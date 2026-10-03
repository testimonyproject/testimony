import Testimony.Bib.Attr

/-!
# Testimony.Bib.Works — the catalogued bibliography

Every entry here was checked against a public catalogue (Open Library,
Crossref) before being committed. **No identifier in this file was written from
memory.** Where an identifier could not be tied to a specific printing, the
field is `none` and the entry renders as unverified — which is the rule working,
not failing. Nineteenth-century works and critical editions co-published under
several imprints are the usual cases.

The module ends with `derive_bib_registry`, which must stay in this file: the
attribute's local state is what the command reads.
-/

namespace Testimony.Bib

/-- R. T. France's NICNT commentary on Matthew. The standard evangelical
reference for Matthew's fulfilment formulae. -/
@[bib_entry] def franceMatthew : BibEntry := .book
  { core :=
      { key := "france-matthew-2007"
      , contributors := { authors := [.person "R. T." "France"] }
      , title := "The Gospel of Matthew"
      , year := some { value := 2007 }
      , identifiers := [.isbn "9780802825018"] }
  , publisher := "Wm. B. Eerdmans"
  , place := some "Grand Rapids"
  , series := some "New International Commentary on the New Testament" }

/-- Raymond Brown's study of the infancy narratives — the standard critical
treatment, and the source for the multiple-attestation premise in
`BornOfAVirgin`. -/
@[bib_entry] def brownBirthMessiah : BibEntry := .book
  { core :=
      { key := "brown-birth-messiah-1993"
      , contributors := { authors := [.person "Raymond E." "Brown"] }
      , title := "The Birth of the Messiah"
      , subtitle := some
          "A Commentary on the Infancy Narratives in the Gospels of Matthew and Luke"
      , year := some { value := 1993 }
      , identifiers := [.isbn "9780385472029"] }
  , publisher := "Doubleday"
  , place := some "New York"
  , edition := some "new updated edition"
  , series := some "Anchor Bible Reference Library" }

/-- Keil and Delitzsch on the Minor Prophets, in James Martin's translation.
Pre-ISBN; the Eerdmans reprint carries no identifier the catalogue could tie to
a printing, so this entry is deliberately unverified. -/
@[bib_entry] def keilDelitzschMinorProphets : BibEntry := .book
  { core :=
      { key := "keil-delitzsch-minor-prophets-1949"
      , contributors :=
          { authors := [.person "Carl Friedrich" "Keil", .person "Franz" "Delitzsch"]
          , translators := [.person "James" "Martin"] }
      , title := "Biblical Commentary on the Old Testament"
      , subtitle := some "The Twelve Minor Prophets"
      , year := some { value := 1949 }
      , note := some
          "Reprint of the T. & T. Clark translation; original German 1866–68." }
  , publisher := "Wm. B. Eerdmans"
  , place := some "Grand Rapids" }

/-- Motyer on Isaiah. The catalogue lists several 1993 printings across IVP's
UK and US imprints and could not tie an ISBN to one, so none is recorded. -/
@[bib_entry] def motyerIsaiah : BibEntry := .book
  { core :=
      { key := "motyer-isaiah-1993"
      , contributors := { authors := [.person "J. Alec" "Motyer"] }
      , title := "The Prophecy of Isaiah"
      , subtitle := some "An Introduction and Commentary"
      , year := some { value := 1993 } }
  , publisher := "InterVarsity Press" }

/-- Nestle-Aland 28, the standard critical edition of the Greek New Testament.
The ISBN recorded is the Hendrickson / German Bible Society co-publication, the
printing the catalogue could confirm. -/
@[bib_entry] def na28 : BibEntry := .criticalEdition
  { core :=
      { key := "na28-2012"
      , role := .text
      , contributors :=
          { editors := [.person "Barbara" "Aland", .person "Kurt" "Aland"
                       , .corporate "Institut für neutestamentliche Textforschung"] }
      , title := "Novum Testamentum Graece"
      , year := some { value := 2012 }
      , identifiers := [.isbn "9781619700321"]
      , note := some "ISBN is the Hendrickson / German Bible Society printing." }
  , publisher := "Deutsche Bibelgesellschaft"
  , place := some "Stuttgart"
  , edition := some "28th revised edition"
  , siglum := some "NA28" }

/-- The UBS Greek New Testament, 5th revised edition. No identifier could be
confirmed against a public catalogue, so this entry renders as unverified. -/
@[bib_entry] def ubs5 : BibEntry := .criticalEdition
  { core :=
      { key := "ubs5-2014"
      , role := .text
      , contributors := { editors := [.corporate "United Bible Societies"] }
      , title := "The Greek New Testament"
      , year := some { value := 2014 } }
  , publisher := "Deutsche Bibelgesellschaft"
  , place := some "Stuttgart"
  , edition := some "5th revised edition"
  , siglum := some "UBS5" }

/-- Biblia Hebraica Stuttgartensia, the standard critical edition of the Hebrew
Bible. Unverified for the same reason as `ubs5`. -/
@[bib_entry] def bhs : BibEntry := .criticalEdition
  { core :=
      { key := "bhs-1997"
      , role := .text
      , contributors := { editors := [.person "Karl" "Elliger", .person "Wilhelm" "Rudolph"] }
      , title := "Biblia Hebraica Stuttgartensia"
      , year := some { value := 1997 } }
  , publisher := "Deutsche Bibelgesellschaft"
  , place := some "Stuttgart"
  , edition := some "5th edition"
  , siglum := some "BHS" }

/-- Dunn's collected essays on the New Perspective. The source for the rival
reading of ἔργα νόμου as covenant boundary markers. -/
@[bib_entry] def dunnNewPerspective : BibEntry := .book
  { core :=
      { key := "dunn-new-perspective-2005"
      , contributors := { authors := [.person "James D. G." "Dunn"] }
      , title := "The New Perspective on Paul"
      , year := some { value := 2005 }
      , identifiers := [.isbn "9783161486777"] }
  , publisher := "Mohr Siebeck"
  , place := some "Tübingen"
  , series := some "Wissenschaftliche Untersuchungen zum Neuen Testament" }

/-- Wright's popular statement of the New Perspective's account of
justification. -/
@[bib_entry] def wrightWhatPaulSaid : BibEntry := .book
  { core :=
      { key := "wright-what-paul-said-1997"
      , contributors := { authors := [.person "N. T." "Wright"] }
      , title := "What Saint Paul Really Said"
      , subtitle := some "Was Paul of Tarsus the Real Founder of Christianity?"
      , year := some { value := 1997 }
      , identifiers := [.isbn "9780802844453"] }
  , publisher := "Wm. B. Eerdmans"
  , place := some "Grand Rapids" }

/-- Tanner's critical edition of the conciliar decrees — the citable text of
Trent's Decree on Justification, used by the `tridentine` package. -/
@[bib_entry] def tannerDecrees : BibEntry := .book
  { core :=
      { key := "tanner-decrees-1990"
      , role := .authority
      , contributors := { editors := [.person "Norman P." "Tanner"] }
      , title := "Decrees of the Ecumenical Councils"
      , year := some { value := 1990 }
      , identifiers := [.isbn "9780878404902"] }
  , publisher := "Georgetown University Press"
  , place := some "Washington, DC"
  , totalVolumes := some 2 }

/-- Calvin's Institutes in the McNeill/Battles edition, the standard English
citation text for the Reformed position. -/
@[bib_entry] def calvinInstitutes : BibEntry := .book
  { core :=
      { key := "calvin-institutes-1960"
      , role := .witness
      , contributors :=
          { authors := [.person "John" "Calvin"]
          , editors := [.person "John T." "McNeill"]
          , translators := [.person "Ford Lewis" "Battles"] }
      , title := "Institutes of the Christian Religion"
      , year := some { value := 1960 }
      , identifiers := [.isbn "9780664220211"]
      , note := some "Original Latin 1559." }
  , publisher := "Westminster Press"
  , place := some "Philadelphia"
  , series := some "Library of Christian Classics"
  , totalVolumes := some 2 }

/-- The machine-verified formalisation of Gödel's ontological argument — the
prior art this project's philosophical-theology roadmap builds on, and a
demonstration that theological arguments can be checked mechanically. -/
@[bib_entry] def benzmullerGodel : BibEntry := .inCollection
  { core :=
      { key := "benzmuller-godel-2014"
      , contributors :=
          { authors := [.person "Christoph" "Benzmüller"
                       , .person "Bruno" "Woltzenlogel Paleo"] }
      , title :=
          "Automating Gödel's Ontological Proof of God's Existence with " ++
          "Higher-order Automated Theorem Provers"
      , year := some { value := 2014 }
      , identifiers := [.doi "10.3233/978-1-61499-419-0-93"] }
  , containerTitle := "ECAI 2014"
  , publisher := "IOS Press"
  , edition := some "Frontiers in Artificial Intelligence and Applications 263" }

/-- The ETCBC's linguistic annotation of the Hebrew Bible. Layer 2 data is
sourced scholarly annotation, never formally certified fact, and must be cited
with a version to be reproducible. -/
@[bib_entry] def bhsaDataset : BibEntry := .dataset
  { core :=
      { key := "etcbc-bhsa"
      , role := .text
      , contributors :=
          { authors := [.corporate "Eep Talstra Centre for Bible and Computer"] }
      , title := "Biblia Hebraica Stuttgartensia (Amstelodamensis)"
      , identifiers := [.url "https://github.com/ETCBC/bhsa"] }
  , maintainer := some "ETCBC, Vrije Universiteit Amsterdam" }

/-- The Open Scriptures Hebrew Bible: a morphologically tagged, openly licensed
Hebrew text. -/
@[bib_entry] def oshbDataset : BibEntry := .dataset
  { core :=
      { key := "openscriptures-oshb"
      , role := .text
      , contributors := { authors := [.corporate "Open Scriptures"] }
      , title := "Open Scriptures Hebrew Bible"
      , identifiers := [.url "https://github.com/openscriptures/morphhb"] }
  , license := some "CC BY 4.0" }

/-- Marshall's NIGTC commentary on Luke — a commentary on the Greek text, which
is what an argument about the sense of σῴζω needs. -/
@[bib_entry] def marshallLuke : BibEntry := .book
  { core :=
      { key := "marshall-luke-1978"
      , contributors := { authors := [.person "I. Howard" "Marshall"] }
      , title := "The Gospel of Luke"
      , subtitle := some "A Commentary on the Greek Text"
      , year := some { value := 1978 }
      , identifiers := [.isbn "9780802835123"] }
  , publisher := "Wm. B. Eerdmans"
  , place := some "Grand Rapids"
  , series := some "New International Greek Testament Commentary" }

/-- Padilla's narrative-critical reading of Luke 7:36–50: the woman "loves much
because she has been forgiven much" (p. 54), and the passage is "about how
Jesus's love, demonstrated in forgiveness, is received by faith" (p. 55). The
modern exegete for the dominical strand's reading of 7:47 and 7:50. Checked
against the publisher's own copy of the issue; the journal registers no DOI. -/
@[bib_entry] def padillaNarrativeCriticism : BibEntry := .article
  { core :=
      { key := "padilla-narrative-criticism-2021"
      , contributors := { authors := [.person "Osvaldo" "Padilla"] }
      , title := "Narrative Criticism in the Gospels and Acts"
      , year := some { value := 2021 }
      , identifiers :=
          [ .url "https://www.sebts.edu/wp-content/uploads/2023/06/Issue-12.2.pdf"
                 (some "2026-09-24") ] }
  , journal := "Southeastern Theological Review"
  , volume := some "12"
  , issue := some "2"
  , pages := some (35, 55) }

/-- Calvin's commentary on John, for 6:29: faith is "a passive work, to which no
reward can be paid", which "bestows on man no other righteousness than that which
he receives from Christ". The Reformed reading of the Johannine strand's hinge.
The 1847 Calvin Translation Society edition, as scanned by the Internet Archive
and transcribed by the Christian Classics Ethereal Library. -/
@[bib_entry] def calvinJohn : BibEntry := .book
  { core :=
      { key := "calvin-commentary-john-1847"
      , role := .witness
      , contributors :=
          { authors := [.person "John" "Calvin"]
          , translators := [.person "William" "Pringle"] }
      , title := "Commentary on the Gospel According to John"
      , year := some { value := 1847 }
      , identifiers :=
          [ .url "https://archive.org/details/commentaryongosp01calvuoft"
                 (some "2026-09-24") ] }
  , publisher := "Calvin Translation Society"
  , place := some "Edinburgh"
  , volume := some "1" }

/-- Luther's 1535 lectures on Galatians, for his answer to faith formed by
charity: at 3:11, "to speak of formed or unformed faith, a sort of double faith,
is contrary to the Scriptures"; at 3:12, "if the law requires charity, charity
is part of the Law and not of faith". Cited as the Project Gutenberg text of
Theodore Graebner's translation, which is the text that was read; the printed
edition behind it is not verified in a catalogue. -/
@[bib_entry] def lutherGalatians : BibEntry := .book
  { core :=
      { key := "luther-commentary-galatians-1998"
      , role := .witness
      , contributors :=
          { authors := [.person "Martin" "Luther"]
          , translators := [.person "Theodore" "Graebner"] }
      , title := "Commentary on the Epistle to the Galatians"
      , year := some { value := 1998 }
      , identifiers :=
          [ .url "https://www.gutenberg.org/ebooks/1549" (some "2026-09-25") ]
      , note := some "Project Gutenberg eBook #1549; lectures of 1535." }
  , publisher := "Project Gutenberg" }

/-- Aquinas's lectures on John, for 6:29 (cap. 6, lect. 3, n. 901): Paul
distinguishes faith "only from external works", and to believe *in* God as one's
end "is proper to faith living through the love of charity". The rival reading
of the Johannine strand's hinge. Cited by the Marietti paragraph numbers, which
this translation keeps; the passage was read in Larcher's translation. -/
@[bib_entry] def aquinasJohn : BibEntry := .book
  { core :=
      { key := "aquinas-commentary-john-2012"
      , role := .witness
      , contributors :=
          { authors := [.single "Thomas Aquinas"]
          , editors := [.person "Daniel A." "Keating", .person "Matthew" "Levering"]
          , translators := [.person "Fabian R." "Larcher", .person "James A." "Weisheipl"] }
      , title := "Commentary on the Gospel of John, Chapters 6–12"
      , year := some { value := 2012 }
      , identifiers := [.isbn "9780813217741"] }
  , publisher := "Catholic University of America Press" }

/-- Moo on James, for the reading that James's target is a barren faith rather
than Paul's doctrine of justification. -/
@[bib_entry] def mooJames : BibEntry := .book
  { core :=
      { key := "moo-james-2000"
      , contributors := { authors := [.person "Douglas J." "Moo"] }
      , title := "The Letter of James"
      , year := some { value := 2000 }
      , identifiers := [.isbn "9780851119779"] }
  , publisher := "Apollos"
  , place := some "Leicester"
  , series := some "Pillar New Testament Commentary" }

/-- Johnson's Anchor Bible commentary on James — the standard critical
treatment, and a check on reading James too readily as Paul's ally. -/
@[bib_entry] def johnsonJames : BibEntry := .book
  { core :=
      { key := "johnson-james-1995"
      , contributors := { authors := [.person "Luke Timothy" "Johnson"] }
      , title := "The Letter of James"
      , subtitle := some "A New Translation with Introduction and Commentary"
      , year := some { value := 1995 }
      , identifiers := [.isbn "9780385413602"] }
  , publisher := "Doubleday"
  , place := some "New York"
  , series := some "Anchor Bible" }

/-- The Westminster Confession of Faith, for the Reformed formulation that
saving faith is never alone. Public catalogues list only print-on-demand
reprints, with no scholarly edition to tie an identifier to, so this entry
carries none. -/
@[bib_entry] def westminsterConfession : BibEntry := .book
  { core :=
      { key := "westminster-confession-1647"
      , role := .authority
      , contributors := { authors := [.corporate "Westminster Assembly"] }
      , title := "The Westminster Confession of Faith"
      , year := some { value := 1647 }
      , note := some "Cited by chapter and section; no critical edition catalogued." }
  , publisher := "Westminster Assembly" }

/-- Miravalle's short Mariology. The source for the two scriptural strands added
to `BornOfAVirgin`: Genesis 3:15 read as protoevangelium, and Micah 5:2--3 read
as naming a mother and no father. -/
@[bib_entry] def miravalleMeetMary : BibEntry := .book
  { core :=
      { key := "miravalle-meet-mary-2007"
      , contributors := { authors := [.person "Mark I." "Miravalle"] }
      , title := "Meet Mary"
      , subtitle := some "Getting to Know the Mother of God"
      , year := some { value := 2007 }
      , identifiers := [.isbn "9781933184326"] }
  , publisher := "Sophia Institute Press"
  , place := some "Manchester, NH" }

/-- Miravalle's survey of Marian doctrine, which collates the papal teaching the
`catholic` package in `BornOfAVirgin` appeals to. Open Library catalogues the
1993 Santa Barbara and 1997 printings, not the 2020 Goleta printing cited here;
the ISBN is carried across all three, so it is the catalogued identifier and the
year and place are not. -/
@[bib_entry] def miravalleIntroductionToMary : BibEntry := .book
  { core :=
      { key := "miravalle-introduction-mary-2020"
      , contributors := { authors := [.person "Mark I." "Miravalle"] }
      , title := "Introduction to Mary"
      , subtitle := some "The Heart of Marian Doctrine and Devotion"
      , year := some { value := 2020 }
      , identifiers := [.isbn "9781882972067"]
      , note := some
          ("ISBN is shared with the 1993 and 1997 Queenship printings; " ++
           "pagination cited is the 2020 printing's.") }
  , publisher := "Queenship Publishing"
  , place := some "Goleta, CA" }

/-- Berry's dictionary article on the virgin birth. Cited for two things the
`BornOfAVirgin` argument turns on: that how Isaiah 7:14 was fulfilled in Ahaz's
own day is itself an open question, and that the semantic range of עַלְמָה does
not exclude the sense "virgin". Open Library records the imprint as B&H
Publishing Group; the volume's title page reads Holman Bible Publishers. -/
@[bib_entry] def berryVirginBirth : BibEntry := .inCollection
  { core :=
      { key := "berry-virgin-birth-2003"
      , contributors := { authors := [.person "Everett" "Berry"] }
      , title := "Virgin, Virgin Birth"
      , year := some { value := 2003 }
      , identifiers := [.isbn "9780805428360"]
      , note := some "ISBN is the containing volume's." }
  , containerTitle := "Holman Illustrated Bible Dictionary"
  , containerEditors :=
      [ .person "Chad" "Brand", .person "Charles" "Draper"
      , .person "Archie" "England", .person "Trent C." "Butler" ]
  , publisher := "Holman Bible Publishers"
  , place := some "Nashville, TN"
  , pages := some (1653, 1654) }

/-- Chilton's translation of Targum Jonathan to Isaiah, with introduction,
apparatus and notes. The citable text for the Targum's rendering of עַלְמָה at
Isaiah 7:14 as עוּלֵימְתָא, "young woman" — evidence that tells against the
Christian reading, and is encoded in `BornOfAVirgin` as such. -/
@[bib_entry] def chiltonIsaiahTargum : BibEntry := .book
  { core :=
      { key := "chilton-isaiah-targum-1987"
      , role := .text
      , contributors := { authors := [.person "Bruce D." "Chilton"] }
      , title := "The Isaiah Targum"
      , subtitle := some "Introduction, Translation, Apparatus and Notes"
      , year := some { value := 1987 }
      , identifiers := [.isbn "9780894534805"] }
  , publisher := "Michael Glazier"
  , place := some "Wilmington, DE"
  , series := some "The Aramaic Bible"
  , seriesNumber := some "11" }

/-- Rico and Gentry's linguistic monograph on Isaiah 7:14 — the hardest
sustained case that עַלְמָה denotes a young virgin and that παρθένος means
virgin throughout Semitic Koine. Open Library records three 2020 Wipf & Stock
printings under ISBNs 9781498230162, 9781498230179 and 9781498230186 and does
not distinguish them, so no single identifier is recorded here. -/
@[bib_entry] def ricoGentryInfantKing : BibEntry := .book
  { core :=
      { key := "rico-gentry-infant-king-2020"
      , contributors :=
          { authors := [.person "Christophe" "Rico", .person "Peter J." "Gentry"] }
      , title := "The Mother of the Infant King, Isaiah 7:14"
      , subtitle := some
          "'almâ and parthenos in the World of the Bible — A Linguistic Perspective"
      , year := some { value := 2020 }
      , note := some
          ("Three 2020 printings catalogued (ISBNs 9781498230162, " ++
           "9781498230179, 9781498230186); none could be tied to a printing.") }
  , publisher := "Wipf & Stock"
  , place := some "Eugene, OR" }

/-- Wegner's article, the clearest evangelical statement of the case *against*
reading Isaiah 7:14 as a direct prediction of a virgin birth. Cited for the
rival lexical premise, so that the objection is stated by someone who holds it.
JETS registers no DOIs; the identifier is the publisher's own open PDF. -/
@[bib_entry] def wegnerVirginBirths : BibEntry := .article
  { core :=
      { key := "wegner-virgin-births-2011"
      , contributors := { authors := [.person "Paul D." "Wegner"] }
      , title := "How Many Virgin Births Are in the Bible? (Isaiah 7:14)"
      , subtitle := some "A Prophetic Pattern Approach"
      , year := some { value := 2011 }
      , identifiers :=
          [ .url ("https://etsjets.org/wp-content/uploads/2012/01/" ++
                  "files_JETS-PDFs_54_54-3_JETS_54-3_467-484_Wegner.pdf")
                 (some "2026-09-16") ] }
  , journal := "Journal of the Evangelical Theological Society"
  , volume := some "54"
  , issue := some "3"
  , pages := some (467, 484) }

/-- Postell's compositional case for reading Isaiah 7:14 messianically. The
source for the fourth strand in `BornOfAVirgin`, and for the parity argument
that Isaiah 9 and 11 sit on the same near-term Assyrian timeline as 7:14. JETS
registers no DOIs; the identifier is the society's own open PDF. -/
@[bib_entry] def postellIsaiahMessianic : BibEntry := .article
  { core :=
      { key := "postell-isaiah-messianic-2025"
      , contributors := { authors := [.person "Seth D." "Postell"] }
      , title := "Is Isaiah 7:14 Messianic?"
      , year := some { value := 2025 }
      , identifiers :=
          [ .url "https://etsjets.org/wp-content/uploads/JETS_68.3_465_Postell.pdf"
                 (some "2026-09-16") ] }
  , journal := "Journal of the Evangelical Theological Society"
  , volume := some "68"
  , issue := some "3"
  , pages := some (465, 493) }

/-- Motyer's article on the setting of Isaiah 7:14: the most direct answer in
the library to the near-term reading. The sign is a confirmation that follows
events rather than a persuader for Ahaz (120); Maher-shalal-hash-baz, not
Immanuel, carries the timetable of the Assyrian crisis (8:1–4), so Immanuel
belongs to the undated future (124); and 7:14 cannot be severed from 8:8, 8:10,
9:6–7 and 11:1–16, which make it "impossible to confine the Immanuel prophecy to
any long-forgotten 'fulfilment' in the time of Ahaz" (123). -/
@[bib_entry] def motyerContextContent : BibEntry := .article
  { core :=
      { key := "motyer-context-content-1970"
      , contributors := { authors := [.person "J. A." "Motyer"] }
      , title := "Context and Content in the Interpretation of Isaiah 7:14"
      , year := some { value := 1970 }
      , identifiers := [.doi "10.53751/001c.30667"] }
  , journal := "Tyndale Bulletin"
  , volume := some "21"
  , issue := some "1"
  , pages := some (118, 125) }

/-- Brown's assessment of the historicity of the virginal conception, which
argues both sides and ends in "an unresolved problem" (33). For historicity:
no parallel explains how early Christians came to the idea, "unless, of course,
that is what really took place" (30–32); the charge of illegitimacy, as old
perhaps as Christianity itself, which "those who deny the virginal conception
cannot escape the task of explaining" (32–33); and a tradition older than both
infancy narratives, since neither evangelist knew the other's (24). Against:
the high Christology of the narratives, the dubious historicity of the infancy
material, and the silence of the rest of the New Testament (24–29). -/
@[bib_entry] def brownProblemVirginalConception : BibEntry := .article
  { core :=
      { key := "brown-problem-virginal-conception-1972"
      , contributors := { authors := [.person "Raymond E." "Brown"] }
      , title := "The Problem of the Virginal Conception of Jesus"
      , year := some { value := 1972 }
      , identifiers := [.doi "10.1177/004056397203300101"] }
  , journal := "Theological Studies"
  , volume := some "33"
  , issue := some "1"
  , pages := some (3, 34) }

/-- Fitzmyer's reply: the New Testament data "are not unambiguous". Matthew's
annunciation asserts the virginal conception clearly and Luke's only possibly,
and whether either affirms it as historical fact or as a theologoumenon "is
still a vital question" (572–575). Cited as the contest over the historical
premise, not as support for it. -/
@[bib_entry] def fitzmyerVirginalConceptionNT : BibEntry := .article
  { core :=
      { key := "fitzmyer-virginal-conception-nt-1973"
      , contributors := { authors := [.person "Joseph A." "Fitzmyer"] }
      , title := "The Virginal Conception of Jesus in the New Testament"
      , year := some { value := 1973 }
      , identifiers := [.doi "10.1177/004056397303400401"] }
  , journal := "Theological Studies"
  , volume := some "34"
  , issue := some "4"
  , pages := some (541, 575) }

/-- Rhodea on Isaiah 7:14 and the virginal conception. Cited for three
observations: Luke's account of the virginal conception makes no explicit
reference to Isaiah 7:14, and whether it alludes to it is disputed — Davies and
Allison find an influence, Fitzmyer discusses and rejects the possible
allusions (71 n. 66); Luke's account is parallel to Matthew's and independent
of it (71); and both gospels trace Jesus' Davidic descent through Joseph, with
nothing in the New Testament placing Mary in David's line (74). -/
@[bib_entry] def rhodeaDidMatthewConceive : BibEntry := .article
  { core :=
      { key := "rhodea-did-matthew-conceive-2013"
      , contributors := { authors := [.person "Greg" "Rhodea"] }
      , title := "Did Matthew Conceive a Virgin?"
      , subtitle := some "Isaiah 7:14 and the Birth of Jesus"
      , year := some { value := 2013 }
      , identifiers :=
          [ .url ("https://etsjets.org/wp-content/uploads/2013/03/" ++
                  "files_JETS-PDFs_56_56-1_JETS_56-1_63-77_Rhodea.pdf")
                 (some "2026-09-23") ] }
  , journal := "Journal of the Evangelical Theological Society"
  , volume := some "56"
  , issue := some "1"
  , pages := some (63, 77) }

/-- Johnson on the birth-announcement type-scene. Cited for the classification
it reports: the "annunciation" form recognised by Neff, Conrad and Brown (*The
Birth of the Messiah*, 155–59) takes in Ishmael (Gen 16:11–12), Isaac, Samson,
John, Jesus — and Immanuel (Isa 7:14–17) itself (270 n. 6). -/
@[bib_entry] def johnsonSamsonTypeScene : BibEntry := .article
  { core :=
      { key := "johnson-samson-type-scene-2010"
      , contributors := { authors := [.person "Benjamin J. M." "Johnson"] }
      , title := "What Type of Son Is Samson?"
      , subtitle := some "Reading Judges 13 as a Biblical Type-Scene"
      , year := some { value := 2010 }
      , identifiers :=
          [ .url ("https://etsjets.org/wp-content/uploads/2010/10/" ++
                  "files_JETS-PDFs_53_53-2_JETS_53-2_269-286_Johnson.pdf")
                 (some "2026-09-23") ] }
  , journal := "Journal of the Evangelical Theological Society"
  , volume := some "53"
  , issue := some "2"
  , pages := some (269, 286) }

/-- The first half of Young's two-part study of Isaiah 7:14–16; it ends "(to be
concluded)", and its verdict on a near-term fulfilment belongs to the second
part, which is not cited here. What this part establishes: the imposed sign is
given in the plural, in contrast with the singular of the sign offered in 7:11
(112); הָרָה is a verbal adjective with present reference, not a participle
(115–117); the "behold" formula is the one used to announce the births to Hagar
and to Samson's mother (113–114); and Ugaritic *ǵlmt* is never used of a married
woman (120–124). Read from the Galaxie text, which preserves the journal's
pagination. -/
@[bib_entry] def youngImmanuelProphecy : BibEntry := .article
  { core :=
      { key := "young-immanuel-prophecy-1953"
      , contributors := { authors := [.person "Edward J." "Young"] }
      , title := "The Immanuel Prophecy: Isaiah 7:14–16"
      , year := some { value := 1953 }
      , identifiers :=
          [ .url "https://www.galaxie.com/article/wtj15-2-01" (some "2026-09-23") ]
      , note := some "First of two parts; the second appeared in a later issue." }
  , journal := "Westminster Theological Journal"
  , volume := some "15"
  , issue := some "2"
  , pages := some (97, 124) }

/-- Compton's case that Isaiah 7:14 is wholly messianic while 7:15–16 speaks to
Ahaz. It disputes both premises of the critical denial. The sign of 7:14 is
addressed to the house of David, with plural pronouns that rule out Ahaz, and so
"does not function as confirmation of Ahaz's promised deliverance" (12); every
near-term candidate fails, since neither Hezekiah's mother nor
Maher-shalal-hash-baz's was a virgin and Hezekiah was already born (9). And the
near-term part of the oracle measures time by the child's infancy, which "does
not depend on the fact that the child in view was not born for several
centuries" (14). -/
@[bib_entry] def comptonImmanuelProphecy : BibEntry := .article
  { core :=
      { key := "compton-immanuel-prophecy-2007"
      , contributors := { authors := [.person "R. Bruce" "Compton"] }
      , title := "The Immanuel Prophecy in Isaiah 7:14–16 and Its Use in Matthew 1:23"
      , subtitle := some "Harmonizing Historical Context and Single Meaning"
      , year := some { value := 2007 }
      , identifiers :=
          [ .url ("https://dbts.edu/wp-content/uploads/2025/10/" ++
                  "The-Immanueal-Prophecy-in-Isaiah-7-14-16-Compton.pdf")
                 (some "2026-09-23") ] }
  , journal := "Detroit Baptist Seminary Journal"
  , volume := some "12"
  , pages := some (3, 15) }

/-! ### Sola scriptura

Added for `Arguments.SolaScriptura`: the Protestant taxonomy and its critics,
the Orthodox doctrine of Tradition, the canon objection in its classical form,
and the sufficiency of Scripture. -/

/-- Mathison's account of sola scriptura, and the source of the Tradition 0 /
Tradition 1 / Tradition 2 taxonomy that separates the Protestant positions from
one another. The thesis cited is that the self-refutation and canon objections
tell against Tradition 0 and not against Tradition 1. -/
@[bib_entry] def mathisonShapeSolaScriptura : BibEntry := .book
  { core :=
      { key := "mathison-shape-sola-scriptura-2001"
      , contributors := { authors := [.person "Keith A." "Mathison"] }
      , title := "The Shape of Sola Scriptura"
      , year := some { value := 2001 }
      , identifiers := [.isbn "9781885767745"] }
  , publisher := "Canon Press"
  , place := some "Moscow, ID" }

/-- Oberman's essays, and the source of the Tradition I / Tradition II
distinction Mathison adapts. Geisler's review identifies this as the work
Mathison builds on. The identifier is the T. & T. Clark printing; Eerdmans
reissued the volume in 1992. -/
@[bib_entry] def obermanDawn : BibEntry := .book
  { core :=
      { key := "oberman-dawn-1986"
      , contributors := { authors := [.person "Heiko A." "Oberman"] }
      , title := "The Dawn of the Reformation"
      , subtitle := some "Essays in Late Medieval and Early Reformation Thought"
      , year := some { value := 1986 }
      , identifiers := [.isbn "9780567093714"]
      , note := some
          "Eerdmans reissued the volume in 1992 under ISBN 9780802806550." }
  , publisher := "T. & T. Clark"
  , place := some "Edinburgh" }

/-- Kruger on the canon's self-authentication. Cited for the parity reply to the
canon objection: that Rome's own model is self-authenticating too, so the
circularity charge does not discriminate between the positions. -/
@[bib_entry] def krugerCanonRevisited : BibEntry := .book
  { core :=
      { key := "kruger-canon-revisited-2012"
      , contributors := { authors := [.person "Michael J." "Kruger"] }
      , title := "Canon Revisited"
      , subtitle := some
          "Establishing the Origins and Authority of the New Testament Books"
      , year := some { value := 2012 }
      , identifiers := [.isbn "9781433505003"] }
  , publisher := "Crossway"
  , place := some "Wheaton, IL" }

/-- Florovsky on Scripture, Church and Tradition. The source for the Orthodox
premise that authority rests in the mind of the Church rather than in an
infallible interpretive organ — the premise that separates the Orthodox package
from the Roman one, which the seed encoding conflated. -/
@[bib_entry] def florovskyBibleChurchTradition : BibEntry := .book
  { core :=
      { key := "florovsky-bible-church-tradition-1972"
      , contributors := { authors := [.person "Georges" "Florovsky"] }
      , title := "Bible, Church, Tradition"
      , subtitle := some "An Eastern Orthodox View"
      , year := some { value := 1972 }
      , identifiers := [.isbn "9780913124024"]
      , note := some
          ("Volume 1 of the Collected Works. A later reprint " ++
           "(ISBN 9780473635909) paginates differently.") }
  , publisher := "Nordland Publishing Company"
  , place := some "Belmont, MA"
  , series := some "The Collected Works of Georges Florovsky"
  , seriesNumber := some "1" }

/-- Ware's standard introduction to Orthodoxy, cited with Florovsky for the
Orthodox doctrine of Tradition. The identifier is the revised Penguin edition;
the work was first published in 1963. -/
@[bib_entry] def wareOrthodoxChurch : BibEntry := .book
  { core :=
      { key := "ware-orthodox-church-1993"
      , contributors := { authors := [.person "Timothy" "Ware"] }
      , title := "The Orthodox Church"
      , year := some { value := 1993 }
      , identifiers := [.isbn "9780140146561"]
      , note := some "New edition; first published 1963." }
  , publisher := "Penguin Books"
  , place := some "London" }

/-- Newman's development thesis: the deposit is closed while understanding
develops, so later formulations make explicit what was implicit. The principal
rival to the Tradition 1 package, because it accepts that mechanism and rejects
the filter placed on it. -/
@[bib_entry] def newmanDevelopment : BibEntry := .book
  { core :=
      { key := "newman-development-1845"
      , role := .witness
      , contributors := { authors := [.person "John Henry" "Newman"] }
      , title := "An Essay on the Development of Christian Doctrine"
      , year := some { value := 1845 }
      , identifiers := [.isbn "9780268009212"]
      , note := some
          "ISBN is the University of Notre Dame Press edition." }
  , publisher := "James Toovey"
  , place := some "London" }

/-- Grudem's systematic theology, cited for the contemporary statement of
Scripture's sufficiency. `scriptureIsSufficient` carries the preservation claim
in `SolaScriptura` and needs support beyond a single section of Calvin. -/
@[bib_entry] def grudemSystematicTheology : BibEntry := .book
  { core :=
      { key := "grudem-systematic-theology-1994"
      , contributors := { authors := [.person "Wayne A." "Grudem"] }
      , title := "Systematic Theology"
      , subtitle := some "An Introduction to Biblical Doctrine"
      , year := some { value := 1994 }
      , identifiers := [.isbn "9780310286707"]
      , note := some
          ("A second edition appeared in 2020; section references here are " ++
           "the first edition's.") }
  , publisher := "Zondervan"
  , place := some "Grand Rapids" }

/-- Webster's dogmatic account of Scripture, the academic counterpart to Grudem
on sufficiency. -/
@[bib_entry] def websterHolyScripture : BibEntry := .book
  { core :=
      { key := "webster-holy-scripture-2003"
      , contributors := { authors := [.person "John" "Webster"] }
      , title := "Holy Scripture"
      , subtitle := some "A Dogmatic Sketch"
      , year := some { value := 2003 }
      , identifiers := [.isbn "9780521538466"] }
  , publisher := "Cambridge University Press"
  , place := some "Cambridge" }

/-- Bavinck's prolegomena, cited with Grudem and Webster for the Reformed
doctrine of Scripture. -/
@[bib_entry] def bavinckProlegomena : BibEntry := .book
  { core :=
      { key := "bavinck-prolegomena-2003"
      , contributors :=
          { authors := [.person "Herman" "Bavinck"]
          , editors := [.person "John" "Bolt"]
          , translators := [.person "John" "Vriend"] }
      , title := "Reformed Dogmatics"
      , subtitle := some "Volume 1: Prolegomena"
      , year := some { value := 2003 }
      , identifiers := [.isbn "9780801026553"] }
  , publisher := "Baker Academic"
  , place := some "Grand Rapids"
  , volume := some "1" }

/-- The Lutheran confessions in the Kolb–Wengert translation. Cited for Formula
of Concord Article X, which defines adiaphora as rites "neither commanded nor
forbidden in the Word of God" — the wider of the two statements this library
uses for the premise that practices need no scriptural warrant, Westminster I.6
being the narrower. Also cited for Melanchthon's *Apology of the Augsburg
Confession*, which reads Luke 7:47 ("she loved much") by 7:50 ("thy faith hath
saved thee") — the dominical strand of sola fide. -/
@[bib_entry] def bookOfConcord : BibEntry := .book
  { core :=
      { key := "kolb-wengert-book-of-concord-2000"
      , role := .authority
      , contributors :=
          { editors := [.person "Robert" "Kolb", .person "Timothy J." "Wengert"] }
      , title := "The Book of Concord"
      , subtitle := some "The Confessions of the Evangelical Lutheran Church"
      , year := some { value := 2000 }
      , identifiers := [.isbn "9780800627409"]
      , note := some "Open Library records the printing as January 2001." }
  , publisher := "Fortress Press"
  , place := some "Minneapolis" }

/-- Schaff's Nicene and Post-Nicene Fathers, first series volume 4: the standard
public-domain English text of Augustine's anti-Manichaean writings, and the
edition the canon objection is cited through — Augustine's *Contra epistolam
Manichaei* 5.6, by section reference into this volume. Reprinted under
many imprints, none of which the catalogue ties to an identifier, so the entry
records the electronic text instead. -/
@[bib_entry] def npnfAugustineManichaeans : BibEntry := .book
  { core :=
      { key := "npnf1-04-1887"
      , role := .witness
      , contributors := { editors := [.person "Philip" "Schaff"] }
      , title :=
          "A Select Library of the Nicene and Post-Nicene Fathers of the Christian Church"
      , subtitle := some
          ("First Series, Volume 4: St. Augustin — The Writings Against the " ++
           "Manichaeans and Against the Donatists")
      , year := some { value := 1887 }
      , identifiers :=
          [ .url "https://www.ccel.org/ccel/schaff/npnf104.html" (some "2026-09-17") ]
      , note := some
          ("Public domain; reprinted under several imprints, none tied to a " ++
           "catalogue identifier.") }
  , publisher := "Christian Literature Company"
  , place := some "Buffalo, NY" }

/-- Cross and Judisch's argument that Mathison's solo/sola distinction
collapses: under both, the individual retains ultimate interpretive authority,
exercised directly in the one case and indirectly in the other. The strongest
statement of the interpretive-authority regress, and the rival the final-arbiter
package has to answer. -/
@[bib_entry] def crossJudischInterpretiveAuthority : BibEntry := .webPage
  { core :=
      { key := "cross-judisch-interpretive-authority-2009"
      , contributors :=
          { authors := [.person "Bryan" "Cross", .person "Neal" "Judisch"] }
      , title :=
          "Solo Scriptura, Sola Scriptura, and the Question of Interpretive Authority"
      , year := some { value := 2009 }
      , identifiers :=
          [ .url ("https://www.calledtocommunion.com/2009/11/solo-scriptura-" ++
                  "sola-scriptura-and-the-question-of-interpretive-authority/")
                 (some "2026-09-17") ] }
  , site := some "Called to Communion" }

/-- Geisler's review of Mathison: the Protestant critique of Tradition I, from
the side Mathison files under Tradition 0. Two claims are cited. First, that
Tradition 0 is a caricature — tradition can be *informative* without being
*normative*, and the Anabaptist position appeals to the Spirit's witness and to
the community of believers rather than to "me alone". Second, that Tradition I
is viciously circular: the consensus of the Church is said to rest on the
clarity of Scripture, while the clear sense of Scripture is said to require the
consensus of the Church. -/
@[bib_entry] def geislerReviewMathison : BibEntry := .article
  { core :=
      { key := "geisler-review-mathison-2005"
      , contributors := { authors := [.person "Norman L." "Geisler"] }
      , title :=
          "A Critical Review of The Shape of Sola Scriptura by Keith Mathison"
      , year := some { value := 2005 }
      , identifiers :=
          [ .url "https://www.galaxie.com/article/caj04-1-04" (some "2026-09-17") ]
      , note := some
          ("Spring 2005 issue; a subscription is required for the full text.") }
  , journal := "Christian Apologetics Journal"
  , volume := some "4"
  , issue := some "1"
  , pages := some (117, 128) }

/-- Barrett on the authority of Scripture. Cited for the parity reply to the
charge of circularity: that any appeal to an ultimate authority is necessarily
circular, since there is no higher authority to appeal to. The same move Kruger
makes on the canon and Mathison on interpretive authority, made here about
perspicuity. -/
@[bib_entry] def barrettGodsWordAlone : BibEntry := .book
  { core :=
      { key := "barrett-gods-word-alone-2016"
      , contributors := { authors := [.person "Matthew" "Barrett"] }
      , title := "God's Word Alone"
      , subtitle := some "The Authority of Scripture"
      , year := some { value := 2016 }
      , identifiers := [.isbn "9780310515722"] }
  , publisher := "Zondervan"
  , place := some "Grand Rapids"
  , series := some "The Five Solas Series" }

/-- Allen and Swain on retrieval. Cited for the reply that the church's
tradition holds a ministerial authority that is itself *established by and
accountable to* Scripture — which, if it holds, denies that the creedal
consensus is a precondition of reading Scripture rather than a product of
it. -/
@[bib_entry] def allenSwainReformedCatholicity : BibEntry := .book
  { core :=
      { key := "allen-swain-reformed-catholicity-2015"
      , contributors :=
          { authors := [.person "Michael" "Allen", .person "Scott R." "Swain"] }
      , title := "Reformed Catholicity"
      , subtitle := some
          "The Promise of Retrieval for Theology and Biblical Interpretation"
      , year := some { value := 2015 }
      , identifiers := [.isbn "9780801049798"] }
  , publisher := "Baker Academic"
  , place := some "Grand Rapids" }

/-! ### Sola scriptura: Mark 7 and the tradition Trent receives -/

/-- Waterworth's English translation of Trent, the translation the library quotes
Trent in. Hanover College's public transcription gives its pages (Session IV at
17–21). Tanner remains the critical edition cited for Trent's text; this entry is
cited where Waterworth's wording is quoted. Published without an ISBN. -/
@[bib_entry] def waterworthTrent : BibEntry := .book
  { core :=
      { key := "waterworth-trent-1848"
      , role := .authority
      , contributors :=
          { authors := [.corporate "Council of Trent"]
          , translators := [.person "J." "Waterworth"] }
      , title := "The Canons and Decrees of the Sacred and Oecumenical Council of Trent"
      , year := some { value := 1848 }
      , note := some "Published without an ISBN; a public transcription is at Hanover College." }
  , publisher := "C. Dolman"
  , place := some "London" }

/-- Geiselmann's argument that Trent, replacing its draft's "partim … partim"
with "et", did not define Scripture and tradition as two partial sources, and
left Scripture's material sufficiency open. The Catholic reader who grants Trent
Session IV and denies that it canonised two coordinate sources. Catalogued
without an ISBN; its contents were not seen, so it is cited whole. -/
@[bib_entry] def geiselmannMeaningOfTradition : BibEntry := .book
  { core :=
      { key := "geiselmann-meaning-of-tradition-1966"
      , contributors :=
          { authors := [.person "Josef Rupert" "Geiselmann"]
          , translators := [.person "W. J." "O'Hara"] }
      , title := "The Meaning of Tradition"
      , year := some { value := 1966 }
      , note := some "Catalogued without an ISBN." }
  , publisher := "Herder and Herder"
  , place := some "New York"
  , series := some "Quaestiones Disputatae"
  , seriesNumber := some "15" }

/-- Congar on Tradition and the traditions: the Catholic distinction between the
apostolic Tradition and the human traditions of local churches, and his judgement
that Trent did not settle whether Scripture is materially sufficient. Cited whole;
its contents were not seen. -/
@[bib_entry] def congarTraditionAndTraditions : BibEntry := .book
  { core :=
      { key := "congar-tradition-and-traditions-1966"
      , contributors :=
          { authors := [.person "Yves" "Congar"]
          , translators := [.person "Michael" "Naseby", .person "Thomas" "Rainborough"] }
      , title := "Tradition and Traditions"
      , subtitle := some "An Historical and a Theological Essay"
      , year := some { value := 1966 }
      , note := some
          ("The 1998 Basilica Press reprint carries ISBN 9780536001733; this " ++
           "first English edition was catalogued without one.") }
  , publisher := "Burns & Oates"
  , place := some "London" }

/-- The *Catechism of the Catholic Church*, cited for §83: the apostolic
Tradition distinguished from the "theological, disciplinary, liturgical or
devotional traditions" of local churches, which "can be retained, modified or
even abandoned". Rome's own answer to the reading of its Tradition as
commandments of men. -/
@[bib_entry] def catechismCatholicChurch : BibEntry := .book
  { core :=
      { key := "catholic-church-catechism-2000"
      , role := .authority
      , contributors := { authors := [.corporate "Catholic Church"] }
      , title := "Catechism of the Catholic Church"
      , year := some { value := 2000 }
      , identifiers := [.isbn "9781574551105"] }
  , publisher := "USCCB Publishing"
  , edition := some "2nd edition" }

/-- Calvin's *Harmony of the Evangelists*, volume 1, in Pringle's translation
for the Calvin Translation Society: cited for Matthew 7:21–23, where "to do the
will of the Father" includes "to believe in Christ" (367–368). Published without
an ISBN; the public scan is given. -/
@[bib_entry] def calvinHarmony1 : BibEntry := .book
  { core :=
      { key := "calvin-harmony-evangelists-1845"
      , role := .witness
      , contributors :=
          { authors := [.person "John" "Calvin"]
          , translators := [.person "William" "Pringle"] }
      , title := "Commentary on a Harmony of the Evangelists, Matthew, Mark, and Luke"
      , year := some { value := 1845 }
      , identifiers :=
          [ .url "https://archive.org/details/harmonyrevelatio01calvuoft"
                 (some "2026-09-27") ] }
  , publisher := "Calvin Translation Society"
  , place := some "Edinburgh"
  , volume := some "1"
  , totalVolumes := some 3 }

/-- Volume 2 of the same: cited for Luke 18:14, where "justified" means "to stand
before God as if we were righteous" (206–207), and for Matthew 19:17, which
Calvin reads as Christ answering on the law's own terms (393–394). -/
@[bib_entry] def calvinHarmony2 : BibEntry := .book
  { core :=
      { key := "calvin-harmony-evangelists-2-1845"
      , role := .witness
      , contributors :=
          { authors := [.person "John" "Calvin"]
          , translators := [.person "William" "Pringle"] }
      , title := "Commentary on a Harmony of the Evangelists, Matthew, Mark, and Luke"
      , year := some { value := 1845 }
      , identifiers :=
          [ .url "https://archive.org/details/harmonyrevelatio02calvuoft"
                 (some "2026-09-27") ] }
  , publisher := "Calvin Translation Society"
  , place := some "Edinburgh"
  , volume := some "2"
  , totalVolumes := some 3 }

/-- John Paul II's encyclical on the Church's moral teaching, which opens with the
rich young man (Matthew 19:16–22) and reads "keep the commandments" as the path
of life: "God's commandments show man the path of life and they lead to it"
(§12). The Catholic reading of Matthew 19:17, cited by section. -/
@[bib_entry] def veritatisSplendor : BibEntry := .book
  { core :=
      { key := "john-paul-ii-veritatis-splendor-1993"
      , role := .authority
      , contributors := { authors := [.person "John Paul" "II"] }
      , title := "The Splendor of Truth"
      , subtitle := some "Veritatis Splendor"
      , year := some { value := 1993 }
      , identifiers := [.isbn "9781555866792"] }
  , publisher := "United States Catholic Conference"
  , place := some "Washington, DC" }

/-! ### Baptism: water, the Spirit, and fire -/

/-- Oliver's survey of the readings of "water" in John 3:5 — baptism, the Ezekiel
36 cleansing, a single birth from above — and his own case for the waters of
natural birth. Open access; cited by article number. -/
@[bib_entry] def oliverWaterJohn : BibEntry := .article
  { core :=
      { key := "oliver-water-john-2022"
      , contributors := { authors := [.person "Willem H." "Oliver"] }
      , title := "The water in John 3:5"
      , year := some { value := 2022 }
      , identifiers := [.doi "10.4102/ve.v43i1.2570"]
      , note := some "Article a2570." }
  , journal := "Verbum et Ecclesia"
  , volume := some "43"
  , issue := some "1" }

/-- Carson on John 3:5: "water and the Spirit" is one birth, and the passage that
brings water and Spirit together in a promise of new beginning is Ezekiel
36:25–27, "spectacular cleansing symbolized by water that washes away all
impurities". The Ezekiel reading, from someone who holds it. -/
@[bib_entry] def carsonBornOfWater : BibEntry := .webPage
  { core :=
      { key := "carson-born-of-water-2019"
      , contributors := { authors := [.person "D. A." "Carson"] }
      , title := "What Does \"Born of Water and the Spirit\" Mean in John 3:5?"
      , year := some { value := 2019 }
      , identifiers :=
          [ .url "https://www.thegospelcoalition.org/article/born-water-spirit-mean/"
                 (some "2026-09-27") ] }
  , site := some "The Gospel Coalition" }

/-- Calvin on Acts, in Beveridge's edition of Fetherstone's translation. Cited
for Acts 10:47: the Spirit given before the water "showeth that the Spirit is
not included in baptism" (454). Published without an ISBN. -/
@[bib_entry] def calvinActs1 : BibEntry := .book
  { core :=
      { key := "calvin-commentary-acts-1844"
      , role := .witness
      , contributors :=
          { authors := [.person "John" "Calvin"]
          , editors := [.person "Henry" "Beveridge"]
          , translators := [.person "Christopher" "Fetherstone"] }
      , title := "Commentary upon the Acts of the Apostles"
      , year := some { value := 1844 }
      , identifiers :=
          [ .url "https://archive.org/details/commentaryuponth01calvuoft"
                 (some "2026-09-27") ] }
  , publisher := "Calvin Translation Society"
  , place := some "Edinburgh"
  , volume := some "1" }

/-- Aquinas's *Summa*, in the English Dominicans' second edition, the text New
Advent reproduces. Cited by question and article: on the thief and the baptisms
of blood and desire (III q.66 a.11), on when the obligation of baptism began
(III q.66 a.2), and on Cornelius receiving grace before baptism "through their
faith in Christ and their desire for Baptism" (III q.69 a.4 ad 2). -/
@[bib_entry] def aquinasSumma : BibEntry := .book
  { core :=
      { key := "aquinas-summa-1920"
      , role := .witness
      , contributors :=
          { authors := [.person "Thomas" "Aquinas"]
          , translators := [.corporate "Fathers of the English Dominican Province"] }
      , title := "The Summa Theologica"
      , year := some { value := 1920 }
      , identifiers := [.url "https://www.newadvent.org/summa/" (some "2026-09-27")]
      , note := some "Second and revised edition; no ISBN attaches to it." }
  , publisher := "Burns Oates & Washbourne"
  , place := some "London" }

/-- Cyril of Jerusalem and Gregory Nazianzen, cited for two readings of the
"fire" of Matthew 3:11: Cyril's Pentecost ("because the descent of the Holy
Ghost was in fiery tongues", *Catechetical Lecture* 17.8) and Gregory's
consuming of the chaff (*Oration* 39.15). -/
@[bib_entry] def npnfCyrilGregory : BibEntry := .book
  { core :=
      { key := "npnf2-07-1894"
      , role := .witness
      , contributors := { editors := [.person "Philip" "Schaff", .person "Henry" "Wace"] }
      , title := "A Select Library of Nicene and Post-Nicene Fathers of the Christian Church"
      , subtitle := some "Second Series, Volume 7: S. Cyril of Jerusalem, S. Gregory Nazianzen"
      , year := some { value := 1894 }
      , identifiers := [.url "https://www.ccel.org/ccel/schaff/npnf207.html" (some "2026-09-27")]
      , note := some "Public domain; CCEL dates its printing 1893." }
  , publisher := "Christian Literature Company"
  , place := some "New York" }

/-- Feeney's *Bread of Life*, the reading of Trent on which water baptism is
necessary for salvation though desire may justify: "It is now: Baptism of Water,
or damnation!" Catalogued without an ISBN; cited whole. -/
@[bib_entry] def feeneyBreadOfLife : BibEntry := .book
  { core :=
      { key := "feeney-bread-of-life-1952"
      , role := .witness
      , contributors := { authors := [.person "Leonard" "Feeney"] }
      , title := "Bread of Life"
      , year := some { value := 1952 }
      , note := some "Catalogued without an ISBN." }
  , publisher := "St. Benedict Center"
  , place := some "Cambridge, MA" }

/-! ### Spirit baptism -/

/-- Dunn's re-examination of Spirit baptism, the standard scholarly case that it
is part of conversion-initiation: "the chief element in conversion-initiation
so that only those who had received the Spirit could be called Christians".
Cited whole; the book is not public, and the catalogue does not confirm the
1970 imprint. -/
@[bib_entry] def dunnBaptismInTheHolySpirit : BibEntry := .book
  { core :=
      { key := "dunn-baptism-holy-spirit-1970"
      , contributors := { authors := [.person "James D. G." "Dunn"] }
      , title := "Baptism in the Holy Spirit"
      , subtitle := some
          ("A Re-examination of the New Testament Teaching on the Gift of the Spirit " ++
           "in Relation to Pentecostalism Today")
      , year := some { value := 1970 }
      , identifiers := [.isbn "9780334000693"] }
  , publisher := "SCM Press"
  , place := some "London" }

/-- Stott's pastoral case that Spirit baptism is given to every believer at
conversion, and that God's purpose is to be sought in Scripture's didactic
rather than its historical parts. Cited whole. -/
@[bib_entry] def stottBaptismAndFullness : BibEntry := .book
  { core :=
      { key := "stott-baptism-fullness-1975"
      , contributors := { authors := [.person "John R. W." "Stott"] }
      , title := "Baptism and Fullness"
      , subtitle := some "The Work of the Holy Spirit Today"
      , year := some { value := 1975 }
      , identifiers := [.isbn "9780851103877"] }
  , publisher := "Inter-Varsity Press"
  , place := some "London"
  , edition := some "2nd edition" }

/-- Stronstad's case that Luke writes as a theologian whose narratives teach, and
that the gift of the Spirit in Luke-Acts is charismatic, for service. Cited
whole. -/
@[bib_entry] def stronstadCharismaticTheology : BibEntry := .book
  { core :=
      { key := "stronstad-charismatic-theology-1984"
      , contributors := { authors := [.person "Roger" "Stronstad"] }
      , title := "The Charismatic Theology of St. Luke"
      , year := some { value := 1984 }
      , identifiers := [.isbn "9780913573112"] }
  , publisher := "Hendrickson"
  , place := some "Peabody, MA" }

/-- Menzies' monograph on the Spirit in Luke-Acts: the Pentecostal gift as
prophetic empowerment. Menzies dates it 1994; the catalogue, May 1995. -/
@[bib_entry] def menziesEmpoweredForWitness : BibEntry := .book
  { core :=
      { key := "menzies-empowered-witness-1994"
      , contributors := { authors := [.person "Robert P." "Menzies"] }
      , title := "Empowered for Witness"
      , subtitle := some "The Spirit in Luke-Acts"
      , year := some { value := 1994 }
      , identifiers := [.isbn "9781850757214"]
      , note := some "The catalogue gives May 1995 for this printing." }
  , publisher := "Sheffield Academic Press"
  , place := some "Sheffield"
  , series := some "Journal of Pentecostal Theology Supplement Series"
  , seriesNumber := some "6" }

/-- Menzies' short statement of the Pentecostal reading: Luke's baptism in the
Spirit "must be distinguished from the gift of the Spirit – and even the baptism
in the Spirit in 1 Corinthians 12:13 – that Paul so clearly associates with
conversion and regeneration". -/
@[bib_entry] def menziesLukesUnderstanding : BibEntry := .webPage
  { core :=
      { key := "menzies-lukes-understanding-2017"
      , contributors := { authors := [.person "Robert" "Menzies"] }
      , title := "Luke's Understanding of the Baptism in the Holy Spirit"
      , subtitle := some "A Pentecostal Perspective"
      , year := some { value := 2017 }
      , identifiers := [.url "https://pentecost.asia/articles/863/" (some "2026-09-27")] }
  , site := some "Pentecost Asia" }

/-- The Assemblies of God position paper, adopted by the General Presbytery in
August 2010. It reads 1 Corinthians 12:13 as baptism *by* the Spirit into the
body, "the Holy Spirit is the instrument", and summarises: "At conversion, the
Spirit baptizes into Christ/the body of Christ; in a subsequent and distinct
experience, Christ will baptize in the Holy Spirit." Its appendix reprints
Fundamental Truths 7–8. -/
@[bib_entry] def agBaptismPositionPaper : BibEntry := .webPage
  { core :=
      { key := "assemblies-of-god-baptism-holy-spirit-2010"
      , role := .authority
      , contributors := { authors := [.corporate "General Presbytery of the Assemblies of God"] }
      , title := "Baptism in the Holy Spirit"
      , subtitle := some "Position Paper"
      , year := some { value := 2010 }
      , identifiers :=
          [ .url ("https://ag.org/-/media/AGORG/Beliefs/Position-Papers/" ++
                  "PP_Baptism_In_the_Holy_Spirit_GPM_08_2010.pdf") (some "2026-09-27") ] }
  , site := some "Assemblies of God" }

/-- Wesley's letters in Telford's standard edition. Cited for the letter to Joseph
Benson of 28 December 1770: the "second change" is real, but to call it
"receiving the Holy Ghost" is "not scriptural and not quite proper; for they all
'received the Holy Ghost' when they were justified". Published without an
ISBN. -/
@[bib_entry] def wesleyLetters : BibEntry := .book
  { core :=
      { key := "wesley-letters-1931"
      , role := .witness
      , contributors :=
          { authors := [.person "John" "Wesley"], editors := [.person "John" "Telford"] }
      , title := "The Letters of the Rev. John Wesley"
      , year := some { value := 1931 }
      , identifiers :=
          [ .url ("https://wesley.nnu.edu/john-wesley/the-letters-of-john-wesley/" ++
                  "wesleys-letters-1770/") (some "2026-09-27") ]
      , note := some "Standard edition; the 1770 letters are in volume 5." }
  , publisher := "Epworth Press"
  , place := some "London" }

/-- The Church of the Nazarene's *Manual*, 2023. Its Articles of Faith, X ¶10,
hold the holiness reading as the denomination's creed: entire sanctification "is
wrought by the baptism with or infilling of the Holy Spirit". Read in the
published PDF (pp. 30–31); the ISBNs printed in it are not in the catalogue, and
the one that is cannot be tied to this printing, so none is given. -/
@[bib_entry] def nazareneManual : BibEntry := .book
  { core :=
      { key := "church-of-the-nazarene-manual-2023"
      , role := .authority
      , contributors := { authors := [.corporate "Church of the Nazarene"] }
      , title := "Manual 2023"
      , subtitle := some "History, Constitution, Government, Sacraments and Rituals"
      , year := some { value := 2023 }
      , note := some "Published by the authority of the 30th General Assembly, 2023." }
  , publisher := "Nazarene Publishing House"
  , place := some "Kansas City, MO" }

/-- The Nazarene Theological Seminary faculty on Article X: entire sanctification
kept, but "our scholars no longer view the American holiness hermeneutic of the
'baptism of the Spirit' as exegetically tenable". -/
@[bib_entry] def nazareneWhitePaper : BibEntry := .article
  { core :=
      { key := "bassett-white-paper-article-x-2010"
      , contributors :=
          { authors :=
              [ .person "Paul M." "Bassett", .person "Alex R. G." "Deasley"
              , .person "Roger L." "Hahn", .person "Douglas S." "Hardy"
              , .person "K. Steve" "McCormick", .person "Thomas A." "Noble" ] }
      , title := "A White Paper on Article X"
      , year := some { value := 2010 }
      , identifiers :=
          [ .url ("https://didache.nazarene.org/index.php/volume-10-1/" ++
                  "812-didache-10-1-the-white-paper/file") (some "2026-09-27") ] }
  , journal := "Didache: Faithful Teaching"
  , volume := some "10"
  , issue := some "1" }

/-- Whitaker's *Disputation*, the Elizabethan Reformed answer to Bellarmine. Its
sixth question of the first controversy argues, against unwritten tradition,
that "the papists have no such unwritten tradition which can be certainly shewn
to have been always observed by the universal church" (506). Cited in the Parker
Society edition; the modern reprints paginate differently. -/
@[bib_entry] def whitakerDisputation : BibEntry := .book
  { core :=
      { key := "whitaker-disputation-1849"
      , role := .witness
      , contributors :=
          { authors := [.person "William" "Whitaker"]
          , translators := [.person "William" "Fitzgerald"] }
      , title := "A Disputation on Holy Scripture"
      , subtitle := some "Against the Papists, Especially Bellarmine and Stapleton"
      , year := some { value := 1849 }
      , note := some
          ("Latin original 1588. The Soli Deo Gloria reprint (2000) carries ISBN " ++
           "9781573580908, the Wipf & Stock reprint (2004) ISBN 9781592445530; " ++
           "neither is the pagination cited here.") }
  , publisher := "Printed at the University Press"
  , place := some "Cambridge"
  , series := some "Parker Society"
  , seriesNumber := some "45" }

/-! ### Sola fide: the wider debate

The positions `SolaFide` did not yet cite from their own sources (#27): the
origin of the New Perspective, both sides of the πίστις Χριστοῦ dispute, the
apocalyptic reading, the New Perspective's critics and a reply to them, the
Finnish reading of Luther, and Catholic exegesis alongside the conciliar text.
Each identifier was resolved at edition level in Open Library, or in Crossref
for a DOI. -/

/-- Sanders' comparison of Paul with Palestinian Judaism, the source of
*covenantal nomism*: that Second Temple Judaism held entry to the covenant to be
by grace and works to be the means of staying in it. The New Perspective's
starting point, and so the primary source for its premises rather than Dunn or
Wright, who build on it. -/
@[bib_entry] def sandersPaulPalestinianJudaism : BibEntry := .book
  { core :=
      { key := "sanders-paul-palestinian-judaism-1977"
      , contributors := { authors := [.person "E. P." "Sanders"] }
      , title := "Paul and Palestinian Judaism"
      , subtitle := some "A Comparison of Patterns of Religion"
      , year := some { value := 1977 }
      , identifiers := [.isbn "9780800604998"]
      , note := some "First American edition; published the same year by SCM, London." }
  , publisher := "Fortress Press"
  , place := some "Philadelphia" }

/-- Hays on the narrative substructure of Galatians: the case for reading
πίστις Χριστοῦ as a subjective genitive, "the faithfulness of Christ". On that
reading Galatians 2:16 and Romans 3:22 name Christ's faithfulness as the ground
of justification, not the believer's faith, and the Pauline strand reaches its
conclusion by a different route. -/
@[bib_entry] def haysFaithOfJesusChrist : BibEntry := .book
  { core :=
      { key := "hays-faith-jesus-christ-2002"
      , contributors := { authors := [.person "Richard B." "Hays"] }
      , title := "The Faith of Jesus Christ"
      , subtitle := some "The Narrative Substructure of Galatians 3:1–4:11"
      , year := some { value := 2002 }
      , identifiers := [.isbn "9780802849571"]
      , note := some
          "First edition 1983, SBL Dissertation Series 56 (Scholars Press)." }
  , publisher := "Wm. B. Eerdmans"
  , place := some "Grand Rapids"
  , edition := some "2nd"
  , series := some "The Biblical Resource Series" }

/-- Dunn's reply to Hays, the standard statement of the objective genitive:
πίστις Χριστοῦ is "faith in Christ". Cited so that the traditional reading of
the phrase is stated by a New Perspective scholar, which shows the genitive
dispute cuts across the Old/New Perspective line. -/
@[bib_entry] def dunnOnceMorePistisChristou : BibEntry := .inCollection
  { core :=
      { key := "dunn-once-more-pistis-christou-1991"
      , contributors := { authors := [.person "James D. G." "Dunn"] }
      , title := "Once More, Pistis Christou"
      , year := some { value := 1991 }
      , identifiers := [.doi "10.15699/9781589835849-048", .isbn "9781555406240"]
      , note := some
          ("Society of Biblical Literature Seminar Papers 30. The ISBN is the " ++
           "Scholars Press volume's; the DOI is SBL Press's 2010 digital reissue, " ++
           "with the same pagination.") }
  , containerTitle := "Society of Biblical Literature 1991 Seminar Papers"
  , containerEditors := [.person "Eugene H." "Lovering" (some "Jr.")]
  , publisher := "Scholars Press"
  , pages := some (730, 744) }

/-- Matlock's lexical-semantic critique of the πίστις Χριστοῦ debate. Its
argument is that the grammar of the genitive cannot settle the question, which
counts against letting either reading bear weight on grammar alone. -/
@[bib_entry] def matlockDetheologizing : BibEntry := .article
  { core :=
      { key := "matlock-detheologizing-2000"
      , contributors := { authors := [.person "R. Barry" "Matlock"] }
      , title := "Detheologizing the ΠΙΣΤΙΣ ΧΡΙΣΤΟΥ Debate"
      , subtitle := some "Cautionary Remarks from a Lexical Semantic Perspective"
      , year := some { value := 2000 }
      , identifiers := [.doi "10.1163/156853600506573"] }
  , journal := "Novum Testamentum"
  , volume := some "42"
  , issue := some "1"
  , pages := some (1, 23) }

/-- Martyn's Anchor Bible commentary on Galatians, the founding statement of the
apocalyptic reading. It rejects the traditional reading of justification and
also the New Perspective's framing of it: the question is God's invasive
deliverance of the world, not how an individual is accepted or how Jew and
gentile are related. -/
@[bib_entry] def martynGalatians : BibEntry := .book
  { core :=
      { key := "martyn-galatians-1997"
      , contributors := { authors := [.person "J. Louis" "Martyn"] }
      , title := "Galatians"
      , subtitle := some "A New Translation with Introduction and Commentary"
      , year := some { value := 1997 }
      , identifiers := [.isbn "9780385088381"] }
  , publisher := "Doubleday"
  , place := some "New York"
  , series := some "Anchor Bible"
  , seriesNumber := some "33A" }

/-- Campbell's apocalyptic rereading of justification. He argues at length
that the "justification theory" behind the traditional reading, which the
Reformed package encodes, is not Paul's own. The most thorough rival to the
`reformed` package, from a direction that is neither Tridentine nor New
Perspective. -/
@[bib_entry] def campbellDeliveranceOfGod : BibEntry := .book
  { core :=
      { key := "campbell-deliverance-god-2009"
      , contributors := { authors := [.person "Douglas A." "Campbell"] }
      , title := "The Deliverance of God"
      , subtitle := some "An Apocalyptic Rereading of Justification in Paul"
      , year := some { value := 2009 }
      , identifiers := [.isbn "9780802831262"] }
  , publisher := "Wm. B. Eerdmans"
  , place := some "Grand Rapids" }

/-- Gathercole's study of early Jewish soteriology. It argues that final
vindication *according to works* was widely held in Second Temple Judaism,
contrary to Sanders, so that Paul's "where is boasting?" (Romans 3:27) targets
confidence in obedience and not only ethnic privilege. The critique that
engages Sanders on his own evidence. -/
@[bib_entry] def gathercoleWhereIsBoasting : BibEntry := .book
  { core :=
      { key := "gathercole-where-boasting-2002"
      , contributors := { authors := [.person "Simon J." "Gathercole"] }
      , title := "Where Is Boasting?"
      , subtitle := some "Early Jewish Soteriology and Paul's Response in Romans 1–5"
      , year := some { value := 2002 }
      , identifiers := [.isbn "9780802839916"] }
  , publisher := "Wm. B. Eerdmans"
  , place := some "Grand Rapids" }

/-- The first volume of *Justification and Variegated Nomism*: a survey of
Second Temple literature, genre by genre, testing whether covenantal nomism
describes it. Cited as a whole for the conclusion that covenantal nomism is too
broad a category. Essays cited from it individually belong as `.inCollection`
entries. -/
@[bib_entry] def carsonVariegatedNomism1 : BibEntry := .book
  { core :=
      { key := "carson-variegated-nomism-1-2001"
      , contributors :=
          { editors :=
              [ .person "D. A." "Carson", .person "Peter T." "O'Brien"
              , .person "Mark A." "Seifrid" ] }
      , title := "Justification and Variegated Nomism"
      , subtitle := some "The Complexities of Second Temple Judaism"
      , year := some { value := 2001 }
      , identifiers := [.isbn "9783161469947"]
      , note := some "Co-published by Baker Academic, ISBN 9780801022722." }
  , publisher := "Mohr Siebeck"
  , series := some "Wissenschaftliche Untersuchungen zum Neuen Testament, 2. Reihe"
  , seriesNumber := some "140"
  , volume := some "1"
  , totalVolumes := some 2 }

/-- Piper's response to Wright. It defends imputed righteousness and the
traditional reading of justification against the New Perspective's
reconstruction. The popular-level Reformed critique that `newPerspective`
should be read beside. -/
@[bib_entry] def piperFutureOfJustification : BibEntry := .book
  { core :=
      { key := "piper-future-justification-2007"
      , contributors := { authors := [.person "John" "Piper"] }
      , title := "The Future of Justification"
      , subtitle := some "A Response to N. T. Wright"
      , year := some { value := 2007 }
      , identifiers := [.isbn "9781581349641"] }
  , publisher := "Crossway Books" }

/-- Wright's reply to Piper and his other critics. Cited so that the New
Perspective answers its critics in its own words, rather than being represented
only by statements that predate them. -/
@[bib_entry] def wrightJustification : BibEntry := .book
  { core :=
      { key := "wright-justification-2009"
      , contributors := { authors := [.person "N. T." "Wright"] }
      , title := "Justification"
      , subtitle := some "God's Plan and Paul's Vision"
      , year := some { value := 2009 }
      , identifiers := [.isbn "9780830838639"] }
  , publisher := "IVP Academic"
  , place := some "Downers Grove, IL" }

/-- Mannermaa's reading of Luther, the founding text of the Finnish school. It
reads justification through union with Christ really present in faith, close to
theosis. It matters here because it cuts across the Protestant/Catholic
division rather than sitting on one side of it. -/
@[bib_entry] def mannermaaChristPresentInFaith : BibEntry := .book
  { core :=
      { key := "mannermaa-christ-present-faith-2005"
      , contributors :=
          { authors := [.person "Tuomo" "Mannermaa"]
          , editors := [.person "Kirsi" "Stjerna"] }
      , title := "Christ Present in Faith"
      , subtitle := some "Luther's View of Justification"
      , year := some { value := 2005 }
      , identifiers := [.isbn "9780800637118"] }
  , publisher := "Fortress Press"
  , place := some "Minneapolis" }

/-- Fitzmyer's Anchor Bible commentary on Romans: Catholic exegesis of the
central texts. Until now the library cited Catholic teaching on justification
only through the conciliar decree. -/
@[bib_entry] def fitzmyerRomans : BibEntry := .book
  { core :=
      { key := "fitzmyer-romans-1993"
      , contributors := { authors := [.person "Joseph A." "Fitzmyer"] }
      , title := "Romans"
      , subtitle := some "A New Translation with Introduction and Commentary"
      , year := some { value := 1993 }
      , identifiers := [.isbn "9780385233170"] }
  , publisher := "Doubleday"
  , place := some "New York"
  , series := some "Anchor Bible"
  , seriesNumber := some "33" }

/-- The standard lexicon of New Testament Greek (BDAG). Cited for δικαιόω, whose
senses include "render a favorable verdict, vindicate". Verified at Open
Library, ISBN 9780226039336 (3rd ed., University of Chicago Press, 2000). -/
@[bib_entry] def bdag : BibEntry := .book
  { core :=
      { key := "bauer-danker-lexicon-2000"
      , role := .text
      , contributors :=
          { authors := [.person "Walter" "Bauer"]
          , editors := [.person "Frederick William" "Danker"] }
      , title :=
          "A Greek-English Lexicon of the New Testament and Other Early Christian " ++
          "Literature"
      , year := some { value := 2000 }
      , identifiers := [.isbn "9780226039336"] }
  , publisher := "University of Chicago Press"
  , place := some "Chicago"
  , edition := some "3rd" }

/-- Morris's lexical study of the apostolic vocabulary of salvation — redeem,
propitiate, reconcile, justify — against its Old Testament background. Cited for
the forensic sense of δικαιόω and its antithesis with condemnation. Verified at
Open Library, ISBN 9780802815125 (3rd ed., Eerdmans, 1965). -/
@[bib_entry] def morrisApostolicPreaching : BibEntry := .book
  { core :=
      { key := "morris-apostolic-preaching-1965"
      , contributors := { authors := [.person "Leon" "Morris"] }
      , title := "The Apostolic Preaching of the Cross"
      , year := some { value := 1965 }
      , identifiers := [.isbn "9780802815125"] }
  , publisher := "Eerdmans"
  , place := some "Grand Rapids"
  , edition := some "3rd" }

/-- Moo's commentary on Romans (NICNT). Verified at Open Library, ISBN
9780802823175 (Eerdmans, 1996). -/
@[bib_entry] def mooRomans : BibEntry := .book
  { core :=
      { key := "moo-romans-1996"
      , contributors := { authors := [.person "Douglas J." "Moo"] }
      , title := "The Epistle to the Romans"
      , year := some { value := 1996 }
      , identifiers := [.isbn "9780802823175"] }
  , publisher := "Eerdmans"
  , place := some "Grand Rapids"
  , series := some "New International Commentary on the New Testament" }

/-- Irons's lexical examination of δικαιοσύνη and its Hebrew counterparts, against
the covenant-faithfulness reading. Verified at Open Library, ISBN 9783161535185
(Mohr Siebeck, 2015; WUNT II/386). -/
@[bib_entry] def ironsRighteousnessOfGod : BibEntry := .book
  { core :=
      { key := "irons-righteousness-of-god-2015"
      , contributors := { authors := [.person "Charles Lee" "Irons"] }
      , title := "The Righteousness of God"
      , subtitle := some "A Lexical Examination of the Covenant-Faithfulness Interpretation"
      , year := some { value := 2015 }
      , identifiers := [.isbn "9783161535185"] }
  , publisher := "Mohr Siebeck"
  , place := some "Tübingen"
  , series := some "Wissenschaftliche Untersuchungen zum Neuen Testament, 2. Reihe"
  , seriesNumber := some "386" }

/-- Gorman's reading of justification as theosis: the verdict as an effective
word that transforms. The modern exegete who grants the forensic sense and
denies that the verdict stands apart from renewal. Verified at Open Library,
ISBN 9780802862655 (Eerdmans, 2009). -/
@[bib_entry] def gormanCruciformGod : BibEntry := .book
  { core :=
      { key := "gorman-cruciform-god-2009"
      , contributors := { authors := [.person "Michael J." "Gorman"] }
      , title := "Inhabiting the Cruciform God"
      , subtitle := some "Kenosis, Justification, and Theosis in Paul's Narrative Soteriology"
      , year := some { value := 2009 }
      , identifiers := [.isbn "9780802862655"] }
  , publisher := "Eerdmans"
  , place := some "Grand Rapids" }

/-- VanLandingham's argument that δικαιόω in Paul is best rendered "make
righteous": the principal modern lexical dissent from the forensic sense.
Verified at Open Library, ISBN 9781565633988 (Hendrickson, 2006). -/
@[bib_entry] def vanLandinghamJudgment : BibEntry := .book
  { core :=
      { key := "vanlandingham-judgment-justification-2006"
      , contributors := { authors := [.person "Chris" "VanLandingham"] }
      , title := "Judgment and Justification in Early Judaism and the Apostle Paul"
      , year := some { value := 2006 }
      , identifiers := [.isbn "9781565633988"] }
  , publisher := "Hendrickson"
  , place := some "Peabody, MA" }

/-- The Lutheran–Catholic *Joint Declaration on the Doctrine of Justification*
(1999). Its claim is that the sixteenth-century condemnations do not apply to
the partner's teaching as stated there. It bears on whether the `tridentine`
package still states a live Catholic position, and not only a historical
one. -/
@[bib_entry] def jointDeclarationJustification : BibEntry := .book
  { core :=
      { key := "lwf-catholic-joint-declaration-2000"
      , role := .authority
      , contributors :=
          { authors :=
              [ .corporate "Lutheran World Federation"
              , .corporate "Catholic Church" ] }
      , title := "Joint Declaration on the Doctrine of Justification"
      , year := some { value := 2000 }
      , identifiers := [.isbn "9780802847744"] }
  , publisher := "Wm. B. Eerdmans" }

/-! ### Sola fide: beyond the law, and the other apostles

Evidence that Paul's refusal reaches past circumcision to works as such, and
the witness of Peter and James at the Jerusalem council (Acts 15). Then the
authorship of the letters that evidence draws on, catalogued from both sides:
Ephesians, Titus, 1 and 2 Peter are each disputed, and a reader is owed the
scholarship that disputes them as well as the scholarship that answers it. -/

/-- Westerholm's defence of the "Lutheran" Paul against the New Perspective.
He argues that Paul contrasts grace with human works as such, from texts where
the law is not in view: Romans 4:4–5, 9:11–12 and 11:6. -/
@[bib_entry] def westerholmPerspectives : BibEntry := .book
  { core :=
      { key := "westerholm-perspectives-2003"
      , contributors := { authors := [.person "Stephen" "Westerholm"] }
      , title := "Perspectives Old and New on Paul"
      , subtitle := some "The \"Lutheran\" Paul and His Critics"
      , year := some { value := 2003 }
      , identifiers := [.isbn "9780802848093"] }
  , publisher := "Wm. B. Eerdmans" }

/-- Das on Paul and the law. His argument is that Paul's case assumes the law
requires the whole of it to be kept (Galatians 3:10, 5:3), so that the law as
a whole is refused as a means of justification, and not only its ethnic
markers. -/
@[bib_entry] def dasPaulLawCovenant : BibEntry := .book
  { core :=
      { key := "das-paul-law-covenant-2001"
      , contributors := { authors := [.person "A. Andrew" "Das"] }
      , title := "Paul, the Law, and the Covenant"
      , year := some { value := 2001 }
      , identifiers := [.isbn "9781565634633"] }
  , publisher := "Hendrickson Publishers" }

/-- Schreiner's account of the doctrine itself, historical and exegetical,
including its answer to James 2. -/
@[bib_entry] def schreinerFaithAlone : BibEntry := .book
  { core :=
      { key := "schreiner-faith-alone-2015"
      , contributors := { authors := [.person "Thomas R." "Schreiner"] }
      , title := "Faith Alone"
      , subtitle := some
          ("The Doctrine of Justification: What the Reformers Taught… " ++
           "and Why It Still Matters")
      , year := some { value := 2015 }
      , identifiers := [.isbn "9780310515784"] }
  , publisher := "Zondervan Academic"
  , place := some "Grand Rapids, MI"
  , series := some "The Five Solas Series" }

/-- Moo's commentary on Galatians: the Reformed exegesis of 2:16 and of the
circumcision polemic in 5:2–4. -/
@[bib_entry] def mooGalatians : BibEntry := .book
  { core :=
      { key := "moo-galatians-2013"
      , contributors := { authors := [.person "Douglas J." "Moo"] }
      , title := "Galatians"
      , year := some { value := 2013 }
      , identifiers := [.isbn "9780801027543"] }
  , publisher := "Baker Academic"
  , place := some "Grand Rapids, MI"
  , series := some "Baker Exegetical Commentary on the New Testament" }

/-- Bruce on Acts, cited for the Jerusalem council: the demand of 15:1 and 15:5,
and Peter's reply in 15:7–11. The catalogue lists two 1988 printings of the
revised edition; this is the one it ties to the series. -/
@[bib_entry] def bruceActs : BibEntry := .book
  { core :=
      { key := "bruce-acts-1988"
      , contributors := { authors := [.person "F. F." "Bruce"] }
      , title := "The Book of the Acts"
      , year := some { value := 1988 }
      , identifiers := [.isbn "9780802824189"] }
  , publisher := "Eerdmans"
  , place := some "Grand Rapids"
  , edition := some "revised"
  , series := some "New International Commentary on the New Testament" }

/-- Bruce on Hebrews, cited for 10:38–39 and 11:6: faith as what the righteous
live by, and without which no one pleases God. The catalogue lists the revised
edition under ISBN-10 0802825141. -/
@[bib_entry] def bruceHebrews : BibEntry := .book
  { core :=
      { key := "bruce-hebrews-1990"
      , contributors := { authors := [.person "F. F." "Bruce"] }
      , title := "The Epistle to the Hebrews"
      , year := some { value := 1990 }
      , identifiers := [.isbn "9780802825148"] }
  , publisher := "Eerdmans"
  , place := some "Grand Rapids"
  , edition := some "revised"
  , series := some "New International Commentary on the New Testament" }

/-- Jervell's reading of Luke-Acts: Luke presents the church as the restored
Israel, and the law as still in force for Jewish believers. On that reading
Acts 15 refuses to lay Israel's law on gentiles as a mark of belonging, and
does not refuse the law as a means of salvation. The rival to the apostolic
strand in `SolaFide`. -/
@[bib_entry] def jervellLukePeopleOfGod : BibEntry := .book
  { core :=
      { key := "jervell-luke-people-god-1972"
      , contributors := { authors := [.person "Jacob" "Jervell"] }
      , title := "Luke and the People of God"
      , subtitle := some "A New Look at Luke-Acts"
      , year := some { value := 1972 }
      , identifiers := [.isbn "9780806612324"] }
  , publisher := "Augsburg Publishing House"
  , place := some "Minneapolis" }

/-- Jobes on 1 Peter. Cited for the letter's account of salvation through
faith (1:3–9, 1:18–19), and for her defence of Petrine authorship. -/
@[bib_entry] def jobesFirstPeter : BibEntry := .book
  { core :=
      { key := "jobes-1-peter-2005"
      , contributors := { authors := [.person "Karen H." "Jobes"] }
      , title := "1 Peter"
      , year := some { value := 2005 }
      , identifiers := [.isbn "9780801026744"] }
  , publisher := "Baker Academic"
  , series := some "Baker Exegetical Commentary on the New Testament" }

/-- Schreiner on 1 and 2 Peter and Jude. Cited for 2 Peter 3:15–16, where the
writer counts Paul's letters with "the other Scriptures", and for his defence
of Petrine authorship of both letters. -/
@[bib_entry] def schreinerPeterJude : BibEntry := .book
  { core :=
      { key := "schreiner-peter-jude-2003"
      , contributors := { authors := [.person "Thomas R." "Schreiner"] }
      , title := "1, 2 Peter, Jude"
      , year := some { value := 2003 }
      , identifiers := [.isbn "9780805401370"] }
  , publisher := "Broadman & Holman"
  , place := some "Nashville, TN"
  , series := some "New American Commentary"
  , seriesNumber := some "37" }

/-- Achtemeier's Hermeneia commentary on 1 Peter, which concludes that the
letter was not written by the apostle. The critical case on 1 Peter's
authorship, stated by a scholar who holds it. -/
@[bib_entry] def achtemeierFirstPeter : BibEntry := .book
  { core :=
      { key := "achtemeier-1-peter-1996"
      , contributors :=
          { authors := [.person "Paul J." "Achtemeier"]
          , editors := [.person "Eldon Jay" "Epp"] }
      , title := "1 Peter"
      , subtitle := some "A Commentary on First Peter"
      , year := some { value := 1996 }
      , identifiers := [.isbn "9780800660307"] }
  , publisher := "Fortress Press"
  , place := some "Minneapolis"
  , series := some "Hermeneia" }

/-- Bauckham on Jude and 2 Peter. He reads 2 Peter as a testament, a genre
whose readers would have recognised it as written in Peter's name after his
death. The standard case that 2 Peter is not by the apostle. -/
@[bib_entry] def bauckhamJude2Peter : BibEntry := .book
  { core :=
      { key := "bauckham-jude-2-peter-1983"
      , contributors := { authors := [.person "Richard J." "Bauckham"] }
      , title := "Jude, 2 Peter"
      , year := some { value := 1983 }
      , identifiers := [.isbn "9780849902499"] }
  , publisher := "Word Books"
  , place := some "Waco, TX"
  , series := some "Word Biblical Commentary"
  , seriesNumber := some "50" }

/-- Lincoln on Ephesians, which argues that the letter is by a follower of
Paul rather than by Paul. Also cited for the reading that Ephesians 2:8–9
restates Paul's "works of the law" as works in general. -/
@[bib_entry] def lincolnEphesians : BibEntry := .book
  { core :=
      { key := "lincoln-ephesians-1990"
      , contributors := { authors := [.person "Andrew T." "Lincoln"] }
      , title := "Ephesians"
      , year := some { value := 1990 }
      , identifiers := [.isbn "9780849902413"] }
  , publisher := "Thomas Nelson"
  , place := some "Dallas, TX"
  , series := some "Word Biblical Commentary"
  , seriesNumber := some "42" }

/-- Hoehner on Ephesians, whose introduction is an extended defence of Pauline
authorship. The reply to Lincoln. -/
@[bib_entry] def hoehnerEphesians : BibEntry := .book
  { core :=
      { key := "hoehner-ephesians-2002"
      , contributors := { authors := [.person "Harold W." "Hoehner"] }
      , title := "Ephesians"
      , subtitle := some "An Exegetical Commentary"
      , year := some { value := 2002 }
      , identifiers := [.isbn "9780801026140"] }
  , publisher := "Baker Academic" }

/-- Dibelius and Conzelmann on the Pastoral Epistles: the classic critical
statement that 1–2 Timothy and Titus are pseudonymous. -/
@[bib_entry] def dibeliusConzelmannPastorals : BibEntry := .book
  { core :=
      { key := "dibelius-conzelmann-pastoral-epistles-1972"
      , contributors :=
          { authors := [.person "Martin" "Dibelius", .person "Hans" "Conzelmann"]
          , editors := [.person "Helmut" "Koester"]
          , translators := [.person "Philip" "Buttolph", .person "Adela" "Yarbro"] }
      , title := "The Pastoral Epistles"
      , subtitle := some "A Commentary on the Pastoral Epistles"
      , year := some { value := 1972 }
      , identifiers := [.isbn "9780800660024"] }
  , publisher := "Fortress Press"
  , place := some "Philadelphia"
  , series := some "Hermeneia" }

/-- Mounce on the Pastoral Epistles, whose introduction defends Pauline
authorship of 1–2 Timothy and Titus. -/
@[bib_entry] def mouncePastorals : BibEntry := .book
  { core :=
      { key := "mounce-pastoral-epistles-2000"
      , contributors := { authors := [.person "William D." "Mounce"] }
      , title := "Pastoral Epistles"
      , year := some { value := 2000 }
      , identifiers := [.isbn "9780849902451"] }
  , publisher := "Thomas Nelson"
  , series := some "Word Biblical Commentary"
  , seriesNumber := some "46" }

/-- Marshall's ICC commentary on the Pastoral Epistles. A mediating position:
the letters are not by Paul's own hand but were written after his death by
those close to him, without intent to deceive. Neither the traditional nor the
critical view, and cited so that the dispute is not presented as two-sided
when it is not. -/
@[bib_entry] def marshallPastorals : BibEntry := .book
  { core :=
      { key := "marshall-pastoral-epistles-1999"
      , contributors := { authors := [.person "I. Howard" "Marshall"] }
      , title := "A Critical and Exegetical Commentary on the Pastoral Epistles"
      , year := some { value := 1999 }
      , identifiers := [.isbn "9780567086617"] }
  , publisher := "T. & T. Clark"
  , series := some "International Critical Commentary" }

/-- Ehrman on forgery in early Christianity. He argues that Ephesians, the
Pastorals, 1 Peter and 2 Peter were all written in apostles' names by others,
and that ancient readers regarded such writing as deceit. The strongest
statement of the critical position, covering every letter in dispute here. -/
@[bib_entry] def ehrmanForgery : BibEntry := .book
  { core :=
      { key := "ehrman-forgery-counterforgery-2014"
      , contributors := { authors := [.person "Bart D." "Ehrman"] }
      , title := "Forgery and Counter-Forgery"
      , subtitle := some "The Use of Literary Deceit in Early Christian Polemics"
      , year := some { value := 2014 }
      , identifiers := [.isbn "9780199928033"] }
  , publisher := "Oxford University Press"
  , place := some "New York" }

/-! ### The church fathers on Isaiah 7:14

Four second- to fourth-century witnesses to the predictive reading, each cited
through the nineteenth-century translation series whose text was consulted, in
the revision New Advent publishes. The series carry no ISBN; the entries are
rendered unverified rather than given the ISBN of a later reprint. -/

/-- *The Ante-Nicene Fathers*, volume 1: the edition through which Justin's
*Dialogue with Trypho* (tr. Marcus Dods and George Reith) and Irenaeus'
*Against Heresies* (tr. Alexander Roberts and William Rambaut) are cited. -/
@[bib_entry] def anf1 : BibEntry := .book
  { core :=
      { key := "roberts-ante-nicene-fathers-1-1885"
      , role := .witness
      , contributors :=
          { editors := [.person "Alexander" "Roberts", .person "James" "Donaldson"
                       , .person "A. Cleveland" "Coxe"] }
      , title := "The Ante-Nicene Fathers"
      , year := some { value := 1885 }
      , note := some "Consulted in the revised text published by New Advent." }
  , publisher := "Christian Literature Publishing Company"
  , place := some "Buffalo, NY"
  , volume := some "1" }

/-- *The Ante-Nicene Fathers*, volume 4: the edition through which Origen's
*Against Celsus* (tr. Frederick Crombie) is cited. -/
@[bib_entry] def anf4 : BibEntry := .book
  { core :=
      { key := "roberts-ante-nicene-fathers-4-1885"
      , role := .witness
      , contributors :=
          { editors := [.person "Alexander" "Roberts", .person "James" "Donaldson"
                       , .person "A. Cleveland" "Coxe"] }
      , title := "The Ante-Nicene Fathers"
      , year := some { value := 1885 }
      , note := some "Consulted in the revised text published by New Advent." }
  , publisher := "Christian Literature Publishing Company"
  , place := some "Buffalo, NY"
  , volume := some "4" }

/-- Basil of Caesarea, *Ascetical Works*, tr. M. Monica Wagner: Fathers of the
Church volume 9, which carries Homily 20, "Of Humility" (p. 475). Verified at
Open Library, ISBN 9780813209661 (Catholic University of America Press,
1999). -/
@[bib_entry] def basilAsceticalWorks : BibEntry := .book
  { core :=
      { key := "basil-ascetical-works-1999"
      , role := .witness
      , contributors :=
          { authors := [.person "Basil" "of Caesarea"]
          , translators := [.person "M. Monica" "Wagner"] }
      , title := "Ascetical Works"
      , year := some { value := 1999 }
      , identifiers := [.isbn "9780813209661"] }
  , publisher := "Catholic University of America Press"
  , place := some "Washington, DC"
  , series := some "The Fathers of the Church"
  , volume := some "9" }

/-- Hilary of Poitiers, *Commentary on Matthew*, tr. D. H. Williams: Fathers of
the Church volume 125. Verified at Open Library, ISBN 9780813201252, whose
record names the series and volume (Catholic University of America Press,
2013). -/
@[bib_entry] def hilaryMatthew : BibEntry := .book
  { core :=
      { key := "hilary-commentary-matthew-2013"
      , role := .witness
      , contributors :=
          { authors := [.person "Hilary" "of Poitiers"]
          , translators := [.person "D. H." "Williams"] }
      , title := "Commentary on Matthew"
      , year := some { value := 2013 }
      , identifiers := [.isbn "9780813201252"] }
  , publisher := "Catholic University of America Press"
  , place := some "Washington, DC"
  , series := some "The Fathers of the Church"
  , volume := some "125" }

/-- *Nicene and Post-Nicene Fathers*, second series, volume 6: the edition
through which Jerome's *Against Jovinianus* (tr. W. H. Fremantle, G. Lewis and
W. G. Martley) is cited. -/
@[bib_entry] def npnf2v6 : BibEntry := .book
  { core :=
      { key := "schaff-nicene-post-nicene-fathers-2-6-1893"
      , role := .witness
      , contributors :=
          { editors := [.person "Philip" "Schaff", .person "Henry" "Wace"] }
      , title := "Nicene and Post-Nicene Fathers, Second Series"
      , subtitle := some "St. Jerome: Letters and Select Works"
      , year := some { value := 1893 }
      , note := some "Consulted in the revised text published by New Advent." }
  , publisher := "Christian Literature Publishing Company"
  , place := some "Buffalo, NY"
  , volume := some "6" }

/-- Justin's *Dialogue with Trypho*, the earliest sustained Christian argument
from Isaiah 7:14 and the earliest record of the Jewish reply to it: Trypho
answers that the text says "young woman" and that the prophecy was fulfilled
in Hezekiah (67). Cited for both halves. -/
@[bib_entry] def justinDialogue : BibEntry := .ancientWork
  { core :=
      { key := "justin-dialogue-with-trypho-160"
      , role := .witness
      , contributors := { authors := [.single "Justin Martyr"] }
      , title := "Dialogue with Trypho" }
  , originalTitle := some "Πρὸς Τρύφωνα Ἰουδαῖον Διάλογος"
  , composed := some { value := 160, approximate := true }
  , editionUsed := some "roberts-ante-nicene-fathers-1-1885" }

/-- Irenaeus, *Against Heresies* III.21: the defence of the Septuagint's
παρθένος against the renderings of Theodotion and Aquila, and the argument that
a young woman's ordinary conception would be no sign. -/
@[bib_entry] def irenaeusAgainstHeresies : BibEntry := .ancientWork
  { core :=
      { key := "irenaeus-against-heresies-180"
      , role := .witness
      , contributors := { authors := [.single "Irenaeus"] }
      , title := "Against Heresies" }
  , originalTitle := some "Adversus haereses"
  , composed := some { value := 180, approximate := true }
  , editionUsed := some "roberts-ante-nicene-fathers-1-1885" }

/-- Origen, *Against Celsus* I.34–35: what sign an ordinary birth would be, and
the question which child of Ahaz's day was called Immanuel. -/
@[bib_entry] def origenAgainstCelsus : BibEntry := .ancientWork
  { core :=
      { key := "origen-against-celsus-248"
      , role := .witness
      , contributors := { authors := [.single "Origen"] }
      , title := "Against Celsus" }
  , originalTitle := some "Κατὰ Κέλσου"
  , composed := some { value := 248, approximate := true }
  , editionUsed := some "roberts-ante-nicene-fathers-4-1885" }

/-- Jerome, *Against Jovinianus* I.32: the lexical argument that עַלְמָה is a
"hidden" virgin, from Genesis 24:43, with the challenge to produce a passage
where it is used of a married woman. -/
@[bib_entry] def jeromeAgainstJovinianus : BibEntry := .ancientWork
  { core :=
      { key := "jerome-against-jovinianus-393"
      , role := .witness
      , contributors := { authors := [.single "Jerome"] }
      , title := "Against Jovinianus" }
  , originalTitle := some "Adversus Jovinianum"
  , composed := some { value := 393 }
  , editionUsed := some "schaff-nicene-post-nicene-fathers-2-6-1893" }

/-- Joos's "Semantic Axiom Number One": of the meanings a word could have in a
passage, the best is the one that contributes least to the total message — the
rule of least meaning. Verified at Crossref, DOI 10.2307/412133. -/
@[bib_entry] def joosSemanticAxiom : BibEntry := .article
  { core :=
      { key := "joos-semantic-axiom-1972"
      , contributors := { authors := [.person "Martin" "Joos"] }
      , title := "Semantic Axiom Number One"
      , year := some { value := 1972 }
      , identifiers := [.doi "10.2307/412133"] }
  , journal := "Language"
  , volume := some "48"
  , issue := some "2"
  , pages := some (257, 265) }

/-- Silva's introduction to lexical semantics for biblical studies, which brings
Joos's rule of least meaning, and Barr's critique of theological lexicography,
to the words of the New Testament. Verified at Open Library, ISBN 0310479819
(Zondervan, 1994, revised and expanded edition). -/
@[bib_entry] def silvaBiblicalWords : BibEntry := .book
  { core :=
      { key := "silva-biblical-words-1994"
      , contributors := { authors := [.person "Moisés" "Silva"] }
      , title := "Biblical Words and Their Meaning"
      , subtitle := some "An Introduction to Lexical Semantics"
      , year := some { value := 1994 }
      , identifiers := [.isbn "9780310479819"] }
  , publisher := "Zondervan"
  , place := some "Grand Rapids"
  , edition := some "revised and expanded edition" }

/-- Barr's critique of arguments from the Bible's vocabulary to its theology,
which named "illegitimate totality transfer": reading into one occurrence of a
word everything the word, or the doctrine it is used for, can carry. Verified at
Open Library, ISBN 9781592446926 (Wipf & Stock, 2004, reprinting Oxford
University Press, 1961). -/
@[bib_entry] def barrSemantics : BibEntry := .book
  { core :=
      { key := "barr-semantics-2004"
      , contributors := { authors := [.person "James" "Barr"] }
      , title := "The Semantics of Biblical Language"
      , year := some { value := 2004 }
      , identifiers := [.isbn "9781592446926"]
      , note := some "First published Oxford University Press, 1961." }
  , publisher := "Wipf & Stock"
  , place := some "Eugene, OR" }

/-- Schaff's Nicene and Post-Nicene Fathers, first series volume 5: Augustine's
anti-Pelagian writings, among them *On the Spirit and the Letter*, whose
chapter 45 (26.45 in the Latin numbering) glosses "being justified" as "being
made righteous". Checked against the electronic text at CCEL. Reprinted under
many imprints, none of which the catalogue ties to an identifier, so the entry
records the electronic text instead. -/
@[bib_entry] def npnfAugustineAntiPelagian : BibEntry := .book
  { core :=
      { key := "npnf1-05-1887"
      , role := .witness
      , contributors := { editors := [.person "Philip" "Schaff"] }
      , title :=
          "A Select Library of the Nicene and Post-Nicene Fathers of the Christian Church"
      , subtitle := some "First Series, Volume 5: St. Augustin — Anti-Pelagian Writings"
      , year := some { value := 1887 }
      , identifiers :=
          [ .url "https://www.ccel.org/ccel/schaff/npnf105.html" (some "2026-09-26") ]
      , note := some
          ("Public domain; reprinted under several imprints, none tied to a " ++
           "catalogue identifier.") }
  , publisher := "Christian Literature Company"
  , place := some "Buffalo, NY" }

/-- McGrath's history of the doctrine of justification: how the Latin West,
from Augustine, read *iustificare* as "to make righteous", and why the
Reformers' distinction of justification from regeneration was new against that
tradition. Verified at Open Library, ISBN 0521533899 (Cambridge University
Press, 2005, third edition). -/
@[bib_entry] def mcgrathIustitiaDei : BibEntry := .book
  { core :=
      { key := "mcgrath-iustitia-dei-2005"
      , contributors := { authors := [.person "Alister E." "McGrath"] }
      , title := "Iustitia Dei"
      , subtitle := some "A History of the Christian Doctrine of Justification"
      , year := some { value := 2005 }
      , identifiers := [.isbn "9780521533898"] }
  , publisher := "Cambridge University Press"
  , place := some "Cambridge"
  , edition := some "3rd edition" }

/-! ### The increase of justification

Added for `Arguments.SolaFide.James`: the critical text and the Catholic Church's
own translation and teaching on the original text, against which the texts
Trent cites for the increase of justification (Session VI, ch. 10) are read. -/

/-- The SBL Greek New Testament, Holmes's critical text, whose apparatus compares
it with Westcott–Hort, Tregelles, the NIV's text and the Byzantine text of
Robinson–Pierpont. Cited for Revelation 22:11, where it marks no variation at
δικαιοσύνην ποιησάτω. ISBN confirmed at Open Library. -/
@[bib_entry] def sblgnt : BibEntry := .criticalEdition
  { core :=
      { key := "holmes-sblgnt-2010"
      , role := .text
      , contributors := { editors := [.person "Michael W." "Holmes"] }
      , title := "The Greek New Testament: SBL Edition"
      , year := some { value := 2010 }
      , identifiers := [.isbn "9781589835351"] }
  , publisher := "Society of Biblical Literature"
  , siglum := some "SBLGNT" }

/-- The New American Bible, Revised Edition: the translation of the United States
Conference of Catholic Bishops. Cited for how the Catholic Church's own
translators render Revelation 22:11 ("The righteous must still do right") and
Sirach 18:22 ("do not wait until death to fulfill them"). Read on the bishops'
site; no single printing's ISBN is recorded. -/
@[bib_entry] def nabre : BibEntry := .webPage
  { core :=
      { key := "usccb-nabre-2011"
      , role := .text
      , contributors := { authors := [.corporate "United States Conference of Catholic Bishops"] }
      , title := "New American Bible, Revised Edition"
      , year := some { value := 2011 }
      , identifiers := [.url "https://bible.usccb.org/bible" (some "2026-10-03")] }
  , site := some "USCCB" }

/-- Pius XII's encyclical on biblical studies. Cited for what Trent's declaring
the Vulgate "authentic" means: an authority "not affirmed by the Council
particularly for critical reasons, but rather because of its legitimate use"
(§21), which does not prevent recourse to the original texts; and the original
text "has more authority and greater weight than any even the very best
translation" (§16). -/
@[bib_entry] def divinoAfflanteSpiritu : BibEntry := .webPage
  { core :=
      { key := "pius-divino-afflante-spiritu-1943"
      , role := .authority
      , contributors := { authors := [.single "Pius XII"] }
      , title := "Divino Afflante Spiritu"
      , year := some { value := 1943 }
      , identifiers :=
          [ .url ("https://www.vatican.va/content/pius-xii/en/encyclicals/documents/" ++
                  "hf_p-xii_enc_30091943_divino-afflante-spiritu.html") (some "2026-10-03") ] }
  , site := some "The Holy See" }

/-! ### Articles examined

Published articles the library examines as commentary
(`Testimony.Articles`), cited for the moves it quotes from them. -/

/-- Howell's dialogue on justification, for *Catholic Answers*: the argument that
"faith alone" occurs once in the New Testament, at James 2:24, where it is
denied, and that Paul and James must mean different things by *works*. Read on
the publisher's page; the print edition is dated 1 March 2003. No ISSN, DOI or
page range is given there, and none is recorded. -/
@[bib_entry] def howellSavedByFaithAlone : BibEntry := .webPage
  { core :=
      { key := "howell-saved-by-faith-alone-2003"
      , role := .witness
      , contributors := { authors := [.person "Kenneth" "Howell"] }
      , title := "Aren't We Saved by Faith Alone?"
      , year := some { value := 2003 }
      , identifiers :=
          [ .url "https://catholic.com/magazine/print-edition/arent-we-saved-by-faith-alone"
                 (some "2026-10-03") ] }
  , site := some "Catholic Answers Magazine" }

derive_bib_registry registry

end Testimony.Bib
