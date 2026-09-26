import Testimony.Logic.Solver

/-!
# Testimony.Logic.Witness — a verdict, declared with its reason

`Testimony.Logic.Solver` decides a dispute's verdicts by enumerating every set
of parties. That proves them, and says nothing about why. Every other claim in
this library is declared with its witness — a refutation names its
countermodel, a satisfiability result its model, a `Grants` result its reading
— and this module does the same for verdicts: the verdict is stated with a
small, readable witness, and a checker proved sound once against
`Testimony.Logic.Framework` confirms it.

- **Nothing is grounded** (`groundedEmpty?`): a defeater for every party.
- **These parties are grounded** (`stages?`): stages, each defended by the
  ones before.
- **The grounded extension is exactly this** (`groundedExactly?`): stages, and
  for each party outside, an attacker the set leaves unanswered.
- **No admissible set holds `b`** (`indefensible?`): a strategy — the attacker
  `b` cannot answer, and why each answer to it fails.
- **Every preferred extension holds `a`** (`skeptical?`): `a` answers its
  attackers itself, and every party in conflict with it is indefensible.
- **Some preferred extension leaves `a` out** (`notSkeptical?`): an admissible
  set holding a party in conflict with `a`.
- **Some preferred extension holds `a`** (`credulous?`): an admissible set
  holding `a`.
- **This set is preferred** (`blocked?`): it is admissible, and everything
  outside it conflicts with something inside.

A witness is checked, never trusted: each checker is a Boolean computation the
kernel runs by `decide +kernel`, and each theorem below turns a successful check
into the statement `Framework` makes. So a wrong witness fails to check; it
cannot prove a wrong verdict.

## Why witnesses rather than enumeration

Checking a witness is polynomial — linear in its size, times the parties —
where enumeration is exponential in the parties. And a witness *is* the
explanation. `critical_denial_indefensible` is witnessed by one line: Postell
attacks the critical denial, and nothing answers Postell. That is the sentence a
reader wants, and now it is checked.

## The limit

The sceptical witness here is a sufficient condition, not a characterisation:
it covers a party that answers its own attackers and whose rivals cannot be
defended. The general form is a strategy in an argument game, and for sceptical
preferred acceptance the smallest such strategy can be exponentially large —
the problem is Π₂ᵖ-complete. Where no witness of this shape exists, the
enumerating solver remains available.
-/

namespace Testimony.Logic.Witness

open Framework Solver

variable {ι : Type} [DecidableEq ι] {R : ι → ι → Prop} (F : Finite R)

/-- `a` and `b` conflict: one defeats the other. -/
def conflicts (a b : ι) : Bool := F.defeats a b || F.defeats b a

/-- A table of pairs `(x, y)`, read as "`x` is answered by `y`": a defeater of
`x`, or the attacker `x` cannot answer. -/
abbrev Table (ι : Type) := List (ι × ι)

/-- The entry for `x` in a table. -/
def Table.lookup (t : Table ι) (x : ι) : Option ι := (t.find? (·.1 == x)).map (·.2)

theorem Table.lookup_mem {t : Table ι} {x y : ι} (h : t.lookup x = some y) : (x, y) ∈ t := by
  simp only [Table.lookup, Option.map_eq_some_iff] at h
  obtain ⟨⟨a, b⟩, hf, rfl⟩ := h
  have := List.find?_some hf
  simp only [beq_iff_eq] at this
  subst this
  exact List.mem_of_find?_eq_some hf

variable {F}

omit [DecidableEq ι] in
theorem conflicts_iff {a b : ι} : conflicts F a b = true ↔ R a b ∨ R b a := by
  simp [conflicts, F.spec]

/-! ### Nothing prevails -/

variable (F)

/-- Every party has a defeater, and the table names it. -/
def groundedEmpty? (t : Table ι) : Bool :=
  F.parties.all fun x => match t.lookup x with
    | some y => F.defeats y x
    | none => false

variable {F}

/-- **Nothing is grounded**, witnessed by a defeater for every party. -/
theorem grounded_eq_empty {t : Table ι} (h : groundedEmpty? F t = true) : grounded R = ∅ := by
  refine grounded_eq_empty_of_attacked fun x => ?_
  have := List.all_eq_true.mp h x (F.complete x)
  split at this
  · exact ⟨_, (F.spec _ _).mpr this⟩
  · simp at this

/-! ### What is grounded -/

variable (F)

/-- Each stage is defended by the parties of the stages before it. -/
def stagesFrom : List ι → List (List ι) → Bool
  | _, [] => true
  | acc, st :: rest => st.all (defends? F acc) && stagesFrom (acc ++ st) rest

/-- A witness that the parties of `sts` are grounded: stages, starting from
nothing. -/
def stages? (sts : List (List ι)) : Bool := stagesFrom F [] sts

variable {F}

omit [DecidableEq ι] in
theorem stagesFrom_sound :
    ∀ {acc : List ι} {sts : List (List ι)}, stagesFrom F acc sts = true →
      (∀ y ∈ acc, y ∈ grounded R) → ∀ x ∈ sts.flatten, x ∈ grounded R
  | _, [], _, _ => by simp
  | acc, st :: rest, h, hacc => by
    simp only [stagesFrom, Bool.and_eq_true, List.all_eq_true] at h
    obtain ⟨hst, hrest⟩ := h
    have hst' : ∀ x ∈ st, x ∈ grounded R := fun x hx => by
      rw [← characteristic_grounded]
      exact (defends?_iff.mp (hst x hx)).mono fun y hy => hacc y hy
    have hacc' : ∀ y ∈ acc ++ st, y ∈ grounded R := fun y hy =>
      (List.mem_append.mp hy).elim (hacc y) (hst' y)
    intro x hx
    rcases List.mem_append.mp (List.flatten_cons ▸ hx) with hx | hx
    · exact hst' x hx
    · exact stagesFrom_sound hrest hacc' x hx

omit [DecidableEq ι] in
/-- **These parties are grounded**, witnessed by stages. -/
theorem mem_grounded_of_stages {sts : List (List ι)} (h : stages? F sts = true) {x : ι}
    (hx : x ∈ sts.flatten) : x ∈ grounded R :=
  stagesFrom_sound h (by simp) x hx

variable (F)

/-- Every party outside `s` has an attacker, named in the table, that nothing in
`s` answers: so `s` defends nothing it does not already hold. -/
def closed? (s : List ι) (t : Table ι) : Bool :=
  F.parties.all fun x => s.elem x || match t.lookup x with
    | some y => F.defeats y x && !(s.any fun z => F.defeats z y)
    | none => false

/-- The grounded extension is exactly the parties of `sts`: they are grounded,
by the stages, and nothing else is, by the unanswered attackers. -/
def groundedExactly? (sts : List (List ι)) (t : Table ι) : Bool :=
  stages? F sts && closed? F sts.flatten t

variable {F}

/-- **The grounded extension, witnessed.** -/
theorem grounded_eq_of_witness {sts : List (List ι)} {t : Table ι}
    (h : groundedExactly? F sts t = true) : grounded R = toSet sts.flatten := by
  simp only [groundedExactly?, Bool.and_eq_true] at h
  obtain ⟨hst, hcl⟩ := h
  refine le_antisymm (OrderHom.lfp_le _ fun x hx => ?_) fun x hx => mem_grounded_of_stages hst hx
  have := List.all_eq_true.mp hcl x (F.complete x)
  simp only [Bool.or_eq_true, List.elem_eq_mem, decide_eq_true_eq] at this
  rcases this with hmem | hout
  · exact hmem
  · split at hout
    · rename_i y _
      simp only [Bool.and_eq_true, Bool.not_eq_eq_eq_not, Bool.not_true, List.any_eq_false,
        Bool.not_eq_true] at hout
      obtain ⟨z, hz, hzy⟩ := hx y ((F.spec _ _).mpr hout.1)
      exact absurd ((F.spec _ _).mp hzy) (by simp [hout.2 z hz])
    · simp at hout

/-! ### What cannot be defended -/

variable (F)

/-- `b` cannot be defended: the table names an attacker `c` of `b`, and every
party answering `c` either conflicts with `b` or cannot itself be defended.
`n` bounds the depth of the check. -/
def indefensibleN (t : Table ι) : ℕ → ι → Bool
  | 0, _ => false
  | n + 1, b => match t.lookup b with
    | some c => F.defeats c b && F.parties.all fun d =>
        !F.defeats d c || conflicts F d b || indefensibleN t n d
    | none => false

/-- `b` cannot be defended, by the strategy in the table. -/
def indefensible? (t : Table ι) (b : ι) : Bool := indefensibleN F t (t.length + 1) b

variable {F}

theorem indefensibleN_sound {t : Table ι} :
    ∀ {n : ℕ} {b : ι}, indefensibleN F t n b = true →
      ∀ S : Set ι, Admissible R S → b ∉ S
  | 0, _, h, _, _ => by simp [indefensibleN] at h
  | n + 1, b, h, S, hS => by
    intro hb
    simp only [indefensibleN] at h
    split at h
    · rename_i c _
      simp only [Bool.and_eq_true, List.all_eq_true, Bool.or_eq_true, Bool.not_eq_eq_eq_not,
        Bool.not_true] at h
      obtain ⟨hcb, hall⟩ := h
      obtain ⟨d, hd, hdc⟩ := hS.2 b hb c ((F.spec _ _).mpr hcb)
      rcases hall d (F.complete d) with (hn | hconf) | hind
      · simp [(F.spec _ _).mp hdc] at hn
      · rcases conflicts_iff.mp hconf with h | h
        · exact hS.1 d hd b hb h
        · exact hS.1 b hb d hd h
      · exact indefensibleN_sound hind S hS hd
    · simp at h

/-- **`b` cannot be defended**, witnessed by a strategy: no admissible set holds
it. -/
theorem not_mem_admissible_of_witness {t : Table ι} {b : ι} (h : indefensible? F t b = true)
    (S : Set ι) (hS : Admissible R S) : b ∉ S :=
  indefensibleN_sound h S hS

/-- **So no resolution accepts `b`.** -/
theorem not_credulously_accepted_of_witness {t : Table ι} {b : ι}
    (h : indefensible? F t b = true) : ¬ CredulouslyAccepted R b :=
  fun ⟨S, hS, hb⟩ => not_mem_admissible_of_witness h S hS.1 hb

/-! ### Sceptical and credulous acceptance -/

variable (F)

/-- `a` is accepted on every resolution: it does not defeat itself, it answers
each of its attackers itself, and every other party in conflict with it cannot
be defended, by the strategy in the table. -/
def skeptical? (t : Table ι) (a : ι) : Bool :=
  !F.defeats a a &&
  F.parties.all (fun b => !F.defeats b a || F.defeats a b) &&
  F.parties.all (fun x => x == a || !conflicts F x a || indefensible? F t x)

variable {F}

/-- **Accepted on every resolution**, witnessed: add `a` to any preferred
extension and it stays admissible, so maximality puts `a` in it. -/
theorem skeptically_accepted_of_witness {t : Table ι} {a : ι} (h : skeptical? F t a = true) :
    SkepticallyAccepted R a := by
  simp only [skeptical?, Bool.and_eq_true, Bool.not_eq_eq_eq_not, Bool.not_true,
    List.all_eq_true, Bool.or_eq_true, beq_iff_eq] at h
  obtain ⟨⟨haa, hself⟩, hriv⟩ := h
  have haa : ¬ R a a := fun h' => by simp [(F.spec _ _).mp h'] at haa
  intro P hP
  -- A party of `P` does not conflict with `a`: if it did, it could not be defended.
  have hfree : ∀ x ∈ P, ¬ R x a ∧ ¬ R a x := by
    intro x hx
    rcases hriv x (F.complete x) with (rfl | hn) | hind
    · exact ⟨haa, haa⟩
    · exact ⟨fun h' => by simp [conflicts, (F.spec _ _).mp h'] at hn,
        fun h' => by simp [conflicts, (F.spec _ _).mp h'] at hn⟩
    · exact absurd hx (not_mem_admissible_of_witness hind P hP.1)
  have hadm : Admissible R (insert a P) := by
    refine ⟨fun x hx y hy hxy => ?_, fun x hx => ?_⟩
    · rcases Set.mem_insert_iff.mp hx with hxa | hxP <;>
        rcases Set.mem_insert_iff.mp hy with hya | hyP
      · rw [hxa, hya] at hxy; exact haa hxy
      · rw [hxa] at hxy; exact (hfree y hyP).2 hxy
      · rw [hya] at hxy; exact (hfree x hxP).1 hxy
      · exact hP.1.1 x hxP y hyP hxy
    · rcases Set.mem_insert_iff.mp hx with hxa | hx
      · subst hxa
        intro b hb
        rcases hself b (F.complete b) with hn | hab
        · simp [(F.spec _ _).mp hb] at hn
        · exact ⟨x, Set.mem_insert _ _, (F.spec _ _).mpr hab⟩
      · exact (hP.1.2 x hx).mono (Set.subset_insert _ _)
  exact hP.2 hadm (Set.subset_insert _ _) (Set.mem_insert _ _)

variable (F)

/-- Some resolution leaves `a` out: `s` is admissible and holds `x`, which
conflicts with `a`. -/
def notSkeptical? (s : List ι) (x a : ι) : Bool :=
  admissible? F s && s.elem x && conflicts F x a

/-- Some resolution holds `a`: `s` is admissible and holds it. -/
def credulous? (s : List ι) (a : ι) : Bool := admissible? F s && s.elem a

/-- `s` is a preferred extension: admissible, and everything outside it
conflicts with something inside. -/
def blocked? (s : List ι) : Bool :=
  admissible? F s && F.parties.all fun x => s.elem x || s.any (conflicts F x)

variable {F}

/-- **Not accepted on every resolution**, witnessed by an admissible set that
holds a rival: it extends to a preferred extension, which cannot hold `a`. -/
theorem not_skeptically_accepted_of_witness {s : List ι} {x a : ι}
    (h : notSkeptical? F s x a = true) : ¬ SkepticallyAccepted R a := by
  simp only [notSkeptical?, Bool.and_eq_true, List.elem_eq_mem, decide_eq_true_eq] at h
  obtain ⟨⟨hadm, hx⟩, hconf⟩ := h
  obtain ⟨P, hsub, hP⟩ := (admissible?_iff.mp hadm).exists_preferred
  intro hsk
  rcases conflicts_iff.mp hconf with h | h
  · exact hP.1.1 x (hsub hx) a (hsk P hP) h
  · exact hP.1.1 a (hsk P hP) x (hsub hx) h

/-- **Accepted on some resolution**, witnessed by an admissible set holding
`a`. -/
theorem credulously_accepted_of_witness {s : List ι} {a : ι} (h : credulous? F s a = true) :
    CredulouslyAccepted R a := by
  simp only [credulous?, Bool.and_eq_true, List.elem_eq_mem, decide_eq_true_eq] at h
  obtain ⟨P, hsub, hP⟩ := (admissible?_iff.mp h.1).exists_preferred
  exact ⟨P, hP, hsub h.2⟩

/-- **A preferred extension**, witnessed: admissible, and blocked from growing. -/
theorem preferred_of_witness {s : List ι} (h : blocked? F s = true) : Preferred R (toSet s) := by
  simp only [blocked?, Bool.and_eq_true, List.all_eq_true, Bool.or_eq_true, List.elem_eq_mem,
    decide_eq_true_eq, List.any_eq_true] at h
  refine preferred_of_blocked (admissible?_iff.mp h.1) fun x hx => ?_
  rcases h.2 x (F.complete x) with hmem | ⟨y, hy, hc⟩
  · exact absurd hmem hx
  · exact ⟨y, hy, conflicts_iff.mp hc⟩

/-! ### Witnesses in a hearing

A hearing (`Finite.restrict`) has the heard parties as a subtype. These write
its witnesses in the parties' own names, dropping any entry that mentions a
party not heard; the checker then sees only what remains. -/

/-- A table, restricted to the parties satisfying `P`. -/
def Table.sub (P : ι → Prop) [DecidablePred P] (t : Table ι) : Table {x // P x} :=
  t.filterMap fun (a, b) => if ha : P a then if hb : P b then some (⟨a, ha⟩, ⟨b, hb⟩) else none
    else none

/-- A list of parties, restricted to those satisfying `P`. -/
def listSub (P : ι → Prop) [DecidablePred P] (l : List ι) : List {x // P x} :=
  l.filterMap fun a => if ha : P a then some ⟨a, ha⟩ else none

/-! ### Finding witnesses

The functions below search for witnesses. They are **not trusted** and carry no
proofs: what they return is declared in the argument file and checked by the
theorems above, so a wrong answer fails to check rather than proving anything.
Use them while writing a dispute — `#eval Witness.findSkeptical F a` — and copy
what they find into the file, where it becomes the verdict's stated reason. -/

variable (F)

/-- Search for a strategy showing `b` cannot be defended: try each attacker `c`
of `b` that `b` does not answer itself, and require every answer to `c` that
does not conflict with `b` to be indefensible in turn. `seen` stops the search
from going round a cycle. -/
def findIndefensibleN : ℕ → List ι → ι → Option (Table ι)
  | 0, _, _ => none
  | n + 1, seen, b =>
    F.parties.findSome? fun c =>
      -- An attacker `b` answers itself is no use: look for one it cannot.
      if !F.defeats c b || F.defeats b c then none else
      let answers := F.parties.filter fun d => F.defeats d c && !conflicts F d b
      if answers.any (seen.elem ·) then none else
      answers.foldl (fun acc d => acc.bind fun t =>
          (findIndefensibleN n (b :: seen) d).map (t ++ ·)) (some [(b, c)])

/-- Search for a strategy showing `b` cannot be defended. -/
def findIndefensible (b : ι) : Option (Table ι) :=
  findIndefensibleN F F.parties.length [] b

/-- Search for a sceptical witness for `a`: a strategy for every party in
conflict with it. -/
def findSkeptical (a : ι) : Option (Table ι) :=
  (F.parties.filter fun x => x != a && conflicts F x a).foldl
    (fun acc x => acc.bind fun t => (findIndefensible F x).map (t ++ ·)) (some [])

/-- A defeater for every party, if each has one. -/
def findDefeaters : Option (Table ι) :=
  F.parties.foldl (fun acc x => acc.bind fun t =>
    (F.parties.find? fun y => F.defeats y x).map fun y => t ++ [(x, y)]) (some [])

/-- The stages of the grounded extension, by iterating what is defended. -/
def findStages : List (List ι) :=
  (List.range F.parties.length).foldl (fun (acc : List ι × List (List ι)) _ =>
    let next := F.parties.filter fun x => !acc.1.elem x && defends? F acc.1 x
    if next.isEmpty then acc else (acc.1 ++ next, acc.2 ++ [next])) ([], []) |>.2

/-- For each party outside `s`, an attacker nothing in `s` answers. -/
def findUnanswered (s : List ι) : Table ι :=
  F.parties.filterMap fun x =>
    if s.elem x then none else
    (F.parties.find? fun y => F.defeats y x && !(s.any fun z => F.defeats z y)).map (x, ·)

/-! ### Sanity checks

A three-party cycle, each defeating the next: the smallest dispute with nothing
grounded and no party defensible. The witnesses that should check do, and ones
that should not are rejected — a wrong witness fails to check rather than
proving anything. -/

/-- Three parties, each defeating the next. -/
inductive Tri
  /-- Defeats `b`. -/
  | a
  /-- Defeats `c`. -/
  | b
  /-- Defeats `a`. -/
  | c
deriving DecidableEq

/-- Who defeats whom in the three-cycle. -/
def triDefeats : Tri → Tri → Bool
  | .a, .b => true
  | .b, .c => true
  | .c, .a => true
  | _, _ => false

/-- The three-cycle, in solver form. -/
def tri : Finite (fun x y => triDefeats x y = true) where
  parties := [.a, .b, .c]
  complete i := by cases i <;> decide
  defeats := triDefeats
  spec _ _ := Iff.rfl

/-- Nothing is grounded: each party has a defeater. -/
example : grounded (fun x y => triDefeats x y = true) = ∅ :=
  grounded_eq_empty (F := tri) (t := [(.a, .c), (.b, .a), (.c, .b)]) (by decide +kernel)

/-- No party can be defended: `a`'s attacker `c` is answered only by `b`, which
conflicts with `a`. -/
example (S : Set Tri) (hS : Admissible (fun x y => triDefeats x y = true) S) : Tri.a ∉ S :=
  not_mem_admissible_of_witness (F := tri) (t := [(.a, .c)]) (by decide +kernel) S hS

/-- A wrong witness is rejected: `a` does not answer `b`'s attack, it makes it. -/
example : indefensible? tri [(.a, .b)] .a = false := by decide +kernel

/-- A missing defeater is rejected. -/
example : groundedEmpty? tri [(.a, .c)] = false := by decide +kernel

/-- Nothing is sceptically accepted in the cycle, and the check says so. -/
example : skeptical? tri [(.b, .a), (.c, .b)] .a = false := by decide +kernel

end Testimony.Logic.Witness
