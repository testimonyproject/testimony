import Testimony.Arguments.SolaFide.Packages
import Testimony.Logic.Tactic

/-!
# Arguments.SolaFide.Results — what does and does not follow

Entailments are established with `establish`; refutations name a countermodel —
the rival's own reading, written down as a valuation — and use `refute_with`.

`lexical_premises_jointly_load_bearing` is the result the encoding exists to
make possible: no strand's disputed premise carries the argument, and only
removing one from every strand defeats it.
`apostolic_strand_survives_paul_and_luke` records what the third strand changed:
the two disputes that used to be jointly decisive are no longer enough.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Results -/

/-- Given the Reformed premises, the conclusion follows. -/
@[headline]
theorem reformed_establishes : Establishes reformed := by
  establish [reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
    jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
    sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
    apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks, toThroughFaith, conclusionSteps,
    solaFide, graceNotWorks]

#print axioms reformed_establishes

/-- **The New Perspective establishes it too.** Dunn and Wright reject the
traditional reading of ἔργα νόμου; they do not reject justification by faith.
Once Jesus' words at Luke 7:50 are in view, denying the Pauline lexical premise
no longer blocks the conclusion.

Winning the ἔργα νόμου argument outright is therefore not a defeat of sola
fide, and this library says so in a form either side can check. The critics of
the New Perspective dispute its premise, not this result. -/
@[headline]
theorem newPerspective_establishes : Establishes newPerspective := by
  establish [newPerspective, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
    jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
    sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
    apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks, toThroughFaith, conclusionSteps,
    solaFide, graceNotWorks]

#print axioms newPerspective_establishes

/-- The Tridentine reading, as a valuation: works merit an increase of
justification, so salvation is not apart from works; and justification renews
the inward man, so it is not forensic only. -/
def tridentineReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | _ => True

/-- The Tridentine premises do not establish the conclusion — they entail the
negation of its second part, that salvation is not by works. -/
@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  refute_with tridentineReading [tridentine, reformed, solaFide]

#print axioms tridentine_not_establishes

/-- The ἔργα νόμου premise is **not** load-bearing on its own: strip it and
the other strands still carry the argument. -/
@[headline]
theorem worksOfLaw_not_load_bearing : Establishes reformedWithoutWorksOfLaw := by
  establish [reformedWithoutWorksOfLaw, paulineWithoutWorksOfLaw, reformed, Line.onGrounds,
    paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine,
    paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps,
    paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation,
    toGraceNotWorks, toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

#print axioms worksOfLaw_not_load_bearing

/-- Nor is the dominical lexical premise: strip it and the other strands still
carry the argument. -/
@[headline]
theorem sozo_not_load_bearing : Establishes reformedWithoutSozo := by
  establish [reformedWithoutSozo, reformed, Line.onGrounds, paulineLine, dominicalLine,
    apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

#print axioms sozo_not_load_bearing

/-- **The two disputes that used to decide the argument no longer do.** Deny
both the ἔργα νόμου premise and the dominical premise — the pair whose joint
removal defeated sola fide before Acts 15 was encoded — and the conclusion
still follows, by Peter's speech at Jerusalem.

This is the change the third strand makes, stated as a result rather than
left to be inferred from the absence of an old one. -/
@[headline]
theorem apostolic_strand_survives_paul_and_luke :
    Establishes reformedWithoutWorksOfLawOrSozo := by
  establish [reformedWithoutWorksOfLawOrSozo, paulineWithoutWorksOfLaw, reformed, Line.onGrounds,
    paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine,
    paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps,
    paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation,
    toGraceNotWorks, toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

#print axioms apostolic_strand_survives_paul_and_luke

/-- The objective genitive is not load-bearing for sola fide as a whole. Grant
Hays that πίστις Χριστοῦ is Christ's own faithfulness, keep everything else,
and the conclusion still follows.

The genitive is the hinge of the Pauline strand, as
`pistisChristou_jointly_load_bearing` shows. It is not the hinge of the
argument. A reader who wins the genitive for Hays has cost the Reformed case
its Pauline route, and not its conclusion. -/
@[headline]
theorem pistisChristou_not_load_bearing : Establishes subjectiveGenitive := by
  establish [subjectiveGenitive, reformed, Line.onGrounds, paulineLine, dominicalLine,
    apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

#print axioms pistisChristou_not_load_bearing

/-- **Nor is the yoke.** Grant Jervell that the yoke of Acts 15:10 is Israel's
law laid on gentiles, not the law as a condition of salvation, keep everything
else, and the conclusion still follows by Paul and by Luke 7:50. -/
@[headline]
theorem acts15Yoke_not_load_bearing : Establishes lawObservantLuke := by
  establish [lawObservantLuke, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
    jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
    sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
    apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks, toThroughFaith, conclusionSteps,
    solaFide, graceNotWorks]

#print axioms acts15Yoke_not_load_bearing

/-- A reading on which no strand's disputed premise holds: Paul's phrase is
about boundary markers, Jesus' σέσωκέν σε is about healing, and Peter's yoke is
Israel's law for gentiles. -/
def neitherLexicalReading : Valuation Claim := fun a =>
  match a with
  | .worksOfLawMeansWorksGenerally => False
  | .sozoIsSoteriological => False
  | .acts15YokeIsLawAsCondition => False
  | .justificationByFaithAlone => False
  | .salvationThroughFaith => False
  | _ => True

/-- **The result worth having.** No strand's disputed premise carries the
argument alone, but together they do: remove the ἔργα νόμου premise from Paul,
σῴζω from Luke and the yoke from Acts, and sola fide no longer follows, with
everything else retained.

So the Reformation's material principle, as encoded here, does not hang on the
sense of Paul's ἔργα νόμου. It hangs on that, *or* on the sense of Jesus'
σέσωκέν σε, *or* on Peter's yoke — and an opponent must defeat all three. The
same holds with the πίστις Χριστοῦ premise in place of ἔργα νόμου; see
`pistisChristou_jointly_load_bearing`. -/
@[headline]
theorem lexical_premises_jointly_load_bearing :
    ¬ Establishes reformedWithoutEveryStrandsPremise := by
  refute_with neitherLexicalReading [reformedWithoutEveryStrandsPremise, paulineWithoutWorksOfLaw,
    reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
    criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds, prooftexts,
    closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
    jamesHarmonisation, toGraceNotWorks, toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

#print axioms lexical_premises_jointly_load_bearing

/-- A reading on which Galatians 2:16 names Christ's faithfulness rather than
faith in Christ, Jesus' σέσωκέν σε is about healing, and Peter's yoke is
Israel's law for gentiles. -/
def neitherPistisNorSozoReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .sozoIsSoteriological => False
  | .acts15YokeIsLawAsCondition => False
  | .justificationByFaithAlone => False
  | .salvationThroughFaith => False
  | _ => True

/-- **Within the Pauline strand, faith in Christ is load-bearing.** Deny the
objective genitive, and the disputed premise of each other strand, keep the
ἔργα νόμου premise and the reading of Galatians as a polemic against
circumcision, and sola fide no longer follows.

Excluding works is not enough to reach *faith alone*. Galatians 2:16 must also
name the believer's faith as the means, and on the subjective genitive it does
not. So the Pauline strand rests on two disputed readings of one verse, either
of which costs it the conclusion. -/
@[headline]
theorem pistisChristou_jointly_load_bearing :
    ¬ Establishes reformedWithoutPistisChristouSozoOrYoke := by
  refute_with neitherPistisNorSozoReading [reformedWithoutPistisChristouSozoOrYoke,
    paulineWithoutPistisChristou, reformed, Line.onGrounds, paulineLine, dominicalLine,
    apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

#print axioms pistisChristou_jointly_load_bearing

/-- **Authorship is not load-bearing.** Grant every critical conclusion — that
Ephesians and Titus are not by Paul, and 1 and 2 Peter not by Peter — and the
conclusion still follows.

The case reads these letters as canonical scripture rather than as an apostle's
testimony, so their authorship is no premise of it — which is why this is proved
by weakening (`entails_of_subset`) from `reformed_establishes`: the premises
added are ones no step reads. What that costs is stated
in `criticalAuthorship`: the letters cannot then serve as evidence of what
*Paul* meant, and the ἔργα νόμου premise rests on Romans instead. -/
@[headline]
theorem authorship_not_load_bearing : Establishes criticalAuthorship :=
  entails_of_subset (fun _ h => List.mem_append_left _ h) reformed_establishes

#print axioms authorship_not_load_bearing

/-- The apocalyptic reading, as a valuation: πίστις Χριστοῦ is Christ's
faithfulness, δικαιοσύνη θεοῦ is God's deliverance, and faith is not the
condition of justification. Everything else it grants. -/
def apocalypticReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | .salvationThroughFaith => False
  | _ => True

/-- **The apocalyptic reading does not establish sola fide.** It denies the
premise the conclusion's third part depends on — that faith is the condition of
justification — and so does not reach "through faith".

What it keeps is stated as its own result,
`apocalyptic_establishes_grace_not_works`. -/
@[headline]
theorem apocalyptic_not_establishes : ¬ Establishes apocalyptic := by
  refute_with apocalypticReading [apocalyptic, reformed, apocalypticLine, deliveranceNotFaithAlone,
    deliveranceIsGrace, toThroughFaith, solaFide, graceNotWorks]

#print axioms apocalyptic_not_establishes

/-- **What the apocalyptic reading keeps: grace, and not by works.** If
δικαιοσύνη θεοῦ is God's act of deliverance, salvation is sheer gift,
conditioned on nothing a person does. The reading establishes the first two
parts of the conclusion by its own route, and denies the third.

So the dispute between the apocalyptic and Reformed readings is located
exactly: it is over *through faith*, and not over grace or works. -/
@[headline]
theorem apocalyptic_establishes_grace_not_works : Establishes apocalypticOnGraceAndWorks := by
  establish [apocalypticOnGraceAndWorks, apocalyptic, reformed, apocalypticLine,
    deliveranceNotFaithAlone, deliveranceIsGrace, toThroughFaith, graceNotWorks]

#print axioms apocalyptic_establishes_grace_not_works

/-- **Grace, and not by works, rest on no lexical premise.** Remove every one —
ἔργα νόμου and πίστις Χριστοῦ from Paul, σῴζω from Luke, the yoke from Acts —
and the first two parts of the conclusion still follow, from the texts that say
"not of works" in terms and the answer to James.

The lexical disputes decide *through faith alone*: whether the texts that
exclude works also name faith as the means. They do not decide whether works
are excluded. -/
@[headline]
theorem grace_and_works_rest_on_no_lexical_premise :
    Establishes graceAndWorksWithoutAnyLexicalPremise := by
  establish [graceAndWorksWithoutAnyLexicalPremise, reformed, Line.onGrounds, paulineLine,
    dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

#print axioms grace_and_works_rest_on_no_lexical_premise

/-- **Forensic justification is not load-bearing.** Grant the Finnish reading of
Luther that justification is not a declaration only — Christ himself is present
in faith — and sola fide still follows. Proved by weakening, like
`authorship_not_load_bearing`: no step reads the forensic premise.

On what justification *is*, Mannermaa sides with Trent against the Reformed
account, and on sola fide with the Reformed against Trent. This result and
`tridentine_not_establishes` together show the two questions are independent:
Trent's disagreement with sola fide is over merit, not over infusion. -/
@[headline]
theorem forensic_justification_not_load_bearing : Establishes finnish :=
  entails_of_subset (fun _ h => List.mem_append_left _ h) reformed_establishes

#print axioms forensic_justification_not_load_bearing

/-- **The critics carry the Pauline strand.** Deny covenantal nomism with
Gathercole, keep the reading of Galatians as a polemic, leave Luke and Acts out,
and sola fide follows from Paul alone — with the ἔργα νόμου premise derived
rather than assumed. -/
@[headline]
theorem critics_carry_the_pauline_strand : Establishes paulineStrandOnTheCritics := by
  establish [paulineStrandOnTheCritics, reformed, Line.onGrounds, paulineLine, dominicalLine,
    apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

#print axioms critics_carry_the_pauline_strand

/-- Sanders' world, with only Paul to go on: covenantal nomism, so the ἔργα
νόμου premise fails and Paul does not reach faith alone. -/
def sandersReading : Valuation Claim := fun a =>
  match a with
  | .worksOfLawMeansWorksGenerally => False
  | .sozoIsSoteriological => False
  | .acts15YokeIsLawAsCondition => False
  | .justificationByFaithAlone => False
  | .salvationThroughFaith => False
  | _ => True

/-- **And Sanders costs it.** Grant covenantal nomism, and with Dunn's inference
the ἔργα νόμου premise is denied; leave Luke and Acts out, and sola fide does
not follow from Paul.

Between them, this and `critics_carry_the_pauline_strand` locate the ἔργα νόμου
dispute where the literature has it: in a historical question about Second
Temple Judaism, before any question about Paul's Greek. -/
@[headline]
theorem sanders_costs_the_pauline_strand : ¬ Establishes paulineStrandOnSanders := by
  refute_with sandersReading [paulineStrandOnSanders, reformed, Line.onGrounds, paulineLine,
    dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

#print axioms sanders_costs_the_pauline_strand

/-- A reading on which James 2:24 stands unharmonised against Paul. -/
def jamesUnharmonisedReading : Valuation Claim := fun a =>
  match a with
  | .james2_24Compatible => False
  | .salvationNotByWorks => False
  | _ => True

/-- The argument genuinely depends on answering James. Remove the two premises
that harmonise James 2:24 with Paul and sola fide no longer follows, however
much of the rest is retained.

An argument for sola fide that does not engage James 2:24 is not merely
impolite; it is invalid. -/
@[headline]
theorem james_harmonisation_is_load_bearing :
    ¬ Establishes reformedWithoutJamesHarmonisation := by
  refute_with jamesUnharmonisedReading [reformedWithoutJamesHarmonisation, reformed, paulineLine,
    dominicalLine, apostolicLine, sharedGroundsWithoutJames, prooftexts, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, toGraceNotWorks, toThroughFaith, conclusionSteps,
    solaFide, graceNotWorks]

#print axioms james_harmonisation_is_load_bearing

/-! ### Satisfiability

`Entails` is vacuously true over a premise set with no model, so a package
built from contradictory premises would establish its conclusion and every gate
would pass. Only packages carrying a positive `Establishes` result need
checking: one with a `¬ Establishes` result is satisfiable already, because its
countermodel satisfies every premise.

Not tagged `@[headline]` — these are claims about the health of the encoding
rather than about justification. -/

/-- The reading on which every claim in this argument holds at once: the
witness that the packages built from positive grounds are coherent. -/
def everythingHoldsReading : Valuation Claim := fun _ => True

/-- The Reformed package has a model, so `reformed_establishes` is not
vacuous. -/
theorem reformed_is_satisfiable : Satisfiable reformed.premises := by
  satisfied_by everythingHoldsReading [reformed, reformed, Line.onGrounds, paulineLine,
    dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

/-- The New Perspective's own world: Paul's ἔργα νόμου denotes the covenant
boundary markers rather than works in general, and justification is by faith
regardless. The all-holds reading cannot serve here — this package *denies* a
premise, which is the whole point of it. -/
def newPerspectiveOwnReading : Valuation Claim := fun a =>
  match a with
  | .worksOfLawMeansWorksGenerally => False
  | _ => True

/-- The New Perspective package has a model. -/
theorem newPerspective_is_satisfiable : Satisfiable newPerspective.premises := by
  satisfied_by newPerspectiveOwnReading [newPerspective, reformed, Line.onGrounds, paulineLine,
    dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

/-- Hays's own world: πίστις Χριστοῦ is Christ's faithfulness, and everything
else in the Reformed case holds. -/
def subjectiveGenitiveReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | _ => True

/-- The subjective-genitive package has a model, so
`pistisChristou_not_load_bearing` is not vacuous. -/
theorem subjectiveGenitive_is_satisfiable : Satisfiable subjectiveGenitive.premises := by
  satisfied_by subjectiveGenitiveReading [subjectiveGenitive, reformed, Line.onGrounds, paulineLine,
    dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

/-- Jervell's world: the yoke is Israel's law for gentiles, and everything else
in the Reformed case holds. -/
def lawObservantLukeReading : Valuation Claim := fun a =>
  match a with
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- The law-observant package has a model, so `acts15Yoke_not_load_bearing` is
not vacuous. -/
theorem lawObservantLuke_is_satisfiable : Satisfiable lawObservantLuke.premises := by
  satisfied_by lawObservantLukeReading [lawObservantLuke, reformed, Line.onGrounds, paulineLine,
    dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

/-- The critics' world: none of the four disputed letters is by the apostle
whose name it bears, and everything else holds. -/
def criticalAuthorshipReading : Valuation Claim := fun a =>
  match a with
  | .ephesiansIsPauline => False
  | .titusIsPauline => False
  | .firstPeterIsPetrine => False
  | .secondPeterIsPetrine => False
  | _ => True

/-- The critical-authorship package has a model, so
`authorship_not_load_bearing` is not vacuous. -/
theorem criticalAuthorship_is_satisfiable : Satisfiable criticalAuthorship.premises := by
  satisfied_by criticalAuthorshipReading [criticalAuthorship, reformed, Line.onGrounds, paulineLine,
    dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

/-- The Reformed package minus the ἔργα νόμου premise has a model, so
`worksOfLaw_not_load_bearing` is not vacuous. A load-bearing result that held
only because its premises could not all be true would be exactly backwards. -/
theorem reformedWithoutWorksOfLaw_is_satisfiable :
    Satisfiable reformedWithoutWorksOfLaw.premises := by
  satisfied_by everythingHoldsReading [reformedWithoutWorksOfLaw, paulineWithoutWorksOfLaw,
    reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
    criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds, prooftexts,
    closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
    jamesHarmonisation, toGraceNotWorks, toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

/-- And the same minus the dominical lexical premise. -/
theorem reformedWithoutSozo_is_satisfiable :
    Satisfiable reformedWithoutSozo.premises := by
  satisfied_by everythingHoldsReading [reformedWithoutSozo, reformed, Line.onGrounds, paulineLine,
    dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

/-- And the same minus both, so `apostolic_strand_survives_paul_and_luke` is not
vacuous. -/
theorem reformedWithoutWorksOfLawOrSozo_is_satisfiable :
    Satisfiable reformedWithoutWorksOfLawOrSozo.premises := by
  satisfied_by everythingHoldsReading [reformedWithoutWorksOfLawOrSozo, paulineWithoutWorksOfLaw,
    reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
    criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds, prooftexts,
    closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
    jamesHarmonisation, toGraceNotWorks, toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

/-- The apocalyptic package, asked about grace and works, has a model. -/
theorem apocalypticOnGraceAndWorks_is_satisfiable :
    Satisfiable apocalypticOnGraceAndWorks.premises := by
  satisfied_by apocalypticReading [apocalypticOnGraceAndWorks, apocalyptic, reformed,
    apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace, toThroughFaith, graceNotWorks]

/-- With every lexical premise removed, the package still has a model. -/
theorem graceAndWorksWithoutAnyLexicalPremise_is_satisfiable :
    Satisfiable graceAndWorksWithoutAnyLexicalPremise.premises := by
  satisfied_by everythingHoldsReading [graceAndWorksWithoutAnyLexicalPremise, reformed,
    Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine,
    paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps,
    paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation,
    toGraceNotWorks, toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

/-- Mannermaa's world: justification is not forensic only, and everything else
holds. -/
def finnishReading : Valuation Claim := fun a =>
  match a with
  | .justificationIsForensicOnly => False
  | _ => True

/-- The Finnish package has a model, so
`forensic_justification_not_load_bearing` is not vacuous. -/
theorem finnish_is_satisfiable : Satisfiable finnish.premises := by
  satisfied_by finnishReading [finnish, reformed, Line.onGrounds, paulineLine, dominicalLine,
    apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

/-- Gathercole's world: Second Temple Judaism was not uniformly covenantal
nomism, and everything else holds. -/
def criticsReading : Valuation Claim := fun a =>
  match a with
  | .secondTempleCovenantalNomism => False
  | _ => True

/-- The critics' Pauline package has a model, so
`critics_carry_the_pauline_strand` is not vacuous. -/
theorem paulineStrandOnTheCritics_is_satisfiable :
    Satisfiable paulineStrandOnTheCritics.premises := by
  satisfied_by criticsReading [paulineStrandOnTheCritics, reformed, Line.onGrounds, paulineLine,
    dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
    paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGraceNotWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

end Testimony.Arguments.SolaFide
