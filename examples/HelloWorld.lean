import Testimony.Argument
import Testimony.Logic.Line
import Testimony.Logic.Tactic
import Testimony.Scripture

/-!
# HelloWorld — the smallest argument the library can check

Matthew tells how the wise men came to Herod asking where the new king was to
be born, and how the chief priests and scribes answered: "In Bethlehem of
Judea, for so it is written by the prophet" (Matthew 2:5). Then they quote
Micah: "And you, O Bethlehem, in the land of Judah, are by no means least among
the rulers of Judah; for from you shall come a ruler who will shepherd my people
Israel" (Matthew 2:6, ESV, quoting Micah 5:2; the last line is from 2 Samuel
5:2). Christians have long read Matthew as saying
that Micah's words came true in Jesus. A reader can also take Matthew to be
borrowing an old text for a new occasion, without claiming that it predicted
anything. That second reading is a stand-in written for this example and cited
to no one; the full argument puts the critical reading in its own words, with
Raymond Brown's source. This file writes both readings down and asks the
computer one question of each: does the conclusion follow?

It is the smallest complete argument the library can check: four claims, one
step of reasoning, one rival reading, two results. It is a miniature of the
full argument `TestimonyArguments.BornInBethlehem`, small enough to read in one
sitting. The page `docs/src/hello-world.md` walks through it block by block, and
copies each block from this file, so the page cannot drift from code that
works.

You do not need to be able to write this to contribute. A contributor working
with Claude Code describes the argument in plain words, and Claude writes the
Lean. What a contributor needs is to be able to read a file like this one well
enough to say "yes, that is what I meant", or "no, that premise is wrong".

It lives in its own namespace, `HelloWorld`, and not under `TestimonyExamples`,
because the checks in `TestimonyExamples.Checks` run over everything in that
namespace and their reports are pinned. A tutorial is not a case.
-/

namespace HelloWorld

open Testimony Testimony.Logic Testimony.Scripture

-- ANCHOR: claims
-- Every claim the argument uses, listed once and given a short name.
-- `inductive Claim` starts the list; each `|` line is one claim; the text
-- in `/-- ... -/` above each is what the claim says, in English.
-- The computer never reads that English. It only checks how the named claims
-- are joined, so the English is where a human reader checks the meaning.

/-- The claims of the argument. Each is a sentence the logic treats as a single
unit: it can be granted or denied, but the logic never looks inside it. -/
inductive Claim
  /-- Matthew 2:6 quotes Micah 5:2. This is about what the text says, and
  nobody disputes it. -/
  | matthewQuotesMicah
  /-- Matthew quotes Micah as a prophecy, and means that Jesus fulfils it.
  This is about how Matthew's use of the verse should be read. -/
  | matthewReadsItAsFulfilled
  /-- Matthew uses the quotation as an application: he borrows an older text
  for a new situation, without claiming that it predicted this one. This is
  the rival reading. -/
  | matthewApplies
  /-- The conclusion: Matthew presents Micah 5:2 as fulfilled. -/
  | matthewPresentsFulfilment
-- This last line asks Lean to let claims be compared and printed. It is the
-- same on every argument, and a reader can skip it.
deriving DecidableEq, Repr
-- ANCHOR_END: claims

-- ANCHOR: cite
-- A citation for every claim: where it comes from, which tradition reads it
-- that way, and how firmly the claim is held. The ratings, from weakest to
-- strongest, are `disputed`, `plausible`, `wellSupported` and `consensus`.
-- Lean refuses to build this file if any claim is left without a citation.

/-- A citation for every claim. Lean checks that every claim in the list above
has one: leave one out and the file does not build. -/
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
            "A stand-in rival written for this tutorial and cited to no one. \
             BornInBethlehem states the critical reading it simplifies, Micah 5:2 \
             as a near-term oracle, and cites Brown for it."
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
-- One step of reasoning: "if these claims hold, that one follows".
-- `p .name` means "this claim holds". `⋀ [A, B]` means "A and B together".
-- The arrow `➝` means "therefore": the claims on its left give the one on
-- its right.

/-- The step. If Matthew quotes Micah, and reads the quotation as a fulfilment,
then Matthew presents Micah 5:2 as fulfilled. Read `⋀ [A, B] ➝ C` as "A and B
together give C". -/
def toFulfilment : Formula Claim :=
  ⋀ [p .matthewQuotesMicah, p .matthewReadsItAsFulfilled] ➝ p .matthewPresentsFulfilment

/-- A line of reason: the claims it starts from (its grounds), the step that
joins them, and what it delivers if the grounds are granted. It is how the
library writes down one stretch of an argument as a person would say it:
"Matthew quotes Micah, and he means it as a fulfilment, so he presents it as
fulfilled." -/
def fulfilmentLine : Line Claim :=
  { name := "Matthew's quotation as a fulfilment"
  , grounds := [p .matthewQuotesMicah, p .matthewReadsItAsFulfilled]
  , step := toFulfilment
  , delivers := p .matthewPresentsFulfilment }
-- ANCHOR_END: implication

-- ANCHOR: packages
-- A position is called a package. It bundles the lines of reason someone
-- holds, the conclusion they draw, and the citations above.
-- The library will not take one reading without its rival, so the rival
-- reading is written straight after it. `notP .name` means "this claim
-- does not hold".

/-- The traditional position, as a package: its premises, its conclusion, and
a citation for every claim either mentions. -/
def traditional : ArgumentPackage Claim :=
  { name := "Matthew quotes Micah as a fulfilment"
  , cite := cite
  , premises := caseOf [fulfilmentLine] [] []
  , conclusion := p .matthewPresentsFulfilment
  , conclusionLabel := "Matthew presents Micah 5:2 as fulfilled" }

/-- The rival's line of reason. It grants that Matthew quotes Micah, holds that
he applies the verse, and denies that he reads it as a fulfilment. It keeps the
same step, but that step needs the fulfilment reading as a ground, and the rival
denies it, so the step never applies. Writing it as "the traditional
line, with these grounds instead" shows exactly what the rival changed. -/
def applicationLine : Line Claim :=
  { fulfilmentLine with
    name := "Matthew's quotation as an application"
    grounds := [p .matthewQuotesMicah, p .matthewApplies, notP .matthewReadsItAsFulfilled] }

/-- The rival position: the same step and the same conclusion, on different
grounds. -/
def application : ArgumentPackage Claim :=
  { traditional with
    name := "Matthew applies Micah as an older text for a new situation"
    premises := caseOf [applicationLine] [] [] }
-- ANCHOR_END: packages

-- ANCHOR: results
-- The two results. A `theorem` is a statement Lean has checked; the lines
-- after `by` are instructions telling Lean how to check it. A reader can
-- skip those instructions: if they were wrong, the file would not build.

/-- The conclusion follows from the traditional position. Grant its premises,
and Matthew presents Micah 5:2 as fulfilled. Lean checks the reasoning. It does
not check that the premises are true: that is for the reader to judge. -/
theorem traditional_establishes : Establishes traditional := by
  establish [traditional, fulfilmentLine, toFulfilment]

-- This line prints what the result rests on. Here it is only Lean's own
-- foundations (`propext` and `Quot.sound`): the project added no assumption of
-- its own. The premises are granted, not proved; that is the method.
#print axioms traditional_establishes

/-- The rival's reading, written out as a list of true and false. Every claim is
granted except two: that Matthew reads the quotation as a fulfilment, and the
conclusion. A list like this, on which every premise of a position holds and its
conclusion fails, is called a countermodel. It shows that the position's
premises leave room for the conclusion to be false. -/
def applicationReading : Valuation Claim := fun a =>
  match a with
  | .matthewReadsItAsFulfilled => False
  | .matthewPresentsFulfilment => False
  | _ => True

/-- The conclusion does not follow from the rival position. This is not a
failure to find a proof. Lean checks that the countermodel above makes every
premise of the rival true and the conclusion false, so no proof could exist. -/
theorem application_not_establishes : ¬ Establishes application := by
  refute_with applicationReading
    [application, traditional, applicationLine, fulfilmentLine, toFulfilment]

#print axioms application_not_establishes
-- ANCHOR_END: results

end HelloWorld
