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
deriving DecidableEq, Repr

end TestimonyArguments.Trinity
