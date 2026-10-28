import Testimony.Semantics.Meaning

/-!
# Testimony.Ontology.Search — where a word of the vocabulary is used, and what a definition derives

An article of `Testimony.Ontology` begins with a search: every claim, in every
argument, whose meaning uses the words it is about. A definition is worth
writing out only where it bears on a claim, and it bears differently on a claim
held as doctrine and on a claim about what a text says or a voice held. So the
search reports both, separately. It ends with what follows: the joins a
definition contributes, which are the joins found with it and not without it.

Every query here is generic: it is asked of any argument, by its `HasMeanings`
instance, and names none. `Testimony.Checks.Ontology` asks them of every
argument the library has, and pins the answers.
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

/-- The atoms whose meaning holds, as doctrine, a claim in one of these
relations. -/
def holding (rs : List Rel) : List α :=
  (all : List α).filter fun a => rs.any (means a).heldRels.contains

/-- The atoms whose meaning uses one of these relations inside a frame: of a
text, or of a voice. -/
def framing (rs : List Rel) : List α :=
  (all : List α).filter fun a => rs.any (means a).framedRels.contains

/-- The atoms whose meaning states what a word means in one passage of a
voice's text: where a definition about a usage bears. -/
def statingPassageSenses : List α :=
  (all : List α).filter fun a => (means a).senses.any fun (_, sc, _) => sc.isPassageOf

/-- **Where a definition bears**: the atoms that hold its relation words as
doctrine, and those that use them of a text or a voice; for the definition
about a usage, the atoms that state a word's sense at a passage of a voice's
text, and none in a frame. -/
def bearing : Axiom → List α × List α
  | .inUsage => (statingPassageSenses, [])
  | ax => (holding ax.rels, framing ax.rels)

/-- **What one definition of an ontology contributes**: the exclusions, and the
entailments, found under the ontology and not under it with that definition
taken out. -/
def contributed [DecidableEq α] (O : Ontology) (i : Nat) : List (α × α) × List (α × α) :=
  let without := O.eraseIdx i
  ((exclusionsUnder O).filter fun e => !(exclusionsUnder without).contains e,
   (entailmentsUnder O).filter fun e => !(entailmentsUnder without).contains e)

end HasMeanings

end Testimony.Semantics
