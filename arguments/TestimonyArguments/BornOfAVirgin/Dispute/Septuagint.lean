import TestimonyArguments.Meanings.BornOfAVirgin
import TestimonyArguments.BornOfAVirgin.Results.Septuagint
import Testimony.Logic.Dispute
import Testimony.Logic.Horn
import Testimony.Logic.Solver
import Testimony.Logic.Verdict
import Testimony.Logic.Map

/-!
# TestimonyArguments.BornOfAVirgin.Dispute.Septuagint — what the Septuagint's word meant

`Results.Septuagint` shows that the Septuagint's witness rests on one claim: that
παρθένος, in its translator's Greek, means a virgin. This module weighs that
claim against its rival. Three positions meet:

- **The Septuagint as a witness** (Irenaeus): Jews translated Isaiah before
  Christ and wrote a word that means a virgin, so they read the woman as one.
- **Wegner on παρθένος** (with Rhodea and Meade): in the Septuagint's day the
  word meant a young woman of marriageable age, and the sense "virgin" came
  later. Genesis 34:3 calls Dinah a παρθένος after Shechem has lain with her.
- **Rico and Gentry's case from usage**: παρθένος means a virgin "whenever it
  appears in Semitic Koine Greek", or the Jewish objection to it — Trypho's, and
  the Three's νεᾶνις — would have had no point. The library adds a ground of its
  own, encoded with theirs: the Greek Isaiah uses the word elsewhere only for
  בְּתוּלָה.

This is a dispute about a Greek word, not about the virgin birth. Wegner and
Rhodea write as evangelicals. Wegner holds that Isaiah 7:14 is used in Matthew
"to refer to Mary, who was indeed a virgin", the "only virgin birth in the
Bible" (483). Rhodea turns the weak sense of the word into an argument that
Matthew did not invent the virginal conception to fit Isaiah: neither the Hebrew
nor the Greek demands it, so Isaiah gave him no reason to (76).

Wegner and Rico and Gentry contradict each other, though no premise says so in
as many words. Wegner says that in the translator's Greek the word meant a young
woman and did not yet mean a virgin; Rico and Gentry say it meant a virgin. The
library's account of what each claim means finds that the two cannot both be
true (`TestimonyArguments.Meanings.BornOfAVirgin.joins`). Every party holds that
much, and each attack below is computed with it.

## How to read the verdicts

- **Defeats.** One position contradicts another — denies one of its premises,
  its conclusion, or a claim it derives on the way — and is not the weaker of
  the two. A defeat that runs both ways is a *standoff*.
- **Weakest link.** A position is only as strong as its least-supported premise
  or step. Every party here rests on something rated `disputed`, the lowest
  rating, so no rating breaks a standoff.
- **Prevails.** Accepted however every standoff is resolved.
- **A resolution.** A largest consistent set of positions that answers every
  attack on its members, itself or through an ally. A position in some
  resolution can be defended; one left out of some resolution is not forced —
  which is not the same as false.

## What the solver computed

Two standoffs, and nothing else (`septuagintDispute_defeats`, all nine pairs):

- **Wegner and the witness.** What Wegner holds denies the witness's ground that
  παρθένος means a virgin; what the witness holds denies his conclusion.
- **Wegner and Rico and Gentry.** Each concludes what the other's conclusion
  rules out.

The witness and Rico and Gentry do not attack each other. They stand together
(`septuagint_stands_with_the_usage`), and Rico and Gentry lend the witness its
contested ground: their conclusion is that ground.

**Nothing prevails** (`nothing_prevails_over_parthenos`): every party is defeated
by someone. The dispute has two resolutions, each proved: the Septuagint's
witness with Rico and Gentry (`septuagint_is_one_resolution`), and Wegner alone
(`drift_is_the_other_resolution`). Either can be defended; neither is forced.

So a reader who says that the Septuagint's word is undeniably "virgin" is taking
a side in a live dispute, with good company on it — Irenaeus and Justin, Rico and
Gentry, Bratcher, and on the translator's reading even Brown, who holds that his
choice "represented a deliberate preference for understanding the young woman of
Isa 7:14 as a virgin" (*Birth of the Messiah* 148) — and not stating a fact both
sides grant.

## What the ratings decide

Every party's weakest link is `disputed`, so every attack succeeds. Three ratings
would break the tie: one in Wegner's favour, two in the witness's.

**Wegner's step**, from the older usage and Genesis 34:3 to the Septuagint's
sense. It is `disputed` because Rico and Gentry, and Bratcher, grant both its
grounds and deny its conclusion: to Rico and Gentry, Genesis 34:3 is "the
exception that proves the rule", an archaism of the Greek Pentateuch (18, 21);
to Bratcher, an exception made "inexplicably" (113). Rated higher, Wegner would
defeat both rivals and neither could answer him, since his grounds are rated
`consensus` and `wellSupported`: he alone would prevail.

**Rico and Gentry's step**, from the Jewish objection (and the Greek Isaiah's
usage, which the library adds) to the sense. It is `disputed` because Davidson
(1899) and Meade (2013) grant the objection and read it the other way: the
revisers wrote νεᾶνις against a sense Christians had put on the word, not one
its translator gave it. Rated higher, Rico and Gentry would defeat Wegner and he
could not answer them; the witness would then prevail with them. Wegner's attack
on the witness would still succeed, but Wegner himself would be out, defeated by
a party nothing defeats.

**The witness's own ground**, `parthenosMeansVirgin`, cited `disputed` because
Wegner, Walton, Rhodea and Meade contest it. An attack on a premise is weighed
against that premise's own rating. Rated higher, the ground would outrank
Wegner's attack on it, and the witness would prevail with Rico and Gentry, as
before. This is the rating closest to the reader who holds that the word is
undeniably "virgin". What would raise it is a cited argument that answers
Wegner, Walton, Rhodea and Meade.

The dissents on the rival steps are brief on both sides. Davidson hedges his
account of the Three with a "possibly", though not his account of the word;
Meade's is a blog comment revising his own earlier view. Against Wegner, Rico
and Gentry give a reason, the archaism of the Greek Pentateuch, while Bratcher
calls Genesis 34:3 inexplicable without explaining it. The ratings weigh none of
this. Each step has a cited reader who grants its grounds and denies its
conclusion, and so each is `disputed`.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### Wegner and Rico and Gentry as positions -/

/-- Wegner on παρθένος delivers its conclusion. -/
theorem driftObjection_establishes : Establishes driftObjection := by
  establish [bornOfAVirginDefs]

/-- Wegner on παρθένος has a model: his own reading, in which the word had not
yet come to mean "virgin". -/
theorem driftObjection_is_satisfiable : Satisfiable driftObjection.premises := by
  satisfied_by wegnerDriftReading [bornOfAVirginDefs]

/-- **Wegner on παρθένος rests on its inference.** On Rico and Gentry's reading
the older Greek usage is granted, Dinah is called παρθένος after Shechem has lain
with her, and the word still means a virgin in the Septuagint at large: Genesis
34:3 is an archaism of the Greek Pentateuch. The two grounds do not decide the
question; the step does, and that is why it is rated `disputed`. -/
@[headline]
theorem drift_rests_on_its_inference :
    ¬ Entails driftLine.grounds (p .parthenosMeantYoungWoman) := by
  refute_with virginConceivesReading [bornOfAVirginDefs]

#print axioms drift_rests_on_its_inference

/-- Rico and Gentry's case delivers its conclusion. -/
theorem usageCase_establishes : Establishes usageCase := by
  establish [bornOfAVirginDefs]

/-- Rico and Gentry's case has a model: Justin's reading of the elders' Greek. -/
theorem usageCase_is_satisfiable : Satisfiable usageCase.premises := by
  satisfied_by virginConceivesReading [bornOfAVirginDefs]

/-- **Rico and Gentry's case rests on its inference.** On the reading Davidson
(1899, 456) and Meade (2013) give, Trypho objects to παρθένος and the Three
write νεᾶνις because by then Christians had put the sense "virgin" on the word,
while in the translator's day it still meant a young woman; and the Greek
Isaiah's other παρθένοι still render בְּתוּלָה. The countermodel is Wegner's
reading, which allows all of this. The grounds do not decide the question; the
step does, and that is why it is rated `disputed`. -/
@[headline]
theorem usage_rests_on_its_inference :
    ¬ Entails usageLine.grounds (p .parthenosMeansVirgin) := by
  refute_with wegnerDriftReading [bornOfAVirginDefs]

#print axioms usage_rests_on_its_inference

/-! ### Strength -/

/-- The witness is no stronger than its claim about the word, cited
`disputed`, nor than its step, rated `disputed` on Walton's report of Archer. -/
theorem septuagintWitness_strength : septuagintWitness.strength = 0 := by decide

/-- Wegner's grounds are `wellSupported` and `consensus`, but his inference is
`disputed`. -/
theorem driftObjection_strength : driftObjection.strength = 0 := by decide

/-- Rico and Gentry's grounds are `consensus`, but their inference is
`disputed`. -/
theorem usageCase_strength : usageCase.strength = 0 := by decide

/-! ### The defeats -/

/-- **Wegner defeats the Septuagint's witness.** What he holds — his conclusion,
with what it means — denies the witness's ground that παρθένος means a virgin,
which, cited `disputed`, does not outrank him. -/
theorem drift_defeats_septuagint : Defeats driftObjection septuagintWitness :=
  Horn.defeats_of_defeats? driftObjection_strength septuagintWitness_strength
    (by decide +kernel)

/-- **The witness defeats Wegner back**, so the two stand off. It holds that the
word means a virgin, which denies what Wegner concludes, and he is no stronger
than it. -/
theorem septuagint_defeats_drift : Defeats septuagintWitness driftObjection :=
  Horn.defeats_of_defeats? septuagintWitness_strength driftObjection_strength
    (by decide +kernel)

/-- **Wegner defeats Rico and Gentry.** His conclusion denies theirs. -/
theorem drift_defeats_usage : Defeats driftObjection usageCase :=
  Horn.defeats_of_defeats? driftObjection_strength usageCase_strength (by decide +kernel)

/-- **Rico and Gentry defeat Wegner.** Their conclusion denies his. -/
theorem usage_defeats_drift : Defeats usageCase driftObjection :=
  Horn.defeats_of_defeats? usageCase_strength driftObjection_strength (by decide +kernel)

/-! ### The dispute -/

/-- The parties to the dispute over the Septuagint's word. -/
inductive SeptuagintParty
  /-- The Septuagint as a witness: its translator read the woman as a virgin. -/
  | witness
  /-- Wegner on παρθένος: in the Septuagint's day, the word meant a young
  woman. -/
  | drift
  /-- Rico and Gentry's case from usage: παρθένος means a virgin. -/
  | usage
deriving DecidableEq

/-- The package each party argues from. -/
@[bornOfAVirginDefs]
def septuagintPartyNode : SeptuagintParty → ArgumentPackage Claim
  | .witness => septuagintWitness
  | .drift => driftObjection
  | .usage => usageCase

/-- The dispute over the Septuagint's word: every party's premises have a model,
every party establishes its conclusion, and every party's inferences are
rated. -/
@[bornOfAVirginDefs]
def septuagintDispute : Dispute Claim SeptuagintParty where
  node := septuagintPartyNode
  consistent i := Horn.satisfiable_of_satisfiable? (by cases i <;> decide +kernel)
  sound
    | .witness => septuagintWitness_establishes
    | .drift => driftObjection_establishes
    | .usage => usageCase_establishes
  rated i := by
    cases i <;> simp [bornOfAVirginDefs, Line.asPackage]

/-- **The witness and Rico and Gentry stand together**, on Justin's reading: the
word means a virgin, and the translator read the woman as one. -/
theorem septuagint_stands_with_the_usage :
    septuagintDispute.StandTogether [.witness, .usage] := by
  satisfied_by virginConceivesReading [Dispute.StandTogether, bornOfAVirginDefs]

/-- The defeats of the dispute, as a table. -/
def septuagintPartyDefeats : SeptuagintParty → SeptuagintParty → Prop
  | .drift, .witness => True
  | .witness, .drift => True
  | .drift, .usage => True
  | .usage, .drift => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel septuagintPartyDefeats := fun i j => by
  cases i <;> cases j <;> unfold septuagintPartyDefeats <;> infer_instance

/-- Every party's weakest link ranks at the bottom. -/
theorem septuagintPartyNode_strength : ∀ i, (septuagintPartyNode i).strength = 0
  | .witness => septuagintWitness_strength
  | .drift => driftObjection_strength
  | .usage => usageCase_strength

/-- **Who defeats whom**, all nine pairs: Wegner and the witness defeat each
other, Wegner and Rico and Gentry defeat each other, and nothing else. Every
cell is computed from what the parties hold by `Horn.defeats?` and checked by
the kernel. -/
theorem septuagintDispute_defeats :
    ∀ i j, septuagintDispute.defeats i j ↔ septuagintPartyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (septuagintPartyNode_strength i)
    (septuagintPartyNode_strength j) ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute in the form the verdict solver computes with. -/
def septuagintFinite : Solver.Finite septuagintDispute.defeats where
  parties := [.witness, .drift, .usage]
  complete i := by cases i <;> decide
  defeats i j := decide (septuagintPartyDefeats i j)
  spec i j := by rw [septuagintDispute_defeats]; simp

/-- Who supports whom, as a table: Rico and Gentry lend the witness its ground. -/
def septuagintPartySupports : SeptuagintParty → SeptuagintParty → Prop
  | .usage, .witness => True
  | _, _ => False

/-- The support table is finite, so membership in it is decidable. -/
instance : DecidableRel septuagintPartySupports := fun i j => by
  cases i <;> cases j <;> unfold septuagintPartySupports <;> infer_instance

/-- **One support**, in all nine pairs: Rico and Gentry's conclusion is the
witness's contested ground, that παρθένος means a virgin. Nothing else supports
anything. Every cell is computed by `supports?` and checked by the kernel. -/
theorem septuagintDispute_supports :
    ∀ i j, septuagintDispute.supports i j ↔ septuagintPartySupports i j := by
  intro i j
  refine supports_iff_of_supports? ?_
  cases i <;> cases j <;> decide +kernel

/-- **No case is part of another's** here, in all nine pairs, except each
party's own. Every cell is computed by `partOf?` and checked by the kernel. -/
theorem septuagintDispute_partOf : ∀ i j, septuagintDispute.partOf i j ↔ i = j := by
  intro i j
  refine partOf_iff_of_partOf? ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute drawn: who defeats whom, and the one support. -/
def septuagintMap : ArgumentMap septuagintDispute where
  finite := septuagintFinite
  supports i j := decide (septuagintPartySupports i j)
  supports_spec i j := by rw [septuagintDispute_supports]; simp
  partOf i j := decide (i = j)
  partOf_spec i j := by rw [septuagintDispute_partOf]; simp

/-- Why nothing prevails: a defeater for each party. -/
def everySeptuagintPartyDefeated : Verdict septuagintDispute where
  finite := septuagintFinite
  claim := .nothingGrounded [(.witness, .drift), (.drift, .witness), (.usage, .drift)]
  checked := by decide +kernel

/-- **Nothing prevails.** Every party is defeated by someone — the witness and
Rico and Gentry by Wegner, Wegner by both — so no position is accepted however
the standoffs are resolved. -/
@[headline]
theorem nothing_prevails_over_parthenos : grounded septuagintDispute.defeats = ∅ :=
  everySeptuagintPartyDefeated.holds

#print axioms nothing_prevails_over_parthenos

/-- Why the witness with Rico and Gentry is one resolution. -/
def septuagintWithTheUsage : Verdict septuagintDispute where
  finite := septuagintFinite
  claim := .preferred [.witness, .usage]
  checked := by decide +kernel

/-- **One resolution: the Septuagint's witness, with Rico and Gentry.** Neither
defeats the other, and between them they answer Wegner, the only party to defeat
either. Wegner is in conflict with both, so no larger set can be defended. -/
@[headline]
theorem septuagint_is_one_resolution :
    Preferred septuagintDispute.defeats {.witness, .usage} :=
  (show Solver.toSet [SeptuagintParty.witness, .usage] = {.witness, .usage} by ext; simp) ▸
    septuagintWithTheUsage.holds

#print axioms septuagint_is_one_resolution

/-- Why Wegner alone is the other resolution. -/
def driftAlone : Verdict septuagintDispute where
  finite := septuagintFinite
  claim := .preferred [.drift]
  checked := by decide +kernel

/-- **The other resolution: Wegner.** His case can be defended on its own,
because it defeats both parties that defeat it; and it is in conflict with both,
so no larger set can be defended. -/
@[headline]
theorem drift_is_the_other_resolution : Preferred septuagintDispute.defeats {.drift} :=
  (show Solver.toSet [SeptuagintParty.drift] = {.drift} by ext; simp) ▸ driftAlone.holds

#print axioms drift_is_the_other_resolution

/-- So the dispute does not force the Septuagint's witness. -/
theorem septuagint_not_skeptically_accepted :
    ¬ SkepticallyAccepted septuagintDispute.defeats .witness :=
  fun h => by simpa using h _ drift_is_the_other_resolution

/-- Nor does it force Wegner on παρθένος. -/
theorem drift_not_skeptically_accepted :
    ¬ SkepticallyAccepted septuagintDispute.defeats .drift :=
  fun h => by simpa using h _ septuagint_is_one_resolution

end TestimonyArguments.BornOfAVirgin
