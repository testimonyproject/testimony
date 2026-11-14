import TestimonyArguments.SolaGratia.ThirdWay
import Testimony.Logic.Declare

/-!
# TestimonyArguments.SolaGratia.Dispute — the positions weighed

Eight parties are heard. One holds only what all of them hold: salvation is by
grace, from Romans 11:6. Then Dort; Trent; the Remonstrants; the Lutherans of
the Formula of Concord; Wesley; the third way as it was put to this argument;
and the objection from the Spirit's resistance, with its three routes to the
claim that the grace that saves can be finally refused. Who defeats whom is
computed from their premises and checked by the kernel.

## How to read the verdicts

- **Defeats.** One position contradicts another (it denies one of the other's
  premises, its conclusion, or a claim it derives on the way) and is not the
  weaker of the two. A defeat that runs both ways is a *standoff*.
- **Weakest link.** A position is only as strong as its least-supported premise
  or step. What every party holds rests on Romans 11:6 and a step rated
  `consensus`. Every other position rests on at least one reading or step rated
  `disputed`, the lowest rating, so no rating breaks a standoff between them.
- **Forced.** Accepted however every standoff is resolved.
- **Can be defended.** Held by some consistent position that answers every
  attack on its members, by itself or through an ally.

## What the weighing found

Only what every party holds is forced: salvation is by grace
(`only_grace_prevails`). Everything else is in a standoff with something.

- **Dort stands off against every party that denies part of sola gratia:**
  Trent, the Remonstrants, the Lutherans, Wesley and the objection. Each of
  them defeats Dort, and Dort defeats each back.
- **Trent stands off against Dort, the Lutherans, Wesley and the third way.**
  With the Lutherans, Wesley and the third way the standoff is over faith alone,
  which Trent's ninth canon condemns; with the Lutherans also over the will's
  passivity.
- **The Remonstrants, the Lutherans, Wesley and the objection do not defeat one
  another.** They agree that the grace that saves can be finally refused, and
  differ on what this dispute does not weigh.
- **The third way is attacked only by Trent**, and only over faith alone. It
  takes no side between Dort and Wesley, and so it can be defended with either:
  with Dort, against Trent (`third_way_defensible_with_dort`); and with the
  Remonstrants, the Lutherans and Wesley, against both Dort and Trent
  (`third_way_defensible_with_wesley`). That is the dispute's form of what the
  dilemma over the ability God gives shows: the third way, as stated, has not
  yet chosen.

Every party but the first can be defended and none is forced. What would move
that is a rating: each standoff rests on readings and steps rated `disputed`,
and a new, cited argument that one side's reading survives what the other side
says against it could move a rating, and so the verdict.
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

/-- The dispute over sola gratia: every party can be held without
contradiction, delivers its conclusion, and has its steps rated. -/
declare_dispute solaGratiaDispute := partyNode using solaGratiaDefs
  /-- **Who defeats whom**, all 64 pairs: sixteen defeats, every one of them half
  of a standoff. Dort stands off against Trent, the Remonstrants, the Lutherans,
  Wesley and the objection; Trent against Dort, the Lutherans, Wesley and the
  third way. Nothing attacks what every party holds. Every cell is checked by
  the kernel. -/
  defeats
    [ (.reformed, .trent), (.reformed, .remonstrant), (.reformed, .lutheran)
    , (.reformed, .wesleyan), (.reformed, .objection)
    , (.trent, .reformed), (.trent, .lutheran), (.trent, .wesleyan), (.trent, .thirdWay)
    , (.remonstrant, .reformed), (.lutheran, .reformed), (.lutheran, .trent)
    , (.wesleyan, .reformed), (.wesleyan, .trent), (.thirdWay, .trent)
    , (.objection, .reformed) ]

/-! ### What the dispute decides -/

/-- How far the dispute is settled, in one stage. Nothing defeats what every
party holds, so it comes first, and nothing joins it: every other party has a
defeater it does not answer. -/
declare_verdict graceUnanswered for solaGratiaDispute :
    .groundedExactly [[.grace]]
      [ (.reformed, .trent), (.trent, .reformed), (.remonstrant, .reformed)
      , (.lutheran, .reformed), (.wesleyan, .reformed), (.thirdWay, .trent)
      , (.objection, .reformed) ]
  /-- **Only what every party holds prevails: salvation is by grace.** What the
  dispute forces before any choice between rivals is that, and nothing more.
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
  third way: some maximal defensible position holds all three. -/
  proves @[headline] reformed_defensible

#print axioms reformed_defensible

/-- Why Dort is not forced: a defensible position holds the Remonstrants, and
they defeat Dort. -/
declare_verdict dortAnsweredByTheRemonstrants for solaGratiaDispute :
    .notSkeptical .reformed .remonstrant
      [.grace, .remonstrant, .lutheran, .wesleyan, .thirdWay, .objection]
  /-- **Nor is it forced.** A maximal defensible position holds the
  Remonstrants, the Lutherans, Wesley, the third way and the objection, and
  cannot hold Dort with them. -/
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

/-- Why Trent can be defended: it answers every attacker itself. -/
declare_verdict trentDefended for solaGratiaDispute : .credulous .trent [.grace, .trent]
  /-- **Trent can be defended**, with what every party holds. -/
  proves @[headline] tridentine_defensible

#print axioms tridentine_defensible

/-- The third way, defended with Dort. -/
declare_verdict thirdWayWithDort for solaGratiaDispute :
    .credulous .thirdWay [.grace, .reformed, .thirdWay]
  /-- **The third way can be defended with Dort**, against Trent: Dort answers
  Trent's attack on faith alone, and the third way grants everything Dort
  holds. -/
  proves @[headline] third_way_defensible_with_dort

#print axioms third_way_defensible_with_dort

/-- The third way, defended with Wesley. -/
declare_verdict thirdWayWithWesley for solaGratiaDispute :
    .credulous .thirdWay [.grace, .remonstrant, .lutheran, .wesleyan, .thirdWay, .objection]
  /-- **And it can be defended with Wesley**, the Lutherans and the
  Remonstrants, against both Dort and Trent. The third way, as stated, takes no
  side between them. -/
  proves @[headline] third_way_defensible_with_wesley

#print axioms third_way_defensible_with_wesley

/-- Why the third way is not forced: a defensible position holds Trent, and Trent
defeats it. -/
declare_verdict thirdWayAnsweredByTrent for solaGratiaDispute :
    .notSkeptical .thirdWay .trent [.grace, .trent]
  /-- **Nor is the third way forced.** A maximal defensible position holds Trent,
  which condemns faith alone, and cannot hold the third way with it. -/
  proves @[headline] third_way_not_forced

#print axioms third_way_not_forced

end TestimonyArguments.SolaGratia
