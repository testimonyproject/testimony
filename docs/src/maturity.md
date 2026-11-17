# How far each argument is checked

Every argument on this site builds, and every build runs the same checks. Lean
checks that each conclusion follows from its premises, that every premise can be
held with the others, and that every verdict is what the weighing computes. Those
checks reach the whole of every argument. Three others reach only part of it,
and how far they reach differs a great deal from one argument to the next.

The three need to know what a claim *means*, not only how it is labelled.

- **Meanings.** A claim's meaning is analysed when it is written out word by
  word: who is said to do what, and in what sense each word is used. Until then
  the library knows the claim only as a sentence with a source.
- **The shared ontology.** Where two analysed claims cannot both be true, or one
  brings the other with it, that is a *join*, and the argument must state it.
  Some joins can be seen in the meanings alone. Others are found only through
  the library's definitions of words such as "the whole ground" or "one length
  of time". The table counts the joins, how many of them needed a definition,
  and how many of the definitions bear on the argument's claims.
- **Fallacies.** Each line of reason (one step from its grounds to what it
  delivers) is checked for three faults: using a word in two senses where the
  step needs one (equivocation), assuming in a premise what the step is meant to
  show (begging the question), and arguing from what a text does not say without
  showing that it would have said it (arguing from silence). A line is read
  only when every claim it touches is analysed.

A line that equivocates, or argues from silence alone, fails the build. So the
table never shows one. What it shows is how many lines have been read at all,
and two conditions that are reported without failing: a line whose premise
already asserts what it delivers, which begs the question only for a reader who
denies that premise; and a line that needs a word to keep one sense, and does not
say so.

## The stages

Each argument is given a stage, defined by the counts alone.

- **Not yet read**: no claim's meaning is analysed, so the ontology joins nothing
  and no line is read.
- **Meanings begun**: some claims are analysed, and no line is read yet, because
  every line still touches a claim that is not.
- **Lines being checked**: the fallacy checks read some lines.
- **Fully read**: every claim is analysed and every line is read.

A stage says how far the checks reach. It says nothing about whether an argument
is right, how well it is sourced, or whether its pages are finished. An argument
"not yet read" may be fully cited and carefully weighed. It has only not yet
been checked for these three faults.

## The arguments

The table is generated from the checks themselves when the library is built,
and CI fails when it is out of date. Work on the gaps is tracked in
[#236][issue].

<!-- BEGIN GENERATED: lake exe statusgen -->

**8 arguments**: 200 of 471 claims have analysed meanings, and the fallacy checks read 52 of 188 lines of reason.

| Argument | Stage | Claims with meanings | Lines read for fallacies | What the fallacy checks found | Joins found | Definitions in use |
|---|---|---|---|---|---|---|
| [Born in Bethlehem — Micah 5:2](./arguments/born-in-bethlehem.md) | not yet read | 0 of 7 | 0 of 2 | — | none | 0 |
| [Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3](./arguments/born-of-a-virgin.md) | meanings begun | 25 of 95 | 0 of 41 | — | 16, 9 through a definition | 1 |
| [Sola fide](./arguments/sola-fide.md) | lines being checked | 97 of 128 | 31 of 49 | 12 need a word kept in one sense, unstated | 5, 1 through a definition | 4 |
| [The canonical witness — faith alone, from the texts all parties accept](./arguments/canonical-witness.md) | meanings begun | 5 of 29 | 0 of 8 | — | 7, none of them through a definition | 1 |
| [Sola scriptura](./arguments/sola-scriptura.md) | lines being checked | 54 of 64 | 21 of 27 | nothing | 3, none of them through a definition | 3 |
| [Sola gratia — Ephesians 2:8–9 and Romans 9:16](./arguments/sola-gratia.md) | meanings begun | 15 of 57 | 0 of 27 | — | 1, none of them through a definition | 3 |
| [Spirit baptism — at conversion, after it, or in the sacraments](./arguments/spirit-baptism.md) | meanings begun | 4 of 15 | 0 of 0 | no lines of reason to read | 2, none of them through a definition | 0 |
| [The Triune God — what Scripture settles, and what it leaves open](./arguments/trinity.md) | not yet read | 0 of 76 | 0 of 34 | — | none | 0 |
<!-- END GENERATED: lake exe statusgen -->

[issue]: https://github.com/testimonyproject/testimony/issues/236
