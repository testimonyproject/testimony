# Testimony — working notes for Claude Code

Christian arguments from Scripture, written out premise by premise and checked
in Lean 4. Every result is conditional: *given premise package P, conclusion C
follows*. Lean checks validity; it never establishes that a premise is true.

## What matters

The project is two things. Hold both, in this order.

1. **A guide for lay people reading an English Bible, in language precise
   enough that a theologian can work with it.** The generated pages are the
   product. A reader with a Bible and no Greek, no Hebrew and no logic should
   follow every paragraph. A scholar should find every claim exact and sourced.
2. **A code library for encoding arguments and checking them for consistency.**
   Positions are lists of cited premises. The machine checks what follows, what
   does not, and which positions can be held together.

So every piece of logical construction (a certificate, a hearing, a named
burden, a result's name) is justified by a question such a reader asks, and is
worth building only if the generated page answers it in words they can follow.

- **Start from the reader's question**, not from what the machinery can prove:
  "where exactly do Trent and Paul part?" is a `Because`; "what if the
  definition means the word, not the reality?" is a `Dilemma`; "what did the
  Reformation itself decide?" is a hearing.
- **Every result says, in its docstring, what it claims and what it does not**,
  in plain words, and names the texts, readers and ratings it turns on. The
  docstring *is* the page.
- **Report what the solver computes, whichever way it goes.** A verdict that
  disappoints the argument's author is still the verdict, and the page says so.
- **Never tune the encoding to reach a verdict**, and never drop a cited reader
  because we judge him mistaken. Show where his reading breaks, or that it does
  not; a rating moves only with a new, cited argument.

## Writing prose

`docs/src/writing-for-readers.md` is the standard, and it applies to every
docstring under `arguments/TestimonyArguments/` as much as to any page. The
short form:

- Quote the passage in English before arguing about it.
- English first, original term in brackets: "works of the law" (ἔργα νόμου).
- Gloss every technical word, theological or logical, where it is used.
- Name who holds a view. Say what a result claims, then what it does not.
- Put identifiers in brackets after the sentence that states the point in
  words. A sentence that needs the identifier to make sense needs rewriting.
- Plain sentences of varied length, joined with *because* and *so* where the
  logic joins them. No clever contrasts, no announcing that a point matters, no
  bold label on every paragraph, no shorthand from the code left unexplained.
- It should sound like a person explaining, not a form being filled in: people
  acting in history, quotations doing the arguing. Skills `prose-voice` and
  `removing-ai-tells` hold the detail; `scripts/prose_tells.py` counts the
  habits that make prose sound generated.

Read the generated page before opening a pull request, not only the docstring.
The `reader-review` agent does a first pass.

## Packages

Three Lake packages. `Testimony`, at the root, is the machinery: logic,
provenance, vocabulary and ontology, the solver, the checks and the generators.
The worked arguments are `TestimonyArguments`, in `arguments/`, a package built
on it; the grits case is `TestimonyExamples`, in `examples/`. Each requires the
library by path and shares its `.lake/packages`.

Full docs: `docs/src/`. Read `docs/src/style-guide.md` before writing Lean.

## Hard rules

Stated as prohibitions on purpose. Each one is enforced by a command.

- **Never invent a bibliographic identifier.** Verify every ISBN, DOI, edition
  and page range against a public catalogue (Open Library, Crossref). If it
  cannot be verified, the field is `none`. A wrong ISBN survives review; a gap
  does not.
- **Never use `sorry`, `native_decide`, or `bv_decide`.** `native_decide` adds
  `Lean.ofReduceBool`; `bv_decide` adds a per-theorem `_native.bv_decide.ax`.
  `lake exe axiom-audit` fails on all of them. `decide +kernel` is not one of
  them: it has the kernel evaluate the decision and adds no axiom, and it is
  how `horn_certify` has the kernel check a defeat table's certificates.
- **Never add a premise without a `Source`.** It will not compile —
  `Source.primary` is required and `ArgumentPackage.cite` is total.
- **Never encode a Christian reading without at least one rival package**, and
  write the rival before proving anything.
- **Never collapse relation types.** Quotation ≠ allusion ≠ typology ≠
  prediction. Disputed cases get both, attributed.
- **Never record a parity reply as two results.** "It blocks the objection" and
  "it establishes nothing" over one premise set are one fact: the disputed
  proposition is `Independent` of that set. Stated as a pair, nothing checks
  that the halves are about the same proposition — and a pair whose halves were
  not reached `main`.
- **Never restate a premise list to make a variant package.** A variant is a
  named difference: one `Line` on different grounds, via `Line.onGrounds`.
  Retyping twenty premises to drop one hides which one went.
- **Never edit `references.bib`, `docs/src/bibliography.md`,
  `docs/latex/arguments.tex`, `docs/src/arguments/*.md`, or the marked blocks in
  `docs/src/roadmap.md` and `docs/src/SUMMARY.md`.** Generated by
  `lake exe bibgen`, `lake exe argtex`, `lake exe statusgen` and
  `lake exe argdoc`, run in `arguments/`, from the Lean source. Both the page
  and the PDF *are* the docstrings: to change what they say, change the
  docstring and regenerate.
- **Never change an argument without the documentation it implies.** A page
  asserting the opposite of a proven theorem is the failure this library exists
  to rule out, and it has happened. `lake exe statusgen --check` regenerates
  what can be generated; linter rule L9 fails on a page *or a docstring* naming
  a result that no longer exists; the rest — a paragraph that still *describes*
  a result wrongly — is yours to fix in the same commit.
- **Never assert an entailment over premises you have not shown satisfiable.**
  `Entails` quantifies over the valuations satisfying the premises, so a premise
  set with no model entails *everything*, `establish` closes the goal, and every
  other gate passes. A package carrying `Establishes` needs a named model;
  linter rule L11 fails without one. A `¬ Establishes` package needs none — its
  countermodel already satisfies every premise.
- **Never let a line of prose run past 100 columns.** Rule L12 holds
  hand-written markdown to the width L8 has always held Lean to. Generated
  pages, generated blocks inside hand-written pages, table rows and YAML
  frontmatter are exempt; long links are *not* — a link that will not fit
  becomes a reference link, `[text][ref]`, defined elsewhere in the file.
- **Never claim "it builds" from `lake build` alone.** Four gates exist, plus
  three `--check` runs for the generated files.
- **Never work in the primary checkout.** Every change is made on a branch in
  its own git worktree, created by `scripts/new-worktree.sh`. A worktree that
  was not created by that script has no `.lake/` — it is gitignored, so it is
  not inherited — and its first `lake build` compiles Mathlib from source.
  `.githooks/pre-commit`, armed by that script, refuses a commit made in the
  primary checkout.
  The one exception is a Claude Code cloud session: its container holds a
  fresh clone already on the session's own branch, which is the disposable
  checkout the rule asks for. Work there, on that branch, and run
  `lake exe cache get` before the first build.

## Commands, in order

```sh
scripts/new-worktree.sh <branch>     # always first: worktree + cache, ready to build
lake exe cache get                   # what that script runs; fetches Mathlib oleans
lake build                           # tier 1: missingDocs + Lean linters
lake build TestimonyTools            # ... and the tools the generators are built from
lake lint                            # tier 2: Batteries environment linters
lake exe axiom-audit                 # tier 3: trust base
scripts/kernel-replay.sh             # tier 3, continued: kernel replay of every module
python3 scripts/testimony_lint.py    # tier 4: project rules L1-L12
python3 scripts/test_testimony_lint.py   # after touching the linter
mdbook build docs                    # docs site

# In arguments/, after the library: the same gates, and the generated files.
lake build && lake lint && lake exe axiom-audit
../scripts/kernel-replay.sh TestimonyArguments bibgen argtex statusgen argdoc
lake exe bibgen --check              # generated files current
lake exe statusgen                   # regenerate the roadmap's status table
lake exe argdoc                      # regenerate docs/src/arguments/ from the docstrings
lake exe argtex                      # render arguments to LaTeX
(cd ../docs/latex && tectonic arguments.tex)   # ... and to PDF (needs a Unicode engine)

# In examples/: the examples package, after the library.
lake build && lake exe exampletex --check

# Engine benchmarks, after the arguments build (optimising-the-engine skill).
scripts/bench.sh                     # every benchmark: time and peak memory
scripts/bench-ab.sh origin/main      # A/B: this checkout against main, as CI does
scripts/bench-ab.sh origin/main --shard 1/3   # ... one of the shards CI runs as jobs
```

`lake build` in `arguments/` also runs `#check_refutations`: `establish` must
fail, as not Horn, on every package an argument refutes. Adding a refutation
changes the count it reports, which is pinned. The library runs the same checks
over a fixture of its own (`Testimony.Checks.Fixture`).

Tier 3 is the one that catches a `decide` proof which silently failed and fell
back to `sorryAx` — that produces a *successful build*.

## Layout

| Path | Contents |
|---|---|
| `Testimony/Text.lean` | Books, passages, canons, textual traditions |
| `Testimony/Scripture.lean` | Shared passages, scripture-citation bundles, `Source` helpers |
| `Testimony/Bib/` | `Core` types, `Attr` registry attribute, `Works` entries, `Render`, `Registry` guards |
| `Testimony/Provenance.lean` | `Reference`, `Source`, `Tradition`, `Confidence` |
| `Testimony/Intertext.lean` | Typed relations between passages |
| `Testimony/Logic/` | `Basic` formula, `Notation` (`p`/`notP`), `Entail` + countermodels + `Independent`, `Package` arguments + manifests, `Line` lines of reason, `Tactic` (`establish`, Horn-only, and `establish_by_search`/`refute_with`/`satisfied_by`/`leaves_open`/`granted`), `ModelCheck` a reading written as a table, checked against every premise by the kernel, `Framework` Dung semantics (grounded, preferred), `Dispute` packages as its nodes, defeat derived from entailment and cited confidence, `Horn` the decision procedure that computes a dispute's defeat table, `Certificate` the search that finds what the kernel checks of it (`horn_certify`), each party's position converted once per table (`prepare_clauses`), and asked by its components (`prepare_parts`), `Solver` the verified solver that computes its verdicts, `Compose` two disputes that share no claim heard as one, their table proved from the two tables, `Witness` the checked reasons they are stated with, `Verdict` a verdict and its witness as one declaration, rendered from the witness, `Support` one position lending another a premise, `Map` a dispute drawn with its defeats, supports and the attacks support implies, `Because` why one package stands against another, at a checked crux, `Burden` the minimal sets of readings an opponent must reject, complete, `Dilemma` every reading of a rival's ambiguous claim, each answered, `Aif` every dispute as an AIF graph, checked against AIF's Definition 1.1 |
| `Testimony/Argument.lean` | Criteria, definitions, `Satisfies`, `People` |
| `Testimony/Semantics/` | `Upper` (DOLCE's categories, each with its BFO counterpart), `Vocabulary`, `Grammar` (a claim's meaning as a term, over concepts, words and particulars), `Ontology` (a meaning taken apart and read under definitions), `Meaning` (`HasMeanings`, `HasJoins`), `Discourse` |
| `Testimony/Ontology/` | Articles that derive what the vocabulary's words mean — definitions with sources, each shown at work — naming no argument (`Relations`; `Time`, an occurrence lasts one length of time; `Kinds`, each concept's category, or why it has none); `Search`, the generic queries; `Shared`, the definitions every join is read under |
| `Testimony/Logic/Page` | `Item` — what a generated page is made of, before either rendering |
| `Testimony/Logic/Latex`, `Testimony/Logic/Markdown` | The two renderings of it: for print, and for the browser |
| `Testimony/Tools/` | What a package's generators are made of: `Docs` (`Argument`, a catalogue entry), `Pages` (the harvest, `derive_argument_bodies … under N`, `latexDocument`, `writeOrCheck`), `Site` (each argument as a page of the site), `Status` (the headline table), `Bibliography` (`references.bib` and the chapter). The root does not import them: they are the library target `TestimonyTools`, built by `lake build TestimonyTools` and by kernel replay |
| `Testimony/Checks/` | The checks a package runs over its arguments: `Refutations` (`establish` fails on every refuted package), `Ontology` (what each definition does in every argument, pinned), `Meanings`, `Postulates`, `Citations` (every bibliography entry is a tagged definition, and a key names one), `Aif`, each `under N`; and `Fixture`, the library's own small case, which they run over in its build |
| `scripts/` | Domain linter and its tests; `kernel-replay.sh [root targets…]`; `prose_tells.py`, an advisory count of generated-sounding habits in prose |
| `arguments/` | `TestimonyArguments`: the worked arguments, a Lake package built on the library. Over ~500 lines an argument becomes a directory (`Atoms`, `Sources`, `Lines`, `Packages`, `Results`, the root module reduced to imports and the module docstring). Beside them: `Works` (what they cite beyond the library's works), `Attr` (their unfold sets), `Meanings` (one module per argument: what each claim means, and its pinned joins), `Articles` (published articles examined), `Checks` (the library's checks over them, pinned), `Tools` (the catalogue and the generators `bibgen`, `argtex`, `statusgen`, `argdoc`, each with `--check`, writing into the repository's `docs/`) |
| `examples/` | `TestimonyExamples`: a separate Lake package that requires the library by path, the first user of it outside its tree. Its cases (`Grits`), works, checks and LaTeX documents (`lake exe exampletex`) are its own, and nothing of it is in the library's index. Build it after the library, from `examples/` |

## Skills

In `.claude/skills/`. Each loads when its description matches the task, or by
name as `/<skill>`.

- `writing-for-readers` — writing or revising a docstring or page for the two
  readers: the rules, the checklist, and how to review a generated page
- `prose-voice` — drafting prose with a voice: how a paragraph and a chapter
  move, people and history put back in, every fact kept
- `removing-ai-tells` — the editing pass for habits that make prose sound
  generated, with `scripts/prose_tells.py` to count them
- `encoding-an-argument` — going from a commentary to a package
- `supplementing-an-argument` — strengthening an existing argument for a reader:
  finding the crux, researching a better-than-disputed premise, auditing its
  rating, and reporting what the solver then computes
- `adding-a-citation` — verifying and adding a bibliography entry
- `checking-the-build` — the four tiers and what each catches
- `optimising-the-engine` — making the engine faster or lighter: the benchmark
  suite, the ablation A/B and its statistics, the fixed-point loop, the CI
  regression gate, and accepting a regression on purpose

## Agents

In `.claude/agents/`, for the research the supplementing workflow needs. Each
returns findings, never edits; what enters the library is decided and encoded
by the main session.

- `source-verifier` — checks identifiers and quotations against public
  catalogues and texts
- `rating-auditor` — looks for a cited reader who grants a step's grounds and
  denies its conclusion, and says what that makes its rating
- `reader-review` — reads a generated page as a lay reader and as a theologian
  would, and flags what either could not follow or would dispute

## Other files an agent reads

- `.claude/rules/lean.md` — the Lean gotchas, loaded when a `.lean` file is in
  play
- `REVIEW.md` — what a review of a pull request here must check. Follow it
  whenever you review a change, by `/code-review` or in
  `.github/workflows/claude-code-review.yml`; Claude Code's managed Code Review
  reads it by itself
- `.claude/settings.json` — the hooks: the linter after each edit, and
  `.claude/hooks/session-start.sh` at the start of a cloud session

## Pull requests

One concern per pull request, opened as a draft. The description says what the
change claims and what it does not, as a result's docstring does, and lists the
gates that were run. If a result's verdict moved, say so in the first line.
`.github/pull_request_template.md` has the headings. A pull request opened from
a Claude Code session is authored by the signed-in person, who therefore cannot
approve it; `docs/src/contributing.md` ("Pull requests and review") lists the
ways round that.

## Toolchain

Lean **v4.33.1**, pinned by the Foundation dependency (which also brings
Mathlib, doc-gen4 and axiom-audit). Do not bump it without checking Foundation.
First build after a clone needs `lake exe cache get` or it will compile Mathlib
from source.

In a Claude Code cloud session, `.claude/hooks/session-start.sh` runs at start:
it installs elan if the image lacks it, puts `lake` on `PATH`, and installs
`tectonic`, `mdbook` and `uv`, pinned as the devcontainer pins them, so the PDF
and the docs site can be rendered too.
