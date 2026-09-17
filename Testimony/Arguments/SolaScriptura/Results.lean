import Testimony.Arguments.SolaScriptura.Packages
import Testimony.Logic.Tactic

/-!
# Arguments.SolaScriptura.Results — what does and does not follow

The results this module exists for are the two on the hinge. The seed asserted
in prose that the dispute reduces to `solaScripturaIsTaughtByScripture`; here
that claim is split into the two roles the premise actually plays, because they
come apart.
-/

namespace Testimony.Arguments.SolaScriptura

open Testimony Testimony.Logic

/-! ### The positions -/

/-- Given the Protestant premises, on either route, the conclusion follows. -/
@[headline]
theorem protestant_establishes : Establishes protestant := by
  establish [protestant, classicalLine, eliminativeLine, sharedGrounds,
    toSoleRule, eliminativeToSoleRule]

#print axioms protestant_establishes

/-- **Tradition 0 establishes it too.** Geisler rejects Mathison's claim that
tradition is hermeneutically necessary; he does not reject sola scriptura. The
position Mathison calls "solo scriptura" and judges unbiblical and unworkable
reaches the same conclusion by a different route, once it is stated by someone
who holds it rather than by its critic. -/
@[headline]
theorem tradition0_establishes : Establishes tradition0 := by
  establish [tradition0, tradition0Line, tradition0ToSoleRule]

#print axioms tradition0_establishes

/-- The Tridentine reading, written down: tradition is a coordinate source, so
scripture is not the sole rule. -/
def tridentineReading : Valuation Claim := fun a =>
  match a with
  | .scriptureIsSoleInfallibleRule => False
  | _ => True

/-- The two-source premises do not establish sola scriptura — they entail its
negation. -/
@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  refute_with tridentineReading [tridentine, tridentineLine, tridentineDeniesSoleRule]

#print axioms tridentine_not_establishes

/-- The post-Vatican I reading: the magisterium is the living interpreter, so
scripture is not the sole infallible rule. -/
def magisterialReading : Valuation Claim := fun a =>
  match a with
  | .scriptureIsSoleInfallibleRule => False
  | _ => True

/-- Tradition III likewise entails the negation — by a different premise from
Tradition II's, which is why the two are separate packages. -/
@[headline]
theorem vaticanI_not_establishes : ¬ Establishes vaticanI := by
  refute_with magisterialReading [vaticanI, vaticanLine, magisterialDeniesSoleRule]

#print axioms vaticanI_not_establishes

/-- The Orthodox reading: the mind of the Church interprets infallibly, with no
magisterium and no second source of revelation. -/
def orthodoxReading : Valuation Claim := fun a =>
  match a with
  | .scriptureIsSoleInfallibleRule => False
  | _ => True

/-- Orthodoxy also entails the negation, and on its own premise. The seed
encoding grounded a single "Catholic/Orthodox" line on magisterial
infallibility, which attributes to Orthodoxy a premise it does not hold. -/
@[headline]
theorem orthodox_not_establishes : ¬ Establishes orthodox := by
  refute_with orthodoxReading [orthodox, orthodoxLine, orthodoxDeniesSoleRule]

#print axioms orthodox_not_establishes

/-! ### The three objections, each valid on its own grounds -/

/-- The self-refutation objection is valid: granted that only scriptural
doctrine binds and that scripture does not teach sola scriptura, the position
fails by its own standard. -/
@[headline]
theorem selfRefutation_is_valid : Establishes selfRefutation := by
  establish [selfRefutation, selfRefutationLine, selfRefutationStep]

#print axioms selfRefutation_is_valid

/-- The canon objection is valid on its own grounds: if the canon is known
through the Church's reception and identifying it requires an infallible
authority, then an authority outside scripture is needed to identify
scripture. -/
@[headline]
theorem canonObjection_is_valid : Establishes canonObjection := by
  establish [canonObjection, canonObjectionLine, canonObjectionStep]

#print axioms canonObjection_is_valid

/-- The interpretive-authority regress is valid on its own grounds. It attacks
something the other two do not: not whether the doctrine is scriptural or
whether the canon can be identified, but whether the authority Tradition I
submits to is anything other than the one submitting. -/
@[headline]
theorem interpretiveRegress_is_valid : Establishes interpretiveRegress := by
  establish [interpretiveRegress, interpretiveRegressLine, interpretiveRegressStep]

#print axioms interpretiveRegress_is_valid

/-! ### The hinge, in its two roles

`solaScripturaIsTaughtByScripture` does two jobs, and they come apart. It is
not load-bearing for reaching the conclusion, because the eliminative line
reaches it without the hinge. It is load-bearing within the classical strand,
and — the result that matters — it is one of only two things that answer the
self-refutation objection. -/

/-- **The hinge is not load-bearing for the conclusion.** Strip it and the
eliminative line still delivers the sole rule. -/
@[headline]
theorem hinge_not_load_bearing_for_conclusion : Establishes protestantWithoutHinge := by
  establish [protestantWithoutHinge, protestant, Line.onGrounds, classicalLine,
    eliminativeLine, sharedGrounds, toSoleRule, eliminativeToSoleRule]

#print axioms hinge_not_load_bearing_for_conclusion

/-- The reading on which scripture does not teach the principle, and the sole
rule does not follow. -/
def hingeDeniedReading : Valuation Claim := fun a =>
  match a with
  | .solaScripturaIsTaughtByScripture => False
  | .scriptureIsSoleInfallibleRule => False
  | _ => True

/-- Within the classical strand taken alone the hinge is still load-bearing:
remove it and that strand yields nothing. -/
@[headline]
theorem hinge_is_load_bearing_within_classical_strand :
    ¬ Establishes classicalStrandWithoutHinge := by
  refute_with hingeDeniedReading [classicalStrandWithoutHinge, Line.onGrounds,
    classicalLine, toSoleRule]

#print axioms hinge_is_load_bearing_within_classical_strand

/-! ### The two answers to self-refutation

The objection's step is a conjunction, so there are two ways to deny it. The
seed encoded only the first. Neither answer is redundant with the other: each
removes a different ground, and the objection succeeds only if both are
refused. -/

/-- The reading on which scripture does teach the principle. -/
def scriptureTeachesItReading : Valuation Claim := fun _ => True

/-- **The classical answer blocks the objection.** Assert that scripture teaches
the principle and the objection no longer delivers its denial. -/
@[headline]
theorem classical_answer_blocks_self_refutation :
    ¬ Establishes selfRefutationAnswered := by
  refute_with scriptureTeachesItReading [selfRefutationAnswered, selfRefutation,
    selfRefutationUnderClassicalAnswer, Line.onGrounds, selfRefutationLine,
    selfRefutationStep]

#print axioms classical_answer_blocks_self_refutation

/-- The final-arbiter reading: scripture adjudicates doctrine rather than
sourcing every binding claim, so the bindingness rule does not apply reflexively
to a claim about where doctrine comes from. -/
def finalArbiterReading : Valuation Claim := fun a =>
  match a with
  | .onlyScripturalDoctrineIsBinding => False
  | .solaScripturaIsTaughtByScripture => False
  | _ => True

/-- **And the final-arbiter answer blocks it too, without the hinge.** This is
the answer the seed did not encode. It concedes that scripture does not teach
the principle in the sense the objection requires, and denies instead that the
bindingness rule governs a claim of this kind.

So the objection is defeated on either route, and succeeds only against a
position that refuses both — which is what "the dispute reduces to the hinge"
was gesturing at, and is narrower than that phrase suggests. -/
@[headline]
theorem scoping_blocks_self_refutation : ¬ Establishes selfRefutationUnderScope := by
  refute_with finalArbiterReading [selfRefutationUnderScope, selfRefutation,
    selfRefutationUnderFinalArbiter, Line.onGrounds, selfRefutationLine,
    selfRefutationStep]

#print axioms scoping_blocks_self_refutation

/-! ### The parity replies, and what they are worth

Kruger on the canon and Mathison on interpretive authority make the same move:
concede the circularity, deny that it discriminates between the positions. Each
gets two results, because blocking an objection and establishing a conclusion
are different things — the lesson `compatibility_does_not_establish_criterion`
already records for a different argument. -/

/-- Kruger's reading: the canon's reception is conceded, and the demand for an
infallible identifying authority is refused, because the rival's own authority
is self-authenticating too. -/
def krugerParityReading : Valuation Claim := fun a =>
  match a with
  | .identifyingCanonRequiresInfallibleAuthority => False
  | _ => True

/-- **The parity reply blocks the canon objection.** -/
@[headline]
theorem parity_blocks_canon_objection : ¬ Establishes canonObjectionUnderParity := by
  refute_with krugerParityReading [canonObjectionUnderParity, canonObjection,
    canonUnderParity, Line.onGrounds, canonObjectionLine, canonObjectionStep]

#print axioms parity_blocks_canon_objection

/-- The reading on which the parity point is granted and the sole rule still
does not follow. -/
def parityEstablishesNothingReading : Valuation Claim := fun a =>
  match a with
  | .scriptureIsSoleInfallibleRule => False
  | _ => True

/-- **And blocking is all it does.** The same grounds, asked for the conclusion
rather than for the block, deliver nothing. The parity reply is purely
defensive: it neutralises the objection without establishing the position. -/
@[headline]
theorem canon_parity_does_not_establish_sole_rule :
    ¬ Establishes canonParityReachingForSoleRule := by
  refute_with parityEstablishesNothingReading [canonParityReachingForSoleRule,
    canonObjection, canonUnderParity, Line.onGrounds, canonObjectionLine,
    canonObjectionStep]

#print axioms canon_parity_does_not_establish_sole_rule

/-- Mathison's reading: ministerial authority is retained, and the claim that
the individual keeps ultimate interpretive authority is refused, because
choosing Rome is itself an act of private judgement. -/
def mathisonParityReading : Valuation Claim := fun a =>
  match a with
  | .individualRetainsUltimateInterpretiveAuthority => False
  | _ => True

/-- **The parity reply blocks the interpretive-authority regress.** -/
@[headline]
theorem parity_blocks_interpretive_regress :
    ¬ Establishes interpretiveRegressUnderParity := by
  refute_with mathisonParityReading [interpretiveRegressUnderParity,
    interpretiveRegress, regressUnderParity, Line.onGrounds,
    interpretiveRegressLine, interpretiveRegressStep]

#print axioms parity_blocks_interpretive_regress

/-- The reading on which the parity point is granted and the distinction still
does not follow. -/
def distinctionUnestablishedReading : Valuation Claim := fun a =>
  match a with
  | .traditionIDiffersInPrincipleFromTradition0 => False
  | _ => True

/-- **And blocking is all this one does either.** That choosing an authority is
private judgement defeats the charge that Tradition I collapses into Tradition
0; it does not show that Tradition I differs from it in principle. The same
shape, twice, against two different objections. -/
@[headline]
theorem regress_parity_does_not_establish_difference :
    ¬ Establishes regressParityReachingForDifference := by
  refute_with distinctionUnestablishedReading [regressParityReachingForDifference,
    interpretiveRegress, regressUnderParity, Line.onGrounds,
    interpretiveRegressLine, interpretiveRegressStep]

#print axioms regress_parity_does_not_establish_difference

/-! ### Geisler's circle -/

/-- The reading on which neither the consensus nor the clarity it is said to
rest on obtains. -/
def neitherEndReading : Valuation Claim := fun a =>
  match a with
  | .creedalConsensusIsHermeneuticallyNecessary => False
  | .scriptureIsPerspicuous => False
  | _ => True

/-- **Geisler's circularity charge against Tradition I, shown rather than
alleged.** The creedal consensus is said to rest on scripture's clarity, and
scripture's clear sense is said to be unobtainable without that consensus. Put
both legs in place and the consensus does not follow, because a cycle of
implications is satisfied outright by a valuation on which every node in it is
false.

Like every result here this is conditional: deny either leg and the circle is
not there. What it settles is that the charge is structural rather than
rhetorical — and it is made from inside Protestantism, against the position
this module encodes as the Protestant one. -/
@[headline]
theorem circle_grounds_neither_consensus : ¬ Establishes traditionICircle := by
  refute_with neitherEndReading [traditionICircle, consensusRestsOnPerspicuity,
    perspicuityRestsOnConsensus]

#print axioms circle_grounds_neither_consensus

/-- **And the other end is no better off.** The same two legs, asked for the
perspicuity instead of the consensus, fail in the same way and for the same
reason. -/
@[headline]
theorem circle_grounds_neither_perspicuity :
    ¬ Establishes traditionICircleForPerspicuity := by
  refute_with neitherEndReading [traditionICircleForPerspicuity, traditionICircle,
    consensusRestsOnPerspicuity, perspicuityRestsOnConsensus]

#print axioms circle_grounds_neither_perspicuity

/-! ### Geisler's charge, and the three replies

The cycle results above are a formal fact about a cycle of implications. These
are about the charge as an argument: whether it goes through, and what answers
it. Two replies deny its second leg; Barrett's concedes the circle and denies
that circularity is peculiar to this position. -/

/-- Geisler's charge is valid on its own grounds: grant that the consensus
rests on scripture's clarity and that scripture's clear sense requires the
consensus, and the reasoning is circular. -/
@[headline]
theorem geislerCircle_is_valid : Establishes geislerCircle := by
  establish [geislerCircle, geislerCircleLine, circleStep]

#print axioms geislerCircle_is_valid

/-- The reading on which the consensus is a product of scripture rather than a
precondition of reading it. -/
def accountabilityReading : Valuation Claim := fun a =>
  match a with
  | .perspicuityRequiresCreedalConsensus => False
  | .traditionIReasoningIsCircular => False
  | _ => True

/-- **Allen and Swain's reply blocks the charge.** If the creedal consensus is
established by and accountable to scripture, it is what reading scripture
produces rather than what reading scripture presupposes, and the second leg
fails.

What this costs is worth stating: Geisler quotes Mathison saying that it is "to
the Church that we must turn for the true interpretation of the Scripture" and
that without the early rule of faith "hermeneutical chaos and anarchy" reigns.
If that is Tradition I, the reply defends a weaker position than the one
charged. -/
@[headline]
theorem accountability_blocks_the_circle :
    ¬ Establishes geislerCircleUnderAccountability := by
  refute_with accountabilityReading [geislerCircleUnderAccountability, geislerCircle,
    circleUnderAccountability, Line.onGrounds, geislerCircleLine, circleStep]

#print axioms accountability_blocks_the_circle

/-- The reading on which scripture bounds the interpretive office, and
perspicuity is claimed only for salvation essentials. -/
def scripturallyBoundedOfficeReading : Valuation Claim := fun a =>
  match a with
  | .perspicuityRequiresCreedalConsensus => False
  | .traditionIReasoningIsCircular => False
  | _ => True

/-- **The scriptural-bounding reply blocks the charge too, and on scriptural
rather than confessional grounds.**

**What is novel here.** No source was found advancing these texts as an answer
to the circularity charge; the passages are cited and the use is assembled in
this library. Acts 20:32 commends the Ephesian elders to "the word of his
grace" rather than to their own office; Titus 1:9 constitutes the office by
holding to "the trustworthy word as taught"; 1 Peter 5:2–3 forbids domineering.
If scripture bounds the interpretive office, the consensus's own warrant is
read off scripture, so it cannot be a precondition of reading scripture — and
Westminster I.7 restricts the perspicuity claim to what is necessary for
salvation, which is not the set of boundaries the creeds fix.

**What would settle whether it is really new.** Mark Thompson's *A Clear and
Present Word* treats the church-as-interpreter objection at length and was not
available here; Vanhoozer's *Biblical Authority after Babel* covers the same
ground. Either may already make this argument, in which case this result should
be recited to them and the tag dropped.

**What it deliberately does not claim.** That scripture *confers* the office.
Conferral invites the recognition/conferral distinction Mathison presses
against Rome over the canon, and boundedness is all the reply needs. It also
does not escape the regress: a critic may say the texts are read this way
because of a tradition. It moves the dispute to far less contested ground; it
does not leave it. -/
@[headline, proposed]
theorem scripturalBounding_blocks_the_circle :
    ¬ Establishes geislerCircleUnderScripturalBounding := by
  refute_with scripturallyBoundedOfficeReading [geislerCircleUnderScripturalBounding,
    geislerCircle, circleUnderScripturalBounding, Line.onGrounds, geislerCircleLine,
    circleStep]

#print axioms scripturalBounding_blocks_the_circle

/-- The reading on which the circularity is granted and is universal. -/
def universalCircularityReading : Valuation Claim := fun a =>
  match a with
  | .circularityDefeatsTraditionI => False
  | _ => True

/-- **Barrett's parity reply blocks the defeat.** Concede the circle; deny that
it is a defect peculiar to this position, since any appeal to an ultimate
authority is circular.

The sixth instance of one move. Kruger on the canon, Mathison on interpretive
authority, Athanasius on ὁμοούσιος, Whitaker on unwritten tradition, Geisler
himself on who may interpret the Old Testament, and now Barrett on perspicuity
— against Geisler, who deploys it himself elsewhere. -/
@[headline]
theorem parity_blocks_the_circularity_defeat :
    ¬ Establishes circleDefeatUnderParity := by
  refute_with universalCircularityReading [circleDefeatUnderParity, circleDefeats,
    defeatUnderParity, Line.onGrounds, circleDefeatsLine, circularityDefeats]

#print axioms parity_blocks_the_circularity_defeat

/-- The reading on which the circle is conceded outright. -/
def circularityConcededReading : Valuation Claim := fun _ => True

/-- **And blocking is all it does, again.** The parity reply cannot clear the
charge, because it grants it: what it denies is that the charge is damaging,
not that it is true. A position defended only by this reply is circular and
keeping company.

Third time the pairing appears in this module, which is the point — it is a
property of the move, not of the objection it answers. -/
@[headline]
theorem circle_parity_does_not_clear_the_charge :
    ¬ Establishes circleParityReachingForVindication := by
  refute_with circularityConcededReading [circleParityReachingForVindication,
    circleDefeats, defeatUnderParity, Line.onGrounds, circleDefeatsLine,
    circularityDefeats]

#print axioms circle_parity_does_not_clear_the_charge

/-! ### Satisfiability

`Entails` quantifies over the valuations satisfying the premises, so a premise
set with no model entails everything — including the negation of what its own
author intended. A package built from contradictory premises would `Establishes`
its conclusion, the proof would close, and every gate would pass.

Only packages carrying a positive `Establishes` result need checking here. A
package with a `¬ Establishes` result is satisfiable already: its countermodel
is a valuation on which every premise holds.

These are not tagged `@[headline]`. They are claims about the health of the
encoding, not about the dispute. -/

/-- The reading on which every claim in this argument holds at once. Not a
position anyone occupies — it is the witness that the packages built only from
positive grounds are coherent. -/
def everythingHoldsReading : Valuation Claim := fun _ => True

/-- The Protestant package has a model, so `protestant_establishes` is not
vacuous. -/
theorem protestant_is_satisfiable : Satisfiable protestant.premises := by
  satisfied_by everythingHoldsReading [protestant, classicalLine, eliminativeLine,
    sharedGrounds, toSoleRule, eliminativeToSoleRule]

/-- Tradition 0's package has a model. -/
theorem tradition0_is_satisfiable : Satisfiable tradition0.premises := by
  satisfied_by everythingHoldsReading [tradition0, tradition0Line, tradition0ToSoleRule]

/-- The Protestant package minus the hinge has a model, so
`hinge_not_load_bearing_for_conclusion` is not vacuous either — which matters,
since a load-bearing result that held only because its premises were
contradictory would be precisely backwards. -/
theorem protestantWithoutHinge_is_satisfiable :
    Satisfiable protestantWithoutHinge.premises := by
  satisfied_by everythingHoldsReading [protestantWithoutHinge, protestant,
    Line.onGrounds, classicalLine, eliminativeLine, sharedGrounds, toSoleRule,
    eliminativeToSoleRule]

/-- Geisler's charge has a model. -/
theorem geislerCircle_is_satisfiable : Satisfiable geislerCircle.premises := by
  satisfied_by everythingHoldsReading [geislerCircle, geislerCircleLine, circleStep]

/-- The world the self-refutation objection describes: scripture does not teach
the principle, so the sole rule does not bind. -/
def selfRefutationOwnReading : Valuation Claim := fun a =>
  match a with
  | .solaScripturaIsTaughtByScripture => False
  | .scriptureIsSoleInfallibleRule => False
  | _ => True

/-- The self-refutation objection has a model. -/
theorem selfRefutation_is_satisfiable : Satisfiable selfRefutation.premises := by
  satisfied_by selfRefutationOwnReading [selfRefutation, selfRefutationLine,
    selfRefutationStep]

/-- The world the canon objection describes: the canon comes through the
Church, so scripture is not the sole infallible rule. -/
def canonObjectionOwnReading : Valuation Claim := fun a =>
  match a with
  | .scriptureIsSoleInfallibleRule => False
  | _ => True

/-- The canon objection has a model. -/
theorem canonObjection_is_satisfiable : Satisfiable canonObjection.premises := by
  satisfied_by canonObjectionOwnReading [canonObjection, canonObjectionLine,
    canonObjectionStep]

/-- The world the regress describes: sola scriptura does not differ in
principle from solo scriptura. -/
def interpretiveRegressOwnReading : Valuation Claim := fun a =>
  match a with
  | .traditionIDiffersInPrincipleFromTradition0 => False
  | _ => True

/-- The interpretive-authority regress has a model. -/
theorem interpretiveRegress_is_satisfiable :
    Satisfiable interpretiveRegress.premises := by
  satisfied_by interpretiveRegressOwnReading [interpretiveRegress,
    interpretiveRegressLine, interpretiveRegressStep]

end Testimony.Arguments.SolaScriptura
