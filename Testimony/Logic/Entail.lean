import Testimony.Logic.Basic
import Mathlib.Tactic.Tauto

/-!
# Testimony.Logic.Entail — entailment, and how it is established or refuted

An earlier version of this module decided entailment by truth table, which cost
`2^n` for `n` atoms and forced a twelve-atom budget on every argument. That
ceiling was too low: an argument tracing a theme across the canon wants far
more atoms than that, and the exponent does not care how simple the argument
is.

Two standard tools replace it, and neither enumerates valuations.

**To establish**: Mathlib's `tauto`, a goal-directed classical tableau. Its
cost tracks the argument's structure rather than its atom count, and it
produces an ordinary proof term, so the trust base is unchanged.

**To refute**: exhibit a countermodel. `not_entails_of_countermodel` turns a
valuation satisfying every premise while falsifying the conclusion into a
refutation, and checking a named valuation is linear rather than exponential.

The second is also better documentation. "A countermodel exists" tells a reader
nothing; a named valuation *is* the rival's reading, written down — which is
why countermodels in this library carry the rival's name.

A note on what was rejected: Lean's `bv_decide` calls an external SAT solver
and adds a per-theorem `_native.bv_decide.ax` axiom to the trust base. For a
library whose claim is that every assumption is declared, that is not a
trade worth making, and `axiom-audit` would reject it.
-/

namespace Testimony.Logic

open FFL.Propositional

variable {α : Type}

/-- Semantic entailment: every valuation satisfying all the premises satisfies
the conclusion. -/
def Entails (prems : List (Formula α)) (concl : Formula α) : Prop :=
  ∀ w : Valuation α, (∀ φ ∈ prems, Formula.Boolean.val w φ) →
    Formula.Boolean.val w concl

/-- A countermodel refutes an entailment.

`w` is a valuation on which every premise holds and the conclusion fails, so
the premises cannot entail the conclusion. This is how every `¬ Establishes`
result in the library is proved: not by failing to find a proof, but by naming
the reading on which the argument does not go through. -/
theorem not_entails_of_countermodel {prems : List (Formula α)} {concl : Formula α}
    (w : Valuation α)
    (hsat : ∀ φ ∈ prems, Formula.Boolean.val w φ)
    (hfail : ¬ Formula.Boolean.val w concl) : ¬ Entails prems concl :=
  fun h => hfail (h w hsat)

/-- Entailment is monotone in the premises: adding premises cannot destroy an
entailment. -/
theorem entails_of_subset {prems prems' : List (Formula α)} {concl : Formula α}
    (hsub : ∀ φ ∈ prems, φ ∈ prems') (h : Entails prems concl) : Entails prems' concl :=
  fun w hw => h w fun φ hφ => hw φ (hsub φ hφ)

/-! ### Sanity checks

Small hand-worked cases pinning both directions, so a change to the semantics
or the tactic recipe fails here rather than inside an argument. -/

/-- Two atoms, for the checks below. -/
inductive Pair
  /-- First test atom. -/
  | p
  /-- Second test atom. -/
  | q
deriving DecidableEq, Repr

/-- Modus ponens is valid. -/
theorem modus_ponens_valid :
    Entails (α := Pair) [.atom .p, .imp (.atom .p) (.atom .q)] (.atom .q) := by
  intro w hw
  simp only [List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
    Formula.Boolean.val] at hw ⊢
  tauto

/-- Affirming the consequent is not valid, and here is why: the reading on
which `q` holds and `p` does not. -/
theorem affirming_consequent_invalid :
    ¬ Entails (α := Pair) [.atom .q, .imp (.atom .p) (.atom .q)] (.atom .p) := by
  refine not_entails_of_countermodel (fun a => a = Pair.q) ?_ ?_ <;>
    simp [Formula.Boolean.val]

end Testimony.Logic
