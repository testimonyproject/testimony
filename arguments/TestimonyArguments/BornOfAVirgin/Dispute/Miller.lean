import TestimonyArguments.BornOfAVirgin.Dispute.Septuagint
import Testimony.Logic.Credibility

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
- **Genesis 34:3**, where the Greek calls Dinah a παρθένος after Shechem has lain
  with her. The Greek reads so. What it shows is contested — the status reading
  takes the word as the law's name for the standing Shechem took
  (`Dispute.Septuagint`) — but that is an argument, not a reading of the text,
  and it strikes nothing.

## What the checks find

The library strikes a claim only when a reading of a text refutes it — Scripture,
rated `consensus` — and then runs every check on what is left
(`Testimony.Logic.Credibility`). Struck of Joel 1:8, Miller's dissent still
denies the laws' step, through Genesis 34:3, and it is still argued, granting
the laws' grounds; so it is still a credible critique under every standard
(`miller_survives_on_genesis`). The laws' step stays `disputed`
(`laws_step_ratings`).

Had Joel 1:8 been all his evidence, the dissent would not count under any
standard: struck of it, nothing in it would deny the step
(`miller_on_joel_alone_does_not_count`). That is the rule at work: evidence the
texts refute stops counting, and a dissent that needed it stops counting with it.

What the rule does not do is weigh the evidence that stands. Genesis 34:3 is one
verse, and the status reading answers it; the rule records only that it is read
as Miller says.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Logic Testimony.Bib Testimony.Scripture

/-! ### Miller's dissent -/

/-- Joel 1:8 shows that the word does not connote virginity, Miller's way: the
young widow is called a παρθένος. -/
@[bornOfAVirginDefs]
def joelShowsNoConnotation : Formula Claim :=
  p .joelGreekCallsTheWidowParthenos ➝ p .parthenosDoesNotItselfConnoteVirginity

/-- Genesis 34:3 shows the same: Dinah is called a παρθένος after Shechem. -/
@[bornOfAVirginDefs]
def dinahShowsNoConnotation : Formula Claim :=
  p .dinahIsAParthenosAfterShechem ➝ p .parthenosDoesNotItselfConnoteVirginity

/-- So in the laws the virginity "has to be inferred from the context", and the
word is not used in the sense "virgin". -/
@[bornOfAVirginDefs]
def contextNotWordInTheLaws : Formula Claim :=
  p .parthenosDoesNotItselfConnoteVirginity ➝ notP .lawsUseParthenosAsVirgin

/-- The citation for Miller's steps. -/
def millerSource : Source :=
  { primary := .work millerBornDivine .whole
  , tradition := .criticalScholarship
  , confidence := .disputed }

/-- **Miller on the laws**, as he argues it: two uses of the word of women who
are not virgins, so the word does not by itself connote virginity, so the laws'
virginity is the context's. -/
@[bornOfAVirginDefs]
def millerOnTheLaws : ArgumentPackage Claim :=
  { name := "Miller: in the laws, the virginity is the context's, not the word's"
  , cite := cite
  , premises :=
      [ p .joelGreekCallsTheWidowParthenos, p .dinahIsAParthenosAfterShechem
      , joelShowsNoConnotation, dinahShowsNoConnotation, contextNotWordInTheLaws ]
  , conclusion := notP .lawsUseParthenosAsVirgin
  , conclusionLabel := "In the Greek Pentateuch's laws, παρθένος is not used in the sense 'virgin'"
  , inferences := [millerSource] }

/-- **Miller's dissent, had Joel 1:8 been all his evidence.** Not his argument as
he makes it, written down to show what striking a refuted claim does. -/
@[bornOfAVirginDefs]
def millerOnJoelAlone : ArgumentPackage Claim :=
  { millerOnTheLaws with
    name := "Miller, from Joel 1:8 alone"
    premises :=
      [ p .joelGreekCallsTheWidowParthenos, joelShowsNoConnotation, contextNotWordInTheLaws ] }

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
denies the step through Genesis 34:3, which the Greek reads as he says. A
credible critique under every standard; under the Scripture standard too,
because what he still asserts outright is the reading of Genesis 34:3. -/
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
    , unadmitted := [(.evidence, []), (.tradition, []), (.scriptural, [])]
    , struck := [.joelGreekCallsTheWidowParthenos] }
  checked := by decide +kernel

/-- **Miller survives on Genesis 34:3.** Struck of Joel 1:8, which the Greek
refutes, his dissent from the laws' step is still a credible critique under
every standard: Genesis 34:3 carries his denial. -/
@[headline]
theorem miller_survives_on_genesis :
    millerOnLawsAssessment.findings.struck = [.joelGreekCallsTheWidowParthenos] ∧
      ∀ s, Dissent.Credible s millerOnLawsAssessment.dissent := by
  refine ⟨rfl, fun s => millerOnLawsAssessment.sound ?_⟩
  cases s <;> decide

#print axioms miller_survives_on_genesis

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
  checked := by decide +kernel

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
Bratcher, and the lexica on τὰ παρθένια. -/
def lawsStep : RatedStep Claim where
  step := lawsLine.name
  support := lawsSource .wellSupported
  register := [millerOnLawsAssessment]
  strongest := some 0

/-- **The laws' step stays `disputed`**, under every standard, on Miller's
dissent from Genesis 34:3: striking the Joel 1:8 example the Greek refutes does
not take away his denial. -/
@[headline]
theorem laws_step_ratings :
    lawsStep.ratings =
      [ (.evidence, .disputedBy ["Miller, Born Divine"])
      , (.tradition, .disputedBy ["Miller, Born Divine"])
      , (.scriptural, .disputedBy ["Miller, Born Divine"]) ] := by
  decide +kernel

#print axioms laws_step_ratings

end TestimonyArguments.BornOfAVirgin
