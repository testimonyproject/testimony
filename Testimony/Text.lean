/-!
# Testimony.Text — Layer 1: Text & canon

Typed references into the biblical corpus. A `Passage` is a *reference*, not
the text itself; resolution against real corpus data (OSHB/STEPBible
identifiers) arrives in Phase 3.
-/

namespace Testimony

-- `missingDocs` is disabled for this declaration alone: a constructor named
-- `genesis` is documented by its name, and dozens of docstrings restating book
-- titles would bury the docstrings that carry real content.
set_option linter.missingDocs false in
/-- A book of the biblical corpus. Extend as needed; the canon a book belongs
to is a separate question (see `Canon`). -/
inductive Book
  | genesis | exodus | leviticus | numbers | deuteronomy
  | joshua | judges | ruth | firstSamuel | secondSamuel
  | firstKings | secondKings | firstChronicles | secondChronicles
  | ezra | nehemiah | esther
  | job | psalms | proverbs | ecclesiastes | songOfSongs
  | isaiah | jeremiah | lamentations | ezekiel | daniel
  | hosea | joel | amos | obadiah | jonah | micah
  | nahum | habakkuk | zephaniah | haggai | zechariah | malachi
  | matthew | mark | luke | john | acts
  | romans | firstCorinthians | secondCorinthians | galatians | ephesians
  | philippians | colossians | firstThessalonians | secondThessalonians
  | firstTimothy | secondTimothy | titus | philemon | hebrews | james
  | firstPeter | secondPeter | firstJohn | secondJohn | thirdJohn | jude
  | revelation
  -- Deuterocanonical books, added as they are cited. Which canon holds a book
  -- is a separate question (`Canon`): Trent cites Sirach as Scripture, and the
  -- Protestant canon does not hold it.
  | sirach | firstMaccabees
  -- Both Testaments are complete for the 66-book Protestant canon; of the
  -- deuterocanonical books, only those an argument cites are represented.
deriving Repr, DecidableEq

/-- Canonical boundaries differ by tradition. Results are always relative to a
declared canon. -/
inductive Canon
  /-- The 66-book Protestant canon. -/
  | protestant
  /-- The Catholic canon, including the deuterocanonical books. -/
  | catholic
  /-- The Eastern Orthodox canon. -/
  | orthodox
  /-- The broader Ethiopian Orthodox Tewahedo canon. -/
  | ethiopian
  /-- The Hebrew Bible, in its Jewish ordering. -/
  | tanakh
deriving Repr, DecidableEq

/-- Language of a textual witness. -/
inductive Language
  /-- Biblical Hebrew. -/
  | hebrew
  /-- Biblical Aramaic, as in parts of Daniel and Ezra. -/
  | aramaic
  /-- Koine Greek. -/
  | greek
deriving Repr, DecidableEq

/-- Textual tradition a reading is drawn from. -/
inductive TextualTradition
  /-- The Masoretic Text, the traditional Hebrew text. -/
  | masoretic
  /-- The Septuagint, the ancient Greek translation of the Hebrew scriptures.
  Its rendering of Isaiah 7:14 is load-bearing for the virgin-birth argument. -/
  | septuagint
  /-- The Qumran biblical manuscripts. -/
  | deadSeaScrolls
  /-- Nestle-Aland 28, the standard critical Greek New Testament. -/
  | nestleAland28
  /-- Jerome's Latin Vulgate. -/
  | vulgate
  /-- The Syriac Peshitta. -/
  | peshitta
  /-- Targum Jonathan, the Aramaic rendering of the Prophets. Distinguished
  from the Hebrew it renders because its vocabulary is evidence about how the
  Hebrew was *understood* in Aramaic-speaking Judaism, which is a different
  question from what the Hebrew says. -/
  | targum
deriving Repr, DecidableEq

/-- A verse-level reference: book, chapter, verse. -/
structure Passage where
  /-- The book referenced. -/
  book : Book
  /-- The chapter number, as traditionally versified. -/
  chapter : Nat
  /-- The verse number, as traditionally versified. -/
  verse : Nat
deriving Repr, DecidableEq

/-- A contiguous range of verses within one book. -/
structure Pericope where
  /-- The book referenced; ranges never span books. -/
  book : Book
  /-- Chapter of the first verse in the range. -/
  startChapter : Nat
  /-- The first verse in the range. -/
  startVerse : Nat
  /-- Chapter of the last verse in the range. -/
  endChapter : Nat
  /-- The last verse in the range, inclusive. -/
  endVerse : Nat
deriving Repr, DecidableEq

/-- **Part of one verse**: the words from `first` to `last`, by their positions in the verse as
the Greek corpus numbers them, from 1. A reader sees it as the verse with a letter, "John
3:18a". The part is anchored by one word it contains, named by its dictionary form, which must
occur in the part exactly once (`anchor`), so that "the half of 3:18 about believing in him" is
found in the text, not asserted. Build one with `verse_part` (`Testimony.Corpus.Greek`), which
reads the corpus and refuses a part whose words or anchor are not there. A part written out by
hand is read from the corpus again by `#check_verse_parts` (`Testimony.Checks.VerseParts`),
which fails the build on any the corpus does not bear out. -/
structure VersePart where
  /-- The verse the part is of. -/
  verse : Passage
  /-- The letter a reader sees after the verse number: "a", "b". -/
  letter : String
  /-- The position of its first word in the verse. -/
  first : Nat
  /-- The position of its last word in the verse, inclusive. -/
  last : Nat
  /-- The dictionary form of the word that anchors it. -/
  anchor : String
deriving Repr, DecidableEq

/-- Either a single verse, a contiguous range, or part of one verse. Scripture
citations quantify over this, so `Matthew 2:1; Luke 2:4–7` is two `PassageRange`
values rather than one opaque string. -/
inductive PassageRange
  /-- A single verse. -/
  | verse (p : Passage)
  /-- A contiguous range of verses. -/
  | range (r : Pericope)
  /-- Part of one verse. -/
  | part (q : VersePart)
deriving Repr, DecidableEq

/-- The standard scholarly abbreviation for a book, following SBL style. Used
wherever a reference is rendered for a human reader. -/
def Book.abbrev : Book → String
  | .genesis => "Gen" | .exodus => "Exod" | .leviticus => "Lev"
  | .numbers => "Num" | .deuteronomy => "Deut"
  | .joshua => "Josh" | .judges => "Judg" | .ruth => "Ruth"
  | .firstSamuel => "1 Sam" | .secondSamuel => "2 Sam"
  | .firstKings => "1 Kgs" | .secondKings => "2 Kgs"
  | .firstChronicles => "1 Chr" | .secondChronicles => "2 Chr"
  | .ezra => "Ezra" | .nehemiah => "Neh" | .esther => "Esth"
  | .job => "Job" | .psalms => "Ps" | .proverbs => "Prov"
  | .ecclesiastes => "Eccl" | .songOfSongs => "Song"
  | .isaiah => "Isa" | .jeremiah => "Jer" | .lamentations => "Lam"
  | .ezekiel => "Ezek" | .daniel => "Dan"
  | .hosea => "Hos" | .joel => "Joel" | .amos => "Amos" | .obadiah => "Obad"
  | .jonah => "Jonah" | .micah => "Mic" | .nahum => "Nah" | .habakkuk => "Hab"
  | .zephaniah => "Zeph" | .haggai => "Hag" | .zechariah => "Zech"
  | .malachi => "Mal"
  | .matthew => "Matt" | .mark => "Mark" | .luke => "Luke" | .john => "John"
  | .acts => "Acts" | .romans => "Rom"
  | .firstCorinthians => "1 Cor" | .secondCorinthians => "2 Cor"
  | .galatians => "Gal" | .ephesians => "Eph" | .philippians => "Phil"
  | .colossians => "Col"
  | .firstThessalonians => "1 Thess" | .secondThessalonians => "2 Thess"
  | .firstTimothy => "1 Tim" | .secondTimothy => "2 Tim"
  | .titus => "Titus" | .philemon => "Phlm" | .hebrews => "Heb"
  | .james => "Jas" | .firstPeter => "1 Pet" | .secondPeter => "2 Pet"
  | .firstJohn => "1 John" | .secondJohn => "2 John" | .thirdJohn => "3 John"
  | .jude => "Jude" | .revelation => "Rev"
  | .sirach => "Sir" | .firstMaccabees => "1 Macc"

/-- A verse reference as a reader expects it: `Matt 2:1`. -/
def Passage.render (p : Passage) : String :=
  s!"{p.book.abbrev} {p.chapter}:{p.verse}"

/-- A range as a reader expects it: `Luke 2:4-7`, or `Matt 1:18-2:3` when it
crosses a chapter boundary. -/
def Pericope.render (r : Pericope) : String :=
  if r.startChapter == r.endChapter then
    s!"{r.book.abbrev} {r.startChapter}:{r.startVerse}-{r.endVerse}"
  else
    s!"{r.book.abbrev} {r.startChapter}:{r.startVerse}-{r.endChapter}:{r.endVerse}"

/-- The book a range belongs to. Ranges never span books, by construction. -/
def PassageRange.book : PassageRange → Book
  | .verse p => p.book
  | .range r => r.book
  | .part q => q.verse.book

/-- A verse, range or part of a verse as a reader expects it: `John 3:18a`. -/
def PassageRange.render : PassageRange → String
  | .verse p => p.render
  | .range r => r.render
  | .part q => q.verse.render ++ q.letter

/-! ### Where one passage lies against another

A passage is an interval of the text: from a first word to a last, in one book. A verse or a
range runs from the start of its first verse to the end of its last; a part of a verse, from its
first word to its last. So whether one passage lies within another, or overlaps it, is a
comparison of the two intervals' ends, read as chapter, verse and word in that order. -/

/-- The position standing for "to the end of the verse", past any word a verse has. -/
def PassageRange.verseEnd : Nat := 1000000

/-- Where a passage starts: chapter, verse and word, the word 0 for a whole verse. -/
def PassageRange.start : PassageRange → Nat × Nat × Nat
  | .verse p => (p.chapter, p.verse, 0)
  | .range r => (r.startChapter, r.startVerse, 0)
  | .part q => (q.verse.chapter, q.verse.verse, q.first)

/-- Where a passage stops: chapter, verse and word, `verseEnd` for a whole verse. -/
def PassageRange.stop : PassageRange → Nat × Nat × Nat
  | .verse p => (p.chapter, p.verse, verseEnd)
  | .range r => (r.endChapter, r.endVerse, verseEnd)
  | .part q => (q.verse.chapter, q.verse.verse, q.last)

/-- Chapter, verse and word, in reading order. -/
def PassageRange.posLe (a b : Nat × Nat × Nat) : Bool :=
  a.1 < b.1 || (a.1 == b.1 && (a.2.1 < b.2.1 || (a.2.1 == b.2.1 && a.2.2 ≤ b.2.2)))

/-- **Whether a passage lies within another**: the same book, starting no earlier and stopping no
later. A verse lies within itself, 3:16 within 3:16–18, and 3:18a within 3:18; 3:18 does not lie
within 3:18a. -/
def PassageRange.within (inner outer : PassageRange) : Bool :=
  inner.book == outer.book && posLe outer.start inner.start && posLe inner.stop outer.stop

/-- **Whether two passages share any of the text.** -/
def PassageRange.overlaps (a b : PassageRange) : Bool :=
  a.book == b.book && posLe a.start b.stop && posLe b.start a.stop

end Testimony
