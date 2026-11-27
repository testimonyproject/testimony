import Testimony.Logic.Markdown

/-!
# The symbols in the logic, and where a reader learns them

A result is printed twice, side by side: in logic notation on the left, in the
docstring's English on the right. A reader who does not know the notation reads
the English, and one who wants to learn it needs somewhere to look a symbol up.
This module is that place, written once for both renderings.

`table` lists every symbol the generated pages set (`Doc.Sym.toSym` in
`Testimony.Tools.Pages`, and the derivations of `Testimony.Logic.Latex`), each
with an example and what the example says in plain words. `linkFirst` finds the
first use of each symbol in a document and links it to the symbol's entry:
`latexAppendix` sets the entries a PDF uses as its appendix, and
`markdownPage` sets every entry as a page of the site.
-/

namespace Testimony.Logic.Symbols

/-- One symbol: how it is written, an example of it in use, and the example in
words. -/
structure Symbol where
  /-- The anchor its entry carries, `sym-<key>`. -/
  key : String
  /-- The LaTeX commands it is written with, any of which is a use of it. -/
  commands : List String
  /-- The symbol on its own, as LaTeX mathematics. -/
  shown : String
  /-- How to read it aloud, in a few words. -/
  readAs : String
  /-- An example of it in use, as LaTeX mathematics. -/
  sample : String
  /-- What the example says, in plain words. -/
  words : String
  /-- The kind of mathematical symbol it is (`\mathrel`, `\mathbin`, `\mathop`),
  so that a link around it keeps the spacing it would have had; empty for an
  ordinary symbol. -/
  kind : String := ""
  deriving Repr

/-- Every symbol the generated pages set, in the order a reader meets them in
the appendix: how claims are joined, then sets, then what follows from what,
then disputes. A command that another contains (`\models` in `\not\models`)
comes after it, so that the longer one is found first. -/
def table : List Symbol := [
  { key := "and", kind := "\\mathbin",
    commands := ["\\wedge", "\\land"], shown := "\\land", readAs := "and"
    sample := "A \\land B"
    words := "A and B are both true." },
  { key := "or", kind := "\\mathbin",
    commands := ["\\vee", "\\lor"], shown := "\\lor", readAs := "or"
    sample := "A \\lor B"
    words := "At least one of A and B is true, and perhaps both." },
  { key := "not", commands := ["\\neg", "\\lnot"], shown := "\\lnot", readAs := "not"
    sample := "\\lnot A"
    words := "A is false." },
  { key := "implies", kind := "\\mathrel",
    commands := ["\\rightarrow"], shown := "\\rightarrow",
    readAs := "if … then"
    sample := "(A \\land B) \\rightarrow C"
    words := "If A and B are true, then C is true. It says nothing of what happens when " ++
      "A or B is false. In a numbered line of reasoning, a row of this shape is a step: " ++
      "grant the claims on the left, and the one on the right follows." },
  { key := "iff", kind := "\\mathrel",
    commands := ["\\leftrightarrow"], shown := "\\leftrightarrow",
    readAs := "exactly when"
    sample := "A \\leftrightarrow B"
    words := "A and B are true in exactly the same cases: whenever one holds, so does the " ++
      "other." },
  { key := "neq", kind := "\\mathrel",
    commands := ["\\neq"], shown := "\\neq", readAs := "is not"
    sample := "x \\neq y"
    words := "x and y are different things." },
  { key := "top", commands := ["\\top"], shown := "\\top", readAs := "true"
    sample := "\\top"
    words := "A statement that is always true." },
  { key := "bot", commands := ["\\bot"], shown := "\\bot", readAs := "false"
    sample := "\\bot"
    words := "A statement that is always false." },
  { key := "therefore", kind := "\\mathrel",
    commands := ["\\vdash"], shown := "\\vdash", readAs := "so"
    sample := "\\vdash C"
    words := "The conclusion a line of reasoning reaches, set under its numbered grounds " ++
      "and steps: grant every row above, and C follows." },
  { key := "forall", commands := ["\\forall"], shown := "\\forall", readAs := "for every"
    sample := "\\forall i, j \\in S.\\ \\ldots"
    words := "What comes after the full stop is true for every i and every j in S: for " ++
      "every pair of parties, say, when S is the parties to a dispute." },
  { key := "exists", commands := ["\\exists"], shown := "\\exists", readAs := "there is"
    sample := "\\exists v.\\ \\ldots"
    words := "There is at least one v for which what comes after the full stop is true." },
  { key := "in", kind := "\\mathrel",
    commands := ["\\in"], shown := "\\in", readAs := "is one of"
    sample := "x \\in S"
    words := "x is one of the things in the collection S." },
  { key := "set", commands := ["\\{"], shown := "\\{\\ \\}", readAs := "the collection of"
    sample := "\\{a, b\\}"
    words := "The collection of exactly a and b. Written with an upright bar after x in " ++
      "S, it is the collection of those x in S of which what follows the bar is true. " ++
      "A pair in round brackets, (i, j), is two things in order: i first, " ++
      "then j." },
  { key := "empty", commands := ["\\varnothing", "\\emptyset"], shown := "\\varnothing",
    readAs := "nothing"
    sample := "(i, j) \\in \\varnothing"
    words := "The empty collection, with nothing in it. Nothing is one of its members, so " ++
      "a statement that a pair is in it is always false: no pair qualifies." },
  { key := "union", kind := "\\mathbin",
    commands := ["\\cup"], shown := "\\cup", readAs := "together with"
    sample := "A \\cup B"
    words := "Everything in A together with everything in B." },
  { key := "bigunion", kind := "\\mathop",
    commands := ["\\bigcup"], shown := "\\bigcup",
    readAs := "all of these together"
    sample := "\\bigcup_{i \\in S} A_{i}"
    words := "The collections A, one for each i in S, put together into one." },
  { key := "bigintersection", kind := "\\mathop",
    commands := ["\\bigcap"], shown := "\\bigcap",
    readAs := "what all of these share"
    sample := "\\bigcap \\mathrm{Pref}(D)"
    words := "What every one of the collections has in common." },
  { key := "premises", commands := ["\\Gamma"], shown := "\\Gamma",
    readAs := "the claims a position rests on"
    sample := "\\Gamma_{X}"
    words := "Every claim position X grants, the grounds it starts from and the steps it " ++
      "takes: its premises." },
  { key := "conclusion", commands := ["\\varphi"], shown := "\\varphi",
    readAs := "what a position concludes"
    sample := "\\varphi_{X}"
    words := "The conclusion position X argues for." },
  { key := "notfollows", kind := "\\mathrel",
    commands := ["\\not\\models"], shown := "\\not\\models",
    readAs := "does not follow from"
    sample := "\\Gamma \\not\\models C"
    words := "C does not follow from the claims on the left: there is a way to grant every one " ++
      "of them and deny C, and the page names it." },
  { key := "follows", kind := "\\mathrel",
    commands := ["\\models"], shown := "\\models",
    readAs := "follows from; makes true"
    sample := "\\Gamma \\models C"
    words := "C follows from the claims on the left: there is no way to grant every one of them " ++
      "and deny C. Written after a reading v, with the claims after it, it says the reading " ++
      "v makes every one of those claims true, so that they can all be held at once." },
  { key := "defeats", kind := "\\mathrel",
    commands := ["\\rightsquigarrow"], shown := "\\rightsquigarrow",
    readAs := "defeats"
    sample := "i \\rightsquigarrow j"
    words := "Position i defeats position j: i denies something j rests on, and where i " ++
      "is weakest it is held at least as firmly as what it denies." },
  { key := "supports", kind := "\\mathrel",
    commands := ["\\Rightarrow"], shown := "\\Rightarrow",
    readAs := "supports"
    sample := "i \\Rightarrow j"
    words := "Position i lends position j one of the claims j rests on." },
  { key := "partof", kind := "\\mathrel",
    commands := ["\\sqsubseteq"], shown := "\\sqsubseteq",
    readAs := "is part of"
    sample := "i \\sqsubseteq j"
    words := "The case position i makes is contained in the case position j makes." },
  { key := "strength", commands := ["\\mathrm{strength}"], shown := "\\mathrm{strength}",
    readAs := "how firmly it is held"
    sample := "\\mathrm{strength}(X)"
    words := "How firmly position X is held where it is weakest: the lowest rating among " ++
      "the claims and steps it rests on." },
  { key := "preferred", commands := ["\\mathrm{Pref}"], shown := "\\mathrm{Pref}",
    readAs := "the ways of settling the dispute"
    sample := "x \\in \\bigcup \\mathrm{Pref}(D)"
    words := "Pref(D) is every way of settling the dispute D: each is a largest group of " ++
      "positions that can be held together and that answers every position defeating " ++
      "one of its members. In the example, x is kept by at least one way of settling it; " ++
      "with the symbol for what all share in place of the one for all together, x is " ++
      "kept by every way." },
  { key := "grounded", commands := ["\\mathrm{Gr}"], shown := "\\mathrm{Gr}",
    readAs := "what the dispute forces"
    sample := "\\mathrm{Gr}(D)"
    words := "The positions the dispute D forces, whichever way it is settled: those " ++
      "nothing defeats, and then those whose every attacker is defeated by one already " ++
      "forced." },
  { key := "admissible", commands := ["\\mathrm{Adm}"], shown := "\\mathrm{Adm}",
    readAs := "can be defended"
    sample := "\\mathrm{Adm}(D, S)"
    words := "The group of positions S can be held together, and answers every position " ++
      "in D that defeats one of its members." }
]

/-- Where `cmd` is next used in `line` as a symbol, as the index of the piece of
`line.splitOn cmd` it follows: not inside a longer command (`\in` in `\int`),
not negated (`\models` in `\not\models`), and not escaped (`\\{` in Markdown). -/
def firstUse (line cmd : String) : Option Nat :=
  let ps := line.splitOn cmd
  let endsInLetter := cmd.back.isAlpha
  (List.range (ps.length - 1)).find? fun k =>
    let before := ps.getD k ""
    let after := ps.getD (k + 1) ""
    (!endsInLetter || after.isEmpty || !after.front.isAlpha) &&
      !before.endsWith "\\not" && !before.endsWith "\\"

/-- `line` with the use of `cmd` at `k` (`firstUse`) replaced by `wrapped`. -/
def replaceAt (line cmd wrapped : String) (k : Nat) : String :=
  let ps := line.splitOn cmd
  cmd.intercalate (ps.take (k + 1)) ++ wrapped ++ cmd.intercalate (ps.drop (k + 1))

/-- **Link the first use of every symbol** in a document, a line at a time:
`wrap s cmd` is what the first use of `s`, written `cmd`, becomes, and a line
for which `skip` holds (a heading, a block of code) is left as it is. Returns
the document and the symbols it uses, in the order of `table`. -/
def linkFirst (wrap : Symbol → String → String) (skip : String → Bool → Bool × Bool)
    (text : String) : String × List Symbol :=
  let step := fun (acc : Array String × List String × Bool) (line : String) =>
    let (out, done, inBlock) := acc
    let (skipThis, inBlock') := skip line inBlock
    if skipThis then (out.push line, done, inBlock')
    else
      let (line', done') := table.foldl (fun (l, d) s =>
        if d.contains s.key then (l, d)
        else match s.commands.findSome? (fun c => (firstUse l c).map (c, ·)) with
          | some (c, k) => (replaceAt l c (wrap s c) k, s.key :: d)
          | none => (l, d)) (line, done)
      (out.push line', done', inBlock')
  let (out, done, _) := (text.splitOn "\n").foldl step (#[], [], false)
  ("\n".intercalate out.toList, table.filter (done.contains ·.key))

/-- `link` around the symbol `s`, in the kind of symbol `s` is. -/
def keepKind (s : Symbol) (link : String) : String :=
  if s.kind.isEmpty then link else s.kind ++ "{" ++ link ++ "}"

/-! ### In print -/

/-- A line of LaTeX not to link in: a heading, which a link would carry into the
contents and the bookmarks, and the lines of a block of code. -/
def latexSkip (line : String) (inBlock : Bool) : Bool × Bool :=
  let t := line.trimAscii.toString
  if t.startsWith "\\begin{verbatim}" || t.startsWith "{\\small\\begin{verbatim}" ||
      t.startsWith "\\begin{alltt}" then (true, true)
  else if t.startsWith "\\end{verbatim}" || t.startsWith "\\end{alltt}" then (true, false)
  else if inBlock then (true, true)
  else ((["\\section", "\\subsection", "\\subsubsection", "\\paragraph", "\\addcontentsline",
      "\\caption", "\\title"].any (fun h => t.startsWith h)), false)

/-- A document's body with the first use of each symbol linked to its entry in
the appendix (`\symref`, defined in the house style), and the symbols used. -/
def linkLatex (body : String) : String × List Symbol :=
  linkFirst (fun s c => keepKind s ("\\symref{" ++ s.key ++ "}{" ++ c ++ "}")) latexSkip body

/-- **The appendix of symbols**: every symbol a document uses, with an example
and the example in words, each entry the target of the symbol's first use.
Nothing when the document uses none. -/
def latexAppendix (used : List Symbol) : String :=
  if used.isEmpty then "" else
  let row (s : Symbol) : String :=
    "\\hypertarget{sym-" ++ s.key ++ "}{}\\(" ++ s.shown ++ "\\) & \\(" ++ s.sample ++
      "\\) & \\textbf{" ++ Latex.escape s.readAs ++ ".} " ++ Latex.escape s.words ++ " \\\\\n"
  "\n\\clearpage\n\\section*{The symbols in the logic}\n" ++
  "\\addcontentsline{toc}{section}{The symbols in the logic}\n" ++
  "Each result in this document is stated twice, side by side: on the left in the " ++
  "notation logicians use, and on the right in English. The English says everything " ++
  "the notation does, so a reader can skip the left column. This table is for a reader " ++
  "who wants to follow it too. The first time each symbol is used, it links here.\n\n" ++
  "A \\(P\\) with a number is one of the argument's claims, listed with its source in " ++
  "the table of numbered claims, and every one links there. A name in a plain typeface, " ++
  "such as \\(\\mathsf{citesOnlyBefore}\\), is the library's own name for a group of " ++
  "things or a test, and the English beside it says what it is.\n\n" ++
  "\\begin{longtable}{@{}>{\\centering\\arraybackslash}p{0.09\\textwidth} " ++
    ">{\\raggedright\\arraybackslash}p{0.24\\textwidth} " ++
    ">{\\raggedright\\arraybackslash}p{0.6\\textwidth}@{}}\n" ++
  "\\toprule\n\\textbf{Symbol} & \\textbf{Example} & \\textbf{What the example says} " ++
    "\\\\\n\\midrule\n\\endhead\n" ++
  String.join (used.map row) ++
  "\\bottomrule\n\\end{longtable}\n"

/-! ### On the site -/

/-- A line of Markdown not to link in: a fenced block of code. -/
def markdownSkip (line : String) (inBlock : Bool) : Bool × Bool :=
  if line.trimAscii.toString.startsWith "```" then (true, !inBlock)
  else (inBlock, inBlock)

/-- A page's Markdown with the first use of each symbol linked, inside its
formula, to the symbol's entry on the page `target` (`symbols.html`, relative
to the page). -/
def linkMarkdown (target : String) (md : String) : String :=
  let wrap (s : Symbol) (c : String) : String :=
    keepKind s ("\\href{" ++ target ++ "#sym-" ++ s.key ++ "}{" ++ c ++ "}")
  let linked := (linkFirst wrap markdownSkip md).1
  -- A subscript after a link follows a brace, where Markdown would read its `_`
  -- as the start of emphasis: escaped, it reaches MathJax as a subscript.
  table.foldl (fun acc s => s.commands.foldl (fun acc' c =>
    acc'.replace (wrap s c ++ "_") (wrap s c ++ "\\_")) acc) linked

/-- **The site's page of symbols**: every symbol, with an example and the
example in words. -/
def markdownPage : String :=
  let m (t : String) := Markdown.inlineMath (Markdown.mathEscape t)
  "Each result on these pages is stated twice, side by side: on the left in the " ++
  "notation logicians use, and on the right in English. The English says everything " ++
  "the notation does, so a reader can skip the left column. This page is for a reader " ++
  "who wants to follow it too. On each page, the first use of a symbol links here.\n\n" ++
  "A \\\\(P\\\\) with a number is one of the argument's claims, listed with its source " ++
  "in the argument's table of numbered claims, and every one links there. A name in a " ++
  "plain typeface, such as \\\\(\\mathsf{citesOnlyBefore}\\\\), is the library's own name " ++
  "for a group of things or a test, and the English beside it says what it is.\n\n" ++
  "| Symbol | Example | What the example says |\n|---|---|---|\n" ++
  String.join (table.map fun s =>
    "| <a id=\"sym-" ++ s.key ++ "\"></a>" ++ m s.shown ++ " | " ++ m s.sample ++
      " | **" ++ Markdown.escape s.readAs ++ ".** " ++ Markdown.escape s.words ++ " |\n")

-- The first use of a symbol is linked and later ones are not; a longer command
-- is not mistaken for a shorter one inside it; headings are left alone.
#guard (linkLatex "\\paragraph{\\(A \\land B\\)}\n\\(A \\land B \\land C\\)\n\\(\\int x\\)").1 ==
  "\\paragraph{\\(A \\land B\\)}\n\\(A \\mathbin{\\symref{and}{\\land}} B \\land C\\)\n" ++
  "\\(\\int x\\)"
#guard (linkLatex "\\(\\Gamma \\not\\models C\\) \\(\\Gamma \\models C\\)").1 ==
  "\\(\\symref{premises}{\\Gamma} \\mathrel{\\symref{notfollows}{\\not\\models}} C\\) " ++
  "\\(\\Gamma \\mathrel{\\symref{follows}{\\models}} C\\)"
#guard ((linkLatex "\\(\\bottomrule \\bot\\)").2.map (·.key)) == ["bot"]
#guard linkMarkdown "s.html" "\\\\(\\bigcup_{i} \\Gamma_{i}\\\\)" ==
  "\\\\(\\mathop{\\href{s.html#sym-bigunion}{\\bigcup}}\\_{i} " ++
  "\\href{s.html#sym-premises}{\\Gamma}\\_{i}\\\\)"
#guard (linkLatex "\\begin{verbatim}\n\\forall\n\\end{verbatim}\n").2.isEmpty

end Testimony.Logic.Symbols
