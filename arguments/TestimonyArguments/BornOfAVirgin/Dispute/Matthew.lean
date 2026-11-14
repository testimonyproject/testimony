import Testimony.Logic.Declare
import TestimonyArguments.BornOfAVirgin.Dispute.Septuagint
import Testimony.Logic.Credibility

/-!
# TestimonyArguments.BornOfAVirgin.Dispute.Matthew — Scripture's own reading of the Greek word

`Dispute.Septuagint` weighs what the Septuagint's παρθένος meant by what scholars
say of the Greek. This module asks the question a reader of the Bible asks
first: **what does Scripture itself make of the word?** Matthew quotes the
Septuagint's Isaiah 7:14 word for word, ἡ παρθένος, of Mary, who conceived
"before they came together" (1:18) and whom Joseph "knew not until she had borne
a son" (1:25). If Scripture is its own interpreter, the word in the text Matthew
quotes has the sense he gives it: "virgin".

Two positions meet:

- **Matthew's reading** (`matthewLine`): from what Matthew quotes and what he
  says of Mary, both Scripture, to the sense of the Greek word at Isaiah 7:14.
  Its principle is Westminster's: "The infallible rule of interpretation of
  Scripture is the Scripture itself" (I.ix). Irenaeus, on the apostles'
  agreement with the Seventy (*Against Heresies* III.21.3).
- **Wegner on παρθένος**, as in `Dispute.Septuagint`. He grants both of
  Matthew's grounds — by the New Testament the word was "a suitable term to
  describe Mary" — and holds that it had changed in meaning since the translator
  wrote it (483).

## What the claims say

Matthew's reading concludes that the word has the sense "virgin" at one passage
of the Septuagint's text, Isaiah 7:14 as Matthew quotes it. A sense a word has
in a passage of a text is a sense of that text's usage
(`Testimony.Ontology.Usage`), so the claim excludes Wegner's "not yet 'virgin'"
by what it means. It says nothing of the Hebrew עַלְמָה.

## As the evidence weighs it

Matthew's step is cited `disputed`, on Wegner, who grants its grounds and denies
its conclusion. Wegner's step is `disputed` too, on Rico and Gentry and on
Bratcher. So each defeats the other, and **nothing prevails**
(`nothing_prevails_between_matthew_and_wegner`).

## Under each standard

Whether Wegner's dissent counts is not a fact about Wegner. It is a question of
standard, and the library computes under each (`Testimony.Logic.Credibility`).

- **Under the evidence and tradition standards** his dissent is a credible
  critique: consistent, granting the grounds, argued by a step of his own, and
  resting on evidence anyone can check. Matthew's step is `disputed`, and the
  hearing is the standoff above (`matthew_step_turns_on_the_standard`).
- **Under the Scripture standard** a dissent from a step whose grounds are all
  Scripture must rest on Scripture alone, and Wegner's rests also on early Greek
  usage, from the lexica, and on his reading of the noun at Genesis 34:3. So his
  dissent is not heard; Matthew's step stands at
  the confidence its support is cited at, `plausible`; and **Matthew's reading
  prevails** (`matthew_prevails_under_scripture`).

So the verdict turns on the standard, and the page says which. A reader who
holds that Scripture interprets Scripture has here a checked result: on that
standard, a scholar's reading of other Greek does not overturn the sense the
New Testament gives the Septuagint's word. A reader who does not hold it has the
standoff, and `Dispute.Septuagint` for the evidence.

## What this does not show

It does not show what Isaiah's Hebrew word means, nor that the translator meant
"virgin" in his own day: it shows what the word means in the text Matthew
quotes, read by Matthew. Nor does the Scripture standard silence a dissent that
argues from Scripture: another text, read the other way, would be heard.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### Matthew's reading as a position -/

/-- Matthew's reading delivers its conclusion. -/
theorem matthewCase_establishes : Establishes matthewCase := by
  establish [bornOfAVirginDefs]

/-- Matthew's reading has a model: the reading Justin gives the elders' Greek, in
which the word Matthew quotes means "virgin". -/
theorem matthewCase_is_satisfiable : Satisfiable matthewCase.premises := by
  satisfied_by virginConceivesReading [bornOfAVirginDefs]

/-- **Matthew's reading rests on its inference.** Grant that Matthew quotes ἡ
παρθένος, and that he says Mary conceived before she and Joseph came together:
on Wegner's reading the word was by then a suitable term for Mary, and still did
not mean "virgin" in the text the translator wrote. The texts do not decide
which; the step does, and the standards weigh it differently. -/
@[headline]
theorem matthew_rests_on_its_inference :
    ¬ Entails matthewLine.grounds (p .lxxIsaiahUsesParthenosAsVirgin) := by
  refute_with wegnerDriftReading [bornOfAVirginDefs]

#print axioms matthew_rests_on_its_inference

/-- Matthew's grounds are `consensus`, what the texts read, but his step is cited
`disputed`, on Wegner. -/
theorem matthewCase_strength : matthewCase.strength = 0 := by decide

/-- **Wegner defeats Matthew's reading.** That the word had not yet come to mean
"virgin" excludes that the text Matthew quotes uses it in that sense, and
Matthew's reading, cited `disputed`, is no stronger than he. -/
theorem drift_defeats_matthew : Defeats driftObjection matthewCase :=
  Horn.defeats_of_certified driftObjection_strength matthewCase_strength (by horn_certify)

/-- **Matthew's reading defeats Wegner.** Its sense "virgin" excludes his "not
yet 'virgin'", and he is no stronger than it. -/
theorem matthew_defeats_drift : Defeats matthewCase driftObjection :=
  Horn.defeats_of_certified matthewCase_strength driftObjection_strength (by horn_certify)

/-! ### The dispute -/

/-- The parties to the dispute over Scripture's reading of the Greek word. -/
inductive MatthewParty
  /-- Matthew's reading: in the Greek he quotes, παρθένος means "virgin". -/
  | matthew
  /-- Wegner on παρθένος: in the Septuagint's day, the word meant a young
  woman. -/
  | drift
deriving DecidableEq

/-- The package each party argues from. -/
@[bornOfAVirginDefs]
def matthewPartyNode : MatthewParty → ArgumentPackage Claim
  | .matthew => matthewCase
  | .drift => driftObjection

/-- The dispute over Scripture's reading of the Greek word: every party's
premises have a model, every party establishes its conclusion, and every party's
inferences are rated. Both parties' weakest links rank at the bottom. -/
declare_dispute matthewDispute := matthewPartyNode using bornOfAVirginDefs
  /-- **Who defeats whom**, all four pairs: Matthew's reading and Wegner defeat
  each other, and nothing else. Every cell is computed from what the parties hold
  by `Horn.defeats?` and checked by the kernel. -/
  defeats [(.matthew, .drift), (.drift, .matthew)]

/-- Why nothing prevails: each party is defeated by the other. -/
declare_verdict matthewStandoff for matthewDispute :
    .nothingGrounded [(.matthew, .drift), (.drift, .matthew)]
  /-- **As the evidence weighs it, nothing prevails** between Matthew's reading and
  Wegner: each defeats the other, and neither outranks the other. -/
  proves @[headline] nothing_prevails_between_matthew_and_wegner

#print axioms nothing_prevails_between_matthew_and_wegner

/-! ### Wegner's dissent, assessed, and Matthew's step, rated -/

/-- **Wegner, against Matthew's reading**: consistent, granting Matthew's
grounds, and argued, from early Greek usage and Genesis 34:3, by a step of his
own. Under the evidence and tradition standards it is a credible critique. Under
the Scripture standard it is not: Matthew's step rests on Scripture alone, and
two of Wegner's grounds do not. His early Greek usage rests on the lexica; his
premise that the noun of Genesis 34:3 describes Dinah as she then was is his
reading of the verse, not the text. -/
def wegnerOnMatthewAssessment : Assessment Claim where
  dissenter := "Wegner on παρθένος (JETS 54, 482–83)"
  against := matthewLine.name
  dissent :=
    { claim := p .lxxIsaiahUsesParthenosAsVirgin
    , grounds := matthewLine.grounds
    , position := driftObjection }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, [])
        , (.tradition, [])
        , (.scriptural,
            [.earlyGreekParthenosIsYoungWoman, .parthenosDescribesDinahAsSheThenWas]) ] }
  checked := by horn_certify

/-- **Matthew's step, rated by its register**: Wegner's dissent, the strongest
known. Its support is cited `plausible`: Westminster's rule, and Irenaeus on the
apostles' agreement with the Seventy. It is not cited higher, because no reader
the library cites argues the step from Matthew's grounds at length. -/
def matthewStep : RatedStep Claim where
  step := matthewLine.name
  support := matthewReadingSource .plausible
  register := [wegnerOnMatthewAssessment]
  strongest := some 0

/-- **Matthew's step turns on the standard.** Under the evidence and tradition
standards Wegner's dissent is a credible critique, and the step is `disputed`.
Under the Scripture standard it is not heard, and the step's support stands at
`plausible`. -/
@[headline]
theorem matthew_step_ratings :
    matthewStep.ratings =
      [ (.evidence, .disputedBy ["Wegner on παρθένος (JETS 54, 482–83)"])
      , (.tradition, .disputedBy ["Wegner on παρθένος (JETS 54, 482–83)"])
      , (.scriptural, .stands .plausible) ] := by
  decide +kernel

#print axioms matthew_step_ratings

/-! ### The hearing under each standard -/

/-- **The dispute's register**: Wegner entered as a dissent from Matthew's step,
assessed, and the step he is rated against. -/
def matthewRegister : Register matthewDispute where
  assessmentOf
    | .drift => some wegnerOnMatthewAssessment
    | _ => none
  ownPosition i a h := by
    cases i <;> simp only [Option.some.injEq, reduceCtorEq] at h
    subst h; rfl
  steps := [matthewStep]

/-- The dispute at each standard's ratings. Each party's weakest link is as
cited, except that under the Scripture standard Matthew's step is weighed at
`plausible`, its computed rating there. -/
declare_rerated matthewRegister
  /-- **Who defeats whom at each standard's ratings**: under the evidence and
  tradition standards, as in the full dispute; under the Scripture standard,
  Matthew's reading defeats Wegner, and Wegner, now the weaker, does not defeat
  it. Computed from the parties' premises and the re-rated inferences and checked
  by the kernel. -/
  defeats fun
    | .scriptural => matthewDispute.defeatsTable.erase (.drift, .matthew)
    | _ => matthewDispute.defeatsTable

/-- How the hearing under the evidence standard is settled: Wegner is heard, and
he and Matthew's reading defeat each other. -/
declare_verdict matthewUnderEvidenceSettled for (matthewRegister.hearing .evidence)
    using (matthewRegister.under .evidence) :
    .nothingGrounded (Witness.Table.sub _ [(.matthew, .drift), (.drift, .matthew)])

/-- How the hearing under the Scripture standard is settled: Wegner's dissent
rests on what the standard does not admit against a step grounded in Scripture
alone, so he is not heard, and Matthew's reading stands unattacked. -/
declare_verdict matthewUnderScriptureSettled for (matthewRegister.hearing .scriptural)
    using (matthewRegister.under .scriptural) :
    .groundedExactly [Witness.listSub _ [.matthew]] (Witness.Table.sub _ [])

/-- **Matthew's step turns on the standard, and the hearing and the rating
agree.** Under the evidence standard Wegner is heard and nothing prevails. Under
the Scripture standard he is not, and Matthew's reading prevails: in the text
Matthew quotes, παρθένος means "virgin". -/
@[headline]
theorem matthew_step_turns_on_the_standard :
    grounded (matthewRegister.hearing .evidence).defeats = ∅ ∧
      grounded (matthewRegister.hearing .scriptural).defeats =
        Solver.toSet (Witness.listSub _ [MatthewParty.matthew]) :=
  ⟨matthewUnderEvidenceSettled.holds, matthewUnderScriptureSettled.holds⟩

#print axioms matthew_step_turns_on_the_standard

/-- **Under the Scripture standard, Matthew's reading prevails.** -/
@[headline]
theorem matthew_prevails_under_scripture :
    ∃ i ∈ grounded (matthewRegister.hearing .scriptural).defeats, i.1 = .matthew := by
  refine ⟨⟨.matthew, by decide⟩, ?_, rfl⟩
  rw [matthewUnderScriptureSettled.holds]
  simp [Solver.toSet, Witness.listSub]

#print axioms matthew_prevails_under_scripture

end TestimonyArguments.BornOfAVirgin
