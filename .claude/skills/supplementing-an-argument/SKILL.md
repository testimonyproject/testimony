---
name: supplementing-an-argument
description: Use when strengthening or deepening an existing argument in the Testimony library for its readers — finding where a dispute actually turns, researching a premise that could be better than disputed, auditing its rating honestly, answering a rival's ambiguous claim, or adding hearings that answer a reader's narrower question. Covers the research workflow, the rating rule, the agents to delegate to, and how to report a verdict that moves either way.
---

# Supplementing an argument

An argument in this library is never finished: a reader asks a sharper question,
a scholar supplies a better premise, a rival's claim turns out to mean two
things. This is the workflow for improving one, learned on sola fide (the
`Gospel`, `Definition` and `Hearings` modules), where it moved headline verdicts
in both directions.

The goal is a page a theologian or a lay Christian can follow, and a verdict
they can trust because nobody tuned it. Everything below serves one or the
other.

## 1 — Start from the reader's question

Write the question down in the reader's words before touching Lean:

- "Where exactly do Trent and Paul part?"
- "Is Trent's definition a claim about Paul's word, or about what God does?"
- "If Trent were not heard, would Scripture establish sola fide?"

The question picks the construction (see `encoding-an-argument`, "Explaining a
result"): a `Because`, a `Dilemma`, an `OpponentsBurden`, a `Verdict`, or a
hearing. If no question needs it, don't build it.

## 2 — Locate the crux before researching

Build the `Because` first. It names the one step the disagreement turns on and
the core of the rival that breaks there. That step, and its rating, is what the
research is for. Research without a located crux produces citations, not
arguments.

If the rival's premise is ambiguous — it can be read as a claim about a word or
about a reality, about a text or about a doctrine — build the `Dilemma` instead,
and research each horn separately. The horns usually meet different kinds of
evidence.

## 3 — Research a better-than-disputed premise

A dispute where every weakest link is `disputed` ties, and ties are honest. A
tie moves only when some link is shown, from sources, to be better than
disputed. Look for grounds that do not depend on either side's authority:

- **Lexical**: what the word denotes, from the standard lexicon and scholars
  across traditions (BDAG, and a Catholic and a Protestant exegete at least).
- **Exegetical**: what the passage's own argument does — how the author glosses
  the term in context (Romans 4:6–8 glossing counted righteousness by Psalm 32).
- **Methodological**: principles of reading that both sides accept, entered as
  cited premises (least meaning: Joos, Silva; Barr's totality transfer). **No
  razor goes into the solver**: a principle built into the semantics would
  decide cases without appearing on the page.
- **Historical**: why the rival reads as it does (Augustine's Latin gloss, the
  Vulgate declared authentic at Session IV). This does not strengthen the
  argument; it makes the rival's position intelligible, which is fairness.

Delegate identifier and quotation checks to the `source-verifier` agent, and
read primary texts yourself where they are public (CCEL, Hanover, Crossref).
Never invent an identifier, a page, or a quotation; cite `.whole` when a
location cannot be verified. See `adding-a-citation`.

## 4 — Audit the rating before trusting it

The library's rule: **a step is `disputed` when a cited source grants its
grounds and denies its conclusion.** Before rating anything above `disputed`,
delegate to the `rating-auditor` agent: who reads the same texts and denies the
conclusion? The strongest rival reader, not the weakest.

- If one exists, the step is `disputed`, and the finding goes in the docstring
  (Augustine grants Romans 4:5–8 and reads "justifies the ungodly" as making the
  ungodly godly).
- If dissent attacks a *ground* instead, it is weighed in that ground's rating,
  not the step's (VanLandingham denies the forensic sense itself).
- If dissent is about a different claim — the reality rather than the word —
  say so, and check whether it is a horn of a dilemma.

Never drop a cited reader because we judge him mistaken. Show where his reading
breaks (`whereTheLatinReadingFalls`), or accept that it does not.

## 5 — Let the solver compute, then write it down

Encode the new premises and parties, then compute before asserting: evaluate
`Horn.defeats?` over every pair, and the grounded and preferred extensions, in a
scratch file or a short script over the computed table. Write the defeat table,
the verdicts and their witnesses from what came out. The kernel then checks
them against the premises; if the build fails, the prose was wrong, not Lean.

Scratch files go outside the source tree and are deleted after.

## 6 — Report whichever way it goes

A supplement can move a verdict against the argument's author. Say so plainly,
in the module docstring, the dispute's introduction, the roadmap paragraph and
the PR. The sola fide supplement made one thing prevail outright — Paul's word —
and left sola fide *not forced*, even with Trent set aside, because of three
disputes inside modern Pauline scholarship. Both halves go on the page.

## 7 — Add hearings for the reader's narrower questions

A full dispute answers a crowded question. A hearing, `D.restrict P`, answers
"what if only these were heard?" with the full dispute's defeats. Add one when a
reader's question names a subset of the parties: the Reformation alone; the
dispute without Trent. Each hearing gets its own verdicts, with witnesses, and a
docstring saying what it sets aside and why a reader would ask.

## 8 — Update the prose that describes the result

Every module docstring, dispute introduction, roadmap paragraph and
`docs/src/logic.md` passage that describes a verdict you moved. Linter rule L9
catches a name that no longer exists; a paragraph that still *describes* the old
verdict is yours to catch. Then run every gate (`checking-the-build`), and have
the `reader-review` agent read the regenerated page before opening the PR.

## Words that mislead a reader

Found by the first `reader-review` pass on sola fide; each was a sentence that
contradicted a theorem on the same page.

- **"Everything else is defeated by someone it does not answer."** False for a
  standoff: two parties that defeat each other each *answer* the other. Say
  "attacked by someone the dispute cannot rule out", and name the standoffs.
- **"It falls to …"** for a break at a `disputed` crux. A reader hears
  "refuted". Say "cannot be held with …", and add who grants the crux and who
  denies it.
- **"X's gloss cannot be defended"** when the gloss is a `consensus` premise and
  only the step from it breaks. Say which link breaks.
- **"Independent routes"** when the routes share a premise. Name the shared
  premise: a reader who denies it denies both.
- **"Unread"** for a position taken at face value. Say "as it states it, tied to
  neither reading".
- **Unexplained terms**: grounded, admissible, credulous, weakest link. A
  dispute's module docstring carries a plain key ("How to read the verdicts"),
  and verdict docstrings use "forced", "can be defended", "not forced".
