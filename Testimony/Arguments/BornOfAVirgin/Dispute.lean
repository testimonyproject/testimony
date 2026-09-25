import Testimony.Arguments.BornOfAVirgin.Results
import Testimony.Logic.Dispute
import Testimony.Logic.Horn
import Testimony.Logic.Solver
import Testimony.Logic.Witness

/-!
# Arguments.BornOfAVirgin.Dispute — who prevails over Isaiah 7:14

The results in `Results.lean` ask what each package entails. This module asks
what happens when the packages meet: the scriptural reading, the critical
denial of the predictive reading, and four replies to that denial — Berry's
objection, Postell's two counterexamples (Isaiah 9 and 11, and Micah 5), and
Motyer's reply, with Compton's — taken together as one dispute.

Who defeats whom is not stipulated. Each defeat below is a theorem about the
packages' premises, and so is each absence of one (see `Testimony.Logic.Dispute`
for how an attack is derived from entailment and filtered by cited confidence).
The defeats are these:

- **The critical denial defeats the scriptural reading.** It entails the
  negation of the scriptural premise that Isaiah 7:14 predicts a virgin birth,
  a premise cited as `disputed`.
- **The scriptural reading defeats the critical denial back.** It undermines
  none of the critic's premises, but it concludes the opposite, so it rebuts;
  and the weakest link on each side is `disputed`, so neither outranks the
  other.
- **Berry and both of Postell's counterexamples defeat the critical denial**,
  by contradicting its premise that a near-term sign excludes a messianic
  sense, cited `disputed`.
- **Motyer defeats it too**, by contradicting its other premise: that 7:14 is
  a near-term sign to Ahaz at all, also cited `disputed`.
- **The critical denial defeats Berry and Motyer back, but neither
  counterexample.** It rebuts all four. Berry's and Motyer's inferences are
  contested — a cited source grants each one's grounds and denies its
  conclusion — so they are no stronger than the critic. Postell's inference is
  not, and both counterexamples outrank it.

## What follows

Faced with the scriptural reading alone, **nothing prevails**: the two defeat
each other, and the grounded extension is empty. Add the replies and **the
scriptural reading prevails**. Nothing defeats Postell's counterexamples; they
defeat the critic, which is the only party that defeats the scriptural reading,
Berry or Motyer; and so all five stand. The critical denial belongs to no
admissible set at all, because nothing answers Postell. Take away either
counterexample and the scriptural reading still prevails; take away both and
nothing does.

This is the result entailment could not state. Adding premises never removes a
conclusion; adding arguments can change what a dispute forces, and here it
turns an open question into a settled one. The replies do not show that the
predictive reading is true. They show that, on these premises and these
ratings, the case against it does not survive them.

## What the ratings decide

These outcomes rest on the cited confidences as much as on the premises, and
the inferences are rated as the premises are: `disputed` when a cited source
grants a step's grounds and denies its conclusion. Before they were rated, a
reply that put its contested move in a step was weighed by its observations
alone, and every reply outranked the critic. Rated, only one does.

The critic's two premises are `disputed`: Berry, Postell and Motyer contest the
exclusion, Motyer and Compton the near-term sign. Its inference is `consensus`,
because it only applies the exclusion to 7:14.

Berry's inference is `disputed`. Watts grants that the chronology is uncertain
and still reads 7:14 of Hezekiah, as Compton reports. Motyer's is `disputed` for
the same reason: those who identify the two children grant both his
observations and keep the near-term sign, and `motyer_rests_on_his_inference`
proves that the whole weight of his reply falls on that step. So each ties with
the critic, and heard alone Motyer settles nothing
(`nothing_prevails_on_motyer_alone`).

Postell's inference is `plausible`. It is a counterexample to the exclusion —
an oracle on the Assyrian timeline, read messianically — and he gives two:
Isaiah 9 and 11, and Micah 5, whose messianic reading Brown himself grants. No
source cited here grants either set of grounds and keeps the exclusion.

**The verdict rests on that inference.** Without Postell's Isaiah argument the
scriptural reading still prevails, on the Micah counterexample
(`scriptural_reading_prevails_without_postell`), so an attack on the grounds of
either — dating Isaiah 11 later, say — leaves it standing. Without both, every
party is defeated by someone and nothing prevails
(`nothing_prevails_without_the_counterexamples`). The two share one inference,
so they share one weakness: rated `disputed`, it would tie both with the critic
as Berry's and Motyer's do. A critic who granted that such an oracle is read
messianically and still held the exclusion — most likely by denying that
Micah 5 or Isaiah 9 is a *sign* to Ahaz — would be the source to find.

## What the church fathers add, and what they cannot

The predictive reading is not a modern apologetic. Justin, Irenaeus, Origen and
Jerome all argue it, and `Sources.lean` cites them for it: for the
prediction itself and for עַלְמָה as a virgin. That strengthens the attestation
of the scriptural premises, and none of it changes a rating. The argument they
share — that an ordinary conception would have been no sign at all — is
encoded as an argument in its own right, `signLine`. It answers Wegner's
objection rather than the critical denial, so it is weighed in `Dispute.Wegner`
and not here.

It cannot, because of what `disputed` means here: *actively contested by
competent scholars*. The fathers are the earliest witnesses to the contest as
well as to the reading. Justin records Trypho's answer — "young woman", and
fulfilled in Hezekiah — and Irenaeus names Theodotion and Aquila. An older
witness does not make a contested claim uncontested. What moved the result was
the same definition applied to the other side: both of the critic's premises
are contested too, and the library records who contests them.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### The replies as positions

Each reply is an argument in its own right, so it must hold together and
deliver its conclusion before it can take part in a dispute. -/

/-- The world Berry and Postell describe: everything holds except that a
near-term sign excludes a messianic sense. The scriptural reading holds in it
too. -/
def repliesStandReading : Valuation Claim := fun a =>
  match a with
  | .nearTermExcludesMessianicSense => False
  | _ => True

/-- Berry's objection delivers its conclusion. -/
theorem berryObjection_establishes : Establishes berryObjection := by
  establish [bornOfAVirginDefs]

/-- Berry's objection has a model. -/
theorem berryObjection_is_satisfiable : Satisfiable berryObjection.premises := by
  satisfied_by repliesStandReading [bornOfAVirginDefs]

/-- Postell's parity argument delivers its conclusion. -/
theorem postellParity_establishes : Establishes postellParity := by
  establish [bornOfAVirginDefs]

/-- Postell's parity argument has a model. -/
theorem postellParity_is_satisfiable : Satisfiable postellParity.premises := by
  satisfied_by repliesStandReading [bornOfAVirginDefs]

/-! #### Postell's Micah counterexample

Postell's second counterexample is Micah 5, the Bethlehem oracle: a ruler set
against the Assyrian invasion, and read messianically in first-century Judaism
— which Brown, the critic's own authority, grants. It is the same inference as
the Isaiah counterexample from a different oracle, so it guards against an
attack on Postell's grounds and not against one on his inference. -/

/-- **The rival reading, written first**: Micah's ruler is a near-term Davidic
king, and the messianic reading of him came later. Both grounds hold — the
Assyrian setting and the first-century expectation — and so does the
exclusion. -/
def laterMessianicReading : Valuation Claim := fun a =>
  match a with
  | .isaiahPredictsVirginBirth => False
  | _ => True

/-- The Micah counterexample rests on its inference: on the later-reading
account both grounds hold and the exclusion stands. -/
theorem micah_parity_rests_on_its_inference :
    ¬ Entails micahLine.grounds (notP .nearTermExcludesMessianicSense) := by
  refute_with laterMessianicReading [bornOfAVirginDefs]

/-- The Micah counterexample delivers its conclusion. -/
theorem micahParity_establishes : Establishes micahParity := by
  establish [bornOfAVirginDefs]

/-- The Micah counterexample has a model. -/
theorem micahParity_is_satisfiable : Satisfiable micahParity.premises := by
  satisfied_by repliesStandReading [bornOfAVirginDefs]

/-! #### Motyer's reply

Motyer's reply, with Compton's, denies the critic's *other* premise: that 7:14 is
a near-term sign to Ahaz at all. It is built as Berry's and Postell's are. Its
grounds are what the text says — the sign given to the house of David in the
plural, and 8:4 repeating for Maher-shalal-hash-baz the timetable 7:16 gives the
child — and the contested move is the step that joins them, rated `disputed`
because a cited reading grants the grounds and denies what the step concludes. -/

/-- **The rival reading, written first**: the one that identifies the two
children. Isaiah 8:1–4 retells the sign of 7:14–16 for Isaiah's own son, so the
sign was a near-term one after all. Both of Motyer's observations hold in it —
it is the reading his inference has to rule out. -/
def sameChildReading : Valuation Claim := fun a =>
  match a with
  | .isaiahPredictsVirginBirth => False
  | _ => True

/-- **Motyer's reply rests on his inference, not on his observations.** On the
reading that identifies the two children, the sign is given to the house of
David, 8:4 repeats the timetable of 7:16, and 7:14 is still a near-term sign to
Ahaz. The two grounds do not decide the question; the step does, and a reader
who contests the reply contests the step. -/
@[headline]
theorem motyer_rests_on_his_inference :
    ¬ Entails motyerLine.grounds (notP .isaiahIsNearTermSignToAhaz) := by
  refute_with sameChildReading [bornOfAVirginDefs]

#print axioms motyer_rests_on_his_inference

/-- The world Motyer describes, with Berry and Postell: the sign is not a
near-term one, and a near-term sign would not exclude a messianic sense anyway.
Everything else holds — the scriptural reading and all four replies with it. -/
def motyerReading : Valuation Claim := fun a =>
  match a with
  | .isaiahIsNearTermSignToAhaz => False
  | .nearTermExcludesMessianicSense => False
  | _ => True

/-- Motyer's reply delivers its conclusion. -/
theorem motyerReply_establishes : Establishes motyerReply := by
  establish [bornOfAVirginDefs]

/-- Motyer's reply has a model. -/
theorem motyerReply_is_satisfiable : Satisfiable motyerReply.premises := by
  satisfied_by motyerReading [bornOfAVirginDefs]

/-! ### Strength: the weakest link of each position

Premises and inferences alike: a position is no stronger than the least
supported thing it assumes, and an inference is something it assumes. -/

/-- The scriptural reading is no stronger than its least supported premise,
which is cited `disputed`. -/
theorem christian_strength : christian.strength = 0 := by decide

/-- Both of the critical denial's premises are contested, and cited
`disputed`. -/
theorem criticalDenial_strength : criticalDenial.strength = 0 := by decide

/-- Berry's premise is cited `wellSupported`, but his inference is `disputed`,
and he is no stronger than it. -/
theorem berryObjection_strength : berryObjection.strength = 0 := by decide

/-- Postell's premises are cited `wellSupported` and his inference `plausible`. -/
theorem postellParity_strength : postellParity.strength = 1 := by decide

/-- The Micah counterexample's grounds are cited `consensus` and
`wellSupported`, and its inference `plausible`. -/
theorem micahParity_strength : micahParity.strength = 1 := by decide

/-- Motyer's observations are cited `consensus` and `wellSupported`, but his
inference is `disputed`, and he is no stronger than it. -/
theorem motyerReply_strength : motyerReply.strength = 0 := by decide

/-! ### The defeats

Each is an attack the ratings do not block, decided from the two packages'
premises by `Horn.defeats?` and checked by the kernel. -/

/-- **The critical denial defeats the scriptural reading.** It entails the
negation of the premise that Isaiah 7:14 predicts a virgin birth, and that
premise, cited `disputed`, does not outrank it. -/
theorem critical_defeats_christian : Defeats criticalDenial christian :=
  Horn.defeats_of_defeats? criticalDenial_strength christian_strength (by decide +kernel)

/-- The scriptural reading does attack the critical denial: it concludes the
opposite. -/
theorem christian_rebuts_critical : Rebuts christian criticalDenial := by
  establish [Rebuts, bornOfAVirginDefs]

/-- But it undermines none of the critical denial's premises. For each of them
there is a world in which the scriptural reading holds and that premise does
too: the near-term setting and the exclusion hold where everything does, and the
exclusion step holds where Berry and Postell are right. -/
theorem christian_does_not_undermine_critical (φ : Formula Claim) :
    ¬ UnderminesOn christian criticalDenial φ := by
  rintro ⟨hmem, hent⟩
  simp only [criticalDenial, criticalExclusionLine, Line.asPackage, Line.premises,
    List.cons_append, List.nil_append, List.mem_cons, List.not_mem_nil,
    or_false] at hmem
  rcases hmem with rfl | rfl | rfl <;> revert hent
  · refute_with everythingHoldsReading [bornOfAVirginDefs]
  · refute_with everythingHoldsReading [bornOfAVirginDefs]
  · refute_with repliesStandReading [bornOfAVirginDefs]

/-- **The scriptural reading answers the critic.** Its rebuttal is a defeat:
the weakest link on each side is `disputed`, so neither outranks the other, and
each defeats the other. -/
@[headline]
theorem christian_defeats_critical : Defeats christian criticalDenial :=
  Horn.defeats_of_defeats? christian_strength criticalDenial_strength (by decide +kernel)

#print axioms christian_defeats_critical

/-- **Berry defeats the critical denial.** He entails the negation of its
premise that a near-term sign excludes a messianic sense, and that premise,
cited `disputed`, does not outrank him. -/
theorem berry_defeats_critical : Defeats berryObjection criticalDenial :=
  Horn.defeats_of_defeats? berryObjection_strength criticalDenial_strength (by decide +kernel)

/-- **Postell defeats the critical denial**, on the same premise from different
grounds. -/
theorem postell_defeats_critical : Defeats postellParity criticalDenial :=
  Horn.defeats_of_defeats? postellParity_strength criticalDenial_strength (by decide +kernel)

/-- **The Micah counterexample defeats the critical denial**, on the same
premise as Berry and Postell. -/
theorem micah_defeats_critical : Defeats micahParity criticalDenial :=
  Horn.defeats_of_defeats? micahParity_strength criticalDenial_strength (by decide +kernel)

/-- **Motyer defeats the critical denial**, by entailing the negation of its
other premise: that 7:14 is a near-term sign to Ahaz, cited `disputed`. -/
theorem motyer_defeats_critical : Defeats motyerReply criticalDenial :=
  Horn.defeats_of_defeats? motyerReply_strength criticalDenial_strength (by decide +kernel)

/-- **The critical denial defeats Berry back.** It holds the premise Berry
denies, so it rebuts him, and Berry is no stronger than it: his inference is
contested as the critic's premises are. -/
theorem critical_defeats_berry : Defeats criticalDenial berryObjection :=
  Horn.defeats_of_defeats? criticalDenial_strength berryObjection_strength (by decide +kernel)

/-- **The critical denial defeats Motyer back**, for the same reason: it holds
the near-term premise he denies, and his inference is contested by the readers
who identify the two children. -/
theorem critical_defeats_motyer : Defeats criticalDenial motyerReply :=
  Horn.defeats_of_defeats? criticalDenial_strength motyerReply_strength (by decide +kernel)

/-! ### What does not defeat -/

/-- **The critical denial does not defeat Postell.** It rebuts him, but it is
the weaker of the two: its premises are `disputed`, and his inference is
`plausible`. And it contradicts none of his premises: the critic can grant both
his observations, and can grant his step too, by dating Isaiah 9 and 11 later
than 7:14 — off its Assyrian timeline — so that one of the step's grounds
fails (`critic_grants_postells_step_by_dating_the_oracles_later`). -/
theorem critical_does_not_defeat_postell : ¬ Defeats criticalDenial postellParity :=
  Horn.not_defeats_of_defeats? criticalDenial_strength postellParity_strength (by decide +kernel)

/-- **The critical denial does not defeat the Micah counterexample**, for the
reason it does not defeat Postell: it is weaker, and it contradicts none of the
counterexample's premises. The critic can grant its step by reading Micah 5:2
of a near-term Davidic king rather than messianically
(`critic_grants_the_micah_step_by_a_royal_reading`). -/
theorem critical_does_not_defeat_micah : ¬ Defeats criticalDenial micahParity :=
  Horn.not_defeats_of_defeats? criticalDenial_strength micahParity_strength (by decide +kernel)

/-! ### Why these are not counters

The two absences above are computed; the readings below say why. -/

/-- The critic's world, with Isaiah 9 and 11 taken off the Assyrian timeline of
7:14 — the way out of the parity argument open to a reader who dates them
later. Postell's step holds in it, because one of its grounds fails. -/
def laterOraclesReading : Valuation Claim := fun a =>
  match a with
  | .isaiahPredictsVirginBirth => False
  | .isaiah9And11ShareTheAssyrianTimeline => False
  | _ => True

/-- **The critic can grant Postell's step**, by dating Isaiah 9 and 11 later than
7:14: then the parity step has a ground that fails, and the critic holds it
without giving up the exclusion. -/
theorem critic_grants_postells_step_by_dating_the_oracles_later :
    Grants criticalDenial parityDefeatsNearTermExclusion := by
  satisfied_by laterOraclesReading [Grants, bornOfAVirginDefs]

/-- The critic's world, with Micah 5:2 read of a near-term Davidic king and not
messianically. The Micah step holds in it, because one of its grounds fails. -/
def royalMicahReading : Valuation Claim := fun a =>
  match a with
  | .isaiahPredictsVirginBirth => False
  | .micahRulerReadMessianically => False
  | _ => True

/-- **The critic can grant the Micah step**, by reading Micah 5:2 of a near-term
Davidic king rather than messianically. -/
theorem critic_grants_the_micah_step_by_a_royal_reading :
    Grants criticalDenial micahParityDefeatsNearTermExclusion := by
  satisfied_by royalMicahReading [Grants, bornOfAVirginDefs]

/-! ### The dispute -/

/-- The parties to the dispute over Isaiah 7:14. -/
inductive Party
  /-- The scriptural reading. -/
  | scriptural
  /-- The critical denial of the predictive reading. -/
  | critical
  /-- Berry's objection to the near-term exclusion. -/
  | berry
  /-- Postell's parity argument against it. -/
  | postell
  /-- Motyer's reply to the near-term reading itself. -/
  | motyer
  /-- Postell's Micah counterexample to the near-term exclusion. -/
  | micah
deriving DecidableEq

/-- The package each party argues from. -/
@[bornOfAVirginDefs]
def partyNode : Party → ArgumentPackage Claim
  | .scriptural => christian
  | .critical => criticalDenial
  | .berry => berryObjection
  | .postell => postellParity
  | .motyer => motyerReply
  | .micah => micahParity

/-- The dispute over Isaiah 7:14: every party's premises have a model, every
party establishes its conclusion, and every party's inferences are rated. -/
@[bornOfAVirginDefs]
def isaiahDispute : Dispute Claim Party where
  node := partyNode
  consistent
    | .scriptural => christian_is_satisfiable
    | .critical => criticalDenial_is_satisfiable
    | .berry => berryObjection_is_satisfiable
    | .postell => postellParity_is_satisfiable
    | .motyer => motyerReply_is_satisfiable
    | .micah => micahParity_is_satisfiable
  sound
    | .scriptural => christian_establishes
    | .critical => criticalDenial_establishes
    | .berry => berryObjection_establishes
    | .postell => postellParity_establishes
    | .motyer => motyerReply_establishes
    | .micah => micahParity_establishes
  rated i := by
    cases i <;> simp [bornOfAVirginDefs, Line.asPackage]

/-- **The scriptural reading and all four replies stand together**, in the
world Motyer describes: none of the five defeats another. One fact, settling
twenty ordered pairs. -/
theorem replies_stand_with_the_scriptural_reading :
    isaiahDispute.StandTogether [.scriptural, .berry, .postell, .motyer, .micah] := by
  satisfied_by motyerReading [Dispute.StandTogether, bornOfAVirginDefs]

/-- The defeats of the dispute, as a table. -/
def partyDefeats : Party → Party → Prop
  | .critical, .scriptural => True
  | .scriptural, .critical => True
  | .berry, .critical => True
  | .postell, .critical => True
  | .motyer, .critical => True
  | .micah, .critical => True
  | .critical, .berry => True
  | .critical, .motyer => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel partyDefeats := fun i j => by
  cases i <;> cases j <;> unfold partyDefeats <;> infer_instance

/-- Each party's weakest link. -/
@[bornOfAVirginDefs]
def partyStrength : Party → ℕ
  | .postell => 1
  | .micah => 1
  | _ => 0

/-- Each party's strength is what `partyStrength` says. -/
theorem partyNode_strength : ∀ i, (partyNode i).strength = partyStrength i
  | .scriptural => christian_strength
  | .critical => criticalDenial_strength
  | .berry => berryObjection_strength
  | .postell => postellParity_strength
  | .motyer => motyerReply_strength
  | .micah => micahParity_strength

/-- **Who defeats whom**, all thirty-six pairs: the critic and the scriptural
reading defeat each other; each reply defeats the critic; the critic defeats
Berry and Motyer back, but neither of Postell's counterexamples; nothing
else.

Every cell is computed from the parties' premises by `Horn.defeats?` and
checked by the kernel; the table is what the computation is checked
against. -/
theorem isaiahDispute_defeats : ∀ i j, isaiahDispute.defeats i j ↔ partyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (partyNode_strength i) (partyNode_strength j) ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute in the form the verdict solver computes with. -/
def isaiahFinite : Solver.Finite isaiahDispute.defeats where
  parties := [.scriptural, .critical, .berry, .postell, .motyer, .micah]
  complete i := by cases i <;> decide
  defeats i j := decide (partyDefeats i j)
  spec i j := by rw [isaiahDispute_defeats]; simp

/-- How the scriptural reading prevails, in stages: nothing attacks Postell's
two counterexamples, so they come first; they answer the critic, the only party
that attacks the scriptural reading, Berry and Motyer, so those three come next.
-/
def repliesHeardInStages : List (List Party) :=
  [[.postell, .micah], [.scriptural, .berry, .motyer]]

/-- And why the critic does not join them: the scriptural reading attacks it,
and nothing among the five answers the scriptural reading. -/
def criticLeftUnanswered : Witness.Table Party := [(.critical, .scriptural)]

/-- **Heard out, the scriptural reading prevails.** Nothing defeats either of
Postell's counterexamples, so both are in the grounded extension from the first
step. They defeat the critic — the only party that defeats the scriptural
reading, Berry or Motyer — so at the second step all three join them; and
nothing defends the critic. -/
@[headline]
theorem scriptural_reading_prevails_once_replies_are_heard :
    grounded isaiahDispute.defeats =
      {.scriptural, .berry, .postell, .motyer, .micah} :=
  (Witness.grounded_eq_of_witness (F := isaiahFinite) (sts := repliesHeardInStages)
    (t := criticLeftUnanswered) (by decide +kernel)).trans
    (by ext x; cases x <;> simp [repliesHeardInStages])

#print axioms scriptural_reading_prevails_once_replies_are_heard

/-- Why the critical denial cannot be defended: Postell attacks it, and nothing
answers Postell. -/
def criticAnsweredByPostell : Witness.Table Party := [(.critical, .postell)]

/-- **The critical denial cannot be defended.** No admissible set contains it:
Postell defeats it, and nothing defeats Postell. -/
@[headline]
theorem critical_denial_indefensible (S : Set Party)
    (hS : Admissible isaiahDispute.defeats S) : Party.critical ∉ S :=
  Witness.not_mem_admissible_of_witness (F := isaiahFinite) (t := criticAnsweredByPostell)
    (by decide +kernel) S hS

#print axioms critical_denial_indefensible

/-- So every resolution of the dispute accepts the scriptural reading. -/
theorem scriptural_reading_skeptically_accepted :
    SkepticallyAccepted isaiahDispute.defeats .scriptural :=
  .of_grounded (by rw [scriptural_reading_prevails_once_replies_are_heard]; simp)

/-- And none accepts the critical denial. -/
theorem critical_denial_not_credulously_accepted :
    ¬ CredulouslyAccepted isaiahDispute.defeats .critical :=
  fun ⟨S, hS, hc⟩ => critical_denial_indefensible S hS.1 hc

/-! ### Hearings

The same dispute with some parties not heard. Each hearing is a restriction of
`isaiahDispute`, so its defeats are the ones already proved. In each of these,
every party has a defeater, and so nothing prevails. -/

/-- The scriptural reading and the critic alone. -/
abbrev unanswered := isaiahDispute.restrict (· ∈ [Party.scriptural, .critical])

/-- **Unanswered, nothing prevails.** The scriptural reading and the critical
denial defeat each other, so neither is forced, and the grounded extension is
empty. -/
@[headline]
theorem nothing_prevails_unanswered : grounded unanswered.defeats = ∅ :=
  Witness.grounded_eq_empty
    (F := isaiahFinite.restrict (· ∈ [Party.scriptural, .critical]))
    (t := Witness.Table.sub _ [(.scriptural, .critical), (.critical, .scriptural)])
    (by decide +kernel)

#print axioms nothing_prevails_unanswered

/-- The scriptural reading, the critic, and Motyer. -/
abbrev motyerAlone := isaiahDispute.restrict (· ∈ [Party.scriptural, .critical, .motyer])

/-- **Motyer alone does not settle it.** He and the critic defeat each other, as
the scriptural reading and the critic do, so nothing is forced. His inference is
contested as the critic's premises are, and a contested reply cannot carry the
verdict alone. -/
@[headline]
theorem nothing_prevails_on_motyer_alone : grounded motyerAlone.defeats = ∅ :=
  Witness.grounded_eq_empty
    (F := isaiahFinite.restrict (· ∈ [Party.scriptural, .critical, .motyer]))
    (t := Witness.Table.sub _
      [(.scriptural, .critical), (.critical, .scriptural), (.motyer, .critical)])
    (by decide +kernel)

#print axioms nothing_prevails_on_motyer_alone

/-- Every party but Postell's Isaiah counterexample. -/
abbrev withoutPostell := isaiahDispute.restrict (· ≠ Party.postell)

/-- **Without Postell's Isaiah argument, the scriptural reading still
prevails.** His Micah counterexample is defeated by nothing, and it defends the
scriptural reading against the critic, as the Isaiah argument did. An attack on
the grounds of either counterexample leaves the verdict standing. -/
@[headline]
theorem scriptural_reading_prevails_without_postell :
    (⟨.scriptural, by decide⟩ : {i // i ≠ Party.postell}) ∈
      grounded withoutPostell.defeats :=
  Witness.mem_grounded_of_stages (F := isaiahFinite.restrict (· ≠ Party.postell))
    (sts := [Witness.listSub _ [.micah], Witness.listSub _ [.scriptural, .berry, .motyer]])
    (by decide +kernel) (by decide)

#print axioms scriptural_reading_prevails_without_postell

/-- Every party but the two counterexamples. -/
abbrev withoutParity :=
  isaiahDispute.restrict (· ∉ [Party.postell, .micah])

/-- **Without the counterexamples, nothing prevails.** Berry and Motyer each tie
with the critic, as the scriptural reading does, so every party is defeated by
someone. The verdict rests on the one kind of reply the critic cannot answer —
an oracle on the Assyrian timeline, read messianically — and so on the rating
of that inference. -/
@[headline]
theorem nothing_prevails_without_the_counterexamples :
    grounded withoutParity.defeats = ∅ :=
  Witness.grounded_eq_empty (F := isaiahFinite.restrict (· ∉ [Party.postell, .micah]))
    (t := Witness.Table.sub _
      [(.scriptural, .critical), (.critical, .scriptural), (.berry, .critical),
        (.motyer, .critical)])
    (by decide +kernel)

#print axioms nothing_prevails_without_the_counterexamples

end Testimony.Arguments.BornOfAVirgin
