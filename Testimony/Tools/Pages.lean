import Testimony.Attr
import Testimony.Logic.Line
import Testimony.Logic.Dispute
import Testimony.Logic.Because
import Testimony.Logic.Dilemma
import Testimony.Logic.Verdict
import Testimony.Logic.Map
import Testimony.Logic.Burden
import Testimony.Logic.Bundle
import Testimony.Logic.Credibility
import Testimony.Logic.Latex
import Testimony.Logic.Markdown
import Testimony.Logic.Symbols
import Testimony.Corpus.Greek
import Testimony.Logic.Contest
import Testimony.Semantics.Grammar
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
false in words. A citation function, `Claim → AtomMeta`, is said in words
too: the claims on the page it cites otherwise than the legend, each with its
citation, so a variant `cite` written for one hearing shows what it changes
rather than its signature. So is every other kind of definition an argument
declares: a map from parties to positions, a dispute and a hearing, a register,
a refutation, Greek words, a passage, a pinpoint, a link between two texts, a
reading of a passage, a reading of a rival's claim, a rule over true and false,
a contested claim, and a helper, which its docstring says.

A reader is not shown Lean. A definition the harvest has no rendering in words
for stops the build, named, until it has one.
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
    -- A `####` section is about the machinery, and goes behind the chapter. A
    -- truth table is read with the prose that names its rows, so it stays in it.
    let isProse : Logic.Page.Item α → Bool
      | .prose md => !headingOnly md && !md.startsWith "####"
      | .table .. => true
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

/-- A contested claim as a page sets it: the names of the position that holds
it and the position that denies it, and the claim. -/
def contestedView [Logic.HasPostulates α] {ι : Type} {D : Logic.Dispute α ι} {φ : Logic.Formula α}
    (c : Logic.Contested D φ) : String × String × Logic.Formula α :=
  ((D.node c.holder).name, (D.node c.denier).name, φ)

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

/-- An identifier set in mathematics: the last component of its name, in sans
serif, its underscores escaped. -/
def mathIdent (n : Name) : String :=
  let s := match n with
    | .str _ s => s
    | _ => n.toString
  "\\mathsf{" ++ s.replace "_" "\\_" ++ "}"

/-- A bound variable set in mathematics, in italics. -/
def mathVar (n : Name) : String :=
  "\\mathit{" ++ (n.eraseMacroScopes.toString).replace "_" "\\_" ++ "}"

section Sym
open Meta

/-- The syntax of a `Sym` made of pieces. -/
def symSeq (xs : Array (TSyntax `term)) : MetaM (TSyntax `term) :=
  `(Logic.Page.Sym.seq [$(xs),*])

/-- The syntax of a `Sym` that is mathematics as LaTeX writes it. -/
def symTex (t : String) : MetaM (TSyntax `term) :=
  `(Logic.Page.Sym.tex $(quote t))

/-- Whether an expression is a connective, which a part of a larger statement
is set in parentheses for. -/
def isCompound (e : Expr) : Bool :=
  e.isAppOfArity ``Iff 2 || e.isAppOfArity ``And 2 || e.isAppOfArity ``Or 2 ||
    (e.isForall && !e.bindingBody!.hasLooseBVars)

/-- The elements of a list written out, `[a, b]`, or `none` if it is not one. -/
partial def listElems (e : Expr) : Option (List Expr) :=
  if e.isAppOfArity ``List.nil 1 then some []
  else if e.isAppOfArity ``List.cons 3 then
    (listElems (e.getArg! 2)).map (e.getArg! 1 :: ·)
  else none

/-- **A statement in logic notation**, as `Sym` syntax to elaborate: the
statement's connectives as logic writes them (∀, →, ↔, ∧, ∨, ¬, =, ∈), the
library's own relations as argumentation theory writes them (Γ ⊨ φ for
entailment, a ⇝ b for defeat, Pref and Gr for the preferred and grounded
semantics), each claim of `atomTy` as its numbered variable, and each closed
formula as a derivation sets it. Anything else is a function applied to its
arguments, under its own name. -/
partial def symOf (atomTy : Option Name) (e : Expr) : MetaM (TSyntax `term) := do
  let e := (← instantiateMVars e).consumeMData
  let go := symOf atomTy
  let paren (x : Expr) : MetaM (TSyntax `term) := do
    if isCompound x then symSeq #[← symTex "(", ← go x, ← symTex ")"] else go x
  let bin (a : Expr) (op : String) (b : Expr) : MetaM (TSyntax `term) := do
    symSeq #[← paren a, ← symTex (" " ++ op ++ " "), ← paren b]
  let call (f : String) (args : Array Expr) : MetaM (TSyntax `term) := do
    let mut parts : Array (TSyntax `term) := #[← symTex (f ++ "(")]
    for (a, i) in args.toList.zipIdx do
      if i > 0 then parts := parts.push (← symTex ",\\allowbreak ")
      parts := parts.push (← go a)
    symSeq (parts.push (← symTex ")"))
  -- A closed formula over the claims is set as the derivations set it.
  if !e.hasFVar && !e.hasLooseBVars then
    let ty ← try whnfR (← inferType e) catch _ => pure (mkConst ``Unit)
    if ty.isAppOf ``FFL.Propositional.Formula then
      let stx ← withOptions (fun o => o.setBool `pp.fullNames true
          |>.setBool `pp.notation false |>.setBool `pp.coercions false) do
        PrettyPrinter.delab e
      return ← `(Logic.Page.Sym.formula $(⟨stx.raw⟩))
  match e with
  | .fvar id => symTex (mathVar (← id.getUserName))
  | .lit (.natVal k) => symTex (toString k)
  | .lit (.strVal t) => symTex ("\\text{“" ++ Logic.Latex.escape t ++ "”}")
  | .lam .. =>
    lambdaTelescope e fun xs body => do
      let names ← xs.mapM fun x => do pure (mathVar (← x.fvarId!.getUserName))
      symSeq #[← symTex ("(" ++ ", ".intercalate names.toList ++ " \\mapsto "), ← go body,
        ← symTex ")"]
  | .forallE .. =>
    if !e.bindingBody!.hasLooseBVars && (← isProp e.bindingDomain!) then
      bin e.bindingDomain! "\\rightarrow" e.bindingBody!
    else
      forallTelescope e fun xs body => do
        let mut parts : Array (TSyntax `term) := #[]
        let mut groups : Array (Expr × Array Name) := #[]
        for x in xs do
          let ty ← inferType x
          let nm ← x.fvarId!.getUserName
          if (← isClass? ty).isSome then continue
          match groups.back? with
          | some (t, ns) =>
            if t == ty then groups := groups.pop.push (t, ns.push nm)
            else groups := groups.push (ty, #[nm])
          | none => groups := groups.push (ty, #[nm])
        for (ty, ns) in groups do
          parts := parts.push (← symTex ("\\forall " ++
            ", ".intercalate (ns.toList.map mathVar) ++ " \\in "))
          parts := parts.push (← go ty)
          parts := parts.push (← symTex ".\\ ")
        symSeq (parts.push (← go body))
  | .const c _ =>
    if c == ``True then symTex "\\top"
    else if c == ``False then symTex "\\bot"
    else if c == ``Bool.true then symTex "\\mathsf{true}"
    else if c == ``Bool.false then symTex "\\mathsf{false}"
    else
      let ty ← inferType e
      if atomTy.isSome && ty.constName? == atomTy then `(Logic.Page.Sym.atom $(mkIdent c))
      else symTex (mathIdent c)
  | .app .. =>
    let f := e.getAppFn
    let args := e.getAppArgs
    let n := args.size
    let some c := f.constName? | do
      -- A bound variable applied: a function of the statement's own.
      call (← symTex' f) args
    -- A list written out is set as the set of its elements, which is what the
    -- statements here use one for: `(i, j) ∈ [...]`, the parties of a hearing.
    if let some xs := listElems e then
      if xs.isEmpty then return ← symTex "\\varnothing"
      let mut parts : Array (TSyntax `term) := #[← symTex "\\{"]
      for (x, i) in xs.zipIdx do
        if i > 0 then parts := parts.push (← symTex ",\\allowbreak ")
        parts := parts.push (← go x)
      return ← symSeq (parts.push (← symTex "\\}"))
    match c, n with
    | ``Iff, 2 => bin args[0]! "\\leftrightarrow" args[1]!
    | ``And, 2 => bin args[0]! "\\wedge" args[1]!
    | ``Or, 2 => bin args[0]! "\\vee" args[1]!
    | ``Not, 1 => symSeq #[← symTex "\\neg ", ← paren args[0]!]
    | ``Eq, 3 => bin args[1]! "=" args[2]!
    | ``Ne, 3 => bin args[1]! "\\neq" args[2]!
    | ``LT.lt, 4 => bin args[2]! "<" args[3]!
    | ``LE.le, 4 => bin args[2]! "\\leq" args[3]!
    | ``Membership.mem, 5 => bin args[4]! "\\in" args[3]!
    | ``Prod.mk, 4 => symSeq #[← symTex "(", ← go args[2]!, ← symTex ", ", ← go args[3]!,
        ← symTex ")"]
    | ``HAppend.hAppend, 6 => bin args[4]! "\\cup" args[5]!
    | ``OfNat.ofNat, 3 => go args[1]!
    | ``Subtype.val, 3 => go args[2]!
    | ``Subtype.mk, 4 => go args[2]!
    | ``EmptyCollection.emptyCollection, 2 => symTex "\\varnothing"
    | ``Singleton.singleton, 4 => symSeq #[← symTex "\\{", ← go args[3]!, ← symTex "\\}"]
    | ``Insert.insert, 5 =>
      -- `{a, b, c}`: the elements inserted, then the last as a singleton.
      let rec elems (x : Expr) (fuel : Nat) : List Expr :=
        match fuel with
        | 0 => [x]
        | k + 1 =>
          if x.isAppOfArity ``Insert.insert 5 then x.getArg! 3 :: elems (x.getArg! 4) k
          else if x.isAppOfArity ``Singleton.singleton 4 then [x.getArg! 3]
          else [x]
      let xs := elems e 64
      let mut parts : Array (TSyntax `term) := #[← symTex "\\{"]
      for (x, i) in xs.zipIdx do
        if i > 0 then parts := parts.push (← symTex ",\\allowbreak ")
        parts := parts.push (← go x)
      symSeq (parts.push (← symTex "\\}"))
    | ``Subtype, 2 =>
      let p := args[1]!
      if p.isLambda then
        lambdaTelescope p fun xs body => do
          let nm ← xs[0]!.fvarId!.getUserName
          symSeq #[← symTex ("\\{" ++ mathVar nm ++ " \\in "), ← go args[0]!,
            ← symTex " \\mid ", ← go body, ← symTex "\\}"]
      else call "\\mathsf{Subtype}" #[args[0]!, p]
    | ``Logic.ArgumentPackage.strength, _ => call "\\mathrm{strength}" #[args[n - 1]!]
    | ``Logic.Establishes, _ =>
      let p := args[n - 1]!
      symSeq #[← symTex "\\Gamma_{", ← go p, ← symTex "} \\models \\varphi_{", ← go p,
        ← symTex "}"]
    | ``Logic.Entails, _ => bin args[n - 2]! "\\models" args[n - 1]!
    | ``Logic.Satisfiable, _ =>
      symSeq #[← symTex "\\exists v.\\ v \\models ", ← paren args[n - 1]!]
    | ``Logic.Independent, _ =>
      symSeq #[← paren args[n - 2]!, ← symTex " \\not\\models ", ← paren args[n - 1]!,
        ← symTex " \\wedge ", ← paren args[n - 2]!, ← symTex " \\not\\models \\neg ",
        ← paren args[n - 1]!]
    | ``Logic.Defeats, _ => bin args[n - 2]! "\\rightsquigarrow" args[n - 1]!
    | ``Logic.Dispute.defeats, _ => bin args[n - 2]! "\\rightsquigarrow" args[n - 1]!
    | ``Logic.Dispute.supports, _ => bin args[n - 2]! "\\Rightarrow" args[n - 1]!
    | ``Logic.Dispute.partOf, _ => bin args[n - 2]! "\\sqsubseteq" args[n - 1]!
    | ``Logic.Grants, _ =>
      symSeq #[← symTex "\\exists v.\\ v \\models \\Gamma_{", ← go args[n - 2]!,
        ← symTex "} \\cup \\{", ← go args[n - 1]!, ← symTex "\\}"]
    | ``Logic.Dispute.StandTogether, _ =>
      symSeq #[← symTex "\\exists v.\\ v \\models \\bigcup_{i \\in ", ← go args[n - 1]!,
        ← symTex "} (\\Gamma_{i} \\cup \\{\\varphi_{i}\\})"]
    | ``Logic.Dispute.node, _ => go args[n - 1]!
    | ``Logic.ArgumentPackage.premises, _ =>
      symSeq #[← symTex "\\Gamma_{", ← go args[n - 1]!, ← symTex "}"]
    | ``Logic.ArgumentPackage.held, _ =>
      symSeq #[← symTex "\\Gamma_{", ← go args[n - 1]!, ← symTex "}"]
    | ``Logic.ArgumentPackage.conclusion, _ =>
      symSeq #[← symTex "\\varphi_{", ← go args[n - 1]!, ← symTex "}"]
    | ``Logic.Framework.CredulouslyAccepted, _ =>
      symSeq #[← go args[n - 1]!, ← symTex " \\in \\bigcup \\mathrm{Pref}(", ← go args[n - 2]!,
        ← symTex ")"]
    | ``Logic.Framework.SkepticallyAccepted, _ =>
      symSeq #[← go args[n - 1]!, ← symTex " \\in \\bigcap \\mathrm{Pref}(", ← go args[n - 2]!,
        ← symTex ")"]
    | ``Logic.Framework.grounded, _ => call "\\mathrm{Gr}" #[args[n - 1]!]
    | ``Logic.Framework.Admissible, _ => call "\\mathrm{Adm}" #[args[n - 2]!, args[n - 1]!]
    | ``Logic.Solver.toSet, _ =>
      match listElems args[n - 1]! with
      | some xs => do
        let mut parts : Array (TSyntax `term) := #[← symTex "\\{"]
        for (x, i) in xs.zipIdx do
          if i > 0 then parts := parts.push (← symTex ",\\allowbreak ")
          parts := parts.push (← go x)
        symSeq (parts.push (← symTex "\\}"))
      | none => go args[n - 1]!
    | _, _ =>
      -- A function applied to its explicit arguments, under its own name.
      let info ← getFunInfoNArgs f n
      let explicit := (args.zip info.paramInfo).filterMap fun (a, (pi : ParamInfo)) =>
        if pi.binderInfo.isExplicit then some a else none
      let explicit := explicit ++ args.extract info.paramInfo.size n
      if explicit.isEmpty then symTex (mathIdent c)
      else call (mathIdent c) explicit
  | _ => symTex ("\\text{" ++ Logic.Latex.escape (toString (← ppExpr e)) ++ "}")
where
  /-- The name a bound function is set under. -/
  symTex' (f : Expr) : MetaM String := do
    match f with
    | .fvar id => pure (mathVar (← id.getUserName))
    | _ => pure ("\\text{" ++ Logic.Latex.escape (toString (← ppExpr f)) ++ "}")

end Sym

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

    -- The line a position is made from, when it is `Line.asPackage` of a line
    -- declared by name: so the page points to the line.
    let lineOf (info : ConstantInfo) : Option Name := do
      let v ← info.value?
      guard (v.getAppFn.constName? == some ``Logic.Line.asPackage)
      v.getAppArgs.findSome? fun a => do
        let c ← a.constName?
        let i ← env.find? c
        guard (i.type.getAppFn.constName? == some ``Logic.Line)
        pure c

    -- The parties of a map from each party to its position, when the parties
    -- are an enumeration: its constructors, in the order they are declared.
    let positionsOf (ty : Expr) : Option (List Name) := do
      let .forallE _ (.const ι _) body _ := ty | none
      guard (body.getAppFn.constName? == some ``Logic.ArgumentPackage)
      let .inductInfo ind ← env.find? ι | none
      guard (ind.numParams == 0 && ind.numIndices == 0)
      ind.ctors.mapM fun c => do
        let .ctorInfo ci ← env.find? c | none
        guard (ci.numFields == 0)
        pure c

    -- The solver's form of each dispute, `D.finite` or any `Solver.Finite
    -- D.defeats` the argument declares, by the dispute it is the form of.
    let mut finiteOf : Std.HashMap Name Name := {}
    for n in (declsOf.getD ns #[]) do
      let some i := env.find? n | continue
      unless i.type.isAppOf ``Logic.Solver.Finite do continue
      let r := i.type.getAppArgs.back!
      if r.isAppOf ``Logic.Dispute.defeats then
        if let some d := r.getAppArgs.back!.constName? then
          finiteOf := finiteOf.insert d n
    let finiteFor (d : Name) : Option Name :=
      if env.contains (d ++ `finite) then some (d ++ `finite) else finiteOf[d]?

    -- A rule over true and false, `Bool → … → Bool`: its inputs' names.
    let boolRule (ty : Expr) : Option (List String) := Id.run do
      let mut t := ty
      let mut names : Array String := #[]
      while t.isForall do
        let .forallE nm dom body _ := t | return none
        unless dom.isConstOf ``Bool do return none
        names := names.push (nm.eraseMacroScopes.toString.dropWhile (· == '_')).toString
        t := body
      if names.isEmpty || names.size > 4 || !t.isConstOf ``Bool then return none
      return some names.toList

    -- A source that takes its pinpoint or rating where it is used: the
    -- arguments that read it at the whole work and at `disputed`.
    let sourceArgs (ty : Expr) : Option (Array (TSyntax `term)) := Id.run do
      let mut t := ty
      let mut args : Array (TSyntax `term) := #[]
      while t.isForall do
        let .forallE _ dom body _ := t | return none
        let dom := dom.consumeTypeAnnotations
        let dom := if dom.isAppOfArity ``optParam 2 then dom.getArg! 0 else dom
        if dom.isConstOf ``Testimony.Confidence then
          args := args.push (mkIdent ``Testimony.Confidence.disputed)
        else if dom.isConstOf ``Testimony.Bib.Locus then
          args := args.push (mkIdent ``Testimony.Bib.Locus.whole)
        else return none
        t := body
      if args.isEmpty || !t.isConstOf ``Testimony.Source then return none
      return some args

    -- A hearing under a register's standard, `R.hearing s`: the register and
    -- the standard, when both are named.
    let hearingOf (info : ConstantInfo) : Option (Name × Name) := do
      let v ← info.value?
      guard (v.isAppOf ``Logic.Register.hearing)
      let args := v.getAppArgs
      let r ← args[args.size - 2]!.constName?
      let st ← args[args.size - 1]!.constName?
      guard (env.contains (r ++ `finite))
      pure (r, st)

    -- The map a dispute takes its positions from, when it is declared by name
    -- in the argument and set out on the page; empty otherwise.
    let nodeOf (info : ConstantInfo) : String := Id.run do
      let some v := info.value? | return ""
      unless v.getAppFn.constName? == some ``Logic.Dispute.mk do return ""
      for a in v.getAppArgs do
        if let some c := a.constName? then
          if let some i := env.find? c then
            if c.getPrefix == ns && (positionsOf i.type).isSome then return c.getString!
      return ""

    -- The argument's claims: the atom type of its positions, which a statement
    -- sets each claim of as its numbered variable.
    let claimTy : Option Name := (declsOf.getD ns #[]).findSome? fun n => do
      let i ← env.find? n
      guard (i.type.getAppFn.constName? == some ``Logic.ArgumentPackage)
      match i.type.getAppArgs[0]? with
      | some (Expr.const c _) => some c
      | _ => none

    -- The declarations: each rendered by what its type says it is.
    let mut atomTy : Option Name := none
    -- Those that would be shown by their signature alone.
    let mut bare : Array Name := #[]
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
            let st ← liftTermElabM (symOf claimTy info.type)
            if headIs ``Logic.OpponentsBurden then
              `(Logic.Page.Item.burden $(quote dname) $(quote doc) $st
                  (Logic.OpponentsBurden.view $(mkIdent n)))
            else
              `(Logic.Page.Item.result $(quote dname) $(quote doc) $st
                  $(quote (proposedAttr.hasTag env n)))
          else if headIs ``Logic.ArgumentPackage then do
            if atomTy.isNone then
              atomTy := match info.type.getAppArgs[0]? with
                | some (Expr.const c _) => some c
                | _ => none
            -- A position made from a line as it stands points to the line.
            match lineOf info with
            | some l =>
              `(Logic.Page.Item.fromLine $(quote dname) $(quote doc) $(quote l.getString!)
                  $(mkIdent n))
            | none => `(Logic.Page.Item.package $(quote dname) $(quote doc) $(mkIdent n))
          else if let some ctors := positionsOf info.type then do
            let names ← ctors.mapM fun c => `(($(mkIdent n) $(mkIdent c)).name)
            `(Logic.Page.Item.positions $(quote dname) $(quote doc) [$(names.toArray),*])
          else if let some fin := (if headIs ``Logic.Dispute then finiteFor n else none) then do
            `(Logic.Page.Item.dispute $(quote dname) $(quote doc)
                ($(mkIdent fin).parties.map fun i => ($(mkIdent n).node i).name)
                $(quote (nodeOf info)))
          else if headIs ``Logic.Solver.Finite || Meta.isInstanceCore env n then
            -- The solver's form of a dispute, and an instance the checks need:
            -- machinery, said by its docstring.
            `(Logic.Page.Item.helper $(quote dname) $(quote doc))
          else if headIs ``Logic.Register then do
            match info.type.getAppArgs.back? with
            | some (.const d _) =>
              if env.contains (d ++ `finite) then
                `(Logic.Page.Item.register $(quote dname) $(quote doc)
                    (($(mkIdent (d ++ `finite)).parties.filter
                        fun i => ($(mkIdent n).assessmentOf i).isSome).map
                      fun i => ($(mkIdent d).node i).name)
                    ($(mkIdent n).steps.map (·.step)))
              else do
                bare := bare.push n
                `(Logic.Page.Item.other $(quote dname) $(quote doc) "")
            | _ => do
              bare := bare.push n
              `(Logic.Page.Item.other $(quote dname) $(quote doc) "")
          else if headIs ``Logic.Refutation then
            `(Logic.Page.Item.refutation $(quote dname) $(quote doc) $(mkIdent n).claim
                $(mkIdent n).reads $(mkIdent n).reading)
          else if headIs ``List &&
              (info.type.getAppArgs[0]?.any fun a => a.constName? == some ``Corpus.Greek.Token) then
            `(Logic.Page.Item.greek $(quote dname) $(quote doc)
                (let ws := $(mkIdent n)
                 match ws.head?, ws.getLast? with
                  | some f, some l =>
                    let first : Testimony.Passage := ⟨f.book, f.chapter, f.verse⟩
                    if f.chapter == l.chapter && f.verse == l.verse then first.render
                    else if f.chapter == l.chapter then
                      first.render ++ "–" ++ toString l.verse
                    else first.render ++ "–" ++ toString l.chapter ++ ":" ++ toString l.verse
                  | _, _ => "")
                ($(mkIdent n).map (·.text)))
          else if headIs ``Logic.Because then
            `(Logic.Page.Item.because $(quote dname) $(quote doc)
                (Logic.Because.view $(mkIdent n)))
          else if headIs ``Logic.TruthTable then
            `(Logic.Page.Item.table $(quote dname) $(quote doc)
                (Logic.Page.tableView $(mkIdent n)))
          else if headIs ``Logic.Dilemma then
            `(Logic.Page.Item.dilemma $(quote dname) $(quote doc)
                (Logic.Dilemma.view $(mkIdent n)))
          else if headIs ``Logic.Verdict then
            `(Logic.Page.Item.verdict $(quote dname) $(quote doc)
                (Logic.Verdict.view $(mkIdent n)) [$(becauseLinks),*]
                $(quote (tableFor info.type)))
          else if headIs ``Logic.Bundle then
            `(Logic.Page.Item.exchange $(quote dname) $(quote doc)
                (Logic.Bundle.view $(mkIdent n)) [$(becauseLinks),*])
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
          else if (match info.type with
              | .forallE _ (.const _ _) (.const c _) _ => c == ``Logic.AtomMeta
              | _ => false) then
            `(Logic.Page.Item.citation $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``List &&
              (info.type.getAppArgs[0]?.any fun a => headOf a == some ``Logic.Line) then
            `(Logic.Page.Item.listing $(quote dname) $(quote doc) "The lines it gathers:"
                ($(mkIdent n).map (·.name)))
          else if headIs ``List &&
              (info.type.getAppArgs[0]?.any fun a => a.constName? == some ``Testimony.Source) then
            `(Logic.Page.Item.sources $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``Testimony.Bib.Locus then
            `(Logic.Page.Item.said $(quote dname) $(quote doc)
                (match Logic.Markdown.locus $(mkIdent n) with
                  | "" => "The pinpoint: the work as a whole."
                  | l => "The pinpoint: " ++ l ++ "."))
          else if headIs ``Testimony.Passage then
            `(Logic.Page.Item.said $(quote dname) $(quote doc)
                ("The passage: " ++ ($(mkIdent n)).render ++ "."))
          else if headIs ``Testimony.IntertextEdge then
            `(Logic.Page.Item.edge $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``Testimony.Interpretation then
            `(Logic.Page.Item.interpretation $(quote dname) $(quote doc) "" $(mkIdent n))
          else if headIs ``Testimony.FulfillmentCriterion then
            `(Logic.Page.Item.interpretation $(quote dname) $(quote doc) $(mkIdent n).name
                $(mkIdent n).basis)
          else if headIs ``Logic.Reading then
            `(Logic.Page.Item.dilemmaReading $(quote dname) $(quote doc) $(mkIdent n).name
                $(mkIdent n).commits $(mkIdent n).source)
          else if headIs ``Logic.Contested then
            `(Logic.Page.Item.contested $(quote dname) $(quote doc)
                (contestedView $(mkIdent n)).1 (contestedView $(mkIdent n)).2.1
                (contestedView $(mkIdent n)).2.2)
          else if let some inputs := boolRule info.type then do
            let combos := (List.range (2 ^ inputs.length)).map fun k =>
              (List.range inputs.length).map fun j => (k >>> (inputs.length - 1 - j)) % 2 == 1
            let rowTerms ← combos.toArray.mapM fun bs => do
              let lits : Array (TSyntax `term) := bs.toArray.map fun b => quote b
              `(([$(lits),*], $(mkIdent n) $(lits)*))
            `(Logic.Page.Item.truthTable $(quote dname) $(quote doc) $(quote inputs)
                [$(rowTerms),*])
          else if let some args := sourceArgs info.type then do
            `(Logic.Page.Item.sourceFn $(quote dname) $(quote doc) ($(mkIdent n) $(args)*))
          else if let some (r, st) := hearingOf info then do
            let some (.const d _) := (env.find? r).bind (·.type.getAppArgs.back?) | do
              bare := bare.push n
              `(Logic.Page.Item.other $(quote dname) $(quote doc) "")
            `(Logic.Page.Item.dispute $(quote dname) $(quote doc)
                ((($(mkIdent (r ++ `finite)) $(mkIdent st)).parties.filter
                    fun i => decide ($(mkIdent r).admits $(mkIdent st) i)).map
                  fun i => ($(mkIdent d).node i).name) "")
          else if info.type.isForall || headIs ``Testimony.Semantics.Statement then
            `(Logic.Page.Item.helper $(quote dname) $(quote doc))
          else if let some truth ← readingTruth info then
            let pairs ← truth.mapM fun (c, b) => `(($(mkIdent c), $(quote b)))
            `(Logic.Page.Item.reading $(quote dname) $(quote doc) [$(pairs),*])
          else do
            bare := bare.push n
            `(Logic.Page.Item.other $(quote dname) $(quote doc) "")
        items := items.push (k, line, false, term)

    -- A reader is not shown Lean: a declaration with no rendering in words
    -- stops the build, named, until it has one.
    unless bare.isEmpty do
      logError m!"derive_argument_bodies: {bare.size} declaration(s) under {ns} have no \
        rendering in words, and a page shows a reader no Lean: \
        {", ".intercalate (bare.toList.map toString)}. Give each kind a case of \
        `Logic.Page.Item`, rendered by `Logic.Latex.item` and `Logic.Markdown.item`, and \
        harvest it in `deriveArgumentBodies`."

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
    -- A chapter that opens a part is preceded by the part's title, in the text
    -- and in the table of contents.
    let part := if c.part.isEmpty then "" else
      let t := Logic.Latex.escape c.part
      "\\bigskip\\noindent{\\large\\scshape " ++ t ++ "}\\par\\medskip\n" ++
        "\\addcontentsline{toc}{subsection}{\\scshape " ++ t ++ "}\n"
    part ++ "\\subsection*{" ++ heading ++ "}\n\\addcontentsline{toc}{subsection}{" ++ heading ++
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
then the symbols its logic uses, each one's first use linked to its entry
(`Logic.Symbols`), and last, how the edition was made
(`Logic.Latex.reproduction`). Every package
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
  let (body, used) := Logic.Symbols.linkLatex body
  let licensed := (Logic.Latex.citedIn body works).filter (·.core.licence.isSome)
  (if credits then
    Logic.Latex.preamble title ("\\credit{" ++ key ++ "}")
   else Logic.Latex.preamble title) ++
  (match sections with
   | [(a, _)] => latexAbstract a true
   | _ => "") ++
  note ++ Logic.Latex.contents ++ body ++
  Logic.Latex.postamble (Logic.Symbols.latexAppendix used ++
    Logic.Latex.reproduction { made with credits, licensed })

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
