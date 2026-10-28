import Testimony.Ontology.Usage.Definitions

/-!
# Testimony.Ontology.Usage.Examples — the definition, at work

Statements of the article's own, about one Greek word in two texts. A sense the
word has in one passage of the Septuagint excludes the claim that the
Septuagint's Greek lacks it: with the definition, and not without it. Three
things it does not do are shown too. That the woman a passage uses the word of
is a virgin excludes nothing, because that is what the word refers to, not what
it means. A sense in Matthew says nothing of the Septuagint. And a sense in the
usage says nothing of any one passage.
-/

namespace Testimony.Ontology.Usage

open Testimony Testimony.Semantics Testimony.Semantics.Notation

/-- The Septuagint, as its translators' text reads. -/
abbrev theSeptuagint : Voice := .version .septuagint

/-- In the Septuagint's Leviticus 21:13, παρθένος means a virgin. -/
abbrev senseThere : Statement :=
  .means .parthenos (.passageOf theSeptuagint (vs .leviticus 21 13)) .virgin

/-- In the Septuagint's Greek as a whole, παρθένος does not mean a virgin. -/
abbrev notInTheUsage : Statement := .denied (.means .parthenos (.usage theSeptuagint) .virgin)

/-- The woman Leviticus 21:13 speaks of is a virgin: what the word refers to
there, not what it means. -/
abbrev referentThere : Statement :=
  .holds (rl .isA (pt "the high priest's wife, Leviticus 21:13" .agent) (cn .virginity))

/-- In Matthew 1:23, παρθένος means a virgin. -/
abbrev senseInMatthew : Statement :=
  .means .parthenos (.passageOf .matthew (vs .matthew 1 23)) .virgin

/-- In the Septuagint's Greek as a whole, παρθένος means a virgin. -/
abbrev inTheUsage : Statement := .means .parthenos (.usage theSeptuagint) .virgin

/-- In the Septuagint's Genesis 34:3, παρθένος does not mean a virgin. -/
abbrev notAtGenesis34 : Statement :=
  .denied (.means .parthenos (.passageOf theSeptuagint (vs .genesis 34 3)) .virgin)

/-- **"A sense in a usage", at work.** That the Septuagint's Leviticus 21:13 uses
παρθένος in the sense "virgin", and that the Septuagint's Greek lacks that sense,
cannot both be held: given what a usage "as a whole" is, and not otherwise.

What it does not join is as much a part of it. That the woman of the verse is a
virgin joins nothing: a word used of a virgin need not mean "virgin", as Walton
argues of "fiancée" (*JETS* 30, 1987, 292). A sense in Matthew's Greek says
nothing of the Septuagint's. And that the Septuagint's Greek has the sense says
nothing of Genesis 34:3, where the word is used of Dinah after Shechem. -/
theorem a_sense_in_a_usage_at_work :
    Ontology.excludeEachOther [senseInUsage] senseThere notInTheUsage = true ∧
      Ontology.excludeEachOther [] senseThere notInTheUsage = false ∧
      Ontology.excludeEachOther [senseInUsage] referentThere notInTheUsage = false ∧
      Ontology.excludeEachOther [senseInUsage] senseInMatthew notInTheUsage = false ∧
      Ontology.excludeEachOther [senseInUsage] inTheUsage notAtGenesis34 = false := by
  decide

end Testimony.Ontology.Usage
