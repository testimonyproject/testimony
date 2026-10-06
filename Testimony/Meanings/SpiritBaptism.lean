import Testimony.Semantics.Meaning
import Testimony.Arguments.SpiritBaptism.Sources

/-!
# Testimony.Meanings.SpiritBaptism — what each Spirit baptism claim says

**Partly analysed.** Two claims have meanings: the readings of 1 Corinthians
12:13, whose meanings join them (`joins`). The rest are registered with their
citations' labels and marked unanalysed, so the argument is counted from the
start (`coverage_now`); `Testimony.Meanings.SolaFide` is the fuller worked
example.

## What is joined, and what is not

A pair is joined only where the claims' own wording joins them.

- **The Assemblies of God's reading of 1 Corinthians 12:13 excludes Dunn's
  and Stott's.** The Pentecostal reading says, in its own words, that the verse
  is baptism *by* the Spirit into the body, "not Christ baptizing in the
  Spirit"; the conversion reading says it is Christ baptizing in the Spirit.

Three pairs are left apart, on purpose.

- That Luke's narratives are a pattern for believers today, and Stott's "not a
  pattern". The words contradict, but the library keeps them apart by design:
  the Pentecostal view with the narratives read as transitions is a fair horn of
  `whatTheActsNarrativesAre` "only because the encoding does not make 'pattern'
  and 'transitions' exclude each other; the break comes from Stott's step"
  (`Testimony.Arguments.SpiritBaptism.pentecostalOnTransitions_is_satisfiable`).
  Joining them would overturn that choice without an argument.
- That every believer is baptized in the Spirit at conversion, and that a
  second baptism in the Spirit is to be sought. The first does not say *only*;
  the step from it to the denial is the conversion view's, and is rated.
- That the Spirit is given in the sacraments, "not in a second baptism beyond
  the sacraments", and that a baptism in the Spirit after conversion is to be
  sought. Confirmation is itself after conversion, so the words do not meet.
-/

namespace Testimony.Meanings.SpiritBaptism

open Testimony.Semantics Testimony.Semantics.Notation
open Testimony.Arguments.SpiritBaptism (Claim cite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .cor12_13AllBaptizedInOneSpirit, .actsSpiritAfterBelieving, .acts10SpiritAsTheyHear
  , .acts2_38SpiritPromised, .cor12_13IsChristBaptizingInTheSpirit, .cor12_13IsBaptismByTheSpirit
  , .lukanSpiritBaptismIsEmpowerment, .actsNarrativesAreNormative, .actsEpisodesAreTransitions
  , .entireSanctificationIsSecondWork, .spiritGivenInWaterBaptism, .confirmationGivesPentecost
  , .spiritBaptismAtConversion, .secondSpiritBaptismToBeSought, .spiritGivenInTheSacraments ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- 1 Corinthians 12:13. -/
@[nolint defsWithUnderscore] abbrev cor12_13 : Testimony.PassageRange := vs .firstCorinthians 12 13

/-- 1 Corinthians 12:13, read rightly, is Christ baptizing in the Spirit. -/
abbrev christBaptizesInTheSpirit : Statement :=
  .teaches cor12_13 (rl .isA (cn .baptism) (cn .christBaptizingInTheSpirit))

/-- **What each Spirit baptism atom asserts.** Two are analysed; the rest keep
their citations' labels, marked unanalysed. -/
def means : Claim → Statement
  | .cor12_13IsChristBaptizingInTheSpirit => christBaptizesInTheSpirit
  | .cor12_13IsBaptismByTheSpirit =>
    .also (.teaches cor12_13 (rl .isA (cn .baptism) (cn .spiritBaptizingIntoTheBody)))
      (.denied christBaptizesInTheSpirit)
  | a => .opaque (cite a).label

/-- What each atom of the argument says. -/
instance meanings : HasMeanings Claim :=
  { argument := "Spirit baptism", all, complete := all_complete, means }

/-- **Two of the 15 atoms are analysed**: the readings of 1 Corinthians 12:13. -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (2, 15) := by decide

/-- **The Spirit baptism joins**: the Assemblies of God's reading of 1
Corinthians 12:13 excludes Dunn's and Stott's, listed, and proved to be exactly
what the meanings contain. Every credibility check and every dispute over the
argument holds `a → ¬b` for it. -/
instance joins : HasJoins Claim where
  exclusions := [(.cor12_13IsChristBaptizingInTheSpirit, .cor12_13IsBaptismByTheSpirit)]
  exclusions_pinned := by decide +kernel
  entailments := []
  entailments_pinned := by decide +kernel

open Testimony.Logic in
/-- **The postulates, written out**: `a → ¬b` for the one exclusion. Proofs over
the argument's packages unfold to this list, so a named reading must satisfy
it. -/
@[spiritBaptismDefs] theorem postulates_eq :
    (HasPostulates.postulates : List (Formula Claim)) =
      [p .cor12_13IsChristBaptizingInTheSpirit ➝ notP .cor12_13IsBaptismByTheSpirit] :=
  rfl

attribute [spiritBaptismDefs] Testimony.Logic.ArgumentPackage.held

end Testimony.Meanings.SpiritBaptism
