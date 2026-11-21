import Testimony.Corpus.Table

/-!
# Testimony.Corpus.Hebrew — the Hebrew Bible, word by word

The Greek New Testament entered the library as data so that a claim about what a verse contains
could be checked against the text rather than asserted (`Testimony.Corpus.Greek`). This module
does the same for the Hebrew Bible, so far for the part of a verse an argument names: what
Isaiah 7:14 calls the young woman (עַלְמָה), or the Bethlehem Ephrathah of Micah 5:2.

The words come from MACULA Hebrew (`Testimony.Bib.maculaHebrew`), Clear Bible's annotation of
the Westminster Leningrad Codex. The text is the Leningrad Codex's, the oldest complete
manuscript of the Hebrew Bible, as the Westminster Leningrad Codex transcribes it, and it is in
the public domain. The parsing is the Open Scriptures Hebrew Bible's, licensed CC BY 4.0.
`scripts/import_hebrew.py` writes one file per book under `data/hebrew/macula-wlc/`, keeping only
the columns the library reads, and that directory's README records the sources and their
checksums. Only the books the library has needed are imported; a part of a verse in any other
book is refused until its book is.

## What the data is, and what it is not

The words are the Masoretic Text's, as one manuscript has them. Where the Septuagint or the Dead
Sea Scrolls read otherwise, as at Psalm 22:16, the table gives the Masoretic reading alone, and
a dispute that turns on the difference must say so. The parsing is an interpretation, usually
uncontested and sometimes not, and the library cites it as the Open Scriptures Hebrew Bible's.

A written Hebrew word is often several rows of the table: "and you" (וְאַתָּה) is the
conjunction and the pronoun, at one position. The positions a part of a verse names are written
words, so a part begins and ends on a whole word.

## Verse numbers

A part of a verse names its verse as English Bibles number it, and the build finds that verse in
the Hebrew by STEPBible's table of versification traditions (`Testimony.Bib.stepTvtms`), as
`Testimony.Corpus.Table` explains. English Micah 5:2 is read from the Hebrew's 5:1. A verse the
Hebrew divides differently from English Bibles is refused.
-/

namespace Testimony.Corpus.Hebrew

open Lean Elab Command

/-- `#hebrew_corpus` reports every imported book of the Hebrew Bible, how many rows its table
has, and how many verses English Bibles number differently from the Hebrew. -/
syntax (name := hebrewCorpusCmd) "#hebrew_corpus" : command

elab_rules : command
  | `(#hebrew_corpus) => do
    let dir ← liftIO hebrew.dir
    let numbering ← liftIO (IO.FS.readFile (dir / "versification.tsv"))
    let mut lines := #[]
    for (code, _) in hebrew.books do
      if ← liftIO (dir / s!"{code}.tsv").pathExists then
        let rows ← liftIO (hebrew.readBook code)
        let moved := (numbering.splitOn "\n").filter (·.startsWith s!"{code} ") |>.length
        lines := lines.push s!"{code}: {rows.size} words, {moved} verses numbered otherwise"
    logInfo m!"the Hebrew corpus:\n{String.intercalate "\n" lines.toList}"

/--
info: the Hebrew corpus:
ISA: 25697 words, 34 verses numbered otherwise
MIC: 2134 words, 15 verses numbered otherwise
-/
#guard_msgs in
#hebrew_corpus

/-! ### Parts of verses, read

Isaiah 7:14 begins with the sign the Lord will give and goes on to the young woman who will bear
a son and call him Immanuel. Words 7 to 11 of the Hebrew, הִנֵּה הָעַלְמָה הָרָה וְיֹלֶדֶת בֵּן,
are the young woman with child and bearing a son, and their one עַלְמָה anchors them. -/

verse_part isaiahSevenFourteenB from ISA 7 14 7 11 "b" "עַלְמָה"

/-! Micah 5:2 opens by addressing Bethlehem Ephrathah, too small to be among the clans of Judah.
The Hebrew numbers the verse 5:1, and the build reads it there: those words are 1 to 8, anchored
by Ephrathah (אֶפְרָתָה). -/

verse_part micahFiveTwoA from MIC 5 2 1 8 "a" "אֶפְרָתָה"

/-- **The parts are named as English Bibles number them.** The part of Micah read from the
Hebrew's 5:1 is shown to a reader as Micah 5:2a ("Mic 5:2a"), and it lies within Micah 5:2. -/
theorem parts_keep_english_numbers :
    isaiahSevenFourteenB.render = "Isa 7:14b" ∧
    micahFiveTwoA.render = "Mic 5:2a" ∧
    micahFiveTwoA.within (.verse ⟨.micah, 5, 2⟩) := by
  decide

/-! The same words cannot be anchored by Bethlehem, because the name is two written words, בֵּית
and לֶחֶם, and the table gives both the dictionary form בֵּית לֶחֶם. (The anchor below is typed
with its points in Unicode's order, which the codex does not keep. The two are compared with
each letter's points in one order, so either way of typing it finds the word.) Nor can English
Micah 5:2 be read at the Hebrew's 5:2, which is the English 5:3 and holds no Ephrathah. And a
part of English Isaiah 64:1 is refused outright, because the Hebrew prints that verse as the end
of its 63:19, so its words are counted as words of another verse. -/

/--
error: verse_part: MIC 5:2a: its anchor בֵּית לֶחֶם occurs 2 times among words 1 to 8
-/
#guard_msgs in
verse_part micahBethlehemTwice from MIC 5 2 1 8 "a" "בֵּית לֶחֶם"

/--
error: verse_part: MIC 5:3a: its anchor אֶפְרָתָה is not among words 1 to 8
-/
#guard_msgs in
verse_part micahFiveThreeA from MIC 5 3 1 8 "a" "אֶפְרָתָה"

/--
error: verse_part: ISA 64:1a: the Hebrew does not hold English 64:1 as one whole verse
-/
#guard_msgs in
verse_part isaiahSixtyFourOneA from ISA 64 1 1 3 "a" "לוּא"

/--
error: verse_part: GEN 1:1a: the corpus has no file for GEN
-/
#guard_msgs in
verse_part genesisOneOneA from GEN 1 1 1 2 "a" "רֵאשִׁית"

end Testimony.Corpus.Hebrew
