import Testimony.Checks.Aif
import Testimony.Checks.Fallacies

/-!
# Testimony.Checks.Conditions — no hidden premise enters a dispute

The fallacy checks find, in a line of reason, a premise it needs and has not
written: that a word keeps one sense between the places it joins, or that one
word bears the sense of a kindred one, a verb of its adjective or the Greek of
the Latin (`Testimony.Checks.fallacyReport`). Such a line is valid as written
and only as strong as what it leaves unstated. Reported beside a dispute, that
condition is never weighed: the solver computes who prevails from the premises a
position states, so a position that leaves its weakest premise unstated is
heard as if it had none.

So a line that enters a dispute must state what it needs. This check finds every
dispute under a namespace, every party's package, and every line of reason whose
step the package holds, and fails the build if one of those lines needs a word
to keep its sense, or a kindred word's sense, and does not say so. The line then
states the condition as a premise of its own, with a citation and a rating, and
the solver weighs it as it weighs everything else. Where a cited reader denies
the condition, it is `disputed`; and a rival who denies it now undermines the
position at that premise, as it always could have in fact.

A line that sets out Scripture's own reasoning is not held to this
(`Testimony.Logic.Line.drawnByScripture`): what it needs is a condition on its
reader, not a premise of the text. A line whose claims are not all analysed
cannot be read, and the report counts such lines in each dispute, so that it
does not claim to reach further than it does.
-/

namespace Testimony.Checks

open Lean Elab Command Meta Testimony.Semantics Testimony.Logic

/-- Where a word is, for a report: a passage, a voice's usage, or a passage of a
voice's own text. -/
def scopeLabel : Testimony.Semantics.Scope → String
  | .passage p => p.render
  | .usage v => atomName v ++ "'s usage"
  | .passageOf v p => atomName v ++ "'s " ++ p.render

/-- What a line needs and leaves unstated: each word it needs kept in one sense
between two places, and each kindred word it reads another by without the
bridge. -/
def unstatedConditions {α : Type} [HasMeanings α] (m : Move) : List String :=
  (m.equivocation.filterMap fun
    | (w, a, b, .unstated) => some (atomName w ++ " the same in " ++ scopeLabel a ++ " and " ++
        scopeLabel b)
    | _ => none) ++
  (m.unbridged.map fun (w, v, k) =>
    atomName w ++ " for " ++ atomName v ++ " (" ++ atomName k ++ ")")

/-- **One dispute's hidden premises**: for every party, each line of reason whose
step its package holds and which leaves a condition unstated, and how many of
its lines could not be read. Returns the report's lines and how many hidden
premises it found. -/
def conditionReport {α : Type} [HasMeanings α] [DecidableEq α] [HasPostulates α]
    {ι : Type} (d : Dispute α ι) (parties : List ι)
    (lines : List (String × Line α)) : List String × Nat := Id.run do
  let mut out : List String := []
  let mut found := 0
  let mut unread := 0
  for i in parties do
    let held := (d.node i).premises
    let inPkg := lines.filter fun (_, l) => l.premises.all held.contains
    -- Lines on one step differ only in grounds; report the fullest held, once.
    let fullest := inPkg.filter fun (_, l) => !inPkg.any fun (_, l') =>
      l'.step == l.step && l'.grounds.length > l.grounds.length
    let once := fullest.foldl (fun acc (n, l) =>
      if acc.any (·.2.step == l.step) then acc else acc ++ [(n, l)]) []
    for (n, l) in once do
      if l.drawnByScripture then continue
      match (l.asMove? (α := α)).filter fun m => m.statements.all Statement.analysed with
      | none => unread := unread + 1
      | some m =>
        let cs := unstatedConditions (α := α) m
        unless cs.isEmpty do
          found := found + cs.length
          out := out ++ ["    " ++ (d.node i).name ++ ": " ++ n ++ " (" ++ l.drawnBy ++ "): " ++
            ", ".intercalate cs]
  return (s!"  hidden premises: {found}; lines not read: {unread}" :: out, found)

/-- Every party of every dispute under `root`, against every line of reason; see
the module docstring. -/
def checkConditions (root : Name) : CommandElabM Unit := do
  let env ← getEnv
  let mut byType : Std.HashMap Name (Array Name) := {}
  for (name, info) in env.constants.toList do
    if name.isInternal then continue
    if let some c := lineClaimType? info.type then
      byType := byType.insert c ((byType.getD c #[]).push name)
  let mut reports : Array String := #[]
  let mut failing : Array Name := #[]
  for (name, info) in env.constants.toList do
    unless root.isPrefixOf name && isDisputeTable info.type do continue
    let r? ← liftTermElabM do
      try
        let rel := info.type.appArg!
        let d := rel.appArg!
        let dTy ← whnfR (← inferType d)
        let α := dTy.getAppArgs[0]!
        let some c := α.constName? | return none
        let names := (byType.getD c #[]).qsort (·.toString < ·.toString)
        let lineTy := mkApp (mkConst ``Testimony.Logic.Line) α
        let pairTy ← mkAppM ``Prod #[mkConst ``String, lineTy]
        let pairs ← names.toList.mapM fun n =>
          mkAppM ``Prod.mk #[toExpr n.getString!, mkConst n]
        let lst ← mkListLit pairTy pairs
        let parties ← mkAppM ``Testimony.Logic.Solver.Finite.parties #[mkConst name]
        let e ← mkAppOptM ``conditionReport
          #[none, none, none, none, none, some d, some parties, some lst]
        some <$> unsafe evalExpr (List String × Nat) (toTypeExpr (List String × Nat)) e
      catch _ => pure none
    match r? with
    | some (lines, found) =>
      let title := (name.replacePrefix root .anonymous).toString
      reports := reports.push (String.intercalate "\n" ((title ++ ":") :: lines))
      if found > 0 then failing := failing.push name
    | none => throwError m!"#check_conditions could not read {name}"
  if reports.isEmpty then
    throwError "#check_conditions found no dispute to check"
  let sorted := reports.qsort (· < ·)
  unless failing.isEmpty do
    throwError m!"lines in a dispute that leave a premise unstated, in:\n{
      String.intercalate "\n" sorted.toList}"
  recordChecked `conditions root
  logInfo m!"every dispute, its lines' conditions stated:\n{String.intercalate "\n" sorted.toList}"

/-- `#check_conditions under N` fails the build if a line of reason held by a
party to a dispute under the namespace `N` leaves a premise unstated. -/
syntax (name := checkConditionsCmd) "#check_conditions" " under " ident : command

elab_rules : command
  | `(#check_conditions under $root) => checkConditions root.getId

/--
info: every dispute, its lines' conditions stated:
finite:
  hidden premises: 0; lines not read: 2
-/
#guard_msgs in
#check_conditions under Testimony.Checks.Fixture

end Testimony.Checks
