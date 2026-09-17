import Testimony.Attr
import Testimony.Logic.Notation
import Testimony.Scripture

/-!
# Arguments.SolaFide.Atoms — the atomic claims

The prooftexts of both strands, the two disputed lexical premises, the James
premises, and the conclusions. See `Testimony.Arguments.SolaFide` for the
dispute this encodes.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- Ephesians 2:8–9 teaches that salvation is by grace through faith, not of
  works, so that no one may boast. -/
  | ephesians2_8_9
  /-- Romans 3:28 teaches that a person is justified by faith apart from works
  of the law. -/
  | romans3_28
  /-- Galatians 2:16 teaches that no one is justified by works of the law. -/
  | galatians2_16
  /-- Romans 4:4–5 contrasts wages owed to a worker with a gift reckoned to one
  who does not work but believes. -/
  | romans4_4_5
  /-- Titus 3:5 teaches that God saved us not by works done in righteousness. -/
  | titus3_5
  /-- Paul's ἔργα νόμου denotes human works in general, not specifically the
  Jewish covenant boundary markers. **The disputed Pauline premise.** -/
  | worksOfLawMeansWorksGenerally
  /-- Luke 7:50 — Jesus tells the woman who anointed him, "your faith has saved
  you", immediately after declaring her sins forgiven. -/
  | luke7_50FaithHasSavedYou
  /-- σῴζω in Luke 7:50 denotes salvation rather than physical healing. **The
  disputed dominical premise.** -/
  | sozoIsSoteriological
  /-- James 2:14–26 targets a barren faith — mere assent, which the demons also
  have — rather than Paul's doctrine of justification. -/
  | james2TargetsDeadFaith
  /-- Good works are the fruit and evidence of saving faith, not a ground of
  justification. -/
  | worksAreFruitNotGround
  /-- James 2:24 is compatible with Paul, using "justify" and "faith" in
  different senses. -/
  | james2_24Compatible
  /-- Scripture does not contradict itself. -/
  | scriptureSelfConsistent
  /-- Justification is by faith alone. -/
  | justificationByFaithAlone
  /-- Salvation is by grace through faith, and not by works. **The
  conclusion.** -/
  | salvationByGraceThroughFaithNotWorks
  /-- Works performed in grace merit an increase of justification. The
  Tridentine claim. -/
  | worksMeritIncreaseOfJustification
deriving DecidableEq, Repr

end Testimony.Arguments.SolaFide
