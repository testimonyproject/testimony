# Testimony

**A Lean 4 library for machine-checkable models of biblical arguments.**

Testimony formalises Christian arguments from Scripture — that Jesus of
Nazareth is the promised Messiah, that salvation is by grace through faith —
with every textual, linguistic, historical, hermeneutical and theological
premise made explicit, sourced, and contestable.

## What this project is — and is not

Lean verifies that **conclusions follow from encoded premises**. It cannot, by
itself, establish that an interpretation of an ancient Hebrew text is correct,
that a historical event occurred, or that a theological premise is true.

So Testimony is **not** a "computer proves Christianity" system. It is a
*machine-checked testimony*: the argument's structure laid bare, its
assumptions enumerated, its verdict left to the reader. A sceptic can see
exactly which premises are assumed; a believer can see precisely how the
argument hangs together; a scholar can swap in a rival interpretation and watch
the derivation diverge.

## What it produces

Three kinds of result, all machine-checked:

**An argument is valid.** Given a named, cited premise package, the conclusion
follows over every valuation.

```lean
theorem reformed_establishes : Establishes reformed
```

**A rival package does not establish the conclusion.** This is not a failure to
find a proof; a countermodel is exhibited.

```lean
theorem newPerspective_not_establishes : ¬ Establishes newPerspective
```

**A particular premise is load-bearing.** Remove it, retain everything else,
and the argument collapses.

```lean
theorem worksOfLaw_is_load_bearing : ¬ Establishes reformedWithoutLexicalPremise
```

That last kind is the most useful thing the library does. It locates precisely
where a disagreement lives — and so far, two of the three fully worked
arguments turn out to hinge on the sense of a single word.

## Getting started

```sh
lake exe cache get   # fetch prebuilt Mathlib — do this first
lake build
```

Requires [elan](https://github.com/leanprover/elan). The toolchain is pinned to
Lean v4.33.1 by the Foundation dependency.

## License

Code: Apache-2.0. Data and documentation: CC-BY 4.0.
