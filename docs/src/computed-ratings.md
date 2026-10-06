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

## Meaning postulates

Some claims the atom type keeps apart are joined by their meanings. "In Paul, δικαιόω is
forensic: a verdict, and *not* making righteous" denies, in so many words, "Paul's δικαιόω
denotes making righteous". A propositional check cannot see that: the two are separate atoms.
So each check holds the argument's **meaning postulates** as background. For every pair where
one claim's meaning denies another's, or part of it, the postulate is `a → ¬b`; where one
claim's meaning asserts all another's does, it is `a → b`.

Each argument lists its pairs in a `HasJoins` instance, beside its meanings, with proofs that
the lists are exactly what the meanings contain. Its atoms take their postulates
(`Testimony.Logic.HasPostulates`) from those lists and from nowhere else, and a check takes
them from the atoms: no call site names them, so no dissent can be checked without them.
`Testimony.Checks.Meanings` fails the build for an argument with no pinned lists, or whose
postulates come from anywhere else. `Testimony.Checks.Postulates` fails it for any package
the postulates make unsatisfiable: a package with no model entails everything.

Two claims that read one word in different senses are **not** held to exclude each other.
Whether the senses exclude each other is itself contested: Trent holds that justification both
declares and makes righteous. A postulate saying they do would hand one side's lexicon to both.
A claim whose meaning says *and not that sense* does exclude the other, and is listed.

Sola fide has four exclusions and no entailments (`Testimony.Meanings.SolaFide.joins`):
- Paul's word as renewal, against the forensic sense;
- Trent's Latin of Revelation 22:11, against the Greek;
- Trent's Latin of Sirach 18:22, against the Greek;
- "James's δικαιόω is Paul's", against "James 2:24 is compatible with Paul".

Every dissent gets the same background, whichever side it is on. Sola scriptura has one
exclusion and two entailments (`Testimony.Meanings.SolaScriptura.joins`): Mark 7's principle
against binding a commandment of men as God's word, and "Scripture is the sole infallible
rule" asserting that it is infallible and that no other rule is. The virgin birth has two
exclusions and one entailment (`Testimony.Meanings.BornOfAVirgin.joins`): Brown's "Micah's
silence proves nothing" against Miravalle's "it indicates a fatherless birth", Westminster's
supreme judge against "magisterial teaching settles the question", and "עַלְמָה denotes a virgin"
asserting that its range admits the sense. The other arguments have none yet. Without the
postulates, Trent's reading of Paul's word would pass as granting the lexical step's forensic
ground, which it denies.

Disputes hold them too: every attack is decided over what a party holds, its premises with
the postulates ([disputes](logic.md#disputes)). In the James dispute this adds one pair of
defeats, both ways: the Reformed harmony and the renewal reading, whose claims about James's
word exclude each other by meaning. No verdict the library states moves. `establish` holds
premises alone; the postulates could only add entailments, and no non-entailment the library
states is undone by them: `Testimony.Checks.Postulates` checks every `¬ Establishes`,
`¬ Entails` and `Independent` result, and fails the build when a meaning would overturn one.

## Stating the bridge

The standards check what a dissent *asserts*, not its step, because every step on every side
is someone's reading. So a claim smuggled into a step escapes the check. When a dissent's own
source states a claim the texts do not, in its own voice, that claim is a ground, not part of
the reading, and it is encoded as one: cited to whoever states it, and checked like any other.
Trent's chapter 16 is the first case: "we must believe" that the reward is rendered to merits.

The rule cuts both ways. A Reformed step that needs a claim its texts do not make must state
that claim too, and it is checked the same way. Westminster's answer to chapter 16 was checked
so: every claim it asserts outright is a text it gives as a proof, and only its step, a reading,
is its own (`westminster_answers_from_the_texts`).

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
| The reward is rendered to merits (Trent, ch. 16) | Westminster XVI.5, XVI.6 | credible | credible | every asserted claim is a text it cites |
| Works cause the increase, not merely fruit (canon 24) | The Reformed harmony | credible | credible | argued from Westminster's proof texts |
| Works are not merely fruit (Trent, ch. 16) | The Reformed harmony | credible | credible | argued from Westminster's proof texts |
| Justification is renewal (Trent, ch. 7) | Paul's gospel; Romans 4 | credible | credible | argued from the texts |
| Paul's δικαιόω denotes renewal (Trent, ch. 8) | Romans 4, on Paul's word | credible | credible | glosses the verb by Paul's text |
| Paul's δικαιόω denotes renewal (Trent, ch. 8) | The lexical case | not credible | not credible | holds the forensic sense as a premise: a rival reading |
| Faith does not suffice (Trent, ch. 7, canon 9) | Luke 18:9–14 | credible | credible | argued from the parable |
| Paul's δικαιόω is not renewal (`lexicalLine`) | Trent, with Augustine | not credible | not credible | denies the step's forensic ground |
| A verdict on a finished work is no renewal | Trent, read as what God does | not credible | not credible | holds the definition as a premise |
| Faith suffices (`luke18Line`) | Trent, ch. 7, canon 9 | not credible | credible | its one ground, the definition, rests on Trent |

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
  teach neither side's account of merit without a further claim.

**The same checks, run the other way.**
- **Westminster's answer to chapter 16's merit premise.** It argues from Hebrews 6:10 (a proof
  of XVI.6, and one of Trent's own four texts), Luke 17:10, Romans 4:4–5 and 1 Peter 2:5. It
  concludes that the reward is of grace, not rendered to merits. It is a credible critique under
  both standards.
- **The Reformed harmony against canon 24's step and chapter 16's.** It is a credible critique
  under both standards.
- **So each of Trent's claims is `disputed` under both** (`rome_steps_ratings`). Set beside
  `fruit_step_ratings`, that is the asymmetry the checks find. The Reformed dissents from
  Trent are critiques under either standard, while Trent's dissents from the Reformed step are
  critiques only where the council's word is admitted. Neither side's step is proved right by
  this. What differs is what each dissent rests on.
- **The hearings.** Under the evidence standard, the hearing forces Westminster's answer
  along with the harmony. Under the tradition standard, Westminster's answer and chapter 16
  defeat each other, and neither is forced.

**Disagreements, not critiques.** Trent's reading of James's word and Howell's move each hold
the denial they need as a premise (`trent_on_the_word_is_asserted`,
`howell_asserts_his_denial`).

**Trent's definition, and faith's sufficiency.**
- **The Reformed dissents.** Paul's gospel and Romans 4 against the definition, Romans 4 against
  its reading as Paul's word, and Luke 18 against the step to "faith does not suffice" are each
  a credible critique under both standards. So each of those claims of Trent's is `disputed`
  under both (`trent_definition_ratings`).
- **Trent's dissents** (`trent_dissents_from_the_definition_steps`). Its reading of Paul's word
  dissents from the lexical step's ground, not the step, so that step's support stands at
  `wellSupported` under both standards. Its definition read as what God does is asserted, not
  argued. Its denial of sufficiency is a critique of Luke 18 under the tradition standard only.
- **On the word itself, both sides hold their reading as a premise.** The lexical case holds
  the forensic sense, cited to the lexicon; Trent holds the renewal sense, cited to itself and
  VanLandingham. Against each other, each is a rival reading, so the question is weighed at
  those premises' ratings. The argued dissent is Romans 4's, which glosses the verb by Paul's
  own text.

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
[registers]: https://github.com/testimonyproject/testimony/issues/139
[phase-three]: https://github.com/testimonyproject/testimony/issues/140
[articles]: https://github.com/testimonyproject/testimony/issues/141
[modgil]: https://doi.org/10.1016/j.artint.2009.02.001
