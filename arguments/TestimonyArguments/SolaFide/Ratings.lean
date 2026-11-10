import TestimonyArguments.SolaFide.Vulgate
import Testimony.Logic.Credibility
import Testimony.Logic.Contest
import TestimonyArguments.Meanings.SolaFide
import TestimonyArguments.SolaFide.Definition
import TestimonyArguments.SolaFide.JesusWords
import Testimony.Logic.Certificate

/-!
# TestimonyArguments.SolaFide.Ratings — is an objection an argument, or only a disagreement?

A step is rated `disputed` when someone objects to it. A reader's next question
is: **is the objection an argument, or only a disagreement?** This section asks
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

Before the reading through Paul was written down, the same checks refused any
rating above `disputed` under all three standards, because the strongest known
objection was missing (`lexical_step_before_the_steelman`). Writing down the
strongest objection is what permits the higher rating, and only where that
objection fails.

## Works as fruit, not ground

Westminster's step (`fruitLine`) derives "fruit, not ground" from its proof
texts. Its support is `wellSupported`: the Lutheran World Federation and the
Catholic Church confess together that good works "follow justification and are
its fruits", and that what follows faith "is neither the basis of justification
nor merits it" (*Joint Declaration* §§37, 25). Two objections are written down,
both from Trent, and both argued.

- **Canon 24, applied to James 2:24**: works cause the increase of
  justification. That claim rests on the council's word alone.
- **Chapter 16, from the texts that promise a reward** (1 Corinthians 15:58,
  Hebrews 6:10, Hebrews 10:35, 2 Timothy 4:8). The texts are Scripture, and
  Westminster accepts them (XVI.6). But they say God *rewards* the works.
  Chapter 16 adds that the reward is "rendered to their good works and merits",
  and that "we must believe" the justified "have truly merited eternal life".
  The passage from reward to merit is the council's own claim. Dulles, defending
  Trent's teaching, grants that "the fact that a reward is promised does not
  make it merited". The *Joint Declaration* reads "merit" as no more than a
  reward promised (§38).

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

- **Its reading of Paul's word** objects to a starting point of the step about
  the word, not to the step. That starting point says the verb is a verdict *and
  not* making righteous, so what Trent concludes is what the starting point
  denies. The step's support stands at `wellSupported` under all three
  standards.
- **Its definition, taken as a claim about what God does**, is stated, not
  argued, against Paul's gospel: Trent holds it as a premise.
- **Its denial that faith suffices** is an argument against Luke 18's step under
  the tradition standard only. Its one starting point is the definition, which
  rests on the council's word.

The question of the word is decided at the two sides' premises. The argument
from Paul's word holds the courtroom sense as a premise, cited to the lexicon.
Trent holds the renewal sense, cited to itself and to VanLandingham. Each
premise, by what it means, denies the other, so against each other each is a
rival reading and not an argument (`lexicalOnWordAssessment`). That is why the
argued objection on the word is the one from Romans 4, which reaches its
conclusion from the text.

## Claims that exclude each other by their meaning

Some claims that are listed separately exclude each other by what they mean.
"The verb is a verdict, and not making righteous" denies "Paul's verb means
making righteous" in so many words. Every check here takes those exclusions as
given (`Meanings.SolaFide.joins`), in the same way for an objection on either
side, and the list is proved to contain exactly the exclusions the meanings
imply. Without them, Trent's reading of the word would count as accepting a
starting point that it in fact denies.

## The debate heard under each standard

Which objections are arguments decides who is heard, and how each step is
weighed. Under a given standard, the debate over James (`jamesDispute`) is heard
among every position that is not an objection, together with every objection
that counts as an argument under that standard, and each rated step is weighed
at the rating worked out under that standard. So who is heard and how the steps
are weighed come from one record, and cannot disagree about the standard.

- **What James's "justified" means depends on the standard**
  (`james_word_turns_on_the_standard`). Under the evidence standard the argument
  from James's word is forced, as in the full debate: the reading through Paul
  is not heard. Under the tradition standard it is heard, the step about the
  word is weighed at `disputed`, and the question is contested. The argument
  from James's word and the reading through Paul can each be defended, and
  neither is forced.
- **Whether works are fruit and not ground depends on the standard too**
  (`fruit_turns_on_the_standard`). Under the evidence standard, the Reformed
  reconciliation and Westminster's answer on the reward are forced. Neither of
  Trent's objections is heard. Under the tradition standard both are heard. The
  reconciliation and chapter 16's reading can each be defended, and so can
  Westminster's answer and chapter 16, which defeat each other. None of them is
  forced.

In both cases the rating and the verdict agree. A step rated `disputed` under a
standard is contested when the debate is heard under it, and a step whose
support stands is forced.

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
        [ (.evidence, [.worksCauseIncreaseOfJustification])
        , (.tradition, [])
        , (.scriptural, [.worksCauseIncreaseOfJustification]) ] }
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
        [ (.evidence, [.jamesJustifyDenotesIncrease])
        , (.tradition, [])
        , (.scriptural, [.jamesJustifyDenotesIncrease]) ] }
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
        [ (.evidence, [.jamesUsesDikaioAsPaul])
        , (.tradition, [])
        , (.scriptural, [.jamesUsesDikaioAsPaul]) ] }
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

What this does not claim: that the reward texts teach the Reformed reading. It
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
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])] }
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
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])] }
  checked := by horn_certify

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

/-- **The same checks, applied the other way: Rome's steps are disputed under every
standard.** Westminster's answer to Trent's premise about merit, and the
Reformed reconciliation's answers to canon 24's step and chapter 16's, each
argue from texts and rest on no one's word alone. So each counts as an argument
under the evidence standard as under the tradition standard, and each of Trent's
claims is `disputed` under both.

Set beside `fruit_step_ratings`, this is the difference the checks find. The
Reformed objections to Trent's claims are arguments under each of the three
standards. Trent's objections to the Reformed step are arguments only under the
standard that allows the council's word.

What this does not claim: that either side's step is right. -/
@[headline]
theorem rome_steps_ratings :
    meritPremise.ratings =
        [ (.evidence, .disputedBy ["Westminster XVI.5, XVI.6"])
        , (.tradition, .disputedBy ["Westminster XVI.5, XVI.6"])
        , (.scriptural, .disputedBy ["Westminster XVI.5, XVI.6"]) ] ∧
      canon24Step.ratings =
        [ (.evidence, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"])
        , (.tradition, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"])
        , (.scriptural, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"]) ] ∧
      rewardStep.ratings =
        [ (.evidence, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"])
        , (.tradition, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"])
        , (.scriptural, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"]) ] := by
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
  , grounds := [p .augustineReadsJustifyAsMakeRighteous]
  , step := p .augustineReadsJustifyAsMakeRighteous ➝ p .paulsJustifyDenotesRenewal
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
about the word.** It holds as a premise that Paul's "justify" is a verdict and
*not* making righteous, and that premise, by what it means, already denies
Trent's reading (`Meanings.SolaFide.joins`). So against that reading it is a
rival reading held as a premise, and by the checks a disagreement, not an
argument. It rests on the lexicon, and it stands or falls with that premise's
own rating. Trent's reading stands in the same place against it
(`trentWordOnLexicalAssessment`). -/
def lexicalOnWordAssessment : Assessment Claim where
  dissenter := "Paul's word (by the rule of least meaning)"
  against := "Trent: Paul's δικαιόω denotes renewal (ch. 8, with Augustine)"
  dissent :=
    { claim := p .paulsJustifyDenotesRenewal
    , position := lexicalCase }
  findings :=
    { consistent := true, denies := true, grants := true, argued := false, bareDenial := false
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

What this does not claim: that the definition is false. `disputed` means there
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
        [ (.evidence, .disputedBy ["Romans 4:3–8, on Paul's word"])
        , (.tradition, .disputedBy ["Romans 4:3–8, on Paul's word"])
        , (.scriptural, .disputedBy ["Romans 4:3–8, on Paul's word"]) ] ∧
      sufficiencyStep.ratings =
        [ (.evidence, .disputedBy ["Luke 18:9–14 (the tax collector justified)"])
        , (.tradition, .disputedBy ["Luke 18:9–14 (the tax collector justified)"])
        , (.scriptural, .disputedBy ["Luke 18:9–14 (the tax collector justified)"]) ] := by
  decide +kernel

#print axioms trent_definition_ratings

/-- **Trent's reading of Paul's word, against the step about the word.** It argues
its conclusion from Augustine's explanation. But what it concludes, that Paul's
"justify" means making righteous, is what the step's first starting point
denies: that starting point says the verb is a verdict *and not* making
righteous (`Meanings.SolaFide.joins`). So it objects to that starting point and
not to the step, and belongs to the rating of the starting point, under any
standard. -/
def trentWordOnLexicalAssessment : Assessment Claim where
  dissenter := "Trent, with Augustine (ch. 8)"
  against := lexicalLine.name
  dissent :=
    { claim := notP .paulsJustifyDenotesRenewal
    , grounds := lexicalLine.grounds
    , position := trentOnTheWordOfPaul }
  findings :=
    { consistent := true, denies := true, grants := false, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])] }
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

- Its reading of Paul's word objects to a starting point of the step about the
  word, not to the step.
- Its definition, taken as a claim about what God does, is stated and not argued
  against Paul's gospel.
- Its denial that faith suffices is an argument against Luke 18's step under the
  tradition standard only, because its one starting point is the definition.

So the support for the step about Paul's word stands at `wellSupported` under
all three standards: the strongest known objection to it is written down, and
fails. -/
@[headline]
theorem trent_dissents_from_the_definition_steps :
    trentWordOnLexicalAssessment.findings.kind = .deniesGrounds ∧
      trentGraceOnGospelAssessment.findings.kind = .asserted ∧
      trentSufficiencyOnLuke18Assessment.profile = [(.evidence, false), (.tradition, true)
      , (.scriptural, false)] ∧
      lexicalWordStep.ratings =
        [(.evidence, .stands .wellSupported), (.tradition, .stands .wellSupported)
        , (.scriptural, .stands .wellSupported)] := by
  decide +kernel

#print axioms trent_dissents_from_the_definition_steps

/-! ### The debate heard under each standard -/

/-- **The record for the debate over James.** Each position that objects to a step
of the Reformed reading is entered as an objection and assessed, together with
the two steps they are rated against. The other positions hold those steps, or
are readings of texts that the texts themselves answer. -/
def jamesRegister : Register jamesDispute where
  assessmentOf
    | .trentOnTheWord => some trentWordAssessment
    | .trentOnWorks => some canon24Assessment
    | .trentOnReward => some rewardAssessment
    | .renewalOnTheWord => some renewalAssessment
    | .westminsterOnReward => some westminsterAssessment
    | _ => none
  ownPosition i a h := by
    cases i <;> simp only [Option.some.injEq, reduceCtorEq] at h <;> subst h <;> rfl
  steps := [fruitStep, lexicalStep, canon24Step, rewardStep]

/-- Each position's weakest link under a given standard. It is as cited, with one
exception: under the tradition standard the argument from James's word is
weighed as `disputed`, which is what is worked out for it there. -/
def ratedStrength : Standard → JamesParty → ℕ
  | .tradition, .lexical => 0
  | _, i => jamesPartyStrength i

/-- Each position's weakest link, as worked out from its premises with the ratings
for that standard. -/
theorem rerated_strength (s : Standard) :
    ∀ i, ((jamesRegister.rerated s).node i).strength = ratedStrength s i := by
  intro i
  cases s <;> cases i <;> decide +kernel

/-- Who defeats whom under a given standard. Under the evidence standard, as in the
full debate. Under the tradition standard there is one difference: Trent's
reading of the word and the reading through Paul each defeat the argument from
James's word, now that it is weighed as `disputed`. -/
def ratedDefeats : Standard → JamesParty → JamesParty → Prop
  | .tradition, .trentOnTheWord, .lexical => True
  | .tradition, .renewalOnTheWord, .lexical => True
  | _, i, j => jamesPartyDefeats i j

/-- The table is finite, so membership in it is decidable. -/
instance (s : Standard) : DecidableRel (ratedDefeats s) := fun i j => by
  cases s <;> cases i <;> cases j <;> unfold ratedDefeats <;> infer_instance

/-- The first six rows of the table under the evidence standard, worked out from the
positions' premises with the ratings for that standard, and checked by machine.
The table is proved in four parts, by standard and by row, only to keep each
proof within the time the checker allows. -/
private theorem rerated_evidence_first (i : JamesParty)
    (hi : i ∈ [.lexical, .faith, .harmony, .trentOnTheWord, .trentOnWorks, .trentOnRevelation])
    (j : JamesParty) :
    (jamesRegister.rerated .evidence).defeats i j ↔ ratedDefeats .evidence i j := by
  refine Horn.defeats_iff_of_certified
    (rerated_strength .evidence i) (rerated_strength .evidence j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> horn_certify

/-- The same rows under the Scripture standard. -/
private theorem rerated_scriptural_first (i : JamesParty)
    (hi : i ∈ [.lexical, .faith, .harmony, .trentOnTheWord, .trentOnWorks, .trentOnRevelation])
    (j : JamesParty) :
    (jamesRegister.rerated .scriptural).defeats i j ↔ ratedDefeats .scriptural i j := by
  refine Horn.defeats_iff_of_certified
    (rerated_strength .scriptural i) (rerated_strength .scriptural j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> horn_certify

/-- The other six rows at the evidence standard. -/
private theorem rerated_evidence_second (i : JamesParty)
    (hi : i ∈ [.trentOnSirach, .revelationText, .sirachText, .trentOnReward,
      .renewalOnTheWord, .westminsterOnReward])
    (j : JamesParty) :
    (jamesRegister.rerated .evidence).defeats i j ↔ ratedDefeats .evidence i j := by
  refine Horn.defeats_iff_of_certified
    (rerated_strength .evidence i) (rerated_strength .evidence j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> horn_certify

/-- The same rows under the Scripture standard. -/
private theorem rerated_scriptural_second (i : JamesParty)
    (hi : i ∈ [.trentOnSirach, .revelationText, .sirachText, .trentOnReward,
      .renewalOnTheWord, .westminsterOnReward])
    (j : JamesParty) :
    (jamesRegister.rerated .scriptural).defeats i j ↔ ratedDefeats .scriptural i j := by
  refine Horn.defeats_iff_of_certified
    (rerated_strength .scriptural i) (rerated_strength .scriptural j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> horn_certify

/-- The first six rows at the tradition standard. -/
private theorem rerated_tradition_first (i : JamesParty)
    (hi : i ∈ [.lexical, .faith, .harmony, .trentOnTheWord, .trentOnWorks, .trentOnRevelation])
    (j : JamesParty) :
    (jamesRegister.rerated .tradition).defeats i j ↔ ratedDefeats .tradition i j := by
  refine Horn.defeats_iff_of_certified
    (rerated_strength .tradition i) (rerated_strength .tradition j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> horn_certify

/-- The other six rows at the tradition standard. -/
private theorem rerated_tradition_second (i : JamesParty)
    (hi : i ∈ [.trentOnSirach, .revelationText, .sirachText, .trentOnReward,
      .renewalOnTheWord, .westminsterOnReward])
    (j : JamesParty) :
    (jamesRegister.rerated .tradition).defeats i j ↔ ratedDefeats .tradition i j := by
  refine Horn.defeats_iff_of_certified
    (rerated_strength .tradition i) (rerated_strength .tradition j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> horn_certify

/-- **Who defeats whom under each standard.** -/
theorem rerated_defeats (s : Standard) :
    ∀ i j, (jamesRegister.rerated s).defeats i j ↔ ratedDefeats s i j := by
  intro i j
  cases s <;> cases i
  all_goals first
    | (refine rerated_evidence_first _ ?_ j; decide)
    | (refine rerated_evidence_second _ ?_ j; decide)
    | (refine rerated_tradition_first _ ?_ j; decide)
    | (refine rerated_tradition_second _ ?_ j; decide)
    | (refine rerated_scriptural_first _ ?_ j; decide)
    | (refine rerated_scriptural_second _ ?_ j; decide)

/-- The debate under a given standard, in the form the solver works with. -/
def ratedFinite (s : Standard) : Solver.Finite (jamesRegister.rerated s).defeats where
  parties := jamesFinite.parties
  complete := jamesFinite.complete
  defeats i j := decide (ratedDefeats s i j)
  spec i j := by rw [rerated_defeats]; simp

/-- The debate heard under the evidence standard. -/
abbrev jamesUnderEvidence := jamesRegister.hearing .evidence

/-- The debate heard under the tradition standard. -/
abbrev jamesUnderTradition := jamesRegister.hearing .tradition

/-- The debate heard under a standard, in the form the solver works with. -/
abbrev jamesUnderFinite (s : Standard) :=
  (ratedFinite s).restrict (jamesRegister.admits s)

/-- **Who defeats whom under the evidence standard**: as in the full debate, among
the positions heard. -/
theorem jamesUnderEvidence_defeats :
    ∀ i j, jamesUnderEvidence.defeats i j ↔ ratedDefeats .evidence i.1 j.1 :=
  fun i j => rerated_defeats .evidence i.1 j.1

/-- **Who defeats whom under the tradition standard**: the argument from James's
word, weighed as `disputed`, and the reading through Paul defeat each other. -/
theorem jamesUnderTradition_defeats :
    ∀ i j, jamesUnderTradition.defeats i j ↔ ratedDefeats .tradition i.1 j.1 :=
  fun i j => rerated_defeats .tradition i.1 j.1

/-- How the debate is settled under the evidence standard. The argument from James's
word, the argument about James's faith, the Reformed reconciliation and the
Greek of both verses are accepted first, and nothing heard answers them. Trent's
Latin readings fall to the Greek. Every objection of Trent's to a rated step,
namely canon 24, chapter 16, the reading through Paul, and Trent's reading of
the word, either rests at some claim on the council's word or merely states its
denial, and so is not heard. -/
def underEvidenceSettled : Verdict jamesUnderEvidence where
  finite := jamesUnderFinite .evidence
  claim := .groundedExactly
    [Witness.listSub _
      [.lexical, .faith, .harmony, .revelationText, .sirachText, .westminsterOnReward]]
    (Witness.Table.sub _
      [ (.trentOnRevelation, .revelationText), (.trentOnSirach, .sirachText) ])
  checked := by decide +kernel

/-- How the debate is settled under the tradition standard. The argument about
James's faith and the Greek of both verses are accepted first. The argument from
James's word and the reading through Paul defeat each other. So do the Reformed
reconciliation and each of Trent's readings of what works do. Only Trent's
reading of the word is not heard. -/
def underTraditionSettled : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .groundedExactly
    [Witness.listSub _ [.faith, .revelationText, .sirachText]]
    (Witness.Table.sub _
      [ (.lexical, .renewalOnTheWord), (.renewalOnTheWord, .lexical)
      , (.trentOnRevelation, .revelationText), (.trentOnSirach, .sirachText)
      , (.harmony, .trentOnWorks), (.trentOnWorks, .harmony)
      , (.trentOnReward, .harmony), (.westminsterOnReward, .trentOnReward) ])
  checked := by decide +kernel

/-- The reading through Paul holds that James's "justified" means the increase of
justice. -/
theorem renewal_holds_increase :
    Entails (jamesDispute.node .renewalOnTheWord).premises (p .jamesJustifyDenotesIncrease) := by
  establish [solaFideDefs, jamesDispute]

/-- The argument from James's word denies it. -/
theorem lexical_denies_increase :
    Entails (jamesDispute.node .lexical).premises (∼ p .jamesJustifyDenotesIncrease) := by
  establish [solaFideDefs, jamesDispute]

/-- Why the reading through Paul can be defended under the tradition standard: it
answers the argument from James's word, now that the two are rated alike. -/
def renewalHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.renewalOnTheWord, by decide⟩
    (Witness.listSub _ [.faith, .renewalOnTheWord, .revelationText, .sirachText])
  checked := by decide +kernel

/-- Why the argument from James's word can be defended there: it answers the reading
through Paul. -/
def lexicalHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.lexical, by decide⟩
    (Witness.listSub _ [.lexical, .faith, .revelationText, .sirachText])
  checked := by decide +kernel

/-- **What James's "justified" means depends on the standard, and the verdict and
the rating agree.**

Under the evidence standard the argument from James's word is forced, with the
argument about James's faith and the Greek of both verses. The reading through
Paul is not heard, because it rests on Trent's word that James's "justified"
(δικαιόω) is Paul's.

Under the tradition standard the reading through Paul is heard, the step about
the word is weighed at the rating worked out for it there, `disputed`, and
whether James's word means the increase of justice is contested. Each side can
be defended, and neither is forced. -/
@[headline]
theorem james_word_turns_on_the_standard :
    grounded jamesUnderEvidence.defeats =
        Solver.toSet
          (Witness.listSub _
            [.lexical, .faith, .harmony, .revelationText, .sirachText, .westminsterOnReward]) ∧
      Nonempty (Contested jamesUnderTradition (p .jamesJustifyDenotesIncrease)) :=
  ⟨underEvidenceSettled.holds,
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
def harmonyHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.harmony, by decide⟩
    (Witness.listSub _ [.lexical, .faith, .harmony, .revelationText, .sirachText])
  checked := by decide +kernel

/-- Why chapter 16's reading of the reward texts can be defended there: it answers
the Reformed reconciliation. -/
def rewardHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.trentOnReward, by decide⟩
    (Witness.listSub _
      [.lexical, .faith, .trentOnWorks, .trentOnReward, .revelationText, .sirachText])
  checked := by decide +kernel

/-- **Whether works are fruit and not ground depends on whether a council's word
counts, and the verdict and the rating agree.**

Under the evidence standard the Reformed reconciliation is forced. It derives
"fruit, not ground" from Westminster's proof texts. Neither of Trent's
objections is heard: each rests at one claim on the council's word.

Under the tradition standard both are heard, the step is weighed at `disputed`,
and the question is contested. The reconciliation and chapter 16's reading of
the reward texts can each be defended, and neither is forced. -/
@[headline]
theorem fruit_turns_on_the_standard :
    grounded jamesUnderEvidence.defeats =
        Solver.toSet
          (Witness.listSub _
            [.lexical, .faith, .harmony, .revelationText, .sirachText, .westminsterOnReward]) ∧
      Nonempty (Contested jamesUnderTradition (p .worksAreFruitNotGround)) :=
  ⟨underEvidenceSettled.holds,
    ⟨{ holder := ⟨.harmony, by decide⟩
       denier := ⟨.trentOnReward, by decide⟩
       holds := harmony_holds_fruit
       denies := trentOnReward_denies_fruit
       holderDefensible := harmonyHeard.holds
       denierDefensible := rewardHeard.holds }⟩⟩

#print axioms fruit_turns_on_the_standard

end TestimonyArguments.SolaFide
