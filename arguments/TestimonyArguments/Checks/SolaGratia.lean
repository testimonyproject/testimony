import TestimonyArguments.SolaGratia
import TestimonyArguments.Meanings.SolaGratia
import Testimony.Checks.Aif
import Testimony.Checks.Fallacies
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Refutations

/-!
# TestimonyArguments.Checks.SolaGratia — the library's checks, over one argument

The checks `TestimonyArguments.Checks` describes, run under this argument's
namespace alone, each report pinned here, beside no other argument's. A pull
request that changes this argument changes this file, and no pull request on
another argument does, so two of them never conflict over a pinned count.
-/

namespace TestimonyArguments.Checks.SolaGratia

open Lean in
/-- This argument's namespace, and the unfold set its proofs name
(`TestimonyArguments.Attr`). -/
def unfoldSet : List (Name × Name) :=
  [(`TestimonyArguments.SolaGratia, `solaGratiaDefs)]

/-- info: every argument has meanings and pinned joins: 1 claim types -/
#guard_msgs in
#check_meanings under TestimonyArguments.SolaGratia

/--
info: the shared ontology, in every argument:
Sola gratia — Ephesians 2:8–9 and Romans 9:16
  joins: 1, with no definition: 1
  not a ground: held by 2, used of a text or voice by 0; derives nothing
  the only means: held by 1, used of a text or voice by 0; derives nothing
  the whole ground: held by 2, used of a text or voice by 0; derives nothing
-/
#guard_msgs in
#check_ontology under TestimonyArguments.SolaGratia

/--
info: the charges, against every argument's lines:
Sola gratia — Ephesians 2:8–9 and Romans 9:16
  lines: 27, read: 0
-/
#guard_msgs in
#check_fallacies under TestimonyArguments.SolaGratia

/-- info: every package has a model with its postulates: 36, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments.SolaGratia

/-- info: every non-entailment survives its postulates: 12, and 0 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments.SolaGratia

/-- info: establish fails, as not Horn, on all 4 refuted packages -/
#guard_msgs in
#check_refutations under TestimonyArguments.SolaGratia using unfoldSet

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
perseveranceDispute.finite: 35 I, 15 RA, 24 CA, 0 PA, 85 edges
solaGratiaDispute.finite: 42 I, 14 RA, 47 CA, 0 PA, 131 edges
and 0 hearings, drawn with the disputes they restrict
-/
#guard_msgs in
#check_aif under TestimonyArguments.SolaGratia

end TestimonyArguments.Checks.SolaGratia
