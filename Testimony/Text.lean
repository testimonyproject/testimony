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
  | psalms | isaiah | jeremiah | ezekiel | daniel
  | hosea | micah | zechariah | malachi
  | matthew | mark | luke | john | acts
  | romans | firstCorinthians | secondCorinthians | galatians | ephesians
  | philippians | colossians | firstThessalonians | secondThessalonians
  | firstTimothy | secondTimothy | titus | philemon | hebrews | james
  | firstPeter | secondPeter | firstJohn | secondJohn | thirdJohn | jude
  | revelation
  -- The New Testament is complete; the Old Testament is still partial.
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

/-- Either a single verse or a contiguous range. Scripture citations quantify
over this, so `Matthew 2:1; Luke 2:4–7` is two `PassageRange` values rather than
one opaque string. -/
inductive PassageRange
  /-- A single verse. -/
  | verse (p : Passage)
  /-- A contiguous range of verses. -/
  | range (r : Pericope)
deriving Repr, DecidableEq

/-- The book a range belongs to. Ranges never span books, by construction. -/
def PassageRange.book : PassageRange → Book
  | .verse p => p.book
  | .range r => r.book

end Testimony
