import TestimonyExamples.Grits.Atoms
import TestimonyExamples.Works

/-!
# TestimonyExamples.Grits.Sources — citation and classification for every atom

`cite` is total, so an uncited atom does not compile. Every claim is cited to
the record: the scene as the D.C. Circuit sets it out, in its summary of the
direct examination and in its note 5, which gives the cross-examination
question by question (slip opinion, pages 11–12), with the film it is from.
The ratings are the record's as the cross-examination ended, and as the court
read it.
-/

namespace TestimonyExamples.Grits

open Testimony Testimony.Bib Testimony.Logic

/-- The record, at a rating: the court's account of the scene, and the film. -/
def theRecord (confidence : Confidence) : Source :=
  { primary := .work novatoHealthcareNlrb (.pages 11 12)
  , supporting := [.work myCousinVinny .whole]
  , tradition := .adversarialTrial
  , confidence }

/-! ### Ratings for inference steps -/

/-- **The reckoning is rated `consensus`.** If the boys went in as breakfast
began, and the shot came as it was ready, then the time between them is the
time breakfast took. It is Tipton's reckoning — on direct he was sure only five
minutes had passed "because he saw Bill go into the store as he (Tipton) started
making breakfast, and the shot rang out just as his breakfast was ready to eat"
— and counsel grants it outright: "So obviously it takes you five minutes to
make breakfast." No one in the record grants its grounds and denies what it
delivers. The cross-examination contests what the breakfast took, never the
step. -/
def onTheReckoning : Source := theRecord .consensus

/-- **The step from the grits is rated `wellSupported`.** Grant that breakfast
was eggs and grits, that the grits were regular, and that regular grits take
twenty minutes, and the breakfast took twenty minutes. It was audited against
the whole of the record for a reader who grants the grounds and denies the
conclusion. One did, for a moment: Tipton, who answers "I don't know. I'm a fast
cook I guess." He withdraws it before the cross-examination ends — "I may have
been mistaken" — and the court reads the step as decisive: "it was clear that
Tipton could not have cooked his breakfast of eggs and grits in just five
minutes." Not `consensus`, because its one dissenter held out until pressed. -/
def onTheGrits : Source := theRecord .wellSupported

/-- **The same step, rated as it stood when Tipton said he was a fast cook:
`disputed`.** He has granted the eggs and grits, and that the grits were
regular, and he does not deny that regular grits take the grit-eating world
twenty minutes; he denies that his did: "I don't know. I'm a fast cook I
guess." A cited reader grants the step's grounds and denies its conclusion,
which is what `disputed` means. -/
def atTheFastCook : Source := theRecord .disputed

/-! ### Citations -/

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .enteredAsBreakfastBegan =>
    { label := "Tipton saw the boys go into the store as he began making breakfast"
    , kind := .historical
      -- `consensus`: the direct examination's own account, which the
      -- cross-examination restates and relies on.
    , source := theRecord .consensus }
  | .shotAsBreakfastWasReady =>
    { label := "The shot rang out just as Tipton's breakfast was ready to eat"
    , kind := .historical
    , source := theRecord .consensus }
  | .breakfastTookFiveMinutes =>
    { label := "Making his breakfast took Tipton five minutes"
    , kind := .historical
      -- `disputed`: Tipton affirms it ("That's right"); counsel contests it
      -- ("how could it take you five minutes to cook your grits"), Tipton
      -- withdraws it ("I may have been mistaken"), and the court finds that he
      -- "could not have cooked his breakfast of eggs and grits in just five
      -- minutes".
    , source := theRecord .disputed }
  | .breakfastWasEggsAndGrits =>
    { label := "Tipton's breakfast was eggs and grits"
    , kind := .historical
    , source := theRecord .consensus }
  | .gritsWereRegular =>
    { label := "Tipton's grits were regular grits, not instant"
    , kind := .historical
      -- `consensus`: his own answer, emphatically: "No self-respecting
      -- Southerner uses instant grits. I take pride in my grits."
    , source := theRecord .consensus }
  | .regularGritsTakeTwentyMinutes =>
    { label := "Regular grits take twenty minutes to cook"
    , kind := .empirical
      -- `wellSupported`, not `consensus`: it is counsel's claim, and the
      -- record holds no evidence for it beyond his word. Tipton does not deny
      -- it ("I don't know"), and the court accepts it.
    , source := theRecord .wellSupported }
  | .breakfastTookTwentyMinutes =>
    { label := "Making his breakfast took Tipton twenty minutes"
    , kind := .historical
    , source := theRecord .wellSupported }
  | .fiveMinutesPassed =>
    { label := "Five minutes passed between the boys' going into the store and the shot"
    , kind := .historical
      -- `disputed`: Tipton's testimony, withdrawn on cross-examination.
    , source := theRecord .disputed }
  | .twentyMinutesPassed =>
    { label := "Twenty minutes passed between the boys' going into the store and the shot"
    , kind := .historical
      -- `plausible`: the court found that five minutes could not be right,
      -- not how long it was.
    , source := theRecord .plausible }

end TestimonyExamples.Grits
