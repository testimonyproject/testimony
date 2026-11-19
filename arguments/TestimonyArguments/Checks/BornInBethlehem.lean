import TestimonyArguments.BornInBethlehem
import TestimonyArguments.Meanings.BornInBethlehem
import Testimony.Checks.Aif
import Testimony.Checks.Fallacies
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Refutations

/-!
# TestimonyArguments.Checks.BornInBethlehem — the library's checks, over one argument

The checks `TestimonyArguments.Checks` describes, run under this argument's
namespace alone, each report pinned here, beside no other argument's. A pull
request that changes this argument changes this file, and no pull request on
another argument does, so two of them never conflict over a pinned count.
-/

namespace TestimonyArguments.Checks.BornInBethlehem

open Lean in
/-- This argument's namespace, and the unfold set its proofs name
(`TestimonyArguments.Attr`). -/
def unfoldSet : List (Name × Name) :=
  [(`TestimonyArguments.BornInBethlehem, `bornInBethlehemDefs)]

/-- info: every argument has meanings and pinned joins: 1 claim types -/
#guard_msgs in
#check_meanings under TestimonyArguments.BornInBethlehem

/--
info: the shared ontology, in every argument:
Born in Bethlehem — Micah 5:2
  joins: 0, with no definition: 0
-/
#guard_msgs in
#check_ontology under TestimonyArguments.BornInBethlehem

/--
info: the fallacy checks, over every argument's lines, each named with its reader:
Born in Bethlehem — Micah 5:2
  lines: 2, read: 0, Scripture's own: 0
-/
#guard_msgs in
#check_fallacies under TestimonyArguments.BornInBethlehem

/-- info: every package has a model with its postulates: 2, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments.BornInBethlehem

/-- info: every non-entailment survives its postulates: 1, and 0 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments.BornInBethlehem

/-- info: establish fails, as not Horn, on all 1 refuted packages -/
#guard_msgs in
#check_refutations under TestimonyArguments.BornInBethlehem using unfoldSet

end TestimonyArguments.Checks.BornInBethlehem
