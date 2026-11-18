import TestimonyArguments.BornOfAVirgin
import TestimonyArguments.Meanings.BornOfAVirgin
import Testimony.Checks.Aif
import Testimony.Checks.Fallacies
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Readers
import Testimony.Checks.Refutations

/-!
# TestimonyArguments.Checks.BornOfAVirgin — the library's checks, over one argument

The checks `TestimonyArguments.Checks` describes, run under this argument's
namespace alone, each report pinned here, beside no other argument's. A pull
request that changes this argument changes this file, and no pull request on
another argument does, so two of them never conflict over a pinned count.
-/

namespace TestimonyArguments.Checks.BornOfAVirgin

open Lean in
/-- This argument's namespace, and the unfold set its proofs name
(`TestimonyArguments.Attr`). -/
def unfoldSet : List (Name × Name) :=
  [(`TestimonyArguments.BornOfAVirgin, `bornOfAVirginDefs)]

/-- info: every argument has meanings and pinned joins: 1 claim types -/
#guard_msgs in
#check_meanings under TestimonyArguments.BornOfAVirgin

/--
info: the shared ontology, in every argument:
Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3
  joins: 16, with no definition: 7
  a sense in a usage: stated at a passage of a voice's text by 3; derives:
    parthenosMeantYoungWoman excludes lawsUseParthenosAsVirgin
    parthenosMeantYoungWoman excludes dinahIsTheLawsParthenos
    parthenosMeantYoungWoman excludes lxxIsaiahUsesParthenosAsVirgin
    lawsUseParthenosAsVirgin excludes parthenosDoesNotItselfConnoteVirginity
    dinahIsTheLawsParthenos excludes parthenosDoesNotItselfConnoteVirginity
    lxxIsaiahUsesParthenosAsVirgin excludes parthenosDoesNotItselfConnoteVirginity
    lawsUseParthenosAsVirgin entails parthenosMeansVirgin
    dinahIsTheLawsParthenos entails parthenosMeansVirgin
    lxxIsaiahUsesParthenosAsVirgin entails parthenosMeansVirgin
-/
#guard_msgs in
#check_ontology under TestimonyArguments.BornOfAVirgin

/--
info: the charges, against every argument's lines:
Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3
  lines: 41, read: 0
-/
#guard_msgs in
#check_fallacies under TestimonyArguments.BornOfAVirgin

/-- info: every package has a model with its postulates: 51, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments.BornOfAVirgin

/--
info: every reading and step has a reader or is marked proposed: 51 packages, 41 lines
-/
#guard_msgs in
#check_readers under TestimonyArguments.BornOfAVirgin

/-- info: every non-entailment survives its postulates: 36, and 4 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments.BornOfAVirgin

/-- info: establish fails, as not Horn, on all 12 refuted packages -/
#guard_msgs in
#check_refutations under TestimonyArguments.BornOfAVirgin using unfoldSet

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
genesisDispute.finite: 8 I, 3 RA, 2 CA, 0 PA, 15 edges
isaiahDispute.finite: 30 I, 10 RA, 6 CA, 1 PA, 48 edges
matthewDispute.finite: 7 I, 2 RA, 2 CA, 0 PA, 11 edges
promiseDispute.finite: 17 I, 5 RA, 5 CA, 0 PA, 30 edges
septuagintDispute.finite: 19 I, 7 RA, 13 CA, 3 PA, 55 edges
wegnerDispute.finite: 13 I, 5 RA, 4 CA, 0 PA, 22 edges
and 5 hearings, drawn with the disputes they restrict
-/
#guard_msgs in
#check_aif under TestimonyArguments.BornOfAVirgin

end TestimonyArguments.Checks.BornOfAVirgin
