import Testimony.Semantics.Meaning
import TestimonyArguments.BornOfAVirgin.Sources

/-!
# TestimonyArguments.Meanings.BornOfAVirgin — what each born of a virgin claim says

**Partly analysed.** Twenty claims have meanings: the ones whose meanings join
them to another claim (`joins`), and the ones about the words of Isaiah 7:14 and
of its versions, about the woman it describes, and about the birth it is read to
promise. The rest are registered with their citations' labels and marked
unanalysed, so the argument is counted from the start (`coverage_now`);
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

A pair is joined only where the claims' own wording joins them.

- **Wegner's claim that παρθένος meant "young woman" and did not yet mean
  "virgin" excludes Rico and Gentry's claim that it meant "virgin".** Both are
  about the word in the Septuagint's Greek, and Wegner's says *and not that
  sense*: by New Testament times, he writes, the word "developed the more
  technical meaning of 'virgin'" (482). That is the join the Septuagint dispute
  turns on
  (`TestimonyArguments.BornOfAVirgin.Dispute.Septuagint`).
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
  , .isaiahUsesParthenosForBetulah, .tryphoRejectsParthenos, .lxxReadsAVirgin
  , .lxxPutsTheConceptionInTheFuture, .lxxEnvisagesAVirginalConception
  , .harahIsPredicateAdjective
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

/-- Genesis 3:15. -/
@[nolint defsWithUnderscore] abbrev gen3_15 : Testimony.PassageRange := vs .genesis 3 15

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

/-- **What each born of a virgin atom asserts.** Twenty are analysed; the rest
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

/-- **Twenty of the 63 atoms are analysed**: the ones whose meanings join them to
another claim, and the ones about the words, the woman and the birth. -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (20, 63) := by decide

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
the critic's take Wegner's. The scriptural reading itself rests on neither. -/
instance joins : HasJoins Claim where
  exclusions :=
    [ (.parthenosMeansVirgin, .parthenosMeantYoungWoman)
    , (.maternalSilenceImpliesNoHumanFather, .maternalSilenceProvesNothing)
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
      [ p .parthenosMeansVirgin ➝ notP .parthenosMeantYoungWoman
      , p .maternalSilenceImpliesNoHumanFather ➝ notP .maternalSilenceProvesNothing
      , p .magisteriumIsDoctrinallyAuthoritative ➝ notP .scriptureIsSupremeJudge
      , p .almahMeansVirgin ➝ p .almahAdmitsVirginSense ] :=
  rfl

attribute [bornOfAVirginDefs] Testimony.Logic.ArgumentPackage.held

end TestimonyArguments.Meanings.BornOfAVirgin
