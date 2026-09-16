# Contributing to Testimony

The full guide lives in the documentation:
**[Contributing](docs/src/contributing.md)**.

Two kinds of expertise make this project work, and **you only need one of
them**: theology or biblical studies (no Lean required), or Lean (no theology
required).

Before writing Lean, read the [style guide](docs/src/style-guide.md) and
[Encoding arguments](docs/src/logic.md).

## Ground rules

1. **Honesty over advocacy.** Rival interpretations are encoded with the same
   care as the Christian ones.
2. **Every premise carries a source** — enforced by the type system, not by
   review.
3. **No invented identifiers.** Verify against a public catalogue, or leave the
   field `none`.
4. **No collapsing relation types.**
5. **Respectful discourse.** Debate the encoding, not the person.

## Work in a worktree

Every change is made on a branch in its own git worktree, never in the primary
checkout:

```sh
scripts/new-worktree.sh my-branch
cd ../testimony-worktrees/my-branch
```

The script creates the worktree *and* runs `lake exe cache get` in it. That
second step is not optional: `.lake/` is gitignored, so a new worktree does not
inherit it, and without the cache the first build compiles Mathlib from source.

## Before opening a pull request

```sh
lake build                           # tier 1
lake lint                            # tier 2
lake exe axiom-audit                 # tier 3
python3 scripts/testimony_lint.py    # tier 4
lake exe bibgen --check
```

All five run in CI. `lake build` passing on its own is not enough — see
[the style guide](docs/src/style-guide.md#the-four-tiers).
