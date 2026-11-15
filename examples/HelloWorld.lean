import Testimony.Argument
import Testimony.Logic.Line
import Testimony.Logic.Tactic
import Testimony.Scripture

/-!
# HelloWorld — the smallest argument the library can check

Three claims, one inference step, one rival reading. It is a miniature of
`TestimonyArguments.BornInBethlehem`, small enough to read in one sitting, and
it is compiled with the rest of the examples so that the page which walks
through it (`docs/src/hello-world.md`) cannot drift from code that works.

It lives in its own namespace, `HelloWorld`, and not under `TestimonyExamples`,
because the checks in `TestimonyExamples.Checks` run over everything in that
namespace and their reports are pinned. A tutorial is not a case.
-/

namespace HelloWorld

open Testimony Testimony.Logic Testimony.Scripture

-- ANCHOR: claims
/-- The atomic claims. Each one is a sentence the logic never looks inside. -/
inductive Claim
  /-- Matthew 2:6 quotes Micah 5:2. A matter of what the text says. -/
  | matthewQuotesMicah
  /-- Matthew quotes Micah as a prophecy that Jesus fulfils. A matter of how
  Matthew's use of the verse is to be read. -/
  | matthewReadsItAsFulfilled
  /-- Matthew intends the quotation as an application of an older text to a
  new situation, not as the fulfilment of a prediction. The rival reading. -/
  | matthewApplies
  /-- **The conclusion.** Matthew presents Micah 5:2 as fulfilled. -/
  | matthewPresentsFulfilment
deriving DecidableEq, Repr
-- ANCHOR_END: claims

-- ANCHOR: cite
/-- Citation and classification for every claim. The function is total, so a
claim with no citation does not compile. -/
def cite : Claim → AtomMeta
  | .matthewQuotesMicah =>
    { label := "Matthew 2:6 quotes Micah 5:2"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse matthew2_6 }, { ref := .verse micah5_2 }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .matthewReadsItAsFulfilled =>
    { label := "Matthew reads Micah 5:2 as a prophecy fulfilled in Jesus"
    , kind := .interpretive
    , source :=
        { primary := .scripture [{ ref := .verse matthew2_6 }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .matthewApplies =>
    { label := "Matthew applies Micah 5:2 to a new situation without claiming a fulfilment"
    , kind := .interpretive
    , source :=
        { primary := .proposal
            "A stand-in for the critical reading, for this tutorial only. \
             BornInBethlehem cites the commentary that holds it."
        , tradition := .criticalScholarship
        , confidence := .plausible } }
  | .matthewPresentsFulfilment =>
    { label := "Matthew presents Micah 5:2 as fulfilled"
    , kind := .interpretive
    , source :=
        { primary := .scripture [{ ref := .verse matthew2_6 }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
-- ANCHOR_END: cite

-- ANCHOR: implication
/-- **The implication.** If Matthew quotes Micah, and reads the quotation as
a fulfilment, then Matthew presents Micah 5:2 as fulfilled. Read `⋀ [A, B] ➝ C`
as "A and B together give C". -/
def toFulfilment : Formula Claim :=
  ⋀ [p .matthewQuotesMicah, p .matthewReadsItAsFulfilled] ➝ p .matthewPresentsFulfilment

/-- **A line of reason**: the grounds it rests on, the step that carries them,
and what it delivers if the grounds are granted. -/
def fulfilmentLine : Line Claim :=
  { name := "Matthew's quotation as a fulfilment"
  , grounds := [p .matthewQuotesMicah, p .matthewReadsItAsFulfilled]
  , step := toFulfilment
  , delivers := p .matthewPresentsFulfilment }
-- ANCHOR_END: implication

-- ANCHOR: packages
/-- **A package is a position.** Its premises, its conclusion, and a citation
for every claim either mentions. -/
def traditional : ArgumentPackage Claim :=
  { name := "Matthew quotes Micah as a fulfilment"
  , cite := cite
  , premises := caseOf [fulfilmentLine] [] []
  , conclusion := p .matthewPresentsFulfilment
  , conclusionLabel := "Matthew presents Micah 5:2 as fulfilled" }

/-- **The rival is written down too.** It grants the quotation, denies the
reading, and so the same step delivers nothing. -/
def applicationLine : Line Claim :=
  { fulfilmentLine with
    name := "Matthew's quotation as an application"
    grounds := [p .matthewQuotesMicah, p .matthewApplies, notP .matthewReadsItAsFulfilled] }

/-- The rival position: same step, same conclusion, different grounds. -/
def application : ArgumentPackage Claim :=
  { traditional with
    name := "Matthew applies Micah as an older text for a new situation"
    premises := caseOf [applicationLine] [] [] }
-- ANCHOR_END: packages

-- ANCHOR: results
/-- **A conclusion follows.** Grant the traditional premises, and Matthew
presents Micah 5:2 as fulfilled. Lean checks the step; it does not check that
the premises are true. -/
theorem traditional_establishes : Establishes traditional := by
  establish [traditional, fulfilmentLine, toFulfilment]

#print axioms traditional_establishes

/-- **The rival's reading, written down.** Everything is granted except that
Matthew reads the quotation as a fulfilment, so nothing about fulfilment
follows. A countermodel is the rival position, with a name. -/
def applicationReading : Valuation Claim := fun a =>
  match a with
  | .matthewReadsItAsFulfilled => False
  | .matthewPresentsFulfilment => False
  | _ => True

/-- **A conclusion does not follow.** The rival's premises do not establish
the conclusion. This is not a failure to find a proof: `applicationReading` is
a way for every premise of `application` to hold while the conclusion fails. -/
theorem application_not_establishes : ¬ Establishes application := by
  refute_with applicationReading
    [application, traditional, applicationLine, fulfilmentLine, toFulfilment]

#print axioms application_not_establishes
-- ANCHOR_END: results

end HelloWorld
