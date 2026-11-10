# Testimony

**Christian arguments from Scripture, written out premise by premise and
checked by machine.**

Testimony is two things.

1. **A guide for people reading an English Bible**, written in language precise
   enough that a theologian can work with it. Each argument page starts from
   the passages, says in plain words what each side takes them to mean, and
   names who holds each view and where they wrote it.
2. **A code library for encoding arguments and checking them for consistency.**
   Each position is a list of premises, every one with a source. Lean 4, a
   proof assistant, checks what follows from each list, what does not, and
   which positions can be held together.

Lean checks that **a conclusion follows from the premises written down**. It
cannot tell you that a reading of an ancient text is right, that an event
happened, or that a doctrine is true. So this is not a computer proving
Christianity. It is an argument with nothing hidden: every assumption listed,
every rival reading given the same care, and the judgement left to the reader.

## What you can learn from it

Take justification by faith alone (*sola fide*). The
[sola fide page](docs/src/arguments/sola-fide.md) reaches "saved through faith"
by four routes, each from its own passage:

- Paul: "not justified by works of the law but through faith in Jesus Christ"
  (Galatians 2:16);
- Jesus: "Your faith has saved you" (Luke 7:50);
- Peter, refusing to lay the law's "yoke" on gentile believers (Acts 15:10–11);
- Jesus: "This is the work of God, that you believe in him whom he has sent"
  (John 6:29).

Each route depends on one reading that some scholar cited on the page denies.
The checked results say what that means for the argument as a whole:

```lean
theorem reformed_establishes        : Establishes reformed
theorem worksOfLaw_not_load_bearing : Establishes reformedWithoutWorksOfLaw
theorem lexical_premises_jointly_load_bearing :
    ¬ Establishes reformedWithoutEveryStrandsPremise
```

In words: grant the Reformed premises and the conclusion follows. Take away the
disputed reading of "works of the law" and it still follows, by the other three
routes. Take away one disputed reading from every route and it no longer does.
So someone who denies sola fide has to answer all four passages, and someone
who defends it can see exactly which four readings they are relying on.

The same page reports results that do not favour the argument's author. When
the positions are weighed against each other, Rome's and the Reformers' tie.
The page says so, and says which single step the tie turns on.

The [roadmap](docs/src/roadmap.md) lists every result the library claims. It
is generated from the Lean source, not written by hand.

## Documentation

📖 **[Read the documentation](https://testimonyproject.github.io/testimony/)**

- [Rationale](docs/src/rationale.md) — why machine-check testimony
- [Reading the logic](docs/src/reading-the-logic.md) — the notation, for readers who
  have not met it
- [Writing for the reader](docs/src/writing-for-readers.md) — who the pages are for, and
  the standard their prose is held to
- [Scope and limits](docs/src/scope-and-limits.md) — what Lean does *not* settle
- [Encoding arguments](docs/src/logic.md) — how arguments become data
- [Citations](docs/src/citations.md) — bibliography conventions
- [Roadmap](docs/src/roadmap.md) — systematic and philosophical theology
- [Contributing](docs/src/contributing.md)

## Getting started

```sh
lake exe cache get   # fetch prebuilt Mathlib first — otherwise it builds from source
lake build           # the library: the machinery for stating and checking arguments
cd arguments && lake build   # the worked arguments, a package built on it
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
