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
- **The scriptural reading does not defeat the critical denial**, although it
  attacks it. It concludes the opposite, so it rebuts; but its weakest premise
  is `disputed` and the critical denial's are `wellSupported`, so the rebuttal
  fails. On the library's own ratings the scriptural reading cannot answer the
  critic by itself.
- **Berry and Postell each defeat the critical denial**, by contradicting its
  premise that a near-term sign excludes a messianic sense.
- **The critical denial defeats each of them back.** It holds that premise, so
  it rebuts both; and all three rest on `wellSupported` premises, so neither
  side of the exchange outranks the other.

## What follows

Faced with the scriptural reading alone, **the critical denial prevails**: it
is the grounded extension of that exchange, and the scriptural reading is
excluded from it. Add Berry and Postell and **nothing prevails any more**: the
grounded extension is empty. The dispute then has two ways to be resolved,
proved as its two preferred extensions:

- the scriptural reading together with Berry and Postell, who defend it; or
- the critical denial alone, which defends itself against both replies.

This is the result entailment could not state. Adding premises never removes
a conclusion; adding arguments can remove one from what a dispute forces. The
replies do not show the predictive reading is right. They reinstate it as a
defensible resolution of the dispute — one of two, and only one of two, because
the ratings make the exchange between the replies and the critic a standoff.

## What the ratings decide

These outcomes rest on the cited confidences as much as on the premises.
Postell's argument is described in `Lines.lean` as the stronger of the two
defeaters; the ratings do not register that, because both of its premises are
cited `wellSupported`, as Berry's is. And the premise that settles the
exchange with the critic — that a near-term sign excludes a messianic sense —
is rated `wellSupported` on Brown's authority. Rated `disputed`, both replies
would defeat the critic without being defeated back, and the scriptural
reading would join the grounded extension. The rating is a premise of this
result, and contesting it is contesting the result.

## What the church fathers add, and what they cannot

The predictive reading is not a modern apologetic. Justin, Irenaeus, Origen and
Jerome all argue it, and `Sources.lean` cites them for it: for the
prediction itself, for עַלְמָה as a virgin, and — the argument they share —
that an ordinary conception would have been no sign at all. That strengthens
the attestation of the scriptural premises, and none of it changes a rating.

It cannot, for two reasons. The first is what `disputed` means here: *actively
contested by competent scholars*. The fathers are the earliest witnesses to the
contest as well as to the reading. Justin records Trypho's answer — "young
woman", and fulfilled in Hezekiah — and Irenaeus names Theodotion and Aquila.
An older witness does not make a contested claim uncontested.

The second is structural. The critic defeats the scriptural reading by
undermining its predictive premise, and that attack fails only if the premise
outranks the critic, whose weakest link is `wellSupported`: only a `consensus`
rating would block it. The scriptural reading's own rebuttal succeeds only if
*every* claim it rests on is rated at least `wellSupported`, across all four
strands. Under the weakest-link rule, support for one premise changes nothing
unless it lifts the lowest.
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

/-- The critical denial rests on two premises cited `wellSupported`. -/
theorem criticalDenial_strength : criticalDenial.strength = 2 := by decide

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

/-- **The scriptural reading cannot answer the critic by itself.** Its rebuttal
is an attack, but not a defeat: its weakest premise is `disputed` and the
critical denial's are `wellSupported`. -/
@[headline]
theorem christian_does_not_defeat_critical : ¬ Defeats christian criticalDenial := by
  rintro (⟨φ, hu, _⟩ | ⟨_, hweak⟩)
  · exact christian_does_not_undermine_critical φ hu
  · exact hweak (by rw [christian_strength, criticalDenial_strength]; decide)

#print axioms christian_does_not_defeat_critical

/-- **Berry defeats the critical denial.** He entails the negation of its
premise that a near-term sign excludes a messianic sense, and that premise is
cited no higher than Berry's own. -/
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

/-- **The critical denial defeats Berry back.** It holds the premise Berry
denies, so it rebuts his conclusion, and Berry is no stronger than it. -/
theorem critical_defeats_berry : Defeats criticalDenial berryObjection :=
  .inr ⟨by establish [Rebuts, criticalDenial, berryObjection, criticalExclusionLine,
      berryLine, criticalExclusion],
    by rw [criticalDenial_strength, berryObjection_strength]; decide⟩

/-- **The critical denial defeats Postell back**, for the same reason. -/
theorem critical_defeats_postell : Defeats criticalDenial postellParity :=
  .inr ⟨by establish [Rebuts, criticalDenial, postellParity, criticalExclusionLine,
      postellLine, criticalExclusion],
    by rw [criticalDenial_strength, postellParity_strength]; decide⟩

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

/-- Who defeats whom in the exchange: the critic defeats the scriptural reading,
and nothing else. -/
theorem exchange_defeats (i j : Exchange) :
    exchange.defeats i j ↔ i = .critical ∧ j = .scriptural := by
  cases i <;> cases j <;> simp only [reduceCtorEq, and_false, false_and, and_self,
    iff_true, iff_false]
  · exact exchange.not_defeats_self .scriptural
  · exact christian_does_not_defeat_critical
  · exact critical_defeats_christian
  · exact exchange.not_defeats_self .critical

/-- **Unanswered, the critical denial prevails.** It is the grounded extension of
the exchange: nothing defeats it, and it defeats the scriptural reading, which
nothing then defends. -/
@[headline]
theorem critical_prevails_unanswered : grounded exchange.defeats = {.critical} := by
  refine grounded_eq_of_iterate 1 ?_ ?_
  · ext a
    cases a <;> simp [characteristic, Defends, exchange_defeats]
  · intro a ha
    cases a
    · obtain ⟨c, hc, hcb⟩ := ha .critical ((exchange_defeats _ _).mpr ⟨rfl, rfl⟩)
      simp only [Set.mem_singleton_iff] at hc
      subst hc
      exact absurd ((exchange_defeats _ _).mp hcb).2 (by decide)
    · exact rfl

#print axioms critical_prevails_unanswered

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
  | .berry, .critical => True
  | .postell, .critical => True
  | .critical, .berry => True
  | .critical, .postell => True
  | _, _ => False

/-- **Who defeats whom**, all sixteen pairs proved: the critic defeats the
scriptural reading; the critic and each reply defeat each other; nothing else. -/
theorem isaiahDispute_defeats (i j : Party) :
    isaiahDispute.defeats i j ↔ partyDefeats i j := by
  cases i <;> cases j <;> simp only [partyDefeats, iff_true, iff_false]
  all_goals first
    | exact isaiahDispute.not_defeats_self _
    | exact critical_defeats_christian
    | exact christian_does_not_defeat_critical
    | exact berry_defeats_critical
    | exact postell_defeats_critical
    | exact critical_defeats_berry
    | exact critical_defeats_postell
    | exact christian_does_not_defeat_berry
    | exact berry_does_not_defeat_christian
    | exact christian_does_not_defeat_postell
    | exact postell_does_not_defeat_christian
    | exact berry_does_not_defeat_postell
    | exact postell_does_not_defeat_berry

/-- **Heard out, nothing prevails.** Every party in the dispute is defeated by
someone, so nothing is forced, and the grounded extension is empty. The critical
denial, which prevailed over the scriptural reading alone, no longer does. -/
@[headline]
theorem nothing_prevails_once_replies_are_heard : grounded isaiahDispute.defeats = ∅ := by
  refine grounded_eq_of_iterate 0 rfl ?_
  intro a ha
  -- Each party has a defeater, and the empty set answers none of them.
  have defeater : ∃ b, isaiahDispute.defeats b a := by
    cases a
    · exact ⟨.critical, (isaiahDispute_defeats _ _).mpr trivial⟩
    · exact ⟨.berry, (isaiahDispute_defeats _ _).mpr trivial⟩
    · exact ⟨.critical, (isaiahDispute_defeats _ _).mpr trivial⟩
    · exact ⟨.critical, (isaiahDispute_defeats _ _).mpr trivial⟩
  obtain ⟨b, hb⟩ := defeater
  obtain ⟨c, hc, _⟩ := ha b hb
  exact hc

#print axioms nothing_prevails_once_replies_are_heard

/-- **The replies reinstate the scriptural reading.** The scriptural reading,
Berry and Postell together are a preferred extension: they do not defeat one
another, and the only party that defeats any of them — the critic — is defeated
by Berry. -/
@[headline]
theorem scriptural_reading_reinstated :
    Preferred isaiahDispute.defeats {.scriptural, .berry, .postell} := by
  refine preferred_of_blocked ⟨?_, ?_⟩ ?_
  · intro a ha b hb hab
    rw [isaiahDispute_defeats] at hab
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at ha hb
    rcases ha with rfl | rfl | rfl <;> rcases hb with rfl | rfl | rfl <;> exact hab
  · intro a _ b hb
    refine ⟨.berry, by simp, ?_⟩
    rw [isaiahDispute_defeats] at hb ⊢
    cases b <;> cases a <;> simp_all [partyDefeats]
  · intro a ha
    cases a <;> simp at ha
    exact ⟨.berry, by simp, .inr ((isaiahDispute_defeats _ _).mpr trivial)⟩

#print axioms scriptural_reading_reinstated

/-- **The critical denial remains defensible.** Alone, it is also a preferred
extension: it defeats both replies, and the scriptural reading, and nothing it
defeats can stand beside it. -/
@[headline]
theorem critical_denial_remains_defensible :
    Preferred isaiahDispute.defeats {.critical} := by
  refine preferred_of_blocked ⟨?_, ?_⟩ ?_
  · intro a ha b hb
    simp only [Set.mem_singleton_iff] at ha hb
    subst ha hb
    exact isaiahDispute.not_defeats_self _
  · intro a ha b hb
    simp only [Set.mem_singleton_iff] at ha
    subst ha
    refine ⟨.critical, rfl, ?_⟩
    rw [isaiahDispute_defeats] at hb ⊢
    cases b <;> simp_all [partyDefeats]
  · intro a ha
    refine ⟨.critical, rfl, .inr ?_⟩
    rw [isaiahDispute_defeats]
    cases a <;> simp_all [partyDefeats]

#print axioms critical_denial_remains_defensible

/-- **So the dispute leaves the predictive reading open.** The scriptural
reading is accepted on one resolution of the dispute and rejected on another. -/
theorem scriptural_reading_credulously_accepted :
    CredulouslyAccepted isaiahDispute.defeats .scriptural :=
  ⟨_, scriptural_reading_reinstated, by simp⟩

/-- Not every resolution accepts the scriptural reading: the critic's does not. -/
theorem scriptural_reading_not_skeptically_accepted :
    ¬ SkepticallyAccepted isaiahDispute.defeats .scriptural :=
  fun h => by simpa using h _ critical_denial_remains_defensible

end Testimony.Arguments.BornOfAVirgin
