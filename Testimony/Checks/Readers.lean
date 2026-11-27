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

It holds one rating to a rule of its own. `refuted` is the one rating no reader
gives: a claim is cited `refuted` exactly where the library computes it from
Scripture's own words, because the word's spelling rules out the voice the claim
gives it (`Statement.misreads`), or because the claim names as the one at work
in a verb what the author, in every use whose spelling makes it active, never
names (`Statement.againstUsage`). So the check fails on a claim cited `refuted`
that neither refutes, and on a claim one of them refutes that is cited at a reader's
rating.

A step is held to what its reasoning does, and its refutation is computed, never
cited: the check fails on any step cited `refuted`. A reader's step may commit a
fault the text itself shows, as the fallacy checks compute it (`lineTextFaults`):
an equivocation on its own terms, an argument from silence alone, a conclusion
against the author's usage, or a reversal of cause and effect. Then a dispute must
already weigh the step at `refuted` by computation, as it weighs every step that
concludes a claim the text refutes (`lineWeighedRefuted`), and the check fails on
a step with such a fault that nothing computes so. A step that only argues from a
claim the text rules out is not refuted for it, because the claim already is. A
straw man and a univocal reading do not refute a step, because each shows what
the step leaves unanswered and not that it fails; they stay charges on the page.

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

/-- **Where a package's `refuted` ratings and the Greek disagree.** A claim is
cited `refuted` exactly where the library computes the refutation: where what it
asserts gives a Greek word a voice its spelling rules out (`Statement.misreads`),
or names as at work in a verb what its author's usage never does
(`Statement.againstUsage`). Each label returned is a claim cited `refuted` that
neither refutes, or a claim one of them refutes that is cited at a reader's
rating. -/
def refutedMismatches {α : Type} [Semantics.HasMeanings α]
    (pkg : Logic.ArgumentPackage α) : List String :=
  pkg.premises.filterMap fun
    | .atom a =>
      let m := pkg.cite a
      let cited := m.source.confidence == .refuted
      let s := Semantics.HasMeanings.means a
      let misread := s.misreads || s.againstUsage
      if cited && !misread then
        some (m.label ++ "\" is cited refuted, and nothing the library computes refutes it")
      else if misread && !cited then
        some (m.label ++
          "\" reads the Greek as its spelling or its author's usage rules out, " ++
          "and is not cited refuted")
      else none
    | _ => none

/-- **The faults a line's step commits that the text itself shows**: an
equivocation on its own terms, an argument from silence alone, a conclusion that
names as at work in a verb what its author never names there, and a cause made the
effect of its effect, each by name, as the fallacy checks find them
(`Testimony.Semantics.Fallacy`). A reading the text rules out that the step only
argues from is not the step's fault: the claim is cited `refuted` where it is
cited, and the step that draws on it is weighed with it, so a misreading of the
Greek, which a premise always carries, is not counted here. A straw man and a
univocal reading are not counted either: each shows what the step leaves
unanswered, not that it fails. A line whose claims are not all analysed is not
read, and shows none. -/
def lineTextFaults {α : Type} [Semantics.HasMeanings α] (l : Logic.Line α) : List String :=
  match l.asMove? with
  | none => []
  | some m =>
    if !m.statements.all Semantics.Statement.analysed then [] else
      (if m.equivocates.isEmpty then [] else ["an equivocation"]) ++
      (if m.fromSilenceAlone.isEmpty then [] else ["an argument from silence alone"]) ++
      (if ((m.conclusion?.map Semantics.Statement.unusualWorkers).getD []).isEmpty then []
        else ["a conclusion against the author's usage"]) ++
      (if m.reversals.isEmpty then [] else ["a reversal of cause and effect"])

/-- **Whether a dispute weighs a line's step at `refuted`, by computation.** A
dispute ranks a step to a claim the text refutes at `refuted`
(`Testimony.Logic.ArgumentPackage.rankOf`), and a claim is cited `refuted` exactly
where its reading of the Greek, or of who works in a verb, is ruled out by the
text (`refutedMismatches`). So the step is weighed `refuted` exactly when what it
concludes is such a reading. Nothing about the step is asserted: the rank follows
from the meaning of its conclusion. -/
def lineWeighedRefuted {α : Type} [Semantics.HasMeanings α] (l : Logic.Line α) : Bool :=
  match l.step with
  | .imp _ (.atom b) =>
    let s := Semantics.HasMeanings.means b
    s.misreads || s.againstUsage
  | _ => false

/-- **Where a line's rating and its faults disagree.** No step is cited `refuted`:
a step's refutation is computed, never asserted. A reader's step that commits a
fault the text itself shows (`lineTextFaults`) must be one a dispute already weighs
at `refuted` by computation (`lineWeighedRefuted`), so that what the fallacy checks
find moves the step's weight wherever it is heard. A step cited `refuted`, and a
step with such a fault that no computation weighs at `refuted`, are each returned
with the reason. Scripture's own reasoning is never charged, so a line cited to
Scripture is left to the fallacy check, which fails the build on the encoding. -/
def lineRefutedMismatch {α : Type} [Semantics.HasMeanings α] (l : Logic.Line α) :
    Option String :=
  let faults := if l.drawnByScripture then [] else lineTextFaults l
  if l.inference.any (·.confidence == .refuted) then
    some "the line's step is cited refuted; a step's refutation is computed, not cited"
  else if !faults.isEmpty && !lineWeighedRefuted l then
    some ("the line's step commits " ++ " and ".intercalate faults ++
      ", and no dispute computes it refuted")
  else none

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
    let refuted? ← liftTermElabM do
      try
        let e ← mkAppM ``refutedMismatches #[mkConst name]
        some <$> unsafe evalExpr (List String) (← inferType e) e
      catch _ => pure none
    for l in refuted?.getD [] do
      problems := problems.push m!"{name}: \"{l}"
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
    let refuted? ← liftTermElabM do
      try
        let e ← mkAppM ``lineRefutedMismatch #[mkConst name]
        some <$> unsafe evalExpr (Option String) (← inferType e) e
      catch _ => pure none
    match refuted? with
    | some (some why) => problems := problems.push m!"{name}: {why}"
    | some none => pure ()
    | none => problems := problems.push m!"{name}: the check could not be run"
    match unrated? with
    | some false => lines := lines + 1
    | some true => problems := problems.push m!"{name}: the line's step is rated by no one"
    | none => problems := problems.push m!"{name}: the check could not be run"
  unless problems.isEmpty do
    throwError m!"readings and steps with no reader, or rated `refuted` against what the \
      library computes:\n{MessageData.joinSep problems.toList "\n"}\ncite a reader who holds \
      each, or mark it the library's own with `Reference.proposal`; cite `refuted` exactly \
      the claims whose reading of the Greek the data contradicts"
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
