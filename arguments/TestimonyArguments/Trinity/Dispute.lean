import TestimonyArguments.Trinity.Procession
import Testimony.Logic.Dispute
import Testimony.Logic.Horn
import Testimony.Logic.Solver
import Testimony.Logic.Verdict
import Testimony.Logic.Map
import Testimony.Logic.Certificate

/-!
# TestimonyArguments.Trinity.Dispute — the three positions weighed

Three positions are parties to one dispute. LST holds only what it says the
texts establish: the Spirit is related to the Son as well as to the Father. The
West, with Aquinas, Florence and Westminster, holds that he proceeds from the
Father and the Son. The East, with Photius and Ware, holds that he proceeds from
the Father alone. Who defeats whom is computed from their premises and checked
by the kernel.

## How to read the verdicts

- **Defeats.** One position contradicts another (it denies one of the other's
  premises, its conclusion, or a claim it derives on the way) and is not the
  weaker of the two. A defeat that runs both ways is a *standoff*.
- **Weakest link.** A position is only as strong as its least-supported premise
  or step. LST's weakest link is `wellSupported`. Each side rests on readings
  rated `disputed`, the lowest rating, so no rating breaks their standoff.
- **Forced.** Accepted however every standoff is resolved.
- **Can be defended.** Held by some consistent position that answers every
  attack on its members, by itself or through an ally.

## What the weighing found

One standoff, and nothing else. The West and the East defeat each other over
"and the Son", and neither attacks LST, because each grants every text LST
cites and the relation LST draws from them. So what is forced is exactly LST's
position (`the_texts_prevail`). The West can be defended, and so can the East,
and neither is forced (`western_defensible`, `western_not_forced`,
`eastern_defensible`, `eastern_not_forced`).

That is LST's grading of the question, reproduced given these ratings: the relation of the Spirit to
the Son is settled, and "the exact eternal relation of the Spirit to the Son
beyond what Scripture states is not demonstrated". It does not show that the
question is idle, or that the two sides read equally well. It shows only that
the weighing cannot choose, because every reading that divides them is rated
`disputed`. A new, cited argument that one side's reading survives what the
other side says against it could move a rating, and so the verdict. LST's own
rating plays no part: nothing attacks its position, so it would prevail at any
rating.

The standoff rests on reading "proceeds" the same way on both sides. The
Pontifical Council for Promoting Christian Unity (1995) distinguishes the
Greek ἐκπόρευσις, origin from the Father alone, from the Latin *processio*.
On that distinction "and the Son" and "not from the Son" may not contradict each
other, and the two defeats would not exist. The chapter on the procession says
what testing that would take.
-/

namespace TestimonyArguments.Trinity

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### Strength -/

/-- LST's weakest link is `wellSupported`: its step from the texts to the
relation, audited for a reader who grants the texts and denies the relation,
and none found. The texts themselves are `consensus`. -/
theorem lstCase_strength : lstCase.strength = 2 := by decide
/-- The Western position's weakest link is `disputed`: its readings of John 16:14
and of the mission, the claim that only opposed relations distinguish the
persons, and its steps from John 16:14 and from mission. Its step from
distinction is rated `wellSupported`. -/
theorem westernCase_strength : westernCase.strength = 0 := by decide
/-- The Eastern position's weakest link is `disputed`: each of its two readings,
and each of its two steps. -/
theorem easternCase_strength : easternCase.strength = 0 := by decide

/-! ### The dispute -/

/-- The parties to the dispute over the procession of the Spirit. -/
inductive Party
  /-- What the texts establish, and no more: LST. -/
  | lst
  /-- From the Father and the Son: Aquinas, Florence, Westminster. -/
  | western
  /-- From the Father alone: Photius, Ware. -/
  | eastern
deriving DecidableEq

/-- The package each party argues from. -/
@[trinityDefs]
def partyNode : Party → ArgumentPackage Claim
  | .lst => lstCase
  | .western => westernCase
  | .eastern => easternCase

/-- The dispute over the procession: every party can be held without
contradiction, delivers its conclusion, and has its steps rated. -/
@[trinityDefs]
def processionDispute : Dispute Claim Party where
  node := partyNode
  consistent i := Horn.satisfiable_of_certified (by cases i <;> horn_certify)
  sound
    | .lst => lstCase_establishes
    | .western => westernCase_establishes
    | .eastern => easternCase_establishes
  rated i := by
    cases i <;> simp [trinityDefs, Line.asPackage]

/-- **LST stands with the West**: one reading satisfies both, the Western
reading. -/
theorem lst_stands_with_the_west : processionDispute.StandTogether [.lst, .western] := by
  satisfied_by westernReading [Dispute.StandTogether, trinityDefs]

/-- **LST stands with the East** too: the Eastern reading satisfies both. So
LST's position takes no side, which is what it says of itself. -/
theorem lst_stands_with_the_east : processionDispute.StandTogether [.lst, .eastern] := by
  satisfied_by easternReading [Dispute.StandTogether, trinityDefs]

/-- The defeats of the dispute, as a table: the West and the East, each way. -/
def partyDefeats : Party → Party → Prop
  | .western, .eastern => True
  | .eastern, .western => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel partyDefeats := fun i j => by
  cases i <;> cases j <;> unfold partyDefeats <;> infer_instance

/-- Each party's weakest link: `wellSupported` for LST, `disputed` for the two
sides. -/
def partyStrength : Party → ℕ
  | .lst => 2
  | _ => 0

/-- Each party's weakest link, as its package computes it. -/
theorem partyNode_strength : ∀ i, (partyNode i).strength = partyStrength i
  | .lst => lstCase_strength
  | .western => westernCase_strength
  | .eastern => easternCase_strength

prepare_clauses processionDisputeClauses for processionDispute

/-- **Who defeats whom**, all 9 pairs: one standoff, the West and the East over
"and the Son", and nothing else. Neither attacks LST, because each holds every
premise LST holds. Every cell is checked by the kernel. -/
theorem processionDispute_defeats :
    ∀ i j, processionDispute.defeats i j ↔ partyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_prepared (partyNode_strength i) (partyNode_strength j)
    (processionDisputeClauses.spec i) (processionDisputeClauses.spec j) ?_
  cases i <;> cases j <;> horn_certify

/-- The dispute in the form the verdict solver computes with. -/
def processionFinite : Solver.Finite processionDispute.defeats where
  parties := [.lst, .western, .eastern]
  complete i := by cases i <;> decide
  defeats i j := decide (partyDefeats i j)
  spec i j := by rw [processionDispute_defeats]; simp

/-- **Nothing supports anything**, in all 9 pairs: no party's conclusion is a
premise another party states. LST's relation is derived inside the other two
positions, not assumed by them. Every cell is checked by the kernel. -/
theorem processionDispute_supports : ∀ i j, ¬ processionDispute.supports i j := by
  intro i j
  refine (supports_iff_of_certified (P := False) ?_).not.mpr id
  cases i <;> cases j <;> horn_certify

/-- Which party's case is part of which: LST's is part of every party's, since
each holds the texts and the step LST draws from them; otherwise each case is
part of its own only. -/
def partyPartOf : Party → Party → Prop
  | .lst, _ => True
  | .western, .western => True
  | .eastern, .eastern => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel partyPartOf := fun i j => by
  cases i <;> cases j <;> unfold partyPartOf <;> infer_instance

/-- **LST's case is part of both the others'.** Every cell is checked by the
kernel. -/
theorem processionDispute_partOf :
    ∀ i j, processionDispute.partOf i j ↔ partyPartOf i j := by
  intro i j
  refine partOf_iff_of_certified ?_
  cases i <;> cases j <;> horn_certify

/-- The dispute over the procession drawn: who defeats whom, and whose case is
part of whose. -/
def processionMap : ArgumentMap processionDispute where
  finite := processionFinite
  supports _ _ := false
  supports_spec i j := by simp [processionDispute_supports i j]
  partOf i j := decide (partyPartOf i j)
  partOf_spec i j := by rw [processionDispute_partOf]; simp

/-! ### What the dispute decides -/

/-- How far the dispute is settled, in one stage. Nothing defeats LST, so it
comes first, and nothing joins it: the West has the East for a defeater, the
East has the West, and LST answers neither. -/
def textsUnanswered : Verdict processionDispute where
  finite := processionFinite
  claim := .groundedExactly [[.lst]] [(.western, .eastern), (.eastern, .western)]
  checked := by decide +kernel

/-- **What the texts establish prevails, and nothing more.** What the dispute
forces before any choice between rivals is exactly LST's position: the Spirit
is related to the Son as well as to the Father. Nothing defeats it, because
the West and the East both hold every premise it holds.

What this does not claim: that the Filioque is false, or that it is true. The
West and the East are in a standoff, and neither is forced. -/
@[headline]
theorem the_texts_prevail : grounded processionDispute.defeats = {.lst} :=
  Eq.trans textsUnanswered.holds (by ext x; cases x <;> simp [Solver.toSet])

#print axioms the_texts_prevail

/-- Why the West can be defended: with LST, it answers the East itself. -/
def westernWithTheTexts : Verdict processionDispute where
  finite := processionFinite
  claim := .credulous .western [.lst, .western]
  checked := by decide +kernel

/-- **The Western position can be defended**, together with LST's: some maximal
defensible position, one no other party can join without losing that, holds
both. -/
@[headline]
theorem western_defensible : CredulouslyAccepted processionDispute.defeats .western :=
  westernWithTheTexts.holds

#print axioms western_defensible

/-- Why the West is not forced: a defensible position holds the East, and the
East defeats the West. -/
def westernAnsweredByTheEast : Verdict processionDispute where
  finite := processionFinite
  claim := .notSkeptical .western .eastern [.lst, .eastern]
  checked := by decide +kernel

/-- **Nor is it forced.** A maximal defensible position holds LST's position and
the East's, and cannot hold the West's with them. -/
@[headline]
theorem western_not_forced : ¬ SkepticallyAccepted processionDispute.defeats .western :=
  westernAnsweredByTheEast.holds

#print axioms western_not_forced

/-- Why the East can be defended: with LST, it answers the West itself. -/
def easternWithTheTexts : Verdict processionDispute where
  finite := processionFinite
  claim := .credulous .eastern [.lst, .eastern]
  checked := by decide +kernel

/-- **The Eastern position can be defended**, together with LST's. -/
@[headline]
theorem eastern_defensible : CredulouslyAccepted processionDispute.defeats .eastern :=
  easternWithTheTexts.holds

#print axioms eastern_defensible

/-- Why the East is not forced: a defensible position holds the West, and the
West defeats the East. -/
def easternAnsweredByTheWest : Verdict processionDispute where
  finite := processionFinite
  claim := .notSkeptical .eastern .western [.lst, .western]
  checked := by decide +kernel

/-- **Nor is it forced.** A maximal defensible position holds LST's position and
the West's, and cannot hold the East's with them. -/
@[headline]
theorem eastern_not_forced : ¬ SkepticallyAccepted processionDispute.defeats .eastern :=
  easternAnsweredByTheWest.holds

#print axioms eastern_not_forced

end TestimonyArguments.Trinity
