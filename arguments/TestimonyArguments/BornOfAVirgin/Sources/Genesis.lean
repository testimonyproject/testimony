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

`wellSupported`. The doubt Collins reports is about the Hebrew, not the Greek:
"many feel that the LXX is an interpretation that the Hebrew itself does not
support" (141). Lewis grants the reading — "Sperma is a neuter noun in Greek and
would have taken a neuter pronoun had the translators not thought of an
individual" — and allows that the masculine "could be an oversight" (300). -/
def lxxReadsOneDescendantCited : AtomMeta :=
  { label := "The Greek translator of Genesis read the woman's seed at 3:15 as one person"
  , kind := .interpretive
  , source :=
      { primary := .work collinsSyntacticalNote (.page 145)
      , supporting :=
          [ .work collinsSyntacticalNote (.page 144)
          , .work martinEarliestMessianic .whole
          , .work lewisWomansSeed (.page 300) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .wellSupported } }

end TestimonyArguments.BornOfAVirgin
