import Testimony.Semantics.Grammar
import Testimony.Provenance

/-!
# Testimony.Semantics.Ontology — what a meaning commits its reader to

A meaning is a term in the shared vocabulary. Two meanings join — one excludes
or entails the other — when a reader who holds the one is thereby bound to deny,
or to hold, the other. That is a question about what the words commit their
reader to, and the words are the vocabulary's. So the joins are not looked for
in the shape of the terms alone; they are derived, from each meaning's parts
and from **definitions**: what the vocabulary's own words mean.

## A meaning, taken apart

A meaning is read as its **shape**: the facts it affirms or denies, each a
**literal**, and the combinations it denies without denying any one part, each a
**nogood** — "not both of these". "Justification includes the remission of
sins, and not sanctification" is two literals, one of them denied. "Galatians
2:21 does not say both that the law and that Christ's death justify" is one
literal, because what a passage says is kept whole.

Only doctrine is taken apart: what is held to be so (`Statement.holds`). A
denied doctrine is the doctrine's denial — "it is not so that works merit" and
"works do not merit" are one claim. What a passage says, what it teaches when
read rightly, what it is written against and what a voice held are kept whole
inside their frame, and only split at "and". A passage that says "not A" has
not thereby failed to say A; a voice that held two things that cannot both be
so may still have held both. Those frames are claims about texts and readers,
and the definitions below are claims about what doctrine's words mean.

## What a definition can say

Each definition is one of six forms, and each comes with a `Source`, as a
premise does:

- **implies** — whatever stands in the one relation stands in the other.
- **denies** — standing in the one relation is not standing in the other.
- **only** — the one relation is the other, and nothing else stands in it to
  the same thing: what is the *only* means of a thing is a means of it, and
  nothing else is.
- **functional** — a thing stands in the relation to one thing only: an
  occurrence lasts one length of time.
- **in a usage** — a sense a word has in one passage of a voice's text is a
  sense it has in that voice's usage.
- **the same sense, both ways** — a word with the same sense at one place as
  at another has the same sense at the other as at the first.

The first four are about relation words; the last two, about senses: what "a
usage as a whole" means, and what "the same sense" means.

The definitions themselves are written in the articles of `Testimony.Ontology`,
each with the search that found where it bears and what follows from it. This
module only says how they are read.

## The reasoning

A meaning's literals are **closed** under the definitions — every literal a
definition yields from one already there is added, until none is new — and a
closed set **clashes** when it affirms and denies one fact, holds two different
things to be the only one, relates one thing to two in a relation that allows
one, or contains every part of one of its nogoods. Every
rule yields from one literal at a time, so the closure of two meanings together
is the two closures side by side, and a clash between them is found by looking
across. Two meanings **exclude** each other when each is coherent alone and the
two together clash; one **entails** another when its closure contains every
literal of the other, and every nogood.
-/

namespace Testimony.Semantics

/-- Where a content is asserted, when it is not simply held to be so: kept
whole, because the frame is a claim about a text or a reader. -/
inductive Frame
  /-- What a passage says, in its own words. -/
  | says (p : PassageRange)
  /-- What a passage, read rightly, teaches. -/
  | teaches (p : PassageRange)
  /-- What a passage is written against. -/
  | opposes (p : PassageRange)
  /-- What a voice held. -/
  | heldBy (v : Voice)
deriving DecidableEq, Repr

/-- One thing a meaning can assert, before it is affirmed or denied. -/
inductive Fact
  /-- A relation, held to be so. The facts the definitions are about. -/
  | rel (r : Rel) (a b : Term)
  /-- A content inside a frame, kept whole. -/
  | within (f : Frame) (c : Content)
  /-- A word, used in this scope, has this sense. -/
  | means (w : Lexeme) (sc : Scope) (s : Sense)
  /-- A word has the same sense in both scopes. -/
  | sameSense (w : Lexeme) (a b : Scope)
  /-- This voice wrote this book. -/
  | wrote (v : Voice) (b : Book)
  /-- This voice read a word in this sense. -/
  | glosses (v : Voice) (w : Lexeme) (s : Sense)
  /-- This voice's translation of the passage has this word. -/
  | renders (v : Voice) (p : PassageRange) (w : Lexeme)
  /-- A principle of reading. -/
  | principle (h : Principle)
  /-- This word occurs in this passage. -/
  | occurs (w : Lexeme) (p : PassageRange)
  /-- This word occurs in this passage and nowhere else in the New Testament. -/
  | occursOnlyIn (w : Lexeme) (p : PassageRange)
  /-- Were the first statement so, the second would be: kept whole. -/
  | expects (s t : Statement)
deriving DecidableEq, Repr

/-- A fact, affirmed or denied. -/
structure Lit where
  /-- Whether the fact is affirmed. -/
  pos : Bool
  /-- The fact. -/
  fact : Fact
deriving DecidableEq, Repr

/-- The same fact, with the other sign. -/
def Lit.neg (l : Lit) : Lit := { l with pos := !l.pos }

/-- **What a meaning asserts, as the reasoner reads it**: the literals it
affirms, the combinations of literals it denies without denying any one, and
whether it could be read at all. A meaning with an unanalysed part, or a denial
the reasoner cannot take apart, is not read, and joins nothing. -/
structure Shape where
  /-- The literals the meaning asserts. -/
  lits : List Lit
  /-- Each a set of literals the meaning denies jointly: not all of these. -/
  nogoods : List (List Lit)
  /-- Whether every part of the meaning could be read. -/
  read : Bool
deriving DecidableEq, Repr

namespace Shape

/-- A meaning the reasoner cannot read. -/
def unread : Shape := ⟨[], [], false⟩

/-- One literal, asserted. -/
def lit (l : Lit) : Shape := ⟨[l], [], true⟩

/-- Both meanings, asserted together. -/
def union (s t : Shape) : Shape := ⟨s.lits ++ t.lits, s.nogoods ++ t.nogoods, s.read && t.read⟩

/-- **The denial of a meaning.** One literal denied is its negation; several
denied together are a nogood. The denial of something that is itself a denial
of a combination would be a disjunction of what it combines, and the reasoner
does not read it. -/
def deny (s : Shape) : Shape :=
  if s.read && s.nogoods.isEmpty then
    match s.lits with
    | [] => unread
    | [l] => lit l.neg
    | ls => ⟨[], [ls], true⟩
  else unread

end Shape

namespace Content

/-- A content held to be so, taken apart: "not" is its denial, "and" both. -/
def held : Content → Shape
  | .rel r a b => .lit ⟨true, .rel r a b⟩
  | .not c => c.held.deny
  | .both c d => c.held.union d.held

/-- A content inside a frame, split only at "and". -/
def within (f : Frame) : Content → Shape
  | .both c d => (c.within f).union (d.within f)
  | c => .lit ⟨true, .within f c⟩

end Content

/-- **A meaning's shape**: what it affirms and denies, literal by literal. -/
def Statement.shape : Statement → Shape
  | .holds c => c.held
  | .says p c => c.within (.says p)
  | .teaches p c => c.within (.teaches p)
  | .opposes p c => c.within (.opposes p)
  | .heldBy v c => c.within (.heldBy v)
  | .means w sc s => .lit ⟨true, .means w sc s⟩
  | .sameSense w a b => .lit ⟨true, .sameSense w a b⟩
  | .wrote v b => .lit ⟨true, .wrote v b⟩
  | .glosses v w s => .lit ⟨true, .glosses v w s⟩
  | .renders v p w => .lit ⟨true, .renders v p w⟩
  | .principle h => .lit ⟨true, .principle h⟩
  | .occurs w p => .lit ⟨true, .occurs w p⟩
  | .occursOnlyIn w p => .lit ⟨true, .occursOnlyIn w p⟩
  | .expects s t => .lit ⟨true, .expects s t⟩
  | .denied s => s.shape.deny
  | .also s t => s.shape.union t.shape
  | .opaque _ => .unread

/-- The forms a definition takes. -/
inductive Axiom
  /-- Whatever stands in the first relation stands in the second. -/
  | implies (r s : Rel)
  /-- Standing in the first relation is not standing in the second, and not
  standing in the first is standing in the second. -/
  | denies (r s : Rel)
  /-- The first relation is the second, and nothing else stands in the second
  to the same thing. -/
  | only (r s : Rel)
  /-- A thing stands in the relation to one thing only: an occurrence lasts one
  length of time. -/
  | functional (r : Rel)
  /-- A sense a word has in one passage of a voice's text is a sense it has in
  that voice's usage. Not the converse: a word with two senses in a usage need
  not have both in every passage. -/
  | inUsage
  /-- A word that has the same sense at one place as at another has the same
  sense at the other as at the first: sameness of sense runs both ways. -/
  | sameSenseBothWays
deriving DecidableEq, Repr

/-- **A definition**: what one of the vocabulary's words commits its reader to,
in a form the reasoner reads, with who says so. -/
structure Definition where
  /-- A short name, for reports: "the only means". -/
  name : String
  /-- What the definition says, in words. -/
  says : String
  /-- The definition, as the reasoner reads it. -/
  form : Axiom
  /-- Who says so, where, and with what confidence. -/
  source : Source

/-- An ontology: the definitions every check over meanings holds. -/
abbrev Ontology := List Definition

namespace Axiom

/-- The literals one definition yields from one literal: the relation it
implies, or denies, and the contrapositive of each; and, for a usage, the sense
a passage of its text gives the word. -/
def yields : Axiom → Lit → List Lit
  | .implies r s, ⟨true, .rel r' a b⟩ | .only r s, ⟨true, .rel r' a b⟩ =>
    if r' = r then [⟨true, .rel s a b⟩] else []
  | .implies r s, ⟨false, .rel s' a b⟩ | .only r s, ⟨false, .rel s' a b⟩ =>
    if s' = s then [⟨false, .rel r a b⟩] else []
  | .denies r s, ⟨pos, .rel r' a b⟩ =>
    (if r' = r then [⟨!pos, .rel s a b⟩] else []) ++
      (if r' = s then [⟨!pos, .rel r a b⟩] else [])
  | .inUsage, ⟨true, .means w (.passageOf v _) s⟩ => [⟨true, .means w (.usage v) s⟩]
  | .sameSenseBothWays, ⟨pos, .sameSense w a b⟩ => [⟨pos, .sameSense w b a⟩]
  | _, _ => []

/-- The relations a definition is about: none, for one about a usage. -/
def rels : Axiom → List Rel
  | .implies r s | .denies r s | .only r s => [r, s]
  | .functional r => [r]
  | .inUsage | .sameSenseBothWays => []

/-- Whether two literals clash under one definition: for **only**, two
different things each standing in the relation to the same thing, one of them
as the only one. -/
def clashes : Axiom → Lit → Lit → Bool
  | .only r s, ⟨true, .rel r' a b⟩, ⟨true, .rel s' c d⟩ => r' == r && s' == s && b == d && a != c
  | .functional r, ⟨true, .rel r' a b⟩, ⟨true, .rel r'' c d⟩ =>
    r' == r && r'' == r && a == c && b != d
  | _, _, _ => false

end Axiom

namespace Ontology

/-- One round: every literal the definitions yield from the ones there. -/
def step (O : Ontology) (ls : List Lit) : List Lit :=
  ls.foldl (fun acc l =>
    (O.flatMap fun d => d.form.yields l).foldl
      (fun acc' m => if acc'.contains m then acc' else acc' ++ [m]) acc) ls

/-- **The closure of a set of literals**: rounds until nothing is new. A chain
of definitions is never longer than the ontology, so as many rounds as there
are definitions, and one more, reach the fixed point. -/
def close (O : Ontology) (ls : List Lit) : List Lit :=
  (List.range (O.length + 1)).foldl (fun acc _ => step O acc) ls

/-- **Whether a closed set of literals clashes**: one fact affirmed and denied;
two things each held to be the only one; one thing related to two, in a relation
that allows one; or every part of a nogood asserted. -/
def clash (O : Ontology) (ls : List Lit) (nogoods : List (List Lit)) : Bool :=
  ls.any (fun l => ls.contains l.neg) ||
    ls.any (fun l => ls.any fun m => O.any fun d => d.form.clashes l m) ||
    nogoods.any fun n => n.all ls.contains

/-- A meaning's shape, closed under the ontology. -/
def closed (O : Ontology) (s : Statement) : Shape :=
  let sh := s.shape
  { sh with lits := close O sh.lits }

/-- Whether a closed shape is read and coherent. -/
def coherent (O : Ontology) (s : Shape) : Bool := s.read && !clash O s.lits s.nogoods

/-- **Two meanings exclude each other** when each is coherent alone, and not
both can be held. -/
def excludes (O : Ontology) (s t : Shape) : Bool :=
  coherent O s && coherent O t && clash O (s.lits ++ t.lits) (s.nogoods ++ t.nogoods)

/-- **Whether two meanings exclude each other** under an ontology: each closed
under its definitions, each coherent alone, and the two clashing together. -/
def excludeEachOther (O : Ontology) (s t : Statement) : Bool :=
  excludes O (closed O s) (closed O t)

/-- **One meaning entails another** when it is coherent, and asserts, read
for what its words mean, every literal of the other and every nogood. -/
def entails (O : Ontology) (s t : Shape) : Bool :=
  coherent O s && t.read && t.lits.all s.lits.contains && t.nogoods.all s.nogoods.contains

/-! ### Where two meanings can meet

Two meanings can clash only where they touch. A literal meets its negation in
the same fact; a definition's rule (**only**, **functional**) relates two facts
about the same thing; a nogood is completed by the other meaning's literal.
So a meaning's **keys** are the facts of its literals and nogoods, and the
things its relations are about, and two coherent meanings that share no key
cannot clash (`shares_of_clash`). A claim is then checked only against the
claims it shares a key with, found through an index of keys, rather than
against every claim (`Testimony.Semantics.HasMeanings.exclusionsUnder`). -/

/-- Where a meaning can meet another: a fact, or a thing a relation is about. -/
inductive Key
  /-- A fact a literal affirms or denies. -/
  | fact (f : Fact)
  /-- A thing a relation is about. -/
  | term (t : Term)
deriving DecidableEq

/-- The keys of one fact: itself, and the things it relates, if a relation. -/
def factKeys : Fact → List Key
  | f@(.rel _ a b) => [.fact f, .term a, .term b]
  | f => [.fact f]

/-- **The keys of a meaning**: those of every fact it affirms or denies, and of
every fact in its nogoods. -/
def keysOf (s : Shape) : List Key :=
  s.lits.flatMap (fun l => factKeys l.fact) ++ s.nogoods.flatMap (·.map fun l => Key.fact l.fact)

theorem fact_mem_factKeys (f : Fact) : Key.fact f ∈ factKeys f := by
  cases f <;> simp [factKeys]

theorem mem_keysOf_of_lit {s : Shape} {l : Lit} {k : Key} (hl : l ∈ s.lits)
    (hk : k ∈ factKeys l.fact) : k ∈ keysOf s := by
  simp only [keysOf, List.mem_append, List.mem_flatMap]
  exact .inl ⟨l, hl, hk⟩

theorem mem_keysOf_of_nogood {s : Shape} {n : List Lit} {x : Lit} (hn : n ∈ s.nogoods)
    (hx : x ∈ n) : Key.fact x.fact ∈ keysOf s := by
  simp only [keysOf, List.mem_append, List.mem_flatMap, List.mem_map]
  exact .inr ⟨n, hn, x, hx, rfl⟩

/-- A definition's rule makes two literals clash only when their relations are
about one same thing. -/
theorem shares_of_clashes {a : Axiom} {l m : Lit} (h : a.clashes l m = true) :
    ∃ t, Key.term t ∈ factKeys l.fact ∧ Key.term t ∈ factKeys m.fact := by
  unfold Axiom.clashes at h
  split at h
  · rename_i _ _ _ _ b _ _ d
    simp only [Bool.and_eq_true, beq_iff_eq, bne_iff_ne, ne_eq] at h
    obtain ⟨⟨⟨-, -⟩, hbd⟩, -⟩ := h
    exact ⟨b, by simp [factKeys], by simp [factKeys, hbd]⟩
  · rename_i _ _ a _ _ c _
    simp only [Bool.and_eq_true, beq_iff_eq, bne_iff_ne, ne_eq] at h
    obtain ⟨⟨⟨-, -⟩, hac⟩, -⟩ := h
    exact ⟨a, by simp [factKeys], by simp [factKeys, hac]⟩
  · simp at h

/-- **Two coherent meanings that clash share a key.** A clash between them is
a literal and its negation, two literals a rule sets against each other, or a
nogood of one completed by the other; none of these is inside one meaning alone,
since each is coherent, so each joins the two, at a fact or at a thing their
relations are about. -/
theorem shares_of_clash {O : Ontology} {s t : Shape} (hs : clash O s.lits s.nogoods = false)
    (ht : clash O t.lits t.nogoods = false)
    (h : clash O (s.lits ++ t.lits) (s.nogoods ++ t.nogoods) = true) :
    ∃ k ∈ keysOf s, k ∈ keysOf t := by
  simp only [clash, Bool.or_eq_false_iff, Bool.or_eq_true, List.any_eq_false, List.any_eq_true,
    List.all_eq_true, List.contains_iff_mem, List.mem_append, Bool.not_eq_true] at hs ht h
  obtain ⟨⟨hs₁, hs₂⟩, hs₃⟩ := hs
  obtain ⟨⟨ht₁, ht₂⟩, ht₃⟩ := ht
  rcases h with (⟨l, hl, hn⟩ | ⟨l, hl, m, hm, d, hd, hc⟩) | ⟨n, hn, hall⟩
  · -- a literal and its negation
    rcases hl with hl | hl <;> rcases hn with hn | hn
    · exact absurd (by simpa using hn) (hs₁ l hl)
    · exact ⟨_, mem_keysOf_of_lit hl (fact_mem_factKeys _),
        mem_keysOf_of_lit hn (fact_mem_factKeys _)⟩
    · exact ⟨_, mem_keysOf_of_lit hn (fact_mem_factKeys _),
        mem_keysOf_of_lit hl (fact_mem_factKeys _)⟩
    · exact absurd (by simpa using hn) (ht₁ l hl)
  · -- a rule setting two literals against each other
    obtain ⟨u, hu₁, hu₂⟩ := shares_of_clashes hc
    rcases hl with hl | hl <;> rcases hm with hm | hm
    · exact absurd ⟨m, hm, d, hd, hc⟩ (hs₂ l hl)
    · exact ⟨_, mem_keysOf_of_lit hl hu₁, mem_keysOf_of_lit hm hu₂⟩
    · exact ⟨_, mem_keysOf_of_lit hm hu₂, mem_keysOf_of_lit hl hu₁⟩
    · exact absurd ⟨m, hm, d, hd, hc⟩ (ht₂ l hl)
  · -- a nogood completed across the two
    rcases hn with hn | hn
    · obtain ⟨x, hx, hxs⟩ : ∃ x ∈ n, x ∉ s.lits :=
        Classical.byContradiction fun hno =>
          hs₃ n hn fun x hx => Classical.byContradiction fun hxs => hno ⟨x, hx, hxs⟩
      have hxt : x ∈ t.lits := (hall x hx).resolve_left hxs
      exact ⟨_, mem_keysOf_of_nogood hn hx, mem_keysOf_of_lit hxt (fact_mem_factKeys _)⟩
    · obtain ⟨x, hx, hxt⟩ : ∃ x ∈ n, x ∉ t.lits :=
        Classical.byContradiction fun hno =>
          ht₃ n hn fun x hx => Classical.byContradiction fun hxt => hno ⟨x, hx, hxt⟩
      have hxs : x ∈ s.lits := (hall x hx).resolve_right hxt
      exact ⟨_, mem_keysOf_of_lit hxs (fact_mem_factKeys _), mem_keysOf_of_nogood hn hx⟩

end Ontology

end Testimony.Semantics
