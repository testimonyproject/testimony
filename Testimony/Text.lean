/-!
# Testimony.Text — Layer 1: Text & canon

Typed references into the biblical corpus. A `Passage` is a *reference*, not
the text itself; resolution against real corpus data (OSHB/STEPBible
identifiers) arrives in Phase 3.
-/

namespace Testimony

/-- A book of the biblical corpus. Extend as needed; the canon a book belongs
to is a separate question (see `Canon`). -/
inductive Book
  | genesis | exodus | leviticus | numbers | deuteronomy
  | psalms | isaiah | jeremiah | ezekiel | daniel
  | hosea | micah | zechariah | malachi
  | matthew | mark | luke | john | acts
  | romans | firstCorinthians | galatians | hebrews | revelation
  -- …to be completed to the full corpus
deriving Repr, DecidableEq

/-- Canonical boundaries differ by tradition. Results are always relative to a
declared canon. -/
inductive Canon
  | protestant | catholic | orthodox | ethiopian | tanakh
deriving Repr, DecidableEq

/-- Language of a textual witness. -/
inductive Language
  | hebrew | aramaic | greek
deriving Repr, DecidableEq

/-- Textual tradition a reading is drawn from. -/
inductive TextualTradition
  | masoretic | septuagint | deadSeaScrolls | naZarene28  -- NA28
  | vulgate | peshitta
deriving Repr, DecidableEq

/-- A verse-level reference: book, chapter, verse. -/
structure Passage where
  book : Book
  chapter : Nat
  verse : Nat
deriving Repr, DecidableEq

/-- A contiguous range of verses within one book. -/
structure Pericope where
  book : Book
  startChapter : Nat
  startVerse : Nat
  endChapter : Nat
  endVerse : Nat
deriving Repr, DecidableEq

end Testimony
