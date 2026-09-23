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
being the narrower. -/
@[bib_entry] def bookOfConcord : BibEntry := .book
  { core :=
      { key := "kolb-wengert-book-of-concord-2000"
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
      , contributors :=
          { editors := [.person "Alexander" "Roberts", .person "James" "Donaldson"
                       , .person "A. Cleveland" "Coxe"] }
      , title := "The Ante-Nicene Fathers"
      , year := some { value := 1885 }
      , note := some "Consulted in the revised text published by New Advent." }
  , publisher := "Christian Literature Publishing Company"
  , place := some "Buffalo, NY"
  , volume := some "4" }

/-- *Nicene and Post-Nicene Fathers*, second series, volume 6: the edition
through which Jerome's *Against Jovinianus* (tr. W. H. Fremantle, G. Lewis and
W. G. Martley) is cited. -/
@[bib_entry] def npnf2v6 : BibEntry := .book
  { core :=
      { key := "schaff-nicene-post-nicene-fathers-2-6-1893"
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
      , contributors := { authors := [.single "Jerome"] }
      , title := "Against Jovinianus" }
  , originalTitle := some "Adversus Jovinianum"
  , composed := some { value := 393 }
  , editionUsed := some "schaff-nicene-post-nicene-fathers-2-6-1893" }

derive_bib_registry registry

end Testimony.Bib
