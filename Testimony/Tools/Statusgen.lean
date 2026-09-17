import Testimony.Arguments.SolaFide
import Testimony.Arguments.SolaScriptura
import Testimony.Arguments.BornInBethlehem
import Testimony.Arguments.BornOfAVirgin

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

```sh
lake exe statusgen            # rewrite the generated block in docs/src/roadmap.md
lake exe statusgen --check    # verify the committed block matches the source
```

Only the block between the two markers is touched. The prose around it is
written by hand, because *why* an argument is worth making is not derivable
from its statements.
-/

open Lean Elab Command

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
  deriving Inhabited, Repr

/-- Namespaces stripped from a pretty-printed statement, so that it reads as
it does in the source file rather than as the pretty-printer spells it from
outside the argument's namespace. Both the fully qualified form and the form
the pretty-printer shortens to inside `Testimony` are listed, longest first. -/
def strippedPrefixes : List String :=
  [ "Testimony.Arguments.BornInBethlehem."
  , "Testimony.Arguments.BornOfAVirgin."
  , "Testimony.Arguments.SolaFide."
  , "Testimony.Arguments.SolaScriptura."
  , "Arguments.BornInBethlehem."
  , "Arguments.BornOfAVirgin."
  , "Arguments.SolaFide."
  , "Arguments.SolaScriptura."
  , "Testimony.Logic."
  , "Testimony.People."
  , "Testimony."
  , "Logic."
  , "People." ]

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
table reads in source order.

Unlike `derive_bib_registry`, this reads the tag attribute's *imported* state as
well as the local one: the results live in the argument modules and the table is
assembled in this one. -/
elab "derive_headline_table " tableName:ident : command => do
  let env ← getEnv
  let mut decls : Array Name := #[]
  for i in [0 : env.header.moduleNames.size] do
    decls := decls ++ headlineAttr.ext.getModuleEntries env i
  decls := decls ++ (headlineAttr.ext.getState env).toArray
  let mut rows : Array (String × Nat × Headline) := #[]
  for decl in decls do
    let some info := env.find? decl
      | throwError "statusgen: {decl} is tagged @[headline] but is not in the environment"
    let stmt ← liftTermElabM do
      let fmt ← Lean.PrettyPrinter.ppExpr info.type
      pure (fmt.pretty (width := 1000))
    let stripped := strippedPrefixes.foldl (fun s p => s.replace p "") (oneLine stmt)
    let doc := (← findDocString? env decl).getD ""
    let mod := match env.getModuleIdxFor? decl with
      | some idx => (env.header.moduleNames[idx.toNat]!).toString
      | none => env.mainModule.toString
    let line := (← findDeclarationRanges? decl).map (·.range.pos.line) |>.getD 0
    rows := rows.push (mod, line,
      { argument := decl.getPrefix
      , name := decl.getString!
      , statement := stripped
      , summary := clip summaryWidth (firstSentence doc) })
  let sorted := rows.qsort fun (m₁, l₁, _) (m₂, l₂, _) => if m₁ == m₂ then l₁ < l₂ else m₁ < m₂
  let terms ← sorted.mapM fun (_, _, h) =>
    `(term| { argument := $(quote h.argument)
            , name := $(quote h.name)
            , statement := $(quote h.statement)
            , summary := $(quote h.summary) })
  elabCommand (← `(command|
    /-- Every `@[headline]` result in the library, collected from the tag
    attribute. Generated by `derive_headline_table`. -/
    def $tableName : List Headline := [$terms,*]))

derive_headline_table headlines

/-- The arguments the table presents, in order, with the heading each appears
under. Editorial: an argument's title is prose about what it argues from, which
is not derivable from the names of its theorems.

Every namespace carrying a headline result must appear here — `#guard` below
fails the build otherwise, so adding an argument cannot silently omit it from
the status table. -/
def sections : List (Name × String) :=
  [ (`Testimony.Arguments.BornInBethlehem, "Born in Bethlehem — Micah 5:2")
  , (`Testimony.Arguments.BornOfAVirgin,
      "Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3")
  , (`Testimony.Arguments.SolaFide, "Sola fide")
  , (`Testimony.Arguments.SolaScriptura, "Sola scriptura (seeded)") ]

#guard !headlines.isEmpty
#guard headlines.all fun h => sections.any fun (ns, _) => ns == h.argument

/-- The results belonging to one argument, in source order. -/
def resultsOf (ns : Name) : List Headline := headlines.filter (·.argument == ns)

/-- One argument's heading and table. -/
def renderSection (ns : Name) (title : String) : String :=
  let rows := (resultsOf ns).map fun h =>
    "| `" ++ cell h.name ++ "` | `" ++ cell h.statement ++ "` | " ++ cell h.summary ++ " |\n"
  "### " ++ title ++ "\n\n" ++
  "| Result | Statement | What it claims |\n|---|---|---|\n" ++
  String.join rows ++ "\n"

/-- The generated block: a count, then one table per argument. -/
def statusMarkdown : String :=
  let counted :=
    s!"**{sections.length} arguments**, worked end to end and each with at " ++
    s!"least one rival package, carrying **{headlines.length} headline " ++
    "results**, listed below in source order.\n\n"
  counted ++ String.join (sections.map fun (ns, title) => renderSection ns title)

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
