import Testimony.Ontology.Relations.Definitions
import Testimony.Ontology.Relations.Reach

/-!
# What three relation words commit a reader to

**A draft article.** The library says what each of its claims means, in a small
vocabulary shared by every argument (`Testimony.Semantics.Vocabulary`), so that
it can tell when two claims it keeps apart cannot both be held. Whether they can
depends on what their words commit a reader to. "Faith is the only means by
which justification is received" and "baptism is a means by which justification
is received" do not contradict each other on their face; they contradict each
other because of what *only* means.

This article writes out what three of the vocabulary's relation words commit a
reader to, searches the library for every claim that uses them, and reports what
follows. It adds no word to the vocabulary and no claim to any argument.

## Derived, not assembled

The vocabulary already defines each relation word, in a sentence. Three of those
sentences say more than the word's name, and say it of another word; each is
written out as a definition the reasoner holds, with the sentence as its source
(`Relations.Definitions`):

- **To be excluded from a thing is not to be its ground** (`notAGround`).
- **The only means of a thing is a means of it, and nothing else is**
  (`onlyMeans`).
- **The whole ground of a thing is a ground of it, and nothing else is**
  (`wholeGround`).

A definition says what a word means, and no reader disputes that. Where one
tradition holds of a word what another denies, it is a premise of that
tradition's position, not a definition, and it is left apart (below).

## What the search found

Three arguments use the five words: sola fide, the canonical witness and sola
scriptura (`Relations.Reach`). Most uses in sola fide are inside a frame — what
Romans 3:28 or Galatians 2:16 *says*, what James 2 is *written against* — and
the definitions do not reach inside a frame: a text may say a thing without
saying all that follows from it.

## What follows

**One join is derived from a definition.** That faith is the only means of
justification excludes Trent's claim that baptism is its instrumental cause
(`only_means_derives_one_join`). Westminster calls faith "the alone instrument
of justification" (XI.2); Trent's sixth session makes baptism "the instrumental
cause" (ch. 7); the atom for Trent's claim cites both. The two were always
opposed; the library now knows it from what the words mean, and not from an
atom written to say so.

**One join is found by reading the meanings more carefully.** "Justification
includes the remission of sins, and not sanctification" — the Reformed claim
that justification is forensic only — excludes Trent's "justification includes
both". The denial was always in the Reformed claim's meaning; the reader used
before looked only for denials of a whole claim, and missed one inside it
(`sola_fide_joins_without_definitions`).

**What it changes.** Every named reading in sola fide now takes a side on both
pairs: Trent's worlds deny *faith alone*; every other world denies Trent's
claim. Several readings that had held both halves of a pair — the claims a
reading does not mention are true in it, and these two had not been mentioned —
no longer do. No dispute's table moves, no verdict moves, and every
non-entailment the library states still holds (`Testimony.Checks.Postulates`):
both pairs were already opposed in every dispute that seats them. Nothing else
moves anywhere (`definitions_derive_nothing_elsewhere`), and no meaning
contradicts itself (`no_meaning_contradicts_itself`).

## What the search found that the definitions cannot fix

Paul's texts are stated in doctrinal words. Romans 3:28, as the library encodes
what it *says*, makes faith the *means* of justification and works of the law
*not its ground*. James 2:24's "by works" is stated with `saidBy`, the word the
vocabulary keeps for a text's "by" that leaves open whether it means a ground, a
means or the evidence — though its "not by faith only" is stated with "the only
means", a doctrinal word again. Each text's own connective — δικαιοῦσθαι πίστει, χωρὶς
ἔργων νόμου, ἐξ ἔργων — should be stated in a textual word for both, and what it
denotes argued as a reading for both. That is the next article: no definition
over doctrine reaches it, because the asymmetry is in what the library says the
texts say.

## What is left apart, and why

- **That the fruit of a thing is not its ground.** Westminster holds good works
  the fruit of faith and no ground of justification; Trent holds them fruit and
  merit. Which it is turns on a dispute the library weighs
  (`fruit_turns_on_the_standard`); a definition would decide it.
- **That to merit a thing is to be a ground of it.** The library keeps "works
  merit an increase of justification" and "works cause an increase of
  justification" as two claims of Trent's; a definition would make one the
  other.
- **That only one thing can settle a question finally.** Westminster's "supreme
  judge" says, in its own words, that the magisterium does not settle the
  question (`scriptureIsSupremeJudge`); that is the confession's claim, not
  what "settles" means.
- **That what includes a thing cannot be distinct from it.** The Reformed hold
  justification distinct from sanctification and inseparable from it; Trent,
  that justification includes it. Whether both can be said of one pair is the
  question between them.
- **That the only means of a thing is necessary for it.** It may follow, but the
  vocabulary's sentence does not say it. And the library analyses *faith alone*
  two ways: as the only means, in sola fide, and as necessary, sufficient and
  apart from works, in the canonical witness. Which is right is a question for
  an article of its own.
-/
