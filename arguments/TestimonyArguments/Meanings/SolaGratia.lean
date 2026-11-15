import Testimony.Semantics.Meaning
import TestimonyArguments.SolaGratia.Sources

/-!
# TestimonyArguments.Meanings.SolaGratia — what each sola gratia claim says

**Partly analysed.** Eight claims have meanings: the ones the dispute turns on,
each written in the vocabulary's terms so that the logic holds what they say
about each other. The rest are registered with their citations' labels and
marked unanalysed, so the argument is counted from the start (`coverage_now`).

## What is joined, and what is not

A pair is joined only where the claims' own wording joins them.

- **"The grace that saves brings about the consent it seeks" and "the grace
  that saves can be finally refused" exclude each other.** The first says that
  grace brings about the act of believing, so that it does not fail to follow;
  the second denies exactly that. Every dispute over this argument holds the
  exclusion as a postulate, so no position can hold both.

Three pairs are left apart, on purpose, and the vocabulary says why.

- **That the will is passive in regeneration, and Trent's claim that the will
  cooperates by assenting.** They look like contraries, and Trent's canon 4
  condemns the "merely passive". But the passivity the Reformed and the
  Lutherans claim is in *regeneration*, being made alive; the cooperation Trent
  claims is in the will's "disposing and preparing itself" for justification.
  Those are two concepts, an event and a process, and the meanings keep them
  apart. Whether Trent's preparation comes before the new life or after it is
  the dispute, and it is a rated step (`cooperationStep`), not a postulate.
- **That conversion is God's work alone, and that the grace which does it cannot
  be refused.** God's being the one who regenerates is a claim about who acts
  in regeneration; grace's bringing about the act of believing is a claim about
  what follows. The Lutherans hold the first and deny the second. Joining them
  would make the Formula of Concord contradict itself by definition, and the
  step between them is rated `disputed` (`effectualStep`).
- **That God gives the ability to believe, and either kind of help.** The
  ability is a quality a person has; whether the grace that gives it also
  brings about the act is what the dilemma over the third way asks
  (`whatTheAbilityIs`). Joining the ability to either answer would settle that
  dilemma before it is heard.
-/

namespace TestimonyArguments.Meanings.SolaGratia

open Testimony

open Testimony.Semantics Testimony.Semantics.Notation
open TestimonyArguments.SolaGratia (Claim baseCite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .ephesians2_1to5, .ephesians2_8to9, .romans9_16, .romans11_6, .acts7_51
  , .ephesians4_30, .thessalonians5_19, .matthew12_31to32, .genesis2_16to17
  , .theSpiritIsResisted, .grievingCanLoseTheSpirit, .blasphemyIsFinalRefusalOfGrace
  , .savingGraceCanBeFinallyRefused, .abilityToBelieveIsGiven, .faithAloneReceivesGrace
  , .zechariah1_3WithLamentations5_21, .toutoRefersToTheWhole, .romans9_16ConcernsSalvation
  , .faithIsGodsGift, .acts7_51ResistsSavingGrace, .freeWillCooperatesByAssenting
  , .freeWillCanDissent, .conversionIsGodsWorkAlone, .salvationIsByGrace
  , .graceIsEffectualOfItself, .willIsPassiveInRegeneration ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- Grace brings about the act of believing, so that it does not fail to follow.
-/
abbrev graceEffectsBelieving : Content := rl .effects (cn .grace) (cn .actOfBelieving)

/-- **What each sola gratia atom asserts.** Eight are analysed; the rest keep
their citations' labels, marked unanalysed. -/
def means : Claim → Statement
  | .graceIsEffectualOfItself => .holds graceEffectsBelieving
  | .savingGraceCanBeFinallyRefused => .holds (.not graceEffectsBelieving)
  | .willIsPassiveInRegeneration => .holds (.not (rl .agentOf (cn .will) (cn .regeneration)))
  | .freeWillCooperatesByAssenting =>
    .holds (rl .agentOf (cn .will) (cn .preparationForJustification))
  | .conversionIsGodsWorkAlone => .holds (rl .agentOf (cn .god) (cn .regeneration))
  | .abilityToBelieveIsGiven => .holds (rl .groundOf (cn .grace) (cn .abilityToBelieve))
  | .faithAloneReceivesGrace => .holds (rl .soleInstrumentOf (cn .faith) (cn .grace))
  | .salvationIsByGrace => .holds (rl .groundOf (cn .grace) (cn .salvation))
  | a => .opaque (baseCite a).label

/-- What each atom of the argument says. -/
instance meanings : HasMeanings Claim :=
  { argument := "Sola gratia — Ephesians 2:8–9 and Romans 9:16", all
  , complete := all_complete, means }

/-- **Eight of the 26 atoms are analysed**: the ones the dispute turns on. -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (8, 26) := by decide

/-- **The sola gratia joins**: each pair of claims whose meanings exclude or
entail one another, listed, and proved to be exactly what the meanings contain.
Every dispute over the argument holds `a → ¬b` for each exclusion.

- That the grace which saves can be finally refused excludes its bringing about
  the act of believing. -/
instance joins : HasJoins Claim where
  exclusions := [(.savingGraceCanBeFinallyRefused, .graceIsEffectualOfItself)]
  exclusions_pinned := by decide +kernel
  entailments := []
  entailments_pinned := by decide +kernel

open Testimony.Logic in
/-- **The postulates, written out**: `a → ¬b` for the one exclusion. Proofs over
the argument's packages unfold to this list, so a named reading must satisfy it.
-/
@[solaGratiaDefs] theorem postulates_eq :
    (HasPostulates.postulates : List (Formula Claim)) =
      [p .savingGraceCanBeFinallyRefused ➝ notP .graceIsEffectualOfItself] :=
  rfl

attribute [solaGratiaDefs] Testimony.Logic.ArgumentPackage.held

end TestimonyArguments.Meanings.SolaGratia
