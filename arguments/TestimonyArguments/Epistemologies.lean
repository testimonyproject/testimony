import Testimony.Logic.Epistemology
import TestimonyArguments.SolaFide

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
(`Testimony.Logic.Epistemology`). Each says exactly what one of the library's three
credibility standards says (`each_rule_is_a_standard`). So the standards the ratings have
always been computed under now have their holders, and no rating moves.

## Does each side keep its own rule?

A reading is held to the rule of the side whose reading it is. That is declared below, party by
party, with the reason; it is not read off the citations, because a Reformed reading may cite a
Catholic exegete and stay Reformed. Then every claim a party asserts is checked against its own
rule. Its steps are not, yet: a step's citation records who disputes it, not what it rests on.
A party that asks its rival for Scripture and rests a claim on a confession's word alone keeps
two rules.

As the library cites them, four readings in the sola fide dispute rest one claim on a ground
their own rule does not admit (`sola_fide_own_rules`). Sola fide from Paul, from Peter at
Jerusalem and from John 6, and the Reformed answer to Chrysostom, each assert that justification
and sanctification are inseparable but distinct: that God's pardoning and accepting a sinner,
and his making that sinner holy over a life, always go together and are not the same thing.
The library cites the claim to Westminster (XIII.1, XI.1) and to Calvin (*Institutes* III.xi.6),
and to nothing else, and Westminster's rule admits Scripture and evidence, not a confession's or
a theologian's word.

A Reformed reader would put the fault on the citation, not the readings. The Confession is a
subordinate standard: a summary of Scripture, printed with its Scripture proofs, and to cite a
section of it is, for that reader, to point at those proofs. Calvin, too, says Scripture lists
the two separately. The library cited the summary and not the texts. One cited text would clear
all four, because a claim rests on the best of what it cites.

Two limits go with the finding. The library's evidence rule admits the same grounds for claims,
so the four would fail it too; what sets Westminster's rule apart governs steps, which are not
yet checked. And the Catholic rule, as encoded, admits any authority's word, so the Catholic
readings could not fail this way: that they pass says less than that the others fail.

Three parties are held to no rule. Aquinas, Luther and Chrysostom wrote neither Trent's rule
nor Westminster's, and the library cites none of their own as a rule; holding them to another's
would give them a rule they did not write.

## What it does not claim

It does not say which epistemology is right: that is what the sola scriptura dispute is about.
It does not weigh anything: no verdict and no rating reads it. It checks claims, not steps. And
it says nothing of parties outside the sola fide dispute, which are the next to be held to their
rules.
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

**As encoded, it is broader than Trent's.** The library's warrants do not say whose authority a
work is, so this rule admits every authority's word: a council's, but also a Protestant
confession's or any theologian's. Trent admits the apostolic tradition and the Church's judgement
of Scripture's sense, not Westminster's word. So a Catholic reading can fail this rule only by
resting a claim on the library's own proposal, and passing it says less than passing
Westminster's. Narrowing it needs warrants that know whose authority they are. Neither source
speaks to arguments from silence, and no principle of reading is recorded until one is cited in
its words. -/
def scriptureAndTradition : Epistemology :=
  { name := "Scripture and tradition"
  , statement := "Scripture and the apostolic tradition, received together, are grounds, with " ++
      "evidence; no step is answered from Scripture alone."
  , admits := fun w => w != .assertion
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

/-- **Each rule is one of the credibility standards.** The Reformed rule admits what the
scriptural standard admits, the Catholic rule what the tradition standard admits, and the
library's evidence rule what the evidence standard admits; and each keeps Scripture-alone steps
to Scripture exactly when its standard does. So every rating computed under the scriptural or
the tradition standard is a rating under a rule a tradition holds, and under the evidence
standard, the library's own; nothing computed so far moves. -/
theorem each_rule_is_a_standard :
    scriptureItsOwnInterpreter.agreesWith .scriptural = true ∧
      scriptureAndTradition.agreesWith .tradition = true ∧
      evidenceAnyoneCanCheck.agreesWith .evidence = true := by
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

/-- **As the library cites them, four Reformed readings rest one claim on a ground their own rule
does not admit.** Sola fide from Paul, from
Peter at Jerusalem and from John 6, and the Reformed answer to Chrysostom, each assert that
justification and sanctification are inseparable but distinct. The library cites that claim to
Westminster (XIII.1, XI.1) and to Calvin (*Institutes* III.xi.6) alone, and Westminster's own
rule admits Scripture and evidence, not a confession's word or a theologian's. Every other
party held to a rule asserts only what its rule admits. Aquinas, Luther and Chrysostom are held
to none.

What it does not claim: that the four readings are wrong, or that the claim has no text. A
Reformed reader cites the Confession as a summary pointing to its Scripture proofs, and Calvin
says Scripture lists the two separately; the library cited neither the proofs nor the texts, and
one cited text would clear all four. The evidence rule admits the same grounds, so the four fail
it too. The Catholic rule, as encoded, admits any authority, so the Catholic readings could not
fail this way. Nor does it say anything of steps, whose citations record their ratings, not
what they rest on. -/
theorem sola_fide_own_rules :
    breakTheirRule = [.pauline, .apostolic, .johannine, .sanctification] ∧
      (breakTheirRule.map fun q => (ownRule q).map (·.claims)) =
        [some [.justificationDistinctFromSanctification],
          some [.justificationDistinctFromSanctification],
          some [.justificationDistinctFromSanctification],
          some [.justificationDistinctFromSanctification]] ∧
      heldToNone = [.aquinas, .luther, .chrysostom] := by
  decide +kernel

end TestimonyArguments.Epistemologies
