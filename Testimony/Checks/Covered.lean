import Testimony.Checks.Aif
import Testimony.Checks.Citations
import Testimony.Checks.Conditions
import Testimony.Checks.Fallacies
import Testimony.Checks.Meanings
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Readers
import Testimony.Checks.Readings
import Testimony.Checks.Refutations
import Testimony.Checks.VerseParts

/-!
# Testimony.Checks.Covered — every check reaches everything under a package

When a package runs a check once for each of its arguments, an argument added
tomorrow is checked tomorrow only if someone remembers to run the checks under
its namespace too (`Testimony.Checks.Coverage` says why a package would split
its checks so). This module makes forgetting a build failure.

`#check_coverage under N` finds, for each check, everything under `N` that the
check examines: every argument's claim type, for the meanings and the shared
ontology; every claim type with a line of reason, for the fallacies; every
package, for its postulates and for its readers; every non-entailment, for the
postulates again; every refutation, for `establish`; every dispute's defeat table,
for AIF and for the premises its lines leave unstated; every definition, for
the citations; and every declaration that builds a part of a verse, for the
reading of each part against the Greek corpus. It fails if any of them lies
under no namespace that check has been run under, here or in a module imported
here, and names each one. Its report states no count, so adding an argument, a package or
a line to one never changes it.
-/

namespace Testimony.Checks

open Lean Elab Command Meta

/-- Whether a theorem's statement is one `#check_refutations_postulates`
examines: `¬ Establishes pkg`, `¬ Entails Γ φ` or `Independent Γ φ`. -/
def isNonEntailment (type : Expr) : Bool :=
  !(type.hasLooseBVars || type.isForall && !type.isArrow) &&
    ((refutedEntailment? type).isSome ||
      (type.not?.any (·.isAppOfArity ``Testimony.Logic.Entails 3)) ||
      type.isAppOfArity ``Testimony.Logic.Independent 3)

/-- What each check examines under `root`, as the check's name (the one it
records with `recordChecked`) and the names it would examine. -/
def checkTargets (env : Environment) (root : Name) : List (Name × Array Name) := Id.run do
  let mut claims : Array Name := #[]
  let mut lined : Std.HashSet Name := {}
  let mut packages : Array Name := #[]
  let mut nonEntailments : Array Name := #[]
  let mut refutations : Array Name := #[]
  let mut tables : Array Name := #[]
  let mut defs : Array Name := #[]
  let mut parts : Array Name := #[]
  for (name, info) in env.constants.toList do
    if !name.isInternal then
      if let some c := lineClaimType? info.type then
        if isClaimType env c root then lined := lined.insert c
    unless root.isPrefixOf name do continue
    if isClaimType env name root then claims := claims.push name
    if isDisputeTable info.type then tables := tables.push name
    if !versePartMachinery name && buildsVersePart info then parts := parts.push name
    match info with
    | .defnInfo d =>
      unless Testimony.Bib.bibEntryAttr.hasTag env name || bibMachinery name do
        defs := defs.push name
      if (packageAtoms? d.type).isSome then packages := packages.push name
    | .thmInfo t =>
      if isNonEntailment t.type then nonEntailments := nonEntailments.push name
      if (refutedEntailment? t.type).isSome then refutations := refutations.push name
    | _ => pure ()
  return [ (`meanings, claims), (`ontology, claims), (`fallacies, lined.toArray)
         , (`postulates, packages), (`readers, packages), (`readings, packages)
         , (`refutationsPostulates, nonEntailments)
         , (`refutations, refutations), (`aif, tables), (`conditions, tables)
         , (`citations, defs), (`verseParts, parts) ]

/-- Check that every check has been run under a namespace holding each thing it
examines under `root`; see the module docstring. -/
def checkCoverage (root : Name) : CommandElabM Unit := do
  let env ← getEnv
  let mut problems : Array MessageData := #[]
  for (kind, targets) in checkTargets env root do
    let roots := checkedRoots env kind
    let missed := targets.filter fun t => !roots.any (·.isPrefixOf t)
    for t in missed.qsort (·.toString < ·.toString) do
      problems := problems.push m!"{kind}: {t}"
  unless problems.isEmpty do
    throwError m!"not under any namespace the check was run under:\n{
      MessageData.joinSep problems.toList "\n"}\nrun the check under its argument's namespace"
  logInfo m!"every check reaches everything under {root}"

/-- `#check_coverage under N` checks that every check has been run under some
namespace holding each thing it examines under `N`. -/
syntax (name := checkCoverageCmd) "#check_coverage" " under " ident : command

elab_rules : command
  | `(#check_coverage under $root) => checkCoverage root.getId

/-- info: every check reaches everything under Testimony.Checks.Fixture -/
#guard_msgs in
#check_coverage under Testimony.Checks.Fixture

end Testimony.Checks
