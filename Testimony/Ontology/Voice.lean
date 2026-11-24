import Testimony.Ontology.Voice.Definitions
import Testimony.Corpus.Greek

/-!
# What a word's voice is

**A draft article.** The library reads the voice of a Greek verb from its data
(`Testimony.Corpus.Greek.Token.voice?`), and a claim that a word is in a voice is
a claim of its own, `Statement.parses`. What a voice is, as a parsing, is not in
question: a form has one. This article writes it out (`Voice.Definitions`), and
shows it at work on the word of Galatians 5:6 (`one_voice_at_work`).

What it does in the library's arguments is computed by
`Testimony.Checks.Ontology`.
-/

namespace Testimony.Ontology.Voice

open Testimony Testimony.Semantics Testimony.Corpus.Greek

greek_word galatiansWorking from GAL 5 6 "ἐνεργέω"

/-- That ἐνεργουμένη in Galatians 5:6 is passive. -/
abbrev saysPassive : Statement := .parses .energeo galatiansWorking .passive

/-- That it is middle. -/
abbrev saysMiddle : Statement := .parses .energeo galatiansWorking .middle

/-- That it is not active. -/
abbrev notActive : Statement := .denied (.parses .energeo galatiansWorking .active)

/-- **"One word, one voice", at work.** That ἐνεργουμένη in Galatians 5:6 is
passive and that it is middle cannot both be held, given what a parsing is, and
not otherwise. That it is middle and that it is not active can: the definition
excludes a second voice, and denying a third agrees with it. -/
theorem one_voice_at_work :
    Ontology.excludeEachOther [oneVoice] saysPassive saysMiddle = true ∧
      Ontology.excludeEachOther [] saysPassive saysMiddle = false ∧
      Ontology.excludeEachOther [oneVoice] saysMiddle notActive = false := by
  decide

end Testimony.Ontology.Voice
