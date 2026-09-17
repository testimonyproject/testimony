import Testimony.Bib.Core

/-!
# Testimony.Provenance — references, traditions, confidence

Every premise, annotation, and intertextual edge carries provenance. This is the
mechanism that keeps the library honest: nothing is asserted bare.

`Source.primary` is a single required `Reference` rather than a possibly-empty
list. The rule in CONTRIBUTING.md that uncited premises do not merge is
therefore enforced by the elaborator: an uncited `Source` cannot be written
down. There is deliberately no free-text escape hatch, because an escape hatch
would be used.
-/

namespace Testimony

open Testimony.Bib

/-- Interpretive tradition attributing a claim. -/
inductive Tradition
  /-- Christian reading that finds Christ prefigured in the pattern of earlier
  texts. -/
  | christianTypological
  /-- Christian reading that seeks the author's intent in its historical
  setting. -/
  | christianHistoricalGrammatical
  /-- Jewish interpretation of the Second Temple period. -/
  | secondTempleJewish
  /-- Rabbinic Jewish interpretation. -/
  | rabbinicJewish
  /-- Historical-critical biblical scholarship. -/
  | criticalScholarship
  /-- Reformed Protestant confessional theology. -/
  | reformedProtestant
  /-- Roman Catholic magisterial teaching. -/
  | romanCatholic
  /-- Eastern Orthodox theology. -/
  | easternOrthodox
deriving Repr, DecidableEq

/-- Confidence a source attaches to a claim. Deliberately coarse. -/
inductive Confidence
  /-- Actively contested by competent scholars. -/
  | disputed
  /-- Defensible, but not established. -/
  | plausible
  /-- Well supported, though not universally held. -/
  | wellSupported
  /-- Accepted across traditions, including by those with no stake in it. -/
  | consensus
deriving Repr, DecidableEq

/-- A citation of scripture. Typed against `PassageRange` rather than stored as
prose, so that citations are traversable — "what cites Isaiah 7:14?" is an
answerable question — and so that `Source.isScriptureOnly` is computable. -/
structure ScriptureCitation where
  /-- The verse or range cited. -/
  ref : PassageRange
  /-- Which text-form is being cited, where it matters (the LXX's `parthenos`
  against the Masoretic `almah`, for instance). -/
  tradition : Option TextualTradition := none
deriving Repr, DecidableEq

/-- What a claim is grounded in.

Scripture is a distinct constructor rather than an `ancientWork` entry because
a premise grounded *only* in scripture is epistemically different from one
grounded in scholarship. For a project that argues from scripture, being able to
surface that distinction mechanically is a defence against circularity. -/
inductive Reference
  /-- A catalogued work, at a pinpoint within it. -/
  | work (entry : BibEntry) (locus : Locus := .whole)
  /-- Scripture itself. -/
  | scripture (refs : List ScriptureCitation)
  /-- A claim this library advances without a source in the literature that
  holds it. `rationale` states what is being proposed and why, because a
  proposed premise still has to say something where a citation would go — the
  field is required for the same reason `primary` is.

  This is not a licence to assert. A proposed reference marks the claim as the
  library's own construction wherever it is rendered, so a reader can always
  tell what is reported from what is assembled here. -/
  | proposal (rationale : String)
deriving Repr, DecidableEq

/-- Whether this reference is scripture rather than scholarship. -/
def Reference.isScripture : Reference → Bool
  | .scripture _ => true
  | .work _ _ => false
  | .proposal _ => false

/-- The bibliography entry a reference cites, if it cites one. -/
def Reference.entry : Reference → Option BibEntry
  | .work e _ => some e
  | .scripture _ => none
  | .proposal _ => none

/-- Who says so, where, and with what confidence.

`primary` is required; `supporting` is for the additional references a premise
may rest on (a text plus the commentary that reads it that way). -/
structure Source where
  /-- The reference this claim principally rests on. Required, which is what
  makes an uncited source unrepresentable. -/
  primary : Reference
  /-- Further references the claim draws on. -/
  supporting : List Reference := []
  /-- Which interpretive tradition advances this claim. -/
  tradition : Tradition
  /-- How firmly the tradition holds it. -/
  confidence : Confidence
deriving Repr, DecidableEq

/-- Every reference this source cites. -/
def Source.references (s : Source) : List Reference := s.primary :: s.supporting

/-- Whether this source appeals to scripture alone, with no scholarly support.

This is the circularity detector. A premise that reads scripture in a particular
way, and cites only scripture for that reading, is assuming what an argument
from scripture needs to establish. Such premises are not forbidden — sometimes
the text really is plain — but they are surfaced in the assumption manifest so
that a reader can weigh them. -/
def Source.isScriptureOnly (s : Source) : Bool :=
  s.references.all Reference.isScripture

/-- Every bibliography entry cited by this source. -/
def Source.entries (s : Source) : List BibEntry :=
  s.references.filterMap Reference.entry

/-- Classification of an unproven premise — the vocabulary of the assumption
manifest. -/
inductive PremiseKind
  /-- What a text says — wording, variants, attestation. -/
  | textual
  /-- What the words mean — lexis, morphology, syntax. -/
  | linguistic
  /-- What happened — events, persons, dates. -/
  | historical
  /-- What doctrine holds. -/
  | theological
  /-- How a passage is to be read. -/
  | interpretive
deriving Repr, DecidableEq

/-- A premise: a named assumption with kind and provenance.

Note that this structure carries *metadata only*. The propositional content of a
premise lives in the logic layer (`Testimony.Logic`), where it can be reasoned
with; this record is what the assumption manifest prints. -/
structure Premise where
  /-- A prose statement of what is assumed. -/
  name : String
  /-- The kind of assumption it is. -/
  kind : PremiseKind
  /-- Who says so, where. -/
  source : Source
deriving Repr, DecidableEq

end Testimony
