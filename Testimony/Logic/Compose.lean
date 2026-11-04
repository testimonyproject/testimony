import Testimony.Logic.Dispute
import Testimony.Logic.Solver

/-!
# Testimony.Logic.Compose — two disputes heard as one

Two arguments that share no claim can be heard together. The combined dispute
has both arguments' claims, kept apart (`α ⊕ β`), both arguments' meaning
postulates, and both arguments' parties. Who defeats whom in it is not computed
again: it is proved, once and for every pair of parties, from the two tables
already proved.

- **Within one argument, nothing changes** (`Dispute.sum_defeats`). A party
  of the first argument defeats another exactly when it did before. Renaming a
  claim changes nothing a valuation can see, and the other argument's
  postulates speak of claims these parties never mention: a model of either
  side extends to a model of both.
- **Across the two arguments, no party defeats another.** To undermine,
  rebut, or rebut a step of a party of the other argument, a party must
  entail the negation of a claim of that argument. All it holds about that
  argument's claims are that argument's postulates, and the other party holds
  them too, together with the claim — so they cannot entail its negation.

Both facts hold for every pair of parties at once, so the combined table costs
the kernel nothing beyond the two tables it already checked: neither a cell of
the cross product nor a cell of either argument is decided again.

What it does not cover: arguments that share a claim, or whose meanings are
joined by a postulate mentioning both. Those are one argument, and their
dispute is computed as one.
-/

namespace Testimony.Logic

variable {α β : Type}

/-! ### Renaming the claims of a formula -/

/-- The formula with each claim `a` renamed to `f a`. -/
def rename (f : α → β) : Formula α → Formula β
  | .atom a => .atom (f a)
  | .falsum => .falsum
  | .and p q => .and (rename f p) (rename f q)
  | .or p q => .or (rename f p) (rename f q)
  | .imp p q => .imp (rename f p) (rename f q)

/-- A renamed formula holds exactly when the formula holds of the renamed
valuation. -/
theorem models_rename (f : α → β) (v : Valuation β) :
    ∀ φ : Formula α, v ⊧ rename f φ ↔ (fun a => v (f a)) ⊧ φ
  | .atom _ => Iff.rfl
  | .falsum => ⟨fun h => absurd h (FFL.Semantics.Bot.models_falsum v),
      fun h => absurd h (FFL.Semantics.Bot.models_falsum _)⟩
  | .and p q => FFL.Semantics.And.models_and.trans <|
      (and_congr (models_rename f v p) (models_rename f v q)).trans
        FFL.Semantics.And.models_and.symm
  | .or p q => FFL.Semantics.Or.models_or.trans <|
      (or_congr (models_rename f v p) (models_rename f v q)).trans
        FFL.Semantics.Or.models_or.symm
  | .imp p q => FFL.Semantics.Imp.models_imply.trans <|
      (imp_congr (models_rename f v p) (models_rename f v q)).trans
        FFL.Semantics.Imp.models_imply.symm

/-- Renaming by an injective map loses no formula. -/
theorem rename_injective {f : α → β} (hf : Function.Injective f) :
    Function.Injective (rename f) := by
  intro φ ψ h
  induction φ generalizing ψ with
  | atom a => cases ψ <;> simp_all [rename, hf.eq_iff]
  | falsum => cases ψ <;> simp_all [rename]
  | and p q ihp ihq =>
    cases ψ <;> simp only [rename, reduceCtorEq, FFL.Propositional.Formula.and.injEq] at h
    exact congrArg₂ _ (ihp h.1) (ihq h.2)
  | or p q ihp ihq =>
    cases ψ <;> simp only [rename, reduceCtorEq, FFL.Propositional.Formula.or.injEq] at h
    exact congrArg₂ _ (ihp h.1) (ihq h.2)
  | imp p q ihp ihq =>
    cases ψ <;> simp only [rename, reduceCtorEq, FFL.Propositional.Formula.imp.injEq] at h
    exact congrArg₂ _ (ihp h.1) (ihq h.2)

/-- A renamed step is the renaming of a step. -/
theorem rename_eq_imp {f : α → β} {χ : Formula α} {p ψ : Formula β}
    (h : rename f χ = (p ➝ ψ)) : ∃ p₀ ψ₀, χ = (p₀ ➝ ψ₀) ∧ p = rename f p₀ ∧ ψ = rename f ψ₀ := by
  cases χ <;> simp only [rename, reduceCtorEq] at h
  case imp p₀ ψ₀ =>
    obtain ⟨rfl, rfl⟩ := FFL.Propositional.Formula.imp.inj h
    exact ⟨p₀, ψ₀, rfl, rfl, rfl⟩

/-- A renamed formula is absurdity exactly when the formula is. -/
theorem rename_eq_falsum {f : α → β} {ψ : Formula α} : rename f ψ = ⊥ ↔ ψ = ⊥ := by
  cases ψ <;> first
    | exact ⟨fun _ => rfl, fun _ => rfl⟩
    | exact ⟨nofun, nofun⟩

/-! ### Two vocabularies side by side -/

section Sum

/-- `Γ'` is `Γ` over the first vocabulary and `Δ` over the second, side by side,
in some order. -/
def SplitsAs (Γ' : List (Formula (α ⊕ β))) (Γ : List (Formula α)) (Δ : List (Formula β)) :
    Prop :=
  ∀ φ, φ ∈ Γ' ↔ φ ∈ Γ.map (rename Sum.inl) ∨ φ ∈ Δ.map (rename Sum.inr)

theorem models_of_splitsAs {Γ' : List (Formula (α ⊕ β))} {Γ : List (Formula α)}
    {Δ : List (Formula β)} (h : SplitsAs Γ' Γ Δ) {w : Valuation α} {u : Valuation β}
    (hw : ∀ φ ∈ Γ, w ⊧ φ) (hu : ∀ φ ∈ Δ, u ⊧ φ) : ∀ φ ∈ Γ', (Sum.elim w u) ⊧ φ := by
  intro φ hφ
  rcases (h φ).mp hφ with hφ | hφ <;> obtain ⟨φ₀, hφ₀, rfl⟩ := List.mem_map.mp hφ
  · exact (models_rename _ _ φ₀).mpr (hw φ₀ hφ₀)
  · exact (models_rename _ _ φ₀).mpr (hu φ₀ hφ₀)

/-- Two satisfiable lists over vocabularies kept apart are satisfiable side by
side: the two models, joined. -/
theorem satisfiable_of_splitsAs {Γ' : List (Formula (α ⊕ β))} {Γ : List (Formula α)}
    {Δ : List (Formula β)} (h : SplitsAs Γ' Γ Δ) (hΓ : Satisfiable Γ) (hΔ : Satisfiable Δ) :
    Satisfiable Γ' := by
  obtain ⟨w, hw⟩ := satisfiable_iff.mp hΓ
  obtain ⟨u, hu⟩ := satisfiable_iff.mp hΔ
  exact satisfiable_iff.mpr ⟨_, models_of_splitsAs h hw hu⟩

/-- **What the first side entails, side by side with a satisfiable second**, is
what it entailed alone. -/
theorem entails_inl_iff {Γ' : List (Formula (α ⊕ β))} {Γ : List (Formula α)}
    {Δ : List (Formula β)} (h : SplitsAs Γ' Γ Δ) (hΔ : Satisfiable Δ) {ψ : Formula α} :
    Entails Γ' (rename Sum.inl ψ) ↔ Entails Γ ψ := by
  rw [entails_iff, entails_iff]
  constructor
  · intro he w hw
    obtain ⟨u, hu⟩ := satisfiable_iff.mp hΔ
    exact (models_rename Sum.inl _ ψ).mp (he _ (models_of_splitsAs h hw hu))
  · intro he v hv
    refine (models_rename Sum.inl _ ψ).mpr
      (he _ fun φ hφ => (models_rename Sum.inl _ φ).mp ?_)
    exact hv _ ((h _).mpr (.inl (List.mem_map_of_mem hφ)))

/-- What the second side entails, side by side with a satisfiable first, is what
it entailed alone. -/
theorem entails_inr_iff {Γ' : List (Formula (α ⊕ β))} {Γ : List (Formula α)}
    {Δ : List (Formula β)} (h : SplitsAs Γ' Γ Δ) (hΓ : Satisfiable Γ) {ψ : Formula β} :
    Entails Γ' (rename Sum.inr ψ) ↔ Entails Δ ψ := by
  rw [entails_iff, entails_iff]
  constructor
  · intro he u hu
    obtain ⟨w, hw⟩ := satisfiable_iff.mp hΓ
    exact (models_rename Sum.inr _ ψ).mp (he _ (models_of_splitsAs h hw hu))
  · intro he v hv
    refine (models_rename Sum.inr _ ψ).mpr
      (he _ fun φ hφ => (models_rename Sum.inr _ φ).mp ?_)
    exact hv _ ((h _).mpr (.inr (List.mem_map_of_mem hφ)))

theorem splitsAs_nil_right (Γ : List (Formula α)) :
    SplitsAs (β := β) (Γ.map (rename Sum.inl)) Γ [] := by
  intro φ; simp

theorem splitsAs_nil_left (Δ : List (Formula β)) :
    SplitsAs (α := α) (Δ.map (rename Sum.inr)) [] Δ := by
  intro φ; simp

/-- Both arguments' meaning postulates, each over its own claims. -/
instance instHasPostulatesSum [HasPostulates α] [HasPostulates β] : HasPostulates (α ⊕ β) :=
  ⟨(HasPostulates.postulates (α := α)).map (rename Sum.inl) ++
    (HasPostulates.postulates (α := β)).map (rename Sum.inr)⟩

theorem postulates_sum [HasPostulates α] [HasPostulates β] :
    HasPostulates.postulates (α := α ⊕ β) =
      (HasPostulates.postulates (α := α)).map (rename Sum.inl) ++
        (HasPostulates.postulates (α := β)).map (rename Sum.inr) := rfl

namespace ArgumentPackage

/-- A package of the first argument, heard among both arguments' claims. The
other argument's claims, which it never mentions, are cited as `other` cites
them. -/
def inl (other : β → AtomMeta) (a : ArgumentPackage α) : ArgumentPackage (α ⊕ β) where
  name := a.name
  cite := Sum.elim a.cite other
  premises := a.premises.map (rename Sum.inl)
  conclusion := rename Sum.inl a.conclusion
  conclusionLabel := a.conclusionLabel
  inferences := a.inferences

/-- A package of the second argument, heard among both arguments' claims. -/
def inr (other : α → AtomMeta) (b : ArgumentPackage β) : ArgumentPackage (α ⊕ β) where
  name := b.name
  cite := Sum.elim other b.cite
  premises := b.premises.map (rename Sum.inr)
  conclusion := rename Sum.inr b.conclusion
  conclusionLabel := b.conclusionLabel
  inferences := b.inferences

variable (cα : α → AtomMeta) (cβ : β → AtomMeta)

theorem rankOf_inl (a : ArgumentPackage α) (φ : Formula α) :
    (a.inl cβ).rankOf (rename Sum.inl φ) = a.rankOf φ := by
  cases φ with
  | imp p q => cases p <;> cases q <;> rfl
  | _ => rfl

theorem rankOf_inr (b : ArgumentPackage β) (φ : Formula β) :
    (b.inr cα).rankOf (rename Sum.inr φ) = b.rankOf φ := by
  cases φ with
  | imp p q => cases p <;> cases q <;> rfl
  | _ => rfl

/-- A package is as strong among both arguments' claims as among its own. -/
theorem strength_inl (a : ArgumentPackage α) : (a.inl cβ).strength = a.strength := by
  simp only [strength, inl, List.filterMap_map]
  congr 2
  funext φ
  exact rankOf_inl cβ a φ

theorem strength_inr (b : ArgumentPackage β) : (b.inr cα).strength = b.strength := by
  simp only [strength, inr, List.filterMap_map]
  congr 2
  funext φ
  exact rankOf_inr cα b φ

theorem establishes_inl {a : ArgumentPackage α} (h : Establishes a) :
    Establishes (a.inl cβ) :=
  (entails_inl_iff (splitsAs_nil_right _) (satisfiable_iff.mpr ⟨fun _ => True, by simp⟩)).mpr h

theorem establishes_inr {b : ArgumentPackage β} (h : Establishes b) :
    Establishes (b.inr cα) :=
  (entails_inr_iff (splitsAs_nil_left _) (satisfiable_iff.mpr ⟨fun _ => True, by simp⟩)).mpr h

variable [HasPostulates α] [HasPostulates β]

theorem held_inl (a : ArgumentPackage α) :
    SplitsAs (a.inl cβ).held a.held (HasPostulates.postulates (α := β)) := by
  intro φ
  simp only [held, inl, postulates_sum, List.map_append, List.mem_append]
  tauto

theorem held_inr (b : ArgumentPackage β) :
    SplitsAs (b.inr cα).held (HasPostulates.postulates (α := α)) b.held := by
  intro φ
  simp only [held, inr, postulates_sum, List.map_append, List.mem_append]
  tauto

end ArgumentPackage

open ArgumentPackage

variable [HasPostulates α] [HasPostulates β] (cα : α → AtomMeta) (cβ : β → AtomMeta)

/-- **Within the first argument, defeat is what it was**, once its claims are
heard beside a second argument's, whose postulates can hold together. -/
theorem defeats_inl_iff (hβ : Satisfiable (HasPostulates.postulates (α := β)))
    (a b : ArgumentPackage α) : Defeats (a.inl cβ) (b.inl cβ) ↔ Defeats a b := by
  have ha := fun ψ => entails_inl_iff (ψ := ψ) (held_inl cβ a) hβ
  have hb := fun ψ => entails_inl_iff (ψ := ψ) (held_inl cβ b) hβ
  have hs : ∀ ψ, (∼ rename Sum.inl ψ : Formula (α ⊕ β)) = rename Sum.inl (∼ψ) := fun _ => rfl
  simp only [Defeats, UnderminesOn, Rebuts, RebutsStep, Outranks, strength_inl]
  refine or_congr ?_ (or_congr ?_ ?_)
  · constructor
    · rintro ⟨φ, ⟨hφ, he⟩, ho⟩
      obtain ⟨φ₀, hφ₀, rfl⟩ := List.mem_map.mp hφ
      rw [hs, ha] at he
      rw [rankOf_inl] at ho
      exact ⟨φ₀, ⟨hφ₀, he⟩, ho⟩
    · rintro ⟨φ₀, ⟨hφ₀, he⟩, ho⟩
      refine ⟨rename Sum.inl φ₀, ⟨List.mem_map_of_mem hφ₀, ?_⟩, ?_⟩
      · rw [hs, ha]; exact he
      · rw [rankOf_inl]; exact ho
  · exact and_congr_left' (ha (∼b.conclusion))
  · constructor
    · rintro ⟨p, ψ, ⟨hm, hne, hbψ, haψ⟩, hl⟩
      obtain ⟨χ, hχ, he⟩ := List.mem_map.mp hm
      obtain ⟨p₀, ψ₀, rfl, rfl, rfl⟩ := rename_eq_imp he
      rw [hs, ha] at haψ
      rw [hb] at hbψ
      exact ⟨p₀, ψ₀, ⟨hχ, fun h => hne (rename_eq_falsum.mpr h), hbψ, haψ⟩, hl⟩
    · rintro ⟨p₀, ψ₀, ⟨hm, hne, hbψ, haψ⟩, hl⟩
      refine ⟨rename Sum.inl p₀, rename Sum.inl ψ₀,
        ⟨List.mem_map_of_mem (f := rename Sum.inl) hm, fun h => hne (rename_eq_falsum.mp h),
          ?_, ?_⟩, hl⟩
      · rw [hb]; exact hbψ
      · rw [hs, ha]; exact haψ

/-- Within the second argument, defeat is what it was. -/
theorem defeats_inr_iff (hα : Satisfiable (HasPostulates.postulates (α := α)))
    (a b : ArgumentPackage β) : Defeats (a.inr cα) (b.inr cα) ↔ Defeats a b := by
  have ha := fun ψ => entails_inr_iff (ψ := ψ) (held_inr cα a) hα
  have hb := fun ψ => entails_inr_iff (ψ := ψ) (held_inr cα b) hα
  have hs : ∀ ψ, (∼ rename Sum.inr ψ : Formula (α ⊕ β)) = rename Sum.inr (∼ψ) := fun _ => rfl
  simp only [Defeats, UnderminesOn, Rebuts, RebutsStep, Outranks, strength_inr]
  refine or_congr ?_ (or_congr ?_ ?_)
  · constructor
    · rintro ⟨φ, ⟨hφ, he⟩, ho⟩
      obtain ⟨φ₀, hφ₀, rfl⟩ := List.mem_map.mp hφ
      rw [hs, ha] at he
      rw [rankOf_inr] at ho
      exact ⟨φ₀, ⟨hφ₀, he⟩, ho⟩
    · rintro ⟨φ₀, ⟨hφ₀, he⟩, ho⟩
      refine ⟨rename Sum.inr φ₀, ⟨List.mem_map_of_mem hφ₀, ?_⟩, ?_⟩
      · rw [hs, ha]; exact he
      · rw [rankOf_inr]; exact ho
  · exact and_congr_left' (ha (∼b.conclusion))
  · constructor
    · rintro ⟨p, ψ, ⟨hm, hne, hbψ, haψ⟩, hl⟩
      obtain ⟨χ, hχ, he⟩ := List.mem_map.mp hm
      obtain ⟨p₀, ψ₀, rfl, rfl, rfl⟩ := rename_eq_imp he
      rw [hs, ha] at haψ
      rw [hb] at hbψ
      exact ⟨p₀, ψ₀, ⟨hχ, fun h => hne (rename_eq_falsum.mpr h), hbψ, haψ⟩, hl⟩
    · rintro ⟨p₀, ψ₀, ⟨hm, hne, hbψ, haψ⟩, hl⟩
      refine ⟨rename Sum.inr p₀, rename Sum.inr ψ₀,
        ⟨List.mem_map_of_mem (f := rename Sum.inr) hm, fun h => hne (rename_eq_falsum.mp h),
          ?_, ?_⟩, hl⟩
      · rw [hb]; exact hbψ
      · rw [hs, ha]; exact haψ

/-- A position that entails the negation of `x` from postulates that a
satisfiable position `b` also holds, together with `x`, entails nothing: the
contradiction behind both cross-argument results. -/
private theorem not_entails_neg {γ : Type} {P H : List (Formula γ)} {x : Formula γ}
    (hP : ∀ φ ∈ P, φ ∈ H) (hH : Satisfiable H) (hx : Entails H x) : ¬ Entails P (∼x) := by
  intro he
  obtain ⟨w, hw⟩ := satisfiable_iff.mp hH
  exact (entails_iff.mp he w fun φ hφ => hw φ (hP φ hφ)) (entails_iff.mp hx w hw)

/-- **No party of the first argument attacks a party of the second.** All the
first holds about the second's claims are the second's postulates, and the
second holds them too, with every claim it rests on, derives or concludes. -/
theorem not_attacks_inl_inr (hαp : Satisfiable (HasPostulates.postulates (α := α)))
    {a : ArgumentPackage α} {b : ArgumentPackage β} (ha : Satisfiable a.held)
    (hb : Satisfiable b.held) (hest : Establishes b) :
    ¬ Attacks (a.inl cβ) (b.inr cα) := by
  have hA := fun ψ => entails_inr_iff (ψ := ψ) (held_inl cβ a) ha
  have hB := fun ψ => entails_inr_iff (ψ := ψ) (held_inr cα b) hαp
  have hs : ∀ ψ, (∼ rename Sum.inr ψ : Formula (α ⊕ β)) = rename Sum.inr (∼ψ) := fun _ => rfl
  have hP : ∀ φ ∈ HasPostulates.postulates (α := β), φ ∈ b.held :=
    fun _ h => List.mem_append_right _ h
  rintro (⟨φ, hφ, he⟩ | he | ⟨p, ψ, hm, -, hbψ, haψ⟩)
  · obtain ⟨φ₀, hφ₀, rfl⟩ := List.mem_map.mp hφ
    rw [hs, hA] at he
    exact not_entails_neg hP hb (entails_of_mem (List.mem_append_left _ hφ₀)) he
  · exact not_entails_neg hP hb (ArgumentPackage.entails_held hest) ((hA _).mp he)
  · obtain ⟨χ, -, hχ⟩ := List.mem_map.mp hm
    obtain ⟨-, ψ₀, -, -, rfl⟩ := rename_eq_imp hχ
    rw [hs, hA] at haψ
    rw [hB] at hbψ
    exact not_entails_neg hP hb hbψ haψ

/-- No party of the second argument attacks a party of the first. -/
theorem not_attacks_inr_inl (hβp : Satisfiable (HasPostulates.postulates (α := β)))
    {a : ArgumentPackage β} {b : ArgumentPackage α} (ha : Satisfiable a.held)
    (hb : Satisfiable b.held) (hest : Establishes b) :
    ¬ Attacks (a.inr cα) (b.inl cβ) := by
  have hA := fun ψ => entails_inl_iff (ψ := ψ) (held_inr cα a) ha
  have hB := fun ψ => entails_inl_iff (ψ := ψ) (held_inl cβ b) hβp
  have hs : ∀ ψ, (∼ rename Sum.inl ψ : Formula (α ⊕ β)) = rename Sum.inl (∼ψ) := fun _ => rfl
  have hP : ∀ φ ∈ HasPostulates.postulates (α := α), φ ∈ b.held :=
    fun _ h => List.mem_append_right _ h
  rintro (⟨φ, hφ, he⟩ | he | ⟨p, ψ, hm, -, hbψ, haψ⟩)
  · obtain ⟨φ₀, hφ₀, rfl⟩ := List.mem_map.mp hφ
    rw [hs, hA] at he
    exact not_entails_neg hP hb (entails_of_mem (List.mem_append_left _ hφ₀)) he
  · exact not_entails_neg hP hb (ArgumentPackage.entails_held hest) ((hA _).mp he)
  · obtain ⟨χ, -, hχ⟩ := List.mem_map.mp hm
    obtain ⟨-, ψ₀, -, -, rfl⟩ := rename_eq_imp hχ
    rw [hs, hA] at haψ
    rw [hB] at hbψ
    exact not_entails_neg hP hb hbψ haψ

end Sum

/-! ### The combined dispute -/

namespace Dispute

variable [HasPostulates α] [HasPostulates β] {ι κ : Type}

/-- A dispute's meaning postulates can hold together: any party's model is a
model of them. -/
theorem postulates_satisfiable (d : Dispute α ι) (i : ι) :
    Satisfiable (HasPostulates.postulates (α := α)) := by
  obtain ⟨w, hw⟩ := satisfiable_iff.mp (d.consistent i)
  exact satisfiable_iff.mpr ⟨w, fun φ hφ => hw φ (List.mem_append_right _ hφ)⟩

/-- **Two disputes heard as one**: both arguments' parties, over both arguments'
claims, kept apart. `cα` and `cβ` cite each argument's claims for the parties of
the other, which never mention them; `hα` and `hβ` say each argument's
postulates can hold together (`postulates_satisfiable`). -/
def sum (dα : Dispute α ι) (dβ : Dispute β κ) (cα : α → AtomMeta) (cβ : β → AtomMeta)
    (hα : Satisfiable (HasPostulates.postulates (α := α)))
    (hβ : Satisfiable (HasPostulates.postulates (α := β))) : Dispute (α ⊕ β) (ι ⊕ κ) where
  node
    | .inl i => (dα.node i).inl cβ
    | .inr j => (dβ.node j).inr cα
  consistent
    | .inl i => satisfiable_of_splitsAs (ArgumentPackage.held_inl cβ _) (dα.consistent i) hβ
    | .inr j => satisfiable_of_splitsAs (ArgumentPackage.held_inr cα _) hα (dβ.consistent j)
  sound
    | .inl i => ArgumentPackage.establishes_inl cβ (dα.sound i)
    | .inr j => ArgumentPackage.establishes_inr cα (dβ.sound j)
  rated
    | .inl i => dα.rated i
    | .inr j => dβ.rated j

/-- **Who defeats whom when two disputes are heard as one**: within each
argument, who defeated whom before; across them, no one. -/
theorem sum_defeats (dα : Dispute α ι) (dβ : Dispute β κ) (cα : α → AtomMeta)
    (cβ : β → AtomMeta) (hα hβ) (x y : ι ⊕ κ) :
    (dα.sum dβ cα cβ hα hβ).defeats x y ↔ Sum.LiftRel dα.defeats dβ.defeats x y := by
  rcases x with i | i <;> rcases y with j | j
  · exact (defeats_inl_iff cβ hβ _ _).trans
      (Sum.liftRel_inl_inl (r := dα.defeats) (s := dβ.defeats)).symm
  · exact iff_of_false (fun h => not_attacks_inl_inr cα cβ hα (dα.consistent i)
      (dβ.consistent j) (dβ.sound j) h.attacks) Sum.not_liftRel_inl_inr
  · exact iff_of_false (fun h => not_attacks_inr_inl cα cβ hβ (dβ.consistent i)
      (dα.consistent j) (dα.sound j) h.attacks) Sum.not_liftRel_inr_inl
  · exact (defeats_inr_iff cα hα _ _).trans
      (Sum.liftRel_inr_inr (r := dα.defeats) (s := dβ.defeats)).symm

end Dispute

namespace Solver.Finite

variable {ι κ : Type} {R : ι → ι → Prop} {S : κ → κ → Prop}

/-- The table of two disputes heard as one, from the two tables: each argument's
own, and no defeat across them. -/
def sum (F : Finite R) (G : Finite S) : Finite (Sum.LiftRel R S) where
  parties := F.parties.map .inl ++ G.parties.map .inr
  complete
    | .inl i => List.mem_append_left _ (List.mem_map_of_mem (F.complete i))
    | .inr j => List.mem_append_right _ (List.mem_map_of_mem (G.complete j))
  defeats
    | .inl i, .inl j => F.defeats i j
    | .inr i, .inr j => G.defeats i j
    | _, _ => false
  spec
    | .inl i, .inl j => Sum.liftRel_inl_inl.trans (F.spec i j)
    | .inl _, .inr _ => iff_of_false Sum.not_liftRel_inl_inr Bool.false_ne_true
    | .inr _, .inl _ => iff_of_false Sum.not_liftRel_inr_inl Bool.false_ne_true
    | .inr i, .inr j => Sum.liftRel_inr_inr.trans (G.spec i j)

end Solver.Finite

namespace Dispute

variable [HasPostulates α] [HasPostulates β] {ι κ : Type}

/-- **The combined dispute's table, from the two tables**: the form the verdict
solver computes with, for two disputes heard as one. No cell is decided again:
each argument's cells are its own table's, and the rest are empty. -/
def sumFinite {dα : Dispute α ι} {dβ : Dispute β κ} {cα : α → AtomMeta}
    {cβ : β → AtomMeta} {hα hβ} (F : Solver.Finite dα.defeats) (G : Solver.Finite dβ.defeats) :
    Solver.Finite (dα.sum dβ cα cβ hα hβ).defeats :=
  { F.sum G with spec := fun x y => (sum_defeats dα dβ cα cβ hα hβ x y).trans ((F.sum G).spec x y) }

end Dispute

end Testimony.Logic
