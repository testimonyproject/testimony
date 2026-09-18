import Testimony.Attr
import Testimony.Argument
import Testimony.Logic.Line
import Testimony.Logic.Tactic
import Testimony.Scripture
import Testimony.Bib.Works

/-!
# Arguments.BornInBethlehem — Phase 1 vertical slice

Matthew 2:5–6 quotes Micah 5:2 as grounds that the Messiah is born in
Bethlehem. Both the Christian predictive reading and a critical reading are
encoded, and the argument is carried through to a `SatisfactionWitness` — the
first end-to-end connection from cited premises to a claim that a person meets
a messianic criterion.

`jesusBornInBethlehem` is cited to scripture alone. That is visible in the
generated manifest via `scriptureOnlyAtoms`, and it should be: the historicity
of the Bethlehem birth is disputed in critical scholarship, and an argument
that assumes it on the authority of the texts whose reading is in question is
assuming part of what it sets out to show.

The argument is short enough to stay in one file. It runs on a **single line of
reason**, which is exactly why it is the weakest of the fulfilment arguments
and why `critical_not_establishes` costs the rival so little: deny the one
interpretive premise and nothing is left standing. Compare `BornOfAVirgin`,
which runs on four.
-/

namespace Testimony.Arguments.BornInBethlehem

open Testimony Testimony.Bib Testimony.Logic
open Testimony.People Testimony.Scripture

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- Micah 5:2 is a forward-looking Messianic prediction of a birthplace. -/
  | micahPredictsBethlehem
  /-- Matthew 2:6 quotes Micah 5:2 — uncontroversial verbal citation. -/
  | matthewQuotesMicah
  /-- Matthew's quotation intends predictive fulfilment. -/
  | matthewIntendsFulfilment
  /-- Jesus of Nazareth was born in Bethlehem. -/
  | jesusBornInBethlehem
  /-- Micah 5:2 is a near-term oracle about a contemporary Judaean ruler. The
  critical reading. -/
  | micahIsNearTermOracle
  /-- The Messiah must be born in Bethlehem. -/
  | messiahBornInBethlehem
  /-- Jesus satisfies the Bethlehem criterion. **The conclusion.** -/
  | jesusSatisfiesCriterion
deriving DecidableEq, Repr

/-- Matthew explicitly quotes Micah — uncontroversial verbal citation, attested
across traditions. -/
def quotationEdge : IntertextEdge :=
  { fromPassage := matthew2_6
  , toPassage := micah5_2
  , relation := .quotation
  , source := na28Apparatus matthew2_6 }

/-- The Christian predictive reading of Micah 5:2. -/
def predictiveReading : Interpretation :=
  { passage := micah5_2
  , reading := "Micah 5:2 predicts the Messiah's birthplace as Bethlehem"
  , asRelation := some .prediction
  , source :=
      { primary := .work keilDelitzschMinorProphets (.adLoc micah5_2)
      , tradition := .christianTypological
      , confidence := .wellSupported } }

/-- The criterion this argument establishes a candidate must meet. -/
def bornInBethlehem : FulfillmentCriterion :=
  { name := "born in Bethlehem", basis := predictiveReading }

/-- Keil and Delitzsch on Micah 5:2, the commentary this argument's
interpretive premises rest on. -/
private def keilOnMicah : Source :=
  { primary := .work keilDelitzschMinorProphets (.adLoc micah5_2)
  , tradition := .christianTypological
  , confidence := .wellSupported }

/-- France on Matthew 2:6, the commentary this argument's claims about
Matthew's intent rest on. -/
private def franceOnMatthew : Source :=
  { primary := .work franceMatthew (.adLoc matthew2_6)
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .micahPredictsBethlehem =>
    { label := "Micah 5:2 is a forward-looking Messianic prediction"
    , kind := .interpretive
    , source := keilOnMicah }
  | .matthewQuotesMicah =>
    { label := "Matthew 2:6 quotes Micah 5:2"
    , kind := .textual
    , source := na28Apparatus matthew2_6 }
  | .matthewIntendsFulfilment =>
    { label := "Matthew's quotation intends predictive fulfilment"
    , kind := .interpretive
    , source := franceOnMatthew }
  | .jesusBornInBethlehem =>
    { label := "Jesus of Nazareth was born in Bethlehem"
    , kind := .historical
      -- Scripture alone, and disputed in critical scholarship. Surfaced by
      -- `scriptureOnlyAtoms`.
    , source :=
        { primary := .scripture bethlehemBirthNarratives
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .micahIsNearTermOracle =>
    { label := "Micah 5:2 is a near-term oracle about a contemporary Judaean ruler"
    , kind := .interpretive
    , source :=
        { primary := .work brownBirthMessiah .whole
        , tradition := .criticalScholarship
        , confidence := .plausible } }
  | .messiahBornInBethlehem =>
    { label := "The Messiah must be born in Bethlehem"
    , kind := .interpretive
    , source := { keilOnMicah with supporting := [.work franceMatthew (.adLoc matthew2_6)] } }
  | .jesusSatisfiesCriterion =>
    { label := "Jesus of Nazareth satisfies the Bethlehem criterion"
    , kind := .interpretive
    , source := franceOnMatthew }

/-! ### The line of reason

One strand, and the argument's whole weight is on it. -/

/-- From the predictive reading and Matthew's intent, the criterion follows. -/
def toCriterion : Formula Claim :=
  ⋀ [p .micahPredictsBethlehem, p .matthewIntendsFulfilment] 🡒 p .messiahBornInBethlehem

/-- From the criterion and the historical claim, the fulfilment follows. -/
def toFulfilment : Formula Claim :=
  ⋀ [p .messiahBornInBethlehem, p .jesusBornInBethlehem] 🡒 p .jesusSatisfiesCriterion

/-- **The predictive line.** Micah's oracle read as prophecy, Matthew's
quotation read as a fulfilment claim, and the criterion that follows. -/
def predictiveLine : Line Claim :=
  { name := "Predictive reading of Micah 5:2"
  , grounds :=
      [ p .micahPredictsBethlehem, p .matthewQuotesMicah
      , p .matthewIntendsFulfilment ]
  , step := toCriterion
  , delivers := p .messiahBornInBethlehem }

/-- The critical line: the quotation is granted and the prediction denied, so
the same step delivers nothing. -/
def criticalLine : Line Claim :=
  { predictiveLine with
    name := "Critical reading of Micah 5:2 as a near-term oracle"
    grounds :=
      [ p .matthewQuotesMicah, p .micahIsNearTermOracle
      , notP .micahPredictsBethlehem ] }

/-! ### Packages -/

/-- The Christian predictive argument. -/
def christian : ArgumentPackage Claim :=
  { name := "Christian predictive reading of Micah 5:2"
  , cite := cite
  , premises := caseOf [predictiveLine] [p .jesusBornInBethlehem] [toFulfilment]
  , conclusion := p .jesusSatisfiesCriterion
  , conclusionLabel := fulfillmentLabel jesus bornInBethlehem }

/-- The critical reading: the quotation is granted, the prediction is not. -/
def critical : ArgumentPackage Claim :=
  { christian with
    name := "Critical reading of Micah 5:2 as a near-term oracle"
    premises := caseOf [criticalLine] [] [toFulfilment] }

/-! ### Results -/

/-- Given the Christian premises, the conclusion follows. -/
@[headline]
theorem christian_establishes : Establishes christian := by
  establish [christian, predictiveLine, toCriterion, toFulfilment]

#print axioms christian_establishes

/-- The critical reading, written down: Micah's oracle concerns a contemporary
Judaean ruler, so no messianic birthplace criterion arises and nothing about
Jesus follows from it. -/
def criticalReading : Valuation Claim := fun a =>
  match a with
  | .micahPredictsBethlehem => False
  | .messiahBornInBethlehem => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- The critical reading does not establish the conclusion. -/
@[headline]
theorem critical_not_establishes : ¬ Establishes critical := by
  refute_with criticalReading [critical, christian, criticalLine, predictiveLine,
    toCriterion, toFulfilment]

#print axioms critical_not_establishes

/-- End to end: under the Christian package, Jesus satisfies the Bethlehem
criterion. This is the first result in the library that runs from cited
premises through a machine-checked entailment to a claim about a person. -/
@[headline]
theorem jesus_satisfies_bethlehem : Satisfies jesus bornInBethlehem :=
  ⟨{ α := Claim
   , pkg := christian
   , valid := christian_establishes
   , concludes := rfl }⟩

#print axioms jesus_satisfies_bethlehem

/-! ### Satisfiability

`Entails` is vacuously true over a premise set with no model, so a package built
from contradictory premises would establish its conclusion with every gate
passing. Only the package carrying a positive `Establishes` result needs
checking: `critical` has a countermodel already, and a countermodel is a
valuation satisfying every premise.

Not tagged `@[headline]` — a claim about the health of the encoding rather than
about Micah. -/

/-- The reading on which every claim in this argument holds at once. -/
def everythingHoldsReading : Valuation Claim := fun _ => True

/-- The Christian package has a model, so `christian_establishes` is not
vacuous. -/
theorem christian_is_satisfiable : Satisfiable christian.premises := by
  satisfied_by everythingHoldsReading [christian, predictiveLine, toCriterion,
    toFulfilment]

end Testimony.Arguments.BornInBethlehem
