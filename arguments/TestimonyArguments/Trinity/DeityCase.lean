import TestimonyArguments.Trinity.Deity
import Testimony.Logic.Burden
import Testimony.Logic.Declare

/-!
# TestimonyArguments.Trinity.DeityCase — the Nicene case, supplemented

Ken Kibbey's *Living Systematic Theology* (LST) confesses the Son and the Spirit
God, and the three persons, from a few texts read in its own way. The last two
chapters found that the weighing cannot choose between that reading and the
readings of its two rivals: Jehovah's Witnesses, for whom the Son is "a god" and
a creature, and the Oneness Pentecostal David Bernard, for whom Father, Son and
Spirit are one person. This chapter asks what the older defenders of the
confession, and some newer ones, add. The case it builds goes beyond what LST
argues. The library assembles it from cited sources, every one of its readings
old, and marks its results as proposed (⚗), so that a reader can tell what the
library constructs from what it reports.

## More routes to "the Son is God"

LST rests the Son's deity on John 1:1 and 1:3, with Thomas's words in John 20:28
among its texts. Christians have read 20:28 as a route of its own, and four more
texts the same way, and the Witnesses have answered each:

- Thomas's "My Lord and my God!" (John 20:28). Augustine: Thomas "saw and
  touched the man, and acknowledged the God whom he neither saw nor touched".
  The Witnesses: "To Thomas, Jesus was like 'a god'".
- "Your throne, O God, is forever and ever" (Hebrews 1:8). Calvin: whoever reads
  the verse "cannot doubt but that the Messiah is called God". The New World
  Translation, the Witnesses' Bible: "God is your throne", because verse 9, "God,
  your God, anointed you", shows the one addressed is "one of his worshippers".
- "Our great God and Savior Jesus Christ" (Titus 2:13). Granville Sharp (1798;
  cited here from the edition of 1803) argued that when the Greek word for "the"
  stands once before two nouns joined by "and", as it does before "God" and
  "Savior", one person is meant, so that Christ is "not only entitled God, but
  even the 'great God'". The New World Translation reads two persons: "the great
  God and of our Savior, Jesus Christ".
- "The Christ, who is God over all, blessed forever" (Romans 9:5). Calvin: "the
  words most evidently mean this". The New World Translation puts a full stop
  before "God" and reads a praise of the Father.
- "At the name of Jesus every knee should bow" (Philippians 2:10–11), which is
  what Isaiah 45:23 says of the LORD. Calvin: "everything may be accomplished in
  him that God, by the prophet Isaiah, exclusively claims to himself". The
  Witnesses read the honour as given "to the glory of God the Father", by one
  greater.

With LST's route from John 1:1 these are six routes to one conclusion, and the
library proves what an opponent must reject to overturn it: the reading of each
of the six, and nothing less (`son_is_god_burden`).

## The Fathers against the modalists and the Arians

A modalist holds the Father, the Son and the Spirit to be one person showing
himself in three ways, as Oneness does. Tertullian wrote *Against Praxeas* about
213 against one, Praxeas, who, he says, "put to flight the Paraclete [the
Helper, the Holy Spirit], and … crucified the Father". Two of his arguments answer
the Oneness reading directly. When Jesus says the law asks for two witnesses and
names himself and the Father (John 8:17–18), "if He were one — being at once both
the Son and the Father — He certainly would not have quoted the sanction of the
law, which requires not the testimony of one, but of two". And when the Son asks
on earth and the Father answers from heaven (John 12:28; Matthew 17:5), "how many
Persons do you discover, obstinate Praxeas? Are there not as many as there are
voices?" Bernard answers both: the two witnesses, he says, are "the Father (the
divine Spirit) and the man Jesus", and the voice is "only another manifestation of
the omnipresent Spirit of God". Tertullian's own account comes close to the
Oneness reading at one point: before creation, he says, the Word was God's "own
Thought", what "the Greeks call λόγος" (*logos*, "word" or "reason") (ch. 5),
and only at creation a second person (ch. 7). That concession is not encoded.

Arius, the Alexandrian priest who held the Son a creature, read "firstborn of all
creation" (Colossians 1:15) much as the Witnesses do. Athanasius, writing against
the Arians, answers that all things were created in the Son, so "He is other than
the creatures, and is not a creature, but the Creator of the creatures". Arius
had already granted that the Son is over the rest of creation and still called
him a creature, "a perfect creature of God, but not as one of the creatures", so
the step is rated `disputed`, the lowest of the library's four ratings, given
when a cited reader grants a step's starting points and denies its conclusion.

Bruce Metzger (1953) answers "a god" from the one God of Scripture: "if the
Jehovah's Witnesses take this translation seriously, they are polytheists". The
Witnesses reply from John 10:34, where Jesus quotes "you are gods": "Since these
are referred to as 'gods,' mighty ones, surely Jesus can be and is 'a god'". And
some Christian readers grant Metzger's premise and still hold the Word God:
Origen calls him "a second God", and Justin "another God and Lord subject to the
Maker of all things". So Metzger's step is rated `disputed` too.

## What "is God" means

Both rivals reason from one reading of the words "is God": that to call someone
God, in the full sense, is to say he is the one God himself, so that two who are
God are the same. (The Witnesses allow a lesser sense, "a god", as their reply to
Metzger shows.) Bernard concludes that Jesus, being God, is "the Father manifested
in flesh". The Witnesses' brochure reasons the other way, that one who is "with"
God "cannot be the same as" God, and so is not God. Basil gave another reading in
the fourth century: "ousia [essence] has the same relation to hypostasis [person]
as the common has to the particular". "God" names the one essence the Father, the
Son and the Spirit share, and "Father", "Son" and "Spirit" name the persons. The
creed of the Council of Nicaea (325) had already confessed the Son "of one
substance (ὁμοούσιον) with the Father".

The library checks a smaller thing than either reading: what Bernard's step does
to three claims a reader may think collide, that the Father is God, the Son is
God, and the Son is another than the Father. Written as three claims, they can
all be true at once, and they stay so with Basil's reading added, which rules
out reading "is God" as identity (`three_claims_hold_on_one_essence`). Add
Bernard's step, from "each is the one God" to "they are the same person", and
they cannot (`three_claims_fail_on_identity`). The check does not model what
"essence" and "person" mean; that analysis is not yet done.

The step is where Bernard parts, and an orthodox reader denies it. Thomas Aquinas
holds each person the one God himself, since "in God essence is not really
distinct from person", and still holds the Son another than the Father. Things
identical with the same thing are identical with each other, he answers, only
"if the identity be real and logical". Because Aquinas grants Bernard's starting
point and denies his step, the step is rated `disputed`. The same Aquinas rates
Basil's step `disputed` as well: he grants the one essence and still holds each
person the one God himself. So the Nicene case as built here denies something
Aquinas affirms, and he parts from the rivals only at the step to one person.
The disagreement is over what "is God" and "the same" mean, and the Nicene
confession is not shown to contradict itself.

## What the weighing finds

Two positions tie when each defeats the other and the ratings do not choose. A
position is forced when it is accepted however the ties are settled, and it can
be defended when some consistent way of settling them accepts it.

Supplemented, the Nicene case still ties with each rival, and nothing is forced
(`supplemented_forces_nothing`). The Nicene case can be defended
(`nicene_case_defensible`), and so can each rival: the Witnesses on their own
(`witnesses_answering_defensible`), and Oneness together with the six routes
(`nicene_case_not_forced`). Each reading aimed at a rival is answered by that
rival with a cited reading of its own, rated the same: Bernard on the witnesses
and the voice, the Witnesses on the other "gods". Every reading on both sides is
rated `disputed`. Because the weighing ranks a position by its weakest reading,
six routes weigh there no more than one, and the breadth raises the burden
instead: to deny that the Son is God a reader must reject the reading of each of
six routes, and the Witnesses do, each with a rendering of their own
(`son_is_god_burden`). Oneness also holds that the Son is God, so the six routes
can be defended alongside it (`son_is_god_defensible_with_oneness`). Only the
Witnesses' position defeats them, and it can still be defended
(`son_is_god_not_forced`).

The meanings of these claims are not yet analysed (see the page on how far each
argument is checked). When they are, the fallacy checks can test whether either
side reads "God" in two senses where its step needs one.
-/

namespace TestimonyArguments.Trinity

open Testimony

open Testimony Testimony.Bib Testimony.Logic

/-! ### The Father and the Son are two: Tertullian against Praxeas -/

/-- From the two witnesses, read as two persons, to the Son's being another than
the Father. -/
@[trinityDefs]
def witnessesMakeTwo : Formula Claim :=
  ⋀ [p .twoWitnesses, p .twoWitnessesAreTwoPersons] ➝ p .sonIsAnotherThanTheFather

/-- **Tertullian's line from John 8:17–18**: the law asks for two witnesses, and
the Son names himself and the Father. -/
@[trinityDefs]
def twoWitnessesLine : Line Claim :=
  { name := "Two witnesses, the Son and the Father (Tertullian)"
  , grounds := [p .twoWitnesses, p .twoWitnessesAreTwoPersons]
  , step := witnessesMakeTwo
  , delivers := p .sonIsAnotherThanTheFather
  , inference := some onTheTwoWitnesses }

/-- From the voice from heaven, read as a second person, to the same. -/
@[trinityDefs]
def voicesMakeTwo : Formula Claim :=
  ⋀ [p .voiceFromHeaven, p .voicesAreTwoPersons] ➝ p .sonIsAnotherThanTheFather

/-- **Tertullian's line from the voice from heaven**: the Son asks on earth and
the Father answers from heaven. -/
@[trinityDefs]
def voicesLine : Line Claim :=
  { name := "The Son on earth, the Father in heaven (Tertullian)"
  , grounds := [p .voiceFromHeaven, p .voicesAreTwoPersons]
  , step := voicesMakeTwo
  , delivers := p .sonIsAnotherThanTheFather
  , inference := some onTheVoices }

/-! ### The Son is not "a god" or a creature: Metzger and Athanasius -/

/-- From the one God, and "a god" read as a second god, to the Word's not being
"a god". -/
@[trinityDefs]
def noSecondGod : Formula Claim :=
  ⋀ [p .oneGod, p .wordWasGod, p .aSecondGodIsPolytheism] ➝ notP .wordIsAGod

/-- **Metzger's line**: there is one God, so a Word who was "a god" beside him
would be a second god, and John does not teach two. -/
@[trinityDefs]
def noSecondGodLine : Line Claim :=
  { name := "One God, so not \"a god\" beside him (Metzger)"
  , grounds := [p .oneGod, p .wordWasGod, p .aSecondGodIsPolytheism]
  , step := noSecondGod
  , delivers := notP .wordIsAGod
  , inference := some onPolytheism }

/-- From "firstborn", read as over creation, to the Son's not being a creature. -/
@[trinityDefs]
def firstbornOverCreation : Formula Claim :=
  ⋀ [p .firstbornOfAllCreation, p .firstbornIsOverCreation] ➝ notP .sonIsACreature

/-- **Athanasius's line from Colossians 1:15**: all things were created in the
Son, so he is over creation, not one of the things created. -/
@[trinityDefs]
def firstbornLine : Line Claim :=
  { name := "Firstborn over creation, not in it (Athanasius)"
  , grounds := [p .firstbornOfAllCreation, p .firstbornIsOverCreation]
  , step := firstbornOverCreation
  , delivers := notP .sonIsACreature
  , inference := some onTheFirstborn }

/-! ### What "is God" means: one essence, three persons -/

/-- From "is God" read as one essence, to its not meaning identity. -/
@[trinityDefs]
def essenceExcludesIdentity : Formula Claim :=
  p .isGodAsOneEssence ➝ notP .isGodAsIdentity

/-- **Basil's line on "is God"**: the word names the one essence the Father and
the Son share, not the person each is. -/
@[trinityDefs]
def oneEssenceLine : Line Claim :=
  { name := "One essence, three persons (Basil; Nicaea)"
  , grounds := [p .isGodAsOneEssence]
  , step := essenceExcludesIdentity
  , delivers := notP .isGodAsIdentity
  , inference := some onOneEssence }

/-! ### The Son is God: five more routes, each a text read as calling him God -/

/-- **From Thomas's words**: "My Lord and my God!", said to Jesus. -/
@[trinityDefs]
def thomasLine : Line Claim :=
  { name := "\"My Lord and my God!\" (John 20:28; Augustine)"
  , grounds := [p .thomasMyLordAndMyGod]
  , step := p .thomasMyLordAndMyGod ➝ p .wordIsGod
  , delivers := p .wordIsGod
  , inference := some onThomas }

/-- **From Hebrews 1:8**: "Your throne, O God", said to the Son. -/
@[trinityDefs]
def throneLine : Line Claim :=
  { name := "\"Your throne, O God\" (Hebrews 1:8; Calvin)"
  , grounds := [p .throneOGod]
  , step := p .throneOGod ➝ p .wordIsGod
  , delivers := p .wordIsGod
  , inference := some onTheThrone }

/-- **From Titus 2:13**: "our great God and Savior", one person. -/
@[trinityDefs]
def greatGodLine : Line Claim :=
  { name := "\"Our great God and Savior\" (Titus 2:13; Sharp)"
  , grounds := [p .greatGodAndSavior]
  , step := p .greatGodAndSavior ➝ p .wordIsGod
  , delivers := p .wordIsGod
  , inference := some onTheGreatGod }

/-- **From Romans 9:5**: "the Christ, who is God over all". -/
@[trinityDefs]
def godOverAllLine : Line Claim :=
  { name := "\"The Christ, who is God over all\" (Romans 9:5; Calvin)"
  , grounds := [p .godOverAll]
  , step := p .godOverAll ➝ p .wordIsGod
  , delivers := p .wordIsGod
  , inference := some onGodOverAll }

/-- **From Philippians 2:10–11**: every knee bows to Jesus, as Isaiah 45:23 says
every knee bows to the LORD. -/
@[trinityDefs]
def everyKneeLine : Line Claim :=
  { name := "Every knee to Jesus, as to the LORD (Philippians 2:10–11; Calvin)"
  , grounds := [p .everyKneeToJesus]
  , step := p .everyKneeToJesus ➝ p .wordIsGod
  , delivers := p .wordIsGod
  , inference := some onEveryKnee }

/-- The six routes to "the Son is God": LST's from John 1:1 and 1:3, with John
20:28 among its texts, and the five above. -/
@[trinityDefs]
def sonIsGodRoutes : List (Line Claim) :=
  [wordLine, thomasLine, throneLine, greatGodLine, godOverAllLine, everyKneeLine]

/-- **The case that the Son is God, by six routes.** Each route is a text and the
reading that carries it to the conclusion. -/
@[trinityDefs]
def sonIsGodCase : ArgumentPackage Claim :=
  { name := "The Son is God, by six texts"
  , cite := cite
  , premises := caseOf sonIsGodRoutes [] []
  , conclusion := p .wordIsGod
  , conclusionLabel := "the Word who became flesh in Jesus is God"
  , inferences :=
      [onTheWordsDeity, onThomas, onTheThrone, onTheGreatGod, onGodOverAll, onEveryKnee] }

/-- The lines the library adds to LST's, each cited to the reader it comes from. -/
@[trinityDefs]
def supplementLines : List (Line Claim) :=
  [twoWitnessesLine, voicesLine, noSecondGodLine, firstbornLine, oneEssenceLine]

/-- **The Nicene case, supplemented**: LST's three lines, and the lines above. -/
@[trinityDefs]
def nicenCase : ArgumentPackage Claim :=
  { name := "One God, three persons, supplemented (the Nicene case)"
  , cite := cite
  , premises :=
      caseOf (sonIsGodRoutes ++ [spiritLine, personsLine] ++ supplementLines) [p .fatherIsGod]
        [confessionDrawnTogether]
  , conclusion := p .triuneGod
  , conclusionLabel := "the Father, the Son and the Spirit are God, three persons and one God"
  , inferences :=
      [ onTheWordsDeity, onThomas, onTheThrone, onTheGreatGod, onGodOverAll, onEveryKnee
      , onTheSpiritsDeity, onThePersons, onTheTwoWitnesses, onTheVoices, onPolytheism
      , onTheFirstborn, onOneEssence, onTheConfession ] }

/-! ### The rivals' replies -/

/-- The Witnesses' step: Scripture rightly calls others "gods", so "a god" is not
a second God. -/
@[trinityDefs]
def otherGodsAnswerMetzger : Formula Claim :=
  ⋀ [p .othersCalledGods, p .othersRightlyCalledGods] ➝ notP .aSecondGodIsPolytheism

/-- **The Witnesses' reply from John 10:34**: "Since these are referred to as
'gods,' mighty ones, surely Jesus can be and is 'a god.'" -/
@[trinityDefs]
def otherGodsLine : Line Claim :=
  { name := "\"You are gods\": a god, not a second God (the Witnesses)"
  , grounds := [p .othersCalledGods, p .othersRightlyCalledGods]
  , step := otherGodsAnswerMetzger
  , delivers := notP .aSecondGodIsPolytheism
  , inference := some onOtherGods }

/-- The Witnesses' step from identity: one who is with God, as another, is not
God. -/
@[trinityDefs]
def withGodIsNotGod : Formula Claim :=
  ⋀ [p .isGodAsIdentity, p .fatherIsGod, p .wordIsAnotherWithGod] ➝ notP .wordIsGod

/-- **The Witnesses' line from identity**: "Someone who is 'with' another person
cannot be the same as that other person." -/
@[trinityDefs]
def withGodLine : Line Claim :=
  { name := "With God, so not God (the Witnesses)"
  , grounds := [p .isGodAsIdentity, p .fatherIsGod, p .wordIsAnotherWithGod]
  , step := withGodIsNotGod
  , delivers := notP .wordIsGod
  , inference := some onIdentity }

/-- **The Witnesses' position, answering**: their case, with their reply from John
10:34 to Metzger and their reasoning from "with God". -/
@[trinityDefs]
def witnessesAnswering : ArgumentPackage Claim :=
  { name := "A god, not God, answering (Jehovah's Witnesses)"
  , cite := cite
  , premises :=
      caseOf [creatureLine, forceLine, otherGodsLine, withGodLine] witnessesShared
        [creatureIsNotGod, forceIsNotGod]
  , conclusion := notP .wordIsGod
  , conclusionLabel := "the Son is a creature, and not God"
  , inferences := [onTheCreature, onTheForce, onOtherGods, onIdentity, onCreatureNotGod
                  , onForceNotGod] }

/-- Bernard's step: the two witnesses are the Spirit and the man, so not two
persons. -/
@[trinityDefs]
def witnessesAreOne : Formula Claim :=
  ⋀ [p .twoWitnesses, p .twoWitnessesAreSpiritAndMan] ➝ notP .twoWitnessesAreTwoPersons

/-- **Bernard's reply on John 8:17–18.** -/
@[trinityDefs]
def spiritAndManLine : Line Claim :=
  { name := "The Spirit and the man, one person (Bernard)"
  , grounds := [p .twoWitnesses, p .twoWitnessesAreSpiritAndMan]
  , step := witnessesAreOne
  , delivers := notP .twoWitnessesAreTwoPersons
  , inference := some onBernardsReplies }

/-- Bernard's step: the voice is a manifestation, so not a second person. -/
@[trinityDefs]
def voiceIsOne : Formula Claim :=
  ⋀ [p .voiceFromHeaven, p .voiceIsAManifestation] ➝ notP .voicesAreTwoPersons

/-- **Bernard's reply on the voice from heaven.** -/
@[trinityDefs]
def manifestationLine : Line Claim :=
  { name := "The voice, a manifestation of the one Spirit (Bernard)"
  , grounds := [p .voiceFromHeaven, p .voiceIsAManifestation]
  , step := voiceIsOne
  , delivers := notP .voicesAreTwoPersons
  , inference := some onBernardsReplies }

/-- Bernard's step from identity: the Father is God and the Son is God, and "God"
names the one God himself, so the Son is not a second person beside the Father. -/
@[trinityDefs]
def bothGodSoOne : Formula Claim :=
  ⋀ [p .isGodAsIdentity, p .fatherIsGod, p .wordIsGod] ➝ notP .sonIsAnotherThanTheFather

/-- **Bernard's line from identity**: "As God, Jesus is one with the Father in the
sense of identity with the Father." -/
@[trinityDefs]
def identityLine : Line Claim :=
  { name := "Both God, so one person (Bernard)"
  , grounds := [p .isGodAsIdentity, p .fatherIsGod, p .wordIsGod]
  , step := bothGodSoOne
  , delivers := notP .sonIsAnotherThanTheFather
  , inference := some onIdentity }

/-- **The Oneness position, answering**: its case, with Bernard's replies on the
witnesses and the voice, and his reasoning from identity. -/
@[trinityDefs]
def onenessAnswering : ArgumentPackage Claim :=
  { name := "One God, one person, answering (Oneness)"
  , cite := cite
  , premises :=
      caseOf [wordLine, spiritLine, onenessLine, spiritAndManLine, manifestationLine, identityLine]
        [] []
  , conclusion := notP .threePersons
  , conclusionLabel := "the Father, the Son and the Spirit are one person, not three"
  , inferences := [onTheWordsDeity, onTheSpiritsDeity, onTheOneness, onBernardsReplies
                  , onIdentity] }

/-! ### Readings, written down -/

/-- **The supplemented Nicene reading**: every text and every Nicene reading,
"is God" as one essence; none of the rivals' readings. -/
def nicenSupplementedReading : Valuation Claim := fun a =>
  match a with
  | .wordIsAGod | .firstbornIsFirstCreated | .spiritIsGodsForce | .sonIsACreature
  | .wordIsGodsThought | .gloryInGodsPlan | .oneNameIsJesus
  | .twoWitnessesAreSpiritAndMan | .voiceIsAManifestation | .othersRightlyCalledGods
  | .isGodAsIdentity => False
  | _ => True

/-- **The Witnesses' reading, answering**: their readings, the others Scripture
calls "gods" rightly so called, and "is God" as identity. -/
def witnessesAnsweringReading : Valuation Claim := fun a =>
  match a with
  | .wordIsGodByNature | .wordIsUnmade | .spiritLiedToIsGod | .spiritIsAPerson
  | .threeNamedInOneName | .wordIsGodsThought | .gloryInGodsPlan | .oneNameIsJesus
  | .wordIsGod | .spiritIsGod | .threePersons | .triuneGod
  | .aSecondGodIsPolytheism | .firstbornIsOverCreation | .isGodAsOneEssence
  | .twoWitnessesAreSpiritAndMan | .voiceIsAManifestation => False
  | _ => True

/-- **The Oneness reading, answering**: its reading, Bernard's replies, and "is
God" as identity, so the Son not another than the Father. -/
def onenessAnsweringReading : Valuation Claim := fun a =>
  match a with
  | .wordIsAGod | .firstbornIsFirstCreated | .spiritIsGodsForce | .sonIsACreature
  | .wordIsAnotherWithGod | .threeNamedInOneName | .threePersons | .triuneGod
  | .twoWitnessesAreTwoPersons | .voicesAreTwoPersons | .isGodAsOneEssence
  | .sonIsAnotherThanTheFather | .othersRightlyCalledGods => False
  | _ => True

/-! ### What the supplemented positions deliver -/

/-- **The supplemented case still delivers LST's confession, and holds together.**
The confession follows from LST's three lines, as before. The lines added here,
from Tertullian, Athanasius, Basil and Metzger, conclude other things: that the
Son is another than the Father, not a creature and not "a god", and that "is
God" does not mean identity. They answer the rivals' readings; they do not carry
the confession.

What is novel: none of its arguments is new; Augustine, Harner, Tertullian,
Athanasius, Basil, Calvin, Sharp and Metzger made them. The library joins them
in one case. -/
@[headline, proposed]
theorem nicenCase_establishes : Establishes nicenCase := by
  establish [trinityDefs]

#print axioms nicenCase_establishes

/-- The supplemented Nicene case can be held without contradiction. -/
theorem nicenCase_is_satisfiable : Satisfiable nicenCase.premises := by
  satisfied_by nicenSupplementedReading [trinityDefs]

/-- **The Witnesses, answering, still deliver their conclusion.** -/
@[headline]
theorem witnessesAnswering_establishes : Establishes witnessesAnswering := by
  establish [trinityDefs]

#print axioms witnessesAnswering_establishes

/-- The Witnesses' position, answering, can be held without contradiction. -/
theorem witnessesAnswering_is_satisfiable : Satisfiable witnessesAnswering.premises := by
  satisfied_by witnessesAnsweringReading [trinityDefs]

/-- **The Oneness position, answering, still delivers its conclusion.** -/
@[headline]
theorem onenessAnswering_establishes : Establishes onenessAnswering := by
  establish [trinityDefs]

#print axioms onenessAnswering_establishes

/-- The Oneness position, answering, can be held without contradiction. -/
theorem onenessAnswering_is_satisfiable : Satisfiable onenessAnswering.premises := by
  satisfied_by onenessAnsweringReading [trinityDefs]


/-! ### Does "each is God, and they are two" hold together? -/

/-- The three claims a reader may think cannot be held at once: the Father is God,
the Son is God, and the Son is another than the Father. -/
@[trinityDefs]
def threeClaims : List (Formula Claim) :=
  [p .fatherIsGod, p .wordIsGod, p .sonIsAnotherThanTheFather]

/-- **The three claims contradict one another only with the identity step added.**
Written as three separate claims (the Father is God, the Son is God, the Son is
another than the Father), they can all be true at once, and they stay so with
Basil's reading added, which rules out reading "is God" as identity.

What this does not claim: that the one-essence reading is right, or that it does
more here than exclude the identity step. The check does not model what
"essence" and "person" mean; that analysis is not yet done.

What is novel: Basil's distinction is old; the check is the library's. -/
@[headline, proposed]
theorem three_claims_hold_on_one_essence :
    Satisfiable (threeClaims ++ [p .isGodAsOneEssence, essenceExcludesIdentity]) := by
  satisfied_by nicenSupplementedReading [trinityDefs]

#print axioms three_claims_hold_on_one_essence

/-- **With Bernard's step from identity, they cannot all be held.** Read "is God"
as Bernard does, as naming the one God himself, take his step that two who are
each the one God are the same person, and grant that the Father and the Son are
both God: then the Son is not a second person beside the Father. So whoever takes
that step must give up one of the three claims, and Bernard gives up the third:
Jesus, as God, is "the Father manifested in flesh". The Witnesses take a step of
their own from the same reading, from "with God" to "not God", and give up the
second; that step is not part of this check.

What this does not claim: that the step is wrong, or that Bernard errs in
drawing what he draws from it. The step is rated `disputed`, because Aquinas
grants that each person is the one God himself and denies that they are
therefore one person (Aquinas, *Summa Theologiae*, part I, question 28, article
3, reply to the first objection).

What is novel: that both rivals reason from the identity reading is the
library's reading of their words; this check covers Bernard's step. -/
@[headline, proposed]
theorem three_claims_fail_on_identity :
    ¬ Satisfiable (threeClaims ++ [p .isGodAsIdentity, bothGodSoOne]) :=
  not_satisfiable_of_check (by decide +kernel)

#print axioms three_claims_fail_on_identity


/-! ### What an opponent must reject -/

/-- The case that the Son is God can be held without contradiction. -/
theorem sonIsGodCase_is_satisfiable : Satisfiable sonIsGodCase.premises := by
  satisfied_by nicenSupplementedReading [trinityDefs]

/-- **The opponent's burden against "the Son is God".** The case runs by six
routes: John 1:1 and 1:3 read with Harner and Augustine, Thomas's words, Hebrews
1:8, Titus 2:13, Romans 9:5, and Philippians 2:10–11 read with Isaiah 45:23.
Every text is granted, so what an opponent can reject is a reading, and there is
exactly one way to overturn the case: reject all six. No smaller set does it, and
no other set does it.

It shows how much a reader must deny to hold that the Son is not God, given these
texts: the reading of every one of them. The Witnesses do deny each, with a
rendering of their own, cited at each step: "a god", "like 'a god'", "God is
your throne", "the great God and of our Savior", "God, who is over all, be
praised", and honour given "to the glory of God the Father". It does not show
that any of those renderings is wrong. Each route's reading is rated `disputed`,
and the weighing ranks a case by its weakest reading, so six routes weigh there
no more than one; the breadth raises the burden instead.

What is novel: each route is old. The proof that each carries the conclusion on
its own, so that an opponent must reject all of them, is the library's. -/
@[headline, proposed]
theorem son_is_god_burden :
    OpponentsBurden sonIsGodCase sonIsGodRoutes [] [] [[0, 1, 2, 3, 4, 5]] :=
  .of_check rfl (by decide +kernel)

#print axioms son_is_god_burden


/-! ### The supplemented positions weighed -/

/-- The supplemented Nicene case's weakest link is `disputed`. -/
theorem nicenCase_strength : nicenCase.strength = 1 := by decide +kernel

/-- So is the six-route case's. -/
theorem sonIsGodCase_strength : sonIsGodCase.strength = 1 := by decide +kernel

/-- So is the Witnesses', answering. -/
theorem witnessesAnswering_strength : witnessesAnswering.strength = 1 := by decide +kernel

/-- So is the Oneness position's, answering. -/
theorem onenessAnswering_strength : onenessAnswering.strength = 1 := by decide +kernel

/-- So is LST's. -/
theorem lstDeityCase_strength : lstDeityCase.strength = 1 := by decide +kernel

open Testimony.Logic.Framework in
/-- The parties to the weighing of the supplemented positions. -/
inductive CaseParty
  /-- LST's own case, as the earlier chapter weighs it. -/
  | lst
  /-- The Nicene case, supplemented: LST's lines and the lines this chapter adds. -/
  | nicene
  /-- That the Son is God, by its six routes alone. -/
  | sonIsGod
  /-- The Witnesses, with their replies. -/
  | witnesses
  /-- Oneness, with Bernard's replies. -/
  | oneness
deriving DecidableEq

/-- The package each party argues from. -/
@[trinityDefs]
def casePartyNode : CaseParty → ArgumentPackage Claim
  | .lst => lstDeityCase
  | .nicene => nicenCase
  | .sonIsGod => sonIsGodCase
  | .witnesses => witnessesAnswering
  | .oneness => onenessAnswering

/-- The weighing of the supplemented positions: every party can be held without
contradiction, delivers its conclusion, and has its steps rated. -/
declare_dispute caseDispute := casePartyNode using trinityDefs
  /-- **Who defeats whom**, all 25 pairs, each checked by Lean. The Witnesses
  defeat each other party and are defeated by each. Oneness and the two
  Trinitarian cases defeat each other over the persons. Neither Oneness nor the
  six-route case defeats the other, because Oneness holds that the Son is God. -/
  defeats
    [ (.lst, .witnesses), (.witnesses, .lst), (.lst, .oneness), (.oneness, .lst)
    , (.nicene, .witnesses), (.witnesses, .nicene), (.nicene, .oneness), (.oneness, .nicene)
    , (.sonIsGod, .witnesses), (.witnesses, .sonIsGod)
    , (.witnesses, .oneness), (.oneness, .witnesses) ]
  /-- **The six routes support the Oneness position**: their conclusion, that the
  Son is God, is a starting point of Bernard's line from identity. Nothing else
  supports anything. Because Oneness uses the Son's deity to argue that he is not
  a second person, the drawing shows the six routes lending weight to Oneness's
  attack on the two Trinitarian cases. That attack is reported, not counted, and
  changes no verdict. Each pair is checked by Lean. -/
  supports [(.sonIsGod, .oneness)]
  /-- **LST's case and the six routes are each part of the Nicene case.** Each
  pair is checked by Lean. -/
  partOf [(.lst, .nicene), (.sonIsGod, .nicene)]
  /-- The supplemented positions drawn: who defeats whom, and whose case is part
  of whose. -/
  map caseMap

/-- Every party is defeated by another. -/
declare_verdict caseSettlesNothing for caseDispute :
    .nothingGrounded
      [ (.lst, .witnesses), (.nicene, .witnesses), (.sonIsGod, .witnesses)
      , (.witnesses, .lst), (.oneness, .lst) ]
  /-- **Supplemented, the weighing still forces nothing.** Every party ties with
  another, and every one rests on a reading rated `disputed`, so no rating breaks
  a tie. Each reading aimed at a rival is answered by that rival with one of its
  own, rated the same, and the Witnesses' renderings of the five added texts are
  cited against each text's step. This is the result whichever side a reader
  hoped for, and it does not say the readings are equally good.

  What is novel: the weighing of these sources against the rivals' cited
  replies. -/
  proves @[headline, proposed] supplemented_forces_nothing

#print axioms supplemented_forces_nothing

/-- The Nicene case, with LST's and the six routes, answers both rivals itself. -/
declare_verdict nicenWithItsParts for caseDispute :
    .credulous .nicene [.lst, .nicene, .sonIsGod]
  /-- **The supplemented Nicene case can be defended**, with LST's case and the six
  routes: the three can be defended together against both rivals.

  What is novel: the supplemented case is the library's assembly. -/
  proves @[headline, proposed] nicene_case_defensible

#print axioms nicene_case_defensible

/-- The Oneness position, with the six routes, can be defended, and leaves the
Nicene case out. -/
declare_verdict nicenAnsweredByOneness for caseDispute :
    .notSkeptical .nicene .oneness [.oneness, .sonIsGod]
  /-- **The supplemented Nicene case is not forced.** The Oneness position and the
  six routes to "the Son is God" can be defended together, and because Oneness
  and the Nicene case defeat each other, no defensible group that holds Oneness
  can hold the Nicene case.

  What is novel: it weighs the library's assembly. -/
  proves @[headline, proposed] nicene_case_not_forced

#print axioms nicene_case_not_forced

/-- The six routes stand with the Oneness position as well as the Nicene. -/
declare_verdict sonIsGodWithOneness for caseDispute :
    .credulous .sonIsGod [.oneness, .sonIsGod]
  /-- **That the Son is God, by six routes, can be defended with Oneness too.** The
  six routes can be defended together with the Oneness position, which also holds
  that the Son is God. Among the parties, only the Witnesses' position defeats
  them.

  What is novel: the six routes are the library's assembly. -/
  proves @[headline, proposed] son_is_god_defensible_with_oneness

#print axioms son_is_god_defensible_with_oneness

/-- The Witnesses' position, on its own, leaves the six routes out. -/
declare_verdict sonIsGodAnsweredByTheWitnesses for caseDispute :
    .notSkeptical .sonIsGod .witnesses [.witnesses]
  /-- **That the Son is God is not forced.** The Witnesses' position, answering, can
  be defended on its own, and it denies that the Son is God. Six routes do not
  outweigh it, because each route's reading is rated `disputed`, as each of the
  Witnesses' readings is, and the weighing ranks a position by its weakest
  reading.

  What is novel: it weighs the library's assembly. -/
  proves @[headline, proposed] son_is_god_not_forced

#print axioms son_is_god_not_forced

/-- The Witnesses, answering, answer every attacker themselves. -/
declare_verdict witnessesAnsweringAlone for caseDispute : .credulous .witnesses [.witnesses]
  /-- **The Witnesses' position, answering, can still be defended**, on its own. -/
  proves @[headline] witnesses_answering_defensible

#print axioms witnesses_answering_defensible

end TestimonyArguments.Trinity
