import Testimony.Logic.Package

/-!
# Testimony.Logic.Line — arguments as lines of reason

An argument is not a heap of premises. It is a small number of *lines of
reason*, each resting on its own grounds, each licensed by its own inference
step, converging on a shared conclusion. `BornOfAVirgin` runs on four; `SolaFide`
on three. Before this module the structure was real but implicit: it lived in the
module docstring and in the order of a twenty-one element premise list, and
every variant package restated the whole list to change one entry.

A `Line` makes the structure a value. That buys three things.

**Variants become differences.** "The scriptural reading minus the lexical
premise" is one line with one ground dropped, written as such, instead of
twenty premises retyped with one missing — where a reader cannot see which one
went and a typo in the other nineteen is invisible.

**A line can be checked alone.** `Line.asPackage` turns one into an
`ArgumentPackage`, so `Establishes` applies to a single strand. A load-bearing
result about one line no longer has to be inferred from results about the whole
argument.

**Lines are shareable.** A line of reason is not argument-specific in
principle; nothing stops one module citing another's, which is what the
scripture bundles in `Testimony.Scripture` do for citations.

`delivers` is not used by the entailment checker — `caseOf` throws the lines'
conclusions away and keeps their steps. It is what `asPackage` concludes, and
recording it is what lets a line be checked on its own terms rather than only
as part of a case.
-/

namespace Testimony.Logic

variable {α : Type}

/-- One line of reason: what it rests on, the step that licenses it, and what
it delivers.

`grounds` are premises the line assumes; `step` is the single formula carrying
them to `delivers`. Keeping the step separate from the grounds is what lets
`caseOf` put every ground before every inference. -/
structure Line (α : Type) where
  /-- The line's name, as the module's prose refers to it. -/
  name : String
  /-- The premises this line rests on. -/
  grounds : List (Formula α)
  /-- The inference step carrying those grounds to what the line delivers. -/
  step : Formula α
  /-- What the line delivers, if its grounds are granted. -/
  delivers : Formula α
  /-- A citation rating the step itself: `disputed` when a cited source grants
  the grounds and denies what the line delivers. A line that enters a dispute
  must carry one. -/
  inference : Option Source := none

namespace Line

/-- The line's premises: its grounds together with its licensing step. -/
def premises (l : Line α) : List (Formula α) := l.grounds ++ [l.step]

/-- The line on its own, as an argument package.

What a single strand is worth in isolation is a question the library asks
constantly — `almah_is_load_bearing_alone` and `criticalDenial_establishes`
both ask it — and this is how it gets asked without restating the strand as a
package by hand. -/
def asPackage (l : Line α) (cite : α → AtomMeta) (conclusionLabel : String) :
    ArgumentPackage α :=
  { name := l.name
  , cite := cite
  , premises := l.premises
  , conclusion := l.delivers
  , conclusionLabel := conclusionLabel
  , inferences := l.inference.toList }

/-- The same line with different grounds, keeping its name, step and
conclusion.

This is the shape of nearly every variant package in the library: drop a
hinge, weaken a premise to its defensive form, deny it outright. Naming the
operation keeps the change visible instead of hiding it in a retyped list. -/
def onGrounds (l : Line α) (grounds : List (Formula α)) : Line α :=
  { l with grounds := grounds }

end Line

/-- A case built from lines of reason: every line's grounds, then the premises
the lines share, then every line's licensing step, then the steps that close
the argument.

Grounds before steps, deliberately. The material the case rests on comes first
and the inferences that move it come last, which is the order a reader checks
an argument in and the order the rendered LaTeX sets it. -/
def caseOf (lines : List (Line α)) (shared closing : List (Formula α)) :
    List (Formula α) :=
  lines.flatMap Line.grounds ++ shared ++ lines.map Line.step ++ closing

end Testimony.Logic
