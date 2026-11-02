import Testimony.Semantics.Grammar
import Testimony.Ontology.Shared
import Testimony.Logic.Package
import Testimony.Logic.Postulates

/-!
# Testimony.Semantics.Meaning — what an argument's claims mean

**A draft.** Every argument names its atomic claims in a type of its own, and a
`HasMeanings` instance says what each one asserts, as a `Statement`. The atoms
are not replaced, and the instance sits beside the argument as its `cite` does.
One thing is read from it: where two claims' meanings cannot both hold, the
pair is an **exclusion**, and its formula `a → ¬b` a **meaning postulate**.
Where one claim's meaning asserts all of another's, the pair is an
**entailment**, and its postulate `a → b`. Both are read for what the words
mean, not for the shape of the terms: each meaning is taken apart into what it
affirms and denies, and closed under the definitions the articles of
`Testimony.Ontology` write out (`Testimony.Semantics.Ontology`). Each argument
lists its exclusions
and entailments, and proves the lists are exactly what its meanings contain
(`HasJoins`); from those lists, and only from them, the argument's atoms get
their postulates (`Testimony.Logic.HasPostulates`). A
credibility check holds them as background (`Testimony.Logic.Dissent`), so that
the logic sees what the meanings say.

The instance lists every atom and proves the list complete, so a meaning cannot
silently miss one. An argument whose claims are not yet analysed still has an
instance — `HasMeanings.ofLabels`, which marks each atom unanalysed with its
citation's label — so it is counted, as unanalysed, rather than left out.
`Testimony.Checks.Meanings` fails the build for an argument with no instance at
all, so a new argument cannot be added without one.

Everything below asks its question of any argument, by its instance.
-/

namespace Testimony.Semantics

open Testimony.Logic

/-- **What an argument's claims mean.** Every atom, listed, and a meaning for
each. -/
class HasMeanings (α : Type) where
  /-- The argument's name, as its page names it. -/
  argument : String
  /-- Every atom of the argument. -/
  all : List α
  /-- What each atom asserts. -/
  means : α → Statement
  /-- The list has every atom. -/
  complete : ∀ a, a ∈ all

namespace Statement

/-- The statements a statement asserts together: `also` taken apart. -/
def parts : Statement → List Statement
  | .also s t => s.parts ++ t.parts
  | s => [s]

/-- Whether a statement is analysed throughout: no part of it is `opaque`.
Two unanalysed atoms may share a label; that says nothing about what they mean. -/
def analysed (s : Statement) : Bool := s.parts.all (!·.isOpaque)

/-- **Two meanings exclude each other** when, read for what their words mean
(`Testimony.Ontology.shared`), each can be held alone and not both together:
"the word means a verdict, and not making righteous" excludes "the word means
making righteous" (sola fide's lexical claim and Trent's reading of Paul's
word); "justification includes the remission of sins, and not sanctification"
excludes "justification includes both"; and "faith is the only means by which
justification is received" excludes "baptism is a means by which it is". -/
def excludes (s t : Statement) : Bool :=
  Ontology.excludeEachOther Testimony.Ontology.shared s t

/-- **One meaning entails another** when, read for what its words mean, it
asserts all the other does: "the word means a verdict, and not making righteous"
entails "the word means a verdict". A reader who holds the one holds the
other. -/
def entails (s t : Statement) : Bool :=
  Ontology.entails Testimony.Ontology.shared (Ontology.closed Testimony.Ontology.shared s)
    (Ontology.closed Testimony.Ontology.shared t)

end Statement

namespace HasMeanings

/-- **Meanings not yet analysed**: each atom marked `opaque`, with its
citation's label. Where an argument starts, so that it is counted from the
start. -/
def ofLabels {α : Type} (argument : String) (all : List α) (cite : α → AtomMeta)
    (complete : ∀ a, a ∈ all) : HasMeanings α :=
  { argument, all, complete, means := fun a => .opaque (cite a).label }

variable {α : Type} [HasMeanings α]

/-- The atoms whose meaning is not yet analysed. -/
def unanalysed : List α := (all : List α).filter fun a => (means a).isOpaque

/-- How many atoms have a meaning, out of how many. -/
def coverage : Nat × Nat :=
  ((all : List α).length - (unanalysed (α := α)).length, (all : List α).length)

/-- Every word the argument gives two senses at one place. -/
def contested : List (Lexeme × Scope × Sense × Sense) :=
  readTwoWays ((all : List α).map means)

/-- Every pair from a list, each once, in the list's order. -/
def pairsOf {β : Type} : List β → List (β × β)
  | [] => []
  | x :: xs => xs.map (x, ·) ++ pairsOf xs

/-- **Every pair of claims whose meanings exclude each other**, under a given
ontology, by definition: `(a, b)`, with `a` listed before `b`, when the two
meanings, read for what their words mean, cannot both be held. Every pair is
checked; `exclusionsUnder` computes the same list through shared keys. -/
def exclusionsByPairs [DecidableEq α] (O : Ontology) : List (α × α) :=
  let shaped := (all : List α).map fun a => (a, Ontology.closed O (means a))
  (pairsOf shaped).filterMap fun ((a, s), (b, t)) =>
    if a ≠ b && Ontology.excludes O s t then some (a, b) else none

/-! #### Exclusions through shared keys

Two coherent meanings clash only where they share a key
(`Testimony.Semantics.Ontology.shares_of_clash`): a fact, or a thing a relation
is about. So the claims are taken from the last to the first, each against an
index from every key to the later claims that hold it, and each claim is
checked only against the claims it shares a key with. A pair sharing nothing is
never compared, which is almost every pair: checking all of them was what made
an argument's joins dear, quadratic in its claims and each check a comparison
of whole facts. The list found is the definition's, pair for pair and in the
same order (`exclusionsUnder_eq`). -/

/-- An index from keys to the claims holding them. -/
abbrev KeyIndex (α : Type) := List (Ontology.Key × List α)

/-- The claims the index holds under a key. -/
def KeyIndex.find : KeyIndex α → Ontology.Key → List α
  | [], _ => []
  | (k', as) :: rest, k => if k' = k then as else KeyIndex.find rest k

/-- The index with one more claim under a key. -/
def KeyIndex.add : KeyIndex α → Ontology.Key → α → KeyIndex α
  | [], k, a => [(k, [a])]
  | (k', as) :: rest, k, a =>
    if k' = k then (k', a :: as) :: rest else (k', as) :: KeyIndex.add rest k a

omit [HasMeanings α] in
theorem KeyIndex.find_add (ix : KeyIndex α) (k k' : Ontology.Key) (a : α) :
    KeyIndex.find (KeyIndex.add ix k a) k' =
      if k = k' then a :: KeyIndex.find ix k' else KeyIndex.find ix k' := by
  induction ix with
  | nil => by_cases h : k = k' <;> simp [KeyIndex.add, KeyIndex.find, h]
  | cons e rest ih =>
    obtain ⟨k'', as⟩ := e
    by_cases h₁ : k'' = k
    · subst h₁
      by_cases h₂ : k'' = k' <;> simp [KeyIndex.add, KeyIndex.find, h₂]
    · by_cases h₂ : k'' = k'
      · subst h₂
        simp [KeyIndex.add, KeyIndex.find, h₁, Ne.symm h₁]
      · simp [KeyIndex.add, KeyIndex.find, h₁, h₂, ih]

omit [HasMeanings α] in
theorem KeyIndex.mem_find_foldl_add (ks : List Ontology.Key) (a b : α) (k : Ontology.Key) :
    ∀ ix : KeyIndex α, b ∈ KeyIndex.find (ks.foldl (fun ix k => KeyIndex.add ix k a) ix) k ↔
      b ∈ KeyIndex.find ix k ∨ (k ∈ ks ∧ b = a) := by
  induction ks with
  | nil => simp
  | cons k₀ ks ih =>
    intro ix
    rw [List.foldl_cons, ih, KeyIndex.find_add]
    by_cases h : k₀ = k
    · subst h; simp only [if_true, List.mem_cons, true_or, true_and]; tauto
    · simp only [h, if_false, List.mem_cons]
      constructor
      · rintro (h' | ⟨hk, rfl⟩)
        · exact .inl h'
        · exact .inr ⟨.inr hk, rfl⟩
      · rintro (h' | ⟨hk | hk, rfl⟩)
        · exact .inl h'
        · exact absurd hk.symm h
        · exact .inr ⟨hk, rfl⟩

/-- The exclusions among a list of claims, and the index of the coherent ones
by key: the claims from the last to the first, each checked against the later
claims it shares a key with. -/
def exclusionsGo [DecidableEq α] (O : Ontology) : List α → List (α × α) × KeyIndex α
  | [] => ([], [])
  | a :: xs =>
    match exclusionsGo O xs with
    | (acc, ix) =>
      let s := Ontology.closed O (means a)
      let c := Ontology.coherent O s
      let ks := Ontology.keysOf s
      let near := if c then ks.flatMap (KeyIndex.find ix) else []
      let found := xs.filterMap fun b =>
        let t := Ontology.closed O (means b)
        if near.contains b && a ≠ b && Ontology.clash O (s.lits ++ t.lits) (s.nogoods ++ t.nogoods)
        then some (a, b) else none
      (found ++ acc, if c then ks.foldl (fun ix k => KeyIndex.add ix k a) ix else ix)

theorem mem_find_exclusionsGo [DecidableEq α] (O : Ontology) (k : Ontology.Key) (b : α) :
    ∀ xs : List α, b ∈ KeyIndex.find (exclusionsGo O xs).2 k ↔
      b ∈ xs ∧ Ontology.coherent O (Ontology.closed O (means b)) = true ∧
        k ∈ Ontology.keysOf (Ontology.closed O (means b))
  | [] => by simp [exclusionsGo, KeyIndex.find]
  | a :: xs => by
    have ih := mem_find_exclusionsGo O k b xs
    simp only [exclusionsGo]
    split
    · rename_i hc
      rw [KeyIndex.mem_find_foldl_add, ih]
      constructor
      · rintro (⟨hb, hcb, hkb⟩ | ⟨hk, rfl⟩)
        · exact ⟨List.mem_cons_of_mem _ hb, hcb, hkb⟩
        · exact ⟨List.mem_cons_self, hc, hk⟩
      · rintro ⟨hb, hcb, hkb⟩
        rcases List.mem_cons.mp hb with rfl | hb
        · exact .inr ⟨hkb, rfl⟩
        · exact .inl ⟨hb, hcb, hkb⟩
    · rename_i hc
      rw [ih]
      constructor
      · rintro ⟨hb, hcb, hkb⟩
        exact ⟨List.mem_cons_of_mem _ hb, hcb, hkb⟩
      · rintro ⟨hb, hcb, hkb⟩
        rcases List.mem_cons.mp hb with rfl | hb
        · exact absurd hcb (by simpa using hc)
        · exact ⟨hb, hcb, hkb⟩

theorem exclusionsGo_fst [DecidableEq α] (O : Ontology) : ∀ xs : List α,
    (exclusionsGo O xs).1 =
      (pairsOf (xs.map fun a => (a, Ontology.closed O (means a)))).filterMap
        fun ((a, s), (b, t)) => if a ≠ b && Ontology.excludes O s t then some (a, b) else none
  | [] => rfl
  | a :: xs => by
    have ih := exclusionsGo_fst O xs
    have hmem := fun k b => mem_find_exclusionsGo O k b xs
    rcases h : exclusionsGo O xs with ⟨acc, ix⟩
    rw [h] at ih hmem
    simp only at ih hmem
    simp only [exclusionsGo, h, List.map_cons, pairsOf, List.filterMap_append,
      List.filterMap_map, ← ih]
    congr 1
    apply List.filterMap_congr
    intro b hb
    simp only [Function.comp_apply, Ontology.excludes]
    by_cases hca : Ontology.coherent O (Ontology.closed O (means a)) = true
    · by_cases hcb : Ontology.coherent O (Ontology.closed O (means b)) = true
      · have hnear : ((Ontology.keysOf (Ontology.closed O (means a))).flatMap
            (KeyIndex.find ix)).contains b =
            (Ontology.keysOf (Ontology.closed O (means a))).any
              (· ∈ Ontology.keysOf (Ontology.closed O (means b))) := by
          apply Bool.eq_iff_iff.mpr
          simp only [List.contains_iff_mem, List.mem_flatMap, List.any_eq_true, decide_eq_true_eq,
            hmem]
          constructor
          · rintro ⟨k, hk, -, -, hkb⟩; exact ⟨k, hk, hkb⟩
          · rintro ⟨k, hk, hkb⟩; exact ⟨k, hk, hb, hcb, hkb⟩
        simp only [hca, hcb, if_true, hnear, Bool.true_and]
        by_cases hcl : Ontology.clash O ((Ontology.closed O (means a)).lits ++
            (Ontology.closed O (means b)).lits) ((Ontology.closed O (means a)).nogoods ++
            (Ontology.closed O (means b)).nogoods) = true
        · have hsa : Ontology.clash O (Ontology.closed O (means a)).lits
              (Ontology.closed O (means a)).nogoods = false := by
            simp only [Ontology.coherent, Bool.and_eq_true, Bool.not_eq_true'] at hca; exact hca.2
          have hsb : Ontology.clash O (Ontology.closed O (means b)).lits
              (Ontology.closed O (means b)).nogoods = false := by
            simp only [Ontology.coherent, Bool.and_eq_true, Bool.not_eq_true'] at hcb; exact hcb.2
          obtain ⟨k, hk, hkb⟩ := Ontology.shares_of_clash hsa hsb hcl
          have : (Ontology.keysOf (Ontology.closed O (means a))).any
              (· ∈ Ontology.keysOf (Ontology.closed O (means b))) = true :=
            List.any_eq_true.mpr ⟨k, hk, by simpa using hkb⟩
          simp only [this, hcl, Bool.true_and, Bool.and_true]
        · simp only [Bool.not_eq_true] at hcl
          simp [hcl]
      · simp only [Bool.not_eq_true] at hcb
        have hnear : ((Ontology.keysOf (Ontology.closed O (means a))).flatMap
            (KeyIndex.find ix)).contains b = false := by
          apply Bool.eq_false_iff.mpr
          intro hc
          obtain ⟨k, -, hk⟩ := List.mem_flatMap.mp (List.contains_iff_mem.mp hc)
          obtain ⟨-, hcb', -⟩ := (hmem k b).mp hk
          simp [hcb] at hcb'
        simp only [hca, if_true, hnear, hcb, Bool.false_and, Bool.and_false, Bool.false_eq_true,
          if_false]
    · simp only [Bool.not_eq_true] at hca
      simp [hca]

/-- **Every pair of claims whose meanings exclude each other**, under a given
ontology: `(a, b)`, with `a` listed before `b`, when the two meanings, read for
what their words mean, cannot both be held. Computed through shared keys, and
the same list as the definition, `exclusionsByPairs` (`exclusionsUnder_eq`). -/
def exclusionsUnder [DecidableEq α] (O : Ontology) : List (α × α) :=
  (exclusionsGo O (all : List α)).1

/-- **The exclusions through shared keys are the exclusions**, pair for pair and
in the same order. -/
theorem exclusionsUnder_eq [DecidableEq α] (O : Ontology) :
    exclusionsUnder (α := α) O = exclusionsByPairs O :=
  exclusionsGo_fst O _

/-- **Every pair of claims whose meanings entail one another**, under a given
ontology: `(a, b)` when the meaning of `a`, read for what its words mean,
asserts everything the meaning of `b` does. -/
def entailmentsUnder [DecidableEq α] (O : Ontology) : List (α × α) :=
  let shaped := (all : List α).map fun a => (a, Ontology.closed O (means a))
  shaped.flatMap fun (a, s) => shaped.filterMap fun (b, t) =>
    if a ≠ b && Ontology.entails O s t then some (a, b) else none

/-- **Every pair of claims whose meanings exclude each other**: `(a, b)`, with `a`
listed before `b`, when the two meanings cannot both be held, read under the
shared ontology (`Testimony.Ontology.shared`). Two claims the atom type keeps
apart, the meanings join: a reader who holds either must deny the other. -/
def exclusions [DecidableEq α] : List (α × α) := exclusionsUnder Testimony.Ontology.shared

/-- **Every pair of claims whose meanings entail one another**: `(a, b)` when
the meaning of `a` asserts everything the meaning of `b` does, read under the
shared ontology. A reader who holds `a` holds `b`. -/
def entailments [DecidableEq α] : List (α × α) := entailmentsUnder Testimony.Ontology.shared

/-- **The atoms whose meaning contradicts itself** under the shared ontology. A
meaning that cannot be held is a mistake in the meaning, and joins nothing. -/
def incoherent : List α :=
  (all : List α).filter fun a =>
    let s := Ontology.closed Testimony.Ontology.shared (means a)
    s.read && !Ontology.coherent Testimony.Ontology.shared s

/-- The atoms that turn on a word. -/
def about (w : Lexeme) : List α := (all : List α).filter fun a => (means a).mentions w

/-- The atoms that deny a word has the same sense at two places. -/
def denyingSameSense (w : Lexeme) (a b : Scope) : List α :=
  (all : List α).filter fun c => (means c).deniesSameSense w a b

end HasMeanings

/-- **An argument's joins, listed and pinned**: the pairs of its claims whose
meanings exclude or entail one another, written out for a reader, with the proof
that they are exactly what the meanings contain. A meaning added tomorrow that
joins two claims fails the proof until its pair is listed, so a change in what
the logic holds is a change a reviewer sees.

Every argument has one, if only with empty lists (`Testimony.Checks.Meanings`).
The lists are what the kernel reads: the proofs are checked once, here, and
every check over the atoms then holds literal lists rather than recomputing
them.

**Not a join: two senses of one word.** Two claims that read the same word in
different senses at one place are not held to exclude each other. Whether the
senses exclude each other is itself contested — Trent holds that justification
both declares and makes righteous — so a postulate saying they do would hand
one side's lexicon to both. A claim whose meaning says *and not that sense*
excludes the other; that is a join, and it is listed. -/
class HasJoins (α : Type) [HasMeanings α] [DecidableEq α] where
  /-- Each pair `(a, b)`, `a` listed first: the two meanings cannot both be
  held. -/
  exclusions : List (α × α)
  /-- No more, no fewer than the meanings contain. -/
  exclusions_pinned : exclusions = HasMeanings.exclusions (α := α)
  /-- Each pair `(a, b)`: the meaning of `a` asserts all the meaning of `b`
  does. -/
  entailments : List (α × α)
  /-- No more, no fewer than the meanings contain. -/
  entailments_pinned : entailments = HasMeanings.entailments (α := α)

namespace HasJoins

variable {α : Type} [HasMeanings α] [DecidableEq α]

/-- The postulate for one exclusion `(a, b)`: `a → ¬b`. -/
def exclusion (e : α × α) : Formula α :=
  .imp (.atom e.1) (.imp (.atom e.2) .falsum)

/-- The postulate for one entailment `(a, b)`: `a → b`. -/
def entailment (e : α × α) : Formula α :=
  .imp (.atom e.1) (.atom e.2)

/-- **The only source of an argument's postulates**: `a → ¬b` for each pinned
exclusion, and `a → b` for each pinned entailment. `Testimony.Checks.Meanings`
fails the build for an argument whose `HasPostulates` instance is any other. -/
instance toHasPostulates [HasJoins α] : HasPostulates α where
  postulates :=
    (exclusions (α := α)).map exclusion ++ (entailments (α := α)).map entailment

end HasJoins

end Testimony.Semantics
