import Testimony.Semantics.Meaning
import TestimonyArguments.BornOfAVirgin.Sources

/-!
# TestimonyArguments.Meanings.BornOfAVirgin — what each born of a virgin claim says

**Partly analysed.** Twenty-three claims have meanings: the ones whose meanings
join them to another claim (`joins`), and the ones about the words of Isaiah
7:14, of its versions and of the Greek Pentateuch, about the woman it
describes, and about the birth it is read to promise. The rest are registered
with their citations' labels and marked unanalysed, so the argument is counted
from the start (`coverage_now`);
`TestimonyArguments.Meanings.SolaFide` is the fuller worked example.

## The words, and the woman

The lexical dispute is about two words and one woman, and the meanings keep the
three apart.

- **What a version wrote** is a `renders`: the Septuagint's παρθένος, the
  Targum's עוּלֵימְתָא, the Three's νεᾶνις, the Peshitta's ܒܬܘܠܬܐ. Each version
  is named as the voice of its textual tradition (`Voice.version`).
- **What a word means** is a `means`. עַלְמָה at Isaiah 7:14 is read two ways —
  as "virgin" by the Isaianic strand, as "young woman of marriageable age" by
  the ground both sides share — and so is παρθένος in the Septuagint's Greek, by
  Rico and Gentry and by Wegner (`HasMeanings.contested`).
- **Who the woman is** is a claim about a particular, of DOLCE's category
  `agent`: whether she has the quality of virginity. Wegner's "the עַלְמָה of
  Isaiah 7:14 is not a virgin" is such a claim; so is "Mary conceived as a
  virgin", about another woman. What the Septuagint's translator took her to be
  is held *by him*, inside a frame, where it contradicts no claim about her.

## What is joined, and what is not

A pair is joined only where the claims' own wording joins them, read under the
definitions of `Testimony.Ontology`: one of them, that a sense found in a passage
of a text is a sense of its usage (`Testimony.Ontology.Usage`), joins the laws,
and Genesis 34:3 as the status reading reads it.

- **Wegner's claim that παρθένος meant "young woman" and did not yet mean
  "virgin" excludes Rico and Gentry's claim that it meant "virgin".** Both are
  about the word in the Septuagint's Greek, and Wegner's says *and not that
  sense*: by New Testament times, he writes, the word "developed the more
  technical meaning of 'virgin'" (482). That is the join the Septuagint dispute
  turns on
  (`TestimonyArguments.BornOfAVirgin.Dispute.Septuagint`).
- **The laws' sense "virgin" excludes Wegner's claim, and entails Rico and
  Gentry's.** The laws' claim is about two passages of the Septuagint's text,
  Leviticus 21:13–14 and Deuteronomy 22:13–21; a sense a word has in a passage
  of a text is a sense it has in that text's usage (`Testimony.Ontology.Usage`).
  So "virgin" is a sense of the word in the Septuagint's Greek, which Wegner's
  "not yet" denies and Rico and Gentry's claim asserts.
- **The status reading of Genesis 34:3 does the same.** It holds that the Greek
  calls Dinah a παρθένος in the sense "virgin", at one passage of the
  Septuagint's text, and the same definition carries that sense to the
  Septuagint's usage.
- **So does Scripture's own reading of the word.** Matthew quotes the Greek of
  Isaiah 7:14 of Mary; the claim that the word there has the sense "virgin" is a
  claim about a passage of the Septuagint's text, and the definition carries it
  to the Septuagint's usage too.
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

Five pairs are left apart, on purpose.

- "עַלְמָה denotes a virgin" and "עַלְמָה denotes a young woman of marriageable
  age". Two senses of one word are not held to exclude each other: Rico and
  Gentry hold both, a young virgin. Only a claim that says *and not* the other
  sense excludes it, and neither does.
- That the split among the ancient versions refutes the virgin sense, and that
  עַלְמָה means virgin. The first is an inference from the versions, and the
  library weighs it as a rated step
  (`TestimonyArguments.BornOfAVirgin.versionalObjection`), not as a meaning.
- Wegner's "the עַלְמָה of Isaiah 7:14 is not a virgin", and the Septuagint's
  reading of her as one. The translator's reading is his; he may have been wrong,
  and Wegner holds that he did not mean "virgin" at all.
- Wegner's "the עַלְמָה of Isaiah 7:14 is not a virgin", and the predictive
  reading. A reader who takes the sign as fulfilled twice, in Ahaz's day and in
  Christ, holds both.
- Brown's etiology of Genesis 3:15, and the protoevangelium. A fuller sense can
  sit on a literal etiology, and the critical package denies the
  protoevangelium as a claim of its own rather than through the etiology.
-/

namespace TestimonyArguments.Meanings.BornOfAVirgin

open Testimony

open Testimony.Semantics Testimony.Semantics.Notation
open TestimonyArguments.BornOfAVirgin (Claim cite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .isaiahPredictsVirginBirth, .almahMeansVirgin, .almahAdmitsVirginSense
  , .almahDenotesMarriageableYoungWoman, .virginityCompatibleWithAlmah, .maryWasAnAlmah
  , .maryFitsIsaianicDescription, .lexicalSenseRequiredForFulfilment, .lxxRendersParthenos
  , .targumRendersUlemta, .theThreeRenderNeanis, .peshittaRendersBtulta, .qumranConfirmsAlmah
  , .versionalDivergenceRefutesVirginSense, .lxxIsPreChristian, .parthenosMeansVirgin
  , .parthenosMeantYoungWoman, .earlyGreekParthenosIsYoungWoman, .dinahIsAParthenosAfterShechem
  , .isaiahUsesParthenosForBetulah, .priestMarriesAParthenos, .partheniaProveTheBride
  , .lawsUseParthenosAsVirgin, .seductionLawPricesAParthenos, .shechemActsUnderTheLaw
  , .dinahIsTheLawsParthenos, .matthewQuotesTheGreekVirgin, .matthewSaysMaryKnewNoMan
  , .lxxIsaiahUsesParthenosAsVirgin, .tryphoRejectsParthenos, .lxxReadsAVirgin
  , .lxxPutsTheConceptionInTheFuture, .lxxEnvisagesAVirginalConception
  , .harahIsPredicateAdjective
  , .isaianicAlmahIsAlreadyPregnant, .pregnancyAtTheSignIsOrdinary, .isaianicAlmahIsNotAVirgin
  , .oneReferentSettlesDenotation, .otherClearAlmahCasesAreVirgins, .signMustBeExtraordinary
  , .ordinaryConceptionIsNoMarvel, .isaianicSignsAreOrdinaryEvents, .signDatedByAChildsInfancy
  , .matthewQuotesIsaiah, .matthewIntendsFulfilment, .isaiah2to12FramedByEschatology
  , .compositionGovernsMeaning, .isaiah9And11AreMessianic, .isaiah9And11ShareTheAssyrianTimeline
  , .compositionalReadingYieldsFutureBirth, .genesis3_15SeedOfTheWoman
  , .genesis3_15IsProtoevangelium, .seedReckonedThroughFather, .seedOfTheWomanImpliesNoHumanFather
  , .wordingSignifiesAFatherlessBirth, .wordingFitsAFatherlessBirth, .seedIsHerPosterityFirst
  , .womanNamedForTheDeception, .womansSeedSaidOfOrdinaryBirths, .lxxCallsTheSeedHe
  , .lxxReadsOneDescendant, .serpentNamedTheDevil, .devilDestroyedThroughDeath
  , .christDiedAndRose, .sonMadeOfAWoman, .jesusFulfilsThePromise, .seedWasOfTheWomanAlone
  , .verseIsACurseOnTheSerpent, .seedIsLineNotIndividual, .seedUsedOfOneDescendant
  , .strikerIsSingular, .serpentTwistsTheCommand, .godSetsTheEnmity
  , .serpentIsTheInstrumentOfAPower, .joelGreekCallsTheWidowParthenos
  , .parthenosDoesNotItselfConnoteVirginity
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

/-- Genesis 3:15. -/
@[nolint defsWithUnderscore] abbrev gen3_15 : Testimony.PassageRange := vs .genesis 3 15

/-- The Septuagint, as its translators' text reads. -/
abbrev lxx : Voice := .version .septuagint

/-- The Septuagint's Greek: its translators' usage, as a whole. -/
abbrev septuagintGreek : Scope := .usage (.version .septuagint)

/-- The woman of Isaiah 7:14, whoever she is: a person, DOLCE's agent. -/
abbrev womanOfTheSign : Term := pt "the woman of Isaiah 7:14" .agent

/-- Mary, when she conceived Jesus: a person, DOLCE's agent. -/
abbrev maryAtTheConception : Term := pt "Mary, when she conceived Jesus" .agent

/-- The Messiah's birth is a birth with no human father. -/
abbrev fatherlessBirth : Content := rl .isA (cn .messiahsBirth) (cn .birthWithoutHumanFather)

/-- Micah 5:3, read rightly, teaches a birth with no human father. -/
abbrev micahTeachesFatherlessBirth : Statement := .teaches mic5_3 fatherlessBirth

/-- Magisterial teaching settles controversies of religion. -/
abbrev magisteriumSettles : Statement :=
  .holds (rl .settles (cn .magisterium) (cn .controversiesOfReligion))

/-- The range of עַלְמָה at Isaiah 7:14 does not exclude the sense "virgin". -/
abbrev almahAdmitsVirgin : Statement :=
  .holds (rl .consistentWith (wd .almah isa7_14) (cn .virginity))

/-- **What each born of a virgin atom asserts.** Twenty-three are analysed; the rest
keep their citations' labels, marked unanalysed. -/
def means : Claim → Statement
  | .isaiahPredictsVirginBirth => .teaches isa7_14 fatherlessBirth
  | .almahMeansVirgin => .also (.means .almah (.passage isa7_14) .virgin) almahAdmitsVirgin
  | .almahAdmitsVirginSense => almahAdmitsVirgin
  | .almahDenotesMarriageableYoungWoman => .means .almah (.passage isa7_14) .youngWoman
  | .lxxRendersParthenos => .renders (.version .septuagint) isa7_14 .parthenos
  | .targumRendersUlemta => .renders (.version .targum) isa7_14 .ulemta
  | .theThreeRenderNeanis => .renders .theThree isa7_14 .neanis
  | .peshittaRendersBtulta => .renders (.version .peshitta) isa7_14 .btulta
  | .parthenosMeansVirgin => .means .parthenos septuagintGreek .virgin
  | .parthenosMeantYoungWoman =>
    .also (.means .parthenos septuagintGreek .youngWoman)
      (.denied (.means .parthenos septuagintGreek .virgin))
  | .lxxIsaiahUsesParthenosAsVirgin => .means .parthenos (.passageOf lxx isa7_14) .virgin
  | .lawsUseParthenosAsVirgin =>
    .also (.means .parthenos (.passageOf lxx (rg .leviticus 21 13 21 14)) .virgin)
      (.means .parthenos (.passageOf lxx (rg .deuteronomy 22 13 22 21)) .virgin)
  | .dinahIsTheLawsParthenos => .means .parthenos (.passageOf lxx (vs .genesis 34 3)) .virgin
  | .lxxReadsAVirgin =>
    .heldBy (.version .septuagint) (rl .isA womanOfTheSign (cn .virginity))
  | .lxxEnvisagesAVirginalConception =>
    .heldBy (.version .septuagint)
      (rl .isA (pt "the birth of the son of Isaiah 7:14" .event) (cn .birthWithoutHumanFather))
  | .isaianicAlmahIsNotAVirgin => .holds (.not (rl .isA womanOfTheSign (cn .virginity)))
  | .seedOfTheWomanImpliesNoHumanFather => .teaches gen3_15 fatherlessBirth
  | .maternalSilenceImpliesNoHumanFather => micahTeachesFatherlessBirth
  | .maternalSilenceProvesNothing => .denied micahTeachesFatherlessBirth
  | .maryConceivedAsVirgin => .holds (rl .isA maryAtTheConception (cn .virginity))
  | .magisteriumIsDoctrinallyAuthoritative => magisteriumSettles
  | .scriptureIsSupremeJudge =>
    .also (.holds (rl .settles (cn .scripture) (cn .controversiesOfReligion)))
      (.denied magisteriumSettles)
  | .messiahBornOfVirgin => .holds fatherlessBirth
  | a => .opaque (cite a).label

/-- What each atom of the argument says. -/
instance meanings : HasMeanings Claim :=
  { argument := "Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3", all
  , complete := all_complete, means }

/-- **Twenty-three of the 94 atoms are analysed**: the ones whose meanings join
them to another claim, and the ones about the words, the woman and the
birth. -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (23, 94) := by decide

/-- **The words read two ways**: עַלְמָה at Isaiah 7:14, as "virgin" and as "young
woman of marriageable age", and παρθένος in the Septuagint's Greek, the same two
ways. Each pair is listed in both orders. Two senses of a word are not a join
in themselves (see the module docstring); the claims about παρθένος are joined
only because Wegner's adds "and not 'virgin'". -/
theorem contested_now :
    HasMeanings.contested (α := Claim) =
      [ (.almah, .passage isa7_14, .virgin, .youngWoman)
      , (.almah, .passage isa7_14, .youngWoman, .virgin)
      , (.parthenos, septuagintGreek, .virgin, .youngWoman)
      , (.parthenos, septuagintGreek, .youngWoman, .virgin) ] := by
  decide

/-- **The born of a virgin joins**: each pair of claims whose meanings exclude or
entail one another, listed, and proved to be exactly what the meanings contain.

- That παρθένος means "virgin" in the Septuagint's Greek is excluded by Wegner's
  claim that it meant "young woman" and did not yet mean "virgin".
- That the Greek Pentateuch's laws use the word in the sense "virgin" is excluded
  by the same claim of Wegner's, and entails that the word means "virgin" in the
  Septuagint's Greek. So does the status reading of Genesis 34:3, that the Greek
  names Dinah a παρθένος in that sense.
- That Micah's silence indicates a fatherless birth is excluded by Brown's "it
  proves nothing".
- That magisterial teaching settles the question is excluded by Westminster's
  supreme judge.
- That עַלְמָה denotes a virgin entails that its range does not exclude it.

Disputes hold them too, so every named reading a dispute is checked against
respects them: a scriptural reader's world holds that Micah's silence indicates
a fatherless birth, a critic's or Wegner's that it proves nothing; and, none of
these worlds being Rome's, each denies that magisterial teaching settles the
question. Each also settles παρθένος, since it cannot hold both claims about
the word: the scriptural readers' worlds take Rico and Gentry's, Wegner's and
the critic's take Wegner's, and deny the laws' sense, and the status reading's,
with it. The scriptural reading itself rests on neither. -/
instance joins : HasJoins Claim where
  exclusions :=
    [ (.parthenosMeansVirgin, .parthenosMeantYoungWoman)
    , (.parthenosMeantYoungWoman, .lawsUseParthenosAsVirgin)
    , (.parthenosMeantYoungWoman, .dinahIsTheLawsParthenos)
    , (.parthenosMeantYoungWoman, .lxxIsaiahUsesParthenosAsVirgin)
    , (.maternalSilenceImpliesNoHumanFather, .maternalSilenceProvesNothing)
    , (.magisteriumIsDoctrinallyAuthoritative, .scriptureIsSupremeJudge) ]
  exclusions_pinned := by decide +kernel
  entailments :=
    [ (.almahMeansVirgin, .almahAdmitsVirginSense)
    , (.lawsUseParthenosAsVirgin, .parthenosMeansVirgin)
    , (.dinahIsTheLawsParthenos, .parthenosMeansVirgin)
    , (.lxxIsaiahUsesParthenosAsVirgin, .parthenosMeansVirgin) ]
  entailments_pinned := by decide +kernel

open Testimony.Logic in
/-- **The postulates, written out**: `a → ¬b` for each exclusion, `a → b` for
each entailment. Proofs over the argument's packages unfold to this list, so a
named reading must satisfy it. -/
@[bornOfAVirginDefs] theorem postulates_eq :
    (HasPostulates.postulates : List (Formula Claim)) =
      [ p .parthenosMeansVirgin ➝ notP .parthenosMeantYoungWoman
      , p .parthenosMeantYoungWoman ➝ notP .lawsUseParthenosAsVirgin
      , p .parthenosMeantYoungWoman ➝ notP .dinahIsTheLawsParthenos
      , p .parthenosMeantYoungWoman ➝ notP .lxxIsaiahUsesParthenosAsVirgin
      , p .maternalSilenceImpliesNoHumanFather ➝ notP .maternalSilenceProvesNothing
      , p .magisteriumIsDoctrinallyAuthoritative ➝ notP .scriptureIsSupremeJudge
      , p .almahMeansVirgin ➝ p .almahAdmitsVirginSense
      , p .lawsUseParthenosAsVirgin ➝ p .parthenosMeansVirgin
      , p .dinahIsTheLawsParthenos ➝ p .parthenosMeansVirgin
      , p .lxxIsaiahUsesParthenosAsVirgin ➝ p .parthenosMeansVirgin ] :=
  rfl

attribute [bornOfAVirginDefs] Testimony.Logic.ArgumentPackage.held

end TestimonyArguments.Meanings.BornOfAVirgin
