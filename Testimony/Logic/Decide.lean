import Testimony.Logic.Basic

/-!
# Testimony.Logic.Decide — decidable entailment, and the bridge to Foundation

`checkEntails` decides validity by truth table over the finite atom
enumeration. `entails_of_check` and `not_entails_of_check` connect that
computation to Foundation's `Prop`-valued semantics, so a `decide` result is a
statement about all valuations, not merely about the enumerated ones.

`not_entails_of_check` is the reason this module exists. Proving that a rival
premise package *fails* to establish its conclusion is what makes packages
comparable, and it identifies which premise an argument actually turns on.

Only `propext`, `Classical.choice` and `Quot.sound` are used — the axiom-audit
allowlist. `native_decide` is prohibited.
-/

namespace Testimony.Logic

open FFL.Propositional

variable {α : Type}

/-- Every Boolean assignment to a list of atoms. -/
def valuations [DecidableEq α] : List α → List (α → Bool)
  | [] => [fun _ => false]
  | a :: as => (valuations as).flatMap fun v =>
      [fun x => if x = a then true else v x, fun x => if x = a then false else v x]

/-- Some enumerated valuation agrees with `b` on every atom of `as`. -/
theorem exists_mem_valuations [DecidableEq α] (b : α → Bool) (as : List α) :
    ∃ v ∈ valuations as, ∀ a ∈ as, v a = b a := by
  induction as with
  | nil => exact ⟨fun _ => false, by simp [valuations], by simp⟩
  | cons a as ih =>
    obtain ⟨v, hv, hagree⟩ := ih
    refine ⟨fun x => if x = a then b a else v x, ?_, ?_⟩
    · simp only [valuations, List.mem_flatMap]
      refine ⟨v, hv, ?_⟩
      cases b a <;> simp
    · intro x hx
      by_cases hxa : x = a
      · simp [hxa]
      · simp only [hxa, if_false]
        exact hagree x (by cases hx with
          | head => exact absurd rfl hxa
          | tail _ h => exact h)

/-- With a complete enumeration, agreement on the enumerated atoms is agreement
everywhere, so the enumerated valuations exhaust `α → Bool`. -/
theorem exists_eq_valuations [DecidableEq α] [FiniteAtoms α] (b : α → Bool) :
    ∃ v ∈ valuations (FiniteAtoms.elems (α := α)), v = b := by
  obtain ⟨v, hv, hagree⟩ := exists_mem_valuations b (FiniteAtoms.elems (α := α))
  exact ⟨v, hv, funext fun a => hagree a (FiniteAtoms.complete a)⟩

/-- `bval` agrees with Foundation's `Prop`-valued `val`. -/
theorem bval_iff_val (v : α → Bool) (φ : Formula α) :
    bval v φ = true ↔ Formula.Boolean.val (fun a => v a = true) φ := by
  induction φ
  all_goals simp [bval, Formula.Boolean.val, Bool.eq_false_iff, *]
  all_goals tauto

/-- Truth-table check: under every enumerated valuation, satisfying every
premise forces the conclusion. -/
def checkEntails [DecidableEq α] [FiniteAtoms α]
    (prems : List (Formula α)) (concl : Formula α) : Bool :=
  (valuations (FiniteAtoms.elems (α := α))).all fun v =>
    !(prems.all fun φ => bval v φ) || bval v concl

/-- Semantic entailment, over Foundation's valuations. -/
def Entails [DecidableEq α] [FiniteAtoms α]
    (prems : List (Formula α)) (concl : Formula α) : Prop :=
  ∀ w : Valuation α, (∀ φ ∈ prems, Formula.Boolean.val w φ) →
    Formula.Boolean.val w concl

/-- A `Prop`-valued valuation, viewed as a Boolean one. Uses classical choice,
which is inside the allowlist. -/
noncomputable def toBool (w : Valuation α) : α → Bool :=
  fun a => @decide (w a) (Classical.propDecidable _)

/-- Viewing a valuation as Boolean and back is the identity. -/
theorem toBool_eq (w : Valuation α) : (fun a => toBool w a = true) = w := by
  funext a
  simp [toBool]

/-- Soundness: a passing truth-table check establishes entailment over *all*
Foundation valuations, not merely the enumerated ones. -/
theorem entails_of_check [DecidableEq α] [FiniteAtoms α]
    {prems : List (Formula α)} {concl : Formula α}
    (h : checkEntails prems concl = true) : Entails prems concl := by
  intro w hw
  obtain ⟨v, hv, hvb⟩ := exists_eq_valuations (toBool w)
  have hall := (List.all_eq_true.mp h) v hv
  rw [hvb] at hall
  have hprems : (prems.all fun φ => bval (toBool w) φ) = true := by
    refine List.all_eq_true.mpr ?_
    intro φ hφ
    exact (bval_iff_val (toBool w) φ).mpr (by rw [toBool_eq]; exact hw φ hφ)
  rw [hprems] at hall
  simp only [Bool.not_true, Bool.false_or] at hall
  have := (bval_iff_val (toBool w) concl).mp hall
  rwa [toBool_eq] at this

/-- Refutation: a failing truth-table check exhibits a countermodel, so the
entailment genuinely does not hold. This is what lets the library show that a
rival premise package does not establish the conclusion. -/
theorem not_entails_of_check [DecidableEq α] [FiniteAtoms α]
    {prems : List (Formula α)} {concl : Formula α}
    (h : checkEntails prems concl = false) : ¬ Entails prems concl := by
  intro hEnt
  rw [checkEntails, List.all_eq_false] at h
  obtain ⟨v, _, hv⟩ := h
  rw [Bool.not_eq_true, Bool.or_eq_false_iff] at hv
  obtain ⟨hnotPrems, hconcl⟩ := hv
  have hprems : (prems.all fun φ => bval v φ) = true := by simpa using hnotPrems
  have hsat : ∀ φ ∈ prems, Formula.Boolean.val (fun a => v a = true) φ := by
    intro φ hφ
    exact (bval_iff_val v φ).mp (List.all_eq_true.mp hprems φ hφ)
  have := hEnt (fun a => v a = true) hsat
  have hb := (bval_iff_val v concl).mpr this
  rw [hconcl] at hb
  exact Bool.noConfusion hb

/-! ### Sanity checks

These pin the checker's behaviour before any argument depends on it. -/

/-- Two atoms, for the sanity checks below. -/
inductive Pair | p | q
deriving DecidableEq, Repr

instance : FiniteAtoms Pair where
  elems := [.p, .q]
  complete a := by cases a <;> simp

-- Modus ponens is valid.
#guard checkEntails (α := Pair) [.atom .p, .imp (.atom .p) (.atom .q)] (.atom .q)

-- Affirming the consequent is not.
#guard !checkEntails (α := Pair) [.atom .q, .imp (.atom .p) (.atom .q)] (.atom .p)

-- A conclusion that is simply unsupported does not follow.
#guard !checkEntails (α := Pair) [.atom .p] (.atom .q)

-- Conjunction elimination is valid.
#guard checkEntails (α := Pair) [.and (.atom .p) (.atom .q)] (.atom .p)

end Testimony.Logic
