import Testimony.Bib.Attr

/-!
# Testimony.Bib.Works — the catalogued bibliography

Every entry here was checked against a public catalogue (Open Library,
Crossref) before being committed. **No identifier in this file was written from
memory.** Where an identifier could not be tied to a specific printing, the
field is `none` and the entry renders as unverified — which is the rule working,
not failing. Nineteenth-century works and critical editions co-published under
several imprints are the usual cases.

These are the works the library itself cites: in its own modules, in the
golden tests of its renderer, and in the source helpers of `Testimony.Scripture`.
The works its arguments cite are the arguments package's
(`TestimonyArguments.Works`), and a package's bibliography is the two registries
together. An argument may cite an entry here; the library cites nothing there.

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

/-- Berry's dictionary article on the virgin birth. Cited for two things the
argument from Isaiah 7:14 turns on: that how Isaiah 7:14 was fulfilled in Ahaz's
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
Christian reading, and is cited as such. -/
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

/-! ### The standards the library aligns to -/

/-- The Argument Interchange Format's specification, from the Argumentation
Research Group at Dundee: the core ontology of argument — information nodes,
and the scheme nodes that apply an inference (RA), a conflict (CA) or a
preference (PA) — and the conditions an AIF graph must meet (Definition 1.1).
`Testimony.Logic.Aif` checks the library's disputes against those conditions. -/
@[bib_entry] def aifSpecification : BibEntry := .webPage
  { core :=
      { key := "dundee-aif-specification-2011"
      , role := .text
      , contributors :=
          { authors := [.corporate "Argumentation Research Group, University of Dundee"] }
      , title := "The Argument Interchange Format (AIF) Specification"
      , year := some { value := 2011 }
      , identifiers :=
          [ .url "https://arg-tech.org/wp-content/uploads/2011/09/aif-spec.pdf"
                 (some "2026-10-14") ] }
  , site := some "ARG-tech, University of Dundee" }

/-- The paper that proposed the Argument Interchange Format: a common ontology
for argument, so that tools built on different formalisms can exchange
arguments. -/
@[bib_entry] def chesnevarArgumentInterchange : BibEntry := .article
  { core :=
      { key := "chesnevar-argument-interchange-format-2006"
      , contributors :=
          { authors :=
              [ .person "Carlos" "Chesñevar", .person "Jarred" "McGinnis"
              , .person "Sanjay" "Modgil", .person "Iyad" "Rahwan", .person "Chris" "Reed"
              , .person "Guillermo" "Simari", .person "Matthew" "South"
              , .person "Gerard" "Vreeswijk", .person "Steven" "Willmott" ] }
      , title := "Towards an Argument Interchange Format"
      , year := some { value := 2006 }
      , identifiers := [.doi "10.1017/S0269888906001044"] }
  , journal := "The Knowledge Engineering Review"
  , volume := some "21"
  , issue := some "4"
  , pages := some (293, 316) }

/-- DOLCE, the Descriptive Ontology for Linguistic and Cognitive Engineering,
as its authors present it: endurants and perdurants, qualities and abstract
regions, built to follow the distinctions natural language and human cognition
make. The upper ontology the library's vocabulary is aligned to
(`Testimony.Semantics.Upper`). -/
@[bib_entry] def borgoDolce : BibEntry := .article
  { core :=
      { key := "borgo-dolce-2022"
      , contributors :=
          { authors :=
              [ .person "Stefano" "Borgo", .person "Roberta" "Ferrario"
              , .person "Aldo" "Gangemi", .person "Nicola" "Guarino"
              , .person "Claudio" "Masolo", .person "Daniele" "Porello"
              , .person "Emilio M." "Sanfilippo", .person "Laure" "Vieu" ] }
      , title := "DOLCE: A Descriptive Ontology for Linguistic and Cognitive Engineering"
      , year := some { value := 2022 }
      , identifiers := [.doi "10.3233/AO-210259"] }
  , journal := "Applied Ontology"
  , volume := some "17"
  , issue := some "1"
  , pages := some (45, 69) }

/-- Basic Formal Ontology, as its authors teach it: continuants and occurrents,
dependent and independent entities, processes and the temporal regions they
occupy. The library's upper categories name their BFO counterparts from it. -/
@[bib_entry] def arpBasicFormalOntology : BibEntry := .book
  { core :=
      { key := "arp-basic-formal-ontology-2015"
      , contributors :=
          { authors :=
              [ .person "Robert" "Arp", .person "Barry" "Smith", .person "Andrew D." "Spear" ] }
      , title := "Building Ontologies with Basic Formal Ontology"
      , year := some { value := 2015 }
      , identifiers := [.isbn "9780262527811"] }
  , publisher := "MIT Press"
  , place := some "Cambridge, MA" }

derive_bib_registry registry

end Testimony.Bib
