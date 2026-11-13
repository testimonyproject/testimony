import Testimony.Logic.Declare
import TestimonyArguments.Meanings.BornOfAVirgin
import TestimonyArguments.BornOfAVirgin.Results.Genesis

/-!
# TestimonyArguments.BornOfAVirgin.Dispute.Genesis — what "her seed" says of a father

`Results.Genesis` shows that the claim that Genesis 3:15's wording itself
signifies a birth with no human father rests on one step, Luther's. This module
weighs that step against the two readings that deny it. Three positions meet:

- **Luther on "her seed"** (with Henry): the seed of other women "might rather
  be said to have been the seed of the man", but Mary's was "the true Seed of
  Mary"; so the wording itself signifies a birth with no human father.
  Irenaeus reads the verse of the Virgin's son too, though he does not argue
  from the wording.
- **Leupold on "her seed"** (with Keil; Calvin gives the same two grounds):
  "her seed" is first collective, the woman's posterity, and the woman is named
  because she was deceived; so the wording "does not specifically prophesy the
  virgin birth, but it coincides and agrees with it under divine providence".
  Leupold and Keil are Lutheran commentators, and both hold the virgin birth.
- **Jack P. Lewis on "her seed"**: Genesis speaks of Hagar's seed and of
  Rebekah's too, each with a father named; so the wording at 3:15 does not by
  itself signify a birth without one.

Luther, Leupold and Keil hold that Genesis 3:15 promises a redeemer; Lewis
doubts it, but his argument does not need that doubt. Whether it does is not
argued here: critical readers deny it, Westermann among them, as Lewis quotes
him: "it is not possible that such a form has either promise or prophecy as its
primary or even its secondary meaning" (318). But it is weighed. The claim is
rated `disputed` because they deny it, and Luther's step uses it while Leupold's
and Lewis's do not, so it holds back Luther's case alone, though Leupold and
Keil hold it too. The virgin birth
itself is not in question here: Leupold and Keil affirm it, and find it in the
promise's fulfilment. Whether the promise is fulfilled in Jesus, and whether
that confirms it as a promise, is weighed in `Dispute.Protoevangelium`.

## How to read the verdicts

- **Defeats.** One position contradicts another — denies one of its premises,
  its conclusion, or a claim it derives on the way — and is not the weaker of
  the two. A defeat that runs both ways is a *standoff*.
- **Weakest link.** A position is only as strong as its least-supported premise
  or step. Every party here rests on something rated `disputed`, the lowest
  rating, so as the ratings stand none outranks another.
- **Prevails.** Accepted however every standoff is resolved.
- **A resolution.** A largest consistent set of positions that answers every
  attack on its members, itself or through an ally. A position in some
  resolution can be defended; one left out of some resolution is not forced —
  which is not the same as false.

## What the solver computed

Two standoffs, and nothing else (`genesisDispute_defeats`, all nine pairs):

- **Luther and Leupold.** Luther concludes that the wording signifies a birth
  without a human father; Leupold concludes that it does not.
- **Luther and Lewis.** The same, with Lewis in Leupold's place.

Leupold and Lewis do not attack each other: they stand together
(`posterity_stands_with_the_idiom`).

**Nothing prevails** (`nothing_prevails_over_her_seed`): every party is defeated
by someone. The dispute has two resolutions, each proved: Luther alone
(`wording_is_one_resolution`), and Leupold with Lewis
(`posterity_and_idiom_are_the_other_resolution`). Either can be defended;
neither is forced.

So a reader who says that "her seed" already implies a virgin conception is
taking a side in a live dispute, with Luther, Henry and Irenaeus on it, and not
stating what the text alone shows. Neither is the reader who says it does not,
with Leupold and Keil, who hold the virgin birth, and Lewis. Neither side is
shown wrong.

## What the ratings decide

Each claim and step carries a rating from its sources: `consensus`,
`wellSupported`, `plausible` or `disputed`. A step is `disputed` when one cited
reader grants its grounds and denies its conclusion; where he wrote does not
enter. A rating moves only with a new, cited argument. As they stand, every
party's weakest link is `disputed`, so the dispute is a tie. What follows is
read off the rule for defeat, and was computed before it was written; it is not
separately proved.

The tie is nearer to breaking against Luther than for him: one rating would
break it against him, and two are needed to break it for him.

**Lewis's step** is `disputed` on one reader, Jimmy Akin, a Catholic apologist
writing in *Catholic Answers Magazine*. He does not discuss Hagar or Rebekah, but
grants the point Lewis draws from them, that a woman's seed "is not outside the
bounds of Hebrew expression", and still calls the wording "odd", and agrees with
the "many" who have "rightly seen" it as "a hint of the Virgin Birth". A hint is
less than a sign; it is the only dissent found. Lewis's grounds are what Genesis
reads,
rated `consensus`, so the step is his only weak point. Rated higher, Lewis would
outrank Luther: his attack would stand and Luther's would not, and Leupold and
Lewis would prevail together. What would raise it is a cited argument that
Akin's objection fails.

**Luther's step**, rated higher, is not enough. His case also uses the claim that
Genesis 3:15 is the first promise of a redeemer, `disputed` because critical
readers deny it. Luther prevails only if both are rated higher, which takes a
cited argument answering Leupold, Keil and Lewis on the step, and one answering
the critics on the promise.

**Leupold's step** is placed as Luther's is. It is `disputed` on Irenaeus, who
grants both its grounds, and on Henry, who grants the second; both still read
the verse of the Virgin's son. His ground that "her seed" is first collective is
`disputed` on Collins, who argues that the Hebrew's syntax is "quite consistent
with the pattern where a single individual is in view" (145). Leupold prevails,
with Lewis, only if both are rated higher.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### Strength -/

/-- Luther's case is no stronger than its step, rated `disputed`, and its claim
that Genesis 3:15 is the first promise of a redeemer, cited `disputed`. -/
theorem herSeedCase_strength : herSeedCase.strength = 0 := by decide

/-- Leupold's case is no stronger than its step and its reading of "her seed"
as first collective, both `disputed`. -/
theorem posterityCase_strength : posterityCase.strength = 0 := by decide

/-- Lewis's case is no stronger than its step, rated `disputed`; his grounds
are `consensus`. -/
theorem idiomCase_strength : idiomCase.strength = 0 := by decide

/-! ### The defeats -/

/-- **Leupold defeats Luther.** His conclusion denies Luther's. -/
theorem posterity_defeats_wording : Defeats posterityCase herSeedCase :=
  Horn.defeats_of_certified posterityCase_strength herSeedCase_strength (by horn_certify)

/-- **Luther defeats Leupold back**, so the two stand off. -/
theorem wording_defeats_posterity : Defeats herSeedCase posterityCase :=
  Horn.defeats_of_certified herSeedCase_strength posterityCase_strength (by horn_certify)

/-- **Lewis defeats Luther.** His conclusion denies Luther's. -/
theorem idiom_defeats_wording : Defeats idiomCase herSeedCase :=
  Horn.defeats_of_certified idiomCase_strength herSeedCase_strength (by horn_certify)

/-- **Luther defeats Lewis back**, so the two stand off. -/
theorem wording_defeats_idiom : Defeats herSeedCase idiomCase :=
  Horn.defeats_of_certified herSeedCase_strength idiomCase_strength (by horn_certify)

/-! ### The dispute -/

/-- The parties to the dispute over the woman's seed. -/
inductive GenesisParty
  /-- Luther on "her seed": the wording itself signifies a birth with no human
  father. -/
  | wording
  /-- Leupold on "her seed": her posterity, named for the deception. -/
  | posterity
  /-- Lewis on "her seed": Genesis says it of Hagar and Rebekah too. -/
  | idiom
deriving DecidableEq

/-- The package each party argues from. -/
@[bornOfAVirginDefs]
def genesisPartyNode : GenesisParty → ArgumentPackage Claim
  | .wording => herSeedCase
  | .posterity => posterityCase
  | .idiom => idiomCase

/-- The dispute over the woman's seed: every party's premises can all be true
together, every party establishes its conclusion, and every party's inferences
are rated. Every party's weakest link ranks at the bottom. -/
declare_dispute genesisDispute := genesisPartyNode using bornOfAVirginDefs
  /-- **Who defeats whom**, all nine pairs: Luther and Leupold defeat each other,
  Luther and Lewis defeat each other, and nothing else. Every cell is computed
  from what the parties hold by `Horn.defeats?` and checked by the kernel. -/
  defeats [(.wording, .posterity), (.posterity, .wording), (.wording, .idiom), (.idiom, .wording)]
  /-- **No support**, in all nine pairs: no party's conclusion is another's
  premise. Every cell is computed by `supports?` and checked by the kernel. -/
  supports []
  /-- **No case is part of another's** here, in all nine pairs, except each
  party's own. Every cell is computed by `partOf?` and checked by the kernel. -/
  partOf []
  /-- The dispute drawn: who defeats whom, with no support between the parties. -/
  map genesisMap

/-- **Leupold and Lewis stand together**, on Leupold's reading, in which
Lewis's claims hold too. -/
theorem posterity_stands_with_the_idiom :
    genesisDispute.StandTogether [.posterity, .idiom] := by
  satisfied_by leupoldReading [Dispute.StandTogether, bornOfAVirginDefs]

/-- Why nothing prevails: a defeater for each party. -/
declare_verdict everyGenesisPartyDefeated for genesisDispute :
    .nothingGrounded [(.wording, .posterity), (.posterity, .wording), (.idiom, .wording)]
  /-- **Nothing prevails.** Every party is defeated by someone — Luther by
  Leupold and by Lewis, each of them by Luther — so no position is accepted
  however the standoffs are resolved. -/
  proves @[headline] nothing_prevails_over_her_seed

#print axioms nothing_prevails_over_her_seed

/-- Why Luther alone is one resolution. -/
declare_verdict wordingAlone for genesisDispute : .preferred [.wording]

/-- **One resolution: Luther.** His case can be defended on its own, because it
defeats both parties that defeat it; and it is in conflict with both, so no
larger set can be defended. -/
@[headline]
theorem wording_is_one_resolution : Preferred genesisDispute.defeats {.wording} :=
  (show Solver.toSet [GenesisParty.wording] = {.wording} by ext; simp) ▸ wordingAlone.holds

#print axioms wording_is_one_resolution

/-- Why Leupold with Lewis is the other resolution. -/
declare_verdict posterityWithTheIdiom for genesisDispute : .preferred [.posterity, .idiom]

/-- **The other resolution: Leupold, with Lewis.** Neither defeats the other,
and each answers Luther, the only party to defeat either. Luther is in conflict
with both, so no larger set can be defended. -/
@[headline]
theorem posterity_and_idiom_are_the_other_resolution :
    Preferred genesisDispute.defeats {.posterity, .idiom} :=
  (show Solver.toSet [GenesisParty.posterity, .idiom] = {.posterity, .idiom} by ext; simp) ▸
    posterityWithTheIdiom.holds

#print axioms posterity_and_idiom_are_the_other_resolution

/-- So the dispute does not force Luther's reading. -/
theorem wording_not_skeptically_accepted :
    ¬ SkepticallyAccepted genesisDispute.defeats .wording :=
  fun h => by simpa using h _ posterity_and_idiom_are_the_other_resolution

/-- Nor does it force Leupold's. -/
theorem posterity_not_skeptically_accepted :
    ¬ SkepticallyAccepted genesisDispute.defeats .posterity :=
  fun h => by simpa using h _ wording_is_one_resolution

end TestimonyArguments.BornOfAVirgin
