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

/-- Protoevangelium strand: Genesis 3:15 promises a redeemer as "her seed"; a
man's line is ordinarily counted through the father; and naming the seed as the
woman's marks a birth with no human father. So the Messiah must be born of a
virgin. -/
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
Septuagint, if its παρθένος already meant "virgin" (`Dispute.Septuagint`), and
the Peshitta render with the narrower term, the Targum and the Three with the
broader one, and both are faithful renderings of a word whose denotation admits
both. The divergence stops being evidence about the sense.

Why the Peshitta has the narrower term is not settled. It is its only ܒܬܘܠܬܐ for
עַלְמָה, and whether that is its translator's reading of the woman, the
Septuagint's influence, or a later Christian hand, Chen finds impossible to
decide (104–5). The step needs only that the rendering is a faithful one, not
why it was chosen. -/
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
meant a young woman, with or without virginity; the Septuagint calls Dinah one
at 34:3, and the noun there describes her as she then was, no longer a virgin;
so in the Septuagint's day the word meant "young woman", and the sense "virgin"
came later. -/
@[bornOfAVirginDefs]
def dinahShowsTheOlderSense : Formula Claim :=
  ⋀ [ p .earlyGreekParthenosIsYoungWoman, p .greekCallsDinahParthenos
    , p .parthenosDescribesDinahAsSheThenWas ]
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

/-! #### Genesis 3:15, and what "her seed" says of a father

The protoevangelium strand holds that the seed being named as the woman's marks
a birth with no human father. The steps below take apart what "marks" can mean:
that the wording itself signifies such a birth, which Luther argues and
Leupold, Keil and Lewis deny, or that it fits one once fulfilled, which Leupold
and Keil grant. -/

/-- **Luther's step.** Genesis 3:15 names the seed as the woman's, it is the
first promise of a redeemer, and a man's seed is ordinarily reckoned through
him; so the wording itself signifies a birth with no human father. -/
@[bornOfAVirginDefs]
def herSeedSignifiesNoFather : Formula Claim :=
  ⋀ [ p .genesis3_15SeedOfTheWoman, p .genesis3_15IsProtoevangelium
    , p .seedReckonedThroughFather ]
  ➝ p .wordingSignifiesAFatherlessBirth

/-- **Leupold's step.** "Her seed" is first collective, the woman's posterity,
and the seed is named hers because the serpent deceived her; so the wording does
not itself signify a birth with no human father. -/
@[bornOfAVirginDefs]
def posterityExplainsTheWording : Formula Claim :=
  ⋀ [ p .genesis3_15SeedOfTheWoman, p .seedIsHerPosterityFirst
    , p .womanNamedForTheDeception ]
  ➝ notP .wordingSignifiesAFatherlessBirth

/-- **Lewis's step.** Genesis speaks of a woman's seed in ordinary births too;
so the woman's seed at 3:15 does not by itself signify a birth with no human
father. -/
@[bornOfAVirginDefs]
def ordinaryBirthsAnswerTheWording : Formula Claim :=
  ⋀ [ p .genesis3_15SeedOfTheWoman, p .womansSeedSaidOfOrdinaryBirths ]
  ➝ notP .wordingSignifiesAFatherlessBirth

/-- **The Greek's "he".** The Greek refers to the neuter seed with a masculine
pronoun; so its translator read the seed as one person. -/
@[bornOfAVirginDefs]
def heReadsOneDescendant : Formula Claim :=
  p .lxxCallsTheSeedHe ➝ p .lxxReadsOneDescendant

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

/-- **The protoevangelium line.** Genesis 3:15 read as the promise of a
redeemer, a man's line counted through the father, and the claim that naming the
seed as the woman's marks a birth with no human father. That claim is its hinge
(`seedOfTheWomanImpliesNoHumanFather`), and `Results.Genesis` says what it can
bear, read either way. -/
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
and two claims about Mary — that she was a young woman of marriageable age, and
that she conceived as a virgin, which is cited `disputed` — delivering that she
answers Isaiah's description without the word having to carry the sense. The
fathers answer the Jewish "young woman" the same way: Cyril of Alexandria, "even
if the virgin were called a young woman, she will not cease to be a virgin".

The scroll's reading is a ground because the reply is about what the word
means, not which word Isaiah wrote: 1QIsaᵃ, copied before Christ, has the
Masoretic Text's עַלְמָה. If the Hebrew were in doubt the dispute would not be
about the sense alone, and the reply would have more to answer. -/
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

/-- **The fathers' sign argument.** Justin, Irenaeus and Origen, and every other
father the library has read on the verse, and Rydelnik today: the sign of 7:14
must be extraordinary, an ordinary conception is not, so the pregnancy is no
ordinary one. It denies the ground of Wegner's line that the parse does not
supply, and nothing else.

Its step is rated `plausible`: no source cited here grants both grounds and
holds the pregnancy ordinary. The rival denies the first ground instead, and the
grounds are rated separately. It is not rated higher, because the step reads the
conception as the whole of the sign. -/
@[bornOfAVirginDefs]
def signLine : Line Claim :=
  { name := "The fathers' sign argument (Isaiah 7:11, 14)"
  , grounds := [ p .signMustBeExtraordinary, p .ordinaryConceptionIsNoMarvel ]
  , step := extraordinarySignExcludesOrdinaryPregnancy
  , delivers := notP .pregnancyAtTheSignIsOrdinary
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
means a virgin described her as one. It is rated `plausible`: no reader cited
here grants that the word means a virgin and denies that the translator called
her one. Bratcher and Brown, who deny the next step, grant this one: the
translator meant "a young woman, at that time virgin" (Bratcher 115), "a
deliberate preference for understanding the young woman of Isa 7:14 as a virgin"
(Brown 148).

Walton doubts the word itself, and that dissent is counted where it belongs, in
the rating of the third ground. Against the step he offers one thing more,
Archer's suggestion that the translator of Isaiah "consistently showed a tendency
to be imprecise in his choice of Greek terms", which "could well be the
explanation of the use of parthenos here" (293). That is a guess at why the
translator wrote the word, not a reading of what he wrote, and it is not counted
as a dissent. The translator's own text tells against it: everywhere else in his
Isaiah, παρθένος stands for בְּתוּלָה (23:4, 37:22, 47:1, 62:5;
`isaiahUsesParthenosForBetulah`). The step is not rated higher, because none of
its readers argues for it beyond the word's sense.

The main contest is over the third ground, rated `disputed`; the witness is no
stronger than that ground, so the step's rating changes no verdict. -/
@[bornOfAVirginDefs]
def septuagintLine : Line Claim :=
  { name := "The Septuagint as a witness (Isaiah 7:14 in Greek)"
  , grounds :=
      [ p .lxxRendersParthenos, p .lxxIsPreChristian, p .parthenosMeansVirgin ]
  , step := septuagintReadsAVirgin
  , delivers := p .lxxReadsAVirgin
  , inference := some
      { primary := .work irenaeusAgainstHeresies (.sectionRef "III.21.1")
      , supporting :=
          [ .work bratcherStudyOfIsaiah (.page 115)
          , .work brownBirthMessiah (.page 148) ]
      , tradition := .christianTypological
      , confidence := .plausible } }

/-- **Wegner on παρθένος**: in the Septuagint's day the word meant "young
woman", and came to mean "virgin" only by the time of the New Testament
(482–83). Held by Wegner, Rhodea and Meade; disputed by Rico and Gentry, and by
Bratcher. Rhodea follows Wegner, with an "apparently", and draws from Genesis
34:3 that the word "need not refer to a virgo intacta" (67). Meade holds the
same, "cf. Dina in Gen 34:3", and that by Justin's day the word had been
"hijacked or used to mean 'chaste woman' only" (comment of 9 January 2013).

Three grounds: the older usage; what the Greek of 34:3 reads; and that the noun
there describes Dinah as she then was. The third is Wegner's own — Dinah "is
called a παρθένος even after she was raped by Shechem" (483) — and Miller's, and
it is not the text's: the order of the verses puts Shechem's love after his act,
not the noun's description (`parthenosDescribesDinahAsSheThenWas`). It is
written out, not left inside the step, so that a reader sees it.

The step is rated `disputed`, because two readers grant all its grounds and
deny its conclusion. Rico and Gentry grant the older usage, that the Greek
calls Dinah a παρθένος, and that she was then no longer a virgin; but Genesis
34:1–3 is "the exception that proves the rule" (21), an archaism of the Greek
Pentateuch, whose language is "more elevated and classical than the language of
the later texts" (18). Bratcher
grants all three — "at first the word was used in a general sense of 'girl',
'young woman'" (112), and Dinah "was no longer, therefore, a 'virgin'" — and still
finds that "parthenos definitely means 'virgin' in the LXX; only very
exceptionally (and, inexplicably, in Gen. 34:3) is it used otherwise" (113). The
Greek Isaiah, a later book by another translator, uses the word elsewhere only
for בְּתוּלָה (`isaiahUsesParthenosForBetulah`).

Delling, in the standard theological dictionary, reads the Septuagint's usage at
Isaiah 7:14 as demanding "no more than the sense of a 'woman untouched by a man
up to the moment of the conception'" (*TDNT* 5.833, as Rhodea quotes him, 67
n. 42): a virgin until then, whatever followed. And the Greek Pentateuch, the
corpus Genesis 34:3 comes from, uses the word in its laws where virginity is the
point (`lawsLine`). One passage in the broader sense does not show that the
narrower sense was missing. -/
@[bornOfAVirginDefs]
def driftLine : Line Claim :=
  { name := "Wegner on παρθένος: the word had not yet come to mean 'virgin'"
  , grounds :=
      [ p .earlyGreekParthenosIsYoungWoman, p .greekCallsDinahParthenos
      , p .parthenosDescribesDinahAsSheThenWas ]
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
whose doctoral supervisor was Gentry, so that the dissent comes from within
Gentry's own school, finds the revisers' change sensible "only in a
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

/-- **Scripture's reading of the Greek word.** Matthew quotes the Septuagint's ἡ
παρθένος of a woman who conceived before she and Joseph came together; so in the
text he quotes, the word has the sense "virgin". -/
@[bornOfAVirginDefs]
def matthewReadsTheGreek : Formula Claim :=
  ⋀ [ p .matthewQuotesTheGreekVirgin, p .matthewSaysMaryKnewNoMan ]
  ➝ p .lxxIsaiahUsesParthenosAsVirgin

/-- The citation for Scripture's reading of the Greek word, at a confidence:
Westminster's rule that Scripture interprets Scripture (I.ix), Irenaeus on the
apostles' agreement with the Seventy (III.21.3), and Wegner, who grants Matthew's
use and denies the step (483). -/
@[bornOfAVirginDefs]
def matthewReadingSource (c : Confidence) : Source :=
  { primary := .work westminsterConfession (.sectionRef "I.ix")
  , supporting :=
      [ .work irenaeusAgainstHeresies (.sectionRef "III.21.3")
      , .work wegnerVirginBirths (.page 483) ]
  , tradition := .reformedProtestant
  , confidence := c }

/-- **Scripture interprets Scripture: Matthew's quotation.** The Gospel quotes
the Greek of Isaiah 7:14, ἡ παρθένος, of Mary, who conceived "before they came
together" (1:18) and whom Joseph "knew not until she had borne a son" (1:25). If
Scripture is its own interpreter — "The infallible rule of interpretation of
Scripture is the Scripture itself" (Westminster I.ix) — the word in the text
Matthew quotes has the sense he gives it. Its grounds are Scripture alone.

Like the case from the laws, it concludes that a passage of the Septuagint uses
the word in the sense "virgin", and so, by what a usage is, that the sense was
the Septuagint's, which Wegner denies. It says nothing of the Hebrew עַלְמָה.

Cited, the step is `disputed`. Wegner grants both grounds — the word was "a
suitable term to describe Mary in the first century AD" — and denies the
conclusion: it "changed in meaning from 'young woman' to 'virgin'" between the
translator and Matthew (483). Whether that dissent counts is the question the
standards answer differently: under the evidence and tradition standards it is a
critique; under the scriptural standard, a dissent from a step whose grounds are
all Scripture counts only if it rests on Scripture alone, and Wegner's rests on
early Greek usage. `Dispute.Matthew` computes the hearing under each. -/
@[bornOfAVirginDefs]
def matthewLine : Line Claim :=
  { name := "Scripture interprets Scripture: Matthew quotes ἡ παρθένος of Mary"
  , grounds := [ p .matthewQuotesTheGreekVirgin, p .matthewSaysMaryKnewNoMan ]
  , step := matthewReadsTheGreek
  , delivers := p .lxxIsaiahUsesParthenosAsVirgin
  , inference := some (matthewReadingSource .disputed) }

/-- **Luther on "her seed"**: the wording itself signifies a birth with no human
father. Held by Luther and Henry, and, as "a hint", by Akin and Miravalle;
disputed by Leupold, Keil and Lewis. Irenaeus reads the verse of the Virgin's
son, though he does not argue from the wording.

Luther: the seed of other women "might rather be said to have been the seed of
the man. But that which was born from Mary was conceived of the Holy Ghost and
was the true Seed of Mary" (*Luther on the Creation* 298–99). He finds the sense
in the words of Genesis, and holds that Isaiah later "threw some additional
light" on it: "For it was then made certain that this Seed would not be born
from the union of a man and a woman" (298).

The step is rated `disputed`, because readers who grant all three grounds deny
the conclusion. Leupold reads the verse as the promise of the victor — "Both the
ultimate victory and its achievement by the seed of the woman are taught with
unequivocal plainness by this word" (167). Asked whether the expression is "so
phrased in reference to Mary and the virgin birth", he answers "Not primarily,
but at least incidentally", and holds that "the expression used does not
specifically prophesy the virgin birth" (169). Keil grants that the promise
"culminates in Christ", and finds the virgin birth in its fulfilment, "even if
the words had reference first of all to the fact that the woman had been led
astray by the serpent", "even in its apparently casual form" (102). Lewis grants
that "it is normal in Hebrew to describe descendants by the noun zeraʿ" (299);
he doubts the promise reading itself, suggesting it came from "Making the woman
to be the addressee", but argues on grounds that do not need that doubt: "To say
that the passage is messianic does not necessarily imply that it is
virgin-birth messianic" (319). -/
@[bornOfAVirginDefs]
def herSeedLine : Line Claim :=
  { name := "Luther on 'her seed': the wording itself signifies no human father"
  , grounds :=
      [ p .genesis3_15SeedOfTheWoman, p .genesis3_15IsProtoevangelium
      , p .seedReckonedThroughFather ]
  , step := herSeedSignifiesNoFather
  , delivers := p .wordingSignifiesAFatherlessBirth
  , inference := some
      { primary := .work lutherOnTheCreation (.pages 298 299)
      , supporting :=
          [ .work henryCommentary (.adLoc Scripture.genesis3_15)
          , .work leupoldGenesis (.pages 167 169)
          , .work keilDelitzschPentateuch (.page 102)
          , .work lewisWomansSeed (.page 319) ]
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- **Leupold on "her seed"**: the wording names the woman's posterity, and names
the woman because she was deceived; it does not itself signify a birth with no
human father. Held by Leupold and Keil, whose two grounds Calvin gives too;
disputed by Irenaeus and Henry.

Leupold: "the expression used does not specifically prophesy the virgin birth,
but it coincides and agrees with it under divine providence. For it is not to be
forgotten that the expression 'her seed' in its first meaning is a collective
noun and includes all who are enrolled in the struggle against Satan, without
being themselves virgin born" (169).

The step is rated `disputed`. Irenaeus grants both grounds. The enmity is kept
up between the serpent and the woman's seed "until the seed did come appointed
to tread down his head" (*Against Heresies* III.23.7), and "it was by means of a
woman that he got the advantage over man at first" (V.21.1); yet he reads the
verse as preaching "He who should be born of a woman, [namely] from the Virgin"
(V.21.1), though without arguing from its wording.
Henry gives the woman's name the same reason — "because she it was whom the
devil had beguiled" — and still reads the seed as "of a woman only, of a
virgin". -/
@[bornOfAVirginDefs]
def posterityLine : Line Claim :=
  { name := "Leupold on 'her seed': her posterity, named for the deception"
  , grounds :=
      [ p .genesis3_15SeedOfTheWoman, p .seedIsHerPosterityFirst
      , p .womanNamedForTheDeception ]
  , step := posterityExplainsTheWording
  , delivers := notP .wordingSignifiesAFatherlessBirth
  , inference := some
      { primary := .work leupoldGenesis (.page 169)
      , supporting :=
          [ .work keilDelitzschPentateuch (.pages 101 102)
          , .work calvinGenesis (.page 170)
          , .work irenaeusAgainstHeresies (.sectionRef "III.23.7")
          , .work irenaeusAgainstHeresies (.sectionRef "V.21.1")
          , .work henryCommentary (.adLoc Scripture.genesis3_15) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- **Lewis on "her seed"**: Genesis speaks of a woman's seed in ordinary births
too, so the wording at 3:15 does not by itself signify a birth with no human
father. Held by Lewis; disputed by Akin.

Lewis: "Had it been observed across history that Hagar's descendants whose
ancestral father is Abraham are also projected with a feminine possessive suffix
attached to zeraʿ (Gen 16:10), as also are Rebekah's descendants whose ancestral
father is Isaac (24:60), the treatment of Gen 3:15 would likely have been
different" (299–300). "A look at texts about Hagar and Rebekah in Genesis could
have safeguarded interpreters from the whole misguided exegetical effort" (319).

The step is rated `disputed`, on one reader. Jimmy Akin, a Catholic
apologist, does not discuss Hagar or Rebekah, but grants the point Lewis draws
from them, that a woman's seed "is not outside the bounds of Hebrew expression",
and still calls the wording "odd", and agrees with the "many" who have "rightly
seen" it as "a hint of the Virgin Birth". A hint is less than a sign, and whether
it denies Lewis's conclusion is arguable; it is the only dissent found. -/
@[bornOfAVirginDefs]
def idiomLine : Line Claim :=
  { name := "Lewis on 'her seed': Genesis says it of Hagar and Rebekah too"
  , grounds := [ p .genesis3_15SeedOfTheWoman, p .womansSeedSaidOfOrdinaryBirths ]
  , step := ordinaryBirthsAnswerTheWording
  , delivers := notP .wordingSignifiesAFatherlessBirth
  , inference := some
      { primary := .work lewisWomansSeed (.pages 299 300)
      , supporting := [.work lewisWomansSeed (.page 319), .work akinWomanSeedSerpent .whole]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- **The Greek's "he"**: the translator of Genesis read the woman's seed as one
person. Held by Collins, and by Martin as Collins quotes him; Collins calls the
reading "generally acknowledged" (141). Rated `disputed`, on Philo, the earliest
known reader of this Greek, who grants that it says "he" and reads it of the
mind, a "barbarism" correct in meaning (*Allegorical Interpretation* III.188).
Lewis leaves it open: the masculine "could be an oversight", and "it is possible
that the translator reveals a messianic understanding" (300). What it does not
reach in any case is whether that person has a human father
(`Results.Genesis`). -/
@[bornOfAVirginDefs]
def greekHeLine : Line Claim :=
  { name := "The Greek's 'he': the woman's seed read as one person"
  , grounds := [ p .lxxCallsTheSeedHe ]
  , step := heReadsOneDescendant
  , delivers := p .lxxReadsOneDescendant
  , inference := some
      { primary := .work collinsSyntacticalNote (.page 145)
      , supporting :=
          [ .work collinsSyntacticalNote (.page 144), .work martinEarliestMessianic .whole
          , .work philoAllegoricalInterpretation (.sectionRef "III.188") ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-! #### The fulfilment of Genesis 3:15, and the critical reading

The strands above ask what the wording of Genesis 3:15 says. The reader's next
question runs the other way: the Gospel tells of one who was born of a woman,
was struck, and destroyed the devil. Does that fulfil the promise, and does the
fulfilment confirm that it was a promise? -/

/-- **The fulfilment.** Each term of Genesis 3:15 met, as the New Testament names
it: the woman's seed in the Son "made of a woman"; the serpent in "that old
serpent, called the Devil"; its head crushed when the Son destroys the devil
"through death"; his heel struck in his death, and the wound not the end of him
in his rising. So in Jesus the promise is fulfilled. -/
@[bornOfAVirginDefs]
def termsMetInJesus : Formula Claim :=
  ⋀ [ p .genesis3_15SeedOfTheWoman, p .sonMadeOfAWoman, p .serpentNamedTheDevil
    , p .devilDestroyedThroughDeath, p .christDiedAndRose ]
  ➝ p .jesusFulfilsThePromise

/-- **The fulfilment confirms the promise.** If in Jesus each term of Genesis
3:15 is met, the verse is a promise of him: the protoevangelium. -/
@[bornOfAVirginDefs]
def fulfilmentConfirmsThePromise : Formula Claim :=
  p .jesusFulfilsThePromise ➝ p .genesis3_15IsProtoevangelium

/-- **Of the woman alone.** If the promise is fulfilled in Jesus, and Jesus was
conceived of a virgin, the seed in whom it is fulfilled had no human father. -/
@[bornOfAVirginDefs]
def fulfilledInOneVirginBorn : Formula Claim :=
  ⋀ [ p .jesusFulfilsThePromise, p .maryConceivedAsVirgin ] ➝ p .seedWasOfTheWomanAlone

/-- **Westermann's denial.** "Her seed" is a line of descendants, and the verse is
a punishment oracle on the serpent; such a form has no promise or prophecy, "even
as its secondary meaning", so the verse is not the protoevangelium. -/
@[bornOfAVirginDefs]
def formExcludesAPromise : Formula Claim :=
  ⋀ [ p .seedIsLineNotIndividual, p .verseIsACurseOnTheSerpent ]
  ➝ notP .genesis3_15IsProtoevangelium

/-- **The scene read whole.** The serpent speaks and twists God's command, as no
animal does of itself; it is the instrument of an evil power; the blow falls on
the serpent itself, "your head"; and God himself sets the enmity. So the
sentence on the serpent is God's promise of victory over that power: the
protoevangelium. -/
@[bornOfAVirginDefs]
def sceneMakesItAPromise : Formula Claim :=
  ⋀ [ p .serpentTwistsTheCommand, p .serpentIsTheInstrumentOfAPower
    , p .strikerIsSingular, p .godSetsTheEnmity ]
  ➝ p .genesis3_15IsProtoevangelium

/-- **The syntax of the striker.** זֶרַע with singular verbs and pronouns denotes
one descendant elsewhere; at 3:15b the striker is singular "he", against the
serpent's own head; and the Greek translator read one person. So "her seed" at
3:15 is not only a line of descendants: the one who strikes is one of them. -/
@[bornOfAVirginDefs]
def singularSyntaxNamesOne : Formula Claim :=
  ⋀ [ p .seedUsedOfOneDescendant, p .strikerIsSingular, p .lxxReadsOneDescendant ]
  ➝ notP .seedIsLineNotIndividual

/-- The citation for the fulfilment's step, at a confidence: the readers who
argue it, and Westermann, who denies it. -/
@[bornOfAVirginDefs]
def fulfilmentSource (c : Confidence) : Source :=
  { primary := .work irenaeusAgainstHeresies (.sectionRef "III.23.7")
  , supporting :=
      [ .work irenaeusAgainstHeresies (.sectionRef "IV.40.3")
      , .work hamiltonSkullCrushingSeed (.pageList [42, 53])
      , .work keilDelitzschPentateuch (.page 102)
      , .work leupoldGenesis (.page 170)
      , .work calvinGenesis (.pages 170 171)
      , .work westermannGenesis (.pages 259 261) ]
  , tradition := .christianTypological
  , confidence := c }

/-- **The fulfilment of Genesis 3:15**, read from Scripture: every term of the
promise is met in Jesus, as the New Testament itself names it.

- **The woman's seed**: God sent his Son, "made of a woman" (Galatians 4:4).
- **The serpent**: "that old serpent, called the Devil, and Satan" (Revelation
  12:9; 20:2).
- **Its head crushed**: the Son shared flesh and blood "that through death he
  might destroy him that had the power of death, that is, the devil" (Hebrews
  2:14); he "was manifested, that he might destroy the works of the devil" (1
  John 3:8).
- **His heel struck**: he died, and rose the third day (1 Corinthians 15:3–4),
  a wound and not the end of him.

Irenaeus reads it so: the seed "appointed to tread down his head — which was born
of Mary", against "that old serpent" (*Against Heresies* III.23.7), and the Lord
"summed up in Himself this enmity, when He was made man from a woman, and trod
upon his head" (IV.40.3). Hamilton: the one "born of woman (i.e., her seed, Gal
4:4) who 'nullified the one who has the power of death, that is, the devil'
(Heb 2:14)—one might say he crushed the serpent's head" (53 n. 89). Keil: "In
this sense Christ is the seed of the woman, who tramples Satan under His feet,
not as an individual, but as the head" (102), with Romans 16:20 and 1 John 3:8.
Leupold, of Christ's temptation and the cross: "the first crushing defeat that
the seed of the woman administered … On the cross this victory was sealed"
(170).

**What the conclusion says, and what it does not.** That in Jesus the promise is
fulfilled: struck at the heel, he crushes the serpent's head. Calvin, Keil and
Leupold each deny that "her seed" means Christ alone — Calvin finds the word
"too violently distorted" by those who take it so, "for who will concede that a
collective noun is to be understood of one man only?" — and each holds the
conclusion as worded: "we must necessarily come to one head" (Calvin 170–71).

**The texts it rests on, and how they are linked.** Revelation's "that old
serpent" names the serpent of the garden. Romans 16:20, "the God of peace shall
bruise Satan under your feet shortly", is not counted: it is an allusion, and a
disputed one, with Calvin (171), Keil (102) and Hamilton (42) for it, and Lewis
("one possible allusion", 303) and Collins (147 n. 24, "if Paul was alluding to
this text at all") doubting it. Galatians 4:4 is cited for what it says, that
the Son was made of a woman; whether Paul alludes to Genesis there is disputed
too (`sonMadeOfAWoman`).

**Its rating.** `disputed`, on Westermann. He grants what every ground reads —
none of them says the New Testament *quotes* Genesis 3:15 — and denies that the
verse promises anyone, "even as its secondary meaning" (260), adding that
"suggestions of a messianic interpretation are found in late Judaism, but not in
the New Testament" (261). His reasons are the collective "seed" and the form of
the verse (259–60): philology and form criticism, not a reading of Hebrews,
1 John or Revelation. Lewis, who holds that "The NT never speaks of Christ as
the one who tramples the serpent" (303), denies that Scripture makes the link
but not the conclusion, and is not counted. -/
@[bornOfAVirginDefs]
def fulfilmentLine : Line Claim :=
  { name := "The fulfilment of Genesis 3:15: struck at the heel, he crushes the serpent's head"
  , grounds :=
      [ p .genesis3_15SeedOfTheWoman, p .sonMadeOfAWoman, p .serpentNamedTheDevil
      , p .devilDestroyedThroughDeath, p .christDiedAndRose ]
  , step := termsMetInJesus
  , delivers := p .jesusFulfilsThePromise
  , inference := some (fulfilmentSource .disputed) }

/-- The citation for the step from the fulfilment to the promise, at a
confidence: the readers who grant that Genesis 3:15 is fulfilled in Christ and
call it, for that, the first promise of the gospel. -/
@[bornOfAVirginDefs]
def confirmationSource (c : Confidence) : Source :=
  { primary := .work leupoldGenesis (.page 167)
  , supporting :=
      [ .work keilDelitzschPentateuch (.page 102)
      , .work calvinGenesis (.pages 170 171)
      , .work collinsSyntacticalNote (.page 146)
      , .work hamiltonSkullCrushingSeed (.page 31)
      , .work irenaeusAgainstHeresies (.sectionRef "IV.40.3") ]
  , tradition := .christianTypological
  , confidence := c }

/-- **The fulfilment confirms the promise.** If in Jesus each term of the verse
is met, the verse was a promise of him: the protoevangelium. This is not a
deduction from Genesis alone. Reasoning "if the verse promised the Messiah, he
would crush the serpent and be struck; Jesus did; so it promised him" would
affirm the consequent. It is a step of its own: a promise whose every term is
met in one person, as Scripture names them, is a promise of that person.

Rated `plausible`. No reader found grants that Jesus fulfils the verse and
denies that it is a promise: everyone found who denies the promise, Westermann
among them, denies the fulfilment too, and that dissent belongs to the fulfilment's
step and to the claim that the verse is the protoevangelium. Everyone who grants
the fulfilment calls the verse a promise: Leupold, who finds "the ultimate
victory and its achievement by the seed of the woman … taught with unequivocal
plainness" (167); Keil (102); Calvin (170–71); Collins, for whom the verse,
read from the end, is God's threat "of an individual who will engage the snake
in combat and win" (146); Hamilton, for whom "God's first act of judgment in the
Bible is accompanied by his first promise of salvation" (31). Rated no higher,
because the step adds little to what its ground already says: to fulfil a
promise there must have been one. -/
@[bornOfAVirginDefs]
def confirmationLine : Line Claim :=
  { name := "The fulfilment confirms the promise: Genesis 3:15 is the protoevangelium"
  , grounds := [ p .jesusFulfilsThePromise ]
  , step := fulfilmentConfirmsThePromise
  , delivers := p .genesis3_15IsProtoevangelium
  , inference := some (confirmationSource .plausible) }

/-- **Of the woman alone.** Granted that the promise is fulfilled in Jesus, and
that Mary conceived him as a virgin, the seed in whom it is fulfilled had no
human father. Irenaeus joins the two: "He who should be born of a woman,
[namely] from the Virgin … was preached as keeping watch for the head of the
serpent" (V.21.1).

The step only joins its grounds, and anyone who grants both grants it, so it is
rated `consensus`. What it rests on is its grounds, and both are contested: the
fulfilment on Westermann, the virginal conception on the historian this
argument cites. It reads the fact of the birth back into the promise; it does
not find the birth in the wording, which is Luther's claim and is weighed
apart (`Results.Genesis`). -/
@[bornOfAVirginDefs]
def aloneLine : Line Claim :=
  { name := "The seed of the woman alone: the promise fulfilled in one born of a virgin"
  , grounds := [ p .jesusFulfilsThePromise, p .maryConceivedAsVirgin ]
  , step := fulfilledInOneVirginBorn
  , delivers := p .seedWasOfTheWomanAlone
  , inference := some
      { primary := .work irenaeusAgainstHeresies (.sectionRef "V.21.1")
      , tradition := .christianTypological
      , confidence := .consensus } }

/-- **Westermann's denial**: Genesis 3:15 is no promise. "The parallelism makes
it clear that 'seed' refers to a line of descendants and not to an individual"
(259), and the verse is a punishment oracle on the serpent: "It is not possible
that such a form has either promise or prophecy as its primary or even as its
secondary meaning" (260). Encoded first, as the rival to the fulfilment.

Its grounds are philology and form criticism, and so is its step: none is a
reading of another text of Scripture. Its first ground is contested in its own
right (`seedIsLineNotIndividual`, and `syntaxLine` against it).

Rated `disputed`. Calvin grants both grounds — the seed is "the posterity of the
woman generally", for "who will concede that a collective noun is to be
understood of one man only?" (170), and the verse is the serpent's sentence —
and denies the conclusion: the promise is in the curse, and "we must necessarily
come to one head" (171). Keil, who reads the seed as "the human race" and Christ
"not as an individual, but as the head" (101–2), denies it too. -/
@[bornOfAVirginDefs]
def westermannLine : Line Claim :=
  { name := "Westermann: a punishment oracle on a line of descendants, and no promise"
  , grounds := [ p .seedIsLineNotIndividual, p .verseIsACurseOnTheSerpent ]
  , step := formExcludesAPromise
  , delivers := notP .genesis3_15IsProtoevangelium
  , inference := some
      { primary := .work westermannGenesis (.pages 259 261)
      , supporting :=
          [ .work calvinGenesis (.pages 170 171)
          , .work keilDelitzschPentateuch (.page 102) ]
      , tradition := .criticalScholarship
      , confidence := .disputed } }

/-- **The scene read whole**, from the section and not the word alone: what
Genesis 3 says of the serpent, of whom the blow falls on, and of who sets the
enmity.

- **The serpent speaks, and knows the command.** It gives back God's word of
  2:17 twisted, "Ye shall not surely die" (3:4). Collins: "the snake's wording of
  v. 4 reflects knowledge of 2:17", and "animals do not have faculty of speech in
  Bible, hence there is some intervention here" (146 n. 21).
- **It is the instrument of an evil power.** Delitzsch, as Collins quotes him:
  "an animal not speaking of its own accord, but as made the instrument of itself
  by the evil principle". Woudstra: "There is a diabolical subtlety in the
  serpent's suggestions which points to a sinister background to his words"
  (197). This ground is `disputed` (`serpentIsTheInstrumentOfAPower`).
- **The blow falls on the serpent itself**: "it is the head of the serpent, not
  that of his zeraʿ, which is in view here" (Woudstra 199).
- **God sets the enmity**: "a tremendous initiative for good, unexpected and
  unmerited" (Woudstra 203).

So the sentence on the serpent is a promise of victory over the power behind it.
Collins: "the referent of the second person pronoun would actually be the dark
power behind the snake" (146–47 n. 21), and "the 'promise' for the humans is an
implicature of the punishment on the snake" (147 n. 22). Keil: "This foe is
Satan, who incessantly opposes the seed of the woman and bruises its heel, but
is eventually to be trodden under its feet" (101–2).

**Its rating.** `plausible`. Woudstra grants every ground and does not deny the
conclusion: though "this passage does not explicitly predict ultimate victory of
the woman's seed", "the One who set the enmity might also be regarded as
implicitly guaranteeing the ultimate success of those who are on his side", and
"the term 'protevangelium' may be rightly used to describe it" (203). Westermann,
who denies the conclusion, denies that the serpent is more than an animal (261),
and that dissent belongs to the ground. Von Rad, as Woudstra quotes him, denies
a protevangelium from "the sense of the passage" and the collective "seed"
(194); he is not shown to grant the grounds. Rated no higher, because the step
reads a promise out of a curse, which Collins calls "an implicature" and
Woudstra "implicit".

None of this is the reading of the readers before Christ: Jubilees, Philo and
Josephus read the serpent as an animal or an emblem, and none of them reads the
verse as a promise. It is an exegesis of the section, from its own words. -/
@[bornOfAVirginDefs]
def sceneLine : Line Claim :=
  { name := "The scene read whole: God's sentence on the serpent's power"
  , grounds :=
      [ p .serpentTwistsTheCommand, p .serpentIsTheInstrumentOfAPower
      , p .strikerIsSingular, p .godSetsTheEnmity ]
  , step := sceneMakesItAPromise
  , delivers := p .genesis3_15IsProtoevangelium
  , inference := some
      { primary := .work collinsSyntacticalNote (.pages 146 147)
      , supporting :=
          [ .work woudstraRecentTranslations (.pageList [197, 199, 203])
          , .work keilDelitzschPentateuch (.pages 101 102)
          , .work westermannGenesis (.page 261) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .plausible } }

/-- **The syntax of the striker**, against Westermann's "a line of descendants
and not an individual". Collins: when זֶרַע "denotes a specific descendant, it
appears with singular verb inflections, adjectives, and pronouns" (144), and "the
singular pronoun hûʾ in Genesis 3:15 is quite consistent with the pattern where a
single individual is in view"; "we might wonder if the singular hûʾ in Genesis
3:15 is used precisely in order to make it plain that an individual is being
promised" (145). It is "he" who strikes "you", the serpent itself, not its seed
(146 n. 21). The Greek translator read one person (`lxxReadsOneDescendant`).
Alexander: the seed "must be understood as referring to a single individual and
not numerous descendants" (363); Leupold (166–68) and Hamilton (32) agree.

What it concludes is worded as they hold it: "her seed" at 3:15 is not only a
line of descendants, for the one who strikes is one of them, whether or not 15a
also names her posterity. Collins allows the collective too, the Messiah "as the
(primary) seed, and his followers as 'seed' by virtue of their relation to him"
(148 n. 24).

Paul reads the singular "seed" of the promise to Abraham as one person: "He
saith not, And to seeds, as of many; but as of one, And to thy seed, which is
Christ" (Galatians 3:16). That is a precedent for reading the word of one, not
a reading of Genesis 3:15, and no reader found takes it as one; Calvin uses it so
("So Paul, from the seed of Abraham, leads us to Christ", 171). It is not counted
as a ground.

Rated `disputed`. Keil grants the first two grounds — "the posterity of a man may
consist of a whole tribe or of one son only", and the victory is "over the
serpent itself" — and denies that "by the seed of the woman we are to understand
one solitary person, one individual only" (101). Collins himself claims no more
than consistency, from "a fairly low level of integration" (145–46), and
Alexander notes that the same singular syntax is usually read collectively at
Genesis 22:17–18a and 24:60 (364). -/
@[bornOfAVirginDefs]
def syntaxLine : Line Claim :=
  { name := "The syntax of the striker: 'he' who strikes is one descendant"
  , grounds := [ p .seedUsedOfOneDescendant, p .strikerIsSingular, p .lxxReadsOneDescendant ]
  , step := singularSyntaxNamesOne
  , delivers := notP .seedIsLineNotIndividual
  , inference := some
      { primary := .work collinsSyntacticalNote (.pages 144 146)
      , supporting :=
          [ .work alexanderFurtherObservations (.pageList [363, 364])
          , .work leupoldGenesis (.pages 166 168)
          , .work hamiltonSkullCrushingSeed (.page 32)
          , .work keilDelitzschPentateuch (.page 101)
          , .work calvinGenesis (.page 171) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- **The laws' sense.** The high priest's παρθένος is set against the widow, the
woman put away, the defiled woman and the harlot, and the bride without τὰ
παρθένια dies for playing the harlot; so in these laws παρθένος is used in the
sense "virgin". -/
@[bornOfAVirginDefs]
def lawsFixTheSense : Formula Claim :=
  ⋀ [ p .priestMarriesAParthenos, p .partheniaProveTheBride ] ➝ p .lawsUseParthenosAsVirgin

/-- The citation for the laws' step, at a confidence: Bratcher, the lexica on
τὰ παρθένια, and Miller, who denies the step. -/
@[bornOfAVirginDefs]
def lawsSource (c : Confidence) : Source :=
  { primary := .work bratcherStudyOfIsaiah (.page 113)
  , supporting :=
      [ .work bratcherStudyOfIsaiah (.page 102)
      , .work liddellScottJones (.page 1339)
      , .work muraokaLexiconSeptuagint (.page 535)
      , .work lustLexiconSeptuagint (.sv "παρθένια")
      , .work millerBornDivine .whole
      , .work rhodeaDidMatthewConceive (.page 67) ]
  , tradition := .christianHistoricalGrammatical
  , confidence := c }

/-- **The case from the laws.** Bratcher's, from the Greek of Leviticus 21 and
Deuteronomy 22 (102, 113): two laws of the Greek Pentateuch, the corpus Wegner
takes Genesis 34:3 from, in which virginity is what the law turns on. The laws
are in the translators' own Greek, and they are not uses of the word *of* a
virgin, which would show nothing of its sense; the passages it rests on are
where the sense is the point (`lawsUseParthenosAsVirgin`).

It concludes nothing about Isaiah 7:14. What it shows is that "virgin" was
already a sense of παρθένος in the Septuagint's Greek, which is what Wegner
denies. The step from the two passages to the Septuagint's usage is not a step
of the argument: it is what a usage "as a whole" means
(`Testimony.Ontology.Usage`), and the meanings join the laws' sense to Rico and
Gentry's claim and against Wegner's (`Meanings.BornOfAVirgin.joins`).

The step is rated `disputed`, on one reader. Robert J. Miller grants what the
laws require: virginity matters "in the law that priests can marry only women
who are virgins (Lev 21:13-14)", and the bride of Deuteronomy 22:13–21 is
charged "with not being a virgin at the time of their marriage". But "that has
to be inferred from the context": "Neither word means virgin", and "As in other
Greek literature, parthenos in the Septuagint did not by itself connote what we
mean by virginity", for where virginity matters the Greek adds "a parthenos who
has not known a man" (Genesis 24:16) (*Born Divine*).

Miller is kept, as every cited reader is, and the page shows where his reading
breaks. He says four things of the Greek. One is answered by a reading he does
not take up, one is not answered here, and two do not hold of it.

- **Genesis 34:3**: "this term refers to a rape victim after she has been
  attacked". The Greek calls Dinah a παρθένος in the verse after Shechem lies
  with her; that the noun describes her as she then was is Miller's premise,
  not the text's. Rico and Gentry explain the verse as an archaism of the Greek
  Pentateuch; the status reading reads it under the law of the seduced
  παρθένος, as the name of the standing Shechem took (`dinahLine`).
- **Genesis 24:16**: where virginity matters, the Greek adds "a parthenos who
  has not known a man". The clause is the Hebrew's own, וְאִישׁ לֹא יְדָעָהּ, and the
  Greek renders it. What it shows about either word, the page does not settle.
- **A young widow**: "Lament like a parthenos dressed in sackcloth for the
  husband of her youth (Joel 1:8)". The Greek of Joel 1:8 calls the woman
  νύμφην, a bride; its παρθεν- word, τὸν παρθενικόν, is of the husband (read
  from Rahlfs's text).
- **The translators "consistently used it to translate the Hebrew almah"**. They
  used it for עַלְמָה twice, at Genesis 24:43 and Isaiah 7:14, and elsewhere wrote
  νεᾶνις, as Rhodea, who holds Wegner's view, notes (67 and n. 34); the word
  they used consistently for was בְּתוּלָה (Bratcher 112–13).

And he does not take up τὰ παρθένια, the abstract noun by which Walton's own
test would fix the sense. The step is cited `disputed` here, on him: it is the
step's floor, and the dispute over the Septuagint weighs it there. What its
register computes is another matter (`Dispute.Miller`). Evidence a text refutes
is struck before his dissent is checked, and the Greek of Joel 1:8 refutes his
young widow; struck of it, his dissent still denies the step through Genesis
34:3, and is a credible critique under the evidence and tradition standards.
But his case from Genesis 34:3 cannot be defended in the dispute over the
Septuagint: the status reading defeats it. So his dissent is overruled, and the
step stands at the `wellSupported` its support is cited at. -/
@[bornOfAVirginDefs]
def lawsLine : Line Claim :=
  { name := "The laws of the Greek Pentateuch: παρθένος in the sense 'virgin'"
  , grounds := [ p .priestMarriesAParthenos, p .partheniaProveTheBride ]
  , step := lawsFixTheSense
  , delivers := p .lawsUseParthenosAsVirgin
  , inference := some (lawsSource .disputed) }

/-- **The law's name for Dinah.** The law of the seduced woman calls her a
παρθένος after the man has lain with her, and sets what he owes by "the
bride-price of virgins"; Genesis 34 tells Shechem's act in the words of that law
and its neighbours. So when the Greek calls Dinah "the παρθένος" at 34:3, it
names her by the standing he took, in the sense "virgin". -/
@[bornOfAVirginDefs]
def seductionLawNamesDinah : Formula Claim :=
  ⋀ [ p .seductionLawPricesAParthenos, p .shechemActsUnderTheLaw ]
  ➝ p .dinahIsTheLawsParthenos

/-- **The status reading of Genesis 34:3.** Wegner's case rests on one verse:
after Shechem "lay with her and humbled her" (34:2), the Greek says he "loved the
παρθένος, and spoke to her according to the mind of the παρθένος" (34:3). He
reads the word as said of her as she then was, a woman no longer a virgin, so
that it cannot mean "virgin". This line reads it the other way: as the name of
the standing Shechem took from her. A noun that names a woman says who she is in
the story, not what she is at the moment of the clause: a noun phrase is read at
a time of its own, which the context gives, not at its verb's (Enç 1986), as
Scripture names Rahab "the harlot" long after Jericho (Hebrews 11:31, James
2:25) and Matthew "the tax collector" after his call (Matthew 10:3). The order
of 34:2 and 34:3 puts Shechem's love after his act; it does not put the noun's
description there.

The law does exactly this. In the Greek Exodus a man who "deceives a παρθένος
not betrothed and lies with her" shall endow her as his wife, or, if her father
refuses, pay "the bride-price of virgins" (22:15–16). The woman he has lain with
is still the law's παρθένος, and what he owes is a virgin's price. Genesis 34
tells Shechem's act in that law's words and its neighbours': he "humbled" her
(34:2), as the man who seizes a virgin has "humbled" her (Deuteronomy 22:29);
his deed was "folly in Israel" (34:7, in the Hebrew), as the harlotry of a bride
without the tokens of virginity is (Deuteronomy 22:21); and he offers the
bride-price (34:12) that Exodus requires. So the narrative treats Dinah as the
law's violated virgin. That is the use of the word the verse shows, and on that
reading it is no evidence that παρθένος could mean a woman who is not a virgin.

Frymer-Kensky reads the law and the story the same way, from the Hebrew. The
lover "pays the mohar habbetulot even if the father refuses to allow him to
marry her", a price a seduced girl "would no longer command" (80); and she
follows the Dinah story with the law of "Intercourse with an Unmarried Girl
(Exodus 22.15-16 and Deuteronomy 22.28-29)", under which the father "can take the
'virgin's brideprice' from the lover" (91). She hedges the price in a note: it
"might simply mean the appropriate brideprice for young girls" (80 n. 3). She
does not discuss the Greek of 34:3.

**What it does not settle.** The Hebrew of 34:3 has נַעֲרָה, "girl", and the
translator of Genesis renders that word with παρθένος elsewhere, of Rebekah
(24:14, 16, 55), and with παῖς (24:28, 57). At 34:4 and 34:12, where marriage
and the bride-price are in view, he writes παῖς for Dinah, not παρθένος. Rico
and Gentry read 34:3 as the older, broader usage, an archaism of the Greek
Pentateuch, while the Septuagint's Greek at large means "virgin" by the word
(18, 21). Bratcher finds 34:3 "surprising", since Dinah "was no longer,
therefore, a 'virgin' in the technical sense of the word" (113). The Greek
Deuteronomy does not tell either way: its translator writes νεᾶνις for נַעֲרָה
through chapter 22, of the virgin wrongly accused (22:19) as of the woman seized
(22:29), so his change of word follows the Hebrew, not the woman's state.

**Its rating.** `plausible`. A step is `disputed` when a cited reader grants its
grounds and denies its conclusion, and none has been found who does. Wegner,
Rhodea, Meade, Rico and Gentry and Bratcher read 34:3 as said of a woman who is
not a virgin, but none of them takes up Exodus 22:15–16 or the law's words in
Genesis 34, the second ground. Frymer-Kensky grants that ground, and does not
deny the conclusion; her note doubts what the first ground's law prices, and so
bears on how firmly that law is read, not on this step. No reader has been found
who makes the status reading of the Greek: it is built here from the texts, with
Frymer-Kensky's reading of the Hebrew, and is rated no higher than `plausible`
for that reason. The commentaries on the Greek Genesis that might settle it,
Wevers's *Notes* and Harl's *La Genèse*, have not been read. A reader of them who
has the law before him and still reads 34:3 of a woman no longer a virgin would
make the step `disputed`; and the verdict of `Dispute.Septuagint` turns on this
rating. -/
@[bornOfAVirginDefs]
def dinahLine : Line Claim :=
  { name := "The law's name for Dinah: Genesis 34:3 read under Exodus 22:15–16"
  , grounds := [ p .seductionLawPricesAParthenos, p .shechemActsUnderTheLaw ]
  , step := seductionLawNamesDinah
  , delivers := p .dinahIsTheLawsParthenos
  , inference := some
      { primary := .scripture Testimony.Scripture.seductionLaw
      , supporting :=
          [ .scripture Testimony.Scripture.shechemUnderTheLaw
          , .work frymerKenskyVirginity (.pageList [80, 91])
          , .work encTemporalExpressions (.pages 405 426)
          , .work ricoGentryInfantKing (.pages 18 21)
          , .work bratcherStudyOfIsaiah (.page 113)
          , .work wegnerVirginBirths (.page 483)
          , .work rhodeaDidMatthewConceive (.page 67) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .plausible } }

/-! ### Miller on the laws -/

/-- The citation for Miller's steps, from a use of the word to its sense in the
Septuagint's Greek. `disputed`: Rico and Gentry (18, 21) and Bratcher (113)
grant that Genesis 34:3 calls a woman no longer a virgin a παρθένος, and still
hold that the word means "virgin" in the Septuagint. -/
@[bornOfAVirginDefs]
def millerSource : Source :=
  { primary := .work millerBornDivine .whole
  , supporting :=
      [ .work ricoGentryInfantKing (.pages 18 21)
      , .work bratcherStudyOfIsaiah (.page 113) ]
  , tradition := .criticalScholarship
  , confidence := .disputed }

/-- Joel 1:8 shows that the word does not connote virginity, Miller's way: the
young widow is called a παρθένος. -/
@[bornOfAVirginDefs]
def joelShowsNoConnotation : Formula Claim :=
  p .joelGreekCallsTheWidowParthenos ➝ p .parthenosDoesNotItselfConnoteVirginity

/-- Genesis 34:3 shows the same: the Greek calls Dinah a παρθένος, and the word
describes her as she then was, no longer a virgin. -/
@[bornOfAVirginDefs]
def dinahShowsNoConnotation : Formula Claim :=
  ⋀ [ p .greekCallsDinahParthenos, p .parthenosDescribesDinahAsSheThenWas ]
  ➝ p .parthenosDoesNotItselfConnoteVirginity

/-- So in the laws the virginity "has to be inferred from the context", and the
word is not used in the sense "virgin". -/
@[bornOfAVirginDefs]
def contextNotWordInTheLaws : Formula Claim :=
  p .parthenosDoesNotItselfConnoteVirginity ➝ notP .lawsUseParthenosAsVirgin

/-- **Miller from Joel 1:8**: "Lament like a parthenos dressed in sackcloth for
the husband of her youth", a young widow (*Born Divine*). The Greek does not
read so (`Dispute.Miller`). -/
@[bornOfAVirginDefs]
def millerJoelLine : Line Claim :=
  { name := "Miller: Joel 1:8 calls a young widow a παρθένος"
  , grounds := [ p .joelGreekCallsTheWidowParthenos ]
  , step := joelShowsNoConnotation
  , delivers := p .parthenosDoesNotItselfConnoteVirginity
  , inference := some millerSource }

/-- **Miller from Genesis 34:3**: "In one passage, this term refers to a rape
victim after she has been attacked (Gen 34:3)" (*Born Divine*). Two grounds: what
the Greek reads, and Miller's premise that its noun describes Dinah as she then
was. The second is his, not the text's: the order of the verses puts Shechem's
love after his act, not the noun's description (`dinahLine`). -/
@[bornOfAVirginDefs]
def millerDinahLine : Line Claim :=
  { name := "Miller: Genesis 34:3 calls a woman no longer a virgin a παρθένος"
  , grounds := [ p .greekCallsDinahParthenos, p .parthenosDescribesDinahAsSheThenWas ]
  , step := dinahShowsNoConnotation
  , delivers := p .parthenosDoesNotItselfConnoteVirginity
  , inference := some millerSource }

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
