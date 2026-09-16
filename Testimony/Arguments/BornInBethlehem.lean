import Testimony.Argument
import Testimony.Bib.Works

/-!
# Arguments.BornInBethlehem — Phase 1 vertical-slice seed

Matthew 2:5–6 quotes Micah 5:2 as grounds that the Messiah is born in
Bethlehem. This file encodes the passages, the quotation edge, one Christian
interpretation and its premise package. A rival (non-predictive) reading and
the assumption manifest are the next steps of Phase 1.
-/

namespace Testimony.Arguments.BornInBethlehem

open Testimony Testimony.Bib

/-- Micah 5:2 — the prophecy of a ruler from Bethlehem Ephrathah. -/
def micah5_2 : Passage := ⟨.micah, 5, 2⟩

/-- Matthew 2:6 — Matthew's citation of Micah in the chief priests' answer. -/
def matthew2_6 : Passage := ⟨.matthew, 2, 6⟩

/-- Matthew explicitly quotes Micah — this much is uncontroversial verbal
citation, attested across traditions. -/
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

/-- The premise package this argument is conditional on — each premise typed
and cited. THIS is the honest core of the project: the theorem downstream is
only as strong as this list, and the list is public. -/
def christianPackage : PremisePackage :=
  { name := "Christian predictive reading of Micah 5:2"
  , premises :=
    [ { name := "Micah 5:2 is a forward-looking Messianic prediction"
      , kind := .interpretive
      , source :=
          { primary := .work keilDelitzschMinorProphets (.adLoc micah5_2)
          , tradition := .christianTypological
          , confidence := .wellSupported } }
      -- Disputed in critical scholarship; honesty required. Note this premise
      -- cites scripture alone, which `Source.isScriptureOnly` will surface.
    , { name := "Jesus of Nazareth was born in Bethlehem"
      , kind := .historical
      , source :=
          { primary := .scripture
              [ { ref := .verse ⟨.matthew, 2, 1⟩ }
              , { ref := .range ⟨.luke, 2, 4, 2, 7⟩ } ]
          , tradition := .christianHistoricalGrammatical
          , confidence := .disputed } }
    , { name := "Matthew's quotation intends predictive fulfilment"
      , kind := .interpretive
      , source :=
          { primary := .work franceMatthew (.adLoc matthew2_6)
          , tradition := .christianHistoricalGrammatical
          , confidence := .wellSupported } } ] }

/-- The candidate this argument concerns. -/
def jesus : Person := ⟨"Jesus of Nazareth"⟩

end Testimony.Arguments.BornInBethlehem
