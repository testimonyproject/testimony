import TestimonyExamples.Grits
import Testimony.Checks.Aif
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Refutations

/-!
# TestimonyExamples.Checks — the library's checks, over the examples

The library checks its own arguments as part of its build
(`Testimony.Checks`). Each check also takes a namespace, so a package built on
the library holds its own cases to the same standard, and here the examples
do: every case's claims have meanings and pinned joins, no package is emptied
by its meanings, no refutation is undone by them, `establish` fails on every
refuted package as not Horn, and every dispute is a graph meeting the Argument
Interchange Format's Definition 1.1. The reports are pinned, so a change in any
of them is a change a reviewer sees.
-/

namespace TestimonyExamples

open Lean in
/-- Each case's namespace, and the unfold set its proofs name. -/
def unfoldSets : List (Name × Name) := [(`TestimonyExamples.Grits, `gritsDefs)]

/-- info: every argument has meanings and pinned joins: 1 claim types -/
#guard_msgs in
#check_meanings under TestimonyExamples

/--
info: the shared ontology, in every argument:
The grits
  joins: 2, with no definition: 0
  one length of time: held by 4, used of a text or voice by 0; derives:
    breakfastTookFiveMinutes excludes breakfastTookTwentyMinutes
    fiveMinutesPassed excludes twentyMinutesPassed
-/
#guard_msgs in
#check_ontology under TestimonyExamples

/-- info: every package has a model with its postulates: 3, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyExamples

/-- info: every non-entailment survives its postulates: 1, and 0 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyExamples

/-- info: establish fails, as not Horn, on all 1 refuted packages -/
#guard_msgs in
#check_refutations under TestimonyExamples using unfoldSets

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
Grits.atTheFastCookFinite: 9 I, 3 RA, 4 CA, 0 PA, 20 edges
Grits.gritsFinite: 9 I, 3 RA, 2 CA, 2 PA, 20 edges
and 0 hearings, drawn with the disputes they restrict
-/
#guard_msgs in
#check_aif under TestimonyExamples

end TestimonyExamples
