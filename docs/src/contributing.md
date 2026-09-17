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
- Tooling: `bibgen`, `argtex`, `statusgen`, the domain linter, doc generation,
  CI.
- The logic layer: lines of reason, the countermodel bridge and the
  `establish`/`refute_with` tactics are the most interesting code in the
  repository.

## Ground rules

1. **Honesty over advocacy.** The library models arguments; it does not
   campaign. Rival interpretations are encoded with the same care as the
   Christian ones.
2. **Every premise carries a source.** Uncited premises do not merge — and,
   as of the citation layer, do not compile.
3. **Original arguments are welcome, and are marked.** The rule has never been
   that an uncited argument is unwelcome; it is that a reader must be able to
   tell what the library *reports* from what it *constructs*. So a contribution
   nobody in the literature advances is encoded like any other, tagged
   `@[proposed]`, and counted separately in the status table. Its premises, if
   they are themselves uncited, carry `Reference.proposal` — which still
   demands a rationale where a citation would go. Rule L10 requires the
   docstring to say what is novel and what would settle whether anyone has said
   it before. Soundness and provenance are different axes: a proposed result is
   checked by exactly the same machinery as every other one, and the tag says
   nothing about whether it holds.
4. **No invented identifiers.** Verify against a public catalogue, or leave the
   field `none`. This is not in tension with the rule above: a proposal says so
   in plain words, where a fabricated ISBN pretends to be a citation.
5. **No collapsing relation types.** If a passage is disputed between
   "prediction" and "typology", encode both, attributed.
6. **Respectful discourse.** People of all faiths and none are welcome here.
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

The worktree script fixes the repository *layout*; it does not fix the
*toolchain*. For that, open a worktree in the devcontainer
(`.devcontainer/`) instead of installing elan, tectonic and mdbook by hand —
it is the same image CI builds in, so a discrepancy between "works for me"
and "works in CI" means the image is wrong, not your machine.

```sh
lake exe cache get                        # what the script runs for you
lake build                                # tier 1
lake lint                                 # tier 2
lake exe axiom-audit                      # tier 3
python3 scripts/testimony_lint.py         # tier 4
lake exe bibgen --check                   # generated files current
lake exe argtex --check
lake exe statusgen --check
```

All of these run in CI. Small pull requests, one concern each. Discuss
significant design changes in an issue first.

If the change touches `Testimony/Arguments/`, it is not finished when it
compiles: the documentation moves with it. Run `lake exe statusgen` and commit
the regenerated block in the [roadmap](./roadmap.md), and say what the encoding
now does on any page that describes it — see [Documentation moves with the
argument](./style-guide.md#documentation-moves-with-the-argument). Rule L9
fails the build if a page names a result the library no longer has, which is
how the roadmap went wrong once already.

See the [style guide](./style-guide.md) for conventions, and
[Encoding arguments](./logic.md) for how to write a new one.
