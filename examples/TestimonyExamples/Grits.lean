import TestimonyExamples.Grits.Atoms
import TestimonyExamples.Grits.Sources
import TestimonyExamples.Grits.Positions
import TestimonyExamples.Grits.Meanings
import TestimonyExamples.Grits.Dispute

/-!
# TestimonyExamples.Grits — the five minutes, and the grits

Bill is on trial for murder. A witness, Sam Tipton, testifies that five minutes
passed between the moment he saw Bill go into the Sac-O-Suds convenience store
and the moment he heard a shot. He is sure, because he had just begun to make
breakfast when the boys went in, and it was ready when the shot rang out. On
cross-examination, Bill's cousin and lawyer, Vinny Gambini, asks him what he had
for breakfast. Eggs and grits. Regular grits, not
instant: "No self-respecting Southerner uses instant grits." "So, Mr. Tipton,
how could it take you five minutes to cook your grits, when it takes the entire
grit-eating world twenty minutes?" By the end, "I may have been mistaken."

A reader asks: *where exactly does the testimony break, and why does it break
there?* The D.C. Circuit answered the first half when it set the scene out,
question by question, in an opinion of 2019: "it was clear that Tipton could not
have cooked his breakfast of eggs and grits in just five minutes." This case
encodes the answer, and checks it.

## What it shows

- **The five minutes rests on the breakfast**, and on nothing else: he did not
  look at his watch (`the_five_minutes_rests_on_the_breakfast`).
- **It cannot stand with the grits.** What Tipton testified, with what he granted
  and what counsel put to him, cannot all be held
  (`tiptons_five_minutes_cannot_stand_with_the_grits`) — and the contradiction
  is in what "lasts" means: an occurrence lasts one length of time, so his
  breakfast cannot have taken five minutes and twenty. Taken as words with no
  meaning, the two could be held together
  (`apart_from_what_lasts_means_both_could_be_held`).
- **Weighed as a dispute, the cross-examination prevails**
  (`the_cross_examination_prevails`), and the testimony cannot be defended
  (`tiptons_testimony_cannot_be_defended`).
- **But not at "I'm a fast cook."** At that moment the witness denied the step
  from the grits, and the dispute was a standoff
  (`at_the_fast_cook_nothing_was_decided`). The cross-examination did not stop
  there, and the solver says why it should not have.

## What it does not show

That Bill is innocent, that twenty minutes passed, or anything else the trial
went on to decide. The case is the five minutes, and only the five minutes.

## Not part of the library

This case is in `TestimonyExamples`, a package that uses the Testimony library
and is not part of it. It imports the library and changes nothing in it: its
works, its unfold set, its checks and this document are its own. It is the
library's first example outside theology, and shows how a case of any kind is
encoded: its claims cited to a record, rival positions, what the claims mean in
the library's vocabulary, and a dispute weighed by the same solver the library's
arguments are.

## Where things are

| File | Contents |
|---|---|
| `Atoms.lean` | the claims |
| `Sources.lean` | `cite`, and the ratings of each step |
| `Positions.lean` | the testimony, the cross-examination, and where the five minutes rests |
| `Meanings.lean` | what each claim says, and the joins |
| `Dispute.lean` | the two weighed, the verdicts, and the dispute at the fast cook |
-/
