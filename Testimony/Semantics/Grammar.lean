import Testimony.Semantics.Vocabulary
import Testimony.Semantics.Upper
import Testimony.Corpus.Greek

/-!
# Testimony.Semantics.Grammar — what a claim says, as a term

**A draft.** Nothing in the solver reads this module, and no result depends on
it.

Every argument names its atomic claims in an `inductive Claim` of its own, and
says what each one asserts in a docstring. The docstring is for a reader; to the
library, `dikaioIsForensic` and `romans3_28` are two opaque names. So the
library cannot answer questions a reader asks of the whole collection — *every
claim made about δικαιόω*, *every passage read two ways*, *the same claim made in
two arguments* — and it cannot see what an article does when it moves from one
passage to another under a single word.

This module gives a claim a **meaning**: a term built from a small, fixed
vocabulary. It does not replace the atoms. An argument keeps its `Claim` type,
and its proofs are untouched; a separate total function, `Claim.means`, says
what each atom asserts in the vocabulary below, as `cite` says who asserts it.

## Two levels: the word, and what it means

The vocabulary keeps apart what a text *says* and what its words *mean*. A
textual claim is stated with the words as they stand — `Term.word` — and a
claim about a word's sense is a separate statement, `Statement.means`. Romans
3:28 says that a person is *justified* by *faith* apart from *works of the law*;
what those three words denote in Paul is a further claim, and each is one the
library already disputes.

That separation is the point. Two passages contradict each other only if their
words are taken in the same senses, and an argument that sets one passage
against another is an argument about senses, whether it says so or not
(`Testimony.Semantics.Discourse`). James Barr's warning against confusing the
word with the concept is the same distinction, and the sola fide argument
already turns on it (`whatTrentsDefinitionClaims`).

## Built from a shared vocabulary

The words, senses, concepts and relations are in
`Testimony.Semantics.Vocabulary`, one for the whole library. This module says
how they combine into a statement, and asks questions of statements that do not
depend on which argument they come from.
-/

namespace Testimony.Semantics

open Testimony

/-- Where a word is used: one passage, one passage of a voice's own text, or an
author's usage as a whole. -/
inductive Scope
  /-- One passage. -/
  | passage (p : PassageRange)
  /-- An author's or tradition's usage as a whole. -/
  | usage (v : Voice)
  /-- One passage of a voice's own text: the Septuagint's Leviticus 21:13, as
  against the Hebrew's. What a word means here, it means somewhere in the
  voice's usage (`Testimony.Ontology.Usage`). -/
  | passageOf (v : Voice) (p : PassageRange)
deriving DecidableEq, Repr

/-- Whether the scope is one passage of a voice's own text. -/
def Scope.isPassageOf : Scope → Bool
  | .passageOf .. => true
  | _ => false

/-- **Whether one place lies within another**: a passage within a passage, as
`PassageRange.within` reads them, and a passage of a voice's text within a
passage of the same voice's text. A voice's usage lies only within itself. What
a premise says of a word throughout a place, it says at every place within it. -/
def Scope.within : Scope → Scope → Bool
  | .passage p, .passage q => p.within q
  | .passageOf v p, .passageOf v' q => v == v' && p.within q
  | .usage v, .usage v' => v == v'
  | _, _ => false

/-- **Whether two places share any of the text**: two passages, or two passages
of one voice's text, that overlap; a voice's usage overlaps only itself. -/
def Scope.overlaps : Scope → Scope → Bool
  | .passage p, .passage q => p.overlaps q
  | .passageOf v p, .passageOf v' q => v == v' && p.overlaps q
  | .usage v, .usage v' => v == v'
  | _, _ => false

/-- What a slot in a relation holds: a concept, a word as it is used somewhere
(whose sense is left to a separate `Statement.means`), or a particular — one
thing or occurrence, named and of a stated kind. -/
inductive Term
  /-- A concept, named directly. -/
  | concept (c : Concept)
  /-- A word as it stands in its text. -/
  | word (w : Lexeme) (at_ : Scope)
  /-- A particular: one thing, or one occurrence, that a claim is about — the
  time between a man's entering a store and a shot, a witness's breakfast —
  named, and of the kind its category says (`Testimony.Semantics.Upper`). The
  vocabulary's concepts are kinds; a case's evidence is about particulars. -/
  | particular (name : String) (kind : Category)
deriving DecidableEq, Repr

/-- A doctrinal content: a relation between two terms, or a combination of
contents. -/
inductive Content
  /-- `a` stands in relation `r` to `b`. -/
  | rel (r : Rel) (a b : Term)
  /-- Not this content. -/
  | not (c : Content)
  /-- Both contents. -/
  | both (c d : Content)
deriving DecidableEq, Repr

/-- **What one atomic claim asserts**, in the vocabulary above. -/
inductive Statement
  /-- A passage says this, in its own words. Textual: what the text asserts,
  not what its words are taken to mean. -/
  | says (p : PassageRange) (c : Content)
  /-- A passage, read rightly, teaches this. Interpretive: a reading of the
  text, which a rival may read otherwise. Never the same claim as `says`. -/
  | teaches (p : PassageRange) (c : Content)
  /-- A word, used in this scope, has this sense. Linguistic. -/
  | means (w : Lexeme) (sc : Scope) (s : Sense)
  /-- A word has the same sense in both scopes. Linguistic, and the claim on
  which every contradiction between two texts using the word depends. -/
  | sameSense (w : Lexeme) (a b : Scope)
  /-- **The first word, at the first place, bears the sense the second word has at
  the second**: what an argument needs when it reads one word by a kindred one,
  a verb by its adjective or the Greek by the Latin (`Lexeme.kin`). Linguistic. -/
  | bears (w : Lexeme) (a : Scope) (v : Lexeme) (b : Scope)
  /-- A passage is written against this content. -/
  | opposes (p : PassageRange) (c : Content)
  /-- This voice wrote this book. Historical. -/
  | wrote (v : Voice) (b : Book)
  /-- This voice read a word in this sense. Historical: a claim about the
  reader, not about the word. -/
  | glosses (v : Voice) (w : Lexeme) (s : Sense)
  /-- This voice's translation of the passage has this word. Textual, about a
  translation. -/
  | renders (v : Voice) (p : PassageRange) (w : Lexeme)
  /-- This voice held this content. Historical. -/
  | heldBy (v : Voice) (c : Content)
  /-- This content is so. Doctrinal: the claim itself, whoever holds it. -/
  | holds (c : Content)
  /-- A principle of reading. -/
  | principle (h : Principle)
  /-- This word occurs in this passage. Textual, and decidable from the text. -/
  | occurs (w : Lexeme) (p : PassageRange)
  /-- **This word of the Greek, where it stands, is in this voice.** Textual: a
  claim about the text's grammar, which the parsing of the Greek data bears out
  or contradicts (`Statement.misreads`). The word is read from the data by
  `greek_word`, so it is the text's word, at its place. -/
  | parses (w : Lexeme) (t : Testimony.Corpus.Greek.Token)
      (v : Testimony.Corpus.Greek.GreekVoice)
  /-- **The one at work in this word of the Greek, where it stands, is what the
  Greek word `agent` names**: its subject, were the verb active, and what works
  on its subject, were it passive. Interpretive: a reading of who or what does
  the work, which the author's use of the verb elsewhere bears out or does not
  (`Statement.againstUsage`). -/
  | worksBy (w : Lexeme) (t : Testimony.Corpus.Greek.Token) (agent : String)
  /-- This word occurs in this passage and nowhere else in the New Testament.
  -/
  | occursOnlyIn (w : Lexeme) (p : PassageRange)
  /-- **An expectation**: were the first statement so, the second would be — had
  Paul taught it, the word would be in Romans 3:28. Kept whole, as a frame is,
  because it is a claim about what a text or a writer would have done, not a
  rule the reasoner applies. It is the premise an argument from silence needs
  and seldom states (`Testimony.Semantics.Fallacy`). -/
  | expects (s t : Statement)
  /-- Not this statement. -/
  | denied (s : Statement)
  /-- Both statements. -/
  | also (s t : Statement)
  /-- Not yet analysed. The label is the atom's docstring in brief. -/
  | opaque (label : String)
deriving DecidableEq, Repr

namespace Content

/-- The words a content uses, with where each is used. -/
def words : Content → List (Lexeme × Scope)
  | .rel _ a b =>
    (match a with | .word w sc => [(w, sc)] | _ => []) ++
    (match b with | .word w sc => [(w, sc)] | _ => [])
  | .not c => c.words
  | .both c d => c.words ++ d.words

end Content

namespace Statement

/-- Whether the statement is still unanalysed. -/
def isOpaque : Statement → Bool
  | .opaque _ => true
  | _ => false

/-- The words a statement turns on, with where each is used. -/
def words : Statement → List (Lexeme × Scope)
  | .says _ c | .teaches _ c | .opposes _ c | .heldBy _ c | .holds c => c.words
  | .means w sc _ => [(w, sc)]
  | .sameSense w a b => [(w, a), (w, b)]
  | .bears w a v b => [(w, a), (v, b)]
  | .renders v p w => [(w, .usage v), (w, .passage p)]
  | .glosses v w _ => [(w, .usage v)]
  | .occurs w p | .occursOnlyIn w p => [(w, .passage p)]
  | .parses w t _ | .worksBy w t _ => [(w, .passage t.verseOf)]
  | .denied s => s.words
  | .also s t | .expects s t => s.words ++ t.words
  | .wrote .. | .principle _ | .opaque _ => []

/-- **Whether a statement misreads the Greek**: it says a word stands in a voice
its spelling rules out, or denies it the only voice its spelling allows
(`Testimony.Corpus.Greek.Token.formVoices`). Where the spelling allows two
voices, as a present middle or passive does, the letters settle nothing between
them: the editors' parsing is a reading of how the word is used, as a
commentator's is, and the question between the two is argued from the passage
and its author's usage, not charged here. A word whose voice the spelling leaves
unknown is misread by neither reading. Read through conjunctions; a statement
about anything else misreads nothing. -/
def misreads : Statement → Bool
  | .parses _ t v => !t.formVoices.isEmpty && !t.formVoices.contains v
  | .denied (.parses _ t v) => t.formVoices == [v]
  | .also s t => s.misreads || t.misreads
  | _ => false

/-- **Where a statement reads a word against its author's usage**: each part of it
that names as
the one at work in a verb something the author never names as at work in that
verb, wherever the spelling of another use makes it active and the text says
who works (`Testimony.Corpus.Greek.agentsNamed`). A reading of a word with no
such use, or whose usage the library has not read, is against nothing. Read
through conjunctions; a statement about anything else is against nothing. -/
def unusualWorkers : Statement → List Statement
  | .worksBy w t a =>
    let named := Testimony.Corpus.Greek.agentsNamed t.usage
    if !named.isEmpty && !named.contains a then [.worksBy w t a] else []
  | .also s t => s.unusualWorkers ++ t.unusualWorkers
  | _ => []

/-- Whether a statement names any such worker (`Statement.unusualWorkers`). -/
def againstUsage (s : Statement) : Bool := !s.unusualWorkers.isEmpty

/-- The lexemes a statement turns on. -/
def lexemes (s : Statement) : List Lexeme := s.words.map Prod.fst

/-- Whether the statement turns on this word. -/
def mentions (s : Statement) (w : Lexeme) : Bool := s.lexemes.contains w

/-- The senses a statement asserts words to have, where it asserts them: through
`also`, and not under `denied`. -/
def senses : Statement → List (Lexeme × Scope × Sense)
  | .means w sc s => [(w, sc, s)]
  | .also s t => s.senses ++ t.senses
  | _ => []

end Statement

/-- Every pair of different senses that a list of statements gives the same word
at the same scope: where the claims, taken together, read one word two ways. A
reading of a passage contested in the library shows up here; so does an
argument that slides between two of them. -/
def readTwoWays (ss : List Statement) : List (Lexeme × Scope × Sense × Sense) :=
  let senses := ss.flatMap Statement.senses
  senses.flatMap fun (w, sc, s) =>
    senses.filterMap fun (w', sc', s') =>
      if w = w' ∧ sc = sc' ∧ s ≠ s' then some (w, sc, s, s') else none

namespace Statement

/-- Whether the statement denies that a word has the same sense at two places,
in either order, on its own or as part of a conjunction. -/
def deniesSameSense (w : Lexeme) (a b : Scope) : Statement → Bool
  | .denied (.sameSense w' a' b') =>
    w == w' && ((a == a' && b == b') || (a == b' && b == a'))
  | .also s t => s.deniesSameSense w a b || t.deniesSameSense w a b
  | _ => false

end Statement

/-! ### Notation for writing meanings

Short names for the forms every meaning uses. Opened where meanings are written,
so they do not leak into the rest of the library. -/

namespace Notation

/-- One verse. -/
abbrev vs (b : Book) (c n : Nat) : PassageRange := .verse ⟨b, c, n⟩

/-- A range of verses. -/
abbrev rg (b : Book) (c₁ n₁ c₂ n₂ : Nat) : PassageRange := .range ⟨b, c₁, n₁, c₂, n₂⟩

/-- A word as it stands in a passage. -/
abbrev wd (w : Lexeme) (p : PassageRange) : Term := .word w (.passage p)

/-- A word as an author or tradition uses it. -/
abbrev wu (w : Lexeme) (v : Voice) : Term := .word w (.usage v)

/-- A concept. -/
abbrev cn (c : Concept) : Term := .concept c

/-- A particular, of a stated kind. -/
abbrev pt (name : String) (kind : Category) : Term := .particular name kind

/-- A relation between two terms. -/
abbrev rl (r : Rel) (a b : Term) : Content := .rel r a b

end Notation

end Testimony.Semantics
