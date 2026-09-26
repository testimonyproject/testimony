import Testimony.Arguments.CanonicalWitness.Packages
import Testimony.Logic.Tactic
import Testimony.Logic.Because
import Testimony.Logic.Burden

/-!
# Arguments.CanonicalWitness.Results — what the canonical witness establishes

Every result is conditional on its premises, as everywhere in the library; what
this argument adds is that every premise but the readings is a text all parties
accept as scripture. So each result says: *grant these texts, read each corpus
this way, and this follows* — and the burden says exactly which readings an
opponent has to reject.
-/

namespace Testimony.Arguments.CanonicalWitness

open Testimony Testimony.Logic

/-! ### The rival -/

/-- Trent's world: every text holds, "justified" in James 2:24 is not
demonstrative, works are part of the ground, and faith alone fails. -/
def tridentineReading : Valuation Claim := fun a =>
  match a with
  | .jamesJustifiesDemonstratively => False
  | .worksAreNotTheGround => False
  | .justificationByFaithAlone => False
  | _ => True

/-- **Trent's reading is coherent, and it denies faith alone.** Granting every
text, Trent reaches its conclusion by its reading of James 2:24. -/
@[headline]
theorem tridentine_establishes : Establishes tridentine := by
  establish [canonicalWitnessDefs]

#print axioms tridentine_establishes

/-- Trent's premises have a model. -/
theorem tridentine_is_satisfiable : Satisfiable tridentine.premises := by
  satisfied_by tridentineReading [canonicalWitnessDefs]

/-! ### The canonical witness -/

/-- The world in which every text and every reading holds. -/
def canonicalReading : Valuation Claim := fun _ => True

/-- **From the texts all parties accept, faith alone follows**, on one reading
per corpus: Paul, Hebrews, John, Peter and Jesus' words, each delivering only
what its own texts say. -/
@[headline]
theorem canonical_establishes : Establishes canonicalCase := by
  establish [canonicalWitnessDefs]

#print axioms canonical_establishes

/-- The canonical case has a model. -/
theorem canonicalCase_is_satisfiable : Satisfiable canonicalCase.premises := by
  satisfied_by canonicalReading [canonicalWitnessDefs]

/-- **With James, the Reformed formula follows**: justification by faith alone,
by a faith that is never alone. James's texts — all of them, 2:24 included —
are premises, and they cohere with the other corpora on the distinction between
justification and sanctification. -/
@[headline]
theorem canonicalWithJames_establishes : Establishes canonicalWithJames := by
  establish [canonicalWitnessDefs]

#print axioms canonicalWithJames_establishes

/-- The case with James has a model: James and the other corpora can all be
held at once. -/
theorem canonicalWithJames_is_satisfiable : Satisfiable canonicalWithJames.premises := by
  satisfied_by canonicalReading [canonicalWitnessDefs]

/-! ### What an opponent must reject

The texts are granted, so what an opponent can reject is a reading. The burden
lists every minimal set of readings whose rejection overturns the case, and
proves there is no other way (`Testimony.Logic.Burden`). The results after it
take its sets one at a time, as named packages a reader can check: each is an
instance of the burden, and is proved from it. -/

/-- **The opponent's burden against the canonical witness.** There are exactly
three ways to overturn it, one for each part of faith alone:

- reject the three readings that say works are not the ground — Paul's on
  works, Peter's and Jesus';
- or the three that say faith is necessary — Paul's on faith, Hebrews' and
  John's;
- or the four that say faith is sufficient — Paul's on faith, John's, Peter's
  and Jesus'.

Nothing less overturns it, and nothing else does. Trent does not take the second
way: its Decree on Justification reads the Apostle's "justified by faith" as
faith "the beginning of human salvation … without which it is impossible to
please God". -/
@[headline]
theorem canonical_burden :
    OpponentsBurden canonicalCase corpora [] [toFaithAlone]
      [ [Reading.paul, Reading.peter, Reading.jesus]
      , [Reading.paulOnFaith, Reading.hebrews, Reading.john]
      , [Reading.paulOnFaith, Reading.john, Reading.peter, Reading.jesus] ] :=
  .of_check rfl (by decide +kernel)

#print axioms canonical_burden

/-! ### No single corpus carries it

Every set in the burden holds more than one corpus, so no single corpus's
rejection overturns the case. Here is each, taken away in turn. -/

/-- **Paul is not load-bearing.** Reject both his readings, and Peter and Jesus
still say that works are not the ground, Hebrews and John that faith is
necessary, and John, Peter and Jesus that it suffices. -/
@[headline]
theorem paul_not_load_bearing : Establishes withoutPaul :=
  canonical_burden.establishes_rejecting (by decide)

#print axioms paul_not_load_bearing

/-- **Nor is Hebrews.** Paul and John say faith is necessary too. -/
@[headline]
theorem hebrews_not_load_bearing : Establishes withoutHebrews :=
  canonical_burden.establishes_rejecting (by decide)

#print axioms hebrews_not_load_bearing

/-- **Nor is John.** Paul and Hebrews say faith is necessary, and Paul, Peter
and Jesus that it is sufficient. -/
@[headline]
theorem john_not_load_bearing : Establishes withoutJohn :=
  canonical_burden.establishes_rejecting (by decide)

#print axioms john_not_load_bearing

/-- **Nor is Peter.** Paul and Jesus still say that works are not the
ground. -/
@[headline]
theorem peter_not_load_bearing : Establishes withoutPeter :=
  canonical_burden.establishes_rejecting (by decide)

#print axioms peter_not_load_bearing

/-- **Nor are Jesus' words.** Paul and Peter still say that works are not the
ground. -/
@[headline]
theorem jesus_not_load_bearing : Establishes withoutJesus :=
  canonical_burden.establishes_rejecting (by decide)

#print axioms jesus_not_load_bearing

/-- **Two corpora are enough**: Hebrews, that faith is necessary, and Jesus'
words, that it is sufficient and that works are not the ground. Rejecting
Paul's, John's and Peter's readings leaves a reading of each set standing. -/
@[headline]
theorem hebrews_and_jesus_suffice : Establishes hebrewsAndJesus :=
  canonical_burden.establishes_rejecting (by decide)

#print axioms hebrews_and_jesus_suffice

/-- Each named variant has a model: rejecting readings never makes the rest
inconsistent. Without Paul: -/
theorem withoutPaul_is_satisfiable : Satisfiable withoutPaul.premises :=
  canonical_burden.rejecting_satisfiable _

/-- Without Hebrews, the premises have a model. -/
theorem withoutHebrews_is_satisfiable : Satisfiable withoutHebrews.premises :=
  canonical_burden.rejecting_satisfiable _

/-- Without John, the premises have a model. -/
theorem withoutJohn_is_satisfiable : Satisfiable withoutJohn.premises :=
  canonical_burden.rejecting_satisfiable _

/-- Without Peter, the premises have a model. -/
theorem withoutPeter_is_satisfiable : Satisfiable withoutPeter.premises :=
  canonical_burden.rejecting_satisfiable _

/-- Without Jesus' words, the premises have a model. -/
theorem withoutJesus_is_satisfiable : Satisfiable withoutJesus.premises :=
  canonical_burden.rejecting_satisfiable _

/-- Hebrews and Jesus' words alone have a model. -/
theorem hebrewsAndJesus_is_satisfiable : Satisfiable hebrewsAndJesus.premises :=
  canonical_burden.rejecting_satisfiable _

/-! ### The three ways, each written down

Each way of overturning the case is a world an opponent could stand in: every
text true, the readings of the other corpora granted, and faith alone false.
Naming that world is what makes the burden concrete. -/

/-- The first way: grant every text and every reading on faith, but none of
Paul's on works, Peter's or Jesus'. Faith is necessary and sufficient, but
works are not shown not to be the ground. -/
def noWorksWitnessReading : Valuation Claim := fun a =>
  match a with
  | .worksAreNotTheGround => False
  | .justificationByFaithAlone => False
  | _ => True

/-- **To deny that works are not the ground, an opponent must reject three
readings** — Paul's on works, Peter's and Jesus'. With all three rejected,
faith alone no longer follows; with any one kept, it does. -/
@[headline]
theorem works_witnesses_jointly_load_bearing : ¬ Establishes withoutTheWorksWitnesses := by
  refute_with noWorksWitnessReading [canonicalWitnessDefs]

#print axioms works_witnesses_jointly_load_bearing

/-- The second way: grant every text, but not Paul's reading on faith, nor
Hebrews', nor John's. Faith is sufficient and works are not the ground, but
faith is not shown to be necessary. -/
def noNecessityWitnessReading : Valuation Claim := fun a =>
  match a with
  | .faithIsNecessary => False
  | .justificationByFaithAlone => False
  | _ => True

/-- **To deny that faith is necessary, an opponent must reject three
readings** — Paul's on faith, Hebrews' and John's. Trent does not: it reads
Paul's "justified by faith" as faith the foundation of justification, without
which it is impossible to please God. That part of faith alone is common
ground. -/
@[headline]
theorem necessity_witnesses_jointly_load_bearing :
    ¬ Establishes withoutTheNecessityWitnesses := by
  refute_with noNecessityWitnessReading [canonicalWitnessDefs]

#print axioms necessity_witnesses_jointly_load_bearing

/-- The third way: grant every text, but not Paul's reading on faith, nor
John's, Peter's or Jesus'. Faith is necessary and works are not the ground, but
faith is not shown to suffice. -/
def noSufficiencyWitnessReading : Valuation Claim := fun a =>
  match a with
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | _ => True

/-- **To deny that faith suffices, an opponent must reject four readings** —
Paul's on faith, John's, Peter's and Jesus'. This is the way Trent takes
(canon 9), and the widest of the three: four corpora say it. -/
@[headline]
theorem sufficiency_witnesses_jointly_load_bearing :
    ¬ Establishes withoutTheSufficiencyWitnesses := by
  refute_with noSufficiencyWitnessReading [canonicalWitnessDefs]

#print axioms sufficiency_witnesses_jointly_load_bearing

/-- **The opponent's burden against the canonical witness with James.** The
three ways of overturning faith alone remain, and a fourth is added for the
Reformed formula: rejecting James's reading alone. That set has one reading in
it — James is the formula's single point of failure, as he is its only witness
that works are the fruit of faith. -/
@[headline]
theorem canonicalWithJames_burden :
    OpponentsBurden canonicalWithJames (corpora ++ [jamesLine]) [p .jude20_21]
      [toFaithAlone, toNeverAlone]
      [ [Reading.paul, Reading.peter, Reading.jesus]
      , [Reading.paulOnFaith, Reading.hebrews, Reading.john]
      , [Reading.paulOnFaith, Reading.john, Reading.peter, Reading.jesus]
      , [Reading.james] ] :=
  .of_check rfl (by decide +kernel)

#print axioms canonicalWithJames_burden

/-! ### James -/

/-- James read without the demonstrative sense of "justified": works are not
shown to be the fruit of faith, and the Reformed formula does not follow. -/
def jamesUndemonstratedReading : Valuation Claim := fun a =>
  match a with
  | .jamesJustifiesDemonstratively => False
  | .worksAreFruitOfFaith => False
  | .faithAloneNeverAlone => False
  | _ => True

/-- **The sense of "justified" in James is load-bearing** for the formula. Take
the demonstrative reading away, keeping every text of James and the distinction
between justification and sanctification, and "faith never alone" no longer
follows. -/
@[headline]
theorem james_demonstrative_is_load_bearing : ¬ Establishes withJamesUndemonstrated := by
  refute_with jamesUndemonstratedReading [canonicalWitnessDefs]

#print axioms james_demonstrative_is_load_bearing

/-! ### Paul on faith, beside James

Paul's message about faith, stated on its own: faith is necessary and it is
sufficient. Does James contradict it? Not on its texts: none of them says
either. It turns on one reading — of whom James says "can that faith save
him?" (2:14). -/

/-- **Paul: faith is necessary and sufficient.** From Romans 4:4–5 and
Galatians 2:16 and 3:11 alone, on Paul's reading of them. -/
@[headline]
theorem paul_on_faith_establishes : Establishes paulOnFaith := by
  establish [canonicalWitnessDefs]

#print axioms paul_on_faith_establishes

/-- Paul's claim about faith has a model. -/
theorem paulOnFaith_is_satisfiable : Satisfiable paulOnFaith.premises := by
  satisfied_by canonicalReading [canonicalWitnessDefs]

/-- James's world read plainly, beside Paul's: every text of James true, the
faith James calls dead is faith without works, justification and sanctification
distinct — and "justified" in 2:21–24 given its ordinary sense, not the
demonstrative one. Faith is necessary and sufficient. -/
def paulWithJamesPlainlyReading : Valuation Claim := fun a =>
  match a with
  | .jamesJustifiesDemonstratively => False
  | .worksAreFruitOfFaith => False
  | .faithAloneNeverAlone => False
  | _ => True

/-- **Paul's claim about faith stands with James.** Every text of James, the
reading of 2:14–17 as about faith without works, and the distinction between
justification and sanctification can all be held with faith necessary and
sufficient — and without the demonstrative sense of "justified" on which James
and Trent part. The harmony does not rest on that contested sense. -/
@[headline]
theorem paul_on_faith_stands_with_james :
    Satisfiable (paulOnFaith.premises ++ [paulOnFaith.conclusion] ++
      jamesWithoutDemonstrative.premises) := by
  satisfied_by paulWithJamesPlainlyReading [canonicalWitnessDefs]

#print axioms paul_on_faith_stands_with_james

/-- The world of James read against sufficiency: every text of James true, and
faith, as such, not enough. -/
def jamesAgainstSufficiencyReading : Valuation Claim := fun a =>
  match a with
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | .faithAloneNeverAlone => False
  | _ => True

/-- James read against sufficiency has a model: the rival is coherent. -/
theorem jamesReadAgainstSufficiency_is_satisfiable :
    Satisfiable jamesReadAgainstSufficiency.premises := by
  satisfied_by jamesAgainstSufficiencyReading [canonicalWitnessDefs]

/-- The rival reading establishes what it says: faith does not suffice. -/
theorem jamesReadAgainstSufficiency_establishes : Establishes jamesReadAgainstSufficiency := by
  establish [canonicalWitnessDefs]

/-- **What the harmony rests on.** Read "that faith" in James 2:14 and "not by
faith alone" in 2:24 of faith as such, as Trent does, and James and Paul's
claim about faith cannot both be held. So the harmony is a reading, not a
given: it rests on the faith James says cannot save being the faith 2:14–17
describes — faith without works — which is `james2TargetsDeadFaith`, cited to
Moo and Johnson. -/
@[headline]
theorem james_against_sufficiency_contradicts_paul :
    ¬ Satisfiable (paulOnFaith.premises ++ jamesReadAgainstSufficiency.premises) :=
  not_satisfiable_of_check (by decide +kernel)

#print axioms james_against_sufficiency_contradicts_paul

/-! ### Why the canonical witness stands against Trent

Both positions hold every text. They part at one reading: the sense of
"justified" in James 2:21–24. -/

/-- **Why the canonical witness, with James, stands against Trent.** The crux is
the demonstrative sense of "justified" in James: it breaks Trent at exactly its
reading of James 2:24, and the Reformed formula needs it. Every other premise
of Trent — every text — the canonical witness holds too. -/
def whyTheCanonicalWitnessStandsAgainstTrent : Because canonicalWithJames tridentine :=
  Because.ofChecks (p .jamesJustifiesDemonstratively)
    (paulineLine.grounds ++ paulineFaithLine.grounds ++ hebrewsLine.grounds ++
      johannineLine.grounds ++
      petrineLine.grounds ++ dominicalLine.grounds ++
      [p .james2_14_17, p .james2_19, p .james2_21_23, p .james2_24,
        p .james2TargetsDeadFaith])
    ([p .justificationDistinctFromSanctification, p .jude20_21] ++
      (corpora ++ [jamesLine]).map Line.step ++ [toFaithAlone, toNeverAlone])
    [] [notP .jamesJustifiesDemonstratively] .derives
    canonicalWithJames_establishes canonicalWithJames_is_satisfiable
    (by simp [canonicalWitnessDefs, caseOf])
    (by simp)
    (by simp [canonicalWitnessDefs])
    (by decide +kernel)

end Testimony.Arguments.CanonicalWitness
