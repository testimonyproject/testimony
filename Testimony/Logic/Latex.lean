import Testimony.Logic.Package
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
-/

namespace Testimony.Logic.Latex

open Testimony Testimony.Bib

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

/-- The legend: one row per atom, giving its claim, classification and source.
This is the assumption manifest, typeset. -/
def legend [DecidableEq α] (pkg : ArgumentPackage α) (order : List α) : String :=
  let rows := order.zipIdx.map fun (a, i) =>
    let m := pkg.cite a
    "$" ++ varName i ++ "$ & " ++ escape m.label ++ " & " ++ kind m.kind ++
      " & " ++ source m.source ++ " \\\\"
  "\\begin{longtable}{@{}rp{0.44\\textwidth}ll@{}}\n" ++
  "\\toprule\n & claim & kind & source \\\\\n\\midrule\n\\endhead\n" ++
  String.intercalate "\n" rows ++ "\n\\bottomrule\n\\end{longtable}\n"

/-- An argument package as a LaTeX section: legend, premises, conclusion. -/
def package [DecidableEq α] (pkg : ArgumentPackage α) : String :=
  let order := pkg.atoms
  let prems := pkg.premises.zipIdx.map fun (φ, i) =>
    "  \\text{(" ++ toString (i + 1) ++ ")} \\quad & " ++ formula order φ ++ " \\\\"
  "\\subsection*{" ++ escape pkg.name ++ "}\n\n" ++
  legend pkg order ++
  "\n\\begin{align*}\n" ++ String.intercalate "\n" prems ++ "\n" ++
  "  \\midrule[0pt] \\vdash \\quad & " ++ formula order pkg.conclusion ++ "\n" ++
  "\\end{align*}\n\n" ++
  (if pkg.scriptureOnlyAtoms.isEmpty then
     "\\emph{No premise rests on scripture alone.}\n"
   else
     "\\emph{Grounded in scripture alone:} " ++
     String.intercalate ", "
       (pkg.scriptureOnlyAtoms.map fun m => escape m.label) ++ ".\n")

/-- Preamble for a standalone document. Needs XeLaTeX or LuaLaTeX: the claims
contain Greek and Hebrew. -/
def preamble (title : String) : String :=
  "\\documentclass[11pt]{article}\n" ++
  "\\usepackage{amsmath,amssymb,booktabs,longtable,geometry,fontspec}\n" ++
  "\\geometry{margin=1in}\n" ++
  "\\setmainfont{Times New Roman}[Ligatures=TeX]\n" ++
  "\\title{" ++ escape title ++ "}\n" ++
  "\\date{Generated by \\texttt{lake exe argtex}}\n" ++
  "\\begin{document}\n\\maketitle\n"

/-- Closing matter, including the bibliography built from `references.bib`. -/
def postamble : String :=
  "\n\\bibliographystyle{plain}\n\\bibliography{references}\n\\end{document}\n"

end Testimony.Logic.Latex
