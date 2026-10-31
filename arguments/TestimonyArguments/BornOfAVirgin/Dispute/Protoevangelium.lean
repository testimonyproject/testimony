import TestimonyArguments.BornOfAVirgin.Dispute.Genesis
import Testimony.Logic.Dispute
import Testimony.Logic.Horn
import Testimony.Logic.Solver
import Testimony.Logic.Verdict
import Testimony.Logic.Certificate

/-!
# TestimonyArguments.BornOfAVirgin.Dispute.Protoevangelium — the promise, and its fulfilment

`Dispute.Genesis` asks what the wording of Genesis 3:15 says of a father. This
module asks the question a reader of the whole Bible asks next. In the garden God
tells the serpent that the woman's seed will crush its head, and that it will
strike his heel. The Gospel tells of one born of a woman, struck in his death,
who destroyed the devil through it. **Is the promise fulfilled in him, and does
the fulfilment confirm that it was a promise?**

## The terms of the promise, and where Scripture says they are met

| Genesis 3:15 | Where the New Testament names it |
|---|---|
| The woman's seed | The Son "made of a woman" (Galatians 4:4) |
| The serpent | "that old serpent, called the Devil, and Satan" (Revelation 12:9; 20:2) |
| His head crushed | "that through death he might destroy … the devil" (Hebrews 2:14; 1 John 3:8) |
| His heel struck | He died, and rose the third day (1 Corinthians 15:3–4) |

Romans 16:20, "the God of peace shall bruise Satan under your feet shortly", is
left out: it is an allusion, and a disputed one (`fulfilmentLine` gives both
sides).

## Four positions

- **The fulfilment, confirming the promise** (`fulfilmentCase`). From the terms
  met (`fulfilmentLine`): in Jesus the promise is fulfilled. From the fulfilment
  (`confirmationLine`): the verse was a promise of him, the protoevangelium. Its
  grounds are Scripture alone.
- **Westermann's denial** (`westermannCase`), encoded first: "her seed" is a
  line of descendants, and the verse is a punishment oracle on the serpent, a
  form that cannot carry "promise or prophecy as its primary or even as its
  secondary meaning" (*Genesis 1–11*, 259–60).
- **The syntax of the striker** (`syntaxCase`), against Westermann's first
  ground: elsewhere זֶרַע with singular verbs and pronouns names one descendant,
  at 3:15b it is "he" who strikes the serpent's own head, and the Greek
  translator read one person; so "her seed" is not only a line of descendants
  (Collins, Alexander, Leupold, Hamilton).
- **The scene read whole** (`sceneCase`): the serpent speaks and twists God's
  command, as no animal does of itself; it is the instrument of an evil power;
  the blow falls on the serpent itself; and God sets the enmity. So the sentence
  on the serpent is a promise of victory over that power (Collins, Woudstra,
  Keil).

## What the confirmation shows, and what it does not

The fulfilment confirms the promise; it does not prove it from Genesis alone.
"If the verse promised the Messiah, he would crush the serpent and be struck;
Jesus did; so it promised him" would affirm the consequent. What the library
encodes is a step of its own, rated: a promise whose every term is met in one
person, as Scripture names them, is a promise of that person. It holds for a
reader who denies the virginal conception
(`the_confirmation_does_not_need_the_virgin_birth`).

Joined with the virginal conception, the fulfilment says one thing more: the
seed in whom the promise is fulfilled was of the woman alone
(`seed_of_the_woman_alone`). That reads the birth back into the promise. It does
not show that the wording foretold it, which is Luther's claim and is weighed in
`Dispute.Genesis` (`the_fulfilment_does_not_reach_the_wording`).

## How the ratings stand, and what the solver computes

- **The fulfilment's step** is `disputed`, on Westermann. He grants what every
  ground reads and denies the conclusion, "even as its secondary meaning", from
  philology and form criticism, not from a reading of the New Testament texts.
- **The confirmation's step** is `plausible`: no reader found grants the
  fulfilment and denies the promise.
- **Westermann's step** is `disputed`, on Calvin, who grants that the seed is
  the woman's posterity and the verse a curse on the serpent, and finds the
  promise in the curse; and Keil with him.
- **Westermann's first ground**, "a line of descendants and not an individual",
  is `disputed` too, on Collins, Leupold, Alexander and Hamilton.
- **The scene's step** is `plausible`: Woudstra grants every ground and holds
  that "the term 'protevangelium' may be rightly used". Its ground that the
  serpent is the instrument of an evil power is `disputed`, on Westermann.
- **The syntax's step** is `disputed`, on Keil, who grants that the word can
  name one son and that the victory is over the serpent itself, and denies "one
  individual only". Collins himself claims no more than that the syntax is
  "quite consistent with" one person.

Each position is only as strong as its weakest link, and each rests on a step
rated `disputed`. Westermann and the fulfilment defeat each other, and so do
Westermann and the scene; Westermann and the syntax defeat each other, the syntax
by denying his ground; the fulfilment, the syntax and the scene stand together.
So **nothing prevails** (`nothing_prevails_over_the_promise`). The fulfilment
with the syntax and the scene can be defended (`fulfilment_is_one_resolution`),
and so can Westermann (`westermann_is_the_other_resolution`); neither is
forced.

That is the verdict as the evidence weighs it. Whether Westermann's dissent
should be heard against a step whose grounds are all Scripture is a question of
standard, not of evidence; `Dispute.PromiseHearing` hears the dispute under each
standard, and reports each.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### Readings -/

/-- Westermann's reading: "her seed" is the woman's posterity, the verse is the
serpent's sentence and no promise, and so no one fulfils it. On the joined
pairs elsewhere in the argument it takes the scriptural reading's side, as the
readings of `Results.Genesis` do; none bears on what it is used for. -/
def westermannReading : Valuation Claim := fun a =>
  match a with
  | .genesis3_15IsProtoevangelium => False
  | .jesusFulfilsThePromise => False
  | .seedWasOfTheWomanAlone => False
  | .wordingSignifiesAFatherlessBirth => False
  | .serpentIsTheInstrumentOfAPower => False
  | .parthenosMeantYoungWoman => False
  | .parthenosDoesNotItselfConnoteVirginity => False
  | .parthenosDescribesDinahAsSheThenWas => False
  | .maternalSilenceProvesNothing => False
  | .magisteriumIsDoctrinallyAuthoritative => False
  | _ => True

/-- A reading no cited reader holds, written down to show what the scene's step
adds: the serpent twists the command, an evil power stands behind it, the blow
falls on the serpent itself and God sets the enmity — and still the verse is no
promise, and no one fulfils it. It is a model of the scene's grounds without its
step. -/
def curseWithoutPromiseReading : Valuation Claim := fun a =>
  match a with
  | .genesis3_15IsProtoevangelium => False
  | .jesusFulfilsThePromise => False
  | .seedWasOfTheWomanAlone => False
  | .wordingSignifiesAFatherlessBirth => False
  | .parthenosMeantYoungWoman => False
  | .parthenosDoesNotItselfConnoteVirginity => False
  | .parthenosDescribesDinahAsSheThenWas => False
  | .maternalSilenceProvesNothing => False
  | .magisteriumIsDoctrinallyAuthoritative => False
  | _ => True

/-- Calvin's reading: "her seed" is "the posterity of the woman generally", and
not one man; the verse is the serpent's sentence; and the promise is in it all
the same, for "we must necessarily come to one head" (170–71). On the other
joined pairs it takes the scriptural reading's side. -/
def calvinReading : Valuation Claim := fun a =>
  match a with
  | .wordingSignifiesAFatherlessBirth => False
  | .parthenosMeantYoungWoman => False
  | .parthenosDoesNotItselfConnoteVirginity => False
  | .parthenosDescribesDinahAsSheThenWas => False
  | .maternalSilenceProvesNothing => False
  | .magisteriumIsDoctrinallyAuthoritative => False
  | _ => True

/-! ### The fulfilment, the confirmation, and the seed of the woman alone -/

/-- **The fulfilment confirms the promise.** Grant what the five texts read, the
fulfilment's step and the confirmation's: Genesis 3:15 is the protoevangelium. -/
theorem fulfilmentCase_establishes : Establishes fulfilmentCase := by
  establish [bornOfAVirginDefs]

/-- The fulfilment's premises can all be true together, on Luther's reading,
which grants every term met, the promise fulfilled and confirmed. -/
theorem fulfilmentCase_is_satisfiable : Satisfiable fulfilmentCase.premises := by
  satisfied_by lutherReading [bornOfAVirginDefs]

/-- **The fulfilment rests on its step.** Grant everything the five texts say: on
Westermann's reading the verse still promises no one, and so no one fulfils it.
The texts do not settle it; the step does, and that is why it is rated
`disputed`. -/
@[headline]
theorem the_fulfilment_rests_on_its_step :
    ¬ Entails fulfilmentLine.grounds (p .jesusFulfilsThePromise) := by
  refute_with westermannReading [bornOfAVirginDefs]

#print axioms the_fulfilment_rests_on_its_step

/-- **The confirmation does not need the virgin birth.** The promise follows from
the fulfilment even for a reader who denies the virginal conception: none of the
fulfilment's grounds is the birth, and none of its steps uses it. -/
@[headline]
theorem the_confirmation_does_not_need_the_virgin_birth :
    Entails (fulfilmentCase.premises ++ [notP .maryConceivedAsVirgin])
      (p .genesis3_15IsProtoevangelium) := by
  establish [bornOfAVirginDefs]

#print axioms the_confirmation_does_not_need_the_virgin_birth

/-- **The seed of the woman alone.** Grant the fulfilment and the virginal
conception: the seed in whom Genesis 3:15 is fulfilled had no human father. -/
@[headline]
theorem seed_of_the_woman_alone : Establishes aloneCase := by
  establish [bornOfAVirginDefs]

#print axioms seed_of_the_woman_alone

/-- The premises of the seed of the woman alone can all be true together, on
Luther's reading. -/
theorem aloneCase_is_satisfiable : Satisfiable aloneCase.premises := by
  satisfied_by lutherReading [bornOfAVirginDefs]

/-- **The fulfilment does not reach the wording.** Grant the fulfilment, the
confirmation, the virginal conception and the seed of the woman alone: the
wording of Genesis 3:15 may still not itself signify a birth with no human
father, as Leupold reads it. Reading the birth back into the promise is not
finding it in the words; Luther's claim stands or falls in `Dispute.Genesis`. -/
@[headline]
theorem the_fulfilment_does_not_reach_the_wording :
    ¬ Entails (fulfilmentCase.premises ++ aloneCase.premises)
      (p .wordingSignifiesAFatherlessBirth) := by
  refute_with leupoldReading [bornOfAVirginDefs]

#print axioms the_fulfilment_does_not_reach_the_wording

/-! ### Westermann's denial -/

/-- Westermann's denial delivers its conclusion. -/
theorem westermannCase_establishes : Establishes westermannCase := by
  establish [bornOfAVirginDefs]

/-- Westermann's premises can all be true together: his own reading. -/
theorem westermannCase_is_satisfiable : Satisfiable westermannCase.premises := by
  satisfied_by westermannReading [bornOfAVirginDefs]

/-- **Westermann's denial rests on its step.** Grant that "her seed" is a line of
descendants and not one man, and that the verse is a curse on the serpent: on
Calvin's reading the verse is a promise all the same. -/
@[headline]
theorem westermann_rests_on_his_step :
    ¬ Entails westermannLine.grounds (notP .genesis3_15IsProtoevangelium) := by
  refute_with calvinReading [bornOfAVirginDefs]

#print axioms westermann_rests_on_his_step

/-! ### The syntax of the striker -/

/-- The syntax's case delivers its conclusion. -/
theorem syntaxCase_establishes : Establishes syntaxCase := by
  establish [bornOfAVirginDefs]

/-- The syntax's premises can all be true together, on Leupold's reading. -/
theorem syntaxCase_is_satisfiable : Satisfiable syntaxCase.premises := by
  satisfied_by leupoldReading [bornOfAVirginDefs]

/-- **The syntax rests on its step.** Grant that זֶרַע names one descendant
elsewhere with singular forms, that the striker at 3:15b is singular "he", and
that the Greek translator read one person: on Calvin's reading "her seed" is
still the woman's posterity, and not one man. -/
@[headline]
theorem syntax_rests_on_its_step :
    ¬ Entails syntaxLine.grounds (notP .seedIsLineNotIndividual) := by
  refute_with calvinReading [bornOfAVirginDefs]

#print axioms syntax_rests_on_its_step

/-! ### The scene read whole -/

/-- The scene's case delivers its conclusion. -/
theorem sceneCase_establishes : Establishes sceneCase := by
  establish [bornOfAVirginDefs]

/-- The scene's premises can all be true together, on Luther's reading. -/
theorem sceneCase_is_satisfiable : Satisfiable sceneCase.premises := by
  satisfied_by lutherReading [bornOfAVirginDefs]

/-- **The scene rests on its step.** Grant that the serpent twists the command,
that an evil power stands behind it, that the blow falls on the serpent itself,
and that God sets the enmity: the verse may still be a sentence and no promise.
The section's words do not force it; reading a promise out of the curse does,
and that is the step rated `plausible`. -/
@[headline]
theorem scene_rests_on_its_step :
    ¬ Entails sceneLine.grounds (p .genesis3_15IsProtoevangelium) := by
  refute_with curseWithoutPromiseReading [bornOfAVirginDefs]

#print axioms scene_rests_on_its_step

/-! ### Strength -/

/-- The fulfilment's grounds are `consensus`, what the texts read; its
confirmation is `plausible`; its fulfilment step is `disputed`, on Westermann. -/
theorem fulfilmentCase_strength : fulfilmentCase.strength = 0 := by decide

/-- Westermann's ground that "her seed" is a line of descendants and not an
individual is `disputed`, and so is his step, on Calvin. -/
theorem westermannCase_strength : westermannCase.strength = 0 := by decide

/-- The syntax's grounds are `consensus` and `wellSupported`, but its step is
`disputed`, on Keil. -/
theorem syntaxCase_strength : syntaxCase.strength = 0 := by decide

/-- The scene's step is `plausible`, but its ground that the serpent is the
instrument of an evil power is `disputed`, on Westermann. -/
theorem sceneCase_strength : sceneCase.strength = 0 := by decide

/-! ### The defeats -/

/-- **Westermann defeats the fulfilment.** His conclusion denies the
fulfilment's, and the fulfilment is no stronger than he. -/
theorem westermann_defeats_fulfilment : Defeats westermannCase fulfilmentCase :=
  Horn.defeats_of_certified westermannCase_strength fulfilmentCase_strength (by horn_certify)

/-- **The fulfilment defeats Westermann.** Its conclusion denies his, and he is
no stronger than it. -/
theorem fulfilment_defeats_westermann : Defeats fulfilmentCase westermannCase :=
  Horn.defeats_of_certified fulfilmentCase_strength westermannCase_strength (by horn_certify)

/-! ### The dispute -/

/-- The parties to the dispute over whether Genesis 3:15 is a promise. -/
inductive PromiseParty
  /-- The fulfilment, confirming the promise. -/
  | fulfilment
  /-- Westermann: a punishment oracle, and no promise. -/
  | westermann
  /-- The syntax of the striker: "her seed" is not only a line of
  descendants. -/
  | syntax
  /-- The scene read whole: God's sentence on the serpent's power. -/
  | scene
deriving DecidableEq

/-- The package each party argues from. -/
@[bornOfAVirginDefs]
def promisePartyNode : PromiseParty → ArgumentPackage Claim
  | .fulfilment => fulfilmentCase
  | .westermann => westermannCase
  | .syntax => syntaxCase
  | .scene => sceneCase

/-- The dispute over whether Genesis 3:15 is a promise: every party's premises
have a model, every party establishes its conclusion, and every party's
inferences are rated. -/
@[bornOfAVirginDefs]
def promiseDispute : Dispute Claim PromiseParty where
  node := promisePartyNode
  consistent i := Horn.satisfiable_of_satisfiable? (by cases i <;> decide +kernel)
  sound
    | .fulfilment => fulfilmentCase_establishes
    | .westermann => westermannCase_establishes
    | .syntax => syntaxCase_establishes
    | .scene => sceneCase_establishes
  rated i := by
    cases i <;> simp [bornOfAVirginDefs, Line.asPackage]

/-- The defeats of the dispute, as a table: Westermann and each of the others
defeat each other. -/
def promisePartyDefeats : PromiseParty → PromiseParty → Prop
  | .fulfilment, .westermann => True
  | .westermann, .fulfilment => True
  | .syntax, .westermann => True
  | .westermann, .syntax => True
  | .scene, .westermann => True
  | .westermann, .scene => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel promisePartyDefeats := fun i j => by
  cases i <;> cases j <;> unfold promisePartyDefeats <;> infer_instance

/-- Every party's weakest link ranks at the bottom. -/
theorem promisePartyNode_strength : ∀ i, (promisePartyNode i).strength = 0
  | .fulfilment => fulfilmentCase_strength
  | .westermann => westermannCase_strength
  | .syntax => syntaxCase_strength
  | .scene => sceneCase_strength

/-- **Who defeats whom**, all sixteen pairs: Westermann defeats the fulfilment,
the syntax and the scene, and each defeats him back; and nothing else. Every cell is computed
from what the parties hold by `Horn.defeats?` and checked by the kernel. -/
theorem promiseDispute_defeats :
    ∀ i j, promiseDispute.defeats i j ↔ promisePartyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_certified (promisePartyNode_strength i)
    (promisePartyNode_strength j) ?_
  cases i <;> cases j <;> horn_certify

/-- The dispute in the form the verdict solver computes with. -/
def promiseFinite : Solver.Finite promiseDispute.defeats where
  parties := [.fulfilment, .westermann, .syntax, .scene]
  complete i := by cases i <;> decide
  defeats i j := decide (promisePartyDefeats i j)
  spec i j := by rw [promiseDispute_defeats]; simp

/-- Why nothing prevails: every party has a defeater. -/
def promiseStandoff : Verdict promiseDispute where
  finite := promiseFinite
  claim := .nothingGrounded
    [ (.fulfilment, .westermann), (.westermann, .fulfilment), (.syntax, .westermann)
    , (.scene, .westermann) ]
  checked := by decide +kernel

/-- **As the evidence weighs it, nothing prevails**: Westermann defeats the
fulfilment, the syntax and the scene, each defeats him back, and none outranks
another. -/
@[headline]
theorem nothing_prevails_over_the_promise : grounded promiseDispute.defeats = ∅ :=
  promiseStandoff.holds

#print axioms nothing_prevails_over_the_promise

/-- Why the fulfilment with the syntax and the scene is one resolution. -/
def fulfilmentAlone : Verdict promiseDispute where
  finite := promiseFinite
  claim := .preferred [.fulfilment, .syntax, .scene]
  checked := by decide +kernel

/-- **The fulfilment can be defended, with the syntax and the scene**: none of
the three attacks another, and each answers Westermann, the only party that
attacks any of them. -/
@[headline]
theorem fulfilment_is_one_resolution :
    Preferred promiseDispute.defeats {.fulfilment, .syntax, .scene} :=
  (show Solver.toSet [PromiseParty.fulfilment, .syntax, .scene] =
      {.fulfilment, .syntax, .scene} by ext; simp) ▸
    fulfilmentAlone.holds

#print axioms fulfilment_is_one_resolution

/-- Why Westermann is the other resolution. -/
def westermannAlone : Verdict promiseDispute where
  finite := promiseFinite
  claim := .preferred [.westermann]
  checked := by decide +kernel

/-- **So can Westermann**, as the evidence weighs it. -/
@[headline]
theorem westermann_is_the_other_resolution : Preferred promiseDispute.defeats {.westermann} :=
  (show Solver.toSet [PromiseParty.westermann] = {.westermann} by ext; simp) ▸
    westermannAlone.holds

#print axioms westermann_is_the_other_resolution

end TestimonyArguments.BornOfAVirgin
