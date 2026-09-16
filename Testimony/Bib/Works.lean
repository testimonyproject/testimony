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

derive_bib_registry registry

end Testimony.Bib
