import Testimony.Arguments.BornInBethlehem
import Testimony.Arguments.BornOfAVirgin
import Testimony.Arguments.CanonicalWitness
import Testimony.Arguments.SolaFide
import Testimony.Arguments.SolaScriptura

/-!
# Testimony.Checks.Refutations — `establish` proves nothing the library refutes

For every theorem of the form `¬ Establishes pkg` in `Testimony.Arguments`,
`establish` is run on `pkg` with its argument's unfold set, and must fail with
`horn_close`'s "not Horn" message. The check runs as part of `lake build`, so CI
runs it on every change, and it finds the refutations itself: one added
tomorrow is checked tomorrow, with no list to keep up to date.

**What it shows, and what it does not.** A tactic cannot make the kernel
accept a false theorem, so this is not what keeps the library sound — the
kernel does that, and a package that is refuted cannot also be established. What
the check pins is how `establish` behaves on an entailment that does not hold:
it stops, with the diagnostic that names the cause, rather than failing some
other way — an elaboration error, a missing set, a timeout — or searching
without end. It is the library-wide form of the affirming-the-consequent check
in `Testimony.Logic.Tactic`.

The failure is the entailment's and not a definition left folded, because each
refutation's own proof unfolds the same set: `refute_with` has to evaluate the
countermodel on every premise, which it cannot do through a folded definition.

The check was a manual step, rerun by hand after every change to the tactics
(`docs/src/logic.md`, "It proves nothing the library refutes"). It is now a
build step. -/

namespace Testimony.Checks

open Lean Elab Command Meta

/-- Each argument's namespace, and the unfold set its proofs name. A refutation
outside every namespace listed here fails the check, so a new argument cannot
be left out of it. -/
def unfoldSets : List (Name × Name) :=
  [ (`Testimony.Arguments.BornInBethlehem, `bornInBethlehemDefs)
  , (`Testimony.Arguments.BornOfAVirgin, `bornOfAVirginDefs)
  , (`Testimony.Arguments.CanonicalWitness, `canonicalWitnessDefs)
  , (`Testimony.Arguments.SolaFide, `solaFideDefs)
  , (`Testimony.Arguments.SolaScriptura, `solaScripturaDefs) ]

/-- The message `horn_close` fails with; the check requires it verbatim. -/
def notHorn : String := "establish: the premises are not Horn"

/-- `Establishes pkg`, if a theorem's statement is `¬ Establishes pkg`. -/
def refutedEntailment? (type : Expr) : Option Expr :=
  match type.not? with
  | some e => if e.isAppOfArity ``Testimony.Logic.Establishes 2 then some e else none
  | none => none

/-- Run `establish [set]` on `Establishes pkg`, and report what happened: `none`
if it failed with `horn_close`'s message, otherwise what went wrong. The
attempt is discarded either way. -/
def establishFailsAsNotHorn (set : Name) (goal : Expr) : TermElabM (Option String) := do
  let s ← saveState
  let setId := mkIdent set
  let tac ← `(tactic| establish [$setId:ident])
  let mvar ← mkFreshExprMVar goal
  let outcome ← try
      let rest ← Tactic.run mvar.mvarId! (Tactic.evalTactic tac)
      if rest.isEmpty then pure (some "establish succeeded")
      else pure (some "establish left goals open")
    catch e =>
      let msg ← e.toMessageData.toString
      if (msg.splitOn notHorn).length > 1 then pure none
      else pure (some s!"establish failed for another reason: {msg}")
  s.restore
  return outcome

/-- Check every refutation in the arguments; see the module docstring. -/
elab "#check_refutations" : command => do
  let env ← getEnv
  let mut checked : Nat := 0
  let mut problems : Array MessageData := #[]
  for (name, info) in env.constants.toList do
    unless (`Testimony.Arguments).isPrefixOf name do continue
    let .thmInfo thm := info | continue
    let some goal := refutedEntailment? thm.type | continue
    let some (_, set) := unfoldSets.find? (·.1.isPrefixOf name) | do
      problems := problems.push m!"{name}: no unfold set for its namespace"
      continue
    match ← liftTermElabM (establishFailsAsNotHorn set goal) with
    | none => checked := checked + 1
    | some why => problems := problems.push m!"{name}: {why}"
  unless problems.isEmpty do
    throwError m!"refutations not confirmed:\n{MessageData.joinSep problems.toList "\n"}"
  if checked == 0 then
    throwError "#check_refutations found no refutation to check"
  logInfo m!"establish fails, as not Horn, on all {checked} refuted packages"

/-- info: establish fails, as not Horn, on all 33 refuted packages -/
#guard_msgs in
#check_refutations

end Testimony.Checks
