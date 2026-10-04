import Testimony.Meanings

/-!
# Testimony.Checks.Meanings — every argument's claims have meanings

For every argument — every inductive type named `Claim` directly inside a
namespace under `Testimony.Arguments` — a `HasMeanings` instance must exist.
The check runs as part of `lake build`, and finds the arguments itself: one added
tomorrow fails the build until it is registered in `Testimony.Meanings`, if only
with its citations' labels (`HasMeanings.ofLabels`).

It also checks that every argument's joins — the claims whose meanings exclude
or entail one another — are listed and pinned (`HasJoins`), and that its atoms
take their postulates from those lists and nowhere else: the `HasPostulates`
instance it finds must be `HasJoins.toHasPostulates`. A hand-written instance, which could hold any
background at all, fails the build.

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

/-- Check that every argument's claim type has meanings, and postulates taken
from its pinned joins; see the module docstring. -/
elab "#check_meanings" : command => do
  let env ← getEnv
  let mut found : Nat := 0
  let mut missing : Array Name := #[]
  let mut unpinned : Array Name := #[]
  let mut foreign : Array Name := #[]
  for (name, _) in env.constants.toList do
    unless isClaimType env name do continue
    found := found + 1
    let ty := mkApp (mkConst ``Testimony.Semantics.HasMeanings) (mkConst name)
    let inst ← liftTermElabM (try? (synthInstance ty))
    if inst.isNone then missing := missing.push name; continue
    let pty := mkApp (mkConst ``Testimony.Logic.HasPostulates) (mkConst name)
    let post ← liftTermElabM (try? (synthInstance pty))
    match post with
    | none => unpinned := unpinned.push name
    | some e =>
      unless e.getAppFn.constName? == some ``Testimony.Semantics.HasJoins.toHasPostulates do
        foreign := foreign.push name
  unless missing.isEmpty do
    throwError m!"no meanings registered for:\n{MessageData.joinSep
      (missing.toList.map toMessageData) "\n"}\nadd a module to Testimony.Meanings"
  unless unpinned.isEmpty do
    throwError m!"no joins pinned for:\n{MessageData.joinSep
      (unpinned.toList.map toMessageData) "\n"}\nadd a HasJoins instance beside its meanings"
  unless foreign.isEmpty do
    throwError m!"postulates not taken from the pinned joins for:\n{MessageData.joinSep
      (foreign.toList.map toMessageData) "\n"}\nremove the hand-written HasPostulates instance"
  if found == 0 then
    throwError "#check_meanings found no argument to check"
  logInfo m!"every argument has meanings and pinned joins: {found} claim types"

/-- info: every argument has meanings and pinned joins: 6 claim types -/
#guard_msgs in
#check_meanings

end Testimony.Checks
