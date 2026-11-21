import Testimony.Checks.Fixture
import Testimony.Logic.Bundle
import Testimony.Semantics.Finding
import Testimony.Checks.FallacyCases
import Testimony.Logic.Markdown

/-!
# Testimony.Checks.BundleCases — what a bundle must refuse, and what it lets through

A bundle (`Testimony.Logic.Bundle`) tells a dispute's defeats in order. These
cases run it over the fixture's dispute, in which the minutes defeat the clock
and the clock's attack is refused: once as the exchange is, and three times as
it is not, each refusal pinned by `#guard_msgs`.

None of these cases is anyone's argument.
-/

namespace Testimony.Checks.BundleCases

open Testimony.Logic Testimony.Checks.Fixture

/-- **The meeting's length, told as an exchange.** The clock says two hours, and
the minutes answer it. -/
declare_bundle meetingLength in finite where
  /-- The clock says the meeting ran two hours. -/
  turn Party.clock
  /-- The minutes say it ran one, and they answer the clock: they defeat it, and
  its attack on them is refused. -/
  turn Party.minutes answers Party.clock

/-- The exchange has two turns, and the second answers the first. -/
theorem meetingLength_turns :
    meetingLength.turns.map (·.relation) = [.enters, .answers .clock] := rfl

/-! **Said to be a standoff, where the solver finds an answer**: the build
refuses it. -/

/--
error: declare_bundle: a turn said to be one that meets an earlier turn, where the solver finds:
  Party.minutes defeats Party.clock
  Party.clock does not defeat Party.minutes
Change what the bundle says, not the encoding.
-/
#guard_msgs in
/-- Not an exchange the dispute has. -/
declare_bundle aStandoff in finite where
  /-- The clock. -/
  turn Party.clock
  /-- The minutes, said to meet the clock. -/
  turn Party.minutes meets Party.clock

/-! **A turn quoting a declared fallacy, left unanswered**: the build refuses
it. The line quoted is a test case's, which declares the straw man it answers
(`Testimony.Checks.FallacyCases.Declared.strawMan`). -/

/--
error: declare_bundle: a turn quotes a line that declares a fallacy it commits,
and no later turn answers it. A fallacy is set out in a bundle only to be
answered there.
-/
#guard_msgs in
/-- Not an exchange a bundle may tell. -/
declare_bundle unanswered in finite where
  /-- The clock, quoting a straw man. -/
  turn Party.clock quoting Testimony.Checks.FallacyCases.Declared.strawMan

/-- **The same turn, answered**, is let through. -/
declare_bundle answered in finite where
  /-- The clock, quoting a straw man. -/
  turn Party.clock quoting Testimony.Checks.FallacyCases.Declared.strawMan
  /-- The minutes answer it. -/
  turn Party.minutes answers Party.clock

/-- The quoting turn is marked as declaring a fallacy. -/
theorem answered_declares : answered.turns.map (·.findings) = [["straw man"], []] := rfl

/-- **The clock said to answer the minutes**, which defeat it: refused, because
the solver finds the reverse. -/
example : ¬ (Turn.mk Party.clock (.answers .minutes) "" "" none []).relation.Holds
    dispute.defeats .clock := by
  intro h
  exact h.2 ((dispute_defeats _ _).2 trivial)

/-- **A relation to a turn not yet told** is refused: the minutes answer the
clock before the clock has entered. -/
theorem answer_before_the_turn :
    Turn.ordered [Turn.mk Party.minutes (.answers .clock) "" "" none [],
      Turn.mk Party.clock .enters "" "" none []] = false := by decide

/-- **A turn quoting a declared fallacy, left unanswered**, is refused; answered,
it is let through. -/
theorem declared_must_be_answered :
    Turn.answered [Turn.mk Party.clock .enters "" "" (some "aLine") ["straw man"]] = false ∧
      Turn.answered [Turn.mk Party.clock .enters "" "" (some "aLine") ["straw man"],
        Turn.mk Party.minutes (.answers .clock) "" "" none []] = true := by decide

/-! **On the page.** Each turn is its party's paragraph, then the sentence that
joins it to the turn it names, in the solver's words, and what the line it quotes
declares. The pairs a turn has already joined are not said again. -/

#guard Markdown.exchange [] answered.view ==
  "**By the clock.** The clock, quoting a straw man.\n\n" ++
  "It quotes [`strawMan`](#strawMan). The line it quotes commits a straw man, and " ++
    "says so where it is written. It is set out here to be answered by " ++
    "*By the minutes*.\n\n" ++
  "**By the minutes.** The minutes answer it.\n\n" ++
  "This answers *By the clock*: it defeats it, and *By the clock* does not defeat it " ++
    "in return.\n\n"

/-- Three positions, one pair joined by a turn: the paragraph after the turns
states the pairs no turn has joined, as the table has them. -/
def threeWay : Page.Exchange :=
  { turns := [⟨"A", "", "", "", "", [], ""⟩, ⟨"B", "", "meets", "A", "", [], ""⟩,
      ⟨"C", "", "", "", "", [], ""⟩]
    pairs := [("A", "B", true, true), ("A", "C", false, false), ("B", "C", false, true)] }

/-- The summary paragraph, as the page sets it. -/
def summaryText (x : Page.Exchange) : String :=
  String.join ((Page.Exchange.summary x).map (Markdown.seg []))

#guard summaryText threeWay ==
  "Of the pairs no turn has joined: *C* defeats *B*, and is not defeated by it. " ++
    "No other pair defeats either way."

-- Three positions that all defeat each other are said to, in one sentence.
#guard summaryText { threeWay with
    pairs := [("A", "B", true, true), ("A", "C", true, true), ("B", "C", true, true)] } ==
  "Each of these positions defeats every other, so none of them gives way."

end Testimony.Checks.BundleCases
