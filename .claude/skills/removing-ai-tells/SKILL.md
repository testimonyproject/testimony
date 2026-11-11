---
name: removing-ai-tells
description: Use as the editing pass after drafting or revising any prose in the Testimony library — docstrings under arguments/TestimonyArguments/ or examples/, pages under docs/src/, the README, pull request descriptions — and whenever someone says the writing sounds machine-written, generic, formulaic or "like Claude". Lists the habits that make prose read as generated, each with a before and after from this project, and gives a scanner (scripts/prose_tells.py) that counts them on a page. Pair with prose-voice for drafting.
---

# Removing the tells of generated prose

Language models write in recognisable habits. One habit is harmless; twenty on
a page tell the reader no one was there. This is the pass that finds them. Run
it on every draft before the facts pass in `prose-voice` and the reader review.

The pass removes habits, never content. Each fix below keeps every fact and
every quotation.

## Measure first

```sh
python3 scripts/prose_tells.py docs/src/arguments/sola-fide.md
python3 scripts/prose_tells.py --lean arguments/TestimonyArguments/SolaFide/Vulgate.lean
```

The scanner counts the habits listed here, per thousand words, and prints the
worst paragraphs with line numbers. It skips code, tables and generated result
headings. It is advisory: no gate runs it, and a count is a prompt to look, not
a rule. Use it to compare a revision with what it replaced.

## The habits

**1. The bold label on every paragraph.** "**Taken as a claim about Paul's
word**, it says…", paragraph after paragraph. It makes a page look like a form.
Keep bold for a term's first definition; let the topic sentence do the rest.

**2. Every sentence the same length.** The standard once said "short
sentences, one idea each", and the result was paragraphs of eight-word
sentences, each falling with the same thud. Join the ones that belong together
with *because*, *so*, *but*, *which*. Keep a short sentence where it lands a
point.

> Before (constructed, in the style of the first drafts): The verb is a
> courtroom word. Paul has other words for renewal. He sets them beside it.
>
> After: The verb is a courtroom word, and when Paul wants to speak of renewal
> he has other words for it, which he sets beside it (Titus 3:5–7).

**3. "Not X but Y", and its cousin ", not Y".** "The dispute is not about the
Greek but about the history." State what it is about. Keep a contrast only where
a reader would otherwise assume X.

**4. Announcing.** "A reader asks whether…", "This section answers…", "The
question is…", "It is worth noting that…", "Here is the point". Delete the
announcement and say the thing. A question the reader would ask may stay, but
after the facts that raise it.

**5. The colon reveal.** "Two things divide them: …", "The answer: …", "What
this shows: …". Write the sentence.

**6. The template.** The same frame for every result: "What this claims: … What
it does not claim: …". The rule that a result says what it claims and what it
does not stands; the frame does not have to. Say it in words that fit the
result: "This shows only that the argument is valid; whether its premises are
true is the next chapter's question."

**7. Triplets.** "The texts, the readers and the ratings." "Clear, exact and
fair." Three-part rhythm on every other sentence is a signature. Use the number
of items there are.

**8. Abstract nouns doing the acting.** "The reading grants the step", "the
position cannot be held with the strand". People read, grant and deny. Say who:
"Augustine grants the verse and reads it the other way."

**9. Dashes and semicolons as glue.** An em dash pair or a semicolon in every
sentence. Most are better as a full stop or a *because*.

**10. Hedge stacks and reassurance.** "This does not, of course, necessarily
mean…". One plain statement of the limit, once.

**11. The summary close.** A paragraph that ends by restating itself ("So the
two are, in the end, one question"). Cut it, unless it adds the step the
paragraph has been building to.

**12. Stock words.** *Crucially, notably, importantly, essentially, indeed,
ultimately, in essence, robust, nuanced, landscape, delve, underscore,
highlight, key (as an adjective), navigate, multifaceted, tapestry, journey.*
None is wrong; each, used for emphasis, sounds generated. Use the plain word or
nothing.

**13. Lists where there is an argument.** Five bullets that are really one line
of reasoning, each step depending on the last. Write the paragraph, with its
joints, and keep the bullets for what is parallel: the positions, the texts,
a summary of what the paragraph showed. Bullets and block quotations are the
house style as visual aids (`prose-voice`, "Visual aids"); this habit is only
the list that replaces an argument.

**14. Identifiers mid-sentence.** "`pius_reading_is_consistent` shows that…".
State the point; put the name in brackets after (`writing-for-readers`, rule 6).

**15. Symmetry.** Every section the same length, with the same sub-headings in
the same order. Real arguments are lopsided: one side needs three paragraphs,
the other one. Let them be.

## After the pass

Read the paragraph aloud. If it sounds like a person explaining something to a
friend who is sharp but busy, it is done. If it sounds like a report, go round
again.

Then check that nothing was lost: the facts list in `prose-voice`, the names
(linter rule L9), the generated page, and the `reader-review` agent, which
also reports the habits above.
