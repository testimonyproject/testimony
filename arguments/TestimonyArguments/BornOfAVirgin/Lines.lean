import TestimonyArguments.BornOfAVirgin.Atoms
import Testimony.Logic.Line

/-!
# TestimonyArguments.BornOfAVirgin.Lines — the steps, and the lines of reason

Every inference this argument makes, and the four strands they compose into.

Inference steps carry no `confidence` field of their own — a step is a claim
that *these premises license that conclusion*, which is a different kind of
claim from an atom, and the library does not pretend to grade it. Where a step
is contestable even though the atoms it joins are well supported, the docstring
says so; `berryBlocksExclusion` is the clearest case.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Bib Testimony.Logic

/-! ### Inference steps

One per strand, each delivering the same criterion, plus the steps that close
the argument and the steps the rivals need. Keeping them separate is what makes
the load-bearing results possible: a strand can be removed without touching the
others. -/

/-- Isaianic strand: from the predictive reading, the lexical premise and
Matthew's intent, the criterion follows. -/
@[bornOfAVirginDefs]
def toCriterion : Formula Claim :=
  ⋀ [ p .isaiahPredictsVirginBirth, p .almahMeansVirgin
    , p .matthewIntendsFulfilment ] ➝ p .messiahBornOfVirgin

/-- Protoevangelium strand: from Genesis 3:15 read as promise, the patrilineal
idiom, and the inference drawn from its departure, the criterion follows. -/
@[bornOfAVirginDefs]
def genesisToCriterion : Formula Claim :=
  ⋀ [ p .genesis3_15SeedOfTheWoman, p .genesis3_15IsProtoevangelium
    , p .seedReckonedThroughFather, p .seedOfTheWomanImpliesNoHumanFather ] ➝ p .messiahBornOfVirgin

/-- Compositional strand: from Isaiah 7's placement in an eschatologically
framed unit, the principle that placement governs meaning, and the future birth
that follows, the criterion follows.

The weak joint is the last step. Postell's argument delivers a *miraculous*
birth; it is `matthewIntendsFulfilment` that says which miracle. A reader who
grants the composition and stops short of Matthew is entitled to. -/
@[bornOfAVirginDefs]
def compositionalToCriterion : Formula Claim :=
  ⋀ [ p .isaiah2to12FramedByEschatology, p .compositionGovernsMeaning
    , p .compositionalReadingYieldsFutureBirth, p .matthewIntendsFulfilment ]
  ➝ p .messiahBornOfVirgin

/-- **Postell's parity argument.** Isaiah 9:5–6 and 11:1–10 are read as
messianic without reservation, and they stand on the same near-term Assyrian
timeline as 7:14 — the Assyrian invasion of 8:7–8, the oppressor's rod of 10:5.
So a near-term geopolitical setting cannot be what rules out messianic
reference, because if it were it would rule out 9 and 11 as well.

This is a second, independent defeater of the same critical step that Berry's
objection attacks, and it is the stronger of the two: Berry says the near-term
fulfilment is unclear, while parity says the near-term setting was never the
right kind of reason. -/
@[bornOfAVirginDefs]
def parityDefeatsNearTermExclusion : Formula Claim :=
  ⋀ [ p .isaiah9And11AreMessianic, p .isaiah9And11ShareTheAssyrianTimeline ]
  ➝ notP .nearTermExcludesMessianicSense

/-- Michean strand: from the maternal-only wording and the inference drawn from
it, the criterion follows. -/
@[bornOfAVirginDefs]
def micahToCriterion : Formula Claim :=
  ⋀ [ p .micah5_3NamesMotherOnly, p .maternalSilenceImpliesNoHumanFather ] ➝ p .messiahBornOfVirgin

/-- Magisterial strand: from papal teaching and the authority granted it, the
criterion follows. Encoded, but deliberately kept out of `christian`. -/
@[bornOfAVirginDefs]
def magisterialToCriterion : Formula Claim :=
  ⋀ [ p .magisteriumTeachesVirginalConception
    , p .magisteriumIsDoctrinallyAuthoritative ] ➝ p .messiahBornOfVirgin

/-- The critical inference, made explicit: granted that Isaiah 7:14 was a sign
to Ahaz, and that such a sign is not also a prediction of a virgin conception,
the predictive reading is denied.

The earlier encoding of this module simply asserted the denial as a premise of
`critical`. That was a weaker rival than the critical case actually is, and it
left nothing for an objection to engage. -/
@[bornOfAVirginDefs]
def criticalExclusion : Formula Claim :=
  ⋀ [ p .isaiahIsNearTermSignToAhaz, p .nearTermExcludesMessianicSense ]
  ➝ notP .isaiahPredictsVirginBirth

/-- Berry's objection: if how the sign was fulfilled in Ahaz's own day is
itself unsettled, the near-term reading is not secure enough to exclude a
further referent.

The step is contestable even though both atoms it joins are `wellSupported` —
an unclear fulfilment is still a fulfilment, and Brown would answer that Isaiah
8:3–4 settles the referent well enough. The step is rated in `berryLine`,
where it is cited `disputed`. -/
@[bornOfAVirginDefs]
def berryBlocksExclusion : Formula Claim :=
  p .nearTermFulfilmentIsUnclear ➝ notP .nearTermExcludesMessianicSense

/-- Postell's second counterexample: an oracle set against the Assyrian invasion,
read messianically, so a near-term Assyrian setting does not exclude a messianic
sense. The same inference as `parityDefeatsNearTermExclusion`, from a different
oracle in a different book (Postell 481 n. 72). -/
@[bornOfAVirginDefs]
def micahParityDefeatsNearTermExclusion : Formula Claim :=
  ⋀ [ p .micahRulerFacesAssyria, p .micahRulerReadMessianically ]
  ➝ notP .nearTermExcludesMessianicSense

/-- Motyer's inference: the sign of 7:14 is given to the dynasty, and the
timetable that answers Ahaz's crisis passes to Maher-shalal-hash-baz, so the
child of 7:14 is not a near-term sign to Ahaz. "Either we must identify
Maher-shalal-hash-baz with Immanuel, or we must project Immanuel into the
undated future" (Motyer 1970, 124).

This is the contested part of his reply, and it is a step rather than an atom
on purpose, as Berry's and Postell's are: the two atoms it joins are what the
text says, and the inference is what a reader who identifies the two children
denies, and `motyerLine` rates it `disputed` for that reason. -/
@[bornOfAVirginDefs]
def timetablePassesToMaherShalalHashBaz : Formula Claim :=
  ⋀ [ p .signGivenToHouseOfDavid, p .maherShalalHashBazRepeatsTheTimetable ]
  ➝ notP .isaiahIsNearTermSignToAhaz

/-! #### The referential strand

Sense against reference. The steps below never claim that עַלְמָה *means*
virgin; they claim that a virgin *is* an עַלְמָה, which is a different and far
cheaper claim, and then ask what the lexical objection is left with. -/

/-- If virginity is compatible with the denotation of עַלְמָה, and Mary was both
an עַלְמָה and a virgin, then Mary answers Isaiah's description — without the
word having to carry the sense. -/
@[bornOfAVirginDefs]
def toDescriptionFit : Formula Claim :=
  ⋀ [ p .almahDenotesMarriageableYoungWoman, p .virginityCompatibleWithAlmah
    , p .maryWasAnAlmah, p .maryConceivedAsVirgin ] ➝ p .maryFitsIsaianicDescription

/-- ... and if she answers it, the fulfilment claim never needed the lexical
sense in the first place. -/
@[bornOfAVirginDefs]
def descriptionFitDefeatsLexicalDemand : Formula Claim :=
  p .maryFitsIsaianicDescription ➝ notP .lexicalSenseRequiredForFulfilment

/-- The lexical objection in full: עַלְמָה does not denote virginity, Matthew's
claim requires that it does, so the fulfilment claim fails. Stated as the
objector would state it, so that the reply has something real to answer. -/
@[bornOfAVirginDefs]
def lexicalObjection : Formula Claim :=
  ⋀ [ notP .almahMeansVirgin, p .lexicalSenseRequiredForFulfilment ] ➝ notP .jesusSatisfiesCriterion

/-- The versional route to the lexical premise: the Targum and the Three read
the broad term, so the narrow sense is not the word's. -/
@[bornOfAVirginDefs]
def versionalObjection : Formula Claim :=
  ⋀ [ p .targumRendersUlemta, p .theThreeRenderNeanis
    , p .versionalDivergenceRefutesVirginSense ] ➝ notP .almahMeansVirgin

/-- **The tension, dissolved.** If virginity is compatible with עַלְמָה, the
versions are not contradicting one another about the referent at all: the
Peshitta, and the Septuagint if its παρθένος already meant "virgin"
(`Dispute.Septuagint`), render with the narrower term because they read the
referent as a virgin, the Targum and the Three render with the broader one, and
both are faithful renderings of a word whose denotation admits both. The
divergence stops being evidence about the sense. -/
@[bornOfAVirginDefs]
def compatibilityDissolvesDivergence : Formula Claim :=
  ⋀ [ p .virginityCompatibleWithAlmah, p .lxxRendersParthenos
    , p .peshittaRendersBtulta ] ➝ notP .versionalDivergenceRefutesVirginSense

/-- From the criterion and the historical claim, the fulfilment follows. -/
@[bornOfAVirginDefs]
def toFulfilment : Formula Claim :=
  ⋀ [p .messiahBornOfVirgin, p .maryConceivedAsVirgin] ➝ p .jesusSatisfiesCriterion

/-! #### Wegner's grammatical objection, and the circle Postell finds in it

The sharpest form of the lexical case. Each link is a step of its own, because
the result worth having is not whether the objection is valid — it is — but
which link carries its weight, and where that link comes from. -/

/-- Wegner's grammatical step: if הָרָה is a predicate adjective, the עַלְמָה of
the sign is pregnant already, at the moment the sign is given. -/
@[bornOfAVirginDefs]
def harahYieldsPresentPregnancy : Formula Claim :=
  p .harahIsPredicateAdjective ➝ p .isaianicAlmahIsAlreadyPregnant

/-- ... and if that pregnancy is an ordinary conception, the woman it describes
is not a virgin.

The second conjunct does all the work, and it is not a grammatical claim.
Rydelnik parses הָרָה exactly as Wegner does and reads the same clause as the
miracle itself — the virgin *is* pregnant — which is available to him precisely
because the parse leaves this open. -/
@[bornOfAVirginDefs]
def ordinaryPregnancyExcludesVirginity : Formula Claim :=
  ⋀ [ p .isaianicAlmahIsAlreadyPregnant, p .pregnancyAtTheSignIsOrdinary ]
  ➝ p .isaianicAlmahIsNotAVirgin

/-- ... and if what the one clear Isaianic referent turns out to be settles what
the word denotes, the lexical conclusion follows. -/
@[bornOfAVirginDefs]
def referentYieldsLexicalConclusion : Formula Claim :=
  ⋀ [ p .isaianicAlmahIsNotAVirgin, p .oneReferentSettlesDenotation ] ➝ notP .almahMeansVirgin

/-- **Where the ordinary pregnancy comes from.** Not from the grammar: from the
near-term reading of the sign, which has the child born within nine months and
the whole oracle discharged by 701 BC.

This is Postell's charge, written as a formula rather than repeated as a
complaint: "because Wegner rejects the messianic interpretation on
grammatical-historical grounds, he assumes that עַלְמָה cannot mean 'virgin' in
Isaiah 7:14" (468 n. 22). -/
@[bornOfAVirginDefs]
def readingSuppliesOrdinaryPregnancy : Formula Claim :=
  ⋀ [ p .isaiahIsNearTermSignToAhaz, notP .isaiahPredictsVirginBirth ]
  ➝ p .pregnancyAtTheSignIsOrdinary

/-- **The return leg.** The lexical conclusion is then turned against the
predictive reading, which is what the critical case does with it and what
`critical` already assumes.

Wegner's own version of this step is weaker — Postell reports it as decreasing
the likelihood of a virgin-birth prediction without ruling it out (469) — and
the encoding states the strong form on purpose. The strong form is the one on
which the two legs make a closed circle, and stating it is what lets
`circle_leaves_the_lexical_conclusion_open` be checked rather than asserted. On
the weaker
form the loop is evidential rather than deductive, which is the difference
between a vicious circle and mutual support. -/
@[bornOfAVirginDefs]
def lexicalConclusionTellsAgainstPrediction : Formula Claim :=
  ⋀ [ notP .almahMeansVirgin, p .lexicalSenseRequiredForFulfilment ]
  ➝ notP .isaiahPredictsVirginBirth

/-- **Postell's usage parity.** If a single clear referent settled the
denotation, the other clear עַלְמָה passages would settle it in the opposite
direction, since the women there are virgins. So that principle is not
available to the objection: it proves too much, and the wrong way. -/
@[bornOfAVirginDefs]
def usageParityBlocksReferentInference : Formula Claim :=
  p .otherClearAlmahCasesAreVirgins ➝ notP .oneReferentSettlesDenotation

/-! #### The fathers' sign argument, and the near-term reply

Wegner's objection needs the pregnancy to be an ordinary one. The oldest
Christian answer to the near-term reading denies exactly that, and it does so
without touching the word: the oracle promised a *sign*, and an ordinary
conception would have been none. -/

/-- **The sign argument.** If the sign of 7:14 must be extraordinary, and an
ordinary conception is nothing extraordinary, the pregnancy the sign announces
is not an ordinary one.

The step assumes that the conception is the sign rather than one part of it.
Wegner counts three parts in 7:14 and more in 7:15–16 (469, 477), but he does
not grant the first ground and deny the conclusion: he denies the first
ground. -/
@[bornOfAVirginDefs]
def extraordinarySignExcludesOrdinaryPregnancy : Formula Claim :=
  ⋀ [ p .signMustBeExtraordinary, p .ordinaryConceptionIsNoMarvel ]
  ➝ notP .pregnancyAtTheSignIsOrdinary

/-- **The near-term reply.** Signs elsewhere in Isaiah are ordinary events, and
this one is dated by a child's infancy, so its point is its timing and it need
not be extraordinary. -/
@[bornOfAVirginDefs]
def ordinarySignsAnswerTheDemand : Formula Claim :=
  ⋀ [ p .isaianicSignsAreOrdinaryEvents, p .signDatedByAChildsInfancy ]
  ➝ notP .signMustBeExtraordinary

/-! #### The Septuagint, and what its word meant

Jews translated Isaiah into Greek before Christ and wrote παρθένος. What that
shows depends on what παρθένος meant to them, and the steps below keep the two
questions apart: what the translator wrote, and what the word he wrote meant. -/

/-- **The Septuagint as a witness.** A Jewish translator, before Christ, chose
for the woman of 7:14 a word that means a virgin; so he read her as one. -/
@[bornOfAVirginDefs]
def septuagintReadsAVirgin : Formula Claim :=
  ⋀ [ p .lxxRendersParthenos, p .lxxIsPreChristian, p .parthenosMeansVirgin ]
  ➝ p .lxxReadsAVirgin

/-- **Wegner's case that the word's sense shifted.** In early Greek παρθένος
meant a young woman, with or without virginity, and the Septuagint still calls
Dinah one after Shechem has lain with her; so in the Septuagint's day the word
meant "young woman", and the sense "virgin" came later. -/
@[bornOfAVirginDefs]
def dinahShowsTheOlderSense : Formula Claim :=
  ⋀ [ p .earlyGreekParthenosIsYoungWoman, p .dinahIsAParthenosAfterShechem ]
  ➝ p .parthenosMeantYoungWoman

/-- **The case from usage.** Rico and Gentry's: the Jews who rejected the
Christian reading of 7:14 rejected the word itself, Trypho reading "the young
woman" and the Three writing νεᾶνις. With it the library's own addition: the
Greek Isaiah's παρθένος renders בְּתוּלָה wherever else it occurs. So the word
meant a virgin. -/
@[bornOfAVirginDefs]
def usageShowsTheVirginSense : Formula Claim :=
  ⋀ [ p .isaiahUsesParthenosForBetulah, p .theThreeRenderNeanis
    , p .tryphoRejectsParthenos ]
  ➝ p .parthenosMeansVirgin

/-- **From the translator's reading to Isaiah's word.** If the first translator
read the woman of 7:14 as a virgin, the word Isaiah used of her denotes one.

The step the Septuagint is usually asked to take, and the one its grounds do not
supply: it has to be granted separately, and it is rated `disputed`.

Irenaeus takes it because he holds the Greek inspired: the seventy elders,
translating apart, agreed "in the very same words", so that "the Scriptures had
been interpreted by the inspiration of God" (*Against Heresies* III.21.2).

Bratcher and Brown grant the ground and deny the step. Bratcher holds that the
translator meant "a young woman, at that time virgin" (115), and that עַלְמָה "is
neutral, so far as virginity is concerned" (105): "even if in all occurrences of
the word in the Old Testament it were proven that the 'almah in each case was,
in fact, a virgin, that would not prove that 'almah in Isaiah 7:14 means
'virgin'" (106). Brown holds that the translator's choice "represented a
deliberate preference for understanding the young woman of Isa 7:14 as a
virgin" (*Birth of the Messiah* 148), and that עַלְמָה puts "no stress on her
virginity" (147). Walton, who doubts the ground itself, denies the step even if it
is granted: "it is illegitimate to use the LXX translation to override clear
lexical material in the Hebrew text", and "at best the LXX would indicate an
interpretational preference rather than a linguistic necessity" (293).

Bratcher's and Brown's reason is that a rendering can follow the woman described
rather than the word. The translator of Genesis wrote παρθένος for the עַלְמָה
Rebekah (24:43), whom the story has already called a virgin (24:16):
"historically correct — since Rebekah was a virgin", Bratcher says, but it "does
not precisely translate the Hebrew" (113). Jerome reads Rebekah the other way, as
showing that עַלְמָה denotes a virgin (*Against Jovinianus* I.32). Elsewhere the
Septuagint's translators render עַלְמָה with νεᾶνις four times (Exodus 2:8;
Psalm 67:26, 68:25 in English Bibles; Song 1:3; 6:8) and with νεότης, "youth",
once (Proverbs 30:19), as Rahlfs's text shows; Rhodea counts the νεᾶνις cases
(67 n. 34). These are other translators than Isaiah's, as the translator of
Genesis 34:3 is. That is also how this argument's referential strand reads the
versions
(`compatibilityDissolvesDivergence`). -/
@[bornOfAVirginDefs]
def translatorsReadingFixesTheWord : Formula Claim :=
  p .lxxReadsAVirgin ➝ p .almahMeansVirgin

/-! ### The lines of reason

Four strands converge on the criterion, and each is a `Line`: its own grounds,
its own licensing step, and what it delivers. The packages are assembled from
these rather than from flat premise lists, so a variant package is a *named
difference* — one line on different grounds — instead of twenty premises retyped
with one missing.

`grounds` are the premises a line contributes of its own. What the strands hold
in common (Mary's conception, the agreement of the two narratives) is passed to
`caseOf` as shared, because it belongs to no single strand. -/

/-- **The Isaianic line.** The predictive reading, the lexical premise, the
Septuagint's rendering, and Matthew's quotation and intent. Its hinge is
`almahMeansVirgin`, and the whole lexical dispute is about that one ground. -/
@[bornOfAVirginDefs]
def isaianicLine : Line Claim :=
  { name := "Isaianic strand (Isaiah 7:14)"
  , grounds :=
      [ p .isaiahPredictsVirginBirth, p .almahMeansVirgin, p .lxxRendersParthenos
      , p .matthewQuotesIsaiah, p .matthewIntendsFulfilment ]
  , step := toCriterion
  , delivers := p .messiahBornOfVirgin }

/-- **The protoevangelium line.** Genesis 3:15 read as promise, the patrilineal
idiom, and the inference drawn from its departure. Its hinge is
`seedOfTheWomanImpliesNoHumanFather`, and the module doc says why that hinge is
weaker than the argument needs. -/
@[bornOfAVirginDefs]
def protoevangeliumLine : Line Claim :=
  { name := "Protoevangelium strand (Genesis 3:15)"
  , grounds :=
      [ p .genesis3_15SeedOfTheWoman, p .genesis3_15IsProtoevangelium
      , p .seedReckonedThroughFather, p .seedOfTheWomanImpliesNoHumanFather ]
  , step := genesisToCriterion
  , delivers := p .messiahBornOfVirgin }

/-- **The Michean line.** The maternal-only wording of Micah 5:3 and the
inference drawn from it. Its hinge is an argument from silence, and the rival
says so. -/
@[bornOfAVirginDefs]
def micheanLine : Line Claim :=
  { name := "Michean strand (Micah 5:2–3)"
  , grounds :=
      [ p .micah5_3NamesMotherOnly, p .maternalSilenceImpliesNoHumanFather ]
  , step := micahToCriterion
  , delivers := p .messiahBornOfVirgin }

/-- **The compositional line.** Isaiah 7's placement in an eschatologically
framed unit, the principle that placement governs meaning, and the future birth
that follows. Its hinge is `compositionGovernsMeaning`. -/
@[bornOfAVirginDefs]
def compositionalLine : Line Claim :=
  { name := "Compositional strand (Isaiah 2–12)"
  , grounds :=
      [ p .isaiah2to12FramedByEschatology, p .compositionGovernsMeaning
      , p .compositionalReadingYieldsFutureBirth ]
  , step := compositionalToCriterion
  , delivers := p .messiahBornOfVirgin }

/-- **The magisterial line.** Papal teaching and the authority granted it.

Encoded as a line like the others and deliberately kept out of `christian`: its
second ground is one this library's author does not grant. Keeping it a line
rather than folding it into a package is what lets
`magisterial_authority_is_load_bearing` ask what the route is worth on its
own. -/
@[bornOfAVirginDefs]
def magisterialLine : Line Claim :=
  { name := "Magisterial strand (papal teaching)"
  , grounds :=
      [ p .magisteriumTeachesVirginalConception
      , p .magisteriumIsDoctrinallyAuthoritative ]
  , step := magisterialToCriterion
  , delivers := p .messiahBornOfVirgin }

/-- **The referential line.** The shared lexical ground, the Rebekah datum,
and the two facts about Mary, delivering that she answers Isaiah's description
without the word having to carry the sense.

`qumranConfirmsAlmah` is a ground here because the reply has to be about the
sense rather than the text: if the Hebrew were in doubt the dispute would not
be purely semantic, and the line would not be the cheap move it is. -/
@[bornOfAVirginDefs]
def referentialLine : Line Claim :=
  { name := "Referential reading: a virgin is an עַלְמָה"
  , grounds :=
      [ p .almahDenotesMarriageableYoungWoman, p .virginityCompatibleWithAlmah
      , p .maryWasAnAlmah, p .maryConceivedAsVirgin
      , p .qumranConfirmsAlmah ]
  , step := toDescriptionFit
  , delivers := p .maryFitsIsaianicDescription }

/-- **The versional line**, stated as the objector would state it: the Targum
and the Three read the broad term, Qumran settles the Hebrew, and Matthew's
claim is taken to need the narrow sense — so the word does not denote
virginity. -/
@[bornOfAVirginDefs]
def versionalLine : Line Claim :=
  { name := "Lexical objection from the ancient versions"
  , grounds :=
      [ p .targumRendersUlemta, p .theThreeRenderNeanis, p .qumranConfirmsAlmah
      , p .versionalDivergenceRefutesVirginSense
      , p .lexicalSenseRequiredForFulfilment ]
  , step := versionalObjection
  , delivers := notP .almahMeansVirgin }

/-- **The Wegner line.** The predicate-adjective parse, the near-term setting
of the sign, the ordinary pregnancy that setting supplies, and the principle
that the Isaianic referent settles the word's denotation — delivering that the
עַלְמָה of the sign is pregnant when it is given.

The line stops at the pregnancy and the two further moves are closing steps,
because that is where the argument actually divides: the parse is common
ground, and everything contestable happens after it.

`lexicalSenseRequiredForFulfilment` is not among its grounds and is not
Wegner's view. He holds a prophetic pattern, on which Matthew's use of the
verse survives the lexical finding, so the objection stops at the lexical
conclusion rather than running on to the fulfilment claim. -/
@[bornOfAVirginDefs]
def wegnerLine : Line Claim :=
  { name := "Wegner's grammatical objection (Isaiah 7:14)"
  , grounds :=
      [ p .harahIsPredicateAdjective, p .isaiahIsNearTermSignToAhaz
      , p .pregnancyAtTheSignIsOrdinary, p .oneReferentSettlesDenotation ]
  , step := harahYieldsPresentPregnancy
  , delivers := p .isaianicAlmahIsAlreadyPregnant }

/-- The two steps that carry Wegner's line to its lexical conclusion: the
pregnancy excludes virginity, and the referent settles the word. Passed to
`caseOf` as closing steps, so that a variant can change the grounds without
retyping them. -/
@[bornOfAVirginDefs]
def wegnerClosingSteps : List (Formula Claim) :=
  [ordinaryPregnancyExcludesVirginity, referentYieldsLexicalConclusion]

/-- **The fathers' sign argument.** Justin, Irenaeus and Origen, and Rydelnik
today: the sign of 7:14 must be extraordinary, an ordinary conception is not, so
the pregnancy is no ordinary one. It denies the ground of Wegner's line that the
parse does not supply, and nothing else. -/
@[bornOfAVirginDefs]
def signLine : Line Claim :=
  { name := "The fathers' sign argument (Isaiah 7:11, 14)"
  , grounds := [ p .signMustBeExtraordinary, p .ordinaryConceptionIsNoMarvel ]
  , step := extraordinarySignExcludesOrdinaryPregnancy
  , delivers := notP .pregnancyAtTheSignIsOrdinary
    -- `plausible`: no source cited here grants both grounds and holds the
    -- pregnancy ordinary. The rival denies the first ground instead, and the
    -- grounds are rated separately. Not `wellSupported`: the step reads the
    -- conception as the whole of the sign.
  , inference := some
      { primary := .work irenaeusAgainstHeresies (.sectionRef "III.21.6")
      , supporting := [.work origenAgainstCelsus (.sectionRef "I.35")]
      , tradition := .christianTypological
      , confidence := .plausible } }

/-- **The near-term reply**, as an argument: signs in Isaiah are ordinary
events, and this one is dated by a child's infancy, so it need not be
extraordinary. Wegner (469–470) and Rhodea (64–65). -/
@[bornOfAVirginDefs]
def ordinarySignLine : Line Claim :=
  { name := "The near-term reply: a sign need not be a miracle"
  , grounds := [ p .isaianicSignsAreOrdinaryEvents, p .signDatedByAChildsInfancy ]
  , step := ordinarySignsAnswerTheDemand
  , delivers := notP .signMustBeExtraordinary
    -- `disputed`: Rydelnik grants both grounds — Isaiah's children are the
    -- "signs and wonders" of 8:18, and 7:16 dates by Shear-jashub's infancy —
    -- and still reads the pregnancy of 7:14 as a sign as deep as Sheol, as
    -- Postell reports (474).
  , inference := some
      { primary := .work rhodeaDidMatthewConceive (.pages 64 65)
      , supporting :=
          [ .work wegnerVirginBirths (.pages 469 470)
          , .work postellIsaiahMessianic (.page 474) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- **The Septuagint as a witness.** Irenaeus's argument: the Greek was made by
Jews long before Christ, so its "virgin" cannot be a Christian reading put on
the text. Its hinge is `parthenosMeansVirgin`, and the dispute over the
Septuagint is about that one ground.

The step draws out its grounds: a translator who chose for the woman a word that
means a virgin described her as one. It is rated `disputed`, on one reader.
Walton, reporting Archer, holds that the translator of Isaiah "consistently
showed a tendency to be imprecise in his choice of Greek terms": "often a vaguely
suitable term was chosen when a much more acceptable and precise term was
available. This could well be the explanation of the use of parthenos here"
(293). On that account a translator can write a word that means a virgin without
meaning that the woman was one. The main contest is over the third ground, which
is rated `disputed` in its own right; the step's rating changes no verdict,
because the witness is already no stronger than that ground. -/
@[bornOfAVirginDefs]
def septuagintLine : Line Claim :=
  { name := "The Septuagint as a witness (Isaiah 7:14 in Greek)"
  , grounds :=
      [ p .lxxRendersParthenos, p .lxxIsPreChristian, p .parthenosMeansVirgin ]
  , step := septuagintReadsAVirgin
  , delivers := p .lxxReadsAVirgin
  , inference := some
      { primary := .work irenaeusAgainstHeresies (.sectionRef "III.21.1")
      , supporting := [.work waltonWhatsInAName (.page 293)]
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- **Wegner on παρθένος**: in the Septuagint's day the word meant "young
woman", and came to mean "virgin" only by the time of the New Testament
(482–83). Held by Wegner, Rhodea and Meade; disputed by Rico and Gentry, and by
Bratcher. Rhodea follows Wegner, with an "apparently", and draws from Genesis
34:3 that the word "need not refer to a virgo intacta" (67). Meade holds the
same, "cf. Dina in Gen 34:3", and that by Justin's day the word had been
"hijacked or used to mean 'chaste woman' only" (comment of 9 January 2013).

The step is rated `disputed`, because two readers grant both its grounds and
deny its conclusion. Rico and Gentry grant the older usage, and that the Greek
calls Dinah a παρθένος; but Genesis 34:1–3 is "the exception that proves the
rule" (21), an archaism of the Greek Pentateuch, whose language is "more
elevated and classical than the language of the later texts" (18). Bratcher
grants both — "at first the word was used in a general sense of 'girl', 'young
woman'" (112), and Dinah "was no longer, therefore, a 'virgin'" — and still
finds that "parthenos definitely means 'virgin' in the LXX; only very
exceptionally (and, inexplicably, in Gen. 34:3) is it used otherwise" (113). The
Greek Isaiah, a later book by another translator, uses the word elsewhere only
for בְּתוּלָה (`isaiahUsesParthenosForBetulah`). -/
@[bornOfAVirginDefs]
def driftLine : Line Claim :=
  { name := "Wegner on παρθένος: the word had not yet come to mean 'virgin'"
  , grounds := [ p .earlyGreekParthenosIsYoungWoman, p .dinahIsAParthenosAfterShechem ]
  , step := dinahShowsTheOlderSense
  , delivers := p .parthenosMeantYoungWoman
  , inference := some
      { primary := .work wegnerVirginBirths (.pages 482 483)
      , supporting :=
          [ .work rhodeaDidMatthewConceive (.page 67)
          , .work meadeAncientVersionsComment .whole
          , .work ricoGentryInfantKing (.pages 18 21)
          , .work bratcherStudyOfIsaiah (.pages 112 113) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- **The case from usage.** Held by Rico and Gentry; disputed by Davidson and
Meade. Rico and Gentry argue from the Jewish objection itself: "Otherwise the
discussion of Justin and Trypho and the change from parthenos to neanis by
AQUILA, SYMMACHUS, and THEODOTION in Is 7:14 would have no raison d'être" (21).

The first ground, the Greek Isaiah's other uses of the word, is the library's
own addition, read from the two texts: it is the usage of the translator whose
word is in question, as Genesis 34:3 is not. What the texts read is not in
dispute; what it shows can be. It shows the sense "virgin" only if בְּתוּלָה
means a virgin where he renders it, and two of the four are figures for a city,
the "virgin daughter" of Zion (37:22) and of Babylon (47:1). Bratcher, who
argues from the same correspondence across the whole Septuagint — 45 of the 52
times בְּתוּלָה occurs — warns that where it means only a young girl, or is used
figuratively, "in such cases parthenos in the LXX will have the same meaning"
(113).

The step is rated `disputed`, on two readers who grant the Jewish objection and
read it the other way: the revisers were answering a sense Christians had put on
the word, not the sense its translator gave it. A. B. Davidson: the Three wrote
νεᾶνις "possibly to evade the technical sense put on the word by the
Christians", παρθένος having been "used generally for 'girl' or 'young woman'"
(*A Dictionary of the Bible* II, 1899, 456). John Meade, a Septuagint scholar
whose doctoral supervisor was Gentry, finds the revisers' change sensible "only in a
context where παρθενος has been hijacked or used to mean 'chaste woman' only
(which by the time of Justin Martyr, it clearly had been, since Trypho never
disputes this point but only relies on his different version which had
νεανις)"; for "παρθενος simply means young woman in this verse and in other
places in the LXX" (comment of 9 January 2013).

The dissents on both rival steps are brief. Davidson hedges his account of the
Three with a "possibly", though not his account of the word; Meade's is a blog
comment, revising his own earlier view toward "young woman". Against Wegner's
step, Rico and Gentry give a reason, the archaism of the Greek Pentateuch, and
Bratcher calls Genesis 34:3 inexplicable without explaining it. The ratings weigh
none of this: each step has a cited reader who grants its grounds and denies its
conclusion, and so each is `disputed`. Wegner's reading can be held with all
three grounds here too — it is the countermodel in
`usage_rests_on_its_inference` — though he does not discuss the Three or Trypho.
The rating matters: rated higher, this step would decide the dispute over the
Septuagint in the witness's favour (`Dispute.Septuagint` says why). -/
@[bornOfAVirginDefs]
def usageLine : Line Claim :=
  { name := "Rico and Gentry: παρθένος means 'virgin' in the Greek of the Scriptures"
  , grounds :=
      [ p .isaiahUsesParthenosForBetulah, p .theThreeRenderNeanis
      , p .tryphoRejectsParthenos ]
  , step := usageShowsTheVirginSense
  , delivers := p .parthenosMeansVirgin
  , inference := some
      { primary := .work ricoGentryInfantKing (.page 21)
      , supporting :=
          [ .work postellIsaiahMessianic (.page 472)
          , .work davidsonImmanuel (.page 456)
          , .work meadeAncientVersionsComment .whole ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- **The critical line**: the sign was given to Ahaz, and such a sign is not
also a prediction of a virgin conception, so the predictive reading is denied.

Its grounds are what the two defeaters attack. Berry replaces the second with
`nearTermFulfilmentIsUnclear` plus `berryBlocksExclusion`; parity replaces it
with Isaiah 9 and 11 plus `parityDefeatsNearTermExclusion`. -/
@[bornOfAVirginDefs]
def criticalExclusionLine : Line Claim :=
  { name := "Critical denial of the predictive reading of Isaiah 7:14"
  , grounds :=
      [ p .isaiahIsNearTermSignToAhaz, p .nearTermExcludesMessianicSense ]
  , step := criticalExclusion
  , delivers := notP .isaiahPredictsVirginBirth
    -- `consensus`: the step only applies the exclusion premise to 7:14, and
    -- anyone who grants both grounds grants it. The critic's contest lives in
    -- the grounds, where it is rated.
  , inference := some (brownOnBirth .consensus) }

/-! ### The two defeaters, as arguments in their own right

`criticalDenialUnderBerry` and `criticalDenialUnderParity` ask what the critical
line is left with once a reply is in play. The lines below ask something else:
what each reply *concludes*, taken on its own. Written this way a reply is a
position with premises of its own, and so a node that can defeat, and be
defeated by, the line it answers — see `Dispute.lean`. -/

/-- **Berry's objection**, as an argument: the near-term fulfilment is unclear,
so the near-term reading does not exclude the messianic sense. -/
@[bornOfAVirginDefs]
def berryLine : Line Claim :=
  { name := "Berry's objection to the near-term exclusion"
  , grounds := [p .nearTermFulfilmentIsUnclear]
  , step := berryBlocksExclusion
  , delivers := notP .nearTermExcludesMessianicSense
    -- `disputed`: Watts grants the ground — "the chronologies of this period
    -- are very uncertain" — and still reads 7:14 of Hezekiah alone, as Compton
    -- reports (5). An unclear fulfilment is still a fulfilment.
  , inference := some
      { primary := .work berryVirginBirth (.pages 1653 1654)
      , supporting := [.work comptonImmanuelProphecy (.page 5)]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- **Postell's parity argument**, as an argument: Isaiah 9 and 11 are messianic
on the same near-term timeline, so a near-term setting does not exclude the
messianic sense. -/
@[bornOfAVirginDefs]
def postellLine : Line Claim :=
  { name := "Postell's parity argument against the near-term exclusion"
  , grounds :=
      [ p .isaiah9And11AreMessianic, p .isaiah9And11ShareTheAssyrianTimeline ]
  , step := parityDefeatsNearTermExclusion
  , delivers := notP .nearTermExcludesMessianicSense
    -- `plausible`: a counterexample to the exclusion, and no source cited
    -- here grants both grounds and keeps the exclusion. A critic's answer
    -- would deny a ground — that 9 and 11 are messianic in Isaiah's own
    -- sense — and the grounds are rated separately. Not `wellSupported`: the
    -- argument is recent and unanswered, which is not the same as established.
  , inference := some (postellOnIsaiah (.pages 487 489) .plausible) }

/-- **Motyer's reply**, as an argument, with Compton: the sign is given to the
house of David and the near-term timetable passes to Isaiah's son, so Isaiah
7:14 is not a near-term sign to Ahaz. The first reply to deny the critic's
near-term premise rather than its exclusion premise. -/
@[bornOfAVirginDefs]
def motyerLine : Line Claim :=
  { name := "Motyer's reply to the near-term reading"
  , grounds :=
      [ p .signGivenToHouseOfDavid, p .maherShalalHashBazRepeatsTheTimetable ]
  , step := timetablePassesToMaherShalalHashBaz
  , delivers := notP .isaiahIsNearTermSignToAhaz
    -- `disputed`: those who identify the two children grant both grounds and
    -- keep the near-term sign — Clements, as Compton reports (5).
  , inference := some
      { primary := .work motyerContextContent (.page 124)
      , supporting := [.work comptonImmanuelProphecy (.page 5)]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- **Postell's Micah counterexample**, as an argument: the ruler of Micah 5 is
set against the Assyrian invasion and was read messianically, so a near-term
setting does not exclude a messianic sense. -/
@[bornOfAVirginDefs]
def micahLine : Line Claim :=
  { name := "Postell's Micah counterexample to the near-term exclusion"
  , grounds := [ p .micahRulerFacesAssyria, p .micahRulerReadMessianically ]
  , step := micahParityDefeatsNearTermExclusion
  , delivers := notP .nearTermExcludesMessianicSense
    -- `plausible`, as for the Isaiah counterexample and for the same reason:
    -- no source cited grants both grounds and keeps the exclusion. A critic's
    -- likeliest answer is a disanalogy — Micah 5 is not a sign to Ahaz — and
    -- the same answer would meet `postellLine`.
  , inference := some (postellOnIsaiah (.page 481) .plausible) }

/-! ### What the strands share -/

/-- The premises no single strand owns: Mary's conception, and the agreement of
the two birth narratives about it. Every scriptural package needs them and
none of the four strands delivers them. -/
@[bornOfAVirginDefs]
def sharedGrounds : List (Formula Claim) :=
  [ p .maryConceivedAsVirgin, p .independentAttestation ]

/-- The four scriptural strands, in the order the module doc introduces them.
`christian` is exactly these four on shared ground. -/
@[bornOfAVirginDefs]
def scripturalLines : List (Line Claim) :=
  [ isaianicLine, protoevangeliumLine, micheanLine, compositionalLine ]

end TestimonyArguments.BornOfAVirgin
