import TestimonyArguments.Trinity.Order
import Testimony.Logic.Declare

/-!
# TestimonyArguments.Trinity.OrderDispute — the readings of the order texts weighed

Seven positions are parties to one dispute: LST, which holds only the order the
texts establish; the Arians; Augustine, Athanasius and Calvin, each with his own
reading of "the Father is greater than I"; Grudem and Ware, for an eternal order
of authority and submission; and Giles, against it. Who defeats whom is computed
from their premises and checked by the kernel.

## What the weighing found

What the texts establish is forced, and nothing more (`the_order_prevails`):
every party holds every premise LST holds, so nothing attacks it.

Over the Son's divinity, the Arian reading and each Nicene reading of John 14:28
defeat each other, and Calvin's reading and Augustine's defeat each other too,
because Calvin denies that the verse speaks of the Son's human nature. Each of
those readings is rated `disputed`, so no rating breaks a standoff. Each of these
positions can be defended and none is forced, the Arian one included
(`arian_reading_defensible`). That is a result about what five verses and four
readings of one of them carry. The case for the Son's divinity rests on other
texts, John 1:1 and 20:28 among them, which this dispute does not hear. LST
confesses the Son's divinity from those texts, not from these.

Over the eternal order, Grudem and Ware and Giles defeat each other, and neither
is forced (`eternal_order_not_forced`, `equal_authority_not_forced`). That is
LST's grading of the question, reproduced given these ratings.
-/

namespace TestimonyArguments.Trinity

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-- The parties to the dispute over the order texts. LST's weakest link is
`wellSupported`; every other party rests on a reading rated `disputed`. -/
inductive OrderParty
  /-- What the order texts establish, and no more: LST. -/
  | lst
  /-- The Son less in divinity: the Arians, as Augustine and Calvin report them. -/
  | arian
  /-- Less in the form of a servant, equal in the form of God: Augustine. -/
  | augustine
  /-- Greater as the one the Son is from: Athanasius. -/
  | athanasius
  /-- The Mediator's humbled state: Calvin. -/
  | calvin
  /-- An eternal order of authority and submission: Grudem, Ware. -/
  | eternal
  /-- No eternal subordination in authority: Giles. -/
  | equal
deriving DecidableEq

/-- The package each party argues from. -/
@[trinityDefs]
def orderPartyNode : OrderParty → ArgumentPackage Claim
  | .lst => lstOrderCase
  | .arian => arianCase
  | .augustine => augustineCase
  | .athanasius => athanasiusCase
  | .calvin => calvinCase
  | .eternal => eternalAuthorityCase
  | .equal => equalAuthorityCase

/-- The dispute over the order texts: every party can be held without
contradiction, delivers its conclusion, and has its steps rated. -/
declare_dispute orderDispute := orderPartyNode using trinityDefs
  /-- **Who defeats whom**, all 49 pairs. The Arians and each of Augustine,
  Athanasius and Calvin defeat each other. Calvin and Augustine defeat each other
  as well: Calvin denies that John 14:28 speaks of the Son's human nature, which
  is Augustine's reading. Grudem and Ware and Giles defeat each other. Nothing
  attacks LST. Every cell is checked by the kernel. -/
  defeats
    [ (.arian, .augustine), (.augustine, .arian), (.arian, .athanasius)
    , (.athanasius, .arian), (.arian, .calvin), (.calvin, .arian)
    , (.augustine, .calvin), (.calvin, .augustine), (.eternal, .equal), (.equal, .eternal) ]
  /-- **Nothing supports anything**, in all 49 pairs. Every cell is checked by the
  kernel. -/
  supports []
  /-- **LST's case is part of every other party's**, since each holds the order
  texts and the order drawn from them. Every cell is checked by the kernel. -/
  partOf
    [ (.lst, .arian), (.lst, .augustine), (.lst, .athanasius), (.lst, .calvin)
    , (.lst, .eternal), (.lst, .equal) ]
  /-- The dispute over the order texts drawn: who defeats whom, and whose case is
  part of whose. -/
  map orderMap

/-- **Augustine and Athanasius stand together**, and with Grudem and Ware: one
reading holds the two forms, "greater" as the one the Son is from, and an eternal
order. -/
theorem augustine_stands_with_athanasius :
    orderDispute.StandTogether [.lst, .augustine, .athanasius, .eternal] := by
  satisfied_by augustineReading [Dispute.StandTogether, trinityDefs]

/-! ### What the dispute decides -/

/-- How far the dispute is settled, in one stage: nothing defeats LST, so it is
forced, and nothing joins it, because every other party has a defeater it does
not answer. -/
declare_verdict orderUnanswered for orderDispute :
    .groundedExactly [[.lst]]
      [ (.arian, .augustine), (.augustine, .arian), (.athanasius, .arian), (.calvin, .arian)
      , (.eternal, .equal), (.equal, .eternal) ]
  /-- **What the order texts establish prevails, and nothing more.** What the
  dispute forces before any choice between rivals is exactly LST's position: a
  real order of Father and Son in the work of salvation. Nothing defeats it,
  because every party holds every premise it holds.

  What this does not claim: anything about the Son's divinity, or about whether
  the order is eternal. Those are in standoffs, and nothing in them is forced. -/
  proves @[headline] the_order_prevails

#print axioms the_order_prevails

/-- Why the Arian reading can be defended on the order texts: with LST, it
answers every Nicene reading itself. -/
declare_verdict arianWithTheOrder for orderDispute : .credulous .arian [.lst, .arian]
  /-- **On the order texts alone, the Arian reading can be defended.** The Nicene
  readings of John 14:28 and the Arian one are each rated `disputed`, so each
  defeats the other and none prevails.

  What this does not claim: that the Son is less than the Father. It weighs five
  verses and four readings of one of them. The texts that say the Son is God,
  John 1:1 and 20:28 among them, are not heard here, and they are where LST
  confesses his divinity from. -/
  proves @[headline] arian_reading_defensible

#print axioms arian_reading_defensible

/-- Why the Arian reading is not forced: a defensible position holds Augustine's,
and Augustine's defeats it. -/
declare_verdict arianAnsweredByAugustine for orderDispute :
    .notSkeptical .arian .augustine [.lst, .augustine, .athanasius]
  /-- **Nor is it forced.** A maximal defensible position holds Augustine's and
  Athanasius's readings, and cannot hold the Arian one with them. -/
  proves @[headline] arian_reading_not_forced

#print axioms arian_reading_not_forced

/-- Why Augustine's reading can be defended: with Athanasius's, it answers the
Arians and Calvin itself. -/
declare_verdict augustineWithAthanasius for orderDispute :
    .credulous .augustine [.lst, .augustine, .athanasius]
  /-- **Augustine's reading can be defended**, with Athanasius's. -/
  proves @[headline] augustine_reading_defensible

#print axioms augustine_reading_defensible

/-- Why Calvin's reading can be defended: with Athanasius's, it answers the
Arians and Augustine itself. -/
declare_verdict calvinWithAthanasius for orderDispute :
    .credulous .calvin [.lst, .calvin, .athanasius]
  /-- **Calvin's reading can be defended**, with Athanasius's; not with
  Augustine's, which it denies. -/
  proves @[headline] calvin_reading_defensible

#print axioms calvin_reading_defensible

/-- Why Athanasius's reading can be defended: it answers the Arians itself. -/
declare_verdict athanasiusWithTheOrder for orderDispute :
    .credulous .athanasius [.lst, .athanasius]
  /-- **Athanasius's reading can be defended.** It stands with Augustine's and
  with Calvin's, which do not stand with each other. -/
  proves @[headline] athanasius_reading_defensible

#print axioms athanasius_reading_defensible

/-- Why the eternal order can be defended: it answers Giles itself. -/
declare_verdict eternalWithTheOrder for orderDispute : .credulous .eternal [.lst, .eternal]
  /-- **The eternal order of Grudem and Ware can be defended.** -/
  proves @[headline] eternal_order_defensible

#print axioms eternal_order_defensible

/-- Why the eternal order is not forced: a defensible position holds Giles's, and
Giles's defeats it. -/
declare_verdict eternalAnsweredByGiles for orderDispute :
    .notSkeptical .eternal .equal [.lst, .equal]
  /-- **Nor is it forced.** A maximal defensible position holds Giles's position,
  and cannot hold the eternal order with it. -/
  proves @[headline] eternal_order_not_forced

#print axioms eternal_order_not_forced

/-- Why Giles's position can be defended: it answers the eternal order itself. -/
declare_verdict equalWithTheOrder for orderDispute : .credulous .equal [.lst, .equal]
  /-- **Giles's position can be defended.** -/
  proves @[headline] equal_authority_defensible

#print axioms equal_authority_defensible

/-- Why Giles's position is not forced: a defensible position holds the eternal
order, and it defeats Giles's. -/
declare_verdict equalAnsweredByTheEternalOrder for orderDispute :
    .notSkeptical .equal .eternal [.lst, .eternal]
  /-- **Nor is it forced.** Between the eternal order and Giles's denial of it the
  dispute chooses neither, as LST says the texts do not. -/
  proves @[headline] equal_authority_not_forced

#print axioms equal_authority_not_forced

end TestimonyArguments.Trinity
