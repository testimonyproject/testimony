import TestimonyArguments.SpiritBaptism
import TestimonyArguments.Meanings.SpiritBaptism
import Testimony.Checks.Aif
import Testimony.Checks.Conditions
import Testimony.Checks.Fallacies
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Readers
import Testimony.Checks.Readings
import Testimony.Checks.Refutations

/-!
# TestimonyArguments.Checks.SpiritBaptism — the library's checks, over one argument

The checks `TestimonyArguments.Checks` describes, run under this argument's
namespace alone, each report pinned here, beside no other argument's. A pull
request that changes this argument changes this file, and no pull request on
another argument does, so two of them never conflict over a pinned count.
-/

namespace TestimonyArguments.Checks.SpiritBaptism

open Lean in
/-- This argument's namespace, and the unfold set its proofs name
(`TestimonyArguments.Attr`). -/
def unfoldSet : List (Name × Name) :=
  [(`TestimonyArguments.SpiritBaptism, `spiritBaptismDefs)]

/-- info: every argument has meanings and pinned joins: 1 claim types -/
#guard_msgs in
#check_meanings under TestimonyArguments.SpiritBaptism

/--
info: the shared ontology, in every argument:
Spirit baptism
  joins: 2, with no definition: 2
-/
#guard_msgs in
#check_ontology under TestimonyArguments.SpiritBaptism

/-- info: every package has a model with its postulates: 7, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments.SpiritBaptism

/--
info: every reading and step has a reader or is marked proposed: 7 packages, 0 lines
-/
#guard_msgs in
#check_readers under TestimonyArguments.SpiritBaptism

/--
info: every claim resting where the copies differ takes a reading, rated no higher:
7 packages, 4 claims citing Scripture, 0 naming the edition they read
-/
#guard_msgs in
#check_readings under TestimonyArguments.SpiritBaptism

/-- info: every non-entailment survives its postulates: 0, and 0 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments.SpiritBaptism

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
spiritBaptismDispute.finite: 15 I, 7 RA, 6 CA, 0 PA, 32 edges
and 0 hearings, drawn with the disputes they restrict
-/
#guard_msgs in
#check_aif under TestimonyArguments.SpiritBaptism

/--
info: every dispute, its lines' conditions stated:
spiritBaptismDispute.finite:
  hidden premises: 0; lines not read: 0
-/
#guard_msgs in
#check_conditions under TestimonyArguments.SpiritBaptism

end TestimonyArguments.Checks.SpiritBaptism
