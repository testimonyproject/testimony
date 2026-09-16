import Lean

/-!
# Testimony.Attr — the `@[headline]` attribute

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

end Testimony
