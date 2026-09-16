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
  | person (given : String) (family : String) (suffix : Option String := none)
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
  authors : List Agent := []
  editors : List Agent := []
  translators : List Agent := []
deriving Repr, DecidableEq

/-- A year of publication or composition. `value` is negative for BCE dates;
`approximate` marks the `c.` of an uncertain composition date. -/
structure Year where
  value : Int
  approximate : Bool := false
deriving Repr, DecidableEq

/-- A stable public identifier. This is the field that makes a reference
*checkable* by a reader who does not have the book to hand. -/
inductive Identifier
  | doi (s : String)
  | isbn (s : String)
  | issn (s : String)
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
  key : CiteKey
  contributors : Contributors
  title : String
  subtitle : Option String := none
  year : Option Year := none
  identifiers : List Identifier := []
  note : Option String := none
deriving Repr, DecidableEq

/-- A monograph or commentary. -/
structure BookData where
  core : WorkCore
  publisher : String
  place : Option String := none
  edition : Option String := none
  series : Option String := none
  seriesNumber : Option String := none
  volume : Option String := none
  totalVolumes : Option Nat := none
deriving Repr, DecidableEq

/-- A chapter or essay within an edited volume. `core.title` is the chapter
title; `containerTitle` is the volume's. Lexicon entries are cited this way,
with `Locus.sv`. -/
structure InCollectionData where
  core : WorkCore
  containerTitle : String
  containerEditors : List Agent := []
  publisher : String
  place : Option String := none
  edition : Option String := none
  pages : Option (Nat × Nat) := none
deriving Repr, DecidableEq

/-- A journal article. -/
structure ArticleData where
  core : WorkCore
  journal : String
  volume : Option String := none
  issue : Option String := none
  pages : Option (Nat × Nat) := none
deriving Repr, DecidableEq

/-- A dissertation or thesis. `kind` is the degree description, e.g.
`"PhD diss."`. -/
structure ThesisData where
  core : WorkCore
  kind : String
  institution : String
deriving Repr, DecidableEq

/-- A critical edition of a text: NA28, BHS, UBS5. Typed separately from `book`
because it is cited by siglum and apparatus rather than by page, and because its
editors matter more than its author (it has none). -/
structure EditionData where
  core : WorkCore
  publisher : String
  place : Option String := none
  edition : Option String := none
  siglum : Option String := none
deriving Repr, DecidableEq

/-- An ancient work, cited through a modern edition. Scholarly practice cites
Josephus, *Ant.* 18.63, *in* a named Loeb volume; `editionUsed` records which.
The link is by key rather than by value to keep `BibEntry` non-recursive. -/
structure AncientWorkData where
  core : WorkCore
  originalTitle : Option String := none
  composed : Option Year := none
  editionUsed : Option CiteKey := none
deriving Repr, DecidableEq

/-- A linguistic or textual dataset: BHSA, OSHB, STEPBible. `version` and
`commit` are what make an appeal to the data reproducible. -/
structure DatasetData where
  core : WorkCore
  version : Option String := none
  commit : Option String := none
  license : Option String := none
  maintainer : Option String := none
deriving Repr, DecidableEq

/-- A web page. -/
structure WebPageData where
  core : WorkCore
  site : Option String := none
deriving Repr, DecidableEq

/-- A bibliography entry. -/
inductive BibEntry
  | book (d : BookData)
  | inCollection (d : InCollectionData)
  | article (d : ArticleData)
  | thesis (d : ThesisData)
  | criticalEdition (d : EditionData)
  | ancientWork (d : AncientWorkData)
  | dataset (d : DatasetData)
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
  | whole
  | page (n : Nat)
  | pages (start finish : Nat)
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
