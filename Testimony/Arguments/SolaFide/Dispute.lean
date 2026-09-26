import Testimony.Arguments.SolaFide.Results
import Testimony.Logic.Dispute
import Testimony.Logic.Horn
import Testimony.Logic.Solver
import Testimony.Logic.Verdict
import Testimony.Logic.Map
import Testimony.Logic.Because

/-!
# Arguments.SolaFide.Dispute — who prevails over sola fide

The results in `Results.lean` ask what each package entails. This module asks
what happens when the positions meet: the three Reformed strands, each argued
alone; Trent; the apocalyptic reading of Martyn and Campbell; Sanders and Dunn on
covenantal nomism, and the critics who answer them; and Jervell on the yoke of
Acts 15. Who defeats whom is not stipulated — each defeat, and each absence of
one, is a theorem about the positions' premises (see `Testimony.Logic.Dispute`).

## The ratings decide nothing here

Every party's weakest link is `disputed`: each Reformed strand's inference is
rated at Trent's canon 9, which denies it; Paul's and Peter's cases hold the
Reformed distinction between justification and sanctification, which Trent
anathematises; Trent rests on its own definition of justification, which
Westminster denies;
the apocalyptic reading denies an atom (and a denial ranks at the bottom); and
so on. So no rating blocks any attack, and the outcome is fixed entirely by who
contradicts whom.
That is unlike the dispute over Isaiah 7:14, where one inference rated
`plausible` carried the verdict.

## Who defeats whom

- **Trent and each Reformed strand defeat each other.** Paul's and Peter's
  cases conclude "not by works", which Trent denies; and Trent's definition of
  justification — the renewal of the inward man — contradicts the distinction
  between justification and sanctification they hold. That is where the
  objection comes from: with the distinction in place of the definition, Trent's
  case no longer denies "not by works"
  (`trent_objection_rests_on_its_definition`). Luke's case holds only Luke's
  words, and meets Trent over faith's sufficiency: Trent's definition, with
  canon 9, denies that faith without charity suffices, and "your faith has
  saved you" says hers did.
- **The apocalyptic reading and Paul defeat each other**: it denies the objective
  genitive, and Paul concludes faith alone. **Luke and Acts do not conflict with
  it** either way. They say that faith saves, which it grants; it says that
  faith is not the condition, which they do not deny.
- **The apocalyptic reading and Trent defeat each other.** They agree that
  justification is not by faith alone; but the apocalyptic reading derives "not
  by works" — God's deliverance is conditioned on nothing a person does — and
  Trent denies it. Each attacks what the other holds.
- **Sanders defeats Paul**, by denying the ἔργα νόμου premise; Paul and the
  critics each defeat Sanders back.
- **Jervell and Acts defeat each other**, over the yoke.

## What follows

**Nothing prevails outright** (`nothing_prevails_over_sola_fide`): every party
is defeated by someone, and the grounded extension is empty.

**Nor does anything win on every resolution.** Luke's case and Trent are each
defensible, and neither is forced (`dominical_case_defensible`,
`dominical_case_not_forced`, `trent_defensible`, `trent_not_forced`). With every
rating at the bottom, every attack between Trent and a Reformed strand runs
both ways, and the dispute has no ground to choose between them.

**Between Paul and the apocalyptic reading, the dispute chooses neither.** Each
defeats the other over πίστις Χριστοῦ; each is defensible, and neither is
forced (`apocalyptic_defensible`, `apocalyptic_not_forced`). The apocalyptic
reading stands with Luke's case and Peter's, which claim that faith saves and
not that faith alone does.

## What the verdict rests on

Three things, each stated as a result or a limitation rather than left implicit.

**What justification is.** Between Trent and the Reformed readings, what
decides is not weighed here but argued: the definition of justification.
`whyTheDominicalCaseStandsAgainstTrent` finds that Luke's case breaks Trent at
its definition and the step from it to denying that faith suffices;
`whereTrentPartsFromPaul` (`Gospel.lean`) finds that Paul's gospel breaks it at
one step, that a verdict on a finished work excludes the renewal wrought in us.
Settle that, and the dispute is settled; the ratings here cannot.

**An absence.** The dominical case is attacked by no one but Trent, because no
source cited here argues that σῴζω at Luke 7:50 means healing. That absence is
now also its rating: the premise is `wellSupported`, not `disputed`, because a
search for a scholar arguing the healing sense *at 7:50* found none, and at 7:50
there is no illness — the saying follows "your sins are forgiven". It is not
`consensus`, because the same formula means "made you well" at Luke 8:48, 17:19
and 18:42. A cited argument for the healing reading would attack the dominical
case and lower the rating.

**An objection answered in advance.** "Her sins are forgiven, for she loved
much" (7:47) is the text a rival would use to make love, not faith, the ground
of her forgiveness. The dominical case does not leave that open: it carries
`luke7_47LoveIsEvidence` — her love is the evidence of forgiveness, not its
ground, as 7:47b and the parable of 7:41–43 read it — as a premise of its own.
It is Padilla's reading — she "loves much because she has been forgiven much" —
and Melanchthon's in the *Apology of the Augsburg Confession*: "Christ
interprets Himself when He adds: Thy faith hath saved thee", so the woman did
not merit forgiveness "by that work of love". It is rated `plausible`, because
Trent counts beginning to love God among the dispositions to justification
(Session VI, ch. 6); but no party here argues that reading of 7:47.

**The parties chosen.** A dispute is over the arguments put into it. Hays's
subjective genitive is represented through the apocalyptic reading, which holds
it; a Hays party of its own, the *Joint Declaration*, and a party for the
Finnish reading would each be new arguments to weigh.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### The positions

Each party is an argument in its own right: premises that can hold together, a
conclusion they deliver, and an inference someone has rated. The Reformed case
enters as three parties, one per strand, because a dispute weighs arguments
whole: one package holding all three strands would be defeated by a
contradiction of any one of them, and the redundancy the results prove would
count for nothing. -/

/-- What the Reformed hold about what justification *is*, where Trent is heard:
justification and sanctification are distinct, and sanctification follows. It
carries no strand's conclusion — the strands reach sola fide without it — but
it is the premise Trent's definition contradicts, so it belongs to each
Reformed party, and Trent's attack on each lands on it as well as on "not by
works". Not added to `reformed`, because the other packages built from it, the
Finnish reading among them, would then hold it on their authors' behalf. -/
@[solaFideDefs]
def reformedOntology : List (Formula Claim) :=
  [p .justificationDistinctFromSanctification]

/-- The Pauline strand, argued alone: sola fide from Galatians 2:16.

Its ἔργα νόμου premise is derived, not assumed: it rests on the critics' line,
which denies covenantal nomism and reads Galatians as a polemic against
circumcision as a requirement. That is where the literature puts the dispute
(`critics_carry_the_pauline_strand`, `sanders_costs_the_pauline_strand`), and so
Sanders meets Paul here on the history of Second Temple Judaism, not on Paul's
Greek. The critics' inference is rated with the rest, as Gathercole's. -/
@[solaFideDefs]
def paulineCase : ArgumentPackage Claim :=
  { reformed with
    name := "Sola fide from Paul (Galatians 2:16)"
    premises :=
      caseOf [paulineWithoutWorksOfLaw, criticsLine] (sharedGrounds ++ reformedOntology)
        closingSteps
    inferences := trentAgainstFaithAlone :: criticsLine.inference.toList }

/-- **Luke's case**: what Jesus says at Luke 7:50, and no more. "Your faith has
saved you", read with σῴζω as salvation and the woman's love (7:47) as the
evidence of her forgiveness rather than its ground: her faith sufficed.

It carries nothing Luke does not say — not Paul's texts, not the answer to
James, not the Reformed account of what justification is — and it does not
claim what Paul argues, that faith *alone* saves. So it is attacked only by
what denies Luke's own claim. -/
@[solaFideDefs]
def dominicalCase : ArgumentPackage Claim :=
  { reformed with
    name := "Luke 7:50: \"your faith has saved you\""
    premises := p .luke7_50FaithHasSavedYou :: dominicalLine.premises
    conclusion := p .faithIsSufficient
    conclusionLabel := "faith is sufficient: her faith saved her"
    inferences := [trentAgainstFaithAlone] }

/-- The apostolic strand, argued alone: sola fide from Peter at Jerusalem. -/
@[solaFideDefs]
def apostolicCase : ArgumentPackage Claim :=
  { reformed with
    name := "Sola fide from Peter (Acts 15:9–11)"
    premises := caseOf [apostolicLine] (sharedGrounds ++ reformedOntology) closingSteps
    inferences := [trentAgainstFaithAlone] }

/-- Trent, as the argument it makes: justification is the renewal of the inward
man, that renewal grows through good works, so works done in grace merit an
increase of justification, and salvation is not apart from works. -/
@[solaFideDefs]
def tridentineCase : ArgumentPackage Claim :=
  { tridentine with
    name := "Trent, against 'not by works'"
    conclusion := notP .salvationNotByWorks
    conclusionLabel := "salvation is not apart from works"
    inferences := [trentOnMerit, trentOnIncrease] }

/-- The apocalyptic reading, as the argument it makes: faith is not the
condition of justification. It keeps grace and "not by works", by its own
step. -/
@[solaFideDefs]
def apocalypticCase : ArgumentPackage Claim :=
  { apocalyptic with
    name := "Apocalyptic reading, against faith as the condition"
    conclusion := notP .justificationByFaithAlone
    conclusionLabel := "justification is not by faith alone"
    inferences := [campbellOnDeliverance] }

/-- Sanders and Dunn: covenantal nomism, so ἔργα νόμου are the boundary
markers. -/
@[solaFideDefs]
def sandersCase : ArgumentPackage Claim :=
  sandersLine.asPackage newPerspectiveCite "Paul's ἔργα νόμου is not works in general"

/-- Gathercole and *Variegated Nomism*: not covenantal nomism, so ἔργα νόμου are
works in general. -/
@[solaFideDefs]
def criticsCase : ArgumentPackage Claim :=
  criticsLine.asPackage criticsCite "Paul's ἔργα νόμου is works in general"

/-- Jervell: Luke is law-observant, so the yoke is not the law as a condition of
salvation. -/
@[solaFideDefs]
def jervellCase : ArgumentPackage Claim :=
  jervellLine.asPackage lawObservantLukeCite
    "the yoke of Acts 15:10 is not the law as a condition of salvation"

/-! ### Each position holds together and delivers its conclusion -/

/-- The Pauline case delivers sola fide. -/
theorem paulineCase_establishes : Establishes paulineCase := by
  establish [solaFideDefs]

/-- The Pauline case has a model. -/
theorem paulineCase_is_satisfiable : Satisfiable paulineCase.premises := by
  satisfied_by criticsReading [solaFideDefs]

/-- The dominical case delivers sola fide. -/
theorem dominicalCase_establishes : Establishes dominicalCase := by
  establish [solaFideDefs]

/-- The dominical case has a model. -/
theorem dominicalCase_is_satisfiable : Satisfiable dominicalCase.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- The apostolic case delivers sola fide. -/
theorem apostolicCase_establishes : Establishes apostolicCase := by
  establish [solaFideDefs]

/-- The apostolic case has a model. -/
theorem apostolicCase_is_satisfiable : Satisfiable apostolicCase.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- Trent's case delivers its conclusion: salvation is not apart from works. -/
theorem tridentineCase_establishes : Establishes tridentineCase := by
  establish [solaFideDefs]

/-- Trent's case has a model. -/
theorem tridentineCase_is_satisfiable : Satisfiable tridentineCase.premises := by
  satisfied_by tridentineReading [solaFideDefs]

/-! ### Where Trent's objection comes from

Trent's objection to "not by works" is not a separate thesis about works. It
follows from what Trent says justification *is*: the renewal of the inward man,
not remission of sins only (ch. 7). Grant that, grant that the renewal grows as
the justified do good works (ch. 10), and good works increase justification
(canon 24), which denies "not by works" (ch. 16). The Reformed grant the growth
— Westminster XIII.1 calls it sanctification — and deny the definition. -/

/-- Trent's case with its definition of justification exchanged for the
Reformed distinction: everything else Trent holds, including that the renewal
grows through good works, and justification and sanctification distinct. -/
@[solaFideDefs]
def tridentineCaseOnTheReformedDistinction : ArgumentPackage Claim :=
  { tridentineCase with
    name := "Trent, on the Reformed distinction"
    premises :=
      tridentinePremises (tridentineLine.onGrounds [p .renewalGrowsThroughGoodWorks]) ++
        reformedOntology }

/-- Trent's world, with the Reformed distinction in place of its definition: the
renewal grows, but it is sanctification, so it increases nothing called
justification, and salvation is not by works. -/
def reformedDistinctionReading : Valuation Claim := fun a =>
  match a with
  | .justificationIncludesSanctification => False
  | .worksMeritIncreaseOfJustification => False
  | _ => True

/-- **Trent's objection rests on its definition of justification.** Keep all of
Trent's case except its definition, grant the Reformed distinction instead,
and "not apart from works" no longer follows — though both sides still hold
that the renewal of the justified grows through good works. So the dispute over
works is, at bottom, a dispute over what justification *is*: whether the
renewal that grows is justification or the sanctification that follows it. -/
@[headline]
theorem trent_objection_rests_on_its_definition :
    ¬ Establishes tridentineCaseOnTheReformedDistinction := by
  refute_with reformedDistinctionReading [solaFideDefs]

#print axioms trent_objection_rests_on_its_definition

/-- The apocalyptic case delivers its conclusion. -/
theorem apocalypticCase_establishes : Establishes apocalypticCase := by
  establish [solaFideDefs]

/-- The apocalyptic case has a model. -/
theorem apocalypticCase_is_satisfiable : Satisfiable apocalypticCase.premises := by
  satisfied_by apocalypticReading [solaFideDefs]

/-- Sanders' case delivers its conclusion. -/
theorem sandersCase_establishes : Establishes sandersCase := by
  establish [solaFideDefs]

/-- Sanders' case has a model. -/
theorem sandersCase_is_satisfiable : Satisfiable sandersCase.premises := by
  satisfied_by sandersReading [solaFideDefs]

/-- The critics' case delivers its conclusion. -/
theorem criticsCase_establishes : Establishes criticsCase := by
  establish [solaFideDefs]

/-- The critics' case has a model. -/
theorem criticsCase_is_satisfiable : Satisfiable criticsCase.premises := by
  satisfied_by criticsReading [solaFideDefs]

/-- Jervell's case delivers its conclusion. -/
theorem jervellCase_establishes : Establishes jervellCase := by
  establish [solaFideDefs]

/-- Jervell's case has a model. -/
theorem jervellCase_is_satisfiable : Satisfiable jervellCase.premises := by
  satisfied_by lawObservantLukeReading [solaFideDefs]

/-! ### Strength: every position's weakest link is `disputed`

Every party rests on something cited `disputed`, or denies an atom, which ranks
at the bottom; so every party's strength is `0`, and no rating blocks any
attack. In this dispute the ratings decide nothing, and the verdict is fixed by
who contradicts whom. -/

/-- The Pauline case rests on its lexical premises, cited `disputed`, as well as
on the Reformed distinction. -/
theorem paulineCase_strength : paulineCase.strength = 0 := by decide
/-- The dominical case rests on the Reformed distinction, cited `disputed`, and
on an inference Trent's canon 9 denies. Its own two premises rank higher: σῴζω
`wellSupported`, and the reading of 7:47 `plausible`. -/
theorem dominicalCase_strength : dominicalCase.strength = 0 := by decide
/-- The apostolic case rests on the yoke premise, cited `disputed`. -/
theorem apostolicCase_strength : apostolicCase.strength = 0 := by decide
/-- Trent rests on its definition of justification, cited `disputed`. -/
theorem tridentineCase_strength : tridentineCase.strength = 0 := by decide
/-- The apocalyptic case denies the objective genitive. -/
theorem apocalypticCase_strength : apocalypticCase.strength = 0 := by decide
/-- Sanders' case rests on covenantal nomism, cited `disputed`. -/
theorem sandersCase_strength : sandersCase.strength = 0 := by decide
/-- The critics' case denies covenantal nomism. -/
theorem criticsCase_strength : criticsCase.strength = 0 := by decide
/-- Jervell's step is contested, by Bruce. -/
theorem jervellCase_strength : jervellCase.strength = 0 := by decide

/-! ### The defeats

Each is decided from the two packages' premises by `Horn.defeats?` and checked
by the kernel: the attack, and the comparison of strengths. -/

/-- **Trent defeats the Pauline case.** It entails the denial of "not by works",
so it rebuts sola fide. -/
theorem trent_defeats_pauline : Defeats tridentineCase paulineCase :=
  Horn.defeats_of_defeats? tridentineCase_strength paulineCase_strength (by decide +kernel)

/-- **Trent defeats the dominical case**, on the same rebuttal. -/
theorem trent_defeats_dominical : Defeats tridentineCase dominicalCase :=
  Horn.defeats_of_defeats? tridentineCase_strength dominicalCase_strength (by decide +kernel)

/-- **Trent defeats the apostolic case**, on the same rebuttal. -/
theorem trent_defeats_apostolic : Defeats tridentineCase apostolicCase :=
  Horn.defeats_of_defeats? tridentineCase_strength apostolicCase_strength (by decide +kernel)

/-- **The Pauline case defeats Trent back.** It entails "not by works", which Trent denies. -/
theorem pauline_defeats_trent : Defeats paulineCase tridentineCase :=
  Horn.defeats_of_defeats? paulineCase_strength tridentineCase_strength (by decide +kernel)

/-- **The dominical case defeats Trent back.** -/
theorem dominical_defeats_trent : Defeats dominicalCase tridentineCase :=
  Horn.defeats_of_defeats? dominicalCase_strength tridentineCase_strength (by decide +kernel)

/-- **The apostolic case defeats Trent back.** -/
theorem apostolic_defeats_trent : Defeats apostolicCase tridentineCase :=
  Horn.defeats_of_defeats? apostolicCase_strength tridentineCase_strength (by decide +kernel)

/-- **The apocalyptic reading defeats Trent.** It holds "not by works" by its
own step — God's deliverance is conditioned on nothing a person does — and Trent
denies it. -/
theorem apocalyptic_defeats_trent : Defeats apocalypticCase tridentineCase :=
  Horn.defeats_of_defeats? apocalypticCase_strength tridentineCase_strength (by decide +kernel)

/-- **The apocalyptic reading defeats the Pauline case.** It denies the
objective genitive, a premise of Paul's strand cited `disputed`. -/
theorem apocalyptic_defeats_pauline : Defeats apocalypticCase paulineCase :=
  Horn.defeats_of_defeats? apocalypticCase_strength paulineCase_strength (by decide +kernel)

/-- **The Pauline case defeats the apocalyptic reading back.** It entails
justification by faith alone. -/
theorem pauline_defeats_apocalyptic : Defeats paulineCase apocalypticCase :=
  Horn.defeats_of_defeats? paulineCase_strength apocalypticCase_strength (by decide +kernel)

/-- **The dominical case does not defeat the apocalyptic reading.** Luke 7:50
says that faith saved her, not that faith alone does; the apocalyptic reading
grants that faith saves, and denies only that faith is the condition. So Luke's
case entails nothing the apocalyptic reading denies
(`luke_grants_the_apocalyptic_conclusion`). -/
theorem dominical_does_not_defeat_apocalyptic : ¬ Defeats dominicalCase apocalypticCase :=
  Horn.not_defeats_of_defeats? dominicalCase_strength apocalypticCase_strength (by decide +kernel)

/-- **Nor does the apostolic case**, for the same reason: Peter at Jerusalem
says faith suffices, not that it alone does
(`peter_grants_the_apocalyptic_conclusion`). -/
theorem apostolic_does_not_defeat_apocalyptic : ¬ Defeats apostolicCase apocalypticCase :=
  Horn.not_defeats_of_defeats? apostolicCase_strength apocalypticCase_strength (by decide +kernel)

/-- **Sanders defeats the Pauline case.** Covenantal nomism, with Dunn's
inference, denies the ἔργα νόμου premise. -/
theorem sanders_defeats_pauline : Defeats sandersCase paulineCase :=
  Horn.defeats_of_defeats? sandersCase_strength paulineCase_strength (by decide +kernel)

/-- **The Pauline case defeats Sanders back.** It holds the premise Sanders' conclusion denies. -/
theorem pauline_defeats_sanders : Defeats paulineCase sandersCase :=
  Horn.defeats_of_defeats? paulineCase_strength sandersCase_strength (by decide +kernel)

/-- **Sanders defeats the critics.** Their conclusions contradict. -/
theorem sanders_defeats_critics : Defeats sandersCase criticsCase :=
  Horn.defeats_of_defeats? sandersCase_strength criticsCase_strength (by decide +kernel)

/-- **The critics defeat Sanders.** They deny covenantal nomism, his ground. -/
theorem critics_defeat_sanders : Defeats criticsCase sandersCase :=
  Horn.defeats_of_defeats? criticsCase_strength sandersCase_strength (by decide +kernel)

/-- **Jervell defeats the apostolic case.** He denies the yoke premise. -/
theorem jervell_defeats_apostolic : Defeats jervellCase apostolicCase :=
  Horn.defeats_of_defeats? jervellCase_strength apostolicCase_strength (by decide +kernel)

/-- **The apostolic case defeats Jervell back.** It holds the premise his conclusion denies. -/
theorem apostolic_defeats_jervell : Defeats apostolicCase jervellCase :=
  Horn.defeats_of_defeats? apostolicCase_strength jervellCase_strength (by decide +kernel)

/-! ### What does not defeat

Most pairs of parties are compatible: some world holds both, and seven such
worlds are named below (`Dispute.StandTogether`) — the readings on which whole
groups of positions can be held at once. Three pairs conflict in one direction
only. All of them, like every cell of the table, are decided by
`Horn.defeats?` from the premises. -/

/-- The critics' world with Jervell's: covenantal nomism fails, and the yoke is
Israel's law for gentiles. The Pauline and dominical cases hold in it. -/
def criticsJervellReading : Valuation Claim := fun a =>
  match a with
  | .secondTempleCovenantalNomism => False
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- Trent's world with Sanders' and Jervell's. -/
def trentSandersJervellReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .worksOfLawMeansWorksGenerally => False
  | .acts15YokeIsLawAsCondition => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | _ => True

/-- Trent's world with the critics' and Jervell's. -/
def trentCriticsJervellReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .secondTempleCovenantalNomism => False
  | .acts15YokeIsLawAsCondition => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | _ => True

/-- The apocalyptic world with Sanders' and Jervell's. -/
def apocalypticSandersJervellReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | .worksOfLawMeansWorksGenerally => False
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- The apocalyptic world with the critics' and Jervell's. -/
def apocalypticCriticsJervellReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | .secondTempleCovenantalNomism => False
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- **The apocalyptic reading does not defeat the dominical case.** It
contradicts nothing the dominical case rests on — not Luke 7:50, not σῴζω, not
the reading of 7:47 — and it does not deny its conclusion: it grants grace and
"not by works", and it can grant that salvation is received through faith while
denying that faith is its condition. Why, premise by premise:
`apocalyptic_grants_sola_fide_as_stated` and
`apocalyptic_grants_the_dominical_step`. -/
theorem apocalyptic_does_not_defeat_dominical : ¬ Defeats apocalypticCase dominicalCase :=
  Horn.not_defeats_of_defeats? apocalypticCase_strength dominicalCase_strength (by decide +kernel)

/-- **Nor the apostolic case**, for the same reasons
(`apocalyptic_grants_the_apostolic_step`). -/
theorem apocalyptic_does_not_defeat_apostolic : ¬ Defeats apocalypticCase apostolicCase :=
  Horn.not_defeats_of_defeats? apocalypticCase_strength apostolicCase_strength (by decide +kernel)

/-- **Trent defeats the apocalyptic reading.** They agree on its conclusion —
justification is not by faith alone — but the apocalyptic reading *derives*
"not by works" on the way (God's deliverance is sheer gift, conditioned on
nothing a person does), and Trent denies it: works done in grace merit an
increase of justification. So Trent rebuts the apocalyptic reading on a claim
it derives (`RebutsStep`). -/
theorem trent_defeats_apocalyptic : Defeats tridentineCase apocalypticCase :=
  Horn.defeats_of_defeats? tridentineCase_strength apocalypticCase_strength (by decide +kernel)

/-! ### Why these are not counters

The absences above are computed, and a computation names no reason. The
readings below do: each is a way of holding one position that leaves one
premise or conclusion of another standing, and each result checks that the
reading holds everything the first position holds as well. -/

/-- The apocalyptic world in which salvation is still received through faith —
faith is not the condition, but it is the means. Grace and "not by works" hold. -/
def apocalypticWithFaithReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | _ => True

/-- **The apocalyptic reading grants what the Reformed strands conclude.** Grace,
"not by works", and salvation received through faith all hold in its world;
what it denies is that faith is the condition. So it rebuts neither Luke's case
nor Acts'. -/
theorem apocalyptic_grants_sola_fide_as_stated :
    Grants apocalypticCase dominicalCase.conclusion := by
  satisfied_by apocalypticWithFaithReading [Grants, solaFideDefs]

/-- **The apocalyptic reader grants the dominical step outright.** Luke's step
delivers that faith suffices — "your faith has saved you" — and the apocalyptic
world holds that: faith is the means, though not the condition. -/
theorem apocalyptic_grants_the_dominical_step :
    Grants apocalypticCase dominicalToSufficiency := by
  satisfied_by apocalypticWithFaithReading [Grants, solaFideDefs]

/-- **And the apostolic step**, for the same reason: Peter says faith suffices,
and the apocalyptic reading does not deny it. -/
theorem apocalyptic_grants_the_apostolic_step :
    Grants apocalypticCase apostolicToSufficiency := by
  satisfied_by apocalypticWithFaithReading [Grants, solaFideDefs]

/-- Luke's world without *alone*: every premise of the dominical case, faith
sufficient, and justification not by faith alone — because nothing Luke says
excludes another condition. -/
def lukeWithoutAloneReading : Valuation Claim := fun a =>
  match a with
  | .justificationByFaithAlone => False
  | _ => True

/-- **Luke's case grants the apocalyptic conclusion.** Everything the dominical
case holds is compatible with justification not being by faith alone, so it
does not rebut the apocalyptic reading. Only Paul's case, which argues for
*alone*, does. -/
theorem luke_grants_the_apocalyptic_conclusion :
    Grants dominicalCase apocalypticCase.conclusion := by
  satisfied_by lukeWithoutAloneReading [Grants, solaFideDefs]

/-- **And Peter's case.** -/
theorem peter_grants_the_apocalyptic_conclusion :
    Grants apostolicCase apocalypticCase.conclusion := by
  satisfied_by lukeWithoutAloneReading [Grants, solaFideDefs]

/-- Trent's world, with the objective genitive and the apocalyptic reading of
δικαιοσύνη θεοῦ both denied. -/
def trentWithoutDeliveranceReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .pistisChristouObjective => False
  | .righteousnessOfGodIsDeliverance => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | _ => True

/-- **Trent can grant the subjective genitive.** Nothing Trent holds settles how
πίστις Χριστοῦ is read, so the apocalyptic reading's denial of the objective
genitive stands against Trent unanswered. -/
theorem trent_grants_the_subjective_genitive :
    Grants tridentineCase (notP .pistisChristouObjective) := by
  satisfied_by trentWithoutDeliveranceReading [Grants, solaFideDefs]

/-- Trent's world, in which justification is not by faith alone — the
apocalyptic reading's conclusion, which Trent shares. -/
def trentWithoutFaithAloneReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationByFaithAlone => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | _ => True

/-- **Trent grants the apocalyptic reading's conclusion**: justification is not
by faith alone. They agree on it for different reasons, so Trent does not rebut
the apocalyptic reading. -/
theorem trent_grants_the_apocalyptic_conclusion :
    Grants tridentineCase apocalypticCase.conclusion := by
  satisfied_by trentWithoutFaithAloneReading [Grants, solaFideDefs]

/-! ### The dispute -/

/-- The parties to the dispute over sola fide. -/
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
  /-- Sanders and Dunn, against ἔργα νόμου as works in general. -/
  | sanders
  /-- Gathercole and *Variegated Nomism*, for it. -/
  | critics
  /-- Jervell, against the yoke as the law as a condition of salvation. -/
  | jervell
deriving DecidableEq

/-- The package each party argues from. -/
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

/-- The dispute over sola fide: every party's premises have a model, every party
establishes its conclusion, and every party's inferences are rated. -/
@[solaFideDefs]
def solaFideDispute : Dispute Claim Party where
  node := partyNode
  consistent
    | .pauline => paulineCase_is_satisfiable
    | .dominical => dominicalCase_is_satisfiable
    | .apostolic => apostolicCase_is_satisfiable
    | .trent => tridentineCase_is_satisfiable
    | .apocalyptic => apocalypticCase_is_satisfiable
    | .sanders => sandersCase_is_satisfiable
    | .critics => criticsCase_is_satisfiable
    | .jervell => jervellCase_is_satisfiable
  sound
    | .pauline => paulineCase_establishes
    | .dominical => dominicalCase_establishes
    | .apostolic => apostolicCase_establishes
    | .trent => tridentineCase_establishes
    | .apocalyptic => apocalypticCase_establishes
    | .sanders => sandersCase_establishes
    | .critics => criticsCase_establishes
    | .jervell => jervellCase_establishes
  rated i := by
    cases i <;> simp [solaFideDefs, Line.asPackage]

/-- The Reformed strands and the critics stand together, where covenantal nomism
fails and everything else holds. -/
theorem reformed_strands_stand_with_the_critics :
    solaFideDispute.StandTogether [.pauline, .dominical, .apostolic, .critics] := by
  satisfied_by criticsReading [Dispute.StandTogether, solaFideDefs]

/-- Paul and Luke stand with the critics and with Jervell. -/
theorem paul_and_luke_stand_with_jervell :
    solaFideDispute.StandTogether [.pauline, .dominical, .jervell, .critics] := by
  satisfied_by criticsJervellReading [Dispute.StandTogether, solaFideDefs]

/-- Luke and Acts stand with Sanders: neither rests on ἔργα νόμου. -/
theorem luke_and_acts_stand_with_sanders :
    solaFideDispute.StandTogether [.dominical, .apostolic, .sanders] := by
  satisfied_by newPerspectiveOwnReading [Dispute.StandTogether, solaFideDefs]

/-- Trent stands with Sanders and Jervell. -/
theorem trent_stands_with_sanders_and_jervell :
    solaFideDispute.StandTogether [.trent, .sanders, .jervell] := by
  satisfied_by trentSandersJervellReading [Dispute.StandTogether, solaFideDefs]

/-- Trent stands with the critics and Jervell. -/
theorem trent_stands_with_the_critics_and_jervell :
    solaFideDispute.StandTogether [.trent, .critics, .jervell] := by
  satisfied_by trentCriticsJervellReading [Dispute.StandTogether, solaFideDefs]

/-- The apocalyptic reading stands with Sanders and Jervell. -/
theorem apocalyptic_stands_with_sanders_and_jervell :
    solaFideDispute.StandTogether [.apocalyptic, .sanders, .jervell] := by
  satisfied_by apocalypticSandersJervellReading [Dispute.StandTogether, solaFideDefs]

/-- The apocalyptic reading stands with the critics and Jervell. -/
theorem apocalyptic_stands_with_the_critics_and_jervell :
    solaFideDispute.StandTogether [.apocalyptic, .critics, .jervell] := by
  satisfied_by apocalypticCriticsJervellReading [Dispute.StandTogether, solaFideDefs]

/-- The defeats of the dispute, as a table. -/
def partyDefeats : Party → Party → Prop
  | .trent, .pauline => True
  | .trent, .dominical => True
  | .trent, .apostolic => True
  | .pauline, .trent => True
  | .dominical, .trent => True
  | .apostolic, .trent => True
  | .apocalyptic, .trent => True
  | .trent, .apocalyptic => True
  | .apocalyptic, .pauline => True
  | .pauline, .apocalyptic => True
  | .sanders, .pauline => True
  | .pauline, .sanders => True
  | .sanders, .critics => True
  | .critics, .sanders => True
  | .jervell, .apostolic => True
  | .apostolic, .jervell => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel partyDefeats := fun i j => by
  cases i <;> cases j <;> unfold partyDefeats <;> infer_instance

/-- Every party's weakest link ranks at the bottom. -/
theorem partyNode_strength : ∀ i, (partyNode i).strength = 0
  | .pauline => paulineCase_strength
  | .dominical => dominicalCase_strength
  | .apostolic => apostolicCase_strength
  | .trent => tridentineCase_strength
  | .apocalyptic => apocalypticCase_strength
  | .sanders => sandersCase_strength
  | .critics => criticsCase_strength
  | .jervell => jervellCase_strength

/-- **Who defeats whom**, all sixty-four pairs. Trent and each Reformed strand
defeat each other. The apocalyptic reading and Paul defeat each other; it and
Luke's and Acts' cases do not conflict; it defeats Trent, and Trent does not
defeat it. Sanders defeats Paul and the critics, and both defeat him back.
Jervell and Acts defeat each other. Nothing else.

Every cell is computed from the parties' premises by `Horn.defeats?` and
checked by the kernel — the defeats, and the absences of defeat, alike. The
table above is what the computation is checked against; none of it is
assumed. -/
theorem solaFideDispute_defeats :
    ∀ i j, solaFideDispute.defeats i j ↔ partyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (partyNode_strength i) (partyNode_strength j) ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute in the form the verdict solver computes with: every party, and
the table. -/
def solaFideFinite : Solver.Finite solaFideDispute.defeats where
  parties := [.pauline, .dominical, .apostolic, .trent, .apocalyptic, .sanders, .critics, .jervell]
  complete i := by cases i <;> decide
  defeats i j := decide (partyDefeats i j)
  spec i j := by rw [solaFideDispute_defeats]; simp

/-! ### The dispute as a graph -/

/-- **Nothing supports anything** in the sola fide dispute, in all sixty-four
pairs: no party's conclusion entails a claim another rests on. The critics'
conclusion used to be one of Paul's premises; now the Pauline case rests on the
critics' whole line instead (`paulineCase`), and the relation is the stronger
one below. The Reformed strands, which share their conclusion, agree rather than
support (see `Testimony.Logic.Support`). Every cell is computed by `supports?`
and checked by the kernel. -/
theorem solaFideDispute_supports : ∀ i j, ¬ solaFideDispute.supports i j := by
  intro i j
  refine (supports_iff_of_supports? (P := False) ?_).not.mpr id
  cases i <;> cases j <;> decide +kernel

/-- Whose case is part of whose, as a table: besides each party's own, one
pair. -/
def partyPartOf : Party → Party → Prop
  | .critics, .pauline => True
  | i, j => i = j

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel partyPartOf := fun i j => by
  cases i <;> cases j <;> unfold partyPartOf <;> infer_instance

/-- **Whose case is part of whose**, all sixty-four pairs: the critics' case is
part of Paul's, since the Pauline case derives its ἔργα νόμου premise from the
critics' line; and every case is part of itself. Nothing else. Every cell is
computed by `partOf?` and checked by the kernel. -/
theorem solaFideDispute_partOf : ∀ i j, solaFideDispute.partOf i j ↔ partyPartOf i j := by
  intro i j
  refine partOf_iff_of_partOf? ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute drawn: who defeats whom, and whose case is part of whose. -/
def solaFideMap : ArgumentMap solaFideDispute where
  finite := solaFideFinite
  supports _ _ := false
  supports_spec i j := by simp [solaFideDispute_supports i j]
  partOf i j := decide (partyPartOf i j)
  partOf_spec i j := by rw [solaFideDispute_partOf]; simp

/-! ### What the dispute decides -/

/-- Why nothing prevails outright: a defeater for every party. -/
def everyPartyDefeated : Verdict solaFideDispute where
  finite := solaFideFinite
  claim := .nothingGrounded
    [ (.pauline, .trent), (.dominical, .trent), (.apostolic, .trent), (.trent, .pauline)
    , (.apocalyptic, .pauline), (.sanders, .pauline), (.critics, .sanders)
    , (.jervell, .apostolic) ]
  checked := by decide +kernel

/-- **Nothing prevails outright.** Every party is defeated by some other: each
Reformed strand by Trent, Trent by each strand and by the apocalyptic reading,
the apocalyptic reading by Paul and by Trent, Sanders by the critics, the
critics by
Sanders, Jervell by Acts. The grounded extension — what the dispute forces,
before any choice between rivals — is empty. -/
@[headline]
theorem nothing_prevails_over_sola_fide : grounded solaFideDispute.defeats = ∅ :=
  everyPartyDefeated.holds

#print axioms nothing_prevails_over_sola_fide

/-- Why Trent can be defended: it stands with Sanders and Jervell, and answers
every party that attacks it itself — each Reformed strand, and the apocalyptic
reading, whose derived "not by works" it denies. -/
def trentStandsWithSandersAndJervell : Verdict solaFideDispute where
  finite := solaFideFinite
  claim := .credulous .trent [.trent, .sanders, .jervell]
  checked := by decide +kernel

/-- **Trent can be defended.** Some maximal defensible position holds it, with
Sanders and Jervell. Every party that defeats Trent — Paul, Luke, Peter, the
apocalyptic reading — Trent defeats back, and the ratings, all at the bottom,
break no tie. In particular Trent answers the apocalyptic reading: that reading
derives "not by works" on the way to its conclusion, and Trent denies it
(`trent_defeats_apocalyptic`). -/
@[headline]
theorem trent_defensible : CredulouslyAccepted solaFideDispute.defeats .trent :=
  trentStandsWithSandersAndJervell.holds

#print axioms trent_defensible

/-- Why Trent is not forced: a defensible position holds Paul, and Paul defeats
Trent. -/
def trentAnsweredByPaul : Verdict solaFideDispute where
  finite := solaFideFinite
  claim := .notSkeptical .trent .pauline [.pauline, .dominical, .apostolic, .critics]
  checked := by decide +kernel

/-- **Nor is Trent forced.** A maximal defensible position holds Paul's case with
Luke's and Peter's, and none of them can be held with Trent. -/
@[headline]
theorem trent_not_forced : ¬ SkepticallyAccepted solaFideDispute.defeats .trent :=
  trentAnsweredByPaul.holds

#print axioms trent_not_forced

/-- Why the apocalyptic reading can be defended: it stands with Luke's case, with
Peter's, and with the critics, and answers the one party that defeats it — Paul
— itself. -/
def apocalypticStandsWithLuke : Verdict solaFideDispute where
  finite := solaFideFinite
  claim := .credulous .apocalyptic [.dominical, .apostolic, .apocalyptic, .critics]
  checked := by decide +kernel

/-- **The apocalyptic reading can be defended.** Some maximal defensible position
holds it, and holds Luke's case and Peter's with it: they claim that faith
saves, and the apocalyptic reading grants that, denying only that faith is the
condition. Its one defeater is Paul, whom it defeats back, over the genitive.

So the dispute between the Reformed reading and the apocalyptic one is where the
literature has it: between Paul and Campbell, over πίστις Χριστοῦ — not between
Campbell and Luke. -/
@[headline]
theorem apocalyptic_defensible :
    CredulouslyAccepted solaFideDispute.defeats .apocalyptic :=
  apocalypticStandsWithLuke.holds

#print axioms apocalyptic_defensible

/-- Why the apocalyptic reading is not forced: a defensible position holds Paul,
and Paul defeats it. -/
def apocalypticAnsweredByPaul : Verdict solaFideDispute where
  finite := solaFideFinite
  claim := .notSkeptical .apocalyptic .pauline [.pauline, .dominical, .apostolic, .critics]
  checked := by decide +kernel

/-- **Nor is it forced.** A maximal defensible position holds Paul's case —
faith alone, from Galatians 2:16 read with the objective genitive — and cannot
hold the apocalyptic reading with it. Between Paul and Campbell the dispute
chooses neither: each is defensible, and neither is forced. -/
@[headline]
theorem apocalyptic_not_forced :
    ¬ SkepticallyAccepted solaFideDispute.defeats .apocalyptic :=
  apocalypticAnsweredByPaul.holds

#print axioms apocalyptic_not_forced

/-- Why Luke's case can be defended: it stands with Peter's, the apocalyptic
reading and the critics, and answers its one defeater, Trent, itself. -/
def lukeStandsWithPeter : Verdict solaFideDispute where
  finite := solaFideFinite
  claim := .credulous .dominical [.dominical, .apostolic, .apocalyptic, .critics]
  checked := by decide +kernel

/-- **Luke's case can be defended.** "Your faith has saved you", read as Luke
says it, stands in six of the dispute's eight maximal defensible positions. Its
only defeater is Trent, over what justification is: Trent's definition denies
that faith without charity suffices, and Luke's words say her faith saved her.
It defeats Trent back, and conflicts with no other party. -/
@[headline]
theorem dominical_case_defensible :
    CredulouslyAccepted solaFideDispute.defeats .dominical :=
  lukeStandsWithPeter.holds

#print axioms dominical_case_defensible

/-- Why Luke's case is not forced: a defensible position holds Trent, and Trent
defeats it. -/
def lukeAnsweredByTrent : Verdict solaFideDispute where
  finite := solaFideFinite
  claim := .notSkeptical .dominical .trent [.trent, .sanders, .jervell]
  checked := by decide +kernel

/-- **Nor is it forced.** A maximal defensible position holds Trent, and cannot
hold Luke's case with it.

This is the dispute's verdict, stated plainly: between Trent and each Reformed
strand, the dispute chooses neither. Every party's weakest link is `disputed`,
so no rating breaks a tie, and every attack between Trent and the Reformed
readings runs both ways. What decides between them is what justification *is*
— and that is argued, not weighed: `whyTheDominicalCaseStandsAgainstTrent`
locates Luke's disagreement with Trent at Trent's definition, and
`whereTrentPartsFromPaul` (`Gospel.lean`) locates Paul's at one step, that a
verdict on a finished work excludes the renewal wrought in us. -/
@[headline]
theorem dominical_case_not_forced :
    ¬ SkepticallyAccepted solaFideDispute.defeats .dominical :=
  lukeAnsweredByTrent.holds

#print axioms dominical_case_not_forced

/-! ### Why Luke's case stands against Trent

The verdicts above say that Luke's case and Trent defeat each other, and that
the dispute chooses neither. This says *why*, at the level of the claims. The
two part over what justification
*is*: Trent defines it as the renewal of the inward man by infused charity, and
from that definition it follows that faith without charity does not suffice.
Luke's words say that her faith saved her. -/

/-- **Why Luke's case stands against Trent.** The crux is Luke's own step: from
"your faith has saved you", with σῴζω as salvation and her love as the
evidence of forgiveness, to faith's sufficiency. Trent cannot hold it with
Luke's words: its definition of justification as the renewal of the inward man
(Session VI, ch. 7), with the step from that definition to denying that faith
suffices (canon 9), contradicts it — and both are needed. Nothing else in
Trent's case does: not its account of merit, not its reading of works.

So the disagreement is not about what Luke says. It is about what justification
is. Grant Trent's definition, and "your faith has saved you" cannot mean that
faith sufficed; grant that it did, and Trent's definition cannot stand. -/
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

end Testimony.Arguments.SolaFide
