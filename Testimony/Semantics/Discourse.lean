import Testimony.Semantics.Meaning

/-!
# Testimony.Semantics.Discourse — what an article does, move by move

**A draft.** An article is not a package. It quotes, attributes, asserts and
infers, and it addresses a reader as it goes. To check one fairly is to check
each of those acts for what it is: a quotation against the text, an attribution
against what its subject holds, an inference against logic. An article is
modelled here as a list of **moves**, each with the words it uses, verbatim, and
the act those words perform, in the vocabulary of
`Testimony.Semantics.Grammar`.

## The check this module makes: what an inference assumes about words

Two texts conflict only if their words are taken in the same senses. So an
inference that sets one text against another — or a text against a doctrine —
assumes, for every word they share, that it means the same in both. Most
arguments never say so, and need not, when the senses are not in question. When
they are, the assumption is the argument.

`Move.assumes` computes those assumptions from the move alone: every word its
premises and conclusion use at different places. `Move.unstated` keeps the ones
the move neither asserts nor argues for. An inference with unstated assumptions
is not thereby fallacious; it is **conditional**, on exactly those senses. What
makes it an equivocation is a sense the move needs and the evidence denies, and
that is not a question about the article: it is the question of what the word
means, which the library's own disputes rate. So the check reports the
conditions, and the ratings report what holds them up.

## What it does not check

Whether a quotation is accurate, or an attribution fair, needs the text and the
position quoted, not only a grammar. Those are the next checks to build; the
design note `docs/src/semantics.md` says how.
-/

namespace Testimony.Semantics

/-- What a move in an article does. -/
inductive Act
  /-- The article asserts this, in its own voice. -/
  | asserts (s : Statement)
  /-- The article quotes a passage, and the quotation says this. -/
  | quotes (p : PassageRange) (s : Statement)
  /-- The article says that someone holds, or did, this. -/
  | attributes (v : Voice) (s : Statement)
  /-- The article infers its conclusion from its premises. -/
  | argues (premises : List Statement) (conclusion : Statement)
deriving Repr

/-- One move in an article: who makes it, the words that make it, verbatim, and
what it does. -/
structure Move where
  /-- Who speaks: the author, or a voice in a dialogue. -/
  speaker : String
  /-- The article's own words, quoted exactly. -/
  words : String
  /-- What the words do. -/
  act : Act
deriving Repr

namespace Move

/-- Each pair of places once, whichever order it was found in. -/
def pairsOnce (l : List (Lexeme × Scope × Scope)) : List (Lexeme × Scope × Scope) :=
  l.foldl (fun acc (w, a, b) =>
    if acc.contains (w, a, b) || acc.contains (w, b, a) then acc else acc ++ [(w, a, b)]) []

/-- Every pair of places at which a move's statements use one word, where the
two places differ: the senses the move assumes the same. -/
def assumes (m : Move) : List (Lexeme × Scope × Scope) :=
  match m.act with
  | .argues ps c =>
    let ws := (ps ++ [c]).flatMap Statement.words
    pairsOnce <| ws.flatMap fun (w, a) => ws.filterMap fun (w', b) =>
      if w = w' ∧ a ≠ b then some (w, a, b) else none
  | _ => []

/-- Whether a premise of the move grants that a word has the same sense at two
places. -/
def grants (m : Move) (w : Lexeme) (a b : Scope) : Bool :=
  match m.act with
  | .argues ps _ => ps.any fun s => s == .sameSense w a b || s == .sameSense w b a
  | _ => false

/-- The senses the move assumes the same and does not say so: the conditions on
which it holds, unstated. -/
def unstated (m : Move) : List (Lexeme × Scope × Scope) :=
  m.assumes.filter fun (w, a, b) => !m.grants w a b

/-- The words the move needs to mean the same at two places, unstated: one
entry per word, however many pairs of places. -/
def unstatedWords (m : Move) : List Lexeme := (m.unstated.map (·.1)).eraseDups

/-- The words a move needs to mean the same at two places, unstated, less the
one its conclusion is about: a move that concludes a word differs, or is the
same, at two places assumes nothing about that word. -/
def unstatedBesidesConclusion (m : Move) : List Lexeme :=
  match m.act with
  | .argues _ (.denied (.sameSense w _ _)) | .argues _ (.sameSense w _ _) =>
    m.unstatedWords.filter (· ≠ w)
  | _ => m.unstatedWords

/-- **Where a move meets an argument.** For each sense the move needs and does
not state, the argument's atoms that deny it. An empty list for a word is not
a verdict either way: the argument has nothing to say about that sense. -/
def meets {α : Type} [HasMeanings α] (m : Move) : List (Lexeme × List α) :=
  m.unstated.filterMap fun (w, a, b) =>
    match HasMeanings.denyingSameSense (α := α) w a b with
    | [] => none
    | cs => some (w, cs)

end Move

end Testimony.Semantics
