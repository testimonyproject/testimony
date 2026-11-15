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
A historian reading Paul as one reads any ancient author asks for neither: only the texts, and
evidence anyone can check.

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

In the sola fide dispute, four parties break their own rule, and all four at one premise. Sola
fide from Paul, from Peter at Jerusalem and from John 6, and the Reformed answer to
Chrysostom, each assert that justification and sanctification are "inseparable but distinct".
The library cites that claim to Westminster (XIII.1, XI.1) and Calvin (*Institutes* III.xi.6),
and to nothing else (`sola_fide_own_rules`). Westminster's rule admits Scripture and evidence;
it does not admit a confession's word, Westminster's own included, or a theologian's. So by
their own rule the four readings owe that claim a text. Calvin says where to look, for he says
Scripture "classes them separately", but the library cites Calvin and not the texts he means.
The claim is not thereby false. The four are answerable, by their own lights, for the one
premise they rest on another rule for, and the remedy is to cite the texts. Every other party
held to a rule, Catholic and scholarly alike, asserts only what its rule admits.

Two parties are held to no rule. Luther's reading of Galatians is Lutheran, and the library
cites no Lutheran statement of how Scripture is to be read; Chrysostom's is patristic, and it
cites no Orthodox one either. Holding them to Westminster's rule, or to Trent's, would hand them
a rule they did not write.

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
Spirit speaking in the Scripture". Westminster does not speak to arguments from silence, so
neither does this. -/
def scriptureItsOwnInterpreter : Epistemology :=
  { name := "Scripture its own interpreter"
  , statement := "Scripture, and evidence anyone can check, are grounds; no council's or " ++
      "confession's word is; and what rests on Scripture alone is answered from Scripture."
  , admits := fun w => w == .scripture || w == .evidence
  , scriptureAlone := true
  , principles := [.scriptureSelfConsistent]
  , silence := none
  , source :=
      { primary := .work westminsterConfession (.sectionRef "I.ix")
      , supporting :=
          [ .work westminsterConfession (.sectionRef "I.vi")
          , .work westminsterConfession (.sectionRef "I.x") ]
      , tradition := .reformedProtestant
      , confidence := .consensus } }

/-- **Scripture and tradition**: the Catholic rule. Scripture, evidence, and the Church's
teaching — a council's definition, the tradition received from the Apostles — are grounds, and
no step is answered from Scripture alone. Trent, Session IV, receives the traditions "received
by the Apostles from the mouth of Christ himself, or from the Apostles themselves, the Holy
Ghost dictating"; *Dei Verbum* 9 holds the two together. Neither speaks to arguments from
silence. -/
def scriptureAndTradition : Epistemology :=
  { name := "Scripture and tradition"
  , statement := "Scripture, evidence and the Church's teaching are grounds, received together; " ++
      "no step is answered from Scripture alone."
  , admits := fun w => w != .assertion
  , scriptureAlone := false
  , principles := [.scriptureSelfConsistent]
  , silence := none
  , source :=
      { primary := .work tannerDecrees
          (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions")
      , supporting := [.work tannerDecrees (.sectionRef "Vatican II (1965), Dei Verbum 9")]
      , tradition := .romanCatholic
      , confidence := .consensus } }

/-- **Evidence anyone can check**: the historian's rule, and the library's own for its
evidence standard. The texts and argued scholarship are grounds; no one's word is, by itself;
no step is kept to Scripture alone; and a word means no more than its context needs (Silva,
Barr). It is the library's statement of the rule, so it is cited as the library's own. -/
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
historian's what the evidence standard admits; and each keeps Scripture-alone steps to
Scripture exactly when its standard does. So every rating computed under a standard is a
rating computed under a rule someone holds, and nothing computed so far moves. -/
theorem each_rule_is_a_standard :
    scriptureItsOwnInterpreter.agreesWith .scriptural = true ∧
      scriptureAndTradition.agreesWith .tradition = true ∧
      evidenceAnyoneCanCheck.agreesWith .evidence = true := by
  decide

/-- **The rule each party to the sola fide dispute professes**, as the side whose reading it is.

- The Reformed readings — sola fide from Paul, from Jesus' words at Luke 7:50 and in John 6,
  from Peter at Jerusalem, Paul's gospel against Trent's definition, and the Reformed answer to
  Chrysostom — profess Westminster's rule.
- Trent's readings, and Aquinas, profess Trent's.
- The scholars' readings — Sanders and Dunn, their critics, the apocalyptic reading, Jervell —
  and the two arguments from Paul's word by a reading method, the lexical case and Romans 4 on
  the word, profess the historian's.
- Luther and Chrysostom profess no rule the library has encoded: it cites no Lutheran and no
  Orthodox statement of how Scripture is read. -/
def professes : Party → Option Epistemology
  | .pauline | .dominical | .apostolic | .gospel | .johannine | .sanctification =>
    some scriptureItsOwnInterpreter
  | .trent | .trentOnPaulsWord | .aquinas => some scriptureAndTradition
  | .sanders | .critics | .apocalyptic | .jervell | .lexical | .romansOnTheWord =>
    some evidenceAnyoneCanCheck
  | .luther | .chrysostom => none

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

/-- **Four Reformed readings break their own rule, at one premise.** Sola fide from Paul, from
Peter at Jerusalem and from John 6, and the Reformed answer to Chrysostom, each assert that
justification and sanctification are inseparable but distinct. The library cites that claim to
Westminster (XIII.1, XI.1) and to Calvin (*Institutes* III.xi.6) alone, and Westminster's own
rule admits Scripture and evidence, not a confession's word or a theologian's. Every other
party held to a rule asserts only what its rule admits. Luther and Chrysostom are held to none.

What it does not claim: that the four readings are wrong, or that the claim has no text. Calvin
says Scripture "classes them separately"; the library cites Calvin, not the texts he means, and
by their own rule the four readings owe them. Nor does it say anything of their steps, whose
citations record their ratings, not what they rest on. -/
theorem sola_fide_own_rules :
    breakTheirRule = [.pauline, .apostolic, .johannine, .sanctification] ∧
      (breakTheirRule.map fun q => (ownRule q).map (·.claims)) =
        [some [.justificationDistinctFromSanctification],
          some [.justificationDistinctFromSanctification],
          some [.justificationDistinctFromSanctification],
          some [.justificationDistinctFromSanctification]] ∧
      heldToNone = [.luther, .chrysostom] := by
  decide +kernel

end TestimonyArguments.Epistemologies
