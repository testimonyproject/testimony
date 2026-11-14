import TestimonyArguments.SolaGratia.Sources

/-!
# TestimonyArguments.SolaGratia.Lines — the inference steps and the lines of reason

Two routes reach the conclusion, one through Ephesians 2 and one through
Romans 9, and each has a reading of its text that is in dispute. A third line,
from Romans 11:6, delivers only the first part of the conclusion, that
salvation is by grace, and every party walks it: Trent quotes the verse in the
eighth chapter of its decree on justification.

Trent and the Remonstrants each deny part of what the Reformed lines deliver,
so each has lines of its own here. Trent's fourth canon on justification denies
that the will is merely passive, and in the same sentence condemns anyone who
says the will cannot refuse its consent: so Trent's lines deny both the second
and third parts of the conclusion. The Remonstrants deny the second part, that
grace cannot be resisted, from Stephen's speech in Acts 7.

The texts of resistance are common ground. Stephen's hearers "always resist the
Holy Spirit" (Acts 7:51), and Paul tells believers not to grieve the Spirit
(Ephesians 4:30) or quench him (1 Thessalonians 5:19); every party grants that
the Spirit's work meets resistance. What is disputed is the step from there to
the claim that the grace that saves can be *finally* refused. The word "resist"
can mean resisting for a time, as the Reformed say even the elect do before
grace overcomes them, or refusing to the end. A second route to the final
refusal runs through the sin that is never forgiven (Matthew 12:31–32), read
with Augustine as impenitence persisted in until death.

The closing step is two steps. From God's work alone to the will's passivity,
the Lutherans agree with Dort. From God's work alone to grace that cannot be
finally refused, they do not: the Formula of Concord holds conversion to be the
Spirit's work alone and grace resistible all the same.
-/

namespace TestimonyArguments.SolaGratia

open Testimony Testimony.Logic

/-! ### The conclusion -/

/-- **Sola gratia, stated sharply enough that the rivals divide from it.**
Salvation is by grace and not earned; the grace that saves brings about the
consent it seeks; and in being made alive the will contributes nothing. The
three parts are separate claims so that a rival can be shown holding the first
and denying one or both of the others: Trent's premises deny both, the
Remonstrants' the second. -/
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

/-- From God's work alone to the third part of the conclusion: the will is
passive in being made alive. Rated `wellSupported`: the Lutherans, who part from
Dort on the next step, grant this one. It is taken as what Dort means by the
phrase: the new life is "a making alive, which God works in us without our aid"
(III/IV, article 12). -/
@[solaGratiaDefs]
def passiveStep : Formula Claim :=
  p .conversionIsGodsWorkAlone ➝ p .willIsPassiveInRegeneration

/-- **From God's work alone to the second part of the conclusion: the grace that
saves cannot be finally refused.** Rated `disputed`: the Formula of Concord holds
conversion to be the Spirit's work alone, with the will "purely passive", and
holds grace resistible all the same. -/
@[solaGratiaDefs]
def effectualStep : Formula Claim :=
  p .conversionIsGodsWorkAlone ➝ p .graceIsEffectualOfItself

/-- What the texts of resistance say together: the Spirit's work is resisted.
Acts 7:51 says so of Stephen's hearers, and Paul's commands not to grieve the
Spirit (Ephesians 4:30) or quench him (1 Thessalonians 5:19) presuppose it of
believers. -/
@[solaGratiaDefs]
def textsOfResistanceStep : Formula Claim :=
  ⋀ [p .acts7_51, p .ephesians4_30, p .thessalonians5_19] ➝ p .theSpiritIsResisted

/-- **From resistance to final refusal.** If the Spirit is resisted, and what is
resisted is the grace that saves, that grace can be finally refused. The
Remonstrants' fourth article, made explicit. -/
@[solaGratiaDefs]
def resistanceStep : Formula Claim :=
  ⋀ [p .theSpiritIsResisted, p .acts7_51ResistsSavingGrace]
  ➝ p .savingGraceCanBeFinallyRefused

/-- **From grieving the Spirit to final refusal.** If the Spirit is resisted,
and those who obstinately resist him can grieve and lose him, the grace that
saves can be finally refused. The Formula of Concord's reading of
Ephesians 4:30. -/
@[solaGratiaDefs]
def griefStep : Formula Claim :=
  ⋀ [p .theSpiritIsResisted, p .grievingCanLoseTheSpirit] ➝ p .savingGraceCanBeFinallyRefused

/-- **From the unforgivable sin to final refusal.** If the blasphemy against the
Spirit is never forgiven (Matthew 12:31–32), and it is the final refusal of the
grace offered, then that grace can be finally refused. -/
@[solaGratiaDefs]
def blasphemyStep : Formula Claim :=
  ⋀ [p .matthew12_31to32, p .blasphemyIsFinalRefusalOfGrace]
  ➝ p .savingGraceCanBeFinallyRefused

/-- What final refusal means for the second part of the conclusion: grace that
can be finally refused is not effectual of itself. Rated `consensus`: it is what
the two claims say, and their meanings exclude each other. -/
@[solaGratiaDefs]
def refusalStep : Formula Claim :=
  p .savingGraceCanBeFinallyRefused ➝ notP .graceIsEffectualOfItself

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

/-- **From faith given to the dead, to God's work alone.** Its ground is
Ephesians 2:1–5; that faith is God's gift comes from the Ephesians line above.
-/
@[solaGratiaDefs]
def giftLine : Line Claim :=
  { name := "From faith given to the dead, to God's work alone (Ephesians 2:1–5)"
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

/-- **The texts of resistance**: Acts 7:51, Ephesians 4:30 and
1 Thessalonians 5:19, delivering that the Spirit's work is resisted. Every party
walks this line. -/
@[solaGratiaDefs]
def textsOfResistanceLine : Line Claim :=
  { name := "The texts of resistance (Acts 7:51; Ephesians 4:30; 1 Thessalonians 5:19)"
  , grounds := [p .acts7_51, p .ephesians4_30, p .thessalonians5_19]
  , step := textsOfResistanceStep
  , delivers := p .theSpiritIsResisted
  , inference := some textsOfResistanceInference }

/-- **The Remonstrants on resistance**: what Stephen's hearers resisted was the
grace that saves, so that grace can be finally refused. -/
@[solaGratiaDefs]
def resistanceLine : Line Claim :=
  { name := "Remonstrance, article 4: grace is not irresistible (Acts 7:51)"
  , grounds := [p .acts7_51ResistsSavingGrace]
  , step := resistanceStep
  , delivers := p .savingGraceCanBeFinallyRefused
  , inference := some resistanceInference }

/-- **Grieving the Spirit**, read as able to end in losing him. -/
@[solaGratiaDefs]
def griefLine : Line Claim :=
  { name := "Grieving the Spirit (Ephesians 4:30), as able to lose him"
  , grounds := [p .grievingCanLoseTheSpirit]
  , step := griefStep
  , delivers := p .savingGraceCanBeFinallyRefused
  , inference := some griefInference }

/-- **The unforgivable sin**, read as the final refusal of grace. -/
@[solaGratiaDefs]
def blasphemyLine : Line Claim :=
  { name := "The sin against the Spirit (Matthew 12:31–32), as final refusal"
  , grounds := [p .matthew12_31to32, p .blasphemyIsFinalRefusalOfGrace]
  , step := blasphemyStep
  , delivers := p .savingGraceCanBeFinallyRefused
  , inference := some blasphemyInference }

/-- **Final refusal, and what it denies.** -/
@[solaGratiaDefs]
def refusalLine : Line Claim :=
  { name := "Grace that can be finally refused is not effectual of itself"
  , grounds := []
  , step := refusalStep
  , delivers := notP .graceIsEffectualOfItself
  , inference := some refusalInference }

/-! ### Shared grounds -/

/-- What the Reformed packages rest on beyond any one line: the Reformed answer
to Acts 7:51, from Dort's account of those who refuse the call. What Stephen's
hearers resisted was the outward call of the preached word, not the grace that
saves. The texts of resistance themselves are a line the Reformed walk too. -/
@[solaGratiaDefs]
def reformedShared : List (Formula Claim) :=
  [notP .acts7_51ResistsSavingGrace]

/-- The steps that close every Reformed package: God's work alone, unpacked into
the conclusion's last two parts, one step each. -/
@[solaGratiaDefs]
def closingSteps : List (Formula Claim) :=
  [passiveStep, effectualStep]

/-- The ratings of the closing steps, which belong to no line. -/
def closingInferences : List Source :=
  [passiveInference, effectualInference]

end TestimonyArguments.SolaGratia
