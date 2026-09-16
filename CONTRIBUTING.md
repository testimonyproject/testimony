# Contributing to Testimony

Thank you for considering a contribution. Two kinds of expertise make this
project work, and **you only need one of them**.

## If you know Lean (no theology required)

- Improve type design, proofs, and tactics in `Testimony/`.
- Build tooling: the assumption-manifest generator, cross-reference reports,
  doc-gen integration, CI.
- Review PRs for Lean idiom and mathlib alignment.

Treat the theological content as opaque data if you like — the engineering
problems (typed references, provenance tracking, manifest generation) stand on
their own.

## If you know theology or biblical studies (no Lean required)

- Propose premise packages: what does a given tradition actually assume?
- Source citations for interpretations (commentaries, journal articles,
  critical editions).
- Review encodings: does the formal statement faithfully represent the
  argument it claims to represent? **A subtly wrong formalisation is worse
  than none** — this review is the most valuable contribution the project
  can receive.
- File issues in plain English; maintainers will pair with you on the Lean.

## Ground rules

1. **Honesty over advocacy.** The library models arguments; it does not
   campaign. Rival interpretations are encoded with the same care as the
   Christian ones.
2. **Every premise carries a source.** Uncited premises don't merge.
3. **No collapsing relation types.** If a passage is disputed between
   "prediction" and "typology", encode both, attributed.
4. **Respectful discourse.** People of all faiths and none are welcome here.
   Debate the encoding, not the person.

## Workflow

- `lake build` must pass; CI runs it on every PR.
- Small PRs, one concern each.
- Discuss significant design changes in an issue before implementing.
