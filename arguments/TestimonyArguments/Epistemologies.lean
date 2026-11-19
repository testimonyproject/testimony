import Testimony.Logic.Epistemology
import TestimonyArguments.SolaFide
import TestimonyArguments.CanonicalWitness
import TestimonyArguments.SolaScriptura

/-!
# TestimonyArguments.Epistemologies — the rules each side professes, and whether it keeps them

**A draft, phase one.** A Protestant and a Catholic who argue over Romans 3:28 seldom argue
only over Romans 3:28. Underneath is a disagreement about how anything is known from Scripture
at all. The Westminster Confession says that "the infallible rule of interpretation of
Scripture is the Scripture itself" (I.ix), and that the supreme judge of controversies "can be
no other but the Holy Spirit speaking in the Scripture" (I.x). The Council of Trent receives,
beside the written books, the traditions "received by the Apostles from the mouth of Christ
himself, or from the Apostles themselves, the Holy Ghost dictating" (Session IV), and the
Second Vatican Council says the two are to be accepted with the same devotion (*Dei Verbum* 9).
The library's own evidence standard asks for neither: only the texts, and evidence anyone can
check.

Each is written here as an **epistemology**: what it admits as grounds, whether a step resting
on Scripture alone may be answered only from Scripture, and who holds it, cited
(`Testimony.Logic.Epistemology`). A fourth, the Orthodox, is cited to Florovsky and Ware.
Westminster's rule is exactly the library's scriptural standard, and the library's own rule its
evidence standard (`two_standards_are_rules`). The tradition standard is neither the Catholic
rule nor the Orthodox one, because it admits authority from every tradition at once, and each
of those admits only its own. No rating moves.

## Does each side keep its own rule?

A reading is held to the rule of the side whose reading it is. That is declared below, party by
party, with the reason; it is not read off the citations, because a Reformed reading may cite a
Catholic exegete and stay Reformed. Then every claim a party asserts is checked against its own
rule. Its steps are not, yet: a step's citation records who disputes it, not what it rests on.
A party that asks its rival for Scripture and rests a claim on a confession's word alone keeps
two rules.

Every party held to a rule keeps it (`sola_fide_own_rules`). The closest case is sola fide from
John 6. It reads "believe" (πιστεύω) at John 6:29, "that you believe in him whom he has sent", in
the sense the word has in "whoever believes in him" at John 3:16 and 3:18, and it needs the word
to keep that sense between them. Calvin and Aquinas both read it so, and they are theologians,
whose word Westminster's rule does not admit. But the premise rests on more than their word. The
Greek of both passages has the same construction, πιστεύειν εἰς, "believe into", and no edition
in the apparatus of the SBL Greek New Testament reads otherwise at those verses
(`john_believing_into_in_both_passages`). Thayer's lexicon lists all three verses under one sense
of the phrase, "to have a faith directed unto … Jesus" (p. 511), and Moulton's grammar gives the
construction one meaning, "believe in", set against the bare dative (pp. 67–68). A lexicon and a
grammar are evidence anyone can check, and Westminster's rule admits evidence.

The other Reformed readings did not keep their rule either when the check was first run, and what
the check found changed the encoding. Four Reformed readings — sola fide from Paul, from Peter at
Jerusalem and from John 6, and the Reformed answer to Chrysostom — each assert that justification
and sanctification are inseparable but distinct: that God's pardoning and accepting a sinner, and
his making that sinner holy over a life, always go together and are not the same thing. The
library had cited that claim to the Westminster Confession and to Calvin alone, so by
Westminster's own rule, which admits Scripture and evidence and not a confession's word, the four
rested a claim on what they refuse their rival.

The fault was the encoding's, not the readings'. A Reformed reader cites the Confession as a
summary pointing to its Scripture proofs, and the library had cited the summary without the
proofs. Worse, it had cited the wrong summary: Confession XIII.1 is about sanctification and
does not state the claim. The Larger Catechism does, at question 77: sanctification is
"inseparably joined with justification, yet they differ", with a proof under each clause. The
claim is cited there now, with those proofs, and the four readings keep their rule.

Trent's readings keep their rule, and the check could have failed them. Each rule admits
authority only from its own tradition, so a Catholic reading resting a claim on Westminster's
word would fail Trent's rule as a Reformed one resting a claim on Trent's word fails
Westminster's. Trent's reading of justification rests two claims on Catholic authority alone,
and the two rules part exactly there: Trent's admits both, Westminster's refuses both
(`trent_keeps_its_own_rule`).

Three parties are held to no rule. Aquinas, Luther and Chrysostom wrote neither Trent's rule,
nor Westminster's, nor the Orthodox one as Florovsky states it. The library cites none of
their own as a rule; holding them to another's would give them a rule they did not write.
Chrysostom is a Father whom the Orthodox and the Catholic traditions both receive, and calling
him either's would be a claim the library does not argue.

## The canonical witness

The canonical witness has no dispute, so its parties are its positions. The Reformed case, with
James and without, and Paul's claim about faith profess Westminster's rule; Trent's two readings
of James profess Trent's; and the ten positions the library builds by striking readings out of
the canonical case are held to none, because no one argues them. Every position keeps its rule,
and every other rule as well (`canonical_witness_own_rules`). That is because every claim each
position asserts rests on Scripture: the texts are cited to Scripture alone, and the three
readings the case with James asserts as claims are cited to the verses they read as well as to
Moo, Calvin and the Larger Catechism. Here the rules cannot part the sides, because the sides
part in their steps, which the check does not reach.
## The dispute over Mark 7

The sola scriptura argument's one dispute asks what Jesus' rebuke of the elders' tradition in
Mark 7 settles between Rome and the Reformers. Its parties are held to their rules the same
way. Mark 7's case for sola scriptura is the Reformed reading and professes Westminster's rule;
Trent, as it states its position and with its tradition read as the apostolic word, professes
Trent's. Mark 7's principle, that God's word judges human tradition, is common ground, granted
by Rome in *Dei Verbum* 10, and is held to no rule; it happens to meet all four
(`marks_principle_meets_every_rule`). Trent read as commandments of men is held to none,
because no one holds it: Trent denies the reading and Calvin, whose reading it is, denies
Trent.

Here the check finds a fault. Mark 7's case rests the claim its last step needs, that no
unwritten tradition can now be shown to be apostolic and so none can bind the conscience as
God's word, on Whitaker's word and the Westminster Confession's, and Westminster's rule admits
neither as a ground. So the Reformed case from Mark 7 asks its rival for Scripture and, at that
one claim, does not give it (`sola_scriptura_own_rules`). The claim is stated as narrowly as
Whitaker states it, as a claim about what can be proved and not about what the apostles once
said, and that does not change what it rests on. Trent's readings keep their rule.

## What it does not claim

It does not say which epistemology is right: that is what the sola scriptura dispute is about.
It does not weigh anything: no verdict and no rating reads it. It checks claims, not steps. And
it says nothing of parties outside the sola fide dispute, the dispute over Mark 7 and the
canonical witness, nor of the sola scriptura argument's packages that no dispute weighs yet.
-/

namespace TestimonyArguments.Epistemologies

open Testimony Testimony.Logic Testimony.Semantics TestimonyArguments.SolaFide

/-- **Scripture its own interpreter**: the Reformed rule. Scripture, and the evidence anyone can
check, are grounds; a council's, a confession's or a theologian's word is not; and a step that
rests on Scripture alone is answered only from Scripture. Westminster I.ix: "The infallible rule
of interpretation of Scripture is the Scripture itself"; I.x, the supreme judge is "the Holy
Spirit speaking in the Scripture"; I.viii, the Hebrew and Greek texts as those to which the
Church finally appeals, which is what admits critical texts and lexica as evidence. Westminster
does not speak to arguments from silence, so neither does this, and no principle of reading is
recorded for it until one is cited in its words. -/
def scriptureItsOwnInterpreter : Epistemology :=
  { name := "Scripture its own interpreter"
  , statement := "Scripture, and evidence anyone can check, are grounds; no council's or " ++
      "confession's word is; and what rests on Scripture alone is answered from Scripture."
  , admits := fun w => w == .scripture || w == .evidence
  , scriptureAlone := true
  , principles := []
  , silence := none
  , source :=
      { primary := .work westminsterConfession (.sectionRef "I.ix")
      , supporting :=
          [ .work westminsterConfession (.sectionRef "I.vi")
          , .work westminsterConfession (.sectionRef "I.viii")
          , .work westminsterConfession (.sectionRef "I.x") ]
      , tradition := .reformedProtestant
      , confidence := .consensus } }

/-- **Scripture and tradition**: the Catholic rule. Scripture and the tradition received from
the Apostles are grounds, received together, with evidence; and no step is answered from
Scripture alone. Trent, Session IV, receives the traditions "received by the Apostles from the
mouth of Christ himself, or from the Apostles themselves, the Holy Ghost dictating" (Waterworth's
translation, p. 18); *Dei Verbum* 9 holds the two together.

It admits authority from the Catholic tradition only: a council's, a Father's or the Church's
teaching as the Catholic tradition receives it, and not Westminster's word or Calvin's. Whose
authority a claim rests on is read from the tradition its citation records as advancing it, which
is a proxy, not a record of who wrote each work. Neither source speaks to arguments from silence,
and no principle of reading is recorded until one is cited in its words. -/
def scriptureAndTradition : Epistemology :=
  { name := "Scripture and tradition"
  , statement := "Scripture and the apostolic tradition, received together, are grounds, with " ++
      "evidence; no step is answered from Scripture alone."
  , admits := fun w => w != .assertion
  , authorityFrom := some .romanCatholic
  , scriptureAlone := false
  , principles := []
  , silence := none
  , source :=
      { primary := .work tannerDecrees
          (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions")
      , supporting :=
          [ .work waterworthTrent (.page 18)
          , .work tannerDecrees (.sectionRef "Vatican II (1965), Dei Verbum 9") ]
      , tradition := .romanCatholic
      , confidence := .consensus } }

/-- **Scripture in the mind of the Church**: the Orthodox rule. Scripture is read within the
Church's Tradition, which adds nothing to Scripture but is its living interpretation: the mind
of the Church, in the consensus of the Fathers and in received conciliar decisions. So
Scripture, evidence, and the authority of the Fathers and councils as the Orthodox Church
receives them are grounds, and no step is answered from Scripture alone. It is cited to
Florovsky and Ware, as the library's sola scriptura argument cites the Orthodox doctrine of
Tradition; Florovsky rejects the two-sources model outright, which is what sets this rule apart
from Trent's, though the grounds the two admit are alike in kind. Neither source, as cited here,
speaks to arguments from silence. -/
def scriptureInTheMindOfTheChurch : Epistemology :=
  { name := "Scripture in the mind of the Church"
  , statement := "Scripture, read within the Church's Tradition: the consensus of the Fathers " ++
      "and the received councils; no step is answered from Scripture alone."
  , admits := fun w => w != .assertion
  , authorityFrom := some .easternOrthodox
  , scriptureAlone := false
  , principles := []
  , silence := none
  , source :=
      { primary := .work florovskyBibleChurchTradition .whole
      , supporting := [.work wareOrthodoxChurch .whole]
      , tradition := .easternOrthodox
      , confidence := .consensus } }

/-- **Evidence anyone can check**: the library's own rule, for its evidence standard. The texts
and argued scholarship are grounds; no one's word is, by itself; no step is kept to Scripture
alone; and a word means no more than its context needs, the principle the library cites to
Silva. No historian is cited as holding the rule as a whole, so it is cited as the library's
own. -/
def evidenceAnyoneCanCheck : Epistemology :=
  { name := "Evidence anyone can check"
  , statement := "The texts and argued scholarship are grounds; no one's word is, by itself."
  , admits := fun w => w == .scripture || w == .evidence
  , scriptureAlone := false
  , principles := [.leastMeaning]
  , silence := none
  , source :=
      { primary := .proposal
          ("The evidence standard of the credibility checks (Testimony.Logic.Credibility): " ++
           "\"Scripture, and evidence anyone can check.\"")
      , supporting := [.work silvaBiblicalWords .whole]
      , tradition := .christianHistoricalGrammatical
      , confidence := .consensus } }

/-- **Two of the standards are rules a side holds; the third is no one's.** The Reformed rule
admits what the scriptural standard admits, and keeps Scripture-alone steps to Scripture as it
does; the library's evidence rule admits what the evidence standard admits. So every rating
computed under those two standards is a rating under a rule someone holds.

The tradition standard is neither the Catholic rule nor the Orthodox one. It admits a council's,
a confession's or a theologian's word from any tradition, so Westminster's word and Trent's
alike; each of those rules admits authority only from its own tradition. So a rating computed
under the tradition standard is a rating under no one's rule: under every tradition's
authorities at once. Nothing computed so far moves; what changes is what a page can say the
tradition standard is. -/
theorem two_standards_are_rules :
    scriptureItsOwnInterpreter.agreesWith .scriptural = true ∧
      evidenceAnyoneCanCheck.agreesWith .evidence = true ∧
      scriptureAndTradition.agreesWith .tradition = false ∧
      scriptureInTheMindOfTheChurch.agreesWith .tradition = false := by
  decide

/-- **The rule each party to the sola fide dispute professes**, as the side whose reading it is.

- The Reformed readings — sola fide from Paul, from Jesus' words at Luke 7:50 and in John 6,
  from Peter at Jerusalem, Paul's gospel against Trent's definition, and the Reformed answer to
  Chrysostom — profess Westminster's rule.
- Trent's readings profess Trent's.
- The scholars' readings — Sanders and Dunn, their critics, the apocalyptic reading, Jervell —
  and the two arguments from Paul's word by a reading method, the lexical case and Romans 4 on
  the word, are held to the library's evidence rule: they argue as scholars, from texts and
  lexica, and profess no confession's rule.
- Aquinas, Luther and Chrysostom profess no rule the library has encoded. None of them wrote
  Trent's rule or Westminster's. Aquinas has his own (sacred doctrine argues from Scripture's
  authority as proper, from the Doctors' as probable: *Summa* I, q. 1, a. 8, ad 2), Luther's
  tradition has the Formula of Concord, and Chrysostom wrote before either; the library cites
  none of these as a rule. -/
def professes : Party → Option Epistemology
  | .pauline | .dominical | .apostolic | .gospel | .johannine | .sanctification =>
    some scriptureItsOwnInterpreter
  | .trent | .trentOnPaulsWord => some scriptureAndTradition
  | .sanders | .critics | .apocalyptic | .jervell | .lexical | .romansOnTheWord =>
    some evidenceAnyoneCanCheck
  | .aquinas | .luther | .chrysostom => none

/-- Every party, in the dispute's order. -/
def parties : List Party :=
  [ .pauline, .dominical, .apostolic, .trent, .apocalyptic, .sanders, .critics, .jervell, .gospel
  , .lexical, .trentOnPaulsWord, .romansOnTheWord, .johannine, .aquinas, .luther, .chrysostom
  , .sanctification ]

/-- The list has every party. -/
theorem parties_complete : ∀ q, q ∈ parties := by intro q; cases q <;> decide

/-- Each party, held to the rule it professes. -/
def ownRule (q : Party) : Option (OwnRule Claim) := (professes q).map (partyNode q).heldTo

/-- The parties that fail their own rule. -/
def breakTheirRule : List Party := parties.filter fun q => (ownRule q).any (!·.kept)

/-- The parties held to no rule. -/
def heldToNone : List Party := parties.filter fun q => (professes q).isNone

/-- **Every party to the sola fide dispute keeps the rule it professes.** Every claim each party
held to a rule asserts rests on what its rule admits. Sola fide from John 6 needs "believe" to
keep its sense between John 6:29 and "whoever believes in him" at John 3:16 and 3:18. That rests
on the Greek both passages share, πιστεύειν εἰς, on Thayer's lexicon, which lists the three
verses under one sense, and on Moulton's grammar, as well as on Calvin and Aquinas; so it rests
on evidence, which Westminster's rule admits. Aquinas, Luther and Chrysostom are held to none.

It did not, when this check was first run. Four Reformed readings — sola fide from Paul, from
Peter and from John 6, and the Reformed answer to Chrysostom — asserted that justification and
sanctification are inseparable but distinct, and the library cited that claim to the
Westminster Confession and to Calvin alone. Westminster's rule does not admit a confession's
word as a ground, so by their own rule the four rested a claim on what they refuse their rival.
The check also showed the citation pointing at the wrong place: Confession XIII.1 is about
sanctification and does not state the claim. The claim is stated in the Larger Catechism, Q. 77,
with its Scripture proofs, and it is cited there now, with those proofs (1 Corinthians 6:11
and 1:30; Romans 4:6, 8; Ezekiel 36:27; Hebrews 9:13–14; Romans 3:24–25; Romans 6:6, 14).

What it does not claim: that the Reformed readings are right, or that the proofs prove the
claim, nor that a construction two passages share fixes the sense the word has in both. It says
only that each claim rests on the kind of ground the readings' own rule admits. Whose authority
a claim rests on is read from the tradition its citation records, a proxy. And
it says nothing of steps, whose citations record their ratings, not what they rest on. -/
theorem sola_fide_own_rules :
    breakTheirRule = [] ∧ heldToNone = [.aquinas, .luther, .chrysostom] := by
  decide +kernel

/-- **Each rule does work: Trent's readings keep their own and fail Westminster's.** Trent's
reading of justification asserts two claims on the Catholic tradition's authority alone: that
justification is not the remission of sins only but the renewal of the inward man, and that the
justified grow in that renewal by good works done in grace. Its own rule admits both, because
they rest on authority from its own tradition. Westminster's rule refuses both, because it
admits no council's or confession's word as a ground. So the Catholic readings pass a rule that
could have failed them, and the two rules part exactly where the two sides do.

What it does not claim: that either claim is true, or that Trent's authority is wrong to bind.
It says only that each claim rests on what Trent's rule admits and Westminster's does not. -/
theorem trent_keeps_its_own_rule :
    (partyNode .trent).refusedBy scriptureAndTradition = [] ∧
      (partyNode .trent).refusedBy scriptureItsOwnInterpreter =
        [.justificationIncludesSanctification, .renewalGrowsThroughGoodWorks] := by
  decide +kernel

/-! ### The canonical witness

The canonical witness has no dispute. Its parties are its positions: the canonical case and the
case with James, Paul's claim about faith on its own, Trent's reading of James 2:24, and Trent's
reading of James against the sufficiency of faith. Beside them stand the positions the library
builds to find what the case rests on, each the canonical case with some of its readings struck
out. Each is a package, and each is held to the rule of the side whose reading it is. -/

/-- **The positions of the canonical witness**, each a package of the argument
(`TestimonyArguments.CanonicalWitness`). -/
inductive CanonicalWitnessParty
  /-- The canonical witness to faith alone: every corpus on its own reading. -/
  | canonical
  /-- The canonical witness with James: faith alone, by a faith never alone. -/
  | withJames
  /-- Paul's claim about faith on its own: necessary and sufficient. -/
  | paulOnFaith
  /-- Trent, reading James 2:24 as justification increased by works. -/
  | trent
  /-- James read against the sufficiency of faith, as Trent reads him. -/
  | jamesAgainstSufficiency
  /-- The canonical case without Paul's two readings. -/
  | withoutPaul
  /-- The canonical case without Hebrews' reading. -/
  | withoutHebrews
  /-- The canonical case without John's reading. -/
  | withoutJohn
  /-- The canonical case without Peter's reading. -/
  | withoutPeter
  /-- The canonical case without the reading of Jesus' words. -/
  | withoutJesus
  /-- The canonical case without the three readings that say works are not the ground. -/
  | withoutTheWorksWitnesses
  /-- The canonical case without the three readings that say faith is necessary. -/
  | withoutTheNecessityWitnesses
  /-- The canonical case without the four readings that say faith is sufficient. -/
  | withoutTheSufficiencyWitnesses
  /-- The canonical case with only Hebrews' reading and that of Jesus' words. -/
  | hebrewsAndJesus
  /-- The case with James, without the demonstrative reading of "justified". -/
  | withJamesUndemonstrated
deriving DecidableEq, Repr

/-- Each position's package. -/
def canonicalWitnessPackage : CanonicalWitnessParty → ArgumentPackage CanonicalWitness.Claim
  | .canonical => CanonicalWitness.canonicalCase
  | .withJames => CanonicalWitness.canonicalWithJames
  | .paulOnFaith => CanonicalWitness.paulOnFaith
  | .trent => CanonicalWitness.tridentine
  | .jamesAgainstSufficiency => CanonicalWitness.jamesReadAgainstSufficiency
  | .withoutPaul => CanonicalWitness.withoutPaul
  | .withoutHebrews => CanonicalWitness.withoutHebrews
  | .withoutJohn => CanonicalWitness.withoutJohn
  | .withoutPeter => CanonicalWitness.withoutPeter
  | .withoutJesus => CanonicalWitness.withoutJesus
  | .withoutTheWorksWitnesses => CanonicalWitness.withoutTheWorksWitnesses
  | .withoutTheNecessityWitnesses => CanonicalWitness.withoutTheNecessityWitnesses
  | .withoutTheSufficiencyWitnesses => CanonicalWitness.withoutTheSufficiencyWitnesses
  | .hebrewsAndJesus => CanonicalWitness.hebrewsAndJesus
  | .withJamesUndemonstrated => CanonicalWitness.withJamesUndemonstrated

/-- **The rule each position of the canonical witness professes**, as the side whose reading it
is.

- The canonical case, the case with James, and Paul's claim about faith profess Westminster's
  rule. They are the Reformed case: their readings are cited to Schreiner, Calvin and Moo, with
  Bruce and Marshall beside them, and what they conclude is the Reformed formula, "by faith
  alone", "by a faith that is never alone", in Westminster's words (XI.2).
- Trent's reading of James 2:24, and its reading of James against the sufficiency of faith,
  profess Trent's rule. Both are cited to its Decree on Justification (Session VI, chapter 10
  and canon 9).
- The positions with readings struck out profess no rule. No side argues any of them. The
  library builds each from the canonical case to show which readings the case rests on, and a
  rule held by no one who argues the position would be a rule given it, not one it wrote. -/
def professesCanonicalWitness : CanonicalWitnessParty → Option Epistemology
  | .canonical | .withJames | .paulOnFaith => some scriptureItsOwnInterpreter
  | .trent | .jamesAgainstSufficiency => some scriptureAndTradition
  | .withoutPaul | .withoutHebrews | .withoutJohn | .withoutPeter | .withoutJesus
  | .withoutTheWorksWitnesses | .withoutTheNecessityWitnesses | .withoutTheSufficiencyWitnesses
  | .hebrewsAndJesus | .withJamesUndemonstrated => none

/-- Every position of the canonical witness, in the order its packages are written. -/
def canonicalWitnessParties : List CanonicalWitnessParty :=
  [ .trent, .canonical, .withJames, .withoutPaul, .withoutHebrews, .withoutJohn, .withoutPeter
  , .withoutJesus, .withoutTheWorksWitnesses, .withoutTheNecessityWitnesses
  , .withoutTheSufficiencyWitnesses, .hebrewsAndJesus, .withJamesUndemonstrated, .paulOnFaith
  , .jamesAgainstSufficiency ]

/-- The list has every position. -/
theorem canonicalWitnessParties_complete : ∀ q, q ∈ canonicalWitnessParties := by
  intro q; cases q <;> decide

/-- Each position of the canonical witness, held to the rule it professes. -/
def canonicalWitnessOwnRule (q : CanonicalWitnessParty) :
    Option (OwnRule CanonicalWitness.Claim) :=
  (professesCanonicalWitness q).map (canonicalWitnessPackage q).heldTo

/-- The positions of the canonical witness that fail their own rule. -/
def canonicalWitnessBreakTheirRule : List CanonicalWitnessParty :=
  canonicalWitnessParties.filter fun q => (canonicalWitnessOwnRule q).any (!·.kept)

/-- The positions of the canonical witness held to no rule. -/
def canonicalWitnessHeldToNone : List CanonicalWitnessParty :=
  canonicalWitnessParties.filter fun q => (professesCanonicalWitness q).isNone

/-- The positions of the canonical witness that assert a claim an encoded rule refuses: any of
the four, whichever the position professes. -/
def canonicalWitnessRefusedByAnyRule : List CanonicalWitnessParty :=
  canonicalWitnessParties.filter fun q =>
    [ scriptureItsOwnInterpreter, scriptureAndTradition, scriptureInTheMindOfTheChurch
    , evidenceAnyoneCanCheck ].any fun E => !((canonicalWitnessPackage q).refusedBy E).isEmpty

/-- **Every position of the canonical witness keeps the rule it professes, and every other
rule too.** The Reformed case, with James and without, and Paul's claim about faith keep
Westminster's rule; Trent's two readings of James keep Trent's. The ten positions with readings
struck out are held to none.

The check could not part them here, because every claim each position asserts outright rests on
Scripture. The texts are cited to Scripture alone. The three readings the case with James
asserts as claims are cited to scholars and to a catechism, and each also to the verses it reads:
that James 2:14–26 is aimed at a faith without works, to Moo and Johnson and to James 2:19; that
"justified" in James 2:21–24 means shown to be righteous, to Calvin and to James 2:21–23; that
justification and sanctification are distinct, to the Larger Catechism, Q. 77, and its proofs.
Trent asserts only the texts. So no encoded rule, Westminster's, Trent's, the Orthodox or the
library's own, refuses any claim of any position.

What it does not claim: that either side reads the texts rightly. It checks claims, not steps,
and the two sides part in their steps — each corpus's reading, and Trent's reading of James
2:24 — and in what they deny, which a citation does not record. Nor does it reach a position's
conclusion, which is derived, not asserted: the Reformed formula is cited to Westminster, and
no rule here is asked whether that citation is a ground. -/
theorem canonical_witness_own_rules :
    canonicalWitnessBreakTheirRule = [] ∧
      canonicalWitnessHeldToNone =
        [ .withoutPaul, .withoutHebrews, .withoutJohn, .withoutPeter, .withoutJesus
        , .withoutTheWorksWitnesses, .withoutTheNecessityWitnesses
        , .withoutTheSufficiencyWitnesses, .hebrewsAndJesus, .withJamesUndemonstrated ] ∧
      canonicalWitnessRefusedByAnyRule = [] := by
  decide +kernel

/-! ### The dispute over Mark 7

The sola scriptura argument has one dispute so far, over what Jesus' rebuke of the elders'
tradition in Mark 7 settles between Rome and the Reformers
(`TestimonyArguments.SolaScriptura.mark7Dispute`). Its five parties are held to their rules
here, as the sola fide parties are above. The argument's other positions — Geisler's
Tradition 0, Mathison's Tradition I, the canon objection and Kruger's reply to it, Barrett's
parity reply — are packages that no dispute weighs yet, so none of them is held to a rule. -/

/-- **The rule each party to the dispute over Mark 7 professes**, as the side whose reading it
is.

- Mark 7's case for sola scriptura is the Reformed reading of the passage, the one the
  Protestant case has always made from it, and professes Westminster's rule.
- Trent, as it states its position, and Trent with its tradition read as the apostolic word
  handed on unwritten, which is what Trent says it receives, profess Trent's rule.
- Mark 7's principle professes none. It is common ground: Rome grants it in *Dei Verbum* 10 as
  the Reformers do, and making it either side's would be a claim the library does not argue.
  It meets every rule the library has encoded all the same
  (`marks_principle_meets_every_rule`).
- Trent read as commandments of men professes none, because no one holds it. It is Calvin's
  reading of what Trent receives (*Institutes* IV.x.23), joined to Trent's own position: Trent
  denies the reading, and Calvin denies the position. Holding it to either side's rule would
  charge one of them with asserting what he does not. -/
def professesSolaScriptura : SolaScriptura.Mark7Party → Option Epistemology
  | .mark7 => some scriptureItsOwnInterpreter
  | .trent | .trentAsApostolicWord => some scriptureAndTradition
  | .principle | .trentAsMensCommandments => none

/-- Every party to the dispute over Mark 7, in the dispute's order. -/
def mark7Parties : List SolaScriptura.Mark7Party :=
  [.principle, .mark7, .trent, .trentAsMensCommandments, .trentAsApostolicWord]

/-- The list has every party. -/
theorem mark7Parties_complete : ∀ q, q ∈ mark7Parties := by intro q; cases q <;> decide

/-- Each party to the dispute over Mark 7, held to the rule it professes. -/
def ownRuleSolaScriptura (q : SolaScriptura.Mark7Party) :
    Option (OwnRule SolaScriptura.Claim) :=
  (professesSolaScriptura q).map (SolaScriptura.mark7PartyNode q).heldTo

/-- The parties to the dispute over Mark 7 that fail their own rule. -/
def mark7BreakTheirRule : List SolaScriptura.Mark7Party :=
  mark7Parties.filter fun q => (ownRuleSolaScriptura q).any (!·.kept)

/-- The parties to the dispute over Mark 7 held to no rule. -/
def mark7HeldToNone : List SolaScriptura.Mark7Party :=
  mark7Parties.filter fun q => (professesSolaScriptura q).isNone

/-- **Mark 7's case for sola scriptura fails its own rule, at one claim; Trent keeps its own.**
The Reformed case from Mark 7 asks its rival for Scripture, and rests one of its two claims on
something Westminster's rule does not admit. Its claim from the text, that Jesus rebukes the
elders' tradition for voiding the word of God, rests on Mark 7 itself. Its other claim is the
one the step to sola scriptura needs: that no unwritten tradition can now be shown to be
apostolic, and so none can bind the conscience as the word of God. The library cites that claim
to Whitaker's *Disputation on Holy Scripture* (question VI, chapter IV, pp. 503–511), which
answers Bellarmine's five rules for telling a genuine tradition from a spurious one and
replies that "the papists have no such unwritten tradition which can be certainly shewn to
have been always observed by the universal church" (p. 506); to the same work at p. 594, "even
they themselves do not certainly know their own traditions"; and to the Westminster
Confession I.6, which says that nothing is to be added to Scripture by "traditions of men".
Both works are a theologian's or a confession's word, and Westminster's rule admits Scripture
and evidence, not anyone's word. So by its own rule the case rests that claim on what it
refuses its rival.

Trent, as it states its position and read as the apostolic word, keeps Trent's rule: it rests
on 2 Thessalonians 2:15, and on tradition as a source of revelation alongside Scripture, which
the library cites to Session IV itself and to Mathison, Geiselmann and Congar on what Session
IV decided. Both are grounds Trent's rule admits. Mark 7's principle and Trent read as
commandments of men are held to no rule, for the reasons `professesSolaScriptura` gives.

What it does not claim: that some unwritten tradition can be shown to be apostolic, or that
none can. Nor that the claim cannot be grounded by Westminster's rule. It is in part a
historical claim, about what the record can show, and Whitaker argues it from the traditions
Bellarmine names, infant baptism among them; an argument from that evidence, cited as
evidence, or from Scripture, would be a ground the rule admits. The library cites Whitaker as
a witness to the Reformed position, and has not cited a historian's account of the evidence.
Whose authority a claim rests on is read from the tradition its citation records, a proxy; and
the check reads claims, not steps. -/
theorem sola_scriptura_own_rules :
    mark7BreakTheirRule = [.mark7] ∧
      (SolaScriptura.mark7PartyNode .mark7).refusedBy scriptureItsOwnInterpreter =
        [.noUnwrittenTraditionShownApostolic] ∧
      mark7HeldToNone = [.principle, .trentAsMensCommandments] := by
  decide +kernel

/-- **Mark 7's principle meets every rule the library has encoded.** It is held to none,
because it is common ground, but each rule admits everything it asserts: its one claim is Mark
7:1–13 itself, and every rule admits Scripture. So Westminster's rule, Trent's, the Orthodox
rule and the library's evidence rule can each grant it on its own terms, which is what common
ground should be.

What it does not claim: that the principle follows from the text. That is its step, rated
`wellSupported`, and steps are not held to a rule. -/
theorem marks_principle_meets_every_rule :
    [scriptureItsOwnInterpreter, scriptureAndTradition, scriptureInTheMindOfTheChurch,
        evidenceAnyoneCanCheck].all
      (fun E => ((SolaScriptura.mark7PartyNode .principle).refusedBy E).isEmpty) = true := by
  decide +kernel

end TestimonyArguments.Epistemologies
