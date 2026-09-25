import Testimony.Logic.Framework
import Mathlib.Data.List.Sublists

/-!
# Testimony.Logic.Solver — deciding what survives a finite dispute

`Testimony.Logic.Framework` defines what survives a dispute — the grounded
extension, the preferred extensions, sceptical and credulous acceptance — over
any relation. Proving a verdict for a particular dispute used to mean reasoning
about sets by hand: iterating the characteristic function, exhibiting an
admissible set and showing nothing larger is one, splitting on every party that
might defend the one in question. Each proof was written for one table, and
redone when a party joined.

A dispute in this library has finitely many parties, listed, and its defeat
table is decided (`Testimony.Logic.Horn`). So every verdict is a finite
computation, and this module does it — with the checks proved correct once,
against the framework's own definitions:

- **Conflict-freeness, defence and admissibility** of a listed set are decided
  exactly (`admissible?_iff`).
- **The grounded extension** is computed by iterating what the set defends from
  nothing, and returned only once it is checked to defend nothing more
  (`grounded_eq`).
- **Preferred extensions, and acceptance**, by enumerating every set of parties.
  Any set of parties at all — including one a theorem quantifies over — is one
  of the listed ones (`exists_sublist`), so a property checked of every listed
  set holds of every set. `preferred_eq`, `skeptically_accepted`,
  `not_skeptically_accepted`, `credulously_accepted`, `not_credulously_accepted`
  and `not_mem_admissible` turn a check into the statement `Framework` makes.

## What the enumeration costs, and what it need not

Enumeration is exponential in the number of parties: 256 sets for eight, a
small computation for the kernel. Some exponential cost is unavoidable
in the worst case. The grounded extension is computed in polynomial time, but
deciding whether a party belongs to *some* preferred extension is NP-complete,
and deciding whether a set *is* preferred is coNP-complete (Dimopoulos and
Torres, "Graph theoretical structures in logic programs and default theories",
*Theoretical Computer Science* 170, 1996); deciding whether a party belongs to
*every* preferred extension is Π₂ᵖ-complete (Dunne and Bench-Capon, "Coherence
in finite argument systems", *Artificial Intelligence* 141, 2002). The hard
instances are single tangles of mutual attack.

The worst case is not the typical one. Preferred semantics decomposes along the
strongly connected components of the defeat graph: each component is decided in
turn, given the components that attack it (Baroni, Giacomin and Guida,
"SCC-recursiveness: a general schema for argumentation semantics", *Artificial
Intelligence* 168, 2005), so the cost is exponential only in the largest
component. Some graphs are easy outright — an acyclic one has the grounded
extension as its only preferred extension, and acceptance is tractable on
bipartite graphs and graphs of bounded treewidth (Dunne, "Computational
properties of argument systems satisfying graph-theoretic constraints",
*Artificial Intelligence* 171, 2007). The disputes here are mostly mutual
defeats in small components, so whole-set enumeration is adequate at their
size; decomposing by component is the route when a dispute outgrows it.
-/

namespace Testimony.Logic.Solver

open Framework

variable {ι : Type}

/-- A finite dispute's relation, in a form the kernel can compute with: every
party listed, and who defeats whom as a Boolean agreeing with the relation. -/
structure Finite (R : ι → ι → Prop) where
  /-- Every party. -/
  parties : List ι
  /-- None is left out. -/
  complete : ∀ i, i ∈ parties
  /-- Who defeats whom, computed. -/
  defeats : ι → ι → Bool
  /-- The computation agrees with the relation. -/
  spec : ∀ i j, R i j ↔ defeats i j = true

/-- The members of a list, as a set. -/
def toSet (s : List ι) : Set ι := {x | x ∈ s}

@[simp] theorem mem_toSet {s : List ι} {x : ι} : x ∈ toSet s ↔ x ∈ s := Iff.rfl

variable {R : ι → ι → Prop} (F : Finite R)

/-! ### Sets of parties -/

/-- No member of `s` defeats a member of `s`. -/
def conflictFree? (s : List ι) : Bool := s.all fun a => s.all fun b => !F.defeats a b

/-- `s` defends `a`: every party defeating `a` is defeated from inside `s`. -/
def defends? (s : List ι) (a : ι) : Bool :=
  F.parties.all fun b => !F.defeats b a || s.any fun c => F.defeats c b

/-- Conflict-free, and defending each of its own members. -/
def admissible? (s : List ι) : Bool := conflictFree? F s && s.all (defends? F s)

variable {F}

theorem conflictFree?_iff {s : List ι} :
    conflictFree? F s = true ↔ ConflictFree R (toSet s) := by
  simp only [conflictFree?, List.all_eq_true, Bool.not_eq_eq_eq_not, Bool.not_true,
    ConflictFree, mem_toSet, F.spec]
  exact ⟨fun h a ha b hb hab => by simp [h a ha b hb] at hab,
    fun h a ha b hb => by simpa using h a ha b hb⟩

theorem defends?_iff {s : List ι} {a : ι} :
    defends? F s a = true ↔ Defends R (toSet s) a := by
  simp only [defends?, List.all_eq_true, Bool.or_eq_true, Bool.not_eq_eq_eq_not, Bool.not_true,
    List.any_eq_true, Defends, mem_toSet, F.spec]
  constructor
  · intro h b hb
    rcases h b (F.complete b) with h | h
    · simp [h] at hb
    · exact h
  · intro h b _
    by_cases hb : F.defeats b a = true
    · exact .inr (h b hb)
    · exact .inl (by simpa using hb)

/-- **Admissibility is decided exactly.** -/
theorem admissible?_iff {s : List ι} : admissible? F s = true ↔ Admissible R (toSet s) := by
  simp only [admissible?, Bool.and_eq_true, List.all_eq_true, conflictFree?_iff, defends?_iff,
    Admissible, mem_toSet]

/-- Every set of parties is the set of some sublist of the parties: the parties,
filtered by membership. This is what lets a check over the finitely many
sublists speak for every set. -/
theorem exists_sublist (F : Finite R) (T : Set ι) : ∃ t ∈ F.parties.sublists, toSet t = T := by
  classical
  refine ⟨F.parties.filter (fun x => decide (x ∈ T)), List.mem_sublists.mpr (List.filter_sublist),
    ?_⟩
  ext x
  simp [F.complete x]

/-! ### The grounded extension -/

variable (F)

/-- What a set defends, as a list: one application of the characteristic
function. -/
def step (s : List ι) : List ι := F.parties.filter (defends? F s)

/-- The characteristic function iterated from nothing, once per party and once
more. -/
def groundedList : List ι := (step F)^[F.parties.length + 1] []

variable {F}

theorem toSet_step (s : List ι) : toSet (step F s) = characteristic R (toSet s) := by
  ext x
  simp only [step, mem_toSet, List.mem_filter, F.complete x, true_and, defends?_iff]
  rfl

theorem toSet_iterate (k : ℕ) : toSet ((step F)^[k] []) = (characteristic R)^[k] ∅ := by
  induction k with
  | zero => ext x; simp [toSet]
  | succ k ih =>
    rw [Function.iterate_succ_apply', Function.iterate_succ_apply', toSet_step, ih]

variable [DecidableEq ι]

/-- **The grounded extension, computed.** If the iterate defends nothing it does
not already hold, and has exactly the members of `target`, the grounded
extension is `target`. -/
theorem grounded_eq (target : List ι)
    (h : ((step F (groundedList F)).all fun x => (groundedList F).elem x) &&
      ((groundedList F).all fun x => target.elem x) &&
      (target.all fun x => (groundedList F).elem x) = true) :
    grounded R = toSet target := by
  simp only [Bool.and_eq_true, List.all_eq_true, List.elem_eq_mem, decide_eq_true_eq] at h
  obtain ⟨⟨hstable, hsub⟩, hsup⟩ := h
  have : toSet (groundedList F) = toSet target := by
    ext x; exact ⟨hsub x, hsup x⟩
  rw [← this]
  refine grounded_eq_of_iterate (F.parties.length + 1) (toSet_iterate _).symm ?_
  rw [← toSet_step]
  exact fun x hx => hstable x hx

/-- **A member of the grounded extension, computed**: the iterate holds `a`. No
stability check is needed — every iterate lies inside the grounded extension. -/
theorem mem_grounded {a : ι} (h : (groundedList F).elem a = true) : a ∈ grounded R := by
  have : a ∈ toSet (groundedList F) := by simpa using h
  rw [groundedList, toSet_iterate] at this
  exact iterate_subset_grounded _ this

/-! ### Preferred extensions and acceptance -/

variable (F)

omit [DecidableEq ι] in
/-- Every admissible set of parties. -/
def admissibleSets : List (List ι) := F.parties.sublists.filter (admissible? F)

/-- The admissible sets that no admissible set strictly contains: the preferred
extensions. -/
def preferredSets : List (List ι) :=
  (admissibleSets F).filter fun s =>
    (admissibleSets F).all fun t => !(s.all (t.elem ·)) || t.all (s.elem ·)

variable {F}

omit [DecidableEq ι] in
theorem mem_admissibleSets {s : List ι} :
    s ∈ admissibleSets F ↔ s ∈ F.parties.sublists ∧ Admissible R (toSet s) := by
  simp [admissibleSets, admissible?_iff]

omit [DecidableEq ι] in
/-- Every admissible set is one the enumeration finds. -/
theorem exists_admissibleSets {T : Set ι} (hT : Admissible R T) :
    ∃ t ∈ admissibleSets F, toSet t = T := by
  obtain ⟨t, ht, rfl⟩ := exists_sublist F T
  exact ⟨t, mem_admissibleSets.mpr ⟨ht, hT⟩, rfl⟩

/-- **A preferred extension, computed.** -/
theorem preferred_of_mem {s : List ι} (h : s ∈ preferredSets F) : Preferred R (toSet s) := by
  simp only [preferredSets, List.mem_filter, List.all_eq_true] at h
  obtain ⟨hs, hmax⟩ := h
  refine ⟨(mem_admissibleSets.mp hs).2, fun T hT hsT => ?_⟩
  obtain ⟨t, ht, rfl⟩ := exists_admissibleSets (F := F) hT
  have := hmax t ht
  simp only [Bool.or_eq_true, Bool.not_eq_eq_eq_not, Bool.not_true, List.all_eq_false,
    List.all_eq_true, List.elem_eq_mem, decide_eq_true_eq] at this
  rcases this with ⟨x, hx, hxt⟩ | h
  · exact absurd (hsT hx) (by simpa using hxt)
  · exact fun x hx => h x hx

/-- Every preferred extension is one the enumeration finds. -/
theorem exists_preferredSets {T : Set ι} (hT : Preferred R T) :
    ∃ t ∈ preferredSets F, toSet t = T := by
  obtain ⟨t, ht, rfl⟩ := exists_admissibleSets (F := F) hT.1
  refine ⟨t, List.mem_filter.mpr ⟨ht, List.all_eq_true.mpr fun u hu => ?_⟩, rfl⟩
  simp only [Bool.or_eq_true, Bool.not_eq_eq_eq_not, Bool.not_true, List.all_eq_false,
    List.all_eq_true, List.elem_eq_mem, decide_eq_true_eq]
  by_cases hsub : ∀ x ∈ t, x ∈ u
  · exact .inr fun x hx => hT.2 (mem_admissibleSets.mp hu).2 (fun y hy => hsub y hy) hx
  · push Not at hsub
    obtain ⟨x, hx, hxu⟩ := hsub
    exact .inl ⟨x, hx, by simpa using hxu⟩

/-- **Sceptical acceptance, computed**: every preferred extension contains `a`. -/
theorem skeptically_accepted {a : ι} (h : (preferredSets F).all (·.elem a) = true) :
    SkepticallyAccepted R a := by
  intro T hT
  obtain ⟨t, ht, rfl⟩ := exists_preferredSets (F := F) hT
  simpa using List.all_eq_true.mp h t ht

/-- **Not sceptically accepted**: some preferred extension leaves `a` out. -/
theorem not_skeptically_accepted {a : ι} (h : (preferredSets F).any (!·.elem a) = true) :
    ¬ SkepticallyAccepted R a := by
  obtain ⟨s, hs, ha⟩ := List.any_eq_true.mp h
  exact fun hsk => (by simpa using ha : a ∉ s) (hsk _ (preferred_of_mem hs))

/-- **Credulous acceptance, computed**: some preferred extension contains `a`. -/
theorem credulously_accepted {a : ι} (h : (preferredSets F).any (·.elem a) = true) :
    CredulouslyAccepted R a := by
  obtain ⟨s, hs, ha⟩ := List.any_eq_true.mp h
  exact ⟨toSet s, preferred_of_mem hs, by simpa using ha⟩

/-- **No resolution accepts `a`**: no preferred extension contains it. -/
theorem not_credulously_accepted {a : ι} (h : (preferredSets F).all (!·.elem a) = true) :
    ¬ CredulouslyAccepted R a := by
  rintro ⟨T, hT, ha⟩
  obtain ⟨t, ht, rfl⟩ := exists_preferredSets (F := F) hT
  exact (by simpa using List.all_eq_true.mp h t ht : a ∉ t) ha

/-- **`a` cannot be defended**: no admissible set contains it. -/
theorem not_mem_admissible {a : ι} (h : (admissibleSets F).all (!·.elem a) = true)
    (S : Set ι) (hS : Admissible R S) : a ∉ S := by
  obtain ⟨t, ht, rfl⟩ := exists_admissibleSets (F := F) hS
  simpa using List.all_eq_true.mp h t ht

/-- **A preferred extension, named**: the enumeration finds exactly `target`. -/
theorem preferred_eq {target : List ι}
    (h : (preferredSets F).any (fun s => s.all (target.elem ·) && target.all (s.elem ·)) = true) :
    Preferred R (toSet target) := by
  obtain ⟨s, hs, hst⟩ := List.any_eq_true.mp h
  simp only [Bool.and_eq_true, List.all_eq_true, List.elem_eq_mem, decide_eq_true_eq] at hst
  have : toSet s = toSet target := by ext x; exact ⟨hst.1 x, hst.2 x⟩
  exact this ▸ preferred_of_mem hs

/-! ### Hearings -/

/-- The dispute among the parties satisfying `P` only, in solver form. -/
def Finite.restrict (F : Finite R) (P : ι → Prop) [DecidablePred P] :
    Finite (fun i j : {x // P x} => R i.1 j.1) where
  parties := F.parties.filterMap fun i => if h : P i then some ⟨i, h⟩ else none
  complete i := List.mem_filterMap.mpr ⟨i.1, F.complete i.1, by simp [i.2]⟩
  defeats i j := F.defeats i.1 j.1
  spec i j := F.spec i.1 j.1

end Testimony.Logic.Solver
