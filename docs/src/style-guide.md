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

Plus `lake exe bibgen --check`, `lake exe argtex --check`,
`lake exe statusgen --check` and `lake exe argdoc --check` for generated-file
drift.

**`lake build` passing is not "it builds".** Three further gates exist, and
tier 3 in particular catches things nothing else will — a `decide` proof that
silently fails and falls back to `sorryAx` produces a *successful build*.

## Naming

- `lowerCamelCase` for definitions, `snake_case` for theorem names, after
  mathlib convention.
- Lines of reason are named `<strand>Line`: `isaianicLine`, `paulineLine`.
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

## Pedagogy

**Write for a reader who knows the theology and not the logic.**

[Contributing](./contributing.md) says the review this project most needs is the
one only a theologian or biblical scholar can do, and that it requires no Lean.
That promise is only kept if the encoding explains itself. A proof that nobody
competent to judge the *theology* can read has not been reviewed; it has only
been checked.

So: assume no logical training, and never leave a technical notion to be
inferred.

- **Elucidate where you use it, or link an explainer.** The primer is
  [Reading the logic](./reading-the-logic.md). Prefer linking it to
  re-explaining the basics; extend it when an argument needs a notion it does
  not cover.
- **A countermodel's docstring says what the reading *is*.** Not "the valuation
  refuting X" — the position, in the words its holders would use.
  `tridentineReading` is "everything else stands, and scripture is not the sole
  infallible rule", which a reader can evaluate. A valuation described as a
  valuation tells them nothing.
- **A model's docstring says whose world it is.** Same rule, opposite sign: the
  way things look if the position is right.
- **Gloss logical vocabulary exactly as you gloss Greek and Hebrew.** This
  library already explains ἔργα νόμου and עַלְמָה where they appear, because it
  does not assume its reader is a Semitist. "Independent", "satisfiable",
  "countermodel" and "vacuous" get the same courtesy, for the same reason.
- **A notion the primer cannot carry is a reason to reconsider the encoding**,
  not a reason to shrug. If an argument can only be stated in a fragment whose
  countermodels are unreadable, say so in the module docstring and explain them
  in prose beside the Lean.

### This one is not enforced by a command

Every other rule on this page names the check that catches it. This one cannot:
you can lint that a docstring exists — `missingDocs` and `docBlame` already do —
but not whether it explains anything. It is enforced in review, and it is the
rule most easily lost in a hurry, which is why it is written down at this
length.

## Encoding

- **Rivals are not optional.** An argument module encoding a Christian reading
  without at least one rival package is incomplete, not merely unpolished.
  Write the rival *before* proving anything. Rule L5 enforces this.
- **There is no atom budget.** Entailment is settled by `tauto` and refuted by
  named countermodels, neither of which enumerates valuations.
- **Write formulas in Foundation's notation.** `➝`, `⋏`, `⋎`, `∼`, and `⋀` for
  the conjunction of a list — not the raw constructors `.imp`, `.and`, `.or`.
  They build the same terms, but only the notation is what Foundation's
  `@[simp]` truth lemmas are indexed under, and those lemmas are where the
  proof recipes get their semantics. `p` and `notP` stay: a reader of a rival's
  premise list should not have to decode the encoding of negation. Implication
  is written `➝`, an alias for Foundation's `🡒` — see
  [Typing the connectives](#typing-the-connectives).
- **Compose arguments from lines of reason.** A strand is a `Line` — its own
  grounds, its own inference step, what it delivers — and a package is
  `caseOf lines shared closing`. A variant package is then a named difference
  (`Line.onGrounds`) rather than a retyped premise list.
- **State reduced packages explicitly**; do not filter premises out of an
  existing package. `List.filter` over a derived `DecidableEq (Formula α)` does
  not reduce in the kernel, and `Line.onGrounds` says the same thing better.
- **Name your countermodels after the position they encode.** A countermodel is
  the rival's reading written down, and a reader should be able to see what it
  commits to.
- **Never `native_decide`, never `sorry`.** This also rules out `bv_decide`,
  which adds a per-theorem native axiom.
- **Use `establish` and `refute_with`**, never the hand-written `simp only`
  recipe. See *Proof tactics* below.

## Proof tactics

`Testimony.Logic.Tactic` provides five, and they are not conveniences.

```lean
theorem christian_establishes : Establishes christian := by
  establish [christian, isaianicLine, sharedGrounds, toCriterion, toFulfilment]

theorem critical_not_establishes : ¬ Establishes critical := by
  refute_with criticalReading [critical, criticalLine, toCriterion]

theorem christian_is_satisfiable : Satisfiable christian.premises := by
  satisfied_by christianOwnReading [christian, isaianicLine, sharedGrounds]

theorem parity_leaves_the_canon_open :
    Independent canonUnderParity.premises (p .scriptureIsSoleInfallibleRule) := by
  leaves_open parityEstablishesNothingReading krugerParityReading
    [canonUnderParity, Line.onGrounds, canonObjectionLine, canonObjectionStep]

theorem circle_parity_concedes_the_charge :
    Establishes circleParityConcedingTheCharge := by
  granted [circleParityConcedingTheCharge, circleDefeats, defeatUnderParity,
    Line.onGrounds, circleDefeatsLine]
```

**`granted` is not a faster `establish`.** `establish` would close the same
goal, by searching for a proof of something that is sitting in the premise
list. The two say different things — that the conclusion *follows*, against
that it was *granted* — and where a reply concedes the charge it answers, which
it is matters more than that the goal closes.

The bracketed list names what to unfold: the package, the lines it is built
from, the inference steps. Everything generic — `caseOf`, `p`,
`notP`, the list-membership lemmas, and the semantics — is supplied by the
tactic.

**This closes a silent-failure hole.** `Formula` is an abbreviation in
`Testimony.Logic` as well as a structure in Foundation, so inside an argument
module the short name `Formula.Boolean.val` used to resolve to the wrong
namespace.
The semantics then never unfold, `simp` leaves the hypothesis alone, and the
proof term rests on `sorryAx` — with a **successful build**. Only tier 3 catches
it, and only afterwards. Written once inside a macro quotation, where
identifiers resolve at the definition site rather than the call site, the
mistake is no longer available to make.

This is the same move as `Source.primary` being a required field rather than a
review rule: make the bad state unrepresentable instead of checking for it.

`refute_with` takes an **identifier**, not a term, so a countermodel must be a
named definition. That enforces the rule above it — a countermodel is the
rival's reading written down, and an inline valuation would satisfy the checker
while telling a reader nothing. `leaves_open` takes two, in the order of
`Independent`'s two halves: first the reading on which the proposition fails,
then the reading on which it holds.

**Prefer `Independent` to a pair of refutations.** When a reply is recorded as
"it blocks the objection" and "it establishes nothing" over the *same* premise
set, those are the two halves of one independence claim and should be stated as
one. Written as a pair, nothing checks that the two halves are about the same
proposition, and a pair whose halves were not has already reached `main`. The
primer's entry is [Independence][independence].

[independence]: ./reading-the-logic.md#independence-the-premises-settle-nothing-either-way

Two premise sets asked two different questions are *not* this pattern —
`compatibility_defeats_lexical_objection` and
`compatibility_does_not_establish_criterion` range over different premise sets,
and forcing `Independent` onto them would be false.

## Typing the connectives

Write implication as **`➝`** (U+279D, TRIANGLE-HEADED RIGHTWARDS ARROW). The
other connectives are Foundation's as written: `⋏`, `⋎`, `∼`, and `⋀` for the
conjunction of a list.

**`➝` is an alias, not a divergence.** Foundation binds implication to `🡒` —
U+1F852, in the Supplemental Arrows-C block — and that is the only token it
declares. `Testimony.Logic.Notation` adds a second notation for the same class:

```lean
scoped infixr:60 " ➝ " => FFL.HArrow.hArrow
macro_rules | `($x ➝ $y) => `(binop% FFL.HArrow.hArrow $x $y)
```

Both parse to `FFL.HArrow.hArrow`, Foundation's own class, with the same
`binop%` elaborator, so nothing about the encoding diverges from Foundation
except the character on the page. It is `scoped`, so it applies where
`Testimony.Logic` is open — every module here — and nowhere else. `➝` occurs
nowhere in Mathlib, Foundation, Batteries or any other dependency, so it
shadows nothing.

**Why bother.** Foundation's `🡒` is a poor character to build a corpus on, for
two reasons that compound:

- *Almost nothing renders it.* Supplemental Arrows-C is covered by Symbola,
  Unifont and PragmataPro, and not by Fira Code, JetBrains Mono, Iosevka,
  Cascadia Code or DejaVu Sans Mono. A Nerd Font patch does not help — Nerd
  Fonts add glyphs in the Private Use Area, not in this block. It shows as an
  empty box in GitHub, in pull-request diffs, and in most editors.
- *Nothing types it.* The Lean 4 extension has no abbreviation producing
  U+1F852; `\to` and `\r` both give `→` (U+2192), which is Lean's function
  arrow and will not elaborate as Foundation's implication.

A catalogue whose whole claim is that anyone can read and contest it should not
be written in a character most readers cannot see and no contributor can type.

**Typing `➝`.** It has no built-in abbreviation either, so add one:

```jsonc
// settings.json
"lean4.input.customTranslations": { "fimp": "➝" }
```

which makes `\fimp` produce it — *f* for formula, since the arrow this
library writes is the one between formulas rather than Lean's own.

Do **not** bind `\imp`. It is already taken: `\imp` is one of six
abbreviations for `→` (U+2192), alongside `\to`, `\r`, `\r-`, `\->` and
`\rightarrow`, and a custom translation shadows the built-in one.
`\fimp`, `\impl`, `\Imp` and `\fto` are all free and share a prefix with
nothing.

Issue #66 proposes shipping the translation in the dev container, so that every
contributor gets it without configuring anything.

**None of this reaches a reader of the site.** The generated argument pages
render formulas through `Logic.Markdown` and `Logic.Latex` as `\rightarrow`, so
every published page shows an ordinary arrow whichever glyph the source uses.
This is an authoring concern only — which is exactly why it was worth fixing
cheaply.

## Layout

Line width at most 100 columns; no trailing whitespace.

An argument is one module until it approaches ~500 lines, at which point it
becomes a directory: `Atoms`, `Sources`, `Lines`, `Packages`, `Results`, with
the root module reduced to imports and the module docstring. Dependencies run
one way, so there are no import cycles. `BornOfAVirgin/` and `SolaFide/` are
the worked examples; `BornInBethlehem` and `SolaScriptura` are small enough to
stay single files, and the structure is not mandatory below that size.

Material shared *across* arguments goes further out: passages and citation
bundles in `Testimony.Scripture`, `Person` values in `Testimony.People`.

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
| L5 | An argument encodes at least one rival package — counted across its directory, not per file |
| L6 | Every `@[headline]` theorem is followed by `#print axioms` |
| L7 | Citation keys match `^[a-z0-9]+(-[a-z0-9]+)*$` |
| L8 | No trailing whitespace; lines at most 100 columns |
| L9 | No prose names a Lean result that does not exist — pages and docstrings alike |
| L10 | Every `@[proposed]` result says what is novel about it |
| L11 | A package with a positive `Establishes` result is shown satisfiable |

Run its own tests with `python3 scripts/test_testimony_lint.py`.

## Documentation moves with the argument

A change under `Testimony/Arguments/` is not finished when it compiles. The
pages that carry results — `README.md`, [Introduction](./introduction.md),
[Encoding arguments](./logic.md), [Rationale](./rationale.md), [Scope and
limits](./scope-and-limits.md), [Roadmap](./roadmap.md) — and the module
docstring of the argument itself state what the library claims, and a page
asserting the opposite of a proven theorem is the failure this project exists
to rule out. It has happened: the roadmap spent two commits saying the
virgin-birth argument was single-stranded and that its lexical premise was
load-bearing, after the theorem saying so had been replaced.

Two mechanisms hold the line, and between them they cover different halves of
the problem.

**What can be generated is generated.** The roadmap's status table is emitted
from the `@[headline]` results by `lake exe statusgen`, the way `bibgen` emits
the bibliography and `argtex` the rendered arguments. Rename a theorem, restate
it, delete it, or add one, and the table moves on the next run;
`lake exe statusgen --check` fails CI if the committed copy has not. The block
between the two `<!-- ... statusgen -->` markers in `docs/src/roadmap.md` is
generated: do not edit it by hand.

The argument pages under `docs/src/arguments/` go further: `lake exe argdoc`
writes each one whole, from the module docstrings and the declarations of the
argument's own files, and `lake exe argtex` sets the same material for print.
A docstring is therefore documentation in the ordinary sense — write it for a
reader, because a reader will meet it on the site and in the PDF — and there is
nothing to keep in step, because there is no second copy. Do not edit those
pages, `docs/latex/arguments.tex`, or the `<!-- ... argdoc -->` block in
`docs/src/SUMMARY.md`, by hand.

**What cannot be generated is checked.** Prose about *why* an argument matters
is not derivable from theorem statements, so it stays hand-written. Rule L9
then reads every result name the prose cites, in backticks or declared in a
Lean code block, and fails if the library no longer declares it. That is the
specific way the roadmap went wrong, and it is now a linter finding rather than
a matter of someone happening to reread the page.

**A docstring counts as prose.** L9 reads the `/-- … -/` and `/-! … -/` blocks
in the Lean sources as well as the pages, because `argdoc` and `argtex` publish
them verbatim — a module docstring naming a deleted result reaches the site and
the PDF exactly as a stale page would, and once did. Ordinary `/- … -/` and
`--` comments are left alone: they are notes to whoever opens the file, not
something this project publishes.

**A name the library imports counts as existing.** Prose may cite Foundation's
own results — `of_mem`, `models_imply` — and the rule reads Foundation's
declarations alongside this library's so that it does not report them missing.
Before it did, the rule pushed documentation towards describing a lemma rather
than naming it, which is the opposite of what it is for.

The generated pages under `docs/src/arguments/` are deliberately *not* read. A
stale name there comes from a docstring, which is now checked at its source,
and `lake exe argdoc --check` catches a page that has drifted from one. Reading
both would report a single defect twice and invite someone to edit a generated
file.

What is left over is judgement: whether a paragraph's *description* of a result
still describes it. Say what the encoding now does, in the same commit that
changes it.

## `@[headline]`

Marks a result the library actually claims, as against a supporting lemma. It
makes "what does this library assert?" a greppable question, and rule L6
requires every headline result to display its trust base with `#print axioms` —
documentation in the source for a reader of the argument, where the axiom audit
is the gate for CI.
