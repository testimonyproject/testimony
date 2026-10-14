import Testimony.Ontology.Relations.Definitions
import Testimony.Ontology.Time.Definitions

/-!
# Testimony.Ontology.Shared — the definitions every check holds

Every definition the articles of `Testimony.Ontology` write out, in one list.
`Testimony.Semantics.Meaning` reads every argument's joins under it, so a
definition added to an article changes what the logic holds for every argument
at once, and each argument's pinned joins fail until the change is listed.

Only definitions belong here: what a word of the vocabulary means, which no
reader disputes. What one tradition holds of a word, and another denies, is a
premise of that tradition's position, not a definition, and an article that
finds one says so and leaves it out.
-/

namespace Testimony.Ontology

/-- **The shared ontology**: every article's definitions. -/
def shared : Semantics.Ontology := Relations.definitions ++ Time.definitions

end Testimony.Ontology
