import Testimony.Arguments.BornOfAVirgin.Results.Wegner
import Testimony.Logic.Dispute
import Testimony.Logic.Horn
import Testimony.Logic.Solver
import Testimony.Logic.Witness

/-!
# Arguments.BornOfAVirgin.Dispute.Wegner — who prevails over Wegner's objection

The sign argument attacks Wegner's objection, not the critical denial of the
predictive reading, so it belongs to a dispute of its own rather than to
`isaiahDispute`. Three positions meet here: Wegner's objection at full
strength, the fathers' sign argument against its ordinary pregnancy, and the
near-term reply that a sign need not be a miracle.

As in `Dispute.lean`, who defeats whom is proved, not stipulated:

- **The sign argument defeats Wegner.** It entails the negation of his premise
  that the pregnancy is an ordinary one, cited `disputed`.
- **Wegner defeats the sign argument back.** He holds that premise, and so
  concludes the opposite of the fathers; and each side's weakest link is
  `disputed`.
- **The reply defeats the sign argument**, by entailing the negation of its
  premise that the sign must be extraordinary, also cited `disputed`.
- **The sign argument defeats the reply back**, for the same reason Wegner
  defeats it: it holds the premise the reply denies, and the reply's inference
  is `disputed`.
- **Wegner and the reply do not attack each other.** They stand together in
  Wegner's own world, and Wegner is cited for both.

## What follows

**Nothing prevails.** Every party is defeated by someone, so the grounded
extension is empty (`nothing_prevails_over_wegner`). It can be resolved two
ways, and each is proved to be a preferred extension: the fathers alone
(`sign_is_one_resolution`), or Wegner with the near-term reply
(`wegner_is_the_other_resolution`). Each side is defensible and neither is
forced. Hear only Wegner and the fathers and it is the same
(`nothing_prevails_without_the_reply`): the reply is not what holds the fathers
back. Wegner's rebuttal is, because the fathers' weakest link is no stronger
than his.

## What the ratings decide

Every party's weakest link is `disputed`, so every attack succeeds and the
dispute ties. Two ratings would break the tie, and they break it in opposite
directions.

**The fathers' ground, `signMustBeExtraordinary`.** It is `disputed` because
Wegner and Rhodea contest it. Rated `plausible`, it would make the sign
argument stronger than both rivals, since its other ground is `consensus` and
its inference `plausible`. Wegner's rebuttal and the reply's undermining would
then both fail. Nothing would defeat the fathers, and the fathers would defeat
Wegner outright.

**The reply's inference.** It is `disputed` because Rydelnik grants both of its
grounds and denies what it concludes (`reply_rests_on_its_inference`). Rated
`plausible`, it would make the reply stronger than the fathers, whose rebuttal
would then fail. The reply would stand unanswered, and it would defend Wegner
against the only party that defeats him.

So the question this dispute cannot settle is the one the sources divide on:
whether the sign of 7:14 must be the kind of sign offered at 7:11. Neither the
age of the fathers' argument nor its modern restatement changes that rating,
for the reason `Dispute.lean` gives: an older witness does not make a contested
claim uncontested.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### The sign argument and the reply as positions -/

/-- The fathers' sign argument delivers its conclusion. -/
theorem signArgument_establishes : Establishes signArgument := by
  establish [bornOfAVirginDefs]

/-- The fathers' sign argument has a model: Rydelnik's reading, in which the
virgin is pregnant and the sign is as deep as Sheol. -/
theorem signArgument_is_satisfiable : Satisfiable signArgument.premises := by
  satisfied_by rydelnikReading [bornOfAVirginDefs]

/-- The near-term reply delivers its conclusion. -/
theorem ordinarySignReply_establishes : Establishes ordinarySignReply := by
  establish [bornOfAVirginDefs]

/-- The near-term reply has a model: the near-term reading of the sign. -/
theorem ordinarySignReply_is_satisfiable : Satisfiable ordinarySignReply.premises := by
  satisfied_by nearTermSignReading [bornOfAVirginDefs]

/-- **The reply rests on its inference, not on its observations.** On
Rydelnik's reading Isaiah's children are signs, 7:16 dates the deliverance by a
child's infancy, and the sign of 7:14 is extraordinary all the same. The two
grounds do not decide the question; the step does, and that is why it is rated
`disputed`. -/
@[headline]
theorem reply_rests_on_its_inference :
    ¬ Entails ordinarySignLine.grounds (notP .signMustBeExtraordinary) := by
  refute_with rydelnikReading [bornOfAVirginDefs]

#print axioms reply_rests_on_its_inference

/-! ### Strength -/

/-- Wegner is no stronger than his contested grounds: the ordinary pregnancy,
the near-term setting and the referent principle, each cited `disputed`. -/
theorem wegnerLexical_strength : wegnerLexical.strength = 0 := by decide

/-- The fathers' second ground is `consensus` and their inference `plausible`,
but their first ground is `disputed`, and they are no stronger than it. -/
theorem signArgument_strength : signArgument.strength = 0 := by decide

/-- The reply's grounds are `consensus`, but its inference is `disputed`. -/
theorem ordinarySignReply_strength : ordinarySignReply.strength = 0 := by decide

/-! ### The defeats -/

/-- **The sign argument defeats Wegner.** It entails the negation of his premise
that the pregnancy is an ordinary one, which, cited `disputed`, does not
outrank it. -/
theorem sign_defeats_wegner : Defeats signArgument wegnerLexical :=
  Horn.defeats_of_defeats? signArgument_strength wegnerLexical_strength (by decide +kernel)

/-- **Wegner defeats the sign argument back.** He holds the premise it denies,
so he rebuts it, and it is no stronger than he is. -/
theorem wegner_defeats_sign : Defeats wegnerLexical signArgument :=
  Horn.defeats_of_defeats? wegnerLexical_strength signArgument_strength (by decide +kernel)

/-- **The reply defeats the sign argument.** It entails the negation of the
fathers' premise that the sign must be extraordinary, cited `disputed`. -/
theorem reply_defeats_sign : Defeats ordinarySignReply signArgument :=
  Horn.defeats_of_defeats? ordinarySignReply_strength signArgument_strength (by decide +kernel)

/-- **The sign argument defeats the reply back.** It holds the premise the reply
denies, and the reply's inference is contested as that premise is. -/
theorem sign_defeats_reply : Defeats signArgument ordinarySignReply :=
  Horn.defeats_of_defeats? signArgument_strength ordinarySignReply_strength (by decide +kernel)

/-! ### The dispute -/

/-- The parties to the dispute over Wegner's objection. -/
inductive WegnerParty
  /-- Wegner's grammatical objection. -/
  | wegner
  /-- The fathers' sign argument against its ordinary pregnancy. -/
  | sign
  /-- The near-term reply that a sign need not be a miracle. -/
  | reply
deriving DecidableEq

/-- The package each party argues from. -/
@[bornOfAVirginDefs]
def wegnerPartyNode : WegnerParty → ArgumentPackage Claim
  | .wegner => wegnerLexical
  | .sign => signArgument
  | .reply => ordinarySignReply

/-- The dispute over Wegner's objection: every party's premises have a model,
every party establishes its conclusion, and every party's inferences are
rated. -/
@[bornOfAVirginDefs]
def wegnerDispute : Dispute Claim WegnerParty where
  node := wegnerPartyNode
  consistent
    | .wegner => wegnerLexical_is_satisfiable
    | .sign => signArgument_is_satisfiable
    | .reply => ordinarySignReply_is_satisfiable
  sound
    | .wegner => wegner_establishes
    | .sign => signArgument_establishes
    | .reply => ordinarySignReply_establishes
  rated i := by
    cases i <;> simp [bornOfAVirginDefs, Line.asPackage]

/-- **Wegner and the near-term reply stand together**, in Wegner's own world:
the word does not denote a virgin, and the sign need not be a miracle. -/
theorem wegner_stands_with_the_reply : wegnerDispute.StandTogether [.wegner, .reply] := by
  satisfied_by nearTermSignReading [Dispute.StandTogether, bornOfAVirginDefs]

/-- The defeats of the dispute, as a table. -/
def wegnerPartyDefeats : WegnerParty → WegnerParty → Prop
  | .sign, .wegner => True
  | .wegner, .sign => True
  | .reply, .sign => True
  | .sign, .reply => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel wegnerPartyDefeats := fun i j => by
  cases i <;> cases j <;> unfold wegnerPartyDefeats <;> infer_instance

/-- Every party's weakest link ranks at the bottom. -/
theorem wegnerPartyNode_strength : ∀ i, (wegnerPartyNode i).strength = 0
  | .wegner => wegnerLexical_strength
  | .sign => signArgument_strength
  | .reply => ordinarySignReply_strength

/-- **Who defeats whom**, all nine pairs: the fathers and Wegner defeat each
other, the fathers and the reply defeat each other, and nothing else. Every
cell is computed from the parties' premises by `Horn.defeats?` and checked by
the kernel. -/
theorem wegnerDispute_defeats :
    ∀ i j, wegnerDispute.defeats i j ↔ wegnerPartyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (wegnerPartyNode_strength i)
    (wegnerPartyNode_strength j) ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute in the form the verdict solver computes with. -/
def wegnerFinite : Solver.Finite wegnerDispute.defeats where
  parties := [.wegner, .sign, .reply]
  complete i := by cases i <;> decide
  defeats i j := decide (wegnerPartyDefeats i j)
  spec i j := by rw [wegnerDispute_defeats]; simp

/-- **Nothing prevails.** Every party is defeated by someone — Wegner and the
reply by the fathers, the fathers by both — so nothing is forced, and the
grounded extension is empty. -/
@[headline]
theorem nothing_prevails_over_wegner : grounded wegnerDispute.defeats = ∅ :=
  Witness.grounded_eq_empty (F := wegnerFinite)
    (t := [(.wegner, .sign), (.sign, .wegner), (.reply, .sign)]) (by decide +kernel)

#print axioms nothing_prevails_over_wegner

/-- **One resolution: the fathers.** The sign argument alone is admissible — it
defeats both of its defeaters — and it is in conflict with both of the other
parties, so no larger set is. -/
@[headline]
theorem sign_is_one_resolution : Preferred wegnerDispute.defeats {.sign} :=
  (show Solver.toSet [WegnerParty.sign] = {.sign} by ext; simp) ▸
    Witness.preferred_of_witness (F := wegnerFinite) (by decide +kernel)

#print axioms sign_is_one_resolution

/-- **The other resolution: Wegner, with the near-term reply.** Neither defeats
the other, and between them they answer the fathers, who are the only party to
defeat either. The fathers are in conflict with both, so no larger set is
admissible. -/
@[headline]
theorem wegner_is_the_other_resolution :
    Preferred wegnerDispute.defeats {.wegner, .reply} :=
  (show Solver.toSet [WegnerParty.wegner, .reply] = {.wegner, .reply} by ext; simp) ▸
    Witness.preferred_of_witness (F := wegnerFinite) (by decide +kernel)

#print axioms wegner_is_the_other_resolution

/-- So the dispute does not force the fathers' reading. -/
theorem sign_not_skeptically_accepted :
    ¬ SkepticallyAccepted wegnerDispute.defeats .sign :=
  fun h => by simpa using h _ wegner_is_the_other_resolution

/-- Nor does it force Wegner's. -/
theorem wegner_not_skeptically_accepted :
    ¬ SkepticallyAccepted wegnerDispute.defeats .wegner :=
  fun h => by simpa using h _ sign_is_one_resolution

/-! ### A hearing without the reply -/

/-- Wegner and the fathers alone. -/
abbrev signAgainstWegner := wegnerDispute.restrict (· ∈ [WegnerParty.wegner, .sign])

/-- **Without the reply, nothing prevails either.** Wegner and the fathers
defeat each other, so the reply is not what keeps the fathers from prevailing:
Wegner's rebuttal does, because the fathers' weakest link is no stronger than
his. -/
@[headline]
theorem nothing_prevails_without_the_reply : grounded signAgainstWegner.defeats = ∅ :=
  Witness.grounded_eq_empty (F := wegnerFinite.restrict (· ∈ [WegnerParty.wegner, .sign]))
    (t := Witness.Table.sub _ [(.wegner, .sign), (.sign, .wegner)]) (by decide +kernel)

#print axioms nothing_prevails_without_the_reply

end Testimony.Arguments.BornOfAVirgin
