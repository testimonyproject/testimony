import Testimony.Semantics.Meaning
import Testimony.Arguments.CanonicalWitness.Sources

/-!
# Testimony.Meanings.CanonicalWitness — what each the canonical witness claim says

**Not yet analysed.** Every atom is registered, with its citation's label and
marked unanalysed, so the argument is counted from the start
(`coverage`). Analysing one is replacing its case of `means` with a
`Statement`; `Testimony.Meanings.SolaFide` is the worked example.
-/

namespace Testimony.Meanings.CanonicalWitness

open Testimony.Semantics
open Testimony.Arguments.CanonicalWitness (Claim cite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .romans3_28, .romans4_4_5, .galatians2_16, .galatians3_11, .ephesians2_8_9, .titus3_5
  , .hebrews10_38_39, .hebrews11_6, .john3_16_18, .john5_24, .john6_28_29, .acts10_43
  , .acts15_10_11, .luke7_50, .luke18_9_14, .james2_14_17, .james2_19, .james2_21_23, .james2_24
  , .jude20_21, .faithIsNecessary, .faithIsSufficient, .worksAreNotTheGround
  , .justificationByFaithAlone, .worksAreFruitOfFaith, .faithAloneNeverAlone
  , .james2TargetsDeadFaith, .jamesJustifiesDemonstratively
  , .justificationDistinctFromSanctification ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- What each atom of the argument says: not yet analysed. -/
instance meanings : HasMeanings Claim :=
  HasMeanings.ofLabels "The canonical witness" all cite all_complete

/-- **None of the 29 atoms is analysed yet.** -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (0, 29) := by decide

/-- **No joins yet**: with no meaning analysed, no claim's meaning excludes or
entails another's, so the argument's checks hold no postulates. Analysing a
meaning that does fails this until the pair is listed. -/
instance joins : HasJoins Claim where
  exclusions := []
  exclusions_pinned := by decide +kernel
  entailments := []
  entailments_pinned := by decide +kernel


/-- **No postulates**: with no joins, the argument's checks hold nothing besides
its premises. -/
@[canonicalWitnessDefs] theorem postulates_eq :
    (Testimony.Logic.HasPostulates.postulates : List (Testimony.Logic.Formula Claim)) =
      [] :=
  rfl

attribute [canonicalWitnessDefs] Testimony.Logic.ArgumentPackage.held


/-- With no postulates, a package's premises having a model is all a dispute
asks of it. -/
theorem satisfiable_held {a : Testimony.Logic.ArgumentPackage Claim}
    (h : Testimony.Logic.Satisfiable a.premises) : Testimony.Logic.Satisfiable a.held :=
  Testimony.Logic.ArgumentPackage.satisfiable_held_of_nil postulates_eq h

end Testimony.Meanings.CanonicalWitness
