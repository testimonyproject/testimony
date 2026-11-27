import Testimony.Attr
import Testimony.Bib.Works
import Testimony.Corpus.Table
import Testimony.Variants
import Testimony.Checks.Readings

/-!
# Testimony.Variants.Units — seven places where the copies differ

Seven places where the Greek copies of the New Testament differ, each with the readings found
there and the cited judgement of readers on both sides. Three are long passages that some copies
have and others lack: the last twelve verses of Mark, the woman taken in adultery in John, and
the heavenly witnesses of 1 John 5:7–8. Two are one word or one phrase for another: what Jesus
says to the rich young man in Matthew 19:17, and whether the king's sceptre in Hebrews 1:8 is
"yours" or "his". One is a shorter form of Matthew 28:19 that no manuscript has but that
Eusebius of Caesarea quotes. And one is a comma, in Romans 9:5, which decides whether Paul calls
Christ God.

Each judgement is cited to the reader who makes it, at the place the library has read it, and
each unit hears both sides on what the author wrote, as `#check_variation_units` requires. The
library does not decide between them. It holds every claim resting on these words to the
reading it takes, and rates the claim no higher than that reading (`VariationUnit.rating`):
where cited readers disagree, no higher than `disputed`.

Bruce Metzger's *Textual Commentary on the Greek New Testament* gives the reasons of the
committee behind the United Bible Societies' edition, and grades most of its decisions from {A},
certain, to {D}, made with great difficulty. It is cited at six of the seven places, with its
grade where it prints one. Where the committee graded the reading it chose {C} or {D}, the library
holds that reading no higher than `disputed`, on the committee's own word that the choice was
hard; that cap is the library's proposal, not the committee's. Metzger has no note on Matthew
28:19, because the committee found no variation in the manuscripts there worth recording.
-/

namespace Testimony.Variants

open Testimony.Bib

/-- A textual critic's judgement, cited to a work at a place, at a rating. -/
private def critic (e : BibEntry) (l : Locus) (c : Confidence) : Source :=
  { primary := .work e l, tradition := .criticalScholarship, confidence := c }

/-- A judgement from a reader writing within a church's tradition. -/
private def churchman (e : BibEntry) (l : Locus) (t : Tradition) (c : Confidence) : Source :=
  { primary := .work e l, tradition := t, confidence := c }

/-- Robinson and Pierpont's edition, as a judgement on what the authors wrote: it prints the
Byzantine reading as the one "the canonical autograph transmission" most plausibly gave. -/
private def byzantinePriority : Source :=
  critic robinsonPierpont (.sectionRef "Preface") .plausible

/-! ### Mark 16:9–20 -/

/-- **Mark 16:9–20, the longer ending.** Codex Sinaiticus and Codex Vaticanus, the two oldest
complete Greek Bibles, end Mark at 16:8, "for they were afraid"; most later copies go on to 16:20,
with the risen Jesus appearing to Mary Magdalene and sending out the eleven. Westcott and Hort
judge the twelve verses later than Mark: "It manifestly cannot claim apostolic authority; but it
is doubtless founded on some tradition of the apostolic age." Bruce Metzger,
for the committee of the United Bible Societies' edition, finds that "the earliest ascertainable
form of the Gospel of Mark ended with 16.8"; it prints the verses in double brackets, "the work of
an author other than the evangelist", and gives them no grade. Robinson and Pierpont print them,
and Maurice Robinson argues for their authenticity in *Perspectives on the Ending of Mark*. -/
@[variation_unit]
def markLongerEnding : VariationUnit :=
  { place := "Mark 16:9–20, the longer ending"
  , span := .range ⟨.mark, 16, 9, 16, 20⟩
  , kind := .addition
  , readings :=
      [ { label := "with verses 9–20", editions := [.byzantine] }
      , { label := "ending at 16:8" } ]
  , judgements :=
      [ { question := .originality, prefers := "ending at 16:8"
        , source := critic westcottHortAppendix (.adLoc ⟨.mark, 16, 9⟩) .wellSupported }
      , { question := .originality, prefers := "ending at 16:8"
        , source := critic metzgerTextualCommentary (.pages 122 126) .wellSupported }
      , { question := .originality, prefers := "with verses 9–20", source := byzantinePriority }
      , { question := .originality, prefers := "with verses 9–20"
        , source := critic blackEndingOfMark .whole .plausible } ] }

/-! ### John 7:53–8:11 -/

/-- **John 7:53–8:11, the woman taken in adultery.** The oldest copies of John lack the passage,
and some later ones place it elsewhere. Westcott and Hort judge it no part of John: "it presents
serious differences from the diction of St John's Gospel, which, to say the least, strongly
suggest diversity of authorship." Metzger reports the committee
"unanimous that the pericope was originally no part of the Fourth Gospel", and prints it in double
brackets, without a grade. Robinson and Pierpont print it, and say in their Preface that
"the autograph form of the Pericope Adulterae" is more likely one of the two main lines of
its transmission within the Byzantine copies. -/
@[variation_unit]
def johnPericopeAdulterae : VariationUnit :=
  { place := "John 7:53–8:11, the woman taken in adultery"
  , span := .range ⟨.john, 7, 53, 8, 11⟩
  , kind := .addition
  , readings :=
      [ { label := "with the passage", editions := [.byzantine] }
      , { label := "without it" } ]
  , judgements :=
      [ { question := .originality, prefers := "without it"
        , source := critic westcottHortAppendix (.pages 82 88) .wellSupported }
      , { question := .originality, prefers := "without it"
        , source := critic metzgerTextualCommentary (.pages 219 222) .wellSupported }
      , { question := .originality, prefers := "with the passage"
        , source := critic robinsonPierpont (.sectionRef "Preface, The Pericope Adulterae")
            .plausible } ] }

/-! ### 1 John 5:7–8 -/

/-- **1 John 5:7–8, the heavenly witnesses.** In the critical editions John says that three
testify, the Spirit, the water and the blood. The Textus Receptus, the text the King James
Version translated, adds three witnesses in heaven, the Father, the Word and the Holy Spirit,
"and these three are one": words found in Latin manuscripts and in a handful of late Greek
ones. Robinson and Pierpont, who print the Byzantine text, leave them out with the critical
editions. Metzger grades their absence {A}: "That these words are spurious and have no right to
stand in the New Testament is certain", because no Greek Father quotes them, and they appear in
Greek first in a translation of the Acts of the Lateran Council of 1215. R. L. Dabney argued in
1871 for the probability of the received reading, his object being "to keep it an open
question". -/
@[variation_unit]
def firstJohnHeavenlyWitnesses : VariationUnit :=
  { place := "1 John 5:7–8, the heavenly witnesses"
  , span := .range ⟨.firstJohn, 5, 7, 5, 8⟩
  , kind := .addition
  , readings :=
      [ { label := "with the heavenly witnesses" }
      , { label := "without them", editions := [.byzantine] } ]
  , judgements :=
      [ { question := .originality, prefers := "without them", source := byzantinePriority }
      , { question := .originality, prefers := "without them"
        , source := critic metzgerTextualCommentary (.pages 715 717) .wellSupported
        , grade := some .a }
      , { question := .originality, prefers := "with the heavenly witnesses"
        , source := churchman dabneyDoctrinalReadings (.page 221) .reformedProtestant
            .disputed } ] }

/-! ### Matthew 19:17 -/

verse_part matthewNineteenSeventeenA from MAT 19 17 1 14 "a" "ἐρωτάω"

/-- **Matthew 19:17a, Jesus's answer to the rich young man.** The critical text has "Why do you
ask me about what is good? There is one who is good" (Τί με ἐρωτᾷς περὶ τοῦ ἀγαθοῦ; εἷς ἐστιν ὁ
ἀγαθός); the Byzantine text has "Why do you call me good? No one is good but one, God", as in
Mark 10:18 and Luke 18:19. Westcott and Hort judge the Byzantine words borrowed from those
Gospels, and Metzger grades the critical reading {B}: "scribal assimilation to Synoptic
parallels occurs frequently". J. W. Burgon called the critical reading "an absurd
fabrication". The verse's second half, "If you would enter life, keep the commandments", is the
same in both, and lies outside the unit. -/
@[variation_unit]
def matthewWhyCallMeGood : VariationUnit :=
  { place := "Matthew 19:17a, what is good"
  , span := matthewNineteenSeventeenA
  , kind := .substitution
  , readings :=
      [ { label := "why do you ask me about what is good"
        , text := "Τί με ἐρωτᾷς περὶ τοῦ ἀγαθοῦ; εἷς ἐστιν ὁ ἀγαθός", editions := [.sblgnt] }
      , { label := "why do you call me good"
        , text := "Τί με λέγεις ἀγαθόν; Οὐδεὶς ἀγαθός, εἰ μὴ εἷς, ὁ θεός"
        , editions := [.byzantine] } ]
  , judgements :=
      [ { question := .originality, prefers := "why do you ask me about what is good"
        , source := critic westcottHortAppendix (.pages 14 15) .wellSupported }
      , { question := .originality, prefers := "why do you ask me about what is good"
        , source := critic metzgerTextualCommentary (.page 49) .wellSupported, grade := some .b }
      , { question := .originality, prefers := "why do you call me good"
        , source := churchman burgonRevisionRevised (.page 139) .christianHistoricalGrammatical
            .wellSupported }
      , { question := .originality, prefers := "why do you call me good"
        , source := byzantinePriority } ] }

/-! ### Matthew 28:19 -/

verse_part matthewTwentyEightNineteenB from MAT 28 19 7 20 "b" "βαπτίζω"

/-- **Matthew 28:19b, the threefold name.** Every Greek manuscript and every version that has the
verse reads "baptizing them in the name of the Father and of the Son and of the Holy Spirit".
Eusebius of Caesarea, in many of his quotations of it, has instead "make disciples of all the
nations in my name". F. C. Conybeare argued in 1901 that Eusebius "seems to have found in the
codices of Caesarea" that shorter form, and that the text "was not yet authoritatively fixed by
the church". F. H. Chase answered him in 1905: "There is not the slightest reason for
questioning the integrity of the text in Matt. xxviii 19." -/
@[variation_unit]
def matthewThreefoldName : VariationUnit :=
  { place := "Matthew 28:19b, the threefold name"
  , span := matthewTwentyEightNineteenB
  , kind := .substitution
  , readings :=
      [ { label := "baptizing them in the threefold name"
        , text := "βαπτίζοντες αὐτοὺς εἰς τὸ ὄνομα τοῦ πατρὸς καὶ τοῦ υἱοῦ καὶ τοῦ ἁγίου πνεύματος"
        , editions := [.sblgnt, .byzantine] }
      , { label := "in my name, as Eusebius quotes it" } ]
  , judgements :=
      [ { question := .originality, prefers := "baptizing them in the threefold name"
        , source := critic chaseCommandToBaptize (.page 512) .wellSupported }
      , { question := .originality, prefers := "in my name, as Eusebius quotes it"
        , source := critic conybeareEusebianForm (.page 286) .plausible } ] }

/-! ### Romans 9:5 -/

verse_part romansNineFiveB from ROM 9 5 12 21 "b" "εἰμί"

/-- **Romans 9:5, the punctuation.** The letters are not in doubt; where the sentence stops is,
because the earliest manuscripts have almost no punctuation. With a comma after "according to the
flesh", Paul calls Christ "God over all, blessed forever"; with a full stop, the verse ends in a
blessing of God. Westcott and Hort, who agree on almost every reading, part here in one signed
note. Hort holds the full stop the one punctuation "which alone seems adequate to account for the
whole of the language employed"; Westcott answers that "the juxtaposition of ὁ χριστὸς κατὰ σάρκα
and ὁ ὢν κ.τ.λ. seems to make a change of subject improbable". Robinson and Pierpont print the
comma. The committee of the United Bible Societies' edition split as Westcott and Hort did, and
Metzger reports both sides without a grade: the majority chose the full stop, "particularly
since nowhere else in his genuine epistles does Paul ever designate ὁ Χριστός as θεός", and a
minority preferred the comma, for reasons that include Westcott's. -/
@[variation_unit]
def romansGodOverAll : VariationUnit :=
  { place := "Romans 9:5, the punctuation"
  , span := romansNineFiveB
  , kind := .punctuation
  , readings :=
      [ { label := "a comma: Christ is God over all", editions := [.byzantine] }
      , { label := "a full stop: a blessing of God" } ]
  , judgements :=
      [ { question := .originality, prefers := "a comma: Christ is God over all"
        , source := critic westcottHortAppendix (.page 110) .plausible }
      , { question := .originality, prefers := "a full stop: a blessing of God"
        , source := critic westcottHortAppendix (.pages 109 110) .plausible }
      , { question := .originality, prefers := "a full stop: a blessing of God"
        , source := critic metzgerTextualCommentary (.pages 520 522) .plausible }
      , { question := .originality, prefers := "a comma: Christ is God over all"
        , source := byzantinePriority } ] }

/-! ### Hebrews 1:8 -/

verse_part hebrewsOneEightB from HEB 1 8 15 23 "b" "βασιλεία"

/-- **Hebrews 1:8b, "your kingdom" or "his".** Most manuscripts read "the sceptre of your
kingdom" (σου); the oldest collection of Paul's letters, a papyrus from about AD 200, and the
codices Sinaiticus and Vaticanus read "his kingdom" (αὐτοῦ). Murray Harris, "with most textual
critics and the vast majority of commentators", takes σου as the earlier text. B. F. Westcott's
text reads αὐτοῦ, and he holds that reading to bear on the verse's first words, outside the unit:
"God is Thy throne", not "Your throne, O God", a rendering "required if we adopt the reading
αὐτοῦ for σου". The committee of the United Bible Societies' edition chose σου and graded it
{C}, a decision it found difficult: Metzger grants that αὐτοῦ "has early and good support",
and says a majority was "more impressed" by the spread of the copies for σου and by how hard
αὐτοῦ is to construe. So a claim that quotes "Your throne, O God" takes σου. -/
@[variation_unit]
def hebrewsYourKingdom : VariationUnit :=
  { place := "Hebrews 1:8b, your kingdom or his"
  , span := hebrewsOneEightB
  , kind := .substitution
  , readings :=
      [ { label := "your kingdom", text := "σου", editions := [.sblgnt, .byzantine] }
      , { label := "his kingdom", text := "αὐτοῦ" } ]
  , judgements :=
      [ { question := .originality, prefers := "your kingdom"
        , source := churchman harrisHebrewsTheos (.pages 136 138) .christianHistoricalGrammatical
            .wellSupported }
      , { question := .originality, prefers := "your kingdom"
        , source := critic metzgerTextualCommentary (.page 662) .plausible, grade := some .c }
      , { question := .originality, prefers := "his kingdom"
        , source := critic westcottHebrews (.pages 25 26) .plausible } ] }

/-! ### The readings the arguments take -/

verse_part matthewNineteenSeventeenB from MAT 19 17 15 24 "b" "τηρέω"

/-- The threefold name at Matthew 28:19b, as a claim takes it. -/
def threefoldName : ReadingTaken :=
  { place := matthewThreefoldName.place, reading := "baptizing them in the threefold name" }

/-- "Your kingdom" at Hebrews 1:8b, as a claim takes it. -/
def yourKingdom : ReadingTaken :=
  { place := hebrewsYourKingdom.place, reading := "your kingdom" }

/-- The comma at Romans 9:5, as a claim takes it. -/
def commaGodOverAll : ReadingTaken :=
  { place := romansGodOverAll.place, reading := "a comma: Christ is God over all" }

/-! ### What the check finds -/

/--
info: every place where the copies differ has two readings or more, each judgement cited to a
reader, and both sides heard on what the author wrote: 7 places
-/
#guard_msgs in
#check_variation_units

/-- Romans 9:5 with a comma is no firmer than `disputed`, on what Paul wrote, because Hort
prefers the full stop. -/
example : romansGodOverAll.rating .originality "a comma: Christ is God over all" =
    some .disputed := by decide

/-- "Your kingdom" at Hebrews 1:8 would be no firmer than `disputed` on the committee's {C} alone,
without Westcott on the other side: the library's cap for a decision the committee found hard. -/
example : { hebrewsYourKingdom with
      judgements := hebrewsYourKingdom.judgements.filter (·.prefers == "your kingdom") }.rating
      .originality "your kingdom" = some .disputed := by decide

/-- And without the committee's {C}, Harris alone would hold it `wellSupported`. -/
example : { hebrewsYourKingdom with
      judgements := hebrewsYourKingdom.judgements.filter
        (fun j => j.prefers == "your kingdom" && j.grade.isNone) }.rating
      .originality "your kingdom" = some .wellSupported := by decide

end Testimony.Variants
