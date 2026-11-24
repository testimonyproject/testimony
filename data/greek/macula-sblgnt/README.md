# The Greek New Testament, word by word (MACULA Greek, SBLGNT edition)

These files hold books of the Greek New Testament, one word per line, as the
library reads them (`Testimony.Corpus.Greek`). They are written by
`scripts/import_greek.py` from MACULA Greek's word table for the SBLGNT,
`SBLGNT/tsv/macula-greek-SBLGNT.tsv` in [Clear-Bible/macula-greek][macula],
read on 2026-11-16 (SHA-256 of the source table:
`7f71504fdee8659bdd9f85342e4103d645864c2851b8205915bb298f0c004cc5`).

## Columns

| Column | What it holds |
|---|---|
| `ref` | Book, chapter, verse and the word's position in the verse: `JHN 1:1!14` |
| `role` | The word's role in its clause, where the word is a whole constituent: `s` subject, `p` predicate, `o` object, `v` verb, `vc` copula, and others. Blank where the role belongs to a phrase |
| `class` | Part of speech: `noun`, `verb`, `det` (the article), `adj`, `pron`, … |
| `text` | The word as printed in the SBLGNT |
| `lemma` | Its dictionary form |
| `morph` | Its parsing, in Robinson's codes: `N-NSM` is a noun, nominative singular masculine |
| `actor` | For a verb, the dictionary forms of the words MACULA's frame gives as its first argument (`A0`), who or what does what the verb says, joined by `;`. Where that argument is a participle used as a noun ("the one who works"), the word it refers to (`subjref`) stands in its place. Empty where the text names none |
| `actor_ref` | Where those words stand, in the same order: `GAL 2:6!14` |

The tagging is an interpretation, not part of the text: it is Clear Bible's
reading of the Greek, and where a word's parsing or role is disputed the files
give one answer. The library cites it as Clear Bible's.

## Licences and attribution

- **The text**: *The Greek New Testament: SBL Edition*, edited by Michael W.
  Holmes (Society of Biblical Literature and Logos Bible Software, 2010),
  licensed [CC BY 4.0][ccby].
- **The morphology, syntactic roles, semantic frames and participant
  referents** (the last two give `actor`): MACULA Greek Linguistic Datasets,
  © 2022–2024 Biblica, Inc., licensed [CC BY 4.0][ccby].

Only these are kept. MACULA's word senses from the United Bible Societies'
MARBLE project are "used with permission" rather than openly licensed, so the
import drops them, along with the glosses and annotations the library does not
read.

[macula]: https://github.com/Clear-Bible/macula-greek
[ccby]: https://creativecommons.org/licenses/by/4.0/
