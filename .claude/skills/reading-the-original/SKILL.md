---
name: reading-the-original
description: Use whenever a Testimony claim, docstring or line of reason turns on a Greek or Hebrew word, a verse's wording, a translation's choice, or a place where manuscripts differ — checking the word against the imported Greek and Hebrew data, quoting the English from a preferred translation, adding glossary renderings, naming the reading taken at a variant, and stating what a Latin or English rendering adds or omits. Covers the corpus commands, the glossary, the translation order and the variant checks.
---

# Reading the original

A claim about what a text says is checked against the text. The library carries the Greek New
Testament word by word (MACULA Greek over the SBL Greek New Testament) and books of the Hebrew
Bible (MACULA Hebrew over the Westminster Leningrad Codex), so most claims about wording can be
read from the data at build time rather than asserted. This skill is the order of work whenever
a claim turns on the original.

## 1 — Look the words up, cheaply

The data is one tab-separated file per book, one word per line, keyed `BOOK c:v!n`:

```sh
grep -P '^ROM 3:28!' data/greek/macula-sblgnt/ROM.tsv     # every word of Romans 3:28
grep -P '\tδικαιόω\t' data/greek/macula-sblgnt/JAS.tsv | cut -f1,4,6   # a lemma in a book
ls data/hebrew/                                            # which Hebrew books are imported
```

The columns are the reference, the word's role in its clause, its class, the word as printed,
its dictionary form (lemma), its parsing (Robinson's codes: `V-PPP-NSF` is a present passive
participle), and, for a verb, who acts. Read only the lines you need; never open a whole book
file.

## 2 — Bring the words into the Lean

- `greek_word n from GAL 5 6 "ἐνεργέω"` reads one word from the data at build time, so a claim
  about its voice or its form is checked (`Statement.parses`, and `Statement.misreads` when the
  claim contradicts the parsing).
- `greek_passage n from JHN 1 1 18` reads a short passage as a list of tokens, for results about
  what a passage contains.
- `greek_usage n of "lemma" in Paul` collects an author's use of a word.
- `verse_part n from …` names part of a verse; `#check_verse_parts` reads every part again from
  the Greek or Hebrew and fails if the words do not match.

The parsing and roles are Clear Bible's reading of the Greek and are cited as theirs
(`Testimony.Bib.maculaGreek`). Where a claim disputes a parsing, the dispute is a claim with
readers on both sides, not a correction of the data.

## 3 — Quote the English from a preferred translation

Quote the NET first, else the LSB or the NRSV, else the ESV, else the NIV, verbatim from the
publisher's own text (netbible.org, read.lsbible.org), and name the translation. The KJV appears
only where a cited source quotes it and reasons from it; then the page says it is the KJV's, and
the library answers from the Greek or Hebrew and context.

When the argument turns on a word, say how the translations part. "Declared righteous" (Romans
3:28, NET) and "justified" (James 2:24, NET) render one verb, and a reader of the English alone
cannot see it. Put the original and its English beside each other: δικαιόω ("justify").

## 4 — Gloss every word, with a cited rendering

Every Greek or Hebrew word printed in a docstring, a label or a hand-written page needs its English
beside it, once per section (lint rule L13). The renderings come from
`arguments/TestimonyArguments/Glossary.lean`, each cited to a translation at a verse or to a
lexicon entry (BDAG, LSJ, Muraoka for the Septuagint). A new word goes in the glossary first, with
every rendering the translations give where they differ. A rendering no translation or lexicon
gives is a `propose`, with a rationale, and is a debt to cite later.

Search the glossary rather than reading it:

```sh
grep -n 'gloss "δικαιόω"' -A6 arguments/TestimonyArguments/Glossary.lean
```

## 5 — Name the reading at a place where the copies differ

If the words a claim cites lie inside a known variation unit (`Testimony/Variants/Units.lean`),
the citation must say which reading it takes and which question it needs answered: what the
copies say, what the author wrote, or what a church receives as Scripture. A claim is rated no
higher than the reading it rests on, and a reading graded {C} or {D} by the UBS committee caps it
at `disputed`. `#check_readings` enforces all of this. A new variant goes in as a unit with its
readings and each judgement cited.

## 6 — Check a version against the original

Where an argument rests on a Latin or other version (Trent's Vulgate, the Septuagint), the
version's wording is a claim of its own, about the translation (`Statement.renders`), and its
departure from the Greek or Hebrew is checked, not assumed. `Testimony/Corpus/Rendering.lean`
aligns a translation word by word to the Greek and computes what it adds and omits; use it for
any claim of the form "the Latin adds a word the Greek does not have".

## Checklist

- [ ] Each word checked against the data at its verse, with lemma and parsing.
- [ ] Any claim about form or voice read from the data with `greek_word`, not asserted.
- [ ] English quoted verbatim from a preferred translation, named; no KJV of the library's own.
- [ ] Every Greek and Hebrew word in the glossary, each rendering cited, and glossed on the page.
- [ ] Any variant named, with the reading and question; rating no higher than the reading.
- [ ] Any version's departure from the original stated as a claim, and checked.
