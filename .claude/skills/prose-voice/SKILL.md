---
name: prose-voice
description: Use when drafting or rewriting prose a reader will meet as continuous writing — a chapter or section introduction, a module docstring under arguments/TestimonyArguments/ or examples/, a hand-written page under docs/src/, the README — and whenever writing reads flat, list-like, choppy or machine-written, or someone asks for it to have more character, flow or warmth. Covers the voice the site is written in, how a paragraph and a chapter move, how to put people and history back in, and how to keep every fact while doing it. Pair with removing-ai-tells for the editing pass and writing-for-readers for the rules on accuracy.
---

# Prose with a voice

`writing-for-readers` says who the readers are and what the prose may claim.
This skill is about how it should *sound*. A page can follow every rule there
and still read like a form: every paragraph opening with a bold label, every
sentence the same length, every result described in the same two sentences.
Readers notice. The people now reading the site have said the prose "reads like
it's written by Claude", and they stop trusting a page that sounds assembled.

Accuracy is not traded for voice. Every fact, quotation, rating and result
survives a rewrite exactly; only the way it is told changes. The procedure for
that is in "Revising without changing a claim", below.

## The voice

Write as a good teacher writes a book for a church study group that includes a
retired professor of New Testament: someone who knows the material well enough
to tell it simply, likes the people in it, and is fair to all of them.

Some models, for the *sound* only — never quote or imitate their content: John
Stott, *The Cross of Christ*; F. F. Bruce's commentaries; C. S. Lewis, *Mere
Christianity*; Alister McGrath writing for a general audience; Jaroslav Pelikan
on the history of doctrine. What they share: plain words, long and short
sentences mixed, people acting in history, quotations that carry the argument,
and verdicts stated without nervousness.

The voice is:

- **Narrative where the subject is.** The debate over justification happened.
  Luther read Romans in a monastery; the fathers at Trent argued for seven
  months before Session VI; Calvin answered the decree within the year. Say so
  where it explains why a position reads as it does. History is not decoration:
  it is how a lay reader comes to care which reading is right.
- **About people, not positions.** "Calvin answered that justification is one
  and simple" beats "The Reformed position holds that justification admits no
  degrees". A position is something somebody holds, for a reason. Name them, give
  the reason, let them speak in their own words.
- **Confident.** State the finding once, plainly, then its limit once. Not
  "This may suggest that it could be argued". The machine has checked the result;
  the prose can stand behind it.
- **Warm toward every side.** A Catholic reader should finish the Trent chapter
  thinking the council was understood. Fairness is part of the voice.

## How a paragraph moves

A paragraph develops one point, usually over four to seven sentences. It does
not list facts; it makes an argument, and an argument has joints.

- **Use the joints.** *Because, so, but, although, which is why, that is, then*.
  These carry the logic a lay reader would otherwise have to rebuild. A list
  drops them, so the reasoning itself is told in paragraphs; a list then sets
  out what the paragraph has argued, for the eye (see "Visual aids", below).
- **Vary the sentence length.** Short sentences land a point. Longer ones carry
  a qualification or a chain of reasoning in one breath. A page of nothing but
  eight-word sentences reads like a telegram; a page of nothing but forty-word
  sentences loses the reader. Mix them. Read the paragraph aloud: if every
  sentence falls with the same thud, rewrite.
- **Open on the matter.** The first sentence of a paragraph says something —
  a verse, a person, an event, a claim. It does not announce what the paragraph
  will do ("This section examines", "A reader may ask").
- **End when the point is made.** No closing sentence that restates the
  paragraph. If the last sentence could be deleted without loss, delete it.
- **Let quotations work.** Quote the verse or the council and then build on the
  words quoted. A quotation dropped in and left alone is a citation, not prose.

## How a chapter moves

A chapter (a module docstring, or a section introduction) answers one reader's
question, and is shaped like a short essay:

1. **The question, with its text.** Open with the verse, the decree or the
   moment, quoted, and the question it raises for someone holding an English
   Bible. "If there is a dispute between men and they come into court..." —
   then: does a verdict like that admit of more and less?
2. **The people.** Who answered the question, when, and why they answered as
   they did. Each side in its own words.
3. **Where they part.** The single place the readings divide, said plainly.
4. **What the checking found.** In words: what follows from which premises, what
   is left open, which way the verdict went. Name the results in brackets at the
   end of the sentence that states them, as `writing-for-readers` requires.
5. **What it does not settle**, once.
6. **A road onward.** One sentence pointing to the chapter that takes the next
   question, when there is one.

In the Lean, a chapter is the modules its argument's catalogue entry names
(`Argument.chapters`). The module docstrings and their `/-! ### … -/` sections
are the chapter's prose; a section opened with `####` goes behind it, with the
declarations. Name another chapter by its title in quotation marks (`the chapter
"Weighing the positions"`), and the site makes it a link. See "An argument set
as chapters" in `docs/src/architecture.md`.

How the results are proved — the formula, the Lean, the claim tables — is not
part of the chapter's story. It belongs in the declarations' own docstrings and
the generated notes, where a reader who wants it can find it.

## Visual aids: quotations, bullets, bold and headings

The house style uses visual aids freely, because a reader with a Bible open
beside the page is looking back and forth. They serve the prose; they do not
replace it.

- **Block quotations** for every passage the chapter argues about, and for a
  council's or a reader's words that carry the argument. Set the verse apart,
  with its reference, before the paragraph that reads it:

  > "If there is a dispute between men and they come into court and the judges
  > decide between them, acquitting the innocent and condemning the guilty …"
  > (Deuteronomy 25:1)

  A short phrase the sentence builds on stays inline, in quotation marks.
- **Bullets** wherever the items are parallel and the eye should find them:
  the positions in a debate and who holds each, the texts a reading rests on,
  what a result shows and what it leaves open, the steps of a command, a
  summary at the end of a chapter. A bulleted item can be a full sentence or
  two. What a bullet list cannot do is carry a chain of reasoning: if the items
  need *because* and *so* between them, write the paragraph, and use the list
  after it to gather what it established.
- **Bold** marks a term the first time it is defined, or the one sentence on a
  page a skimming reader must not miss. It does not open every paragraph.
- **Headings** name the question or the subject in the reader's words ("Does
  justification have degrees?"), not the machinery ("Results", "The dispute's
  table").
- **Diagrams**, where the generator supports them, for the shape of a debate:
  who answers whom, where two readings part. A diagram restates what the prose
  says; it never says something the prose does not.

## Revising without changing a claim

Voice work is rewriting, and rewriting is where facts get lost. So:

1. **List what the passage asserts first**: every text, person, date, rating,
   count and result name. Keep the list beside you.
2. **Rewrite for sound.** Join, reorder, add history and people, cut the
   scaffolding.
3. **Check the list against the new text.** Every item is still there, or was
   removed on purpose. Nothing new is asserted that the encoding does not hold.
   A historical sentence you add ("Calvin answered within the year") needs a
   source, the same as a premise: verify it, or leave it out.
4. **Quotations stay word for word.** Do not smooth a verified quotation to fit
   the rhythm; build the rhythm around it.
5. **Identifiers stay spelled as declared** (linter rule L9), in brackets after
   the sentence that states the point in words.
6. **Run the editing pass** in `removing-ai-tells`, then regenerate and read the
   page, as `writing-for-readers` says.

## An example

Before (the opening of `TestimonyArguments.SolaFide.Vulgate`, as written):

> A reader asks whether Rome contradicts itself here. Pius XII taught, in
> *Divino Afflante Spiritu* (1943), that the original texts outweigh any
> translation. Can that be held together with Trent's use of these two Latin
> readings? This section answers from Rome's own words only: Trent's, Pius
> XII's, and the Catholic Church's own translation of the Greek.

After:

> In 1943 Pius XII urged Catholic scholars back to the Hebrew and the Greek.
> The original text, he wrote, "has more authority and greater weight than any
> even the very best translation". Four centuries earlier, Trent had taught the
> increase of justification from two verses whose Latin reads differently from
> the Greek. Do the pope and the council contradict each other? The answer here
> is drawn from Rome's own documents and nothing else: the council's decree,
> the pope's letter, and the Catholic Church's own translation of the Greek.

Every fact survives: the pope, the year, the document (named in the
paragraphs that follow), the principle quoted word for word, the two Latin
readings, the question, and the limit to Rome's own words. What changed is that
the paragraph now begins with a person doing something in history, the
question comes after the reader has the facts that raise it, and the
announcement ("This section answers") has become a statement of method.
