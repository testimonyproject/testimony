import Foundation.Propositional.Boolean.Basic

/-!
# Testimony.Logic.Basic — the formula type

Syntax and semantics come from FormalizedFormalLogic/Foundation; this library
does not reimplement them.

Entailment is checked with Mathlib's `tauto`, which is goal-directed, and
refuted by exhibiting a countermodel (see `Testimony.Logic.Entail`). Neither
approach enumerates valuations, so there is no bound on how many atoms an
argument may use.
-/

namespace Testimony.Logic

/-- A propositional formula over cited atoms, from Foundation. -/
abbrev Formula (α : Type) := FFL.Propositional.Formula α

/-- A valuation of atoms, from Foundation. -/
abbrev Valuation (α : Type) := FFL.Propositional.Boolean.Valuation α

/-- The atoms occurring in a formula, with repeats. Used to generate the
assumption manifest. -/
def atomsOf {α : Type} : Formula α → List α
  | .atom a => [a]
  | .falsum => []
  | .and p q => atomsOf p ++ atomsOf q
  | .or p q => atomsOf p ++ atomsOf q
  | .imp p q => atomsOf p ++ atomsOf q

end Testimony.Logic
