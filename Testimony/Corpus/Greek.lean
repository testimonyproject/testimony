import Lean
import Testimony.Text

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

/-- MACULA's code for each book of the New Testament. -/
def bookCodes : List (String × Lean.Name) :=
  [ ("MAT", `matthew), ("MRK", `mark), ("LUK", `luke), ("JHN", `john), ("ACT", `acts)
  , ("ROM", `romans), ("1CO", `firstCorinthians), ("2CO", `secondCorinthians)
  , ("GAL", `galatians), ("EPH", `ephesians), ("PHP", `philippians), ("COL", `colossians)
  , ("1TH", `firstThessalonians), ("2TH", `secondThessalonians), ("1TI", `firstTimothy)
  , ("2TI", `secondTimothy), ("TIT", `titus), ("PHM", `philemon), ("HEB", `hebrews)
  , ("JAS", `james), ("1PE", `firstPeter), ("2PE", `secondPeter), ("1JN", `firstJohn)
  , ("2JN", `secondJohn), ("3JN", `thirdJohn), ("JUD", `jude), ("REV", `revelation) ]

/-- The directory the corpus is read from: `data/greek/macula-sblgnt`, found by
looking up from the working directory, so that a build from the library's root
and one from `arguments/` read the same files. -/
def dataDir : IO System.FilePath := do
  let mut dir ← IO.currentDir
  for _ in [0:6] do
    let candidate := dir / "data" / "greek" / "macula-sblgnt"
    if ← candidate.isDir then return candidate
    match dir.parent with
    | some p => dir := p
    | none => break
  throw <| IO.userError "Testimony.Corpus.Greek: data/greek/macula-sblgnt not found"

/-- One row of a book's file, read into its fields: chapter, verse, position, and
the five columns after the reference. -/
structure Row where
  /-- Its chapter. -/
  chapter : Nat
  /-- Its verse. -/
  verse : Nat
  /-- Its position in the verse. -/
  position : Nat
  /-- Its role. -/
  role : String
  /-- Its part of speech. -/
  wordClass : String
  /-- The word as printed. -/
  text : String
  /-- Its dictionary form. -/
  lemma : String
  /-- Its parsing. -/
  morph : String

/-- Read a row of a book's file: `JHN 1:1!14  p  noun  θεὸς  θεός  N-NSM`. -/
def parseRow (line : String) : Option Row := do
  match line.splitOn "\t" with
  | [ref, role, cls, text, lemma, morph] =>
    let [_, cv] := ref.splitOn " " | none
    let [chv, pos] := cv.splitOn "!" | none
    let [ch, v] := chv.splitOn ":" | none
    pure { chapter := ← ch.toNat?, verse := ← v.toNat?, position := ← pos.toNat?
         , role, wordClass := cls, text, lemma, morph }
  | _ => none

/-- Every row of one book's file, in the order of its words. -/
def readBook (code : String) : IO (Array Row) := do
  let path := (← dataDir) / s!"{code}.tsv"
  let lines := (← IO.FS.readFile path).splitOn "\n"
  let mut rows := #[]
  for line in lines.drop 1 do
    if line.isEmpty then continue
    match parseRow line with
    | some r => rows := rows.push r
    | none => throw <| IO.userError s!"Testimony.Corpus.Greek: cannot read {path}: {line}"
  return rows

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

/-! ### Part of a verse

An argument sometimes needs half a verse: John 3:18 says "whoever believes in him is not
condemned" and then "whoever does not believe is condemned already, because he has not believed
in the name", and a reader may treat the two halves differently. `verse_part` names such a part
by the positions of its first and last words, and by one word it contains, its anchor. It reads
the corpus when the module is built and refuses the part, failing the build, unless the verse is
there, the positions lie within it, and the anchor occurs in the part exactly once. So a part
cannot silently stand for the whole verse, or for words the verse does not have. -/

/-- Why a part of a verse cannot be anchored in these words of the verse, or `none` if it can. -/
def partProblem (words : List Row) (first last : Nat) (anchor : String) : Option String :=
  let n := words.length
  if words.isEmpty then some "the verse has no words in the corpus"
  else if first == 0 || first > last then some s!"words {first} to {last} are not a span"
  else if last > n then some s!"the verse has {n} words, not {last}"
  else
    let span := words.filter fun r => first ≤ r.position && r.position ≤ last
    match (span.filter (·.lemma == anchor)).length with
    | 1 => none
    | 0 => some s!"its anchor {anchor} is not among words {first} to {last}"
    | k => some s!"its anchor {anchor} occurs {k} times among words {first} to {last}"

/-- Write `def n : PassageRange`, part `letter` of verse `c:v` of the book with code `code`,
words `first` to `last`, after checking it against the corpus. See the section above. -/
def versePart (n : Ident) (code : String) (c v first last : Nat) (letter anchor : String) :
    CommandElabM Unit := do
  let some (_, bookName) := bookCodes.find? (·.1 == code)
    | throwError "verse_part: no book with code {code}"
  let rows ← liftIO (readBook code)
  let words := (rows.filter fun r => r.chapter == c && r.verse == v).toList
  if let some why := partProblem words first last anchor then
    throwError "verse_part: {code} {c}:{v}{letter}: {why}"
  let book := mkCIdent (``Testimony.Book ++ bookName)
  elabCommand (← `(command|
    /-- Part of a verse, anchored in the Greek corpus by `verse_part`. -/
    def $n : Testimony.PassageRange :=
      .part { verse := ⟨$book, $(quote c), $(quote v)⟩, letter := $(quote letter)
            , first := $(quote first), last := $(quote last), anchor := $(quote anchor) }))

/-- `verse_part n from JHN 3 18 1 6 "a" "πιστεύω"` writes `def n`, John 3:18a: in order, the
book, chapter and verse, the positions of the part's first and last words, its letter, and the
dictionary form of the word that anchors it. Here that is the verse's first six words, anchored
by its one πιστεύω. -/
syntax (name := versePartCmd) "verse_part " ident " from " ident num num num num str str : command

elab_rules : command
  | `(verse_part $n from $code $c $v $a $b $l $w) =>
    versePart n code.getId.toString c.getNat v.getNat a.getNat b.getNat l.getString w.getString

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
COL: 1580 words
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
