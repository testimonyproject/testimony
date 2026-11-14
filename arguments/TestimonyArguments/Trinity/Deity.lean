import TestimonyArguments.Trinity.Sources
import TestimonyArguments.Meanings.Trinity
import Testimony.Logic.Tactic

/-!
# TestimonyArguments.Trinity.Deity — are the Son and the Spirit God, and three?

When Thomas saw the risen Jesus he answered him, "My Lord and my God!" (John
20:28). John's Gospel opens with the same claim: "In the beginning was the Word,
and the Word was with God, and the Word was God" (John 1:1). Peter tells Ananias,
who had lied "to the Holy Spirit", that he had "not lied to man but to God" (Acts
5:3–4). Ken Kibbey's *Living Systematic Theology* (LST) gathers these texts with
others and confesses: "The Father is God, the Son is God, and the Holy Spirit is
God; they are personally distinct without being separate gods."

That sentence makes two claims, and each has a rival that reads the same verses
otherwise. The first is that the Son and the Spirit are God. Jehovah's Witnesses
deny it. The second is that Father, Son and Spirit are three persons, none of
them the other. Oneness Pentecostals deny that, and they agree with LST against
the Witnesses on the first. So the question divides three ways, and the texts
each side cites are mostly the same texts.

## Three readings of the same verses

The Witnesses' brochure *Should You Believe in the Trinity?* (1989) reads John
1:1 from the Greek. The first "God" in "the Word was with God" has the article,
"the" (τὸν θεόν); the second, in "the Word was God", has none (θεός). "So John
1:1 highlights the quality of the Word, that he was 'divine,' 'godlike,' 'a god,'
but not Almighty God" (p. 27). Their New World Translation renders the clause
"and the Word was a god". Colossians 1:15 calls the Son "the firstborn of all
creation", and the brochure reads it as "Jesus was created by God as the beginning
of God's invisible creations" (p. 14). Of Thomas it offers two readings: "To
Thomas, Jesus was like 'a god'", or the words were an exclamation "spoken to Jesus
but directed to God"; "in either case, Thomas did not think that Jesus was
Almighty God" (p. 29). On "with God" the brochure is on LST's side against the
Oneness reading: "Someone who is 'with' another person cannot be the same as that
other person" (p. 27). The holy spirit is
"God's active force that he uses to accomplish his will", and "personifying the
holy spirit" does not "make it a spirit person" (pp. 21, 23).

Philip Harner's study of the same grammar (1973) reads the clause the other way.
A noun without the article placed before the verb, as θεός is here, is
"primarily qualitative": it says what kind of thing the Word is. "They indicate
that the logos has the nature of theos" (as the New World Translation's reference
edition quotes him). Augustine answers the Arians from John 1:3: "How can it be
that the Word of God was made, when God by the Word made all things? … that by
which all things were made could not be made by itself" (*Tractates on John*
I.11). Calvin reads Acts 5:4 as Peter saying that "he lieth to God who doth lie to
the Holy Ghost. For the divinity of the Holy Ghost is manifestly proved by this
form of speech."

David Bernard's *The Oneness of God* (1983) grants all of that. "Jesus is the one
God" (ch. 4), and the Holy Spirit is God, as "a comparison of Acts 5:3 with 5:4"
shows (ch. 6). What he denies is that "with God" means a second person. "The Word
was not a separate person or a separate god any more than a man's word is a
separate person from him. Rather the Word was the thought, plan, or mind of God"
(ch. 4). When Jesus prays for "the glory that I had with you before the world
existed" (John 17:5), he speaks of "the glory the Son had in the plan of God from
the beginning" (ch. 8). And the "name" of Matthew 28:19 is one name, not three:
"the one name of Matthew 28:19 is Jesus" (ch. 6).

## What is checked

Each verse is a claim of its own, and each reading of it is another, cited to the
reader who holds it and rated `disputed`, the lowest rating, because the other
readers deny it. LST's case has three lines. From John 1:1, 1:3 and 20:28, with
Harner's and Augustine's readings, the Word is God (`wordLine`). From Acts 5:3–4,
with Calvin's reading, the Spirit is God (`spiritLine`). From "with God", the
glory before the world, the Spirit who says "set apart for me" (Acts 13:2), and
the three named in Matthew 28:19, each read as LST reads it, there are three
persons (`personsLine`). Together with the one God of Deuteronomy 6:4, they give
LST's confession (`lstDeity_establishes`). The Witnesses' case gives the Son a
creature and not God (`witnesses_establish`). The Oneness case holds LST's first
two lines and adds its own readings of the "with" texts, and gives one person,
not three (`oneness_establishes`). Each position can be held without
contradiction.

These results say what follows from each set of readings. They do not say which
readings are right, and they do not say that the bare texts, without any reading,
settle the question either way. The next chapter weighs the three positions
against one another.

## What is not heard

Many texts on each side are left out. For the Witnesses: John 14:28, which the
chapter on the order hears; John 17:3, "you, the only true God", which the
brochure cites against Thomas's words; and John 10:34, where Jesus quotes "you
are gods" (Psalm 82:6), from which the brochure argues that the Son "can be and
is 'a god'" (p. 28). For LST: Hebrews 1:8, Titus 2:13, Romans 9:5, and the texts
that apply to Jesus what the Old Testament says of the LORD, Isaiah 45:23 in
Philippians 2:10–11 among them. John 20:28 enters as a text that every party
grants, with no reading of its own: neither of the brochure's two readings of
Thomas's words is a premise here, so what divides the parties over the Son is
carried by their readings of John 1:1, 1:3 and Colossians 1:15. What is found here
is what these verses and these readings carry, and no more.
-/

namespace TestimonyArguments.Trinity

open Testimony

open Testimony Testimony.Bib Testimony.Logic

/-! ### The Word is God -/

/-- From John 1:1, 1:3 and 20:28, read as the Nicene readers read them, to the
Word's being God. -/
@[trinityDefs]
def textsMakeTheWordGod : Formula Claim :=
  ⋀ [ p .oneGod, p .wordWasGod, p .allThingsThroughTheWord, p .thomasMyLordAndMyGod
    , p .wordIsGodByNature, p .wordIsUnmade ] ➝ p .wordIsGod

/-- **The Word is God**: John 1:1 and 1:3 read of the Word's nature and of his
not being made, with Thomas's confession. -/
@[trinityDefs]
def wordLine : Line Claim :=
  { name := "\"The Word was God\": of God's nature, and not made"
  , grounds :=
      [ p .oneGod, p .wordWasGod, p .allThingsThroughTheWord, p .thomasMyLordAndMyGod
      , p .wordIsGodByNature, p .wordIsUnmade ]
  , step := textsMakeTheWordGod
  , delivers := p .wordIsGod
  , inference := some onTheWordsDeity }

/-- From Acts 5:3–4, read as Peter naming the Spirit God, to the Spirit's being
God. -/
@[trinityDefs]
def textsMakeTheSpiritGod : Formula Claim :=
  ⋀ [p .lyingToTheSpirit, p .spiritLiedToIsGod] ➝ p .spiritIsGod

/-- **The Spirit is God**: Ananias lied to the Holy Spirit, and so "not to man
but to God". -/
@[trinityDefs]
def spiritLine : Line Claim :=
  { name := "\"Not to man but to God\": the Spirit is God"
  , grounds := [p .lyingToTheSpirit, p .spiritLiedToIsGod]
  , step := textsMakeTheSpiritGod
  , delivers := p .spiritIsGod
  , inference := some onTheSpiritsDeity }

/-- From the Word with God, the glory before the world, the Spirit who speaks,
and the three names, to three persons. -/
@[trinityDefs]
def textsMakeThreePersons : Formula Claim :=
  ⋀ [ p .wordWithGod, p .gloryBeforeTheWorld, p .spiritSpeaksAsHimself, p .oneNameOfThree
    , p .wordIsAnotherWithGod, p .spiritIsAPerson, p .threeNamedInOneName ] ➝ p .threePersons

/-- **Three persons**: the Word was with God, and shared his glory before the
world; the Spirit speaks as "I"; and the three are named in one name. -/
@[trinityDefs]
def personsLine : Line Claim :=
  { name := "\"With God\", and three named: three persons"
  , grounds :=
      [ p .wordWithGod, p .gloryBeforeTheWorld, p .spiritSpeaksAsHimself, p .oneNameOfThree
      , p .wordIsAnotherWithGod, p .spiritIsAPerson, p .threeNamedInOneName ]
  , step := textsMakeThreePersons
  , delivers := p .threePersons
  , inference := some onThePersons }

/-- LST's confession drawn together: one God, the Word God, the Spirit God, and
three persons. -/
@[trinityDefs]
def confessionDrawnTogether : Formula Claim :=
  ⋀ [p .oneGod, p .wordIsGod, p .spiritIsGod, p .threePersons] ➝ p .triuneGod

/-- **LST's position**: the Word is God, the Spirit is God, and they are three
persons with the Father, one God. -/
@[trinityDefs]
def lstDeityCase : ArgumentPackage Claim :=
  { name := "One God, three persons (LST)"
  , cite := cite
  , premises := caseOf [wordLine, spiritLine, personsLine] [] [confessionDrawnTogether]
  , conclusion := p .triuneGod
  , conclusionLabel := "the Father, the Son and the Spirit are God, three persons and one God"
  , inferences := [onTheWordsDeity, onTheSpiritsDeity, onThePersons, onTheConfession] }

/-- **The Word is God, on its own**: the word line as a position. -/
@[trinityDefs]
def wordCase : ArgumentPackage Claim :=
  wordLine.asPackage cite "the Word who became flesh is God"

/-- **The Spirit is God, on its own.** -/
@[trinityDefs]
def spiritCase : ArgumentPackage Claim :=
  spiritLine.asPackage cite "the Holy Spirit is God"

/-- **Three persons, on its own.** -/
@[trinityDefs]
def personsCase : ArgumentPackage Claim :=
  personsLine.asPackage cite "the Father, the Son and the Spirit are three persons"

/-! ### Jehovah's Witnesses: a god, a creature, and a force -/

/-- The Witnesses' step: "a god", and "firstborn" as first created, make the Son
a creature. -/
@[trinityDefs]
def aGodAndFirstbornMakeACreature : Formula Claim :=
  ⋀ [p .wordWasGod, p .firstbornOfAllCreation, p .wordIsAGod, p .firstbornIsFirstCreated]
  ➝ p .sonIsACreature

/-- **The Witnesses' line on the Son.** -/
@[trinityDefs]
def creatureLine : Line Claim :=
  { name := "\"A god\", the firstborn of creation (Jehovah's Witnesses)"
  , grounds :=
      [p .wordWasGod, p .firstbornOfAllCreation, p .wordIsAGod, p .firstbornIsFirstCreated]
  , step := aGodAndFirstbornMakeACreature
  , delivers := p .sonIsACreature
  , inference := some onTheCreature }

/-- A creature is not God. -/
@[trinityDefs]
def creatureIsNotGod : Formula Claim := p .sonIsACreature ➝ notP .wordIsGod

/-- The Witnesses' step: a force is not a person. -/
@[trinityDefs]
def forceIsNoPerson : Formula Claim :=
  ⋀ [p .spiritSpeaksAsHimself, p .spiritIsGodsForce] ➝ notP .spiritIsAPerson

/-- **The Witnesses' line on the Spirit.** -/
@[trinityDefs]
def forceLine : Line Claim :=
  { name := "God's active force, personified (Jehovah's Witnesses)"
  , grounds := [p .spiritSpeaksAsHimself, p .spiritIsGodsForce]
  , step := forceIsNoPerson
  , delivers := notP .spiritIsAPerson
  , inference := some onTheForce }

/-- God's force is not God himself. -/
@[trinityDefs]
def forceIsNotGod : Formula Claim := p .spiritIsGodsForce ➝ notP .spiritIsGod

/-- **The Witnesses' position**: the Son a creature, and so not God; the holy
spirit God's force, and so neither a person nor God. -/
@[trinityDefs]
def witnessesCase : ArgumentPackage Claim :=
  { name := "A god, not God; a force, not a person (Jehovah's Witnesses)"
  , cite := cite
  , premises :=
      caseOf [creatureLine, forceLine]
        [p .thomasMyLordAndMyGod, p .lyingToTheSpirit, p .wordWithGod
        , p .wordIsAnotherWithGod]
        [creatureIsNotGod, forceIsNotGod]
  , conclusion := notP .wordIsGod
  , conclusionLabel := "the Son is a creature, and not God"
  , inferences := [onTheCreature, onTheForce, onCreatureNotGod, onForceNotGod] }

/-! ### Oneness: one God, one person -/

/-- The Oneness step: the Word God's thought, the glory in his plan, and the one
name Jesus, so not three persons. -/
@[trinityDefs]
def onePersonUnderThreeTitles : Formula Claim :=
  ⋀ [ p .wordWithGod, p .gloryBeforeTheWorld, p .oneNameOfThree
    , p .wordIsGodsThought, p .gloryInGodsPlan, p .oneNameIsJesus ] ➝ notP .threePersons

/-- **The Oneness line.** -/
@[trinityDefs]
def onenessLine : Line Claim :=
  { name := "God's Word, God's plan, and the one name (Oneness)"
  , grounds :=
      [ p .wordWithGod, p .gloryBeforeTheWorld, p .oneNameOfThree
      , p .wordIsGodsThought, p .gloryInGodsPlan, p .oneNameIsJesus ]
  , step := onePersonUnderThreeTitles
  , delivers := notP .threePersons
  , inference := some onTheOneness }

/-- **The Oneness position**: the Word is God and the Spirit is God, as LST
holds, and they are one person with the Father, not three. -/
@[trinityDefs]
def onenessCase : ArgumentPackage Claim :=
  { name := "One God, one person (Oneness)"
  , cite := cite
  , premises := caseOf [wordLine, spiritLine, onenessLine] [] []
  , conclusion := notP .threePersons
  , conclusionLabel := "the Father, the Son and the Spirit are one person, not three"
  , inferences := [onTheWordsDeity, onTheSpiritsDeity, onTheOneness] }

/-! ### Readings, written down -/

/-- **The Nicene reading**: every text, every Nicene reading, and the
confession; none of the Witnesses' readings or the Oneness ones. -/
def nicenReading : Valuation Claim := fun a =>
  match a with
  | .wordIsAGod | .firstbornIsFirstCreated | .spiritIsGodsForce | .sonIsACreature
  | .wordIsGodsThought | .gloryInGodsPlan | .oneNameIsJesus => False
  | _ => True

/-- **The Witnesses' reading**: every text, "a god", the firstborn first created,
the spirit a force; the Son a creature and not God, the spirit neither a person
nor God. None of the Nicene readings, none of the Oneness ones, and not three
persons. -/
def witnessesReading : Valuation Claim := fun a =>
  match a with
  | .wordIsGodByNature | .wordIsUnmade | .spiritLiedToIsGod | .spiritIsAPerson
  | .threeNamedInOneName
  | .wordIsGodsThought | .gloryInGodsPlan | .oneNameIsJesus
  | .wordIsGod | .spiritIsGod | .threePersons | .triuneGod => False
  | _ => True

/-- **The Oneness reading**: every text, the Nicene readings of John 1:1c, 1:3
and Acts 5, the Word and the Spirit God; the Oneness readings, and not three
persons. -/
def onenessReading : Valuation Claim := fun a =>
  match a with
  | .wordIsAGod | .firstbornIsFirstCreated | .spiritIsGodsForce | .sonIsACreature
  | .wordIsAnotherWithGod | .threeNamedInOneName | .threePersons | .triuneGod => False
  | _ => True

/-! ### What each position delivers -/

/-- **Grant the Nicene readings of John 1:1 and 1:3, of Acts 5:3–4, and of the
texts that name three, and LST's confession follows**: the Father, the Son and
the Spirit are God, three persons and one God. -/
@[headline]
theorem lstDeity_establishes : Establishes lstDeityCase := by
  establish [trinityDefs]

#print axioms lstDeity_establishes

/-- LST's position can be held without contradiction. -/
theorem lstDeityCase_is_satisfiable : Satisfiable lstDeityCase.premises := by
  satisfied_by nicenReading [trinityDefs]

/-- **Grant John 1:1c read as "a god" and Colossians 1:15 as the first thing
made, and the Son is a creature, not God.** -/
@[headline]
theorem witnesses_establish : Establishes witnessesCase := by
  establish [trinityDefs]

#print axioms witnesses_establish

/-- The Witnesses' position can be held without contradiction. -/
theorem witnessesCase_is_satisfiable : Satisfiable witnessesCase.premises := by
  satisfied_by witnessesReading [trinityDefs]

/-- **Grant the Oneness readings of John 1:1, 17:5 and Matthew 28:19, and the
Father, the Son and the Spirit are one person.** -/
@[headline]
theorem oneness_establishes : Establishes onenessCase := by
  establish [trinityDefs]

#print axioms oneness_establishes

/-- The Oneness position can be held without contradiction. -/
theorem onenessCase_is_satisfiable : Satisfiable onenessCase.premises := by
  satisfied_by onenessReading [trinityDefs]

/-- Each of LST's lines, on its own, can be held without contradiction. -/
theorem wordCase_is_satisfiable : Satisfiable wordCase.premises := by
  satisfied_by nicenReading [trinityDefs]

/-- The Spirit line can be held without contradiction. -/
theorem spiritCase_is_satisfiable : Satisfiable spiritCase.premises := by
  satisfied_by nicenReading [trinityDefs]

/-- The line of three persons can be held without contradiction. -/
theorem personsCase_is_satisfiable : Satisfiable personsCase.premises := by
  satisfied_by nicenReading [trinityDefs]

/-- The Word line delivers what it says. -/
theorem wordCase_establishes : Establishes wordCase := by
  establish [trinityDefs]

/-- The Spirit line delivers what it says. -/
theorem spiritCase_establishes : Establishes spiritCase := by
  establish [trinityDefs]

/-- The line of three persons delivers what it says. -/
theorem personsCase_establishes : Establishes personsCase := by
  establish [trinityDefs]

end TestimonyArguments.Trinity
