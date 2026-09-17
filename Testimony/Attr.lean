import Lean

/-!
# Testimony.Attr — the `@[headline]` and `@[proposed]` attributes

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

end Testimony
