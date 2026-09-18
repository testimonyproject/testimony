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

/-! ### The implication arrow

Foundation writes implication `🡒` — U+1F852, RIGHTWARDS SANS-SERIF ARROW, in
the Supplemental Arrows-C block. It is the only token Foundation binds, and it
is a poor one to build a corpus on: almost no font covers that block, so it
shows as an empty box in GitHub, in pull-request diffs and in most editors, and
the Lean extension has no abbreviation that produces it, so it cannot be typed
at all without configuration.

`➝` — U+279D, TRIANGLE-HEADED RIGHTWARDS ARROW — is the same notation under a
glyph that renders. It is an *alias*, not a replacement: both parse to
`FFL.HArrow.hArrow`, Foundation's own class, so nothing here diverges from
Foundation but the character on the page. The `binop%` elaborator is carried
over from Foundation's declaration so that coercion behaviour is identical.

Declared `scoped`, so it applies where `Testimony.Logic` is open — every module
of this library — and nowhere else. A reader of Foundation's own sources still
sees Foundation's arrow.

`➝` occurs nowhere in Mathlib, Foundation, Batteries or any other dependency,
so the alias cannot shadow anything. -/
/-- Implication, as Foundation's `🡒` under a glyph that renders. Both parse to
`FFL.HArrow.hArrow`; see the section note above for why this library writes the
alias. -/
scoped infixr:60 " ➝ " => FFL.HArrow.hArrow

macro_rules | `($x ➝ $y) => `(binop% FFL.HArrow.hArrow $x $y)

end Testimony.Logic
