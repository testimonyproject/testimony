import Testimony.Checks.Meanings
import Testimony.Ontology

/-!
# Testimony.Checks.Ontology — where each definition bears, and what it derives

The articles of `Testimony.Ontology` define what the vocabulary's words mean,
and say nothing about any argument. This check asks, of every argument the
library has, what those definitions do there. It finds the arguments itself, as
`Testimony.Checks.Meanings` does, so one added tomorrow is reported tomorrow.

For each argument it reports how many joins its meanings have under the shared
ontology, and how many of them are found with no definition at all, by reading
the meanings alone. Then, for each definition whose words the argument uses: how
many of its claims hold them as doctrine, how many use them of a text or a
voice, where the definitions do not reach, and the joins the definition
contributes — those found with it, and not with it taken out. The report is
pinned, so a definition that starts or stops deriving a join, or a claim that
starts using a defined word, changes it.

It fails the build if any meaning contradicts itself under the shared ontology:
a meaning that cannot be held is a mistake in the meaning, not a join.
-/

namespace Testimony.Checks

open Lean Elab Command Meta Testimony.Semantics

/-- An atom's name, as its argument's source spells it. -/
def atomName {α : Type} [Repr α] (a : α) : String := ((reprStr a).splitOn ".").getLast!

/-- **What the shared ontology does in one argument**: the report's lines for
it, and how many of its meanings contradict themselves. -/
def ontologyReport (α : Type) [HasMeanings α] [DecidableEq α] [Repr α] : String × Nat :=
  let O := Testimony.Ontology.shared
  let joins := (HasMeanings.exclusions (α := α)).length + (HasMeanings.entailments (α := α)).length
  let bare := (HasMeanings.exclusionsUnder (α := α) []).length +
    (HasMeanings.entailmentsUnder (α := α) []).length
  let head := [HasMeanings.argument α, s!"  joins: {joins}, with no definition: {bare}"]
  let lines := O.zipIdx.flatMap fun (d, i) =>
    let rs := d.form.rels
    let held := (HasMeanings.holding (α := α) rs).length
    let framed := (HasMeanings.framing (α := α) rs).length
    if held + framed == 0 then [] else
      let (ex, en) := HasMeanings.contributed (α := α) O i
      let derived := ex.map (fun (a, b) => "    " ++ atomName a ++ " excludes " ++ atomName b) ++
        en.map (fun (a, b) => "    " ++ atomName a ++ " entails " ++ atomName b)
      ("  " ++ d.name ++ ": held by " ++ toString held ++ ", used of a text or voice by " ++
        toString framed ++ (if derived.isEmpty then "; derives nothing" else "; derives:")) ::
        derived
  (String.intercalate "\n" (head ++ lines), (HasMeanings.incoherent (α := α)).length)

/-- Report what the shared ontology does in every argument; see the module
docstring. -/
elab "#check_ontology" : command => do
  let env ← getEnv
  let mut reports : Array String := #[]
  let mut incoherent : Array Name := #[]
  for (name, _) in env.constants.toList do
    unless isClaimType env name do continue
    let r? ← liftTermElabM do
      try
        let e ← mkAppOptM ``ontologyReport #[some (mkConst name), none, none, none]
        some <$> unsafe evalExpr (String × Nat) (toTypeExpr (String × Nat)) e
      catch _ => pure none
    match r? with
    | some (lines, bad) =>
      reports := reports.push lines
      if bad > 0 then incoherent := incoherent.push name
    | none => throwError m!"#check_ontology could not report on {name}"
  unless incoherent.isEmpty do
    throwError m!"meanings that contradict themselves, in:\n{MessageData.joinSep
      (incoherent.toList.map toMessageData) "\n"}"
  if reports.isEmpty then
    throwError "#check_ontology found no argument to report on"
  let sorted := reports.qsort (· < ·)
  logInfo m!"the shared ontology, in every argument:\n{String.intercalate "\n" sorted.toList}"

/--
info: the shared ontology, in every argument:
Born in Bethlehem — Micah 5:2
  joins: 0, with no definition: 0
Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3
  joins: 3, with no definition: 3
Sola fide
  joins: 6, with no definition: 5
  not a ground: held by 4, used of a text or voice by 13; derives nothing
  the only means: held by 3, used of a text or voice by 9; derives:
    justificationByFaithAlone excludes baptismIsInstrumentalCause
  the whole ground: held by 3, used of a text or voice by 6; derives nothing
Sola scriptura
  joins: 3, with no definition: 3
  not a ground: held by 1, used of a text or voice by 0; derives nothing
  the whole ground: held by 1, used of a text or voice by 0; derives nothing
Spirit baptism
  joins: 2, with no definition: 2
The canonical witness
  joins: 7, with no definition: 7
  not a ground: held by 3, used of a text or voice by 0; derives nothing
-/
#guard_msgs in
#check_ontology

end Testimony.Checks
