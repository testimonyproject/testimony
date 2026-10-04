import Testimony.Logic.Basic

/-!
# Testimony.Logic.Postulates — what an argument's checks hold besides

An argument's atom type keeps its claims apart: to the logic, any two atoms are
independent. Their meanings may not be. When one claim's meaning denies
another's, a reader who holds the one must deny the other; when it asserts all
the other does, a reader who holds the one holds the other. The logic should
know both. A **meaning postulate** says so, as a formula over the atoms.

`HasPostulates` gives an atom type its postulates. The logic asks for them and
does not compute them: `Testimony.Semantics` computes them from what the claims
mean (`Testimony.Semantics.HasJoins`), and is the only source of an
instance. `Testimony.Checks.Meanings` fails the build for an argument whose
instance comes from anywhere else.

A credibility check (`Testimony.Logic.Dissent`) holds them for every dissent,
whichever side it is on. No call site names them, so none can forget them.
-/

namespace Testimony.Logic

/-- **An argument's meaning postulates**: what every check over its atoms holds
besides the premises in question. Supplied by `Testimony.Semantics`, from the
argument's meanings. -/
class HasPostulates (α : Type) where
  /-- The postulates, as formulas over the atoms. -/
  postulates : List (Formula α)

end Testimony.Logic
