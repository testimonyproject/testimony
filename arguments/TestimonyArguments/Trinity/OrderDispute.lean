import TestimonyArguments.Trinity.Order
import Testimony.Logic.Declare

/-!
# TestimonyArguments.Trinity.OrderDispute — the readings of the order texts weighed

Seven positions are parties to one dispute: LST, which holds only the order the
texts establish; the Arians; Augustine, Athanasius and Calvin, each with his own
reading of "the Father is greater than I"; Grudem and Ware, for an eternal order
of authority and submission; and Giles, against it.

## How to read the verdicts

One position *defeats* another when it denies something the other needs and does
not rest on anything rated lower. Every reading here is rated `disputed`, the
lowest rating, because cited readers disagree over it; so when two readings deny
each other, each defeats the other, and that is a tie. A position is *forced*
when it is accepted however the ties are settled. It *can be defended* when some
consistent way of settling them accepts it, and it is *not forced* when another
consistent way leaves it out. Every defeat is computed from the positions'
premises, and Lean checks each computation.

## What the weighing found

LST's position is accepted at once, because nothing defeats it
(`the_order_prevails`): every other party holds every premise it holds.

Over the Son's divinity, the Arian reading and each Nicene reading of John 14:28
(Nicene: of the Council of Nicaea, 325, which confessed the Son of one being with
the Father) defeat each other. Calvin's reading and Augustine's defeat each other
too, because Calvin denies that the verse speaks of the Son's human nature. Every
one of these positions can be defended and none is forced, the Arian one
included (`arian_reading_defensible`, `arian_reading_not_forced`,
`augustine_reading_not_forced`, `athanasius_reading_not_forced`,
`calvin_reading_not_forced`). That is because the readings that answer the
Arian one are rated no higher than it. It is a finding about the five order
texts, Philippians 2:6 and four readings of one verse. LST confesses the Son's
divinity from John 1:1, 20:28 and the other texts of its next question, which
this dispute does not hear.

Over the eternal order, Grudem and Ware and Giles defeat each other, and neither
is forced (`eternal_order_not_forced`, `equal_authority_not_forced`). That agrees
with LST: the texts do not establish an eternal hierarchy. If either reading were
rated above the other, the verdict could change.
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

/-- **Augustine's and Athanasius's readings can be held with Grudem and Ware's
eternal order**: nothing in the two forms, or in "greater" as the one the Son is
from, rules it out. This does not say that Augustine or Athanasius held it. Giles
reads them as denying it, and Augustine writes that the Son "was not sent in
virtue of some disparity of power or substance" (*On the Trinity* IV.20.27, as
Grudem quotes it). -/
theorem nicene_readings_stand_with_the_eternal_order :
    orderDispute.StandTogether [.lst, .augustine, .athanasius, .eternal] := by
  satisfied_by augustineReading [Dispute.StandTogether, trinityDefs]

/-- **They can be held with Giles's denial of it too.** So the two Nicene
readings of John 14:28 take no side in the second question. -/
theorem nicene_readings_stand_with_giles :
    orderDispute.StandTogether [.lst, .augustine, .athanasius, .equal] := by
  satisfied_by nicenWithGilesReading [Dispute.StandTogether, trinityDefs]

/-! ### What the dispute decides -/

/-- LST's position is accepted at once, because nothing defeats it. No other
position can be added to it, because each is defeated by a rival that nothing
already accepted answers. -/
declare_verdict orderUnanswered for orderDispute :
    .groundedExactly [[.lst]]
      [ (.arian, .augustine), (.augustine, .arian), (.athanasius, .arian), (.calvin, .arian)
      , (.eternal, .equal), (.equal, .eternal) ]
  /-- **What the order texts establish is forced, and nothing more**: a real
  order of Father and Son in the work of salvation. Nothing defeats it, because
  every party holds every premise it holds. It says nothing about the Son's
  divinity or about whether the order is eternal; on both, every position is in
  a tie. -/
  proves @[headline] the_order_prevails

#print axioms the_order_prevails

/-- Held with LST's position, the Arian reading defeats each Nicene reading that
defeats it. -/
declare_verdict arianWithTheOrder for orderDispute : .credulous .arian [.lst, .arian]
  /-- **On the order texts alone, the Arian reading can be defended**: some
  consistent way of settling the dispute accepts it. That is because the readings
  that answer it, Augustine's, Athanasius's and Calvin's, are rated no higher than
  it, so each answers the other and none is chosen. It does not say the reading
  is likely, or that the Son is less than the Father. The texts that say the Son
  is God, John 1:1 and 20:28 among them, are not heard here. -/
  proves @[headline] arian_reading_defensible

#print axioms arian_reading_defensible

/-- Augustine's and Athanasius's readings, held together, each defeat the Arian
one. -/
declare_verdict arianAnsweredByAugustine for orderDispute :
    .notSkeptical .arian .augustine [.lst, .augustine, .athanasius]
  /-- **The Arian reading is not forced.** One consistent way of settling the
  dispute, which can take in no further position, holds Augustine's and
  Athanasius's readings, and the Arian one cannot join them. -/
  proves @[headline] arian_reading_not_forced

#print axioms arian_reading_not_forced

/-- Held with Athanasius's, Augustine's reading defeats both the Arian reading
and Calvin's, the two that defeat it. -/
declare_verdict augustineWithAthanasius for orderDispute :
    .credulous .augustine [.lst, .augustine, .athanasius]
  /-- **Augustine's reading can be defended**, with Athanasius's. -/
  proves @[headline] augustine_reading_defensible

#print axioms augustine_reading_defensible

/-- Held with LST's position, the Arian reading defeats Augustine's. -/
declare_verdict augustineAnsweredByArius for orderDispute :
    .notSkeptical .augustine .arian [.lst, .arian]
  /-- **Augustine's reading is not forced**: the Arian reading, rated no lower,
  leaves it out of one consistent settlement. -/
  proves @[headline] augustine_reading_not_forced

#print axioms augustine_reading_not_forced

/-- Athanasius's reading defeats the Arian one, the only reading that defeats
it. -/
declare_verdict athanasiusWithTheOrder for orderDispute :
    .credulous .athanasius [.lst, .athanasius]
  /-- **Athanasius's reading can be defended.** It can be held with Augustine's
  and with Calvin's, which cannot be held with each other. -/
  proves @[headline] athanasius_reading_defensible

#print axioms athanasius_reading_defensible

/-- Held with LST's position, the Arian reading defeats Athanasius's. -/
declare_verdict athanasiusAnsweredByArius for orderDispute :
    .notSkeptical .athanasius .arian [.lst, .arian]
  /-- **Athanasius's reading is not forced**, for the same reason as Augustine's. -/
  proves @[headline] athanasius_reading_not_forced

#print axioms athanasius_reading_not_forced

/-- Held with Athanasius's, Calvin's reading defeats both the Arian reading and
Augustine's, the two that defeat it. -/
declare_verdict calvinWithAthanasius for orderDispute :
    .credulous .calvin [.lst, .calvin, .athanasius]
  /-- **Calvin's reading can be defended**, with Athanasius's, and not with
  Augustine's, whose reading of the verse it denies. -/
  proves @[headline] calvin_reading_defensible

#print axioms calvin_reading_defensible

/-- Held with LST's position, the Arian reading defeats Calvin's. -/
declare_verdict calvinAnsweredByArius for orderDispute :
    .notSkeptical .calvin .arian [.lst, .arian]
  /-- **Calvin's reading is not forced**: the Arian reading leaves it out of one
  consistent settlement, and so does Augustine's. -/
  proves @[headline] calvin_reading_not_forced

#print axioms calvin_reading_not_forced

/-- Held with LST's position, the eternal order defeats Giles's denial of it, the
one position that defeats it. -/
declare_verdict eternalWithTheOrder for orderDispute : .credulous .eternal [.lst, .eternal]
  /-- **Grudem and Ware's eternal order can be defended.** -/
  proves @[headline] eternal_order_defensible

#print axioms eternal_order_defensible

/-- Held with LST's position, Giles's denial defeats the eternal order. -/
declare_verdict eternalAnsweredByGiles for orderDispute :
    .notSkeptical .eternal .equal [.lst, .equal]
  /-- **The eternal order is not forced**: Giles's position can be held with LST's,
  and it rules the eternal order out. -/
  proves @[headline] eternal_order_not_forced

#print axioms eternal_order_not_forced

/-- Held with LST's position, Giles's denial defeats the eternal order, the one
position that defeats it. -/
declare_verdict equalWithTheOrder for orderDispute : .credulous .equal [.lst, .equal]
  /-- **Giles's position can be defended**: held with LST's, it answers Grudem and
  Ware's position, which is the only one that attacks it. -/
  proves @[headline] equal_authority_defensible

#print axioms equal_authority_defensible

/-- Held with LST's position, the eternal order defeats Giles's denial. -/
declare_verdict equalAnsweredByTheEternalOrder for orderDispute :
    .notSkeptical .equal .eternal [.lst, .eternal]
  /-- **Giles's position is not forced** either. Between it and the eternal order
  the dispute chooses neither, as LST says the texts do not. -/
  proves @[headline] equal_authority_not_forced

#print axioms equal_authority_not_forced

end TestimonyArguments.Trinity
