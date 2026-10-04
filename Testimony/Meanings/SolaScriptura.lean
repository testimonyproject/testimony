import Testimony.Semantics.Meaning
import Testimony.Arguments.SolaScriptura.Sources

/-!
# Testimony.Meanings.SolaScriptura — what each sola scriptura claim says

**Not yet analysed.** Every atom is registered, with its citation's label and
marked unanalysed, so the argument is counted from the start
(`coverage`). Analysing one is replacing its case of `means` with a
`Statement`; `Testimony.Meanings.SolaFide` is the worked example.
-/

namespace Testimony.Meanings.SolaScriptura

open Testimony.Semantics
open Testimony.Arguments.SolaScriptura (Claim cite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .timothy3_16GodBreathed, .timothy3_17ThoroughlyEquips, .mark7TraditionCanNullify
  , .acts17BereansTested, .thessalonians2_15TraditionBinding, .scriptureIsInfallible
  , .scriptureIsSufficient, .scriptureIsPerspicuous, .scriptureIsSoleInfallibleRule
  , .solaScripturaIsTaughtByScripture, .onlyScripturalDoctrineIsBinding, .noOtherRuleIsInfallible
  , .traditionIsCoordinateSourceOfRevelation, .magisteriumIsInfallible
  , .churchMindIsInfallibleInterpreter, .canonKnownThroughChurchReception
  , .identifyingCanonRequiresInfallibleAuthority, .rivalAuthorityIsAlsoSelfAuthenticating
  , .traditionHasMinisterialAuthority, .traditionIDiffersInPrincipleFromTradition0
  , .individualRetainsUltimateInterpretiveAuthority, .choosingAnAuthorityIsItselfPrivateJudgment
  , .bindingnessAppliesToFirstOrderDoctrineOnly, .practiceNeitherCommandedNorForbiddenIsPermitted
  , .creedsAreInformativeNotNormative, .historicalGrammaticalMethodSuffices
  , .creedalConsensusIsHermeneuticallyNecessary, .doctrineDevelopsWithoutNewRevelation
  , .developmentIsAuthenticatedByTheChurch, .creedalConsensusRestsOnPerspicuity
  , .perspicuityRequiresCreedalConsensus, .traditionIReasoningIsCircular
  , .circularityDefeatsTraditionI, .everyUltimateAuthorityIsCircular
  , .creedalConsensusIsDerivedFromScripture, .scriptureBoundsTheInterpretiveOffice
  , .perspicuityIsLimitedToSalvationEssentials, .godsWordJudgesTradition
  , .mensCommandmentBindsAsGodsWord, .noApostolicWordOutsideScripture ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- What each atom of the argument says: not yet analysed. -/
instance meanings : HasMeanings Claim :=
  HasMeanings.ofLabels "Sola scriptura" all cite all_complete

/-- **None of the 40 atoms is analysed yet.** -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (0, 40) := by decide

/-- **No joins yet**: with no meaning analysed, no claim's meaning excludes or
entails another's, so the argument's checks hold no postulates. Analysing a
meaning that does fails this until the pair is listed. -/
instance joins : HasJoins Claim where
  exclusions := []
  exclusions_pinned := by decide +kernel
  entailments := []
  entailments_pinned := by decide +kernel

end Testimony.Meanings.SolaScriptura
