import Testimony.Corpus.Greek

/-!
# Testimony.Corpus.Rendering — a translation, word by word against the Greek

A translation says in English what a verse says in Greek, and a reader who
cannot read the Greek has to take it on trust. Some of what a translation does
can be checked instead: whether each English word has a Greek word behind it,
and whether the translator marks the words that have none. A `Rendering` is a
translation of one verse with that alignment written down: each English word,
the positions of the Greek words it renders (`Testimony.Corpus.Greek.Token`),
and whether the translator prints it as supplied, in brackets or italics. From
the alignment two lists are computed rather than asserted:

- the **additions**: English words that render no Greek word, each marked as
  supplied or not;
- the **omissions**: Greek words that no English word renders.

## What this claims, and what it does not

English needs words Greek does not: "the", "they are", "things" after a Greek
adjective. So an addition is not a fault in itself, and this module does not say
which additions a translation needed. That is a reading, argued and rated like
any other. What it says is what the alignment shows: which English words have no
Greek behind them, and whether the translator told the reader so.

An alignment is itself a reading of the verse. The alignments here are the
library's own, made word by word against the SBLGNT as `Testimony.Corpus.Greek`
holds it, and are cited as the library's. A published interlinear, where one
exists, can be cited instead.

## The first case: Colossians 1:16–17

"For by him all things were created" (Colossians 1:16, ESV). The Greek has τὰ
πάντα, "all things", here and three times more in the two verses. The New World
Translation of the Jehovah's Witnesses (2013 revision) prints "all other things"
each time, and its 1984 edition had printed "other" in brackets, as a word the
translators supplied. Bruce Metzger wrote of the earlier edition that "the word
'other' has been unwarrantably inserted four times" (*Theology Today*, 1953,
p. 76). The renderings below are the two translations' own words, read on
jw.org and biblegateway.com on 2026-11-16; the alignments are the library's.
-/

namespace Testimony.Corpus

open Testimony.Corpus.Greek

/-- One English word of a rendering: the word, the positions in its verse of the
Greek words it renders (empty when it renders none), and whether the translator
prints it as supplied. -/
structure RenderedWord where
  /-- The English word. -/
  text : String
  /-- The positions, from 1, of the Greek words it renders in its verse. -/
  source : List Nat
  /-- Whether the translator prints it as supplied, in brackets or italics. -/
  marked : Bool := false
deriving Repr, DecidableEq

/-- A translation of one verse, aligned word by word to the Greek. -/
structure Rendering where
  /-- The translation and edition: "New World Translation (2013)". -/
  translation : String
  /-- The verse it renders. -/
  verse : Nat
  /-- Its English words, in order, each with the Greek words it renders. -/
  words : List RenderedWord
deriving Repr, DecidableEq

namespace Rendering

/-- The English words that render no Greek word. -/
def additions (r : Rendering) : List RenderedWord := r.words.filter (·.source.isEmpty)

/-- The English words that render no Greek word and are not marked as supplied. -/
def unmarkedAdditions (r : Rendering) : List String :=
  (r.additions.filter (!·.marked)).map (·.text)

/-- The Greek words of the verse that no English word renders. -/
def omissions (r : Rendering) (tokens : List Token) : List String :=
  ((tokens.filter (·.verse == r.verse)).filter fun t =>
    r.words.all fun w => !w.source.contains t.position).map (·.text)

/-- Whether every position the alignment cites is a word of the verse. -/
def aligned (r : Rendering) (tokens : List Token) : Bool :=
  r.words.all fun w => w.source.all fun i =>
    tokens.any fun t => t.verse == r.verse && t.position == i

end Rendering

/-! ### Colossians 1:16–17 -/

greek_passage colossiansPassage from COL 1 16 17

/-- Write an English word that renders the Greek words at `is`. -/
private def w (text : String) (is : List Nat) : RenderedWord := { text, source := is }

/-- The New World Translation (2013) of Colossians 1:16: "because by means of him
all other things were created in the heavens and on the earth, the things visible
and the things invisible, whether they are thrones or lordships or governments or
authorities. All other things have been created through him and for him." -/
def nwtColossians16 : Rendering :=
  { translation := "New World Translation (2013)", verse := 16
  , words :=
      [ w "because" [1], w "by" [2], w "means" [2], w "of" [2], w "him" [3]
      , w "all" [5, 6], w "other" [], w "things" [6], w "were" [4], w "created" [4]
      , w "in" [7], w "the" [8], w "heavens" [9], w "and" [10], w "on" [11], w "the" [12]
      , w "earth" [13], w "the" [14], w "things" [15], w "visible" [15], w "and" [16]
      , w "the" [17], w "things" [18], w "invisible" [18], w "whether" [19], w "they" []
      , w "are" [], w "thrones" [20], w "or" [21], w "lordships" [22], w "or" [23]
      , w "governments" [24], w "or" [25], w "authorities" [26], w "All" [27, 28]
      , w "other" [], w "things" [28], w "have" [34], w "been" [34], w "created" [34]
      , w "through" [29], w "him" [30], w "and" [31], w "for" [32], w "him" [33] ] }

/-- The ESV of Colossians 1:16: "For by him all things were created, in heaven and
on earth, visible and invisible, whether thrones or dominions or rulers or
authorities—all things were created through him and for him." -/
def esvColossians16 : Rendering :=
  { translation := "English Standard Version", verse := 16
  , words :=
      [ w "For" [1], w "by" [2], w "him" [3], w "all" [5, 6], w "things" [6], w "were" [4]
      , w "created" [4], w "in" [7], w "heaven" [8, 9], w "and" [10], w "on" [11]
      , w "earth" [12, 13], w "visible" [14, 15], w "and" [16], w "invisible" [17, 18]
      , w "whether" [19], w "thrones" [20], w "or" [21], w "dominions" [22], w "or" [23]
      , w "rulers" [24], w "or" [25], w "authorities" [26], w "all" [27, 28]
      , w "things" [28], w "were" [34], w "created" [34], w "through" [29], w "him" [30]
      , w "and" [31], w "for" [32], w "him" [33] ] }

/-- The New World Translation (2013) of Colossians 1:17: "Also, he is before all
other things, and by means of him all other things were made to exist". -/
def nwtColossians17 : Rendering :=
  { translation := "New World Translation (2013)", verse := 17
  , words :=
      [ w "Also" [1], w "he" [2], w "is" [3], w "before" [4], w "all" [5], w "other" []
      , w "things" [5], w "and" [6], w "by" [9], w "means" [9], w "of" [9], w "him" [10]
      , w "all" [7, 8], w "other" [], w "things" [8], w "were" [11], w "made" [11]
      , w "to" [11], w "exist" [11] ] }

/-- The ESV of Colossians 1:17: "And he is before all things, and in him all
things hold together." -/
def esvColossians17 : Rendering :=
  { translation := "English Standard Version", verse := 17
  , words :=
      [ w "And" [1], w "he" [2], w "is" [3], w "before" [4], w "all" [5], w "things" [5]
      , w "and" [6], w "in" [9], w "him" [10], w "all" [7, 8], w "things" [8]
      , w "hold" [11], w "together" [11] ] }

/-- Every alignment cites only words of its verse, and every Greek word of the two
verses is rendered by some English word, in both translations. -/
theorem colossians_alignments_complete :
    [nwtColossians16, esvColossians16, nwtColossians17, esvColossians17].all
      (·.aligned colossiansPassage) = true ∧
    [nwtColossians16, esvColossians16, nwtColossians17, esvColossians17].all
      (·.omissions colossiansPassage == []) = true := by
  decide

/-- **In Colossians 1:16–17 the New World Translation (2013) adds "other" four times,
unmarked, where the Greek has no word for it; the ESV adds nothing.** Aligned word
by word against the SBLGNT, the New World Translation's two verses have six English
words with no Greek behind them, none marked as supplied: "other" before each of
the four "things" that render τὰ πάντα or πάντων, and "they are" in "whether they
are thrones". The ESV's two verses have none.

What this does not claim: that "other" is wrong. Whether the context implies it,
as the Witnesses hold, is a reading of the verse, and it is argued and rated as
one. Nor does it say "they are" was needless; English may want it. It says what
the alignment shows: that the Greek has no word for "other" here, and that the
2013 edition, unlike the 1984, does not mark it as supplied. The alignments are the
library's own. -/
theorem colossians_additions :
    (nwtColossians16.unmarkedAdditions ++ nwtColossians17.unmarkedAdditions) =
      ["other", "they", "are", "other", "other", "other"] ∧
    (esvColossians16.unmarkedAdditions ++ esvColossians17.unmarkedAdditions) = [] := by
  decide

end Testimony.Corpus
