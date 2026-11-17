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
Both are licensed CC BY 4.0. `scripts/import_greek.py` reads MACULA's word table
and writes one file per book under `data/greek/macula-sblgnt/`, keeping only the
columns the library reads; the README there records the source and its checksum.
So far John, Colossians, Titus and Hebrews are imported, the books the first
questions need ([#247][issue]); the import takes any book.

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
  θεός on its own is the predicate and carries the role `p`; the subject is the
  phrase "ὁ λόγος", "the Word", and the word table leaves the role blank on both
  its words, because the role belongs to the phrase.

## What it is for

The next steps ([#247][issue]) align a translation to these words, so that what a
rendering adds or leaves out is computed rather than asserted; test grammatical
rules, Colwell's, Harner's, Sharp's and a translator's own, over every place
their construction occurs; and let what the text contains enter a dispute as a
premise every party can check.

[issue]: https://github.com/testimonyproject/testimony/issues/247
