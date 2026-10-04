import Testimony.Arguments.SolaFide.Vulgate
import Testimony.Logic.Credibility
import Testimony.Logic.Contest
import Testimony.Meanings.SolaFide
import Testimony.Arguments.SolaFide.Definition
import Testimony.Arguments.SolaFide.JesusWords

/-!
# Arguments.SolaFide.Ratings — which dissents from the James steps are critiques

A step is rated `disputed` when someone dissents from it. The reader's question
is the next one: **is the dissent an argument, or only a disagreement?** This
module asks it of every dissent the library encodes from two steps of the
Reformed reading of James, using the checks of `Testimony.Logic.Credibility`. A
credible dissent:

- is consistent;
- denies the claim;
- grants the step's grounds;
- argues its denial by a step of its own, rather than asserting it;
- rests its grounds on what a stated standard admits.

There are two standards, and every result is computed under both. The
**evidence** standard admits Scripture and evidence anyone can check; the
**tradition** standard also admits a council's or a confession's word.

## James's word: how a rating moves

The lexical step reads James's δικαιόω as the declarative sense the word has
outside Paul (`jamesLexicalLine`). Two dissents from it are encoded.

- **Trent's reading of the word** holds the increase of justice as a premise:
  a disagreement, not a critique, under any standard.
- **The renewal reading** argues it. Paul's δικαιόω denotes renewal, as
  VanLandingham argues from the lexicon and Augustine glossed it; James's word
  is Paul's; and James says Abraham was justified by works after Genesis 15:6.
  This is the strongest dissent the library has found, and it is a critique —
  but one of its grounds, that James's word is Paul's, rests on Trent's word
  alone (chapter 10). No exegete's statement of it has been verified.

So the step's rating turns on the authority question, and the page says so
(`lexical_step_ratings`). Under the evidence standard its support stands at
`wellSupported`, because every encoded dissent fails, the strongest among them.
Under the tradition standard it is `disputed` by the renewal reading. Before the
renewal reading was encoded, the same computation withheld any rating above
`disputed` under both standards, because the strongest dissent was missing
(`lexical_step_before_the_steelman`). Encoding it is what licenses the higher
rating, and only where it fails.

## Works as fruit, not ground

Westminster's step (`fruitLine`) derives "fruit, not ground" from its proof
texts. Its support is `wellSupported`: the Lutheran World Federation and the
Catholic Church confess together that good works "follow justification and are
its fruits", and that what follows faith "is neither the basis of justification
nor merits it" (*Joint Declaration* §§37, 25). Two dissents from it are encoded,
both from Trent, and both argued.

- **Canon 24, applied to James 2:24**: works cause the increase of
  justification. That claim rests on the council's word alone.
- **Chapter 16, from the reward texts** (1 Corinthians 15:58, Hebrews 6:10,
  Hebrews 10:35, 2 Timothy 4:8). The texts are Scripture, and Westminster grants
  them (XVI.6). But they say God *rewards* the works. Chapter 16 adds that the
  reward is "rendered to their good works and merits", and that "we must believe"
  the justified "have truly merited eternal life". That bridge from reward to
  merit is the council's own claim. Dulles, defending Trent's teaching, grants
  that "the fact that a reward is promised does not make it merited". The Joint
  Declaration reads "merit" as no more than a reward promised (§38).

So each of Trent's dissents rests at one claim on the council's word, and the
step's rating turns on the authority question (`fruit_step_ratings`). Under the
evidence standard neither dissent is credible, and the support stands at
`wellSupported`. Under the tradition standard both are, and the step is
`disputed`.

What this shows is exactly that, and no more. Trent's denial does not stand on
Scripture and evidence alone. A reader who receives the council's word has a
credible critique; a reader who does not has none. It does not show that the
reward texts teach the Reformed reading of them; it shows that they do not
teach Trent's without Trent.

## The same checks, run the other way

A check applied in one direction only is a weapon, not a measure. So the
Reformed dissents from Rome's claims are assessed by the same checks, under the
same two standards.

- **Westminster against chapter 16's merit premise** (XVI.5, XVI.6). God does
  not forget the work of believers. That is Hebrews 6:10, which Westminster
  gives as a proof and which is one of Trent's own four texts. Having done all,
  believers are unworthy servants who have done only their duty (Luke 17:10).
  Wages are reckoned as due to one who works, but as a gift to one who believes
  (Romans 4:4–5). Their sacrifices are acceptable to God through Jesus Christ
  (1 Peter 2:5). So the reward is of grace, not rendered to merits. Every claim
  Westminster asserts outright is a text it cites. What is its own is the step,
  a reading rated `disputed` (`westminster_answers_from_the_texts`).
- **The Reformed harmony against canon 24's step, and against chapter 16's.** It
  grants each step's grounds, and argues from Westminster's proof texts that
  works are the fruit of faith, not its ground.

Each is a critique under **both** standards, so each of Trent's claims is
`disputed` under both (`rome_steps_ratings`). Set beside `fruit_step_ratings`,
that is the asymmetry the checks find. The Reformed dissents from Trent are
critiques under either standard. Trent's dissents from the Reformed step are
critiques only under the standard that admits the council's word. Neither side's
step is proved right by this. What differs is what each side's dissent rests on.

## Trent's definition, and faith's sufficiency

Trent's definition — justification is not remission of sins only, but the
renewal of the inward man (ch. 7) — can be read two ways
(`whatTrentsDefinitionClaims`), and Trent draws from it that faith does not
suffice (ch. 7, canon 9). The checks run on each, in both directions.

From the Reformed side, each is a critique under **both** standards
(`trent_definition_ratings`):

- Paul's gospel and Romans 4 against the definition, read as what God does;
- Romans 4, glossing Paul's verb by Paul's own text, against the definition read
  as Paul's word;
- Luke 18 against the step to "faith does not suffice".

So each of Trent's three claims is `disputed` under both standards.

From Trent's side (`trent_dissents_from_the_definition_steps`):

- **Its reading of Paul's word** dissents from the lexical step's ground, not
  from the step. "Forensic", in that ground, means a verdict *and not* making
  righteous, so what Trent concludes is what the ground denies. The lexical
  step's support stands at `wellSupported` under both standards.
- **Its definition, read as what God does**, is asserted, not argued, against
  Paul's gospel: Trent holds it as a premise.
- **Its denial of sufficiency** is a critique of Luke 18's step under the
  tradition standard only. Its one ground is the definition, which rests on the
  council's word.

The word question is settled where both sides' readings stand: at their
premises. The lexical case holds the forensic sense as a premise cited to the
lexicon; Trent holds the renewal sense, cited to itself and VanLandingham. By
their meanings each denies the other, so against each other each is a rival
reading, not an argument (`lexicalOnWordAssessment`). That is why the argued
dissent on the word is Romans 4's, which reaches its verdict from the text.

## Meaning postulates

Some claims the atom type keeps apart are joined by their meanings: "δικαιόω is
forensic — a verdict, and not making righteous" denies "Paul's δικαιόω denotes
making righteous" in so many words. Every check here holds those joins as
background (`Meanings.SolaFide.postulates`), the same for a dissent on either
side, and they are exactly the exclusions the meanings contain
(`Meanings.SolaFide.exclusions_from_meanings`). Without them, Trent's reading of
the word would pass as granting a ground it denies.

## The hearing under each standard

Which dissents are critiques decides who is heard, and how each step is weighed.
The hearing under a standard (`Testimony.Logic.Register`) is the James dispute
(`jamesDispute`) among every party that is not a dissent and every dissent that
is credible under the standard, with each rated step weighed at its computed
rating under that standard. So the dissents heard and the ratings weighed come
from one register, and the hearing's verdict and the step's rating cannot
disagree about the standard.

- **What James's δικαιόω denotes turns on the standard**
  (`james_word_turns_on_the_standard`). Under the evidence standard the hearing
  forces James's word, as the full dispute does: the renewal reading is not
  heard. Under the tradition standard it is heard, the lexical step is weighed at
  `disputed`, and the question is contested — James's word and the renewal
  reading each survive, and neither is forced.
- **Whether works are fruit and not ground turns on the standard too**
  (`fruit_turns_on_the_standard`). Under the evidence standard the hearing
  forces the Reformed harmony and Westminster's answer on the reward. Neither of
  Trent's dissents is heard. Under the tradition standard both are heard. The
  harmony and chapter 16's reading each survive, and so do Westminster's answer
  and chapter 16, which defeat each other; none of them is forced.

In both, the register's rating and the hearing's verdict agree. A step rated
`disputed` under a standard is contested in the hearing under it, and a step
whose support stands is forced.

The full dispute still weighs every step at its *cited* rating. For the lexical
step that is `wellSupported`, its computed rating under the evidence standard;
under the tradition standard the hearing, not the full dispute, is the coherent
result. Making every dispute weigh computed ratings is phase two of the design
(`docs/src/computed-ratings.md`).

## What this does not show

A credible dissent does not show the step wrong, and an answered one does not
show it right. Credibility says the dispute is a dispute between arguments;
which prevails is what the hearing computes, from the ratings each side rests
on.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Logic.Framework

/-! ### The dissents, assessed -/

/-- **Canon 24, against "fruit, not ground"**: argued, and granting
Westminster's proof texts. It asserts that good works are a cause of the
increase of justification on the council's word alone, so it is a critique
under the tradition standard and not under the evidence standard. -/
def canon24Assessment : Assessment Claim where
  dissenter := "Trent, canon 24"
  against := fruitLine.name
  dissent :=
    { claim := p .worksAreFruitNotGround
    , grounds := fruitLine.grounds
    , position := catholicJamesOnWorks
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, [.worksCauseIncreaseOfJustification]), (.tradition, [])] }
  checked := by decide +kernel

/-- **Chapter 16, against "fruit, not ground"**: argued, and granting
Westminster's proof texts. Its grounds are the reward texts, which are Scripture
and which Westminster grants, and the claim that the reward is rendered to the
works as merits — which the texts do not say, and Trent asserts on its own word
("we must believe"). So it is a critique under the tradition standard, and not
under the evidence standard. -/
def rewardAssessment : Assessment Claim where
  dissenter := "Trent, Session VI, ch. 16"
  against := fruitLine.name
  dissent :=
    { claim := p .worksAreFruitNotGround
    , grounds := fruitLine.grounds
    , position := trentOnReward
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, [.rewardRenderedToMerits]), (.tradition, [])] }
  checked := by decide +kernel

/-- **Trent's reading of James's word, against the lexical step**: it holds that
James's δικαιόω denotes the increase of justice as a premise, and that premise
alone contradicts the step's conclusion. A disagreement, not a critique, under
any standard. -/
def trentWordAssessment : Assessment Claim where
  dissenter := "Trent, Session VI, ch. 10"
  against := jamesLexicalLine.name
  dissent :=
    { claim := notP .jamesJustifyDenotesIncrease
    , grounds := jamesLexicalLine.grounds
    , position := catholicJamesOnTheWord
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := false, bareDenial := false
    , unadmitted := [(.evidence, [.jamesJustifyDenotesIncrease]), (.tradition, [])] }
  checked := by decide +kernel

/-- **The renewal reading, against the lexical step**: argued from Paul's word
as renewal and James's word as Paul's, granting the lexical case's grounds. It
is a critique under the tradition standard; under the evidence standard one of
its grounds, that James's word is Paul's, rests on Trent's word alone. -/
def renewalAssessment : Assessment Claim where
  dissenter := "The renewal reading"
  against := jamesLexicalLine.name
  dissent :=
    { claim := notP .jamesJustifyDenotesIncrease
    , grounds := jamesLexicalLine.grounds
    , position := renewalOnTheWord
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, [.jamesUsesDikaioAsPaul]), (.tradition, [])] }
  checked := by decide +kernel

/-- **Trent's reading of James's word is a disagreement, not a critique.** What
it asserts outright includes the increase of justice, which alone contradicts the
lexical step's conclusion: no step of its own is needed to reach its denial. -/
theorem trent_on_the_word_is_asserted :
    trentWordAssessment.findings.kind = .asserted ∧
      ∀ s, ¬ Dissent.Credible s trentWordAssessment.dissent := by
  refine ⟨by decide, fun s => trentWordAssessment.complete ?_⟩
  cases s <;> decide

/-! ### The steps, rated -/

/-- **"Works are fruit, not ground", rated by its register**: canon 24's
dissent and chapter 16's. Chapter 16's is the strongest known: it argues from
texts both sides grant. -/
def fruitStep : RatedStep Claim where
  step := fruitLine.name
  support := fruitSource
  register := [canon24Assessment, rewardAssessment]
  strongest := some 1

/-- **"Fruit, not ground" turns on the authority question.** Under the evidence
standard its support stands at `wellSupported`: both of Trent's dissents are
argued, and each rests at one claim on the council's word alone. Canon 24's
claim is that works cause the increase of justification. Chapter 16's is that the
reward the texts promise is rendered to the works as merits. Under the
tradition standard, which admits the council's word, both are credible
critiques, and the step is `disputed`. -/
@[headline]
theorem fruit_step_ratings :
    fruitStep.ratings =
      [ (.evidence, .stands .wellSupported)
      , (.tradition, .disputedBy ["Trent, canon 24", "Trent, Session VI, ch. 16"]) ] := by
  decide +kernel

#print axioms fruit_step_ratings

/-- **James's word, rated by its register**: Trent's reading of the word, and
the renewal reading — the strongest known dissent, which argues the increase
from Paul's word instead of asserting it. -/
def lexicalStep : RatedStep Claim where
  step := jamesLexicalLine.name
  support := jamesLexicalSource
  register := [trentWordAssessment, renewalAssessment]
  strongest := some 1

/-- **The lexical step's rating turns on the authority question.** Under the
evidence standard its support stands at `wellSupported`: every encoded dissent
fails a check, the strongest known among them, because the renewal reading's
claim that James's word is Paul's rests on Trent alone. Under the tradition
standard, which admits Trent's word, the renewal reading is a credible critique
and the step is `disputed`. -/
@[headline]
theorem lexical_step_ratings :
    lexicalStep.ratings =
      [ (.evidence, .stands .wellSupported)
      , (.tradition, .disputedBy ["The renewal reading"]) ] := by
  decide +kernel

#print axioms lexical_step_ratings

/-- **Before the steelman was encoded, no rating above `disputed` was licensed.**
With only Trent's reading of the word in the register, no dissent is credible,
but the strongest known one is missing, so the rating is withheld under both
standards. Encoding the renewal reading is what moves it: to `wellSupported`
under the evidence standard, and to `disputed` under the tradition standard. -/
theorem lexical_step_before_the_steelman :
    ({ lexicalStep with register := [trentWordAssessment], strongest := none }).ratings =
      [(.evidence, .withheld), (.tradition, .withheld)] := by
  decide +kernel

/-! ### Rome's steps, rated by the same checks -/

/-- **Westminster, against Trent's premise that the reward is rendered to
merits** (XVI.5, XVI.6): argued from texts Westminster gives as proofs — Hebrews
6:10, one of Trent's own four; Luke 17:10; Romans 4:4–5; 1 Peter 2:5 — by a step
of its own, its reading of them. Every claim it asserts outright is a text. So
it is a critique under both standards. -/
def westminsterAssessment : Assessment Claim where
  dissenter := "Westminster XVI.5, XVI.6"
  against := "Trent: the reward is rendered to merits (ch. 16, canon 32)"
  dissent :=
    { claim := p .rewardRenderedToMerits
    , position := westminsterOnReward
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, [])] }
  checked := by decide +kernel

/-- **The Reformed harmony, against canon 24's step**: it grants James 2:24, the
works by which Abraham and Rahab were justified, and canon 24's own claim that
works cause the increase, and argues from Westminster's proof texts that works
are the fruit of faith and not its ground. What it asserts outright rests on
Scripture and on readings argued from it; so it is a critique under both
standards. -/
def harmonyOnCanon24Assessment : Assessment Claim where
  dissenter := "The Reformed harmony (Westminster XVI.2, XVI.5)"
  against := catholicJamesWorksLine.name
  dissent :=
    { claim := notP .worksAreFruitNotGround
    , grounds := catholicJamesWorksLine.grounds
    , position := jamesHarmonyCase
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, [])] }
  checked := by decide +kernel

/-- **The Reformed harmony, against chapter 16's step**: it grants the reward
texts, and grants for the step's sake even that the reward is rendered to
merits, and argues that works are the fruit of faith, not its ground. A critique
under both standards. Westminster's own answer goes further, and denies the
second ground (`westminsterAssessment`). -/
def harmonyOnRewardAssessment : Assessment Claim where
  dissenter := "The Reformed harmony (Westminster XVI.2, XVI.5)"
  against := trentRewardLine.name
  dissent :=
    { claim := notP .worksAreFruitNotGround
    , grounds := trentRewardLine.grounds
    , position := jamesHarmonyCase
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, [])] }
  checked := by decide +kernel

/-- **Trent's premise that the reward is rendered to merits, rated by its
register**: Westminster's dissent, the strongest known. -/
def meritPremise : RatedStep Claim where
  step := "Trent: the reward is rendered to merits (ch. 16, canon 32)"
  support := (baseCite .rewardRenderedToMerits).source
  register := [westminsterAssessment]
  strongest := some 0

/-- **Canon 24's step, rated by its register**: the Reformed harmony's dissent. -/
def canon24Step : RatedStep Claim where
  step := catholicJamesWorksLine.name
  support := trentWorksSource
  register := [harmonyOnCanon24Assessment]
  strongest := some 0

/-- **Chapter 16's step, rated by its register**: the Reformed harmony's
dissent. -/
def rewardStep : RatedStep Claim where
  step := trentRewardLine.name
  support := trentRewardSource
  register := [harmonyOnRewardAssessment]
  strongest := some 0

/-- **The same checks, run the other way: Rome's steps are disputed under both
standards.** Westminster's answer to Trent's merit premise, and the Reformed
harmony's answers to canon 24's and chapter 16's steps, each argue from texts
and rest on no one's word alone. So each is a credible critique under the
evidence standard as under the tradition standard, and each of Trent's claims
is `disputed` under both.

Set beside `fruit_step_ratings`, this is the asymmetry the checks find. The
Reformed dissents from Trent's claims are critiques under either standard.
Trent's dissents from the Reformed step are critiques only under the standard
that admits the council's word. -/
@[headline]
theorem rome_steps_ratings :
    meritPremise.ratings =
        [ (.evidence, .disputedBy ["Westminster XVI.5, XVI.6"])
        , (.tradition, .disputedBy ["Westminster XVI.5, XVI.6"]) ] ∧
      canon24Step.ratings =
        [ (.evidence, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"])
        , (.tradition, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"]) ] ∧
      rewardStep.ratings =
        [ (.evidence, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"])
        , (.tradition, .disputedBy ["The Reformed harmony (Westminster XVI.2, XVI.5)"]) ] := by
  decide +kernel

#print axioms rome_steps_ratings

/-- **Westminster's answer rests on no one's word alone; Trent's claim does.**
Every claim Westminster's reading of the reward asserts outright is a text it
gives as a proof. The one claim chapter 16 adds to its texts, that the reward is
rendered to merits, is the council's own. -/
theorem westminster_answers_from_the_texts :
    westminsterOnReward.restingOnAuthority = [] ∧
      trentOnReward.restingOnAuthority = [.rewardRenderedToMerits] := by
  decide

/-! ### Trent's definition, and faith's sufficiency -/

/-- Trent's step from its definition to the denial that faith suffices: if
justification is the renewal of the inward man by infused charity, then faith,
"unless hope and charity be added thereto, neither unites man perfectly with
Christ" (Session VI, ch. 7), and whoever says that "nothing else is required to
co-operate" is anathema (canon 9). Rated `disputed`: Luke 18 and Luke 7:50 are
read by the Reformed as a plea that sufficed (`luke18Line`). -/
def trentSufficiencySource : Source :=
  { primary := .work tannerDecrees
      (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 7; canon 9")
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **Faith does not suffice, from Trent's definition** (ch. 7, canon 9): the
definition, and the step from it. Trent's denial of sufficiency, stated as the
library states it — a consequence of what Trent says justification is
(`trentDefinitionSteps`). -/
@[solaFideDefs]
def trentSufficiencyLine : Line Claim :=
  { name := "Faith does not suffice (Trent, ch. 7, canon 9)"
  , grounds := [p .justificationIncludesSanctification]
  , step := p .justificationIncludesSanctification ➝ notP .faithIsSufficient
  , delivers := notP .faithIsSufficient
  , inference := some trentSufficiencySource }

/-- Trent on faith's sufficiency, as a position of its own. -/
@[solaFideDefs]
def trentOnSufficiency : ArgumentPackage Claim :=
  trentSufficiencyLine.asPackage baseCite "Faith does not suffice"

/-- **Paul's word, as the Latin West read it**: Augustine glossed "being
justified" as "being made righteous", and Trent reads the Apostle so (ch. 8); so
Paul's δικαιόω denotes the renewal of the inward man. The reading of Trent's
definition as a claim about the word (`trentOnPaulsWord`), as a line. -/
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

/-- **Paul's gospel, against Trent's definition read as what God does**: from
Galatians 1:6–9, 2:21 and 5:2–4, 1 Corinthians 15:3, Romans 8:33–34 and the
forensic sense of the verb. Every claim it asserts outright is a text or a
reading argued from the lexicon; a critique under both standards. -/
def gospelOnDefinitionAssessment : Assessment Claim where
  dissenter := "Paul's gospel (Galatians 1; Westminster XI.1)"
  against := "Trent: justification is the renewal of the inward man (ch. 7)"
  dissent :=
    { claim := p .justificationIncludesSanctification
    , position := galatianGospel
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, [])] }
  checked := by decide +kernel

/-- **Romans 4, against Trent's definition**: the righteousness God counts to the
ungodly is sin not counted (4:5–8), and the verb is forensic. A critique under
both standards. -/
def romansFourOnDefinitionAssessment : Assessment Claim where
  dissenter := "Romans 4:3–8"
  against := "Trent: justification is the renewal of the inward man (ch. 7)"
  dissent :=
    { claim := p .justificationIncludesSanctification
    , position := romansFourCase
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, [])] }
  checked := by decide +kernel

/-- **Romans 4, on Paul's word, against Trent's definition read as the word**:
Paul glosses the righteousness God counts to the ungodly as sin not counted
(4:5–8), and by the rule of least meaning his verb denotes no more than that
verdict. It argues from Paul's own text, without assuming the forensic sense, so
it is a critique under both standards — the strongest known against this
reading. -/
def romansFourOnWordAssessment : Assessment Claim where
  dissenter := "Romans 4:3–8, on Paul's word"
  against := "Trent: Paul's δικαιόω denotes renewal (ch. 8, with Augustine)"
  dissent :=
    { claim := p .paulsJustifyDenotesRenewal
    , position := romansFourOnTheWord
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, [])] }
  checked := by decide +kernel

/-- **The lexical case, against Trent's definition read as the word**: it holds
as a premise that Paul's δικαιόω is forensic — a verdict, and *not* making
righteous — and that premise, by its meaning, already denies Trent's reading
(`Meanings.SolaFide.postulates`). So against this reading it is a rival
reading held as a premise, not an argument: by the checks, a disagreement. What
it rests on is the lexicon, and its standing is that premise's own rating,
where the library weighs the word; Trent's reading stands in the same place
against it (`trentWordOnLexicalAssessment`). -/
def lexicalOnWordAssessment : Assessment Claim where
  dissenter := "Paul's word (by the rule of least meaning)"
  against := "Trent: Paul's δικαιόω denotes renewal (ch. 8, with Augustine)"
  dissent :=
    { claim := p .paulsJustifyDenotesRenewal
    , position := lexicalCase
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := false, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, [])] }
  checked := by decide +kernel

/-- **Luke 18, against Trent's step to "faith does not suffice"**: the tax
collector's plea, without works, and God's verdict. It can be held with Trent's
definition, the step's ground, and argues that the plea sufficed. A critique
under both standards. -/
def luke18OnSufficiencyAssessment : Assessment Claim where
  dissenter := "Luke 18:9–14 (the tax collector justified)"
  against := trentSufficiencyLine.name
  dissent :=
    { claim := notP .faithIsSufficient
    , grounds := trentSufficiencyLine.grounds
    , position := luke18Case
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, [])] }
  checked := by decide +kernel

/-- **Trent's definition, rated by its register**: Paul's gospel and Romans 4. -/
def definitionPremise : RatedStep Claim where
  step := "Trent: justification is the renewal of the inward man (ch. 7)"
  support := (baseCite .justificationIncludesSanctification).source
  register := [gospelOnDefinitionAssessment, romansFourOnDefinitionAssessment]
  strongest := some 0

/-- **Trent's reading of Paul's word, rated by its register**: Romans 4 on the
word, the strongest known, and the lexical case. -/
def wordPremise : RatedStep Claim where
  step := "Trent: Paul's δικαιόω denotes renewal (ch. 8, with Augustine)"
  support := (baseCite .paulsJustifyDenotesRenewal).source
  register := [romansFourOnWordAssessment, lexicalOnWordAssessment]
  strongest := some 0

/-- **Trent's step to "faith does not suffice", rated by its register**: Luke
18. -/
def sufficiencyStep : RatedStep Claim where
  step := trentSufficiencyLine.name
  support := trentSufficiencySource
  register := [luke18OnSufficiencyAssessment]
  strongest := some 0

/-- **Trent's definition, and what follows from it, are disputed under both
standards.** Read as what God does, the definition meets Paul's gospel and
Romans 4. Read as Paul's word, it meets Romans 4's gloss of the verb. Its step
to "faith does not suffice" meets Luke 18. Each is argued from texts and from
evidence anyone can check, so each is a critique under either standard. -/
@[headline]
theorem trent_definition_ratings :
    definitionPremise.ratings =
        [ (.evidence, .disputedBy
            ["Paul's gospel (Galatians 1; Westminster XI.1)", "Romans 4:3–8"])
        , (.tradition, .disputedBy
            ["Paul's gospel (Galatians 1; Westminster XI.1)", "Romans 4:3–8"]) ] ∧
      wordPremise.ratings =
        [ (.evidence, .disputedBy ["Romans 4:3–8, on Paul's word"])
        , (.tradition, .disputedBy ["Romans 4:3–8, on Paul's word"]) ] ∧
      sufficiencyStep.ratings =
        [ (.evidence, .disputedBy ["Luke 18:9–14 (the tax collector justified)"])
        , (.tradition, .disputedBy ["Luke 18:9–14 (the tax collector justified)"]) ] := by
  decide +kernel

#print axioms trent_definition_ratings

/-- **Trent's word, against the lexical step**: the Latin West's reading of
Paul's verb. It argues its conclusion from Augustine's gloss — but what it
concludes, that Paul's δικαιόω denotes making righteous, is what the step's
first ground denies: "forensic", in that ground, means a verdict *and not*
making righteous (`Meanings.SolaFide.postulates`). So it is a dissent from that
ground, not from the step, and belongs to the ground's rating, under either
standard. -/
def trentWordOnLexicalAssessment : Assessment Claim where
  dissenter := "Trent, with Augustine (ch. 8)"
  against := lexicalLine.name
  dissent :=
    { claim := notP .paulsJustifyDenotesRenewal
    , grounds := lexicalLine.grounds
    , position := trentOnTheWordOfPaul
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := false, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, [])] }
  checked := by decide +kernel

/-- **Trent's definition read as what God does, against Paul's gospel step**: it
holds the definition as a premise, and that premise alone contradicts the step's
conclusion. A disagreement, not a critique, under either standard. -/
def trentGraceOnGospelAssessment : Assessment Claim where
  dissenter := "Trent, read as what God does (ch. 7; Joint Declaration §22)"
  against := "Paul's gospel: a verdict on a finished work is no renewal"
  dissent :=
    { claim := notP .justificationIncludesSanctification
    , grounds := [p .christsWorkIsTheWholeGround, p .dikaioIsForensic, p .romans8_33_34]
    , position := tridentineOnWhatGodDoes
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := false, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.justificationIncludesSanctification, .renewalGrowsThroughGoodWorks])
        , (.tradition, []) ] }
  checked := by decide +kernel

/-- **Trent's denial of sufficiency, against Luke 18's step**: argued, from its
definition, and granting the parable. Its one ground is the definition, which
rests on the council's word; so it is a critique under the tradition standard
only. -/
def trentSufficiencyOnLuke18Assessment : Assessment Claim where
  dissenter := "Trent, ch. 7 and canon 9"
  against := luke18Line.name
  dissent :=
    { claim := p .faithIsSufficient
    , grounds := luke18Line.grounds
    , position := trentOnSufficiency
    , background := Meanings.SolaFide.postulates }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, [.justificationIncludesSanctification]), (.tradition, [])] }
  checked := by decide +kernel

/-- **Paul's word, rated by its register**: Trent's reading of the word, the
strongest known dissent. -/
def lexicalWordStep : RatedStep Claim where
  step := lexicalLine.name
  support := leastMeaningSource
  register := [trentWordOnLexicalAssessment]
  strongest := some 0

/-- **The same checks, from Trent's side.** Of Trent's three dissents from the
Reformed steps over its definition:

- its reading of Paul's word dissents from the lexical step's ground, not from
  the step;
- its definition read as what God does is asserted, not argued, against Paul's
  gospel;
- its denial of sufficiency is a critique of Luke 18's step under the tradition
  standard only, because its one ground is the definition.

So the lexical step's support stands at `wellSupported` under both standards:
its strongest known dissent is encoded, and fails. -/
@[headline]
theorem trent_dissents_from_the_definition_steps :
    trentWordOnLexicalAssessment.findings.kind = .deniesGrounds ∧
      trentGraceOnGospelAssessment.findings.kind = .asserted ∧
      trentSufficiencyOnLuke18Assessment.profile = [(.evidence, false), (.tradition, true)] ∧
      lexicalWordStep.ratings =
        [(.evidence, .stands .wellSupported), (.tradition, .stands .wellSupported)] := by
  decide +kernel

#print axioms trent_dissents_from_the_definition_steps

/-! ### The hearing under each standard -/

/-- **The James dispute's register**: each party entered as a dissent from a step
of the Reformed reading, assessed, and the two steps they are rated against. The
other parties hold those steps, or are readings of texts answered by the texts
themselves. -/
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

/-- Each party's weakest link, weighed at a standard's ratings: as cited, except
that under the tradition standard James's word is weighed as `disputed`, its
computed rating there. -/
def ratedStrength : Standard → JamesParty → ℕ
  | .tradition, .lexical => 0
  | _, i => jamesPartyStrength i

/-- Each party's weakest link, as the re-rated package computes it. -/
theorem rerated_strength (s : Standard) :
    ∀ i, ((jamesRegister.rerated s).node i).strength = ratedStrength s i := by
  intro i
  cases s <;> cases i <;> decide +kernel

/-- Who defeats whom at a standard's ratings: under the evidence standard, as in
the full dispute; under the tradition standard, also Trent's reading of the word
and the renewal reading each defeat James's word, now that it is weighed as
`disputed`. -/
def ratedDefeats : Standard → JamesParty → JamesParty → Prop
  | .tradition, .trentOnTheWord, .lexical => True
  | .tradition, .renewalOnTheWord, .lexical => True
  | _, i, j => jamesPartyDefeats i j

/-- The table is finite, so membership in it is decidable. -/
instance (s : Standard) : DecidableRel (ratedDefeats s) := fun i j => by
  cases s <;> cases i <;> cases j <;> unfold ratedDefeats <;> infer_instance

/-- **Who defeats whom at the evidence standard's ratings**, all 144 pairs,
computed from the parties' premises and the re-rated inferences and checked by
the kernel. -/
theorem rerated_defeats_evidence :
    ∀ i j, (jamesRegister.rerated .evidence).defeats i j ↔ ratedDefeats .evidence i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats?
    (rerated_strength .evidence i) (rerated_strength .evidence j) ?_
  cases i <;> cases j <;> decide +kernel

/-- **Who defeats whom at the tradition standard's ratings**, all 144 pairs,
computed and checked the same way. -/
theorem rerated_defeats_tradition :
    ∀ i j, (jamesRegister.rerated .tradition).defeats i j ↔ ratedDefeats .tradition i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats?
    (rerated_strength .tradition i) (rerated_strength .tradition j) ?_
  cases i <;> cases j <;> decide +kernel

/-- **Who defeats whom at each standard's ratings.** -/
theorem rerated_defeats (s : Standard) :
    ∀ i j, (jamesRegister.rerated s).defeats i j ↔ ratedDefeats s i j := by
  cases s
  · exact rerated_defeats_evidence
  · exact rerated_defeats_tradition

/-- The dispute at a standard's ratings, in the form the verdict solver computes
with. -/
def ratedFinite (s : Standard) : Solver.Finite (jamesRegister.rerated s).defeats where
  parties := jamesFinite.parties
  complete := jamesFinite.complete
  defeats i j := decide (ratedDefeats s i j)
  spec i j := by rw [rerated_defeats]; simp

/-- The hearing under the evidence standard. -/
abbrev jamesUnderEvidence := jamesRegister.hearing .evidence

/-- The hearing under the tradition standard. -/
abbrev jamesUnderTradition := jamesRegister.hearing .tradition

/-- The hearing under a standard, in the form the verdict solver computes with. -/
abbrev jamesUnderFinite (s : Standard) :=
  (ratedFinite s).restrict (jamesRegister.admits s)

/-- **Who defeats whom in the hearing under the evidence standard**: as in the
full dispute, among the parties heard. -/
theorem jamesUnderEvidence_defeats :
    ∀ i j, jamesUnderEvidence.defeats i j ↔ ratedDefeats .evidence i.1 j.1 :=
  fun i j => rerated_defeats .evidence i.1 j.1

/-- **Who defeats whom in the hearing under the tradition standard**: James's
word, weighed as `disputed`, and the renewal reading defeat each other. -/
theorem jamesUnderTradition_defeats :
    ∀ i j, jamesUnderTradition.defeats i j ↔ ratedDefeats .tradition i.1 j.1 :=
  fun i j => rerated_defeats .tradition i.1 j.1

/-- How the hearing under the evidence standard is settled: James's word,
James's faith, the Reformed harmony and the Greek of both verses come first, and
nothing heard answers them; Trent's Latin readings fall to the Greek. Every
dissent of Trent's from a rated step — canon 24, chapter 16, the renewal reading,
and Trent's reading of the word — rests at some claim on the council's word, or
asserts its denial, and is not heard. -/
def underEvidenceSettled : Verdict jamesUnderEvidence where
  finite := jamesUnderFinite .evidence
  claim := .groundedExactly
    [Witness.listSub _
      [.lexical, .faith, .harmony, .revelationText, .sirachText, .westminsterOnReward]]
    (Witness.Table.sub _
      [ (.trentOnRevelation, .revelationText), (.trentOnSirach, .sirachText) ])
  checked := by decide +kernel

/-- How the hearing under the tradition standard is settled: James's faith and
the Greek of both verses come first. James's word and the renewal reading defeat
each other; so do the Reformed harmony and each of Trent's readings of what works
do. Only Trent's reading of the word is not heard. -/
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

/-- The renewal reading holds that James's δικαιόω denotes the increase of
justice. -/
theorem renewal_holds_increase :
    Entails (jamesDispute.node .renewalOnTheWord).premises (p .jamesJustifyDenotesIncrease) := by
  establish [solaFideDefs, jamesDispute]

/-- James's word denies it. -/
theorem lexical_denies_increase :
    Entails (jamesDispute.node .lexical).premises (∼ p .jamesJustifyDenotesIncrease) := by
  establish [solaFideDefs, jamesDispute]

/-- Why the renewal reading can be defended in the hearing under the tradition
standard: it answers James's word itself, now that the two are rated alike. -/
def renewalHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.renewalOnTheWord, by decide⟩
    (Witness.listSub _ [.faith, .renewalOnTheWord, .revelationText, .sirachText])
  checked := by decide +kernel

/-- Why James's word can be defended there: it answers the renewal reading
itself. -/
def lexicalHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.lexical, by decide⟩
    (Witness.listSub _ [.lexical, .faith, .revelationText, .sirachText])
  checked := by decide +kernel

/-- **What James's δικαιόω denotes turns on the standard, and the hearing and
the rating agree.** Under the evidence standard the hearing forces James's word,
with James's faith and the Greek of both verses: the renewal reading is not
heard, because it rests on Trent's word that James's δικαιόω is Paul's. Under
the tradition standard the renewal reading is heard, the lexical step is weighed
at its computed rating there, `disputed`, and whether James's word denotes the
increase of justice is contested: each side can be defended, and neither is
forced. -/
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

/-- **Under the tradition standard, what is forced is James's faith and the
Greek of the two verses**, and no more. -/
theorem under_tradition_forces :
    grounded jamesUnderTradition.defeats =
      Solver.toSet (Witness.listSub _ [.faith, .revelationText, .sirachText]) :=
  underTraditionSettled.holds

/-- Trent's reading of the reward texts denies that works are fruit and not
ground. -/
theorem trentOnReward_denies_fruit :
    Entails (jamesDispute.node .trentOnReward).premises (∼ p .worksAreFruitNotGround) := by
  establish [solaFideDefs, jamesDispute]

/-- Why the Reformed harmony can be defended in the hearing under the tradition
standard: it answers canon 24 and chapter 16 itself. -/
def harmonyHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.harmony, by decide⟩
    (Witness.listSub _ [.lexical, .faith, .harmony, .revelationText, .sirachText])
  checked := by decide +kernel

/-- Why chapter 16's reading of the reward texts can be defended there: it
answers the Reformed harmony itself. -/
def rewardHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.trentOnReward, by decide⟩
    (Witness.listSub _
      [.lexical, .faith, .trentOnWorks, .trentOnReward, .revelationText, .sirachText])
  checked := by decide +kernel

/-- **Whether works are fruit and not ground turns on the authority question,
and the hearing and the rating agree.** Under the evidence standard the hearing
forces the Reformed harmony, which derives "fruit, not ground" from Westminster's
proof texts. Neither of Trent's dissents is heard: each rests at one claim on the
council's word. Under the tradition standard both are heard, the step is weighed
at `disputed`, and the question is contested: the harmony and chapter 16's
reading of the reward texts can each be defended, and neither is forced. -/
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

end Testimony.Arguments.SolaFide
