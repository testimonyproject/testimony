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

/-- Sola fide, set as a book: one chapter for each question a reader brings to
it, in the order a reader would ask them. The claims and their sources, which
every chapter's formulas point to, are an appendix. -/
def solaFideChapters : List Chapter :=
  [ { slug := "sola-fide", title := "What sola fide claims"
    , modules := [`TestimonyArguments.SolaFide] }
  , { slug := "four-witnesses", title := "Four witnesses: Paul, Luke, Acts and John"
    , modules := [ `TestimonyArguments.SolaFide.Lines, `TestimonyArguments.SolaFide.Packages
                 , `TestimonyArguments.SolaFide.Results ] }
  , { slug := "john", title := "John: \"this is the work of God, that you believe\""
    , modules := [`TestimonyArguments.SolaFide.Johannine] }
  , { slug := "trent-and-paul", title := "Where Trent parts from Paul"
    , modules := [`TestimonyArguments.SolaFide.Gospel] }
  , { slug := "trents-definition", title := "What Trent means by justification"
    , modules := [`TestimonyArguments.SolaFide.Definition] }
  , { slug := "degrees", title := "Does justification have degrees?"
    , modules := [`TestimonyArguments.SolaFide.Verdict] }
  , { slug := "james", title := "James 2:24: \"not by faith alone\""
    , modules := [`TestimonyArguments.SolaFide.James] }
  , { slug := "abraham", title := "Abraham, counted righteous"
    , modules := [`TestimonyArguments.SolaFide.Abraham] }
  , { slug := "latin-texts", title := "Trent's two Latin texts"
    , modules := [`TestimonyArguments.SolaFide.Vulgate] }
  , { slug := "jesus-words", title := "What Jesus' own words say about faith and works"
    , modules := [`TestimonyArguments.SolaFide.JesusWords] }
  , { slug := "baptism", title := "Is baptism how we are justified?"
    , modules := [`TestimonyArguments.SolaFide.Baptism] }
  , { slug := "weighing", title := "Weighing the positions"
    , modules := [`TestimonyArguments.SolaFide.Dispute, `TestimonyArguments.SolaFide.Hearings] }
  , { slug := "ratings", title := "Why each step is rated as it is"
    , modules := [`TestimonyArguments.SolaFide.Ratings] }
  , { slug := "claims", title := "Appendix: the claims and their sources"
    , modules := [`TestimonyArguments.SolaFide.Atoms, `TestimonyArguments.SolaFide.Sources]
    , legend := true } ]

/-- The canonical witness, set as chapters: the question and its method; what
each corpus says; what follows, what an opponent must reject, and James; and the
claims, as an appendix. -/
def canonicalWitnessChapters : List Chapter :=
  [ { slug := "canonical-witness", title := "Faith alone from the texts every party accepts"
    , modules := [`TestimonyArguments.CanonicalWitness] }
  , { slug := "the-readings", title := "What each corpus says"
    , modules := [`TestimonyArguments.CanonicalWitness.Lines] }
  , { slug := "the-burden", title := "What follows, and what an opponent must reject"
    , modules := [ `TestimonyArguments.CanonicalWitness.Results
                 , `TestimonyArguments.CanonicalWitness.Packages ] }
  , { slug := "claims", title := "Appendix: the claims and their sources"
    , modules := [ `TestimonyArguments.CanonicalWitness.Atoms
                 , `TestimonyArguments.CanonicalWitness.Sources ]
    , legend := true } ]

/-- Spirit baptism, set as chapters: what the question is and who answers it;
each view from its own texts, with what Acts can carry; the views weighed
against each other; and the claims, as an appendix. -/
def spiritBaptismChapters : List Chapter :=
  [ { slug := "spirit-baptism", title := "Spirit baptism: the question and its answers"
    , modules := [`TestimonyArguments.SpiritBaptism] }
  , { slug := "the-views", title := "Each view from its own texts, and what Acts can carry"
    , modules := [`TestimonyArguments.SpiritBaptism.Positions] }
  , { slug := "weighing", title := "Weighing the four views"
    , modules := [`TestimonyArguments.SpiritBaptism.Dispute] }
  , { slug := "claims", title := "Appendix: the claims and their sources"
    , modules := [ `TestimonyArguments.SpiritBaptism.Atoms
                 , `TestimonyArguments.SpiritBaptism.Sources ]
    , legend := true } ]

/-- The Triune God, set as chapters: what LST says and why it is checked; for
each question encoded, the texts and what each side adds to them, then the
positions weighed; and the claims, as an appendix. -/
def trinityChapters : List Chapter :=
  [ { slug := "trinity", title := "The Triune God: what Scripture settles, and what it leaves open"
    , modules := [`TestimonyArguments.Trinity] }
  , { slug := "the-order", title := "Is the Son less than the Father?"
    , modules := [`TestimonyArguments.Trinity.Order] }
  , { slug := "weighing-the-order", title := "Weighing the readings of the order texts"
    , modules := [`TestimonyArguments.Trinity.OrderDispute] }
  , { slug := "the-procession", title := "Does the Spirit proceed from the Son?"
    , modules := [`TestimonyArguments.Trinity.Procession] }
  , { slug := "weighing", title := "Weighing the positions on the procession"
    , modules := [`TestimonyArguments.Trinity.Dispute] }
  , { slug := "claims", title := "Appendix: the claims and their sources"
    , modules := [`TestimonyArguments.Trinity.Atoms, `TestimonyArguments.Trinity.Sources]
    , legend := true } ]

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
    , title := "Sola fide"
    , chapters := solaFideChapters }
  , { ns := `TestimonyArguments.CanonicalWitness
    , slug := "canonical-witness"
    , title := "The canonical witness — faith alone, from the texts all parties accept"
    , chapters := canonicalWitnessChapters }
  , { ns := `TestimonyArguments.SolaScriptura
    , slug := "sola-scriptura"
    , title := "Sola scriptura" }
  , { ns := `TestimonyArguments.SpiritBaptism
    , slug := "spirit-baptism"
    , title := "Spirit baptism — at conversion, after it, or in the sacraments"
    , chapters := spiritBaptismChapters }
  , { ns := `TestimonyArguments.Trinity
    , slug := "trinity"
    , title := "The Triune God — what Scripture settles, and what it leaves open"
    , chapters := trinityChapters } ]

end TestimonyArguments.Doc
