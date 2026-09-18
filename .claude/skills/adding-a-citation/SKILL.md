---
name: adding-a-citation
description: Use when adding a bibliography entry to the Testimony library, citing a new work in a premise or argument, or when a citation needs verifying against a public catalogue. Covers entry-type choice, the @[bib_entry] registry, and regenerating references.bib.
---

# Adding a citation

## The rule that matters

**No bibliographic identifier is ever written from memory.** Not ISBNs, not
DOIs, not edition statements, not page ranges. A wrong-but-plausible ISBN
survives review indefinitely because it looks exactly like a right one. An
honest gap does not.

If a field cannot be verified, it is `none`. Five of the fourteen seed entries
carry no identifier. That is the rule working.

## Step 1 — verify

```sh
# Open Library search
curl -s "https://openlibrary.org/search.json?q=TITLE+AUTHOR\
&fields=title,author_name,publisher,publish_date,isbn&limit=3"

# Crossref, for anything with a DOI
curl -s "https://api.crossref.org/works?query.bibliographic=TITLE&rows=3"
```

Record only what the catalogue returns. If the catalogue lists several
printings and cannot tie an ISBN to the one you mean, leave `identifiers`
empty and say so in `note`.

## Step 2 — choose the entry type

| Use | When |
|---|---|
| `book` | Monograph or commentary |
| `inCollection` | Chapter, essay, conference paper, lexicon entry |
| `article` | Journal article |
| `criticalEdition` | NA28, BHS, UBS5 — has editors not authors, cited by siglum and apparatus |
| `ancientWork` | Ancient text — set `editionUsed` to the modern edition's key |
| `dataset` | BHSA, OSHB — must carry `version` or `commit` |

The two confusable cases: if you would cite it as "NA28 at Matt 1:23" it is a
`criticalEdition`, not a `book`. If you would cite it as "Josephus, *Ant.*
18.63, in the Loeb edition", the ancient work is the entry and the Loeb is
`editionUsed`.

## Step 3 — add it to `Testimony/Bib/Works.lean`

It must go in that file: `derive_bib_registry` at the bottom reads the
attribute's *local module state*.

```lean
/-- Why this work is cited in this library. -/
@[bib_entry] def mooRomans : BibEntry := .book
  { core :=
      { key := "moo-romans-2018"
      , contributors := { authors := [.person "Douglas J." "Moo"] }
      , title := "The Letter to the Romans"
      , year := some { value := 2018 }
      , identifiers := [.isbn "9780802871268"] }
  , publisher := "Wm. B. Eerdmans"
  , place := some "Grand Rapids"
  , series := some "New International Commentary on the New Testament" }
```

- `@[bib_entry]` is required. Without it the entry is invisible to `bibgen`;
  linter rule L4 rejects it.
- Keys are `family-shorttitle-year`, lowercase and hyphenated. Rule L7 and a
  compile-time `#guard` both check this.
- The docstring is required (`linter.missingDocs`) and should say why the work
  is cited here, not restate its title.

## Step 4 — cite it

```lean
source :=
  { primary := .work mooRomans (.adLoc ⟨.romans, 3, 28⟩)
  , tradition := .reformedProtestant
  , confidence := .wellSupported }
```

Pinpoints: `adLoc` for commentary on a passage, `apparatus` for a critical
apparatus, `sv` for a lexicon headword, `sectionRef` for canonical divisions
(`"III.xi.19"`), `pages`, or `whole`.

**Scripture is not a bibliography entry.** Use the other constructor:

```lean
primary := .scripture [ { ref := .verse ⟨.romans, 3, 28⟩ } ]
```

A premise whose references are *all* scripture is flagged by
`Source.isScriptureOnly` and appears in the argument's `scriptureOnlyAtoms`.
That is intended; do not work around it by attaching an irrelevant commentary.

## Step 5 — regenerate and verify

```sh
lake exe bibgen
lake build
python3 scripts/testimony_lint.py
git add references.bib docs/src/bibliography.md Testimony/Bib/Works.lean
```

Never hand-edit `references.bib` or `docs/src/bibliography.md`. CI runs
`lake exe bibgen --check`.
