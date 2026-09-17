import Testimony.Arguments.SolaScriptura.Lines

/-!
# Arguments.SolaScriptura.Packages — the positions, and the variants results refute

Four positions on tradition, three objections, two parity replies, and the
variants each result needs. The rivals were written before anything was proved
about the position argued for.

Three packages are built to be *refuted*. A reply is shown to block an
objection by writing the objection's line on the reply's grounds and exhibiting
a countermodel; a reply is shown to be purely defensive by asking the same
grounds for the conclusion and exhibiting another.
-/

namespace Testimony.Arguments.SolaScriptura

open Testimony Testimony.Logic

/-- The label every package concluding the sole rule shares. -/
private def soleRuleLabel : String := "scripture is the sole infallible rule of faith"

/-! ### The positions -/

/-- **The Protestant position**: two routes to the conclusion, on the
final-arbiter reading. Scripture is not the only authority but the only
infallible one; tradition is ministerial, and practices neither commanded nor
forbidden need no scriptural warrant. -/
def protestant : ArgumentPackage Claim :=
  { name := "Protestant (sola scriptura as final arbiter)"
  , cite := cite
  , premises := caseOf [classicalLine, eliminativeLine] sharedGrounds []
  , conclusion := p .scriptureIsSoleInfallibleRule
  , conclusionLabel := soleRuleLabel }

/-- **Tradition 0**, as Geisler states it: creeds inform without binding, and
the historical-grammatical method does the work an authoritative interpreter
was supposed to do. -/
def tradition0 : ArgumentPackage Claim :=
  tradition0Line.asPackage cite soleRuleLabel

/-- **Tradition II**, the Tridentine two-source position. Its line delivers the
denial, so the package is not the line as it stands: the question asked of
these premises is whether sola scriptura follows, and the answer is that they
entail its negation. -/
def tridentine : ArgumentPackage Claim :=
  { tridentineLine.asPackage cite soleRuleLabel with
    conclusion := p .scriptureIsSoleInfallibleRule }

/-- **Tradition III**, resting on Vatican I. Kept separate from `tridentine`
because Mathison argues it escapes several objections to the two-source view
while incurring its own. -/
def vaticanI : ArgumentPackage Claim :=
  { vaticanLine.asPackage cite soleRuleLabel with
    conclusion := p .scriptureIsSoleInfallibleRule }

/-- **The Orthodox position**, on the mind of the Church rather than on a
magisterium. -/
def orthodox : ArgumentPackage Claim :=
  { orthodoxLine.asPackage cite soleRuleLabel with
    conclusion := p .scriptureIsSoleInfallibleRule }

/-! ### The objections -/

/-- The self-refutation objection, as a package concluding the negation. -/
def selfRefutation : ArgumentPackage Claim :=
  selfRefutationLine.asPackage cite "scripture is not the sole infallible rule of faith"

/-- The canon objection, likewise. -/
def canonObjection : ArgumentPackage Claim :=
  canonObjectionLine.asPackage cite "scripture is not the sole infallible rule of faith"

/-- The interpretive-authority regress, concluding that Tradition I is not
principled distinct from Tradition 0. -/
def interpretiveRegress : ArgumentPackage Claim :=
  interpretiveRegressLine.asPackage cite
    "sola scriptura does not differ in principle from solo scriptura"

/-! ### The two answers to self-refutation -/

/-- The objection with the classical answer in place of the ground it needed. -/
def selfRefutationAnswered : ArgumentPackage Claim :=
  { selfRefutation with
    name := "Self-refutation objection, answered from scripture's own teaching"
    premises := selfRefutationUnderClassicalAnswer.premises }

/-- The objection with the final-arbiter answer in place of the ground it
needed. -/
def selfRefutationUnderScope : ArgumentPackage Claim :=
  { selfRefutation with
    name := "Self-refutation objection, answered by scoping the bindingness rule"
    premises := selfRefutationUnderFinalArbiter.premises }

/-! ### The parity replies, and what they cost -/

/-- The canon objection with Kruger's parity reply in play. -/
def canonObjectionUnderParity : ArgumentPackage Claim :=
  { canonObjection with
    name := "Canon objection, with the parity reply in play"
    premises := canonUnderParity.premises }

/-- The same grounds, asked for the conclusion instead of for the block. -/
def canonParityReachingForSoleRule : ArgumentPackage Claim :=
  { canonObjection with
    name := "Kruger's parity reply, asked for the sole rule"
    premises := canonUnderParity.premises
    conclusion := p .scriptureIsSoleInfallibleRule
    conclusionLabel := soleRuleLabel }

/-- The interpretive-authority regress with Mathison's parity reply in play. -/
def interpretiveRegressUnderParity : ArgumentPackage Claim :=
  { interpretiveRegress with
    name := "Interpretive-authority regress, with the parity reply in play"
    premises := regressUnderParity.premises }

/-- The same grounds, asked to deliver the distinction rather than to block its
denial. -/
def regressParityReachingForDifference : ArgumentPackage Claim :=
  { interpretiveRegress with
    name := "Mathison's parity reply, asked for the distinction"
    premises := regressUnderParity.premises
    conclusion := p .traditionIDiffersInPrincipleFromTradition0
    conclusionLabel := "sola scriptura differs in principle from solo scriptura" }

/-! ### The hinge, in its two roles -/

/-- The Protestant position with the classical line stripped of the hinge. The
eliminative line is untouched. -/
def protestantWithoutHinge : ArgumentPackage Claim :=
  { protestant with
    name := "Protestant, minus the claim that scripture teaches the principle"
    premises :=
      caseOf
        [ classicalLine.onGrounds
            [ p .timothy3_16GodBreathed, p .timothy3_17ThoroughlyEquips
            , p .scriptureIsSufficient, p .scriptureIsPerspicuous ]
        , eliminativeLine ]
        sharedGrounds [] }

/-- The classical line alone, stripped of the hinge. -/
def classicalStrandWithoutHinge : ArgumentPackage Claim :=
  (classicalLine.onGrounds
    [ p .timothy3_16GodBreathed, p .timothy3_17ThoroughlyEquips
    , p .scriptureIsSufficient, p .scriptureIsPerspicuous ]).asPackage cite soleRuleLabel

/-! ### Geisler's charge, and the three replies -/

/-- Geisler's charge, stated as its holder states it. -/
def geislerCircle : ArgumentPackage Claim :=
  geislerCircleLine.asPackage cite "Tradition I's reasoning is circular"

/-- The charge pressed home to a defeat. -/
def circleDefeats : ArgumentPackage Claim :=
  circleDefeatsLine.asPackage cite "the circularity defeats Tradition I"

/-- The charge with Allen and Swain's accountability reply in play. -/
def geislerCircleUnderAccountability : ArgumentPackage Claim :=
  { geislerCircle with
    name := "Geisler's charge, with the accountability reply in play"
    premises := circleUnderAccountability.premises }

/-- The charge with the proposed scriptural-bounding reply in play. -/
def geislerCircleUnderScripturalBounding : ArgumentPackage Claim :=
  { geislerCircle with
    name := "Geisler's charge, with the scriptural-bounding reply in play"
    premises := circleUnderScripturalBounding.premises }

/-- The defeat with Barrett's parity reply in play. -/
def circleDefeatUnderParity : ArgumentPackage Claim :=
  { circleDefeats with
    name := "The circularity defeat, with the parity reply in play"
    premises := defeatUnderParity.premises }

/-- The same parity grounds, asked to show the circle is not there. -/
def circleParityReachingForVindication : ArgumentPackage Claim :=
  { circleDefeats with
    name := "Barrett's parity reply, asked to clear the charge"
    premises := defeatUnderParity.premises
    conclusion := notP .traditionIReasoningIsCircular
    conclusionLabel := "Tradition I's reasoning is not circular" }

/-! ### Geisler's circle -/

/-- Both legs of the circle Geisler alleges in Tradition I, asked for the
consensus. -/
def traditionICircle : ArgumentPackage Claim :=
  { name := "Tradition I's hermeneutical circle"
  , cite := cite
  , premises := [consensusRestsOnPerspicuity, perspicuityRestsOnConsensus]
  , conclusion := p .creedalConsensusIsHermeneuticallyNecessary
  , conclusionLabel := "the creedal consensus is hermeneutically necessary" }

/-- The same two legs, asked for the other end. -/
def traditionICircleForPerspicuity : ArgumentPackage Claim :=
  { traditionICircle with
    name := "Tradition I's hermeneutical circle, asked for perspicuity"
    conclusion := p .scriptureIsPerspicuous
    conclusionLabel := "scripture is clear on what is necessary for salvation" }

end Testimony.Arguments.SolaScriptura
