import Lean
import Mathlib.Tactic.Linter.Style

/-!
# Testimony.Attr — the library's attributes

`@[headline]` and `@[proposed]` mark results; an unfold set, one per argument,
marks the definitions its proofs unfold.

## `@[headline]`

Marks a load-bearing result: a theorem the library actually claims, as against
the lemmas supporting it. Tagging them makes "what does this library assert?" a
greppable question rather than a matter of reading everything, lets the docs
site list results rather than hand-curating them, and gives
`scripts/testimony_lint.py` rule L6 something to check — every headline result
must display its trust base with `#print axioms`.
-/

open Lean

namespace Testimony

/-- Marks a load-bearing result that the library claims, as distinct from a
supporting lemma. Every `@[headline]` theorem must be followed by
`#print axioms`. -/
initialize headlineAttr : TagAttribute ←
  registerTagAttribute `headline
    "a load-bearing result this library claims; must be followed by #print axioms"

/-- Marks a result the library **constructs** rather than reports: an argument
assembled here that no cited source advances in this form.

The library's value is that a reader can tell what is reported from what is
assembled, so a contribution is welcome but never silent. A proposed result is
marked wherever results are rendered, and rule L10 requires its docstring to
say what is novel about it and what would settle whether anyone has said it
before.

Soundness and provenance are different axes. A proposed result is checked by
exactly the same machinery as every other one; the tag says nothing about
whether it holds, only that the library is its source. -/
initialize proposedAttr : TagAttribute ←
  registerTagAttribute `proposed
    "a result this library constructs rather than reports; docstring must state what is novel"

/-! ## The unfold sets

One simp set per argument, holding every definition its proofs must unfold to
reach a premise list: the packages, the lines of reason, the inference steps,
the shared premise lists. A definition joins its argument's set where it is
written, as `@[fixtureDefs] def minutes ...`, and every proof then names the
set — `establish [fixtureDefs]` — rather than a list of the definitions it
happens to pass through.

**Why a set rather than a list.** A list written at the proof has to name every
definition on the way from the package to its premises, and a new definition
means editing every list that reaches it. One that is missing does not fail
where it is missing: `establish` reports the premises as "not Horn", because the
definition it could not see through is still standing where a formula should
be. Tagging the definition once, where it is written, removes that class of
failure rather than the symptoms of it.

**Where they are declared.** Lean will not let a module use a simp set it
declares itself, so each set lives in a module its argument imports. The
library's own is here, for the fixture its checks run over
(`Testimony.Checks.Fixture`); a package built on the library declares its
arguments' sets in a module of its own, as the arguments package does in
`TestimonyArguments.Attr`.

**What a set does not do.** It names what to unfold and nothing more; it proves
nothing. Every tactic still unfolds the semantics through the qualified names
written inside `Testimony.Logic.Tactic`, so a set cannot reintroduce the
unqualified `Formula.Boolean.val` that once let a proof fall back to `sorryAx`
with a successful build. -/

/-- The definitions the proofs over the checks' fixture unfold. -/
register_simp_attr fixtureDefs

-- `register_simp_attr` also declares a simproc set, named with a `_proc` suffix
-- the naming linter cannot see is generated.
attribute [nolint defsWithUnderscore] Parser.Attr.fixtureDefs_proc

end Testimony
