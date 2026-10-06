import Testimony.Semantics.Meaning
import Testimony.Arguments.BornOfAVirgin.Sources

/-!
# Testimony.Meanings.BornOfAVirgin — what each born of a virgin claim says

**Partly analysed.** Six claims have meanings: the ones whose meanings join them
to another claim (`joins`). The rest are registered with their citations'
labels and marked unanalysed, so the argument is counted from the start
(`coverage_now`); `Testimony.Meanings.SolaFide` is the fuller worked example.

## What is joined, and what is not

A pair is joined only where the claims' own wording joins them.

- **Brown's "Micah's silence about a father proves nothing" excludes
  Miravalle's "it indicates a birth with no human father".** The one says
  Micah 5:3, read rightly, does not teach a fatherless birth; the other says it
  does. The citation of Miravalle's claim already names Brown's as its rival.
- **Westminster I.10 excludes "magisterial teaching settles the question".**
  The supreme judge of controversies "can be no other but the Holy Spirit
  speaking in the Scripture", and the decrees of councils are among what it
  examines; the other claim makes the magisterium the judge that settles.
- **"עַלְמָה denotes a virgin" entails that its range does not exclude
  "virgin".** A word's range includes what it denotes; the atom calls the
  second "weaker … deliberately so".

Three pairs are left apart, on purpose.

- That the split among the ancient versions refutes the virgin sense, and that
  עַלְמָה means virgin. The first is an inference from the versions, and the
  library weighs it as a rated step
  (`Testimony.Arguments.BornOfAVirgin.versionalObjection`), not as a meaning.
- Wegner's "the עַלְמָה of Isaiah 7:14 is not a virgin", and the predictive
  reading. A reader who takes the sign as fulfilled twice, in Ahaz's day and in
  Christ, holds both.
- Brown's etiology of Genesis 3:15, and the protoevangelium. A fuller sense can
  sit on a literal etiology, and the critical package denies the
  protoevangelium as a claim of its own rather than through the etiology.
-/

namespace Testimony.Meanings.BornOfAVirgin

open Testimony.Semantics Testimony.Semantics.Notation
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

/-- Isaiah 7:14. -/
@[nolint defsWithUnderscore] abbrev isa7_14 : Testimony.PassageRange := vs .isaiah 7 14

/-- Micah 5:3. -/
@[nolint defsWithUnderscore] abbrev mic5_3 : Testimony.PassageRange := vs .micah 5 3

/-- Micah 5:3, read rightly, teaches a birth with no human father. -/
abbrev micahTeachesFatherlessBirth : Statement :=
  .teaches mic5_3 (rl .isA (cn .messiahsBirth) (cn .birthWithoutHumanFather))

/-- Magisterial teaching settles controversies of religion. -/
abbrev magisteriumSettles : Statement :=
  .holds (rl .settles (cn .magisterium) (cn .controversiesOfReligion))

/-- The range of עַלְמָה at Isaiah 7:14 does not exclude the sense "virgin". -/
abbrev almahAdmitsVirgin : Statement :=
  .holds (rl .consistentWith (wd .almah isa7_14) (cn .virginity))

/-- **What each born of a virgin atom asserts.** Six are analysed; the rest keep
their citations' labels, marked unanalysed. -/
def means : Claim → Statement
  | .almahMeansVirgin => .also (.means .almah (.passage isa7_14) .virgin) almahAdmitsVirgin
  | .almahAdmitsVirginSense => almahAdmitsVirgin
  | .maternalSilenceImpliesNoHumanFather => micahTeachesFatherlessBirth
  | .maternalSilenceProvesNothing => .denied micahTeachesFatherlessBirth
  | .magisteriumIsDoctrinallyAuthoritative => magisteriumSettles
  | .scriptureIsSupremeJudge =>
    .also (.holds (rl .settles (cn .scripture) (cn .controversiesOfReligion)))
      (.denied magisteriumSettles)
  | a => .opaque (cite a).label

/-- What each atom of the argument says. -/
instance meanings : HasMeanings Claim :=
  { argument := "Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3", all
  , complete := all_complete, means }

/-- **Six of the 53 atoms are analysed**: the ones whose meanings join them to
another claim. -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (6, 53) := by decide

/-- **The born of a virgin joins**: each pair of claims whose meanings exclude or
entail one another, listed, and proved to be exactly what the meanings contain.

- That Micah's silence indicates a fatherless birth is excluded by Brown's "it
  proves nothing".
- That magisterial teaching settles the question is excluded by Westminster's
  supreme judge.
- That עַלְמָה denotes a virgin entails that its range does not exclude it.

Disputes hold them too, so every named reading a dispute is checked against
respects them: a scriptural reader's world holds that Micah's silence indicates
a fatherless birth, a critic's or Wegner's that it proves nothing; and, none of
these worlds being Rome's, each denies that magisterial teaching settles the
question. -/
instance joins : HasJoins Claim where
  exclusions :=
    [ (.maternalSilenceImpliesNoHumanFather, .maternalSilenceProvesNothing)
    , (.magisteriumIsDoctrinallyAuthoritative, .scriptureIsSupremeJudge) ]
  exclusions_pinned := by decide +kernel
  entailments := [(.almahMeansVirgin, .almahAdmitsVirginSense)]
  entailments_pinned := by decide +kernel

open Testimony.Logic in
/-- **The postulates, written out**: `a → ¬b` for each exclusion, `a → b` for
each entailment. Proofs over the argument's packages unfold to this list, so a
named reading must satisfy it. -/
@[bornOfAVirginDefs] theorem postulates_eq :
    (HasPostulates.postulates : List (Formula Claim)) =
      [ p .maternalSilenceImpliesNoHumanFather ➝ notP .maternalSilenceProvesNothing
      , p .magisteriumIsDoctrinallyAuthoritative ➝ notP .scriptureIsSupremeJudge
      , p .almahMeansVirgin ➝ p .almahAdmitsVirginSense ] :=
  rfl

attribute [bornOfAVirginDefs] Testimony.Logic.ArgumentPackage.held

end Testimony.Meanings.BornOfAVirgin
