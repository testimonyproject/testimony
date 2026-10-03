import Testimony.Semantics.Grammar
import Testimony.Logic.Package

/-!
# Testimony.Semantics.Meaning — what an argument's claims mean

**A draft.** Every argument names its atomic claims in a type of its own, and a
`HasMeanings` instance says what each one asserts, as a `Statement`. The atoms
are not replaced, and no proof reads a meaning: the instance sits beside the
argument as its `cite` does.

The instance lists every atom and proves the list complete, so a meaning cannot
silently miss one. An argument whose claims are not yet analysed still has an
instance — `HasMeanings.ofLabels`, which marks each atom unanalysed with its
citation's label — so it is counted, as unanalysed, rather than left out.
`Testimony.Checks.Meanings` fails the build for an argument with no instance at
all, so a new argument cannot be added without one.

Everything below asks its question of any argument, by its instance.
-/

namespace Testimony.Semantics

open Testimony.Logic

/-- **What an argument's claims mean.** Every atom, listed, and a meaning for
each. -/
class HasMeanings (α : Type) where
  /-- The argument's name, as its page names it. -/
  argument : String
  /-- Every atom of the argument. -/
  all : List α
  /-- What each atom asserts. -/
  means : α → Statement
  /-- The list has every atom. -/
  complete : ∀ a, a ∈ all

namespace HasMeanings

/-- **Meanings not yet analysed**: each atom marked `opaque`, with its
citation's label. Where an argument starts, so that it is counted from the
start. -/
def ofLabels {α : Type} (argument : String) (all : List α) (cite : α → AtomMeta)
    (complete : ∀ a, a ∈ all) : HasMeanings α :=
  { argument, all, complete, means := fun a => .opaque (cite a).label }

variable {α : Type} [HasMeanings α]

/-- The atoms whose meaning is not yet analysed. -/
def unanalysed : List α := (all : List α).filter fun a => (means a).isOpaque

/-- How many atoms have a meaning, out of how many. -/
def coverage : Nat × Nat :=
  ((all : List α).length - (unanalysed (α := α)).length, (all : List α).length)

/-- Every word the argument gives two senses at one place. -/
def contested : List (Lexeme × Scope × Sense × Sense) :=
  readTwoWays ((all : List α).map means)

/-- The atoms that turn on a word. -/
def about (w : Lexeme) : List α := (all : List α).filter fun a => (means a).mentions w

/-- The atoms that deny a word has the same sense at two places. -/
def denyingSameSense (w : Lexeme) (a b : Scope) : List α :=
  (all : List α).filter fun c => (means c).deniesSameSense w a b

end HasMeanings

end Testimony.Semantics
