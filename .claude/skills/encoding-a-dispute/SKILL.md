---
name: encoding-a-dispute
description: Use when setting positions of a Testimony argument against each other — declaring a dispute and its defeat table, rating the claims and steps that decide it, stating verdicts with their witnesses, adding hearings, explaining a defeat with a Because or an absence with Grants, listing an opponent's burden — or when a defeat, a tie or a derived attack needs explaining to a reader. Covers what a defeater is here, the rating rule, and how to report a verdict whichever way it goes.
---

# Encoding a dispute, its defeaters and its verdicts

A dispute answers the reader's question "who prevails?" A position **attacks** another when
what it holds cannot be held with one of the other's premises, its conclusion, or a claim one of
its steps delivers. The attack is a **defeat** unless what it attacks is strictly stronger, and a
position is as strong as its weakest link, premises and steps alike. So ratings decide disputes,
and the whole discipline of this skill is that ratings, readings and verdicts are never tuned.

`docs/src/logic.md` ("Disputes") is the reference for the API. This skill is the order of work
and the rules that keep the result honest.

## 0 — Before declaring anything

- **Every party is a complete line of reason.** Each claim cited, each step with an
  `inference` naming who draws it or a `Reference.proposal` with its rationale, each claim
  given a meaning (`encoding-meanings`). A party whose claims are unanalysed is heard as if it
  had no hidden conditions, because `#check_conditions` cannot read it.
- **The rival is written first**, from its holders' own words, quoted with the place.
- **Every party is an argument.** Its premises have a model and establish its conclusion. A reply
  is its own `Line` delivering what the reply concludes, never an objection with a premise taken
  away.
- **Each line delivers what its text says.** A strand from Luke 7:50 delivers "faith saves", not
  "faith alone justifies". An over-claim creates attacks the literature does not have.

## 1 — Rate by the rule, and audit before trusting

Each claim and each step carries a `Confidence`. The rule:

- a step or claim is `disputed` when a cited reader **grants its grounds and denies its
  conclusion**;
- every "X denies it" in a docstring gives X's reason in the same sentence, quoted, with its
  place; where no reader has been read who denies it, the docstring says so;
- a rating never moves because more people hold a view, and never to make a verdict come out.
  It moves with a new, cited argument, and the pull request says which.

Before rating anything above `disputed`, run the `rating-auditor` agent on it: it looks for the
reader who grants the grounds and denies the conclusion. A rating that would move a verdict is
audited whatever its level.

## 2 — Declare the dispute

Use `declare_dispute` (`Testimony/Logic/Declare.lean`): the party enumeration, each party's
package, the unfold set, and three tables (defeats, supports, part-of) as lists of pairs, plus
the map. Every cell is decided and checked by the kernel, so a wrong pair does not build.

Do not guess the table. Write the defeats you expect, build, and read the error: it names the
cell and what the engine found. Then change the table, never the encoding. For a large table use
`rows N` and `pruned`, as sola fide does.

Then check the **derived attacks** on the page (supported, secondary, on a part) that are not
already defeats. Each is a modelling question: either a case claims more than its sources, and
the line is re-encoded to say what its text says, or the attack is real and a verdict must move.
Decide which from the sources, and say so in the module docstring.

## 3 — State each verdict with its witness

`declare_verdict` takes the verdict's claim and its witness: the stages of a grounded set, the
defeater of a party that cannot be defended, the admissible set that leaves a party out. Ask the
untrusted finders for a witness (`#eval Witness.findSkeptical F a`, `findIndefensible`,
`findDefeaters`, `findStages`, `findUnanswered`), copy what they return, and let the kernel check
it. The page renders the reason from the witness, so the docstring must say what the witness
says. A docstring that drifts from its witness is visible on the page.

Name the result for what it establishes (`to_1520_purgatory_stands_and_the_treasury_ties`), and
mark it `@[headline]` only if a reader would ask the question it answers.

## 4 — Answer the reader's "why"

A verdict says who. Each follow-up question has one construction, and each is worth building
only if a reader asks it:

| The reader asks | Build | Module |
|---|---|---|
| Where exactly do these two part? | `Because P R`: the crux, the core of `R` that breaks, and the crux's role (`derives` or `answers`), proved | `Logic/Because.lean` |
| Why does this one *not* answer that one? | `Grants a φ` with a named reading, via `satisfied_by` | `Logic/Dispute.lean` |
| What would an opponent have to give up? | `OpponentsBurden`: every minimal set of readings to reject | `Logic/Burden.lean` |
| What if the rival's claim means two things? | a `Dilemma`, every reading answered (`encoding-a-dilemma`) | `Logic/Dilemma.lean` |
| What if only these were heard? | `declare_hearing H := D only [...]`, with its own verdicts | `Logic/Declare.lean` |
| What if each side's standard of evidence were applied? | `declare_rerated` | `Logic/Credibility.lean` |
| How did the exchange go, in order? | a bundle (`historical-framing`) | `Logic/Bundle.lean` |

Write a `Because` for every defeat a page's prose leans on: the page then links the defeat to it.
Write a `Grants` wherever the absence of a counter is something a reader would ask about ("why
does Postell's step not touch the critic?").

## 5 — Report what the solver computes

The verdict is the verdict. If it ties where the argument's author hoped it would prevail, the
page says it ties, and says at which `disputed` links. If a new party or rating moves a headline
verdict, the first line of the pull request says so. The words for a verdict are the solver's:
"forced", "can be defended", "cannot be defended", "each defeats the other, so neither gives
way". "Cannot be held against P at a disputed crux" is never "refuted".

## 6 — Write it for the reader

The dispute's module docstring states, before any code: who the parties are, in their holders'
words; which ratings decide the outcome, and that a changed rating could reverse it; what each
side takes as its ground truth (Scripture alone; Scripture with tradition and the teaching office);
and the verdicts in plain sentences. No Lean appears on the page: the generator renders each
declaration in words, and a declaration with no rendering in words fails the build.

## Checklist

- [ ] Every party is complete: cited claims, steps with readers or proposals, meanings.
- [ ] Every rating follows the rule; every denial quotes its reason; anything above `disputed`
      was audited.
- [ ] The table was computed, not chosen; derived attacks checked and explained.
- [ ] Each verdict has a witness, a name that says what it establishes, and a docstring that
      matches the witness.
- [ ] A `Because` for each defeat the prose explains; a `Grants` for each absence a reader asks
      about.
- [ ] Any moved verdict is in the first line of the pull request.
