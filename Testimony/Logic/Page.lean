import Testimony.Logic.Line

/-!
# Testimony.Logic.Page — what a generated page is made of

An argument module is a literate document: a module docstring saying what the
dispute is, `/-! ### … -/` blocks marking its sections, and a docstring on every
package, line, countermodel and result. `Testimony.Tools.Pages` harvests all of
it from the environment in source order; this module is the shape it comes back
in, and `Testimony.Logic.Markdown` and `Testimony.Logic.Latex` are the two
renderings of that shape.

The type sits here rather than in either renderer because neither owns it. The
harvest is medium-independent — a docstring, a package, a pretty-printed
statement — and what differs is only how each is set.
-/

namespace Testimony.Logic.Page

open Testimony

variable {α : Type}

/-- Why one position stands against another, as a page shows it: the data of a
`Because` (`Testimony.Logic.Because`), without its proofs. -/
structure Explanation (α : Type) where
  /-- The position that stands. -/
  holder : String
  /-- The rival it stands against. -/
  rival : String
  /-- Citation and classification for every atom, the holder's. -/
  cite : α → AtomMeta
  /-- The premise the explanation turns on. -/
  crux : Formula α
  /-- Further premises of the holder the break needs. -/
  granted : List (Formula α)
  /-- The premises of the rival that cannot be held with the crux. -/
  core : List (Formula α)
  /-- Whether the holder's conclusion needs the crux, or the crux only answers
  the rival. -/
  derives : Bool
  /-- The holder's cited inferences: what rates a crux that is a step rather
  than a claim. -/
  inferences : List Source

namespace Explanation

/-- Whether a formula is a claim or a denied claim, as against a step. -/
def isLiteral : Formula α → Bool
  | .atom _ => true
  | .imp (.atom _) .falsum => true
  | _ => false

/-- The claims an explanation rests on, each once: the crux, when it is a
claim, and the granted grounds. A crux that is a step rests on the step's own
rating instead, not on the claims it mentions — some of which are the rival's. -/
def restsOn [DecidableEq α] (e : Explanation α) : List α :=
  ((if isLiteral e.crux then atomsOf e.crux else []) ++ e.granted.flatMap atomsOf).eraseDups

end Explanation

/-- One element of a generated page.

`prose` is a module docstring, lifted whole; the rest are declarations, each
carrying its own docstring and whatever rendering its type admits. The cases
are the shapes an argument module actually declares, and `other` is the honest
fallback — a declaration the renderer has no special reading of is still
listed, with its source, rather than silently dropped. -/
inductive Item (α : Type)
  /-- Prose lifted from a module docstring. Markdown, as docstrings are. -/
  | prose (markdown : String)
  /-- A named position: its premises and its conclusion. -/
  | package (decl doc : String) (pkg : ArgumentPackage α)
  /-- A named line of reason: its grounds, its step, what it delivers. -/
  | line (decl doc : String) (l : Line α)
  /-- A named formula, usually an inference step. -/
  | formula (decl doc : String) (φ : Formula α)
  /-- A named list of formulas, usually grounds shared between lines. -/
  | formulas (decl doc : String) (φs : List (Formula α))
  /-- A declaration shown as Lean: a countermodel, whose content is a function,
  or anything else the renderer does not read. -/
  | other (decl doc source : String)
  /-- A result, with the statement as Lean states it. -/
  | result (decl doc statement : String) (proposed : Bool)
  /-- Why one position stands against another: a `Because`. -/
  | because (decl doc : String) (e : Explanation α)

namespace Item

/-- Every atom this item mentions, in the order it mentions them. -/
def atoms [DecidableEq α] : Item α → List α
  | .package _ _ pkg => pkg.atoms
  | .line _ _ l => (l.premises ++ [l.delivers]).flatMap atomsOf
  | .formula _ _ φ => atomsOf φ
  | .formulas _ _ φs => φs.flatMap atomsOf
  | .because _ _ e => (e.crux :: e.granted ++ e.core).flatMap atomsOf
  | _ => []

end Item

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
package's is the argument's. An argument with no package has nothing to legend,
and cannot occur: rule L5 requires at least two. -/
def citeOf : List (Item α) → Option (α → AtomMeta)
  | [] => none
  | .package _ _ pkg :: _ => some pkg.cite
  | _ :: rest => citeOf rest

end Testimony.Logic.Page
