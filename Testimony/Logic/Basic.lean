import Foundation.Propositional.Boolean.Basic

/-!
# Testimony.Logic.Basic — the formula type and finite atom enumeration

Syntax and semantics come from FormalizedFormalLogic/Foundation; this library
does not reimplement them. What it adds is a `Bool`-valued evaluator, because
Foundation's Boolean valuations are `Prop`-valued:

```
abbrev Boolean.Valuation (α : Type*) := α → Prop
def val (v : Valuation α) : Formula α → Prop
```

That is the right definition for metatheory and the wrong one for deciding
whether a particular argument is valid. `bval` below is the decidable mirror,
proved to agree with `val` in `Testimony.Logic.Decide`.
-/

namespace Testimony.Logic

open FFL.Propositional

/-- A propositional formula over cited atoms, from Foundation. -/
abbrev Formula (α : Type) := FFL.Propositional.Formula α

/-- A `Prop`-valued valuation, from Foundation. -/
abbrev Valuation (α : Type) := FFL.Propositional.Boolean.Valuation α

/-- An atom type with a finite, enumerated carrier.

Arguments in this library range over finitely many cited claims, which is what
makes validity decidable by truth table. `complete` is the obligation that the
enumeration really is exhaustive; it is discharged by `decide` for the small
enumerations used here. -/
class FiniteAtoms (α : Type) where
  /-- Every atom of the argument. -/
  elems : List α
  /-- The enumeration is exhaustive. -/
  complete : ∀ a : α, a ∈ elems

/-- `Bool`-valued evaluation, the decidable mirror of `Formula.Boolean.val`.

Foundation defines negation as `φ ➝ ⊥` and verum as `⊥ ➝ ⊥`, so five cases
cover the whole language. -/
def bval {α : Type} (v : α → Bool) : Formula α → Bool
  | .atom a => v a
  | .falsum => false
  | .and p q => bval v p && bval v q
  | .or p q => bval v p || bval v q
  | .imp p q => !(bval v p) || bval v q

end Testimony.Logic
