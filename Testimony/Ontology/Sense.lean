import Testimony.Ontology.Sense.Definitions
import Testimony.Ontology.Sense.Examples

/-!
# What "the same sense" means

**A draft article.** An argument that sets one text against another assumes,
for every word the two share, that it means the same in both
(`Testimony.Semantics.Discourse`). Whether it does is the question an
equivocation turns on, and the library states it as a claim of its own,
`Statement.sameSense`, cited and rated like any other. What "the same" means is
not in question, and this article writes it out: sameness of sense runs both
ways (`Sense.Definitions`). It is shown at work on statements of its own
(`both_ways_at_work`).

## Why it was needed

The checks for fallacies (`Testimony.Semantics.Fallacy`) look up each premise of
an argument against every claim the library holds, to find who denies it. A
move that needs James's "justify" to be Paul's states the sameness in one order;
a claim that denies it may state it in the other. Without this definition the
lookup missed every such denial, and the equivocation check had to compare both
orders by hand. With it, the order a claim happens to be written in no longer
decides whether two claims meet.

## What it does not settle

It does not say that any word keeps its sense anywhere, and it does not carry a
sense from one place to another. A reader who holds that James's word is Paul's
is not thereby told what either means. Those stay premises.

What it does in the library's arguments is computed by
`Testimony.Checks.Ontology`.
-/
