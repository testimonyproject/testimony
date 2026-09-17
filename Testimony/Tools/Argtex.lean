import Testimony.Tools.Pages

/-!
# argtex — render every argument as a printable document

`lake exe argtex` writes `docs/latex/arguments.tex`: each argument as a section
of prose and notation, with a legend of numbered propositional variables giving
every claim, who holds it and where they say so.

The prose is the library's own. Until `Testimony.Tools.Pages` existed this tool
rendered packages and nothing else, under a hand-written paragraph per argument
— prose that said less than the module docstring it was paraphrasing, and that
nothing stopped from contradicting it. The document is now assembled from the
same harvest the documentation site is, so the PDF and the site are two
settings of one text rather than two accounts of it.

Compile with a Unicode engine — the claims contain Greek and Hebrew, and the
rendered statements contain `¬`, `→` and `⊢`:

```sh
lake exe argtex
cd docs/latex && tectonic arguments.tex
```
-/

open Lean Testimony Testimony.Doc Testimony.Logic

/-- Where the rendered document is written. -/
def texPath : System.FilePath := "docs/latex/arguments.tex"

/-- The document's title. -/
def documentTitle : String := "Testimony: arguments in propositional form"

/-- The standing note under the title.

Hand-written, and the only hand-written prose in the document: what the
notation means and what the document does *not* claim are facts about the
library rather than about any one argument, so no docstring carries them. -/
def note : String :=
  "\\noindent Each argument below is set as its Lean source sets it: the module " ++
  "docstrings as prose, in the order they are written, and under each one the " ++
  "package, line of reason, countermodel or result it introduces. Atoms are " ++
  "numbered propositional variables, numbered once per argument, so a variable " ++
  "means the same claim in every position within it; the legend gives each one's " ++
  "claim, its classification, the tradition that holds it and the source that " ++
  "carries it.\n\n" ++
  "\\noindent Nothing here asserts that the premises are true --- only that the " ++
  "conclusion does or does not follow from them.\n\n"

/-- The whole document. -/
def document : String :=
  Latex.preamble documentTitle ++ note ++ Latex.contents ++
  String.join (arguments.filterMap fun a =>
    (bodyOf a.ns).map fun b => Latex.sectionHeading a.title ++ b.latex) ++
  Latex.postamble

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
