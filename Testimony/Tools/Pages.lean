import Testimony
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
`List (Formula _)` as formulas. Everything else — a countermodel, which is a
function, or a `FulfillmentCriterion` — is shown as Lean source, which is the
honest fallback: a countermodel *is* the rival's reading, and `Valuation` being
`α → Prop` there is nothing to enumerate.

Values above `valueWidth` characters are shown by signature alone. That is
aimed at one declaration in particular: `cite` is a total function from every
atom to its citation, and printing it would repeat the legend at ten times the
length.
-/

open Lean Elab Command Testimony

namespace Testimony.Doc

/-- One argument's harvest, rendered for both media.

Both fields are computed from one item list — see `render` — so the page and
the PDF cannot come from different readings of the source. -/
structure Body where
  /-- The namespace the items were harvested from. -/
  ns : Name
  /-- The body of the generated Markdown page, below its title. -/
  markdown : String
  /-- The body of the generated LaTeX section, below its heading. -/
  latex : String
deriving Inhabited

/-- Both renderings of one argument's harvest.

The elaborated call names the item list once and hands it to both renderers,
which is the point: two lists would be two chances to drift. -/
def render [DecidableEq α] (ns : Name) (allAtoms : List α)
    (intro items : List (Logic.Page.Item α)) : Body :=
  { ns := ns
  , markdown := Logic.Markdown.body allAtoms intro items
  , latex := Logic.Latex.body allAtoms intro items }

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
/-- Generates `def <name> : List Body` by walking every argument namespace in
the environment and rendering what it declares.

The namespaces are taken from the `@[headline]` tag rather than from
`arguments`, for the reason `statusgen` gives: a tool that took its scope from
a hand-written list could not check that the list is complete. The `#guard`
below compares the two in both directions, so an argument missing from
`arguments` fails the build rather than the page.

Within a namespace the order is the source's own. Module docstrings carry
positions, so `/-! ### The lines -/` lands between the declaration above it and
the declaration below it, exactly as it does in the file. -/
elab "derive_argument_bodies " tableName:ident : command => do
  let env ← getEnv

  -- Pretty-print an expression as the argument's own file spells it.
  let render (width : Nat) (ns : Name) (e : Expr) : CommandElabM String := do
    let fmt ← liftTermElabM (Lean.PrettyPrinter.ppExpr e)
    pure (stripNamespaces ns (fmt.pretty (width := width)))

  -- A statement, on one line from the printer: the wrapping happens once the
  -- keyword and the declaration's own name are in front of it, which is what
  -- decides whether the line fits.
  let statement (ns : Name) (e : Expr) : CommandElabM String :=
    render unwrappedWidth ns e

  -- The namespaces that carry results, in the order the modules declare them.
  let mut nss : Array Name := #[]
  for i in [0 : env.header.moduleNames.size] do
    for d in headlineAttr.ext.getModuleEntries env i do
      unless nss.contains d.getPrefix do nss := nss.push d.getPrefix

  -- One pass over the environment, bucketing declarations by their namespace.
  let mut declsOf : Std.HashMap Name (Array Name) := {}
  for (n, _) in env.constants.toList do
    let ns := n.getPrefix
    if nss.contains ns then
      declsOf := declsOf.insert ns ((declsOf.getD ns #[]).push n)

  let mut bodies : Array (TSyntax `term) := #[]
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
    for n in (declsOf.getD ns #[]) do
      let some info := env.find? n | continue
      if info.type.getAppFn.constName? == some ``Logic.Because then
        becauseLinks := becauseLinks.push (← `(((Logic.Because.view $(mkIdent n)).holder,
          (Logic.Because.view $(mkIdent n)).rival, $(quote n.getString!))))
      if info matches .thmInfo _ then
        let d? ← liftTermElabM <| Meta.forallTelescope info.type fun _ body => do
          let lhs := body.getArg! 0
          if body.isAppOfArity ``Iff 2 && lhs.isAppOfArity ``Logic.Dispute.defeats 5 then
            pure (lhs.getArg! 2).constName?
          else pure none
        if let some d := d? then tableOf := tableOf.insert d n

    -- The dispute a verdict is about, followed through hearings and the
    -- abbreviations that name them, to the one whose table is proved.
    let tableFor (ty : Expr) : String := Id.run do
      let mut e := ty.getArg! 3
      for _ in [0:8] do
        if e.isAppOf ``Logic.Dispute.restrict then e := e.getArg! 2
        else match e.constName? with
          | some c =>
            if let some t := tableOf[c]? then return t.getString!
            match env.find? c |>.bind (·.value?) with
            | some v => e := v
            | none => return ""
          | none => return ""
      return ""

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
        let line := (← findDeclarationRanges? n).map (·.range.pos.line) |>.getD 0
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
          else if headIs ``Logic.Verdict then
            `(Logic.Page.Item.verdict $(quote dname) $(quote doc)
                (Logic.Verdict.view $(mkIdent n)) [$(becauseLinks),*]
                $(quote (tableFor info.type)))
          else if headIs ``Logic.Line then
            `(Logic.Page.Item.line $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``Logic.Formula then
            `(Logic.Page.Item.formula $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``List &&
              (info.type.getAppArgs[0]?.any fun a => headOf a == some ``Logic.Formula) then
            `(Logic.Page.Item.formulas $(quote dname) $(quote doc) $(mkIdent n))
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
    -- The atom type's constructors, in the order it declares them: the order
    -- the legend reads in, and the one `Atoms.lean` groups its prose by.
    let ctors : Array (TSyntax `term) :=
      match atomTy.bind (fun c => env.find? c) with
      | some (.inductInfo val) => val.ctors.toArray.map fun c => mkIdent c
      | _ => #[]
    bodies := bodies.push
      (← `(term| render $(quote ns) [$(ctors),*] [$(intro),*] [$(rest),*]))

  elabCommand (← `(command|
    /-- Every argument's page body, generated from the Lean source by
    `derive_argument_bodies`. -/
    def $tableName : List Body := [$bodies,*]))

derive_argument_bodies bodies

#guard bodies.all fun b => arguments.any fun a => a.ns == b.ns
#guard arguments.all fun a => bodies.any fun b => b.ns == a.ns

/-- The harvest for one argument. -/
def bodyOf (ns : Name) : Option Body := bodies.find? (·.ns == ns)

end Testimony.Doc
