import TestimonyArguments.SolaFide.Packages
import Testimony.Logic.Tactic

/-!
# TestimonyArguments.SolaFide.Results — what does and does not follow

Entailments are established with `establish`; refutations name a countermodel —
the rival's own reading, written down as a valuation — and use `refute_with`.

The central result is `lexical_premises_jointly_load_bearing`. The argument
needs at least one strand's disputed reading, and does not need any particular
one.

`apostolic_strand_survives_paul_and_luke` and
`johannine_strand_survives_the_other_three` show that Acts and John each reach
the conclusion with the other strands' disputed readings left out.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Results -/

/-- Given the Reformed premises, the conclusion follows. -/
@[headline]
theorem reformed_establishes : Establishes reformed := by
  establish [solaFideDefs]

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
  establish [solaFideDefs]

#print axioms newPerspective_establishes

/-- The Tridentine reading, as a valuation: works merit an increase of
justification, so salvation is not apart from works; and justification renews
the inward man, so it is not forensic only, not distinct from sanctification,
and not had by faith alone — faith without charity does not suffice. -/
def tridentineReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | _ => True

/-- The Tridentine premises do not establish the conclusion — they entail the
negation of its second part, that salvation is not by works. -/
@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  refute_with tridentineReading [solaFideDefs]

#print axioms tridentine_not_establishes

/-- The ἔργα νόμου premise is **not** load-bearing on its own: strip it and
the other strands still carry the argument. -/
@[headline]
theorem worksOfLaw_not_load_bearing : Establishes reformedWithoutWorksOfLaw := by
  establish [solaFideDefs]

#print axioms worksOfLaw_not_load_bearing

/-- Nor is the dominical lexical premise: strip it and the other strands still
carry the argument. -/
@[headline]
theorem sozo_not_load_bearing : Establishes reformedWithoutSozo := by
  establish [solaFideDefs]

#print axioms sozo_not_load_bearing

/-- **Acts supplies "through faith" with the other strands' disputed readings
left out.** Leave out the reading of "works of the law" in Paul, of "saved" in
Luke 7:50, and of believing in John 6:29; that is, assume none of them either
way. Keep what every strand shares: the verses on grace and works, and the
answer to James. Sola fide still follows, with Peter's speech at Jerusalem
(Acts 15:7–11) as the only route to faith.

What this claims: Peter's strand does not lean on any of the other three
disputes. What it does not claim: that Peter's strand is beyond dispute, or
that Acts 15 is the only text used. The strand rests on its own disputed
reading, of the yoke at 15:10. The result's name is older than the strand from
John; John's reading is left out as well. -/
@[headline]
theorem apostolic_strand_survives_paul_and_luke :
    Establishes reformedRestingOnActs := by
  establish [solaFideDefs]

#print axioms apostolic_strand_survives_paul_and_luke

/-- **John supplies "through faith" with the other strands' disputed readings
left out.** Leave out the reading of "works of the law" in Paul, of "saved" in
Luke 7:50, and of the yoke in Acts 15:10; that is, assume none of them either
way. Keep what every strand shares: the verses on grace and works, and the
answer to James. Sola fide still follows, with Jesus' answer in John 6:29 as
the only route to faith: "This is the work of God, that you believe in him whom
he has sent."

What this claims: a reader who wins the disputes over Paul, Luke and Acts has
not yet answered John. What it does not claim: that John's strand is beyond
dispute, or that John 6:29 is the only text used. Grace and "not by works" still
come from the shared verses and the answer to James. The strand rests on
reading that believing as trust, which Aquinas denies
(`johannine_strand_rests_on_believing_as_trust`), and on a step from "eternal
life through believing" to "justified by faith alone" that is rated
`plausible`. -/
@[headline]
theorem johannine_strand_survives_the_other_three :
    Establishes reformedRestingOnJohn := by
  establish [solaFideDefs]

#print axioms johannine_strand_survives_the_other_three

/-- The objective genitive is not load-bearing for sola fide as a whole. Grant
Hays that πίστις Χριστοῦ is Christ's own faithfulness, keep everything else,
and the conclusion still follows.

The genitive is the hinge of the Pauline strand, as
`pistisChristou_jointly_load_bearing` shows. It is not the hinge of the
argument. A reader who wins the genitive for Hays has cost the Reformed case
its Pauline route, and not its conclusion. -/
@[headline]
theorem pistisChristou_not_load_bearing : Establishes subjectiveGenitive := by
  establish [solaFideDefs]

#print axioms pistisChristou_not_load_bearing

/-- **Nor is the yoke.** Grant Jervell that the yoke of Acts 15:10 is Israel's
law laid on gentiles, not the law as a condition of salvation, keep everything
else, and the conclusion still follows by Paul and by Luke 7:50. -/
@[headline]
theorem acts15Yoke_not_load_bearing : Establishes lawObservantLuke := by
  establish [solaFideDefs]

#print axioms acts15Yoke_not_load_bearing

/-- A reading on which no strand's disputed premise holds. Paul's "works of the
law" are the boundary markers. Jesus' "your faith has saved you" at Luke 7:50 is
about healing. Peter's yoke is Israel's law laid on gentiles. And the believing
of John 6:29 is not bare trust. Every text stands; faith is not said to be
enough. -/
def neitherLexicalReading : Valuation Claim := fun a =>
  match a with
  | .worksOfLawMeansWorksGenerally => False
  | .sozoIsSoteriological => False
  | .acts15YokeIsLawAsCondition => False
  | .johannineBelievingIsTrust => False
  | .justificationByFaithAlone => False
  | .faithIsSufficient => False
  | .salvationThroughFaith => False
  | _ => True

/-- **Sola fide fails to follow only when every strand loses its disputed
reading.** Remove one disputed reading from each strand — "works of the law" as works in
general from Paul, "saved" as salvation from Luke 7:50, the yoke as the law as a
condition of salvation from Acts 15, believing as trust from John 6:29 — and
keep everything else. Sola fide no longer follows. Remove fewer, and a strand
that still has its reading reaches the conclusion.

So the argument, as encoded here, does not hang on the meaning of Paul's "works
of the law". It hangs on that, *or* on Luke's "saved", *or* on Peter's yoke,
*or* on John's "believe". Someone who denies sola fide has to answer all four.
The same holds with "faith of Christ" (πίστις Χριστοῦ) in place of "works of the
law"; see `pistisChristou_jointly_load_bearing`.

What this does not claim: that the four are independent in practice. A reader
who takes "works of the law" as boundary markers will usually read Peter's yoke
the same way. The result shows that four separate premises would each have to
be denied. It does not show that four separate groups of scholars deny them. -/
@[headline]
theorem lexical_premises_jointly_load_bearing :
    ¬ Establishes reformedWithoutEveryStrandsPremise := by
  refute_with neitherLexicalReading [solaFideDefs]

#print axioms lexical_premises_jointly_load_bearing

/-- A reading on which Galatians 2:16 names Christ's own faithfulness and not
faith in Christ, Jesus' "your faith has saved you" is about healing, Peter's
yoke is Israel's law laid on gentiles, and the believing of John 6:29 is not
bare trust. -/
def neitherPistisNorSozoReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .sozoIsSoteriological => False
  | .acts15YokeIsLawAsCondition => False
  | .johannineBelievingIsTrust => False
  | .justificationByFaithAlone => False
  | .faithIsSufficient => False
  | .salvationThroughFaith => False
  | _ => True

/-- **Within the Pauline strand, faith in Christ is load-bearing.** Deny the
objective genitive, and the disputed reading of each of the other three strands, keep the
ἔργα νόμου premise and the reading of Galatians as a polemic against
circumcision, and sola fide no longer follows.

Excluding works is not enough to reach *faith alone*. Galatians 2:16 must also
name the believer's faith as the means, and on the subjective genitive it does
not. So the Pauline strand rests on two disputed readings of one verse, either
of which costs it the conclusion. -/
@[headline]
theorem pistisChristou_jointly_load_bearing :
    ¬ Establishes reformedWithoutPistisChristouSozoOrYoke := by
  refute_with neitherPistisNorSozoReading [solaFideDefs]

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
  | .faithIsSufficient => False
  | .salvationThroughFaith => False
  | _ => True

/-- **The apocalyptic reading does not establish sola fide.** It does not reach
the conclusion's third part, "through faith": nothing it holds says that faith
suffices, and the faith alone from which Paul's strand derives it, it denies.

What it keeps is stated as its own result,
`apocalyptic_establishes_grace_not_works`. -/
@[headline]
theorem apocalyptic_not_establishes : ¬ Establishes apocalyptic := by
  refute_with apocalypticReading [solaFideDefs]

#print axioms apocalyptic_not_establishes

/-- **What the apocalyptic reading keeps: grace, and not by works.** If
δικαιοσύνη θεοῦ is God's act of deliverance, salvation is sheer gift,
conditioned on nothing a person does. The reading establishes the first two
parts of the conclusion by its own route, and denies the third.

So the dispute between the apocalyptic and Reformed readings is located
exactly: it is over *through faith*, and not over grace or works. -/
@[headline]
theorem apocalyptic_establishes_grace_not_works : Establishes apocalypticOnGraceAndWorks := by
  establish [solaFideDefs]

#print axioms apocalyptic_establishes_grace_not_works

/-- **Grace, and not by works, rest on no lexical premise.** Remove every one —
ἔργα νόμου and πίστις Χριστοῦ from Paul, σῴζω from Luke, the yoke from Acts —
and the first two parts of the conclusion still follow, from the texts that say
"not of works" in terms and the answer to James.

The lexical disputes decide *through faith*: whether the texts that
exclude works also name faith as the means. They do not decide whether works
are excluded. -/
@[headline]
theorem grace_and_works_rest_on_no_lexical_premise :
    Establishes graceAndWorksWithoutAnyLexicalPremise := by
  establish [solaFideDefs]

#print axioms grace_and_works_rest_on_no_lexical_premise

/-- **Forensic justification is not load-bearing.** Grant the Finnish reading of
Luther that justification is not a declaration only — Christ himself is present
in faith — and sola fide still follows. Proved by weakening, like
`authorship_not_load_bearing`: no step reads the forensic premise.

On what justification *is*, Mannermaa sides with Trent against the Reformed
account, and on sola fide with the Reformed against Trent. This result and
`tridentine_not_establishes` together show that denying the forensic account
does not by itself deny sola fide. What Trent's denial rests on is narrower:
that justification includes the sanctification that grows through works
(`trent_objection_rests_on_its_definition`). -/
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
  establish [solaFideDefs]

#print axioms critics_carry_the_pauline_strand

/-- Sanders' world, with only Paul to go on: covenantal nomism, so the ἔργα
νόμου premise fails and Paul does not reach faith alone. -/
def sandersReading : Valuation Claim := fun a =>
  match a with
  | .worksOfLawMeansWorksGenerally => False
  | .sozoIsSoteriological => False
  | .acts15YokeIsLawAsCondition => False
  | .justificationByFaithAlone => False
  | .faithIsSufficient => False
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
  refute_with sandersReading [solaFideDefs]

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
  refute_with jamesUnharmonisedReading [solaFideDefs]

#print axioms james_harmonisation_is_load_bearing

/-- **But grace does not need it.** Remove the answer to James and salvation by
grace still follows, from Ephesians 2:8, Romans 4:4–5 and Titus 3:5 alone.
James 2:24 is load-bearing for *not by works*, the part it appears to contradict,
and for nothing else — which the single closing step this argument once had
could not show. -/
@[headline]
theorem grace_needs_no_answer_to_james : Establishes graceWithoutJamesHarmonisation := by
  establish [solaFideDefs]

#print axioms grace_needs_no_answer_to_james

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
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- The New Perspective's own world: Paul's ἔργα νόμου denotes the covenant
boundary markers rather than works in general, and justification is by faith
regardless. The all-holds reading cannot serve here — this package *denies* a
premise, which is the whole point of it. Faith the only means and justification
forensic only, it denies Trent's baptism as the instrument and justification as
including sanctification. -/
def newPerspectiveOwnReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .worksOfLawMeansWorksGenerally => False
  | .baptismIsInstrumentalCause => False
  | .justificationIncludesSanctification => False
  | _ => True

/-- The New Perspective package has a model. -/
theorem newPerspective_is_satisfiable : Satisfiable newPerspective.premises := by
  satisfied_by newPerspectiveOwnReading [solaFideDefs]

/-- Hays's own world: πίστις Χριστοῦ is Christ's faithfulness, and everything
else in the Reformed case holds. -/
def subjectiveGenitiveReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | _ => True

/-- The subjective-genitive package has a model, so
`pistisChristou_not_load_bearing` is not vacuous. -/
theorem subjectiveGenitive_is_satisfiable : Satisfiable subjectiveGenitive.premises := by
  satisfied_by subjectiveGenitiveReading [solaFideDefs]

/-- Jervell's world: the yoke is Israel's law for gentiles, and everything else
in the Reformed case holds. -/
def lawObservantLukeReading : Valuation Claim := fun a =>
  match a with
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- The law-observant package has a model, so `acts15Yoke_not_load_bearing` is
not vacuous. -/
theorem lawObservantLuke_is_satisfiable : Satisfiable lawObservantLuke.premises := by
  satisfied_by lawObservantLukeReading [solaFideDefs]

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
  satisfied_by criticalAuthorshipReading [solaFideDefs]

/-- The Reformed package minus the ἔργα νόμου premise has a model, so
`worksOfLaw_not_load_bearing` is not vacuous. A load-bearing result that held
only because its premises could not all be true would be exactly backwards. -/
theorem reformedWithoutWorksOfLaw_is_satisfiable :
    Satisfiable reformedWithoutWorksOfLaw.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- And the same minus the dominical lexical premise. -/
theorem reformedWithoutSozo_is_satisfiable :
    Satisfiable reformedWithoutSozo.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- The package resting on Acts can be held without contradiction, so
`apostolic_strand_survives_paul_and_luke` is not true merely because its
premises could never all hold. -/
theorem reformedRestingOnActs_is_satisfiable :
    Satisfiable reformedRestingOnActs.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- And so can the package resting on John, so
`johannine_strand_survives_the_other_three` is not empty either. -/
theorem reformedRestingOnJohn_is_satisfiable :
    Satisfiable reformedRestingOnJohn.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- The apocalyptic package, asked about grace and works, has a model. -/
theorem apocalypticOnGraceAndWorks_is_satisfiable :
    Satisfiable apocalypticOnGraceAndWorks.premises := by
  satisfied_by apocalypticReading [solaFideDefs]

/-- With every lexical premise removed, the package still has a model. -/
theorem graceAndWorksWithoutAnyLexicalPremise_is_satisfiable :
    Satisfiable graceAndWorksWithoutAnyLexicalPremise.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- Mannermaa's world: justification is not forensic only, and everything else
holds. -/
def finnishReading : Valuation Claim := fun a =>
  match a with
  | .justificationIsForensicOnly => False
  | _ => True

/-- The Finnish package has a model, so
`forensic_justification_not_load_bearing` is not vacuous. -/
theorem finnish_is_satisfiable : Satisfiable finnish.premises := by
  satisfied_by finnishReading [solaFideDefs]

/-- Gathercole's world: Second Temple Judaism was not uniformly covenantal
nomism, and everything else holds. Faith the only means and justification
forensic only, it denies Trent's baptism as the instrument and justification as
including sanctification. -/
def criticsReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .jamesUsesDikaioAsPaul => False
  | .secondTempleCovenantalNomism => False
  | .baptismIsInstrumentalCause => False
  | .justificationIncludesSanctification => False
  | _ => True

/-- The critics' Pauline package has a model, so
`critics_carry_the_pauline_strand` is not vacuous. -/
theorem paulineStrandOnTheCritics_is_satisfiable :
    Satisfiable paulineStrandOnTheCritics.premises := by
  satisfied_by criticsReading [solaFideDefs]

/-- With the answer to James removed, the package asked about grace still has a
model, so `grace_needs_no_answer_to_james` is not vacuous. -/
theorem graceWithoutJamesHarmonisation_is_satisfiable :
    Satisfiable graceWithoutJamesHarmonisation.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

end TestimonyArguments.SolaFide
