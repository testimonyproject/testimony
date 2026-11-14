import Testimony.Checks.Meanings
import Testimony.Checks.Ontology
import Testimony.Semantics.Fallacy

/-!
# Testimony.Checks.Fallacies — the library's own reasoning, charged as an article's is

An article's moves are checked for equivocation, for begging the question and
for arguing from silence (`Testimony.Semantics.Fallacy`). The library holds its
own arguments to the same checks. Every line of reason is one step from its
grounds to what it delivers, and read through its argument's meanings the step
is a move: its antecedent's parts the premises, its consequent the conclusion
(`Testimony.Logic.Line.asMove?`). This check finds every line of every argument
under a namespace it is given, as `Testimony.Checks.Meanings` finds the claim
types, and reports, for each argument:

- how many of its lines it could read, all of whose claims are analysed;
- the lines that read a word in two senses and need it the same;
- the lines a premise of which already asserts what they deliver, and whether a
  claim of the argument denies that premise;
- the lines that argue from a text's silence without the expectation that would
  carry it;
- and the lines that need a word to keep its sense and do not say so, with the
  words. These are conditions, not faults.

The report is pinned. It fails the build if a line equivocates on its own terms
or argues from silence alone: the library may not do what it checks articles
for. A line that carries its conclusion in a premise is reported and does not
fail the build, because a premise that restates what no one denies begs no
question; the report says whom it is addressed to.
-/

namespace Testimony.Checks

open Lean Elab Command Meta Testimony.Semantics Testimony.Logic

/-- **The charges against one argument's lines**: the report's lines, and how
many lines commit a charge that fails the build. -/
def fallacyReport (α : Type) [HasMeanings α] [Repr α]
    (lines : List (String × Line α)) : String × Nat :=
  let moves := lines.filterMap fun (n, l) =>
    (l.asMove? (α := α)).bind fun m => if m.statements.all Statement.analysed then some (n, m)
      else none
  let named (f : Move → Bool) := moves.filterMap fun (n, m) => if f m then some n else none
  let equivocating := named fun m => !m.equivocates.isEmpty
  let silent := named fun m => !m.fromSilenceAlone.isEmpty
  let carrying := moves.filterMap fun (n, m) =>
    if m.carriers.isEmpty then none else
      let deniers := (m.begsAgainst (α := α)).flatMap (·.2)
      some (n ++ (if deniers.isEmpty then ": denied by no claim of the argument"
        else ": its premise denied by " ++ ", ".intercalate (deniers.map atomName)))
  let conditional := moves.filterMap fun (n, m) =>
    if m.conditionalOn.isEmpty then none else
      some (n ++ ": " ++ ", ".intercalate (m.conditionalOn.map fun w => atomName w))
  let part (title : String) (xs : List String) : List String :=
    if xs.isEmpty then [] else ("  " ++ title ++ ":") :: xs.map ("    " ++ ·)
  let head := [HasMeanings.argument α,
    s!"  lines: {lines.length}, read: {moves.length}"]
  let body :=
    part "read a word in two senses and need it the same" equivocating ++
    part "carry what they deliver in a premise" carrying ++
    part "argue from silence alone" silent ++
    part "need a word to keep its sense, unstated" conditional
  (String.intercalate "\n" (head ++ body), equivocating.length + silent.length)

/-- Whether a constant's type is `Line C`, and `C` its argument's claim type. -/
def lineClaimType? (ty : Expr) : Option Name :=
  match ty.getAppFn.constName?, ty.getAppArgs with
  | some ``Testimony.Logic.Line, #[c] => c.constName?
  | _, _ => none

/-- Report the charges against every argument's lines under `root`; see the
module docstring. -/
def checkFallacies (root : Name) : CommandElabM Unit := do
  let env ← getEnv
  let mut byType : Std.HashMap Name (Array Name) := {}
  for (name, info) in env.constants.toList do
    if name.isInternal then continue
    match lineClaimType? info.type with
    | some c =>
      if isClaimType env c root then byType := byType.insert c ((byType.getD c #[]).push name)
    | none => pure ()
  let mut reports : Array String := #[]
  let mut failing : Array Name := #[]
  for (c, names) in byType.toList do
    let sorted := names.qsort (·.toString < ·.toString)
    let r? ← liftTermElabM do
      try
        let lineTy := mkApp (mkConst ``Testimony.Logic.Line) (mkConst c)
        let pairTy ← mkAppM ``Prod #[mkConst ``String, lineTy]
        let pairs ← sorted.toList.mapM fun n =>
          mkAppM ``Prod.mk #[toExpr n.getString!, mkConst n]
        let lst ← mkListLit pairTy pairs
        let e ← mkAppOptM ``fallacyReport #[some (mkConst c), none, none, some lst]
        some <$> unsafe evalExpr (String × Nat) (toTypeExpr (String × Nat)) e
      catch _ => pure none
    match r? with
    | some (lines, bad) =>
      reports := reports.push lines
      if bad > 0 then failing := failing.push c
    | none => throwError m!"#check_fallacies could not report on {c}"
  if reports.isEmpty then
    throwError "#check_fallacies found no line to check"
  let sorted := reports.qsort (· < ·)
  unless failing.isEmpty do
    throwError m!"lines that equivocate or argue from silence alone, in:\n{MessageData.joinSep
      (failing.toList.map toMessageData) "\n"}\n{String.intercalate "\n" sorted.toList}"
  logInfo m!"the charges, against every argument's lines:\n{String.intercalate "\n" sorted.toList}"

/-- `#check_fallacies under N` reports on the lines of every argument whose
claim type is declared under the namespace `N`. -/
syntax (name := checkFallaciesCmd) "#check_fallacies" " under " ident : command

elab_rules : command
  | `(#check_fallacies under $root) => checkFallacies root.getId

/--
info: the charges, against every argument's lines:
The fixture
  lines: 3, read: 1
  carry what they deliver in a premise:
    byTheHour: its premise denied by lastedTwoHours
-/
#guard_msgs in
#check_fallacies under Testimony.Checks.Fixture

end Testimony.Checks
