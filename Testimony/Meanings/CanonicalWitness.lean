import Testimony.Semantics.Meaning
import Testimony.Arguments.CanonicalWitness.Sources

/-!
# Testimony.Meanings.CanonicalWitness — what each the canonical witness claim says

**Partly analysed.** Five claims have meanings: *faith alone*, its three parts,
and Westminster's "by faith alone, by a faith that is never alone", whose
meanings join them (`joins`). The rest are registered with their citations'
labels and marked unanalysed, so the argument is counted from the start
(`coverage_now`); `Testimony.Meanings.SolaFide` is the fuller worked example.

## What is joined, and what is not

- **Justification by faith alone asserts its three parts.** The argument
  defines it so: faith is necessary, faith is sufficient, and works are not the
  ground. The step from the parts to the whole (`toFaithAlone`) is the converse.
- **"By faith alone, by a faith that is never alone" asserts "by faith
  alone"**, and with it the three parts. Its second clause is not the claim that
  works are faith's fruit (Westminster XVI.2), so that is not joined to it.

Left apart, on purpose: James 2:24's "not by faith alone" and the doctrine. The
argument turns on James's meaning another faith (`james2TargetsDeadFaith`), and
a meaning that joined the words would decide that question before it is asked.
-/

namespace Testimony.Meanings.CanonicalWitness

open Testimony.Semantics Testimony.Semantics.Notation
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

/-- Faith is necessary for justification. -/
abbrev faithNecessary : Statement := .holds (rl .necessaryFor (cn .faith) (cn .justification))

/-- Faith suffices for justification. -/
abbrev faithSufficient : Statement := .holds (rl .sufficientFor (cn .faith) (cn .justification))

/-- Works are not the ground of justification. -/
abbrev worksNotGround : Statement := .holds (rl .excludedFrom (cn .works) (cn .justification))

/-- Justification by faith alone: its three parts. -/
abbrev byFaithAlone : Statement := .also faithNecessary (.also faithSufficient worksNotGround)

/-- **What each canonical witness atom asserts.** Five are analysed; the rest
keep their citations' labels, marked unanalysed. -/
def means : Claim → Statement
  | .faithIsNecessary => faithNecessary
  | .faithIsSufficient => faithSufficient
  | .worksAreNotTheGround => worksNotGround
  | .justificationByFaithAlone => byFaithAlone
  | .faithAloneNeverAlone =>
    .also byFaithAlone (.holds (rl .inseparableFrom (cn .faith) (cn .worksOfFaith)))
  | a => .opaque (cite a).label

/-- What each atom of the argument says. -/
instance meanings : HasMeanings Claim :=
  { argument := "The canonical witness", all, complete := all_complete, means }

/-- **Five of the 29 atoms are analysed**: *faith alone*, its parts, and
Westminster's "never alone". -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (5, 29) := by decide

/-- **The canonical witness joins**: no exclusions, and seven entailments —
*faith alone* asserts each of its three parts, and "by faith alone, by a faith
that is never alone" asserts *faith alone* and each part. Listed, and proved to
be exactly what the meanings contain. -/
instance joins : HasJoins Claim where
  exclusions := []
  exclusions_pinned := by decide +kernel
  entailments :=
    [ (.justificationByFaithAlone, .faithIsNecessary)
    , (.justificationByFaithAlone, .faithIsSufficient)
    , (.justificationByFaithAlone, .worksAreNotTheGround)
    , (.faithAloneNeverAlone, .faithIsNecessary)
    , (.faithAloneNeverAlone, .faithIsSufficient)
    , (.faithAloneNeverAlone, .worksAreNotTheGround)
    , (.faithAloneNeverAlone, .justificationByFaithAlone) ]
  entailments_pinned := by decide +kernel

open Testimony.Logic in
/-- **The postulates, written out**: `a → b` for each entailment. Proofs over the
argument's packages unfold to this list, so a named reading must satisfy it. -/
@[canonicalWitnessDefs] theorem postulates_eq :
    (HasPostulates.postulates : List (Formula Claim)) =
      [ p .justificationByFaithAlone ➝ p .faithIsNecessary
      , p .justificationByFaithAlone ➝ p .faithIsSufficient
      , p .justificationByFaithAlone ➝ p .worksAreNotTheGround
      , p .faithAloneNeverAlone ➝ p .faithIsNecessary
      , p .faithAloneNeverAlone ➝ p .faithIsSufficient
      , p .faithAloneNeverAlone ➝ p .worksAreNotTheGround
      , p .faithAloneNeverAlone ➝ p .justificationByFaithAlone ] :=
  rfl

attribute [canonicalWitnessDefs] Testimony.Logic.ArgumentPackage.held

end Testimony.Meanings.CanonicalWitness
