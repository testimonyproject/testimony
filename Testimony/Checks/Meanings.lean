import Testimony.Checks.Fixture

/-!
# Testimony.Checks.Meanings — every argument's claims have meanings

For every argument under a namespace the check is given — every inductive type
named `Claim` inside it — a `HasMeanings` instance must exist. The check runs as
part of a package's build, and finds the arguments itself: one added tomorrow
fails the build until its meanings are registered, if only with its citations'
labels (`HasMeanings.ofLabels`). The library runs it over its own fixture
(`Testimony.Checks.Fixture`); a package built on the library, over its
arguments.

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

/-- Whether a name is an argument's claim type: an inductive named `Claim` under
the namespace `root`. -/
def isClaimType (env : Environment) (name : Name) (root : Name) : Bool :=
  root.isPrefixOf name && name.getString! == "Claim" &&
    (env.find? name).any fun | .inductInfo _ => true | _ => false

/-- Check that every argument's claim type under `root` has meanings, and
postulates taken from its pinned joins; see the module docstring. -/
def checkMeanings (root : Name) : CommandElabM Unit := do
  let env ← getEnv
  let mut found : Nat := 0
  let mut missing : Array Name := #[]
  let mut unpinned : Array Name := #[]
  let mut foreign : Array Name := #[]
  for (name, _) in env.constants.toList do
    unless isClaimType env name root do continue
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
      (missing.toList.map toMessageData) "\n"}\nregister its meanings \
      beside its claims"
  unless unpinned.isEmpty do
    throwError m!"no joins pinned for:\n{MessageData.joinSep
      (unpinned.toList.map toMessageData) "\n"}\nadd a HasJoins instance beside its meanings"
  unless foreign.isEmpty do
    throwError m!"postulates not taken from the pinned joins for:\n{MessageData.joinSep
      (foreign.toList.map toMessageData) "\n"}\nremove the hand-written HasPostulates instance"
  if found == 0 then
    throwError "#check_meanings found no argument to check"
  logInfo m!"every argument has meanings and pinned joins: {found} claim types"

/-- `#check_meanings under N` checks every argument whose claim type is declared
under the namespace `N`. -/
syntax (name := checkMeaningsCmd) "#check_meanings" " under " ident : command

elab_rules : command
  | `(#check_meanings under $root) => checkMeanings root.getId

/-- info: every argument has meanings and pinned joins: 1 claim types -/
#guard_msgs in
#check_meanings under Testimony.Checks.Fixture

end Testimony.Checks
