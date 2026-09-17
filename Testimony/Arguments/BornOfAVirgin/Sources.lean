import Testimony.Arguments.BornOfAVirgin.Atoms

/-!
# Arguments.BornOfAVirgin.Sources — a citation for every atom

`cite` is total, so an atom without a citation does not compile. This is the
file that makes that obligation concrete, and it is the largest in the
argument: forty atoms, each with a prose statement of what it asserts, a
classification, and who says so at what pinpoint with what confidence.

Four `Source` values recur across it and are defined in `Atoms`. Where an atom
cites one of them with something further, it says `{ ... with supporting := }`,
so what a reader sees is the part that differs.

Inline comments carry the qualifications that do not fit a `confidence` field —
why a premise is marked `disputed` when the tradition holding it is confident,
which scholar is *not* being cited for a claim and why.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .isaiahPredictsVirginBirth =>
    { label := "Isaiah 7:14 is a Messianic prediction of a virgin birth"
    , kind := .interpretive
    , source := motyerOnIsaiah }
  | .almahMeansVirgin =>
    { label := "עַלְמָה in Isaiah 7:14 denotes a virgin, not merely a young woman"
    , kind := .linguistic
      -- The Isaianic crux. The Hebrew term does not by itself carry the sense;
      -- the Septuagint's παρθένος does.
    , source :=
        { motyerOnIsaiah with
          supporting :=
            [ .work bhs (.apparatus isaiah7_14)
            , .work berryVirginBirth (.pages 1653 1654) ] } }
  | .almahAdmitsVirginSense =>
    { label := "The semantic range of עַלְמָה does not exclude 'virgin' at Isaiah 7:14"
    , kind := .linguistic
      -- Berry's defensive claim, and all the lexical evidence actually
      -- supports. עַלְמָה is used of a virgin at Gen 24:43 and, some argue, of a
      -- maiden who need not be one at Prov 30:19; versatility is not ambiguity
      -- resolved in the argument's favour. `admissibility_is_not_enough`
      -- measures the gap between this and `almahMeansVirgin`.
    , source :=
        { primary := .work berryVirginBirth (.pages 1653 1654)
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .almahDenotesMarriageableYoungWoman =>
    { label := "עַלְמָה denotes a young woman of marriageable age"
    , kind := .linguistic
      -- Shared ground. Rico and Gentry and Wegner disagree about almost
      -- everything else here and not about this, which is why it is the only
      -- lexical atom in the module marked `consensus`.
    , source :=
        { primary := .work ricoGentryInfantKing .whole
        , supporting := [.work wegnerVirginBirths .whole]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .virginityCompatibleWithAlmah =>
    { label := "Being a virgin does not exclude a woman from the denotation of עַלְמָה"
    , kind := .linguistic
      -- The Rebekah datum settles this and neither side disputes it: Genesis
      -- calls the same woman עַלְמָה (24:43) and בְּתוּלָה whom no man had known
      -- (24:16). Compatibility is not the contested question; denotation is.
    , source :=
        { primary := .scripture rebekahAlmahAndBetulah
        , supporting := [.work ricoGentryInfantKing .whole]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .maryWasAnAlmah =>
    { label := "Mary at the conception was a betrothed young woman of marriageable age"
    , kind := .historical
    , source :=
        { primary := .scripture betrothalNotices
        , supporting := [.work franceMatthew (.adLoc matthew1_23)]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .maryFitsIsaianicDescription =>
    { label := "Mary answers the description at Isaiah 7:14 whatever עַלְמָה denotes"
    , kind := .interpretive
    , source :=
        { franceOnMatthew with supporting := [.work ricoGentryInfantKing .whole] } }
  | .lexicalSenseRequiredForFulfilment =>
    { label := "Matthew's fulfilment claim requires that עַלְמָה itself denote virginity"
    , kind := .interpretive
      -- Attributed carefully. This is what the popular form of the lexical
      -- objection needs, and Brown's case against an OT basis for the virginal
      -- conception presupposes it. It is *not* Wegner's view: the prophetic
      -- pattern approach gives this premise up, which is why Wegner is not
      -- cited here even though he is the module's main lexical rival.
    , source := brownOnBirth .disputed }
  | .lxxRendersParthenos =>
    { label := "The Septuagint renders עַלְמָה at Isaiah 7:14 as παρθένος"
    , kind := .textual
    , source :=
        { primary := .work na28 (.apparatus matthew1_23)
        , supporting := [.work franceMatthew (.adLoc matthew1_23)]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .targumRendersUlemta =>
    { label := "Targum Jonathan renders עַלְמָה at Isaiah 7:14 as עוּלֵימְתָא, 'young woman'"
    , kind := .textual
    , source :=
        { primary := .work chiltonIsaiahTargum (.adLoc isaiah7_14)
        , supporting := [.scripture [verseIn .targum isaiah7_14]]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .theThreeRenderNeanis =>
    { label := "Aquila, Symmachus and Theodotion render Isaiah 7:14 with νεᾶνις"
    , kind := .textual
      -- Often explained as anti-Christian revision, and Justin already
      -- complains of it (Dial. 43, 67, 71, 84). The explanation is not clean:
      -- Theodotion's version is arguably pre-Christian.
    , source :=
        { primary := .work ricoGentryInfantKing .whole
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .peshittaRendersBtulta =>
    { label := "The Syriac Peshitta renders Isaiah 7:14 with ܒܬܘܠܬܐ, 'virgin'"
    , kind := .textual
      -- Scripture alone, and legitimately so: the claim is about what a
      -- version reads, and the version is the evidence for that. Surfaced by
      -- `scriptureOnlyAtoms` all the same.
    , source :=
        { primary := .scripture [verseIn .peshitta isaiah7_14]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .qumranConfirmsAlmah =>
    { label := "1QIsaᵃ reads עַלְמָה, so no textual variant bears on the sense"
    , kind := .textual
    , source :=
        { primary := .work bhs (.apparatus isaiah7_14)
        , supporting := [.scripture [verseIn .deadSeaScrolls isaiah7_14]]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .versionalDivergenceRefutesVirginSense =>
    { label := "The split among the ancient versions shows עַלְמָה does not denote virginity"
    , kind := .interpretive
    , source :=
        { brownOnBirth with supporting := [.work chiltonIsaiahTargum .whole] } }
  | .matthewQuotesIsaiah =>
    { label := "Matthew 1:23 quotes Isaiah 7:14"
    , kind := .textual
    , source := na28Apparatus matthew1_23 }
  | .matthewIntendsFulfilment =>
    { label := "Matthew's quotation intends the virgin conception as fulfilment"
    , kind := .interpretive
    , source := franceOnMatthew }
  | .isaiah2to12FramedByEschatology =>
    { label := "Isaiah 7 sits inside Isaiah 2–12, a unit framed by eschatology"
    , kind := .textual
    , source :=
        { postellOnIsaiah (.pages 483 490) .wellSupported with
          supporting := [.scripture isaiah2to12Frame] } }
  | .compositionGovernsMeaning =>
    { label := "An oracle's meaning in the finished book is set by its literary placement"
    , kind := .interpretive
      -- The compositional crux, argued from the making of canonical Jeremiah
      -- (Jer 36): the second scroll's oracles mean what their placement in the
      -- book makes them mean. A reader who holds that the historical setting of
      -- an oracle fixes its sense rejects this outright.
    , source := postellOnIsaiah (.pages 483 486) .disputed }
  | .isaiah9And11AreMessianic =>
    { label := "Isaiah 9:5–6 and 11:1–10 are read as messianic without reservation"
    , kind := .interpretive
      -- Cited to the Targum as well as to Postell, and the Targum is the
      -- stronger witness here precisely because it is hostile elsewhere: it
      -- reads 9:5-6 and 11:1 messianically while declining to read 7:14 so.
    , source :=
        { postellOnIsaiah (.pages 487 489) .wellSupported with
          supporting := [.work chiltonIsaiahTargum .whole] } }
  | .isaiah9And11ShareTheAssyrianTimeline =>
    { label := "Isaiah 9 and 11 sit on the same near-term Assyrian timeline as 7:14"
    , kind := .textual
    , source :=
        { postellOnIsaiah (.pages 487 489) .wellSupported with
          supporting := [.scripture assyrianTimeline] } }
  | .compositionalReadingYieldsFutureBirth =>
    { label := "Read compositionally, Isaiah 7:14 anticipates a future, miraculous birth"
    , kind := .interpretive
    , source := postellOnIsaiah (.pages 490 493) .disputed }
  | .genesis3_15SeedOfTheWoman =>
    { label := "Genesis 3:15 promises victory over the serpent through 'her seed'"
    , kind := .textual
      -- What the text says, as against what it is taken to imply. The wording
      -- is not in dispute; everything built on it is.
    , source :=
        { primary := .scripture [verseIn .masoretic genesis3_15]
        , supporting := [.work bhs (.apparatus genesis3_15)]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .genesis3_15IsProtoevangelium =>
    { label := "Genesis 3:15 is the protoevangelium, the first promise of a redeemer"
    , kind := .interpretive
    , source := miravalleOnMary }
  | .seedReckonedThroughFather =>
    { label := "Hebrew זֶרַע is ordinarily reckoned through the father"
    , kind := .linguistic
      -- Marked disputed rather than wellSupported on purpose: Genesis speaks of
      -- a woman's seed in wholly ordinary contexts (16:10 to Hagar, 24:60 to
      -- Rebekah), so the idiom is weaker than the argument needs.
    , source :=
        { miravalleOnMary with supporting := [.work bhs (.apparatus genesis3_15)] } }
  | .seedOfTheWomanImpliesNoHumanFather =>
    { label := "The matrilineal wording of Genesis 3:15 marks a birth with no human father"
    , kind := .interpretive
    , source := miravalleOnMary }
  | .micah5_3NamesMotherOnly =>
    { label := "Micah 5:3 names only the woman in labour as bearing the coming ruler"
    , kind := .textual
    , source :=
        { primary := .scripture [rangeIn .masoretic micah5_2to3]
        , supporting := [.work keilDelitzschMinorProphets (.adLoc micah5_3)]
        , tradition := .christianTypological
        , confidence := .wellSupported } }
  | .maternalSilenceImpliesNoHumanFather =>
    { label := "Micah's mention of a mother and no father indicates a birth with no human father"
    , kind := .interpretive
      -- An argument from silence, and the rival says so. See
      -- `maternalSilenceProvesNothing`.
    , source := miravalleOnMary }
  | .maryConceivedAsVirgin =>
    { label := "Mary conceived Jesus while a virgin"
    , kind := .historical
      -- Scripture alone. A miraculous conception is outside ordinary
      -- historical method; critical scholarship disputes or denies it.
    , source :=
        { primary := .scripture virginConceptionNarratives
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .independentAttestation =>
    { label :=
        "Matthew and Luke are independent traditions agreeing on the virgin conception"
    , kind := .historical
      -- The independence of the two sources is itself debated.
    , source :=
        { primary := .work brownBirthMessiah (.pages 26 38)
        , tradition := .christianHistoricalGrammatical
        , confidence := .plausible } }
  | .isaiahIsNearTermSignToAhaz =>
    { label := "Isaiah 7:14 is a near-term sign to Ahaz, fulfilled in Isaiah's generation"
    , kind := .interpretive
    , source := brownOnBirth }
  | .nearTermExcludesMessianicSense =>
    { label := "A sign given for Ahaz's generation is not also a prediction of a virgin birth"
    , kind := .interpretive
    , source := brownOnBirth }
  | .nearTermFulfilmentIsUnclear =>
    { label := "How Isaiah 7:14 was fulfilled in Ahaz's own day is itself an open question"
    , kind := .interpretive
      -- Descriptively uncontroversial: the near-term referent has been taken
      -- for Isaiah's son, for Hezekiah, and for a son of Ahaz, with no
      -- settled answer. What is contestable is the use Berry puts it to.
    , source :=
        { primary := .work berryVirginBirth (.pages 1653 1654)
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .genesis3_15IsEtiology =>
    { label := "Genesis 3:15 is an etiology of snake-human enmity, 'her seed' her descendants"
    , kind := .interpretive
    , source := brownOnBirth }
  | .maternalSilenceProvesNothing =>
    { label := "Micah's silence about a father is an argument from silence and proves nothing"
    , kind := .interpretive
    , source := brownOnBirth }
  | .magisteriumTeachesVirginalConception =>
    { label := "Papal teaching affirms that Mary conceived while remaining a virgin"
    , kind := .theological
    , source :=
        { primary := .work miravalleIntroductionToMary (.page 23)
        , tradition := .romanCatholic
        , confidence := .consensus } }
  | .magisteriumIsDoctrinallyAuthoritative =>
    { label := "Magisterial teaching settles the question"
    , kind := .theological
      -- Held within Roman Catholicism, denied by the Reformed tradition. This
      -- library's author does not grant it, which is why it appears only in
      -- `catholic` and `magisterialOnly`, never in `christian`.
    , source :=
        { primary := .work miravalleIntroductionToMary (.page 23)
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .scriptureIsSupremeJudge =>
    { label := "Scripture is the supreme judge of controversies of religion"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "I.x")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .messiahBornOfVirgin =>
    { label := "The Messiah must be born of a virgin"
    , kind := .interpretive
    , source :=
        { motyerOnIsaiah with
          supporting :=
            [ .work franceMatthew (.adLoc matthew1_23)
            , .work miravalleMeetMary (.pages 9 10) ] } }
  | .jesusSatisfiesCriterion =>
    { label := "Jesus of Nazareth satisfies the virgin-birth criterion"
    , kind := .interpretive
    , source := franceOnMatthew .disputed }

end Testimony.Arguments.BornOfAVirgin
