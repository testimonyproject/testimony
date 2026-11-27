import TestimonyArguments.Attr
import Testimony.Logic.Line
import Testimony.Scripture

/-!
# TestimonyArguments.SolaScriptura.Atoms — the claims

Every claim the chapters use is listed here once, with the number every formula
calls it by: the texts each side reads, the four positions on tradition and the
Orthodox one, the three objections and the replies to them, and the readings of
Mark 7, Acts 15 and Moses' seat. The table gives each claim's kind, who holds it
and how firmly, and the sources that carry it.

Two claims are worth flagging. Every party grants that Scripture is infallible
(`scriptureIsInfallible`), and the first version of this argument never said
so, though it concluded that Scripture is the sole *infallible* rule; the
eliminative line needs it stated. And Paul's charge to "hold to the traditions
which you were taught, whether by word of mouth or by letter from us" (2
Thessalonians 2:15) is a text both sides must account for, not a Roman premise
(`thessalonians2_15TraditionBinding`). The first version filed it as the
Catholic counter-text, which left the Protestant position with no answer to it.
-/

/-!
#### How the atoms are grouped

Four positions, three objections and two parity replies, so the atom list is
longer than most. It is grouped by what each atom belongs to rather than by
kind, because the groups are what the lines are built from.
-/

namespace TestimonyArguments.SolaScriptura

open Testimony

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- 2 Timothy 3:16 — all scripture is God-breathed and profitable. -/
  | timothy3_16GodBreathed
  /-- 2 Timothy 3:17 — that the man of God may be complete, equipped for every
  good work. The sufficiency prooftext. -/
  | timothy3_17ThoroughlyEquips
  /-- Mark 7:1–13, with its parallel in Matthew 15:1–9 — Jesus rebukes the
  elders' tradition, Corban above all, for voiding the command of God, and
  quotes Isaiah 29:13 against it: "teaching as doctrines the commandments of
  men". What the text says, not yet what follows from it. -/
  | mark7TraditionCanNullify
  /-- Acts 17:11 — the Bereans tested apostolic preaching against scripture.
  Scripture adjudicating rather than sourcing. -/
  | acts17BereansTested
  /-- 2 Thessalonians 2:15 — hold to the traditions taught by word or letter.
  A datum both sides must accommodate, not a premise of one of them. -/
  | thessalonians2_15TraditionBinding
  /-- Scripture is infallible. Granted by every party to this dispute. -/
  | scriptureIsInfallible
  /-- Scripture is a sufficient rule of faith. -/
  | scriptureIsSufficient
  /-- Scripture is clear on what is necessary for salvation. -/
  | scriptureIsPerspicuous
  /-- Scripture is the sole infallible rule of faith. **The conclusion.** -/
  | scriptureIsSoleInfallibleRule
  /-- Scripture itself teaches sola scriptura. The hinge of the self-refutation
  objection. -/
  | solaScripturaIsTaughtByScripture
  /-- A doctrine is binding only if scripture teaches it. -/
  | onlyScripturalDoctrineIsBinding
  /-- No candidate rule of faith other than scripture is infallible. The hinge
  of the eliminative line. -/
  | noOtherRuleIsInfallible
  /-- Tradition is a coordinate source of revelation alongside scripture.
  **Tradition II**, Trent as Oberman and Mathison read it. Rated `disputed`:
  Geiselmann grants Trent's Session IV and denies that it canonised two
  coordinate sources — the draft's "partly … partly" (*partim … partim*) became
  "and" (*et*), which leaves open whether Scripture holds all revealed content —
  and Congar judges that Trent left the question open. -/
  | traditionIsCoordinateSourceOfRevelation
  /-- The magisterium is an infallible interpreter of scripture.
  **Tradition III**, resting on Vatican I. -/
  | magisteriumIsInfallible
  /-- The mind of the Church, expressed in the consensus of the Fathers and in
  conciliar decisions received by the whole Church, infallibly interprets
  scripture. The Orthodox premise, which is not the Roman one. -/
  | churchMindIsInfallibleInterpreter
  /-- The canon is known through the Church's reception of it. -/
  | canonKnownThroughChurchReception
  /-- Identifying the canon requires an infallible authority outside Scripture.
  The hinge of the canon objection. -/
  | identifyingCanonRequiresInfallibleAuthority
  /-- A rival's own foundational authority is self-authenticating too, so the
  circularity charge does not discriminate between the positions. Kruger's
  parity reply. -/
  | rivalAuthorityIsAlsoSelfAuthenticating
  /-- Deuteronomy 13:1–3 — "If a prophet or a dreamer of dreams arises among you
  and gives you a sign or a wonder, and the sign or the wonder comes true,
  concerning which he spoke to you, saying, 'Let us walk after other gods (whom
  you have not known) and let us serve them,' you shall not listen to the words
  of that prophet" (LSB). A sign that comes true does not make him a prophet:
  what he says is weighed against the God Israel already knows. -/
  | deut13_1_3ProphetOfOtherGods
  /-- Deuteronomy 18:20–22 — "Now you may say in your heart, 'How will we know the
  word which Yahweh has not spoken?' When a prophet speaks in the name of
  Yahweh, if the thing does not come about or come true, that is the thing which
  Yahweh has not spoken" (18:21–22, LSB). -/
  | deut18_20_22WordNotFulfilled
  /-- The early Church set apart books it read but did not receive into the
  canon, and gave its reasons. The Muratorian fragment says the Shepherd of
  Hermas may be read but not placed "among the prophets, as their number is
  complete, nor among the apostles"; Athanasius, in his Festal Letter of 367,
  sets the Shepherd and the Didache among books "appointed by the Fathers to be
  read by those who newly join us", and not in the canon. -/
  | booksReadButNotReceived
  /-- God keeps his written word by his providence and brings it to his people.
  The Westminster Confession says the Old Testament in Hebrew and the New in
  Greek were "immediately inspired by God, and by his singular care and
  providence kept pure in all ages" (I.8). The tests are applied under that
  providence, not in place of it. -/
  | providenceKeepsScripture
  /-- Ephesians 2:20 — the church is "built on the foundation of the apostles and
  prophets, Christ Jesus Himself being the corner stone"; and Jude 3 speaks of
  "the faith which was once for all handed down to the saints" (LSB). -/
  | eph2_20FoundationOfApostles
  /-- 2 Peter 3:15–16 — Peter writes that "our beloved brother Paul" wrote "in all
  his letters" things which "the untaught and unstable distort, as they do also
  the rest of the Scriptures" (LSB). He counts Paul's letters among the
  Scriptures. In 3:2 he sets "the commandment of the Lord and Savior spoken by
  your apostles" beside "the words spoken beforehand by the holy prophets"; and
  1 Timothy 5:18 introduces, after a line of Deuteronomy, "The laborer is worthy
  of his wages", with "the Scripture says", a saying Luke 10:7 records from
  Jesus. -/
  | pet3_15_16PaulAmongScriptures
  /-- Galatians 1:8 — "But even if we, or an angel from heaven, should proclaim to
  you a gospel contrary to the gospel we have proclaimed to you, let him be
  accursed!" (LSB). Deuteronomy's test, that a sign does not outweigh a message at
  odds with what God has said, is applied to the apostles' own gospel. -/
  | gal1_8NoOtherGospel
  /-- The Jews of the first century held that prophecy had ceased, and did not
  give the books written after it the authority of the earlier ones. Josephus
  says that what was written after Artaxerxes "hath not been esteemed of the
  like authority with the former ... because there hath not been an exact
  succession of prophets since that time" (*Against Apion* I.8, in Whiston's
  translation), and 1 Maccabees speaks of a distress unknown "since the time a
  prophet had last appeared among them" (9:27, NRSVUE). -/
  | prophecyCeasedBeforeLaterBooks
  /-- The infallible authority that identifies the canon is known by proving the
  Church from Scripture received as inspired. -/
  | churchKnownFromInspiredScripture
  /-- The "spiral": Scripture, read only as reliable history, shows that Christ
  founded an infallible Church, and that Church's word gives the certainty of
  faith about which books are inspired. -/
  | spiralGivesCertaintyOfTheCanon
  /-- The Church's marks, its spread, holiness, unity and stability, show it to
  be the infallible authority, and so give the certainty of faith about the
  canon. -/
  | marksGiveCertaintyOfTheCanon
  /-- The Church's universal reception and ordinary teaching settled which books
  are canonical before any council defined the list. -/
  | receptionSettledTheCanon
  /-- To prove the Church from Scripture received as inspired, and then
  Scripture's inspiration from the Church, is to argue in a circle. -/
  | provingEachFromTheOtherIsCircular
  /-- A conclusion reached by reasoning from history can be no more certain, by
  natural means, than the history it starts from, and the judgement that the
  Gospels are reliable history is a fallible one. -/
  | conclusionNoSurerThanItsHistory
  /-- The marks make the Church's claim credible, not evident, and other
  churches claim the same marks. -/
  | marksMakeTheClaimOnlyCredible
  /-- Before Trent, the Latin Church did not receive the disputed books with one
  voice: Jerome left them out of the canon, Gregory the Great called 1 Maccabees
  "not Canonical", and Cajetan, on the eve of Trent, followed Jerome. -/
  | disputedBooksDoubtedBeforeTrent
  /-- Tradition carries real but fallible — ministerial, not magisterial —
  authority. **Tradition I.** -/
  | traditionHasMinisterialAuthority
  /-- Tradition I differs in principle from Tradition 0. What the
  interpretive-authority regress denies. -/
  | traditionIDiffersInPrincipleFromTradition0
  /-- The individual retains ultimate interpretive authority, exercised
  indirectly by choosing which body to submit to. Cross and Judisch's premise. -/
  | individualRetainsUltimateInterpretiveAuthority
  /-- Choosing which authority to submit to is itself an act of private
  judgement, whichever authority is chosen. Mathison's parity reply. -/
  | choosingAnAuthorityIsItselfPrivateJudgment
  /-- The bindingness rule governs first-order doctrine, not a claim about
  where binding doctrine comes from. The final-arbiter answer to
  self-refutation. -/
  | bindingnessAppliesToFirstOrderDoctrineOnly
  /-- A practice neither commanded nor forbidden in scripture is permitted
  without scriptural warrant. Adiaphora. -/
  | practiceNeitherCommandedNorForbiddenIsPermitted
  /-- Creeds are informative without being normative: valuable in interpreting
  scripture without binding. **Tradition 0**, as Geisler states it. -/
  | creedsAreInformativeNotNormative
  /-- The historical-grammatical method alone suffices to obtain the meaning of
  scripture on essential doctrine. -/
  | historicalGrammaticalMethodSuffices
  /-- The creedal consensus is hermeneutically necessary for understanding
  scripture. Tradition I's claim, and one leg of Geisler's circle. -/
  | creedalConsensusIsHermeneuticallyNecessary
  /-- Doctrine develops without new revelation: the deposit is closed while
  understanding of it deepens. Held by Rome and by Tradition I alike. -/
  | doctrineDevelopsWithoutNewRevelation
  /-- A development is authenticated by the authority of the developing body.
  Newman's answer to what licenses a development. -/
  | developmentIsAuthenticatedByTheChurch
  /-- The creedal consensus rests on the clarity of scripture. The first leg of
  Geisler's circle. -/
  | creedalConsensusRestsOnPerspicuity
  /-- Scripture's clear sense is not obtainable without the creedal consensus.
  The second leg, and the one every reply below denies. -/
  | perspicuityRequiresCreedalConsensus
  /-- Tradition I's reasoning is circular. Geisler's charge. -/
  | traditionIReasoningIsCircular
  /-- The circularity defeats Tradition I. -/
  | circularityDefeatsTraditionI
  /-- Any appeal to an ultimate authority is circular, there being no higher
  authority to appeal to. Barrett's parity reply. -/
  | everyUltimateAuthorityIsCircular
  /-- The creedal consensus is established by and accountable to scripture — a
  product of reading it rather than a precondition of it. Allen and Swain. -/
  | creedalConsensusIsDerivedFromScripture
  /-- Scripture itself bounds the interpretive office: elders are commended to
  the word, required to hold to it, and forbidden to domineer. **Proposed.** -/
  | scriptureBoundsTheInterpretiveOffice
  /-- Perspicuity is claimed only for what is necessary for salvation, not for
  all of scripture alike. Westminster I.7. -/
  | perspicuityIsLimitedToSalvationEssentials
  /-- **Mark 7's principle.** God's word judges human tradition: no commandment
  of men may be taught as God's word, and a tradition that voids God's command
  is void. Held by Rome as firmly as by the Reformers: the Church's teaching
  office is "not above the word of God" (*Dei Verbum* 10). It is common ground
  only while "God's word" is left as each side uses it — for Rome it includes
  the apostolic Tradition. Read as "Scripture judges every tradition", it is the
  Reformed claim, and Rome denies it. -/
  | godsWordJudgesTradition
  /-- A commandment of men may rightly be bound on the Church as God's word.
  What the elders claimed for Corban, and what Isaiah 29:13 condemns. Trent,
  read as receiving commandments of men, is committed to it; Mark 7's principle
  denies it. -/
  | mensCommandmentBindsAsGodsWord
  /-- No unwritten tradition can now be shown to be apostolic, and so none can
  bind the conscience as the word of God. A claim about what can be proved, not
  about what the apostles once said. Whitaker, answering one by one Bellarmine's
  five rules for telling a genuine tradition from a spurious one, replies that
  "the papists have no such unwritten tradition which can be certainly shewn to
  have been always observed by the universal church". **The step from Mark 7 to
  sola scriptura needs it**, and Rome denies it: Trent says the gospel's truth
  and discipline "are contained in the written books, and the unwritten
  traditions", and *Dei Verbum* 9 says that "it is not from Sacred Scripture
  alone that the Church draws her certainty about everything which has been
  revealed". -/
  | noUnwrittenTraditionShownApostolic
  /-- John 10:35 — "the Scripture cannot be broken". Jesus answers the charge
  of blasphemy from Psalm 82:6, and rests the answer on this. What the text
  says, not yet what follows from it. -/
  | john10_35ScriptureCannotBeBroken
  /-- Matthew 5:18 — "until heaven and earth pass away, not the smallest letter
  or stroke shall pass from the Law until all is accomplished". The smallest
  letter is the iota (ἰῶτα, "smallest letter"), and the stroke (κεραία) the smallest mark of one.
  -/
  | matthew5_18LawShallNotPass
  /-- Galatians 1:8–9 — "But even if we, or an angel from heaven, should
  proclaim to you a gospel contrary to the gospel we have proclaimed to you, let
  him be accursed! As we have said before, so I say again now, if any man is
  proclaiming to you a gospel contrary to what you received, let him be
  accursed!" Paul puts his own later preaching, and an angel's, under the gospel
  he had already preached. "Contrary to" translates παρ' ὅ ("contrary to"), which can also be
  rendered "besides" or "other than"; how far it reaches, to any addition or
  only to what is alien, is the point Calvin and Aquinas dispute, and the step's
  rating weighs it. -/
  | galatians1_8AnotherGospelAccursed
  /-- Colossians 2:8 and 2:20–22 — "See to it that no one takes you captive
  through philosophy and empty deception, according to the tradition of men,
  according to the elementary principles of the world, and not according to
  Christ"; and of the rules "Do not handle, nor taste, nor touch", that they are
  "in accordance with the commands and teachings of men". Paul is warning a
  church, not the elders of Jerusalem. -/
  | colossians2_8TraditionOfMen
  /-- Acts 15:1 — "Some men came down from Judea and began teaching the
  brothers, 'Unless you are circumcised according to the custom of Moses, you
  cannot be saved.'" "The custom" (ἔθος) of Moses is the oldest practice Israel
  had, and one God himself had given. What the text reports, not yet what
  follows from it. -/
  | acts15_1CircumcisionAfterMoses
  /-- Acts 15:10–11 — Peter at the council: "Now therefore why do you put God to
  the test by placing upon the neck of the disciples a yoke which neither our
  fathers nor we have been able to bear? But we believe that we are saved
  through the grace of the Lord Jesus, in the same way as they also are." -/
  | acts15_10_11YokeAndGrace
  /-- Acts 15:15–17 — James at the council: "And with this the words of the
  Prophets agree, just as it is written, 'After these things I will return, And
  I will rebuild the fallen booth of David ... So that the rest of mankind may
  seek the Lord, And all the Gentiles who are called by My name'". He quotes
  Amos 9:11–12. -/
  | acts15_15_17ProphetsAgree
  /-- Acts 15:23–29 — "and they sent this letter by them": the council's decree
  went to the churches as a letter, and the letter is in Scripture. -/
  | acts15_23_29DecreeWritten
  /-- Acts 15:28 — the council's letter: "For it seemed good to the Holy Spirit
  and to us to lay upon you no greater burden than these essentials". -/
  | acts15_28SeemedGoodToTheHolyGhost
  /-- Acts 16:4 — "Now while they were passing through the cities, they were
  delivering the decrees which had been decided upon by the apostles and elders
  who were in Jerusalem, for them to keep." "Delivering" (παρεδίδοσαν) is the
  verb whose noun is "tradition" (παράδοσις): the decrees were handed on. -/
  | acts16_4DecreesDelivered
  /-- A general council of the Church after the apostles binds with the Holy
  Spirit's authority, as the council at Jerusalem did: its definition of faith is
  the Spirit's as well as the council's, and cannot err. Rome's reading of Acts
  15:28, in Joseph Wilhelm's words: the apostles "put the seal of supreme
  authority on their decisions in attributing them to the joint action of the
  Spirit of God and of themselves". Rated `disputed`: the Westminster Confession
  cites the same chapter for the authority of councils and holds that "All
  synods or councils since the apostles' times ... may err" (XXXI.4). -/
  | councilBindsWithTheSpiritsAuthority
  /-- Matthew 23:2–3 — "The scribes and the Pharisees have seated themselves in
  the chair of Moses; therefore all that they tell you, do and keep, but do not
  do according to their deeds; for they say things and do not do them." The
  "chair" (καθέδρα), Moses' seat, is the teacher's chair; "keep" (τηρεῖτε) is
  the verb Mark 7:9 uses for keeping "your tradition". What the text says, not
  yet what follows from it. -/
  | matthew23_2_3MosesSeat
  /-- Matthew 23:16–22 — "Woe to you, blind guides, who say, 'Whoever swears by
  the sanctuary, that is nothing; but whoever swears by the gold of the
  sanctuary is obligated.'" A teaching of the scribes, about which oaths bind,
  that Jesus condemns in the same discourse in which he tells the crowd to
  observe what they bid. -/
  | matthew23_16_22BlindGuides
  /-- Those who hold the teaching office in the Church are to be heeded by
  reason of the seat they hold, in whatever they teach that is not contrary to
  God's law, even when they themselves live ill. Rome's reading of Matthew
  23:2–3, in Cornelius a Lapide's words: the seat is "the honour, dignity, and
  authority of teaching and commanding, which Moses had with the Jews, and to
  which the Scribes had succeeded", as the chair of Peter is the authority "in
  which the Roman Pontiffs succeed S. Peter". A claim about authority, not about
  infallibility. Rated `disputed`: Calvin reads the same verses and holds that
  Christ bids the people obey the scribes "only so far as they adhere to the
  pure and simple exposition of the Law". -/
  | teachingOfficeHeardByItsSeat
  /-- Acts 1:21–22 — the qualification for the apostle chosen in Judas's place:
  "it is necessary that of the men who have accompanied us all the time that the
  Lord Jesus went in and out among us—beginning with the baptism of John until
  the day that He was taken up from us—one of these must become a witness with
  us of His resurrection." What the text says, not yet what follows from it. -/
  | acts1_21_22WitnessOfResurrection
  /-- 1 Corinthians 15:8 — Paul, at the end of the list of those to whom the
  risen Christ appeared: "and last of all, as to one untimely born, He appeared
  to me also." -/
  | corinthians15_8LastOfAll
  /-- 2 Peter 3:15–16 — "our beloved brother Paul, according to the wisdom given
  him, wrote to you, as also in all his letters ... which the untaught and
  unstable distort, as they do also the rest of the Scriptures". Paul's letters
  are counted with "the rest of the Scriptures". -/
  | peter3_15_16PaulsEpistlesWithTheScriptures
  /-- 2 Corinthians 1:1 and Colossians 1:1 — "Paul, an apostle of Christ Jesus
  by the will of God, and Timothy our brother" (2 Corinthians 1:1; Colossians
  1:1 reads the same). Paul calls himself an apostle and his companion a
  brother. -/
  | salutationsApostleAndBrother
  /-- 1 Thessalonians 2:6, with 1:1 — the letter is from "Paul and Silvanus and
  Timothy", and it says "as apostles of Christ we could have been a burden to
  you" (2:7 in the Greek editions, where "a burden" is ἐν βάρει ("a burden"), "of weight").
  Whether "apostles" here takes in Silvanus and Timothy the text does not
  settle. Calvin takes it of Paul, "inasmuch as he was an Apostle of Christ";
  Coppieters, in the *Catholic Encyclopedia*, lists the verse among the passages
  "in which the extension of the word Apostle is doubtful". What the text says,
  and no more. -/
  | thessalonians2_6ApostlesOfChrist
  /-- The apostles' own office ended with them. They were the eyewitnesses of the
  risen Christ, sent to found the churches, and later ministers succeed to
  their ministry of word and sacrament, not to that office, so a council after
  them lacks what the council at Jerusalem had. Calvin: the offices of apostle,
  prophet and evangelist "were not instituted in the Church to be perpetual",
  and the twelve, with Paul, were "distinguished from others by a peculiar
  title" (*Institutes* IV.iii.4–5). Rated `disputed`: *Lumen Gentium* 20 holds
  that "the apostles' office of nurturing the Church is permanent, and is to be
  exercised without interruption by the sacred order of bishops". -/
  | apostlesOfficeEndedWithThem
  /-- Acts 15:6, 22–23 and 16:4 — the council was "the apostles and elders":
  "the apostles and the elders came together to look into this matter" (15:6),
  "it seemed good to the apostles and the elders, with the whole church"
  (15:22), the letter went from "The apostles and the brothers who are elders"
  (15:23), and the decrees were those "decided upon by the apostles and elders
  who were in Jerusalem" (16:4). -/
  | acts15ApostlesAndElders
  /-- Acts 1:20 — Peter, of Judas: "For it is written in the book of Psalms,
  'Let his residence be made desolate, And let no one dwell in it'; and, 'Let
  another man take his office.'" "Office" (ἐπισκοπή) is the office of oversight,
  the word from which "bishop" (ἐπίσκοπος, overseer) comes. -/
  | acts1_20BishoprickLetAnotherTake
  /-- 2 Timothy 2:2 — "And the things which you have heard from me in the
  presence of many witnesses, entrust these to faithful men who will be able to
  teach others also." -/
  | timothy2_2CommitToFaithfulMen
  /-- 1 Clement 42 and 44 — Clement of Rome, writing to Corinth near the end of
  the first century, records that the apostles "appointed the first-fruits [of
  their labours] ... to be bishops and deacons", and "afterwards gave
  instructions, that when these should fall asleep, other approved men should
  succeed them in their ministry". What Clement records, not yet what follows
  from it; in 44 he calls the same men "presbyters". -/
  | clement42_44SuccessorsAppointed
deriving DecidableEq, Repr

end TestimonyArguments.SolaScriptura
