import TestimonyArguments.SolaGratia.Lines

/-!
# TestimonyArguments.SolaGratia.Packages — the positions, and the variants the results ask about

The rivals come first, because they were written first. Each is a position as
its own documents state it: Trent from the sixth session's decree and canons on
justification, the Remonstrants from their five articles of 1610 and from
Arminius. Neither is Pelagian. Both say, in so many words, that salvation is by
grace, and both packages carry the line from Romans 11:6 that delivers it.

Two more positions follow, each a way of holding grace and freedom together
that is neither Dort's nor the Remonstrants'. The Lutherans of the Formula of
Concord hold the will "purely passive" in conversion and grace resistible all
the same. Wesley holds that God restores to everyone a measure of the freedom
lost in Adam, so that each can receive the offer by faith or refuse it. And the
third way as it was put to this argument, that God gives the ability to believe
as Adam was made able to stand or fall, and faith alone receives, is stated
without saying which kind of help that ability is, because that is what a
dilemma below asks.

The variants after the Reformed package each change one thing, named, so that a
result about a variant is a result about that one change.
-/

namespace TestimonyArguments.SolaGratia

open Testimony Testimony.Logic

/-- The label every package asked for the conclusion shares. -/
private def solaGratiaLabel : String :=
  "salvation by grace alone: grace brings about the consent it seeks, and the will " ++
  "contributes nothing to its own new life"

/-! ### The rivals -/

/-- **Trent**, from the sixth session (1547). Romans 11:6, which its eighth
chapter quotes; Zechariah 1:3 read with Lamentations 5:21, as its fifth chapter
reads them; and canon 4, on the will that cooperates by assenting and can refuse
if it wishes. -/
@[solaGratiaDefs]
def tridentine : ArgumentPackage Claim :=
  { name := "Trent (Session VI, canon 4)"
  , cite := tridentineCite
  , premises :=
      caseOf [graceLine, cooperationLine, dissentLine] [notP .faithAloneReceivesGrace] []
  , conclusion := solaGratia
  , conclusionLabel := solaGratiaLabel
  , inferences := [graceInference, cooperationInference, dissentInference] }

/-- **The Remonstrants**, from their articles of 1610 and from Arminius.
Romans 11:6; the texts of resistance, which every party grants; the fourth
article, that grace is not irresistible, read from Acts 7:51; and what Arminius
grants of the Reformed case: the texts of Ephesians 2, that
faith is God's gift, and that Romans 9:16 is about salvation. What is left out
is the two steps from those to God's work alone, which are the steps he
refuses. -/
@[solaGratiaDefs]
def remonstrant : ArgumentPackage Claim :=
  { name := "Remonstrant (the Five Articles, 1610)"
  , cite := remonstrantCite
  , premises :=
      caseOf [graceLine, textsOfResistanceLine, resistanceLine, refusalLine]
        [ p .ephesians2_1to5, p .ephesians2_8to9, p .faithIsGodsGift
        , p .romans9_16, p .romans9_16ConcernsSalvation ] []
  , conclusion := solaGratia
  , conclusionLabel := solaGratiaLabel
  , inferences :=
      [graceInference, textsOfResistanceInference, resistanceInference, refusalInference] }

/-- **The Lutherans**, from the Formula of Concord (1577) and the Augsburg
Confession (1530). Conversion is the Holy Spirit's work alone, and in it the
will is "purely passive"; yet those who obstinately resist the Spirit "grieve
and lose" him, so the grace that saves can be finally refused, and where it is,
the fault is the person's own. Grace is received by faith
alone. -/
@[solaGratiaDefs]
def lutheran : ArgumentPackage Claim :=
  { name := "Lutheran (the Formula of Concord)"
  , cite := lutheranCite
  , premises :=
      caseOf [graceLine, textsOfResistanceLine, griefLine, refusalLine]
        [p .conversionIsGodsWorkAlone, p .faithAloneReceivesGrace] [passiveStep]
  , conclusion := solaGratia
  , conclusionLabel := solaGratiaLabel
  , inferences :=
      [ graceInference, textsOfResistanceInference, griefInference, refusalInference
      , passiveInference ] }

/-- **Wesley.** God restores to every person a measure of free will, by the
grace that goes before ("preventing grace"), so that each is able to believe;
that grace can be resisted or yielded to; and it is received by faith alone. -/
@[solaGratiaDefs]
def wesleyan : ArgumentPackage Claim :=
  { name := "Wesleyan (preventing grace)"
  , cite := wesleyanCite
  , premises :=
      caseOf [graceLine, textsOfResistanceLine, refusalLine]
        [ p .abilityToBelieveIsGiven, p .savingGraceCanBeFinallyRefused
        , p .faithAloneReceivesGrace ] []
  , conclusion := solaGratia
  , conclusionLabel := solaGratiaLabel
  , inferences := [graceInference, textsOfResistanceInference, refusalInference] }

/-- **The third way, as it was put to this argument.** As Adam was made able to
stand or to fall (Genesis 2:16–17), so God gives the one who hears the gospel
the ability to believe, and grace is received by faith alone. That the offer is
real is part of the third way too, and is not encoded as a premise, because no
party here denies it. Stated this way it does not say what kind of help the ability is, whether one
that makes believing possible or one that brings it about. It carries the step
every party grants, that grace which can be finally refused is not effectual of
itself, and nothing that would decide whether it can be. -/
@[solaGratiaDefs]
def thirdWay : ArgumentPackage Claim :=
  { name := "The third way (an ability given, received by faith)"
  , cite := baseCite
  , premises :=
      caseOf [graceLine, refusalLine]
        [p .genesis2_16to17, p .abilityToBelieveIsGiven, p .faithAloneReceivesGrace] []
  , conclusion := ⋀ [p .salvationIsByGrace, p .faithAloneReceivesGrace]
  , conclusionLabel :=
      "salvation is by grace, through an ability God gives, received by faith alone"
  , inferences := [graceInference, refusalInference] }

/-- **The objection from the Spirit's resistance, strengthened.** Three routes to
the claim that the grace that saves can be finally refused. Two run from the
texts of resistance: with the Remonstrants' reading of what Stephen's hearers
resisted, and with the Formula of Concord's reading of grieving the Spirit, that
it can end in losing him. The third runs from the sin that is never forgiven,
read with Augustine as impenitence to the end. It concludes the denial of the
second part of sola gratia, and nothing about the others. -/
@[solaGratiaDefs]
def objection : ArgumentPackage Claim :=
  { name := "The objection from the Spirit's resistance"
  , cite := remonstrantCite
  , premises :=
      caseOf [textsOfResistanceLine, resistanceLine, griefLine, blasphemyLine, refusalLine] [] []
  , conclusion := notP .graceIsEffectualOfItself
  , conclusionLabel := "the grace that saves is not effectual of itself"
  , inferences :=
      [ textsOfResistanceInference, resistanceInference, griefInference, blasphemyInference
      , refusalInference ] }

/-! ### The position argued for -/

/-- **The Reformed position**, as the Synod of Dort (1619) and the Westminster
Confession (1647) state it. Two routes to God's work alone, one through
Ephesians 2 and one through Romans 9:16, with Romans 11:6 for the first part of
the conclusion, and the Reformed answer to Acts 7:51. -/
@[solaGratiaDefs]
def reformed : ArgumentPackage Claim :=
  { name := "Reformed (the Canons of Dort)"
  , cite := reformedCite
  , premises :=
      caseOf [graceLine, ephesiansLine, giftLine, romansLine, textsOfResistanceLine]
        reformedShared closingSteps
  , conclusion := solaGratia
  , conclusionLabel := solaGratiaLabel
  , inferences :=
      [ graceInference, ephesiansInference, giftInference, romansInference
      , textsOfResistanceInference ] ++ closingInferences }

/-! ### Each strand alone -/

/-- The Ephesians strand alone: Romans 11:6, Ephesians 2 with its reading of
"this", and the step from the gift to God's work alone. -/
@[solaGratiaDefs]
def ephesiansStrand : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, the Ephesians strand alone"
    premises := caseOf [graceLine, ephesiansLine, giftLine] reformedShared closingSteps }

/-- The Romans strand alone: Romans 11:6, and Romans 9:16 read as being about
salvation. -/
@[solaGratiaDefs]
def romansStrand : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, the Romans strand alone"
    premises := caseOf [graceLine, romansLine] reformedShared closingSteps }

/-- The Ephesians strand without the step Arminius refuses: every text and
reading it rests on, and the step to faith as God's gift, with only the step
from the gift to God's work alone left out. The Reformed answer to Acts 7:51 is
not part of the strand, and is left out with the rest of what the strand does
not read. -/
@[solaGratiaDefs]
def ephesiansWithoutTheGiftStep : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, the Ephesians strand without the step from the gift"
    premises := caseOf [graceLine, ephesiansLine] [p .ephesians2_1to5] closingSteps }

/-! ### The readings, removed -/

/-- The Reformed position without its reading of "this" in Ephesians 2:8. The
Romans strand is untouched. -/
@[solaGratiaDefs]
def reformedWithoutTouto : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus its reading of \"this\" in Ephesians 2:8"
    premises :=
      caseOf
        [ graceLine, ephesiansLine.onGrounds [p .ephesians2_8to9], giftLine, romansLine
        , textsOfResistanceLine ]
        reformedShared closingSteps }

/-- The Reformed position without the reading of Romans 9:16 as being about
salvation. The Ephesians strand is untouched. -/
@[solaGratiaDefs]
def reformedWithoutRomansReading : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus Romans 9:16 as being about salvation"
    premises :=
      caseOf
        [ graceLine, ephesiansLine, giftLine, romansLine.onGrounds [p .romans9_16]
        , textsOfResistanceLine ]
        reformedShared closingSteps }

/-- The Reformed position without either reading. Every text is kept, and every
step. -/
@[solaGratiaDefs]
def reformedWithoutEitherReading : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus both readings"
    premises :=
      caseOf
        [ graceLine, ephesiansLine.onGrounds [p .ephesians2_8to9], giftLine
        , romansLine.onGrounds [p .romans9_16], textsOfResistanceLine ]
        reformedShared closingSteps }

end TestimonyArguments.SolaGratia
