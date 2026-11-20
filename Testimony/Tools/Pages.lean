import Testimony.Attr
import Testimony.Logic.Line
import Testimony.Logic.Dispute
import Testimony.Logic.Because
import Testimony.Logic.Dilemma
import Testimony.Logic.Verdict
import Testimony.Logic.Map
import Testimony.Logic.Burden
import Testimony.Logic.Credibility
import Testimony.Logic.Latex
import Testimony.Logic.Markdown
import Testimony.Tools.Docs

/-!
# Testimony.Tools.Pages — harvesting an argument from the environment

An argument module is already a literate document. It opens with a docstring
saying what the dispute is and what it is not, its sections are marked by
`/-! ### … -/` blocks, and every package, line, countermodel and result carries
a docstring written for a reader rather than for a compiler. Until this module
none of it reached a reader who had not opened the file.

`derive_argument_bodies` walks the environment for all of it — every module
docstring of every file an argument is built from, and every documented
declaration in its namespace — orders it by the module and line it is written
on, and renders it twice: once as Markdown for `argdoc`, once as LaTeX for
`argtex`. The harvest is shared because it is the same document; only the
setting differs.

Nothing is curated. The page is every documented declaration in the argument's
namespace, in the order the source declares them, so a declaration that is
added, renamed or deleted moves both renderings on the next run.

## What the renderers read, and what they do not

A declaration is rendered as notation when its type says how: `ArgumentPackage`
as premises above a turnstile, `Line` likewise, `Formula` and
`List (Formula _)` as formulas. A `Source` and an `AtomMeta` are said in words,
as the legend says them. A countermodel is a `Valuation`, a function into
`Prop`, so there is nothing to enumerate at run time; but when its atom type is
an enumeration, the harvest applies it to each claim and reduces the result to
`True` or `False` (`readingTruth`), and the page lists the claims it takes as
false in words. Everything else — a `FulfillmentCriterion`, a cite function, a
dispute — is shown as Lean source, the honest fallback, and so is a valuation
that does not reduce.

Values above `valueWidth` characters are shown by signature alone. That is
aimed at one declaration in particular: `cite` is a total function from every
atom to its citation, and printing it would repeat the legend at ten times the
length.
-/

open Lean Elab Command Testimony

namespace Testimony.Doc

/-- One module's share of an argument, rendered for both media: its prose, and
the declarations behind it.

An argument divided into chapters (`Argument.chapters`) is set from these. The
prose is the module's docstrings, the chapter a reader reads; the notes are its
declarations, each with its docstring and its formula or statement, the
headings that only organise them, and any section opened with `####`, which is
how a module says that a passage is about the machinery and not the argument.
A chapter shows the notes after its prose, under "How this is checked". -/
structure Part where
  /-- The module the items were written in. -/
  module : Name
  /-- What the module's opening heading names, after its namespace: "where
  Trent parts from Paul", for `TestimonyArguments.SolaFide.Gospel —
  where Trent parts from Paul`. Empty if the module has no such heading. -/
  subtitle : String := ""
  /-- The module's prose, as Markdown, without its opening heading. -/
  prose : String := ""
  /-- Its declarations, as Markdown. -/
  notes : String := ""
  /-- The prose, as LaTeX. -/
  proseTex : String := ""
  /-- The declarations, as LaTeX. -/
  notesTex : String := ""
deriving Inhabited

/-- One argument's harvest, rendered for both media.

Every field is computed from one item list — see `render` — so the page and
the PDF cannot come from different readings of the source. -/
structure Body where
  /-- The namespace the items were harvested from. -/
  ns : Name
  /-- The body of the generated Markdown page, below its title. -/
  markdown : String
  /-- The body of the generated LaTeX section, below its heading. -/
  latex : String
  /-- The same items, module by module, for an argument set as chapters. -/
  parts : List Part := []
  /-- The legend alone, as Markdown: the table of numbered claims. -/
  legend : String := ""
  /-- The legend alone, as LaTeX. -/
  legendTex : String := ""
deriving Inhabited

/-- Raise every heading outside a fenced block by `k` levels, never above `##`,
which is the highest a page's own sections go: `#` is its title. A chapter sets
a module's `###` sections as its own `##`. -/
def promoteHeadings (k : Nat) (md : String) : String :=
  let step := fun ((acc : List String), inFence) (line : String) =>
    if (line.trimAscii.toString).startsWith "```" then (acc ++ [line], !inFence)
    else if inFence || !line.startsWith "#" then (acc ++ [line], inFence)
    else
      let hashes := (line.toList.takeWhile (· == '#')).length
      let level := max 2 (hashes - k)
      (acc ++ [String.ofList (List.replicate level '#') ++ (line.drop hashes).toString], inFence)
  let (lines, _) := (md.splitOn "\n").foldl step ([], false)
  "\n".intercalate lines

/-- Whether a module docstring is only a heading: `/-! ### The lines -/`, which
organises the declarations under it and has no prose of its own. -/
def headingOnly (md : String) : Bool :=
  match (md.splitOn "\n").filter (fun l => !(l.trimAscii.toString).isEmpty) with
  | [l] => l.startsWith "#"
  | _ => false

/-- A module docstring's opening heading split off: the text after the
namespace and its dash, and the rest of the docstring. A docstring that does not
open with `# <namespace> — …` is returned whole, with no subtitle. -/
def splitModuleHeading (md : String) : String × String :=
  match md.splitOn "\n" with
  | first :: rest =>
    if first.startsWith "# " && (first.splitOn " — ").length ≥ 2 then
      (" — ".intercalate ((first.splitOn " — ").drop 1), "\n".intercalate rest)
    else ("", md)
  | [] => ("", md)

/-- The renderings of one argument's harvest, whole and module by module.

The elaborated call names the item list once and hands it to both renderers,
which is the point: two lists would be two chances to drift. `mods` gives the
module each item, of `intro` then `items`, was written in. -/
def render [DecidableEq α] (ns : Name) (allAtoms : List α)
    (intro items : List (Logic.Page.Item α)) (mods : List Name := []) : Body :=
  let all := intro ++ items
  let order := Logic.Page.atomOrder allAtoms all
  let cite := Logic.Page.citeOf all
  let n : Logic.Latex.Numbering α :=
    { order := order, cite := cite,
      anchor := if cite.isSome then Logic.Latex.anchorName ns.toString else "" }
  let tagged := mods.zip all
  let modules := (mods.eraseDups)
  let parts := modules.map fun m =>
    let mine := (tagged.filter (·.1 == m)).map (·.2)
    -- A `####` section is about the machinery, and goes behind the chapter.
    let isProse : Logic.Page.Item α → Bool
      | .prose md => !headingOnly md && !md.startsWith "####"
      | _ => false
    let opening := mine.find? isProse
    let (subtitle, _) := match opening with
      | some (.prose md) => splitModuleHeading md
      | _ => ("", "")
    -- The opening heading is the chapter's to set, so it comes off the prose.
    let strip : Logic.Page.Item α → Logic.Page.Item α
      | .prose md => if subtitle.isEmpty then .prose md else .prose (splitModuleHeading md).2
      | i => i
    let prose := match mine.filter isProse with
      | first :: rest => strip first :: rest
      | [] => []
    let notes := mine.filter (!isProse ·)
    { module := m, subtitle := subtitle
    , prose := "\n".intercalate (prose.map (Logic.Markdown.item order cite))
    , notes := "\n".intercalate (notes.map (Logic.Markdown.item order cite))
    -- In print a chapter is a `\subsection*`, so a module's `###` sections are
    -- set one level up, as `\subsubsection*`.
    , proseTex := String.join ((prose.map fun
        | .prose md => .prose (promoteHeadings 1 md)
        | i => i).map (Logic.Latex.item n))
    , notesTex := String.join (notes.map (Logic.Latex.item n)) : Part }
  { ns := ns
  , markdown := Logic.Markdown.body allAtoms intro items
  , latex := Logic.Latex.body ns.toString allAtoms intro items
  , parts := parts
  , legend := match cite with
      | some c => Logic.Markdown.legend c order
      | none => ""
  , legendTex := match cite with
      | some c => Logic.Latex.legend n c
      | none => "" }

variable {α : Type}

/-- How much of a declaration's value a page will show before falling back to
its signature alone. -/
def valueWidth : Nat := 600

/-- How wide a rendered statement is allowed to be: narrow enough that a long
one wraps inside a code block rather than scrolling off it, and inside a LaTeX
`verbatim` rather than off the page. -/
def printWidth : Nat := 78

/-- The width the pretty-printer is given when the wrapping is done afterwards:
wide enough that it never wraps. -/
def unwrappedWidth : Nat := 10000

/-- Soft-wrap a statement at `printWidth`, continuing indented.

Wrapped here rather than by the pretty-printer, because the pretty-printer
wraps the name it printed and how long that name is depends on which namespaces
happen to be open where the harvest runs. What a statement looks like on the
page should not. -/
def wrapStatement (s : String) : String :=
  let indent := "    "
  let step := fun (lines, cur) (w : String) =>
    if cur.isEmpty then (lines, w)
    else if cur.length + 1 + w.length <= printWidth then (lines, cur ++ " " ++ w)
    else (lines ++ [cur], indent ++ w)
  let (lines, last) := ((s.splitOn " ").filter (· ≠ "")).foldl step (([] : List String), "")
  String.intercalate "\n" (lines ++ [last])

/-- Indent a pretty-printed value so it reads as the body of the definition it
is being shown as. -/
def indentLines (s : String) : String :=
  String.intercalate "\n" ((s.splitOn "\n").map fun l => if l.isEmpty then l else "  " ++ l)

/-- The repository path an argument's sources live at, for the "do not edit"
header. A directory argument and a single-file one both answer to it: the
former has the directory, the latter the module of the same name. -/
def sourcePath (ns : Name) : String := ns.toString.replace "." "/"

end Testimony.Doc

namespace Testimony.Doc

open Testimony in
/-- Generates `def <name> : List Body` by walking every argument namespace
under `root` in the environment (every one, when `root` is anonymous) and
rendering what it declares. Each argument's body is a definition of its own,
`<name><Argument>` after the namespace's last component, and the list names
them.

The namespaces are taken from the `@[headline]` tag rather than from a
package's catalogue, for the reason the status table gives: a tool that took its
scope from a hand-written list could not check that the list is complete. A
package `#guard`s the two against each other in both directions, so an argument
missing from its catalogue fails the build rather than the page.

Within a namespace the order is the source's own. Module docstrings carry
positions, so `/-! ### The lines -/` lands between the declaration above it and
the declaration below it, exactly as it does in the file. -/
def deriveArgumentBodies (tableName : Ident) (root : Name) : CommandElabM Unit := do
  let env ← getEnv

  -- Pretty-print an expression as the argument's own file spells it.
  let render (width : Nat) (ns : Name) (e : Expr) : CommandElabM String := do
    let fmt ← liftTermElabM (Lean.PrettyPrinter.ppExpr e)
    pure (stripNamespaces ns (fmt.pretty (width := width)) (← getCurrNamespace))

  -- A statement, on one line from the printer: the wrapping happens once the
  -- keyword and the declaration's own name are in front of it, which is what
  -- decides whether the line fits.
  let statement (ns : Name) (e : Expr) : CommandElabM String :=
    render unwrappedWidth ns e

  -- The namespaces that carry results, in the order the modules declare them.
  let mut nss : Array Name := #[]
  for i in [0 : env.header.moduleNames.size] do
    for d in headlineAttr.ext.getModuleEntries env i do
      unless nss.contains d.getPrefix || !root.isPrefixOf d.getPrefix do
        nss := nss.push d.getPrefix

  -- One pass over the environment, bucketing declarations by their namespace.
  let mut declsOf : Std.HashMap Name (Array Name) := {}
  for (n, _) in env.constants.toList do
    let ns := n.getPrefix
    if nss.contains ns then
      declsOf := declsOf.insert ns ((declsOf.getD ns #[]).push n)

  let mut bodies : Array (Name × TSyntax `term) := #[]
  for ns in nss do
    -- The argument's modules: its own first, then the files it is built from.
    let mut mods : Array (Nat × Name) := #[]
    for i in [0 : env.header.moduleNames.size] do
      let m := env.header.moduleNames[i]!
      if ns.isPrefixOf m then mods := mods.push (i, m)
    let ordered := mods.qsort fun (i, m₁) (j, m₂) =>
      if m₁ == ns then true else if m₂ == ns then false else i < j

    -- Where each module sits in that order, so items sort across files.
    let mut modOrder : Std.HashMap Name Nat := {}
    for ((_, m), k) in ordered.toList.zipIdx do
      modOrder := modOrder.insert m k

    -- The prose: every module docstring, at the line it is written on. The
    -- flag rides along because the legend goes after the leading prose, and
    -- a term is not something to ask that question of afterwards.
    let mut items : Array (Nat × Nat × Bool × TSyntax `term) := #[]
    let moduleAt : Std.HashMap Nat Name :=
      ordered.toList.foldl (fun acc (_, m) => acc.insert (modOrder.getD m 0) m) {}
    for (_, m) in ordered do
      let k := modOrder.getD m 0
      for d in (getModuleDoc? env m).getD #[] do
        let md := d.doc.trimAscii.toString
        unless md.isEmpty do
          items := items.push (k, d.declarationRange.pos.line, true,
            ← `(Logic.Page.Item.prose $(quote md)))

    -- What a verdict links to: the page's `Because` declarations, by the pair
    -- they explain, and each dispute's defeat-table theorem — the one stating
    -- `∀ i j, D.defeats i j ↔ …` — by the dispute it is about.
    let mut becauseLinks : Array (TSyntax `term) := #[]
    let mut tableOf : Std.HashMap Name Name := {}
    let mut supportTableOf : Std.HashMap Name Name := {}
    let mut partTableOf : Std.HashMap Name Name := {}
    for n in (declsOf.getD ns #[]) do
      let some info := env.find? n | continue
      if info.type.getAppFn.constName? == some ``Logic.Because then
        becauseLinks := becauseLinks.push (← `(((Logic.Because.view $(mkIdent n)).holder,
          (Logic.Because.view $(mkIdent n)).rival, $(quote n.getString!))))
      if info matches .thmInfo _ then
        -- Which table a theorem proves, if any: 0 defeats, 1 supports, 2 part-of.
        -- Arities are checked before any argument is read: `getArg!` past the
        -- end panics, and a panic here does not fail the build.
        let d? ← liftTermElabM <| Meta.forallTelescope info.type fun _ body => do
          let isIff := body.isAppOfArity ``Iff 2
          unless isIff || body.isAppOfArity ``Not 1 do return none
          let lhs := body.getArg! 0
          -- `D.defeats i j`: the dispute is the third argument from the end,
          -- whatever implicit and instance arguments come before it.
          let rel (c : Name) := lhs.isAppOf c && lhs.getAppNumArgs ≥ 3
          let kind? : Option Nat :=
            if isIff && rel ``Logic.Dispute.defeats then some 0
            else if rel ``Logic.Dispute.supports then some 1
            else if isIff && rel ``Logic.Dispute.partOf then some 2
            else none
          pure <| kind?.bind fun k =>
            (lhs.getArg! (lhs.getAppNumArgs - 3)).constName?.map (·, k)
        match d? with
        | some (d, 0) => tableOf := tableOf.insert d n
        | some (d, 1) => supportTableOf := supportTableOf.insert d n
        | some (d, _) => partTableOf := partTableOf.insert d n
        | none => pure ()

    -- The dispute a verdict is about, followed through hearings and the
    -- abbreviations that name them, to the one whose table is proved.
    let tableIn (tables : Std.HashMap Name Name) (ty : Expr) : String := Id.run do
      -- The dispute is a verdict's last argument, and a hearing's second from
      -- the end, whatever implicit and instance arguments come before.
      let mut e := ty.getAppArgs.back!
      for _ in [0:8] do
        if e.isAppOf ``Logic.Dispute.restrict then e := e.getArg! (e.getAppNumArgs - 2)
        else match e.constName? with
          | some c =>
            if let some t := tables[c]? then return t.getString!
            match env.find? c |>.bind (·.value?) with
            | some v => e := v
            | none => return ""
          | none => return ""
      return ""
    let tableFor := tableIn tableOf

    -- A reading written as a valuation (`Valuation Claim`), read off one claim at
    -- a time: the definition applied to each of the atom type's constructors,
    -- reduced to `True` or `False`. `none` if the type is not a valuation over
    -- an enumeration, or if any claim does not reduce to one of the two, and the
    -- declaration falls back to being shown as Lean.
    let readingTruth (info : ConstantInfo) : CommandElabM (Option (Array (Name × Bool))) :=
      liftTermElabM do
        unless info.type.getAppFn.constName? == some ``Logic.Valuation do return none
        let some (Expr.const atomTyName _) := info.type.getAppArgs[0]? | return none
        let some (ConstantInfo.inductInfo ind) := env.find? atomTyName | return none
        unless info.hasValue do return none
        let mut out : Array (Name × Bool) := #[]
        for ctor in ind.ctors do
          let some (ConstantInfo.ctorInfo ci) := env.find? ctor | return none
          unless ci.numFields == 0 && ci.numParams == 0 do return none
          let e ← Meta.whnfD (mkApp (mkConst info.name (info.levelParams.map mkLevelParam))
            (mkConst ctor))
          if e.isConstOf ``True then out := out.push (ctor, true)
          else if e.isConstOf ``False then out := out.push (ctor, false)
          else return none
        return some out

    -- The declarations: each rendered by what its type says it is.
    let mut atomTy : Option Name := none
    for n in (declsOf.getD ns #[]) do
      let some info := env.find? n | continue
      let some rawDoc ← findDocString? env n | continue
      let doc := rawDoc.trimAscii.toString
      match info with
      | .inductInfo _ | .ctorInfo _ | .recInfo _ | .quotInfo _ => continue
      | _ =>
        let some modIdx := env.getModuleIdxFor? n | continue
        let some k := modOrder[env.header.moduleNames[modIdx.toNat]!]? | continue
        -- A declaration with no place in the source was generated by a command
        -- (`prepare_clauses`'s clauses), machinery for the kernel, not
        -- something written for a reader.
        let some ranges ← findDeclarationRanges? n | continue
        let line := ranges.range.pos.line
        let dname := n.getString!
        let headOf (e : Expr) : Option Name :=
          match e.getAppFn with
          | .const c _ => some c
          | _ => none
        let headIs (c : Name) : Bool := headOf info.type == some c
        let term ←
          if info matches .thmInfo _ then do
            let stmt ← statement ns info.type
            let axioms ← collectAxioms n
            let note :=
              if axioms.isEmpty then "-- axioms: none beyond Lean's own"
              else "-- axioms: " ++ String.intercalate ", " (axioms.toList.map toString)
            let shown := wrapStatement ("theorem " ++ dname ++ " : " ++ stmt)
            if headIs ``Logic.OpponentsBurden then
              `(Logic.Page.Item.burden $(quote dname) $(quote doc)
                  $(quote (shown ++ "\n" ++ note)) (Logic.OpponentsBurden.view $(mkIdent n)))
            else
              `(Logic.Page.Item.result $(quote dname) $(quote doc)
                  $(quote (shown ++ "\n" ++ note))
                  $(quote (proposedAttr.hasTag env n)))
          else if headIs ``Logic.ArgumentPackage then do
            if atomTy.isNone then
              atomTy := match info.type.getAppArgs[0]? with
                | some (Expr.const c _) => some c
                | _ => none
            `(Logic.Page.Item.package $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``Logic.Because then
            `(Logic.Page.Item.because $(quote dname) $(quote doc)
                (Logic.Because.view $(mkIdent n)))
          else if headIs ``Logic.Dilemma then
            `(Logic.Page.Item.dilemma $(quote dname) $(quote doc)
                (Logic.Dilemma.view $(mkIdent n)))
          else if headIs ``Logic.Verdict then
            `(Logic.Page.Item.verdict $(quote dname) $(quote doc)
                (Logic.Verdict.view $(mkIdent n)) [$(becauseLinks),*]
                $(quote (tableFor info.type)))
          else if headIs ``Logic.ArgumentMap then
            `(Logic.Page.Item.graph $(quote dname) $(quote doc)
                (Logic.ArgumentMap.view $(mkIdent n)) $(quote (tableFor info.type))
                $(quote (tableIn supportTableOf info.type))
                $(quote (tableIn partTableOf info.type)))
          else if headIs ``Logic.Assessment then
            `(Logic.Page.Item.assessed $(quote dname) $(quote doc)
                (Logic.Assessment.view $(mkIdent n)))
          else if headIs ``Logic.RatedStep then
            `(Logic.Page.Item.rated $(quote dname) $(quote doc)
                (Logic.RatedStep.view $(mkIdent n)))
          else if headIs ``Logic.Line then
            `(Logic.Page.Item.line $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``Logic.Formula then
            `(Logic.Page.Item.formula $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``List &&
              (info.type.getAppArgs[0]?.any fun a => headOf a == some ``Logic.Formula) then
            `(Logic.Page.Item.formulas $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``Testimony.Source then
            `(Logic.Page.Item.source $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``Logic.AtomMeta then
            `(Logic.Page.Item.claim $(quote dname) $(quote doc) $(mkIdent n))
          else if let some truth ← readingTruth info then
            let pairs ← truth.mapM fun (c, b) => `(($(mkIdent c), $(quote b)))
            `(Logic.Page.Item.reading $(quote dname) $(quote doc) [$(pairs),*])
          else do
            let sig ← statement ns info.type
            let value ← match info.value? with
              | some v => do
                  let s ← render printWidth ns v
                  pure (if s.length > valueWidth then none else some s)
              | none => pure none
            let head := wrapStatement ("def " ++ dname ++ " : " ++ sig)
            let src := match value with
              | some v => head ++ " :=\n" ++ indentLines v
              | none => head
            `(Logic.Page.Item.other $(quote dname) $(quote doc) $(quote src))
        items := items.push (k, line, false, term)

    let sorted := (items.qsort fun (k₁, l₁, _) (k₂, l₂, _) =>
      if k₁ == k₂ then l₁ < l₂ else k₁ < k₂).toList
    -- The leading prose is the argument's own introduction; the legend goes
    -- under it, before the first thing that mentions an atom.
    let intro := (sorted.takeWhile (·.2.2.1)).map (·.2.2.2) |>.toArray
    let rest := (sorted.dropWhile (·.2.2.1)).map (·.2.2.2) |>.toArray
    -- The module of each item, of `intro` and then `rest`, for the chapters.
    let modsOf := (sorted.takeWhile (·.2.2.1) ++ sorted.dropWhile (·.2.2.1)).map
      fun (k, _) => moduleAt.getD k .anonymous
    let modTerms : Array (TSyntax `term) := modsOf.toArray.map fun m => quote m
    -- The atom type's constructors, in the order it declares them: the order
    -- the legend reads in, and the one `Atoms.lean` groups its prose by.
    let ctors : Array (TSyntax `term) :=
      match atomTy.bind (fun c => env.find? c) with
      | some (.inductInfo val) => val.ctors.toArray.map fun c => mkIdent c
      | _ => #[]
    -- The items after the introduction, in chunks of a fixed size, each its own
    -- definition, joined with `++`. Written as one list literal, an argument's
    -- items nest as deep as there are items, and the code generator's recursion
    -- depth runs across all of them: sola fide, at some four hundred items, went
    -- past it. Chunked, the depth is a chunk's, plus one per chunk. Chunking
    -- needs the atom type, to type a chunk that holds only prose.
    let restTerm ← match atomTy with
      | some ty =>
        let mut chunks : Array Ident := #[]
        for (chunk, i) in (rest.toList.toChunks 64).zipIdx do
          let name := mkIdent ((tableName.getId.appendAfter ns.getString!).appendAfter
            ("Items" ++ toString i))
          let chunkItems := chunk.toArray
          elabCommand (← `(command|
            /-- Part of one argument's page body, generated from the Lean source by
            `derive_argument_bodies`. -/
            def $name : List (Logic.Page.Item $(mkIdent ty)) := [$(chunkItems),*]))
          chunks := chunks.push name
        chunks.foldlM (init := ← `(term| ([] : List (Logic.Page.Item $(mkIdent ty)))))
          fun acc c => `(term| $acc ++ $c)
      | none => `(term| [$(rest),*])
    bodies := bodies.push
      (ns, ← `(term| render $(quote ns) [$(ctors),*] [$(intro),*] $restTerm
        [$(modTerms),*]))

  -- One definition per argument, then the list of them. Written as one list
  -- literal, every argument's body was a single term, and the code generator's
  -- recursion depth ran across all of it: an argument that grew could push the
  -- whole past the limit. Split, each argument's body compiles on its own.
  let mut parts : Array Ident := #[]
  for (ns, body) in bodies do
    let part := mkIdent (tableName.getId.appendAfter ns.getString!)
    elabCommand (← `(command|
      /-- One argument's page body, generated from the Lean source by
      `derive_argument_bodies`. -/
      def $part : Body := $body))
    parts := parts.push part
  elabCommand (← `(command|
    /-- Every argument's page body, generated from the Lean source by
    `derive_argument_bodies`. -/
    def $tableName : List Body := [$parts,*]))

/-- `derive_argument_bodies t` generates `def t : List Body`, every argument's
page body, each defined on its own; see `deriveArgumentBodies`. `derive_argument_bodies t under N`
harvests only the arguments declared under the namespace `N`, which is how a
package harvests its own arguments and not those of another it imports. -/
syntax (name := deriveArgumentBodiesCmd) "derive_argument_bodies " ident (" under " ident)? :
  command

elab_rules : command
  | `(derive_argument_bodies $t $[under $root]?) =>
    deriveArgumentBodies t ((root.map (·.getId)).getD .anonymous)

/-! ### Documents, for the library and for packages built on it -/

/-- Each catalogued argument with its harvested body, in the catalogue's order. -/
def sectionsOf (catalogue : List Argument) (harvest : List Body) : List (Argument × Body) :=
  catalogue.filterMap fun a => (harvest.find? (·.ns == a.ns)).map (a, ·)

/-- An argument set as chapters, in print: each chapter a `\subsection*` in the
table of contents, its modules' prose, the legend where the outline puts it,
and the declarations behind the chapter under "How this is checked", as the
site sets them. -/
def latexChapters (a : Argument) (b : Body) : String :=
  String.join (a.chapters.map fun c =>
    let parts := c.modules.filterMap fun m => b.parts.find? (·.module == m)
    let heading := Logic.Latex.escape c.title
    let sub (t : String) := "\\subsubsection*{" ++ Logic.Latex.escape t ++ "}\n"
    "\\subsection*{" ++ heading ++ "}\n\\addcontentsline{toc}{subsection}{" ++ heading ++
      "}\n" ++
    String.join (parts.zipIdx.map fun (p, j) =>
      (if j == 0 || p.subtitle.isEmpty then ""
       else sub (match p.subtitle.toList with
         | ch :: cs => String.ofList (ch.toUpper :: cs)
         | [] => "")) ++ p.proseTex) ++
    (if c.legend && !b.legendTex.isEmpty then sub "The claims, numbered" ++ b.legendTex
     else "") ++
    (let notes := String.join (parts.map (·.notesTex))
     if (notes.trimAscii.toString).isEmpty then "" else sub "How this is checked" ++ notes))

/-- An argument's abstract, set where a document puts it: under the title of
the argument's own document, in the article class's own `abstract`; under its
heading in a document of several, as a quotation headed "Abstract". Nothing
where it has none. -/
def latexAbstract (a : Argument) (alone : Bool) : String :=
  if a.abstract.trimAscii.toString.isEmpty then ""
  else if alone then
    "\\begin{abstract}\n" ++ Logic.Latex.prose a.abstract ++ "\\end{abstract}\n\n"
  else
    "\\begin{quote}\\small\\noindent\\textbf{Abstract.}\\enspace " ++
      Logic.Latex.prose a.abstract ++ "\\end{quote}\n\n"

-- An argument printed alone opens with the article's own abstract; in a book,
-- the abstract sits under the argument's heading; with none, nothing is set.
#guard latexAbstract { ns := `X, slug := "x", title := "X", abstract := "It *holds*." } true ==
  "\\begin{abstract}\nIt \\emph{holds}.\n\n\\end{abstract}\n\n"
#guard (latexAbstract { ns := `X, slug := "x", title := "X", abstract := "A." } false).startsWith
  "\\begin{quote}\\small\\noindent\\textbf{Abstract.}"
#guard latexAbstract { ns := `X, slug := "x", title := "X" } true == ""

/-- **A printable document**: a title, the abstract of the argument it holds if
it holds one, a standing note, and a section for each argument — its heading
the catalogue's title, its abstract under it, its body the harvest's LaTeX —
and last, how the edition was made (`Logic.Latex.reproduction`). Every package
built on the library sets its documents with it, so they are set alike. `made`
says what makes this document: the package, its generator and the file.

With `credits`, the document names the people behind its arguments, as
`Logic.Latex.credits` works them out when it is typeset: one argument's under
the title of a document that holds only it, and in a document of several,
everyone's under the title and each argument's under its heading.

`works` is the package's bibliography. Every work in it that the document cites
and whose licence asks for credit is credited in the last section
(`Logic.Latex.licenceCredits`), so a document that cites the SBL Greek New
Testament says so, and one that does not, does not. -/
def latexDocument (title note : String) (sections : List (Argument × Body))
    (made : Logic.Latex.Reproduction) (credits : Bool := false)
    (works : List Bib.BibEntry := []) : String :=
  let alone := sections.length == 1
  let key := match sections with
    | [(a, _)] => a.ns.toString
    | _ => "all"
  let body := String.join (sections.map fun (a, b) =>
    Logic.Latex.sectionHeading a.title ++
      (if credits && !alone then "\\creditline{" ++ a.ns.toString ++ "}\n\n" else "") ++
      (if alone then "" else latexAbstract a false) ++
      (if a.chapters.isEmpty then b.latex else latexChapters a b))
  let licensed := (Logic.Latex.citedIn body works).filter (·.core.licence.isSome)
  (if credits then
    Logic.Latex.preamble title ("\\credit{" ++ key ++ "}")
   else Logic.Latex.preamble title) ++
  (match sections with
   | [(a, _)] => latexAbstract a true
   | _ => "") ++
  note ++ Logic.Latex.contents ++ body ++
  Logic.Latex.postamble (Logic.Latex.reproduction { made with credits, licensed })

-- A work is credited where it is cited, with or without a pinpoint, and only there;
-- its credit names its licence, escaped for LaTeX.
#guard (Logic.Latex.citedIn "x \\cite[p. 3]{holmes-sblgnt-2010} y"
  [Bib.sblgnt, Bib.oshbDataset]).map (·.key) == ["holmes-sblgnt-2010"]
#guard (Logic.Latex.citedIn "x \\cite{holmes-sblgnt-2010x} y" [Bib.sblgnt]).isEmpty
#guard ((Logic.Latex.licenceCredits [Bib.maculaGreek]).splitOn
  "copyright 2022–2024 by Biblica, Inc. The library keeps only the morphology and syntactic \
  roles of its SBLGNT word table, and drops the rest. Licensed under CC BY 4.0, \
  \\url{https://creativecommons.org/licenses/by/4.0/}.").length == 2

/-- A generated file's committed contents, or nothing if there is none, so that
a check reports a missing file as stale. -/
def readGenerated (p : System.FilePath) : IO String := do
  if ← p.pathExists then IO.FS.readFile p else pure ""

/-- **Markdown quotation marks that reached the LaTeX.** The lines of a
generated document, outside verbatim blocks, that begin with `>`: a docstring's
block quote that the renderer set as running text instead of as a quotation,
which the PDF shows as stray marks mid-sentence. A generator refuses to write or
pass a document that has any. -/
def strayQuoteLines (tex : String) : List String :=
  let step := fun (acc : Bool × Array String) (line : String) =>
    let (inVerbatim, found) := acc
    let t := line.trimAscii.toString
    if t.startsWith "{\\small\\begin{verbatim}" || t.startsWith "\\begin{verbatim}" then
      (true, found)
    else if t.startsWith "\\end{verbatim}" then (false, found)
    else if !inVerbatim && t.startsWith ">" then (inVerbatim, found.push line)
    else (inVerbatim, found)
  ((tex.splitOn "\n").foldl step (false, #[])).2.toList

/-- Report a document's stray quotation lines, if it has any, and say whether it
is clean. -/
def reportStrayQuotes (tool : String) (path : System.FilePath) (tex : String) : IO Bool := do
  let stray := strayQuoteLines tex
  if stray.isEmpty then return true
  IO.eprintln (s!"{tool}: {path} has {stray.length} line(s) beginning with `>`, " ++
    "a Markdown block quote not set as a quotation:")
  for l in stray.take 5 do IO.eprintln s!"  {l}"
  return false

#guard strayQuoteLines "a\n> quoted\n\\begin{verbatim}\n> prompt\n\\end{verbatim}\nb" ==
  ["> quoted"]

/-- **Write generated files, or check that they are current**, as every
generator here does: with `check`, report each file whose committed contents
differ and fail; otherwise write them all. Returns the exit code. -/
def writeOrCheck (tool : String) (files : List (System.FilePath × String)) (check : Bool) :
    IO UInt32 := do
  if check then
    let mut stale := #[]
    for (path, want) in files do
      if (← readGenerated path) != want then stale := stale.push path
    if stale.isEmpty then
      IO.println s!"{tool}: generated files are up to date"
      return 0
    for path in stale do
      IO.eprintln s!"{tool}: {path} is stale — run `lake exe {tool}`"
    return 1
  for (path, contents) in files do
    if let some dir := path.parent then IO.FS.createDirAll dir
    IO.FS.writeFile path contents
    IO.println s!"{tool}: wrote {path}"
  return 0

end Testimony.Doc
