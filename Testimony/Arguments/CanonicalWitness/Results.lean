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
proves there is no other way (`Testimony.Logic.Burden`). The readings are
numbered from zero in the order of `corpora` — Paul, Hebrews, John, Peter,
Jesus' words — with James sixth. -/

/-- **The opponent's burden against the canonical witness.** To overturn it, an
opponent must reject Paul's, Peter's and Jesus' readings together — the three
that say works are not the ground — or Hebrews' and John's together, the two
that say faith is necessary. Nothing less overturns it, and nothing else does.

Trent does not take the second way. Its Decree on Justification calls faith the
beginning of salvation, "without which it is impossible to please God", so
Hebrews' reading is one it makes itself. That leaves the first: three readings,
of three corpora, each rejected. -/
@[headline]
theorem canonical_burden :
    OpponentsBurden canonicalCase corpora [] [toFaithAlone] [[0, 3, 4], [1, 2]] :=
  .of_check rfl (by decide +kernel)

#print axioms canonical_burden

/-- **No corpus carries it alone.** Reject any one corpus's reading and faith
alone still follows, because every set in the burden holds two readings or
more. -/
@[headline]
theorem no_corpus_is_load_bearing (i : ℕ) :
    Entails (caseRejecting corpora [] [toFaithAlone] [i]) canonicalCase.conclusion :=
  canonical_burden.stands_without_one (by decide) i

#print axioms no_corpus_is_load_bearing

/-- **Two corpora are enough**: Hebrews, that faith is necessary, and Jesus'
words, that it is sufficient and that works are not the ground. Reject Paul's,
John's and Peter's readings, and faith alone still follows — the rejection
leaves one reading of each set standing. -/
@[headline]
theorem hebrews_and_jesus_suffice :
    Entails (caseRejecting corpora [] [toFaithAlone] [0, 2, 3]) canonicalCase.conclusion :=
  canonical_burden.stands_without _ (by decide)

#print axioms hebrews_and_jesus_suffice

/-- **The opponent's burden against the canonical witness with James.** The
two ways of overturning faith alone remain, and a third is added for the
Reformed formula: rejecting James's reading alone. That set has one reading
in it — James is the formula's single point of failure, as he is its only
witness that works are the fruit of faith. -/
@[headline]
theorem canonicalWithJames_burden :
    OpponentsBurden canonicalWithJames (corpora ++ [jamesLine]) [p .jude20_21]
      [toFaithAlone, toNeverAlone] [[0, 3, 4], [1, 2], [5]] :=
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
