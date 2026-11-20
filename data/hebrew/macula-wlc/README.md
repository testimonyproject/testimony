# The Hebrew Bible, word by word (MACULA Hebrew, Westminster Leningrad Codex)

These files hold books of the Hebrew Bible, one row per word or part of a word,
as the library reads them (`Testimony.Corpus.Table`, `Testimony.Corpus.Hebrew`).
They are written by `scripts/import_hebrew.py` from MACULA Hebrew's word table,
`WLC/tsv/macula-hebrew.tsv` in [Clear-Bible/macula-hebrew][macula], at revision
`47db250bd55d0d8577f2a94fba114ef16c35b23c`, read on 2026-11-20 (SHA-256 of the
source table:
`965cb0599beed2fe31283b615bcc369178141c0e718a66d97518d94309cfc124`).

So far Isaiah (`ISA.tsv`) and Micah (`MIC.tsv`) are imported. The import takes
any book.

## Columns

| Column | What it holds |
|---|---|
| `ref` | Book, chapter, verse and the written word's position in the verse, as the Hebrew numbers them: `MIC 5:1!4` |
| `role` | Empty: MACULA Hebrew's word table gives no role |
| `class` | Part of speech: `noun`, `verb`, `prep`, `cj`, `art`, `pron`, … |
| `text` | The word or part of a word as the codex prints it, with its points and accents |
| `lemma` | Its dictionary form |
| `morph` | Its parsing, in the Open Scriptures Hebrew Bible's codes: `Ncfsa` is a common noun, feminine singular absolute |

A written word with a prefix or suffix is more than one row at one position:
"and you" (וְאַתָּה) is the conjunction and the pronoun. The parsing is an
interpretation, the Open Scriptures Hebrew Bible's, and the library cites it as
theirs.

## Verse numbers

`versification.tsv` lists every verse of the imported books that English Bibles
number differently from the Hebrew, with the Hebrew verse it is (`MIC 5:2` →
`MIC 5:1`), or `-` where the Hebrew does not hold it as one whole verse. It is
written from the "English KJV" and "Hebrew" columns of STEPBible's TVTMS,
`Versification/TVTMS - Translators Versification Traditions with Methodology for
Standardisation for Eng+Heb+Lat+Grk+Others - STEPBible.org CC BY.txt` in
[STEPBible/STEPBible-Data][step], at revision
`5de0a47f35f0fc13dfe1430d104e5db8a4285f9c` (SHA-256:
`c42cdfec1ae82d3e0c7e2f6a89d73bbed28ede4cf3fe18d5582626881e8d5c78`). A verse not
listed is numbered alike in both.

## Licences and attribution

- **The text**: the Westminster Leningrad Codex, by the J. Alan Groves Center
  for Advanced Biblical Research, in the public domain.
- **The morphology**: the Open Scriptures Hebrew Bible, licensed
  [CC BY 4.0][ccby].
- **The word table**: MACULA Hebrew Linguistic Datasets, © 2022–2024 Biblica,
  Inc., licensed [CC BY 4.0][ccby], available at
  https://github.com/Clear-Bible/macula-hebrew/.
- **The verse numbering**: TVTMS, data created by STEPBible.org based on work at
  Tyndale House Cambridge, licensed [CC BY 4.0][ccby].

Only these are kept. MACULA's semantic domains and word senses from the United
Bible Societies' Semantic Dictionary of Biblical Hebrew are "used with
permission" rather than openly licensed, so the import drops them, along with
the glosses, Greek equivalents and annotations the library does not read.

[macula]: https://github.com/Clear-Bible/macula-hebrew
[step]: https://github.com/STEPBible/STEPBible-Data
[ccby]: https://creativecommons.org/licenses/by/4.0/
