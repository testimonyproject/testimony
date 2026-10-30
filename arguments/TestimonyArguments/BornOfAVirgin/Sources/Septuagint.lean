import TestimonyArguments.BornOfAVirgin.Atoms

/-!
# TestimonyArguments.BornOfAVirgin.Sources.Septuagint — the citations of the Septuagint dispute

The atoms of the dispute over what the Septuagint's παρθένος shows, cited here
and dispatched from `cite` by name: when and by whom the Greek Isaiah was made,
what its word for the woman of 7:14 meant, the evidence each side reads, and
what the translator can be taken to have meant.

They sit apart for the reason `Sources.Wegner` does: `cite` stays one total
function, and each value below is reached from exactly one of its cases.

Rico and Gentry are cited from their book; Bratcher, Walton, Wegner, Rhodea and
Postell from their articles; Davidson from his dictionary article; Meade from
his comment on his own blog post. Three readings are known to the library only
through the scholar who reports them, and each comment says so: Delling's and
Tsevat's, through Rhodea, and Gray's, through Bratcher.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- `lxxIsPreChristian`. Irenaeus makes the argument from it: Isaiah 7:14 "was
interpreted into Greek by the Jews themselves, much before the period of our
Lord's advent, that there might remain no suspicion that perchance the Jews,
complying with our humour, did put this interpretation upon these words"
(*Against Heresies* III.21.1). Justin presses Trypho with the version made by
"the seventy elders who were with Ptolemy" (*Dialogue* 71). Chrysostom makes the
same point: the Seventy, "as having entered upon this work an hundred years or
more before the coming of Christ, stand clear from all such suspicion" (*Homilies
on Matthew* 5); Eusebius adds that they were "men of Hebrew race, experts in the
accuracy of their knowledge of their national language" (*Dem. Ev.* VII.1). The
rival grants the date: Wegner puts the translator "about 250–150 BC" (483).
`consensus`. -/
def lxxIsPreChristianCited : AtomMeta :=
  { label := "The Greek Isaiah was translated by Jews before the coming of Christ"
  , kind := .historical
  , source :=
      { primary := .work irenaeusAgainstHeresies (.sectionRef "III.21.1")
      , supporting :=
          [ .work justinDialogue (.sectionRef "71")
          , .work chrysostomHomiliesMatthew (.sectionRef "5")
          , .work eusebiusDemonstratio (.sectionRef "VII.1")
          , .work wegnerVirginBirths (.page 483) ]
      , tradition := .christianTypological
      , confidence := .consensus } }

/-- `parthenosMeansVirgin`. Rico and Gentry: "There is no doubt that we should
take the term parthenos to mean 'virgin' whenever it appears in Semitic Koine
Greek: the example of Gn 34:1–3 is the exception that proves the rule" (21).
Postell reports that they "insist" on it (472 n. 45). Bratcher reaches the same
conclusion from the Septuagint's usage, without their argument: "parthenos
definitely means 'virgin' in the LXX; only very exceptionally (and, inexplicably,
in Gen. 34:3) is it used otherwise" (113).

`disputed`, because scholars this argument cites deny it. Wegner holds that in
the translator's day the word meant "a young woman of marriageable age", and
came to mean "virgin" only by the time of the New Testament (482–83). Walton:
"Therefore the LXX is not necessarily betraying an interpretation as virgin by
choosing this term" (293). Rhodea: "in the LXX, παρθένος need not refer to a
virgo intacta" (67). Meade: "παρθενος simply means young woman in this verse and
in other places in the LXX" (comment of 9 January 2013). -/
def parthenosMeansVirginCited : AtomMeta :=
  { label := "In the Greek of the Septuagint, παρθένος means a virgin"
  , kind := .linguistic
  , source :=
      { primary := .work ricoGentryInfantKing (.page 21)
      , supporting :=
          [ .work bratcherStudyOfIsaiah (.page 113)
          , .work postellIsaiahMessianic (.page 472) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- `parthenosMeantYoungWoman`. A claim about the word, not about any woman: in
the translator's Greek, παρθένος meant "young woman", and did not yet mean
"virgin". Wegner and Walton grant that by the New Testament it meant "virgin";
Meade and Davidson put that sense down to Christian use. The dispute is over the
translator's day, two or three centuries before Matthew.

Wegner: "In early Greek literature it appears to have had the meaning of 'a young
woman of marriageable age' (with or without the focus on virginity), but by NT
times this word developed the more technical meaning of 'virgin'" (482). So the
translator of Isaiah chose a word for a young woman, "an excellent word choice to
convey what the LXX's author meant", and "in the intervening time between the
LXX and the NT book of Matthew, the word παρθένος changed in meaning" (483).
Rhodea follows him, with an "apparently" (67). Meade holds it too: παρθένος
"simply means young woman in this verse and in other places in the LXX", and by
the time of Justin it had been "hijacked or used to mean 'chaste woman' only"
(comment of 9 January 2013). `disputed`: Rico and Gentry deny it, and so does
Bratcher. -/
def parthenosMeantYoungWomanCited : AtomMeta :=
  { label := "In the Septuagint's day, παρθένος meant 'young woman'; not yet 'virgin'"
  , kind := .linguistic
  , source :=
      { wegnerOnAlmah (.pages 482 483) .disputed with
        supporting :=
          [ .work rhodeaDidMatthewConceive (.page 67)
          , .work meadeAncientVersionsComment .whole ] } }

/-- `earlyGreekParthenosIsYoungWoman`. Wegner (482) and Rhodea (67) both state it
from BDAG 777: "a young woman of marriageable age, with or without focus on
virginity". BDAG itself gives that as the word's general use "Hom.+", from
Homer on, and sets against it the sense "in our lit.", the New Testament and the
early Christian writings: "one who has never engaged in sexual intercourse,
virgin". So the contrast in BDAG is between bodies of writing, not between
periods; "early Greek" is Wegner's and Rhodea's narrowing of it, and the claim
here is no more than the narrowing. BDAG gives no sense for the Septuagint.
LSJ, for classical Greek: "maiden, girl", "virgin, opp. γυνή", and "of unmarried
women who are not virgins" (1339). Walton: the word "does not always mean 'virgin' in
classical Greek" (293). Bratcher, who holds the opposite of Wegner about the
Septuagint, grants it: "at first the word was used in a general sense of
'girl', 'young woman', without any specific connotation of virginity" (112).
`wellSupported`: Rico and Gentry grant the older usage too, and explain Genesis
34:3 by it, as an "almost anachronistic use of the word parthenos" that
"corresponds to the general tendency of language in the Septuagint version of
the Pentateuch", whose language is "more elevated and classical than the
language of the later texts" (18). What they deny is that the older usage is the
Septuagint's at large. -/
def earlyGreekParthenosIsYoungWomanCited : AtomMeta :=
  { label := "In early Greek, παρθένος meant a young woman, with or without virginity"
  , kind := .linguistic
  , source :=
      { wegnerOnAlmah (.page 482) .wellSupported with
        supporting :=
          [ .work rhodeaDidMatthewConceive (.page 67)
          , .work bdag (.page 777)
          , .work liddellScottJones (.page 1339)
          , .work waltonWhatsInAName (.page 293)
          , .work bratcherStudyOfIsaiah (.page 112) ] } }

/-- `greekCallsDinahParthenos`. What the Greek reads: Shechem "lay with her
and humbled her" (34:2), and "he loved the παρθένος, and spoke to her according
to the mind of the παρθένος" (34:3), where the Hebrew has נַעֲרָה, "girl", both
times. Read from Rahlfs's text and the Masoretic. Wegner calls it "a good
example of the meaning of παρθένος in the LXX" (483), and Rhodea draws from it
that "παρθένος need not refer to a virgo intacta" (67). No one denies the
reading. Rico and Gentry call it "the exception that proves the rule" (21);
Bratcher, an exception made "inexplicably" (113).

The claim is what the text reads: the word, and the verse it stands in, after
34:2. Whether the noun describes Dinah as she was after 34:2 is a further claim,
and a reader's (`parthenosDescribesDinahAsSheThenWas`). -/
def greekCallsDinahParthenosCited : AtomMeta :=
  { label := "The Septuagint calls Dinah a παρθένος at 34:3, after Shechem lies with her (34:2)"
  , kind := .textual
  , source :=
      { primary := .scripture dinahAfterShechem
      , supporting :=
          [ .work wegnerVirginBirths (.page 483)
          , .work rhodeaDidMatthewConceive (.page 67)
          , .work ricoGentryInfantKing (.pages 18 21)
          , .work bratcherStudyOfIsaiah (.page 113) ]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `isaiahUsesParthenosForBetulah`. What the two texts read, and nothing more:
read from Rahlfs's text of the Greek and from the Masoretic Text, the Greek
Isaiah has παρθένος at 23:4, 37:22, 47:1 and 62:5 besides 7:14, and in each the
Hebrew has בְּתוּלָה. The converse does not hold — at 23:12 the Greek has no
παρθένος for בְּתוּלַת — and the atom does not claim it. Scripture alone, and
legitimately so: the claim is about what a version reads. -/
def isaiahUsesParthenosForBetulahCited : AtomMeta :=
  { label := "Elsewhere in the Greek Isaiah, παρθένος renders בְּתוּלָה"
  , kind := .textual
  , source :=
      { primary := .scripture isaianicParthenoi
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `priestMarriesAParthenos`. What the Greek reads, from Rahlfs's text: the high
priest "shall take a wife, a παρθένος, from his own kin" (γυναῖκα παρθένον ἐκ τοῦ
γένους αὐτοῦ, 21:13), where the Hebrew has אִשָּׁה בִבְתוּלֶיהָ, "a woman in her
virginity"; and "a widow, a woman put away, a defiled woman and a harlot, these he
shall not take, but a παρθένος from his own kin" (21:14). Read from Rahlfs's text
and the Masoretic. Scripture alone, and legitimately so: the claim is about what
a version reads. `consensus`. -/
def priestMarriesAParthenosCited : AtomMeta :=
  { label := "The high priest of the Greek Leviticus marries a παρθένος, not a widow or a harlot"
  , kind := .textual
  , source :=
      { primary := .scripture priestsBride
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `partheniaProveTheBride`. What the Greek reads, from Rahlfs's text: a husband
says of his bride "I did not find τὰ παρθένια in her" (22:14), and her parents
bring out "τὰ παρθένια of the girl" (22:15); if the charge is true and "παρθένια
are not found for the girl", she is stoned, "for she has done folly among the
sons of Israel, to play the harlot in her father's house" (22:20–21). A man who
brings the charge falsely has brought "an evil name upon a παρθένος of Israel"
(22:19). The Hebrew has בְּתוּלִים for the tokens.

The lexica gloss the Greek word alike: "signs of virginity, LxxDe.22.15" (LSJ
1339); "tokens of virginity" (Muraoka 535); "signs pertaining to virginity,
virginity" (LEH s.v.). `consensus`: no reader found denies the reading. -/
def partheniaProveTheBrideCited : AtomMeta :=
  { label := "In the Greek Deuteronomy, a bride without τὰ παρθένια dies for playing the harlot"
  , kind := .textual
  , source :=
      { primary := .scripture tokensOfVirginity
      , supporting :=
          [ .work liddellScottJones (.page 1339)
          , .work muraokaLexiconSeptuagint (.page 535)
          , .work lustLexiconSeptuagint (.sv "παρθένια") ]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `lawsUseParthenosAsVirgin`. Bratcher makes the argument from the Greek of
the laws: in Deuteronomy 22 the Hebrew's בְּתוּלִים "stands concretely for 'tokens
of virginity' (LXX partheneia)", and in Leviticus 21 "the young woman so
characterized is clearly a virgin (LXX parthenos)" (102, where "Lev. 21:3" is a
misprint for 21:13); "The use of the cognates of parthenos in the LXX bears out
the conclusion that parthenos is 'virgin'", and "All this indicates that
parthenos is 'virgin' in the exact sense of the word" (113).

These are not uses of the word *of* a virgin, which would show nothing about its
sense: Walton observes that a thousand uses of "fiancée" of virgins would not
make it mean "virgin" (292). In these laws virginity is what the law turns on.
The priest's παρθένος is set against the widow, the woman put away, the defiled
woman and the harlot, and stands for "a woman in her virginity". The bride's τὰ
παρθένια are the tokens whose absence proves her a harlot, and Walton's own test
is that a word meaning "virgin" should have an abstract meaning "virginity"
(292).

`disputed`, as its step is, on Miller (`lawsLine` gives his dissent, and where
it breaks). -/
def lawsUseParthenosAsVirginCited : AtomMeta :=
  { label := "In the Greek Pentateuch's laws, παρθένος is used in the sense 'virgin'"
  , kind := .linguistic
  , source :=
      { primary := .work bratcherStudyOfIsaiah (.page 113)
      , supporting :=
          [ .work bratcherStudyOfIsaiah (.page 102)
          , .work waltonWhatsInAName (.page 292)
          , .work millerBornDivine .whole ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- `seductionLawPricesAParthenos`. What the Greek reads, from Rahlfs's text:
"if anyone deceives a παρθένος not betrothed and lies with her, he shall endow
her with a bride-price as his wife" (22:15), and if her father will not give her,
"he shall pay the father silver, as much as is the bride-price of virgins", ἡ
φερνὴ τῶν παρθένων (22:16), where the Hebrew has בְּתוּלָה and מֹהַר הַבְּתוּלֹת. The
law calls her a παρθένος, and names what the man owes "the bride-price of
virgins", after he has lain with her. What that price says of her is the step's
to read (`dinahLine`). `consensus`: it is what the text reads. -/
def seductionLawPricesAParthenosCited : AtomMeta :=
  { label := "In the Greek Exodus, the seduced παρθένος is owed 'the bride-price of virgins'"
  , kind := .textual
  , source :=
      { primary := .scripture seductionLaw
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `shechemActsUnderTheLaw`. What the texts read, from Rahlfs's text and the
Masoretic. Three words of Genesis 34 are words of the laws of the violated
virgin:

- Shechem "humbled her", ἐταπείνωσεν αὐτήν, וַיְעַנֶּהָ (34:2), the verb of the
  man who seizes a virgin not betrothed: he shall marry her "because he humbled
  her" (Deuteronomy 22:29, in both texts).
- Jacob's sons say he "did folly in Israel", נְבָלָה עָשָׂה בְיִשְׂרָאֵל (34:7), the
  words of the bride found without the tokens of virginity, who "did folly in
  Israel" (Deuteronomy 22:21). The link is the Hebrew's: the Greek has
  ἄσχημον at 34:7 and ἀφροσύνην at Deuteronomy 22:21.
- Shechem offers the bride-price, φερνή, מֹהַר (34:12), the payment Exodus
  22:15–16 requires of the man who has lain with a παρθένος.

`consensus`: the words are the texts', whatever is made of them. -/
def shechemActsUnderTheLawCited : AtomMeta :=
  { label := "Genesis 34 tells Shechem's act in the words of the laws of the violated virgin"
  , kind := .textual
  , source :=
      { primary := .scripture shechemUnderTheLaw
      , supporting := [.scripture seductionLaw]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `dinahIsTheLawsParthenos`. The status reading of Genesis 34:3: the Greek
calls Dinah "the παρθένος" as the law of Exodus 22:15–16 calls the woman a man
has lain with, naming her by the standing he took from her, and the word keeps
its sense "virgin". `dinahLine` gives the argument and its rating. `plausible`,
as its step is. -/
def dinahIsTheLawsParthenosCited : AtomMeta :=
  { label := "At Genesis 34:3 the Greek names Dinah a παρθένος as the law names the seduced virgin"
  , kind := .linguistic
  , source :=
      { primary := .scripture seductionLaw
      , supporting :=
          [ .scripture shechemUnderTheLaw
          , .work frymerKenskyVirginity (.pageList [80, 91])
          , .work ricoGentryInfantKing (.pages 18 21)
          , .work bratcherStudyOfIsaiah (.page 113) ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .plausible } }

/-- `matthewQuotesTheGreekVirgin`. What Matthew reads: "ἰδοὺ ἡ παρθένος ἐν γαστρὶ
ἕξει καὶ τέξεται υἱόν" (1:23), the Septuagint's words for Isaiah 7:14. Scripture
alone, and legitimately so: the claim is about what the texts read.
`consensus`. -/
def matthewQuotesTheGreekVirginCited : AtomMeta :=
  { label := "Matthew 1:23 quotes Isaiah 7:14 in the Greek's own words: ἡ παρθένος"
  , kind := .textual
  , source :=
      { primary := .scripture matthewQuotesTheSeptuagint
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `matthewSaysMaryKnewNoMan`. What Matthew says: Mary was found with child
"before they came together" (1:18), and Joseph "knew her not until she had borne
a son" (1:25). This is what Matthew says, not whether it happened, which the
argument rates apart (`maryConceivedAsVirgin`). `consensus`. -/
def matthewSaysMaryKnewNoManCited : AtomMeta :=
  { label := "Matthew says Mary conceived before she and Joseph came together"
  , kind := .textual
  , source :=
      { primary := .scripture matthewMaryKnewNoMan
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `lxxIsaiahUsesParthenosAsVirgin`. Scripture's own reading of the Greek word:
Matthew quotes the Septuagint's ἡ παρθένος of a woman who conceived before she
and Joseph came together, so in the text he quotes, the word has the sense
"virgin". The principle is Westminster's: "The infallible rule of interpretation
of Scripture is the Scripture itself" (I.ix). Irenaeus: the apostles "agree with
this aforesaid translation", and Matthew among them set forth the prophecies
"just as the interpretation of the elders contains them" (*Against Heresies*
III.21.3).

`disputed`, as its step is: Wegner grants that Matthew uses the word of Mary, a
virgin, and holds that it had changed in meaning since the translator wrote it,
"from 'young woman' to 'virgin,' thus also making it a suitable term to describe
Mary in the first century AD" (483). -/
def lxxIsaiahUsesParthenosAsVirginCited : AtomMeta :=
  { label := "In the Greek of Isaiah 7:14, which Matthew quotes, παρθένος means 'virgin'"
  , kind := .linguistic
  , source :=
      { primary := .work westminsterConfession (.sectionRef "I.ix")
      , supporting :=
          [ .work irenaeusAgainstHeresies (.sectionRef "III.21.3")
          , .work wegnerVirginBirths (.page 483) ]
      , tradition := .reformedProtestant
      , confidence := .disputed } }

/-- `joelGreekCallsTheWidowParthenos`. Miller's claim about the Greek: "Lament
like a parthenos dressed in sackcloth for the husband of her youth (Joel 1:8)",
given as a use of the word of a woman who is not a virgin (*Born Divine*). The
Greek of Joel 1:8 does not read so: it calls the woman νύμφην, a bride, and its
παρθεν- word, τὸν παρθενικόν, is of the husband (Rahlfs). Cited for what Miller
holds; the text refutes it (`Dispute.Miller`). -/
def joelGreekCallsTheWidowParthenosCited : AtomMeta :=
  { label := "The Greek of Joel 1:8 calls a young widow a παρθένος (Miller)"
  , kind := .textual
  , source :=
      { primary := .work millerBornDivine .whole
      , tradition := .criticalScholarship
      , confidence := .disputed } }

/-- `parthenosDoesNotItselfConnoteVirginity`. Miller's thesis: "As in other Greek
literature, parthenos in the Septuagint did not by itself connote what we mean by
virginity", so that where virginity matters it "has to be inferred from the
context" (*Born Divine*). `disputed`: Bratcher (113), and Rico and Gentry, hold
the opposite. -/
def parthenosDoesNotItselfConnoteVirginityCited : AtomMeta :=
  { label := "In the Septuagint, παρθένος did not by itself connote virginity (Miller)"
  , kind := .linguistic
  , source :=
      { primary := .work millerBornDivine .whole
      , supporting := [.work bratcherStudyOfIsaiah (.page 113)]
      , tradition := .criticalScholarship
      , confidence := .disputed } }

/-- `parthenosDescribesDinahAsSheThenWas`. Miller's premise: "In one passage,
this term refers to a rape victim after she has been attacked (Gen 34:3)" (*Born
Divine*). Wegner says the same, that Dinah "is called a παρθένος even after she
was raped by Shechem" (483), and Muraoka's lexicon glosses the verse "so called
just after having been raped" (535). It is more than the reading of the text
(`greekCallsDinahParthenos`): that the noun says what Dinah was at the time of
the verse, and so, since she was then no longer a virgin, that the word is not
used there in the sense "virgin".

A noun need not say what the one it names is at the time of its verb. Enç
argues that a noun phrase is read at a time of its own, which the context gives
(1986); Scripture names Rahab "the harlot" long after Jericho (Hebrews 11:31,
James 2:25), and Matthew "the tax collector" after his call (Matthew 10:3). So
the noun at 34:3 can name Dinah by what she had been, or, as the status reading
holds, by the law's name for the woman a man has lain with
(`dinahIsTheLawsParthenos`).

`wellSupported`, not higher: every reader on record who takes up the verse holds
it, and Rico and Gentry and Bratcher, who read the word as "virgin", grant it.
The status reading and the argument from the noun contest it, but both are the
library's own, and no reader has been found who makes either. -/
def parthenosDescribesDinahAsSheThenWasCited : AtomMeta :=
  { label := "At 34:3 παρθένος describes Dinah as she then was, no longer a virgin (Miller)"
  , kind := .linguistic
  , source :=
      { primary := .work millerBornDivine .whole
      , supporting :=
          [ .work wegnerVirginBirths (.page 483)
          , .work muraokaLexiconSeptuagint (.page 535) ]
      , tradition := .criticalScholarship
      , confidence := .wellSupported } }

/-- `tryphoRejectsParthenos`. Trypho: "The Scripture has not, 'Behold, the virgin
shall conceive, and bear a son,' but, 'Behold, the young woman shall conceive'"
(*Dialogue* 67). Justin answers that Trypho's teachers "refuse to admit that the
interpretation made by the seventy elders who were with Ptolemy ... is a correct
one" (71). `consensus`: the record is Justin's, and no one doubts that the
objection was made. -/
def tryphoRejectsParthenosCited : AtomMeta :=
  { label := "Trypho rejects the Septuagint's 'the virgin' and reads 'the young woman'"
  , kind := .historical
  , source :=
      { primary := .work justinDialogue (.sectionRef "67")
      , supporting := [.work justinDialogue (.sectionRef "71")]
      , tradition := .christianTypological
      , confidence := .consensus } }

/-- `lxxReadsAVirgin`. What Irenaeus takes the Greek to say: "the token of the
Virgin" (*Against Heresies* III.21.1). Readers who doubt more grant this much.
Bratcher: "all the LXX means by parthenos is that a young woman, at that time
virgin, would in the normal way marry and bear a child" (115), which he calls
"the most reasonable explanation" (116). Delling, as Rhodea quotes him: the
Septuagint's usage "demands no more than the sense of a 'woman untouched by a
man up to the moment of the conception (of Immanuel)'" (Rhodea 67, citing TDNT
5.833 in n. 42).

`disputed`, because it stands or falls with the claim about παρθένος: on
Wegner's reading the translator wrote a word for a young woman, and said nothing
of her virginity. -/
def lxxReadsAVirginCited : AtomMeta :=
  { label := "Before Christ, a Jewish translator read the woman of Isaiah 7:14 as a virgin"
  , kind := .interpretive
  , source :=
      { primary := .work irenaeusAgainstHeresies (.sectionRef "III.21.1")
      , supporting :=
          [ .work bratcherStudyOfIsaiah (.pages 115 116)
          , .work rhodeaDidMatthewConceive (.page 67) ]
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- `lxxPutsTheConceptionInTheFuture`. What the Greek reads: ἰδοὺ ἡ παρθένος ἐν
γαστρὶ ἕξει, "look, the virgin shall be with child", a future, where Wegner reads
the Hebrew הָרָה as a present pregnancy. Rhodea notes it (67). `consensus`. -/
def lxxPutsTheConceptionInTheFutureCited : AtomMeta :=
  { label := "The Septuagint puts the conception in the future: 'she shall be with child'"
  , kind := .textual
  , source :=
      { primary := .scripture [verseIn .septuagint isaiah7_14]
      , supporting := [.work rhodeaDidMatthewConceive (.page 67)]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `lxxEnvisagesAVirginalConception`. Justin reads the elders' Greek so: "if He
also were to be begotten of sexual intercourse, like all other first-born sons,
why did God say that He would give a sign which is not common to all the
first-born sons?" (*Dialogue* 84). Delling, as Rhodea quotes him, allows that
"on the basis of LXX usage it is also possible that the translator of Is. 7:14
envisaged a non-sexual origin of the virgin's son" (67 n. 42).

`disputed`. Rhodea, quoting Tsevat: "The pregnancy lies in the future ...;
nothing indicates that the woman is also a virgin after the conception" (67);
"the evidence, then, does not demand a miraculous conception in either the
Hebrew or LXX" (68). Bratcher, quoting Gray: "all, then, that the Greek
translators need mean is that a woman now virgin will hereafter, in the ordinary
course of nature of losing her virginity, conceive" (115–16). -/
def lxxEnvisagesAVirginalConceptionCited : AtomMeta :=
  { label := "The Septuagint's translator meant that the woman conceives as a virgin"
  , kind := .interpretive
  , source :=
      { primary := .work justinDialogue (.sectionRef "84")
      , supporting := [.work rhodeaDidMatthewConceive (.page 67)]
      , tradition := .christianTypological
      , confidence := .disputed } }

end TestimonyArguments.BornOfAVirgin
