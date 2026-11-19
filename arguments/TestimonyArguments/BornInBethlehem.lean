import TestimonyArguments.Attr
import Testimony.Argument
import Testimony.Logic.Line
import Testimony.Logic.Tactic
import Testimony.Scripture
import TestimonyArguments.Works

/-!
# TestimonyArguments.BornInBethlehem — Born in Bethlehem: Micah 5:2

When the magi came asking where the king of the Jews was to be born, Herod put
the question to the chief priests and scribes, and Matthew gives their answer:

> "In Bethlehem of Judea, for so it is written by the prophet: 'And you, O
> Bethlehem, in the land of Judah, are by no means least among the rulers of
> Judah; for from you shall come a ruler who will shepherd my people Israel.'"
> (Matthew 2:5–6)

The prophet is Micah, who prophesied in the eighth century before Christ:

> "But you, O Bethlehem Ephrathah, who are too little to be among the clans of
> Judah, from you shall come forth for me one who is to be ruler in Israel, whose
> coming forth is from of old, from ancient days." (Micah 5:2)

Matthew's form of the verse is not Micah's word for word, but that Matthew is
quoting Micah no one disputes, and it is recorded as a quotation. What is
disputed is what Micah meant. On the Christian reading, which Keil and
Delitzsch give in their commentary, the oracle looks forward: it names the
birthplace of the Messiah. R. T. France reads Matthew as claiming that
prediction fulfilled. On the critical reading, for which Raymond Brown's *The
Birth of the Messiah* is cited, the oracle is about a ruler of Micah's own day,
and no birthplace for a later Messiah follows from it.

Both readings are written out and checked. On the Christian premises the
conclusion follows, and it is carried all the way to a claim about a person:
that Jesus meets the criterion "born in Bethlehem" (`jesus_satisfies_bethlehem`).
On the critical premises it does not follow (`critical_not_establishes`).

Two things limit what that shows. The first is that the argument runs on a
single line of reason, from Micah's oracle through Matthew's reading of it. So
it is the weakest of the library's fulfilment arguments: deny the one reading of
Micah and nothing is left standing, which is why the critical reading costs its
holders so little. The argument "Born of a virgin", by contrast, runs on four
strands. The second is that the birth in Bethlehem is itself disputed as
history. Matthew and Luke both place it there, and Joseph Ratzinger, answering
the exegetes who read their Bethlehem as "a theological statement, not a
historical one", holds that "if we abide by the sources, it is clear that Jesus
was born in Bethlehem and grew up in Nazareth"; William Ramsay argued the same
a century before him. Raymond Brown judged the evidence for it "much weaker than
the evidence for Davidic descent", because of "such a general ignorance of
Jesus' birthplace" in the rest of the Gospels, and John Meier, while granting it
"cannot be positively ruled out", reads the Gospels' predominant view as that
Jesus came "only from Nazareth". So the claim is cited to those who hold it and
rated `disputed`, and the argument's conclusion is no surer than it. -/

namespace TestimonyArguments.BornInBethlehem

open Testimony

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
      -- Held by Ratzinger and Ramsay as history; doubted by Brown (Appendix III,
      -- "Birth at Bethlehem") and Meier. Pages for the lending copies are not
      -- verified, so those works are cited whole.
    , source :=
        { primary := .work ratzingerInfancyNarratives .whole
        , supporting :=
            [ .work ramsayBornAtBethlehem (.pages 97 98)
            , .scripture bethlehemBirthNarratives ]
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

One strand carries the argument's whole weight. If Micah 5:2 foretells the
Messiah's birthplace, and Matthew quotes it meaning that, then the Messiah must
be born in Bethlehem. If he must, and Jesus was, Jesus meets the criterion. -/

/-- From the predictive reading and Matthew's intent, the criterion follows. -/
@[bornInBethlehemDefs]
def toCriterion : Formula Claim :=
  ⋀ [p .micahPredictsBethlehem, p .matthewIntendsFulfilment] ➝ p .messiahBornInBethlehem

/-- From the criterion and the historical claim, the fulfilment follows. -/
@[bornInBethlehemDefs]
def toFulfilment : Formula Claim :=
  ⋀ [p .messiahBornInBethlehem, p .jesusBornInBethlehem] ➝ p .jesusSatisfiesCriterion

/-- The rating of the step from Micah's prediction and Matthew's intent to the
criterion that the Messiah be born in Bethlehem: `wellSupported`. Keil draws it:
"the coming forth from Bethlehem implies birth in Bethlehem", by "the divine
appointment that Christ was born in Bethlehem, the city of David". No reader was
found who grants the grounds and denies the conclusion. Radak reads the verse of
"the King Messiah" and gives as the reason that he will be "of the seed of David,
who was from Bethlehem"; that reads "come forth" as descent, and so bears on
what the first ground means, not on this step. -/
def predictiveInference : Source :=
  { primary := .work keilDelitzschMinorProphets (.adLoc micah5_2)
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **The predictive line.** Micah's oracle read as prophecy, Matthew's
quotation read as a fulfilment claim, and the criterion that follows. -/
@[bornInBethlehemDefs]
def predictiveLine : Line Claim :=
  { name := "Predictive reading of Micah 5:2"
  , grounds :=
      [ p .micahPredictsBethlehem, p .matthewQuotesMicah
      , p .matthewIntendsFulfilment ]
  , step := toCriterion
  , delivers := p .messiahBornInBethlehem
  , inference := some predictiveInference }

/-- **The critical line.** Matthew's quotation is granted, Micah's oracle is read
as one about a ruler of his own day, and the prediction is denied. The step is
the same, but its first ground is missing, so it delivers nothing. -/
@[bornInBethlehemDefs]
def criticalLine : Line Claim :=
  { predictiveLine with
    name := "Critical reading of Micah 5:2 as a near-term oracle"
    grounds :=
      [ p .matthewQuotesMicah, p .micahIsNearTermOracle
      , notP .micahPredictsBethlehem ] }

/-! ### Packages -/

/-- **The Christian reading**: the predictive line, with the claim that Jesus was
born in Bethlehem. -/
@[bornInBethlehemDefs]
def christian : ArgumentPackage Claim :=
  { name := "Christian predictive reading of Micah 5:2"
  , cite := cite
  , premises := caseOf [predictiveLine] [p .jesusBornInBethlehem] [toFulfilment]
  , conclusion := p .jesusSatisfiesCriterion
  , conclusionLabel := fulfillmentLabel jesus bornInBethlehem }

/-- **The critical reading**: the quotation is granted, the prediction is not. -/
@[bornInBethlehemDefs]
def critical : ArgumentPackage Claim :=
  { christian with
    name := "Critical reading of Micah 5:2 as a near-term oracle"
    premises := caseOf [criticalLine] [] [toFulfilment] }

/-! ### Results -/

/-- On the Christian premises, Jesus meets the Bethlehem criterion: if Micah
foretells the birthplace, Matthew claims the fulfilment, and Jesus was born
there, the conclusion follows. It does not show that any of the three is true;
the prediction and the birth are both disputed. -/
@[headline]
theorem christian_establishes : Establishes christian := by
  establish [bornInBethlehemDefs]

#print axioms christian_establishes

/-- The critical reading, written down: Micah's oracle concerns a ruler of
Micah's own day in Judah, so no birthplace for the Messiah is foretold, and
nothing about Jesus follows from it. Every critical premise holds on this
reading and the conclusion fails. -/
def criticalReading : Valuation Claim := fun a =>
  match a with
  | .micahPredictsBethlehem => False
  | .messiahBornInBethlehem => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- On the critical premises the conclusion does not follow: there is a way of
taking the texts, the critical reading above, on which every one of them holds
and Jesus does not meet the criterion. It does not show that the critical
reading is right, only that it can be held consistently. -/
@[headline]
theorem critical_not_establishes : ¬ Establishes critical := by
  refute_with criticalReading [bornInBethlehemDefs]

#print axioms critical_not_establishes

/-- End to end: on the Christian premises, Jesus satisfies the Bethlehem
criterion. This is the first result in the library that runs from cited
premises, through an entailment the machine checks, to a claim about a person.
It is conditional like every other result here: it holds for a reader who grants
the Christian premises, and says nothing to one who does not. -/
@[headline]
theorem jesus_satisfies_bethlehem : Satisfies jesus bornInBethlehem :=
  ⟨{ α := Claim
   , pkg := christian
   , valid := christian_establishes
   , concludes := rfl }⟩

#print axioms jesus_satisfies_bethlehem

/-! #### Satisfiability

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
  satisfied_by everythingHoldsReading [bornInBethlehemDefs]

end TestimonyArguments.BornInBethlehem
