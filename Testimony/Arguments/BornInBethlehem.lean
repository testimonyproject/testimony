import Testimony.Argument

/-!
# Arguments.BornInBethlehem — Phase 1 vertical-slice seed

Matthew 2:5–6 quotes Micah 5:2 as grounds that the Messiah is born in
Bethlehem. This file encodes the passages, the quotation edge, one Christian
interpretation and its premise package. A rival (non-predictive) reading and
the assumption manifest are the next steps of Phase 1.
-/

namespace Testimony.Arguments

open Testimony

def micah5_2 : Passage := ⟨.micah, 5, 2⟩
def matthew2_6 : Passage := ⟨.matthew, 2, 6⟩

/-- Matthew explicitly quotes Micah — this much is uncontroversial verbal
citation, attested across traditions. -/
def quotationEdge : IntertextEdge :=
  { fromPassage := matthew2_6
  , toPassage := micah5_2
  , relation := .quotation
  , source := { citation := "NA28 marginal cross-reference; UBS5 index of quotations"
              , tradition := .criticalScholarship
              , confidence := .consensus } }

/-- The Christian predictive reading of Micah 5:2. -/
def predictiveReading : Interpretation :=
  { passage := micah5_2
  , reading := "Micah 5:2 predicts the Messiah's birthplace as Bethlehem"
  , asRelation := some .prediction
  , source := { citation := "Keil & Delitzsch, Commentary on the Minor Prophets, ad loc."
              , tradition := .christianTypological
              , confidence := .wellSupported } }

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
      , source := { citation := "Keil & Delitzsch, ad loc."
                  , tradition := .christianTypological
                  , confidence := .wellSupported } }
    , { name := "Jesus of Nazareth was born in Bethlehem"
      , kind := .historical
      , source := { citation := "Matthew 2:1; Luke 2:4–7"
                  , tradition := .christianHistoricalGrammatical
                  , confidence := .disputed } }  -- disputed in critical scholarship; honesty required
    , { name := "Matthew's quotation intends predictive fulfilment"
      , kind := .interpretive
      , source := { citation := "France, The Gospel of Matthew (NICNT), ad loc."
                  , tradition := .christianHistoricalGrammatical
                  , confidence := .wellSupported } } ] }

def jesus : Person := ⟨"Jesus of Nazareth"⟩

end Testimony.Arguments
