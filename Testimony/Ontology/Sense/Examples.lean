import Testimony.Ontology.Sense.Definitions

/-!
# Testimony.Ontology.Sense.Examples — the definition, at work

Statements of the article's own, about δικαιόω ("justify") in James 2:24 and in
Paul. That James uses the word as Paul does excludes the claim that Paul does not
use it as James does: with the definition, and not without it. What it does not
do is shown too: that the word keeps its sense from James to Paul says nothing
of any third place, and nothing of what the sense is.
-/

namespace Testimony.Ontology.Sense

open Testimony Testimony.Semantics Testimony.Semantics.Notation

/-- James 2:24. -/
abbrev jamesTwo : Scope := .passage (vs .james 2 24)

/-- James's "justify" at 2:24 has the sense Paul's has. -/
abbrev jamesAsPaul : Statement := .sameSense .dikaioo jamesTwo (.usage .paul)

/-- Paul's "justify" does not have the sense James's has at 2:24. -/
abbrev paulNotAsJames : Statement := .denied (.sameSense .dikaioo (.usage .paul) jamesTwo)

/-- Paul's "justify" does not have the sense Luke's has. -/
abbrev paulNotAsLuke : Statement := .denied (.sameSense .dikaioo (.usage .paul) (.usage .luke))

/-- In Paul, "justify" means a verdict. -/
abbrev paulsVerdict : Statement := .means .dikaioo (.usage .paul) .verdict

/-- At James 2:24, "justify" does not mean a verdict. -/
abbrev jamesNoVerdict : Statement := .denied (.means .dikaioo jamesTwo .verdict)

/-- **"The same sense, both ways", at work.** That James uses δικαιόω as Paul
does, and that Paul does not use it as James does, cannot both be held: given
what "the same" means, and not otherwise.

What it does not join is as much a part of it. A claim about James and Paul says
nothing of Paul and Luke. And the definition does not carry a sense from one
place to the other: that the word means a verdict in Paul, and not at James
2:24, with the same sense in both, is not excluded by this definition, which
says only that sameness runs both ways. Carrying a sense across is what an
argument does when it assumes the same sense, and the fallacy checks
(`Testimony.Semantics.Fallacy`) look for exactly that assumption. -/
theorem both_ways_at_work :
    Ontology.excludeEachOther [bothWays] jamesAsPaul paulNotAsJames = true ∧
      Ontology.excludeEachOther [] jamesAsPaul paulNotAsJames = false ∧
      Ontology.excludeEachOther [bothWays] jamesAsPaul paulNotAsLuke = false ∧
      Ontology.excludeEachOther [bothWays] (.also jamesAsPaul paulsVerdict) jamesNoVerdict =
        false := by
  decide

end Testimony.Ontology.Sense
