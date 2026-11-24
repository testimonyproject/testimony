import Testimony.Semantics.Ontology

/-!
# Testimony.Ontology.Voice.Definitions — one word, one voice

`Statement.parses` says that a word of the Greek text, one token at its place in
a verse, is in a given voice: active, middle or passive. A token the data parses
is one form, with one parsing, and so one voice. To say that ἐνεργουμένη in
Galatians 5:6 is passive is therefore to say that it is not middle, and the
reasoner did not know this: it read "passive" and "middle" as two unrelated
facts about the word. This article writes out what a parsing is.
-/

namespace Testimony.Ontology.Voice

open Testimony Testimony.Semantics

/-- **A word has one voice.** Whoever holds that a token of the text is in one
voice holds that it is in no other. That is what parsing a form means, and no
reader disputes it. What readers dispute is *which* voice a form is in, where
the form allows two; the data gives that, and a reading of the Greek it does not
bear is the fault the library calls misreading the original
(`Testimony.Semantics.Move.misreadings`). -/
def oneVoice : Definition :=
  { name := "one word, one voice"
  , says := "A token of the text that is in one voice is in no other."
  , form := .oneVoice
  , source :=
      { primary := .proposal
          ("The vocabulary's own definition of `Statement.parses` " ++
           "(Testimony.Semantics.Grammar): a token parsed in one voice.")
      , tradition := .formalOntology
      , confidence := .consensus } }

/-- The definitions this article writes out. -/
def definitions : Ontology := [oneVoice]

end Testimony.Ontology.Voice
