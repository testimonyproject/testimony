import Testimony.Arguments.SolaFide.Sources
import Testimony.Arguments.SolaFide.Lines

/-!
# Arguments.SolaFide.Packages — the positions, and the variants

Three positions — Reformed, New Perspective, Tridentine — and four reduced
Reformed packages that exist to be refuted, because "this premise is
load-bearing" is shown by removing it and naming a countermodel.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Packages -/

/-- The classical Protestant position: both strands, both lexical premises. -/
def reformed : ArgumentPackage Claim :=
  { name := "Reformed (sola fide)"
  , cite := reformedCite
  , premises := caseOf [paulineLine, dominicalLine] sharedGrounds closingSteps
  , conclusion := p .salvationByGraceThroughFaithNotWorks
  , conclusionLabel := "salvation by grace through faith, not works" }

/-- The New Perspective on Paul: it denies the traditional reading of ἔργα
νόμου while accepting justification by faith, which is what Dunn and Wright
actually hold. -/
def newPerspective : ArgumentPackage Claim :=
  { reformed with
    name := "New Perspective on Paul"
    cite := newPerspectiveCite
    premises :=
      caseOf [paulineLine.onGrounds [notP .worksOfLawMeansWorksGenerally], dominicalLine]
        sharedGrounds closingSteps }

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
      , .imp (p .worksMeritIncreaseOfJustification)
             (notP .salvationByGraceThroughFaithNotWorks) ] }

/-- The Reformed package without the Pauline lexical premise. -/
def reformedWithoutWorksOfLaw : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the Pauline lexical premise"
    premises := caseOf [paulineLine.onGrounds [], dominicalLine] sharedGrounds closingSteps }

/-- The Reformed package without the dominical lexical premise. -/
def reformedWithoutSozo : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the dominical lexical premise"
    premises := caseOf [paulineLine, dominicalLine.onGrounds []] sharedGrounds closingSteps }

/-- The Reformed package with **both** lexical premises removed. -/
def reformedWithoutEitherLexicalPremise : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus both lexical premises"
    premises :=
      caseOf [paulineLine.onGrounds [], dominicalLine.onGrounds []]
        sharedGrounds closingSteps }

/-- The Reformed package without the premises that harmonise James. -/
def reformedWithoutJamesHarmonisation : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the James harmonisation"
    premises :=
      caseOf [paulineLine, dominicalLine] sharedGroundsWithoutJames [toSalvation] }

end Testimony.Arguments.SolaFide
