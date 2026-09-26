import Testimony.Arguments.CanonicalWitness.Packages
import Testimony.Logic.Tactic
import Testimony.Logic.Because

/-!
# Arguments.CanonicalWitness.Results — what the canonical witness establishes

Every result is conditional on its premises, as everywhere in the library; what
this argument adds is that every premise but the readings is a text all parties
accept as scripture. So each result says: *grant these texts, read each corpus
this way, and this follows* — and the refutations say exactly which readings an
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

/-! ### No single corpus carries it -/

/-- **Paul's reading is not load-bearing.** Take it away and Peter and Jesus
still say works are not the ground. -/
@[headline]
theorem paul_not_load_bearing : Establishes withoutPaul := by
  establish [canonicalWitnessDefs]

#print axioms paul_not_load_bearing

/-- **Nor is Hebrews'.** John says faith is necessary too. -/
@[headline]
theorem hebrews_not_load_bearing : Establishes withoutHebrews := by
  establish [canonicalWitnessDefs]

#print axioms hebrews_not_load_bearing

/-- **Nor is John's.** Hebrews says faith is necessary, and three corpora say it
is sufficient. -/
@[headline]
theorem john_not_load_bearing : Establishes withoutJohn := by
  establish [canonicalWitnessDefs]

#print axioms john_not_load_bearing

/-- **Nor is Peter's.** -/
@[headline]
theorem peter_not_load_bearing : Establishes withoutPeter := by
  establish [canonicalWitnessDefs]

#print axioms peter_not_load_bearing

/-- **Nor is the reading of Jesus' words.** -/
@[headline]
theorem jesus_not_load_bearing : Establishes withoutJesus := by
  establish [canonicalWitnessDefs]

#print axioms jesus_not_load_bearing

/-- **Two corpora suffice**: Hebrews, that faith is necessary, and Jesus' words,
that it is sufficient and that works are not the ground. -/
@[headline]
theorem hebrews_and_jesus_suffice : Establishes hebrewsAndJesus := by
  establish [canonicalWitnessDefs]

#print axioms hebrews_and_jesus_suffice

/-- Each variant keeps a subset of the canonical case's premises, so the world
in which every text and reading holds is a model of each. Without Paul: -/
theorem withoutPaul_is_satisfiable : Satisfiable withoutPaul.premises := by
  satisfied_by canonicalReading [canonicalWitnessDefs]

/-- Without Hebrews, the premises have a model. -/
theorem withoutHebrews_is_satisfiable : Satisfiable withoutHebrews.premises := by
  satisfied_by canonicalReading [canonicalWitnessDefs]

/-- Without John, the premises have a model. -/
theorem withoutJohn_is_satisfiable : Satisfiable withoutJohn.premises := by
  satisfied_by canonicalReading [canonicalWitnessDefs]

/-- Without Peter, the premises have a model. -/
theorem withoutPeter_is_satisfiable : Satisfiable withoutPeter.premises := by
  satisfied_by canonicalReading [canonicalWitnessDefs]

/-- Without Jesus' words, the premises have a model. -/
theorem withoutJesus_is_satisfiable : Satisfiable withoutJesus.premises := by
  satisfied_by canonicalReading [canonicalWitnessDefs]

/-- Hebrews and Jesus' words alone have a model. -/
theorem hebrewsAndJesus_is_satisfiable : Satisfiable hebrewsAndJesus.premises := by
  satisfied_by canonicalReading [canonicalWitnessDefs]

/-! ### What an opponent must reject -/

/-- Grant every text, and Hebrews' and John's readings, but none of Paul's,
Peter's or Jesus': faith is necessary and sufficient, but works are not shown
not to be the ground. -/
def noWorksWitnessReading : Valuation Claim := fun a =>
  match a with
  | .worksAreNotTheGround => False
  | .justificationByFaithAlone => False
  | _ => True

/-- **To deny that works are not the ground, an opponent must reject three
readings** — Paul's, Peter's and Jesus'. With all three taken away, faith alone
no longer follows; with any one of them kept, it does (`paul_not_load_bearing`,
`peter_not_load_bearing`, `jesus_not_load_bearing`). -/
@[headline]
theorem works_witnesses_jointly_load_bearing : ¬ Establishes withoutTheWorksWitnesses := by
  refute_with noWorksWitnessReading [canonicalWitnessDefs]

#print axioms works_witnesses_jointly_load_bearing

/-- Grant every text, and Paul's, Peter's and Jesus' readings, but neither
Hebrews' nor John's: faith is sufficient and works are not the ground, but
faith is not shown to be necessary. -/
def noNecessityWitnessReading : Valuation Claim := fun a =>
  match a with
  | .faithIsNecessary => False
  | .justificationByFaithAlone => False
  | _ => True

/-- **To deny that faith is necessary, an opponent must reject two readings** —
Hebrews' and John's. Trent does not: it calls faith the beginning of salvation,
without which it is impossible to please God. That part of faith alone is
common ground. -/
@[headline]
theorem necessity_witnesses_jointly_load_bearing :
    ¬ Establishes withoutTheNecessityWitnesses := by
  refute_with noNecessityWitnessReading [canonicalWitnessDefs]

#print axioms necessity_witnesses_jointly_load_bearing

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

/-! ### Why the canonical witness stands against Trent

Both positions hold every text. They part at one reading: the sense of
"justified" in James 2:21–24. -/

/-- **Why the canonical witness, with James, stands against Trent.** The crux is
the demonstrative sense of "justified" in James: it breaks Trent at exactly its
reading of James 2:24, and the Reformed formula needs it. Every other premise
of Trent — every text — the canonical witness holds too. -/
def whyTheCanonicalWitnessStandsAgainstTrent : Because canonicalWithJames tridentine :=
  Because.ofChecks (p .jamesJustifiesDemonstratively)
    (paulineLine.grounds ++ hebrewsLine.grounds ++ johannineLine.grounds ++
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
