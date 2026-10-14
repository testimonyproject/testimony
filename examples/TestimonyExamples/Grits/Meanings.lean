import Testimony.Semantics.Meaning
import TestimonyExamples.Grits.Sources

/-!
# TestimonyExamples.Grits.Meanings — what each claim says

Seven of the nine claims are about three particular occurrences, and are read
for what they say about them, in the library's vocabulary:

- **the time in the store**, from the boys' going in to the shot;
- **the making of Tipton's breakfast**;
- **the cooking of its eggs, and of its grits**.

Going in as breakfast began says the time in the store *starts with* the making
of breakfast, and the shot as it was ready says it *ends with* it. Five minutes
passed says the time in the store *lasts* five minutes; breakfast took five
minutes says its making does. Eggs and grits says the cooking of each is *part
of* making breakfast. Lengths are read to the precision the testimony speaks in:
"five minutes" and "twenty minutes" are two lengths of time.

The other two, that the grits were regular and that regular grits take twenty
minutes, are about a kind of grits, which the vocabulary has no word for. They
keep their citations' labels, marked unanalysed.

## What is joined, and why

One definition does all the work: **an occurrence lasts one length of time**
(`Testimony.Ontology.Time.oneLength`), which DOLCE and BFO both state. So the
making of breakfast cannot have taken both five minutes and twenty, nor the time
in the store have lasted both: two exclusions, found by reading the meanings
under the library's shared ontology, and pinned (`joins`).

## What is not joined, and why

That the time in the store starts and ends with the making of breakfast does
not, by what the words mean, make the two last the same: the reasoner reads
facts, not measures, and that step is Tipton's reckoning, cited and rated where
it is used. Nor does a part's lasting twenty minutes make its whole last at
least as long; the cross-examination states that as its step from the grits.
-/

namespace TestimonyExamples.Grits.Meanings

open Testimony.Semantics Testimony.Semantics.Notation
open TestimonyExamples.Grits (Claim cite)

/-- Every atom of the case, in declaration order. -/
def all : List Claim :=
  [ .enteredAsBreakfastBegan, .shotAsBreakfastWasReady, .breakfastTookFiveMinutes
  , .breakfastWasEggsAndGrits, .gritsWereRegular, .regularGritsTakeTwentyMinutes
  , .breakfastTookTwentyMinutes, .fiveMinutesPassed, .twentyMinutesPassed ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- The time in the store: from the boys' going in to the shot. -/
abbrev timeInTheStore : Term :=
  pt "the time from the boys' going into the store to the shot" .process

/-- The making of Tipton's breakfast, from its beginning to its being ready. -/
abbrev makingBreakfast : Term := pt "the making of Tipton's breakfast" .event

/-- The cooking of the breakfast's eggs. -/
abbrev cookingEggs : Term := pt "the cooking of Tipton's eggs" .process

/-- The cooking of the breakfast's grits. -/
abbrev cookingGrits : Term := pt "the cooking of Tipton's grits" .process

/-- **What each claim asserts.** Seven are analysed; the two about a kind of
grits keep their citations' labels, marked unanalysed. -/
def means : Claim → Statement
  | .enteredAsBreakfastBegan => .holds (rl .startsWith timeInTheStore makingBreakfast)
  | .shotAsBreakfastWasReady => .holds (rl .endsWith timeInTheStore makingBreakfast)
  | .breakfastTookFiveMinutes => .holds (rl .lasts makingBreakfast (cn (.minutes 5)))
  | .breakfastWasEggsAndGrits =>
    .also (.holds (rl .partOf cookingEggs makingBreakfast))
      (.holds (rl .partOf cookingGrits makingBreakfast))
  | .breakfastTookTwentyMinutes => .holds (rl .lasts makingBreakfast (cn (.minutes 20)))
  | .fiveMinutesPassed => .holds (rl .lasts timeInTheStore (cn (.minutes 5)))
  | .twentyMinutesPassed => .holds (rl .lasts timeInTheStore (cn (.minutes 20)))
  | a => .opaque (cite a).label

/-- What each atom of the case says. -/
instance meanings : HasMeanings Claim :=
  { argument := "The grits", all, complete := all_complete, means }

/-- **Seven of the nine atoms are analysed**: all but the two about a kind of
grits. -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (7, 9) := by decide

/-- **The grits joins**: a breakfast of five minutes excludes one of twenty, and
five minutes in the store excludes twenty — each by what "lasts" means, and by
nothing else; listed, and proved to be exactly what the meanings contain under
the library's shared ontology. Every dispute over the case holds `a → ¬b` for
each. -/
instance joins : HasJoins Claim where
  exclusions :=
    [ (.breakfastTookFiveMinutes, .breakfastTookTwentyMinutes)
    , (.fiveMinutesPassed, .twentyMinutesPassed) ]
  exclusions_pinned := by decide +kernel
  entailments := []
  entailments_pinned := by decide +kernel

open Testimony.Logic in
/-- **The postulates, written out**: `a → ¬b` for each exclusion. Proofs over
the case's packages unfold to this list, so a named reading must satisfy it. -/
@[gritsDefs] theorem postulates_eq :
    (HasPostulates.postulates : List (Formula Claim)) =
      [ p .breakfastTookFiveMinutes ➝ notP .breakfastTookTwentyMinutes
      , p .fiveMinutesPassed ➝ notP .twentyMinutesPassed ] :=
  rfl

attribute [gritsDefs] Testimony.Logic.ArgumentPackage.held

end TestimonyExamples.Grits.Meanings
