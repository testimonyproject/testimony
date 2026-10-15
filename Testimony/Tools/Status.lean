import Testimony.Attr
import Testimony.Tools.Docs
import Testimony.Logic.Markdown

/-!
# Testimony.Tools.Status — the status table, generated from the results

The roadmap used to restate results by hand, and for two commits it asserted
the opposite of a proven theorem. The table is generated instead, and a check
fails CI when the committed copy is stale.

What it lists is not a curated selection. `@[headline]` already marks exactly
the results an argument claims, so the table is every headline theorem in a
package's namespace, with its statement as Lean states it and the first
sentence of its docstring. A result that is renamed, restated or deleted moves
the table on the next run; a result that is added appears without anyone
remembering to add it.

Only the block between two markers is generated. The prose around it is
written by hand, because *why* an argument is worth making is not derivable
from its statements. `statusgen` is this, run over the library's arguments.
-/

open Lean Elab Command Testimony.Doc
open Testimony.Logic.Markdown (oneLine cell splice)

namespace Testimony.Status

/-- One headline result, as the status table lists it. -/
structure Headline where
  /-- The namespace of the argument the result belongs to. -/
  argument : Name
  /-- The declaration name, unqualified: `reformed_establishes`. -/
  name : String
  /-- The statement as Lean states it, with the namespaces stripped so that it
  reads as it does in the source file. -/
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

open Testimony in
/-- Generates `def <name> : List Headline` from every `@[headline]`
declaration under `root` (every one, when `root` is anonymous), ordered by the
module and line they are declared on, so the table reads in source order.
Modules are taken in import order, not by name: an argument split into a
directory is read as it is built, so its packages' results come before a module
that imports them — `Dispute` after `Results`, not before.

Unlike `derive_bib_registry`, this reads the tag attribute's *imported* state as
well as the local one: the results live in the argument modules and the table is
assembled in another. -/
def deriveHeadlineTable (tableName : Ident) (root : Name) : CommandElabM Unit := do
  let env ← getEnv
  let mut decls : Array Name := #[]
  for i in [0 : env.header.moduleNames.size] do
    decls := decls ++ headlineAttr.ext.getModuleEntries env i
  decls := decls ++ (headlineAttr.ext.getState env).toArray
  let mut rows : Array (Nat × Nat × Headline) := #[]
  for decl in decls do
    unless root.isPrefixOf decl do continue
    let some info := env.find? decl
      | throwError "statusgen: {decl} is tagged @[headline] but is not in the environment"
    let stmt ← liftTermElabM do
      let fmt ← Lean.PrettyPrinter.ppExpr info.type
      pure (fmt.pretty (width := 1000))
    let stripped := stripNamespaces decl.getPrefix (oneLine stmt) (← getCurrNamespace)
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
    /-- Every `@[headline]` result, collected from the tag attribute. Generated
    by `derive_headline_table`. -/
    def $tableName : List Headline := [$terms,*]))

/-- `derive_headline_table t` generates `def t : List Headline` from every
`@[headline]` result in the environment; `derive_headline_table t under N`, from
those declared under the namespace `N`. See `deriveHeadlineTable`. -/
syntax (name := deriveHeadlineTableCmd) "derive_headline_table " ident (" under " ident)? :
  command

elab_rules : command
  | `(derive_headline_table $t $[under $root]?) =>
    deriveHeadlineTable t ((root.map (·.getId)).getD .anonymous)

/-- One argument's heading and table. The heading links to the argument's own
generated page, where the same results are set with their full docstrings and
the premises they rest on. -/
def renderSection (headlines : List Headline) (a : Argument) : String :=
  let rows := (headlines.filter (·.argument == a.ns)).map fun h =>
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
has got is editorial, and belongs to its heading in the catalogue.

Results tagged `@[proposed]` are counted separately and marked in the table.
The library's worth depends on a reader being able to tell what it reports from
what it constructs, so that distinction is generated rather than remembered. -/
def statusMarkdown (sections : List Argument) (headlines : List Headline) : String :=
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
  counted ++ String.join (sections.map (renderSection headlines))

/-- Opening marker of the block the status table owns in its page. Everything
between this and `endMarker` is generated. -/
def beginMarker : String := "<!-- BEGIN GENERATED: lake exe statusgen -->"

/-- Closing marker. -/
def endMarker : String := "<!-- END GENERATED: lake exe statusgen -->"

/-- **Write the status table into its page, or check it**: with `--check`, fail
if the committed block is stale; otherwise splice the table in. Returns the exit
code. -/
def run (page : System.FilePath) (sections : List Argument) (headlines : List Headline)
    (args : List String) : IO UInt32 := do
  unless ← page.pathExists do
    IO.eprintln s!"statusgen: {page} does not exist"
    return 1
  let doc ← IO.FS.readFile page
  match splice beginMarker endMarker doc (statusMarkdown sections headlines) with
  | .error e =>
    IO.eprintln s!"statusgen: {page}: {e}"
    return 1
  | .ok updated =>
    if args.contains "--check" then
      if doc == updated then
        IO.println s!"statusgen: {headlines.length} headline results; {page} is up to date"
        return 0
      IO.eprintln s!"statusgen: {page} is stale — run `lake exe statusgen`"
      IO.eprintln "statusgen: and commit the result"
      return 1
    IO.FS.writeFile page updated
    IO.println s!"statusgen: wrote {page} ({headlines.length} headline results)"
    return 0

end Testimony.Status
