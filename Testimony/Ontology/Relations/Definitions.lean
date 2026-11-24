import Testimony.Semantics.Ontology

/-!
# Testimony.Ontology.Relations.Definitions — what five relation words say

The vocabulary defines each of its relation words in a sentence
(`Testimony.Semantics.Vocabulary`). Five of those sentences say more than the
word's name does: "not a ground", "the only means", "the whole ground", say it
of another word, "works through" says that a means is moved by its user, and
"moves" that moving runs one way. Each is written out here as a definition the
reasoner holds, with the sentence it comes from as its source.

These are stipulations, not findings: they say what the library's own words
mean. So each is cited as the library's own (`Reference.proposal`), with the
vocabulary's sentence quoted, and rated `consensus`: no reader disputes what a
word of this library means, only whether a claim made in it is true.
-/

namespace Testimony.Ontology.Relations

open Testimony Testimony.Semantics

/-- The source of a stipulated definition: the vocabulary's own sentence for the
word, quoted. -/
def stipulated (word sentence : String) : Source :=
  { primary := .proposal
      ("The vocabulary's own definition of `" ++ word ++ "` " ++
       "(Testimony.Semantics.Vocabulary): \"" ++ sentence ++ "\"")
  , tradition := .formalOntology
  , confidence := .consensus }

/-- **To be excluded from a thing is not to be its ground.** The vocabulary
defines `excludedFrom` as "the first is not a ground of the second". So to hold
that works are excluded from justification is to deny that they are its ground,
and to deny that they are excluded is to hold that they are. -/
def notAGround : Definition :=
  { name := "not a ground"
  , says := "To be excluded from a thing is not to be a ground of it."
  , form := .denies .excludedFrom .groundOf
  , source := stipulated "excludedFrom" "The first is not a ground of the second." }

/-- **The only means of a thing is a means of it, and nothing else is.**
`soleInstrumentOf` is "the only means by which the second is received", and
`instrumentOf` "the means by which". So whoever holds faith the only means by
which justification is received holds faith a means of it, and holds that
nothing else is: not baptism, not works, not anything. -/
def onlyMeans : Definition :=
  { name := "the only means"
  , says := "The only means of a thing is a means of it, and nothing else is."
  , form := .only .soleInstrumentOf .instrumentOf
  , source := stipulated "soleInstrumentOf"
      "The first is the only means by which the second is received." }

/-- **The whole ground of a thing is a ground of it, and nothing else is.**
`soleGroundOf` is "the whole ground of the second: nothing added completes it".
A ground that needed another beside it would not be the whole; another ground
beside it would be something added. -/
def wholeGround : Definition :=
  { name := "the whole ground"
  , says := "The whole ground of a thing is a ground of it, and nothing else is."
  , form := .only .soleGroundOf .groundOf
  , source := stipulated "soleGroundOf"
      "The first is the whole ground of the second: nothing added completes it." }

/-- **What works through a means moves it.** `worksThrough` is "the second is the
means by which the first is at work, as the hand works through the stick", and
`moves` "the second acts because, and as, the first moves it". A means is what
its user is at work by, so the user moves it: the hand moves the stick. -/
def meansIsMoved : Definition :=
  { name := "a means is moved by its user"
  , says := "What works through a means moves it."
  , form := .implies .worksThrough .moves
  , source := stipulated "worksThrough"
      "The first works through the second: the second is the means by which the first \
        is at work, as the hand works through the stick." }

/-- **Moving runs one way.** `moves` is "the second acts because, and as, the
first moves it", in one respect. So in that respect a thing moved does not move
its mover: the stick does not move the hand that moves it. A thing moved in one
respect may move its mover in another, and that is another relation, which this
definition says nothing of. -/
def movingRunsOneWay : Definition :=
  { name := "moving runs one way"
  , says := "What a thing moves does not move it, in the same respect."
  , form := .asymmetric .moves
  , source := stipulated "moves"
      "The first moves the second: the second acts because, and as, the first moves it." }

/-- The definitions this article writes out. -/
def definitions : Ontology :=
  [notAGround, onlyMeans, wholeGround, meansIsMoved, movingRunsOneWay]

end Testimony.Ontology.Relations
