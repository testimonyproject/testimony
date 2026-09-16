import Testimony.Logic.Latex
import Testimony.Arguments.SolaFide
import Testimony.Arguments.SolaScriptura
import Testimony.Arguments.BornInBethlehem
import Testimony.Arguments.BornOfAVirgin

/-!
# argtex — render every argument as traditional propositional logic

`lake exe argtex` writes `docs/latex/arguments.tex`: each package as a legend
of numbered propositional variables with their claims and sources, followed by
its premises and conclusion in ordinary logical notation.

Compile with a Unicode engine — the claims contain Greek and Hebrew:

```sh
lake exe argtex
cd docs/latex && tectonic arguments.tex
```
-/

open Testimony.Logic.Latex

/-- Where the rendered document is written. -/
def texPath : System.FilePath := "docs/latex/arguments.tex"

/-- A `\section*` heading with a prose introduction. -/
def section_ (title intro : String) : String :=
  "\\section*{" ++ escape title ++ "}\n\n" ++ intro ++ "\n\n"

/-- The whole document. -/
def document : String :=
  preamble "Testimony: arguments in propositional form" ++
  "\\noindent Each argument below is a named premise package. Atoms are " ++
  "numbered propositional variables; the legend gives each one's claim, its " ++
  "classification, and the source that carries it. Nothing here asserts that " ++
  "the premises are true --- only that the conclusion does or does not follow " ++
  "from them.\n\n" ++
  section_ "Sola fide"
    ("Two independent strands, Pauline and dominical. Neither lexical premise " ++
     "carries the argument alone; only their disjunction does.") ++
  package Testimony.Arguments.SolaFide.reformed ++
  package Testimony.Arguments.SolaFide.newPerspective ++
  package Testimony.Arguments.SolaFide.tridentine ++
  section_ "Sola scriptura"
    ("Seeded. The self-refutation objection is encoded alongside the " ++
     "position it tells against.") ++
  package Testimony.Arguments.SolaScriptura.protestant ++
  package Testimony.Arguments.SolaScriptura.traditionAndMagisterium ++
  package Testimony.Arguments.SolaScriptura.selfRefutation ++
  section_ "Born in Bethlehem (Micah 5:2)"
    "Matthew 2:5--6 quotes Micah 5:2 as grounds for the Messiah's birthplace." ++
  package Testimony.Arguments.BornInBethlehem.christian ++
  package Testimony.Arguments.BornInBethlehem.critical ++
  section_ "Born of a virgin (Isaiah 7:14)"
    ("A single-stranded argument, and so the weaker one: defeating the " ++
     "lexical premise defeats it outright.") ++
  package Testimony.Arguments.BornOfAVirgin.christian ++
  package Testimony.Arguments.BornOfAVirgin.critical ++
  postamble

/-- Read a file, treating absence as empty so `--check` reports it as stale. -/
def readOrEmpty (p : System.FilePath) : IO String := do
  if ← p.pathExists then IO.FS.readFile p else pure ""

/-- Entry point. -/
def main (args : List String) : IO UInt32 := do
  if args.contains "--check" then
    if (← readOrEmpty texPath) == document then
      IO.println "argtex: rendered arguments are up to date"
      return 0
    IO.eprintln s!"argtex: {texPath} is stale — run `lake exe argtex` and commit the result"
    return 1
  IO.FS.createDirAll "docs/latex"
  IO.FS.writeFile texPath document
  -- The bibliography must sit beside the document for `\bibliography` to resolve.
  IO.FS.writeFile "docs/latex/references.bib" (← IO.FS.readFile "references.bib")
  IO.println s!"argtex: wrote {texPath}"
  return 0
