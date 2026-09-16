# Style guide

Conventions, and the command that enforces each one. A rule that lives only in
prose is a rule that gets broken by someone in a hurry, human or agent, and
nobody notices for months.

## The four tiers

Run them in this order. Each catches what the previous one cannot.

| Tier | Command | Catches |
|---|---|---|
| 1 | `lake build` | Missing docstrings, Lean style linters |
| 2 | `lake lint` | `docBlame`, `docBlameThm`, `unusedArguments`, `checkType`, `synTaut` |
| 3 | `lake exe axiom-audit` | `sorry`, `native_decide`, undeclared axioms |
| 4 | `python3 scripts/testimony_lint.py` | The project-specific rules below |

Plus `lake exe bibgen --check` for generated-file drift.

**`lake build` passing is not "it builds".** Three further gates exist, and
tier 3 in particular catches things nothing else will — a `decide` proof that
silently fails and falls back to `sorryAx` produces a *successful build*.

## Naming

- `lowerCamelCase` for definitions, `snake_case` for theorem names, after
  mathlib convention.
- **Scripture-reference defs are the one exception**: `micah5_2`,
  `isaiah7_14`, `matthew1_23`. The underscores are meaningful — they are
  chapter and verse. These carry `@[nolint defsWithUnderscore]`, so the
  exception is declared rather than silent.
- Atom constructors read as `passage` + `claim`:
  `romans3_28`, `worksOfLawMeansWorksGenerally`, `timothy3_16GodBreathed`.
- Citation keys are `family-shorttitle-year`: `france-matthew-2007`,
  `na28-2012`.

## Docstrings

Required on every declaration — enforced by `linter.missingDocs` at build time
and `docBlame`/`docBlameThm` in `lake lint`. `docBlameThm` is *disabled by
default* in Batteries and deliberately enabled here.

This is not decoration. A docstring in this library states what a premise
asserts and who holds it, so an undocumented premise is very nearly an uncited
one, and a theorem asserting a theological result must say what it claims.

- **Atoms and premises**: what is asserted, *and which tradition asserts it*.
- **Packages**: which position it encodes.
- **Headline theorems**: what it does and does not establish.
- **Module docstrings**: the layer, the purpose, and — for argument modules —
  a prose statement of the dispute. `BornOfAVirgin.lean` is the model.

The one exception is `Book`, where `missingDocs` is disabled for that
declaration alone with the reason recorded inline: a constructor named
`genesis` is documented by its name.

## Encoding

- **Rivals are not optional.** An argument module encoding a Christian reading
  without at least one rival package is incomplete, not merely unpolished.
  Write the rival *before* proving anything. Rule L5 enforces this.
- **There is no atom budget.** Entailment is settled by `tauto` and refuted by
  named countermodels, neither of which enumerates valuations.
- **State reduced packages explicitly**; do not filter premises out of an
  existing package.
- **Name your countermodels after the position they encode.** A countermodel is
  the rival's reading written down, and a reader should be able to see what it
  commits to.
- **Never `native_decide`, never `sorry`.** This also rules out `bv_decide`,
  which adds a per-theorem native axiom.

## Layout

Line width at most 100 columns; no trailing whitespace.

## Domain linter rules

`scripts/testimony_lint.py`, tier 4. Every rule has a test that must trip it
and a test that must not — a linter that silently stops firing is worse than no
linter.

| Rule | Check |
|---|---|
| L1 | No `sorry` or `admit` |
| L2 | No `native_decide` |
| L3 | `BibEntry` values are defined only in `Testimony/Bib/Works.lean` |
| L4 | Every `BibEntry` definition carries `@[bib_entry]` |
| L5 | An argument module encodes at least one rival package |
| L6 | Every `@[headline]` theorem is followed by `#print axioms` |
| L7 | Citation keys match `^[a-z0-9]+(-[a-z0-9]+)*$` |
| L8 | No trailing whitespace; lines at most 100 columns |

Run its own tests with `python3 scripts/test_testimony_lint.py`.

## `@[headline]`

Marks a result the library actually claims, as against a supporting lemma. It
makes "what does this library assert?" a greppable question, and rule L6
requires every headline result to display its trust base with `#print axioms` —
documentation in the source for a reader of the argument, where the axiom audit
is the gate for CI.
