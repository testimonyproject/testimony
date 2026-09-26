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
| `Testimony.Logic` | Formula type, entailment, independence and countermodels, `ArgumentPackage`, manifests, `Line` lines of reason, the `establish`/`refute_with`/`satisfied_by`/`leaves_open`/`granted` tactics, `Horn`, which decides who defeats whom, `Solver`, which decides what survives, and `Witness`, which states why, `Verdict`, which renders the why from the witness, `Support` and `Map`, which draw who stands with whom, and `Because`, which says why one position stands against another |
| `Testimony.Argument` | `FulfillmentCriterion`, `MessiahDefinition`, `Satisfies`, `MeetsDefinition` |
| `Testimony.Arguments.*` | The worked arguments. A large one is a directory — `Atoms`, `Sources`, `Lines`, `Packages`, `Results` |
| `Testimony.Logic.Page` | `Item` — what a generated page is made of, before either rendering |
| `Testimony.Logic.Latex`, `Testimony.Logic.Markdown` | The two renderings of it: traditional notation for print, and the same notation for the browser |
| `Testimony.Tools.*` | The generators — `Bibgen`, `Argtex`, `Statusgen`, `Argdoc` — over `Docs`, the catalogue they share, and `Pages`, the harvest the two document generators read |
| `Testimony.Checks.*` | Checks that run in `lake build` over every argument: `Refutations`, that `establish` fails, as not Horn, on every package the library refutes |

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

Four executables write files that live in the repository, and each has a
`--check` mode CI runs, so a committed copy that has fallen behind the source
fails the build rather than misleading a reader.

| Tool | Writes | From |
|---|---|---|
| `bibgen` | `references.bib`, `docs/src/bibliography.md` | the `@[bib_entry]` registry |
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
