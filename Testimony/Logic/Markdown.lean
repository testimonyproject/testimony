import Testimony.Logic.Latex
import Testimony.Logic.Page

/-!
# Testimony.Logic.Markdown — arguments as Markdown, with typeset notation

`Testimony.Logic.Latex` renders a package for a printed page. This module
renders the same package for the documentation site, where the notation is
typeset in the browser by MathJax and the prose around it is Markdown.

The notation is not written twice. `Latex.formula` already produces what both
media want — `P_{2} \land P_{3} \rightarrow P_{13}` is what MathJax reads too —
so this module reuses it and supplies only what differs: Markdown tables
instead of `longtable`, an author and year linked to the bibliography instead of
`\cite`, and delimiters MathJax recognises. What a derivation says in words is
not written twice either: both renderers say it through `Latex.inWordsWith`.

## One legend for the page

The LaTeX renderer numbers atoms per package, because a printed argument is
read one package at a time. A generated page is not: it sets four positions,
three objections and the variants that test them side by side, and a reader
comparing two of them needs `P_{9}` to mean the same claim in both. So the
numbering here is fixed once for the whole page, from the atoms every item on
it mentions, and the legend is given once at the top.

## Why a derivation is a list inside a `<div>`

mdBook runs Markdown over the page before MathJax sees it, and a display
environment is full of the characters Markdown eats: `\\` opens a new row in
`aligned` and is Markdown's escape character, and a missed pair of them does not
error, it just renders as text. So the site sets no display mathematics. A
derivation is a Markdown list, one row to an item, each formula inline and each
followed by its claims in the legend's words, as print sets it; it wraps on a
narrow screen where a display would run off the side.

The list sits in a `<div>` the stylesheet sets it by, with a blank line inside
each end of it. CommonMark passes an HTML block through untouched only as far
as the first blank line, so those blank lines are what hand the list back to
the Markdown parser.

Inline math is written the way mdBook documents: `\\(` in the source survives
the Markdown pass as `\(`. A variable is a link, `\href{#claim-3}{P_{3}}`, to
its row in the legend, which MathJax renders as a link.
-/

namespace Testimony.Logic.Markdown

open Testimony Testimony.Bib Testimony.Logic.Page

variable {α : Type}

/-! ### Text -/

/-- Collapse whitespace runs to single spaces, so a label or a pretty-printed
statement fits one Markdown table cell. -/
def oneLine (s : String) : String :=
  String.intercalate " " ((s.replace "\n" " ").splitOn " " |>.filter (· ≠ ""))

/-- Escape what a Markdown table cell cannot carry. -/
def cell (s : String) : String := (oneLine s).replace "|" "\\|"

/-- Replace the block of `doc` between `beginMarker` and `endMarker` with
`body`, or report why it could not be found. A missing marker is an error
rather than an append: the page decides where the block goes. `body` is placed
verbatim after a blank line, so a caller that wants one before the closing
marker supplies it. -/
def splice (beginMarker endMarker doc body : String) : Except String String :=
  match doc.splitOn beginMarker with
  | [before, rest] =>
    match rest.splitOn endMarker with
    | [_, after] =>
      .ok (before ++ beginMarker ++ "\n\n" ++ body ++ endMarker ++ after)
    | parts =>
      .error s!"expected exactly one {endMarker}, found {parts.length - 1}"
  | parts => .error s!"expected exactly one {beginMarker}, found {parts.length - 1}"

/-- Escape the characters Markdown reads as formatting.

Atom labels, cite loci and scripture references are prose written for a reader,
not Markdown: an underscore in a transliteration must reach the page as itself.
Docstrings are deliberately *not* put through this — they are written as
Markdown on purpose, and rendering them is what the generated pages are for. -/
def escape (s : String) : String :=
  s.foldl (init := "") fun acc c =>
    acc ++ match c with
      | '\\' => "\\\\" | '`' => "\\`" | '*' => "\\*" | '_' => "\\_"
      | '[' => "\\[" | ']' => "\\]" | '|' => "\\|"
      | '<' => "&lt;" | '>' => "&gt;" | '&' => "&amp;"
      | c => c.toString

/-- Whether a line opens or closes a fenced code block. -/
private def isFence (line : String) : Bool :=
  (line.dropWhile (· == ' ')).startsWith "```"

/-- Push every ATX heading in a block of Markdown down one level, stopping at
`######`, which is as deep as Markdown goes.

Module docstrings are written as though each were the top of its own page: they
open with `# TestimonyArguments.SolaScriptura.Lines — …` and use `##` and `###` beneath
it. A generated page carries several of them under a title of its own, so each
one is demoted to sit under that title rather than beside it.

Fenced blocks are skipped, so a `#` that is a comment in a shell example stays
a comment. -/
def demote (md : String) : String :=
  let step := fun (acc, inFence) (line : String) =>
    if isFence line then (acc ++ [line], !inFence)
    else if inFence || !line.startsWith "#" then (acc ++ [line], inFence)
    else if line.startsWith "######" then (acc ++ [line], inFence)
    else (acc ++ ["#" ++ line], inFence)
  let (lines, _) := (md.splitOn "\n").foldl step (([] : List String), false)
  String.intercalate "\n" lines

/-! ### Math -/

/-- An inline formula, written so that Markdown's escaping pass leaves MathJax
the `\(…\)` it looks for. -/
def inlineMath (body : String) : String := "\\\\(" ++ body ++ "\\\\)"

/-- The anchor a legend row carries for its claim. A page holds one legend, so the
number alone names the row. -/
def claimAnchor (i : Nat) : String := "claim-" ++ toString (i + 1)

/-- A propositional variable as a link to its row in the legend, as print links
it. MathJax's `\href` takes a bare fragment, so the link stays within the page. -/
def varLink (i : Nat) : String :=
  "\\href{#" ++ claimAnchor i ++ "}{" ++ Latex.varName i ++ "}"

/-- A formula with each variable linked to its legend row, as in print. -/
def formula [DecidableEq α] (order : List α) (φ : Formula α) : String :=
  Latex.formulaPrec varLink order 0 φ

/-- A derivation's words in the legend's: `Latex.inWordsWith`, set for the site, so
the site says what print says. A variable links to its legend row, a label is
escaped, and the mark is in italics. -/
def inWords [DecidableEq α] (order : List α) (cite : α → AtomMeta) (lead : Latex.Lead)
    (φ : Formula α) : Option String :=
  Latex.inWordsWith (fun a => inlineMath (varLink (order.idxOf a)))
    (fun a => escape (cite a).label) (fun s => "*" ++ s ++ ":* ") lead φ

/-- One row of a derivation: its label, its formula, and the formula's words after
a dash where there are any. -/
def derivationRow [DecidableEq α] (order : List α) (label : String) (φ : Formula α)
    (words : Option String) : String :=
  "- " ++ (if label.isEmpty then "" else label ++ " ") ++ inlineMath (formula order φ) ++
    (match words with | some w => " — " ++ w | none => "") ++ "\n"

/-- Rows of a derivation, as a list inside the `<div>` the stylesheet sets it by.

A list rather than an `aligned` display, as print sets a list rather than an
`align*`, so that the words can wrap: a claim's label can run to a line of its
own, which a display formula would push off the side of a phone. Each formula
is inline, so it needs no `\\` and the list is ordinary Markdown; the blank
lines inside the `<div>` are what hand it back to the Markdown parser. -/
def derivationRows (rows : List String) : String :=
  "<div class=\"testimony-derivation\">\n\n" ++ String.join rows ++ "\n</div>\n"

/-- The label of numbered row `i`. -/
def rowLabel (i : Nat) : String := "(" ++ toString (i + 1) ++ ")"

/-- Numbered premises above a turnstile, each with its words where
`Latex.glossWith` gives them, and on the turnstile row the conclusion at issue.
Without a legend (`cite` is `none`) nothing is glossed.

The order is the order the encoding puts them in, which for a package built by
`caseOf` is every line's grounds first and every line's inference step last —
the order a reader checks an argument in. -/
def derivation [DecidableEq α] (order : List α) (cite : Option (α → AtomMeta))
    (prems : List (Formula α)) (concl : Formula α) : String :=
  let words (c : α → AtomMeta) := inWords order c
  derivationRows <|
    prems.zipIdx.map (fun (φ, i) => derivationRow order (rowLabel i) φ
      (cite.bind fun c => Latex.glossWith (words c) (some concl) φ)) ++
    [derivationRow order (inlineMath "\\vdash") concl
      (cite.bind fun c => words c .atIssue concl)]

/-! ### Citations -/

/-- A pinpoint, as a reader reads it rather than as `\cite` takes it. -/
def locus : Locus → String
  | .whole => ""
  | .page n => "p. " ++ toString n
  | .pages a b => "pp. " ++ toString a ++ "–" ++ toString b
  | .pageList ns => "pp. " ++ String.intercalate ", " (ns.map toString)
  | .sectionRef s => "§" ++ escape s
  | .adLoc p => "ad loc. " ++ escape p.render
  | .apparatus p => "app. " ++ escape p.render
  | .sv w => "s.v. " ++ escape w

/-- Where the generated pages sit relative to the bibliography chapter. -/
def bibliographyPath : String := "../bibliography.md"

/-- The family names a citation is made under: the authors, else the editors,
else the title. Two names are joined by "and"; three or more are cut to the
first and "et al.". -/
def citedNames (e : BibEntry) : String :=
  let c := e.core.contributors
  let names := (if c.authors.isEmpty then c.editors else c.authors).map Agent.sortKey
  match names with
  | [] => e.core.title
  | [a] => a
  | [a, b] => a ++ " and " ++ b
  | a :: _ => a ++ " et al."

/-- A work's year as a citation gives it: "c." where approximate, "BC" where
negative, and nothing where the entry has none. -/
def citedYear (e : BibEntry) : String :=
  match e.core.year with
  | none => ""
  | some y =>
      (if y.approximate then "c. " else "") ++
        (if y.value < 0 then toString y.value.natAbs ++ " BC" else toString y.value)

/-- A work as a reader reads it: author and year, such as "Calvin 1960". -/
def citedWork (e : BibEntry) : String :=
  let y := citedYear e
  escape (citedNames e) ++ (if y.isEmpty then "" else " " ++ y)

/-- A reference. Scripture renders as the passage; a work renders as its author
and year, linked to its entry in the bibliography — `Bib.Render.toMarkdown` puts
an anchor of the entry's cite key on every line — and a proposal is marked as
the library's own construction. -/
def reference : Reference → String
  | .scripture refs =>
      String.intercalate "; " (refs.map fun r => escape r.render)
  | .work e l =>
      let link := "[" ++ citedWork e ++ "](" ++ bibliographyPath ++ "#" ++ e.key ++ ")"
      let loc := locus l
      if loc.isEmpty then link else link ++ ", " ++ loc
  | .proposal r => "*proposed:* " ++ escape r

/-- Every reference a source rests on. -/
def source (s : Source) : String :=
  String.intercalate "; " (s.references.map reference)

/-- Which interpretive tradition advances a claim, worded as print words it. -/
def tradition : Tradition → String := Latex.tradition

/-- How firmly that tradition holds it. -/
def confidence : Confidence → String
  | .refuted => "refuted"
  | .disputed => "disputed"
  | .plausible => "plausible"
  | .wellSupported => "well supported"
  | .consensus => "consensus"

/-- How a premise is classified. -/
def kind : PremiseKind → String
  | .textual => "textual" | .linguistic => "linguistic"
  | .historical => "historical" | .theological => "theological"
  | .interpretive => "interpretive" | .empirical => "empirical"

/-- The legend: one row per atom, giving the claim it stands for, how it is
classified, who holds it and where they say so. This is the assumption manifest
of the whole page.

The wrapping `<div>` is what the stylesheet hangs the column widths on, and the
blank line after it is load-bearing: it closes the HTML block, so the table
inside is read as Markdown rather than passed through as raw HTML. -/
def legend (cite : α → AtomMeta) (order : List α) : String :=
  let rows := order.zipIdx.map fun (a, i) =>
    let m := cite a
    let mark := if m.readsScriptureAlone then " ※" else ""
    "| <a id=\"" ++ claimAnchor i ++ "\"></a>" ++ inlineMath (Latex.varName i) ++ " | " ++
      cell (escape m.label) ++ mark ++ " | " ++ kind m.kind ++ " | " ++
      tradition m.source.tradition ++ ", " ++ confidence m.source.confidence ++ " | " ++
      cell (source m.source) ++ " |"
  "<div class=\"testimony-legend\">\n\n" ++
  "| | claim | kind | held | source |\n|---|---|---|---|---|\n" ++
  String.intercalate "\n" rows ++ "\n\n</div>\n\n" ++
  (if order.any fun a => (cite a).readsScriptureAlone then
    "※ a reading cited to the text alone, with no commentator: it is assumed here, " ++
    "not argued for.\n"
  else "")

/-! ### The page -/

/-- The label a declaration is introduced by: an anchor to link to, then its
name, then whatever the item wants said beside it.

Declarations are deliberately not headings. A generated page's heading
structure is the prose's own — the module docstrings decide what the sections
are — and a heading per declaration would bury that under sixty entries of
scaffolding. The anchor is what a link needs; the rest is a label. -/
def declLabel (d : String) (suffix : String) : String :=
  "<a id=\"" ++ d ++ "\"></a>\n**`" ++ d ++ "`**" ++ suffix ++ "\n"


/-- A fenced block of Lean, for the declarations that are read as code rather
than as notation. -/
def leanBlock (body : String) : String := "```lean\n" ++ body ++ "\n```\n"

/-- The formulas of a list, inline and joined. -/
def inlineFormulas [DecidableEq α] (order : List α) (φs : List (Formula α)) : String :=
  String.intercalate ", " (φs.map fun φ => inlineMath (formula order φ))

/-- One claim an explanation rests on: its number, what it says, how firmly it
is held and by whom. -/
def restingClaim [DecidableEq α] (order : List α) (cite : α → AtomMeta) (a : α) : String :=
  let m := cite a
  "  - " ++ inlineMath (varLink (order.idxOf a)) ++ " " ++ escape m.label ++ " — *" ++
    confidence m.source.confidence ++ "*: " ++ source m.source

/-- Why one position stands against another, as a list a reader can check line
by line against the theorems it summarises. -/
def explanation [DecidableEq α] (order : List α) (e : Page.Explanation α) : String :=
  let given := if e.granted.isEmpty then "" else " and " ++ inlineFormulas order e.granted
  "**Why *" ++ escape e.holder ++ "* stands against *" ++ escape e.rival ++ "*.**\n\n" ++
  "- **The crux:** " ++ inlineMath (formula order e.crux) ++ ", a premise of *" ++
    escape e.holder ++ "*.\n" ++
  "- **What it does:** " ++
    (if e.derives then "its conclusion does not follow without it."
     else "its conclusion follows without it — the crux is its answer to *" ++
       escape e.rival ++ "*.") ++ "\n" ++
  (if e.granted.isEmpty then "" else
    "- **Granted:** " ++ inlineFormulas order e.granted ++
    ", which the break also needs.\n") ++
  "- **Where the rival breaks:** " ++ inlineFormulas order e.core ++
    " cannot be held together with " ++ inlineMath (formula order e.crux) ++ given ++
    "; each is needed for the break, and without the crux they stand.\n" ++
  "- **What this rests on:**\n" ++
    String.intercalate "\n" (e.restsOn.map (restingClaim order e.cite)) ++
    (if Page.Explanation.isLiteral e.crux then "" else
      "\n  - the step itself — " ++
      (match e.rating with
       | some s => "*" ++ confidence s.confidence ++ "*: " ++ source s
       | none =>
         if e.inferences.isEmpty then "*unrated*" else
           "*not rated on its own*. These ratings are for the steps of *" ++
           escape e.holder ++ "* together, not for this one: " ++
           String.intercalate "; " (e.inferences.map fun s =>
             "*" ++ confidence s.confidence ++ "*: " ++ source s))) ++ "\n"

/-- Every reading of a rival's claim, answered: each horn with what the claim
commits the rival to, who reads it that way, and what happens to it against
each position — the explanation where it cannot be held, and a sentence where
it is not reached. -/
def dilemma [DecidableEq α] (order : List α) (d : Page.Dilemma α) : String :=
  let claim := inlineMath (formula order d.claim)
  let fate (f : Page.Fate α) : String := match f.falls with
    | some e =>
      "Against *" ++ escape f.against ++ "*, it cannot be held. Where it breaks:\n\n" ++
        explanation order e
    | none =>
      "Against *" ++ escape f.against ++ "*, it is not reached: *" ++ escape f.against ++
        "* holds, and can be held together with it.\n"
  "**Every reading of " ++ claim ++ ", answered.** *" ++ escape d.rival ++ "* holds " ++
    claim ++ ". It is read " ++ toString d.horns.length ++
    (if d.horns.length == 1 then " way" else " ways") ++
    " here, and each reading is checked; none can be left out.\n\n" ++
  String.intercalate "\n" (d.horns.zipIdx.map fun (h, k) =>
    "**" ++ toString (k + 1) ++ ". Read " ++ escape h.reading ++ ".** The claim commits *" ++
      escape d.rival ++ "* to " ++ inlineMath (formula order h.commits) ++
      " — so read by " ++ source h.source ++ " (*" ++ confidence h.source.confidence ++
      "*)." ++
      (if h.grounds.isEmpty then "" else
        " It rests the reading on " ++ inlineFormulas order h.grounds ++ ".") ++ "\n\n" ++
    String.intercalate "\n" (h.fates.map fate))

/-- What an opponent must reject: every minimal set of readings whose
rejection overturns the case, each reading with its rating, and the readings no
set needs. -/
def burden (b : Page.Burden) : String :=
  let reading (i : Nat) : String := match b.readings[i]? with
    | some (n, some s) => "*" ++ escape n ++ "* (" ++ confidence s.confidence ++ ")"
    | some (n, none) => "*" ++ escape n ++ "* (unrated)"
    | none => "reading " ++ toString i
  let spare := b.spare
  "**What an opponent must reject.** *" ++ escape b.holder ++ "* concludes that " ++
    escape b.conclusion ++ ". That conclusion is overturned exactly when every " ++
    "reading in one of these sets is rejected. Each set is minimal, and no other " ++
    "rejection overturns it:\n\n" ++
  String.join (b.sets.zipIdx.map fun (S, k) =>
    toString (k + 1) ++ ". " ++ String.intercalate "; " (S.map reading) ++ "\n") ++
  (if spare.isEmpty then "" else
    "\nNo set contains " ++ String.intercalate ", " (spare.map fun n => "*" ++ escape n ++ "*") ++
    ": an opponent never needs to reject it.\n")

/-- One piece of a generated sentence. A defeat that a `Because` on the page
explains links its verb to it. -/
def seg (links : List Page.BecauseLink) : Page.Seg → String
  | .text t => escape t
  | .party n => "*" ++ escape n ++ "*"
  | .defeat a b =>
    let verb := match Page.becauseFor links a b with
      | some d => "[defeats](#" ++ d ++ ")"
      | none => "defeats"
    "*" ++ escape a ++ "* " ++ verb ++ " *" ++ escape b ++ "*"

/-- The last component of a declaration's name: what its label on a page is. -/
def shortName (n : String) : String := ((n.splitOn ".").getLast?).getD n

/-- An exchange, told: each turn's paragraph under its party's name, then the
sentence that joins it to the turn it names, as the solver found it, and what the
line it quotes declares; then how the parties stand to one another, in a
paragraph, with a table as well when there are many of them. -/
def exchange (links : List Page.BecauseLink) (x : Page.Exchange) : String :=
  let segs (ss : List Page.Seg) : String := String.join (ss.map (seg links))
  let turn (t : Page.ExchangeTurn) : String :=
    let quoted := if t.quoting.isEmpty then "" else
      "It quotes [`" ++ shortName t.quoting ++ "`](#" ++ shortName t.quoting ++ "). "
    let joined := segs (Page.Exchange.connective t ++
      (if t.relation.isEmpty || t.findings.isEmpty then [] else [.text " "]) ++
      Page.Exchange.declared t)
    let after := (quoted ++ joined).trimAscii.toString
    let from_ := if t.source.isEmpty then ".**" else
      "** (*" ++ escape t.source ++ "*" ++ (if t.year.isEmpty then "" else ", " ++ t.year) ++ ")."
    "**" ++ escape t.party ++ from_ ++ " " ++
      t.doc ++ "\n\n" ++
      (if after.isEmpty then "" else after ++ "\n\n")
  let ps := x.parties
  let table := if ps.length ≤ Page.Exchange.manyParties then "" else
    let names (l : List String) : String :=
      if l.isEmpty then "—" else String.intercalate ", " (l.map fun n => "*" ++ escape n ++ "*")
    "| Position | Defeats | Is defeated by |\n|---|---|---|\n" ++
    String.join (ps.map fun a =>
      let beats := x.pairs.filterMap fun (p, q, pq, qp) =>
        if p == a && pq then some q else if q == a && qp then some p else none
      let beaten := x.pairs.filterMap fun (p, q, pq, qp) =>
        if p == a && qp then some q else if q == a && pq then some p else none
      "| *" ++ escape a ++ "* | " ++ names beats ++ " | " ++ names beaten ++ " |\n") ++ "\n"
  let summary := Page.Exchange.summary x
  String.join (x.turns.map turn) ++
    (if summary.isEmpty then "" else segs summary ++ "\n\n") ++ table

/-- What a verdict rests on, for a reader: that each reason is an entry of the
table of who defeats whom, what defeat turns on, every party involved where it
is weakest, and which defeats a `Because` explains claim by claim. -/
def restsOn (v : Page.Verdict) (links : List Page.BecauseLink) (table : String) : String :=
  let tableRef := if table.isEmpty then "the defeat table"
    else "[`" ++ table ++ "`](#" ++ table ++ ")"
  let explained := (v.cells.filterMap fun (a, b, d) =>
    if d then (Page.becauseFor links a b).map (a, b, ·) else none)
  let held (h : Page.Held) : String :=
    "  - " ++ escape h.what ++ " — " ++ source h.source ++ "\n"
  let reading (r : Page.Reading) : String :=
    match r.weakest with
    | [] => "- *" ++ escape r.party ++ "*: none of its claims is rated.\n"
    | h :: _ =>
      "- *" ++ escape r.party ++ "*, held as *" ++ confidence h.confidence ++
      "* at its weakest, at:\n" ++ String.join (r.weakest.map held)
  "\n**Why.** Each reason above is one entry in the table of who defeats whom (" ++
  tableRef ++ "), worked out from what each position claims and checked by the computer " ++
  "when the library is built. One position defeats another when it denies something the " ++
  "other rests on and, where it is weakest, is held at least as firmly as what it denies; " ++
  "so if a claim were rated differently, the verdict could change. Where each position is " ++
  "weakest:\n\n" ++
  String.join (v.readings.map reading) ++
  String.join (explained.map fun (a, b, d) =>
    "\nWhy *" ++ escape a ++ "* defeats *" ++ escape b ++ "*, claim by claim, is set out at [`" ++
    d ++ "`](#" ++ d ++ ").\n")

/-- A verdict: its claim in bold, then its reasons as a nested list, then what
they rest on. -/
def verdict (v : Page.Verdict) (links : List Page.BecauseLink) (table : String) : String :=
  let line (segs : List Page.Seg) := String.join (segs.map (seg links))
  "**" ++ line v.claim ++ "**\n\n" ++
  String.join (v.reasons.map fun (d, segs) =>
    String.join (List.replicate d "  ") ++ "- " ++ line segs ++ "\n") ++
  restsOn v links table

/-- A coordinate, rounded to a whole pixel. -/
def px (x : Float) : String := toString x.round.toUInt64.toNat

/-- Text for an HTML element: the three characters HTML reserves. -/
def html (s : String) : String :=
  s.foldl (init := "") fun acc c =>
    acc ++ match c with
      | '<' => "&lt;" | '>' => "&gt;" | '&' => "&amp;" | '"' => "&quot;"
      | c => c.toString

/-- **A truth table, set out** (`Latex.tableWords`): a column for each claim,
one for each test, whether the row is allowed, and one for each statement that
follows, shaded. Each row has an anchor, `decl-row-k`, so prose after the table
can link "row 5" to it. Each test and statement is said in words under the
table, with what a test rests on.

The table is a raw HTML block, which Markdown passes through only up to the
first blank line; it therefore contains none. -/
def table (d : String) (t : Page.TableView) : String :=
  let yn (b : Bool) := if b then "Yes" else "No"
  let mark (b : Bool) :=
    if b then "<span class=\"kept\">✓</span>" else "<span class=\"broken\">✗</span>"
  let cls (c : Page.TableColumnView) (base : String) :=
    " class=\"" ++ base ++ (if c.proposed then " proposed" else "") ++ "\""
  let anchorOf (k : Nat) := d ++ "-col-" ++ toString k
  let head (c : Page.TableColumnView) (k : Nat) (base : String) :=
    "<th" ++ cls c base ++ "><a href=\"#" ++ anchorOf k ++ "\">" ++ html c.label ++
      "</a><br><span class=\"formula\">" ++ html c.formula ++ "</span></th>"
  let nt := t.tests.length
  let nf := t.follows.length
  let cols := t.tests.map (·, "test") ++ t.follows.map (·, "follows")
  let numbered := cols.zip (List.range cols.length)
  "<div class=\"testimony-table\">\n<table>\n<thead>\n<tr><th rowspan=\"2\">Row</th>" ++
  String.join (t.claims.map fun (h, l) =>
    "<th rowspan=\"2\">" ++ html h ++ "<br><i>" ++ html l ++ "</i></th>") ++
  "<th colspan=\"" ++ toString nt ++ "\" class=\"group\">Tests</th>" ++
  "<th rowspan=\"2\">Allowed</th>" ++
  (if nf == 0 then "" else
    "<th colspan=\"" ++ toString nf ++ "\" class=\"group follows\">What follows</th>") ++
  "</tr>\n<tr>" ++
  String.join (numbered.map fun ((c, base), k) => head c k base) ++ "</tr>\n</thead>\n<tbody>\n" ++
  String.join ((t.rows.zip (List.range t.rows.length)).map fun ((cs, ts, ok, fs), k) =>
    "<tr id=\"" ++ d ++ "-row-" ++ toString (k + 1) ++ "\"" ++
      (if ok then "" else " class=\"struck\"") ++ "><td>" ++ toString (k + 1) ++ "</td>" ++
      String.join (cs.map fun b => "<td>" ++ yn b ++ "</td>") ++
      String.join ((ts.zip t.tests).map fun (b, c) =>
        "<td" ++ cls c "test" ++ ">" ++ mark b ++ "</td>") ++
      "<td class=\"allowed\">" ++ yn ok ++ "</td>" ++
      String.join (fs.map fun b =>
        "<td class=\"follows\">" ++ (if b then "true" else "false") ++ "</td>") ++
      "</tr>\n") ++
  "</tbody>\n</table>\n</div>\n\n" ++
  String.join (numbered.map fun ((c, _), k) =>
    "- <a id=\"" ++ anchorOf k ++ "\"></a>" ++ escape c.label ++ " **" ++ c.words ++ "**" ++
      (match c.source with
       | some s => " " ++ source s ++ "."
       | none => "") ++ "\n") ++
  "\n"

/-- A dispute's graph drawn as an inline SVG: the parties numbered on a circle,
defeats as solid arrows, supports as dashed ones. Each edge bends a little to
its left, so a mutual defeat is two arrows rather than one line.

The SVG is a raw HTML block, which Markdown passes through only up to the first
blank line; it therefore contains none. -/
def graphSvg (g : Page.Graph) : String :=
  let n := g.nodes.length
  let c := 200.0
  let radius := 150.0
  let node := 15.0
  let at' (k : Nat) := let (x, y) := Page.Graph.position n k; (c + radius * x, c - radius * y)
  let edge (i j : Nat) (kind : Page.EdgeKind) : String :=
    let (x1, y1) := at' i
    let (x2, y2) := at' j
    let dx := x2 - x1
    let dy := y2 - y1
    let len := Float.sqrt (dx * dx + dy * dy)
    let ux := dx / len
    let uy := dy / len
    let sx := x1 + ux * node
    let sy := y1 + uy * node
    let ex := x2 - ux * (node + 3)
    let ey := y2 - uy * (node + 3)
    let cx := (sx + ex) / 2 - uy * 18
    let cy := (sy + ey) / 2 + ux * 18
    let style := match kind with
      | .defeat => "stroke:#b3261e;fill:none;stroke-width:1.6\" marker-end=\"url(#tm-defeat)"
      | .partOf => "stroke:#1f5fa8;fill:none;stroke-width:1.6;stroke-dasharray:1.5 3\" " ++
          "marker-end=\"url(#tm-part)"
      | _ => "stroke:#2e7d32;fill:none;stroke-width:1.6;stroke-dasharray:5 3\" " ++
          "marker-end=\"url(#tm-support)"
    "<path d=\"M" ++ px sx ++ "," ++ px sy ++ " Q" ++ px cx ++ "," ++ px cy ++ " " ++
      px ex ++ "," ++ px ey ++ "\" style=\"" ++ style ++ "\"/>\n"
  let circle (k : Nat) : String :=
    let (x, y) := at' k
    "<circle cx=\"" ++ px x ++ "\" cy=\"" ++ px y ++ "\" r=\"" ++ px node ++
      "\" style=\"fill:var(--bg);stroke:var(--fg);stroke-width:1.2\"/>\n" ++
    "<text x=\"" ++ px x ++ "\" y=\"" ++ px (y + 5) ++
      "\" text-anchor=\"middle\" style=\"fill:var(--fg);font-size:14px\">" ++
      toString (k + 1) ++ "</text>\n"
  let marker (id colour : String) : String :=
    "<marker id=\"" ++ id ++ "\" viewBox=\"0 0 10 10\" refX=\"9\" refY=\"5\" " ++
      "markerWidth=\"7\" markerHeight=\"7\" orient=\"auto\">" ++
      "<path d=\"M0,0 L10,5 L0,10 z\" style=\"fill:" ++ colour ++ "\"/></marker>\n"
  "<div class=\"argument-map\">\n" ++
  "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 400 400\" width=\"400\" " ++
    "height=\"400\" role=\"img\" aria-label=\"The dispute as a graph: parties numbered " ++
    "as in the table below, defeats solid, supports dashed, parts dotted\">\n" ++
  "<defs>\n" ++ marker "tm-defeat" "#b3261e" ++ marker "tm-support" "#2e7d32" ++
    marker "tm-part" "#1f5fa8" ++ "</defs>\n" ++
  String.join (g.edges.filterMap fun (i, j, k) =>
    if Page.Graph.EdgeKind.drawn k then some (edge i j k) else none) ++
  String.join ((List.range n).map circle) ++
  "</svg>\n</div>\n\n"

/-- A dispute's graph: drawn, then its parties by number, then every edge in a
table, then what the derived attacks and the conflicts come to. -/
def graph (g : Page.Graph) (defeatTable supportTable partTable : String) : String :=
  let name (k : Nat) := "*" ++ escape (g.nodes.getD k "") ++ "*"
  let ref (t : String) (fallback : String) :=
    if t.isEmpty then fallback else "[`" ++ t ++ "`](#" ++ t ++ ")"
  if g.edges.isEmpty then
    Page.Graph.apartWords g (fun nm => "*" ++ escape nm ++ "*") ++
    " This is read from the cells of " ++ ref defeatTable "the defeat table" ++ ", " ++
    ref supportTable "the support table" ++ " and " ++ ref partTable "the part-of table" ++
    ", each computed from the parties' premises and checked by the kernel.\n"
  else
  graphSvg g ++
  "Solid red: defeats. Dashed green: supports. Dotted blue: one party's case is " ++
  "part of another's.\n\n" ++
  "| # | Party |\n|---|---|\n" ++
  String.join (g.nodes.zipIdx.map fun (nm, k) =>
    "| " ++ toString (k + 1) ++ " | " ++ escape nm ++ " |\n") ++
  "\n| From | To | Edge |\n|---|---|---|\n" ++
  String.join (g.edges.map fun (i, j, k) =>
    "| " ++ toString (i + 1) ++ " " ++ name i ++ " | " ++ toString (j + 1) ++ " " ++ name j ++
    " | " ++ Page.Graph.EdgeKind.describe k ++ " |\n") ++
  "\nThe defeats are the cells of " ++ ref defeatTable "the defeat table" ++
  ", the supports the cells of " ++ ref supportTable "the support table" ++
  " and the parts the cells of " ++ ref partTable "the part-of table" ++
  ", each computed from the parties' premises and checked by the kernel. " ++
  "The attacks derived through support and through parts are reported, not counted: " ++
  "every verdict is computed from the defeats alone. " ++
  (match Page.Graph.undirected g with
    | 0 => "Every derived attack is already a defeat."
    | 1 => "One derived attack is not a defeat; the dispute leaves it open."
    | k => toString k ++ " derived attacks are not defeats; the dispute leaves them open.") ++
  (match Page.Graph.conflicted g with
    | 0 => ""
    | _ => " A party that both supports and defeats another is marked in the table.") ++
  "\n"

/-- A dissent, assessed under every standard: what kind it is, and under each
standard whether it is credible, with what it rests on that the standard does
not admit. -/
def assessed (a : Page.Assessed) : String :=
  "**Dissent:** *" ++ escape a.dissenter ++ "*, against *" ++ escape a.against ++ "*. " ++
    (if a.critique then "✔ " else "✘ ") ++ escape a.kind ++ "\n\n" ++
  String.join (a.struck.map fun (c, r) =>
    "- **Struck, because the text reads otherwise:** " ++ escape c ++ ". " ++ escape r ++
      ".\n") ++
  (if a.struck.isEmpty then "" else "\n") ++
  "| Standard | A credible critique? | Rests on what the standard does not accept |\n" ++
  "|---|---|---|\n" ++
  String.join (a.standards.map fun (s, ok, un) =>
    "| " ++ s ++ " | " ++ (if ok then "✔ yes" else "✘ no") ++ " | " ++
      (if un.isEmpty then "—" else String.intercalate "; " (un.map escape)) ++ " |\n")

/-- A step's rating, computed from its register under every standard. -/
def rated (r : Page.Rated) : String :=
  "**The rating, computed.** *" ++ escape r.step ++ "* is cited at *" ++
    confidence r.support.confidence ++ "* (" ++ source r.support ++ "). Dissents encoded: " ++
    (if r.register.isEmpty then "none" else
      String.intercalate ", " (r.register.map fun d => "*" ++ escape d ++ "*")) ++ ". " ++
    (match r.steelman with
      | some d => "The strongest known: *" ++ escape d ++ "*."
      | none => "The strongest known dissent is not encoded.") ++ "\n\n" ++
  "| Standard | Rating | Why |\n|---|---|---|\n" ++
  String.join (r.ratings.map fun (s, c, why) =>
    "| " ++ s ++ " | **" ++ confidence c ++ "** | " ++ escape why ++ " |\n")

/-- A step, built up from its claims, as print sets it (`Latex.step`): each claim
it needs in words, with its rating and source; then what they give, after ∴;
then the formula. Any other shape, or a page without a legend, is one row. -/
def step [DecidableEq α] (order : List α) (cite : Option (α → AtomMeta))
    (φ : Formula α) : String :=
  match cite, Latex.stepClaims φ with
  | some c, some (needs, gives) =>
    let ground (i : Nat) (a : α) (denied : Bool) : String :=
      let m := c a
      "- " ++ rowLabel i ++ " " ++ inlineMath (formula order (Latex.literal a denied)) ++ " " ++
        (if denied then "*" ++ Latex.Lead.held.denial ++ ":* " else "") ++ escape m.label ++
        " — *" ++ confidence m.source.confidence ++ "*: " ++ source m.source ++ "\n"
    Latex.stepOpening ++ "\n\n" ++
    derivationRows (needs.zipIdx.map (fun ((a, d), i) => ground i a d) ++
      gives.map fun (a, d) =>
        "- " ++ inlineMath "\\therefore" ++ " " ++
          inlineMath (formula order (Latex.literal a d)) ++ " " ++
          (if d then "*" ++ Latex.Lead.held.denial ++ ":* " else "") ++ escape (c a).label ++
          "\n") ++
    "\n" ++ Latex.stepSymbols ++ " " ++ inlineMath (formula order φ) ++ ".\n"
  | _, _ =>
    derivationRows [derivationRow order "" φ
      (cite.bind fun c => Latex.loneGlossWith (inWords order c) φ)]

/-- A source in words, as print says it (`Latex.sourceWords`). -/
def sourceWords (s : Source) : String :=
  "Rated *" ++ confidence s.confidence ++ "*, held in the " ++ escape (tradition s.tradition) ++
    " tradition: " ++ source s ++ ".\n"

/-- A claim's citation in words, as print says it (`Latex.claimWords'`). -/
def claimWords (m : AtomMeta) : String :=
  "The claim: *" ++ escape m.label ++ "* (" ++ kind m.kind ++ "). " ++ sourceWords m.source

/-- A reading in words, as print says it (`Latex.readingWords`): the claims on
the page it takes as false, or, where fewer, those it takes as true. -/
def readingWords [DecidableEq α] (order : List α) (cite : Option (α → AtomMeta))
    (truth : List (α × Bool)) : String :=
  match cite with
  | none => ""
  | some c =>
    let onPage := truth.filter fun (a, _) => order.contains a
    let falses := onPage.filter (!·.2)
    let trues := onPage.filter (·.2)
    let (listed, lead, rest) :=
      if falses.length ≤ trues.length then
        (falses, "On this reading these claims are false:",
          if falses.isEmpty then "Every claim on this page is true on this reading."
          else "Every other claim on this page is true.")
      else
        (trues, "On this reading only these claims are true:",
          "Every other claim on this page is false.")
    if listed.isEmpty then rest ++ "\n"
    else
      lead ++ "\n\n" ++
      derivationRows (listed.map fun (a, _) =>
        "- " ++ inlineMath (varLink (order.idxOf a)) ++ " " ++ escape (c a).label ++ "\n") ++
      "\n" ++ rest ++ "\n"

/-- A citation function in words, as print says it (`Latex.citationWords`): the
claims on the page it cites otherwise than the table of numbered claims, each
with its citation, and that it cites the rest as the table does. -/
def citationWords [DecidableEq α] (order : List α) (legendCite : Option (α → AtomMeta))
    (cite : α → AtomMeta) : String :=
  let row (a : α) : String :=
    "- " ++ inlineMath (varLink (order.idxOf a)) ++ " " ++ escape (cite a).label ++ " — *" ++
      kind (cite a).kind ++ "; " ++ confidence (cite a).source.confidence ++ ": " ++
      source (cite a).source ++ "*\n"
  match legendCite with
  | none =>
    if order.isEmpty then ""
    else "It cites each claim on this page so:\n\n" ++ derivationRows (order.map row)
  | some l =>
    match Page.citedOtherwise order l cite with
    | [] => "It cites every claim on this page as the table of numbered claims does.\n"
    | differs =>
      "It cites these claims otherwise than the table of numbered claims does:\n\n" ++
      derivationRows (differs.map (row ·.1)) ++
      "\nEvery other claim on this page it cites as the table does.\n"

/-- Names set as a list, each in italics. -/
def nameList (names : List String) : String :=
  String.join (names.map fun x => "- *" ++ escape x ++ "*\n") ++ "\n"

/-- Mathematics written so that Markdown's escaping pass leaves MathJax what it
was given: a backslash before punctuation, `\{` say, is one Markdown would eat. -/
def mathEscape (t : String) : String :=
  let step := fun (acc : String × Bool) (c : Char) =>
    let (out, afterSlash) := acc
    if afterSlash && "{}_,;!|#*[]()".contains c then (out ++ "\\\\" ++ c.toString, false)
    else if afterSlash then (out ++ "\\" ++ c.toString, false)
    else if c == '\\' then (out, true)
    else (out.push c, false)
  let (out, pending) := t.foldl step ("", false)
  if pending then out ++ "\\" else out

/-- A statement in logic notation, as the site sets it: `Latex.symTex`, each
claim linked to its legend row. The browser wraps a long statement itself, so
print's break points (`\allowbreak`) are left out. -/
def symMd [DecidableEq α] (order : List α) : Sym α → String
  | .atom a => varLink (order.idxOf a)
  | .formula φ => formula order φ
  | .tex t => mathEscape (t.replace "\\allowbreak " " ")
  | .seq ps => String.join (ps.attach.map fun ⟨p, _⟩ => symMd order p)

/-- A result stated twice, side by side, as print sets it (`Latex.stated`): the
logic notation on the left, the docstring on the right. -/
def stated [DecidableEq α] (order : List α) (st : Sym α) (doc : String) : String :=
  "<div class=\"testimony-stated\">\n<div class=\"testimony-stated-logic\">\n\n" ++
  inlineMath (symMd order st) ++ "\n\n</div>\n<div class=\"testimony-stated-words\">\n\n" ++
  doc ++ "\n\n</div>\n</div>\n"

/-- Render one item against the page's atom ordering, and the legend's citations
where the page has a legend. A lone formula, or a list of them, is set as rows of
a derivation, as in print, so a step says what it delivers there too. -/
def item [DecidableEq α] (order : List α) (cite : Option (α → AtomMeta)) :
    Item α → String
  | .prose md => demote md ++ "\n"
  | .package d doc pkg =>
      declLabel d (" — " ++ escape pkg.name) ++ "\n" ++ doc ++ "\n\n" ++
      derivation order cite pkg.premises pkg.conclusion ++
      (if pkg.scriptureOnlyAtoms.isEmpty then ""
       else
         "\nRead from the text alone, with no commentator cited, and so assumed here " ++
         "rather than argued for: " ++
         String.intercalate "; "
           (pkg.scriptureOnlyAtoms.map fun m => escape m.label) ++ ".\n")
  | .line d doc l =>
      declLabel d (" — " ++ escape l.name) ++ "\n" ++ doc ++ "\n\n" ++
      derivation order cite l.premises l.delivers
  | .formula d doc φ =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ step order cite φ
  | .formulas d doc φs =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++
      derivationRows (φs.zipIdx.map fun (φ, i) => derivationRow order (rowLabel i) φ
        (cite.bind fun c => Latex.glossWith (inWords order c) none φ))
  | .source d doc s =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ sourceWords s
  | .claim d doc m =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ claimWords m
  | .reading d doc truth =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ readingWords order cite truth
  | .fromLine d doc line pkg =>
      declLabel d (" — " ++ escape pkg.name) ++ "\n" ++ doc ++ "\n\n" ++
      "It argues the line [`" ++ line ++ "`](#" ++ line ++ "), set out above, as it stands: " ++
      "the same grounds and the same step, to the same conclusion.\n\n" ++
      derivationRows [derivationRow order (inlineMath "\\vdash") pkg.conclusion
        (cite.bind fun c => inWords order c .atIssue pkg.conclusion)]
  | .positions d doc names =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ nameList names
  | .dispute d doc names node =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++
      (if node.isEmpty then "It hears these positions, each"
       else "It hears the positions [`" ++ node ++ "`](#" ++ node ++ ") gives the parties, each") ++
      " checked when the library is built to be consistent, to reach its conclusion, and to " ++
      "rest on at least one rated step" ++
      (if node.isEmpty then ":\n\n" ++ nameList names else ".\n")
  | .register d doc assessed steps =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\nThe positions it assesses as dissents:\n\n" ++
        nameList assessed ++ "The steps their dissents are rated against:\n\n" ++
        nameList steps
  | .refutation d doc a reads src =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\nThe claim struck: " ++
        inlineMath (varLink (order.idxOf a)) ++
        (match cite with | some c => " " ++ escape (c a).label | none => "") ++
        ". What the text reads: " ++ escape reads ++ ". " ++ sourceWords src
  | .greek d doc place words =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ escape place ++
        " in the SBL Greek New Testament: " ++ escape (" ".intercalate words) ++ "\n"
  | .sourceFn d doc src =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\nCited to " ++ source src ++
        ", at whatever rating the place that cites it gives.\n"
  | .listing d doc lead entries =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++
        (if entries.isEmpty then "" else escape lead ++ "\n\n" ++ nameList entries)
  | .sources d doc ss =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ String.join (ss.map fun x => sourceWords x ++ "\n")
  | .said d doc text => declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ escape text ++ "\n"
  | .edge d doc e =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ escape e.fromPassage.render ++ " " ++
        escape (relationWords e.relation) ++ " " ++ escape e.toPassage.render ++ ". " ++
        sourceWords e.source
  | .interpretation d doc crit i =>
      declLabel d (if crit.isEmpty then "" else " — " ++ escape crit) ++ "\n" ++ doc ++ "\n\n" ++
        escape i.passage.render ++
        (match i.asRelation with
         | some r => ", read as " ++ escape (asRelationWords r)
         | none => "") ++
        ": *" ++ escape i.reading ++ "*. " ++ sourceWords i.source
  | .dilemmaReading d doc name φ src =>
      declLabel d (" — " ++ escape name) ++ "\n" ++ doc ++ "\n\n" ++
        "Read so, the claim commits its holder to:\n\n" ++
        derivationRows [derivationRow order "" φ
          (cite.bind fun c => Latex.loneGlossWith (inWords order c) φ)] ++ "\n" ++
        sourceWords src
  | .truthTable d doc inputs rs =>
      let yn (b : Bool) := if b then "true" else "false"
      declLabel d "" ++ "\n" ++ doc ++ "\n\nThe rule, row by row:\n\n" ++
        "| " ++ " | ".intercalate (inputs ++ ["allowed"]) ++ " |\n" ++
        "|" ++ String.join ((inputs ++ ["allowed"]).map fun _ => "---|") ++ "\n" ++
        String.join (rs.map fun (ins, out) =>
          "| " ++ " | ".intercalate (ins.map yn ++ [if out then "yes" else "no"]) ++ " |\n") ++
        "\n"
  | .table d doc t => "<a id=\"" ++ d ++ "\"></a>\n\n" ++ doc ++ "\n\n" ++ table d t
  | .contested d doc holder denier φ =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n*" ++ escape holder ++ "* holds this claim, and *" ++
        escape denier ++ "* denies it; each can be defended in the dispute:\n\n" ++
        derivationRows [derivationRow order "" φ
          (cite.bind fun c => Latex.loneGlossWith (inWords order c) φ)]
  | .helper d doc => declLabel d "" ++ "\n" ++ doc ++ "\n"
  | .citation d doc c =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ citationWords order cite c
  | .other d doc sig =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ leanBlock sig
  | .result d doc st proposed =>
      declLabel d (if proposed then " ⚗" else "") ++ "\n" ++ stated order st doc
  | .because d doc e =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ explanation order e
  | .dilemma d doc dl =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ dilemma order dl
  | .burden d doc st b =>
      declLabel d "" ++ "\n" ++ stated order st doc ++ "\n" ++ burden b
  | .verdict d doc v links table =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ verdict v links table
  | .graph d doc g defeats supports parts =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ graph g defeats supports parts
  | .assessed d doc a =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ assessed a
  | .rated d doc r =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ rated r
  | .exchange d doc x links =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ exchange links x

/-- The body of a generated page: the legend, then every item in source order.

The legend goes above the prose that explains the atoms rather than below it,
because a reader meeting `P_{9}` in the first formula needs the table more than
they need the paragraph. -/
def body [DecidableEq α] (allAtoms : List α) (intro : List (Item α))
    (items : List (Item α)) : String :=
  let all := intro ++ items
  let order := atomOrder allAtoms all
  let cite := citeOf all
  -- The legend sits under the module whose prose it follows, not beside it.
  let table := match cite with
    | some c => "### The claims, numbered\n\n" ++ legend c order ++ "\n"
    | none => ""
  String.intercalate "\n" (intro.map (item order cite)) ++ "\n" ++ table ++
    String.intercalate "\n" (items.map (item order cite))

/-! The derivation's links and words, pinned on three claims of a test argument:
claim `k` says "claim k". They are the words `Latex`'s guards pin for print. -/

/-- The test argument's claims. -/
private def testCite (k : Nat) : AtomMeta :=
  { label := "claim " ++ toString k, kind := .historical,
    source := { primary := .proposal "a test", tradition := .adversarialTrial,
                confidence := .disputed } }

-- A claim the position holds says itself, a denied one is marked, a step that
-- gives the conclusion leaves it to the turnstile row, and every variable links
-- to its legend row.
#guard derivation [0, 1, 2] (some testCite)
    [.atom 0, .imp (.atom 1) .falsum, .imp (.and (.atom 0) (.imp (.atom 1) .falsum)) (.atom 2)]
    (.atom 2) ==
  "<div class=\"testimony-derivation\">\n\n" ++
  "- (1) \\\\(\\href{#claim-1}{P_{1}}\\\\) — claim 0\n" ++
  "- (2) \\\\(\\lnot \\href{#claim-2}{P_{2}}\\\\) — *denied:* claim 1\n" ++
  "- (3) \\\\((\\href{#claim-1}{P_{1}} \\land \\lnot \\href{#claim-2}{P_{2}}) " ++
    "\\rightarrow \\href{#claim-3}{P_{3}}\\\\)\n" ++
  "- \\\\(\\vdash\\\\) \\\\(\\href{#claim-3}{P_{3}}\\\\) — *at issue:* claim 2\n" ++
  "\n</div>\n"

-- Of several claims, each is named by its variable, linked.
#guard Latex.glossWith (inWords [0, 1, 2] testCite) none
    (.imp (.atom 0) (.and (.atom 1) (.imp (.atom 2) .falsum))) ==
  some ("*would give:* \\\\(\\href{#claim-2}{P_{2}}\\\\) claim 1; " ++
    "\\\\(\\href{#claim-3}{P_{3}}\\\\) *denied:* claim 2")

-- A step is built up from its claims, as print builds it.
#guard step [0, 1, 2] (some testCite) (.imp (.and (.atom 0) (.atom 1)) (.atom 2)) ==
  "If each of these holds,\n\n" ++
  "<div class=\"testimony-derivation\">\n\n" ++
  "- (1) \\\\(\\href{#claim-1}{P_{1}}\\\\) claim 0 — *disputed*: *proposed:* a test\n" ++
  "- (2) \\\\(\\href{#claim-2}{P_{2}}\\\\) claim 1 — *disputed*: *proposed:* a test\n" ++
  "- \\\\(\\therefore\\\\) \\\\(\\href{#claim-3}{P_{3}}\\\\) claim 2\n" ++
  "\n</div>\n\n" ++
  "In symbols, the step is \\\\((\\href{#claim-1}{P_{1}} \\land \\href{#claim-2}{P_{2}}) " ++
    "\\rightarrow \\href{#claim-3}{P_{3}}\\\\).\n"

-- Without a legend, nothing is glossed.
#guard derivation [0] none [] (.atom 0) ==
  "<div class=\"testimony-derivation\">\n\n" ++
  "- \\\\(\\vdash\\\\) \\\\(\\href{#claim-1}{P_{1}}\\\\)\n\n</div>\n"

end Testimony.Logic.Markdown
