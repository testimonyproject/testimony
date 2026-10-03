import Testimony.Meanings

/-!
# Testimony.Checks.Meanings — every argument's claims have meanings

For every argument — every inductive type named `Claim` directly inside a
namespace under `Testimony.Arguments` — a `HasMeanings` instance must exist.
The check runs as part of `lake build`, and finds the arguments itself: one added
tomorrow fails the build until it is registered in `Testimony.Meanings`, if only
with its citations' labels (`HasMeanings.ofLabels`).

It checks that meanings exist, not that they are analysed. How much of each
argument is analysed is stated beside its instance, as a theorem
(`coverage_now`), so that a change in coverage is a change a reviewer sees.
-/

namespace Testimony.Checks

open Lean Elab Command Meta

/-- Whether a name is an argument's claim type: `Testimony.Arguments.X.Claim`,
or an inductive named `Claim` deeper in an argument's namespace. -/
def isClaimType (env : Environment) (name : Name) : Bool :=
  (`Testimony.Arguments).isPrefixOf name && name.getString! == "Claim" &&
    (env.find? name).any fun | .inductInfo _ => true | _ => false

/-- Check that every argument's claim type has meanings; see the module
docstring. -/
elab "#check_meanings" : command => do
  let env ← getEnv
  let mut found : Nat := 0
  let mut missing : Array Name := #[]
  for (name, _) in env.constants.toList do
    unless isClaimType env name do continue
    found := found + 1
    let ty := mkApp (mkConst ``Testimony.Semantics.HasMeanings) (mkConst name)
    let inst ← liftTermElabM (try? (synthInstance ty))
    if inst.isNone then missing := missing.push name
  unless missing.isEmpty do
    throwError m!"no meanings registered for:\n{MessageData.joinSep
      (missing.toList.map toMessageData) "\n"}\nadd a module to Testimony.Meanings"
  if found == 0 then
    throwError "#check_meanings found no argument to check"
  logInfo m!"every argument has meanings: {found} claim types"

/-- info: every argument has meanings: 6 claim types -/
#guard_msgs in
#check_meanings

end Testimony.Checks
