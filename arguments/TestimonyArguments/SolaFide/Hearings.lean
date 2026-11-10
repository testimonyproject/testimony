import TestimonyArguments.SolaFide.Dispute

/-!
# TestimonyArguments.SolaFide.Hearings — two narrower questions

The full debate over sola fide puts a crowded question: the Reformers, Trent,
and several schools of modern scholarship all at once. A reader usually wants
something narrower. Two questions come up again and again. Each is answered here
by hearing the same debate with some positions left out. Nothing is argued
again. Every defeat the full debate established is kept; some positions are
simply not heard.

**What did the Reformation itself decide?** The sixteenth-century debate was
between Rome and the Reformers, before anyone had proposed a New Perspective on
Paul or an apocalyptic reading of him. Heard that way (`reformationAlone`), with
the modern evidence cited for each side, one thing is forced: Paul's "justify"
(δικαιόω) does not mean the renewal of the inward person. So Trent cannot claim
that its definition is what Paul's word means. What fails there is not
Augustine's explanation of the word, which he certainly gave, but the step from
a Latin explanation to what the Greek word means.

Trent's definition taken as a claim about what God does is not touched by
anything about the word. There Trent and the Reformers tie: each defeats the
other, and the ratings, all `disputed`, cannot choose. The Reformation debate,
heard alone, comes down to what justification *is*, which is the question
`whatTrentsDefinitionClaims` examines.

**If Trent were not heard, would Scripture establish sola fide?** A Protestant
reader will naturally ask this. Heard without Trent (`withoutTrent`), two things
are forced: the meaning of Paul's word; and Paul's gospel, that justification is
not the renewal of the inward person. *Faith alone* is not forced, from Paul,
from Peter or from John, and neither is Luke's "your faith has saved you", that
faith suffices. Five disagreements remain with Rome left out: three in modern
New Testament scholarship, and two older.

- Campbell's apocalyptic reading takes "faith of Christ" (πίστις Χριστοῦ) as
  Christ's own faithfulness, and meets Paul's case there.
- Sanders and Dunn read "works of the law" (ἔργα νόμου) as the marks of Israel.
  The critics answer them, and are answered in return.
- Jervell reads the yoke of Acts 15 as something other than the law as a
  condition of salvation, and meets Peter's case.
- Aquinas reads the believing of John 6:29 as faith formed by charity, and meets
  John's case. Luther answers him from Galatians 3, and is answered in return. -
  Chrysostom reads John 3:36 and Matthew 7:21 as requiring a right life beside
  believing, and meets every case that concludes faith suffices, Luke's among
  them. The Reformed answer, that the obedience those texts require is
  sanctification, the fruit of faith, meets him and is met in return.

Each of these is a question about what a text says. Leaving Rome out does not
make them go away.

**Augustine** stays where the full debate has him. In the Reformation hearing,
his explanation is what Trent's reading of Paul's word rests on. Without Trent,
it goes out with that reading, since nothing else rests on it. In both he
remains the cited reader who accepts Romans 4:5–8 and reads it the other way,
which is why the step from Romans 4 is rated `disputed`. A reader is not removed
from these pages because he is judged mistaken. The pages show where his reading
fails, and where it does not.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### The Reformation debate, heard alone -/

/-- The positions of the sixteenth-century debate: the four Reformed strands, Paul's
gospel, the two arguments about Paul's word, Trent as it states its definition
and Trent taken as a claim about Paul's word, and the exchange over John 6:29
between Aquinas and Luther. Not heard: the apocalyptic reading, Sanders and his
critics, and Jervell. -/
abbrev reformationAlone :=
  solaFideDispute.restrict (· ∉ [Party.apocalyptic, .sanders, .critics, .jervell])

/-- The Reformation debate, in the form the solver works with. -/
abbrev reformationAloneFinite :=
  solaFideFinite.restrict (· ∉ [Party.apocalyptic, .sanders, .critics, .jervell])

/-- How far the Reformation debate can be settled. Nothing defeats either argument
about Paul's word, so both are accepted first, and nothing joins them. Each
Reformed position is defeated by Trent. Trent is defeated by Paul's case, and by
Luke's, Peter's and Paul's gospel. Trent taken as a claim about Paul's word is
defeated by the argument from the word itself. -/
def reformationSettlesTheWord : Verdict reformationAlone where
  finite := reformationAloneFinite
  claim := .groundedExactly [Witness.listSub _ [.lexical, .romansOnTheWord]]
    (Witness.Table.sub _
      [ (.pauline, .trent), (.dominical, .trent), (.apostolic, .trent)
      , (.trent, .pauline), (.gospel, .trent), (.trentOnPaulsWord, .lexical)
      , (.johannine, .trent), (.aquinas, .luther), (.luther, .aquinas)
      , (.chrysostom, .pauline), (.sanctification, .trent) ])
  checked := by decide +kernel

/-- **What the Reformation debate forces: the meaning of Paul's word, and nothing
else.** Heard as Rome and the Reformers alone, the forced positions are exactly
the two arguments about Paul's word. Trent cannot claim that its definition is
what Paul's "justify" (δικαιόω) means.

Nothing else is forced. Sola fide from each strand, Paul's gospel, and Trent's
definition as a claim about what God does each have an attacker they cannot
remove. -/
@[headline]
theorem reformation_dispute_forces_only_pauls_word :
    grounded reformationAlone.defeats =
      Solver.toSet (Witness.listSub _ [.lexical, .romansOnTheWord]) :=
  reformationSettlesTheWord.holds

#print axioms reformation_dispute_forces_only_pauls_word

/-- Why Trent can be defended in the Reformation debate: it can be held with the
arguments about Paul's word, and it answers every position that attacks it. -/
def trentStandsWithPaulsWord : Verdict reformationAlone where
  finite := reformationAloneFinite
  claim := .credulous ⟨.trent, by decide⟩
    (Witness.listSub _ [.trent, .lexical, .romansOnTheWord])
  checked := by decide +kernel

/-- **Trent, as Trent states it, can be defended in the Reformation debate, together
with the arguments about Paul's word.** A consistent set of positions that
answers every attack holds Trent and both of those arguments.

This is what the two ways of taking Trent's definition come to when weighed:
accepting everything the word's meaning shows costs Trent nothing, so long as
its definition is a claim about what God does. -/
@[headline]
theorem trent_defensible_with_pauls_word :
    CredulouslyAccepted reformationAlone.defeats ⟨.trent, by decide⟩ :=
  trentStandsWithPaulsWord.holds

#print axioms trent_defensible_with_pauls_word

/-- Why sola fide is not forced in the Reformation debate: a set of positions that
can be defended includes Trent, and Trent defeats Paul's case. -/
def reformationAnsweredByTrent : Verdict reformationAlone where
  finite := reformationAloneFinite
  claim := .notSkeptical ⟨.pauline, by decide⟩ ⟨.trent, by decide⟩
    (Witness.listSub _ [.trent, .lexical, .romansOnTheWord])
  checked := by decide +kernel

/-- **Nor is sola fide forced there.** Rome and the Reformers, heard alone, tie.
Each Reformed strand and Trent defeat each other over Trent's definition, and
every rating on both sides is `disputed`. What would decide it is the step from
a verdict to "renewal is no part of justification", which is `disputed` in
Galatians and again in Romans 4 (see `whatTrentsDefinitionClaims`). -/
@[headline]
theorem sola_fide_not_forced_in_the_reformation_dispute :
    ¬ SkepticallyAccepted reformationAlone.defeats ⟨.pauline, by decide⟩ :=
  reformationAnsweredByTrent.holds

#print axioms sola_fide_not_forced_in_the_reformation_dispute

/-! ### The debate without Trent -/

/-- Every position but Trent's two: Trent as it states its definition, and Trent
taken as a claim about Paul's word. Augustine's explanation of "justify" goes
with the second, since that is what it rests on. -/
abbrev withoutTrent := solaFideDispute.restrict (· ∉ [Party.trent, .trentOnPaulsWord])

/-- The debate without Trent, in the form the solver works with. -/
abbrev withoutTrentFinite := solaFideFinite.restrict (· ∉ [Party.trent, .trentOnPaulsWord])

/-- What is settled without Trent. Nothing now defeats Paul's gospel or either
argument about Paul's word, so those three are accepted first, and nothing joins
them. Luke's case is defeated by Chrysostom, and Chrysostom by Luke's case. Paul's
case is defeated by the apocalyptic reading, Peter's by Jervell, John's by
Aquinas. Sanders is defeated by the critics and the critics by Sanders, the
apocalyptic reading by Paul's case, Jervell by Peter's case, Aquinas by Luther
and Luther by Aquinas, and the Reformed answer to Chrysostom by Chrysostom. -/
def withoutTrentSettles : Verdict withoutTrent where
  finite := withoutTrentFinite
  claim := .groundedExactly
    [Witness.listSub _ [.gospel, .lexical, .romansOnTheWord]]
    (Witness.Table.sub _
      [ (.pauline, .apocalyptic), (.apostolic, .jervell), (.apocalyptic, .pauline)
      , (.sanders, .critics), (.critics, .sanders), (.jervell, .apostolic)
      , (.johannine, .aquinas), (.aquinas, .luther), (.luther, .aquinas)
      , (.dominical, .chrysostom), (.chrysostom, .dominical)
      , (.sanctification, .chrysostom) ])
  checked := by decide +kernel

/-- **Without Trent, two things are forced.** That justification is not the
renewal of the inward person, from Paul's gospel. And that Paul's "justify"
(δικαιόω) does not mean that renewal, argued two ways. With Trent not heard,
nothing attacks either.

Luke's "faith suffices" is no longer among them. Chrysostom, reading John 3:36
and Matthew 7:21, concludes that believing is not enough without a right life,
and so stands against it (`luke_not_forced_without_trent`).

What this does not claim: that *faith alone*, or even "faith suffices", is
refuted. Each is in a tie; see the results that follow. -/
@[headline]
theorem without_trent_pauls_gospel_and_word_prevail :
    grounded withoutTrent.defeats =
      Solver.toSet (Witness.listSub _ [.gospel, .lexical, .romansOnTheWord]) :=
  withoutTrentSettles.holds

#print axioms without_trent_pauls_gospel_and_word_prevail

/-- Why Luke's case is not forced without Trent: a set of positions that can be
defended includes Chrysostom, who defeats it. -/
def lukeAnsweredByChrysostom : Verdict withoutTrent where
  finite := withoutTrentFinite
  claim := .notSkeptical ⟨.dominical, by decide⟩ ⟨.chrysostom, by decide⟩
    (Witness.listSub _
      [ .apocalyptic, .aquinas, .chrysostom, .critics, .gospel, .jervell, .lexical
      , .romansOnTheWord ])
  checked := by decide +kernel

/-- **Without Trent, Luke's case is not forced either.** A consistent set of
positions that answers every attack holds Chrysostom, and cannot hold Luke's case
with it. Chrysostom reads "whoever does not obey the Son shall not see life"
(John 3:36) and "the one who does the will of my Father" (Matthew 7:21) as
requiring a right life beside believing. Luke's case reads "your faith has saved
you" (Luke 7:50) as saying that faith sufficed.

What this claims: a reading of two other sayings of Jesus, rated `disputed`, ties
with Luke's. What it does not claim: that Chrysostom outranks Luke, or that any
text of Luke's is contradicted. Luke's case defeats Chrysostom in return, and
Chrysostom accepts every word of Luke 7:50; what he denies is the step from it
to "faith suffices". -/
@[headline]
theorem luke_not_forced_without_trent :
    ¬ SkepticallyAccepted withoutTrent.defeats ⟨.dominical, by decide⟩ :=
  lukeAnsweredByChrysostom.holds

#print axioms luke_not_forced_without_trent

/-- Why Paul's case is not forced without Trent: a set of positions that can be
defended includes the apocalyptic reading, which defeats Paul's case over "faith
of Christ". -/
def paulAnsweredByCampbell : Verdict withoutTrent where
  finite := withoutTrentFinite
  claim := .notSkeptical ⟨.pauline, by decide⟩ ⟨.apocalyptic, by decide⟩
    (Witness.listSub _
      [.apocalyptic, .apostolic, .critics, .dominical, .gospel, .lexical, .romansOnTheWord])
  checked := by decide +kernel

/-- **Without Trent, sola fide from Paul is still not forced.** A consistent set of
positions that answers every attack holds Campbell's apocalyptic reading, on
which "faith of Christ" (πίστις Χριστοῦ) is Christ's own faithfulness, and
cannot hold Paul's case with it. What stands in the way is a question about
Paul's Greek, not about Rome. -/
@[headline]
theorem sola_fide_from_paul_not_forced_without_trent :
    ¬ SkepticallyAccepted withoutTrent.defeats ⟨.pauline, by decide⟩ :=
  paulAnsweredByCampbell.holds

#print axioms sola_fide_from_paul_not_forced_without_trent

/-- Why Peter's case is not forced without Trent: a set of positions that can be
defended includes Jervell, who defeats it over the yoke. -/
def peterAnsweredByJervell : Verdict withoutTrent where
  finite := withoutTrentFinite
  claim := .notSkeptical ⟨.apostolic, by decide⟩ ⟨.jervell, by decide⟩
    (Witness.listSub _
      [.critics, .dominical, .gospel, .jervell, .lexical, .pauline, .romansOnTheWord])
  checked := by decide +kernel

/-- **Nor from Peter.** A consistent set of positions that answers every attack
holds Jervell's reading of Acts 15, on which the yoke is not the law as a
condition of salvation, and cannot hold Peter's case with it.

So without Trent it is forced that faith suffices (Luke) and that justification
is not renewal (Paul's gospel). *Faith alone* still depends on questions about
what the texts say: "faith of Christ", "works of the law", the yoke, and, for
John, what believing is (`sola_fide_from_john_not_forced_without_trent`). -/
@[headline]
theorem sola_fide_from_peter_not_forced_without_trent :
    ¬ SkepticallyAccepted withoutTrent.defeats ⟨.apostolic, by decide⟩ :=
  peterAnsweredByJervell.holds

#print axioms sola_fide_from_peter_not_forced_without_trent

/-- Why John's case is not forced without Trent: a set of positions that can be
defended includes Aquinas, who defeats it over what believing is. -/
def johnAnsweredByAquinas : Verdict withoutTrent where
  finite := withoutTrentFinite
  claim := .notSkeptical ⟨.johannine, by decide⟩ ⟨.aquinas, by decide⟩
    (Witness.listSub _ [.aquinas, .dominical, .gospel, .lexical, .romansOnTheWord])
  checked := by decide +kernel

/-- **Nor from John.** Remove both of Trent's parties from the hearing: its
case, and its definition read as a claim about Paul's word. Aquinas remains, and
Trent describes justifying faith as he does: the believing Jesus names in John
6:29 is faith formed by charity, not bare trust. A reader can hold Aquinas's
reading consistently and answer every objection raised here. John's case cannot
be held with it.

What this claims: without the Council, John 6:29 still does not compel faith
alone, because what believing is remains contested. What it does not claim: that
Aquinas's reading wins. John's case can be held just as consistently. Luther's
argument and Aquinas's each defeat the other, and neither is removed. -/
@[headline]
theorem sola_fide_from_john_not_forced_without_trent :
    ¬ SkepticallyAccepted withoutTrent.defeats ⟨.johannine, by decide⟩ :=
  johnAnsweredByAquinas.holds

#print axioms sola_fide_from_john_not_forced_without_trent

end TestimonyArguments.SolaFide
