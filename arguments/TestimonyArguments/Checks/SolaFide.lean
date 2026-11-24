import TestimonyArguments.SolaFide
import TestimonyArguments.Meanings.SolaFide
import Testimony.Checks.Aif
import Testimony.Checks.Conditions
import Testimony.Checks.Fallacies
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Readers
import Testimony.Checks.Refutations

/-!
# TestimonyArguments.Checks.SolaFide — the library's checks, over one argument

The checks `TestimonyArguments.Checks` describes, run under this argument's
namespace alone, each report pinned here, beside no other argument's. A pull
request that changes this argument changes this file, and no pull request on
another argument does, so two of them never conflict over a pinned count.
-/

namespace TestimonyArguments.Checks.SolaFide

open Lean in
/-- This argument's namespace, and the unfold set its proofs name
(`TestimonyArguments.Attr`). -/
def unfoldSet : List (Name × Name) :=
  [(`TestimonyArguments.SolaFide, `solaFideDefs)]

/-- info: every argument has meanings and pinned joins: 1 claim types -/
#guard_msgs in
#check_meanings under TestimonyArguments.SolaFide

/--
info: the shared ontology, in every argument:
Sola fide
  joins: 7, with no definition: 4
  not a ground: held by 4, used of a text or voice by 14; derives nothing
  the only means: held by 3, used of a text or voice by 9; derives:
    justificationByFaithAlone excludes baptismIsInstrumentalCause
  the whole ground: held by 3, used of a text or voice by 6; derives nothing
  a means is moved by its user: held by 2, used of a text or voice by 0; derives:
    loveMovesFaith excludes faithWorksThroughLove
  moving runs one way: held by 1, used of a text or voice by 0; derives:
    loveMovesFaith excludes faithWorksThroughLove
  the same sense, both ways: stated or denied by 13; derives nothing
  one word, one voice: stated by 2; derives:
    energoumeneIsPassive excludes energoumeneIsMiddle
-/
#guard_msgs in
#check_ontology under TestimonyArguments.SolaFide

/--
info: the fallacy checks, over every argument's lines, each named with its reader:
Sola fide
  lines: 74, read: 51, Scripture's own: 0
  commit what they declare, as declared:
    bellarminePassiveLine (Bellarmine): misreading of ἐνεργουμένη passive, parsed middle
  argue from a reading of the Greek its parsing does not bear:
    bellarminePassiveLine (Bellarmine): ἐνεργουμένη passive, parsed middle
  attribute a view, against the argument's record:
    renewalLine (Augustine): augustine, borne out by augustineGivesBothSenses; latinWest, unrecorded
    sandersLine (Dunn): secondTempleJudaism, unrecorded
    trentWordLine (Trent): augustine, borne out by augustineGivesBothSenses; latinWest, unrecorded
  cite a voice for one reading, leaving out another the record has:
    renewalLine (Augustine): augustine, also verdict in augustineGivesBothSenses
    trentWordLine (Trent): augustine, also verdict in augustineGivesBothSenses
  conclude a word's sense from no use or reading of the word:
    effectiveVerdictLine (Fitzmyer): dikaioo as makeRighteous
-/
#guard_msgs in
#check_fallacies under TestimonyArguments.SolaFide

/-- info: every package has a model with its postulates: 102, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments.SolaFide

/--
info: every reading and step has a reader or is marked proposed: 102 packages, 74 lines
-/
#guard_msgs in
#check_readers under TestimonyArguments.SolaFide

/-- info: every non-entailment survives its postulates: 27, and 0 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments.SolaFide

/-- info: establish fails, as not Horn, on all 9 refuted packages -/
#guard_msgs in
#check_refutations under TestimonyArguments.SolaFide using unfoldSet

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
beforeTrentDispute.finite: 6 I, 2 RA, 0 CA, 0 PA, 6 edges
faithAndCharityDispute.finite: 26 I, 13 RA, 13 CA, 5 PA, 79 edges
jamesDispute.finite: 38 I, 13 RA, 11 CA, 4 PA, 83 edges
jesusWordsDispute.finite: 27 I, 11 RA, 6 CA, 0 PA, 43 edges
solaFideDispute.finite: 80 I, 36 RA, 42 CA, 0 PA, 196 edges
and 3 hearings, drawn with the disputes they restrict
-/
#guard_msgs in
#check_aif under TestimonyArguments.SolaFide

/--
info: every dispute, its lines' conditions stated:
beforeTrentDispute.finite:
  hidden premises: 0; lines not read: 1
faithAndCharityDispute.finite:
  hidden premises: 0; lines not read: 2
jamesDispute.finite:
  hidden premises: 0; lines not read: 4
jesusWordsDispute.finite:
  hidden premises: 0; lines not read: 1
solaFideDispute.finite:
  hidden premises: 0; lines not read: 6
-/
#guard_msgs in
#check_conditions under TestimonyArguments.SolaFide

end TestimonyArguments.Checks.SolaFide
