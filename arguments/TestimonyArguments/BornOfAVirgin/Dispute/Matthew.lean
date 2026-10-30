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
  Horn.defeats_of_defeats? driftObjection_strength matthewCase_strength (by decide +kernel)

/-- **Matthew's reading defeats Wegner.** Its sense "virgin" excludes his "not
yet 'virgin'", and he is no stronger than it. -/
theorem matthew_defeats_drift : Defeats matthewCase driftObjection :=
  Horn.defeats_of_defeats? matthewCase_strength driftObjection_strength (by decide +kernel)

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
inferences are rated. -/
@[bornOfAVirginDefs]
def matthewDispute : Dispute Claim MatthewParty where
  node := matthewPartyNode
  consistent i := Horn.satisfiable_of_satisfiable? (by cases i <;> decide +kernel)
  sound
    | .matthew => matthewCase_establishes
    | .drift => driftObjection_establishes
  rated i := by
    cases i <;> simp [bornOfAVirginDefs, Line.asPackage]

/-- The defeats of the dispute, as a table: each party defeats the other. -/
def matthewPartyDefeats : MatthewParty → MatthewParty → Prop
  | .matthew, .drift => True
  | .drift, .matthew => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel matthewPartyDefeats := fun i j => by
  cases i <;> cases j <;> unfold matthewPartyDefeats <;> infer_instance

/-- Both parties' weakest links rank at the bottom. -/
theorem matthewPartyNode_strength : ∀ i, (matthewPartyNode i).strength = 0
  | .matthew => matthewCase_strength
  | .drift => driftObjection_strength

/-- **Who defeats whom**, all four pairs: Matthew's reading and Wegner defeat
each other, and nothing else. Every cell is computed from what the parties hold
by `Horn.defeats?` and checked by the kernel. -/
theorem matthewDispute_defeats :
    ∀ i j, matthewDispute.defeats i j ↔ matthewPartyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (matthewPartyNode_strength i)
    (matthewPartyNode_strength j) ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute in the form the verdict solver computes with. -/
def matthewFinite : Solver.Finite matthewDispute.defeats where
  parties := [.matthew, .drift]
  complete i := by cases i <;> decide
  defeats i j := decide (matthewPartyDefeats i j)
  spec i j := by rw [matthewDispute_defeats]; simp

/-- Why nothing prevails: each party is defeated by the other. -/
def matthewStandoff : Verdict matthewDispute where
  finite := matthewFinite
  claim := .nothingGrounded [(.matthew, .drift), (.drift, .matthew)]
  checked := by decide +kernel

/-- **As the evidence weighs it, nothing prevails** between Matthew's reading and
Wegner: each defeats the other, and neither outranks the other. -/
@[headline]
theorem nothing_prevails_between_matthew_and_wegner :
    grounded matthewDispute.defeats = ∅ :=
  matthewStandoff.holds

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
  checked := by decide +kernel

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

/-- Each party's weakest link at a standard's ratings: as cited, except that
under the Scripture standard Matthew's step is weighed at `plausible`, its
computed rating there. -/
def matthewRatedStrength : Standard → MatthewParty → ℕ
  | .scriptural, .matthew => 1
  | _, _ => 0

/-- Each party's weakest link, as the re-rated package computes it. -/
theorem matthew_rerated_strength (s : Standard) :
    ∀ i, ((matthewRegister.rerated s).node i).strength = matthewRatedStrength s i := by
  intro i
  cases s <;> cases i <;> decide +kernel

/-- Who defeats whom at a standard's ratings: under the evidence and tradition
standards, as in the full dispute; under the Scripture standard, Matthew's
reading defeats Wegner, and Wegner, now the weaker, does not defeat it. -/
def matthewRatedDefeats : Standard → MatthewParty → MatthewParty → Prop
  | .scriptural, .drift, .matthew => False
  | _, i, j => matthewPartyDefeats i j

/-- The table is finite, so membership in it is decidable. -/
instance (s : Standard) : DecidableRel (matthewRatedDefeats s) := fun i j => by
  cases s <;> cases i <;> cases j <;> unfold matthewRatedDefeats matthewPartyDefeats <;>
    infer_instance

/-- **Who defeats whom at each standard's ratings**, computed from the parties'
premises and the re-rated inferences and checked by the kernel. -/
theorem matthew_rerated_defeats (s : Standard) :
    ∀ i j, (matthewRegister.rerated s).defeats i j ↔ matthewRatedDefeats s i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats?
    (matthew_rerated_strength s i) (matthew_rerated_strength s j) ?_
  cases s <;> cases i <;> cases j <;> decide +kernel

/-- The dispute at a standard's ratings, in the form the verdict solver computes
with. -/
def matthewRatedFinite (s : Standard) : Solver.Finite (matthewRegister.rerated s).defeats where
  parties := matthewFinite.parties
  complete := matthewFinite.complete
  defeats i j := decide (matthewRatedDefeats s i j)
  spec i j := by rw [matthew_rerated_defeats]; simp

/-- The hearing under a standard, in the form the verdict solver computes with. -/
abbrev matthewUnderFinite (s : Standard) :=
  (matthewRatedFinite s).restrict (matthewRegister.admits s)

/-- How the hearing under the evidence standard is settled: Wegner is heard, and
he and Matthew's reading defeat each other. -/
def matthewUnderEvidenceSettled : Verdict (matthewRegister.hearing .evidence) where
  finite := matthewUnderFinite .evidence
  claim := .nothingGrounded (Witness.Table.sub _ [(.matthew, .drift), (.drift, .matthew)])
  checked := by decide +kernel

/-- How the hearing under the Scripture standard is settled: Wegner's dissent
rests on what the standard does not admit against a step grounded in Scripture
alone, so he is not heard, and Matthew's reading stands unattacked. -/
def matthewUnderScriptureSettled : Verdict (matthewRegister.hearing .scriptural) where
  finite := matthewUnderFinite .scriptural
  claim := .groundedExactly [Witness.listSub _ [.matthew]] (Witness.Table.sub _ [])
  checked := by decide +kernel

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
