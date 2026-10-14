import TestimonyExamples.Attr
import Testimony.Logic.Line

/-!
# TestimonyExamples.Grits.Atoms — the atomic claims

What Sam Tipton testified, what he answered on cross-examination, what counsel
put to him, and what each side concludes. The witness's own answers are kept
apart from counsel's claim about grits, so that a reader can see which premises
the witness granted and which the cross-examination brought.
-/

namespace TestimonyExamples.Grits

/-- The atomic claims this case is built from. -/
inductive Claim
  /-- Tipton saw the boys go into the store as he began making breakfast: "you
  had just begun to make breakfast". -/
  | enteredAsBreakfastBegan
  /-- The shot rang out just as his breakfast was ready: "you were just ready to
  eat, and you heard a gunshot". -/
  | shotAsBreakfastWasReady
  /-- Making his breakfast took five minutes: "So obviously it takes you five
  minutes to make breakfast." — "That's right." -/
  | breakfastTookFiveMinutes
  /-- His breakfast was eggs and grits. -/
  | breakfastWasEggsAndGrits
  /-- His grits were regular, not instant: "Just regular, I guess." — "No
  self-respecting Southerner uses instant grits." -/
  | gritsWereRegular
  /-- Regular grits take twenty minutes to cook: "it takes the entire
  grit-eating world twenty minutes". Counsel's claim, not the witness's. -/
  | regularGritsTakeTwentyMinutes
  /-- Making his breakfast took twenty minutes: as long as its grits. -/
  | breakfastTookTwentyMinutes
  /-- **Tipton's testimony.** Five minutes passed between the boys' going into
  the store and the shot. -/
  | fiveMinutesPassed
  /-- **What the cross-examination concludes.** Twenty minutes passed between
  them: as long as the grits take. -/
  | twentyMinutesPassed
deriving DecidableEq, Repr

end TestimonyExamples.Grits
