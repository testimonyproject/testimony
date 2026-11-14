import Testimony.Bib.Attr
import Testimony.Bib.Registry
import Testimony.Checks.Fixture

/-!
# Testimony.Checks.Citations — a citation key names one entry

Two citations of the same work at the same place are the same citation. The
library tests that by key and locus (`Testimony.Source.sameCitation`), not by
comparing two bibliography entries field by field: the kernel compares strings
one character at a time, and an entry is mostly strings, so a full comparison of
two equal entries cost a hearing 350 ms a citation.

A key stands in for its entry only if no two different entries share a key.
Nothing in the types prevents two: an entry is a value, and two values written
with one key and different titles would both compile. So this check makes it
true of the code as written, under the namespace it is given:

- **Every entry is built in a `@[bib_entry]` definition.** Any other definition
  that applies one of `BibEntry`'s constructors fails the check. So every entry
  a citation can hold is one of the tagged definitions.
- **No two tagged definitions share a key**, wherever they are declared: the
  check reads every tagged definition in the environment, not one module's
  registry.

Together they make a key name exactly one entry, which is what
`Testimony.Bib.BibEntry.eq_of_key_eq` needs of a list of entries to prove that
equal keys are equal entries. The check finds the definitions itself, so an
entry written tomorrow, anywhere, is checked tomorrow.
-/

namespace Testimony.Checks

open Lean Elab Command Meta Testimony.Bib

/-- Whether a declaration belongs to the machinery of `BibEntry` itself — its
recursors, its functions, and the instances it derives — whose terms name the
constructors without building an entry anyone cites. -/
def bibMachinery (name : Name) : Bool :=
  name.isInternalDetail ||
    [``BibEntry, ``Testimony.Bib.instDecidableEqBibEntry, ``Testimony.Bib.instReprBibEntry].any
      (·.isPrefixOf name)

/-- Check every definition under `roots` for entries built outside a
`@[bib_entry]` definition, and every tagged definition for a key it shares; see
the module docstring. -/
def checkCitations (roots : List Name) : CommandElabM Unit := do
  let env ← getEnv
  let some (.inductInfo bib) := env.find? ``BibEntry
    | throwError "#check_citations: `BibEntry` is not an inductive type"
  let ctors := bib.ctors
  let mut scanned : Nat := 0
  let mut problems : Array MessageData := #[]
  for (name, info) in env.constants.toList do
    unless roots.any (·.isPrefixOf name) do continue
    let .defnInfo d := info | continue
    if bibEntryAttr.hasTag env name || bibMachinery name then continue
    scanned := scanned + 1
    if let some c := d.value.find? fun e => e.isConst && ctors.contains e.constName! then
      problems := problems.push
        m!"{name} builds an entry with {c}: write it as a `@[bib_entry]` definition"
  let mut keys : Std.HashMap String Name := {}
  let mut tagged : Nat := 0
  for (name, _) in env.constants.toList do
    unless bibEntryAttr.hasTag env name do continue
    tagged := tagged + 1
    let key ← liftTermElabM do
      unsafe evalExpr String (mkConst ``String) (mkApp (mkConst ``BibEntry.key) (mkConst name))
    if let some other := keys[key]? then
      problems := problems.push m!"{name} and {other} share the key \"{key}\""
    else
      keys := keys.insert key name
  unless problems.isEmpty do
    throwError m!"citations that a key does not name:\n{MessageData.joinSep problems.toList "\n"}"
  if scanned == 0 then
    throwError "#check_citations found no definition to check"
  logInfo m!"every entry is a tagged definition, and every key names one: \
    {scanned} definitions, {tagged} entries"

/-- `#check_citations under N` checks every definition declared under the
namespace `N`, and every `@[bib_entry]` definition anywhere. -/
syntax (name := checkCitationsCmd) "#check_citations" " under " ident : command

elab_rules : command
  | `(#check_citations under $root) => checkCitations [root.getId]

/-- info: every entry is a tagged definition, and every key names one: 50 definitions, 15 entries -/
#guard_msgs in
#check_citations under Testimony.Checks.Fixture

end Testimony.Checks
