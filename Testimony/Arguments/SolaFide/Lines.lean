import Testimony.Arguments.SolaFide.Atoms
import Testimony.Logic.Line

/-!
# Arguments.SolaFide.Lines — the strands, and what they share

Two strands deliver justification by faith alone, by different words in
different authors. A third line answers James. What every package holds in
common is collected here too, so that a variant package is a named difference
rather than a retyped list.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Lines of reason

Two strands deliver the conclusion, and a third line answers James. The James
harmonisation is deliberately *not* a strand: it does not reach
`justificationByFaithAlone` by an independent route, it supplies a premise the
closing step needs. So it contributes its grounds and its step to the case
without being one of the lines `caseOf` treats as converging. -/

/-- **The Pauline strand.** From Romans and Galatians to justification by faith
alone, by way of the disputed lexical premise about ἔργα νόμου. -/
def paulineToFaithAlone : Formula Claim :=
  .imp (conjOf [p .romans3_28, p .galatians2_16, p .worksOfLawMeansWorksGenerally])
       (p .justificationByFaithAlone)

/-- **The dominical strand.** From Jesus' own words at Luke 7:50 to
justification by faith alone, by way of the disputed lexical premise about
σῴζω. Independent of Paul, and of the ἔργα νόμου dispute. -/
def dominicalToFaithAlone : Formula Claim :=
  .imp (conjOf [p .luke7_50FaithHasSavedYou, p .sozoIsSoteriological])
       (p .justificationByFaithAlone)

/-- The harmonisation of James: because James's target is barren faith, and
works are the fruit of saving faith rather than its ground, James 2:24 does not
contradict Paul. Derived rather than assumed. -/
def jamesHarmonisation : Formula Claim :=
  .imp (conjOf [p .james2TargetsDeadFaith, p .worksAreFruitNotGround])
       (p .james2_24Compatible)

/-- The inference from justification by faith alone to the full claim about
salvation, requiring the remaining prooftexts and the harmonisation of James. -/
def toSalvation : Formula Claim :=
  .imp (conjOf
        [ p .justificationByFaithAlone, p .ephesians2_8_9, p .romans4_4_5
        , p .titus3_5, p .james2_24Compatible, p .scriptureSelfConsistent ])
       (p .salvationByGraceThroughFaithNotWorks)

/-- The Pauline line. Its only distinctive ground is the lexical premise; the
prooftexts its step reads are shared with every other package, which is exactly
why denying the premise does not cost the argument its prooftexts. -/
def paulineLine : Line Claim :=
  { name := "Pauline strand (ἔργα νόμου)"
  , grounds := [p .worksOfLawMeansWorksGenerally]
  , step := paulineToFaithAlone
  , delivers := p .justificationByFaithAlone }

/-- The dominical line, resting on Jesus' words rather than Paul's. Its
distinctive ground is the other lexical premise. -/
def dominicalLine : Line Claim :=
  { name := "Dominical strand (σῴζω at Luke 7:50)"
  , grounds := [p .sozoIsSoteriological]
  , step := dominicalToFaithAlone
  , delivers := p .justificationByFaithAlone }

/-- The James line: not a route to the conclusion but the answer to the one
text that stands against it. -/
def jamesLine : Line Claim :=
  { name := "Harmonisation of James 2:24"
  , grounds := [p .james2TargetsDeadFaith, p .worksAreFruitNotGround]
  , step := jamesHarmonisation
  , delivers := p .james2_24Compatible }

/-- The prooftexts both strands read, and the hermeneutical premise the closing
step needs. Shared by every Reformed package, and by the New Perspective. -/
def prooftexts : List (Formula Claim) :=
  [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .romans4_4_5
  , p .titus3_5, p .luke7_50FaithHasSavedYou ]

/-- Everything the two strands share: the prooftexts, the grounds of the James
harmonisation, and scripture's self-consistency. -/
def sharedGrounds : List (Formula Claim) :=
  prooftexts ++ jamesLine.grounds ++ [p .scriptureSelfConsistent]

/-- The same, with James unanswered. -/
def sharedGroundsWithoutJames : List (Formula Claim) :=
  prooftexts ++ [p .scriptureSelfConsistent]

/-- The steps that close the argument once a strand has delivered
justification by faith alone: the James harmonisation, then the inference to
salvation. -/
def closingSteps : List (Formula Claim) := [jamesLine.step, toSalvation]

end Testimony.Arguments.SolaFide
