# Reading the logic

[Contributing](./contributing.md) says you can review an encoding without knowing
Lean, and that the review this project most needs is the one only a theologian or
biblical scholar can do: *does this formal statement faithfully represent the
argument it claims to represent?*

This page is the minimum you need to answer that. It is not a logic course, and
it deliberately teaches nothing you will not use. Links to real courses are at
the end.

### The library borrows its logic rather than inventing it

One thing worth knowing before the four ideas, because it is the reason you can
trust the rest.

This project does not define what "follows from" means. That definition comes
from [Foundation](https://github.com/FormalizedFormalLogic/Foundation), a
general-purpose formal-logic library, and this project uses it as written —
the same relation a logician would recognise, with the same name. What is local
here is only the *cataloguing*: which claims, whose, cited to what.

That division is deliberate and it is the whole basis of the guarantee. A
library that wrote its own definition of entailment could get that definition
subtly wrong, and every result in the catalogue would inherit the mistake
without any of them looking wrong. Borrowing a definition that thousands of
other theorems already depend on removes that failure mode. When you read
`Entails` here, you are reading Foundation's *logical consequence relation*,
narrowed to this project's premise lists.

The same goes in the other direction: because the relation is Foundation's,
facts Foundation has already proved about it hold here for free — that adding
premises never destroys an entailment, that a premise is entailed by the set it
belongs to, and more besides. None of those had to be re-proved, so none of
them could be re-proved wrongly.

## Four ideas, and then you can read anything here

(A fifth, further down, is needed only for the replies that settle nothing;
come back to it when you meet one.)

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

## A fifth idea, for the replies that settle nothing

### Independence: the premises settle nothing either way

Sometimes the two halves above are not two facts. Take a set of premises and
one disputed claim. Three things can be true of them:

- the premises **entail** the claim — grant them and you are stuck with it;
- the premises entail its **denial** — grant them and you are stuck without it;
- the premises do **neither**. There is a way of reading them on which the
  claim holds, and another way, equally faithful to every premise, on which it
  does not.

The third is **independence**: *the premises settle nothing either way.* It is
shown by exhibiting both readings — two of them rather than one, each satisfying
every premise, one with the disputed claim true and one with it false.

They need not agree about anything else, and usually do not. Each is a whole
position, not the other with one atom flipped: Kruger's reading refuses that
identifying the canon requires an infallible authority, while the reading that
concedes his point and still denies the sole rule refuses something else
entirely. What independence asks of the pair is only that both satisfy every
premise and that they disagree about the claim in dispute.

This is exactly what a parity reply produces. "It blocks the objection" means
the denial does not follow; "it establishes nothing" means the claim does not
follow either. Together they say the reply leaves the question open, and
`parity_leaves_the_canon_open` says it in one result instead of two.

A pair of results can hide a mistake that a single result cannot, and this is
not hypothetical. One of the three parity replies in the sola scriptura
argument was written as a pair whose halves were about *different claims* over
the same premises, while being presented as complements. Restating the pattern
as independence forced the claim to be named once, and the mismatch was
immediate.

Reading an independence result, your job is the same as ever and now doubled:
**are both readings ones someone would actually hold?** A reading nobody
occupies proves the premises settle nothing only in a sense nobody cares about.

## A sixth idea, for when positions meet

### A dispute asks who prevails, not what follows

Everything above asks one question of one position: *do these premises force
that conclusion?* A dispute asks a different question of several positions at
once: *given who defeats whom, which positions can be held, and which can hold
their ground against every attacker?*

Entailment cannot answer that, for a structural reason. Adding a premise never
takes a conclusion away — whatever follows from some premises still follows
when you add more. So in the entailment results a reply can only be encoded by
*removing* something from the objection. That is right for a reply that
declines to grant a premise. It cannot express a reply that answers an
objection by contradicting it and wins.

A dispute can. Positions become the nodes of a graph, an arrow from one to
another means the first defeats the second, and the question is which sets of
nodes survive together. This is Dung's theory of argumentation (1995), and the
library proves its main results rather than assuming them.

### Attack, refusal and defeat

One position **attacks** another when its premises entail the negation of one
of the other's premises, or of its conclusion. It is a fact about entailment,
so it is proved, and so is its absence — by naming a world in which both
positions hold.

A reply that merely **refuses** a premise — *I do not grant that* — attacks
nothing. It is a different move, and the entailment results already handle it.
Kruger's parity reply on the canon is a refusal; Berry's objection on Isaiah
7:14 is an attack, because it asserts the negation of what the critic assumes.

An attack is a **defeat** unless what it attacks is strictly better supported.
Every atom in the library carries a cited confidence, from `disputed` to
`consensus`, and a position is judged by its **weakest link**: it is no stronger
than the least supported thing it assumes. Without that comparison, attacks
between positions built from premises come in pairs — if you contradict what I
assume, I contradict what you conclude — and nobody ever prevails.

**This is the one place where a confidence rating decides a result.** Elsewhere
a rating tells you how firmly a premise is held. In a dispute it can decide who
wins, and contesting the rating is contesting the result.

A note on vocabulary: several older results say a reply "defeats" an objection
— `compatibility_defeats_lexical_objection` is one. There the word means the
objection no longer reaches its conclusion once the reply is granted, an
entailment fact. In a dispute, **defeat** is the relation just described.

### Grounded and preferred: two ways to say who survives

- The **grounded extension** is what the dispute *forces*: the positions left
  standing if you accept only what cannot be resisted. When two sides defeat
  each other, it takes neither.
- A **preferred extension** is one way the dispute *can be resolved*: a set of
  positions that do not defeat one another and answer every defeat on any of
  them, made as large as it can be. A dispute can have several.

The Isaiah 7:14 dispute shows both. Against the scriptural reading alone,
nothing is forced: the critic and the scriptural reading each rest on a premise
rated `disputed`, so each defeats the other, the grounded extension is empty,
and there are two preferred extensions, one for each side. Add the replies:
Berry, Postell and Motyer. Each defeats the critic, by denying a premise the
critic's case turns on, and the critic cannot defeat them back, because those
contested premises are its weakest. Now the grounded extension is the
scriptural reading with all three replies: they defend it against its only
defeater. The replies have not proved the predictive reading. They have answered
the objection to it, which is what a reply is for.

Reading a dispute, check the two things the machine cannot: **is each position
one someone holds, and is each rating one its source would stand behind?**

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
- **Is a confidence rating deciding a dispute?** In a dispute the ratings are
  premises. A rating nobody would defend can hand a position a win it has not
  earned.
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

For disputes, the Stanford Encyclopedia's
[Argument and Argumentation](https://plato.stanford.edu/entries/argument/)
introduces Dung's frameworks, and
[Defeasible Reasoning](https://plato.stanford.edu/entries/reasoning-defeasible/)
covers the grounded and preferred semantics this library uses.

Modal logic is listed because arguments about what *cannot* be otherwise need
it, and the library does not yet have it.

For how the encoding works rather than how to read it, see
[Encoding arguments](./logic.md). For what the library does and does not claim,
see [Scope and limits](./scope-and-limits.md).
