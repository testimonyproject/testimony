import TestimonyArguments.SolaFide.Packages
import Testimony.Logic.Tactic

/-!
# TestimonyArguments.SolaFide.Results — what follows, and what does not

Each result takes one position and asks whether its conclusion follows from its
premises. Where it does, the result says so. Where it does not, the result
names a *reading*: a consistent way of taking the texts on which every premise
holds and the conclusion fails. That reading is the rival position, written
down, and a reader can check it verse by verse.

Many results ask what the case depends on. A premise is taken out, everything
else is kept, and the result says whether the conclusion still follows. If it
does, the case never needed that premise.

The central result is the one already met in the first chapter. The case needs
a disputed reading from at least one strand, and does not need any particular
one (`lexical_premises_jointly_load_bearing`). Acts and John each reach the
conclusion with every other strand's disputed reading left out
(`apostolic_strand_survives_paul_and_luke`,
`johannine_strand_survives_the_other_three`).
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Results -/

/-- **Grant the Reformed premises, and sola fide follows.** The premises are the
texts all four strands read, the disputed reading each strand depends on, and
the answer to James 2:24.

What this claims: the argument is valid. What it does not claim: that the
premises are true. Each disputed reading is denied by a scholar cited on this
page. -/
@[headline]
theorem reformed_establishes : Establishes reformed := by
  establish [solaFideDefs]

#print axioms reformed_establishes

/-- **The New Perspective reaches the same conclusion.** Dunn and Wright reject the
traditional reading of "works of the law" (ἔργα νόμου). They do not reject
justification by faith. Leave Paul's phrase to them, and sola fide still
follows, from Jesus' words at Luke 7:50.

What this claims: winning the argument over "works of the law" does not defeat
sola fide. What it does not claim: that Dunn or Wright would put it this way, or
that their reading of Paul is right. Their critics dispute the reading, not this
result. -/
@[headline]
theorem newPerspective_establishes : Establishes newPerspective := by
  establish [solaFideDefs]

#print axioms newPerspective_establishes

/-- The Council of Trent's reading, written out. Works done in grace merit an
increase of justification, so salvation is not apart from works. Justification
renews the inward person, so it is not only a verdict and is not distinct from
sanctification. And it is not had by faith alone: faith without charity does not
suffice. Every text holds. -/
def tridentineReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | _ => True

/-- **Trent's premises do not lead to sola fide.** They lead to the denial of its
second part: on Trent's account salvation is not apart from works.

What this claims: a reader who holds what Trent holds is not committed to sola
fide, and the reading above shows a consistent way to hold it. What it does not
claim: that Trent is wrong, or right. -/
@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  refute_with tridentineReading [solaFideDefs]

#print axioms tridentine_not_establishes

/-- **The argument does not depend on the reading of "works of the law".** Remove
the premise that Paul's phrase (ἔργα νόμου) means works in general, keep
everything else, and sola fide still follows by the other strands. -/
@[headline]
theorem worksOfLaw_not_load_bearing : Establishes reformedWithoutWorksOfLaw := by
  establish [solaFideDefs]

#print axioms worksOfLaw_not_load_bearing

/-- **Nor on the reading of "saved" at Luke 7:50.** Remove the premise that the word
there (σῴζω) means saved and not healed, keep everything else, and sola fide
still follows by the other strands. -/
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

/-- **Nor on "faith in Christ".** Grant Hays that the phrase in Galatians 2:16
(πίστις Χριστοῦ) means Christ's own faithfulness and not our faith in him. Keep
everything else. Sola fide still follows.

What this claims: a reader who wins this point for Hays has cost the Reformed
case its route through Paul, and not its conclusion. What it does not claim:
that the point is unimportant to Paul's strand. Within that strand everything
depends on it; see `pistisChristou_jointly_load_bearing`. -/
@[headline]
theorem pistisChristou_not_load_bearing : Establishes subjectiveGenitive := by
  establish [solaFideDefs]

#print axioms pistisChristou_not_load_bearing

/-- **Nor on the yoke.** Grant Jervell that the yoke Peter refuses at Acts 15:10 is
Israel's law laid on gentiles, and not the law as a condition of salvation. Keep
everything else. Sola fide still follows, by Paul, by Luke 7:50 and by John. -/
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

/-- **Within Paul's strand, "faith in Christ" is needed.** Deny that Galatians 2:16
speaks of our faith in Christ, and leave out the disputed reading of each of the
other three strands. Keep the reading of "works of the law" as works in general,
and keep Galatians as a letter against requiring circumcision. Sola fide no
longer follows.

Excluding works is not yet *faith alone*. The verse must also name the
believer's faith as the means, and on Hays's reading it does not. So Paul's
strand rests on two disputed readings of one verse, and losing either costs it
the conclusion. -/
@[headline]
theorem pistisChristou_jointly_load_bearing :
    ¬ Establishes reformedWithoutPistisChristouSozoOrYoke := by
  refute_with neitherPistisNorSozoReading [solaFideDefs]

#print axioms pistisChristou_jointly_load_bearing

/-- **The argument does not depend on who wrote the disputed letters.** Grant every
critical conclusion: that Ephesians and Titus are not by Paul, and 1 and 2 Peter
not by Peter. Sola fide still follows.

The argument reads these letters as Scripture, not as the testimony of a named
apostle, so their authorship is not one of its premises. The proof shows this
directly: it adds the four denials to the Reformed premises and uses none of
them.

What this costs is stated at `criticalAuthorship`. The letters cannot then be
used as evidence of what *Paul* meant by "works", which is why that premise
rests on Romans. -/
@[headline]
theorem authorship_not_load_bearing : Establishes criticalAuthorship :=
  entails_of_subset (fun _ h => List.mem_append_left _ h) reformed_establishes

#print axioms authorship_not_load_bearing

/-- The apocalyptic reading of Paul (Martyn, Campbell), written out. "Faith of
Christ" is Christ's own faithfulness. "The righteousness of God" is God's act of
rescue. Faith is not the condition on which a person is justified. Everything
else it grants. -/
def apocalypticReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | .faithIsSufficient => False
  | .salvationThroughFaith => False
  | _ => True

/-- **The apocalyptic reading does not lead to sola fide.** It does not reach the
third part of the conclusion, "through faith". Nothing it holds says that faith
is enough, and it denies the faith alone from which Paul's strand would derive
that.

What it does reach is stated as a result of its own,
`apocalyptic_establishes_grace_not_works`. -/
@[headline]
theorem apocalyptic_not_establishes : ¬ Establishes apocalyptic := by
  refute_with apocalypticReading [solaFideDefs]

#print axioms apocalyptic_not_establishes

/-- **The apocalyptic reading keeps grace, and "not by works".** If "the
righteousness of God" is God's act of rescue, then salvation is a gift that
depends on nothing a person does. So the reading reaches the first two parts of
the conclusion by its own route.

This places its disagreement with the Reformed reading exactly. They differ over
*through faith*. They do not differ over grace or over works. -/
@[headline]
theorem apocalyptic_establishes_grace_not_works : Establishes apocalypticOnGraceAndWorks := by
  establish [solaFideDefs]

#print axioms apocalyptic_establishes_grace_not_works

/-- **Grace, and "not by works", depend on none of the disputed readings.** Remove
all of them: both of Paul's, Luke's "saved", the yoke in Acts and believing as
trust in John. The first two parts of the conclusion still follow, from the
verses that say "not of works" in as many words and from the answer to James.

So the disputed readings decide one thing: whether the texts that exclude works
also name faith as the means. They do not decide whether works are excluded. -/
@[headline]
theorem grace_and_works_rest_on_no_lexical_premise :
    Establishes graceAndWorksWithoutAnyLexicalPremise := by
  establish [solaFideDefs]

#print axioms grace_and_works_rest_on_no_lexical_premise

/-- **The argument does not depend on justification being only a verdict.** Grant
the Finnish reading of Luther (Mannermaa): justification is not a declaration
and nothing more, because Christ himself is present in faith. Sola fide still
follows. The proof adds that one denial to the Reformed premises and uses
nothing else.

On what justification *is*, Mannermaa stands with Trent against the Reformed
account. On sola fide he stands with the Reformed against Trent. So denying the
verdict-only account does not by itself deny sola fide. What Trent's objection
needs is narrower: that justification includes the sanctification that grows
through works (`trent_objection_rests_on_its_definition`). -/
@[headline]
theorem forensic_justification_not_load_bearing : Establishes finnish :=
  entails_of_subset (fun _ h => List.mem_append_left _ h) reformed_establishes

#print axioms forensic_justification_not_load_bearing

/-- **On the critics' account of Judaism, Paul alone reaches sola fide.** Gathercole
and others deny that Judaism in Paul's day was simply "in by grace, staying in
by obedience". Grant them that, keep Galatians as a letter against requiring
circumcision, and leave Luke, Acts and John out. Sola fide follows from Paul,
and the reading of "works of the law" as works in general is derived and not
assumed. -/
@[headline]
theorem critics_carry_the_pauline_strand : Establishes paulineStrandOnTheCritics := by
  establish [solaFideDefs]

#print axioms critics_carry_the_pauline_strand

/-- Sanders' account, with only Paul to go on. Judaism taught entry by grace and
staying in by obedience, so "works of the law" are not works in general, and
Paul's strand does not reach faith alone. -/
def sandersReading : Valuation Claim := fun a =>
  match a with
  | .worksOfLawMeansWorksGenerally => False
  | .sozoIsSoteriological => False
  | .acts15YokeIsLawAsCondition => False
  | .justificationByFaithAlone => False
  | .faithIsSufficient => False
  | .salvationThroughFaith => False
  | _ => True

/-- **On Sanders' account, Paul alone does not.** Grant Sanders his account of
Judaism and Dunn his inference from it, and "works of the law" does not mean
works in general. Leave Luke, Acts and John out, and sola fide does not follow
from Paul.

Taken with `critics_carry_the_pauline_strand`, this shows where the dispute over
"works of the law" lies: in a question about first-century Judaism, which has to
be answered before the question about Paul's Greek. -/
@[headline]
theorem sanders_costs_the_pauline_strand : ¬ Establishes paulineStrandOnSanders := by
  refute_with sandersReading [solaFideDefs]

#print axioms sanders_costs_the_pauline_strand

/-- A reading on which James 2:24, "justified by works and not by faith alone",
stands against Paul with no answer given. -/
def jamesUnharmonisedReading : Valuation Claim := fun a =>
  match a with
  | .james2_24Compatible => False
  | .salvationNotByWorks => False
  | _ => True

/-- **The argument depends on answering James.** Remove the two premises that
reconcile James 2:24 with Paul, keep everything else, and sola fide no longer
follows.

So a case for sola fide that does not deal with James 2:24 is incomplete: its
conclusion does not follow from what it has said. -/
@[headline]
theorem james_harmonisation_is_load_bearing :
    ¬ Establishes reformedWithoutJamesHarmonisation := by
  refute_with jamesUnharmonisedReading [solaFideDefs]

#print axioms james_harmonisation_is_load_bearing

/-- **Grace does not depend on answering James.** Remove the answer to James, and
"salvation is by grace" still follows, from Ephesians 2:8, Romans 4:4–5 and
Titus 3:5.

James 2:24 bears on *not by works*, the part of the conclusion it appears to
contradict, and on nothing else. -/
@[headline]
theorem grace_needs_no_answer_to_james : Establishes graceWithoutJamesHarmonisation := by
  establish [solaFideDefs]

#print axioms grace_needs_no_answer_to_james

/-! #### Can the premises be true together?

Anything follows from premises that contradict each other. So a position that
"establishes" its conclusion only because its premises could never all be true
would show nothing, and every other check would still pass. For each position
with a result saying its conclusion follows, a reading is named below on which
all its premises hold.

A position with a result saying its conclusion does *not* follow needs no such
check. The reading that shows the conclusion failing already makes every premise
true.

These are checks on the encoding, not claims about justification, so they are
not listed among the main results. -/

/-- The reading on which every claim in this argument holds at once. It shows that
the positions built only from affirmations do not contradict themselves. -/
def everythingHoldsReading : Valuation Claim := fun _ => True

/-- The Reformed premises can all be true together. Without this, "sola fide follows
from them" would be empty: anything follows from premises that contradict each
other. -/
theorem reformed_is_satisfiable : Satisfiable reformed.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- The New Perspective's own reading. Paul's "works of the law" are the boundary
markers and not works in general, and justification is by faith all the same. It
also holds that faith is the only means and that justification is a verdict, so
it denies Trent's account of baptism as the instrument and of justification as
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

/-- The New Perspective's premises can all be true together. -/
theorem newPerspective_is_satisfiable : Satisfiable newPerspective.premises := by
  satisfied_by newPerspectiveOwnReading [solaFideDefs]

/-- Hays's reading: "faith of Christ" is Christ's own faithfulness, and everything
else in the Reformed case holds. -/
def subjectiveGenitiveReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | _ => True

/-- That position can be held without contradiction, so
`pistisChristou_not_load_bearing` is not empty. -/
theorem subjectiveGenitive_is_satisfiable : Satisfiable subjectiveGenitive.premises := by
  satisfied_by subjectiveGenitiveReading [solaFideDefs]

/-- Jervell's reading: the yoke is Israel's law for gentiles, and everything else in
the Reformed case holds. -/
def lawObservantLukeReading : Valuation Claim := fun a =>
  match a with
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- That position can be held without contradiction, so
`acts15Yoke_not_load_bearing` is not empty. -/
theorem lawObservantLuke_is_satisfiable : Satisfiable lawObservantLuke.premises := by
  satisfied_by lawObservantLukeReading [solaFideDefs]

/-- The critical view of authorship: none of the four disputed letters is by the
apostle whose name it bears, and everything else holds. -/
def criticalAuthorshipReading : Valuation Claim := fun a =>
  match a with
  | .ephesiansIsPauline => False
  | .titusIsPauline => False
  | .firstPeterIsPetrine => False
  | .secondPeterIsPetrine => False
  | _ => True

/-- That position can be held without contradiction, so
`authorship_not_load_bearing` is not empty. -/
theorem criticalAuthorship_is_satisfiable : Satisfiable criticalAuthorship.premises := by
  satisfied_by criticalAuthorshipReading [solaFideDefs]

/-- The Reformed premises without the reading of "works of the law" can all be true
together, so `worksOfLaw_not_load_bearing` is not empty. -/
theorem reformedWithoutWorksOfLaw_is_satisfiable :
    Satisfiable reformedWithoutWorksOfLaw.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- And the same without the reading of "saved" at Luke 7:50. -/
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

/-- The apocalyptic reading, asked about grace and works, can be held without
contradiction. -/
theorem apocalypticOnGraceAndWorks_is_satisfiable :
    Satisfiable apocalypticOnGraceAndWorks.premises := by
  satisfied_by apocalypticReading [solaFideDefs]

/-- With every disputed reading removed, the premises can still all be true
together. -/
theorem graceAndWorksWithoutAnyLexicalPremise_is_satisfiable :
    Satisfiable graceAndWorksWithoutAnyLexicalPremise.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-- Mannermaa's reading: justification is not only a verdict, and everything else
holds. -/
def finnishReading : Valuation Claim := fun a =>
  match a with
  | .justificationIsForensicOnly => False
  | _ => True

/-- That position can be held without contradiction, so
`forensic_justification_not_load_bearing` is not empty. -/
theorem finnish_is_satisfiable : Satisfiable finnish.premises := by
  satisfied_by finnishReading [solaFideDefs]

/-- The critics' reading (Gathercole): Judaism in Paul's day was not simply "in by
grace, staying in by obedience", and everything else holds. Faith is the only
means and justification is a verdict, so this reading denies Trent's account of
baptism as the instrument and of justification as including sanctification. -/
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

/-- That position can be held without contradiction, so
`critics_carry_the_pauline_strand` is not empty. -/
theorem paulineStrandOnTheCritics_is_satisfiable :
    Satisfiable paulineStrandOnTheCritics.premises := by
  satisfied_by criticsReading [solaFideDefs]

/-- With the answer to James removed, the premises asked about grace can still all
be true together, so `grace_needs_no_answer_to_james` is not empty. -/
theorem graceWithoutJamesHarmonisation_is_satisfiable :
    Satisfiable graceWithoutJamesHarmonisation.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

end TestimonyArguments.SolaFide
