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
instead of `longtable`, cite keys instead of `\cite`, and delimiters MathJax
recognises.

## One legend for the page

The LaTeX renderer numbers atoms per package, because a printed argument is
read one package at a time. A generated page is not: it sets four positions,
three objections and the variants that test them side by side, and a reader
comparing two of them needs `P_{9}` to mean the same claim in both. So the
numbering here is fixed once for the whole page, from the atoms every item on
it mentions, and the legend is given once at the top.

## Why the display math sits inside a `<div>`

mdBook runs Markdown over the page before MathJax sees it, and a display
environment is full of the characters Markdown eats. `\\` opens a new row in
`aligned` and is Markdown's escape character; `\[` is Markdown's escaped
bracket. Doubling every one of them to survive that pass is possible, and it
fails silently — a missed pair does not error, it just renders as text.

A block-level raw-HTML element does not have the problem: CommonMark hands an
HTML block through untouched as far as the first blank line, so what is written
inside one is what MathJax receives. Every display formula a generated page
carries is therefore emitted inside a `<div>` containing no blank line.

Inline math, which needs no `\\`, is written the way mdBook documents:
`\\(` in the source survives the Markdown pass as `\(`.
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
open with `# Arguments.SolaScriptura.Lines — …` and use `##` and `###` beneath
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

/-- The alignment tab, HTML-escaped. A display block is raw HTML, and MathJax
reads the text the browser decodes from it. -/
def amp : String := "&amp;"

/-- A display formula, inside the raw-HTML block that keeps Markdown away from
it. There is deliberately no blank line within: a blank line would close the
HTML block and hand the rest of the formula back to the Markdown parser. -/
def display (body : String) : String :=
  "<div class=\"testimony-math\">\n\\[\n" ++ body ++ "\n\\]\n</div>\n"

/-- One row of an `aligned` environment: a label, then the formula it labels.
`aligned` right-aligns its odd columns and left-aligns its even ones, so the
labels line up on their right and the formulas on their left. -/
def row (label body : String) : String :=
  label ++ " \\quad " ++ amp ++ " " ++ body

/-- Rows joined into an `aligned` environment, ready for `display`. -/
def aligned (rows : List String) : String :=
  "\\begin{aligned}\n" ++ String.intercalate " \\\\\n" rows ++ "\n\\end{aligned}"

/-- Numbered premises above a turnstile, as one display formula.

The order is the order the encoding puts them in, which for a package built by
`caseOf` is every line's grounds first and every line's inference step last —
the order a reader checks an argument in. -/
def derivation [DecidableEq α] (order : List α) (prems : List (Formula α))
    (concl : Formula α) : String :=
  let numbered := prems.zipIdx.map fun (φ, i) =>
    row ("\\text{(" ++ toString (i + 1) ++ ")}") (Latex.formula order φ)
  let above :=
    if numbered.isEmpty then ""
    else String.intercalate " \\\\\n" numbered ++ " \\\\[4pt]\n"
  display ("\\begin{aligned}\n" ++ above ++ row "\\vdash" (Latex.formula order concl) ++
    "\n\\end{aligned}")

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

/-- A reference. Scripture renders as the passage; a work renders as its cite
key, linked to its entry in the bibliography — `Bib.Render.toMarkdown` puts an
anchor of that name on every line — and a proposal is marked as the library's
own construction. -/
def reference : Reference → String
  | .scripture refs =>
      String.intercalate "; " (refs.map fun r => escape r.ref.render)
  | .work e l =>
      let link := "[`" ++ e.key ++ "`](" ++ bibliographyPath ++ "#" ++ e.key ++ ")"
      let loc := locus l
      if loc.isEmpty then link else link ++ ", " ++ loc
  | .proposal r => "*proposed:* " ++ escape r

/-- Every reference a source rests on. -/
def source (s : Source) : String :=
  String.intercalate "; " (s.references.map reference)

/-- Which interpretive tradition advances a claim. -/
def tradition : Tradition → String
  | .christianTypological => "Christian, typological"
  | .christianHistoricalGrammatical => "Christian, historical-grammatical"
  | .secondTempleJewish => "Second Temple Jewish"
  | .rabbinicJewish => "rabbinic Jewish"
  | .criticalScholarship => "critical scholarship"
  | .reformedProtestant => "Reformed Protestant"
  | .romanCatholic => "Roman Catholic"
  | .easternOrthodox => "Eastern Orthodox"

/-- How firmly that tradition holds it. -/
def confidence : Confidence → String
  | .disputed => "disputed"
  | .plausible => "plausible"
  | .wellSupported => "well supported"
  | .consensus => "consensus"

/-- How a premise is classified. -/
def kind : PremiseKind → String
  | .textual => "textual" | .linguistic => "linguistic"
  | .historical => "historical" | .theological => "theological"
  | .interpretive => "interpretive"

/-- The legend: one row per atom, giving the claim it stands for, how it is
classified, who holds it and where they say so. This is the assumption manifest
of the whole page.

The wrapping `<div>` is what the stylesheet hangs the column widths on, and the
blank line after it is load-bearing: it closes the HTML block, so the table
inside is read as Markdown rather than passed through as raw HTML. -/
def legend [DecidableEq α] (cite : α → AtomMeta) (order : List α) : String :=
  let rows := order.zipIdx.map fun (a, i) =>
    let m := cite a
    let mark := if m.source.isScriptureOnly then " ※" else ""
    "| " ++ inlineMath (Latex.varName i) ++ " | " ++ cell (escape m.label) ++ mark
      ++ " | " ++ kind m.kind ++ " | " ++ tradition m.source.tradition ++ ", "
      ++ confidence m.source.confidence ++ " | " ++ cell (source m.source) ++ " |"
  "<div class=\"testimony-legend\">\n\n" ++
  "| | claim | kind | held | source |\n|---|---|---|---|---|\n" ++
  String.intercalate "\n" rows ++ "\n\n</div>\n\n" ++
  "※ grounded in scripture alone: the reading is assumed, not argued for.\n"

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
  String.intercalate ", " (φs.map fun φ => inlineMath (Latex.formula order φ))

/-- One claim an explanation rests on: its number, what it says, how firmly it
is held and by whom. -/
def restingClaim [DecidableEq α] (order : List α) (cite : α → AtomMeta) (a : α) : String :=
  let m := cite a
  "  - " ++ inlineMath (Latex.varName (order.idxOf a)) ++ " " ++ escape m.label ++ " — *" ++
    confidence m.source.confidence ++ "*: " ++ source m.source

/-- Why one position stands against another, as a list a reader can check line
by line against the theorems it summarises. -/
def explanation [DecidableEq α] (order : List α) (e : Page.Explanation α) : String :=
  let given := if e.granted.isEmpty then "" else " and " ++ inlineFormulas order e.granted
  "**Why *" ++ escape e.holder ++ "* stands against *" ++ escape e.rival ++ "*.**\n\n" ++
  "- **The crux:** " ++ inlineMath (Latex.formula order e.crux) ++ ", a premise of *" ++
    escape e.holder ++ "*.\n" ++
  "- **What it does:** " ++
    (if e.derives then "its conclusion does not follow without it."
     else "its conclusion follows without it — the crux is its answer to *" ++
       escape e.rival ++ "*.") ++ "\n" ++
  (if e.granted.isEmpty then "" else
    "- **Granted:** " ++ inlineFormulas order e.granted ++
    ", which the break also needs.\n") ++
  "- **Where the rival breaks:** " ++ inlineFormulas order e.core ++
    " cannot be held together with " ++ inlineMath (Latex.formula order e.crux) ++ given ++
    "; each is needed for the break, and without the crux they stand.\n" ++
  "- **What this rests on:**\n" ++
    String.intercalate "\n" (e.restsOn.map (restingClaim order e.cite)) ++
    (if Page.Explanation.isLiteral e.crux then "" else
      "\n  - the step itself — " ++
      (if e.inferences.isEmpty then "*unrated*" else
        String.intercalate "; " (e.inferences.map fun s =>
          "*" ++ confidence s.confidence ++ "*: " ++ source s))) ++ "\n"

/-- Every reading of a rival's claim, answered: each horn with what the claim
commits the rival to, who reads it that way, and what happens to it against
each position — the explanation where it falls, and a sentence where it is not
reached. -/
def dilemma [DecidableEq α] (order : List α) (d : Page.Dilemma α) : String :=
  let claim := inlineMath (Latex.formula order d.claim)
  let fate (f : Page.Fate α) : String := match f.falls with
    | some e => "Against *" ++ escape f.against ++ "*, it falls.\n\n" ++ explanation order e
    | none =>
      "Against *" ++ escape f.against ++ "*, it is not reached: *" ++ escape f.against ++
        "* holds, and can be held together with it.\n"
  "**Every reading of " ++ claim ++ ", answered.** *" ++ escape d.rival ++ "* holds " ++
    claim ++ ". It is read " ++ toString d.horns.length ++
    (if d.horns.length == 1 then " way" else " ways") ++
    " here, and each reading is checked; none can be left out.\n\n" ++
  String.intercalate "\n" (d.horns.zipIdx.map fun (h, k) =>
    "**" ++ toString (k + 1) ++ ". Read " ++ escape h.reading ++ ".** The claim commits *" ++
      escape d.rival ++ "* to " ++ inlineMath (Latex.formula order h.commits) ++
      " — so read by " ++ source h.source ++ " (*" ++ confidence h.source.confidence ++
      "*).\n\n" ++
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

/-- A count with its noun, singular or plural. -/
def count (n : Nat) (one many : String) : String :=
  toString n ++ " " ++ (if n == 1 then one else many)

/-- What a verdict rests on: how many cells of the table its reasons state,
which of those defeats a `Because` explains, and every party involved at its
weakest link. -/
def restsOn (v : Page.Verdict) (links : List Page.BecauseLink) (table : String) : String :=
  let defeats := (v.cells.filter (·.2.2)).length
  let absences := v.cells.length - defeats
  let tableRef := if table.isEmpty then "the defeat table"
    else "the defeat table, [`" ++ table ++ "`](#" ++ table ++ ")"
  let explained := (v.cells.filterMap fun (a, b, d) =>
    if d then (Page.becauseFor links a b).map (a, b, ·) else none)
  let held (h : Page.Held) : String :=
    "  - " ++ escape h.what ++ " — " ++ source h.source ++ "\n"
  let reading (r : Page.Reading) : String :=
    match r.weakest with
    | [] => "- *" ++ escape r.party ++ "*: no rated premise.\n"
    | h :: _ =>
      "- *" ++ escape r.party ++ "*, weakest at *" ++ confidence h.confidence ++ "*:\n" ++
      String.join (r.weakest.map held)
  "\n**What this rests on.** The reasons state " ++ count defeats "defeat" "defeats" ++
  " and " ++ count absences "absence of defeat" "absences of defeat" ++ ", each a cell of " ++
  tableRef ++ ", computed from the two parties' premises and checked by the kernel. " ++
  "Whether an attack survives turns on the attacker's weakest link and on the rating " ++
  "of what it attacks, so a changed rating can change the verdict. The weakest links:\n\n" ++
  String.join (v.readings.map reading) ++
  String.join (explained.map fun (a, b, d) =>
    "\nWhy *" ++ escape a ++ "* defeats *" ++ escape b ++ "*, at the level of the claims: [`" ++
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

/-- Render one item against the page's atom ordering. -/
def item [DecidableEq α] (order : List α) : Item α → String
  | .prose md => demote md ++ "\n"
  | .package d doc pkg =>
      declLabel d (" — " ++ escape pkg.name) ++ "\n" ++ doc ++ "\n\n" ++
      derivation order pkg.premises pkg.conclusion ++
      (if pkg.scriptureOnlyAtoms.isEmpty then
         "\nNo premise here rests on scripture alone.\n"
       else
         "\nGrounded in scripture alone: " ++
         String.intercalate ", "
           (pkg.scriptureOnlyAtoms.map fun m => escape m.label) ++ ".\n")
  | .line d doc l =>
      declLabel d (" — " ++ escape l.name) ++ "\n" ++ doc ++ "\n\n" ++
      derivation order l.premises l.delivers
  | .formula d doc φ =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++
      display (Latex.formula order φ)
  | .formulas d doc φs =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++
      display (aligned (φs.zipIdx.map fun (φ, i) =>
        row ("\\text{(" ++ toString (i + 1) ++ ")}") (Latex.formula order φ)))
  | .other d doc sig =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ leanBlock sig
  | .result d doc stmt proposed =>
      declLabel d (if proposed then " ⚗" else "") ++ "\n" ++ doc ++ "\n\n" ++
      leanBlock stmt
  | .because d doc e =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ explanation order e
  | .dilemma d doc dl =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ dilemma order dl
  | .burden d doc stmt b =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ leanBlock stmt ++ "\n" ++ burden b
  | .verdict d doc v links table =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ verdict v links table
  | .graph d doc g defeats supports parts =>
      declLabel d "" ++ "\n" ++ doc ++ "\n\n" ++ graph g defeats supports parts

/-- The body of a generated page: the legend, then every item in source order.

The legend goes above the prose that explains the atoms rather than below it,
because a reader meeting `P_{9}` in the first formula needs the table more than
they need the paragraph. -/
def body [DecidableEq α] (allAtoms : List α) (intro : List (Item α))
    (items : List (Item α)) : String :=
  let all := intro ++ items
  let order := atomOrder allAtoms all
  let table := match citeOf all with
    | some cite => "## The claims, numbered\n\n" ++ legend cite order ++ "\n"
    | none => ""
  String.intercalate "\n" (intro.map (item order)) ++ "\n" ++ table ++
    String.intercalate "\n" (items.map (item order))

end Testimony.Logic.Markdown
