import Testimony.Attr
import Testimony.Argument
import Testimony.Bib.Works

/-!
# Arguments.BornOfAVirgin — Isaiah 7:14 and the virgin birth

Matthew 1:22–23 quotes Isaiah 7:14 as grounds that the Messiah is born of a
virgin. Unlike Micah 5:2 (see `BornInBethlehem`), the predictive reading here is
heavily disputed, and the dispute is lexical: the Hebrew עַלְמָה (*almah*) means
"young woman" and does not by itself mean "virgin", while the Septuagint's
παρθένος does. Isaiah's immediate context — a sign to Ahaz, apparently fulfilled
within the prophet's own generation (cf. Isa 8:3–4) — is read by most critical
and much Jewish scholarship as having nothing to do with a future Messiah.

`almah_is_load_bearing` makes that precise: the lexical premise carries the
argument, exactly as `worksOfLawMeansWorksGenerally` carries sola fide. Two of
the library's three fully worked arguments turn out to hinge on the sense of a
single word, which is itself a result worth having.

Matthew's and Luke's birth narratives agree on the virgin conception while
differing in nearly every other detail, and that convergence is encoded as a
multiple-attestation premise — though the independence of the two traditions is
itself debated, and is marked `plausible` rather than `wellSupported`.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony Testimony.Bib Testimony.Logic

set_option maxRecDepth 40000

/-- Isaiah 7:14 — the sign of the *almah* who conceives and bears a son. -/
@[nolint defsWithUnderscore] def isaiah7_14 : Passage := ⟨.isaiah, 7, 14⟩

/-- Matthew 1:23 — Matthew's citation of Isaiah via the Septuagint. -/
@[nolint defsWithUnderscore] def matthew1_23 : Passage := ⟨.matthew, 1, 23⟩

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- Isaiah 7:14 predicts a virgin conceiving, fulfilled in the Messiah. -/
  | isaiahPredictsVirginBirth
  /-- עַלְמָה in Isaiah 7:14 denotes a virgin, not merely a young woman.
  **The disputed premise.** -/
  | almahMeansVirgin
  /-- The Septuagint renders עַלְמָה as παρθένος. -/
  | lxxRendersParthenos
  /-- Matthew 1:23 quotes Isaiah 7:14. -/
  | matthewQuotesIsaiah
  /-- Matthew's quotation intends the virgin conception as fulfilment. -/
  | matthewIntendsFulfilment
  /-- Mary conceived Jesus while a virgin. -/
  | maryConceivedAsVirgin
  /-- Matthew and Luke are independent traditions agreeing on the virgin
  conception. -/
  | independentAttestation
  /-- Isaiah 7:14 is a near-term sign to Ahaz, fulfilled in Isaiah's own
  generation. The critical reading. -/
  | isaiahIsNearTermSignToAhaz
  /-- The Messiah must be born of a virgin. -/
  | messiahBornOfVirgin
  /-- Jesus satisfies the virgin-birth criterion. **The conclusion.** -/
  | jesusSatisfiesCriterion
deriving DecidableEq, Repr

instance : FiniteAtoms Claim where
  elems :=
    [ .isaiahPredictsVirginBirth, .almahMeansVirgin, .lxxRendersParthenos
    , .matthewQuotesIsaiah, .matthewIntendsFulfilment, .maryConceivedAsVirgin
    , .independentAttestation, .isaiahIsNearTermSignToAhaz
    , .messiahBornOfVirgin, .jesusSatisfiesCriterion ]
  complete a := by cases a <;> simp

/-- Shorthand for an atomic formula. -/
abbrev p (c : Claim) : Formula Claim := .atom c

/-- Negation, as Foundation defines it. -/
abbrev notP (c : Claim) : Formula Claim := .imp (.atom c) .falsum

/-- Matthew explicitly quotes Isaiah, via the Septuagint's παρθένος. -/
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
Micah 5:2 — see the module doc. -/
def predictiveReading : Interpretation :=
  { passage := isaiah7_14
  , reading :=
      "Isaiah 7:14 predicts a virgin conceiving and bearing 'Immanuel', " ++
      "fulfilled in the virgin birth of the Messiah"
  , asRelation := some .prediction
  , source :=
      { primary := .work motyerIsaiah (.adLoc isaiah7_14)
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- The criterion this argument establishes a candidate must meet. -/
def bornOfAVirgin : FulfillmentCriterion :=
  { name := "born of a virgin", basis := predictiveReading }

/-- The candidate this argument concerns. -/
def jesus : Person := ⟨"Jesus of Nazareth"⟩

/-- Mary, whose virginity at conception is the contested historical claim. -/
def mary : Person := ⟨"Mary of Nazareth"⟩

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .isaiahPredictsVirginBirth =>
    { label := "Isaiah 7:14 is a Messianic prediction of a virgin birth"
    , kind := .interpretive
    , source :=
        { primary := .work motyerIsaiah (.adLoc isaiah7_14)
        , tradition := .christianTypological
        , confidence := .disputed } }
  | .almahMeansVirgin =>
    { label := "עַלְמָה in Isaiah 7:14 denotes a virgin, not merely a young woman"
    , kind := .linguistic
      -- The crux. The Hebrew term does not by itself carry the sense; the
      -- Septuagint's παρθένος does.
    , source :=
        { primary := .work motyerIsaiah (.adLoc isaiah7_14)
        , supporting := [.work bhs (.apparatus isaiah7_14)]
        , tradition := .christianTypological
        , confidence := .disputed } }
  | .lxxRendersParthenos =>
    { label := "The Septuagint renders עַלְמָה at Isaiah 7:14 as παρθένος"
    , kind := .textual
    , source :=
        { primary := .work na28 (.apparatus matthew1_23)
        , supporting := [.work franceMatthew (.adLoc matthew1_23)]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .matthewQuotesIsaiah =>
    { label := "Matthew 1:23 quotes Isaiah 7:14"
    , kind := .textual
    , source :=
        { primary := .work na28 (.apparatus matthew1_23)
        , supporting := [.work ubs5 .whole]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .matthewIntendsFulfilment =>
    { label := "Matthew's quotation intends the virgin conception as fulfilment"
    , kind := .interpretive
    , source :=
        { primary := .work franceMatthew (.adLoc matthew1_23)
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .maryConceivedAsVirgin =>
    { label := "Mary conceived Jesus while a virgin"
    , kind := .historical
      -- Scripture alone. A miraculous conception is outside ordinary
      -- historical method; critical scholarship disputes or denies it.
    , source :=
        { primary := .scripture
            [ { ref := .range ⟨.matthew, 1, 18, 1, 25⟩ }
            , { ref := .range ⟨.luke, 1, 26, 1, 38⟩ } ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .independentAttestation =>
    { label :=
        "Matthew and Luke are independent traditions agreeing on the virgin conception"
    , kind := .historical
      -- The independence of the two sources is itself debated.
    , source :=
        { primary := .work brownBirthMessiah (.pages 26 38)
        , tradition := .christianHistoricalGrammatical
        , confidence := .plausible } }
  | .isaiahIsNearTermSignToAhaz =>
    { label := "Isaiah 7:14 is a near-term sign to Ahaz, fulfilled in Isaiah's generation"
    , kind := .interpretive
    , source :=
        { primary := .work brownBirthMessiah .whole
        , tradition := .criticalScholarship
        , confidence := .wellSupported } }
  | .messiahBornOfVirgin =>
    { label := "The Messiah must be born of a virgin"
    , kind := .interpretive
    , source :=
        { primary := .work motyerIsaiah (.adLoc isaiah7_14)
        , supporting := [.work franceMatthew (.adLoc matthew1_23)]
        , tradition := .christianTypological
        , confidence := .disputed } }
  | .jesusSatisfiesCriterion =>
    { label := "Jesus of Nazareth satisfies the virgin-birth criterion"
    , kind := .interpretive
    , source :=
        { primary := .work franceMatthew (.adLoc matthew1_23)
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }

/-- From the predictive reading, the lexical premise and Matthew's intent, the
criterion follows. -/
def toCriterion : Formula Claim :=
  .imp (conjOf
        [ p .isaiahPredictsVirginBirth, p .almahMeansVirgin
        , p .matthewIntendsFulfilment ])
       (p .messiahBornOfVirgin)

/-- From the criterion and the historical claim, the fulfilment follows. -/
def toFulfilment : Formula Claim :=
  .imp (conjOf [p .messiahBornOfVirgin, p .maryConceivedAsVirgin])
       (p .jesusSatisfiesCriterion)

/-- The Christian predictive argument. -/
def christian : ArgumentPackage Claim :=
  { name := "Christian predictive reading of Isaiah 7:14"
  , cite := cite
  , premises :=
      [ p .isaiahPredictsVirginBirth, p .almahMeansVirgin, p .lxxRendersParthenos
      , p .matthewQuotesIsaiah, p .matthewIntendsFulfilment
      , p .maryConceivedAsVirgin, p .independentAttestation
      , toCriterion, toFulfilment ]
  , conclusion := p .jesusSatisfiesCriterion
  , conclusionLabel := fulfillmentLabel jesus bornOfAVirgin }

/-- The Christian package with the lexical premise removed, everything else
retained. Stated explicitly so that it reduces under `decide`. -/
def christianWithoutAlmah : ArgumentPackage Claim :=
  { christian with
    name := "Christian reading, minus the lexical premise"
    premises :=
      [ p .isaiahPredictsVirginBirth, p .lxxRendersParthenos
      , p .matthewQuotesIsaiah, p .matthewIntendsFulfilment
      , p .maryConceivedAsVirgin, p .independentAttestation
      , toCriterion, toFulfilment ] }

/-- The critical reading: the quotation and the Septuagint rendering are
granted, the Hebrew lexical claim and the prediction are denied. -/
def critical : ArgumentPackage Claim :=
  { name := "Critical reading of Isaiah 7:14 as a near-term sign"
  , cite := cite
  , premises :=
      [ p .lxxRendersParthenos, p .matthewQuotesIsaiah
      , p .isaiahIsNearTermSignToAhaz, notP .almahMeansVirgin
      , notP .isaiahPredictsVirginBirth, toCriterion, toFulfilment ]
  , conclusion := p .jesusSatisfiesCriterion
  , conclusionLabel := fulfillmentLabel jesus bornOfAVirgin }

/-- Given the Christian premises, the conclusion follows. -/
@[headline]
theorem christian_establishes : Establishes christian := by
  apply entails_of_check
  decide

#print axioms christian_establishes

/-- The critical reading does not establish the conclusion. -/
@[headline]
theorem critical_not_establishes : ¬ Establishes critical := by
  apply not_entails_of_check
  decide

#print axioms critical_not_establishes

/-- The lexical premise about עַלְמָה is load-bearing: remove it and the
argument collapses, everything else retained.

This is the same shape of result as `SolaFide.worksOfLaw_is_load_bearing`. Two
of the library's worked arguments turn on the sense of a single word. -/
@[headline]
theorem almah_is_load_bearing : ¬ Establishes christianWithoutAlmah := by
  apply not_entails_of_check
  decide

#print axioms almah_is_load_bearing

/-- End to end: under the Christian package, Jesus satisfies the virgin-birth
criterion. -/
@[headline]
theorem jesus_satisfies_virgin_birth : Satisfies jesus bornOfAVirgin :=
  ⟨{ α := Claim
   , pkg := christian
   , valid := christian_establishes
   , concludes := rfl }⟩

#print axioms jesus_satisfies_virgin_birth

end Testimony.Arguments.BornOfAVirgin
