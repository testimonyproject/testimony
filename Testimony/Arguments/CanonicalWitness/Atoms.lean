import Testimony.Attr
import Testimony.Logic.Notation
import Testimony.Scripture

/-!
# Arguments.CanonicalWitness.Atoms — the atomic claims

What the texts say, corpus by corpus; the three parts of *faith alone* — that
faith is necessary, that it is sufficient, and that works are not the ground;
what James adds, that works are the fruit of saving faith; and the readings on
which James and Trent part. See `Testimony.Arguments.CanonicalWitness` for the
argument this encodes.
-/

namespace Testimony.Arguments.CanonicalWitness

open Testimony Testimony.Logic Testimony.Scripture

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- Romans 3:28 says a person is justified by faith apart from works of the
  law. -/
  | romans3_28
  /-- Romans 4:4–5 says that to the one who does not work but believes in him who
  justifies the ungodly, his faith is counted as righteousness. -/
  | romans4_4_5
  /-- Galatians 2:16 says a person is not justified by works of the law but
  through faith in Christ. -/
  | galatians2_16
  /-- Ephesians 2:8–9 says we are saved by grace through faith, not of works, so
  that no one may boast. -/
  | ephesians2_8_9
  /-- Titus 3:5 says God saved us not by works done in righteousness but by his
  mercy. -/
  | titus3_5
  /-- Hebrews 10:38–39 says the righteous one shall live by faith, and we are of
  those who have faith and preserve their souls. -/
  | hebrews10_38_39
  /-- Hebrews 11:6 says without faith it is impossible to please God. -/
  | hebrews11_6
  /-- John 3:16–18 says whoever believes in the Son has eternal life, and whoever
  does not believe is condemned already. -/
  | john3_16_18
  /-- John 5:24 says whoever hears Jesus' word and believes has eternal life and
  does not come into judgement. -/
  | john5_24
  /-- John 6:28–29 says the work of God is this: that you believe in him whom he
  has sent. -/
  | john6_28_29
  /-- Acts 10:43 says, in Peter's words, that everyone who believes in him
  receives forgiveness of sins through his name. -/
  | acts10_43
  /-- Acts 15:10–11 says, in Peter's words, that the yoke is not to be laid on the
  disciples, for we are saved through the grace of the Lord Jesus. -/
  | acts15_10_11
  /-- Luke 7:50 says, in Jesus' words to the woman who anointed him, "your faith
  has saved you". -/
  | luke7_50
  /-- Luke 18:9–14 says the tax collector who pleaded for mercy went home
  justified, rather than the Pharisee who listed his works. -/
  | luke18_9_14
  /-- James 2:14–17 says faith by itself, if it does not have works, is dead. -/
  | james2_14_17
  /-- James 2:19 says even the demons believe, and shudder. -/
  | james2_19
  /-- James 2:21–23 says Abraham's faith was completed by his works, and the
  scripture was fulfilled that says he believed God and it was counted to him as
  righteousness. -/
  | james2_21_23
  /-- James 2:24 says a person is justified by works and not by faith alone. -/
  | james2_24
  /-- Jude 20–21 says to keep yourselves in the love of God, waiting for the
  mercy of our Lord Jesus Christ that leads to eternal life. -/
  | jude20_21
  /-- Faith is necessary: no one is saved without it. -/
  | faithIsNecessary
  /-- Faith is sufficient: whoever believes is saved. -/
  | faithIsSufficient
  /-- Works are not the ground of justification. -/
  | worksAreNotTheGround
  /-- Justification is by faith alone. **The conclusion.** -/
  | justificationByFaithAlone
  /-- Good works are the fruit of saving faith, and follow it. -/
  | worksAreFruitOfFaith
  /-- Justification by faith alone, by a faith that is never alone. **The
  conclusion with James.** -/
  | faithAloneNeverAlone
  /-- James 2:14–26 targets a faith without works — bare assent, the faith of
  the demons in 2:19 — not the faith Paul says justifies. -/
  | james2TargetsDeadFaith
  /-- "Justified" in James 2:21–24 is demonstrative: shown to be righteous, as
  Abraham's offering of Isaac in Genesis 22 displayed the faith already counted
  as righteousness in Genesis 15:6. **The hinge between James and Trent.** -/
  | jamesJustifiesDemonstratively
  /-- Justification and sanctification are distinct: the one a verdict, the
  other a renewal that follows it. -/
  | justificationDistinctFromSanctification
deriving DecidableEq, Repr

end Testimony.Arguments.CanonicalWitness
