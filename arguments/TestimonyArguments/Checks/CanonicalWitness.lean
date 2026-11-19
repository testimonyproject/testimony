import TestimonyArguments.CanonicalWitness
import TestimonyArguments.Meanings.CanonicalWitness
import Testimony.Checks.Aif
import Testimony.Checks.Fallacies
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Refutations

/-!
# TestimonyArguments.Checks.CanonicalWitness — the library's checks, over one argument

The checks `TestimonyArguments.Checks` describes, run under this argument's
namespace alone, each report pinned here, beside no other argument's. A pull
request that changes this argument changes this file, and no pull request on
another argument does, so two of them never conflict over a pinned count.
-/

namespace TestimonyArguments.Checks.CanonicalWitness

open Lean in
/-- This argument's namespace, and the unfold set its proofs name
(`TestimonyArguments.Attr`). -/
def unfoldSet : List (Name × Name) :=
  [(`TestimonyArguments.CanonicalWitness, `canonicalWitnessDefs)]

/-- info: every argument has meanings and pinned joins: 1 claim types -/
#guard_msgs in
#check_meanings under TestimonyArguments.CanonicalWitness

/--
info: the shared ontology, in every argument:
The canonical witness
  joins: 7, with no definition: 7
  not a ground: held by 3, used of a text or voice by 6; derives nothing
  the same sense, both ways: stated or denied by 1; derives nothing
-/
#guard_msgs in
#check_ontology under TestimonyArguments.CanonicalWitness

/--
info: the fallacy checks, over every argument's lines, each named with its reader:
The canonical witness
  lines: 8, read: 8, Scripture's own: 0
  need a word to keep its sense, unstated:
    hebrewsLine (Bruce): pistis
    johannineLine (Calvin): pisteuo
    paulineFaithLine (Schreiner): dikaioo
    paulineLine (Schreiner): pistis, sozo, erga
-/
#guard_msgs in
#check_fallacies under TestimonyArguments.CanonicalWitness

/-- info: every package has a model with its postulates: 15, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments.CanonicalWitness

/-- info: every non-entailment survives its postulates: 4, and 0 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments.CanonicalWitness

/-- info: establish fails, as not Horn, on all 4 refuted packages -/
#guard_msgs in
#check_refutations under TestimonyArguments.CanonicalWitness using unfoldSet

end TestimonyArguments.Checks.CanonicalWitness
