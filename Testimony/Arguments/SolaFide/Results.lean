import Testimony.Arguments.SolaFide.Packages
import Testimony.Logic.Tactic

/-!
# Arguments.SolaFide.Results — what does and does not follow

Entailments are established with `establish`; refutations name a countermodel —
the rival's own reading, written down as a valuation — and use `refute_with`.

`lexical_premises_jointly_load_bearing` is the result the two-strand encoding
exists to make possible.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Results

Entailments are established with `tauto`; refutations name a countermodel — the
rival's own reading, written down as a valuation. -/

/-- Given the Reformed premises, the conclusion follows. -/
@[headline]
theorem reformed_establishes : Establishes reformed := by
  establish [reformed, paulineLine, dominicalLine, jamesLine, sharedGrounds,
    prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
    jamesHarmonisation, toSalvation]

#print axioms reformed_establishes

/-- **The New Perspective establishes it too.** Dunn and Wright reject the
traditional reading of ἔργα νόμου; they do not reject justification by faith.
Once Jesus' words at Luke 7:50 are in view, denying the Pauline lexical premise
no longer blocks the conclusion.

Winning the ἔργα νόμου argument outright is therefore not a defeat of sola
fide, and this library says so in a form either side can check. -/
@[headline]
theorem newPerspective_establishes : Establishes newPerspective := by
  establish [newPerspective, reformed, Line.onGrounds, paulineLine, dominicalLine,
    jamesLine, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, jamesHarmonisation, toSalvation]

#print axioms newPerspective_establishes

/-- The Tridentine reading, as a valuation: works merit an increase of
justification, so salvation is not by faith apart from works. -/
def tridentineReading : Valuation Claim := fun a =>
  match a with
  | .salvationByGraceThroughFaithNotWorks => False
  | _ => True

/-- The Tridentine premises do not establish the conclusion — they entail its
negation. -/
@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  refute_with tridentineReading [tridentine, reformed]

#print axioms tridentine_not_establishes

/-- The Pauline lexical premise is **not** load-bearing on its own: strip it and
the dominical strand still carries the argument. -/
@[headline]
theorem worksOfLaw_not_load_bearing : Establishes reformedWithoutWorksOfLaw := by
  establish [reformedWithoutWorksOfLaw, reformed, Line.onGrounds, paulineLine,
    dominicalLine, jamesLine, sharedGrounds, prooftexts, closingSteps,
    paulineToFaithAlone, dominicalToFaithAlone, jamesHarmonisation, toSalvation]

#print axioms worksOfLaw_not_load_bearing

/-- Nor is the dominical lexical premise: strip it and the Pauline strand still
carries the argument. -/
@[headline]
theorem sozo_not_load_bearing : Establishes reformedWithoutSozo := by
  establish [reformedWithoutSozo, reformed, Line.onGrounds, paulineLine,
    dominicalLine, jamesLine, sharedGrounds, prooftexts, closingSteps,
    paulineToFaithAlone, dominicalToFaithAlone, jamesHarmonisation, toSalvation]

#print axioms sozo_not_load_bearing

/-- A reading on which neither lexical premise holds: Paul's phrase is about
boundary markers, and Jesus' σέσωκέν σε is about healing. -/
def neitherLexicalReading : Valuation Claim := fun a =>
  match a with
  | .worksOfLawMeansWorksGenerally => False
  | .sozoIsSoteriological => False
  | .justificationByFaithAlone => False
  | .salvationByGraceThroughFaithNotWorks => False
  | _ => True

/-- **The result worth having.** Neither lexical premise carries the argument
alone, but their *disjunction* does: remove both and sola fide no longer
follows, with everything else retained.

So the Reformation's material principle, as encoded here, does not hang on the
sense of Paul's ἔργα νόμου. It hangs on that *or* on the sense of Jesus'
σέσωκέν σε — and an opponent must defeat both. -/
@[headline]
theorem lexical_premises_jointly_load_bearing :
    ¬ Establishes reformedWithoutEitherLexicalPremise := by
  refute_with neitherLexicalReading [reformedWithoutEitherLexicalPremise, reformed,
    Line.onGrounds, paulineLine, dominicalLine, jamesLine, sharedGrounds, prooftexts,
    closingSteps, paulineToFaithAlone, dominicalToFaithAlone, jamesHarmonisation,
    toSalvation]

#print axioms lexical_premises_jointly_load_bearing

/-- A reading on which James 2:24 stands unharmonised against Paul. -/
def jamesUnharmonisedReading : Valuation Claim := fun a =>
  match a with
  | .james2_24Compatible => False
  | .salvationByGraceThroughFaithNotWorks => False
  | _ => True

/-- The argument genuinely depends on answering James. Remove the two premises
that harmonise James 2:24 with Paul and sola fide no longer follows, however
much of the rest is retained.

An argument for sola fide that does not engage James 2:24 is not merely
impolite; it is invalid. -/
@[headline]
theorem james_harmonisation_is_load_bearing :
    ¬ Establishes reformedWithoutJamesHarmonisation := by
  refute_with jamesUnharmonisedReading [reformedWithoutJamesHarmonisation, reformed,
    paulineLine, dominicalLine, sharedGroundsWithoutJames, prooftexts,
    paulineToFaithAlone, dominicalToFaithAlone, toSalvation]

#print axioms james_harmonisation_is_load_bearing

/-! ### Satisfiability

`Entails` is vacuously true over a premise set with no model, so a package
built from contradictory premises would establish its conclusion and every gate
would pass. Only packages carrying a positive `Establishes` result need
checking: one with a `¬ Establishes` result is satisfiable already, because its
countermodel satisfies every premise.

Not tagged `@[headline]` — these are claims about the health of the encoding
rather than about justification. -/

/-- The reading on which every claim in this argument holds at once: the
witness that the packages built from positive grounds are coherent. -/
def everythingHoldsReading : Valuation Claim := fun _ => True

/-- The Reformed package has a model, so `reformed_establishes` is not
vacuous. -/
theorem reformed_is_satisfiable : Satisfiable reformed.premises := by
  satisfied_by everythingHoldsReading [reformed, paulineLine, dominicalLine, jamesLine,
    sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
    dominicalToFaithAlone, jamesHarmonisation, toSalvation]

/-- The New Perspective's own world: Paul's ἔργα νόμου denotes the covenant
boundary markers rather than works in general, and justification is by faith
regardless. The all-holds reading cannot serve here — this package *denies* a
premise, which is the whole point of it. -/
def newPerspectiveOwnReading : Valuation Claim := fun a =>
  match a with
  | .worksOfLawMeansWorksGenerally => False
  | _ => True

/-- The New Perspective package has a model. -/
theorem newPerspective_is_satisfiable : Satisfiable newPerspective.premises := by
  satisfied_by newPerspectiveOwnReading [newPerspective, reformed, Line.onGrounds,
    paulineLine, dominicalLine, jamesLine, sharedGrounds, prooftexts, closingSteps,
    paulineToFaithAlone, dominicalToFaithAlone, jamesHarmonisation, toSalvation]

/-- The Reformed package minus the Pauline lexical premise has a model, so
`worksOfLaw_not_load_bearing` is not vacuous. A load-bearing result that held
only because its premises could not all be true would be exactly backwards. -/
theorem reformedWithoutWorksOfLaw_is_satisfiable :
    Satisfiable reformedWithoutWorksOfLaw.premises := by
  satisfied_by everythingHoldsReading [reformedWithoutWorksOfLaw, reformed,
    Line.onGrounds, paulineLine, dominicalLine, jamesLine, sharedGrounds, prooftexts,
    closingSteps, paulineToFaithAlone, dominicalToFaithAlone, jamesHarmonisation,
    toSalvation]

/-- And the same minus the dominical lexical premise. -/
theorem reformedWithoutSozo_is_satisfiable :
    Satisfiable reformedWithoutSozo.premises := by
  satisfied_by everythingHoldsReading [reformedWithoutSozo, reformed, Line.onGrounds,
    paulineLine, dominicalLine, jamesLine, sharedGrounds, prooftexts, closingSteps,
    paulineToFaithAlone, dominicalToFaithAlone, jamesHarmonisation, toSalvation]

end Testimony.Arguments.SolaFide
