import TestimonyArguments.Attr
import Testimony.Logic.Notation
import Testimony.Scripture

/-!
# TestimonyArguments.SolaFide.Atoms — the claims

Every claim the chapters use is listed here once, with the number every formula
calls it by: the verses, the disputed readings of them, who wrote the disputed
letters, what the rival positions hold, the premises that answer James, and the
three parts of the conclusion. The table gives each claim's kind, who holds it
and how firmly, and the sources that carry it. Behind the table, each claim's
own description, and the reasoning for each source and rating, are kept for a
reader who wants to check one.
-/

namespace TestimonyArguments.SolaFide

open Testimony

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
  /-- Paul's "works of the law" (ἔργα νόμου) means human works in general, and not
  only the practices that marked Jews off from gentiles. **The first disputed
  reading in Paul's strand.** -/
  | worksOfLawMeansWorksGenerally
  /-- "Faith of Christ" (πίστις Χριστοῦ) in Galatians 2:16, and at Romans 3:22 and
  Philippians 3:9, means our faith *in* Christ, and not Christ's own
  faithfulness. Grammarians call the first an objective genitive and the second
  a subjective one. **The second disputed reading in Paul's strand.** It is what
  makes the believer's faith, and not only the exclusion of works, part of what
  Galatians 2:16 says. -/
  | pistisChristouObjective
  /-- Galatians is written against requiring believers to be circumcised, in
  addition to believing, as a condition of justification (Galatians 2:3–5,
  5:2–4). -/
  | galatiansOpposesCircumcisionAsRequirement
  /-- Acts 15:9–11 — at the Jerusalem council, answering the demand that
  gentile believers be circumcised and keep the law of Moses (15:1, 15:5), Peter
  says that God cleansed their hearts by faith, and that "we believe that we
  will be saved through the grace of the Lord Jesus, just as they will". -/
  | acts15_9_11
  /-- The yoke Peter refuses at Acts 15:10, one "that neither our fathers nor we
  have been able to bear", is the law as a whole taken as a condition of
  salvation, and not only Israel's marks of belonging. **The disputed reading in
  Peter's strand.** -/
  | acts15YokeIsLawAsCondition
  /-- Acts 15:20–21 and 21:20–24. The council's decree lays on gentile believers
  part of what the law of Moses requires, and the Jewish believers in Jerusalem
  are "all zealous for the law". This is Jervell's reason for reading Luke as
  holding to the law. -/
  | lukeKeepsTheLaw
  /-- Ephesians was written by Paul. -/
  | ephesiansIsPauline
  /-- Titus was written by Paul. -/
  | titusIsPauline
  /-- 1 Peter was written by the apostle Peter. -/
  | firstPeterIsPetrine
  /-- 2 Peter was written by the apostle Peter. -/
  | secondPeterIsPetrine
  /-- "The righteousness of God" (δικαιοσύνη θεοῦ) in Romans names God's act of
  rescuing the world in Christ, and not a standing given to those who meet the
  condition of faith. The apocalyptic reading (Martyn, Campbell). -/
  | righteousnessOfGodIsDeliverance
  /-- Luke 7:50 — Jesus tells the woman who anointed him, "your faith has saved
  you", immediately after declaring her sins forgiven. -/
  | luke7_50FaithHasSavedYou
  /-- "Saved" (σῴζω) at Luke 7:50 means saved from sin, and not healed of an
  illness. **The reading of the word that Luke's strand needs.** -/
  | sozoIsSoteriological
  /-- Luke 7:47, "her sins, which are many, are forgiven—for she loved much": her
  love is the evidence of her forgiveness, not its cause. The rest of the verse
  ("he who is forgiven little, loves little") and the parable of the two debtors
  (7:41–43) put the forgiveness first and the love after it. This is the
  Reformed answer to reading 7:47 as salvation by love. -/
  | luke7_47LoveIsEvidence
  /-- James 2:14–26 is aimed at a barren faith, mere assent, which "even the demons"
  have (2:19), and not at Paul's teaching on justification. -/
  | james2TargetsDeadFaith
  /-- Good works are the fruit and evidence of saving faith, not a ground of
  justification. -/
  | worksAreFruitNotGround
  /-- James 2:24 does not contradict Paul: the two use "justify" and "faith" in
  different senses. -/
  | james2_24Compatible
  /-- James 2:24: "You see that a person is justified by works and not by faith
  alone." This is what the verse says, in its own words. What its "justified"
  and "faith" mean is the question `james2_24Compatible` answers. -/
  | james2_24NotByFaithAlone
  /-- Scripture does not contradict itself. -/
  | scriptureSelfConsistent
  /-- Justification is by faith alone. -/
  | justificationByFaithAlone
  /-- Faith is sufficient: whoever believes is saved. This is weaker than faith
  alone. It says that faith saves, not that nothing else is a condition. It is
  all that Luke 7:50 and Peter at Jerusalem say. -/
  | faithIsSufficient
  /-- Salvation is by grace: a gift, not wages owed. **First part of the
  conclusion.** -/
  | salvationByGrace
  /-- Salvation is not by works: no work, however done, is its ground. **Second part
  of the conclusion**, and the one Trent denies. -/
  | salvationNotByWorks
  /-- Salvation is received through faith: faith is the means by which it is
  received. **Third part of the conclusion**, and the one the apocalyptic
  reading does not reach. -/
  | salvationThroughFaith
  /-- Justification is a verdict and nothing more ("forensic only"): God pardons,
  and counts Christ's righteousness to the believer. It is not righteousness
  poured into the person. This is the Reformed account of what justification
  *is*. Trent denies it, and so does the Finnish reading of Luther. -/
  | justificationIsForensicOnly
  /-- Judaism in Paul's day held that one enters the covenant by grace and stays in
  it by obedience. Sanders named this *covenantal nomism*. -/
  | secondTempleCovenantalNomism
  /-- Works done in grace merit an increase of justification. Trent's claim. -/
  | worksMeritIncreaseOfJustification
  /-- Justification is "not remission of sins merely, but also the sanctification
  and renewal of the inward man". **Trent's definition of what justification
  is.** Its objection to "not by works" follows from it. -/
  | justificationIncludesSanctification
  /-- Justification and sanctification cannot be separated and are not the same
  thing. Justification is God's pardon and acceptance. Sanctification is the
  renewal that follows. **The Reformed distinction**, which Trent's definition
  denies. -/
  | justificationDistinctFromSanctification
  /-- The inward renewal of the justified grows as they do good works in grace. Both
  sides accept this. Trent calls the growth an increase of justification, and
  the Reformed call it sanctification. -/
  | renewalGrowsThroughGoodWorks
  /-- John 6:28–29 — asked what they must do to be doing the works of God, Jesus
  answers: "This is the work of God, that you believe in him whom he has sent."
  -/
  | john6_29WorkIsBelieving
  /-- John 3:16–18, 3:36, 5:24 and 20:31 — eternal life, and passing out of
  judgement, through believing in the Son. -/
  | johnLifeThroughBelieving
  /-- John 3:36 — "Whoever believes in the Son has eternal life; whoever does not obey
  the Son shall not see life, but the wrath of God remains on him." The opposite
  of believing is put, in Greek, as not obeying (ὁ ἀπειθῶν). Every reader here
  grants the wording. -/
  | john3_36WhoeverDoesNotObey
  /-- The obedience John 3:36 sets beside believing, and the doing of the
  Father's will in Matthew 7:21, are sanctification: the inward and outward life
  of good works that follows faith as its fruit and evidence. They are
  necessary, and they are not the ground or basis of justification. **The
  Reformed answer to Chrysostom.** -/
  | obedienceIsSanctification
  /-- The believing of John 6:29 is trust in Christ, which brings nothing to God and
  receives righteousness from him. Calvin calls it a "passive work". **The
  disputed reading in John's strand.** -/
  | johannineBelievingIsTrust
  /-- The believing of John 6:29, believing *in* him as the goal one moves toward,
  is faith made alive by love ("formed by charity"), the source of good works.
  Aquinas's reading, and the rival to Calvin's. Trent describes justifying faith
  the same way (Session VI, ch. 7). -/
  | johannineBelievingIsFormedByCharity
  /-- Galatians 3:11–12 — no one is justified before God by the law; and the law
  is not of faith, for "the one who does them shall live by them". -/
  | gal3_11_12LawIsNotOfFaith
  /-- Love of God and neighbour is what the law commands (Deuteronomy 6:5; the two
  great commandments). Both sides accept this: Luther argues from it, and
  Aquinas would not deny it. -/
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
  /-- In Paul, "justify" (δικαιόω) is a courtroom word: to declare righteous, to
  give a verdict. Its opposite is to condemn, as in Deuteronomy 25:1 and Romans
  8:33–34. It does not mean to make a person good. **The premise about the
  word.** -/
  | dikaioIsForensic
  /-- Paul has words of his own for renewal: "renewal" (ἀνακαίνωσις; Titus 3:5,
  Romans 12:2) and "sanctification" (ἁγιασμός; Romans 6:19, 22). He sets them
  beside "justify" and not inside it: "the washing of regeneration and renewal
  of the Holy Spirit … so that being justified by his grace" (Titus 3:5–7); "you
  were washed, you were sanctified, you were justified" (1 Corinthians 6:11). -/
  | paulNamesRenewalOtherwise
  /-- A word adds to a passage the least meaning its context requires. One use of it
  does not carry everything the word can mean elsewhere, or everything the
  doctrine it is used for contains. This is Joos's rule of least meaning, and
  the mistake it guards against is what Barr called "illegitimate totality
  transfer". Silva applies both to the words of the New Testament. **The rule
  for reading a word.** -/
  | leastMeaning
  /-- Paul's word "justify" (δικαιόω) itself means the renewal of the inward person,
  and not only the verdict: to be justified, in Paul's sense of the word, is to
  be made inwardly just. This is Trent's definition, **read as a claim about
  Paul's word**. -/
  | paulsJustifyDenotesRenewal
  /-- When God justifies, he also renews. Pardon and the renewal of the inward
  person are given together and are not to be separated. This is Trent's
  definition, **read as a claim about what God does**. Stated this way, it is
  what the *Joint Declaration* confesses and what Calvin grants. -/
  | justifyingGraceRenews
  /-- Augustine explains Paul's "being justified" as "being made righteous": "by
  Him, of course, who justifies the ungodly man, that he may become a godly one"
  (*On the Spirit and the Letter* 26.45). The Latin West read "justify"
  (*iustificare*) that way after him. This is a claim about what Augustine wrote
  and what the tradition received, not about what Paul meant. -/
  | augustineReadsJustifyAsMakeRighteous
  /-- Romans 4:6–8 says that David speaks of the blessing of the one to whom God
  counts righteousness apart from works: "Blessed are those whose lawless deeds
  are forgiven, and whose sins are covered; blessed is the man against whom the
  Lord will not count his sin." -/
  | romans4_6_8
  /-- "Count" (λογίζομαι) in Romans 4:3–11 is the language of an account: to credit
  something to someone. The wage "is not counted as a gift but as his due"
  (4:4); the one who does not work has faith "counted as righteousness" (4:5). -/
  | logizomaiIsReckoning
  /-- In Romans 4:6–8 Paul explains "God counts righteousness apart from works" by
  the psalm he quotes: lawless deeds forgiven, sins covered, sin not counted. So
  the righteousness counted to the ungodly is described, in Paul's own argument,
  as sin not counted. -/
  | countedRighteousnessIsSinNotCounted
  /-- Christ's death for our sins is the whole ground of justification. Nothing
  added to it completes it, and to add a ground is to preach another gospel.
  **Paul's gospel, as Galatians is read here.** -/
  | christsWorkIsTheWholeGround
  /-- Luke 18:9–14 — the Pharisee lists his fasting and his tithes; the tax
  collector stands far off, beats his breast, and prays "God, be merciful to me,
  a sinner"; and Jesus says that he, "rather than the other", went down to his
  house justified. -/
  | luke18_9_14TaxCollectorJustified
  /-- "Justified" (δεδικαιωμένος) at Luke 18:14 is God's verdict: the tax collector
  goes home accepted as righteous before God. This says what the word means in
  Jesus' own parable. It does not say what else God gives with the verdict. -/
  | luke18JustifiedIsVerdict
  /-- The tax collector brings no works that merit anything, only a humble and
  contrite plea for mercy. The Pharisee's works (18:11–12) do not justify him.
  The tax collector's humility is in the text, and this claim does not deny it:
  it says what he brings, not what his humility is. -/
  | taxCollectorBringsNoWorks
  /-- Matthew 7:21–23. Not everyone who says "Lord, Lord" enters the kingdom, but
  the one who does the will of the Father. To those who prophesied and did
  mighty works in his name: "I never knew you". The test at the judgement is
  doing the Father's will, not profession or mighty works. The passage does not
  mention faith. -/
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
  /-- The thief's case bears on salvation under the Gospel, and not only on the time
  before baptism was commanded. The argument from the thief needs this.
  Augustine holds it, and Aquinas quotes him. A reader who holds that the
  washing itself is necessary for salvation must deny it. -/
  | thiefBearsOnTheGospel
  /-- **The Spirit.** Acts 8:14–17 — the Samaritans, baptized in Jesus' name,
  receive the Spirit afterwards, when Peter and John lay hands on them. -/
  | acts8WaterThenSpirit
  /-- Acts 10:44–48 — the Spirit falls on Cornelius's household while Peter is
  still speaking, and they are baptized afterwards. -/
  | acts10SpiritThenWater
  /-- God is not bound to water baptism: he gives the Spirit before it and after it.
  "God has bound salvation to the sacrament of Baptism, but he himself is not
  bound by his sacraments" (Catechism 1257). Both sides accept this. -/
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
  -- James, and the increase of justification. See `SolaFide.James`.
  /-- James 2:14–26 — faith that has no works cannot save (2:14); "faith by
  itself, if it does not have works, is dead" (2:17); "faith apart from works is
  dead" (2:26). What the text says. -/
  | james2FaithWithoutWorksIsDead
  /-- James 2:21–25 — Abraham "justified by works when he offered up his son
  Isaac" (Genesis 22), by which the Scripture (Genesis 15:6), spoken years before,
  "was fulfilled" (2:23); Rahab "justified by works" when she received the
  messengers (2:25). What the text says. -/
  | james2JustifiedByWorks
  /-- Outside Paul, "justify" (δικαιόω) declares, acquits or vindicates. The judges
  "justify the righteous and condemn the wicked" (Deuteronomy 25:1). "Wisdom is
  justified by her deeds" (Matthew 11:19, ESV; "deeds" translates ἔργα, the word
  James uses for "works"): shown to be in the right by what she does. It does
  not mean making a person inwardly righteous. **The premise about the word, for
  James.** -/
  | dikaioIsDeclarativeOutsidePaul
  /-- James's "justified by works" (δικαιόω; 2:21, 24, 25) means the increase of the
  justice already received: being made more just. **The Catholic reading of
  James's word**, which is Trent's (Session VI, ch. 10). On it, James 2:24
  teaches the increase of justification. -/
  | jamesJustifyDenotesIncrease
  /-- The "faith alone" that James 2:24 denies justifies is the faith of 2:14–26:
  faith apart from works, which James calls dead (2:17, 2:26). -/
  | jamesFaithAloneIsDeadFaith
  /-- The faith the Reformers say alone justifies is "no dead faith, but worketh
  by love": "the alone instrument of justification: yet is it not alone in the
  person justified" (Westminster XI.2). What the formula *sola fide* means, in
  its framers' words. -/
  | reformedFaithIsNoDeadFaith
  /-- "Faith" in James 2:24's "not by faith alone" is not the faith of the
  Reformers' *sola fide*: the phrase James denies is not the formula they
  affirm. -/
  | jamesFaithIsNotReformedFaith
  /-- Scripture teaches that the justice received increases by good works — an
  **increase of justification** (Trent, Session VI, ch. 10; canon 24). -/
  | scriptureTeachesIncreaseOfJustification
  /-- Good works done in grace are a cause of the increase of justification, and not
  merely its fruits and signs (Trent, Session VI, canon 24). **The Catholic
  reading of what works do.** It is a claim about God's verdict, not about a
  word. -/
  | worksCauseIncreaseOfJustification
  /-- The text of Revelation 22:11 — what its inspired author wrote — says "He that
  is just, let him be justified still" (the Vulgate's *iustificetur adhuc*).
  Trent's "as it is written" (Session VI, ch. 10), read as a claim about the
  inspired text. -/
  | rev22_11BeJustifiedStill
  /-- The Greek text of Revelation 22:11, as the critical editions print it, says
  "let the righteous still do righteousness" (δικαιοσύνην ποιησάτω ἔτι): it has
  no "be justified". -/
  | rev22_11GreekDoRighteousness
  /-- The text of Sirach 18:22 — what its inspired author wrote — says "Be not
  afraid to be justified even to death" (the Vulgate's verse). Trent's "as it is
  written", read as a claim about the inspired text. -/
  | sir18_22BeJustifiedToDeath
  /-- Sirach 18:22, in the Greek, is about paying a vow promptly. It says "let
  nothing hinder you from paying a vow in due time, and do not wait until death
  to be justified" (μὴ μείνῃς ἕως θανάτου δικαιωθῆναι), which the Catholic
  Church's own translation renders "do not wait until death to fulfill them". It
  has the verb "to be justified". It does not say "be not afraid", and it does
  not say "pray always", as the Vulgate does. -/
  | sir18_22GreekIsAVow
  /-- The original text, "written by the inspired author himself, has more authority
  and greater weight than any even the very best translation" (Pius XII, *Divino
  Afflante Spiritu* §16). So a reading the original lacks is not the inspired
  author's word. Westminster says the same of the originals, which are
  "authentical" and to which the Church is "finally to appeal" (I.8). **The
  principle about texts.** -/
  | originalTextDecides
  /-- The Vulgate, "in the sense in which the Church has understood and
  understands it", is "free from any error whatsoever in matters of faith and
  morals", and "may be quoted safely and without fear of error in disputations";
  its authenticity is "not ... primarily ... critical, but rather ... juridical"
  (*Divino Afflante Spiritu* §21, on Trent's Session IV). -/
  | vulgateFreeFromDoctrinalError
  /-- Trent's "as it is written" at Revelation 22:11 and Sirach 18:22 quotes the
  Vulgate as the Church's approved text: a reading free from error in faith, to
  be used in teaching. It does not quote it as what the inspired authors wrote.
  This is Trent's citation, **read as Pius XII reads Trent's decree on the
  Vulgate**. -/
  | trentQuotesTheVulgateJuridically
  /-- A doctrine taught from the Vulgate is to be confirmed from the original
  texts: its authority "by no means prevents — nay rather today it almost
  demands — ... the corroboration and confirmation of this same doctrine by the
  original texts" (*Divino Afflante Spiritu* §22). -/
  | doctrineToBeConfirmedFromOriginals
  /-- Revelation 22:11 and Sirach 18:22 confirm, from the original texts, the
  increase of justification Trent quotes them for. -/
  | latinTextsConfirmedFromOriginals
  -- The Westminster Assembly's proof texts for works as fruit (XVI.2, XVI.5).
  /-- Ephesians 2:10 — "we are his workmanship, created in Christ Jesus for good
  works, which God prepared beforehand, that we should walk in them", following
  "not a result of works, so that no one may boast" (2:9). -/
  | ephesians2_10CreatedForGoodWorks
  /-- James 2:18, 22 — "I will show you my faith by my works"; "faith was active
  along with his works, and faith was completed by his works". -/
  | james2_18ShowFaithByWorks
  /-- Romans 6:22 — "the fruit you get leads to sanctification and its end,
  eternal life". -/
  | romans6_22FruitToSanctification
  /-- Luke 17:10 — "when you have done all that you were commanded, say, 'We are
  unworthy servants; we have only done what was our duty.'" -/
  | luke17_10UnworthyServants
  -- The texts Trent cites for the reward of good works (Session VI, ch. 16).
  /-- 1 Corinthians 15:58, Hebrews 6:10, Hebrews 10:35 and 2 Timothy 4:8 — "in
  the Lord your labor is not in vain"; "God is not unjust so as to overlook your
  work"; "your confidence, which has a great reward"; "the crown of
  righteousness, which the Lord, the righteous judge, will award to me". -/
  | rewardTextsPromiseReward
  /-- James's "justify" (δικαιόω) has the sense Paul's has. The "justified" of James
  2:24 is the justification of Romans and Galatians, and not a second use of the
  word meaning "shown to be right". -/
  | jamesUsesDikaioAsPaul
  /-- The reward God renders to the good works of the justified is rendered to
  them as merits: by those works they "have truly merited eternal life" (Trent,
  Session VI, ch. 16; canon 32). -/
  | rewardRenderedToMerits
  /-- 1 Peter 2:5 — "a holy priesthood, to offer spiritual sacrifices acceptable to
  God through Jesus Christ". -/
  | firstPeter2_5AcceptableThroughChrist
  -- Whether justification has degrees: a verdict, and Trent's increase.
  /-- Justification admits of more and less: the justified "increase in that
  justice which they have received ... and are still further justified"
  (Trent, Session VI, ch. 10). **What Trent's increase of justification
  requires.** -/
  | justificationHasDegrees
  /-- Deuteronomy 25:1 and Proverbs 17:15 — "the judges decide between them,
  acquitting the innocent and condemning the guilty"; "He who justifies the
  wicked and he who condemns the righteous are both alike an abomination to the
  LORD". -/
  | deut25_1JudgesAcquitOrCondemn
  /-- A verdict acquits or condemns, and has no degrees: one is not more or less
  acquitted. **The courtroom reading of "justify"**, applied to the verdict
  itself. -/
  | verdictAdmitsNoDegrees
  -- Abraham, counted righteous: Genesis 15, and the reading tied to Genesis 22.
  /-- Genesis 15:6 — "And he believed the LORD, and he counted it to him as
  righteousness." -/
  | gen15_6AbramBelieved
  /-- Genesis 15:12, 17 — "a deep sleep fell on Abram"; "a smoking fire pot and a
  flaming torch passed between these pieces". Only the fire and the torch pass
  between the pieces; Abram is asleep. -/
  | gen15_17GodAlonePasses
  /-- Romans 4:10 — "How then was it counted to him? Was it before or after he
  had been circumcised? It was not after, but before he was circumcised." -/
  | romans4_10BeforeCircumcision
  /-- The covenant of Genesis 15 binds God alone: he alone passes between the
  pieces, as one who swears an oath on his own life (compare Jeremiah 34:18), and
  "he swore by himself" (Hebrews 6:13). **The Reformed reading of the
  ritual.** -/
  | gen15CovenantIsGodsOathAlone
  /-- Abraham was counted righteous on believing, and nothing he did was a
  condition of it. **The Reformed conclusion from Genesis 15.** -/
  | abrahamCountedRighteousWithoutWorks
  /-- Genesis 22:16–18 and 26:5 — "because you have done this and have not
  withheld your son"; "because Abraham obeyed my voice and kept my charge, my
  commandments, my statutes, and my laws". -/
  | gen22_16BecauseYouObeyed
  /-- 1 Maccabees 2:52 and Sirach 44:20, in the NABRE — "Was not Abraham found
  faithful in trial, and it was credited to him as righteousness?"; "when tested
  was found loyal". Two Jewish writings of the second century before Christ,
  which tie the counting of Genesis 15:6 to Abraham's testing in Genesis 22. -/
  | abrahamFoundFaithfulWhenTested
  /-- A royal grant in the ancient Near East was "a reward for loyalty and good
  deeds already performed" (Weinfeld). -/
  | grantRewardsPastLoyalty
  /-- The grant God made to Abraham rewarded his obedience: "because you have
  obeyed my voice" (Genesis 22:18; 26:5). **Weinfeld's reading of Abraham's
  covenant.** -/
  | abrahamsGrantRewardsHisObedience
  /-- The righteousness counted to Abraham at Genesis 15:6 was credited for his
  faithfulness when he was tested in Genesis 22. **The reading 1 Maccabees 2:52
  gives Genesis 15:6.** -/
  | countingWasForTheTesting
  /-- The blessing sworn in Genesis 22:16–18 was augmented because of Abraham's
  obedience: "Contingent upon his obedience, every aspect of the earlier promises
  to Abraham is now 'augmented and guaranteed'" (Kuruvilla). -/
  | aqedahBlessingAugmentedForObedience
  /-- The covenant oath of Genesis 22:16–18, to bless the nations through
  Abraham's seed, was merited by the binding of Isaac (Hahn). -/
  | aqedahOathMeritedByObedience
deriving DecidableEq, Repr

end TestimonyArguments.SolaFide
