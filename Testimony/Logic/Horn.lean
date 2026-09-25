import Testimony.Logic.Dispute

/-!
# Testimony.Logic.Horn — deciding who attacks whom

Every relation a dispute is built from comes down to one question: **can these
formulas all be true together?**

- `a` undermines `b` on `φ` exactly when `a`'s premises and `φ` cannot all hold
  (`entails_neg_iff`).
- `a` rebuts `b` exactly when `a`'s premises and `b`'s conclusion cannot all
  hold.
- `a` does *not* attack `b` exactly when each of those can.

The library's packages are written as clauses: atoms, denials of atoms, and
steps from a conjunction of atoms and denied atoms to an atom, a conjunction of
atoms, or a contradiction. Almost all are Horn clauses, whose satisfiability is
decided by forward chaining (Dowling and Gallier, "Linear-time algorithms for
testing the satisfiability of propositional Horn formulae", *J. Logic
Programming* 1(3), 1984). A few are not: the critics' step
`¬nomism ∧ galatians → worksGenerally` is the clause *from Galatians, nomism or
works in general*, with two heads. So the procedure here is unit propagation,
which is forward chaining over literals: settle every atom that some clause
forces true or false given what is already settled, until nothing changes.

## A decision that returns its evidence

`satisfiable?` answers `some true`, `some false`, or `none`, and each answer
carries its own proof:

- **`some true`** is returned only after checking that a candidate valuation
  satisfies every clause. There are two candidates — the atoms forced true and
  no others, and every atom not forced false — because a clause with two heads
  can be left unsettled, and the first candidate then makes both heads false.
  The checked candidate is the evidence (`satisfiable_of_satisfiable?`).
- **`some false`** is returned only when a clause is violated by settled atoms,
  and a settled atom has its value in every model of the clauses. The
  propagation is the evidence (`not_satisfiable_of_satisfiable?`).
- **`none`** is returned for a formula with no clauses — a disjunction, or an
  implication inside an antecedent — or if neither candidate is a model and no
  clause is violated. It claims nothing.

So the theorems here run in one direction, from the computed answer to the
property, and none of them depends on the procedure being complete or on how
many passes it takes. A procedure that gave up more often would prove fewer
relations; it could not prove a false one. On Horn clauses it is complete, and
on every dispute in the library it decides every pair. The kernel evaluates
the procedure itself — by `decide +kernel`, which adds no axiom, unlike the
banned `native_decide` — so a relation between two packages is one line.

## What it replaces

Before this, each defeat was an entailment proved by hand and each non-defeat a
countermodel checked premise by premise, with the case split over the target's
premises counted out by hand. `defeats?` decides both in one computation, and
`defeats_iff_of_defeats?` turns its answer into the `Defeats` statement the rest
of the library reasons about.
-/

namespace Testimony.Logic.Horn

variable {α : Type}

/-- A clause: if every atom of `body` holds, so does one of `heads`. With no
heads, the body cannot hold at all; with one, the clause is a Horn clause. -/
structure Clause (α : Type) where
  /-- The atoms that must all hold for the clause to fire. -/
  body : List α
  /-- What the clause forces when it fires: one of these atoms. -/
  heads : List α

/-- A valuation satisfies a clause. -/
def Clause.Holds (w : Valuation α) (c : Clause α) : Prop :=
  (∀ a ∈ c.body, w a) → ∃ h ∈ c.heads, w h

/-! ### From formulas to clauses -/

/-- The truth conditions of the constructors, as the translation below matches
on them. Foundation's own lemmas are stated over its notation; these are the
same facts, by definition. -/
theorem models_and {w : Valuation α} {φ ψ : Formula α} :
    w ⊧ FFL.Propositional.Formula.and φ ψ ↔ w ⊧ φ ∧ w ⊧ ψ := Iff.rfl

@[inherit_doc models_and]
theorem models_imp {w : Valuation α} {φ ψ : Formula α} :
    w ⊧ FFL.Propositional.Formula.imp φ ψ ↔ (w ⊧ φ → w ⊧ ψ) := Iff.rfl

@[inherit_doc models_and]
theorem not_models_falsum {w : Valuation α} :
    ¬ w ⊧ (FFL.Propositional.Formula.falsum : Formula α) := id

@[inherit_doc models_and]
theorem models_atom {w : Valuation α} {a : α} :
    w ⊧ FFL.Propositional.Formula.atom a ↔ w a := Iff.rfl

/-- The literals of an antecedent, if it is a conjunction of atoms and denied
atoms: the atoms it asserts, and the atoms it denies. `⊤` is the empty
conjunction. A denied atom in an antecedent moves to the clause's heads —
`¬a ∧ b → c` is the clause from `b` to `a` or `c`. -/
def bodyLits : Formula α → Option (List α × List α)
  | .atom a => some ([a], [])
  | .imp (.atom a) .falsum => some ([], [a])
  | .and φ ψ => (bodyLits φ).bind fun l => (bodyLits ψ).map fun r => (l.1 ++ r.1, l.2 ++ r.2)
  | .imp .falsum .falsum => some ([], [])
  | _ => none

/-- The clauses saying that `body` forces the formula, one of the atoms `heads`
aside: an atom, a contradiction, a conjunction of those, or an implication from
a conjunction of literals to one of them — curried, so that `a ➝ (b ➝ ⊥)`, the
shape of a step that denies an atom, is the clause from `a` and `b` to a
contradiction. An implication from `⊥`, which includes `⊤`, forces nothing. -/
def headClauses (body heads : List α) : Formula α → Option (List (Clause α))
  | .atom h => some [⟨body, h :: heads⟩]
  | .falsum => some [⟨body, heads⟩]
  | .and φ ψ =>
    (headClauses body heads φ).bind fun l => (headClauses body heads ψ).map (l ++ ·)
  | .imp .falsum _ => some []
  | .imp φ ψ => (bodyLits φ).bind fun b => headClauses (body ++ b.1) (heads ++ b.2) ψ
  | .or _ _ => none

/-- The clauses a formula says, if it can be written as clauses this way. A
disjunction cannot, and makes the whole formula `none`. -/
def toClauses (φ : Formula α) : Option (List (Clause α)) := headClauses [] [] φ

/-- The clauses of every formula in a list, if each has them. -/
def clausesOf : List (Formula α) → Option (List (Clause α))
  | [] => some []
  | φ :: rest => (toClauses φ).bind fun l => (clausesOf rest).map (l ++ ·)

theorem bodyLits_sound {w : Valuation α} :
    ∀ {φ : Formula α} {l : List α × List α}, bodyLits φ = some l →
      (w ⊧ φ ↔ (∀ a ∈ l.1, w a) ∧ ∀ a ∈ l.2, ¬ w a)
  | .atom a, l, h => by
    simp only [bodyLits, Option.some.injEq] at h; subst h; simp
  | .imp (.atom a) .falsum, l, h => by
    simp only [bodyLits, Option.some.injEq] at h; subst h
    simp [models_imp, not_models_falsum]
  | .and φ ψ, l, h => by
    simp only [bodyLits, Option.bind_eq_some_iff, Option.map_eq_some_iff] at h
    obtain ⟨l₁, h₁, l₂, h₂, rfl⟩ := h
    rw [models_and, bodyLits_sound h₁, bodyLits_sound h₂]
    simp only [List.mem_append]
    constructor
    · rintro ⟨⟨p₁, n₁⟩, p₂, n₂⟩
      exact ⟨fun a ha => ha.elim (p₁ a) (p₂ a), fun a ha => ha.elim (n₁ a) (n₂ a)⟩
    · rintro ⟨p, n⟩
      exact ⟨⟨fun a ha => p a (.inl ha), fun a ha => n a (.inl ha)⟩,
        fun a ha => p a (.inr ha), fun a ha => n a (.inr ha)⟩
  | .imp .falsum .falsum, l, h => by
    simp only [bodyLits, Option.some.injEq] at h; subst h
    simp [models_imp, not_models_falsum]
  | .falsum, _, h | .or _ _, _, h | .imp (.atom _) (.atom _) , _, h
  | .imp (.atom _) (.and _ _), _, h | .imp (.atom _) (.or _ _), _, h
  | .imp (.atom _) (.imp _ _), _, h | .imp (.and _ _) _, _, h
  | .imp (.or _ _) _, _, h | .imp (.imp _ _) _, _, h | .imp .falsum (.atom _), _, h
  | .imp .falsum (.and _ _), _, h | .imp .falsum (.or _ _), _, h
  | .imp .falsum (.imp _ _), _, h => by simp [bodyLits] at h

/-- **The translation is faithful**: `body` forcing the formula, unless one of
`heads` holds, is exactly every clause holding. -/
theorem headClauses_sound {w : Valuation α} :
    ∀ {φ : Formula α} {body heads : List α} {cs : List (Clause α)},
      headClauses body heads φ = some cs →
      (((∀ a ∈ body, w a) → (∃ h ∈ heads, w h) ∨ w ⊧ φ) ↔ ∀ c ∈ cs, c.Holds w)
  | .atom h, body, heads, cs, e => by
    simp only [headClauses, Option.some.injEq] at e; subst e
    simp only [Clause.Holds, List.mem_cons, List.not_mem_nil, or_false, forall_eq, models_atom,
      exists_eq_or_imp]
    exact ⟨fun p q => (p q).symm, fun p q => (p q).symm⟩
  | .falsum, body, heads, cs, e => by
    simp only [headClauses, Option.some.injEq] at e; subst e
    simp [Clause.Holds, not_models_falsum]
  | .and φ ψ, body, heads, cs, e => by
    simp only [headClauses, Option.bind_eq_some_iff, Option.map_eq_some_iff] at e
    obtain ⟨l₁, h₁, l₂, h₂, rfl⟩ := e
    rw [List.forall_mem_append, ← headClauses_sound h₁, ← headClauses_sound h₂, models_and]
    constructor
    · intro p
      exact ⟨fun hb => (p hb).imp id And.left, fun hb => (p hb).imp id And.right⟩
    · rintro ⟨p, q⟩ hb
      rcases p hb with h | h
      · exact .inl h
      · exact (q hb).imp id fun h' => ⟨h, h'⟩
  | .imp .falsum ψ, body, heads, cs, e => by
    simp only [headClauses, Option.some.injEq] at e; subst e
    simp [models_imp, not_models_falsum]
  | .imp (.atom a) ψ, body, heads, cs, e | .imp (.and φ₁ φ₂) ψ, body, heads, cs, e
  | .imp (.or φ₁ φ₂) ψ, body, heads, cs, e | .imp (.imp φ₁ φ₂) ψ, body, heads, cs, e => by
    simp only [headClauses, Option.bind_eq_some_iff] at e
    obtain ⟨b, hb, hh⟩ := e
    rw [← headClauses_sound hh, models_imp, bodyLits_sound hb]
    simp only [List.mem_append]
    constructor
    · intro p q
      have hb₁ : ∀ a ∈ body, w a := fun x hx => q x (.inl hx)
      have hb₂ : ∀ a ∈ b.1, w a := fun x hx => q x (.inr hx)
      by_cases hn : ∃ h ∈ b.2, w h
      · obtain ⟨h, hh, hw⟩ := hn
        exact .inl ⟨h, .inr hh, hw⟩
      · push Not at hn
        rcases p hb₁ with ⟨h, hh, hw⟩ | hψ
        · exact .inl ⟨h, .inl hh, hw⟩
        · exact .inr (hψ ⟨hb₂, hn⟩)
    · intro p q
      by_cases hψ : w ⊧ ψ
      · exact .inr fun _ => hψ
      · by_cases hall : ∀ x ∈ b.1, w x
        · rcases p fun x hx => hx.elim (q x) (hall x) with ⟨h, hh | hh, hw⟩ | hψ'
          · exact .inl ⟨h, hh, hw⟩
          · exact .inr fun ⟨_, hn⟩ => absurd hw (hn h hh)
          · exact absurd hψ' hψ
        · exact .inr fun ⟨hp, _⟩ => absurd hp hall
  | .or _ _, _, _, _, e => by simp [headClauses] at e

/-- A formula holds exactly when its clauses do. -/
theorem toClauses_sound {w : Valuation α} {φ : Formula α} {cs : List (Clause α)}
    (e : toClauses φ = some cs) : (w ⊧ φ ↔ ∀ c ∈ cs, c.Holds w) := by
  rw [← headClauses_sound e]
  simp

/-- Every formula of a list holds exactly when every clause of the list does. -/
theorem clausesOf_sound {w : Valuation α} :
    ∀ {Γ : List (Formula α)} {cs : List (Clause α)}, clausesOf Γ = some cs →
      ((∀ φ ∈ Γ, w ⊧ φ) ↔ ∀ c ∈ cs, c.Holds w)
  | [], cs, e => by simp only [clausesOf, Option.some.injEq] at e; subst e; simp
  | φ :: rest, cs, e => by
    simp only [clausesOf, Option.bind_eq_some_iff, Option.map_eq_some_iff] at e
    obtain ⟨l₁, h₁, l₂, h₂, rfl⟩ := e
    rw [List.forall_mem_cons, List.forall_mem_append, toClauses_sound h₁, clausesOf_sound h₂]

/-! ### Unit propagation -/

variable [DecidableEq α]

/-- What propagation has settled: atoms that hold in every model of the clauses,
and atoms that fail in every one. -/
structure Settled (α : Type) where
  /-- Atoms forced true. -/
  yes : List α
  /-- Atoms forced false. -/
  no : List α

/-- Settled atoms are *sound* for a valuation when it agrees with them. -/
def Settled.Sound (s : Settled α) (w : Valuation α) : Prop :=
  (∀ a ∈ s.yes, w a) ∧ ∀ a ∈ s.no, ¬ w a

/-- What one clause forces, given what is settled: if its body holds and all its
heads but one fail, that head; if all its heads fail and all its body but one
atom holds, the denial of that atom. -/
def propagate (s : Settled α) (c : Clause α) : Settled α :=
  if c.body.all (s.yes.elem ·) then
    match c.heads.filter (!s.no.elem ·) with
    | [h] => if s.yes.elem h then s else ⟨h :: s.yes, s.no⟩
    | _ => s
  else if c.heads.all (s.no.elem ·) then
    match c.body.filter (!s.yes.elem ·) with
    | [b] => if s.no.elem b then s else ⟨s.yes, b :: s.no⟩
    | _ => s
  else s

/-- One pass of propagation over every clause. -/
def pass (cs : List (Clause α)) (s : Settled α) : Settled α := cs.foldl propagate s

/-- Passes from `s`, at most `n` of them, stopping at the first that settles
nothing new. Propagation only ever adds atoms, so an unchanged count is an
unchanged state. -/
def chain (cs : List (Clause α)) : ℕ → Settled α → Settled α
  | 0, s => s
  | n + 1, s =>
    match pass cs s with
    | s' => if s'.yes.length == s.yes.length && s'.no.length == s.no.length then s'
      else chain cs n s'

/-- What propagation settles: at most one pass per clause, and one more. Each
productive pass settles at least one atom, so this is enough; but nothing below
depends on it, because an answer is only returned once it has been checked. -/
def settle (cs : List (Clause α)) : Settled α := chain cs (cs.length + 1) ⟨[], []⟩

/-- Whether a clause is violated outright by what is settled: its body holds and
every head fails. -/
def violated (s : Settled α) (c : Clause α) : Bool :=
  c.body.all (s.yes.elem ·) && c.heads.all (s.no.elem ·)

/-- Whether the valuation `v` satisfies a clause. -/
def satisfiedBy (v : α → Bool) (c : Clause α) : Bool :=
  !c.body.all v || c.heads.any v

/-- **Satisfiability, with its evidence.** `some true` when one of two candidate
models is checked to satisfy every clause — the atoms forced true and no others,
or every atom not forced false — `some false` when a clause is violated by what
every model must have, and `none` otherwise.

Two candidates because a clause with two heads, such as the critics' step
`¬nomism ∧ galatians → worksGenerally`, can be left unsettled by propagation:
the first candidate makes both heads false, and the second makes both true.
Either is a model only once it has been checked to be one. -/
def clausesSatisfiable? (cs : List (Clause α)) : Option Bool :=
  if cs.all (satisfiedBy ((settle cs).yes.elem ·)) then some true
  else if cs.all (satisfiedBy (!(settle cs).no.elem ·)) then some true
  else if cs.any (violated (settle cs)) then some false
  else none

theorem propagate_sound {c : Clause α} {w : Valuation α} (hc : c.Holds w)
    {s : Settled α} (hs : s.Sound w) : (propagate s c).Sound w := by
  obtain ⟨hy, hn⟩ := hs
  unfold propagate
  split
  · rename_i hbody
    have hbody : ∀ a ∈ c.body, w a := fun a ha =>
      hy a (by simpa using List.all_eq_true.mp hbody a ha)
    obtain ⟨h, hh, hw⟩ := hc hbody
    split
    · rename_i x hx
      split
      · exact ⟨hy, hn⟩
      · refine ⟨fun a ha => ?_, hn⟩
        rcases List.mem_cons.mp ha with rfl | ha
        · by_cases hno : s.no.elem h
          · exact absurd hw (hn h (by simpa using hno))
          · have : h ∈ c.heads.filter (!s.no.elem ·) := List.mem_filter.mpr ⟨hh, by simpa using hno⟩
            rw [hx] at this
            simp only [List.mem_singleton] at this
            exact this ▸ hw
        · exact hy a ha
    · exact ⟨hy, hn⟩
  · split
    · rename_i _ hheads
      split
      · rename_i x hx
        split
        · exact ⟨hy, hn⟩
        · refine ⟨hy, fun a ha => ?_⟩
          rcases List.mem_cons.mp ha with rfl | ha
          · intro hwa
            have hbody : ∀ b ∈ c.body, w b := by
              intro b hb
              by_cases hyes : s.yes.elem b
              · exact hy b (by simpa using hyes)
              · have : b ∈ c.body.filter (!s.yes.elem ·) :=
                  List.mem_filter.mpr ⟨hb, by simpa using hyes⟩
                rw [hx] at this
                simp only [List.mem_singleton] at this
                exact this ▸ hwa
            obtain ⟨h, hh, hw⟩ := hc hbody
            exact hn h (by simpa using List.all_eq_true.mp hheads h hh) hw
          · exact hn a ha
      · exact ⟨hy, hn⟩
    · exact ⟨hy, hn⟩

theorem pass_sound {cs : List (Clause α)} {w : Valuation α} (hw : ∀ c ∈ cs, c.Holds w)
    {s : Settled α} (hs : s.Sound w) : (pass cs s).Sound w := by
  unfold pass
  induction cs generalizing s with
  | nil => exact hs
  | cons c rest ih =>
    exact ih (fun c' hc' => hw c' (.tail _ hc')) (propagate_sound (hw c (.head _)) hs)

theorem chain_sound {cs : List (Clause α)} {w : Valuation α} (hw : ∀ c ∈ cs, c.Holds w) :
    ∀ n (s : Settled α), s.Sound w → (chain cs n s).Sound w
  | 0, _, hs => hs
  | n + 1, s, hs => by
    have h' := pass_sound hw hs
    simp only [chain]
    split
    · exact h'
    · exact chain_sound hw n _ h'

theorem settle_sound {cs : List (Clause α)} {w : Valuation α} (hw : ∀ c ∈ cs, c.Holds w) :
    (settle cs).Sound w :=
  chain_sound hw _ _ ⟨by simp, by simp⟩

omit [DecidableEq α] in
theorem holds_of_satisfiedBy {v : α → Bool} {c : Clause α} (h : satisfiedBy v c = true) :
    c.Holds (fun a => v a = true) := by
  intro hbody
  simp only [satisfiedBy, Bool.or_eq_true, Bool.not_eq_eq_eq_not, Bool.not_true,
    List.all_eq_false, List.any_eq_true] at h
  rcases h with ⟨a, ha, hna⟩ | hh
  · exact absurd (hbody a ha) (by simpa using hna)
  · exact hh

/-- `some true` is a model: whichever candidate was checked. -/
theorem satisfiable_of_clausesSatisfiable? {cs : List (Clause α)}
    (h : clausesSatisfiable? cs = some true) : ∃ w : Valuation α, ∀ c ∈ cs, c.Holds w := by
  unfold clausesSatisfiable? at h
  split at h
  · rename_i hall
    exact ⟨_, fun c hc => holds_of_satisfiedBy (List.all_eq_true.mp hall c hc)⟩
  · split at h
    · rename_i hall
      exact ⟨_, fun c hc => holds_of_satisfiedBy (List.all_eq_true.mp hall c hc)⟩
    · split at h <;> simp at h

/-- `some false` is a refutation: a clause is violated by what every model must
have, so there is none. -/
theorem not_satisfiable_of_clausesSatisfiable? {cs : List (Clause α)}
    (h : clausesSatisfiable? cs = some false) : ¬ ∃ w : Valuation α, ∀ c ∈ cs, c.Holds w := by
  rintro ⟨w, hw⟩
  unfold clausesSatisfiable? at h
  split at h
  · simp at h
  split at h
  · simp at h
  · split at h
    · rename_i hany
      obtain ⟨c, hc, hv⟩ := List.any_eq_true.mp hany
      simp only [violated, Bool.and_eq_true, List.all_eq_true, List.elem_eq_mem,
        decide_eq_true_eq] at hv
      obtain ⟨hy, hn⟩ := settle_sound hw
      obtain ⟨h, hh, hwh⟩ := hw c hc fun a ha => hy a (hv.1 a ha)
      exact hn h (hv.2 h hh) hwh
    · simp at h

/-! ### Formulas -/

/-- Whether a list of formulas can all hold together, decided through its
clauses: `none` if a formula is not Horn. -/
def satisfiable? (Γ : List (Formula α)) : Option Bool :=
  (clausesOf Γ).bind clausesSatisfiable?

theorem satisfiable_of_satisfiable? {Γ : List (Formula α)} (h : satisfiable? Γ = some true) :
    Satisfiable Γ := by
  simp only [satisfiable?, Option.bind_eq_some_iff] at h
  obtain ⟨cs, hcs, h⟩ := h
  obtain ⟨w, hw⟩ := satisfiable_of_clausesSatisfiable? h
  exact satisfiable_iff.mpr ⟨w, (clausesOf_sound hcs).mpr hw⟩

theorem not_satisfiable_of_satisfiable? {Γ : List (Formula α)}
    (h : satisfiable? Γ = some false) : ¬ Satisfiable Γ := by
  simp only [satisfiable?, Option.bind_eq_some_iff] at h
  obtain ⟨cs, hcs, h⟩ := h
  intro hs
  obtain ⟨w, hw⟩ := satisfiable_iff.mp hs
  exact not_satisfiable_of_clausesSatisfiable? h ⟨w, (clausesOf_sound hcs).mp hw⟩

omit [DecidableEq α] in
/-- Premises entail a negation exactly when they cannot hold together with what
it negates. This is what lets one satisfiability check decide an attack. -/
theorem entails_neg_iff {Γ : List (Formula α)} {φ : Formula α} :
    Entails Γ (∼φ) ↔ ¬ Satisfiable (Γ ++ [φ]) := by
  rw [entails_iff, satisfiable_iff]
  simp only [List.mem_append, List.mem_singleton, FFL.Semantics.Not.models_not]
  constructor
  · rintro h ⟨w, hw⟩
    exact h w (fun ψ hψ => hw ψ (.inl hψ)) (hw φ (.inr rfl))
  · intro h w hw hφ
    exact h ⟨w, fun ψ hψ => hψ.elim (hw ψ) (fun e => e ▸ hφ)⟩

/-! ### Attacks and defeats

The strengths of the two packages are arguments rather than computed inside:
a package's strength is a lookup of every atom's citation, which is by far the
most expensive part of a decision, and a dispute has each party's strength
proved once already. The theorems take those proofs, so a wrong strength cannot
be passed in. -/

/-- Whether `a`, of strength `s`, defeats `b` by undermining its premise `φ`:
`some true` if `a`'s premises cannot hold with `φ` and `φ` does not outrank `a`,
`some false` if either fails, `none` if a formula it needed has no clauses. -/
def undermines? (a b : ArgumentPackage α) (s : ℕ) (φ : Formula α) : Option Bool :=
  if Outranks b φ s then some false
  else (satisfiable? (a.premises ++ [φ])).map (!·)

/-- Whether `a`, of strength `s`, defeats `b`, of strength `t`, by rebutting its
conclusion, decided the same way. -/
def rebuts? (a b : ArgumentPackage α) (s t : ℕ) : Option Bool :=
  if s < t then some false
  else (satisfiable? (a.premises ++ [b.conclusion])).map (!·)

/-- Every way `a` could defeat `b`: the rebuttal, then each premise of `b`. -/
def defeatChecks (a b : ArgumentPackage α) (s t : ℕ) : List (Option Bool) :=
  rebuts? a b s t :: b.premises.map (undermines? a b s)

/-- Whether `a`, of strength `s`, defeats `b`, of strength `t`: `some true` if
any way succeeds, `some false` if every way is shown to fail, `none` if some
check was on a formula without clauses and none succeeded. -/
def defeats? (a b : ArgumentPackage α) (s t : ℕ) : Option Bool :=
  if (defeatChecks a b s t).any (· == some true) then some true
  else if (defeatChecks a b s t).all (· == some false) then some false
  else none

omit [DecidableEq α] in
theorem map_not_eq_some {o : Option Bool} {v : Bool} :
    o.map (!·) = some v ↔ o = some (!v) := by
  cases o with
  | none => simp
  | some x => cases x <;> cases v <;> simp

theorem undermines?_true {a b : ArgumentPackage α} {φ : Formula α}
    (h : undermines? a b a.strength φ = some true) :
    Entails a.premises (∼φ) ∧ ¬ Outranks b φ a.strength := by
  unfold undermines? at h
  split at h
  · simp at h
  · rename_i hno
    exact ⟨entails_neg_iff.mpr (not_satisfiable_of_satisfiable? (map_not_eq_some.mp h)), hno⟩

theorem undermines?_false {a b : ArgumentPackage α} {φ : Formula α}
    (h : undermines? a b a.strength φ = some false) :
    ¬ (Entails a.premises (∼φ) ∧ ¬ Outranks b φ a.strength) := by
  unfold undermines? at h
  rintro ⟨hent, hno⟩
  split at h
  · exact hno (by assumption)
  · exact entails_neg_iff.mp hent (satisfiable_of_satisfiable? (map_not_eq_some.mp h))

theorem rebuts?_true {a b : ArgumentPackage α}
    (h : rebuts? a b a.strength b.strength = some true) :
    Rebuts a b ∧ ¬ a.strength < b.strength := by
  unfold rebuts? at h
  split at h
  · simp at h
  · rename_i hno
    exact ⟨entails_neg_iff.mpr (not_satisfiable_of_satisfiable? (map_not_eq_some.mp h)), hno⟩

theorem rebuts?_false {a b : ArgumentPackage α}
    (h : rebuts? a b a.strength b.strength = some false) :
    ¬ (Rebuts a b ∧ ¬ a.strength < b.strength) := by
  unfold rebuts? at h
  rintro ⟨hr, hno⟩
  split at h
  · exact hno (by assumption)
  · exact entails_neg_iff.mp hr (satisfiable_of_satisfiable? (map_not_eq_some.mp h))

/-- A defeat, decided. -/
theorem defeats_of_defeats? {a b : ArgumentPackage α} {s t : ℕ}
    (hs : a.strength = s) (ht : b.strength = t) (h : defeats? a b s t = some true) :
    Defeats a b := by
  subst hs ht
  unfold defeats? at h
  split at h
  · rename_i hany
    obtain ⟨x, hx, hxt⟩ := List.any_eq_true.mp hany
    have hxt : x = some true := by simpa using hxt
    subst hxt
    rcases List.mem_cons.mp hx with hr | hu
    · exact .inr (rebuts?_true hr.symm)
    · obtain ⟨φ, hφ, he⟩ := List.mem_map.mp hu
      obtain ⟨hent, hno⟩ := undermines?_true he
      exact .inl ⟨φ, ⟨hφ, hent⟩, hno⟩
  · split at h <;> simp at h

/-- A non-defeat, decided. -/
theorem not_defeats_of_defeats? {a b : ArgumentPackage α} {s t : ℕ}
    (hs : a.strength = s) (ht : b.strength = t) (h : defeats? a b s t = some false) :
    ¬ Defeats a b := by
  subst hs ht
  unfold defeats? at h
  split at h
  · simp at h
  · split at h
    · rename_i hall
      have hall := List.all_eq_true.mp hall
      rintro (⟨φ, ⟨hφ, hent⟩, hno⟩ | hr)
      · have := hall _ (List.mem_cons_of_mem _ (List.mem_map_of_mem hφ))
        exact undermines?_false (by simpa using this) ⟨hent, hno⟩
      · have := hall _ List.mem_cons_self
        exact rebuts?_false (by simpa using this) hr
    · simp at h

/-- **A cell of a defeat table, from one computation.** If the decision agrees
with `P`, then `a` defeats `b` exactly when `P`. -/
theorem defeats_iff_of_defeats? {a b : ArgumentPackage α} {s t : ℕ} {P : Prop} [Decidable P]
    (hs : a.strength = s) (ht : b.strength = t) (h : defeats? a b s t = some (decide P)) :
    Defeats a b ↔ P := by
  by_cases hP : P
  · simp only [hP, decide_true] at h
    exact iff_of_true (defeats_of_defeats? hs ht h) hP
  · simp only [hP, decide_false] at h
    exact iff_of_false (not_defeats_of_defeats? hs ht h) hP

end Testimony.Logic.Horn
