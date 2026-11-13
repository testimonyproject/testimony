import TestimonyArguments.Trinity.Atoms
import TestimonyArguments.Works

/-!
# TestimonyArguments.Trinity.Sources — citation and classification for every atom

Every claim must name a source, or the encoding will not build (`cite`). Each
reading is cited to a source that holds it. Each step's rating is cited to a
reader who accepts the claims it starts from (its grounds) and still denies
where it ends, or says that no such reader was found after a search for one.
-/

namespace TestimonyArguments.Trinity

open Testimony

open Testimony Testimony.Bib Testimony.Logic

/-- A text, as Scripture states it. -/
private def text (refs : List ScriptureCitation) : Source :=
  { primary := .scripture refs
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-- LST §3, the passage on the procession. -/
def lstOnTheProcession : Locus := .sectionRef "§3, The Triune God"

/-- Aquinas on whether the Spirit proceeds from the Son. -/
def aquinasOnTheSon : Locus := .sectionRef "I, q. 36, a. 2"

/-- Florence's definition of the procession. -/
def florenceOnTheProcession : Locus := .sectionRef "Florence, Session 6 (1439), Laetentur caeli"

/-! ### Ratings for inference steps -/

/-- **The step from the texts to a relation between the Spirit and the Son is
well supported.** LST draws it: the texts "establish a real relation of the
Spirit to both Father and Son". It was audited for a reader who grants the
texts and denies that the Spirit is related to the Son, and none was found. The
Eastern readers affirm the relation in their own terms. Photius grants that the
Spirit is the "Spirit of His Son" (Galatians 4:6), "because He is in the Son"
and of one substance with him. Staniloae writes that "in the East, it is not
denied that at the origin of the sending of the Spirit by the Son there is a
special eternal relationship between the Son and the Spirit". What they deny is
that the relation is one of origin, and the claim the step delivers does not
say that it is. -/
def onTheRelation : Source :=
  { primary := .work kibbeyLivingSystematicTheology lstOnTheProcession
  , supporting :=
      [ .work photiusMystagogy .whole, .work vischerSpiritOfGod (.page 178)
      , .work aquinasSumma aquinasOnTheSon ]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **The step from John 16:14 is rated `disputed`, conservatively.** Aquinas
holds it (reply to objection 1). The Eastern readers reject its conclusion by
denying a ground: that what the Spirit takes from the Son is his being, and not
what he declares. No reader was sought who grants that ground and still denies
the Filioque, so the step is not rated above the bottom. -/
def onTheReceiving : Source :=
  { primary := .work aquinasSumma aquinasOnTheSon
  , supporting := [.work photiusMystagogy .whole]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **The step from mission to origin is disputed.** Its grounds are that the
Son sends the Spirit, that the Spirit is named for him, and that the sending
rests on an eternal relation of the Spirit to the Son. Three readers grant all
three and deny that the Spirit is from the Son. Moltmann holds that "there must be an
inner-trinitarian basis for the temporal sending of the Spirit through Christ",
and that the Spirit "receives from the Father his own perfect divine existence
(hypostasis), and obtains from the Son his relational form". Bobrinskoy speaks
of the Spirit "resting on the Son from all eternity". Staniloae, following
Gregory of Cyprus: "though the Spirit's manifestation is by the Son, his coming
into existence is not by the Son". Aquinas reaches origin from the relation
because "there cannot be in God any relations opposed to each other, except
relations of origin" (I, q. 36, a. 2). He does not hold that every sending
shows origin: a person sent proceeds from the sender when the sender is
"designated as the principle of the person sent" (I, q. 43, a. 8). -/
def onTheMission : Source :=
  { primary := .work vischerSpiritOfGod (.pages 165 169)
  , supporting :=
      [ .work vischerSpiritOfGod (.page 144), .work vischerSpiritOfGod (.pages 183 184)
      , .work aquinasSumma (.sectionRef "I, q. 43, a. 8") ]
  , tradition := .easternOrthodox
  , confidence := .disputed }

/-- **The step from distinction is well supported, once its unstated premise is
written in.** Aquinas argues that "if He were not from Him, He could in no wise
be personally distinguished from Him", because the persons are distinguished
"only by the relations" and only opposed relations distinguish. It was audited
for a reader who grants that, and that the Son is not from the Spirit, and
still denies the Filioque, and none was found. Its rejecters deny a ground.
Scotus denies that only opposed relations distinguish: a relation, he says,
"distinguishes not only from the opposite relation but also from any disparate
relation" (*Ordinatio* I, d. 11, q. 2), though he holds the Filioque on other
grounds. Gregory of Nazianzus names each person by "the very fact of being
Unbegotten or Begotten, or Proceeding" (*Oration* 31.9), which distinguishes the
Son and the Spirit by their relations to the Father. Neither Scotus nor Gregory
is yet in this library's bibliography, so the rating cites Aquinas alone. -/
def onTheOpposition : Source :=
  { primary := .work aquinasSumma aquinasOnTheSon
  , tradition := .romanCatholic
  , confidence := .wellSupported }

/-- **The Eastern step from John 15:26 is rated `disputed`, conservatively.**
Photius holds it. The Western readers reject its conclusion by denying a
ground: that the verse, naming the Father, names the whole of the Spirit's
source. Augustine asks why the Son said "he proceeds from the Father", and
answers, "so as not to imply, He proceeds not from me" (*Tractates on John*
99.8): he grants the verse and denies that it excludes the Son. The step has
not been audited for a reader who grants that ground and still holds the
Filioque, as the Western step from distinction was; until it is, it stays at
the bottom. -/
def onTheWords : Source :=
  { primary := .work photiusMystagogy .whole
  , supporting := [.work aquinasSumma aquinasOnTheSon]
  , tradition := .easternOrthodox
  , confidence := .disputed }

/-- **The Eastern step from the monarchy is disputed.** Florence denies its
ground as it stands: the Father is "the source and principle of all deity", but
the Spirit "has his essence and his subsistent being from the Father together
with the Son", and the Greek fathers' "through the Son" signifies the Son "as
cause". The Pontifical Council for Promoting Christian Unity (1995) grants the
ground almost word for word, the
Father "the sole Trinitarian Cause (Aitia) or principle (principium) of the Son
and the Holy Spirit", and still confesses the Father, "with the Son, the single
principle from which the Spirit proceeds". It does so by distinguishing two
senses of "proceed": the Greek ἐκπόρευσις, origin from the Father alone, and
the Latin *processio*, which may be from the Son. -/
def onTheMonarchy : Source :=
  { primary := .work tannerDecrees florenceOnTheProcession
  , supporting := [.work pcpcuGreekAndLatinTraditions .whole, .work photiusMystagogy .whole]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-! ### The order texts -/

/-- Augustine on John 14:28. -/
def augustineOnJohn14 : Locus := .sectionRef "On the Trinity I.7.14"

/-- Athanasius on John 14:28. -/
def athanasiusOnJohn14 : Locus := .sectionRef "Against the Arians I.13.58"

/-! ### Ratings for the steps over the order texts -/

/-- **The step from the order texts to a real order is well supported.** LST
draws it: the texts "establish real personal and mediatorial order". It was
audited for a reader who grants the texts and denies the order, and none was
found. The nearest is the Oneness writer David Bernard (*The Oneness of God*,
1983, ch. 8), who grants every text, and the sending, the obedience and the
final subjection, and reads "Father" and "Son" as the deity and the humanity of
one person: "The flesh was subject to the Spirit." The order as stated here does
not say whether Father and Son are two persons, so he grants it too. That they
are is LST's next question. -/
def onTheOrder : Source :=
  { primary := .work kibbeyLivingSystematicTheology lstOnTheProcession
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **The Arian step is well supported**: the reading it starts from already says
the Son is less in divinity, and no reader was found who grants the reading and
denies that. The dissent is from the reading, which is rated `disputed`. -/
def onTheArianReading : Source :=
  { primary := .work npnf1v3 augustineOnJohn14
  , supporting :=
      [ .work calvinJohn2 (.page 102)
      , .work npnf2v3 (.sectionRef "Theodoret, Ecclesiastical History I.4") ]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **Augustine's step is well supported**: his reading already says the Son is
equal in the form of God, and no reader was found who grants it and holds him
less in divinity. Gregory of Nazianzus grants the reading: "to say that he is
greater than the Son considered as man, is true indeed, but is no great thing"
(*Oration* 30.7). -/
def onTheTwoForms : Source :=
  { primary := .work npnf1v3 augustineOnJohn14
  , supporting := [.work npnfCyrilGregory (.sectionRef "Gregory of Nazianzus, Oration 30.7")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **Athanasius's step is well supported, because his reading says "not in
greatness".** Readers who grant only that the Father is greater as the one the
Son is from, and still hold him greater in divinity, deny that clause. The
creed of Sirmium (357) says the Father is "greater in honour and dignity and
Godhead, and in the very name of Father, the Son Himself testifying, 'The Father
that sent Me is greater than I'" (Athanasius, *De Synodis* 28). Gregory of
Nazianzus reports opponents who, granting that "in respect of being the Cause
the Father is greater than the Son", "deduce the conclusion that He is greater by
Nature also", and calls the inference a fallacy (*Oration* 29.15). So the
dispute sits in the reading, which is rated `disputed`. -/
def onTheBegetter : Source :=
  { primary := .work npnf2v4 athanasiusOnJohn14
  , supporting :=
      [ .work npnf2v4 (.sectionRef "De Synodis 28")
      , .work npnfCyrilGregory (.sectionRef "Gregory of Nazianzus, Oration 29.15") ]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **Calvin's step is well supported**: no reader was found who grants that the
verse compares the Mediator's humbled state with his glory and holds that it
says the Son is less in divinity. -/
def onTheMediatorsState : Source :=
  { primary := .work calvinJohn2 (.pages 102 103)
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- **Calvin against the Fathers' reply**: reading the verse of the Mediator's
state, he denies that it speaks of the Son's human nature, and calls the
Fathers' reply "neither correct nor appropriate". Rated `wellSupported`: his
reading says that the comparison is of states, not natures, and no reader was
found who grants that and reads the verse of the human nature. -/
def onCalvinAgainstTheFathers : Source :=
  { primary := .work calvinJohn2 (.page 102)
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- **The step from the order to an eternal order of authority is well
supported**: its reading already says the order is the outworking of an eternal
relationship, and no reader was found who grants that and denies the
relationship. The dissent is from the reading. Augustine grants the order and
reads it otherwise: the Son "was not sent in virtue of some disparity of power or
substance … but in virtue of the Son being from the Father" (*On the Trinity*
IV.20.27, as Grudem quotes it, 2016). -/
def onTheEternalOrder : Source :=
  { primary := .work grudemDoctrinalDeviations (.page 40)
  , supporting := [.work grudemEts2016 .whole, .work wareFatherSonSpirit .whole]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **Giles's step is well supported**: no reader was found who grants both its
grounds and still affirms an eternal submission. Grudem grants the first, the
Son's equality in power: the Evangelical Theological Society, of which he was
president, confesses the persons "equal in power and glory", and he "zealously"
guards "against greater ontological power" for the Father (2016, I.A.4). He
denies the second, that eternal submission would deny that equality. Giles
concedes that the second is his reading: "I cannot see how anyone could
distinguish these terms" (2008, p. 327). So the dispute sits in the reading,
which is rated `disputed`. -/
def onEqualPower : Source :=
  { primary := .work gilesEtsTrinity (.page 327)
  , supporting := [.work gilesJesusAndTheFather .whole, .work grudemEts2016 .whole]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-! ### Citations -/

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .john15_26ProceedsFromTheFather =>
    { label := "John 15:26 — the Spirit of truth, who proceeds from the Father"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.john, 15, 26⟩ }] }
  | .sonSendsTheSpirit =>
    { label := "John 15:26; 16:7 — the Son sends the Spirit, from the Father"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.john, 15, 26⟩ }, { ref := .verse ⟨.john, 16, 7⟩ }] }
  | .spiritOfTheSon =>
    { label := "Galatians 4:6; Romans 8:9 — the Spirit of his Son, the Spirit of Christ"
    , kind := .textual
    , source :=
        text [{ ref := .verse ⟨.galatians, 4, 6⟩ }, { ref := .verse ⟨.romans, 8, 9⟩ }] }
  | .acts2_33SonPoursOutTheSpirit =>
    { label := "Acts 2:33 — the exalted Son receives the promised Spirit and pours him out"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.acts, 2, 33⟩ }] }
  | .john16_14TakesWhatIsTheSons =>
    { label := "John 16:14 — the Spirit will take what is the Son's and declare it"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.john, 16, 14⟩ }] }
  | .spiritRelatedToBoth =>
    { label := "The Spirit is related to the Son as well as to the Father"
    , kind := .theological
    , source :=
        { primary := .work kibbeyLivingSystematicTheology lstOnTheProcession
        , supporting := [.work photiusMystagogy .whole, .work aquinasSumma aquinasOnTheSon]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .receivingIsOrigin =>
    { label := "In John 16:14 what the Spirit takes from the Son is his being, not only his word"
    , kind := .interpretive
    , source :=
        { primary := .work aquinasSumma aquinasOnTheSon
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .missionRevealsEternalRelation =>
    { label := "The Son's sending of the Spirit rests on an eternal relation of Spirit to Son"
    , kind := .theological
    , source :=
        { primary := .work aquinasSumma aquinasOnTheSon
        , supporting := [.work vischerSpiritOfGod (.page 165)]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .sonAndSpiritDistinct =>
    { label := "John 14:16 — the Son and the Spirit are two persons: \"another Helper\""
    , kind := .theological
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.john, 14, 16⟩ }]
        , supporting := [.work kibbeyLivingSystematicTheology lstOnTheProcession]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .distinctOnlyByOpposedRelations =>
    { label := "The divine persons are distinguished only by opposed relations of origin"
    , kind := .theological
    , source :=
        { primary := .work aquinasSumma aquinasOnTheSon
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .sonNotFromTheSpirit =>
    { label := "The Son is not from the Spirit: \"which no one says\""
    , kind := .theological
    , source :=
        { primary := .work aquinasSumma aquinasOnTheSon
        , tradition := .romanCatholic
        , confidence := .wellSupported } }
  | .john15_26SpeaksOfEternalOrigin =>
    { label := "John 15:26 \"proceeds\" speaks of the Spirit's eternal origin, not only of mission"
    , kind := .interpretive
    , source :=
        { primary := .work aquinasSumma aquinasOnTheSon
        , supporting := [.work photiusMystagogy .whole]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .john15_26NamesTheWholeSource =>
    { label := "In John 15:26 Jesus names the Spirit's source, the Father, and no other"
    , kind := .interpretive
    , source :=
        { primary := .work photiusMystagogy .whole
        , supporting := [.work wareOrthodoxChurch .whole]
        , tradition := .easternOrthodox
        , confidence := .disputed } }
  | .monarchyOfTheFather =>
    { label := "The Father is the one cause of the Son and of the Spirit"
    , kind := .theological
    , source :=
        { primary := .work photiusMystagogy .whole
        , supporting := [.work wareOrthodoxChurch .whole]
        , tradition := .easternOrthodox
        , confidence := .disputed } }
  | .filioque =>
    { label := "The Spirit proceeds eternally from the Father and the Son"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees florenceOnTheProcession
        , supporting := [.work westminsterConfession (.sectionRef "II.3")]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .sonDoesNothingOfHimself =>
    { label := "John 5:19, 30 — the Son does nothing of his own accord, but the sender's will"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.john, 5, 19⟩ }, { ref := .verse ⟨.john, 5, 30⟩ }] }
  | .fatherIsGreater =>
    { label := "John 14:28 — \"the Father is greater than I\""
    , kind := .textual
    , source := text [{ ref := .verse ⟨.john, 14, 28⟩ }] }
  | .fatherIsGodOfTheRisenSon =>
    { label := "John 20:17 — the risen Jesus: \"my God and your God\""
    , kind := .textual
    , source := text [{ ref := .verse ⟨.john, 20, 17⟩ }] }
  | .headOfChristIsGod =>
    { label := "1 Corinthians 11:3 — \"the head of Christ is God\""
    , kind := .textual
    , source := text [{ ref := .verse ⟨.firstCorinthians, 11, 3⟩ }] }
  | .sonSubjectAtTheEnd =>
    { label := "1 Corinthians 15:28 — \"the Son himself will also be subjected to him\""
    , kind := .textual
    , source := text [{ ref := .verse ⟨.firstCorinthians, 15, 28⟩ }] }
  | .sonInTheFormOfGod =>
    { label := "Philippians 2:6 — \"though he was in the form of God\""
    , kind := .textual
    , source := text [{ ref := .verse ⟨.philippians, 2, 6⟩ }] }
  | .realOrder =>
    { label := "There is a real order of Father and Son in the work of salvation"
    , kind := .theological
    , source :=
        { primary := .work kibbeyLivingSystematicTheology lstOnTheProcession
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .greaterMeansLesserDivinity =>
    { label := "In John 14:28 \"greater\" means the Son is less in his divinity"
    , kind := .interpretive
    , source :=
        { primary := .work npnf1v3 augustineOnJohn14
        , supporting := [.work calvinJohn2 (.page 102)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .lessInTheFormOfAServant =>
    { label := "The Son is less in the form of a servant, equal in the form of God"
    , kind := .interpretive
    , source :=
        { primary := .work npnf1v3 augustineOnJohn14
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .greaterAsBegetter =>
    { label := "The Father is \"greater\" as the one the Son is begotten from"
    , kind := .interpretive
    , source :=
        { primary := .work npnf2v4 athanasiusOnJohn14
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .greaterAsMediatorsState =>
    { label := "In John 14:28 Christ compares his humbled state as Mediator with his glory"
    , kind := .interpretive
    , source :=
        { primary := .work calvinJohn2 (.pages 102 103)
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .orderIsEternal =>
    { label := "The sending and obeying are the outworking of an eternal authority and submission"
    , kind := .theological
    , source :=
        { primary := .work grudemDoctrinalDeviations (.page 40)
        , supporting := [.work grudemEts2016 .whole, .work wareFatherSonSpirit .whole]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .sonEqualInPower =>
    { label := "The Son is equal to the Father in power: \"of one substance, power, and eternity\""
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "II.3")
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .subordinationDeniesEqualPower =>
    { label := "Eternal subordination in authority would deny the Son's equality in power"
    , kind := .theological
    , source :=
        { primary := .work gilesEtsTrinity (.page 323)
        , supporting := [.work gilesJesusAndTheFather .whole]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .sonLesserInDivinity =>
    { label := "The Son is less than the Father in his divinity"
    , kind := .theological
    , source :=
        { primary := .work npnf2v3 (.sectionRef "Theodoret, Ecclesiastical History I.4")
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .eternalAuthorityAndSubmission =>
    { label := "There is an eternal relationship of authority and submission of Father and Son"
    , kind := .theological
    , source :=
        { primary := .work grudemEts2016 .whole
        , supporting := [.work wareFatherSonSpirit .whole]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }

end TestimonyArguments.Trinity
