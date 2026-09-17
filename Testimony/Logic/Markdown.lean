import Testimony.Logic.Latex
import Testimony.Logic.Line

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

open Testimony Testimony.Bib

variable {α : Type}

/-! ### Text -/

/-- Collapse whitespace runs to single spaces, so a label or a pretty-printed
statement fits one Markdown table cell. -/
def oneLine (s : String) : String :=
  String.intercalate " " ((s.replace "\n" " ").splitOn " " |>.filter (· ≠ ""))

/-- Escape what a Markdown table cell cannot carry. -/
def cell (s : String) : String := (oneLine s).replace "|" "\\|"

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

/-- A reference. Scripture renders as the passage; a work renders as its cite
key, which is what the [bibliography](./../bibliography.md) is indexed by; a
proposal is marked as the library's own construction. -/
def reference : Reference → String
  | .scripture refs =>
      String.intercalate "; " (refs.map fun r => escape r.ref.render)
  | .work e l =>
      let loc := locus l
      if loc.isEmpty then "`" ++ e.key ++ "`" else "`" ++ e.key ++ "`, " ++ loc
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

/-! ### Items -/

/-- One element of a generated page.

`prose` is a module docstring, lifted whole; the rest are declarations, each
carrying its own docstring and whatever rendering its type admits. The cases
are the shapes an argument module actually declares, and `other` is the
honest fallback — a declaration the renderer has no special reading of is
still listed, with its signature, rather than silently dropped. -/
inductive Item (α : Type)
  /-- Prose lifted from a module docstring. Already Markdown. -/
  | prose (markdown : String)
  /-- A named position: its premises and its conclusion. -/
  | package (decl doc : String) (pkg : ArgumentPackage α)
  /-- A named line of reason: its grounds, its step, what it delivers. -/
  | line (decl doc : String) (l : Line α)
  /-- A named formula, usually an inference step. -/
  | formula (decl doc : String) (φ : Formula α)
  /-- A named list of formulas, usually grounds shared between lines. -/
  | formulas (decl doc : String) (φs : List (Formula α))
  /-- A declaration shown by its signature alone: a countermodel, whose content
  is a function, or anything else the renderer does not read. -/
  | other (decl doc signature : String)
  /-- A result, with the statement as Lean states it. -/
  | result (decl doc statement : String) (proposed : Bool)

namespace Item

/-- Every atom this item mentions, in the order it mentions them. What the
page's legend is built from. -/
def atoms [DecidableEq α] : Item α → List α
  | .package _ _ pkg => pkg.atoms
  | .line _ _ l => (l.premises ++ [l.delivers]).flatMap atomsOf
  | .formula _ _ φ => atomsOf φ
  | .formulas _ _ φs => φs.flatMap atomsOf
  | _ => []

/-- The label a declaration is introduced by: an anchor to link to, then its
name, then whatever the item wants said beside it.

Declarations are deliberately not headings. A generated page's heading
structure is the prose's own — the module docstrings decide what the sections
are — and a heading per declaration would bury that under sixty entries of
scaffolding. The anchor is what a link needs; the rest is a label. -/
def anchor (d : String) (suffix : String) : String :=
  "<a id=\"" ++ d ++ "\"></a>\n**`" ++ d ++ "`**" ++ suffix ++ "\n"

end Item

/-! ### The page -/

/-- A fenced block of Lean, for the declarations that are read as code rather
than as notation. -/
def leanBlock (body : String) : String := "```lean\n" ++ body ++ "\n```\n"

/-- Render one item against the page's atom ordering. -/
def item [DecidableEq α] (order : List α) : Item α → String
  | .prose md => demote md ++ "\n"
  | .package d doc pkg =>
      Item.anchor d (" — " ++ escape pkg.name) ++ "\n" ++ doc ++ "\n\n" ++
      derivation order pkg.premises pkg.conclusion ++
      (if pkg.scriptureOnlyAtoms.isEmpty then
         "\nNo premise here rests on scripture alone.\n"
       else
         "\nGrounded in scripture alone: " ++
         String.intercalate ", "
           (pkg.scriptureOnlyAtoms.map fun m => escape m.label) ++ ".\n")
  | .line d doc l =>
      Item.anchor d (" — " ++ escape l.name) ++ "\n" ++ doc ++ "\n\n" ++
      derivation order l.premises l.delivers
  | .formula d doc φ =>
      Item.anchor d "" ++ "\n" ++ doc ++ "\n\n" ++
      display (Latex.formula order φ)
  | .formulas d doc φs =>
      Item.anchor d "" ++ "\n" ++ doc ++ "\n\n" ++
      display (aligned (φs.zipIdx.map fun (φ, i) =>
        row ("\\text{(" ++ toString (i + 1) ++ ")}") (Latex.formula order φ)))
  | .other d doc sig =>
      Item.anchor d "" ++ "\n" ++ doc ++ "\n\n" ++ leanBlock sig
  | .result d doc stmt proposed =>
      Item.anchor d (if proposed then " ⚗" else "") ++ "\n" ++ doc ++ "\n\n" ++
      leanBlock stmt

/-- The atom ordering a page uses.

`allAtoms` is the atom type's own constructor order, which is the order
`Atoms.lean` declares them in and therefore the order its prose groups them by.
The page keeps that order and drops what it does not mention, so the legend
reads as the source reads. An atom mentioned but not listed — which would mean
the caller passed something other than the constructors — is kept at the end
rather than silently dropped. -/
def atomOrder [DecidableEq α] (allAtoms : List α) (items : List (Item α)) : List α :=
  let mentioned := (items.flatMap Item.atoms).eraseDups
  allAtoms.filter (mentioned.contains ·) ++ mentioned.filter (!allAtoms.contains ·)

/-- The `cite` of the first package on the page.

Every package in an argument shares one `cite` — it is what makes the atom
type's claims a single manifest rather than a per-package one — so the first
package's is the argument's. An argument with no package has nothing to
legend, and cannot occur: rule L5 requires at least two. -/
def citeOf : List (Item α) → Option (α → AtomMeta)
  | [] => none
  | .package _ _ pkg :: _ => some pkg.cite
  | _ :: rest => citeOf rest

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
