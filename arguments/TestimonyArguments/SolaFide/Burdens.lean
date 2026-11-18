import Testimony.Logic.Burden
import TestimonyArguments.SolaFide.Ratings

/-!
# TestimonyArguments.SolaFide.Burdens — what each side must give up over Paul's word

The chapters before this one found that Trent and the Reformers part over one
word. Paul writes that God "justifies" (δικαιόω), and the question is whether
the word means that God declares a person righteous, or also that he makes the
person righteous within. This chapter asks what a reader on each side has to
deny to hold that position, and it asks the machine rather than the scholars.

Each side reaches its answer by more than one road. The Reformed reach "the word
does not mean renewal" from how the word is used, and again from Romans 4,
where Paul explains what God counts by quoting a psalm about sins forgiven.
Trent reaches "the word means renewal" from Augustine's explanation, which the
Latin West received. A modern Catholic exegete, Joseph Fitzmyer, gives two more
roads, each put here as strongly as he puts it. One goes through the Greek of
Romans 5:19, "the many will be made righteous". The other he takes from Karl
Kertelge: God's verdict is effective, so in declaring a sinner righteous God
makes him so. The texts on both sides are granted. What a reader can deny is a
reading: the step that carries a text to what it is taken to show. So for each
side the library computes the **opponent's burden** (`Testimony.Logic.Burden`).
That is every smallest set of readings whose denial overturns the case, with a
proof that there is no other way.

Three things come out.

- **To deny the Reformed reading of the word, a reader must deny two readings:**
  the step from the word's courtroom use to "and nothing more", and one of the
  two steps of the road through Romans 4 (`paulsWord_burden`).
- **Trent's reading, on Augustine's explanation alone, fails at a single
  point:** deny the step from Augustine's Latin to Paul's Greek, and nothing is
  left of it (`trentsWord_burden`).
- **Trent's reading at its strongest, with Fitzmyer's two roads beside
  Augustine's, needs three denied** (`trentsWordAtItsStrongest_burden`): the
  step from Augustine, the step from the verdict, and one reading on the road
  from Romans 5:19. Romans 5:19 has the adjective "righteous" (δίκαιος), not the
  verb, so that road carries two readings, the verse's sense and the bridge from
  the adjective to the verb, and either may be denied.

What this does not show is which readings are right. A burden counts the
denials a reader must make. It does not weigh them, and the side that asks for
more denials is not for that reason the better reading. Every step that a
denial falls on is rated `disputed`, because a cited reader grants its grounds
and denies its conclusion: Trent and Fitzmyer at the step from the courtroom
sense, the Reformers at the step from the Latin, Ziesler at the bridge from
Romans 5:19 and again at the step from the verdict. Each denial has a reader
who makes it.

No position wins this outright, and the defeat table says so plainly. A
position defeats another when it attacks it and its weakest step is rated no
lower than the other's. Here the steps on both sides are `disputed`, so every
attack is a defeat, and each runs both ways. Of the 56 defeats in the debate
over sola fide (`solaFideDispute`), not one is answered without a defeat in
return. A one-way defeat would need a side whose every step no cited reader
denies, and neither side has one. That is why the burdens matter: they say what
each side has to deny, when nothing settles which denial is right.

Three checks that do not depend on who said what were also run over these
roads (`Testimony.Semantics.Fallacy`).

- **Does a word keep its sense where the argument needs it to?** A line that
  sets one text beside another relies on their shared word meaning the same in
  both. The road from the word's usage draws on Titus 3:5–7, so it needs
  "justified" there to be Paul's word in Paul's sense. The road through Romans 4
  explains "count" in 4:5 by "count" in 4:8, so it needs that word to keep its
  sense through the passage. The equivocation check found both needs left
  unstated. Each line now states its need as a premise, with the source it
  rests on (`titus3_7UsesDikaioAsPaul`, `romans4CountKeepsItsSense`), so a
  reader can deny it in the open. One need is still unstated: the road through
  Romans 4 also needs "works" (ἔργα) in 4:4–5, "the one who works", to mean
  what it means in 4:6, "apart from works". Until a premise says so, that road
  holds only on that condition.
- **Is one word read by another?** Two roads move from one word to a kindred
  one. Fitzmyer's moves from the adjective in Romans 5:19 to the verb, and it
  states the move as a reading of its own (`fitzmyerBridgeLine`), so the check
  finds it granted. Trent's moves from the Latin *iustificare* to the Greek
  δικαιόω, and it does not state the move. The check reports it unstated. No
  premise is added for Trent here, because no cited reader argues that the
  Latin word carries the Greek one's sense. The Council received the Vulgate as
  authentic, and Pius XII explained that its authority is "juridical", a matter
  of the Church's approval and not a claim about the original wording (see the
  chapter on the Vulgate). So Trent's road holds only on the condition that the
  Latin word means what Paul's does.
- **Does a line cite a voice for one reading and leave out another?** Trent's
  line cites Augustine for "make righteous", and the record bears it out: he
  wrote that "justified" means "made just" (*On the Spirit and the Letter*
  26.45). In the same passage he gives the other sense, "deemed, or reckoned
  as just" (`augustineGivesBothSenses`), and the line leaves that out. The
  check reports the omission. It does not make Trent's reading wrong, since
  Augustine himself put the renewal first, but a reader is owed both.
- **Does a line reach a word's sense from something other than the word?**
  Kertelge's road reaches "justify means make righteous" from what God's
  verdict does, with no use or reading of the word among its premises
  (`effectiveVerdictLine`). The check reports that. It is where the road's
  ground lies, not a fault in it, and it is where Ziesler answers: he grants that
  the justified are also made new, the two "interdependent and inseparable",
  and denies that the renewal is what the verb says.

What the Latin West held, the Trent line's second attribution, is not yet on
record, and the check says so.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Logic

/-! ### Paul's word, by two roads -/

/-- The second step of the road through Romans 4: from Paul's explanation of the
counting, by the rule of least meaning, to "the verb does not also mean
renewal". It is the same rule the road from usage applies, and it carries the
same rating (`leastMeaningSource`). -/
@[solaFideDefs]
def romansFourGlossLine : Line Claim :=
  { name := "Romans 4, by the rule of least meaning"
  , grounds := [p .leastMeaning]
  , step := glossByLeastMeaning
  , delivers := notP .paulsJustifyDenotesRenewal
  , inference := some leastMeaningSource }

/-- The roads to "Paul's 'justify' does not mean renewal": the word's usage, and
Romans 4 in two steps. -/
@[solaFideDefs]
def paulsWordRoads : List (Line Claim) :=
  [lexicalLine, romansFourExegesisLine, romansFourGlossLine]

/-- **Paul's word, by both roads.** That Paul's "justify" (δικαιόω) does not mean
the renewal of the inward person, from the word's courtroom use and from
Romans 4:3–8. -/
@[solaFideDefs]
def paulsWordCase : ArgumentPackage Claim :=
  { name := "Paul's word, from its usage and from Romans 4"
  , cite := baseCite
  , premises := caseOf paulsWordRoads [] []
  , conclusion := notP .paulsJustifyDenotesRenewal
  , conclusionLabel := "Paul's δικαιόω does not denote the renewal of the inward man"
  , inferences := [leastMeaningSource, romansFourExegesisSource] }

/-- Every premise of Paul's word, by both roads, granted: the word does not mean
renewal. -/
def paulsWordReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | _ => True

/-- **Paul's word, by both roads, can be held without contradiction.** -/
theorem paulsWordCase_is_satisfiable : Satisfiable paulsWordCase.premises := by
  satisfied_by paulsWordReading [solaFideDefs]

/-- **What a reader must deny to hold that Paul's "justify" means renewal.** The
case reaches its conclusion by two roads: from how the word is used, and from
Romans 4, where Paul explains righteousness counted as sins not counted. There
are exactly two ways to overturn it, and both deny two readings:

- the step from the courtroom sense to "and nothing more", and the reading of
  Romans 4:6–8 as Paul's explanation of the counting;
- or that same step from the courtroom sense, and the step from Paul's
  explanation to the meaning of the verb.

No single denial overturns it, and no other set does. Trent's reading of Paul's
word takes the second way: it meets the case at the two steps that apply the
rule of least meaning (`whereTrentsWordReadingFalls`,
`whereRomansFourMeetsTheWordReading`), and accepts the reading of Romans 4:6–8,
as Augustine does.

It does not show that either step is right. Both are rated `disputed`, because
Trent and Fitzmyer grant their grounds and deny what they conclude.

What is novel: both roads are old. The proof that these are the only two ways
to overturn the case, so that no single denial is enough, is the library's. -/
@[headline, proposed]
theorem paulsWord_burden :
    OpponentsBurden paulsWordCase paulsWordRoads [] [] [[0, 1], [0, 2]] :=
  .of_check rfl (by decide +kernel)

#print axioms paulsWord_burden

/-! ### Trent's reading of the word, by one road and by two -/

/-- **Trent's reading of Paul's word, on Augustine's explanation alone.** -/
@[solaFideDefs]
def trentsWordCase : ArgumentPackage Claim :=
  { name := "Paul's word, as the Latin West read it"
  , cite := baseCite
  , premises := caseOf [trentWordLine] [] []
  , conclusion := p .paulsJustifyDenotesRenewal
  , conclusionLabel := "Paul's δικαιόω denotes renewal"
  , inferences := [trentReadsPaulsWord] }

/-- Every premise of Trent's reading granted: the word means renewal. -/
def trentsWordReading : Valuation Claim := fun _ => True

/-- **Trent's reading, on Augustine's explanation, can be held without
contradiction.** -/
theorem trentsWordCase_is_satisfiable : Satisfiable trentsWordCase.premises := by
  satisfied_by trentsWordReading [solaFideDefs]

/-- **Trent's reading of Paul's word, on Augustine's explanation alone, fails at
one point.** Deny the step from Augustine's explanation, and the Latin West's,
to what Paul's Greek word means, and the case is overturned. It is the only way,
and it is enough: the case has no second road.

That step is rated `disputed`. Augustine himself gives the courtroom sense as a
second way of taking the word (`augustineGivesBothSenses`), and the Latin
*iustificare* is not the Greek δικαιόω, which is what the argument from Paul's
word denies at this point. It does not show that the step is wrong.

What is novel: the reading is Augustine's and Trent's. The proof that it stands
or falls at this one step is the library's. -/
@[headline, proposed]
theorem trentsWord_burden :
    OpponentsBurden trentsWordCase [trentWordLine] [] [] [[0]] :=
  .of_check rfl (by decide +kernel)

#print axioms trentsWord_burden

/-- Fitzmyer's bridge, rated `disputed`. Fitzmyer grants that the verb "seems
normally to have a declarative, forensic meaning" in the Septuagint, and in Paul
at times. But "many instances are ambiguous, and the effective sense seems to be
supported by 5:19, 'through the obedience of one many will be made upright'"
(*Romans*, 118–19). Ziesler grants the verse, and that "certainly something more
than forensic" is meant there, and denies that it bears on the verb, because
the word in 5:19 is "righteous" (δίκαιοι), not "justify" (*The Meaning of
Righteousness in Paul*, 199). -/
def fitzmyerOnTheAdjective : Source :=
  { primary := .work fitzmyerRomans (.pages 118 119)
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **The bridge from Romans 5:19 to Paul's verb.** Romans 5:19 does not use the
verb "justify" (δικαιόω). It says the many "will be made righteous" (δίκαιοι
κατασταθήσονται), with the adjective "righteous" (δίκαιος). Fitzmyer's road
needs what the adjective means there to be what the verb means in Paul. That
is a reading in its own right, and it is the one Ziesler denies, so it stands
here as a line of its own, which a reader can reject without rejecting the
verse. The word-shift check (`Testimony.Semantics.Fallacy`) finds the move from
the adjective to the verb granted, because this line states it. -/
@[solaFideDefs]
def fitzmyerBridgeLine : Line Claim :=
  { name := "Romans 5:19's adjective bears on Paul's verb (Fitzmyer)"
  , grounds := []
  , step := p .romans5_19BearsOnTheVerb
  , delivers := p .romans5_19BearsOnTheVerb
  , inference := some fitzmyerOnTheAdjective }

/-- The step from Romans 5:19 and the bridge to what Paul's verb means, rated
`plausible`. Granted that the many in 5:19 are made righteous in fact, and that
the adjective there bears on the verb, the verb carries the sense of making
righteous. No cited reader grants both and denies this. Ziesler, who denies the
conclusion, does so by denying the bridge (p. 199). -/
def fitzmyerOnRomansFiveNineteen : Source :=
  { primary := .work fitzmyerRomans (.pages 118 119)
  , tradition := .romanCatholic
  , confidence := .plausible }

/-- **Paul's word, from Romans 5:19.** "Through the obedience of the one man the
many will be made righteous." So, Fitzmyer argues, Paul's "justify" carries an
effective sense: God's declaration makes the sinner upright. This is Trent's
reading of the word on a modern Catholic exegete's ground, the Greek of
Romans, rather than on the Latin. It rests on the verse and on the bridge from
the verse's adjective to the verb. The bridge is not among this line's grounds,
which a burden takes as granted. It comes from its own line
(`fitzmyerBridgeLine`), so that a reader can deny it. -/
@[solaFideDefs]
def fitzmyerWordLine : Line Claim :=
  { name := "Paul's word, from Romans 5:19 (Fitzmyer)"
  , grounds := [p .romans5_19ManyMadeRighteous]
  , step :=
      ⋀ [p .romans5_19ManyMadeRighteous, p .romans5_19BearsOnTheVerb]
      ➝ p .paulsJustifyDenotesRenewal
  , delivers := p .paulsJustifyDenotesRenewal
  , inference := some fitzmyerOnRomansFiveNineteen }

/-- The step from God's effective verdict to what Paul's verb means, rated
`disputed`. Fitzmyer, quoting Karl Kertelge: declaring a person upright has "not
only a forensic effect, but as forensic also an 'effective' meaning" (*Romans*,
118–19). Ziesler grants that the justified are also made a new creature, the
two "interdependent and inseparable" (p. 212), and denies that the renewal is
what the verb says (pp. 162–63). -/
def kertelgeOnTheVerdict : Source :=
  { primary := .work fitzmyerRomans (.pages 118 119)
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **Paul's word, from what God's verdict does.** When God declares a sinner
righteous, his word does what it says, and the sinner is made righteous. So the
verb that names the declaration names the renewal too. This is the third road,
Kertelge's, as Fitzmyer reports it, and it is the strongest form of the
Catholic reading, because it grants the Reformers the courtroom sense and asks
only that the verdict be effective.

It reaches a sense of the word from a claim about God's act, not from a use or
a reading of the word, and the sense-from-elsewhere check
(`Testimony.Semantics.Fallacy`) reports it so. That is not a charge that the
road is wrong. It says where its ground lies: in what God's verdict does, which
Ziesler grants, rather than in what Paul's word means, which he denies. -/
@[solaFideDefs]
def effectiveVerdictLine : Line Claim :=
  { name := "Paul's word, from God's effective verdict (Kertelge, via Fitzmyer)"
  , grounds := [p .godsVerdictIsEffective]
  , step := p .godsVerdictIsEffective ➝ p .paulsJustifyDenotesRenewal
  , delivers := p .paulsJustifyDenotesRenewal
  , inference := some kertelgeOnTheVerdict }

/-- The roads to "Paul's 'justify' means renewal": Augustine's explanation, the
bridge from Romans 5:19 with the step from it, and God's effective verdict. -/
@[solaFideDefs]
def trentsWordRoads : List (Line Claim) :=
  [trentWordLine, fitzmyerBridgeLine, fitzmyerWordLine, effectiveVerdictLine]

/-- **Trent's reading of Paul's word, at its strongest.** That Paul's "justify"
means renewal, from Augustine's explanation, from Romans 5:19 and from God's
effective verdict. -/
@[solaFideDefs]
def trentsWordAtItsStrongest : ArgumentPackage Claim :=
  { name := "Paul's word, from Augustine, from Romans 5:19 and from the verdict"
  , cite := baseCite
  , premises := caseOf trentsWordRoads [] []
  , conclusion := p .paulsJustifyDenotesRenewal
  , conclusionLabel := "Paul's δικαιόω denotes renewal"
  , inferences :=
      [trentReadsPaulsWord, fitzmyerOnTheAdjective, fitzmyerOnRomansFiveNineteen,
        kertelgeOnTheVerdict] }

/-- **Trent's reading at its strongest can be held without contradiction.** -/
theorem trentsWordAtItsStrongest_is_satisfiable :
    Satisfiable trentsWordAtItsStrongest.premises := by
  satisfied_by trentsWordReading [solaFideDefs]

/-- **What a reader must deny to hold that Paul's "justify" does not mean
renewal, against Trent's reading at its strongest.** There are two ways, and
each denies three readings: the step from Augustine's explanation to Paul's
word, the step from God's effective verdict to it, and one of the two readings
on the road from Romans 5:19, either the bridge from the verse's adjective to
the verb or the step from the verse and the bridge to the verb's sense. Keep
any one of the three, and the case stands.

So, put as strongly as its cited readers put it, Trent's reading asks more of
its opponent than the Reformed reading does: three readings against two
(`paulsWord_burden`). The Reformed have a denial ready at each point. At
Augustine, that the Latin *iustificare* is not the Greek, and that Augustine
gives the courtroom sense too. At Romans 5:19, Ziesler's, that the verse has
the adjective and not the verb. At the verdict, Ziesler's again, that the
renewal is real and inseparable from justification and still not what the verb
says. Each of these denials answers a step rated `disputed`. The second way is
different. It denies the step from the verse and the bridge to the verb's sense,
rated `plausible`, and no cited reader denies that step once the bridge is
granted. So the way a reader on record takes is the first, through the bridge.

It does not show that Trent's reading is right because it is harder to
overturn. A burden counts denials. It does not weigh them.

What is novel: setting Fitzmyer's road from the Greek and Kertelge's from the
verdict beside Augustine's from the Latin, as one case, with the bridge from
the adjective stated as a reading of its own, and the proof that an opponent
must deny three. -/
@[headline, proposed]
theorem trentsWordAtItsStrongest_burden :
    OpponentsBurden trentsWordAtItsStrongest trentsWordRoads [] [] [[0, 1, 3], [0, 2, 3]] :=
  .of_check rfl (by decide +kernel)

#print axioms trentsWordAtItsStrongest_burden

end TestimonyArguments.SolaFide
