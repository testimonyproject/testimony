import Lean
import Testimony.Corpus.Table

/-!
# Testimony.Corpus.Greek — the Greek New Testament, word by word

Until now a text entered the library as its English words and a reference, and
anything said about its Greek was said in a premise, cited to whoever said it.
This module makes the Greek itself data. Each word of a book is a `Token`: where
it stands, what it is (a noun, the article, a verb), its dictionary form, its
parsing, and, where the word is a whole constituent of its clause, its role
there (subject, predicate, object). A claim about what the text *contains*, that
a word has no article or that no word for "other" stands in a verse, can then be
checked against the data rather than asserted.

The words come from MACULA Greek, Clear Bible's annotation of the SBL Greek New
Testament, both licensed CC BY 4.0 (`Testimony.Bib.maculaGreek`,
`Testimony.Bib.sblgnt`). `scripts/import_greek.py` writes one file per book under
`data/greek/macula-sblgnt/`, keeping only the columns read here; that
directory's README records the source and its checksum.

## What the data is, and what it is not

The words of the text are the SBLGNT's, a critical text: where the manuscripts
differ, it gives one reading, and a dispute that turns on a variant must say so.
The tagging is an interpretation. A word's parsing and its role are Clear
Bible's reading of the Greek, usually uncontested and sometimes not, and the
library cites them as theirs. A role is given only where a single word is a
whole constituent; where a phrase is, as "ὁ λόγος" is the subject of John 1:1c,
the word table leaves the role blank, because the role belongs to the phrase.

## How it is read

`greek_passage n from JHN 1 1 18` reads John 1:1–18 from the data when the
module is built and writes `def n : List Token` as a literal, so that a result
about those words is checked by the kernel like any other. Whole books are too
large for that; checks over a whole book are evaluated at build time and their
reports pinned, as the library's other checks are. `#greek_corpus` reports how
many words each imported book has, and the count is pinned below, so a changed
import changes the build.
-/

namespace Testimony.Corpus.Greek

open Lean Elab Command

/-- One word of the Greek New Testament, as MACULA Greek's word table gives it. -/
structure Token where
  /-- The book it stands in. -/
  book : Book
  /-- Its chapter. -/
  chapter : Nat
  /-- Its verse. -/
  verse : Nat
  /-- Its position in the verse, from 1. -/
  position : Nat
  /-- Its role in its clause, where the word is a whole constituent: `s` subject,
  `p` predicate, `o` object, `v` verb, `vc` copula, and others; empty where the
  role belongs to a phrase. -/
  role : String
  /-- Its part of speech: `noun`, `verb`, `det` (the article), `adj`, `pron`, … -/
  wordClass : String
  /-- The word as printed in the SBLGNT. -/
  text : String
  /-- Its dictionary form. -/
  lemma : String
  /-- Its parsing, in Robinson's codes: `N-NSM` is a noun, nominative singular
  masculine. -/
  morph : String
deriving Repr, DecidableEq

namespace Token

/-- Whether the word is the article. -/
def isArticle (t : Token) : Bool := t.wordClass == "det"

/-- The word's case, for a declined word whose parsing gives it (`N-NSM`, `T-ASM`,
`A-GSM`): the letter after the first hyphen. -/
def caseLetter? (t : Token) : Option Char :=
  match t.morph.toList with
  | c :: '-' :: k :: _ => if c == 'N' || c == 'T' || c == 'A' || c == 'P' then some k else none
  | _ => none

/-- Whether the word is nominative. -/
def isNominative (t : Token) : Bool := t.caseLetter? == some 'N'

/-- Whether the word is the predicate of its clause, by the word table's role. -/
def isPredicate (t : Token) : Bool := t.role == "p"

/-- Whether the word is a verb. -/
def isVerb (t : Token) : Bool := t.wordClass == "verb"

end Token

/-- **The voice of a Greek verb.** In the active the subject acts ("faith works");
in the passive it is acted on ("faith is moved"); in the middle it acts, and the
action stays with it ("faith is at work"). In some tenses the middle and the
passive are spelled alike, so the spelling of such a form does not say which it
is, and a reader decides from how the verb is used. -/
inductive GreekVoice
  /-- The subject acts. -/
  | active
  /-- The subject acts, and the action stays with it. -/
  | middle
  /-- The subject is acted on. -/
  | passive
deriving DecidableEq, Repr

/-- The voice, in a word, for a report. -/
def GreekVoice.name : GreekVoice → String
  | .active => "active"
  | .middle => "middle"
  | .passive => "passive"

namespace Token

/-- **The voice the parsing gives a verb**, in Robinson's codes: the letter after
the tense in `V-PMP-NSF` (present, middle, participle). `A` is active, `M` middle,
`P` passive; `D` and `O` are the middle and passive of a verb with no active
(deponent), and are read as middle and passive. `E` and `N`, middle or passive,
leave the choice open, and so does a verb with no voice: none is given. -/
def voice? (t : Token) : Option GreekVoice :=
  if !t.isVerb then none else
  match t.morph.toList with
  | 'V' :: '-' :: rest =>
    match rest.dropWhile Char.isDigit with
    | _ :: 'A' :: _ => some .active
    | _ :: 'M' :: _ | _ :: 'D' :: _ => some .middle
    | _ :: 'P' :: _ | _ :: 'O' :: _ => some .passive
    | _ => none
  | _ => none

/-- The verse the word stands in. -/
def verseOf (t : Token) : PassageRange := .verse ⟨t.book, t.chapter, t.verse⟩

/-- Where the word stands, as a reference: `Gal 5:6, word 15`. -/
def place (t : Token) : String :=
  s!"{t.book.abbrev} {t.chapter}:{t.verse}, word {t.position}"

end Token

/-- MACULA's code for each book of the New Testament (`Testimony.Corpus.greek`). -/
def bookCodes : List (String × Lean.Name) := Testimony.Corpus.greek.books

/-- Every row of one book's file, in the order of its words. -/
def readBook (code : String) : IO (Array Testimony.Corpus.Row) :=
  Testimony.Corpus.greek.readBook code

/-- The directory the corpus is read from: `data/greek/macula-sblgnt`. -/
def dataDir : IO System.FilePath := Testimony.Corpus.greek.dir

/-- Write `def n : List Token` for verses `v₁` to `v₂` of chapter `c` of the book
with MACULA code `code`. See the module docstring. -/
def greekPassage (n : Ident) (code : String) (c v₁ v₂ : Nat) : CommandElabM Unit := do
  let some (_, bookName) := bookCodes.find? (·.1 == code)
    | throwError "greek_passage: no book with code {code}"
  let rows ← liftIO (readBook code)
  let picked := rows.filter fun r => r.chapter == c && v₁ ≤ r.verse && r.verse ≤ v₂
  if picked.isEmpty then throwError "greek_passage: no words in {code} {c}:{v₁}–{v₂}"
  let book := mkCIdent (``Testimony.Book ++ bookName)
  let terms ← picked.mapM fun r =>
    `(term| { book := $book, chapter := $(quote r.chapter), verse := $(quote r.verse)
            , position := $(quote r.position), role := $(quote r.role)
            , wordClass := $(quote r.wordClass), text := $(quote r.text)
            , lemma := $(quote r.lemma), morph := $(quote r.morph) })
  elabCommand (← `(command|
    /-- Words of the Greek New Testament, read from MACULA Greek (SBLGNT) by
    `greek_passage`. -/
    def $n : List Token := [$terms,*]))

/-- `greek_passage n from JHN 1 1 18` writes `def n : List Token`, the words of
John 1:1–18; `greek_passage n from JHN 1 1` writes those of John 1:1 alone. -/
syntax (name := greekPassageCmd) "greek_passage " ident " from " ident num num (num)? : command

elab_rules : command
  | `(greek_passage $n from $code $c $v₁ $[$v₂]?) =>
    greekPassage n code.getId.toString c.getNat v₁.getNat ((v₂.map (·.getNat)).getD v₁.getNat)

/-- Write `def n : Token`, the one word of verse `c:v` of the book with MACULA code
`code` whose dictionary form is `lemma`. Refused, failing the build, unless the
verse has exactly one such word. -/
def greekWord (n : Ident) (code : String) (c v : Nat) (lemma : String) : CommandElabM Unit := do
  let some (_, bookName) := bookCodes.find? (·.1 == code)
    | throwError "greek_word: no book with code {code}"
  let rows ← liftIO (readBook code)
  let picked := rows.filter fun r => r.chapter == c && r.verse == v && r.lemma == lemma
  let r ← match picked.toList with
    | [r] => pure r
    | [] => throwError "greek_word: {code} {c}:{v} has no word {lemma}"
    | rs => throwError "greek_word: {code} {c}:{v} has {rs.length} words {lemma}"
  let book := mkCIdent (``Testimony.Book ++ bookName)
  elabCommand (← `(command|
    /-- A word of the Greek New Testament, read from MACULA Greek (SBLGNT) by
    `greek_word`. -/
    def $n : Token :=
      { book := $book, chapter := $(quote r.chapter), verse := $(quote r.verse)
      , position := $(quote r.position), role := $(quote r.role)
      , wordClass := $(quote r.wordClass), text := $(quote r.text)
      , lemma := $(quote r.lemma), morph := $(quote r.morph) }))

/-- `greek_word n from GAL 5 6 "ἐνεργέω"` writes `def n : Token`, the word of
Galatians 5:6 whose dictionary form is ἐνεργέω, read from the data when the
module is built; the verse must have exactly one. -/
syntax (name := greekWordCmd) "greek_word " ident " from " ident num num str : command

elab_rules : command
  | `(greek_word $n from $code $c $v $lemma) =>
    greekWord n code.getId.toString c.getNat v.getNat lemma.getString

/-- `#greek_corpus` reports every imported book and how many words it has. -/
syntax (name := greekCorpusCmd) "#greek_corpus" : command

elab_rules : command
  | `(#greek_corpus) => do
    let dir ← liftIO dataDir
    let mut lines := #[]
    for (code, _) in bookCodes do
      if ← liftIO (dir / s!"{code}.tsv").pathExists then
        let rows ← liftIO (readBook code)
        lines := lines.push s!"{code}: {rows.size} words"
    logInfo m!"the Greek corpus:\n{String.intercalate "\n" lines.toList}"

/--
info: the Greek corpus:
JHN: 15625 words
ROM: 7055 words
2CO: 4473 words
GAL: 2226 words
EPH: 2416 words
COL: 1580 words
1TH: 1473 words
2TH: 820 words
TIT: 659 words
HEB: 4935 words
-/
#guard_msgs in
#greek_corpus

/-! ### A passage, read -/

greek_passage john1_1 from JHN 1 1

/-- **John 1:1, read from the data.** The verse has seventeen words. The
fourteenth, θεός, is a noun in the nominative, the predicate of its clause, with
no article before it, and it stands before its verb, ἦν. That is what the data
says the verse contains; what the construction means is argued elsewhere, by
readers cited for it. -/
theorem john1_1_theos :
    john1_1.length = 17 ∧
    (john1_1[13]?.map fun t =>
      (t.lemma, t.isNominative, t.isPredicate, john1_1[12]?.map Token.isArticle,
       john1_1[14]?.map Token.isVerb)) =
      some ("θεός", true, true, some false, some true) := by
  decide

/-! ### A part of a verse, read -/

verse_part johnThreeEighteenA from JHN 3 18 1 6 "a" "πιστεύω"

/-- **John 3:18a lies within John 3:18 and within John 3:16–18, and 3:18 does not lie within
it.** The part is the verse's first six words, ὁ πιστεύων εἰς αὐτὸν οὐ κρίνεται, "whoever
believes in him is not condemned", and `verse_part` has checked that its one πιστεύω is there.
It does not overlap 3:17. -/
theorem john3_18a_lies_within :
    johnThreeEighteenA.render = "John 3:18a" ∧
    johnThreeEighteenA.within (.verse ⟨.john, 3, 18⟩) ∧
    johnThreeEighteenA.within (.range ⟨.john, 3, 16, 3, 18⟩) ∧
    !(PassageRange.verse ⟨.john, 3, 18⟩).within johnThreeEighteenA ∧
    !johnThreeEighteenA.overlaps (.verse ⟨.john, 3, 17⟩) := by
  decide

/--
error: verse_part: JHN 3:18b: its anchor πιστεύω occurs 2 times among words 7 to 23
-/
#guard_msgs in
verse_part johnThreeEighteenBAmbiguous from JHN 3 18 7 23 "b" "πιστεύω"

/--
error: verse_part: JHN 3:18c: the verse has 23 words, not 30
-/
#guard_msgs in
verse_part johnThreeEighteenOverlong from JHN 3 18 1 30 "c" "πιστεύω"

end Testimony.Corpus.Greek
