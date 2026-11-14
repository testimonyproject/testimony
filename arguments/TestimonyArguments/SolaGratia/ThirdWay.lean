import TestimonyArguments.SolaGratia.Results
import TestimonyArguments.Meanings.SolaGratia
import Testimony.Logic.Dilemma

/-!
# TestimonyArguments.SolaGratia.ThirdWay — freedom to refuse, and the ability God gives

The strongest objection to sola gratia comes from the Arminian side, and it is
an objection from Scripture. Stephen told the council, "you always resist the
Holy Spirit" (Acts 7:51). Paul tells believers, "do not grieve the Holy Spirit of
God, by whom you were sealed for the day of redemption" (Ephesians 4:30), and
"do not quench the Spirit" (1 Thessalonians 5:19). Jesus says that "the
blasphemy against the Spirit will not be forgiven … either in this age or in
the age to come" (Matthew 12:31–32). If the Spirit can be resisted, grieved and
quenched, and if one sin against him is never forgiven, then surely the grace he
brings can be refused.

## What the texts settle, and what they do not

Every party grants what the texts say. Dort says that believers "grieve the Holy
Spirit" (V, article 5); Calvin, on Ephesians 4:30, that "we grieve him when we
do not follow his guidance"; the Formula of Concord, that "those who always
resist the Holy Ghost … are not converted". So the step from the texts to "the
Spirit's work is resisted" is rated *consensus*, the highest rating: accepted
across traditions.

The dispute is the next step, from resistance to the claim that the grace that
saves can be *finally* refused. "Resist" has two senses. A person can resist for
a time and be overcome, which the Reformed say happens to the elect before they
believe, and to believers when they grieve the Spirit and are brought back. Or a
person can refuse to the end. Only the second sense denies sola gratia, and
each route to it needs a reading of its own:

- **Acts 7:51**, read as resistance to the grace that saves, as the Remonstrants
  read it. The Reformed say that what Stephen's hearers resisted was the
  outward call of the preached word.
- **Ephesians 4:30**, read with the Formula of Concord: those who obstinately
  resist "do not receive, but grieve and lose, the Holy Ghost". Dort denies the
  reading: God "does not wholly withdraw the Holy Spirit from his own people,
  even in their melancholy falls".
- **Matthew 12:31–32**, read with Augustine: the sin never forgiven is
  impenitence to the end, "the persevering hardness of an impenitent heart".
  Calvin rejects the reading outright ("Those who define it to be impenitence
  may be refuted without any difficulty") and takes the sin to be knowing
  contempt of the Spirit, which the regenerate "cannot possibly fall into". And
  the step from Augustine's reading to final refusal of *saving* grace is rated
  `disputed`, because Augustine himself holds both that reading and that God is
  the one "whom no man's will resists when He wills to give salvation".

Grieving the Spirit is Paul's word, and it is addressed to believers. The
unforgivable sin is Jesus' word, in the Gospels. They are kept as two texts with
two readings, because no reader cited here takes grieving to be the
unforgivable sin.

## Two positions between Dort and the Remonstrants

**The Lutherans** of the Formula of Concord (1577) grant the ground of the
Reformed case's last step and deny its conclusion. They hold that conversion is
"not only in part, but altogether an operation, gift, and present, and work of
the Holy Ghost alone", and that in it man "does nothing whatever towards it, but
only suffers what God works in him". That is the third part of sola gratia as
Dort states it. And they deny that grace cannot be refused: "God does not force
man to become godly", and the perverse will "resists the Holy Ghost, who wishes
to be efficacious". So the step from "God's work alone" to grace effectual of
itself, grace that brings about the consent it seeks and so cannot be finally
refused, is rated *disputed*, and the Formula is why.

**Wesley** holds that "there is a measure of free-will supernaturally restored to
every man", so that each has "power either to resist or yield to the grace of
God"; that grace, which "goes before" anything a person does, he calls
"preventing grace". Faith itself is God's gift: "Of yourselves cometh neither your
faith nor your salvation". And it is received by faith alone: Wesley defends
"salvation or justification, by faith only" against the objection that it is
preaching against holiness (Sermon 1, III.1).

## The third way

The third way, as it was put to this argument: God gives the one who hears the
gospel the ability to believe, as Adam and Eve were made able to stand or to
fall (Genesis 2:16–17); the offer of grace is real; and it is received by faith
alone. The reality of the offer is not encoded as a premise, because no party
here denies it. Stated that way, the third way does not decide whether the grace
that saves can be finally refused: Dort's reading and Arminius's both satisfy
it, and disagree about exactly that (`third_way_leaves_resistibility_open`).

What decides it is what kind of help the ability is. Augustine drew the
distinction. "The aid without which a thing does not come to pass is one thing,
and the aid by which a thing comes to pass is another." Adam was given the first,
"not that by which it should be brought about that he should persevere, but that
without which he could not of free will persevere"; the saints are given the
second, "so that by means of this gift they cannot help persevering" (*On Rebuke
and Grace*, ch. 34). Read as Adam's kind of help, the third way is the reading
Wesley gives, and it cannot be held together with Dort's position. Read as the
saints' kind, it is Dort's reading, and it cannot be held together with the
Remonstrants'. Each break comes at a step or reading rated *disputed*, so
neither shows the other side right (`whatTheAbilityIs`).
-/

namespace TestimonyArguments.SolaGratia

open Testimony Testimony.Logic

/-! ### Each position, with its own conclusion

Each position below is stated with the conclusion its own sources draw, not with
sola gratia, so that it can be weighed against the others. -/

/-- What every party holds: salvation is by grace, from Romans 11:6. -/
@[solaGratiaDefs]
def graceCase : ArgumentPackage Claim :=
  graceLine.asPackage baseCite "salvation is by grace and not earned"

/-- Trent's position on the Molinist reading of canon 4: salvation by grace, the
will not passive, grace not effectual of itself, and not by faith alone. The
Thomists, who read the canon as compatible with grace effectual of itself, are
cited against its steps and are not a position here. -/
@[solaGratiaDefs]
def tridentinePosition : ArgumentPackage Claim :=
  { tridentine with
    conclusion :=
      ⋀ [ p .salvationIsByGrace, notP .willIsPassiveInRegeneration
        , notP .graceIsEffectualOfItself, notP .faithAloneReceivesGrace ]
    conclusionLabel :=
      "salvation by grace, with a will that cooperates and can refuse, not by faith alone" }

/-- The Remonstrants' position: salvation by grace, and a grace that can be
resisted to the end. -/
@[solaGratiaDefs]
def remonstrantPosition : ArgumentPackage Claim :=
  { remonstrant with
    conclusion := ⋀ [p .salvationIsByGrace, notP .graceIsEffectualOfItself]
    conclusionLabel := "salvation by grace, which can be resisted and refused" }

/-- The Lutherans' position: salvation by grace, the will passive in conversion,
the grace that converts resistible, and faith alone. -/
@[solaGratiaDefs]
def lutheranPosition : ArgumentPackage Claim :=
  { lutheran with
    conclusion :=
      ⋀ [ p .salvationIsByGrace, p .willIsPassiveInRegeneration
        , notP .graceIsEffectualOfItself, p .faithAloneReceivesGrace ]
    conclusionLabel :=
      "salvation by grace alone, the will passive, grace resistible, through faith alone" }

/-- Wesley's position: salvation by grace, a grace that goes before and can be
refused, and faith alone. -/
@[solaGratiaDefs]
def wesleyanPosition : ArgumentPackage Claim :=
  { wesleyan with
    conclusion :=
      ⋀ [p .salvationIsByGrace, notP .graceIsEffectualOfItself, p .faithAloneReceivesGrace]
    conclusionLabel := "salvation by grace, which can be refused, received by faith alone" }

/-! ### What each position reaches -/

/-- What every party holds follows from Romans 11:6. -/
theorem graceCase_establishes : Establishes graceCase := by
  establish [solaGratiaDefs]

/-- Trent's premises, on the Molinist reading of canon 4, deliver that position. -/
theorem tridentinePosition_establishes : Establishes tridentinePosition := by
  establish [solaGratiaDefs]

/-- The Remonstrants' fourth article delivers grace that can be refused. -/
theorem remonstrantPosition_establishes : Establishes remonstrantPosition := by
  establish [solaGratiaDefs]

/-- **The Lutheran premises reach the Lutheran position**: the will passive in
conversion, and the grace that converts resistible. The Reformed case joins the
two; the Formula of Concord holds them apart. This does not show the Lutherans
right, only that their premises deliver their position; that it can be held
without contradiction is `lutheranPosition_is_satisfiable`. -/
@[headline]
theorem lutheranPosition_establishes : Establishes lutheranPosition := by
  establish [solaGratiaDefs]

#print axioms lutheranPosition_establishes

/-- Wesley's premises reach grace that goes before, can be refused, and is
received by faith alone. -/
@[headline]
theorem wesleyanPosition_establishes : Establishes wesleyanPosition := by
  establish [solaGratiaDefs]

#print axioms wesleyanPosition_establishes

/-- The third way's premises reach salvation by grace, received by faith
alone. -/
@[headline]
theorem thirdWay_establishes : Establishes thirdWay := by
  establish [solaGratiaDefs]

#print axioms thirdWay_establishes

/-- **The objection from the Spirit's resistance is valid on its own grounds.**
Grant the texts of resistance and any one of its three readings, and the grace
that saves is not effectual of itself. -/
@[headline]
theorem objection_establishes : Establishes objection := by
  establish [solaGratiaDefs]

#print axioms objection_establishes

/-- **The third way leaves resistibility open.** Grant everything it says: Adam
made able to stand or fall, the ability to believe given by God, faith alone,
and that grace which can be finally refused is not effectual of itself. Whether
the grace that saves is effectual of itself neither follows nor fails. Arminius's
reading satisfies every premise and denies it; Dort's satisfies every premise and
holds it. So the third way, as stated, neither blocks sola gratia nor
establishes it. -/
@[headline]
theorem third_way_leaves_resistibility_open :
    Independent thirdWay.premises (p .graceIsEffectualOfItself) := by
  leaves_open arminiusReading dortReading [solaGratiaDefs]

#print axioms third_way_leaves_resistibility_open

/-! ### Each position can be held without contradiction

For each position, a reading is written down that makes every premise true. -/

/-- The third way has a model: Dort's reading. -/
theorem thirdWay_is_satisfiable : Satisfiable thirdWay.premises := by
  satisfied_by dortReading [solaGratiaDefs]

/-- The objection has a model: Arminius's reading. -/
theorem objection_is_satisfiable : Satisfiable objection.premises := by
  satisfied_by arminiusReading [solaGratiaDefs]

/-- The Lutheran reading: conversion is God's work alone and the will passive,
and the grace that does it can be resisted and lost. -/
def lutheranReading : Valuation Claim := fun a =>
  match a with
  | .graceIsEffectualOfItself => False
  | _ => True

/-- The Lutheran position has a model. -/
theorem lutheranPosition_is_satisfiable : Satisfiable lutheranPosition.premises := by
  satisfied_by lutheranReading [solaGratiaDefs]

/-- Trent's position has a model: Trent's reading. -/
theorem tridentinePosition_is_satisfiable : Satisfiable tridentinePosition.premises := by
  satisfied_by trentsReading [solaGratiaDefs]

/-- The Remonstrants' position has a model: Arminius's reading. -/
theorem remonstrantPosition_is_satisfiable : Satisfiable remonstrantPosition.premises := by
  satisfied_by arminiusReading [solaGratiaDefs]

/-- Wesley's position has a model. -/
theorem wesleyanPosition_is_satisfiable : Satisfiable wesleyanPosition.premises := by
  satisfied_by arminiusReading [solaGratiaDefs]

/-- What every party holds has a model. -/
theorem graceCase_is_satisfiable : Satisfiable graceCase.premises := by
  satisfied_by dortReading [solaGratiaDefs]

/-! ### What kind of help the ability is -/

attribute [solaGratiaDefs] ArgumentPackage.readAs

/-- The ability read as Adam's kind of help: it makes believing possible, and the
grace that gives it can be finally refused. Wesley's reading. -/
@[solaGratiaDefs]
def asAidWithoutWhich : Reading Claim :=
  { name := "as the help without which a person cannot believe, Adam's kind"
  , commits := p .savingGraceCanBeFinallyRefused
  , source := asAidWithoutWhichSource }

/-- The ability read as the saints' kind of help: the grace that gives it brings
believing about. Augustine's reading of the grace given to the saints, and
Dort's. -/
@[solaGratiaDefs]
def asAidByWhich : Reading Claim :=
  { name := "as the help by which a person believes, the saints' kind"
  , commits := p .graceIsEffectualOfItself
  , source := asAidByWhichSource }

/-- The third way, with the ability read as Adam's kind of help. -/
@[solaGratiaDefs]
def thirdWayAsAidWithoutWhich : ArgumentPackage Claim :=
  thirdWay.readAs (p .abilityToBelieveIsGiven) asAidWithoutWhich

/-- The third way, with the ability read as the saints' kind of help. -/
@[solaGratiaDefs]
def thirdWayAsAidByWhich : ArgumentPackage Claim :=
  thirdWay.readAs (p .abilityToBelieveIsGiven) asAidByWhich

/-- The third way, read as giving Adam's kind of help, can be held without
contradiction: Arminius's reading satisfies it, and it is the reading Wesley
gives. -/
theorem thirdWayAsAidWithoutWhich_is_satisfiable :
    Satisfiable thirdWayAsAidWithoutWhich.premises := by
  satisfied_by arminiusReading [solaGratiaDefs]

/-- The third way, read as giving the saints' kind of help, can be held without
contradiction: Dort's reading satisfies it, and it is the reading Dort gives. -/
theorem thirdWayAsAidByWhich_is_satisfiable : Satisfiable thirdWayAsAidByWhich.premises := by
  satisfied_by dortReading [solaGratiaDefs]

/-- The Remonstrants hold together with the first reading: Arminius's reading
satisfies both. -/
theorem remonstrants_do_not_reach_adams_kind :
    Satisfiable (remonstrantPosition.premises ++ thirdWayAsAidWithoutWhich.premises) := by
  satisfied_by arminiusReading [solaGratiaDefs]

/-- Dort holds together with the second reading: Dort's reading satisfies both. -/
theorem dort_does_not_reach_the_saints_kind :
    Satisfiable (reformed.premises ++ thirdWayAsAidByWhich.premises) := by
  satisfied_by dortReading [solaGratiaDefs]

/-- **Why Dort stands against the third way, read as Adam's kind of help.** The
crux is Dort's step from God's work alone to grace effectual of itself, that is,
grace that brings about the consent it seeks and so cannot be finally refused;
the Lutherans dispute it. With the Romans strand granted, the reading of Romans
9:16 as being about God's mercy in saving, the crux breaks the third way at
three of its premises: the ability given, the reading of it as a help that can
be refused, and the step every party grants, that grace which can be finally
refused is not effectual of itself. -/
def whereAdamsKindFalls : Because reformed thirdWayAsAidWithoutWhich :=
  Because.ofChecks effectualStep
    (caseOf [graceLine, ephesiansLine, giftLine, romansLine, textsOfResistanceLine]
      reformedShared [passiveStep]) []
    [p .romans9_16, p .romans9_16ConcernsSalvation, romansStep]
    [ p .abilityToBelieveIsGiven
    , p .abilityToBelieveIsGiven ➝ p .savingGraceCanBeFinallyRefused, refusalStep ]
    .derives reformed_establishes reformed_is_satisfiable
    (by simp [reformed, caseOf, closingSteps])
    (by simp [solaGratiaDefs, caseOf])
    (by simp [solaGratiaDefs, caseOf])
    (by decide +kernel)

/-- **Why the Remonstrants stand against the third way, read as the saints' kind
of help.** The crux is the step every party grants, that grace which can be
finally refused is not effectual of itself. With the Remonstrants' reading of
Acts 7:51 granted, it breaks the third way at two of its premises: the ability
given, and the reading of it as a help that brings believing about. Every party
grants that step, so what the break really rests on is the Remonstrants' reading
of Acts 7:51, which Dort denies. -/
def whereTheSaintsKindFalls : Because remonstrantPosition thirdWayAsAidByWhich :=
  Because.ofChecks refusalStep
    ([ p .romans11_6, p .acts7_51, p .ephesians4_30, p .thessalonians5_19
     , p .acts7_51ResistsSavingGrace
     , p .ephesians2_1to5, p .ephesians2_8to9, p .faithIsGodsGift
     , p .romans9_16, p .romans9_16ConcernsSalvation ] ++
     [graceStep, textsOfResistanceStep, resistanceStep]) []
    [ p .acts7_51, p .ephesians4_30, p .thessalonians5_19, p .acts7_51ResistsSavingGrace
    , textsOfResistanceStep, resistanceStep ]
    [p .abilityToBelieveIsGiven, p .abilityToBelieveIsGiven ➝ p .graceIsEffectualOfItself]
    .derives remonstrantPosition_establishes remonstrantPosition_is_satisfiable
    (by simp [remonstrantPosition, remonstrant, caseOf, solaGratiaDefs])
    (by simp [solaGratiaDefs, caseOf])
    (by simp [solaGratiaDefs, caseOf])
    (by decide +kernel)

/-- **What the ability God gives is, read both ways.** The claim is the third
way's: God gives the one who hears the gospel the ability to believe, as Adam was
made able to stand or to fall.

Read as Adam's kind of help, the help "without which" a person cannot believe,
it is the reading Wesley gives, and the Remonstrants can hold it without
contradiction. It cannot be held together with Dort's position. The break comes
at Dort's step from God's work alone to grace effectual of itself, and that step
is rated *disputed*, because the Lutherans grant its ground and deny its
conclusion; so the break does not show Dort right.

Read as the saints' kind, the help "by which" a person believes, it is Dort's
reading, and Dort can hold it without contradiction. It cannot be held together
with the Remonstrants' position. The break rests on their reading of Acts 7:51,
which is rated *disputed* too.

Each reading is fair: the third way read either way can be held without
contradiction. Which reading its holder means is not something the dilemma
decides. What it shows is that the third way takes a side the moment it says
which kind of help God gives, and which side depends on the answer. -/
def whatTheAbilityIs : Dilemma thirdWay where
  claim := p .abilityToBelieveIsGiven
  horns :=
    [ { reading := asAidWithoutWhich
      , fair := thirdWayAsAidWithoutWhich_is_satisfiable
      , fates :=
          [ .falls reformed whereAdamsKindFalls
          , .unreached remonstrantPosition remonstrantPosition_establishes
              remonstrants_do_not_reach_adams_kind ]
      , answered := by simp }
    , { reading := asAidByWhich
      , fair := thirdWayAsAidByWhich_is_satisfiable
      , fates :=
          [ .falls remonstrantPosition whereTheSaintsKindFalls
          , .unreached reformed reformed_establishes dort_does_not_reach_the_saints_kind ]
      , answered := by simp } ]
  claim_mem := by simp [solaGratiaDefs, caseOf]
  two := by simp

end TestimonyArguments.SolaGratia
