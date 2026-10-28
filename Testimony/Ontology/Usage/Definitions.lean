import Testimony.Semantics.Ontology

/-!
# Testimony.Ontology.Usage.Definitions — a sense found in a passage is a sense of the usage

The vocabulary reads a word in one passage, or in a voice's usage "as a whole"
(`Scope.usage`). A third place joins the two: one passage of a voice's own text
(`Scope.passageOf`), the Septuagint's Leviticus 21:13 as against the Hebrew's. A
usage as a whole is the senses its passages give the word, so a sense the word
has in one of them is a sense it has in the whole. That is what "as a whole"
means. It is not a reading of any text.
-/

namespace Testimony.Ontology.Usage

open Testimony Testimony.Semantics

/-- **A sense a word has in one passage of a text is a sense it has in that
text's usage.** `Scope.usage` is a voice's usage "as a whole", and
`Scope.passageOf` is one passage of the voice's own text. So whoever holds that
the Septuagint's Leviticus 21:13 uses παρθένος in the sense "virgin" holds that
"virgin" is among the word's senses in the Septuagint's Greek, and cannot hold
that the Septuagint's Greek lacked that sense.

The converse is not part of it. A word may have two senses in a usage and only
one of them in a given passage, so a sense in the usage says nothing of any one
passage. -/
def senseInUsage : Definition :=
  { name := "a sense in a usage"
  , says := "A sense a word has in one passage of a voice's text is a sense it has " ++
      "in that voice's usage."
  , form := .inUsage
  , source :=
      { primary := .proposal
          ("The vocabulary's own definition of `Scope.usage` " ++
           "(Testimony.Semantics.Grammar): \"An author's or tradition's usage as a whole.\"")
      , tradition := .formalOntology
      , confidence := .consensus } }

/-- The definitions this article writes out. -/
def definitions : Ontology := [senseInUsage]

end Testimony.Ontology.Usage
