import TestimonyArguments.SolaFide
import TestimonyArguments.Meanings.SolaFide
import Testimony.Checks.Aif
import Testimony.Checks.Conditions
import Testimony.Checks.Fallacies
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Readers
import Testimony.Checks.Readings
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
  the only means: held by 3, used of a text or voice by 11; derives:
    justificationByFaithAlone excludes baptismIsInstrumentalCause
  the whole ground: held by 3, used of a text or voice by 6; derives nothing
  a means is moved by its user: held by 2, used of a text or voice by 0; derives:
    loveMovesFaith excludes faithWorksThroughLove
  moving runs one way: held by 1, used of a text or voice by 0; derives:
    loveMovesFaith excludes faithWorksThroughLove
  the same sense, both ways: stated or denied by 15; derives nothing
  one word, one voice: stated by 2; derives:
    energoumeneIsPassive excludes energoumeneIsMiddle
-/
#guard_msgs in
#check_ontology under TestimonyArguments.SolaFide

/--
info: the fallacy checks, over every argument's lines, each named with its reader:
Sola fide
  lines: 110, read: 62, Scripture's own: 0
  commit what they declare, as declared:
    bellarmineFormedFaithLine (Bellarmine): reading against usage: ἀγάπη at work in ἐνεργουμένη
    bellarminePassiveLine (Bellarmine): reading against usage: ἀγάπη at work in ἐνεργουμένη
    rheimsFormLine (English College at Rheims): reading against usage: ἀγάπη at work in ἐνεργουμένη
    rheimsSoulLine (English College at Rheims): reading against usage: ἀγάπη at work in ἐνεργουμένη
  name as at work in a verb what its author never does:
    bellarmineFormedFaithLine (Bellarmine): ἀγάπη at work in ἐνεργουμένη;
        the author's: θεός, εἷς, πνεῦμα, ἀγαπητός
    bellarminePassiveLine (Bellarmine): ἀγάπη at work in ἐνεργουμένη;
        the author's: θεός, εἷς, πνεῦμα, ἀγαπητός
    rheimsFormLine (English College at Rheims): ἀγάπη at work in ἐνεργουμένη;
        the author's: θεός, εἷς, πνεῦμα, ἀγαπητός
    rheimsSoulLine (English College at Rheims): ἀγάπη at work in ἐνεργουμένη;
        the author's: θεός, εἷς, πνεῦμα, ἀγαπητός
  attribute a view, against the argument's record:
    hippoLine (Augustine): augustine, borne out by augustineGivesBothSenses; latinWest, unrecorded
    renewalLine (Augustine): augustine, borne out by augustineGivesBothSenses; latinWest, unrecorded
    sandersLine (Dunn): secondTempleJudaism, unrecorded
    trentWordLine (Trent): augustine, borne out by augustineGivesBothSenses; latinWest, unrecorded
  cite a voice for one reading, leaving out another the record has:
    hippoLine (Augustine): augustine, also verdict in augustineGivesBothSenses
    renewalLine (Augustine): augustine, also verdict in augustineGivesBothSenses
    trentWordLine (Trent): augustine, also verdict in augustineGivesBothSenses
  conclude a word's sense from no use or reading of the word:
    effectiveVerdictLine (Fitzmyer): dikaioo as makeRighteous
-/
#guard_msgs in
#check_fallacies under TestimonyArguments.SolaFide

/-- info: every package has a model with its postulates: 138, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments.SolaFide

/--
info: every reading and step has a reader or is marked proposed: 138 packages, 110 lines
-/
#guard_msgs in
#check_readers under TestimonyArguments.SolaFide

/--
info: every claim resting where the copies differ takes a reading, rated no higher:
138 packages, 102 claims citing Scripture, 0 naming the edition they read
-/
#guard_msgs in
#check_readings under TestimonyArguments.SolaFide

/-- info: every non-entailment survives its postulates: 27, and 0 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments.SolaFide

/-- info: establish fails, as not Horn, on all 9 refuted packages -/
#guard_msgs in
#check_refutations under TestimonyArguments.SolaFide using unfoldSet

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
beforeTrentDispute.finite: 6 I, 2 RA, 0 CA, 0 PA, 6 edges
faithAndCharityDispute.finite: 26 I, 13 RA, 12 CA, 7 PA, 81 edges
forgivenessDispute.finite: 12 I, 6 RA, 2 CA, 0 PA, 19 edges
historyDispute.finite: 5 I, 2 RA, 2 CA, 0 PA, 9 edges
jamesDispute.finite: 38 I, 13 RA, 11 CA, 4 PA, 83 edges
jesusWordsDispute.finite: 27 I, 11 RA, 6 CA, 0 PA, 43 edges
reformationDispute.finite: 41 I, 20 RA, 11 CA, 0 PA, 83 edges
reformersAnswerDispute.finite: 14 I, 5 RA, 9 CA, 0 PA, 37 edges
solaFideDispute.finite: 80 I, 36 RA, 42 CA, 0 PA, 196 edges
trentAnswersDispute.finite: 19 I, 7 RA, 2 CA, 0 PA, 26 edges
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
forgivenessDispute.finite:
  hidden premises: 0; lines not read: 6
historyDispute.finite:
  hidden premises: 0; lines not read: 2
jamesDispute.finite:
  hidden premises: 0; lines not read: 4
jesusWordsDispute.finite:
  hidden premises: 0; lines not read: 1
reformationDispute.finite:
  hidden premises: 0; lines not read: 13
reformersAnswerDispute.finite:
  hidden premises: 0; lines not read: 2
solaFideDispute.finite:
  hidden premises: 0; lines not read: 6
trentAnswersDispute.finite:
  hidden premises: 0; lines not read: 2
-/
#guard_msgs in
#check_conditions under TestimonyArguments.SolaFide

end TestimonyArguments.Checks.SolaFide
