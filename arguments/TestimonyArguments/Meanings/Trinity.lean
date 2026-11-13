import Testimony.Semantics.Meaning
import TestimonyArguments.Trinity.Sources

/-!
# TestimonyArguments.Meanings.Trinity — what each Trinity claim says

**Not yet analysed.** Every atom is registered, with its citation's label and
marked unanalysed, so the argument is counted from the start
(`coverage_now`). Analysing one is replacing its case of `means` with a
`Statement`; `TestimonyArguments.Meanings.SolaFide` is the worked example.

**Looked at for joins, and none found.** The Western and Eastern readings meet
only through the steps that carry them to their conclusions, and those steps are
rated. No reading's own words deny another's. Aquinas's "only opposed relations
distinguish the persons" does not say, in its words, that the Father is not the
one cause; the step from it to "and the Son" is what says so.
-/

namespace TestimonyArguments.Meanings.Trinity

open Testimony

open Testimony.Semantics
open TestimonyArguments.Trinity (Claim cite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .john15_26ProceedsFromTheFather, .sonSendsTheSpirit, .spiritOfTheSon
  , .acts2_33SonPoursOutTheSpirit, .john16_14TakesWhatIsTheSons, .spiritRelatedToBoth
  , .receivingIsOrigin, .missionRevealsEternalRelation
  , .sonAndSpiritDistinct, .distinctOnlyByOpposedRelations, .sonNotFromTheSpirit
  , .john15_26SpeaksOfEternalOrigin
  , .john15_26NamesTheWholeSource, .monarchyOfTheFather, .filioque ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- What each atom of the argument says: not yet analysed. -/
instance meanings : HasMeanings Claim :=
  HasMeanings.ofLabels "The Triune God" all cite all_complete

/-- **None of the 15 atoms is analysed yet.** -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (0, 15) := by decide

/-- **No joins yet**: with no meaning analysed, no claim's meaning excludes or
entails another's, so the argument's checks hold no postulates. Analysing a
meaning that does fails this until the pair is listed. -/
instance joins : HasJoins Claim where
  exclusions := []
  exclusions_pinned := by decide +kernel
  entailments := []
  entailments_pinned := by decide +kernel

/-- **No postulates**: with no joins, the argument's checks hold nothing besides
its premises. -/
@[trinityDefs] theorem postulates_eq :
    (Testimony.Logic.HasPostulates.postulates : List (Testimony.Logic.Formula Claim)) =
      [] :=
  rfl

attribute [trinityDefs] Testimony.Logic.ArgumentPackage.held

/-- With no postulates, a package's premises having a model is all a dispute
asks of it. -/
theorem satisfiable_held {a : Testimony.Logic.ArgumentPackage Claim}
    (h : Testimony.Logic.Satisfiable a.premises) : Testimony.Logic.Satisfiable a.held :=
  Testimony.Logic.ArgumentPackage.satisfiable_held_of_nil postulates_eq h

end TestimonyArguments.Meanings.Trinity
