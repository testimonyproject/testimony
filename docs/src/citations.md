# Citations

Every claim in this library carries a citation, and the citation is a typed
value rather than a string. The point is that a reader can *check* it.

## The binding rule

> **No bibliographic identifier is ever written from memory.**
>
> Verify every ISBN, DOI, edition statement, publisher and page range against a
> public catalogue before committing it. If a field cannot be verified, leave
> it `none`.

An entry with no identifier renders in the [bibliography](./bibliography.md) as
*(no public identifier)*. That is the rule working, not failing: five of the
fourteen seed entries carry no identifier, because none could be tied to a
specific printing. A plausible-looking wrong ISBN is far worse than an honest
gap, because it survives review — it looks exactly like a right one.

Useful catalogues: [Open Library](https://openlibrary.org) (`/search.json`,
`/isbn/{isbn}.json`) and [Crossref](https://api.crossref.org) for DOIs.

## Entry types

| Constructor | Use for |
|---|---|
| `book` | Monographs and commentaries |
| `inCollection` | Chapters, essays, conference papers, lexicon entries |
| `article` | Journal articles |
| `thesis` | Dissertations |
| `criticalEdition` | NA28, BHS, UBS5 — cited by siglum and apparatus, not page |
| `ancientWork` | Ancient texts, cited *through* a modern edition via `editionUsed` |
| `dataset` | BHSA, OSHB, STEPBible — carry `version` and `commit` |
| `webPage` | Online resources |

Two distinctions that are easy to get wrong:

**`criticalEdition` versus `book`.** A critical edition has editors rather than
authors, and is cited by siglum (`NA28`) and apparatus location rather than by
page. If you would cite it as "NA28 at Matt 1:23", it is a `criticalEdition`.

**`ancientWork` versus its modern edition.** Scholarly practice cites Josephus,
*Ant.* 18.63, *in* a named Loeb volume. Encode the ancient work with
`editionUsed` pointing at the modern edition's key; the registry checks the
reference resolves.

## Adding an entry

1. **Verify** against a public catalogue. Leave unverifiable fields `none`.
2. **Add a tagged definition** to `Testimony/Bib/Works.lean`. The tag is what
   puts it in the registry; an untagged entry is invisible to `bibgen` and
   linter rule L4 rejects it.

   ```lean
   /-- Why this work is cited here. -/
   @[bib_entry] def mooRomans : BibEntry := .book
     { core :=
         { key := "moo-romans-2018"
         , contributors := { authors := [.person "Douglas J." "Moo"] }
         , title := "The Letter to the Romans"
         , year := some { value := 2018 }
         , identifiers := [.isbn "9780802871268"] }
     , publisher := "Wm. B. Eerdmans"
     , place := some "Grand Rapids"
     , edition := some "2nd edition"
     , series := some "New International Commentary on the New Testament" }
   ```

   Citation keys are `family-shorttitle-year`, lowercase, hyphen-separated.
   Rule L7 and a compile-time `#guard` both check the format. The key is also
   the entry's anchor in the generated bibliography, so it is what every
   citation on an [argument page](./arguments/sola-scriptura.md) links to —
   `bibliography.md#moo-romans-2018` lands a reader on the entry.

3. **Cite it** from a `Source`, with a pinpoint:

   ```lean
   source :=
     { primary := .work mooRomans (.adLoc ⟨.romans, 3, 28⟩)
     , tradition := .reformedProtestant
     , confidence := .wellSupported }
   ```

4. **Regenerate and commit** both generated files:

   ```sh
   lake exe bibgen
   git add references.bib docs/src/bibliography.md
   ```

   CI runs `lake exe bibgen --check` and fails if they are stale.

## Pinpoints

`Locus` says where in a work:

| Constructor | Renders as |
|---|---|
| `whole` | the work as a whole |
| `page` / `pages` / `pageList` | page references |
| `sectionRef` | canonical divisions — `"Ant. 18.63"`, `"III.xi.19"` |
| `adLoc` | commentary on a passage — the `ad loc.` of commentary citation |
| `apparatus` | the critical apparatus at a passage |
| `sv` | a lexicon headword — `s.v.` |

(`sectionRef` rather than `section`, because `section` is a Lean keyword.)

## Scripture is not a bibliography entry

Scripture citations use a separate `Reference` constructor over typed passages:

```lean
primary := .scripture
  [ { ref := .verse ⟨.matthew, 2, 1⟩ }
  , { ref := .range ⟨.luke, 2, 4, 2, 7⟩ } ]
```

This is not a stylistic choice. It makes citations traversable — "what cites
Isaiah 7:14?" is answerable — and it makes `Source.isScriptureOnly` computable,
which is how the library surfaces circularity. See
[Scope and limits](./scope-and-limits.md#circularity-specifically).

## Generated outputs

`lake exe bibgen` writes two files from the Lean source, both committed:

- `references.bib` — biblatex-flavoured, for Zotero, pandoc and LaTeX
- `docs/src/bibliography.md` — the bibliography chapter of this book, each
  entry carrying an anchor named after its cite key

Neither is edited by hand. `lake exe bibgen --check` verifies they match.

Entry types map onto BibTeX as follows. If you add a variant to `BibEntry`,
extend `Testimony/Bib/Render.lean` and add a golden test for it.

| `BibEntry` | BibTeX |
|---|---|
| `book` | `@book` |
| `inCollection` | `@incollection` |
| `article` | `@article` |
| `thesis` | `@phdthesis` / `@mastersthesis`, by `kind` |
| `criticalEdition` | `@book`, siglum in `note` |
| `ancientWork` | `@misc`, `crossref` to `editionUsed` |
| `dataset` | `@misc` with `version` |
| `webPage` | `@online` |
