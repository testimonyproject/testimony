import TestimonyArguments.Attr
import Testimony.Argument
import Testimony.Scripture
import TestimonyArguments.Works

/-!
# TestimonyArguments.BornOfAVirgin.Atoms — the atomic claims, and what cites them

The atoms this argument is built from, the `Source` shapes that recur across
them, the typed intertextual edges between the passages, and the criterion the
argument is about. Everything here is *what the argument is about*; nothing
here asserts anything.

See `TestimonyArguments.BornOfAVirgin` for the dispute this encodes.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

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
  /-- 1QIsaᵃ, copied before Christ, reads הָעַלְמָה at Isaiah 7:14 as the Masoretic
  Text does: the verse has variants, but none at the word, so the dispute over
  it is about its sense and not its text. -/
  | qumranConfirmsAlmah
  /-- The split among the ancient versions shows עַלְמָה does not denote
  virginity. The critical inference from the versions. -/
  | versionalDivergenceRefutesVirginSense
  /-- The Greek Isaiah was translated by Jews, before the coming of Christ. -/
  | lxxIsPreChristian
  /-- In the Greek of the Septuagint, παρθένος means a virgin. **The Septuagint's
  hinge**, and what Rico and Gentry hold of the word wherever it appears in the
  Greek of the Jewish Scriptures. -/
  | parthenosMeansVirgin
  /-- In the Greek of the Septuagint's day, παρθένος meant a young woman of
  marriageable age, and not yet a virgin as such: that sense came later.
  **Wegner's thesis**, and the rival to the hinge above. -/
  | parthenosMeantYoungWoman
  /-- In early Greek literature παρθένος meant a young woman of marriageable age,
  with or without virginity. -/
  | earlyGreekParthenosIsYoungWoman
  /-- The Septuagint calls Dinah a παρθένος after Shechem has lain with her
  (Genesis 34:2–3). -/
  | dinahIsAParthenosAfterShechem
  /-- Wherever else the Greek Isaiah has παρθένος — 23:4, 37:22, 47:1 and 62:5 —
  it renders בְּתוּלָה. -/
  | isaiahUsesParthenosForBetulah
  /-- The Greek Leviticus has the high priest marry a παρθένος, "a woman in her
  virginity" in the Hebrew, and not a widow, a divorced woman, a defiled woman or
  a harlot (21:13–14). -/
  | priestMarriesAParthenos
  /-- In the Greek Deuteronomy, a bride in whom τὰ παρθένια are not found dies for
  playing the harlot (22:13–21). -/
  | partheniaProveTheBride
  /-- In the Greek Pentateuch's laws, παρθένος is used in the sense "virgin".
  **The laws' sense**, and a claim about two passages, not about Isaiah 7:14. -/
  | lawsUseParthenosAsVirgin
  /-- Trypho rejects the Septuagint's "the virgin" at Isaiah 7:14 and reads "the
  young woman" (Justin, *Dialogue* 67 and 71). -/
  | tryphoRejectsParthenos
  /-- Before Christ, a Jewish translator read the woman of Isaiah 7:14 as a
  virgin. **What the Septuagint shows**, if its word means what Rico and Gentry
  say it means. -/
  | lxxReadsAVirgin
  /-- The Septuagint puts the conception in the future: ἐν γαστρὶ ἕξει, "she shall
  be with child". -/
  | lxxPutsTheConceptionInTheFuture
  /-- The translator of Isaiah meant that the woman conceives while still a
  virgin: a conception without a man. -/
  | lxxEnvisagesAVirginalConception
  /-- הָרָה at Isaiah 7:14 is a predicate adjective, so the clause reads "the
  עַלְמָה *is* pregnant". **Wegner's grammatical premise**, and not the contested
  step: Rydelnik parses it the same way. -/
  | harahIsPredicateAdjective
  /-- The עַלְמָה of Isaiah 7:14 is already pregnant at the moment the sign is
  given. -/
  | isaianicAlmahIsAlreadyPregnant
  /-- The pregnancy the sign announces is an ordinary conception. **The step
  the parse does not supply**, and the one Rydelnik denies. -/
  | pregnancyAtTheSignIsOrdinary
  /-- The עַלְמָה of Isaiah 7:14 is not a virgin. Wegner's conclusion about the
  referent, and his ground for the lexical conclusion. -/
  | isaianicAlmahIsNotAVirgin
  /-- What the עַלְמָה of Isaiah 7:14 turns out to be settles what עַלְמָה denotes.
  **Wegner's method**, and the principle Rico and Gentry reject. -/
  | oneReferentSettlesDenotation
  /-- In the other clear עַלְמָה passages Wegner lists — Genesis 24:43 and Song
  6:8 — the women are virgins. Postell's usage reply. -/
  | otherClearAlmahCasesAreVirgins
  /-- The sign given at Isaiah 7:14 must be extraordinary, as the sign offered
  "deep as Sheol or high as heaven" at 7:11 would have been. **The fathers'
  hinge**, and the premise the near-term reply denies. -/
  | signMustBeExtraordinary
  /-- An ordinary conception is nothing extraordinary: it happens to every
  woman who is not barren. -/
  | ordinaryConceptionIsNoMarvel
  /-- Signs elsewhere in Isaiah are ordinary events: the prophet's children are
  "signs and portents" (8:18), and so are his walking stripped (20:3) and a
  harvest of what grows of itself (37:30). -/
  | isaianicSignsAreOrdinaryEvents
  /-- Isaiah 7:16 dates the deliverance by a child's infancy: the land is
  deserted before he knows how to refuse evil and choose good. -/
  | signDatedByAChildsInfancy
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
  /-- Genesis 3:15 says that "her seed" will strike the serpent's head, and the
  serpent its heel. -/
  | genesis3_15SeedOfTheWoman
  /-- Genesis 3:15 is the protoevangelium: the first promise of a redeemer. -/
  | genesis3_15IsProtoevangelium
  /-- Hebrew זֶרַע is ordinarily reckoned through the father: a man's seed is his
  descendants. -/
  | seedReckonedThroughFather
  /-- The seed being named as the woman's marks a birth with no human father.
  **The protoevangelium hinge**, and an ambiguous one: "marks" can mean what the
  wording signified, or what it fits once fulfilled (`Results.Genesis`). -/
  | seedOfTheWomanImpliesNoHumanFather
  /-- The wording "her seed" itself signifies a birth with no human father: read
  in Genesis, it names the seed as the woman's and not a man's. **Luther's
  reading of the hinge.** -/
  | wordingSignifiesAFatherlessBirth
  /-- The wording "her seed" fits a birth with no human father, as the promise
  was fulfilled in Christ. **Leupold's and Keil's reading of the hinge**, which
  they grant. -/
  | wordingFitsAFatherlessBirth
  /-- "Her seed" at Genesis 3:15 is, in the first place, collective: the
  woman's posterity, not one person. -/
  | seedIsHerPosterityFirst
  /-- The seed is called the woman's because the serpent deceived the woman. -/
  | womanNamedForTheDeception
  /-- Genesis speaks of a woman's seed in ordinary births: Hagar's (16:10) and
  Rebekah's (24:60). -/
  | womansSeedSaidOfOrdinaryBirths
  /-- The Greek of Genesis 3:15 calls the woman's seed "he" (αὐτός), though its
  word for seed, σπέρμα, is neuter. -/
  | lxxCallsTheSeedHe
  /-- The Greek translator of Genesis read the woman's seed at 3:15 as one
  person. -/
  | lxxReadsOneDescendant
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
  /-- The sign of Isaiah 7:13–14 is given to the house of David, in the
  plural; the "you" of 7:16 is singular, and is Ahaz. -/
  | signGivenToHouseOfDavid
  /-- Isaiah 8:4 gives Maher-shalal-hash-baz the timetable that 7:16 gives the
  child of 7:14: before he can speak, Damascus and Samaria are despoiled. -/
  | maherShalalHashBazRepeatsTheTimetable
  /-- Micah 5:5–6 sets the ruler from Bethlehem against the Assyrian invasion:
  "when the Assyrian comes into our land". -/
  | micahRulerFacesAssyria
  /-- Micah 5:2 was read messianically in first-century Judaism: the Messiah
  was expected from Bethlehem. -/
  | micahRulerReadMessianically
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

/-! ### Recurring sources

Five works carry this argument, and each carries several atoms at the same
pinpoint with the same confidence. Written out at every atom, the citation was
repeated rather than the claim — and a `Source` differing from its neighbour by
one field is hard to read as deliberate.

These are values, so an atom that cites one of them *with something further*
says so with `{ ... with supporting := ... }`, and the difference is the part a
reader sees. -/

/-- Motyer on Isaiah 7:14: the predictive reading and the lexical premise it
needs, disputed and marked so. -/
def motyerOnIsaiah : Source :=
  { primary := .work motyerIsaiah (.adLoc isaiah7_14)
  , tradition := .christianTypological
  , confidence := .disputed }

/-- Miravalle on Genesis 3:15, in *Meet Your Mother*: the verse is the
"Protoevangelium", "the first reference to Jesus as the future Redeemer of the
world", and to speak of "the 'seed' of a woman rather than the seed of a man" is
"already a hint of Mary's virginal conception of Jesus". His word is "hint": a
remark in passing, not an argument from the Hebrew.

The protoevangelium strand rests on him and on Luther, the reader who argues
from the wording (`herSeedLine`); the Michean strand rests on Miravalle alone
(`miravalleOnMicah`). Every atom citing this is `disputed`. -/
def miravalleOnGenesis : Source :=
  { primary := .work miravalleMeetYourMother .whole
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- Miravalle on Micah 5:2–3, in *Introduction to Mary*: the mother "so
specifically designated without a husband" conveys "the same virginal sense as
we see in Isaiah 7:14". The passage is on page 18 of the 1993 printing; the
library's entry is the 2020 printing, whose page could not be checked, so the
book is cited whole. -/
def miravalleOnMicah : Source :=
  { primary := .work miravalleIntroductionToMary .whole
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- Brown's *Birth of the Messiah*, taken whole: the critical case.

`confidence` defaults to `wellSupported`, which is what the critical readings
are. It is passed explicitly where a critical premise is contested: the one
Brown's case *presupposes* rather than argues, and both premises of the
critical denial, each denied by scholars this argument cites. -/
def brownOnBirth (confidence : Confidence := .wellSupported) : Source :=
  { primary := .work brownBirthMessiah .whole
  , tradition := .criticalScholarship
  , confidence := confidence }

/-- Postell on the compositional reading, at a given pinpoint. The pinpoint
matters here in a way it does not for the others: the textual observations and
the interpretive principle come from different pages and carry different
confidence. -/
def postellOnIsaiah (l : Locus) (confidence : Confidence) : Source :=
  { primary := .work postellIsaiahMessianic l
  , tradition := .christianHistoricalGrammatical
  , confidence := confidence }

/-- Wegner on the sense of עַלְמָה, at a given pinpoint.

Like `postellOnIsaiah`, the pinpoint carries weight: the grammatical claim is
at 471 and the near-term reconstruction that makes its conclusion bite is at
476–478, and they are not equally secure. Wegner is an evangelical arguing
*against* a virgin-birth prediction here, which is what makes him the module's
strongest lexical rival rather than one more critical voice. -/
def wegnerOnAlmah (l : Locus) (confidence : Confidence) : Source :=
  { primary := .work wegnerVirginBirths l
  , tradition := .christianHistoricalGrammatical
  , confidence := confidence }

/-- France on Matthew 1:23, for what Matthew's quotation intends and what
follows from it. -/
def franceOnMatthew (confidence : Confidence := .wellSupported) : Source :=
  { primary := .work franceMatthew (.adLoc matthew1_23)
  , tradition := .christianHistoricalGrammatical
  , confidence := confidence }

/-! ### Intertextual edges and readings -/

/-- Matthew explicitly quotes Isaiah, via the Septuagint's παρθένος. -/
def quotationEdge : IntertextEdge :=
  { fromPassage := matthew1_23
  , toPassage := isaiah7_14
  , relation := .quotation
  , source := na28Apparatus matthew1_23 }

/-- Genesis 3:15 read as promise rather than quotation. Typed as `.promise`,
not `.prediction`: what Miravalle argues is that the protoevangelium *commits*
to a redeemer born of a woman, and collapsing that into a prediction would beg
the question the Michean and Isaianic strands are also asking. -/
def protoevangeliumEdge : IntertextEdge :=
  { fromPassage := matthew1_23
  , toPassage := genesis3_15
  , relation := .promise
  , source := miravalleOnGenesis }

/-- Micah 5:3's maternal reference, read as a messianic theme rather than a
verbal link — there is no quotation of Micah 5:3 in the birth narratives. -/
def micahMaternalEdge : IntertextEdge :=
  { fromPassage := matthew1_23
  , toPassage := micah5_3
  , relation := .messianicTheme
  , source := miravalleOnMicah }

/-- **Luke's annunciation, read as an allusion to Isaiah 7:14.** Luke never
quotes the verse, but Luke 1:31 is close to its Septuagint wording, and Luke
1:27 and 1:32 bring in the house and the throne of David, as Isaiah 7:13 and
9:6–7 do. Whether that is an allusion is disputed, and both sides are recorded
here: Davies and Allison find an influence from Isaiah 7:14, Fitzmyer rejects
it, as Rhodea reports (71 n. 66). Typed `.allusion`, never `.quotation`: that
is the difference between Luke and Matthew. See `annunciationFormEdge` for the
rival reading of the same wording. -/
def lukeAllusionEdge : IntertextEdge :=
  { fromPassage := luke1_31
  , toPassage := isaiah7_14
  , relation := .allusion
  , source :=
      { primary := .work rhodeaDidMatthewConceive (.page 71)
      , supporting :=
          [.scripture [verseIn .nestleAland28 luke1_31, verseIn .septuagint isaiah7_14]]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- **The rival reading: the wording is the birth-announcement form.** Luke 1:31
is as close to the announcement to Hagar (Gen 16:11) as to Isaiah 7:14, and
Isaiah 7:14 is itself an instance of the form, which Brown and others trace
through Ishmael, Isaac, Samson, John and Jesus (Johnson 270 n. 6; Young 113–14).
On this reading the shared wording is shared form, not dependence — typed
`.thematic`. -/
def annunciationFormEdge : IntertextEdge :=
  { fromPassage := luke1_31
  , toPassage := genesis16_11
  , relation := .thematic
  , source :=
      { primary := .work johnsonSamsonTypeScene (.page 270)
      , supporting :=
          [ .work youngImmanuelProphecy (.pages 113 114)
            -- "there is no proof that Is 7:14 played any major role in
            -- shaping the Lucan account of the virginal conception"
          , .work brownProblemVirginalConception (.page 31) ]
      , tradition := .criticalScholarship
      , confidence := .wellSupported } }

/-- The Christian predictive reading of Isaiah 7:14. Far more contested than
Micah 5:2 — see the module doc. -/
def predictiveReading : Interpretation :=
  { passage := isaiah7_14
  , reading :=
      "Isaiah 7:14 predicts a virgin conceiving and bearing 'Immanuel', " ++
      "fulfilled in the virgin birth of the Messiah"
  , asRelation := some .prediction
  , source := motyerOnIsaiah }

/-- Miravalle's reading of Genesis 3:15: the seed is named as the woman's, and
that is "already a hint" that no man is involved in the conception it
promises. -/
def protoevangeliumReading : Interpretation :=
  { passage := genesis3_15
  , reading :=
      "Genesis 3:15 promises a redeemer born of the woman's seed, the wording " ++
      "hinting at a conception with no human father"
  , asRelation := some .promise
  , source := miravalleOnGenesis }

/-- Miravalle's reading of Micah 5:2–3: the oracle names a mother and no
father for the ruler who comes forth from Bethlehem. -/
def maternalReading : Interpretation :=
  { passage := micah5_3
  , reading :=
      "Micah 5:2–3 names only the woman in labour as bearing the coming " ++
      "ruler, mentioning no father"
  , asRelation := some .messianicTheme
  , source := miravalleOnMicah }

/-- The criterion this argument establishes a candidate must meet. -/
def bornOfAVirgin : FulfillmentCriterion :=
  { name := "born of a virgin", basis := predictiveReading }

end TestimonyArguments.BornOfAVirgin
