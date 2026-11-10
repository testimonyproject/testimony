import TestimonyArguments.SolaFide.JesusWords

/-!
# TestimonyArguments.SolaFide.Baptism — is baptism the instrument of justification?

Trent calls baptism "the instrumental cause" of justification: "the sacrament of
baptism, which is the sacrament of faith, without which (faith) no man was ever
justified" (Session VI, ch. 7). The "without which" refers to faith, not to
baptism, as the translator Waterworth's bracket shows. The Reformed hold baptism
to be Christ's own ordinance, a sign and seal of the covenant of grace
(Westminster XXVIII.1), and faith to be "the alone instrument of justification"
(XI.2). A reader asks: *does the New Testament make water baptism the instrument
that justifies?*

A reminder of the ratings. A step is `disputed` when a cited reader accepts its
starting points and denies its conclusion. It is `wellSupported` when no such
reader was found. It is `consensus` when every side accepts it.

## Three things called baptism

"Baptism" names three things in the New Testament. Each is a separate claim
here, so that no argument slides from one to another unnoticed.

- **Water.** John's baptism, and the one Christ commands (Matthew 28:19; Acts
  2:38). Trent's instrumental cause is *this* one. It is not a "commandment of
  men", since Jesus commands it, so the argument from Mark 7 against human
  tradition (in the sola scriptura argument) does not apply to it as such. The
  disagreement is over the role Trent gives it.
- **The Spirit.** "He will baptize you with the Holy Spirit." In Acts the Spirit
  comes after the water (Samaria, 8:14–17) and before it (Cornelius, 10:44–48).
- **"And fire"** (Matthew 3:11; Luke 3:16). Gregory Nazianzen reads the fire as
  judgement, the chaff burned. Calvin reads it as purification. Cyril of
  Jerusalem reads it as Pentecost's tongues "as of fire". All three readings are
  written down, and none is chosen: the text does not settle between them
  (`the_baptist_leaves_the_fire_open` and the two results after it).

## What Trent's claim says

Trent qualifies its own claim. Justification "cannot be effected, without the
laver of regeneration, **or the desire thereof**" (ch. 4). So the claim can be
taken two ways, and `whatTrentsInstrumentalCauseClaims` answers both.

- **Taken so that the washing itself is necessary for salvation.** This is
  Feeney's reading: desire may justify, but "It is now: Baptism of Water, or
  damnation!" No reader was found who holds the water itself necessary for
  *justification*; Feeney too grants that desire justifies. Taken Feeney's way,
  the claim cannot be held together with the thief promised paradise unbaptised
  (Luke 23:43), read as Augustine reads him. Nor can it be held with Rome's own
  teaching that the desire "assures them the salvation" (Catechism 1259). Both
  steps are `wellSupported`.
- **Taken as "baptism or the desire for it"**, Trent's own words. The thief does
  not count against this. What it meets is a question the desire raises. Where
  only the desire is present, what justifies is not the washing, since the
  desire "brings about the fruits of Baptism without being a sacrament"
  (Catechism 1258). Then what is the instrument, and how does it differ from
  faith? The Reformed answer is that the instrument is faith, and the sacrament
  is not. Aquinas accepts the premises and denies that: the desire is a desire
  *for* the sacrament, and when the sacrament follows it gives "a yet greater
  fulness of grace". So the step is `disputed`.

Neither way of taking the claim is ruled out by what is argued here. The first
is answered by texts and teaching that Rome itself holds. The second stands at a
disputed step, where the question is whether the desire is faith under another
name.

## John 3:5

"Unless one is born of water and the Spirit, he cannot enter the kingdom of God"
is the verse Trent cites in chapter 4, and Session VII condemns whoever "wrests,
to some sort of metaphor" its water. `whatJohnThreeFiveMeans` takes the four
readings of "water" that are on record.

- Baptismal water: Trent, and most early Christian writers, as Calvin reports.
- Natural birth: Oliver.
- The cleansing promised in Ezekiel 36:25–27: Carson.
- The Spirit's own cleansing, with "water and Spirit" naming one thing: Calvin.

What can be taken more than one way here is the verse, not Trent. Trent argues
from the verse to water baptism, and each reading is a reading of the verse's
"water". Only the baptismal reading leaves Trent's step standing. The other
three each rule it out, at a step rated `wellSupported`.

The baptismal reading cannot be held together with Calvin's. The step from
Calvin's reading is `wellSupported`, but his reading itself is `disputed`, and
Trent condemns it. Even on the baptismal reading Trent's step stays `disputed`:
Calvin accepts the verse and denies that it requires water baptism. Which
reading is right is not decided here.

## Acts gives both orders

In Samaria the water comes first and the Spirit after. At Caesarea the Spirit
comes first and the water after. The Reformed argue from this that the Spirit is
not tied to the water; Calvin on Acts 10:47: "the Spirit is not included in
baptism". Rome says as much in its own words: "God has bound salvation to the
sacrament of Baptism, but he himself is not bound by his sacraments" (Catechism
1257).

So that God is not bound to the water is accepted on both sides
(`trent_grants_god_is_not_bound`). It is not a point won by the Reformed.
Calvin's further claim, that the Spirit is not included in the sign, is not what
Rome accepts. What remains in dispute is the first half of the Catechism's
sentence, that God has bound salvation to the sacrament, and Trent's further
claim that the sacrament is the instrument of justification, which is the
question above.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic

/-! ### Trent's claim, and two ways of taking it -/

/-- **Trent's instrumental cause**, as Trent states it: water baptism is the
instrumental cause of justification. -/
@[solaFideDefs]
def trentOnBaptism : ArgumentPackage Claim :=
  { name := "Trent: baptism the instrumental cause of justification"
  , cite := baseCite
  , premises := [p .baptismIsInstrumentalCause]
  , conclusion := p .baptismIsInstrumentalCause
  , conclusionLabel := "water baptism is the instrumental cause of justification" }

/-- Taking the instrumental cause so that the washing itself is necessary for
salvation. This is Feeney's reading. Rated `disputed`: Rome's own teaching
denies it (Catechism 1258–1260). -/
def feeneyReadsTrent : Source :=
  { primary := .work feeneyBreadOfLife .whole
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- Taking the instrumental cause as Trent's chapter 4 qualifies it: the laver of
regeneration, or the desire for it. Rated `consensus`, since it is what Trent
says. -/
def trentReadsItsOwnClaim : Source :=
  { primary := .work waterworthTrent (.page 32)
  , tradition := .romanCatholic
  , confidence := .consensus }

/-- The instrumental cause, **taken so that the washing itself is necessary for
salvation**. -/
@[solaFideDefs]
def asTheWaterItself : Reading Claim :=
  { name := "so that the washing itself is necessary for salvation"
  , commits := p .waterItselfNecessaryForSalvation
  , source := feeneyReadsTrent }

/-- The instrumental cause, **taken as baptism or the desire for it**. -/
@[solaFideDefs]
def asBaptismOrItsDesire : Reading Claim :=
  { name := "as baptism or the desire of it"
  , commits := p .baptismOrItsDesire
  , source := trentReadsItsOwnClaim }

/-- Trent's instrumental cause, taken so that the washing itself is necessary. -/
@[solaFideDefs]
def trentOnTheWaterItself : ArgumentPackage Claim :=
  trentOnBaptism.readAs (p .baptismIsInstrumentalCause) asTheWaterItself

/-- Trent's instrumental cause, taken as baptism or the desire for it. -/
@[solaFideDefs]
def trentOnBaptismOrDesire : ArgumentPackage Claim :=
  trentOnBaptism.readAs (p .baptismIsInstrumentalCause) asBaptismOrItsDesire

/-! ### What each is set against -/

/-- From the thief to "the washing is not necessary": he was promised paradise
unbaptised, and his case bears on salvation under the Gospel. -/
@[solaFideDefs]
def thiefToNotNecessary : Formula Claim :=
  ⋀ [p .luke23_43ThiefPromisedParadise, p .thiefBearsOnTheGospel]
  ➝ notP .waterItselfNecessaryForSalvation

/-- **The thief on the cross**, as Augustine reads him: the washing itself is not
necessary for salvation. -/
@[solaFideDefs]
def thiefCase : ArgumentPackage Claim :=
  { name := "The thief on the cross (Luke 23:43), read with Augustine"
  , cite := baseCite
  , premises :=
      [p .luke23_43ThiefPromisedParadise, p .thiefBearsOnTheGospel, thiefToNotNecessary]
  , conclusion := notP .waterItselfNecessaryForSalvation
  , conclusionLabel := "the washing itself is not necessary for salvation"
  , inferences := [augustineOnTheThief] }

/-- From what the desire brings to "the washing is not necessary". -/
@[solaFideDefs]
def desireToNotNecessary : Formula Claim :=
  p .desireBringsFruitsWithoutTheSacrament ➝ notP .waterItselfNecessaryForSalvation

/-- **Rome's own teaching on the desire**: it brings about the fruits of baptism, so
the washing itself is not necessary for salvation. -/
@[solaFideDefs]
def desireCase : ArgumentPackage Claim :=
  { name := "The desire for baptism (Catechism 1258–1259)"
  , cite := baseCite
  , premises := [p .desireBringsFruitsWithoutTheSacrament, desireToNotNecessary]
  , conclusion := notP .waterItselfNecessaryForSalvation
  , conclusionLabel := "the washing itself is not necessary for salvation"
  , inferences := [catechismOnDesire] }

/-- The Reformed step from the desire. If justification needs only the laver or the
desire for it, and the desire alone brings the fruits of baptism without the
sacrament, then the sacrament is not the instrument of justification. Held by
Westminster (XXVIII.5; XI.2). Rated `disputed`, because Aquinas accepts the
starting points and denies the conclusion. -/
@[solaFideDefs]
def desireToNotTheInstrument : Formula Claim :=
  ⋀ [p .baptismOrItsDesire, p .desireBringsFruitsWithoutTheSacrament]
  ➝ notP .baptismIsInstrumentalCause

/-- **The question the desire raises.** Where only the desire is present, what
justifies is not the washing, so the washing is not the instrument. This is the
Reformed answer to Trent taken in its own words. -/
@[solaFideDefs]
def reformedOnTheDesire : ArgumentPackage Claim :=
  { name := "What justifies where only the desire is present"
  , cite := baseCite
  , premises :=
      [ p .baptismOrItsDesire, p .desireBringsFruitsWithoutTheSacrament
      , desireToNotTheInstrument ]
  , conclusion := notP .baptismIsInstrumentalCause
  , conclusionLabel := "the sacrament is not the instrument of justification"
  , inferences := [westminsterOnTheDesire, aquinasOnTheDesire] }

/-! ### The positions, written out -/

/-- Rome's position. Baptism is the instrumental cause. The desire for it brings its
fruits. The thief is saved. God is not bound to his sacraments. The water of
John 3:5 is baptismal. And the washing itself is not necessary for salvation.
Since baptism is a means of justification, faith is not the only means; and
since justification includes sanctification, it is not a verdict only. -/
def romeOnBaptismReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .waterItselfNecessaryForSalvation => False
  | .john3_5WaterIsNaturalBirth => False
  | .john3_5WaterIsEzekielsCleansing => False
  | .john3_5WaterIsTheSpiritsCleansing => False
  | .justificationByFaithAlone => False
  | .justificationIsForensicOnly => False
  | _ => True

/-- A consistent way of holding Feeney's reading: baptism is the instrumental cause,
and the washing itself is necessary for salvation. It has to deny that the
thief's case bears on the Gospel, and that the desire brings the fruits that
save. The first denial is what his reading requires; it is not a sentence quoted
from him. With Trent, it denies that faith is the only means of justification,
and that justification is a verdict only. -/
def feeneyReading : Valuation Claim := fun a =>
  match a with
  | .thiefBearsOnTheGospel => False
  | .desireBringsFruitsWithoutTheSacrament => False
  | .john3_5WaterIsNaturalBirth => False
  | .john3_5WaterIsEzekielsCleansing => False
  | .john3_5WaterIsTheSpiritsCleansing => False
  | .justificationByFaithAlone => False
  | .justificationIsForensicOnly => False
  | _ => True

/-- The Reformed position. Faith is the instrument, and baptism is not.
Justification is the remission of sins, not sanctification. The desire brings
the fruits, the thief is saved, and God is not bound to water. The water of John
3:5 is the Spirit's own cleansing, and the verse does not require water baptism. -/
def reformedOnBaptismReading : Valuation Claim := fun a =>
  match a with
  | .baptismIsInstrumentalCause => False
  | .waterItselfNecessaryForSalvation => False
  | .john3_5RequiresWaterBaptism => False
  | .john3_5WaterIsBaptism => False
  | .justificationIncludesSanctification => False
  | _ => True

/-! ### Each position holds together -/

/-- Trent's claim follows from its premises, trivially, since its one premise is the
claim itself. This records the position. It does not argue for it. -/
theorem trentOnBaptism_establishes : Establishes trentOnBaptism := by
  granted [solaFideDefs]

/-- Trent's instrumental cause, as stated, can be held without contradiction. -/
theorem trentOnBaptism_is_satisfiable : Satisfiable trentOnBaptism.premises := by
  satisfied_by romeOnBaptismReading [solaFideDefs]

/-- **The first way of taking it is fair.** By itself, Trent taken Feeney's way
contradicts nothing, so it is not a position invented to be knocked down. -/
theorem trentOnTheWaterItself_is_satisfiable :
    Satisfiable trentOnTheWaterItself.premises := by
  satisfied_by feeneyReading [solaFideDefs]

/-- **The second is fair too.** Trent taken in its own words can be held without
contradiction. -/
theorem trentOnBaptismOrDesire_is_satisfiable :
    Satisfiable trentOnBaptismOrDesire.premises := by
  satisfied_by romeOnBaptismReading [solaFideDefs]

/-- **Grant that the thief was promised paradise unbaptised, and that his case bears
on the Gospel. It follows that the washing itself is not necessary for
salvation.** -/
@[headline]
theorem thiefCase_establishes : Establishes thiefCase := by
  establish [solaFideDefs]

#print axioms thiefCase_establishes

/-- The thief's case can be held without contradiction. -/
theorem thiefCase_is_satisfiable : Satisfiable thiefCase.premises := by
  satisfied_by romeOnBaptismReading [solaFideDefs]

/-- **Grant Rome's own teaching that the desire brings the fruits of baptism,
and the same follows.** -/
@[headline]
theorem desireCase_establishes : Establishes desireCase := by
  establish [solaFideDefs]

#print axioms desireCase_establishes

/-- The desire's case can be held without contradiction. -/
theorem desireCase_is_satisfiable : Satisfiable desireCase.premises := by
  satisfied_by romeOnBaptismReading [solaFideDefs]

/-- **The Reformed answer reaches its conclusion**, given its step: the sacrament is
not the instrument of justification. -/
@[headline]
theorem reformedOnTheDesire_establishes : Establishes reformedOnTheDesire := by
  establish [solaFideDefs]

#print axioms reformedOnTheDesire_establishes

/-- The Reformed answer can be held without contradiction. -/
theorem reformedOnTheDesire_is_satisfiable : Satisfiable reformedOnTheDesire.premises := by
  satisfied_by reformedOnBaptismReading [solaFideDefs]

/-- **The thief does not count against Trent taken in its own words.** Trent's
instrumental cause, as baptism or the desire for it, can be held with everything
the thief's case says: the thief had the desire, and the desire saves. -/
theorem the_thief_does_not_reach_the_desire :
    Satisfiable (thiefCase.premises ++ trentOnBaptismOrDesire.premises) := by
  satisfied_by romeOnBaptismReading [solaFideDefs]

/-! ### Where each fails -/

/-- **Why the thief stands against Feeney's reading.** Everything turns on the step
from the thief: he was promised paradise unbaptised, and his case bears on the
Gospel, so the washing itself is not necessary for salvation. What that
contradicts is Trent's claim taken Feeney's way, and nothing else. -/
def whereTheThiefMeetsFeeney : Because thiefCase trentOnTheWaterItself :=
  Because.ofChecks thiefToNotNecessary
    [p .luke23_43ThiefPromisedParadise, p .thiefBearsOnTheGospel] []
    [p .luke23_43ThiefPromisedParadise, p .thiefBearsOnTheGospel]
    [ p .baptismIsInstrumentalCause
    , p .baptismIsInstrumentalCause ➝ p .waterItselfNecessaryForSalvation ]
    .derives thiefCase_establishes thiefCase_is_satisfiable
    (by simp [thiefCase])
    (by simp [thiefCase])
    (by simp [solaFideDefs])
    (by decide +kernel)

/-- **Why Rome's own teaching stands against Feeney's reading.** Everything turns on
the step from what the desire brings: if the desire brings about the fruits of
baptism, the washing itself is not necessary for salvation. Feeney denies the
starting point. Whoever accepts it, as the Catechism does, cannot hold his
reading. -/
def whereTheDesireMeetsFeeney : Because desireCase trentOnTheWaterItself :=
  Because.ofChecks desireToNotNecessary
    [p .desireBringsFruitsWithoutTheSacrament] []
    [p .desireBringsFruitsWithoutTheSacrament]
    [ p .baptismIsInstrumentalCause
    , p .baptismIsInstrumentalCause ➝ p .waterItselfNecessaryForSalvation ]
    .derives desireCase_establishes desireCase_is_satisfiable
    (by simp [desireCase])
    (by simp [desireCase])
    (by simp [solaFideDefs])
    (by decide +kernel)

/-- **Why the Reformed answer stands against Trent taken in its own words.**
Everything turns on the step from the desire: where the desire alone brings the
fruits, what justifies is not the washing, so the washing is not the instrument.
What that contradicts is the instrumental cause itself. The step is rated
`disputed`: Aquinas accepts that the desire brings grace, and holds that it does
so as a desire for the sacrament, which then gives a fuller grace. -/
def whereTheDesireMeetsTrent : Because reformedOnTheDesire trentOnBaptismOrDesire :=
  Because.ofChecks desireToNotTheInstrument
    [p .baptismOrItsDesire, p .desireBringsFruitsWithoutTheSacrament] []
    [p .baptismOrItsDesire, p .desireBringsFruitsWithoutTheSacrament]
    [p .baptismIsInstrumentalCause]
    .derives reformedOnTheDesire_establishes reformedOnTheDesire_is_satisfiable
    (by simp [reformedOnTheDesire])
    (by simp [reformedOnTheDesire])
    (by simp [solaFideDefs, ArgumentPackage.readAs])
    (by decide +kernel)

/-- **What Trent's instrumental cause claims, taken both ways.**

*Taken so that the washing itself is necessary for salvation*, Feeney's reading,
it cannot be held with the thief as Augustine reads him, nor with Rome's own
teaching that the desire brings the fruits of baptism. Each fails at a step
rated `wellSupported`. Both answers are Catholic ones.

*Taken in Trent's own words*, baptism or the desire for it, the thief does not
count against it. It cannot be held with the Reformed answer, that where only
the desire is present what justifies is not the washing. But that step is
`disputed`, by Aquinas.

Each way of taking it is fair. By itself it contradicts nothing, so it is not a
position invented to be knocked down. It fails only when joined to what the
positions set against it hold. -/
def whatTrentsInstrumentalCauseClaims : Dilemma trentOnBaptism where
  claim := p .baptismIsInstrumentalCause
  horns :=
    [ { reading := asTheWaterItself
      , fair := trentOnTheWaterItself_is_satisfiable
      , fates :=
          [ .falls thiefCase whereTheThiefMeetsFeeney
          , .falls desireCase whereTheDesireMeetsFeeney ]
      , answered := by simp }
    , { reading := asBaptismOrItsDesire
      , fair := trentOnBaptismOrDesire_is_satisfiable
      , fates :=
          [ .unreached thiefCase thiefCase_establishes the_thief_does_not_reach_the_desire
          , .falls reformedOnTheDesire whereTheDesireMeetsTrent ]
      , answered := by simp } ]
  claim_mem := by simp [trentOnBaptism]
  two := by simp

/-! ### John 3:5 -/

/-- Trent's step from John 3:5: the verse requires water baptism. Rated `disputed`:
Calvin accepts the verse and denies the step. -/
@[solaFideDefs]
def johnThreeFiveToWater : Formula Claim :=
  p .john3_5WaterAndSpirit ➝ p .john3_5RequiresWaterBaptism

/-- **Trent on John 3:5**: born of water and the Spirit, so the verse requires
water baptism for entry into the kingdom. -/
@[solaFideDefs]
def trentOnJohnThreeFive : ArgumentPackage Claim :=
  { name := "Trent on John 3:5: born of water, so water baptism required"
  , cite := baseCite
  , premises := [p .john3_5WaterAndSpirit, johnThreeFiveToWater]
  , conclusion := p .john3_5RequiresWaterBaptism
  , conclusionLabel := "John 3:5 requires water baptism"
  , inferences := [calvinAgainstBaptismInJohnThreeFive] }

/-- Who reads the water of John 3:5 as baptismal water: Trent (Session VII, On
Baptism, canon 2), and "Chrysostom, with whom the greater part of expounders
agree", as Calvin reports. -/
def waterReadAsBaptism : Source :=
  { primary := .work waterworthTrent (.page 56)
  , supporting := [.work calvinJohn (.page 110)]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- Who reads it as natural birth: Oliver, who argues for it as his own reading. The
water "could be a reference to the amniotic fluid that surrounds the baby in the
womb". -/
def waterReadAsBirth : Source :=
  { primary := .work oliverWaterJohn .whole
  , tradition := .criticalScholarship
  , confidence := .disputed }

/-- Who reads it as the cleansing of Ezekiel 36: Carson, who finds there "a
transformative new beginning, characterized by spectacular cleansing symbolized
by water". -/
def waterReadAsEzekiel : Source :=
  { primary := .work carsonBornOfWater .whole
  , supporting := [.work oliverWaterJohn .whole]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- Who reads it as the Spirit's own cleansing: Calvin, "By 'water and the
Spirit,' therefore, I simply understand the Spirit, which is water"
(*Institutes* IV.xvi.25). -/
def waterReadAsTheSpirit : Source :=
  { primary := .work calvinInstitutes (.sectionRef "IV.xvi.25")
  , supporting := [.work calvinJohn (.pages 110 111)]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- The water of John 3:5, **read as baptismal water**. -/
@[solaFideDefs]
def waterAsBaptism : Reading Claim :=
  { name := "with its water as baptismal water"
  , commits := p .john3_5WaterIsBaptism, source := waterReadAsBaptism }

/-- The water of John 3:5, **read as natural birth**. -/
@[solaFideDefs]
def waterAsBirth : Reading Claim :=
  { name := "with its water as natural birth"
  , commits := p .john3_5WaterIsNaturalBirth, source := waterReadAsBirth }

/-- The water of John 3:5, **read as the cleansing of Ezekiel 36**. -/
@[solaFideDefs]
def waterAsEzekiel : Reading Claim :=
  { name := "with its water as Ezekiel's cleansing"
  , commits := p .john3_5WaterIsEzekielsCleansing, source := waterReadAsEzekiel }

/-- The water of John 3:5, **read as the Spirit's own cleansing**. -/
@[solaFideDefs]
def waterAsTheSpirit : Reading Claim :=
  { name := "with its water as the Spirit's own cleansing"
  , commits := p .john3_5WaterIsTheSpiritsCleansing, source := waterReadAsTheSpirit }

/-- If the water is natural birth, the verse does not require water baptism. -/
@[solaFideDefs]
def birthToNoWater : Formula Claim :=
  p .john3_5WaterIsNaturalBirth ➝ notP .john3_5RequiresWaterBaptism

/-- If the water is Ezekiel's cleansing and not baptism, the verse does not
require water baptism. -/
@[solaFideDefs]
def ezekielToNoWater : Formula Claim :=
  p .john3_5WaterIsEzekielsCleansing ➝ notP .john3_5RequiresWaterBaptism

/-- If the water is the Spirit's own cleansing, the verse does not require water
baptism. -/
@[solaFideDefs]
def spiritToNoWater : Formula Claim :=
  p .john3_5WaterIsTheSpiritsCleansing ➝ notP .john3_5RequiresWaterBaptism

/-- And if the water is the Spirit's own cleansing, it is not baptismal water. -/
@[solaFideDefs]
def spiritToNotBaptism : Formula Claim :=
  ⋀ [p .john3_5WaterAndSpirit, p .john3_5WaterIsTheSpiritsCleansing]
  ➝ notP .john3_5WaterIsBaptism

/-- **The natural-birth reading, as a position**: the water is natural birth, so
the verse does not require water baptism. -/
@[solaFideDefs]
def birthOnJohnThreeFive : ArgumentPackage Claim :=
  { name := "John 3:5, the water as natural birth (Oliver)"
  , cite := baseCite
  , premises := [p .john3_5WaterIsNaturalBirth, birthToNoWater]
  , conclusion := notP .john3_5RequiresWaterBaptism
  , conclusionLabel := "John 3:5 does not require water baptism"
  , inferences := [readingsWithoutTheWater] }

/-- **The Ezekiel reading, as a position.** -/
@[solaFideDefs]
def ezekielOnJohnThreeFive : ArgumentPackage Claim :=
  { name := "John 3:5, the water as Ezekiel's cleansing (Carson)"
  , cite := baseCite
  , premises := [p .john3_5WaterIsEzekielsCleansing, ezekielToNoWater]
  , conclusion := notP .john3_5RequiresWaterBaptism
  , conclusionLabel := "John 3:5 does not require water baptism"
  , inferences := [readingsWithoutTheWater] }

/-- **Calvin's reading, as a position**: water and Spirit are one, so the water
is not baptismal water, and the verse does not require water baptism. -/
@[solaFideDefs]
def calvinOnJohnThreeFive : ArgumentPackage Claim :=
  { name := "John 3:5, the water as the Spirit's own cleansing (Calvin)"
  , cite := baseCite
  , premises :=
      [ p .john3_5WaterAndSpirit, p .john3_5WaterIsTheSpiritsCleansing
      , spiritToNoWater, spiritToNotBaptism ]
  , conclusion := notP .john3_5RequiresWaterBaptism
  , conclusionLabel := "John 3:5 does not require water baptism"
  , inferences := [readingsWithoutTheWater] }

/-- A reading on which all three non-baptismal readings hold at once: the water is
natural birth, Ezekiel's cleansing and the Spirit's own cleansing, and not
baptism, and the verse does not require water baptism. Nobody holds this, since
the three readings are rivals. It is used only to show that each position's
premises can be true together. -/
def noWaterInJohnThreeFiveReading : Valuation Claim := fun a =>
  match a with
  | .john3_5RequiresWaterBaptism => False
  | .john3_5WaterIsBaptism => False
  | _ => True

/-- Grant the verse and Trent's step from it, and the requirement of water baptism
follows. The step is `disputed`. -/
theorem trentOnJohnThreeFive_establishes : Establishes trentOnJohnThreeFive := by
  establish [solaFideDefs]

/-- Trent on John 3:5 can be held without contradiction, on Rome's position. -/
theorem trentOnJohnThreeFive_is_satisfiable : Satisfiable trentOnJohnThreeFive.premises := by
  satisfied_by romeOnBaptismReading [solaFideDefs]

/-- The natural-birth reading reaches its conclusion. -/
theorem birthOnJohnThreeFive_establishes : Establishes birthOnJohnThreeFive := by
  establish [solaFideDefs]

/-- The natural-birth reading can be held without contradiction. -/
theorem birthOnJohnThreeFive_is_satisfiable :
    Satisfiable birthOnJohnThreeFive.premises := by
  satisfied_by noWaterInJohnThreeFiveReading [solaFideDefs]

/-- The Ezekiel reading reaches its conclusion. -/
theorem ezekielOnJohnThreeFive_establishes : Establishes ezekielOnJohnThreeFive := by
  establish [solaFideDefs]

/-- The Ezekiel reading can be held without contradiction. -/
theorem ezekielOnJohnThreeFive_is_satisfiable :
    Satisfiable ezekielOnJohnThreeFive.premises := by
  satisfied_by noWaterInJohnThreeFiveReading [solaFideDefs]

/-- Calvin's reading reaches its conclusion. -/
theorem calvinOnJohnThreeFive_establishes : Establishes calvinOnJohnThreeFive := by
  establish [solaFideDefs]

/-- Calvin's reading can be held without contradiction. -/
theorem calvinOnJohnThreeFive_is_satisfiable :
    Satisfiable calvinOnJohnThreeFive.premises := by
  satisfied_by reformedOnBaptismReading [solaFideDefs]

/-- Trent on John 3:5, with the water read as baptism. -/
@[solaFideDefs]
def trentWithBaptismalWater : ArgumentPackage Claim :=
  trentOnJohnThreeFive.readAs (p .john3_5WaterAndSpirit) waterAsBaptism

/-- Trent on John 3:5, with the water read as natural birth. -/
@[solaFideDefs]
def trentWithNaturalBirth : ArgumentPackage Claim :=
  trentOnJohnThreeFive.readAs (p .john3_5WaterAndSpirit) waterAsBirth

/-- Trent on John 3:5, with the water read as Ezekiel's cleansing. -/
@[solaFideDefs]
def trentWithEzekielsCleansing : ArgumentPackage Claim :=
  trentOnJohnThreeFive.readAs (p .john3_5WaterAndSpirit) waterAsEzekiel

/-- Trent on John 3:5, with the water read as the Spirit's own cleansing. -/
@[solaFideDefs]
def trentWithTheSpiritsCleansing : ArgumentPackage Claim :=
  trentOnJohnThreeFive.readAs (p .john3_5WaterAndSpirit) waterAsTheSpirit

/-- The verse read Trent's way and no other: its water is baptismal water, and not
natural birth, Ezekiel's cleansing or the Spirit's own cleansing. -/
def trentReadingOfJohnThreeFive : Valuation Claim := fun a =>
  match a with
  | .john3_5WaterIsNaturalBirth => False
  | .john3_5WaterIsEzekielsCleansing => False
  | .john3_5WaterIsTheSpiritsCleansing => False
  | _ => True

/-- The verse read with its water as natural birth, and Trent's step kept. By itself
this contradicts nothing. It fails only when that reading's own step is added:
then the verse does not require water baptism. -/
def trentWithBirthReading : Valuation Claim := fun a =>
  match a with
  | .john3_5WaterIsEzekielsCleansing => False
  | .john3_5WaterIsTheSpiritsCleansing => False
  | _ => True

/-- Trent's step, with the water read as Ezekiel's cleansing. -/
def trentWithEzekielReading : Valuation Claim := fun a =>
  match a with
  | .john3_5WaterIsNaturalBirth => False
  | .john3_5WaterIsTheSpiritsCleansing => False
  | _ => True

/-- Trent's step, with the water read as the Spirit's own cleansing. -/
def trentWithSpiritReading : Valuation Claim := fun a =>
  match a with
  | .john3_5WaterIsNaturalBirth => False
  | .john3_5WaterIsEzekielsCleansing => False
  | _ => True

/-- The baptismal reading of Trent's step can be held without contradiction. -/
theorem trentWithBaptismalWater_is_satisfiable :
    Satisfiable trentWithBaptismalWater.premises := by
  satisfied_by trentReadingOfJohnThreeFive [solaFideDefs]

/-- The natural-birth reading of Trent's step can be held without
contradiction. -/
theorem trentWithNaturalBirth_is_satisfiable :
    Satisfiable trentWithNaturalBirth.premises := by
  satisfied_by trentWithBirthReading [solaFideDefs]

/-- The Ezekiel reading of Trent's step can be held without contradiction. -/
theorem trentWithEzekielsCleansing_is_satisfiable :
    Satisfiable trentWithEzekielsCleansing.premises := by
  satisfied_by trentWithEzekielReading [solaFideDefs]

/-- The Spirit's-cleansing reading of Trent's step can be held without
contradiction. -/
theorem trentWithTheSpiritsCleansing_is_satisfiable :
    Satisfiable trentWithTheSpiritsCleansing.premises := by
  satisfied_by trentWithSpiritReading [solaFideDefs]

/-- **Why Calvin's reading stands against Trent with the water read as baptism.**
Everything turns on Calvin's step: if water and Spirit are one thing, the water
is not baptismal water. What that contradicts is the baptismal reading itself.
The step is `wellSupported`. But Calvin's reading, which it starts from, is
`disputed`, and Trent condemns it (Session VII, On Baptism, canon 2). -/
def whereCalvinMeetsTheBaptismalReading :
    Because calvinOnJohnThreeFive trentWithBaptismalWater :=
  Because.ofChecks spiritToNotBaptism
    [p .john3_5WaterAndSpirit, p .john3_5WaterIsTheSpiritsCleansing, spiritToNoWater] []
    [p .john3_5WaterAndSpirit, p .john3_5WaterIsTheSpiritsCleansing]
    [p .john3_5WaterAndSpirit ➝ p .john3_5WaterIsBaptism]
    .answers calvinOnJohnThreeFive_establishes calvinOnJohnThreeFive_is_satisfiable
    (by simp [calvinOnJohnThreeFive])
    (by simp [calvinOnJohnThreeFive])
    (by simp [solaFideDefs, ArgumentPackage.readAs])
    (by decide +kernel)

/-- **Why the natural-birth reading cannot keep Trent's step.** If the water is
natural birth, the verse does not require water baptism. So Trent's step from
the verse, with the verse read that way, fails, at a step rated `wellSupported`. -/
def whereBirthMeetsTrentsStep : Because birthOnJohnThreeFive trentWithNaturalBirth :=
  Because.ofChecks birthToNoWater [p .john3_5WaterIsNaturalBirth] [] []
    [ p .john3_5WaterAndSpirit, johnThreeFiveToWater
    , p .john3_5WaterAndSpirit ➝ p .john3_5WaterIsNaturalBirth ]
    .derives birthOnJohnThreeFive_establishes birthOnJohnThreeFive_is_satisfiable
    (by simp [birthOnJohnThreeFive])
    (by simp)
    (by simp [solaFideDefs, ArgumentPackage.readAs])
    (by decide +kernel)

/-- **Why the Ezekiel reading cannot keep Trent's step.** If the water is
Ezekiel's cleansing and not baptism, the verse does not require water baptism. -/
def whereEzekielMeetsTrentsStep :
    Because ezekielOnJohnThreeFive trentWithEzekielsCleansing :=
  Because.ofChecks ezekielToNoWater [p .john3_5WaterIsEzekielsCleansing] [] []
    [ p .john3_5WaterAndSpirit, johnThreeFiveToWater
    , p .john3_5WaterAndSpirit ➝ p .john3_5WaterIsEzekielsCleansing ]
    .derives ezekielOnJohnThreeFive_establishes ezekielOnJohnThreeFive_is_satisfiable
    (by simp [ezekielOnJohnThreeFive])
    (by simp)
    (by simp [solaFideDefs, ArgumentPackage.readAs])
    (by decide +kernel)

/-- **Why Calvin's reading cannot keep Trent's step.** If the water is the
Spirit's own cleansing, the verse does not require water baptism. -/
def whereTheSpiritMeetsTrentsStep :
    Because calvinOnJohnThreeFive trentWithTheSpiritsCleansing :=
  Because.ofChecks spiritToNoWater
    [p .john3_5WaterAndSpirit, p .john3_5WaterIsTheSpiritsCleansing] [spiritToNotBaptism] []
    [ p .john3_5WaterAndSpirit, johnThreeFiveToWater
    , p .john3_5WaterAndSpirit ➝ p .john3_5WaterIsTheSpiritsCleansing ]
    .derives calvinOnJohnThreeFive_establishes calvinOnJohnThreeFive_is_satisfiable
    (by simp [calvinOnJohnThreeFive])
    (by simp)
    (by simp [solaFideDefs, ArgumentPackage.readAs])
    (by decide +kernel)

/-- **What John 3:5 means, read four ways.** What can be taken more than one way is
the verse Trent cites, not Trent. Trent argues: unless one is born of water and
the Spirit, he cannot enter the kingdom of God; therefore water baptism is
required. Each of the four readings is a reading of the verse's "water", held by
the reader named. For each, the question is whether Trent's step from the verse
still stands once the verse is read that way.

Read with its water as baptismal water, Trent's step stands. That reading cannot
be held with Calvin's, at a `wellSupported` step from Calvin's reading, which is
itself `disputed`. Even so, Trent's step stays `disputed`.

Read with its water as natural birth, as Ezekiel's cleansing, or as the Spirit's
own cleansing, Trent's step cannot be kept, each time at a `wellSupported` step.

So only the baptismal reading leaves Trent's step standing. Which reading is
right is not decided here: each is cited, and each is disputed. Each is fair. By
itself it contradicts nothing, and it fails only when joined to the step its own
holders draw from it. -/
def whatJohnThreeFiveMeans : Dilemma trentOnJohnThreeFive where
  claim := p .john3_5WaterAndSpirit
  horns :=
    [ { reading := waterAsBaptism
      , fair := trentWithBaptismalWater_is_satisfiable
      , fates := [.falls calvinOnJohnThreeFive whereCalvinMeetsTheBaptismalReading]
      , answered := by simp }
    , { reading := waterAsBirth
      , fair := trentWithNaturalBirth_is_satisfiable
      , fates := [.falls birthOnJohnThreeFive whereBirthMeetsTrentsStep]
      , answered := by simp }
    , { reading := waterAsEzekiel
      , fair := trentWithEzekielsCleansing_is_satisfiable
      , fates := [.falls ezekielOnJohnThreeFive whereEzekielMeetsTrentsStep]
      , answered := by simp }
    , { reading := waterAsTheSpirit
      , fair := trentWithTheSpiritsCleansing_is_satisfiable
      , fates := [.falls calvinOnJohnThreeFive whereTheSpiritMeetsTrentsStep]
      , answered := by simp } ]
  claim_mem := by simp [trentOnJohnThreeFive]
  two := by simp

/-! ### Acts, both orders -/

/-- From Samaria and Caesarea: the Spirit comes after the water and before it, so
God is not bound to water baptism. Rated `consensus`: Calvin and the Catechism
both accept that much, though Calvin's own sentence goes further. -/
@[solaFideDefs]
def actsToUnbound : Formula Claim :=
  ⋀ [p .acts8WaterThenSpirit, p .acts10SpiritThenWater] ➝ p .godNotBoundToWater

/-- **Acts, both orders**: the Spirit given after the water in Samaria and before
it at Caesarea, so God is not bound to water baptism. -/
@[solaFideDefs]
def actsCase : ArgumentPackage Claim :=
  { name := "Acts 8 and 10: the Spirit after the water, and before it"
  , cite := baseCite
  , premises := [p .acts8WaterThenSpirit, p .acts10SpiritThenWater, actsToUnbound]
  , conclusion := p .godNotBoundToWater
  , conclusionLabel := "God is not bound to water baptism"
  , inferences := [calvinOnActsTen] }

/-- **Grant the two orders in Acts, and it follows that God is not bound to water.** -/
@[headline]
theorem actsCase_establishes : Establishes actsCase := by
  establish [solaFideDefs]

#print axioms actsCase_establishes

/-- Acts' case can be held without contradiction. -/
theorem actsCase_is_satisfiable : Satisfiable actsCase.premises := by
  satisfied_by romeOnBaptismReading [solaFideDefs]

/-- **Trent's instrumental cause is consistent with God not being bound to it.**
Rome holds both: "God has bound salvation to the sacrament of Baptism, but he
himself is not bound by his sacraments" (Catechism 1257). So what Acts shows is
accepted on both sides, and is not a point won by the Reformed. What remains in
dispute is the first half of that sentence, that God has bound salvation to the
sacrament, and Trent's further claim that the sacrament is the instrument of
justification. -/
@[headline]
theorem trent_grants_god_is_not_bound : Grants trentOnBaptism (p .godNotBoundToWater) := by
  satisfied_by romeOnBaptismReading [Grants, solaFideDefs]

#print axioms trent_grants_god_is_not_bound

/-! ### "And fire": three readings, and none chosen -/

/-- A reading on which the fire is judgement, and neither of the other readings
holds. This is enough to show that the verse does not require them. Many readers
take the fire as both judging and purifying; nothing here says the readings
exclude each other. -/
def fireAsJudgmentReading : Valuation Claim := fun a =>
  match a with
  | .fireIsPurification => False
  | .fireIsPentecost => False
  | _ => True

/-- A reading on which the fire is purification, and neither of the other readings
holds. This is enough to show that the verse does not require them. -/
def fireAsPurificationReading : Valuation Claim := fun a =>
  match a with
  | .fireIsJudgment => False
  | .fireIsPentecost => False
  | _ => True

/-- **John the Baptist's words leave open whether the fire is judgement.** "He will
baptize you with the Holy Spirit and fire" is kept alike by Gregory Nazianzen,
who reads the fire as the burning of the chaff, and by Calvin, who reads it as
the Spirit's purifying. The text does not settle it either way. -/
@[headline]
theorem the_baptist_leaves_the_fire_open :
    Independent [p Claim.matthew3_11SpiritAndFire] (p .fireIsJudgment) := by
  leaves_open fireAsPurificationReading fireAsJudgmentReading [solaFideDefs]

#print axioms the_baptist_leaves_the_fire_open

/-- **Nor whether it is purification.** -/
@[headline]
theorem the_baptist_leaves_purification_open :
    Independent [p Claim.matthew3_11SpiritAndFire] (p .fireIsPurification) := by
  leaves_open fireAsJudgmentReading fireAsPurificationReading [solaFideDefs]

#print axioms the_baptist_leaves_purification_open

/-- **Nor whether it is Pentecost**, as Cyril of Jerusalem reads it: "because the
descent of the Holy Ghost was in fiery tongues". -/
@[headline]
theorem the_baptist_leaves_pentecost_open :
    Independent [p Claim.matthew3_11SpiritAndFire] (p .fireIsPentecost) := by
  leaves_open fireAsJudgmentReading everythingHoldsReading [solaFideDefs]

#print axioms the_baptist_leaves_pentecost_open

end TestimonyArguments.SolaFide
