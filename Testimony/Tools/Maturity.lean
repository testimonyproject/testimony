import Testimony.Checks.Maturity
import Testimony.Tools.Docs
import Testimony.Logic.Markdown

/-!
# Testimony.Tools.Maturity — the maturity page, generated from the checks

Every argument builds, and every build runs the same checks, but the checks of
meaning, of the shared ontology and of fallacies reach only what has been
analysed. This writes, for each argument, how far they reach: the table on the
documentation's maturity page, between two markers, from the counts
`derive_maturity_table` makes at build time. As with the status table, a
`--check` run fails CI when the committed page is stale, so a claim analysed
tomorrow moves the page tomorrow.

Each argument is given a stage, and the stages are defined by the counts alone,
so the stage says what the checks reach and nothing about whether the argument
is right, or finished in any other sense:

- **not yet read**: no claim's meaning is analysed, so the ontology joins
  nothing and the fallacy checks read no line;
- **meanings begun**: some claims are analysed, and no line of reason is read
  yet, because every line still touches a claim that is not;
- **lines being checked**: the fallacy checks read some lines;
- **fully read**: every claim is analysed and every line is read.

An argument with no lines of reason at all is marked so: the fallacy checks have
nothing of it to read, however far its meanings go.
-/

open Testimony.Doc Testimony.Checks
open Testimony.Logic.Markdown (cell splice)

namespace Testimony.Maturity

/-- The stage an argument has reached, by the counts alone; see the module
docstring. -/
def stage (m : Maturity) : String :=
  if m.analysed == 0 then "not yet read"
  else if m.lines > 0 && m.analysed == m.claims && m.read == m.lines then "fully read"
  else if m.read > 0 then "lines being checked"
  else "meanings begun"

/-- `n` lines, with the verb agreeing. -/
def linesThat (n : Nat) (one many : String) : String :=
  if n == 1 then "1 " ++ one else s!"{n} " ++ many

/-- What the fallacy checks found in the lines they read. -/
def found (m : Maturity) : String :=
  if m.lines == 0 then "no lines of reason to read"
  else if m.read == 0 then "—"
  else
    let parts :=
      (if m.carrying == 0 then [] else
        [linesThat m.carrying "carries what it delivers in a premise"
          "carry what they deliver in a premise"]) ++
      (if m.conditional == 0 then [] else
        [linesThat m.conditional "needs a word kept in one sense, unstated"
          "need a word kept in one sense, unstated"])
    if parts.isEmpty then "nothing" else "; ".intercalate parts

/-- What the shared ontology does with its meanings: how many joins, and how
many of them only its definitions find. -/
def joined (m : Maturity) : String :=
  if m.joins == 0 then "none"
  else
    let byDefs := m.joins - m.bare
    s!"{m.joins}, " ++ (if byDefs == 0 then "none of them through a definition"
      else s!"{byDefs} through a definition")

/-- The argument's name, linked to its page when the catalogue lists it. -/
def heading (sections : List Argument) (m : Maturity) : String :=
  match sections.find? (·.ns == m.argument) with
  | some a => "[" ++ cell a.title ++ "](./arguments/" ++ a.slug ++ ".md)"
  | none => cell m.title

/-- The generated block: a sentence of totals, then one row per argument, in
the catalogue's order. -/
def maturityMarkdown (sections : List Argument) (rows : List Maturity) : String :=
  let order (m : Maturity) : Nat := (sections.findIdx? (·.ns == m.argument)).getD sections.length
  let sorted := rows.toArray.qsort (fun a b => order a < order b) |>.toList
  let sum (f : Maturity → Nat) := (rows.map f).foldl (· + ·) 0
  let totals :=
    s!"**{rows.length} arguments**: {sum (·.analysed)} of {sum (·.claims)} claims have " ++
    s!"analysed meanings, and the fallacy checks read {sum (·.read)} of " ++
    s!"{sum (·.lines)} lines of reason.\n\n"
  let row (m : Maturity) : String :=
    "| " ++ heading sections m ++ " | " ++ stage m ++ " | " ++
    s!"{m.analysed} of {m.claims}" ++ " | " ++ s!"{m.read} of {m.lines}" ++ " | " ++
    found m ++ " | " ++ joined m ++ " | " ++ toString m.definitions ++ " |\n"
  totals ++
  "| Argument | Stage | Claims with meanings | Lines read for fallacies " ++
  "| What the fallacy checks found | Joins found | Definitions in use |\n" ++
  "|---|---|---|---|---|---|---|\n" ++ String.join (sorted.map row)

/-- Opening marker of the block the table owns in its page. -/
def beginMarker : String := "<!-- BEGIN GENERATED: lake exe statusgen -->"

/-- Closing marker. -/
def endMarker : String := "<!-- END GENERATED: lake exe statusgen -->"

/-- **Write the maturity table into its page, or check it**: with `--check`,
fail if the committed block is stale; otherwise splice the table in. Returns the
exit code. -/
def run (page : System.FilePath) (sections : List Argument) (rows : List Maturity)
    (args : List String) : IO UInt32 := do
  unless ← page.pathExists do
    IO.eprintln s!"statusgen: {page} does not exist"
    return 1
  let doc ← IO.FS.readFile page
  match splice beginMarker endMarker doc (maturityMarkdown sections rows) with
  | .error e =>
    IO.eprintln s!"statusgen: {page}: {e}"
    return 1
  | .ok updated =>
    if args.contains "--check" then
      if doc == updated then
        IO.println s!"statusgen: {rows.length} arguments' maturity; {page} is up to date"
        return 0
      IO.eprintln s!"statusgen: {page} is stale — run `lake exe statusgen`"
      IO.eprintln "statusgen: and commit the result"
      return 1
    IO.FS.writeFile page updated
    IO.println s!"statusgen: wrote {page} ({rows.length} arguments' maturity)"
    return 0

end Testimony.Maturity
