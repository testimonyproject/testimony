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
| `Testimony.Checks.*` | Checks a package runs over its arguments, in its build: `Refutations`, that `establish` fails, as not Horn, on every package it refutes; `Meanings`, `Ontology`, `Postulates`, and `Aif`. Each takes a namespace. The library runs them over `Fixture`, a small case of its own |

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
| `argtex` | `docs/latex/arguments.tex` | the same harvest as `argdoc` |
| `statusgen` | the marked block in `docs/src/roadmap.md` | every `@[headline]` result |
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
tables and MathJax on the site, `longtable` and `\cite` in print.

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
