import Testimony.Arguments.BornOfAVirgin.Packages
import Testimony.Logic.Tactic

/-!
# Arguments.BornOfAVirgin.Results — what does and does not follow

Every result about the strands, each tagged `@[headline]` and each followed by
`#print axioms` so its trust base is visible in the source. The results about
Wegner's objection — its validity, its circle, and the replies to it, the
fathers' sign argument among them — are in `Results.Wegner`.

Entailments are established with `establish`; refutations name a countermodel
and use `refute_with`. A countermodel here is the rival's reading written down
as a valuation, which is why each one is a named definition with a docstring
saying what position it encodes rather than an anonymous function.

Read `hinges_jointly_load_bearing` first. It is the result the four-strand
encoding exists to make possible.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony Testimony.Bib Testimony.Logic
open Testimony.People

/-! ### Results -/

/-- Given the scriptural premises, the conclusion follows. -/
@[headline]
theorem christian_establishes : Establishes christian := by
  establish [bornOfAVirginDefs]

#print axioms christian_establishes

/-- The Roman Catholic package establishes it too, unsurprisingly: it is the
scriptural package with a further strand bolted on. -/
@[headline]
theorem catholic_establishes : Establishes catholic := by
  establish [bornOfAVirginDefs]

#print axioms catholic_establishes

/-- The magisterial route carries the conclusion on its own, for a reader who
grants the authority it claims. -/
@[headline]
theorem magisterialOnly_establishes : Establishes magisterialOnly := by
  establish [bornOfAVirginDefs]

#print axioms magisterialOnly_establishes

/-- The critical reading, written down: עַלְמָה means "young woman", Isaiah's
sign was given to Ahaz, Genesis 3:15 is an etiology, and Micah's silence about a
father is only silence. No virgin-birth criterion arises. -/
def criticalReading : Valuation Claim := fun a =>
  match a with
  | .almahMeansVirgin => False
  | .isaiahPredictsVirginBirth => False
  | .genesis3_15IsProtoevangelium => False
  | .seedOfTheWomanImpliesNoHumanFather => False
  | .maternalSilenceImpliesNoHumanFather => False
  | .messiahBornOfVirgin => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- The critical reading does not establish the conclusion. -/
@[headline]
theorem critical_not_establishes : ¬ Establishes critical := by
  refute_with criticalReading [bornOfAVirginDefs]

#print axioms critical_not_establishes

/-- The critical case for the denial does go through on its own terms. Stating
it as an argument rather than a bare assumption is what makes the next result
possible. -/
@[headline]
theorem criticalDenial_establishes : Establishes criticalDenial := by
  establish [bornOfAVirginDefs]

#print axioms criticalDenial_establishes

/-- Berry's reading, written down: the sign was given to Ahaz, how it was
fulfilled in his day is unclear, and so the near-term reading does not exclude
a further referent — leaving the predictive reading standing. -/
def berryReading : Valuation Claim := fun a =>
  match a with
  | .nearTermExcludesMessianicSense => False
  | _ => True

/-- **Berry's objection blocks the critical denial.** Grant that Isaiah 7:14
was a sign to Ahaz, and grant with Berry that how it was fulfilled in Ahaz's own
day is an open question, and the denial no longer follows.

This is the narrow thing the objection does, and it is worth being clear about
what it does not do. It does not establish the predictive reading, and it does
not touch the lexical dispute. It removes one route to the denial — the route
that runs through the near-term fulfilment — and leaves the argument where
`hinges_jointly_load_bearing` puts it. -/
@[headline]
theorem berry_blocks_critical_denial : ¬ Establishes criticalDenialUnderBerry := by
  refute_with berryReading [bornOfAVirginDefs]

#print axioms berry_blocks_critical_denial

/-- The parity reading, written down: a near-term Assyrian setting is simply not
the kind of reason that rules out messianic reference, since Isaiah 9 and 11 sit
on that same timeline and are read messianically anyway. -/
def parityReading : Valuation Claim := fun a =>
  match a with
  | .nearTermExcludesMessianicSense => False
  | _ => True

/-- **Postell's parity argument blocks the critical denial too**, and by a
different route from Berry's.

Berry's objection is evidential — we do not know how the sign was fulfilled in
Ahaz's day. Parity is structural — the near-term setting was never the right
kind of reason, because Isaiah 9:5–6 and 11:1–10 stand on the same Assyrian
timeline and are read messianically without embarrassment. An opponent who
answers Berry by settling the near-term referent has not touched this. -/
@[headline]
theorem parity_blocks_critical_denial : ¬ Establishes criticalDenialUnderParity := by
  refute_with parityReading [bornOfAVirginDefs]

#print axioms parity_blocks_critical_denial

/-- The Reformed objection, written down: papal teaching says what it says, and
saying it settles nothing, because Scripture is the supreme judge. -/
def reformedReading : Valuation Claim := fun a =>
  match a with
  | .magisteriumIsDoctrinallyAuthoritative => False
  | .messiahBornOfVirgin => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- **What the magisterial strand is worth to a reader who does not grant the
magisterium's authority: nothing.** Deny that premise and the route collapses
outright, however firmly the teaching itself is attested.

This is why `christian` excludes it. A reader who holds with Westminster I.x
that Scripture is the supreme judge of controversies loses the whole of
`magisterialOnly` and must get the criterion from the four scriptural strands
or not at all. -/
@[headline]
theorem magisterial_authority_is_load_bearing : ¬ Establishes magisterialDenied := by
  refute_with reformedReading [bornOfAVirginDefs]

#print axioms magisterial_authority_is_load_bearing

/-- **The lexical premise no longer carries the argument.** Strip `almah` and
the protoevangelium and Michean strands still deliver the criterion.

Before Genesis 3:15 and Micah 5:2–3 were encoded, this module proved the
opposite — and `almah_is_load_bearing_alone` below shows that the earlier
finding was right about the Isaianic strand taken by itself. What changed is
not the Isaianic evidence but the number of strands. -/
@[headline]
theorem almah_not_load_bearing : Establishes christianWithoutAlmah := by
  establish [bornOfAVirginDefs]

#print axioms almah_not_load_bearing

/-- A reading that grants everything in the Isaianic strand except the lexical
premise. -/
def withoutAlmahReading : Valuation Claim := fun a =>
  match a with
  | .almahMeansVirgin => False
  | .messiahBornOfVirgin => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- Within the Isaianic strand taken alone, the lexical premise is still
load-bearing: remove it and that strand yields nothing. The earlier
single-stranded encoding of this module is preserved here rather than deleted,
because it is what makes `almah_not_load_bearing` informative — the Isaianic
evidence did not get stronger, it got company. -/
@[headline]
theorem almah_is_load_bearing_alone : ¬ Establishes isaianicStrandWithoutAlmah := by
  refute_with withoutAlmahReading [bornOfAVirginDefs]

#print axioms almah_is_load_bearing_alone

/-- **Admissibility is not enough.** Berry's lexical point is defensive — the
semantic range of עַלְמָה does not *exclude* the sense "virgin" — and defensive
is all it is. Substitute it for `almahMeansVirgin` and the Isaianic strand
yields nothing, on the same reading that refutes the strand without any lexical
premise at all.

The gap between *may mean* and *does mean* is where this argument lives, and
Berry is useful against the critical denial without narrowing it. -/
@[headline]
theorem admissibility_is_not_enough : ¬ Establishes isaianicStrandOnAdmissibility := by
  refute_with withoutAlmahReading [bornOfAVirginDefs]

#print axioms admissibility_is_not_enough

/-! #### The referential strand -/

/-- **The referential argument goes through.** Granted only what both sides
grant about the word — that עַלְמָה denotes a young woman of marriageable age,
and that being a virgin does not exclude a woman from that denotation — and
granted that Mary was such a woman and conceived as a virgin, Matthew's claim
turns out not to have required the lexical sense at all.

Nothing here asserts that עַלְמָה *means* virgin. The argument is about
reference, not sense, and it is cheaper for exactly that reason. -/
@[headline]
theorem semantic_establishes : Establishes semantic := by
  establish [bornOfAVirginDefs]

#print axioms semantic_establishes

/-- The lexical objection, written down and granted its own premises. -/
@[headline]
theorem lexicalCritical_establishes : Establishes lexicalCritical := by
  establish [bornOfAVirginDefs]

#print axioms lexicalCritical_establishes

/-- The referential reading, written down: the versions differ about which term
to use and not about who is described, so the divergence settles nothing about
the sense, and Matthew's claim never needed the sense. -/
def compatibilityReading : Valuation Claim := fun a =>
  match a with
  | .versionalDivergenceRefutesVirginSense => False
  | .lexicalSenseRequiredForFulfilment => False
  | _ => True

/-- **The referential reply defeats the lexical objection.** Keep every
versional datum — the Targum's עוּלֵימְתָא, the Three's νεᾶνις, the Septuagint's
παρθένος, the Peshitta's ܒܬܘܠܬܐ, Qumran's confirmation of the Hebrew — add the
referential premises, and the objection no longer reaches its conclusion.

The tension in the versions is not evidence against the reading once virginity
is compatible with the word. It is evidence that four translators made four
defensible choices about how much of the referent's description to make
explicit. -/
@[headline]
theorem compatibility_defeats_lexical_objection :
    ¬ Establishes lexicalCriticalUnderCompatibility := by
  refute_with compatibilityReading [bornOfAVirginDefs]

#print axioms compatibility_defeats_lexical_objection

/-- A reading on which Mary fits Isaiah's description and no criterion arises
from it. -/
def compatibilityOnlyReading : Valuation Claim := fun a =>
  match a with
  | .lexicalSenseRequiredForFulfilment => False
  | .messiahBornOfVirgin => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- **What the referential argument costs.** It is purely defensive. It defeats
the objection without establishing the criterion: ask the same premises for
`jesusSatisfiesCriterion` and they do not deliver it, because nothing in them
says the Messiah *must* be born of a virgin — only that Mary may be described
as Isaiah describes.

This is the honest price of the move, and it is worth paying. The criterion has
to come from the Isaianic, protoevangelium or Michean strands; what the
referential argument buys is that losing the lexical dispute no longer costs
the fulfilment claim. Winning `almahMeansVirgin` outright was never necessary,
and this says so in a form either side can check. -/
@[headline]
theorem compatibility_does_not_establish_criterion :
    ¬ Establishes semanticReachingForCriterion := by
  refute_with compatibilityOnlyReading [bornOfAVirginDefs]

#print axioms compatibility_does_not_establish_criterion

/-- A reading on which none of the four interpretive hinges holds: *almah*
means "young woman", the matrilineal wording of Genesis 3:15 implies nothing
about a father, Micah's silence is only silence, and Isaiah's composition does
not govern the sense of 7:14. Every textual observation is granted. -/
def noHingeReading : Valuation Claim := fun a =>
  match a with
  | .almahMeansVirgin => False
  | .seedOfTheWomanImpliesNoHumanFather => False
  | .maternalSilenceImpliesNoHumanFather => False
  | .compositionGovernsMeaning => False
  | .messiahBornOfVirgin => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- **The result worth having.** No single hinge carries the argument, but the
four of them jointly do: remove all four and the criterion no longer follows,
with every textual and historical premise retained.

So the argument no longer hangs on the sense of עַלְמָה alone. It hangs on that
*or* on the matrilineal wording of Genesis 3:15 *or* on Micah's maternal
silence *or* on Postell's compositional reading — and an opponent must defeat
all four. That is a materially stronger position than the single-stranded
version, and a materially weaker one than four independent arguments would be:
three of the four hinges are `disputed` for good reason, and the module doc
says why. -/
@[headline]
theorem hinges_jointly_load_bearing : ¬ Establishes christianWithoutAnyHinge := by
  refute_with noHingeReading [bornOfAVirginDefs]

#print axioms hinges_jointly_load_bearing

/-- End to end: under the scriptural package, Jesus satisfies the virgin-birth
criterion. -/
@[headline]
theorem jesus_satisfies_virgin_birth : Satisfies jesus bornOfAVirgin :=
  ⟨{ α := Claim
   , pkg := christian
   , valid := christian_establishes
   , concludes := rfl }⟩

#print axioms jesus_satisfies_virgin_birth

/-! ### Satisfiability

`Entails` is vacuously true over a premise set with no model, so a package built
from contradictory premises would establish its conclusion with every gate
passing. Only packages carrying a positive `Establishes` result need checking:
one with a `¬ Establishes` result is satisfiable already, its countermodel being
a valuation on which every premise holds.

Several packages here *deny* a premise, so the all-holds reading will not serve
them — a model has to be the position's own world, which is the same discipline
the countermodels follow.

Not tagged `@[headline]`: these are claims about the health of the encoding. -/

/-- The reading on which every claim holds at once. -/
def everythingHoldsReading : Valuation Claim := fun _ => True

/-- The scriptural package has a model. -/
theorem christian_is_satisfiable : Satisfiable christian.premises := by
  satisfied_by everythingHoldsReading [bornOfAVirginDefs]

/-- The Roman Catholic package has a model. -/
theorem catholic_is_satisfiable : Satisfiable catholic.premises := by
  satisfied_by everythingHoldsReading [bornOfAVirginDefs]

/-- The magisterial route has a model. -/
theorem magisterialOnly_is_satisfiable : Satisfiable magisterialOnly.premises := by
  satisfied_by everythingHoldsReading [bornOfAVirginDefs]

/-- The scriptural package minus the lexical premise has a model, so
`almah_not_load_bearing` is not vacuous. -/
theorem christianWithoutAlmah_is_satisfiable :
    Satisfiable christianWithoutAlmah.premises := by
  satisfied_by everythingHoldsReading [bornOfAVirginDefs]

/-- The critical denial's own world: the sign was Ahaz's, so Isaiah 7:14 is not
a prediction of a virgin birth. -/
def criticalDenialOwnReading : Valuation Claim := fun a =>
  match a with
  | .isaiahPredictsVirginBirth => False
  | _ => True

/-- The critical denial has a model. -/
theorem criticalDenial_is_satisfiable : Satisfiable criticalDenial.premises := by
  satisfied_by criticalDenialOwnReading [bornOfAVirginDefs]

/-- The referential argument's own world: Mary answers Isaiah's description, so
the fulfilment claim never required the lexical sense. -/
def referentialOwnReading : Valuation Claim := fun a =>
  match a with
  | .lexicalSenseRequiredForFulfilment => False
  | _ => True

/-- The referential argument has a model. -/
theorem semantic_is_satisfiable : Satisfiable semantic.premises := by
  satisfied_by referentialOwnReading [bornOfAVirginDefs]

/-- The lexical objection's own world: the versions read the broad term, so
עַלְמָה does not denote virginity and the criterion is not met. -/
def lexicalObjectionOwnReading : Valuation Claim := fun a =>
  match a with
  | .almahMeansVirgin => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- The lexical objection has a model. -/
theorem lexicalCritical_is_satisfiable : Satisfiable lexicalCritical.premises := by
  satisfied_by lexicalObjectionOwnReading [bornOfAVirginDefs]

end Testimony.Arguments.BornOfAVirgin
