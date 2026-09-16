import Testimony.Argument

/-!
# Arguments.BornOfAVirgin — Phase 2 vertical-slice seed

Matthew 1:22–23 quotes Isaiah 7:14 as grounds that the Messiah is born of a
virgin. Unlike Micah 5:2 (see `BornInBethlehem`), the predictive reading of
Isaiah 7:14 is itself heavily disputed: the Hebrew `almah` ("young woman")
does not by itself mean "virgin", the LXX's `parthenos` does, and Isaiah's
immediate context — a sign given to Ahaz, seemingly fulfilled within the
prophet's own generation (cf. Isa 8:3–4) — is read by most critical and much
Jewish scholarship as having nothing to do with a future Messiah. That
dispute is flagged here via `Confidence.disputed`; a formal rival
(near-term-sign) `Interpretation` is deferred to a follow-up, as with the
Bethlehem argument's rival reading.

Two independent gospel birth narratives (Matthew's and Luke's) agree on the
core historical claim — that Mary, betrothed to Joseph, conceived Jesus
while a virgin — despite differing in nearly every other narrative detail
(genealogies, visitors, order of events). That convergence is encoded as a
multiple-attestation premise below.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony

def isaiah7_14 : Passage := ⟨.isaiah, 7, 14⟩
def matthew1_23 : Passage := ⟨.matthew, 1, 23⟩

/-- Matthew explicitly quotes Isaiah — uncontroversial verbal citation,
attested across traditions, via the LXX's rendering of `almah` as
`parthenos` ("virgin"). -/
def quotationEdge : IntertextEdge :=
  { fromPassage := matthew1_23
  , toPassage := isaiah7_14
  , relation := .quotation
  , source := { citation := "NA28 marginal cross-reference; UBS5 index of quotations"
              , tradition := .criticalScholarship
              , confidence := .consensus } }

/-- The Christian predictive reading of Isaiah 7:14. Far more contested than
Micah 5:2 — see the module doc above. -/
def predictiveReading : Interpretation :=
  { passage := isaiah7_14
  , reading := "Isaiah 7:14 predicts a virgin conceiving and bearing 'Immanuel', ultimately fulfilled in the virgin birth of the Messiah"
  , asRelation := some .prediction
  , source := { citation := "J.A. Motyer, The Prophecy of Isaiah (IVP, 1993), ad loc."
              , tradition := .christianTypological
              , confidence := .disputed } }

def bornOfAVirgin : FulfillmentCriterion :=
  { name := "born of a virgin", basis := predictiveReading }

/-- The premise package this argument is conditional on — each premise typed
and cited. THIS is the honest core of the project: the theorem downstream is
only as strong as this list, and the list is public. -/
def christianPackage : PremisePackage :=
  { name := "Christian predictive reading of Isaiah 7:14"
  , premises :=
    [ { name := "Isaiah 7:14 is a forward-looking Messianic prediction of a virgin birth, not solely a near-term sign to Ahaz"
      , kind := .interpretive
      , source := { citation := "Motyer, The Prophecy of Isaiah, ad loc."
                  , tradition := .christianTypological
                  , confidence := .disputed } }  -- the almah/parthenos and near/far-fulfilment dispute is the crux of this argument
    , { name := "Mary, betrothed to Joseph, conceived Jesus while a virgin, before she and Joseph came together"
      , kind := .historical
      , source := { citation := "Matthew 1:18–25; Luke 1:26–38, 34–35"
                  , tradition := .christianHistoricalGrammatical
                  , confidence := .disputed } }  -- a miraculous conception is outside ordinary historical method; critical scholarship disputes or denies it
    , { name := "Matthew's and Luke's birth narratives are independent traditions that nonetheless agree on the virgin conception, satisfying a criterion of multiple attestation"
      , kind := .historical
      , source := { citation := "R.E. Brown, The Birth of the Messiah (Doubleday, 1993), 26–38"
                  , tradition := .christianHistoricalGrammatical
                  , confidence := .plausible } }  -- independence of Matthew's and Luke's sources is itself debated
    , { name := "Matthew's quotation of Isaiah 7:14 (via LXX 'parthenos') intends the virgin conception of Jesus as prophetic fulfilment"
      , kind := .interpretive
      , source := { citation := "R.T. France, The Gospel of Matthew (NICNT), ad loc."
                  , tradition := .christianHistoricalGrammatical
                  , confidence := .wellSupported } } ] }

def jesus : Person := ⟨"Jesus of Nazareth"⟩
def mary : Person := ⟨"Mary of Nazareth"⟩

end Testimony.Arguments.BornOfAVirgin
