import TestimonyArguments.Tools.Pages

/-!
# argtex — render every argument as a printable document

`lake exe argtex`, run in `arguments/`, writes `docs/latex/arguments.tex` at the
repository's root: each argument as a section
of prose and notation, with a legend of numbered propositional variables giving
every claim, who holds it and where they say so. Beside it, under
`docs/latex/arguments/`, it writes each argument again as a document of its own,
`sola-fide.tex` for sola fide, so that a reader who wants one argument need not
take the whole book.

A standalone document needs nothing the book does not already give it. Every
variable links to a row of its own argument's legend, and no argument refers to
another by a label, so no link points out of the document. The bibliography is
BibTeX's, which lists only the works a document cites, so each document's is its
own.

The prose is the library's own. Until `Testimony.Tools.Pages` existed this tool
rendered packages and nothing else, under a hand-written paragraph per argument
— prose that said less than the module docstring it was paraphrasing, and that
nothing stopped from contradicting it. The document is now assembled from the
same harvest the documentation site is, so the PDF and the site are two
settings of one text rather than two accounts of it.

Compile with a Unicode engine — the claims contain Greek and Hebrew, and the
rendered statements contain `¬`, `→` and `⊢`:

```sh
lake exe bibgen && lake exe argtex
cd .. && python3 scripts/credits.py docs/latex docs/latex/arguments
python3 scripts/edition.py docs/latex docs/latex/arguments
cd docs/latex && tectonic arguments.tex
cd arguments && for f in *.tex; do tectonic "$f"; done
```

Under its title a document gives a date and a version, the release's tag or
the commit's short hash, and its last section says how it was made and how to
make it again from that commit. Neither is known when the `.tex` is written,
so both come from `edition.def`, which `scripts/edition.py` writes beside the
document when it is typeset, as `credits.def` comes from `scripts/credits.py`.
Without them the document still sets, as an unrecorded copy with no credits.

`lake exe argtex --check` fails if any committed document is stale or missing.
-/

open Lean Testimony Testimony.Doc Testimony.Logic TestimonyArguments.Doc

/-- Where the rendered document is written. -/
def texPath : System.FilePath := "../docs/latex/arguments.tex"

/-- The document's title. -/
def documentTitle : String := "Testimony: arguments in propositional form"

/-- What the notation means and what the document does *not* claim: the same
for the book and for any one argument printed alone. Plain words, because the
reader of a PDF may never have seen a logic text: how the document was made,
and the words for that, wait for its last section. -/
def notationNote : String :=
  "Each claim is given a numbered letter, $P_1$, $P_2$ and so on, so that the steps " ++
  "can be written out in the notation of logic, and a letter means the same claim " ++
  "wherever it appears in one argument. The table of numbered claims gives each in " ++
  "words, with who holds it and where they say so, and every letter links to its " ++
  "row.\n\n" ++
  "\\noindent Nothing here asserts that the premises are true. It shows only " ++
  "whether the conclusion follows from them. The last section says how this " ++
  "edition was made, and how to make it again.\n\n"

/-- The standing note under the book's title.

Hand-written, and with `standaloneNote` the only hand-written prose in the
documents besides the closing section: what the notation means and what a
document does *not* claim are facts about the library rather than about any one
argument, so no docstring carries them. -/
def note : String :=
  "\\noindent This book sets out every argument of the Testimony library, each " ++
  "in its own section. " ++ notationNote

/-- The standing note under the title of an argument printed on its own. It
says where the argument comes from and where the rest of the book is. -/
def standaloneNote : String :=
  "\\noindent This is one argument of the Testimony library, printed on its own. " ++
  "The library also prints every argument together, as one book " ++
  "(\\texttt{arguments.pdf}). " ++ notationNote

/-- How the book is made again: `argtex`, in `arguments/`, writes it. -/
def bookMade : Logic.Latex.Reproduction :=
  { package := "arguments", tool := "argtex", dir := "docs/latex",
    file := "arguments.tex", before := ["bibgen"] }

/-- The whole document: every catalogued argument, set as `latexDocument` sets
any package's. -/
def document : String :=
  latexDocument documentTitle note (sectionsOf arguments bodies) bookMade (credits := true)

/-- Where each argument's own document is written: `<slug>.tex` in this
directory. -/
def standaloneDir : System.FilePath := "../docs/latex/arguments"

/-- One argument printed on its own, under its catalogue title. -/
def standalone (a : Argument) : String :=
  latexDocument a.title standaloneNote (sectionsOf [a] bodies)
    { bookMade with dir := "docs/latex/arguments", file := a.slug ++ ".tex" }
    (credits := true)

-- Each argument's document is named by its slug, so two arguments with one slug
-- would write one file and lose the other. A release attaches every PDF without
-- its directory (`.github/workflows/release.yml`), so none may be the book's.
#guard (arguments.map (·.slug)).eraseDups.length == arguments.length
#guard arguments.all (·.slug != "arguments")
-- Each document is also set on US Letter as `<slug>-letter.pdf`
-- (`scripts/typeset.sh --paper letter`), so no slug may take that form.
#guard arguments.all (!·.slug.endsWith "-letter")

/-- Every file `argtex` writes: the book, then each argument alone, and the house
style beside each, which every one of them loads (`Logic.Latex.style`). -/
def files : List (System.FilePath × String) :=
  (texPath, document) ::
    arguments.map (fun a => (standaloneDir / (a.slug ++ ".tex"), standalone a)) ++
    [((texPath.parent.getD ".") / Logic.Latex.styleFile, Logic.Latex.style),
     (standaloneDir / Logic.Latex.styleFile, Logic.Latex.style)]

/-- Entry point. -/
def main (args : List String) : IO UInt32 := do
  let mut clean := true
  for (path, tex) in files.filter (·.1.extension == some "tex") do
    clean := (← reportStrayQuotes "argtex" path tex) && clean
  unless clean do return 1
  let check := args.contains "--check"
  let code ← writeOrCheck "argtex" files check
  unless check do
    -- The bibliography must sit beside each document for `\bibliography` to
    -- resolve. Not committed: the root's `references.bib` is.
    let bib ← IO.FS.readFile "../references.bib"
    IO.FS.writeFile "../docs/latex/references.bib" bib
    IO.FS.writeFile (standaloneDir / "references.bib") bib
  return code
