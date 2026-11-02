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
engine and checked by the kernel, as defeats are: from hints, a model or a
refutation for each question, which `horn_certify` finds and the kernel checks
(`supportsBy?`, `supports_iff_of_certified`), or by a search the kernel runs
itself (`supports?`).

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

/-! #### Checks, each with a hint

Both relations ask one question of satisfiability per premise of `b`, and each
question can be given a hint, a model or a refutation, which the kernel checks
in place of a search (`Horn.clausesSatisfiableBy?`). `checksBy` hands the
questions their hints in order, and any question without one is searched. -/

/-- One check per formula, each asked with the hint at its position, or with
`search` past the end of the hints. -/
def checksBy (f : Hint → Formula α → Option Bool) :
    List Hint → List (Formula α) → List (Option Bool)
  | _, [] => []
  | hs, φ :: φs => f (hs.headD .search) φ :: checksBy f hs.tail φs

omit [DecidableEq α] in
/-- Every check was asked of one of the formulas, with a hint that is `search`
unless the index tells atoms apart. -/
theorem mem_checksBy {P : Prop} {f : Hint → Formula α → Option Bool} {hs : List Hint}
    {φs : List (Formula α)} {x : Option Bool} (hidx : P ∨ hs = []) (hx : x ∈ checksBy f hs φs) :
    ∃ φ ∈ φs, ∃ h, (P ∨ h = .search) ∧ f h φ = x := by
  induction φs generalizing hs with
  | nil => simp [checksBy] at hx
  | cons φ φs ih =>
    rcases List.mem_cons.mp hx with rfl | hx
    · refine ⟨φ, List.mem_cons_self, _, hidx.imp id fun h => ?_, rfl⟩
      subst h; rfl
    · obtain ⟨ψ, hψ, h, hh, e⟩ := ih (hs := hs.tail) (hidx.imp id fun h => by subst h; rfl) hx
      exact ⟨ψ, List.mem_cons_of_mem _ hψ, h, hh, e⟩

omit [DecidableEq α] in
/-- Every formula was asked about, with a hint that is `search` unless the index
tells atoms apart. -/
theorem checksBy_mem {P : Prop} {f : Hint → Formula α → Option Bool} {hs : List Hint}
    {φs : List (Formula α)} {φ : Formula α} (hidx : P ∨ hs = []) (hφ : φ ∈ φs) :
    ∃ h, (P ∨ h = .search) ∧ f h φ ∈ checksBy f hs φs := by
  induction φs generalizing hs with
  | nil => simp at hφ
  | cons ψ φs ih =>
    rcases List.mem_cons.mp hφ with rfl | hφ
    · refine ⟨_, hidx.imp id fun h => ?_, List.mem_cons_self⟩
      subst h; rfl
    · obtain ⟨h, hh, hm⟩ := ih (hs := hs.tail) (hidx.imp id fun h => by subst h; rfl) hφ
      exact ⟨h, hh, List.mem_cons_of_mem _ hm⟩

/-- For each claim among `b`'s premises, in order, whether `a`'s conclusion can
hold with its negation, from a hint: `some false` is an entailment. `a`'s
conclusion is converted to clauses once. -/
def supportChecksBy (index : α → ℕ) (hints : List Hint) (a b : ArgumentPackage α) :
    List (Option Bool) :=
  let ca := clausesOf [a.conclusion]
  checksBy (fun h φ => satisfiableAppend? index h ca [∼φ]) hints
    (b.premises.filter (Page.Explanation.isLiteral ·))

/-- **Whether `a` supports `b`**, decided from hints: `none` when some claim's
check is undecided, or its hint did not check, and none succeeded. -/
def supportsBy? (index : α → ℕ) (hints : List Hint) (a b : ArgumentPackage α) : Option Bool :=
  let checks := supportChecksBy index hints a b
  if checks.any (· == some false) then some true
  else if checks.all (· == some true) then some false
  else none

/-- **Whether `a` supports `b`**, every question searched: `supportsBy?` with
no hints. -/
def supports? (a b : ArgumentPackage α) : Option Bool := supportsBy? (fun _ => 0) [] a b

theorem supports_of_supportsBy? {index : α → ℕ} {hints : List Hint} {a b : ArgumentPackage α}
    (hidx : Function.Injective index ∨ hints = []) (e : supportsBy? index hints a b = some true) :
    Supports a b := by
  dsimp only [supportsBy?] at e
  split at e
  · rename_i hany
    obtain ⟨r, hmem, hr⟩ := List.any_eq_true.mp hany
    obtain ⟨φ, hφ, h, hh, rfl⟩ := mem_checksBy hidx hmem
    obtain ⟨hφ, hlit⟩ := List.mem_filter.mp hφ
    exact ⟨φ, hφ, hlit, entails_iff_not_satisfiable.mpr
      (not_satisfiable_of_satisfiableAppend? hh (by simpa using hr))⟩
  · split at e <;> simp at e

theorem not_supports_of_supportsBy? {index : α → ℕ} {hints : List Hint}
    {a b : ArgumentPackage α} (e : supportsBy? index hints a b = some false) :
    ¬ Supports a b := by
  dsimp only [supportsBy?] at e
  split at e
  · simp at e
  · split at e
    · rename_i hall
      rintro ⟨φ, hφ, hlit, hent⟩
      obtain ⟨h, -, hmem⟩ := checksBy_mem (f := fun h φ =>
        satisfiableAppend? index h (clausesOf [a.conclusion]) [∼φ]) (P := True) (.inl trivial)
        (List.mem_filter.mpr ⟨hφ, hlit⟩)
      exact entails_iff_not_satisfiable.mp hent
        (satisfiable_of_satisfiableAppend? (by simpa using List.all_eq_true.mp hall _ hmem))
    · simp at e

theorem supports_of_supports? {a b : ArgumentPackage α} (h : supports? a b = some true) :
    Supports a b :=
  supports_of_supportsBy? (.inr rfl) h

theorem not_supports_of_supports? {a b : ArgumentPackage α} (h : supports? a b = some false) :
    ¬ Supports a b :=
  not_supports_of_supportsBy? h

/-- **A support table cell, from the engine**: whenever it decides, the relation
is exactly what it says. -/
theorem supports_iff_of_supports? {a b : ArgumentPackage α} {P : Prop} [Decidable P]
    (h : supports? a b = some (decide P)) : Supports a b ↔ P := by
  by_cases hP : P
  · simp only [hP, decide_true] at h
    exact ⟨fun _ => hP, fun _ => supports_of_supports? h⟩
  · simp only [hP, decide_false] at h
    exact ⟨fun hs => absurd hs (not_supports_of_supports? h), fun h' => absurd h' hP⟩

/-- **A support table cell, from hints the kernel checks.** Whichever index
that tells atoms apart, and whichever hints, decide the cell, the answer is
sound. `horn_certify` (`Testimony.Logic.Certificate`) finds them. -/
theorem supports_iff_of_certified {a b : ArgumentPackage α} {P : Prop} [Decidable P]
    (h : ∃ (index : α → ℕ), Function.Injective index ∧
      ∃ hints : List Hint, supportsBy? index hints a b = some (decide P)) :
    Supports a b ↔ P := by
  obtain ⟨_, hinj, _, h⟩ := h
  by_cases hP : P
  · simp only [hP, decide_true] at h
    exact iff_of_true (supports_of_supportsBy? (.inl hinj) h) hP
  · simp only [hP, decide_false] at h
    exact iff_of_false (not_supports_of_supportsBy? h) hP

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

/-- What is asked of a list of formulas to learn whether it entails `φ`: for a
step `p → q`, `p` and `q`'s negation, and otherwise `φ`'s negation. The list
entails `φ` when it cannot hold with them. -/
def entailsQuestion : Formula α → List (Formula α)
  | .imp p q => [p, ∼q]
  | φ => [∼φ]

/-- Whether the formulas whose clauses are `base` entail `φ`, from a hint:
`some false` is an entailment. -/
def entailsCheckBy (index : α → ℕ) (h : Hint) (base : Option (List (Clause α)))
    (φ : Formula α) : Option Bool :=
  satisfiableAppend? index h base (entailsQuestion φ)

theorem entails_of_entailsCheckBy {index : α → ℕ} {h : Hint} {Γ : List (Formula α)}
    {φ : Formula α} (hidx : Function.Injective index ∨ h = .search)
    (e : entailsCheckBy index h (clausesOf Γ) φ = some false) : Entails Γ φ := by
  have hn := not_satisfiable_of_satisfiableAppend? hidx e
  cases φ with
  | imp p q => exact entails_imp_iff.mpr hn
  | _ => exact entails_iff_not_satisfiable.mpr hn

theorem not_entails_of_entailsCheckBy {index : α → ℕ} {h : Hint} {Γ : List (Formula α)}
    {φ : Formula α} (e : entailsCheckBy index h (clausesOf Γ) φ = some true) :
    ¬ Entails Γ φ := by
  have hs := satisfiable_of_satisfiableAppend? e
  cases φ with
  | imp p q => exact fun he => entails_imp_iff.mp he hs
  | _ => exact fun he => entails_iff_not_satisfiable.mp he hs

/-- For each premise of `b`, in order, whether `a`'s premises entail it, from a
hint. `a`'s premises are converted to clauses once. -/
def partChecksBy (index : α → ℕ) (hints : List Hint) (b a : ArgumentPackage α) :
    List (Option Bool) :=
  let ca := clausesOf a.premises
  checksBy (fun h φ => entailsCheckBy index h ca φ) hints b.premises

/-- **Whether `b` is part of `a`**, decided from hints. -/
def partOfBy? (index : α → ℕ) (hints : List Hint) (b a : ArgumentPackage α) : Option Bool :=
  let checks := partChecksBy index hints b a
  if checks.all (· == some false) then some true
  else if checks.any (· == some true) then some false
  else none

/-- **Whether `b` is part of `a`**, every question searched: `partOfBy?` with
no hints. -/
def partOf? (b a : ArgumentPackage α) : Option Bool := partOfBy? (fun _ => 0) [] b a

theorem partOf_of_partOfBy? {index : α → ℕ} {hints : List Hint} {b a : ArgumentPackage α}
    (hidx : Function.Injective index ∨ hints = []) (e : partOfBy? index hints b a = some true) :
    PartOf b a := by
  dsimp only [partOfBy?] at e
  split at e
  · rename_i hall
    intro φ hφ
    obtain ⟨h, hh, hmem⟩ := checksBy_mem (f := fun h φ =>
      entailsCheckBy index h (clausesOf a.premises) φ) hidx hφ
    exact entails_of_entailsCheckBy hh (by simpa using List.all_eq_true.mp hall _ hmem)
  · split at e <;> simp at e

theorem not_partOf_of_partOfBy? {index : α → ℕ} {hints : List Hint} {b a : ArgumentPackage α}
    (e : partOfBy? index hints b a = some false) : ¬ PartOf b a := by
  dsimp only [partOfBy?] at e
  split at e
  · simp at e
  · split at e
    · rename_i _ hany
      obtain ⟨r, hr, hr'⟩ := List.any_eq_true.mp hany
      obtain ⟨φ, hφ, h, -, rfl⟩ := mem_checksBy (P := True) (.inl trivial) hr
      exact fun hp => not_entails_of_entailsCheckBy (by simpa using hr') (hp φ hφ)
    · simp at e

theorem partOf_of_partOf? {b a : ArgumentPackage α} (h : partOf? b a = some true) :
    PartOf b a :=
  partOf_of_partOfBy? (.inr rfl) h

theorem not_partOf_of_partOf? {b a : ArgumentPackage α} (h : partOf? b a = some false) :
    ¬ PartOf b a :=
  not_partOf_of_partOfBy? h

/-- **A part-of table cell, from the engine.** -/
theorem partOf_iff_of_partOf? {b a : ArgumentPackage α} {P : Prop} [Decidable P]
    (h : partOf? b a = some (decide P)) : PartOf b a ↔ P := by
  by_cases hP : P
  · simp only [hP, decide_true] at h
    exact ⟨fun _ => hP, fun _ => partOf_of_partOf? h⟩
  · simp only [hP, decide_false] at h
    exact ⟨fun hs => absurd hs (not_partOf_of_partOf? h), fun h' => absurd h' hP⟩

/-- **A part-of table cell, from hints the kernel checks.** -/
theorem partOf_iff_of_certified {b a : ArgumentPackage α} {P : Prop} [Decidable P]
    (h : ∃ (index : α → ℕ), Function.Injective index ∧
      ∃ hints : List Hint, partOfBy? index hints b a = some (decide P)) :
    PartOf b a ↔ P := by
  obtain ⟨_, hinj, _, h⟩ := h
  by_cases hP : P
  · simp only [hP, decide_true] at h
    exact iff_of_true (partOf_of_partOfBy? (.inl hinj) h) hP
  · simp only [hP, decide_false] at h
    exact iff_of_false (not_partOf_of_partOfBy? h) hP

end DecidePart

namespace Dispute

variable [HasPostulates α] {ι : Type} (d : Dispute α ι)

/-- In a dispute, node `i` supports node `j`. -/
def supports (i j : ι) : Prop := Supports (d.node i) (d.node j)

/-- In a dispute, node `i` is part of node `j`. -/
def partOf (i j : ι) : Prop := PartOf (d.node i) (d.node j)

end Dispute

end Testimony.Logic
