import Testimony.Logic.Basic

/-!
# Testimony.Logic.Notation — shorthand for atomic formulas

`p` and `notP` were formerly redeclared at the top of every argument module,
four times over with four identical bodies. They are notation rather than
content: nothing about them depends on which atoms an argument uses, so they
are generic over the atom type and live here.

`notP` exists because Foundation defines negation as `φ ➝ ⊥` rather than as a
primitive constructor. Writing `.imp (.atom c) .falsum` at every use site would
say the same thing less clearly, and a reader of an argument should not have to
decode the encoding of negation to read a rival's premise list.
-/

namespace Testimony.Logic

variable {α : Type}

/-- Shorthand for an atomic formula. -/
abbrev p (c : α) : Formula α := .atom c

/-- Negation of an atom, as Foundation defines negation: `φ ➝ ⊥`. -/
abbrev notP (c : α) : Formula α := .imp (.atom c) .falsum

end Testimony.Logic
