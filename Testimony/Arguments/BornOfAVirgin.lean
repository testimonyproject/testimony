import Testimony.Arguments.BornOfAVirgin.Atoms
import Testimony.Arguments.BornOfAVirgin.Sources
import Testimony.Arguments.BornOfAVirgin.Lines
import Testimony.Arguments.BornOfAVirgin.Packages
import Testimony.Arguments.BornOfAVirgin.Results
import Testimony.Arguments.BornOfAVirgin.Dispute

/-!
# Arguments.BornOfAVirgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3

Matthew 1:22–23 quotes Isaiah 7:14 as grounds that the Messiah is born of a
virgin. Unlike Micah 5:2 (see `BornInBethlehem`), the predictive reading here is
heavily disputed, and the dispute is lexical: the Hebrew עַלְמָה (*almah*) means
"young woman" and does not by itself mean "virgin", while the Septuagint's
παρθένος does. Isaiah's immediate context — a sign to Ahaz, apparently fulfilled
within the prophet's own generation (cf. Isa 8:3–4) — is read by most critical
and much Jewish scholarship as having nothing to do with a future Messiah.

The argument now runs on **four scriptural strands**, and that changes its
shape. Each is encoded as a `Line` — its own grounds, its own inference step,
what it delivers — and the packages are assembled from those rather than from
flat premise lists. `Lines.lean` is where the shape of the argument is legible
in one screen.

**The Isaianic strand** is the one above, hinging on *almah*.

**The protoevangelium strand** reads Genesis 3:15 — enmity between the serpent's
seed and "her seed", זֶרַע הָאִשָּׁה — as the first promise of a redeemer, and
takes the matrilineal wording to mark a birth with no human father, since
Hebrew ordinarily reckons זֶרַע through the man. That last step is genuinely
contestable and is marked `disputed`: Genesis itself speaks of a woman's seed
in wholly ordinary contexts (Gen 16:10 to Hagar, 24:60 to Rebekah), so the
wording at 3:15 is not the anomaly the argument needs it to be unless the
reader already grants the messianic reading.

**The Michean strand** reads Micah 5:2–3 — "until the time when she who is in
labour has given birth" — as naming a mother and no father for the coming
ruler. The objection is immediate and is encoded as the rival: this is an
argument from silence, and an oracle about a woman in labour has no occasion to
mention a father.

**The referential strand answers the lexical dispute without entering it.**
`almah` need not *mean* "virgin" for Mary to *be* an `almah`. Genesis settles
the compatibility outright: Rebekah is an עַלְמָה at 24:43 and a בְּתוּלָה "whom no
man had known" at 24:16, the same woman under both terms. Mary was a betrothed
young woman of marriageable age and conceived as a virgin, so she answers
Isaiah's description on anyone's lexicon — and `semantic_establishes` shows
that Matthew's claim therefore never required the sense the objection demands.

That reply has a price, and `compatibility_does_not_establish_criterion` names
it: the argument is purely defensive. It defeats the objection without
delivering the criterion, which still has to come from one of the four
scriptural strands. What it buys is that *losing* the lexical dispute no longer
costs the fulfilment claim.

**The versional evidence is encoded in full, including the half that tells
against the reading.** Targum Jonathan renders עוּלֵימְתָא, "young woman", and does
not read 7:14 messianically though it reads 9:5–6 and 11:1 so; Aquila,
Symmachus and Theodotion render νεᾶνις. Against them, the pre-Christian
Septuagint renders παρθένος and the Syriac Peshitta ܒܬܘܠܬܐ, both "virgin" — so
the Aramaic evidence is itself split, Jewish against Christian. 1QIsaᵃ confirms
עַלְמָה in the Hebrew, so no textual variant rescues either side; the dispute is
purely semantic. The usual Christian reply, that the Three revised against
Christian use, is recorded but not leaned on: Theodotion's version is arguably
pre-Christian, and the module says so rather than passing over it.

`compatibility_defeats_lexical_objection` is where the tension pays off.
Granting every versional datum and adding the referential premises, the
objection no longer reaches its conclusion — because once virginity is
compatible with the word, four translators making four different choices about
how much of the referent to make explicit is not evidence about the sense.

**Wegner's objection is encoded in its sharpest form, and the module shows the
circle in it rather than alleging one.** Wegner does not merely say that
עַלְמָה means "young woman". He says that הָרָה at Isaiah 7:14 is a predicate
adjective, so the clause reads "the עַלְמָה *is* pregnant" — already, when the
sign is given — and a pregnant woman is not a virgin; the one clear Isaianic
case then settles the word. `wegner_establishes` grants him every premise and
checks that the argument goes through, because a rival worth answering has to
be stated at full strength first.

The parse is not the weak point, and the encoding says so by granting it
throughout: Rydelnik — cited here through Postell, who reports him at 474 —
reads the same predicate adjective and draws the opposite conclusion, that the
virgin *is* pregnant and the sign is therefore as deep as Sheol. What the
grammar does not supply is that the pregnancy is an *ordinary* one, and that is
the premise that excludes virginity. `wegner_needs_ordinary_pregnancy` removes
it and the objection stops. `readingSuppliesOrdinaryPregnancy` then supplies it
the way Wegner's own case does — from the near-term reading of the sign — and
with the lexical conclusion turned back against that reading, the two legs
close. `circle_leaves_the_lexical_conclusion_open` and
`circle_leaves_the_denial_open` are the result: keep every uncontested datum,
and *neither* end is settled — not established, and not refuted either. A cycle
of implications is satisfied outright by a valuation on which all of its nodes
are false, and equally by one granting Wegner's own conclusion. Nothing enters
the loop, so nothing comes out of it, in either direction. That is a
demonstration rather than a complaint, and it is conditional in the usual way:
a defender of Wegner should deny `readingSuppliesOrdinaryPregnancy` and argue
that the near-term reading stands on the historical evidence alone.

Postell's second reply is independent of the first and survives that defence.
The other clear עַלְמָה passages Wegner himself lists are cases of virgins, so a
single referent cannot be what settles the denotation — the same principle
would settle it the other way. `usage_parity_blocks_wegner` checks it, and the
atom is marked `plausible` rather than `wellSupported` because Postell's "in
fact virgins" is stronger than Wegner's own discussion of Song 6:8.

The critical case against the Isaianic strand is now *derived* rather than
assumed. `critical` used to carry `¬isaiahPredictsVirginBirth` as a bare
premise; it now carries the step that produces it — that a sign given for
Ahaz's generation is not also a prediction of a virgin conception — and
`criticalDenial_establishes` checks that the step works. Berry supplies the
objection: how Isaiah 7:14 was fulfilled in Ahaz's own day is itself an open
question, and `berry_blocks_critical_denial` shows that granting him that much
takes the exclusion out. It does no more than that. It does not establish the
predictive reading and it does not touch the lexical dispute.

Berry also supplies a *defensive* lexical premise — that the semantic range of
עַלְמָה does not exclude "virgin" — and `admissibility_is_not_enough` measures
what it is worth: nothing, on its own. *May mean* is not *does mean*, and the
whole Isaianic strand lives in that gap.

**The compositional strand** (Postell) declines the lexical fight altogether.
Isaiah 7 sits inside Isaiah 2–12, a unit framed by eschatological vision at
2:1–4 and 11:1–12:6; on the principle that an oracle's meaning in a finished
book is set by its literary placement rather than by the events it describes —
argued from the making of canonical Jeremiah — 7:14 anticipates a future,
miraculous birth. The hinge is `compositionGovernsMeaning`, and a reader who
holds that an oracle's historical setting fixes its sense rejects it outright.

Postell also supplies the module's sharpest rival-defeater. `parityDefeats`
`NearTermExclusion` observes that Isaiah 9:5–6 and 11:1–10 are read as messianic
without reservation *and* stand on the same near-term Assyrian timeline as 7:14
— the invasion of 8:7–8, the oppressor's rod of 10:5. So a near-term setting
cannot be what rules out messianic reference, or it would rule out 9 and 11 too.
`parity_blocks_critical_denial` checks it. Notably the Targum is cited *for*
this premise: it reads 9:5–6 and 11:1 messianically while declining to read 7:14
so, which makes it a hostile witness and therefore a strong one.

That gives the critical exclusion step two independent defeaters. Berry's is
evidential — we do not know how the sign was fulfilled in Ahaz's day. Postell's
is structural — the near-term setting was never the right kind of reason.

**Taken together, the positions make a dispute, and the dispute has an outcome
the entailment results cannot state.** `Dispute.lean` treats the scriptural
reading, the critical denial, Berry, Postell and Motyer as the nodes of an
argumentation framework and proves who defeats whom — a defeat being an attack
derived from entailment that the cited confidences do not block. Against the
scriptural reading alone, `nothing_prevails_unanswered`: the critical denial and
the scriptural reading defeat each other, because the weakest premise on each
side is `disputed` (`christian_defeats_critical`). Hear Berry and Postell, and
`scriptural_reading_prevails_once_replies_are_heard`: nothing defeats the
replies — Berry, Postell, and Motyer with Compton — they defeat the critic, and
so they defend the scriptural reading against its only defeater. The critic is
left with no defence at all (`critical_denial_indefensible`), and Motyer, who
denies the critic's other premise, is enough on his own
(`scriptural_reading_prevails_on_motyer_alone`). His reply rests on an
inference rather than an observation, and `motyer_rests_on_his_inference` says
so. That outcome turns on the critic's premises
being rated `disputed`, as the replies, Motyer and Compton contest them; with
the exclusion premise rated `wellSupported`, as it once was, the dispute was a
standoff.

`hinges_jointly_load_bearing` is the result worth having. No single interpretive
hinge carries the argument any more — strip *almah* and the other three strands
still deliver the criterion, which `almah_not_load_bearing` records. Strip all
four and the argument collapses. `almah_is_load_bearing_alone` keeps the
pre-Miravalle finding on the books: within the Isaianic strand taken by itself,
the lexical premise still carries everything.

**The magisterial strand is encoded separately and is not part of `christian`.**
Papal teaching on Mary's virginity in conceiving, as collated by Miravalle, is
a Roman Catholic premise; this library's author does not grant that magisterial
teaching settles doctrinal questions, and the encoding says so rather than
quietly folding it in. `catholic` is the package for a reader who does grant it.
`magisterial_authority_is_load_bearing` shows what follows for a reader who does
not: that route yields nothing on its own, and the four scriptural strands have
to carry the argument by themselves. The rival is cited to Westminster I.x.

Matthew's and Luke's birth narratives agree on the virgin conception while
differing in nearly every other detail, and that convergence is encoded as a
multiple-attestation premise — though the independence of the two traditions is
itself debated, and is marked `plausible` rather than `wellSupported`.

## Where things are

This argument is a directory, because at fourteen hundred lines it was one file
that no one could hold in view. The dependencies run one way.

| File | Contents |
|---|---|
| `Atoms.lean` | the `Claim` atoms, the recurring sources, the intertextual edges, the criterion |
| `Sources.lean` | `cite`: a citation and a classification for every atom |
| `Lines.lean` | the inference steps, and the lines of reason they compose into |
| `Packages.lean` | the positions, and the variant packages the results refute |
| `Results.lean` | every `@[headline]` result, with its trust base |
| `Dispute.lean` | the five positions as one dispute: who defeats whom, and who prevails |

Shared material lives further out: passages and citation bundles in
`Testimony.Scripture`, the `Line` and `caseOf` vocabulary in
`Testimony.Logic.Line`, and the `establish` and `refute_with` tactics in
`Testimony.Logic.Tactic`.
-/
