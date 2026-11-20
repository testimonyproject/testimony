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
- it **stands apart** from that turn: neither defeats the other.

A turn that says none of these only enters the exchange, and claims nothing about the others.

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
error: declare_bundle: a turn said to be one that meets an earlier turn, where the solver finds:
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

## On the page

The page tells the exchange in order. Each turn is its party's paragraph, then the sentence that
joins it to the turn it names, in the solver's words ("This answers *By the clock*: *By the
minutes* defeats *By the clock*, and *By the clock* does not defeat it in return"), and, for a
quoted line that declares a fallacy, which fallacy it is and which turn answers it. A defeat
that a `Because` on the page explains links to it.

After the turns comes one paragraph on how the positions stand to one another, for the pairs no
turn has joined. It is written as a reader would say it: "each of these positions defeats every
other, so none of them gives way", or "none of these positions defeats another", or the defeats
pair by pair. Above five positions the page also sets the defeats out in a table.

## What a bundle does not do

It decides nothing the dispute does not. It is the dispute's defeats, put in an order and told.
Two arguments that share no claim never defeat each other, so a bundle within one dispute
cannot join them; that waits on bridges between arguments, each cited to the scholar or article
that draws it, or marked as proposed.

The cases in `Testimony.Checks.BundleCases` pin what a bundle must refuse and what it lets
through, and how the page sets it.

[declaring]: ./fallacies.md#declaring-a-fallacy-where-it-is-committed
