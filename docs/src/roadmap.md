# Roadmap

## Where the library is

Every result this library claims is tagged `@[headline]` in the Lean source,
and the table below is generated from those tags by `lake exe statusgen`. It is
not a summary someone maintains beside the arguments: rename a theorem, restate
it, or delete it, and the next run moves the table. `lake exe statusgen --check`
fails CI when the committed copy has drifted.

Each heading links to that argument's own page, where the same results are set
out with their docstrings, the premises they rest on, and the rival readings
they are checked against — also generated, by `lake exe argdoc`.

<!-- BEGIN GENERATED: lake exe statusgen -->

**4 arguments**, carrying **68 headline results**, listed below in source order. one of them is marked ⚗: a result this library constructs rather than reports, with no source found advancing it in that form.

### [Born in Bethlehem — Micah 5:2](./arguments/born-in-bethlehem.md)

| Result | Statement | What it claims |
|---|---|---|
| `christian_establishes` | `Establishes christian` | Given the Christian premises, the conclusion follows. |
| `critical_not_establishes` | `¬Establishes critical` | The critical reading does not establish the conclusion. |
| `jesus_satisfies_bethlehem` | `Satisfies jesus bornInBethlehem` | End to end: under the Christian package, Jesus satisfies the Bethlehem criterion. |

### [Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3](./arguments/born-of-a-virgin.md)

| Result | Statement | What it claims |
|---|---|---|
| `christian_establishes` | `Establishes christian` | Given the scriptural premises, the conclusion follows. |
| `catholic_establishes` | `Establishes catholic` | The Roman Catholic package establishes it too, unsurprisingly: it is the scriptural package with a further strand bolted on. |
| `magisterialOnly_establishes` | `Establishes magisterialOnly` | The magisterial route carries the conclusion on its own, for a reader who grants the authority it claims. |
| `critical_not_establishes` | `¬Establishes critical` | The critical reading does not establish the conclusion. |
| `criticalDenial_establishes` | `Establishes criticalDenial` | The critical case for the denial does go through on its own terms. |
| `berry_blocks_critical_denial` | `¬Establishes criticalDenialUnderBerry` | **Berry's objection blocks the critical denial.** Grant that Isaiah 7:14 was a sign to Ahaz, and grant with Berry that how it was fulfilled in Ahaz's own day is an open question, … |
| `parity_blocks_critical_denial` | `¬Establishes criticalDenialUnderParity` | **Postell's parity argument blocks the critical denial too**, and by a different route from Berry's. |
| `magisterial_authority_is_load_bearing` | `¬Establishes magisterialDenied` | **What the magisterial strand is worth to a reader who does not grant the magisterium's authority: nothing.** Deny that premise and the route collapses outright, however firmly … |
| `almah_not_load_bearing` | `Establishes christianWithoutAlmah` | **The lexical premise no longer carries the argument.** Strip `almah` and the protoevangelium and Michean strands still deliver the criterion. |
| `almah_is_load_bearing_alone` | `¬Establishes isaianicStrandWithoutAlmah` | Within the Isaianic strand taken alone, the lexical premise is still load-bearing: remove it and that strand yields nothing. |
| `admissibility_is_not_enough` | `¬Establishes isaianicStrandOnAdmissibility` | **Admissibility is not enough.** Berry's lexical point is defensive — the semantic range of עַלְמָה does not *exclude* the sense "virgin" — and defensive is all it is. |
| `semantic_establishes` | `Establishes semantic` | **The referential argument goes through.** Granted only what both sides grant about the word — that עַלְמָה denotes a young woman of marriageable age, and that being a virgin does … |
| `lexicalCritical_establishes` | `Establishes lexicalCritical` | The lexical objection, written down and granted its own premises. |
| `compatibility_defeats_lexical_objection` | `¬Establishes lexicalCriticalUnderCompatibility` | **The referential reply defeats the lexical objection.** Keep every versional datum — the Targum's עוּלֵימְתָא, the Three's νεᾶνις, the Septuagint's παρθένος, the Peshitta's … |
| `compatibility_does_not_establish_criterion` | `¬Establishes semanticReachingForCriterion` | **What the referential argument costs.** It is purely defensive. |
| `hinges_jointly_load_bearing` | `¬Establishes christianWithoutAnyHinge` | **The result worth having.** No single hinge carries the argument, but the four of them jointly do: remove all four and the criterion no longer follows, with every textual and … |
| `jesus_satisfies_virgin_birth` | `Satisfies jesus bornOfAVirgin` | End to end: under the scriptural package, Jesus satisfies the virgin-birth criterion. |
| `wegner_establishes` | `Establishes wegnerLexical` | **Wegner's objection is valid on its own terms.** Grant the predicate-adjective parse, grant that the pregnancy it reports is an ordinary one, and grant that the one clear … |
| `wegner_needs_ordinary_pregnancy` | `¬Establishes wegnerWithoutOrdinaryPregnancy` | **The grammar is not what carries the objection.** Derive the ordinary pregnancy the way Wegner derives it — from the near-term reading of the sign — rather than granting it, and … |
| `circle_leaves_the_lexical_conclusion_open` | `Independent wegnerCircle.premises (notP Claim.almahMeansVirgin)` | **The circle, shown rather than alleged.** Put both legs in place — the reading supplying the ordinary pregnancy, and the lexical conclusion turned back against the reading — keep … |
| `circle_leaves_the_denial_open` | `Independent wegnerCircle.premises (notP Claim.isaiahPredictsVirginBirth)` | **And the other end of it is no better off.** The same premises, asked for the denial of the predictive reading instead of the lexical conclusion, fail in the same way and on the … |
| `usage_parity_blocks_wegner` | `¬Establishes wegnerUnderUsageParity` | **Postell's second reply, and it is independent of the first.** Concede the parse, concede the ordinary pregnancy, concede that the woman of Isaiah 7:14 is no virgin — and the … |
| `sign_leaves_the_lexical_conclusion_open` | `Independent wegnerUnderTheSign.premises (notP Claim.almahMeansVirgin)` | **The sign argument blocks Wegner's objection, and settles nothing about the word.** Keep the parse, the near-term setting and the referent principle, put the fathers' two grounds … |
| `reply_leaves_the_pregnancy_open` | `Independent signArgumentUnderReply.premises (notP Claim.pregnancyAtTheSignIsOrdinary)` | **The near-term reply blocks the sign argument back, and settles nothing about the pregnancy.** Put the reply's grounds and step where the fathers' first ground was, keep the … |
| `motyer_rests_on_his_inference` | `¬Entails motyerLine.grounds (notP Claim.isaiahIsNearTermSignToAhaz)` | **Motyer's reply rests on his inference, not on his observations.** On the reading that identifies the two children, the sign is given to the house of David, 8:4 repeats the … |
| `christian_defeats_critical` | `Defeats christian criticalDenial` | **The scriptural reading answers the critic.** Its rebuttal is a defeat: the weakest link on each side is `disputed`, so neither outranks the other, and each defeats the other. |
| `scriptural_reading_prevails_once_replies_are_heard` | `Framework.grounded isaiahDispute.defeats = {Party.scriptural, Party.berry, Party.postell, Party.motyer, Party.micah}` | **Heard out, the scriptural reading prevails.** Nothing defeats either of Postell's counterexamples, so both are in the grounded extension from the first step. |
| `critical_denial_indefensible` | `∀ (S : Set Party), Framework.Admissible isaiahDispute.defeats S → Party.critical ∉ S` | **The critical denial cannot be defended.** No admissible set contains it: Postell defeats it, and nothing defeats Postell. |
| `nothing_prevails_unanswered` | `Framework.grounded unanswered.defeats = ∅` | **Unanswered, nothing prevails.** The scriptural reading and the critical denial defeat each other, so neither is forced, and the grounded extension is empty. |
| `nothing_prevails_on_motyer_alone` | `Framework.grounded motyerAlone.defeats = ∅` | **Motyer alone does not settle it.** He and the critic defeat each other, as the scriptural reading and the critic do, so nothing is forced. |
| `scriptural_reading_prevails_without_postell` | `⟨Party.scriptural, ⋯⟩ ∈ Framework.grounded withoutPostell.defeats` | **Without Postell's Isaiah argument, the scriptural reading still prevails.** His Micah counterexample is defeated by nothing, and it defends the scriptural reading against the … |
| `nothing_prevails_without_the_counterexamples` | `Framework.grounded withoutParity.defeats = ∅` | **Without the counterexamples, nothing prevails.** Berry and Motyer each tie with the critic, as the scriptural reading does, so every party is defeated by someone. |
| `reply_rests_on_its_inference` | `¬Entails ordinarySignLine.grounds (notP Claim.signMustBeExtraordinary)` | **The reply rests on its inference, not on its observations.** On Rydelnik's reading Isaiah's children are signs, 7:16 dates the deliverance by a child's infancy, and the sign of … |
| `nothing_prevails_over_wegner` | `Framework.grounded wegnerDispute.defeats = ∅` | **Nothing prevails.** Every party is defeated by someone — Wegner and the reply by the fathers, the fathers by both — so nothing is forced, and the grounded extension is empty. |
| `sign_is_one_resolution` | `Framework.Preferred wegnerDispute.defeats {WegnerParty.sign}` | **One resolution: the fathers.** The sign argument alone is admissible — it defeats both of its defeaters — and it is in conflict with both of the other parties, so no larger set … |
| `wegner_is_the_other_resolution` | `Framework.Preferred wegnerDispute.defeats {WegnerParty.wegner, WegnerParty.reply}` | **The other resolution: Wegner, with the near-term reply.** Neither defeats the other, and between them they answer the fathers, who are the only party to defeat either. |
| `nothing_prevails_without_the_reply` | `Framework.grounded signAgainstWegner.defeats = ∅` | **Without the reply, nothing prevails either.** Wegner and the fathers defeat each other, so the reply is not what keeps the fathers from prevailing: Wegner's rebuttal does, … |

### [Sola fide](./arguments/sola-fide.md)

| Result | Statement | What it claims |
|---|---|---|
| `reformed_establishes` | `Establishes reformed` | Given the Reformed premises, the conclusion follows. |
| `newPerspective_establishes` | `Establishes newPerspective` | **The New Perspective establishes it too.** Dunn and Wright reject the traditional reading of ἔργα νόμου; they do not reject justification by faith. |
| `tridentine_not_establishes` | `¬Establishes tridentine` | The Tridentine premises do not establish the conclusion — they entail its negation. |
| `worksOfLaw_not_load_bearing` | `Establishes reformedWithoutWorksOfLaw` | The Pauline lexical premise is **not** load-bearing on its own: strip it and the dominical strand still carries the argument. |
| `sozo_not_load_bearing` | `Establishes reformedWithoutSozo` | Nor is the dominical lexical premise: strip it and the Pauline strand still carries the argument. |
| `lexical_premises_jointly_load_bearing` | `¬Establishes reformedWithoutEitherLexicalPremise` | **The result worth having.** Neither lexical premise carries the argument alone, but their *disjunction* does: remove both and sola fide no longer follows, with everything else … |
| `james_harmonisation_is_load_bearing` | `¬Establishes reformedWithoutJamesHarmonisation` | The argument genuinely depends on answering James. |

### [Sola scriptura](./arguments/sola-scriptura.md)

| Result | Statement | What it claims |
|---|---|---|
| `protestant_establishes` | `Establishes protestant` | Given the Protestant premises, on either route, the conclusion follows. |
| `tradition0_establishes` | `Establishes tradition0` | **Tradition 0 establishes it too.** Geisler rejects Mathison's claim that tradition is hermeneutically necessary; he does not reject sola scriptura. |
| `tridentine_not_establishes` | `¬Establishes tridentine` | The two-source premises do not establish sola scriptura — they entail its negation. |
| `vaticanI_not_establishes` | `¬Establishes vaticanI` | Tradition III likewise entails the negation — by a different premise from Tradition II's, which is why the two are separate packages. |
| `orthodox_not_establishes` | `¬Establishes orthodox` | Orthodoxy also entails the negation, and on its own premise. |
| `selfRefutation_is_valid` | `Establishes selfRefutation` | The self-refutation objection is valid: granted that only scriptural doctrine binds and that scripture does not teach sola scriptura, the position fails by its own standard. |
| `canonObjection_is_valid` | `Establishes canonObjection` | The canon objection is valid on its own grounds: if the canon is known through the Church's reception and identifying it requires an infallible authority, then an authority … |
| `interpretiveRegress_is_valid` | `Establishes interpretiveRegress` | The interpretive-authority regress is valid on its own grounds. |
| `hinge_not_load_bearing_for_conclusion` | `Establishes protestantWithoutHinge` | **The hinge is not load-bearing for the conclusion.** Strip it and the eliminative line still delivers the sole rule. |
| `hinge_is_load_bearing_within_classical_strand` | `¬Establishes classicalStrandWithoutHinge` | Within the classical strand taken alone the hinge is still load-bearing: remove it and that strand yields nothing. |
| `classical_answer_blocks_self_refutation` | `¬Establishes selfRefutationAnswered` | **The classical answer blocks the objection.** Assert that scripture teaches the principle and the objection no longer delivers its denial. |
| `scoping_blocks_self_refutation` | `¬Establishes selfRefutationUnderScope` | **And the final-arbiter answer blocks it too, without the hinge.** This is the answer the seed did not encode. |
| `parity_leaves_the_canon_open` | `Independent canonUnderParity.premises (p Claim.scriptureIsSoleInfallibleRule)` | **The parity reply leaves the canon question open.** Granted Kruger's grounds, the sole infallible rule neither follows nor fails: his own reading has it, and the reading on which … |
| `parity_leaves_the_distinction_open` | `Independent regressUnderParity.premises (p Claim.traditionIDiffersInPrincipleFromTradition0)` | **And the same for interpretive authority.** That choosing an authority is itself private judgement defeats the charge that Tradition I collapses into Tradition 0; it does not … |
| `circle_leaves_the_consensus_open` | `Independent traditionICircle.premises (p Claim.creedalConsensusIsHermeneuticallyNecessary)` | **Geisler's circularity charge against Tradition I, shown rather than alleged.** The creedal consensus is said to rest on scripture's clarity, and scripture's clear sense is said … |
| `circle_leaves_the_perspicuity_open` | `Independent traditionICircle.premises (p Claim.scriptureIsPerspicuous)` | **And the other end is no better off.** The same two legs, asked about perspicuity instead of the consensus, leave it open in the same way and on the same two readings. |
| `geislerCircle_is_valid` | `Establishes geislerCircle` | Geisler's charge is valid on its own grounds: grant that the consensus rests on scripture's clarity and that scripture's clear sense requires the consensus, and the reasoning is … |
| `accountability_blocks_the_circle` | `¬Establishes geislerCircleUnderAccountability` | **Allen and Swain's reply blocks the charge.** If the creedal consensus is established by and accountable to scripture, it is what reading scripture produces rather than what … |
| `scripturalBounding_blocks_the_circle` ⚗ | `¬Establishes geislerCircleUnderScripturalBounding` | **The scriptural-bounding reply blocks the charge too, and on scriptural rather than confessional grounds.** **What is novel here.** No source was found advancing these texts as … |
| `parity_leaves_the_defeat_open` | `Independent defeatUnderParity.premises (p Claim.circularityDefeatsTraditionI)` | **Barrett's parity reply leaves the defeat open.** Concede the circle; deny that it is a defect peculiar to this position, since any appeal to an ultimate authority is circular. |
| `circle_parity_concedes_the_charge` | `Establishes circleParityConcedingTheCharge` | **The reply does not merely fail to clear the charge — it grants it.** This is the second question, kept because it is worth asking and restated because the answer is stronger … |

<!-- END GENERATED: lake exe statusgen -->

Eight findings emerged that were not designed for.

**Redundancy defeats a lexical dispute.** Sola fide runs on two independent
strands — Paul's ἔργα νόμου and Jesus' σέσωκέν σε at Luke 7:50 — and neither
lexical premise carries the argument alone. Only their disjunction does. An
opponent must defeat both readings, not either.

**The virgin-birth argument was the weaker one, and stopped being so.** It
began single-stranded, and the library's result then recorded that defeating
עַלְמָה defeated it outright. Adding the protoevangelium (Genesis 3:15), Michean
(Micah 5:2–3) and compositional (Isaiah 2–12) strands changed the structure, not
the Isaianic evidence: `almah_not_load_bearing` now holds, while
`almah_is_load_bearing_alone` preserves the original finding about the Isaianic
strand taken by itself.

The same module carries a *referential* reply that answers the lexical dispute
without entering it — עַלְמָה need not mean "virgin" for Mary to be one — and
`compatibility_does_not_establish_criterion` records its price: the reply is
purely defensive. The contrast between these arguments is a structural fact
about them, not a matter of taste, and the library states it in a form either
side can check.

**A rival's circularity, shown rather than alleged**
([#13](https://github.com/testimonyproject/testimony/issues/13)). Wegner's
sharper form of the lexical objection — הָרָה at Isaiah 7:14 is a predicate
adjective, so the עַלְמָה is *already pregnant* and therefore no virgin — is
encoded at full strength, and `wegner_establishes` checks that it goes through.
What the grammar does not supply is that the pregnancy is an *ordinary* one:
that comes from the near-term reading of the sign, which the lexical conclusion
was then wanted to support. With both legs in place,
`circle_leaves_the_lexical_conclusion_open` and `circle_leaves_the_denial_open`
show that neither end is settled either way, because a cycle of implications is
satisfied outright by a valuation on which every node in it is false, and
equally by one granting Wegner's conclusion. Postell's charge of circular
reasoning becomes a checkable result rather than an accusation — and, like
every result here, a conditional one: deny that the near-term reading needs the
lexical conclusion and the circle is not there.

The oldest answer to the objection goes to the same premise
([#73](https://github.com/testimonyproject/testimony/issues/73)). Justin,
Irenaeus and Origen argue that an ordinary conception would have been no sign.
Encoded against its rival, that a sign need not be a miracle,
`sign_leaves_the_lexical_conclusion_open` shows that it blocks Wegner and
settles nothing about the word. As a dispute, the three positions tie
(`nothing_prevails_over_wegner`), and the tie is a fact about two ratings. It
turns on whether the sign of 7:14 must be the kind offered at 7:11, and on
whether the reply's inference survives Rydelnik, who grants its grounds.

A corollary worth noting: because the New Perspective rejects the traditional
reading of Paul's phrase while still affirming justification by faith, it
**establishes the conclusion too**. Winning the ἔργα νόμου argument is not a
defeat of sola fide.

**The same reply, six times.** The major objections to sola scriptura turn out
to share a form: *an authority outside scripture is needed to make scripture
usable* — to fix the canon, to supply the vocabulary Nicaea settled on, to
identify which unwritten apostolic teaching is genuine, to license a
development. And the reply is the same every time: *so do you.* Kruger on the
canon, Mathison on interpretive authority, Athanasius answering the Arian charge
that ὁμοούσιος is unscriptural, Whitaker on unwritten tradition, Geisler on who
may interpret the Old Testament, Barrett on perspicuity — six instances across
seventeen centuries, by people arguing against each other.

What the library adds is the price, and it has a name: **a parity reply renders
the disputed proposition independent of the premise set.** Granted the reply's
grounds, the proposition neither follows nor fails — two readings satisfy those
grounds, one with it and one without. `parity_leaves_the_canon_open` and
`parity_leaves_the_distinction_open` say exactly that, and saying it once is the
whole finding: blocking the objection and establishing nothing are not two
facts about the move but one fact seen from either side. It neutralises an
objection and establishes nothing, because conceding a charge is not answering
it. That is the lesson `compatibility_does_not_establish_criterion` already
recorded for the virgin-birth argument, now shown to be a property of the
*move* rather than of any one dispute.

**And naming a shape finds the cases that do not fit it.** The three parity
replies in the sola scriptura argument were each written as a pair of results,
"it blocks" and "it establishes nothing". Two of the pairs were genuine
independence claims. The third was not: its halves asked about *different
propositions* over the same premises — whether the circularity defeats
Tradition I, and whether Tradition I's reasoning is circular — while being
presented as complements. Nothing checked that, because nothing required the
proposition to be named once. Under `Independent` it has to be, and the defect
was visible immediately. Restated, the first half is
`parity_leaves_the_defeat_open` and the second is stronger than it was:
`circle_parity_concedes_the_charge` shows the reply does not merely fail to
clear the charge but grants it outright, since the charge is one of its own
grounds.

The notion is Foundation's — `Independent φ` there is `𝓢 ⊬ φ ∧ 𝓢 ⊬ ∼φ`, over
provability. `Testimony.Logic.Independent` is its semantic counterpart, over
the entailment this library uses, and `leaves_open` proves one from the two
readings the premises admit. Both readings stay named, for the same reason
every countermodel here is named.

**Answering an objection is two moves, and only one of them can win.** Every
reply in the library was written the same way, as the objection's own line with
a ground replaced. Asked which of them *contradict* the ground and which merely
*decline* it, they split. Kruger on the canon, Mathison on interpretive
authority, the final-arbiter answer and both replies to Geisler's circle decline
it: `kruger_refuses_rather_than_denies` shows Kruger's premises leave the
requirement he refuses standing. Berry and Postell deny theirs, as do the
classical answer to self-refutation and Barrett. A refusal takes a ground away,
and its effect is the independence finding above. A denial is an *attack*, and
an attack can defeat.

Entailment cannot say that one argument defeats another, because adding
premises never removes a conclusion. A dispute can. The Isaiah 7:14 positions,
taken as an argumentation framework with defeats proved from their premises and
their cited confidences, show that against the scriptural reading alone nothing
prevails (`nothing_prevails_unanswered`): each defeats the other. Once Berry and
Postell are heard, the scriptural reading prevails
(`scriptural_reading_prevails_once_replies_are_heard`), and the critic cannot be
defended at all (`critical_denial_indefensible`). Two corrections got it
there. The first draft rated the critic's exclusion premise `wellSupported`
while recording, in the same argument, two scholars who contest it; rated as
the library defines `disputed`, it became the critic's weakest link. Then the
replies' inferences, unrated, had let each reply be weighed by its observations
alone, so that where an encoding put a contested move — atom or step — decided
who prevailed. Rated, Berry's and Motyer's steps are `disputed` and tie with the
critic (`nothing_prevails_on_motyer_alone`). The verdict rests on Postell's
inference — an oracle on the Assyrian timeline, read messianically, refutes the
exclusion — rated `plausible` because no source cited grants its grounds and
keeps the exclusion. He gives it two instances, Isaiah 9 and 11 and Micah 5:
either suffices (`scriptural_reading_prevails_without_postell`), and without
both nothing prevails (`nothing_prevails_without_the_counterexamples`). That
makes the ratings premises of the result, and says which one to contest.

**A premise can be load-bearing in one role and not another.** The sola
scriptura seed asserted in prose that the whole dispute reduces to whether
scripture teaches the principle. Split into the two jobs that premise does, the
claim is both weaker and sharper. It is *not* load-bearing for reaching the
conclusion — `hinge_not_load_bearing_for_conclusion` strips it and the
eliminative line still delivers — while `hinge_is_load_bearing_within_classical_strand`
holds within that strand alone. Against the self-refutation objection it is one
of *two* answers rather than the only one, since the objection's step is a
conjunction and either conjunct may be denied:
`classical_answer_blocks_self_refutation` denies one and
`scoping_blocks_self_refutation` the other. "The dispute reduces to the hinge"
was pointing at something true and describing it too broadly.

**A position its own cataloguer calls unworkable establishes the conclusion.**
Mathison files "solo scriptura" as Tradition 0 and judges it "unbiblical,
illogical, and unworkable". `tradition0_establishes` shows that, stated by
Geisler — who holds a version of it — rather than by its critic, it reaches sola
scriptura by its own route. This is the second time the pattern has appeared;
the New Perspective does the same for sola fide. Both results come from the same
discipline: encode a rival from a source that *holds* it, never from a
description of it.

**And one finding about the method rather than about an argument.** `Entails`
quantifies over the valuations satisfying the premises, so a premise set with no
model entails everything. A package assembled from contradictory premises would
establish its conclusion, the proof would close, and all four gates would pass —
a claim simultaneously proved, axiom-clean and empty. Nothing checked for it, and
`Satisfiable` did not exist. Twenty packages were audited, every one in the
library carrying a positive `Establishes` result, and **none was unsatisfiable**:
no result here was vacuous. Rule L11 now fails the build for a package that
establishes a conclusion without exhibiting a model, so that is a standing check
rather than a snapshot.

## Near term

**More messianic prophecies** ([#1], [#2]). The canonical dozen — Isaiah 53,
Psalm 22, Zechariah 9:9, Daniel 9, Psalm 110 — each with competing packages.
Then the first aggregate result: a `MessiahDefinition` with several criteria
and a `MeetsDefinition` theorem, which will expose how sensitive a cumulative
case is to its weakest link.

**The remaining solas** ([#3]). *Sola gratia*, *solus Christus* and
*soli Deo gloria*. *Sola scriptura* is no longer a seed: it now carries four
positions on tradition, three objections that do not reduce to one another, and
the two answers to the self-refutation objection.

**Corpus grounding** ([#4]). Importers so `Passage` values resolve against real
text data (BHSA, OSHB, STEPBible). At that point linguistic premises can cite
actual morphological annotation rather than a commentary's report of it — which
matters most for exactly the lexical premises that keep turning out to be
load-bearing.

## Systematic theology

The natural extension. Doctrine is already structured the way this library
wants: confessional standards state positions in numbered articles, and the
relations between doctrinal loci are exactly the dependency structure the
manifest machinery tracks.

- **Confessional standards as versioned, citable axiom sets**
  ([#6](https://github.com/testimonyproject/testimony/issues/6)) — the Nicene
  Creed, the Chalcedonian Definition, the Westminster Confession, the Catechism
  of the Catholic Church. Each becomes an `ArgumentPackage` whose atoms cite
  specific articles.
- **Cross-locus consistency checking.** Do a tradition's commitments on
  Christology, the atonement and justification cohere? This is a question about
  a set of formulas, and it is decidable for the propositional fragment.
- **Dependency tracing.** Which doctrines rest on which exegetical premises? If
  a reading of Romans 5 is abandoned, what else moves? Prose systematic
  theology cannot answer this; a generated manifest can.

The divinity of Christ is the obvious target and the hardest: it is a
cumulative argument drawing on the Johannine prologue, the *ego eimi* sayings,
worship texts, and the Chalcedonian settlement's reading of all of them. It
should be attempted only once the aggregate machinery has been tested on the
messianic prophecies, where the premises are simpler.

## Philosophical theology

This is why the substrate choice matters — though not quite in the way this
page used to claim. Foundation itself has **no** modal logic: its structure is
`Logic`, `Propositional`, `FirstOrder`, `SecondOrder`, `Meta` and `Vorspiel`,
and the `FirstOrder/Kripke` modules are Kripke semantics for *intuitionistic
first-order* logic, with no `□` and no `◇`.

The modal logic is a sibling package,
[`FormalizedFormalLogic/ModalLogic`](https://github.com/FormalizedFormalLogic/ModalLogic),
which depends on Foundation and so shares the `Semantics` and `Entailment`
interfaces this library already builds on. That is a smaller claim than the one
this paragraph made before, and a true one: the arguments needing `□` and `◇`
are reachable by *adding a dependency in the same family*, not by changing
foundations. The family also has neighbourhood semantics — which is what the
omnipotence paradoxes usually want, normal modal logic being too strong for
them — and a Lean 4 formalisation of Gödel's ontological argument. See
[#61](https://github.com/testimonyproject/testimony/issues/61) for the survey
and [#52](https://github.com/testimonyproject/testimony/issues/52) for the
work, which begins with a toolchain reconciliation.

**Nearer than the modal work, and currently invisible on this page**:
Foundation's `FirstOrder` is complete and unused here. Every argument so far is
propositional, and `SolaScriptura` records what that costs — its
doctrine/practice scope distinction "is carried by atom design and by this
docstring, not by the logic", because a propositional fragment cannot quantify.
That limitation is closable with no new dependency at all.

- **Divine attributes and their alleged incompatibilities.** The omnipotence
  paradoxes, and the foreknowledge/freedom problem — where the formal question
  is whether a set of attribute definitions is jointly satisfiable, which is
  precisely what a model-theoretic treatment settles.
- **The classical arguments.** Cosmological, ontological, moral. The
  ontological argument is the best-charted territory: Benzmüller and
  Woltzenlogel Paleo's machine-verified formalisation of Gödel's proof both
  demonstrates feasibility and illustrates the payoff, having discovered that
  Gödel's axioms collapse modal distinctions — a structural fact a century of
  prose commentary had missed.
- **Theodicy structures.** The logical problem of evil is a consistency claim
  about a premise set, which is the shape of problem this machinery handles
  best.

## Infrastructure

- **An assumption-manifest browser** ([#7]) on the docs site: every theorem,
  every premise it rests on, every citation, cross-linked.
- **Literate sources** ([#9]). Prose and Lean interleaved in the `.lean` files,
  in the coqdoc tradition, rendering to PDF. This is currently **blocked on tooling**
  rather than on effort. Alectryon plus LeanInk was the path, and
  [LeanInk is archived](https://github.com/leanprover/LeanInk) — last pushed in
  July 2024, pinned to Lean v4.6.0-rc1. [Verso](https://github.com/leanprover/verso)
  is actively developed and has a TeX backend, but it is HTML-first and inverts
  the model: documents embed Lean rather than Lean files carrying prose. Until
  one of those changes, `lake exe argtex` covers the part that matters most —
  the arguments themselves, typeset as logic.
- **Probabilistic and evidential reasoning** ([#10]), in a separate namespace,
  never conflated with deduction. Cumulative-case apologetics is Bayesian in
  structure, and pretending otherwise would misrepresent it.
- **API documentation** ([#8]). doc-gen4 arrives transitively via Foundation
  and the `Testimony:docs` facet works, but `lake build Testimony:docs` generates
  documentation for the entire Mathlib closure, which is far too slow to run in
  CI. Publishing API docs needs either a way to scope generation to this
  library's own modules, or a separately cached job. It is deliberately absent
  from the docs workflow until then.

## Development environment

- **A devcontainer** ([#11]), so that the toolchain is consistent and not only
  the worktree layout. Contributors should not have to install elan and match
  Lean v4.33.1 by hand.
- **Enforcing the worktree rule** ([#12]). Every other hard rule in CLAUDE.md
  is enforced by a command; this one is documented and unchecked.

## How deferred work is tracked

Everything above is a [GitHub issue][issues]; the [`roadmap`][label-roadmap]
label marks the items seeded from this page, and [`infra`][label-infra] the
build and developer-environment ones. This page says *why* a thing is worth
doing; the issue is where its state lives. When the two disagree, the issue is
current.

## What will not change

The conditional form of every result, the requirement that rivals be encoded
with equal care, and the prohibition on undeclared axioms. These are what make
the rest worth reading.

<!-- The issues this page seeds, as reference links: an inline link to one of
     them is wider than the 100 columns rule L12 holds this file to, and a
     reference link is the form that fits. -->

[#1]: https://github.com/testimonyproject/testimony/issues/1
[#2]: https://github.com/testimonyproject/testimony/issues/2
[#3]: https://github.com/testimonyproject/testimony/issues/3
[#4]: https://github.com/testimonyproject/testimony/issues/4
[#7]: https://github.com/testimonyproject/testimony/issues/7
[#8]: https://github.com/testimonyproject/testimony/issues/8
[#9]: https://github.com/testimonyproject/testimony/issues/9
[#10]: https://github.com/testimonyproject/testimony/issues/10
[#11]: https://github.com/testimonyproject/testimony/issues/11
[#12]: https://github.com/testimonyproject/testimony/issues/12
[issues]: https://github.com/testimonyproject/testimony/issues
[label-roadmap]: https://github.com/testimonyproject/testimony/issues?q=is%3Aissue+label%3Aroadmap
[label-infra]: https://github.com/testimonyproject/testimony/issues?q=is%3Aissue+label%3Ainfra
