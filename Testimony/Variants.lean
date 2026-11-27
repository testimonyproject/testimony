import Testimony.Provenance
import Testimony.Logic.Dispute

/-!
# Testimony.Variants — places where the copies differ, and how sure the text is there

A Christian reading the King James Version finds at 1 John 5:7 "there are three that bear
record in heaven, the Father, the Word, and the Holy Ghost: and these three are one". A
Christian reading a modern translation finds no such sentence, because the two translations
rest on different Greek texts. So "1 John 5:7 says these three are one" is true of one text and
false of another, and an argument that rests on the words of a verse has to say which text it
read, and how sure anyone can be of the words there.

A place where the copies of a book differ is what textual critics call a **variation unit**:
a stretch of text, the readings found there, and the editions that print each. Who judges which
reading the author wrote is a reader like any other, cited, and rated by the library's one rule:
a judgement is `disputed` when a cited reader denies it. So the units here carry no scale of
their own. A unit records where it is, down to the word where it can; what kind of difference it
is; its readings; and every cited judgement on them, each saying which of the three questions it
answers (`TextQuestion`): what the copies say, what the author wrote, or what a church receives
as Scripture.

From there one rule carries the certainty of the text into an argument: **a claim cannot be
rated above the reading it rests on**. A claim resting on Mark 16:16 for what Mark wrote can be no
firmer than the judgement that Mark wrote 16:16 (`VariationUnit.rating`). `#check_readings`
(`Testimony.Checks.Readings`) holds every claim to it, and fails the build on a claim whose
words lie where the copies differ and which does not say which reading it takes there.

The judgements are cited, never computed: the library does not decide which reading is
original. It checks that the judgement is named, attributed, rated by the rule, and carried
into every claim that needs it. `docs/src/textual-criticism.md` sets out the design.
-/

namespace Testimony

/-- **What kind of difference a variation unit is.** Punctuation has a kind of its own because
it is the editors', not the copyists': the earliest manuscripts have almost none, so where a
comma falls in Romans 9:5 is an editor's reading of the sentence. -/
inductive VariantKind
  /-- Some copies have words the others lack. -/
  | addition
  /-- Some copies lack words the others have. -/
  | omission
  /-- One word or phrase for another. -/
  | substitution
  /-- The same words in another order. -/
  | transposition
  /-- The same letters, punctuated or divided differently by editors. -/
  | punctuation
  /-- A reading no manuscript has, proposed by a scholar. -/
  | conjecture
deriving Repr, DecidableEq

/-- How the kind is named to a reader. -/
def VariantKind.render : VariantKind → String
  | .addition => "words added"
  | .omission => "words left out"
  | .substitution => "one word for another"
  | .transposition => "words in another order"
  | .punctuation => "punctuation"
  | .conjecture => "a reading no manuscript has"

/-- **One reading at a place where the copies differ**: its label as a reader sees it, the
words as printed (empty where the reading is the words' absence), and the editions whose
printing of it the library has checked. -/
structure VariantReading where
  /-- The label a reader sees, and a claim names when it takes the reading: "with the
  heavenly witnesses". -/
  label : String
  /-- The words as an edition prints them, in Greek or Hebrew; empty for an omission. -/
  text : String := ""
  /-- The editions that print it, each checked against the edition's own text. -/
  editions : List TextualTradition := []
deriving Repr, DecidableEq

/-- **The letter the United Bible Societies' committee gives a decision**, as Bruce Metzger's
*Textual Commentary* prints it beside each reading the committee chose: {A} where the text is
certain, {B} almost certain, {C} where the committee had difficulty deciding, and {D} where it
had great difficulty. -/
inductive UbsGrade
  /-- The text is certain. -/
  | a
  /-- The text is almost certain. -/
  | b
  /-- The committee had difficulty deciding which reading to place in the text. -/
  | c
  /-- The committee had great difficulty arriving at a decision. -/
  | d
deriving Repr, DecidableEq

/-- How the grade is printed: "{C}". -/
def UbsGrade.render : UbsGrade → String
  | .a => "{A}"
  | .b => "{B}"
  | .c => "{C}"
  | .d => "{D}"

/-- **A cited judgement on a variation unit**: who prefers which reading, on which of the
three questions, at what confidence. The source names the reader; a judgement cited to
Scripture alone names no one and fails `#check_variation_units`. -/
structure VariantJudgement where
  /-- Which question the judgement answers. -/
  question : TextQuestion
  /-- The label of the reading it prefers. -/
  prefers : String
  /-- Who judges so, where, and how firmly. -/
  source : Source
  /-- The committee's letter, where the judgement is the United Bible Societies' committee's
  and Metzger prints one. -/
  grade : Option UbsGrade := none
deriving Repr, DecidableEq

/-- **A place where the copies differ.** `place` names it as a reader sees it and as a claim
names it when it takes a reading there; `span` is where it is, as narrowly as the corpus allows,
so that the build can tell whether a claim's words lie inside it. -/
structure VariationUnit where
  /-- Its name, as a reader sees it: "Mark 16:9–20, the longer ending". -/
  place : String
  /-- Where it is in the text. -/
  span : PassageRange
  /-- What kind of difference it is. -/
  kind : VariantKind
  /-- The readings found there. -/
  readings : List VariantReading
  /-- Every cited judgement on which reading is original, or attested, or received. -/
  judgements : List VariantJudgement
deriving Repr, DecidableEq

/-- The higher of two confidences. -/
def Confidence.max (a b : Confidence) : Confidence := if a.rank ≥ b.rank then a else b

/-- The lower of two confidences. -/
def Confidence.min (a b : Confidence) : Confidence := if a.rank ≤ b.rank then a else b

/-- Whether a committee that graded its own decision {C} or {D} said that it found the
decision hard. -/
def UbsGrade.hard : UbsGrade → Bool
  | .c | .d => true
  | _ => false

/-- **How firmly the library may hold a reading, on one question.** The firmest confidence of
any cited reader who prefers it, and no higher than `disputed` if any cited reader prefers
another reading on the same question, because that reader grants the copies and denies the
reading. No higher than `disputed`, too, where the committee that chose the reading graded its
choice {C} or {D}, because it says itself that it found the choice hard; that second cap is the
library's own proposal, not a rule of the committee's. Nothing, where no cited reader prefers it
at all: a claim cannot rest on a reading nobody holds. -/
def VariationUnit.rating (u : VariationUnit) (q : TextQuestion) (reading : String) :
    Option Confidence :=
  let js := u.judgements.filter (·.question == q)
  let pros := js.filter (·.prefers == reading)
  let dissent := js.any (·.prefers != reading)
  let hard := pros.any fun j => j.grade.any UbsGrade.hard
  match pros.map (·.source.confidence) with
  | [] => none
  | c :: cs =>
    let best := cs.foldl Confidence.max c
    some (if dissent || hard then best.min .disputed else best)

/-- The reading with this label, if the unit has one. -/
def VariationUnit.reading? (u : VariationUnit) (label : String) : Option VariantReading :=
  u.readings.find? (·.label == label)

/-- **What is wrong with a unit as data**, each as a sentence: fewer than two readings, two
readings with one label, a judgement preferring a reading the unit does not have, a judgement
cited to Scripture alone, or judgements on what the author wrote that all prefer one reading,
so that the other side is not heard. -/
def VariationUnit.problems (u : VariationUnit) : List String :=
  let labels := u.readings.map (·.label)
  let orig := (u.judgements.filter (·.question == .originality)).map (·.prefers)
  (if u.readings.length < 2 then [u.place ++ ": fewer than two readings"] else []) ++
  (if labels.eraseDups.length != labels.length then [u.place ++ ": two readings share a label"]
   else []) ++
  (u.judgements.filterMap fun j =>
    if labels.contains j.prefers then none
    else some (u.place ++ ": a judgement prefers \"" ++ j.prefers ++
      "\", which is not a reading")) ++
  (u.judgements.filterMap fun j =>
    if j.source.isScriptureOnly then
      some (u.place ++ ": a judgement preferring \"" ++ j.prefers ++ "\" names no reader")
    else none) ++
  (if orig.eraseDups.length < 2 then
    [u.place ++ ": the judgements on what the author wrote do not hear both sides"]
   else [])

end Testimony
