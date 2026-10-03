import Testimony.Logic.Package

/-!
# Testimony.Logic.Warrant — what a premise finally rests on

Every premise in the library is cited, but a citation can carry very different
weight. "James 2:24 says this" rests on the text. "δικαιόω is declarative" rests
on evidence anyone can check — the lexicon, the uses of the word. "Good works
are a cause of the increase of justification" rests, in the library's citation,
on the Council of Trent's word: it binds those who receive the council, and to
everyone else it is what the council teaches. And a claim the library proposes
itself rests on nothing but the library's say-so, which is why it is marked.

A premise's **warrant** is the best of what its references are:

- **Scripture**, if it cites a text of Scripture;
- **evidence**, if it cites a critical text, a lexicon, or argued scholarship;
- **authority**, if every reference is a council's, a confession's or a
  theologian's own word (`Bib.Role.authority`, `Bib.Role.witness`);
- **assertion**, if it is the library's own proposal and nothing else.

A claim *about* what someone holds is the exception: a historical claim that
Westminster says faith is "no dead faith" is proved by Westminster's text, and
its warrant is evidence, whatever kind of work is cited for it.

## What it is for, and what it does not do

It answers a reader's question about any position: *where does this rest on
someone's word alone?* `ArgumentPackage.restingOnAuthority` lists those
premises. An appeal to authority is not thereby false, and a reader who
receives the authority is entitled to it; but a reader who does not is entitled
to see that the premise gives him nothing else.

**It does not weigh anything.** A rule that discounted authority inside the
solver — "Scripture first, by default" — would decide the sola scriptura dispute
by fiat, since whether a council's or a confession's word binds is exactly what
that dispute is about. The warrant is reported beside the verdicts, never mixed
into them. And it is applied to every side alike: the Reformed confessions are
authorities under it as Trent is.
-/

namespace Testimony.Logic

open Testimony Testimony.Bib

/-- What a premise finally rests on, best first. -/
inductive Warrant
  /-- A text of Scripture. -/
  | scripture
  /-- Evidence anyone can check, or argued scholarship. -/
  | evidence
  /-- A council's, a confession's or a theologian's own word, and nothing else. -/
  | authority
  /-- The library's own proposal, and nothing else. -/
  | assertion
deriving DecidableEq, Repr

/-- The rank of a warrant: lower is better. -/
def Warrant.rank : Warrant → Nat
  | .scripture => 0 | .evidence => 1 | .authority => 2 | .assertion => 3

/-- The better of two warrants. -/
def Warrant.best (a b : Warrant) : Warrant := if b.rank < a.rank then b else a

/-- What one reference is, as a warrant. -/
def _root_.Testimony.Reference.warrant : Reference → Warrant
  | .scripture _ => .scripture
  | .work e _ =>
    match e.core.role with
    | .text | .scholarship => .evidence
    | .authority | .witness => .authority
  | _ => .assertion

/-- What a source rests on: the best of its references. -/
def _root_.Testimony.Source.warrant (s : Source) : Warrant :=
  s.supporting.foldl (fun w r => w.best r.warrant) s.primary.warrant

/-- What a cited claim rests on. A claim about what someone holds or wrote is
proved by their own text, so it rests on evidence at worst. -/
def AtomMeta.warrant (m : AtomMeta) : Warrant :=
  match m.kind with
  | .historical => Warrant.best .evidence m.source.warrant
  | _ => m.source.warrant

namespace ArgumentPackage

variable {α : Type}

/-- The claims a package asserts outright: its premises that are atoms. -/
def assertedAtoms (pkg : ArgumentPackage α) : List α :=
  pkg.premises.filterMap fun
    | .atom a => some a
    | _ => none

/-- **Where a position rests on someone's word alone**: the claims it asserts
whose every citation is an authority's or a theologian's own word. -/
def restingOnAuthority (pkg : ArgumentPackage α) : List α :=
  pkg.assertedAtoms.filter fun a => (pkg.cite a).warrant == .authority

/-- The claims a position asserts on the library's say-so alone. -/
def restingOnAssertion (pkg : ArgumentPackage α) : List α :=
  pkg.assertedAtoms.filter fun a => (pkg.cite a).warrant == .assertion

end ArgumentPackage

end Testimony.Logic
