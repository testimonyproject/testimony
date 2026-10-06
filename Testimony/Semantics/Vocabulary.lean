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
deriving DecidableEq, Repr

/-- A word or fixed phrase, in the language its text is written in. A lexeme is
the word, not its meaning: what it means is a `Statement.means`. -/
inductive Lexeme
  /-- δικαιόω, to justify. -/
  | dikaioo
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
deriving DecidableEq, Repr

/-- What a word can mean: a fixed inventory of senses, each named for what it
denotes. A sense belongs to no word in particular; `Statement.means` pairs them.
-/
inductive Sense
  /-- A woman who has not known a man. -/
  | virgin
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
deriving DecidableEq, Repr

/-- A principle of reading, held for its own sake. -/
inductive Principle
  /-- Scripture does not contradict itself. -/
  | scriptureSelfConsistent
  /-- A word contributes the least meaning its context requires (Joos, Silva),
  and one occurrence does not carry all a word can (Barr). -/
  | leastMeaning
deriving DecidableEq, Repr

end Testimony.Semantics
