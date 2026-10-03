# Computed ratings (design)

**Status: a design, with phase one built.** `Testimony.Logic.Credibility` implements the checks
below, and `Testimony.Arguments.SolaFide.Ratings` applies them to the James steps. The solver
does not yet use computed ratings; phases two and three describe how it would.

## The question

Every inference step in the library carries a `Confidence`, and the rule for `disputed` is that
a cited source grants the step's grounds and denies its conclusion. That rule records a fact
about the literature: *someone dissents*. It does not record what a reader most needs to know
next: **is the dissent an argument, or only a disagreement?**

"You are wrong because I say so" and "you are wrong because the council says so" are dissents.
So is "you are wrong, because these texts say what your reading cannot hold". Only the last is
a critique anyone can weigh without first sharing the dissenter's allegiances. A rating that
cannot tell them apart lets a bare denial lower a well-argued step as far as a strong argument
would — and, the other way, lets an author raise a step's rating by not looking for the
strongest dissent.

So a rating should be computed: `disputed` when some dissent is **credible**, and otherwise the
rating the step's support earns.

## What makes a dissent credible

A **dissent** is a position, stated as an `ArgumentPackage`, set against a claim: a premise, or
the conclusion of a step whose grounds it is given. Five checks, each decided by the engine:

1. **Consistent.** Its premises have a model. A self-contradictory position denies everything,
   and so says nothing about this claim in particular.
2. **Denies the claim.** Its premises entail the claim's negation.
3. **Grants the grounds.** It can be held together with the step's grounds. A dissent that
   denies a ground is a dissent from *that* ground, and belongs to its rating. This is the
   library's existing rule, made a check.
4. **Argued, not asserted.** What it asserts outright — its atoms and denied atoms — does not
   already contradict the claim. The denial must need one of its own steps. A position that
   holds the claim's negation as a premise is reporting its disagreement, not arguing it.
5. **Its grounds meet the standard.** Every claim it asserts rests on a warrant the standard
   admits (`Testimony.Logic.Warrant`), and it asserts no bare denial: a denial is cited nowhere,
   so it rests on the position's own say-so.

A dissent passing all five is `Credible std d`. `Dissent.credible?` decides it, and
`Dissent.credible_of_check` turns the engine's answer into the proposition, so every result is
checked by the kernel.

## Two standards, both reported

Check 5 needs a standard, and choosing one would decide a dispute the library exists to show,
not settle. Whether a council's or a confession's word can ground a critique is the sola
scriptura question. So the standard is named and every result is computed under both:

| Standard | Admits |
|---|---|
| `evidence` | Scripture; evidence anyone can check (texts, lexica, argued scholarship) |
| `tradition` | also a council's, a confession's or a theologian's own word |

Neither admits the library's own bare assertion. The standards check a dissent's **grounds**,
never its inference: every step on every side is someone's reading, cited to a commentator, a
council or a confession, and a rule that discounted those would discount all of them alike.

A rating that differs between the standards is a rating that turns on the authority question,
and the page says so in those words. That is a finding, not a failure.

## What stays cited

Two things are still judgement, and are stated as such.

- **Support.** How broad the evidence for a step is — `plausible`, `wellSupported`,
  `consensus` — is still cited and argued in the step's docstring. What is computed is only
  whether a dissent brings it down. In time `Source.confidence` should split into the two
  things it now carries: the support rating, and a **register** of the dissents it has been
  tested against.
- **The register.** A rating computed from the dissents that are encoded is only as good as the
  dissents encoded. Hence:

> **The steelman rule.** A computed rating may stand above `disputed` only when the strongest
> known dissent is encoded *with its own grounds* and fails a check. A dissent recorded only as
> a citation proves nothing either way.

The rule makes leaving out a dissent visible. A rating above `disputed` must name the dissents
it was tested against, and a reader who knows a stronger one has a concrete thing to add: a
position, with grounds, that the engine will check.

## What phase one finds

`Testimony.Arguments.SolaFide.Ratings` and `Testimony.Articles.Howell2003` carry the results.

| Step | Dissent | Evidence | Tradition | Why |
|---|---|---|---|---|
| Works are fruit, not ground (`fruitLine`) | Trent, canon 24 | not credible | credible | "works cause the increase" rests on Trent alone |
| Works are fruit, not ground (`fruitLine`) | Trent, ch. 16, from the reward texts | credible | credible | grounds are Scripture; the denial is Trent's step |
| James's δικαιόω is not the increase (`jamesLexicalLine`) | Trent, on the word | not credible | not credible | asserts the increase as a premise |
| James's faith is not the Reformers' (`jamesFaithLine`) | Howell (2003) | not credible | not credible | asserts the denial as a premise |

So:

- **"Fruit, not ground" is disputed under both standards** (`fruit_step_disputed`). This is a
  result against the Reformed side, and it is reported as one. Canon 24 alone would leave the
  rating turning on the authority question (`canon24_alone_turns_on_authority`); chapter 16's
  reading of 1 Corinthians 15:58, Hebrews 6:10, Hebrews 10:35 and 2 Timothy 4:8 is a critique on
  Scripture's own ground, which Westminster answers (XVI.6) with a different reading of the same
  texts. That contest is between two steps, and a hearing decides it, not this check.
- **Trent's reading of James's word, and Howell's move, are disagreements, not critiques**
  (`trent_on_the_word_is_asserted`, `howell_asserts_his_denial`). Each holds the denial it
  needs as a premise.
- **The lexical step is not thereby raised.** Against the register as encoded its computed
  rating is its support (`word_register_leaves_support`), but its strongest dissent — that James
  uses δικαιόω as Paul does, and Paul's denotes renewal, as Augustine read it — is not yet
  encoded. The steelman rule withholds a rating above `disputed` until it is.

## Phase two: the solver uses computed ratings

`Dispute` reads each step's `Confidence` to decide which attacks survive as defeats. In phase two
a dispute is built under a declared `Standard`, and each step's strength is `computedRating` of
its support under that standard and its register. Every hearing then runs twice, once per
standard, and a verdict that differs between the two is reported as turning on authority.

This is not circular. A dissent's credibility (checks 1–5) depends on entailment and warrant
only, never on ratings, so the computed ratings are fixed before the solver runs.

## Phase three: when the dissent must also survive

Phase one does not ask whether a credible dissent can be *defended*: whether, heard against
everything else the library holds, it survives. That is the sixth check one wants, and
`Contested` and `DenialAnswered` (`Testimony.Logic.Contest`) already report it after the fact.

Folding it into the computation is circular — ratings decide defeats, and defeats would decide
ratings — and iterating to a fixpoint is not safe. Lowering one step's rating can weaken a
party, which can let a dissent survive that did not, which lowers another rating: the map is
not monotone, so a fixpoint need not exist, or be unique, or be reached.

The literature's answer is to make preferences themselves attackable. In Modgil's **extended
argumentation frameworks** ([Modgil 2009][modgil]) an argument may attack an *attack*: "this
step is not as strong as that one" is an argument with its own premises, and it can be defeated
in turn. A rating becomes a party — "this step is well supported, because its strongest dissent
is asserted, not argued" — and the grounded and preferred semantics of the extended framework
decide which ratings stand together with which verdicts. The library's `Framework` would gain
attacks on attacks; `Horn` would compute them as it computes defeats now.

## Open questions

- **Partial credibility.** A dissent may be argued from Scripture for one ground and from
  authority for another. Phase one rejects it under the evidence standard; a finer result would
  name which ground fails.
- **A dissent from a premise**, not a step. The checks apply with empty grounds; the register
  for textual premises (what a verse says) is mostly empty, because those are common ground.
- **Who encodes the steelman.** The rule is only as good as the search for the strongest
  dissent. The `rating-auditor` agent does that search; its findings are what a register is
  built from.

[modgil]: https://doi.org/10.1016/j.artint.2009.02.001
