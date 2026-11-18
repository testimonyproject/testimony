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
Latin West received. A modern Catholic exegete, Joseph Fitzmyer, reaches it a
second way, from the Greek of Romans 5:19. The texts on both sides are granted.
What a reader can deny is a reading: the step that carries a text to what it is
taken to show. So for each side the library computes the **opponent's burden**
(`Testimony.Logic.Burden`). That is every smallest set of readings whose denial
overturns the case, with a proof that there is no other way.

Three things come out.

- **To deny the Reformed reading of the word, a reader must deny two readings:**
  the step from the word's courtroom use to "and nothing more", and one of the
  two steps of the road through Romans 4 (`paulsWord_burden`).
- **Trent's reading, on Augustine's explanation alone, fails at a single
  point:** deny the step from Augustine's Latin to Paul's Greek, and nothing is
  left of it (`trentsWord_burden`).
- **Trent's reading at its strongest, with Fitzmyer's road beside Augustine's,
  needs both denied** (`trentsWordAtItsStrongest_burden`). So each side, put as
  strongly as its cited readers put it, asks the other to give up two readings.

What this does not show is which readings are right. Every step on both sides
is rated `disputed`, because a cited reader grants its grounds and denies its
conclusion: Trent and Fitzmyer at the step from the courtroom sense, the
Reformers at the step from the Latin, Ziesler at the step from Romans 5:19. A
burden measures how much a reader must deny. It does not say whether the denial
is mistaken.

No position wins this outright, and the defeat table says so plainly. A
position defeats another when it attacks it and its weakest step is rated no
lower than the other's. Here every step on both sides is `disputed`, so every
attack is a defeat, and each runs both ways. Of the 56 defeats in the debate
over sola fide (`solaFideDispute`), not one is answered without a defeat in
return. A one-way defeat would need a step that no cited reader denies, and
none of the readings above is such a step. That is why the burdens matter: they
say what each side has to deny, when nothing settles which denial is right.

Two checks that do not depend on who said what were also run over these roads.

- **Does a word keep its sense where the argument needs it to?** A line that
  sets one text beside another relies on their shared word meaning the same in
  both. The road from the word's usage draws on Titus 3:5–7, so it needs
  "justified" there to be Paul's word in Paul's sense. The road through Romans 4
  explains "count" in 4:5 by "count" in 4:8, so it needs that word to keep its
  sense through the passage. The equivocation check (`Testimony.Semantics.Fallacy`)
  found both needs left unstated. Each line now states its need as a premise,
  with the source it rests on (`titus3_7UsesDikaioAsPaul`,
  `romans4CountKeepsItsSense`), so a reader can deny it in the open, and neither
  line uses a word in two senses on its own terms. One need is still unstated:
  the road through Romans 4 also needs "works" (ἔργα) in 4:4–5, "the one who
  works", to mean what it means in 4:6, "apart from works". Until a premise
  says so, that road holds only on that condition.
- **What the check cannot see.** Fitzmyer's road argues from the adjective
  "righteous" (δίκαιοι) in 5:19 to the verb "justify". That is a move from one
  word to another, and the equivocation check tests one word in two senses, so
  it passes over it. Ziesler's objection is exactly this move, and it is weighed
  in the step's rating instead.
- **Does Trent's line say what Augustine actually held?** It does. The record
  now carries what Augustine wrote in the chapter the line cites (26.45), and
  the check finds the line's attribution borne out by it
  (`augustineGivesBothSenses`). The same record shows that Augustine gave the
  courtroom sense too, "deemed, or reckoned as just", as a second way of taking
  the word. The line quotes the first sense and not the second. The check
  compares an attribution with the record and has no test for what a quotation
  leaves out, so that is a reader's observation, not a finding of the machine.
  What the Latin West held, the line's other attribution, is not yet on record.
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

/-- The step from Romans 5:19 to what Paul's verb means. Fitzmyer grants that the
verb "seems normally to have a declarative, forensic meaning" in the
Septuagint, and in Paul at times. But "many instances are ambiguous, and the
effective sense seems to be supported by 5:19, 'through the obedience of one
many will be made upright'" (*Romans*, 118–19). Rated `disputed`. Ziesler grants
the verse and that "certainly something more than forensic" is meant there, and
denies that it bears on the verb, because the word in 5:19 is "righteous"
(δίκαιοι), not "justify" (*The Meaning of Righteousness in Paul*, 199). -/
def fitzmyerOnRomansFiveNineteen : Source :=
  { primary := .work fitzmyerRomans (.pages 118 119)
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **Paul's word, from Romans 5:19.** "Through the obedience of the one man the
many will be made righteous." So, Fitzmyer argues, Paul's "justify" carries an
effective sense: God's declaration makes the sinner upright. This is Trent's
reading of the word on a modern Catholic exegete's ground, the Greek of
Romans, rather than on the Latin. -/
@[solaFideDefs]
def fitzmyerWordLine : Line Claim :=
  { name := "Paul's word, from Romans 5:19 (Fitzmyer)"
  , grounds := [p .romans5_19ManyMadeRighteous]
  , step := p .romans5_19ManyMadeRighteous ➝ p .paulsJustifyDenotesRenewal
  , delivers := p .paulsJustifyDenotesRenewal
  , inference := some fitzmyerOnRomansFiveNineteen }

/-- The roads to "Paul's 'justify' means renewal": Augustine's explanation, and
Romans 5:19. -/
@[solaFideDefs]
def trentsWordRoads : List (Line Claim) := [trentWordLine, fitzmyerWordLine]

/-- **Trent's reading of Paul's word, at its strongest.** That Paul's "justify"
means renewal, from Augustine's explanation and from Romans 5:19. -/
@[solaFideDefs]
def trentsWordAtItsStrongest : ArgumentPackage Claim :=
  { name := "Paul's word, from Augustine and from Romans 5:19"
  , cite := baseCite
  , premises := caseOf trentsWordRoads [] []
  , conclusion := p .paulsJustifyDenotesRenewal
  , conclusionLabel := "Paul's δικαιόω denotes renewal"
  , inferences := [trentReadsPaulsWord, fitzmyerOnRomansFiveNineteen] }

/-- **Trent's reading at its strongest can be held without contradiction.** -/
theorem trentsWordAtItsStrongest_is_satisfiable :
    Satisfiable trentsWordAtItsStrongest.premises := by
  satisfied_by trentsWordReading [solaFideDefs]

/-- **What a reader must deny to hold that Paul's "justify" does not mean
renewal, against Trent's reading at its strongest.** There is one way: deny both
readings, the step from Augustine's explanation to Paul's word and the step
from Romans 5:19 to it. Either one kept, the case stands.

So, put as strongly as its cited readers put it, Trent's reading asks as much
of its opponent as the Reformed reading does of its own: two readings each
(`paulsWord_burden`). The Reformed deny the second at the point Ziesler names,
that Romans 5:19 has the adjective and not the verb. That denial is itself a
reading, and it is rated `disputed` with the step it answers.

What is novel: setting Fitzmyer's road from the Greek beside Augustine's from
the Latin, as one case, and the proof that an opponent must deny both. -/
@[headline, proposed]
theorem trentsWordAtItsStrongest_burden :
    OpponentsBurden trentsWordAtItsStrongest trentsWordRoads [] [] [[0, 1]] :=
  .of_check rfl (by decide +kernel)

#print axioms trentsWordAtItsStrongest_burden

end TestimonyArguments.SolaFide
