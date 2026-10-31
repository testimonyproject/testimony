import TestimonyArguments.BornOfAVirgin.Dispute.Septuagint
import Testimony.Logic.Credibility
import Testimony.Logic.Certificate

/-!
# TestimonyArguments.BornOfAVirgin.Dispute.Miller — a dissent, with what the texts refute struck

The laws' step (`lawsLine`) is rated `disputed` on one reader, Robert J. Miller.
He grants what the laws of Leviticus 21 and Deuteronomy 22 require, and denies
that the word in them means "virgin": "As in other Greek literature, parthenos in
the Septuagint did not by itself connote what we mean by virginity", so that the
virginity "has to be inferred from the context" (*Born Divine*). This module asks
the question a reader asks of any such dissent: **does it still stand once the
texts it cites are read?**

## His evidence, read

Miller gives two uses of the word of a woman who is not a virgin.

- **Joel 1:8**, "Lament like a parthenos dressed in sackcloth for the husband of
  her youth", a young widow. The Greek does not read so: it calls the woman
  νύμφην, a bride, and its παρθεν- word, τὸν παρθενικόν, is of the husband
  (Rahlfs). The text refutes the claim.
- **Genesis 34:3**: "In one passage, this term refers to a rape victim after she
  has been attacked." The Greek calls Dinah a παρθένος in the verse after
  Shechem lies with her, and that much the text reads. But Miller's claim is
  more: that the noun describes her as she then was, no longer a virgin, so that
  it is not used there in the sense "virgin". That is his premise, not the
  text's. The order of the verses puts Shechem's love after his act; it does not
  put the noun's description there. A noun is read at a time of its own, which
  the context gives (Enç 1986): Scripture names Rahab "the harlot" long after
  Jericho (Hebrews 11:31). The status reading takes the noun as the law's name
  for the woman a man has lain with (`dinahLine`).

## What the checks find

The library strikes a claim only when a reading of a text refutes it — Scripture,
rated `consensus` — and then runs every check on what is left
(`Testimony.Logic.Credibility`). Struck of Joel 1:8, Miller's dissent is his
case from Genesis 34:3 (`miller_struck_is_his_case_from_genesis`), and it still
denies the laws' step, granting the laws' grounds. His premise about the noun is
not struck: no text reads otherwise, and an argument strikes nothing. It is
weighed instead.

- **Under the evidence and tradition standards** his dissent is a credible
  critique. His premise rests on argued scholarship, which both standards
  admit.
- **Under the Scripture standard** it is not
  (`miller_survives_on_genesis`). The laws' grounds are all Scripture, and a
  dissent from such a step must rest on Scripture alone. What the Greek of
  34:3 reads is Scripture; that its noun describes Dinah as she then was is
  Miller's reading of it.
- **His denial needs that premise** (`miller_rests_on_the_noun`). Grant what the
  Greek reads and every step of his, and the laws' sense can still stand.

Had Joel 1:8 been all his evidence, the dissent would not count under any
standard: struck of it, nothing in it would deny the step
(`miller_on_joel_alone_does_not_count`). That is the rule at work: evidence the
texts refute stops counting, and a dissent that needed it stops counting with it.

## Weighed in the dispute, and overruled

A credible dissent can still lose when it is weighed. In `Dispute.Septuagint`
Miller's case from Genesis 34:3 is a party, beside Wegner's, and the solver
computes that nothing can defend it (`miller_indefensible`). The status reading
concludes that the word names Dinah in the sense "virgin", which Miller's
premise and his thesis deny; he attacks it back, and fails, because his step,
rated `disputed`, is weaker than the status reading's, rated `plausible`. Nothing
answers the status reading, so nothing defends Miller.

A dissent overruled so stops counting against the step
(`Testimony.Logic.Credibility`, `Overruled`), on one condition, which keeps the
rule from arguing in a circle: the dispute must weigh the step at its floor. It
does. The case from the laws cites its step `disputed` there, so Miller is
overruled with the laws at their weakest, and the overruling owes nothing to the
rating it lets stand.

So the laws' step stands at its cited `wellSupported` under every standard
(`laws_step_ratings`): under the evidence and tradition standards because the
one credible dissent is overruled, and under the Scripture standard because it
is not heard. The verdict turns, as the dispute's does, on the status reading's
step, rated `plausible`. Rated `disputed`, it would not outrank Miller, he would
stand off with it, and his dissent would count again.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Logic Testimony.Bib Testimony.Scripture

/-! ### Miller's dissent -/

/-- **What the Greek of Joel 1:8 reads**: the woman is νύμφην, a bride, and
τὸν παρθενικόν is said of her husband. A reading of the text, from Rahlfs. -/
def joelReadsABride : Refutation Claim :=
  { claim := .joelGreekCallsTheWidowParthenos
  , reads := "the Greek of Joel 1:8 calls the woman νύμφην, a bride; its παρθεν- word, " ++
      "τὸν παρθενικόν, is of the husband"
  , reading :=
      { primary := .scripture [verseIn .septuagint ⟨.joel, 1, 8⟩]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-! ### Assessed, with what the texts refute struck -/

/-- **Miller against the laws' step**, with Joel 1:8 struck. Consistent,
granting the laws' grounds, and argued: struck of Joel 1:8, his dissent still
denies the step through Genesis 34:3. What it still asserts outright is the
Greek's reading of the verse, and his premise that its noun describes Dinah as
she then was. The first is Scripture; the second is his reading of it, argued
scholarship. So the dissent is a credible critique under the evidence and
tradition standards. Under the Scripture standard it is not: the laws' grounds
are all Scripture, and his premise is not. -/
def millerOnLawsAssessment : Assessment Claim where
  dissenter := "Miller, Born Divine"
  against := lawsLine.name
  dissent :=
    { claim := p .lawsUseParthenosAsVirgin
    , grounds := lawsLine.grounds
    , position := millerOnTheLaws
    , refuted := [joelReadsABride] }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, []), (.tradition, [])
        , (.scriptural, [.parthenosDescribesDinahAsSheThenWas]) ]
    , struck := [.joelGreekCallsTheWidowParthenos] }
  checked := by horn_certify

/-- **Struck of Joel 1:8, Miller's dissent is his case from Genesis 34:3**: with
the claim the Greek refutes taken out, and his step from it, the premises the
checks weigh are, formula for formula, the premises of the position
he holds in the dispute over the Septuagint's word (`millerCase`). -/
theorem miller_struck_is_his_case_from_genesis :
    millerOnLawsAssessment.dissent.premises = millerCase.premises := by
  rfl

/-- **Miller survives on Genesis 34:3, and turns on the standard.** Struck of
Joel 1:8, which the Greek refutes, his dissent from the laws' step is still a
credible critique under the evidence and tradition standards: Genesis 34:3
carries his denial. Under the Scripture standard it is not, because it carries
it only with his premise that the noun describes Dinah as she then was, and that
is not Scripture. -/
@[headline]
theorem miller_survives_on_genesis :
    millerOnLawsAssessment.findings.struck = [.joelGreekCallsTheWidowParthenos] ∧
      Dissent.Credible .evidence millerOnLawsAssessment.dissent ∧
      Dissent.Credible .tradition millerOnLawsAssessment.dissent ∧
      ¬ Dissent.Credible .scriptural millerOnLawsAssessment.dissent :=
  ⟨rfl, millerOnLawsAssessment.sound (by decide), millerOnLawsAssessment.sound (by decide),
    millerOnLawsAssessment.complete (by decide)⟩

#print axioms miller_survives_on_genesis

/-- **Miller's denial rests on his premise about the noun.** Grant what the Greek
of Genesis 34:3 reads, and every step of his, and the laws' sense still stands:
on the reading Justin gives the elders' Greek, the noun names Dinah, and the
word is used of her in the sense "virgin". Miller's conclusion needs his further
premise, that the noun describes her as she then was. A noun need not: it is
read at a time of its own (Enç 1986), as Scripture names Rahab "the harlot" long
after Jericho (Hebrews 11:31). -/
@[headline]
theorem miller_rests_on_the_noun :
    ¬ Entails
      (caseOf [millerDinahLine.onGrounds [p .greekCallsDinahParthenos]] []
        [contextNotWordInTheLaws])
      (notP .lawsUseParthenosAsVirgin) := by
  refute_with virginConceivesReading [bornOfAVirginDefs, caseOf]

#print axioms miller_rests_on_the_noun

/-- **Miller from Joel 1:8 alone**, with Joel 1:8 struck: nothing left denies the
step. -/
def millerOnJoelAloneAssessment : Assessment Claim where
  dissenter := "Miller, from Joel 1:8 alone"
  against := lawsLine.name
  dissent :=
    { claim := p .lawsUseParthenosAsVirgin
    , grounds := lawsLine.grounds
    , position := millerOnJoelAlone
    , refuted := [joelReadsABride] }
  findings :=
    { consistent := true, denies := false, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])]
    , struck := [.joelGreekCallsTheWidowParthenos] }
  checked := by horn_certify

/-- **Evidence the texts refute stops counting.** Had Miller rested his dissent on
Joel 1:8 alone, then, with the claim the Greek refutes struck, nothing in it
would deny the laws' step, and it would not be a credible critique under any
standard. -/
@[headline]
theorem miller_on_joel_alone_does_not_count :
    ∀ s, ¬ Dissent.Credible s millerOnJoelAloneAssessment.dissent := by
  intro s
  exact millerOnJoelAloneAssessment.complete (by cases s <;> decide)

#print axioms miller_on_joel_alone_does_not_count

/-! ### The laws' step, rated -/

/-- **The laws' step, rated by its register**: Miller's dissent, the strongest
known, with what the texts refute struck. Its support is cited `wellSupported`:
Bratcher, and the lexica on τὰ παρθένια.

Miller's dissent is overruled in the dispute over the Septuagint's word, where
his case from Genesis 34:3 is a party and nothing defends it
(`miller_indefensible`). That dispute weighs the laws' step at its floor: the
case from the laws cites it `disputed` there. So the overruling owes nothing to
the rating it lets stand. -/
def lawsStep : RatedStep Claim where
  step := lawsLine.name
  support := lawsSource .wellSupported
  register := [millerOnLawsAssessment]
  strongest := some 0
  overruled :=
    [ { dissent := 0
      , disputeName := "the dispute over the Septuagint's word"
      , Party := SeptuagintParty
      , dispute := septuagintDispute
      , party := .miller
      , isTheDissent := ⟨_, rfl, miller_struck_is_his_case_from_genesis.symm⟩
      , atTheFloor := by intro j; cases j <;> decide +kernel
      , indefensible := miller_indefensible } ]

/-- **The laws' step stands at `wellSupported` under every standard, and for two
reasons.** Under the evidence and tradition standards Miller's dissent is a
credible critique, and it is overruled: his case from Genesis 34:3 cannot be
defended in the dispute over the Septuagint's word, which weighs the step at its
floor. Under the Scripture standard his dissent is not heard at all, because his
premise about the noun is not Scripture. -/
@[headline]
theorem laws_step_ratings :
    lawsStep.ratings =
      [ (.evidence, .overruled ["Miller, Born Divine"] .wellSupported)
      , (.tradition, .overruled ["Miller, Born Divine"] .wellSupported)
      , (.scriptural, .stands .wellSupported) ] := by
  decide +kernel

#print axioms laws_step_ratings

end TestimonyArguments.BornOfAVirgin
