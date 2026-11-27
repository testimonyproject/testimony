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

## Every variable a link, every claim in words

A numbered variable asks the reader to turn back to the legend, and the cost
falls hardest where a claim first comes in and where a step gives one. So every
variable in a formula is a link to its row in the legend, and a derivation puts
its claims in words on three kinds of row: a premise that is a claim, which the
position holds; a step, by what it *would give*, whether or not the position
holds what the step needs; and the turnstile row, by the conclusion *at issue*,
whether or not the premises reach it. Inside a derivation, a claim met only
inside a step is left to its link. The words are the legend's label, run on
after the formula and wrapping beneath it.

A step that stands alone, as a line of reason does under its docstring, has no
rows above it to have said its claims, so it is built up from them instead
(`step`): each claim it needs, in words, with its rating and source; then what
they give, after the "therefore" sign (∴); then the formula. The reader meets
the claims in the order the step uses them, and the formula comes last, as a
summary.

The marks are there because the words are read as sentences. Unmarked, a step's
words in a rival's package read as the rival conceding them, and the turnstile's
words under a refuted package as the conclusion reached. Nor is the conclusion
always the position's aim: the positions an argument sets side by side are often
asked about one thesis, so a rival's package can end at the very thesis it
denies.

They are the label whole, not a shorter name for it. What to call a disputed
claim in four words is a judgement — a short name for "the phrase means A, not
B" keeps the A and drops the "not B" the dispute is about — and the label is the
wording its sources were checked against.

The site's renderer borrows `formula` and gets plain variables: a link here is
a TeX command, which MathJax does not know. So do headings, whose text is
written out to the table of contents, where a link does not survive.

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

/-- Escape the characters TeX treats specially, one by one and nothing else.
Greek and Hebrew pass through: the preamble selects a Unicode engine. Code is
escaped with this alone, because a quotation mark in code is the character
itself. -/
def escapeChars (s : String) : String :=
  s.foldl (init := "") fun acc c =>
    acc ++ match c with
      | '&' => "\\&" | '%' => "\\%" | '$' => "\\$" | '#' => "\\#"
      | '_' => "\\_" | '{' => "\\{" | '}' => "\\}"
      | '~' => "\\textasciitilde{}" | '^' => "\\textasciicircum{}"
      | '\\' => "\\textbackslash{}"
      | c => c.toString

/-- Whether a quotation mark between these two characters opens a quotation: at
the start of the text, after a space, or after an opening bracket, a dash or
another opening mark. After Markdown emphasis (`*`, `_`) the mark may open or
close a quotation, so the next character decides: a word after it, and it
opens. -/
def opensQuote (prev next : Option Char) : Bool :=
  match prev with
  | none => true
  | some c =>
    c.isWhitespace || "([{—–-/“‘".contains c ||
      ("*_".contains c && next.any fun n => n.isAlphanum || "([“‘".contains n)

/-- **Typographic quotation marks for straight ones.** A docstring types `"` and
`'`; TeX sets a straight double quote as a closing mark wherever it stands, so
every quotation opened with the wrong one. Each mark becomes an opening or a
closing curly mark by what surrounds it, and an apostrophe stays an apostrophe
(`’`). Text between backticks is code, and is left alone. -/
def smartQuotes (s : String) : String :=
  let rec /-- The marks set so far, with the character before and whether it is in code. -/
    go (prev : Option Char) (inCode : Bool) : List Char → List Char
    | [] => []
    | '`' :: rest => '`' :: go (some '`') (!inCode) rest
    | c :: rest =>
      if inCode then c :: go (some c) inCode rest
      else
        let c' := match c with
          | '"' => if opensQuote prev rest.head? then '“' else '”'
          | '\'' => if opensQuote prev rest.head? then '‘' else '’'
          | c => c
        c' :: go (some c') inCode rest
  String.ofList (go none false s.toList)

/-- Escape prose for TeX: typographic quotation marks, then the special
characters. -/
def escape (s : String) : String := escapeChars (smartQuotes s)

/-- A propositional variable, subscripted by its position in the legend. -/
def varName (i : Nat) : String := "P_{" ++ toString (i + 1) ++ "}"

/-- The name an argument's links are made from: its namespace, with every
character but a letter, a digit or a dot written as its code point between
hyphens. Nothing in it then means anything to TeX or to a PDF viewer, and no
character is dropped, so no two namespaces — and no two arguments — share a
name. -/
def anchorName (ns : String) : String :=
  ns.foldl (init := "") fun acc c =>
    acc ++ if c.isAlphanum || c == '.' then c.toString else "-" ++ toString c.toNat ++ "-"

/-- A propositional variable as a link to its row in the legend, through the
preamble's `\pvar`. Variables are numbered once per argument and a document
sets several, so the link names the argument as well as the number. With no
argument to name, the variable is set plain. -/
def varLink (anchor : String) (i : Nat) : String :=
  if anchor.isEmpty then varName i
  else "\\pvar{" ++ anchor ++ "}{" ++ toString (i + 1) ++ "}"

/-- The mark a legend row carries for its variable's links to land on, through
the preamble's `\pvartarget`; nothing, where nothing links. -/
def varTarget (anchor : String) (i : Nat) : String :=
  if anchor.isEmpty then ""
  else "\\pvartarget{" ++ anchor ++ "}{" ++ toString (i + 1) ++ "}"

/-- Parenthesise only where the surrounding precedence requires it. -/
def wrap (ctx prec : Nat) (s : String) : String :=
  if ctx > prec then "(" ++ s ++ ")" else s

/-- Render a formula in traditional notation.

Precedence-aware, so nothing carries more parentheses than it needs: `¬` binds
tighter than `∧`, which binds tighter than `∨`, which binds tighter than `→`.
Conjunction and disjunction are associative and render flat. The antecedent of
an implication is parenthesised even though precedence does not require it,
because that is how a reader expects to see it.

`φ → ⊥` renders as `¬φ` rather than as an implication. `var` sets a variable
from its position: `varName` plainly, `varLink` as a link. -/
partial def formulaPrec [DecidableEq α] (var : Nat → String) (order : List α) (ctx : Nat) :
    Formula α → String
  | .atom a => var (order.idxOf a)
  | .falsum => "\\bot"
  | .imp p .falsum => wrap ctx 40 ("\\lnot " ++ formulaPrec var order 41 p)
  | .and p q =>
      wrap ctx 30 (formulaPrec var order 30 p ++ " \\land " ++ formulaPrec var order 30 q)
  | .or p q =>
      wrap ctx 20 (formulaPrec var order 20 p ++ " \\lor " ++ formulaPrec var order 20 q)
  | .imp p q =>
      wrap ctx 10 (formulaPrec var order 31 p ++ " \\rightarrow " ++ formulaPrec var order 10 q)

/-- Render a formula at the top level, where nothing needs wrapping, with plain
variables. The Markdown renderer sets its formulas with this. -/
def formula [DecidableEq α] (order : List α) (φ : Formula α) : String :=
  formulaPrec varName order 0 φ

/-- What the document needs to refer to an argument's claims: their numbering,
the argument the numbers belong to, and what each claim says. `cite` is the
legend's, so a gloss is always the legend's own words. -/
structure Numbering (α : Type) where
  /-- The atoms, in legend order: an atom's variable is its position here. -/
  order : List α
  /-- The argument, as its variables' links name it (`anchorName`); empty, and
  the variables are set plain, where there is no legend to link to. -/
  anchor : String := ""
  /-- Each claim's citation, as the legend gives it; `none` where there is no
  legend, and nothing is glossed. -/
  cite : Option (α → AtomMeta) := none

/-- A formula with each variable a link to its row in the legend. -/
def linked [DecidableEq α] (n : Numbering α) (φ : Formula α) : String :=
  formulaPrec (varLink n.anchor) n.order 0 φ

/-- One atom's variable, linked, as inline mathematics. -/
def linkedVar [DecidableEq α] (n : Numbering α) (a : α) : String :=
  "\\(" ++ varLink n.anchor (n.order.idxOf a) ++ "\\)"

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
      String.intercalate "; " (refs.map fun r => escape r.render)
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
  | .interpretive => "interpretive" | .empirical => "empirical"

/-- Which interpretive tradition advances a claim. -/
def tradition : Tradition → String
  | .christianTypological => "Christian, typological"
  | .christianHistoricalGrammatical => "Christian, hist.-gramm."
  | .secondTempleJewish => "Second Temple Jewish"
  | .rabbinicJewish => "rabbinic Jewish"
  | .criticalScholarship => "critical scholarship"
  | .reformedProtestant => "Reformed Protestant"
  | .romanCatholic => "Roman Catholic"
  | .arminian => "Arminian"
  | .easternOrthodox => "Eastern Orthodox"
  | .jehovahsWitness => "Jehovah's Witnesses"
  | .onenessPentecostal => "Oneness Pentecostal"
  | .adversarialTrial => "adversarial trial"
  | .formalOntology => "formal ontology"

/-- How firmly that tradition holds it. -/
def confidence : Confidence → String
  | .refuted => "refuted"
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
$P_{9}$ to mean one thing throughout. Each row is the target its variable's
links land on. -/
def legend (n : Numbering α) (cite : α → AtomMeta) : String :=
  let order := n.order
  let rows := order.zipIdx.map fun (a, i) =>
    let m := cite a
    let mark := if m.readsScriptureAlone then scriptureOnlyMark else ""
    varTarget n.anchor i ++ "$" ++ varName i ++ "$ & " ++ escape m.label ++ mark ++ " & " ++
      kind m.kind ++
      " & " ++ tradition m.source.tradition ++ ", " ++ confidence m.source.confidence ++
      " & " ++ source m.source ++ " \\\\"
  "\\begin{longtable}{@{}r " ++ pcol "0.30" ++ " l " ++ pcol "0.19" ++ " " ++
    pcol "0.21" ++ "@{}}\n" ++
  "\\toprule\n & claim & kind & held & source \\\\\n\\midrule\n\\endhead\n" ++
  String.intercalate "\n" rows ++ "\n\\bottomrule\n\\end{longtable}\n\n" ++
  (if order.any fun a => (cite a).readsScriptureAlone then
    "\\noindent\\footnotesize " ++ scriptureOnlyMark ++
    " a reading cited to the text alone, with no commentator: it is assumed here, " ++
    "not argued for.\n" ++
    "\\normalsize\n"
  else "")

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
          "\\allowbreak{}" ++ escapeChars c.toString
        else escapeChars c.toString
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
  let rec /-- The characters still to set. -/
    go : List Char → String
    | [] => ""
    | '`' :: rest =>
      match upTo ['`'] rest with
      | some (body, after) =>
        "\\texttt{" ++ codeEscape (String.ofList body) ++ "}" ++ go after
      | none => escapeChars "`" ++ go rest
    | '*' :: '*' :: rest =>
      match upTo ['*', '*'] rest with
      | some (body, after) => "\\textbf{" ++ go body ++ "}" ++ go after
      | none => escapeChars "*" ++ go ('*' :: rest)
    | '*' :: rest =>
      match upTo ['*'] rest with
      | some (body, after) => "\\emph{" ++ go body ++ "}" ++ go after
      | none => escapeChars "*" ++ go rest
    | '[' :: rest =>
      match upTo [']'] rest with
      | some (text, '(' :: afterOpen) =>
        match upTo [')'] afterOpen with
        | some (url, after) =>
          let u := String.ofList url
          let shown := go text
          (if isAbsoluteUrl u then "\\href{" ++ u ++ "}{" ++ shown ++ "}" else shown) ++ go after
        | none => escapeChars "[" ++ go rest
      | _ => escapeChars "[" ++ go rest
    | c :: rest => escapeChars c.toString ++ go rest
  go (smartQuotes s).toList

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

/-- Whether a line continues the list item above it: indented, and not a new
item or a fence. -/
private def continuesItem (line : String) : Bool :=
  line.startsWith " " && !line.trimAscii.toString.isEmpty && (bulletBody line).isNone &&
    !isFence line

/-- The text of a block-quote line, with its `>` and one following space taken
off, or `none` if the line is not part of a quotation. -/
private def quoteBody (line : String) : Option String :=
  let t := line.trimAsciiStart.toString
  if t.startsWith ">" then
    let rest := (t.drop 1).toString
    some (if rest.startsWith " " then (rest.drop 1).toString else rest)
  else none

/-- Whether a line starts a paragraph rather than some other block. -/
private def isPlain (line : String) : Bool :=
  let t := line.trimAscii.toString
  !t.isEmpty && !t.startsWith "#" && !t.startsWith "|" && !isFence line &&
    (bulletBody line).isNone && (quoteBody line).isNone

/-- Markdown prose as LaTeX.

Line-based, because that is how Markdown's block structure works: a run of
non-blank lines is a paragraph, a run of `|` lines is a table, a run of `- `
lines is a list, a run of `>` lines is a quotation, and anything between fences
is left alone. A quotation's lines, their `>` taken off, are prose in their own
right, so a quote may hold several paragraphs or a list. -/
partial def prose (md : String) : String :=
  let rec /-- The lines still to set. -/
    go : List String → String
    | [] => ""
    | line :: rest =>
      if line.trimAscii.toString.isEmpty then go rest
      else if isFence line then
        let body := rest.takeWhile (!isFence ·)
        verbatim (String.intercalate "\n" body) ++ go (rest.drop (body.length + 1))
      else if line.startsWith "#" then
        let (level, text) := headingParts line
        headingCommand level ++ "{" ++ inlineProse text ++ "}\n" ++
        (if level >= 3 then "\\leavevmode\\par\\nobreak\n" else "") ++ go rest
      else if line.trimAscii.toString.startsWith "|" then
        let block := (line :: rest).takeWhile fun l => l.trimAscii.toString.startsWith "|"
        let cells := (block.map rowCells).filter (!isSeparatorRow ·)
        table cells ++ go (rest.drop (block.length - 1))
      else if (quoteBody line).isSome then
        let block := (line :: rest).takeWhile fun l => (quoteBody l).isSome
        "\\begin{quote}\n" ++ prose (String.intercalate "\n" (block.filterMap quoteBody)) ++
        "\\end{quote}\n" ++ go (rest.drop (block.length - 1))
      else if (bulletBody line).isSome then
        -- An item's wrapped lines are part of it: Markdown reads an indented
        -- line under an item as its continuation, and so does this.
        let block := (line :: rest).takeWhile fun l => (bulletBody l).isSome || continuesItem l
        let items := block.foldl (init := #[]) fun acc l =>
          match bulletBody l with
          | some b => acc.push b
          | none => acc.modify (acc.size - 1) (· ++ " " ++ l.trimAscii.toString)
        "\\begin{itemize}\n" ++
        String.join (items.toList.map fun i => "  \\item " ++ inlineProse i ++ "\n") ++
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
without it a label after a one-line note — "Read from the text alone …" —
sets on the same line as the note and reads as part of it. `\nobreak` keeps the
label with the docstring it introduces, and the trailing `\noindent` keeps that
docstring from being indented away from it. -/
def declLabel (d suffix : String) : String :=
  "\\par\\medskip\\noindent\\textbf{\\texttt{" ++ codeEscape d ++ "}}" ++ suffix ++
    "\\par\\nobreak\\noindent\n"

/-- The claims a formula is made of, when it is nothing but claims and denied
claims joined by `∧`: each atom, with whether it is denied. `none` for any other
shape — a step, a disjunction, a denied conjunction — which is not a list of
claims. -/
def literals : Formula α → Option (List (α × Bool))
  | .atom a => some [(a, false)]
  | .imp (.atom a) .falsum => some [(a, true)]
  | .and p q => do pure ((← literals p) ++ (← literals q))
  | _ => none

/-- What a row's words are, as the marks before them say: for a claim, and for a
claim denied. -/
structure Lead where
  /-- The mark before a claim; empty for none. -/
  claim : String
  /-- The mark before a denied claim. -/
  denial : String

/-- A premise's words: what the position holds, so a claim is unmarked. -/
def Lead.held : Lead := ⟨"", "denied"⟩

/-- A step's words: what it would give, if what it needs were held. -/
def Lead.step : Lead := ⟨"would give", "would deny"⟩

/-- The turnstile row's words: the conclusion the premises are asked about. -/
def Lead.atIssue : Lead := ⟨"at issue", "at issue, the denial of"⟩

/-- What a formula says, in its claims' own words, when it is a list of claims
(`literals`): one claim is its label, and a denied one is marked so; of several,
each is named by its variable, since the reader is matching words to the formula
beside them. `lead` says what the words are.

The renderer supplies how a variable is set, how a claim's label is escaped and
how a mark is set. Print and the site both say a derivation's words through
this, so the two cannot come to say different ones. -/
def inWordsWith (var label : α → String) (mark : String → String) (lead : Lead)
    (φ : Formula α) : Option String :=
  (literals φ).map fun claims =>
    let mark' (s : String) := if s.isEmpty then "" else mark s
    match claims with
    | [(a, true)] => mark' lead.denial ++ label a
    | [(a, false)] => mark' lead.claim ++ label a
    | _ => mark' lead.claim ++ String.intercalate "; " (claims.map fun (a, denied) =>
        var a ++ " " ++ (if denied then mark' Lead.held.denial else "") ++ label a)

/-- `inWordsWith`, set for print: a linked variable, an escaped label, and the mark
in italics. -/
def inWords [DecidableEq α] (n : Numbering α) (cite : α → AtomMeta) (lead : Lead)
    (φ : Formula α) : Option String :=
  inWordsWith (linkedVar n) (fun a => escape (cite a).label)
    (fun s => "\\emph{" ++ s ++ ":} ") lead φ

/-- The words a row of a derivation carries, if any, given how a renderer says a
formula in words.

A premise that is a claim, or a list of them, says it: it is what the position
holds. A step says what it *would give*: a step is a conditional, and holding it
is not holding what it needs — in a rival's package it often does not. A step
that gives the conclusion leaves it to the turnstile row. A
step's antecedent is not glossed: a claim there is in words on the row where it
is a premise, if it is one, and is otherwise left to its link. -/
def glossWith [DecidableEq α] (words : Lead → Formula α → Option String)
    (concl : Option (Formula α)) (φ : Formula α) : Option String :=
  match φ with
  | .imp _ .falsum => words .held φ
  | .imp _ q => if concl == some q then none else words .step q
  | _ => words .held φ

/-- The words of a lone formula, which is no position's premise: what a step would
give. A claim, or a list of them, is left to its links, since nothing here holds
it. -/
def loneGlossWith [DecidableEq α] (words : Lead → Formula α → Option String)
    (φ : Formula α) : Option String :=
  match φ with
  | .imp _ .falsum => none
  | .imp _ _ => glossWith words none φ
  | _ => none

/-- `glossWith`, set for print. Nothing is glossed without a legend to take the
words from. -/
def gloss [DecidableEq α] (n : Numbering α) (concl : Option (Formula α)) (φ : Formula α) :
    Option String :=
  n.cite.bind fun cite => glossWith (inWords n cite) concl φ

/-- `loneGlossWith`, set for print. -/
def loneGloss [DecidableEq α] (n : Numbering α) (φ : Formula α) : Option String :=
  n.cite.bind fun cite => loneGlossWith (inWords n cite) φ

/-- A step whose grounds and whose result are each a list of claims
(`literals`): the claims it needs, then the claims it gives. `none` for any
other shape, which is set as a single formula. A denial is no step: it gives
nothing to build up to. -/
def stepClaims : Formula α → Option (List (α × Bool) × List (α × Bool))
  | .imp _ .falsum => none
  | .imp p q => do pure ((← literals p), (← literals q))
  | _ => none

/-- A claim as a formula: the atom, or its denial. -/
def literal (a : α) (denied : Bool) : Formula α :=
  if denied then .imp (.atom a) .falsum else .atom a

/-- The sentence a step built up from its claims opens with, in print and on the
site alike. -/
def stepOpening : String := "If each of these holds,"

/-- The words that close a step built up from its claims, before its formula. -/
def stepSymbols : String := "In symbols, the step is"

/-- One row of a derivation: how it starts (an `\item` with its label, or the
preamble's `\breakrow` where a page may break before it), its formula, and the
formula's words after a dash, through the preamble's `\gloss`. -/
def row [DecidableEq α] (n : Numbering α) (start : String) (φ : Formula α)
    (words : Option String) : String :=
  "  " ++ start ++ " \\(" ++ linked n φ ++ "\\)" ++
    (match words with | some w => "\\gloss{" ++ w ++ "}" | none => "") ++ "\n"

/-- Whether a page may break before row `i` of a derivation of `count` rows: only
where it leaves three rows or more on each side. So a derivation of five rows or
fewer never breaks, and a long one never leaves its first rows, or its
conclusion, alone on a page. -/
def breakable (i count : Nat) : Bool := 3 ≤ i && 3 ≤ count - i

/-- The start of numbered row `i` of a derivation of `count` rows. -/
def numbered (i count : Nat) : String :=
  let label := "(" ++ toString (i + 1) ++ ")"
  if breakable i count then "\\breakrow{" ++ label ++ "}" else "\\item[" ++ label ++ "]"

/-- Rows of a derivation, as the preamble's `derivation` list.

A list rather than an `align*`, so the words can wrap: they run on after their
formula and continue beneath it, and a long derivation can break across pages,
which an `align*` cannot — where `breakable` lets it. A `note` set under the
rows is kept with them, through the preamble's `\keepwithnext`. -/
def rows (body : String) (note : String := "") : String :=
  "\\begin{derivation}\n" ++ body ++ (if note.isEmpty then "" else "  \\keepwithnext\n") ++
    "\\end{derivation}\n" ++ note

/-- Numbered premises above a turnstile, each with its words where `gloss` gives
them, and on the turnstile row the conclusion at issue; then `note`, if any, kept
with them. -/
def derivation [DecidableEq α] (n : Numbering α) (prems : List (Formula α))
    (concl : Formula α) (note : String := "") : String :=
  rows (note := note) <|
    String.join (prems.zipIdx.map fun (φ, i) =>
      row n (numbered i (prems.length + 1)) φ (gloss n (some concl) φ)) ++
    row n "\\item[\\(\\vdash\\)]" concl (n.cite.bind fun cite => inWords n cite .atIssue concl)

/-- A claim set as a step sets it: its variable, linked, then its words, a denied
claim marked so. -/
def claimWords [DecidableEq α] (n : Numbering α) (cite : α → AtomMeta) (a : α)
    (denied : Bool) : String :=
  "\\(" ++ linked n (literal a denied) ++ "\\)\\enspace " ++
    (if denied then "\\emph{" ++ Lead.held.denial ++ ":} " else "") ++ escape (cite a).label

/-- One claim a step needs, in its own words, with how firmly it is held and who
holds it: so a reader meets the claim where the step uses it, and need not turn
to the legend. -/
def groundRow [DecidableEq α] (n : Numbering α) (cite : α → AtomMeta) (start : String)
    (a : α) (denied : Bool) : String :=
  "  " ++ start ++ " " ++ claimWords n cite a denied ++
    "\\gloss{" ++ confidence (cite a).source.confidence ++ ": " ++ source (cite a).source ++
    "}\n"

/-- **A step, built up from its claims.** A step written as a formula,
`(P₂ ∧ P₃ ∧ P₈) → P₂₅`, names its claims by number and leaves the reader to look
each one up. Set this way, the step is read in the order a reader follows it:
each claim it needs, in words, with its rating and its source; then what those
claims together give, after the "therefore" sign (∴); and only then the
formula, which says the same in symbols. The formula is kept, and every
variable in it still links to the legend, so nothing a logician reads is lost.

A step that is not a list of claims leading to a list of claims, or a page with
no legend to take the words from, is set as one row, as before. -/
def step [DecidableEq α] (n : Numbering α) (φ : Formula α) : String :=
  match n.cite, stepClaims φ with
  | some cite, some (needs, gives) =>
    let count := needs.length + gives.length
    "\\par\\smallskip\\noindent " ++ stepOpening ++ "\n" ++
    rows (String.join (needs.zipIdx.map fun ((a, d), i) =>
        groundRow n cite (numbered i count) a d) ++
      String.join (gives.map fun (a, d) =>
        "  \\item[\\(\\therefore\\)] " ++ claimWords n cite a d ++ "\n")) ++
    "\\noindent " ++ stepSymbols ++ " \\(" ++ linked n φ ++ "\\).\n"
  | _, _ => rows (row n "\\item[]" φ (loneGloss n φ))

/-- **A source in words.** Who holds a claim or a step, where, and how firmly,
as a sentence: the rating and the tradition, then every reference, the primary
first. It is the legend's "held" and "source" columns, said for one source on
its own, so a rating that stands under a step's docstring reads as the legend
does and not as the Lean that records it. -/
def sourceWords (s : Source) : String :=
  "\\par\\smallskip\\noindent Rated \\emph{" ++ confidence s.confidence ++ "}, held in the " ++
    escape (tradition s.tradition) ++ " tradition: " ++ source s ++ ".\n"

/-- **A claim's citation in words**: the claim, what kind of claim it is, and
its source as `sourceWords` gives it. -/
def claimWords' (m : AtomMeta) : String :=
  "\\par\\smallskip\\noindent The claim: \\emph{" ++ escape m.label ++ "} (" ++ kind m.kind ++
    ")." ++ sourceWords m.source

/-- **A reading in words.** A reading written as a valuation says, of every
claim, whether it is true; set as Lean it is a `match` over the claims'
names. In words it is the claims it takes as false, each with its words and
its link to the legend, and the rest taken as true; or, where it takes fewer
as true, those, and the rest as false. A claim the page never mentions is left
out, since nothing on the page turns on it. -/
def readingWords [DecidableEq α] (n : Numbering α) (truth : List (α × Bool)) : String :=
  match n.cite with
  | none => ""
  | some cite =>
    let onPage := truth.filter fun (a, _) => n.order.contains a
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
    if listed.isEmpty then "\\par\\smallskip\\noindent " ++ rest ++ "\n"
    else
      "\\par\\smallskip\\noindent " ++ lead ++ "\n" ++
      rows (String.join (listed.map fun (a, _) =>
        "  \\item[] " ++ claimWords n cite a false ++ "\n")) ++
      "\\noindent " ++ rest ++ "\n"

/-- **A citation function in words.** A function from claims to their
citations is, set as Lean, a `match` that runs to pages, and its signature alone
says nothing. In words it is what it cites differently from the table of
numbered claims: each such claim on the page with its variable, linked, its
words, what kind of claim it is, how firmly it is held and its references; and
then that it cites every other claim on the page as the table does. A function
that cites every claim as the table does says so, and on a page with no table
every claim on the page is listed. A claim the page never mentions is left out,
since nothing on the page turns on it. -/
def citationWords [DecidableEq α] (n : Numbering α) (cite : α → AtomMeta) : String :=
  let row (a : α) : String :=
    "  \\item[] " ++ claimWords n cite a false ++
      "\\gloss{" ++ kind (cite a).kind ++ "; " ++ confidence (cite a).source.confidence ++
      ": " ++ source (cite a).source ++ "}\n"
  match n.cite with
  | none =>
    if n.order.isEmpty then ""
    else
      "\\par\\smallskip\\noindent It cites each claim on this page so:\n" ++
      rows (String.join (n.order.map row))
  | some legendCite =>
    match Page.citedOtherwise n.order legendCite cite with
    | [] =>
      "\\par\\smallskip\\noindent It cites every claim on this page as the table of " ++
        "numbered claims does.\n"
    | differs =>
      "\\par\\smallskip\\noindent It cites these claims otherwise than the table of " ++
        "numbered claims does:\n" ++
      rows (String.join (differs.map (row ·.1))) ++
      "\\noindent Every other claim on this page it cites as the table does.\n"

/-- Names set as a list, each in italics. -/
def nameList (names : List String) : String :=
  rows (String.join (names.map fun x => "  \\item[] \\emph{" ++ escape x ++ "}\n"))

/-- **A position made from a line, in words**: the line it argues, by name, and
the conclusion it reaches, so the grounds and the step are set out once, at the
line. -/
def fromLineWords [DecidableEq α] (n : Numbering α) (line : String) (pkg : ArgumentPackage α) :
    String :=
  "\\par\\smallskip\\noindent It argues the line \\texttt{" ++ codeEscape line ++
    "}, set out above, as it stands: the same grounds and the same step, to the same " ++
    "conclusion.\n" ++
  rows (row n "\\item[\\(\\vdash\\)]" pkg.conclusion
    (n.cite.bind fun cite => inWords n cite .atIssue pkg.conclusion))

/-- **A refutation in words**: the claim struck, what the text reads, and the
text's citation. -/
def refutationWords [DecidableEq α] (n : Numbering α) (a : α) (reads : String) (s : Source) :
    String :=
  "\\par\\smallskip\\noindent The claim struck: " ++
    (match n.cite with
     | some cite => claimWords n cite a false
     | none => "") ++
    ". What the text reads: " ++ escape reads ++ "." ++ sourceWords s

/-- **A rule written as a table, in words**: a table with a column for each
input and one for whether the rule allows the row. -/
def truthTableWords (inputs : List String) (rowsOf : List (List Bool × Bool)) : String :=
  let yn (b : Bool) := if b then "true" else "false"
  "\\par\\smallskip\\noindent The rule, row by row:\n\n" ++
  "\\begin{tabular}{" ++ String.join (inputs.map fun _ => "l ") ++ "l}\n\\toprule\n" ++
  String.intercalate " & " (inputs.map escape ++ ["allowed"]) ++ " \\\\\n\\midrule\n" ++
  String.join (rowsOf.map fun (ins, out) =>
    String.intercalate " & " (ins.map yn ++ [if out then "yes" else "no"]) ++ " \\\\\n") ++
  "\\bottomrule\n\\end{tabular}\n\n"

/-- **A truth table, set out**: a column for each claim, one for each test,
whether the row is allowed, and one for each statement that follows, shaded.
Each test and statement is said in words under the table, with what a test
rests on. A struck row is set in grey; a test proposed here is shaded. Rows are
numbered from 1, as the prose after a table names them, and the table shrinks
to the text's width only when it is wider. -/
def tableWords (t : Page.TableView) : String :=
  let yn (b : Bool) := if b then "Yes" else "No"
  let mark (b : Bool) := if b then "\\textcolor{tablekept}{✓}" else "\\textcolor{tablebroken}{✗}"
  let grey (keep : Bool) (x : String) := if keep then x else "\\textcolor{tablestruck}{" ++ x ++ "}"
  let nc := t.claims.length
  let nt := t.tests.length
  let nf := t.follows.length
  let testSpec (c : Page.TableColumnView) :=
    if c.proposed then ">{\\columncolor{tableproposed}}c " else "c "
  let spec := "@{}r " ++ String.join (t.claims.map fun _ => "c ") ++
    String.join (t.tests.map testSpec) ++ "c " ++
    String.join (t.follows.map fun _ => ">{\\columncolor{tablefollows}}c ") ++ "@{}"
  let head (c : Page.TableColumnView) :=
    "\\shortstack{" ++ escape c.label ++ "\\\\[1pt]$" ++ c.formulaTex ++ "$}"
  let first := 2 + nc
  let lastTest := first + nt - 1
  let firstFollow := lastTest + 2
  let header :=
    String.intercalate " & " ("" :: t.claims.map (fun (h, _) => escape h) ++
      ["\\multicolumn{" ++ toString nt ++ "}{c}{Tests}", ""] ++
      (if nf == 0 then [] else ["\\multicolumn{" ++ toString nf ++ "}{c}{What follows}"])) ++
      " \\\\\n" ++
    "\\cmidrule(lr){" ++ toString first ++ "-" ++ toString lastTest ++ "}" ++
    (if nf == 0 then "" else
      "\\cmidrule(l){" ++ toString firstFollow ++ "-" ++ toString (firstFollow + nf - 1) ++ "}") ++
      "\n" ++
    String.intercalate " & "
      ("Row" :: t.claims.map (fun (_, l) => "$" ++ Page.texLetter l ++ "$") ++
      t.tests.map head ++ ["Allowed"] ++ t.follows.map head) ++ " \\\\\n\\midrule\n"
  let body := String.join ((t.rows.zip (List.range t.rows.length)).map
    fun ((cs, ts, ok, fs), k) =>
      String.intercalate " & " ([grey ok (toString (k + 1))] ++ cs.map (grey ok ∘ yn) ++
        ts.map mark ++ [grey ok (yn ok)] ++
        fs.map (grey ok ∘ fun b => if b then "true" else "false")) ++ " \\\\\n")
  let said (c : Page.TableColumnView) :=
    "\\item[" ++ escape c.label ++ "] \\textbf{" ++ inlineProse c.words ++ "}" ++
      (match c.source with
       | some s => " " ++ source s ++ "."
       | none => "") ++ "\n"
  "\\par\\medskip\\noindent\\begin{center}\\small\n" ++
  "\\resizebox{\\ifdim\\width>\\textwidth\\textwidth\\else\\width\\fi}{!}{%\n" ++
  "\\begin{tabular}{" ++ spec ++ "}\n\\toprule\n" ++ header ++ body ++
  "\\bottomrule\n\\end{tabular}}\n\\end{center}\n" ++
  "{\\footnotesize\\begin{list}{}{\\setlength{\\leftmargin}{2em}\\setlength{\\labelwidth}{1.6em}" ++
  "\\setlength{\\itemsep}{1pt}\\setlength{\\topsep}{2pt}}\n" ++
  String.join ((t.tests ++ t.follows).map said) ++ "\\end{list}}\n"

/-- **A reading of a passage, in words**: the passage, how the reading
construes it, the reading, and who reads it so. -/
def interpretationWords (i : Interpretation) : String :=
  "\\par\\smallskip\\noindent " ++ escape i.passage.render ++
    (match i.asRelation with
     | some r => ", read as " ++ escape (Page.asRelationWords r)
     | none => "") ++
    ": \\emph{" ++ escape i.reading ++ "}." ++ sourceWords i.source

/-- A statement in logic notation, as mathematics: each claim its variable,
linked to the legend, and each formula as a derivation sets it. -/
def symTex [DecidableEq α] (n : Numbering α) : Page.Sym α → String
  | .atom a => varLink n.anchor (n.order.idxOf a)
  | .formula φ => linked n φ
  | .tex t => t
  | .seq ps => String.join (ps.attach.map fun ⟨p, _⟩ => symTex n p)

/-- **A result, stated twice, side by side**: on the left in logic notation, on
the right in the docstring's English, so a reader who does not read the symbols
reads the sentence beside them, and one who does can check that the two say the
same. The columns run on together across a page break. -/
def stated [DecidableEq α] (n : Numbering α) (st : Page.Sym α) (doc : String) : String :=
  "\\begin{paracol}{2}\n\\raggedright\\noindent\\(" ++ symTex n st ++ "\\)\n" ++
  "\\switchcolumn\n" ++ prose doc ++ "\\end{paracol}\n"

/-- Which of a package's premises are readings taken from the text alone
(`AtomMeta.readsScriptureAlone`), as a note under its derivation; nothing when
there are none. A quotation of the text is not such a reading, so a package
whose only scripture-cited premises are quotations gets no note. -/
def scriptureNote [DecidableEq α] (_order : List α) (pkg : ArgumentPackage α) : String :=
  if pkg.scriptureOnlyAtoms.isEmpty then ""
  else
    "\\emph{Read from the text alone, with no commentator cited, and so assumed " ++
    "here rather than argued for:} " ++
    String.intercalate "; " (pkg.scriptureOnlyAtoms.map fun m => escape m.label) ++ ".\n"

/-- The formulas of a list, inline and joined. -/
def inlineFormulas [DecidableEq α] (n : Numbering α) (φs : List (Formula α)) : String :=
  String.intercalate ", " (φs.map fun φ => "\\(" ++ linked n φ ++ "\\)")

/-- Why one position stands against another, as an itemised list. -/
def explanation [DecidableEq α] (n : Numbering α) (e : Page.Explanation α) : String :=
  let given := if e.granted.isEmpty then "" else " and " ++ inlineFormulas n e.granted
  let claim (a : α) : String :=
    let m := e.cite a
    "\\item " ++ linkedVar n a ++ " " ++ escape m.label ++ " --- \\emph{" ++
      confidence m.source.confidence ++ "}: " ++ source m.source ++ "\n"
  "\\paragraph{Why \\emph{" ++ escape e.holder ++ "} stands against \\emph{" ++
    escape e.rival ++ "}.}\n" ++
  "\\begin{itemize}\n" ++
  "\\item \\textbf{The crux:} \\(" ++ linked n e.crux ++ "\\), a premise of \\emph{" ++
    escape e.holder ++ "}.\n" ++
  "\\item \\textbf{What it does:} " ++
    (if e.derives then "its conclusion does not follow without it."
     else "its conclusion follows without it --- the crux is its answer to \\emph{" ++
       escape e.rival ++ "}.") ++ "\n" ++
  (if e.granted.isEmpty then "" else
    "\\item \\textbf{Granted:} " ++ inlineFormulas n e.granted ++
    ", which the break also needs.\n") ++
  "\\item \\textbf{Where the rival breaks:} " ++ inlineFormulas n e.core ++
    " cannot be held together with \\(" ++ linked n e.crux ++ "\\)" ++ given ++
    "; each is needed for the break, and without the crux they stand.\n" ++
  "\\item \\textbf{What this rests on:}\n\\begin{itemize}\n" ++
    String.join (e.restsOn.map claim) ++
    (if Page.Explanation.isLiteral e.crux then "" else
      "\\item the step itself --- " ++
      (match e.rating with
       | some s => "\\emph{" ++ confidence s.confidence ++ "}: " ++ source s
       | none =>
         if e.inferences.isEmpty then "\\emph{unrated}" else
           "\\emph{not rated on its own}. These ratings are for the steps of \\emph{" ++
           escape e.holder ++ "} together, not for this one: " ++
           String.intercalate "; " (e.inferences.map fun s =>
             "\\emph{" ++ confidence s.confidence ++ "}: " ++ source s)) ++ "\n") ++
  "\\end{itemize}\n\\end{itemize}\n"

/-- Every reading of a rival's claim, answered: each horn with what the claim
commits the rival to, who reads it that way, and what happens to it against
each position. -/
def dilemma [DecidableEq α] (n : Numbering α) (d : Page.Dilemma α) : String :=
  let claim := "\\(" ++ linked n d.claim ++ "\\)"
  -- A heading's text is written out — to the table of contents, among other
  -- places — and a link does not survive that, so the heading's variables are
  -- plain.
  let heading := "\\(" ++ formula n.order d.claim ++ "\\)"
  let fate (f : Page.Fate α) : String := match f.falls with
    | some e =>
      "Against \\emph{" ++ escape f.against ++ "}, it cannot be held. Where it breaks:\n" ++
        explanation n e
    | none =>
      "Against \\emph{" ++ escape f.against ++ "}, it is not reached: \\emph{" ++
        escape f.against ++ "} holds, and can be held together with it.\n\n"
  let ways := d.horns.length
  "\\paragraph{Every reading of " ++ heading ++ ", answered.} \\emph{" ++ escape d.rival ++
    "} holds " ++ claim ++ ". It is read " ++ toString ways ++
    (if ways == 1 then " way" else " ways") ++
    " here, and each reading is checked; none can be left out.\n\n" ++
  String.join (d.horns.zipIdx.map fun (h, k) =>
    "\\paragraph{" ++ toString (k + 1) ++ ". Read " ++ escape h.reading ++
      ".} The claim commits \\emph{" ++ escape d.rival ++ "} to \\(" ++
      linked n h.commits ++ "\\) --- so read by " ++ source h.source ++ " (\\emph{" ++
      confidence h.source.confidence ++ "})." ++
      (if h.grounds.isEmpty then "" else
        " It rests the reading on " ++ inlineFormulas n h.grounds ++ ".") ++ "\n\n" ++
    String.join (h.fates.map fate))

/-- What an opponent must reject: every minimal set of readings whose
rejection overturns the case, each reading with its rating, and the readings no
set needs. -/
def burden (b : Page.Burden) : String :=
  let reading (i : Nat) : String := match b.readings[i]? with
    | some (n, some s) => "\\emph{" ++ escape n ++ "} (" ++ confidence s.confidence ++ ")"
    | some (n, none) => "\\emph{" ++ escape n ++ "} (unrated)"
    | none => "reading " ++ toString i
  let spare := b.spare
  "\\paragraph{What an opponent must reject.} \\emph{" ++ escape b.holder ++
    "} concludes that " ++ escape b.conclusion ++ ". That conclusion is overturned " ++
    "exactly when every reading in one of these sets is rejected. Each set is " ++
    "minimal, and no other rejection overturns it:\n" ++
  "\\begin{enumerate}\n" ++
  String.join (b.sets.map fun S =>
    "\\item " ++ String.intercalate "; " (S.map reading) ++ "\n") ++
  "\\end{enumerate}\n" ++
  (if spare.isEmpty then "" else
    "No set contains " ++
    String.intercalate ", " (spare.map fun n => "\\emph{" ++ escape n ++ "}") ++
    ": an opponent never needs to reject it.\n")

/-- A dissent, assessed under every standard: what kind it is, and under each
standard whether it is credible, with what it rests on that the standard does
not admit. -/
def assessed (a : Page.Assessed) : String :=
  "\\paragraph{Dissent.} \\emph{" ++ escape a.dissenter ++ "}, against \\emph{" ++
    escape a.against ++ "}. " ++ (if a.critique then "\\textbf{A critique.} " else
      "\\textbf{Not a critique.} ") ++ escape a.kind ++ "\n" ++
  "\\begin{itemize}\n" ++
  String.join (a.struck.map fun (c, r) =>
    "\\item Struck, because the text reads otherwise: " ++ escape c ++ ". " ++ escape r ++
      ".\n") ++
  String.join (a.standards.map fun (s, ok, un) =>
    "\\item Under the " ++ s ++ " standard: " ++
      (if ok then "credible." else "not credible") ++
      (if un.isEmpty then (if ok then "" else ".") else
        "; it rests on what the standard does not accept: " ++
          String.intercalate "; " (un.map escape) ++ ".") ++ "\n") ++
  "\\end{itemize}\n"

/-- A step's rating, computed from its register under every standard. -/
def rated (r : Page.Rated) : String :=
  "\\paragraph{The rating, computed.} \\emph{" ++ escape r.step ++ "} is cited at \\emph{" ++
    confidence r.support.confidence ++ "} (" ++ source r.support ++ "). Dissents encoded: " ++
    (if r.register.isEmpty then "none" else
      String.intercalate ", " (r.register.map fun d => "\\emph{" ++ escape d ++ "}")) ++ ". " ++
    (match r.steelman with
      | some d => "The strongest known: \\emph{" ++ escape d ++ "}."
      | none => "The strongest known dissent is not encoded.") ++ "\n" ++
  "\\begin{itemize}\n" ++
  String.join (r.ratings.map fun (s, c, why) =>
    "\\item Under the " ++ s ++ " standard: \\textbf{" ++ confidence c ++ "} --- " ++
      escape why ++ ".\n") ++
  "\\end{itemize}\n"

/-- One piece of a generated sentence. A defeat that a `Because` in the
document explains names it. -/
def seg (links : List Page.BecauseLink) : Page.Seg → String
  | .text t => escape t
  | .party n => "\\emph{" ++ escape n ++ "}"
  | .defeat a b =>
    "\\emph{" ++ escape a ++ "} defeats \\emph{" ++ escape b ++ "}" ++
    match Page.becauseFor links a b with
      | some d => " (\\texttt{" ++ codeEscape d ++ "})"
      | none => ""

/-- An exchange, told: each turn's paragraph under its party's name, then the
sentence that joins it to the turn it names, as the solver found it, and what the
line it quotes declares; then how the parties stand to one another, in a
paragraph, with a table as well when there are many of them. -/
def exchange (links : List Page.BecauseLink) (x : Page.Exchange) : String :=
  let segs (ss : List Page.Seg) : String := String.join (ss.map (seg links))
  let turn (t : Page.ExchangeTurn) : String :=
    let quoted := if t.quoting.isEmpty then "" else
      "It quotes \\texttt{" ++ codeEscape (((t.quoting.splitOn ".").getLast?).getD "") ++
        "}. "
    let joined := segs (Page.Exchange.connective t ++
      (if t.relation.isEmpty || t.findings.isEmpty then [] else [.text " "]) ++
      Page.Exchange.declared t)
    let after := (quoted ++ joined).trimAscii.toString
    let from_ := if t.source.isEmpty then "" else
      " (\\emph{" ++ escape t.source ++ "}" ++
        (if t.year.isEmpty then "" else ", " ++ escape t.year) ++ ")"
    "\\paragraph{" ++ escape t.party ++ from_ ++ ".}" ++ " " ++
      prose t.doc ++
      (if after.isEmpty then "" else after ++ "\n\n")
  let ps := x.parties
  let table := if ps.length ≤ Page.Exchange.manyParties then "" else
    let names (l : List String) : String :=
      if l.isEmpty then "---" else
        String.intercalate ", " (l.map fun n => "\\emph{" ++ escape n ++ "}")
    "\\begin{tabular}{lll}\nPosition & Defeats & Is defeated by \\\\\n\\hline\n" ++
    String.join (ps.map fun a =>
      let beats := x.pairs.filterMap fun (p, q, pq, qp) =>
        if p == a && pq then some q else if q == a && qp then some p else none
      let beaten := x.pairs.filterMap fun (p, q, pq, qp) =>
        if p == a && qp then some q else if q == a && pq then some p else none
      "\\emph{" ++ escape a ++ "} & " ++ names beats ++ " & " ++ names beaten ++
        " \\\\\n") ++
    "\\end{tabular}\n\n"
  let summary := Page.Exchange.summary x
  String.join (x.turns.map turn) ++
    (if summary.isEmpty then "" else segs summary ++ "\n\n") ++ table

/-- Nested `itemize` environments for a list of lines with depths: open one
where the depth rises, close where it falls. LaTeX nests lists four deep at
most, so a deeper line is set at the fourth level rather than failing the
build. -/
def nested (lines : List (Nat × String)) : String :=
  let rec /-- The lines still to set, at the depth open so far. -/
    go : Nat → List (Nat × String) → String
    | cur, [] => String.join (List.replicate cur "\\end{itemize}\n")
    | cur, (d, l) :: rest =>
      let depth := min d 3 + 1
      let opens := String.join (List.replicate (depth - cur) "\\begin{itemize}\n")
      let closes := String.join (List.replicate (cur - depth) "\\end{itemize}\n")
      closes ++ opens ++ "\\item " ++ l ++ "\n" ++ go depth rest
  go 0 lines

/-- What a verdict rests on, for a reader: that each reason is an entry of the
table of who defeats whom, what defeat turns on, every party involved where it
is weakest, and which defeats a `Because` explains claim by claim. -/
def restsOn (v : Page.Verdict) (links : List Page.BecauseLink) (table : String) : String :=
  let tableRef := if table.isEmpty then "the defeat table"
    else "\\texttt{" ++ codeEscape table ++ "}"
  let explained := (v.cells.filterMap fun (a, b, d) =>
    if d then (Page.becauseFor links a b).map (a, b, ·) else none)
  let held (h : Page.Held) : String :=
    "\\item " ++ escape h.what ++ " --- " ++ source h.source ++ "\n"
  let reading (r : Page.Reading) : String :=
    match r.weakest with
    | [] => "\\item \\emph{" ++ escape r.party ++ "}: none of its claims is rated.\n"
    | h :: _ =>
      "\\item \\emph{" ++ escape r.party ++ "}, held as \\emph{" ++
      confidence h.confidence ++ "} at its weakest, at:\n\\begin{itemize}\n" ++
      String.join (r.weakest.map held) ++ "\\end{itemize}\n"
  "\\par\\noindent\\textbf{Why.} Each reason above is one entry in the table of who " ++
  "defeats whom (" ++ tableRef ++ "), worked out from what each position claims and " ++
  "checked by the computer when the library is built. One position defeats another when " ++
  "it denies something the other rests on and, where it is weakest, is held at least as " ++
  "firmly as what it denies; so if a claim were rated differently, the verdict could " ++
  "change. Where each position is weakest:\n" ++
  "\\begin{itemize}\n" ++ String.join (v.readings.map reading) ++ "\\end{itemize}\n" ++
  String.join (explained.map fun (a, b, d) =>
    "\\noindent Why \\emph{" ++ escape a ++ "} defeats \\emph{" ++ escape b ++
    "}, claim by claim, is set out at \\texttt{" ++ codeEscape d ++ "}.\n")

/-- A verdict: its claim, its reasons as nested lists, and what they rest on. -/
def verdict (v : Page.Verdict) (links : List Page.BecauseLink) (table : String) : String :=
  let line (segs : List Page.Seg) := String.join (segs.map (seg links))
  "\\paragraph{" ++ line v.claim ++ "}\n" ++
  nested (v.reasons.map fun (d, segs) => (d, line segs)) ++
  restsOn v links table

/-- A coordinate in centimetres, to two places. -/
def cm (x : Float) : String :=
  let v := (x * 100).round
  let neg := v < 0
  let n := (if neg then -v else v).toUInt64.toNat
  (if neg then "-" else "") ++ toString (n / 100) ++ "." ++
    (if n % 100 < 10 then "0" else "") ++ toString (n % 100)

/-- A dispute's graph drawn in TikZ, on the same circle as the web page:
defeats solid, supports dashed, each edge bent a little to its left. -/
def graphTikz (g : Page.Graph) : String :=
  let n := g.nodes.length
  let radius := 3.2
  let node (k : Nat) : String :=
    let (x, y) := Page.Graph.position n k
    "\\node[draw,circle,minimum size=6mm,inner sep=0pt] (n" ++ toString k ++ ") at (" ++
      cm (radius * x) ++ "," ++ cm (radius * y) ++ ") {" ++ toString (k + 1) ++ "};\n"
  let edge (i j : Nat) (kind : Page.EdgeKind) : String :=
    let style := match kind with
      | .defeat => "->,red!70!black,thick"
      | .partOf => "->,blue!60!black,thick,dotted"
      | _ => "->,green!40!black,thick,dashed"
    "\\draw[" ++ style ++ "] (n" ++ toString i ++ ") to[bend left=10] (n" ++ toString j ++
      ");\n"
  "\\begin{center}\n\\begin{tikzpicture}[>={Stealth[length=2mm]}]\n" ++
  String.join ((List.range n).map node) ++
  String.join (g.edges.filterMap fun (i, j, k) =>
    if Page.Graph.EdgeKind.drawn k then some (edge i j k) else none) ++
  "\\end{tikzpicture}\n\\end{center}\n"

/-- A dispute's graph: drawn, then its parties by number, then every edge in a
table, then what the derived attacks and the conflicts come to. -/
def graph (g : Page.Graph) (defeatTable supportTable partTable : String) : String :=
  let name (k : Nat) := "\\emph{" ++ escape (g.nodes.getD k "") ++ "}"
  let ref (t fallback : String) :=
    if t.isEmpty then fallback else "\\texttt{" ++ codeEscape t ++ "}"
  if g.edges.isEmpty then
    "\\noindent " ++ Page.Graph.apartWords g (fun nm => "\\emph{" ++ escape nm ++ "}") ++
    " This is read from the cells of " ++ ref defeatTable "the defeat table" ++ ", " ++
    ref supportTable "the support table" ++ " and " ++ ref partTable "the part-of table" ++
    ", each computed from the parties' premises and checked by the kernel.\n"
  else
  graphTikz g ++
  "\\noindent Solid: defeats. Dashed: supports. Dotted: one party's case is part of " ++
  "another's.\n" ++
  "\\begin{enumerate}\n" ++
  String.join (g.nodes.map fun nm => "\\item " ++ escape nm ++ "\n") ++
  "\\end{enumerate}\n" ++
  "\\begin{longtable}{@{}>{\\raggedright\\arraybackslash}p{0.3\\textwidth} " ++
    ">{\\raggedright\\arraybackslash}p{0.3\\textwidth} " ++
    ">{\\raggedright\\arraybackslash}p{0.3\\textwidth}@{}}\n" ++
  "\\toprule\n\\textbf{From} & \\textbf{To} & \\textbf{Edge} \\\\\n\\midrule\n\\endhead\n" ++
  String.join (g.edges.map fun (i, j, k) =>
    toString (i + 1) ++ " " ++ name i ++ " & " ++ toString (j + 1) ++ " " ++ name j ++ " & " ++
    escape (Page.Graph.EdgeKind.describe k) ++ " \\\\\n") ++
  "\\bottomrule\n\\end{longtable}\n" ++
  "\\noindent The defeats are the cells of " ++ ref defeatTable "the defeat table" ++
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

/-- Render one item against the document's numbering. A lone formula, or a
list of them, is set as rows of a derivation, so a step says what it delivers
there too. -/
def item [DecidableEq α] (n : Numbering α) : Page.Item α → String
  | .prose md => prose md
  | .package d doc pkg =>
      declLabel d (" --- " ++ escape pkg.name) ++ prose doc ++
      derivation n pkg.premises pkg.conclusion (scriptureNote n.order pkg)
  | .line d doc l =>
      declLabel d (" --- " ++ escape l.name) ++ prose doc ++
      derivation n l.premises l.delivers
  | .formula d doc φ => declLabel d "" ++ prose doc ++ step n φ
  | .formulas d doc φs =>
      declLabel d "" ++ prose doc ++
      rows (String.join (φs.zipIdx.map fun (φ, i) =>
        row n (numbered i φs.length) φ (gloss n none φ)))
  | .source d doc s => declLabel d "" ++ prose doc ++ sourceWords s
  | .claim d doc m => declLabel d "" ++ prose doc ++ claimWords' m
  | .reading d doc truth => declLabel d "" ++ prose doc ++ readingWords n truth
  | .citation d doc c => declLabel d "" ++ prose doc ++ citationWords n c
  | .listing d doc lead entries => declLabel d "" ++ prose doc ++
      (if entries.isEmpty then "" else
        "\\par\\smallskip\\noindent " ++ escape lead ++ "\n" ++ nameList entries)
  | .sources d doc ss => declLabel d "" ++ prose doc ++ String.join (ss.map sourceWords)
  | .said d doc text => declLabel d "" ++ prose doc ++
      "\\par\\smallskip\\noindent " ++ escape text ++ "\n"
  | .edge d doc e => declLabel d "" ++ prose doc ++
      "\\par\\smallskip\\noindent " ++ escape e.fromPassage.render ++ " " ++
        escape (Page.relationWords e.relation) ++ " " ++ escape e.toPassage.render ++ "." ++
        sourceWords e.source
  | .interpretation d doc crit i => declLabel d (if crit.isEmpty then "" else
        " --- " ++ escape crit) ++ prose doc ++ interpretationWords i
  | .dilemmaReading d doc name φ src => declLabel d (" --- " ++ escape name) ++ prose doc ++
      "\\par\\smallskip\\noindent Read so, the claim commits its holder to:\n" ++
      rows (row n "\\item[]" φ (loneGloss n φ)) ++ sourceWords src
  | .truthTable d doc inputs rs => declLabel d "" ++ prose doc ++ truthTableWords inputs rs
  | .table _ doc t => prose doc ++ tableWords t
  | .contested d doc holder denier φ => declLabel d "" ++ prose doc ++
      "\\par\\smallskip\\noindent \\emph{" ++ escape holder ++ "} holds this claim, and \\emph{" ++
        escape denier ++ "} denies it; each can be defended in the dispute:\n" ++
      rows (row n "\\item[]" φ (loneGloss n φ))
  | .helper d doc => declLabel d "" ++ prose doc
  | .fromLine d doc line pkg =>
      declLabel d (" --- " ++ escape pkg.name) ++ prose doc ++ fromLineWords n line pkg ++
      scriptureNote n.order pkg
  | .positions d doc names =>
      declLabel d "" ++ prose doc ++ nameList names
  | .dispute d doc names node =>
      declLabel d "" ++ prose doc ++
      "\\par\\smallskip\\noindent " ++
      (if node.isEmpty then "It hears these positions, each"
       else "It hears the positions \\texttt{" ++ codeEscape node ++ "} gives the parties, each") ++
      " checked when the library is built to be consistent, to reach its conclusion, and to " ++
      "rest on at least one rated step" ++
      (if node.isEmpty then ":\n" ++ nameList names else ".\n")
  | .register d doc assessed steps =>
      declLabel d "" ++ prose doc ++
      "\\par\\smallskip\\noindent The positions it assesses as dissents:\n" ++
        nameList assessed ++
      "\\noindent The steps their dissents are rated against:\n" ++ nameList steps
  | .refutation d doc a reads s => declLabel d "" ++ prose doc ++ refutationWords n a reads s
  | .greek d doc place words =>
      declLabel d "" ++ prose doc ++
      "\\par\\smallskip\\noindent " ++ escape place ++ " in the SBL Greek New Testament: " ++
        escape (" ".intercalate words) ++ "\n"
  | .sourceFn d doc s =>
      declLabel d "" ++ prose doc ++
      "\\par\\smallskip\\noindent Cited to " ++ source s ++
        ", at whatever rating the place that cites it gives.\n"
  | .other d doc src => declLabel d "" ++ prose doc ++ verbatim src
  | .result d doc st proposed =>
      declLabel d (if proposed then " \\textsuperscript{(proposed)}" else "") ++ stated n st doc
  | .because d doc e => declLabel d "" ++ prose doc ++ explanation n e
  | .dilemma d doc dl => declLabel d "" ++ prose doc ++ dilemma n dl
  | .burden d doc st b => declLabel d "" ++ stated n st doc ++ burden b
  | .verdict d doc v links table => declLabel d "" ++ prose doc ++ verdict v links table
  | .graph d doc g defeats supports parts =>
      declLabel d "" ++ prose doc ++ graph g defeats supports parts
  | .assessed d doc a => declLabel d "" ++ prose doc ++ assessed a
  | .rated d doc r => declLabel d "" ++ prose doc ++ rated r
  | .exchange d doc x links => declLabel d "" ++ prose doc ++ exchange links x

/-- One argument's body: its introductory prose, its legend, then every item in
source order. The heading above it is the caller's, as the page title is in the
Markdown rendering.

`ns` is the argument's namespace, which its variables' links are named by. An
argument with no legend has nothing to link to or gloss from, and its variables
are set plain. -/
def body [DecidableEq α] (ns : String) (allAtoms : List α) (intro : List (Page.Item α))
    (items : List (Page.Item α)) : String :=
  let all := intro ++ items
  let cite := citeOf all
  let n : Numbering α :=
    { order := atomOrder allAtoms all, cite := cite,
      anchor := if cite.isSome then anchorName ns else "" }
  let legendPart := match cite with
    | some c => "\\subsubsection*{The claims, numbered}\n" ++ legend n c ++ "\n"
    | none => ""
  String.join (intro.map (item n)) ++ legendPart ++
  String.join (items.map (item n))

/-- A starred section heading for one argument, put into the table of contents
by hand because a starred section does not do it for itself. -/
def sectionHeading (title : String) : String :=
  "\\clearpage\n\\section*{" ++ escape title ++ "}\n" ++
  "\\addcontentsline{toc}{section}{" ++ escape title ++ "}\n\n"

/-- The repository every edition is made from, which the last section tells a
reader to clone. -/
def repository : String := "https://github.com/testimonyproject/testimony"

/-- **Which edition a document is.** The date and version under its title, and
the commit its last section tells a reader to check out, as macros a document
reads from `edition.def` beside it.

None of them belongs in the generator: the same source must make the same
`.tex` on every machine, and a pull request is typeset from GitHub's merge of
it, whose commit does not exist until then. So the file is written when the document is
typeset, by `scripts/edition.py`, from the commit being typeset, as
`credits.def` is by `scripts/credits.py`. Without it the document says it is an
unrecorded copy, and dates itself the day it was typeset.

The paper is not part of the record, because one `.tex` makes every size of
page: `\editionpaper` names the paper this copy is set on, "A4" or "US Letter"
(or the name `scripts/typeset.sh --paper` was given), from `\testimonypaper`,
which the preamble reads before the class (`preamble`). -/
def edition : String :=
  "\\newif\\ifeditionrecorded\n\\newif\\ifeditionpreview\n" ++
  "\\edef\\testimony@paper{\\testimonypaper}\\def\\testimony@aiv{a4}" ++
  "\\def\\testimony@letter{letter}\n" ++
  "\\newcommand{\\editionpaper}{\\ifx\\testimony@paper\\testimony@aiv A4\\else" ++
  "\\ifx\\testimony@paper\\testimony@letter US Letter\\else" ++
  "\\texttt{\\testimony@paper}\\fi\\fi}\n" ++
  "\\newcommand{\\editiondate}{\\today}\n" ++
  "\\newcommand{\\editionversion}{unrecorded}\n" ++
  "\\newcommand{\\editioncommit}{COMMIT}\n" ++
  "\\newcommand{\\editionremark}{}\n" ++
  "\\InputIfFileExists{edition.def}{}{}\n"

/-- What a reader needs to make one document again: the package it belongs to,
the program in that package that writes it, and where it is written. -/
structure Reproduction where
  /-- The package's directory in the repository: `arguments`, or `examples`. -/
  package : String
  /-- The program that writes the document: `argtex`, or `exampletex`. -/
  tool : String
  /-- The directory the document is written to, from the repository's root. -/
  dir : String
  /-- The document's file name, `sola-fide.tex`. -/
  file : String
  /-- Whether the document names the people behind it, so that the steps
  include working out who they are (`credits`). -/
  credits : Bool := false
  /-- The programs to run in the package before `tool`: what writes the files
  the document needs beside it, such as the bibliography (`bibgen`). -/
  before : List String := []
  /-- Which Bible translations the document quotes, in a sentence for the
  reader, and the notice each one's publisher asks for, printed as given. -/
  scripture : String × List String := ("", [])
  /-- The works the document cites whose licence asks for credit
  (`BibEntry.core.licence`), each credited in the closing section
  (`licenceCredits`). -/
  licensed : List BibEntry := []
deriving Inhabited, Repr

/-- The paragraph of the closing section that names the translations the
document quotes Scripture from, with each publisher's notice: nothing, if it
names none. `lead` says which translation quotes what, and each notice follows
it as its publisher gives it. -/
def scripturePermissions (lead : String) (notices : List String) : String :=
  if notices.isEmpty then "" else
    escape lead ++ "\n" ++
    "\\begin{itemize}\n" ++
    String.join (notices.map fun n => "\\item " ++ escape n ++ "\n") ++
    "\\end{itemize}\n\n"

#guard scripturePermissions "Quoted:" [] == ""
#guard scripturePermissions "Quoted:" ["Used by permission."] ==
  "Quoted:\n\\begin{itemize}\n\\item Used by permission.\n\\end{itemize}\n\n"

/-- The works in `works` that `tex` cites, by a `\cite` of their key with or
without a pinpoint, in the order of `works`. -/
def citedIn (tex : String) (works : List BibEntry) : List BibEntry :=
  works.filter fun e =>
    (tex.splitOn ("\\cite{" ++ e.key ++ "}")).length > 1 ||
      (tex.splitOn ("]{" ++ e.key ++ "}")).length > 1

/-- The paragraph of the closing section that credits each cited work whose
licence asks for credit, as the licence asks: its credit, the licence's name,
and where the licence is: nothing, if the document cites none. -/
def licenceCredits (works : List BibEntry) : String :=
  let items := works.filterMap fun e => e.core.licence.map fun l =>
    "\\item " ++ escape l.credit ++ ". Licensed under " ++ escape l.name ++
      ", \\url{" ++ l.url ++ "}.\n"
  if items.isEmpty then "" else
    "This document cites the works below, which are published under licences that " ++
    "ask for credit. Each is credited as its licence asks.\n" ++
    "\\begin{itemize}\n" ++ String.join items ++ "\\end{itemize}\n\n"

#guard licenceCredits [] == ""

/-- **How this edition was made**, the document's last section: what made it,
for a reader who has never heard of Lean, and every step to make it again from
the commit the edition names (`edition`).

The title matter says only when and which: a reader who wants to cite the
document needs those, and a reader who wants to check it needs the rest, which
is too long for a title page. The steps are the ones `.github/workflows/pdf.yml`
takes, written out for one computer, and they end in one command for each size
of page the workflow publishes, A4 and US Letter, since a reader may hold either
(`\editionpaper`, defined in `edition`, says which). Before the steps it names
the Bible translations the document quotes, with the notice each publisher asks
for (`scripturePermissions`), and credits each work it cites whose licence asks
for credit (`licenceCredits`). -/
def reproduction (r : Reproduction) : String :=
  let cmd (lines : List String) : String :=
    "\\begin{alltt}\\small\n" ++ "\n".intercalate lines ++ "\n\\end{alltt}\n"
  let defs := if r.credits then "docs/latex docs/latex/arguments" else r.dir
  let name := (r.file.dropEnd 4).toString
  let pdf := name ++ ".pdf"
  let letter := name ++ "-letter.pdf"
  let a5 := name ++ "-a5.pdf"
  let tex := r.dir ++ "/" ++ r.file
  "\n\\clearpage\n\\section*{How this edition was made}\n" ++
  "\\addcontentsline{toc}{section}{How this edition was made}\n" ++
  "This document was printed by a program, not set by hand. Its text comes from " ++
  "the source files of the Testimony library, where each argument is written out " ++
  "twice: in prose, for a reader, and in Lean, a language for stating proofs that " ++
  "a computer can check. The prose is printed in the order it is written, and " ++
  "under each part come the premises, lines of reasoning and results it " ++
  "introduces, as the source states them. Before anything is printed, the " ++
  "computer checks every one of those results: where this document says a " ++
  "conclusion follows from its premises, that it does, and where it says a " ++
  "conclusion does not follow, that the counterexample it gives really is one. " ++
  "It does not check that any premise is true.\n\n" ++
  scripturePermissions r.scripture.1 r.scripture.2 ++
  licenceCredits r.licensed ++
  "\\ifeditionrecorded This edition, version \\editionversion, was made from " ++
  "the library as it stood on \\editiondate, at the commit named in step 3 " ++
  "below. A commit is one saved state of every file in the " ++
  "repository; that string of letters and digits names it, and what it names " ++
  "never changes. So anyone can make this edition again.\n" ++
  "\\else This copy was typeset without a record of the commit it was made from, " ++
  "so the steps below write \\texttt{COMMIT} where an edition names its own. A " ++
  "commit is one saved state of every file in the repository, named by a string " ++
  "of letters and digits that never changes what it names.\n\\fi\n\n" ++
  "This copy is set on \\editionpaper{} paper. The steps below make the document " ++
  "on A4 and on US Letter alike, and only the last of them differs between the " ++
  "two.\n\n" ++
  "You need a computer running Linux or macOS (on Windows, the Windows Subsystem " ++
  "for Linux), with git, Python~3, an internet connection, and about 10\\,GB of " ++
  "free disk space.\n" ++
  "\\begin{enumerate}\n" ++
  "\\item Install elan, which installs the version of Lean the library asks for:\n" ++
  cmd ["curl https://elan.lean-lang.org/elan-init.sh -sSf | sh"] ++
  "Then open a new terminal, so that it can find the \\texttt{lake} command elan " ++
  "installed.\n" ++
  "\\item Install Tectonic, which sets the pages, following " ++
  "\\url{https://tectonic-typesetting.github.io/book/latest/installation/}.\n" ++
  "\\item Fetch the library, and turn it back to this edition's commit:\n" ++
  cmd ["git clone " ++ repository ++ ".git", "cd testimony",
    "git checkout \\editioncommit"] ++
  "\\item Download the mathematics library Lean builds on, already compiled, so " ++
  "it need not be compiled on your computer:\n" ++
  cmd ["lake exe cache get"] ++
  "\\item Check every argument. This is the longest step, and if any proof failed " ++
  "it would stop here with an error:\n" ++
  cmd ["cd " ++ r.package, "lake build"] ++
  "\\item Write the document from the source:\n" ++
  cmd ((r.before ++ [r.tool]).map ("lake exe " ++ ·) ++ ["cd .."]) ++
  "\\item Record the edition" ++
  (if r.credits then ", and work out from the repository's history who wrote " ++
    "each argument" else "") ++ ":\n" ++
  cmd ((if r.credits then ["python3 scripts/credits.py " ++ defs] else []) ++
    ["python3 scripts/edition.py " ++ defs]) ++
  "\\item Set the pages. For A4 paper:\n" ++
  cmd ["scripts/typeset.sh " ++ tex] ++
  "That makes \\texttt{" ++ escape (r.dir ++ "/" ++ pdf) ++ "}. For US Letter " ++
  "paper:\n" ++
  cmd ["scripts/typeset.sh --paper letter " ++ tex] ++
  "That makes \\texttt{" ++ escape letter ++ "} beside it.\n" ++
  "\\end{enumerate}\n" ++
  "Both sizes are set from the same source file, so they hold the same words, " ++
  "numbers and references; only the size of the page differs, and with it where " ++
  "the lines and pages break. Another size works the same way: " ++
  "\\texttt{--paper a5} makes \\texttt{" ++ escape a5 ++ "}. The fonts the " ++
  "document is set in come with Tectonic, not from your computer, so a copy you " ++
  "make on the same paper as this one should match it page for page. The script " ++
  "stops with an error if a character the document quotes is missing from those " ++
  "fonts, rather than leave a blank where it should be.\n"

/-- The fonts, and which font sets each script the documents quote.

Every font is named by its file, and every file is one the TeX distribution
ships: GNU FreeFont and DejaVu, which Tectonic's bundle and TeX Live both carry.
The fonts used to be looked up by name among the machine's own, Times New Roman
first, and the CI image that typesets the published PDFs has no fonts of its own.
So the documents fell back to Latin Modern, which has no Greek, no Hebrew and
none of the logical symbols, and XeTeX left a blank where each should be: the
published `sola-fide.pdf` read 'Paul's verb "justify" ( ) does not mean…'.
Named by file, a font is the same on every machine, and a PDF typeset on a
laptop is the PDF CI publishes.

FreeSerif sets the prose, Greek with every accent and breathing included.
DejaVu Sans Mono sets code. A few ranges no single font covers are passed to
another by XeTeX's character classes, which wrap each run of such characters in
a group set in the font that has them, so the rest of the line is untouched:

- Hebrew, in FreeSerif, so a word quoted inside code is set too, and a run of
  Hebrew is shaped right to left as one group, its punctuation left outside it;
- Syriac, in FreeSans, which alone of these has it;
- the modifier letters of a manuscript siglum (1QIsaᵃ) and the n-ary logical
  operators (`⋀`), which the italic and the monospace fonts lack.

Foundation's implication arrow `🡒` (U+1F852) is in no font the distribution
carries, so it is set as `→`, the glyph `Notation` already reads it as. -/
def fonts : String :=
  "\\setmainfont{FreeSerif}[Extension=.otf,UprightFont=*,BoldFont=*Bold,\n" ++
  "  ItalicFont=*Italic,BoldItalicFont=*BoldItalic,Ligatures=TeX]\n" ++
  "\\setmonofont{DejaVuSansMono}[Extension=.ttf,UprightFont=*,BoldFont=*-Bold,\n" ++
  "  ItalicFont=*-Oblique,BoldItalicFont=*-BoldOblique,Scale=MatchLowercase]\n" ++
  -- One family per fallback, upright in italic too: none of them has an italic of
  -- these scripts, and a missing shape is a blank again.
  String.join (fallbacks.map fun (name, font, script, _) =>
    "\\newfontfamily\\" ++ name ++ "font{" ++ font ++ "}[Extension=.otf,UprightFont=*," ++
    "BoldFont=*Bold,\n  ItalicFont=*,BoldItalicFont=*Bold" ++
    (if script.isEmpty then "" else ",Script=" ++ script) ++ "]\n") ++
  "\\XeTeXinterchartokenstate=1\n" ++
  "\\newcommand{\\fontrange}[3]{\\count255=#2\\relax\n" ++
  "  \\loop\\XeTeXcharclass\\count255=#1\\relax\\ifnum\\count255<#3\\relax\n" ++
  "  \\advance\\count255 by 1\\repeat}\n" ++
  String.join (fallbacks.map fun (name, _, _, ranges) =>
    "\\newXeTeXintercharclass\\" ++ name ++ "class\n" ++
    String.join (ranges.map fun (lo, hi) =>
      "\\fontrange\\" ++ name ++ "class{\"" ++ lo ++ "}{\"" ++ hi ++ "}\n")) ++
  -- Into a run from ordinary text (class 0) or a boundary (4095), out of it to
  -- either, and from one run straight into another.
  String.join (fallbacks.map fun (name, _, _, _) =>
    let cls := "\\" ++ name ++ "class"
    let enter := "{\\begingroup\\" ++ name ++ "font}"
    "\\XeTeXinterchartoks 0 " ++ cls ++ " " ++ enter ++ "\n" ++
    "\\XeTeXinterchartoks 4095 " ++ cls ++ " " ++ enter ++ "\n" ++
    "\\XeTeXinterchartoks " ++ cls ++ " 0 {\\endgroup}\n" ++
    "\\XeTeXinterchartoks " ++ cls ++ " 4095 {\\endgroup}\n" ++
    String.join ((fallbacks.filter (·.1 != name)).map fun (other, _, _, _) =>
      "\\XeTeXinterchartoks " ++ cls ++ " \\" ++ other ++ "class " ++
      "{\\endgroup\\begingroup\\" ++ other ++ "font}\n")) ++
  "\\usepackage{newunicodechar}\n" ++
  "\\newunicodechar{🡒}{→}\n" ++
  -- Ⓐ to Ⓩ label what follows in a truth table, and no font here has them, so
  -- each is drawn: the letter in a circle, as ① to ⑳ are set.
  "\\newcommand{\\circledletter}[1]{\\tikz[baseline=(c.base)]\\node[draw,circle," ++
  "inner sep=0.4pt,minimum size=1.1em,font=\\footnotesize](c){#1};}\n" ++
  String.join ((List.range 26).map fun k =>
    let letter := Char.ofNat ('A'.toNat + k)
    "\\newunicodechar{" ++ (Char.ofNat (0x24B6 + k)).toString ++ "}{\\circledletter{" ++
      letter.toString ++ "}}\n")
where
  /-- Each fallback: its name, its font's file, the OpenType script it is
  shaped as, and the ranges of code points it sets, in hexadecimal. -/
  fallbacks : List (String × String × String × List (String × String)) :=
    [("hebrew", "FreeSerif", "Hebrew", [("0590", "05FF")]),
     ("syriac", "FreeSans", "Syriac", [("0700", "074F")]),
     ("symbol", "FreeSerif", "", [("1D2C", "1D6A"), ("22C0", "22C3")])]

/-- **Credit, worked out when the document is typeset.** `\credit{key}`
expands to what `credits.def`, beside the document, defines for `key`, and to
nothing without it; `\creditline{key}` sets it centred under a heading, and sets
nothing at all where there is no credit.

The file is written by `scripts/credits.py` from git history when the PDF is
made, not by the generator, and is not committed. A commit that names no person
is credited to whoever merged it, so the credit changes at the moment of merge,
and a committed document holding it would be stale on `main` from then on. -/
def credits : String :=
  "\\newcommand{\\credit}[1]{\\ifcsname credit@#1\\endcsname" ++
  "\\csname credit@#1\\endcsname\\fi}\n" ++
  "\\newcommand{\\creditline}[1]{\\ifcsname credit@#1\\endcsname" ++
  "{\\centering\\credit{#1}\\par\\medskip}\\fi}\n" ++
  "\\InputIfFileExists{credits.def}{}{}\n"

/-- **The house style**: what every generated document shares, written once as
the package `testimony.sty`, which each generator writes beside its documents
and each document loads with one line. A document holds only its title, its
author line and its text.

It is built on KOMA-Script's `scrartcl`, the class `preamble` names, rather
than on LaTeX's plain `article` with the margins and spacing set by hand. KOMA
sets the width of the text block from the paper and the type size (`DIV`), so a
line stays within the length a reader's eye can follow, and sets headings in
the sans-serif face. Its foot margin, twice the head's, is the one thing
overridden: it left a wide band of white under every page number. The sans
face is FreeSans, so a heading that quotes Greek or Hebrew still has the glyphs
(`fonts`).

The rest is this library's own: a variable linked to its row in the legend
(`\pvar`), a derivation's rows (`derivation`), the gloss after a formula
(`\gloss`), the fonts, the edition's date and version (`edition`), and the
credit lines (`credits`). -/
def style : String :=
  "\\NeedsTeXFormat{LaTeX2e}\n" ++
  "\\ProvidesPackage{testimony}[Testimony house style, written by the generators]\n" ++
  "\\usepackage{amsmath,amssymb,array,booktabs,longtable,fontspec,xcolor,alltt}\n" ++
  "\\usepackage{tikz}\\usetikzlibrary{arrows.meta}\n" ++
  -- A truth table's colours (`tableWords`): what follows shaded blue, a test
  -- proposed here shaded gold, a struck row in grey.
  "\\usepackage{colortbl}\n" ++
  "\\definecolor{tablefollows}{RGB}{232,240,250}\\definecolor{tableproposed}{RGB}{251,244,226}\n" ++
  "\\definecolor{tablestruck}{RGB}{140,140,140}\\definecolor{tablekept}{RGB}{46,125,50}\n" ++
  "\\definecolor{tablebroken}{RGB}{179,38,30}\n" ++
  "\\usepackage{paracol}\\setcolumnwidth{0.4\\textwidth,0.56\\textwidth}\n" ++
  -- A light rule between a statement's logic and its words.
  "\\setlength{\\columnseprule}{0.4pt}\\colseprulecolor{black!25}\n" ++
  "\\usepackage[hidelinks]{hyperref}\n" ++
  -- A variable links to its row in the legend, and is coloured so a reader can
  -- see that it does: `hidelinks` sets every other link as plain text. The blue
  -- is dark enough to print as near-black.
  "\\definecolor{claimlink}{RGB}{25,70,150}\n" ++
  "\\newcommand{\\pvar}[2]{\\hyperlink{#1-P#2}{\\textcolor{claimlink}{P_{#2}}}}\n" ++
  -- The first use of a symbol links to its entry in the appendix of symbols
  -- (`Logic.Symbols.latexAppendix`), coloured as a claim's link is.
  "\\newcommand{\\symref}[2]{\\hyperlink{sym-#1}{\\textcolor{claimlink}{#2}}}\n" ++
  -- The target sits at the top of its row, so following a link shows the whole
  -- row rather than starting below its first line.
  "\\newcommand{\\pvartarget}[2]{\\raisebox{\\ht\\strutbox}{\\hypertarget{#1-P#2}{}}}\n" ++
  -- A derivation's rows: the label hangs in the margin, and the words after a
  -- formula run on and wrap beneath it, ragged so a narrow line is not
  -- stretched to fill the measure. The display it replaces could not break at
  -- all, and a list invites a break before it, between its rows and after it.
  -- So a page never breaks between a derivation and the paragraph before it, or
  -- the note a `\keepwithnext` keeps after it; a row is never split; and a page
  -- breaks between rows only where the generator starts a row with `\breakrow`
  -- (`breakable`).
  -- A package reads `@` as a letter, so the internals need no `\makeatletter`.
  "\\newenvironment{derivation}\n" ++
  "  {\\begin{list}{}{\\setlength{\\leftmargin}{2.6em}\\setlength{\\labelwidth}{2.2em}%\n" ++
  "    \\setlength{\\labelsep}{0.4em}\\setlength{\\itemsep}{2pt}\\setlength{\\parsep}{0pt}%\n" ++
  "    \\setlength{\\topsep}{6pt}\\@beginparpenalty\\@M\\@itempenalty\\@M%\n" ++
  "    \\interlinepenalty\\@M\\raggedright}}\n" ++
  "  {\\end{list}}\n" ++
  "\\newcommand{\\breakrow}[1]{\\@itempenalty\\z@\\item[#1]\\@itempenalty\\@M}\n" ++
  "\\newcommand{\\keepwithnext}{\\@endparpenalty\\@M}\n" ++
  -- No paragraph leaves a single line alone at the foot or the head of a page.
  -- A derivation cannot be parted from the paragraph before it, so without
  -- this TeX carries that paragraph's last line over with it, and the page
  -- opens on a fragment of a sentence.
  "\\clubpenalty=10000\n\\widowpenalty=10000\n" ++
  "\\newcommand{\\gloss}[1]{\\enspace---\\enspace{\\small\\itshape #1}}\n" ++
  -- Long unbreakable words — a cite key, a declaration name in \\texttt — would
  -- otherwise spill into the margin rather than loosening the line.
  "\\setlength{\\emergencystretch}{3em}\n" ++
  -- One width of space between words, wherever they fall. TeX's default widens
  -- the space after every full stop and colon, taking each for the end of a
  -- sentence; in text full of "ch. 16", "ad loc. Rom" and "p. 80" that reads
  -- as stray double spaces, and justification stretches them further.
  "\\frenchspacing\n" ++
  -- The line length is KOMA's (`DIV=13`, set by `preamble`); the height is not.
  -- KOMA gives the foot margin twice the head's, which on A4 left some 45mm
  -- of white under the page number. Here the page keeps KOMA's width and runs
  -- the text down to 24mm from the foot, with the number 11mm below it.
  "\\RequirePackage{geometry}\n" ++
  "\\edef\\testimony@geometry{width=\\the\\textwidth,top=22mm,bottom=24mm," ++
  "footskip=11mm}\n" ++
  "\\expandafter\\geometry\\expandafter{\\testimony@geometry}\n" ++
  fonts ++
  "\\setsansfont{FreeSans}[Extension=.otf,UprightFont=*,BoldFont=*Bold,\n" ++
  "  ItalicFont=*Oblique,BoldItalicFont=*BoldOblique]\n" ++
  edition ++ credits ++
  "\\endinput\n"

/-- The style file's name, as a document loads it and a generator writes it. -/
def styleFile : String := "testimony.sty"

/-- Preamble for a standalone document: the class, the house style (`style`), and
the title matter. Needs XeLaTeX: the claims contain Greek, Hebrew and Syriac,
the rendered Lean contains `¬`, `→` and `⊢`, and `fonts` sets them with XeTeX's
character classes.

`author`, where given, is set under the title, as LaTeX; it is how a document
carries its credit (`credits`). Under it come the edition's date and version
(`edition`), which say to a reader which copy they hold without naming the
program that made it; how it was made is the last section's business
(`reproduction`). -/
def preamble (title : String) (author : String := "") : String :=
  -- `DIV=13` divides the page into thirteen strips and gives the margins three,
  -- a wider text block than `DIV=11` and so fewer pages; `parskip=false` keeps
  -- indented paragraphs, as the prose is written for. The style file sets the
  -- page's height (`style`).
  --
  -- The paper is A4 unless `\testimonypaper` names another before the document
  -- is read: `scripts/typeset.sh --paper letter` typesets a US Letter edition
  -- through a one-line wrapper that defines it, so one `.tex` makes both.
  "\\providecommand{\\testimonypaper}{a4}\n" ++
  "\\documentclass[11pt,paper=\\testimonypaper,DIV=13,parskip=false]{scrartcl}\n" ++
  "\\usepackage{testimony}\n" ++
  "\\title{" ++ escape title ++ "}\n" ++
  (if author.isEmpty then "" else "\\author{" ++ author ++ "}\n") ++
  "\\date{\\editiondate\\\\[2pt]{\\small Version \\editionversion" ++
  "\\ifeditionpreview\\\\\\editionremark\\fi}}\n" ++
  "\\begin{document}\n\\maketitle\n"

/-- The table of contents, which the starred sections opt into by hand. -/
def contents : String := "\\tableofcontents\n"

/-- Closing matter: the bibliography built from `references.bib`, then
`closing`, the sections that come after it (`reproduction`). -/
def postamble (closing : String := "") : String :=
  "\n\\bibliographystyle{plain}\n\\bibliography{references}\n" ++ closing ++
  "\\end{document}\n"


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

-- `\paragraph*` is run-in, so a heading at that depth has to be made to break,
-- and kept with what follows it, as a run-in heading does not keep itself.
#guard prose "### Deep\n\ntext" == "\\paragraph*{Deep}\n\\leavevmode\\par\\nobreak\ntext\n\n"

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

-- A quotation's lines lose their `>` and are prose again: a blank `>` line
-- parts its paragraphs, and a `>` line ends the paragraph above it.
#guard prose "Before:\n> one\n> two\n>\n> - item\n\nafter" ==
  "Before:\n\n\\begin{quote}\none two\n\n\\begin{itemize}\n  \\item item\n" ++
  "\\end{itemize}\n\\end{quote}\nafter\n\n"

/-! The derivation's links and words, pinned on three claims of a test argument
`A`: claim `k` says "claim k". -/

/-- The test argument's claims. -/
private def testCite (k : Nat) : AtomMeta :=
  { label := "claim " ++ toString k, kind := .historical,
    source := { primary := .proposal "a test", tradition := .adversarialTrial,
                confidence := .disputed } }

/-- The test argument's numbering: three claims, linked, and glossed. -/
private def testNumbering : Numbering Nat :=
  { order := [0, 1, 2], anchor := "A", cite := some testCite }

-- A claim the position holds says itself where it comes in, and a denied one is
-- marked; a step that gives the conclusion leaves it to the turnstile row, which
-- names the conclusion at issue; every variable links to the legend.
#guard derivation testNumbering
    [.atom 0, .imp (.atom 1) .falsum, .imp (.and (.atom 0) (.imp (.atom 1) .falsum)) (.atom 2)]
    (.atom 2) ==
  "\\begin{derivation}\n" ++
  "  \\item[(1)] \\(\\pvar{A}{1}\\)\\gloss{claim 0}\n" ++
  "  \\item[(2)] \\(\\lnot \\pvar{A}{2}\\)\\gloss{\\emph{denied:} claim 1}\n" ++
  "  \\item[(3)] \\((\\pvar{A}{1} \\land \\lnot \\pvar{A}{2}) \\rightarrow \\pvar{A}{3}\\)\n" ++
  "  \\item[\\(\\vdash\\)] \\(\\pvar{A}{3}\\)\\gloss{\\emph{at issue:} claim 2}\n" ++
  "\\end{derivation}\n"

-- A step that gives anything else says what it would give, a denial as a denial.
#guard gloss testNumbering (some (.atom 2)) (.imp (.atom 0) (.imp (.atom 1) .falsum)) ==
  some "\\emph{would deny:} claim 1"

-- Of several claims, each is named by its variable.
#guard gloss testNumbering none (.imp (.atom 0) (.and (.atom 1) (.imp (.atom 2) .falsum))) ==
  some ("\\emph{would give:} \\(\\pvar{A}{2}\\) claim 1; " ++
    "\\(\\pvar{A}{3}\\) \\emph{denied:} claim 2")

-- A conclusion that is a denial is at issue as one; a note under a derivation is
-- kept with it.
#guard derivation testNumbering [] (.imp (.atom 1) .falsum) "A note.\n" ==
  "\\begin{derivation}\n" ++
  "  \\item[\\(\\vdash\\)] \\(\\lnot \\pvar{A}{2}\\)" ++
  "\\gloss{\\emph{at issue, the denial of:} claim 1}\n" ++
  "  \\keepwithnext\n\\end{derivation}\nA note.\n"

-- A lone formula is no position's premise: a step says what it would give, and a
-- claim is left to its links.
#guard loneGloss testNumbering (.imp (.atom 0) (.atom 1)) == some "\\emph{would give:} claim 1"
#guard loneGloss testNumbering (.and (.atom 0) (.atom 1)) == none
#guard loneGloss testNumbering (.imp (.atom 0) .falsum) == none

-- A step is built up from its claims: each it needs in words, with its rating and
-- source, a denied one marked; then what it would give; then the formula.
#guard step testNumbering (.imp (.and (.atom 0) (.imp (.atom 1) .falsum)) (.atom 2)) ==
  "\\par\\smallskip\\noindent If each of these holds,\n" ++
  "\\begin{derivation}\n" ++
  "  \\item[(1)] \\(\\pvar{A}{1}\\)\\enspace claim 0" ++
    "\\gloss{disputed: \\emph{proposed:} a test}\n" ++
  "  \\item[(2)] \\(\\lnot \\pvar{A}{2}\\)\\enspace \\emph{denied:} claim 1" ++
    "\\gloss{disputed: \\emph{proposed:} a test}\n" ++
  "  \\item[\\(\\therefore\\)] \\(\\pvar{A}{3}\\)\\enspace claim 2\n" ++
  "\\end{derivation}\n" ++
  "\\noindent In symbols, the step is " ++
    "\\((\\pvar{A}{1} \\land \\lnot \\pvar{A}{2}) \\rightarrow \\pvar{A}{3}\\).\n"

-- A step that is not a list of claims leading to claims is one row, as before.
#guard step testNumbering (.imp (.or (.atom 0) (.atom 1)) (.atom 2)) ==
  "\\begin{derivation}\n" ++
  "  \\item[] \\((\\pvar{A}{1} \\lor \\pvar{A}{2}) \\rightarrow \\pvar{A}{3}\\)" ++
    "\\gloss{\\emph{would give:} claim 2}\n" ++
  "\\end{derivation}\n"

-- A reading says, in words, the claims it takes as false, or, where fewer, the
-- claims it takes as true; a claim the page does not mention is left out.
#guard readingWords testNumbering [(0, true), (1, false), (2, true), (7, false)] ==
  "\\par\\smallskip\\noindent On this reading these claims are false:\n" ++
  "\\begin{derivation}\n  \\item[] \\(\\pvar{A}{2}\\)\\enspace claim 1\n\\end{derivation}\n" ++
  "\\noindent Every other claim on this page is true.\n"
#guard readingWords testNumbering [(0, false), (1, false), (2, true)] ==
  "\\par\\smallskip\\noindent On this reading only these claims are true:\n" ++
  "\\begin{derivation}\n  \\item[] \\(\\pvar{A}{3}\\)\\enspace claim 2\n\\end{derivation}\n" ++
  "\\noindent Every other claim on this page is false.\n"

-- A source says its rating, its tradition and its references.
#guard sourceWords (testCite 0).source ==
  "\\par\\smallskip\\noindent Rated \\emph{disputed}, held in the adversarial trial " ++
  "tradition: \\emph{proposed:} a test.\n"

-- What is not a list of claims has no words: a disjunction, a denied conjunction.
#guard gloss testNumbering none (.or (.atom 0) (.atom 1)) == none
#guard gloss testNumbering none (.imp (.and (.atom 0) (.atom 1)) .falsum) == none

-- Without a legend, nothing links and nothing is glossed.
#guard derivation ({ order := [0] } : Numbering Nat) [] (.atom 0) ==
  "\\begin{derivation}\n  \\item[\\(\\vdash\\)] \\(P_{1}\\)\n\\end{derivation}\n"

-- A page breaks inside a derivation only where three rows or more stand on
-- each side: never in one of five rows, and in one of eight before row 4, 5 or
-- 6 (counting from 1), the conclusion among the last three.
#guard (List.range 5).filter (breakable · 5) == []
#guard (List.range 8).filter (breakable · 8) == [3, 4, 5]
#guard numbered 3 8 == "\\breakrow{(4)}"
#guard numbered 2 8 == "\\item[(3)]"

-- A link's name keeps nothing TeX or a PDF viewer would read as markup, and
-- drops nothing, so two namespaces never share one.
#guard anchorName "Testimony.Arguments.SolaFide" == "Testimony.Arguments.SolaFide"
#guard anchorName "A_b-c «d»" == "A-95-b-45-c-32--171-d-187-"
#guard anchorName "A_b" != anchorName "Ab"

end Testimony.Logic.Latex
