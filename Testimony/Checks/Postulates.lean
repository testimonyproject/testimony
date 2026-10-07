import Testimony.Meanings
import Testimony.Arguments.BornInBethlehem
import Testimony.Arguments.BornOfAVirgin
import Testimony.Arguments.CanonicalWitness
import Testimony.Arguments.SolaFide
import Testimony.Arguments.SolaScriptura
import Testimony.Arguments.SpiritBaptism
import Testimony.Articles.Howell2003
import Testimony.Logic.Horn
import Testimony.Checks.Refutations

/-!
# Testimony.Checks.Postulates — no package is emptied by its meanings

A meaning postulate is held beside a package's premises (`Testimony.Logic.Dissent`),
and a premise set with no model entails *everything*. A postulate that
contradicts a package would make every check on it vacuous and still pass.

So for every package in `Testimony.Arguments` and `Testimony.Articles` — every
definition whose type is `ArgumentPackage α` — the check decides that its
premises, with its argument's postulates, have a model. (A package the engine
cannot decide — not Horn, or no candidate model fits — is counted and left to
its own proofs.) It finds the packages itself, so one added tomorrow is checked
tomorrow. A package that fails is a finding about the encoding, to be reported:
either the package holds two claims whose meanings exclude each other, or a
meaning says more than its reader does.
-/

namespace Testimony.Checks

open Lean Elab Command Meta

/-- Whether a package's premises, with its argument's postulates, are
satisfiable, as the Horn engine decides it: `none` if it cannot. -/
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
  let mut undecided : Nat := 0
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
    | some none => undecided := undecided + 1
    | none => problems := problems.push m!"{name}: the check could not be run"
  unless problems.isEmpty do
    throwError m!"packages emptied by their meanings:\n{MessageData.joinSep problems.toList "\n"}"
  if checked == 0 then
    throwError "#check_postulates found no package to check"
  logInfo m!"every package has a model with its postulates: {checked}, and {undecided} undecided"

/-- info: every package has a model with its postulates: 150, and 0 undecided -/
#guard_msgs in
#check_postulates

/-! ## No refutation is undone by its meanings

`establish` and `Establishes` hold a package's premises alone. Entailment only
grows with what is held, so adding the postulates could establish more and
never less: an `Establishes` or `Entails` result stands either way. What could
change is a non-entailment: a `¬ Establishes`, a `¬ Entails` or an `Independent`
result, each proved by a countermodel. If every countermodel broke a postulate,
the premises would entail the claim once they are read for what they mean, and
the library would be asserting the opposite of what its meanings say.

So for every such result in `Testimony.Arguments` and `Testimony.Articles`, the
check decides that the premises, with their argument's postulates, can still
hold while the claim fails. (One the engine cannot decide, because the claim is
not Horn, is counted and left to its own proof.) Every one decided can; so
holding the postulates in `establish` would change no result, and the library
does not. A meaning that undoes one fails the build here, and the result it
undoes names the judgment the meaning would overturn. -/

/-- Whether `φ` can fail while `Γ` and the postulates hold, as the Horn engine
decides it: `none` if it cannot. -/
def survivesPostulates {α : Type} [DecidableEq α] [Logic.HasPostulates α]
    (Γ : List (Logic.Formula α)) (φ : Logic.Formula α) : Option Bool :=
  Logic.Horn.satisfiable? (Γ ++ Logic.HasPostulates.postulates ++ [∼φ])

/-- Whether `∼φ` can fail while `Γ` and the postulates hold: the other half of
an `Independent` result. -/
def survivesPostulatesNeg {α : Type} [DecidableEq α] [Logic.HasPostulates α]
    (Γ : List (Logic.Formula α)) (φ : Logic.Formula α) : Option Bool :=
  survivesPostulates Γ (∼φ)

/-- The non-entailments a theorem states, as premise lists and claims, each with
the helper that decides it: one for `¬ Establishes pkg` or `¬ Entails Γ φ`, two
for `Independent Γ φ`. -/
def nonEntailments (type : Expr) : MetaM (List (Name × Expr × Expr)) := do
  if let some e := refutedEntailment? type then
    let pkg := e.appArg!
    return [(``survivesPostulates, ← mkAppM ``Logic.ArgumentPackage.premises #[pkg],
      ← mkAppM ``Logic.ArgumentPackage.conclusion #[pkg])]
  match type.not? with
  | some e =>
    if e.isAppOfArity ``Testimony.Logic.Entails 3 then
      return [(``survivesPostulates, e.getArg! 1, e.getArg! 2)]
    return []
  | none =>
    if type.isAppOfArity ``Testimony.Logic.Independent 3 then
      let Γ := type.getArg! 1
      let φ := type.getArg! 2
      return [(``survivesPostulates, Γ, φ), (``survivesPostulatesNeg, Γ, φ)]
    return []

/-- Check every non-entailment against its postulates; see the section
docstring. -/
elab "#check_refutations_postulates" : command => do
  let env ← getEnv
  let mut checked : Nat := 0
  let mut undecided : Nat := 0
  let mut problems : Array MessageData := #[]
  for (name, info) in env.constants.toList do
    unless (`Testimony.Arguments).isPrefixOf name || (`Testimony.Articles).isPrefixOf name do
      continue
    let .thmInfo thm := info | continue
    if thm.type.hasLooseBVars || thm.type.isForall && !thm.type.isArrow then continue
    let cases ← liftTermElabM (try nonEntailments thm.type catch _ => pure [])
    for (helper, Γ, φ) in cases do
      -- Over atoms that are no argument's claims — a word, say — there are no
      -- meanings to hold, and nothing to check.
      let argued ← liftTermElabM do
        let ty ← inferType φ
        let inst := mkApp (mkConst ``Logic.HasPostulates) ty.appArg!
        return (← try? (synthInstance inst)).isSome
      unless argued do continue
      let ok? ← liftTermElabM do
        try
          let e ← mkAppM helper #[Γ, φ]
          some <$> unsafe evalExpr (Option Bool) (mkApp (mkConst ``Option [0]) (mkConst ``Bool)) e
        catch _ => pure none
      match ok? with
      | some (some true) => checked := checked + 1
      | some (some false) =>
        problems := problems.push m!"{name}: entailed once its meanings are held"
      | some none => undecided := undecided + 1
      | none => problems := problems.push m!"{name}: the check could not be run"
  unless problems.isEmpty do
    throwError m!"non-entailments undone by their meanings:\n{
      MessageData.joinSep problems.toList "\n"}"
  logInfo m!"every non-entailment survives its postulates: {checked}, and {undecided} undecided"

/-- info: every non-entailment survives its postulates: 67, and 4 undecided -/
#guard_msgs in
#check_refutations_postulates

end Testimony.Checks
