import Testimony.Semantics.Ontology
import Testimony.Bib.Works

/-!
# Testimony.Ontology.Time.Definitions — an occurrence lasts one length of time

Both top-level ontologies the vocabulary is aligned to say it: an occurrence —
DOLCE's perdurant, BFO's process — has one temporal extent. In DOLCE a
perdurant's temporal location is a single temporal region; in BFO a process
occupies one temporal region. So the time between two moments is five minutes
or twenty, and not both. That is not a reading of any testimony; it is what
"lasts" means.
-/

namespace Testimony.Ontology.Time

open Testimony Testimony.Bib Testimony.Semantics

/-- **An occurrence lasts one length of time.** `lasts` relates an occurrence to
a length of time, and the length is one: the time from a man's entering a store
to a shot cannot have lasted both five minutes and twenty. DOLCE and BFO each
give an occurrence a single temporal extent. -/
def oneLength : Definition :=
  { name := "one length of time"
  , says := "An occurrence lasts one length of time."
  , form := .functional .lasts
  , source :=
      { primary := .work borgoDolce .whole
      , supporting := [.work arpBasicFormalOntology .whole]
      , tradition := .formalOntology
      , confidence := .consensus } }

/-- The definitions this article writes out. -/
def definitions : Ontology := [oneLength]

end Testimony.Ontology.Time
