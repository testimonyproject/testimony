import Testimony.Meanings
import Testimony.Arguments.BornInBethlehem
import Testimony.Arguments.BornOfAVirgin
import Testimony.Arguments.CanonicalWitness
import Testimony.Arguments.SolaFide
import Testimony.Arguments.SolaScriptura
import Testimony.Arguments.SpiritBaptism
import Testimony.Articles.Howell2003
import Testimony.Logic.Horn

/-!
# Testimony.Checks.Postulates — no package is emptied by its meanings

A meaning postulate is held beside a package's premises (`Testimony.Logic.Dissent`),
and a premise set with no model entails *everything*. A postulate that
contradicts a package would make every check on it vacuous and still pass.

So for every package in `Testimony.Arguments` and `Testimony.Articles` — every
definition whose type is `ArgumentPackage α` — the check decides that its
premises, with its argument's postulates, have a model. (A package that is not
Horn, which the engine cannot decide, is counted and left to its own proofs.) It
finds the packages itself, so one added tomorrow is checked tomorrow. A package
that fails is a finding about the encoding, to be reported: either the package
holds two claims whose meanings exclude each other, or a meaning says more than
its reader does.
-/

namespace Testimony.Checks

open Lean Elab Command Meta

/-- Whether a package's premises, with its argument's postulates, are
satisfiable, as the Horn engine decides it: `none` if they are not Horn. -/
def consistentWithPostulates {α : Type} [DecidableEq α] [Logic.HasPostulates α]
    (pkg : Logic.ArgumentPackage α) : Option Bool :=
  Logic.Horn.satisfiable? (pkg.premises ++ Logic.HasPostulates.postulates)

/-- The atom type of a package, if a declaration's type is `ArgumentPackage α`. -/
def packageAtoms? (type : Expr) : Option Expr :=
  if type.isAppOfArity ``Testimony.Logic.ArgumentPackage 1 then some type.appArg! else none

/-- Check every package against its postulates; see the module docstring. -/
elab "#check_postulates" : command => do
  let env ← getEnv
  let mut checked : Nat := 0
  let mut notHorn : Nat := 0
  let mut problems : Array MessageData := #[]
  for (name, info) in env.constants.toList do
    unless (`Testimony.Arguments).isPrefixOf name || (`Testimony.Articles).isPrefixOf name do
      continue
    let .defnInfo d := info | continue
    let some atoms := packageAtoms? d.type | continue
    let ok? ← liftTermElabM do
      try
        let e ← mkAppM ``consistentWithPostulates #[mkConst name]
        some <$> unsafe evalExpr (Option Bool) (mkApp (mkConst ``Option [0]) (mkConst ``Bool)) e
      catch _ => pure none
    match ok? with
    | some (some true) => checked := checked + 1
    | some (some false) =>
      problems := problems.push m!"{name}: no model with the postulates of {atoms}"
    | some none => notHorn := notHorn + 1
    | none => problems := problems.push m!"{name}: the check could not be run"
  unless problems.isEmpty do
    throwError m!"packages emptied by their meanings:\n{MessageData.joinSep problems.toList "\n"}"
  if checked == 0 then
    throwError "#check_postulates found no package to check"
  logInfo m!"every package has a model with its postulates: {checked}, and {notHorn} not Horn"

/-- info: every package has a model with its postulates: 149, and 2 not Horn -/
#guard_msgs in
#check_postulates

end Testimony.Checks
