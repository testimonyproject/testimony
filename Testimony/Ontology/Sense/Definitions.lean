import Testimony.Semantics.Ontology

/-!
# Testimony.Ontology.Sense.Definitions — the same sense, both ways

`Statement.sameSense` says that a word has the same sense in two places: James's
"justify" in 2:24 is Paul's. Nothing in the order of the two places matters to
what is claimed. To say that James uses the word as Paul does is to say that
Paul uses it as James does, and to deny the one is to deny the other. The
reasoner did not know this. It read "the same sense at James 2:24 as in Paul"
and "not the same sense in Paul as at James 2:24" as two unrelated facts, so a
claim stated in one order and its denial stated in the other did not exclude
each other. This article writes out what "the same" means.
-/

namespace Testimony.Ontology.Sense

open Testimony Testimony.Semantics

/-- **The same sense runs both ways.** Whoever holds that a word has the same
sense at one place as at another holds that it has the same sense at the second
as at the first; whoever denies the one denies the other. That is what "the same"
means, and no reader disputes it. What readers dispute is whether a word *does*
keep its sense from one place to another, and that stays a premise, cited and
rated, wherever an argument turns on it. -/
def bothWays : Definition :=
  { name := "the same sense, both ways"
  , says := "A word with the same sense at one place as at another has the same " ++
      "sense at the other as at the first."
  , form := .sameSenseBothWays
  , source :=
      { primary := .proposal
          ("The vocabulary's own definition of `Statement.sameSense` " ++
           "(Testimony.Semantics.Grammar): \"A word has the same sense in both scopes.\"")
      , tradition := .formalOntology
      , confidence := .consensus } }

/-- The definitions this article writes out. -/
def definitions : Ontology := [bothWays]

end Testimony.Ontology.Sense
