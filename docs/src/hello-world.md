# Hello world: your first argument

> **Who wrote this page.** Drafted by Claude, an AI assistant, at Dean Berris's
> request, and **not yet rewritten by him**. The code below is not prose: it
> compiles, and the build fails if this page and the code disagree. See
> [Who wrote what](./authorship.md).

This page shows the smallest argument the library can check. It is for someone
who knows the theology and has never met Lean. You do not need to install
anything to read it.

The argument is a miniature of [Born in Bethlehem](./arguments/born-in-bethlehem.md),
cut down to three claims and one step. It is in
[`examples/HelloWorld.lean`](https://github.com/testimonyproject/testimony/blob/main/examples/HelloWorld.lean),
and every block below is copied from that file as it compiles.

## 1. Claims

An argument is built from **claims**, each a sentence the logic never looks
inside. You list them once, with a name.

```lean
{{#include ../../examples/HelloWorld.lean:claims}}
```

## 2. A citation for each claim

Every claim says who holds it, where, and how firmly. The function is *total*:
a claim with no citation does not compile. That is the whole mechanism by which
the library refuses an uncited premise.

```lean
{{#include ../../examples/HelloWorld.lean:cite}}
```

Note the third claim. Its source is a `proposal`: the library marks it wherever
it appears as an assembled position, not one reported from the literature. It is
a stand-in for this page only.

## 3. An implication

This is the heart of it. The step says: *if these two claims hold, this one
follows.* A **line of reason** is the grounds, the step, and what it delivers.

```lean
{{#include ../../examples/HelloWorld.lean:implication}}
```

## 4. Positions, and a rival written first

A **package** is one position: its premises, its conclusion, its citations.
The library will not let a reading stand alone, so the rival is written next to
it. Here it grants the quotation, denies the reading, and keeps the same step.

```lean
{{#include ../../examples/HelloWorld.lean:packages}}
```

## 5. What Lean checks

Two results. The first says the conclusion **follows** from the traditional
premises. The second says it **does not follow** from the rival's, by naming a
way for every rival premise to hold while the conclusion fails. That way is a
**countermodel**, and it is the rival's reading, written down.

```lean
{{#include ../../examples/HelloWorld.lean:results}}
```

`#print axioms` shows what each result rests on. Nothing here is `sorry`, and
nothing is an unchecked assumption beyond Lean's own foundations.

## What this does not show

It does not show that Matthew read Micah as a fulfilment, or that he did not.
Lean checks that the conclusion follows from the premises written down. Whether
the premises are right is yours to judge, and that is the point: every premise
is listed, cited and rated where you can see it.

## Where to go next

- [Reading the logic](./reading-the-logic.md) is the minimum you need to
  *review* an argument, which needs no Lean.
- [Encoding arguments](./logic.md) is for writing one.
- [Born in Bethlehem](./arguments/born-in-bethlehem.md) is this argument grown
  up: real commentary, a rated rival, and the checks the library runs over it.
- To build this file yourself, install [elan](https://github.com/leanprover/elan)
  and, from the repository root, run `lake exe cache get && lake build`, then
  `cd examples && lake build HelloWorld`.
