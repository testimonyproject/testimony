import Testimony.Logic.Horn
import Testimony.Logic.Page

/-!
# Testimony.Logic.Because — why a position stands against a rival

The library proves facts one at a time: that a position follows from its
premises, that a rival does not, that a premise is load-bearing, that one
package defeats another. A reader who asks *why does this position stand
against that one?* has had to assemble the answer from separate theorems, and
nothing checked that the pieces were about the same proposition, the same
rival, or the same premises.

A `Because P R` is that answer as one checked object. It names a **crux** — one
of P's premises — and shows, with a proof for each claim:

- **P holds.** P's premises have a model and establish its conclusion.
- **Where the crux sits.** P's premises are `before ++ crux :: after`, so what
  follows is about this premise and no other.
- **The crux breaks the rival.** A **core** of R's premises cannot be held
  together with the crux (and any **granted** grounds of P that the break needs).
  The core is minimal: drop any one of its premises and the rest can be held
  with the crux. That is precisely where R breaks.
- **The crux, not the grounds, does it.** The core and the granted grounds can
  be held together without the crux.
- **The rival stands on its own.** R's premises have a model: it falls to the
  crux, not to itself.
- **What the crux does for P** (`CruxRole`): either P's conclusion does not
  follow without it — the crux is part of P's case — or it does, and the crux is
  P's *answer* to R, held for no other reason. Both are proved, not asserted,
  and the rendering says which.

## What a `Because` claims, and what it does not

It is conditional on its crux, and it states the condition rather than hiding
it: *if the crux holds, P stands and R cannot be held, and here is exactly the
premise of R that fails.* It says nothing about whether the crux is true. That is
what the crux's citation and rating are for, and the rendering ends by listing
them — the readings the verdict rests on.

## How it is proved

Every satisfiability claim is decided by the engine (`Testimony.Logic.Horn`) and
checked by `decide +kernel`; `Because.ofChecks` takes those checks and builds
the object. The split `premises = before ++ crux :: after` is declared and
proved by unfolding — it cannot be computed in the kernel, because equality on
`Formula` does not reduce there — which is also the honest form: it names the
occurrence of the crux that is meant.
-/

namespace Testimony.Logic

open Horn

variable {α : Type}

/-- What the crux does for the position that holds it. -/
inductive CruxRole
  /-- P's conclusion does not follow without the crux: it is part of P's case. -/
  | derives
  /-- P's conclusion follows without the crux: it is P's answer to the rival. -/
  | answers
deriving DecidableEq, Repr

/-- The claim a role makes about the premises other than the crux. -/
def CruxRole.Holds (role : CruxRole) (rest : List (Formula α)) (conclusion : Formula α) : Prop :=
  match role with
  | .derives => ¬ Entails rest conclusion
  | .answers => Entails rest conclusion

/-- **Why `P` stands against `R`**, as one checked object. See the module
docstring for what each field claims. -/
structure Because (P R : ArgumentPackage α) where
  /-- The premise of `P` the explanation turns on. -/
  crux : Formula α
  /-- `P`'s premises before the crux. -/
  before : List (Formula α)
  /-- `P`'s premises after the crux. -/
  after : List (Formula α)
  /-- Further premises of `P` the break needs, stated rather than hidden. -/
  granted : List (Formula α)
  /-- The premises of `R` that cannot be held with the crux. -/
  core : List (Formula α)
  /-- What the crux does for `P`. -/
  role : CruxRole
  /-- `P` delivers its conclusion. -/
  holds : Establishes P
  /-- `P`'s premises can all be true. -/
  consistent : Satisfiable P.premises
  /-- Where the crux sits among `P`'s premises. -/
  split : P.premises = before ++ crux :: after
  /-- The granted grounds are `P`'s own. -/
  granted_mem : ∀ φ ∈ granted, φ ∈ P.premises
  /-- The core is `R`'s own. -/
  core_mem : ∀ φ ∈ core, φ ∈ R.premises
  /-- `R` can be held on its own. -/
  rival_consistent : Satisfiable R.premises
  /-- The crux, with the granted grounds, breaks the core. -/
  breaks : ¬ Satisfiable (core ++ granted ++ [crux])
  /-- Every premise of the core is needed for the break. -/
  core_minimal : ∀ i < core.length, Satisfiable (core.eraseIdx i ++ granted ++ [crux])
  /-- Without the crux, the core and the granted grounds stand together. -/
  crux_needed : Satisfiable (core ++ granted)
  /-- What the crux does for `P`, proved. -/
  role_holds : role.Holds (before ++ after) P.conclusion

namespace Because

variable {P R : ArgumentPackage α}

/-- The crux is one of `P`'s premises. -/
theorem crux_mem (b : Because P R) : b.crux ∈ P.premises := by
  rw [b.split]; simp

/-- **The rival falls wherever the crux holds.** No reading that makes the crux
and the granted grounds true can make all of `R`'s premises true. -/
theorem rival_falls (b : Because P R) (w : Valuation α) (hc : w ⊧ b.crux)
    (hg : ∀ φ ∈ b.granted, w ⊧ φ) : ¬ ∀ φ ∈ R.premises, w ⊧ φ := fun hR =>
  b.breaks (satisfiable_iff.mpr ⟨w, fun φ hφ => by
    simp only [List.mem_append, List.mem_singleton] at hφ
    rcases hφ with (h | h) | rfl
    · exact hR φ (b.core_mem φ h)
    · exact hg φ h
    · exact hc⟩)

/-- **So the two positions cannot be held together.** -/
theorem not_together (b : Because P R) : ¬ Satisfiable (P.premises ++ R.premises) := by
  intro h
  obtain ⟨w, hw⟩ := satisfiable_iff.mp h
  exact b.rival_falls w (hw _ (by simp [b.crux_mem]))
    (fun φ hφ => hw φ (by simp [b.granted_mem φ hφ]))
    (fun φ hφ => hw φ (by simp [hφ]))

/-- **A single broken premise is undermined.** When the core is one premise and
nothing is granted, `P` entails its negation: `P` undermines `R` there, in the
dispute's own sense. -/
theorem undermines (b : Because P R) {φ : Formula α} (hcore : b.core = [φ])
    (hgranted : b.granted = []) : UnderminesOn P R φ := by
  refine ⟨b.core_mem φ (by simp [hcore]), entails_neg_iff.mpr fun h => ?_⟩
  obtain ⟨w, hw⟩ := satisfiable_iff.mp h
  exact b.breaks (satisfiable_iff.mpr ⟨w, fun ψ hψ => by
    simp only [hcore, hgranted, List.append_nil, List.mem_append, List.mem_singleton] at hψ
    rcases hψ with h1 | h2
    · rw [h1]; exact hw φ (by simp)
    · rw [h2]; exact hw b.crux (by simp [b.crux_mem])⟩)

/-- What a page renders: the explanation's data, without its proofs. -/
def view (b : Because P R) : Page.Explanation α :=
  { holder := P.name, rival := R.name, cite := P.cite, crux := b.crux
  , granted := b.granted, core := b.core, derives := b.role == .derives
  , inferences := P.inferences }

end Because

/-! ### Building one from checks -/

section Checks

variable [DecidableEq α]

theorem satisfiable_of_check {Γ : List (Formula α)} (h : satisfiable? Γ = some true) :
    Satisfiable Γ := satisfiable_of_satisfiable? h

theorem not_satisfiable_of_check {Γ : List (Formula α)} (h : satisfiable? Γ = some false) :
    ¬ Satisfiable Γ := not_satisfiable_of_satisfiable? h

/-- A role, decided by the engine: `answers` when the premises other than the
crux cannot hold with the negated conclusion, `derives` when they can. -/
def roleCheck (role : CruxRole) (rest : List (Formula α)) (conclusion : Formula α) : Bool :=
  satisfiable? (rest ++ [∼conclusion]) == some (role == .derives)

theorem role_holds_of_check {role : CruxRole} {rest : List (Formula α)} {c : Formula α}
    (h : roleCheck role rest c = true) : role.Holds rest c := by
  cases role with
  | derives =>
    have h' : satisfiable? (rest ++ [∼c]) = some true := by simpa [roleCheck] using h
    exact fun he => entails_iff_not_satisfiable.mp he (satisfiable_of_check h')
  | answers =>
    have h' : satisfiable? (rest ++ [∼c]) = some false := by
      simpa [roleCheck, show (CruxRole.answers == CruxRole.derives) = false from rfl] using h
    exact entails_iff_not_satisfiable.mpr (not_satisfiable_of_check h')

/-- Every premise of the core is needed, decided by the engine. -/
def minimalCheck (core granted : List (Formula α)) (crux : Formula α) : Bool :=
  (List.range core.length).all fun i =>
    satisfiable? (core.eraseIdx i ++ granted ++ [crux]) == some true

theorem core_minimal_of_check {core granted : List (Formula α)} {crux : Formula α}
    (h : minimalCheck core granted crux = true) :
    ∀ i < core.length, Satisfiable (core.eraseIdx i ++ granted ++ [crux]) := by
  intro i hi
  have := List.all_eq_true.mp h i (List.mem_range.mpr hi)
  exact satisfiable_of_check (by simpa using this)

/-- Everything about a `Because` the engine decides, as one Boolean: the break,
its minimality, that the crux is needed, that the rival stands, and the role. -/
def Because.check (P R : ArgumentPackage α) (crux : Formula α)
    (before after granted core : List (Formula α)) (role : CruxRole) : Bool :=
  satisfiable? (core ++ granted ++ [crux]) == some false &&
  minimalCheck core granted crux &&
  satisfiable? (core ++ granted) == some true &&
  satisfiable? R.premises == some true &&
  roleCheck role (before ++ after) P.conclusion

/-- **Build a `Because`** from the engine's check and the facts it cannot
decide: that `P` holds, that its premises have a model, where the crux sits, and
that the granted grounds and the core are the two positions' own. -/
def Because.ofChecks {P R : ArgumentPackage α} (crux : Formula α)
    (before after granted core : List (Formula α)) (role : CruxRole)
    (holds : Establishes P) (consistent : Satisfiable P.premises)
    (split : P.premises = before ++ crux :: after)
    (granted_mem : ∀ φ ∈ granted, φ ∈ P.premises) (core_mem : ∀ φ ∈ core, φ ∈ R.premises)
    (h : Because.check P R crux before after granted core role = true) : Because P R := by
  simp only [Because.check, Bool.and_eq_true, beq_iff_eq] at h
  obtain ⟨⟨⟨⟨hbreak, hmin⟩, hneed⟩, hrival⟩, hrole⟩ := h
  exact { crux, before, after, granted, core, role, holds, consistent, split, granted_mem,
          core_mem
          rival_consistent := satisfiable_of_check hrival
          breaks := not_satisfiable_of_check hbreak
          core_minimal := core_minimal_of_check hmin
          crux_needed := satisfiable_of_check hneed
          role_holds := role_holds_of_check hrole }

end Checks

end Testimony.Logic
