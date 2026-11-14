import TestimonyArguments.Attr
import Testimony.Logic.Line
import Testimony.Scripture

/-!
# TestimonyArguments.Trinity.Atoms — the atomic claims

The texts every party reads, the readings each party gives them, and the
conclusion that divides them. The texts are kept apart from the readings, so
that a reader can see which claims are what John, Paul and Luke say, and which
are what a tradition says they mean.
-/

namespace TestimonyArguments.Trinity

open Testimony

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- John 15:26: "the Spirit of truth, who proceeds from the Father". -/
  | john15_26ProceedsFromTheFather
  /-- The Son sends the Spirit: "whom I will send to you from the Father" (John
  15:26); "if I go, I will send him to you" (John 16:7). -/
  | sonSendsTheSpirit
  /-- The Spirit is named for the Son: "God has sent the Spirit of his Son into
  our hearts" (Galatians 4:6); "the Spirit of Christ" (Romans 8:9). -/
  | spiritOfTheSon
  /-- Acts 2:33: the exalted Son, "having received from the Father the promise
  of the Holy Spirit", has poured him out. -/
  | acts2_33SonPoursOutTheSpirit
  /-- John 16:14: "He will glorify me, for he will take what is mine and declare
  it to you." LST does not cite it; Aquinas rests on it. -/
  | john16_14TakesWhatIsTheSons
  /-- **What every party grants.** The Spirit is related to the Son as well as to
  the Father, as his sending by the Son and his name, "Spirit of the Son", show.
  LST says the texts establish "a real relation of the Spirit to both Father and
  Son". The claim here leaves open what kind of relation it is: in Aquinas's
  vocabulary a "real relation" in God is a relation of origin, and read that way
  the claim would be the Filioque itself. -/
  | spiritRelatedToBoth
  /-- **The Western reading of John 16:14.** "He will take what is mine" speaks
  of what the Spirit has from the Son, and so of where he is from, not only of
  what he makes known. Aquinas: "although we do not find it verbally expressed
  in Holy Scripture that the Holy Ghost proceeds from the Son, still we do find
  it in the sense of Scripture". -/
  | receivingIsOrigin
  /-- **The Western reading of the Son's sending.** The Son's sending of the
  Spirit, and the Spirit's name "Spirit of the Son", rest on an eternal relation
  of the Spirit to the Son, and are not a mission in time only. Augustine:
  "to be sent is to be known to proceed" (*On the Trinity* IV.20.29). Some
  Orthodox readers grant this much too, and deny that the relation is one of
  origin. -/
  | missionRevealsEternalRelation
  /-- The Son and the Spirit are two persons, not one: Jesus calls the Spirit
  "another Helper" (John 14:16). -/
  | sonAndSpiritDistinct
  /-- **The Western reading from distinction.** The divine persons are distinguished from
  one another only by opposed relations of origin, so two persons with no
  relation of origin between them would not be distinct. Aquinas. -/
  | distinctOnlyByOpposedRelations
  /-- The Son is not from the Spirit. Aquinas's argument from distinction needs
  it and does not argue it: "either the Son is from the Holy Ghost; which no one
  says; or that the Holy Ghost is from the Son". No party here holds otherwise. -/
  | sonNotFromTheSpirit
  /-- **The reading of John 15:26 as eternal origin.** "Who proceeds from the
  Father" (ἐκπορεύεται) speaks of where the Spirit is from eternally, not only of
  his being sent in time. Photius and Ware read it so, and so does Aquinas. LST
  says the texts do not settle it. -/
  | john15_26SpeaksOfEternalOrigin
  /-- **The first Eastern reading.** In John 15:26 Jesus names the source the
  Spirit proceeds from, the Father, and names no other. What the Lord did not
  add may not be added. Photius. -/
  | john15_26NamesTheWholeSource
  /-- **The second Eastern reading: the monarchy of the Father.** Within the
  Godhead the Father is the one cause of the Son and of the Spirit. If the Spirit
  were from the Son as well, there would be two causes. Photius; Ware. -/
  | monarchyOfTheFather
  /-- **The Filioque.** The Spirit proceeds eternally from the Father and the
  Son, as from one principle. Rome confesses it (Florence, *Laetentur caeli*)
  and so do the Reformed (Westminster II.3). It is cited to Florence, the earlier
  definition, and tagged with Rome's tradition, because a citation carries one
  tradition. -/
  | filioque
  /-- John 5:19, 30: "the Son can do nothing of his own accord, but only what he
  sees the Father doing"; "I seek not my own will but the will of him who sent
  me." -/
  | sonDoesNothingOfHimself
  /-- John 14:28: "the Father is greater than I." -/
  | fatherIsGreater
  /-- John 20:17: the risen Jesus says, "I am ascending to my Father and your
  Father, to my God and your God." -/
  | fatherIsGodOfTheRisenSon
  /-- 1 Corinthians 11:3: "the head of Christ is God." -/
  | headOfChristIsGod
  /-- 1 Corinthians 15:28: "the Son himself will also be subjected to him who put
  all things in subjection under him, that God may be all in all." -/
  | sonSubjectAtTheEnd
  /-- Philippians 2:6: Christ Jesus, "though he was in the form of God, did not
  count equality with God a thing to be grasped." -/
  | sonInTheFormOfGod
  /-- **What every party grants.** There is a real order between the Father and
  the Son in the work of salvation: the Father sends, and the Son is sent, obeys,
  and at the end is subject. LST: "real personal and mediatorial order". The
  claim leaves open whether Father and Son are two persons, which is LST's next
  question; a modalist reads them as the deity and the humanity of one. -/
  | realOrder
  /-- **The Arian reading of John 14:28.** "Greater" means that the Son is less
  than the Father in his divinity. The creed of Sirmium (357), of the party after
  Arius that held the Son a creature or unlike the Father, says the Father is
  "greater in honour and dignity and Godhead … the Son Himself testifying, 'The
  Father that sent Me is greater than I'" (Athanasius, *De Synodis* 28). Augustine
  and Calvin report the same use of the verse, and deny it. -/
  | greaterMeansLesserDivinity
  /-- **Augustine's reading of John 14:28.** The verse speaks of the Son as less
  than the Father in the form of a servant which he took, not in the form of God,
  in which he is equal (Philippians 2:6–7): "equal to God the Father in nature,
  but less in fashion" (*On the Trinity* I.7.14). Calvin denies this reading of
  the verse, not the two forms themselves. -/
  | lessInTheFormOfAServant
  /-- **Athanasius's reading of John 14:28.** The Father is "greater" as the one
  the Son is begotten from, "not indeed in greatness, nor in time"; so the word
  "shows that He is proper to His essence" (*Against the Arians* I.58). -/
  | greaterAsBegetter
  /-- **Calvin's reading of John 14:28.** Christ compares his present humbled
  state as Mediator with the heavenly glory he is going to, and "does not now
  speak either of his human nature, or of his eternal Divinity". -/
  | greaterAsMediatorsState
  /-- **The reading of the order as eternal.** The Father's sending and the Son's
  obedience are the outworking of an eternal relationship of authority and
  submission between them. Grudem; Ware. -/
  | orderIsEternal
  /-- The Son is equal to the Father in power: the three persons are "of one
  substance, power, and eternity" (Westminster II.3). -/
  | sonEqualInPower
  /-- **Giles's reading.** To hold the Son eternally subordinate in authority is
  to deny that he is equal in power with the Father. -/
  | subordinationDeniesEqualPower
  /-- **The Arian conclusion.** The Son is less than the Father in his divinity.
  Arius: "the Son has a beginning, but … God is without beginning." -/
  | sonLesserInDivinity
  /-- **The conclusion Grudem and Ware draw.** There is an eternal relationship of
  authority and submission between the Father and the Son, as the persons are,
  not only in the work of salvation. -/
  | eternalAuthorityAndSubmission
  /-- There is one God: "Hear, O Israel: The LORD our God, the LORD is one"
  (Deuteronomy 6:4); "there is no God but one" (1 Corinthians 8:4). -/
  | oneGod
  /-- John 1:1: "In the beginning was the Word, and the Word was with God". -/
  | wordWithGod
  /-- John 1:1: "and the Word was God" (καὶ θεὸς ἦν ὁ λόγος). The Greek word for
  God, θεός, stands first and has no article. The New World Translation renders
  it "and the Word was a god". -/
  | wordWasGod
  /-- John 1:3: "All things were made through him, and without him was not any
  thing made that was made." -/
  | allThingsThroughTheWord
  /-- John 20:28: "Thomas answered him, 'My Lord and my God!'" -/
  | thomasMyLordAndMyGod
  /-- Acts 5:3–4: "Ananias, why has Satan filled your heart to lie to the Holy
  Spirit …? You have not lied to man but to God." -/
  | lyingToTheSpirit
  /-- The Spirit speaks of himself as "I" and can be grieved: "the Holy Spirit
  said, 'Set apart for me Barnabas and Saul for the work to which I have called
  them'" (Acts 13:2); "do not grieve the Holy Spirit of God" (Ephesians 4:30). -/
  | spiritSpeaksAsHimself
  /-- John 17:5: "Father, glorify me in your own presence with the glory that I
  had with you before the world existed." -/
  | gloryBeforeTheWorld
  /-- Matthew 28:19: "baptizing them in the name of the Father and of the Son and
  of the Holy Spirit". -/
  | oneNameOfThree
  /-- Colossians 1:15: the Son "is the image of the invisible God, the firstborn
  of all creation." -/
  | firstbornOfAllCreation
  /-- **The Nicene reading of "the Word was God" (John 1:1).** "Nicene", here and
  below, is named for the creed of Nicaea (325), which confessed the Son of one
  being with the Father. God (θεός), without "the", says what the Word is: he has
  the nature of the one God. Harner: "the logos [the Word] has the nature of theos
  [God]" (as the New World Translation's reference edition quotes him). -/
  | wordIsGodByNature
  /-- **The Nicene reading of John 1:3.** Everything that was made was made through
  the Word, so the Word himself is not among the things made. Augustine: "that by
  which all things were made could not be made by itself". -/
  | wordIsUnmade
  /-- **The Nicene reading of Acts 5:3–4.** Peter names the Spirit that Ananias
  lied to as God: to lie to the Holy Spirit is to lie, "not to man but to God".
  Calvin: "the divinity of the Holy Ghost is manifestly proved by this form of
  speech". -/
  | spiritLiedToIsGod
  /-- **The Nicene reading of the Spirit's speech.** The Spirit who says "set apart
  for me" and can be grieved is a person, not a power or a force. -/
  | spiritIsAPerson
  /-- **The Nicene reading of John 1:1 and 17:5.** "With God" and "the glory that
  I had with you" speak of one person beside another before the world was made,
  not of a thought or a plan in God's mind. -/
  | wordIsAnotherWithGod
  /-- **The Nicene reading of Matthew 28:19.** Three are named, the Father, the
  Son and the Holy Spirit, and the one "name" is theirs together. -/
  | threeNamedInOneName
  /-- **The Witnesses' reading of "the Word was God" (John 1:1).** God (θεός),
  without "the", means "a god": the Word is "'divine,' 'godlike,' 'a god,' but not
  Almighty God" (*Should You Believe in the Trinity?*). -/
  | wordIsAGod
  /-- **The Witnesses' reading of Colossians 1:15.** "Firstborn of all creation"
  means that the Son is the first thing God created, through whom he made all
  other things: "Jesus was created by God as the beginning of God's invisible
  creations". The New World Translation renders Colossians 1:16 "all other
  things were created". -/
  | firstbornIsFirstCreated
  /-- **The Witnesses' reading of the Spirit.** The holy spirit is God's active
  force, not a person; where Scripture has it speak or be grieved, it is
  personified: "nor does personifying the holy spirit make it a spirit
  person". -/
  | spiritIsGodsForce
  /-- **The Oneness reading of John 1:1.** The Word is God's own thought and
  self-expression, "with God" as a man's word is with him, and not a second
  person beside him. Bernard: "the Word was the thought, plan, or mind of
  God". -/
  | wordIsGodsThought
  /-- **The Oneness reading of John 17:5.** The glory the Son "had with" the
  Father before the world was his in God's plan and foreknowledge, not the glory
  of a second person then present. -/
  | gloryInGodsPlan
  /-- **The Oneness reading of Matthew 28:19.** "The name" is singular, and it is
  the name of Jesus, in which the apostles then baptized (Acts 2:38). Father, Son
  and Holy Spirit are titles of the one God, not names of three persons. -/
  | oneNameIsJesus
  /-- **What LST, and the Oneness believers with it, conclude of the Word.** The
  Word who became flesh in Jesus (John 1:14) is God: of the nature of the one
  God, and not created. -/
  | wordIsGod
  /-- **What LST, and the Oneness believers with it, conclude of the Spirit.** The
  Holy Spirit is God. -/
  | spiritIsGod
  /-- **What LST concludes of the persons.** The Father, the Son and the Holy
  Spirit are three persons, none of them the other. -/
  | threePersons
  /-- **The Witnesses' conclusion.** The Son is a creature, the first and greatest
  of God's works, and so is not God. -/
  | sonIsACreature
  /-- **LST's confession.** "The Father is God, the Son is God, and the Holy
  Spirit is God; they are personally distinct without being separate gods." -/
  | triuneGod
deriving DecidableEq, Repr

end TestimonyArguments.Trinity
