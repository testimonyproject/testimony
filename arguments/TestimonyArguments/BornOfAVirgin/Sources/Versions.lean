import TestimonyArguments.BornOfAVirgin.Atoms

/-!
# TestimonyArguments.BornOfAVirgin.Sources.Versions — the Hebrew, the Syriac, and a reply

Three citations that say more than a label can: what the oldest Hebrew copy of
Isaiah reads at 7:14, what the Syriac Peshitta reads and what can be said of who
wrote it, and the reply to the lexical objection that leaves the word's sense
aside, with the fathers who made it. Cited here and dispatched from `cite` by
name, for the reason `Sources.Wegner` gives.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- `qumranConfirmsAlmah`. What the oldest Hebrew copy of Isaiah reads. 1QIsaᵃ,
column VI, line 29, has הנה העלמה הרה, as the Masoretic Text has it: read in
Abegg's transcription, from Ulrich and Flint's text. The verse has other
variants — יהוה for אדני, and וקרא, "and one shall call", for וקראת, "and she
shall call" — but none at the word. 4QIsaˡ, the one other Qumran copy of the
verse, preserves too little of it to witness either way. The scroll is dated by
radiocarbon to 335–122 BC at one standard deviation, and by its hand to 150–125
BC (Jull et al. 14, 19).

So the Hebrew that both sides read is the Hebrew read before Christ, and neither
Christians nor their opponents changed the word. That settles the text, not the
sense: the scroll has the same word, and what it means is the dispute.
`consensus`. -/
def qumranConfirmsAlmahCited : AtomMeta :=
  { label := "1QIsaᵃ, copied before Christ, reads הָעַלְמָה at Isaiah 7:14, as the Masoretic Text"
  , kind := .textual
  , source :=
      { primary := .scripture [verseIn .deadSeaScrolls isaiah7_14]
      , supporting :=
          [ .scripture [verseIn .masoretic isaiah7_14]
          , .work jullRadiocarbonScrolls (.pageList [14, 19]) ]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `peshittaRendersBtulta`. What the Syriac reads, and nothing about who wrote it
or why. Van der Kooij prints the reading (271). It is the Peshitta's only ܒܬܘܠܬܐ
for עַלְמָה: at Genesis 24:43, Exodus 2:8, Psalm 68:26 and Song 1:3 and 6:8 it
writes the cognate ܥܠܝܡܬܐ. Who made the version is disputed: Jews, for Bloch
("a work of Jewish hands outside of Palestine", 218 n.), or a Jewish Christian
who knew the Greek Isaiah, for van der Kooij (276–77, 287). Whether its 7:14 is
the translator's own reading, follows the Septuagint, or was changed later, Chen
finds impossible to settle: its agreement with the Greek "prevents us from
drawing any certain conclusion" (104–5). So it is cited for what it reads, and
not as a Jewish witness to "virgin". `consensus`, for the reading. -/
def peshittaRendersBtultaCited : AtomMeta :=
  { label := "The Syriac Peshitta renders Isaiah 7:14 with ܒܬܘܠܬܐ, 'virgin'"
  , kind := .textual
  , source :=
      { primary := .scripture [verseIn .peshitta isaiah7_14]
      , supporting :=
          [ .work vanDerKooijTextzeugen (.page 271)
          , .scripture peshittaAlmahElsewhere
          , .work blochAuthorshipPeshitta (.pages 218 219)
          , .work chenPeshittaIsaiah (.pages 104 105) ]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `maryFitsIsaianicDescription`. The referential reply: Mary was a young woman
of marriageable age and a virgin, so she answers Isaiah's description whatever
עַלְמָה denotes. France on Matthew 1:23, with Rico and Gentry.

The fathers gave the same answer to the Jewish "young woman", where they granted
it. Cyril of Alexandria: "κἂν εἰ λέγοιτο νεᾶνις ἡ παρθένος, οὐκ ἔξω κείσεται τοῦ
εἶναι παρθένος", even if the virgin were called a young woman, she will not cease
to be a virgin (PG 70, 204B). Cyril of Jerusalem: "though I assent to what they
say, even so I find the truth" (*Catechetical Lectures* 12.21). Eusebius: Christ's
entry by birth "as I and the Septuagint interpret it, of a virgin, or even
according to the current Jewish rendering, of a young woman" (*Dem. Ev.* VII.1).
Each, with Chrysostom (*Homilies on Matthew* 5), points to Deuteronomy 22, where
the betrothed νεᾶνις of 22:24–27 is the παῖς παρθένος of 22:23. -/
def maryFitsIsaianicDescriptionCited : AtomMeta :=
  { label := "Mary answers the description at Isaiah 7:14 whatever עַלְמָה denotes"
  , kind := .interpretive
  , source :=
      { franceOnMatthew with
        supporting :=
          [ .work ricoGentryInfantKing .whole
          , .work cyrilAlexandriaIsaiah (.adLoc isaiah7_14)
          , .work cyrilCatecheticalLectures (.sectionRef "12.21")
          , .work eusebiusDemonstratio (.sectionRef "VII.1")
          , .work chrysostomHomiliesMatthew (.sectionRef "5") ] } }

end TestimonyArguments.BornOfAVirgin
