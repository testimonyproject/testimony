import Testimony.Logic.Framework
import Testimony.Logic.Package

/-!
# Testimony.Logic.Dispute — argument packages as the nodes of a dispute

`Testimony.Logic.Framework` says which positions survive a dispute, given a
relation saying who defeats whom. This module supplies the relation. It is not
stipulated: whether one package defeats another is a fact about their premises,
proved like any other result in the library.

## Attack: derived from entailment

One package **attacks** another in one of two ways, the two that structured
argumentation (ASPIC+; Modgil and Prakken, 2013) distinguishes for arguments
built from premises and inference steps:

- It **undermines** it when its premises entail the negation of one of the
  other's premises — it contradicts something the other rests on.
- It **rebuts** it when its premises entail the negation of the other's
  conclusion — it concludes the opposite.

Both are `Entails` facts, so both are proved by `establish`, and the absence of
either is proved by a countermodel. An attack is a theorem, and so is its
absence.

A reply that merely **refuses** a ground — declines to grant it, without
asserting its negation — attacks nothing. That is not a gap. It is a different
dialectical move, and `Line.onGrounds` is the right encoding of it: the
objection loses a ground, and what it was left with is a question about
entailment, which the library already asks.

## Defeat: attack, filtered by cited confidence

Attack alone is not enough, and the reason is structural rather than a matter
of taste. If one package contradicts a premise of another, the second holds
that premise and so entails the negation of anything concluded from its denial.
**Premise attacks between classical arguments come in pairs.** On symmetric
attack Dung's semantics collapse into a consistency check — Cayrol (1995)
showed that the stable extensions are then exactly the maximal consistent
subsets of the premises — and the one thing a dispute is for, one argument
prevailing over another, never happens.

What breaks the symmetry in the literature is a preference between arguments,
and this library already records one: every atom is cited with a `Confidence`.
An attack succeeds as a **defeat** unless what it attacks is strictly stronger
than the attacker. Strength is measured by the *weakest link* — the lowest
confidence among an argument's ranked premises — so an argument is no stronger
than the least supported thing it assumes.

- An **undermining** attack on a premise defeats unless that premise's rank is
  strictly higher than the attacker's strength.
- A **rebutting** attack defeats unless the rebutted argument is strictly
  stronger than the attacker.

Inference steps are weighed too, as ASPIC+'s weakest-link principle weighs
defeasible rules alongside premises. The confidence of the atoms a step joins
is not the confidence of the inference, so a step is rated on its own, by a
citation of its own: `disputed` when a cited source grants the step's grounds
and denies its conclusion. Without this, where an encoding puts a contested
move — in an atom, where it is rated, or in a step, where it was not — would
decide who prevails, and that is a modelling choice, not a fact about the
positions.

**This makes the confidence ratings load-bearing.** Before this module a
rating was information for a reader; in a dispute it decides who prevails. A
rating that is wrong can now change a result, and a disputed rating is a
disputed premise of every dispute that uses it.

## How a premise is ranked

A premise that is an atom ranks at the confidence its source is cited with. A
premise that *denies* an atom ranks as `disputed`, the lowest rank. The citation
for an atom rates the claim as its label states it; nothing in the library rates
that claim's denial, and a denial of a consensus claim does not inherit the
consensus. Ranking denials at the bottom is the conservative choice: a denial
never outranks anything by default.

Any other formula is an inference step, and ranks at the lowest of the
package's `inferences` — every step as weak as the weakest cited inference, the
same conservative choice. A package with no cited inference has unranked steps,
and a `Dispute` refuses it: every node must carry at least one.
-/

namespace Testimony

/-- The order on confidence: `disputed` lowest, `consensus` highest. -/
def Confidence.rank : Confidence → ℕ
  | .disputed => 0
  | .plausible => 1
  | .wellSupported => 2
  | .consensus => 3

end Testimony

namespace Testimony.Logic

open Testimony

variable {α : Type}

namespace ArgumentPackage

/-- The rank of the package's inference steps: the lowest confidence among its
cited inferences, if it cites any. -/
def inferenceRank (pkg : ArgumentPackage α) : Option ℕ :=
  match pkg.inferences with
  | [] => none
  | s :: rest => some ((rest.map (·.confidence.rank)).foldr min s.confidence.rank)

/-- The rank of a premise of this package, if it has one: an atom at its cited
confidence, a denied atom at the bottom, an inference step at the package's
inference rank. -/
def rankOf (pkg : ArgumentPackage α) : Formula α → Option ℕ
  | .atom a => some (pkg.cite a).source.confidence.rank
  | .imp (.atom _) .falsum => some 0
  | _ => pkg.inferenceRank

/-- **Weakest link**: the lowest rank among the package's ranked premises. A
package with no ranked premise is as strong as a package can be. -/
def strength (pkg : ArgumentPackage α) : ℕ :=
  (pkg.premises.filterMap pkg.rankOf).foldr min 3

end ArgumentPackage

/-- `a` **undermines** `b` on `φ`: `φ` is one of `b`'s premises, and `a`'s
premises entail its negation. -/
def UnderminesOn (a b : ArgumentPackage α) (φ : Formula α) : Prop :=
  φ ∈ b.premises ∧ Entails a.premises (∼φ)

/-- `a` **rebuts** `b`: `a`'s premises entail the negation of `b`'s
conclusion. -/
def Rebuts (a b : ArgumentPackage α) : Prop :=
  Entails a.premises (∼b.conclusion)

/-- `a` **attacks** `b`: it undermines one of `b`'s premises or rebuts its
conclusion. -/
def Attacks (a b : ArgumentPackage α) : Prop :=
  (∃ φ, UnderminesOn a b φ) ∨ Rebuts a b

/-- Premise `φ` of `b` is strictly stronger than an attacker of strength `s`. An
unranked premise — an uncited inference step — never is. -/
def Outranks (b : ArgumentPackage α) (φ : Formula α) (s : ℕ) : Prop :=
  match b.rankOf φ with
  | some r => s < r
  | none => False

instance (b : ArgumentPackage α) (φ : Formula α) (s : ℕ) :
    Decidable (Outranks b φ s) := by
  unfold Outranks; split <;> infer_instance

/-- `a` **defeats** `b`: it attacks `b`, and what it attacks is not strictly
stronger than it. -/
def Defeats (a b : ArgumentPackage α) : Prop :=
  (∃ φ, UnderminesOn a b φ ∧ ¬ Outranks b φ a.strength) ∨
  (Rebuts a b ∧ ¬ a.strength < b.strength)

/-- Defeat is attack that survives the preference. -/
theorem Defeats.attacks {a b : ArgumentPackage α} (h : Defeats a b) : Attacks a b := by
  rcases h with ⟨φ, hu, _⟩ | ⟨hr, _⟩
  · exact .inl ⟨φ, hu⟩
  · exact .inr hr

/-- **Two positions that can be held together do not attack each other.** If
one valuation satisfies both packages' premises and the second's conclusion,
then the first entails the negation of nothing the second rests on or
concludes.

This is how the absence of an attack is proved, and it is proved by naming the
reading on which both positions stand — the world in which neither has to give
way. -/
theorem not_attacks_of_joint_model {a b : ArgumentPackage α}
    (h : Satisfiable (a.premises ++ b.premises ++ [b.conclusion])) : ¬ Attacks a b := by
  obtain ⟨w, hw⟩ := satisfiable_iff.mp h
  have ha : ∀ φ ∈ a.premises, w ⊧ φ := fun φ hφ => hw φ (by simp [hφ])
  have hb : ∀ φ ∈ b.premises, w ⊧ φ := fun φ hφ => hw φ (by simp [hφ])
  have hc : w ⊧ b.conclusion := hw _ (by simp)
  rintro (⟨φ, hφ, hent⟩ | hent)
  · exact (entails_iff.mp hent w ha) (hb φ hφ)
  · exact (entails_iff.mp hent w ha) hc

/-- No attack, no defeat. -/
theorem not_defeats_of_joint_model {a b : ArgumentPackage α}
    (h : Satisfiable (a.premises ++ b.premises ++ [b.conclusion])) : ¬ Defeats a b :=
  fun hd => not_attacks_of_joint_model h hd.attacks

/-- **An argument never defeats itself** — if its premises can hold together and
deliver its conclusion. Undermining itself would make its premises inconsistent;
rebutting itself would make them entail both its conclusion and the conclusion's
negation. -/
theorem not_defeats_self {a : ArgumentPackage α} (hsat : Satisfiable a.premises)
    (hest : Establishes a) : ¬ Defeats a a := by
  obtain ⟨w, hw⟩ := satisfiable_iff.mp hsat
  intro hd
  rcases hd.attacks with ⟨φ, hφ, hent⟩ | hent
  · exact (entails_iff.mp hent w hw) (hw φ hφ)
  · exact (entails_iff.mp hent w hw) (entails_iff.mp hest w hw)

/-- **A dispute**: argument packages indexed by `ι`, each of them an argument in
the full sense — premises that can hold together, a conclusion they deliver,
and inferences someone has rated.

The fields are what make the nodes arguments rather than premise lists. A node
whose premises had no model would attack everything; a node that did not
establish its conclusion would be arguing for nothing; and a node with unrated
steps would be weighed by its premises alone, however contested its
inferences. -/
structure Dispute (α : Type) (ι : Type) where
  /-- The package at each node. -/
  node : ι → ArgumentPackage α
  /-- Every node's premises can hold together. -/
  consistent : ∀ i, Satisfiable (node i).premises
  /-- Every node establishes its conclusion. -/
  sound : ∀ i, Establishes (node i)
  /-- Every node's inference steps are rated. -/
  rated : ∀ i, (node i).inferences ≠ []

namespace Dispute

variable {ι : Type} (d : Dispute α ι)

/-- Who defeats whom in the dispute: derived, never stipulated. -/
def defeats (i j : ι) : Prop := Defeats (d.node i) (d.node j)

/-- No node defeats itself. -/
theorem not_defeats_self (i : ι) : ¬ d.defeats i i :=
  Logic.not_defeats_self (d.consistent i) (d.sound i)

/-- The dispute among some of the parties only: a hearing in which the others
are not heard. -/
def restrict (P : ι → Prop) : Dispute α {i // P i} :=
  ⟨fun i => d.node i.1, fun i => d.consistent i.1, fun i => d.sound i.1,
    fun i => d.rated i.1⟩

/-- In a hearing, who defeats whom is what it was in the full dispute. -/
theorem restrict_defeats (P : ι → Prop) (i j : {i // P i}) :
    (d.restrict P).defeats i j ↔ d.defeats i.1 j.1 := Iff.rfl

/-- The parties `l` **stand together**: one valuation satisfies every premise and
every conclusion of each of them. It is proved by naming that valuation — the
world in which none of them has to give way. -/
def StandTogether (l : List ι) : Prop :=
  Satisfiable (l.flatMap fun i => (d.node i).premises ++ [(d.node i).conclusion])

/-- **Parties that stand together do not defeat one another.** One named world
settles every ordered pair in the group at once. -/
theorem StandTogether.not_defeats {d : Dispute α ι} {l : List ι} (h : d.StandTogether l)
    {i j : ι} (hi : i ∈ l) (hj : j ∈ l) : ¬ d.defeats i j := by
  obtain ⟨w, hw⟩ := satisfiable_iff.mp h
  have holds : ∀ k ∈ l, (∀ φ ∈ (d.node k).premises, w ⊧ φ) ∧ w ⊧ (d.node k).conclusion :=
    fun k hk => ⟨fun φ hφ => hw φ (List.mem_flatMap.mpr ⟨k, hk, by simp [hφ]⟩),
      hw _ (List.mem_flatMap.mpr ⟨k, hk, by simp⟩)⟩
  refine not_defeats_of_joint_model (satisfiable_iff.mpr ⟨w, fun φ hφ => ?_⟩)
  simp only [List.mem_append, List.mem_singleton] at hφ
  rcases hφ with (hφ | hφ) | rfl
  · exact (holds i hi).1 φ hφ
  · exact (holds j hj).1 φ hφ
  · exact (holds j hj).2

end Dispute

/-- **An attack that the ratings block, and nothing else.** `a` is weaker than
`b`, so its rebuttal fails; and each of `b`'s premises can hold alongside all of
`a`'s, so it undermines nothing. -/
theorem not_defeats_of_outweighed {a b : ArgumentPackage α} (hweak : a.strength < b.strength)
    (hmodels : ∀ φ ∈ b.premises, Satisfiable (a.premises ++ [φ])) : ¬ Defeats a b := by
  rintro (⟨φ, ⟨hmem, hent⟩, _⟩ | ⟨_, hw⟩)
  · obtain ⟨w, hw⟩ := satisfiable_iff.mp (hmodels φ hmem)
    exact (entails_iff.mp hent w fun ψ hψ => hw ψ (by simp [hψ])) (hw φ (by simp))
  · exact hw hweak

/-- **An attack that is simply not there**, shown premise by premise. Each of
`b`'s premises can hold alongside all of `a`'s, so `a` undermines none; and `b`'s
conclusion can too, so `a` does not rebut it.

This is how the absence of a defeat is proved between positions that cannot
both be held — where `not_defeats_of_joint_model` does not apply, because no one
world holds both, but the conflict runs only one way. -/
theorem not_defeats_of_models {a b : ArgumentPackage α}
    (hunder : ∀ φ ∈ b.premises, Satisfiable (a.premises ++ [φ]))
    (hreb : Satisfiable (a.premises ++ [b.conclusion])) : ¬ Defeats a b := by
  rintro (⟨φ, ⟨hmem, hent⟩, _⟩ | ⟨hr, _⟩)
  · obtain ⟨w, hw⟩ := satisfiable_iff.mp (hunder φ hmem)
    exact (entails_iff.mp hent w fun ψ hψ => hw ψ (by simp [hψ])) (hw φ (by simp))
  · obtain ⟨w, hw⟩ := satisfiable_iff.mp hreb
    exact (entails_iff.mp hr w fun ψ hψ => hw ψ (by simp [hψ])) (hw _ (by simp))

/-- `defeat_table [defs] using [facts]` proves `d.defeats i j ↔ table i j` for
every pair of a finite dispute: it splits on both parties, reduces the table by
`defs`, and closes each goal from the diagonal or from one of `facts` — a
defeat, a non-defeat, or a `StandTogether` group, whose memberships it decides. -/
syntax "defeat_table" ppSpace "[" Lean.Parser.Tactic.simpLemma,+ "]" ppSpace "using"
  ppSpace "[" term,+ "]" : tactic

open Lean in
macro_rules
  | `(tactic| defeat_table [$ls,*] using [$facts,*]) => do
    let direct ← facts.getElems.mapM fun f => `(tacticSeq| exact $f)
    let grouped ← facts.getElems.mapM fun f =>
      `(tacticSeq| exact Dispute.StandTogether.not_defeats $f (by decide) (by decide))
    let diagonal ← `(tacticSeq| exact Dispute.not_defeats_self _ _)
    let alts := #[diagonal] ++ direct ++ grouped
    `(tactic| (intro i j; cases i <;> cases j <;>
        simp only [$ls,*, iff_true, iff_false] <;> first $[| $alts]*))

/-- `grounded_by n [lemmas]` proves `grounded R = S` for a finite dispute: `S` is
the `n`-th iterate of the characteristic function from `∅`, and defends nothing
more. Each membership is decided by `simp` with `lemmas` — the defeat table,
and the enumeration of the parties. -/
syntax "grounded_by" ppSpace num ppSpace "[" Lean.Parser.Tactic.simpLemma,+ "]" : tactic

macro_rules
  | `(tactic| grounded_by $n [$ls,*]) =>
    `(tactic|
        (refine Framework.grounded_eq_of_iterate $n ?_ ?_
         · ext a
           cases a <;> simp [Framework.characteristic, Framework.Defends, $ls,*]
         · intro a ha
           cases a <;> simp_all [Framework.characteristic, Framework.Defends, $ls,*]))

end Testimony.Logic
