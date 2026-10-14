import Testimony.Ontology.Time.Definitions

/-!
# Testimony.Ontology.Time.Examples — the definition, at work

Two statements of the article's own, about one occurrence: they exclude each
other with the definition, and not without it.
-/

namespace Testimony.Ontology.Time

open Testimony Testimony.Semantics Testimony.Semantics.Notation

/-- An occurrence: the time between two moments a witness reports. -/
abbrev theInterval : Term := pt "the time between two moments" .process

/-- It lasted five minutes. -/
abbrev fiveMinutes : Statement := .holds (rl .lasts theInterval (cn (.minutes 5)))

/-- It lasted twenty minutes. -/
abbrev twentyMinutes : Statement := .holds (rl .lasts theInterval (cn (.minutes 20)))

/-- **"One length of time", at work.** That the interval lasted five minutes,
and that it lasted twenty, cannot both be held — given what "lasts" means, and
not otherwise. Two different intervals may last five minutes and twenty: the
definition joins claims about one occurrence only. -/
theorem one_length_at_work :
    Ontology.excludeEachOther [oneLength] fiveMinutes twentyMinutes = true ∧
      Ontology.excludeEachOther [] fiveMinutes twentyMinutes = false ∧
      Ontology.excludeEachOther [oneLength] fiveMinutes
        (.holds (rl .lasts (pt "another occurrence" .process) (cn (.minutes 20)))) = false := by
  decide

end Testimony.Ontology.Time
