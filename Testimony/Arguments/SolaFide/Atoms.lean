import Testimony.Attr
import Testimony.Logic.Notation
import Testimony.Scripture

/-!
# Arguments.SolaFide.Atoms — the atomic claims

The prooftexts of the three strands, their four disputed premises, the reading
of Galatians as a polemic, the authorship of the disputed letters, the rivals'
premises — covenantal nomism, forensic justification, the apocalyptic reading —
the James premises, and the three parts of the conclusion. See
`Testimony.Arguments.SolaFide` for the dispute this encodes.
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
  Jewish covenant boundary markers. **The first disputed Pauline premise.** -/
  | worksOfLawMeansWorksGenerally
  /-- πίστις Χριστοῦ in Galatians 2:16 — and at Romans 3:22 and Philippians 3:9 —
  is an objective genitive: faith *in* Christ, not Christ's own faithfulness.
  **The second disputed Pauline premise**, and the one that makes the believer's
  faith, not only the exclusion of works, part of what Galatians 2:16 says. -/
  | pistisChristouObjective
  /-- Galatians is a polemic against requiring circumcision of believers, in
  addition to faith, as a condition of justification (Galatians 2:3–5,
  5:2–4). -/
  | galatiansOpposesCircumcisionAsRequirement
  /-- Acts 15:9–11 — at the Jerusalem council, answering the demand that
  gentile believers be circumcised and keep the law of Moses (15:1, 15:5), Peter
  says that God cleansed their hearts by faith, and that "we believe that we
  will be saved through the grace of the Lord Jesus, just as they will". -/
  | acts15_9_11
  /-- The yoke Peter refuses at Acts 15:10 — one "that neither our fathers nor
  we have been able to bear" — is the law as a whole taken as a condition of
  salvation, and not only Israel's marks of belonging. **The disputed apostolic
  premise.** -/
  | acts15YokeIsLawAsCondition
  /-- Acts 15:20–21 and 21:20–24 — the decree lays on gentile believers part of
  what the law of Moses requires, and the Jewish believers in Jerusalem are
  "all zealous for the law". Jervell's ground for reading Luke as law-observant.
  -/
  | lukeKeepsTheLaw
  /-- Ephesians was written by Paul. -/
  | ephesiansIsPauline
  /-- Titus was written by Paul. -/
  | titusIsPauline
  /-- 1 Peter was written by the apostle Peter. -/
  | firstPeterIsPetrine
  /-- 2 Peter was written by the apostle Peter. -/
  | secondPeterIsPetrine
  /-- δικαιοσύνη θεοῦ in Romans names God's act of delivering the world in
  Christ, not a status granted to those who meet the condition of faith. The
  apocalyptic reading. -/
  | righteousnessOfGodIsDeliverance
  /-- Luke 7:50 — Jesus tells the woman who anointed him, "your faith has saved
  you", immediately after declaring her sins forgiven. -/
  | luke7_50FaithHasSavedYou
  /-- σῴζω in Luke 7:50 denotes salvation rather than physical healing. **The
  dominical strand's lexical premise.** -/
  | sozoIsSoteriological
  /-- Luke 7:47 — "her sins, which are many, are forgiven, for she loved much":
  her love is the evidence of her forgiveness, not its ground. The half-verse
  that follows ("the one who is forgiven little loves little") and the parable
  of the two debtors (7:41–43) put the forgiveness first and the love after it.
  The Reformed answer, in advance, to reading 7:47 as salvation by love. -/
  | luke7_47LoveIsEvidence
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
  /-- Salvation is by grace: a gift, not wages owed. **First part of the
  conclusion.** -/
  | salvationByGrace
  /-- Salvation is not by works: no work, however done, is its ground. **Second
  part of the conclusion**, and the one the Tridentine position denies. -/
  | salvationNotByWorks
  /-- Salvation is received through faith: faith is the means by which it is
  received. **Third part of the conclusion**, and the one the apocalyptic
  reading denies. -/
  | salvationThroughFaith
  /-- Justification is forensic only: a declaration — pardon, and the
  imputation of Christ's righteousness — and not an infusion of righteousness.
  The Reformed account of what justification *is*, denied by Trent and by the
  Finnish reading of Luther alike. -/
  | justificationIsForensicOnly
  /-- Second Temple Judaism held entry to the covenant to be by grace, and works
  to be the means of staying in it: Sanders' *covenantal nomism*. -/
  | secondTempleCovenantalNomism
  /-- Works performed in grace merit an increase of justification. The
  Tridentine claim. -/
  | worksMeritIncreaseOfJustification
deriving DecidableEq, Repr

end Testimony.Arguments.SolaFide
