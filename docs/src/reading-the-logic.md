# Reading the logic

[Contributing](./contributing.md) says you can review an encoding without knowing
Lean, and that the review this project most needs is the one only a theologian or
biblical scholar can do: *does this formal statement faithfully represent the
argument it claims to represent?*

This page is the minimum you need to answer that. It is not a logic course, and
it deliberately teaches nothing you will not use. Links to real courses are at
the end.

## Four ideas, and then you can read anything here

### An atom is a claim, quoted

An **atom** is one indivisible claim, written down once and given a name. The
logic never looks inside it. `scriptureIsSufficient` is an atom; so is
`magisteriumIsInfallible`. Each carries a label, a classification, and a source
saying who holds it and where.

Because the logic never looks inside, **everything interesting about an atom is
in its label and its citation** — which is precisely the part you can check and
the machine cannot.

### A package is a position

A **package** is one position's premises, its conclusion, and a citation for
every premise. `tridentine` is the Tridentine position; `orthodox` is the
Orthodox one. Rival positions get their own packages, with their own sources.

A package is not a claim that the position is *true*. It is a claim that this is
what the position assumes.

### Entailment is "no way out"

The premises **entail** the conclusion when there is no way of assigning
true and false to the atoms that makes every premise true and the conclusion
false. Not "the conclusion is true" — "you cannot have the premises without it."

So a result like `protestant_establishes` says: *grant these premises and you
are stuck with this conclusion.* It says nothing about whether you should grant
them. Every result in this library is conditional in exactly this way, and that
is not modesty, it is the only thing a proof assistant can check.

### A countermodel is the rival's reading, written down

To show the premises **do not** entail the conclusion, you exhibit a way for all
the premises to hold while the conclusion fails. That assignment is a
**countermodel**, and in this library it is always given a name and a docstring,
because it is not a technical device — it is a position.

`tridentineReading` says: everything else stands, and scripture is *not* the
sole infallible rule. That is Trent's reading, in the only form a machine can
check. `tridentine_not_establishes` is the result that it holds.

## Two things that go wrong, and what the library does about them

### An argument can be valid and worthless

If a package's premises **contradict each other**, then there is no way to make
them all true — so there is trivially no way to make them all true with the
conclusion false. The premises entail the conclusion, and they entail its
opposite, and they entail anything at all.

Such a result would be proved, machine-checked, free of hidden assumptions, and
completely empty. So every package that claims to establish its conclusion must
also exhibit a **model**: an assignment on which all its premises hold together.
`reformed_is_satisfiable` is one. Rule L11 fails the build without it.

A model is the mirror image of a countermodel: where a countermodel is the
rival's reading, a model is the position's **own** world — what things look like
if it is right.

### A reply can defeat an objection and prove nothing

A common move in these disputes is to grant an objection's point and deny that
it discriminates: *yes, that is circular — so is yours.* It works, in the sense
that the objection no longer goes through. It also establishes nothing, because
conceding a charge is not answering it.

The library states both halves. `compatibility_does_not_establish_criterion` is
the result recording that a reply of this kind is purely defensive. When you see
a pair like that, the second half is not a hedge; it is the price.

## What to look for when you review

The machine checks that the reasoning is valid. **Everything that makes the
encoding honest is outside what it checks**, and that is your part:

- **Is the rival's premise set one its holders would recognise?** A package that
  attributes to Orthodoxy a premise only Rome holds is a strawman, however
  valid the reasoning from it. This has happened here and was caught in review.
- **Is the citation the right one?** An atom sourced to a critic's summary of a
  position rather than to someone who holds it is the same failure, one step
  removed.
- **Is one atom doing two jobs?** If a label would be read differently by the
  two sides, the encoding has hidden the dispute instead of showing it.
- **Is a premise missing?** Especially one the argument needs and its author
  would rather not state.
- **Does the prose match the theorems?** Generated tables cannot drift, but a
  paragraph that names a result correctly and describes it wrongly will pass
  every check in this repository.

You do not need to read Lean to do any of that. You need to read the labels, the
citations, and the module's own prose.

## Further reading

For the logic itself, in increasing order of commitment:

- [*forall x*](https://forallx.openlogicproject.org/) — a free introductory
  logic textbook, and the gentlest of these. The chapters on truth tables cover
  everything this library's propositional fragment does.
- [The Open Logic Project](https://openlogicproject.org/) — a free, open
  graduate-level text, for going further.
- Stanford Encyclopedia of Philosophy:
  [Propositional Logic](https://plato.stanford.edu/entries/logic-propositional/),
  [Classical Logic](https://plato.stanford.edu/entries/logic-classical/), and
  [Modal Logic](https://plato.stanford.edu/entries/logic-modal/) — reference
  articles rather than tutorials, but authoritative and free.

Modal logic is listed because arguments about what *cannot* be otherwise need
it, and the library does not yet have it.

For how the encoding works rather than how to read it, see
[Encoding arguments](./logic.md). For what the library does and does not claim,
see [Scope and limits](./scope-and-limits.md).
