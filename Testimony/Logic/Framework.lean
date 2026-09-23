import Mathlib.Order.FixedPoints
import Mathlib.Order.Zorn

/-!
# Testimony.Logic.Framework — which positions survive a dispute

Everything below the argument layer asks one question of one package: do these
premises entail that conclusion? A dispute asks a different question of several
packages at once. *Given who defeats whom, which positions can be held together,
and which can be defended against every attacker?*

That is Dung's question, and this module answers it the way Dung did (*On the
acceptability of arguments and its fundamental role in nonmonotonic reasoning,
logic programming and n-person games*, 1995). Arguments are nodes; a relation
`R` says which node defeats which; and a **semantics** picks out the sets of
nodes that survive together. Nothing here knows what a node is. The next module
up, `Testimony.Logic.Dispute`, makes the nodes argument packages and derives the
relation from entailment; this one is the abstract layer it sits on.

## The definitions, in the order a reader needs them

- A set is **conflict-free** when none of its members defeats another. Holding a
  set of positions together requires at least this much.
- A set **defends** a node when every defeater of that node is itself defeated
  by something in the set. This is the dialectical idea at the centre: a
  position is not safe because nothing attacks it, but because every attack on
  it is answered.
- A set is **admissible** when it is conflict-free and defends each of its
  members: a position that can stand up for itself.
- A set is **complete** when it is admissible and contains everything it
  defends — it does not leave on the table what it has already secured.
- The **grounded** extension is the least complete set: what survives if one
  admits only what is forced. It is sceptical — a standoff leaves both sides out.
- A **preferred** extension is a maximal admissible set: one internally
  defensible position, as large as it can be made. A dispute can have several,
  and when it does, each is a way the dispute can be resolved.

## What this module proves, and what it borrows

The grounded extension is *defined* as the least fixed point of the
characteristic function `S ↦ {a | S defends a}`, which is monotone on sets.
Existence, uniqueness and leastness of that fixed point are Mathlib's
Knaster–Tarski theorem, through `OrderHom.lfp`, not anything written here.
Existence of preferred extensions is Mathlib's Zorn's lemma
(`zorn_subset_nonempty`).

What *is* written here is Dung's fundamental lemma — an admissible set can take
on anything it defends — and the three results built on it: every preferred
extension is complete, the grounded extension is conflict-free and complete, and
it lies inside every complete extension. These are the textbook theorems, and
they are proved rather than assumed. The definitions they rest on are the trusted
part, and they are Dung's, clause for clause.

## Why not stop at entailment

Classical consequence is monotonic: adding a premise never destroys an
entailment. A reply therefore cannot be encoded as the objection's premises plus
something more; `Line.onGrounds` encodes it by taking a ground away instead.
That is correct for a reply that *refuses* a ground, and it is how the library
encodes such replies. It cannot say that one argument **defeats** another, which
is what a reply that *contradicts* a ground does. The layer here can — and it is
non-monotonic where entailment is not: adding a node can remove another from the
grounded extension, which no premise can do to a proof.
-/

namespace Testimony.Logic.Framework

variable {ι : Type*} (R : ι → ι → Prop)

/-- No member of `S` defeats a member of `S`. -/
def ConflictFree (S : Set ι) : Prop :=
  ∀ a ∈ S, ∀ b ∈ S, ¬ R a b

/-- `S` defends `a`: every defeater of `a` is defeated by some member of `S`. -/
def Defends (S : Set ι) (a : ι) : Prop :=
  ∀ b, R b a → ∃ c ∈ S, R c b

/-- Conflict-free, and defending each of its own members. -/
def Admissible (S : Set ι) : Prop :=
  ConflictFree R S ∧ ∀ a ∈ S, Defends R S a

/-- Admissible, and containing everything it defends. -/
def Complete (S : Set ι) : Prop :=
  Admissible R S ∧ ∀ a, Defends R S a → a ∈ S

/-- A maximal admissible set. -/
def Preferred (S : Set ι) : Prop :=
  Maximal (Admissible R) S

/-- A larger set defends everything a smaller one does. -/
theorem Defends.mono {R : ι → ι → Prop} {S T : Set ι} {a : ι} (hST : S ⊆ T)
    (h : Defends R S a) : Defends R T a := fun b hb =>
  let ⟨c, hc, hcb⟩ := h b hb
  ⟨c, hST hc, hcb⟩

/-- The characteristic function: what a set defends. Monotone, which is what
makes a least fixed point exist. -/
def characteristic : Set ι →o Set ι where
  toFun S := {a | Defends R S a}
  monotone' _ _ hST _ h := h.mono hST

/-- **The grounded extension**: the least fixed point of `characteristic`. -/
def grounded : Set ι := (characteristic R).lfp

/-- Accepted on every way of resolving the dispute. -/
def SkepticallyAccepted (a : ι) : Prop :=
  ∀ S, Preferred R S → a ∈ S

/-- Accepted on at least one way of resolving the dispute. -/
def CredulouslyAccepted (a : ι) : Prop :=
  ∃ S, Preferred R S ∧ a ∈ S

variable {R}

/-- **Dung's fundamental lemma.** An admissible set can take on anything it
defends and stay admissible. -/
theorem Admissible.insert {S : Set ι} {a : ι} (hS : Admissible R S)
    (ha : Defends R S a) : Admissible R (insert a S) := by
  obtain ⟨hcf, hdef⟩ := hS
  -- Anything that defeats a member of `S` or `a` is defeated from inside `S`,
  -- and a member of `S` defeated from inside `S` is a conflict.
  have noAttackFromS : ∀ b ∈ S, ¬ R b a := fun b hb hba =>
    let ⟨c, hc, hcb⟩ := ha b hba
    hcf c hc b hb hcb
  have noAttackOnS : ∀ b ∈ S, ¬ R a b := fun b hb hab =>
    let ⟨c, hc, hca⟩ := hdef b hb a hab
    let ⟨d, hd, hdc⟩ := ha c hca
    hcf d hd c hc hdc
  -- And `a` cannot defeat itself: its defeater would be defeated from `S`.
  have noSelfAttack : ¬ R a a := fun haa =>
    let ⟨c, hc, hca⟩ := ha a haa
    noAttackFromS c hc hca
  refine ⟨?_, ?_⟩
  · intro x hx y hy hxy
    rcases Set.mem_insert_iff.mp hx with hxa | hxS <;>
      rcases Set.mem_insert_iff.mp hy with hya | hyS
    · subst hxa hya; exact noSelfAttack hxy
    · subst hxa; exact noAttackOnS y hyS hxy
    · subst hya; exact noAttackFromS x hxS hxy
    · exact hcf x hxS y hyS hxy
  · intro x hx
    rcases Set.mem_insert_iff.mp hx with hxa | hxS
    · subst hxa; exact ha.mono (Set.subset_insert _ _)
    · exact (hdef x hxS).mono (Set.subset_insert _ _)

/-- The empty set is admissible: it holds nothing, so it has nothing to defend. -/
theorem admissible_empty : Admissible R (∅ : Set ι) :=
  ⟨fun _ h => absurd h (Set.notMem_empty _), fun _ h => absurd h (Set.notMem_empty _)⟩

/-- Every admissible set extends to a preferred one. Zorn's lemma, from Mathlib;
what is proved here is only that a chain of admissible sets has an admissible
union. -/
theorem Admissible.exists_preferred {S : Set ι} (hS : Admissible R S) :
    ∃ P, S ⊆ P ∧ Preferred R P := by
  obtain ⟨P, hSP, hP⟩ := zorn_subset_nonempty {T | Admissible R T}
    (fun c hc hchain _ => by
      refine ⟨⋃₀ c, ⟨?_, ?_⟩, fun s hs => Set.subset_sUnion_of_mem hs⟩
      · -- Two members of the union come from comparable members of the chain.
        intro a ⟨A, hA, ha⟩ b ⟨B, hB, hb⟩ hab
        rcases hchain.total hA hB with hAB | hBA
        · exact (hc hB).1 a (hAB ha) b hb hab
        · exact (hc hA).1 a ha b (hBA hb) hab
      · intro a ⟨A, hA, ha⟩
        exact ((hc hA).2 a ha).mono (Set.subset_sUnion_of_mem hA))
    S hS
  exact ⟨P, hSP, hP⟩

/-- Every dispute has at least one preferred extension. -/
theorem exists_preferred : ∃ P, Preferred R P :=
  let ⟨P, _, hP⟩ := (admissible_empty (R := R)).exists_preferred
  ⟨P, hP⟩

/-- A complete set is a fixed point of the characteristic function. -/
theorem Complete.fixed {S : Set ι} (hS : Complete R S) : characteristic R S = S :=
  Set.ext fun a => ⟨hS.2 a, hS.1.2 a⟩

/-- **Every preferred extension is complete.** If it defended something it did
not contain, the fundamental lemma would make it larger and still admissible. -/
theorem Preferred.complete {S : Set ι} (hS : Preferred R S) : Complete R S :=
  ⟨hS.1, fun a ha => by
    have := hS.eq_of_subset (hS.1.insert ha) (Set.subset_insert a S)
    exact this ▸ Set.mem_insert a S⟩

/-- **The grounded extension lies inside every complete extension.** It is the
least fixed point, and a complete set is a fixed point. -/
theorem grounded_subset {S : Set ι} (hS : Complete R S) : grounded R ⊆ S :=
  OrderHom.lfp_le_fixed _ hS.fixed

/-- The grounded extension lies inside every preferred extension. -/
theorem grounded_subset_preferred {S : Set ι} (hS : Preferred R S) :
    grounded R ⊆ S :=
  grounded_subset hS.complete

/-- **The grounded extension is conflict-free** — it sits inside a preferred
extension, which is. -/
theorem grounded_conflictFree : ConflictFree R (grounded R) := by
  obtain ⟨P, hP⟩ := exists_preferred (R := R)
  intro a ha b hb
  exact hP.1.1 a (grounded_subset_preferred hP ha) b (grounded_subset_preferred hP hb)

/-- The grounded extension is exactly what it defends. -/
theorem characteristic_grounded : characteristic R (grounded R) = grounded R :=
  OrderHom.map_lfp _

/-- **The grounded extension is complete**, and by `grounded_subset` the least
complete set. -/
theorem grounded_complete : Complete R (grounded R) := by
  have hfix := characteristic_grounded (R := R)
  refine ⟨⟨grounded_conflictFree, fun a ha => ?_⟩, fun a ha => ?_⟩
  · rw [← hfix] at ha; exact ha
  · rw [← hfix]; exact ha

/-- What the grounded extension contains is accepted on every resolution. -/
theorem SkepticallyAccepted.of_grounded {a : ι} (ha : a ∈ grounded R) :
    SkepticallyAccepted R a := fun _ hS => grounded_subset_preferred hS ha

/-! ### Computing the grounded extension of a finite dispute

The definition is a least fixed point, which says what the grounded extension is
but not how to find it. Iterating the characteristic function from the empty set
finds it: each step adds what the previous step defends. When an iterate stops
growing, it is the least fixed point. -/

/-- Every iterate of the characteristic function from the empty set lies inside
the grounded extension. -/
theorem iterate_subset_grounded (n : ℕ) :
    (characteristic R)^[n] ∅ ⊆ grounded R := by
  induction n with
  | zero => exact Set.empty_subset _
  | succ n ih =>
    rw [Function.iterate_succ_apply']
    exact (OrderHom.map_le_lfp _ ih)

/-- **An iterate that no longer grows is the grounded extension.** This is how a
concrete dispute's grounded extension is proved: compute the iterates, and show
the last one defends nothing new. -/
theorem grounded_eq_of_iterate {S : Set ι} (n : ℕ)
    (hS : (characteristic R)^[n] ∅ = S) (hstable : characteristic R S ⊆ S) :
    grounded R = S :=
  le_antisymm (OrderHom.lfp_le _ hstable) (hS ▸ iterate_subset_grounded n)

/-- **When every position is defeated, nothing prevails.** Each has a defeater,
and the empty set answers none of them. -/
theorem grounded_eq_empty_of_attacked (h : ∀ a, ∃ b, R b a) : grounded R = ∅ :=
  grounded_eq_of_iterate 0 rfl fun a ha =>
    let ⟨b, hb⟩ := h a
    let ⟨c, hc, _⟩ := ha b hb
    absurd hc (Set.notMem_empty c)

/-- **A preferred extension, by exhibition.** An admissible set is maximal when
everything outside it is in conflict with something inside it — no larger set
could hold both and stay conflict-free. -/
theorem preferred_of_blocked {S : Set ι} (hS : Admissible R S)
    (hout : ∀ a ∉ S, ∃ b ∈ S, R a b ∨ R b a) : Preferred R S := by
  refine ⟨hS, fun T hT hST a ha => ?_⟩
  by_contra haS
  obtain ⟨b, hb, hab | hba⟩ := hout a haS
  · exact hT.1 a ha b (hST hb) hab
  · exact hT.1 b (hST hb) a ha hba

end Testimony.Logic.Framework
