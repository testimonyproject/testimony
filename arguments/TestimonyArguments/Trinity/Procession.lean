import TestimonyArguments.Trinity.Sources
import TestimonyArguments.Meanings.Trinity
import Testimony.Logic.Tactic

/-!
# TestimonyArguments.Trinity.Procession — what the texts say, and what each side adds

Every party reads the same texts. Jesus promises "the Helper, … whom I will
send to you from the Father, the Spirit of truth, who proceeds from the Father"
(John 15:26), and "if I go, I will send him to you" (John 16:7). Paul writes
that "God has sent the Spirit of his Son into our hearts" (Galatians 4:6), and
calls him "the Spirit of Christ" (Romans 8:9). Peter says of the risen Jesus
that, "having received from the Father the promise of the Holy Spirit, he has
poured out this that you yourselves are seeing and hearing" (Acts 2:33).

From these texts LST draws one conclusion and declines a second. "These texts
establish a real relation of the Spirit to both Father and Son"
(`lstCase_establishes`). "They do not state that the Spirit's eternal origin is
'from the Father and the Son' rather than 'from the Father through the Son.'"
Put in the library's terms, the second claim is that the question is
*independent* of the texts: granted only them, the Filioque ("and the Son")
neither follows nor fails (`texts_leave_the_filioque_open`). Both claims hold.
The check sets "and the Son" against "from the Father alone", Photius's
position. The alternative LST names, "through the Son", is not yet a position
here. So the result shows that the texts leave the Filioque open. It does not
yet show that they leave open the choice between LST's two formulas.

## What the West adds

Thomas Aquinas states the objection himself: "in the Sacred Scripture we are not
told that the Holy Ghost proceeds from the Son; but only that He proceeds from
the Father, as appears from John 15:26" (*Summa* I, q. 36, a. 2, objection 1).
His answer is that "although we do not find it verbally expressed in Holy
Scripture that the Holy Ghost proceeds from the Son, still we do find it in the
sense of Scripture, especially where the Son says, speaking of the Holy Ghost,
'He will glorify Me, because He shall receive of Mine' (John 16:14)". So the
Western case starts from a verse LST does not cite. Adding it changes nothing
about what the texts settle (`john16_14_leaves_it_open_too`): the Western case
needs a reading of the verse, not the verse alone.

The Western case runs on three lines, each with a reading of its own. The first
reads John 16:14: what the Spirit takes from the Son is his being, not only
what he declares. The second reads the Son's sending: it rests on an eternal
relation of the Spirit to the Son, and in God, Aquinas argues, "there cannot be
… any relations opposed to each other, except relations of origin". The third is
Aquinas's argument from distinction: "if He were not from Him, He could in no wise be personally
distinguished from Him", because the persons are told apart only by opposed
relations of origin, and the Son is not from the Spirit, "which no one says".
The Western position delivers "and the Son" (`westernCase_establishes`), and
any one of its three lines would do. So no single reading is *load-bearing*,
meaning that taking it away would make the case fail
(`western_rests_on_no_one_reading`). Take away all three readings that divide
the sides, and what is left (the texts, John 16:14, and the distinction of Son
and Spirit that every party grants) does not reach the Filioque
(`western_needs_one_of_its_readings`).

## What the East adds

Kallistos Ware gives the Eastern case in a sentence: "An eternal procession of
the Spirit from the Father alone, a temporal mission from the Son: such was the
position upheld by St Photius against the west" (*The Orthodox Church*). Photius
argued on two lines. The first is from the Lord's own words: Jesus names the
Father as the one the Spirit proceeds from, and what he did not add may not be
added. The second is the *monarchy* of the Father: within the Godhead the
Father is the one cause of the Son and of the Spirit. The Eastern position delivers "not from the
Son" (`easternCase_establishes`), and either line would do, so neither reading
is load-bearing (`eastern_rests_on_no_one_reading`). Take both away and the texts are left, even
with John 15:26 read as eternal origin, and they do not exclude the Filioque
(`eastern_needs_one_of_its_readings`).

LST adds a further point: the texts do not "by themselves settle whether John
15:26 is speaking directly of eternal origin or of the Spirit's mission". That
holds too (`texts_leave_john15_26_open`), and there is a reader on each side:
B. F. Westcott read the verse as "the temporal mission of the Holy Spirit, and
not … the eternal Procession". But Aquinas and Photius both read it as eternal
origin, so this is not where they divide.

## What this does not claim

It does not say which side is right. Every reading that divides them is rated
`disputed`, because each side rejects the other's. Nor does either side have
every argument it makes here. The West's pairing of John 16:14 with 16:15, "All
that the Father has is mine", and Florence's reason that the Father gave the
Son everything "except to be the Father", are not encoded. Neither is the whole
of Photius's argument from the monarchy: that a property not common to all
three persons belongs to one alone, so that if causing the Spirit belonged to
the Father and the Son, either there would be two causes or the two persons
would merge. It does not encode the "from
the Father through the Son" (διὰ τοῦ Υἱοῦ) of the Greek fathers as a party of
its own. The Council of Florence declared that the phrase "bears the sense that
thereby also the Son should be signified, according to the Greeks indeed as
cause, and according to the Latins as principle of the subsistence of the holy
Spirit, just like the Father". An Orthodox reader denies that it does. That
third position is the next to add.

Nor does it settle what "proceeds" means. The Pontifical Council for Promoting
Christian Unity (1995) grants the Eastern grounds almost word for word, calling
the Father "the sole Trinitarian Cause (Aitia) or principle (principium) of the
Son and the Holy Spirit", and still confesses the Filioque. It reads the Greek
ἐκπόρευσις as origin from the Father alone and the Latin *processio* as a
wider word, which can be from the Son. If that distinction holds, the two
conclusions here may not contradict each other at all. Testing that means
reading "the Spirit proceeds from the Son" both ways and answering each reading,
and it is not yet done.
-/

namespace TestimonyArguments.Trinity

open Testimony

open Testimony Testimony.Bib Testimony.Logic

/-! ### The texts, and what they establish -/

/-- The texts LST cites. -/
@[trinityDefs]
def texts : List (Formula Claim) :=
  [ p .john15_26ProceedsFromTheFather, p .sonSendsTheSpirit, p .spiritOfTheSon
  , p .acts2_33SonPoursOutTheSpirit ]

/-- From the texts to a real relation between the Spirit and the Son: he is
sent by the Son, named for him, and poured out by him. -/
@[trinityDefs]
def textsRelateTheSpirit : Formula Claim :=
  ⋀ [ p .john15_26ProceedsFromTheFather, p .sonSendsTheSpirit, p .spiritOfTheSon
    , p .acts2_33SonPoursOutTheSpirit ] ➝ p .spiritRelatedToBoth

/-- **What the texts establish**, on LST's reading and on every party's: the
Spirit is related to the Son as well as to the Father. -/
@[trinityDefs]
def relationLine : Line Claim :=
  { name := "The texts: the Spirit sent by the Son and named for him"
  , grounds := texts
  , step := textsRelateTheSpirit
  , delivers := p .spiritRelatedToBoth
  , inference := some onTheRelation }

/-- **LST's position**: the texts, and the relation they establish. Every premise is
a text, cited to Scripture alone, which is the point: this is what the texts
establish by themselves. -/
@[trinityDefs]
def lstCase : ArgumentPackage Claim :=
  relationLine.asPackage cite "the Spirit is related to the Son as well as to the Father"

/-- LST's texts, with the verse Aquinas rests on added: John 16:14, "he will take
what is mine". -/
@[trinityDefs]
def lstWithAquinassVerse : ArgumentPackage Claim :=
  relationLine.onGrounds (texts ++ [p .john16_14TakesWhatIsTheSons]) |>.asPackage cite
    "the Spirit is related to the Son as well as to the Father"

/-! ### The Western case -/

/-- From John 16:14: the Spirit takes what is the Son's, and what he takes is
his being. -/
@[trinityDefs]
def receivingToOrigin : Formula Claim :=
  ⋀ [p .john16_14TakesWhatIsTheSons, p .receivingIsOrigin] ➝ p .filioque

/-- **The Western line from John 16:14.** -/
@[trinityDefs]
def receivingLine : Line Claim :=
  { name := "From \"he will take what is mine\" (Aquinas)"
  , grounds := [p .john16_14TakesWhatIsTheSons, p .receivingIsOrigin]
  , step := receivingToOrigin
  , delivers := p .filioque
  , inference := some onTheReceiving }

/-- From mission to origin: the Son sends the Spirit, the Spirit is named for
him, and the sending rests on an eternal relation of the Spirit to the Son,
which in God, Aquinas holds, can only be a relation of origin. -/
@[trinityDefs]
def missionToOrigin : Formula Claim :=
  ⋀ [p .sonSendsTheSpirit, p .spiritOfTheSon, p .missionRevealsEternalRelation] ➝ p .filioque

/-- **The Western line from mission.** -/
@[trinityDefs]
def missionLine : Line Claim :=
  { name := "From mission to origin (Aquinas)"
  , grounds := [p .missionRevealsEternalRelation]
  , step := missionToOrigin
  , delivers := p .filioque
  , inference := some onTheMission }

/-- From opposed relations: the Son and the Spirit are distinct, only an opposed
relation of origin distinguishes divine persons, and the Son is not from the
Spirit. -/
@[trinityDefs]
def oppositionToOrigin : Formula Claim :=
  ⋀ [p .sonAndSpiritDistinct, p .distinctOnlyByOpposedRelations, p .sonNotFromTheSpirit]
  ➝ p .filioque

/-- **The Western line from distinction.** Aquinas allows the other order too
("either the Son is from the Holy Ghost; which no one says; or that the Holy
Ghost is from the Son"), and sets it aside because no one holds it. The line
writes that premise in. -/
@[trinityDefs]
def oppositionLine : Line Claim :=
  { name := "From the distinction of Son and Spirit (Aquinas)"
  , grounds :=
      [p .sonAndSpiritDistinct, p .distinctOnlyByOpposedRelations, p .sonNotFromTheSpirit]
  , step := oppositionToOrigin
  , delivers := p .filioque
  , inference := some onTheOpposition }

/-- **The Western position**: the texts, read by any one of the three Western
lines, deliver "and the Son". -/
@[trinityDefs]
def westernCase : ArgumentPackage Claim :=
  { name := "From the Father and the Son (Aquinas; Florence; Westminster)"
  , cite := cite
  , premises := caseOf [relationLine, receivingLine, missionLine, oppositionLine] [] []
  , conclusion := p .filioque
  , conclusionLabel := "the Spirit proceeds from the Father and the Son"
  , inferences := [onTheRelation, onTheReceiving, onTheMission, onTheOpposition] }

/-! ### The Eastern case -/

/-- From the words of John 15:26: Jesus says the Spirit proceeds from the
Father, the verse speaks of eternal origin, and it names the whole of the
Spirit's source. -/
@[trinityDefs]
def wordsExcludeTheSon : Formula Claim :=
  ⋀ [ p .john15_26ProceedsFromTheFather, p .john15_26SpeaksOfEternalOrigin
    , p .john15_26NamesTheWholeSource ] ➝ notP .filioque

/-- **The Eastern line from the words of John 15:26.** -/
@[trinityDefs]
def wordsLine : Line Claim :=
  { name := "From the Lord's words, \"from the Father\" (Photius)"
  , grounds := [p .john15_26SpeaksOfEternalOrigin, p .john15_26NamesTheWholeSource]
  , step := wordsExcludeTheSon
  , delivers := notP .filioque
  , inference := some onTheWords }

/-- From the monarchy: the Father is the one cause of Son and Spirit, so the
Spirit is not from the Son as well. -/
@[trinityDefs]
def monarchyExcludesTheSon : Formula Claim :=
  p .monarchyOfTheFather ➝ notP .filioque

/-- **The Eastern line from the monarchy of the Father.** -/
@[trinityDefs]
def monarchyLine : Line Claim :=
  { name := "From the monarchy of the Father (Photius, Ware)"
  , grounds := [p .monarchyOfTheFather]
  , step := monarchyExcludesTheSon
  , delivers := notP .filioque
  , inference := some onTheMonarchy }

/-- **The Eastern position**: the texts, read by either Eastern line, exclude
"and the Son". -/
@[trinityDefs]
def easternCase : ArgumentPackage Claim :=
  { name := "From the Father alone (Photius; Ware)"
  , cite := cite
  , premises := caseOf [relationLine, wordsLine, monarchyLine] [] []
  , conclusion := notP .filioque
  , conclusionLabel := "the Spirit does not proceed from the Son"
  , inferences := [onTheRelation, onTheWords, onTheMonarchy] }

/-! ### Readings, written down -/

/-- **The Western reading**: every text, every Western reading, John 15:26 as
eternal origin, and the Filioque. The verse names the Father without naming the
whole of the Spirit's source. The Father is not the *only* cause either, as
Florence holds: the Spirit "has his essence and his subsistent being from the
Father together with the Son". The Pontifical Council's reading of 1995, which
grants the monarchy, is a different position, not written down here. -/
def westernReading : Valuation Claim := fun a =>
  match a with
  | .john15_26NamesTheWholeSource => False
  | .monarchyOfTheFather => False
  | _ => True

/-- **The Eastern reading**, as Photius holds it: every text, John 15:26 as
eternal origin and as naming the whole source, the monarchy of the Father, and
no Filioque. What the Spirit takes from the Son in John 16:14 is what he
declares. The Son's sending is "a temporal mission from the Son", in Ware's
words, resting on no eternal relation to him. The persons are told apart by how
each is from the Father, not by a relation between Son and Spirit. -/
def easternReading : Valuation Claim := fun a =>
  match a with
  | .receivingIsOrigin => False
  | .missionRevealsEternalRelation => False
  | .distinctOnlyByOpposedRelations => False
  | .filioque => False
  | _ => True

/-- **The reading of John 15:26 as mission**, Westcott's: the verse speaks of
the Spirit being sent, not of where he is from eternally. Westcott notes that
"from the Father" is παρά, which "expresses properly position ('from the side
of'), and not source (ἐκ, 'out of')", and concludes that "the reference here is
to the temporal mission of the Holy Spirit, and not to the eternal Procession"
(pp. 224–225). Otherwise everything is as the Western reading has it. -/
def missionReading : Valuation Claim := fun a =>
  match a with
  | .john15_26SpeaksOfEternalOrigin => False
  | .john15_26NamesTheWholeSource => False
  | .monarchyOfTheFather => False
  | _ => True

/-! ### What the texts settle, and what they leave open -/

/-- **Grant the texts, and the Spirit is related to the Son as well as to the
Father.** This is what LST says the texts establish, and every party here
grants it. -/
@[headline]
theorem lstCase_establishes : Establishes lstCase := by
  establish [trinityDefs]

#print axioms lstCase_establishes

/-- LST's position can be held without contradiction. -/
theorem lstCase_is_satisfiable : Satisfiable lstCase.premises := by
  satisfied_by westernReading [trinityDefs]

/-- **The texts leave the Filioque open.** Granted the texts LST cites and the
relation they establish, "and the Son" neither follows nor fails. The Western
reading satisfies every premise with it, and the Eastern reading satisfies every
premise without it.

That is LST's claim, and it holds. It is a modest claim, and cheap to prove for
the same reason: no text names the Spirit's eternal origin from the Son, or
denies it. What the result does show is that the dispute lives in the readings
each side brings to the verses, which the chapter on weighing the positions sets
against each other. It sets "and the Son" against "from the Father alone"; the
"through the Son" LST names is not yet a party. -/
@[headline]
theorem texts_leave_the_filioque_open : Independent lstCase.premises (p .filioque) := by
  leaves_open easternReading westernReading [trinityDefs]

#print axioms texts_leave_the_filioque_open

/-- **Adding the verse Aquinas rests on leaves the question open too.** With
John 16:14 among the texts, "and the Son" still neither follows nor fails: the
same two readings satisfy every premise. Aquinas does not say the verse states
it. He says "we do find it in the sense of Scripture", and the sense is a
reading, which is the Western line from John 16:14. -/
@[headline]
theorem john16_14_leaves_it_open_too :
    Independent lstWithAquinassVerse.premises (p .filioque) := by
  leaves_open easternReading westernReading [trinityDefs]

#print axioms john16_14_leaves_it_open_too

/-- **The texts leave open whether John 15:26 speaks of eternal origin.**
Granted the texts, the reading on which "proceeds" speaks of mission satisfies
every premise, and so does the reading on which it speaks of eternal origin.

That is LST's further claim, and it holds, with a reader on each side.
Westcott reads the verse as mission. Aquinas and Photius both read it as eternal
origin, so it is not where they divide. Their dispute is over whether the verse
names the whole of the Spirit's origin, not over whether it speaks of origin at
all. -/
@[headline]
theorem texts_leave_john15_26_open :
    Independent lstCase.premises (p .john15_26SpeaksOfEternalOrigin) := by
  leaves_open missionReading westernReading [trinityDefs]

#print axioms texts_leave_john15_26_open

/-! ### What each position delivers -/

/-- **Grant the Western position, and the Spirit proceeds from the Father and the
Son.** Any one of its three lines would do (`western_rests_on_no_one_reading`). -/
@[headline]
theorem westernCase_establishes : Establishes westernCase := by
  establish [trinityDefs]

#print axioms westernCase_establishes

/-- The Western position can be held without contradiction. -/
theorem westernCase_is_satisfiable : Satisfiable westernCase.premises := by
  satisfied_by westernReading [trinityDefs]

/-- **Grant the Eastern position, and the Spirit does not proceed from the
Son.** Either of its two lines would do (`eastern_rests_on_no_one_reading`). -/
@[headline]
theorem easternCase_establishes : Establishes easternCase := by
  establish [trinityDefs]

#print axioms easternCase_establishes

/-- The Eastern position can be held without contradiction. -/
theorem easternCase_is_satisfiable : Satisfiable easternCase.premises := by
  satisfied_by easternReading [trinityDefs]

/-! ### What each side's case rests on -/

/-- The Western position without its reading of John 16:14. The verse stays. -/
@[trinityDefs]
def westernWithoutTheReceiving : ArgumentPackage Claim :=
  { westernCase with
    premises :=
      caseOf
        [ relationLine, receivingLine.onGrounds [p .john16_14TakesWhatIsTheSons]
        , missionLine, oppositionLine ] [] [] }

/-- The Western position without its reading of the Son's mission. -/
@[trinityDefs]
def westernWithoutTheMission : ArgumentPackage Claim :=
  { westernCase with
    premises :=
      caseOf [relationLine, receivingLine, missionLine.onGrounds [], oppositionLine] [] [] }

/-- The Western position without the claim that only opposed relations
distinguish the persons. That the Son and the Spirit are distinct stays, and so
does that the Son is not from the Spirit. -/
@[trinityDefs]
def westernWithoutTheOpposition : ArgumentPackage Claim :=
  { westernCase with
    premises :=
      caseOf
        [ relationLine, receivingLine, missionLine
        , oppositionLine.onGrounds [p .sonAndSpiritDistinct, p .sonNotFromTheSpirit] ] [] [] }

/-- The Western position without any of its readings: the texts, John 16:14,
the distinction of Son and Spirit, that the Son is not from the Spirit, and the
three Western steps with nothing to start from. -/
@[trinityDefs]
def westernOnTheTextsAlone : ArgumentPackage Claim :=
  { westernCase with
    premises :=
      caseOf
        [ relationLine, receivingLine.onGrounds [p .john16_14TakesWhatIsTheSons]
        , missionLine.onGrounds []
        , oppositionLine.onGrounds [p .sonAndSpiritDistinct, p .sonNotFromTheSpirit] ] [] [] }

/-- The Western position without its reading of John 16:14 can be held without
contradiction: the Western reading satisfies it. -/
theorem westernWithoutTheReceiving_is_satisfiable :
    Satisfiable westernWithoutTheReceiving.premises := by
  satisfied_by westernReading [trinityDefs]

/-- The Western position without its reading of the mission can be held. -/
theorem westernWithoutTheMission_is_satisfiable :
    Satisfiable westernWithoutTheMission.premises := by
  satisfied_by westernReading [trinityDefs]

/-- The Western position without opposed relations can be held. -/
theorem westernWithoutTheOpposition_is_satisfiable :
    Satisfiable westernWithoutTheOpposition.premises := by
  satisfied_by westernReading [trinityDefs]

/-- **The Western case rests on no one of its readings.** Take away any one of
the three (the reading of John 16:14, of the Son's sending, or the claim that
only opposed relations distinguish the persons) and the other two lines still
deliver "and the Son". So an Eastern reader who answers one Western line has not
answered the case. -/
@[headline]
theorem western_rests_on_no_one_reading :
    Establishes westernWithoutTheReceiving ∧ Establishes westernWithoutTheMission ∧
      Establishes westernWithoutTheOpposition :=
  ⟨by establish [trinityDefs], by establish [trinityDefs], by establish [trinityDefs]⟩

#print axioms western_rests_on_no_one_reading

/-- **It rests on the three together.** Take away the three readings that divide
the sides, and what is left (the texts, John 16:14, the distinction of Son and
Spirit, and that the Son is not from the Spirit) does not reach "and the Son":
the Eastern reading satisfies all of it.

So the Western case needs at least one of its readings, and the texts alone are
not enough. That is the Western half of LST's claim, stated for the Western
case's own premises. -/
@[headline]
theorem western_needs_one_of_its_readings : ¬ Establishes westernOnTheTextsAlone := by
  refute_with easternReading [trinityDefs]

#print axioms western_needs_one_of_its_readings

/-- The Eastern position without its reading of the Lord's words. That John
15:26 speaks of eternal origin stays: Aquinas reads it so too. -/
@[trinityDefs]
def easternWithoutTheWords : ArgumentPackage Claim :=
  { easternCase with
    premises :=
      caseOf [relationLine, wordsLine.onGrounds [p .john15_26SpeaksOfEternalOrigin], monarchyLine]
        [] [] }

/-- The Eastern position without the monarchy of the Father. -/
@[trinityDefs]
def easternWithoutTheMonarchy : ArgumentPackage Claim :=
  { easternCase with
    premises := caseOf [relationLine, wordsLine, monarchyLine.onGrounds []] [] [] }

/-- The Eastern position without either of its readings. -/
@[trinityDefs]
def easternOnTheTextsAlone : ArgumentPackage Claim :=
  { easternCase with
    premises :=
      caseOf
        [ relationLine, wordsLine.onGrounds [p .john15_26SpeaksOfEternalOrigin]
        , monarchyLine.onGrounds [] ] [] [] }

/-- The Eastern position without its reading of the Lord's words can be held:
the Eastern reading satisfies it. -/
theorem easternWithoutTheWords_is_satisfiable :
    Satisfiable easternWithoutTheWords.premises := by
  satisfied_by easternReading [trinityDefs]

/-- The Eastern position without the monarchy can be held. -/
theorem easternWithoutTheMonarchy_is_satisfiable :
    Satisfiable easternWithoutTheMonarchy.premises := by
  satisfied_by easternReading [trinityDefs]

/-- **The Eastern case rests on neither of its readings alone.** Take away the
reading of the Lord's words, or the monarchy of the Father, and the other line
still excludes "and the Son". So a Western reader who answers one Eastern line
has not answered the case. -/
@[headline]
theorem eastern_rests_on_no_one_reading :
    Establishes easternWithoutTheWords ∧ Establishes easternWithoutTheMonarchy :=
  ⟨by establish [trinityDefs], by establish [trinityDefs]⟩

#print axioms eastern_rests_on_no_one_reading

/-- **It rests on the two together.** Drop both readings, and the texts, with
John 15:26 read as eternal origin, do not exclude "and the Son": the Western
reading satisfies everything that is left. That is the Eastern half of LST's
claim, stated for the Eastern case's own premises. -/
@[headline]
theorem eastern_needs_one_of_its_readings : ¬ Establishes easternOnTheTextsAlone := by
  refute_with westernReading [trinityDefs]

#print axioms eastern_needs_one_of_its_readings

end TestimonyArguments.Trinity
