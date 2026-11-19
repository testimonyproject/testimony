import TestimonyArguments.SolaScriptura.Sources

/-!
# TestimonyArguments.SolaScriptura.Lines — three objections, and the answers to them

Three routes are encoded to the conclusion that Scripture is the sole
infallible rule. The classical line reads Scripture as "God-breathed" and able
to make the believer "thoroughly equipped for every good work" (2 Timothy
3:16–17), sufficient and clear, and holds that Scripture teaches the principle
itself. The eliminative line holds that Scripture is infallible and that no
other rule is. Mark 7's line is taken in its own chapter. Against them stand
three objections, and they come from different directions, so that answering one
does not answer another.

**Self-refutation.** If a doctrine binds only when Scripture teaches it, and
Scripture does not teach sola scriptura, the position fails by its own
standard.

**The canon.** If the canon is known through the Church's reception of it, an
authority outside Scripture is needed to identify Scripture. Augustine gives
the classical form: *ego vero Evangelio non crederem, nisi me catholicae
Ecclesiae commoveret auctoritas*. He would not believe the gospel, he says,
unless the authority of the Catholic Church moved him to. The chapter
"How the canon is recognised" takes a reply that denies that identifying the
canon needs an infallible authority outside Scripture, from the tests Scripture
itself sets.

**The regress of interpretive authority.** Cross and Judisch argue that the
individual keeps the final authority to interpret, exercised indirectly by
choosing which body to submit to. So Tradition I, which gives tradition a real
but subordinate authority, is not distinct in principle from Tradition 0: "when
I submit (so long as I agree), the one to whom I submit is me."

These objections tell against the position this argument sets out, and they
are encoded with the same care, because the project's rules require every
rival to be.

## Does Scripture have to teach the principle?

The first version of this argument said that the whole dispute reduces to one
premise, that Scripture teaches sola scriptura
(`solaScripturaIsTaughtByScripture`). That premise does two jobs, and the jobs
come apart. It is not needed to reach the conclusion, because the eliminative
line delivers the sole rule without it (`hinge_not_load_bearing_for_conclusion`).
It is needed within the classical line taken alone.

Against self-refutation it is one of *two* answers. The objection joins two
grounds, so either may be denied. The classical answer denies that Scripture
fails to teach the principle (`classical_answer_blocks_self_refutation`). The
other denies that the rule about what binds governs a claim about where binding
doctrine comes from (`scoping_blocks_self_refutation`). That is the
final-arbiter reading, on which Scripture is not the only arbiter but the last
one. The objection succeeds only against a position that refuses both.

A second route to the conclusion does not help here, and this is where the
argument parts from sola fide. There, a second strand defeated an attack on a
premise. These objections are not attacks on a premise: each delivers the
denial of the conclusion by itself, so another route to the conclusion does
nothing against them. What answers an objection is denying one of *its*
grounds.

## Parity: "your side has the same problem"

Kruger on the canon and Mathison on interpretive authority make the same move.
They concede the circle, and deny that it tells against one side more than the
other. What the move achieves is that the disputed question comes out
*independent* of the reply's grounds: neither it nor its denial follows,
because two readings satisfy those grounds and disagree about it
(`parity_leaves_the_canon_open`, `parity_leaves_the_distinction_open`). The
replies block the objection, and establish nothing.

Blocking an objection and establishing nothing are one fact here, stated once
for each reply, so the two halves cannot drift apart into different questions.
Barrett's parity reply to Geisler gets the same treatment: the defeat Geisler
claims is left open (`parity_leaves_the_defeat_open`). The reply also does more
than fail to clear the charge of circularity. It grants the charge as one of
its own grounds (`circle_parity_concedes_the_charge`).

## The circle inside Protestantism

Geisler, who holds Tradition 0, charges Tradition I with a circle. The creedal
consensus is said to rest on Scripture's clarity, while Scripture's clear sense
is said to be unobtainable without that consensus. With both legs in place,
neither end is settled either way (`circle_leaves_the_consensus_open`,
`circle_leaves_the_perspicuity_open`). A circle of claims can be held all true
or all false with nothing to choose between them. That charge is made from
inside the Reformation, against the position this argument encodes as the
Protestant one. It is conditional like every result here: deny either leg and
the circle is not there.

## A limitation worth stating

The final-arbiter reading turns on a distinction between **doctrine**, which
needs Scripture to settle it, and **practice** neither commanded nor forbidden,
which does not. That is a distinction of scope, and the logic used here cannot
express one: it works with whole claims, and cannot say "for every doctrine".
So the distinction is carried by how the claims are drawn and by this
paragraph, not by the logic. What the encoding shows is what follows given the
distinction, not that the distinction can be drawn.
-/

/-!
#### How the lines are built

Three routes reach the conclusion — the classical line, the eliminative line,
and Mark 7's, which takes two lines, and whose principle a further line draws
from Jesus' sayings and Paul's letters — three positions deny it, and three
objections attack it from different directions. Two more lines read the council
at Jerusalem (Acts 15), one as the Reformers read it and one as Rome does, and
they deliver opposite answers about the authority of councils. Each rests on a
line about the apostles' office: that it ended with them, or that it continues
in their successors. Two more read Moses' seat (Matthew 23:2–3) the same two
ways, and deliver opposite answers about the teaching office.

Every reply below is written with `Line.onGrounds`: the objection's own line,
with the ground the reply refuses put back as what the reply offers instead.
-/

namespace TestimonyArguments.SolaScriptura

open Testimony

open Testimony Testimony.Logic

/-! #### Steps reaching the conclusion -/

/-- Sufficiency and perspicuity, with the prooftexts and the claim that
scripture teaches the principle, yield the sole infallible rule. -/
@[solaScripturaDefs]
def toSoleRule : Formula Claim :=
  ⋀ [ p .timothy3_16GodBreathed, p .timothy3_17ThoroughlyEquips
    , p .scriptureIsSufficient, p .scriptureIsPerspicuous
    , p .solaScripturaIsTaughtByScripture ] ➝ p .scriptureIsSoleInfallibleRule

/-- The eliminative route: scripture is infallible, nothing else is, so
scripture is the *sole* infallible rule. It never asserts that scripture
teaches the principle. -/
@[solaScripturaDefs]
def eliminativeToSoleRule : Formula Claim :=
  ⋀ [p .scriptureIsInfallible, p .noOtherRuleIsInfallible] ➝ p .scriptureIsSoleInfallibleRule

/-- **Mark 7's step**: from Jesus' rebuke of the elders' tradition to the
principle it enacts — God's word judges human tradition. Rated `wellSupported`:
no reader was found who grants the text and denies the principle, and Rome
grants it in so many words (*Dei Verbum* 10). Not `consensus`, because the step
generalises from one pericope. -/
@[solaScripturaDefs]
def mark7ToPrinciple : Formula Claim :=
  p .mark7TraditionCanNullify ➝ p .godsWordJudgesTradition

/-- **The same principle from Jesus' sayings and Paul's letters**, without Mark 7.
Jesus says that "the Scripture cannot be broken" (John 10:35) and that "not the
smallest letter or stroke shall pass from the Law" (Matthew 5:18); Paul says
that even he, or an angel, would be accursed for proclaiming "a gospel contrary
to the gospel we have proclaimed" (Galatians 1:8–9), and warns a church against
teaching "according to the tradition of men … and not according to Christ"
(Colossians 2:8, 20–22). Together they say what Mark 7 says: God's word judges
human tradition. Rated `wellSupported`: Aquinas grants Galatians 1:8 and the
principle with it, and denies only that every addition is "another gospel"
(`jesusAndPaulPrincipleInference`). -/
@[solaScripturaDefs]
def jesusAndPaulToPrinciple : Formula Claim :=
  ⋀ [ p .john10_35ScriptureCannotBeBroken, p .matthew5_18LawShallNotPass
    , p .galatians1_8AnotherGospelAccursed, p .colossians2_8TraditionOfMen ]
  ➝ p .godsWordJudgesTradition

/-- **Acts 15, as the Reformers read it.** Men from Judaea laid the custom of
Moses on the gentiles as a condition of salvation (15:1); Peter answered with
the gospel, salvation "through the grace of the Lord Jesus" (15:10–11), and
James with Scripture, "just as it is written" (15:15–17). So the gospel judged
even the oldest tradition, and the council judged by Scripture. And the
apostles' own office ended with them, so a council after them lacks what the
council at Jerusalem had: it binds only as far as it agrees with the word, and
may err. The last premise is carried in by `apostlesOfficeEndedLine`. Rated
`disputed`: Wilhelm grants the texts and holds that general councils define with
the Spirit's authority (`acts15ReformedInference`). -/
@[solaScripturaDefs]
def acts15ToCouncilUnderScripture : Formula Claim :=
  ⋀ [ p .acts15_1CircumcisionAfterMoses, p .acts15_10_11YokeAndGrace
    , p .acts15_15_17ProphetsAgree, p .apostlesOfficeEndedWithThem ]
  ➝ notP .councilBindsWithTheSpiritsAuthority

/-- **Acts 15, as Rome reads it.** The council's letter says "it seemed good to
the Holy Spirit and to us" (15:28), and its decrees were delivered to the
churches "for them to keep" (16:4). The council was "the apostles and elders"
(15:6, 22–23; 16:4), and the apostles' office did not end with them but
continues in those who succeed them. So a general council binds with the
Spirit's authority, and cannot err. The last premise is carried in by
`apostolicSuccessionLine`. Rated `disputed`: the Westminster Confession cites
the same texts for the authority of councils and denies that councils since the
apostles cannot err (`acts15RomanInference`). -/
@[solaScripturaDefs]
def acts15ToCouncilWithTheSpirit : Formula Claim :=
  ⋀ [ p .acts15_28SeemedGoodToTheHolyGhost, p .acts16_4DecreesDelivered
    , p .acts15ApostlesAndElders, notP .apostlesOfficeEndedWithThem ]
  ➝ p .councilBindsWithTheSpiritsAuthority

/-- **The apostles' office, as the Reformers read it.** The apostle chosen in
Judas's place had to be one who had "accompanied us all the time" and was "a
witness with us of His resurrection" (Acts 1:21–22); Paul was the last to see
the risen Christ, "last of all ... He appeared to me also" (1 Corinthians 15:8);
Peter counts Paul's letters with "the rest of the Scriptures" (2 Peter 3:15–16);
and Paul writes as "an apostle" beside "Timothy our brother" (2 Corinthians 1:1;
Colossians 1:1). So the apostles' own office ended with them. Rated `disputed`:
*Lumen Gentium* 20 grants the texts and holds that the apostles' office is
permanent in the order of bishops (`apostlesOfficeEndedInference`). -/
@[solaScripturaDefs]
def apostlesToTheirOfficeEnded : Formula Claim :=
  ⋀ [ p .acts1_21_22WitnessOfResurrection, p .corinthians15_8LastOfAll
    , p .peter3_15_16PaulsEpistlesWithTheScriptures, p .salutationsApostleAndBrother ]
  ➝ p .apostlesOfficeEndedWithThem

/-- **The apostles' office, as Rome reads it.** "Let another man take his office
(ἐπισκοπή)" (Acts 1:20); "entrust these to faithful men who will be able to
teach others also" (2 Timothy 2:2); and Clement records that the apostles
appointed bishops and deacons, with instructions that "other approved men should
succeed them in their ministry" (1 Clement 44). So the apostles' office did not
end with them. Rated `disputed`: Calvin grants the texts and holds that the
apostolic office was not "instituted in the Church to be perpetual"
(`apostolicSuccessionInference`). -/
@[solaScripturaDefs]
def successionToTheOfficeContinuing : Formula Claim :=
  ⋀ [ p .acts1_20BishoprickLetAnotherTake, p .timothy2_2CommitToFaithfulMen
    , p .clement42_44SuccessorsAppointed ]
  ➝ notP .apostlesOfficeEndedWithThem

/-- **Moses' seat, as the Reformers read it.** Jesus bids the crowd do and keep
what the scribes and Pharisees tell them, because they sit in "the chair of
Moses" (Matthew 23:2–3); in the same discourse he condemns their teaching on
oaths as the teaching of "blind guides" (23:16–22), and in Mark 7 the elders'
tradition as making void the word of God. So the seat binds only so far as Moses
is taught from it: an office in the Church is heard as far as it teaches God's
word, and not for the seat alone. Rated `disputed`: Cornelius a Lapide grants
the texts and holds that the scribes were to be obeyed in all "not contrary to
Moses and the Law" (`mosesSeatReformedInference`). -/
@[solaScripturaDefs]
def mosesSeatToTheWordTaught : Formula Claim :=
  ⋀ [ p .matthew23_2_3MosesSeat, p .matthew23_16_22BlindGuides
    , p .mark7TraditionCanNullify ]
  ➝ notP .teachingOfficeHeardByItsSeat

/-- **Moses' seat, as Rome reads it.** Jesus bids the crowd do and keep what
those in Moses' chair tell them, though "they say things and do not do them"
(Matthew 23:2–3). So the seat carries an authority of teaching that passes to
those who succeed to it, and in the Church those who hold the teaching office
are heeded for the seat they hold, in what is not contrary to God's law, even
when they live ill. Rated `disputed`: Calvin grants the text and holds that the
scribes were to be obeyed "only so far as they adhere to the pure and simple
exposition of the Law" (`mosesSeatRomanInference`). -/
@[solaScripturaDefs]
def mosesSeatToTheOffice : Formula Claim :=
  p .matthew23_2_3MosesSeat ➝ p .teachingOfficeHeardByItsSeat

/-- What the principle says of a commandment of men: it may not be bound on the
Church as God's word. This is Isaiah 29:13 as Mark 7:7 quotes it. -/
@[solaScripturaDefs]
def principleExcludesMensCommandments : Formula Claim :=
  p .godsWordJudgesTradition ➝ notP .mensCommandmentBindsAsGodsWord

/-- **From Mark 7's principle to the sole rule.** If God's word judges human
tradition, and no unwritten tradition can now be shown to be apostolic, so that
none binds as God's word, Scripture is the sole infallible rule. Rated
`disputed`: Geiselmann holds that Scripture contains all revealed content and,
as a Catholic after Vatican I, keeps the Magisterium as its infallible
interpreter; Florovsky holds that tradition adds nothing to
Scripture and keeps the mind of the Church as its interpreter. Neither adds a
word to Scripture; both deny it is the *sole* infallible rule. -/
@[solaScripturaDefs]
def principleToSoleRule : Formula Claim :=
  ⋀ [p .godsWordJudgesTradition, p .noUnwrittenTraditionShownApostolic]
  ➝ p .scriptureIsSoleInfallibleRule

/-- Geisler's route: the historical-grammatical method suffices, so creeds may
inform without binding, and no second infallible rule is needed. -/
@[solaScripturaDefs]
def tradition0ToSoleRule : Formula Claim :=
  ⋀ [ p .historicalGrammaticalMethodSuffices, p .creedsAreInformativeNotNormative
    , p .scriptureIsInfallible, p .noOtherRuleIsInfallible ] ➝ p .scriptureIsSoleInfallibleRule

/-! #### Steps denying it -/

/-- **Tradition II.** Binding unwritten tradition as a coordinate source denies
that scripture is the sole rule. -/
@[solaScripturaDefs]
def tridentineDeniesSoleRule : Formula Claim :=
  ⋀ [ p .thessalonians2_15TraditionBinding
    , p .traditionIsCoordinateSourceOfRevelation ] ➝ notP .scriptureIsSoleInfallibleRule

/-- **Tradition III.** An infallible magisterium is a second infallible rule,
whatever is said about sources. -/
@[solaScripturaDefs]
def magisterialDeniesSoleRule : Formula Claim :=
  p .magisteriumIsInfallible ➝ notP .scriptureIsSoleInfallibleRule

/-- **Orthodoxy.** The mind of the Church interpreting infallibly is likewise a
second infallible rule — and it is not the magisterial premise. -/
@[solaScripturaDefs]
def orthodoxDeniesSoleRule : Formula Claim :=
  p .churchMindIsInfallibleInterpreter ➝ notP .scriptureIsSoleInfallibleRule

/-! #### The three objections -/

/-- If a doctrine binds only when scripture teaches it, and scripture does not
teach sola scriptura, then sola scriptura does not bind. -/
@[solaScripturaDefs]
def selfRefutationStep : Formula Claim :=
  ⋀ [p .onlyScripturalDoctrineIsBinding, notP .solaScripturaIsTaughtByScripture]
  ➝ notP .scriptureIsSoleInfallibleRule

/-- If the canon is known only through the Church's reception, and identifying
the canon requires an infallible authority outside scripture, then scripture
is not the sole infallible rule. -/
@[solaScripturaDefs]
def canonObjectionStep : Formula Claim :=
  ⋀ [ p .canonKnownThroughChurchReception
    , p .identifyingCanonRequiresInfallibleAuthority ] ➝ notP .scriptureIsSoleInfallibleRule

/-- Cross and Judisch: if the individual retains ultimate interpretive
authority, exercised indirectly by choosing the body to submit to, then
Tradition I's ministerial authority is not a principled difference from
Tradition 0. -/
@[solaScripturaDefs]
def interpretiveRegressStep : Formula Claim :=
  ⋀ [ p .traditionHasMinisterialAuthority
    , p .individualRetainsUltimateInterpretiveAuthority ]
  ➝ notP .traditionIDiffersInPrincipleFromTradition0

/-! #### Geisler's circle

Two legs, each supplying the other's ground. The consensus of the Church is
said to rest on the clarity of scripture, while the clear sense of scripture is
said to require the consensus of the Church. -/

/-- Leg one: the creedal consensus rests on scripture's clarity. -/
@[solaScripturaDefs]
def consensusRestsOnPerspicuity : Formula Claim :=
  p .scriptureIsPerspicuous ➝ p .creedalConsensusIsHermeneuticallyNecessary

/-- Leg two: scripture's clear sense is not obtainable without that
consensus. -/
@[solaScripturaDefs]
def perspicuityRestsOnConsensus : Formula Claim :=
  p .creedalConsensusIsHermeneuticallyNecessary ➝ p .scriptureIsPerspicuous

/-! #### The lines -/

/-- **The classical Protestant line**, running through the claim that scripture
teaches the principle. -/
@[solaScripturaDefs]
def classicalLine : Line Claim :=
  { name := "Classical (scripture teaches the principle)"
  , grounds :=
      [ p .timothy3_16GodBreathed, p .timothy3_17ThoroughlyEquips
      , p .scriptureIsSufficient, p .scriptureIsPerspicuous
      , p .solaScripturaIsTaughtByScripture ]
  , step := toSoleRule
  , delivers := p .scriptureIsSoleInfallibleRule
  , inference := some classicalInference }

/-- **The eliminative line**, which reaches the conclusion without the hinge. -/
@[solaScripturaDefs]
def eliminativeLine : Line Claim :=
  { name := "Eliminative (nothing else is infallible)"
  , grounds := [p .scriptureIsInfallible, p .noOtherRuleIsInfallible]
  , step := eliminativeToSoleRule
  , delivers := p .scriptureIsSoleInfallibleRule
  , inference := some eliminativeInference }

/-- **Mark 7**, as a line of its own: Jesus' rebuke of the elders' tradition,
and the principle it enacts. It delivers the principle, and no more. -/
@[solaScripturaDefs]
def mark7Line : Line Claim :=
  { name := "Mark 7 (God's word judges human tradition)"
  , grounds := [p .mark7TraditionCanNullify]
  , step := mark7ToPrinciple
  , delivers := p .godsWordJudgesTradition
  , inference := some mark7PrincipleInference }

/-- **From Mark 7 to the sole rule**: the principle, with the premise that no
unwritten tradition can now be shown to be apostolic. The principle is carried
in by `mark7Line`, or by `jesusAndPaulLine`; this line's own ground is the one
Rome denies. -/
@[solaScripturaDefs]
def mark7SoleRuleLine : Line Claim :=
  { name := "From Mark 7's principle to the sole rule"
  , grounds := [p .noUnwrittenTraditionShownApostolic]
  , step := principleToSoleRule
  , delivers := p .scriptureIsSoleInfallibleRule
  , inference := some principleToSoleRuleInference }

/-- **Jesus and Paul**, as a line of their own: the same principle as Mark 7's,
from John 10:35, Matthew 5:18, Galatians 1:8–9 and Colossians 2:8, 20–22. It
delivers the principle, and no more: what it adds is that the principle does not
rest on one passage. -/
@[solaScripturaDefs]
def jesusAndPaulLine : Line Claim :=
  { name := "Jesus and Paul (God's word judges human tradition)"
  , grounds :=
      [ p .john10_35ScriptureCannotBeBroken, p .matthew5_18LawShallNotPass
      , p .galatians1_8AnotherGospelAccursed, p .colossians2_8TraditionOfMen ]
  , step := jesusAndPaulToPrinciple
  , delivers := p .godsWordJudgesTradition
  , inference := some jesusAndPaulPrincipleInference }

/-- **Acts 15, the Reformed reading**, as a line of its own: the demand of 15:1,
answered by Peter's gospel (15:10–11) and James's "as it is written" (15:15–17).
With the apostles' office ended, which `apostlesOfficeEndedLine` carries in, it
delivers that a council after the apostles does not bind with the Spirit's own
authority: it binds as far as it agrees with Scripture. -/
@[solaScripturaDefs]
def acts15ReformedLine : Line Claim :=
  { name := "Acts 15, the Reformed reading (the council judged by Scripture)"
  , grounds :=
      [ p .acts15_1CircumcisionAfterMoses, p .acts15_10_11YokeAndGrace
      , p .acts15_15_17ProphetsAgree ]
  , step := acts15ToCouncilUnderScripture
  , delivers := notP .councilBindsWithTheSpiritsAuthority
  , inference := some acts15ReformedInference }

/-- **Acts 15, Rome's reading**, as a line of its own: "it seemed good to the
Holy Spirit and to us" (15:28), the decrees delivered to keep (16:4), and the
council of "the apostles and elders" (15:6, 22–23). With the apostles' office
continuing, which `apostolicSuccessionLine` carries in, it delivers that a
general council binds with the Spirit's authority. -/
@[solaScripturaDefs]
def acts15RomanLine : Line Claim :=
  { name := "Acts 15, Rome's reading (the council binds with the Spirit's authority)"
  , grounds :=
      [ p .acts15_28SeemedGoodToTheHolyGhost, p .acts16_4DecreesDelivered
      , p .acts15ApostlesAndElders ]
  , step := acts15ToCouncilWithTheSpirit
  , delivers := p .councilBindsWithTheSpiritsAuthority
  , inference := some acts15RomanInference }

/-- **The apostles' office ended**, as a line of its own: Acts 1:21–22, 1
Corinthians 15:8, 2 Peter 3:15–16, and Paul's salutations. It delivers that the
apostles' own office ended with them. -/
@[solaScripturaDefs]
def apostlesOfficeEndedLine : Line Claim :=
  { name := "The apostles' office ended with them (Calvin)"
  , grounds :=
      [ p .acts1_21_22WitnessOfResurrection, p .corinthians15_8LastOfAll
      , p .peter3_15_16PaulsEpistlesWithTheScriptures, p .salutationsApostleAndBrother ]
  , step := apostlesToTheirOfficeEnded
  , delivers := p .apostlesOfficeEndedWithThem
  , inference := some apostlesOfficeEndedInference }

/-- **The apostles' office continues**, as a line of its own: Acts 1:20, 2 Timothy
2:2, and 1 Clement 42 and 44. It delivers that the apostles' office did not end
with them. -/
@[solaScripturaDefs]
def apostolicSuccessionLine : Line Claim :=
  { name := "The apostles' office continues in their successors (Lumen Gentium 20)"
  , grounds :=
      [ p .acts1_20BishoprickLetAnotherTake, p .timothy2_2CommitToFaithfulMen
      , p .clement42_44SuccessorsAppointed ]
  , step := successionToTheOfficeContinuing
  , delivers := notP .apostlesOfficeEndedWithThem
  , inference := some apostolicSuccessionInference }

/-- **Moses' seat, the Reformed reading**, as a line of its own: Matthew 23:2–3,
the "blind guides" of 23:16–22, and Mark 7. It delivers that an office in the
Church is not heeded for its seat alone: it is heard as far as it teaches God's
word. -/
@[solaScripturaDefs]
def mosesSeatReformedLine : Line Claim :=
  { name := "Moses' seat, the Reformed reading (heard as far as it teaches the word)"
  , grounds :=
      [ p .matthew23_2_3MosesSeat, p .matthew23_16_22BlindGuides
      , p .mark7TraditionCanNullify ]
  , step := mosesSeatToTheWordTaught
  , delivers := notP .teachingOfficeHeardByItsSeat
  , inference := some mosesSeatReformedInference }

/-- **Moses' seat, Rome's reading**, as a line of its own: Matthew 23:2–3. It
delivers that those who hold the Church's teaching office are heeded for the
seat they hold, in whatever is not contrary to God's law. -/
@[solaScripturaDefs]
def mosesSeatRomanLine : Line Claim :=
  { name := "Moses' seat, Rome's reading (the office heeded for its seat)"
  , grounds := [p .matthew23_2_3MosesSeat]
  , step := mosesSeatToTheOffice
  , delivers := p .teachingOfficeHeardByItsSeat
  , inference := some mosesSeatRomanInference }

/-- **Tradition 0**, as Geisler states it rather than as Mathison describes
it. -/
@[solaScripturaDefs]
def tradition0Line : Line Claim :=
  { name := "Tradition 0 (creeds informative, not normative)"
  , grounds :=
      [ p .historicalGrammaticalMethodSuffices, p .creedsAreInformativeNotNormative
      , p .scriptureIsInfallible, p .noOtherRuleIsInfallible ]
  , step := tradition0ToSoleRule
  , delivers := p .scriptureIsSoleInfallibleRule
  , inference := some tradition0Inference }

/-- **Tradition II**, the Tridentine two-source position. Its step is rated
`wellSupported`: once unwritten tradition is granted as a source of revelation
alongside Scripture, no reader was found who denies that Scripture is then not
the *sole* rule. Protestants deny the ground instead, and that dissent is
weighed in the ground's own rating. -/
@[solaScripturaDefs]
def tridentineLine : Line Claim :=
  { name := "Trent (Tradition II)"
  , grounds :=
      [ p .thessalonians2_15TraditionBinding
      , p .traditionIsCoordinateSourceOfRevelation ]
  , step := tridentineDeniesSoleRule
  , delivers := notP .scriptureIsSoleInfallibleRule
  , inference := some tridentineInference }

/-- **Tradition III**, resting on Vatican I rather than on Trent. -/
@[solaScripturaDefs]
def vaticanLine : Line Claim :=
  { name := "Tradition III (the magisterium as the one real source)"
  , grounds := [p .magisteriumIsInfallible]
  , step := magisterialDeniesSoleRule
  , delivers := notP .scriptureIsSoleInfallibleRule
  , inference := some vaticanInference }

/-- **The Orthodox line**, grounded on the mind of the Church. -/
@[solaScripturaDefs]
def orthodoxLine : Line Claim :=
  { name := "Orthodox (the mind of the Church)"
  , grounds := [p .churchMindIsInfallibleInterpreter]
  , step := orthodoxDeniesSoleRule
  , delivers := notP .scriptureIsSoleInfallibleRule
  , inference := some orthodoxInference }

/-- **The self-refutation objection.** -/
@[solaScripturaDefs]
def selfRefutationLine : Line Claim :=
  { name := "Self-refutation objection"
  , grounds :=
      [ p .onlyScripturalDoctrineIsBinding
      , notP .solaScripturaIsTaughtByScripture ]
  , step := selfRefutationStep
  , delivers := notP .scriptureIsSoleInfallibleRule
  , inference := some selfRefutationInference }

/-- **The canon objection.** -/
@[solaScripturaDefs]
def canonObjectionLine : Line Claim :=
  { name := "Canon objection"
  , grounds :=
      [ p .canonKnownThroughChurchReception
      , p .identifyingCanonRequiresInfallibleAuthority ]
  , step := canonObjectionStep
  , delivers := notP .scriptureIsSoleInfallibleRule
  , inference := some canonObjectionInference }

/-- **The interpretive-authority regress.** -/
@[solaScripturaDefs]
def interpretiveRegressLine : Line Claim :=
  { name := "Interpretive-authority regress"
  , grounds :=
      [ p .traditionHasMinisterialAuthority
      , p .individualRetainsUltimateInterpretiveAuthority ]
  , step := interpretiveRegressStep
  , delivers := notP .traditionIDiffersInPrincipleFromTradition0
  , inference := some interpretiveRegressInference }

/-! #### The replies, as substituted grounds

Each reply is the objection's own line with the ground it refuses replaced by
what the reply offers instead. Adding a premise could never block a valid
argument; taking away the ground it needed is what a reply actually does. -/

/-- The classical answer to self-refutation: scripture does teach the
principle. -/
@[solaScripturaDefs]
def selfRefutationUnderClassicalAnswer : Line Claim :=
  selfRefutationLine.onGrounds
    [p .onlyScripturalDoctrineIsBinding, p .solaScripturaIsTaughtByScripture]

/-- The final-arbiter answer: the bindingness rule governs first-order doctrine,
not a claim about where binding doctrine comes from. -/
@[solaScripturaDefs]
def selfRefutationUnderFinalArbiter : Line Claim :=
  selfRefutationLine.onGrounds
    [ p .bindingnessAppliesToFirstOrderDoctrineOnly
    , notP .solaScripturaIsTaughtByScripture ]

/-- Kruger's parity reply: the canon's reception is conceded, and what the
objection needed — that identifying it requires an *infallible* authority — is
replaced by the observation that the rival's authority is self-authenticating
too. -/
@[solaScripturaDefs]
def canonUnderParity : Line Claim :=
  canonObjectionLine.onGrounds
    [p .canonKnownThroughChurchReception, p .rivalAuthorityIsAlsoSelfAuthenticating]

/-- Mathison's parity reply: choosing Rome is itself an act of private
judgement, so private judgement does not separate the positions. -/
@[solaScripturaDefs]
def regressUnderParity : Line Claim :=
  interpretiveRegressLine.onGrounds
    [p .traditionHasMinisterialAuthority, p .choosingAnAuthorityIsItselfPrivateJudgment]

/-! #### Geisler's charge as an argument, and the replies to it

The cycle results above are a formal fact: a cycle of implications grounds
neither end. The line below is the *dialectical* fact — Geisler charging
circularity, and what answers the charge. They are different claims, and both
are worth having.

Every reply denies the second leg, that scripture's clear sense is unobtainable
without the consensus. Barrett's is the exception: it concedes the circle and
denies that circularity is a defect peculiar to Tradition I, which is why
`circleDefeatsLine` carries the universality claim as a ground of its own. -/

/-- Both legs together make the reasoning circular. -/
@[solaScripturaDefs]
def circleStep : Formula Claim :=
  ⋀ [ p .creedalConsensusRestsOnPerspicuity
    , p .perspicuityRequiresCreedalConsensus ] ➝ p .traditionIReasoningIsCircular

/-- Circularity defeats the position **if** it is not a feature of every appeal
to an ultimate authority. Geisler's charge needs the second conjunct, and it is
what Barrett denies. -/
@[solaScripturaDefs]
def circularityDefeats : Formula Claim :=
  ⋀ [ p .traditionIReasoningIsCircular
    , notP .everyUltimateAuthorityIsCircular ] ➝ p .circularityDefeatsTraditionI

/-- **Geisler's circularity charge.** -/
@[solaScripturaDefs]
def geislerCircleLine : Line Claim :=
  { name := "Geisler's circularity charge against Tradition I"
  , grounds :=
      [ p .creedalConsensusRestsOnPerspicuity
      , p .perspicuityRequiresCreedalConsensus ]
  , step := circleStep
  , delivers := p .traditionIReasoningIsCircular
  , inference := some circleInference }

/-- The charge pressed home: the circularity defeats the position. -/
@[solaScripturaDefs]
def circleDefeatsLine : Line Claim :=
  { name := "The circularity defeats Tradition I"
  , grounds :=
      [ p .traditionIReasoningIsCircular
      , notP .everyUltimateAuthorityIsCircular ]
  , step := circularityDefeats
  , delivers := p .circularityDefeatsTraditionI
  , inference := some circleDefeatsInference }

/-- **Allen and Swain's reply.** The consensus is established by and
accountable to scripture, so it is a product of reading scripture rather than a
precondition of it. -/
@[solaScripturaDefs]
def circleUnderAccountability : Line Claim :=
  geislerCircleLine.onGrounds
    [ p .creedalConsensusRestsOnPerspicuity
    , p .creedalConsensusIsDerivedFromScripture ]

/-- **The proposed reply.** Scripture itself bounds the interpretive office —
elders commended to the word (Acts 20:32), required to hold to it (Titus 1:9),
forbidden to domineer (1 Peter 5:2–3) — so the consensus's own warrant is read
off scripture, and perspicuity is in any case claimed only for what is
necessary for salvation. -/
@[solaScripturaDefs]
def circleUnderScripturalBounding : Line Claim :=
  geislerCircleLine.onGrounds
    [ p .creedalConsensusRestsOnPerspicuity
    , p .scriptureBoundsTheInterpretiveOffice
    , p .perspicuityIsLimitedToSalvationEssentials ]

/-- **Barrett's parity reply.** The circle is conceded; what is denied is that
it is peculiar to this position. -/
@[solaScripturaDefs]
def defeatUnderParity : Line Claim :=
  circleDefeatsLine.onGrounds
    [ p .traditionIReasoningIsCircular
    , p .everyUltimateAuthorityIsCircular ]

/-! #### Shared grounds and closing steps -/

/-- What the Protestant packages rest on beyond any single line: the prooftext
that belongs to no strand, the shared datum of 2 Thessalonians 2:15, and the
commitments of the final-arbiter reading. Mark 7 is not among them: it is a
line of its own (`mark7Line`). -/
@[solaScripturaDefs]
def sharedGrounds : List (Formula Claim) :=
  [ p .acts17BereansTested
  , p .thessalonians2_15TraditionBinding
  , p .doctrineDevelopsWithoutNewRevelation
  , p .traditionHasMinisterialAuthority
  , p .practiceNeitherCommandedNorForbiddenIsPermitted
  , p .bindingnessAppliesToFirstOrderDoctrineOnly ]

end TestimonyArguments.SolaScriptura
