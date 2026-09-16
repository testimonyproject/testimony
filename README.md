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
theorem reformed_establishes       : Establishes reformed
theorem worksOfLaw_not_load_bearing : Establishes reformedWithoutWorksOfLaw
theorem sozo_not_load_bearing       : Establishes reformedWithoutSozo
theorem lexical_premises_jointly_load_bearing :
    ¬ Establishes reformedWithoutEitherLexicalPremise
```

Read together, those say something prose arguments rarely establish. Sola fide
runs on **two independent strands** — Paul's ἔργα νόμου, and Jesus' "your faith
has saved you" at Luke 7:50 — and *neither* disputed lexical premise carries
the argument by itself. Only their disjunction does, so an opponent must defeat
both readings rather than either.

A corollary: the New Perspective on Paul, which rejects the traditional reading
of ἔργα νόμου while still affirming justification by faith, **establishes the
conclusion too**.

The virgin-birth argument makes the contrast. It has a single strand, so
defeating עַלְמָה in Isaiah 7:14 defeats it outright — a structural weakness the
library states plainly rather than glossing.

## Documentation

📖 **[Read the documentation](https://testimonyproject.github.io/testimony/)**

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
dependency. Alternatively, open the repo in the devcontainer
(`.devcontainer/`) for elan, the pinned toolchain, tectonic, mdbook and
python3 preinstalled — the same image CI builds in.

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

Two licences, split by what the file is:

- **Code** — Lean sources, `scripts/`, build tooling: [Apache License
  2.0](LICENSE).
- **Documentation and data** — `docs/`, the encoded premises, citations and
  generated prose: [Creative Commons Attribution 4.0
  International](LICENSE-CC-BY-4.0).

Scripture and the commentary literature are quoted for citation and criticism;
those works remain under their own terms, recorded per entry in the
[bibliography](docs/src/bibliography.md).
