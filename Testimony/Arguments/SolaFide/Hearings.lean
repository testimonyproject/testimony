import Testimony.Arguments.SolaFide.Dispute

/-!
# Arguments.SolaFide.Hearings — the same dispute, asked two narrower questions

A dispute answers the question it is asked, and the full sola fide dispute asks
a crowded one: the Reformers, Trent, and three modern schools of Pauline
scholarship at once. A reader usually wants something narrower. Two questions
come up again and again, and each is answered here by hearing the same dispute
with some of its parties set aside. Nothing is re-argued: a hearing keeps every
defeat the full dispute proved, and only leaves some parties unheard.

**What did the Reformation itself decide?** The sixteenth-century dispute was
Rome and the Reformers, before anyone had proposed a New Perspective on Paul or
an apocalyptic reading of him. Heard that way (`reformationAlone`) — the
sixteenth-century positions, argued with the modern evidence cited for each, so
Joos, Silva and Barr among them — one thing is forced: Paul's word — δικαιόω
does not denote the renewal of the inward man — by both routes, lexical and
exegetical. So Trent cannot claim that its definition is what Paul's word means;
that reading cannot be defended. What breaks is not Augustine's gloss — that he
glossed the word so is not in question — but the step from a Latin gloss to what
the Greek word denotes. But Trent's definition read as a
claim about what God does is not touched by anything about the word, and there
Trent and the Reformers tie: each defeats the other, and the ratings, all
`disputed`, cannot choose between them. The Reformation dispute, heard on its
own, comes down to what justification *is* — the question
`whatTrentsDefinitionClaims` locates.

**If Trent were not heard, would Scripture establish sola fide?** It is a
natural question for a Protestant reader, and the answer is more interesting
than yes. Heard without Trent (`withoutTrent`), four things are forced: Paul's
word, by both routes; Paul's gospel — justification is not the renewal of the
inward man; and Luke's "your faith has saved you" — faith suffices. But sola fide
itself, *faith alone*, is still not forced, from Paul or from Peter. What stops
it is not Rome. It is three disputes inside modern Pauline scholarship:

- Campbell's apocalyptic reading takes πίστις Χριστοῦ as Christ's own
  faithfulness, and meets Paul over the genitive;
- Sanders and Dunn read ἔργα νόμου as Israel's boundary markers, and the
  critics who answer them are answered back;
- Jervell reads the yoke of Acts 15 as something other than the law as a
  condition of salvation, and meets Peter's case.

Each of those is a question about what a text says, and each is where the
literature has it. Setting Rome aside does not make them go away.

Augustine stays where the full dispute has him. In the Reformation hearing he
is the ground Trent's reading of Paul's word rests on; without Trent, his gloss
goes with that reading, since nothing else rests on it. In both, he remains the
cited reader who grants Romans 4:5–8 and reads it the other way, which is why
Paul's step from Romans 4 is rated `disputed`. The library does not remove a reader
because it judges him mistaken; it shows where his reading breaks, and where it
does not.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### The Reformation dispute, on its own -/

/-- The parties of the sixteenth-century dispute: the three Reformed strands,
Paul's gospel, Paul's word by both routes, and Trent, read and unread. Not
heard: the apocalyptic reading, Sanders and his critics, and Jervell. -/
abbrev reformationAlone :=
  solaFideDispute.restrict (· ∉ [Party.apocalyptic, .sanders, .critics, .jervell])

/-- The Reformation dispute, in the form the verdict solver computes with. -/
abbrev reformationAloneFinite :=
  solaFideFinite.restrict (· ∉ [Party.apocalyptic, .sanders, .critics, .jervell])

/-- How the Reformation dispute is settled as far as it can be: nothing defeats
either route to Paul's word, so both come first, and nothing joins them. Each
Reformed party is defeated by Trent, Trent by Paul's case (and by Luke's, Peter's
and Paul's gospel), and Trent read as a claim
about Paul's word by Paul's word itself. -/
def reformationSettlesTheWord : Verdict reformationAlone where
  finite := reformationAloneFinite
  claim := .groundedExactly [Witness.listSub _ [.lexical, .romansOnTheWord]]
    (Witness.Table.sub _
      [ (.pauline, .trent), (.dominical, .trent), (.apostolic, .trent)
      , (.trent, .pauline), (.gospel, .trent), (.trentOnPaulsWord, .lexical) ])
  checked := by decide +kernel

/-- **What the Reformation dispute forces: Paul's word, and nothing else.** Heard
as Rome and the Reformers alone, the grounded extension is exactly the two
routes to Paul's word. Trent cannot claim that its definition is what Paul's
δικαιόω means. Everything else — sola fide from each strand, Paul's gospel,
Trent's definition as a claim about what God does — is defeated by someone it
does not answer. -/
@[headline]
theorem reformation_dispute_forces_only_pauls_word :
    grounded reformationAlone.defeats =
      Solver.toSet (Witness.listSub _ [.lexical, .romansOnTheWord]) :=
  reformationSettlesTheWord.holds

#print axioms reformation_dispute_forces_only_pauls_word

/-- Why Trent can be defended in the Reformation dispute: it stands with Paul's
word, and answers every party that attacks it itself. -/
def trentStandsWithPaulsWord : Verdict reformationAlone where
  finite := reformationAloneFinite
  claim := .credulous ⟨.trent, by decide⟩
    (Witness.listSub _ [.trent, .lexical, .romansOnTheWord])
  checked := by decide +kernel

/-- **Trent, as Trent states it, can be defended in the Reformation dispute — and
with Paul's word.** Some maximal defensible position holds Trent together
with both routes to Paul's word. That is the point of the dilemma, weighed:
granting everything Paul's word means costs Trent nothing, so long as its
definition is a claim about what God does. -/
@[headline]
theorem trent_defensible_with_pauls_word :
    CredulouslyAccepted reformationAlone.defeats ⟨.trent, by decide⟩ :=
  trentStandsWithPaulsWord.holds

#print axioms trent_defensible_with_pauls_word

/-- Why sola fide is not forced in the Reformation dispute: a defensible
position holds Trent, and Trent defeats Paul. -/
def reformationAnsweredByTrent : Verdict reformationAlone where
  finite := reformationAloneFinite
  claim := .notSkeptical ⟨.pauline, by decide⟩ ⟨.trent, by decide⟩
    (Witness.listSub _ [.trent, .lexical, .romansOnTheWord])
  checked := by decide +kernel

/-- **Nor is sola fide forced there.** Rome and the Reformers, heard alone, tie:
each Reformed strand and Trent defeat each other over Trent's definition, and
every rating on both sides is `disputed`. What would decide is the step from a
verdict to "renewal is no part of justification": it is `disputed` in Galatians
and again in Romans 4 (see `whatTrentsDefinitionClaims`). -/
@[headline]
theorem sola_fide_not_forced_in_the_reformation_dispute :
    ¬ SkepticallyAccepted reformationAlone.defeats ⟨.pauline, by decide⟩ :=
  reformationAnsweredByTrent.holds

#print axioms sola_fide_not_forced_in_the_reformation_dispute

/-! ### The dispute without Trent -/

/-- Every party but Trent's two: Trent as Trent states it, and Trent read as a
claim about
Paul's word. Augustine's gloss goes with the second, since it is the ground that
reading rests on. -/
abbrev withoutTrent := solaFideDispute.restrict (· ∉ [Party.trent, .trentOnPaulsWord])

/-- The dispute without Trent, in the form the verdict solver computes with. -/
abbrev withoutTrentFinite := solaFideFinite.restrict (· ∉ [Party.trent, .trentOnPaulsWord])

/-- What is settled without Trent: nothing now defeats Luke's case, Paul's
gospel, or either route to Paul's word, so all four come first; and nothing
joins them. Paul's case is defeated by the apocalyptic reading, Peter's by
Jervell, Sanders by the critics and the critics by Sanders, the apocalyptic
reading by Paul, and Jervell by Peter. -/
def withoutTrentSettles : Verdict withoutTrent where
  finite := withoutTrentFinite
  claim := .groundedExactly
    [Witness.listSub _ [.dominical, .gospel, .lexical, .romansOnTheWord]]
    (Witness.Table.sub _
      [ (.pauline, .apocalyptic), (.apostolic, .jervell), (.apocalyptic, .pauline)
      , (.sanders, .critics), (.critics, .sanders), (.jervell, .apostolic) ])
  checked := by decide +kernel

/-- **Without Trent, four things are forced.** Luke 7:50 — faith suffices; Paul's
gospel — justification is not the renewal of the inward man; and Paul's word, by
both routes — δικαιόω does not denote that renewal. With Trent unheard, nothing
attacks any of them. -/
@[headline]
theorem without_trent_luke_and_pauls_gospel_prevail :
    grounded withoutTrent.defeats =
      Solver.toSet (Witness.listSub _ [.dominical, .gospel, .lexical, .romansOnTheWord]) :=
  withoutTrentSettles.holds

#print axioms without_trent_luke_and_pauls_gospel_prevail

/-- Why Paul's case for sola fide is not forced without Trent: a defensible
position holds the apocalyptic reading, and it defeats Paul over πίστις Χριστοῦ.
-/
def paulAnsweredByCampbell : Verdict withoutTrent where
  finite := withoutTrentFinite
  claim := .notSkeptical ⟨.pauline, by decide⟩ ⟨.apocalyptic, by decide⟩
    (Witness.listSub _
      [.apocalyptic, .apostolic, .critics, .dominical, .gospel, .lexical, .romansOnTheWord])
  checked := by decide +kernel

/-- **Without Trent, sola fide from Paul is still not forced.** A maximal
defensible position holds Campbell's apocalyptic reading — πίστις Χριστοῦ as
Christ's own faithfulness — and cannot hold Paul's case with it. The obstacle is
a question about Paul's Greek, not about Rome. -/
@[headline]
theorem sola_fide_from_paul_not_forced_without_trent :
    ¬ SkepticallyAccepted withoutTrent.defeats ⟨.pauline, by decide⟩ :=
  paulAnsweredByCampbell.holds

#print axioms sola_fide_from_paul_not_forced_without_trent

/-- Why Peter's case for sola fide is not forced without Trent: a defensible
position holds Jervell, and he defeats it over the yoke. -/
def peterAnsweredByJervell : Verdict withoutTrent where
  finite := withoutTrentFinite
  claim := .notSkeptical ⟨.apostolic, by decide⟩ ⟨.jervell, by decide⟩
    (Witness.listSub _
      [.critics, .dominical, .gospel, .jervell, .lexical, .pauline, .romansOnTheWord])
  checked := by decide +kernel

/-- **Nor from Peter.** A maximal defensible position holds Jervell's reading of
Acts 15 — the yoke is not the law as a condition of salvation — and cannot hold
Peter's case with it. So without Trent, faith is forced to suffice (Luke), and
justification forced not to be renewal (Paul's gospel), but *faith alone* still
turns on three questions of exegesis: the genitive, the works of the law, and
the yoke. -/
@[headline]
theorem sola_fide_from_peter_not_forced_without_trent :
    ¬ SkepticallyAccepted withoutTrent.defeats ⟨.apostolic, by decide⟩ :=
  peterAnsweredByJervell.holds

#print axioms sola_fide_from_peter_not_forced_without_trent

end Testimony.Arguments.SolaFide
