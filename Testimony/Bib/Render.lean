import Testimony.Bib.Registry

/-!
# Testimony.Bib.Render — BibTeX and Markdown rendering

Pure functions from entries to text, so that `lake exe bibgen` is a thin shell
around testable code. The `#guard` assertions below are golden tests: they pin
the exact output, and a change to the renderer that alters it fails the build.

BibTeX output is biblatex-flavoured (`@online`, `doi`, `isbn`), which degrades
acceptably under classic BibTeX.
-/

namespace Testimony.Bib

/-- Escape the characters BibTeX and LaTeX treat specially.

Applied to free-text field values, not to structural braces or identifiers. An
unescaped `&` in a note field — "Reprint of the T. & T. Clark translation" —
produces a misplaced-alignment-tab error deep inside the generated `.bbl`,
which is a long way from where a contributor would think to look. -/
def texEscape (s : String) : String :=
  s.foldl (init := "") fun acc c =>
    acc ++ match c with
      | '&' => "\\&" | '%' => "\\%" | '$' => "\\$"
      | '#' => "\\#" | '_' => "\\_"
      | c => c.toString

/-- Render a year, marking approximate dates with `c.` and negative years BCE. -/
def renderYear (y : Year) : String :=
  let n := if y.value < 0 then toString (-y.value) ++ " BCE" else toString y.value
  if y.approximate then "c. " ++ n else n

/-- A name in BibTeX form: `Family, Given` for people, braced for
organisations so BibTeX does not treat them as a personal name. -/
def agentBibtex : Agent → String
  | .person given family suffix =>
    let base := texEscape family ++ ", " ++ texEscape given
    match suffix with
    | some s => base ++ ", " ++ texEscape s
    | none => base
  | .corporate name => "{" ++ texEscape name ++ "}"

/-- A name for display: `Given Family`. -/
def agentDisplay : Agent → String
  | .person given family suffix =>
    let base := given ++ " " ++ family
    match suffix with
    | some s => base ++ " " ++ s
    | none => base
  | .corporate name => name

/-- BibTeX joins names with ` and `. -/
def agentsBibtex (as : List Agent) : String := String.intercalate " and " (as.map agentBibtex)

/-- Display several names, comma-separated. -/
def agentsDisplay (as : List Agent) : String :=
  String.intercalate ", " (as.map agentDisplay)

/-- The BibTeX field name and value for an identifier. -/
def identifierBibtex : Identifier → String × String
  | .doi s => ("doi", s)
  | .isbn s => ("isbn", s)
  | .issn s => ("issn", s)
  | .oclc s => ("oclc", s)
  | .url s _ => ("url", s)
  | .archived s => ("url", s)

/-- An identifier for display, as a Markdown link where one resolves. -/
def identifierMarkdown (i : Identifier) : String :=
  let label :=
    match i with
    | .doi s => "DOI " ++ s
    | .isbn s => "ISBN " ++ s
    | .issn s => "ISSN " ++ s
    | .oclc s => "OCLC " ++ s
    | .url s _ => s
    | .archived s => "archived: " ++ s
  match i.uri with
  | some u => "[" ++ label ++ "](" ++ u ++ ")"
  | none => label

/-- The BibTeX entry type for each variant. -/
def entryType : BibEntry → String
  | .book _ => "book"
  | .inCollection _ => "incollection"
  | .article _ => "article"
  | .thesis d => if d.kind.startsWith "PhD" then "phdthesis" else "mastersthesis"
  | .criticalEdition _ => "book"
  | .ancientWork _ => "misc"
  | .dataset _ => "misc"
  | .webPage _ => "online"

/-- Render one `name = {value}` line, or nothing when the value is absent. -/
def field (name : String) : Option String → List String
  | none => []
  | some v => ["  " ++ name ++ " = {" ++ v ++ "}"]

/-- Fields common to every entry, derived from `WorkCore`. -/
def coreFields (c : WorkCore) : List String :=
  let title := texEscape (match c.subtitle with
    | some s => c.title ++ ": " ++ s
    | none => c.title)
  field "author" (if c.contributors.authors.isEmpty then none
                  else some (agentsBibtex c.contributors.authors))
  ++ field "editor" (if c.contributors.editors.isEmpty then none
                     else some (agentsBibtex c.contributors.editors))
  ++ field "translator" (if c.contributors.translators.isEmpty then none
                         else some (agentsBibtex c.contributors.translators))
  ++ field "title" (some title)
  ++ field "year" (c.year.map renderYear)
  ++ (c.identifiers.flatMap fun i =>
        let (n, v) := identifierBibtex i
        field n (some v))
  ++ field "note" (c.note.map texEscape)

/-- The fields particular to each entry variant. -/
def variantFields : BibEntry → List String
  | .book d =>
    field "publisher" (some (texEscape d.publisher))
    ++ field "address" (d.place.map texEscape)
    ++ field "edition" (d.edition.map texEscape)
    ++ field "series" (d.series.map texEscape)
    ++ field "number" (d.seriesNumber.map texEscape)
    ++ field "volume" (d.volume.map texEscape)
  | .inCollection d =>
    field "booktitle" (some (texEscape d.containerTitle))
    ++ field "editor" (if d.containerEditors.isEmpty then none
                       else some (agentsBibtex d.containerEditors))
    ++ field "publisher" (some (texEscape d.publisher))
    ++ field "address" (d.place.map texEscape)
    ++ field "edition" (d.edition.map texEscape)
    ++ field "pages" (d.pages.map fun (a, b) => toString a ++ "--" ++ toString b)
  | .article d =>
    field "journal" (some (texEscape d.journal)) ++ field "volume" d.volume
    ++ field "number" d.issue
    ++ field "pages" (d.pages.map fun (a, b) => toString a ++ "--" ++ toString b)
  | .thesis d =>
    field "school" (some (texEscape d.institution))
    ++ field "type" (some (texEscape d.kind))
  | .criticalEdition d =>
    field "publisher" (some (texEscape d.publisher))
    ++ field "address" (d.place.map texEscape)
    ++ field "edition" (d.edition.map texEscape)
    ++ field "note" (d.siglum.map fun s => "siglum: " ++ texEscape s)
  | .ancientWork d =>
    field "howpublished" (d.originalTitle.map texEscape)
    ++ field "note" (d.composed.map fun y => "composed " ++ renderYear y)
    ++ field "crossref" d.editionUsed
  | .dataset d =>
    field "version" d.version ++ field "note" (d.commit.map fun c => "commit " ++ c)
    ++ field "howpublished" (d.maintainer.map texEscape)
  | .webPage d => field "organization" (d.site.map texEscape)

/-- One entry in BibTeX form. -/
def toBibtex (e : BibEntry) : String :=
  let fields := coreFields e.core ++ variantFields e
  "@" ++ entryType e ++ "{" ++ e.key ++ ",\n"
    ++ String.intercalate ",\n" fields ++ "\n}"

/-- The whole bibliography as a `.bib` file. -/
def bibtexFile (es : List BibEntry) : String :=
  "% Generated by `lake exe bibgen`. Do not edit by hand.\n" ++
  "% Source of truth: Testimony/Bib/Works.lean\n\n" ++
  String.intercalate "\n\n" (es.map toBibtex) ++ "\n"

/-- One entry as a Markdown bibliography line. Entries with no stable public
identifier are marked, so an unverifiable reference is visibly so. -/
def toMarkdown (e : BibEntry) : String :=
  let c := e.core
  let who :=
    if !c.contributors.authors.isEmpty then agentsDisplay c.contributors.authors ++ ". "
    else if !c.contributors.editors.isEmpty then
      agentsDisplay c.contributors.editors ++ " (ed.). "
    else ""
  let title := match c.subtitle with
    | some s => c.title ++ ": " ++ s
    | none => c.title
  let trans :=
    if c.contributors.translators.isEmpty then ""
    else " Translated by " ++ agentsDisplay c.contributors.translators ++ "."
  let year := match c.year with
    | some y => " " ++ renderYear y ++ "."
    | none => ""
  let ids :=
    if c.identifiers.isEmpty then " *(no public identifier)*"
    else " " ++ String.intercalate ", " (c.identifiers.map identifierMarkdown) ++ "."
  let note := match c.note with
    | some n => " " ++ n
    | none => ""
  "- **`" ++ c.key ++ "`** — " ++ who ++ "*" ++ title ++ "*." ++ trans ++ year ++ ids ++ note

/-- The whole bibliography as a Markdown chapter, sorted by author family
name. -/
def bibliographyMarkdown (es : List BibEntry) : String :=
  let sorted := (es.toArray.qsort fun a b => decide (a.sortKey < b.sortKey)).toList
  let unverified := (es.filter fun e => !e.isVerifiable).length
  "<!-- Generated by `lake exe bibgen`. Do not edit by hand. -->\n" ++
  "<!-- Source of truth: Testimony/Bib/Works.lean -->\n\n" ++
  "# Bibliography\n\n" ++
  "Every work cited anywhere in the library, generated from the Lean source.\n" ++
  "Machine-readable BibTeX is at [`references.bib`](" ++
  "https://github.com/deanberris/testimony/blob/main/references.bib).\n\n" ++
  s!"{es.length} entries, of which {unverified} carry no stable public identifier.\n\n" ++
  String.intercalate "\n" (sorted.map toMarkdown) ++ "\n"

/-! ### Golden tests

These pin the exact rendered output. A renderer change that alters it fails the
build rather than silently rewriting `references.bib`. -/

#guard agentBibtex (.person "R. T." "France") == "France, R. T."
#guard agentBibtex (.corporate "United Bible Societies") == "{United Bible Societies}"
#guard agentDisplay (.person "R. T." "France") == "R. T. France"
#guard renderYear { value := 2007 } == "2007"
#guard renderYear { value := -250, approximate := true } == "c. 250 BCE"
#guard entryType franceMatthew == "book"
#guard entryType benzmullerGodel == "incollection"
#guard entryType na28 == "book"
#guard entryType bhsaDataset == "misc"
#guard entryType oshbDataset == "misc"

#guard toBibtex franceMatthew ==
  "@book{france-matthew-2007,\n" ++
  "  author = {France, R. T.},\n" ++
  "  title = {The Gospel of Matthew},\n" ++
  "  year = {2007},\n" ++
  "  isbn = {9780802825018},\n" ++
  "  publisher = {Wm. B. Eerdmans},\n" ++
  "  address = {Grand Rapids},\n" ++
  "  series = {New International Commentary on the New Testament}\n}"

-- The `&` in the note field must survive as `\\&`, or the generated .bbl
-- breaks with a misplaced-alignment-tab error.
#guard ((toBibtex keilDelitzschMinorProphets).splitOn "T. \\& T. Clark").length == 2

#guard toMarkdown motyerIsaiah ==
  "- **`motyer-isaiah-1993`** — J. Alec Motyer. " ++
  "*The Prophecy of Isaiah: An Introduction and Commentary*. 1993." ++
  " *(no public identifier)*"

end Testimony.Bib
