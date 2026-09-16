import Testimony.Text

/-!
# Testimony.Bib.Core — bibliography-grade citation types

A citation in this library is a typed value, not a string. The purpose is that a
reader can *check* it: every entry carries whatever stable public identifier
exists for the work (DOI, ISBN, OCLC, URL), and an entry that carries none is
rendered as unverified rather than passing silently.

Entry types follow ordinary bibliographic practice, with three additions this
domain needs. Critical editions (`criticalEdition`) are cited by siglum and
apparatus rather than by page. Ancient works (`ancientWork`) are cited through
the modern edition used, as scholarly convention requires. Datasets (`dataset`)
carry a version and commit, because linguistic annotation is evidence and
evidence must be reproducible.
-/

namespace Testimony.Bib

/-- A citation key: the stable handle by which an entry is referenced.
Format is `family-shorttitle-year`, e.g. `france-matthew-2007`. -/
abbrev CiteKey := String

/-- A person or an organisation responsible for a work. Names are stored in
parts so that renderers can produce any citation style, and so that corporate
authors (Deutsche Bibelgesellschaft, United Bible Societies) are representable
without pretending to be people. -/
inductive Agent
  /-- A person, with name parts kept separate for rendering. -/
  | person (given : String) (family : String) (suffix : Option String := none)
  /-- An organisation, which has no given and family name. -/
  | corporate (name : String)
deriving Repr, DecidableEq

/-- The name a bibliography sorts by: a person's family name, or the
organisation's name. -/
def Agent.sortKey : Agent → String
  | .person _ family _ => family
  | .corporate name => name

/-- Contributors to a work, by role. Editors and translators are tracked
separately from authors because critical editions and translated commentaries
(Keil & Delitzsch, trans. James Martin) cannot be rendered correctly without
them. -/
structure Contributors where
  /-- Those who wrote the work. -/
  authors : List Agent := []
  /-- Those who edited it — often the only contributors a critical edition
  has. -/
  editors : List Agent := []
  /-- Those who translated it. -/
  translators : List Agent := []
deriving Repr, DecidableEq

/-- A year of publication or composition. `value` is negative for BCE dates;
`approximate` marks the `c.` of an uncertain composition date. -/
structure Year where
  /-- The year; negative for BCE. -/
  value : Int
  /-- Whether the date is approximate — the `c.` of an uncertain composition
  date. -/
  approximate : Bool := false
deriving Repr, DecidableEq

/-- A stable public identifier. This is the field that makes a reference
*checkable* by a reader who does not have the book to hand. -/
inductive Identifier
  /-- A Digital Object Identifier, resolvable at doi.org. -/
  | doi (s : String)
  /-- An International Standard Book Number, for a specific printing. -/
  | isbn (s : String)
  /-- An International Standard Serial Number, for a periodical. -/
  | issn (s : String)
  /-- An OCLC WorldCat record number. -/
  | oclc (s : String)
  /-- `accessed` is an ISO-8601 date, required by most style guides for web
  resources. -/
  | url (s : String) (accessed : Option String := none)
  /-- A stable archived copy (Wayback, Zenodo) of a resource that may move. -/
  | archived (s : String)
deriving Repr, DecidableEq

/-- A resolvable web address for an identifier, where one exists. Used by the
bibliography renderer to turn identifiers into links. -/
def Identifier.uri : Identifier → Option String
  | .doi s => some ("https://doi.org/" ++ s)
  | .isbn _ => none
  | .issn _ => none
  | .oclc s => some ("https://worldcat.org/oclc/" ++ s)
  | .url s _ => some s
  | .archived s => some s

/-- Fields every entry type carries. -/
structure WorkCore where
  /-- The stable handle for this entry. -/
  key : CiteKey
  /-- Who is responsible for the work. -/
  contributors : Contributors
  /-- The work's title. -/
  title : String
  /-- Its subtitle, where it has one. -/
  subtitle : Option String := none
  /-- Year of publication. -/
  year : Option Year := none
  /-- Stable public identifiers. An empty list renders as unverified. -/
  identifiers : List Identifier := []
  /-- Anything a reader needs in order to follow the citation. -/
  note : Option String := none
deriving Repr, DecidableEq

/-- A monograph or commentary. -/
structure BookData where
  /-- Fields shared with every entry type. -/
  core : WorkCore
  /-- The publisher. -/
  publisher : String
  /-- Place of publication. -/
  place : Option String := none
  /-- Edition statement, e.g. "2nd edition". -/
  edition : Option String := none
  /-- Series the volume belongs to, e.g. NICNT. -/
  series : Option String := none
  /-- Number within that series. -/
  seriesNumber : Option String := none
  /-- Which volume, for a multi-volume work. -/
  volume : Option String := none
  /-- How many volumes the work runs to. -/
  totalVolumes : Option Nat := none
deriving Repr, DecidableEq

/-- A chapter or essay within an edited volume. `core.title` is the chapter
title; `containerTitle` is the volume's. Lexicon entries are cited this way,
with `Locus.sv`. -/
structure InCollectionData where
  /-- Fields shared with every entry type; `core.title` is the chapter title. -/
  core : WorkCore
  /-- Title of the containing volume. -/
  containerTitle : String
  /-- Editors of the containing volume. -/
  containerEditors : List Agent := []
  /-- The publisher. -/
  publisher : String
  /-- Place of publication. -/
  place : Option String := none
  /-- Edition statement. -/
  edition : Option String := none
  /-- First and last page of the chapter. -/
  pages : Option (Nat × Nat) := none
deriving Repr, DecidableEq

/-- A journal article. -/
structure ArticleData where
  /-- Fields shared with every entry type. -/
  core : WorkCore
  /-- The journal it appeared in. -/
  journal : String
  /-- Volume number. -/
  volume : Option String := none
  /-- Issue number. -/
  issue : Option String := none
  /-- First and last page. -/
  pages : Option (Nat × Nat) := none
deriving Repr, DecidableEq

/-- A dissertation or thesis. `kind` is the degree description, e.g.
`"PhD diss."`. -/
structure ThesisData where
  /-- Fields shared with every entry type. -/
  core : WorkCore
  /-- The degree, e.g. "PhD diss.". -/
  kind : String
  /-- The awarding institution. -/
  institution : String
deriving Repr, DecidableEq

/-- A critical edition of a text: NA28, BHS, UBS5. Typed separately from `book`
because it is cited by siglum and apparatus rather than by page, and because its
editors matter more than its author (it has none). -/
structure EditionData where
  /-- Fields shared with every entry type. -/
  core : WorkCore
  /-- The publisher. -/
  publisher : String
  /-- Place of publication. -/
  place : Option String := none
  /-- Edition statement, e.g. "28th revised edition". -/
  edition : Option String := none
  /-- The siglum scholars cite it by, e.g. "NA28". -/
  siglum : Option String := none
deriving Repr, DecidableEq

/-- An ancient work, cited through a modern edition. Scholarly practice cites
Josephus, *Ant.* 18.63, *in* a named Loeb volume; `editionUsed` records which.
The link is by key rather than by value to keep `BibEntry` non-recursive. -/
structure AncientWorkData where
  /-- Fields shared with every entry type; `core.title` is the conventional
  title. -/
  core : WorkCore
  /-- The title in its original language. -/
  originalTitle : Option String := none
  /-- Approximate date of composition. -/
  composed : Option Year := none
  /-- The modern edition this work is cited through, by key. Checked against
  the registry. -/
  editionUsed : Option CiteKey := none
deriving Repr, DecidableEq

/-- A linguistic or textual dataset: BHSA, OSHB, STEPBible. `version` and
`commit` are what make an appeal to the data reproducible. -/
structure DatasetData where
  /-- Fields shared with every entry type. -/
  core : WorkCore
  /-- Released version, without which an appeal to the data is not
  reproducible. -/
  version : Option String := none
  /-- Exact revision, where the dataset lives in version control. -/
  commit : Option String := none
  /-- Licence the data is published under. -/
  license : Option String := none
  /-- Who maintains it. -/
  maintainer : Option String := none
deriving Repr, DecidableEq

/-- A web page. -/
structure WebPageData where
  /-- Fields shared with every entry type. -/
  core : WorkCore
  /-- The site the page belongs to. -/
  site : Option String := none
deriving Repr, DecidableEq

/-- A bibliography entry. -/
inductive BibEntry
  /-- A monograph or commentary. -/
  | book (d : BookData)
  /-- A chapter or essay within an edited volume. -/
  | inCollection (d : InCollectionData)
  /-- A journal article. -/
  | article (d : ArticleData)
  /-- A dissertation or thesis. -/
  | thesis (d : ThesisData)
  /-- A critical edition of a text. -/
  | criticalEdition (d : EditionData)
  /-- An ancient work, cited through a modern edition. -/
  | ancientWork (d : AncientWorkData)
  /-- A linguistic or textual dataset. -/
  | dataset (d : DatasetData)
  /-- A web page. -/
  | webPage (d : WebPageData)
deriving Repr, DecidableEq

/-- The fields common to every entry type. -/
def BibEntry.core : BibEntry → WorkCore
  | .book d => d.core
  | .inCollection d => d.core
  | .article d => d.core
  | .thesis d => d.core
  | .criticalEdition d => d.core
  | .ancientWork d => d.core
  | .dataset d => d.core
  | .webPage d => d.core

/-- The entry's citation key. -/
def BibEntry.key (e : BibEntry) : CiteKey := e.core.key

/-- Whether the entry carries any stable public identifier. An entry for which
this is `false` is rendered as unverified: legal, but visibly so. -/
def BibEntry.isVerifiable (e : BibEntry) : Bool := !e.core.identifiers.isEmpty

/-- The name the bibliography sorts this entry under: first author, else first
editor, else the title. -/
def BibEntry.sortKey (e : BibEntry) : String :=
  let c := e.core.contributors
  match c.authors, c.editors with
  | a :: _, _ => a.sortKey
  | [], ed :: _ => ed.sortKey
  | [], [] => e.core.title

/-- The modern edition an ancient work is cited through, if any. Checked against
the registry so that a dangling reference cannot be committed. -/
def BibEntry.editionUsed : BibEntry → Option CiteKey
  | .ancientWork d => d.editionUsed
  | _ => none

/-- A pinpoint within a cited work. -/
inductive Locus
  /-- The work as a whole. -/
  | whole
  /-- A single page. -/
  | page (n : Nat)
  /-- A contiguous page range. -/
  | pages (start finish : Nat)
  /-- Several discontinuous pages. -/
  | pageList (ns : List Nat)
  /-- A canonical division, e.g. `"Ant. 18.63"` or a section number. Named
  `sectionRef` because `section` is a Lean keyword. -/
  | sectionRef (s : String)
  /-- Commentary on a passage — the `ad loc.` of commentary citation. -/
  | adLoc (p : Passage)
  /-- The critical apparatus at a passage. -/
  | apparatus (p : Passage)
  /-- A lexicon headword — `s.v.`. The almah/parthenos dispute is argued from
  lexicon entries, so this is needed from the outset. -/
  | sv (headword : String)
deriving Repr, DecidableEq

end Testimony.Bib
