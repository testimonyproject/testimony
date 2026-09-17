import Testimony.Arguments.SolaScriptura.Sources

/-!
# Arguments.SolaScriptura.Lines — the inference steps and the lines of reason

Two lines reach the conclusion, three positions deny it, and three objections
attack it from different directions. The objections do not reduce to one
another: self-refutation says the doctrine fails its own standard, the canon
objection says an authority outside scripture is needed to identify scripture,
and the interpretive-authority regress says the authority claimed is the
claimant in disguise.

**Redundancy does not defend the hinge here.** In `SolaFide`, adding a second
strand defeated an attack on a premise. These objections are not premise
attacks: each independently delivers the negation of the conclusion, so a
further route to the conclusion does nothing against them. What answers an
objection is denying one of *its* grounds, which is why every reply below is
written with `Line.onGrounds` — the objection's own line, with the ground the
reply refuses put back as what the reply offers instead.
-/

namespace Testimony.Arguments.SolaScriptura

open Testimony Testimony.Logic

/-! ### Steps reaching the conclusion -/

/-- Sufficiency and perspicuity, with the prooftexts and the claim that
scripture teaches the principle, yield the sole infallible rule. -/
def toSoleRule : Formula Claim :=
  .imp (conjOf
        [ p .timothy3_16GodBreathed, p .timothy3_17ThoroughlyEquips
        , p .scriptureIsSufficient, p .scriptureIsPerspicuous
        , p .solaScripturaIsTaughtByScripture ])
       (p .scriptureIsSoleInfallibleRule)

/-- The eliminative route: scripture is infallible, nothing else is, so
scripture is the *sole* infallible rule. It never asserts that scripture
teaches the principle. -/
def eliminativeToSoleRule : Formula Claim :=
  .imp (conjOf [p .scriptureIsInfallible, p .noOtherRuleIsInfallible])
       (p .scriptureIsSoleInfallibleRule)

/-- Geisler's route: the historical-grammatical method suffices, so creeds may
inform without binding, and no second infallible rule is needed. -/
def tradition0ToSoleRule : Formula Claim :=
  .imp (conjOf
        [ p .historicalGrammaticalMethodSuffices, p .creedsAreInformativeNotNormative
        , p .scriptureIsInfallible, p .noOtherRuleIsInfallible ])
       (p .scriptureIsSoleInfallibleRule)

/-! ### Steps denying it -/

/-- **Tradition II.** Binding unwritten tradition as a coordinate source denies
that scripture is the sole rule. -/
def tridentineDeniesSoleRule : Formula Claim :=
  .imp (conjOf
        [ p .thessalonians2_15TraditionBinding
        , p .traditionIsCoordinateSourceOfRevelation ])
       (notP .scriptureIsSoleInfallibleRule)

/-- **Tradition III.** An infallible magisterium is a second infallible rule,
whatever is said about sources. -/
def magisterialDeniesSoleRule : Formula Claim :=
  .imp (p .magisteriumIsInfallible) (notP .scriptureIsSoleInfallibleRule)

/-- **Orthodoxy.** The mind of the Church interpreting infallibly is likewise a
second infallible rule — and it is not the magisterial premise. -/
def orthodoxDeniesSoleRule : Formula Claim :=
  .imp (p .churchMindIsInfallibleInterpreter) (notP .scriptureIsSoleInfallibleRule)

/-! ### The three objections -/

/-- If a doctrine binds only when scripture teaches it, and scripture does not
teach sola scriptura, then sola scriptura does not bind. -/
def selfRefutationStep : Formula Claim :=
  .imp (conjOf [p .onlyScripturalDoctrineIsBinding, notP .solaScripturaIsTaughtByScripture])
       (notP .scriptureIsSoleInfallibleRule)

/-- If the canon is known only through the Church's reception, and identifying
the canon requires an infallible authority, then an infallible authority
outside scripture is needed to identify scripture. -/
def canonObjectionStep : Formula Claim :=
  .imp (conjOf
        [ p .canonKnownThroughChurchReception
        , p .identifyingCanonRequiresInfallibleAuthority ])
       (notP .scriptureIsSoleInfallibleRule)

/-- Cross and Judisch: if the individual retains ultimate interpretive
authority, exercised indirectly by choosing the body to submit to, then
Tradition I's ministerial authority is not a principled difference from
Tradition 0. -/
def interpretiveRegressStep : Formula Claim :=
  .imp (conjOf
        [ p .traditionHasMinisterialAuthority
        , p .individualRetainsUltimateInterpretiveAuthority ])
       (notP .traditionIDiffersInPrincipleFromTradition0)

/-! ### Geisler's circle

Two legs, each supplying the other's ground. The consensus of the Church is
said to rest on the clarity of scripture, while the clear sense of scripture is
said to require the consensus of the Church. -/

/-- Leg one: the creedal consensus rests on scripture's clarity. -/
def consensusRestsOnPerspicuity : Formula Claim :=
  .imp (p .scriptureIsPerspicuous) (p .creedalConsensusIsHermeneuticallyNecessary)

/-- Leg two: scripture's clear sense is not obtainable without that
consensus. -/
def perspicuityRestsOnConsensus : Formula Claim :=
  .imp (p .creedalConsensusIsHermeneuticallyNecessary) (p .scriptureIsPerspicuous)

/-! ### The lines -/

/-- **The classical Protestant line**, running through the claim that scripture
teaches the principle. -/
def classicalLine : Line Claim :=
  { name := "Classical (scripture teaches the principle)"
  , grounds :=
      [ p .timothy3_16GodBreathed, p .timothy3_17ThoroughlyEquips
      , p .scriptureIsSufficient, p .scriptureIsPerspicuous
      , p .solaScripturaIsTaughtByScripture ]
  , step := toSoleRule
  , delivers := p .scriptureIsSoleInfallibleRule }

/-- **The eliminative line**, which reaches the conclusion without the hinge. -/
def eliminativeLine : Line Claim :=
  { name := "Eliminative (nothing else is infallible)"
  , grounds := [p .scriptureIsInfallible, p .noOtherRuleIsInfallible]
  , step := eliminativeToSoleRule
  , delivers := p .scriptureIsSoleInfallibleRule }

/-- **Tradition 0**, as Geisler states it rather than as Mathison describes
it. -/
def tradition0Line : Line Claim :=
  { name := "Tradition 0 (creeds informative, not normative)"
  , grounds :=
      [ p .historicalGrammaticalMethodSuffices, p .creedsAreInformativeNotNormative
      , p .scriptureIsInfallible, p .noOtherRuleIsInfallible ]
  , step := tradition0ToSoleRule
  , delivers := p .scriptureIsSoleInfallibleRule }

/-- **Tradition II**, the Tridentine two-source position. -/
def tridentineLine : Line Claim :=
  { name := "Tradition II (two coordinate sources)"
  , grounds :=
      [ p .thessalonians2_15TraditionBinding
      , p .traditionIsCoordinateSourceOfRevelation ]
  , step := tridentineDeniesSoleRule
  , delivers := notP .scriptureIsSoleInfallibleRule }

/-- **Tradition III**, resting on Vatican I rather than on Trent. -/
def vaticanLine : Line Claim :=
  { name := "Tradition III (the magisterium as the one real source)"
  , grounds := [p .magisteriumIsInfallible]
  , step := magisterialDeniesSoleRule
  , delivers := notP .scriptureIsSoleInfallibleRule }

/-- **The Orthodox line**, grounded on the mind of the Church. -/
def orthodoxLine : Line Claim :=
  { name := "Orthodox (the mind of the Church)"
  , grounds := [p .churchMindIsInfallibleInterpreter]
  , step := orthodoxDeniesSoleRule
  , delivers := notP .scriptureIsSoleInfallibleRule }

/-- **The self-refutation objection.** -/
def selfRefutationLine : Line Claim :=
  { name := "Self-refutation objection"
  , grounds :=
      [ p .onlyScripturalDoctrineIsBinding
      , notP .solaScripturaIsTaughtByScripture ]
  , step := selfRefutationStep
  , delivers := notP .scriptureIsSoleInfallibleRule }

/-- **The canon objection.** -/
def canonObjectionLine : Line Claim :=
  { name := "Canon objection"
  , grounds :=
      [ p .canonKnownThroughChurchReception
      , p .identifyingCanonRequiresInfallibleAuthority ]
  , step := canonObjectionStep
  , delivers := notP .scriptureIsSoleInfallibleRule }

/-- **The interpretive-authority regress.** -/
def interpretiveRegressLine : Line Claim :=
  { name := "Interpretive-authority regress"
  , grounds :=
      [ p .traditionHasMinisterialAuthority
      , p .individualRetainsUltimateInterpretiveAuthority ]
  , step := interpretiveRegressStep
  , delivers := notP .traditionIDiffersInPrincipleFromTradition0 }

/-! ### The replies, as substituted grounds

Each reply is the objection's own line with the ground it refuses replaced by
what the reply offers instead. Adding a premise could never block a valid
argument; taking away the ground it needed is what a reply actually does. -/

/-- The classical answer to self-refutation: scripture does teach the
principle. -/
def selfRefutationUnderClassicalAnswer : Line Claim :=
  selfRefutationLine.onGrounds
    [p .onlyScripturalDoctrineIsBinding, p .solaScripturaIsTaughtByScripture]

/-- The final-arbiter answer: the bindingness rule governs first-order doctrine,
not a claim about where binding doctrine comes from. -/
def selfRefutationUnderFinalArbiter : Line Claim :=
  selfRefutationLine.onGrounds
    [ p .bindingnessAppliesToFirstOrderDoctrineOnly
    , notP .solaScripturaIsTaughtByScripture ]

/-- Kruger's parity reply: the canon's reception is conceded, and what the
objection needed — that identifying it requires an *infallible* authority — is
replaced by the observation that the rival's authority is self-authenticating
too. -/
def canonUnderParity : Line Claim :=
  canonObjectionLine.onGrounds
    [p .canonKnownThroughChurchReception, p .rivalAuthorityIsAlsoSelfAuthenticating]

/-- Mathison's parity reply: choosing Rome is itself an act of private
judgement, so private judgement does not separate the positions. -/
def regressUnderParity : Line Claim :=
  interpretiveRegressLine.onGrounds
    [p .traditionHasMinisterialAuthority, p .choosingAnAuthorityIsItselfPrivateJudgment]

/-! ### Geisler's charge as an argument, and the replies to it

The cycle results above are a formal fact: a cycle of implications grounds
neither end. The line below is the *dialectical* fact — Geisler charging
circularity, and what answers the charge. They are different claims, and both
are worth having.

Every reply denies the second leg, that scripture's clear sense is unobtainable
without the consensus. Barrett's is the exception: it concedes the circle and
denies that circularity is a defect peculiar to Tradition I, which is why
`circleDefeatsLine` carries the universality claim as a ground of its own. -/

/-- Both legs together make the reasoning circular. -/
def circleStep : Formula Claim :=
  .imp (conjOf
        [ p .creedalConsensusRestsOnPerspicuity
        , p .perspicuityRequiresCreedalConsensus ])
       (p .traditionIReasoningIsCircular)

/-- Circularity defeats the position **if** it is not a feature of every appeal
to an ultimate authority. Geisler's charge needs the second conjunct, and it is
what Barrett denies. -/
def circularityDefeats : Formula Claim :=
  .imp (conjOf
        [ p .traditionIReasoningIsCircular
        , notP .everyUltimateAuthorityIsCircular ])
       (p .circularityDefeatsTraditionI)

/-- **Geisler's circularity charge.** -/
def geislerCircleLine : Line Claim :=
  { name := "Geisler's circularity charge against Tradition I"
  , grounds :=
      [ p .creedalConsensusRestsOnPerspicuity
      , p .perspicuityRequiresCreedalConsensus ]
  , step := circleStep
  , delivers := p .traditionIReasoningIsCircular }

/-- The charge pressed home: the circularity defeats the position. -/
def circleDefeatsLine : Line Claim :=
  { name := "The circularity defeats Tradition I"
  , grounds :=
      [ p .traditionIReasoningIsCircular
      , notP .everyUltimateAuthorityIsCircular ]
  , step := circularityDefeats
  , delivers := p .circularityDefeatsTraditionI }

/-- **Allen and Swain's reply.** The consensus is established by and
accountable to scripture, so it is a product of reading scripture rather than a
precondition of it. -/
def circleUnderAccountability : Line Claim :=
  geislerCircleLine.onGrounds
    [ p .creedalConsensusRestsOnPerspicuity
    , p .creedalConsensusIsDerivedFromScripture ]

/-- **The proposed reply.** Scripture itself bounds the interpretive office —
elders commended to the word (Acts 20:32), required to hold to it (Titus 1:9),
forbidden to domineer (1 Peter 5:2–3) — so the consensus's own warrant is read
off scripture, and perspicuity is in any case claimed only for what is
necessary for salvation. -/
def circleUnderScripturalBounding : Line Claim :=
  geislerCircleLine.onGrounds
    [ p .creedalConsensusRestsOnPerspicuity
    , p .scriptureBoundsTheInterpretiveOffice
    , p .perspicuityIsLimitedToSalvationEssentials ]

/-- **Barrett's parity reply.** The circle is conceded; what is denied is that
it is peculiar to this position. -/
def defeatUnderParity : Line Claim :=
  circleDefeatsLine.onGrounds
    [ p .traditionIReasoningIsCircular
    , p .everyUltimateAuthorityIsCircular ]

/-! ### Shared grounds and closing steps -/

/-- What the Protestant packages rest on beyond any single line: the prooftexts
that belong to no strand, the shared datum of 2 Thessalonians 2:15, and the
commitments of the final-arbiter reading. -/
def sharedGrounds : List (Formula Claim) :=
  [ p .mark7TraditionCanNullify, p .acts17BereansTested
  , p .thessalonians2_15TraditionBinding
  , p .doctrineDevelopsWithoutNewRevelation
  , p .traditionHasMinisterialAuthority
  , p .practiceNeitherCommandedNorForbiddenIsPermitted
  , p .bindingnessAppliesToFirstOrderDoctrineOnly ]

end Testimony.Arguments.SolaScriptura
