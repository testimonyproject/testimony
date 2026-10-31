import TestimonyArguments.BornOfAVirgin.Dispute.Protoevangelium
import Testimony.Logic.Credibility
import Testimony.Logic.Certificate

/-!
# TestimonyArguments.BornOfAVirgin.Dispute.PromiseHearing — the promise, heard under each standard

`Dispute.Protoevangelium` weighs the fulfilment of Genesis 3:15 against
Westermann's denial that the verse is any promise, and as the evidence weighs it
nothing prevails. This module asks the question that verdict leaves open: **should
Westermann's dissent be heard against a step whose grounds are all Scripture?**

The fulfilment's step rests on five texts, each a claim about what Scripture
says: Genesis 3:15 itself, Galatians 4:4, Revelation 12:9, Hebrews 2:14 with 1
John 3:8, and 1 Corinthians 15:3–4. Westermann grants every one of them, and
denies the step from an argument of his own: "her seed" is "a line of
descendants and not an individual" (259), and the verse is a punishment oracle,
a form that cannot carry promise "even as its secondary meaning" (260). His first
ground is philology; it is not a reading of another text of Scripture.

## Under each standard

The library computes the answer under every standard it knows
(`Testimony.Logic.Credibility`), and reports each.

- **Under the evidence standard** Westermann's dissent is a credible critique:
  consistent, granting the fulfilment's grounds, argued by a step of his own,
  and resting on what anyone can check. The fulfilment's step is `disputed`,
  and the hearing is the dispute as it stands: **nothing prevails**.
- **Under the tradition standard**, the same.
- **Under the Scripture standard** a dissent from a step whose grounds are all
  Scripture must itself rest on Scripture alone, and Westermann's rests on his
  reading of the Hebrew word. So he is not heard; the fulfilment's step stands at
  the confidence its support is cited at, `plausible`; and **the fulfilment
  prevails, with the syntax of the striker and the scene read whole**
  (`promise_turns_on_the_standard`).

## What the hearing does not do

A dissent not heard under a standard is not heard at all: the hearing sets the
party aside, not one attack of his. So under the Scripture standard Westermann's
denial that an evil power stands behind the serpent, a ground of the scene's,
is not weighed either, and that ground stays rated `disputed` in its citation.
And the Scripture standard silences no dissent that argues from Scripture:
another text, read the other way, would be heard.

Nor does the verdict say what Genesis 3:15 meant to its first readers. The
readers before Christ do not read it as a promise of one victor
(`Dispute.Protoevangelium`). It says what the verse is, read with the rest of
Scripture, for a reader who holds that Scripture interprets Scripture.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### Westermann's dissent, assessed, and the fulfilment's step, rated -/

/-- **Westermann, against the fulfilment**: consistent, granting its five texts,
and argued, from the collective "seed" and the form of the verse, by a step of
his own. Under the evidence and tradition standards it is a credible critique.
Under the Scripture standard it is not: the fulfilment's grounds are all
Scripture, and Westermann's "a line of descendants and not an individual" rests
on his philology, not on Scripture. -/
def westermannOnFulfilmentAssessment : Assessment Claim where
  dissenter := "Westermann, Genesis 1–11 (259–61)"
  against := fulfilmentLine.name
  dissent :=
    { claim := p .jesusFulfilsThePromise
    , grounds := fulfilmentLine.grounds
    , position := westermannCase }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, [])
        , (.tradition, [])
        , (.scriptural, [.seedIsLineNotIndividual]) ] }
  checked := by decide +kernel

/-- **The fulfilment's step, rated by its register**: Westermann's dissent, the
strongest known. Its support is cited `plausible`: Irenaeus, Keil, Leupold,
Calvin and Hamilton argue it, and it is rated no higher because the readers
before Christ do not read the verse so. -/
def fulfilmentStep : RatedStep Claim where
  step := fulfilmentLine.name
  support := fulfilmentSource .plausible
  register := [westermannOnFulfilmentAssessment]
  strongest := some 0

/-- **The fulfilment's step turns on the standard.** Under the evidence and
tradition standards Westermann's dissent is a credible critique, and the step is
`disputed`. Under the Scripture standard it is not heard, and the step's support
stands at `plausible`. -/
@[headline]
theorem fulfilment_step_ratings :
    fulfilmentStep.ratings =
      [ (.evidence, .disputedBy ["Westermann, Genesis 1–11 (259–61)"])
      , (.tradition, .disputedBy ["Westermann, Genesis 1–11 (259–61)"])
      , (.scriptural, .stands .plausible) ] := by
  decide +kernel

#print axioms fulfilment_step_ratings

/-! ### The hearing under each standard -/

/-- **The dispute's register**: Westermann entered as a dissent from the
fulfilment's step, assessed, and the step he is rated against. The syntax and the
scene are not dissents from a rated step. -/
def promiseRegister : Register promiseDispute where
  assessmentOf
    | .westermann => some westermannOnFulfilmentAssessment
    | _ => none
  ownPosition i a h := by
    cases i <;> simp only [Option.some.injEq, reduceCtorEq] at h
    subst h; rfl
  steps := [fulfilmentStep]

/-- Each party's weakest link at a standard's ratings: as cited, except that
under the Scripture standard the fulfilment's step is weighed at `plausible`,
its computed rating there. -/
def promiseRatedStrength : Standard → PromiseParty → ℕ
  | .scriptural, .fulfilment => 1
  | _, _ => 0

/-- Each party's weakest link, as the re-rated package computes it. -/
theorem promise_rerated_strength (s : Standard) :
    ∀ i, ((promiseRegister.rerated s).node i).strength = promiseRatedStrength s i := by
  intro i
  cases s <;> cases i <;> decide +kernel

/-- Who defeats whom at a standard's ratings: under the evidence and tradition
standards, as in the full dispute; under the Scripture standard, Westermann,
now the weaker, no longer defeats the fulfilment. -/
def promiseRatedDefeats : Standard → PromiseParty → PromiseParty → Prop
  | .scriptural, .westermann, .fulfilment => False
  | _, i, j => promisePartyDefeats i j

/-- The table is finite, so membership in it is decidable. -/
instance (s : Standard) : DecidableRel (promiseRatedDefeats s) := fun i j => by
  cases s <;> cases i <;> cases j <;> unfold promiseRatedDefeats promisePartyDefeats <;>
    infer_instance

/-- **Who defeats whom at each standard's ratings**, computed from the parties'
premises and the re-rated inferences and checked by the kernel. -/
theorem promise_rerated_defeats (s : Standard) :
    ∀ i j, (promiseRegister.rerated s).defeats i j ↔ promiseRatedDefeats s i j := by
  intro i j
  refine Horn.defeats_iff_of_certified
    (promise_rerated_strength s i) (promise_rerated_strength s j) ?_
  cases s <;> cases i <;> cases j <;> horn_certify

/-- The dispute at a standard's ratings, in the form the verdict solver computes
with. -/
def promiseRatedFinite (s : Standard) :
    Solver.Finite (promiseRegister.rerated s).defeats where
  parties := promiseFinite.parties
  complete := promiseFinite.complete
  defeats i j := decide (promiseRatedDefeats s i j)
  spec i j := by rw [promise_rerated_defeats]; simp

/-- The hearing under a standard, in the form the verdict solver computes with. -/
abbrev promiseUnderFinite (s : Standard) :=
  (promiseRatedFinite s).restrict (promiseRegister.admits s)

/-- How the hearing under the evidence standard is settled: Westermann is heard,
and he and each of the others defeat one another. -/
def promiseUnderEvidenceSettled : Verdict (promiseRegister.hearing .evidence) where
  finite := promiseUnderFinite .evidence
  claim := .nothingGrounded
    (Witness.Table.sub _
      [ (.fulfilment, .westermann), (.westermann, .fulfilment), (.syntax, .westermann)
      , (.scene, .westermann) ])
  checked := by decide +kernel

/-- How the hearing under the Scripture standard is settled: Westermann's dissent
rests on what the standard does not admit against a step grounded in Scripture
alone, so he is not heard, and the fulfilment, the syntax and the scene stand
unattacked. -/
def promiseUnderScriptureSettled : Verdict (promiseRegister.hearing .scriptural) where
  finite := promiseUnderFinite .scriptural
  claim := .groundedExactly
    [Witness.listSub _ [.fulfilment, .syntax, .scene]] (Witness.Table.sub _ [])
  checked := by decide +kernel

/-- **The promise turns on the standard, and the hearing and the rating agree.**
Under the evidence standard Westermann is heard, and nothing prevails. Under the
Scripture standard he is not, and the fulfilment prevails, with the syntax of
the striker and the scene read whole: Genesis 3:15 is the protoevangelium,
fulfilled in Jesus. -/
@[headline]
theorem promise_turns_on_the_standard :
    grounded (promiseRegister.hearing .evidence).defeats = ∅ ∧
      grounded (promiseRegister.hearing .scriptural).defeats =
        Solver.toSet
          (Witness.listSub _ [PromiseParty.fulfilment, .syntax, .scene]) :=
  ⟨promiseUnderEvidenceSettled.holds, promiseUnderScriptureSettled.holds⟩

#print axioms promise_turns_on_the_standard

end TestimonyArguments.BornOfAVirgin
