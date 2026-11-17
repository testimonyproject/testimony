import Testimony.Logic.Declare
import TestimonyArguments.Meanings.SolaScriptura
import TestimonyArguments.SolaScriptura.Results

/-!
# TestimonyArguments.SolaScriptura.Canon — how the canon is recognised

The canon objection asks who told us which books are Scripture. Augustine's
answer is the one Rome has given since: he would not believe the gospel, he
says, unless the authority of the Catholic Church moved him to. If the Church's
authority is what identifies Scripture, and that identification must be
infallible, then Scripture is not the only infallible rule. The chapter
"Three objections, and the answers to them" gives Kruger's reply, which grants
the Church's reception and answers that every final authority vouches for
itself.
That reply defends the Protestant position and gains it nothing. The reply in
this chapter goes further. It denies that identifying the canon needs an
infallible authority at all.

## Tests Scripture sets

Israel had to tell God's word from a counterfeit long before there was a
Church. Moses gave two tests. The first is agreement with what God has already
said: "If there arise among you a prophet, or a dreamer of dreams, and giveth
thee a sign or a wonder, And the sign or the wonder come to pass, whereof he
spake unto thee, saying, Let us go after other gods, which thou hast not known,
and let us serve them; Thou shalt not hearken unto the words of that prophet"
(Deuteronomy 13:1–3, KJV). The second is whether the word comes true: "And if
thou say in thine heart, How shall we know the word which the LORD hath not
spoken? When a prophet speaketh in the name of the LORD, if the thing follow
not, nor come to pass, that is the thing which the LORD hath not spoken"
(18:21–22). Neither test sends the hearer to an office that cannot err. Each
gives the hearer something to check.

## Books the Church read and did not receive

The early Church drew a line between books it read and books it received as
Scripture, and it said why. The Muratorian fragment, an early list of the New
Testament books whose date is disputed (the late second century or the fourth),
says of the Shepherd of Hermas that he wrote it "very recently in our
times in the city of Rome ... And therefore it also ought to be read; but it
cannot be made public in the Church to the people, nor placed among the
prophets, as their number is complete, nor among the apostles". Athanasius, in
his Festal Letter of 367, lists the books of both Testaments and calls them
"fountains of salvation ... Let no man add to these". He then names "other books
besides these not indeed included in the Canon, but appointed by the Fathers to
be read by those who newly join us", among them "that which is called the
Teaching of the Apostles" (the Didache) "and the Shepherd". The reasons are ones
a reader can weigh: when a book was written, whether it came from the apostles'
time, what had been handed down.

So the reply runs: Scripture itself gives tests for a word that claims to come
from God, and the Church set books apart by reasons it stated; so identifying
the canon is a matter of recognising what God gave, by tests, and needs no
infallible authority to do it.

## Rome's answer

Both sides agree that the Church recognises the canon and does not make it.
The First Vatican Council says the Church holds the books "sacred and canonical
not because she subsequently approved them by her authority after they had been
composed by unaided human skill, nor simply because they contain revelation
without error, but because, being written under the inspiration of the holy
Spirit, they have God as their author" (*Dei Filius*, ch. 2). What divides them
is whether the recognition must be infallible.

George Reid, writing in the *Catholic Encyclopedia* in 1908, grants the tests
and the history and denies that they reach far enough. He calls apostolic
origin "a positive and partial touchstone of inspiration", and tells how the
Shepherd and the Didache were set apart under Athanasius. Then he answers the
reply directly. Inspiration "is not self-evident", and so "Its sole absolute
criterion, therefore, is the Holy inspiring Spirit, witnessing decisively to
Itself, not in the subjective experience of individual souls, as Calvin
maintained, neither in the doctrinal and spiritual tenor of Holy Writ itself,
according to Luther, but through the constituted organ and custodian of Its
revelations, the Church. All other evidences fall short of the certainty and
finality necessary to compel the absolute assent of faith." Augustine's own
rule for the canon is reception, not agreement: prefer the books "received by
all the Catholic churches" (*On Christian Doctrine* II.8.12). Because Reid
grants the reply's grounds and denies its conclusion, the step from one to the
other is rated `disputed`.

Two Protestant scholars press on the reply from the other side, without denying
what it concludes. Michael Kruger criticises the appeal to criteria of
canonicity, while granting that it has "rightly focused on apostolicity as a key
component of canonicity". Orthodoxy alone cannot pick out the canon, because the
Shepherd was orthodox too, and apostolic origin is the Muratorian fragment's
reason for setting it apart. Lee Martin McDonald finds that the Fathers
"employed several criteria, often unequally". And not everyone drew the line
in the same place: Irenaeus quotes the Shepherd as "the Scripture". Moses' tests
rule a word out. They do not, by themselves, rule a book in.

## What the checks show

Granted its grounds, the reply delivers what it claims: identifying the canon
does not require an infallible authority (`canon_tests_deny_the_ground`). It
does not, on its own, deliver sola scriptura: with the tests granted, Scripture
may be the sole infallible rule or not, and the reply does not choose
(`canon_tests_leave_the_sole_rule_open`).

Weighed against the objection, the reply and the objection each defeat the
other. Each contradicts something the other rests on, and each rests at its
weakest on a link rated `disputed`. The objection rests on the claim that
identifying the canon needs an infallible authority, cited to Trent, and on its
own step, which Kruger denies; the reply rests on its step, which Reid denies.
No rating breaks the tie, so the dispute forces neither
(`canon_dispute_forces_nothing`), and each can be defended
(`canon_tests_defensible`, `canon_objection_defensible`). The reply answers the
objection; it does not defeat it outright. What would move the verdict is a
ground for one side's weakest link that does better than `disputed`.
-/

namespace TestimonyArguments.SolaScriptura

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! #### How the reply is built

The reply is a line of its own, with its own step, because it *denies* the
objection's ground rather than refusing it: it delivers the negation of the
claim that identifying the canon needs an infallible authority. A denial is an
attack, so the reply and the objection can be weighed in a dispute. -/

/-- If Scripture tests a word that claims to come from God, by what it says
and by whether it comes to pass, and the early Church set apart books it read
for reasons it stated, then identifying the canon does not require an
infallible authority. -/
@[solaScripturaDefs]
def canonTestsStep : Formula Claim :=
  ⋀ [ p .deut13_1_3ProphetOfOtherGods
    , p .deut18_20_22WordNotFulfilled
    , p .booksReadButNotReceived ] ➝ notP .identifyingCanonRequiresInfallibleAuthority

/-- **The canon recognised by Scripture's tests.** -/
@[solaScripturaDefs]
def canonTestsLine : Line Claim :=
  { name := "The canon recognised by Scripture's tests"
  , grounds :=
      [ p .deut13_1_3ProphetOfOtherGods
      , p .deut18_20_22WordNotFulfilled
      , p .booksReadButNotReceived ]
  , step := canonTestsStep
  , delivers := notP .identifyingCanonRequiresInfallibleAuthority
  , inference := some canonTestsInference }

/-- The reply as an argument of its own. -/
@[solaScripturaDefs]
def canonTestsReply : ArgumentPackage Claim :=
  canonTestsLine.asPackage cite
    "identifying the canon does not require an infallible authority"

/-! #### What it shows -/

/-- **The reply denies the canon objection's ground.** Granted Moses' two tests
(Deuteronomy 13:1–3 and 18:20–22) and the early Church's setting apart of
books it read but did not receive, identifying the canon does not require an
infallible authority.

What this does not claim: that the grounds are enough. The step from them is
rated `disputed`, because Reid grants them and denies the conclusion. -/
@[headline]
theorem canon_tests_deny_the_ground : Establishes canonTestsReply := by
  establish [solaScripturaDefs]

#print axioms canon_tests_deny_the_ground

/-- The reply's premises have a model: Kruger's reading, on which no infallible
authority is needed to identify the canon and every other claim holds. -/
theorem canonTestsReply_is_satisfiable : Satisfiable canonTestsReply.premises := by
  satisfied_by krugerParityReading [solaScripturaDefs]

/-- The reading on which the tests are granted, no infallible authority is
needed to identify the canon, and Scripture is still not the sole infallible
rule. -/
def testsWithoutSoleRuleReading : Valuation Claim := fun a =>
  match a with
  | .identifyingCanonRequiresInfallibleAuthority => False
  | .scriptureIsSoleInfallibleRule => False
  | _ => True

/-- **The reply leaves the sole rule open.** Granted the reply's grounds,
Scripture may be the sole infallible rule or not: Kruger's reading has it, and
a reading that grants the tests and still denies the sole rule has it not. Both
satisfy every premise.

So the reply clears a ground the objection needed, and establishes nothing more
by itself. The case for sola scriptura is made elsewhere in the argument. -/
@[headline]
theorem canon_tests_leave_the_sole_rule_open :
    Independent canonTestsLine.premises (p .scriptureIsSoleInfallibleRule) := by
  leaves_open testsWithoutSoleRuleReading krugerParityReading [solaScripturaDefs]

#print axioms canon_tests_leave_the_sole_rule_open

/-! ### The dispute -/

/-- The parties to the dispute over the canon. -/
inductive CanonParty
  /-- The canon objection. -/
  | objection
  /-- The reply from Scripture's tests. -/
  | tests
deriving DecidableEq

/-- The package each party argues from. -/
@[solaScripturaDefs]
def canonPartyNode : CanonParty → ArgumentPackage Claim
  | .objection => canonObjection
  | .tests => canonTestsReply

/-- The dispute over the canon: the objection, and the reply from Scripture's
tests. Every party's premises have a model, every party establishes its
conclusion, and every party's inferences are rated. -/
declare_dispute canonDispute := canonPartyNode using solaScripturaDefs
  /-- **Who defeats whom**, all four pairs. The objection and the reply defeat
  each other, and nothing else defeats anything. The reply denies the
  objection's claim that identifying the canon needs an infallible authority,
  and the objection, holding that claim, denies what the reply concludes. Both
  rest at their weakest on a link rated `disputed`, so neither attack is
  outweighed.

  Every cell is computed from the parties' premises by `Horn.defeats?` and
  checked by the kernel. -/
  defeats [(.objection, .tests), (.tests, .objection)]
  /-- **Nothing supports anything**: neither party's conclusion is a claim the
  other rests on. Computed by `supports?` and checked by the kernel. -/
  supports []
  /-- **Neither case is part of the other**, and each is part of itself.
  Computed by `partOf?` and checked by the kernel. -/
  partOf []
  /-- The dispute over the canon drawn: the objection and the reply, each
  defeating the other. -/
  map canonMap

/-! ### What the dispute decides -/

/-- Why nothing is forced: the objection has the reply as a defeater, and the
reply has the objection. -/
declare_verdict canonSettlesNothing for canonDispute :
    .nothingGrounded [(.objection, .tests), (.tests, .objection)]
  /-- **The dispute over the canon forces neither side.** The objection and the
  reply are in a standoff, and both rest on a link rated `disputed`, so no
  rating breaks the tie.

  What this does not claim: that the two are equally good arguments. It claims
  that, on the ratings the sources support, neither is shown to outweigh the
  other. -/
  proves @[headline] canon_dispute_forces_nothing

#print axioms canon_dispute_forces_nothing

/-- Why the reply can be defended: it answers the objection, its only
attacker, itself. -/
declare_verdict canonTestsStandAlone for canonDispute :
    .credulous .tests [.tests]
  /-- **The reply from Scripture's tests can be defended.** A defensible
  position holds it: the one party that defeats it, the objection, it defeats
  back. So the canon objection does not refute sola scriptura on this ground. -/
  proves @[headline] canon_tests_defensible

#print axioms canon_tests_defensible

/-- Why the objection can be defended: it answers the reply, its only attacker,
itself. -/
declare_verdict canonObjectionStandsAlone for canonDispute :
    .credulous .objection [.objection]
  /-- **The canon objection can be defended too.** A defensible position holds
  it, because it defeats the reply back. Read with the verdict before it: each
  side has an answer to the other, and the dispute does not choose. -/
  proves @[headline] canon_objection_defensible

#print axioms canon_objection_defensible

end TestimonyArguments.SolaScriptura
