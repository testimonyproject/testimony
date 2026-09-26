import Testimony.Logic.Because

/-!
# Testimony.Logic.Support — one position lending another a premise, or holding it

A dispute's defeats say who stands against whom. Positions also stand *with*
each other, in two ways. One can deliver a claim another rests on: a case whose
conclusion is that Paul's ἔργα νόμου is works in general lends that claim to any
case that assumes it. Or one can hold another's whole case inside its own: the
Pauline strand of the sola fide dispute derives its ἔργα νόμου premise from the
critics' line rather than assuming it, and so the critics' case is **part of**
Paul's (`PartOf`, below). No party in the library's current disputes supports
another; that one is part of another.

`Supports a b` is that relation: `a`'s conclusion entails a **claim** `b` rests
on — an atom or a denied atom among `b`'s premises. It is decided by the Horn
engine and checked by the kernel, as defeats are (`supports?`,
`supports_iff_of_supports?`).

## Why claims and not steps

A conclusion can entail an inference step `p → q` in two ways, and neither is
support. It can deny `p`, and then the step holds vacuously: the critic of
Isaiah 7:14 "entails" the scriptural reading's step from a predictive reading,
by denying that the reading is predictive. Or it can entail `q`, and then the
step holds because its conclusion does: every Reformed strand "entails" the
others' steps to *sola fide*, by concluding *sola fide*. That is agreement on a
conclusion, not a premise lent. Both were found in the library's own disputes
before this definition excluded them, so the exclusion is stated rather than
left to the reader to discover.

## What support does, and does not, do to a dispute

Nothing. Support is reported alongside the defeats (`Testimony.Logic.Map`),
with the attacks it implies — a supported attack and a secondary attack, in the
bipolar sense (Cayrol and Lagasquie-Schiex) — each marked as already a defeat
or not. The verdicts are computed from the defeats alone, so no support edge
can change one.
-/

namespace Testimony.Logic

open Horn

variable {α : Type}

/-- `a` **supports** `b` on `φ`: `φ` is a claim among `b`'s premises — an atom
or a denied atom, not a step — and `a`'s conclusion entails it. -/
def SupportsOn (a b : ArgumentPackage α) (φ : Formula α) : Prop :=
  φ ∈ b.premises ∧ Page.Explanation.isLiteral φ = true ∧ Entails [a.conclusion] φ

/-- `a` **supports** `b`: its conclusion entails a claim `b` rests on. -/
def Supports (a b : ArgumentPackage α) : Prop := ∃ φ, SupportsOn a b φ

section Decide

variable [DecidableEq α]

/-- For each claim among `b`'s premises, whether `a`'s conclusion can hold with
its negation: `some false` is an entailment. -/
def supportChecks (a b : ArgumentPackage α) : List (Formula α × Option Bool) :=
  (b.premises.filter (Page.Explanation.isLiteral ·)).map fun φ =>
    (φ, satisfiable? [a.conclusion, ∼φ])

/-- **Whether `a` supports `b`**, decided by the engine: `none` when some
claim's check is undecided and none succeeded. -/
def supports? (a b : ArgumentPackage α) : Option Bool :=
  if (supportChecks a b).any (·.2 == some false) then some true
  else if (supportChecks a b).all (·.2 == some true) then some false
  else none

theorem supports_of_supports? {a b : ArgumentPackage α} (h : supports? a b = some true) :
    Supports a b := by
  unfold supports? at h
  split at h
  · rename_i hany
    obtain ⟨⟨φ, r⟩, hmem, hr⟩ := List.any_eq_true.mp hany
    simp only [supportChecks, List.mem_map, List.mem_filter, Prod.mk.injEq] at hmem
    obtain ⟨ψ, ⟨hψ, hlit⟩, rfl, rfl⟩ := hmem
    have hsat : ¬ Satisfiable ([a.conclusion] ++ [∼ψ]) :=
      not_satisfiable_of_satisfiable? (by simpa using hr)
    exact ⟨ψ, hψ, hlit, entails_iff_not_satisfiable.mpr hsat⟩
  · split at h <;> simp at h

theorem not_supports_of_supports? {a b : ArgumentPackage α} (h : supports? a b = some false) :
    ¬ Supports a b := by
  unfold supports? at h
  split at h
  · simp at h
  · split at h
    · rename_i hall
      rintro ⟨φ, hφ, hlit, hent⟩
      have hmem : (φ, satisfiable? [a.conclusion, ∼φ]) ∈ supportChecks a b := by
        simp only [supportChecks, List.mem_map, List.mem_filter]
        exact ⟨φ, ⟨hφ, hlit⟩, rfl⟩
      have hsat : satisfiable? ([a.conclusion] ++ [∼φ]) = some true := by
        simpa using List.all_eq_true.mp hall _ hmem
      exact entails_iff_not_satisfiable.mp hent (satisfiable_of_satisfiable? hsat)
    · simp at h

/-- **A support table cell, from the engine**: whenever it decides, the relation
is exactly what it says. -/
theorem supports_iff_of_supports? {a b : ArgumentPackage α} {P : Prop} [Decidable P]
    (h : supports? a b = some (decide P)) : Supports a b ↔ P := by
  by_cases hP : P
  · simp only [hP, decide_true] at h
    exact ⟨fun _ => hP, fun _ => supports_of_supports? h⟩
  · simp only [hP, decide_false] at h
    exact ⟨fun hs => absurd hs (not_supports_of_supports? h), fun h' => absurd h' hP⟩

end Decide

/-! ### One position as part of another

Support is one position lending another a claim. A position can also hold
another's whole case: the Pauline strand rests on the critics' line, deriving
its ἔργα νόμου premise from their denial of covenantal nomism. Then the critics'
case is **part of** Paul's — every premise of it follows from Paul's premises —
and whatever defeats the part is aimed at the whole. -/

/-- `b` is **part of** `a`: every premise of `b` follows from `a`'s premises. -/
def PartOf (b a : ArgumentPackage α) : Prop := ∀ φ ∈ b.premises, Entails a.premises φ

section DecidePart

variable [DecidableEq α]

/-- Whether `a`'s premises entail `φ`, asked of the engine in a form it can
decide: `φ`'s negation for a claim, and for a step `p → q`, `p` with `q`'s
negation. `some false` is an entailment. -/
def entailsCheck (Γ : List (Formula α)) : Formula α → Option Bool
  | .imp p q => satisfiable? (Γ ++ [p, ∼q])
  | φ => satisfiable? (Γ ++ [∼φ])

omit [DecidableEq α] in
theorem entails_imp_iff {Γ : List (Formula α)} {p q : Formula α} :
    Entails Γ (.imp p q) ↔ ¬ Satisfiable (Γ ++ [p, ∼q]) := by
  rw [entails_iff, satisfiable_iff]
  simp only [List.mem_append, List.mem_cons, List.not_mem_nil, or_false]
  constructor
  · rintro h ⟨w, hw⟩
    exact hw _ (.inr (.inr rfl)) (h w (fun ψ hψ => hw ψ (.inl hψ)) (hw _ (.inr (.inl rfl))))
  · intro h w hw hp
    by_contra hq
    exact h ⟨w, fun ψ hψ => by
      rcases hψ with hψ | rfl | rfl
      · exact hw ψ hψ
      · exact hp
      · exact hq⟩

theorem entails_of_entailsCheck {Γ : List (Formula α)} {φ : Formula α}
    (h : entailsCheck Γ φ = some false) : Entails Γ φ := by
  cases φ with
  | imp p q => exact entails_imp_iff.mpr (not_satisfiable_of_satisfiable? h)
  | _ => exact entails_iff_not_satisfiable.mpr (not_satisfiable_of_satisfiable? h)

theorem not_entails_of_entailsCheck {Γ : List (Formula α)} {φ : Formula α}
    (h : entailsCheck Γ φ = some true) : ¬ Entails Γ φ := by
  cases φ with
  | imp p q => exact fun he => entails_imp_iff.mp he (satisfiable_of_satisfiable? h)
  | _ => exact fun he => entails_iff_not_satisfiable.mp he (satisfiable_of_satisfiable? h)

/-- For each premise of `b`, whether `a`'s premises entail it. -/
def partChecks (b a : ArgumentPackage α) : List (Option Bool) :=
  b.premises.map (entailsCheck a.premises)

/-- **Whether `b` is part of `a`**, decided by the engine. -/
def partOf? (b a : ArgumentPackage α) : Option Bool :=
  if (partChecks b a).all (· == some false) then some true
  else if (partChecks b a).any (· == some true) then some false
  else none

theorem partOf_of_partOf? {b a : ArgumentPackage α} (h : partOf? b a = some true) :
    PartOf b a := by
  unfold partOf? at h
  split at h
  · rename_i hall
    intro φ hφ
    have hmem := List.mem_map_of_mem (f := entailsCheck a.premises) hφ
    exact entails_of_entailsCheck (by simpa using List.all_eq_true.mp hall _ hmem)
  · split at h <;> simp at h

theorem not_partOf_of_partOf? {b a : ArgumentPackage α} (h : partOf? b a = some false) :
    ¬ PartOf b a := by
  unfold partOf? at h
  split at h
  · simp at h
  · split at h
    · rename_i _ hany
      obtain ⟨r, hr, hr'⟩ := List.any_eq_true.mp hany
      obtain ⟨φ, hφ, rfl⟩ := List.mem_map.mp (by simpa [partChecks] using hr)
      exact fun hp => not_entails_of_entailsCheck (by simpa using hr') (hp φ hφ)
    · simp at h

/-- **A part-of table cell, from the engine.** -/
theorem partOf_iff_of_partOf? {b a : ArgumentPackage α} {P : Prop} [Decidable P]
    (h : partOf? b a = some (decide P)) : PartOf b a ↔ P := by
  by_cases hP : P
  · simp only [hP, decide_true] at h
    exact ⟨fun _ => hP, fun _ => partOf_of_partOf? h⟩
  · simp only [hP, decide_false] at h
    exact ⟨fun hs => absurd hs (not_partOf_of_partOf? h), fun h' => absurd h' hP⟩

end DecidePart

namespace Dispute

variable {ι : Type} (d : Dispute α ι)

/-- In a dispute, node `i` supports node `j`. -/
def supports (i j : ι) : Prop := Supports (d.node i) (d.node j)

/-- In a dispute, node `i` is part of node `j`. -/
def partOf (i j : ι) : Prop := PartOf (d.node i) (d.node j)

end Dispute

end Testimony.Logic
