import Testimony.Intertext
import Testimony.Logic.Package

/-!
# Testimony.Argument — Layer 6: criteria, claims, and conditional theorems

The shape of every result: *given premise package P, conclusion C follows*.

`Satisfies` was formerly a placeholder (`pkg.premises ≠ []`) because `Premise`
carried no propositional content. It is now grounded in `Establishes`: a person
satisfies a criterion when there exists a cited argument package, valid by
truth table, whose conclusion is labelled with that person and criterion.
-/

namespace Testimony

open Testimony.Logic

/-- A person referenced by historical or textual claims. -/
structure Person where
  name : String
deriving Repr, DecidableEq

/-- A criterion a candidate Messiah must satisfy, per some interpretation. -/
structure FulfillmentCriterion where
  /-- e.g. "born in Bethlehem". -/
  name : String
  /-- Which reading of which passage grounds it. -/
  basis : Interpretation
deriving Repr

/-- A definition of "Messiah": a named set of criteria regarded as jointly
sufficient by some tradition. -/
structure MessiahDefinition where
  /-- The tradition's name for this definition. -/
  name : String
  /-- The criteria it regards as jointly sufficient. -/
  criteria : List FulfillmentCriterion
  /-- Who holds this definition. -/
  source : Source
deriving Repr

/-- The conclusion label a fulfilment argument must carry for its package to
count as a witness. Making the convention a function rather than a comment is
what lets `SatisfactionWitness.concludes` check it. -/
def fulfillmentLabel (person : Person) (c : FulfillmentCriterion) : String :=
  person.name ++ " satisfies: " ++ c.name

/-- Evidence that a person satisfies a criterion: a cited argument package,
valid over all valuations, whose conclusion is labelled for that person and
criterion.

The atom type is a field, so different arguments may use different atoms; this
places the structure in `Type 1`, which is harmless here. -/
structure SatisfactionWitness (person : Person) (c : FulfillmentCriterion) where
  /-- The atom type of the argument. -/
  α : Type
  /-- Atoms must be comparable for the truth-table check. -/
  decEq : DecidableEq α
  /-- Atoms must be finitely enumerable for the truth-table check. -/
  finite : FiniteAtoms α
  /-- The cited argument. -/
  pkg : ArgumentPackage α
  /-- Its premises entail its conclusion. -/
  valid : @Establishes α decEq finite pkg
  /-- Its conclusion is the one claimed. -/
  concludes : pkg.conclusionLabel = fulfillmentLabel person c

/-- Under some cited and valid argument, `person` satisfies `c`. -/
def Satisfies (person : Person) (c : FulfillmentCriterion) : Prop :=
  Nonempty (SatisfactionWitness person c)

/-- `person` meets definition `d` when every criterion is satisfied. -/
def MeetsDefinition (person : Person) (d : MessiahDefinition) : Prop :=
  ∀ c ∈ d.criteria, Satisfies person c

/-- Structural lemma: meeting a definition with more criteria implies meeting
one with a subset of them. -/
theorem meets_of_subset (person : Person) (d₁ d₂ : MessiahDefinition)
    (hsub : ∀ c ∈ d₂.criteria, c ∈ d₁.criteria)
    (h : MeetsDefinition person d₁) : MeetsDefinition person d₂ :=
  fun c hc => h c (hsub c hc)

/-- Structural lemma: an empty definition is met vacuously — a reminder that
a "Messiah definition" with no criteria proves nothing. -/
theorem meets_empty (person : Person) (d : MessiahDefinition)
    (h : d.criteria = []) : MeetsDefinition person d := by
  intro c hc
  simp [h] at hc

end Testimony
