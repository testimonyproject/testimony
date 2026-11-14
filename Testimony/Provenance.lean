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
  /-- Arminian Protestant theology: Arminius, the Remonstrants of 1610, and
  their heirs, Wesleyan Methodism among them. -/
  | arminian
  /-- Eastern Orthodox theology. -/
  | easternOrthodox
  /-- The adversarial trial: testimony given, and the cross-examination that
  tests it. For cases outside theology, where the parties are a witness and
  counsel rather than a tradition of reading. -/
  | adversarialTrial
  /-- Formal ontology: what a word means, as the top-level ontologies (DOLCE,
  BFO) state it, or as the library stipulates its own words. -/
  | formalOntology
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

/-- **The same reference, compared shallowly**: two works are the same reference
when they have the same key and the same locus, and any other two when they are
equal. A key stands for its entry because no two entries share one
(`Testimony.Checks.Citations`; `Reference.sameAs_iff`), and comparing keys spares
the kernel a comparison of two whole entries, one character of each at a time. -/
def Reference.sameAs : Reference → Reference → Bool
  | .work e l, .work e' l' => e.key == e'.key && l == l'
  | r, r' => r == r'

/-- Two lists of references, compared shallowly, in order. -/
def Reference.sameAll : List Reference → List Reference → Bool
  | [], [] => true
  | r :: rs, r' :: rs' => r.sameAs r' && sameAll rs rs'
  | _, _ => false

/-- Every entry the reference cites is one of `L`. -/
def Reference.CitesFrom (L : List BibEntry) (r : Reference) : Prop :=
  ∀ e, r.entry = some e → e ∈ L

/-- **Shallow comparison is equality** for references whose entries are drawn
from a list with distinct keys. -/
theorem Reference.sameAs_iff {L : List BibEntry} (hL : (L.map BibEntry.key).Nodup)
    {r r' : Reference} (hr : r.CitesFrom L) (hr' : r'.CitesFrom L) :
    r.sameAs r' = true ↔ r = r' := by
  cases r <;> cases r' <;> simp only [sameAs, beq_iff_eq, Bool.and_eq_true, reduceCtorEq,
    Reference.work.injEq, Reference.scripture.injEq, Reference.proposal.injEq, iff_self]
  case work.work e l e' l' =>
    constructor
    · rintro ⟨hk, rfl⟩
      exact ⟨BibEntry.eq_of_key_eq hL (hr e rfl) (hr' e' rfl) hk, rfl⟩
    · rintro ⟨rfl, rfl⟩
      exact ⟨rfl, rfl⟩

/-- Every entry a source cites is one of `L`. -/
def Source.CitesFrom (L : List BibEntry) (s : Source) : Prop :=
  ∀ r ∈ s.references, r.CitesFrom L

/-- **The same citation, whatever its confidence**: the same references, compared
shallowly, and the same tradition. A step's citation is matched this way when
it is re-rated (`Testimony.Logic.RatedStep.rerate`), where it is cited at some
confidence and rated at another. -/
def Source.sameCitation (a b : Source) : Bool :=
  a.primary.sameAs b.primary && Reference.sameAll a.supporting b.supporting &&
    a.tradition == b.tradition

theorem Reference.sameAll_iff {L : List BibEntry} (hL : (L.map BibEntry.key).Nodup) :
    ∀ {rs rs' : List Reference}, (∀ r ∈ rs, r.CitesFrom L) → (∀ r ∈ rs', r.CitesFrom L) →
      (sameAll rs rs' = true ↔ rs = rs')
  | [], [], _, _ => by simp [sameAll]
  | [], _ :: _, _, _ => by simp [sameAll]
  | _ :: _, [], _, _ => by simp [sameAll]
  | r :: rs, r' :: rs', h, h' => by
    simp only [sameAll, Bool.and_eq_true, List.cons.injEq]
    rw [sameAs_iff hL (h r (by simp)) (h' r' (by simp)),
      sameAll_iff hL (fun x hx => h x (by simp [hx])) (fun x hx => h' x (by simp [hx]))]

/-- **Shallow comparison is equality, but for the confidence**, for sources whose
entries are drawn from a list with distinct keys: two sources are the same
citation exactly when one is the other cited at its confidence. -/
theorem Source.sameCitation_iff {L : List BibEntry} (hL : (L.map BibEntry.key).Nodup)
    {a b : Source} (ha : a.CitesFrom L) (hb : b.CitesFrom L) :
    a.sameCitation b = true ↔ a = { b with confidence := a.confidence } := by
  obtain ⟨p, sup, t, c⟩ := a
  obtain ⟨p', sup', t', c'⟩ := b
  simp only [sameCitation, Bool.and_eq_true, beq_iff_eq, Source.mk.injEq, and_true]
  rw [Reference.sameAs_iff hL (ha p (by simp [references])) (hb p' (by simp [references])),
    Reference.sameAll_iff hL (fun r hr => ha r (by simp [references, hr]))
      (fun r hr => hb r (by simp [references, hr]))]
  exact and_assoc

/-- Whether this source appeals to scripture alone, with no scholarly support.

This is the circularity detector. A premise that reads scripture in a particular
way, and cites only scripture for that reading, is assuming what an argument
from scripture needs to establish. Such premises are not forbidden — sometimes
the text really is plain — but they are surfaced in the assumption manifest so
that a reader can weigh them. -/
def Source.isScriptureOnly (s : Source) : Bool :=
  s.references.all Reference.isScripture

/-- Whether this source cites scripture at all. A document none of whose claims
does — a case from outside theology — has nothing to say about premises grounded
in scripture alone, and the renderers say nothing. -/
def Source.citesScripture (s : Source) : Bool :=
  s.references.any Reference.isScripture

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
  /-- What is generally so, as observation or common experience establishes it:
  how long a thing takes, how a thing behaves. For cases outside theology,
  where a reckoning turns on how the world goes. -/
  | empirical
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
