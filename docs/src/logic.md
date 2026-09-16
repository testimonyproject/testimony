# Encoding arguments

## How entailment is settled

An argument is a list of premises and a conclusion, both formulas over cited
atoms. Two questions get asked of it, and they are answered by different means.

**Does the conclusion follow?** Mathlib's `tauto`, a goal-directed classical
tableau. It produces an ordinary proof term, so the trust base is unchanged,
and its cost tracks the argument's structure rather than its atom count.

**Does it fail to follow?** Name a countermodel — a valuation satisfying every
premise while falsifying the conclusion:

```lean
theorem not_entails_of_countermodel
    (w : Valuation α)
    (hsat : ∀ φ ∈ prems, Formula.Boolean.val w φ)
    (hfail : ¬ Formula.Boolean.val w concl) : ¬ Entails prems concl
```

Checking a named valuation is linear. Searching for one is not, which is why
the library asks the author to supply it.

That turns out to be a feature rather than a chore. "A countermodel exists"
tells a reader nothing; a named valuation **is the rival's reading, written
down**. So countermodels here carry the rival's name — `nppReading`,
`tridentineReading`, `criticalReading` — and a reader can inspect what the
opposing position actually commits to.

### There is no atom budget

An earlier version decided entailment by exhaustive truth table, which cost
`2^n` and forced a twelve-atom cap on every argument. Both are gone. An
argument tracing a theme across the canon may use as many atoms as it needs.

### What was rejected, and why

**`bv_decide`**, Lean's SAT-solver tactic, is fast and unusable here. It emits
a per-theorem native axiom:

```
'bvtest' depends on axioms: [propext, Classical.choice, Quot.sound,
                             bvtest._native.bv_decide.ax_1_5]
```

That is an external solver's certificate entering the trust base. For a library
whose claim is that every assumption is declared, it is not a trade worth
making, and `axiom-audit` would reject it.

**Foundation's proof calculi** supply soundness and completeness metatheorems
for the Tait calculus, but no executable decision procedure, so they cannot
discharge a goal.

**A hand-rolled pruning search** was written and then deleted once `tauto`
proved to handle the same goals with less machinery and no new proof
obligations.

## Writing an argument

An argument module has five parts.

**1. An atom type**, one constructor per atomic claim, each documented with
what it asserts:

```lean
inductive Claim
  /-- Romans 3:28 teaches justification by faith apart from works of the law. -/
  | romans3_28
  /-- Paul's ἔργα νόμου denotes human works in general. **The disputed
  premise.** -/
  | worksOfLawMeansWorksGenerally
  ...
deriving DecidableEq, Repr
```

**2. A total citation function.** Because it is total, an uncited atom does not
compile:

```lean
def cite : Claim → AtomMeta
  | .romans3_28 =>
    { label := "Romans 3:28 teaches justification by faith apart from works of the law"
    , kind := .textual
    , source := { primary := .scripture [{ ref := .verse ⟨.romans, 3, 28⟩ }]
                , supporting := [.work calvinInstitutes (.sectionRef "III.xi.19")]
                , tradition := .reformedProtestant
                , confidence := .wellSupported } }
  ...
```

**3. Packages — rivals first.** Writing the rival before proving anything keeps
the encoding honest; it is much easier to build a strawman after you have a
proof you like.

**4. Theorems**, tagged `@[headline]` and followed by `#print axioms`. To
establish, unfold the package and call `tauto`:

```lean
@[headline]
theorem reformed_establishes : Establishes reformed := by
  intro w hw
  simp only [reformed, sharedPremises, paulineToFaithAlone, conjOf, p,
    List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
    FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto
```

To refute, name the rival's reading and check it:

```lean
def tridentineReading : Valuation Claim := fun a =>
  match a with
  | .salvationByGraceThroughFaithNotWorks => False
  | _ => True

@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  refine not_entails_of_countermodel tridentineReading ?_ ?_ <;>
    simp [tridentine, conjOf, p, notP,
      FFL.Propositional.Formula.Boolean.val, tridentineReading]
```

Qualify `FFL.Propositional.Formula.Boolean.val` in full: `Formula` is also an
abbreviation in `Testimony.Logic`, and the unqualified name resolves there.

**5. The load-bearing results**, where there is a disputed premise. State the
reduced package explicitly:

```lean
def reformedWithoutWorksOfLaw : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the Pauline lexical premise"
    premises := [ ... everything except the disputed premise ... ] }
```

Then ask whether the argument survives. Where an argument has **two independent
strands**, as sola fide does, neither disputed premise is load-bearing alone —
only their disjunction is, and that is the more interesting result.

## Manifests

Generated from the premises, never maintained beside them:

```lean
def ArgumentPackage.manifest           : List AtomMeta
def ArgumentPackage.scriptureOnlyAtoms : List AtomMeta
```

`manifest` is every atom the premises rest on, deduplicated and mapped through
`cite`. `scriptureOnlyAtoms` filters it to those appealing to Scripture with no
scholarly support — the circularity surface described in
[Scope and limits](./scope-and-limits.md#circularity-specifically).
