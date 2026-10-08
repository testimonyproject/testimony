import Testimony.Meanings

/-!
# Testimony.Ontology.Search — where a word of the vocabulary is used

An article of `Testimony.Ontology` begins with a search: every claim, in every
argument, whose meaning uses the words it is about. A definition is worth
writing out only where it bears on a claim, and it bears differently on a claim
held as doctrine and on a claim about what a text says or a voice held. So the
search reports both, separately, and the articles pin what it finds, so that a
meaning added tomorrow that uses the word changes the article's numbers.

Every query here is generic: it is asked of any argument, by its `HasMeanings`
instance.
-/

namespace Testimony.Semantics

namespace Content

/-- The relations a content uses. -/
def rels : Content → List Rel
  | .rel r _ _ => [r]
  | .not c => c.rels
  | .both c d => c.rels ++ d.rels

end Content

namespace Statement

/-- The relations a meaning holds as doctrine: where the definitions apply. -/
def heldRels : Statement → List Rel
  | .holds c => c.rels
  | .denied s => s.heldRels
  | .also s t => s.heldRels ++ t.heldRels
  | _ => []

/-- The relations a meaning uses inside a frame — what a passage says or
teaches, what it opposes, what a voice held — where the definitions do not
apply. -/
def framedRels : Statement → List Rel
  | .says _ c | .teaches _ c | .opposes _ c | .heldBy _ c => c.rels
  | .denied s => s.framedRels
  | .also s t => s.framedRels ++ t.framedRels
  | _ => []

end Statement

namespace HasMeanings

variable {α : Type} [HasMeanings α]

/-- The atoms whose meaning holds, as doctrine, a claim in this relation. -/
def holding (r : Rel) : List α :=
  (all : List α).filter fun a => (means a).heldRels.contains r

/-- The atoms whose meaning uses this relation inside a frame: of a text, or of
a voice. -/
def framing (r : Rel) : List α :=
  (all : List α).filter fun a => (means a).framedRels.contains r

end HasMeanings

end Testimony.Semantics
