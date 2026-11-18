import Testimony.Checks.Fixture
import Testimony.Checks.Postulates
import Testimony.Checks.Fallacies

/-!
# Testimony.Checks.Readers — every reading and every step has a reader, or says it has none

An argument from Scripture that reads Scripture a particular way, and cites
nothing but Scripture for that reading, is assuming part of what it sets out to
show. The same holds of a step: a step from grounds to a conclusion, rated by
citing only the passages it reads, names no one who draws that inference. A
quotation is different. A claim that a passage says something (`.textual`)
needs no commentator, because citing the passage is all its source can be.

So for every package under the namespace it is given, the check finds every
claim the package rests on that is not a report of what a text says, and every
step the package rates, and fails if any of them is cited to Scripture alone.
Each has two ways out, and both are visible on the page: cite a reader who
holds it, or mark it as the library's own construction (`Reference.proposal`),
with the rationale a proposal must give. What the check refuses is the third
way, a reading or a step that is the library's own and is presented as if the
text alone gave it.

It holds every line of reason under the namespace to the same rule. A line with
no rating of its step (`Line.inference` left `none`) names no one who draws its
inference and does not say it is the library's own either, so the check fails
on it too: cite who draws the step, or mark the step proposed.
-/

namespace Testimony.Checks

open Lean Elab Command Meta

/-- What a package rests on from Scripture alone: the labels of its claims that
read the text with no reader cited (`AtomMeta.readsScriptureAlone`), and the
number of its steps whose rating cites nothing but Scripture. -/
def unreadByAnyone {α : Type} [DecidableEq α] (pkg : Logic.ArgumentPackage α) :
    List String × Nat :=
  (pkg.scriptureOnlyAtoms.map (·.label),
    (pkg.inferences.filter fun s => s.isScriptureOnly).length)

/-- Whether a line of reason carries no rating of its step at all. Such a line
cannot enter a dispute, which refuses a step nobody has rated, but it can stand
in a package on its own, and then nothing on its page says who draws its
inference. -/
def lineUnrated {α : Type} (l : Logic.Line α) : Bool := l.inference.isNone

/-- Check every package under `roots`; see the module docstring. -/
def checkReaders (roots : List Name) : CommandElabM Unit := do
  let env ← getEnv
  let mut checked : Nat := 0
  let mut problems : Array MessageData := #[]
  for (name, info) in env.constants.toList do
    unless roots.any (·.isPrefixOf name) do continue
    let .defnInfo d := info | continue
    let some _ := packageAtoms? d.type | continue
    let found? ← liftTermElabM do
      try
        let e ← mkAppM ``unreadByAnyone #[mkConst name]
        let ty ← inferType e
        some <$> unsafe evalExpr (List String × Nat) ty e
      catch _ => pure none
    match found? with
    | some ([], 0) => checked := checked + 1
    | some (labels, steps) =>
      for l in labels do
        problems := problems.push m!"{name}: \"{l}\" is read from Scripture alone"
      if steps > 0 then
        problems := problems.push m!"{name}: {steps} step(s) rated by Scripture alone"
    | none => problems := problems.push m!"{name}: the check could not be run"
  let mut lines : Nat := 0
  for (name, info) in env.constants.toList do
    unless roots.any (·.isPrefixOf name) do continue
    if name.isInternal then continue
    let .defnInfo d := info | continue
    let some _ := lineClaimType? d.type | continue
    let unrated? ← liftTermElabM do
      try
        let e ← mkAppM ``lineUnrated #[mkConst name]
        some <$> unsafe evalExpr Bool (← inferType e) e
      catch _ => pure none
    match unrated? with
    | some false => lines := lines + 1
    | some true => problems := problems.push m!"{name}: the line's step is rated by no one"
    | none => problems := problems.push m!"{name}: the check could not be run"
  unless problems.isEmpty do
    throwError m!"readings and steps with no reader:\n{
      MessageData.joinSep problems.toList "\n"}\ncite a reader who holds each, or mark it \
      the library's own with `Reference.proposal`"
  if checked == 0 then
    throwError "#check_readers found no package to check"
  for r in roots do recordChecked `readers r
  logInfo m!"every reading and step has a reader or is marked proposed: \
    {checked} packages, {lines} lines"

/-- `#check_readers under N` checks every package declared under the namespace
`N`. -/
syntax (name := checkReadersCmd) "#check_readers" " under " ident : command

elab_rules : command
  | `(#check_readers under $root) => checkReaders [root.getId]

/--
info: every reading and step has a reader or is marked proposed: 2 packages, 4 lines
-/
#guard_msgs in
#check_readers under Testimony.Checks.Fixture

end Testimony.Checks
