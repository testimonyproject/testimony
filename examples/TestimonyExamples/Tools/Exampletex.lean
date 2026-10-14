import TestimonyExamples
import Testimony.Tools.Pages
import Testimony.Bib.Render

/-!
# exampletex — render each example as its own printable document

`lake exe exampletex`, run in `examples/`, writes one LaTeX document per case
under `docs/latex/` — `grits.tex` for the grits — and the examples'
bibliography beside them. Each is harvested from the case's own source by the
library's harvest (`derive_argument_bodies … under TestimonyExamples`) and set by
the library's `latexDocument`, so it reads as the library's own arguments do.
None of it enters the library's documentation: the library's generators do not
import this package, and could not.

```sh
lake exe exampletex
cd docs/latex && tectonic grits.tex
```

`lake exe exampletex --check` fails if a committed document is stale.
-/

open Lean Testimony Testimony.Doc

namespace TestimonyExamples.Doc

derive_argument_bodies bodies under TestimonyExamples

/-- One example, as a document of its own: its catalogue entry, and the file it
is written to under `docs/latex/`. -/
structure Example where
  /-- The case, as the documentation catalogues an argument. -/
  argument : Argument
  /-- The document's file name, without the extension. -/
  file : String

/-- Every example, each its own document. -/
def examples : List Example :=
  [ { argument :=
        { ns := `TestimonyExamples.Grits
        , slug := "grits"
        , title := "The grits — a cross-examination, from My Cousin Vinny (1992)" }
    , file := "grits" } ]

#guard bodies.all fun b => examples.any fun e => e.argument.ns == b.ns
#guard examples.all fun e => bodies.any fun b => b.ns == e.argument.ns

/-- The standing note under each document's title. Hand-written, as the
library's is: what the document is, and what it does not claim. -/
def note : String :=
  "\\noindent This document is generated from the Lean source of " ++
  "\\texttt{TestimonyExamples}, a package built on the Testimony library and not " ++
  "part of it: it imports the library and changes nothing in it. It is set as the " ++
  "library sets its own arguments: the module docstrings as prose, and under each " ++
  "one the package, line of reason, countermodel or result it introduces. Atoms are " ++
  "numbered propositional variables; the legend gives each one's claim, its " ++
  "classification, the tradition that holds it and the source that carries it.\n\n" ++
  "\\noindent Nothing here asserts that the premises are true --- only that the " ++
  "conclusion does or does not follow from them.\n\n"

/-- An example's document. -/
def document (e : Example) : String :=
  latexDocument e.argument.title note (sectionsOf [e.argument] bodies) "exampletex"

end TestimonyExamples.Doc

open TestimonyExamples.Doc in
/-- Entry point. -/
def main (args : List String) : IO UInt32 := do
  let files := examples.map fun e =>
    ((("docs/latex" : System.FilePath) / (e.file ++ ".tex")), document e)
  let code ← writeOrCheck "exampletex" files (args.contains "--check")
  unless args.contains "--check" do
    -- The bibliography must sit beside the documents for `\bibliography` to
    -- resolve. Not committed: it is derived, as the library's copy is.
    IO.FS.writeFile "docs/latex/references.bib"
      (Testimony.Bib.bibtexFile TestimonyExamples.bibliography)
  return code
