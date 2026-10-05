import Testimony.Semantics.Meaning
import Testimony.Arguments.SpiritBaptism.Sources

/-!
# Testimony.Meanings.SpiritBaptism — what each spirit baptism claim says

**Not yet analysed.** Every atom is registered, with its citation's label and
marked unanalysed, so the argument is counted from the start
(`coverage`). Analysing one is replacing its case of `means` with a
`Statement`; `Testimony.Meanings.SolaFide` is the worked example.
-/

namespace Testimony.Meanings.SpiritBaptism

open Testimony.Semantics
open Testimony.Arguments.SpiritBaptism (Claim cite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .cor12_13AllBaptizedInOneSpirit, .actsSpiritAfterBelieving, .acts10SpiritAsTheyHear
  , .acts2_38SpiritPromised, .cor12_13IsChristBaptizingInTheSpirit, .cor12_13IsBaptismByTheSpirit
  , .lukanSpiritBaptismIsEmpowerment, .actsNarrativesAreNormative, .actsEpisodesAreTransitions
  , .entireSanctificationIsSecondWork, .spiritGivenInWaterBaptism, .confirmationGivesPentecost
  , .spiritBaptismAtConversion, .secondSpiritBaptismToBeSought, .spiritGivenInTheSacraments ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- What each atom of the argument says: not yet analysed. -/
instance meanings : HasMeanings Claim :=
  HasMeanings.ofLabels "Spirit baptism" all cite all_complete

/-- **None of the 15 atoms is analysed yet.** -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (0, 15) := by decide

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
@[spiritBaptismDefs] theorem postulates_eq :
    (Testimony.Logic.HasPostulates.postulates : List (Testimony.Logic.Formula Claim)) =
      [] :=
  rfl

attribute [spiritBaptismDefs] Testimony.Logic.ArgumentPackage.held


/-- With no postulates, a package's premises having a model is all a dispute
asks of it. -/
theorem satisfiable_held {a : Testimony.Logic.ArgumentPackage Claim}
    (h : Testimony.Logic.Satisfiable a.premises) : Testimony.Logic.Satisfiable a.held :=
  Testimony.Logic.ArgumentPackage.satisfiable_held_of_nil postulates_eq h

end Testimony.Meanings.SpiritBaptism
