# Roadmap

## Where the library is

Four arguments are worked end to end, each with at least one rival package:

| Argument | Result |
|---|---|
| Bethlehem (Micah 5:2) | Christian package establishes; critical reading does not; `Satisfies` witness |
| Virgin birth (Isaiah 7:14) | Establishes; critical reading does not; **עַלְמָה is load-bearing** |
| Sola fide | Reformed establishes; **so does the New Perspective**; Trent does not; **neither lexical premise is load-bearing alone**; the James harmonisation is |
| Sola scriptura *(seeded)* | Protestant establishes; Catholic/Orthodox does not; self-refutation objection is valid |

Two findings emerged that were not designed for.

**Redundancy defeats a lexical dispute.** Sola fide runs on two independent
strands — Paul's ἔργα νόμου and Jesus' σέσωκέν σε at Luke 7:50 — and neither
lexical premise carries the argument alone. Only their disjunction does. An
opponent must defeat both readings, not either.

**Which is why the virgin-birth argument is the weaker one.** It has a single
strand, so defeating עַלְמָה defeats it outright. There is no dominical saying
about a virgin birth to fall back on. The contrast between the two arguments is
a structural fact about them, not a matter of taste, and the library states it
in a form either side can check.

A corollary worth noting: because the New Perspective rejects the traditional
reading of Paul's phrase while still affirming justification by faith, it
**establishes the conclusion too**. Winning the ἔργα νόμου argument is not a
defeat of sola fide.

## Near term

**More messianic prophecies.** The canonical dozen — Isaiah 53, Psalm 22,
Zechariah 9:9, Daniel 9, Psalm 110 — each with competing packages. Then the
first aggregate result: a `MessiahDefinition` with several criteria and a
`MeetsDefinition` theorem, which will expose how sensitive a cumulative case is
to its weakest link.

**The remaining solas.** *Sola gratia*, *solus Christus*, *soli Deo gloria*,
and completing *sola scriptura* past its seed.

**Corpus grounding.** Importers so `Passage` values resolve against real text
data (BHSA, OSHB, STEPBible). At that point linguistic premises can cite actual
morphological annotation rather than a commentary's report of it — which
matters most for exactly the lexical premises that keep turning out to be
load-bearing.

**Old Testament `Book` completion.** The New Testament is complete; the Old is
partial.

## Systematic theology

The natural extension. Doctrine is already structured the way this library
wants: confessional standards state positions in numbered articles, and the
relations between doctrinal loci are exactly the dependency structure the
manifest machinery tracks.

- **Confessional standards as versioned, citable axiom sets** — the Nicene
  Creed, the Chalcedonian Definition, the Westminster Confession, the Catechism
  of the Catholic Church. Each becomes an `ArgumentPackage` whose atoms cite
  specific articles.
- **Cross-locus consistency checking.** Do a tradition's commitments on
  Christology, the atonement and justification cohere? This is a question about
  a set of formulas, and it is decidable for the propositional fragment.
- **Dependency tracing.** Which doctrines rest on which exegetical premises? If
  a reading of Romans 5 is abandoned, what else moves? Prose systematic
  theology cannot answer this; a generated manifest can.

The divinity of Christ is the obvious target and the hardest: it is a
cumulative argument drawing on the Johannine prologue, the *ego eimi* sayings,
worship texts, and the Chalcedonian settlement's reading of all of them. It
should be attempted only once the aggregate machinery has been tested on the
messianic prophecies, where the premises are simpler.

## Philosophical theology

This is why the substrate choice matters. Foundation supplies modal logic and
Kripke semantics, so the arguments that need `□` and `◇` are reachable without
changing foundations.

- **Divine attributes and their alleged incompatibilities.** The omnipotence
  paradoxes, and the foreknowledge/freedom problem — where the formal question
  is whether a set of attribute definitions is jointly satisfiable, which is
  precisely what a model-theoretic treatment settles.
- **The classical arguments.** Cosmological, ontological, moral. The
  ontological argument is the best-charted territory: Benzmüller and
  Woltzenlogel Paleo's machine-verified formalisation of Gödel's proof both
  demonstrates feasibility and illustrates the payoff, having discovered that
  Gödel's axioms collapse modal distinctions — a structural fact a century of
  prose commentary had missed.
- **Theodicy structures.** The logical problem of evil is a consistency claim
  about a premise set, which is the shape of problem this machinery handles
  best.

## Infrastructure

- **An assumption-manifest browser** on the docs site: every theorem, every
  premise it rests on, every citation, cross-linked.
- **Probabilistic and evidential reasoning**, in a separate namespace, never
  conflated with deduction. Cumulative-case apologetics is Bayesian in
  structure, and pretending otherwise would misrepresent it.
- **API documentation.** doc-gen4 arrives transitively via Foundation and the
  `Testimony:docs` facet works, but `lake build Testimony:docs` generates
  documentation for the entire Mathlib closure, which is far too slow to run in
  CI. Publishing API docs needs either a way to scope generation to this
  library's own modules, or a separately cached job. It is deliberately absent
  from the docs workflow until then.

## What will not change

The conditional form of every result, the requirement that rivals be encoded
with equal care, and the prohibition on undeclared axioms. These are what make
the rest worth reading.
