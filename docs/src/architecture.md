# Architecture

Testimony models arguments in layers. The guiding rule: **formal validity and
truth of premises are different things**, and the library's job is to keep that
boundary visible at all times.

## Principles

1. **Conditional analysis.** Every theorem has the shape *given premise package
   P, conclusion C follows*. No premise is smuggled in.
2. **Rival interpretations are first-class.** Divergent conclusions are a
   feature. An argument module encoding a Christian reading without at least
   one rival package is incomplete.
3. **Relation types are not collapsed.** Quotation ≠ allusion ≠ typology ≠
   prediction ≠ retrospective interpretation. Much of the messianic-prophecy
   debate is precisely about which of these a given link is.
4. **Provenance everywhere.** Enforced by the elaborator, not by review: see
   [Citations](./citations.md).
5. **Assumption manifests are generated**, never maintained.
6. **Canon is a parameter.** Results are relative to a declared canon.

## The layers

| Module | Contents |
|---|---|
| `Testimony.Text` | `Book`, `Passage`, `Pericope`, `PassageRange`, `Canon`, `TextualTradition` |
| `Testimony.Scripture` | Named passages, citation bundles, and the `Source` helpers arguments share |
| `Testimony.Bib` | Typed bibliography entries, the `@[bib_entry]` registry, BibTeX and Markdown rendering |
| `Testimony.Provenance` | `Reference`, `Source`, `Tradition`, `Confidence`, `PremiseKind` |
| `Testimony.Intertext` | `RelationType`, `IntertextEdge`, `Interpretation` |
| `Testimony.Logic` | Formula type, entailment, independence and countermodels, `ArgumentPackage`, manifests, `Line` lines of reason, the `establish`/`refute_with`/`satisfied_by`/`leaves_open`/`granted` tactics, `Horn`, which decides who defeats whom, `Solver`, which decides what survives, and `Witness`, which states why, `Verdict`, which renders the why from the witness, `Support` and `Map`, which draw who stands with whom, `Because`, which says why one position stands against another, and `Burden`, which says what an opponent must reject to overturn a case |
| `Testimony.Argument` | `FulfillmentCriterion`, `MessiahDefinition`, `Satisfies`, `MeetsDefinition` |
| `Testimony.Logic.Page` | `Item` — what a generated page is made of, before either rendering |
| `Testimony.Logic.Latex`, `Testimony.Logic.Markdown` | The two renderings of it: traditional notation for print, and the same notation for the browser |
| `Testimony.Tools.*` | What a package's generators are made of: `Pages`, the harvest its site and its PDF share, `Site` and `Status`, which set the pages and the status table, `Bibliography`, and `Docs`, a catalogue's entries |
| `Testimony.Logic.Aif` | Every dispute as an Argument Interchange Format graph, and AIF's Definition 1.1 as a check (see [Standards](./standards.md)) |
| `Testimony.Semantics.Upper` | The upper categories a term can name — DOLCE's, each with its BFO counterpart |
| `Testimony.Checks.*` | Checks a package runs over its arguments, in its build: `Refutations`, that `establish` fails, as not Horn, on every package it refutes; `Meanings`, `Ontology`, `Postulates`, `Aif`, and `Readers`, that every reading past the text and every line's step cites a reader or is marked the library's own (`Reference.proposal`). Each takes a namespace. The library runs them over `Fixture`, a small case of its own |

## The library, and the packages built on it

The library is the machinery for representing and checking arguments: the
logic, the provenance types, the vocabulary and its ontology, the solver, the
checks and the generators. Everything an argument needs from it is public, and
a package built on it uses that and nothing else: it requires the library as a
Lake dependency, imports it, and keeps its own works, unfold sets, checks and
documents.

There are two. **`TestimonyArguments`**, in `arguments/`, holds the worked
arguments this documentation presents: their claims, sources, packages,
disputes and verdicts, what each claim means, the articles examined against
them, the works they cite beyond the library's, their unfold sets, and the
library's checks run over them. Its generators write the generated files below
into the repository's `docs/`. **`TestimonyExamples`**, in `examples/`, holds a
case from outside theology (see [Beyond theology](./beyond-theology.md)), with a
document of its own that is not in this book's index.

| Package | Directory | Module root | Holds |
|---|---|---|---|
| `Testimony` | the root | `Testimony` | the machinery, and a fixture its checks run over |
| `TestimonyArguments` | `arguments/` | `TestimonyArguments` | the worked arguments, and the generators of this book's argument pages, status table, bibliography and PDF |
| `TestimonyExamples` | `examples/` | `TestimonyExamples` | the grits case, and its PDF |

Each package requires the library by path, shares its downloaded dependencies,
and is built and checked in CI after it, through the same gates. The library
knows nothing of either: it imports neither, and names no argument. An argument
module's own path is `arguments/TestimonyArguments/<Argument>`, and its
namespace is `TestimonyArguments.<Argument>`.

## Two structural enforcements

The library's central rule — nothing is asserted bare — is enforced twice, at
two levels, by making the bad state unrepresentable rather than by checking for
it.

**`Source.primary` is a single required `Reference`**, not a possibly-empty
list. An uncited `Source` cannot be written down. There is no free-text escape
hatch, because an escape hatch would be used.

**`ArgumentPackage.cite` is a total function** from atoms to their metadata. An
atomic proposition without a citation does not compile.

Neither of these requires a linter, a review checklist, or a proof obligation
at the use site. They are consequences of the types.

## The documentation is generated from the library

Four executables of the arguments package write files that live in the
repository, and each has a `--check` mode CI runs, so a committed copy that has
fallen behind the source fails the build rather than misleading a reader. They
run in `arguments/`, and each is a few lines over a library module that any
package could call (`Testimony.Tools.Site`, `Status`, `Bibliography`, and
`latexDocument` in `Pages`).

| Tool | Writes | From |
|---|---|---|
| `bibgen` | `references.bib`, `docs/src/bibliography.md` | the library's `@[bib_entry]` registry and the arguments' |
| `argtex` | `docs/latex/arguments.tex`, `docs/latex/arguments/<slug>.tex` | the same harvest as `argdoc` |
| `statusgen` | the marked blocks in `docs/src/roadmap.md` and `docs/src/maturity.md` | every `@[headline]` result; what the meanings, ontology and fallacy checks reach in each argument |
| `argdoc` | `docs/src/arguments/*.md`, the marked block in `docs/src/SUMMARY.md` | every documented declaration in an argument's namespace |

`argdoc` and `argtex` are the two that read the *prose*. An argument module is
written as a literate document — a module docstring saying what the dispute is,
`/-! ### … -/` blocks marking its sections, a docstring on every package, line
and result — and `Testimony.Tools.Pages` walks the environment for all of it, in
source order, interleaving the module docstrings with the declarations they
introduce. What a reader meets, on the site or in the PDF, is the file typeset:
the same paragraphs, with the formulas set as notation and the atoms numbered
against one legend for the whole argument.

The two tools share that harvest rather than each doing their own, so the page
and the PDF are two settings of one text. Only the setting differs: Markdown
tables and MathJax on the site, `longtable` and `\cite` in print. Both name a
cited work by author and year, both abbreviate the "held" column alike, and
both link each variable in a formula to its row in the legend. Both set a
derivation as a list of rows, each formula followed by its claims in the
legend's words: a premise by what the position holds, a step by what it would
give, and the turnstile row by the conclusion at issue. The words come from one
function, `Latex.inWordsWith`, so the two settings cannot come to say different
things.

`argtex` sets the arguments twice. `arguments.tex` is the book, every argument in
one document. Under `docs/latex/arguments/` each argument is set again on its
own, `sola-fide.tex` for sola fide, for a reader who wants one argument and not
the rest. Nothing has to be added to let an argument stand alone. Each variable
links to a row of its own argument's legend, no argument refers to another by a
label, and BibTeX lists only the works a document cites, so each document's
bibliography is its own.

Only the `.tex` files are committed, so the PDFs have to be made somewhere. The
`PDF` workflow (`.github/workflows/pdf.yml`) typesets them with `tectonic`, along
with the examples' documents, on every pull request that touches what they are
made from, and a LaTeX error fails there rather than on `main`. The `Docs`
workflow puts the PDFs beside the site: the book at `pdf/arguments.pdf`, and
each argument at `pdf/arguments/<slug>.pdf`. Every argument's page links to its
own PDF and to the book. The `Release` workflow attaches all of them to the
GitHub release a `v*` tag makes.

Each document also names the people behind its arguments: under the title of an
argument printed alone, and in the book under each argument's heading, with
everyone under the book's title. The names come from git history, and they are
worked out when the PDF is typeset, by `scripts/credits.py`, not written into
the committed `.tex`. The `.tex` only asks for them (`\credit{…}`), and the
script writes a `credits.def` beside it that answers. The reason is when the
credit is decided. Many commits here are authored by Claude and name no person,
and such a commit is credited to whoever merged it. So the credit changes at the
moment a pull request merges, and a committed document holding it would be
stale on `main` from then on.

A commit counts for an argument if it touches the argument's own Lean sources,
where they live now or where they lived before the arguments became a package
of their own. Regenerating a page touches no source, so it credits no one, and
works shared between arguments are not divided among them. Names pass through
`.mailmap`, so one person spelled two ways is listed once. Claude is not listed
as an author. Where it took part, the credit says so on a line of its own,
"Written with Claude Code". The script refuses a shallow clone, because a
history cut short would drop credit for the older work without saying so, so the
`PDF` workflow checks out the whole history.

Under the title, each document gives the date and version of its edition: the
release's tag where there is one, and otherwise the short hash of the commit it
was made from, dated by that commit, so one commit always makes the same
edition. Its last section, "How this edition was made", says in plain words
what made it, which paper the copy is set on, and every step to make it again
from the commit to check out, ending in one command for A4 and one for US
Letter. These come from `scripts/edition.py`, which writes an `edition.def`
beside each document when it is typeset, for the reason the credits do: the
commit is not known when the `.tex` is generated. A pull request's PDF is
typeset from GitHub's trial merge, so it says it is a preview of that pull
request. A copy typeset without the file says it is unrecorded.

An argument's catalogue entry can carry an abstract, a paragraph for a reader
with little time, set under the title of its own document and under its heading
in the book.

### An argument set as chapters

A long argument reads better as a book than as one page. Its catalogue entry
(`Argument.chapters`, in `arguments/TestimonyArguments/Tools/Catalogue.lean`)
lists its chapters in reading order, each with a title in the reader's words and
the modules it is made of. Each chapter becomes a page of the site, nested under
the argument in the summary, and a `\subsection*` of the PDF. The first chapter
is the argument's own page, and one chapter, usually an appendix, carries the
table of numbered claims that every formula refers to.

A chapter is the modules' *prose*, their module docstrings, followed by "How
this is checked": every declaration of those modules, each with its docstring
and its formula or statement, folded away on the site. So a module is written as
a chapter. Its opening docstring and its `/-! ### … -/` sections are what a
reader reads. A section that only organises the declarations under it, a
heading with no prose, goes behind the chapter, and so does a section opened
with `####`, which is how a module marks a passage that is about the machinery
rather than the argument. `argdoc` fails if the outline leaves out a module or
names one twice. Prose that names another chapter in quotation marks, `the
chapter "Weighing the positions"`, or by the part of its title before a colon,
`"James 2:24"`, is set on the site as a link to it.

That is why there is no hand-written page describing an argument. There is
nothing to keep in step, because there is no second copy — the docstring is the
documentation, and `--check` fails if what is committed is not what the source
now says.

## Dependencies

The library depends on
[FormalizedFormalLogic/Foundation](https://github.com/FormalizedFormalLogic/Foundation)
for its propositional syntax and semantics, and transitively on Mathlib,
doc-gen4 and axiom-audit. Foundation pins Lean v4.33.1.

Foundation supplies the formula type, the Hilbert systems, the Boolean and
Kripke semantics, and the metatheory; Testimony reimplements none of it. What
Testimony adds is the provenance layer over the formulas, lines of reason, and
the `establish`/`refute_with`/`satisfied_by`/`leaves_open`/`granted` tactics
that settle
entailment, refutation, satisfiability and independence —
explained in [Encoding arguments](./logic.md).
