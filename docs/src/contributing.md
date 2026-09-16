# Contributing

Two kinds of expertise make this project work, and **you only need one of
them**.

## If you know theology or biblical studies (no Lean required)

This is the contribution the project most needs, and it does not require
writing any code.

- **Review encodings.** Does the formal statement faithfully represent the
  argument it claims to represent? Are the atoms carved correctly? Is a premise
  missing? **A subtly wrong formalisation is worse than none**, because it
  launders a bad argument through a proof assistant and comes out looking
  rigorous. No proof assistant can check this; only you can.
- **Propose rival packages.** What does a given tradition actually assume? The
  library is only as good as its rivals, and a strawman rival is worse than
  useless.
- **Source citations.** Commentaries, journal articles, critical editions —
  with identifiers that can be verified. See [Citations](./citations.md).
- **File issues in plain English.** Maintainers will pair with you on the Lean.

## If you know Lean (no theology required)

- Type design, proofs, tactics. The theological content can be treated as
  opaque data; the engineering problems stand on their own.
- Tooling: `bibgen`, the domain linter, doc generation, CI.
- The logic layer: the decidability adapter and its bridge theorems are the
  most interesting code in the repository.

## Ground rules

1. **Honesty over advocacy.** The library models arguments; it does not
   campaign. Rival interpretations are encoded with the same care as the
   Christian ones.
2. **Every premise carries a source.** Uncited premises do not merge — and,
   as of the citation layer, do not compile.
3. **No invented identifiers.** Verify against a public catalogue, or leave the
   field `none`.
4. **No collapsing relation types.** If a passage is disputed between
   "prediction" and "typology", encode both, attributed.
5. **Respectful discourse.** People of all faiths and none are welcome here.
   Debate the encoding, not the person.

## Workflow

Work happens in a git worktree, one per branch, never in the primary checkout.
Worktrees keep an in-progress encoding from colliding with a review of someone
else's, and they matter more here than in most repositories because a Lean
build is slow enough that switching branches in place means rebuilding.

```sh
scripts/new-worktree.sh my-branch         # worktree + Mathlib cache, ready to build
cd ../testimony-worktrees/my-branch
```

`.lake/` is gitignored, so a fresh worktree does not inherit it from the
checkout you branched from. The script runs `lake exe cache get` for you;
skipping it means the first build compiles Mathlib from source, which takes
hours rather than minutes.

```sh
lake exe cache get                        # what the script runs for you
lake build                                # tier 1
lake lint                                 # tier 2
lake exe axiom-audit                      # tier 3
python3 scripts/testimony_lint.py         # tier 4
lake exe bibgen --check                   # generated files current
```

All of these run in CI. Small pull requests, one concern each. Discuss
significant design changes in an issue first.

See the [style guide](./style-guide.md) for conventions, and
[Encoding arguments](./logic.md) for how to write a new one.
