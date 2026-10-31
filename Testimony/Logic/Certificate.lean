import Testimony.Logic.Horn
import Testimony.Logic.Credibility

/-!
# Testimony.Logic.Certificate — finding what the kernel checks

`Horn.defeatsBy?` decides a cell of a defeat table from hints: for each question
of satisfiability the cell asks, a model or a refutation, which the kernel
checks (`Horn.clausesSatisfiableBy?`). This module finds them.

The search is the one the kernel would otherwise run, unit propagation, run
here at elaboration time and recording what it found:

- for a satisfiable question, the model a candidate gave, as a bitmask over the
  atoms' constructor indices;
- for an unsatisfiable one, the clauses that fired, in order, and the clause
  then violated.

Each hint is checked here, with the kernel's own checker, before it is handed
on, and a hint that does not check is replaced by `search`, so the kernel never
fails on a hint where the search would have succeeded. None of this is trusted:
the kernel checks every hint again, and a wrong one could only make a proof
fail.

`horn_certify` proves a goal `∃ index hints, Horn.defeatsBy? index hints a b s t
= some v`, the hypothesis of `Horn.defeats_iff_of_certified` and its siblings,
by finding the hints and checking them with `decide +kernel`.

## Why it is faster

Propagation to a fixed point, in the kernel, is pass after pass over every
clause, by term rewriting. Checking a model is one pass; replaying a refutation
fires only the clauses that fired, once each. Each party's position is
converted to clauses once per cell, not once per question.
-/

namespace Testimony.Logic.Horn

variable {α : Type} [DecidableEq α]

/-- One pass of propagation, recording the position of each clause that settled
something new. -/
def passTrace (cs : List (Clause α)) (s : Settled α) : Settled α × List ℕ :=
  cs.zipIdx.foldl (fun (s, trace) (c, i) =>
    let s' := propagate s c
    if s'.yes.length == s.yes.length && s'.no.length == s.no.length then (s, trace)
    else (s', trace ++ [i])) (s, [])

/-- Passes from `s`, at most `n` of them, until one settles nothing new, with
the clauses that fired appended to `trace`. -/
def chainTrace (cs : List (Clause α)) : ℕ → Settled α → List ℕ → Settled α × List ℕ
  | 0, s, trace => (s, trace)
  | n + 1, s, trace =>
    let (s', fired) := passTrace cs s
    if fired.isEmpty then (s', trace) else chainTrace cs n s' (trace ++ fired)

/-- The atoms as a bitmask, each at its index. -/
def maskOf (index : α → ℕ) (as : List α) : ℕ := as.foldl (fun m a => m ||| (1 <<< index a)) 0

/-- What propagation settled from a list of formulas alone: the clauses, and
the state and trace every question asked of that list starts from. -/
structure Base (α : Type) where
  /-- The list's clauses. -/
  clauses : List (Clause α)
  /-- What propagation settled from them. -/
  settled : Settled α
  /-- The clauses that fired, in order. -/
  trace : List ℕ

/-- The base of a list of formulas, if each has clauses. -/
def base (Γ : List (Formula α)) : Option (Base α) :=
  (clausesOf Γ).map fun cs =>
    let (s, trace) := chainTrace cs (cs.length + 1) ⟨[], []⟩ []
    ⟨cs, s, trace⟩

/-- The hint for the clauses `cs`, which begin with a base's: propagation
continues from what the base settled, and the candidates and the refutation are
`clausesSatisfiable?`'s, recorded. A trace that starts from a base's state
replays from nothing, because the base's trace is its prefix and the base's
clauses keep their positions. A hint that does not check is `search`. -/
def hintFrom (index : α → ℕ) (cs : List (Clause α)) (s₀ : Settled α) (trace₀ : List ℕ) :
    Hint :=
  let (s, trace) := chainTrace cs (cs.length + 1) s₀ trace₀
  let atoms := (cs.flatMap fun c => c.body ++ c.heads).eraseDups
  let notNo := atoms.filter (!s.no.elem ·)
  let hint : Hint :=
    if cs.all (satisfiedBy (s.yes.elem ·)) then .model (maskOf index s.yes)
    else if cs.all (satisfiedBy (notNo.elem ·)) then .model (maskOf index notNo)
    else match cs.zipIdx.find? (fun (c, _) => violated s c) with
      | some (_, last) => .refute trace last
      | none =>
        let yes := chosen cs s
        if cs.all (satisfiedBy (yes.elem ·)) then .model (maskOf index yes) else .search
  match clausesSatisfiableBy? index cs hint with
  | some _ => hint
  | none => .search

/-- The hint for the question whether the base's formulas and `φ` can hold
together. -/
def hintOn (index : α → ℕ) (b : Option (Base α)) (φ : Formula α) : Hint :=
  match b, toClauses φ with
  | some b, some d => hintFrom index (b.clauses ++ d) b.settled b.trace
  | _, _ => .search

/-- The hint for the question whether the base's formulas and `Δ` can all hold
together. -/
def hintOnAll (index : α → ℕ) (b : Option (Base α)) (Δ : List (Formula α)) : Hint :=
  match b, clausesOf Δ with
  | some b, some d => hintFrom index (b.clauses ++ d) b.settled b.trace
  | _, _ => .search

/-- **The hint for whether `Γ` and `Δ` can all hold together**, as the one
question `Horn.satisfiable_of_certified` asks. -/
@[nospecialize]
def hintsAppend (index : α → ℕ) (Γ Δ : List (Formula α)) : List Hint :=
  [hintOnAll index (base Γ) Δ]

variable [HasPostulates α]

/-- **The hints for a dissent's findings**, in the order `Dissent.findingsBy?`
asks its questions: whether its premises hold together, with the claim, with
the step's grounds, and what it asserts with the claim. -/
@[nospecialize]
def findingsHints (index : α → ℕ) (d : Dissent α) : List Hint :=
  let b := base (d.premises ++ d.background)
  [ hintOnAll index b [], hintOnAll index b [d.claim], hintOnAll index b d.grounds
  , hintOnAll index (base (d.asserted ++ d.background)) [d.claim] ]

/-- **The hints for a cell**, in the order `Horn.defeatChecks` asks its
questions: the rebuttal, each premise of `b`, and for each of `b`'s steps what
it delivers and what `a` denies. Not specialized, so that elaborating a call to
it compiles the call alone. -/
@[nospecialize]
def hintsFor (index : α → ℕ) (a b : ArgumentPackage α) : List Hint :=
  let ba := base a.held
  let bb := base b.held
  (hintOn index ba b.conclusion :: b.premises.map (hintOn index ba)) ++
    (stepsOf b.premises).flatMap fun q => [hintOn index bb (∼q.2), hintOn index ba q.2]

end Testimony.Logic.Horn

namespace Testimony.Logic.Certificate

open Lean Meta Elab Tactic Testimony.Logic.Horn

instance : ToExpr Hint where
  toTypeExpr := mkConst ``Hint
  toExpr
    | .search => mkConst ``Hint.search
    | .model yes => mkApp (mkConst ``Hint.model) (toExpr yes)
    | .refute trace last => mkApp2 (mkConst ``Hint.refute) (toExpr trace) (toExpr last)

/-- The index a cell's models are read through: the atom type's constructor
index, where it has one, which tells every atom of an enumeration apart; and
otherwise every atom at `0`, under which most models fail to check and the
kernel searches instead. -/
def indexFor (α : Expr) : MetaM Expr := do
  if let .const n us := α then
    let idx := n ++ `ctorIdx
    if (← getEnv).contains idx then return .const idx us
  return .lam `_ α (mkNatLit 0) .default

/-- The search that finds a decision's hints, from the decision the goal
states: a defeat cell (`Horn.defeatsBy?`), a dissent's findings
(`Dissent.findingsBy?`), or one question of satisfiability
(`Horn.satisfiableAppend?`). -/
def searchFor (index lhs : Expr) : MetaM Expr := do
  let args := lhs.getAppArgs
  if lhs.isAppOfArity ``Horn.defeatsBy? 9 then
    mkAppOptM ``Horn.hintsFor #[args[0]!, args[1]!, args[2]!, index, args[5]!, args[6]!]
  else if lhs.isAppOfArity ``Dissent.findingsBy? 6 then
    mkAppOptM ``Horn.findingsHints #[args[0]!, args[1]!, args[2]!, index, args[5]!]
  else if lhs.isAppOfArity ``Horn.satisfiableAppend? 6 then
    let base := args[4]!
    unless base.isAppOfArity ``Horn.clausesOf 2 do
      throwError "horn_certify: expected the clauses of a list, got{indentExpr base}"
    mkAppOptM ``Horn.hintsAppend #[args[0]!, args[1]!, index, base.appArg!, args[5]!]
  else
    throwError "horn_certify: expected `Horn.defeatsBy? …`, `Dissent.findingsBy? …` or \
      `Horn.satisfiableAppend? …`, got{indentExpr lhs}"

/-- Prove `∃ index hints, decision index hints … = v`, for a defeat cell, a
dissent's findings or a question of satisfiability, by finding the hints and
having the kernel check them. -/
elab (name := hornCertify) "horn_certify" : tactic => do
  let goal ← getMainGoal
  let ty ← whnfR (← instantiateMVars (← goal.getType))
  let some (indexTy, p) := ty.app2? ``Exists
    | throwError "horn_certify: expected `∃ index hints, …`, got{indentExpr ty}"
  let .const _ us := ty.getAppFn | throwError "horn_certify: unexpected goal"
  let index ← indexFor indexTy.bindingDomain!
  let inner ← whnfR (p.beta #[index])
  let some (hintsTy, q) := inner.app2? ``Exists
    | throwError "horn_certify: expected `∃ hints, …`, got{indentExpr inner}"
  let .const _ vs := inner.getAppFn | throwError "horn_certify: unexpected goal"
  let probe := q.beta #[mkApp (mkConst ``List.nil [0]) (mkConst ``Hint)]
  let some (_, lhs, _) := probe.eq?
    | throwError "horn_certify: expected an equation, got{indentExpr probe}"
  let search ← searchFor index (← instantiateMVars lhs)
  let hints ← unsafe evalExpr (List Hint) (← inferType search) search
  let hintsE := toExpr hints
  let checked ← mkFreshExprMVar (q.beta #[hintsE])
  let rest ← Tactic.run checked.mvarId! (evalTactic (← `(tactic| decide +kernel)))
  unless rest.isEmpty do throwError "horn_certify: the kernel did not check the hints"
  goal.assign <| mkApp4 (.const ``Exists.intro us) indexTy p index <|
    mkApp4 (.const ``Exists.intro vs) hintsTy q hintsE checked
  replaceMainGoal []

end Testimony.Logic.Certificate
