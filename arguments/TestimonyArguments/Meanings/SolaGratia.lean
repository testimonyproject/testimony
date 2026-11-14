import Testimony.Semantics.Meaning
import TestimonyArguments.SolaGratia

/-!
# TestimonyArguments.Meanings.SolaGratia — what each sola gratia claim says

**Not yet analysed.** Every atom is registered, with its citation's label and
marked unanalysed, so the argument is counted from the start (`coverage_now`).
Analysing one is replacing its case of `means` with a `Statement`;
`TestimonyArguments.Meanings.SolaFide` is the worked example.

**Looked at for joins, and none taken.** Two pairs come close. That the will can
refuse if it wishes (Trent's canon 4) and that grace brings about the consent it
seeks look like contraries, but Aquinas holds both, the first taken simply and
the second of the will God actually moves; joining them would settle by
definition the step this argument rates `disputed` (`dissentStep`). And that the
will cooperates by assenting and that it is passive in being made alive look
like contraries too, but Dort holds that the will, once renewed, "becomes itself
active"; whether Trent's assent comes before the new life or after it is the
dispute, and it is a rated step (`cooperationStep`).
-/

namespace TestimonyArguments.Meanings.SolaGratia

open Testimony

open Testimony.Semantics
open TestimonyArguments.SolaGratia (Claim baseCite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .ephesians2_1to5, .ephesians2_8to9, .romans9_16, .romans11_6, .acts7_51
  , .zechariah1_3WithLamentations5_21, .toutoRefersToTheWhole, .romans9_16ConcernsSalvation
  , .faithIsGodsGift, .acts7_51ResistsSavingGrace, .freeWillCooperatesByAssenting
  , .freeWillCanDissent, .conversionIsGodsWorkAlone, .salvationIsByGrace
  , .graceIsEffectualOfItself, .willIsPassiveInRegeneration ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- What each atom of the argument says: not yet analysed. -/
instance meanings : HasMeanings Claim :=
  HasMeanings.ofLabels "Sola gratia — Ephesians 2:8–9 and Romans 9:16" all baseCite all_complete

/-- **None of the 16 atoms is analysed yet.** -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (0, 16) := by decide

/-- **No joins**: with no meaning analysed, no claim's meaning excludes or
entails another's, so the argument's checks hold no postulates. -/
instance joins : HasJoins Claim where
  exclusions := []
  exclusions_pinned := by decide +kernel
  entailments := []
  entailments_pinned := by decide +kernel

/-- **No postulates**: with no joins, the argument's checks hold nothing besides
its premises. -/
@[solaGratiaDefs] theorem postulates_eq :
    (Testimony.Logic.HasPostulates.postulates : List (Testimony.Logic.Formula Claim)) =
      [] :=
  rfl

attribute [solaGratiaDefs] Testimony.Logic.ArgumentPackage.held

/-- With no postulates, a package's premises having a model is all a dispute
asks of it. -/
theorem satisfiable_held {a : Testimony.Logic.ArgumentPackage Claim}
    (h : Testimony.Logic.Satisfiable a.premises) : Testimony.Logic.Satisfiable a.held :=
  Testimony.Logic.ArgumentPackage.satisfiable_held_of_nil postulates_eq h

end TestimonyArguments.Meanings.SolaGratia
