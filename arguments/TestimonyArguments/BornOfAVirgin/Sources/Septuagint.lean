import TestimonyArguments.BornOfAVirgin.Atoms

/-!
# TestimonyArguments.BornOfAVirgin.Sources.Septuagint — the citations of the Septuagint dispute

The atoms of the dispute over what the Septuagint's παρθένος shows, cited here
and dispatched from `cite` by name: when and by whom the Greek Isaiah was made,
what its word for the woman of 7:14 meant, the evidence each side reads, and
what the translator can be taken to have meant.

They sit apart for the reason `Sources.Wegner` does: `cite` stays one total
function, and each value below is reached from exactly one of its cases.

Rico and Gentry are cited from their book; Bratcher, Walton, Wegner, Rhodea and
Postell from their articles; Davidson from his dictionary article; Meade from
his comment on his own blog post. Three readings are known to the library only
through the scholar who reports them, and each comment says so: Delling's and
Tsevat's, through Rhodea, and Gray's, through Bratcher.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- `lxxIsPreChristian`. Irenaeus makes the argument from it: Isaiah 7:14 "was
interpreted into Greek by the Jews themselves, much before the period of our
Lord's advent, that there might remain no suspicion that perchance the Jews,
complying with our humour, did put this interpretation upon these words"
(*Against Heresies* III.21.1). Justin presses Trypho with the version made by
"the seventy elders who were with Ptolemy" (*Dialogue* 71). The rival grants
the date: Wegner puts the translator "about 250–150 BC" (483). `consensus`. -/
def lxxIsPreChristianCited : AtomMeta :=
  { label := "The Greek Isaiah was translated by Jews before the coming of Christ"
  , kind := .historical
  , source :=
      { primary := .work irenaeusAgainstHeresies (.sectionRef "III.21.1")
      , supporting :=
          [ .work justinDialogue (.sectionRef "71")
          , .work wegnerVirginBirths (.page 483) ]
      , tradition := .christianTypological
      , confidence := .consensus } }

/-- `parthenosMeansVirgin`. Rico and Gentry: "There is no doubt that we should
take the term parthenos to mean 'virgin' whenever it appears in Semitic Koine
Greek: the example of Gn 34:1–3 is the exception that proves the rule" (21).
Postell reports that they "insist" on it (472 n. 45). Bratcher reaches the same
conclusion from the Septuagint's usage, without their argument: "parthenos
definitely means 'virgin' in the LXX; only very exceptionally (and, inexplicably,
in Gen. 34:3) is it used otherwise" (113).

`disputed`, because scholars this argument cites deny it. Wegner holds that in
the translator's day the word meant "a young woman of marriageable age", and
came to mean "virgin" only by the time of the New Testament (482–83). Walton:
"Therefore the LXX is not necessarily betraying an interpretation as virgin by
choosing this term" (293). Rhodea: "in the LXX, παρθένος need not refer to a
virgo intacta" (67). Meade: "παρθενος simply means young woman in this verse and
in other places in the LXX" (comment of 9 January 2013). -/
def parthenosMeansVirginCited : AtomMeta :=
  { label := "In the Greek of the Septuagint, παρθένος means a virgin"
  , kind := .linguistic
  , source :=
      { primary := .work ricoGentryInfantKing (.page 21)
      , supporting :=
          [ .work bratcherStudyOfIsaiah (.page 113)
          , .work postellIsaiahMessianic (.page 472) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- `parthenosMeantYoungWoman`. A claim about the word, not about any woman: in
the translator's Greek, παρθένος meant "young woman", and did not yet mean
"virgin". Wegner and Walton grant that by the New Testament it meant "virgin";
Meade and Davidson put that sense down to Christian use. The dispute is over the
translator's day, two or three centuries before Matthew.

Wegner: "In early Greek literature it appears to have had the meaning of 'a young
woman of marriageable age' (with or without the focus on virginity), but by NT
times this word developed the more technical meaning of 'virgin'" (482). So the
translator of Isaiah chose a word for a young woman, "an excellent word choice to
convey what the LXX's author meant", and "in the intervening time between the
LXX and the NT book of Matthew, the word παρθένος changed in meaning" (483).
Rhodea follows him, with an "apparently" (67). Meade holds it too: παρθένος
"simply means young woman in this verse and in other places in the LXX", and by
the time of Justin it had been "hijacked or used to mean 'chaste woman' only"
(comment of 9 January 2013). `disputed`: Rico and Gentry deny it, and so does
Bratcher. -/
def parthenosMeantYoungWomanCited : AtomMeta :=
  { label := "In the Septuagint's day, παρθένος meant 'young woman'; not yet 'virgin'"
  , kind := .linguistic
  , source :=
      { wegnerOnAlmah (.pages 482 483) .disputed with
        supporting :=
          [ .work rhodeaDidMatthewConceive (.page 67)
          , .work meadeAncientVersionsComment .whole ] } }

/-- `earlyGreekParthenosIsYoungWoman`. Wegner (482) and Rhodea (67) both state it
from BDAG 777: in early Greek, "a young woman of marriageable age, with or
without focus on virginity". Walton: the word "does not always mean 'virgin' in
classical Greek" (293). Bratcher, who holds the opposite of Wegner about the
Septuagint, grants it: "at first the word was used in a general sense of
'girl', 'young woman', without any specific connotation of virginity" (112).
`wellSupported`: Rico and Gentry grant the older usage too, and explain Genesis
34:3 by it, as an "almost anachronistic use of the word parthenos" that
"corresponds to the general tendency of language in the Septuagint version of
the Pentateuch", whose language is "more elevated and classical than the
language of the later texts" (18). What they deny is that the older usage is the
Septuagint's at large. -/
def earlyGreekParthenosIsYoungWomanCited : AtomMeta :=
  { label := "In early Greek, παρθένος meant a young woman, with or without virginity"
  , kind := .linguistic
  , source :=
      { wegnerOnAlmah (.page 482) .wellSupported with
        supporting :=
          [ .work rhodeaDidMatthewConceive (.page 67)
          , .work waltonWhatsInAName (.page 293)
          , .work bratcherStudyOfIsaiah (.page 112) ] } }

/-- `dinahIsAParthenosAfterShechem`. What the Greek reads: Shechem "lay with her
and humbled her" (34:2), and "he loved the παρθένος, and spoke to her according
to the mind of the παρθένος" (34:3), where the Hebrew has נַעֲרָה, "girl", both
times. Read from Rahlfs's text and the Masoretic. Wegner calls it "a good example of the meaning
of παρθένος in the LXX" (483), and Rhodea draws from it that "παρθένος need not
refer to a virgo intacta" (67). No one denies the reading. Rico and Gentry call
it "the exception that proves the rule" (21); Bratcher, an exception made
"inexplicably" (113). -/
def dinahIsAParthenosAfterShechemCited : AtomMeta :=
  { label := "The Septuagint calls Dinah a παρθένος after Shechem has lain with her"
  , kind := .textual
  , source :=
      { primary := .scripture dinahAfterShechem
      , supporting :=
          [ .work wegnerVirginBirths (.page 483)
          , .work rhodeaDidMatthewConceive (.page 67)
          , .work ricoGentryInfantKing (.pages 18 21)
          , .work bratcherStudyOfIsaiah (.page 113) ]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `isaiahUsesParthenosForBetulah`. What the two texts read, and nothing more:
read from Rahlfs's text of the Greek and from the Masoretic Text, the Greek
Isaiah has παρθένος at 23:4, 37:22, 47:1 and 62:5 besides 7:14, and in each the
Hebrew has בְּתוּלָה. The converse does not hold — at 23:12 the Greek has no
παρθένος for בְּתוּלַת — and the atom does not claim it. Scripture alone, and
legitimately so: the claim is about what a version reads. -/
def isaiahUsesParthenosForBetulahCited : AtomMeta :=
  { label := "Elsewhere in the Greek Isaiah, παρθένος renders בְּתוּלָה"
  , kind := .textual
  , source :=
      { primary := .scripture isaianicParthenoi
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `tryphoRejectsParthenos`. Trypho: "The Scripture has not, 'Behold, the virgin
shall conceive, and bear a son,' but, 'Behold, the young woman shall conceive'"
(*Dialogue* 67). Justin answers that Trypho's teachers "refuse to admit that the
interpretation made by the seventy elders who were with Ptolemy ... is a correct
one" (71). `consensus`: the record is Justin's, and no one doubts that the
objection was made. -/
def tryphoRejectsParthenosCited : AtomMeta :=
  { label := "Trypho rejects the Septuagint's 'the virgin' and reads 'the young woman'"
  , kind := .historical
  , source :=
      { primary := .work justinDialogue (.sectionRef "67")
      , supporting := [.work justinDialogue (.sectionRef "71")]
      , tradition := .christianTypological
      , confidence := .consensus } }

/-- `lxxReadsAVirgin`. What Irenaeus takes the Greek to say: "the token of the
Virgin" (*Against Heresies* III.21.1). Readers who doubt more grant this much.
Bratcher: "all the LXX means by parthenos is that a young woman, at that time
virgin, would in the normal way marry and bear a child" (115), which he calls
"the most reasonable explanation" (116). Delling, as Rhodea quotes him: the
Septuagint's usage "demands no more than the sense of a 'woman untouched by a
man up to the moment of the conception (of Immanuel)'" (Rhodea 67, citing TDNT
5.833 in n. 42).

`disputed`, because it stands or falls with the claim about παρθένος: on
Wegner's reading the translator wrote a word for a young woman, and said nothing
of her virginity. -/
def lxxReadsAVirginCited : AtomMeta :=
  { label := "Before Christ, a Jewish translator read the woman of Isaiah 7:14 as a virgin"
  , kind := .interpretive
  , source :=
      { primary := .work irenaeusAgainstHeresies (.sectionRef "III.21.1")
      , supporting :=
          [ .work bratcherStudyOfIsaiah (.pages 115 116)
          , .work rhodeaDidMatthewConceive (.page 67) ]
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- `lxxPutsTheConceptionInTheFuture`. What the Greek reads: ἰδοὺ ἡ παρθένος ἐν
γαστρὶ ἕξει, "look, the virgin shall be with child", a future, where Wegner reads
the Hebrew הָרָה as a present pregnancy. Rhodea notes it (67). `consensus`. -/
def lxxPutsTheConceptionInTheFutureCited : AtomMeta :=
  { label := "The Septuagint puts the conception in the future: 'she shall be with child'"
  , kind := .textual
  , source :=
      { primary := .scripture [verseIn .septuagint isaiah7_14]
      , supporting := [.work rhodeaDidMatthewConceive (.page 67)]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `lxxEnvisagesAVirginalConception`. Justin reads the elders' Greek so: "if He
also were to be begotten of sexual intercourse, like all other first-born sons,
why did God say that He would give a sign which is not common to all the
first-born sons?" (*Dialogue* 84). Delling, as Rhodea quotes him, allows that
"on the basis of LXX usage it is also possible that the translator of Is. 7:14
envisaged a non-sexual origin of the virgin's son" (67 n. 42).

`disputed`. Rhodea, quoting Tsevat: "The pregnancy lies in the future ...;
nothing indicates that the woman is also a virgin after the conception" (67);
"the evidence, then, does not demand a miraculous conception in either the
Hebrew or LXX" (68). Bratcher, quoting Gray: "all, then, that the Greek
translators need mean is that a woman now virgin will hereafter, in the ordinary
course of nature of losing her virginity, conceive" (115–16). -/
def lxxEnvisagesAVirginalConceptionCited : AtomMeta :=
  { label := "The Septuagint's translator meant that the woman conceives as a virgin"
  , kind := .interpretive
  , source :=
      { primary := .work justinDialogue (.sectionRef "84")
      , supporting := [.work rhodeaDidMatthewConceive (.page 67)]
      , tradition := .christianTypological
      , confidence := .disputed } }

end TestimonyArguments.BornOfAVirgin
