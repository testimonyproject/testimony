import Testimony.Semantics.Meaning
import Testimony.Arguments.BornOfAVirgin.Sources

/-!
# Testimony.Meanings.BornOfAVirgin — what each born of a virgin claim says

**Not yet analysed.** Every atom is registered, with its citation's label and
marked unanalysed, so the argument is counted from the start
(`coverage`). Analysing one is replacing its case of `means` with a
`Statement`; `Testimony.Meanings.SolaFide` is the worked example.
-/

namespace Testimony.Meanings.BornOfAVirgin

open Testimony.Semantics
open Testimony.Arguments.BornOfAVirgin (Claim cite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .isaiahPredictsVirginBirth, .almahMeansVirgin, .almahAdmitsVirginSense
  , .almahDenotesMarriageableYoungWoman, .virginityCompatibleWithAlmah, .maryWasAnAlmah
  , .maryFitsIsaianicDescription, .lexicalSenseRequiredForFulfilment, .lxxRendersParthenos
  , .targumRendersUlemta, .theThreeRenderNeanis, .peshittaRendersBtulta, .qumranConfirmsAlmah
  , .versionalDivergenceRefutesVirginSense, .harahIsPredicateAdjective
  , .isaianicAlmahIsAlreadyPregnant, .pregnancyAtTheSignIsOrdinary, .isaianicAlmahIsNotAVirgin
  , .oneReferentSettlesDenotation, .otherClearAlmahCasesAreVirgins, .signMustBeExtraordinary
  , .ordinaryConceptionIsNoMarvel, .isaianicSignsAreOrdinaryEvents, .signDatedByAChildsInfancy
  , .matthewQuotesIsaiah, .matthewIntendsFulfilment, .isaiah2to12FramedByEschatology
  , .compositionGovernsMeaning, .isaiah9And11AreMessianic, .isaiah9And11ShareTheAssyrianTimeline
  , .compositionalReadingYieldsFutureBirth, .genesis3_15SeedOfTheWoman
  , .genesis3_15IsProtoevangelium, .seedReckonedThroughFather, .seedOfTheWomanImpliesNoHumanFather
  , .micah5_3NamesMotherOnly, .maternalSilenceImpliesNoHumanFather, .maryConceivedAsVirgin
  , .independentAttestation, .isaiahIsNearTermSignToAhaz, .nearTermExcludesMessianicSense
  , .nearTermFulfilmentIsUnclear, .signGivenToHouseOfDavid, .maherShalalHashBazRepeatsTheTimetable
  , .micahRulerFacesAssyria, .micahRulerReadMessianically, .genesis3_15IsEtiology
  , .maternalSilenceProvesNothing, .magisteriumTeachesVirginalConception
  , .magisteriumIsDoctrinallyAuthoritative, .scriptureIsSupremeJudge, .messiahBornOfVirgin
  , .jesusSatisfiesCriterion ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- What each atom of the argument says: not yet analysed. -/
instance meanings : HasMeanings Claim :=
  HasMeanings.ofLabels "Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3" all cite
    all_complete

/-- **None of the 53 atoms is analysed yet.** -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (0, 53) := by decide

/-- **No joins yet**: with no meaning analysed, no claim's meaning excludes or
entails another's, so the argument's checks hold no postulates. Analysing a
meaning that does fails this until the pair is listed. -/
instance joins : HasJoins Claim where
  exclusions := []
  exclusions_pinned := by decide +kernel
  entailments := []
  entailments_pinned := by decide +kernel

end Testimony.Meanings.BornOfAVirgin
