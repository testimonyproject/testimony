import Testimony.Text

/-!
# Testimony.Semantics.Vocabulary — the words meanings are built from

**A draft.** One vocabulary for the whole library: who speaks, the words of the
texts, what those words can mean, what doctrine is about, and how one thing can
stand to another. It is shared, not per argument, because that is what lets two
arguments — or an argument and an article — be compared at all: a claim about
δικαιόω in one is a claim about δικαιόω in the other.

It grows from the claims. A constructor is added when a claim needs it, and the
docstring says what it denotes; nothing is added for completeness. A claim the
vocabulary cannot yet say is marked unanalysed (`Statement.opaque`), not forced.
-/

namespace Testimony.Semantics

/-- Who speaks, writes, holds or reads: a biblical author, a council, a reader,
a school. -/
inductive Voice
  /-- The apostle Paul. -/
  | paul
  /-- James, the author of the letter. -/
  | james
  /-- Luke, the author of Luke–Acts. -/
  | luke
  /-- The fourth evangelist. -/
  | john
  /-- The first evangelist. -/
  | matthew
  /-- The apostle Peter. -/
  | peter
  /-- Jesus, as the Gospels report his words. -/
  | jesus
  /-- The Council of Trent. -/
  | trent
  /-- The Catholic Church's later teaching: the *Catechism*, encyclicals. -/
  | catholicMagisterium
  /-- Augustine of Hippo. -/
  | augustine
  /-- Thomas Aquinas. -/
  | aquinas
  /-- Martin Luther. -/
  | luther
  /-- John Calvin. -/
  | calvin
  /-- The Reformed confessions and their theologians. -/
  | reformed
  /-- Leonard Feeney and those who read Trent's baptismal canons as he did. -/
  | feeney
  /-- The Latin West after Augustine, reading *iustificare*. -/
  | latinWest
  /-- Second Temple Judaism, as Sanders describes it. -/
  | secondTempleJudaism
  /-- The writer or speaker of a modern article under examination. -/
  | author
  /-- The translators of an ancient version, as their translation reads: the
  Septuagint's, the Targum's, the Peshitta's. The version is named by its
  textual tradition (`Testimony.TextualTradition`), so the vocabulary does not
  name it a second time. -/
  | version (t : TextualTradition)
  /-- Aquila, Symmachus and Theodotion: the Jewish versions of the Greek
  Scriptures that the fathers name together, against the Septuagint. -/
  | theThree
deriving DecidableEq, Repr

/-- A word or fixed phrase, in the language its text is written in. A lexeme is
the word, not its meaning: what it means is a `Statement.means`. -/
inductive Lexeme
  /-- δικαιόω, to justify. -/
  | dikaioo
  /-- δίκαιος, righteous: the adjective of δικαιόω's family, as Romans 5:19 has it,
  "the many will be made righteous" (δίκαιοι κατασταθήσονται). -/
  | dikaios
  /-- δικαιοσύνη θεοῦ, the righteousness of God. -/
  | dikaiosyneTheou
  /-- ἔργα νόμου, works of the law. -/
  | ergaNomou
  /-- ἔργα, works, without "of the law". -/
  | erga
  /-- πίστις, faith. -/
  | pistis
  /-- πίστις Χριστοῦ, the faith of, or in, Christ. -/
  | pistisChristou
  /-- πιστεύω, to believe. -/
  | pisteuo
  /-- σῴζω, to save, or to heal. -/
  | sozo
  /-- λογίζομαι, to reckon, to count. -/
  | logizomai
  /-- ἀνακαίνωσις, renewal. -/
  | anakainosis
  /-- ἁγιασμός, sanctification. -/
  | hagiasmos
  /-- ζυγός, the yoke of Acts 15:10. -/
  | zygos
  /-- ὕδωρ, the water of John 3:5. -/
  | hydor
  /-- πῦρ, the fire of Matthew 3:11. -/
  | pyr
  /-- Doing the will of the Father (Matthew 7:21). -/
  | doingTheWill
  /-- Keeping the commandments (Matthew 19:17). -/
  | keepingTheCommandments
  /-- μόνος, alone. -/
  | monos
  /-- Latin *iustificare*. -/
  | iustificare
  /-- German *allein*, alone. -/
  | allein
  /-- πίστεως μόνον, "faith alone" — the phrase, as James 2:24 has it. -/
  | faithAlonePhrase
  /-- Hebrew עַלְמָה (Isaiah 7:14). -/
  | almah
  /-- Greek παρθένος, the Septuagint's word at Isaiah 7:14. -/
  | parthenos
  /-- Greek νεᾶνις, a young woman: Aquila's, Symmachus's and Theodotion's word
  at Isaiah 7:14. -/
  | neanis
  /-- Aramaic עוּלֵימְתָא, a young woman: the Targum's word at Isaiah 7:14. -/
  | ulemta
  /-- Syriac ܒܬܘܠܬܐ, a virgin: the Peshitta's word at Isaiah 7:14. -/
  | btulta
  /-- ζάω, to live: "the righteous shall live by faith" (Habakkuk 2:4, as
  Galatians 3:11 and Hebrews 10:38 quote it). -/
  | zao
  /-- εὐαρεστέω, to please: "without faith it is impossible to please him"
  (Hebrews 11:6). -/
  | euaresteo
  /-- περιποίησις ψυχῆς, the preserving of the soul: what Hebrews 10:39 says
  belongs to those "of faith". -/
  | peripoiesisPsyches
  /-- "Whoever hears my word and believes" (ὁ τὸν λόγον μου ἀκούων καὶ πιστεύων):
  the phrase, as John 5:24 has it, hearing and believing together. -/
  | hearingAndBelieving
  /-- "Faith by itself" (ἡ πίστις … καθ' ἑαυτήν): the phrase, as James 2:17 has it,
  of faith "if it does not have works". -/
  | faithByItself
  /-- νεκρός, dead: what James 2:17 and 2:26 call faith without works. -/
  | nekros
  /-- "Faith was completed" (ἡ πίστις ἐτελειώθη): the phrase, as James 2:22 has it,
  of Abraham's faith and his works. -/
  | faithCompleted
  /-- ἔλεος, mercy: "according to his own mercy he saved us" (Titus 3:5). -/
  | eleos
  /-- ὄνομα, name: "through his name" (Acts 10:43). -/
  | onoma
  /-- γραφή, scripture: "all scripture" (πᾶσα γραφή) at 2 Timothy 3:16. -/
  | graphe
  /-- θεόπνευστος, God-breathed, breathed out by God (2 Timothy 3:16). -/
  | theopneustos
  /-- ὠφέλιμος, profitable, useful: "profitable for teaching, for reproof, for
  correction, and for training in righteousness" (2 Timothy 3:16). -/
  | ophelimos
  /-- "Complete, equipped for every good work" (ἄρτιος … πρὸς πᾶν ἔργον ἀγαθὸν
  ἐξηρτισμένος): what 2 Timothy 3:17 says scripture's profit is for. -/
  | equippedForEveryGoodWork
  /-- λόγος τοῦ θεοῦ, the word of God, as Mark 7:13 has it: "making void the word
  of God by your tradition". The phrase as the text uses it, not the concept a
  party gives it (`Concept.wordOfGod`). -/
  | logosTouTheou
  /-- παράδοσις, tradition: what is handed on. 2 Thessalonians 2:15's
  "traditions", and Mark 7's "tradition of the elders". -/
  | paradosis
deriving DecidableEq, Repr

/-- What a word can mean: a fixed inventory of senses, each named for what it
denotes. A sense belongs to no word in particular; `Statement.means` pairs them.
-/
inductive Sense
  /-- A woman who has not known a man. -/
  | virgin
  /-- A young woman of marriageable age, whether or not she is a virgin. -/
  | youngWoman
  /-- A verdict: to declare righteous, the opposite of to condemn. -/
  | verdict
  /-- To make righteous: inward renewal. -/
  | makeRighteous
  /-- To show to be righteous: a vindication before others. -/
  | showRighteous
  /-- Human works in general: any doing put forward before God. -/
  | worksInGeneral
  /-- The marks of Israel's covenant belonging: circumcision, food laws,
  sabbath. -/
  | boundaryMarkers
  /-- The law of Moses as a whole, taken as a condition of salvation. -/
  | lawAsCondition
  /-- Deeds that grow out of faith. -/
  | worksOfFaith
  /-- Deeds done without grace, before faith, by the will's own strength: the
  works Bellarmine holds Paul excludes from justification. -/
  | worksWithoutGrace
  /-- Trust in Christ, receiving and bringing nothing: faith as Calvin's
  "passive work". -/
  | trust
  /-- Faith living through charity, the source of good works. -/
  | formedFaith
  /-- Assent without works: the faith the demons also have. -/
  | mereAssent
  /-- The believer's faith directed at Christ: an objective genitive. -/
  | faithInChrist
  /-- Christ's own faithfulness: a subjective genitive. -/
  | faithfulnessOfChrist
  /-- Salvation, rather than physical healing. -/
  | salvation
  /-- Physical healing. -/
  | healing
  /-- To credit to someone's account. -/
  | reckoning
  /-- God's act of delivering the world in Christ. -/
  | deliverance
  /-- A status granted to those who meet a condition. -/
  | statusGranted
  /-- Baptismal water. -/
  | baptismalWater
  /-- Natural birth: the waters of the womb. -/
  | naturalBirth
  /-- The cleansing promised in Ezekiel 36:25–27. -/
  | ezekielsCleansing
  /-- The Spirit's own cleansing: "water and Spirit" naming one thing. -/
  | spiritsCleansing
  /-- Judgment: the chaff burned. -/
  | judgment
  /-- Purification, as fire refines gold. -/
  | purification
  /-- Pentecost: tongues as of fire. -/
  | pentecost
  /-- A condition of entering life in its own right. -/
  | groundOfEntry
  /-- What the law requires, said so that its hearer sees he has not kept it.
  -/
  | lawsOwnTerms
  /-- Including believing in Christ. -/
  | includesBelieving
deriving DecidableEq, Repr

/-- The things doctrinal claims are about. -/
inductive Concept
  /-- Justification. -/
  | justification
  /-- Salvation. -/
  | salvation
  /-- Sanctification: the renewal of the inward man. -/
  | sanctification
  /-- Faith. -/
  | faith
  /-- Works, of any kind. -/
  | works
  /-- Works done in grace, growing out of faith. -/
  | worksOfFaith
  /-- Grace. -/
  | grace
  /-- The remission of sins. -/
  | forgiveness
  /-- Christ's death for our sins. -/
  | christsDeath
  /-- Water baptism. -/
  | baptism
  /-- The desire for baptism. -/
  | desireForBaptism
  /-- The gift of the Holy Spirit. -/
  | spirit
  /-- The law of Moses. -/
  | law
  /-- Circumcision. -/
  | circumcision
  /-- Love of God and neighbour. -/
  | charity
  /-- Entry into the kingdom, or into life. -/
  | eternalLife
  /-- God. -/
  | god
  /-- Scripture. -/
  | scripture
  /-- The gospel Paul received and delivered. -/
  | gospel
  /-- An increase of justification. -/
  | increaseOfJustification
  /-- Covenant membership: entering, and staying in. -/
  | covenant
  /-- The cleansing of the heart. -/
  | cleansing
  /-- What cannot err. -/
  | infallible
  /-- A rule of faith: what faith is measured by. -/
  | ruleOfFaith
  /-- Any candidate rule of faith other than Scripture. -/
  | otherRuleOfFaith
  /-- The word of God, as each party uses the phrase. -/
  | wordOfGod
  /-- Human tradition: what the Church hands on. -/
  | tradition
  /-- Commandments of men (Isaiah 29:13, as Mark 7:7 quotes it). -/
  | commandmentsOfMen
  /-- The consensus of the Church's creeds. -/
  | creedalConsensus
  /-- Scripture's clear sense: what it plainly teaches. -/
  | clearSenseOfScripture
  /-- Reading Scripture: the act, not what it yields. -/
  | readingScripture
  /-- The teaching office of the Church of Rome. -/
  | magisterium
  /-- Controversies of religion: the questions a rule of faith decides. -/
  | controversiesOfReligion
  /-- The Messiah's birth. -/
  | messiahsBirth
  /-- A birth with no human father. -/
  | birthWithoutHumanFather
  /-- Virginity: having not known a man. -/
  | virginity
  /-- Christ baptizing believers in the Spirit, as John promised. -/
  | christBaptizingInTheSpirit
  /-- The Spirit baptizing believers into the body of Christ. -/
  | spiritBaptizingIntoTheBody
  /-- The episodes of Acts in which believers receive the Spirit: Samaria,
  Cornelius's household, Ephesus. -/
  | actsSpiritEpisodes
  /-- A pattern for believers today. -/
  | patternForBelievers
  /-- An unrepeatable step in the gospel's spread. -/
  | unrepeatableTransition
  /-- The human will: the power by which a person consents or refuses. -/
  | will
  /-- The act of believing: a person's consent to the gospel, when it happens.
  -/
  | actOfBelieving
  /-- The ability to believe: what a person must have before any act of
  believing, whether or not it is used. -/
  | abilityToBelieve
  /-- Regeneration: being made alive by God (Ephesians 2:5), the new birth. -/
  | regeneration
  /-- The will's disposing and preparing itself for justification, as Trent's
  sixth session describes it (canon 4). -/
  | preparationForJustification
  /-- Not being condemned: what John 3:18 says of whoever believes ("is not
  condemned"), and John 5:24 calls not coming into judgement. -/
  | noCondemnation
  /-- A verdict: a judge's declaration, acquitting or condemning. -/
  | verdict
  /-- Election: being among those God has chosen to save. A role a person holds
  by God's choice, not a quality in them; the dispute over perseverance is over
  who holds it. -/
  | election
  /-- Perseverance: continuing in grace to the end of life. A process, which
  either lasts to the end or does not. -/
  | perseverance
  /-- What must be known, believed and observed for salvation (Westminster
  Confession I.6–7): essential doctrine, in Geisler's word. -/
  | essentialDoctrine
  /-- Understanding Scripture: coming to know what it means. Not the act of
  reading it (`readingScripture`), nor the sense it yields
  (`clearSenseOfScripture`). -/
  | understandingScripture
  /-- The historical-grammatical method: reading a text for what its words meant
  in their own language, grammar and historical setting. -/
  | historicalGrammaticalMethod
  /-- A source of revelation: something from which revealed truth is drawn. -/
  | sourceOfRevelation
  /-- Unwritten tradition: teaching on faith or morals, or a rule of practice,
  said to have been handed on from the apostles by word of mouth and not
  written in Scripture. Trent's "unwritten traditions" (Session IV). -/
  | unwrittenTradition
  /-- Shown to be apostolic: proved, from evidence that can still be produced,
  to have come from the apostles, and not only claimed to. Whitaker's
  "certainly shewn" (*Disputation*, question VI, chapter IV). -/
  | shownApostolic
  /-- An infallible interpreter of Scripture: one whose interpretation of it
  cannot err. -/
  | infallibleInterpreter
  /-- The mind of the Church, as the Orthodox speak of it: expressed in the
  consensus of the Fathers and in the conciliar decisions the whole Church has
  received. -/
  | mindOfTheChurch
  /-- An infallible authority: one that cannot err in what it decides. -/
  | infallibleAuthority
  /-- Identifying the canon: coming to know which books are Scripture. -/
  | identifyingTheCanon
  /-- The Church's reception of the canon: its receiving, over the early
  centuries, of these books and not others as Scripture. -/
  | receptionOfTheCanon
  /-- Ministerial authority: real authority that serves the word it answers to
  and can be corrected by it — "ministerial, not magisterial". -/
  | ministerialAuthority
  /-- The individual believer, judging for himself. -/
  | individualBeliever
  /-- Choosing which body's authority to submit to. -/
  | choosingAnAuthority
  /-- An act of private judgement: an individual's own judgement in a matter of
  faith. -/
  | privateJudgment
  /-- A circular argument: what it concludes is among what it rests on, so that
  only a reader who grants its conclusion grants its premises. -/
  | circularArgument
  /-- An appeal to an ultimate authority: arguing for a rule of faith from that
  rule itself, there being no higher authority to appeal to. -/
  | appealToUltimateAuthority
  /-- A length of time, in minutes. -/
  | minutes (n : Nat)
deriving DecidableEq, Repr

/-- The relations doctrinal claims are built from. A fixed set, so that two
claims using the same relation can be compared; each says how its first term
stands to its second. -/
inductive Rel
  /-- The first is the ground of the second: what it rests on. -/
  | groundOf
  /-- The first is the means by which the second is received. -/
  | instrumentOf
  /-- The first is the only means by which the second is received. -/
  | soleInstrumentOf
  /-- The first is necessary for the second. -/
  | necessaryFor
  /-- The first suffices for the second. -/
  | sufficientFor
  /-- The first is not a ground of the second. -/
  | excludedFrom
  /-- The first includes the second, as part of what it is. -/
  | includes
  /-- The first and the second are distinct. -/
  | distinctFrom
  /-- The first and the second are never given apart. -/
  | inseparableFrom
  /-- The first is the fruit and evidence of the second. -/
  | fruitOf
  /-- The first merits the second. -/
  | merits
  /-- The first grows through the second. -/
  | growsThrough
  /-- The first comes before the second. -/
  | precedes
  /-- The first is the whole ground of the second: nothing added completes it.
  -/
  | soleGroundOf
  /-- The first is the one who does the second. -/
  | agentOf
  /-- The first is bound to the second: given only through it. -/
  | boundTo
  /-- The first is consistent with the second. -/
  | consistentWith
  /-- The second is said to be "by" the first, as the text has it (ἐκ, "from",
  "by"), leaving open whether the first is its ground, its means or its
  evidence. Textual statements use it where a reading would choose. -/
  | saidBy
  /-- The first is one of the second: a kind, or a property it has. -/
  | isA
  /-- The first may rightly be bound on the Church as the second. -/
  | bindsAs
  /-- The first judges the second: is its measure, and voids what contradicts
  it. -/
  | judges
  /-- The first settles the second, finally: no appeal lies beyond it. -/
  | settles
  /-- The first, an occurrence, lasts the second, a length of time. DOLCE's
  temporal location of a perdurant; BFO's *occupies temporal region*. -/
  | lasts
  /-- The first, an occurrence, begins when the second begins: Allen's *starts*,
  or *equals*. -/
  | startsWith
  /-- The first, an occurrence, ends when the second ends: Allen's *finishes*,
  or *equals*. -/
  | endsWith
  /-- The first is part of the second: DOLCE's and BFO's *part of*. -/
  | partOf
  /-- The first brings about the second, so that the second does not fail to
  follow: an efficient cause that cannot be frustrated. -/
  | effects
  /-- The first makes the second void: sets it aside, so that it no longer
  binds. What Mark 7:13 says the elders' tradition does to the word of God
  (ἀκυρόω). -/
  | voids
deriving DecidableEq, Repr

/-- **How two different words are kin**, so that an argument may be tempted to
read one by the other. -/
inductive Kinship
  /-- Words of one family in one language: a verb and its adjective. Reading one
  by the other is what Barr called the root fallacy. -/
  | cognate
  /-- A word and the word a version puts for it: the Latin or the Greek of the
  same text. -/
  | translation
deriving DecidableEq, Repr

/-- **Which words are kin, and how**, in either order. The table is the
vocabulary's own, and it grows with the vocabulary: a pair is added when two of
its words are both in it. -/
def Lexeme.kin (w v : Lexeme) : Option Kinship :=
  let pairs : List (Lexeme × Lexeme × Kinship) :=
    [ (.dikaios, .dikaioo, .cognate), (.pistis, .pisteuo, .cognate)
    , (.iustificare, .dikaioo, .translation), (.allein, .monos, .translation)
    , (.parthenos, .almah, .translation), (.neanis, .almah, .translation)
    , (.ulemta, .almah, .translation), (.btulta, .almah, .translation) ]
  (pairs.find? fun (a, b, _) => (a == w && b == v) || (a == v && b == w)).map (·.2.2)

/-- A principle of reading, held for its own sake. -/
inductive Principle
  /-- Scripture does not contradict itself. -/
  | scriptureSelfConsistent
  /-- A word contributes the least meaning its context requires (Joos, Silva),
  and one occurrence does not carry all a word can (Barr). -/
  | leastMeaning
deriving DecidableEq, Repr

end Testimony.Semantics
