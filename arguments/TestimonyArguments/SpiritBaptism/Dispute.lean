import TestimonyArguments.Meanings.SpiritBaptism
import TestimonyArguments.SpiritBaptism.Positions
import Testimony.Logic.Declare

/-!
# TestimonyArguments.SpiritBaptism.Dispute — the four views weighed

The four views as parties to one dispute: at conversion; after it, as the
Pentecostals hold; after it, as the holiness tradition holds; and in baptism and
confirmation, as Rome holds. The Pentecostal and holiness views are *the
subsequence views*: both hold a second baptism in the Spirit, after conversion,
to be sought. Who defeats whom is computed from their premises and checked by the
kernel.

## How to read the verdicts

- **Defeats.** One position contradicts another — denies one of its premises,
  its conclusion, or a claim it derives on the way — and is not the weaker of
  the two. A defeat that runs both ways is a *standoff*.
- **Weakest link.** A position is only as strong as its least-supported premise
  or step. Every party here rests on something rated `disputed`, the lowest
  rating, so no rating breaks a standoff.
- **Forced.** Accepted however every standoff is resolved.
- **Can be defended.** Held by some consistent position that answers every
  attack on its members, itself or through an ally.
- **Not forced.** Some consistent position leaves it out — which is not the same
  as false.

## What the weighing found

Four standoffs, and nothing else. The conversion view stands off against both
subsequence views, and so does the sacramental view; the two subsequence views
do not attack each other, and neither do the conversion and sacramental views.
Nothing is forced (`spirit_baptism_forces_nothing`). Every view can be defended
(`conversion_defensible`, `pentecostal_defensible`, `holiness_defensible`,
`sacramental_defensible`), in one of two camps, and no position holds views from both: the
conversion and sacramental views together, and the Pentecostal and holiness
views together.

That is where the question stands in the literature, and the page says so rather
than choosing. The conversion and sacramental views agree that there is no
second baptism in the Spirit to seek, and differ over the rite, which this
dispute does not weigh. What would decide between the two camps is argued, not
weighed: what Luke's narratives are (`pentecostal_cannot_read_acts_as_transitions`
says the Pentecostal view must read them as a pattern), and whether
Paul's word at 1 Corinthians 12:13 and Luke's are the same baptism — a question
not yet encoded.
-/

namespace TestimonyArguments.SpiritBaptism

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### The dispute -/

/-- The parties to the dispute over Spirit baptism. Every one's weakest link is
`disputed`: the conversion view's reading of 1 Corinthians 12:13 and both of its
steps; the Pentecostal view's readings of 1 Corinthians 12:13, of Acts 8 and 19,
of Luke's Spirit baptism and of the narratives as a pattern, and its step from
the instrumental reading; the holiness view's premise and the step Wesley
contests; and the sacramental view's readings of the rite and both its steps. -/
inductive View
  /-- At conversion: Dunn, Stott. -/
  | conversion
  /-- After conversion, for empowerment: the Assemblies of God. -/
  | pentecostal
  /-- After conversion, as a second work of grace: the Church of the Nazarene. -/
  | holiness
  /-- In baptism and confirmation: Rome. Lutherans hold the first half. -/
  | sacramental
deriving DecidableEq

/-- The package each view argues from. -/
@[spiritBaptismDefs]
def viewNode : View → ArgumentPackage Claim
  | .conversion => conversionCase
  | .pentecostal => pentecostalCase
  | .holiness => holinessCase
  | .sacramental => sacramentalCase

/-- The dispute over Spirit baptism: every view can be held without
contradiction, delivers its conclusion, and has its steps rated. -/
declare_dispute spiritBaptismDispute := viewNode using spiritBaptismDefs
  /-- **Who defeats whom**, all 16 pairs: four standoffs, and nothing else. The
  conversion view and each subsequence view defeat each other — "no second to
  seek" against "a second to seek" — and the Pentecostal view also denies the
  conversion reading of 1 Corinthians 12:13. The sacramental view and each
  subsequence view defeat each other on the same point. Every cell is checked by
  the kernel. -/
  defeats
    [ (.conversion, .pentecostal), (.conversion, .holiness)
    , (.pentecostal, .conversion), (.pentecostal, .sacramental)
    , (.holiness, .conversion), (.holiness, .sacramental)
    , (.sacramental, .pentecostal), (.sacramental, .holiness) ]
  /-- **Nothing supports anything**, in all 16 pairs. Every cell is checked by
  the kernel. -/
  supports []
  /-- Each view's case is part of its own and of no other's. Every cell is
  checked by the kernel. -/
  partOf []
  /-- The dispute over Spirit baptism drawn: who defeats whom. -/
  map spiritBaptismMap

/-- **The conversion and sacramental views can be held together**: one reading
satisfies both — every believer baptized in the Spirit at conversion, the Spirit
given in the sacraments, and no second baptism to seek.

It does not show that the two agree. They differ over what the rite does, which
this dispute does not weigh, and the result says only that nothing encoded here
makes them contradict each other. -/
theorem conversion_stands_with_the_sacraments :
    spiritBaptismDispute.StandTogether [.conversion, .sacramental] := by
  satisfied_by conversionReading [Dispute.StandTogether, spiritBaptismDefs]

/-- **The two subsequence views can be held together**: a second baptism to
seek, whether read as empowerment or as the second work of grace. Whether it is
the same second experience, the encoding does not say. -/
theorem the_subsequence_views_stand_together :
    spiritBaptismDispute.StandTogether [.pentecostal, .holiness] := by
  satisfied_by pentecostalReading [Dispute.StandTogether, spiritBaptismDefs]

/-! ### What the dispute decides -/

/-- Why nothing is forced: every view has a defeater. The conversion view has the
Pentecostal, the Pentecostal and holiness views have the conversion view, and the
sacramental view has the Pentecostal. -/
declare_verdict spiritBaptismSettlesNothing for spiritBaptismDispute :
    .nothingGrounded
      [ (.conversion, .pentecostal), (.pentecostal, .conversion)
      , (.holiness, .conversion), (.sacramental, .pentecostal) ]
  /-- **Nothing is forced.** Every view is in a standoff the dispute cannot
  resolve, and every weakest link is `disputed`, so no rating breaks a tie.

  It does not show that the question is idle. Each view can be defended, and
  what the dispute cannot do is choose between readings rated alike. -/
  proves @[headline] spirit_baptism_forces_nothing

#print axioms spirit_baptism_forces_nothing

/-- Why the conversion view can be defended: it stands with the sacramental view,
and answers both subsequence views, itself. -/
declare_verdict conversionStandsWithTheSacraments for spiritBaptismDispute :
    .credulous .conversion [.conversion, .sacramental]
  /-- **The conversion view can be defended**, with the sacramental view: some
  maximal defensible position — one no other party can join without losing that —
  holds both. -/
  proves @[headline] conversion_defensible

#print axioms conversion_defensible

/-- Why the conversion view is not forced: a defensible position holds the
Pentecostal view, and it defeats the conversion view. -/
declare_verdict conversionAnsweredByPentecost for spiritBaptismDispute :
    .notSkeptical .conversion .pentecostal [.pentecostal, .holiness]
  /-- **Nor is it forced.** A maximal defensible position holds the Pentecostal
  and holiness views, and cannot hold the conversion view with them. -/
  proves @[headline] conversion_not_forced

#print axioms conversion_not_forced

/-- Why the Pentecostal view can be defended: it stands with the holiness view,
and answers both the conversion and sacramental views itself. -/
declare_verdict pentecostalStandsWithHoliness for spiritBaptismDispute :
    .credulous .pentecostal [.pentecostal, .holiness]
  /-- **The Pentecostal view can be defended**, with the holiness view. -/
  proves @[headline] pentecostal_defensible

#print axioms pentecostal_defensible

/-- Why the Pentecostal view is not forced: a defensible position holds the
conversion view, and it defeats the Pentecostal view. -/
declare_verdict pentecostalAnsweredByConversion for spiritBaptismDispute :
    .notSkeptical .pentecostal .conversion [.conversion, .sacramental]
  /-- **Nor is it forced.** A maximal defensible position holds the conversion
  and sacramental views, and cannot hold the Pentecostal view with them. What
  would decide is argued, not weighed: what the Acts narratives are
  (`pentecostal_cannot_read_acts_as_transitions`). -/
  proves @[headline] pentecostal_not_forced

#print axioms pentecostal_not_forced

/-- Why the holiness view can be defended: it stands with the Pentecostal view,
which answers the conversion and sacramental views. -/
declare_verdict holinessStandsWithPentecost for spiritBaptismDispute :
    .credulous .holiness [.pentecostal, .holiness]
  /-- **The holiness view can be defended**, with the Pentecostal view. Not
  forced, for the same reason the Pentecostal view is not. -/
  proves @[headline] holiness_defensible

#print axioms holiness_defensible

/-- Why the sacramental view can be defended: it stands with the conversion view,
which answers both subsequence views. -/
declare_verdict sacramentalStandsWithConversion for spiritBaptismDispute :
    .credulous .sacramental [.conversion, .sacramental]
  /-- **The sacramental view can be defended**, with the conversion view. Not
  forced, for the same reason the conversion view is not. -/
  proves @[headline] sacramental_defensible

#print axioms sacramental_defensible

/-! ### What the Pentecostal view can read Acts as -/

/-- **The Pentecostal view cannot read Acts as transitions.** Its own premise is
that Luke's narratives are a pattern for believers today, and Stott's reading
says, in its own words, that they are "not a pattern"
(`TestimonyArguments.Meanings.SpiritBaptism.joins`). So what the view holds, read for
what its claims mean, denies the transitions reading outright.

So the Pentecostal view must read the Acts narratives as a pattern, because the
other reading is not open to it. It does not show that the pattern reading is
right. Read as a pattern, the narratives still meet the
variety of Acts (`whereTheVarietyMeetsThePattern`), at a step the Assemblies of
God contest.

Before the two readings were joined by meaning, this was a dilemma with two
horns, and the transitions horn broke only at Stott's step from transitions to
no norm. Joined, the horn is not there to break: no reader can hold the
Pentecostal view and read Acts as transitions. -/
@[headline]
theorem pentecostal_cannot_read_acts_as_transitions :
    Entails pentecostalCase.held (notP .actsEpisodesAreTransitions) := by
  establish [spiritBaptismDefs]

#print axioms pentecostal_cannot_read_acts_as_transitions

/-- **Stott's reading meets the Pentecostal view at its premise.** Read for what
its claims mean, Acts as transitions denies that the narratives are a pattern,
and that is one of the Pentecostal view's premises. Before the join it met the
view only at Stott's step, as a reason not to seek a second baptism; now it
contradicts what the view rests on. Whether that attack is a defeat is a
question of ratings, and this argument's dispute does not seat Stott's reading
as a party. -/
theorem stott_undermines_the_pattern :
    UnderminesOn transitionCase pentecostalCase (p .actsNarrativesAreNormative) := by
  refine ⟨by simp [pentecostalCase, spiritBaptismDefs], ?_⟩
  establish [spiritBaptismDefs]

end TestimonyArguments.SpiritBaptism
