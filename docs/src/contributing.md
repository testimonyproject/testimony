# Contributing

Two kinds of expertise make this project work, and **you only need one of
them**.

The project is two things, and a contribution serves one or both. It is a guide
for people reading an English Bible, in language precise enough that a
theologian can work with it. And it is a code library for encoding arguments and
checking them for consistency. [Writing for the reader](./writing-for-readers.md)
says what the first asks of anything you write.

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
  `establish`/`refute_with`/`satisfied_by`/`leaves_open`/`granted` tactics are
  the most
  interesting code in the
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
4. **No vacuous claims.** A package that establishes its conclusion must name a
   valuation on which all its premises hold. Without one the premises may be
   jointly unsatisfiable, in which case they entail everything and the result
   says nothing. Rule L11 checks it.
5. **No invented identifiers.** Verify against a public catalogue, or leave the
   field `none`. This is not in tension with the rule above: a proposal says so
   in plain words, where a fabricated ISBN pretends to be a citation.
6. **No collapsing relation types.** If a passage is disputed between
   "prediction" and "typology", encode both, attributed.
7. **Respectful discourse.** People of all faiths and none are welcome here.
   Debate the encoding, not the person.

## Editor setup

Lean source here is Unicode, and one glyph needs help: implication is `➝`
(U+279D), which has no abbreviation in the Lean 4 extension's input method — and
neither does Foundation's `🡒`, which it aliases. So the extension alone gives no
way to enter it but copy-paste. The devcontainer now ships one, under
`customizations.vscode.settings`, so inside `.devcontainer/` you type `\fimp`
and get `➝` with nothing to configure:

```jsonc
"lean4.input.customTranslations": { "fimp": "➝" }
```

Working outside the container, put the same line in your own `settings.json`.
Do **not** bind `\imp`: it is already one of six abbreviations for `→` (U+2192),
Lean's own function arrow, and a custom translation silently shadows the
built-in one. Every other connective is typable out of the box — `⋏` is
`\curlywedge`, `⋎` is `\curlyvee`, `∼` is `\sim`, `⋀` is `\And` or
`\bigwedge`, `⊧` is `\models`, `⊨` is `\vDash`. The rest of the library's
non-ASCII is the Hebrew, Greek and Syriac of quoted scripture, which is copied
from a critical edition rather than typed.

**Fonts are yours, not the container's, and cannot be fixed in the Dockerfile.**
`editor.fontFamily` is resolved by the VS Code UI process on your own machine,
not in the container, so neither `devcontainer.json` nor
`.devcontainer/Dockerfile` can change how your editor renders a character;
installing a font in the image does nothing for editor rendering. This project
therefore sets no font at all, and none is needed: `➝` is in Dingbats and shows
in ordinary programming fonts, in GitHub and in pull-request diffs. Only
Foundation's `🡒` — Supplemental Arrows-C, covered by almost nothing, and not by
a Nerd Font patch, which adds glyphs in the Private Use Area — renders as an
empty box, and this library does not write it.

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

The script also points `core.hooksPath` at `.githooks/`, whose `pre-commit`
refuses a commit made in the primary checkout. The setting is shared by every
worktree, so it arms the rule for the primary checkout as soon as the first
worktree exists. A checkout that has never run the script has no hook; running
`git config core.hooksPath .githooks` once installs it by hand.

The worktree script fixes the repository *layout*; it does not fix the
*toolchain*. For that, open a worktree in the devcontainer
(`.devcontainer/`) instead of installing elan, tectonic and mdbook by hand —
it is the same image CI builds in, so a discrepancy between "works for me"
and "works in CI" means the image is wrong, not your machine.

```sh
lake exe cache get                        # what the script runs for you
lake build                                # tier 1: the library
lake lint                                 # tier 2
lake exe axiom-audit                      # tier 3
python3 scripts/testimony_lint.py         # tier 4, over every package

cd arguments                              # the arguments: tiers 1-3 again
lake build && lake lint && lake exe axiom-audit
lake exe bibgen --check                   # generated files current
lake exe argtex --check
lake exe statusgen --check
lake exe argdoc --check
```

All of these run in CI, whenever a change touches something a build reads. A
change to nothing but hand-written pages, skills or notes like this one runs
the domain linter and, if it touched `docs/`, builds the book; the builds, the
benchmarks and the PDF are skipped, because they would have nothing new to
check. `scripts/ci_changes.py` decides which jobs a change needs, and any file
it does not know runs everything. Small pull requests, one concern each.
Discuss significant design changes in an issue first.

If the change touches `arguments/TestimonyArguments/`, it is not finished when
it compiles: the documentation moves with it. Run `lake exe statusgen` and
`lake exe argdoc` in `arguments/` and commit what they regenerate — the block in the
[roadmap](./roadmap.md) and the argument's own page — and say what the encoding
now does on any hand-written page that describes it — see [Documentation moves with the
argument](./style-guide.md#documentation-moves-with-the-argument). Rule L9
fails the build if a page *or a docstring* names a result the library no longer
has, which is how the roadmap went wrong once, and a published argument page a
second time.

See the [style guide](./style-guide.md) for conventions, and
[Encoding arguments](./logic.md) for how to write a new one.

## Pull requests and review

Much of the work here is done with Claude Code, and a pull request should be
reviewed by someone other than its author. GitHub does not let an author
approve their own pull request, so who the author is matters.

**Who authors a pull request today.** A pull request opened from a Claude Code
session, on the web or in a terminal, is opened with the signed-in person's own
GitHub account. That person is its author and cannot approve it. The commits
carry a `Co-Authored-By: Claude` line, which records who wrote them and does
not change who the author of the pull request is.

**Claude cannot be added to the organisation as a member.** There is no Claude
user account on GitHub to invite. Claude's identity on GitHub is the
[Claude GitHub App](https://github.com/apps/claude), which an organisation
owner installs on the organisation and grants this repository.

**Routes by which the App is the author.** Each needs the App installed.

- *Claude in Slack (Claude Tag).* Anthropic's documentation states that pull
  requests opened this way "show the Claude GitHub App as the author". It is a
  Team and Enterprise feature that an owner sets up. This is the route the
  documentation vouches for.
- *The GitHub Action, [`anthropics/claude-code-action`][action].* It is
  installed here as `.github/workflows/claude.yml`. Mention `@claude` in an
  issue or a pull-request comment, and Claude commits to a branch as the App.
  By default it does not open the pull request: it posts a link, and whoever
  clicks the link becomes the author. So have a maintainer other than the one
  who will review click it. The documentation does not describe a supported
  way to have the action open the pull request itself.
  The job runs in the devcontainer image, as CI does, with Mathlib's build
  restored from CI's cache. So it can build, regenerate the pages and run the
  gates, as a cloud session can. It cannot change `.github/workflows/`: the
  App is not granted that permission, so a maintainer makes those changes.

**A route that needs no setup.** Have a second maintainer, or the maintainer
who did not start the session, review and approve. Branch protection on `main`
with one required approval makes that the rule, and it works whoever the author
is, as long as the author is not the only maintainer.

**Review by Claude.** `.github/workflows/claude-code-review.yml` runs a review
on each pull request through the same action. `REVIEW.md` at the repository
root says what a review here must check, and `CLAUDE.md` holds the project's
rules; the action's review reads `CLAUDE.md`, and Claude Code's managed Code
Review, where an owner has enabled it, reads both. Either way the reviews are
comments. They never approve a pull request, so they do not replace a
maintainer's approval.

[action]: https://github.com/anthropics/claude-code-action
