import Testimony.Logic.Basic

/-!
# Testimony.Logic.Notation — shorthand for atomic formulas

`p` and `notP` were formerly redeclared at the top of every argument module,
four times over with four identical bodies. They are notation rather than
content: nothing about them depends on which atoms an argument uses, so they
are generic over the atom type and live here.

`notP` exists because a reader of an argument should not have to decode the
encoding of negation to read a rival's premise list. It is Foundation's `∼`
applied to an atom, and Foundation's `∼` on `Formula α` is itself an
abbreviation for `φ 🡒 ⊥` — the `NegAbbrev (Formula α)` instance says so. The
library used to write that implication out by hand; naming Foundation's
connective instead is what puts every formula in reach of Foundation's own
`@[simp]` truth lemmas, which is where the proof recipes get their semantics
from.
-/

namespace Testimony.Logic

open FFL

variable {α : Type}

/-- Shorthand for an atomic formula. -/
abbrev p (c : α) : Formula α := .atom c

/-- Negation of an atom, as Foundation writes negation. -/
abbrev notP (c : α) : Formula α := ∼(.atom c)

end Testimony.Logic
