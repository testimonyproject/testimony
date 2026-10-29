import TestimonyArguments.BornOfAVirgin.Atoms

/-!
# TestimonyArguments.BornOfAVirgin.Sources.Genesis — the citations of the dispute over "her seed"

The atoms of the dispute over what the wording of Genesis 3:15 says about a
father: whether "her seed" signifies a birth without one, or fits such a birth
once it has happened, what else might explain the wording, and what the Greek's
"he" adds. Cited here and dispatched from `cite` by name, for the reason
`Sources.Wegner` gives.

Luther, Leupold, Keil and Calvin are cited from their commentaries, Lewis and
Collins from their articles, Henry by passage, and Akin from the publisher's
site. Martin is cited whole: the library has not read his article, and quotes
him only as Collins does.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- `wordingSignifiesAFatherlessBirth`. Luther makes the argument from the
wording: "Thus women continued to bring forth until the Flood; and afterwards
also, until the time of Mary. But the seed of none of those women could truly be
said to be the Seed of the woman, but might rather be said to have been the seed
of the man. But that which was born from Mary was conceived of the Holy Ghost
and was the true Seed of Mary" (*Luther on the Creation* 298–99). Henry: "He was
likewise to be the seed of a woman only, of a virgin" (on 3:15). Akin finds in
the wording "a hint of the Virgin Birth".

Luther finds the sense in the words of Genesis, and holds that Isaiah later
"threw some additional light upon this glorious promise ... For it was then made
certain that this Seed would not be born from the union of a man and a woman"
(298). Irenaeus reads the verse of the Virgin's son, "He who should be born of a
woman, [namely] from the Virgin" (*Against Heresies* V.21.1), though he does not
argue from the wording.

`disputed`: Leupold and Keil, who read the verse as the promise of Christ, deny
that the wording says this (`posterityLine`); Calvin gives both of their grounds
(170) without discussing the point; and Lewis denies it from what Genesis says
of Hagar and Rebekah (`idiomLine`). -/
def wordingSignifiesAFatherlessBirthCited : AtomMeta :=
  { label := "The wording 'her seed' itself signifies a birth with no human father"
  , kind := .interpretive
  , source :=
      { primary := .work lutherOnTheCreation (.pages 298 299)
      , supporting :=
          [ .work henryCommentary (.adLoc genesis3_15)
          , .work akinWomanSeedSerpent .whole ]
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- `wordingFitsAFatherlessBirth`. Leupold, asked whether the expression is "so
phrased in reference to Mary and the virgin birth": "Not primarily, but at least
incidentally"; "an expression is chosen that meets with literal fulfilment in
Him who is virgin born and not of the seed of man.
Yet we prefer to state the case thus: the expression used does not specifically
prophesy the virgin birth, but it coincides and agrees with it under divine
providence" (169). Keil: "in the fact that the destroyer of the serpent was born
of a woman (without a human father) they were fulfilled in a way which showed
that the promise must have proceeded from that Being, who secured its
fulfilment not only in its essential force, but even in its apparently casual
form" (102).

`disputed`, because it presupposes the virginal conception, which this argument
rates `disputed` (`maryConceivedAsVirgin`). Among readers who grant that
conception, none found denies the fit: Leupold and Keil, who deny that the
wording signifies it, grant this. -/
def wordingFitsAFatherlessBirthCited : AtomMeta :=
  { label := "The wording 'her seed' fits a birth with no human father, as fulfilled in Christ"
  , kind := .interpretive
  , source :=
      { primary := .work leupoldGenesis (.page 169)
      , supporting := [.work keilDelitzschPentateuch (.page 102)]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- `seedIsHerPosterityFirst`. Leupold: "the expression 'her seed' in its first
meaning is a collective noun and includes all who are enrolled in the struggle
against Satan, without being themselves virgin born" (169) — not every
descendant, for "within the circle of the broadest possible meaning of zéra' must
be drawn a circle quite a bit smaller" (167). Calvin: "for who will concede that
a collective noun is to be understood of one man only? ... I explain, therefore,
the seed to mean the posterity of the woman generally" (170). Keil: "It does not
follow from this, however, apart from other considerations, that by the seed of
the woman we are to understand one solitary person, one individual only" (101).

`disputed`. Collins argues that the Hebrew's syntax is "quite consistent with the
pattern where a single individual is in view" (145), and that on a "bottom-up"
reading of the final form "it would be fair to read this as God's threat to the
snake, of an individual who will engage the snake in combat and win" (146). -/
def seedIsHerPosterityFirstCited : AtomMeta :=
  { label := "'Her seed' at Genesis 3:15 is first collective: her posterity, not one person"
  , kind := .interpretive
  , source :=
      { primary := .work leupoldGenesis (.pages 167 169)
      , supporting :=
          [ .work calvinGenesis (.page 170)
          , .work keilDelitzschPentateuch (.page 101)
          , .work collinsSyntacticalNote (.pages 145 146) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- `womanNamedForTheDeception`. Leupold: "The woman, as one factor in the
enmity, is stressed to the exclusion of man because the woman was beguiled"
(165); "the one tempted and brought to fall is chosen by God to produce the one
that is to bring Satan to fall" (169). Calvin: "He mentions the woman on this
account, because, as she had yielded to the subtlety of the devil, and being
first deceived, had drawn her husband into the participation of her ruin, so she
had peculiar need of consolation" (170). Henry: "God does the woman the honour to
call him rather her seed, because she it was whom the devil had beguiled". Keil
allows it — "even if the words had reference first of all to the fact that the
woman had been led astray by the serpent" — and gives his own reason in the same
key: "as it was through the woman that the craft of the devil brought sin and
death into the world, so it is also through the woman that the grace of God will
give to the fallen human race the conqueror" (102).

`wellSupported`: Lutheran, Reformed and Puritan readers give it, Henry among
them, who also holds that the wording signifies a birth from a virgin. No reader
found denies it. -/
def womanNamedForTheDeceptionCited : AtomMeta :=
  { label := "The seed is called the woman's because the serpent deceived the woman"
  , kind := .interpretive
  , source :=
      { primary := .work leupoldGenesis (.page 165)
      , supporting :=
          [ .work leupoldGenesis (.page 169)
          , .work calvinGenesis (.page 170)
          , .work henryCommentary (.adLoc genesis3_15)
          , .work keilDelitzschPentateuch (.page 102) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .wellSupported } }

/-- `womansSeedSaidOfOrdinaryBirths`. What the Hebrew reads: the angel promises
Hagar that her seed, זַרְעֵךְ, will be multiplied (Genesis 16:10), and Rebekah's
family blesses her seed, זַרְעֵךְ, to possess the gate of its enemies (24:60).
Each seed has a father named, Abraham and Isaac. Lewis: "While it is normal in
Hebrew to describe descendants by the noun zeraʿ, it is unusual (though not
unique) to use the term with a feminine possessive pronoun" (299). Scripture
alone, and legitimately so: the claim is about what the text reads. -/
def womansSeedSaidOfOrdinaryBirthsCited : AtomMeta :=
  { label := "Genesis speaks of a woman's seed in ordinary births: Hagar's and Rebekah's"
  , kind := .textual
  , source :=
      { primary := .scripture womensSeedInGenesis
      , supporting := [.work lewisWomansSeed (.pages 299 300)]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `lxxCallsTheSeedHe`. What the Greek reads, from Rahlfs's text: καὶ ἀνὰ μέσον
τοῦ σπέρματος αὐτῆς· αὐτός σου τηρήσει κεφαλήν, "and between her seed: he will
watch for your head". The pronoun αὐτός is masculine, and σπέρμα is neuter.
Collins: "The mismatch in gender between pronoun and antecedent is held to be
evidence that the LXX translator saw this as a prophecy of a specific
individual" (141). `consensus`: no one denies the reading. -/
def lxxCallsTheSeedHeCited : AtomMeta :=
  { label := "The Greek of Genesis 3:15 calls the woman's seed 'he', though σπέρμα is neuter"
  , kind := .textual
  , source :=
      { primary := .scripture [verseIn .septuagint genesis3_15]
      , supporting := [.work collinsSyntacticalNote (.page 141)]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `lxxReadsOneDescendant`. Collins: "The evidence of the Greek translators
makes it beyond question that the translator of Genesis 3:15 meant to convey
that an individual was promised" (145). The reading "is generally acknowledged"
(141), and Martin's article is its usual citation: as Collins quotes him, Martin
calls the Greek "the earliest evidence of an individual messianic
interpretation" (Collins 141 n. 4). Elsewhere the Greek translators use a
masculine pronoun after the neuter σπέρμα when one person is meant: αὐτόν at 1
Samuel 1:11, and ὅς, αὐτός and αὐτόν at 2 Samuel 7:12–14 (Collins 144).

`disputed`, on Philo, the earliest known reader of this Greek. He grants that
it says "he", and reads it as a "barbarism" that is correct in meaning, of the
mind and not of a person: "the woman is not he, but she", and "the mind is
masculine" (*Allegorical Interpretation* III.188). Lewis leaves the question
open: "Sperma is a neuter noun in Greek and would have taken a neuter pronoun had
the translators not thought of an individual", but the masculine "could be an
oversight … it is possible that the translator reveals a messianic
understanding—which, if true, would then be the earliest known" (300). John Day
is reported to call it "simply an over-literal translation of the Hebrew"; his
words could not be read, and he is not counted. The doubt Collins reports is
about the Hebrew, not the Greek (141). -/
def lxxReadsOneDescendantCited : AtomMeta :=
  { label := "The Greek translator of Genesis read the woman's seed at 3:15 as one person"
  , kind := .interpretive
  , source :=
      { primary := .work collinsSyntacticalNote (.page 145)
      , supporting :=
          [ .work collinsSyntacticalNote (.page 144)
          , .work martinEarliestMessianic .whole
          , .work lewisWomansSeed (.page 300)
          , .work philoAllegoricalInterpretation (.sectionRef "III.188") ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-! ### The fulfilment, and the critical reading

What the New Testament says, cited to its text: each is a claim about what a
passage reads, and none about what it means for Genesis. -/

/-- `serpentNamedTheDevil`. "That old serpent, called the Devil, and Satan"
(Revelation 12:9; again at 20:2): ὁ ὄφις ὁ ἀρχαῖος, the serpent of old. Collins
gives these, with John 8:44, as the New Testament's identification of the
serpent (147 n. 21). `consensus`: it is what the text reads. -/
def serpentNamedTheDevilCited : AtomMeta :=
  { label := "Revelation calls the devil 'that old serpent' (12:9, 20:2)"
  , kind := .textual
  , source :=
      { primary := .scripture Testimony.Scripture.serpentNamedTheDevil
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `devilDestroyedThroughDeath`. The Son shared flesh and blood "that through
death he might destroy him that had the power of death, that is, the devil"
(Hebrews 2:14), and "was manifested, that he might destroy the works of the
devil" (1 John 3:8). `consensus`: it is what the texts read. -/
def devilDestroyedThroughDeathCited : AtomMeta :=
  { label := "The Son came to destroy the devil and his works, through death"
  , kind := .textual
  , source :=
      { primary := .scripture Testimony.Scripture.devilDestroyedThroughDeath
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `christDiedAndRose`. Christ "died for our sins", "was buried", and "rose
again the third day" (1 Corinthians 15:3–4). `consensus`: it is what the text
reads; whether it happened is not the claim. -/
def christDiedAndRoseCited : AtomMeta :=
  { label := "Paul says Christ died, was buried, and rose the third day"
  , kind := .textual
  , source :=
      { primary := .scripture Testimony.Scripture.christDiedAndRose
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `sonMadeOfAWoman`. God sent forth his Son, "made of a woman", γενόμενον ἐκ
γυναικός (Galatians 4:4). Whether Paul alludes to Genesis 3:15 here is
disputed: Hamilton reads Jesus as "born of (i.e., the seed of) the woman", after
Wifall (43, 53 n. 89); Lewis holds that it says only "that the Christ became
human" (303). The atom claims only what Paul says. `consensus`. -/
def sonMadeOfAWomanCited : AtomMeta :=
  { label := "Paul says God sent his Son 'made of a woman' (Galatians 4:4)"
  , kind := .textual
  , source :=
      { primary := .scripture Testimony.Scripture.sonMadeOfAWoman
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `jesusFulfilsThePromise`. The fulfilment, as `fulfilmentLine` argues it.
Worded so that it says what Calvin, Keil and Leupold all hold: none of them
takes "her seed" for Christ alone, and each holds that in Christ, as the head of
the woman's seed, the serpent is crushed. `disputed`, as its step is, on
Westermann. -/
def jesusFulfilsThePromiseCited : AtomMeta :=
  { label := "In Jesus the promise of Genesis 3:15 is fulfilled: he crushes the serpent's head"
  , kind := .interpretive
  , source :=
      { primary := .work irenaeusAgainstHeresies (.sectionRef "III.23.7")
      , supporting :=
          [ .work hamiltonSkullCrushingSeed (.pageList [42, 53])
          , .work keilDelitzschPentateuch (.page 102)
          , .work westermannGenesis (.pages 259 261) ]
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- `seedWasOfTheWomanAlone`. The seed in whom the promise is fulfilled had no
human father: Irenaeus reads the verse of "He who should be born of a woman,
[namely] from the Virgin" (V.21.1). `disputed`, as the virginal conception it
rests on is (`maryConceivedAsVirgin`). -/
def seedWasOfTheWomanAloneCited : AtomMeta :=
  { label := "The seed in whom Genesis 3:15 is fulfilled was of the woman alone"
  , kind := .interpretive
  , source :=
      { primary := .work irenaeusAgainstHeresies (.sectionRef "V.21.1")
      , supporting := [.work keilDelitzschPentateuch (.page 102)]
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- `verseIsACurseOnTheSerpent`. "Because thou hast done this, thou art
cursed" (3:14): the words of 3:15 are spoken to the serpent, as part of its
sentence. Westermann classes them as a punishment oracle (260), the form-critical
ground of his denial (`westermannLine`). `wellSupported`: the address and the
curse are the text's; the classification is his, and is not contested by the
readers cited here, who read a promise within the curse. -/
def verseIsACurseOnTheSerpentCited : AtomMeta :=
  { label := "Genesis 3:14–15 is a curse on the serpent, in the form of a punishment oracle"
  , kind := .interpretive
  , source :=
      { primary := .work westermannGenesis (.page 260)
      , supporting := [.scripture [verseIn .masoretic ⟨.genesis, 3, 14⟩]]
      , tradition := .criticalScholarship
      , confidence := .wellSupported } }

/-- `seedIsLineNotIndividual`. Westermann: "The parallelism makes it clear that
'seed' refers to a line of descendants and not to an individual" (259); "it is
beyond doubt that [zeraʿ] is to be understood collectively" (260). Martin holds
the same of the Hebrew, as Collins quotes him: "he" is "indefensible as a
translation", and the right English is "it" or "they", "the descendants of Eve"
(Collins 140 n. 2). The Targums read the verse collectively, of "the sons of the
woman".

Stronger than `seedIsHerPosterityFirst`, which Calvin, Keil and Leupold hold:
they read "her seed" as her posterity first, and Keil and Leupold deny that no
individual is in view. `disputed`: Collins answers Westermann that the woman's
seed "is not unquestionably collective" (147 n. 22); Leupold, that the word "is
also used in reference to an individual and not only in the collective sense"
(168); Alexander, that the seed "must be understood as referring to a single
individual" (363); Hamilton, that "the text switches from a collective referent
to a singular one" (32). `syntaxLine` gives their argument. -/
def seedIsLineNotIndividualCited : AtomMeta :=
  { label := "At Genesis 3:15 'her seed' is a line of descendants, and not an individual"
  , kind := .linguistic
  , source :=
      { primary := .work westermannGenesis (.pages 259 260)
      , supporting :=
          [ .work collinsSyntacticalNote (.pageList [140, 147])
          , .work leupoldGenesis (.page 168)
          , .work alexanderFurtherObservations (.page 363)
          , .work hamiltonSkullCrushingSeed (.page 32) ]
      , tradition := .criticalScholarship
      , confidence := .disputed } }

/-- `seedUsedOfOneDescendant`. What the texts read, as Collins sets them out:
"when zeraʿ denotes a specific descendant, it appears with singular verb
inflections, adjectives, and pronouns" (144) — 2 Samuel 7:12–15, the clearest
parallel (145), Genesis 21:13, 38:9 and 1 Samuel 1:11. Keil grants it: "the
posterity of a man may consist of a whole tribe or of one son only" (101); so
does Leupold (168). `consensus`: no reader found denies the readings. -/
def seedUsedOfOneDescendantCited : AtomMeta :=
  { label := "Elsewhere זֶרַע with singular verbs and pronouns denotes one descendant"
  , kind := .textual
  , source :=
      { primary := .work collinsSyntacticalNote (.pages 144 145)
      , supporting :=
          [ .work keilDelitzschPentateuch (.page 101)
          , .work leupoldGenesis (.page 168) ]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `strikerIsSingular`. What the Hebrew reads at 3:15b: הוּא, "he", masculine
singular, with a singular verb, and the object is the serpent's own head, "your
head", not its seed's. Collins: "it is 'he' … who will bruise 'you' (singular,
i.e., the snake)" (146 n. 21). Keil grants it: "it is not over the seed of the
serpent but over the serpent itself that the victory is said to be gained" (101).
`consensus` for the form. Whether הוּא means "he" or "it" is the question the
readings answer, not the form. -/
def strikerIsSingularCited : AtomMeta :=
  { label := "At Genesis 3:15b the striker is singular 'he', against the serpent's own head"
  , kind := .textual
  , source :=
      { primary := .scripture [verseIn .masoretic genesis3_15]
      , supporting :=
          [ .work collinsSyntacticalNote (.page 146)
          , .work keilDelitzschPentateuch (.page 101) ]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

end TestimonyArguments.BornOfAVirgin
