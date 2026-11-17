import TestimonyArguments.Trinity
import TestimonyArguments.Meanings.Trinity
import Testimony.Checks.Aif
import Testimony.Checks.Fallacies
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Refutations

/-!
# TestimonyArguments.Checks.Trinity — the library's checks, over one argument

The checks `TestimonyArguments.Checks` describes, run under this argument's
namespace alone, each report pinned here, beside no other argument's. A pull
request that changes this argument changes this file, and no pull request on
another argument does, so two of them never conflict over a pinned count.
-/

namespace TestimonyArguments.Checks.Trinity

open Lean in
/-- This argument's namespace, and the unfold set its proofs name
(`TestimonyArguments.Attr`). -/
def unfoldSet : List (Name × Name) :=
  [(`TestimonyArguments.Trinity, `trinityDefs)]

/-- info: every argument has meanings and pinned joins: 1 claim types -/
#guard_msgs in
#check_meanings under TestimonyArguments.Trinity

/--
info: the shared ontology, in every argument:
The Triune God
  joins: 0, with no definition: 0
-/
#guard_msgs in
#check_ontology under TestimonyArguments.Trinity

/--
info: the charges, against every argument's lines:
The Triune God
  lines: 34, read: 0
-/
#guard_msgs in
#check_fallacies under TestimonyArguments.Trinity

/-- info: every package has a model with its postulates: 28, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments.Trinity

/-- info: every non-entailment survives its postulates: 12, and 0 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments.Trinity

/-- info: establish fails, as not Horn, on all 2 refuted packages -/
#guard_msgs in
#check_refutations under TestimonyArguments.Trinity using unfoldSet

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
caseDispute.finite: 56 I, 24 RA, 27 CA, 0 PA, 138 edges
deityDispute.finite: 31 I, 9 RA, 14 CA, 0 PA, 70 edges
orderDispute.finite: 20 I, 8 RA, 8 CA, 0 PA, 43 edges
processionDispute.finite: 16 I, 6 RA, 2 CA, 0 PA, 26 edges
and 0 hearings, drawn with the disputes they restrict
-/
#guard_msgs in
#check_aif under TestimonyArguments.Trinity

end TestimonyArguments.Checks.Trinity
