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
it is not, each refusal pinned by `#guard_msgs`. Then over two meetings heard as
one (`Testimony.Checks.TwoMeetings`), whose claims are kept apart, so that a turn
from one meeting told as a reply to the other is a red herring.

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
error: declare_bundle: a turn said to meet an earlier turn, where the solver finds:
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
error: declare_bundle: a turn sets out a fallacy, its own or one the line it quotes
declares, and no later turn answers it. A fallacy is set out in a bundle only
to be answered there.
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
example : ¬ ({ party := Party.clock, relation := .answers .minutes } : Turn Party).relation.Holds
    dispute.defeats .clock := by
  intro h
  exact h.2 ((dispute_defeats _ _).2 trivial)

/-- **A relation to a turn not yet told** is refused: the minutes answer the
clock before the clock has entered. -/
theorem answer_before_the_turn :
    Turn.ordered [({ party := .minutes, relation := .answers .clock } : Turn Party),
      { party := .clock }] = false := by decide

/-- A turn quoting a line that declares a straw man. -/
def quotesAStrawMan : Turn Party :=
  { party := .clock, quoting := some "aLine", findings := ["straw man"] }

/-- **A turn quoting a declared fallacy, left unanswered**, is refused; answered,
it is let through. -/
theorem declared_must_be_answered :
    Turn.answered [quotesAStrawMan] = false ∧
      Turn.answered [quotesAStrawMan, { party := .minutes, relation := .answers .clock }] =
        true := by decide

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
  { turns := [{ party := "A", doc := "" },
      { party := "B", doc := "", relation := "meets", target := "A" }, { party := "C", doc := "" }]
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

/-! ### A reply, and a red herring

In two meetings heard as one, each meeting's minutes and clock share a meaning:
an hour and two hours exclude each other. Nothing of the first meeting touches
the second. -/

/-- The first meeting's minutes and clock share a meaning, and the second
meeting's clock shares nothing with the first meeting's minutes. -/
theorem shares_within_a_meeting :
    TwoMeetings.dispute.shares (.inl .minutes) (.inl .clock) = true ∧
      TwoMeetings.dispute.shares (.inr .clock) (.inl .minutes) = false := by
  decide +kernel

/-- **A reply on the subject** passes the relevance check, and a red herring
fails it: the first meeting's minutes reply to its clock, and the second
meeting's clock does not. -/
theorem relevant_reply :
    (Relation.responds (Sum.inl Party.clock)).relevant TwoMeetings.dispute.shares
        TwoMeetings.dispute.sameConclusion (.inl .minutes) = true ∧
      (Relation.responds (Sum.inl Party.minutes)).relevant TwoMeetings.dispute.shares
        TwoMeetings.dispute.sameConclusion (.inr .clock) = false := by
  decide +kernel

/-- **The second meeting's clock, told as a reply to the first meeting's
minutes**, evades them, and the second meeting's minutes answer it. -/
declare_bundle aRedHerring in TwoMeetings.finite where
  /-- The first meeting's minutes say it ran an hour. -/
  turn (Sum.inl Party.minutes)
  /-- The second meeting's clock says that meeting ran two hours. -/
  turn (Sum.inr Party.clock) evades (Sum.inl Party.minutes)
  /-- The second meeting's minutes say it ran one. -/
  turn (Sum.inr Party.minutes) answers (Sum.inr Party.clock)

/-- The evading turn is charged with a red herring. -/
theorem aRedHerring_charges :
    aRedHerring.turns.map (·.charges) = [[], ["red herring"], []] := rfl

/-! **A red herring left unanswered** is refused. -/

/--
error: declare_bundle: a turn sets out a fallacy, its own or one the line it quotes
declares, and no later turn answers it. A fallacy is set out in a bundle only
to be answered there.
-/
#guard_msgs in
/-- Not an exchange a bundle may tell. -/
declare_bundle unansweredHerring in TwoMeetings.finite where
  /-- The first meeting's minutes. -/
  turn (Sum.inl Party.minutes)
  /-- The second meeting's clock, evading them. -/
  turn (Sum.inr Party.clock) evades (Sum.inl Party.minutes)

/-! **A red herring told as a reply** is refused, and the refusal names it. -/

/--
error: declare_bundle: a turn said to reply to an earlier turn shares no claim with it,
and no meaning. A reply on another subject is a red herring: say `evades`, and
answer it in a later turn.
-/
#guard_msgs in
/-- Not an exchange a bundle may tell. -/
declare_bundle aDisguisedHerring in TwoMeetings.finite where
  /-- The first meeting's minutes. -/
  turn (Sum.inl Party.minutes)
  /-- The second meeting's clock, said to reply to them. -/
  turn (Sum.inr Party.clock) responds (Sum.inl Party.minutes)

/-! **A defeat told as a reply** is refused: where the solver finds a defeat, the
turn answers or meets, and the bundle must say which. -/

/--
error: declare_bundle: a turn said to reply to an earlier turn, where the solver finds:
  (Sum.inl Party.minutes) defeats (Sum.inl Party.clock)
  (Sum.inl Party.clock) does not defeat (Sum.inl Party.minutes)
Change what the bundle says, not the encoding.
-/
#guard_msgs in
/-- Not an exchange a bundle may tell. -/
declare_bundle aDefeatToldAsAReply in TwoMeetings.finite where
  /-- The first meeting's clock. -/
  turn (Sum.inl Party.clock)
  /-- The first meeting's minutes, said only to reply to it. -/
  turn (Sum.inl Party.minutes) responds (Sum.inl Party.clock)

-- On the page, the red herring is named, with the turn that answers it. Both
-- meetings' packages carry the same names, so the page names them alike.
#guard Markdown.exchange [] aRedHerring.view ==
  "**By the minutes.** The first meeting's minutes say it ran an hour.\n\n" ++
  "**By the clock.** The second meeting's clock says that meeting ran two hours.\n\n" ++
  "It is told as a reply, but it shares no claim with *By the minutes*, and no meaning: " ++
    "it is a red herring, a reply that changes the subject. It is set out here to be " ++
    "answered by *By the minutes*.\n\n" ++
  "**By the minutes.** The second meeting's minutes say it ran one.\n\n" ++
  "This answers *By the clock*: it defeats it, and *By the clock* does not defeat it " ++
    "in return.\n\n" ++
  "No other pair of these positions defeats either way.\n\n"

/-! ### Moving the goalposts

The first meeting's clock is answered by its minutes. The clock then comes back,
told as the same position, about the second meeting: it concludes something
else, so it shifts, and the second meeting's minutes answer it. Told instead as
giving the first conclusion up, the same turn concedes, and nothing is charged. -/

/-- **A shift, after an answer**, set out and answered. -/
declare_bundle movedGoalposts in TwoMeetings.finite where
  /-- The first meeting's clock says it ran two hours. -/
  turn (Sum.inl Party.clock)
  /-- The first meeting's minutes answer it. -/
  turn (Sum.inl Party.minutes) answers (Sum.inl Party.clock)
  /-- The clock again, now of the second meeting. -/
  turn (Sum.inr Party.clock) shifts (Sum.inl Party.clock)
  /-- The second meeting's minutes answer that too. -/
  turn (Sum.inr Party.minutes) answers (Sum.inr Party.clock)

/-- The shifting turn is charged with moving the goalposts. -/
theorem movedGoalposts_charges :
    movedGoalposts.turns.map (·.charges) = [[], [], ["moving the goalposts"], []] := rfl

/-- **The same turn, told as a concession**, is let through, and charged with
nothing. -/
declare_bundle aConcession in TwoMeetings.finite where
  /-- The first meeting's clock says it ran two hours. -/
  turn (Sum.inl Party.clock)
  /-- The first meeting's minutes answer it. -/
  turn (Sum.inl Party.minutes) answers (Sum.inl Party.clock)
  /-- The clock gives up the first meeting, and speaks of the second. -/
  turn (Sum.inr Party.clock) concedes (Sum.inl Party.clock)

/-- The conceding turn is charged with nothing. -/
theorem aConcession_charges : aConcession.turns.map (·.charges) = [[], [], []] := rfl

/-! **A shift told as a restatement** is refused, and the refusal names it. -/

/--
error: declare_bundle: a turn said to restate an earlier turn concludes something else.
Told as the same position, that is moving the goalposts: say `shifts`, and answer it
in a later turn. If the turn gives the earlier conclusion up, say `concedes`.
-/
#guard_msgs in
/-- Not an exchange a bundle may tell. -/
declare_bundle aDisguisedShift in TwoMeetings.finite where
  /-- The first meeting's clock. -/
  turn (Sum.inl Party.clock)
  /-- The first meeting's minutes answer it. -/
  turn (Sum.inl Party.minutes) answers (Sum.inl Party.clock)
  /-- The clock of the second meeting, said to restate the first. -/
  turn (Sum.inr Party.clock) restates (Sum.inl Party.clock)

/-! **A shift before any answer** is refused: the goalposts move only once a
position has been answered. -/

/--
error: declare_bundle: a turn shifts from a position no earlier turn answers.
The goalposts move only once a position has been answered: say `concedes`, or
answer the position first.
-/
#guard_msgs in
/-- Not an exchange a bundle may tell. -/
declare_bundle anEarlyShift in TwoMeetings.finite where
  /-- The first meeting's clock. -/
  turn (Sum.inl Party.clock)
  /-- The clock of the second meeting, said to shift from it. -/
  turn (Sum.inr Party.clock) shifts (Sum.inl Party.clock)
  /-- The second meeting's minutes answer it. -/
  turn (Sum.inr Party.minutes) answers (Sum.inr Party.clock)

-- On the page, a shift names both conclusions and the turn that answered the
-- first. The two meetings' packages share their labels, so the case is set by hand.
#guard String.join ((Page.Exchange.connective
    { party := "The clock, again", doc := "", relation := "shifts", target := "The clock",
      concludes := "the second meeting ran two hours",
      targetConcludes := "the first meeting ran two hours",
      answeredEarlierBy := "The first minutes",
      answeredBy := "The second minutes" }).map (Markdown.seg [])) ==
  "It is told as the position of *The clock* again, but it concludes something else. " ++
    "That position concluded (the first meeting ran two hours), and this concludes " ++
    "(the second meeting ran two hours) once *The first minutes* had answered it. " ++
    "That is moving the goalposts: changing what is defended once it has been " ++
    "answered. It is set out here to be answered by *The second minutes*."

/-! ### Ignoring the rebuttal

The minutes answer the clock. The clock then sets out its position again, with
the same conclusion, and does not defeat the minutes: it ignores the rebuttal,
and the minutes answer it again. -/

/-- **A rebuttal ignored**, set out and answered. -/
declare_bundle anIgnoredRebuttal in finite where
  /-- The clock says the meeting ran two hours. -/
  turn Party.clock
  /-- The minutes answer it. -/
  turn Party.minutes answers Party.clock
  /-- The clock says it again. -/
  turn Party.clock ignores Party.clock
  /-- The minutes answer it again. -/
  turn Party.minutes answers Party.clock

/-- The restating turn is charged with ignoring the rebuttal. -/
theorem anIgnoredRebuttal_charges :
    anIgnoredRebuttal.turns.map (·.charges) = [[], [], ["ignoring the rebuttal"], []] := rfl

/-! **The same turn, told as a plain restatement**, is refused. -/

/--
error: declare_bundle: a turn said to restate an earlier one leaves standing a turn that defeated
that position, or a turn said to ignore a rebuttal leaves none standing. Restated
without an answer, a defeated position ignores the rebuttal: say `ignores`, and
answer it in a later turn. A restatement that defeats every rebuttal says `restates`.
-/
#guard_msgs in
/-- Not an exchange a bundle may tell. -/
declare_bundle aRebuttalPassedOver in finite where
  /-- The clock. -/
  turn Party.clock
  /-- The minutes answer it. -/
  turn Party.minutes answers Party.clock
  /-- The clock, said only to restate itself. -/
  turn Party.clock restates Party.clock

/-- The clock, answered by the minutes, then told again under `r`. -/
def rebutted (r : Relation Party) : List (Turn Party) :=
  [{ party := .clock }, { party := .minutes, relation := .answers .clock },
    { party := .clock, relation := r }]

/-- **A restatement that defeats its rebuttal** is let through, and one said to
ignore a rebuttal where it defeats every one is refused: here under a table in
which every party defeats every other. -/
theorem restating_meets_the_rebuttal :
    Turn.rebuttalsMet (fun _ _ => true) (rebutted (.restates .clock)) = true ∧
      Turn.rebuttalsMet (fun _ _ => true) (rebutted (.ignores .clock)) = false := by
  decide

-- On the page, the turn names the rebuttal it leaves standing.
#guard String.join ((Page.Exchange.connective (anIgnoredRebuttal.view.turns[2]?.getD
    { party := "", doc := "" })).map (Markdown.seg [])) ==
  "This sets out the position of *By the clock* again, with the same conclusion, but it " ++
    "does not defeat *By the minutes*, which defeated that position. That is ignoring " ++
    "the rebuttal: restating a position without answering what defeated it. It is set " ++
    "out here to be answered by *By the minutes*."

end Testimony.Checks.BundleCases
