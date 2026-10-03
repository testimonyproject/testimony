# Computed ratings (design)

**Status: phase one is built.** `Testimony.Logic.Credibility` implements the checks, the
ratings and the hearings below. `Testimony.Arguments.SolaFide.Ratings` applies them to two
steps of the Reformed reading of James, and `Testimony.Articles.Howell2003` to Howell's move.
The remaining steps are tracked in [#135][tracking].

## The question

Every inference step in the library carries a `Confidence`. The rule for `disputed` is that a
cited source grants the step's grounds and denies its conclusion. That rule records a fact
about the literature: *someone dissents*. It does not record the next thing a reader needs to
know: **is the dissent an argument, or only a disagreement?**

"You are wrong because I say so" is a dissent. So is "you are wrong because the council says
so". So is "you are wrong, because these texts say what your reading cannot hold". Only the
last is a critique that anyone can weigh without first sharing the dissenter's allegiances.

A rating that cannot tell these apart goes wrong in two directions:
- a bare denial lowers a well-argued step as far as a strong argument would;
- an author can raise a step's rating by never looking for the strongest dissent.

So a rating should be computed. It is `disputed` when some dissent is **credible**, and
otherwise the rating the step's support earns.

## What makes a dissent credible

A **dissent** is a position, stated as an `ArgumentPackage`, set against a claim. The claim is
either a premise, or the conclusion of a step whose grounds the dissent is given. The engine
decides five checks:

1. **Consistent.** Its premises have a model. A self-contradictory position denies everything,
   so it says nothing about this claim in particular.
2. **Denies the claim.** Its premises entail the claim's negation.
3. **Grants the grounds.** It can be held together with the step's grounds. A dissent that
   denies a ground is a dissent from *that* ground, and belongs to that ground's rating.
4. **Argued, not asserted.** What it asserts outright (its atoms and denied atoms) does not
   already contradict the claim. The denial must need one of its own steps. A position that
   holds the claim's negation as a premise is reporting its disagreement, not arguing it.
5. **Its grounds meet the standard.** Every claim it asserts rests on a warrant the standard
   admits (`Testimony.Logic.Warrant`). It also asserts no bare denial, because a denial is
   cited nowhere and so rests on the position's own say-so.

An `Assessment` runs the checks once and records what they find under **every** standard,
with the kernel's check that the engine finds it. One declaration answers the reader's
question for every standard at once. `Assessment.credible_iff` says the answer is exact:
credible as assessed if and only if `Credible`.

## Two standards, both reported

Check 5 needs a standard. Choosing one would decide a dispute that the library exists to
show, not to settle: whether a council's or a confession's word can ground a critique is the
sola scriptura question. So the standard is named, and every result is computed under both:

| Standard | Admits |
|---|---|
| `evidence` | Scripture; evidence anyone can check (texts, lexica, argued scholarship) |
| `tradition` | also a council's, a confession's or a theologian's own word |

- **Neither admits the library's own bare assertion.**
- **The standards check a dissent's grounds, never its inference.** Every step on every side is
  someone's reading, cited to a commentator, a council or a confession. A rule that discounted
  those readings would discount all of them alike.
- **A rating that differs between the standards turns on the authority question.** The page
  says so in those words. That is a finding, not a failure.

## Computing a rating

A `RatedStep` is a step together with its **register**: every dissent encoded against it, and
which of them is the strongest known. Its rating under a standard is one of three:

- **disputed**, by every dissent credible under the standard;
- **the support stands**, at the confidence its citation gives, when no dissent is credible
  and the strongest known dissent is encoded;
- **withheld**, weighed as `disputed`, when no dissent is credible but the strongest known
  dissent is not encoded.

The third case is the **steelman rule**:

> A computed rating may stand above `disputed` only when the strongest known dissent is encoded
> *with its own grounds* and fails a check. A dissent recorded only as a citation proves
> nothing either way.

The rule makes it visible when a dissent has been left out. A reader who knows a stronger
dissent has a concrete thing to add: a position, with grounds, that the engine will check.

`RatedStep.ratings` computes the rating under every standard at once. One theorem therefore
states a step's rating under each standard, and an article can argue from whichever standard
it prefers. It cannot hide the preference: the other standard's rating is on the same line.

## Stating the bridge

The standards check what a dissent *asserts*, not its step, because every step on every side
is someone's reading. So a claim smuggled into a step escapes the check. When a dissent's own
source states a claim the texts do not, in its own voice, that claim is a ground, not part of
the reading, and it is encoded as one: cited to whoever states it, and checked like any other.
Trent's chapter 16 is the first case: "we must believe" that the reward is rendered to merits.

The rule cuts both ways. A Reformed step that needs a claim its texts do not make must state
that claim too, and it will be checked the same way ([#138][reformed]).

## Hearings under a standard

Which dissents count decides two things in a dispute: who is heard, and how each step is
weighed. A `Register` attaches assessments to a dispute's parties and rated steps to its
citations. The **hearing under a standard** (`Register.hearing`) does three things:

- it hears every party that is not a dissent;
- it hears every dissent that is credible under the standard;
- it weighs each rated step at its computed rating under that standard.

So the dissents heard and the ratings weighed come from one register, under one standard, and
a verdict and a rating cannot disagree about which standard they assume.
`Register.heard_credible` proves that every dissent heard is a credible critique.

## What phase one finds

| Step | Dissent | Evidence | Tradition | Why |
|---|---|---|---|---|
| Works are fruit, not ground (`fruitLine`) | Trent, canon 24 | not credible | credible | "works cause the increase" rests on Trent alone |
| Works are fruit, not ground (`fruitLine`) | Trent, ch. 16, from the reward texts | not credible | credible | "the reward is rendered to merits" rests on Trent alone |
| James's δικαιόω is not the increase (`jamesLexicalLine`) | Trent, on the word | not credible | not credible | asserts the increase as a premise |
| James's δικαιόω is not the increase (`jamesLexicalLine`) | The renewal reading | not credible | credible | "James's word is Paul's" rests on Trent alone |
| James's faith is not the Reformers' (`jamesFaithLine`) | Howell (2003) | not credible | not credible | asserts the denial as a premise |

Each row is rendered on the generated page with ✔ or ✘ under each standard, and with the
claims a standard does not admit named. Disagreements are marked as disagreements.

**James's word: how a rating moves.**
- **Before the steelman.** Only Trent's reading of the word was encoded. It is a disagreement,
  so no dissent was credible. But the strongest known dissent was missing, so the computed
  rating was **withheld** under both standards (`lexical_step_before_the_steelman`).
- **The steelman.** The renewal reading argues the increase from Paul's word: Paul's δικαιόω
  denotes renewal, as VanLandingham argues and Augustine glossed it, and James's word is
  Paul's.
- **After it.** The step's support **stands** at `wellSupported` under the evidence standard,
  and it is **disputed** under the tradition standard (`lexical_step_ratings`).
- **Why the standards differ.** No exegete's statement that James's word is Paul's has been
  verified, so that ground rests on Trent's word. A verified one would make the step
  `disputed` under both standards ([#139][registers]).
- **The hearings agree with the rating** (`james_word_turns_on_the_standard`). Under the
  evidence standard the hearing forces James's word. Under the tradition standard it weighs
  the step at `disputed`, and the question is contested.

**Works as fruit, not ground: a bridge stated.**
- **The support.** Westminster's step is `wellSupported`. The Lutheran World Federation and the
  Catholic Church confess together that good works "follow justification and are its fruits",
  and that what follows faith "is neither the basis of justification nor merits it" (*Joint
  Declaration* §§37, 25).
- **Chapter 16's bridge.** The reward texts (1 Corinthians 15:58, Hebrews 6:10, 10:35, 2 Timothy
  4:8) say God *rewards* works. Chapter 16 adds that the reward is "rendered to their good works
  and merits", and that "we must believe" the justified "have truly merited eternal life". From
  reward to merit is the council's own step. Dulles, defending Trent, grants that "the fact
  that a reward is promised does not make it merited". Stated as a premise, as Trent states it,
  the bridge rests on the council's word (`rewardRenderedToMerits`).
- **The rating** (`fruit_step_ratings`). The support stands at `wellSupported` under the
  evidence standard, where neither of Trent's dissents is credible, and the step is `disputed`
  under the tradition standard, where both are.
- **The hearings agree** (`fruit_turns_on_the_standard`). Under the evidence standard the
  hearing forces the Reformed harmony. Under the tradition standard it is contested.
- **What this does not show.** It shows that Trent's denial does not stand on Scripture and
  evidence alone. It does not show that the reward texts teach the Reformed reading: they
  teach neither side's account of merit without a further claim. Westminster's own answer
  (XVI.6) gets the same checks in [#138][reformed].

**Disagreements, not critiques.** Trent's reading of James's word and Howell's move each hold
the denial they need as a premise (`trent_on_the_word_is_asserted`,
`howell_asserts_his_denial`).

## Phase two: every dispute weighs computed ratings

A hearing weighs computed ratings, but a full dispute still weighs cited ones. For the James
dispute these agree under the evidence standard only. The full dispute therefore forces
James's word (`james_words_prevail`), while the hearing under the tradition standard finds it
contested. Phase two ([#136][phase-two]) declares every dispute with its register and states
each verdict under both standards. Splitting `Source.confidence` into support and register,
and enforcing the steelman rule with a linter rule, is [#137][split].

This is not circular. A dissent's credibility depends only on entailment and warrant, never on
ratings, so the computed ratings are fixed before the solver runs.

## Phase three: survival, and preferences as arguments

A credible dissent can still lose the weighing. Phase one does not let that survival feed
back into the rating. `Contested` and `DenialAnswered` (`Testimony.Logic.Contest`) report it
after the fact.

Folding survival into the rating is circular: ratings decide defeats, and defeats would
decide ratings. Iterating to a fixpoint is not safe either. Lowering one step's rating can
weaken a party; that can let a dissent survive that did not before; and that lowers another
rating. The map is not monotone, so a fixpoint need not exist, need not be unique, and need
not be reached.

The literature's answer is to make preferences themselves attackable. In Modgil's **extended
argumentation frameworks** ([Modgil 2009][modgil]) an argument may attack an *attack*. "This
step is not as strong as that one" becomes an argument with its own premises, and it can be
defeated in turn.

Two kinds of preference become parties:
- **A rating.** For example: "this step is well supported, because its strongest dissent rests
  on a council's word alone".
- **A standard.** For example: "a council's word does not ground a critique of Scripture's
  sense", which is the claim the sola scriptura argument already encodes.

A reader who prefers a standard can then argue for it, and the page shows what each verdict
costs if that argument falls. This is [#140][phase-three].

## Open questions

- **A dissent from a premise**, not a step. The checks apply with empty grounds. The register
  for a textual premise (what a verse says) is mostly empty, because those premises are common
  ground.
- **Who encodes the steelman.** The rule is only as good as the search for the strongest
  dissent. The `rating-auditor` agent does that search, and a register is built from its
  findings ([#139][registers]).
- **Articles.** Howell's assessment is checked but is not yet on a generated page
  ([#141][articles]).

[tracking]: https://github.com/testimonyproject/testimony/issues/135
[phase-two]: https://github.com/testimonyproject/testimony/issues/136
[split]: https://github.com/testimonyproject/testimony/issues/137
[reformed]: https://github.com/testimonyproject/testimony/issues/138
[registers]: https://github.com/testimonyproject/testimony/issues/139
[phase-three]: https://github.com/testimonyproject/testimony/issues/140
[articles]: https://github.com/testimonyproject/testimony/issues/141
[modgil]: https://doi.org/10.1016/j.artint.2009.02.001
