import TestimonyArguments.SolaFide.Gospel
import Testimony.Logic.Dilemma

/-!
# TestimonyArguments.SolaFide.Definition — what Trent's definition claims

The last chapter found that Trent and Paul part at one step
(`whereTrentPartsFromPaul`). What lies on Trent's side of that step is its
definition:

> justification is "not remission of sins merely, but also the sanctification
> and renewal of the inward man" (Session VI, ch. 7).

The Westminster Confession denies it (XI.1). But the definition can be taken in two ways, as a claim
about a word or as a claim about what God does, and each way meets a different
objection.

### Taken as a claim about Paul's word

On this reading the definition says that "justify" (δικαιόω), in Paul, means
the renewal of the inward person. Trent invites it. Chapter 8 of the decree sets
out how "the Apostle's" words, justified "by faith and freely", are to be
understood, and chapter 7 of the decree says that the justified "are not only
reputed, but are truly called, and are, just". So read, the definition is a
claim about a word, and it meets an answer about the word. The verb is a
courtroom word. Paul
has other words for renewal and sets them beside it (Titus 3:5–7; 1 Corinthians
6:11). And a word contributes the least meaning its context requires (Joos;
Silva). To read renewal into the verdict from the doctrine is what Barr called
"illegitimate totality transfer". Romans 4 gives the same answer from one
passage: Paul explains the righteousness God counts to the ungodly as sin not
counted, and by the same rule the verb he explains in that way does not also
mean renewal.

Every link of that answer is rated above `disputed` but one. The step from the
courtroom sense to "and nothing more" is `disputed`, because Trent grants where
it starts and denies where it ends. Trent keeps the verdict: the justified "are
not only reputed, but are truly called, and are, just". And Augustine gives the
courtroom sense himself, "deemed, or reckoned as just" (*On the Spirit and the
Letter* 26.45), beside "made righteous". Fitzmyer, a modern Catholic exegete,
grants the courtroom sense in the Septuagint and at times in Paul, and still
finds the "effective sense" supported by Romans 5:19, "through the obedience of
one many will be made upright" (*Romans*, 118). Whether the step can rise above
`disputed` turns on that verse, on Romans 6:7 ("freed from sin", or "justified
from sin") and on 1 Corinthians 6:11 ("you were washed, you were sanctified, you
were justified"), which readers take both ways.

### Why Trent would take it so

The council read Paul in the Latin it had declared "authentic" (Session IV), and in Latin "justify"
(*iustificare*) had meant "to make righteous" since Augustine: "what else does
the phrase 'being justified' signify than being made righteous" (*On the Spirit
and the Letter* 26.45). McGrath traces that inheritance through the medieval
West. So this way of taking the definition has a starting point of its own, that
Augustine explained the word so, which is rated `consensus` because he did. It
then needs a step from the Latin explanation to the Greek word. An explanation
in one language does not settle what a word means in another, and the argument
from usage says what the Greek word means in Paul (`whereTheLatinReadingFalls`).
But that argument reaches "and nothing more" only by the `disputed` step above,
so the two cannot be held together, and neither defeats the other outright.

### Taken as a claim about what God does

On this reading the definition says that when God justifies he also renews:
pardon and renewal given together, "not to be separated", as the *Joint
Declaration* (§22) confesses. No argument about the word reaches it. It can be
held with everything the argument from usage says about "justify", and Calvin
himself grants that justification and sanctification cannot be separated. What
still divides Trent from Paul is the step found in the last chapter: that a
verdict on Christ's finished work excludes renewal from justification
(`whereTrentPartsFromPaul`). That step is `disputed`.

Romans 4 leads to the same place by another way, and does not raise the rating.
God "justifies the ungodly" (4:5), and the blessing of righteousness counted
apart from works is sin not counted (4:6–8). Read with the courtroom sense of
the verb, what is counted to the ungodly is not a righteousness worked in them.
Trent can accept every word (`trent_grants_romans_four`), and Augustine reads
the same verse the other way: God justifies the ungodly "that he may become a
godly one" (*On the Spirit and the Letter* 26.45). So the step is `disputed`, as
the step from Galatians is, and Romans 4 adds a second argument at the same
rating. So read, Trent is met by Paul
from Galatians and from Romans 4, and each has to be answered
(`whereRomansFourMeetsWhatGodDoes`). The two arguments are not wholly separate:
both start from the courtroom sense of the verb, so a reader who denies that
sense denies both.

The two are put together and checked in one result
(`whatTrentsDefinitionClaims`). Each way of taking the definition is fair, since
Trent read either way can still be held without contradiction, and each is
answered. The first cannot be held with the arguments about Paul's word: it
meets them three times, each at the same step, rated `disputed`. The second is
untouched by anything about the word, and conflicts with Paul's gospel and with
Romans 4, each time at a step
rated `disputed`. So a reader who grants that step rejects the definition taken
that way, and a reader who denies it need not. Which way Trent means it is not
something this chapter decides.

One premise, that Paul has his own words for renewal
(`paulNamesRenewalOtherwise`), is cited to Scripture alone: it says what the
texts say and no more.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic

attribute [solaFideDefs] ArgumentPackage.readAs

/-! ### The argument from Paul's word holds together -/

/-- The reading on which the argument from Paul's word holds: every word as that
argument takes it, and "justify" meaning the verdict and not renewal. -/
def lexicalReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | _ => True

/-- **Paul's "justify" (δικαιόω) does not mean the renewal of the inward person.**
This follows from three things: the verb is a courtroom word; Paul has other
words for renewal; and a word contributes the least meaning its context
requires.

It does not claim anything about what God does when he justifies. It is
a result about a word. -/
@[headline]
theorem lexicalCase_establishes : Establishes lexicalCase := by
  establish [solaFideDefs]

#print axioms lexicalCase_establishes

/-- The premises of the argument from Paul's word can all be true together. -/
theorem lexicalCase_is_satisfiable : Satisfiable lexicalCase.premises := by
  satisfied_by lexicalReading [solaFideDefs]

/-! ### Two ways of taking Trent's definition -/

/-- Taking Trent's definition as a claim about Paul's word, and taking Paul's word
as the Latin West did. Trent's chapter 8 sets out how "the Apostle's" words are
to be understood, and chapter 7 says the justified are "not only reputed, but
are truly called, and are, just". The council read Paul in the Latin it had
declared "authentic" (Session IV), where "justify" (*iustificare*) had meant "to
make righteous" since Augustine. McGrath traces that inheritance. Rated
`disputed`: whether the council defines the word or the reality is itself
argued, and the step from the Latin explanation to the Greek word is what the
argument from Paul's word denies. -/
def trentReadsPaulsWord : Source :=
  { primary := .work tannerDecrees
      (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 8")
  , supporting :=
      [ .work tannerDecrees
          (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 7")
      , .work npnfAugustineAntiPelagian
          (.sectionRef "On the Spirit and the Letter, ch. 45 (26.45)")
      , .work mcgrathIustitiaDei .whole ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- Taking Trent's definition as a claim about what God does in justifying. In the
*Joint Declaration*, forgiveness and the renewal the Spirit brings about are two
sides of God's gracious action, "not to be separated" (§22). Rated `disputed`,
for the same reason as the other way of taking it. -/
def trentReadsGrace : Source :=
  { primary := .work jointDeclarationJustification (.sectionRef "§22")
  , supporting :=
      [.work tannerDecrees
        (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 7")]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-! ### Paul's word, from the Greek: two Catholic roads and the Reformed answers

Trent read Paul's "justify" (δικαιόω) through Augustine's Latin. A modern
Catholic exegete, Joseph Fitzmyer, gives the same reading two roads from the
Greek (*Romans*, 118–19). Each road is taken here in the steps a reader can
deny, and each step has the reader who denies it beside it. -/

/-- The reading of Romans 5:19's "made righteous" as made righteous within, rated
`disputed`. Ziesler holds that "certainly something more than forensic" is meant,
that the many "will really be righteous" (*The Meaning of Righteousness in Paul*,
199), and Fitzmyer reads it in the "effective sense" (*Romans*, 118–19). Charles
Hodge grants the verse and denies the reading (`hodgeOnRomansFiveNineteen`). -/
def inwardOnRomansFiveNineteen : Source :=
  { primary := .work zieslerRighteousnessInPaul (.page 199)
  , supporting := [.work fitzmyerRomans (.pages 118 119)]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- **Romans 5:19, read as renewal.** "Through the obedience of the one man the many
will be made righteous" (δίκαιοι κατασταθήσονται). Fitzmyer and Ziesler read
"made righteous" as made righteous within: the many "will really be
righteous". -/
@[solaFideDefs]
def inwardSenseLine : Line Claim :=
  { name := "Romans 5:19, 'made righteous' as made righteous within (Ziesler, Fitzmyer)"
  , grounds := [p .romans5_19ManyMadeRighteous]
  , step := p .romans5_19ManyMadeRighteous ➝ p .romans5_19MadeInwardlyRighteous
  , delivers := p .romans5_19MadeInwardlyRighteous
  , inference := some inwardOnRomansFiveNineteen }

/-- Fitzmyer's bridge, rated `disputed`. Fitzmyer grants that the verb "seems
normally to have a declarative, forensic meaning" in the Septuagint, and in Paul
at times. But "many instances are ambiguous, and the effective sense seems to be
supported by 5:19, 'through the obedience of one many will be made upright'"
(*Romans*, 118–19). Ziesler grants the verse, and that "certainly something more
than forensic" is meant there, and denies that it bears on the verb, because
the word in 5:19 is "righteous" (δίκαιοι), not "justify" (*The Meaning of
Righteousness in Paul*, 199). -/
def fitzmyerOnTheAdjective : Source :=
  { primary := .work fitzmyerRomans (.pages 118 119)
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **The bridge from Romans 5:19 to Paul's verb.** Romans 5:19 does not use the
verb "justify" (δικαιόω). It says the many "will be made righteous" (δίκαιοι
κατασταθήσονται), with the adjective "righteous" (δίκαιος). Fitzmyer's road
needs what the adjective means there to be what the verb means in Paul. That
is a reading in its own right, and it is the one Ziesler denies, so it stands
here as a line of its own, which a reader can reject without rejecting the
verse. The word-shift check (`Testimony.Semantics.Fallacy`) finds the move from
the adjective to the verb granted, because this line states it. -/
@[solaFideDefs]
def fitzmyerBridgeLine : Line Claim :=
  { name := "Romans 5:19's adjective bears on Paul's verb (Fitzmyer)"
  , grounds := []
  , step := p .romans5_19BearsOnTheVerb
  , delivers := p .romans5_19BearsOnTheVerb
  , inference := some fitzmyerOnTheAdjective }

/-- The step from Romans 5:19, read as renewal, and the bridge to what Paul's verb
means, rated `plausible`. Granted that the many in 5:19 are made righteous
within, and that the adjective there bears on the verb, the verb carries the
sense of making righteous. No cited reader grants both and denies this. Those
who deny the conclusion deny one of the two: Hodge the reading of the verse,
Ziesler the bridge. -/
def fitzmyerOnRomansFiveNineteen : Source :=
  { primary := .work fitzmyerRomans (.pages 118 119)
  , tradition := .romanCatholic
  , confidence := .plausible }

/-- **Paul's word, from Romans 5:19.** "Through the obedience of the one man the
many will be made righteous." So, Fitzmyer argues, Paul's "justify" carries an
effective sense: God's declaration makes the sinner upright. This is Trent's
reading of the word on a modern Catholic exegete's ground, the Greek of
Romans, rather than on the Latin. It rests on two readings, each its own line
so that a reader can deny it: that "made righteous" there means made righteous
within (`inwardSenseLine`), and that the verse's adjective bears on the verb
(`fitzmyerBridgeLine`). Neither is among this line's grounds, which a burden
takes as granted. -/
@[solaFideDefs]
def fitzmyerWordLine : Line Claim :=
  { name := "Paul's word, from Romans 5:19 (Fitzmyer)"
  , grounds := []
  , step :=
      ⋀ [p .romans5_19MadeInwardlyRighteous, p .romans5_19BearsOnTheVerb]
      ➝ p .paulsJustifyDenotesRenewal
  , delivers := p .paulsJustifyDenotesRenewal
  , inference := some fitzmyerOnRomansFiveNineteen }

/-- That God's verdict is effective, rated `disputed`. Fitzmyer, quoting Karl
Kertelge: declaring a person upright has "not only a forensic effect, but as
forensic also an 'effective' meaning" (*Romans*, 118–19). Calvin grants that the
two are given together and denies that the verdict does the renewing
(`calvinOnTheVerdict`). -/
def kertelgeOnTheVerdictItself : Source :=
  { primary := .work fitzmyerRomans (.pages 118 119)
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **God's verdict is effective.** When God declares a sinner righteous, his word
does what it says, and the sinner is made righteous. Kertelge's claim, as
Fitzmyer reports it. It is a claim about what God's declaration does, held as a
line of its own so that a reader can deny it, as Calvin does. -/
@[solaFideDefs]
def kertelgeVerdictLine : Line Claim :=
  { name := "God's verdict is effective (Kertelge, via Fitzmyer)"
  , grounds := []
  , step := p .godsVerdictIsEffective
  , delivers := p .godsVerdictIsEffective
  , inference := some kertelgeOnTheVerdictItself }

/-- The step from God's effective verdict to what Paul's verb means, rated
`disputed`. Fitzmyer, quoting Kertelge (*Romans*, 118–19). Ziesler grants that the
justified are also made a new creature, the two "interdependent and
inseparable" (p. 212), and denies that the renewal is what the verb says
(pp. 162–63). -/
def kertelgeOnTheVerdict : Source :=
  { primary := .work fitzmyerRomans (.pages 118 119)
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **Paul's word, from what God's verdict does.** If God's declaration makes the
sinner righteous, the verb that names the declaration names the renewal too.
This is the road Kertelge takes, as Fitzmyer reports it, and it is the strongest
form of the Catholic reading, because it grants the Reformers the courtroom
sense and asks only that the verdict be effective.

It reaches a sense of the word from a claim about God's act, not from a use or
a reading of the word, and the sense-from-elsewhere check
(`Testimony.Semantics.Fallacy`) reports it so. That is not a charge that the
road is wrong. It says where its ground lies: in what God's verdict does, not in
what Paul's word means. -/
@[solaFideDefs]
def effectiveVerdictLine : Line Claim :=
  { name := "Paul's word, from God's effective verdict (Kertelge, via Fitzmyer)"
  , grounds := []
  , step := p .godsVerdictIsEffective ➝ p .paulsJustifyDenotesRenewal
  , delivers := p .paulsJustifyDenotesRenewal
  , inference := some kertelgeOnTheVerdict }

/-- Fitzmyer's and Kertelge's roads to Trent's reading of Paul's word, each in the
steps a reader can deny: Romans 5:19 read as renewal, the bridge from its
adjective to the verb, the step from both, God's verdict as effective, and the
step from it. -/
@[solaFideDefs]
def modernCatholicWordRoads : List (Line Claim) :=
  [inwardSenseLine, fitzmyerBridgeLine, fitzmyerWordLine, kertelgeVerdictLine,
    effectiveVerdictLine]

/-- Hodge's reading of Romans 5:19, rated `disputed`, because Ziesler and Fitzmyer
grant the verse and read it as renewal. Charles Hodge: καθίστημι "never, in the
New Testament, means to make, in the sense of effecting, or causing a person or
thing, to be in its character or nature other than it was before"
(*Commentary on the Epistle to the Romans*, 1864, p. 271). So "this cannot mean,
that by the obedience of one the many shall be made holy": "as by the
righteousness of Christ we are constituted legally righteous" (p. 272). Calvin
reads the verse the same way: we could not be "made righteous 'by the
obedience' of Christ (Rom. 5:19), were it not that we are deemed righteous in
the sight of God in him and not in ourselves" (*Institutes* III.xi.4). -/
def hodgeOnRomansFiveNineteen : Source :=
  { primary := .work hodgeRomans (.pages 271 272)
  , supporting := [.work calvinInstitutesBeveridgeCcel (.sectionRef "III.xi.4")]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- **Romans 5:19, read as a verdict.** The verb in "will be made righteous" is
καθίστημι, "to set down" or "constitute", and Hodge argues that it never means
to make a person other in nature than he was. So the many are set in the rank of
the righteous on the ground of Christ's obedience, as by Adam's disobedience
they were set in the rank of sinners. "Made righteous" here is a standing, not a
renewal. The Reformed answer to the first of Fitzmyer's readings. -/
@[solaFideDefs]
def hodgeVerseLine : Line Claim :=
  { name := "Romans 5:19, 'made righteous' as constituted righteous (Hodge, Calvin)"
  , grounds := [p .romans5_19ManyMadeRighteous]
  , step := p .romans5_19ManyMadeRighteous ➝ notP .romans5_19MadeInwardlyRighteous
  , delivers := notP .romans5_19MadeInwardlyRighteous
  , inference := some hodgeOnRomansFiveNineteen }

/-- Ziesler's answer to the bridge, rated `disputed`, because Fitzmyer grants the
verse and holds the bridge. Ziesler grants that "certainly something more than
forensic" is meant at 5:19 and denies that it bears on the verb, because the
word there is "righteous" (δίκαιοι), not "justify" (*The Meaning of
Righteousness in Paul*, 199). -/
def zieslerOnTheAdjective : Source :=
  { primary := .work zieslerRighteousnessInPaul (.page 199)
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- **The adjective is not the verb.** Romans 5:19 says the many will be
"righteous" (δίκαιοι). It does not say they will be "justified". So whatever the
adjective means there, it does not settle what the verb means. Ziesler's answer
to the second of Fitzmyer's readings, made by a reader who grants the first. -/
@[solaFideDefs]
def zieslerAdjectiveLine : Line Claim :=
  { name := "Romans 5:19's adjective does not settle the verb (Ziesler)"
  , grounds := [p .romans5_19ManyMadeRighteous]
  , step := p .romans5_19ManyMadeRighteous ➝ notP .romans5_19BearsOnTheVerb
  , delivers := notP .romans5_19BearsOnTheVerb
  , inference := some zieslerOnTheAdjective }

/-- Calvin's answer to the effective verdict, rated `disputed`, because Kertelge,
as Fitzmyer reports him, grants that God renews whom he justifies and holds the
verdict itself effective. Calvin, against Osiander: "as Christ cannot be divided
into parts, so the two things, justification and sanctification, which we
perceive to be united together in him, are inseparable." "But if the brightness
of the sun cannot be separated from its heat, are we therefore to say, that the
earth is warmed by light and illumined by heat? ... Here is a mutual and
undivided connection, and yet reason itself prohibits us from transferring the
peculiar properties of the one to the other" (*Institutes* III.xi.6). Both gifts
come with Christ, "a twofold benefit": reconciliation, and being "sanctified by
his Spirit" (III.xi.1). -/
def calvinOnTheVerdict : Source :=
  { primary := .work calvinInstitutesBeveridgeCcel (.sectionRef "III.xi.6")
  , supporting := [.work calvinInstitutesBeveridgeCcel (.sectionRef "III.xi.1")]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- **The renewal comes with the verdict, not from it.** Calvin grants Kertelge's
starting point: "whomsoever, therefore, God receives into his favor, he presents
with the Spirit of adoption, whose agency forms them anew into his image"
(*Institutes* III.xi.6). He denies that the verdict does the renewing. Light and
heat come together from the sun, and still the earth is not warmed by the
light. So God renews those he justifies, and his verdict is not what renews
them. The Reformed answer to Kertelge's road, at its first step. -/
@[solaFideDefs]
def calvinVerdictLine : Line Claim :=
  { name := "The renewal comes with the verdict, not from it (Calvin)"
  , grounds := [p .justifyingGraceRenews]
  , step := p .justifyingGraceRenews ➝ notP .godsVerdictIsEffective
  , delivers := notP .godsVerdictIsEffective
  , inference := some calvinOnTheVerdict }

/-- The Reformed answers to the two roads from the Greek: Hodge on Romans 5:19,
Ziesler on its adjective, and Calvin on the verdict. -/
@[solaFideDefs]
def reformedAnswersFromTheGreek : List (Line Claim) :=
  [hodgeVerseLine, zieslerAdjectiveLine, calvinVerdictLine]

/-- Trent's definition, **taken as a claim about what Paul's word means**, and
resting, as the Latin West did, on Augustine's explanation: "being justified" is
"being made righteous". -/
@[solaFideDefs]
def trentOnPaulsWord : Reading Claim :=
  { name := "as what Paul's word means"
  , commits := p .paulsJustifyDenotesRenewal
  , grounds :=
      [ p .augustineReadsJustifyAsMakeRighteous
      , p .augustineReadsJustifyAsMakeRighteous ➝ p .paulsJustifyDenotesRenewal ]
  , source := trentReadsPaulsWord }

/-- Trent's definition, **taken as a claim about what God does in justifying**. -/
@[solaFideDefs]
def trentOnWhatGodDoes : Reading Claim :=
  { name := "as what God does in justifying"
  , commits := p .justifyingGraceRenews
  , source := trentReadsGrace }

/-- Trent, with its definition taken as a claim about Paul's word. -/
@[solaFideDefs]
def tridentineOnPaulsWord : ArgumentPackage Claim :=
  tridentineCase.readAs (p .justificationIncludesSanctification) trentOnPaulsWord

/-- Trent, with its definition taken as a claim about what God does. -/
@[solaFideDefs]
def tridentineOnWhatGodDoes : ArgumentPackage Claim :=
  tridentineCase.readAs (p .justificationIncludesSanctification) trentOnWhatGodDoes

/-- Trent, taken as a claim about Paul's word, still concludes what Trent concludes:
taking the definition one way only adds premises. -/
theorem tridentineOnPaulsWord_establishes : Establishes tridentineOnPaulsWord := by
  establish [solaFideDefs]

/-- Trent's position, taking Paul's word as it does: "justify" means making just,
and not a verdict only; justification includes renewal; faith without charity
does not suffice; and justification is not by faith alone. -/
def trentOnPaulsWordReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | .dikaioIsForensic => False
  | _ => True

/-- **Trent, taken as a claim about Paul's word, can be held without
contradiction.** So this branch of the question is a fair one: the position does
not refute itself. -/
theorem tridentineOnPaulsWord_is_satisfiable :
    Satisfiable tridentineOnPaulsWord.premises := by
  satisfied_by trentOnPaulsWordReading [solaFideDefs]

/-- **Trent, taken as a claim about Paul's word, at its strongest.** Trent's reading
of the word rests on Augustine's explanation, as the Latin West received it. A
modern Catholic exegete gives it two more roads, each from the Greek and not the
Latin. Joseph Fitzmyer argues from Romans 5:19, "the many will be made
righteous", and Karl Kertelge, whom Fitzmyer quotes, from God's verdict: it
does what it says (*Romans*, 118–19). This is Trent taken that way, with both
roads added (`modernCatholicWordRoads`). It is the position the debate over
sola fide hears as Trent on Paul's word, so that the debate meets the reading
as strongly as its cited readers put it. -/
@[solaFideDefs]
def tridentineOnPaulsWordAtItsStrongest : ArgumentPackage Claim :=
  { tridentineOnPaulsWord with
    name := tridentineOnPaulsWord.name ++ ", with Fitzmyer's and Kertelge's roads"
    premises := tridentineOnPaulsWord.premises ++ caseOf modernCatholicWordRoads [] []
    inferences :=
      tridentineOnPaulsWord.inferences
        ++ [inwardOnRomansFiveNineteen, fitzmyerOnTheAdjective, fitzmyerOnRomansFiveNineteen,
          kertelgeOnTheVerdictItself, kertelgeOnTheVerdict] }

/-- Trent on Paul's word at its strongest still concludes what Trent concludes. -/
theorem tridentineOnPaulsWordAtItsStrongest_establishes :
    Establishes tridentineOnPaulsWordAtItsStrongest := by
  establish [solaFideDefs]

/-- **Trent on Paul's word at its strongest can be held without contradiction**, on
the same reading as Trent on Paul's word, with Romans 5:19, its bridge to the
verb and the effective verdict all granted. -/
theorem tridentineOnPaulsWordAtItsStrongest_is_satisfiable :
    Satisfiable tridentineOnPaulsWordAtItsStrongest.premises := by
  satisfied_by trentOnPaulsWordReading [solaFideDefs]

/-- **The argument from Paul's word, with its answers from the Greek.** The
argument from how the word is used (`lexicalCase`), with the Reformed answer to
each reading the two Catholic roads from the Greek rest on: Hodge's reading of
Romans 5:19 as a standing, Ziesler's that its adjective does not settle the verb,
and Calvin's that the renewal comes with the verdict and not from it
(`reformedAnswersFromTheGreek`). It is the position the debate over sola fide
hears as the argument from Paul's word, so that Trent's reading at its strongest
meets the Reformed reading at its strongest. -/
@[solaFideDefs]
def lexicalCaseAnsweringTheGreek : ArgumentPackage Claim :=
  { lexicalCase with
    name := lexicalCase.name ++ ", with its answers from the Greek"
    premises := lexicalCase.premises ++ caseOf reformedAnswersFromTheGreek [] []
    inferences :=
      lexicalCase.inferences
        ++ [hodgeOnRomansFiveNineteen, zieslerOnTheAdjective, calvinOnTheVerdict] }

/-- The argument from Paul's word, with its answers, granted: the word does not
mean renewal; "made righteous" in Romans 5:19 is a standing, and its adjective
does not bear on the verb; God renews those he justifies, and his verdict is not
what renews them. -/
def answeringTheGreekReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .romans5_19MadeInwardlyRighteous => False
  | .romans5_19BearsOnTheVerb => False
  | .godsVerdictIsEffective => False
  | _ => True

/-- The argument from Paul's word still concludes what it concludes. -/
theorem lexicalCaseAnsweringTheGreek_establishes :
    Establishes lexicalCaseAnsweringTheGreek := by
  establish [solaFideDefs]

/-- **The argument from Paul's word, with its answers, can be held without
contradiction.** -/
theorem lexicalCaseAnsweringTheGreek_is_satisfiable :
    Satisfiable lexicalCaseAnsweringTheGreek.premises := by
  satisfied_by answeringTheGreekReading [solaFideDefs]

/-- Trent taken as a claim about what God does, with everything the argument from
Paul's word says accepted: the verb a courtroom word, Paul's own words for
renewal, the rule of least meaning, and "justify" not meaning renewal. God, in
justifying, also renews. -/
def trentGrantsTheWordReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | .paulsJustifyDenotesRenewal => False
  | _ => True

/-- **Trent, taken as a claim about what God does, can be held without
contradiction.** -/
theorem tridentineOnWhatGodDoes_is_satisfiable :
    Satisfiable tridentineOnWhatGodDoes.premises := by
  satisfied_by trentGrantsTheWordReading [solaFideDefs]

/-- **The argument from Paul's word does not reach Trent's definition taken as a
claim about what God does.** Taken that way, Trent's position can be held
together with every premise of the argument. The rule of least meaning governs
what Paul's word says, and this way of taking the definition says nothing about
the word. -/
theorem lexical_case_does_not_reach_what_god_does :
    Satisfiable (lexicalCase.premises ++ tridentineOnWhatGodDoes.premises) := by
  satisfied_by trentGrantsTheWordReading [solaFideDefs]

/-! ### Where each fails -/

/-- **Why Paul's word stands against Trent taken as a claim about it.** Everything
turns on one step: with the courtroom sense, Paul's own words for renewal and
the rule of least meaning, "justify" does not mean renewal. What that
contradicts is Trent's definition together with this way of taking it, and
nothing else in Trent. Every link is rated above `disputed` but that step, which is
`disputed`: Trent grants its starting points and denies its conclusion. -/
def whereTrentsWordReadingFalls : Because lexicalCase tridentineOnPaulsWord :=
  Because.ofChecks lexicalLine.step lexicalLine.grounds [] lexicalLine.grounds
    [ p .justificationIncludesSanctification
    , p .justificationIncludesSanctification ➝ p .paulsJustifyDenotesRenewal ]
    .derives lexicalCase_establishes lexicalCase_is_satisfiable
    (by simp [lexicalCase, Line.asPackage, Line.premises])
    (fun φ hφ => by
      simp only [lexicalCase, Line.asPackage, Line.premises, List.mem_append,
        List.mem_cons, List.not_mem_nil, or_false] at hφ ⊢
      tauto)
    (by simp [solaFideDefs, tridentinePremises, Line.premises])
    (by decide +kernel)
  |>.ratedByLine lexicalLine rfl (by simp [lexicalCase, solaFideDefs, Line.asPackage])

/-- **Why Paul's word stands against the Latin reading of it.** The same step, and a
second contradiction in the same branch. Trent rests its reading of Paul's word
on Augustine's explanation, and what fails is the step from that explanation to
what the Greek word means. That Augustine explained it so is not in question; it
is rated `consensus`. But a Latin explanation does not settle what the Greek
word means in Paul, and the courtroom sense, Paul's own words for renewal and
the rule of least meaning say it does not mean renewal. That last step is rated
`disputed`, so the break is a tie, not a refutation: Trent grants the starting
points and denies the step. -/
def whereTheLatinReadingFalls : Because lexicalCase tridentineOnPaulsWord :=
  Because.ofChecks lexicalLine.step lexicalLine.grounds [] lexicalLine.grounds
    [ p .augustineReadsJustifyAsMakeRighteous
    , p .augustineReadsJustifyAsMakeRighteous ➝ p .paulsJustifyDenotesRenewal ]
    .derives lexicalCase_establishes lexicalCase_is_satisfiable
    (by simp [lexicalCase, Line.asPackage, Line.premises])
    (fun φ hφ => by
      simp only [lexicalCase, Line.asPackage, Line.premises, List.mem_append,
        List.mem_cons, List.not_mem_nil, or_false] at hφ ⊢
      tauto)
    (by simp [solaFideDefs, tridentinePremises, Line.premises])
    (by decide +kernel)
  |>.ratedByLine lexicalLine rfl (by simp [lexicalCase, solaFideDefs, Line.asPackage])

/-- **Why Paul's gospel stands against Trent taken as a claim about what God does.**
The same step as `whereTrentPartsFromPaul`, and the same contradiction: from a
verdict on Christ's finished work to "renewal is no part of justification",
against Trent's definition. Taken this way, that step is all that divides them,
and it is rated `disputed`. -/
def whereTrentsGraceReadingFalls : Because galatianGospel tridentineOnWhatGodDoes :=
  Because.ofChecks verdictExcludesRenewal
    (galatianGospelLine.premises ++ [p .romans8_33_34, p .dikaioIsForensic]) []
    (galatianGospelLine.premises ++ [p .romans8_33_34, p .dikaioIsForensic])
    [p .justificationIncludesSanctification]
    .derives galatianGospel_establishes galatianGospel_is_satisfiable
    (by simp [galatianGospel])
    (fun φ hφ => by
      simp only [galatianGospel, List.mem_append, List.mem_cons, List.not_mem_nil,
        or_false] at hφ ⊢
      tauto)
    (by simp [solaFideDefs, tridentinePremises, Line.premises])
    (by decide +kernel)
  |>.ratedBy verdictNotRenewalSource (by simp [galatianGospel, solaFideDefs])

/-! ### Romans 4 -/

/-- **Romans 4, read this way, denies Trent's definition.** Paul explains the
righteousness God counts to the ungodly as sin not counted. With the courtroom
sense of the verb, renewal is no part of justification.

It does not show that the reading is beyond dispute. Augustine accepts
the same verses and reads them the other way, so the step is rated `disputed`. -/
@[headline]
theorem romansFourCase_establishes : Establishes romansFourCase := by
  establish [solaFideDefs, caseOf]

#print axioms romansFourCase_establishes

/-- The premises of the argument from Romans 4 can all be true together, on the
reading given for Paul's gospel. -/
theorem romansFourCase_is_satisfiable : Satisfiable romansFourCase.premises := by
  satisfied_by galatianGospelReading [solaFideDefs, caseOf]

/-- **Romans 4, read by the rule of least meaning, shows what Paul's word means.**
The verb Paul explains as sin not counted does not also mean the renewal of the
inward person. -/
@[headline]
theorem romansFourOnTheWord_establishes : Establishes romansFourOnTheWord := by
  establish [solaFideDefs, caseOf]

#print axioms romansFourOnTheWord_establishes

/-- The premises of that argument can all be true together, on the reading given for
the argument from Paul's word. -/
theorem romansFourOnTheWord_is_satisfiable : Satisfiable romansFourOnTheWord.premises := by
  satisfied_by lexicalReading [solaFideDefs, caseOf]

/-- **Trent can accept every word of Romans 4:5–8**, as Augustine does: God
justifies the ungodly, and the blessing is sin not counted. The texts are
accepted on both sides. The reading of them is not. -/
theorem trent_grants_romans_four :
    Grants tridentineCase (⋀ [p .romans4_4_5, p .romans4_6_8]) := by
  satisfied_by jointDeclarationReading [Grants, solaFideDefs]

/-- **Romans 4, read for Paul's word, does not reach Trent's definition taken as a
claim about what God does.** Taken that way, Trent's position can be held with
every premise of the argument. The argument says what the counting is, and this
way of taking the definition says nothing about the word. -/
theorem romans_four_on_the_word_does_not_reach_what_god_does :
    Satisfiable (romansFourOnTheWord.premises ++ tridentineOnWhatGodDoes.premises) := by
  satisfied_by trentGrantsTheWordReading [solaFideDefs, caseOf]

/-- **Why Romans 4 stands against Trent taken as a claim about Paul's word.**
Everything turns on the step from Paul's explanation, that the righteousness
counted to the ungodly is sin not counted, by the rule of least meaning, to "the
verb does not also mean renewal". What it contradicts is Trent's definition
taken this way. Every link is rated `wellSupported` or better but that step,
which uses the rule of least meaning as the argument from usage does, and is
rated `disputed` for the same reason. It arrives from one passage where the
argument from usage arrives from the word. -/
def whereRomansFourMeetsTheWordReading : Because romansFourOnTheWord tridentineOnPaulsWord :=
  Because.ofChecks glossByLeastMeaning
    (romansFourExegesisLine.grounds ++ [p .leastMeaning, romansFourExegesisLine.step]) []
    (romansFourExegesisLine.grounds ++ [p .leastMeaning, romansFourExegesisLine.step])
    [ p .justificationIncludesSanctification
    , p .justificationIncludesSanctification ➝ p .paulsJustifyDenotesRenewal ]
    .derives romansFourOnTheWord_establishes romansFourOnTheWord_is_satisfiable
    (by simp [romansFourOnTheWord, caseOf, romansFourExegesisLine])
    (fun φ hφ => by
      simp only [romansFourOnTheWord, caseOf, romansFourExegesisLine, List.flatMap_cons,
        List.flatMap_nil, List.map_cons, List.map_nil, List.append_nil, List.mem_append,
        List.mem_cons, List.not_mem_nil, or_false] at hφ ⊢
      tauto)
    (by simp [solaFideDefs, tridentinePremises, Line.premises])
    (by decide +kernel)
  |>.ratedBy leastMeaningSource (by simp [romansFourOnTheWord, solaFideDefs])

/-- **Why Romans 4 stands against Trent taken as a claim about what God does.**
Everything turns on the step from Paul's explanation, with the courtroom sense
of the verb, to "renewal is no part of justification". It contradicts Trent's
definition and nothing else.

The step is rated `disputed`, as the step from Galatians is. Augustine accepts
the same verses and reads them the other way: God justifies the ungodly "that he
may become a godly one". So taken this way, Trent is met by Paul twice, from
Galatians and from Romans 4, each time at a `disputed` step. The two arguments
share one starting point, the courtroom sense of the verb. -/
def whereRomansFourMeetsWhatGodDoes : Because romansFourCase tridentineOnWhatGodDoes :=
  Because.ofChecks countedExcludesRenewal
    (romansFourExegesisLine.grounds ++ [p .dikaioIsForensic, romansFourExegesisLine.step]) []
    (romansFourExegesisLine.grounds ++ [p .dikaioIsForensic, romansFourExegesisLine.step])
    [p .justificationIncludesSanctification]
    .derives romansFourCase_establishes romansFourCase_is_satisfiable
    (by simp [romansFourCase, caseOf, romansFourExegesisLine])
    (fun φ hφ => by
      simp only [romansFourCase, caseOf, romansFourExegesisLine, List.flatMap_cons,
        List.flatMap_nil, List.map_cons, List.map_nil, List.append_nil, List.mem_append,
        List.mem_cons, List.not_mem_nil, or_false] at hφ ⊢
      tauto)
    (by simp [solaFideDefs, tridentinePremises, Line.premises])
    (by decide +kernel)
  |>.ratedBy romansFourReadingSource (by simp [romansFourCase, solaFideDefs])

/-! ### The two put together -/

/-- **What Trent's definition claims, taken both ways.** The definition is that
justification is the sanctification and renewal of the inward person.

*Taken as a claim about what Paul's word means*, namely that "justify" (δικαιόω)
means that renewal, it cannot be held with the arguments about the word. It meets
them three times, each at the step from the courtroom sense to "and nothing
more", rated `disputed`: against the argument from usage, as Trent states the
definition; against the same argument, at the Latin explanation this reading
rests on ("being justified" as "being made righteous"); and against Romans 4
read for the word. A reader who grants that step rejects the definition taken
this way. A reader who denies it, as Trent does, need not.

*Taken as a claim about what God does in justifying*, namely that he also
renews, nothing about the word reaches it: neither the argument from usage nor
Romans 4 read for the word. It conflicts with Paul twice, each time at a step
rated `disputed`: with his gospel in Galatians, at the step
`whereTrentPartsFromPaul` names, and with Romans 4, at the reading of "justifies
the ungodly". A reader who grants those steps rejects the definition taken this
way. A reader who denies them need not. Augustine does, and so does the *Joint
Declaration*'s Annex, which defines justification as "forgiveness of sins and
being made righteous" (Annex 2 A).

Each way of taking it is fair: Trent's position, taken either way, can still be
held without contradiction. -/
def whatTrentsDefinitionClaims : Dilemma tridentineCase where
  claim := p .justificationIncludesSanctification
  horns :=
    [ { reading := trentOnPaulsWord
      , fair := tridentineOnPaulsWord_is_satisfiable
      , fates :=
          [ .falls lexicalCase whereTrentsWordReadingFalls
          , .falls lexicalCase whereTheLatinReadingFalls
          , .falls romansFourOnTheWord whereRomansFourMeetsTheWordReading ]
      , answered := by simp }
    , { reading := trentOnWhatGodDoes
      , fair := tridentineOnWhatGodDoes_is_satisfiable
      , fates :=
          [ .unreached lexicalCase lexicalCase_establishes
              lexical_case_does_not_reach_what_god_does
          , .unreached romansFourOnTheWord romansFourOnTheWord_establishes
              romans_four_on_the_word_does_not_reach_what_god_does
          , .falls galatianGospel whereTrentsGraceReadingFalls
          , .falls romansFourCase whereRomansFourMeetsWhatGodDoes ]
      , answered := by simp } ]
  claim_mem := by simp [solaFideDefs, tridentinePremises, Line.premises]
  two := by simp

end TestimonyArguments.SolaFide
