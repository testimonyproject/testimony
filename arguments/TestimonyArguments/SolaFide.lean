import TestimonyArguments.SolaFide.Atoms
import TestimonyArguments.SolaFide.Sources
import TestimonyArguments.SolaFide.Lines
import TestimonyArguments.SolaFide.Packages
import TestimonyArguments.SolaFide.Results
import TestimonyArguments.SolaFide.Dispute
import TestimonyArguments.SolaFide.Johannine
import TestimonyArguments.SolaFide.Gospel
import TestimonyArguments.SolaFide.Definition
import TestimonyArguments.SolaFide.Hearings
import TestimonyArguments.SolaFide.JesusWords
import TestimonyArguments.SolaFide.Baptism
import TestimonyArguments.SolaFide.James
import TestimonyArguments.SolaFide.Vulgate
import TestimonyArguments.SolaFide.Ratings

/-!
# TestimonyArguments.SolaFide — justified by grace, through faith, not by works

"By grace you have been saved through faith. And this is not your own doing; it
is the gift of God, not a result of works" (Ephesians 2:8–9). The Reformers
summed that up as *sola fide*, faith alone. Rome answered at the Council of
Trent that faith is necessary and is not alone. This page sets out that
argument so that a reader can see every step of it.

## What this page does, and what it does not

It does two things. It writes down each position as a list of premises, every
one with a source, so that nothing is assumed silently. And it checks, by
machine, what follows from each list and what does not.

It does not tell you which premises are true. Whether Paul meant one thing or
another by a phrase is a question for the reader and for the scholars cited.
What the checking adds is narrower: if you grant these premises, this conclusion
follows; if you deny that one, here is what you lose and what you keep.

Three words recur. A **premise** is something a position takes as given, such as
a verse or a claim about what a word in it means. A **reading** is a premise
about what a text means where readers disagree. A **rating** says how well
supported a premise is among the sources cited: `disputed` when a cited source
grants the evidence and denies the claim, then `plausible`, `wellSupported` and
`consensus`. Names in `this type` are the names of premises and results in the
source, given so that a reader can find them.

## The conclusion has three parts

Salvation is *by grace*, *not by works*, and *through faith*. The page keeps the
three apart, because the positions disagree about different parts.

- Trent denies the second in one respect. It grants that nothing before
  justification, "whether faith or works", merits it (Session VI, ch. 8). It
  holds that works done afterwards, in grace, merit an increase of
  justification (ch. 10; canon 24). So for Trent salvation as a whole is not
  apart from works.
- The apocalyptic reading of Paul (Martyn, Campbell), so called because it
  reads Paul's gospel as God breaking into the world to rescue it, does not
  reach the third. It takes "the righteousness of God" as God's act of rescue, not as a status
  given on condition of faith. So it has no ground of its own for "through
  faith", while it reaches grace and "not by works" by its own route
  (`apocalyptic_establishes_grace_not_works`).

The split also shows what the disputed readings below are needed for. Grace and
"not by works" follow from the verses that say so in as many words, once James
is answered, with every disputed reading removed
(`grace_and_works_rest_on_no_lexical_premise`). The disputed readings decide
*through faith*.

## Four strands, from four speakers

The Reformed case reaches "through faith" four ways, here called strands. Each
rests on its own texts and on a reading of them that the conclusion needs.
Every strand has at least one such reading that a scholar cited here denies.

**Paul.** "A person is not justified by works of the law but through faith in
Jesus Christ" (Galatians 2:16). Teachers in Galatia required believers to be
circumcised as well as to believe, and this is Paul's answer. The strand rests
on two readings of the verse.

- What "works of the law" (ἔργα νόμου) means: human works in general, or what
  the law requires of Israel as a people set apart, seen above all in the
  practices that marked Jews off from gentiles: circumcision, food laws and
  sabbath. Dunn and Wright hold the second, building on Sanders. Their reading
  is known as the New Perspective on Paul. Only on the
  first does refusing circumcision mean refusing every work as a requirement
  (`worksOfLawMeansWorksGenerally`).
- What "faith in Jesus Christ" (πίστις Χριστοῦ) means: our faith in Christ, or
  Christ's own faithfulness. Hays holds the second. Only on the first does the
  verse name the believer's faith as the means (`pistisChristouObjective`).

The second question is a premise inside Paul's strand and not a strand of its
own. Every verse with the phrase sets it against the law, so no route through
it avoids the first question. Nor does it divide the same people: Dunn rejects
the traditional reading of "works of the law" and keeps "faith in Christ".

**Jesus, in Luke.** "Your faith has saved you; go in peace" (Luke 7:50), said to
the woman who anointed his feet. The saying occurs four times in Luke (7:50,
8:48, 17:19, 18:42). The Greek verb (σῴζω) means both *save* and *heal*, and in
the other three places the person has just been healed, which is why most
English Bibles print "made you well" there. So the strand rests on 7:50 alone,
where the saying follows "your sins are forgiven" and no one is ill. That the
word means *saved* there is a reading the strand needs
(`sozoIsSoteriological`). It is rated `wellSupported`: no scholar found argues
the healing sense at 7:50. The reading in this strand that is rated `disputed`
is of 7:47.

The strand also answers "her sins, which are many, are forgiven—for she loved
much" (7:47), which could be read as making love the reason she was forgiven. It
holds that her love shows her forgiveness and does not earn it
(`luke7_47LoveIsEvidence`), as the rest of the verse ("he who is forgiven
little, loves little") and the parable of the two debtors (7:41–43) suggest.
That reading is cited to Osvaldo Padilla: her
actions "stem from the fact that she loves much because she has been forgiven
much". It is Melanchthon's too, in the *Apology of the Augsburg Confession*:
"Christ interprets Himself when He adds: Thy faith hath saved thee". Marshall's
commentary on the Greek text argues it from the grammar: "for" here means "as
is evidenced by the fact that". He also names those who read the love as the
cause, most Roman Catholic commentators among them, so this premise is rated
`disputed`. On "saved", Marshall notes that the saying is used at 7:50 "in a
case where physical healing is not involved".

**Peter, in Acts.** At the Jerusalem council some demanded: "Unless you are
circumcised according to the custom of Moses, you cannot be saved" (Acts 15:1).
Peter answered that God cleansed the gentiles' hearts by faith, that the law is
"a yoke… that neither our fathers nor we have been able to bear", and that "we
believe that we will be saved through the grace of the Lord Jesus, just as they
will" (15:9–11). The strand's disputed reading is that the yoke is the whole
law treated as a condition of salvation (`acts15YokeIsLawAsCondition`). Jervell
reads it as Israel's law laid on gentiles as a mark of belonging. On that
reading Peter refuses to make gentiles keep Israel's law, and says nothing
about the law as a condition of salvation.

**Jesus, in John.** "What must we do, to be doing the works of God?" "This is
the work of God, that you believe in him whom he has sent" (John 6:28–29). The
strand's disputed reading is that this believing is trust, which brings nothing
of its own to God (`johannineBelievingIsTrust`). Calvin reads it so. Aquinas
reads it as faith formed by charity, that is, faith made alive by love, which
is how Trent describes the faith that justifies. Luther answers Aquinas from
Galatians 3:11–12, and the answer rests on a step Aquinas denies. The section
on John below sets this out. It also takes up John 3:36, "whoever does not obey
the Son shall not see life", and Chrysostom's reading of it.

## What the four strands show together

The argument does not depend on any one disputed reading. Remove any one and
the other strands still reach the conclusion (`worksOfLaw_not_load_bearing`,
`sozo_not_load_bearing`, `acts15Yoke_not_load_bearing`,
`believing_as_trust_not_load_bearing`). Acts and John each reach it with all
the other strands' disputed readings left out
(`apostolic_strand_survives_paul_and_luke`,
`johannine_strand_survives_the_other_three`). Only when a disputed reading is
removed from every strand at once does sola fide fail to follow
(`lexical_premises_jointly_load_bearing`).

So a reader who wins the argument over "works of the law" has not thereby
defeated sola fide. The New Perspective (Dunn's and Wright's reading), which
rejects the traditional reading of that phrase and still holds justification by
faith, establishes the conclusion too (`newPerspective_establishes`). Nor does winning "the
faithfulness of Christ" for Hays defeat it: that costs the Reformed case its
route through Paul, and not its conclusion (`pistisChristou_not_load_bearing`).

What this does not show is that the strands are independent in practice. A
reader who takes "works of the law" as boundary markers will usually read
Peter's yoke the same way. They are different premises about different texts,
and an opponent has to answer each.

## Each strand is credited only with what its texts say

On the Reformed reading, Paul argues for *alone*. The Galatians already
believed; adding circumcision to their faith is what he says severs them from
Christ (5:4). John's strand, on Calvin's reading, claims the same: asked about
works, Jesus names believing and nothing else.

Luke 7:50 and Acts 15 say less. Her faith saved her; the gentiles are saved
without the yoke. That is, faith *suffices* (`faithIsSufficient`). They do not
say that nothing else could be a condition. "Through faith" needs only that
much.

The difference matters when positions are weighed against each other, because
a case is attacked on what it claims. Credit Luke with *alone*, and the
apocalyptic reading would attack Luke on a claim Luke never made.

## Why the New Perspective reads Paul as it does, and the reply

Sanders argued that Judaism in Paul's day taught that one enters the covenant
by grace and stays in by obedience ("covenantal nomism"). If so, Paul's
opponents were not trying to earn salvation, and Dunn infers that what Paul
refuses is the boundary markers (`sandersLine`). Gathercole, and the *Variegated
Nomism* volume edited by Carson, O'Brien and Seifrid, deny the starting point:
Jewish texts of the period also speak of
final vindication according to works, so the demand Paul refuses is a demand for
obedience (`criticsLine`).

On the critics' history, Paul alone carries sola fide
(`critics_carry_the_pauline_strand`). On Sanders', he does not
(`sanders_costs_the_pauline_strand`). So whether Paul's strand reaches sola
fide depends on what Judaism in Paul's day taught about works.

## What justification is

This is a separate question, and the page keeps it separate. The Reformed
account is that justification is a verdict only (the technical word is
"forensic"): God pardons and counts righteousness to the believer, and that is
not a change worked inside the person (Westminster Confession XI.1). Trent
denies that: justification is "not remission of sins merely, but
also the sanctification and renewal of the inward man". Mannermaa and the
Finnish school read Luther differently again. In faith Christ himself is present
in the believer, and so justification is not a verdict *and nothing more*.

The Finnish position denies that justification is only a verdict and still
establishes sola fide (`forensic_justification_not_load_bearing`). Trent denies it and does not.
So denying the verdict-only account is not what separates Trent from the Reformers.
What Trent's objection needs is its fuller definition: justification includes
the inner renewal, that renewal grows through good works, and so works increase
justification. Both sides grant the growth. The Reformed call it
sanctification, distinct from justification and following it (Westminster
XIII.1; Calvin, *Institutes* III.xi.6). Put that distinction in place of Trent's
definition, and Trent's case no longer denies "not by works"
(`trent_objection_rests_on_its_definition`). Whether works merit anything in
justification depends on whether justification includes the inner renewal.

## James 2:24

"A person is justified by works and not by faith alone" is the only place in the
New Testament where the words *faith alone* occur, and they are denied. The page
does not assume the verse away. It derives the agreement of James with Paul from
two cited premises: that James is attacking a barren faith, mere assent ("even
the demons believe", 2:19); and that works are the fruit and evidence of saving
faith and not a ground of justification. Moo and Johnson are cited for the
exegesis, and Westminster XI.2 for the confession: faith "is not alone in the
person justified, but is ever accompanied with all other saving graces, and is
no dead faith, but worketh by love".

The argument depends on this. Remove the answer to James and sola fide does not
follow (`james_harmonisation_is_load_bearing`). Grace alone does not need it
(`grace_needs_no_answer_to_james`): James bears on "not by works", the part he
appears to contradict.

## Who wrote the letters

Ephesians, Titus and 1 and 2 Peter are each disputed as to author, and each
dispute is recorded from both sides: Hoehner and Lincoln on Ephesians; Mounce,
Dibelius–Conzelmann and Marshall on the Pastorals; Jobes and Achtemeier on
1 Peter; Schreiner and Bauckham on 2 Peter; Ehrman across all four. Granting
every critical conclusion costs the argument nothing
(`authorship_not_load_bearing`), because it reads these letters as Scripture and
not as the testimony of a named apostle. It does cost them their use as evidence
of what *Paul* meant by "works", which is why that premise is argued from Romans
4, 9 and 11, where the authorship is not in doubt.

## The positions weighed against each other

The results above ask what follows from each position's premises. The section
on the dispute (`Dispute.lean`) asks a different question: when the positions
are set against one another, which survive?

Three words are used there. One position *defeats* another when it contradicts
it and rests on premises rated at least as well. A position is *forced* when it
must be accepted however the open disagreements are settled. Two positions that
defeat each other are a *tie*: a reader may hold either, and neither is
forced. Fifteen positions are heard: the four strands, each argued alone;
Trent; the apocalyptic reading; Sanders and his critics; Jervell; Aquinas on
John, and Luther's answer; Paul's gospel in Galatians; and three positions on
what Paul's word "justify" means.

One thing prevails outright: Paul's verb "justify" (δικαιόω) does not mean the
renewal of the inward man (`only_pauls_word_prevails`). It is argued two ways,
from the word's usage and from Romans 4, and those are the only positions whose
every step is rated above `disputed`. Trent's definition, if it is taken as a
claim about what Paul's word means, cannot be defended against them
(`trent_on_pauls_word_indefensible`).

Everything else ties. Every other position rests on something rated `disputed`,
and every attack between Trent and a Reformed strand runs in both directions.
Luke's case, Paul's gospel and Trent can each be defended, and none is forced.
John's case ties with Trent and with Aquinas, as the other strands tie with
their rivals.

## Narrower questions

The remaining sections each take one question a reader asks.

- **Where exactly do Trent and Paul part?** At one step (`Gospel.lean`): that a
  verdict on Christ's finished work excludes the renewal worked in us. Trent
  grants every text, and, with the *Joint Declaration* (§22), the verdict sense
  of the verb.
- **Is Trent's definition about Paul's word, or about what God does?** Read as
  a claim about the word, it cannot be held with the evidence for the word's
  meaning. Read as a claim about what God does, nothing about the word reaches
  it, and it meets Paul at steps rated `disputed`: Augustine accepts Romans 4
  and reads it as God making the ungodly godly (`Definition.lean`).
- **What did the Reformation itself decide? And without Trent, would Scripture
  establish sola fide?** Heard as Rome and the Reformers alone, only the meaning
  of Paul's word is forced. Heard without Trent, three things are forced: Luke's
  "faith suffices", Paul's gospel, and the meaning of Paul's word. *Faith alone*
  still is not. Campbell, Sanders and Dunn, Jervell, and Aquinas each still
  stand against one strand (`Hearings.lean`).
- **What does Jesus himself say?** The tax collector "went
  down to his house justified" (Luke 18:14). Trent's case is consistent with
  every word of the parable, and meets it where it meets Luke 7:50. Matthew
  7:21–23 and 19:16–22 are each read both ways, and neither settles its question
  alone (`JesusWords.lean`).
- **Is baptism necessary?** Trent makes water baptism the
  instrument of justification, "or the desire thereof". Water, the Spirit and
  "fire" are kept apart, so that no argument slides from one sense of "baptism"
  to another. John 3:5 is examined under each of the four readings of its
  "water" (`Baptism.lean`).
- **What does "justified by works" mean in James?** The same kind of hearing,
  over James 2:24 and the two other texts Trent cites for the increase of
  justification (`James.lean`, `Vulgate.lean`).
- **How firm are the ratings?** Each rating that a verdict depends on is
  recomputed under three standards (`Ratings.lean`).

## Where things are

| File | Contents |
|---|---|
| `Atoms.lean` | the list of claims |
| `Sources.lean` | a source and a rating for every claim |
| `Lines.lean` | the inference steps, the four strands, the apocalyptic rival, what they share |
| `Packages.lean` | the positions, and the variants that remove a named premise |
| `Results.lean` | the main results: what follows from each position, and what does not |
| `Dispute.lean` | the positions as parties to one dispute, who defeats whom, and what prevails |
| `Johannine.lean` | John's strand, Aquinas's rival reading, Luther's answer, and John 3:36 |
| `Gospel.lean` | Paul's gospel in Galatians against Trent's definition, and where they part |
| `Definition.lean` | Paul's word, and the two ways of taking Trent's definition |
| `Hearings.lean` | the dispute heard narrower: the Reformation alone, and without Trent |
| `JesusWords.lean` | Luke 18, and both readings of Matthew 7 and 19: what Jesus' words decide |
| `Baptism.lean` | water, Spirit and fire apart; the instrumental cause; John 3:5 |
| `James.lean`, `Vulgate.lean` | James 2:24 and Trent's other two texts, heard as a dispute |
| `Ratings.lean` | the ratings recomputed under three standards |
-/
