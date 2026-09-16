# Testimony

**A Lean 4 library for machine-checkable models of biblical Messianic arguments.**

Testimony formalises the Christian argument from Scripture that Jesus of Nazareth
is the promised Messiah — with every textual, linguistic, historical,
hermeneutical, and theological premise made explicit, sourced, and contestable.

## What this project is — and is not

Lean verifies that **conclusions follow from encoded premises**. It cannot, by
itself, establish that an interpretation of an ancient Hebrew text is correct,
that a historical event occurred, or that a theological premise is true.

So Testimony is **not** a "computer proves Christianity" system. It is a
*machine-checked testimony*: the argument's structure laid bare, its assumptions
enumerated, its verdict left to the reader. A sceptic can see exactly which
premises are assumed; a believer can see precisely how the argument hangs
together; a scholar can swap in a rival interpretation and watch the derivation
diverge.

Every theorem ships with an **assumption manifest** — a generated report listing
each unproven premise, typed as *textual*, *linguistic*, *historical*,
*theological*, or *interpretive*, with its source citation.

## Architecture

| Layer | Contents |
|---|---|
| 1. Text & canon | Book/chapter/verse references, language, textual tradition, canon parameterisation |
| 2. Linguistic analysis | Lemma, morphology, syntax — imported with provenance (BHSA, Open Scriptures, STEPBible) |
| 3. Intertextual relations | Quotation, allusion, typology, prediction — *distinct* relation types, each with source and confidence |
| 4. Historical claims | Events, authorship, dates, witness testimony — separate from text-internal claims |
| 5. Premise packages | Hermeneutical and theological assumptions as versioned, *alternative* packages |
| 6. Formal reasoning | Typed definitions, conditional theorems, consistency checks, assumption manifests |

## Getting started

```sh
lake build
```

Requires [elan](https://github.com/leanprover/elan). VS Code with the
[lean4 extension](https://marketplace.visualstudio.com/items?itemName=leanprover.lean4)
is the recommended editor.

## Contributing

Two kinds of contributors are equally welcome — see [CONTRIBUTING.md](CONTRIBUTING.md):

- **Lean people**: no theology required. Types, tactics, tooling, CI.
- **Theology/biblical-studies people**: no Lean required. Premise sourcing,
  rival interpretations, citations, review of encodings.

## License

Code: Apache-2.0. Data and documentation: CC-BY 4.0.
