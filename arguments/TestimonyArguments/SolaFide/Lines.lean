import TestimonyArguments.SolaFide.Atoms
import Testimony.Logic.Line
import TestimonyArguments.Works

/-!
# TestimonyArguments.SolaFide.Lines — the strands, and what they share

Four strands lead to the conclusion, each from a different speaker: Paul, Jesus
as Luke reports him, Peter at Jerusalem, and Jesus as John reports him. Each is
credited only with what its own texts say. Paul and John say that justification
is by faith *alone*. Luke 7:50 and Acts 15 say that faith *suffices*, which is
less, and is all that "through faith" in the conclusion needs.

Two further lines are here. One answers James 2:24. The other is the
apocalyptic reading of Paul, which denies what Paul's strand delivers.

What every package holds in common is collected here too, so that a variant
package is a named difference from another and not a retyped list.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Lines of reason

Four strands lead to the conclusion, and a fifth line answers James. The
strands do not all deliver the same thing.

Paul argues for *alone*. His letter refuses circumcision added to faith, and
Galatians 2:16 names faith as the one means ("not justified by works of the law
but through faith", ἐὰν μή). John's strand delivers the same: asked what works
God requires, Jesus names believing and nothing else (John 6:28–29).

Luke 7:50 and Acts 15 say that faith saves, and that the woman's love and the
law's yoke are not what saves. They do not say that nothing else could. So
those two strands deliver `faithIsSufficient`, the weaker claim.

The difference matters when the positions are weighed against each other. A
case is attacked on what it derives as well as on what it assumes. Credit Luke
with *alone*, and the apocalyptic reading, which denies faith alone, would
attack Luke on a claim Luke never made.

The answer to James is deliberately *not* a strand. It is not another route to
`justificationByFaithAlone`; it supplies a premise the closing step needs. So
it adds its grounds and its step to the case without being one of the lines
that `caseOf` treats as arriving at the same place. -/

/-- **Paul's strand.** From Romans and Galatians to justification by faith alone,
with Galatians 2:16 at the centre: "a person is not justified by works of the
law but through faith in Jesus Christ."

Each premise does its own work. Galatians 2:16 excludes works of the law. Read
as "faith *in* Christ", it also names the believer's faith as the means. The
letter's occasion says what is being refused: circumcision *added to* faith as a
requirement. That is where *alone* comes from. The Galatians already believed,
and Paul says that adding a work to their faith severs them from Christ (5:4).
Only the reading of "works of the law" as works in general lets circumcision
stand for every work, and not for one mark of being a Jew. -/
@[solaFideDefs]
def paulineToFaithAlone : Formula Claim :=
  ⋀ [ p .romans3_28, p .galatians2_16, p .galatiansOpposesCircumcisionAsRequirement
    , p .pistisChristouObjective, p .worksOfLawMeansWorksGenerally ]
  ➝ p .justificationByFaithAlone

/-- **Luke's strand.** From Jesus' words at Luke 7:50, "your faith has saved you",
to the claim that faith suffices. It needs two readings. The word "saved" (σῴζω)
means saved there, not healed. And "for she loved much" (7:47) gives the
evidence of her forgiveness, not its cause, so that what Jesus names as saving
her is her faith.

The strand says that her faith saved her, and no more. It does not say that
nothing else could have. It owes nothing to Paul or to the dispute over "works
of the law". -/
@[solaFideDefs]
def dominicalToSufficiency : Formula Claim :=
  ⋀ [p .luke7_50FaithHasSavedYou, p .sozoIsSoteriological, p .luke7_47LoveIsEvidence]
    ➝ p .faithIsSufficient

/-- **Peter's strand.** From Peter's speech at the Jerusalem council to the claim
that faith suffices.

The council answers the demand Galatians answers: circumcision and the law of
Moses as a condition of salvation (Acts 15:1, 15:5). Peter replies that God
cleansed the gentiles' hearts by faith, that Jew and gentile alike are saved
through grace, and that the yoke should not be laid on them. If the yoke is the
whole law as a condition of salvation, then the gentiles are saved without it,
by faith. That is the reading the strand needs. -/
@[solaFideDefs]
def apostolicToSufficiency : Formula Claim :=
  ⋀ [p .acts15_9_11, p .acts15YokeIsLawAsCondition] ➝ p .faithIsSufficient

/-- **The Johannine strand.** From John's Gospel to justification by faith
alone. The crowd asks what they must do "to be doing the works of God", and
Jesus answers: "This is the work of God, that you believe in him whom he has
sent" (6:28–29). The Gospel says throughout that eternal life comes through
believing (3:16–18, 3:36, 5:24, 20:31).

The step needs one more premise, and it is the disputed one: that this
believing is trust, which brings nothing of its own to God. Independent of
Paul, of Luke 7:50 and of Acts 15. -/
@[solaFideDefs]
def johannineToFaithAlone : Formula Claim :=
  ⋀ [p .john6_29WorkIsBelieving, p .johnLifeThroughBelieving, p .johannineBelievingIsTrust]
    ➝ p .justificationByFaithAlone

/-- The answer to James. James 2:24 says "a person is justified by works and not by
faith alone". If James is attacking a barren faith, and if works are the fruit
of saving faith and not its ground, then the verse does not contradict Paul. The
agreement is derived from those two premises, not assumed. -/
@[solaFideDefs]
def jamesHarmonisation : Formula Claim :=
  ⋀ [p .james2TargetsDeadFaith, p .worksAreFruitNotGround] ➝ p .james2_24Compatible

/-- **The conclusion**, in three parts: salvation is by grace, not by works, and
through faith. They are stated as three claims and not one, so that a position
can be shown to hold some and deny another. Trent and the apocalyptic reading
each do that, over different parts. -/
@[solaFideDefs]
def solaFide : Formula Claim :=
  ⋀ [p .salvationByGrace, p .salvationNotByWorks, p .salvationThroughFaith]

/-- The first two parts: by grace, and not by works. This is what the apocalyptic
reading keeps. -/
@[solaFideDefs]
def graceNotWorks : Formula Claim :=
  ⋀ [p .salvationByGrace, p .salvationNotByWorks]

/-- *By grace*, from the verses that say so: "by grace you have been saved… it is
the gift of God" (Ephesians 2:8), a gift and not wages (Romans 4:4–5),
"according to his own mercy" (Titus 3:5). This part needs neither a strand nor
the answer to James. -/
@[solaFideDefs]
def toGrace : Formula Claim :=
  ⋀ [p .ephesians2_8_9, p .romans4_4_5, p .titus3_5] ➝ p .salvationByGrace

/-- *Not by works*, from the same verses, which say "not a result of works" in as
many words. It needs two more things: an answer to James 2:24, and that
Scripture does not contradict itself. It needs no strand. -/
@[solaFideDefs]
def toNotByWorks : Formula Claim :=
  ⋀ [ p .ephesians2_8_9, p .romans4_4_5, p .titus3_5
    , p .james2_24Compatible, p .scriptureSelfConsistent ]
  ➝ p .salvationNotByWorks

/-- If justification is by faith alone, then faith suffices: if nothing but faith is
the condition, faith is enough. This is how Paul's strand and John's, which
argue the stronger claim, reach the part of the conclusion that Luke's and
Peter's reach directly. -/
@[solaFideDefs]
def faithAloneSuffices : Formula Claim :=
  p .justificationByFaithAlone ➝ p .faithIsSufficient

/-- *Through faith*, from the claim that faith suffices together with Ephesians 2:8,
"through faith" (διὰ πίστεως), which names faith as the means. This is the only
part of the conclusion the four strands are needed for, and it needs only what
each of them says. -/
@[solaFideDefs]
def toThroughFaith : Formula Claim :=
  ⋀ [p .faithIsSufficient, p .ephesians2_8_9] ➝ p .salvationThroughFaith

/-- Paul's line of argument. What is distinctive to it is the reading of Galatians
as a letter against requiring circumcision, and two disputed readings: of "works
of the law" (ἔργα νόμου) and of "faith in Christ" (πίστις Χριστοῦ). The verses
it reads are shared with every other position, which is why denying one of the
readings does not cost the argument its texts.

The question of "faith in Christ" is a premise *inside* this strand, not a
strand of its own. Every verse with the phrase sets it against the law, so any
route through it still has to say what "works of the law" means. -/
@[solaFideDefs]
def paulineLine : Line Claim :=
  { name := "Pauline strand (ἔργα νόμου, πίστις Χριστοῦ)"
  , grounds :=
      [ p .galatiansOpposesCircumcisionAsRequirement, p .worksOfLawMeansWorksGenerally
      , p .pistisChristouObjective ]
  , step := paulineToFaithAlone
  , delivers := p .justificationByFaithAlone }

/-- Luke's line of argument, resting on Jesus' words and not Paul's. What is
distinctive to it is the reading of "saved" at Luke 7:50, and the reading of
7:47 on which the woman's love is not the cause of her forgiveness. -/
@[solaFideDefs]
def dominicalLine : Line Claim :=
  { name := "Dominical strand (σῴζω at Luke 7:50)"
  , grounds := [p .sozoIsSoteriological, p .luke7_47LoveIsEvidence]
  , step := dominicalToSufficiency
  , delivers := p .faithIsSufficient }

/-- Peter's line of argument, as Luke reports him. What is distinctive to it is the
reading of the yoke.

It shares no premise with Paul's line. That does not make the two independent in
practice. A reader who takes "works of the law" as the marks of Israel will read
Peter's yoke the same way, as Jervell does, so the two readings tend to be won
or lost together. The encoding shows only that they are two premises about two
texts, and an opponent has to answer both. -/
@[solaFideDefs]
def apostolicLine : Line Claim :=
  { name := "Apostolic strand (Acts 15:7–11)"
  , grounds := [p .acts15YokeIsLawAsCondition]
  , step := apostolicToSufficiency
  , delivers := p .faithIsSufficient }

/-- Calvin's step from John to justification. John never uses Paul's verb
"justify" (δικαιόω), so passing from "eternal life through believing" to
"justified by faith alone" is an inference and not the reading of a word.
Rated `plausible`: no cited source grants the strand's grounds and denies the
step, but the step rests on Calvin's comment on 6:29 and not on a full argument
from John's vocabulary to Paul's. -/
def calvinOnJohnSix : Source :=
  { primary := .work calvinJohn (.adLoc john6_29)
  , tradition := .reformedProtestant
  , confidence := .plausible }

/-- The Johannine line, resting on Jesus' words in John's Gospel. Its texts are
its own grounds: no other strand reads them. Its distinctive ground is the
reading of believing as trust, which Aquinas denies. -/
@[solaFideDefs]
def johannineLine : Line Claim :=
  { name := "Johannine strand (John 6:29)"
  , grounds :=
      [p .john6_29WorkIsBelieving, p .johnLifeThroughBelieving, p .johannineBelievingIsTrust]
  , step := johannineToFaithAlone
  , delivers := p .justificationByFaithAlone
  , inference := some calvinOnJohnSix }

/-- The line that answers James. It is not a route to the conclusion. It answers the
one verse that appears to stand against it. -/
@[solaFideDefs]
def jamesLine : Line Claim :=
  { name := "Harmonisation of James 2:24"
  , grounds := [p .james2TargetsDeadFaith, p .worksAreFruitNotGround]
  , step := jamesHarmonisation
  , delivers := p .james2_24Compatible }

/-- **The apocalyptic reading** (Martyn, Campbell). If "faith of Christ" is Christ's
own faithfulness, and "the righteousness of God" (δικαιοσύνη θεοῦ) is God's act
of rescue, then faith is not the condition on which a person is justified. So
justification by faith alone, in the sense the Reformed and the New Perspective
share, is denied. Grace and "not by works" are not denied: the reading rejects
the condition, not the gift. -/
@[solaFideDefs]
def deliveranceNotFaithAlone : Formula Claim :=
  ⋀ [notP .pistisChristouObjective, p .righteousnessOfGodIsDeliverance]
  ➝ notP .justificationByFaithAlone

/-- What the apocalyptic reading keeps. If "the righteousness of God" is God's act
of rescue, it is a gift that depends on nothing a person does: by grace, and not
by works. This is Campbell's inference, and his reason for calling the reading
more gracious than the one it replaces. -/
@[solaFideDefs]
def deliveranceIsGrace : Formula Claim :=
  p .righteousnessOfGodIsDeliverance ➝ graceNotWorks

/-- The apocalyptic line: another route from Paul, arriving at the denial of what
Paul's strand delivers. -/
@[solaFideDefs]
def apocalypticLine : Line Claim :=
  { name := "Apocalyptic reading (δικαιοσύνη θεοῦ as deliverance)"
  , grounds := [notP .pistisChristouObjective, p .righteousnessOfGodIsDeliverance]
  , step := deliveranceNotFaithAlone
  , delivers := notP .justificationByFaithAlone }

/-- **The New Perspective's reason** for its reading of "works of the law". Sanders
argued that Judaism in Paul's day taught entry into the covenant by grace and
staying in by obedience ("covenantal nomism"). If so, Paul's opponents were not
trying to earn salvation, and what Paul refuses is not works as such but the
practices that kept gentiles out. The starting point is Sanders'. The inference
is Dunn's, and is cited as his. -/
@[solaFideDefs]
def sandersLine : Line Claim :=
  { name := "Covenantal nomism (Sanders, Dunn)"
  , grounds := [p .secondTempleCovenantalNomism]
  , step := p .secondTempleCovenantalNomism ➝ notP .worksOfLawMeansWorksGenerally
  , delivers := notP .worksOfLawMeansWorksGenerally
  , inference :=
      some
        { primary := .work dunnNewPerspective .whole
        , supporting := [.work wrightWhatPaulSaid .whole]
        , tradition := .criticalScholarship
        , confidence := .disputed } }

/-- **The critics' reply.** If Jewish texts of the period also speak of final
vindication according to works, then the demand Galatians refuses, circumcision
added to faith as a requirement, is a demand for obedience. In refusing it Paul
refuses works as such. So the Reformed reading of "works of the law" is derived
here and not assumed: from the occasion of Galatians, and from a claim about
first-century Judaism that is argued on the evidence. Cited to Gathercole, and
to the volume edited by Carson, O'Brien and Seifrid. -/
@[solaFideDefs]
def criticsLine : Line Claim :=
  { name := "Variegated nomism (Gathercole, Carson et al.)"
  , grounds :=
      [notP .secondTempleCovenantalNomism, p .galatiansOpposesCircumcisionAsRequirement]
  , step :=
      ⋀ [notP .secondTempleCovenantalNomism, p .galatiansOpposesCircumcisionAsRequirement]
      ➝ p .worksOfLawMeansWorksGenerally
  , delivers := p .worksOfLawMeansWorksGenerally
  , inference :=
      some
        { primary := .work gathercoleWhereIsBoasting .whole
        , supporting := [.work carsonVariegatedNomism1 .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }

/-- **Jervell's reading of the yoke.** Luke shows the Jewish believers keeping the
law (Acts 21:20–24), and the council's decree lays part of it on gentiles (Acts
15:20–21). So, Jervell argues, what Peter refuses at 15:10 is the whole of
Israel's law laid on gentiles, and not the law as a condition of salvation. The
step is contested: Bruce accepts both passages and reads the yoke as the law
taken as a condition of salvation. -/
@[solaFideDefs]
def jervellLine : Line Claim :=
  { name := "Law-observant Luke (Jervell)"
  , grounds := [p .lukeKeepsTheLaw]
  , step := p .lukeKeepsTheLaw ➝ notP .acts15YokeIsLawAsCondition
  , delivers := notP .acts15YokeIsLawAsCondition
  , inference :=
      some
        { primary := .work jervellLukePeopleOfGod .whole
        , tradition := .criticalScholarship
        , confidence := .disputed } }

/-- Trent's step from its definition to merit. If justification *is* the renewal of
the inward person, and that renewal grows through good works, then good works
increase justification (Session VI, ch. 10 and canon 24). Rated `consensus`, as
`trentOnMerit` is. The Reformed deny the definition, not the inference, and
canon 24 condemns the Reformed alternative by name: that works are "merely the
fruits and signs of Justification obtained". -/
def trentOnIncrease : Source :=
  { primary := .work tannerDecrees (.sectionRef "Trent, Session VI (1547), canon 24")
  , supporting :=
      [ .work tannerDecrees
          (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 10") ]
  , tradition := .romanCatholic
  , confidence := .consensus }

/-- **Trent's line of argument.** Justification is the renewal of the inward person
and not remission of sins only. That renewal grows through good works. So good
works increase justification (Session VI, ch. 10, canon 24). The Reformed accept
that the renewal grows and deny the definition, so the step carries the
objection only as far as the definition does. -/
@[solaFideDefs]
def tridentineLine : Line Claim :=
  { name := "Trent (justification as renewal)"
  , grounds := [p .justificationIncludesSanctification, p .renewalGrowsThroughGoodWorks]
  , step :=
      ⋀ [p .justificationIncludesSanctification, p .renewalGrowsThroughGoodWorks]
        ➝ p .worksMeritIncreaseOfJustification
  , delivers := p .worksMeritIncreaseOfJustification
  , inference := some trentOnIncrease }

/-- What Trent's definition rules out. Justification as a verdict only (canon 11).
Justification as distinct from the sanctification that follows it. And faith as
sufficient: if justification *is* the renewal of the inward person by charity
poured in, then faith "unless hope and charity be added thereto" does not unite
a person perfectly with Christ (ch. 7), and whoever says that "nothing else is
required to cooperate" is anathema (canon 9). So Trent's denial that faith
suffices is not a separate thesis. It follows from what Trent says justification
is. -/
@[solaFideDefs]
def trentDefinitionSteps : List (Formula Claim) :=
  [ p .justificationIncludesSanctification ➝ notP .justificationIsForensicOnly
  , p .justificationIncludesSanctification ➝ notP .justificationDistinctFromSanctification
  , p .justificationIncludesSanctification ➝ notP .faithIsSufficient ]

/-- The verses the strands read. Every Reformed position shares them, and so does
the New Perspective. -/
@[solaFideDefs]
def prooftexts : List (Formula Claim) :=
  [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .romans4_4_5
  , p .titus3_5, p .luke7_50FaithHasSavedYou, p .acts15_9_11 ]

/-- Everything the strands share: those verses, the two premises that answer James,
and that Scripture does not contradict itself. -/
@[solaFideDefs]
def sharedGrounds : List (Formula Claim) :=
  prooftexts ++ jamesLine.grounds ++ [p .scriptureSelfConsistent]

/-- The same, with James left unanswered. -/
@[solaFideDefs]
def sharedGroundsWithoutJames : List (Formula Claim) :=
  prooftexts ++ [p .scriptureSelfConsistent]

/-- The steps to the three parts of the conclusion, one for each, and the step from
"faith alone" to "faith suffices". -/
@[solaFideDefs]
def conclusionSteps : List (Formula Claim) :=
  [toGrace, toNotByWorks, faithAloneSuffices, toThroughFaith]

/-- The steps that finish the argument: the answer to James, then the steps to the
three parts of the conclusion. -/
@[solaFideDefs]
def closingSteps : List (Formula Claim) := jamesLine.step :: conclusionSteps

/-! ### Paul's gospel, against justification as renewal

Galatians is a letter about another gospel. The teachers Paul opposes did not
deny Christ. They added circumcision to him, and Paul calls that addition a
different gospel and its preachers accursed (1:6–9). Against it he sets what he
received: "Christ died for our sins" (1 Corinthians 15:3); "if righteousness
were through the law, then Christ died for no purpose" (Galatians 2:21); whoever
would be justified by the law is "severed from Christ" (5:2–4).

This line reads those texts as one claim: Christ's work is the whole ground of
justification. With the courtroom sense of Paul's verb "justify", it carries
that claim to the denial of Trent's definition. If justification is God's
verdict on the ground of a finished work, then the renewal worked in us is no
part of it. -/

/-- The reading of the gospel in Galatians: Christ's death is the whole ground of
justification, and to add a ground is to preach another gospel. Cited to Moo on
Galatians and to the Westminster Confession. Rated `disputed`: Trent accepts
every text, and that Christ's passion merited justification (ch. 7), and denies
that nothing is added (canons 24, 32). -/
def galatianGospelReadingSource : Source :=
  { primary := .work mooGalatians (.adLoc ⟨.galatians, 1, 6⟩)
  , supporting := [.work westminsterConfession (.sectionRef "XI.1")]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- The step from "a verdict on Christ's finished work" to "renewal is no part of
justification". Westminster XI.1: God justifies "not by infusing righteousness
into them, but by pardoning their sins, and by accounting and accepting their
persons as righteous; not for anything wrought in them". Rated `disputed`, and
the source that makes it so is Rome's own. The *Joint Declaration* (§22) accepts
the starting point, that God "no longer imputes to them their sin", and denies
the step: forgiveness and the love the Spirit brings about "are not to be
separated". Among New Testament scholars, Gorman takes the same side: the
verdict is a word that does what it says, and changes the person. -/
def verdictNotRenewalSource : Source :=
  { primary := .work westminsterConfession (.sectionRef "XI.1")
  , supporting :=
      [ .work calvinInstitutes (.sectionRef "III.xi.2")
      , .work morrisApostolicPreaching .whole ]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- **Paul's gospel**, as Galatians states it and 1 Corinthians sums it up. -/
@[solaFideDefs]
def galatianGospelLine : Line Claim :=
  { name := "Paul's gospel (Galatians 1:6–9; 2:21; 5:2–4; 1 Corinthians 15:3)"
  , grounds :=
      [ p .galatians1_6_9, p .firstCorinthians15_3, p .galatians2_21, p .galatians5_2_4 ]
  , step :=
      ⋀ [ p .galatians1_6_9, p .firstCorinthians15_3, p .galatians2_21, p .galatians5_2_4 ]
      ➝ p .christsWorkIsTheWholeGround
  , delivers := p .christsWorkIsTheWholeGround
  , inference := some galatianGospelReadingSource }

/-- **The step where Trent parts from Paul.** If justification is God's verdict,
since Paul's verb "justify" (δικαιόω) is a courtroom word whose opposite is
"condemn" (Romans 8:33–34), and if its ground is Christ's finished work alone,
then the renewal of the inward person is no part of it. -/
@[solaFideDefs]
def verdictExcludesRenewal : Formula Claim :=
  ⋀ [p .christsWorkIsTheWholeGround, p .dikaioIsForensic, p .romans8_33_34]
  ➝ notP .justificationIncludesSanctification

/-! ### What Paul's word means

Trent's definition can be read as a claim about Paul's word: that "justify"
(δικαιόω), in Paul, means the renewal of the inward person. This line answers
that reading from the word alone.

The verb is a courtroom word: its opposite is "condemn". Paul has other words
for renewal, and sets them beside it. And a word contributes the least meaning
its context requires. Nothing in the setting of a verdict requires a second,
inward sense, and to supply one from the doctrine is the mistake Barr called
"illegitimate totality transfer": reading into one use of a word everything it
can mean elsewhere. So Paul's "justify" does not mean renewal.

The line says nothing about what God does when he justifies. That is the other
way of reading Trent's definition, and this line does not reach it
(`TestimonyArguments.SolaFide.Definition`). -/

/-- The step from three things to "Paul's 'justify' does not mean renewal": the verb
is a courtroom word; Paul has other words for renewal; and a word contributes
the least meaning its context requires. The method is Silva's, applied as Moo
applies it to Romans. Rated `wellSupported`: no source cited here accepts the
three starting points and denies the conclusion. Those who hold that the verb
means "make righteous", VanLandingham and the Latin tradition from Augustine,
deny the first starting point, and are weighed in that premise's rating. Those
who hold that God's verdict renews, Gorman and the *Joint Declaration*, make a
claim about what God does, not about the word. -/
def leastMeaningSource : Source :=
  { primary := .work silvaBiblicalWords .whole
  , supporting := [.work mooRomans (.sectionRef "p. 80"), .work barrSemantics .whole]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **Paul's word**, read by the rule that a word means no more than its context
requires. -/
@[solaFideDefs]
def lexicalLine : Line Claim :=
  { name := "Paul's word (δικαιόω, by the rule of least meaning)"
  , grounds := [p .dikaioIsForensic, p .paulNamesRenewalOtherwise, p .leastMeaning]
  , step :=
      ⋀ [p .dikaioIsForensic, p .paulNamesRenewalOtherwise, p .leastMeaning]
      ➝ notP .paulsJustifyDenotesRenewal
  , delivers := notP .paulsJustifyDenotesRenewal
  , inference := some leastMeaningSource }

/-! ### Romans 4: the ungodly, justified

An argument from one passage, in two steps.

The first step is about what Paul says. God "justifies the ungodly" (4:5). What
he counts to them is described in the psalm Paul quotes: "blessed are those
whose lawless deeds are forgiven… blessed is the man against whom the Lord will
not count his sin" (4:6–8). "Count" (λογίζομαι) is the language of an account,
set against wages owed (4:4). So, in Paul's own argument, the righteousness
counted to the ungodly is sin not counted. No source cited here accepts the
texts and the sense of the verb and denies that.

The second step puts the first to work, and it goes two ways.

- **Against a claim about Paul's word.** With the rule of least meaning, the
  verb Paul explains in that way does not also mean the renewal of the inward
  person. Rated `wellSupported`, as the argument from the word is.
- **Against a claim about what God does.** That what is counted is sin not
  counted, and that the verdict is a courtroom one, excludes renewal from
  justification. Augustine accepts every word of Romans 4 and reads the verse
  the other way: God "justifies the ungodly man, that he may become a godly one"
  (*On the Spirit and the Letter* 26.45). Trent makes the justice "whereby He
  maketh us just" the formal cause of justification (ch. 7). So that step is
  `disputed`, as the step from Galatians is. -/

/-- The reading of Romans 4:3–8. Paul uses the language of an account ("counted",
λογίζομαι), sets it against wages, and explains what is counted by quoting a
psalm. Cited to Moo on Romans. Rated `wellSupported`: Augustine and Trent accept
the texts and dispute what follows from them, not what Paul says the counting
is. -/
def romansFourExegesisSource : Source :=
  { primary := .work mooRomans (.adLoc ⟨.romans, 4, 6⟩)
  , supporting := [.work bdag (.sectionRef "s.v. λογίζομαι")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- The step from Paul's explanation, with the courtroom sense of the verb, to
"renewal is no part of justification". Cited to Moo on Romans 4:5 and
Westminster XI.1. Rated `disputed`: Augustine accepts the texts and reads
"justifies the ungodly" as making the ungodly godly, and Trent's chapter 7 makes
the justice "whereby He maketh us just" the formal cause of justification. -/
def romansFourReadingSource : Source :=
  { primary := .work mooRomans (.adLoc ⟨.romans, 4, 5⟩)
  , supporting := [.work westminsterConfession (.sectionRef "XI.1")]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- **Romans 4:3–8, read.** God "justifies the ungodly", and the righteousness he
counts to them is, in Paul's own explanation, sin not counted. -/
@[solaFideDefs]
def romansFourExegesisLine : Line Claim :=
  { name := "Romans 4:3–8 (the ungodly, justified)"
  , grounds := [p .romans4_4_5, p .romans4_6_8, p .logizomaiIsReckoning]
  , step :=
      ⋀ [p .romans4_4_5, p .romans4_6_8, p .logizomaiIsReckoning]
      ➝ p .countedRighteousnessIsSinNotCounted
  , delivers := p .countedRighteousnessIsSinNotCounted
  , inference := some romansFourExegesisSource }

/-- From Paul's explanation, by the rule of least meaning: the verb he explains in
that way does not also mean renewal. -/
@[solaFideDefs]
def glossByLeastMeaning : Formula Claim :=
  ⋀ [p .countedRighteousnessIsSinNotCounted, p .leastMeaning]
  ➝ notP .paulsJustifyDenotesRenewal

/-- From Paul's explanation, with the courtroom sense of the verb: renewal is no
part of justification. This is the step Augustine denies. -/
@[solaFideDefs]
def countedExcludesRenewal : Formula Claim :=
  ⋀ [p .countedRighteousnessIsSinNotCounted, p .dikaioIsForensic]
  ➝ notP .justificationIncludesSanctification

end TestimonyArguments.SolaFide
