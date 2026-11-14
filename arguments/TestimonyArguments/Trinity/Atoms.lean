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
deriving DecidableEq, Repr

end TestimonyArguments.Trinity
