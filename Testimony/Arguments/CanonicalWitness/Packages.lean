import Testimony.Arguments.CanonicalWitness.Lines
import Testimony.Logic.Package

/-!
# Arguments.CanonicalWitness.Packages — the positions

Trent first, because the rival is written before anything is proved. Then the
canonical case, the case with James, and one variant: James read without the
demonstrative sense of "justified". Which corpora's readings an opponent must
reject is not a variant package but a computed result — the opponent's burden
(`Testimony.Logic.Burden`), in `Testimony.Arguments.CanonicalWitness.Results`.
-/

namespace Testimony.Arguments.CanonicalWitness

open Testimony Testimony.Logic

/-- Every text the argument cites, from every corpus and from James. The rival
holds all of them. -/
@[canonicalWitnessDefs]
def allTexts : List (Formula Claim) :=
  paulineLine.grounds ++ hebrewsLine.grounds ++ johannineLine.grounds ++
    petrineLine.grounds ++ dominicalLine.grounds ++
    [p .james2_14_17, p .james2_19, p .james2_21_23, p .james2_24, p .jude20_21]

/-- **Trent.** It grants every text the canonical witness reads — its Decree on
Justification quotes most of them — and reads James 2:24 as the increase of a
justification already received, by works done in grace (Session VI, ch. 10).
So works are part of the ground, and faith alone is denied. -/
@[canonicalWitnessDefs]
def tridentine : ArgumentPackage Claim :=
  { name := "Trent, reading James 2:24 as justification increased by works"
  , cite := tridentineCite
  , premises := allTexts ++ [notP .jamesJustifiesDemonstratively, trentOnJames,
      notAloneIfWorksGround]
  , conclusion := notP .justificationByFaithAlone
  , conclusionLabel := "justification is not by faith alone"
  , inferences := [trentOnJamesSource] }

/-- **The canonical witness**: every corpus, each on its own reading, and the
three parts of faith alone put together. -/
@[canonicalWitnessDefs]
def canonicalCase : ArgumentPackage Claim :=
  { name := "The canonical witness to faith alone"
  , cite := cite
  , premises := caseOf corpora [] [toFaithAlone]
  , conclusion := p .justificationByFaithAlone
  , conclusionLabel := "justification is by faith alone"
  , inferences := corpora.filterMap Line.inference }

/-- **The canonical witness with James**: James read with the distinction
between justification and sanctification, and Jude as consistent with the rest.
It concludes the Reformed formula — faith alone, but a faith never alone. -/
@[canonicalWitnessDefs]
def canonicalWithJames : ArgumentPackage Claim :=
  { name := "The canonical witness, with James"
  , cite := cite
  , premises := caseOf (corpora ++ [jamesLine]) [p .jude20_21] [toFaithAlone, toNeverAlone]
  , conclusion := p .faithAloneNeverAlone
  , conclusionLabel := "justification is by faith alone, by a faith never alone"
  , inferences := (corpora ++ [jamesLine]).filterMap Line.inference }

/-! ### James without its hinge -/

/-- James without the demonstrative reading of "justified": his texts, and the
distinction between justification and sanctification, but not the sense of
2:21–24 on which James and Trent part. -/
@[canonicalWitnessDefs]
def jamesWithoutDemonstrative : Line Claim :=
  jamesLine.onGrounds
    [ p .james2_14_17, p .james2_19, p .james2_21_23, p .james2_24
    , p .james2TargetsDeadFaith, p .justificationDistinctFromSanctification ]

/-- The canonical witness with James, on that reading. -/
@[canonicalWitnessDefs]
def withJamesUndemonstrated : ArgumentPackage Claim :=
  { canonicalWithJames with
    name := "The canonical witness with James, without the demonstrative reading"
    premises :=
      caseOf (corpora ++ [jamesWithoutDemonstrative]) [p .jude20_21]
        [toFaithAlone, toNeverAlone] }

end Testimony.Arguments.CanonicalWitness
