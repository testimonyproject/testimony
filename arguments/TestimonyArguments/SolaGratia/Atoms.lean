import TestimonyArguments.Attr
import Testimony.Logic.Line
import Testimony.Scripture

/-!
# TestimonyArguments.SolaGratia.Atoms — the atomic claims

Sixteen claims, in four groups: the texts every party reads, the readings of
them that are in dispute, the claims Trent and the Remonstrants add, and the
three parts of the conclusion.

The conclusion has three parts so that a rival can hold one part and deny
another, and both rivals do. Everyone in this dispute says that salvation is by
grace and not earned. Only the Reformed say that grace brings about the consent
it asks for, and that in being made alive the will contributes nothing.
-/

namespace TestimonyArguments.SolaGratia

open Testimony

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- Ephesians 2:1–5: "And you were dead in the trespasses and sins … even when
  we were dead in our trespasses, [God] made us alive together with Christ — by
  grace you have been saved." What the text says, which no party disputes. -/
  | ephesians2_1to5
  /-- Ephesians 2:8–9: "For by grace you have been saved through faith. And
  this is not your own doing; it is the gift of God, not a result of works, so
  that no one may boast." -/
  | ephesians2_8to9
  /-- Romans 9:16: "So then it depends not on human will or exertion, but on
  God, who has mercy." -/
  | romans9_16
  /-- Romans 11:6: "But if it is by grace, it is no longer on the basis of
  works; otherwise grace would no longer be grace." -/
  | romans11_6
  /-- Acts 7:51: Stephen to the council, "You stiff-necked people … you always
  resist the Holy Spirit." The Remonstrants' text, cited in their fourth
  article. -/
  | acts7_51
  /-- Zechariah 1:3, "Return to me … and I will return to you", read with
  Lamentations 5:21, "Restore us to yourself, O Lord, that we may be restored."
  Trent pairs the two (Session VI, chapter 5): by the first "we are admonished of
  our liberty", and in answering with the second "we confess that we are
  prevented by the grace of God", that is, that grace goes first. -/
  | zechariah1_3WithLamentations5_21
  /-- In Ephesians 2:8 "this" (τοῦτο) points to the whole of "saved by grace
  through faith", and not to "faith" or "grace" on its own. **The reading of the
  Ephesians strand.** The pronoun is neuter, and "faith" (πίστις) and "grace"
  (χάρις) are both feminine, so it does not agree with either. Hoehner and
  Robertson both read it this way. They differ over what follows: Robertson says
  the whole act of being saved is "conditioned on faith on our part". -/
  | toutoRefersToTheWhole
  /-- Romans 9:16 is about salvation: the mercy it speaks of is God's mercy in
  saving, not only his choice of a people for a part in history. **The reading
  of the Romans strand.** Arminius grants it, and so does Abasciano, who reads
  the election of Romans 9 as of a people rather than of individuals: "Paul's
  argument in Romans 9 surely concerns the salvation of Israel". -/
  | romans9_16ConcernsSalvation
  /-- Faith itself is God's gift, not something the believer adds. What the
  Ephesians strand delivers, and what Arminius affirms on grounds of his own. -/
  | faithIsGodsGift
  /-- What is resisted in Acts 7:51 is the grace that saves, not only the
  preaching that calls. The Remonstrants hold it. The Reformed deny it, reading
  the verse with Dort's account of those who refuse the call, which lays the
  fault on them and does not itself cite Acts 7:51. -/
  | acts7_51ResistsSavingGrace
  /-- The free will, moved and roused by God, cooperates by assenting to God's
  call, and so disposes itself for justification. Trent, Session VI, canon 4. -/
  | freeWillCooperatesByAssenting
  /-- The free will, moved and roused by God, can refuse its assent if it
  wishes. Trent, Session VI, canon 4. -/
  | freeWillCanDissent
  /-- Conversion is God's work alone: the grace that turns a sinner does not
  wait on the sinner's consent but brings it about. What each Reformed strand
  delivers, and what the second and third parts of the conclusion unpack. The
  older word for it is monergism, "one at work". -/
  | conversionIsGodsWorkAlone
  /-- Salvation is by grace and not earned: grace goes before every saving act
  and makes it possible. **The first part of the conclusion**, which Trent and
  the Remonstrants hold as firmly as the Reformed. -/
  | salvationIsByGrace
  /-- The grace that saves brings about the consent it seeks; it is not made
  effective by a will that could have refused it. **The second part of the
  conclusion**, which the Remonstrants deny. -/
  | graceIsEffectualOfItself
  /-- In being made alive the will is passive: its consent follows from the new
  life and is no part of bringing it about. **The third part of the
  conclusion**, which Trent's fourth canon condemns. -/
  | willIsPassiveInRegeneration
deriving DecidableEq, Repr

end TestimonyArguments.SolaGratia
