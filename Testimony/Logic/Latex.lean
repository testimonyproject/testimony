import Testimony.Logic.Page
import Testimony.Bib.Render

/-!
# Testimony.Logic.Latex — arguments as traditional propositional logic

Renders an `ArgumentPackage` the way a logic paper would set it: atoms as
numbered propositional variables with a legend giving each one's claim and
source, premises as a numbered list of formulas, and the conclusion below a
turnstile.

Atoms are numbered rather than named. A formula reading
`(P₂ ∧ P₃ ∧ P₆) → P₁₃` is legible as propositional structure in a way that one
reading `(romans3_28 ∧ galatians2_16 ∧ …) → …` is not, and the legend carries
what each variable means. This is the usual convention, and it is the point of
rendering at all: to see the *shape* of the argument separately from its
content.

Citations render as `\cite{key}` against the generated `references.bib`, so a
rendered argument is bibliographically live.

## The prose comes too

`argtex` used to render packages and nothing else, with a hand-written
paragraph introducing each argument — prose that said less than the module
docstring it was paraphrasing, and could contradict it. The document is now
assembled from the same harvest the documentation site is: every module
docstring in source order, each declaration under the docstring that introduces
it. `prose` is what makes that possible, converting the Markdown a docstring is
written in to LaTeX.

That converter is deliberately small. It handles what the docstrings in this
library use — headings, paragraphs, tables, lists, fenced code, and inline
`code`, **bold**, *italic* and links — and anything it does not recognise is
set as an ordinary paragraph, which is the safe way to be wrong.
-/

namespace Testimony.Logic.Latex

open Testimony Testimony.Bib Testimony.Logic.Page

variable {α : Type}

/-- Escape the characters TeX treats specially. Greek and Hebrew pass through:
the preamble selects a Unicode engine. -/
def escape (s : String) : String :=
  s.foldl (init := "") fun acc c =>
    acc ++ match c with
      | '&' => "\\&" | '%' => "\\%" | '$' => "\\$" | '#' => "\\#"
      | '_' => "\\_" | '{' => "\\{" | '}' => "\\}"
      | '~' => "\\textasciitilde{}" | '^' => "\\textasciicircum{}"
      | '\\' => "\\textbackslash{}"
      | c => c.toString

/-- A propositional variable, subscripted by its position in the legend. -/
def varName (i : Nat) : String := "P_{" ++ toString (i + 1) ++ "}"

/-- Parenthesise only where the surrounding precedence requires it. -/
def wrap (ctx prec : Nat) (s : String) : String :=
  if ctx > prec then "(" ++ s ++ ")" else s

/-- Render a formula in traditional notation.

Precedence-aware, so nothing carries more parentheses than it needs: `¬` binds
tighter than `∧`, which binds tighter than `∨`, which binds tighter than `→`.
Conjunction and disjunction are associative and render flat. The antecedent of
an implication is parenthesised even though precedence does not require it,
because that is how a reader expects to see it.

`φ → ⊥` renders as `¬φ` rather than as an implication. -/
partial def formulaPrec [DecidableEq α] (order : List α) (ctx : Nat) :
    Formula α → String
  | .atom a => varName (order.idxOf a)
  | .falsum => "\\bot"
  | .imp p .falsum => wrap ctx 40 ("\\lnot " ++ formulaPrec order 41 p)
  | .and p q =>
      wrap ctx 30 (formulaPrec order 30 p ++ " \\land " ++ formulaPrec order 30 q)
  | .or p q =>
      wrap ctx 20 (formulaPrec order 20 p ++ " \\lor " ++ formulaPrec order 20 q)
  | .imp p q =>
      wrap ctx 10 (formulaPrec order 31 p ++ " \\rightarrow " ++ formulaPrec order 10 q)

/-- Render a formula at the top level, where nothing needs wrapping. -/
def formula [DecidableEq α] (order : List α) (φ : Formula α) : String :=
  formulaPrec order 0 φ

/-- A pinpoint, as the optional argument to `\cite`. -/
def locus : Locus → String
  | .whole => ""
  | .page n => s!"{n}"
  | .pages a b => s!"{a}--{b}"
  | .pageList ns => String.intercalate ", " (ns.map toString)
  | .sectionRef s => escape s
  | .adLoc p => "ad loc. " ++ escape p.render
  | .apparatus p => "app. " ++ escape p.render
  | .sv w => "s.v. " ++ escape w

/-- A reference: scripture in plain text, works as live `\cite` commands. -/
def reference : Reference → String
  | .scripture refs =>
      String.intercalate "; " (refs.map fun r => escape r.ref.render)
  | .work e l =>
      let loc := locus l
      if loc.isEmpty then "\\cite{" ++ e.key ++ "}"
      else "\\cite[" ++ loc ++ "]{" ++ e.key ++ "}"
  | .proposal r => "\\emph{proposed:} " ++ escape r

/-- Every reference a source rests on. -/
def source (s : Source) : String :=
  String.intercalate "; " (s.references.map reference)

/-- How a premise is classified, for the legend. -/
def kind : PremiseKind → String
  | .textual => "textual" | .linguistic => "linguistic"
  | .historical => "historical" | .theological => "theological"
  | .interpretive => "interpretive"

/-- Which interpretive tradition advances a claim. -/
def tradition : Tradition → String
  | .christianTypological => "Christian, typological"
  | .christianHistoricalGrammatical => "Christian, hist.-gramm."
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

/-- A paragraph column of the given width, as a fraction of `\textwidth`.

Ragged rather than justified. A narrow column set justified hyphenates
"typological" across three lines and puts rivers through what is left, and
every column that carries prose here is narrow. -/
def pcol (width : String) : String :=
  ">{\\raggedright\\arraybackslash}p{" ++ width ++ "\\textwidth}"

/-- The mark a scripture-only atom carries in the legend. -/
def scriptureOnlyMark : String := "\\textsuperscript{\\dag}"

/-- The legend: one row per atom, giving its claim, classification, who holds
it and where they say so. This is the assumption manifest, typeset.

Numbered once for the whole argument rather than once per package, as the
generated Markdown pages are: a document that sets four positions and three
objections against each other is read by comparing them, and that needs
$P_{9}$ to mean one thing throughout. -/
def legend [DecidableEq α] (cite : α → AtomMeta) (order : List α) : String :=
  let rows := order.zipIdx.map fun (a, i) =>
    let m := cite a
    let mark := if m.source.isScriptureOnly then scriptureOnlyMark else ""
    "$" ++ varName i ++ "$ & " ++ escape m.label ++ mark ++ " & " ++ kind m.kind ++
      " & " ++ tradition m.source.tradition ++ ", " ++ confidence m.source.confidence ++
      " & " ++ source m.source ++ " \\\\"
  "\\begin{longtable}{@{}r " ++ pcol "0.30" ++ " l " ++ pcol "0.19" ++ " " ++
    pcol "0.21" ++ "@{}}\n" ++
  "\\toprule\n & claim & kind & held & source \\\\\n\\midrule\n\\endhead\n" ++
  String.intercalate "\n" rows ++ "\n\\bottomrule\n\\end{longtable}\n\n" ++
  "\\noindent\\footnotesize " ++ scriptureOnlyMark ++
  " grounded in scripture alone: the reading is assumed, not argued for.\n" ++
  "\\normalsize\n"

/-! ### Docstring prose

A docstring is written in Markdown, because that is what a Lean docstring is
read as everywhere else. Getting it into the document means converting it, and
these are the pieces of that conversion. -/

/-- Take characters up to the first occurrence of `stop`, returning what came
before it and what follows it. `none` when `stop` never arrives, which is how
an unclosed marker falls back to being ordinary text. -/
private def upTo (stop : List Char) : List Char → Option (List Char × List Char) :=
  let rec go (acc : List Char) : List Char → Option (List Char × List Char)
    | [] => none
    | cs@(c :: rest) =>
      if stop.isPrefixOf cs then some (acc.reverse, cs.drop stop.length)
      else go (c :: acc) rest
  go []

/-- Escape a code span, letting it break.

A declaration name is a single unbreakable word to TeX, and
`lexicalCriticalUnderCompatibility` set in `\texttt` is wider than what is left
of the line it lands on, so it runs into the margin. `\allowbreak` gives the
line breaker somewhere to go, and the places it goes are the ones a reader
would break the name at themselves: after an underscore or a hyphen, and before
the capital that starts the next word of a camelCase name. -/
def codeEscape (s : String) : String :=
  let step := fun (acc, prev) (c : Char) =>
    let piece :=
      match c with
      | '_' => "\\_\\allowbreak{}"
      | '-' => "-\\allowbreak{}"
      | c =>
        if c.isUpper && prev.any (fun q => q.isLower || q.isDigit) then
          "\\allowbreak{}" ++ escape c.toString
        else escape c.toString
    (acc ++ piece, some c)
  (s.foldl step ("", none)).1

/-- Whether a URL is one a PDF can follow. A docstring may link to another page
of the documentation site, and a relative `.md` path means nothing in print, so
only absolute links become links. -/
def isAbsoluteUrl (u : String) : Bool := u.startsWith "http://" || u.startsWith "https://"

/-- Inline Markdown, as LaTeX: `code`, **bold**, *italic* and links, with
everything else escaped. Named `inlineProse` because `inline` is Lean's own.

Deliberately a scan rather than a parser. The markup in a docstring is never
nested more than one deep, and an unclosed marker is treated as the literal
character it is — which is what a reader of the source would expect, and what
keeps a stray asterisk from swallowing the rest of a paragraph. -/
partial def inlineProse (s : String) : String :=
  let rec go : List Char → String
    | [] => ""
    | '`' :: rest =>
      match upTo ['`'] rest with
      | some (body, after) =>
        "\\texttt{" ++ codeEscape (String.ofList body) ++ "}" ++ go after
      | none => escape "`" ++ go rest
    | '*' :: '*' :: rest =>
      match upTo ['*', '*'] rest with
      | some (body, after) => "\\textbf{" ++ go body ++ "}" ++ go after
      | none => escape "*" ++ go ('*' :: rest)
    | '*' :: rest =>
      match upTo ['*'] rest with
      | some (body, after) => "\\emph{" ++ go body ++ "}" ++ go after
      | none => escape "*" ++ go rest
    | '[' :: rest =>
      match upTo [']'] rest with
      | some (text, '(' :: afterOpen) =>
        match upTo [')'] afterOpen with
        | some (url, after) =>
          let u := String.ofList url
          let shown := go text
          (if isAbsoluteUrl u then "\\href{" ++ u ++ "}{" ++ shown ++ "}" else shown) ++ go after
        | none => escape "[" ++ go rest
      | _ => escape "[" ++ go rest
    | c :: rest => escape c.toString ++ go rest
  go s.toList

/-- A block of Lean or shell, set verbatim. Nothing in it is escaped, which is
the point.

Set one size down. A rendered statement is wrapped at `Pages.printWidth`, but a
string literal inside a pretty-printed value cannot be wrapped at all — the
Greek in `SolaFide`'s `newPerspectiveCite` is one line of 95 characters — and
`\small` is the difference between that reaching the margin and passing it. -/
def verbatim (body : String) : String :=
  "{\\small\\begin{verbatim}\n" ++ body ++ "\n\\end{verbatim}}\n"

/-- How deep a Markdown heading sits in the document.

A module docstring opens at `#` because it is written as the top of its own
page. In the document each argument is a `\section*`, so its docstrings start
one level below that. -/
def headingCommand : Nat → String
  | 0 | 1 => "\\subsection*"
  | 2 => "\\subsubsection*"
  | _ => "\\paragraph*"

/-- The `#`s a heading opens with, and the text after them. -/
private def headingParts (line : String) : Nat × String :=
  let hashes := (line.toList.takeWhile (· == '#')).length
  (hashes, (line.drop hashes).trimAscii.toString)

/-- Whether a table row is the `|---|---|` separator rather than data. -/
private def isSeparatorRow (cells : List String) : Bool :=
  !cells.isEmpty && cells.all fun c =>
    let t := c.trimAscii.toString
    !t.isEmpty && t.all fun ch => ch == '-' || ch == ':' || ch == ' '

/-- The cells of a Markdown table row, without the leading and trailing pipe. -/
private def rowCells (line : String) : List String :=
  let t := line.trimAscii.toString
  let inner := if t.startsWith "|" then t.drop 1 |>.toString else t
  let inner := if inner.endsWith "|" then inner.dropEnd 1 |>.toString else inner
  (inner.splitOn "|").map fun c => c.trimAscii.toString

/-- A column width as a fraction of `\textwidth`, so an n-column table fills
the measure however many columns it has. -/
private def columnWidth (n : Nat) : String :=
  let hundredths := if n == 0 then 90 else 90 / n
  "0." ++ (if hundredths < 10 then "0" ++ toString hundredths else toString hundredths)

/-- A Markdown table as a `longtable`, first row as the header. -/
def table (rows : List (List String)) : String :=
  match rows with
  | [] => ""
  | header :: body =>
    let n := header.length
    let spec := String.intercalate " " (List.replicate n (pcol (columnWidth n)))
    let render := fun (cells : List String) =>
      String.intercalate " & " (cells.map inlineProse) ++ " \\\\"
    "\\begin{longtable}{@{}" ++ spec ++ "@{}}\n\\toprule\n" ++
    render (header.map fun c => "**" ++ c ++ "**") ++ "\n\\midrule\n\\endhead\n" ++
    String.intercalate "\n" (body.map render) ++ "\n\\bottomrule\n\\end{longtable}\n"

/-- Whether a line opens or closes a fenced code block. -/
private def isFence (line : String) : Bool := (line.trimAscii.toString).startsWith "```"

/-- Whether a line starts a bullet item. -/
private def bulletBody (line : String) : Option String :=
  let t := line.trimAscii.toString
  if t.startsWith "- " || t.startsWith "* " || t.startsWith "+ " then
    some (t.drop 2).toString
  else none

/-- Whether a line starts a paragraph rather than some other block. -/
private def isPlain (line : String) : Bool :=
  let t := line.trimAscii.toString
  !t.isEmpty && !t.startsWith "#" && !t.startsWith "|" && !isFence line &&
    (bulletBody line).isNone

/-- Markdown prose as LaTeX.

Line-based, because that is how Markdown's block structure works: a run of
non-blank lines is a paragraph, a run of `|` lines is a table, a run of `- `
lines is a list, and anything between fences is left alone. -/
partial def prose (md : String) : String :=
  let rec go : List String → String
    | [] => ""
    | line :: rest =>
      if line.trimAscii.toString.isEmpty then go rest
      else if isFence line then
        let body := rest.takeWhile (!isFence ·)
        verbatim (String.intercalate "\n" body) ++ go (rest.drop (body.length + 1))
      else if line.startsWith "#" then
        let (level, text) := headingParts line
        headingCommand level ++ "{" ++ inlineProse text ++ "}\n" ++
        (if level >= 3 then "\\leavevmode\\par\n" else "") ++ go rest
      else if line.trimAscii.toString.startsWith "|" then
        let block := (line :: rest).takeWhile fun l => l.trimAscii.toString.startsWith "|"
        let cells := (block.map rowCells).filter (!isSeparatorRow ·)
        table cells ++ go (rest.drop (block.length - 1))
      else if (bulletBody line).isSome then
        let block := (line :: rest).takeWhile fun l => (bulletBody l).isSome
        let items := block.filterMap bulletBody
        "\\begin{itemize}\n" ++
        String.join (items.map fun i => "  \\item " ++ inlineProse i ++ "\n") ++
        "\\end{itemize}\n" ++ go (rest.drop (block.length - 1))
      else
        let block := (line :: rest).takeWhile isPlain
        inlineProse (String.intercalate " " block) ++ "\n\n" ++ go (rest.drop (block.length - 1))
  go (md.splitOn "\n")

/-! ### The page

The same harvest the documentation site renders, set for print. -/

/-- The label a declaration is introduced by.

Declarations are not headings, for the reason the Markdown renderer gives: the
document's heading structure is the prose's own, and a heading per declaration
would bury it under sixty entries of scaffolding.

The leading `\par` is load-bearing. `\noindent` does not start a paragraph, so
without it a label after a one-line note — "Grounded in scripture alone: …" —
sets on the same line as the note and reads as part of it. `\nobreak` keeps the
label with the docstring it introduces, and the trailing `\noindent` keeps that
docstring from being indented away from it. -/
def declLabel (d suffix : String) : String :=
  "\\par\\medskip\\noindent\\textbf{\\texttt{" ++ codeEscape d ++ "}}" ++ suffix ++
    "\\par\\nobreak\\noindent\n"

/-- Numbered premises above a turnstile. -/
def derivation [DecidableEq α] (order : List α) (prems : List (Formula α))
    (concl : Formula α) : String :=
  let rows := prems.zipIdx.map fun (φ, i) =>
    "  \\text{(" ++ toString (i + 1) ++ ")} \\quad & " ++ formula order φ ++ " \\\\"
  "\\begin{align*}\n" ++
  (if rows.isEmpty then "" else String.intercalate "\n" rows ++ "\n") ++
  "  \\vdash \\quad & " ++ formula order concl ++ "\n\\end{align*}\n"

/-- Which of a package's premises are grounded in scripture alone, as a note
under its derivation. -/
def scriptureNote [DecidableEq α] (pkg : ArgumentPackage α) : String :=
  if pkg.scriptureOnlyAtoms.isEmpty then
    "\\emph{No premise here rests on scripture alone.}\n"
  else
    "\\emph{Grounded in scripture alone:} " ++
    String.intercalate ", " (pkg.scriptureOnlyAtoms.map fun m => escape m.label) ++ ".\n"

/-- Render one item against the document's atom ordering. -/
def item [DecidableEq α] (order : List α) : Page.Item α → String
  | .prose md => prose md
  | .package d doc pkg =>
      declLabel d (" --- " ++ escape pkg.name) ++ prose doc ++
      derivation order pkg.premises pkg.conclusion ++ scriptureNote pkg
  | .line d doc l =>
      declLabel d (" --- " ++ escape l.name) ++ prose doc ++
      derivation order l.premises l.delivers
  | .formula d doc φ =>
      declLabel d "" ++ prose doc ++ "\\[" ++ formula order φ ++ "\\]\n"
  | .formulas d doc φs =>
      declLabel d "" ++ prose doc ++
      "\\begin{align*}\n" ++ String.intercalate "\n"
        (φs.zipIdx.map fun (φ, i) =>
          "  \\text{(" ++ toString (i + 1) ++ ")} \\quad & " ++ formula order φ ++ " \\\\") ++
      "\n\\end{align*}\n"
  | .other d doc src => declLabel d "" ++ prose doc ++ verbatim src
  | .result d doc stmt proposed =>
      declLabel d (if proposed then " \\textsuperscript{(proposed)}" else "") ++
      prose doc ++ verbatim stmt

/-- One argument's body: its introductory prose, its legend, then every item in
source order. The heading above it is the caller's, as the page title is in the
Markdown rendering. -/
def body [DecidableEq α] (allAtoms : List α) (intro : List (Page.Item α))
    (items : List (Page.Item α)) : String :=
  let all := intro ++ items
  let order := atomOrder allAtoms all
  let legendPart := match citeOf all with
    | some cite => "\\subsection*{The claims, numbered}\n" ++ legend cite order ++ "\n"
    | none => ""
  String.join (intro.map (item order)) ++ legendPart ++
  String.join (items.map (item order))

/-- A starred section heading for one argument, put into the table of contents
by hand because a starred section does not do it for itself. -/
def sectionHeading (title : String) : String :=
  "\\clearpage\n\\section*{" ++ escape title ++ "}\n" ++
  "\\addcontentsline{toc}{section}{" ++ escape title ++ "}\n\n"

/-- Preamble for a standalone document. Needs XeLaTeX or LuaLaTeX: the claims
contain Greek and Hebrew, and the rendered Lean contains `¬`, `→` and `⊢`.

The fonts are chosen rather than demanded. `\setmainfont{Times New Roman}` was
a hard requirement, and on a machine without it — which is most machines that
are not someone's laptop — `tectonic arguments.tex` failed at line 4 with a
fontspec error, so the PDF half of the toolchain only ever worked for whoever
had already made it work. Each family now falls back, and the monospace one
matters as much as the body one: the default `\ttfamily` has no glyph for the
logical symbols the rendered statements are full of. -/
def preamble (title : String) : String :=
  "\\documentclass[11pt]{article}\n" ++
  "\\usepackage{amsmath,amssymb,array,booktabs,longtable,geometry,fontspec}\n" ++
  "\\usepackage[hidelinks]{hyperref}\n" ++
  "\\geometry{margin=1in}\n" ++
  -- Long unbreakable words — a cite key, a declaration name in \\texttt — would
  -- otherwise spill into the margin rather than loosening the line.
  "\\setlength{\\emergencystretch}{3em}\n" ++
  "\\IfFontExistsTF{Times New Roman}\n" ++
  "  {\\setmainfont{Times New Roman}[Ligatures=TeX]}\n" ++
  "  {\\IfFontExistsTF{FreeSerif}{\\setmainfont{FreeSerif}[Ligatures=TeX]}{}}\n" ++
  "\\IfFontExistsTF{DejaVu Sans Mono}\n" ++
  "  {\\setmonofont{DejaVu Sans Mono}[Scale=MatchLowercase]}\n" ++
  "  {\\IfFontExistsTF{FreeMono}{\\setmonofont{FreeMono}[Scale=MatchLowercase]}{}}\n" ++
  "\\title{" ++ escape title ++ "}\n" ++
  "\\date{Generated by \\texttt{lake exe argtex}}\n" ++
  "\\begin{document}\n\\maketitle\n"

/-- The table of contents, which the starred sections opt into by hand. -/
def contents : String := "\\tableofcontents\n"

/-- Closing matter, including the bibliography built from `references.bib`. -/
def postamble : String :=
  "\n\\bibliographystyle{plain}\n\\bibliography{references}\n\\end{document}\n"


/-! ### Golden tests

These pin what the prose converter emits, the way `Bib.Render`'s pin the
bibliography. A change to the converter that alters the document fails the
build rather than silently rewriting `docs/latex/arguments.tex`. -/

#guard inlineProse "a `code` span" == "a \\texttt{code} span"

-- A declaration name is one unbreakable word to TeX, and a long one runs into
-- the margin; the breaks go where a reader would put them.
#guard inlineProse "`a_b-c`" == "\\texttt{a\\_\\allowbreak{}b-\\allowbreak{}c}"
#guard inlineProse "`camelCase2X`" ==
  "\\texttt{camel\\allowbreak{}Case2\\allowbreak{}X}"
#guard inlineProse "**bold** and *italic*" == "\\textbf{bold} and \\emph{italic}"
#guard inlineProse "**a `cite` in bold**" == "\\textbf{a \\texttt{cite} in bold}"

-- The characters TeX reads as commands must arrive as themselves.
#guard inlineProse "100% of 2_3 & more" == "100\\% of 2\\_3 \\& more"

-- An unclosed marker is the character it is, not the start of an emphasis that
-- swallows the rest of the paragraph.
#guard inlineProse "an *unclosed marker" == "an *unclosed marker"

-- A relative link means nothing in print, so it keeps its text and loses its
-- target; an absolute one stays a link.
#guard inlineProse "[the site](https://example.com)" ==
  "\\href{https://example.com}{the site}"
#guard inlineProse "[a page](./roadmap.md)" == "a page"

-- A paragraph is a run of lines, joined; a module docstring's `#` sits one
-- level below the argument's own section.
#guard prose "# Title\n\nA paragraph\nover two lines.\n" ==
  "\\subsection*{Title}\nA paragraph over two lines.\n\n"

-- `\paragraph*` is run-in, so a heading at that depth has to be made to break.
#guard prose "### Deep\n\ntext" == "\\paragraph*{Deep}\n\\leavevmode\\par\ntext\n\n"

-- The separator row is dropped and the header row set bold; the columns share
-- the measure between them.
#guard prose "| a | b |\n|---|---|\n| 1 | 2 |\n" ==
  "\\begin{longtable}{@{}" ++ pcol "0.45" ++ " " ++ pcol "0.45" ++ "@{}}\n" ++
  "\\toprule\n\\textbf{a} & \\textbf{b} \\\\\n\\midrule\n\\endhead\n" ++
  "1 & 2 \\\\\n\\bottomrule\n\\end{longtable}\n"

#guard prose "- one\n- two\n\nafter" ==
  "\\begin{itemize}\n  \\item one\n  \\item two\n\\end{itemize}\nafter\n\n"

-- Nothing inside a fence is escaped, and the prose after it resumes.
#guard prose "```sh\nlake build\n```\n\nafter" ==
  "{\\small\\begin{verbatim}\nlake build\n\\end{verbatim}}\nafter\n\n"

end Testimony.Logic.Latex
