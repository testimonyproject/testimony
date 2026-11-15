import Testimony.Logic.Credibility
import Testimony.Semantics.Fallacy

/-!
# Testimony.Logic.Epistemology — how a side says we come to know, and whether it keeps to it

**A draft, phase one.** Many disputes over Scripture are disputes about how anything is known
from it, carried on as if they were disputes about a verse. Can a council's definition ground a
reading? Does Scripture interpret Scripture? Is the silence of a text evidence? A verdict that
quietly assumes one answer has settled the dispute before hearing it.

The library already keeps two of the pieces apart. A premise's **warrant**
(`Testimony.Logic.Warrant`) says what it finally rests on: a text of Scripture, evidence anyone
can check, a council's, a confession's or a theologian's own word, or the library's own
proposal. And a credibility check is run under three **standards** (`Standard`), each a rule
about which warrants a dissent's grounds may rest on. But a standard is not anyone's: it is not
cited, it is not held by a tradition, and it says nothing about how a text is to be read or
which kinds of inference count.

An **epistemology** is all of that, as one named value with a source, the way a premise has
one:

- the **warrants it admits** as grounds;
- whether a step resting on **Scripture alone** may be answered only from Scripture;
- the **principles of reading** it licenses (a word means no more than its context needs;
  Scripture does not contradict itself);
- how it takes an **argument from silence**: never, only with its expectation stated, or freely
  (`Testimony.Semantics.Fallacy`);
- who holds it, cited.

## What it lets the library ask

**Does each side keep its own rule?** A tradition professes an epistemology. A position argued
in that tradition is held to it: every claim it asserts must rest on what its own epistemology
admits. A position that asks its rival for Scripture and rests a step
on a confession's word alone has two rules, one for itself and one for the other side. That is
the charge of a double standard, made checkable (`ArgumentPackage.heldTo`).

Which epistemology a position professes is declared with the position, and argued there, not
computed. It cannot be read off the steps: a Reformed reading whose step is cited to a Catholic
exegete is still a Reformed reading, held to the Reformed rule.

**Which epistemologies does a position meet?** Every encoded epistemology, applied to one
position, says which would admit it (`ArgumentPackage.refusedBy`).

**Does a standard say what an epistemology says?** Each of the three standards the credibility
checks use is meant to be an epistemology someone holds. `Epistemology.agreesWith` says whether an
epistemology admits exactly what a standard admits, so a standard can be given its holder
without any result changing.

## Claims, not yet steps

A position's steps are cited too, but a step's citation records its rating, not what it rests
on: a step is rated `disputed` by citing the reader who grants its grounds and denies its
conclusion, so a Reformed step is often cited to Trent's anathema on it. A step's own warrant
cannot be read from that, so only claims are held to a rule here. Holding steps to one needs
each step to record what licenses it, apart from who disputes it.

## What it does not do

Nothing here decides which epistemology is right. That is what the sola scriptura dispute is
about, and an epistemology built into the solver would settle it by fiat. Every result stays
conditional: *under epistemology E, this position rests on what E admits*. Nor is a position
that fails its own rule thereby false. It is answerable, by its own lights, for the premise or
step it rests on another rule for.
-/

namespace Testimony.Logic

open Testimony.Semantics

variable {α : Type}

/-- **How an epistemology takes an argument from silence**: reasoning from what a text does not
say to the claim that something was not so. -/
inductive SilenceTerms
  /-- Never: a text's silence is no evidence. -/
  | refused
  /-- Only with its expectation stated: had it been so, the text would say it. -/
  | withExpectation
  /-- Freely, as evidence in itself. -/
  | accepted
deriving DecidableEq, Repr

/-- **An epistemology**: how a side holds that something is known from Scripture and the other
witnesses, as one value with who holds it. -/
structure Epistemology where
  /-- Its name, as a page shows it: "Scripture its own interpreter". -/
  name : String
  /-- What it holds, in a sentence a reader can follow. -/
  statement : String
  /-- The warrants it admits as grounds. -/
  admits : Warrant → Bool
  /-- Whose authority it admits, when it admits a council's, a confession's or a theologian's
  word: `none`, anyone's; `some t`, only authority advanced within the tradition `t` — Trent's
  councils and Fathers for the Catholic rule, not Westminster's word. A claim's tradition is the
  one its citation records as advancing it, which is a proxy for whose authority it rests on, not
  a record of who wrote each work cited. -/
  authorityFrom : Option Tradition := none
  /-- Whether a step resting on Scripture alone may be answered only from Scripture. -/
  scriptureAlone : Bool
  /-- The principles of reading it licenses. -/
  principles : List Principle
  /-- How it takes an argument from silence, where its source says; `none` where its source does
  not speak to it, which is not the same as refusing it. -/
  silence : Option SilenceTerms
  /-- Who holds it, where, and with what confidence that they do. -/
  source : Source

namespace Warrant

/-- Every warrant, best first. -/
def all : List Warrant := [.scripture, .evidence, .authority, .assertion]

/-- No warrant is left out. -/
theorem mem_all (w : Warrant) : w ∈ all := by cases w <;> decide

end Warrant

namespace Epistemology

/-- **An epistemology says what a standard says**: it admits exactly the warrants the standard
admits, and keeps Scripture-alone steps to Scripture exactly when the standard is the scriptural
one, and admits authority from any tradition, as every standard does. Then the standard can be
given the epistemology's holder, and no credibility result moves. -/
def agreesWith (E : Epistemology) (s : Standard) : Bool :=
  Warrant.all.all (fun w => E.admits w == s.admits w) && E.scriptureAlone == (s == .scriptural) &&
    E.authorityFrom.isNone

/-- Matching a standard means admitting what it admits, warrant by warrant. -/
theorem admits_eq_of_agreesWith {E : Epistemology} {s : Standard} (h : E.agreesWith s = true)
    (w : Warrant) : E.admits w = s.admits w := by
  simp only [agreesWith, Bool.and_eq_true, List.all_eq_true, beq_iff_eq] at h
  exact h.1.1 w (Warrant.mem_all w)

/-- **Whether an epistemology accepts a move's silences**: a move that argues from no silence is
accepted by all; one that does is accepted freely, only with its expectation stated, or not at
all. `none` when the epistemology's source does not say. -/
def acceptsSilences (E : Epistemology) (m : Move) : Option Bool :=
  E.silence.map fun
    | .accepted => true
    | .withExpectation => m.fromSilenceAlone.isEmpty
    | .refused => m.silences.isEmpty

/-- **Whether an epistemology admits a cited claim**: it admits the claim's warrant, and, if the
claim rests on someone's authority, the authority is from the tradition the epistemology admits
authority from. -/
def admitsCited (E : Epistemology) (m : AtomMeta) : Bool :=
  E.admits m.warrant && (m.warrant != .authority || E.authorityFrom.all (· == m.source.tradition))

end Epistemology

namespace ArgumentPackage

/-- **The claims a position asserts that an epistemology does not admit**: each rests on a
warrant the epistemology refuses, or on authority from a tradition other than the one whose
authority it admits. -/
def refusedBy (E : Epistemology) (pkg : ArgumentPackage α) : List α :=
  pkg.assertedAtoms.filter fun a => !E.admitsCited (pkg.cite a)

end ArgumentPackage

/-- **A position, held to its own rule**: the epistemology it professes, and the claims it
asserts that its own epistemology does not admit. -/
structure OwnRule (α : Type) where
  /-- The epistemology the position professes. -/
  epistemology : Epistemology
  /-- The claims it asserts that its own epistemology does not admit. -/
  claims : List α

/-- Whether a position keeps its own rule: nothing it asserts rests on what its own epistemology
refuses. -/
def OwnRule.kept (r : OwnRule α) : Bool := r.claims.isEmpty

/-- **Holding a position to the rule it professes**: what it asserts, against the epistemology.
Which epistemology a position professes is not computed. A step cited to a scholar of another
tradition does not make the position that scholar's, so the profession is declared, party by
party, with the reason, where the position is encoded. -/
def ArgumentPackage.heldTo (E : Epistemology) (pkg : ArgumentPackage α) : OwnRule α :=
  { epistemology := E, claims := pkg.refusedBy E }

/-! ### At work

Three epistemologies of the module's own, differing only in how they take a silence, applied to
the moves `Testimony.Semantics.FallacyExamples` writes: one argues from silence alone, one states
its expectation. And an epistemology admitting only Scripture and evidence, checked against the
standards. -/

namespace EpistemologyExamples

open Testimony.Semantics.FallacyExamples

/-- An epistemology of the module's own, cited as the library's: Scripture and evidence, and
silence taken on the given terms. -/
def withSilence (t : Option SilenceTerms) : Epistemology :=
  { name := "an example", statement := "Scripture and evidence."
  , admits := fun w => w == .scripture || w == .evidence
  , scriptureAlone := false, principles := [], silence := t
  , source :=
      { primary := .proposal "An example of the library's own, for its checks; it argues nothing."
      , tradition := .formalOntology, confidence := .consensus } }

/-- **The silence terms, at work.** Taken freely, both moves pass. Taken only with the
expectation stated, the move from silence alone fails and the one stating its expectation
passes. Refused, both fail, since both argue from silence. And where the source does not say,
nothing is concluded either way. -/
theorem silence_terms_at_work :
    (withSilence (some .accepted)).acceptsSilences aloneNotThere = some true ∧
      (withSilence (some .withExpectation)).acceptsSilences aloneNotThere = some false ∧
      (withSilence (some .withExpectation)).acceptsSilences aloneExpected = some true ∧
      (withSilence (some .refused)).acceptsSilences aloneExpected = some false ∧
      (withSilence none).acceptsSilences aloneNotThere = none := by
  decide

/-- **Agreement with a standard, at work.** Admitting Scripture and evidence, and not keeping
Scripture-alone steps to Scripture, is what the evidence standard admits, and not what the
scriptural standard asks or what the tradition standard allows. -/
theorem agrees_at_work :
    (withSilence none).agreesWith .evidence = true ∧
      (withSilence none).agreesWith .scriptural = false ∧
      (withSilence none).agreesWith .tradition = false := by
  decide

end EpistemologyExamples

end Testimony.Logic
