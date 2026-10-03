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

end Testimony.Meanings.CanonicalWitness
