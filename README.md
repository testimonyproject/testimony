# Testimony

**A Lean 4 library for machine-checkable models of biblical arguments.**

Testimony formalises Christian arguments from Scripture — that Jesus of
Nazareth is the promised Messiah, that salvation is by grace through faith —
with every textual, linguistic, historical, hermeneutical and theological
premise made explicit, sourced, and contestable.

Lean verifies that **conclusions follow from encoded premises**. It cannot
establish that an interpretation of an ancient Hebrew text is correct, that a
historical event occurred, or that a theological premise is true. So this is
not a "computer proves Christianity" system. It is a *machine-checked
testimony*: the argument's structure laid bare, its assumptions enumerated, its
verdict left to the reader.

## What it produces

```lean
theorem reformed_establishes           : Establishes reformed
theorem newPerspective_not_establishes : ¬ Establishes newPerspective
theorem worksOfLaw_is_load_bearing     : ¬ Establishes reformedWithoutLexicalPremise
```

The third is the most useful kind. It says: strip out the premise that Paul's
ἔργα νόμου means works in general rather than Jewish covenant boundary markers,
keep everything else, and the Reformed argument for sola fide collapses.

That result is neither Protestant nor Catholic. It is a description of where
the disagreement actually lives, and both sides can accept it.

So far **two of the three fully worked arguments turn on the sense of a single
word** — the other being עַלְמָה in Isaiah 7:14.

## Documentation

📖 **[Read the documentation](https://deanberris.github.io/testimony/)**

- [Rationale](docs/src/rationale.md) — why machine-check testimony
- [Scope and limits](docs/src/scope-and-limits.md) — what Lean does *not* settle
- [Encoding arguments](docs/src/logic.md) — how arguments become data
- [Citations](docs/src/citations.md) — bibliography conventions
- [Roadmap](docs/src/roadmap.md) — systematic and philosophical theology
- [Contributing](docs/src/contributing.md)

## Getting started

```sh
lake exe cache get   # fetch prebuilt Mathlib first — otherwise it builds from source
lake build
```

Requires [elan](https://github.com/leanprover/elan). Lean v4.33.1, pinned by
the [Foundation](https://github.com/FormalizedFormalLogic/Foundation)
dependency.

## Contributing

Two kinds of expertise make this work, and **you only need one**:

- **Theology or biblical studies, no Lean required.** Review whether an
  encoding faithfully represents the argument it claims to. This is the
  contribution the project most needs — a subtly wrong formalisation is worse
  than none, and no proof assistant can catch it.
- **Lean, no theology required.** Types, proofs, tooling. The theological
  content can be treated as opaque data.

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Code: Apache-2.0. Data and documentation: CC-BY 4.0.
