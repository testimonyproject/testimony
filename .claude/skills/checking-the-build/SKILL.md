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
python3 scripts/testimony_lint.py    # 4
lake exe bibgen --check              # generated files
```

### Tier 1 — `lake build`

Catches type errors, and missing docstrings via `linter.missingDocs`.

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

### Tier 4 — `python3 scripts/testimony_lint.py`

Project rules no general-purpose Lean linter knows: uncited `BibEntry` literals
outside `Works.lean` (L3), untagged registry entries (L4), the twelve-atom
budget (L5), `@[headline]` theorems without `#print axioms` (L6), citation-key
format (L7), layout (L8).

Sub-second, so run it freely. If you change the linter, run its own tests:

```sh
python3 scripts/test_testimony_lint.py
```

### Generated files

```sh
lake exe bibgen --check
```

Fails if `references.bib` or `docs/src/bibliography.md` are stale. Fix with
`lake exe bibgen` and commit both.

## Reporting

State what you ran and what it said. "All four tiers pass, axiom-audit clean
over N declarations" is a claim backed by output. "It builds" is not.
