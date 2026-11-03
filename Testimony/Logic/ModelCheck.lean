import Testimony.Logic.Entail

/-!
# Testimony.Logic.ModelCheck — a named reading, checked by the kernel

`satisfied_by` and `leaves_open` prove that a premise set has a model by naming
one: a reading, written as a definition that says of each claim whether it
holds. They used to prove it by having `simp` unfold the premise list and the
semantics of every formula in it, which cost a module like the sola fide
dispute most of its elaboration time.

A reading over an enumeration of claims is a table: each claim is `True` or
`False`. This module reads the table off the definition at elaboration time, as
a function to `Bool` (`ModelCheck.tableOf`), with the proof that it agrees with
the reading claim by claim, built as a term by cases rather than proved goal by
goal. The kernel then evaluates every premise under the table
(`holdsB`) with `decide +kernel`. Nothing is trusted that was not before:
`models_iff_holdsB` proves that a formula holds under the reading exactly when
it evaluates to `true` under the table, and the kernel checks the table's
agreement with the reading and every evaluation.

A reading that is not such a table — one defined through another reading, or
over a type that is not an enumeration — is left to the old recipe, which the
tactics fall back to.
-/

namespace Testimony.Logic

variable {α : Type}

/-- Whether a formula holds under a valuation given as a table of `Bool`s. -/
def holdsB (b : α → Bool) : Formula α → Bool
  | .atom a => b a
  | .falsum => false
  | .and p q => holdsB b p && holdsB b q
  | .or p q => holdsB b p || holdsB b q
  | .imp p q => !holdsB b p || holdsB b q

/-- **A formula holds under a reading exactly when it evaluates to `true` under
the reading's table.** -/
theorem models_iff_holdsB {w : Valuation α} {b : α → Bool} (hb : ∀ a, w a ↔ b a = true) :
    ∀ φ : Formula α, w ⊧ φ ↔ holdsB b φ = true
  | .atom a => by
    simp only [holdsB, FFL.Propositional.Formula.Boolean.models_atom, hb]
  | .falsum => by
    simp only [holdsB, Bool.false_eq_true, iff_false]
    exact FFL.Semantics.Bot.models_falsum w
  | .and p q => by
    have hp := models_iff_holdsB hb p
    have hq := models_iff_holdsB hb q
    simp only [holdsB, Bool.and_eq_true, ← hp, ← hq]
    exact FFL.Semantics.And.models_and
  | .or p q => by
    have hp := models_iff_holdsB hb p
    have hq := models_iff_holdsB hb q
    simp only [holdsB, Bool.or_eq_true, ← hp, ← hq]
    exact FFL.Semantics.Or.models_or
  | .imp p q => by
    have hp := models_iff_holdsB hb p
    have hq := models_iff_holdsB hb q
    refine FFL.Semantics.Imp.models_imply.trans ?_
    cases e : holdsB b p
    · simp only [holdsB, e, Bool.not_false, Bool.true_or]
      exact ⟨fun _ => trivial, fun _ h => absurd (e.symm.trans (hp.mp h)) Bool.false_ne_true⟩
    · simp only [holdsB, e, Bool.not_true, Bool.false_or]
      exact ⟨fun h => hq.mp (h (hp.mpr e)), fun h _ => hq.mpr h⟩

/-- Every premise holds under a reading, when each evaluates to `true` under its
table. -/
theorem models_all_of_holdsB {w : Valuation α} {b : α → Bool} (hb : ∀ a, w a ↔ b a = true)
    {prems : List (Formula α)} (h : prems.all (holdsB b) = true) : ∀ φ ∈ prems, w ⊧ φ :=
  fun φ hφ => (models_iff_holdsB hb φ).mpr (List.all_eq_true.mp h φ hφ)

/-- **Satisfiable, by a reading the kernel checks against every premise.** -/
theorem satisfiable_of_table {prems : List (Formula α)} (w : Valuation α) (b : α → Bool)
    (hb : ∀ a, w a ↔ b a = true) (h : prems.all (holdsB b) = true) : Satisfiable prems :=
  satisfiable_of_model w (models_all_of_holdsB hb h)

/-- **Independent, by two readings the kernel checks**: one satisfying every
premise and falsifying `φ`, one satisfying every premise and `φ`. -/
theorem independent_of_tables {prems : List (Formula α)} {φ : Formula α}
    (wf wt : Valuation α) (bf bt : α → Bool)
    (hbf : ∀ a, wf a ↔ bf a = true) (hbt : ∀ a, wt a ↔ bt a = true)
    (h : (prems.all (holdsB bf) && !holdsB bf φ && prems.all (holdsB bt) && holdsB bt φ) = true) :
    Independent prems φ := by
  simp only [Bool.and_eq_true, Bool.not_eq_true'] at h
  obtain ⟨⟨⟨hfs, hff⟩, hts⟩, htt⟩ := h
  exact independent_of_countermodels wf wt (models_all_of_holdsB hbf hfs)
    (fun hm => absurd (hff.symm.trans ((models_iff_holdsB hbf φ).mp hm)) Bool.false_ne_true)
    (models_all_of_holdsB hbt hts) ((models_iff_holdsB hbt φ).mpr htt)

end Testimony.Logic

namespace Testimony.Logic.ModelCheck

open Lean Meta Elab Tactic

/-- **A reading's table**, read off its definition: for a valuation `w` over an
enumeration, the function to `Bool` that is `true` exactly at the claims where
`w` reduces to `True`, and the proof, by cases, that the two agree. Fails if the
atom type is not an enumeration or if the reading does not reduce, at some
claim, to `True` or `False`. -/
def tableOf (w : Expr) : MetaM (Expr × Expr) := do
  let wTy ← whnf (← inferType w)
  let .forallE _ α _ _ := wTy | throwError "model check: not a valuation"
  let .const αName [] := α.getAppFn | throwError "model check: the atoms are not an enumeration"
  let some (.inductInfo ind) := (← getEnv).find? αName
    | throwError "model check: the atoms are not an inductive type"
  unless ind.numParams == 0 && ind.numIndices == 0 do
    throwError "model check: the atoms are not an enumeration"
  let casesOn := mkConst (αName ++ `casesOn) [Level.one]
  let casesOnProp := mkConst (αName ++ `casesOn) [Level.zero]
  let mut bools : Array Expr := #[]
  let mut proofs : Array Expr := #[]
  let eqTrue (b : Expr) :=
    mkApp3 (mkConst ``Eq [Level.one]) (mkConst ``Bool) b (mkConst ``Bool.true)
  for c in ind.ctors do
    let some (.ctorInfo ci) := (← getEnv).find? c | throwError "model check: no constructor {c}"
    unless ci.numFields == 0 do throwError "model check: the atoms are not an enumeration"
    let v ← whnf (mkApp w (mkConst c))
    if v.isConstOf ``True then
      bools := bools.push (mkConst ``Bool.true)
      proofs := proofs.push <| mkApp4 (mkConst ``iff_of_true) (mkConst ``True)
        (eqTrue (mkConst ``Bool.true)) (mkConst ``True.intro)
        (mkApp2 (mkConst ``Eq.refl [Level.one]) (mkConst ``Bool) (mkConst ``Bool.true))
    else if v.isConstOf ``False then
      bools := bools.push (mkConst ``Bool.false)
      proofs := proofs.push <| mkApp4 (mkConst ``iff_of_false) (mkConst ``False)
        (eqTrue (mkConst ``Bool.false)) (mkConst ``not_false) (mkConst ``Bool.false_ne_true)
    else
      throwError "model check: the reading is not a table at {c}"
  let b := .lam `a α (mkAppN casesOn (#[.lam `_ α (mkConst ``Bool) .default, .bvar 0] ++ bools))
    .default
  let motive := .lam `a α (mkApp2 (mkConst ``Iff) (mkApp w (.bvar 0))
    (eqTrue (mkApp b (.bvar 0)))) .default
  let hb := .lam `a α (mkAppN casesOnProp (#[motive, .bvar 0] ++ proofs)) .default
  return (b, hb)

/-- Close the goal with `decide +kernel`, or fail. -/
def kernelDecide (g : MVarId) : TacticM Unit := do
  let rest ← Tactic.run g (evalTactic (← `(tactic| decide +kernel)))
  unless rest.isEmpty do throwError "model check: the kernel did not check the reading"

/-- Apply the theorem `thm` to the goal, its explicit arguments before the last
given by `given`, in order, and its implicit ones found by unifying its
conclusion with the goal; the last argument, the evaluation, is checked by the
kernel. -/
def applyChecked (thm : Name) (given : Array Expr) : TacticM Unit := do
  let goal ← getMainGoal
  let c ← mkConstWithFreshMVarLevels thm
  let (args, binfos, concl) ← forallMetaTelescopeReducing (← inferType c)
  let explicit := (args.zip binfos).filter (·.2.isExplicit) |>.map (·.1)
  unless explicit.size == given.size + 1 do
    throwError "model check: {thm} takes {explicit.size} arguments"
  for (m, e) in explicit.zip given do
    unless ← isDefEq m e do throwError "model check: an argument of {thm} does not fit"
  unless ← isDefEq concl (← goal.getType) do
    throwError "model check: {thm} does not prove the goal"
  let h := explicit[given.size]!
  goal.assign (mkAppN c args)
  kernelDecide h.mvarId!
  replaceMainGoal []

/-- `satisfied_by_table w`: prove `Satisfiable prems` from the reading `w`'s
table, checked by the kernel against every premise. -/
elab "satisfied_by_table " v:ident : tactic => do
  let w ← Term.elabTerm v none
  let (b, hb) ← tableOf w
  applyChecked ``satisfiable_of_table #[w, b, hb]

/-- `leaves_open_table wf wt`: prove `Independent prems φ` from the two
readings' tables, checked by the kernel. -/
elab "leaves_open_table " vf:ident ppSpace vt:ident : tactic => do
  let wf ← Term.elabTerm vf none
  let wt ← Term.elabTerm vt none
  let (bf, hbf) ← tableOf wf
  let (bt, hbt) ← tableOf wt
  applyChecked ``independent_of_tables #[wf, wt, bf, bt, hbf, hbt]

end Testimony.Logic.ModelCheck
