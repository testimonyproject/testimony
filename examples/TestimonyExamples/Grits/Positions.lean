import TestimonyExamples.Grits.Sources
import Testimony.Logic.Tactic

/-!
# TestimonyExamples.Grits.Positions — the testimony, and the cross-examination

Two positions, each from the record. Tipton's, on direct examination: the boys
went in as he began breakfast, the shot came as it was ready, and breakfast
took five minutes, so five minutes passed. Counsel's, on cross-examination: the
same reckoning, with the grits. Breakfast was eggs and grits, the grits were
regular, regular grits take twenty minutes, so breakfast took twenty, and so
did the time from the boys' going in to the shot.

The cross-examination's case is built on Tipton's own reckoning. It contests one
premise, what the breakfast took, and keeps the step.
-/

namespace TestimonyExamples.Grits

open Testimony Testimony.Logic

/-! ### Tipton, on direct examination -/

/-- **Tipton's reckoning**: the boys went in as breakfast began, the shot came
as it was ready, and breakfast took five minutes; so five minutes passed between
them. The step is rated `consensus`: counsel grants it, and contests the
breakfast. -/
@[gritsDefs]
def tiptonsReckoning : Line Claim :=
  { name := "Tipton, on direct examination"
  , grounds :=
      [ p .enteredAsBreakfastBegan, p .shotAsBreakfastWasReady, p .breakfastTookFiveMinutes ]
  , step :=
      ⋀ [ p .enteredAsBreakfastBegan, p .shotAsBreakfastWasReady
        , p .breakfastTookFiveMinutes ] ➝ p .fiveMinutesPassed
  , delivers := p .fiveMinutesPassed
  , inference := some onTheReckoning }

/-- **Tipton's testimony**, as a position: his reckoning, and nothing else. He did
not look at his watch — "Are you sure, did you look at your watch?" "No." — so
nothing but the breakfast carries the five minutes. -/
@[gritsDefs]
def direct : ArgumentPackage Claim :=
  tiptonsReckoning.asPackage cite "five minutes passed between the boys' going in and the shot"

/-! ### Counsel, on cross-examination -/

/-- From eggs and grits, regular grits, and twenty minutes for regular grits, to
a breakfast that took twenty minutes. Rated `wellSupported`: Tipton denied it
for a moment ("I'm a fast cook I guess") and withdrew. -/
@[gritsDefs]
def theGrits : Formula Claim :=
  ⋀ [ p .breakfastWasEggsAndGrits, p .gritsWereRegular, p .regularGritsTakeTwentyMinutes ]
  ➝ p .breakfastTookTwentyMinutes

/-- Tipton's own reckoning, with the grits' twenty minutes in place of his five.
Rated `consensus`, as his is. -/
@[gritsDefs]
def theReckoningTurned : Formula Claim :=
  ⋀ [ p .enteredAsBreakfastBegan, p .shotAsBreakfastWasReady
    , p .breakfastTookTwentyMinutes ] ➝ p .twentyMinutesPassed

/-- **The cross-examination**, as a position: what Tipton granted — when the
boys went in, when the shot came, what he cooked, that his grits were regular —
with counsel's claim that regular grits take twenty minutes, carried through
his own reckoning to twenty minutes.

Its conclusion says more than the court found. The court found that five
minutes could not be right; how long it was, it did not say, and the conclusion
is rated `plausible` accordingly. What the cross-examination needed was the
contradiction, and that is in what Tipton held
(`tiptons_five_minutes_cannot_stand_with_the_grits`). -/
@[gritsDefs]
def cross : ArgumentPackage Claim :=
  { name := "Counsel, on cross-examination"
  , cite := cite
  , premises :=
      [ p .enteredAsBreakfastBegan, p .shotAsBreakfastWasReady, p .breakfastWasEggsAndGrits
      , p .gritsWereRegular, p .regularGritsTakeTwentyMinutes, theGrits, theReckoningTurned ]
  , conclusion := p .twentyMinutesPassed
  , conclusionLabel := "twenty minutes passed: as long as the grits take"
  , inferences := [onTheGrits, onTheReckoning] }

/-- **The cross-examination as it stood when Tipton said he was a fast cook**:
the same premises, with the step from the grits rated as it was then,
`disputed`. A named difference of one rating, not a second position. -/
@[gritsDefs]
def crossAtTheFastCook : ArgumentPackage Claim :=
  { cross with
    name := "Counsel, when Tipton said he was a fast cook"
    inferences := [atTheFastCook, onTheReckoning] }

/-! ### Readings, written down -/

/-- Tipton's world: the boys went in as he began breakfast, the shot came as it
was ready, his breakfast of eggs and regular grits took five minutes, and five
minutes passed. Regular grits do not take twenty minutes — or not his: he is a
fast cook. -/
def tiptonsWorld : Valuation Claim := fun a =>
  match a with
  | .regularGritsTakeTwentyMinutes => False
  | .breakfastTookTwentyMinutes => False
  | .twentyMinutesPassed => False
  | _ => True

/-- The cross-examination's world: everything Tipton granted, regular grits
taking twenty minutes, a breakfast of twenty minutes, and twenty minutes
passed — not five. -/
def crossWorld : Valuation Claim := fun a =>
  match a with
  | .breakfastTookFiveMinutes => False
  | .fiveMinutesPassed => False
  | _ => True

/-- Everything both positions say, held at once: a breakfast of five minutes and
of twenty, five minutes passed and twenty. As claims with nothing to say what
they mean, nothing stops it; read for what "lasts" means, nothing allows it. -/
def bothAtOnce : Valuation Claim := fun _ => True

/-! ### Each position holds -/

/-- **Grant Tipton's reckoning, and five minutes passed.** -/
@[headline]
theorem direct_establishes : Establishes direct := by
  establish [gritsDefs]

#print axioms direct_establishes

/-- Tipton's testimony can be held without contradiction. -/
theorem direct_is_satisfiable : Satisfiable direct.premises := by
  satisfied_by tiptonsWorld [gritsDefs]

/-- **Grant what Tipton granted, and that regular grits take twenty minutes, and
twenty minutes passed.** -/
@[headline]
theorem cross_establishes : Establishes cross := by
  establish [gritsDefs]

#print axioms cross_establishes

/-- The cross-examination's case can be held without contradiction. -/
theorem cross_is_satisfiable : Satisfiable cross.premises := by
  satisfied_by crossWorld [gritsDefs]

/-- The cross-examination at the fast cook delivers its conclusion: the premises
are the same, and only a rating differs. -/
theorem crossAtTheFastCook_establishes : Establishes crossAtTheFastCook := by
  establish [gritsDefs]

/-- The cross-examination at the fast cook can be held without contradiction. -/
theorem crossAtTheFastCook_is_satisfiable : Satisfiable crossAtTheFastCook.premises := by
  satisfied_by crossWorld [gritsDefs]

/-! ### Where the five minutes rests -/

/-- **The five minutes rests on the breakfast.** Take away what the breakfast
took, and Tipton's reckoning delivers nothing: when the boys went in and when
the shot came, with the step, do not give five minutes. He did not look at his
watch, so nothing else carries it. That is why the cross-examination goes to the
breakfast, and why it is enough to go there. -/
@[headline]
theorem the_five_minutes_rests_on_the_breakfast :
    ¬ Establishes ((tiptonsReckoning.onGrounds
      [p .enteredAsBreakfastBegan, p .shotAsBreakfastWasReady]).asPackage cite
      "five minutes passed between the boys' going in and the shot") := by
  refute_with crossWorld [gritsDefs]

#print axioms the_five_minutes_rests_on_the_breakfast

end TestimonyExamples.Grits
