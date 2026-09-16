import Testimony.Argument
import Testimony.Bib.Works

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

open Testimony Testimony.Bib

/-- Isaiah 7:14 — the sign of the `almah` who conceives and bears a son. -/
def isaiah7_14 : Passage := ⟨.isaiah, 7, 14⟩

/-- Matthew 1:23 — Matthew's citation of Isaiah via the LXX. -/
def matthew1_23 : Passage := ⟨.matthew, 1, 23⟩

/-- Matthew explicitly quotes Isaiah — uncontroversial verbal citation,
attested across traditions, via the LXX's rendering of `almah` as
`parthenos` ("virgin"). -/
def quotationEdge : IntertextEdge :=
  { fromPassage := matthew1_23
  , toPassage := isaiah7_14
  , relation := .quotation
  , source :=
      { primary := .work na28 (.apparatus matthew1_23)
      , supporting := [.work ubs5 .whole]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- The Christian predictive reading of Isaiah 7:14. Far more contested than
Micah 5:2 — see the module doc above. -/
def predictiveReading : Interpretation :=
  { passage := isaiah7_14
  , reading := "Isaiah 7:14 predicts a virgin conceiving and bearing 'Immanuel', ultimately fulfilled in the virgin birth of the Messiah"
  , asRelation := some .prediction
  , source :=
      { primary := .work motyerIsaiah (.adLoc isaiah7_14)
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- The criterion this argument establishes a candidate must meet. -/
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
      , source :=
          { primary := .work motyerIsaiah (.adLoc isaiah7_14)
          , tradition := .christianTypological
          -- The almah/parthenos and near/far-fulfilment dispute is the crux
          -- of this argument.
          , confidence := .disputed } }
    , { name := "Mary, betrothed to Joseph, conceived Jesus while a virgin, before she and Joseph came together"
      , kind := .historical
      -- A miraculous conception is outside ordinary historical method;
      -- critical scholarship disputes or denies it. This premise also cites
      -- scripture alone — `Source.isScriptureOnly` surfaces that.
      , source :=
          { primary := .scripture
              [ { ref := .range ⟨.matthew, 1, 18, 1, 25⟩ }
              , { ref := .range ⟨.luke, 1, 26, 1, 38⟩ } ]
          , tradition := .christianHistoricalGrammatical
          , confidence := .disputed } }
    , { name := "Matthew's and Luke's birth narratives are independent traditions that nonetheless agree on the virgin conception, satisfying a criterion of multiple attestation"
      , kind := .historical
      -- Independence of Matthew's and Luke's sources is itself debated.
      , source :=
          { primary := .work brownBirthMessiah (.pages 26 38)
          , tradition := .christianHistoricalGrammatical
          , confidence := .plausible } }
    , { name := "Matthew's quotation of Isaiah 7:14 (via LXX 'parthenos') intends the virgin conception of Jesus as prophetic fulfilment"
      , kind := .interpretive
      , source :=
          { primary := .work franceMatthew (.adLoc matthew1_23)
          , tradition := .christianHistoricalGrammatical
          , confidence := .wellSupported } } ] }

/-- The candidate this argument concerns. -/
def jesus : Person := ⟨"Jesus of Nazareth"⟩

/-- Mary, whose virginity at conception is the contested historical claim. -/
def mary : Person := ⟨"Mary of Nazareth"⟩

end Testimony.Arguments.BornOfAVirgin
