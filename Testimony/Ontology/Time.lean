import Testimony.Ontology.Time.Definitions
import Testimony.Ontology.Time.Examples

/-!
# How long an occurrence lasts

**A draft article.** A testimony about time — "only five minutes had passed" —
and a reckoning from what happened in that time — "the grits take twenty
minutes" — meet only if both are about one occurrence, and if an occurrence
cannot last two lengths of time. The second is what "lasts" means, and both
top-level ontologies the vocabulary is aligned to state it: DOLCE gives a
perdurant one temporal location, BFO has a process occupy one temporal region.
It is written out here as a definition (`Time.Definitions`), and shown at work
on statements of the article's own (`one_length_at_work`).

What it does in the library's arguments is computed by
`Testimony.Checks.Ontology`: nothing yet, since none of them is about how long
something took. It does its work in the first case built on the library from
outside theology, the grits cross-examination in the `TestimonyExamples`
package, where it is what makes a witness's five minutes and the grits' twenty
exclude each other.

## What is left apart

That a part lasts no longer than its whole — that a breakfast takes at least as
long as the grits it includes — follows from the same ontologies, but it is a
comparison of lengths, and the reasoner reads facts, not measures. Where a case
needs it, the case states it as a step, cited and rated, and a reader can see
it there rather than find it hidden in a definition.
-/
