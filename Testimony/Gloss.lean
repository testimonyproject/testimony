import Testimony.Provenance

/-!
# Glosses: the English for a Greek or Hebrew word

A reader with an English Bible and no Greek reads "ἐνεργουμένη is passive" as a row of
shapes. So every Greek or Hebrew word the arguments print stands beside its English, and
the English is not the library's own: each rendering names the lexicon or translation that
gives it, at the place it gives it. Where the translations part, as they do over παρθένος,
"virgin" or "young woman", the glossary gives both, each with its source, and the prose
gives both too.

A package keeps one glossary, in its `Glossary` module. Rule L13 of
`scripts/testimony_lint.py` reads it, and fails a docstring or a label that prints a word
with none of its renderings beside it, or a word the glossary does not have.
-/

namespace Testimony

/-- One English rendering of a word, and who renders it so: a lexicon's entry for the
word, or a translation at a verse where the word stands. Where no work in the bibliography
renders a quotation from the Greek or Hebrew, as with a father read in Migne, the rendering
is the library's own, and says so: it is a `Reference.proposal`, with the reason. -/
structure Gloss.Rendering where
  /-- The English, as the prose prints it beside the word: "working". -/
  english : String
  /-- The lexicon or translation that gives it, at its entry or verse, or the library's
  proposal. -/
  source : Reference
deriving Repr

/-- A Greek or Hebrew word or phrase, exactly as the prose prints it, with every English
rendering the prose may give beside it. -/
structure Gloss where
  /-- The word or phrase, in the form the prose prints: "ἐνεργουμένη", "ἔργα νόμου". -/
  original : String
  /-- Its renderings, the most common first. -/
  renderings : List Gloss.Rendering
deriving Repr

end Testimony
