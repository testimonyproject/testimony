---
name: literate-style
description: Use when writing or restructuring an argument's prose so that it builds the case up from its claims, in literate programming style — module docstrings, the docstrings of atoms, lines of reason and packages, and the order of declarations in an argument's files — or when someone says a page reads top-down, as an outline, or in the order of the Lean rather than the order a reader follows. Pair with prose-voice for the sound and writing-for-readers for the rules.
---

# Literate style: building the case up

An argument "in literate programming style" means one told in the pedagogical
style Donald Knuth uses to present a program as a narrative. Knuth
put the idea in one sentence: "The main idea is to treat a program as a piece of
literature, addressed to human beings rather than to a computer."
([Literate Programming][lp], Knuth's own page for the book: CSLI Lecture Notes
27, 1992.) In a literate program the explanation is the main text, and each
piece of code comes into it at the point the story needs it, already
motivated, so a reader builds up the whole program piece by piece and
understands each piece as it arrives.

An argument in this library is a program of that kind. Its pieces are claims,
the steps that join them, and the positions that hold them. Written
literately, the page builds the case up: it introduces each claim in words,
with the verse or the reader it rests on, at the moment the case needs it; it
joins claims into a step only once the reader has met them; and it reaches
the conclusion as the end of that story. The conclusion is not announced at
the top and then broken into parts.

`writing-for-readers` says what the prose may claim. `prose-voice` says how it
sounds. This skill is about the *order*: what the reader meets first, and what
each paragraph may take as already known.

## Constructive, not top-down

A top-down page reads like an outline. It states the thesis, lists the lines
that support it, and fills in each line with claims the reader meets for the
first time inside a formula. That is the order in which the Lean is checked,
and it is often the order the files were written in. It is not the order in
which a person comes to see why the thesis follows.

A constructive page goes the other way:

1. **The question, with its text.** Open on the reader's question and the
   passage that raises it, quoted. Knuth also starts from the problem, so this
   is not top-down: a question is not yet an answer.
2. **One claim at a time, in words.** Say what the claim is, quote the verse or
   the reader it rests on, and say who disputes it, before anything uses it.
   A claim met for the first time as `P₇` in a formula is a failure of order.
3. **The step, once its claims are in hand.** Say how the claims join: "if
   *works of the law* means works in general, and Galatians 2:16 says no one is
   justified by them, then …". The step names claims the reader has already
   met, in the order the paragraph met them.
4. **What follows, as the end of the paragraph.** The step's result is the
   last thing said, not the first.
5. **The next piece builds on that one.** A later line may take an earlier
   line's result as given; say so in words ("with Paul's strand in hand, …").
   The conclusion comes after the strands that reach it.
6. **Then the formal summary.** The formula, the package and the result come
   after the prose that motivates them, as a check on what the reader has just
   followed, never as the first statement of it.

An outline is still useful, but in service of the story. A sentence at the
start that says where the case is going ("three strands, from Paul, Luke and
Acts, each reach the same claim") helps the reader keep their place. It names
the destination; it does not replace the journey.

## In the Lean source

Lean checks a file top to bottom, and a declaration must come before its use,
so the source already runs constructively: atoms, then sources, then lines,
then packages, then results. Use that order, and write the prose to match it.

- **An atom's docstring introduces the claim** as a reader first meets it: the
  verse quoted, the word glossed, who holds and who denies it. Declare atoms in
  the order the narrative introduces them. The legend is numbered in
  declaration order, so this also makes `P₁, P₂, …` the order of the story.
- **A line's docstring walks its claims in the order its step lists them.**
  The generated page now sets every step built up from its claims: each claim
  in words with its rating and source, then what they would give, then the
  formula (`Testimony.Logic.Latex.step`, and `Markdown.step` for the site). The
  docstring above it should tell the same claims in the same order, saying
  why each is needed, so the reader reads the explanation and then sees the
  claims laid out as they were explained.
- **Order lines so that each builds on what came before.** A line whose result
  another line takes as a ground comes first. The closing step that gathers
  the strands into the conclusion comes after all of them.
- **A `/-! ### … -/` section opens with what it adds** to what the reader
  already has, not with a summary of what it contains.
- **Packages and results come last**, and their docstrings refer back to the
  claims and lines by what they say, not by number.

## An example

Paul's strand in Sola fide (`paulineToFaithAlone`), as it reads before this
skill was written:

> **Paul's strand.** From Romans and Galatians to justification by faith alone,
> with Galatians 2:16 at the centre: "a person is not justified by works of the
> law but through faith in Jesus Christ."
>
> Each premise does its own work. Galatians 2:16 excludes works of the law. …

Then the formula `(P₂ ∧ P₃ ∧ P₈ ∧ P₇ ∧ P₆) → P₂₅`, with the claims only as
links to the legend. The thesis comes first, the claims are mentioned in an
order different from the step's, and two of the five (Romans 3:28 and the
reading of "works of the law") are named only in passing.

Built up, the same facts read in the order of the step:

> Romans 3:28 says that "one is justified by faith apart from works of the
> law". Galatians 2:16 says it again, and more sharply: "a person is not
> justified by works of the law but through faith in Jesus Christ." Two things
> in that verse are disputed. "Faith in Jesus Christ" (πίστις Χριστοῦ) can be
> read as the believer's faith in Christ, which makes faith the means, or as
> Christ's own faithfulness. And "works of the law" (ἔργα νόμου) can be read as
> human works in general, or as the marks of being a Jew. The
> letter's occasion settles what is being refused: circumcision *added to*
> faith as a requirement, by people who already believed, and Paul says that
> adding it severs them from Christ (5:4). Grant all five, and justification
> is by faith alone.

Each claim arrives with its text and its dispute before the conclusion, so the
build-up the generator sets below the docstring repeats what the reader has
just read. Better still, tell them in the order the step lists them, and the
two match line for line. A real revision would also
name who holds each reading, from the sources the atoms already cite, as
`writing-for-readers` requires.

## Checking a page for order

Read the generated page, not the docstring, and ask at each paragraph:

- Does it use a claim, verse, reader or term the page has not yet introduced?
  Move the introduction earlier, or the use later.
- Does a formula or a variable appear before the prose that says the same in
  words? Put the words first.
- Does the paragraph state its conclusion first and then justify it? Turn it
  round, unless the opening sentence is the reader's question.
- Could a reader stop after any section and say what has been established so
  far? If not, the section is still an outline.

[lp]: https://cs.stanford.edu/~knuth/lp.html
