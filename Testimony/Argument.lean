import Testimony.Intertext

/-!
# Testimony.Argument — Layer 6: criteria, claims, and conditional theorems

The shape of every result: *given premise package P, conclusion C follows*.
-/

namespace Testimony

/-- A person referenced by historical or textual claims. -/
structure Person where
  name : String
deriving Repr, DecidableEq

/-- A criterion a candidate Messiah must satisfy, per some interpretation. -/
structure FulfillmentCriterion where
  name : String              -- e.g. "born in Bethlehem"
  basis : Interpretation     -- which reading of which passage grounds it
deriving Repr

/-- A claim that a person satisfies a criterion, with provenance
(historical/textual evidence cited by `source`). -/
structure FulfillmentClaim where
  person : Person
  criterion : FulfillmentCriterion
  source : Source
deriving Repr

/-- A definition of "Messiah": a named set of criteria regarded as jointly
sufficient by some tradition. -/
structure MessiahDefinition where
  name : String
  criteria : List FulfillmentCriterion
  source : Source
deriving Repr

/-- A premise package: a named bundle of assumptions a theorem is conditional
on. The `Prop`-valued fields are hypotheses, not asserted facts. -/
structure PremisePackage where
  name : String
  premises : List Premise
deriving Repr

/-- Abstract satisfaction: under package `pkg`, person `p` satisfies
criterion `c`. Kept abstract; instantiated per-argument in `Arguments/`. -/
def Satisfies (pkg : PremisePackage) (p : Person) (c : FulfillmentCriterion) : Prop :=
  ∃ claim : FulfillmentClaim, claim.person = p ∧ claim.criterion.name = c.name ∧
    pkg.premises ≠ []   -- placeholder: real arguments supply substantive conditions

/-- Under package `pkg`, `p` meets definition `d` when every criterion is
satisfied. -/
def MeetsDefinition (pkg : PremisePackage) (p : Person) (d : MessiahDefinition) : Prop :=
  ∀ c ∈ d.criteria, Satisfies pkg p c

/-- Structural lemma: meeting a definition with more criteria implies meeting
one with a subset of them. -/
theorem meets_of_subset (pkg : PremisePackage) (p : Person)
    (d₁ d₂ : MessiahDefinition)
    (hsub : ∀ c ∈ d₂.criteria, c ∈ d₁.criteria)
    (h : MeetsDefinition pkg p d₁) : MeetsDefinition pkg p d₂ :=
  fun c hc => h c (hsub c hc)

/-- Structural lemma: an empty definition is met vacuously — a reminder that
a "Messiah definition" with no criteria proves nothing. -/
theorem meets_empty (pkg : PremisePackage) (p : Person)
    (d : MessiahDefinition) (h : d.criteria = []) : MeetsDefinition pkg p d := by
  intro c hc
  simp [h] at hc

end Testimony
