import Testimony.Semantics.Meaning
import Testimony.Arguments.SolaScriptura.Sources

/-!
# Testimony.Meanings.SolaScriptura — what each sola scriptura claim says

**Partly analysed.** Seven claims have meanings: the five whose meanings join
them to another claim, so that the logic holds what they say about each other
(`joins`), and the two of Geisler's circle whose join was weighed and refused.
The rest are registered with their citations' labels and marked unanalysed, so
the argument is counted from the start (`coverage_now`);
`Testimony.Meanings.SolaFide` is the fuller worked example.

## What is joined, and what is not

A pair is joined only where the claims' own wording joins them.

- **Mark 7's principle excludes binding a commandment of men as God's word.**
  The principle, as *Dei Verbum* 10 grants it and the atom states it, says that
  no commandment of men may be taught as God's word; the other claim says one
  may rightly be bound so.
- **"Scripture is the sole infallible rule" asserts that Scripture is
  infallible and that no other rule is.** That is what *sole* means, and the
  eliminative line argues the converse as a step.

Four pairs are left apart, on purpose.

- Allen and Swain's account of the creedal consensus — "a product of reading"
  Scripture, "not a precondition of it" — and the second leg of Geisler's
  circle, that Scripture's clear sense is not obtainable without the consensus.
  The library holds that their reply *refuses* the leg rather than denying it
  (`Testimony.Arguments.SolaScriptura.accountability_refuses_rather_than_denies`):
  a precondition of reading Scripture is not the same claim as a condition of
  its clear sense. Joining them would overturn that judgment without an
  argument, and `Testimony.Checks.Postulates` fails the build when a join
  does.

- Geisler's "the historical-grammatical method alone suffices … on essential
  doctrine" and Mathison's "the creedal consensus is hermeneutically necessary
  for understanding scripture" are each other's targets, but their scopes
  differ: essential doctrine, and Scripture's sense at large. Whether the one
  necessity reaches the other's scope is Mathison's to say, not the meanings'.
- That tradition is a coordinate source of revelation does not, by its
  wording, say that an apostolic word survives outside Scripture. The library
  reads Trent both ways (`Testimony.Arguments.SolaScriptura.whatTrentsTraditionIs`).
- That the magisterium, or the mind of the Church, interprets Scripture
  infallibly does not, by its wording, make it a *rule of faith*. Whether an
  infallible interpreter is a second infallible rule is the dispute itself, and
  it is a rated step (`magisterialDeniesSoleRule`, `orthodoxDeniesSoleRule`).
-/

namespace Testimony.Meanings.SolaScriptura

open Testimony.Semantics Testimony.Semantics.Notation
open Testimony.Arguments.SolaScriptura (Claim cite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .timothy3_16GodBreathed, .timothy3_17ThoroughlyEquips, .mark7TraditionCanNullify
  , .acts17BereansTested, .thessalonians2_15TraditionBinding, .scriptureIsInfallible
  , .scriptureIsSufficient, .scriptureIsPerspicuous, .scriptureIsSoleInfallibleRule
  , .solaScripturaIsTaughtByScripture, .onlyScripturalDoctrineIsBinding, .noOtherRuleIsInfallible
  , .traditionIsCoordinateSourceOfRevelation, .magisteriumIsInfallible
  , .churchMindIsInfallibleInterpreter, .canonKnownThroughChurchReception
  , .identifyingCanonRequiresInfallibleAuthority, .rivalAuthorityIsAlsoSelfAuthenticating
  , .traditionHasMinisterialAuthority, .traditionIDiffersInPrincipleFromTradition0
  , .individualRetainsUltimateInterpretiveAuthority, .choosingAnAuthorityIsItselfPrivateJudgment
  , .bindingnessAppliesToFirstOrderDoctrineOnly, .practiceNeitherCommandedNorForbiddenIsPermitted
  , .creedsAreInformativeNotNormative, .historicalGrammaticalMethodSuffices
  , .creedalConsensusIsHermeneuticallyNecessary, .doctrineDevelopsWithoutNewRevelation
  , .developmentIsAuthenticatedByTheChurch, .creedalConsensusRestsOnPerspicuity
  , .perspicuityRequiresCreedalConsensus, .traditionIReasoningIsCircular
  , .circularityDefeatsTraditionI, .everyUltimateAuthorityIsCircular
  , .creedalConsensusIsDerivedFromScripture, .scriptureBoundsTheInterpretiveOffice
  , .perspicuityIsLimitedToSalvationEssentials, .godsWordJudgesTradition
  , .mensCommandmentBindsAsGodsWord, .noApostolicWordOutsideScripture ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- Scripture is infallible. -/
abbrev scriptureInfallible : Statement := .holds (rl .isA (cn .scripture) (cn .infallible))

/-- No candidate rule of faith other than Scripture is infallible. -/
abbrev noOtherInfallible : Statement :=
  .holds (.not (rl .isA (cn .otherRuleOfFaith) (cn .infallible)))

/-- A commandment of men may rightly be bound on the Church as God's word. -/
abbrev mensCommandmentAsGodsWord : Statement :=
  .holds (rl .bindsAs (cn .commandmentsOfMen) (cn .wordOfGod))

/-- Scripture's clear sense is not obtainable without the creedal consensus. -/
abbrev consensusPrecedesClearSense : Statement :=
  .holds (rl .necessaryFor (cn .creedalConsensus) (cn .clearSenseOfScripture))

/-- The creedal consensus is not a precondition of reading Scripture. Not the
denial of `consensusPrecedesClearSense`: reading Scripture is one thing, its
clear sense another (`accountability_refuses_rather_than_denies`). -/
abbrev consensusNotPreconditionOfReading : Statement :=
  .holds (.not (rl .precedes (cn .creedalConsensus) (cn .readingScripture)))

/-- **What each sola scriptura atom asserts.** Seven are analysed; the rest
keep their citations' labels, marked unanalysed. -/
def means : Claim → Statement
  | .scriptureIsInfallible => scriptureInfallible
  | .noOtherRuleIsInfallible => noOtherInfallible
  | .scriptureIsSoleInfallibleRule =>
    .also scriptureInfallible <|
      .also (.holds (rl .isA (cn .scripture) (cn .ruleOfFaith))) noOtherInfallible
  | .godsWordJudgesTradition =>
    .also (.holds (rl .judges (cn .wordOfGod) (cn .tradition)))
      (.denied mensCommandmentAsGodsWord)
  | .mensCommandmentBindsAsGodsWord => mensCommandmentAsGodsWord
  | .perspicuityRequiresCreedalConsensus => consensusPrecedesClearSense
  | .creedalConsensusIsDerivedFromScripture =>
    .also (.holds (rl .groundOf (cn .scripture) (cn .creedalConsensus)))
      consensusNotPreconditionOfReading
  | a => .opaque (cite a).label

/-- What each atom of the argument says. -/
instance meanings : HasMeanings Claim :=
  { argument := "Sola scriptura", all, complete := all_complete, means }

/-- **Seven of the 40 atoms are analysed**: the ones whose meanings join them to
another claim. -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (7, 40) := by decide

/-- **The sola scriptura joins**: each pair of claims whose meanings exclude or
entail one another, listed, and proved to be exactly what the meanings contain.
Every credibility check and every dispute over the argument holds `a → ¬b` for
each exclusion and `a → b` for each entailment.

- That a commandment of men may be bound as God's word is excluded by Mark 7's
  principle.
- That Scripture is the sole infallible rule entails that it is infallible, and
  that no other rule is. -/
instance joins : HasJoins Claim where
  exclusions :=
    [ (.mensCommandmentBindsAsGodsWord, .godsWordJudgesTradition) ]
  exclusions_pinned := by decide +kernel
  entailments :=
    [ (.scriptureIsSoleInfallibleRule, .scriptureIsInfallible)
    , (.scriptureIsSoleInfallibleRule, .noOtherRuleIsInfallible) ]
  entailments_pinned := by decide +kernel

open Testimony.Logic in
/-- **The postulates, written out**: `a → ¬b` for each exclusion, `a → b` for
each entailment. Proofs over the argument's packages unfold to this list, so a
named reading must satisfy it. -/
@[solaScripturaDefs] theorem postulates_eq :
    (HasPostulates.postulates : List (Formula Claim)) =
      [ p .mensCommandmentBindsAsGodsWord ➝ notP .godsWordJudgesTradition
      , p .scriptureIsSoleInfallibleRule ➝ p .scriptureIsInfallible
      , p .scriptureIsSoleInfallibleRule ➝ p .noOtherRuleIsInfallible ] :=
  rfl

attribute [solaScripturaDefs] Testimony.Logic.ArgumentPackage.held

end Testimony.Meanings.SolaScriptura
