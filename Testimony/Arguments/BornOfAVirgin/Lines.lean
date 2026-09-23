import Testimony.Arguments.BornOfAVirgin.Atoms
import Testimony.Logic.Line

/-!
# Arguments.BornOfAVirgin.Lines — the steps, and the lines of reason

Every inference this argument makes, and the four strands they compose into.

Inference steps carry no `confidence` field of their own — a step is a claim
that *these premises license that conclusion*, which is a different kind of
claim from an atom, and the library does not pretend to grade it. Where a step
is contestable even though the atoms it joins are well supported, the docstring
says so; `berryBlocksExclusion` is the clearest case.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony Testimony.Bib Testimony.Logic

/-! ### Inference steps

One per strand, each delivering the same criterion, plus the steps that close
the argument and the steps the rivals need. Keeping them separate is what makes
the load-bearing results possible: a strand can be removed without touching the
others. -/

/-- Isaianic strand: from the predictive reading, the lexical premise and
Matthew's intent, the criterion follows. -/
def toCriterion : Formula Claim :=
  ⋀ [ p .isaiahPredictsVirginBirth, p .almahMeansVirgin
    , p .matthewIntendsFulfilment ] ➝ p .messiahBornOfVirgin

/-- Protoevangelium strand: from Genesis 3:15 read as promise, the patrilineal
idiom, and the inference drawn from its departure, the criterion follows. -/
def genesisToCriterion : Formula Claim :=
  ⋀ [ p .genesis3_15SeedOfTheWoman, p .genesis3_15IsProtoevangelium
    , p .seedReckonedThroughFather, p .seedOfTheWomanImpliesNoHumanFather ] ➝ p .messiahBornOfVirgin

/-- Compositional strand: from Isaiah 7's placement in an eschatologically
framed unit, the principle that placement governs meaning, and the future birth
that follows, the criterion follows.

The weak joint is the last step. Postell's argument delivers a *miraculous*
birth; it is `matthewIntendsFulfilment` that says which miracle. A reader who
grants the composition and stops short of Matthew is entitled to. -/
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
def parityDefeatsNearTermExclusion : Formula Claim :=
  ⋀ [ p .isaiah9And11AreMessianic, p .isaiah9And11ShareTheAssyrianTimeline ]
  ➝ notP .nearTermExcludesMessianicSense

/-- Michean strand: from the maternal-only wording and the inference drawn from
it, the criterion follows. -/
def micahToCriterion : Formula Claim :=
  ⋀ [ p .micah5_3NamesMotherOnly, p .maternalSilenceImpliesNoHumanFather ] ➝ p .messiahBornOfVirgin

/-- Magisterial strand: from papal teaching and the authority granted it, the
criterion follows. Encoded, but deliberately kept out of `christian`. -/
def magisterialToCriterion : Formula Claim :=
  ⋀ [ p .magisteriumTeachesVirginalConception
    , p .magisteriumIsDoctrinallyAuthoritative ] ➝ p .messiahBornOfVirgin

/-- The critical inference, made explicit: granted that Isaiah 7:14 was a sign
to Ahaz, and that such a sign is not also a prediction of a virgin conception,
the predictive reading is denied.

The earlier encoding of this module simply asserted the denial as a premise of
`critical`. That was a weaker rival than the critical case actually is, and it
left nothing for an objection to engage. -/
def criticalExclusion : Formula Claim :=
  ⋀ [ p .isaiahIsNearTermSignToAhaz, p .nearTermExcludesMessianicSense ]
  ➝ notP .isaiahPredictsVirginBirth

/-- Berry's objection: if how the sign was fulfilled in Ahaz's own day is
itself unsettled, the near-term reading is not secure enough to exclude a
further referent.

The step is contestable even though both atoms it joins are `wellSupported` —
an unclear fulfilment is still a fulfilment, and Brown would answer that Isaiah
8:3–4 settles the referent well enough. Inference steps carry no confidence
field of their own, so this is where that is recorded. -/
def berryBlocksExclusion : Formula Claim :=
  p .nearTermFulfilmentIsUnclear ➝ notP .nearTermExcludesMessianicSense

/-- Motyer's inference: the sign of 7:14 is given to the dynasty, and the
timetable that answers Ahaz's crisis passes to Maher-shalal-hash-baz, so the
child of 7:14 is not a near-term sign to Ahaz. "Either we must identify
Maher-shalal-hash-baz with Immanuel, or we must project Immanuel into the
undated future" (Motyer 1970, 124).

This is the contested part of his reply, and it is a step rather than an atom
on purpose, as Berry's and Postell's are: the two atoms it joins are what the
text says, and the inference is what a reader who identifies the two children
denies. Inference steps carry no confidence field; an attack on one always
defeats. -/
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
def toDescriptionFit : Formula Claim :=
  ⋀ [ p .almahDenotesMarriageableYoungWoman, p .virginityCompatibleWithAlmah
    , p .maryWasAnAlmah, p .maryConceivedAsVirgin ] ➝ p .maryFitsIsaianicDescription

/-- ... and if she answers it, the fulfilment claim never needed the lexical
sense in the first place. -/
def descriptionFitDefeatsLexicalDemand : Formula Claim :=
  p .maryFitsIsaianicDescription ➝ notP .lexicalSenseRequiredForFulfilment

/-- The lexical objection in full: עַלְמָה does not denote virginity, Matthew's
claim requires that it does, so the fulfilment claim fails. Stated as the
objector would state it, so that the reply has something real to answer. -/
def lexicalObjection : Formula Claim :=
  ⋀ [ notP .almahMeansVirgin, p .lexicalSenseRequiredForFulfilment ] ➝ notP .jesusSatisfiesCriterion

/-- The versional route to the lexical premise: the Targum and the Three read
the broad term, so the narrow sense is not the word's. -/
def versionalObjection : Formula Claim :=
  ⋀ [ p .targumRendersUlemta, p .theThreeRenderNeanis
    , p .versionalDivergenceRefutesVirginSense ] ➝ notP .almahMeansVirgin

/-- **The tension, dissolved.** If virginity is compatible with עַלְמָה, the
versions are not contradicting one another about the referent at all: the
Septuagint and the Peshitta render with the narrower term because they read the
referent as a virgin, the Targum and the Three render with the broader one, and
both are faithful renderings of a word whose denotation admits both. The
divergence stops being evidence about the sense. -/
def compatibilityDissolvesDivergence : Formula Claim :=
  ⋀ [ p .virginityCompatibleWithAlmah, p .lxxRendersParthenos
    , p .peshittaRendersBtulta ] ➝ notP .versionalDivergenceRefutesVirginSense

/-- From the criterion and the historical claim, the fulfilment follows. -/
def toFulfilment : Formula Claim :=
  ⋀ [p .messiahBornOfVirgin, p .maryConceivedAsVirgin] ➝ p .jesusSatisfiesCriterion

/-! #### Wegner's grammatical objection, and the circle Postell finds in it

The sharpest form of the lexical case. Each link is a step of its own, because
the result worth having is not whether the objection is valid — it is — but
which link carries its weight, and where that link comes from. -/

/-- Wegner's grammatical step: if הָרָה is a predicate adjective, the עַלְמָה of
the sign is pregnant already, at the moment the sign is given. -/
def harahYieldsPresentPregnancy : Formula Claim :=
  p .harahIsPredicateAdjective ➝ p .isaianicAlmahIsAlreadyPregnant

/-- ... and if that pregnancy is an ordinary conception, the woman it describes
is not a virgin.

The second conjunct does all the work, and it is not a grammatical claim.
Rydelnik parses הָרָה exactly as Wegner does and reads the same clause as the
miracle itself — the virgin *is* pregnant — which is available to him precisely
because the parse leaves this open. -/
def ordinaryPregnancyExcludesVirginity : Formula Claim :=
  ⋀ [ p .isaianicAlmahIsAlreadyPregnant, p .pregnancyAtTheSignIsOrdinary ]
  ➝ p .isaianicAlmahIsNotAVirgin

/-- ... and if what the one clear Isaianic referent turns out to be settles what
the word denotes, the lexical conclusion follows. -/
def referentYieldsLexicalConclusion : Formula Claim :=
  ⋀ [ p .isaianicAlmahIsNotAVirgin, p .oneReferentSettlesDenotation ] ➝ notP .almahMeansVirgin

/-- **Where the ordinary pregnancy comes from.** Not from the grammar: from the
near-term reading of the sign, which has the child born within nine months and
the whole oracle discharged by 701 BC.

This is Postell's charge, written as a formula rather than repeated as a
complaint: "because Wegner rejects the messianic interpretation on
grammatical-historical grounds, he assumes that עַלְמָה cannot mean 'virgin' in
Isaiah 7:14" (468 n. 22). -/
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
def lexicalConclusionTellsAgainstPrediction : Formula Claim :=
  ⋀ [ notP .almahMeansVirgin, p .lexicalSenseRequiredForFulfilment ]
  ➝ notP .isaiahPredictsVirginBirth

/-- **Postell's usage parity.** If a single clear referent settled the
denotation, the other clear עַלְמָה passages would settle it in the opposite
direction, since the women there are virgins. So that principle is not
available to the objection: it proves too much, and the wrong way. -/
def usageParityBlocksReferentInference : Formula Claim :=
  p .otherClearAlmahCasesAreVirgins ➝ notP .oneReferentSettlesDenotation

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
def micheanLine : Line Claim :=
  { name := "Michean strand (Micah 5:2–3)"
  , grounds :=
      [ p .micah5_3NamesMotherOnly, p .maternalSilenceImpliesNoHumanFather ]
  , step := micahToCriterion
  , delivers := p .messiahBornOfVirgin }

/-- **The compositional line.** Isaiah 7's placement in an eschatologically
framed unit, the principle that placement governs meaning, and the future birth
that follows. Its hinge is `compositionGovernsMeaning`. -/
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
def wegnerClosingSteps : List (Formula Claim) :=
  [ordinaryPregnancyExcludesVirginity, referentYieldsLexicalConclusion]

/-- **The critical line**: the sign was given to Ahaz, and such a sign is not
also a prediction of a virgin conception, so the predictive reading is denied.

Its grounds are what the two defeaters attack. Berry replaces the second with
`nearTermFulfilmentIsUnclear` plus `berryBlocksExclusion`; parity replaces it
with Isaiah 9 and 11 plus `parityDefeatsNearTermExclusion`. -/
def criticalExclusionLine : Line Claim :=
  { name := "Critical denial of the predictive reading of Isaiah 7:14"
  , grounds :=
      [ p .isaiahIsNearTermSignToAhaz, p .nearTermExcludesMessianicSense ]
  , step := criticalExclusion
  , delivers := notP .isaiahPredictsVirginBirth }

/-! ### The two defeaters, as arguments in their own right

`criticalDenialUnderBerry` and `criticalDenialUnderParity` ask what the critical
line is left with once a reply is in play. The lines below ask something else:
what each reply *concludes*, taken on its own. Written this way a reply is a
position with premises of its own, and so a node that can defeat, and be
defeated by, the line it answers — see `Dispute.lean`. -/

/-- **Berry's objection**, as an argument: the near-term fulfilment is unclear,
so the near-term reading does not exclude the messianic sense. -/
def berryLine : Line Claim :=
  { name := "Berry's objection to the near-term exclusion"
  , grounds := [p .nearTermFulfilmentIsUnclear]
  , step := berryBlocksExclusion
  , delivers := notP .nearTermExcludesMessianicSense }

/-- **Postell's parity argument**, as an argument: Isaiah 9 and 11 are messianic
on the same near-term timeline, so a near-term setting does not exclude the
messianic sense. -/
def postellLine : Line Claim :=
  { name := "Postell's parity argument against the near-term exclusion"
  , grounds :=
      [ p .isaiah9And11AreMessianic, p .isaiah9And11ShareTheAssyrianTimeline ]
  , step := parityDefeatsNearTermExclusion
  , delivers := notP .nearTermExcludesMessianicSense }

/-- **Motyer's reply**, as an argument, with Compton: the sign is given to the
house of David and the near-term timetable passes to Isaiah's son, so Isaiah
7:14 is not a near-term sign to Ahaz. The first reply to deny the critic's
near-term premise rather than its exclusion premise. -/
def motyerLine : Line Claim :=
  { name := "Motyer's reply to the near-term reading"
  , grounds :=
      [ p .signGivenToHouseOfDavid, p .maherShalalHashBazRepeatsTheTimetable ]
  , step := timetablePassesToMaherShalalHashBaz
  , delivers := notP .isaiahIsNearTermSignToAhaz }

/-! ### What the strands share -/

/-- The premises no single strand owns: Mary's conception, and the agreement of
the two birth narratives about it. Every scriptural package needs them and
none of the four strands delivers them. -/
def sharedGrounds : List (Formula Claim) :=
  [ p .maryConceivedAsVirgin, p .independentAttestation ]

/-- The four scriptural strands, in the order the module doc introduces them.
`christian` is exactly these four on shared ground. -/
def scripturalLines : List (Line Claim) :=
  [ isaianicLine, protoevangeliumLine, micheanLine, compositionalLine ]

end Testimony.Arguments.BornOfAVirgin
