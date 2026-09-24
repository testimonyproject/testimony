import Testimony.Logic.Notation
import Mathlib.Tactic.Tauto

/-!
# Testimony.Logic.Entail — entailment, and how it is established or refuted

An earlier version of this module decided entailment by truth table, which cost
`2^n` for `n` atoms and forced a twelve-atom budget on every argument. That
ceiling was too low: an argument tracing a theme across the canon wants far
more atoms than that, and the exponent does not care how simple the argument
is.

Two standard tools replace it, and neither enumerates valuations.

**To establish**: backward chaining over the premises read as Horn clauses —
SLD resolution, as Lean's `solve_by_elim` — which is what `establish` in
`Testimony.Logic.Tactic` runs. Its cost grows with the length of the chain of
inference, not with the number of atoms or of steps, and it produces an
ordinary proof term, so the trust base is unchanged. Mathlib's `tauto`, which
this replaced, case-splits on every implication and is kept only for the
non-Horn case, as `establish_by_search`.

**To refute**: exhibit a countermodel. `not_entails_of_countermodel` turns a
valuation satisfying every premise while falsifying the conclusion into a
refutation, and checking a named valuation is linear rather than exponential.

The second is also better documentation. "A countermodel exists" tells a reader
nothing; a named valuation *is* the rival's reading, written down — which is
why countermodels in this library carry the rival's name.

A note on what was rejected: Lean's `bv_decide` calls an external SAT solver
and adds a per-theorem `_native.bv_decide.ax` axiom to the trust base. For a
library whose claim is that every assumption is declared, that is not a
trade worth making, and `axiom-audit` would reject it.
-/

namespace Testimony.Logic

open FFL FFL.Propositional

variable {α : Type}

/-- A premise list, as the *set* Foundation's consequence relation takes.

Two shapes, and the library needs both. A premise **set** is what entailment is
about: consequence does not care what order the premises come in or whether one
was written twice, and Foundation states it over `Set F` accordingly. A premise
**list** is what a package can be read off — `ArgumentPackage.manifest` is
*computed* by walking `premises` and citing each atom it meets, and `Set F` is
`F → Prop`, which cannot be walked. The generated assumption manifest, the atom
legend and the numbered derivation on every argument page all exist because the
premises are a list.

So the field stays a list and the relation is Foundation's, with this the one
step between them. -/
def premiseSet (prems : List (Formula α)) : Set (Formula α) := {φ | φ ∈ prems}

@[simp] theorem mem_premiseSet {prems : List (Formula α)} {φ : Formula α} :
    φ ∈ premiseSet prems ↔ φ ∈ prems := Iff.rfl

/-- A valuation models the premise set exactly when it satisfies every premise
in the list. The bridge between Foundation's `⊧*` and the `∀ φ ∈ prems` form
every result in this library is stated in. -/
@[simp] theorem modelsSet_premiseSet_iff {w : Valuation α} {prems : List (Formula α)} :
    w ⊧* premiseSet prems ↔ ∀ φ ∈ prems, w ⊧ φ :=
  ⟨fun h φ hφ => h.models_set hφ, fun h => ⟨fun _ hφ => h _ hφ⟩⟩

/-- Semantic entailment: every valuation satisfying all the premises satisfies
the conclusion.

This **is** Foundation's logical consequence, `T ⊨[M] φ`, over the Boolean
valuations — not a reimplementation of it. The library used to spell the
quantifier out by hand, which meant re-proving facts Foundation already has:
monotonicity, the relation to satisfiability, compactness. Borrowing the
definition rather than the shape is what makes those available here, and it is
the reason `entails_of_subset` below is three words long. -/
def Entails (prems : List (Formula α)) (concl : Formula α) : Prop :=
  premiseSet prems ⊨[Valuation α] concl

/-- Entailment in the shape the rest of the library states it in: quantify over
valuations, assume every premise, conclude.

`Entails` is Foundation's consequence relation over a set; this says the same
thing over the list, and is what the proof tactics and every result below are
written against.

A *proved* equivalence, not a definitional one — `Iff.rfl` will not close it.
Only `premiseSet` membership is definitional; Foundation's `⊧*` is a class with
a field, so reaching the `∀ φ ∈ prems` form goes through
`modelsSet_premiseSet_iff`. Nothing is lost crossing it, but it costs a
rewrite rather than nothing. -/
theorem entails_iff {prems : List (Formula α)} {concl : Formula α} :
    Entails prems concl ↔ ∀ w : Valuation α, (∀ φ ∈ prems, w ⊧ φ) → w ⊧ concl :=
  ⟨fun h w hw => h (modelsSet_premiseSet_iff.mpr hw),
   fun h _ hw => h _ (modelsSet_premiseSet_iff.mp hw)⟩

/-- A countermodel refutes an entailment.

`w` is a valuation on which every premise holds and the conclusion fails, so
the premises cannot entail the conclusion. This is how every `¬ Establishes`
result in the library is proved: not by failing to find a proof, but by naming
the reading on which the argument does not go through. -/
theorem not_entails_of_countermodel {prems : List (Formula α)} {concl : Formula α}
    (w : Valuation α)
    (hsat : ∀ φ ∈ prems, w ⊧ φ)
    (hfail : ¬ w ⊧ concl) : ¬ Entails prems concl :=
  fun h => hfail (entails_iff.mp h w hsat)

/-- A premise set is *satisfiable* when some valuation makes every premise
true — when the position it encodes describes a possible way for things to be.

This is not a technicality. `Entails` quantifies over the valuations satisfying
the premises, so a premise set with **no** model entails everything vacuously,
including the negation of what its own author intended. A package assembled
from contradictory premises would therefore `Establishes` its conclusion, the
proof would close, and all four gates would pass — a claim that is true only
because nothing could make its assumptions hold at once. -/
def Satisfiable (prems : List (Formula α)) : Prop :=
  Semantics.Satisfiable (Valuation α) (premiseSet prems)

/-- Satisfiability in the shape the library states it in, as `entails_iff` is
for entailment. -/
theorem satisfiable_iff {prems : List (Formula α)} :
    Satisfiable prems ↔ ∃ w : Valuation α, ∀ φ ∈ prems, w ⊧ φ :=
  ⟨fun ⟨w, hw⟩ => ⟨w, modelsSet_premiseSet_iff.mp hw⟩,
   fun ⟨w, hw⟩ => ⟨w, modelsSet_premiseSet_iff.mpr hw⟩⟩

/-- A valuation satisfying every premise witnesses satisfiability. This is how
every `Satisfiable` result in the library is proved: by naming the reading on
which the position holds together — its own world, rather than a rival's. -/
theorem satisfiable_of_model {prems : List (Formula α)}
    (w : Valuation α) (hsat : ∀ φ ∈ prems, w ⊧ φ) :
    Satisfiable prems :=
  satisfiable_iff.mpr ⟨w, hsat⟩

/-- **The hazard, as a theorem.** An unsatisfiable premise set entails
everything, so an `Establishes` result over one says nothing at all.

Stated here rather than left as a remark, because it is the one way a result in
this library can be simultaneously proved, axiom-clean and worthless. -/
theorem entails_of_unsatisfiable {prems : List (Formula α)}
    (h : ¬ Satisfiable prems) (concl : Formula α) : Entails prems concl :=
  entails_iff.mpr fun w hw => absurd (satisfiable_iff.mpr ⟨w, hw⟩) h

/-- A proposition is *independent* of a premise set when the set entails
neither it nor its negation — when the premises settle the question neither
way.

The term is Foundation's. `Foundation/Logic/Entailment.lean` defines
`Independent φ` as `𝓢 ⊬ φ ∧ 𝓢 ⊬ ∼φ`, and this is the same notion, in the same
notation, over the entailment this library actually uses — `∼` here is
Foundation's own, which `Formula α` carries through its `LogicalConnective`
instance. It is a counterpart rather than an
instance, deliberately: Foundation's is *proof-theoretic*, built on `Prf : S →
F → Type*`, so instantiating it would mean declaring `Prf prems φ := PLift
(Entails prems φ)` — wrapping a semantics in an interface meant for
derivations, to borrow a definition. It would also misdescribe the method.
Nothing here is refuted by a failed proof search; every refutation is a named
countermodel, which is why `refute_with` takes an identifier. Borrow the
vocabulary, not the plumbing.

**Why the library needs it.** A *parity reply* — concede the objection's point
and deny that it discriminates, *yes, that is circular, so is yours* — was
being recorded as two results each time: one that it blocks the objection, one
that it establishes nothing. Those are not two facts about the reply. They are
one fact, stated twice, and stating it twice is what let a pair through in
which the two halves were about different propositions. Named once, the shape
is checkable. -/
def Independent (prems : List (Formula α)) (φ : Formula α) : Prop :=
  ¬ Entails prems φ ∧ ¬ Entails prems (∼φ)

/-- Two countermodels establish independence: a reading of the premises on
which the proposition fails, and a reading of the same premises on which it
holds.

Both are named, for the reason `not_entails_of_countermodel` is proved from a
named valuation rather than an existence claim — a countermodel *is* a reading,
and a parity reply leaves exactly two of them available. `wf` is the reading on
which the proposition does not hold; `wt` is the reading on which it does. -/
theorem independent_of_countermodels {prems : List (Formula α)} {φ : Formula α}
    (wf wt : Valuation α)
    (hfsat : ∀ ψ ∈ prems, wf ⊧ ψ)
    (hfail : ¬ wf ⊧ φ)
    (htsat : ∀ ψ ∈ prems, wt ⊧ ψ)
    (hhold : wt ⊧ φ) :
    Independent prems φ :=
  ⟨not_entails_of_countermodel wf hfsat hfail,
   not_entails_of_countermodel wt htsat fun h => h hhold⟩

/-- **An independence result needs no separate satisfiability witness.** A
premise set that settles nothing about some proposition has a model already:
an unsatisfiable set entails everything, including the proposition and its
negation.

This is why rule L11 asks for a model only of the packages carrying a positive
`Establishes` result. Stated as a theorem rather than left as a remark in the
linter, because the exemption is a fact about entailment and not a convention
about checking. -/
theorem satisfiable_of_independent {prems : List (Formula α)} {φ : Formula α}
    (h : Independent prems φ) : Satisfiable prems := by
  by_contra hns
  exact h.1 (entails_of_unsatisfiable hns φ)

/-- Entailment is monotone in the premises: adding premises cannot destroy an
entailment. Foundation's `weakening`, at this library's premise lists. -/
theorem entails_of_subset {prems prems' : List (Formula α)} {concl : Formula α}
    (hsub : ∀ φ ∈ prems, φ ∈ prems') (h : Entails prems concl) : Entails prems' concl :=
  Semantics.weakening h fun _ hφ => hsub _ hφ

/-- A premise is entailed by the set it belongs to. Foundation's `of_mem`.

Trivial as a fact and not as a result: it is what a reply *conceding* the
charge it answers amounts to, and `circle_parity_concedes_the_charge` is
exactly this shape — Barrett's parity grounds entail the circularity because
the circularity is one of them. -/
theorem entails_of_mem {prems : List (Formula α)} {concl : Formula α}
    (h : concl ∈ prems) : Entails prems concl :=
  Semantics.of_mem (by simpa using h)

/-! ### Sanity checks

Small hand-worked cases pinning both directions, so a change to the semantics
or the tactic recipe fails here rather than inside an argument. -/

/-- Two atoms, for the checks below. -/
inductive Pair
  /-- First test atom. -/
  | p
  /-- Second test atom. -/
  | q
deriving DecidableEq, Repr

/-- Modus ponens is valid. -/
theorem modus_ponens_valid :
    Entails (α := Pair) [.atom .p, .atom .p ➝ .atom .q] (.atom .q) := by
  refine entails_iff.mpr ?_
  intro w hw
  simp only [List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
    FFL.Semantics.Imp.models_imply,
    FFL.Propositional.Formula.Boolean.models_atom] at hw ⊢
  tauto

/-- Affirming the consequent is not valid, and here is why: the reading on
which `q` holds and `p` does not. -/
theorem affirming_consequent_invalid :
    ¬ Entails (α := Pair) [.atom .q, .atom .p ➝ .atom .q] (.atom .p) := by
  refine not_entails_of_countermodel (fun a => a = Pair.q) ?_ ?_ <;> simp

/-- And `p` is independent of those premises, not merely unentailed by them:
the reading above leaves `p` false, and the reading on which both atoms hold
leaves it true, while both satisfy every premise. -/
theorem p_independent_of_affirming_the_consequent :
    Independent (α := Pair) [.atom .q, .atom .p ➝ .atom .q] (.atom .p) := by
  refine independent_of_countermodels (fun a => a = Pair.q) (fun _ => True) ?_ ?_ ?_ ?_ <;>
    simp

end Testimony.Logic
