# Reviewing a pull request to Testimony

Instructions for reviewing changes to this repository. `CLAUDE.md` holds the
project's rules; this file says what a review must look for and what it should
leave alone.

The project is two things: a guide for lay people reading an English Bible, in
language precise enough that a theologian can work with it; and a code library
for encoding arguments and checking them for consistency. A review serves both.
CI already runs the build, the linters, the axiom audit and the generated-file
checks, so do not repeat what they catch. Look for what they cannot.

## What Important means here

Report as Important anything that would mislead a reader of the published
pages or weaken trust in a checked result:

- **Prose that disagrees with a result.** A docstring or page that describes a
  verdict the theorems no longer state: a strand count, a party count, "forced"
  where the result says "defensible", a tie described as a win. Compare each
  changed result with every paragraph that describes it, including hand-written
  pages under `docs/src/` and the module docstring of the argument.
- **A result that says more than its theorem.** The docstring claims something
  the statement does not prove, or omits what the result does not claim.
- **An encoding tuned toward a verdict.** A rating raised without a new cited
  argument; a cited reader removed or weakened; a rival written so that it
  loses; a premise list retyped instead of varied with `Line.onGrounds`.
- **A rival misdescribed.** A position stated in words its holders would not
  accept, or cited only from its critics.
- **An unverified citation.** A new ISBN, DOI, page range or quotation with no
  sign it was checked against a public catalogue or text. A missing identifier
  is acceptable; a guessed one is not.
- **An entailment over premises not shown consistent**, `sorry`,
  `native_decide`, `bv_decide`, or a raised `maxHeartbeats`.
- **Hand edits to generated files**: `references.bib`,
  `docs/src/bibliography.md`, `docs/latex/arguments.tex`,
  `docs/src/arguments/*.md`, and the marked blocks in `docs/src/roadmap.md` and
  `docs/src/SUMMARY.md`.
- **Collapsed relation types**: a quotation recorded as an allusion, typology
  as prediction, or a disputed case given only one of its readings.

## Always check the prose

For every changed docstring under `arguments/TestimonyArguments/` and every
changed page a visitor reads, check it against
`docs/src/writing-for-readers.md`. Report as Important:

- a Greek, Hebrew or Latin term with no English beside it;
- a technical word, theological or logical, used with no gloss on a page where
  it has not been explained;
- a sentence that cannot be understood without knowing what a source
  identifier means;
- a headline result whose docstring does not say what it does not claim.

Report as a Nit: a sentence that could be shorter, a contrast that could be a
plain statement, a paragraph that announces its own importance.

## Cap the nits

Report at most five Nits per review, the five that would most help a lay
reader. Do not report formatting, line width, import order or naming: the
linters hold those.

## Do not report

- Anything in a generated file, except that it was edited by hand or is out of
  date with its source.
- Changes to pinned counts in `arguments/TestimonyArguments/Checks.lean` that
  follow from an added package, party or definition in the same pull request.
- Benchmark timings, unless the pull request claims a speed-up or adds an
  entry to `arguments/bench/accepted.toml`; then check that the reason given
  is true of the change.
- Theological disagreement with a premise. Every premise here is some cited
  reader's. The question for review is whether it is that reader's, fairly
  stated and correctly rated, not whether it is true.

## When a verdict moves

If a headline result's statement changes, or a dispute's verdict does, say so
at the top of the review in one sentence a non-programmer can read: what the
library said before, what it says now, and which change caused it.
