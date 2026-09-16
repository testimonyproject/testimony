import Testimony.Attr
import Testimony.Argument
import Testimony.Bib.Works

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
shape.

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
delivering the criterion, which still has to come from one of the three
prophetic strands. What it buys is that *losing* the lexical dispute no longer
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

`hinges_jointly_load_bearing` is the result worth having. No single interpretive
hinge carries the argument any more — strip *almah* and the other two strands
still deliver the criterion, which `almah_not_load_bearing` records. Strip all
three and the argument collapses. `almah_is_load_bearing_alone` keeps the
pre-Miravalle finding on the books: within the Isaianic strand taken by itself,
the lexical premise still carries everything.

**The magisterial strand is encoded separately and is not part of `christian`.**
Papal teaching on Mary's virginity in conceiving, as collated by Miravalle, is
a Roman Catholic premise; this library's author does not grant that magisterial
teaching settles doctrinal questions, and the encoding says so rather than
quietly folding it in. `catholic` is the package for a reader who does grant it.
`magisterial_authority_is_load_bearing` shows what follows for a reader who does
not: that route yields nothing on its own, and the three scriptural strands have
to carry the argument by themselves. The rival is cited to Westminster I.x.

Matthew's and Luke's birth narratives agree on the virgin conception while
differing in nearly every other detail, and that convergence is encoded as a
multiple-attestation premise — though the independence of the two traditions is
itself debated, and is marked `plausible` rather than `wellSupported`.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony Testimony.Bib Testimony.Logic

/-- Isaiah 7:14 — the sign of the *almah* who conceives and bears a son. -/
@[nolint defsWithUnderscore] def isaiah7_14 : Passage := ⟨.isaiah, 7, 14⟩

/-- Matthew 1:23 — Matthew's citation of Isaiah via the Septuagint. -/
@[nolint defsWithUnderscore] def matthew1_23 : Passage := ⟨.matthew, 1, 23⟩

/-- Genesis 3:15 — the protoevangelium, and the "seed of the woman". -/
@[nolint defsWithUnderscore] def genesis3_15 : Passage := ⟨.genesis, 3, 15⟩

/-- Micah 5:3 — "until the time when she who is in labour has given birth". -/
@[nolint defsWithUnderscore] def micah5_3 : Passage := ⟨.micah, 5, 3⟩

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- Isaiah 7:14 predicts a virgin conceiving, fulfilled in the Messiah. -/
  | isaiahPredictsVirginBirth
  /-- עַלְמָה in Isaiah 7:14 denotes a virgin, not merely a young woman.
  **The Isaianic hinge.** -/
  | almahMeansVirgin
  /-- The semantic range of עַלְמָה does not exclude the sense "virgin" at
  Isaiah 7:14. Weaker than `almahMeansVirgin`, and deliberately so. -/
  | almahAdmitsVirginSense
  /-- עַלְמָה denotes a young woman of marriageable age. The lexical ground both
  sides of the dispute actually share. -/
  | almahDenotesMarriageableYoungWoman
  /-- Being a virgin does not exclude a woman from that denotation: Rebekah is
  an עַלְמָה at Genesis 24:43 and a בְּתוּלָה "whom no man had known" at 24:16. -/
  | virginityCompatibleWithAlmah
  /-- Mary at the conception was a betrothed young woman of marriageable age —
  an עַלְמָה on anyone's lexicon. -/
  | maryWasAnAlmah
  /-- Mary answers the description at Isaiah 7:14 whether or not עַלְמָה denotes
  virginity. **The conclusion of the referential argument.** -/
  | maryFitsIsaianicDescription
  /-- Matthew's fulfilment claim requires that עַלְמָה itself denote virginity.
  **The assumption the lexical objection needs**, and the one the referential
  argument attacks. -/
  | lexicalSenseRequiredForFulfilment
  /-- The Septuagint renders עַלְמָה as παρθένος. -/
  | lxxRendersParthenos
  /-- Targum Jonathan renders עַלְמָה as עוּלֵימְתָא, "young woman". -/
  | targumRendersUlemta
  /-- Aquila, Symmachus and Theodotion render νεᾶνις, "young woman". -/
  | theThreeRenderNeanis
  /-- The Syriac Peshitta renders ܒܬܘܠܬܐ, "virgin". -/
  | peshittaRendersBtulta
  /-- 1QIsaᵃ reads עַלְמָה, so no textual variant bears on the sense. -/
  | qumranConfirmsAlmah
  /-- The split among the ancient versions shows עַלְמָה does not denote
  virginity. The critical inference from the versions. -/
  | versionalDivergenceRefutesVirginSense
  /-- Matthew 1:23 quotes Isaiah 7:14. -/
  | matthewQuotesIsaiah
  /-- Matthew's quotation intends the virgin conception as fulfilment. -/
  | matthewIntendsFulfilment
  /-- Isaiah 7 sits inside Isaiah 2–12, a unit framed by eschatological vision
  at 2:1–4 and 11:1–12:6. -/
  | isaiah2to12FramedByEschatology
  /-- An oracle's meaning in the finished book is set by its literary placement,
  not by the historical events it describes. **The compositional hinge.** -/
  | compositionGovernsMeaning
  /-- Isaiah 9:5–6 and 11:1–10 are read as messianic without reservation. -/
  | isaiah9And11AreMessianic
  /-- Isaiah 9 and 11 sit on the same near-term Assyrian timeline as 7:14. -/
  | isaiah9And11ShareTheAssyrianTimeline
  /-- Read compositionally, Isaiah 7:14 anticipates a future, miraculous birth
  rather than one in Ahaz's generation. -/
  | compositionalReadingYieldsFutureBirth
  /-- Genesis 3:15 promises victory over the serpent through "her seed". -/
  | genesis3_15SeedOfTheWoman
  /-- Genesis 3:15 is the protoevangelium: the first promise of a redeemer. -/
  | genesis3_15IsProtoevangelium
  /-- Hebrew זֶרַע is ordinarily reckoned through the father, so a seed named as
  the woman's is a departure from the idiom. -/
  | seedReckonedThroughFather
  /-- That departure marks a birth with no human father. **The protoevangelium
  hinge.** -/
  | seedOfTheWomanImpliesNoHumanFather
  /-- Micah 5:3 names only "she who is in labour" as bearing the coming ruler,
  with no father mentioned. -/
  | micah5_3NamesMotherOnly
  /-- That maternal-only reference indicates a birth with no human father.
  **The Michean hinge.** -/
  | maternalSilenceImpliesNoHumanFather
  /-- Mary conceived Jesus while a virgin. -/
  | maryConceivedAsVirgin
  /-- Matthew and Luke are independent traditions agreeing on the virgin
  conception. -/
  | independentAttestation
  /-- Isaiah 7:14 is a near-term sign to Ahaz, fulfilled in Isaiah's own
  generation. The critical reading. -/
  | isaiahIsNearTermSignToAhaz
  /-- A sign given for Ahaz's generation is not also a prediction of a virgin
  conception. **The critical inference**, which the earlier encoding of this
  module left implicit. -/
  | nearTermExcludesMessianicSense
  /-- How Isaiah 7:14 was fulfilled in Ahaz's own day is itself an open
  question. Berry's objection to the premise above. -/
  | nearTermFulfilmentIsUnclear
  /-- Genesis 3:15 is an etiology of the enmity between snakes and humans, and
  "her seed" is simply her descendants. The critical reading. -/
  | genesis3_15IsEtiology
  /-- The absence of a father in Micah 5:3 is an argument from silence: an
  oracle about a woman in labour has no occasion to mention one. -/
  | maternalSilenceProvesNothing
  /-- Papal teaching affirms that Mary conceived while remaining a virgin. -/
  | magisteriumTeachesVirginalConception
  /-- Magisterial teaching settles the question. **The Roman Catholic premise
  this library's author does not grant.** -/
  | magisteriumIsDoctrinallyAuthoritative
  /-- Scripture is the supreme judge of controversies of religion. The Reformed
  denial of the premise above. -/
  | scriptureIsSupremeJudge
  /-- The Messiah must be born of a virgin. -/
  | messiahBornOfVirgin
  /-- Jesus satisfies the virgin-birth criterion. **The conclusion.** -/
  | jesusSatisfiesCriterion
deriving DecidableEq, Repr

/-- Shorthand for an atomic formula. -/
abbrev p (c : Claim) : Formula Claim := .atom c

/-- Negation, as Foundation defines it. -/
abbrev notP (c : Claim) : Formula Claim := .imp (.atom c) .falsum

/-- Matthew explicitly quotes Isaiah, via the Septuagint's παρθένος. -/
def quotationEdge : IntertextEdge :=
  { fromPassage := matthew1_23
  , toPassage := isaiah7_14
  , relation := .quotation
  , source :=
      { primary := .work na28 (.apparatus matthew1_23)
      , supporting := [.work ubs5 .whole]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- Genesis 3:15 read as promise rather than quotation. Typed as `.promise`,
not `.prediction`: what Miravalle argues is that the protoevangelium *commits*
to a redeemer born of a woman, and collapsing that into a prediction would beg
the question the Michean and Isaianic strands are also asking. -/
def protoevangeliumEdge : IntertextEdge :=
  { fromPassage := matthew1_23
  , toPassage := genesis3_15
  , relation := .promise
  , source :=
      { primary := .work miravalleMeetMary (.pages 9 10)
      , tradition := .romanCatholic
      , confidence := .disputed } }

/-- Micah 5:3's maternal reference, read as a messianic theme rather than a
verbal link — there is no quotation of Micah 5:3 in the birth narratives. -/
def micahMaternalEdge : IntertextEdge :=
  { fromPassage := matthew1_23
  , toPassage := micah5_3
  , relation := .messianicTheme
  , source :=
      { primary := .work miravalleMeetMary (.pages 9 10)
      , tradition := .romanCatholic
      , confidence := .disputed } }

/-- The Christian predictive reading of Isaiah 7:14. Far more contested than
Micah 5:2 — see the module doc. -/
def predictiveReading : Interpretation :=
  { passage := isaiah7_14
  , reading :=
      "Isaiah 7:14 predicts a virgin conceiving and bearing 'Immanuel', " ++
      "fulfilled in the virgin birth of the Messiah"
  , asRelation := some .prediction
  , source :=
      { primary := .work motyerIsaiah (.adLoc isaiah7_14)
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- Miravalle's reading of Genesis 3:15: the seed is named as the woman's, and
no man is involved in the conception it promises. -/
def protoevangeliumReading : Interpretation :=
  { passage := genesis3_15
  , reading :=
      "Genesis 3:15 promises a redeemer born of the woman's seed, with no " ++
      "human father implied by the wording"
  , asRelation := some .promise
  , source :=
      { primary := .work miravalleMeetMary (.pages 9 10)
      , tradition := .romanCatholic
      , confidence := .disputed } }

/-- Miravalle's reading of Micah 5:2–3: the oracle names a mother and no
father for the ruler who comes forth from Bethlehem. -/
def maternalReading : Interpretation :=
  { passage := micah5_3
  , reading :=
      "Micah 5:2–3 names only the woman in labour as bearing the coming " ++
      "ruler, mentioning no father"
  , asRelation := some .messianicTheme
  , source :=
      { primary := .work miravalleMeetMary (.pages 9 10)
      , tradition := .romanCatholic
      , confidence := .disputed } }

/-- The criterion this argument establishes a candidate must meet. -/
def bornOfAVirgin : FulfillmentCriterion :=
  { name := "born of a virgin", basis := predictiveReading }

/-- The candidate this argument concerns. -/
def jesus : Person := ⟨"Jesus of Nazareth"⟩

/-- Mary, whose virginity at conception is the contested historical claim. -/
def mary : Person := ⟨"Mary of Nazareth"⟩

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .isaiahPredictsVirginBirth =>
    { label := "Isaiah 7:14 is a Messianic prediction of a virgin birth"
    , kind := .interpretive
    , source :=
        { primary := .work motyerIsaiah (.adLoc isaiah7_14)
        , tradition := .christianTypological
        , confidence := .disputed } }
  | .almahMeansVirgin =>
    { label := "עַלְמָה in Isaiah 7:14 denotes a virgin, not merely a young woman"
    , kind := .linguistic
      -- The Isaianic crux. The Hebrew term does not by itself carry the sense;
      -- the Septuagint's παρθένος does.
    , source :=
        { primary := .work motyerIsaiah (.adLoc isaiah7_14)
        , supporting :=
            [ .work bhs (.apparatus isaiah7_14)
            , .work berryVirginBirth (.pages 1653 1654) ]
        , tradition := .christianTypological
        , confidence := .disputed } }
  | .almahAdmitsVirginSense =>
    { label := "The semantic range of עַלְמָה does not exclude 'virgin' at Isaiah 7:14"
    , kind := .linguistic
      -- Berry's defensive claim, and all the lexical evidence actually
      -- supports. עַלְמָה is used of a virgin at Gen 24:43 and, some argue, of a
      -- maiden who need not be one at Prov 30:19; versatility is not ambiguity
      -- resolved in the argument's favour. `admissibility_is_not_enough`
      -- measures the gap between this and `almahMeansVirgin`.
    , source :=
        { primary := .work berryVirginBirth (.pages 1653 1654)
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .almahDenotesMarriageableYoungWoman =>
    { label := "עַלְמָה denotes a young woman of marriageable age"
    , kind := .linguistic
      -- Shared ground. Rico and Gentry and Wegner disagree about almost
      -- everything else here and not about this, which is why it is the only
      -- lexical atom in the module marked `consensus`.
    , source :=
        { primary := .work ricoGentryInfantKing .whole
        , supporting := [.work wegnerVirginBirths .whole]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .virginityCompatibleWithAlmah =>
    { label := "Being a virgin does not exclude a woman from the denotation of עַלְמָה"
    , kind := .linguistic
      -- The Rebekah datum settles this and neither side disputes it: Genesis
      -- calls the same woman עַלְמָה (24:43) and בְּתוּלָה whom no man had known
      -- (24:16). Compatibility is not the contested question; denotation is.
    , source :=
        { primary := .scripture
            [ { ref := .verse ⟨.genesis, 24, 43⟩, tradition := some .masoretic }
            , { ref := .verse ⟨.genesis, 24, 16⟩, tradition := some .masoretic } ]
        , supporting := [.work ricoGentryInfantKing .whole]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .maryWasAnAlmah =>
    { label := "Mary at the conception was a betrothed young woman of marriageable age"
    , kind := .historical
    , source :=
        { primary := .scripture
            [ { ref := .verse ⟨.matthew, 1, 18⟩ }
            , { ref := .verse ⟨.luke, 1, 27⟩ } ]
        , supporting := [.work franceMatthew (.adLoc matthew1_23)]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .maryFitsIsaianicDescription =>
    { label := "Mary answers the description at Isaiah 7:14 whatever עַלְמָה denotes"
    , kind := .interpretive
    , source :=
        { primary := .work franceMatthew (.adLoc matthew1_23)
        , supporting := [.work ricoGentryInfantKing .whole]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .lexicalSenseRequiredForFulfilment =>
    { label := "Matthew's fulfilment claim requires that עַלְמָה itself denote virginity"
    , kind := .interpretive
      -- Attributed carefully. This is what the popular form of the lexical
      -- objection needs, and Brown's case against an OT basis for the virginal
      -- conception presupposes it. It is *not* Wegner's view: the prophetic
      -- pattern approach gives this premise up, which is why Wegner is not
      -- cited here even though he is the module's main lexical rival.
    , source :=
        { primary := .work brownBirthMessiah .whole
        , tradition := .criticalScholarship
        , confidence := .disputed } }
  | .lxxRendersParthenos =>
    { label := "The Septuagint renders עַלְמָה at Isaiah 7:14 as παρθένος"
    , kind := .textual
    , source :=
        { primary := .work na28 (.apparatus matthew1_23)
        , supporting := [.work franceMatthew (.adLoc matthew1_23)]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .targumRendersUlemta =>
    { label := "Targum Jonathan renders עַלְמָה at Isaiah 7:14 as עוּלֵימְתָא, 'young woman'"
    , kind := .textual
    , source :=
        { primary := .work chiltonIsaiahTargum (.adLoc isaiah7_14)
        , supporting :=
            [ .scripture [ { ref := .verse ⟨.isaiah, 7, 14⟩
                           , tradition := some .targum } ] ]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .theThreeRenderNeanis =>
    { label := "Aquila, Symmachus and Theodotion render Isaiah 7:14 with νεᾶνις"
    , kind := .textual
      -- Often explained as anti-Christian revision, and Justin already
      -- complains of it (Dial. 43, 67, 71, 84). The explanation is not clean:
      -- Theodotion's version is arguably pre-Christian.
    , source :=
        { primary := .work ricoGentryInfantKing .whole
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .peshittaRendersBtulta =>
    { label := "The Syriac Peshitta renders Isaiah 7:14 with ܒܬܘܠܬܐ, 'virgin'"
    , kind := .textual
      -- Scripture alone, and legitimately so: the claim is about what a
      -- version reads, and the version is the evidence for that. Surfaced by
      -- `scriptureOnlyAtoms` all the same.
    , source :=
        { primary := .scripture
            [ { ref := .verse ⟨.isaiah, 7, 14⟩, tradition := some .peshitta } ]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .qumranConfirmsAlmah =>
    { label := "1QIsaᵃ reads עַלְמָה, so no textual variant bears on the sense"
    , kind := .textual
    , source :=
        { primary := .work bhs (.apparatus isaiah7_14)
        , supporting :=
            [ .scripture [ { ref := .verse ⟨.isaiah, 7, 14⟩
                           , tradition := some .deadSeaScrolls } ] ]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .versionalDivergenceRefutesVirginSense =>
    { label := "The split among the ancient versions shows עַלְמָה does not denote virginity"
    , kind := .interpretive
    , source :=
        { primary := .work brownBirthMessiah .whole
        , supporting := [.work chiltonIsaiahTargum .whole]
        , tradition := .criticalScholarship
        , confidence := .wellSupported } }
  | .matthewQuotesIsaiah =>
    { label := "Matthew 1:23 quotes Isaiah 7:14"
    , kind := .textual
    , source :=
        { primary := .work na28 (.apparatus matthew1_23)
        , supporting := [.work ubs5 .whole]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .matthewIntendsFulfilment =>
    { label := "Matthew's quotation intends the virgin conception as fulfilment"
    , kind := .interpretive
    , source :=
        { primary := .work franceMatthew (.adLoc matthew1_23)
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .isaiah2to12FramedByEschatology =>
    { label := "Isaiah 7 sits inside Isaiah 2–12, a unit framed by eschatology"
    , kind := .textual
    , source :=
        { primary := .work postellIsaiahMessianic (.pages 483 490)
        , supporting :=
            [ .scripture
                [ { ref := .range ⟨.isaiah, 2, 1, 2, 4⟩ }
                , { ref := .range ⟨.isaiah, 11, 1, 12, 6⟩ } ] ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .compositionGovernsMeaning =>
    { label := "An oracle's meaning in the finished book is set by its literary placement"
    , kind := .interpretive
      -- The compositional crux, argued from the making of canonical Jeremiah
      -- (Jer 36): the second scroll's oracles mean what their placement in the
      -- book makes them mean. A reader who holds that the historical setting of
      -- an oracle fixes its sense rejects this outright.
    , source :=
        { primary := .work postellIsaiahMessianic (.pages 483 486)
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .isaiah9And11AreMessianic =>
    { label := "Isaiah 9:5–6 and 11:1–10 are read as messianic without reservation"
    , kind := .interpretive
      -- Cited to the Targum as well as to Postell, and the Targum is the
      -- stronger witness here precisely because it is hostile elsewhere: it
      -- reads 9:5-6 and 11:1 messianically while declining to read 7:14 so.
    , source :=
        { primary := .work postellIsaiahMessianic (.pages 487 489)
        , supporting := [.work chiltonIsaiahTargum .whole]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .isaiah9And11ShareTheAssyrianTimeline =>
    { label := "Isaiah 9 and 11 sit on the same near-term Assyrian timeline as 7:14"
    , kind := .textual
    , source :=
        { primary := .work postellIsaiahMessianic (.pages 487 489)
        , supporting :=
            [ .scripture
                [ { ref := .range ⟨.isaiah, 8, 7, 8, 8⟩ }
                , { ref := .range ⟨.isaiah, 9, 8, 9, 11⟩ }
                , { ref := .verse ⟨.isaiah, 10, 5⟩ } ] ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .compositionalReadingYieldsFutureBirth =>
    { label := "Read compositionally, Isaiah 7:14 anticipates a future, miraculous birth"
    , kind := .interpretive
    , source :=
        { primary := .work postellIsaiahMessianic (.pages 490 493)
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .genesis3_15SeedOfTheWoman =>
    { label := "Genesis 3:15 promises victory over the serpent through 'her seed'"
    , kind := .textual
      -- What the text says, as against what it is taken to imply. The wording
      -- is not in dispute; everything built on it is.
    , source :=
        { primary := .scripture
            [ { ref := .verse ⟨.genesis, 3, 15⟩, tradition := some .masoretic } ]
        , supporting := [.work bhs (.apparatus genesis3_15)]
        , tradition := .criticalScholarship
        , confidence := .consensus } }
  | .genesis3_15IsProtoevangelium =>
    { label := "Genesis 3:15 is the protoevangelium, the first promise of a redeemer"
    , kind := .interpretive
    , source :=
        { primary := .work miravalleMeetMary (.pages 9 10)
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .seedReckonedThroughFather =>
    { label := "Hebrew זֶרַע is ordinarily reckoned through the father"
    , kind := .linguistic
      -- Marked disputed rather than wellSupported on purpose: Genesis speaks of
      -- a woman's seed in wholly ordinary contexts (16:10 to Hagar, 24:60 to
      -- Rebekah), so the idiom is weaker than the argument needs.
    , source :=
        { primary := .work miravalleMeetMary (.pages 9 10)
        , supporting := [.work bhs (.apparatus genesis3_15)]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .seedOfTheWomanImpliesNoHumanFather =>
    { label := "The matrilineal wording of Genesis 3:15 marks a birth with no human father"
    , kind := .interpretive
    , source :=
        { primary := .work miravalleMeetMary (.pages 9 10)
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .micah5_3NamesMotherOnly =>
    { label := "Micah 5:3 names only the woman in labour as bearing the coming ruler"
    , kind := .textual
    , source :=
        { primary := .scripture
            [ { ref := .range ⟨.micah, 5, 2, 5, 3⟩, tradition := some .masoretic } ]
        , supporting := [.work keilDelitzschMinorProphets (.adLoc micah5_3)]
        , tradition := .christianTypological
        , confidence := .wellSupported } }
  | .maternalSilenceImpliesNoHumanFather =>
    { label := "Micah's mention of a mother and no father indicates a birth with no human father"
    , kind := .interpretive
      -- An argument from silence, and the rival says so. See
      -- `maternalSilenceProvesNothing`.
    , source :=
        { primary := .work miravalleMeetMary (.pages 9 10)
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .maryConceivedAsVirgin =>
    { label := "Mary conceived Jesus while a virgin"
    , kind := .historical
      -- Scripture alone. A miraculous conception is outside ordinary
      -- historical method; critical scholarship disputes or denies it.
    , source :=
        { primary := .scripture
            [ { ref := .range ⟨.matthew, 1, 18, 1, 25⟩ }
            , { ref := .range ⟨.luke, 1, 26, 1, 38⟩ } ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .independentAttestation =>
    { label :=
        "Matthew and Luke are independent traditions agreeing on the virgin conception"
    , kind := .historical
      -- The independence of the two sources is itself debated.
    , source :=
        { primary := .work brownBirthMessiah (.pages 26 38)
        , tradition := .christianHistoricalGrammatical
        , confidence := .plausible } }
  | .isaiahIsNearTermSignToAhaz =>
    { label := "Isaiah 7:14 is a near-term sign to Ahaz, fulfilled in Isaiah's generation"
    , kind := .interpretive
    , source :=
        { primary := .work brownBirthMessiah .whole
        , tradition := .criticalScholarship
        , confidence := .wellSupported } }
  | .nearTermExcludesMessianicSense =>
    { label := "A sign given for Ahaz's generation is not also a prediction of a virgin birth"
    , kind := .interpretive
    , source :=
        { primary := .work brownBirthMessiah .whole
        , tradition := .criticalScholarship
        , confidence := .wellSupported } }
  | .nearTermFulfilmentIsUnclear =>
    { label := "How Isaiah 7:14 was fulfilled in Ahaz's own day is itself an open question"
    , kind := .interpretive
      -- Descriptively uncontroversial: the near-term referent has been taken
      -- for Isaiah's son, for Hezekiah, and for a son of Ahaz, with no
      -- settled answer. What is contestable is the use Berry puts it to.
    , source :=
        { primary := .work berryVirginBirth (.pages 1653 1654)
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .genesis3_15IsEtiology =>
    { label := "Genesis 3:15 is an etiology of snake-human enmity, 'her seed' her descendants"
    , kind := .interpretive
    , source :=
        { primary := .work brownBirthMessiah .whole
        , tradition := .criticalScholarship
        , confidence := .wellSupported } }
  | .maternalSilenceProvesNothing =>
    { label := "Micah's silence about a father is an argument from silence and proves nothing"
    , kind := .interpretive
    , source :=
        { primary := .work brownBirthMessiah .whole
        , tradition := .criticalScholarship
        , confidence := .wellSupported } }
  | .magisteriumTeachesVirginalConception =>
    { label := "Papal teaching affirms that Mary conceived while remaining a virgin"
    , kind := .theological
    , source :=
        { primary := .work miravalleIntroductionToMary (.page 23)
        , tradition := .romanCatholic
        , confidence := .consensus } }
  | .magisteriumIsDoctrinallyAuthoritative =>
    { label := "Magisterial teaching settles the question"
    , kind := .theological
      -- Held within Roman Catholicism, denied by the Reformed tradition. This
      -- library's author does not grant it, which is why it appears only in
      -- `catholic` and `magisterialOnly`, never in `christian`.
    , source :=
        { primary := .work miravalleIntroductionToMary (.page 23)
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .scriptureIsSupremeJudge =>
    { label := "Scripture is the supreme judge of controversies of religion"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "I.x")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .messiahBornOfVirgin =>
    { label := "The Messiah must be born of a virgin"
    , kind := .interpretive
    , source :=
        { primary := .work motyerIsaiah (.adLoc isaiah7_14)
        , supporting :=
            [ .work franceMatthew (.adLoc matthew1_23)
            , .work miravalleMeetMary (.pages 9 10) ]
        , tradition := .christianTypological
        , confidence := .disputed } }
  | .jesusSatisfiesCriterion =>
    { label := "Jesus of Nazareth satisfies the virgin-birth criterion"
    , kind := .interpretive
    , source :=
        { primary := .work franceMatthew (.adLoc matthew1_23)
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }

/-! ### Inference steps

One per strand, each delivering the same criterion. Keeping them separate is
what makes the load-bearing results below possible: a strand can be removed
without touching the others. -/

/-- Isaianic strand: from the predictive reading, the lexical premise and
Matthew's intent, the criterion follows. -/
def toCriterion : Formula Claim :=
  .imp (conjOf
        [ p .isaiahPredictsVirginBirth, p .almahMeansVirgin
        , p .matthewIntendsFulfilment ])
       (p .messiahBornOfVirgin)

/-- Protoevangelium strand: from Genesis 3:15 read as promise, the patrilineal
idiom, and the inference drawn from its departure, the criterion follows. -/
def genesisToCriterion : Formula Claim :=
  .imp (conjOf
        [ p .genesis3_15SeedOfTheWoman, p .genesis3_15IsProtoevangelium
        , p .seedReckonedThroughFather, p .seedOfTheWomanImpliesNoHumanFather ])
       (p .messiahBornOfVirgin)

/-- Compositional strand: from Isaiah 7's placement in an eschatologically
framed unit, the principle that placement governs meaning, and the future birth
that follows, the criterion follows.

The weak joint is the last step. Postell's argument delivers a *miraculous*
birth; it is `matthewIntendsFulfilment` that says which miracle. A reader who
grants the composition and stops short of Matthew is entitled to. -/
def compositionalToCriterion : Formula Claim :=
  .imp (conjOf
        [ p .isaiah2to12FramedByEschatology, p .compositionGovernsMeaning
        , p .compositionalReadingYieldsFutureBirth, p .matthewIntendsFulfilment ])
       (p .messiahBornOfVirgin)

/-- **Postell's parity argument.** Isaiah 9:5–6 and 11:1–10 are read as
messianic without reservation, and they stand on the same near-term Assyrian
timeline as 7:14 — the Assyrian invasion of 8:7–8, the oppressor's rod of 10:5.
So a near-term geopolitical setting cannot be what rules out messianic
reference, because if it were it would rule out 9 and 11 as well.

This is a second, independent defeater of the same critical step that Berry's
objection attacks, and it is the stronger of the two: Berry says the near-term
fulfilment is unclear, while parity says the near-term setting was never the
right kind of reason. -/
def parityDefeatsNearTermExclusion : Formula Claim :=
  .imp (conjOf
        [ p .isaiah9And11AreMessianic, p .isaiah9And11ShareTheAssyrianTimeline ])
       (notP .nearTermExcludesMessianicSense)

/-- Michean strand: from the maternal-only wording and the inference drawn from
it, the criterion follows. -/
def micahToCriterion : Formula Claim :=
  .imp (conjOf
        [ p .micah5_3NamesMotherOnly, p .maternalSilenceImpliesNoHumanFather ])
       (p .messiahBornOfVirgin)

/-- Magisterial strand: from papal teaching and the authority granted it, the
criterion follows. Encoded, but deliberately kept out of `christian`. -/
def magisterialToCriterion : Formula Claim :=
  .imp (conjOf
        [ p .magisteriumTeachesVirginalConception
        , p .magisteriumIsDoctrinallyAuthoritative ])
       (p .messiahBornOfVirgin)

/-- The critical inference, made explicit: granted that Isaiah 7:14 was a sign
to Ahaz, and that such a sign is not also a prediction of a virgin conception,
the predictive reading is denied.

The earlier encoding of this module simply asserted the denial as a premise of
`critical`. That was a weaker rival than the critical case actually is, and it
left nothing for an objection to engage. -/
def criticalExclusion : Formula Claim :=
  .imp (conjOf
        [ p .isaiahIsNearTermSignToAhaz, p .nearTermExcludesMessianicSense ])
       (notP .isaiahPredictsVirginBirth)

/-- Berry's objection: if how the sign was fulfilled in Ahaz's own day is
itself unsettled, the near-term reading is not secure enough to exclude a
further referent.

The step is contestable even though both atoms it joins are `wellSupported` —
an unclear fulfilment is still a fulfilment, and Brown would answer that Isaiah
8:3–4 settles the referent well enough. Inference steps carry no confidence
field of their own, so this is where that is recorded. -/
def berryBlocksExclusion : Formula Claim :=
  .imp (p .nearTermFulfilmentIsUnclear) (notP .nearTermExcludesMessianicSense)

/-! #### The referential strand

Sense against reference. The steps below never claim that עַלְמָה *means*
virgin; they claim that a virgin *is* an עַלְמָה, which is a different and far
cheaper claim, and then ask what the lexical objection is left with. -/

/-- If virginity is compatible with the denotation of עַלְמָה, and Mary was both
an עַלְמָה and a virgin, then Mary answers Isaiah's description — without the
word having to carry the sense. -/
def toDescriptionFit : Formula Claim :=
  .imp (conjOf
        [ p .almahDenotesMarriageableYoungWoman, p .virginityCompatibleWithAlmah
        , p .maryWasAnAlmah, p .maryConceivedAsVirgin ])
       (p .maryFitsIsaianicDescription)

/-- ... and if she answers it, the fulfilment claim never needed the lexical
sense in the first place. -/
def descriptionFitDefeatsLexicalDemand : Formula Claim :=
  .imp (p .maryFitsIsaianicDescription)
       (notP .lexicalSenseRequiredForFulfilment)

/-- The lexical objection in full: עַלְמָה does not denote virginity, Matthew's
claim requires that it does, so the fulfilment claim fails. Stated as the
objector would state it, so that the reply has something real to answer. -/
def lexicalObjection : Formula Claim :=
  .imp (conjOf
        [ notP .almahMeansVirgin, p .lexicalSenseRequiredForFulfilment ])
       (notP .jesusSatisfiesCriterion)

/-- The versional route to the lexical premise: the Targum and the Three read
the broad term, so the narrow sense is not the word's. -/
def versionalObjection : Formula Claim :=
  .imp (conjOf
        [ p .targumRendersUlemta, p .theThreeRenderNeanis
        , p .versionalDivergenceRefutesVirginSense ])
       (notP .almahMeansVirgin)

/-- **The tension, dissolved.** If virginity is compatible with עַלְמָה, the
versions are not contradicting one another about the referent at all: the
Septuagint and the Peshitta render with the narrower term because they read the
referent as a virgin, the Targum and the Three render with the broader one, and
both are faithful renderings of a word whose denotation admits both. The
divergence stops being evidence about the sense. -/
def compatibilityDissolvesDivergence : Formula Claim :=
  .imp (conjOf
        [ p .virginityCompatibleWithAlmah, p .lxxRendersParthenos
        , p .peshittaRendersBtulta ])
       (notP .versionalDivergenceRefutesVirginSense)

/-- From the criterion and the historical claim, the fulfilment follows. -/
def toFulfilment : Formula Claim :=
  .imp (conjOf [p .messiahBornOfVirgin, p .maryConceivedAsVirgin])
       (p .jesusSatisfiesCriterion)

/-! ### Packages -/

/-- The scriptural argument: three strands, no appeal to magisterial
authority. -/
def christian : ArgumentPackage Claim :=
  { name := "Scriptural reading of Isaiah 7:14, Genesis 3:15 and Micah 5:2–3"
  , cite := cite
  , premises :=
      [ p .isaiahPredictsVirginBirth, p .almahMeansVirgin, p .lxxRendersParthenos
      , p .matthewQuotesIsaiah, p .matthewIntendsFulfilment
      , p .genesis3_15SeedOfTheWoman, p .genesis3_15IsProtoevangelium
      , p .seedReckonedThroughFather, p .seedOfTheWomanImpliesNoHumanFather
      , p .micah5_3NamesMotherOnly, p .maternalSilenceImpliesNoHumanFather
      , p .isaiah2to12FramedByEschatology, p .compositionGovernsMeaning
      , p .compositionalReadingYieldsFutureBirth
      , p .maryConceivedAsVirgin, p .independentAttestation
      , toCriterion, genesisToCriterion, micahToCriterion
      , compositionalToCriterion, toFulfilment ]
  , conclusion := p .jesusSatisfiesCriterion
  , conclusionLabel := fulfillmentLabel jesus bornOfAVirgin }

/-- The Roman Catholic package: the three scriptural strands *and* the
magisterial one. This is the position as actually held — Scripture and Tradition
together — and it is kept distinct from `christian` because its extra premise is
one this library's author does not grant. -/
def catholic : ArgumentPackage Claim :=
  { christian with
    name := "Roman Catholic reading (Scripture and magisterial teaching)"
    premises :=
      p .magisteriumTeachesVirginalConception ::
      p .magisteriumIsDoctrinallyAuthoritative ::
      magisterialToCriterion :: christian.premises }

/-- The magisterial route on its own, with no exegetical premise at all. -/
def magisterialOnly : ArgumentPackage Claim :=
  { christian with
    name := "Magisterial teaching alone"
    premises :=
      [ p .magisteriumTeachesVirginalConception
      , p .magisteriumIsDoctrinallyAuthoritative
      , p .maryConceivedAsVirgin, magisterialToCriterion, toFulfilment ] }

/-- The magisterial route as it stands for a reader who denies that magisterial
teaching settles doctrinal questions, holding with Westminster I.x that
Scripture is the supreme judge. -/
def magisterialDenied : ArgumentPackage Claim :=
  { christian with
    name := "Magisterial teaching, with its authority denied"
    premises :=
      [ p .magisteriumTeachesVirginalConception
      , notP .magisteriumIsDoctrinallyAuthoritative, p .scriptureIsSupremeJudge
      , p .maryConceivedAsVirgin, magisterialToCriterion, toFulfilment ] }

/-- The scriptural package with the lexical premise removed, everything else
retained. Stated explicitly so that it reduces predictably. -/
def christianWithoutAlmah : ArgumentPackage Claim :=
  { christian with
    name := "Scriptural reading, minus the lexical premise"
    premises :=
      [ p .isaiahPredictsVirginBirth, p .lxxRendersParthenos
      , p .matthewQuotesIsaiah, p .matthewIntendsFulfilment
      , p .genesis3_15SeedOfTheWoman, p .genesis3_15IsProtoevangelium
      , p .seedReckonedThroughFather, p .seedOfTheWomanImpliesNoHumanFather
      , p .micah5_3NamesMotherOnly, p .maternalSilenceImpliesNoHumanFather
      , p .isaiah2to12FramedByEschatology, p .compositionGovernsMeaning
      , p .compositionalReadingYieldsFutureBirth
      , p .maryConceivedAsVirgin, p .independentAttestation
      , toCriterion, genesisToCriterion, micahToCriterion
      , compositionalToCriterion, toFulfilment ] }

/-- The Isaianic strand by itself, with the lexical premise removed: the
argument exactly as this module encoded it before the other two strands were
added. Kept so that the earlier finding stays checkable. -/
def isaianicStrandWithoutAlmah : ArgumentPackage Claim :=
  { christian with
    name := "Isaianic strand alone, minus the lexical premise"
    premises :=
      [ p .isaiahPredictsVirginBirth, p .lxxRendersParthenos
      , p .matthewQuotesIsaiah, p .matthewIntendsFulfilment
      , p .maryConceivedAsVirgin, p .independentAttestation
      , toCriterion, toFulfilment ] }

/-- The scriptural package with all three interpretive hinges removed, every
textual and historical premise retained. -/
def christianWithoutAnyHinge : ArgumentPackage Claim :=
  { christian with
    name := "Scriptural reading, minus all four interpretive hinges"
    premises :=
      [ p .isaiahPredictsVirginBirth, p .lxxRendersParthenos
      , p .matthewQuotesIsaiah, p .matthewIntendsFulfilment
      , p .genesis3_15SeedOfTheWoman, p .genesis3_15IsProtoevangelium
      , p .seedReckonedThroughFather
      , p .micah5_3NamesMotherOnly
      , p .isaiah2to12FramedByEschatology
      , p .compositionalReadingYieldsFutureBirth
      , p .maryConceivedAsVirgin, p .independentAttestation
      , toCriterion, genesisToCriterion, micahToCriterion
      , compositionalToCriterion, toFulfilment ] }

/-- The critical reading: the quotation, the Septuagint rendering and the
wording of Genesis and Micah are all granted, and every inference drawn from
them is denied. -/
def critical : ArgumentPackage Claim :=
  { name := "Critical reading: near-term sign, etiology, and silence"
  , cite := cite
  , premises :=
      [ p .lxxRendersParthenos, p .matthewQuotesIsaiah
      , p .genesis3_15SeedOfTheWoman, p .micah5_3NamesMotherOnly
      , p .isaiahIsNearTermSignToAhaz, p .nearTermExcludesMessianicSense
      , p .genesis3_15IsEtiology, p .maternalSilenceProvesNothing
      , notP .almahMeansVirgin
      , notP .genesis3_15IsProtoevangelium
      , notP .seedOfTheWomanImpliesNoHumanFather
      , notP .maternalSilenceImpliesNoHumanFather
      , criticalExclusion
      , toCriterion, genesisToCriterion, micahToCriterion, toFulfilment ]
  , conclusion := p .jesusSatisfiesCriterion
  , conclusionLabel := fulfillmentLabel jesus bornOfAVirgin }

/-- The critical case for denying the predictive reading, stated as an argument
in its own right rather than assumed inside `critical`. Its conclusion is the
denial, not anything about Jesus. -/
def criticalDenial : ArgumentPackage Claim :=
  { name := "Critical denial of the predictive reading of Isaiah 7:14"
  , cite := cite
  , premises :=
      [ p .isaiahIsNearTermSignToAhaz, p .nearTermExcludesMessianicSense
      , criticalExclusion ]
  , conclusion := notP .isaiahPredictsVirginBirth
  , conclusionLabel := "Isaiah 7:14 is not a prediction of a virgin birth" }

/-- The same case with Berry's observation in play, and the exclusion premise
no longer simply granted. -/
def criticalDenialUnderBerry : ArgumentPackage Claim :=
  { criticalDenial with
    name := "Critical denial, with Berry's objection in play"
    premises :=
      [ p .isaiahIsNearTermSignToAhaz, p .nearTermFulfilmentIsUnclear
      , berryBlocksExclusion, criticalExclusion ] }

/-- The critical denial with Postell's parity argument in play, and the
exclusion premise no longer simply granted. -/
def criticalDenialUnderParity : ArgumentPackage Claim :=
  { criticalDenial with
    name := "Critical denial, with the parity argument in play"
    premises :=
      [ p .isaiahIsNearTermSignToAhaz, p .isaiah9And11AreMessianic
      , p .isaiah9And11ShareTheAssyrianTimeline
      , parityDefeatsNearTermExclusion, criticalExclusion ] }

/-- The Isaianic strand with Berry's defensive lexical premise in place of the
assertive one: עַלְמָה *admits* the sense "virgin" rather than *bearing* it. -/
def isaianicStrandOnAdmissibility : ArgumentPackage Claim :=
  { christian with
    name := "Isaianic strand, with the lexical premise weakened to admissibility"
    premises :=
      [ p .isaiahPredictsVirginBirth, p .almahAdmitsVirginSense
      , p .lxxRendersParthenos, p .matthewQuotesIsaiah
      , p .matthewIntendsFulfilment
      , p .maryConceivedAsVirgin, p .independentAttestation
      , toCriterion, toFulfilment ] }

/-- The referential argument: Mary answers Isaiah's description, so Matthew's
claim never required עַלְמָה to denote virginity. Its conclusion is the *denial
of the objection's premise*, not the criterion — see
`compatibility_does_not_establish_criterion`. -/
def semantic : ArgumentPackage Claim :=
  { name := "Referential reading: a virgin is an עַלְמָה"
  , cite := cite
  , premises :=
      [ p .almahDenotesMarriageableYoungWoman, p .virginityCompatibleWithAlmah
      , p .maryWasAnAlmah, p .maryConceivedAsVirgin
      , p .qumranConfirmsAlmah
      , toDescriptionFit, descriptionFitDefeatsLexicalDemand ]
  , conclusion := notP .lexicalSenseRequiredForFulfilment
  , conclusionLabel := "Matthew's claim does not require עַלְמָה to denote virginity" }

/-- The same premises, asked to deliver the criterion instead. They do not. -/
def semanticReachingForCriterion : ArgumentPackage Claim :=
  { semantic with
    name := "Referential reading, asked for the criterion"
    premises := semantic.premises ++ [toFulfilment]
    conclusion := p .jesusSatisfiesCriterion
    conclusionLabel := fulfillmentLabel jesus bornOfAVirgin }

/-- The lexical objection with its versional support, stated as its holder
would state it. -/
def lexicalCritical : ArgumentPackage Claim :=
  { name := "Lexical objection from the ancient versions"
  , cite := cite
  , premises :=
      [ p .targumRendersUlemta, p .theThreeRenderNeanis, p .qumranConfirmsAlmah
      , p .versionalDivergenceRefutesVirginSense
      , p .lexicalSenseRequiredForFulfilment
      , versionalObjection, lexicalObjection ]
  , conclusion := notP .jesusSatisfiesCriterion
  , conclusionLabel := "Jesus does not satisfy the virgin-birth criterion" }

/-- The same objection, with the referential premises in play and its own
key premise no longer simply granted. -/
def lexicalCriticalUnderCompatibility : ArgumentPackage Claim :=
  { lexicalCritical with
    name := "Lexical objection, with the referential reply in play"
    premises :=
      [ p .targumRendersUlemta, p .theThreeRenderNeanis, p .qumranConfirmsAlmah
      , p .lxxRendersParthenos, p .peshittaRendersBtulta
      , p .almahDenotesMarriageableYoungWoman, p .virginityCompatibleWithAlmah
      , p .maryWasAnAlmah, p .maryConceivedAsVirgin
      , toDescriptionFit, descriptionFitDefeatsLexicalDemand
      , compatibilityDissolvesDivergence
      , versionalObjection, lexicalObjection ] }

/-! ### Results -/

/-- Given the scriptural premises, the conclusion follows. -/
@[headline]
theorem christian_establishes : Establishes christian := by
  intro w hw
  simp only [christian, toCriterion, genesisToCriterion, micahToCriterion,
    compositionalToCriterion, toFulfilment, conjOf, p, List.mem_cons, List.not_mem_nil, or_false,
    forall_eq_or_imp, forall_eq, FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms christian_establishes

/-- The Roman Catholic package establishes it too, unsurprisingly: it is the
scriptural package with a further strand bolted on. -/
@[headline]
theorem catholic_establishes : Establishes catholic := by
  intro w hw
  simp only [catholic, christian, toCriterion, genesisToCriterion, micahToCriterion,
    compositionalToCriterion, magisterialToCriterion, toFulfilment, conjOf, p,
    List.mem_cons, List.not_mem_nil,
    or_false, forall_eq_or_imp, forall_eq,
    FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms catholic_establishes

/-- The magisterial route carries the conclusion on its own, for a reader who
grants the authority it claims. -/
@[headline]
theorem magisterialOnly_establishes : Establishes magisterialOnly := by
  intro w hw
  simp only [magisterialOnly, christian, magisterialToCriterion, toFulfilment,
    conjOf, p, List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp,
    forall_eq, FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms magisterialOnly_establishes

/-- The critical reading, written down: עַלְמָה means "young woman", Isaiah's
sign was given to Ahaz, Genesis 3:15 is an etiology, and Micah's silence about a
father is only silence. No virgin-birth criterion arises. -/
def criticalReading : Valuation Claim := fun a =>
  match a with
  | .almahMeansVirgin => False
  | .isaiahPredictsVirginBirth => False
  | .genesis3_15IsProtoevangelium => False
  | .seedOfTheWomanImpliesNoHumanFather => False
  | .maternalSilenceImpliesNoHumanFather => False
  | .messiahBornOfVirgin => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- The critical reading does not establish the conclusion. -/
@[headline]
theorem critical_not_establishes : ¬ Establishes critical := by
  refine not_entails_of_countermodel criticalReading ?_ ?_ <;>
    simp [critical, criticalExclusion, toCriterion, genesisToCriterion,
      micahToCriterion, toFulfilment, conjOf, p, notP,
      FFL.Propositional.Formula.Boolean.val, criticalReading]

#print axioms critical_not_establishes

/-- The critical case for the denial does go through on its own terms. Stating
it as an argument rather than a bare assumption is what makes the next result
possible. -/
@[headline]
theorem criticalDenial_establishes : Establishes criticalDenial := by
  intro w hw
  simp only [criticalDenial, criticalExclusion, conjOf, p, notP, List.mem_cons,
    List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
    FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms criticalDenial_establishes

/-- Berry's reading, written down: the sign was given to Ahaz, how it was
fulfilled in his day is unclear, and so the near-term reading does not exclude
a further referent — leaving the predictive reading standing. -/
def berryReading : Valuation Claim := fun a =>
  match a with
  | .nearTermExcludesMessianicSense => False
  | _ => True

/-- **Berry's objection blocks the critical denial.** Grant that Isaiah 7:14
was a sign to Ahaz, and grant with Berry that how it was fulfilled in Ahaz's own
day is an open question, and the denial no longer follows.

This is the narrow thing the objection does, and it is worth being clear about
what it does not do. It does not establish the predictive reading, and it does
not touch the lexical dispute. It removes one route to the denial — the route
that runs through the near-term fulfilment — and leaves the argument where
`hinges_jointly_load_bearing` puts it. -/
@[headline]
theorem berry_blocks_critical_denial : ¬ Establishes criticalDenialUnderBerry := by
  refine not_entails_of_countermodel berryReading ?_ ?_ <;>
    simp [criticalDenialUnderBerry, criticalDenial, criticalExclusion,
      berryBlocksExclusion, conjOf, p, notP,
      FFL.Propositional.Formula.Boolean.val, berryReading]

#print axioms berry_blocks_critical_denial

/-- The parity reading, written down: a near-term Assyrian setting is simply not
the kind of reason that rules out messianic reference, since Isaiah 9 and 11 sit
on that same timeline and are read messianically anyway. -/
def parityReading : Valuation Claim := fun a =>
  match a with
  | .nearTermExcludesMessianicSense => False
  | _ => True

/-- **Postell's parity argument blocks the critical denial too**, and by a
different route from Berry's.

Berry's objection is evidential — we do not know how the sign was fulfilled in
Ahaz's day. Parity is structural — the near-term setting was never the right
kind of reason, because Isaiah 9:5–6 and 11:1–10 stand on the same Assyrian
timeline and are read messianically without embarrassment. An opponent who
answers Berry by settling the near-term referent has not touched this. -/
@[headline]
theorem parity_blocks_critical_denial : ¬ Establishes criticalDenialUnderParity := by
  refine not_entails_of_countermodel parityReading ?_ ?_ <;>
    simp [criticalDenialUnderParity, criticalDenial, criticalExclusion,
      parityDefeatsNearTermExclusion, conjOf, p, notP,
      FFL.Propositional.Formula.Boolean.val, parityReading]

#print axioms parity_blocks_critical_denial

/-- The Reformed objection, written down: papal teaching says what it says, and
saying it settles nothing, because Scripture is the supreme judge. -/
def reformedReading : Valuation Claim := fun a =>
  match a with
  | .magisteriumIsDoctrinallyAuthoritative => False
  | .messiahBornOfVirgin => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- **What the magisterial strand is worth to a reader who does not grant the
magisterium's authority: nothing.** Deny that premise and the route collapses
outright, however firmly the teaching itself is attested.

This is why `christian` excludes it. A reader who holds with Westminster I.x
that Scripture is the supreme judge of controversies loses the whole of
`magisterialOnly` and must get the criterion from the three scriptural strands
or not at all. -/
@[headline]
theorem magisterial_authority_is_load_bearing : ¬ Establishes magisterialDenied := by
  refine not_entails_of_countermodel reformedReading ?_ ?_ <;>
    simp [magisterialDenied, christian, magisterialToCriterion, toFulfilment,
      conjOf, p, notP, FFL.Propositional.Formula.Boolean.val, reformedReading]

#print axioms magisterial_authority_is_load_bearing

/-- **The lexical premise no longer carries the argument.** Strip `almah` and
the protoevangelium and Michean strands still deliver the criterion.

Before Genesis 3:15 and Micah 5:2–3 were encoded, this module proved the
opposite — and `almah_is_load_bearing_alone` below shows that the earlier
finding was right about the Isaianic strand taken by itself. What changed is
not the Isaianic evidence but the number of strands. -/
@[headline]
theorem almah_not_load_bearing : Establishes christianWithoutAlmah := by
  intro w hw
  simp only [christianWithoutAlmah, christian, toCriterion, genesisToCriterion,
    micahToCriterion, compositionalToCriterion, toFulfilment, conjOf, p,
    List.mem_cons, List.not_mem_nil,
    or_false, forall_eq_or_imp, forall_eq,
    FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms almah_not_load_bearing

/-- A reading that grants everything in the Isaianic strand except the lexical
premise. -/
def withoutAlmahReading : Valuation Claim := fun a =>
  match a with
  | .almahMeansVirgin => False
  | .messiahBornOfVirgin => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- Within the Isaianic strand taken alone, the lexical premise is still
load-bearing: remove it and that strand yields nothing. The earlier
single-stranded encoding of this module is preserved here rather than deleted,
because it is what makes `almah_not_load_bearing` informative — the Isaianic
evidence did not get stronger, it got company. -/
@[headline]
theorem almah_is_load_bearing_alone : ¬ Establishes isaianicStrandWithoutAlmah := by
  refine not_entails_of_countermodel withoutAlmahReading ?_ ?_ <;>
    simp [isaianicStrandWithoutAlmah, christian, toCriterion, toFulfilment, conjOf, p,
      FFL.Propositional.Formula.Boolean.val, withoutAlmahReading]

#print axioms almah_is_load_bearing_alone

/-- **Admissibility is not enough.** Berry's lexical point is defensive — the
semantic range of עַלְמָה does not *exclude* the sense "virgin" — and defensive
is all it is. Substitute it for `almahMeansVirgin` and the Isaianic strand
yields nothing, on the same reading that refutes the strand without any lexical
premise at all.

The gap between *may mean* and *does mean* is where this argument lives, and
Berry is useful against the critical denial without narrowing it. -/
@[headline]
theorem admissibility_is_not_enough : ¬ Establishes isaianicStrandOnAdmissibility := by
  refine not_entails_of_countermodel withoutAlmahReading ?_ ?_ <;>
    simp [isaianicStrandOnAdmissibility, christian, toCriterion, toFulfilment, conjOf, p,
      FFL.Propositional.Formula.Boolean.val, withoutAlmahReading]

#print axioms admissibility_is_not_enough

/-! #### The referential strand -/

/-- **The referential argument goes through.** Granted only what both sides
grant about the word — that עַלְמָה denotes a young woman of marriageable age,
and that being a virgin does not exclude a woman from that denotation — and
granted that Mary was such a woman and conceived as a virgin, Matthew's claim
turns out not to have required the lexical sense at all.

Nothing here asserts that עַלְמָה *means* virgin. The argument is about
reference, not sense, and it is cheaper for exactly that reason. -/
@[headline]
theorem semantic_establishes : Establishes semantic := by
  intro w hw
  simp only [semantic, toDescriptionFit, descriptionFitDefeatsLexicalDemand,
    conjOf, p, notP, List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp,
    forall_eq, FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms semantic_establishes

/-- The lexical objection, written down and granted its own premises. -/
@[headline]
theorem lexicalCritical_establishes : Establishes lexicalCritical := by
  intro w hw
  simp only [lexicalCritical, versionalObjection, lexicalObjection, conjOf, p, notP,
    List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
    FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms lexicalCritical_establishes

/-- The referential reading, written down: the versions differ about which term
to use and not about who is described, so the divergence settles nothing about
the sense, and Matthew's claim never needed the sense. -/
def compatibilityReading : Valuation Claim := fun a =>
  match a with
  | .versionalDivergenceRefutesVirginSense => False
  | .lexicalSenseRequiredForFulfilment => False
  | _ => True

/-- **The referential reply defeats the lexical objection.** Keep every
versional datum — the Targum's עוּלֵימְתָא, the Three's νεᾶνις, the Septuagint's
παρθένος, the Peshitta's ܒܬܘܠܬܐ, Qumran's confirmation of the Hebrew — add the
referential premises, and the objection no longer reaches its conclusion.

The tension in the versions is not evidence against the reading once virginity
is compatible with the word. It is evidence that four translators made four
defensible choices about how much of the referent's description to make
explicit. -/
@[headline]
theorem compatibility_defeats_lexical_objection :
    ¬ Establishes lexicalCriticalUnderCompatibility := by
  refine not_entails_of_countermodel compatibilityReading ?_ ?_ <;>
    simp [lexicalCriticalUnderCompatibility, lexicalCritical, toDescriptionFit,
      descriptionFitDefeatsLexicalDemand, compatibilityDissolvesDivergence,
      versionalObjection, lexicalObjection, conjOf, p, notP,
      FFL.Propositional.Formula.Boolean.val, compatibilityReading]

#print axioms compatibility_defeats_lexical_objection

/-- A reading on which Mary fits Isaiah's description and no criterion arises
from it. -/
def compatibilityOnlyReading : Valuation Claim := fun a =>
  match a with
  | .lexicalSenseRequiredForFulfilment => False
  | .messiahBornOfVirgin => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- **What the referential argument costs.** It is purely defensive. It defeats
the objection without establishing the criterion: ask the same premises for
`jesusSatisfiesCriterion` and they do not deliver it, because nothing in them
says the Messiah *must* be born of a virgin — only that Mary may be described
as Isaiah describes.

This is the honest price of the move, and it is worth paying. The criterion has
to come from the Isaianic, protoevangelium or Michean strands; what the
referential argument buys is that losing the lexical dispute no longer costs
the fulfilment claim. Winning `almahMeansVirgin` outright was never necessary,
and this says so in a form either side can check. -/
@[headline]
theorem compatibility_does_not_establish_criterion :
    ¬ Establishes semanticReachingForCriterion := by
  refine not_entails_of_countermodel compatibilityOnlyReading ?_ ?_ <;>
    simp [semanticReachingForCriterion, semantic, toDescriptionFit,
      descriptionFitDefeatsLexicalDemand, toFulfilment, conjOf, p, notP,
      FFL.Propositional.Formula.Boolean.val, compatibilityOnlyReading]

#print axioms compatibility_does_not_establish_criterion

/-- A reading on which none of the three interpretive hinges holds: *almah*
means "young woman", the matrilineal wording of Genesis 3:15 implies nothing
about a father, and Micah's silence is only silence. Every textual observation
is granted. -/
def noHingeReading : Valuation Claim := fun a =>
  match a with
  | .almahMeansVirgin => False
  | .seedOfTheWomanImpliesNoHumanFather => False
  | .maternalSilenceImpliesNoHumanFather => False
  | .compositionGovernsMeaning => False
  | .messiahBornOfVirgin => False
  | .jesusSatisfiesCriterion => False
  | _ => True

/-- **The result worth having.** No single hinge carries the argument, but the
four of them jointly do: remove all three and the criterion no longer follows,
with every textual and historical premise retained.

So the argument no longer hangs on the sense of עַלְמָה alone. It hangs on that
*or* on the matrilineal wording of Genesis 3:15 *or* on Micah's maternal
silence *or* on Postell's compositional reading — and an opponent must defeat
all four. That is a materially stronger position than the single-stranded
version, and a materially weaker one than four independent arguments would be:
three of the four hinges are `disputed` for good reason, and the module doc
says why. -/
@[headline]
theorem hinges_jointly_load_bearing : ¬ Establishes christianWithoutAnyHinge := by
  refine not_entails_of_countermodel noHingeReading ?_ ?_ <;>
    simp [christianWithoutAnyHinge, christian, toCriterion, genesisToCriterion,
      micahToCriterion, compositionalToCriterion, toFulfilment, conjOf, p,
      FFL.Propositional.Formula.Boolean.val, noHingeReading]

#print axioms hinges_jointly_load_bearing

/-- End to end: under the scriptural package, Jesus satisfies the virgin-birth
criterion. -/
@[headline]
theorem jesus_satisfies_virgin_birth : Satisfies jesus bornOfAVirgin :=
  ⟨{ α := Claim
   , pkg := christian
   , valid := christian_establishes
   , concludes := rfl }⟩

#print axioms jesus_satisfies_virgin_birth

end Testimony.Arguments.BornOfAVirgin
