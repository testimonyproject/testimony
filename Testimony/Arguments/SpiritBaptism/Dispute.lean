import Testimony.Arguments.SpiritBaptism.Positions
import Testimony.Logic.Dispute
import Testimony.Logic.Horn
import Testimony.Logic.Solver
import Testimony.Logic.Verdict
import Testimony.Logic.Map

/-!
# Arguments.SpiritBaptism.Dispute — the four views weighed

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

## What the solver computed

Four standoffs, and nothing else. The conversion view stands off against both
subsequence views, and so does the sacramental view; the two subsequence views
do not attack each other, and neither do the conversion and sacramental views.
Nothing is forced (`spirit_baptism_forces_nothing`). Every view can be defended
(`conversion_defensible`, `pentecostal_defensible`, `holiness_defensible`,
`sacramental_defensible`), in one of two camps, and nothing joins them: the
conversion and sacramental views together, and the Pentecostal and holiness
views together.

That is where the question stands in the literature, and the page says so rather
than choosing. The conversion and sacramental views agree that there is no
second baptism in the Spirit to seek, and differ over the rite, which this
dispute does not weigh. What would decide between the two camps is argued, not
weighed: what Luke's narratives are (`whatTheActsNarrativesAre`), and whether
Paul's word at 1 Corinthians 12:13 and Luke's are the same baptism — a question
not yet encoded.
-/

namespace Testimony.Arguments.SpiritBaptism

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### Strength -/

/-- The conversion view's weakest link is `disputed`, at several places: its
reading of 1 Corinthians 12:13 and both of its steps. -/
theorem conversionCase_strength : conversionCase.strength = 0 := by decide
/-- The Pentecostal view's weakest link is `disputed`, at several places: its
reading of 1 Corinthians 12:13, of Acts 8 and 19, of Luke's Spirit baptism, of
the narratives as a pattern, and its step from the instrumental reading. -/
theorem pentecostalCase_strength : pentecostalCase.strength = 0 := by decide
/-- The holiness view's weakest link is `disputed`: its premise, and the step
Wesley contests. -/
theorem holinessCase_strength : holinessCase.strength = 0 := by decide
/-- The sacramental view's weakest link is `disputed`, at several places: its
readings of the rite and both of its steps. -/
theorem sacramentalCase_strength : sacramentalCase.strength = 0 := by decide

/-! ### The dispute -/

/-- The parties to the dispute over Spirit baptism. -/
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
@[spiritBaptismDefs]
def spiritBaptismDispute : Dispute Claim View where
  node := viewNode
  consistent
    | .conversion => conversionCase_is_satisfiable
    | .pentecostal => pentecostalCase_is_satisfiable
    | .holiness => holinessCase_is_satisfiable
    | .sacramental => sacramentalCase_is_satisfiable
  sound
    | .conversion => conversionCase_establishes
    | .pentecostal => pentecostalCase_establishes
    | .holiness => holinessCase_establishes
    | .sacramental => sacramentalCase_establishes
  rated i := by
    cases i <;> simp [spiritBaptismDefs]

/-- **The conversion and sacramental views can be held together**: one reading
satisfies both — every believer baptized in the Spirit at conversion, the Spirit
given in the sacraments, and no second baptism to seek.

What this does not claim: that the two agree. They differ over what the rite
does, which this dispute does not weigh; the result says only that nothing
encoded here makes them contradict each other. -/
theorem conversion_stands_with_the_sacraments :
    spiritBaptismDispute.StandTogether [.conversion, .sacramental] := by
  satisfied_by conversionReading [Dispute.StandTogether, spiritBaptismDefs]

/-- **The two subsequence views can be held together**: a second baptism to
seek, whether read as empowerment or as the second work of grace. Whether it is
the same second experience, the encoding does not say. -/
theorem the_subsequence_views_stand_together :
    spiritBaptismDispute.StandTogether [.pentecostal, .holiness] := by
  satisfied_by pentecostalReading [Dispute.StandTogether, spiritBaptismDefs]

/-- The defeats of the dispute, as a table. -/
def viewDefeats : View → View → Prop
  | .conversion, .pentecostal => True
  | .conversion, .holiness => True
  | .pentecostal, .conversion => True
  | .pentecostal, .sacramental => True
  | .holiness, .conversion => True
  | .holiness, .sacramental => True
  | .sacramental, .pentecostal => True
  | .sacramental, .holiness => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel viewDefeats := fun i j => by
  cases i <;> cases j <;> unfold viewDefeats <;> infer_instance

/-- Each view's weakest link: `disputed` for every one. -/
def viewStrength : View → ℕ := fun _ => 0

/-- Each view's weakest link, as its package computes it. -/
theorem viewNode_strength : ∀ i, (viewNode i).strength = viewStrength i
  | .conversion => conversionCase_strength
  | .pentecostal => pentecostalCase_strength
  | .holiness => holinessCase_strength
  | .sacramental => sacramentalCase_strength

/-- **Who defeats whom**, all 16 pairs: four standoffs, and nothing else. The
conversion view and each subsequence view defeat each other — "no second to
seek" against "a second to seek" — and the Pentecostal view also denies the
conversion reading of 1 Corinthians 12:13. The sacramental view and each
subsequence view defeat each other on the same point. Every cell is computed by
`Horn.defeats?` and checked by the kernel. -/
theorem spiritBaptismDispute_defeats :
    ∀ i j, spiritBaptismDispute.defeats i j ↔ viewDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (viewNode_strength i) (viewNode_strength j) ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute in the form the verdict solver computes with. -/
def spiritBaptismFinite : Solver.Finite spiritBaptismDispute.defeats where
  parties := [.conversion, .pentecostal, .holiness, .sacramental]
  complete i := by cases i <;> decide
  defeats i j := decide (viewDefeats i j)
  spec i j := by rw [spiritBaptismDispute_defeats]; simp

/-- **Nothing supports anything**, in all 16 pairs. Every cell is computed by
`supports?` and checked by the kernel. -/
theorem spiritBaptismDispute_supports : ∀ i j, ¬ spiritBaptismDispute.supports i j := by
  intro i j
  refine (supports_iff_of_supports? (P := False) ?_).not.mpr id
  cases i <;> cases j <;> decide +kernel

/-- Each view's case is part of its own and of no other's. Every cell is computed
by `partOf?` and checked by the kernel. -/
theorem spiritBaptismDispute_partOf : ∀ i j, spiritBaptismDispute.partOf i j ↔ i = j := by
  intro i j
  refine partOf_iff_of_partOf? ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute over Spirit baptism drawn: who defeats whom. -/
def spiritBaptismMap : ArgumentMap spiritBaptismDispute where
  finite := spiritBaptismFinite
  supports _ _ := false
  supports_spec i j := by simp [spiritBaptismDispute_supports i j]
  partOf i j := decide (i = j)
  partOf_spec i j := by rw [spiritBaptismDispute_partOf]; simp

/-! ### What the dispute decides -/

/-- Why nothing is forced: every view has a defeater. The conversion view has the
Pentecostal, the Pentecostal and holiness views have the conversion view, and the
sacramental view has the Pentecostal. -/
def spiritBaptismSettlesNothing : Verdict spiritBaptismDispute where
  finite := spiritBaptismFinite
  claim := .nothingGrounded
    [ (.conversion, .pentecostal), (.pentecostal, .conversion)
    , (.holiness, .conversion), (.sacramental, .pentecostal) ]
  checked := by decide +kernel

/-- **Nothing is forced.** Every view is in a standoff the dispute cannot resolve,
and every weakest link is `disputed`, so no rating breaks a tie.

What this does not claim: that the question is idle. Each view can be defended;
what the dispute cannot do is choose between readings rated alike. -/
@[headline]
theorem spirit_baptism_forces_nothing : grounded spiritBaptismDispute.defeats = ∅ :=
  spiritBaptismSettlesNothing.holds

#print axioms spirit_baptism_forces_nothing

/-- Why the conversion view can be defended: it stands with the sacramental view,
and answers both subsequence views, itself. -/
def conversionStandsWithTheSacraments : Verdict spiritBaptismDispute where
  finite := spiritBaptismFinite
  claim := .credulous .conversion [.conversion, .sacramental]
  checked := by decide +kernel

/-- **The conversion view can be defended**, with the sacramental view: some
maximal defensible position — one no other party can join without losing that —
holds both. -/
@[headline]
theorem conversion_defensible : CredulouslyAccepted spiritBaptismDispute.defeats .conversion :=
  conversionStandsWithTheSacraments.holds

#print axioms conversion_defensible

/-- Why the conversion view is not forced: a defensible position holds the
Pentecostal view, and it defeats the conversion view. -/
def conversionAnsweredByPentecost : Verdict spiritBaptismDispute where
  finite := spiritBaptismFinite
  claim := .notSkeptical .conversion .pentecostal [.pentecostal, .holiness]
  checked := by decide +kernel

/-- **Nor is it forced.** A maximal defensible position holds the Pentecostal and
holiness views, and cannot hold the conversion view with them. -/
@[headline]
theorem conversion_not_forced :
    ¬ SkepticallyAccepted spiritBaptismDispute.defeats .conversion :=
  conversionAnsweredByPentecost.holds

#print axioms conversion_not_forced

/-- Why the Pentecostal view can be defended: it stands with the holiness view,
and answers both the conversion and sacramental views itself. -/
def pentecostalStandsWithHoliness : Verdict spiritBaptismDispute where
  finite := spiritBaptismFinite
  claim := .credulous .pentecostal [.pentecostal, .holiness]
  checked := by decide +kernel

/-- **The Pentecostal view can be defended**, with the holiness view. -/
@[headline]
theorem pentecostal_defensible :
    CredulouslyAccepted spiritBaptismDispute.defeats .pentecostal :=
  pentecostalStandsWithHoliness.holds

#print axioms pentecostal_defensible

/-- Why the Pentecostal view is not forced: a defensible position holds the
conversion view, and it defeats the Pentecostal view. -/
def pentecostalAnsweredByConversion : Verdict spiritBaptismDispute where
  finite := spiritBaptismFinite
  claim := .notSkeptical .pentecostal .conversion [.conversion, .sacramental]
  checked := by decide +kernel

/-- **Nor is it forced.** A maximal defensible position holds the conversion and
sacramental views, and cannot hold the Pentecostal view with them. What would
decide is argued, not weighed: what the Acts narratives are
(`whatTheActsNarrativesAre`). -/
@[headline]
theorem pentecostal_not_forced :
    ¬ SkepticallyAccepted spiritBaptismDispute.defeats .pentecostal :=
  pentecostalAnsweredByConversion.holds

#print axioms pentecostal_not_forced

/-- Why the holiness view can be defended: it stands with the Pentecostal view,
which answers the conversion and sacramental views. -/
def holinessStandsWithPentecost : Verdict spiritBaptismDispute where
  finite := spiritBaptismFinite
  claim := .credulous .holiness [.pentecostal, .holiness]
  checked := by decide +kernel

/-- **The holiness view can be defended**, with the Pentecostal view. Not forced,
for the same reason the Pentecostal view is not. -/
@[headline]
theorem holiness_defensible : CredulouslyAccepted spiritBaptismDispute.defeats .holiness :=
  holinessStandsWithPentecost.holds

#print axioms holiness_defensible

/-- Why the sacramental view can be defended: it stands with the conversion view,
which answers both subsequence views. -/
def sacramentalStandsWithConversion : Verdict spiritBaptismDispute where
  finite := spiritBaptismFinite
  claim := .credulous .sacramental [.conversion, .sacramental]
  checked := by decide +kernel

/-- **The sacramental view can be defended**, with the conversion view. Not
forced, for the same reason the conversion view is not. -/
@[headline]
theorem sacramental_defensible :
    CredulouslyAccepted spiritBaptismDispute.defeats .sacramental :=
  sacramentalStandsWithConversion.holds

#print axioms sacramental_defensible

end Testimony.Arguments.SpiritBaptism
