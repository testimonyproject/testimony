import Testimony
import Testimony.Tools.Docs

/-!
# statusgen — generate the roadmap's status table from the Lean source

`docs/src/roadmap.md` used to restate results by hand, and for two commits it
asserted the opposite of a proven theorem. This tool removes that class of
drift the way `bibgen` and `argtex` remove it for the bibliography and the
rendered arguments: the table is generated, and `--check` fails CI when the
committed copy is stale.

What it lists is not a curated selection. `@[headline]` already marks exactly
the results this library claims, so the table is every headline theorem in the
environment, with its statement as Lean states it and the first sentence of its
docstring. A result that is renamed, restated or deleted moves the table on the
next run; a result that is added appears without anyone remembering to add it.

That last claim is why this module imports the library root rather than the
argument modules one by one, as `argtex` does. `argtex` names every package it
renders, so a module missing from its imports fails to compile; here a missing
import would simply mean fewer results, silently, and the `#guard` below could
not see the gap it is meant to catch. Importing `Testimony` makes the table's
scope the library's own.

```sh
lake exe statusgen            # rewrite the generated block in docs/src/roadmap.md
lake exe statusgen --check    # verify the committed block matches the source
```

Only the block between the two markers is touched. The prose around it is
written by hand, because *why* an argument is worth making is not derivable
from its statements.
-/

open Lean Elab Command Testimony.Doc

namespace Testimony.Status

/-- One headline result, as the status table lists it. -/
structure Headline where
  /-- The namespace of the argument the result belongs to, e.g.
  `Testimony.Arguments.SolaFide`. -/
  argument : Name
  /-- The declaration name, unqualified: `reformed_establishes`. -/
  name : String
  /-- The statement as Lean states it, with the library's own namespaces
  stripped so that it reads as it does in the source file. -/
  statement : String
  /-- The first sentence of the declaration's docstring. -/
  summary : String
  /-- Whether the result is tagged `@[proposed]`: constructed by this library
  rather than reported from a source. -/
  proposed : Bool := false
  deriving Inhabited, Repr

/-- How much of a docstring's first sentence the table carries. A summary is
one sentence by construction, but a sentence can be a paragraph long, and a
table cell is not where a reader should meet it — the source is. -/
def summaryWidth : Nat := 180

/-- Collapse whitespace runs to single spaces, so a pretty-printed statement or
a docstring sentence fits one Markdown table cell. -/
def oneLine (s : String) : String :=
  String.intercalate " " ((s.replace "\n" " ").splitOn " " |>.filter (· ≠ ""))

/-- The first sentence of a docstring: everything up to the first period that
ends a word. Docstrings here open with what the result claims, so the first
sentence is the summary; the rest is the argument for it. -/
def firstSentence (s : String) : String :=
  let flat := oneLine s
  let rec go (acc : String) : List Char → String
    | [] => acc
    | '.' :: rest =>
      match rest with
      | [] => acc.push '.'
      | c :: _ => if c == ' ' then acc.push '.' else go (acc.push '.') rest
    | c :: rest => go (acc.push c) rest
  go "" flat.toList

/-- Truncate at a word boundary, marking that something was cut. -/
def clip (width : Nat) (s : String) : String :=
  if s.length <= width then s
  else
    let head := (s.take width).toString
    let kept := (head.splitOn " ").dropLast
    (if kept.isEmpty then head else String.intercalate " " kept) ++ " …"

/-- Escape the one character a Markdown table cell cannot carry. -/
def cell (s : String) : String := (oneLine s).replace "|" "\\|"

end Testimony.Status

namespace Testimony.Status

open Testimony in
/-- Generates `def <name> : List Headline` from every `@[headline]` declaration
in the environment, ordered by the module and line they are declared on, so the
table reads in source order. Modules are taken in import order, not by name: an
argument split into a directory is read as it is built, so its packages' results
come before a module that imports them — `Dispute` after `Results`, not before.

Unlike `derive_bib_registry`, this reads the tag attribute's *imported* state as
well as the local one: the results live in the argument modules and the table is
assembled in this one. -/
elab "derive_headline_table " tableName:ident : command => do
  let env ← getEnv
  let mut decls : Array Name := #[]
  for i in [0 : env.header.moduleNames.size] do
    decls := decls ++ headlineAttr.ext.getModuleEntries env i
  decls := decls ++ (headlineAttr.ext.getState env).toArray
  let mut rows : Array (Nat × Nat × Headline) := #[]
  for decl in decls do
    let some info := env.find? decl
      | throwError "statusgen: {decl} is tagged @[headline] but is not in the environment"
    let stmt ← liftTermElabM do
      let fmt ← Lean.PrettyPrinter.ppExpr info.type
      pure (fmt.pretty (width := 1000))
    let stripped := stripNamespaces decl.getPrefix (oneLine stmt)
    let doc := (← findDocString? env decl).getD ""
    let mod := match env.getModuleIdxFor? decl with
      | some idx => idx.toNat
      | none => env.header.moduleNames.size
    let line := (← findDeclarationRanges? decl).map (·.range.pos.line) |>.getD 0
    rows := rows.push (mod, line,
      { argument := decl.getPrefix
      , name := decl.getString!
      , statement := stripped
      , summary := clip summaryWidth (firstSentence doc)
      , proposed := proposedAttr.hasTag env decl })
  let sorted := rows.qsort fun (m₁, l₁, _) (m₂, l₂, _) => if m₁ == m₂ then l₁ < l₂ else m₁ < m₂
  let terms ← sorted.mapM fun (_, _, h) =>
    `(term| { argument := $(quote h.argument)
            , name := $(quote h.name)
            , statement := $(quote h.statement)
            , summary := $(quote h.summary)
            , proposed := $(quote h.proposed) })
  elabCommand (← `(command|
    /-- Every `@[headline]` result in the library, collected from the tag
    attribute. Generated by `derive_headline_table`. -/
    def $tableName : List Headline := [$terms,*]))

derive_headline_table headlines

/-- The arguments the table presents, in order, with the heading each appears
under. Taken from `Testimony.Doc.arguments`, which `argdoc` reads too: an
argument's title is editorial prose, and one editorial list is better than two.

Every namespace carrying a headline result must appear there — `#guard` below
fails the build otherwise, so adding an argument cannot silently omit it from
the status table. -/
def sections : List Argument := arguments

#guard !headlines.isEmpty
#guard headlines.all fun h => sections.any fun a => a.ns == h.argument

/-- The results belonging to one argument, in source order. -/
def resultsOf (ns : Name) : List Headline := headlines.filter (·.argument == ns)

/-- One argument's heading and table. The heading links to the argument's own
generated page, where the same results are set with their full docstrings and
the premises they rest on. -/
def renderSection (a : Argument) : String :=
  let rows := (resultsOf a.ns).map fun h =>
    let mark := if h.proposed then " ⚗" else ""
    "| `" ++ cell h.name ++ "`" ++ mark ++ " | `" ++ cell h.statement ++ "` | "
      ++ cell h.summary ++ " |\n"
  "### [" ++ a.title ++ "](./arguments/" ++ a.slug ++ ".md)\n\n" ++
  "| Result | Statement | What it claims |\n|---|---|---|\n" ++
  String.join rows ++ "\n"

/-- The generated block: a count, then one table per argument.

The count says how many arguments and results there are, and nothing about how
finished they are. A generated "worked end to end" would be the very thing this
tool exists to prevent — a page contradicting the source. How far an argument
has got is editorial, and belongs to its heading in `sections`.

Results tagged `@[proposed]` are counted separately and marked in the table.
The library's worth depends on a reader being able to tell what it reports from
what it constructs, so that distinction is generated rather than remembered. -/
def statusMarkdown : String :=
  let proposedCount := (headlines.filter (·.proposed)).length
  let proposedNote :=
    if proposedCount == 0 then ""
    else
      let subject :=
        if proposedCount == 1 then "one of them is marked ⚗: a result"
        else s!"{proposedCount} of them are marked ⚗: results"
      " " ++ subject ++ " this library constructs rather than reports, with no " ++
      "source found advancing it in that form."
  let counted :=
    s!"**{sections.length} arguments**, carrying **{headlines.length} " ++
    "headline results**, listed below in source order." ++ proposedNote ++ "\n\n"
  counted ++ String.join (sections.map renderSection)

end Testimony.Status

open Testimony.Status

/-- The page carrying the generated block. -/
def roadmapPath : System.FilePath := "docs/src/roadmap.md"

/-- Opening marker. Everything between this and `endMarker` is generated. -/
def beginMarker : String := "<!-- BEGIN GENERATED: lake exe statusgen -->"

/-- Closing marker. -/
def endMarker : String := "<!-- END GENERATED: lake exe statusgen -->"

/-- Replace the marked block of `doc` with `body`, or report why it could not
be found. A missing marker is an error rather than an append: the page decides
where the table goes. -/
def splice (doc body : String) : Except String String :=
  match doc.splitOn beginMarker with
  | [before, rest] =>
    match rest.splitOn endMarker with
    | [_, after] =>
      .ok (before ++ beginMarker ++ "\n\n" ++ body ++ endMarker ++ after)
    | parts =>
      .error s!"expected exactly one {endMarker}, found {parts.length - 1}"
  | parts => .error s!"expected exactly one {beginMarker}, found {parts.length - 1}"

/-- Entry point. -/
def main (args : List String) : IO UInt32 := do
  unless ← roadmapPath.pathExists do
    IO.eprintln s!"statusgen: {roadmapPath} does not exist"
    return 1
  let doc ← IO.FS.readFile roadmapPath
  match splice doc statusMarkdown with
  | .error e =>
    IO.eprintln s!"statusgen: {roadmapPath}: {e}"
    return 1
  | .ok updated =>
    if args.contains "--check" then
      if doc == updated then
        IO.println s!"statusgen: {headlines.length} headline results; {roadmapPath} is up to date"
        return 0
      IO.eprintln s!"statusgen: {roadmapPath} is stale — run `lake exe statusgen`"
      IO.eprintln "statusgen: and commit the result"
      return 1
    IO.FS.writeFile roadmapPath updated
    IO.println s!"statusgen: wrote {roadmapPath} ({headlines.length} headline results)"
    return 0
