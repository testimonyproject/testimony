import TestimonyArguments.Attr
import Testimony.Logic.Line
import Testimony.Scripture

/-!
# TestimonyArguments.SolaGratia.Atoms — the atomic claims

The claims, in groups: the texts every party reads; the readings of them that
are in dispute; the claims each rival position adds; the three parts of the
conclusion; and, last, the claims of the chapter on the perseverance of the
saints.

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
  /-- Ephesians 4:30: "And do not grieve the Holy Spirit of God, by whom you were
  sealed for the day of redemption." Paul, to believers. -/
  | ephesians4_30
  /-- 1 Thessalonians 5:19: "Do not quench the Spirit." Paul, to believers. -/
  | thessalonians5_19
  /-- Matthew 12:31–32: "every sin and blasphemy will be forgiven people, but the
  blasphemy against the Spirit will not be forgiven … either in this age or in
  the age to come." Jesus, answering the Pharisees who said he cast out demons
  by Beelzebul. The unforgivable sin is in the Gospels, not in Paul. -/
  | matthew12_31to32
  /-- Genesis 2:16–17: God commanded the man that he might eat of every tree of
  the garden, "but of the tree of the knowledge of good and evil you shall not
  eat". The man was made able to obey and able to disobey. -/
  | genesis2_16to17
  /-- The Holy Spirit's work is resisted: Stephen's hearers resisted him, and
  believers can grieve and quench him. What the texts of resistance say
  together, and what every party grants. -/
  | theSpiritIsResisted
  /-- Those who obstinately resist the Spirit, believers among them, can grieve
  him and lose him. The Formula of Concord's reading of Ephesians 4:30; Dort
  holds that God "does not wholly withdraw the Holy Spirit from his own people,
  even in their melancholy falls" (V, article 6). -/
  | grievingCanLoseTheSpirit
  /-- The blasphemy against the Spirit is the final refusal of the grace that is
  offered, persisted in until death. Augustine's reading: the sin that is never
  forgiven is impenitence to the end. -/
  | blasphemyIsFinalRefusalOfGrace
  /-- The grace that saves can be finally refused: one to whom it is given may
  refuse it to the end. What the Remonstrants, the Lutherans and Wesley hold,
  each on grounds of their own. Its meaning excludes the conclusion's second
  part. -/
  | savingGraceCanBeFinallyRefused
  /-- God gives the ability to believe: as Adam was made able to stand or to
  fall, so the one who hears the gospel is made able to receive it. The third
  way, stated without saying what kind of help the ability is. -/
  | abilityToBelieveIsGiven
  /-- Grace is received by faith alone. Sola fide, which the Reformed, the
  Lutherans and Wesley hold, and Trent condemns (Session VI, canon 9). -/
  | faithAloneReceivesGrace
  /-- In the grace by which the will is converted, God is the sole mover: "in
  that effect in which our mind is moved and does not move, but in which God is
  the sole mover, the operation is attributed to God", which is operating grace,
  "especially when the will, which hitherto willed evil, begins to will good"
  (Aquinas, *Summa* I-II q.111 a.2). -/
  | operatingGraceMovesTheWill
  /-- God moves the will intending that it attain grace: "if God intends, while
  moving, that the one whose heart He moves should attain to grace, he will
  infallibly attain to it" (Aquinas, I-II q.112 a.3). -/
  | godIntendsWhileMoving
  /-- Under operating grace the will is not merely passive: it "elicits its act
  vitally, in fact, it freely consents to the divine motion", and "does not
  remain passive" (Garrigou-Lagrange). Trent's canon 4 condemns the "merely
  passive" too. Read two ways, which the dilemma over it sets out. -/
  | willIsNotMerelyPassive
  /-- Grace truly sufficient, giving the power to do good, is resisted, and
  through that resistance the efficacious grace offered with it is withheld. The
  Thomists' sufficient grace (Garrigou-Lagrange, after Lemos). Not the claim that
  the grace that saves can be finally refused: the grace resisted here is not the
  grace that converts. -/
  | sufficientGraceIsResisted
  /-- Justifying grace, once given, can be lost: the charity of one still on the
  way can be lost (Aquinas, II-II q.24 a.11), and Trent condemns anyone who says
  that a man once justified cannot lose grace (Session VI, canon 23). Dort holds
  the contrary, the perseverance of the saints (Fifth Head). Not the claim that
  the grace that saves can be finally refused: this is about grace once given,
  not about the grace that converts. -/
  | justifyingGraceCanBeLost
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
  /-- Conversion is God's work alone: God is the one who regenerates, and the
  sinner's will does nothing to bring it about. What each Reformed strand
  delivers, and what the Lutherans hold too. It does not by itself say that the
  grace which does this cannot be refused; the step from here to that claim is
  where the Lutherans part from Dort. The older word for it is monergism, "one
  at work". -/
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
  /-- John 10:27–29: "My sheep hear my voice, and I know them, and they follow
  me. I give them eternal life, and they will never perish, and no one will
  snatch them out of my hand." The first text of the perseverance of the
  saints. -/
  | john10_27to29
  /-- Philippians 1:6: "And I am sure of this, that he who began a good work in
  you will bring it to completion at the day of Jesus Christ." -/
  | philippians1_6
  /-- Hebrews 6:4–6: "For it is impossible, in the case of those who have once
  been enlightened, who have tasted the heavenly gift, and have shared in the
  Holy Spirit … and then have fallen away, to restore them again to
  repentance." The text most often set against perseverance. -/
  | hebrews6_4to6
  /-- 1 John 2:19: "They went out from us, but they were not of us; for if they
  had been of us, they would have continued with us." -/
  | firstJohn2_19
  /-- No power from outside can snatch true believers out of Christ's hand. What
  the Remonstrants' fifth article grants from John 10:28, and what no party
  denies. -/
  | noneSnatchedByForce
  /-- To some whom God has regenerated, and given faith, hope and love, he does
  not give perseverance. Augustine, *On Rebuke and Grace*, chapter 18. -/
  | someRegenerateNotGivenPerseverance
  /-- God's promise to keep those he has begun to save holds unless they fall
  away by their own fault. Trent's "unless men be themselves wanting to His
  grace", Wesley's "if ye do these things, ye shall never fall", and the Formula
  of Concord's account of those who fall away. Read two ways, which the dilemma
  over it sets out. -/
  | promiseIsConditional
  /-- The God of John 10 keeps the condition himself: those who are his sheep do
  hear and follow, because he keeps them in faith. Dort's "God is faithful, who
  having conferred grace, mercifully confirms and powerfully preserves them
  therein, even to the end" (V, article 3). -/
  | godKeepsHisSheepInFaith
  /-- Hebrews 6:4–6 describes true believers who actually fall away. Wesley's
  reading; Calvin's is that those described had only "some taste" of grace. -/
  | hebrews6DescribesBelieversWhoFall
  /-- Those God has chosen and effectually calls cannot finally fall away from
  grace: they persevere to the end. Westminster XVII.1 says it of the
  effectually called, and Westminster X.1 makes them the elect. Augustine,
  Aquinas and the Formula of Concord say it of the elect too. -/
  | electPersevere
  /-- Everyone who is truly justified is among the elect: faith that does not
  last to the end was never justifying faith. The Reformed claim that joins
  the elect's perseverance to every believer's. Augustine denies it; Trent
  condemns it (canon 23); the Lutherans and Wesley do not hold it. -/
  | justifiedAreElect
  /-- One who is truly justified can fall away from grace finally, and perish.
  What Augustine and Aquinas, Trent, the Lutherans and Wesley hold, each on
  grounds of their own; Westminster and Dort deny it. -/
  | justifiedCanFinallyFallAway
  /-- Romans 8:29–30: "And those whom he predestined he also called, and those
  whom he called he also justified, and those whom he justified he also
  glorified." -/
  | romans8_29to30
  /-- Hebrews 10:26–29: "How much worse punishment, do you think, will be
  deserved by the one who has trampled underfoot the Son of God, and has
  profaned the blood of the covenant by which he was sanctified, and has
  outraged the Spirit of grace?" -/
  | hebrews10_26to29
  /-- 2 Peter 2:20–22: "For if, after they have escaped the defilements of the
  world through the knowledge of our Lord and Savior Jesus Christ, they are again
  entangled in them and overcome, the last state has become worse for them than
  the first … The dog returns to its own vomit, and the sow, after washing
  herself, returns to wallow in the mire." -/
  | secondPeter2_20to22
  /-- Psalm 51:11: "Cast me not away from your presence, and take not your Holy
  Spirit from me." David's prayer after his sin with Bathsheba. -/
  | psalm51_11
  /-- Romans 8:16: "The Spirit himself bears witness with our spirit that we are
  children of God." -/
  | romans8_16
  /-- 1 Corinthians 10:12: "Therefore let anyone who thinks that he stands take
  heed lest he fall." -/
  | firstCorinthians10_12
  /-- Hebrews 10:29 describes one truly sanctified by Christ's blood who falls
  away. Wesley's reading: "he was, at least, justified once". -/
  | hebrews10DescribesTheSanctifiedWhoFall
  /-- 2 Peter 2:20–22 describes true believers, who had escaped the world's
  defilements by an inward knowledge of Christ, falling back. Wesley's reading;
  Calvin's is that "there are many swine who, immediately after washing, roll
  themselves again in the mud". -/
  | secondPeter2DescribesBelieversWhoFall
  /-- In his sin David lost the Holy Spirit, and his faith with it. The Smalcald
  Articles' reading of David's fall; Calvin's is that "the Spirit had not
  altogether been taken away from him". -/
  | davidLostTheSpirit
  /-- A believer can know, without a special revelation, that he will persevere
  to the end. Dort (V, articles 9–10) and Westminster (XVIII) hold it; Trent's
  canon 16 condemns it. -/
  | believersCanBeSureOfPersevering
deriving DecidableEq, Repr

end TestimonyArguments.SolaGratia
