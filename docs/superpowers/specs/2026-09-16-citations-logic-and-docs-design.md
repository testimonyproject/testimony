# Design: bibliography-grade citations, a propositional logic layer, and a docs site

Date: 2026-09-16
Status: approved for planning

## 1. Context

Testimony currently has six declared layers, two seeded arguments (Bethlehem,
Virgin Birth), and a `Source` type whose entire bibliographic content is one
free-text field:

```lean
structure Source where
  citation : String        -- "Keil & Delitzsch, Commentary on Micah, ad loc."
  tradition : Tradition
  confidence : Confidence
```

Two gaps block public consumption.

**Citations are not checkable.** `"NA28 marginal cross-reference; UBS5 index of
quotations"` cannot be resolved, exported to a reference manager, or verified by
a reader. A project whose credibility rests on "every premise carries a source"
cannot have sources that are prose.

**Nothing actually reasons yet.** `Testimony/Provenance.lean` documents `Premise`
as carrying a proposition — *"The `holds` proposition is what theorems
hypothesise"* — but the structure has no such field. Consequently `Satisfies` in
`Testimony/Argument.lean` bottoms out in the placeholder `pkg.premises ≠ []`.
The library models the *shape* of arguments without deriving anything from them,
and the assumption manifest promised in README.md has no implementation.

This design closes both gaps and adds the documentation surface that makes the
project legible to outside contributors.

## 2. Goals

1. Every citation in the library is a structured, typed value carrying a stable
   public identifier wherever one exists, exportable to BibTeX.
2. An uncited premise, and an uncited atomic proposition, fail to compile.
3. Arguments are data that can be mechanically checked for validity, contrasted
   against rival premise packages, and reduced to a generated assumption
   manifest.
4. Sola Fide is derived end to end, with its rivals encoded to the same standard.
5. A published documentation site explains the rationale, the limits, and the
   roadmap.
6. No hidden assumption can enter the trust base without CI failing.
7. Every convention in this design is machine-enforced, and contributors —
   human or agent — are told which command enforces which rule.

## 3. Non-goals

- Proving any theological claim unconditionally. Every result stays of the form
  *given premise package P, conclusion C follows*.
- Modal logic, philosophical-theology arguments, and confessional axiom sets for
  systematic theology. These are documented in the roadmap as future work only.
- Corpus grounding (Phase 3): `Passage` values still do not resolve against real
  text data.
- The probabilistic/evidential layer.
- Completing `Book` to the full canon.

## 4. Dependency and toolchain changes

The project takes its first dependencies. This is a deliberate, costly choice
made in favour of a battle-tested logic substrate and future modal-logic
capability.

| | before | after |
|---|---|---|
| `lean-toolchain` | `leanprover/lean4:v4.34.0` | `leanprover/lean4:v4.33.1` |
| dependencies | none | `FormalizedFormalLogic/Foundation` |
| transitive | — | Mathlib, doc-gen4, axiom-audit |
| CI | `lake build` | `lake exe cache get`, `lake build`, `lake exe runLinter`, `lake exe axiom-audit`, `lake exe bibgen --check`, `testimony_lint.py` |

Foundation pins `v4.33.1` and requires Mathlib, doc-gen4 and axiom-audit at the
same revision. The toolchain downgrade is forced by that pin; the existing
Testimony code is simple enough that no v4.34-specific features are in use.

Two consequences are treated as benefits rather than accidents:

- **doc-gen4 arrives transitively**, so generated API documentation costs a build
  step rather than a new dependency, and is included in the docs site.
- **axiom-audit arrives transitively.** It inspects the kernel environment rather
  than source text, failing CI when any declaration transitively depends on an
  axiom outside an allowlist — catching `sorry` (as `sorryAx`), `native_decide`
  (as `Lean.ofReduceBool`), and hand-rolled axioms reaching in through imports.
  For this library that is not a lint but a core guarantee, and it is wired into
  CI as a required gate with the default allowlist
  (`propext`, `Classical.choice`, `Quot.sound`).

**`native_decide` is prohibited.** It adds `Lean.ofReduceBool` to the trust base.
A project whose thesis is that every assumption is declared cannot rest results
on an undeclared one. axiom-audit enforces this mechanically.

## 5. Layer A — Bibliography (`Testimony/Bib/`)

### 5.1 Entry types

Bibliographic data is Lean-native and typed. `BibEntry` is an inductive over
eight entry types, each wrapping a shared `WorkCore`:

```lean
abbrev CiteKey := String

inductive Agent where
  | person (given family : String) (suffix : Option String := none)
  | corporate (name : String)

structure Contributors where
  authors     : List Agent := []
  editors     : List Agent := []
  translators : List Agent := []

structure Year where
  value       : Int          -- negative denotes BCE
  approximate : Bool := false

inductive Identifier where
  | doi      (s : String)
  | isbn     (s : String)
  | issn     (s : String)
  | oclc     (s : String)
  | url      (s : String) (accessed : Option String := none)   -- ISO-8601
  | archived (s : String)

structure WorkCore where
  key          : CiteKey
  contributors : Contributors
  title        : String
  subtitle     : Option String := none
  year         : Option Year := none
  identifiers  : List Identifier := []
  note         : Option String := none

inductive BibEntry where
  | book            (d : BookData)
  | inCollection    (d : InCollectionData)
  | article         (d : ArticleData)
  | thesis          (d : ThesisData)
  | criticalEdition (d : EditionData)
  | ancientWork     (d : AncientWorkData)
  | dataset         (d : DatasetData)
  | webPage         (d : WebPageData)
```

Per-variant data structures carry the fields that variant needs:

- `BookData` — publisher, place, edition, series, seriesNumber, volume,
  totalVolumes.
- `InCollectionData` — containerTitle, containerEditors, publisher, place,
  edition, pages. `core.title` is the chapter title.
- `ArticleData` — journal, volume, issue, pages.
- `ThesisData` — kind (`"PhD diss."`, `"MA thesis"`), institution.
- `EditionData` — publisher, place, edition, siglum (`"NA28"`). Critical editions
  are cited by siglum and apparatus, not by page, and so are typed separately.
- `AncientWorkData` — originalTitle, composed, `editionUsed : Option CiteKey`.
  Scholarly practice cites an ancient work *through* a modern edition (Josephus,
  *Ant.* 18.63, in a named Loeb volume). The link is by key rather than by value
  to keep `BibEntry` non-recursive.
- `DatasetData` — version, commit, license, maintainer. Linguistic data
  (BHSA, OSHB, STEPBible) is citable evidence and needs reproducible versioning.
- `WebPageData` — site.

All derive `Repr`, `DecidableEq`, and `Inhabited` where derivable.
`BibEntry.core` and `BibEntry.key` are total accessors.

### 5.2 Rationale for structured names and identifiers

Names are structured (`person given family suffix` / `corporate name`) rather
than strings so renderers can produce any citation style, and so corporate
authors (Deutsche Bibelgesellschaft, United Bible Societies) are representable.
Editors and translators are separate lists because critical editions and
translated commentaries — Keil & Delitzsch, trans. James Martin — cannot be
rendered correctly without them.

`Identifier` is the mechanism that makes a reference *publicly checkable*. An
entry with an empty identifier list is legal but renders in the bibliography
marked as unverified, so the gap is visible rather than silent.

### 5.3 Locus

```lean
inductive Locus where
  | whole
  | page      (n : Nat)
  | pages     (start finish : Nat)
  | pageList  (ns : List Nat)
  | section   (s : String)        -- canonical divisions, e.g. "Ant. 18.63"
  | adLoc     (p : Passage)       -- commentary on a passage
  | apparatus (p : Passage)       -- critical apparatus at a passage
  | sv        (headword : String) -- lexicon entries, e.g. s.v. עלמה
```

`sv` is included from the start: the almah/parthenos dispute is already load
bearing in `BornOfAVirgin`, and lexicon citations (BDB, HALOT, TDNT) will be
needed the moment it is encoded properly.

`Locus` references `Passage`, so `Testimony/Bib/Core.lean` imports
`Testimony.Text`. No cycle results: `Text` imports nothing from `Bib`.

### 5.4 Registry

Entries are defined as named `def`s in `Testimony/Bib/Works.lean` and tagged
`@[bib_entry]`. An environment extension collects them; a command in
`Testimony/Bib/Registry.lean` (which imports `Works.lean`) materialises
`Testimony.Bib.registry : List BibEntry`. Collection rather than hand-maintenance
makes registry desync impossible.

`#guard` checks in `Registry.lean`:

1. `registry.map BibEntry.key` is `Nodup`.
2. Every `AncientWorkData.editionUsed` key resolves within `registry`.

**Fallback if the attribute fights the Lean 4.33 API:** a hand-written `registry`
list plus a coverage check inside `bibgen` that parses `Works.lean` for
`def NAME : BibEntry` and compares against `registry`. This is strictly worse and
is to be adopted only after a timeboxed attempt at the attribute, with the
decision recorded in the implementation notes.

## 6. Layer B — References and `Source` (`Testimony/Provenance.lean`)

```lean
inductive PassageRange where       -- added to Testimony/Text.lean
  | verse (p : Passage)
  | range (r : Pericope)

structure ScriptureCitation where
  ref       : PassageRange
  tradition : Option TextualTradition := none

inductive Reference where
  | work      (entry : BibEntry) (locus : Locus := .whole)
  | scripture (refs : List ScriptureCitation)

structure Source where
  primary    : Reference
  supporting : List Reference := []
  tradition  : Tradition
  confidence : Confidence

def Source.references (s : Source) : List Reference := s.primary :: s.supporting
def Source.isScriptureOnly (s : Source) : Bool
```

Two decisions carry weight here.

**`primary` is a single required `Reference`, not a list.** CONTRIBUTING.md's
rule that uncited premises do not merge becomes a property the elaborator
enforces, with no validity predicate to invoke and no proof obligation at call
sites. An uncited `Source` is unrepresentable.

**Scripture is a distinct constructor, not an ancient-work entry.** It reuses the
typed `Passage`/`Pericope` vocabulary, which makes scripture citations
traversable — "what cites Isaiah 7:14?" becomes answerable — and, more
importantly, makes `Source.isScriptureOnly` computable. A premise grounded only
in scripture is epistemically different from one grounded in scholarship, and for
a project arguing from scripture the ability to mechanically surface that
distinction is a defence against circularity, not a convenience.

`citation : String` is **deleted**, with no deprecated field and no `.raw`
escape-hatch constructor. The codebase is two argument files; a clean break costs
less than the hatch would, and an escape hatch would be used.

## 7. Layer C — Logic (`Testimony/Logic/`)

### 7.1 Substrate and the decidability adapter

Foundation supplies the formula type, the Hilbert systems, the Boolean and Kripke
semantics, and the metatheory. Testimony does not reimplement any of it.

Foundation's Boolean valuations are `Prop`-valued:

```lean
abbrev Boolean.Valuation (α : Type*) := α → Prop     -- Foundation
def val (v : Valuation α) : Formula α → Prop
```

Entailment against them is therefore not decidable, so `by decide` is
unavailable and refutations require hand-built countermodels. `Testimony.Logic`
adds a thin adapter that recovers decidability without abandoning the substrate:

```lean
def bval (v : α → Bool) : Formula α → Bool

theorem bval_iff_val (v : α → Bool) (φ : Formula α) :
    bval v φ = true ↔ Formula.Boolean.val (fun a => v a = true) φ

class FiniteAtoms (α : Type) where
  elems    : List α
  complete : ∀ a, a ∈ elems

def checkEntails [DecidableEq α] [FiniteAtoms α]
    (prems : List (Formula α)) (concl : Formula α) : Bool

theorem entails_of_check [DecidableEq α] [FiniteAtoms α]
    {prems : List (Formula α)} {concl : Formula α} :
    checkEntails prems concl = true →
    ∀ v : Boolean.Valuation α, (∀ φ ∈ prems, v ⊧ φ) → v ⊧ concl

theorem not_entails_of_check [DecidableEq α] [FiniteAtoms α]
    {prems : List (Formula α)} {concl : Formula α} :
    checkEntails prems concl = false →
    ¬ (∀ v : Boolean.Valuation α, (∀ φ ∈ prems, v ⊧ φ) → v ⊧ concl)
```

Bridging `Bool`-valued enumeration to arbitrary `Prop`-valued valuations uses
`Classical.propDecidable`; `Classical.choice` and `propext` are inside the
axiom-audit allowlist, so this does not widen the declared trust base.

`not_entails_of_check` is the reason the adapter is worth building. It turns
"this premise package does *not* establish its conclusion" into a machine-checked
result rather than a manual construction, which is what makes rival packages
comparable at all.

Mathlib's `tauto` remains available for goals where enumeration is awkward.

### 7.2 Argument packages and generated manifests

```lean
structure AtomMeta where
  label  : String
  kind   : PremiseKind
  source : Source

structure ArgumentPackage (α : Type) [DecidableEq α] [FiniteAtoms α] where
  name            : String
  meta            : α → AtomMeta   -- total: every atom is cited
  premises        : List (Formula α)
  conclusion      : Formula α
  conclusionLabel : String         -- ties the conclusion to a named criterion

def ArgumentPackage.manifest            : List AtomMeta
def ArgumentPackage.scriptureOnlyAtoms  : List AtomMeta
def Establishes (pkg : ArgumentPackage α) : Prop :=
  ∀ v : Boolean.Valuation α, (∀ φ ∈ pkg.premises, v ⊧ φ) → v ⊧ pkg.conclusion
```

`meta` being a **total function** is the second structural enforcement of the
citation rule: an atomic proposition without a citation fails to compile, exactly
as an uncited `Source` does one layer up.

`manifest` is the atoms occurring in `premises`, deduplicated and mapped through
`meta`. This is the assumption manifest README.md promises, generated rather than
maintained. `scriptureOnlyAtoms` filters it by `Source.isScriptureOnly`,
surfacing the circularity exposure of a package directly.

### 7.3 Atom budget

`checkEntails` enumerates `2^n` valuations. Arguments are held to **at most 12
atoms** (4096 valuations), which kernel reduction handles. Exceeding the budget
is a signal to decompose the argument, not to reach for `native_decide` — which
axiom-audit would reject anyway.

## 8. Layer D — Arguments

### 8.1 `Testimony/Arguments/SolaFide.lean` (complete)

A `Claim` inductive of cited atoms covering the Pauline corpus texts
(Eph 2:8–9, Rom 3:28, Gal 2:16, Rom 4:4–5, Titus 3:5), the hermeneutical
premises (scripture's non-contradiction; the compatibility of Jas 2:24), and the
contested lexical premise that Paul's "works of the law" denotes works in general
rather than Jewish boundary markers.

Three packages, each with full citations:

- `reformed` — the classical Protestant reading.
- `newPerspective` — Dunn and Wright on ἔργα νόμου as boundary markers.
- `tridentine` — the Council of Trent's canons on justification.

Results:

- `reformed_establishes : Establishes reformed`
- `newPerspective_not_establishes : ¬ Establishes newPerspective`
- `worksOfLaw_is_load_bearing` — removing the lexical premise from `reformed`
  destroys the entailment.

The third result is the point of the exercise. It identifies mechanically which
single premise the Reformation debate turns on, and it is a result the project
can state honestly regardless of which side the reader takes.

Each headline theorem is accompanied by `#print axioms`.

### 8.2 `Testimony/Arguments/SolaScriptura.lean` (seeded)

Premises for the sufficiency, perspicuity and necessity of scripture; the
conclusion that scripture is the sole infallible rule of faith; the Catholic and
Orthodox rival placing tradition and magisterium alongside it; and the
self-refutation objection (that sola scriptura is not itself taught by
scripture) encoded as a formal challenge. Under the project's honesty rule the
objection is not optional.

Seeded means: types, atoms, citations and packages are complete and compile;
the full set of derivations is left to a follow-up.

### 8.3 Migration of existing arguments

`BornInBethlehem` and `BornOfAVirgin` move onto the logic layer, and their
prose citations become typed references. `Testimony/Argument.lean` is rebuilt so
`Satisfies` is grounded in `Establishes` rather than `pkg.premises ≠ []`:

```lean
structure SatisfactionWitness (p : Person) (c : FulfillmentCriterion) where
  α          : Type
  decEq      : DecidableEq α
  finite     : FiniteAtoms α
  pkg        : ArgumentPackage α
  valid      : Establishes pkg
  concludes  : pkg.conclusionLabel = c.name

def Satisfies (p : Person) (c : FulfillmentCriterion) : Prop :=
  Nonempty (SatisfactionWitness p c)
```

`Satisfies` loses its `pkg` parameter, since the witness now carries its own
package, so `MeetsDefinition` loses it too:

```lean
def MeetsDefinition (p : Person) (d : MessiahDefinition) : Prop :=
  ∀ c ∈ d.criteria, Satisfies p c
```

The existing structural lemmas `meets_of_subset` and `meets_empty` survive
unchanged in substance and are re-proved against the new signature; both are
statements about criteria lists and do not touch the package.

The `α : Type` field places `SatisfactionWitness` in `Type 1`, which is
acceptable. **Fallback if universe handling proves awkward:** instantiate
`Satisfies` per argument file against a concrete atom type, keeping
`MeetsDefinition` and the two structural lemmas as above.

Migrating rather than leaving the messianic arguments alone avoids two competing
notions of "premise package" in a library young enough to still fix it cheaply.

## 9. Layer E — Tooling

### 9.1 `lake exe bibgen`

A `lean_exe` rooted at `Testimony.Tools.Bibgen` with `supportInterpreter = true`.
Rendering lives in `Testimony/Bib/Render.lean` as pure functions.

Outputs, both committed:

- `references.bib` — biblatex-flavoured BibTeX.
- `docs/src/bibliography.md` — sorted by author family, identifiers as live
  links, entries lacking identifiers marked unverified.

`bibgen --check` regenerates into memory, compares against the committed files,
and exits non-zero on drift, so adding an entry without regenerating fails CI.

Entry-type mapping:

| `BibEntry` | BibTeX |
|---|---|
| `book` | `@book` |
| `inCollection` | `@incollection` |
| `article` | `@article` |
| `thesis` | `@phdthesis` / `@mastersthesis` by `kind` |
| `criticalEdition` | `@book` with `note = {siglum}` |
| `ancientWork` | `@misc`, `crossref` to `editionUsed` when present |
| `dataset` | `@misc` with `version`, `howpublished` |
| `webPage` | `@online` |

### 9.2 CI

`.github/workflows/ci.yml` and `.github/workflows/lean_action_ci.yml` currently
duplicate each other. They are replaced by a single `ci.yml`:

1. install elan, cache `.lake`
2. `lake exe cache get`
3. `lake build`
4. `python3 scripts/testimony_lint.py`
5. `lake exe runLinter Testimony`
6. `lake exe axiom-audit`
7. `lake exe bibgen --check`

`.github/workflows/docs.yml` builds the mdBook site plus doc-gen4 API docs and
deploys to GitHub Pages.

## 10. Layer F — Documentation site (`docs/`)

mdBook (v0.5.4 installed locally via Homebrew for verification).

```
docs/
  book.toml
  src/
    SUMMARY.md
    introduction.md     what this is and is not
    rationale.md        why machine-check testimony
    scope-and-limits.md what Lean settles and what it cannot
    architecture.md     the six layers; links to DESIGN.md
    logic.md            how arguments are encoded and checked
    citations.md        bibliography conventions and contribution rules
    style-guide.md      naming, docstrings, citation keys, rival encoding
    bibliography.md     GENERATED by bibgen
    roadmap.md          phases, then systematic and philosophical theology
    contributing.md
```

`README.md` shrinks to a short pointer into the site. `DESIGN.md` remains the
type-level design document; `architecture.md` links to it rather than
duplicating it.

### 10.1 `rationale.md`

The argued position: the project makes the argument for the divinity of Jesus,
and for his fulfilment of the messianic prophecies, **fully explicit and
machine-checked for validity, with every premise it rests on published**. That
is what Lean can deliver, it is what README.md already commits to, and it is the
stronger rhetorical position — an argument whose assumptions are all declared is
harder to dismiss than one claiming mechanical proof of its conclusion.

Prior art is cited rather than alluded to, principally Benzmüller and
Woltzenlogel Paleo's machine-verified formalisation of Gödel's ontological
argument.

### 10.2 `roadmap.md`

Existing Phases 1–4, then the two future directions:

- **Systematic theology** — confessional standards (Nicaea, Chalcedon,
  Westminster, the Catechism of the Catholic Church) as versioned, citable axiom
  sets; cross-locus consistency checking; tracing which doctrines depend on which
  exegetical premises.
- **Philosophical theology** — divine attributes and their alleged
  incompatibilities, theodicy structures, and the classical arguments. Foundation's
  modal logic and Kripke semantics are the reason this is reachable from the
  chosen substrate.

### 10.3 `citations.md`

Documents the entry types, the `@[bib_entry]` workflow, `bibgen`, and the
contribution rule below.

## 11. Bibliographic verification rule

**No bibliographic identifier is written from memory.** Every ISBN, DOI, edition
statement, publisher and page range in the seed bibliography is verified against
a public catalogue before it is committed; any field that cannot be verified is
left `none` rather than guessed. `citations.md` states this as a binding
contribution rule.

Seed entries requiring verification: France (*Matthew*, NICNT), Brown (*The Birth
of the Messiah*), Keil & Delitzsch (*Minor Prophets*), Motyer (*The Prophecy of
Isaiah*), NA28, UBS5, BHS, the ETCBC BHSA dataset, the Open Scriptures Hebrew
Bible, Dunn and Wright on the New Perspective, the Council of Trent's canons on
justification, and Benzmüller & Woltzenlogel Paleo.

This makes a research pass part of the implementation, not a preliminary to it.

## 12. Testing strategy

Test-first throughout.

- **Render** — `#guard` golden-string assertions on sample entries for each of
  the eight BibTeX mappings and the markdown renderer, written before the
  renderer.
- **Registry** — `#guard` for key `Nodup` and `editionUsed` resolution.
- **Logic** — `bval_iff_val`, `entails_of_check` and `not_entails_of_check` are
  proved, not assumed; `#guard` assertions pin `checkEntails` on small hand-worked
  cases before the argument files depend on it.
- **Arguments** — the theorems are the tests. Every headline theorem carries
  `#print axioms`.
- **Whole library** — `lake exe axiom-audit` in CI is the global gate; it is what
  catches a `sorry` left behind anywhere.
- **Generated artefacts** — `lake exe bibgen --check` in CI.
- **Conventions** — the four tiers of §13.2. `scripts/testimony_lint.py` ships
  with its own unit tests over fixture snippets, since a linter that silently
  stops firing is worse than no linter.

## 13. Contributor and agent tooling

### 13.1 Why this is in scope

The library's honesty rules — every premise cited, rival readings encoded with
equal care, no undeclared axiom, relation types never collapsed — are exactly the
kind of convention that erodes silently under time pressure. A rule that lives
only in CONTRIBUTING.md is a rule that will be broken by a contributor in a
hurry, human or agent, and nobody will notice for months.

Every rule stated in this design therefore gets an enforcement tier, and the
rules an agent is most likely to violate get the fastest ones.

### 13.2 Four tiers of checking

| tier | command | catches | speed |
|---|---|---|---|
| 1 build-time | `lake build` | missing docstrings, Lean style linters | in-editor |
| 2 semantic | `lake exe runLinter Testimony` | `docBlame`, `docBlameThm`, `unusedArguments`, `checkType`, `synTaut`, `dupNamespace` | ~build |
| 3 trust base | `lake exe axiom-audit` | `sorry`, `native_decide`, undeclared axioms | seconds |
| 4 domain | `python3 scripts/testimony_lint.py` | the project-specific rules in §13.3 | <1s |

**Tier 1** is configured in `lakefile.toml`, giving feedback in the editor rather
than in CI:

```toml
[leanOptions]
linter.missingDocs           = true
weak.linter.flexible         = true
weak.linter.style.multiGoal  = true
```

`linter.missingDocs` matters more here than in an ordinary library. A docstring
on a Testimony declaration is not decoration: it states what a premise asserts
and who holds it, and an undocumented premise is very nearly an uncited one.

**Tier 2** uses the Batteries environment linters, available transitively via
Mathlib. `lintDriver` is set in `lakefile.toml` so `lake lint` works.
`docBlameThm` — **disabled by default in Batteries** — is explicitly enabled: a
theorem asserting a theological result must document what it claims.

**Tier 3** is the axiom-audit gate from §4.

**Tier 4** is domain-specific and is the tier this project actually needs, since
no general-purpose Lean linter knows what a citation is.

### 13.3 `scripts/testimony_lint.py`

Python 3, standard library only (present on macOS and `ubuntu-latest`).
Source-level and sub-second, so it can run on every file write rather than only
in CI. Rules:

| id | rule | rationale |
|---|---|---|
| L1 | no `sorry` / `admit` under `Testimony/` | fast feedback; axiom-audit remains the authoritative gate |
| L2 | no `native_decide` | §4; keeps the trust base declared |
| L3 | `BibEntry` constructors appear only in `Testimony/Bib/Works.lean` | citations elsewhere must reference registry entries, so nothing escapes `bibgen` |
| L4 | every `def … : BibEntry` in `Works.lean` carries `@[bib_entry]` | an untagged entry is invisible to the registry and silently uncited |
| L5 | a type with a `FiniteAtoms` instance has at most 12 constructors | the atom budget of §7.3 |
| L6 | every `@[headline]` theorem is followed by `#print axioms` | the trust base of a headline result is visible in the source, not merely in CI |
| L7 | citation keys match `^[a-z0-9]+(-[a-z0-9]+)*$` | stable, URL-safe, BibTeX-safe keys |
| L8 | no trailing whitespace; lines at most 100 columns | ordinary hygiene |

L6 requires a `@[headline]` tag attribute (a plain `registerTagAttribute`, no
environment extension). Marking the load-bearing results is worth doing
independently: it makes "what does this library actually claim?" a greppable
question, and the docs site can list headline theorems rather than hand-curating
them.

`#print axioms` is documentation-in-source, not a gate — axiom-audit is the gate.
Both exist because the audience for the first is a reader of the argument and
the audience for the second is CI.

### 13.4 Style guide — `docs/src/style-guide.md`

A chapter of the book, so contributors and agents read the same document.
Covers:

- **Naming.** `lowerCamelCase` for definitions, `snake_case` for theorem names
  after mathlib convention. Atoms named `passage_claim`
  (`rom3_28_justified_apart_from_works_of_law`) so the source text is legible in
  the atom itself.
- **Citation keys.** `family-shorttitle-year` — `france-matthew-2007`,
  `brown-birth-messiah-1993`, `na28-2012`. Enforced by L7.
- **Docstrings.** Required on every declaration. For a premise or atom, the
  docstring states what is asserted *and which tradition asserts it*; for a
  package, which position it encodes; for a headline theorem, what it does and
  does not establish.
- **Module docstrings.** Layer, purpose, and — for argument modules — a prose
  statement of the dispute, as `BornOfAVirgin.lean` already does well.
- **Rival encoding.** An argument module that encodes a Christian reading without
  at least one rival package is incomplete, not merely unpolished.
- Line width 100; no trailing whitespace.

### 13.5 `CLAUDE.md`

Repository root, loaded automatically by Claude Code. Deliberately short — a long
CLAUDE.md is a skimmed CLAUDE.md. Contents:

1. What the project is, in three sentences, including the conditional-analysis
   invariant that no premise is smuggled in.
2. **Hard rules**, stated as prohibitions: never invent a bibliographic
   identifier; never use `sorry` or `native_decide`; never add a premise without
   a `Source`; never encode a Christian reading without its rivals; never
   collapse relation types.
3. Commands, in the order to run them (§13.2 plus `lake exe bibgen`).
4. A layout map: which layer lives in which directory.
5. Pointers to the three skills in §13.6.
6. Toolchain notes: v4.33.1, `lake exe cache get` before a first build, expected
   build times.

Rule 2 is phrased as prohibitions because that is the form that survives
compaction and skimming. "Verify citations against a public catalogue" invites
judgement about whether this one really needs it; "never invent an identifier"
does not.

### 13.6 Project skills — `.claude/skills/`

Three skills, each a `SKILL.md` with `name` and `description` frontmatter,
scoped narrowly enough to be worth invoking:

- **`adding-a-citation`** — verify the work against a public catalogue; choose
  the entry type (with the decision points that are actually confusing: critical
  edition versus book, ancient work versus its modern edition); write the
  `@[bib_entry]` def; reference it from a `Source`; run `lake exe bibgen`; commit
  the generated files alongside the source change.
- **`encoding-an-argument`** — go from a commentary or a text to an
  `ArgumentPackage`: choose atoms and stay inside the budget, cite every atom via
  the total `meta`, write the rival packages *before* proving anything, prove via
  `entails_of_check`, tag `@[headline]`, add `#print axioms`, and read the
  generated manifest to check the argument does not rest on scripture alone.
- **`checking-the-build`** — the four tiers in order, what each catches, and what
  to do when each fails. Its real job is to stop an agent concluding "it builds"
  from `lake build` alone, when three further gates exist.

### 13.7 Claude Code hook

A `PostToolUse` hook in `.claude/settings.json` matching `Edit|Write` on `*.lean`
runs tier 4, so a violated project rule surfaces at the edit rather than in CI.
Tiers 1–3 are too slow for an edit hook and stay in the build and CI.

## 14. Breaking changes

1. `Source.citation : String` is removed; all call sites migrate.
2. `lean-toolchain` downgrades to `v4.33.1`; contributors must re-run `elan`.
3. First build requires `lake exe cache get`; build times rise substantially.
4. `Satisfies` and `MeetsDefinition` change meaning and signature; both
   lose their `PremisePackage` parameter.
5. The two CI workflows collapse into one.

## 15. Risks and mitigations

| Risk | Mitigation |
|---|---|
| Mathlib build times or cache misses on v4.33.1 | `lake exe cache get`; cache `.lake` in CI; accept longer builds as the cost of the chosen substrate |
| Foundation uses the Lean module system (`module`, `public import`); interop with a classic-style project may be rough | Spike this **first**, before any other implementation work. If interop fights, adopt the module system in Testimony or pin an earlier Foundation revision |
| `@[bib_entry]` environment extension proves fiddly | Timeboxed; documented fallback to a manual `registry` plus a coverage check in `bibgen` (§5.4) |
| `SatisfactionWitness` universe handling | Documented fallback to per-argument `Satisfies` instantiation (§8.3) |
| `decide` too slow on larger arguments | 12-atom budget (§7.3); decompose rather than reach for `native_decide` |
| `lake exe runLinter` ambiguous or unresolvable across transitive deps (Batteries and Mathlib both ship linter drivers) | Fall back to a local `lean_exe lint` rooted at `Testimony/Tools/Lint.lean` invoking the Batteries linter frontend directly |
| `scripts/testimony_lint.py` silently stops firing after a refactor | Fixture-based unit tests for every rule (§12), run in CI alongside the linter itself |
| Toolchain downgrade breaks existing code | Existing code uses no v4.34-specific features; verified by building early |

## 16. Implementation order

The Foundation interop spike gates everything else, because a failure there
changes the substrate decision.

1. **Spike:** Foundation + Mathlib on v4.33.1, module-system interop, a trivial
   `Formula` value elaborating inside Testimony. Report before proceeding.
2. Bibliography core types, registry, render (test-first).
3. `Reference` / `Source` rewrite; migrate the two existing argument files'
   citations so the build stays green.
4. `bibgen`, `references.bib`, CI consolidation, axiom-audit gate.
5. Logic layer: adapter, bridge theorems, `ArgumentPackage`, manifest.
6. Bibliographic research pass for the seed entries (§11).
7. `SolaFide` complete; `SolaScriptura` seeded.
8. Migrate `BornInBethlehem`, `BornOfAVirgin`, and `Argument.lean` onto the
   logic layer.
9. Style guide, `scripts/testimony_lint.py` with its tests, lint tiers wired into
   `lakefile.toml` and CI, the `@[headline]` attribute.
10. `CLAUDE.md`, the three skills, the `PostToolUse` hook. Written last, so they
    document the conventions as built rather than as imagined.
11. mdBook site, doc-gen4 wiring, `docs.yml`, README/DESIGN updates.
