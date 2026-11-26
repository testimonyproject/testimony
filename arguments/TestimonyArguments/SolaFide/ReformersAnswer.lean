import TestimonyArguments.SolaFide.TrentAnswers
import TestimonyArguments.SolaFide.Verdict
import TestimonyArguments.SolaFide.Ratings
import TestimonyArguments.SolaFide.BeforeTrent

/-!
# TestimonyArguments.SolaFide.ReformersAnswer — the Reformers answer the council, 1547–1647

The decree on justification was read in January 1547, and Calvin's answer was in
print before the year was out. He reprinted the council's text, chapter by
chapter and canon by canon, and set his *Antidote* after each. In 1565 Martin
Chemnitz, a Lutheran theologian at Brunswick, finished the first part of a longer
answer, his *Examination of the Council of Trent*, printed the next year, which
takes the decree apart topic by topic. And in 1647 the Westminster Assembly, sitting in London,
wrote a confession whose chapter on justification answers the decree in its
own terms, though it never names the council.

All three answered one point. The council had taught that justification is "not
remission of sins merely, but also the sanctification and renewal of the inward
man" (ch. 7), and so that it can grow. The justified, "through the observance
of the commandments of God and of the Church, faith co-operating with good
works, increase in that justice which they have received through the grace of
Christ, and are still further justified" (ch. 10). Canon 24 condemns whoever
says that the justice received "is not preserved and also increased before God
through good works", or that good works are "merely the fruits and signs of
Justification obtained, but not a cause of the increase thereof".

## What the Reformers answered

Calvin went to the definition. Of the council's account of justification he
wrote, "I maintain that it is one, and simple, and is wholly included in the
gratuitous acceptance of God" (*Antidote*, p. 116). Paul sets God's justifying
against condemning: "It is God who justifies. Who is the one who will condemn?"
(Romans 8:33–34, NET). A verdict of acquittal is given or it is not. So Calvin
answered canon 24 in one sentence: "whosoever asserts that works have the
effect of increasing justification, understands neither what is the meaning of
justification nor its cause" (p. 158).

Chemnitz went to Abraham. Paul says that faith is credited as righteousness "to
the one who does not work, but believes in the one who declares the ungodly
righteous" (Romans 4:5, NET), and he says it of Abraham. But the verse Paul
quotes is Genesis 15:6, and by then Abraham had followed God's call for years,
from Genesis 11 to 15 as Chemnitz counts them (p. 154). So, Chemnitz wrote, Paul
proves "that Abraham was justified by faith, freely, for Christ's sake, without
works, not only at the beginning of his conversion, but then also when, renewed,
he had obeyed God with good works for many years" (*Examen*, p. 175). What holds
at the start holds after it: "one and the same is the justification, both at the
beginning of conversion, and that by which we come at last to eternal life"
(p. 175). The distinction the council's defenders drew from ch. 10, between a
first justification and a second, is "false, and against the Scriptures"
(p. 175). The increase the council attributes to keeping the commandments he
left to his topic on good works. The translations from the Latin are ours, and
the Latin is given with each position below.

Westminster said what justification is, in the terms the council had denied.
God justifies those He calls,

> "not by infusing righteousness into them, but by pardoning their sins, and by
> accounting and accepting their persons as righteous" (Westminster Confession
> XI.1).

The texts printed beneath that clause begin with Romans 4:5–8, where God
"declares the ungodly righteous" and David calls blessed "the one against whom
the Lord will never count sin" (4:5, 8, NET). The Assembly granted that the
justified grow: they are "further sanctified, really and personally" (XIII.1).
The growth it called sanctification, not justification.

## Who stands

Every position here cites, for what it holds, only Scripture and works written
before 1648 (`reformers_answer_hears_no_later_voice`). The ratings, though, name
readers of any date who grant a step's grounds and deny its conclusion, so
Bellarmine, writing later, can count against a step.

The council and each of its three answerers attack one another, because each
side denies what the other says justification is. An attack defeats unless the
attacker's weakest premise or step is rated lower than the position it attacks.
Two of the answers, Chemnitz's and Westminster's, go through a reading of Romans
4, and each has a reader who grants its texts and denies where it ends.
Bellarmine agrees that Paul's Abraham was already reborn, and holds that the
works Paul excludes are only those done before faith; Augustine reads "justifies
the ungodly" as making the ungodly godly. So those steps are rated *disputed*,
and they and the council defeat each other.

Calvin's step runs from "justification is a verdict" and "a verdict has no
degrees" to "justification has no degrees", and nothing in the council's
position denies the step: it can grant that a verdict has no degrees, and
denies only that justification is a verdict and nothing more. So the step is
rated *well supported*. His first premise is not. That justification is a
verdict only is rated *disputed*, because canon 11 denies it in terms,
condemning justification "by the sole imputation of the justice of Christ, or
by the sole remission of sins". The council's definition, that justification
is also renewal (ch. 7), is rated *disputed* for the same kind of reason:
Westminster XI.1 denies it in terms. The two definitions are rated by one rule,
and so Calvin and the council defeat each other, as Chemnitz and Westminster do
with the council.

So none of the four stands (`after_the_reformers_answer_nothing_stands`). To
stand is to survive however the open disagreements are settled, and here every
position is defeated by another. What is left are two sides, each consistent:
the council alone, and the three answers together, since one reading satisfies
them all (`the_reformers_answers_stand_together`).
Which side holds turns on the two definitions, and they fare alike when the
objections to each are checked (`both_definitions_disputed_alike`). Each
confession's denial of the other is only a denial: canon 11 holds the council's
definition as a premise against Calvin's, and Calvin holds his own against the
council's. Each definition is also met by an argument that every standard
admits. Augustine argues from his explanation of the word, "what else does the
phrase 'being justified' signify than being made righteous", that justification
includes renewal. Paul's gospel and Romans 4 argue from the texts and the
courtroom sense of the verb that it does not. Westminster's own answer from
Romans 4 is an argument only where a theologian's word counts, because it needs
Chemnitz's reading that "count" and "works" keep one sense through 4:4–8. So
neither definition is refuted, and each is *disputed* under every standard. Whether Scripture
settles that question is the work of the chapter "What Trent means by
justification", which weighs both definitions against Paul's own uses of the
verb.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Logic.Framework Testimony.Scripture

/-! ### The sources of 1547–1647 -/

/-- The sources of the Reformers' answer. Romans 4:4–5 and 4:6–8 are cited to
the text alone. That "count" and "works" keep their sense across Romans 4:4–8 is
cited to Chemnitz (p. 169), and that the Abraham of Romans 4 was already a
believer to Chemnitz (p. 154) and Calvin (p. 123). That justification is a
verdict only, and that a verdict has no degrees, are cited to Calvin's *Antidote*
(p. 116), the second with Romans 8:33–34 as its text. The council's definition
is cited to its ch. 7, the growth of the renewal to ch. 10 (with Westminster
XIII.1, which grants it), works as a cause of the increase to canon 24, and
degrees of justification to ch. 10 and canon 24. Every other claim keeps the
source the chapter "The council answers, 1547" gives it. -/
@[solaFideDefs]
def reformersAnswerCite : Claim → AtomMeta
  | .romans4_4_5 =>
    { councilCite .romans4_4_5 with
      source :=
        { primary := .scripture [{ ref := .range ⟨.romans, 4, 4, 4, 5⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .romans4_6_8 =>
    { councilCite .romans4_6_8 with
      source :=
        { primary := .scripture [{ ref := .range ⟨.romans, 4, 6, 4, 8⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .romans4CountKeepsItsSense =>
    { councilCite .romans4CountKeepsItsSense with
      source :=
        { primary := .work chemnitzExamen (.page 169)
        , tradition := .christianHistoricalGrammatical
        , confidence := (councilCite .romans4CountKeepsItsSense).source.confidence } }
  | .romans4WorksKeepsItsSense =>
    { councilCite .romans4WorksKeepsItsSense with
      source :=
        { primary := .work chemnitzExamen (.page 169)
        , tradition := .christianHistoricalGrammatical
        , confidence := (councilCite .romans4WorksKeepsItsSense).source.confidence } }
  | .abrahamOfRomans4WasABeliever =>
    { councilCite .abrahamOfRomans4WasABeliever with
      source :=
        { primary := .work chemnitzExamen (.page 154)
        , supporting := [.work calvinAntidoteWork (.page 123)]
        , tradition := .christianHistoricalGrammatical
        , confidence := (councilCite .abrahamOfRomans4WasABeliever).source.confidence } }
  | .justificationIsForensicOnly =>
    { councilCite .justificationIsForensicOnly with
      source :=
        { primary := .work calvinAntidoteWork (.page 116)
        , tradition := .reformedProtestant
        , confidence := (councilCite .justificationIsForensicOnly).source.confidence } }
  | .verdictAdmitsNoDegrees =>
    { councilCite .verdictAdmitsNoDegrees with
      source :=
        { primary := .scripture [{ ref := .range ⟨.romans, 8, 33, 8, 34⟩ }]
        , supporting := [.work calvinAntidoteWork (.page 116)]
        , tradition := .reformedProtestant
        , confidence := (councilCite .verdictAdmitsNoDegrees).source.confidence } }
  | .justificationIncludesSanctification =>
    { councilCite .justificationIncludesSanctification with
      source :=
        { primary := .work trentSessionVI (.sectionRef "ch. 7; Waterworth, pp. 34–35")
        , tradition := .romanCatholic
        , confidence := (councilCite .justificationIncludesSanctification).source.confidence } }
  | .renewalGrowsThroughGoodWorks =>
    { councilCite .renewalGrowsThroughGoodWorks with
      source :=
        { primary := .work trentSessionVI (.sectionRef "ch. 10; Waterworth, p. 37")
        , supporting := [.work westminsterConfession (.sectionRef "XIII.1")]
        , tradition := .romanCatholic
        , confidence := (councilCite .renewalGrowsThroughGoodWorks).source.confidence } }
  | .worksCauseIncreaseOfJustification =>
    { councilCite .worksCauseIncreaseOfJustification with
      source :=
        { primary := .work trentSessionVI (.sectionRef "canon 24; Waterworth, p. 47")
        , tradition := .romanCatholic
        , confidence := (councilCite .worksCauseIncreaseOfJustification).source.confidence } }
  | .justificationHasDegrees =>
    { councilCite .justificationHasDegrees with
      source :=
        { primary :=
            .work trentSessionVI (.sectionRef "ch. 10 and canon 24; Waterworth, pp. 37, 47")
        , tradition := .romanCatholic
        , confidence := (councilCite .justificationHasDegrees).source.confidence } }
  | c => councilCite c

/-! ### The council on the increase -/

/-- The council draws this step itself, in ch. 10 and canon 24: if justification
is the renewal of the inward man, and that renewal grows through good works,
then good works are a cause of the increase of justification. Rated
*consensus*, as the same step is in the chapter "Does justification have
degrees?" (`trentOnIncrease`): the Reformed deny the definition it starts from,
not the step from it. -/
def councilIncreaseStep : Source :=
  { trentOnIncrease with
    primary := .work trentSessionVI (.sectionRef "ch. 10 and canon 24; Waterworth, pp. 37, 47")
    supporting := [] }

/-- **Works, a cause of the increase.** Justification is the renewal of the
inward man (ch. 7), and that renewal grows as the justified do good works in
grace (ch. 10). So good works are "a cause of the increase" of justification,
and not "merely the fruits and signs of Justification obtained" (canon 24). -/
@[solaFideDefs]
def councilCauseLine : Line Claim :=
  { name := "Works, a cause of the increase (Trent, ch. 10 and canon 24)"
  , grounds := tridentineLine.grounds
  , step := ⋀ tridentineLine.grounds ➝ p .worksCauseIncreaseOfJustification
  , delivers := p .worksCauseIncreaseOfJustification
  , inference := some councilIncreaseStep }

/-- The step from an increase of justification to degrees of it: what grows is
more at one time than at another, and the council says the justified "are still
further justified" (ch. 10). Calvin read the chapter so (*Antidote*, p. 158).
Rated *consensus*, as the same step about merit is in the chapter "Does
justification have degrees?" (`increaseMeansDegreesSource`): it is what the
word "increase" says, and both sides read ch. 10 so. -/
def causeMeansDegreesStep : Source :=
  { increaseMeansDegreesSource with
    primary := .work trentSessionVI (.sectionRef "ch. 10; Waterworth, p. 37")
    supporting := [.work calvinAntidoteWork (.page 158)] }

/-- If good works are a cause of the increase of justification, then
justification has degrees. -/
@[solaFideDefs]
def causeMeansDegrees : Formula Claim :=
  p .worksCauseIncreaseOfJustification ➝ p .justificationHasDegrees

/-- The council's teaching on the increase, set as a position to be weighed
against its answerers: from its definition and the growth of the renewal, good
works are a cause of the increase of justification, and so justification has
degrees. -/
@[solaFideDefs]
def councilOnIncreaseCase : ArgumentPackage Claim :=
  { name := "The council, on the increase of justification (1547)"
  , cite := reformersAnswerCite
  , premises := councilCauseLine.premises ++ [causeMeansDegrees]
  , conclusion := p .worksCauseIncreaseOfJustification
  , conclusionLabel := "good works are a cause of the increase of justification"
  , inferences := [councilIncreaseStep, causeMeansDegreesStep] }

/-! ### Calvin's *Antidote* -/

/-- Calvin draws this step against canon 24 (*Antidote*, p. 158). It is the step
of the chapter "Does justification have degrees?" (`noDegreesSource`), cited
here to the *Antidote* alone, and rated *well supported* as it is there: nothing
in the council's position denies that a verdict has no degrees, and it denies
only that justification is a verdict and nothing more. -/
def antidoteNoDegreesStep : Source :=
  { noDegreesSource with
    primary := .work calvinAntidoteWork (.page 158)
    supporting := [] }

/-- **Calvin against the increase.** Justification is "one, and simple, and is
wholly included in the gratuitous acceptance of God" (*Antidote*, p. 116): a
verdict, and nothing more. A verdict acquits or condemns and has no degrees. So
justification has none, and since an increase of it would be a degree of it,
works do not cause one: "whosoever asserts that works have the effect of
increasing justification, understands neither what is the meaning of
justification nor its cause" (p. 158). -/
@[solaFideDefs]
def calvinAgainstIncreaseCase : ArgumentPackage Claim :=
  { name := "Calvin's Antidote, against the increase (1547)"
  , cite := reformersAnswerCite
  , premises :=
      [ p .justificationIsForensicOnly, p .verdictAdmitsNoDegrees, noDegreesLine.step
      , causeMeansDegrees ]
  , conclusion := notP .worksCauseIncreaseOfJustification
  , conclusionLabel := "good works do not cause an increase of justification"
  , inferences := [antidoteNoDegreesStep, causeMeansDegreesStep] }

/-! ### The Westminster Confession -/

/-- The Assembly draws this step in XI.1, whose first proof under the clause is
Romans 4:5–8. Rated *disputed*, because Augustine grants the texts and reads
"justifies the ungodly" as making the ungodly godly (*On the Spirit and the
Letter* 26.45), and the council makes the justice "whereby He maketh us just"
the formal cause of justification, that is, what makes it justification
(ch. 7). -/
def westminsterOnRomansFourStep : Source :=
  { romansFourReadingSource with
    primary := .work westminsterConfession (.sectionRef "XI.1")
    supporting := [] }

/-- Romans 4:4–8 read as one argument: the two passages, with "count" and
"works" meaning the same in 4:4–5 as in 4:6–8. Chemnitz reads it so, applying
both to the same Abraham: "to Abraham already reborn he says this belongs: that
blessedness is of the man to whom God imputes righteousness without works" (*Ad
Abraham jam renatum dicit pertinere illud: Beatitudinem esse ejus hominis, cui
Deus imputat justitiam sine operibus*; *Examen*, p. 169). -/
@[solaFideDefs]
def romansFourAsOneArgument : List (Formula Claim) :=
  [ p .romans4_4_5, p .romans4_6_8, p .romans4CountKeepsItsSense
  , p .romans4WorksKeepsItsSense ]

/-- **Westminster, from Romans 4.** God "declares the ungodly righteous" (4:5,
NET), and the righteousness He counts is sin not counted (4:6–8), with "count"
and "works" meaning the same in both. So He justifies "not by infusing
righteousness into them, but by pardoning their sins, and by accounting and
accepting their persons as righteous" (XI.1), and the renewal of the inward man
is no part of justification. -/
@[solaFideDefs]
def westminsterRomansFourLine : Line Claim :=
  { name := "Westminster XI.1, from Romans 4:5–8"
  , grounds := romansFourAsOneArgument
  , step := ⋀ romansFourAsOneArgument ➝ notP .justificationIncludesSanctification
  , delivers := notP .justificationIncludesSanctification
  , inference := some westminsterOnRomansFourStep }

/-- Westminster's line, set as a position to be weighed against the council: the
renewal of the inward man is no part of justification. -/
@[solaFideDefs]
def westminsterOnJustificationCase : ArgumentPackage Claim :=
  westminsterRomansFourLine.asPackage reformersAnswerCite
    "the renewal of the inward man is no part of justification"

/-! ### Chemnitz's *Examen* -/

/-- Chemnitz draws this step against the council's ch. 10 (*Examen*,
pp. 174–175): "For in Romans 4 Paul proves that Abraham was justified by faith,
freely, for Christ's sake, without works, not only at the beginning of his
conversion, but then also when, renewed, he had obeyed God with good works for
many years" (*Nam Rom. 4: Paulus probat, Abrahamum fide gratis propter Christum
sine operibus justificatum, non in principio tantum conversionis, sed tunc etiam
cum renovatus per multos annos bonis operibus Deo obedisset*; p. 175). Rated
*disputed*, because Bellarmine grants that the Abraham of Romans 4 "was indeed
reborn, and did many good works from faith" (*De justificatione* I.19, p. 194),
answering Chemnitz by name, and reads the works Paul excludes as only "the works
which precede faith" (p. 193), so that the justified may still grow in
justification by a believer's works. -/
def chemnitzOneJustificationStep : Source :=
  { primary := .work chemnitzExamen (.page 175)
  , supporting := [.work chemnitzExamen (.page 174)]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- **Chemnitz: one justification, at the start and after.** The Abraham to whom
faith was counted had already believed and obeyed God for years (Genesis 12 to
15, as Chemnitz reads them, p. 154), and the blessedness of the man to whom God
counts righteousness without works (Romans 4:6–8) is his. So the renewed are
justified as the ungodly are, without works, and justification has no degrees:
"one and the same is the justification, both at the beginning of conversion,
and that by which we come at last to eternal life" (*una igitur et eadem est
justificatio, et in principio conversionis, et qua tandem pervenimus ad vitam
aeternam*; *Examen*, p. 175). The distinction the council's defenders drew from
ch. 10, between a first justification and a second, "is false, and against the
Scriptures" (*falsum ergo, et scripturis adversum est dogma illud de differentia
primae et secundae justificationis*; p. 175). The increase the council
attributes to keeping the commandments he leaves to his topic on good works
(p. 175), so he is stated here as denying degrees of justification, which is
his word, and not as answering canon 24 on works. -/
@[solaFideDefs]
def chemnitzAbrahamLine : Line Claim :=
  { name := "One justification, at the start and after (Chemnitz on Romans 4)"
  , grounds := romansFourAsOneArgument ++ [p .abrahamOfRomans4WasABeliever]
  , step :=
      ⋀ (romansFourAsOneArgument ++ [p .abrahamOfRomans4WasABeliever]) ➝
        notP .justificationHasDegrees
  , delivers := notP .justificationHasDegrees
  , inference := some chemnitzOneJustificationStep }

/-- Chemnitz's line, set as a position to be weighed against the council:
justification has no degrees. -/
@[solaFideDefs]
def chemnitzOnIncreaseCase : ArgumentPackage Claim :=
  chemnitzAbrahamLine.asPackage reformersAnswerCite "justification has no degrees"

/-! ### The answer, weighed -/

/-- The parties to the Reformers' answer: the council, as it taught the
increase, and the three answers to it. -/
inductive ReformersAnswerParty
  /-- The council, 1547: justification is renewal, and good works increase it
  (ch. 7, ch. 10, canon 24). -/
  | trentOnIncrease
  /-- Calvin's *Antidote*, 1547: justification is a verdict, and works do not
  cause it to increase. -/
  | calvin
  /-- Chemnitz's *Examen*, 1566: Abraham, already renewed, was justified without
  works, so justification is one and the same, and has no degrees. -/
  | chemnitz
  /-- The Westminster Confession, 1647: God justifies by pardoning, not by
  infusing righteousness (XI.1). -/
  | westminster
deriving DecidableEq

/-- The position each party argues from. -/
@[solaFideDefs]
def reformersAnswerNode : ReformersAnswerParty → ArgumentPackage Claim
  | .trentOnIncrease => councilOnIncreaseCase
  | .calvin => calvinAgainstIncreaseCase
  | .chemnitz => chemnitzOnIncreaseCase
  | .westminster => westminsterOnJustificationCase

/-- The Reformers' answer to the council, heard with the council. -/
declare_dispute reformersAnswerDispute := reformersAnswerNode using solaFideDefs
  /-- **Who defeats whom.** Calvin, Chemnitz and Westminster each defeat the
  council, and the council defeats each of them, because each side's weakest
  premise is its definition of justification, rated *disputed*. The three
  answers deny nothing of one another.
  Each pair is checked by the proof checker. -/
  defeats [ (.calvin, .trentOnIncrease), (.chemnitz, .trentOnIncrease)
          , (.westminster, .trentOnIncrease), (.trentOnIncrease, .chemnitz)
          , (.trentOnIncrease, .calvin), (.trentOnIncrease, .westminster) ]
  /-- None of the four positions lends another a premise. Each pair is checked
  by the proof checker. -/
  supports []
  /-- No position here is contained in another. Each pair is checked by the
  proof checker. -/
  partOf []
  /-- The Reformers' answer drawn: who defeats whom. -/
  map reformersAnswerMap

/-- **The Reformers' answer hears no later voice.** Every reference each party
cites, for its claims and for its steps, is Scripture or a work dated before
1648. -/
theorem reformers_answer_hears_no_later_voice :
    reformersAnswerDispute.citesOnlyBefore .trentOnIncrease 1648 = true ∧
      reformersAnswerDispute.citesOnlyBefore .calvin 1648 = true ∧
      reformersAnswerDispute.citesOnlyBefore .chemnitz 1648 = true ∧
      reformersAnswerDispute.citesOnlyBefore .westminster 1648 = true := by
  decide +kernel

/-- **The Reformers' answer, told in the order it was given.** The council
first, then Calvin within the year, Chemnitz in 1566, and Westminster a century
later. Where a
turn answers an earlier one it defeats it and is not defeated by it; where it
meets one, the two defeat each other, as the solver computes from their
premises. -/
declare_bundle reformersAnswerExchange in reformersAnswerDispute.finite where
  /-- The council: justification is "not remission of sins merely, but also the
  sanctification and renewal of the inward man" (ch. 7), and the justified "are
  still further justified" (ch. 10). -/
  turn ReformersAnswerParty.trentOnIncrease from trentSessionVI
  /-- Calvin: "whosoever asserts that works have the effect of increasing
  justification, understands neither what is the meaning of justification nor
  its cause" (*Antidote*, p. 158). -/
  turn ReformersAnswerParty.calvin meets ReformersAnswerParty.trentOnIncrease
    from calvinAntidoteWork
  /-- Chemnitz: "one and the same is the justification, both at the beginning of
  conversion, and that by which we come at last to eternal life" (*Examen*,
  p. 175). -/
  turn ReformersAnswerParty.chemnitz meets ReformersAnswerParty.trentOnIncrease
    from chemnitzExamen
  /-- Westminster: God justifies "not by infusing righteousness into them, but
  by pardoning their sins" (XI.1). -/
  turn ReformersAnswerParty.westminster meets ReformersAnswerParty.trentOnIncrease
    from westminsterConfession

/-- The reading the three answers share: justification is a verdict only, it has
no degrees, works do not cause it to increase, and the renewal of the inward man
is no part of it. It also leaves out what other chapters show the Reformers
denying: baptism as the instrument of justification, faith formed by charity,
and the council's readings of Revelation 22:11 and Sirach 18:22 from the
Latin text ("let him be justified still"), which the chapter "Trent's two Latin
texts" weighs against the Greek. Every other claim is held true on it, except
where one claim's meaning excludes another. -/
def reformersAnswerReading : Valuation Claim := fun a =>
  match a with
  | .justificationHasDegrees => False
  | .worksCauseIncreaseOfJustification => False
  | .justificationIncludesSanctification => False
  | .baptismIsInstrumentalCause => False
  | .justifyingFaithIsFormedByCharity => False
  | .jamesUsesDikaioAsPaul => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | .paulsJustifyDenotesRenewal => False
  | _ => True

/-- **Calvin, Chemnitz and Westminster stand together.** One reading satisfies
all three at once: justification is a verdict only, it has no degrees, works do
not increase it, and the renewal of the inward man is no part of it. -/
theorem the_reformers_answers_stand_together :
    reformersAnswerDispute.StandTogether [.calvin, .chemnitz, .westminster] := by
  satisfied_by reformersAnswerReading [Dispute.StandTogether, solaFideDefs]

/-- Why nothing stands: the council defeats Calvin, and Calvin, Chemnitz and
Westminster each defeat the council. -/
declare_verdict reformersAnswerSettle for reformersAnswerDispute :
    .nothingGrounded
      [ (.trentOnIncrease, .calvin), (.calvin, .trentOnIncrease)
      , (.chemnitz, .trentOnIncrease), (.westminster, .trentOnIncrease) ]
  /-- **Among the voices of 1547 to 1647, the council and its three answerers
  defeat one another, and none of them stands.** The council holds that
  justification is also renewal, and that good works are a cause of its
  increase (canon 24). Calvin, Chemnitz and Westminster each deny it, from what
  justification is: a verdict, which has no degrees (Calvin), one and the same
  from conversion to eternal life (Chemnitz), and a pardon and an accounting
  "not by infusing righteousness" (Westminster XI.1). An attack defeats unless
  the attacker's weakest premise or step is rated lower than the position it
  attacks. On each side the weakest premise is its definition of
  justification, rated *disputed*: the council's because Westminster XI.1
  denies it in terms, Calvin's because canon 11 denies it in terms. Chemnitz's
  and Westminster's readings of Romans 4 are rated *disputed* too, because
  Bellarmine and Augustine grant their texts and deny where they end. So every
  attack defeats, each position is defeated, and nothing is left that survives
  however the disagreements are settled. -/
  proves @[headline] after_the_reformers_answer_nothing_stands

#print axioms after_the_reformers_answer_nothing_stands

/-! ### The two definitions, by the same checks -/

/-- **Augustine, against the definition that justification is a verdict only.**
"What else does the phrase 'being justified' signify than being made righteous,
by Him, of course, who justifies the ungodly man, that he may become a godly
one?" (*On the Spirit and the Letter*, ch. 45). His starting point is that he
explained the word so, which is a fact about his book, and he argues from it
that justification includes the renewal of the person (`renewalLine`). So he
reaches his denial by a step, and rests on nothing a standard refuses: an
argument under all three standards. -/
def augustineOnForensicAssessment : Assessment Claim where
  dissenter := "Augustine (On the Spirit and the Letter, ch. 45)"
  against := "Calvin: justification is a verdict only (Antidote, p. 116)"
  dissent :=
    { claim := p .justificationIsForensicOnly
    , position := augustineCase }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])] }
  checked := by horn_certify

/-- **The council, against the same definition.** Canon 11 condemns
justification "by the sole imputation of the justice of Christ, or by the sole
remission of sins". The council holds its own definition as a premise (ch. 7),
and that premise alone denies Calvin's, because the two exclude each other by
what they mean. So it is a disagreement, not an argument, under every standard,
and under the evidence and the Scripture standards it also rests on the
council's word. -/
def canon11OnForensicAssessment : Assessment Claim where
  dissenter := "Trent, canon 11"
  against := "Calvin: justification is a verdict only (Antidote, p. 116)"
  dissent :=
    { claim := p .justificationIsForensicOnly
    , position := councilOnIncreaseCase }
  findings :=
    { consistent := true, denies := true, grants := true, argued := false, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.justificationIncludesSanctification, .renewalGrowsThroughGoodWorks])
        , (.tradition, [])
        , (.scriptural, [.justificationIncludesSanctification, .renewalGrowsThroughGoodWorks]) ] }
  checked := by horn_certify

/-- **Calvin, against the council's definition.** He holds his own definition as
a premise, and it alone denies the council's. A disagreement, not an argument,
under every standard, as canon 11 is against him. -/
def calvinOnDefinitionAssessment : Assessment Claim where
  dissenter := "Calvin (Antidote, pp. 116, 158)"
  against := "Trent: justification is the renewal of the inward man (ch. 7)"
  dissent :=
    { claim := p .justificationIncludesSanctification
    , position := calvinAgainstIncreaseCase }
  findings :=
    { consistent := true, denies := true, grants := true, argued := false, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.justificationIsForensicOnly])
        , (.tradition, [])
        , (.scriptural, [.justificationIsForensicOnly]) ] }
  checked := by horn_certify

/-- **Westminster, against the council's definition.** It argues from Romans
4:5–8 that God justifies by not counting sin, and not by infusing
righteousness (XI.1). So it reaches its denial by a step. But the step needs
"count" and "works" to keep one sense from 4:4–5 to 4:6–8, and those two
readings are cited to Chemnitz (*Examen*, p. 169), a theologian's word. So it is
an argument under the tradition standard only. -/
def westminsterOnDefinitionAssessment : Assessment Claim where
  dissenter := "Westminster XI.1, from Romans 4:5–8"
  against := "Trent: justification is the renewal of the inward man (ch. 7)"
  dissent :=
    { claim := p .justificationIncludesSanctification
    , position := westminsterOnJustificationCase }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, [.romans4CountKeepsItsSense, .romans4WorksKeepsItsSense])
        , (.tradition, [])
        , (.scriptural, [.romans4CountKeepsItsSense, .romans4WorksKeepsItsSense]) ] }
  checked := by horn_certify

/-- **Calvin's definition, with the objections to it**: Augustine, the strongest
known, and canon 11. -/
def forensicPremise : RatedStep Claim where
  step := "Calvin: justification is a verdict only (Antidote, p. 116)"
  support := (reformersAnswerCite .justificationIsForensicOnly).source
  register := [augustineOnForensicAssessment, canon11OnForensicAssessment]
  strongest := some 0

/-- **Both definitions are disputed under every standard, each by an argument
and not only by the other side's denial.** Calvin's, that justification is a
verdict only, is met by Augustine, who argues from his explanation of the word
that it includes renewal. Trent's, that it includes renewal, is met by Paul's
gospel and by Romans 4, each argued from the texts and the courtroom sense of
the verb (`trent_definition_ratings`). Each confession's denial of the other is
a disagreement only: canon 11 against Calvin, and Calvin's own definition
against the council's. Westminster's answer from Romans 4 is an argument under
the tradition standard only, because it needs Chemnitz's word that "count" and
"works" keep their sense through the passage. -/
@[headline]
theorem both_definitions_disputed_alike :
    forensicPremise.ratings =
        [ (.evidence, .disputedBy ["Augustine (On the Spirit and the Letter, ch. 45)"])
        , (.tradition, .disputedBy ["Augustine (On the Spirit and the Letter, ch. 45)"])
        , (.scriptural, .disputedBy ["Augustine (On the Spirit and the Letter, ch. 45)"]) ] ∧
      canon11OnForensicAssessment.findings.kind = .asserted ∧
      calvinOnDefinitionAssessment.findings.kind = .asserted ∧
      westminsterOnDefinitionAssessment.profile =
        [(.evidence, false), (.tradition, true), (.scriptural, false)] ∧
      definitionPremise.ratings.map (·.2.confidence) = [.disputed, .disputed, .disputed] := by
  decide +kernel

#print axioms both_definitions_disputed_alike

end TestimonyArguments.SolaFide
