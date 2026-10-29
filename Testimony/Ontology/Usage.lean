import Testimony.Ontology.Usage.Definitions
import Testimony.Ontology.Usage.Examples

/-!
# What a word's use in one passage shows about its usage

**A draft article.** "In the Septuagint's day, παρθένος did not yet mean
'virgin'" is a claim about a usage as a whole. "In the Septuagint's Leviticus
21:13 it means 'virgin'" is a claim about one passage of it. The two cannot both
be held, but only because of what "a usage as a whole" means: the senses its
passages give the word. The article writes that out as a definition
(`Usage.Definitions`) and shows it at work on statements of its own
(`a_sense_in_a_usage_at_work`).

## What it settles, and what it leaves to evidence

It carries a sense from a passage to the usage the passage belongs to, and
nothing more. Two things stay premises, cited and rated, because readers
dispute them.

- **What a word means in a given passage.** That is a reading of the passage,
  and the evidence for it is the passage's own context. Not every use is
  evidence of a sense. A word used *of* a virgin need not *mean* "virgin": Walton
  observes that a thousand passages using "fiancée" of virgins would not make it
  mean "virgin" (*JETS* 30, 1987, 292). What can fix a sense is a context that
  turns on it: a contrast that only the sense explains, a translation of a word
  that itself names the thing, or an abstract noun naming the quality. The
  library does not read these contexts itself. They are the grounds a premise
  about a passage cites, and a reader can see and dispute them there.
- **What a word means in a passage, from what it means in the usage.** The
  definition runs one way. A word with two senses in a usage need not have both
  in every passage, so the usage settles nothing about any one passage, Isaiah
  7:14 among them.

Two senses of one word in a usage do not exclude each other either, any more
than at one passage (`HasJoins`). What the definition can show false is a claim
that a usage *lacked* a sense, wherever a passage of it is held to have that
sense.

What it does in the library's arguments is computed by
`Testimony.Checks.Ontology`.
-/
