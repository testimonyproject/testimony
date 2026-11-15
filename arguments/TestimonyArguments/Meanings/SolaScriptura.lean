import Testimony.Semantics.Meaning
import TestimonyArguments.SolaScriptura.Sources

/-!
# TestimonyArguments.Meanings.SolaScriptura — what each sola scriptura claim says

**Thirty of the forty claims have meanings** (`coverage_now`), and with them
fourteen of the argument's twenty lines of reason can be read as moves, all of
whose claims say something the checks can see: the eliminative line, both of
Mark 7's lines, Geisler's Tradition 0, Trent, Vatican I, the Orthodox line, the
canon objection and Kruger's reply, the interpretive-authority regress and
Mathison's reply, and Geisler's circularity charge with both replies to it.
`TestimonyArguments.Meanings.SolaFide` is the fuller worked example of the same
work.

## The texts, in their own words

Each passage is given what it says, not what it is taken to teach, and the
words that carry a reading are kept as the text has them.

- **2 Timothy 3:16** says that "all scripture" (πᾶσα γραφή) is God-breathed
  (θεόπνευστος) and profitable (ὠφέλιμος). **3:17** finishes the sentence:
  scripture is profitable so that the man of God may be "complete, equipped
  for every good work". The meaning says that scripture is the means to that
  equipping. It does not say that scripture is the only means, or that it
  suffices; that is the sufficiency claim the classical line draws from it, a
  separate claim with its own citation.
- **Mark 7:1–13** says that the tradition of the elders, Corban above all, is
  commandments of men ("the tradition of men", 7:8), and that it makes void
  "the word of God" (7:13). The tradition is a particular the text names, not a
  concept of the library's, and "the word of God" is the text's phrase, not the
  concept each party fills differently.
- **Acts 17:11** says that the Jews of Berea examined the Scriptures daily to
  see whether what Paul said was so. That they took Scripture as the measure of
  apostolic preaching is the atom's gloss, and the meaning leaves it out.
- **2 Thessalonians 2:15** says that the traditions (παραδόσεις) are to be held
  as what the apostles taught, and that they were taught by spoken word and by
  letter.

## What the doctrinal claims say

Sufficiency is that Scripture is a rule of faith and suffices for essential
doctrine, what must be known, believed and observed for salvation; perspicuity,
that Scripture's clear sense takes in that doctrine. Geisler's method claim is
that the historical-grammatical method suffices for essential doctrine and the
creedal consensus is not necessary for it; Tradition 0's creeds help in
understanding Scripture and are not a rule of faith. Mathison's claim is that
the consensus is necessary for understanding Scripture at all. Tradition I's
ministerial authority is real authority, and not infallible. Trent, read as
Tradition II, makes tradition and Scripture both sources of revelation, with
Scripture not the measure of tradition. The magisterium and the mind of the
Church are each said to be an infallible interpreter of Scripture. The canon
objection says that the canon is identified by means of the Church's reception,
and that an infallible authority is necessary to identify it. Cross and
Judisch's premise is that the individual settles questions of faith finally,
and is the one who chooses which body to submit to; Mathison answers that
choosing is itself private judgement. Geisler charges that Tradition I's
reasoning is a circular argument, and Barrett answers that every appeal to an
ultimate authority is one. The premise Mark 7's case needs, that no apostolic
word survives outside Scripture, says that the apostles' teaching as it survives
today is part of Scripture.

## What is left unanalysed, and why

Ten claims keep their citations' labels.

- **"Scripture itself teaches sola scriptura"**, and **"a doctrine is binding
  only if Scripture teaches it"**, name no passage. The grammar says what a
  passage teaches (`Statement.teaches`), and Scripture as a whole is not a
  passage. Written as simply held, the first would be the conclusion itself,
  that Scripture is the sole infallible rule, when whether Scripture teaches
  that is the point the self-refutation objection disputes. So the classical
  line and the three self-refutation lines are not read.
- **"The circularity defeats Tradition I"** needs a relation of one argument's
  defeating a position, which the vocabulary does not have. Read as "the
  reasoning does not ground the position" it would say less than Geisler's
  charge, which is that the position must be given up. So the two lines that
  press the charge home are not read.
- **The scope of the bindingness rule, adiaphora (practices neither commanded
  nor forbidden), the development of doctrine
  and what authenticates it, Kruger's self-authenticating rival, Scripture's
  bounding of the interpretive office, and perspicuity's being claimed only for
  what is necessary for salvation** are claims no line's step reads, and each
  needs vocabulary (a claim's scope, permission, growth in understanding,
  self-authentication, an office) that would be added for one claim. The last
  is a claim about the scope of another claim; stating it as doctrine would
  make it assert perspicuity, a join its wording does not make.

## What is joined, and what is not

The meanings join three pairs, and no more (`joins`). A pair is joined only
where the claims' own wording joins them.

- **Mark 7's principle excludes binding a commandment of men as God's word.**
  The principle, as *Dei Verbum* 10 grants it and the atom states it, says that
  no commandment of men may be taught as God's word; the other claim says one
  may rightly be bound so.
- **"Scripture is the sole infallible rule" asserts that Scripture is
  infallible and that no other rule is.** That is what *sole* means, and the
  eliminative line argues the converse as a step.

Five pairs are left apart, on purpose.

- Allen and Swain's account of the creedal consensus — "a product of reading"
  Scripture, "not a precondition of it" — and the second leg of Geisler's
  circle, that Scripture's clear sense is not obtainable without the consensus.
  The library holds that their reply *refuses* the leg rather than denying it
  (`TestimonyArguments.SolaScriptura.accountability_refuses_rather_than_denies`):
  a precondition of reading Scripture is not the same claim as a condition of
  its clear sense. Joining them would overturn that judgment without an
  argument, and `Testimony.Checks.Postulates` fails the build when a join
  does.

- Geisler's "the historical-grammatical method alone suffices … on essential
  doctrine" and Mathison's "the creedal consensus is hermeneutically necessary
  for understanding scripture" are each other's targets, but their scopes
  differ: essential doctrine, and Scripture's sense at large. Whether the one
  necessity reaches the other's scope is Mathison's to say, not the meanings'.
  So Geisler's meaning denies that the consensus is necessary for essential
  doctrine, Mathison's asserts that it is necessary for understanding
  Scripture, and the two do not meet. For the same reason Mathison's claim is
  kept apart from the circle's second leg: understanding Scripture is not
  Scripture's clear sense.
- Tradition II says that Scripture is not the measure of tradition; Mark 7's
  principle, that God's word is. Rome holds both, because for Rome the word of
  God is Scripture and the apostolic Tradition together, so the principle's
  "word of God" is not the coordinate source's "Scripture", and the meanings
  keep the two terms apart (`trent_grants_marks_principle`).
- That tradition is a coordinate source of revelation does not, by its
  wording, say that an apostolic word survives outside Scripture. The library
  reads Trent both ways (`TestimonyArguments.SolaScriptura.whatTrentsTraditionIs`).
- That the magisterium, or the mind of the Church, interprets Scripture
  infallibly does not, by its wording, make it a *rule of faith*. Whether an
  infallible interpreter is a second infallible rule is the dispute itself, and
  it is a rated step (`magisterialDeniesSoleRule`, `orthodoxDeniesSoleRule`).
-/

namespace TestimonyArguments.Meanings.SolaScriptura

open Testimony

open Testimony.Semantics Testimony.Semantics.Notation
open TestimonyArguments.SolaScriptura (Claim cite)

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

/-- 2 Timothy 3:16. -/
@[nolint defsWithUnderscore] abbrev tim3_16 : PassageRange := vs .secondTimothy 3 16
/-- 2 Timothy 3:17. -/
@[nolint defsWithUnderscore] abbrev tim3_17 : PassageRange := vs .secondTimothy 3 17
/-- 2 Timothy 3:16–17: the sentence 3:17 completes. -/
@[nolint defsWithUnderscore] abbrev tim3_16_17 : PassageRange := rg .secondTimothy 3 16 3 17
/-- Mark 7:1–13. -/
@[nolint defsWithUnderscore] abbrev mark7_1_13 : PassageRange := rg .mark 7 1 7 13
/-- Mark 7:13. -/
@[nolint defsWithUnderscore] abbrev mark7_13 : PassageRange := vs .mark 7 13
/-- Acts 17:11. -/
@[nolint defsWithUnderscore] abbrev acts17_11 : PassageRange := vs .acts 17 11
/-- 2 Thessalonians 2:15. -/
@[nolint defsWithUnderscore] abbrev thess2_15 : PassageRange := vs .secondThessalonians 2 15

/-- "All scripture", the words of 2 Timothy 3:16. -/
abbrev allScripture : Term := wd .graphe tim3_16

/-- The tradition Mark 7 names: the elders' tradition, Corban above all. -/
abbrev eldersTradition : Term :=
  pt "the tradition of the elders, Corban above all (Mark 7:3–13)" .informationObject

/-- The traditions of 2 Thessalonians 2:15, in its own word. -/
abbrev theTraditions : Term := wd .paradosis thess2_15

/-- Tradition I's reasoning about Scripture and the creedal consensus, as
Mathison states it and Geisler charges it. -/
abbrev traditionIReasoning : Term :=
  pt "Tradition I's reasoning on Scripture and the creedal consensus" .informationObject

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

/-- **What each sola scriptura atom asserts.** Thirty are analysed; the rest
keep their citations' labels, marked unanalysed, for the reasons the module
docstring gives. -/
def means : Claim → Statement
  | .timothy3_16GodBreathed =>
    .says tim3_16 <| .both (rl .isA allScripture (wd .theopneustos tim3_16))
      (rl .isA allScripture (wd .ophelimos tim3_16))
  | .timothy3_17ThoroughlyEquips =>
    .says tim3_16_17 (rl .instrumentOf allScripture (wd .equippedForEveryGoodWork tim3_17))
  | .mark7TraditionCanNullify =>
    .says mark7_1_13 <| .both (rl .isA eldersTradition (cn .commandmentsOfMen))
      (rl .voids eldersTradition (wd .logosTouTheou mark7_13))
  | .acts17BereansTested =>
    .says acts17_11 <| rl .agentOf (pt "the Jews of Berea" .agent)
      (pt "examining the Scriptures daily, to see whether what Paul said was so" .event)
  | .thessalonians2_15TraditionBinding =>
    .says thess2_15 <|
      .both (rl .bindsAs theTraditions
          (pt "what the apostles taught the Thessalonians" .informationObject)) <|
        .both (rl .saidBy (pt "the apostles' spoken word to the Thessalonians" .event)
            theTraditions)
          (rl .saidBy (pt "the apostles' letter to the Thessalonians" .informationObject)
            theTraditions)
  | .scriptureIsInfallible => scriptureInfallible
  | .scriptureIsSufficient =>
    .holds <| .both (rl .isA (cn .scripture) (cn .ruleOfFaith))
      (rl .sufficientFor (cn .scripture) (cn .essentialDoctrine))
  | .scriptureIsPerspicuous =>
    .holds (rl .includes (cn .clearSenseOfScripture) (cn .essentialDoctrine))
  | .noOtherRuleIsInfallible => noOtherInfallible
  | .scriptureIsSoleInfallibleRule =>
    .also scriptureInfallible <|
      .also (.holds (rl .isA (cn .scripture) (cn .ruleOfFaith))) noOtherInfallible
  | .traditionIsCoordinateSourceOfRevelation =>
    .holds <| .both (rl .isA (cn .tradition) (cn .sourceOfRevelation)) <|
      .both (rl .isA (cn .scripture) (cn .sourceOfRevelation))
        (.not (rl .judges (cn .scripture) (cn .tradition)))
  | .magisteriumIsInfallible => .holds (rl .isA (cn .magisterium) (cn .infallibleInterpreter))
  | .churchMindIsInfallibleInterpreter =>
    .holds (rl .isA (cn .mindOfTheChurch) (cn .infallibleInterpreter))
  | .canonKnownThroughChurchReception =>
    .holds (rl .instrumentOf (cn .receptionOfTheCanon) (cn .identifyingTheCanon))
  | .identifyingCanonRequiresInfallibleAuthority =>
    .holds (rl .necessaryFor (cn .infallibleAuthority) (cn .identifyingTheCanon))
  | .traditionHasMinisterialAuthority =>
    .holds <| .both (rl .isA (cn .tradition) (cn .ministerialAuthority))
      (.not (rl .isA (cn .tradition) (cn .infallible)))
  | .traditionIDiffersInPrincipleFromTradition0 =>
    .holds <| rl .distinctFrom
      (pt "Tradition I's principle of authority" .informationObject)
      (pt "Tradition 0's principle of authority" .informationObject)
  | .individualRetainsUltimateInterpretiveAuthority =>
    .holds <| .both (rl .settles (cn .individualBeliever) (cn .controversiesOfReligion))
      (rl .agentOf (cn .individualBeliever) (cn .choosingAnAuthority))
  | .choosingAnAuthorityIsItselfPrivateJudgment =>
    .holds (rl .isA (cn .choosingAnAuthority) (cn .privateJudgment))
  | .creedsAreInformativeNotNormative =>
    .holds <| .both (rl .instrumentOf (cn .creedalConsensus) (cn .understandingScripture))
      (.not (rl .isA (cn .creedalConsensus) (cn .ruleOfFaith)))
  | .historicalGrammaticalMethodSuffices =>
    .holds <| .both (rl .sufficientFor (cn .historicalGrammaticalMethod) (cn .essentialDoctrine))
      (.not (rl .necessaryFor (cn .creedalConsensus) (cn .essentialDoctrine)))
  | .creedalConsensusIsHermeneuticallyNecessary =>
    .holds (rl .necessaryFor (cn .creedalConsensus) (cn .understandingScripture))
  | .creedalConsensusRestsOnPerspicuity =>
    .holds (rl .groundOf (cn .clearSenseOfScripture) (cn .creedalConsensus))
  | .perspicuityRequiresCreedalConsensus => consensusPrecedesClearSense
  | .traditionIReasoningIsCircular => .holds (rl .isA traditionIReasoning (cn .circularArgument))
  | .everyUltimateAuthorityIsCircular =>
    .holds (rl .isA (cn .appealToUltimateAuthority) (cn .circularArgument))
  | .creedalConsensusIsDerivedFromScripture =>
    .also (.holds (rl .groundOf (cn .scripture) (cn .creedalConsensus)))
      consensusNotPreconditionOfReading
  | .godsWordJudgesTradition =>
    .also (.holds (rl .judges (cn .wordOfGod) (cn .tradition)))
      (.denied mensCommandmentAsGodsWord)
  | .mensCommandmentBindsAsGodsWord => mensCommandmentAsGodsWord
  | .noApostolicWordOutsideScripture =>
    .holds (rl .partOf (cn .survivingApostolicTeaching) (cn .scripture))
  | a => .opaque (cite a).label

/-- What each atom of the argument says. -/
instance meanings : HasMeanings Claim :=
  { argument := "Sola scriptura", all, complete := all_complete, means }

/-- **Thirty of the 40 atoms are analysed**: the texts, in their own words, and
every claim a line's step reads except the three the module docstring names. -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (30, 40) := by decide

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
    [ (.godsWordJudgesTradition, .mensCommandmentBindsAsGodsWord) ]
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
      [ p .godsWordJudgesTradition ➝ notP .mensCommandmentBindsAsGodsWord
      , p .scriptureIsSoleInfallibleRule ➝ p .scriptureIsInfallible
      , p .scriptureIsSoleInfallibleRule ➝ p .noOtherRuleIsInfallible ] :=
  rfl

attribute [solaScripturaDefs] Testimony.Logic.ArgumentPackage.held

end TestimonyArguments.Meanings.SolaScriptura
