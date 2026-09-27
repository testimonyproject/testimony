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
  /-- Augustine glosses Paul's "being justified" as "being made righteous" —
  "by Him, of course, who justifies the ungodly man, that he may become a godly
  one" (*On the Spirit and the Letter* 26.45) — and the Latin West read
  *iustificare* so after him. A claim about what Augustine wrote and what the
  tradition received, not about what Paul meant. -/
  | augustineReadsJustifyAsMakeRighteous
  /-- Romans 4:6–8 says that David speaks of the blessing of the one to whom God
  counts righteousness apart from works: "Blessed are those whose lawless deeds
  are forgiven, and whose sins are covered; blessed is the man against whom the
  Lord will not count his sin." -/
  | romans4_6_8
  /-- λογίζομαι in Romans 4:3–11 is the language of reckoning: to credit to
  someone's account. The wage "is not counted as a gift but as his due" (4:4);
  the one who does not work has faith "counted as righteousness" (4:5). -/
  | logizomaiIsReckoning
  /-- In Romans 4:6–8 Paul glosses "God counts righteousness apart from works" by
  the psalm he quotes: lawless deeds forgiven, sins covered, sin not counted. The
  righteousness counted to the ungodly is described, in Paul's own argument, as
  sin not counted. -/
  | countedRighteousnessIsSinNotCounted
  /-- Christ's death for our sins is the whole ground of justification: nothing
  added to it completes it, and to add a ground is to preach another gospel.
  **Paul's gospel, as Galatians reads it.** -/
  | christsWorkIsTheWholeGround
  /-- Luke 18:9–14 — the Pharisee lists his fasting and his tithes; the tax
  collector stands far off, beats his breast, and prays "God, be merciful to me,
  a sinner"; and Jesus says that he, "rather than the other", went down to his
  house justified. -/
  | luke18_9_14TaxCollectorJustified
  /-- δεδικαιωμένος at Luke 18:14 is God's verdict: the tax collector goes home
  accepted as righteous before God. What δικαιόω means here, in Jesus' own
  parable — not a claim about what else God gives with the verdict. -/
  | luke18JustifiedIsVerdict
  /-- The tax collector brings no works that merit, only a humble and contrite
  plea for mercy; the Pharisee's works (18:11–12) do not justify him. His humility is in
  the text, and this does not deny it: it says what he brings, not what his
  humility is. -/
  | taxCollectorBringsNoWorks
  /-- Matthew 7:21–23 — not everyone who says "Lord, Lord" enters the kingdom,
  but the one who does the will of the Father; to those who prophesied and did
  mighty works in his name, "I never knew you". The criterion at the judgment is
  doing the Father's will, not profession or mighty works. The text names no
  faith. -/
  | matthew7_21_23DoingTheWill
  /-- **The Catholic reading of Matthew 7:21–23**: the passage condemns
  professing without obeying, and doing the Father's will is a condition of
  entering the kingdom in its own right, not only the fruit of faith. -/
  | matthew7ObedienceIsAGround
  /-- **The Reformed reading of Matthew 7:21–23**: to do the Father's will
  includes believing in Christ, and "I never knew you" means he never counted
  them his own — no union with him by faith, whatever they did in his name. -/
  | matthew7DoingIncludesBelieving
  /-- Matthew 19:16–22 — asked what good deed he must do to have eternal life,
  Jesus tells the young man "If you would enter life, keep the commandments";
  told to sell what he has and follow, he goes away sorrowful. Trent quotes
  19:17 (Session VI, ch. 7). -/
  | matthew19_17KeepTheCommandments
  /-- **The Catholic reading of Matthew 19:17**: keeping the commandments is the
  way to life — "God's commandments show man the path of life and they lead to
  it" (*Veritatis Splendor* 12) — possible only by grace. -/
  | matthew19CommandmentsAreTheWayToLife
  /-- **The Reformed reading of Matthew 19:17**: Christ answers on the law's own
  terms, what the righteousness of works requires, so that the young man, seeing
  he has not kept it, may turn to faith. Calvin: "this reply of Christ is
  legal". -/
  | matthew19LawExposesInability
  -- Baptism. Each sense of the word is its own atom — water, the Spirit, and
  -- "fire" — so that no argument can pass from one to another unnoticed.
  /-- **Water.** Christ commands baptism with water: "baptizing them in the name
  of the Father and of the Son and of the Holy Spirit" (Matthew 28:19); "repent
  and be baptized" (Acts 2:38). His ordinance, not a commandment of men. -/
  | baptismCommandedByChrist
  /-- Water baptism is the instrumental cause of justification: "the
  instrumental cause is the sacrament of baptism, which is the sacrament of
  faith" (Trent, Session VI, ch. 7). Trent's claim, as a claim about what
  justifies. -/
  | baptismIsInstrumentalCause
  /-- The washing itself is necessary for salvation: desire for baptism may
  justify, but whoever dies without the water is not saved — not the
  catechumen who dies desiring it. Feeney's reading: "It is now: Baptism of
  Water, or damnation!" -/
  | waterItselfNecessaryForSalvation
  /-- Justification "cannot be effected, without the laver of regeneration, or
  the desire thereof" (Trent, Session VI, ch. 4). Trent's own qualification. -/
  | baptismOrItsDesire
  /-- Where only the desire for baptism is present, it "brings about the fruits
  of Baptism without being a sacrament" (Catechism 1258): what justifies then
  is not the washing. Rome's own teaching. -/
  | desireBringsFruitsWithoutTheSacrament
  /-- Luke 23:43 — to the thief on the cross, unbaptised, "Truly, I say to you,
  today you will be with me in paradise". -/
  | luke23_43ThiefPromisedParadise
  /-- The thief's case bears on salvation under the Gospel, not only on the time
  before baptism was commanded. The ground the argument from the thief needs:
  held by Augustine, and by Aquinas quoting him; a reader who holds the washing
  itself necessary for salvation must deny it. -/
  | thiefBearsOnTheGospel
  /-- **The Spirit.** Acts 8:14–17 — the Samaritans, baptized in Jesus' name,
  receive the Spirit afterwards, when Peter and John lay hands on them. -/
  | acts8WaterThenSpirit
  /-- Acts 10:44–48 — the Spirit falls on Cornelius's household while Peter is
  still speaking, and they are baptized afterwards. -/
  | acts10SpiritThenWater
  /-- God is not bound to water baptism: he gives the Spirit before it and after
  it. "God has bound salvation to the sacrament of Baptism, but he himself is
  not bound by his sacraments" (Catechism 1257). Common ground. -/
  | godNotBoundToWater
  /-- John 3:5 — "unless one is born of water and the Spirit, he cannot enter the
  kingdom of God". -/
  | john3_5WaterAndSpirit
  /-- John 3:5 requires water baptism for entry into the kingdom. Trent: whoever
  "wrests, to some sort of metaphor" these words is anathema (Session VII, On
  Baptism, canon 2). -/
  | john3_5RequiresWaterBaptism
  /-- The water of John 3:5 is baptismal water. -/
  | john3_5WaterIsBaptism
  /-- The water of John 3:5 is natural birth — the waters of the womb — set
  beside birth from the Spirit. -/
  | john3_5WaterIsNaturalBirth
  /-- The water of John 3:5 is the cleansing promised in Ezekiel 36:25–27 — clean
  water sprinkled, and a new spirit put within — and not Christian baptism. -/
  | john3_5WaterIsEzekielsCleansing
  /-- The water of John 3:5 is the Spirit's own cleansing: "water and Spirit" name
  one thing. Calvin: "this water is the Spirit who cleanseth us anew". -/
  | john3_5WaterIsTheSpiritsCleansing
  /-- **Fire.** Matthew 3:11 (Luke 3:16) — "he will baptize you with the Holy
  Spirit and fire". What the fire is, the text does not say. -/
  | matthew3_11SpiritAndFire
  /-- The fire of Matthew 3:11 is judgment: the chaff burned with unquenchable
  fire (3:12). -/
  | fireIsJudgment
  /-- The fire of Matthew 3:11 is purification: the Spirit takes away our
  pollution as fire purifies gold. -/
  | fireIsPurification
  /-- The fire of Matthew 3:11 is Pentecost: "divided tongues as of fire" (Acts
  2:3). -/
  | fireIsPentecost
deriving DecidableEq, Repr

end Testimony.Arguments.SolaFide
