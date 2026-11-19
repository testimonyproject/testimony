---
name: checking-the-build
description: Use before claiming work is complete in the Testimony library, before committing, or when verifying that Lean changes are sound. Covers the four checking tiers, what each one catches that the others cannot, and how to respond to each failure.
---

# Checking the build

## Why this exists

**`lake build` passing does not mean the work is sound.** Three further gates
exist, and one of them catches a failure mode that produces a *successful
build*: a `decide` proof that silently fails falls back to `sorryAx`, and
nothing in tier 1 or 2 will tell you.

Run all four. In order.

## The four tiers

```sh
lake build                           # 1
lake lint                            # 2
lake exe axiom-audit                 # 3
scripts/kernel-replay.sh             # 3, continued: kernel replay
python3 scripts/testimony_lint.py    # 4, over every package

cd arguments                         # the arguments, built on the library: 1-3 again
lake build && lake lint && lake exe axiom-audit
../scripts/kernel-replay.sh TestimonyArguments bibgen argtex statusgen argdoc
cd ..
scripts/generate-docs.sh             # generated files, not committed
```

The library and each package built on it (`arguments/`, `examples/`) are
separate Lake packages, and each is held to the gates in its own directory.

### Tier 1 — `lake build`

Catches type errors, and missing docstrings via `linter.missingDocs`. It also
runs `#check_refutations` (in `arguments/`, one module per argument under
`TestimonyArguments/Checks/`):
`establish` must fail, as not Horn, on every package an argument refutes. It reports how many it
checked, and the count is pinned with `#guard_msgs`, so adding a refutation
means updating the number — the error shows the new one.

The same build runs `#check_readers`, which fails on a reading cited to
Scripture alone and on a line of reason whose step has no rating. The error
names each one; cite a reader, or mark it `Reference.proposal` with a rationale.

Expect **zero warnings**, not just zero errors. A missing docstring is a
warning, and in this library a docstring states what a premise asserts and who
holds it.

### Tier 2 — `lake lint`

Batteries environment linters: `docBlame`, `docBlameThm` (enabled here though
disabled upstream), `unusedArguments`, `checkType`, `synTaut`.

`unusedArguments` is worth taking seriously — it has already revealed that two
definitions carried typeclass instances they never used.

For a genuinely justified exception, use `@[nolint ...]` with a comment saying
why. Scripture-reference defs such as `isaiah7_14` carry
`@[nolint defsWithUnderscore]` because the underscores are chapter and verse.

### Tier 3 — `lake exe axiom-audit`

**The most important one.** Inspects the kernel environment, not the source
text, and fails if any declaration depends on an axiom outside
`propext, Classical.choice, Quot.sound`.

Catches `sorry` (as `sorryAx`), `native_decide` (as `Lean.ofReduceBool`), and
hand-rolled axioms arriving through imports.

If it reports `sorryAx` on a theorem you believe you proved, a tactic failed
silently. The usual cause is `decide` on a term that does not kernel-reduce —
for instance `List.filter` over a derived `DecidableEq (Formula α)`. Restate
the term so it reduces; do not reach for `native_decide`, which is prohibited.

**Then `scripts/kernel-replay.sh`.** It runs `leanchecker`, which replays every
declaration of every `Testimony` module through the kernel, into the
environment as it stood before that module — independently of the elaborator
and of every tactic. Run the script rather than `leanchecker` directly:
`leanchecker` replays whatever `.olean` it finds, and the tools' modules are
not built by `lake build`, so a stale one from an older commit — or the build
output of a deleted module — fails the replay for a reason that has nothing to
do with the proofs. The script builds every target and removes orphaned build
output first. The
audit asks which axioms a proof rests on; the replay re-checks the proof. About
seventy seconds. It is what makes a change to a proof *recipe* — such as
`establish` moving from `tauto` to backward chaining — safe by construction: a
tactic can fail to find a proof, but it cannot get a false one past the kernel.

### Tier 4 — `python3 scripts/testimony_lint.py`

Project rules no general-purpose Lean linter knows: uncited `BibEntry` literals
outside `Works.lean` (L3), untagged registry entries (L4), an argument with no
rival package (L5), `@[headline]` theorems without `#print axioms` (L6),
citation-key format (L7), layout (L8), prose naming a result the library no
longer has (L9), and the same 100-column limit over hand-written markdown that
L8 applies to Lean (L12).

Sub-second, so run it freely. If you change the linter, run its own tests:

```sh
python3 scripts/test_testimony_lint.py
```

### Generated files

```sh
scripts/generate-docs.sh
```

Four tools of the arguments package, run in `arguments/`, and `exampletex` in
`examples/`, write the files below; the script runs them all. Git does not hold
what they write (`.gitignore`), so no two pull requests conflict over it, and
there is nothing to keep in step: CI runs the script for the site, the PDFs and
each pull request's preview, and fails if a generator does. Run it before
reading a page your change produces, or building the book. The hand-written
prose of the roadmap, maturity and summary pages is in `docs/templates/`; edit
it there.

| Tool | Owns |
|---|---|
| `bibgen` | `references.bib`, `docs/src/bibliography.md` |
| `argtex` | `docs/latex/arguments.tex` and `docs/latex/arguments/*.tex` — the same harvest as `argdoc`, set for print, together and each argument alone |
| `statusgen` | `docs/src/roadmap.md` and `docs/src/maturity.md`, from `docs/templates/` |
| `argdoc` | `docs/src/arguments/*.md`, and `docs/src/SUMMARY.md` from `docs/templates/` |

`argdoc` and `argtex` are the two a change to an argument almost always moves:
both render the module docstrings as well as the declarations, so editing a
docstring is editing the published page and the PDF alike.

## Reporting

State what you ran and what it said. "All four tiers pass, axiom-audit clean
over N declarations" is a claim backed by output. "It builds" is not.
