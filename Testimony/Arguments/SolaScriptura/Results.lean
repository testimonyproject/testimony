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

end Testimony.Arguments.SolaScriptura
