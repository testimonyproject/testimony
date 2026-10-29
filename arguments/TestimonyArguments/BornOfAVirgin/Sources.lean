import TestimonyArguments.BornOfAVirgin.Sources.Genesis
import TestimonyArguments.BornOfAVirgin.Sources.NearTerm
import TestimonyArguments.BornOfAVirgin.Sources.Septuagint
import TestimonyArguments.BornOfAVirgin.Sources.Versions
import TestimonyArguments.BornOfAVirgin.Sources.Wegner

/-!
# TestimonyArguments.BornOfAVirgin.Sources — a citation for every atom

`cite` is total, so an atom without a citation does not compile. This is the
file that makes that obligation concrete: every atom, each with a prose
statement of what it asserts, a classification, and who says so at what
pinpoint with what confidence.

It was once the largest file in the argument, and the atoms of its four
disputes are now cited in modules of their own: `Sources.NearTerm` for the
dispute over the critical denial, `Sources.Wegner` for the dispute over Wegner's
objection, `Sources.Septuagint` for the dispute over the Septuagint's word,
`Sources.Versions` for the Hebrew text, the Syriac, and the referential reply, and
`Sources.Genesis` for the dispute over the woman's seed.
`cite` reaches each of those citations by name from one of its cases, so it is
still one total function, and a new atom still cannot be left out of it.

Several `Source` values recur across it and are defined in `Atoms`. Where an atom
cites one of them with something further, it says `{ ... with supporting := }`,
so what a reader sees is the part that differs.

Inline comments carry the qualifications that do not fit a `confidence` field —
why a premise is marked `disputed` when the tradition holding it is confident,
which scholar is *not* being cited for a claim and why.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .isaiahPredictsVirginBirth =>
    { label := "Isaiah 7:14 is a Messianic prediction of a virgin birth"
    , kind := .interpretive
      -- The church's reading from the second century: Justin (Dial. 43, 66),
      -- Irenaeus (Haer. III.21.6), Origen (Cels. I.35). Still `disputed`,
      -- because the same texts record it contested from the start — Trypho's
      -- reply (Dial. 67), Theodotion and Aquila (Haer. III.21.1). The fathers
      -- attest the reading's age, not its standing.
    , source :=
        { motyerOnIsaiah with
          supporting :=
            [ .work motyerContextContent (.page 123)
            , .work comptonImmanuelProphecy (.pages 12 14)
            , .work justinDialogue (.sectionRef "66")
            , .work irenaeusAgainstHeresies (.sectionRef "III.21.6")
            , .work origenAgainstCelsus (.sectionRef "I.35") ] } }
  | .almahMeansVirgin =>
    { label := "עַלְמָה in Isaiah 7:14 denotes a virgin, not merely a young woman"
    , kind := .linguistic
      -- The Isaianic crux. The Hebrew term does not by itself carry the sense;
      -- the Septuagint's παρθένος does, on Rico and Gentry's reading of its
      -- Greek (`parthenosMeansVirgin`, disputed), and the step from the Greek
      -- to the Hebrew is rated apart (`translatorsReadingFixesTheWord`).
      -- Jerome argues the Hebrew carries it (Jov. I.32):
      -- עַלְמָה is a "hidden" virgin, as Rebekah is at Genesis 24:43. Origen
      -- is not cited: his appeal to Deuteronomy 22 (Cels. I.34) is to a law
      -- whose Hebrew reads נַעֲרָה בְתוּלָה, not עַלְמָה.
    , source :=
        { motyerOnIsaiah with
          supporting :=
            [ .work bhs (.apparatus isaiah7_14)
            , .work berryVirginBirth (.pages 1653 1654)
            , .work motyerContextContent (.page 125)
            , .work comptonImmanuelProphecy (.pages 7 8)
            , .work jeromeAgainstJovinianus (.sectionRef "I.32") ] } }
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
        , supporting := [.work youngImmanuelProphecy (.pages 120 124)]
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
  | .maryFitsIsaianicDescription => maryFitsIsaianicDescriptionCited
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
      -- Often explained as anti-Christian revision. Justin records the Jewish
      -- reading "young woman" (Dial. 43, 71, 84; Trypho gives it at 67) but
      -- names no translator. Irenaeus names Theodotion and Aquila (III.21.1);
      -- Eusebius gives Aquila's and Symmachus's renderings (Dem. Ev. VII.1). The
      -- explanation is not clean: Theodotion's version is arguably pre-Christian.
    , source :=
        { primary := .work ricoGentryInfantKing .whole
        , supporting :=
            [ .work irenaeusAgainstHeresies (.sectionRef "III.21.1")
            , .work eusebiusDemonstratio (.sectionRef "VII.1") ]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .peshittaRendersBtulta => peshittaRendersBtultaCited
  | .qumranConfirmsAlmah => qumranConfirmsAlmahCited
  | .versionalDivergenceRefutesVirginSense =>
    { label := "The split among the ancient versions shows עַלְמָה does not denote virginity"
    , kind := .interpretive
    , source :=
        { brownOnBirth with supporting := [.work chiltonIsaiahTargum .whole] } }
  | .lxxIsPreChristian => lxxIsPreChristianCited
  | .parthenosMeansVirgin => parthenosMeansVirginCited
  | .parthenosMeantYoungWoman => parthenosMeantYoungWomanCited
  | .earlyGreekParthenosIsYoungWoman => earlyGreekParthenosIsYoungWomanCited
  | .dinahIsAParthenosAfterShechem => dinahIsAParthenosAfterShechemCited
  | .isaiahUsesParthenosForBetulah => isaiahUsesParthenosForBetulahCited
  | .priestMarriesAParthenos => priestMarriesAParthenosCited
  | .partheniaProveTheBride => partheniaProveTheBrideCited
  | .lawsUseParthenosAsVirgin => lawsUseParthenosAsVirginCited
  | .seductionLawPricesAParthenos => seductionLawPricesAParthenosCited
  | .shechemActsUnderTheLaw => shechemActsUnderTheLawCited
  | .dinahIsTheLawsParthenos => dinahIsTheLawsParthenosCited
  | .matthewQuotesTheGreekVirgin => matthewQuotesTheGreekVirginCited
  | .matthewSaysMaryKnewNoMan => matthewSaysMaryKnewNoManCited
  | .lxxIsaiahUsesParthenosAsVirgin => lxxIsaiahUsesParthenosAsVirginCited
  | .tryphoRejectsParthenos => tryphoRejectsParthenosCited
  | .lxxReadsAVirgin => lxxReadsAVirginCited
  | .lxxPutsTheConceptionInTheFuture => lxxPutsTheConceptionInTheFutureCited
  | .lxxEnvisagesAVirginalConception => lxxEnvisagesAVirginalConceptionCited
  | .wordingSignifiesAFatherlessBirth => wordingSignifiesAFatherlessBirthCited
  | .wordingFitsAFatherlessBirth => wordingFitsAFatherlessBirthCited
  | .seedIsHerPosterityFirst => seedIsHerPosterityFirstCited
  | .womanNamedForTheDeception => womanNamedForTheDeceptionCited
  | .womansSeedSaidOfOrdinaryBirths => womansSeedSaidOfOrdinaryBirthsCited
  | .lxxCallsTheSeedHe => lxxCallsTheSeedHeCited
  | .lxxReadsOneDescendant => lxxReadsOneDescendantCited
  | .harahIsPredicateAdjective => harahIsPredicateAdjectiveCited
  | .isaianicAlmahIsAlreadyPregnant => isaianicAlmahIsAlreadyPregnantCited
  | .pregnancyAtTheSignIsOrdinary => pregnancyAtTheSignIsOrdinaryCited
  | .isaianicAlmahIsNotAVirgin => isaianicAlmahIsNotAVirginCited
  | .oneReferentSettlesDenotation => oneReferentSettlesDenotationCited
  | .otherClearAlmahCasesAreVirgins => otherClearAlmahCasesAreVirginsCited
  | .signMustBeExtraordinary => signMustBeExtraordinaryCited
  | .ordinaryConceptionIsNoMarvel => ordinaryConceptionIsNoMarvelCited
  | .isaianicSignsAreOrdinaryEvents => isaianicSignsAreOrdinaryEventsCited
  | .signDatedByAChildsInfancy => signDatedByAChildsInfancyCited
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
          supporting :=
            [ .work motyerContextContent (.pages 122 123)
            , .scripture isaiah2to12Frame ] } }
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
    { label := "Genesis 3:15 says that 'her seed' will strike the serpent's head"
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
      -- Held across traditions: Leupold, "Both the ultimate victory and its
      -- achievement by the seed of the woman are taught with unequivocal
      -- plainness by this word" (167); Keil (102); Miravalle. `disputed`
      -- because critical readers deny it: Westermann, as Lewis quotes him, "it
      -- is not possible that such a form has either promise or prophecy as its
      -- primary or even its secondary meaning" (Lewis 318). The rival atom,
      -- `genesis3_15IsEtiology`, cites Brown whole; no page of Brown giving that
      -- reading has yet been found.
    , source :=
        { primary := .work leupoldGenesis (.page 167)
        , supporting :=
            [ .work keilDelitzschPentateuch (.page 102)
            , .work miravalleMeetYourMother .whole
            , .work lewisWomansSeed (.page 318) ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .seedReckonedThroughFather =>
    { label := "Hebrew זֶרַע is ordinarily reckoned through the father"
    , kind := .linguistic
      -- Granted by the reader who denies most of what is built on it: Lewis,
      -- "it is normal in Hebrew to describe descendants by the noun zeraʿ" and
      -- "unusual (though not unique)" to give it a feminine possessive (299).
      -- Calvin grants descent reckoned through the male "in regard to civil
      -- order" (Institutes II.13.3). `wellSupported`: no reader found denies it.
      -- That Genesis also speaks of a woman's seed (16:10, 24:60) does not
      -- deny it; it is the ground of a different claim,
      -- `womansSeedSaidOfOrdinaryBirths`, weighed against the step built on it.
    , source :=
        { primary := .work lewisWomansSeed (.page 299)
        , supporting :=
            [ .work calvinInstitutes (.sectionRef "II.13.3")
            , .work bhs (.apparatus genesis3_15) ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .seedOfTheWomanImpliesNoHumanFather =>
    { label := "The matrilineal wording of Genesis 3:15 marks a birth with no human father"
    , kind := .interpretive
      -- Ambiguous on purpose, as its holders leave it: Miravalle's word is
      -- "hint". `Results.Genesis` takes "marks" both ways.
    , source :=
        { primary := .work lutherOnTheCreation (.pages 298 299)
        , supporting :=
            [ .work miravalleMeetYourMother .whole
            , .work henryCommentary (.adLoc genesis3_15) ]
        , tradition := .christianTypological
        , confidence := .disputed } }
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
    , source := miravalleOnMicah }
  | .maryConceivedAsVirgin =>
    { label := "Mary conceived Jesus while a virgin"
    , kind := .historical
      -- The historical case is Brown's (1972): no parallel explains how the
      -- idea arose (30–32), and the charge of illegitimacy needs explaining by
      -- anyone who denies it (32–33). His verdict is "an unresolved problem"
      -- (33), and Fitzmyer (1973) finds the New Testament data "not
      -- unambiguous" (572). So still `disputed`: the best historical case
      -- leaves the question open, and the contest is recorded.
    , source :=
        { primary := .scripture virginConceptionNarratives
        , supporting := [.work brownProblemVirginalConception (.pages 30 33)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .independentAttestation =>
    { label :=
        "Matthew and Luke are independent traditions agreeing on the virgin conception"
    , kind := .historical
      -- The independence of the two sources is itself debated. Rhodea counts
      -- Luke's account parallel to Matthew's and independent of it (71) — for
      -- the conception, not for the prophecy: Luke makes no explicit reference
      -- to Isaiah 7:14 (see `lukeAllusionEdge`).
    , source :=
        { primary := .work brownBirthMessiah (.pages 26 38)
        , supporting :=
            [ .work brownProblemVirginalConception (.page 24)
            , .work rhodeaDidMatthewConceive (.page 71) ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .plausible } }
  | .isaiahIsNearTermSignToAhaz => isaiahIsNearTermSignToAhazCited
  | .nearTermExcludesMessianicSense => nearTermExcludesMessianicSenseCited
  | .nearTermFulfilmentIsUnclear => nearTermFulfilmentIsUnclearCited
  | .signGivenToHouseOfDavid => signGivenToHouseOfDavidCited
  | .maherShalalHashBazRepeatsTheTimetable => maherShalalHashBazRepeatsTheTimetableCited
  | .micahRulerFacesAssyria => micahRulerFacesAssyriaCited
  | .micahRulerReadMessianically => micahRulerReadMessianicallyCited
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
            , .work miravalleMeetYourMother .whole
            , .work miravalleIntroductionToMary .whole ] } }
  | .jesusSatisfiesCriterion =>
    { label := "Jesus of Nazareth satisfies the virgin-birth criterion"
    , kind := .interpretive
    , source := franceOnMatthew .disputed }

end TestimonyArguments.BornOfAVirgin
