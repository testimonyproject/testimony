import Testimony.Logic.Burden
import TestimonyArguments.SolaFide.Ratings

/-!
# TestimonyArguments.SolaFide.Burdens — what each side must give up over Paul's word

The chapters before this one found that Trent and the Reformers part over one
word. Paul writes that God "justifies" (δικαιόω), and the question is whether
the word means that God declares a person righteous, or also that He makes the
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
  step from Augustine, one reading on the road from Romans 5:19, and one on the
  road from the verdict. Romans 5:19 has the adjective "righteous" (δίκαιος),
  not the verb, so that road carries three readings: that "made righteous"
  there means made righteous within, that the adjective bears on the verb, and
  the step from both. The verdict road carries two: that God's verdict is
  effective, and the step from that to the word. There are six ways to make the
  three denials, and no fewer denials will do.

A burden counts the denials a reader must make and weighs none of them, so
asking an opponent for more denials does not make a side the better reading. Almost every reading a
denial can fall on is rated `disputed`, because a cited reader grants its
grounds and denies its conclusion: Trent and Fitzmyer at the step from the
courtroom sense, the Reformers at the step from the Latin, Charles Hodge and
Calvin at the reading of Romans 5:19 as renewal, Ziesler at the bridge from its
adjective and at the step from the verdict, and Calvin at the verdict itself.
The one exception is the step from Romans 5:19, read as renewal, and the bridge
to the verb's sense, which no cited reader denies once both are granted.

The Reformed side now answers each of those readings in the debate itself, not
only in the ratings. The argument from Paul's word is heard with three answers
from the Greek (`lexicalCaseAnsweringTheGreek`). Hodge reads Romans 5:19 as a
standing: the verb there, καθίστημι, "never, in the New Testament, means to
make, in the sense of effecting", so the many are "constituted legally
righteous" (*Commentary on the Epistle to the Romans*, 1864, 271–72). Ziesler
holds that the verse's adjective does not settle the verb. Calvin grants that
God renews whom He justifies and denies that the verdict is what renews: light
and heat come together from the sun, "and yet reason itself prohibits us from
transferring the peculiar properties of the one to the other" (*Institutes*
III.xi.6). Trent is heard with Fitzmyer's and Kertelge's roads
(`tridentineOnPaulsWordAtItsStrongest`).

No position wins this outright, and the defeat table says so plainly. A
position defeats another when it attacks it and its weakest step is rated no
lower than the other's. Here the weakest step on both sides is `disputed`, so
every attack is a defeat, and each runs both ways. With both sides heard at
their strongest, the debate over sola fide (`solaFideDispute`) has the same 56
defeats it had before, and not one is answered without a defeat in return. The
new answers and the new roads add attacks between the same two positions, and
every one is a tie. A one-way defeat would need a side whose every step no
cited reader denies, and neither side has one. That is why the burdens matter: they say what
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
  check reports the omission. Trent's reading survives it, since Augustine
  himself put the renewal first, but a reader is owed both.
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
as Augustine does. Both steps are rated `disputed`, because Trent and Fitzmyer
grant their grounds and deny what they conclude.

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
word denies at this point.

What is novel: the reading is Augustine's and Trent's. The proof that it stands
or falls at this one step is the library's. -/
@[headline, proposed]
theorem trentsWord_burden :
    OpponentsBurden trentsWordCase [trentWordLine] [] [] [[0]] :=
  .of_check rfl (by decide +kernel)

#print axioms trentsWord_burden

/-- The roads to "Paul's 'justify' means renewal": Augustine's explanation, the
bridge from Romans 5:19 with the step from it, and God's effective verdict. -/
@[solaFideDefs]
def trentsWordRoads : List (Line Claim) := trentWordLine :: modernCatholicWordRoads

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
      [trentReadsPaulsWord, inwardOnRomansFiveNineteen, fitzmyerOnTheAdjective,
        fitzmyerOnRomansFiveNineteen, kertelgeOnTheVerdictItself, kertelgeOnTheVerdict] }

/-- **Trent's reading at its strongest can be held without contradiction.** -/
theorem trentsWordAtItsStrongest_is_satisfiable :
    Satisfiable trentsWordAtItsStrongest.premises := by
  satisfied_by trentsWordReading [solaFideDefs]

/-- **What a reader must deny to hold that Paul's "justify" does not mean
renewal, against Trent's reading at its strongest.** Three readings, one from
each road, and there are six ways to choose them:

- the step from Augustine's explanation to Paul's word, on every way;
- on the road from Romans 5:19, one of three: that "made righteous" there means
  made righteous within, that the verse's adjective bears on the verb, or the
  step from both to the verb's sense;
- on the road from the verdict, one of two: that God's verdict is effective, or
  the step from it to the word.

Keep a whole road, and the case stands.

So, put as strongly as its cited readers put it, Trent's reading asks more of
its opponent than the Reformed reading does: three readings against two
(`paulsWord_burden`). The Reformed have a cited denial ready at each road. At
Augustine, that the Latin *iustificare* is not the Greek, and that Augustine
gives the courtroom sense too. At Romans 5:19, Hodge's and Calvin's, that "made
righteous" there is a standing, not a renewal, or Ziesler's, that the adjective
does not settle the verb. At the verdict, Calvin's, that the renewal comes with
the verdict and not from it, or Ziesler's, that it is real and still not what
the verb says. Only one reading in the table has no cited denier: the step from
Romans 5:19, read as renewal, and the bridge to the verb's sense, rated
`plausible`. The ways a reader on record takes pass it by.

A burden counts denials and weighs none of them: a reading harder to overturn
is not for that reason right.

What is novel: setting Fitzmyer's road from the Greek and Kertelge's from the
verdict beside Augustine's from the Latin, as one case, with each road's
readings stated as readings of their own, and the proof that an opponent must
deny three. -/
@[headline, proposed]
theorem trentsWordAtItsStrongest_burden :
    OpponentsBurden trentsWordAtItsStrongest trentsWordRoads [] []
      [[0, 1, 4], [0, 1, 5], [0, 2, 4], [0, 2, 5], [0, 3, 4], [0, 3, 5]] :=
  .of_check rfl (by decide +kernel)

#print axioms trentsWordAtItsStrongest_burden

end TestimonyArguments.SolaFide
