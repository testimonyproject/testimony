import Lean
import Testimony.Text

/-!
# Testimony.Corpus.Table — the word tables of the Greek and Hebrew texts, and parts of verses

The library holds two texts word by word: the Greek New Testament, from MACULA Greek's table
for the SBL Greek New Testament (`data/greek/macula-sblgnt/`, read by `Testimony.Corpus.Greek`),
and the Hebrew Bible, from MACULA Hebrew's table for the Westminster Leningrad Codex
(`data/hebrew/macula-wlc/`, described in `Testimony.Corpus.Hebrew`). Both tables have one row
per word, in the same columns, so this module reads either: where a word stands, its part of
speech, the word as printed, its dictionary form and its parsing.

A Hebrew word is often more than one row. MACULA Hebrew splits a written word into its parts,
so "and you" (וְאַתָּה) is two rows, the conjunction and the pronoun, at one position. A
position is a written word; a row is one part of it.

## Verse numbers

A verse is named in the library as English Bibles number it. The Hebrew text numbers some verses
differently: what English Bibles call Micah 5:2, "But you, O Bethlehem Ephrathah" (ESV), is 5:1
in the Hebrew, whose 4:14 is the English 5:1. So before a Hebrew verse is read, its English
number is looked up in `data/hebrew/macula-wlc/versification.tsv`, which
`scripts/import_hebrew.py` writes from STEPBible's table of versification traditions (TVTMS,
`Testimony.Bib.stepTvtms`). A verse that table does not list is numbered alike in both. A verse
the Hebrew divides differently, joining it to another or splitting it, is listed with no Hebrew
verse, and nothing is read from it: a part of English Isaiah 64:1, which the Hebrew prints as
the end of 63:19, cannot be numbered by the Hebrew's words without saying where the English
verse begins.

## A part of a verse

An argument sometimes needs half a verse: John 3:18 says "whoever believes in him is not
condemned" and then "whoever does not believe is condemned already, because he has not believed
in the name", and a reader may treat the two halves differently. `verse_part` names such a part
by the positions of its first and last words, and by one word it contains, its anchor, named
by its dictionary form. It reads the text when the module is built and refuses the part, failing
the build, unless the book is in the corpus, the verse is there and numbered one to one, the
positions lie within it, and the anchor occurs in the part exactly once. So a part cannot
silently stand for the whole verse, or for words the verse does not have. A part written out by
hand is read again by `#check_verse_parts` (`Testimony.Checks.VerseParts`).
-/

namespace Testimony.Corpus

open Lean Elab Command

/-- A text held word by word: where its files are, under `data/`, and the code MACULA gives
each of its books, with the book it names. -/
structure Corpus where
  /-- Its name, as a message gives it: "Greek", "Hebrew". -/
  name : String
  /-- Its directory under `data/`: `["greek", "macula-sblgnt"]`. -/
  path : List String
  /-- MACULA's code for each of its books, and the book. -/
  books : List (String × Lean.Name)

/-- The Greek New Testament, from MACULA Greek's table for the SBLGNT. -/
def greek : Corpus where
  name := "Greek"
  path := ["greek", "macula-sblgnt"]
  books :=
    [ ("MAT", `matthew), ("MRK", `mark), ("LUK", `luke), ("JHN", `john), ("ACT", `acts)
    , ("ROM", `romans), ("1CO", `firstCorinthians), ("2CO", `secondCorinthians)
    , ("GAL", `galatians), ("EPH", `ephesians), ("PHP", `philippians), ("COL", `colossians)
    , ("1TH", `firstThessalonians), ("2TH", `secondThessalonians), ("1TI", `firstTimothy)
    , ("2TI", `secondTimothy), ("TIT", `titus), ("PHM", `philemon), ("HEB", `hebrews)
    , ("JAS", `james), ("1PE", `firstPeter), ("2PE", `secondPeter), ("1JN", `firstJohn)
    , ("2JN", `secondJohn), ("3JN", `thirdJohn), ("JUD", `jude), ("REV", `revelation) ]

/-- The Hebrew Bible, from MACULA Hebrew's table for the Westminster Leningrad Codex. -/
def hebrew : Corpus where
  name := "Hebrew"
  path := ["hebrew", "macula-wlc"]
  books :=
    [ ("GEN", `genesis), ("EXO", `exodus), ("LEV", `leviticus), ("NUM", `numbers)
    , ("DEU", `deuteronomy), ("JOS", `joshua), ("JDG", `judges), ("RUT", `ruth)
    , ("1SA", `firstSamuel), ("2SA", `secondSamuel), ("1KI", `firstKings)
    , ("2KI", `secondKings), ("1CH", `firstChronicles), ("2CH", `secondChronicles)
    , ("EZR", `ezra), ("NEH", `nehemiah), ("EST", `esther), ("JOB", `job), ("PSA", `psalms)
    , ("PRO", `proverbs), ("ECC", `ecclesiastes), ("SNG", `songOfSongs), ("ISA", `isaiah)
    , ("JER", `jeremiah), ("LAM", `lamentations), ("EZK", `ezekiel), ("DAN", `daniel)
    , ("HOS", `hosea), ("JOL", `joel), ("AMO", `amos), ("OBA", `obadiah), ("JON", `jonah)
    , ("MIC", `micah), ("NAM", `nahum), ("HAB", `habakkuk), ("ZEP", `zephaniah)
    , ("HAG", `haggai), ("ZEC", `zechariah), ("MAL", `malachi) ]

/-- Both texts. -/
def corpora : List Corpus := [greek, hebrew]

/-- The text that holds the book with MACULA code `code`, if either does. -/
def corpusOfCode? (code : String) : Option Corpus :=
  corpora.find? fun c => c.books.any (·.1 == code)

/-- The text and MACULA code of a book, named by its constructor (`Testimony.Book.micah`), if
either text holds it. -/
def codeOfBook? (book : Lean.Name) : Option (Corpus × String) :=
  corpora.findSome? fun c =>
    (c.books.find? fun (_, b) => ``Testimony.Book ++ b == book).map (c, ·.1)

/-- The directory a text is read from, found by looking up from the working directory, so that
a build from the library's root and one from `arguments/` read the same files. -/
def Corpus.dir (c : Corpus) : IO System.FilePath := do
  let mut dir ← IO.currentDir
  for _ in [0:6] do
    let candidate := c.path.foldl (· / ·) (dir / "data")
    if ← candidate.isDir then return candidate
    match dir.parent with
    | some p => dir := p
    | none => break
  throw <| IO.userError s!"Testimony.Corpus: data/{"/".intercalate c.path} not found"

/-- One row of a book's file, read into its fields: chapter, verse, position, and the five
columns after the reference. -/
structure Row where
  /-- Its chapter. -/
  chapter : Nat
  /-- Its verse. -/
  verse : Nat
  /-- Its position in the verse: the written word it is, or is part of. -/
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
  /-- For a verb, the dictionary forms of the words a text's syntax gives as its
  first argument, who or what does what it says; empty where none is named. -/
  actors : List String := []
  /-- Where those words stand, in the same order: `GAL 2:6!14`. -/
  actorRefs : List String := []

/-- Read a row of a book's file: `JHN 1:1!14  p  noun  θεὸς  θεός  N-NSM`, with,
in a file that has them, a verb's actors and where they stand, each list joined
by `;`. -/
def parseRow (line : String) : Option Row := do
  let (ref, role, cls, text, lemma, morph, actors, actorRefs) ← match line.splitOn "\t" with
    | [ref, role, cls, text, lemma, morph] => some (ref, role, cls, text, lemma, morph, "", "")
    | [ref, role, cls, text, lemma, morph, a, r] => some (ref, role, cls, text, lemma, morph, a, r)
    | _ => none
  let [_, cv] := ref.splitOn " " | none
  let [chv, pos] := cv.splitOn "!" | none
  let [ch, v] := chv.splitOn ":" | none
  let list (s : String) := if s.isEmpty then [] else s.splitOn ";"
  pure { chapter := ← ch.toNat?, verse := ← v.toNat?, position := ← pos.toNat?
       , role, wordClass := cls, text, lemma, morph
       , actors := list actors, actorRefs := list actorRefs }

/-- Every row of one book's file in a text, in the order of its words. -/
def Corpus.readBook (c : Corpus) (code : String) : IO (Array Row) := do
  let path := (← c.dir) / s!"{code}.tsv"
  let lines := (← IO.FS.readFile path).splitOn "\n"
  let mut rows := #[]
  for line in lines.drop 1 do
    if line.isEmpty then continue
    match parseRow line with
    | some r => rows := rows.push r
    | none => throw <| IO.userError s!"Testimony.Corpus: cannot read {path}: {line}"
  return rows

/-- Where the verse English Bibles number `chapter:verse` stands in a text, by its
`versification.tsv`: the same verse if the file does not list it or the text has no such file,
another if it lists one, and an explanation if it lists the verse as not divided one to one. -/
def Corpus.locate (c : Corpus) (code : String) (chapter verse : Nat) :
    IO (Except String (Nat × Nat)) := do
  let path := (← c.dir) / "versification.tsv"
  unless ← path.pathExists do return .ok (chapter, verse)
  let key := s!"{code} {chapter}:{verse}"
  for line in ((← IO.FS.readFile path).splitOn "\n").drop 1 do
    match line.splitOn "\t" with
    | [english, theirs] =>
      if english != key then continue
      if theirs == "-" then
        return .error s!"the {c.name} does not hold English {chapter}:{verse} as one whole verse"
      let some cv := (theirs.splitOn " ")[1]?
        | throw <| IO.userError s!"Testimony.Corpus: cannot read {path}: {line}"
      match cv.splitOn ":" with
      | [ch, v] =>
        if let (some ch, some v) := (ch.toNat?, v.toNat?) then return .ok (ch, v)
      | _ => pure ()
      throw <| IO.userError s!"Testimony.Corpus: cannot read {path}: {line}"
    | _ => continue
  return .ok (chapter, verse)

/-- The words of the verse English Bibles number `chapter:verse`, in the book with MACULA code
`code` of a text, or why they cannot be read: the text has no file for the book, or numbers the
verse otherwise than one to one. -/
def Corpus.verseWords (c : Corpus) (code : String) (chapter verse : Nat) :
    IO (Except String (List Row)) := do
  unless ← ((← c.dir) / s!"{code}.tsv").pathExists do
    return .error s!"the corpus has no file for {code}"
  match ← c.locate code chapter verse with
  | .error why => return .error why
  | .ok (ch, v) =>
    let rows ← c.readBook code
    return .ok (rows.filter fun r => r.chapter == ch && r.verse == v).toList

/-- Whether a character is one of the Hebrew points and accents written above or below a letter
(U+0591 to U+05C7, leaving out the maqaf, the paseq, the sof pasuq and the nun hafukha, which
stand on the line). -/
def isHebrewMark (c : Char) : Bool :=
  let n := c.toNat
  0x0591 ≤ n && n ≤ 0x05C7 && n != 0x05BE && n != 0x05C0 && n != 0x05C3 && n != 0x05C6

/-- A word with the points and accents on each letter put in one order, by code point. The same
pointed word can be typed with its marks in either order, "בֵּ" as dagesh then tsere or tsere
then dagesh, and the Westminster Leningrad Codex does not keep to Unicode's order, so an anchor
is compared with a word in this form, and a word typed either way finds it. -/
def markOrder (w : String) : String := Id.run do
  let mut out : List Char := []
  let mut run : List Char := []
  for c in w.toList do
    if isHebrewMark c then run := c :: run
    else
      out := out ++ (run.toArray.qsort (· < ·)).toList
      run := []
      out := out ++ [c]
  return String.ofList (out ++ (run.toArray.qsort (· < ·)).toList)

/-- Why a part of a verse cannot be anchored in these words of the verse, or `none` if it can.
The verse has as many words as its last position; a Hebrew word of several rows counts once. -/
def partProblem (words : List Row) (first last : Nat) (anchor : String) : Option String :=
  let n := words.foldl (fun m r => max m r.position) 0
  if words.isEmpty then some "the verse has no words in the corpus"
  else if first == 0 || first > last then some s!"words {first} to {last} are not a span"
  else if last > n then some s!"the verse has {n} words, not {last}"
  else
    let span := words.filter fun r => first ≤ r.position && r.position ≤ last
    match (span.filter (markOrder ·.lemma == markOrder anchor)).length with
    | 1 => none
    | 0 => some s!"its anchor {anchor} is not among words {first} to {last}"
    | k => some s!"its anchor {anchor} occurs {k} times among words {first} to {last}"

/-- Write `def n : PassageRange`, part `letter` of the verse English Bibles number `c:v`, in
the book with MACULA code `code`, words `first` to `last`, after checking it against the text
that holds the book. See the module docstring. -/
def versePart (n : Ident) (code : String) (c v first last : Nat) (letter anchor : String) :
    CommandElabM Unit := do
  let some corpus := corpusOfCode? code
    | throwError "verse_part: no book with code {code}"
  let some (_, bookName) := corpus.books.find? (·.1 == code)
    | throwError "verse_part: no book with code {code}"
  let why? ← match ← liftIO (corpus.verseWords code c v) with
    | .error why => pure (some why)
    | .ok words => pure (partProblem words first last anchor)
  if let some why := why? then
    throwError "verse_part: {code} {c}:{v}{letter}: {why}"
  let book := mkCIdent (``Testimony.Book ++ bookName)
  elabCommand (← `(command|
    /-- Part of a verse, anchored in the Greek or Hebrew text by `verse_part`. -/
    def $n : Testimony.PassageRange :=
      .part { verse := ⟨$book, $(quote c), $(quote v)⟩, letter := $(quote letter)
            , first := $(quote first), last := $(quote last), anchor := $(quote anchor) }))

/-- `verse_part n from JHN 3 18 1 6 "a" "πιστεύω"` writes `def n`, John 3:18a: in order, the
book, chapter and verse as English Bibles number it, the positions of the part's first and last
words in the text, its letter, and the dictionary form of the word that anchors it. Here that is
the verse's first six words, anchored by its one πιστεύω. -/
syntax (name := versePartCmd) "verse_part " ident " from " ident num num num num str str : command

elab_rules : command
  | `(verse_part $n from $code $c $v $a $b $l $w) =>
    versePart n code.getId.toString c.getNat v.getNat a.getNat b.getNat l.getString w.getString

end Testimony.Corpus
