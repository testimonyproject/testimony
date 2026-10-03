import Testimony.Text

/-!
# Testimony.Semantics.Grammar — what a claim says, as a term

**A draft.** Nothing in the solver reads this module, and no result depends on
it.

Every argument names its atomic claims in an `inductive Claim` of its own, and
says what each one asserts in a docstring. The docstring is for a reader; to the
library, `dikaioIsForensic` and `romans3_28` are two opaque names. So the
library cannot answer questions a reader asks of the whole collection — *every
claim made about δικαιόω*, *every passage read two ways*, *the same claim made in
two arguments* — and it cannot see what an article does when it moves from one
passage to another under a single word.

This module gives a claim a **meaning**: a term built from a small, fixed
vocabulary. It does not replace the atoms. An argument keeps its `Claim` type,
and its proofs are untouched; a separate total function, `Claim.means`, says
what each atom asserts in the vocabulary below, as `cite` says who asserts it.

## Two levels: the word, and what it means

The vocabulary keeps apart what a text *says* and what its words *mean*. A
textual claim is stated with the words as they stand — `Term.word` — and a
claim about a word's sense is a separate statement, `Statement.means`. Romans
3:28 says that a person is *justified* by *faith* apart from *works of the law*;
what those three words denote in Paul is a further claim, and each is one the
library already disputes.

That separation is the point. Two passages contradict each other only if their
words are taken in the same senses, and an argument that sets one passage
against another is an argument about senses, whether it says so or not
(`Testimony.Semantics.Discourse`). James Barr's warning against confusing the
word with the concept is the same distinction, and the sola fide argument
already turns on it (`whatTrentsDefinitionClaims`).

## A fixed vocabulary, grown from the claims

Every constructor below was added because a claim in the library needed it. The
vocabulary is meant to grow the same way: a new claim that does not fit is a
reason to add a word, a sense or a relation, and `Statement.opaque` is the
honest fallback until then — a claim marked unanalysed, counted as such, rather
than forced into a shape that says more or less than its docstring.
-/

namespace Testimony.Semantics

open Testimony

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
deriving DecidableEq, Repr

/-- What a word can mean: a fixed inventory of senses, each named for what it
denotes. A sense belongs to no word in particular; `Statement.means` pairs them.
-/
inductive Sense
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
deriving DecidableEq, Repr

/-- Where a word is used: one passage, or an author's usage as a whole. -/
inductive Scope
  /-- One passage. -/
  | passage (p : PassageRange)
  /-- An author's or tradition's usage as a whole. -/
  | usage (v : Voice)
deriving DecidableEq, Repr

/-- What a slot in a doctrinal relation holds: a concept, or a word as it is
used somewhere, whose sense is left to a separate `Statement.means`. -/
inductive Term
  /-- A concept, named directly. -/
  | concept (c : Concept)
  /-- A word as it stands in its text. -/
  | word (w : Lexeme) (at_ : Scope)
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
deriving DecidableEq, Repr

/-- A doctrinal content: a relation between two terms, or a combination of
contents. -/
inductive Content
  /-- `a` stands in relation `r` to `b`. -/
  | rel (r : Rel) (a b : Term)
  /-- Not this content. -/
  | not (c : Content)
  /-- Both contents. -/
  | both (c d : Content)
deriving DecidableEq, Repr

/-- A principle of reading, held for its own sake. -/
inductive Principle
  /-- Scripture does not contradict itself. -/
  | scriptureSelfConsistent
  /-- A word contributes the least meaning its context requires (Joos, Silva),
  and one occurrence does not carry all a word can (Barr). -/
  | leastMeaning
deriving DecidableEq, Repr

/-- **What one atomic claim asserts**, in the vocabulary above. -/
inductive Statement
  /-- A passage says this, in its own words. Textual: what the text asserts,
  not what its words are taken to mean. -/
  | says (p : PassageRange) (c : Content)
  /-- A passage, read rightly, teaches this. Interpretive: a reading of the
  text, which a rival may read otherwise. Never the same claim as `says`. -/
  | teaches (p : PassageRange) (c : Content)
  /-- A word, used in this scope, has this sense. Linguistic. -/
  | means (w : Lexeme) (sc : Scope) (s : Sense)
  /-- A word has the same sense in both scopes. Linguistic, and the claim on
  which every contradiction between two texts using the word depends. -/
  | sameSense (w : Lexeme) (a b : Scope)
  /-- A passage is written against this content. -/
  | opposes (p : PassageRange) (c : Content)
  /-- This voice wrote this book. Historical. -/
  | wrote (v : Voice) (b : Book)
  /-- This voice read a word in this sense. Historical: a claim about the
  reader, not about the word. -/
  | glosses (v : Voice) (w : Lexeme) (s : Sense)
  /-- This voice's translation of the passage has this word. Textual, about a
  translation. -/
  | renders (v : Voice) (p : PassageRange) (w : Lexeme)
  /-- This voice held this content. Historical. -/
  | heldBy (v : Voice) (c : Content)
  /-- This content is so. Doctrinal: the claim itself, whoever holds it. -/
  | holds (c : Content)
  /-- A principle of reading. -/
  | principle (h : Principle)
  /-- This word occurs in this passage. Textual, and decidable from the text. -/
  | occurs (w : Lexeme) (p : PassageRange)
  /-- This word occurs in this passage and nowhere else in the New Testament.
  -/
  | occursOnlyIn (w : Lexeme) (p : PassageRange)
  /-- Not this statement. -/
  | denied (s : Statement)
  /-- Both statements. -/
  | also (s t : Statement)
  /-- Not yet analysed. The label is the atom's docstring in brief. -/
  | opaque (label : String)
deriving DecidableEq, Repr

namespace Content

/-- The words a content uses, with where each is used. -/
def words : Content → List (Lexeme × Scope)
  | .rel _ a b =>
    (match a with | .word w sc => [(w, sc)] | .concept _ => []) ++
    (match b with | .word w sc => [(w, sc)] | .concept _ => [])
  | .not c => c.words
  | .both c d => c.words ++ d.words

end Content

namespace Statement

/-- Whether the statement is still unanalysed. -/
def isOpaque : Statement → Bool
  | .opaque _ => true
  | _ => false

/-- The words a statement turns on, with where each is used. -/
def words : Statement → List (Lexeme × Scope)
  | .says _ c | .teaches _ c | .opposes _ c | .heldBy _ c | .holds c => c.words
  | .means w sc _ => [(w, sc)]
  | .sameSense w a b => [(w, a), (w, b)]
  | .renders v p w => [(w, .usage v), (w, .passage p)]
  | .glosses v w _ => [(w, .usage v)]
  | .occurs w p | .occursOnlyIn w p => [(w, .passage p)]
  | .denied s => s.words
  | .also s t => s.words ++ t.words
  | .wrote .. | .principle _ | .opaque _ => []

/-- The lexemes a statement turns on. -/
def lexemes (s : Statement) : List Lexeme := s.words.map Prod.fst

/-- Whether the statement turns on this word. -/
def mentions (s : Statement) (w : Lexeme) : Bool := s.lexemes.contains w

/-- The senses a statement asserts words to have, where it asserts them: through
`also`, and not under `denied`. -/
def senses : Statement → List (Lexeme × Scope × Sense)
  | .means w sc s => [(w, sc, s)]
  | .also s t => s.senses ++ t.senses
  | _ => []

end Statement

/-- Every pair of different senses that a list of statements gives the same word
at the same scope: where the claims, taken together, read one word two ways. A
reading of a passage contested in the library shows up here; so does an
argument that slides between two of them. -/
def readTwoWays (ss : List Statement) : List (Lexeme × Scope × Sense × Sense) :=
  let senses := ss.flatMap Statement.senses
  senses.flatMap fun (w, sc, s) =>
    senses.filterMap fun (w', sc', s') =>
      if w = w' ∧ sc = sc' ∧ s ≠ s' then some (w, sc, s, s') else none

end Testimony.Semantics
