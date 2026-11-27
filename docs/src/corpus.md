# The Greek text as data

Most claims about a verse in this library are made in English and cited to
whoever makes them. Some are claims about what the original text *contains*:
that a noun has no article, that a word stands before its verb, that a verse has
no word for "other". Those can be checked against the text itself, and the
library now holds the Greek New Testament as data so that they can be.

## Where the words come from

The text is the SBL Greek New Testament, edited by Michael Holmes (2010). The
analysis of each word, its part of speech, its dictionary form, its parsing and
its role in its clause, is MACULA Greek's, Clear Bible's annotation of that text.
Both are licensed CC BY 4.0, and every printed document that cites either
credits it as its licence asks. `scripts/import_greek.py` reads MACULA's word table
and writes one file per book under `data/greek/macula-sblgnt/`, keeping only the
columns the library reads; the README there records the source and its checksum.
So far Matthew, John, Hebrews and the thirteen letters ascribed to Paul are
imported, the books the arguments' questions have needed ([#247][issue]); the
import takes any book.

## What a word looks like

Each word is a `Token` (`Testimony.Corpus.Greek`): where it stands, what it is,
its dictionary form, its parsing, and its role. John 1:1 reads, word by word,
"In beginning was the Word, and the Word was toward the God, and God was the
Word". Its fourteenth word is θεός, "God". The data says that it is a noun in the
nominative, the predicate of its clause, with no article before it, standing
before its verb ἦν, "was". The library checks that from the data itself
(`john1_1_theos`).

What the data does not say is what that construction means. Whether a noun
placed so says *who* the Word is, *what kind* of thing, or that he is "a god", is
the question the readers dispute, and their readings stay cited premises, rated
as readings are.

## The limits of the data

- **The text is one edition.** The SBLGNT is a critical text: where the
  manuscripts differ it prints one reading. A dispute that turns on a variant
  must name it and cite an apparatus.
- **The tagging is an interpretation.** A word's parsing and role are Clear
  Bible's reading of the Greek, usually uncontested and sometimes not. The
  library cites them as theirs, and a dispute over a parsing is argued like any
  other.
- **A role is given only to a word that is a whole constituent.** In John 1:1c,
  θεός ("God") on its own is the predicate and carries the role `p`; the subject is the
  phrase "ὁ λόγος", "the Word", and the word table leaves the role blank on both
  its words, because the role belongs to the phrase.

## A translation, word by word

A translation can be aligned to these words: each English word with the Greek
words it renders, and whether the translator prints it as supplied
(`Testimony.Corpus.Rendering`). What a translation adds or leaves out is then
computed rather than asserted. English needs words Greek does not, so an
addition is not a fault in itself, and the library does not say which additions
were needed. It says which English words have no Greek behind them, and whether
the reader was told.

The first case is Colossians 1:16–17. "For by him all things were created" (ESV):
the Greek has τὰ πάντα, "all things", here and three times more in the two
verses. The New World Translation of the Jehovah's Witnesses (2013) prints "all
other things" each time; its 1984 edition had printed "other" in brackets, as a
supplied word. Aligned word by word, its two verses add "other" four times and
"they are" once, none of them marked; the ESV's add nothing
(`colossians_additions`). Whether the context implies "other", as the Witnesses
hold, is a reading, and stays one. The alignments are the library's own.

## The Hebrew text

Isaiah and Micah are imported from the Hebrew Bible, so far for one use: naming
part of a verse and having the build check that its words are there. The text is
the Westminster Leningrad Codex, a transcription of the Leningrad Codex, the
oldest complete manuscript of the Hebrew Bible, and it is in the public domain.
The parsing is the Open Scriptures Hebrew Bible's, carried in MACULA Hebrew,
Clear Bible's annotation of the codex, both licensed CC BY 4.0.
`scripts/import_hebrew.py` writes one file per book under
`data/hebrew/macula-wlc/` (`Testimony.Corpus.Hebrew`).

Two things differ from the Greek. A written Hebrew word is often several entries
in the table, because "and you" (וְאַתָּה) is a conjunction and a pronoun
written as one word. A part of a verse counts written words. And the Hebrew
numbers some verses differently from English Bibles: what English Bibles call
Micah 5:2, "But you, O Bethlehem Ephrathah" (ESV), is 5:1 in the Hebrew. The
library names verses as English Bibles do, so the build looks each one up in
STEPBible's table of versification traditions (TVTMS, CC BY 4.0) before reading
it. Where the Hebrew joins an English verse to another or splits it, as it
prints English Isaiah 64:1 at the end of its 63:19, the build refuses to name a
part of it.

The words are the Masoretic Text's, as one manuscript has them. Where the
Septuagint or the Dead Sea Scrolls read otherwise, the table gives the Masoretic
reading alone ([#327][hebrew-issue]).

## What comes next

The next steps ([#247][issue]) test grammatical rules, Colwell's, Harner's,
Sharp's and a translator's own, over every place their construction occurs, and
let what the text contains enter a dispute as a premise every party can check.

[issue]: https://github.com/testimonyproject/testimony/issues/247
[hebrew-issue]: https://github.com/testimonyproject/testimony/issues/327
