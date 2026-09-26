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
  /-- Faith is sufficient: whoever believes is saved. Weaker than faith alone —
  it says faith saves, not that nothing else is a condition — and all that Luke
  7:50 and Peter at Jerusalem say. -/
  | faithIsSufficient
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
  /-- Justification is not the remission of sins only, but also the
  sanctification and renewal of the inward man. **Trent's definition of what
  justification is**, from which its objection to "not by works" follows. -/
  | justificationIncludesSanctification
  /-- Justification and sanctification are inseparable but distinct:
  justification is God's pardon and acceptance, and sanctification is the
  renewal that follows it. **The Reformed distinction** that Trent's definition
  denies. -/
  | justificationDistinctFromSanctification
  /-- The inward renewal of the justified grows as they do good works in grace.
  Common ground: Trent calls the growth an increase of justification, and the
  Reformed call it sanctification. -/
  | renewalGrowsThroughGoodWorks
  /-- John 6:28–29 — asked what they must do to be doing the works of God, Jesus
  answers: "This is the work of God, that you believe in him whom he has sent."
  -/
  | john6_29WorkIsBelieving
  /-- John 3:16–18, 3:36, 5:24 and 20:31 — eternal life, and passing out of
  judgement, through believing in the Son. -/
  | johnLifeThroughBelieving
  /-- The believing of John 6:29 is trust in Christ, which brings nothing to God
  and receives righteousness from him: faith as a "passive work" (Calvin). **The
  Johannine strand's hinge.** -/
  | johannineBelievingIsTrust
  /-- The believing of John 6:29 — believing *in* him, as one's end — is faith
  living through charity, the source of good works (Aquinas). The rival reading
  of the hinge, and Trent's (Session VI, ch. 7). -/
  | johannineBelievingIsFormedByCharity
  /-- Galatians 3:11–12 — no one is justified before God by the law; and the law
  is not of faith, for "the one who does them shall live by them". -/
  | gal3_11_12LawIsNotOfFaith
  /-- Love of God and neighbour is what the law commands (Deuteronomy 6:5; the
  two great commandments). Common ground: Luther argues from it, and Aquinas
  would not deny it. -/
  | lawCommandsCharity
  /-- Galatians 1:6–9 says that whoever preaches a gospel contrary to the one
  received — even an angel from heaven — is accursed. -/
  | galatians1_6_9
  /-- 1 Corinthians 15:3 says that Christ died for our sins in accordance with the
  Scriptures: the gospel Paul received and delivered, "of first importance". -/
  | firstCorinthians15_3
  /-- Galatians 2:21 says that if righteousness were through the law, then Christ
  died for no purpose. -/
  | galatians2_21
  /-- Galatians 5:2–4 says that if you accept circumcision, Christ will be of no
  advantage to you; you who would be justified by the law are severed from
  Christ. -/
  | galatians5_2_4
  /-- Romans 8:33–34 says: it is God who justifies — who is to condemn? -/
  | romans8_33_34
  /-- In Paul, δικαιόω is forensic: to declare righteous, a verdict — the
  opposite of condemning, as in Deuteronomy 25:1 and Romans 8:33–34 — and not to
  make virtuous. **The lexical premise.** -/
  | dikaioIsForensic
  /-- Paul names renewal with words of its own — ἀνακαίνωσις, renewal (Titus
  3:5; Romans 12:2), and ἁγιασμός, sanctification (Romans 6:19, 22) — and sets
  them beside δικαιόω rather than inside it: "the washing of regeneration and
  renewal of the Holy Spirit … so that being justified by his grace" (Titus
  3:5–7); "you were washed, you were sanctified, you were justified" (1
  Corinthians 6:11). -/
  | paulNamesRenewalOtherwise
  /-- A word contributes to a passage the least meaning its context requires,
  and one occurrence of it does not carry everything the word — or the doctrine
  it is used for — can carry: Joos's rule of least meaning, and Barr's
  "illegitimate totality transfer", as Silva applies them to the words of the
  New Testament. **The semantic razor.** -/
  | leastMeaning
  /-- Paul's word δικαιόω itself denotes the renewal of the inward man, and not
  only the verdict: to be justified, in Paul's sense of the word, is to be made
  inwardly just. What Trent's definition says, **read as a claim about Paul's
  word**. -/
  | paulsJustifyDenotesRenewal
  /-- When God justifies, he also renews: pardon and the renewal of the inward
  man are given together, and are not to be separated. What Trent's definition
  says, **read as a claim about what God does**; and, so stated, what the
  *Joint Declaration* confesses and Calvin grants. -/
  | justifyingGraceRenews
  /-- Christ's death for our sins is the whole ground of justification: nothing
  added to it completes it, and to add a ground is to preach another gospel.
  **Paul's gospel, as Galatians reads it.** -/
  | christsWorkIsTheWholeGround
deriving DecidableEq, Repr

end Testimony.Arguments.SolaFide
