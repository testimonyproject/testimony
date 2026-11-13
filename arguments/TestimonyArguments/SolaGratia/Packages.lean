import TestimonyArguments.SolaGratia.Lines

/-!
# TestimonyArguments.SolaGratia.Packages — the positions, and the variants the results ask about

The rivals come first, because they were written first. Each is a position as
its own documents state it: Trent from the sixth session's decree and canons on
justification, the Remonstrants from their five articles of 1610 and from
Arminius. Neither is Pelagian. Both say, in so many words, that salvation is by
grace, and both packages carry the line from Romans 11:6 that delivers it.

The variants after the Reformed package each change one thing, named, so that a
result about a variant is a result about that one change.
-/

namespace TestimonyArguments.SolaGratia

open Testimony Testimony.Logic

/-- The label every package asked for the conclusion shares. -/
private def solaGratiaLabel : String :=
  "salvation by grace alone: grace brings about the consent it seeks, and the will " ++
  "contributes nothing to its own new life"

/-! ### The rivals -/

/-- **Trent**, from the sixth session (1547). Romans 11:6, which its eighth
chapter quotes; Zechariah 1:3 read with Lamentations 5:21, as its fifth chapter
reads them; and canon 4, on the will that cooperates by assenting and can refuse
if it wishes. -/
@[solaGratiaDefs]
def tridentine : ArgumentPackage Claim :=
  { name := "Trent (Session VI, canon 4)"
  , cite := tridentineCite
  , premises := caseOf [graceLine, cooperationLine, dissentLine] [] []
  , conclusion := solaGratia
  , conclusionLabel := solaGratiaLabel }

/-- **The Remonstrants**, from their articles of 1610 and from Arminius.
Romans 11:6; the fourth article, that grace is not irresistible, from Acts 7:51;
and what Arminius grants of the Reformed case: the texts of Ephesians 2, that
faith is God's gift, and that Romans 9:16 is about salvation. What is left out
is the two steps from those to God's work alone, which are the steps he
refuses. -/
@[solaGratiaDefs]
def remonstrant : ArgumentPackage Claim :=
  { name := "Remonstrant (the Five Articles, 1610)"
  , cite := remonstrantCite
  , premises :=
      caseOf [graceLine, resistanceLine]
        [ p .ephesians2_1to5, p .ephesians2_8to9, p .faithIsGodsGift
        , p .romans9_16, p .romans9_16ConcernsSalvation ] []
  , conclusion := solaGratia
  , conclusionLabel := solaGratiaLabel }

/-! ### The position argued for -/

/-- **The Reformed position**, as the Synod of Dort (1619) and the Westminster
Confession (1647) state it. Two routes to God's work alone, one through
Ephesians 2 and one through Romans 9:16, with Romans 11:6 for the first part of
the conclusion, and Dort's answer to Acts 7:51. -/
@[solaGratiaDefs]
def reformed : ArgumentPackage Claim :=
  { name := "Reformed (the Canons of Dort)"
  , cite := reformedCite
  , premises :=
      caseOf [graceLine, ephesiansLine, giftLine, romansLine] reformedShared closingSteps
  , conclusion := solaGratia
  , conclusionLabel := solaGratiaLabel }

/-! ### Each strand alone -/

/-- The Ephesians strand alone: Romans 11:6, Ephesians 2 with its reading of
"this", and the step from the gift to God's work alone. -/
@[solaGratiaDefs]
def ephesiansStrand : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, the Ephesians strand alone"
    premises := caseOf [graceLine, ephesiansLine, giftLine] reformedShared closingSteps }

/-- The Romans strand alone: Romans 11:6, and Romans 9:16 read as being about
salvation. -/
@[solaGratiaDefs]
def romansStrand : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, the Romans strand alone"
    premises := caseOf [graceLine, romansLine] reformedShared closingSteps }

/-- The Ephesians strand without the step Arminius refuses: every text and
reading it rests on, and the step to faith as God's gift, with only the step
from the gift to God's work alone left out. Dort's answer to Acts 7:51 is
not part of the strand, and is left out with the rest of what the strand does
not read. -/
@[solaGratiaDefs]
def ephesiansWithoutTheGiftStep : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, the Ephesians strand without the step from the gift"
    premises := caseOf [graceLine, ephesiansLine] [p .ephesians2_1to5] closingSteps }

/-! ### The readings, removed -/

/-- The Reformed position without its reading of "this" in Ephesians 2:8. The
Romans strand is untouched. -/
@[solaGratiaDefs]
def reformedWithoutTouto : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus its reading of \"this\" in Ephesians 2:8"
    premises :=
      caseOf [graceLine, ephesiansLine.onGrounds [p .ephesians2_8to9], giftLine, romansLine]
        reformedShared closingSteps }

/-- The Reformed position without the reading of Romans 9:16 as being about
salvation. The Ephesians strand is untouched. -/
@[solaGratiaDefs]
def reformedWithoutRomansReading : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus Romans 9:16 as being about salvation"
    premises :=
      caseOf [graceLine, ephesiansLine, giftLine, romansLine.onGrounds [p .romans9_16]]
        reformedShared closingSteps }

/-- The Reformed position without either reading. Every text is kept, and every
step. -/
@[solaGratiaDefs]
def reformedWithoutEitherReading : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus both readings"
    premises :=
      caseOf
        [ graceLine, ephesiansLine.onGrounds [p .ephesians2_8to9], giftLine
        , romansLine.onGrounds [p .romans9_16] ]
        reformedShared closingSteps }

end TestimonyArguments.SolaGratia
