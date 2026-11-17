# Who wrote what

> **Draft for Dean Berris's approval.** This page is a proposal, not yet
> approved. It was drafted by Claude, an AI assistant.

Much of the prose in this documentation was drafted by Claude, Anthropic's AI
assistant, working with Dean Berris, who started the project and is its only
maintainer. Dean has not yet rewritten it, and intends to once the foundations
in Lean settle. Until then the prose reads as machine prose: long, even, and
short on a human voice. A reader who finds that tiring is right, and this page
exists so you know what you are reading.

## What the machine checks, and what it does not

Whoever wrote it, these parts are checked by Lean, and the build fails if they
are wrong:

- that each result's conclusion follows from the premises written down;
- that a rival's countermodel really does satisfy every premise of the rival
  while falsifying the conclusion;
- that every claim has a citation, because a claim without one does not compile;
- that the code on the [Hello world](./hello-world.md) page is the code that
  compiles.

These parts are **not** checked, and need a human reader:

- the prose around the results;
- whether a cited source says what the entry says it does;
- whether a rating (`consensus`, `wellSupported`, `plausible`, `disputed`)
  is the right rating;
- whether a formal statement faithfully represents the argument it names.

The last three are the review this project most needs. It needs a theologian
or biblical scholar, and it needs no Lean. See [Reading the logic](./reading-the-logic.md).

## How a page says who wrote it

A page begins with a note naming its author, once that has been settled:

- **Written by Dean.** Human exposition.
- **Drafted by Claude, rewritten by Dean.** The structure is Claude's; the words
  are his.
- **Drafted by Claude, not yet rewritten.** The state of most pages today.

A page with no note has not yet been labelled. Read it as *drafted by Claude,
not yet rewritten*, which is the safe assumption.

## Why this is written down

An argument whose purpose is that nothing is hidden should not hide how it was
written. A theologian reviewing a page should know whether a person or a
language model chose its words, because the two fail differently. The first
may be wrong, and the second may be fluent and wrong at once.

If you can help bring the prose to a human voice, the project would like that.
See [Contributing](./contributing.md).
