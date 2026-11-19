import TestimonyArguments.SolaScriptura
import TestimonyArguments.Meanings.SolaScriptura
import Testimony.Checks.Aif
import Testimony.Checks.Conditions
import Testimony.Checks.Fallacies
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Readers
import Testimony.Checks.Refutations

/-!
# TestimonyArguments.Checks.SolaScriptura — the library's checks, over one argument

The checks `TestimonyArguments.Checks` describes, run under this argument's
namespace alone, each report pinned here, beside no other argument's. A pull
request that changes this argument changes this file, and no pull request on
another argument does, so two of them never conflict over a pinned count.
-/

namespace TestimonyArguments.Checks.SolaScriptura

open Lean in
/-- This argument's namespace, and the unfold set its proofs name
(`TestimonyArguments.Attr`). -/
def unfoldSet : List (Name × Name) :=
  [(`TestimonyArguments.SolaScriptura, `solaScripturaDefs)]

/-- info: every argument has meanings and pinned joins: 1 claim types -/
#guard_msgs in
#check_meanings under TestimonyArguments.SolaScriptura

/--
info: the shared ontology, in every argument:
Sola scriptura
  joins: 3, with no definition: 3
  not a ground: held by 2, used of a text or voice by 1; derives nothing
  the only means: held by 6, used of a text or voice by 1; derives nothing
  the whole ground: held by 2, used of a text or voice by 1; derives nothing
-/
#guard_msgs in
#check_ontology under TestimonyArguments.SolaScriptura

/--
info: the fallacy checks, over every argument's lines, each named with its reader:
Sola scriptura
  lines: 32, read: 26, Scripture's own: 0
-/
#guard_msgs in
#check_fallacies under TestimonyArguments.SolaScriptura

/-- info: every package has a model with its postulates: 40, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments.SolaScriptura

/--
info: every reading and step has a reader or is marked proposed: 40 packages, 32 lines
-/
#guard_msgs in
#check_readers under TestimonyArguments.SolaScriptura

/-- info: every non-entailment survives its postulates: 37, and 0 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments.SolaScriptura

/-- info: establish fails, as not Horn, on all 8 refuted packages -/
#guard_msgs in
#check_refutations under TestimonyArguments.SolaScriptura using unfoldSet

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
canonDispute.finite: 12 I, 2 RA, 2 CA, 0 PA, 16 edges
mark7Dispute.finite: 10 I, 6 RA, 7 CA, 2 PA, 32 edges
and 2 hearings, drawn with the disputes they restrict
-/
#guard_msgs in
#check_aif under TestimonyArguments.SolaScriptura

/--
info: every dispute, its lines' conditions stated:
mark7Dispute.finite:
  hidden premises: 0; lines not read: 0
-/
#guard_msgs in
#check_conditions under TestimonyArguments.SolaScriptura

end TestimonyArguments.Checks.SolaScriptura
