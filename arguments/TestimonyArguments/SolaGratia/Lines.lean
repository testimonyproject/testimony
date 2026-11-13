import TestimonyArguments.SolaGratia.Sources

/-!
# TestimonyArguments.SolaGratia.Lines — the inference steps and the lines of reason

Two routes reach the conclusion, one through Ephesians 2 and one through
Romans 9, and each has a reading of its text that is in dispute. A third line,
from Romans 11:6, delivers only the first part of the conclusion, that
salvation is by grace, and every party walks it: Trent quotes the verse in the
eighth chapter of its decree on justification.

Trent and the Remonstrants each deny a different part of what the Reformed
lines deliver, so each has lines of its own here. Trent's fourth canon on
justification denies that the will is merely passive, and in the same sentence
says the will can refuse if it wishes. The Remonstrants deny that grace cannot
be resisted, from Stephen's speech in Acts 7.
-/

namespace TestimonyArguments.SolaGratia

open Testimony Testimony.Logic

/-! ### The conclusion -/

/-- **Sola gratia, stated sharply enough that the rivals divide from it.**
Salvation is by grace and not earned; the grace that saves brings about the
consent it seeks; and in being made alive the will contributes nothing. The
three parts are separate claims so that a rival can be shown holding the first
and denying the others, which is what both rivals do. -/
@[solaGratiaDefs]
def solaGratia : Formula Claim :=
  ⋀ [p .salvationIsByGrace, p .graceIsEffectualOfItself, p .willIsPassiveInRegeneration]

/-! ### The steps -/

/-- Romans 11:6: if salvation is by grace it is not by works, so it is by grace
and not earned. -/
@[solaGratiaDefs]
def graceStep : Formula Claim :=
  p .romans11_6 ➝ p .salvationIsByGrace

/-- Ephesians 2:8–9, with "this" read as pointing to the whole of being saved
by grace through faith: so faith, part of that whole, is God's gift. Rated
`disputed`: Robertson reads the pronoun the same way and calls the whole
"conditioned on faith on our part", and Calvin, on the next verse, writes "not
that faith is the gift of God, but that salvation is given to us by God". -/
@[solaGratiaDefs]
def ephesiansStep : Formula Claim :=
  ⋀ [p .ephesians2_8to9, p .toutoRefersToTheWhole] ➝ p .faithIsGodsGift

/-- **The step Arminius refuses.** If faith is God's gift, and it is given to
those who were dead until God made them alive (Ephesians 2:1–5), then
conversion is God's work alone. Rated `disputed`: Arminius grants both grounds
and denies that the gift cannot be refused. Dort's answer is its article on
faith: God's gift "not on account of its being offered by God to man, to be
accepted or rejected at his pleasure, but because it is in reality conferred"
(III/IV, article 14). -/
@[solaGratiaDefs]
def giftStep : Formula Claim :=
  ⋀ [p .faithIsGodsGift, p .ephesians2_1to5] ➝ p .conversionIsGodsWorkAlone

/-- Romans 9:16, read as being about salvation: if God's saving mercy "depends
not on human will or exertion", conversion is God's work alone. Rated
`disputed`: Arminius grants that the verse is about salvation and reads its
willing and running as seeking salvation by the works of the law, so that the
mercy goes to believers and can be refused. -/
@[solaGratiaDefs]
def romansStep : Formula Claim :=
  ⋀ [p .romans9_16, p .romans9_16ConcernsSalvation] ➝ p .conversionIsGodsWorkAlone

/-- What "God's work alone" means, unpacked into the conclusion's second and
third parts: grace brings about the consent, and the will contributes nothing
to its own new life. -/
@[solaGratiaDefs]
def monergismUnpacked : Formula Claim :=
  p .conversionIsGodsWorkAlone
  ➝ ⋀ [p .graceIsEffectualOfItself, p .willIsPassiveInRegeneration]

/-- **Trent's fourth canon, first half.** The will, moved by God, cooperates by
assenting, as "Return to me" calls on it to; so it is not passive. Rated
`disputed`: Aquinas grants that grace cooperates with a will that moves and
holds that in grace's first effect the mind "is moved and does not move". -/
@[solaGratiaDefs]
def cooperationStep : Formula Claim :=
  ⋀ [p .zechariah1_3WithLamentations5_21, p .freeWillCooperatesByAssenting]
  ➝ notP .willIsPassiveInRegeneration

/-- **Trent's fourth canon, second half.** The will, moved by God, can refuse
if it wishes; so grace is not effectual of itself. Rated `disputed`: Aquinas
grants that a will God moves could, taken simply, fail to be moved, and still
holds that the man God moves to grace attains it infallibly. -/
@[solaGratiaDefs]
def dissentStep : Formula Claim :=
  p .freeWillCanDissent ➝ notP .graceIsEffectualOfItself

/-- **The Remonstrants' fourth article.** Stephen's hearers resisted the Holy
Spirit, and what they resisted was the grace that saves; so that grace is not
effectual of itself. -/
@[solaGratiaDefs]
def resistanceStep : Formula Claim :=
  ⋀ [p .acts7_51, p .acts7_51ResistsSavingGrace] ➝ notP .graceIsEffectualOfItself

/-! ### The lines -/

/-- **Romans 11:6**, the line every party walks. It delivers the first part of
the conclusion and nothing more. -/
@[solaGratiaDefs]
def graceLine : Line Claim :=
  { name := "Romans 11:6 (by grace, so not by works)"
  , grounds := [p .romans11_6]
  , step := graceStep
  , delivers := p .salvationIsByGrace
  , inference := some graceInference }

/-- **Ephesians 2:8–9**, read with "this" pointing to the whole of being saved by
grace through faith. It delivers that faith is God's gift, which is not yet the
conclusion. -/
@[solaGratiaDefs]
def ephesiansLine : Line Claim :=
  { name := "Ephesians 2:8–9 (\"this is not your own doing\")"
  , grounds := [p .ephesians2_8to9, p .toutoRefersToTheWhole]
  , step := ephesiansStep
  , delivers := p .faithIsGodsGift
  , inference := some ephesiansInference }

/-- **From the gift to the dead to God's work alone.** Its ground is
Ephesians 2:1–5; the gift is carried in by `ephesiansLine`. -/
@[solaGratiaDefs]
def giftLine : Line Claim :=
  { name := "Faith given to the dead (Ephesians 2:1–5)"
  , grounds := [p .ephesians2_1to5]
  , step := giftStep
  , delivers := p .conversionIsGodsWorkAlone
  , inference := some giftInference }

/-- **Romans 9:16**, read as being about salvation. It reaches God's work alone
without the Ephesians grammar. -/
@[solaGratiaDefs]
def romansLine : Line Claim :=
  { name := "Romans 9:16 (\"not on human will or exertion\")"
  , grounds := [p .romans9_16, p .romans9_16ConcernsSalvation]
  , step := romansStep
  , delivers := p .conversionIsGodsWorkAlone
  , inference := some romansInference }

/-- **Trent on cooperation**: Zechariah 1:3 with Lamentations 5:21, and the
first half of canon 4. -/
@[solaGratiaDefs]
def cooperationLine : Line Claim :=
  { name := "Trent, canon 4: the will cooperates by assenting"
  , grounds := [p .zechariah1_3WithLamentations5_21, p .freeWillCooperatesByAssenting]
  , step := cooperationStep
  , delivers := notP .willIsPassiveInRegeneration
  , inference := some cooperationInference }

/-- **Trent on dissent**: the second half of canon 4. -/
@[solaGratiaDefs]
def dissentLine : Line Claim :=
  { name := "Trent, canon 4: the will can refuse if it wishes"
  , grounds := [p .freeWillCanDissent]
  , step := dissentStep
  , delivers := notP .graceIsEffectualOfItself
  , inference := some dissentInference }

/-- **The Remonstrants on resistance**: Acts 7:51, read as resisting the grace
that saves. -/
@[solaGratiaDefs]
def resistanceLine : Line Claim :=
  { name := "Remonstrance, article 4: grace is not irresistible (Acts 7:51)"
  , grounds := [p .acts7_51, p .acts7_51ResistsSavingGrace]
  , step := resistanceStep
  , delivers := notP .graceIsEffectualOfItself
  , inference := some resistanceInference }

/-! ### Shared grounds -/

/-- What the Reformed packages rest on beyond any one line: Acts 7:51, which
they must answer too, and Dort's answer to it, that what Stephen's hearers
resisted was the preached word and not the grace that saves. -/
@[solaGratiaDefs]
def reformedShared : List (Formula Claim) :=
  [p .acts7_51, notP .acts7_51ResistsSavingGrace]

/-- The step that closes every Reformed package: God's work alone, unpacked. -/
@[solaGratiaDefs]
def closingSteps : List (Formula Claim) :=
  [monergismUnpacked]

end TestimonyArguments.SolaGratia
