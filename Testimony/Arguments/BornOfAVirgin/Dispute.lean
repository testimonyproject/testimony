import Testimony.Arguments.BornOfAVirgin.Results
import Testimony.Logic.Dispute

/-!
# Arguments.BornOfAVirgin.Dispute — who prevails over Isaiah 7:14

The results in `Results.lean` ask what each package entails. This module asks
what happens when the packages meet: the scriptural reading, the critical
denial of the predictive reading, and three replies to that denial — Berry's
objection, Postell's parity argument, and Motyer's reply, with Compton's —
taken together as one dispute.

Who defeats whom is not stipulated. Each defeat below is a theorem about the
packages' premises, and so is each absence of one (see `Testimony.Logic.Dispute`
for how an attack is derived from entailment and filtered by cited confidence).
The defeats, all four proved, are these:

- **The critical denial defeats the scriptural reading.** It entails the
  negation of the scriptural premise that Isaiah 7:14 predicts a virgin birth,
  a premise cited as `disputed`.
- **The scriptural reading defeats the critical denial back.** It undermines
  none of the critic's premises, but it concludes the opposite, so it rebuts;
  and the weakest link on each side is `disputed`, so neither outranks the
  other.
- **Berry and Postell each defeat the critical denial**, by contradicting its
  premise that a near-term sign excludes a messianic sense, cited `disputed`.
- **Motyer defeats it too**, by contradicting its other premise: that 7:14 is
  a near-term sign to Ahaz at all, also cited `disputed`.
- **The critical denial defeats Berry and Motyer back, but not Postell.** It
  rebuts all three. Berry's and Motyer's inferences are contested — a cited
  source grants each one's grounds and denies its conclusion — so they are no
  stronger than the critic. Postell's inference is not, and he outranks it.

## What follows

Faced with the scriptural reading alone, **nothing prevails**: the two defeat
each other, and the grounded extension is empty. Add the replies and **the
scriptural reading prevails**. Nothing defeats Postell; he defeats the critic,
which is the only party that defeats the scriptural reading, Berry or Motyer;
and so all four stand. The critical denial belongs to no admissible set at all,
because nothing answers Postell. Take Postell away and nothing prevails again.

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
two oracles on the same Assyrian timeline, read messianically — and no source
cited here grants his grounds and keeps the exclusion. **The verdict rests on
that rating.** Without Postell, every party is defeated by someone and nothing
prevails (`nothing_prevails_without_postell`); and rated `disputed`, his
inference would tie him with the critic as Berry's and Motyer's do. A critic
who granted that Isaiah 9 and 11 are messianic on the Assyrian timeline, and
still held the exclusion, would be the source to find. Postell's argument is
described in `Lines.lean` as the stronger of the two; the ratings now register
that, and it is what decides the dispute.

## What the church fathers add, and what they cannot

The predictive reading is not a modern apologetic. Justin, Irenaeus, Origen and
Jerome all argue it, and `Sources.lean` cites them for it: for the
prediction itself, for עַלְמָה as a virgin, and — the argument they share —
that an ordinary conception would have been no sign at all. That strengthens
the attestation of the scriptural premises, and none of it changes a rating.

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
  establish [berryObjection, berryLine, berryBlocksExclusion]

/-- Berry's objection has a model. -/
theorem berryObjection_is_satisfiable : Satisfiable berryObjection.premises := by
  satisfied_by repliesStandReading [berryObjection, berryLine, berryBlocksExclusion]

/-- Postell's parity argument delivers its conclusion. -/
theorem postellParity_establishes : Establishes postellParity := by
  establish [postellParity, postellLine, parityDefeatsNearTermExclusion]

/-- Postell's parity argument has a model. -/
theorem postellParity_is_satisfiable : Satisfiable postellParity.premises := by
  satisfied_by repliesStandReading [postellParity, postellLine,
    parityDefeatsNearTermExclusion]

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
  refute_with sameChildReading [motyerLine]

#print axioms motyer_rests_on_his_inference

/-- The world Motyer describes, with Berry and Postell: the sign is not a
near-term one, and a near-term sign would not exclude a messianic sense anyway.
Everything else holds — the scriptural reading and all three replies with it. -/
def motyerReading : Valuation Claim := fun a =>
  match a with
  | .isaiahIsNearTermSignToAhaz => False
  | .nearTermExcludesMessianicSense => False
  | _ => True

/-- Motyer's reply delivers its conclusion. -/
theorem motyerReply_establishes : Establishes motyerReply := by
  establish [motyerReply, motyerLine, timetablePassesToMaherShalalHashBaz]

/-- Motyer's reply has a model. -/
theorem motyerReply_is_satisfiable : Satisfiable motyerReply.premises := by
  satisfied_by motyerReading [motyerReply, motyerLine,
    timetablePassesToMaherShalalHashBaz]

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

/-- Motyer's observations are cited `consensus` and `wellSupported`, but his
inference is `disputed`, and he is no stronger than it. -/
theorem motyerReply_strength : motyerReply.strength = 0 := by decide

/-! ### The defeats

Each is an attack the ratings do not block, proved by the attack and the
comparison of strengths. -/

/-- **The critical denial defeats the scriptural reading.** It entails the
negation of the premise that Isaiah 7:14 predicts a virgin birth, and that
premise, cited `disputed`, does not outrank it. -/
theorem critical_defeats_christian : Defeats criticalDenial christian :=
  .inl ⟨p .isaiahPredictsVirginBirth,
    ⟨by simp [christian, scripturalLines, isaianicLine, caseOf],
      criticalDenial_establishes⟩,
    by decide⟩

/-- The scriptural reading does attack the critical denial: it concludes the
opposite. -/
theorem christian_rebuts_critical : Rebuts christian criticalDenial := by
  establish [Rebuts, criticalDenial, criticalExclusionLine, Line.asPackage, christian,
    scripturalLines, isaianicLine, protoevangeliumLine, micheanLine, compositionalLine,
    sharedGrounds, toCriterion, genesisToCriterion, micahToCriterion,
    compositionalToCriterion, toFulfilment]

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
  · refute_with everythingHoldsReading [christian, scripturalLines,
    isaianicLine, protoevangeliumLine, micheanLine, compositionalLine, sharedGrounds,
    toCriterion, genesisToCriterion, micahToCriterion, compositionalToCriterion,
    toFulfilment]
  · refute_with everythingHoldsReading [christian, scripturalLines,
    isaianicLine, protoevangeliumLine, micheanLine, compositionalLine, sharedGrounds,
    toCriterion, genesisToCriterion, micahToCriterion, compositionalToCriterion,
    toFulfilment]
  · refute_with repliesStandReading [christian, scripturalLines,
    isaianicLine, protoevangeliumLine, micheanLine, compositionalLine, sharedGrounds,
    toCriterion, genesisToCriterion, micahToCriterion, compositionalToCriterion,
    toFulfilment, criticalExclusion]

/-- **The scriptural reading answers the critic.** Its rebuttal is a defeat:
the weakest link on each side is `disputed`, so neither outranks the other, and
each defeats the other. -/
@[headline]
theorem christian_defeats_critical : Defeats christian criticalDenial :=
  .inr ⟨christian_rebuts_critical,
    by rw [christian_strength, criticalDenial_strength]; decide⟩

#print axioms christian_defeats_critical

/-- **Berry defeats the critical denial.** He entails the negation of its
premise that a near-term sign excludes a messianic sense, and that premise,
cited `disputed`, does not outrank him. -/
theorem berry_defeats_critical : Defeats berryObjection criticalDenial :=
  .inl ⟨p .nearTermExcludesMessianicSense,
    ⟨by simp [criticalDenial, criticalExclusionLine, Line.asPackage, Line.premises],
      berryObjection_establishes⟩,
    by decide⟩

/-- **Postell defeats the critical denial**, on the same premise from different
grounds. -/
theorem postell_defeats_critical : Defeats postellParity criticalDenial :=
  .inl ⟨p .nearTermExcludesMessianicSense,
    ⟨by simp [criticalDenial, criticalExclusionLine, Line.asPackage, Line.premises],
      postellParity_establishes⟩,
    by decide⟩

/-- **Motyer defeats the critical denial**, by entailing the negation of its
other premise: that 7:14 is a near-term sign to Ahaz, cited `disputed`. -/
theorem motyer_defeats_critical : Defeats motyerReply criticalDenial :=
  .inl ⟨p .isaiahIsNearTermSignToAhaz,
    ⟨by simp [criticalDenial, criticalExclusionLine, Line.asPackage, Line.premises],
      motyerReply_establishes⟩,
    by decide⟩

/-- **The critical denial defeats Berry back.** It holds the premise Berry
denies, so it rebuts him, and Berry is no stronger than it: his inference is
contested as the critic's premises are. -/
theorem critical_defeats_berry : Defeats criticalDenial berryObjection :=
  .inr ⟨by establish [Rebuts, criticalDenial, berryObjection, criticalExclusionLine,
      berryLine, criticalExclusion],
    by rw [criticalDenial_strength, berryObjection_strength]; decide⟩

/-- **The critical denial defeats Motyer back**, for the same reason: it holds
the near-term premise he denies, and his inference is contested by the readers
who identify the two children. -/
theorem critical_defeats_motyer : Defeats criticalDenial motyerReply :=
  .inr ⟨by establish [Rebuts, criticalDenial, motyerReply, criticalExclusionLine,
      motyerLine, criticalExclusion],
    by rw [criticalDenial_strength, motyerReply_strength]; decide⟩

/-! ### What does not defeat -/

/-- The critic's world, with Isaiah 9 and 11 taken off the Assyrian timeline of
7:14 — the way out of the parity argument open to a reader who dates them
later. Postell's step holds in it, because one of its grounds fails. -/
def laterOraclesReading : Valuation Claim := fun a =>
  match a with
  | .isaiahPredictsVirginBirth => False
  | .isaiah9And11ShareTheAssyrianTimeline => False
  | _ => True

/-- **The critical denial does not defeat Postell.** It rebuts him, but it is
the weaker of the two: its premises are `disputed`, and his inference is
`plausible`. And it contradicts none of his premises: the critical reading
grants both his observations, and the later-oracles reading his step. -/
theorem critical_does_not_defeat_postell : ¬ Defeats criticalDenial postellParity := by
  refine not_defeats_of_outweighed
    (by rw [criticalDenial_strength, postellParity_strength]; decide) ?_
  intro φ hφ
  simp only [postellParity, postellLine, Line.asPackage, Line.premises,
    List.cons_append, List.nil_append, List.mem_cons, List.not_mem_nil,
    or_false] at hφ
  rcases hφ with rfl | rfl | rfl
  · satisfied_by criticalReading [criticalDenial, criticalExclusionLine, criticalExclusion]
  · satisfied_by criticalReading [criticalDenial, criticalExclusionLine, criticalExclusion]
  · satisfied_by laterOraclesReading [criticalDenial, criticalExclusionLine,
      criticalExclusion, parityDefeatsNearTermExclusion]

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
deriving DecidableEq

/-- A statement about every party is a statement about each of the five. -/
theorem Party.forall_iff {P : Party → Prop} :
    (∀ x, P x) ↔ P .scriptural ∧ P .critical ∧ P .berry ∧ P .postell ∧ P .motyer :=
  ⟨fun h => ⟨h _, h _, h _, h _, h _⟩,
    fun ⟨h₁, h₂, h₃, h₄, h₅⟩ x => by cases x <;> assumption⟩

/-- Some party satisfies `P` just when one of the five does. -/
theorem Party.exists_iff {P : Party → Prop} :
    (∃ x, P x) ↔ P .scriptural ∨ P .critical ∨ P .berry ∨ P .postell ∨ P .motyer := by
  constructor
  · rintro ⟨x, hx⟩
    cases x <;> simp_all
  · rintro (h | h | h | h | h) <;> exact ⟨_, h⟩

/-- The package each party argues from. -/
def partyNode : Party → ArgumentPackage Claim
  | .scriptural => christian
  | .critical => criticalDenial
  | .berry => berryObjection
  | .postell => postellParity
  | .motyer => motyerReply

/-- The dispute over Isaiah 7:14: every party's premises have a model, every
party establishes its conclusion, and every party's inferences are rated. -/
def isaiahDispute : Dispute Claim Party where
  node := partyNode
  consistent
    | .scriptural => christian_is_satisfiable
    | .critical => criticalDenial_is_satisfiable
    | .berry => berryObjection_is_satisfiable
    | .postell => postellParity_is_satisfiable
    | .motyer => motyerReply_is_satisfiable
  sound
    | .scriptural => christian_establishes
    | .critical => criticalDenial_establishes
    | .berry => berryObjection_establishes
    | .postell => postellParity_establishes
    | .motyer => motyerReply_establishes
  rated i := by
    cases i <;> simp [partyNode, christian, criticalDenial, criticalExclusionLine,
      berryObjection, berryLine, postellParity, postellLine, motyerReply, motyerLine,
      Line.asPackage]

/-- **The scriptural reading and all three replies stand together**, in the
world Motyer describes: none of the four defeats another. One fact, settling
twelve ordered pairs. -/
theorem replies_stand_with_the_scriptural_reading :
    isaiahDispute.StandTogether [.scriptural, .berry, .postell, .motyer] := by
  satisfied_by motyerReading [Dispute.StandTogether, isaiahDispute, partyNode,
    berryObjection, berryLine, berryBlocksExclusion, postellParity, postellLine,
    parityDefeatsNearTermExclusion, motyerReply, motyerLine,
    timetablePassesToMaherShalalHashBaz, christian, scripturalLines,
    isaianicLine, protoevangeliumLine, micheanLine, compositionalLine, sharedGrounds,
    toCriterion, genesisToCriterion, micahToCriterion, compositionalToCriterion,
    toFulfilment]

/-- The defeats of the dispute, as a table. -/
def partyDefeats : Party → Party → Prop
  | .critical, .scriptural => True
  | .scriptural, .critical => True
  | .berry, .critical => True
  | .postell, .critical => True
  | .motyer, .critical => True
  | .critical, .berry => True
  | .critical, .motyer => True
  | _, _ => False

/-- **Who defeats whom**, all twenty-five pairs: the critic and the scriptural
reading defeat each other; each reply defeats the critic; the critic defeats
Berry and Motyer back, but not Postell; nothing else. -/
theorem isaiahDispute_defeats : ∀ i j, isaiahDispute.defeats i j ↔ partyDefeats i j := by
  defeat_table [partyDefeats] using [critical_defeats_christian, christian_defeats_critical,
    berry_defeats_critical, postell_defeats_critical, motyer_defeats_critical,
    critical_defeats_berry, critical_defeats_motyer, critical_does_not_defeat_postell,
    replies_stand_with_the_scriptural_reading]

/-- **Heard out, the scriptural reading prevails.** Nothing defeats Postell, so
he is in the grounded extension from the first step. He defeats the critic —
the only party that defeats the scriptural reading, Berry or Motyer — so at the
second step all three join him; and nothing defends the critic. -/
@[headline]
theorem scriptural_reading_prevails_once_replies_are_heard :
    grounded isaiahDispute.defeats = {.scriptural, .berry, .postell, .motyer} := by
  grounded_by 2 [isaiahDispute_defeats, partyDefeats, Party.forall_iff, Party.exists_iff]

#print axioms scriptural_reading_prevails_once_replies_are_heard

/-- **The critical denial cannot be defended.** No admissible set contains it:
Postell defeats it, and nothing defeats Postell. -/
@[headline]
theorem critical_denial_indefensible (S : Set Party)
    (hS : Admissible isaiahDispute.defeats S) : Party.critical ∉ S := by
  intro hc
  obtain ⟨c, _, hcb⟩ := hS.2 _ hc .postell ((isaiahDispute_defeats _ _).mpr trivial)
  rw [isaiahDispute_defeats] at hcb
  cases c <;> exact hcb

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
  grounded_eq_empty_of_attacked fun ⟨a, ha⟩ => by
    cases a <;> simp at ha
    · exact ⟨⟨.critical, by simp⟩, (isaiahDispute_defeats _ _).mpr trivial⟩
    · exact ⟨⟨.scriptural, by simp⟩, (isaiahDispute_defeats _ _).mpr trivial⟩

#print axioms nothing_prevails_unanswered

/-- The scriptural reading, the critic, and Motyer. -/
abbrev motyerAlone := isaiahDispute.restrict (· ∈ [Party.scriptural, .critical, .motyer])

/-- **Motyer alone does not settle it.** He and the critic defeat each other, as
the scriptural reading and the critic do, so nothing is forced. His inference is
contested as the critic's premises are, and a contested reply cannot carry the
verdict alone. -/
@[headline]
theorem nothing_prevails_on_motyer_alone : grounded motyerAlone.defeats = ∅ :=
  grounded_eq_empty_of_attacked fun ⟨a, ha⟩ => by
    cases a <;> simp at ha
    · exact ⟨⟨.critical, by simp⟩, (isaiahDispute_defeats _ _).mpr trivial⟩
    · exact ⟨⟨.motyer, by simp⟩, (isaiahDispute_defeats _ _).mpr trivial⟩
    · exact ⟨⟨.critical, by simp⟩, (isaiahDispute_defeats _ _).mpr trivial⟩

#print axioms nothing_prevails_on_motyer_alone

/-- Every party but Postell. -/
abbrev withoutPostell := isaiahDispute.restrict (· ≠ Party.postell)

/-- **Without Postell, nothing prevails.** Berry and Motyer each tie with the
critic, as the scriptural reading does, so every party is defeated by someone.
The verdict rests on the one reply the critic cannot answer. -/
@[headline]
theorem nothing_prevails_without_postell : grounded withoutPostell.defeats = ∅ :=
  grounded_eq_empty_of_attacked fun ⟨a, ha⟩ => by
    cases a
    · exact ⟨⟨.critical, by decide⟩, (isaiahDispute_defeats _ _).mpr trivial⟩
    · exact ⟨⟨.scriptural, by decide⟩, (isaiahDispute_defeats _ _).mpr trivial⟩
    · exact ⟨⟨.critical, by decide⟩, (isaiahDispute_defeats _ _).mpr trivial⟩
    · exact absurd rfl ha
    · exact ⟨⟨.critical, by decide⟩, (isaiahDispute_defeats _ _).mpr trivial⟩

#print axioms nothing_prevails_without_postell

end Testimony.Arguments.BornOfAVirgin
