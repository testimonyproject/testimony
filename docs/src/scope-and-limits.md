# Scope and limits

This chapter states what the library does not do. It is here near the front,
before the claims, on purpose.

## What Lean settles

Exactly one thing: whether a conclusion follows from the premises as encoded.
Where it does, `tauto` produces an ordinary proof term and Lean's kernel checks
it; where it does not, a named valuation satisfies every premise while
falsifying the conclusion, and the kernel checks that. Nothing else is verified
by the machine.

## What Lean does not settle

**Whether the premises are true.** That Micah 5:2 is a forward-looking
prediction is an interpretive claim held by some traditions and denied by
others. The library records who holds it, with what confidence, and on what
authority. It does not adjudicate the claim.

**Whether the confidence ratings are right.** A rating records how firmly a
source holds a claim, and elsewhere it is information for a reader. In a
*dispute* it is more: which position defeats which depends on the ratings, so a
dispute's outcome is conditional on them in exactly the way a result is
conditional on its premises. Lean checks what follows from the ratings. Whether
a rating is fair to its source is a judgement it cannot make, and the Isaiah
7:14 dispute names the ratings it rests on.

**Whether the encoding is faithful.** That a Lean formula represents the
argument a commentary actually makes is a human judgement. No proof assistant
can check it, and it is the most common way a formalisation goes wrong. This is
why encodings need review by people who know the literature, and why a subtly
wrong formalisation is worse than none.

**Whether the atoms carve the argument correctly.** Choosing which atomic
claims carve sola fide is already an interpretive act. A different carving might
make a different premise load-bearing. The atoms are visible and arguable, and
that is the best the method offers.

**Whether the argument is the best one available.** The library encodes
particular arguments from particular sources. A better argument for the same
conclusion may exist and simply not be encoded yet.

## Circularity, specifically

An argument that Scripture predicts X, which reads Scripture as predicting X,
and cites only Scripture for that reading, is assuming part of what it sets out
to establish.

The library does not forbid this. Sometimes a text really is plain, and
demanding external corroboration for every reading would be its own distortion.
What the library does is make it **computable**: `Source.isScriptureOnly` is
`true` exactly when a premise appeals to Scripture with no scholarly support,
and `ArgumentPackage.scriptureOnlyAtoms` lists them.

In the Bethlehem argument, `jesusBornInBethlehem` is such a premise: the
historicity of the Bethlehem birth is disputed in critical scholarship, and the
argument assumes it on the authority of the texts whose reading is in question.
That is stated in the module, and it is visible in the manifest.

## The trust base

Results depend on Lean's kernel and on three axioms: `propext`,
`Classical.choice`, and `Quot.sound`. Nothing else.

This is enforced rather than asserted. `lake exe axiom-audit` inspects the
kernel environment — not the source text — and fails CI if any declaration
depends on anything outside that allowlist. It catches `sorry` (which appears
as `sorryAx`), `native_decide` (which adds `Lean.ofReduceBool`), and any
hand-rolled axiom arriving through an import.

`native_decide` is prohibited outright. A project whose entire claim is that
every assumption is declared cannot rest results on an undeclared one.

This gate has already earned its place. During development a `decide` proof
failed silently and fell back to `sorryAx`; the axiom audit caught it, and the
underlying API was removed.

## What is deliberately out of scope for now

- **Probabilistic and evidential reasoning.** Cumulative-case arguments update
  on evidence; that is a different formal apparatus and will live in a separate
  namespace, never conflated with deduction.
- **Corpus grounding.** `Passage` values are references, not text. They do not
  yet resolve against real manuscript data.
- **Modal logic.** Needed for divine-attribute arguments. *Not* part of
  Foundation, contrary to what this page said until recently: it is a sibling
  package in the same family, depending on Foundation and sharing its
  interfaces, so reaching it means adding a dependency rather than changing
  substrate. See the [roadmap](./roadmap.md).
- **Quantification.** Every argument here is propositional, so a claim whose
  force depends on *scope* — this holds of doctrine but not of practice — is
  carried by atom design and by prose rather than by the logic. Foundation's
  first-order fragment would close this and is already a dependency; it is
  unused, not unavailable.
