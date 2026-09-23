import Testimony.Arguments.BornOfAVirgin.Results
import Testimony.Logic.Dispute

/-!
# Arguments.BornOfAVirgin.Dispute — who prevails over Isaiah 7:14

The results in `Results.lean` ask what each package entails. This module asks
what happens when the packages meet: the scriptural reading, the critical
denial of the predictive reading, and the two replies to that denial — Berry's
objection and Postell's parity argument — taken together as one dispute.

Who defeats whom is not stipulated. Each defeat below is a theorem about the
packages' premises, and so is each absence of one (see `Testimony.Logic.Dispute`
for how an attack is derived from entailment and filtered by cited confidence).
The defeats, all four proved, are these:

- **The critical denial defeats the scriptural reading.** It entails the
  negation of the scriptural premise that Isaiah 7:14 predicts a virgin birth,
  a premise cited as `disputed`.
- **The scriptural reading defeats the critical denial back.** It undermines
  none of the critic's premises, but it concludes the opposite, so it rebuts;
  and the weakest premise on each side is cited `disputed`, so neither
  outranks the other.
- **Berry and Postell each defeat the critical denial**, by contradicting its
  premise that a near-term sign excludes a messianic sense, cited `disputed`.
- **The critical denial does not defeat either of them.** It rebuts both, but
  both of its premises are cited `disputed` and theirs `wellSupported`. It
  contradicts nothing they rest on.

## What follows

Faced with the scriptural reading alone, **nothing prevails**: the two defeat
each other, the grounded extension is empty, and each is a resolution of the
exchange on its own. Add Berry and Postell and **the scriptural reading
prevails**. The replies are defeated by nothing, they defeat the critic, and in
doing so they defend the scriptural reading against its only defeater: the
grounded extension is the scriptural reading with both replies. The critical
denial belongs to no admissible set at all, because nothing answers Berry.

This is the result entailment could not state. Adding premises never removes a
conclusion; adding arguments can change what a dispute forces, and here it
turns an open question into a settled one. The replies do not show that the
predictive reading is true. They show that, on these premises and these
ratings, the case against it does not survive them.

## What the ratings decide

These outcomes rest on the cited confidences as much as on the premises. The
premise that decides the exchange with the critic — that a near-term sign
excludes a messianic sense — was once cited `wellSupported` on Brown's
authority. So rated, the critic defeated both replies back, and the dispute
ended in a standoff with two resolutions. It is cited `disputed` because Berry,
Postell and Motyer contest it, and this argument records the contest in its own
lines: the rating follows the library's definition, not the result.

What the result now rests on are the replies' own ratings. Berry's premise, that
how the sign was fulfilled in Ahaz's day is an open question, and Postell's two
observations about Isaiah 9 and 11 are all cited `wellSupported`. Rate them
`disputed` and the replies and the critic would tie, and the standoff would
return. Postell's argument is described in `Lines.lean` as the stronger of the
two; the ratings do not register that, and do not need to. Every rating here is
a premise of the result, and contesting one is contesting the result.

The critic's other premise, that 7:14 was a near-term sign to Ahaz fulfilled in
Isaiah's generation, is cited `disputed` on the same definition: Motyer and
Compton deny it outright. That rating decides nothing in this dispute, where
the critic is already as weak as a position can be. It would decide a dispute
in which a reply attacked that premise, as Motyer's would: rated
`wellSupported`, the premise would outrank such a reply and the attack would
fail.

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
too, which is what the joint-model results below use it for. -/
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

/-! ### Strength: the weakest link of each position -/

/-- The scriptural reading is no stronger than its least supported premise,
which is cited `disputed`. -/
theorem christian_strength : christian.strength = 0 := by decide

/-- Both of the critical denial's premises are contested, and cited
`disputed`. -/
theorem criticalDenial_strength : criticalDenial.strength = 0 := by decide

/-- Berry's one ranked premise is cited `wellSupported`. -/
theorem berryObjection_strength : berryObjection.strength = 2 := by decide

/-- Both of Postell's ranked premises are cited `wellSupported`. -/
theorem postellParity_strength : postellParity.strength = 2 := by decide

/-! ### Who defeats whom -/

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
  establish [Rebuts, christian, criticalDenial, criticalExclusionLine, Line.asPackage,
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
  · refute_with everythingHoldsReading [christian, scripturalLines, isaianicLine,
      protoevangeliumLine, micheanLine, compositionalLine, sharedGrounds, toCriterion,
      genesisToCriterion, micahToCriterion, compositionalToCriterion, toFulfilment]
  · refute_with everythingHoldsReading [christian, scripturalLines, isaianicLine,
      protoevangeliumLine, micheanLine, compositionalLine, sharedGrounds, toCriterion,
      genesisToCriterion, micahToCriterion, compositionalToCriterion, toFulfilment]
  · refute_with repliesStandReading [christian, scripturalLines, isaianicLine,
      protoevangeliumLine, micheanLine, compositionalLine, sharedGrounds, toCriterion,
      genesisToCriterion, micahToCriterion, compositionalToCriterion, toFulfilment,
      criticalExclusion]

/-- **The scriptural reading answers the critic.** Its rebuttal is a defeat:
the weakest premise on each side is cited `disputed`, so neither outranks the
other, and each defeats the other. -/
@[headline]
theorem christian_defeats_critical : Defeats christian criticalDenial :=
  .inr ⟨christian_rebuts_critical,
    by rw [christian_strength, criticalDenial_strength]; decide⟩

#print axioms christian_defeats_critical

/-- **Berry defeats the critical denial.** He entails the negation of its
premise that a near-term sign excludes a messianic sense, and that premise, cited
`disputed`, does not outrank him. -/
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

/-- The critic's world, with the near-term fulfilment taken as settled: the sign
was given to Ahaz, was discharged in his day, and excludes anything further.
Berry's step holds in it, because its antecedent fails. -/
def settledFulfilmentReading : Valuation Claim := fun a =>
  match a with
  | .isaiahPredictsVirginBirth => False
  | .nearTermFulfilmentIsUnclear => False
  | _ => True

/-- The critic's world, with Isaiah 9 and 11 taken off the Assyrian timeline of
7:14 — the way out of the parity argument open to a reader who dates them
later. Postell's step holds in it, because one of its grounds fails. -/
def laterOraclesReading : Valuation Claim := fun a =>
  match a with
  | .isaiahPredictsVirginBirth => False
  | .isaiah9And11ShareTheAssyrianTimeline => False
  | _ => True

/-- **The critical denial does not defeat Berry.** It rebuts him, but it is the
weaker of the two: its premises are cited `disputed`, below his. And it
contradicts nothing he rests on — the critical reading grants his premise, and
the settled-fulfilment reading his step. -/
theorem critical_does_not_defeat_berry : ¬ Defeats criticalDenial berryObjection := by
  rintro (⟨φ, ⟨hmem, hent⟩, _⟩ | ⟨_, hweak⟩)
  · simp only [berryObjection, berryLine, Line.asPackage, Line.premises,
      List.cons_append, List.nil_append, List.mem_cons, List.not_mem_nil,
      or_false] at hmem
    rcases hmem with rfl | rfl <;> revert hent
    · refute_with criticalReading [criticalDenial, criticalExclusionLine,
        criticalExclusion]
    · refute_with settledFulfilmentReading [criticalDenial, criticalExclusionLine,
        criticalExclusion, berryBlocksExclusion]
  · exact hweak (by rw [criticalDenial_strength, berryObjection_strength]; decide)

/-- **The critical denial does not defeat Postell**, for the same reason: it is
weaker, and it contradicts none of his premises. -/
theorem critical_does_not_defeat_postell : ¬ Defeats criticalDenial postellParity := by
  rintro (⟨φ, ⟨hmem, hent⟩, _⟩ | ⟨_, hweak⟩)
  · simp only [postellParity, postellLine, Line.asPackage, Line.premises,
      List.cons_append, List.nil_append, List.mem_cons, List.not_mem_nil,
      or_false] at hmem
    rcases hmem with rfl | rfl | rfl <;> revert hent
    · refute_with criticalReading [criticalDenial, criticalExclusionLine,
        criticalExclusion]
    · refute_with criticalReading [criticalDenial, criticalExclusionLine,
        criticalExclusion]
    · refute_with laterOraclesReading [criticalDenial, criticalExclusionLine,
        criticalExclusion, parityDefeatsNearTermExclusion]
  · exact hweak (by rw [criticalDenial_strength, postellParity_strength]; decide)

/-! ### Who does not defeat whom

The scriptural reading, Berry and Postell can all be held at once, in the world
`repliesStandReading` describes, so none of them attacks another. Each result
below names that world. -/

/-- The scriptural reading and Berry stand together. -/
theorem christian_does_not_defeat_berry : ¬ Defeats christian berryObjection :=
  not_defeats_of_joint_model (by
    satisfied_by repliesStandReading [christian, berryObjection, berryLine,
      berryBlocksExclusion, scripturalLines, isaianicLine, protoevangeliumLine,
      micheanLine, compositionalLine, sharedGrounds, toCriterion, genesisToCriterion,
      micahToCriterion, compositionalToCriterion, toFulfilment])

/-- Berry and the scriptural reading stand together. -/
theorem berry_does_not_defeat_christian : ¬ Defeats berryObjection christian :=
  not_defeats_of_joint_model (by
    satisfied_by repliesStandReading [christian, berryObjection, berryLine,
      berryBlocksExclusion, scripturalLines, isaianicLine, protoevangeliumLine,
      micheanLine, compositionalLine, sharedGrounds, toCriterion, genesisToCriterion,
      micahToCriterion, compositionalToCriterion, toFulfilment])

/-- The scriptural reading and Postell stand together. -/
theorem christian_does_not_defeat_postell : ¬ Defeats christian postellParity :=
  not_defeats_of_joint_model (by
    satisfied_by repliesStandReading [christian, postellParity, postellLine,
      parityDefeatsNearTermExclusion, scripturalLines, isaianicLine, protoevangeliumLine,
      micheanLine, compositionalLine, sharedGrounds, toCriterion, genesisToCriterion,
      micahToCriterion, compositionalToCriterion, toFulfilment])

/-- Postell and the scriptural reading stand together. -/
theorem postell_does_not_defeat_christian : ¬ Defeats postellParity christian :=
  not_defeats_of_joint_model (by
    satisfied_by repliesStandReading [christian, postellParity, postellLine,
      parityDefeatsNearTermExclusion, scripturalLines, isaianicLine, protoevangeliumLine,
      micheanLine, compositionalLine, sharedGrounds, toCriterion, genesisToCriterion,
      micahToCriterion, compositionalToCriterion, toFulfilment])

/-- Berry and Postell stand together: they are two routes to one conclusion. -/
theorem berry_does_not_defeat_postell : ¬ Defeats berryObjection postellParity :=
  not_defeats_of_joint_model (by
    satisfied_by repliesStandReading [berryObjection, berryLine, berryBlocksExclusion,
      postellParity, postellLine, parityDefeatsNearTermExclusion])

/-- Postell and Berry stand together. -/
theorem postell_does_not_defeat_berry : ¬ Defeats postellParity berryObjection :=
  not_defeats_of_joint_model (by
    satisfied_by repliesStandReading [berryObjection, berryLine, berryBlocksExclusion,
      postellParity, postellLine, parityDefeatsNearTermExclusion])

/-! ### The exchange: the scriptural reading against the critic

Before either reply is heard, the dispute has two parties. -/

/-- The two parties before the replies are heard. -/
inductive Exchange
  /-- The scriptural reading. -/
  | scriptural
  /-- The critical denial of the predictive reading. -/
  | critical
deriving DecidableEq

/-- The package each party of the exchange argues from. -/
def exchangeNode : Exchange → ArgumentPackage Claim
  | .scriptural => christian
  | .critical => criticalDenial

/-- Each party's premises can hold together. -/
theorem exchangeNode_consistent : ∀ i, Satisfiable (exchangeNode i).premises
  | .scriptural => christian_is_satisfiable
  | .critical => criticalDenial_is_satisfiable

/-- Each party establishes its conclusion. -/
theorem exchangeNode_sound : ∀ i, Establishes (exchangeNode i)
  | .scriptural => christian_establishes
  | .critical => criticalDenial_establishes

/-- The exchange as a dispute. -/
def exchange : Dispute Claim Exchange :=
  ⟨exchangeNode, exchangeNode_consistent, exchangeNode_sound⟩

/-- Who defeats whom in the exchange: each party defeats the other. -/
theorem exchange_defeats (i j : Exchange) : exchange.defeats i j ↔ i ≠ j := by
  cases i <;> cases j <;> simp only [ne_eq, not_true_eq_false, reduceCtorEq,
    not_false_eq_true, iff_true, iff_false]
  · exact exchange.not_defeats_self .scriptural
  · exact christian_defeats_critical
  · exact critical_defeats_christian
  · exact exchange.not_defeats_self .critical

/-- **Unanswered, nothing prevails.** The scriptural reading and the critical
denial defeat each other, so neither is forced, and the grounded extension is
empty. -/
@[headline]
theorem nothing_prevails_unanswered : grounded exchange.defeats = ∅ := by
  refine grounded_eq_of_iterate 0 rfl ?_
  intro a ha
  obtain ⟨c, hc, _⟩ := ha _ ((exchange_defeats (if a = .critical then .scriptural
    else .critical) a).mpr (by cases a <;> decide))
  exact hc

#print axioms nothing_prevails_unanswered

/-- A party of the exchange, standing alone, is a resolution of it: it defeats
the only party that defeats it, and nothing else remains to be added. -/
theorem exchange_alone_preferred (x : Exchange) : Preferred exchange.defeats {x} := by
  refine preferred_of_blocked ⟨?_, ?_⟩ ?_
  · intro a ha b hb
    simp only [Set.mem_singleton_iff] at ha hb
    subst ha hb
    exact exchange.not_defeats_self _
  · intro a ha b hb
    simp only [Set.mem_singleton_iff] at ha
    subst ha
    refine ⟨a, rfl, (exchange_defeats _ _).mpr ?_⟩
    exact fun h => (exchange_defeats _ _).mp hb h.symm
  · intro a ha
    exact ⟨x, rfl, .inl ((exchange_defeats _ _).mpr ha)⟩

/-! ### The dispute: the replies heard -/

/-- The four parties once Berry and Postell are heard. -/
inductive Party
  /-- The scriptural reading. -/
  | scriptural
  /-- The critical denial of the predictive reading. -/
  | critical
  /-- Berry's objection to the near-term exclusion. -/
  | berry
  /-- Postell's parity argument against it. -/
  | postell
deriving DecidableEq

/-- A statement about every party is a statement about each of the four. -/
theorem Party.forall_iff {P : Party → Prop} :
    (∀ x, P x) ↔ P .scriptural ∧ P .critical ∧ P .berry ∧ P .postell :=
  ⟨fun h => ⟨h _, h _, h _, h _⟩, fun ⟨h₁, h₂, h₃, h₄⟩ x => by cases x <;> assumption⟩

/-- Some party satisfies `P` just when one of the four does. -/
theorem Party.exists_iff {P : Party → Prop} :
    (∃ x, P x) ↔ P .scriptural ∨ P .critical ∨ P .berry ∨ P .postell := by
  constructor
  · rintro ⟨x, hx⟩
    cases x <;> simp_all
  · rintro (h | h | h | h) <;> exact ⟨_, h⟩

/-- The package each party of the dispute argues from. -/
def partyNode : Party → ArgumentPackage Claim
  | .scriptural => christian
  | .critical => criticalDenial
  | .berry => berryObjection
  | .postell => postellParity

/-- Each party's premises can hold together. -/
theorem partyNode_consistent : ∀ i, Satisfiable (partyNode i).premises
  | .scriptural => christian_is_satisfiable
  | .critical => criticalDenial_is_satisfiable
  | .berry => berryObjection_is_satisfiable
  | .postell => postellParity_is_satisfiable

/-- Each party establishes its conclusion. -/
theorem partyNode_sound : ∀ i, Establishes (partyNode i)
  | .scriptural => christian_establishes
  | .critical => criticalDenial_establishes
  | .berry => berryObjection_establishes
  | .postell => postellParity_establishes

/-- The dispute over Isaiah 7:14, with both replies in play. -/
def isaiahDispute : Dispute Claim Party :=
  ⟨partyNode, partyNode_consistent, partyNode_sound⟩

/-- The defeats of the dispute, as a table. -/
def partyDefeats : Party → Party → Prop
  | .critical, .scriptural => True
  | .scriptural, .critical => True
  | .berry, .critical => True
  | .postell, .critical => True
  | _, _ => False

/-- **Who defeats whom**, all sixteen pairs proved: the critic and the
scriptural reading defeat each other; each reply defeats the critic; nothing
else. -/
theorem isaiahDispute_defeats (i j : Party) :
    isaiahDispute.defeats i j ↔ partyDefeats i j := by
  cases i <;> cases j <;> simp only [partyDefeats, iff_true, iff_false]
  all_goals first
    | exact isaiahDispute.not_defeats_self _
    | exact critical_defeats_christian
    | exact christian_defeats_critical
    | exact berry_defeats_critical
    | exact postell_defeats_critical
    | exact critical_does_not_defeat_berry
    | exact critical_does_not_defeat_postell
    | exact christian_does_not_defeat_berry
    | exact berry_does_not_defeat_christian
    | exact christian_does_not_defeat_postell
    | exact postell_does_not_defeat_christian
    | exact berry_does_not_defeat_postell
    | exact postell_does_not_defeat_berry

/-- **Heard out, the scriptural reading prevails.** Nothing defeats Berry or
Postell, so both are in the grounded extension from the first step; they defeat
the critic, the scriptural reading's only defeater, so at the second step it
joins them; and nothing defends the critic. -/
@[headline]
theorem scriptural_reading_prevails_once_replies_are_heard :
    grounded isaiahDispute.defeats = {.scriptural, .berry, .postell} := by
  refine grounded_eq_of_iterate 2 ?_ ?_
  · ext a
    cases a <;> simp [characteristic, Defends, isaiahDispute_defeats, partyDefeats,
      Party.forall_iff, Party.exists_iff]
  · intro a ha
    cases a <;> simp_all [characteristic, Defends, isaiahDispute_defeats, partyDefeats,
      Party.forall_iff, Party.exists_iff]

#print axioms scriptural_reading_prevails_once_replies_are_heard

/-- **The critical denial cannot be defended.** No admissible set contains it:
Berry defeats it, and nothing defeats Berry. -/
@[headline]
theorem critical_denial_indefensible (S : Set Party)
    (hS : Admissible isaiahDispute.defeats S) : Party.critical ∉ S := by
  intro hc
  obtain ⟨c, _, hcb⟩ := hS.2 _ hc .berry ((isaiahDispute_defeats _ _).mpr trivial)
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

end Testimony.Arguments.BornOfAVirgin
