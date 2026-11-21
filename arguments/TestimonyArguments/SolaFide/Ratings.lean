import Testimony.Logic.Declare
import TestimonyArguments.SolaFide.Vulgate
import Testimony.Logic.Credibility
import Testimony.Logic.Contest
import TestimonyArguments.Meanings.SolaFide
import TestimonyArguments.SolaFide.Definition
import TestimonyArguments.SolaFide.JesusWords

/-!
# TestimonyArguments.SolaFide.Ratings — is an objection an argument, or only a disagreement?

A step is rated `disputed` when someone objects to it. A reader's next question
is: **is the objection an argument, or only a disagreement?** This chapter asks
that of every objection written down here to several steps of the Reformed
reading. An objection counts as an argument (the code calls it *credible*, or a
*critique*) when it does all of these:

- it does not contradict itself;
- it denies the step's conclusion;
- it accepts the step's starting points;
- it argues for its denial by a step of its own, and does not merely state it;
- it rests its own starting points on what a stated standard allows.

There are three standards, and every result is worked out under each.

- The **evidence** standard allows Scripture and evidence anyone can check.
- The **tradition** standard also allows the word of a council or a confession.
- The **Scripture** standard is the evidence standard, with one addition: an
  objection to a step that rests on Scripture alone must itself rest on
  Scripture alone. Here it gives the same answer as the evidence standard every
  time.

## James's word: how a rating changes

One step reads James's "justified" (δικαιόω) in the declaring sense the word has
outside Paul (`jamesLexicalLine`). Two objections to it are written down.

- **Trent's reading of the word** takes the increase of justice as a premise.
  That is a disagreement, not an argument, under any standard.
- **The reading through Paul** argues for it. Paul's "justify" means renewal, as
  VanLandingham argues from the lexicon and as Augustine explained it. James
  uses the word as Paul does. And James says Abraham was justified by works
  after Genesis 15:6. This is the strongest objection found, and it is an
  argument. But one of its starting points, that James uses the word as Paul
  does, rests on Trent's word alone (chapter 10). No scholar's statement of it
  has been verified.

So the step's rating depends on whether a council's word counts
(`lexical_step_ratings`). Under the evidence standard its support stands at
`wellSupported`, because every objection written down fails, the strongest among
them. Under the tradition standard it is `disputed`, by the reading through
Paul.

Without the reading through Paul, the same checks refuse any rating above
`disputed` under all three standards, because the strongest known objection is
missing (`lexical_step_before_the_steelman`). A step rises above `disputed` only
once its strongest objection is heard, and only where that objection fails.

## Works as fruit, not ground

Westminster's step (`fruitLine`) derives "fruit, not ground" from its proof
texts. Its support is `wellSupported`: the Lutheran World Federation and the
Catholic Church confess together that good works "follow justification and are
its fruits" (§37), and that "whatever in the justified precedes or follows the
free gift of faith is neither the basis of justification nor merits it" (§25,
*Joint Declaration*). That joint statement is about the *ground* of
justification. It does not settle whether works do anything further. On that the
Declaration records the two sides apart. Catholics hold that good works
"contribute to growth in grace, so that the righteousness that comes from God is
preserved and communion with Christ is deepened" (§38). Lutherans hold "a
preservation of grace and a growth in grace and faith", and view good works "as
the fruits and signs of justification and not as one's own 'merits'" (§39). Two
objections are written down, both from Trent, and both argued.

- **Canon 24, applied to James 2:24**: works cause the increase of
  justification. That claim rests on the council's word alone.
- **Chapter 16, from the texts that promise a reward** (1 Corinthians 15:58,
  Hebrews 6:10, Hebrews 10:35, 2 Timothy 4:8). The texts are Scripture, and
  Westminster accepts them (XVI.6). But they say God *rewards* the works.
  Chapter 16 adds that the reward is "rendered to their good works and merits",
  and that "we must believe" the justified "have truly merited eternal life".
  The passage from reward to merit is the council's own claim. Dulles, defending
  Trent's teaching, grants that "the fact that a reward is promised does not
  make it merited". In the *Joint Declaration*, Catholics say that in affirming
  the "meritorious" character of good works "they wish to say that, according to
  the biblical witness, a reward in heaven is promised to these works", and to
  emphasise "the responsibility of persons for their actions" (§38).

So each of Trent's objections rests, at one claim, on the council's word, and
the step's rating depends on whether that word counts (`fruit_step_ratings`).
Under the evidence standard neither objection stands, and the support remains
`wellSupported`. Under the tradition standard both stand, and the step is
`disputed`.

This shows exactly that, and no more. Trent's denial does not stand on Scripture
and checkable evidence alone. A reader who accepts the council's word has an
argued objection. A reader who does not has none. It does not show that the
reward texts teach the Reformed reading of them. It shows that Trent's
objection, as written down here, needs one claim that is cited to the council
alone.

## The same checks, applied the other way

A check applied in one direction only would be unfair. So the Reformed
objections to Rome's claims are assessed by the same checks, under the same
three standards.

- **Westminster against chapter 16's premise about merit** (XVI.5, XVI.6). God
  does not forget the work of believers: that is Hebrews 6:10, which Westminster
  gives as a proof and which is one of Trent's own four texts. Having done all,
  believers are unworthy servants who have done only their duty (Luke 17:10).
  Wages are counted as due to one who works, and as a gift to one who believes
  (Romans 4:4–5). Their sacrifices are acceptable to God through Jesus Christ (1
  Peter 2:5). So the reward is of grace, and is not given to merits. Every claim
  Westminster states outright is a text it cites. What is its own is the step, a
  reading rated `disputed` (`westminster_answers_from_the_texts`).
- **The Reformed reconciliation of James with Paul, against canon 24's step and
  against chapter 16's.** It accepts each step's starting points, and argues
  from Westminster's proof texts that works are the fruit of faith and not its
  ground.

Each is an argument under **every** standard, so each of Trent's claims is
`disputed` under every standard (`rome_steps_ratings`). Set beside
`fruit_step_ratings`, that is the difference the checks find. The Reformed
objections to Trent are arguments under each of the three standards. Trent's
objections to the Reformed step are arguments only under the standard that
allows the council's word. Neither side's step is shown to be right by this.
What differs is what each side's objection rests on.

One caution. The checks test an objection's starting points, not its step.
Trent's move from reward to merit is written as a starting point, because
chapter 16 states it as something to be believed. Westminster's move from the
same texts to "not given to merits" is written as its step, and is rated
`disputed`. A reader who thinks the two moves are alike should weigh this result
accordingly.

## Trent's definition, and whether faith suffices

Trent's definition, that justification is "not remission of sins merely, but
also the sanctification and renewal of the inward man" (ch. 7), can be taken two
ways (`whatTrentsDefinitionClaims`), and Trent draws from it that faith does not
suffice (ch. 7, canon 9). The checks are applied to each, in both directions.

From the Reformed side, each of these is an argument under every standard
(`trent_definition_ratings`):

- Paul's gospel and Romans 4, against the definition taken as a claim about what
  God does;
- Romans 4, explaining Paul's verb from Paul's own text, against the definition
  taken as a claim about Paul's word;
- Luke 18, against the step to "faith does not suffice".

So each of Trent's three claims is `disputed` under all three standards.

From Trent's side (`trent_dissents_from_the_definition_steps`):

- **Its reading of Paul's word** is an argument against the step about the word,
  under all three standards. Trent keeps the courtroom sense, the step's first
  starting point, and argues from Augustine that the word means making righteous
  as well, which is what the step denies. So the step is `disputed` under every
  standard.
- **Its definition, taken as a claim about what God does**, is stated, not
  argued, against Paul's gospel: Trent holds it as a premise.
- **Its denial that faith suffices** is an argument against Luke 18's step under
  the tradition standard only. Its one starting point is the definition, which
  rests on the council's word.

The question of the word is argued from both sides. The argument from Paul's
word holds the courtroom sense as a premise, cited to the lexicon, and argues
from it, from Paul's other words for renewal and from the rule of least meaning
that the word means no more. Trent holds that it means renewal, cited to itself
and to VanLandingham, and keeps the courtroom sense beside it. Neither premise,
by what it means, denies the other, so each is an argument against the other
(`lexicalOnWordAssessment`, `trentWordOnLexicalAssessment`). Romans 4 argues
against Trent's reading from the text as well.

## Claims that exclude each other by their meaning

Some claims that are listed separately exclude each other by what they mean.
"Justification includes the remission of sins, and not sanctification" denies
"justification includes both" in so many words. Every check here takes those
exclusions as given (`Meanings.SolaFide.joins`), in the same way for an
objection on either side, and the list is proved to contain exactly the
exclusions the meanings imply. Without them, a position could count as granting
a starting point that, by what it means, it denies.

## The debate heard under each standard

Which objections are arguments decides who is heard, and how each step is
weighed. Under a given standard, the debate over James (`jamesDispute`) is heard
among every position that is not an objection, together with every objection
that counts as an argument under that standard, and each rated step is weighed
at the rating worked out under that standard. So who is heard and how the steps
are weighed come from one record, and cannot disagree about the standard.

Both sides are entered in that record. Trent's readings object to the Reformed
steps, and the Reformed positions object to Trent's: the argument from James's
word to the reading through Paul, the Reformed reconciliation to canon 24 and
chapter 16, and Westminster to the claim that the reward is given to merits. So
a Reformed position that rests on Calvin's or Westminster's word is set aside by
the evidence standard exactly as a Catholic one that rests on Trent's is.

- **Under the evidence standard no reading of James's "by works" is heard**
  (`james_readings_heard`). Every one of them needs James to keep "justify" and
  "works" in one sense through 2:21–25, and that is Calvin's reading and
  Trent's, not a fact anyone can check without a reader. Some need more: the
  argument from James's word needs Calvin's word that James uses "justify" as
  it is used outside Paul, and the reading through Paul needs Trent's that he
  uses it as Paul does.
- **What James's "justified" means depends on the standard**
  (`james_word_turns_on_the_standard`). Under the evidence standard the question
  is not heard: both readings of the word are set aside. Under the tradition
  standard both are heard, as in the full debate, and the question is contested.
  The argument from James's word and the reading through Paul can each be
  defended, and neither is forced.
- **Whether works are fruit and not ground depends on the standard too**
  (`fruit_turns_on_the_standard`). Under the evidence standard the question is
  not heard either. The Reformed reconciliation rests on Westminster's and
  Calvin's word that Ephesians 2 and James 2:18 share "faith" and "works", and
  each of Trent's objections rests on the council's word. What is forced there is
  Westminster's answer on the reward, which argues from its proof texts alone.
  Under the tradition standard all of them are heard. The reconciliation and
  chapter 16's reading can each be defended, and so can Westminster's answer and
  chapter 16, which defeat each other. None of them is forced.

Under the tradition standard the rating and the verdict agree: a step rated
`disputed` there is contested when the debate is heard under it. Under the
evidence standard they no longer line up. The step about James's word and the
step to "fruit, not ground" stand there at `wellSupported`, because no objection
the standard admits brings them down. But the positions that take them are not
heard, because each rests a premise of its own on a reader's word. A rating
says whether an objection brings a step down; a hearing also asks what the
step's own premises rest on.

The full debate still weighs every step at the rating *cited* for it. For the
step about the word that is `wellSupported`, which is also what is worked out
under the evidence standard. Under the tradition standard it is this narrower
hearing, not the full debate, that gives the consistent result. Having every
debate weigh worked-out ratings is the next stage of the design
(`docs/src/computed-ratings.md`).

## What this does not show

An objection that counts as an argument does not show the step wrong, and an
objection that fails does not show it right. These checks say only whether the
disagreement is one between arguments. Which side prevails is what the hearing
works out, from the ratings each side rests on.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Logic.Framework

/-! ### The objections, assessed -/

/-- **Canon 24, against "fruit, not ground".** It is argued, and it accepts
Westminster's proof texts. But it states that good works are a cause of the
increase of justification on the council's word alone. So it is an argument
under the tradition standard and not under the evidence standard. -/
def canon24Assessment : Assessment Claim where
  dissenter := "Trent, canon 24"
  against := fruitLine.name
  dissent :=
    { claim := p .worksAreFruitNotGround
    , grounds := fruitLine.grounds
    , position := catholicJamesOnWorks }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.worksCauseIncreaseOfJustification, .jamesKeepsHisWordsThroughTheParagraph])
        , (.tradition, [])
        , (.scriptural,
            [.worksCauseIncreaseOfJustification, .jamesKeepsHisWordsThroughTheParagraph]) ] }
  checked := by horn_certify

/-- **Chapter 16, against "fruit, not ground".** It is argued, and it accepts
Westminster's proof texts. Its starting points are the texts that promise a
reward, which are Scripture and which Westminster accepts, and the claim that
the reward is given to the works as merits. The texts do not say that; Trent
states it on its own word ("we must believe"). So it is an argument under the
tradition standard and not under the evidence standard. -/
def rewardAssessment : Assessment Claim where
  dissenter := "Trent, Session VI, ch. 16"
  against := fruitLine.name
  dissent :=
    { claim := p .worksAreFruitNotGround
    , grounds := fruitLine.grounds
    , position := trentOnReward }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.rewardRenderedToMerits])
        , (.tradition, [])
        , (.scriptural, [.rewardRenderedToMerits]) ] }
  checked := by horn_certify

/-- **Trent's reading of James's word, against the step about the word.** It takes
as a premise that James's "justified" means the increase of justice, and that
premise alone contradicts the step's conclusion. A disagreement, not an
argument, under any standard. -/
def trentWordAssessment : Assessment Claim where
  dissenter := "Trent, Session VI, ch. 10"
  against := jamesLexicalLine.name
  dissent :=
    { claim := notP .jamesJustifyDenotesIncrease
    , grounds := jamesLexicalLine.grounds
    , position := catholicJamesOnTheWord }
  findings :=
    { consistent := true, denies := true, grants := true, argued := false, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.jamesJustifyDenotesIncrease, .jamesKeepsHisWordsThroughTheParagraph])
        , (.tradition, [])
        , (.scriptural, [.jamesJustifyDenotesIncrease, .jamesKeepsHisWordsThroughTheParagraph]) ] }
  checked := by horn_certify

/-- **The reading through Paul, against the step about the word.** It is argued,
from Paul's word as renewal and James's word as Paul's, and it accepts the
step's starting points. It is an argument under the tradition standard. Under
the evidence standard it is not, because one of its starting points, that
James's word is Paul's, rests on Trent's word alone. -/
def renewalAssessment : Assessment Claim where
  dissenter := "The renewal reading"
  against := jamesLexicalLine.name
  dissent :=
    { claim := notP .jamesJustifyDenotesIncrease
    , grounds := jamesLexicalLine.grounds
    , position := renewalOnTheWord }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.jamesUsesDikaioAsPaul, .jamesKeepsHisWordsThroughTheParagraph])
        , (.tradition, [])
        , (.scriptural, [.jamesUsesDikaioAsPaul, .jamesKeepsHisWordsThroughTheParagraph]) ] }
  checked := by horn_certify

/-- **Trent's reading of James's word is a disagreement, not an argument.** What it
states outright includes the increase of justice, which alone contradicts the
step's conclusion. It needs no step of its own to reach its denial. -/
theorem trent_on_the_word_is_asserted :
    trentWordAssessment.findings.kind = .asserted ∧
      ∀ s, ¬ Dissent.Credible s trentWordAssessment.dissent := by
  refine ⟨by decide, fun s => trentWordAssessment.complete ?_⟩
  cases s <;> decide

/-! ### The steps, rated -/

/-- **"Works are fruit, not ground", with the objections to it**: canon 24's and
chapter 16's. Chapter 16's is the strongest known: it argues from texts both
sides accept. -/
def fruitStep : RatedStep Claim where
  step := fruitLine.name
  support := fruitSource
  register := [canon24Assessment, rewardAssessment]
  strongest := some 1

/-- **The rating of "fruit, not ground" depends on whether a council's word
counts.** Under the evidence standard its support stands at `wellSupported`.
Both of Trent's objections are argued, and each rests at one claim on the
council's word alone: canon 24's, that works cause the increase of
justification; and chapter 16's, that the reward the texts promise is given to
the works as merits. Under the tradition standard, which allows the council's
word, both count as arguments, and the step is `disputed`.

It does not show that the reward texts teach the Reformed reading. It
shows that Trent's objection, as written down here, needs one claim cited to the
council alone. -/
@[headline]
theorem fruit_step_ratings :
    fruitStep.ratings =
      [ (.evidence, .stands .wellSupported)
      , (.tradition, .disputedBy ["Trent, canon 24", "Trent, Session VI, ch. 16"])
      , (.scriptural, .stands .wellSupported) ] := by
  decide +kernel

#print axioms fruit_step_ratings

/-- **The step about James's word, with the objections to it**: Trent's reading of
the word, and the reading through Paul, which is the strongest known objection
because it argues for the increase from Paul's word. -/
def lexicalStep : RatedStep Claim where
  step := jamesLexicalLine.name
  support := jamesLexicalSource
  register := [trentWordAssessment, renewalAssessment]
  strongest := some 1

/-- **The rating of the step about James's word depends on whether a council's word
counts.** Under the evidence standard its support stands at `wellSupported`.
Every objection written down fails a check, the strongest known among them,
because the reading through Paul rests its claim that James's word is Paul's on
Trent alone. Under the tradition standard, which allows Trent's word, that
reading counts as an argument and the step is `disputed`. -/
@[headline]
theorem lexical_step_ratings :
    lexicalStep.ratings =
      [ (.evidence, .stands .wellSupported)
      , (.tradition, .disputedBy ["The renewal reading"])
      , (.scriptural, .stands .wellSupported) ] := by
  decide +kernel

#print axioms lexical_step_ratings

/-- **Before the strongest objection was written down, no rating above `disputed`
was permitted.** With only Trent's reading of the word on record, no objection
counts as an argument. But the strongest known one is missing, so the rating is
withheld under every standard. Writing down the reading through Paul is what
changes it: to `wellSupported` under the evidence standard, and to `disputed`
under the tradition standard. -/
theorem lexical_step_before_the_steelman :
    ({ lexicalStep with
        register := [trentWordAssessment], strongest := none, overruled := [] }).ratings =
      [(.evidence, .withheld), (.tradition, .withheld), (.scriptural, .withheld)] := by
  decide +kernel

/-! ### Rome's steps, by the same checks -/

/-- **Westminster, against Trent's premise that the reward is given to merits**
(XVI.5, XVI.6). It argues from texts Westminster gives as proofs: Hebrews 6:10,
one of Trent's own four; Luke 17:10; Romans 4:4–5; 1 Peter 2:5. It argues by a
step of its own, its reading of them. Every claim it states outright is a text.
So it is an argument under all three standards. -/
def westminsterAssessment : Assessment Claim where
  dissenter := "Westminster XVI.5, XVI.6"
  against := "Trent: the reward is rendered to merits (ch. 16, canon 32)"
  dissent :=
    { claim := p .rewardRenderedToMerits
    , position := westminsterOnReward }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])] }
  checked := by horn_certify

/-- **The Reformed reconciliation, against canon 24's step.** It accepts James 2:24,
the works by which Abraham and Rahab were justified, and canon 24's own claim
that works cause the increase. It argues from Westminster's proof texts that
works are the fruit of faith and not its ground. What it states outright rests
on Scripture and on readings argued from it. So it is an argument under every
standard. -/
def harmonyOnCanon24Assessment : Assessment Claim where
  dissenter := "The Reformed harmony (Westminster XVI.2, XVI.5)"
  against := catholicJamesWorksLine.name
  dissent :=
    { claim := notP .worksAreFruitNotGround
    , grounds := catholicJamesWorksLine.grounds
    , position := jamesHarmonyCase }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.fruitTextsShareFaithAndWorks])
        , (.tradition, [])
        , (.scriptural, [.fruitTextsShareFaithAndWorks]) ] }
  checked := by horn_certify

/-- **The Reformed reconciliation, against chapter 16's step.** It accepts the
reward texts, and accepts for the sake of argument even that the reward is given
to merits. It argues that works are the fruit of faith and not its ground. An
argument under all three standards. Westminster's own answer goes further and
denies the second starting point (`westminsterAssessment`). -/
def harmonyOnRewardAssessment : Assessment Claim where
  dissenter := "The Reformed harmony (Westminster XVI.2, XVI.5)"
  against := trentRewardLine.name
  dissent :=
    { claim := notP .worksAreFruitNotGround
    , grounds := trentRewardLine.grounds
    , position := jamesHarmonyCase }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.fruitTextsShareFaithAndWorks])
        , (.tradition, [])
        , (.scriptural, [.fruitTextsShareFaithAndWorks]) ] }
  checked := by horn_certify

/-- **The argument from James's word, against the reading through Paul.** It
grants that reading's starting points as starting points: that Paul's "justify"
means renewal, that James uses the word as Paul does, that Abraham was justified
by works, and that James keeps his words through the paragraph. Holding them
beside its own does not contradict it, because what contradicts it is the
reading's step, not its premises. It argues, from the word's use outside Paul and
the rule of least meaning, that James's "justified" does not mean the increase of
justice. So it is an argument against the reading's step, as that reading is
against its own (`renewalAssessment`).

It is held to the standards by the same test. Two of its starting points rest on
Calvin's word: that James uses "justify" as it is used outside Paul (Calvin on
James 2:21), and that James keeps his words in one sense through 2:21–25 (Calvin
on James 2:24, with Trent). So it is an argument under the tradition standard,
and not under the evidence or the Scripture standard. -/
def lexicalOnRenewalAssessment : Assessment Claim where
  dissenter := "James's word (δικαιόω, by the rule of least meaning)"
  against := renewalWordLine.name
  dissent :=
    { claim := p .jamesJustifyDenotesIncrease
    , grounds := renewalWordLine.grounds
    , position := jamesLexicalCase }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.jamesUsesDikaioAsOutsidePaul, .jamesKeepsHisWordsThroughTheParagraph])
        , (.tradition, [])
        , (.scriptural, [.jamesUsesDikaioAsOutsidePaul, .jamesKeepsHisWordsThroughTheParagraph])
        ] }
  checked := by horn_certify

/-- **The reading through Paul's step, with the objection to it**: the argument
from James's word, the strongest known, because it argues from the word's use
outside Paul and does not merely deny the reading. -/
def renewalStep : RatedStep Claim where
  step := renewalWordLine.name
  support := renewalWordSource
  register := [lexicalOnRenewalAssessment]
  strongest := some 0

/-- **The rating of the reading through Paul depends on whether a theologian's word
counts.** Under the tradition standard the argument from James's word is an
argument against it, and the step is `disputed`. Under the evidence and the
Scripture standards the argument from James's word is not heard, because it
rests on Calvin's word at two premises, and the step stands at its cited rating,
which is `disputed` already.

Set beside `lexical_step_ratings`, the two readings of James's word are held to
the same test, and each fails it at the evidence standard for the same kind of
reason: each needs a reader's word for how James uses "justify". -/
@[headline]
theorem renewal_step_ratings :
    renewalStep.ratings =
      [ (.evidence, .stands .disputed)
      , (.tradition, .disputedBy ["James's word (δικαιόω, by the rule of least meaning)"])
      , (.scriptural, .stands .disputed) ] := by
  decide +kernel

#print axioms renewal_step_ratings

/-- **The Reformed reconciliation meets the same test against chapter 16's step as
against canon 24's.** Its position is the same in both, so what the checks find
of it is the same, under every standard. That is why the record of the debate
can enter it once. -/
theorem harmony_assessed_alike :
    harmonyOnRewardAssessment.findings = harmonyOnCanon24Assessment.findings := by
  decide

/-- **Trent's premise that the reward is given to merits, with the objection to
it**: Westminster's, the strongest known. -/
def meritPremise : RatedStep Claim where
  step := "Trent: the reward is rendered to merits (ch. 16, canon 32)"
  support := (baseCite .rewardRenderedToMerits).source
  register := [westminsterAssessment]
  strongest := some 0

/-- **Canon 24's step, with the objection to it**: the Reformed reconciliation's. -/
def canon24Step : RatedStep Claim where
  step := catholicJamesWorksLine.name
  support := trentWorksSource
  register := [harmonyOnCanon24Assessment]
  strongest := some 0

/-- **Chapter 16's step, with the objection to it**: the Reformed reconciliation's. -/
def rewardStep : RatedStep Claim where
  step := trentRewardLine.name
  support := trentRewardSource
  register := [harmonyOnRewardAssessment]
  strongest := some 0

/-- **The same checks, applied the other way: what Rome's steps meet under each
standard.** Westminster's answer to Trent's premise about merit argues from texts
and rests on no one's word alone. So it counts as an argument under every
standard, and Trent's premise is `disputed` under all three.

The Reformed reconciliation's answers to canon 24's step and to chapter 16's are
another matter. Each needs Ephesians 2:8–10 and James 2:18 to use "faith" and
"works" in one sense, so that Paul's works and James's are the same works, and
only Westminster (XVI.2) and Calvin (on James 2:18) say that they do. So each
answer rests at that premise on a confession's and a theologian's word. It is an
argument under the tradition standard, and not under the evidence or the
Scripture standard. There, canon 24's step and chapter 16's stand at their cited
rating, `disputed`.

Set beside `fruit_step_ratings`, the checks now find the two sides alike. Trent's
objections to the Reformed step are arguments only under the standard that
allows the council's word, and the Reformed objections to Trent's two steps are
arguments only under the standard that allows the Assembly's. The one exception
is Westminster's answer on merit, which needs no one's word.

It does not show that either side's step is right. -/
@[headline]
theorem rome_steps_ratings :
    meritPremise.ratings =
        [ (.evidence, .disputedBy ["Westminster XVI.5, XVI.6"])
        , (.tradition, .disputedBy ["Westminster XVI.5, XVI.6"])
        , (.scriptural, .disputedBy ["Westminster XVI.5, XVI.6"]) ] ∧
      canon24Step.ratings =
        [ (.evidence, .stands .disputed)
        , (.tradition, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"])
        , (.scriptural, .stands .disputed) ] ∧
      rewardStep.ratings =
        [ (.evidence, .stands .disputed)
        , (.tradition, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"])
        , (.scriptural, .stands .disputed) ] := by
  decide +kernel

#print axioms rome_steps_ratings

/-- **Westminster's answer rests on no one's word alone; Trent's claim does.** Every
claim that Westminster's reading of the reward states outright is a text it
gives as a proof. The one claim chapter 16 adds to its texts, that the reward is
given to merits, is the council's own. -/
theorem westminster_answers_from_the_texts :
    westminsterOnReward.restingOnAuthority = [] ∧
      trentOnReward.restingOnAuthority = [.rewardRenderedToMerits] := by
  decide

/-! ### Trent's definition, and whether faith suffices -/

/-- Trent's step from its definition to the denial that faith suffices. If
justification is the renewal of the inward person by charity poured in, then
faith, "unless hope and charity be added thereto, neither unites man perfectly
with Christ" (Session VI, ch. 7), and whoever says that "nothing else is
required to co-operate" is anathema (canon 9). Rated `disputed`: the Reformed
read Luke 18 and Luke 7:50 as a plea that sufficed (`luke18Line`). -/
def trentSufficiencySource : Source :=
  { primary := .work tannerDecrees
      (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 7; canon 9")
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **Faith does not suffice, from Trent's definition** (ch. 7, canon 9): the
definition, and the step from it. This states Trent's denial as these pages
state it throughout, as a consequence of what Trent says justification is
(`trentDefinitionSteps`). -/
@[solaFideDefs]
def trentSufficiencyLine : Line Claim :=
  { name := "Faith does not suffice (Trent, ch. 7, canon 9)"
  , grounds := [p .justificationIncludesSanctification]
  , step := p .justificationIncludesSanctification ➝ notP .faithIsSufficient
  , delivers := notP .faithIsSufficient
  , inference := some trentSufficiencySource }

/-- Trent on whether faith suffices, as a position of its own. -/
@[solaFideDefs]
def trentOnSufficiency : ArgumentPackage Claim :=
  trentSufficiencyLine.asPackage baseCite "Faith does not suffice"

/-- **Paul's word, as the Latin West read it.** Augustine explained "being
justified" as "being made righteous", and Trent reads the Apostle so (ch. 8). So
Paul's "justify" (δικαιόω) means the renewal of the inward person. This is
Trent's definition taken as a claim about the word (`trentOnPaulsWord`), set out
as a line of argument. -/
@[solaFideDefs]
def trentWordLine : Line Claim :=
  { name := "Paul's word, as the Latin West read it (Augustine; Trent, ch. 8)"
  , grounds := [p .augustineReadsJustifyAsMakeRighteous, p .latinWordBearsPaulsSense]
  , step :=
      ⋀ [p .augustineReadsJustifyAsMakeRighteous, p .latinWordBearsPaulsSense]
      ➝ p .paulsJustifyDenotesRenewal
  , delivers := p .paulsJustifyDenotesRenewal
  , inference := some trentReadsPaulsWord }

/-- Trent's reading of Paul's word, as a position of its own. -/
@[solaFideDefs]
def trentOnTheWordOfPaul : ArgumentPackage Claim :=
  trentWordLine.asPackage baseCite "Paul's δικαιόω denotes renewal"

/-- **Paul's gospel, against Trent's definition taken as a claim about what God
does.** It argues from Galatians 1:6–9, 2:21 and 5:2–4, 1 Corinthians 15:3,
Romans 8:33–34 and the courtroom sense of the verb. Every claim it states
outright is a text, or a reading argued from the lexicon. An argument under all
three standards. -/
def gospelOnDefinitionAssessment : Assessment Claim where
  dissenter := "Paul's gospel (Galatians 1; Westminster XI.1)"
  against := "Trent: justification is the renewal of the inward man (ch. 7)"
  dissent :=
    { claim := p .justificationIncludesSanctification
    , position := galatianGospel }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])] }
  checked := by horn_certify

/-- **Romans 4, against Trent's definition.** The righteousness God counts to the
ungodly is sin not counted (4:5–8), and the verb is a courtroom word. An
argument under every standard. -/
def romansFourOnDefinitionAssessment : Assessment Claim where
  dissenter := "Romans 4:3–8"
  against := "Trent: justification is the renewal of the inward man (ch. 7)"
  dissent :=
    { claim := p .justificationIncludesSanctification
    , position := romansFourCase }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])] }
  checked := by horn_certify

/-- **Romans 4, on Paul's word, against Trent's definition taken as a claim about
the word.** Paul explains the righteousness God counts to the ungodly as sin not
counted (4:5–8), and by the rule of least meaning his verb means no more than
that verdict. It argues from Paul's own text, without assuming the courtroom
sense. So it is an argument under all three standards, and the strongest known
against taking the definition this way. -/
def romansFourOnWordAssessment : Assessment Claim where
  dissenter := "Romans 4:3–8, on Paul's word"
  against := "Trent: Paul's δικαιόω denotes renewal (ch. 8, with Augustine)"
  dissent :=
    { claim := p .paulsJustifyDenotesRenewal
    , position := romansFourOnTheWord }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])] }
  checked := by horn_certify

/-- **The argument from Paul's word, against Trent's definition taken as a claim
about the word.** It holds as a premise that Paul's "justify" is a verdict, cited
to the lexicon, and argues from that, from Paul's other words for renewal and
from the rule of least meaning that the word does not also mean renewal. So it
reaches its denial by a step, and is an argument under all three standards.
Trent's reading stands against it in the same way
(`trentWordOnLexicalAssessment`): each grants the verdict sense, and each argues
its own answer to whether that is all the word means. -/
def lexicalOnWordAssessment : Assessment Claim where
  dissenter := "Paul's word (by the rule of least meaning)"
  against := "Trent: Paul's δικαιόω denotes renewal (ch. 8, with Augustine)"
  dissent :=
    { claim := p .paulsJustifyDenotesRenewal
    , position := lexicalCase }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])] }
  checked := by horn_certify

/-- **Luke 18, against Trent's step to "faith does not suffice".** The tax
collector's plea, without works, and God's verdict. It can be held together with
Trent's definition, the step's starting point, and argues that the plea
sufficed. An argument under all three standards. -/
def luke18OnSufficiencyAssessment : Assessment Claim where
  dissenter := "Luke 18:9–14 (the tax collector justified)"
  against := trentSufficiencyLine.name
  dissent :=
    { claim := notP .faithIsSufficient
    , grounds := trentSufficiencyLine.grounds
    , position := luke18Case }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])] }
  checked := by horn_certify

/-- **Trent's definition, with the objections to it**: Paul's gospel and Romans 4. -/
def definitionPremise : RatedStep Claim where
  step := "Trent: justification is the renewal of the inward man (ch. 7)"
  support := (baseCite .justificationIncludesSanctification).source
  register := [gospelOnDefinitionAssessment, romansFourOnDefinitionAssessment]
  strongest := some 0

/-- **Trent's reading of Paul's word, with the objections to it**: Romans 4 on the
word, the strongest known, and the argument from Paul's word. -/
def wordPremise : RatedStep Claim where
  step := "Trent: Paul's δικαιόω denotes renewal (ch. 8, with Augustine)"
  support := (baseCite .paulsJustifyDenotesRenewal).source
  register := [romansFourOnWordAssessment, lexicalOnWordAssessment]
  strongest := some 0

/-- **Trent's step to "faith does not suffice", with the objection to it**: Luke 18. -/
def sufficiencyStep : RatedStep Claim where
  step := trentSufficiencyLine.name
  support := trentSufficiencySource
  register := [luke18OnSufficiencyAssessment]
  strongest := some 0

/-- **Trent's definition, and what follows from it, are disputed under every
standard.** Taken as a claim about what God does, the definition is met by
Paul's gospel and Romans 4. Taken as a claim about Paul's word, it is met by
Romans 4's explanation of the verb. Its step to "faith does not suffice" is met
by Luke 18. Each of those argues from texts and from evidence anyone can check,
so each is an argument under each of the three standards.

It does not show that the definition is false. `disputed` means there
is an argued objection, not that the objection wins. -/
@[headline]
theorem trent_definition_ratings :
    definitionPremise.ratings =
        [ (.evidence, .disputedBy
            ["Paul's gospel (Galatians 1; Westminster XI.1)", "Romans 4:3–8"])
        , (.tradition, .disputedBy
            ["Paul's gospel (Galatians 1; Westminster XI.1)", "Romans 4:3–8"])
            , (.scriptural, .disputedBy
            ["Paul's gospel (Galatians 1; Westminster XI.1)", "Romans 4:3–8"]) ] ∧
      wordPremise.ratings =
        [ (.evidence, .disputedBy ["Romans 4:3–8, on Paul's word",
            "Paul's word (by the rule of least meaning)"])
        , (.tradition, .disputedBy ["Romans 4:3–8, on Paul's word",
            "Paul's word (by the rule of least meaning)"])
        , (.scriptural, .disputedBy ["Romans 4:3–8, on Paul's word",
            "Paul's word (by the rule of least meaning)"]) ] ∧
      sufficiencyStep.ratings =
        [ (.evidence, .disputedBy ["Luke 18:9–14 (the tax collector justified)"])
        , (.tradition, .disputedBy ["Luke 18:9–14 (the tax collector justified)"])
        , (.scriptural, .disputedBy ["Luke 18:9–14 (the tax collector justified)"]) ] := by
  decide +kernel

#print axioms trent_definition_ratings

/-- **Trent's reading of Paul's word, against the step about the word.** It argues
its conclusion from Augustine's explanation: Paul's "justify" means making
righteous. It can be held with every starting point of the step, the courtroom
sense among them, because Trent keeps the verdict: the justified "are not only
reputed, but are truly called, and are, just" (Session VI, ch. 7). So it grants
the step's grounds and argues against what the step draws from them, and under
every standard it is an argument against the step: against the step from the
verdict to "nothing more", which is where Trent's own words put it. -/
def trentWordOnLexicalAssessment : Assessment Claim where
  dissenter := "Trent, with Augustine (ch. 8)"
  against := lexicalLine.name
  dissent :=
    { claim := notP .paulsJustifyDenotesRenewal
    , grounds := lexicalLine.grounds
    , position := trentOnTheWordOfPaul }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.latinWordBearsPaulsSense])
        , (.tradition, [])
        , (.scriptural, [.latinWordBearsPaulsSense]) ] }
  checked := by horn_certify

/-- **Trent's definition taken as a claim about what God does, against the step in
Paul's gospel.** It holds the definition as a premise, and that premise alone
contradicts the step's conclusion. A disagreement, not an argument, under each
of the three standards. -/
def trentGraceOnGospelAssessment : Assessment Claim where
  dissenter := "Trent, read as what God does (ch. 7; Joint Declaration §22)"
  against := "Paul's gospel: a verdict on a finished work is no renewal"
  dissent :=
    { claim := notP .justificationIncludesSanctification
    , grounds := [p .christsWorkIsTheWholeGround, p .dikaioIsForensic, p .romans8_33_34]
    , position := tridentineOnWhatGodDoes }
  findings :=
    { consistent := true, denies := true, grants := true, argued := false, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.justificationIncludesSanctification, .renewalGrowsThroughGoodWorks])
        , (.tradition, [])
        , (.scriptural, [.justificationIncludesSanctification, .renewalGrowsThroughGoodWorks]) ] }
  checked := by horn_certify

/-- **Trent's denial that faith suffices, against Luke 18's step.** It is argued,
from its definition, and it accepts the parable. Its one starting point is the
definition, which rests on the council's word. So it is an argument under the
tradition standard only. -/
def trentSufficiencyOnLuke18Assessment : Assessment Claim where
  dissenter := "Trent, ch. 7 and canon 9"
  against := luke18Line.name
  dissent :=
    { claim := p .faithIsSufficient
    , grounds := luke18Line.grounds
    , position := trentOnSufficiency }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.justificationIncludesSanctification])
        , (.tradition, [])
        , (.scriptural, [.justificationIncludesSanctification]) ] }
  checked := by horn_certify

/-- **The step about Paul's word, with the objection to it**: Trent's reading of the
word, the strongest known. -/
def lexicalWordStep : RatedStep Claim where
  step := lexicalLine.name
  support := leastMeaningSource
  register := [trentWordOnLexicalAssessment]
  strongest := some 0

/-- **The same checks, from Trent's side.** Trent objects three times to the
Reformed steps over its definition.

- Its reading of Paul's word is argued. Trent keeps the courtroom sense, since
  the justified "are not only reputed, but are truly called, and are, just"
  (Session VI, ch. 7), and argues from Augustine that the word means making
  righteous too. So it grants the step's starting points and denies what the
  step draws from them. But Augustine wrote of the Latin *iustificare*, and the
  argument needs the Latin word to bear the sense of Paul's Greek one, δικαιόω.
  Trent says it does (ch. 7–8), and Melanchthon and Calvin deny it. So the
  objection rests at that premise on the council's word, and it is an argument
  under the tradition standard only.
- Its definition, taken as a claim about what God does, is stated and not argued
  against Paul's gospel.
- Its denial that faith suffices is an argument against Luke 18's step under the
  tradition standard only, because its one starting point is the definition.

So the step about Paul's word is disputed by Trent's reading of the word under
the tradition standard. Under the evidence and the Scripture standards it stands
at its cited rating, which is `disputed` already.

What it does not claim: that Trent's reading is right. `disputed` means there
is an argued objection, not that the objection wins. The step's cited rating
agrees with this check: it is `disputed`, and the dispute weighs it so. -/
@[headline]
theorem trent_dissents_from_the_definition_steps :
    trentWordOnLexicalAssessment.findings.kind = .argued ∧
      trentGraceOnGospelAssessment.findings.kind = .asserted ∧
      trentSufficiencyOnLuke18Assessment.profile = [(.evidence, false), (.tradition, true)
      , (.scriptural, false)] ∧
      lexicalWordStep.ratings =
        [(.evidence, .stands .disputed)
        , (.tradition, .disputedBy ["Trent, with Augustine (ch. 8)"])
        , (.scriptural, .stands .disputed)] := by
  decide +kernel

#print axioms trent_dissents_from_the_definition_steps

/-! ### The debate heard under each standard -/

/-- **The record for the debate over James.** Every position that objects to a
step of the other side is entered as an objection and assessed, whichever side
it is on, together with the steps they are rated against. From Trent's side:
its reading of James's word, canon 24, chapter 16 and the reading through Paul,
against the Reformed steps. From the Reformed side: the argument from James's
word, against the reading through Paul; the Reformed reconciliation, against
canon 24's step and chapter 16's, which it meets alike
(`harmony_assessed_alike`); and Westminster on the reward, against Trent's
premise that the reward is given to merits. So each standard hears or sets
aside both sides by one test.

Two kinds of position are not entered. The argument about James's faith objects
to no step of Trent's. Trent's Latin readings of Revelation 22:11 and Sirach
18:22, and the Greek of the two verses, are readings of texts that the texts
themselves answer. -/
def jamesRegister : Register jamesDispute where
  assessmentOf
    | .trentOnTheWord => some trentWordAssessment
    | .trentOnWorks => some canon24Assessment
    | .trentOnReward => some rewardAssessment
    | .renewalOnTheWord => some renewalAssessment
    | .lexical => some lexicalOnRenewalAssessment
    | .harmony => some harmonyOnCanon24Assessment
    | .westminsterOnReward => some westminsterAssessment
    | _ => none
  ownPosition i a h := by
    cases i <;> simp only [Option.some.injEq, reduceCtorEq] at h <;> subst h <;> rfl
  steps := [fruitStep, lexicalStep, canon24Step, rewardStep, renewalStep]

/-- The debate at each standard's ratings. Each position's weakest link is as
cited, with one exception: under the tradition standard the step about James's
word is weighed as `disputed`, which is what is worked out for it there. The
argument from James's word already rests on a premise rated `disputed`, so its
weakest link does not move. -/
declare_rerated jamesRegister rows 2
  /-- **Who defeats whom under each standard**: under every standard, as in the full
  debate. Every answer is worked out from the positions' premises with the
  ratings for that standard, and checked by machine. -/
  defeats fun
    | _ => jamesDispute.defeatsTable

/-- The debate heard under the evidence standard. -/
abbrev jamesUnderEvidence := jamesRegister.hearing .evidence

/-- The debate heard under the tradition standard. -/
abbrev jamesUnderTradition := jamesRegister.hearing .tradition

/-- **Who defeats whom under the evidence standard**: as in the full debate, among
the positions heard. -/
theorem jamesUnderEvidence_defeats :
    ∀ i j, jamesUnderEvidence.defeats i j ↔ (i.1, j.1) ∈ jamesRegister.defeatsTable .evidence :=
  fun i j => jamesRegister_defeats .evidence i.1 j.1

/-- **Who defeats whom under the tradition standard**: as in the full debate, among
the positions heard. -/
theorem jamesUnderTradition_defeats :
    ∀ i j, jamesUnderTradition.defeats i j ↔
      (i.1, j.1) ∈ jamesRegister.defeatsTable .tradition :=
  fun i j => jamesRegister_defeats .tradition i.1 j.1

/-- How the debate is settled under the evidence standard. Every position that
rests at some premise on a council's, a confession's or a theologian's word, and
objects to a step of the other side, is set aside. That is each of Trent's
readings of James 2:24 and of the reward texts, and the reading through Paul; and
on the Reformed side the argument from James's word, which rests on Calvin, and
the Reformed reconciliation, which rests on Westminster and Calvin. What is left
is the argument about James's faith, Westminster's answer on the reward, the
Greek of both verses and Trent's Latin readings of them. The first four are
accepted, and the Latin readings fall to the Greek. -/
declare_verdict underEvidenceSettled for jamesUnderEvidence using (jamesRegister.under .evidence) :
    .groundedExactly
      [Witness.listSub _ [.faith, .revelationText, .sirachText, .westminsterOnReward]]
      (Witness.Table.sub _
        [ (.trentOnRevelation, .revelationText), (.trentOnSirach, .sirachText) ])

/-- How the debate is settled under the tradition standard. The argument about
James's faith and the Greek of both verses are accepted first. The argument from
James's word and the reading through Paul defeat each other. So do the Reformed
reconciliation and each of Trent's readings of what works do. Only Trent's
reading of the word is not heard. -/
declare_verdict underTraditionSettled for jamesUnderTradition
    using (jamesRegister.under .tradition) :
    .groundedExactly
      [Witness.listSub _ [.faith, .revelationText, .sirachText]]
      (Witness.Table.sub _
        [ (.lexical, .renewalOnTheWord), (.renewalOnTheWord, .lexical)
        , (.trentOnRevelation, .revelationText), (.trentOnSirach, .sirachText)
        , (.harmony, .trentOnWorks), (.trentOnWorks, .harmony)
        , (.trentOnReward, .harmony), (.westminsterOnReward, .trentOnReward) ])

/-- The reading through Paul holds that James's "justified" means the increase of
justice. -/
theorem renewal_holds_increase :
    Entails (jamesDispute.node .renewalOnTheWord).premises (p .jamesJustifyDenotesIncrease) := by
  establish [solaFideDefs, jamesDispute]

/-- Why the reading through Paul can be defended under the tradition standard: it
answers the argument from James's word, now that the two are rated alike. -/
declare_verdict renewalHeard for jamesUnderTradition using (jamesRegister.under .tradition) :
    .credulous ⟨.renewalOnTheWord, by decide⟩
      (Witness.listSub _ [.faith, .renewalOnTheWord, .revelationText, .sirachText])

/-- Why the argument from James's word can be defended there: it answers the reading
through Paul. -/
declare_verdict lexicalHeard for jamesUnderTradition using (jamesRegister.under .tradition) :
    .credulous ⟨.lexical, by decide⟩
      (Witness.listSub _ [.lexical, .faith, .revelationText, .sirachText])

/-- **Which readings of James's "by works" each standard hears.** Under the
evidence standard, and under the Scripture standard, which here asks the same,
none of them: Trent's reading of the word, canon 24, the reading through Paul,
the argument from James's word and the Reformed reconciliation are all set
aside. Each rests at some premise on a reader's word. Every one of them needs
James to keep "justify" and "works" in one sense through 2:21–25, which is
Calvin's reading, and Trent's. The argument from James's word needs Calvin's
word besides, that James uses "justify" as it is used outside Paul; the
reconciliation needs Westminster's and Calvin's, that the fruit texts share
their terms. Under the tradition standard all of them are heard but Trent's
reading of the word, which merely states its answer. -/
theorem james_readings_heard :
    (∀ i, i ∈ [JamesParty.trentOnTheWord, .trentOnWorks, .trentOnReward, .renewalOnTheWord,
        .lexical, .harmony] → ¬ jamesRegister.admits .evidence i ∧
          ¬ jamesRegister.admits .scriptural i) ∧
      (∀ i, i ∈ [JamesParty.trentOnWorks, .trentOnReward, .renewalOnTheWord, .lexical,
        .harmony] → jamesRegister.admits .tradition i) ∧
      ¬ jamesRegister.admits .tradition .trentOnTheWord := by
  decide

/-- **What James's "justified" means depends on the standard.**

Under the evidence standard the question is not heard at all. Both readings of
the word are set aside by the same test. The reading through Paul rests on
Trent's word that James's "justified" (δικαιόω) is Paul's. The argument from
James's word rests on Calvin's word that James uses it as it is used outside
Paul. And both rest on Calvin's and Trent's shared reading that James keeps his
words in one sense through 2:21–25. So neither is forced, and neither is
accepted: what is accepted is the argument about James's faith, Westminster's
answer on the reward and the Greek of both verses.

Under the tradition standard both are heard, as in the full debate, and whether
James's word means the increase of justice is contested. Each side can be
defended, and neither is forced.

Under the tradition standard the verdict and the rating agree. Under the evidence
standard they do not line up: the step about James's word stands there at
`wellSupported` (`lexical_step_ratings`), because no objection the standard
admits brings it down, but the argument that takes the step is not heard,
because two of its own premises rest on Calvin's word.

What it does not show: that either reading of the word is wrong, or that no
argument from evidence alone could settle it. It shows that, as the readings
are written down here, each takes a reader's word at a premise the evidence
standard does not admit. -/
@[headline]
theorem james_word_turns_on_the_standard :
    grounded jamesUnderEvidence.defeats =
        Solver.toSet
          (Witness.listSub _ [.faith, .revelationText, .sirachText, .westminsterOnReward]) ∧
      ¬ jamesRegister.admits .evidence .lexical ∧
      ¬ jamesRegister.admits .evidence .renewalOnTheWord ∧
      Nonempty (Contested jamesUnderTradition (p .jamesJustifyDenotesIncrease)) :=
  ⟨underEvidenceSettled.holds, by decide, by decide,
    ⟨{ holder := ⟨.renewalOnTheWord, by decide⟩
       denier := ⟨.lexical, by decide⟩
       holds := renewal_holds_increase
       denies := lexical_denies_increase
       holderDefensible := renewalHeard.holds
       denierDefensible := lexicalHeard.holds }⟩⟩

#print axioms james_word_turns_on_the_standard

/-- **Under the tradition standard, what is forced is the argument about James's
faith and the Greek of the two verses**, and no more. -/
theorem under_tradition_forces :
    grounded jamesUnderTradition.defeats =
      Solver.toSet (Witness.listSub _ [.faith, .revelationText, .sirachText]) :=
  underTraditionSettled.holds

/-- Trent's reading of the reward texts denies that works are fruit and not ground. -/
theorem trentOnReward_denies_fruit :
    Entails (jamesDispute.node .trentOnReward).premises (∼ p .worksAreFruitNotGround) := by
  establish [solaFideDefs, jamesDispute]

/-- Why the Reformed reconciliation can be defended under the tradition standard: it
answers canon 24 and chapter 16. -/
declare_verdict harmonyHeard for jamesUnderTradition using (jamesRegister.under .tradition) :
    .credulous ⟨.harmony, by decide⟩
      (Witness.listSub _ [.lexical, .faith, .harmony, .revelationText, .sirachText])

/-- Why chapter 16's reading of the reward texts can be defended there: it answers
the Reformed reconciliation. -/
declare_verdict rewardHeard for jamesUnderTradition using (jamesRegister.under .tradition) :
    .credulous ⟨.trentOnReward, by decide⟩
      (Witness.listSub _
        [.lexical, .faith, .trentOnWorks, .trentOnReward, .revelationText, .sirachText])

/-- **Whether works are fruit and not ground depends on whether a council's or a
confession's word counts.**

Under the evidence standard the question is not heard. The Reformed
reconciliation derives "fruit, not ground" from Westminster's proof texts, but it
needs Ephesians 2:8–10 and James 2:18 to share "faith" and "works", and only
Westminster (XVI.2) and Calvin (on James 2:18) are cited for that. Canon 24 rests
on the council's word that works cause the increase, and chapter 16 on its word
that the reward is given to merits. So all three are set aside. What is
accepted on the reward is Westminster's answer, which argues from its proof texts
alone that the reward is of grace and not rendered to merits. That is not the
claim that works are fruit and not ground.

Under the tradition standard all three are heard, the step is weighed at
`disputed`, and the question is contested. The reconciliation and chapter 16's
reading of the reward texts can each be defended, and neither is forced. There
the verdict and the rating agree. Under the evidence standard the step stands at
`wellSupported` (`fruit_step_ratings`) while the reconciliation that takes it is
not heard, because the premise that the fruit texts share their terms is one of
the step's own grounds, and it rests on Westminster's and Calvin's word.

What it does not show: that works are a cause of the increase of justification,
or that the reward texts teach Trent's reading. -/
@[headline]
theorem fruit_turns_on_the_standard :
    grounded jamesUnderEvidence.defeats =
        Solver.toSet
          (Witness.listSub _ [.faith, .revelationText, .sirachText, .westminsterOnReward]) ∧
      ¬ jamesRegister.admits .evidence .harmony ∧
      Nonempty (Contested jamesUnderTradition (p .worksAreFruitNotGround)) :=
  ⟨underEvidenceSettled.holds, by decide,
    ⟨{ holder := ⟨.harmony, by decide⟩
       denier := ⟨.trentOnReward, by decide⟩
       holds := harmony_holds_fruit
       denies := trentOnReward_denies_fruit
       holderDefensible := harmonyHeard.holds
       denierDefensible := rewardHeard.holds }⟩⟩

#print axioms fruit_turns_on_the_standard

end TestimonyArguments.SolaFide
