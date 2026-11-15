import TestimonyArguments.SolaGratia.Thomist
import Testimony.Logic.Declare

/-!
# TestimonyArguments.SolaGratia.Dispute — the positions weighed

Nine parties are heard. One holds only what all of them hold: salvation is by
grace, from Romans 11:6. Then Dort; Trent, on the Molinist reading of its fourth
canon; the Thomists, on theirs; the Remonstrants; the Lutherans of the Formula
of Concord; Wesley; the third way as it was put to this argument; and the
objection from the Spirit's resistance, with its three routes to the claim that
the grace that saves can be finally refused. Who defeats whom is
computed from their premises and checked by the kernel.

## How to read the verdicts

- **Weakest link.** A position is only as strong as its least-supported premise
  or step. What every party holds rests on Romans 11:6 and a step rated
  *consensus*, accepted across traditions. Every other position rests on at
  least one reading or step rated *disputed*, the lowest rating, so no rating
  breaks a standoff between them.
- **Defeats.** One position contradicts another (it denies one of the other's
  premises, its conclusion, or a claim it derives on the way), and its weakest
  link is not rated below the other's. A defeat that runs both ways is a
  *standoff*.
- **Settled before any choice.** What prevails once every unanswered attack is
  taken into account, before any standoff is decided either way.
- **Can be defended.** Held by some consistent group of positions that answers
  every attack on its members, by itself or through an ally. Such a group that
  no further party can join is a *maximal defensible position*.
- **Forced.** Held in every maximal defensible position, however the standoffs
  are resolved. A party is shown not forced by naming a maximal defensible
  position that does not hold it.

Dort's position here does not carry faith alone: the Reformed case is stated
from Ephesians 2 and Romans 9, and sola fide is an argument of its own. So Dort
and Trent are never set against each other over it; they stand off over the
will's passivity and grace effectual of itself.

## What the weighing found

Only what every party holds is settled before any choice: salvation is by grace
(`only_grace_prevails`). Everything else is in a standoff with something.

- **Dort stands off against every party that denies part of sola gratia:**
  Trent, the Remonstrants, the Lutherans, Wesley and the objection. Each of
  them defeats Dort, and Dort defeats each back.
- **Neither Dort nor the Thomists defeats the other**
  (`dort_stands_with_the_thomists`), because the Thomist position weighed here
  takes no side on the will's passivity: it holds that the will is "not merely
  passive" and draws nothing from it. So this does not show that the Thomists
  hold the third part of sola gratia. In the Molinists' sense the phrase cannot
  be held with Dort; in Garrigou-Lagrange's it can (the chapter on Aquinas). On
  faith alone and perseverance, on which they part, Dort's position here carries
  nothing. So the Thomists can be defended with Dort (`thomist_defensible`).
- **The Thomists stand off against every party but Dort and what every party
  holds.** Against the Remonstrants, the Lutherans, Wesley and the objection, the
  standoff is over grace effectual of itself, which the claim that the grace
  that saves can be finally refused excludes. Against the third way, the
  Lutherans and Wesley, it is also over faith alone. Against Trent on the
  Molinist reading, it is the question Rome left open in 1607.
- **Trent stands off against Dort, the Thomists, the Lutherans, Wesley and the
  third way.** With the Thomists the standoff is over grace effectual of itself,
  the question of the two Catholic schools that Rome left open in 1607
  (`thomist_not_forced`); with the Lutherans, Wesley and the third way it is
  over faith alone, which Trent's ninth canon condemns; with the Lutherans also
  over the will's passivity.
- **The Remonstrants, the Lutherans, Wesley and the objection do not defeat one
  another.** They agree that the grace that saves can be finally refused. The
  Lutherans also hold the will passive; the Remonstrants and Wesley are not
  encoded with a view on that, so nothing here sets them against each other.
- **The third way is attacked only over faith alone**, by Trent and by the
  Thomists. It takes no side between Dort and Wesley, and so it can be defended
  with either:
  with Dort, against Trent (`third_way_defensible_with_dort`); and with the
  Remonstrants, the Lutherans and Wesley, against both Dort and Trent
  (`third_way_defensible_with_wesley`). The dilemma found the same thing: until
  the third way says which kind of help God gives, it has taken neither side.
- **Trent can be defended with the Remonstrants and the objection**, which agree
  with it that grace can be resisted, against Dort.

Every party can be defended, and only the first is forced: each of the others is
left out of some maximal defensible position. Each standoff rests on readings
and steps rated *disputed*, so the verdict moves only if a new, cited argument
moves one of those ratings.
-/

namespace TestimonyArguments.SolaGratia

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### The dispute -/

/-- The parties to the dispute over sola gratia. -/
inductive Party
  /-- What every party holds: salvation is by grace (Romans 11:6). Its weakest
  link is `consensus`. -/
  | grace
  /-- Dort and Westminster: sola gratia, all three parts. Its weakest link is
  `disputed`: the steps from each strand's reading to God's work alone, and the
  step from God's work alone to grace that cannot be finally refused. -/
  | reformed
  /-- Trent: the will cooperates and can refuse; not by faith alone. Its weakest
  link is `disputed`: its claims from canon 4 and canon 9, and its step from the
  will's power to refuse. -/
  | trent
  /-- The Remonstrants: grace resistible, read from Acts 7:51. Its weakest link
  is `disputed`: its reading of what Stephen's hearers resisted. -/
  | remonstrant
  /-- The Lutherans: the will passive, grace resistible, faith alone. Its weakest
  link is `disputed`: that grieving the Spirit can end in losing him, and that
  conversion is God's work alone. -/
  | lutheran
  /-- Wesley: preventing grace restores to all an ability that can be refused,
  received by faith alone. Its weakest link is `disputed`: faith alone. -/
  | wesleyan
  /-- The third way: an ability given, received by faith alone. Its weakest link
  is `disputed`: faith alone, which Trent condemns. -/
  | thirdWay
  /-- The objection from the Spirit's resistance. Its weakest link is
  `disputed`: each of its three readings, and its step from the unforgivable
  sin. -/
  | objection
  /-- The Thomists: grace efficacious of itself, Trent's canon 4 read so that it
  denies neither part of sola gratia, and not faith alone. Its weakest link is
  `disputed`: the step from God's intention to grace effectual of itself, and
  operating grace, which the Molinists deny. -/
  | thomist
deriving DecidableEq

/-- The package each party argues from. -/
@[solaGratiaDefs]
def partyNode : Party → ArgumentPackage Claim
  | .grace => graceCase
  | .reformed => reformed
  | .trent => tridentinePosition
  | .remonstrant => remonstrantPosition
  | .lutheran => lutheranPosition
  | .wesleyan => wesleyanPosition
  | .thirdWay => thirdWay
  | .objection => objection
  | .thomist => thomistPosition

/-- The dispute over sola gratia: every party can be held without
contradiction, delivers its conclusion, and has its steps rated. -/
declare_dispute solaGratiaDispute := partyNode using solaGratiaDefs
  /-- **Who defeats whom**, all 81 pairs: twenty-eight defeats, every one of them
  half of a standoff. Dort stands off against Trent, the Remonstrants, the
  Lutherans, Wesley and the objection; Trent against Dort, the Lutherans, Wesley,
  the third way and the Thomists; the Thomists against every party but Dort and
  what every party holds. Dort and the Thomists defeat neither each other.
  Nothing attacks what every party holds. Every cell is checked by the kernel. -/
  defeats
    [ (.reformed, .trent), (.reformed, .remonstrant), (.reformed, .lutheran)
    , (.reformed, .wesleyan), (.reformed, .objection)
    , (.trent, .reformed), (.trent, .lutheran), (.trent, .wesleyan), (.trent, .thirdWay)
    , (.trent, .thomist)
    , (.remonstrant, .reformed), (.remonstrant, .thomist)
    , (.lutheran, .reformed), (.lutheran, .trent), (.lutheran, .thomist)
    , (.wesleyan, .reformed), (.wesleyan, .trent), (.wesleyan, .thomist)
    , (.thirdWay, .trent), (.thirdWay, .thomist)
    , (.objection, .reformed), (.objection, .thomist)
    , (.thomist, .trent), (.thomist, .remonstrant), (.thomist, .lutheran)
    , (.thomist, .wesleyan), (.thomist, .thirdWay), (.thomist, .objection) ]

/-! ### What the dispute decides -/

/-- How far the dispute is settled before any choice. Nothing defeats what every
party holds, so it is settled first; and nothing is settled with it, because
every other party has a defeater that what every party holds does not answer. -/
declare_verdict graceUnanswered for solaGratiaDispute :
    .groundedExactly [[.grace]]
      [ (.reformed, .trent), (.trent, .reformed), (.remonstrant, .reformed)
      , (.lutheran, .reformed), (.wesleyan, .reformed), (.thirdWay, .trent)
      , (.objection, .reformed), (.thomist, .trent) ]
  /-- **Only what every party holds prevails: salvation is by grace.** What the
  dispute settles before any choice between rivals is that, and nothing more.
  Nothing defeats it, because every party holds every premise it holds.

  What this does not claim: that sola gratia is false, or that any rival is
  right. Every other position is in a standoff, and none is forced. -/
  proves @[headline] only_grace_prevails

#print axioms only_grace_prevails

/-- Why Dort can be defended: with what every party holds and the third way, it
answers every attacker itself. -/
declare_verdict dortDefended for solaGratiaDispute :
    .credulous .reformed [.grace, .reformed, .thirdWay]
  /-- **Dort can be defended**, together with what every party holds and the
  third way: some maximal defensible position, one no other party can join,
  holds all three. -/
  proves @[headline] reformed_defensible

#print axioms reformed_defensible

/-- Why Dort is not forced: a defensible position holds the Remonstrants, and
they defeat Dort. -/
declare_verdict dortAnsweredByTheRemonstrants for solaGratiaDispute :
    .notSkeptical .reformed .remonstrant
      [.grace, .remonstrant, .lutheran, .wesleyan, .thirdWay, .objection]
  /-- Nor is Dort forced. A maximal defensible position holds the Remonstrants,
  the Lutherans, Wesley, the third way and the objection, and cannot hold Dort
  with them. -/
  proves @[headline] reformed_not_forced

#print axioms reformed_not_forced

/-- Why the Lutherans can be defended: with the Remonstrants and Wesley they
answer both Dort and Trent. -/
declare_verdict lutheransDefended for solaGratiaDispute :
    .credulous .lutheran [.grace, .remonstrant, .lutheran, .wesleyan, .thirdWay, .objection]
  /-- **The Lutheran position can be defended**, with the Remonstrants, Wesley,
  the third way and the objection. -/
  proves @[headline] lutheran_defensible

#print axioms lutheran_defensible

/-- Why Trent can be defended: it answers every attacker of its group itself. -/
declare_verdict trentDefended for solaGratiaDispute :
    .credulous .trent [.grace, .trent, .remonstrant, .objection]
  /-- **Trent can be defended**, with what every party holds, the Remonstrants and
  the objection, which agree with it that grace can be resisted. Only Dort
  attacks the Remonstrants and the objection, and Trent answers Dort. -/
  proves @[headline] tridentine_defensible

#print axioms tridentine_defensible

/-- Why Trent is not forced: a maximal defensible position holds Dort, and Dort
defeats Trent. -/
declare_verdict trentAnsweredByDort for solaGratiaDispute :
    .notSkeptical .trent .reformed [.grace, .reformed, .thirdWay]
  /-- Nor is Trent forced. The maximal defensible position that holds Dort and the
  third way cannot hold Trent with them. -/
  proves @[headline] tridentine_not_forced

#print axioms tridentine_not_forced

/-- Why the Remonstrants are not forced: Dort's position defeats them. -/
declare_verdict remonstrantsAnsweredByDort for solaGratiaDispute :
    .notSkeptical .remonstrant .reformed [.grace, .reformed, .thirdWay]
  /-- The Remonstrants can be defended (with the Lutherans and Wesley, as
  `lutheran_defensible` shows), and are not forced: the maximal defensible
  position that holds Dort cannot hold them. -/
  proves @[headline] remonstrant_not_forced

#print axioms remonstrant_not_forced

/-- Why the Lutherans are not forced: Dort's position defeats them. -/
declare_verdict lutheransAnsweredByDort for solaGratiaDispute :
    .notSkeptical .lutheran .reformed [.grace, .reformed, .thirdWay]
  /-- Nor are the Lutherans forced: the maximal defensible position that holds
  Dort cannot hold them. -/
  proves @[headline] lutheran_not_forced

#print axioms lutheran_not_forced

/-- Why Wesley is not forced: Dort's position defeats him. -/
declare_verdict wesleyAnsweredByDort for solaGratiaDispute :
    .notSkeptical .wesleyan .reformed [.grace, .reformed, .thirdWay]
  /-- Nor is Wesley's position forced: the maximal defensible position that holds
  Dort cannot hold it. -/
  proves @[headline] wesleyan_not_forced

#print axioms wesleyan_not_forced

/-- Why the objection is not forced: Dort's position defeats it. -/
declare_verdict objectionAnsweredByDort for solaGratiaDispute :
    .notSkeptical .objection .reformed [.grace, .reformed, .thirdWay]
  /-- Nor is the objection from the Spirit's resistance forced: the maximal
  defensible position that holds Dort cannot hold it. -/
  proves @[headline] objection_not_forced

#print axioms objection_not_forced

/-- The third way, defended with Dort. -/
declare_verdict thirdWayWithDort for solaGratiaDispute :
    .credulous .thirdWay [.grace, .reformed, .thirdWay]
  /-- **The third way can be defended with Dort**, against Trent, by the position
  shown above. Trent attacks the third way over faith alone; Dort, which defeats
  Trent over the will and grace, answers that attack; and nothing in the third
  way contradicts Dort. -/
  proves @[headline] third_way_defensible_with_dort

#print axioms third_way_defensible_with_dort

/-- The third way, defended with Wesley. -/
declare_verdict thirdWayWithWesley for solaGratiaDispute :
    .credulous .thirdWay [.grace, .remonstrant, .lutheran, .wesleyan, .thirdWay, .objection]
  /-- It can also be defended with Wesley, the Lutherans and the Remonstrants,
  against both Dort and Trent, by the position shown above. The third way, as
  stated, takes no side between Dort and Wesley. -/
  proves @[headline] third_way_defensible_with_wesley

#print axioms third_way_defensible_with_wesley

/-- Why the third way is not forced: a defensible position holds Trent, and Trent
defeats it. -/
declare_verdict thirdWayAnsweredByTrent for solaGratiaDispute :
    .notSkeptical .thirdWay .trent [.grace, .trent, .remonstrant, .objection]
  /-- Nor is the third way forced. A maximal defensible position holds Trent,
  which condemns faith alone, and cannot hold the third way with it. -/
  proves @[headline] third_way_not_forced

#print axioms third_way_not_forced

/-- **Dort and the Thomists stand together**: one reading satisfies every premise
and every conclusion of both, so neither defeats the other. The Thomist position
weighed here takes no side on the will's passivity. It holds that the will is
"not merely passive" and draws nothing from it, so this result does not show
that the Thomists hold the third part of sola gratia. Read in the Molinists'
sense, the phrase cannot be held with Dort (`whereTheAgentReadingFalls`); read in
Garrigou-Lagrange's, it can (`dort_holds_with_garrigou_lagrange`). They differ on
faith alone and on perseverance, which this dispute does not weigh between
them. -/
@[headline]
theorem dort_stands_with_the_thomists :
    solaGratiaDispute.StandTogether [.reformed, .thomist] := by
  satisfied_by thomistWithDortReading [Dispute.StandTogether, solaGratiaDefs]

#print axioms dort_stands_with_the_thomists

/-- The Thomists, defended with Dort. -/
declare_verdict thomistsWithDort for solaGratiaDispute :
    .credulous .thomist [.grace, .reformed, .thomist]
  /-- **The Thomists can be defended, with Dort**: some maximal defensible
  position holds both, with what every party holds. Between them they answer
  every attack on either. -/
  proves @[headline] thomist_defensible

#print axioms thomist_defensible

/-- Why the Thomists are not forced: a maximal defensible position holds Trent on
the Molinist reading, and Trent defeats them. -/
declare_verdict thomistsAnsweredByTrent for solaGratiaDispute :
    .notSkeptical .thomist .trent [.grace, .trent, .remonstrant, .objection]
  /-- Nor are the Thomists forced. A maximal defensible position holds Trent on
  the Molinist reading, with the Remonstrants and the objection, and cannot hold
  the Thomists with them: the dispute between the two Catholic schools, which
  Rome left open in 1607, is a standoff here too. -/
  proves @[headline] thomist_not_forced

#print axioms thomist_not_forced

end TestimonyArguments.SolaGratia
