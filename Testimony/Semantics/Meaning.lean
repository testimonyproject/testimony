import Testimony.Semantics.Grammar
import Testimony.Ontology.Shared
import Testimony.Logic.Package
import Testimony.Logic.Postulates

/-!
# Testimony.Semantics.Meaning — what an argument's claims mean

**A draft.** Every argument names its atomic claims in a type of its own, and a
`HasMeanings` instance says what each one asserts, as a `Statement`. The atoms
are not replaced, and the instance sits beside the argument as its `cite` does.
One thing is read from it: where two claims' meanings cannot both hold, the
pair is an **exclusion**, and its formula `a → ¬b` a **meaning postulate**.
Where one claim's meaning asserts all of another's, the pair is an
**entailment**, and its postulate `a → b`. Both are read for what the words
mean, not for the shape of the terms: each meaning is taken apart into what it
affirms and denies, and closed under the definitions the articles of
`Testimony.Ontology` write out (`Testimony.Semantics.Ontology`). Each argument
lists its exclusions
and entailments, and proves the lists are exactly what its meanings contain
(`HasJoins`); from those lists, and only from them, the argument's atoms get
their postulates (`Testimony.Logic.HasPostulates`). A
credibility check holds them as background (`Testimony.Logic.Dissent`), so that
the logic sees what the meanings say.

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

namespace Statement

/-- The statements a statement asserts together: `also` taken apart. -/
def parts : Statement → List Statement
  | .also s t => s.parts ++ t.parts
  | s => [s]

/-- Whether a statement is analysed throughout: no part of it is `opaque`.
Two unanalysed atoms may share a label; that says nothing about what they mean. -/
def analysed (s : Statement) : Bool := s.parts.all (!·.isOpaque)

/-- **Two meanings exclude each other** when, read for what their words mean
(`Testimony.Ontology.shared`), each can be held alone and not both together:
"the word means a verdict, and not making righteous" excludes "the word means
making righteous" (sola fide's lexical claim and Trent's reading of Paul's
word); "justification includes the remission of sins, and not sanctification"
excludes "justification includes both"; and "faith is the only means by which
justification is received" excludes "baptism is a means by which it is". -/
def excludes (s t : Statement) : Bool :=
  Ontology.excludes Testimony.Ontology.shared (Ontology.closed Testimony.Ontology.shared s)
    (Ontology.closed Testimony.Ontology.shared t)

/-- **One meaning entails another** when, read for what its words mean, it
asserts all the other does: "the word means a verdict, and not making righteous"
entails "the word means a verdict". A reader who holds the one holds the
other. -/
def entails (s t : Statement) : Bool :=
  Ontology.entails Testimony.Ontology.shared (Ontology.closed Testimony.Ontology.shared s)
    (Ontology.closed Testimony.Ontology.shared t)

end Statement

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

/-- Every pair from a list, each once, in the list's order. -/
def pairsOf {β : Type} : List β → List (β × β)
  | [] => []
  | x :: xs => xs.map (x, ·) ++ pairsOf xs

/-- **Every pair of claims whose meanings exclude each other**, under a given
ontology: `(a, b)`, with `a` listed before `b`, when the two meanings, read for
what their words mean, cannot both be held. -/
def exclusionsUnder [DecidableEq α] (O : Ontology) : List (α × α) :=
  let shaped := (all : List α).map fun a => (a, Ontology.closed O (means a))
  (pairsOf shaped).filterMap fun ((a, s), (b, t)) =>
    if a ≠ b && Ontology.excludes O s t then some (a, b) else none

/-- **Every pair of claims whose meanings entail one another**, under a given
ontology: `(a, b)` when the meaning of `a`, read for what its words mean,
asserts everything the meaning of `b` does. -/
def entailmentsUnder [DecidableEq α] (O : Ontology) : List (α × α) :=
  let shaped := (all : List α).map fun a => (a, Ontology.closed O (means a))
  shaped.flatMap fun (a, s) => shaped.filterMap fun (b, t) =>
    if a ≠ b && Ontology.entails O s t then some (a, b) else none

/-- **Every pair of claims whose meanings exclude each other**: `(a, b)`, with `a`
listed before `b`, when the two meanings cannot both be held, read under the
shared ontology (`Testimony.Ontology.shared`). Two claims the atom type keeps
apart, the meanings join: a reader who holds either must deny the other. -/
def exclusions [DecidableEq α] : List (α × α) := exclusionsUnder Testimony.Ontology.shared

/-- **Every pair of claims whose meanings entail one another**: `(a, b)` when
the meaning of `a` asserts everything the meaning of `b` does, read under the
shared ontology. A reader who holds `a` holds `b`. -/
def entailments [DecidableEq α] : List (α × α) := entailmentsUnder Testimony.Ontology.shared

/-- **The atoms whose meaning contradicts itself** under the shared ontology. A
meaning that cannot be held is a mistake in the meaning, and joins nothing. -/
def incoherent : List α :=
  (all : List α).filter fun a =>
    let s := Ontology.closed Testimony.Ontology.shared (means a)
    s.read && !Ontology.coherent Testimony.Ontology.shared s

/-- The atoms that turn on a word. -/
def about (w : Lexeme) : List α := (all : List α).filter fun a => (means a).mentions w

/-- The atoms that deny a word has the same sense at two places. -/
def denyingSameSense (w : Lexeme) (a b : Scope) : List α :=
  (all : List α).filter fun c => (means c).deniesSameSense w a b

end HasMeanings

/-- **An argument's joins, listed and pinned**: the pairs of its claims whose
meanings exclude or entail one another, written out for a reader, with the proof
that they are exactly what the meanings contain. A meaning added tomorrow that
joins two claims fails the proof until its pair is listed, so a change in what
the logic holds is a change a reviewer sees.

Every argument has one, if only with empty lists (`Testimony.Checks.Meanings`).
The lists are what the kernel reads: the proofs are checked once, here, and
every check over the atoms then holds literal lists rather than recomputing
them.

**Not a join: two senses of one word.** Two claims that read the same word in
different senses at one place are not held to exclude each other. Whether the
senses exclude each other is itself contested — Trent holds that justification
both declares and makes righteous — so a postulate saying they do would hand
one side's lexicon to both. A claim whose meaning says *and not that sense*
excludes the other; that is a join, and it is listed. -/
class HasJoins (α : Type) [HasMeanings α] [DecidableEq α] where
  /-- Each pair `(a, b)`, `a` listed first: the two meanings cannot both be
  held. -/
  exclusions : List (α × α)
  /-- No more, no fewer than the meanings contain. -/
  exclusions_pinned : exclusions = HasMeanings.exclusions (α := α)
  /-- Each pair `(a, b)`: the meaning of `a` asserts all the meaning of `b`
  does. -/
  entailments : List (α × α)
  /-- No more, no fewer than the meanings contain. -/
  entailments_pinned : entailments = HasMeanings.entailments (α := α)

namespace HasJoins

variable {α : Type} [HasMeanings α] [DecidableEq α]

/-- The postulate for one exclusion `(a, b)`: `a → ¬b`. -/
def exclusion (e : α × α) : Formula α :=
  .imp (.atom e.1) (.imp (.atom e.2) .falsum)

/-- The postulate for one entailment `(a, b)`: `a → b`. -/
def entailment (e : α × α) : Formula α :=
  .imp (.atom e.1) (.atom e.2)

/-- **The only source of an argument's postulates**: `a → ¬b` for each pinned
exclusion, and `a → b` for each pinned entailment. `Testimony.Checks.Meanings`
fails the build for an argument whose `HasPostulates` instance is any other. -/
instance toHasPostulates [HasJoins α] : HasPostulates α where
  postulates :=
    (exclusions (α := α)).map exclusion ++ (entailments (α := α)).map entailment

end HasJoins

end Testimony.Semantics
