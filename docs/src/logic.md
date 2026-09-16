# Encoding arguments

## Why there is an adapter

Foundation's Boolean semantics uses `Prop`-valued valuations:

```lean
abbrev Boolean.Valuation (α : Type*) := α → Prop
def val (v : Valuation α) : Formula α → Prop
```

That is the right definition for metatheory — soundness and completeness proofs
quantify over arbitrary valuations — and the wrong one for deciding whether a
particular argument is valid. Entailment against `Prop`-valued valuations is
not decidable, so `by decide` is unavailable.

`Testimony.Logic` therefore adds a `Bool`-valued mirror and proves it agrees:

```lean
def bval (v : α → Bool) : Formula α → Bool

theorem bval_iff_val (v : α → Bool) (φ : Formula α) :
    bval v φ = true ↔ Formula.Boolean.val (fun a => v a = true) φ
```

with a finite atom enumeration and a truth-table check over it:

```lean
class FiniteAtoms (α : Type) where
  elems    : List α
  complete : ∀ a : α, a ∈ elems

def checkEntails [DecidableEq α] [FiniteAtoms α]
    (prems : List (Formula α)) (concl : Formula α) : Bool
```

Two bridge theorems connect the computation to the semantics:

```lean
theorem entails_of_check     : checkEntails prems concl = true  →   Entails prems concl
theorem not_entails_of_check : checkEntails prems concl = false → ¬ Entails prems concl
```

The second is why the adapter exists. Without it, "these premises do not
establish that conclusion" would require constructing a countermodel by hand
for every rival package. With it, the countermodel falls out of the failing
check, and rival packages become mechanically comparable.

Going from `Bool`-valued enumeration to arbitrary `Prop`-valued valuations uses
classical choice. Both `Classical.choice` and `propext` are inside the
[axiom allowlist](./scope-and-limits.md#the-trust-base), so this does not widen
the declared trust base.

## The atom budget

`checkEntails` enumerates `2^n` valuations, so **an atom type carries at most
twelve constructors** — 4096 valuations, which the kernel handles in seconds.
Proofs need `set_option maxRecDepth 20000` (40000 for ten or more atoms).

Exceeding the budget is a signal to decompose the argument. It is never a
reason to reach for `native_decide`, which is prohibited and which the axiom
audit would reject anyway. Rule L5 of the [domain linter](./style-guide.md)
enforces the budget.

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

instance : FiniteAtoms Claim where
  elems := [...]
  complete a := by cases a <;> simp
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

**4. Theorems**, tagged `@[headline]` and followed by `#print axioms`:

```lean
@[headline]
theorem reformed_establishes : Establishes reformed := by
  apply entails_of_check
  decide

#print axioms reformed_establishes
```

**5. The load-bearing result**, where there is a disputed premise. State the
reduced package explicitly rather than filtering a premise out of an existing
one: `List.filter` over a derived `DecidableEq (Formula α)` does not reduce in
the kernel, so a `decide` proof built on it fails and falls back to `sorryAx`.

```lean
def reformedWithoutLexicalPremise : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the lexical premise"
    premises := [ ... everything except the disputed premise ... ] }

@[headline]
theorem worksOfLaw_is_load_bearing : ¬ Establishes reformedWithoutLexicalPremise := by
  apply not_entails_of_check
  decide
```

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
