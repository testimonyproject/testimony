# Telling an exchange

An argument's page sets out each line of reason on its own. A reader also asks how the lines
meet. Who answers whom? Where do two readings stand off, neither giving way? Which reply leaves
the objection standing? Written as prose alone, every "this answers Howell" is a claim that
nothing checks. A **bundle** tells one such exchange as a list of turns, in the order a reader
meets them, and the build checks every word that joins them.

## Turns, and how they meet

Each turn is a party to a dispute, with the paragraph that tells it. A turn may say how it
stands to a turn before it:

- it **answers** that turn: it defeats it, and is not defeated by it in return;
- it **meets** that turn: each defeats the other, so neither gives way;
- it **stands apart** from that turn: neither defeats the other;
- it **responds** to that turn: neither defeats the other, but the two share a claim;
- it **evades** that turn: told as a reply, it shares no claim with it, a red herring.
- it **restates** that turn: it sets out the same position again, with the same conclusion;
- it **concedes** to that turn: it concludes something else, and says it gives the first up;
- it **shifts** from that turn: told as the same position once that turn has been answered, it
  concludes something else, which is moving the goalposts.
- it **ignores** a rebuttal of that turn: it sets out the same position again, and does not
  defeat a turn that defeated it.

A turn with none of these simply enters the exchange.

```lean
/-- The meeting's length, told as an exchange. -/
declare_bundle meetingLength in finite where
  /-- The clock says the meeting ran two hours. -/
  turn Party.clock
  /-- The minutes say it ran one, and they answer the clock. -/
  turn Party.minutes answers Party.clock
```

`finite` is the dispute in the solver's form, which every `declare_dispute` gives as
`D.finite` and every hearing as `H.finite`. Each stated relation is computed from it when the
bundle is declared, and checked again by the kernel. So the words that join the turns are what
the solver finds, and a bundle that says "answers" where the solver finds a standoff does not
build:

```text
error: declare_bundle: a turn said to meet an earlier turn, where the solver finds:
  Party.minutes defeats Party.clock
  Party.clock does not defeat Party.minutes
Change what the bundle says, not the encoding.
```

The fix is to the prose. A rating moves only with a new, cited argument, never to make an
exchange read the way its author hoped.

A turn may name only a party that an earlier turn has already set out, because a reply cannot
come before what it replies to.

## A fallacy set out, and answered

A turn may quote a line of reason: `turn Party.clock quoting strawMan`. If that line declares a
fallacy it commits ([Declaring a fallacy where it is committed][declaring]), a later turn must
answer the turn that quotes it. A fallacy is set out in a bundle only to be answered there, and
a bundle that leaves one standing does not build.

## A reply, and a red herring

Two positions that neither defeats the other may still be about the same thing. A turn that
**responds** to an earlier one says so: neither defeats the other, and the two share a claim, or
a meaning that joins two of their claims, as "the meeting lasted an hour" and "the meeting
lasted two hours" are joined by what *lasts* means. The build reads which claims each position
rests on or delivers, and refuses a reply that shares none:

```text
error: declare_bundle: a turn said to reply to an earlier turn shares no claim with it,
and no meaning. A reply on another subject is a red herring: say `evades`, and
answer it in a later turn.
```

A reply that shares nothing with what it replies to is a red herring: it changes the subject.
An author may set one out, as a debate sometimes has one, by writing that the turn **evades**
the earlier one. The build then checks that the two really share nothing, and the turn is
treated as a declared fallacy: a later turn must answer it. Where the solver finds a defeat, the
two positions always share a claim, so a defeat is told as an answer or a meeting, never as a
reply.

## Moving the goalposts

A position that has been answered sometimes comes back. If it comes back with the conclusion it
had, the turn **restates** it. If it comes back concluding something else, and is still told as
the same position, it has moved the goalposts: it changes what is defended once the first claim
has been answered. An author sets that out by writing that the turn **shifts** from the earlier
one. The build checks that the two conclusions differ and that some earlier turn answered the
first, and a later turn must answer the shift. A turn that gives the first conclusion up, and
says so, **concedes** instead, and nothing is charged. The build refuses a restatement whose
conclusion has changed:

```text
error: declare_bundle: a turn said to restate an earlier turn concludes something else.
Told as the same position, that is moving the goalposts: say `shifts`, and answer it
in a later turn. If the turn gives the earlier conclusion up, say `concedes`.
```

On the page, a shift names both conclusions and the turn that answered the first.

A restatement has a condition of its own. Once a turn has defeated a position, setting the
position out again answers nothing unless the new turn defeats that rebuttal. So a turn that
**restates** must defeat every earlier turn that defeated the position. One that leaves a
rebuttal standing **ignores** it, which is ignoring the rebuttal: the author says so, a later
turn must answer it, and the page names the rebuttal left standing.

## On the page

The page tells the exchange in order. Each turn is its party's paragraph, then the sentence that
joins it to the turn it names, in the solver's words ("This answers *By the clock*: it defeats
it, and *By the clock* does not defeat it in return"), and, for a quoted line that declares a
fallacy, which fallacy it is and which turn answers it. A defeat named in the closing paragraph
links to the `Because` that explains it, if the page has one.

After the turns comes one paragraph on how the positions stand to one another, for the pairs no
turn has joined. It is written as a reader would say it: "each of these positions defeats every
other, so none of them gives way", or "none of these positions defeats another", or the defeats
pair by pair. Above five positions the page also sets the defeats out in a table.

## What a bundle decides

Only what the dispute decides: a bundle is the dispute's defeats, put in an order and told. Its
turns are parties to one dispute. Two arguments that share no claim never defeat each other, so
joining them waits on bridges between arguments, each cited to the scholar or article that
draws it, or marked as proposed.

The cases in `Testimony.Checks.BundleCases` pin what a bundle must refuse and what it lets
through, and how the page sets it.

[declaring]: ./fallacies.md#declaring-a-fallacy-where-it-is-committed
