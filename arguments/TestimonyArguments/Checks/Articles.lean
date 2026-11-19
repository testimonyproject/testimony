import TestimonyArguments.Articles.Howell2003
import Testimony.Checks.Aif
import Testimony.Checks.Conditions
import Testimony.Checks.Postulates
import Testimony.Checks.Readers

/-!
# TestimonyArguments.Checks.Articles — the library's checks, over the articles

The checks `TestimonyArguments.Checks` describes that reach the published
articles the package examines: their packages against their postulates, and
their hearings drawn as AIF graphs. An article has no claims of its own, so the
meanings, the ontology and the fallacy checks reach it through the arguments
whose claims it uses.
-/

namespace TestimonyArguments.Checks.Articles

/-- info: every package has a model with its postulates: 1, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments.Articles

/--
info: every reading and step has a reader or is marked proposed: 1 packages, 0 lines
-/
#guard_msgs in
#check_readers under TestimonyArguments.Articles

/-- info: every non-entailment survives its postulates: 0, and 0 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments.Articles

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
Howell2003.hearingFinite: 87 I, 38 RA, 45 CA, 1 PA, 212 edges
and 0 hearings, drawn with the disputes they restrict
-/
#guard_msgs in
#check_aif under TestimonyArguments.Articles

/--
info: every dispute, its lines' conditions stated:
Howell2003.hearingFinite:
  hidden premises: 0; lines not read: 6
-/
#guard_msgs in
#check_conditions under TestimonyArguments.Articles

end TestimonyArguments.Checks.Articles
