import Testimony.Logic.Support
import Testimony.Logic.Page
import Mathlib.Data.List.Sublists

/-!
# Testimony.Logic.Burden — what an opponent must reject

A case built from several lines of reason is stronger than a case built from
one, and the library has to say *why* without counting. Three citations of the
same premise are one premise, and ten allies behind one line do not make it
stronger. What independent lines change is what an opponent has to give up:
with three routes to a conclusion, denying it means breaking all three.

So instead of a count, the library reports the **opponent's burden**: the
minimal sets of readings whose rejection overturns the case. A reading here is
a line's step — what carries its grounds to what it delivers. Rejecting it
keeps the grounds: the texts stay granted, and only the reading of them goes.
The shared premises and the closing steps are granted too.

An `OpponentsBurden P lines shared closing sets` claims, with a proof of each:

- **The case holds.** `P`'s premises are exactly `caseOf lines shared closing`,
  they have a model, and they establish `P`'s conclusion.
- **Each set overturns it.** Reject every reading in the set, and the
  conclusion no longer follows.
- **Each set is minimal.** Keep any one reading of the set, and the conclusion
  follows again.
- **There is no other way.** Every set of rejected readings that overturns the
  case contains one of the listed sets.

The last claim is what makes the burden a burden: it quantifies over every
choice an opponent could make, so an argument cannot inflate its standing by
listing only the sets that are hard to reject. A reading in no set is one an
opponent never needs to reject; a set of one is a single point of failure.

## How it is proved

The engine (`Testimony.Logic.Horn`) decides every entailment, and
`OpponentsBurden.of_check` turns its answers into the claims above, checked by
`decide +kernel`. Completeness is checked over every subset of the readings,
so the cost is exponential in the number of *lines* — a handful per argument —
and not in the number of atoms, which is unbounded.
-/

namespace Testimony.Logic

open Horn

variable {α : Type}

/-- The steps of `lines`, numbered from `i`, except those numbered in `drop`. -/
def keptSteps : List (Line α) → ℕ → List ℕ → List (Formula α)
  | [], _, _ => []
  | l :: ls, i, drop => (if drop.contains i then [] else [l.step]) ++ keptSteps ls (i + 1) drop

/-- The case with the readings numbered in `drop` rejected: every line's
grounds, the shared premises, the steps of the lines kept, and the closing
steps. The same layout as `caseOf`, so rejecting nothing gives the case back
(`caseRejecting_nil`). -/
def caseRejecting (lines : List (Line α)) (shared closing : List (Formula α))
    (drop : List ℕ) : List (Formula α) :=
  lines.flatMap Line.grounds ++ shared ++ keptSteps lines 0 drop ++ closing

theorem keptSteps_nil (ls : List (Line α)) (i : ℕ) : keptSteps ls i [] = ls.map Line.step := by
  induction ls generalizing i with
  | nil => rfl
  | cons l ls ih => simp [keptSteps, ih]

theorem caseRejecting_nil (lines : List (Line α)) (shared closing : List (Formula α)) :
    caseRejecting lines shared closing [] = caseOf lines shared closing := by
  simp [caseRejecting, caseOf, keptSteps_nil]

/-- Which steps are kept depends only on which of the lines' own numbers are
rejected. -/
theorem keptSteps_congr (ls : List (Line α)) (i : ℕ) (T T' : List ℕ)
    (h : ∀ j, i ≤ j → j < i + ls.length → (j ∈ T ↔ j ∈ T')) :
    keptSteps ls i T = keptSteps ls i T' := by
  induction ls generalizing i with
  | nil => rfl
  | cons l ls ih =>
    have hi : i ∈ T ↔ i ∈ T' := h i le_rfl (by simp)
    have hrest := ih (i + 1) fun j h1 h2 => h j (by omega) (by simp at h2 ⊢; omega)
    simp only [keptSteps, hrest, List.contains_iff_mem, hi]

/-- **The opponent's burden.** See the module docstring for what each field
claims. Indices number `lines` from zero. -/
structure OpponentsBurden (P : ArgumentPackage α) (lines : List (Line α))
    (shared closing : List (Formula α)) (sets : List (List ℕ)) : Prop where
  /-- `P` is the case these lines make. -/
  premises_eq : P.premises = caseOf lines shared closing
  /-- `P`'s premises can all be true. -/
  consistent : Satisfiable P.premises
  /-- `P` delivers its conclusion. -/
  holds : Establishes P
  /-- Rejecting the readings of any listed set overturns the case. -/
  overturns : ∀ S ∈ sets, ¬ Entails (caseRejecting lines shared closing S) P.conclusion
  /-- Keeping any one reading of a listed set restores it. -/
  minimal : ∀ S ∈ sets, ∀ i ∈ S,
    Entails (caseRejecting lines shared closing (S.erase i)) P.conclusion
  /-- Every way of overturning the case rejects one of the listed sets. -/
  complete : ∀ T : List ℕ, ¬ Entails (caseRejecting lines shared closing T) P.conclusion →
    ∃ S ∈ sets, ∀ i ∈ S, i ∈ T

namespace OpponentsBurden

variable {P : ArgumentPackage α} {lines : List (Line α)} {shared closing : List (Formula α)}
  {sets : List (List ℕ)}

/-- **The case survives any rejection that leaves every set incomplete.** If
an opponent keeps at least one reading of every listed set, the conclusion
still follows. -/
theorem stands_without (b : OpponentsBurden P lines shared closing sets) (T : List ℕ)
    (h : ∀ S ∈ sets, ∃ i ∈ S, i ∉ T) :
    Entails (caseRejecting lines shared closing T) P.conclusion := by
  by_contra hn
  obtain ⟨S, hS, hsub⟩ := b.complete T hn
  obtain ⟨i, hi, hni⟩ := h S hS
  exact hni (hsub i hi)

/-- **No reading is load-bearing alone** when every listed set has two
distinct readings: reject any one, and the conclusion still follows. -/
theorem stands_without_one (b : OpponentsBurden P lines shared closing sets)
    (h : ∀ S ∈ sets, ∃ j ∈ S, ∃ k ∈ S, j ≠ k) (i : ℕ) :
    Entails (caseRejecting lines shared closing [i]) P.conclusion :=
  b.stands_without [i] fun S hS => by
    obtain ⟨j, hj, k, hk, hne⟩ := h S hS
    by_cases hji : j = i
    · exact ⟨k, hk, by simp; omega⟩
    · exact ⟨j, hj, by simpa using hji⟩

/-- What a page renders: the burden's data, without its proofs. -/
def view (_ : OpponentsBurden P lines shared closing sets) : Page.Burden :=
  { holder := P.name, conclusion := P.conclusionLabel
  , readings := lines.map fun l => (l.name, l.inference), sets }

end OpponentsBurden

/-! ### Building one from checks -/

section Checks

variable [DecidableEq α]

/-- Everything about a burden the engine decides, as one Boolean: that the
case has a model and holds, that each set overturns it and is minimal, and —
over every subset of the readings — that nothing else overturns it. -/
def burdenCheck (lines : List (Line α)) (shared closing : List (Formula α))
    (conclusion : Formula α) (sets : List (List ℕ)) : Bool :=
  let stands (T : List ℕ) := entailsCheck (caseRejecting lines shared closing T) conclusion
  satisfiable? (caseOf lines shared closing) == some true &&
  stands [] == some false &&
  sets.all (fun S => stands S == some true && S.all fun i => stands (S.erase i) == some false) &&
  (List.range lines.length).sublists.all fun T =>
    stands T == some false || sets.any fun S => S.all (T.contains ·)

/-- **Build a burden** from the engine's check and the one fact it cannot
decide: that `P`'s premises are the case the lines make. -/
theorem OpponentsBurden.of_check {P : ArgumentPackage α} {lines : List (Line α)}
    {shared closing : List (Formula α)} {sets : List (List ℕ)}
    (premises_eq : P.premises = caseOf lines shared closing)
    (h : burdenCheck lines shared closing P.conclusion sets = true) :
    OpponentsBurden P lines shared closing sets := by
  simp only [burdenCheck, Bool.and_eq_true, beq_iff_eq, List.all_eq_true,
    Bool.or_eq_true, List.any_eq_true] at h
  obtain ⟨⟨⟨hsat, hholds⟩, hsets⟩, hall⟩ := h
  have hcase := caseRejecting_nil lines shared closing
  refine { premises_eq, consistent := ?_, holds := ?_, overturns := ?_, minimal := ?_,
           complete := ?_ }
  · rw [premises_eq]; exact satisfiable_of_satisfiable? hsat
  · show Entails P.premises P.conclusion
    rw [premises_eq, ← hcase]; exact entails_of_entailsCheck hholds
  · exact fun S hS => not_entails_of_entailsCheck (hsets S hS).1
  · exact fun S hS i hi => entails_of_entailsCheck ((hsets S hS).2 i hi)
  · intro T hT
    -- Only the lines' own numbers matter: restrict `T` to them.
    let T' := (List.range lines.length).filter (· ∈ T)
    have hmem : ∀ j, j ∈ T' ↔ j < lines.length ∧ j ∈ T := by simp [T']
    have heq : caseRejecting lines shared closing T = caseRejecting lines shared closing T' := by
      simp only [caseRejecting]
      rw [keptSteps_congr lines 0 T T' fun j _ hj => by
        rw [hmem]; exact ⟨fun h => ⟨by omega, h⟩, fun h => h.2⟩]
    have hsub : T' ∈ (List.range lines.length).sublists :=
      List.mem_sublists.mpr List.filter_sublist
    rcases hall T' hsub with hst | ⟨S, hS, hS'⟩
    · exact absurd (heq ▸ entails_of_entailsCheck hst) hT
    · exact ⟨S, hS, fun i hi => ((hmem i).mp (by simpa using hS' i hi)).2⟩

end Checks

end Testimony.Logic
