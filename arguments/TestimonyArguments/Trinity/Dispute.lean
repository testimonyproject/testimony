import TestimonyArguments.Trinity.Procession
import Testimony.Logic.Declare

/-!
# TestimonyArguments.Trinity.Dispute — the three positions weighed

Three positions are parties to one dispute. LST holds only what it says the
texts establish: the Spirit is related to the Son as well as to the Father. The
West, with Aquinas, Florence and Westminster, holds that he proceeds from the
Father and the Son. The East, with Photius and Ware, holds that he proceeds from
the Father alone. Who defeats whom is computed from their premises and checked
by the kernel.

## How to read the verdicts

- **Defeats.** One position contradicts another (it denies one of the other's
  premises, its conclusion, or a claim it derives on the way) and is not the
  weaker of the two. A defeat that runs both ways is a *standoff*.
- **Weakest link.** A position is only as strong as its least-supported premise
  or step. LST's weakest link is `wellSupported`. Each side rests on readings
  rated `disputed`, the lowest rating, so no rating breaks their standoff.
- **Forced.** Accepted however every standoff is resolved.
- **Can be defended.** Held by some consistent position that answers every
  attack on its members, by itself or through an ally.

## What the weighing found

One standoff, and nothing else. The West and the East defeat each other over
"and the Son", and neither attacks LST, because each grants every text LST
cites and the relation LST draws from them. So what is forced is exactly LST's
position (`the_texts_prevail`). The West can be defended, and so can the East,
and neither is forced (`western_defensible`, `western_not_forced`,
`eastern_defensible`, `eastern_not_forced`).

That is LST's grading of the question, reproduced given these ratings: the relation of the Spirit to
the Son is settled, and "the exact eternal relation of the Spirit to the Son
beyond what Scripture states is not demonstrated". It does not show that the
question is idle, or that the two sides read equally well. It shows only that
the weighing cannot choose, because every reading that divides them is rated
`disputed`. A new, cited argument that one side's reading survives what the
other side says against it could move a rating, and so the verdict. LST's own
rating plays no part: nothing attacks its position, so it would prevail at any
rating.

The standoff rests on reading "proceeds" the same way on both sides. The
Pontifical Council for Promoting Christian Unity (1995) distinguishes the
Greek ἐκπόρευσις, origin from the Father alone, from the Latin *processio*.
On that distinction "and the Son" and "not from the Son" may not contradict each
other, and the two defeats would not exist. The chapter on the procession says
what testing that would take.
-/

namespace TestimonyArguments.Trinity

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### The dispute -/

/-- The parties to the dispute over the procession of the Spirit. -/
inductive Party
  /-- What the texts establish, and no more: LST. Its weakest link is
  `wellSupported`, the step from the texts to the relation, audited for a reader
  who grants the texts and denies the relation, and none found. -/
  | lst
  /-- From the Father and the Son: Aquinas, Florence, Westminster. Its weakest
  link is `disputed`: its readings of John 16:14 and of the mission, the claim
  that only opposed relations distinguish the persons, and its steps from John
  16:14 and from mission. Its step from distinction is `wellSupported`. -/
  | western
  /-- From the Father alone: Photius, Ware. Its weakest link is `disputed`: each
  of its two readings, and each of its two steps. -/
  | eastern
deriving DecidableEq

/-- The package each party argues from. -/
@[trinityDefs]
def partyNode : Party → ArgumentPackage Claim
  | .lst => lstCase
  | .western => westernCase
  | .eastern => easternCase

/-- The dispute over the procession: every party can be held without
contradiction, delivers its conclusion, and has its steps rated. -/
declare_dispute processionDispute := partyNode using trinityDefs
  /-- **Who defeats whom**, all 9 pairs: one standoff, the West and the East over
  "and the Son", and nothing else. Neither attacks LST, because each holds every
  premise LST holds. Every cell is checked by the kernel. -/
  defeats [(.western, .eastern), (.eastern, .western)]
  /-- **Nothing supports anything**, in all 9 pairs: no party's conclusion is a
  premise another party states. LST's relation is derived inside the other two
  positions, not assumed by them. Every cell is checked by the kernel. -/
  supports []
  /-- **LST's case is part of both the others'**, since each holds the texts and
  the step LST draws from them. Otherwise each case is part of its own only.
  Every cell is checked by the kernel. -/
  partOf [(.lst, .western), (.lst, .eastern)]
  /-- The dispute over the procession drawn: who defeats whom, and whose case is
  part of whose. -/
  map processionMap

/-- **LST stands with the West**: one reading satisfies both, the Western
reading. -/
theorem lst_stands_with_the_west : processionDispute.StandTogether [.lst, .western] := by
  satisfied_by westernReading [Dispute.StandTogether, trinityDefs]

/-- **LST stands with the East** too: the Eastern reading satisfies both. So
LST's position takes no side, which is what it says of itself. -/
theorem lst_stands_with_the_east : processionDispute.StandTogether [.lst, .eastern] := by
  satisfied_by easternReading [Dispute.StandTogether, trinityDefs]

/-! ### What the dispute decides -/

/-- How far the dispute is settled, in one stage. Nothing defeats LST, so it
comes first, and nothing joins it: the West has the East for a defeater, the
East has the West, and LST answers neither. -/
declare_verdict textsUnanswered for processionDispute :
    .groundedExactly [[.lst]] [(.western, .eastern), (.eastern, .western)]
  /-- **What the texts establish prevails, and nothing more.** What the dispute
  forces before any choice between rivals is exactly LST's position: the Spirit
  is related to the Son as well as to the Father. Nothing defeats it, because
  the West and the East both hold every premise it holds.

  What this does not claim: that the Filioque is false, or that it is true. The
  West and the East are in a standoff, and neither is forced. -/
  proves @[headline] the_texts_prevail

#print axioms the_texts_prevail

/-- Why the West can be defended: with LST, it answers the East itself. -/
declare_verdict westernWithTheTexts for processionDispute : .credulous .western [.lst, .western]
  /-- **The Western position can be defended**, together with LST's: some
  maximal defensible position, one no other party can join without losing that,
  holds both. -/
  proves @[headline] western_defensible

#print axioms western_defensible

/-- Why the West is not forced: a defensible position holds the East, and the
East defeats the West. -/
declare_verdict westernAnsweredByTheEast for processionDispute :
    .notSkeptical .western .eastern [.lst, .eastern]
  /-- **Nor is it forced.** A maximal defensible position holds LST's position
  and the East's, and cannot hold the West's with them. -/
  proves @[headline] western_not_forced

#print axioms western_not_forced

/-- Why the East can be defended: with LST, it answers the West itself. -/
declare_verdict easternWithTheTexts for processionDispute : .credulous .eastern [.lst, .eastern]
  /-- **The Eastern position can be defended**, together with LST's. -/
  proves @[headline] eastern_defensible

#print axioms eastern_defensible

/-- Why the East is not forced: a defensible position holds the West, and the
West defeats the East. -/
declare_verdict easternAnsweredByTheWest for processionDispute :
    .notSkeptical .eastern .western [.lst, .western]
  /-- **Nor is it forced.** A maximal defensible position holds LST's position
  and the West's, and cannot hold the East's with them. -/
  proves @[headline] eastern_not_forced

#print axioms eastern_not_forced

end TestimonyArguments.Trinity
