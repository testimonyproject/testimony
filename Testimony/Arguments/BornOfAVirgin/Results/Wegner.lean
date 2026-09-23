import Testimony.Arguments.BornOfAVirgin.Packages
import Testimony.Logic.Tactic

/-!
# Arguments.BornOfAVirgin.Results.Wegner — Wegner's objection, and the sign

What follows from Wegner's grammatical objection and from the replies to it:
that it is valid, where its weight rests, the circle in it, Postell's usage
parity, and the fathers' sign argument together with the near-term reply to
that. `Dispute.Wegner` then asks who prevails when these meet.

Every result is tagged `@[headline]` and followed by `#print axioms`, as in
`Results.lean`, and every countermodel is a named reading.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony Testimony.Bib Testimony.Logic

/-! ### Wegner's objection, and the circle in it -/

/-- **Wegner's objection is valid on its own terms.** Grant the
predicate-adjective parse, grant that the pregnancy it reports is an ordinary
one, and grant that the one clear Isaianic referent settles what the word
denotes, and the lexical conclusion follows.

Stated first, and at full strength, because the results below are about where
its weight rests and are worth nothing if the argument was weak to begin
with. -/
@[headline]
theorem wegner_establishes : Establishes wegnerLexical := by
  establish [wegnerLexical, wegnerLine, wegnerClosingSteps,
    harahYieldsPresentPregnancy, ordinaryPregnancyExcludesVirginity,
    referentYieldsLexicalConclusion]

#print axioms wegner_establishes

/-- Rydelnik's reading, written down: הָרָה is the predicate adjective Wegner
says it is, and what it announces is the miracle rather than an ordinary
conception — the virgin is pregnant, a sign as deep as Sheol. -/
def rydelnikReading : Valuation Claim := fun a =>
  match a with
  | .pregnancyAtTheSignIsOrdinary => False
  | .isaianicAlmahIsNotAVirgin => False
  | _ => True

/-- **The grammar is not what carries the objection.** Derive the ordinary
pregnancy the way Wegner derives it — from the near-term reading of the sign —
rather than granting it, and the argument no longer reaches its conclusion,
with the parse itself untouched.

So the load-bearing premise is not `harahIsPredicateAdjective`, which both
sides grant, but the reading of the sign that makes the pregnancy an ordinary
one. The next result follows that premise back to where it comes from. -/
@[headline]
theorem wegner_needs_ordinary_pregnancy : ¬ Establishes wegnerWithoutOrdinaryPregnancy := by
  refute_with rydelnikReading [wegnerWithoutOrdinaryPregnancy, wegnerLexical,
    wegnerWithoutTheOrdinaryPregnancy, wegnerLine, Line.onGrounds, wegnerClosingSteps,
    readingSuppliesOrdinaryPregnancy, harahYieldsPresentPregnancy,
    ordinaryPregnancyExcludesVirginity, referentYieldsLexicalConclusion]

#print axioms wegner_needs_ordinary_pregnancy

/-- Wegner's own conclusion granted: עַלְמָה does not denote a virgin, and
Isaiah 7:14 is not a prediction of a virgin birth. The same two legs of the
circle are satisfied on this reading as on the one below — the first because
its antecedent fails, the second because its consequent holds — which is what
makes the circle silent in *both* directions rather than merely unhelpful in
one.

Not a convenience: it is the position Wegner argues for, and the reading had to
be found rather than assumed. The all-true valuation that serves the same
purpose in `SolaScriptura` does not work here, because `wegnerCircle` carries
negated grounds. -/
def wegnerConclusionGrantedReading : Valuation Claim := fun a =>
  match a with
  | .almahMeansVirgin => False
  | .isaiahPredictsVirginBirth => False
  | _ => True

/-- The reading that exhibits the circle: the predictive reading of Isaiah 7:14
stands, עַלְמָה may denote a virgin, and the pregnancy the sign announces is not
an ordinary one. Every uncontested datum in Wegner's case is granted — the
parse, the near-term setting, the referent principle — and the two legs of the
circle are satisfied because each is an implication whose antecedent fails. -/
def circleUngroundedReading : Valuation Claim := fun a =>
  match a with
  | .pregnancyAtTheSignIsOrdinary => False
  | .isaianicAlmahIsNotAVirgin => False
  | _ => True

/-- **The circle, shown rather than alleged.** Put both legs in place — the
reading supplying the ordinary pregnancy, and the lexical conclusion turned
back against the reading — keep every uncontested datum, and the lexical
conclusion does not follow.

`circleUngroundedReading` is why: a cycle of implications is satisfied outright
by a valuation on which every node in it is false, because each leg then has a
false antecedent. Nothing enters such a loop from outside, so nothing comes out
of it. That is what it means for an argument to be circular rather than sound,
and it is checkable rather than merely assertable.

What this does **not** show is that Wegner is wrong. `wegner_establishes`
records that his argument is valid; what the circle costs is the claim that it
is an *independent* route to the lexical conclusion. And the result is
conditional on `readingSuppliesOrdinaryPregnancy`, which is Postell's reading
of Wegner's procedure, not Wegner's own account of it. He would say the
near-term reading rests on the historical setting and stands without the
lexical finding — in which case the premise is false and the circle is not
there. That premise is where a defender of Wegner should press. -/
@[headline]
theorem circle_leaves_the_lexical_conclusion_open :
    Independent wegnerCircle.premises (notP .almahMeansVirgin) := by
  leaves_open circleUngroundedReading wegnerConclusionGrantedReading
    [wegnerCircle, wegnerLexical, wegnerInTheCircle, wegnerLine, Line.onGrounds,
      wegnerClosingSteps, readingSuppliesOrdinaryPregnancy,
      lexicalConclusionTellsAgainstPrediction, harahYieldsPresentPregnancy,
      ordinaryPregnancyExcludesVirginity, referentYieldsLexicalConclusion]

#print axioms circle_leaves_the_lexical_conclusion_open

/-- **And the other end of it is no better off.** The same premises, asked for
the denial of the predictive reading instead of the lexical conclusion, fail in
the same way and on the same reading.

Both results are needed to make the point. A circle is not an argument that
fails to establish one of its nodes; it is one that establishes neither, having
no premise outside itself. -/
@[headline]
theorem circle_leaves_the_denial_open :
    Independent wegnerCircle.premises (notP .isaiahPredictsVirginBirth) := by
  leaves_open circleUngroundedReading wegnerConclusionGrantedReading
    [wegnerCircle, wegnerLexical, wegnerInTheCircle, wegnerLine, Line.onGrounds,
      wegnerClosingSteps, readingSuppliesOrdinaryPregnancy,
      lexicalConclusionTellsAgainstPrediction, harahYieldsPresentPregnancy,
      ordinaryPregnancyExcludesVirginity, referentYieldsLexicalConclusion]

#print axioms circle_leaves_the_denial_open

/-- Postell's usage reading, written down: the עַלְמָה of Isaiah 7:14 is granted
to be no virgin, and a single referent still does not settle what the word
denotes — because the other clear cases would settle it the other way. -/
def usageParityReading : Valuation Claim := fun a =>
  match a with
  | .oneReferentSettlesDenotation => False
  | _ => True

/-- **Postell's second reply, and it is independent of the first.** Concede the
parse, concede the ordinary pregnancy, concede that the woman of Isaiah 7:14 is
no virgin — and the lexical conclusion still does not follow, because the
principle that carries it there would carry the other clear cases the opposite
way.

This one survives the defence suggested above. An opponent who shows that the
near-term reading stands on its own, and so that there is no circle, has not
touched the usage parity: the method is still selective. Between them the two
replies leave the objection needing both a non-circular route to the ordinary
pregnancy and a reason to privilege this occurrence over Genesis 24:43. -/
@[headline]
theorem usage_parity_blocks_wegner : ¬ Establishes wegnerUnderUsageParity := by
  refute_with usageParityReading [wegnerUnderUsageParity, wegnerLexical,
    wegnerUnderParity, wegnerLine, Line.onGrounds, wegnerClosingSteps,
    usageParityBlocksReferentInference, harahYieldsPresentPregnancy,
    ordinaryPregnancyExcludesVirginity, referentYieldsLexicalConclusion]

#print axioms usage_parity_blocks_wegner

/-! ### The fathers' sign argument

Justin, Irenaeus and Origen answer the near-term reading with one argument. The
oracle promised a *sign*, one offered "in the depth or in the height" (7:11),
and an ordinary conception happens to every woman who is not barren. So the
pregnancy of 7:14 is not an ordinary one, and that is the ground of Wegner's
objection that the grammar does not supply.

The near-term reply is that a sign need not be a miracle. Isaiah's own children
are "signs and portents" (8:18), and this sign is dated by a child's infancy
(7:16), so its point may be its timing. -/

/-- The fathers' sign, with the word left to the lexicon: the pregnancy of 7:14
is no ordinary one, and עַלְמָה still does not denote a virgin. It is the
referential reading's world, in which Mary is an עַלְמָה without the word
carrying the sense. Every premise of Wegner's objection under the sign argument
holds in it, and so does his lexical conclusion. -/
def referentialSignReading : Valuation Claim := fun a =>
  match a with
  | .almahMeansVirgin => False
  | .pregnancyAtTheSignIsOrdinary => False
  | .isaianicAlmahIsNotAVirgin => False
  | _ => True

/-- **The sign argument blocks Wegner's objection, and settles nothing about
the word.** Keep the parse, the near-term setting and the referent principle,
put the fathers' two grounds where the ordinary pregnancy was, and the lexical
conclusion is independent of what is left. On Rydelnik's reading it fails: the
virgin is pregnant, a sign as deep as Sheol. On `referentialSignReading` it
holds.

So the argument answers the objection where `wegner_needs_ordinary_pregnancy`
says its weight rests, and does no more. It does not show that עַלְמָה denotes a
virgin, because it is not about the word at all. -/
@[headline]
theorem sign_leaves_the_lexical_conclusion_open :
    Independent wegnerUnderTheSign.premises (notP .almahMeansVirgin) := by
  leaves_open rydelnikReading referentialSignReading
    [wegnerUnderTheSign, wegnerLexical, wegnerUnderSign, wegnerLine, Line.onGrounds,
      wegnerClosingSteps, extraordinarySignExcludesOrdinaryPregnancy,
      harahYieldsPresentPregnancy, ordinaryPregnancyExcludesVirginity,
      referentYieldsLexicalConclusion]

#print axioms sign_leaves_the_lexical_conclusion_open

/-- The near-term reading of the sign, in Wegner's world: a sign need not be a
miracle, the pregnancy is an ordinary one, and עַלְמָה does not denote a
virgin. -/
def nearTermSignReading : Valuation Claim := fun a =>
  match a with
  | .signMustBeExtraordinary => False
  | .almahMeansVirgin => False
  | _ => True

/-- A sign that need not be a marvel, and is one all the same: the reader who
grants the near-term reply and still holds that the pregnancy of 7:14 is no
ordinary one, on other grounds than the sign. -/
def marvelAnywayReading : Valuation Claim := fun a =>
  match a with
  | .signMustBeExtraordinary => False
  | .pregnancyAtTheSignIsOrdinary => False
  | _ => True

/-- **The near-term reply blocks the sign argument back, and settles nothing
about the pregnancy.** Put the reply's grounds and step where the fathers' first
ground was, keep the second, and whether the pregnancy is an ordinary one is
independent of what is left: it is on `nearTermSignReading` and it is not on
`marvelAnywayReading`.

This is the reply's whole reach. It takes away the fathers' reason for denying
the ordinary pregnancy; it does not supply Wegner's reason for asserting it,
which still comes from the near-term reading of the sign. -/
@[headline]
theorem reply_leaves_the_pregnancy_open :
    Independent signArgumentUnderReply.premises (notP .pregnancyAtTheSignIsOrdinary) := by
  leaves_open nearTermSignReading marvelAnywayReading
    [signArgumentUnderReply, signArgument, signUnderReply, signLine, Line.onGrounds,
      Line.asPackage, extraordinarySignExcludesOrdinaryPregnancy,
      ordinarySignsAnswerTheDemand]

#print axioms reply_leaves_the_pregnancy_open

/-! ### Satisfiability

As in `Results.lean`: only a package with a positive `Establishes` result needs
a model named, and the sign argument and the reply are given theirs in
`Dispute.Wegner`, where they are established. -/

/-- Wegner's own world: the one clear Isaianic referent is not a virgin, so the
word does not denote virginity. -/
def wegnerOwnReading : Valuation Claim := fun a =>
  match a with
  | .almahMeansVirgin => False
  | _ => True

/-- Wegner's objection has a model. -/
theorem wegnerLexical_is_satisfiable : Satisfiable wegnerLexical.premises := by
  satisfied_by wegnerOwnReading [wegnerLexical, wegnerLine, wegnerClosingSteps,
    harahYieldsPresentPregnancy, ordinaryPregnancyExcludesVirginity,
    referentYieldsLexicalConclusion]

end Testimony.Arguments.BornOfAVirgin
