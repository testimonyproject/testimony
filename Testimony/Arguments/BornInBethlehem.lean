import Testimony.Attr
import Testimony.Argument
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
-/

namespace Testimony.Arguments.BornInBethlehem

open Testimony Testimony.Bib Testimony.Logic

/-- Micah 5:2 — the prophecy of a ruler from Bethlehem Ephrathah. -/
@[nolint defsWithUnderscore] def micah5_2 : Passage := ⟨.micah, 5, 2⟩

/-- Matthew 2:6 — Matthew's citation of Micah. -/
@[nolint defsWithUnderscore] def matthew2_6 : Passage := ⟨.matthew, 2, 6⟩

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

/-- Shorthand for an atomic formula. -/
abbrev p (c : Claim) : Formula Claim := .atom c

/-- Negation, as Foundation defines it. -/
abbrev notP (c : Claim) : Formula Claim := .imp (.atom c) .falsum

/-- Matthew explicitly quotes Micah — uncontroversial verbal citation, attested
across traditions. -/
def quotationEdge : IntertextEdge :=
  { fromPassage := matthew2_6
  , toPassage := micah5_2
  , relation := .quotation
  , source :=
      { primary := .work na28 (.apparatus matthew2_6)
      , supporting := [.work ubs5 .whole]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

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

/-- The candidate this argument concerns. -/
def jesus : Person := ⟨"Jesus of Nazareth"⟩

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .micahPredictsBethlehem =>
    { label := "Micah 5:2 is a forward-looking Messianic prediction"
    , kind := .interpretive
    , source :=
        { primary := .work keilDelitzschMinorProphets (.adLoc micah5_2)
        , tradition := .christianTypological
        , confidence := .wellSupported } }
  | .matthewQuotesMicah =>
    { label := "Matthew 2:6 quotes Micah 5:2"
    , kind := .textual
    , source :=
        { primary := .work na28 (.apparatus matthew2_6)
        , supporting := [.work ubs5 .whole]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .matthewIntendsFulfilment =>
    { label := "Matthew's quotation intends predictive fulfilment"
    , kind := .interpretive
    , source :=
        { primary := .work franceMatthew (.adLoc matthew2_6)
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .jesusBornInBethlehem =>
    { label := "Jesus of Nazareth was born in Bethlehem"
    , kind := .historical
      -- Scripture alone, and disputed in critical scholarship. Surfaced by
      -- `scriptureOnlyAtoms`.
    , source :=
        { primary := .scripture
            [ { ref := .verse ⟨.matthew, 2, 1⟩ }
            , { ref := .range ⟨.luke, 2, 4, 2, 7⟩ } ]
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
    , source :=
        { primary := .work keilDelitzschMinorProphets (.adLoc micah5_2)
        , supporting := [.work franceMatthew (.adLoc matthew2_6)]
        , tradition := .christianTypological
        , confidence := .wellSupported } }
  | .jesusSatisfiesCriterion =>
    { label := "Jesus of Nazareth satisfies the Bethlehem criterion"
    , kind := .interpretive
    , source :=
        { primary := .work franceMatthew (.adLoc matthew2_6)
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }

/-- From the predictive reading and Matthew's intent, the criterion follows. -/
def toCriterion : Formula Claim :=
  .imp (conjOf [p .micahPredictsBethlehem, p .matthewIntendsFulfilment])
       (p .messiahBornInBethlehem)

/-- From the criterion and the historical claim, the fulfilment follows. -/
def toFulfilment : Formula Claim :=
  .imp (conjOf [p .messiahBornInBethlehem, p .jesusBornInBethlehem])
       (p .jesusSatisfiesCriterion)

/-- The Christian predictive argument. -/
def christian : ArgumentPackage Claim :=
  { name := "Christian predictive reading of Micah 5:2"
  , cite := cite
  , premises :=
      [ p .micahPredictsBethlehem, p .matthewQuotesMicah
      , p .matthewIntendsFulfilment, p .jesusBornInBethlehem
      , toCriterion, toFulfilment ]
  , conclusion := p .jesusSatisfiesCriterion
  , conclusionLabel := fulfillmentLabel jesus bornInBethlehem }

/-- The critical reading: the quotation is granted, the prediction is not. -/
def critical : ArgumentPackage Claim :=
  { name := "Critical reading of Micah 5:2 as a near-term oracle"
  , cite := cite
  , premises :=
      [ p .matthewQuotesMicah, p .micahIsNearTermOracle
      , notP .micahPredictsBethlehem, toCriterion, toFulfilment ]
  , conclusion := p .jesusSatisfiesCriterion
  , conclusionLabel := fulfillmentLabel jesus bornInBethlehem }

/-! ### Results -/

/-- Given the Christian premises, the conclusion follows. -/
@[headline]
theorem christian_establishes : Establishes christian := by
  intro w hw
  simp only [christian, toCriterion, toFulfilment, conjOf, p, List.mem_cons,
    List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
    FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

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
  refine not_entails_of_countermodel criticalReading ?_ ?_ <;>
    simp [critical, toCriterion, toFulfilment, conjOf, p, notP,
      FFL.Propositional.Formula.Boolean.val, criticalReading]

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

end Testimony.Arguments.BornInBethlehem
