import Testimony
import Testimony.Logic.Markdown
import Testimony.Tools.Docs

/-!
# argdoc — generate one documentation page per argument, from the Lean source

An argument module is already a literate document. It opens with a docstring
saying what the dispute is and what it is not, its sections are marked by
`/-! ### … -/` blocks, and every package, line and result carries a docstring
written for a reader rather than for a compiler. Until this tool, all of that
reached the documentation site only if someone retyped it there, which is the
drift `statusgen` exists to prevent one table at a time.

`lake exe argdoc` writes `docs/src/arguments/<slug>.md` for every argument in
`Testimony.Doc.arguments`, and splices the list of them into the marked block
of `docs/src/SUMMARY.md`. What lands on the page is:

* **the prose, in source order** — every module docstring of every file the
  argument is built from, its headings pushed down one level to sit under the
  page's title;
* **the claims, numbered once** — a legend of every atom the page mentions,
  with its classification, the tradition that holds it and the source that
  carries it;
* **the arguments themselves** — each package, line and inference step as
  typeset notation, with the same numbering throughout the page;
* **the results** — each `@[headline]` theorem as Lean states it, with the
  axioms it actually rests on.

Nothing here is curated. The page is every documented declaration in the
argument's namespace, in the order the source declares them, so a declaration
that is added, renamed or deleted moves the page on the next run.

```sh
lake exe argdoc            # rewrite docs/src/arguments/ and the SUMMARY block
lake exe argdoc --check    # verify the committed pages match the source
```

## What the renderer reads, and what it does not

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

open Lean Elab Command Testimony Testimony.Logic

namespace Testimony.Doc

/-- One argument's page body, as generated from the environment: everything
below the page's title. -/
structure Body where
  /-- The namespace the items were harvested from. -/
  ns : Name
  /-- The rendered Markdown. -/
  markdown : String
deriving Inhabited

/-- How much of a declaration's value a page will show before falling back to
its signature alone. -/
def valueWidth : Nat := 600

/-- The width the pretty-printer is given for a rendered statement. Narrow
enough that a long one wraps inside a code block rather than scrolling. -/
def printWidth : Nat := 78

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
  let render (ns : Name) (e : Expr) : CommandElabM String := do
    let fmt ← liftTermElabM (Lean.PrettyPrinter.ppExpr e)
    pure (stripNamespaces ns (fmt.pretty (width := printWidth)))

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
            ← `(Markdown.Item.prose $(quote md)))

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
            let stmt ← render ns info.type
            let axioms ← collectAxioms n
            let note :=
              if axioms.isEmpty then "-- axioms: none beyond Lean's own"
              else "-- axioms: " ++ String.intercalate ", " (axioms.toList.map toString)
            `(Markdown.Item.result $(quote dname) $(quote doc)
                $(quote ("theorem " ++ dname ++ " : " ++ stmt ++ "\n" ++ note))
                $(quote (proposedAttr.hasTag env n)))
          else if headIs ``ArgumentPackage then do
            if atomTy.isNone then
              atomTy := match info.type.getAppArgs[0]? with
                | some (Expr.const c _) => some c
                | _ => none
            `(Markdown.Item.package $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``Line then
            `(Markdown.Item.line $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``Formula then
            `(Markdown.Item.formula $(quote dname) $(quote doc) $(mkIdent n))
          else if headIs ``List &&
              (info.type.getAppArgs[0]?.any fun a => headOf a == some ``Formula) then
            `(Markdown.Item.formulas $(quote dname) $(quote doc) $(mkIdent n))
          else do
            let sig ← render ns info.type
            let value ← match info.value? with
              | some v => do
                  let s ← render ns v
                  pure (if s.length > valueWidth then none else some s)
              | none => pure none
            let src := match value with
              | some v => "def " ++ dname ++ " : " ++ sig ++ " :=\n" ++ indentLines v
              | none => "def " ++ dname ++ " : " ++ sig
            `(Markdown.Item.other $(quote dname) $(quote doc) $(quote src))
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
    let call ← `(Markdown.body [$(ctors),*] [$(intro),*] [$(rest),*])
    bodies := bodies.push (← `(term| { ns := $(quote ns), markdown := $call }))

  elabCommand (← `(command|
    /-- Every argument's page body, generated from the Lean source by
    `derive_argument_bodies`. -/
    def $tableName : List Body := [$bodies,*]))

derive_argument_bodies bodies

#guard bodies.all fun b => arguments.any fun a => a.ns == b.ns
#guard arguments.all fun a => bodies.any fun b => b.ns == a.ns

/-- The body generated for one argument. -/
def bodyOf (ns : Name) : Option String := (bodies.find? (·.ns == ns)).map (·.markdown)

/-- The note every generated page opens with, under its title.

It says three things a reader meets in the first screen and would otherwise
have to infer: that the prose is the source's own, what the numbering is, and
what the two marks mean. -/
def preamble (a : Argument) : String :=
  "*This page is generated from [`" ++ sourcePath a.ns ++ "`](https://github.com/" ++
  "testimonyproject/testimony/blob/main/" ++ sourcePath a.ns ++ "). Every heading and " ++
  "paragraph below is a docstring in those files; every formula is rendered from the " ++
  "encoding they check. If the page and the source disagree, the page is the one that " ++
  "is wrong, and regenerating it is the fix.*\n\n" ++
  "Atoms are numbered propositional variables, numbered once for the whole page, so " ++
  "the same variable means the same claim in every position below. " ++
  "[Reading the logic](./../reading-the-logic.md) is the short version of what the " ++
  "notation means. A result marked ⚗ is one this library constructs rather than " ++
  "reports.\n\n"

/-- One argument's page: the do-not-edit header, the title, the note, the
generated body. -/
def page (a : Argument) : Option String :=
  (bodyOf a.ns).map fun b =>
    "<!-- Generated by `lake exe argdoc`. Do not edit by hand. -->\n" ++
    "<!-- Source of truth: " ++ sourcePath a.ns ++ " -->\n\n" ++
    "# " ++ a.title ++ "\n\n" ++ preamble a ++ b

/-- Every generated page, as a file name under `docs/src/arguments/` and its
contents. -/
def pages : List (String × String) :=
  arguments.filterMap fun a => (page a).map fun p => (a.slug ++ ".md", p)

/-- The block `argdoc` owns in `docs/src/SUMMARY.md`. -/
def summaryMarkdown : String :=
  String.join (arguments.map fun a =>
    "- [" ++ a.title ++ "](./arguments/" ++ a.slug ++ ".md)\n")

/-- Replace the marked block of `doc` with `body`, or report why it could not
be found. A missing marker is an error rather than an append: the page decides
where the block goes. -/
def splice (beginMarker endMarker doc body : String) : Except String String :=
  match doc.splitOn beginMarker with
  | [before, rest] =>
    match rest.splitOn endMarker with
    | [_, after] =>
      .ok (before ++ beginMarker ++ "\n\n" ++ body ++ "\n" ++ endMarker ++ after)
    | parts =>
      .error s!"expected exactly one {endMarker}, found {parts.length - 1}"
  | parts => .error s!"expected exactly one {beginMarker}, found {parts.length - 1}"

end Testimony.Doc

open Testimony.Doc

/-- Where the generated pages are written. -/
def pagesDir : System.FilePath := "docs/src/arguments"

/-- The page carrying the generated list of arguments. -/
def summaryPath : System.FilePath := "docs/src/SUMMARY.md"

/-- Opening marker of the block `argdoc` owns in `SUMMARY.md`. -/
def beginMarker : String := "<!-- BEGIN GENERATED: lake exe argdoc -->"

/-- Closing marker. -/
def endMarker : String := "<!-- END GENERATED: lake exe argdoc -->"

/-- Read a file, treating absence as empty so `--check` reports it as stale
rather than failing. -/
def readOrEmpty (p : System.FilePath) : IO String := do
  if ← p.pathExists then IO.FS.readFile p else pure ""

/-- Pages present in `docs/src/arguments/` that `argdoc` does not generate.

An argument that is renamed or removed leaves its old page behind, and a stale
page asserting a result the library no longer has is the failure this project
exists to rule out. Reported rather than deleted: the tool says what to remove,
and a human removes it. -/
def strayPages : IO (Array System.FilePath) := do
  unless ← pagesDir.pathExists do return #[]
  let wanted := pages.map (·.1)
  let mut stray := #[]
  for entry in ← pagesDir.readDir do
    let name := entry.fileName
    if name.endsWith ".md" && !wanted.contains name then
      stray := stray.push entry.path
  return stray.qsort (·.toString < ·.toString)

/-- Entry point. -/
def main (args : List String) : IO UInt32 := do
  unless ← summaryPath.pathExists do
    IO.eprintln s!"argdoc: {summaryPath} does not exist"
    return 1
  let summary ← IO.FS.readFile summaryPath
  let updated ← match splice beginMarker endMarker summary summaryMarkdown with
    | .error e => do IO.eprintln s!"argdoc: {summaryPath}: {e}"; return 1
    | .ok s => pure s
  let stray ← strayPages
  if args.contains "--check" then
    let mut ok := true
    for (name, text) in pages do
      if (← readOrEmpty (pagesDir / name)) != text then
        IO.eprintln s!"argdoc: docs/src/arguments/{name} is stale"
        ok := false
    if summary != updated then
      IO.eprintln s!"argdoc: the generated block in {summaryPath} is stale"
      ok := false
    for p in stray do
      IO.eprintln s!"argdoc: {p} is not generated by argdoc — delete it"
      ok := false
    if ok then
      IO.println s!"argdoc: {pages.length} argument pages are up to date"
      return 0
    IO.eprintln "argdoc: run `lake exe argdoc` and commit the result"
    return 1
  IO.FS.createDirAll pagesDir
  for (name, text) in pages do
    IO.FS.writeFile (pagesDir / name) text
  IO.FS.writeFile summaryPath updated
  for p in stray do
    IO.eprintln s!"argdoc: warning: {p} is not generated by argdoc — delete it"
  IO.println s!"argdoc: wrote {pages.length} pages to {pagesDir} and updated {summaryPath}"
  return 0
