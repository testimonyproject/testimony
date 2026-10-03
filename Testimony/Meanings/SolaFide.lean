import Testimony.Semantics.Meaning
import Testimony.Arguments.SolaFide.Sources

/-!
# Testimony.Meanings.SolaFide — what each sola fide claim says

**A draft**, and the first argument given meanings. `means` is total over the
argument's atoms, as `cite` is: a new atom cannot be left without
one. Each meaning says what the atom's docstring says, in the vocabulary of
`Testimony.Semantics.Vocabulary`, and no more. Where the vocabulary cannot yet say
it, the meaning is `opaque`, and `unanalysed` counts those.

Three things the labelling made visible, which the atom names alone did not:

- **Textual and interpretive claims about one passage are now told apart by
  their form.** Luke 7:47 `says` that her sins are forgiven, for she loved
  much; the Reformed claim is what the passage `teaches` — that her love is the
  evidence of forgiveness, not its ground.
- **The disputed readings are found, not listed.** `contested` is computed from
  the meanings alone: every word given two senses at one place. It finds the
  readings the argument disputes — δικαιόω in Paul, the believing of John 6:29,
  doing the will in Matthew 7, keeping the commandments in Matthew 19, the water
  of John 3:5, the fire of Matthew 3:11 — and nothing else.
- **`james2_24Compatible` is a claim about senses.** It denies that James 2:24
  uses "justify" and "faith" in Paul's senses. An argument that sets James 2:24
  against Paul assumes the opposite, whether it says so or not; that is what
  `Testimony.Semantics.Discourse` checks.

Every query below is the generic one, `HasMeanings`, asked of this argument.
-/

namespace Testimony.Meanings.SolaFide

open Testimony Testimony.Semantics Testimony.Semantics.Notation
open Testimony.Arguments.SolaFide (Claim)






/-- Ephesians 2:8–9. -/
@[nolint defsWithUnderscore] abbrev eph2_8_9 : PassageRange := rg .ephesians 2 8 2 9
/-- Romans 3:28. -/
@[nolint defsWithUnderscore] abbrev rom3_28 : PassageRange := vs .romans 3 28
/-- Galatians 2:16. -/
@[nolint defsWithUnderscore] abbrev gal2_16 : PassageRange := vs .galatians 2 16
/-- Romans 4:4–5. -/
@[nolint defsWithUnderscore] abbrev rom4_4_5 : PassageRange := rg .romans 4 4 4 5
/-- Romans 4:6–8. -/
@[nolint defsWithUnderscore] abbrev rom4_6_8 : PassageRange := rg .romans 4 6 4 8
/-- Titus 3:5. -/
@[nolint defsWithUnderscore] abbrev titus3_5 : PassageRange := vs .titus 3 5
/-- Titus 3:5–7. -/
@[nolint defsWithUnderscore] abbrev titus3_5_7 : PassageRange := rg .titus 3 5 3 7
/-- Acts 15:9–11. -/
@[nolint defsWithUnderscore] abbrev acts15_9_11 : PassageRange := rg .acts 15 9 15 11
/-- Luke 7:50. -/
@[nolint defsWithUnderscore] abbrev luke7_50 : PassageRange := vs .luke 7 50
/-- Luke 7:41–47: the parable of the two debtors, and the verse it explains. -/
@[nolint defsWithUnderscore] abbrev luke7_41_47 : PassageRange := rg .luke 7 41 7 47
/-- Luke 18:9–14. -/
@[nolint defsWithUnderscore] abbrev luke18_9_14 : PassageRange := rg .luke 18 9 18 14
/-- James 2:14–26. -/
@[nolint defsWithUnderscore] abbrev james2_14_26 : PassageRange := rg .james 2 14 2 26
/-- James 2:24. -/
@[nolint defsWithUnderscore] abbrev james2_24 : PassageRange := vs .james 2 24
/-- John 6:29. -/
@[nolint defsWithUnderscore] abbrev john6_29 : PassageRange := vs .john 6 29
/-- John 3:5. -/
@[nolint defsWithUnderscore] abbrev john3_5 : PassageRange := vs .john 3 5
/-- Matthew 3:11. -/
@[nolint defsWithUnderscore] abbrev matt3_11 : PassageRange := vs .matthew 3 11
/-- Matthew 7:21. -/
@[nolint defsWithUnderscore] abbrev matt7_21 : PassageRange := vs .matthew 7 21
/-- Matthew 19:17. -/
@[nolint defsWithUnderscore] abbrev matt19_17 : PassageRange := vs .matthew 19 17
/-- James 2:21–25. -/
@[nolint defsWithUnderscore] abbrev james2_21_25 : PassageRange := rg .james 2 21 2 25
/-- Revelation 22:11. -/
@[nolint defsWithUnderscore] abbrev rev22_11 : PassageRange := vs .revelation 22 11
/-- Sirach 18:22. -/
@[nolint defsWithUnderscore] abbrev sir18_22 : PassageRange := vs .sirach 18 22
/-- The letter to the Galatians, as a whole. -/
abbrev galatians : PassageRange := rg .galatians 1 1 6 18

/-- Paul's doctrine, in the sense the Reformation gave the phrase: faith the
only means by which justification is received. -/
abbrev faithAlone : Content := rl .soleInstrumentOf (cn .faith) (cn .justification)

/-- **What each sola fide atom asserts.** Total, so no atom is left without a
meaning; `opaque` where the vocabulary cannot yet say it. -/
def means : Claim → Statement
  | .ephesians2_8_9 =>
    .says eph2_8_9 <| .both (rl .groundOf (cn .grace) (wd .sozo eph2_8_9)) <|
      .both (rl .instrumentOf (wd .pistis eph2_8_9) (wd .sozo eph2_8_9))
        (rl .excludedFrom (wd .erga eph2_8_9) (wd .sozo eph2_8_9))
  | .romans3_28 =>
    .says rom3_28 <| .both (rl .instrumentOf (wd .pistis rom3_28) (wd .dikaioo rom3_28))
      (rl .excludedFrom (wd .ergaNomou rom3_28) (wd .dikaioo rom3_28))
  | .galatians2_16 => .says gal2_16 (rl .excludedFrom (wd .ergaNomou gal2_16) (wd .dikaioo gal2_16))
  | .romans4_4_5 =>
    .says rom4_4_5 <| .both (rl .instrumentOf (wd .pisteuo rom4_4_5) (wd .logizomai rom4_4_5))
      (rl .excludedFrom (wd .erga rom4_4_5) (wd .logizomai rom4_4_5))
  | .titus3_5 => .says titus3_5 (rl .excludedFrom (wd .erga titus3_5) (wd .sozo titus3_5))
  | .worksOfLawMeansWorksGenerally => .means .ergaNomou (.usage .paul) .worksInGeneral
  | .pistisChristouObjective =>
    .also (.means .pistisChristou (.passage gal2_16) .faithInChrist) <|
      .also (.means .pistisChristou (.passage (vs .romans 3 22)) .faithInChrist)
        (.means .pistisChristou (.passage (vs .philippians 3 9)) .faithInChrist)
  | .galatiansOpposesCircumcisionAsRequirement =>
    .opposes galatians (rl .necessaryFor (cn .circumcision) (cn .justification))
  | .acts15_9_11 =>
    .says acts15_9_11 <| .both (rl .instrumentOf (wd .pistis acts15_9_11) (cn .cleansing))
      (rl .groundOf (cn .grace) (wd .sozo acts15_9_11))
  | .acts15YokeIsLawAsCondition => .means .zygos (.passage (vs .acts 15 10)) .lawAsCondition
  | .lukeKeepsTheLaw =>
    .opaque "Acts 15:20–21 and 21:20–24: the decree, and Jerusalem's zeal for the law"
  | .ephesiansIsPauline => .wrote .paul .ephesians
  | .titusIsPauline => .wrote .paul .titus
  | .firstPeterIsPetrine => .wrote .peter .firstPeter
  | .secondPeterIsPetrine => .wrote .peter .secondPeter
  | .righteousnessOfGodIsDeliverance =>
    .also (.means .dikaiosyneTheou (.usage .paul) .deliverance)
      (.denied (.means .dikaiosyneTheou (.usage .paul) .statusGranted))
  | .luke7_50FaithHasSavedYou =>
    .says luke7_50 <| .both (rl .instrumentOf (wd .pistis luke7_50) (wd .sozo luke7_50))
      (rl .precedes (cn .forgiveness) (wd .sozo luke7_50))
  | .sozoIsSoteriological => .means .sozo (.passage luke7_50) .salvation
  | .luke7_47LoveIsEvidence =>
    .teaches luke7_41_47 <| .both (rl .fruitOf (cn .charity) (cn .forgiveness))
      (.not (rl .groundOf (cn .charity) (cn .forgiveness)))
  | .james2TargetsDeadFaith =>
    .also (.means .pistis (.passage james2_14_26) .mereAssent)
      (.denied (.opposes james2_14_26 faithAlone))
  | .worksAreFruitNotGround =>
    .holds <| .both (rl .fruitOf (cn .works) (cn .faith))
      (rl .excludedFrom (cn .works) (cn .justification))
  | .james2_24Compatible =>
    .also (.denied (.sameSense .dikaioo (.passage james2_24) (.usage .paul)))
      (.denied (.sameSense .pistis (.passage james2_24) (.usage .paul)))
  | .james2_24NotByFaithAlone =>
    .says james2_24 <| .both (rl .saidBy (wd .erga james2_24) (wd .dikaioo james2_24))
      (.not (rl .soleInstrumentOf (wd .pistis james2_24) (wd .dikaioo james2_24)))
  | .scriptureSelfConsistent => .principle .scriptureSelfConsistent
  | .justificationByFaithAlone => .holds faithAlone
  | .faithIsSufficient => .holds (rl .sufficientFor (cn .faith) (cn .salvation))
  | .salvationByGrace => .holds (rl .groundOf (cn .grace) (cn .salvation))
  | .salvationNotByWorks => .holds (rl .excludedFrom (cn .works) (cn .salvation))
  | .salvationThroughFaith => .holds (rl .instrumentOf (cn .faith) (cn .salvation))
  | .justificationIsForensicOnly =>
    .holds <| .both (rl .includes (cn .justification) (cn .forgiveness))
      (.not (rl .includes (cn .justification) (cn .sanctification)))
  | .secondTempleCovenantalNomism =>
    .heldBy .secondTempleJudaism <| .both (rl .groundOf (cn .grace) (cn .covenant))
      (rl .instrumentOf (cn .works) (cn .covenant))
  | .worksMeritIncreaseOfJustification =>
    .holds (rl .merits (cn .worksOfFaith) (cn .increaseOfJustification))
  | .justificationIncludesSanctification =>
    .holds <| .both (rl .includes (cn .justification) (cn .forgiveness))
      (rl .includes (cn .justification) (cn .sanctification))
  | .justificationDistinctFromSanctification =>
    .holds <| .both (rl .inseparableFrom (cn .justification) (cn .sanctification))
      (rl .distinctFrom (cn .justification) (cn .sanctification))
  | .renewalGrowsThroughGoodWorks =>
    .holds (rl .growsThrough (cn .sanctification) (cn .worksOfFaith))
  | .john6_29WorkIsBelieving =>
    .says (rg .john 6 28 6 29) (rl .includes (wd .erga john6_29) (wd .pisteuo john6_29))
  | .johnLifeThroughBelieving =>
    .says (rg .john 3 16 3 18) (rl .instrumentOf (wd .pisteuo (rg .john 3 16 3 18))
      (cn .eternalLife))
  | .johannineBelievingIsTrust => .means .pisteuo (.passage john6_29) .trust
  | .johannineBelievingIsFormedByCharity => .means .pisteuo (.passage john6_29) .formedFaith
  | .gal3_11_12LawIsNotOfFaith =>
    .says (rg .galatians 3 11 3 12) <|
      .both (rl .excludedFrom (cn .law) (wd .dikaioo (vs .galatians 3 11)))
        (rl .distinctFrom (cn .law) (cn .faith))
  | .lawCommandsCharity => .says (vs .deuteronomy 6 5) (rl .includes (cn .law) (cn .charity))
  | .galatians1_6_9 =>
    .opaque "Galatians 1:6–9: whoever preaches a contrary gospel is accursed"
  | .firstCorinthians15_3 =>
    .says (vs .firstCorinthians 15 3) (rl .includes (cn .gospel) (cn .christsDeath))
  | .galatians2_21 =>
    .says (vs .galatians 2 21) <| .not <| .both (rl .groundOf (cn .law) (cn .justification))
      (rl .groundOf (cn .christsDeath) (cn .justification))
  | .galatians5_2_4 =>
    .says (rg .galatians 5 2 5 4) <| .not <|
      .both (rl .groundOf (cn .law) (wd .dikaioo (vs .galatians 5 4)))
        (rl .groundOf (cn .christsDeath) (wd .dikaioo (vs .galatians 5 4)))
  | .romans8_33_34 =>
    .says (rg .romans 8 33 8 34) (rl .agentOf (cn .god) (wd .dikaioo (vs .romans 8 33)))
  | .dikaioIsForensic =>
    .also (.means .dikaioo (.usage .paul) .verdict)
      (.denied (.means .dikaioo (.usage .paul) .makeRighteous))
  | .paulNamesRenewalOtherwise =>
    .also (.occurs .anakainosis titus3_5) <| .also (.occurs .hagiasmos (vs .romans 6 19))
      (.says titus3_5_7 (rl .distinctFrom (wd .anakainosis titus3_5_7) (wd .dikaioo titus3_5_7)))
  | .leastMeaning => .principle .leastMeaning
  | .paulsJustifyDenotesRenewal => .means .dikaioo (.usage .paul) .makeRighteous
  | .justifyingGraceRenews =>
    .holds (rl .inseparableFrom (cn .forgiveness) (cn .sanctification))
  | .augustineReadsJustifyAsMakeRighteous =>
    .also (.glosses .augustine .dikaioo .makeRighteous)
      (.glosses .latinWest .iustificare .makeRighteous)
  | .romans4_6_8 =>
    .says rom4_6_8 <| .both (rl .excludedFrom (wd .erga rom4_6_8) (wd .logizomai rom4_6_8))
      (rl .includes (wd .logizomai rom4_6_8) (cn .forgiveness))
  | .logizomaiIsReckoning => .means .logizomai (.passage (rg .romans 4 3 4 11)) .reckoning
  | .countedRighteousnessIsSinNotCounted =>
    .teaches rom4_6_8 (rl .includes (wd .logizomai rom4_6_8) (cn .forgiveness))
  | .christsWorkIsTheWholeGround =>
    .holds (rl .soleGroundOf (cn .christsDeath) (cn .justification))
  | .luke18_9_14TaxCollectorJustified =>
    .opaque "Luke 18:9–14: the tax collector, not the Pharisee, went home justified"
  | .luke18JustifiedIsVerdict => .means .dikaioo (.passage (vs .luke 18 14)) .verdict
  | .taxCollectorBringsNoWorks =>
    .teaches luke18_9_14 (rl .excludedFrom (cn .works) (wd .dikaioo (vs .luke 18 14)))
  | .matthew7_21_23DoingTheWill =>
    .says (rg .matthew 7 21 7 23) (rl .necessaryFor (wd .doingTheWill matt7_21) (cn .eternalLife))
  | .matthew7ObedienceIsAGround => .means .doingTheWill (.passage matt7_21) .groundOfEntry
  | .matthew7DoingIncludesBelieving =>
    .means .doingTheWill (.passage matt7_21) .includesBelieving
  | .matthew19_17KeepTheCommandments =>
    .says (rg .matthew 19 16 19 22)
      (rl .necessaryFor (wd .keepingTheCommandments matt19_17) (cn .eternalLife))
  | .matthew19CommandmentsAreTheWayToLife =>
    .means .keepingTheCommandments (.passage matt19_17) .groundOfEntry
  | .matthew19LawExposesInability =>
    .means .keepingTheCommandments (.passage matt19_17) .lawsOwnTerms
  | .baptismCommandedByChrist =>
    .opaque "Matthew 28:19, Acts 2:38: Christ commands baptism with water"
  | .baptismIsInstrumentalCause =>
    .holds (rl .instrumentOf (cn .baptism) (cn .justification))
  | .waterItselfNecessaryForSalvation =>
    .holds <| .both (rl .necessaryFor (cn .baptism) (cn .salvation))
      (.not (rl .sufficientFor (cn .desireForBaptism) (cn .salvation)))
  | .baptismOrItsDesire =>
    .opaque "Trent VI.4: justification not without the laver, or the desire of it"
  | .desireBringsFruitsWithoutTheSacrament =>
    .holds <| .both (rl .sufficientFor (cn .desireForBaptism) (cn .justification))
      (.not (rl .necessaryFor (cn .baptism) (cn .justification)))
  | .luke23_43ThiefPromisedParadise =>
    .opaque "Luke 23:43: the unbaptised thief promised paradise"
  | .thiefBearsOnTheGospel =>
    .opaque "The thief's case bears on salvation under the Gospel"
  | .acts8WaterThenSpirit => .says (rg .acts 8 14 8 17) (rl .precedes (cn .baptism) (cn .spirit))
  | .acts10SpiritThenWater => .says (rg .acts 10 44 10 48) (rl .precedes (cn .spirit) (cn .baptism))
  | .godNotBoundToWater => .holds (.not (rl .boundTo (cn .spirit) (cn .baptism)))
  | .john3_5WaterAndSpirit =>
    .says john3_5 <| .both (rl .necessaryFor (wd .hydor john3_5) (cn .eternalLife))
      (rl .necessaryFor (cn .spirit) (cn .eternalLife))
  | .john3_5RequiresWaterBaptism =>
    .teaches john3_5 (rl .necessaryFor (cn .baptism) (cn .eternalLife))
  | .john3_5WaterIsBaptism => .means .hydor (.passage john3_5) .baptismalWater
  | .john3_5WaterIsNaturalBirth => .means .hydor (.passage john3_5) .naturalBirth
  | .john3_5WaterIsEzekielsCleansing => .means .hydor (.passage john3_5) .ezekielsCleansing
  | .john3_5WaterIsTheSpiritsCleansing => .means .hydor (.passage john3_5) .spiritsCleansing
  | .matthew3_11SpiritAndFire => .occurs .pyr matt3_11
  | .fireIsJudgment => .means .pyr (.passage matt3_11) .judgment
  | .fireIsPurification => .means .pyr (.passage matt3_11) .purification
  | .fireIsPentecost => .means .pyr (.passage matt3_11) .pentecost
  | .james2FaithWithoutWorksIsDead =>
    .says james2_14_26 (.not (rl .sufficientFor (wd .pistis james2_14_26) (wd .sozo james2_14_26)))
  | .james2JustifiedByWorks =>
    .says james2_21_25 (rl .saidBy (wd .erga james2_21_25) (wd .dikaioo james2_21_25))
  | .dikaioIsDeclarativeOutsidePaul =>
    .also (.means .dikaioo (.passage (vs .matthew 11 19)) .showRighteous)
      (.means .dikaioo (.passage (vs .deuteronomy 25 1)) .verdict)
  | .jamesJustifyDenotesIncrease => .means .dikaioo (.usage .james) .makeRighteous
  | .jamesFaithAloneIsDeadFaith => .means .pistis (.passage james2_24) .mereAssent
  | .reformedFaithIsNoDeadFaith => .denied (.means .pistis (.usage .reformed) .mereAssent)
  | .jamesFaithIsNotReformedFaith =>
    .denied (.sameSense .pistis (.passage james2_24) (.usage .reformed))
  | .scriptureTeachesIncreaseOfJustification =>
    .holds (rl .growsThrough (cn .justification) (cn .worksOfFaith))
  | .worksCauseIncreaseOfJustification =>
    .holds (rl .groundOf (cn .worksOfFaith) (cn .increaseOfJustification))
  | .rev22_11BeJustifiedStill => .occurs .dikaioo rev22_11
  | .rev22_11GreekDoRighteousness => .denied (.occurs .dikaioo rev22_11)
  | .sir18_22BeJustifiedToDeath =>
    .says sir18_22 (rl .growsThrough (wd .dikaioo sir18_22) (cn .worksOfFaith))
  | .sir18_22GreekIsAVow =>
    .denied (.says sir18_22 (rl .growsThrough (wd .dikaioo sir18_22) (cn .worksOfFaith)))
  | .ephesians2_10CreatedForGoodWorks =>
    .says (rg .ephesians 2 8 2 10) (rl .fruitOf (wd .erga (vs .ephesians 2 10)) (cn .grace))
  | .james2_18ShowFaithByWorks =>
    .says (rg .james 2 18 2 22)
      (rl .fruitOf (wd .erga (vs .james 2 18)) (wd .pistis (vs .james 2 18)))
  | .romans6_22FruitToSanctification =>
    .says (vs .romans 6 22) (rl .growsThrough (cn .sanctification) (cn .worksOfFaith))
  | .luke17_10UnworthyServants =>
    .says (vs .luke 17 10) (.not (rl .merits (cn .works) (cn .eternalLife)))
  | .vulgateFreeFromDoctrinalError =>
    .opaque "The Vulgate is free from error in faith and morals; its authenticity is juridical"
  | .trentQuotesTheVulgateJuridically =>
    .opaque "Trent quotes the Vulgate's two verses as juridically authentic"
  | .doctrineToBeConfirmedFromOriginals =>
    .opaque "A doctrine taught from the Vulgate is to be confirmed from the originals"
  | .latinTextsConfirmedFromOriginals =>
    .opaque "Revelation 22:11 and Sirach 18:22 confirm the increase from the originals"
  | .originalTextDecides =>
    .opaque "What the original text does not say, a translation does not establish"
  | .jamesUsesDikaioAsPaul => .sameSense .dikaioo (.passage james2_24) (.usage .paul)
  | .rewardRenderedToMerits => .holds (rl .merits (cn .works) (cn .eternalLife))
  | .rewardTextsPromiseReward =>
    .opaque "God rewards the labor of believers (1 Cor 15:58; Heb 6:10; 10:35; 2 Tim 4:8)"

/-- Every sola fide atom, in declaration order. -/
def all : List Claim :=
  [ .ephesians2_8_9, .romans3_28, .galatians2_16, .romans4_4_5, .titus3_5
  , .worksOfLawMeansWorksGenerally, .pistisChristouObjective
  , .galatiansOpposesCircumcisionAsRequirement, .acts15_9_11, .acts15YokeIsLawAsCondition
  , .lukeKeepsTheLaw, .ephesiansIsPauline, .titusIsPauline, .firstPeterIsPetrine
  , .secondPeterIsPetrine, .righteousnessOfGodIsDeliverance, .luke7_50FaithHasSavedYou
  , .sozoIsSoteriological, .luke7_47LoveIsEvidence, .james2TargetsDeadFaith
  , .worksAreFruitNotGround, .james2_24Compatible, .james2_24NotByFaithAlone
  , .scriptureSelfConsistent
  , .justificationByFaithAlone, .faithIsSufficient, .salvationByGrace
  , .salvationNotByWorks, .salvationThroughFaith, .justificationIsForensicOnly
  , .secondTempleCovenantalNomism, .worksMeritIncreaseOfJustification
  , .justificationIncludesSanctification, .justificationDistinctFromSanctification
  , .renewalGrowsThroughGoodWorks, .john6_29WorkIsBelieving, .johnLifeThroughBelieving
  , .johannineBelievingIsTrust, .johannineBelievingIsFormedByCharity
  , .gal3_11_12LawIsNotOfFaith, .lawCommandsCharity, .galatians1_6_9
  , .firstCorinthians15_3, .galatians2_21, .galatians5_2_4, .romans8_33_34
  , .dikaioIsForensic, .paulNamesRenewalOtherwise, .leastMeaning
  , .paulsJustifyDenotesRenewal, .justifyingGraceRenews
  , .augustineReadsJustifyAsMakeRighteous, .romans4_6_8, .logizomaiIsReckoning
  , .countedRighteousnessIsSinNotCounted, .christsWorkIsTheWholeGround
  , .luke18_9_14TaxCollectorJustified, .luke18JustifiedIsVerdict
  , .taxCollectorBringsNoWorks, .matthew7_21_23DoingTheWill, .matthew7ObedienceIsAGround
  , .matthew7DoingIncludesBelieving, .matthew19_17KeepTheCommandments
  , .matthew19CommandmentsAreTheWayToLife, .matthew19LawExposesInability
  , .baptismCommandedByChrist, .baptismIsInstrumentalCause
  , .waterItselfNecessaryForSalvation, .baptismOrItsDesire
  , .desireBringsFruitsWithoutTheSacrament, .luke23_43ThiefPromisedParadise
  , .thiefBearsOnTheGospel, .acts8WaterThenSpirit, .acts10SpiritThenWater
  , .godNotBoundToWater, .john3_5WaterAndSpirit, .john3_5RequiresWaterBaptism
  , .john3_5WaterIsBaptism, .john3_5WaterIsNaturalBirth, .john3_5WaterIsEzekielsCleansing
  , .john3_5WaterIsTheSpiritsCleansing, .matthew3_11SpiritAndFire, .fireIsJudgment
  , .fireIsPurification, .fireIsPentecost, .james2FaithWithoutWorksIsDead
  , .james2JustifiedByWorks, .dikaioIsDeclarativeOutsidePaul, .jamesJustifyDenotesIncrease
  , .jamesFaithAloneIsDeadFaith, .reformedFaithIsNoDeadFaith, .jamesFaithIsNotReformedFaith
  , .scriptureTeachesIncreaseOfJustification, .worksCauseIncreaseOfJustification
  , .rev22_11BeJustifiedStill, .rev22_11GreekDoRighteousness, .sir18_22BeJustifiedToDeath
  , .sir18_22GreekIsAVow, .originalTextDecides, .vulgateFreeFromDoctrinalError
  , .trentQuotesTheVulgateJuridically, .doctrineToBeConfirmedFromOriginals
  , .latinTextsConfirmedFromOriginals, .ephesians2_10CreatedForGoodWorks
  , .james2_18ShowFaithByWorks, .romans6_22FruitToSanctification, .luke17_10UnworthyServants
  , .rewardTextsPromiseReward, .jamesUsesDikaioAsPaul
  , .rewardRenderedToMerits ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- `all` has no repeats. -/
theorem all_nodup : all.Nodup := by decide

/-- What each sola fide atom says. -/
instance meanings : HasMeanings Claim where
  argument := "Sola fide"
  all := all
  means := means
  complete := all_complete

/-- **Ninety-seven of the hundred and ten are analysed.** Of the thirteen that
are not, four are Pius XII's and Trent's claims about the Vulgate and one is the
textual principle, whose content is a rule about texts and translations the
vocabulary cannot yet state; the other eight are the narrative texts of the
thief and the tax collector, Galatians 1:6–9, Christ's command to baptise,
Trent's "laver, or the desire thereof", Luke's law-observance, and the texts
that promise a reward. Each needs a word the vocabulary lacks — a command, a
curse, a disjunction, a story's outcome, a reward. -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (97, 110) := by decide

/-- **The disputed readings, found from the meanings alone**: δικαιόω in Paul;
the believing of John 6:29; doing the will in Matthew 7; keeping the
commandments in Matthew 19; the water of John 3:5, four ways; the fire of
Matthew 3:11, three ways. Fifteen readings at six places; each pair is counted
in both orders, so twenty-six ordered pairs. -/
theorem contested_length : (HasMeanings.contested (α := Claim)).length = 26 := by decide

/-- **Twenty-one claims turn on δικαιόω**: six Pauline texts that use it or
name renewal beside it; the forensic reading of Paul's word, the renewal reading,
and Augustine's gloss; the verdict and the tax collector of Luke 18; James
2:21–25, James 2:24, and whether 2:24 is compatible with Paul; the word outside
Paul, Trent's reading of James's word, and the claim that James's word is
Paul's; and Revelation 22:11 and Sirach 18:22, each in the Latin and in the
Greek. -/
theorem about_dikaioo : (HasMeanings.about (α := Claim) .dikaioo).length = 21 := by decide

end Testimony.Meanings.SolaFide
