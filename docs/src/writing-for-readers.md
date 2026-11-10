# Writing for the reader

Every argument page on this site is generated from docstrings in the Lean
source. So the people who write Lean here are also writing the pages, and this
is the standard that prose is held to.

## Two things this project is

Keep both in view. Most bad prose here comes from forgetting one of them.

1. **A guide for lay people reading an English Bible, in language precise
   enough that a theologian can work with it.** A reader should be able to
   follow a page with a Bible open beside it and no Greek, no Hebrew and no
   logic. A scholar reading the same page should find every claim stated
   exactly, with its source, and nothing softened.
2. **A code library for encoding arguments and checking them for consistency.**
   Positions are written as lists of premises. The machine checks what follows
   from each list, what does not, and which positions can be held together. It
   never decides whether a premise is true.

The first tells you who you are writing for. The second tells you what you may
claim.

## Who is reading

Picture two people at the same table.

**The first** teaches a Bible study. They know the passages well and have heard
of the Reformation debates. They have never seen a turnstile, do not read Greek,
and will stop reading at the first sentence they cannot parse.

**The second** has a theology degree. They read Greek, know who Dunn and
Campbell are, and are looking for the place where the page gets their
tradition wrong.

Write so the first can follow every sentence and the second can check every
claim. When the two pull apart, the first sets the vocabulary and the second
sets the accuracy.

## The rules

**Start from the passage, in English.** Quote the verse as an English Bible
prints it before you say anything about it. A reader who has the words in front
of them can follow an argument about those words.

**English first, then the original term in brackets.** Write "works of the law"
(ἔργα νόμου), not ἔργα νόμου alone. The English is what the lay reader holds
on to. The Greek or Hebrew is the handle a scholar needs to look the question
up. Give both, once, where the term first appears in a section.

**Say what a technical word means where you use it.** This applies to theology
as much as to logic. "Forensic" needs "a verdict, as in a court". "Objective
genitive" needs "faith *in* Christ, as opposed to Christ's own faithfulness".
"Grounded extension" needs "what must be accepted however the open disagreements
are settled". If a term needs a paragraph, link to
[Reading the logic](./reading-the-logic.md) and still give the short gloss.

**Name the people who hold a view.** "Some scholars" tells a reader nothing.
"Dunn and Wright, building on Sanders" tells them where to look, and tells the
scholar whether the position is fairly described.

**Say what a result claims, then what it does not.** Every headline result's
docstring does both, in plain words. The second half matters more: a reader
will take "John carries the conclusion alone" to mean John's reading is beyond
dispute unless the next sentence says it is not.

**Put source names in brackets, at the end.** A reader does not need
`pistisChristou_jointly_load_bearing` to follow a sentence. State the point in
words and give the name afterwards, in brackets, so it can be found. A
sentence that only makes sense if you already know what the identifier means
needs rewriting.

**Report the result the machine gave.** If the dispute comes out a tie, the
page says tie. Do not write a tie as a near-win, and do not write "not forced"
so that it sounds like "false".

**Describe a rival in words its holders would accept.** A Catholic reader
should recognise Trent's position in the paragraph that states it, and should
find the Council's own words there.

**Keep sentences short and make each one say something.** One idea to a
sentence. If a sentence could be cut without the reader losing anything, cut
it.

## What to avoid

These are habits of writing quickly, and each one costs the lay reader.

- **Clever contrasts.** "The dispute is not about Paul's Greek but about
  Second Temple Judaism" makes the reader hold two things to get one. Say what
  it is about.
- **Announcing that something matters.** "And that is the point." "The result
  worth having." Say the thing; the reader will see whether it matters.
- **Shorthand from the code.** "Load-bearing", "hinge", "strand", "forced",
  "standoff" are useful words here, and each needs a plain gloss the first time
  it appears on a page.
- **Stacked qualifications.** One clear statement of the limit is better than
  three hedges.
- **Describing the machinery to people who came for the argument.** How a
  result is proved belongs in the Lean. What it shows belongs in the docstring.

## An example

Before:

> The dominical strand rests on Jesus' own words rather than Paul's. ἡ πίστις
> σου σέσωκέν σε occurs four times in Luke. It is not a free win: σῴζω means
> both *save* and *heal*, and carries `sozoIsSoteriological` as its own premise.

After:

> **Jesus, in Luke.** "Your faith has saved you; go in peace" (Luke 7:50), said
> to the woman who anointed his feet. The saying occurs four times in Luke. The
> Greek verb (σῴζω) means both *save* and *heal*, and in the other three places
> the person has just been healed, which is why most English Bibles print "made
> you well" there. So the strand rests on 7:50 alone, where the saying follows
> "your sins are forgiven" and no one is ill. That the word means *saved* there
> is its disputed reading (`sozoIsSoteriological`).

The second version is longer. It begins with the verse, explains why the Greek
matters by pointing at something visible in an English Bible, and gives the
identifier last. Nothing a scholar needs has been lost.

## Before you open a pull request

Read the generated page, not the docstring. Then ask:

1. Could someone with an English Bible and no Greek follow each paragraph?
2. Is every Greek, Hebrew or Latin term given in English first?
3. Does each result say what it claims and what it does not?
4. Would a holder of each position accept the description of it?
5. Does every paragraph agree with the result it describes, as it stands after
   your change?

The `reader-review` agent in `.claude/agents/` reads a page this way and reports
what it could not follow. It is a first pass. A person who does not know the
code is the real test.

## Where this applies

- Module and declaration docstrings under `arguments/TestimonyArguments/` and
  `examples/`, which become the argument pages and the PDF.
- The hand-written pages of this site that a visitor reads first: the
  introduction, the rationale, scope and limits, and the roadmap's findings.

It applies less strictly to pages written for contributors, such as the
architecture and performance pages, and to docstrings in the library's own
machinery under `Testimony/`. Those are read by people who write Lean. They
should still be plain.

## What has been brought up to this standard

The standard is newer than most of the prose. As of this writing the whole of
the sola fide page follows it: every section's introduction, and the
description of every claim, position and result. The other five argument pages
were written before it and have not been revised. When you change a docstring
on one of them for another reason, bring it up to the standard in the same
change, and update this paragraph.

Two things about the sola fide page are worth knowing before copying its
vocabulary elsewhere. It says "position" for what the code calls a party or a
package, "tie" for two positions that defeat each other, "starting points" for
a step's grounds, and "can be held without contradiction" for satisfiable. And
it keeps a small set of words as terms of its own, each explained where it
first appears on the page: *strand*, *defeats*, *forced*, *can be defended*,
and the four ratings.
