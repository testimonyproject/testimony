import TestimonyArguments.BornInBethlehem
import TestimonyArguments.BornOfAVirgin
import TestimonyArguments.CanonicalWitness
import TestimonyArguments.SolaFide
import TestimonyArguments.SolaScriptura
import TestimonyArguments.SpiritBaptism
import TestimonyArguments.Meanings
import TestimonyArguments.Articles.Howell2003
import Testimony.Checks.Aif
import Testimony.Checks.Ontology
import Testimony.Checks.Postulates
import Testimony.Checks.Refutations

/-!
# TestimonyArguments.Checks — the library's checks, over every argument

The checks the library defines (`Testimony.Checks`), run over this package as
part of its build. Each finds what it checks for itself, so an argument added
tomorrow is checked tomorrow, and each report is pinned, so a change in any of
them is a change a reviewer sees:

- **meanings**: every argument's claims have meanings, and its postulates come
  from its pinned joins and nowhere else;
- **the shared ontology**: what each of the library's definitions does in each
  argument — where its words are held, and the joins it derives;
- **postulates**: no package is emptied by its meanings, and no refutation is
  undone by them;
- **refutations**: `establish` fails, as not Horn, on every package an argument
  refutes, with that argument's unfold set;
- **AIF**: every dispute is a graph meeting the Argument Interchange Format's
  Definition 1.1.
-/

namespace TestimonyArguments

open Lean in
/-- Each argument's namespace, and the unfold set its proofs name
(`TestimonyArguments.Attr`). A refutation outside every namespace listed here
fails the check, so a new argument cannot be left out of it. -/
def unfoldSets : List (Name × Name) :=
  [ (`TestimonyArguments.BornInBethlehem, `bornInBethlehemDefs)
  , (`TestimonyArguments.BornOfAVirgin, `bornOfAVirginDefs)
  , (`TestimonyArguments.CanonicalWitness, `canonicalWitnessDefs)
  , (`TestimonyArguments.SolaFide, `solaFideDefs)
  , (`TestimonyArguments.SolaScriptura, `solaScripturaDefs)
  , (`TestimonyArguments.SpiritBaptism, `spiritBaptismDefs) ]

/-- info: every argument has meanings and pinned joins: 6 claim types -/
#guard_msgs in
#check_meanings under TestimonyArguments

/--
info: the shared ontology, in every argument:
Born in Bethlehem — Micah 5:2
  joins: 0, with no definition: 0
Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3
  joins: 10, with no definition: 4
  a sense in a usage: stated at a passage of a voice's text by 3; derives:
    parthenosMeantYoungWoman excludes lawsUseParthenosAsVirgin
    parthenosMeantYoungWoman excludes dinahIsTheLawsParthenos
    parthenosMeantYoungWoman excludes lxxIsaiahUsesParthenosAsVirgin
    lawsUseParthenosAsVirgin entails parthenosMeansVirgin
    dinahIsTheLawsParthenos entails parthenosMeansVirgin
    lxxIsaiahUsesParthenosAsVirgin entails parthenosMeansVirgin
Sola fide
  joins: 6, with no definition: 5
  not a ground: held by 4, used of a text or voice by 13; derives nothing
  the only means: held by 3, used of a text or voice by 9; derives:
    justificationByFaithAlone excludes baptismIsInstrumentalCause
  the whole ground: held by 3, used of a text or voice by 6; derives nothing
Sola scriptura
  joins: 3, with no definition: 3
  not a ground: held by 1, used of a text or voice by 0; derives nothing
  the whole ground: held by 1, used of a text or voice by 0; derives nothing
Spirit baptism
  joins: 2, with no definition: 2
The canonical witness
  joins: 7, with no definition: 7
  not a ground: held by 3, used of a text or voice by 0; derives nothing
-/
#guard_msgs in
#check_ontology under TestimonyArguments

/-- info: every package has a model with its postulates: 170, and 0 undecided -/
#guard_msgs in
#check_postulates under TestimonyArguments

/-- info: every non-entailment survives its postulates: 84, and 4 undecided -/
#guard_msgs in
#check_refutations_postulates under TestimonyArguments

/-- info: establish fails, as not Horn, on all 34 refuted packages -/
#guard_msgs in
#check_refutations under TestimonyArguments using unfoldSets

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
Articles.Howell2003.hearingFinite: 63 I, 27 RA, 29 CA, 3 PA, 150 edges
BornOfAVirgin.genesisFinite: 8 I, 3 RA, 2 CA, 0 PA, 15 edges
BornOfAVirgin.isaiahFinite: 30 I, 10 RA, 6 CA, 1 PA, 48 edges
BornOfAVirgin.matthewFinite: 6 I, 2 RA, 2 CA, 0 PA, 10 edges
BornOfAVirgin.promiseFinite: 17 I, 5 RA, 5 CA, 0 PA, 30 edges
BornOfAVirgin.septuagintFinite: 16 I, 5 RA, 6 CA, 1 PA, 31 edges
BornOfAVirgin.wegnerFinite: 13 I, 5 RA, 4 CA, 0 PA, 22 edges
SolaFide.jamesFinite: 35 I, 13 RA, 9 CA, 6 PA, 77 edges
SolaFide.jesusWordsFinite: 27 I, 11 RA, 6 CA, 0 PA, 43 edges
SolaFide.solaFideFinite: 56 I, 25 RA, 26 CA, 2 PA, 134 edges
SolaScriptura.mark7Finite: 10 I, 6 RA, 7 CA, 2 PA, 32 edges
SpiritBaptism.spiritBaptismFinite: 15 I, 7 RA, 6 CA, 0 PA, 32 edges
and 5 hearings, drawn with the disputes they restrict
-/
#guard_msgs in
#check_aif under TestimonyArguments

end TestimonyArguments
