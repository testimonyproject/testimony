import TestimonyArguments.SolaFide
import TestimonyArguments.Meanings.SolaFide
import Testimony.Checks.Aif
import Testimony.Checks.Fallacies
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
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
  joins: 5, with no definition: 4
  not a ground: held by 4, used of a text or voice by 13; derives nothing
  the only means: held by 3, used of a text or voice by 9; derives:
    justificationByFaithAlone excludes baptismIsInstrumentalCause
  the whole ground: held by 3, used of a text or voice by 6; derives nothing
  the same sense, both ways: stated or denied by 5; derives nothing
-/
#guard_msgs in
#check_ontology under TestimonyArguments.SolaFide

/--
info: the fallacy checks, over every argument's lines, each named with its reader:
Sola fide
  lines: 58, read: 38, Scripture's own: 0
  attribute a view, against the argument's record:
    sandersLine (Dunn): secondTempleJudaism, unrecorded
    trentWordLine (Trent): augustine, borne out by augustineGivesBothSenses; latinWest, unrecorded
  need a word to keep its sense, unstated:
    catholicJamesWordLine (Trent): erga, dikaioo
    catholicJamesWorksLine (Trent): erga, dikaioo
    fruitLine (Westminster Assembly): pistis, erga
    jamesLexicalLine (Moo): dikaioo
    johannineLine (Calvin): pisteuo
    johannineWithoutTrust (Calvin): pisteuo
    paulineLine (uncited): dikaioo, ergaNomou
    paulineWithoutPistisChristou (uncited): dikaioo, ergaNomou
    paulineWithoutWorksOfLaw (uncited): dikaioo, ergaNomou
    renewalWordLine (Trent): dikaioo
    romansFourExegesisLine (Moo): erga
  read one word by a kindred one, the bridge unstated:
    trentWordLine (Trent): iustificare for dikaioo (translation)
  cite a voice for one reading, leaving out another the record has:
    trentWordLine (Trent): augustine, also verdict in augustineGivesBothSenses
  conclude a word's sense from no use or reading of the word:
    effectiveVerdictLine (Fitzmyer): dikaioo as makeRighteous
-/
#guard_msgs in
#check_fallacies under TestimonyArguments.SolaFide

/-- info: every package has a model with its postulates: 93, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments.SolaFide

/-- info: every non-entailment survives its postulates: 27, and 0 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments.SolaFide

/-- info: establish fails, as not Horn, on all 9 refuted packages -/
#guard_msgs in
#check_refutations under TestimonyArguments.SolaFide using unfoldSet

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
jamesDispute.finite: 35 I, 13 RA, 9 CA, 6 PA, 77 edges
jesusWordsDispute.finite: 27 I, 11 RA, 6 CA, 0 PA, 43 edges
solaFideDispute.finite: 77 I, 36 RA, 42 CA, 0 PA, 193 edges
and 3 hearings, drawn with the disputes they restrict
-/
#guard_msgs in
#check_aif under TestimonyArguments.SolaFide

end TestimonyArguments.Checks.SolaFide
