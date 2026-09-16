/-!
# Testimony.Provenance — sources, traditions, confidence

Every premise, annotation, and intertextual edge carries provenance. This is
the mechanism that keeps the library honest: nothing is asserted bare.
-/

namespace Testimony

/-- Interpretive tradition attributing a claim. -/
inductive Tradition
  | christianTypological
  | christianHistoricalGrammatical
  | secondTempleJewish
  | rabbinicJewish
  | criticalScholarship
deriving Repr, DecidableEq

/-- Confidence a source attaches to a claim. Deliberately coarse. -/
inductive Confidence
  | disputed | plausible | wellSupported | consensus
deriving Repr, DecidableEq

/-- A citation: who says so, where. -/
structure Source where
  citation : String        -- e.g. "Keil & Delitzsch, Commentary on Micah, ad loc."
  tradition : Tradition
  confidence : Confidence
deriving Repr, DecidableEq

/-- Classification of an unproven premise — the vocabulary of the assumption
manifest. -/
inductive PremiseKind
  | textual | linguistic | historical | theological | interpretive
deriving Repr, DecidableEq

/-- A premise: a named assumption with kind and provenance. The `holds`
proposition is what theorems hypothesise. -/
structure Premise where
  name : String
  kind : PremiseKind
  source : Source
deriving Repr

end Testimony
