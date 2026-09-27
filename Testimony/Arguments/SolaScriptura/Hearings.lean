import Testimony.Arguments.SolaScriptura.Dispute

/-!
# Arguments.SolaScriptura.Hearings — Mark 7, heard against each reading of Trent

The dispute over Mark 7 hears Trent three ways at once: as Trent states its
position, and with its tradition read each of the two ways the dilemma
`whatTrentsTraditionIs` names. A reader usually has one reading in mind, and
asks what Mark 7 settles *if that is what Trent means*. Each question is
answered by hearing the same dispute with the other readings set aside. Nothing
is re-argued: a hearing keeps every defeat the full dispute proved.

**If Rome's tradition were the commandments of men, would Mark 7 settle
sola scriptura?** Heard against that reading alone (`mensCommandmentsHearing`),
Mark 7's case is forced — but only because nothing left in the hearing contests
it. The reading is the only party that attacks it, and the principle defeats the
reading. Mark 7's case still rests on two things rated `disputed`: that no
apostolic word survives outside Scripture, and the step from the principle to
the *sole* rule. The reading of Trent as commandments of men contests neither,
and the parties that would are set aside. This is the Protestant polemic at full
strength — and it holds only on a reading of Trent that Trent itself denies.

**If Rome's tradition is the apostolic word handed on unwritten, what does
Mark 7 settle?** Heard against that reading (`apostolicWordHearing`), only the
principle — which the reading grants. Mark 7's case and the reading defeat each
other at one premise, that no apostolic word survives outside Scripture, and
each side's weakest link is `disputed`. So the dispute chooses neither.

The difference between the two hearings is the whole of what Mark 7 contributes:
against Rome's tradition read as human, it leaves Mark 7's case unopposed;
against it read as apostolic, it leaves the question where it was. Which it is,
Mark 7 does not say.
-/

namespace Testimony.Arguments.SolaScriptura

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### Heard against the reading as commandments of men -/

/-- Mark 7's principle and case, heard against Trent read as commandments of
men. Not heard: Trent as it states its position, and Trent read as the
apostolic word. -/
abbrev mensCommandmentsHearing :=
  mark7Dispute.restrict (· ∈ [Mark7Party.principle, .mark7, .trentAsMensCommandments])

/-- The hearing, in the form the verdict solver computes with. -/
abbrev mensCommandmentsHearingFinite :=
  mark7Finite.restrict (· ∈ [Mark7Party.principle, .mark7, .trentAsMensCommandments])

/-- How the hearing is settled, in two stages: nothing defeats Mark 7's
principle, so it comes first; the principle defeats the reading, and with the
reading answered Mark 7's case has no attacker left, so it comes second. -/
def mensCommandmentsHearingSettles : Verdict mensCommandmentsHearing where
  finite := mensCommandmentsHearingFinite
  claim := .groundedExactly [Witness.listSub _ [.principle], Witness.listSub _ [.mark7]]
    (Witness.Table.sub _ [(.trentAsMensCommandments, .principle)])
  checked := by decide +kernel

/-- **Against Rome's tradition read as commandments of men, Mark 7's case is
unopposed.** Heard against that reading alone, Mark 7's principle and Mark 7's
case for sola scriptura are both forced: the reading is the only party in the
hearing that attacks the case, and the principle defeats it.

What this does not claim: that Rome's tradition is the commandments of men —
Trent says what it receives came from Christ and the apostles, and the reading
that says otherwise is rated `disputed`. Nor that Mark 7's case is sound. It
still rests on the premise that no apostolic word survives outside Scripture,
and on a step Geiselmann and Florovsky deny, both `disputed`; no party heard
here contests either. Trent as it states its position, and Trent read as the
apostolic word, are set aside. -/
@[headline]
theorem mark7_forced_against_mens_commandments :
    grounded mensCommandmentsHearing.defeats =
      Solver.toSet (Witness.listSub _ [.principle, .mark7]) :=
  mensCommandmentsHearingSettles.holds

#print axioms mark7_forced_against_mens_commandments

/-! ### Heard against the reading as the apostolic word -/

/-- Mark 7's principle and case, heard against Trent read as the apostolic word
handed on unwritten. Not heard: Trent as it states its position, and Trent read
as commandments of men. -/
abbrev apostolicWordHearing :=
  mark7Dispute.restrict (· ∈ [Mark7Party.principle, .mark7, .trentAsApostolicWord])

/-- The hearing, in the form the verdict solver computes with. -/
abbrev apostolicWordHearingFinite :=
  mark7Finite.restrict (· ∈ [Mark7Party.principle, .mark7, .trentAsApostolicWord])

/-- How the hearing is settled: nothing defeats Mark 7's principle, so it comes
first; and nothing joins it, because Mark 7's case and the reading defeat each
other. -/
def apostolicWordHearingSettles : Verdict apostolicWordHearing where
  finite := apostolicWordHearingFinite
  claim := .groundedExactly [Witness.listSub _ [.principle]]
    (Witness.Table.sub _ [(.mark7, .trentAsApostolicWord), (.trentAsApostolicWord, .mark7)])
  checked := by decide +kernel

/-- **If Rome's tradition is the apostolic word, Mark 7 forces only its
principle** — which that reading grants. Mark 7's case and the reading stand off
at the premise that no apostolic word survives outside Scripture. -/
@[headline]
theorem against_the_apostolic_word_only_the_principle_is_forced :
    grounded apostolicWordHearing.defeats =
      Solver.toSet (Witness.listSub _ [.principle]) :=
  apostolicWordHearingSettles.holds

#print axioms against_the_apostolic_word_only_the_principle_is_forced

/-- Why Mark 7's case is not forced in this hearing: a defensible position holds
the reading, with the principle, and the reading defeats Mark 7's case. -/
def mark7AnsweredByTheApostolicWord : Verdict apostolicWordHearing where
  finite := apostolicWordHearingFinite
  claim := .notSkeptical ⟨.mark7, by decide⟩ ⟨.trentAsApostolicWord, by decide⟩
    (Witness.listSub _ [.principle, .trentAsApostolicWord])
  checked := by decide +kernel

/-- **So, against the apostolic word, sola scriptura from Mark 7 is not
forced.** A defensible position that cannot be enlarged holds Mark 7's
principle together with Trent read as the apostolic word, and cannot hold Mark
7's case with them. What would decide is argued, not weighed: whether any
apostolic word survives outside Scripture, and whether the principle would then
make Scripture the *sole* rule. Both are rated `disputed`, and neither is
something Mark 7 speaks to. -/
@[headline]
theorem mark7_not_forced_against_the_apostolic_word :
    ¬ SkepticallyAccepted apostolicWordHearing.defeats ⟨.mark7, by decide⟩ :=
  mark7AnsweredByTheApostolicWord.holds

#print axioms mark7_not_forced_against_the_apostolic_word

end Testimony.Arguments.SolaScriptura
