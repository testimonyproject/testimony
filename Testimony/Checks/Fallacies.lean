import Testimony.Checks.Meanings
import Testimony.Checks.Ontology
import Testimony.Semantics.Fallacy

/-!
# Testimony.Checks.Fallacies — the library's own lines, checked as an article's are

An article's moves are checked for equivocation, for begging the question, for
arguing from silence and for answering a straw man (`Testimony.Semantics.Fallacy`).
The library holds its own arguments to the same checks. Every line of reason is one step from its
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
- the lines that rest on one another in a circle: each, through the others,
  resting on what it delivers itself (`Testimony.Semantics.circular`);
- the lines that answer a view its holder does not hold, by the argument's own
  record of that voice (`Testimony.Semantics.Move.strawMen`), and every line that
  attributes a view, with how the attribution stands to the record. A line's
  record of a voice is the argument's other claims about what the voice held or
  how it read a word (`Testimony.Semantics.recordOf`), without the line's own
  claims, which cannot bear themselves out;
- the lines that need a word to keep its sense and do not say so, with the
  words. These are conditions, not faults;
- the lines that read one word by a kindred one, a verb by its adjective or the
  Greek by the Latin, without a premise saying the one bears on the other
  (`Testimony.Semantics.Move.unbridged`). Conditions too, not faults;
- and the lines that cite a voice for one reading of a word when the record has
  the same voice reading it another way as well
  (`Testimony.Semantics.Move.omissions`). Not a fault either: a reader is owed
  the other reading, and the page should give it;
- and the lines that conclude what a word means from no use or reading of the
  word, as from a doctrine (`Testimony.Semantics.Move.sensesFromElsewhere`).
  Reported, not charged.

Each line is named with the reader its step is cited to, so a finding is always
about someone's reading: Trent's, Schreiner's, Moo's, or the library's own
("proposed here"), or "uncited" where a line cites no one. A line whose step is
cited to Scripture itself sets out Scripture's own reasoning and is never listed
with the findings against readers. What it needs is reported apart, as what a
reader must hold to follow the text (`Testimony.Semantics.Fallacy`, "Whose
reasoning is checked").

The report is pinned. It fails the build if a line equivocates on its own terms,
argues from silence alone, or answers a straw man: the library may not do what it
checks articles for. A line that carries its conclusion in a premise is reported and does not
fail the build, because a premise that restates what no one denies begs no
question; the report says whom it is addressed to.

A circle does not fail the build either, for a reason of its own. A line does not
record which position holds it, and a circle is a fault only in one position's
reasoning. Two rivals whose lines happen to feed each other are not reasoning in a
circle; and an argument may encode a circle on purpose, as the charge it weighs —
sola scriptura's lines for Geisler's circle are the circle he charges Tradition I
with. So the report names the lines on a circle, and the page that describes them
says whose they are.
-/

namespace Testimony.Checks

open Lean Elab Command Meta Testimony.Semantics Testimony.Logic

/-- **What the fallacy checks find in one argument's lines**: the report's lines,
and how many lines commit what fails the build. Each line is named with the
reader its step is cited to (`Testimony.Logic.Line.drawnBy`). A line that sets
out Scripture's own reasoning (`Testimony.Logic.Line.drawnByScripture`) is never
listed among the findings against readers: what it needs is reported apart, as
what a reader must hold to follow the text. -/
def fallacyReport (α : Type) [HasMeanings α] [Repr α] [DecidableEq α]
    (lines : List (String × Line α)) : String × Nat :=
  let read := lines.filterMap fun (n, l) =>
    (l.asMove? (α := α)).bind fun m => if m.statements.all Statement.analysed
      then some (n ++ " (" ++ l.drawnBy ++ ")", l, m) else none
  let scriptural := read.filter fun (_, l, _) => l.drawnByScripture
  let moves := (read.filter fun (_, l, _) => !l.drawnByScripture).map fun (n, _, m) => (n, m)
  let named (f : Move → Bool) := moves.filterMap fun (n, m) => if f m then some n else none
  let equivocating := named fun m => !m.equivocates.isEmpty
  let silent := named fun m => !m.fromSilenceAlone.isEmpty
  let carrying := moves.filterMap fun (n, m) =>
    if m.carriers.isEmpty then none else
      let deniers := (m.begsAgainst (α := α)).flatMap (·.2)
      some (n ++ (if deniers.isEmpty then ": denied by no claim of the argument"
        else ": its premise denied by " ++ ", ".intercalate (deniers.map atomName)))
  let onCircle := (circular (moves.map (·.2))).filterMap fun i => (moves[i]?).map (·.1)
  let ownClaims (n : String) : List α :=
    ((lines.find? fun (k, l) => n == k ++ " (" ++ l.drawnBy ++ ")").map fun (_, l) =>
      atomsOf l.step).getD []
  let recordFor (n : String) (v : Voice) : List α :=
    (recordOf α v).filter fun a => !(ownClaims n).contains a
  let names (cs : List α) := ", ".intercalate (cs.map atomName)
  let standing : Attribution α → String
    | .fair cs => "borne out by " ++ names cs
    | .unfair cs => "contradicted by " ++ names cs
    | .disputed f u => "disputed: borne out by " ++ names f ++ ", contradicted by " ++ names u
    | .unrecorded => "unrecorded"
  let attributing := moves.filterMap fun (n, m) =>
    match m.attributed (recordFor n) with
    | [] => none
    | as => some (n ++ ": " ++ "; ".intercalate (as.map fun (a, st) =>
        ((a.voice?.map atomName).getD "?") ++ ", " ++ standing st))
  let strawMen := moves.filterMap fun (n, m) =>
    if (m.strawMen (recordFor n)).isEmpty then none else some n
  let shiftsOf (m : Move) := m.unbridged.map fun (w, v, k) =>
    atomName w ++ " for " ++ atomName v ++ " (" ++ atomName k ++ ")"
  let shifting := moves.filterMap fun (n, m) =>
    if m.unbridged.isEmpty then none else some (n ++ ": " ++ ", ".intercalate (shiftsOf m))
  let omitting := moves.filterMap fun (n, m) =>
    match m.omissions (recordFor n) with
    | [] => none
    | os => some (n ++ ": " ++ "; ".intercalate (os.map fun (a, others) =>
        ((a.voice?.map atomName).getD "?") ++ ", also " ++ ", ".intercalate
          (others.map fun (s, cs) => atomName s ++ " in " ++ names cs)))
  let fromElsewhere (m : Move) := m.sensesFromElsewhere.map fun (w, _, s) =>
    atomName w ++ " as " ++ atomName s
  let elsewhere := moves.filterMap fun (n, m) =>
    if m.sensesFromElsewhere.isEmpty then none else
      some (n ++ ": " ++ ", ".intercalate (fromElsewhere m))
  let conditional := moves.filterMap fun (n, m) =>
    if m.conditionalOn.isEmpty then none else
      some (n ++ ": " ++ ", ".intercalate (m.conditionalOn.map fun w => atomName w))
  -- Scripture's own reasoning: what a reader must hold to follow it, never a charge.
  let toFollow := scriptural.filterMap fun (n, _, m) =>
    let needs :=
      (m.conditionalOn.map fun w => atomName w ++ " kept in one sense") ++
      (m.equivocates.map fun _ => "the encoding gives a word two senses") ++
      shiftsOf m ++ fromElsewhere m
    if needs.isEmpty then none else some (n ++ ": " ++ ", ".intercalate needs)
  let encodingFaults := (scriptural.filter fun (_, _, m) =>
    !m.equivocates.isEmpty || !m.fromSilenceAlone.isEmpty).length
  let part (title : String) (xs : List String) : List String :=
    if xs.isEmpty then [] else ("  " ++ title ++ ":") :: xs.map ("    " ++ ·)
  let head := [HasMeanings.argument α,
    s!"  lines: {lines.length}, read: {read.length}, Scripture's own: {scriptural.length}"]
  let body :=
    part "read a word in two senses and need it the same" equivocating ++
    part "carry what they deliver in a premise" carrying ++
    part "argue from silence alone" silent ++
    part "rest on one another in a circle" onCircle ++
    part "answer a view the argument's record says its holder does not hold" strawMen ++
    part "attribute a view, against the argument's record" attributing ++
    part "need a word to keep its sense, unstated" conditional ++
    part "read one word by a kindred one, the bridge unstated" shifting ++
    part "cite a voice for one reading, leaving out another the record has" omitting ++
    part "conclude a word's sense from no use or reading of the word" elsewhere ++
    part "Scripture's own reasoning, not charged: what a reader must hold to follow it"
      toFollow
  (String.intercalate "\n" (head ++ body),
    equivocating.length + silent.length + strawMen.length + encodingFaults)

/-- Whether a constant's type is `Line C`, and `C` its argument's claim type. -/
def lineClaimType? (ty : Expr) : Option Name :=
  match ty.getAppFn.constName?, ty.getAppArgs with
  | some ``Testimony.Logic.Line, #[c] => c.constName?
  | _, _ => none

/-- Report what the fallacy checks find in every argument's lines under `root`;
see the module docstring. -/
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
        let e ← mkAppOptM ``fallacyReport #[some (mkConst c), none, none, none, some lst]
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
    let head := "lines that equivocate, argue from silence alone or answer a straw man, in:"
    throwError m!"{head}\n{MessageData.joinSep
      (failing.toList.map toMessageData) "\n"}\n{String.intercalate "\n" sorted.toList}"
  recordChecked `fallacies root
  let head := "the fallacy checks, over every argument's lines, each named with its reader:"
  logInfo m!"{head}\n{String.intercalate "\n" sorted.toList}"

/-- `#check_fallacies under N` reports on the lines of every argument whose
claim type is declared under the namespace `N`. -/
syntax (name := checkFallaciesCmd) "#check_fallacies" " under " ident : command

elab_rules : command
  | `(#check_fallacies under $root) => checkFallacies root.getId

/--
info: the fallacy checks, over every argument's lines, each named with its reader:
The fixture
  lines: 4, read: 2, Scripture's own: 0
  carry what they deliver in a premise:
    byTheHour (uncited): its premise denied by lastedTwoHours
  rest on one another in a circle:
    byNotTwoHours (uncited)
    byTheHour (uncited)
-/
#guard_msgs in
#check_fallacies under Testimony.Checks.Fixture

end Testimony.Checks
