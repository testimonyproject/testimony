# Hello world: your first argument

> **Who wrote this page.** Drafted by Claude, an AI assistant, at Dean Berris's
> request, and not yet rewritten by him. The code below is not prose: it
> compiles, and the build fails if the code on this page stops working. See
> [Who wrote what](./authorship.md).

This page walks through the smallest argument the library can check, one piece
at a time. It is written for someone who knows their Bible and has never seen a
line of code. You do not need to install anything to read it, and you will not
be asked to write any of it. If you contribute through Claude Code, Claude
writes the code; [Contributing with Claude Code](./getting-started.md) explains
how that works. What you need from this page is enough to read a file like this
one and say "yes, that is what I meant", or "no, that premise is wrong".

## The question

Matthew tells how the wise men came to Herod, and how the chief priests and
scribes told him where the Messiah would be born: "In Bethlehem of Judea, for so
it is written by the prophet" (Matthew 2:5). Then they quote Micah:

> "And you, O Bethlehem, in the land of Judah, are by no means least among the
> rulers of Judah; for from you shall come a ruler who will shepherd my people
> Israel." (Matthew 2:6, ESV, quoting Micah 5:2)

The last line is not Micah's: it comes from 2 Samuel 5:2, where God tells David
"you shall be shepherd of my people Israel". And Matthew does not use his usual
words, "this took place to fulfil", which is one reason readers differ.

Christians have long read Matthew as saying that Micah's words came true in
Jesus. A reader can also take Matthew to be borrowing an old text for a new
occasion, without claiming that it predicted anything. On this page that second
reading is a stand-in, written for the example and cited to no one. The full
argument, [Born in Bethlehem](./arguments/born-in-bethlehem.md), states the
critical reading as its holders do and cites Raymond Brown for it.

So there are two positions, and one question to put to each: grant everything
this side says, and does it follow that Matthew presents Micah's words as
fulfilled?

The whole example is in one file,
[`examples/HelloWorld.lean`][hello-lean]. Every block below is copied from that
file by the tool that builds this site, so the page and the working code
cannot drift apart. Lines that begin with `--` are notes for a human reader,
and the computer ignores them.

[hello-lean]: https://github.com/testimonyproject/testimony/blob/main/examples/HelloWorld.lean

## 1. The claims

An argument is built from claims. Each claim is one sentence that can be
granted or denied, and each gets a short name so the rest of the file can refer
to it. The English sentence sits above the name, between `/--` and `-/`.

```lean
{{#include ../../examples/HelloWorld.lean:claims}}
```

The computer never reads the English. It checks only how the named claims are
joined together. So the English is the only place a human reader can check
that a claim says what the argument needs it to say. When you review an
argument, this is the first list to read.

## 2. A citation for every claim

Every claim says where it comes from, which way of reading it belongs to, and
how firmly it is held. There are four ratings, from weakest to strongest:
*disputed* (scholars actively contest it), *plausible* (defensible, not
established), *well supported* (widely held, not universally) and *consensus*
(accepted across traditions, including by people with no stake in it). A fifth,
*refuted*, is never a reader's to give. The library gives it to a claim about
the Greek that the Greek text, as its data parses it, contradicts, and the build
fails wherever a citation says otherwise.

```lean
{{#include ../../examples/HelloWorld.lean:cite}}
```

The file will not build if any claim is missing from this list. So the library
refuses a premise with no source without anyone having to remember a rule: the
computer will not go on without one.

Two other fields appear on each citation. `kind` says whether a claim is about
what the text says (*textual*) or about how to read it (*interpretive*).
`tradition` names the school of reading it belongs to. Here that is mostly
historical-grammatical exegesis, which reads a text by its grammar and its
original setting; the rival belongs to critical scholarship.

Look at the third claim. Its source is a *proposal*: a position assembled for
the occasion, not reported from a book. Wherever it appears, the library marks
it as such, and the note says why it is there. An argument you write yourself,
which nobody in print has made, is welcome on the same terms. It is marked as
your proposal, so a reader can tell what the library reports from what it
constructs.

## 3. One step of reasoning

This is the heart of an argument: *if these claims hold, that one follows.*
Three symbols carry it. `p .name` means "this claim holds". `⋀ [A, B]` means
"A and B, together". The arrow `➝` means "therefore".

```lean
{{#include ../../examples/HelloWorld.lean:implication}}
```

The step and its claims together make a *line of reason*: what it starts from
(its grounds), the step, and what it delivers. It is the library's way of
writing down one stretch of argument as a person would say it aloud: "Matthew
quotes Micah, and he means it as a fulfilment, so he presents it as fulfilled."

## 4. Two positions, side by side

A position is called a *package*. It bundles the lines of reason someone holds,
the conclusion they draw, and the citations. The library will not accept one
reading on its own, so the rival is written directly after it. One more symbol
appears here: `notP .name` means "this claim does not hold".

```lean
{{#include ../../examples/HelloWorld.lean:packages}}
```

`def name : … :=` gives something a name, so the rest of the file can use it.
`caseOf [fulfilmentLine] [] []` gathers a position's premises from its lines of
reason; the two empty lists are for premises shared across lines and for
closing steps, which this small example does not need. `{ traditional with … }`
means "the same as `traditional`, except for what follows".

So the rival is written as "the traditional line, with these grounds instead",
and nobody has to compare two long lists by eye to see what changed. The rival
grants that Matthew quotes Micah, holds that he applies the verse to a new
situation, and denies that he reads it as a fulfilment. It keeps the same step,
but that step needs the fulfilment reading as one of its grounds, and the rival
denies it, so the step never applies.

## 5. What the computer checks

Two results. A `theorem` is a statement the computer has checked. The lines
after `by` tell it how to check the statement, and you can skip them: if they
were wrong, the file would not build.

```lean
{{#include ../../examples/HelloWorld.lean:results}}
```

The first result says that the conclusion *follows* from the traditional
position. Grant its premises and you must grant the conclusion.

The second says that the conclusion *does not follow* from the rival position.
That is a stronger thing than "no proof was found". The file writes down one way
the world could be, as a list of which claims are true and which false, on which
every premise of the rival holds and the conclusion fails. Such a list is
called a *countermodel*, and the computer checks it claim by claim. If it
passes, no proof of the conclusion from those premises can exist. Here the
countermodel is simply the rival's reading, written out.

In the countermodel, `fun a => match a with` means "for each claim, look it
up", the two named claims are set to `False`, and `_ => True` means "every other
claim: true".

The `#print axioms` lines report what each result rests on. Both rest only on
two principles built into Lean itself (`propext` and `Quot.sound`). The project
added no assumption of its own to reach them. The premises are granted rather
than proved, and that is what the next section is about.

## What this does not show

It does not show that Matthew read Micah as a prophecy fulfilled, or that he
did not. The computer checks that a conclusion follows from the premises
written down. Whether those premises are right is yours to judge. That is the
point of writing them down: every premise is listed, cited and rated where you
can see it, and so is every premise of the other side.

## Where to go next

- [Contributing with Claude Code](./getting-started.md): how to bring an
  argument of your own, with no programming.
- [Reading the logic](./reading-the-logic.md): the few ideas you need to
  review any argument on this site, still with no code to write.
- [Born in Bethlehem](./arguments/born-in-bethlehem.md): this argument grown up,
  with real commentary, a cited rival, and every check the library runs.
- [Encoding arguments](./logic.md): for those who want to write the Lean
  themselves.

In a Claude Code session on the web all of this is already set up: ask Claude
to build the file and it will. To build it on your own computer instead,
install [elan](https://github.com/leanprover/elan), download the project with
`git clone https://github.com/testimonyproject/testimony`, then in a terminal
run `cd testimony && lake exe cache get && lake build`, and then
`cd examples && lake build HelloWorld`.
