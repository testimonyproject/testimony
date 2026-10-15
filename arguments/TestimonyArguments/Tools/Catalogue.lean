import Testimony.Tools.Docs

/-!
# TestimonyArguments.Tools.Catalogue — which arguments, and what to call them

An argument's title is prose about what it argues from — "Born of a virgin —
Isaiah 7:14, Genesis 3:15, Micah 5:2–3" is not recoverable from the names of its
theorems. The catalogue lives here once, so that adding an argument is one edit,
and every generator reads it.
-/

namespace TestimonyArguments.Doc

open Lean Testimony.Doc

/-- Every argument the documentation presents, in the order it presents them.

Every namespace carrying a `@[headline]` result must appear here. The page
harvest and the status table both `#guard` it, so adding an argument cannot
silently omit it from the roadmap's table or from the argument pages. -/
def arguments : List Argument :=
  [ { ns := `TestimonyArguments.BornInBethlehem
    , slug := "born-in-bethlehem"
    , title := "Born in Bethlehem — Micah 5:2" }
  , { ns := `TestimonyArguments.BornOfAVirgin
    , slug := "born-of-a-virgin"
    , title := "Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3" }
  , { ns := `TestimonyArguments.SolaFide
    , slug := "sola-fide"
    , title := "Sola fide" }
  , { ns := `TestimonyArguments.CanonicalWitness
    , slug := "canonical-witness"
    , title := "The canonical witness — faith alone, from the texts all parties accept" }
  , { ns := `TestimonyArguments.SolaScriptura
    , slug := "sola-scriptura"
    , title := "Sola scriptura" }
  , { ns := `TestimonyArguments.SpiritBaptism
    , slug := "spirit-baptism"
    , title := "Spirit baptism — at conversion, after it, or in the sacraments" } ]

end TestimonyArguments.Doc
