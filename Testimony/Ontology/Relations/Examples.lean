import Testimony.Ontology.Relations.Definitions

/-!
# Testimony.Ontology.Relations.Examples — each definition, at work

Each definition is shown on two statements of its own, built from the
vocabulary and from no argument: the pair excludes each other with the
definition, and does not without it. So what a definition does is checked here,
once, for any argument that uses its words. Where it bears in the library's
arguments, and what it derives there, is computed for every argument by
`Testimony.Checks.Ontology`.
-/

namespace Testimony.Ontology.Relations

open Testimony Testimony.Semantics Testimony.Semantics.Notation

/-- Works are excluded from justification: not its ground. -/
abbrev worksExcluded : Statement := .holds (rl .excludedFrom (cn .works) (cn .justification))

/-- Works are a ground of justification. -/
abbrev worksAGround : Statement := .holds (rl .groundOf (cn .works) (cn .justification))

/-- Faith is the only means by which justification is received. -/
abbrev faithTheOnlyMeans : Statement :=
  .holds (rl .soleInstrumentOf (cn .faith) (cn .justification))

/-- Baptism is a means by which justification is received. -/
abbrev baptismAMeans : Statement := .holds (rl .instrumentOf (cn .baptism) (cn .justification))

/-- Christ's death is the whole ground of justification. -/
abbrev christsDeathTheWholeGround : Statement :=
  .holds (rl .soleGroundOf (cn .christsDeath) (cn .justification))

/-- **"Not a ground", at work.** That works are excluded from justification, and
that they are its ground, cannot both be held — given what "excluded from"
means, and not otherwise. -/
theorem not_a_ground_at_work :
    Ontology.excludeEachOther [notAGround] worksExcluded worksAGround = true ∧
      Ontology.excludeEachOther [] worksExcluded worksAGround = false := by
  decide

/-- **"The only means", at work.** That faith is the only means of
justification, and that baptism is a means of it, cannot both be held — given
what "only" means, and not otherwise. -/
theorem the_only_means_at_work :
    Ontology.excludeEachOther [onlyMeans] faithTheOnlyMeans baptismAMeans = true ∧
      Ontology.excludeEachOther [] faithTheOnlyMeans baptismAMeans = false := by
  decide

/-- **"The whole ground", at work.** That Christ's death is the whole ground of
justification, and that works are a ground of it, cannot both be held — given
what "whole" means, and not otherwise. -/
theorem the_whole_ground_at_work :
    Ontology.excludeEachOther [wholeGround] christsDeathTheWholeGround worksAGround = true ∧
      Ontology.excludeEachOther [] christsDeathTheWholeGround worksAGround = false := by
  decide

/-- **A denial inside a claim needs no definition.** "Justification includes the
remission of sins, and not sanctification" excludes "justification includes
both" with no definition at all: the denial is in the first claim's own
words. -/
theorem a_denial_inside_needs_no_definition :
    Ontology.excludeEachOther []
      (.holds (.both (rl .includes (cn .justification) (cn .forgiveness))
        (.not (rl .includes (cn .justification) (cn .sanctification)))))
      (.holds (.both (rl .includes (cn .justification) (cn .forgiveness))
        (rl .includes (cn .justification) (cn .sanctification)))) = true := by
  decide

/-- **The definitions do not reach inside a frame.** A passage that says faith
is the only means, and the same passage saying baptism is a means, are two
claims about what it says, and they do not exclude each other under any of the
definitions: a text may say a thing without saying all that follows from it. -/
theorem the_definitions_stop_at_a_frame :
    Ontology.excludeEachOther definitions
      (.says (vs .romans 3 28) (rl .soleInstrumentOf (cn .faith) (cn .justification)))
      (.says (vs .romans 3 28) (rl .instrumentOf (cn .baptism) (cn .justification))) =
      false := by
  decide

end Testimony.Ontology.Relations
