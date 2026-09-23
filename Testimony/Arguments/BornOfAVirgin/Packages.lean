import Testimony.Arguments.BornOfAVirgin.Sources
import Testimony.Arguments.BornOfAVirgin.Lines

/-!
# Arguments.BornOfAVirgin.Packages — the positions, and the variants

A handful of these packages are positions someone holds; the rest exist to be
*refuted*, because "this premise is load-bearing" is proved by removing it and
exhibiting a countermodel, and the package with it removed has to be written
down to be refuted. So the file grows with every result, and counting it here
would only be one more thing to keep current.

Each variant is a named difference from `christian`: one line on different
grounds, or one fewer line. Before `Line` existed each restated the whole
twenty-one element premise list, where a reader could not see which premise had
gone and a slip in the other twenty was invisible.

Two packages are *not* built from the lines, and deliberately. `critical`
grants the texts and denies every inference drawn from them, so its premises
group by kind rather than by strand. `lexicalCriticalUnderCompatibility` mixes
the objector's grounds with the replies to them. Forcing either into `caseOf`
would describe them as something they are not.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony Testimony.Bib Testimony.Logic
open Testimony.People

/-- The scriptural argument: four strands, no appeal to magisterial
authority. -/
def christian : ArgumentPackage Claim :=
  { name := "Scriptural reading of Isaiah 7:14, Genesis 3:15 and Micah 5:2–3"
  , cite := cite
  , premises := caseOf scripturalLines sharedGrounds [toFulfilment]
  , conclusion := p .jesusSatisfiesCriterion
  , conclusionLabel := fulfillmentLabel jesus bornOfAVirgin
    -- Each strand's inference is contested as its interpretive atoms are: by
    -- the critical readings recorded against every one of them.
  , inferences :=
      [ motyerOnIsaiah, miravalleOnMary, postellOnIsaiah (.pages 490 493) .disputed
      , franceOnMatthew .disputed ] }

/-- The Roman Catholic package: the four scriptural strands *and* the
magisterial one. This is the position as actually held — Scripture and Tradition
together — and it is kept distinct from `christian` because its extra premise is
one this library's author does not grant. -/
def catholic : ArgumentPackage Claim :=
  { christian with
    name := "Roman Catholic reading (Scripture and magisterial teaching)"
    premises := magisterialLine.premises ++ christian.premises }

/-- The magisterial route on its own, with no exegetical premise at all. -/
def magisterialOnly : ArgumentPackage Claim :=
  { christian with
    name := "Magisterial teaching alone"
    premises :=
      caseOf [magisterialLine] [p .maryConceivedAsVirgin] [toFulfilment] }

/-- The magisterial route as it stands for a reader who denies that magisterial
teaching settles doctrinal questions, holding with Westminster I.x that
Scripture is the supreme judge. -/
def magisterialDenied : ArgumentPackage Claim :=
  { christian with
    name := "Magisterial teaching, with its authority denied"
    premises :=
      caseOf
        [ magisterialLine.onGrounds
            [ p .magisteriumTeachesVirginalConception
            , notP .magisteriumIsDoctrinallyAuthoritative
            , p .scriptureIsSupremeJudge ] ]
        [p .maryConceivedAsVirgin] [toFulfilment] }

/-- The Isaianic line with the lexical premise removed, everything else it
rests on retained. The one difference that most of the results below turn
on. -/
def isaianicWithoutAlmah : Line Claim :=
  isaianicLine.onGrounds
    [ p .isaiahPredictsVirginBirth, p .lxxRendersParthenos
    , p .matthewQuotesIsaiah, p .matthewIntendsFulfilment ]

/-- The scriptural package with the lexical premise removed, everything else
retained. -/
def christianWithoutAlmah : ArgumentPackage Claim :=
  { christian with
    name := "Scriptural reading, minus the lexical premise"
    premises :=
      caseOf [isaianicWithoutAlmah, protoevangeliumLine, micheanLine, compositionalLine]
        sharedGrounds [toFulfilment] }

/-- The Isaianic strand by itself, with the lexical premise removed: the
argument exactly as this module encoded it before the other three strands were
added. Kept so that the earlier finding stays checkable. -/
def isaianicStrandWithoutAlmah : ArgumentPackage Claim :=
  { christian with
    name := "Isaianic strand alone, minus the lexical premise"
    premises := caseOf [isaianicWithoutAlmah] sharedGrounds [toFulfilment] }

/-- The scriptural package with all four interpretive hinges removed, every
textual and historical premise retained. -/
def christianWithoutAnyHinge : ArgumentPackage Claim :=
  { christian with
    name := "Scriptural reading, minus all four interpretive hinges"
    premises :=
      caseOf
        [ isaianicWithoutAlmah
        , protoevangeliumLine.onGrounds
            [ p .genesis3_15SeedOfTheWoman, p .genesis3_15IsProtoevangelium
            , p .seedReckonedThroughFather ]
        , micheanLine.onGrounds [p .micah5_3NamesMotherOnly]
        , compositionalLine.onGrounds
            [ p .isaiah2to12FramedByEschatology
            , p .compositionalReadingYieldsFutureBirth ] ]
        sharedGrounds [toFulfilment] }

/-- The Isaianic strand with Berry's defensive lexical premise in place of the
assertive one: עַלְמָה *admits* the sense "virgin" rather than *bearing* it. -/
def isaianicStrandOnAdmissibility : ArgumentPackage Claim :=
  { christian with
    name := "Isaianic strand, with the lexical premise weakened to admissibility"
    premises :=
      caseOf
        [ isaianicLine.onGrounds
            [ p .isaiahPredictsVirginBirth, p .almahAdmitsVirginSense
            , p .lxxRendersParthenos, p .matthewQuotesIsaiah
            , p .matthewIntendsFulfilment ] ]
        sharedGrounds [toFulfilment] }

/-- The critical reading: the quotation, the Septuagint rendering and the
wording of Genesis and Micah are all granted, and every inference drawn from
them is denied.

Written flat rather than from the lines above, because that is its shape: the
texts first, then the critical readings of them, then the denials. It is not
four strands on shared ground; it is the refusal of four strands. -/
def critical : ArgumentPackage Claim :=
  { name := "Critical reading: near-term sign, etiology, and silence"
  , cite := cite
  , premises :=
      [ p .lxxRendersParthenos, p .matthewQuotesIsaiah
      , p .genesis3_15SeedOfTheWoman, p .micah5_3NamesMotherOnly
      , p .isaiahIsNearTermSignToAhaz, p .nearTermExcludesMessianicSense
      , p .genesis3_15IsEtiology, p .maternalSilenceProvesNothing
      , notP .almahMeansVirgin
      , notP .genesis3_15IsProtoevangelium
      , notP .seedOfTheWomanImpliesNoHumanFather
      , notP .maternalSilenceImpliesNoHumanFather
      , criticalExclusion
      , toCriterion, genesisToCriterion, micahToCriterion, toFulfilment ]
  , conclusion := p .jesusSatisfiesCriterion
  , conclusionLabel := fulfillmentLabel jesus bornOfAVirgin }

/-- The critical case for denying the predictive reading, stated as an argument
in its own right rather than assumed inside `critical`. Its conclusion is the
denial, not anything about Jesus. -/
def criticalDenial : ArgumentPackage Claim :=
  criticalExclusionLine.asPackage cite
    "Isaiah 7:14 is not a prediction of a virgin birth"

/-- The same case with Berry's observation in play, and the exclusion premise
no longer simply granted. -/
def criticalDenialUnderBerry : ArgumentPackage Claim :=
  { criticalDenial with
    name := "Critical denial, with Berry's objection in play"
    premises :=
      (criticalExclusionLine.onGrounds
        [ p .isaiahIsNearTermSignToAhaz, p .nearTermFulfilmentIsUnclear
        , berryBlocksExclusion ]).premises }

/-- Berry's objection as a position of its own: its conclusion is that the
near-term reading does not exclude the messianic sense. -/
def berryObjection : ArgumentPackage Claim :=
  berryLine.asPackage cite
    "a near-term sign to Ahaz does not exclude a messianic sense"

/-- Postell's parity argument as a position of its own, with the same conclusion
as Berry's reached from different grounds. -/
def postellParity : ArgumentPackage Claim :=
  postellLine.asPackage cite
    "a near-term sign to Ahaz does not exclude a messianic sense"

/-- Motyer's reply as a position of its own: Isaiah 7:14 is not a near-term
sign to Ahaz. -/
def motyerReply : ArgumentPackage Claim :=
  motyerLine.asPackage cite "Isaiah 7:14 is not a near-term sign to Ahaz"

/-- The critical denial with Postell's parity argument in play, and the
exclusion premise no longer simply granted. -/
def criticalDenialUnderParity : ArgumentPackage Claim :=
  { criticalDenial with
    name := "Critical denial, with the parity argument in play"
    premises :=
      (criticalExclusionLine.onGrounds
        [ p .isaiahIsNearTermSignToAhaz, p .isaiah9And11AreMessianic
        , p .isaiah9And11ShareTheAssyrianTimeline
        , parityDefeatsNearTermExclusion ]).premises }

/-- The referential argument: Mary answers Isaiah's description, so Matthew's
claim never required עַלְמָה to denote virginity. Its conclusion is the *denial
of the objection's premise*, not the criterion — see
`compatibility_does_not_establish_criterion`. -/
def semantic : ArgumentPackage Claim :=
  { name := "Referential reading: a virgin is an עַלְמָה"
  , cite := cite
  , premises := caseOf [referentialLine] [] [descriptionFitDefeatsLexicalDemand]
  , conclusion := notP .lexicalSenseRequiredForFulfilment
  , conclusionLabel := "Matthew's claim does not require עַלְמָה to denote virginity" }

/-- The same premises, asked to deliver the criterion instead. They do not. -/
def semanticReachingForCriterion : ArgumentPackage Claim :=
  { semantic with
    name := "Referential reading, asked for the criterion"
    premises := semantic.premises ++ [toFulfilment]
    conclusion := p .jesusSatisfiesCriterion
    conclusionLabel := fulfillmentLabel jesus bornOfAVirgin }

/-! ### Wegner's objection, and the circle in it

Four variants of one line, each a named difference. `wegnerLine` grants
everything Wegner needs; the rest take one ground away and put in its place the
step that is supposed to supply it. -/

/-- **Wegner's objection at full strength**, granted every premise it needs:
the predicate-adjective parse, the near-term setting of the sign, the ordinary
pregnancy that setting supplies, and the principle that the Isaianic referent
settles the word's denotation.

Stated first and in full, because the results that follow are about where its
weight rests and are worth nothing against a weakened rival. -/
def wegnerLexical : ArgumentPackage Claim :=
  { name := "Wegner's grammatical objection: the עַלְמָה is already pregnant"
  , cite := cite
  , premises := caseOf [wegnerLine] [] wegnerClosingSteps
  , conclusion := notP .almahMeansVirgin
  , conclusionLabel := "עַלְמָה at Isaiah 7:14 does not denote a virgin" }

/-- Wegner's line with the ordinary pregnancy no longer granted. It is the one
ground that goes; the parse, the near-term setting and the referent principle
all stay. -/
def wegnerWithoutTheOrdinaryPregnancy : Line Claim :=
  wegnerLine.onGrounds
    [ p .harahIsPredicateAdjective, p .isaiahIsNearTermSignToAhaz
    , p .oneReferentSettlesDenotation ]

/-- The same objection with the ordinary pregnancy derived instead of assumed —
derived as Wegner derives it, from the reading of the sign, which is not
granted either. -/
def wegnerWithoutOrdinaryPregnancy : ArgumentPackage Claim :=
  { wegnerLexical with
    name := "Wegner's objection, with the ordinary pregnancy no longer assumed"
    premises :=
      caseOf [wegnerWithoutTheOrdinaryPregnancy] []
        (readingSuppliesOrdinaryPregnancy :: wegnerClosingSteps) }

/-- Wegner's line as it stands inside the circle: the ordinary pregnancy gone
from its grounds, and the demand that עַלְמָה carry the sense — which is what the
return leg needs — put in. -/
def wegnerInTheCircle : Line Claim :=
  wegnerLine.onGrounds
    [ p .harahIsPredicateAdjective, p .isaiahIsNearTermSignToAhaz
    , p .oneReferentSettlesDenotation, p .lexicalSenseRequiredForFulfilment ]

/-- **Both legs of the circle at once**, with every uncontested datum retained:
the parse, the near-term setting, the referent principle, and the demand that
עַלְמָה carry the sense. Asked for the lexical conclusion. -/
def wegnerCircle : ArgumentPackage Claim :=
  { wegnerLexical with
    name := "Wegner's objection with both legs of the circle in place"
    premises :=
      caseOf [wegnerInTheCircle] []
        (readingSuppliesOrdinaryPregnancy ::
          lexicalConclusionTellsAgainstPrediction :: wegnerClosingSteps) }

-- A package asking the circle for its other end used to stand here. Both ends
-- are now asked of `wegnerCircle.premises` directly, since `Independent` takes
-- a premise list and a proposition rather than a package's own conclusion.

/-- Wegner's line with Postell's usage datum in place of the referent
principle. The parse and the ordinary pregnancy both stay: this reply concedes
the referent and contests only what may be inferred from it. -/
def wegnerUnderParity : Line Claim :=
  wegnerLine.onGrounds
    [ p .harahIsPredicateAdjective, p .isaiahIsNearTermSignToAhaz
    , p .pregnancyAtTheSignIsOrdinary, p .otherClearAlmahCasesAreVirgins ]

/-- Wegner's objection with Postell's usage parity in play. -/
def wegnerUnderUsageParity : ArgumentPackage Claim :=
  { wegnerLexical with
    name := "Wegner's objection, with the usage parity reply in play"
    premises :=
      caseOf [wegnerUnderParity] []
        (usageParityBlocksReferentInference :: wegnerClosingSteps) }

/-- The lexical objection with its versional support, stated as its holder
would state it. -/
def lexicalCritical : ArgumentPackage Claim :=
  { name := "Lexical objection from the ancient versions"
  , cite := cite
  , premises := caseOf [versionalLine] [] [lexicalObjection]
  , conclusion := notP .jesusSatisfiesCriterion
  , conclusionLabel := "Jesus does not satisfy the virgin-birth criterion" }

/-- The same objection, with the referential premises in play and its own
key premise no longer simply granted.

Written flat: it is the objector's grounds and the replies to them side by
side, which is neither one line nor several converging ones. -/
def lexicalCriticalUnderCompatibility : ArgumentPackage Claim :=
  { lexicalCritical with
    name := "Lexical objection, with the referential reply in play"
    premises :=
      [ p .targumRendersUlemta, p .theThreeRenderNeanis, p .qumranConfirmsAlmah
      , p .lxxRendersParthenos, p .peshittaRendersBtulta
      , p .almahDenotesMarriageableYoungWoman, p .virginityCompatibleWithAlmah
      , p .maryWasAnAlmah, p .maryConceivedAsVirgin
      , toDescriptionFit, descriptionFitDefeatsLexicalDemand
      , compatibilityDissolvesDivergence
      , versionalObjection, lexicalObjection ] }

end Testimony.Arguments.BornOfAVirgin
