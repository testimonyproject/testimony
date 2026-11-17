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
eliminative line needs it stated. And Paul's charge to "hold the traditions
which ye have been taught, whether by word, or our epistle" (2 Thessalonians
2:15) is a text both sides must account for, not a Roman premise
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
  /-- Identifying the canon requires an infallible authority. The hinge of the
  canon objection. -/
  | identifyingCanonRequiresInfallibleAuthority
  /-- A rival's own foundational authority is self-authenticating too, so the
  circularity charge does not discriminate between the positions. Kruger's
  parity reply. -/
  | rivalAuthorityIsAlsoSelfAuthenticating
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
  /-- John 10:35 — "the scripture cannot be broken". Jesus answers the charge
  of blasphemy from Psalm 82:6, and rests the answer on this. What the text
  says, not yet what follows from it. -/
  | john10_35ScriptureCannotBeBroken
  /-- Matthew 5:18 — "Till heaven and earth pass, one jot or one tittle shall in
  no wise pass from the law, till all be fulfilled". The jot (ἰῶτα) is the
  smallest letter, the tittle (κεραία) the smallest stroke of one. -/
  | matthew5_18LawShallNotPass
  /-- Galatians 1:8–9 — "though we, or an angel from heaven, preach any other
  gospel unto you than that which we have preached unto you, let him be
  accursed. As we said before, so say I now again, If any man preach any other
  gospel unto you than that ye have received, let him be accursed." Paul puts
  his own later preaching, and an angel's, under the gospel he had already
  preached. -/
  | galatians1_8AnotherGospelAccursed
  /-- Colossians 2:8 and 2:20–22 — "Beware lest any man spoil you through
  philosophy and vain deceit, after the tradition of men, after the rudiments
  of the world, and not after Christ"; and of the rules "Touch not; taste not;
  handle not", that they are "after the commandments and doctrines of men".
  Paul is warning a church, not the elders of Jerusalem. -/
  | colossians2_8TraditionOfMen
  /-- Acts 15:1 — "And certain men which came down from Judaea taught the
  brethren, and said, Except ye be circumcised after the manner of Moses, ye
  cannot be saved." "The manner" (ἔθος) is the custom of Moses: the oldest
  practice Israel had, and one God himself had given. What the text reports,
  not yet what follows from it. -/
  | acts15_1CircumcisionAfterMoses
  /-- Acts 15:10–11 — Peter at the council: "Now therefore why tempt ye God, to
  put a yoke upon the neck of the disciples, which neither our fathers nor we
  were able to bear? But we believe that through the grace of the Lord Jesus
  Christ we shall be saved, even as they." -/
  | acts15_10_11YokeAndGrace
  /-- Acts 15:15–17 — James at the council: "And to this agree the words of the
  prophets; as it is written, After this I will return, and will build again
  the tabernacle of David, which is fallen down ... That the residue of men
  might seek after the Lord, and all the Gentiles, upon whom my name is called".
  He quotes Amos 9:11–12. -/
  | acts15_15_17ProphetsAgree
  /-- Acts 15:23–29 — "And they wrote letters by them after this manner": the
  council's decree went to the churches as a letter, and the letter is in
  Scripture. -/
  | acts15_23_29DecreeWritten
  /-- Acts 15:28 — the council's letter: "For it seemed good to the Holy Ghost,
  and to us, to lay upon you no greater burden than these necessary things". -/
  | acts15_28SeemedGoodToTheHolyGhost
  /-- Acts 16:4 — "And as they went through the cities, they delivered them the
  decrees for to keep, that were ordained of the apostles and elders which were
  at Jerusalem." "Delivered" (παρεδίδοσαν) is the verb whose noun is "tradition"
  (παράδοσις): the decrees were handed on. -/
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
  /-- Matthew 23:2–3 — "The scribes and the Pharisees sit in Moses' seat: All
  therefore whatsoever they bid you observe, that observe and do; but do not ye
  after their works: for they say, and do not." The "seat" (καθέδρα) is the
  teacher's chair; "observe" (τηρεῖτε) is the verb Mark 7:9 uses for keeping
  "your own tradition". What the text says, not yet what follows from it. -/
  | matthew23_2_3MosesSeat
  /-- Matthew 23:16–22 — "Woe unto you, ye blind guides, which say, Whosoever
  shall swear by the temple, it is nothing; but whosoever shall swear by the
  gold of the temple, he is a debtor!" A teaching of the scribes, about which
  oaths bind, that Jesus condemns in the same discourse in which he tells the
  crowd to observe what they bid. -/
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
  "of these men which have companied with us all the time that the Lord Jesus
  went in and out among us, Beginning from the baptism of John, unto that same
  day that he was taken up from us, must one be ordained to be a witness with us
  of his resurrection." What the text says, not yet what follows from it. -/
  | acts1_21_22WitnessOfResurrection
  /-- 1 Corinthians 15:8 — Paul, at the end of the list of those to whom the
  risen Christ appeared: "And last of all he was seen of me also, as of one born
  out of due time." -/
  | corinthians15_8LastOfAll
  /-- 2 Peter 3:15–16 — "our beloved brother Paul also according to the wisdom
  given unto him hath written unto you; As also in all his epistles ... which
  they that are unlearned and unstable wrest, as they do also the other
  scriptures". Paul's letters are counted with "the other scriptures". -/
  | peter3_15_16PaulsEpistlesWithTheScriptures
  /-- 2 Corinthians 1:1 and Colossians 1:1 — "Paul, an apostle of Jesus Christ by
  the will of God, and Timothy our brother" (2 Corinthians; Colossians has
  "Timotheus our brother"). Paul calls himself an apostle and his companion a
  brother. -/
  | salutationsApostleAndBrother
  /-- 1 Thessalonians 2:6, with 1:1 — the letter is from "Paul, and Silvanus, and
  Timotheus", and it says "we might have been burdensome, as the apostles of
  Christ" (2:7 in the Greek editions, where "burdensome" is ἐν βάρει, "of
  weight"). Whether "apostles" here takes in Silvanus and Timothy the text
  does not settle. Calvin takes it of Paul, "inasmuch as he was an Apostle of Christ";
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
  /-- Acts 15:6, 22–23 and 16:4 — the council was "the apostles and elders": "the
  apostles and elders came together for to consider of this matter" (15:6), "it
  pleased the apostles and elders, with the whole church" (15:22), the letter
  went from "The apostles and elders and brethren" (15:23), and the decrees were
  those "ordained of the apostles and elders which were at Jerusalem" (16:4). -/
  | acts15ApostlesAndElders
  /-- Acts 1:20 — Peter, of Judas: "For it is written in the book of Psalms, Let
  his habitation be desolate, and let no man dwell therein: and his bishoprick
  let another take." "Bishoprick" (ἐπισκοπή) is the office of oversight. -/
  | acts1_20BishoprickLetAnotherTake
  /-- 2 Timothy 2:2 — "And the things that thou hast heard of me among many
  witnesses, the same commit thou to faithful men, who shall be able to teach
  others also." -/
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
