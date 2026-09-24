import Testimony.Arguments.SolaFide.Sources
import Testimony.Arguments.SolaFide.Lines

/-!
# Arguments.SolaFide.Packages — the positions, and the variants

Five positions — Reformed, New Perspective, subjective genitive, apocalyptic,
Tridentine — and reduced Reformed packages, each missing a named premise.
Whether a premise is load-bearing is shown by removing it and then either
establishing the conclusion anyway or naming a countermodel.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Packages -/

/-- The classical Protestant position: both strands, and all three lexical
premises — ἔργα νόμου and πίστις Χριστοῦ in Paul, σῴζω in Luke. -/
def reformed : ArgumentPackage Claim :=
  { name := "Reformed (sola fide)"
  , cite := reformedCite
  , premises := caseOf [paulineLine, dominicalLine] sharedGrounds closingSteps
  , conclusion := p .salvationByGraceThroughFaithNotWorks
  , conclusionLabel := "salvation by grace through faith, not works" }

/-- The New Perspective on Paul: it denies the traditional reading of ἔργα
νόμου while accepting justification by faith, which is what Dunn and Wright
actually hold. It keeps the objective genitive, as Dunn does, so the one
Pauline ground it denies is the ἔργα νόμου premise. -/
def newPerspective : ArgumentPackage Claim :=
  { reformed with
    name := "New Perspective on Paul"
    cite := newPerspectiveCite
    premises :=
      caseOf
        [ paulineLine.onGrounds
            [ p .galatiansOpposesCircumcisionAsRequirement
            , notP .worksOfLawMeansWorksGenerally, p .pistisChristouObjective ]
        , dominicalLine ]
        sharedGrounds closingSteps }

/-- The subjective genitive (Hays): πίστις Χριστοῦ in Galatians 2:16 is Christ's
own faithfulness, so the verse does not name the believer's faith as the means
of justification. Everything else in the Reformed case is granted. -/
def subjectiveGenitive : ArgumentPackage Claim :=
  { reformed with
    name := "Subjective genitive (πίστις Χριστοῦ as Christ's faithfulness)"
    cite := subjectiveGenitiveCite
    premises :=
      caseOf
        [ paulineLine.onGrounds
            [ p .galatiansOpposesCircumcisionAsRequirement
            , p .worksOfLawMeansWorksGenerally, notP .pistisChristouObjective ]
        , dominicalLine ]
        sharedGrounds closingSteps }

/-- The apocalyptic reading of Paul (Martyn, Campbell). It rejects the
traditional reading's framing of justification and also the New Perspective's.
The question is neither how an individual is accepted nor how Jew and gentile
are related, but God's deliverance of the world in Christ.

It shares Galatians with the Reformed reading — the text of 2:16 and the
circumcision polemic — and closes with the same step to salvation. It does not
share the dominical strand, which neither Martyn nor Campbell argues from; to
grant it Luke 7:50 would be to encode a position nobody holds. -/
def apocalyptic : ArgumentPackage Claim :=
  { reformed with
    name := "Apocalyptic reading of Paul (Martyn, Campbell)"
    cite := apocalypticCite
    premises :=
      caseOf [apocalypticLine]
        [p .galatians2_16, p .galatiansOpposesCircumcisionAsRequirement] [toSalvation] }

/-- The Tridentine position: works performed in grace merit an increase of
justification, which is incompatible with the conclusion as stated.

Not built from the lines above, and that is the point: it shares four
prooftexts with them and nothing else, so `caseOf` would misdescribe it. -/
def tridentine : ArgumentPackage Claim :=
  { reformed with
    name := "Tridentine (Council of Trent, Session VI)"
    cite := baseCite
    premises :=
      [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .titus3_5
      , p .scriptureSelfConsistent, p .worksMeritIncreaseOfJustification
      , p .worksMeritIncreaseOfJustification ➝ notP .salvationByGraceThroughFaithNotWorks ] }

/-- The Reformed package without the ἔργα νόμου premise. -/
def reformedWithoutWorksOfLaw : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the ἔργα νόμου premise"
    premises :=
      caseOf
        [ paulineLine.onGrounds
            [p .galatiansOpposesCircumcisionAsRequirement, p .pistisChristouObjective]
        , dominicalLine ]
        sharedGrounds closingSteps }

/-- The Reformed package without the dominical lexical premise. -/
def reformedWithoutSozo : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the dominical lexical premise"
    premises := caseOf [paulineLine, dominicalLine.onGrounds []] sharedGrounds closingSteps }

/-- The Reformed package with the ἔργα νόμου premise **and** the dominical
lexical premise removed — one from each strand. The objective genitive stays. -/
def reformedWithoutEitherLexicalPremise : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the ἔργα νόμου and σῴζω premises"
    premises :=
      caseOf
        [ paulineLine.onGrounds
            [p .galatiansOpposesCircumcisionAsRequirement, p .pistisChristouObjective]
        , dominicalLine.onGrounds [] ]
        sharedGrounds closingSteps }

/-- The Reformed package with the objective genitive **and** the dominical
lexical premise removed. The ἔργα νόμου premise stays. -/
def reformedWithoutPistisChristouOrSozo : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the πίστις Χριστοῦ and σῴζω premises"
    premises :=
      caseOf
        [ paulineLine.onGrounds
            [ p .galatiansOpposesCircumcisionAsRequirement
            , p .worksOfLawMeansWorksGenerally ]
        , dominicalLine.onGrounds [] ]
        sharedGrounds closingSteps }

/-- The Reformed package without the premises that harmonise James. -/
def reformedWithoutJamesHarmonisation : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the James harmonisation"
    premises :=
      caseOf [paulineLine, dominicalLine] sharedGroundsWithoutJames [toSalvation] }

end Testimony.Arguments.SolaFide
