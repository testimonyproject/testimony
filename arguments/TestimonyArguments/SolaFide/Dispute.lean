import Testimony.Logic.Declare
import TestimonyArguments.SolaFide.Definition
import TestimonyArguments.SolaFide.Johannine
import Testimony.Logic.Because
import Testimony.Logic.Bundle

/-!
# TestimonyArguments.SolaFide.Dispute — the positions weighed against each other

The earlier chapters each heard one question: Trent against Paul's gospel,
James 2:24, Jesus' words, baptism. This one hears all the positions at once and
asks which are left standing.

Seventeen positions are heard.

- The four Reformed strands, each argued alone: Paul's, Luke's, Peter's and
  John's.
- The Council of Trent.
- The apocalyptic reading of Paul (Martyn, Campbell).
- Sanders and Dunn on Judaism in Paul's day, and the critics who answer them.
- Jervell on the yoke of Acts 15.
- Aquinas on John 6:29, and Luther's answer to him.
- Chrysostom on John 3:36 and Matthew 7:21, and the Reformed answer to him: the
  obedience those texts require is sanctification, the fruit of faith.
- Paul's gospel in Galatians, set against Trent's definition of justification.
- The meaning of Paul's word "justify", argued two ways: from how the word is
  used, and from Romans 4.
- Trent, with its definition taken as a claim about that word.

Who defeats whom is not decided by hand. Each defeat, and each absence of one,
is worked out from the two positions' premises and checked by machine.

## The words used here

- **Defeats.** One position contradicts another, and is not the weaker of the
  two. To contradict it is to deny one of its premises, its conclusion, or
  something it derives on the way.
- **Weakest link.** A position is only as strong as its least-supported premise
  or step. Ratings run from `disputed`, the lowest, through `plausible` and
  `wellSupported`, to `consensus`. Denying a claim counts as `disputed`.
- **Tie.** Two positions defeat each other. A reader may hold either.
- **Meets.** One position meets another when they contradict each other, so
  that one defeats the other unless it is the weaker. Where both defeat, they
  meet "in both directions".
- **Forced** (also: *prevails outright*). The position must be accepted however
  every tie is settled. Either nothing defeats it, or every position that
  defeats it is itself defeated by a forced position. The technical name for the
  set of forced positions is the *grounded extension*.
- **Can be defended.** Some consistent set of positions includes it and answers
  every attack on its members. A set is consistent when no member defeats
  another.
- **Not forced.** Some set of positions that can be defended, and is as large
  as it can be, leaves it out. Not forced does not mean false. It means the
  debate, as argued here, cannot make a reader accept it. The verdicts below
  that say *not forced* use this test; *forced* means the test above.
- **Cannot be defended.** No consistent set of positions can include it and
  answer its attackers.

## The ratings decide nothing

Every position here has a weakest link rated `disputed`.

- Each Reformed strand uses a step that Trent's canon 9 denies: to faith alone
  in Paul's case and John's, and to "faith suffices" in Luke's and Peter's. Trent
  denies it because faith, "unless hope and charity be added thereto, neither
  unites man perfectly with Christ, nor makes him a living member of His body"
  (Session VI, ch. 7).
- Paul's, Peter's and John's cases hold the Reformed distinction between
  justification and sanctification, which Trent condemns.
- Trent rests on its definition of justification, which the Westminster
  Confession denies: God justifies "not by infusing righteousness into them, but
  by pardoning their sins, and by accounting and accepting their persons as
  righteous" (XI.1).
- The apocalyptic reading denies a claim, and a premise that denies a claim is
  rated `disputed` by rule.
- The two arguments about Paul's word share a step that Trent grants the
  starting points of and denies. The first is from usage (`lexicalCase`):
  "justify" (δικαιόω) is a courtroom word, Paul has other words for renewal, and
  a word contributes the least meaning its context requires. The second is from
  Romans 4 (`romansFourOnTheWord`): Paul explains the righteousness God counts
  to the ungodly as sin not counted, and by the same rule the verb he explains
  in that way does not also mean renewal. Their other links are rated
  `wellSupported` or better. But Trent keeps the courtroom sense, for the
  justified "are not only reputed, but are truly called, and are, just"
  (Session VI, ch. 7), and denies that the word means no more; Augustine gives
  the courtroom sense himself, "deemed, or reckoned as just" (*On the Spirit and
  the Letter* 26.45), beside "made righteous". So the step from those starting
  points to "and nothing more" is rated `disputed`.

Between such positions no rating blocks an attack. The outcome depends only on
who contradicts whom.

## Who defeats whom

- **Trent and each Reformed strand defeat each other.** Paul's, Peter's and
  John's cases conclude "not by works", which Trent denies, holding good works
  done in grace to be "a cause of the increase" of justification (canon 24).
  Trent's definition
  of justification, "not remission of sins merely, but also the sanctification
  and renewal of the inward man" (Session VI, ch. 7), contradicts the
  distinction between justification and sanctification that they hold. That is
  where Trent's objection comes from: put the distinction in place of the
  definition, and Trent's case no longer denies "not by works"
  (`trent_objection_rests_on_its_definition`). Luke's case holds only Luke's
  words and meets Trent on one point. Trent's definition, with canon 9, denies
  that faith without charity suffices. Luke's case reads "Your faith has saved
  you" (Luke 7:50) as saying that her faith sufficed.
- **The apocalyptic reading and Paul's case defeat each other.** It denies that
  Galatians 2:16 speaks of faith *in* Christ, because Martyn and Campbell read
  "faith of Christ" (πίστις Χριστοῦ) as Christ's own faithfulness, and Paul's
  case concludes faith alone. **It does not conflict with Luke's case or
  Peter's.** They say that faith saves, which it grants. It says that faith is
  not the condition, which they do not deny.
- **The apocalyptic reading and Trent defeat each other.** They agree that
  justification is not by faith alone. But the apocalyptic reading derives "not
  by works", since God's rescue depends on nothing a person does, and Trent
  denies that, because works done in grace "truly merit increase of grace"
  (canon 32).
- **Sanders defeats Paul's case**, by denying the reading of "works of the law",
  because on his account Judaism taught entry into the covenant by grace, so the
  works Paul refuses are the marks that kept gentiles out, as Dunn infers. Paul's
  case defeats him in return. **Sanders and the critics defeat each
  other.**
- **Jervell and Peter's case defeat each other**, over the yoke.
- **John's case meets four positions, each in both directions.** Trent, however
  its definition is taken, over whether faith suffices and over "not by works",
  as with Paul and Peter. The apocalyptic reading, because John's case concludes
  faith alone, as Paul's does and Luke's does not. And Aquinas, over what the
  believing of John 6:29 is: Aquinas concludes it is not bare trust, and John's
  case holds that it is.
- **Chrysostom meets every position that concludes faith suffices, each in both
  directions**: Paul's case, Luke's, Peter's and John's, and the Reformed answer
  to him. He contradicts no text they read. He contradicts the step each takes
  to "faith suffices", and each contradicts his step to "faith does not
  suffice". Each pair is a tie at `disputed`. The Reformed answer meets Trent
  too, however Trent's definition is taken, because it holds the distinction
  between justification and sanctification.
- **Aquinas and Luther defeat each other.** Luther concludes that the faith
  which justifies is not faith formed by charity, which is Aquinas's premise.
  Luther meets no one else. Aquinas meets only John's case besides.
- **Paul's gospel and Trent defeat each other**, over Trent's definition. The
  gospel line concludes that justification is not the renewal of the inward
  person. Both rest on something rated `disputed`.
- **Paul's word and Trent taken as a claim about it defeat each other**
  (`lexical_defeats_trent_on_pauls_word`, `trent_on_pauls_word_defeats_lexical`).
  Taken that way, Trent's case derives that "justify" means renewal. The
  argument from the word denies it. Both rest on something rated `disputed`.
  Romans 4, read for the word, meets Trent the same way, from one passage.
  Neither argument conflicts with anything else. In particular neither
  conflicts with Trent's case as Trent states it, whose definition,
  taken as it stands, says nothing about the word. Trent taken as a claim about
  Paul's word also meets every position Trent meets, in both directions: the
  four strands, the apocalyptic reading, Paul's gospel and the Reformed answer
  to Chrysostom.

## What follows

### Nothing prevails outright

The checking finds that nothing is forced (`sola_fide_dispute_forces_nothing`),
not even the meaning of Paul's word. Every position is attacked by one the
debate cannot rule out, and none loses: every position can be defended.

### Paul's word and Trent's reading of it tie

The two arguments about Paul's word can be defended, and are not forced
(`pauls_word_defensible`, `pauls_word_not_forced`). Trent, taken as a claim
about Paul's word, can be defended too (`trent_on_pauls_word_defensible`). They
tie at one step: from the courtroom sense of "justify" to "and it means nothing
more". Whether that step can rise above `disputed` turns on Romans 5:19, 6:7
and 1 Corinthians 6:11, which readers take both ways.

### Nor does anything else win outright

Luke's case, Paul's gospel and Trent as
Trent states it can each be defended, and none is forced
(`dominical_case_defensible`, `dominical_case_not_forced`, `gospel_defensible`,
`gospel_not_forced`, `trent_defensible`, `trent_not_forced`). Every attack
between Trent and a Reformed position runs in both directions, with every rating
at the bottom, and the debate has no ground to choose between them.

### Between Paul and the apocalyptic reading, the debate chooses neither

Each
defeats the other over "faith of Christ" (πίστις Χριστοῦ). Each can be defended,
and neither is forced (`apocalyptic_defensible`, `apocalyptic_not_forced`). The
apocalyptic reading can be held together with Luke's case and Peter's, which
claim that faith saves and not that faith alone does.

## What the verdict rests on

### What Trent's definition claims

The definition can be taken two ways, and
the chapter "What Trent means by justification" answers both (`whatTrentsDefinitionClaims`).
Taken as a claim about Paul's word, it meets the argument from the word at the
step from the courtroom sense to "and nothing more", which is rated `disputed`,
and the two tie. Taken as a claim about what God does in justifying, the
argument from the word does not reach it. What then divides it from Paul is one
step: that a verdict on Christ's finished work excludes the renewal worked in us
(`whereTrentPartsFromPaul`). That step is rated `disputed` too. Trent's case as
Trent states it stands here for that second way of taking it. So the debate does
not settle between Trent and the Reformed, however the definition is taken. It
names the step on which each way of taking it depends.

### An absence

No source cited here argues that "saved" (σῴζω) at Luke 7:50 means healed, so no
position attacks Luke's case at that reading. Trent, however its definition is
taken, and Chrysostom attack it at the step to "faith suffices". That absence is
also the premise's rating. It is `wellSupported`, not `disputed`: a search for a
scholar arguing the healing sense *at 7:50* found none, and at 7:50 no one is
ill. The saying follows "your sins are forgiven". Marshall's commentary on the
Greek text says the same: the saying refers mainly to healing elsewhere in Luke,
and is used here "in a case where physical healing is not involved". The rating
is not `consensus`, because the same words mean "made you well" at Luke 8:48,
17:19 and 18:42. One older lexicon, Thayer's, lists 7:50 with the healing uses
without arguing it. It is not yet cited, and whether an unargued listing should
lower the rating is an open question. A cited argument for the healing reading
would attack Luke's case and lower the rating.

### An objection built in, not heard

"Her sins, which are many, are
forgiven—for she loved much" (7:47) is the verse a rival would use to make love,
not faith, the reason she was forgiven. Luke's case does not leave that open. It
carries, as a premise of its own, that her love is the evidence of her
forgiveness and not its cause (`luke7_47LoveIsEvidence`), as the rest of the
verse and the parable of 7:41–43 suggest. Marshall argues this from the Greek:
"for" (ὅτι) here means "as is evidenced by the fact that". Padilla reads it so:
she "loves much because she has been forgiven much". So does Melanchthon in the
*Apology of the Augsburg Confession*: "Christ interprets Himself when He adds:
Thy faith hath saved thee" (Bente and Dau's translation of 1921, which gives
Luke 7:50 in the King James wording), so the woman did not merit forgiveness
"by that work of love". The premise is rated `disputed`. Marshall names those
who read the love as the cause: Wellhausen, Creed, and most Roman Catholic
commentators, Lagrange and Schürmann among them. Trent counts beginning to
love God among the dispositions to justification (Session VI, ch. 6). None of
them is heard here as a position of his own. No one in this debate argues that
reading of 7:47, and none of those commentators is yet cited from his own work.

### John

John's case, Aquinas's reading of John 6:29 and Luther's answer are
each in a tie with a position rated no higher than itself. So none of the three
is forced, and none of them changes what is forced. Without Trent, John's case
is still not forced, because Aquinas's reading can be defended
(`sola_fide_from_john_not_forced_without_trent`).

### Who is heard

A debate is over the arguments put into it. Hays's reading of
"faith of Christ" is represented through the apocalyptic reading, which holds
it. A position for Hays alone, one for the *Joint Declaration*, and one for the
Finnish reading of Luther would each be new arguments to weigh. So would a cited
argument that Paul's "justify", granted to be a courtroom word, still means
renewal: none was found, and the rating of the argument from the word says so.
Romans 4 as an argument about what God does (`romansFourCase`) is set against
Trent in the chapter "What Trent means by justification", and is not added to
this debate. It meets Trent exactly
where Paul's gospel does, at Trent's definition, from a step rated `disputed`,
and a position of its own would be a second argument to weigh.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! #### The positions

Each position heard is an argument in its own right: premises that can be held
together, a conclusion that follows from them, and steps that someone has rated.
The Reformed case is heard as four positions, one for each strand. A debate
weighs each argument whole. One position holding all four strands would be
defeated by a contradiction of any one of them, and the fact that each strand
reaches the conclusion without the others would count for nothing. -/

/-- What the Reformed hold about what justification *is*: justification and
sanctification are distinct, and sanctification follows. No strand needs this to
reach sola fide. But it is the premise Trent's definition contradicts, so it
belongs to Paul's, Peter's and John's cases, and Trent's attack on each falls on
it as well as on "not by works". It is not added to the Reformed case itself,
because the other positions built from that case, the Finnish reading among
them, would then hold it on their authors' behalf. -/
@[solaFideDefs]
def reformedOntology : List (Formula Claim) :=
  [p .justificationDistinctFromSanctification]

/-- **Paul's case**: sola fide from Galatians 2:16, argued alone.

Its reading of "works of the law" is derived, not assumed. It rests on the
critics' line, which denies Sanders' account of Judaism, because Jewish texts of
the period also speak of final vindication according to works (Gathercole), and
reads Galatians as written against requiring circumcision. That is where the
scholarly debate lies (`critics_carry_the_pauline_strand`,
`sanders_costs_the_pauline_strand`). So Sanders meets Paul's case here over the
history of Judaism in Paul's day, not over Paul's Greek. The critics' inference
is rated with the rest, as Gathercole's. -/
@[solaFideDefs]
def paulineCase : ArgumentPackage Claim :=
  { reformed with
    name := "Sola fide from Paul (Galatians 2:16)"
    premises :=
      caseOf [paulineWithoutWorksOfLaw, criticsLine] (sharedGrounds ++ reformedOntology)
        closingSteps
    inferences := trentAgainstFaithAlone :: criticsLine.inference.toList }

/-- **Luke's case**: what Jesus says at Luke 7:50, and no more. "Your faith has
saved you", with "saved" (σῴζω) read as saved from sin and the woman's love
(7:47) read as the evidence of her forgiveness: her faith sufficed.

It carries what Luke says and nothing more: not Paul's texts, the answer to
James, or the Reformed account of what justification is, nor what Paul argues,
that faith *alone* saves. So it is attacked only by what denies Luke's own
claim. -/
@[solaFideDefs]
def dominicalCase : ArgumentPackage Claim :=
  { reformed with
    name := "Luke 7:50: \"your faith has saved you\""
    premises := p .luke7_50FaithHasSavedYou :: dominicalLine.premises
    conclusion := p .faithIsSufficient
    conclusionLabel := "faith is sufficient: her faith saved her"
    inferences := [trentAgainstFaithAlone] }

/-- **Peter's case**: sola fide from Peter's speech at Jerusalem (Acts 15:7–11),
argued alone. -/
@[solaFideDefs]
def apostolicCase : ArgumentPackage Claim :=
  { reformed with
    name := "Sola fide from Peter (Acts 15:9–11)"
    premises := caseOf [apostolicLine] (sharedGrounds ++ reformedOntology) closingSteps
    inferences := [trentAgainstFaithAlone] }

/-- **John's case**: sola fide from Jesus' answer in John 6:28–29, argued alone.
It holds the Reformed distinction between justification and sanctification, as
Paul's and Peter's cases do, so Trent meets it on the same ground. Two
inferences are rated: Calvin's step from John's "eternal life through
believing" to justification, and the step to faith alone that Trent's canon 9
denies, because faith without hope and charity "neither unites man perfectly
with Christ, nor makes him a living member of His body" (Session VI, ch. 7). -/
@[solaFideDefs]
def johannineParty : ArgumentPackage Claim :=
  { reformed with
    name := "Sola fide from John (6:28–29)"
    premises := caseOf [johannineLine] (sharedGrounds ++ reformedOntology) closingSteps
    inferences := [trentAgainstFaithAlone, calvinOnJohnSix] }

/-- **Aquinas on John 6:29**, as the argument he makes: the believing Jesus names is
faith made alive by love, so it is not bare trust. -/
@[solaFideDefs]
def aquinasCase : ArgumentPackage Claim :=
  thomistLine.asPackage baseCite "the believing of John 6:29 is not bare trust"

/-- **The Reformed answer to Chrysostom**, as a position: the obedience John 3:36
and Matthew 7:21 require is sanctification, the fruit of faith, so the texts add
no condition to faith, and faith suffices. It holds the Reformed distinction
between justification and sanctification, as the other Reformed positions do,
so Trent meets it on the same ground. -/
@[solaFideDefs]
def sanctificationCase : ArgumentPackage Claim :=
  { reformed with
    name := "Obedience as sanctification (John 3:36, Matthew 7:21)"
    premises := caseOf [sanctificationLine] reformedOntology []
    conclusion := p .faithIsSufficient
    conclusionLabel := "faith suffices: the obedience the texts require is its fruit"
    inferences := [obedienceAsFruitSource] }

/-- The apocalyptic reading, as the argument it makes: faith is not the condition of
justification. It keeps grace and "not by works", by a step of its own. -/
@[solaFideDefs]
def apocalypticCase : ArgumentPackage Claim :=
  { apocalyptic with
    name := "Apocalyptic reading, against faith as the condition"
    conclusion := notP .justificationByFaithAlone
    conclusionLabel := "justification is not by faith alone"
    inferences := [campbellOnDeliverance] }

/-- Sanders and Dunn: Judaism in Paul's day taught entry by grace and staying in by
obedience, so "works of the law" are the boundary markers. -/
@[solaFideDefs]
def sandersCase : ArgumentPackage Claim :=
  sandersLine.asPackage newPerspectiveCite "Paul's ‘works of the law’ is not works in general"

/-- Gathercole, and the volume edited by Carson, O'Brien and Seifrid: Judaism in
Paul's day was not simply that, so "works of the law" are works in general. -/
@[solaFideDefs]
def criticsCase : ArgumentPackage Claim :=
  criticsLine.asPackage criticsCite "Paul's ‘works of the law’ is works in general"

/-- Jervell: Luke shows the church keeping the law, so the yoke is not the law as a
condition of salvation. -/
@[solaFideDefs]
def jervellCase : ArgumentPackage Claim :=
  jervellLine.asPackage lawObservantLukeCite
    "the yoke of Acts 15:10 is not the law as a condition of salvation"

/-! ### Each position holds together and reaches its conclusion -/

/-- Paul's case reaches sola fide. -/
theorem paulineCase_establishes : Establishes paulineCase := by
  establish [solaFideDefs]

/-- Paul's case can be held without contradiction. -/
theorem paulineCase_is_satisfiable : Satisfiable paulineCase.premises := by
  satisfied_by criticsReading [solaFideDefs]

/-- Luke's case reaches its conclusion: faith suffices. -/
theorem dominicalCase_establishes : Establishes dominicalCase := by
  establish [solaFideDefs]

/-- Luke's case can be held without contradiction. -/
theorem dominicalCase_is_satisfiable : Satisfiable dominicalCase.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- Peter's case reaches sola fide. -/
theorem apostolicCase_establishes : Establishes apostolicCase := by
  establish [solaFideDefs]

/-- Peter's case can be held without contradiction. -/
theorem apostolicCase_is_satisfiable : Satisfiable apostolicCase.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- Trent's case reaches its conclusion: salvation is not apart from works. -/
theorem tridentineCase_establishes : Establishes tridentineCase := by
  establish [solaFideDefs]

/-- Trent's case can be held without contradiction. -/
theorem tridentineCase_is_satisfiable : Satisfiable tridentineCase.premises := by
  satisfied_by tridentineReading [solaFideDefs]

/-! #### Where Trent's objection comes from

Trent's objection to "not by works" is not a separate thesis about works. It
follows from what Trent says justification *is*: "not remission of sins merely,
but also the sanctification and renewal of the inward man" (ch. 7). Grant that.
Grant also that the renewal grows as the justified do good works (ch. 10). Then
good works increase justification (canon 24), which denies "not by works" (ch.
16). The Reformed grant the growth, which Westminster XIII.1 calls
sanctification, and deny the definition, because God justifies "not by infusing
righteousness into them, but by pardoning their sins" (XI.1). -/

/-- Trent's case with one change: its definition of justification is exchanged for
the Reformed distinction. Everything else Trent holds is kept, including that
the renewal grows through good works. -/
@[solaFideDefs]
def tridentineCaseOnTheReformedDistinction : ArgumentPackage Claim :=
  { tridentineCase with
    name := "Trent, on the Reformed distinction"
    premises :=
      tridentinePremises (tridentineLine.onGrounds [p .renewalGrowsThroughGoodWorks]) ++
        reformedOntology }

/-- Trent's position with the Reformed distinction in place of its definition. The
renewal grows, but it is sanctification, so it increases nothing called
justification, and salvation is not by works. -/
def reformedDistinctionReading : Valuation Claim := fun a =>
  match a with
  | .justificationIncludesSanctification => False
  | .worksMeritIncreaseOfJustification => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- **Trent's objection depends on its definition of justification.** Keep all of
Trent's case except the definition, put the Reformed distinction in its place,
and "salvation is not apart from works" no longer follows. Both sides still hold
that the renewal of the justified grows through good works.

So the disagreement over works comes down to what justification *is*: whether
the renewal that grows is part of justification, or is the sanctification that
follows it. -/
@[headline]
theorem trent_objection_rests_on_its_definition :
    ¬ Establishes tridentineCaseOnTheReformedDistinction := by
  refute_with reformedDistinctionReading [solaFideDefs]

#print axioms trent_objection_rests_on_its_definition

/-- The apocalyptic case reaches its conclusion. -/
theorem apocalypticCase_establishes : Establishes apocalypticCase := by
  establish [solaFideDefs]

/-- The apocalyptic case can be held without contradiction. -/
theorem apocalypticCase_is_satisfiable : Satisfiable apocalypticCase.premises := by
  satisfied_by apocalypticReading [solaFideDefs]

/-- Sanders' case reaches its conclusion. -/
theorem sandersCase_establishes : Establishes sandersCase := by
  establish [solaFideDefs]

/-- Sanders' case can be held without contradiction. -/
theorem sandersCase_is_satisfiable : Satisfiable sandersCase.premises := by
  satisfied_by sandersReading [solaFideDefs]

/-- The critics' case reaches its conclusion. -/
theorem criticsCase_establishes : Establishes criticsCase := by
  establish [solaFideDefs]

/-- The critics' case can be held without contradiction. -/
theorem criticsCase_is_satisfiable : Satisfiable criticsCase.premises := by
  satisfied_by criticsReading [solaFideDefs]

/-- Jervell's case reaches its conclusion. -/
theorem jervellCase_establishes : Establishes jervellCase := by
  establish [solaFideDefs]

/-- Jervell's case can be held without contradiction. -/
theorem jervellCase_is_satisfiable : Satisfiable jervellCase.premises := by
  satisfied_by lawObservantLukeReading [solaFideDefs]

/-- John's case reaches sola fide. -/
theorem johannineParty_establishes : Establishes johannineParty := by
  establish [solaFideDefs]

/-- Aquinas's case reaches its conclusion: the believing is not bare trust. -/
theorem aquinasCase_establishes : Establishes aquinasCase := by
  establish [solaFideDefs]

/-- John's case can be held without contradiction: on the Reformed reading, every
claim in it holds. -/
theorem johannineParty_is_satisfiable : Satisfiable johannineParty.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- Aquinas's case can be held without contradiction: on his own reading, the
believing of John 6:29 is faith formed by charity and not bare trust. -/
theorem aquinasCase_is_satisfiable : Satisfiable aquinasCase.premises := by
  satisfied_by thomistReading [solaFideDefs]

/-- Chrysostom's case reaches its conclusion, as the John section shows. -/
theorem chrysostomCase_establishes : Establishes chrysostomOnJohn :=
  chrysostom_reads_john3_36_against_faith_alone

/-- The Reformed answer to Chrysostom reaches its conclusion: faith suffices. -/
theorem sanctificationCase_establishes : Establishes sanctificationCase := by
  establish [solaFideDefs]

/-- The Reformed answer to Chrysostom can be held without contradiction: on the
Reformed reading, every claim in it holds. -/
theorem sanctificationCase_is_satisfiable : Satisfiable sanctificationCase.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- Chrysostom's position, with every verse of Paul's that the Reformed strands
read. Every text holds. Believing does not suffice without a right life, so faith
is not sufficient and justification is not by faith alone. With Rome, it takes
justification to include sanctification, and the readings of Matthew 7 and 19
that make obedience a condition. On the readings the meanings exclude, it takes
the Greek of Revelation 22:11 and Sirach 18:22, and that James does not use
"justify" as Paul does. -/
def chrysostomReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | .matthew7DoingIncludesBelieving => False
  | .matthew19LawExposesInability => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- **Chrysostom contradicts no text of Paul's.** His position can be held
together with every verse the Reformed strands read from Paul: Romans 3:28,
Galatians 2:16, Romans 4:4–5, Ephesians 2:8–9 and Titus 3:5.

Where Chrysostom stands against the Reformed case, he stands
against a reading of those verses, the step from them to faith alone, and not
against anything they say. His own reading of John 3:36 is weighed in the
debate on its own. -/
@[headline]
theorem chrysostom_grants_the_pauline_texts :
    Grants chrysostomOnJohn
      (⋀ [ p .romans3_28, p .galatians2_16, p .romans4_4_5, p .ephesians2_8_9
         , p .titus3_5 ]) := by
  satisfied_by chrysostomReading [Grants, solaFideDefs]

#print axioms chrysostom_grants_the_pauline_texts

/-! #### How strong each position is

Every position rests on something rated `disputed`, or denies a claim, which
ranks at the bottom. Between two such positions no rating blocks an attack.

The two arguments about Paul's word come nearest to an exception. Every link of
each is rated `wellSupported` or better but one, the step they share from the
courtroom sense of the verb to "and nothing more", which Trent grants the
starting points of and denies, because the justified "are not only reputed, but
are truly called, and are, just" (Session VI, ch. 7). -/

/-- Paul's case rests on its two disputed readings, and on the Reformed distinction.
All are rated `disputed`. -/
theorem paulineCase_strength : paulineCase.strength = 1 := by decide
/-- Luke's case uses a step that Trent's canon 9 denies, because faith without hope
and charity "neither unites man perfectly with Christ" (Session VI, ch. 7), so
its weakest link is `disputed`. Of its own two premises, the sense of "saved"
(σῴζω) is rated `wellSupported`. The reading of 7:47 is `disputed`, because
Marshall names the commentators who read her love as the cause of her
forgiveness. -/
theorem dominicalCase_strength : dominicalCase.strength = 1 := by decide
/-- Peter's case rests on the reading of the yoke, rated `disputed`. -/
theorem apostolicCase_strength : apostolicCase.strength = 1 := by decide
/-- Trent rests on its definition of justification, rated `disputed`. -/
theorem tridentineCase_strength : tridentineCase.strength = 1 := by decide
/-- The apocalyptic case denies that Galatians 2:16 speaks of faith *in* Christ,
reading it as Christ's own faithfulness, and a denial ranks at the bottom. -/
theorem apocalypticCase_strength : apocalypticCase.strength = 1 := by decide
/-- Sanders' case rests on his account of Judaism, rated `disputed`. -/
theorem sandersCase_strength : sandersCase.strength = 1 := by decide
/-- The critics' case denies that account, because Jewish texts of the period also
speak of final vindication according to works (Gathercole). -/
theorem criticsCase_strength : criticsCase.strength = 1 := by decide
/-- Jervell's step is contested, by Bruce. -/
theorem jervellCase_strength : jervellCase.strength = 1 := by decide
/-- Paul's gospel rests on its reading of Galatians, and on the step from a verdict
to "renewal is no part of justification". Both are rated `disputed`. -/
theorem galatianGospel_strength : galatianGospel.strength = 1 := by decide
/-- John's case rests on the Reformed distinction and on a step that Trent's canon 9
denies, because faith without hope and charity "neither unites man perfectly
with Christ" (Session VI, ch. 7), both `disputed`. Its own reading, believing as
trust, is `disputed` too: Aquinas denies it, because to believe in God as one's
end "is proper to faith living through the love of charity" (*Super Ioannem* 6,
lect. 3, n. 901). -/
theorem johannineParty_strength : johannineParty.strength = 1 := by decide
/-- Aquinas's case rests on his reading of John 6:29, rated `disputed`: Calvin
denies it, because faith "brings nothing to God, but, on the contrary, places man
before God as empty and poor, that he may be filled with Christ" (on John
6:29). -/
theorem aquinasCase_strength : aquinasCase.strength = 1 := by decide
/-- Luther's answer rests on his step, which Aquinas denies, because Paul
distinguishes faith "only from external works" (*Super Ioannem* 6, lect. 3,
n. 901), so a faith formed by charity does not justify by the law. -/
theorem lutherOnGalatians_strength : lutherOnGalatians.strength = 1 := by decide
/-- Chrysostom's case rests on his step, rated `disputed`: Calvin accepts both
texts and denies it, because the words of Matthew 7:21 "do not exclude faith,
but presuppose it as the principle from which other good works flow" (*Harmony*,
pp. 367–68). -/
theorem chrysostomCase_strength : chrysostomOnJohn.strength = 1 := by decide
/-- The Reformed answer rests on its reading of the obedience, rated `disputed`:
Chrysostom denies it, because "though a man believe rightly on the Father, the
Son, and the Holy Ghost, yet if he lead not a right life, his faith will avail
nothing towards his salvation" (*Homilies on John* 31). -/
theorem sanctificationCase_strength : sanctificationCase.strength = 1 := by decide
/-- **The argument from Paul's word rests on one disputed step.** That the verb is a
courtroom word, and the rule of least meaning, are `wellSupported`. That Paul
has other words for renewal is `consensus`. The step from them to "and so it
does not mean renewal" is `disputed`, because Trent grants those starting points
and denies it: the justified "are truly called, and are, just" (Session VI,
ch. 7). So its weakest link ranks at the bottom. -/
theorem lexicalCase_strength : lexicalCase.strength = 1 := by decide
/-- Trent, taken as a claim about Paul's word, rests on everything Trent rests on. -/
theorem tridentineOnPaulsWord_strength : tridentineOnPaulsWord.strength = 1 := by decide
/-- **So does Romans 4, read for Paul's word.** Its texts are rated `wellSupported`
or better. So are the sense of "count" (λογίζομαι), Paul's explanation and the
rule of least meaning. But it takes the same step from the rule of least
meaning, rated `disputed`. -/
theorem romansFourOnTheWord_strength : romansFourOnTheWord.strength = 1 := by decide

/-! #### The defeats

Each is worked out from the two positions' premises and checked by machine:
first whether one contradicts the other, then which is the weaker. -/

/-- **Trent defeats Paul's case.** Trent's case leads to the denial of "not by
works", because good works done in grace are "a cause of the increase" of
justification (canon 24), which contradicts the conclusion of Paul's. -/
theorem trent_defeats_pauline : Defeats tridentineCase paulineCase :=
  Horn.defeats_of_certified tridentineCase_strength paulineCase_strength (by horn_certify)

/-- **Trent defeats Luke's case.** Trent's definition, with canon 9, denies that
faith suffices, because faith "unless hope and charity be added thereto" does
not make one "a living member of His body" (Session VI, ch. 7), and that is
what Luke's case concludes. -/
theorem trent_defeats_dominical : Defeats tridentineCase dominicalCase :=
  Horn.defeats_of_certified tridentineCase_strength dominicalCase_strength (by horn_certify)

/-- **Trent defeats Peter's case**, as it defeats Paul's. -/
theorem trent_defeats_apostolic : Defeats tridentineCase apostolicCase :=
  Horn.defeats_of_certified tridentineCase_strength apostolicCase_strength (by horn_certify)

/-- **Paul's case defeats Trent in return.** It leads to "not by works", which Trent
denies, holding good works "a cause of the increase" of justification
(canon 24). -/
theorem pauline_defeats_trent : Defeats paulineCase tridentineCase :=
  Horn.defeats_of_certified paulineCase_strength tridentineCase_strength (by horn_certify)

/-- **Luke's case defeats Trent in return.** -/
theorem dominical_defeats_trent : Defeats dominicalCase tridentineCase :=
  Horn.defeats_of_certified dominicalCase_strength tridentineCase_strength (by horn_certify)

/-- **Peter's case defeats Trent in return.** -/
theorem apostolic_defeats_trent : Defeats apostolicCase tridentineCase :=
  Horn.defeats_of_certified apostolicCase_strength tridentineCase_strength (by horn_certify)

/-- **The apocalyptic reading defeats Trent.** It holds "not by works" by a step of
its own, since God's rescue depends on nothing a person does, and Trent denies
it, because the justified by good works "truly merit increase of grace"
(canon 32). -/
theorem apocalyptic_defeats_trent : Defeats apocalypticCase tridentineCase :=
  Horn.defeats_of_certified apocalypticCase_strength tridentineCase_strength (by horn_certify)

/-- **The apocalyptic reading defeats Paul's case.** It denies that Galatians 2:16
speaks of faith *in* Christ, a premise of Paul's strand rated `disputed`,
because it reads "faith of Christ" as Christ's own faithfulness (Martyn,
Campbell). -/
theorem apocalyptic_defeats_pauline : Defeats apocalypticCase paulineCase :=
  Horn.defeats_of_certified apocalypticCase_strength paulineCase_strength (by horn_certify)

/-- **Paul's case defeats the apocalyptic reading in return.** It leads to
justification by faith alone. -/
theorem pauline_defeats_apocalyptic : Defeats paulineCase apocalypticCase :=
  Horn.defeats_of_certified paulineCase_strength apocalypticCase_strength (by horn_certify)

/-- **Luke's case does not defeat the apocalyptic reading.** Luke 7:50 says that
faith saved her, not that faith alone does. The apocalyptic reading grants that
faith saves, and denies only that faith is the condition. So nothing in Luke's
case contradicts it (`luke_grants_the_apocalyptic_conclusion`). -/
theorem dominical_does_not_defeat_apocalyptic : ¬ Defeats dominicalCase apocalypticCase :=
  Horn.not_defeats_of_certified dominicalCase_strength apocalypticCase_strength (by horn_certify)

/-- **Nor does Peter's case**, for the same reason: Peter says that faith suffices,
not that faith alone does (`peter_grants_the_apocalyptic_conclusion`). -/
theorem apostolic_does_not_defeat_apocalyptic : ¬ Defeats apostolicCase apocalypticCase :=
  Horn.not_defeats_of_certified apostolicCase_strength apocalypticCase_strength (by horn_certify)

/-- **Sanders defeats Paul's case.** His account of Judaism, with Dunn's inference,
denies the reading of "works of the law" as works in general: if Judaism taught
entry by grace and staying in by obedience, what Paul refuses is not works as
such but the practices that kept gentiles out. -/
theorem sanders_defeats_pauline : Defeats sandersCase paulineCase :=
  Horn.defeats_of_certified sandersCase_strength paulineCase_strength (by horn_certify)

/-- **Paul's case defeats Sanders in return.** It holds the premise Sanders'
conclusion denies. -/
theorem pauline_defeats_sanders : Defeats paulineCase sandersCase :=
  Horn.defeats_of_certified paulineCase_strength sandersCase_strength (by horn_certify)

/-- **Sanders defeats the critics.** Their conclusions contradict. -/
theorem sanders_defeats_critics : Defeats sandersCase criticsCase :=
  Horn.defeats_of_certified sandersCase_strength criticsCase_strength (by horn_certify)

/-- **The critics defeat Sanders.** They deny the account of Judaism he starts from,
because Jewish texts of the period also speak of final vindication according to
works (Gathercole). -/
theorem critics_defeat_sanders : Defeats criticsCase sandersCase :=
  Horn.defeats_of_certified criticsCase_strength sandersCase_strength (by horn_certify)

/-- **Jervell defeats Peter's case.** He denies its reading of the yoke, because
Luke shows the Jewish believers keeping the law (Acts 21:20–24), and the
council's decree lays part of it on gentiles (Acts 15:20–21). -/
theorem jervell_defeats_apostolic : Defeats jervellCase apostolicCase :=
  Horn.defeats_of_certified jervellCase_strength apostolicCase_strength (by horn_certify)

/-- **Peter's case defeats Jervell in return.** It holds the premise his conclusion
denies. -/
theorem apostolic_defeats_jervell : Defeats apostolicCase jervellCase :=
  Horn.defeats_of_certified apostolicCase_strength jervellCase_strength (by horn_certify)

/-! #### What does not defeat

Most pairs of positions do not conflict: some consistent reading holds both.
Seven such readings are named below, each one a way of holding a whole group of
positions at once. Two pairs conflict in one direction only: each argument about
Paul's word defeats Trent taken as a claim about it, and is not defeated in
return. All of this, like every answer in the table, is worked out from the
premises. -/

/-- The critics' reading together with Jervell's: Sanders' account of Judaism is
denied, and the yoke is Israel's law for gentiles. Paul's case and Luke's hold
on it. Faith is the only means and justification is a verdict, so it denies
Trent's account of baptism as the instrument and of justification as including
sanctification. -/
def criticsJervellReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .secondTempleCovenantalNomism => False
  | .acts15YokeIsLawAsCondition => False
  | .baptismIsInstrumentalCause => False
  | .justificationIncludesSanctification => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- Trent's position together with Sanders' and Jervell's. With Trent, it denies
that faith is the only means of justification. -/
def trentSandersJervellReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .worksOfLawMeansWorksGenerally => False
  | .acts15YokeIsLawAsCondition => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- Trent's position together with the critics' and Jervell's. With Trent, it denies
that faith is the only means of justification. -/
def trentCriticsJervellReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .secondTempleCovenantalNomism => False
  | .acts15YokeIsLawAsCondition => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- The apocalyptic reading together with Sanders' and Jervell's. Justification is a
verdict only here, as on every reading but Trent's, so it does not include
sanctification. -/
def apocalypticSandersJervellReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | .worksOfLawMeansWorksGenerally => False
  | .acts15YokeIsLawAsCondition => False
  | .justificationIncludesSanctification => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- The apocalyptic reading together with the critics' and Jervell's. Justification
is a verdict only here, as on every reading but Trent's, so it does not include
sanctification. -/
def apocalypticCriticsJervellReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | .secondTempleCovenantalNomism => False
  | .acts15YokeIsLawAsCondition => False
  | .justificationIncludesSanctification => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- **The apocalyptic reading does not defeat Luke's case.** It contradicts nothing
Luke's case rests on: not Luke 7:50, not the sense of "saved", not the reading
of 7:47. And it does not deny the conclusion. It can grant that salvation is
received through faith while denying that faith is its condition. The reasons,
premise by premise, are in `apocalyptic_grants_sola_fide_as_stated` and
`apocalyptic_grants_the_dominical_step`. -/
theorem apocalyptic_does_not_defeat_dominical : ¬ Defeats apocalypticCase dominicalCase :=
  Horn.not_defeats_of_certified apocalypticCase_strength dominicalCase_strength (by horn_certify)

/-- **Nor Peter's case**, for the same reasons
(`apocalyptic_grants_the_apostolic_step`). -/
theorem apocalyptic_does_not_defeat_apostolic : ¬ Defeats apocalypticCase apostolicCase :=
  Horn.not_defeats_of_certified apocalypticCase_strength apostolicCase_strength (by horn_certify)

/-- **Trent defeats the apocalyptic reading.** The two agree on its conclusion:
justification is not by faith alone. But the apocalyptic reading *derives* "not
by works" on the way, since God's rescue is a gift that depends on nothing a
person does. Trent denies that: works done in grace merit an increase of
justification (Session VI, canon 32). So Trent contradicts something the
apocalyptic reading derives. -/
theorem trent_defeats_apocalyptic : Defeats tridentineCase apocalypticCase :=
  Horn.defeats_of_certified tridentineCase_strength apocalypticCase_strength (by horn_certify)

/-- **Paul's gospel defeats Trent.** It leads to the denial of Trent's definition:
justification is not the renewal of the inward person. `whereTrentPartsFromPaul`
says at which step. -/
theorem gospel_defeats_trent : Defeats galatianGospel tridentineCase :=
  Horn.defeats_of_certified galatianGospel_strength tridentineCase_strength (by horn_certify)

/-- **Trent defeats Paul's gospel in return**, by the same contradiction from the
other side. Its definition denies the gospel line's conclusion, and both rest on
something rated `disputed`. -/
theorem trent_defeats_gospel : Defeats tridentineCase galatianGospel :=
  Horn.defeats_of_certified tridentineCase_strength galatianGospel_strength (by horn_certify)

/-- **Paul's word defeats Trent taken as a claim about it.** Taken that way, Trent
derives that "justify" (δικαιόω) means renewal. The argument from the word
concludes that it does not. The attack succeeds because Trent's weakest link is
not above the argument's. -/
theorem lexical_defeats_trent_on_pauls_word : Defeats lexicalCase tridentineOnPaulsWord :=
  Horn.defeats_of_certified lexicalCase_strength tridentineOnPaulsWord_strength
    (by horn_certify)

/-- **And Trent defeats it in return.** Trent, taken as a claim about Paul's word,
attacks the argument from the word in turn. Trent's weakest link is its
definition, rated `disputed`, and so is the argument's: the step from the
courtroom sense to "and nothing more" is `disputed`, because Trent grants its
starting points and denies what it draws from them: the justified "are not only
reputed, but are truly called, and are, just" (Session VI, ch. 7). Between two
positions at the bottom no rating blocks an attack, so the two defeat each
other. -/
theorem trent_on_pauls_word_defeats_lexical : Defeats tridentineOnPaulsWord lexicalCase :=
  Horn.defeats_of_certified tridentineOnPaulsWord_strength lexicalCase_strength
    (by horn_certify)

/-! #### Why these do not conflict

The absences above are worked out by machine, and a machine's working gives no
reason. The readings below do. Each is a way of holding one position that leaves
a premise or conclusion of another standing, and each result checks that the
reading holds everything the first position holds. -/

/-- The apocalyptic reading with salvation still received through faith: faith is
not the condition, but it is the means. Grace and "not by works" hold.
Justification is a verdict only here, as on every reading but Trent's, so it
does not include sanctification. -/
def apocalypticWithFaithReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | .justificationIncludesSanctification => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- **The apocalyptic reading can grant what the Reformed strands conclude.** Grace,
"not by works", and salvation received through faith can all hold on it. What it
denies is that faith is the condition. So it contradicts neither Luke's case nor
Peter's. -/
theorem apocalyptic_grants_sola_fide_as_stated :
    Grants apocalypticCase dominicalCase.conclusion := by
  satisfied_by apocalypticWithFaithReading [Grants, solaFideDefs]

/-- **The apocalyptic reader can grant Luke's step.** The step delivers that faith
suffices, "your faith has saved you", and the apocalyptic reading can hold that:
faith is the means, though not the condition. -/
theorem apocalyptic_grants_the_dominical_step :
    Grants apocalypticCase dominicalToSufficiency := by
  satisfied_by apocalypticWithFaithReading [Grants, solaFideDefs]

/-- **And Peter's step**, for the same reason: Peter says that faith suffices, and
the apocalyptic reading does not deny it. -/
theorem apocalyptic_grants_the_apostolic_step :
    Grants apocalypticCase apostolicToSufficiency := by
  satisfied_by apocalypticWithFaithReading [Grants, solaFideDefs]

/-- Luke's case without *alone*: every premise of the case, faith sufficient, and
justification not by faith alone, because nothing Luke says excludes another
condition. Justification is a verdict only here, as on every reading but
Trent's, so it does not include sanctification. -/
def lukeWithoutAloneReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .justificationByFaithAlone => False
  | .justificationIncludesSanctification => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- **Luke's case can grant the apocalyptic conclusion.** Everything Luke's case
holds is consistent with justification not being by faith alone, so it does not
contradict the apocalyptic reading. Among the cases from Paul, Luke and Acts,
only Paul's, which argues for *alone*, does. -/
theorem luke_grants_the_apocalyptic_conclusion :
    Grants dominicalCase apocalypticCase.conclusion := by
  satisfied_by lukeWithoutAloneReading [Grants, solaFideDefs]

/-- **And so can Peter's case.** -/
theorem peter_grants_the_apocalyptic_conclusion :
    Grants apostolicCase apocalypticCase.conclusion := by
  satisfied_by lukeWithoutAloneReading [Grants, solaFideDefs]

/-- Trent's position, with both of these denied: that Galatians 2:16 speaks of faith
*in* Christ, and that "the righteousness of God" is God's act of rescue. With
Trent, it denies that faith is the only means of justification. -/
def trentWithoutDeliveranceReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .pistisChristouObjective => False
  | .righteousnessOfGodIsDeliverance => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- **Trent can grant Hays's reading of "faith of Christ".** Nothing Trent holds
settles how the phrase (πίστις Χριστοῦ, "faith in Christ" or "faithfulness of Christ") is read, so
the apocalyptic reading's denial that it means faith *in* Christ is not something Trent answers. -/
theorem trent_grants_the_subjective_genitive :
    Grants tridentineCase (notP .pistisChristouObjective) := by
  satisfied_by trentWithoutDeliveranceReading [Grants, solaFideDefs]

/-- Trent's position, on which justification is not by faith alone. That is the
apocalyptic reading's conclusion, which Trent shares. -/
def trentWithoutFaithAloneReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationByFaithAlone => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- **Trent grants the apocalyptic reading's conclusion**: justification is not by
faith alone. The two hold it for different reasons, so Trent does not contradict
that conclusion. -/
theorem trent_grants_the_apocalyptic_conclusion :
    Grants tridentineCase apocalypticCase.conclusion := by
  satisfied_by trentWithoutFaithAloneReading [Grants, solaFideDefs]

/-! ### The dispute -/

/-- The positions heard in the debate over sola fide. -/
inductive Party
  /-- Sola fide from Paul. -/
  | pauline
  /-- Sola fide from Jesus' words at Luke 7:50. -/
  | dominical
  /-- Sola fide from Peter at Jerusalem. -/
  | apostolic
  /-- Trent, against "not by works". -/
  | trent
  /-- The apocalyptic reading, against faith as the condition. -/
  | apocalyptic
  /-- Sanders and Dunn, against reading "works of the law" as works in general. -/
  | sanders
  /-- Gathercole, and Carson, O'Brien and Seifrid, for that reading. -/
  | critics
  /-- Jervell, against the yoke as the law as a condition of salvation. -/
  | jervell
  /-- Paul's gospel in Galatians, against Trent's definition. -/
  | gospel
  /-- Paul's word, read by the rule of least meaning: "justify" (δικαιόω) does not
  mean renewal. Heard with the Reformed answers to the Catholic roads from the
  Greek: Hodge and Calvin on Romans 5:19, Ziesler on its adjective, and Calvin on
  the verdict. -/
  | lexical
  /-- Trent, with its definition taken as a claim about Paul's word, at its
  strongest: on Augustine's explanation, and on Fitzmyer's and Kertelge's roads
  from the Greek. -/
  | trentOnPaulsWord
  /-- Romans 4:3–8, read for what Paul's word means: the same conclusion as the
  argument from usage, reached from one passage. -/
  | romansOnTheWord
  /-- Sola fide from Jesus' answer in John 6:28–29. -/
  | johannine
  /-- Aquinas, against reading the believing of John 6:29 as bare trust. -/
  | aquinas
  /-- Luther on Galatians 3:11–12, against faith formed by charity. -/
  | luther
  /-- Chrysostom on John 3:36 and Matthew 7:21: believing is not enough without a
  right life. -/
  | chrysostom
  /-- The Reformed answer: the obedience those texts require is sanctification,
  the fruit of faith. -/
  | sanctification
deriving DecidableEq

/-- The premises each position argues from. -/
@[solaFideDefs]
def partyNode : Party → ArgumentPackage Claim
  | .pauline => paulineCase
  | .dominical => dominicalCase
  | .apostolic => apostolicCase
  | .trent => tridentineCase
  | .apocalyptic => apocalypticCase
  | .sanders => sandersCase
  | .critics => criticsCase
  | .jervell => jervellCase
  | .gospel => galatianGospel
  | .lexical => lexicalCaseAnsweringTheGreek
  | .trentOnPaulsWord => tridentineOnPaulsWordAtItsStrongest
  | .romansOnTheWord => romansFourOnTheWord
  | .johannine => johannineParty
  | .aquinas => aquinasCase
  | .luther => lutherOnGalatians
  | .chrysostom => chrysostomOnJohn
  | .sanctification => sanctificationCase

/-- The debate over sola fide. For every position heard: its premises can be held
without contradiction, its conclusion follows from them, and every step it uses
is rated. -/
declare_dispute solaFideDispute := partyNode using solaFideDefs pruned rows 6
  /-- **Who defeats whom**, for all 289 pairs of positions.

  Trent and each Reformed strand defeat each other. The apocalyptic reading and
  Paul's case defeat each other; it does not conflict with Luke's case or Peter's;
  it and Trent defeat each other. Sanders defeats Paul's case and the critics',
  and both defeat him in return. Jervell and Peter's case defeat each other.
  Paul's gospel and Trent defeat each other, over Trent's definition. John's case
  meets Trent, the apocalyptic reading and Aquinas, each in both directions, and
  Aquinas and Luther defeat each other. Trent taken as a claim about Paul's word
  meets every position Trent meets, in both directions, and two more: it and the
  two arguments about Paul's word defeat each other. Nothing else. Every defeat in
  the table runs both ways, so no position here defeats another without being
  defeated by it in return.

  Every one of the 289 answers, the defeats and the absences alike, is worked out
  from the positions' premises and checked by machine. The table above is what
  that working is checked against. None of it is assumed. -/
  defeats
    [ (.trent, .pauline), (.trent, .dominical), (.trent, .apostolic), (.pauline, .trent)
    , (.dominical, .trent), (.apostolic, .trent), (.apocalyptic, .trent)
    , (.trent, .apocalyptic), (.apocalyptic, .pauline), (.pauline, .apocalyptic)
    , (.sanders, .pauline), (.pauline, .sanders), (.sanders, .critics), (.critics, .sanders)
    , (.jervell, .apostolic), (.apostolic, .jervell), (.gospel, .trent), (.trent, .gospel)
    , (.gospel, .trentOnPaulsWord), (.trentOnPaulsWord, .gospel)
    , (.lexical, .trentOnPaulsWord), (.romansOnTheWord, .trentOnPaulsWord)
    , (.trentOnPaulsWord, .lexical), (.trentOnPaulsWord, .romansOnTheWord)
    , (.pauline, .trentOnPaulsWord), (.dominical, .trentOnPaulsWord)
    , (.apostolic, .trentOnPaulsWord), (.apocalyptic, .trentOnPaulsWord)
    , (.trentOnPaulsWord, .pauline), (.trentOnPaulsWord, .dominical)
    , (.trentOnPaulsWord, .apostolic), (.trentOnPaulsWord, .apocalyptic)
    , (.trent, .johannine), (.johannine, .trent), (.trentOnPaulsWord, .johannine)
    , (.johannine, .trentOnPaulsWord), (.apocalyptic, .johannine)
    , (.johannine, .apocalyptic), (.aquinas, .johannine), (.johannine, .aquinas)
    , (.luther, .aquinas), (.aquinas, .luther), (.chrysostom, .pauline)
    , (.pauline, .chrysostom), (.chrysostom, .dominical), (.dominical, .chrysostom)
    , (.chrysostom, .apostolic), (.apostolic, .chrysostom), (.chrysostom, .johannine)
    , (.johannine, .chrysostom), (.chrysostom, .sanctification)
    , (.sanctification, .chrysostom), (.trent, .sanctification), (.sanctification, .trent)
    , (.trentOnPaulsWord, .sanctification), (.sanctification, .trentOnPaulsWord) ]
  /-- **No position supports another** in this debate, in any of the 289 pairs. One
  position supports another when its conclusion gives the other a claim it rests
  on. The critics' conclusion used to be one of Paul's premises. Now Paul's case
  contains the critics' whole line (`paulineCase`), which is the closer relation
  recorded below. The Reformed strands share a conclusion; that is agreement, not
  support (see `Testimony.Logic.Support`). Every answer is worked out and checked
  by machine. -/
  supports []
  /-- **Whose case is contained in whose**, for all 289 pairs. The critics' case is
  contained in Paul's, since Paul's case derives its reading of "works of the law"
  from the critics' line. Trent's case is contained in Trent taken as a claim
  about Paul's word, which only adds to it. Every case contains itself. Nothing
  else. Every answer is worked out and checked by machine. -/
  partOf [(.critics, .pauline), (.trent, .trentOnPaulsWord)]
  /-- The debate drawn as a map: who defeats whom, and whose case is contained in
  whose. -/
  map solaFideMap

/-- Paul's, Luke's and Peter's cases can be held together with the critics', on the
reading where Sanders' account of Judaism is denied and everything else holds. -/
theorem reformed_strands_stand_with_the_critics :
    solaFideDispute.StandTogether [.pauline, .dominical, .apostolic, .critics] := by
  satisfied_by criticsReading [Dispute.StandTogether, solaFideDefs]

/-- Paul's case and Luke's can be held together with the critics' and with
Jervell's. -/
theorem paul_and_luke_stand_with_jervell :
    solaFideDispute.StandTogether [.pauline, .dominical, .jervell, .critics] := by
  satisfied_by criticsJervellReading [Dispute.StandTogether, solaFideDefs]

/-- Luke's case and Peter's can be held together with Sanders': neither rests on the
reading of "works of the law". -/
theorem luke_and_acts_stand_with_sanders :
    solaFideDispute.StandTogether [.dominical, .apostolic, .sanders] := by
  satisfied_by newPerspectiveOwnReading [Dispute.StandTogether, solaFideDefs]

/-- Trent can be held together with Sanders and Jervell. -/
theorem trent_stands_with_sanders_and_jervell :
    solaFideDispute.StandTogether [.trent, .sanders, .jervell] := by
  satisfied_by trentSandersJervellReading [Dispute.StandTogether, solaFideDefs]

/-- Trent can be held together with the critics and Jervell. -/
theorem trent_stands_with_the_critics_and_jervell :
    solaFideDispute.StandTogether [.trent, .critics, .jervell] := by
  satisfied_by trentCriticsJervellReading [Dispute.StandTogether, solaFideDefs]

/-- The apocalyptic reading can be held together with Sanders and Jervell. -/
theorem apocalyptic_stands_with_sanders_and_jervell :
    solaFideDispute.StandTogether [.apocalyptic, .sanders, .jervell] := by
  satisfied_by apocalypticSandersJervellReading [Dispute.StandTogether, solaFideDefs]

/-- The apocalyptic reading can be held together with the critics and Jervell. -/
theorem apocalyptic_stands_with_the_critics_and_jervell :
    solaFideDispute.StandTogether [.apocalyptic, .critics, .jervell] := by
  satisfied_by apocalypticCriticsJervellReading [Dispute.StandTogether, solaFideDefs]

/-! ### Trent's definition, and the answers to it, in the order they came -/

/-- The arguments from Paul's word, from usage and from Romans 4, share no claim
with Trent as Trent states it, and no meaning that joins two of their claims. -/
theorem the_word_arguments_share_nothing_with_trent :
    solaFideDispute.shares .lexical .trent = false ∧
      solaFideDispute.shares .romansOnTheWord .trent = false := by
  decide +kernel

/-- **Trent's definition, and the answers to it, in the order they were given.**
In 1547 the Council of Trent defined justification as "not remission of sins
merely, but also the sanctification and renewal of the inward man" (Session VI,
ch. 7). A century later the Westminster Assembly answered from Paul's letter to
the Galatians. In 1993 Joseph Fitzmyer gave Trent's reading of Paul's word two
roads from the Greek, and scholars of word meaning answered on the word. Paul
wrote long before any of them, so each turn is a later reader's reading, named
with the work it comes from and that work's date.

The arguments from Paul's word answer Trent only when Trent is read as a claim
about that word. They share no claim with the definition as the council states
it, and no meaning (`the_word_arguments_share_nothing_with_trent`), so told as
replies to it they would change the subject, the fault called a red herring. The
sentence after each turn, saying who defeats whom, is computed from the two
positions' premises, whatever their dates. -/
declare_bundle trentsDefinitionExchange in solaFideDispute.finite where
  /-- The council defines justification as the renewal of the inward person, and
  holds that the renewal grows as the justified do good works (ch. 10). So good
  works increase justification (canon 24), and salvation is not apart from
  works. -/
  turn Party.trent from trentSessionVI
  /-- The Westminster Confession denies the definition, because God justifies "not
  by infusing righteousness into them, but by pardoning their sins" (XI.1), and
  reads Galatians as Douglas Moo reads it today. The teachers Paul opposed added
  circumcision to faith in Christ, and he called the addition a different gospel
  (1:6–9). Read with the courtroom sense of "justify", Christ's work is the
  whole ground of justification, so the renewal worked in us is no part of it.
  Trent accepts every text and denies that nothing is added, because good works
  done in grace are "a cause of the increase" of justification (canon 24) and
  "truly merit increase of grace" (canon 32), so the step is rated `disputed`.
  -/
  turn Party.gospel meets Party.trent from westminsterConfession
  /-- Read as a claim about Paul's word, Trent's definition says that "justify"
  (δικαιόω) in Paul means renewal, as Augustine explained the Latin word: "what
  else does the phrase 'being justified' signify than being made righteous" (*On
  the Spirit and the Letter* 26.45). Joseph Fitzmyer, a Catholic exegete, gave
  that reading two roads from the Greek: Romans 5:19, "the many will be made
  righteous", and Karl Kertelge's verdict that does what it says (*Romans*,
  118–19). So set out, Trent's conclusion defeats each position that defeated
  the definition as the council states it. -/
  turn Party.trentOnPaulsWord restates Party.trent from fitzmyerRomans
  /-- Scholars of word meaning answer on the word. "Justify" is a courtroom word,
  Paul has other words for renewal and sets them beside it (Titus 3:5–7;
  1 Corinthians 6:11), and a word contributes the least meaning its context
  requires (Joos, 1972; Silva). Hodge (1864) and Ziesler (1972) had already
  answered the readings of Romans 5:19 that Fitzmyer relies on, and Calvin the
  verdict that renews. The step to "and nothing more" is rated `disputed`,
  because Trent grants where it starts and denies where it ends: the justified
  "are not only reputed, but are truly called, and are, just" (Session VI,
  ch. 7). -/
  turn Party.lexical meets Party.trentOnPaulsWord from silvaBiblicalWords
  /-- Douglas Moo reads Romans 4 the same way. Paul explains the righteousness
  God counts to the ungodly as sin not counted (4:6–8), and by the same rule the
  verb he explains that way does not also mean renewal. Augustine reads the
  passage the other way, so this step too is rated `disputed`. -/
  turn Party.romansOnTheWord meets Party.trentOnPaulsWord from mooRomans

/-! ### What the dispute decides -/

/-- Why nothing is forced: every position has an attacker that no rating rules out.
Each Reformed strand has Trent. Trent has Paul's case. The apocalyptic reading
has Paul's case. Sanders has the critics, and the critics have Sanders. Jervell
has Peter's case. Paul's gospel has Trent. Aquinas has Luther, and Luther has
Aquinas. Trent taken as a claim about Paul's word has the argument from the
word, and the two arguments about the word have Trent taken that way. Every one
of these is a tie, or meets one: each attacked position answers its attacker,
or is answered by a position that does. -/
declare_verdict nothingForcedUnanswered for solaFideDispute :
    .nothingGrounded
      [ (.pauline, .trent), (.dominical, .trent), (.apostolic, .trent), (.trent, .pauline)
      , (.apocalyptic, .pauline), (.sanders, .critics), (.critics, .sanders)
      , (.jervell, .apostolic), (.gospel, .trent), (.trentOnPaulsWord, .lexical)
      , (.lexical, .trentOnPaulsWord), (.romansOnTheWord, .trentOnPaulsWord)
      , (.johannine, .trent), (.aquinas, .luther), (.luther, .aquinas)
      , (.chrysostom, .pauline), (.sanctification, .trent) ]
  /-- **Nothing prevails outright.** Heard together, the debate forces no position,
  not even the meaning of Paul's word. Every position is attacked by one the
  debate cannot rule out, and every weakest link is rated `disputed` or denies a
  claim, so no rating breaks a tie.

  The two arguments about Paul's word, from how the word is used and from
  Romans 4, used to prevail here. Both take the same step: from the courtroom
  sense of "justify" (δικαιόω), and the rule that a word means no more than its
  context requires, to "and so it does not mean renewal". That step is rated
  `disputed`, because a cited reader grants its starting points and denies its
  conclusion. Trent keeps the verdict, for the justified "are not only reputed,
  but are truly called, and are, just" (Session VI, ch. 7), and Augustine gives
  the courtroom sense himself, "deemed, or reckoned as just" (*On the Spirit and
  the Letter* 26.45), beside "made righteous". So Trent, taken as a claim about
  Paul's word, and the arguments about the word now defeat each other, and the
  debate cannot choose between them.

  The tie leaves every position defensible, and none loses (`pauls_word_defensible`,
  `trent_on_pauls_word_defensible`). What would move the verdict is an argument
  that answers Trent at that step from evidence both sides accept.

  Both sides are heard here at their strongest. Trent on Paul's word has, beside
  Augustine's explanation, Fitzmyer's two roads from the Greek: Romans 5:19, "the
  many will be made righteous", and Kertelge's effective verdict
  (`tridentineOnPaulsWordAtItsStrongest`). The argument from Paul's word has the
  Reformed answer to each: Hodge and Calvin read 5:19 as a standing, Ziesler
  holds that its adjective does not settle the verb, and Calvin that the renewal
  comes with the verdict and not from it (`lexicalCaseAnsweringTheGreek`). Every
  one of those readings has a cited reader who denies it, so the new attacks are
  ties too, and the verdict is the one the narrower positions gave. Romans 6:7
  and 1 Corinthians 6:11, which readers also take both ways, are not yet
  heard. -/
  proves @[headline] sola_fide_dispute_forces_nothing

#print axioms sola_fide_dispute_forces_nothing

/-- Why the argument from Paul's word can be defended: with Romans 4, read for the
word, it answers its one attacker, Trent taken as a claim about Paul's word,
which both defeat. -/
declare_verdict paulsWordStandsWithRomansFour for solaFideDispute :
    .credulous .lexical [.lexical, .romansOnTheWord]
  /-- **The argument from Paul's word can be defended.** A consistent set of
  positions holds it with Romans 4, read for the word, and answers every attack.
  Its one attacker is Trent taken as a claim about Paul's word, and both
  arguments defeat that in return. -/
  proves @[headline] pauls_word_defensible

#print axioms pauls_word_defensible

/-- Why the argument from Paul's word is not forced: a set of positions that can be
defended holds Trent, taken as a claim about Paul's word, with Trent as Trent
states it, Sanders and Jervell, and that reading of Trent defeats the
argument. -/
declare_verdict paulsWordAnsweredByTrent for solaFideDispute :
    .notSkeptical .lexical .trentOnPaulsWord [.trentOnPaulsWord, .trent, .sanders, .jervell]
  /-- **Nor is the argument from Paul's word forced.** A consistent set of positions
  that answers every attack holds Trent, taken as a claim about Paul's word, and
  cannot hold the argument from the word with it. The two are in a tie at the
  step from the courtroom sense to "and nothing more", which Trent grants the
  starting points of and denies, because the justified "are truly called, and
  are, just" (Session VI, ch. 7). -/
  proves @[headline] pauls_word_not_forced

#print axioms pauls_word_not_forced

/-- Why Trent, taken as a claim about Paul's word, can be defended: it can be held
with Trent as Trent states it, Sanders and Jervell, and it answers every
position that defeats it. -/
declare_verdict trentsWordReadingStands for solaFideDispute :
    .credulous .trentOnPaulsWord [.trentOnPaulsWord, .trent, .sanders, .jervell]
  /-- **Trent, taken as a claim about Paul's word, can be defended.** A consistent set
  of positions includes it, with Trent as Trent states it, Sanders and Jervell,
  and answers every attack. The two arguments about Paul's word defeat it, and it
  defeats both in return, because the step they share is rated `disputed`.

  Trent's definition can be taken two ways. This is the first, weighed in the
  debate (`whatTrentsDefinitionClaims`): the definition read as saying what
  Paul's "justify" means. Read so, it is defensible and no more: it is in a tie
  with each position that attacks it, and a defended set can leave it out
  (`pauls_word_defensible`). -/
  proves @[headline] trent_on_pauls_word_defensible

#print axioms trent_on_pauls_word_defensible

/-- Why Trent can be defended: it can be held with Sanders and Jervell, and it
answers every position that attacks it. Those are each Reformed strand, Paul's
gospel, and the apocalyptic reading, whose "not by works" it denies, because good
works done in grace are "a cause of the increase" of justification (canon 24). -/
declare_verdict trentStandsWithSandersAndJervell for solaFideDispute :
    .credulous .trent [.trent, .sanders, .jervell]
  /-- **Trent can be defended.** A consistent set of positions includes it, with
  Sanders and Jervell, and answers every attack. Every position that defeats
  Trent, Trent defeats in return: Paul's case, Luke's, Peter's, John's, Paul's
  gospel, the apocalyptic reading, and the Reformed answer to Chrysostom. The
  ratings, all at the bottom, break no tie.

  The arguments about Paul's word do not attack it. Trent's definition, taken as
  it stands, says nothing about what "justify" means. Trent is defensible and no
  more: it is in a tie with each of those seven positions, and a defended set can
  leave it out (`trent_not_forced`). -/
  proves @[headline] trent_defensible

#print axioms trent_defensible

/-- Why Trent is not forced: a set of positions that can be defended includes Paul's
case, and Paul's case defeats Trent. -/
declare_verdict trentAnsweredByPaul for solaFideDispute :
    .notSkeptical .trent .pauline [.pauline, .dominical, .apostolic, .critics]
  /-- **Nor is Trent forced.** A consistent set of positions that answers every attack
  holds Paul's case with Luke's and Peter's, and none of them can be held with
  Trent. -/
  proves @[headline] trent_not_forced

#print axioms trent_not_forced

/-- Why the apocalyptic reading can be defended: it can be held with Luke's case,
Peter's and the critics', and it answers every position that defeats it. Those
are Paul's case, John's, Trent, and Trent taken as a claim about Paul's word. -/
declare_verdict apocalypticStandsWithLuke for solaFideDispute :
    .credulous .apocalyptic [.dominical, .apostolic, .apocalyptic, .critics]
  /-- **The apocalyptic reading can be defended.** A consistent set of positions
  includes it and answers every attack, and that set holds Luke's case and Peter's
  too. They claim that faith saves, and the apocalyptic reading grants that,
  denying only that faith is the condition. Of the cases from Paul, Luke and Acts,
  only Paul's defeats it, and it defeats Paul's in return, over "faith of Christ".
  Trent it defeats in return over "not by works".

  So the disagreement between the Reformed reading and the apocalyptic one lies
  where scholars place it: between Paul and Campbell, over "faith of Christ"
  (πίστις Χριστοῦ). It does not lie between Campbell and Luke. -/
  proves @[headline] apocalyptic_defensible

#print axioms apocalyptic_defensible

/-- Why the apocalyptic reading is not forced: a set of positions that can be
defended includes Paul's case, and Paul's case defeats it. -/
declare_verdict apocalypticAnsweredByPaul for solaFideDispute :
    .notSkeptical .apocalyptic .pauline [.pauline, .dominical, .apostolic, .critics]
  /-- **Nor is it forced.** A consistent set of positions that answers every attack
  holds Paul's case, faith alone from Galatians 2:16 read as faith *in* Christ,
  and cannot hold the apocalyptic reading with it. Between Paul and Campbell the
  debate chooses neither: each can be defended, and neither is forced. -/
  proves @[headline] apocalyptic_not_forced

#print axioms apocalyptic_not_forced

/-- Why Luke's case can be defended: it can be held with Peter's, the apocalyptic
reading and the critics', and it answers every position that defeats it: Trent,
Trent taken as a claim about Paul's word, and Chrysostom. -/
declare_verdict lukeStandsWithPeter for solaFideDispute :
    .credulous .dominical [.dominical, .apostolic, .apocalyptic, .critics]
  /-- **Luke's case can be defended.** "Your faith has saved you", read as Luke gives
  it, can be held with every position but Trent, however Trent's definition is
  taken, and Chrysostom. Those are its only attackers, and Luke's case defeats
  each in return. Against Trent the point at issue is what justification is:
  Trent's definition denies that faith without charity suffices, since faith
  "unless hope and charity be added thereto" does not make one "a living member
  of His body" (Session VI, ch. 7), and Luke's words say her faith saved her.
  Against Chrysostom it is whether the right life Jesus requires elsewhere (John
  3:36, Matthew 7:21) is a second condition beside faith. -/
  proves @[headline] dominical_case_defensible

#print axioms dominical_case_defensible

/-- Why Luke's case is not forced: a set of positions that can be defended includes
Trent, and Trent defeats it. -/
declare_verdict lukeAnsweredByTrent for solaFideDispute :
    .notSkeptical .dominical .trent [.trent, .sanders, .jervell]
  /-- **Luke's case is not forced.** A consistent set of positions that answers every
  attack holds Trent, and cannot hold Luke's case with it.

  Between Trent and each Reformed strand, the debate chooses neither. Their
  weakest links are all `disputed`, so no rating breaks a tie, and every attack
  between them runs in both directions.

  What would decide between them is what justification *is*. No rating here
  settles that. `whyTheDominicalCaseStandsAgainstTrent` places Luke's disagreement
  with Trent at Trent's definition. `whereTrentPartsFromPaul`, in the chapter
  "Where Trent parts from Paul", places Paul's at one step: that a verdict on
  Christ's finished work excludes the renewal worked in us. The ratings do not
  decide even the meaning of Paul's word: Trent's reading of it ties with the
  arguments from the word (`trent_on_pauls_word_defensible`). -/
  proves @[headline] dominical_case_not_forced

#print axioms dominical_case_not_forced

/-- Why Paul's gospel can be defended: it can be held with Paul's case, Luke's,
Peter's, the critics' and the argument from Paul's word, and it answers both
positions that defeat it. Those are Trent, and Trent taken as a claim about
Paul's word. -/
declare_verdict gospelStandsWithTheStrands for solaFideDispute :
    .credulous .gospel [.gospel, .pauline, .dominical, .apostolic, .critics, .lexical]
  /-- **Paul's gospel can be defended**, together with Paul's, Luke's and Peter's
  cases and with the argument from Paul's word. A consistent set of positions that
  answers every attack holds them all. -/
  proves @[headline] gospel_defensible

#print axioms gospel_defensible

/-- Why Paul's gospel is not forced: a set of positions that can be defended
includes Trent, and Trent defeats it. -/
declare_verdict gospelAnsweredByTrent for solaFideDispute :
    .notSkeptical .gospel .trent [.trent, .sanders, .jervell]
  /-- **Nor is it forced.** Trent as Trent states it can still be defended, and Paul's
  gospel cannot be held with it. What would decide between them is the step
  `whereTrentPartsFromPaul` names, that a verdict on Christ's finished work
  excludes renewal, and that step is rated `disputed`. The argument from Paul's
  word does not decide it. Taken as a claim about what God does, Trent's
  definition is not reached by anything the word's meaning shows
  (`lexical_case_does_not_reach_what_god_does`). -/
  proves @[headline] gospel_not_forced

#print axioms gospel_not_forced

/-! #### Where Luke's case and Trent part

The verdicts above say that Luke's case and Trent defeat each other, and that
the debate chooses neither. This says *why*, claim by claim. The two part over
what justification *is*. Trent defines it as the renewal of the inward person by
charity poured in, and from that definition it follows that faith without
charity does not suffice. Luke's words say that her faith saved her. -/

/-- **Why Luke's case stands against Trent.** Everything turns on Luke's own step:
from "your faith has saved you", with "saved" (σῴζω) read as saved from sin and
her love as the evidence of forgiveness, to the conclusion that faith suffices.

Trent cannot hold that step together with Luke's words. Two things in Trent's
case contradict it, and both are needed: its definition of justification as the
renewal of the inward person (Session VI, ch. 7), and the step from that
definition to denying that faith suffices (canon 9). Nothing else in Trent's
case does: not its account of merit, and not its reading of works.

So the disagreement is not over what Luke says. It is over what justification
is. Grant Trent's definition, and "your faith has saved you" cannot mean that
faith sufficed. Grant that it did, and Trent's definition cannot stand. -/
def whyTheDominicalCaseStandsAgainstTrent : Because dominicalCase tridentineCase :=
  Because.ofChecks dominicalToSufficiency
    ([p .luke7_50FaithHasSavedYou] ++ dominicalLine.grounds) []
    ([p .luke7_50FaithHasSavedYou] ++ dominicalLine.grounds)
    [ p .justificationIncludesSanctification
    , p .justificationIncludesSanctification ➝ notP .faithIsSufficient ]
    .derives dominicalCase_establishes dominicalCase_is_satisfiable
    (by simp [dominicalCase, dominicalLine, Line.premises])
    (by simp [dominicalCase, dominicalLine, Line.premises])
    (by simp [solaFideDefs, trentDefinitionSteps, Line.premises])
    (by decide +kernel)
  |>.ratedBy trentAgainstFaithAlone (by simp [dominicalCase, solaFideDefs])

end TestimonyArguments.SolaFide
