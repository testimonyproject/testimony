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

/-- Sola fide, set as a book. After the opening chapter come two parts: the
story of the doctrine, told in the order its voices wrote, each group hearing
only the voices of its own time; and then one chapter for each question a reader
brings to it, in the order a reader would ask them. The claims and their
sources, which every chapter's formulas point to, are an appendix. -/
def solaFideChapters : List Chapter :=
  [ { slug := "sola-fide", title := "What sola fide claims"
    , modules := [`TestimonyArguments.SolaFide] }
  , { slug := "scripture", title := "What Scripture says"
    , modules := [`TestimonyArguments.SolaFide.WhatScriptureSays]
    , part := "The story, in the order it was told" }
  , { slug := "before-trent", title := "Was faith alone read in Paul before Trent?"
    , modules := [`TestimonyArguments.SolaFide.BeforeTrent] }
  , { slug := "reformation", title := "The Reformation's case, 1521–1541"
    , modules := [`TestimonyArguments.SolaFide.Reformation] }
  , { slug := "trent-answers", title := "The council answers, 1547"
    , modules := [`TestimonyArguments.SolaFide.TrentAnswers] }
  , { slug := "four-witnesses", title := "Four witnesses: Paul, Luke, Acts and John"
    , modules := [ `TestimonyArguments.SolaFide.Lines, `TestimonyArguments.SolaFide.Packages
                 , `TestimonyArguments.SolaFide.Results ]
    , part := "The questions, one at a time" }
  , { slug := "john", title := "John: \"this is the work of God, that you believe\""
    , modules := [`TestimonyArguments.SolaFide.Johannine] }
  , { slug := "trent-and-paul", title := "Where Trent parts from Paul"
    , modules := [`TestimonyArguments.SolaFide.Gospel] }
  , { slug := "faith-and-charity", title := "Faith working through love"
    , modules := [`TestimonyArguments.SolaFide.FaithAndCharity] }
  , { slug := "trents-definition", title := "What Trent means by justification"
    , modules := [`TestimonyArguments.SolaFide.Definition] }
  , { slug := "what-each-side-must-deny", title := "What each side must deny about Paul's word"
    , modules := [`TestimonyArguments.SolaFide.Burdens] }
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

/-- Born of a virgin, set as chapters: Matthew's claim and the four strands;
what each strand depends on; whether Isaiah's sign was only for Ahaz; Wegner's
grammar; the Septuagint's word, and Matthew's reading of it; "her seed" in
Genesis 3:15, and the verse as a promise fulfilled; and the claims, as an
appendix. -/
def bornOfAVirginChapters : List Chapter :=
  [ { slug := "born-of-a-virgin"
    , title := "Born of a virgin: Matthew's claim, and the texts it rests on"
    , modules := [`TestimonyArguments.BornOfAVirgin] }
  , { slug := "the-strands", title := "Four strands, and what each depends on"
    , modules := [ `TestimonyArguments.BornOfAVirgin.Lines
                 , `TestimonyArguments.BornOfAVirgin.Packages
                 , `TestimonyArguments.BornOfAVirgin.Results ] }
  , { slug := "ahaz", title := "Was Isaiah's sign only for Ahaz?"
    , modules := [`TestimonyArguments.BornOfAVirgin.Dispute] }
  , { slug := "wegner", title := "Was the woman already pregnant?"
    , modules := [ `TestimonyArguments.BornOfAVirgin.Results.Wegner
                 , `TestimonyArguments.BornOfAVirgin.Dispute.Wegner ] }
  , { slug := "septuagint", title := "What the Septuagint's word meant"
    , modules := [ `TestimonyArguments.BornOfAVirgin.Results.Septuagint
                 , `TestimonyArguments.BornOfAVirgin.Dispute.Septuagint
                 , `TestimonyArguments.BornOfAVirgin.Dispute.Miller ] }
  , { slug := "matthew", title := "Matthew's reading of the word"
    , modules := [`TestimonyArguments.BornOfAVirgin.Dispute.Matthew] }
  , { slug := "her-seed", title := "Does Genesis 3:15 rule out a human father?"
    , modules := [ `TestimonyArguments.BornOfAVirgin.Results.Genesis
                 , `TestimonyArguments.BornOfAVirgin.Dispute.Genesis ] }
  , { slug := "the-promise", title := "Is Genesis 3:15 a promise, fulfilled in Jesus?"
    , modules := [ `TestimonyArguments.BornOfAVirgin.Dispute.Protoevangelium
                 , `TestimonyArguments.BornOfAVirgin.Dispute.PromiseHearing ] }
  , { slug := "claims", title := "Appendix: the claims and their sources"
    , modules := [ `TestimonyArguments.BornOfAVirgin.Atoms
                 , `TestimonyArguments.BornOfAVirgin.Sources
                 , `TestimonyArguments.BornOfAVirgin.Sources.Genesis
                 , `TestimonyArguments.BornOfAVirgin.Sources.NearTerm
                 , `TestimonyArguments.BornOfAVirgin.Sources.Septuagint
                 , `TestimonyArguments.BornOfAVirgin.Sources.Versions
                 , `TestimonyArguments.BornOfAVirgin.Sources.Wegner ]
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

/-- Sola scriptura, set as chapters: the claim and the positions on tradition;
the three objections and the answers to them; Mark 7, and the same principle
from Jesus and Paul; Mark 7 weighed between Rome and the Reformers; the council
at Jerusalem and Moses' seat, each read both ways; and the claims, as an
appendix. -/
def solaScripturaChapters : List Chapter :=
  [ { slug := "sola-scriptura"
    , title := "Sola scriptura: the claim, and the positions on tradition"
    , modules := [`TestimonyArguments.SolaScriptura] }
  , { slug := "objections", title := "Three objections, and the answers to them"
    , modules := [ `TestimonyArguments.SolaScriptura.Lines
                 , `TestimonyArguments.SolaScriptura.Packages
                 , `TestimonyArguments.SolaScriptura.Results ] }
  , { slug := "canon", title := "How the canon is recognised"
    , modules := [`TestimonyArguments.SolaScriptura.Canon] }
  , { slug := "mark-7", title := "What Jesus' rebuke of tradition settles"
    , modules := [`TestimonyArguments.SolaScriptura.Mark7] }
  , { slug := "jesus-and-paul", title := "The same principle, beyond Mark 7"
    , modules := [`TestimonyArguments.SolaScriptura.JesusAndPaul] }
  , { slug := "weighing", title := "Weighing Mark 7 between Rome and the Reformers"
    , modules := [ `TestimonyArguments.SolaScriptura.Dispute
                 , `TestimonyArguments.SolaScriptura.Hearings ] }
  , { slug := "acts-15", title := "The council at Jerusalem, read both ways"
    , modules := [`TestimonyArguments.SolaScriptura.Acts15] }
  , { slug := "moses-seat", title := "Moses' seat, read both ways"
    , modules := [`TestimonyArguments.SolaScriptura.MosesSeat] }
  , { slug := "claims", title := "Appendix: the claims and their sources"
    , modules := [ `TestimonyArguments.SolaScriptura.Atoms
                 , `TestimonyArguments.SolaScriptura.Sources ]
    , legend := true } ]

/-- Sola gratia, set as chapters: what it claims and why it must be stated
sharply; the two Reformed routes and what each depends on; freedom to refuse,
with the Lutherans, Wesley and the third way; the positions weighed; and the
claims, as an appendix. -/
def solaGratiaChapters : List Chapter :=
  [ { slug := "sola-gratia", title := "Sola gratia: what everyone grants, and what divides them"
    , modules := [`TestimonyArguments.SolaGratia] }
  , { slug := "two-routes", title := "Two routes: Ephesians 2 and Romans 9"
    , modules := [ `TestimonyArguments.SolaGratia.Lines, `TestimonyArguments.SolaGratia.Packages
                 , `TestimonyArguments.SolaGratia.Results ] }
  , { slug := "freedom-to-refuse", title := "Freedom to refuse, and the ability God gives"
    , modules := [`TestimonyArguments.SolaGratia.ThirdWay] }
  , { slug := "aquinas", title := "Aquinas and the Catholic schools"
    , modules := [`TestimonyArguments.SolaGratia.Thomist] }
  , { slug := "weighing", title := "Weighing the positions"
    , modules := [`TestimonyArguments.SolaGratia.Dispute] }
  , { slug := "perseverance", title := "The perseverance of the saints"
    , modules := [`TestimonyArguments.SolaGratia.Perseverance] }
  , { slug := "claims", title := "Appendix: the claims and their sources"
    , modules := [`TestimonyArguments.SolaGratia.Atoms, `TestimonyArguments.SolaGratia.Sources]
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
  , { slug := "the-deity", title := "Are the Son and the Spirit God, and three persons?"
    , modules := [`TestimonyArguments.Trinity.Deity] }
  , { slug := "weighing-the-deity", title := "Weighing the positions on the deity and the persons"
    , modules := [`TestimonyArguments.Trinity.DeityDispute] }
  , { slug := "the-nicene-case", title := "The Nicene case, supplemented"
    , modules := [`TestimonyArguments.Trinity.DeityCase] }
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
    , title := "Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3"
    , chapters := bornOfAVirginChapters }
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
    , title := "Sola scriptura"
    , chapters := solaScripturaChapters }
  , { ns := `TestimonyArguments.SolaGratia
    , slug := "sola-gratia"
    , title := "Sola gratia — Ephesians 2:8–9 and Romans 9:16"
    , chapters := solaGratiaChapters }
  , { ns := `TestimonyArguments.SpiritBaptism
    , slug := "spirit-baptism"
    , title := "Spirit baptism — at conversion, after it, or in the sacraments"
    , chapters := spiritBaptismChapters }
  , { ns := `TestimonyArguments.Trinity
    , slug := "trinity"
    , title := "The Triune God — what Scripture settles, and what it leaves open"
    , chapters := trinityChapters } ]

end TestimonyArguments.Doc
