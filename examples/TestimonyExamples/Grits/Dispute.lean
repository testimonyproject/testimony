import TestimonyExamples.Grits.Meanings
import TestimonyExamples.Grits.Positions
import Testimony.Logic.Dispute
import Testimony.Logic.Horn
import Testimony.Logic.Solver
import Testimony.Logic.Verdict
import Testimony.Logic.Map

/-!
# TestimonyExamples.Grits.Dispute — the testimony and the cross-examination weighed

The two positions as parties to one dispute, with what their claims mean held
beside their premises: an occurrence lasts one length of time. Who defeats whom
is computed from their premises and their cited ratings, and checked by the
kernel.

## How to read the verdicts

- **Defeats.** One position contradicts another — denies one of its premises,
  its conclusion, or a claim it derives on the way — and is not the weaker of
  the two.
- **Weakest link.** A position is only as strong as its least-supported premise
  or step.
- **Grounded.** Accepted however the dispute is resolved: nothing that defeats
  it is left standing.
- **Cannot be defended.** No consistent position holding it answers every attack
  on it.

## What the solver computed

The testimony and the cross-examination contradict each other, both ways. The
cross-examination denies that breakfast took five minutes, and that five
minutes passed; the testimony denies that breakfast took twenty, and that
twenty passed. But the testimony's weakest link is the five-minute breakfast,
which the record contests — `disputed` — and the cross-examination's is the step
from the grits, rated `wellSupported`. So only the cross-examination's attacks
are defeats. It is grounded (`the_cross_examination_prevails`), and the
testimony cannot be defended (`tiptons_testimony_cannot_be_defended`).

Rated as the step stood when Tipton said he was a fast cook, the
cross-examination's weakest link is `disputed` too, and the dispute is a
standoff: nothing is grounded (`at_the_fast_cook_nothing_was_decided`), and the
testimony could still be defended
(`at_the_fast_cook_tiptons_testimony_could_be_defended`). What decided the
dispute was not the twenty minutes, which counsel had already put to him, but
the witness's withdrawing his denial: "I may have been mistaken."

What the verdicts turn on, then: that the five-minute breakfast is contested,
which no one in the record denies once the cross-examination ends, and that
the step from the grits is rated above the bottom. A reader who rated the
twenty minutes for regular grits `disputed` — who asked, say, whether regular
grits could be a quick-cooking kind — would have the standoff back. No one in
the record asks it, so the case does not encode it.

What none of this claims: that Bill is innocent, that the boys did not shoot
the clerk, or that twenty minutes passed. The court found that five minutes
could not be right, and so does the solver; how long it was, and what follows
for the trial, is not encoded.
-/

namespace TestimonyExamples.Grits

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### What Tipton held cannot stand with the grits -/

/-- **Tipton's five minutes cannot stand with the grits.** What he testified —
the boys went in as he began breakfast, the shot came as it was ready,
breakfast took five minutes, so five minutes passed — cannot be held with what
he granted on cross-examination (eggs and grits; regular grits) and what
counsel put to him (regular grits take twenty minutes; and so the breakfast,
and the time in the store, took twenty), once the claims are read for what they
mean.

What this claims: the contradiction. What it does not: which side is wrong. That
is the dispute's question, and it is answered by the ratings, not here. -/
@[headline]
theorem tiptons_five_minutes_cannot_stand_with_the_grits :
    ¬ Satisfiable (direct.held ++ cross.premises) :=
  Horn.not_satisfiable_of_satisfiable? (by decide +kernel)

#print axioms tiptons_five_minutes_cannot_stand_with_the_grits

/-- **The contradiction is in what "lasts" means.** Taken as claims with nothing
to say what they mean, everything both positions say can be held at once: a
breakfast of five minutes and of twenty, five minutes passed and twenty
(`bothAtOnce`). It is the definition that an occurrence lasts one length of time
(`Testimony.Ontology.Time.oneLength`) that rules this out. -/
@[headline]
theorem apart_from_what_lasts_means_both_could_be_held :
    Satisfiable (direct.premises ++ cross.premises) := by
  satisfied_by bothAtOnce [gritsDefs]

#print axioms apart_from_what_lasts_means_both_could_be_held

/-- **The cross-examination denies the five-minute breakfast.** Read for what
its claims mean, it holds that breakfast took twenty minutes, and so not five:
it undermines Tipton's testimony at the premise the five minutes rests on
(`the_five_minutes_rests_on_the_breakfast`). -/
theorem the_grits_undermine_the_breakfast :
    UnderminesOn cross direct (p .breakfastTookFiveMinutes) := by
  refine ⟨by simp [direct, tiptonsReckoning, Line.asPackage, Line.premises], ?_⟩
  establish [gritsDefs]

/-! ### Strength -/

/-- Tipton's testimony's weakest link is `disputed`: the five-minute
breakfast. -/
theorem direct_strength : direct.strength = 0 := by decide
/-- The cross-examination's weakest link is `wellSupported`: that regular grits
take twenty minutes, and the step from the grits. -/
theorem cross_strength : cross.strength = 2 := by decide
/-- At the fast cook, the cross-examination's weakest link was `disputed`: the
step from the grits, as Tipton then denied it. -/
theorem crossAtTheFastCook_strength : crossAtTheFastCook.strength = 0 := by decide

/-! ### The dispute -/

/-- The parties: the witness's testimony, and the cross-examination. -/
inductive Side
  /-- Tipton, on direct examination. -/
  | direct
  /-- Counsel, on cross-examination. -/
  | cross
deriving DecidableEq

/-- The package each side argues from. -/
@[gritsDefs]
def sideNode : Side → ArgumentPackage Claim
  | .direct => direct
  | .cross => cross

/-- The dispute over the five minutes: each side can be held without
contradiction, read for what its claims mean, delivers its conclusion, and has
its steps rated. -/
@[gritsDefs]
def gritsDispute : Dispute Claim Side where
  node := sideNode
  consistent i := Horn.satisfiable_of_satisfiable? (by cases i <;> decide +kernel)
  sound
    | .direct => direct_establishes
    | .cross => cross_establishes
  rated i := by cases i <;> simp [gritsDefs, Line.asPackage]

/-- The defeats of the dispute, as a table: the cross-examination defeats the
testimony, and nothing else. -/
def sideDefeats : Side → Side → Prop
  | .cross, .direct => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel sideDefeats := fun i j => by
  cases i <;> cases j <;> unfold sideDefeats <;> infer_instance

/-- Each side's weakest link. -/
def sideStrength : Side → ℕ
  | .direct => 0
  | .cross => 2

/-- Each side's weakest link, as its package computes it. -/
theorem sideNode_strength : ∀ i, (sideNode i).strength = sideStrength i
  | .direct => direct_strength
  | .cross => cross_strength

/-- **Who defeats whom**, all four pairs. The cross-examination defeats the
testimony: it denies the five-minute breakfast and the five minutes, and it is
the stronger. The testimony's denials of the twenty minutes are attacks, and
fail: its weakest link is weaker than the cross-examination's. Every cell is
computed by `Horn.defeats?` and checked by the kernel. -/
theorem gritsDispute_defeats : ∀ i j, gritsDispute.defeats i j ↔ sideDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (sideNode_strength i) (sideNode_strength j) ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute in the form the verdict solver computes with. -/
def gritsFinite : Solver.Finite gritsDispute.defeats where
  parties := [.direct, .cross]
  complete i := by cases i <;> decide
  defeats i j := decide (sideDefeats i j)
  spec i j := by rw [gritsDispute_defeats]; simp

/-- **Nothing supports anything**, in all four pairs. Every cell is computed by
`supports?` and checked by the kernel. -/
theorem gritsDispute_supports : ∀ i j, ¬ gritsDispute.supports i j := by
  intro i j
  refine (supports_iff_of_supports? (P := False) ?_).not.mpr id
  cases i <;> cases j <;> decide +kernel

/-- Each side's case is part of its own and of no other's. Every cell is computed
by `partOf?` and checked by the kernel. -/
theorem gritsDispute_partOf : ∀ i j, gritsDispute.partOf i j ↔ i = j := by
  intro i j
  refine partOf_iff_of_partOf? ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute over the five minutes drawn: who defeats whom. -/
def gritsMap : ArgumentMap gritsDispute where
  finite := gritsFinite
  supports _ _ := false
  supports_spec i j := by simp [gritsDispute_supports i j]
  partOf i j := decide (i = j)
  partOf_spec i j := by rw [gritsDispute_partOf]; simp

/-! ### What the dispute decides -/

/-- Why the cross-examination prevails: nothing defeats it, so it is grounded
from the first step, and it defeats the testimony, which nothing defends. -/
def theCrossExaminationGrounded : Verdict gritsDispute where
  finite := gritsFinite
  claim := .groundedExactly [[.cross]] [(.direct, .cross)]
  checked := by decide +kernel

/-- **The cross-examination prevails.** However the dispute is resolved, the
cross-examination is accepted and the testimony is not.

What this claims: given the record as rated — the five-minute breakfast
contested, the step from the grits well supported — the five minutes cannot
stand. What it does not claim: that twenty minutes passed, or anything about
who shot the clerk. -/
@[headline]
theorem the_cross_examination_prevails : grounded gritsDispute.defeats = {.cross} :=
  Eq.trans theCrossExaminationGrounded.holds (by ext x; cases x <;> simp [Solver.toSet])

#print axioms the_cross_examination_prevails

/-- Why the testimony cannot be defended: the cross-examination defeats it, and
nothing answers the cross-examination. -/
def theTestimonyAnswered : Verdict gritsDispute where
  finite := gritsFinite
  claim := .indefensible .direct [(.direct, .cross)]
  checked := by decide +kernel

/-- **Tipton's testimony cannot be defended.** No consistent position holding it
answers the cross-examination. -/
@[headline]
theorem tiptons_testimony_cannot_be_defended (S : Set Side)
    (hS : Admissible gritsDispute.defeats S) : Side.direct ∉ S :=
  theTestimonyAnswered.holds S hS

#print axioms tiptons_testimony_cannot_be_defended

/-! ### The dispute when Tipton said he was a fast cook -/

/-- The parties as they stood when Tipton said he was a fast cook: the same
packages, with the step from the grits rated as it was then. -/
@[gritsDefs]
def atTheFastCookNode : Side → ArgumentPackage Claim
  | .direct => direct
  | .cross => crossAtTheFastCook

/-- The dispute at the fast cook. -/
@[gritsDefs]
def atTheFastCookDispute : Dispute Claim Side where
  node := atTheFastCookNode
  consistent i := Horn.satisfiable_of_satisfiable? (by cases i <;> decide +kernel)
  sound
    | .direct => direct_establishes
    | .cross => crossAtTheFastCook_establishes
  rated i := by cases i <;> simp [gritsDefs, Line.asPackage]

/-- The defeats at the fast cook, as a table: a standoff. -/
def fastCookDefeats : Side → Side → Prop
  | .cross, .direct => True
  | .direct, .cross => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel fastCookDefeats := fun i j => by
  cases i <;> cases j <;> unfold fastCookDefeats <;> infer_instance

/-- Each side's weakest link at the fast cook: `disputed` for both. -/
def fastCookStrength : Side → ℕ := fun _ => 0

/-- Each side's weakest link at the fast cook, as its package computes it. -/
theorem atTheFastCookNode_strength : ∀ i, (atTheFastCookNode i).strength = fastCookStrength i
  | .direct => direct_strength
  | .cross => crossAtTheFastCook_strength

/-- **Who defeated whom at the fast cook**, all four pairs: a standoff. With both
weakest links `disputed`, each side's attacks on the other are defeats. Every
cell is computed by `Horn.defeats?` and checked by the kernel. -/
theorem atTheFastCookDispute_defeats :
    ∀ i j, atTheFastCookDispute.defeats i j ↔ fastCookDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (atTheFastCookNode_strength i)
    (atTheFastCookNode_strength j) ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute at the fast cook, in the form the verdict solver computes with. -/
def atTheFastCookFinite : Solver.Finite atTheFastCookDispute.defeats where
  parties := [.direct, .cross]
  complete i := by cases i <;> decide
  defeats i j := decide (fastCookDefeats i j)
  spec i j := by rw [atTheFastCookDispute_defeats]; simp

/-- Why nothing was decided at the fast cook: each side had a defeater. -/
def atTheFastCookUndecided : Verdict atTheFastCookDispute where
  finite := atTheFastCookFinite
  claim := .nothingGrounded [(.direct, .cross), (.cross, .direct)]
  checked := by decide +kernel

/-- **When Tipton said he was a fast cook, nothing was decided.** He had granted
the grounds of the step from the grits and denied its conclusion, so the step
was `disputed`, and neither side was the stronger.

What this claims: that the twenty minutes alone did not settle it. What settled
it was the witness's withdrawing his denial (`the_cross_examination_prevails`). -/
@[headline]
theorem at_the_fast_cook_nothing_was_decided :
    grounded atTheFastCookDispute.defeats = ∅ :=
  atTheFastCookUndecided.holds

#print axioms at_the_fast_cook_nothing_was_decided

/-- Why the testimony could still be defended at the fast cook: it answered the
cross-examination itself. -/
def atTheFastCookTheTestimonyStood : Verdict atTheFastCookDispute where
  finite := atTheFastCookFinite
  claim := .credulous .direct [.direct]
  checked := by decide +kernel

/-- **At the fast cook, Tipton's testimony could still be defended**: holding it,
he answered the cross-examination's attack with his own. -/
@[headline]
theorem at_the_fast_cook_tiptons_testimony_could_be_defended :
    CredulouslyAccepted atTheFastCookDispute.defeats .direct :=
  atTheFastCookTheTestimonyStood.holds

#print axioms at_the_fast_cook_tiptons_testimony_could_be_defended

end TestimonyExamples.Grits
