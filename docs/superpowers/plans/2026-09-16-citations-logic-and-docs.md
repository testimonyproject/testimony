# Citations, Logic Layer, and Docs Site — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace free-text citations with typed, publicly checkable bibliography entries; add a propositional logic layer on Foundation so arguments are machine-checked data; derive Sola Fide end to end; and publish a documentation site with enforced conventions.

**Architecture:** Six additions, layered bottom-up. `Testimony.Bib` supplies typed bibliography entries collected into a registry by a `@[bib_entry]` attribute. `Testimony.Provenance` is rewritten so `Source.primary` is a single required `Reference`, making an uncited source unrepresentable. `Testimony.Logic` wraps FormalizedFormalLogic/Foundation's `Formula` with a `Bool`-valued decidability adapter, recovering `decide`-checkable entailment from Foundation's `Prop`-valued Boolean semantics. Argument modules instantiate `ArgumentPackage` over per-argument atom types whose `meta` function is total, so every atom is cited. A `bibgen` executable renders the registry to `references.bib` and a book chapter; four tiers of linting enforce the conventions.

**Tech Stack:** Lean 4.33.1, FormalizedFormalLogic/Foundation (transitively Mathlib, doc-gen4, axiom-audit), mdBook 0.5.4, Python 3 (stdlib only) for the domain linter.

**Spec:** `docs/superpowers/specs/2026-09-16-citations-logic-and-docs-design.md`

## Global Constraints

- Lean toolchain is `leanprover/lean4:v4.33.1`, pinned by Foundation.
- `native_decide` is prohibited. `sorry` is prohibited. `lake exe axiom-audit` enforces both against the allowlist `propext,Classical.choice,Quot.sound`.
- No bibliographic identifier may be written from memory. Verify against a public catalogue; leave a field `none` rather than guess.
- Every declaration carries a docstring (`linter.missingDocs = true`, `docBlameThm` enabled).
- An argument module encoding a Christian reading must encode at least one rival package.
- Atom types carrying a `FiniteAtoms` instance have at most 12 constructors.
- Citation keys match `^[a-z0-9]+(-[a-z0-9]+)*$`, formatted `family-shorttitle-year`.
- Line width at most 100 columns; no trailing whitespace.

---

### Task 1: Foundation interop spike

**Files:**
- Modify: `lean-toolchain`, `lakefile.toml`
- Create (throwaway): `Spike/Probe.lean`

**Interfaces:**
- Produces: confirmation that `FFL.Propositional.Formula` elaborates inside a classic-style (non-module-system) Lean project, and the exact import path for Boolean semantics.

- [ ] **Step 1: Pin toolchain and add the dependency** — `lean-toolchain` to `leanprover/lean4:v4.33.1`; `lakefile.toml` gains a `[[require]]` on Foundation at `master`.
- [ ] **Step 2: `lake update`** then `lake exe cache get` for Mathlib oleans.
- [ ] **Step 3: Probe** — build `Spike/Probe.lean` containing `def probe : Formula Nat := .atom 0 ➝ .atom 0` and `#check @Formula.Boolean.val`.
- [ ] **Step 4: Decide** — if the probe fails on module-system interop, STOP and report; the substrate decision reopens. If it passes, delete `Spike/` and continue.
- [ ] **Step 5: Commit** the toolchain and lakefile change.

### Task 2: Bibliography core types

**Files:**
- Create: `Testimony/Bib/Core.lean`
- Modify: `Testimony/Text.lean` (add `PassageRange`)

**Interfaces:**
- Produces: `Testimony.Bib.{CiteKey, Agent, Contributors, Year, Identifier, WorkCore, BookData, InCollectionData, ArticleData, ThesisData, EditionData, AncientWorkData, DatasetData, WebPageData, BibEntry, Locus}`; accessors `BibEntry.{core, key, isVerifiable, sortKey, editionUsed}`; `Identifier.uri`; `Agent.sortKey`. `Testimony.PassageRange` with `PassageRange.book`.
- Note: `Locus.sectionRef`, not `Locus.section` — `section` is a Lean keyword.

- [ ] **Step 1:** Add `PassageRange` and `PassageRange.book` to `Testimony/Text.lean`.
- [ ] **Step 2:** Write `Testimony/Bib/Core.lean` with all entry types, deriving `Repr, DecidableEq`.
- [ ] **Step 3:** `lake build Testimony.Bib.Core` — expect success.
- [ ] **Step 4:** Commit.

### Task 3: Registry attribute

**Files:**
- Create: `Testimony/Bib/Attr.lean`

**Interfaces:**
- Produces: `@[bib_entry]` tag attribute; `derive_bib_registry <ident>` command generating `def <ident> : List BibEntry`.
- Constraint: `derive_bib_registry` reads the attribute's *local* module state, so it must be invoked in the same module that defines the entries.

- [ ] **Step 1:** Write the attribute and the `elab` command.
- [ ] **Step 2:** Smoke-test in a scratch module: two tagged defs, `derive_bib_registry testRegistry`, `#guard testRegistry.length = 2`.
- [ ] **Step 3:** If the attribute API fights, fall back to a hand-written `registry` list plus a coverage check in `bibgen` (spec §5.4). Record the decision.
- [ ] **Step 4:** Commit.

### Task 4: References and Source rewrite

**Files:**
- Modify: `Testimony/Provenance.lean`, `Testimony/Intertext.lean`, `Testimony/Argument.lean`
- Modify: `Testimony/Arguments/BornInBethlehem.lean`, `Testimony/Arguments/BornOfAVirgin.lean`

**Interfaces:**
- Produces: `ScriptureCitation`, `Reference` (`.work`, `.scripture`), `Reference.{isScripture, entry}`, `Source` (`primary`, `supporting`, `tradition`, `confidence`), `Source.{references, isScriptureOnly, entries}`. `Tradition` gains `reformedProtestant`, `romanCatholic`, `easternOrthodox`.
- Removes: `Source.citation : String`.

- [ ] **Step 1:** Rewrite `Testimony/Provenance.lean`.
- [ ] **Step 2:** `lake build` — expect failures in the two argument files; that is the migration surface.
- [ ] **Step 3:** Migrate both argument files' citations to typed references, temporarily inline pending Task 6's verified entries.
- [ ] **Step 4:** `lake build` — expect success. Commit.

### Task 5: Bibliography rendering and `bibgen`

**Files:**
- Create: `Testimony/Bib/Render.lean`, `Testimony/Bib/Registry.lean`, `Testimony/Tools/Bibgen.lean`
- Modify: `lakefile.toml` (`[[lean_exe]] bibgen`)

**Interfaces:**
- Produces: `Render.toBibtex : BibEntry → String`, `Render.toMarkdown : BibEntry → String`, `Render.bibliographyMarkdown : List BibEntry → String`, `Render.bibtexFile : List BibEntry → String`; `Testimony.Bib.registry : List BibEntry`; `lake exe bibgen [--check]`.
- Entry-type to BibTeX mapping per spec §9.1.

- [ ] **Step 1 (test first):** Write `#guard` golden-string assertions in `Render.lean` for each of the eight entry types, before the renderer.
- [ ] **Step 2:** `lake build` — expect failure (functions undefined).
- [ ] **Step 3:** Implement the renderers until the guards pass.
- [ ] **Step 4:** Write `Registry.lean` with `#guard` for key `Nodup` and `editionUsed` resolution.
- [ ] **Step 5:** Write `Tools/Bibgen.lean` with `--check`; wire `[[lean_exe]]`.
- [ ] **Step 6:** `lake exe bibgen`; commit generated `references.bib` and `docs/src/bibliography.md`.

### Task 6: Verified seed bibliography

**Files:**
- Create: `Testimony/Bib/Works.lean`
- Modify: the two argument files to cite registry entries

**Interfaces:**
- Produces: tagged `BibEntry` defs and `Testimony.Bib.registry` via `derive_bib_registry`.

- [ ] **Step 1: Research pass.** Verify against public catalogues: France *Matthew* (NICNT); Brown *Birth of the Messiah*; Keil & Delitzsch *Minor Prophets*; Motyer *Prophecy of Isaiah*; NA28; UBS5; BHS; ETCBC BHSA; OSHB; Dunn and Wright on the New Perspective; Trent's canons on justification; Benzmüller & Woltzenlogel Paleo. Leave unverifiable fields `none`.
- [ ] **Step 2:** Write the tagged defs; end the module with `derive_bib_registry registry`.
- [ ] **Step 3:** Repoint both argument files at registry entries.
- [ ] **Step 4:** `lake exe bibgen`; `lake build`; commit.

### Task 7: Logic layer

**Files:**
- Create: `Testimony/Logic/Basic.lean`, `Testimony/Logic/Decide.lean`, `Testimony/Logic/Package.lean`

**Interfaces:**
- Produces: `FiniteAtoms` class (`elems`, `complete`); `bval : (α → Bool) → Formula α → Bool`; `bval_iff_val`; `checkEntails`; `entails_of_check`; `not_entails_of_check`; `AtomMeta`; `ArgumentPackage` (`name`, `meta`, `premises`, `conclusion`, `conclusionLabel`); `ArgumentPackage.{manifest, scriptureOnlyAtoms}`; `Establishes`.

- [ ] **Step 1 (test first):** `#guard` assertions pinning `checkEntails` on hand-worked cases — modus ponens valid, affirming the consequent invalid.
- [ ] **Step 2:** Implement `bval`, `FiniteAtoms`, valuation enumeration, `checkEntails` until the guards pass.
- [ ] **Step 3:** Prove `bval_iff_val`, `entails_of_check`, `not_entails_of_check`.
- [ ] **Step 4:** Implement `ArgumentPackage`, `manifest`, `scriptureOnlyAtoms`, `Establishes`.
- [ ] **Step 5:** `lake build`; `lake exe axiom-audit`; commit.

### Task 8: Sola Fide

**Files:**
- Create: `Testimony/Arguments/SolaFide.lean`

**Interfaces:**
- Produces: `Claim` atom type with `DecidableEq`/`FiniteAtoms` instances; `cite : Claim → AtomMeta`; packages `reformed`, `newPerspective`, `tridentine`; theorems `reformed_establishes`, `newPerspective_not_establishes`, `worksOfLaw_is_load_bearing`.

- [ ] **Step 1:** Define `Claim` (at most 12 constructors) with docstrings naming the text and the tradition.
- [ ] **Step 2:** Write `cite` as a total function over verified registry entries.
- [ ] **Step 3:** Build the three packages. Rivals first, per the encoding rule.
- [ ] **Step 4:** Prove the three theorems; tag `@[headline]`; add `#print axioms`.
- [ ] **Step 5:** `lake build`; `lake exe axiom-audit`; commit.

### Task 9: Sola Scriptura seed and messianic migration

**Files:**
- Create: `Testimony/Arguments/SolaScriptura.lean`
- Modify: `Testimony/Argument.lean`, both messianic argument files

**Interfaces:**
- Produces: `SatisfactionWitness`, `Satisfies p c`, `MeetsDefinition p d` (both lose their `PremisePackage` parameter), re-proved `meets_of_subset` and `meets_empty`.

- [ ] **Step 1:** Write `SolaScriptura.lean`: atoms, citations, Protestant and Catholic/Orthodox packages, the self-refutation objection.
- [ ] **Step 2:** Rebuild `Argument.lean` on `Establishes`; re-prove the structural lemmas.
- [ ] **Step 3:** Migrate both messianic argument files onto `ArgumentPackage`.
- [ ] **Step 4:** `lake build`; `lake exe axiom-audit`; commit.

### Task 10: Lint tiers and the `@[headline]` attribute

**Files:**
- Create: `scripts/testimony_lint.py`, `scripts/test_testimony_lint.py`, `Testimony/Attr.lean`
- Modify: `lakefile.toml` (`leanOptions`, `lintDriver`), `.github/workflows/ci.yml`
- Delete: `.github/workflows/lean_action_ci.yml`

**Interfaces:**
- Produces: `@[headline]` tag attribute; `testimony_lint.py` implementing rules L1–L8; a single consolidated CI workflow.

- [ ] **Step 1 (test first):** Write `scripts/test_testimony_lint.py` with a fixture per rule, each asserting the rule fires and that clean input passes.
- [ ] **Step 2:** `python3 scripts/test_testimony_lint.py` — expect failure.
- [ ] **Step 3:** Implement `testimony_lint.py` until tests pass.
- [ ] **Step 4:** Add `@[headline]` in `Testimony/Attr.lean`; tag the headline theorems.
- [ ] **Step 5:** Add `leanOptions` and `lintDriver` to `lakefile.toml`; run all four tiers.
- [ ] **Step 6:** Consolidate CI into one workflow running all four tiers plus `bibgen --check`. Commit.

### Task 11: Documentation site

**Files:**
- Create: `docs/book.toml`, `docs/src/SUMMARY.md` and chapters, `.github/workflows/docs.yml`, `CLAUDE.md`, `.claude/skills/{adding-a-citation,encoding-an-argument,checking-the-build}/SKILL.md`, `.claude/settings.json` hook
- Modify: `README.md`, `DESIGN.md`, `CONTRIBUTING.md`
- Delete: `docs/superpowers/specs/2026-09-16-citations-logic-and-docs-design.md`, this plan

**Interfaces:**
- Produces: a book that builds under `mdbook build docs`, with `bibliography.md` generated by `bibgen`.

- [ ] **Step 1:** `book.toml` and `SUMMARY.md`.
- [ ] **Step 2:** Write the chapters: introduction, rationale, scope-and-limits, architecture, logic, citations, style-guide, roadmap, contributing.
- [ ] **Step 3:** `mdbook build docs` — expect success.
- [ ] **Step 4:** `docs.yml` building book plus doc-gen4 API docs, deploying to Pages.
- [ ] **Step 5:** Write `CLAUDE.md` and the three skills, documenting conventions as built.
- [ ] **Step 6:** Update README/DESIGN/CONTRIBUTING to point into the book.
- [ ] **Step 7:** Migrate any spec detail not yet captured in the book, then delete the spec and this plan. Commit.
