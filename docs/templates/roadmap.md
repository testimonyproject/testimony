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
<!-- END GENERATED: lake exe statusgen -->

Twelve findings emerged that were not designed for.

**No single disputed reading decides sola fide.** The argument reaches "saved
through faith" by four routes, here called strands: Paul's "not by works of the
law" (Galatians 2:16), Jesus' "your faith has saved you" (Luke 7:50), Peter's
refusal of the law's "yoke" at the Jerusalem council (Acts 15:10), and Jesus'
"this is the work of God, that you believe" (John 6:29). Each strand depends on
one reading that a cited scholar denies. Remove any one and the others still
reach the conclusion. Remove one from every strand and it no longer follows
(`lexical_premises_jointly_load_bearing`). An opponent has to answer all four.

The argument first had two strands, and defeating Paul's reading and Luke's
together defeated it. Acts 15 and then John 6 changed that, and each change is
recorded as a result of its own: `apostolic_strand_survives_paul_and_luke` and
`johannine_strand_survives_the_other_three`. Each says that one strand reaches
the conclusion with the disputed readings of all the others set aside.

The strands are separate premises about separate texts. They are not separate
in the minds of readers: someone who takes "works of the law" (ἔργα νόμου) as
the practices that marked Israel off from the nations will read Peter's yoke
the same way, as Jervell does. The encoding cannot make that reader answer
twice. It does show that there are two texts to answer.

The πίστις Χριστοῦ dispute was expected to add a strand of its own, and did not.
Every text where the phrase occurs sets it against νόμος, so a route through the
genitive still passes through what ἔργα νόμου denotes. Encoded honestly, it is a
second disputed premise *inside* the Pauline strand. Deny it together with the
other strands' premises and sola fide fails
(`pistisChristou_jointly_load_bearing`); deny it alone and the other strands
still carry the argument (`pistisChristou_not_load_bearing`). The genitive is
the hinge of Paul's route, not of the conclusion, and it does not follow the
Old/New Perspective line: Dunn holds the objective genitive and the New
Perspective together.

The fourth strand, from John's Gospel, has the same shape as the others.
"This is the work of God, that you believe in him whom he has sent" (John 6:29)
delivers sola fide if that believing is trust, as Calvin reads it
(`johannine_strand_establishes`). It does not if the believing is faith made
alive by love, as Aquinas reads it
(`johannine_strand_rests_on_believing_as_trust`). Luther answers Aquinas from
Galatians 3:11–12: love is what the law commands, and "the law is not of faith"
(`luther_answers_aquinas_from_galatians`). The texts alone do not settle it;
Luther's step does, and Aquinas denies the step
(`luther_answer_rests_on_his_step`). Granting Aquinas his reading costs the
Reformed case this strand and not its conclusion
(`believing_as_trust_not_load_bearing`).

Adding John to the debate changed none of its verdicts. John's case ties with
Trent, with the apocalyptic reading and with Aquinas, each time between
positions rated `disputed`. With Trent set aside, John's
case is still not forced on the reader, because Aquinas's reading can still be
defended (`sola_fide_from_john_not_forced_without_trent`).

"Whoever does not obey the Son shall not see life" (John 3:36) is now treated
too. The commentators cited read "does not obey" as unbelief seen in what it
does (Westcott; Calvin). Chrysostom, preaching on the verse, denies that
believing is enough without a right life, arguing from Matthew 7:21
(`chrysostom_reads_john3_36_against_faith_alone`). The wording of the two texts
does not decide between them (`john3_36_leaves_faiths_sufficiency_open`), and
Chrysostom's conclusion cannot be held together with John's strand
(`chrysostom_cannot_be_held_with_johns_case`).

**A church father ties with the Reformed readings; he does not outrank them.**
Chrysostom's case is now heard in the main debate, with the Reformed answer to
it: the obedience John 3:36 and Matthew 7:21 require is sanctification, the
fruit of faith and not its ground (Ridderbos, Carson and Morris on the texts;
Schreiner, Hoekema and Murray on sanctification;
`chrysostom_grants_the_pauline_texts` shows he contradicts no verse of Paul's).
He meets every case that concludes faith suffices, and each meets him in return:
ties at `disputed`, so nothing he says is forced. One verdict moved. Without
Trent, Luke's "faith suffices" used to be forced; now Chrysostom stands against
it, and it is not (`luke_not_forced_without_trent`). What is forced without
Trent is Paul's gospel and the meaning of Paul's word
(`without_trent_pauls_gospel_and_word_prevail`) ([#86]).

**Sola fide's rivals deny different parts of it.** The conclusion is three
atoms — by grace, not by works, through faith — because a single atom could not
say what a rival keeps. Trent denies the second, by merit. The apocalyptic
reading denies the third and establishes the first two by its own route
(`apocalyptic_establishes_grace_not_works`). And the split shows which part the
strands are for: remove every lexical premise from every strand and grace and
"not by works" still follow, from the texts that say so in terms and the answer
to James (`grace_and_works_rest_on_no_lexical_premise`). The lexical disputes
decide *through faith alone* — whether the texts that exclude works also name
faith as the means — and, as encoded, nothing else.

**The ἔργα νόμου dispute is a dispute about Judaism.** The New Perspective's
reading of Paul's phrase is not a bare premise but an inference, Dunn's, from
Sanders' covenantal nomism; its critics answer by denying the ground, and
derive the Reformed reading from the denial. On their history Paul alone
carries sola fide (`critics_carry_the_pauline_strand`); on Sanders' he does not
(`sanders_costs_the_pauline_strand`). What the lexical question turns on is a
historical one about Second Temple soteriology. And what justification *is* —
forensic, or Christ present in faith — turns out to be a separate question
again: the Finnish reading of Luther denies the forensic account with Trent and
still establishes sola fide (`forensic_justification_not_load_bearing`). What
Trent's objection does rest on is its fuller definition — justification is the
renewal of the inward man, which grows through good works — against the
Reformed distinction of justification from the sanctification that follows it.
Put the distinction in its place and Trent's case no longer denies "not by
works" (`trent_objection_rests_on_its_definition`).

**Jesus' own words decide less than either side cites them for** ([#122]).
Luke 18:9–14, where the tax collector "went down to his house justified", is
Jesus' own teaching on justification and works, in Paul's word for it. The word
pronounces a verdict there, and the tax collector brings no meriting works.
Trent never cites Luke 18, but its case is consistent with every word of the
parable (`trent_grants_the_parable`), since nothing before justification,
"whether faith or works", merits it (Session VI, ch. 8). What divides them is
the step to "faith suffices", which Trent's dispositions (ch. 6) and canon 9,
applied to the parable, deny; so Luke 18 can be defended and is not forced
(`luke18_defensible`, `luke18_not_forced`), meeting Trent where Luke 7:50 does
(`whyLukeEighteenStandsAgainstTrent`). Matthew 7:21–23 and 19:16–22 are encoded
as readings, never as what the text plainly says: the texts alone leave open
whether obedience is a ground and whether the commandments are the way to life
(`matthew7_leaves_the_ground_open`, `matthew19_leaves_the_way_open`), and each
reading stands off against its rival. Heard together, Jesus' words force
nothing (`jesus_words_force_nothing`); heard without Trent, Luke's two sayings
are forced (`without_trent_luke_is_forced`) — that faith sufficed, not faith
alone — and Matthew is still not.

**Baptism, with its senses kept apart** ([#122]). Trent makes water baptism the
instrumental cause of justification, and chapter 4 qualifies it: "or the desire
thereof". Water, the Spirit and "fire" are separate atoms, and the readings of
the fire are encoded without a winner (`the_baptist_leaves_the_fire_open`). The
dilemma `whatTrentsInstrumentalCauseClaims` finds that nobody on record holds
the washing itself necessary for *justification* — even Feeney, who holds it
necessary for salvation, grants that the desire justifies — and that Feeney's
reading cannot be held with the thief read as Augustine reads him, nor with
Rome's own teaching on the desire. Read in Trent's own words, the claim meets
only the Reformed argument from the desire, at a step Aquinas contests. Of the
readings of John 3:5's water (`whatJohnThreeFiveMeans`), only the baptismal one
leaves Trent's step from the verse standing, and even then the step is
disputed. Acts giving the Spirit before the water and after it is common ground
(`trent_grants_god_is_not_bound`), not a Reformed win.

**As a dispute, only Paul's word prevails; sola fide and Trent each stand, and
neither is forced.** Weighed as a dispute — the four strands argued
separately, Trent, the apocalyptic reading, Sanders, the critics, Jervell,
Aquinas on John 6:29 and Luther's answer to him,
Paul's gospel in Galatians, Paul's word, and Trent read as a claim about that
word — one thing prevails outright: Paul's word, that δικαιόω does not denote
the renewal of the inward man (`only_pauls_word_prevails`). It prevails by two
routes: lexically, from the forensic sense, Paul's own words for renewal and the
rule of least meaning (Joos; Silva; Barr); and exegetically, from Romans 4:3–8,
where Paul glosses the righteousness counted to the ungodly as sin not counted.
Every link of each is rated `wellSupported` or better, so Trent read as a claim
about the word cannot be defended (`trent_on_pauls_word_indefensible`) — nor can
the Latin gloss it rests on, "being justified" as "being made righteous".
Every other party's weakest link is `disputed`, and every attack between Trent
and a Reformed party runs both ways, including a claim a party derives on the
way to its conclusion. So Luke's case, Paul's gospel and Trent — as Trent states
it, tied to neither reading — are each defensible and none forced (`dominical_case_defensible`,
`dominical_case_not_forced`, `gospel_defensible`, `gospel_not_forced`,
`trent_defensible`, `trent_not_forced`). The dilemma `whatTrentsDefinitionClaims`
says why: read as a claim about Paul's word, Trent's definition cannot be held
with the lexical and exegetical cases; read as a claim about what God does in
justifying, nothing about the word reaches it, and it parts from Paul at the
step from Galatians, that a verdict on a finished work excludes the renewal
wrought in us (`whereTrentPartsFromPaul`), and at the step from Romans 4 —
each rated `disputed`, because Augustine and Trent grant the texts and read them
the other way. Two hearings answer narrower questions. Heard as Rome and the
Reformers alone, only Paul's word is forced
(`reformation_dispute_forces_only_pauls_word`). Heard without Trent, Luke's case,
Paul's gospel and Paul's word are forced, but sola fide is still not — from Paul,
because of Campbell's reading of πίστις Χριστοῦ, or from Peter, because of
Jervell's reading of the yoke (`sola_fide_from_paul_not_forced_without_trent`,
`sola_fide_from_peter_not_forced_without_trent`). Luke's case is
attacked by no one but Trent, because no cited source argues that σῴζω at Luke
7:50 means healing. A search
for one found none, so that premise is rated `wellSupported`; and the dominical
case carries the Reformed reading of 7:47 — her love is the evidence of her
forgiveness, not its ground — as a premise. That reading is cited to Osvaldo
Padilla's narrative-critical study of Luke 7:36–50 and to Melanchthon's
*Apology of the Augsburg Confession*, which reads 7:47 by 7:50; both read 7:50
as salvation received by faith.

**Authorship is not a premise, and the encoding says what that costs.**
Ephesians, Titus and 1 and 2 Peter are each disputed, and each dispute is
catalogued from both sides. Grant every critical conclusion and sola fide still
follows (`authorship_not_load_bearing`), because the case reads them as
canonical scripture rather than as an apostle's testimony. The cost is that
they cannot then be evidence of what *Paul* meant by "works", so the premise
that he meant works in general rests on Romans 4, 9 and 11, which nobody
disputes.

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

**The Septuagint's "virgin", weighed rather than assumed.** Irenaeus's
argument — Jews translated Isaiah into Greek long before Christ and wrote
παρθένος — is encoded at full strength, and three results say what it does.
It rests on one claim, that παρθένος in the translator's Greek means a virgin
(`parthenos_is_load_bearing`). Rico and Gentry hold that claim, and Bratcher with
them; Wegner, Rhodea and Meade deny it, pointing to Genesis 34:3, where the Greek
calls Dinah a παρθένος after Shechem has lain with her. The Greek Pentateuch, the
corpus that verse comes from, uses the word in its laws where virginity is the
point (Leviticus 21:13–14, Deuteronomy 22:13–21), and a new article of the
ontology carries a sense found in a passage to the usage it belongs to
(`a_sense_in_a_usage_at_work`), so the laws' sense excludes Wegner's "not yet
'virgin'" by what the words mean. Genesis 34:3 itself is read under the law
of the seduced παρθένος (Exodus 22:15–16), which still calls the woman a man has
lain with a παρθένος and owed "the bride-price of virgins"; Genesis 34 tells
Shechem's act in that law's words. Weighed as a dispute, **the Septuagint's side
prevails** (`septuagint_prevails_over_wegner`): that reading of Genesis 34:3
defeats Wegner, and he, on a step rated `disputed`, cannot answer it. The
verdict turns on one rating, that reading's step, `plausible` because no reader
found grants its grounds and denies it, and no higher because none found makes
it; rated `disputed`, it would leave nothing prevailing, as before. The page
says where the evidence lies, which the ratings do not weigh. A third standard, Scripture
interprets Scripture, hears no dissent from a step grounded in Scripture alone unless the
dissent rests on Scripture too; under it Matthew's reading of the Greek word, from his
quotation of it of Mary, prevails over Wegner, and under the evidence standard the two stand
off (`matthew_step_turns_on_the_standard`).
Granted the word, the Septuagint shows
that a pre-Christian Jewish reader took the woman of 7:14 to be a virgin, not
what Isaiah's word means (`septuagint_word_rests_on_its_inference`), and its
future tense leaves open whether she conceives as one
(`septuagint_leaves_the_conception_open`). The two rival claims about παρθένος
exclude each other by their meanings — Wegner's says the word meant a young
woman and not yet a virgin — and the dispute's attacks are computed with that.

**"Her seed", read two ways.** The protoevangelium strand holds that Genesis 3:15, by naming the
seed as the woman's, marks a birth with no human father. Read as what the wording itself signifies,
that is Luther's argument, and it rests on his step (`her_seed_rests_on_its_inference`): Leupold and
Keil grant every ground and deny it, and so does Lewis, on grounds that do not need the promise
reading he doubts. Weighed against Leupold and Lewis, **nothing prevails**
(`nothing_prevails_over_her_seed`), but the tie is nearer to breaking against Luther than for him:
one rating, Lewis's step from Hagar and Rebekah, would break it against him, and two would be needed
to break it for him. Read as what the wording fits once fulfilled, Leupold and Keil grant it, and it
rests on the virginal conception rather than evidencing it (`whatHerSeedMarks`). The Septuagint's
"he" for the neuter σπέρμα may show that its translator read one person (`disputed`: Philo, its
earliest known reader, took it of the mind), and leaves the father open
(`the_greek_he_leaves_the_father_open`). The promise is also weighed as a promise: every term of the
verse is met as the New Testament names it (Galatians 4:4, Revelation 12:9, Hebrews 2:14, 1
Corinthians 15:3–4), and the fulfilment confirms that the verse was a promise, without needing the
virgin birth (`the_confirmation_does_not_need_the_virgin_birth`); with it, the seed was of the woman
alone (`seed_of_the_woman_alone`). Weighed against Westermann's denial that the verse is any
promise, **nothing prevails** (`nothing_prevails_over_the_promise`): his "a line of descendants and
not an individual" is answered from the Hebrew syntax of 3:15b, and that answer is `disputed` too.
So is the reading of the scene as a whole, in which the speaking serpent is the instrument of a
power the sentence falls on (its step `plausible`, its ground on the power `disputed`). Under the
Scripture standard, which hears no dissent from a step grounded in Scripture alone unless it rests
on Scripture too, Westermann is not heard and the fulfilment prevails
(`promise_turns_on_the_standard`). A dissent now counts only on evidence the texts leave standing:
Miller's "young widow" at Joel 1:8, a bride in the Greek, is struck from his dissent from the laws,
which still stands on Genesis 34:3 (`miller_survives_on_genesis`) — but only with his premise that
the noun there describes Dinah as she then was, which is his reading and not the text
(`miller_rests_on_the_noun`). And a credible dissent now stops counting when it is overruled in a
dispute that weighs the step at its floor: Miller's case from Genesis 34:3, a party in the dispute
over the Septuagint's word, cannot be defended there (`miller_indefensible`), so the laws' step
stands at its cited `wellSupported` under every standard (`laws_step_ratings`). On the way, the
strand's Miravalle citations were corrected: *Meet Mary*, which could not be checked, gave way to
the books where the passages are.

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
keeps the exclusion. He gives it two instances, Isaiah 9 and 11 and Micah 5. The
Micah instance is `disputed`: Rashi grants that Micah's ruler is the Messiah,
facing Assyria, and still reads 7:14 of a child of Ahaz's day, and Ibn Ezra gives
the reason, "the sign was given to Ahaz". So without the Isaiah instance nothing
prevails (`nothing_prevails_without_postell`), and the verdict rests on that one
step, still `plausible` because every reader found who keeps 7:14 near-term
reads Isaiah 9 of Hezekiah, denying a ground rather than the step. That makes
the ratings premises of the result, and says which one to contest.

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

**Jesus' rebuke of tradition settles less than it is cited for** ([#122]).
Mark 7 used to sit among sola scriptura's shared grounds, cited and read by no
step. As a line of its own, it delivers a principle — God's word judges human
tradition, and no commandment of men may be taught as God's word — and the
principle is common ground while "God's word" is left as each side uses it:
Rome's teaching office is "not above the word of God" (*Dei Verbum* 10), and
Trent can hold every word of it (`trent_grants_marks_principle`). Weighed as a
dispute, the principle prevails (`marks_principle_prevails`); sola scriptura
from Mark 7 and Trent can each be defended, and neither is forced
(`mark7_case_defensible`, `mark7_case_not_forced`,
`trent_defensible_against_mark7`, `trent_not_forced_against_mark7`). The dilemma
`whatTrentsTraditionIs` says why. Read as commandments of men, Trent's tradition
is what Mark 7 condemns and cannot be defended
(`trent_as_mens_commandments_indefensible`); heard against that reading alone,
Mark 7's case is unopposed (`mark7_forced_against_mens_commandments`), though it
still rests on two premises rated `disputed` that no party left in that hearing
contests. Read as the apostolic word handed on unwritten — what Trent says it
receives — Mark 7 does not reach it (`mark7_does_not_reach_the_apostolic_word`,
`against_the_apostolic_word_only_the_principle_is_forced`), and the dispute
moves to what the sola scriptura argument already turned on: whether any
unwritten tradition can now be shown to be apostolic — Whitaker's claim against
Bellarmine, a claim about proof — and whether the principle would then make
Scripture the *sole* infallible rule. Mark 7 is not alone in delivering the
principle: Jesus' sayings in John 10:35 and Matthew 5:18, and Paul's in
Galatians 1:8–9 and Colossians 2:8, 20–22, deliver it too
(`jesusAndPaulPrinciple_establishes`), at a step rated `wellSupported` because
Aquinas grants Galatians 1:8 and the principle with it. Added to Mark 7, they
still leave the sole rule open without that one premise
(`every_text_without_the_hinge_leaves_the_sole_rule_open`). The council at Jerusalem (Acts 15) is
read both ways. The Reformers read a council that let the gospel judge even the custom of Moses
and judged by Scripture, "as it is written" (15:15); Rome reads one binding with the Spirit's
authority, "it seemed good to the Holy Ghost, and to us" (15:28). Both pass through the apostles'
office: Calvin holds that it ended with them (Acts 1:21–22; 1 Corinthians 15:8), and *Lumen
Gentium* 20 that it continues in the bishops (Acts 1:20; 2 Timothy 2:2; 1 Clement 44), and the
texts alone leave that open (`apostolic_texts_leave_the_office_open`). Each grants the other's
texts, each step from them is `disputed`, and the two cannot be held together
(`acts15_readings_cannot_be_held_together`); the texts alone leave the council's authority open
(`acts15_texts_leave_the_council_open`), and what the council handed on was a letter, so Rome's
reading leaves the premise about unwritten tradition where it was
(`romes_reading_of_acts15_leaves_unwritten_tradition_open`). Moses' seat (Matthew 23:2–3) is
read both ways too. Calvin reads it as binding the hearers to the law taught from that seat
"only so far as" the scribes expound it, since in the same discourse Jesus condemns their
teaching on oaths (23:16–22); Cornelius a Lapide reads it as an authority of teaching that passes
to those who succeed to the seat, heeded in "all things not contrary to Moses and the Law".
Each step is `disputed`, the two cannot be held together
(`moses_seat_readings_cannot_be_held_together`), and Mark 7 with Matthew 23 leaves the office
open (`mark7_and_moses_seat_leave_the_office_open`). Rome's reading claims authority, not
infallibility, so it can be held with Mark 7's case for sola scriptura
(`romes_reading_of_moses_seat_can_be_held_with_mark7s_case`). Weighing the dispute also moved a
rating. Trent's claim that tradition is a coordinate source of revelation had
been `wellSupported`. Geiselmann grants Session IV and denies that it canonised
two coordinate sources, since the council replaced its draft's "partly … partly"
with "and", and Congar judges that Trent left the question open. So it is
`disputed` now, and the Tridentine party is named "Trent (Tradition II)" rather
than by the reading in dispute.

**A position its own cataloguer calls unworkable establishes the conclusion.**
Mathison files "solo scriptura" as Tradition 0 and judges it "unbiblical,
illogical, and unworkable". `tradition0_establishes` shows that, stated by
Geisler — who holds a version of it — rather than by its critic, it reaches sola
scriptura by its own route. This is the second time the pattern has appeared;
the New Perspective does the same for sola fide. Both results come from the same
discipline: encode a rival from a source that *holds* it, never from a
description of it.

**Spirit baptism, a question among Protestants, is an argument of its own**
([#122]). At conversion (Dunn, Stott), after it (the Assemblies of God; the
Church of the Nazarene), or in baptism and confirmation (Rome; Lutherans hold
the first half): weighed as a dispute, nothing is forced
(`spirit_baptism_forces_nothing`). The conversion and sacramental views can be
held together against a second baptism to seek, the two subsequence views can be
held together for one, and each camp can be defended and is not forced
(`conversion_defensible`, `conversion_not_forced`, `pentecostal_defensible`,
`pentecostal_not_forced`). It turns on the Acts narratives: read for what its
claims mean, the Pentecostal view must take them as a pattern, since Stott's
"not a pattern" excludes its premise
(`pentecostal_cannot_read_acts_as_transitions`), and read as a pattern they
meet the variety of Acts itself. The holiness reading meets Wesley, who held the second work
and declined to call it receiving the Holy Ghost, and the Nazarene seminary
faculty, who keep entire sanctification and no longer hold the reading tenable.
Tongues as initial evidence, and whether Paul and Luke mean the same by
"baptized in the Spirit", are not yet encoded.

**What Scripture settles about the procession of the Spirit is what LST says it
settles** ([#216]). Ken Kibbey's *Living Systematic Theology* grades its own
claims, and its section on the Triune God says the texts "establish a real
relation of the Spirit to both Father and Son" but do not state that his eternal
origin is "from the Father and the Son". Both grades hold of the texts it cites
(`lstCase_establishes`, `texts_leave_the_filioque_open`), and the second still
holds when John 16:14, the verse Aquinas rests on, is added
(`john16_14_leaves_it_open_too`). Each side needs a reading of its own beyond the
texts. The West has three (John 16:14, the Son's sending, Aquinas's argument
from distinction) and the East two (the Lord's words in John 15:26, the
monarchy of the Father). No single reading carries either side, but each side
needs at least one of them (`western_rests_on_no_one_reading`,
`western_needs_one_of_its_readings`, and their Eastern counterparts). Weighed as
a dispute, what the texts establish is forced and nothing more
(`the_texts_prevail`); the West and the East stand off, each defensible and
neither forced. The rating audit found readers who grant the mission step's
grounds and deny its conclusion (Moltmann, Bobrinskoy, Staniloae), and a Roman
document that grants the monarchy step's grounds while confessing the Filioque
(the Pontifical Council for Promoting Christian Unity, 1995). That second
finding suggests the two sides may mean different things by "proceeds", which
is not yet encoded. LST's other graded claims in §3 (each person God; order
without inequality; eternal generation) are tracked in the same issue.

**The texts of the Son's obedience establish an order, and leave open both
questions read into them** ([#216]). LST says these texts (John 5:19–30; 14:28;
20:17; 1 Corinthians 11:3; 15:28) "establish real personal and mediatorial
order, but they do not by themselves establish inequality of divine nature or an
eternal hierarchy of command and obedience". All three parts hold
(`lstOrder_establishes`, `order_texts_leave_lesser_divinity_open`,
`order_texts_leave_eternal_authority_open`). John 14:28 gets four readings: the
Arians' lesser divinity, Augustine's two forms, Athanasius's "greater" as the one
the Son is from, and Calvin's humbled Mediator, who denies that the verse speaks
of either nature. Weighed, the order is forced (`the_order_prevails`) and every
reading beyond it stands off, the Arian one included
(`arian_reading_defensible`): the order texts alone do not settle the Son's
divinity, which LST confesses from other texts. Grudem and Ware's eternal order
of authority and Giles's denial of it stand off too. The audit placed both
disputes in readings, not steps: Sirmium (357) and Gregory of Nazianzus's
opponents grant "greater as the one he is from" and still conclude a lesser
Godhead, and Grudem grants the Son's equality in power while denying that eternal
submission contradicts it.

**Sola gratia divides its rivals only once it is stated sharply, and its
readings are not where they part** ([#24]). Trent and the Remonstrants both say
salvation is by grace, and both reach that part of the conclusion
(`rivals_hold_salvation_by_grace`). What separates them from Dort is two further
claims: that the grace that saves brings about the consent it seeks, which the
Remonstrants deny (`remonstrants_deny_effectual_grace`), and that the will is
passive in being made alive, which Trent's fourth canon denies
(`trent_denies_passivity`). The Reformed case runs through Ephesians 2 and
through Romans 9:16, and needs one of the two readings and not both
(`touto_not_load_bearing`, `romans_reading_not_load_bearing`,
`readings_jointly_load_bearing`). The rating audit found that the readings
themselves are widely granted: Robertson reads "this" in Ephesians 2:8 as Hoehner
does, and Arminius and Abasciano read Romans 9 as being about salvation. The
dissent is at the steps after them. Robertson and Calvin deny that the verse
makes faith the gift; Arminius grants that faith is God's gift and denies that
it cannot be refused (`gift_of_faith_does_not_settle_resistibility`); and
Aquinas grants each half of Trent's canon while holding grace infallibly
effectual. The strongest objection, that the Spirit is resisted, grieved and
quenched and one sin against him never forgiven, starts from texts every party
grants; each route from them to grace that can be *finally* refused needs a
reading a cited reader denies, and Augustine himself grants the unforgivable sin
is impenitence to the end while holding saving grace irresistible. The
Lutherans of the Formula of Concord hold the will passive in conversion and
grace resistible, which made the step from "God's work alone" to irresistible
grace a disputed step of its own (`lutheranPosition_establishes`). The third
way, an ability given as Adam was made able, received by faith alone, leaves
resistibility open (`third_way_leaves_resistibility_open`) until it says what
kind of help the ability is, and Augustine's "help without which" and "help by
which" are the two horns of its dilemma. Supposing the contrary, that the grace
that saves can be finally refused, has no model beside the Reformed reading of
either text, with the claims read as they mean
(`final_refusal_cannot_be_held_with_the_scriptures`). Weighed as one dispute,
only salvation by grace is settled before any choice (`only_grace_prevails`).
The Thomists were expected to reach the whole sharpened conclusion, and they
reach part of it. They reach grace effectual of itself
(`thomists_reach_effectual_grace`), at a step the Molinists dispute. On the
will's passivity their premises decide nothing (`thomists_leave_passivity_open`),
because Garrigou-Lagrange's "not merely passive" places the will's consent after
grace in the order of efficient cause, and a dilemma answers both readings of
it. Weighed, neither Dort nor the Thomists defeats the other
(`dort_stands_with_the_thomists`), because the Thomist position takes no side on
passivity; and the Thomists and Trent on the Molinist reading stand off, as Rome
left them in 1607.

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

**The remaining solas** ([#3]). *Solus Christus* and *soli Deo gloria*.
*Sola scriptura* is no longer a seed: it now carries four positions on
tradition, three objections that do not reduce to one another, the two answers
to the self-refutation objection, and a dispute over what Jesus' rebuke of
tradition in Mark 7 decides. *Sola gratia* is encoded with Trent and the
Remonstrants as its rivals, and the Lutherans, Wesley and a third way between
them, and the Thomists, weighed as one dispute ([#24]); the perseverance of the
saints is weighed beside it, Westminster against Augustine and Aquinas, Trent,
the Lutherans and Wesley. What it lacks is John 6:44 as a third strand, and
1 John 3:9 on perseverance.

**The rest of the Triune God** ([#216]). The procession and the order texts are
encoded; LST §3's other graded claims are not. They are that each person is God
and the three are not three gods, against the Arians, the modalists and the "a
god" of John 1:1 in the New World Translation; and that eternal generation is a
defended synthesis. Then the "through the Son" of the Greek fathers as a third
position on the procession, and an article check of LST's own sentences.

**Corpus grounding** ([#4]). Importers so `Passage` values resolve against real
text data. The Greek New Testament has begun: John, Colossians, Titus and Hebrews
are imported from MACULA Greek's annotation of the SBLGNT, so a claim about what
the Greek contains is checked against the data ([The Greek text as
data](./corpus.md), [#247]). The Hebrew Bible (BHSA, OSHB) is still to come.
Linguistic premises can then cite actual morphological annotation rather than a
commentary's report of it, which matters most for exactly the lexical premises
that keep turning out to be load-bearing.

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

- **Premise-to-result cross-links** ([#7]) on the docs site. `lake exe argdoc`
  already generates a page per argument that numbers every claim with its
  source and lists every package and result. Missing is the link from each
  result to the premises it rests on, and back from a premise to every result
  that would fall with it.
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
[#24]: https://github.com/testimonyproject/testimony/issues/24
[#4]: https://github.com/testimonyproject/testimony/issues/4
[#247]: https://github.com/testimonyproject/testimony/issues/247
[#7]: https://github.com/testimonyproject/testimony/issues/7
[#8]: https://github.com/testimonyproject/testimony/issues/8
[#9]: https://github.com/testimonyproject/testimony/issues/9
[#10]: https://github.com/testimonyproject/testimony/issues/10
[#11]: https://github.com/testimonyproject/testimony/issues/11
[#86]: https://github.com/testimonyproject/testimony/issues/86
[issues]: https://github.com/testimonyproject/testimony/issues
[label-roadmap]: https://github.com/testimonyproject/testimony/issues?q=is%3Aissue+label%3Aroadmap
[label-infra]: https://github.com/testimonyproject/testimony/issues?q=is%3Aissue+label%3Ainfra
[#216]: https://github.com/testimonyproject/testimony/issues/216
[#122]: https://github.com/testimonyproject/testimony/issues/122
