import Testimony.Semantics.Meaning
import Testimony.Arguments.BornInBethlehem

/-!
# Testimony.Meanings.BornInBethlehem — what each born in bethlehem claim says

**Not yet analysed.** Every atom is registered, with its citation's label and
marked unanalysed, so the argument is counted from the start
(`coverage`). Analysing one is replacing its case of `means` with a
`Statement`; `Testimony.Meanings.SolaFide` is the worked example.

**Looked at for joins, and none found.** The one pair of rivals is Keil and
Delitzsch's "Micah 5:2 is a forward-looking messianic prediction" and Brown's
"a near-term oracle about a contemporary Judaean ruler". They are left apart: a
reader who takes the oracle as fulfilled twice, in a ruler of Micah's day and in
the Messiah, holds both, as the virgin birth's near-term reply does for Isaiah
7:14 (`Testimony.Meanings.BornOfAVirgin`).
-/

namespace Testimony.Meanings.BornInBethlehem

open Testimony.Semantics
open Testimony.Arguments.BornInBethlehem (Claim cite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .micahPredictsBethlehem, .matthewQuotesMicah, .matthewIntendsFulfilment, .jesusBornInBethlehem
  , .micahIsNearTermOracle, .messiahBornInBethlehem, .jesusSatisfiesCriterion ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- What each atom of the argument says: not yet analysed. -/
instance meanings : HasMeanings Claim :=
  HasMeanings.ofLabels "Born in Bethlehem — Micah 5:2" all cite all_complete

/-- **None of the 7 atoms is analysed yet.** -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (0, 7) := by decide

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
@[bornInBethlehemDefs] theorem postulates_eq :
    (Testimony.Logic.HasPostulates.postulates : List (Testimony.Logic.Formula Claim)) =
      [] :=
  rfl

attribute [bornInBethlehemDefs] Testimony.Logic.ArgumentPackage.held


/-- With no postulates, a package's premises having a model is all a dispute
asks of it. -/
theorem satisfiable_held {a : Testimony.Logic.ArgumentPackage Claim}
    (h : Testimony.Logic.Satisfiable a.premises) : Testimony.Logic.Satisfiable a.held :=
  Testimony.Logic.ArgumentPackage.satisfiable_held_of_nil postulates_eq h

end Testimony.Meanings.BornInBethlehem
