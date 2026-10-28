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
claim against its rival. Four positions meet:

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
- **The case from the laws** (Bratcher's): the Greek Pentateuch, the corpus
  Genesis 34:3 comes from, uses the word in two laws where virginity is the
  point. The high priest marries a παρθένος — "a woman in her virginity", in the
  Hebrew — and not a widow, a woman put away, a defiled woman or a harlot
  (Leviticus 21:13–14). A bride without τὰ παρθένια, the tokens of virginity,
  dies for playing the harlot (Deuteronomy 22:13–21).

## What this dispute does not decide

It is about a Greek word. It is not about the virgin birth, and not about
whether Isaiah 7:14 is fulfilled in Christ. That is weighed in `Dispute`, where
the scriptural reading prevails once the replies are heard
(`scriptural_reading_prevails_once_replies_are_heard`) and the critical denial
of the prediction belongs to no position that can be defended
(`critical_denial_indefensible`). That shows that the case against the
prediction does not survive the replies, on those premises and ratings; it does
not prove the prediction. And it needs neither side's claim about παρθένος.

Nor is it a dispute between believers and unbelievers. Wegner and Rhodea write
as evangelicals. Wegner holds that Isaiah 7:14 is used in Matthew "to refer to
Mary, who was indeed a virgin", the "only virgin birth in the Bible" (483).
Rhodea turns the weak sense of the word into an argument that Matthew did not
invent the virginal conception to fit Isaiah: neither the Hebrew nor the Greek
demands it, so Isaiah gave him no reason to (76).

## What the claims say, and how they are joined

The claims about the word are claims about its senses. Rico and Gentry's,
encoded, is that "virgin" is a sense of παρθένος in the Septuagint's Greek;
they say more, "whenever it appears". Wegner's is that the word meant "young
woman" there, and did not yet have the sense "virgin". Two senses of one word do
not exclude each other, so the two claims contradict each other only through
Wegner's "not yet": the library's account of what each claim means finds that
they cannot both be true (`TestimonyArguments.Meanings.BornOfAVirgin.joins`).

The laws are joined the same way. The case from the laws concludes that the
word has the sense "virgin" in two passages of the Septuagint. A sense a word
has in one passage of a text is a sense it has in that text's usage as a whole
(`Testimony.Ontology.Usage`): a definition of terms, not a reading of any text.
So the laws' sense, if it holds, makes "virgin" one of the word's senses in the
Septuagint's Greek. That is the claim encoded for Rico and Gentry, and the
witness's ground, and it excludes Wegner's "not yet 'virgin'". It does not say
which sense the translator of Isaiah used at 7:14; that move is the witness's
own step. Nor does the definition count a word used *of* a virgin as meaning
"virgin": a thousand uses of "fiancée" of virgins, Walton observes, would not
make it mean "virgin" (292). The laws count only because their contexts turn on
the sense.

Every party holds these joins, and each attack below is computed with them. In
the names of the results, *drift* is Wegner's case that the word's sense
shifted.

## How to read the verdicts

- **Defeats.** One position contradicts another, and the attack survives the
  ratings. An attack on a premise succeeds unless that premise is rated higher
  than the attacker's weakest link. An attack on a conclusion, or on a claim
  derived on the way, succeeds unless the attacked position is the stronger of
  the two. A defeat that runs both ways is a *standoff*.
- **Weakest link.** A position is only as strong as its least-supported premise
  or step. Every party here rests on something rated `disputed`, the lowest
  rating, so, as the ratings stand, no party outranks another and every
  standoff holds.
- **Prevails.** Accepted however every standoff is resolved.
- **A resolution.** A largest set of positions, none of which defeats another,
  that answers every attack on its members, itself or through an ally. A
  position in some resolution can be defended; one left out of some resolution
  is not forced — which is not the same as false.

## What the solver computed

Three standoffs, all with Wegner, and nothing else (`septuagintDispute_defeats`,
all sixteen pairs):

- **Wegner and the witness.** What Wegner holds denies the witness's ground that
  "virgin" is a sense of the word; what the witness holds denies his
  conclusion.
- **Wegner and Rico and Gentry.** Each concludes what the other's conclusion
  rules out.
- **Wegner and the laws.** The laws' sense excludes his "not yet 'virgin'", and
  his conclusion excludes theirs.

The witness, Rico and Gentry and the laws do not attack one another. They stand
together (`septuagint_stands_with_the_usage`). Rico and Gentry lend the witness
its contested ground: their conclusion is that ground, word for word. The laws
reach the same ground through the definition, so the library draws no support
from them, though they lead to the same place.

**Nothing prevails** (`nothing_prevails_over_parthenos`): every party is defeated
by someone. The dispute has two resolutions, each proved: the Septuagint's
witness with Rico and Gentry and the laws (`septuagint_is_one_resolution`), and
Wegner alone (`drift_is_the_other_resolution`). Either can be defended; neither
is forced.

## Where the evidence lies

The tie is a tie of ratings, and the ratings count dissenters, not evidence.
What each side brings is not alike, and a reader should see it.

For "virgin" as a sense of the word in the Septuagint's Greek:

- **The Greek Pentateuch's own usage.** Every בְּתוּלָה and בְּתוּלִים in the Hebrew
  Pentateuch — fifteen words in fourteen verses — has a παρθεν- word in the
  Greek, and its laws use the word where virginity is the point (read from
  Rahlfs's text and the Masoretic). Across the whole Septuagint, Bratcher counts
  παρθένος for בְּתוּלָה forty-five times out of fifty-two (113).
- **The lexica on the laws.** LSJ glosses τὰ παρθένια "signs of virginity", from
  Deuteronomy 22 (1339); Muraoka, "tokens of virginity" (535); LEH, "signs
  pertaining to virginity, virginity". LEH glosses παρθένος itself "virgin"
  first.
- **Readers who hold the sense, whatever they make of the prophecy.** Rico and
  Gentry; Bratcher, for whom the word "definitely means 'virgin' in the LXX"
  (113), though he reads 7:14 of a woman then a virgin who conceives "in the
  normal way" (115); and Delling, for whom the Septuagint's usage at 7:14
  demands "no more than the sense of a 'woman untouched by a man up to the
  moment of the conception'" (as Rhodea quotes him, 67 n. 42): a virgin until
  then, whatever followed. Rhodea, who follows Wegner, still writes that
  παρθένος "more properly means 'virgin'" (67), and holds that in the Septuagint
  it "need not refer to a virgo intacta".

For "young woman, and not yet 'virgin'":

- **Early Greek usage.** Early Greek had both senses. LSJ gives "maiden, girl",
  "virgin, opp. γυνή", and "of unmarried women who are not virgins" (1339);
  BDAG gives the general use "of a young woman of marriageable age, w. or
  without focus on virginity" from Homer on (777), and the sense "virgin" in the
  New Testament and the early Christian writings. Every side grants it.
- **Genesis 34:3**, one verse with the word twice, which every side grants.
- **Muraoka's lexicon**, which glosses παρθένος "young woman", lists Genesis 34:3,
  "so called just after having been raped", and marks "virginity stressed (?)"
  in the laws of Deuteronomy 22 (535).
- **Readers.** Wegner, Rhodea, Meade, Davidson and Miller; Walton doubts the
  virgin sense, citing Brown for the word's broader sense (293 n. 15). Brown
  himself holds that the translator chose "a deliberate preference for
  understanding the young woman of Isa 7:14 as a virgin" (*Birth of the Messiah*
  148): a claim about how the translator read the woman, not about the word.

None of this moves a rating. The solver weighs who contests a claim, not how
much evidence each side brings. But it does show what the tie is: between the
broader sense of early Greek, with one passage of the Septuagint, read by one
side as the rule; and the Septuagint's usage at large, read by the other as the
rule, with that passage the exception.

## What the ratings decide

Every party's weakest link is `disputed`, so every attack succeeds. Four ratings
would break the tie: one in Wegner's favour, three in the witness's. Each was
found by running the solver on the changed rating; no theorem on this page
states those runs.

**Wegner's step**, from the older usage and Genesis 34:3 to the Septuagint's
sense, is rated `disputed`, the lowest rating. Rico and Gentry, and Bratcher,
grant both its grounds and deny its conclusion: to Rico and Gentry, Genesis 34:3
is "the exception that proves the rule", an archaism of the Greek Pentateuch
(18, 21); to Bratcher, an exception made "inexplicably" (113). The higher
ratings belong to the grounds, not the step: that early Greek used παρθένος of a
young woman (well supported), and that the Greek of Genesis 34:3 calls Dinah one
(`consensus`). Both sides grant them, and neither says what the word meant at
Isaiah 7:14. Only if the step itself were rated higher would Wegner defeat all
three rivals unanswered, and prevail alone.

**Rico and Gentry's step**, from the Jewish objection (and the Greek Isaiah's
usage, which the library adds) to the sense. It is `disputed` because Davidson
(1899) and Meade (2013) grant the objection and read it the other way: the
revisers wrote νεᾶνις against a sense Christians had put on the word, not one
its translator gave it. Rated higher, Rico and Gentry would defeat Wegner and he
could not answer them; the witness would then prevail with them and the laws.

**The laws' step**, from what the two laws read to the sense of the word in them
(`laws_rest_on_their_inference`). It is `disputed` on one reader. Miller grants
that the laws require virgins, and holds that the virginity "has to be inferred
from the context": "parthenos in the Septuagint did not by itself connote what
we mean by virginity". Of what he says of the Greek, Genesis 34:3 holds; the
young widow he finds at Joel 1:8 is not there in the Greek, which calls her a
bride; and the translators did not "consistently" use the word for עַלְמָה. His
remaining point, that the Greek adds "who has not known a man" where virginity
matters (Genesis 24:16), translates a clause the Hebrew already has; what it
shows about the word, the page does not settle. The case from the laws gives
his dissent in his words. The rating rests on him, and showing his evidence
partly wrong does not move it: the rule counts a reader who grants the grounds
and denies the conclusion. Rated higher, the laws would defeat Wegner and he
could not answer them; the witness would prevail with Rico and Gentry and the
laws.

**The witness's own ground**, that "virgin" is a sense of the word, cited
`disputed` because Wegner, Walton, Rhodea and Meade contest it. An attack on a
premise is weighed against that premise's own rating. Rated higher, the ground
would outrank Wegner's attack on it, and the witness would prevail with Rico and
Gentry and the laws. This is the rating closest to the reader who holds that the
word is undeniably "virgin". The laws are a cited argument against Wegner's case
for the opposite; they do not raise the ground's rating, because the readers who
contest the ground still contest it.

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

/-- The case from the laws delivers its conclusion. -/
theorem lawsCase_establishes : Establishes lawsCase := by
  establish [bornOfAVirginDefs]

/-- The case from the laws has a model: the reading Justin gives the elders'
Greek, extended to the laws. "Virgin" is a sense of the word, and the laws use
it so. -/
theorem lawsCase_is_satisfiable : Satisfiable lawsCase.premises := by
  satisfied_by virginConceivesReading [bornOfAVirginDefs]

/-- **The case from the laws rests on its inference.** The high priest's
παρθένος is set against the widow and the harlot, and the bride without τὰ
παρθένια dies as a harlot; and still, on Miller's reading, which Wegner's thesis
requires, the word itself means a young woman there, as at Genesis 34:3. What the
laws read does not decide the word's sense; the step does, and its rating is one
of the four that would decide the dispute. -/
@[headline]
theorem laws_rest_on_their_inference :
    ¬ Entails lawsLine.grounds (p .lawsUseParthenosAsVirgin) := by
  refute_with wegnerDriftReading [bornOfAVirginDefs]

#print axioms laws_rest_on_their_inference

/-! ### Strength -/

/-- The witness is no stronger than its claim about the word, cited
`disputed`, nor than its step, rated `disputed` on Walton's report of Archer. -/
theorem septuagintWitness_strength : septuagintWitness.strength = 0 := by decide

/-- Wegner's grounds are well supported and `consensus`, but his inference is
`disputed`, on Rico and Gentry and on Bratcher. -/
theorem driftObjection_strength : driftObjection.strength = 0 := by decide

/-- Rico and Gentry's grounds are `consensus`, but their inference is
`disputed`, on Davidson and Meade. -/
theorem usageCase_strength : usageCase.strength = 0 := by decide

/-- The laws' grounds are `consensus`, what the Greek reads, but their inference
is `disputed`, on Miller. -/
theorem lawsCase_strength : lawsCase.strength = 0 := by decide

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

/-- **Wegner defeats the case from the laws.** That the word had not yet come to
mean "virgin" excludes that the laws used it in that sense, because a sense the
word has in one passage of the Septuagint is a sense of the Septuagint's Greek.
The laws, at `disputed`, are no stronger than he. -/
theorem drift_defeats_laws : Defeats driftObjection lawsCase :=
  Horn.defeats_of_defeats? driftObjection_strength lawsCase_strength (by decide +kernel)

/-- **The case from the laws defeats Wegner.** Their sense "virgin" excludes his
"not yet 'virgin'", and he is no stronger than they. -/
theorem laws_defeats_drift : Defeats lawsCase driftObjection :=
  Horn.defeats_of_defeats? lawsCase_strength driftObjection_strength (by decide +kernel)

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
  /-- The case from the laws: in the Greek Pentateuch's laws, παρθένος is used in
  the sense "virgin". -/
  | laws
deriving DecidableEq

/-- The package each party argues from. -/
@[bornOfAVirginDefs]
def septuagintPartyNode : SeptuagintParty → ArgumentPackage Claim
  | .witness => septuagintWitness
  | .drift => driftObjection
  | .usage => usageCase
  | .laws => lawsCase

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
    | .laws => lawsCase_establishes
  rated i := by
    cases i <;> simp [bornOfAVirginDefs, Line.asPackage]

/-- **The witness, Rico and Gentry and the laws stand together**, on the reading
Justin gives the elders' Greek, extended to the laws: "virgin" is a sense of the
word, the laws use it so, and the translator read the woman of 7:14 as a
virgin. -/
theorem septuagint_stands_with_the_usage :
    septuagintDispute.StandTogether [.witness, .usage, .laws] := by
  satisfied_by virginConceivesReading [Dispute.StandTogether, bornOfAVirginDefs]

/-- The defeats of the dispute, as a table. -/
def septuagintPartyDefeats : SeptuagintParty → SeptuagintParty → Prop
  | .drift, .witness => True
  | .witness, .drift => True
  | .drift, .usage => True
  | .usage, .drift => True
  | .drift, .laws => True
  | .laws, .drift => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel septuagintPartyDefeats := fun i j => by
  cases i <;> cases j <;> unfold septuagintPartyDefeats <;> infer_instance

/-- Every party's weakest link ranks at the bottom. -/
theorem septuagintPartyNode_strength : ∀ i, (septuagintPartyNode i).strength = 0
  | .witness => septuagintWitness_strength
  | .drift => driftObjection_strength
  | .usage => usageCase_strength
  | .laws => lawsCase_strength

/-- **Who defeats whom**, all sixteen pairs: Wegner defeats each of the other
three, and each defeats him back; and nothing else. Every
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
  parties := [.witness, .drift, .usage, .laws]
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

/-- **One support**, in all sixteen pairs: Rico and Gentry's conclusion is the
witness's contested ground, that "virgin" is a sense of παρθένος. The library
draws a support only where one party's conclusion is, word for word, another's
premise. The laws reach the witness's ground through a definition, so no support
is drawn from them, though they lead to the same ground. Every cell is computed
by `supports?` and checked by the kernel. -/
theorem septuagintDispute_supports :
    ∀ i j, septuagintDispute.supports i j ↔ septuagintPartySupports i j := by
  intro i j
  refine supports_iff_of_supports? ?_
  cases i <;> cases j <;> decide +kernel

/-- **No case is part of another's** here, in all sixteen pairs, except each
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
  claim := .nothingGrounded
    [(.witness, .drift), (.drift, .witness), (.usage, .drift), (.laws, .drift)]
  checked := by decide +kernel

/-- **Nothing prevails.** Every party is defeated by someone — the witness, Rico
and Gentry and the laws by Wegner, Wegner by all three — so no position is
accepted however the standoffs are resolved. -/
@[headline]
theorem nothing_prevails_over_parthenos : grounded septuagintDispute.defeats = ∅ :=
  everySeptuagintPartyDefeated.holds

#print axioms nothing_prevails_over_parthenos

/-- Why the witness with Rico and Gentry and the laws is one resolution. -/
def septuagintWithTheUsage : Verdict septuagintDispute where
  finite := septuagintFinite
  claim := .preferred [.witness, .usage, .laws]
  checked := by decide +kernel

/-- **One resolution: the Septuagint's witness, with Rico and Gentry and the
laws.** None of the three defeats another, and between them they answer Wegner,
the only party to defeat any of them. Wegner is in conflict with all three, so no
larger set can be defended. -/
@[headline]
theorem septuagint_is_one_resolution :
    Preferred septuagintDispute.defeats {.witness, .usage, .laws} :=
  (show Solver.toSet [SeptuagintParty.witness, .usage, .laws] =
      {.witness, .usage, .laws} by ext; simp) ▸
    septuagintWithTheUsage.holds

#print axioms septuagint_is_one_resolution

/-- Why Wegner alone is the other resolution. -/
def driftAlone : Verdict septuagintDispute where
  finite := septuagintFinite
  claim := .preferred [.drift]
  checked := by decide +kernel

/-- **The other resolution: Wegner.** His case can be defended on its own,
because it defeats every party that defeats it; and it is in conflict with all
three, so no larger set can be defended. -/
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
