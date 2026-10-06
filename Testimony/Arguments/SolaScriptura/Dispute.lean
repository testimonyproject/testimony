import Testimony.Arguments.SolaScriptura.Mark7
import Testimony.Logic.Dispute
import Testimony.Logic.Horn
import Testimony.Logic.Solver
import Testimony.Logic.Verdict
import Testimony.Logic.Map

/-!
# Arguments.SolaScriptura.Dispute — what Mark 7 decides between Rome and the Reformers

`Mark7.lean` asks what each position entails. This module asks what happens when
they meet. Five parties: Mark 7's principle; Mark 7's case for sola scriptura;
Trent, as it states its position; and Trent with its tradition read each of the
two ways the dilemma `whatTrentsTraditionIs` names. Who defeats whom is not
stipulated — each defeat, and each absence of one, is computed from the parties'
premises and checked by the kernel (see `Testimony.Logic.Dispute`).

## How to read the verdicts

- **Defeats.** One position contradicts another — denies one of its premises,
  its conclusion, or a claim it derives on the way — and is not the weaker of
  the two. A defeat that runs both ways is a *standoff*.
- **Weakest link.** A position is only as strong as its least-supported premise
  or step. Ratings run from `disputed`, the lowest, through `plausible` and
  `wellSupported`, to `consensus`.
- **Forced.** Accepted however every standoff is resolved: nothing attacks it
  that it cannot rule out.
- **Can be defended.** Held by some consistent position that answers every
  attack on its members, itself or through an ally.
- **Not forced.** Some consistent position leaves it out. Not forced is not
  false: the dispute, as argued, cannot make a reader accept it.
- **Cannot be defended.** No consistent position can hold it and answer its
  attackers.
- **A defensible position that cannot be enlarged** (a *maximal* one) is a
  consistent position answering every attack on its members, to which no other
  party can be added without losing that. "Some maximal defensible position
  holds it" means a reader can hold it and lose nothing by it.

## The ratings decide one thing here

Every party but one rests on something rated `disputed`. Mark 7's case rests on
the premise that no apostolic word survives outside Scripture. Trent rests on
tradition as a source of revelation alongside Scripture — a claim this module's
audit moved from `wellSupported` to `disputed`, because Geiselmann grants
Session IV and denies that it canonised two coordinate sources. The reading of
Trent as commandments of men rests on Calvin's reading, which Rome denies.

The exception is Mark 7's principle. Its text is `consensus`, and its step from
the text is `wellSupported`: no one was found who grants Mark 7 and denies that
God's word judges human tradition. So an attack on it from a party at the bottom
fails, and its attack on such a party succeeds.

## Who defeats whom

- **Mark 7's principle defeats Trent read as commandments of men, and not the
  reverse.** Read that way, Trent binds a commandment of men as God's word; the
  principle denies that any may be. The reading's reply, from a claim rated
  `disputed`, fails against the principle.
- **Mark 7's case and Trent defeat each other, whichever way Trent is read.** One
  concludes that Scripture is the sole infallible rule, the other that it is
  not; and Trent read as the apostolic word also denies the premise Mark 7's case
  needs. Each side's weakest link is `disputed`, so no rating breaks the tie.
- **Mark 7's principle and Trent do not conflict**, read as Trent states it or
  as the apostolic word (`trent_grants_marks_principle`).

## What follows

**Mark 7's principle is forced** (`marks_principle_prevails`), and it is common
ground: Rome grants it. **Trent, read as commandments of men, cannot be defended**
(`trent_as_mens_commandments_indefensible`). **Between Mark 7's case for sola
scriptura and Trent, the dispute chooses neither**: each can be defended, and
neither is forced (`mark7_case_defensible`, `mark7_case_not_forced`,
`trent_defensible_against_mark7`, `trent_not_forced_against_mark7`). Mark 7 does
not decide the Reformation's question. What would decide it is argued, not
weighed: whether any apostolic word survives outside Scripture, and, even
granting that none does, whether the principle then makes Scripture the *sole*
infallible rule. Both are rated `disputed`.
-/

namespace Testimony.Arguments.SolaScriptura

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### Strength -/

/-- **Mark 7's principle does not rest on anything disputed.** The text is
`consensus`, and the step from it `wellSupported`, so its weakest link is well
supported: `2` on the scale from `0`, disputed, to `3`, consensus. -/
theorem mark7Principle_strength : mark7Principle.strength = 2 := by decide
/-- Mark 7's case rests on the premise that no apostolic word survives outside
Scripture, rated `disputed`. -/
theorem mark7Case_strength : mark7Case.strength = 0 := by decide
/-- Trent rests on tradition as a coordinate source of revelation, rated
`disputed`. -/
theorem tridentineCase_strength : tridentineCase.strength = 0 := by decide
/-- Trent read as commandments of men rests on everything Trent does, and on
Calvin's reading, rated `disputed`. -/
theorem tridentineAsMensCommandments_strength :
    tridentineAsMensCommandments.strength = 0 := by decide
/-- Trent read as the apostolic word rests on everything Trent does. -/
theorem tridentineAsApostolicWord_strength :
    tridentineAsApostolicWord.strength = 0 := by decide

/-! ### The dispute -/

/-- The parties to the dispute over Mark 7. -/
inductive Mark7Party
  /-- Mark 7's principle: God's word judges human tradition. -/
  | principle
  /-- Sola scriptura from Mark 7. -/
  | mark7
  /-- Trent, as it states its position. -/
  | trent
  /-- Trent, with its tradition read as commandments of men. -/
  | trentAsMensCommandments
  /-- Trent, with its tradition read as the apostolic word handed on unwritten. -/
  | trentAsApostolicWord
deriving DecidableEq

/-- The package each party argues from. -/
@[solaScripturaDefs]
def mark7PartyNode : Mark7Party → ArgumentPackage Claim
  | .principle => mark7Principle
  | .mark7 => mark7Case
  | .trent => tridentineCase
  | .trentAsMensCommandments => tridentineAsMensCommandments
  | .trentAsApostolicWord => tridentineAsApostolicWord

/-- The dispute over Mark 7: every party's premises have a model, every party
establishes its conclusion, and every party's inferences are rated. -/
@[solaScripturaDefs]
def mark7Dispute : Dispute Claim Mark7Party where
  node := mark7PartyNode
  consistent i := Horn.satisfiable_of_satisfiable? (by cases i <;> decide +kernel)
  sound
    | .principle => mark7Principle_establishes
    | .mark7 => mark7Case_establishes
    | .trent => tridentineCase_establishes
    | .trentAsMensCommandments => tridentineAsMensCommandments_establishes
    | .trentAsApostolicWord => tridentineAsApostolicWord_establishes
  rated i := by
    cases i <;> simp [solaScripturaDefs, Line.asPackage]

/-- Mark 7's principle stands with Trent, as Trent states it and read as the
apostolic word: Rome's world, in which the principle holds and apostolic
teaching survives outside Scripture. -/
theorem marks_principle_stands_with_trent :
    mark7Dispute.StandTogether [.principle, .trent, .trentAsApostolicWord] := by
  satisfied_by romeGrantsMarksPrincipleReading [Dispute.StandTogether, solaScripturaDefs]

/-- The defeats of the dispute, as a table. -/
def mark7PartyDefeats : Mark7Party → Mark7Party → Prop
  | .principle, .trentAsMensCommandments => True
  | .mark7, .trent => True
  | .mark7, .trentAsMensCommandments => True
  | .mark7, .trentAsApostolicWord => True
  | .trent, .mark7 => True
  | .trentAsMensCommandments, .mark7 => True
  | .trentAsApostolicWord, .mark7 => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel mark7PartyDefeats := fun i j => by
  cases i <;> cases j <;> unfold mark7PartyDefeats <;> infer_instance

/-- Each party's weakest link: at the bottom for all but Mark 7's principle. -/
def mark7PartyStrength : Mark7Party → ℕ
  | .principle => 2
  | _ => 0

/-- Each party's weakest link, as its package computes it. -/
theorem mark7PartyNode_strength : ∀ i, (mark7PartyNode i).strength = mark7PartyStrength i
  | .principle => mark7Principle_strength
  | .mark7 => mark7Case_strength
  | .trent => tridentineCase_strength
  | .trentAsMensCommandments => tridentineAsMensCommandments_strength
  | .trentAsApostolicWord => tridentineAsApostolicWord_strength

/-- **Who defeats whom**, all 25 pairs. Mark 7's principle defeats Trent read as
commandments of men, and that reading's reply fails against it. Mark 7's case
and Trent defeat each other, as Trent states it and read either way. Nothing
else.

Every cell is computed from the parties' premises by `Horn.defeats?` and checked
by the kernel — the defeats, and the absences of defeat, alike. -/
theorem mark7Dispute_defeats :
    ∀ i j, mark7Dispute.defeats i j ↔ mark7PartyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (mark7PartyNode_strength i) (mark7PartyNode_strength j) ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute in the form the verdict solver computes with. -/
def mark7Finite : Solver.Finite mark7Dispute.defeats where
  parties := [.principle, .mark7, .trent, .trentAsMensCommandments, .trentAsApostolicWord]
  complete i := by cases i <;> decide
  defeats i j := decide (mark7PartyDefeats i j)
  spec i j := by rw [mark7Dispute_defeats]; simp

/-! ### The dispute as a graph -/

/-- **Nothing supports anything** in the dispute over Mark 7, in all 25 pairs: no
party's conclusion entails a claim another rests on. Mark 7's principle is
*derived* inside Mark 7's case, not assumed there, so the relation between them
is not support. Every cell is computed by `supports?` and checked by the
kernel. -/
theorem mark7Dispute_supports : ∀ i j, ¬ mark7Dispute.supports i j := by
  intro i j
  refine (supports_iff_of_supports? (P := False) ?_).not.mpr id
  cases i <;> cases j <;> decide +kernel

/-- Whose case is part of whose, as a table: besides each party's own, Trent's
is part of each reading of it. -/
def mark7PartyPartOf : Mark7Party → Mark7Party → Prop
  | .trent, .trentAsMensCommandments => True
  | .trent, .trentAsApostolicWord => True
  | i, j => i = j

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel mark7PartyPartOf := fun i j => by
  cases i <;> cases j <;> unfold mark7PartyPartOf <;> infer_instance

/-- **Whose case is part of whose**, all 25 pairs: Trent's case is part of each
reading of it, which only adds to it; and every case is part of itself. Every
cell is computed by `partOf?` and checked by the kernel. -/
theorem mark7Dispute_partOf : ∀ i j, mark7Dispute.partOf i j ↔ mark7PartyPartOf i j := by
  intro i j
  refine partOf_iff_of_partOf? ?_
  cases i <;> cases j <;> decide +kernel

/-- The dispute over Mark 7 drawn: who defeats whom, and whose case is part of
whose. -/
def mark7Map : ArgumentMap mark7Dispute where
  finite := mark7Finite
  supports _ _ := false
  supports_spec i j := by simp [mark7Dispute_supports i j]
  partOf i j := decide (mark7PartyPartOf i j)
  partOf_spec i j := by rw [mark7Dispute_partOf]; simp

/-! ### What the dispute decides -/

/-- How the dispute is settled as far as it can be, in one stage: nothing defeats
Mark 7's principle, so it comes first; and nothing joins it. Mark 7's case has
Trent, and Trent has Mark 7's case — a standoff; Trent read as the apostolic word
has Mark 7's case; and Trent read as commandments of men has the principle
itself. -/
def marksPrincipleUnanswered : Verdict mark7Dispute where
  finite := mark7Finite
  claim := .groundedExactly [[.principle]]
    [ (.mark7, .trent), (.trent, .mark7), (.trentAsMensCommandments, .principle)
    , (.trentAsApostolicWord, .mark7) ]
  checked := by decide +kernel

/-- **Mark 7's principle prevails outright, and it is common ground.** The
grounded extension — what the dispute forces before any choice between rivals —
is exactly the principle: God's word judges human tradition, and no commandment
of men may be taught as God's word. Nothing defeats it: the one party that
contradicts it, Trent read as commandments of men, rests on a reading rated
`disputed`, and its reply fails against a principle whose every link is rated
`wellSupported` or better. And Trent, as it states its position, does not
contradict it at all (`trent_grants_marks_principle`).

What this does not claim: that sola scriptura is forced. Mark 7's case for it
is not (`mark7_case_not_forced`). -/
@[headline]
theorem marks_principle_prevails :
    grounded mark7Dispute.defeats = {.principle} :=
  Eq.trans marksPrincipleUnanswered.holds (by ext x; cases x <;> simp [Solver.toSet])

#print axioms marks_principle_prevails

/-- Why Trent, read as commandments of men, cannot be defended: Mark 7's
principle defeats it, and nothing defeats the principle. -/
def mensCommandmentsReadingAnswered : Verdict mark7Dispute where
  finite := mark7Finite
  claim := .indefensible .trentAsMensCommandments [(.trentAsMensCommandments, .principle)]
  checked := by decide +kernel

/-- **Trent, read as commandments of men, cannot be defended.** No consistent
position that answers its attackers can hold it: Mark 7's principle defeats it,
and nothing answers the principle. This is the first horn of
`whatTrentsTraditionIs`, weighed: if what Trent receives alongside Scripture
were a commandment of men, Jesus' words in Mark 7
would condemn it, at a step rated `wellSupported`.

What this does not claim: that Trent's tradition *is* a commandment of men.
Trent says the opposite, and Calvin's reading of it is rated `disputed`. -/
@[headline]
theorem trent_as_mens_commandments_indefensible (S : Set Mark7Party)
    (hS : Admissible mark7Dispute.defeats S) : Mark7Party.trentAsMensCommandments ∉ S :=
  mensCommandmentsReadingAnswered.holds S hS

#print axioms trent_as_mens_commandments_indefensible

/-- Why Mark 7's case can be defended: it stands with Mark 7's principle, and
answers every party that defeats it — Trent, read or unread — itself. -/
def mark7StandsWithItsPrinciple : Verdict mark7Dispute where
  finite := mark7Finite
  claim := .credulous .mark7 [.principle, .mark7]
  checked := by decide +kernel

/-- **Sola scriptura from Mark 7 can be defended.** Some maximal defensible
position holds it, with Mark 7's principle. Every party that defeats it — Trent,
as it states its position and read either way — it defeats back. -/
@[headline]
theorem mark7_case_defensible : CredulouslyAccepted mark7Dispute.defeats .mark7 :=
  mark7StandsWithItsPrinciple.holds

#print axioms mark7_case_defensible

/-- Why Mark 7's case is not forced: a defensible position holds Trent, and Trent
defeats it. -/
def mark7AnsweredByTrent : Verdict mark7Dispute where
  finite := mark7Finite
  claim := .notSkeptical .mark7 .trent [.principle, .trent, .trentAsApostolicWord]
  checked := by decide +kernel

/-- **Nor is it forced.** A maximal defensible position holds Trent, with Mark 7's
principle and with Trent read as the apostolic word, and cannot hold Mark 7's
case with it. Their weakest links are all `disputed`, so no rating breaks the
tie. What would decide it is argued, not weighed: whether any apostolic word
survives outside Scripture (`whereTheApostolicWordReadingFalls`), and, even
granting that none does, whether the principle then makes Scripture the *sole*
infallible rule — a step Geiselmann and Florovsky deny. -/
@[headline]
theorem mark7_case_not_forced : ¬ SkepticallyAccepted mark7Dispute.defeats .mark7 :=
  mark7AnsweredByTrent.holds

#print axioms mark7_case_not_forced

/-- Why Trent can be defended against Mark 7: it stands with Mark 7's principle
and with its own reading as the apostolic word, and answers Mark 7's case
itself. -/
def trentStandsWithMarksPrinciple : Verdict mark7Dispute where
  finite := mark7Finite
  claim := .credulous .trent [.principle, .trent, .trentAsApostolicWord]
  checked := by decide +kernel

/-- **Trent, as it states its position, can be defended against Mark 7** — and
with Mark 7's principle. Some maximal defensible position holds Trent, the
principle, and Trent read as the apostolic word. Granting everything Mark 7's
principle says costs Trent nothing, so long as what it receives is the apostolic
word and not a commandment of men. -/
@[headline]
theorem trent_defensible_against_mark7 :
    CredulouslyAccepted mark7Dispute.defeats .trent :=
  trentStandsWithMarksPrinciple.holds

#print axioms trent_defensible_against_mark7

/-- Why Trent is not forced: a defensible position holds Mark 7's case, and it
defeats Trent. -/
def trentAnsweredByMark7 : Verdict mark7Dispute where
  finite := mark7Finite
  claim := .notSkeptical .trent .mark7 [.principle, .mark7]
  checked := by decide +kernel

/-- **Nor is Trent forced.** A maximal defensible position holds Mark 7's case
for sola scriptura, and cannot hold Trent with it. Between them the dispute
chooses neither. -/
@[headline]
theorem trent_not_forced_against_mark7 : ¬ SkepticallyAccepted mark7Dispute.defeats .trent :=
  trentAnsweredByMark7.holds

#print axioms trent_not_forced_against_mark7

end Testimony.Arguments.SolaScriptura
