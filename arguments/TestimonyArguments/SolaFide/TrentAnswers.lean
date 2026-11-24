import TestimonyArguments.SolaFide.Reformation
import TestimonyArguments.SolaFide.FaithAndCharity

/-!
# TestimonyArguments.SolaFide.TrentAnswers — the council answers, 1547

The Council of Trent opened in December 1545, in a small city in the Alps,
nearly thirty years after Luther's theses. Its sixth session took up
justification, and the debate on it ran for seven months. The decree was read on
13 January 1547. It has sixteen chapters, which teach, and thirty-three canons,
which condemn. The council named no Reformer, but its canons answer what the
Reformers had taught. The *Apology* of 1531 had written "therefore by faith
alone we are justified"; canon 9 condemns whoever says "that by faith alone the
impious is justified".

Here the council stands beside four of the Reformation voices it answered, each
as the chapter "The Reformation's case, 1521–1541" sets it out, and nothing
written after 1547 is cited for what any of them holds.

## What the council taught

It agreed with the Reformers on grace. "None of those things which precede
justification, whether faith or works, merit the grace itself of
justification", and for that the council quoted Paul: "if it be a grace, it is
not now by works, otherwise … grace is no more grace" (Romans 11:6; ch. 8).
Faith is "the beginning of human salvation, the foundation, and the root of all
Justification" (ch. 8).

It parted from them on three points. Two are weighed here, and the third has
chapters of its own.

The first is baptism. Chapter 7 names the causes of justification in the terms
of the schools: its final cause, its efficient cause, the cause that merits it,
the instrument through which it is given, and the form that makes a person just.
Justification "cannot be effected, without the laver of regeneration, or the
desire thereof, as it is written; unless a man be born again of water and the
Holy Ghost, he cannot enter into the kingdom of God" (ch. 4, quoting John 3:5).
So "the instrumental cause is the sacrament of baptism, which is the sacrament of
faith, without which (faith) no man was ever justified" (ch. 7). The Reformed
answer came a century later: faith "is the alone instrument of justification"
(Westminster Confession XI.2).

The second is what faith is when it justifies. "Faith, unless hope and charity
be added thereto, neither unites man perfectly with Christ, nor makes him a
living member of His body" (ch. 7). The council cited James, "faith without
works is dead", Paul's "faith which worketh by charity", and Christ's word to the
young man, "if thou wilt enter into life, keep the commandments". Canon 9
condemns whoever says that by faith alone the impious is justified, "in such
wise as to mean, that nothing else is required to co-operate in order to the
obtaining the grace of Justification".

The third is what justification is. It is "not remission of sins merely, but
also the sanctification and renewal of the inward man" (ch. 7), and the
justified, "faith co-operating with good works, increase in that justice which
they have received through the grace of Christ, and are still further
justified" (ch. 10). The Reformers answered that after the decree, so the
chapters "What Trent means by justification" and
"Does justification have degrees?" weigh it.

## Who stands

Every position here cites, for what it holds, only Scripture and works written
by the end of 1547 (`trent_answers_hear_no_later_voice`). Its ratings name
readers of any date who grant a step's grounds and deny its conclusion.

On baptism the two sides meet. The library states justification by faith alone
as faith being the only means of justification, and on that statement it
excludes baptism as the instrument. So the council's teaching on baptism and the
two Lutheran confessions defeat each other, each on a step rated `disputed`, and
none of the three survives as forced, that is, as standing however the open
disagreements are settled. The confessions' own steps are disputed by the
Confutation of 1530, whose reasons the chapter on the Reformation quotes. The
Lutherans would not put the clash there: the Augsburg Confession itself teaches
that baptism "is necessary to salvation" (*necessarius ad salutem*), and that
through it the grace of God is offered (art. IX). What is weighed here is the
Reformed statement of faith alone, the one Westminster later confessed.

On faith they do not meet. Luther in 1535 and Calvin in 1539 are stated as
holding that the faith which justifies is not faith formed by love; the council
holds that faith does not suffice without hope and charity added. One
assignment of true and false to every claim satisfies all three
(`the_council_stands_with_luthers_claim`), so none of them denies another,
nothing defeats any of them, and all three are forced
(`after_the_council_baptism_and_faith_alone_tie`). Luther's own complaint, against
a faith that "justifieth not, except it be furnished with charity", is aimed at
what canon 9 requires, and the library's definitions leave open
whether faith as the only means of justification is a faith that suffices
alone. Calvin answered the decree within the year: "It is therefore faith alone
which justifies, and yet the faith which justifies is not alone" (*Antidote*,
p. 152).
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Logic.Framework Testimony.Scripture

/-! ### The sources of 1547

Each position below is cited, for every claim it rests on or reaches, to
Scripture or to a work written before the decree: the four Reformation voices to
their own writings, and the council to its own decree. The ratings are the
library's, and each names the reader, of whatever date, who grants the grounds
and denies the conclusion. -/

/-- The sources of the council's answer. Romans 3:28 and 4:4–5, John 3:5 and
Matthew 19:17 are cited to the text alone. Justification by faith alone is cited
to the Augsburg Confession, art. IV, and the agreement of James with Paul to the
*Apology*. Faith's sufficiency is cited to the texts the Reformers read it from,
Luke 7:50 and Acts 15:9–11, and to Calvin's answer to the decree in 1547: "It is
therefore faith alone which justifies" (*Antidote*, p. 152). Baptism or its
desire is cited to the decree, ch. 4, and baptism as the instrumental cause to
ch. 7. Every other claim keeps the
source the chapter on the Reformation gives it. -/
@[solaFideDefs]
def councilCite : Claim → AtomMeta
  | .justificationByFaithAlone =>
    { reformationCite .justificationByFaithAlone with
      source :=
        { primary := .work augsburgConfession (.pages 44 45)
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .james2_24Compatible =>
    { reformationCite .james2_24Compatible with
      source :=
        { primary := .scripture [{ ref := .verse james2_24 }]
        , supporting := [.work melanchthonApology (.pages 188 189)]
        , tradition := .reformedProtestant
        , confidence := (reformationCite .james2_24Compatible).source.confidence } }
  | .faithIsSufficient =>
    { reformationCite .faithIsSufficient with
      source :=
        { primary :=
            .scripture [{ ref := .verse luke7_50 }, { ref := .range ⟨.acts, 15, 9, 15, 11⟩ }]
        , supporting := [.work calvinAntidoteWork (.page 152)]
        , tradition := .reformedProtestant
        , confidence := (reformationCite .faithIsSufficient).source.confidence } }
  | .matthew19_17KeepTheCommandments =>
    { reformationCite .matthew19_17KeepTheCommandments with
      source :=
        { primary := .scripture [{ ref := Variants.matthewNineteenSeventeenB }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .john3_5WaterAndSpirit =>
    { reformationCite .john3_5WaterAndSpirit with
      source :=
        { primary := .scripture [{ ref := .verse john3_5 }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .baptismOrItsDesire =>
    { reformationCite .baptismOrItsDesire with
      source :=
        { primary := .work trentSessionVI (.sectionRef "ch. 4; Waterworth, p. 32")
        , tradition := .romanCatholic
        , confidence := (reformationCite .baptismOrItsDesire).source.confidence } }
  | .baptismIsInstrumentalCause =>
    { reformationCite .baptismIsInstrumentalCause with
      source :=
        { primary := .work trentSessionVI (.sectionRef "ch. 7; Waterworth, pp. 34–35")
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | c => reformationCite c

/-! ### The council on baptism -/

/-- **Who draws the step to baptism as the instrument.** The council itself, in
its fourth and seventh chapters. Rated `disputed`, because the Reformed grant
John 3:5 and deny that baptism is the instrument of justification. The
Westminster Confession's reason is that faith, "receiving and resting on Christ
and his righteousness, is the alone instrument of justification" (XI.2), and
Calvin's, on the verse itself, is that "by water, therefore, is meant nothing
more than the inward purification and invigoration which is produced by the Holy
Spirit" (on John 3:5, p. 110). -/
def councilBaptismStep : Source :=
  { primary := .work trentSessionVI (.sectionRef "ch. 4 and ch. 7; Waterworth, pp. 32, 34–35")
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **Baptism, the instrumental cause, as the council taught it.** Jesus said,
"unless one is born of water and the Spirit, he cannot enter the kingdom of God"
(John 3:5), and the council reads it so that justification "cannot be effected,
without the laver of regeneration, or the desire thereof" (ch. 4). So "the
instrumental cause is the sacrament of baptism, which is the sacrament of faith"
(ch. 7). -/
@[solaFideDefs]
def councilBaptismLine : Line Claim :=
  { name := "Baptism, the instrumental cause (Trent, chs. 4 and 7)"
  , grounds := [p .john3_5WaterAndSpirit, p .baptismOrItsDesire]
  , step := ⋀ [p .john3_5WaterAndSpirit, p .baptismOrItsDesire] ➝ p .baptismIsInstrumentalCause
  , delivers := p .baptismIsInstrumentalCause
  , inference := some councilBaptismStep }

/-- The council on baptism, as a position. -/
@[solaFideDefs]
def councilOnBaptismCase : ArgumentPackage Claim :=
  councilBaptismLine.asPackage councilCite "baptism is the instrumental cause of justification"

/-! ### The council on faith -/

/-- **Who draws the council's step on faith**: the council, in ch. 7 and canon 9.
It is the step of the chapter "Faith working through love" (`trentCharityStep`),
cited to the decree alone. Rated `disputed`, because Calvin grants every text
ch. 7 cites and denies that faith needs charity added to justify (*Antidote*,
pp. 117–120). -/
def councilCharityStep : Source :=
  { trentCharityStep with
    primary := .work trentSessionVI (.sectionRef "ch. 7 and canon 9; Waterworth, pp. 35, 45")
    supporting := [] }

/-- The council on faith, as a position: ch. 7 and canon 9, as the chapter "Faith
working through love" hears them, cited to the decree. -/
@[solaFideDefs]
def councilOnFaithCase : ArgumentPackage Claim :=
  { trentOnCharityCase with cite := councilCite, inferences := [councilCharityStep] }

/-! ### The voices the council answered -/

/-- The Augsburg Confession, cited to its own article for faith alone. -/
@[solaFideDefs]
def augsburgIn1547 : ArgumentPackage Claim := { augsburgCase with cite := councilCite }

/-- The *Apology*, cited to its own pages for faith alone and for James. -/
@[solaFideDefs]
def apologyIn1547 : ArgumentPackage Claim := { apologyCase with cite := councilCite }

/-! ### The council's answer, weighed -/

/-- The parties to the council's answer: four Reformation voices it answered, and
the council's two answers. -/
inductive TrentAnswerParty
  /-- The Augsburg Confession, 1530: justified freely, through faith. -/
  | augsburg
  /-- The *Apology*, 1531: by faith alone, and James agrees. -/
  | apology
  /-- Luther on Galatians, 1535: the faith that justifies is not formed by love. -/
  | luther
  /-- Calvin to Sadoleto, 1539: the faith that justifies is not formed by love. -/
  | calvin
  /-- The council on baptism, 1547: the instrumental cause (chs. 4 and 7). -/
  | trentOnBaptism
  /-- The council on faith, 1547: faith does not suffice without hope and charity
  (ch. 7, canon 9). -/
  | trentOnFaith
deriving DecidableEq

/-- The package each party argues from. -/
@[solaFideDefs]
def trentAnswerNode : TrentAnswerParty → ArgumentPackage Claim
  | .augsburg => augsburgIn1547
  | .apology => apologyIn1547
  | .luther => lutherTruthCase
  | .calvin => calvinSadoletoCase
  | .trentOnBaptism => councilOnBaptismCase
  | .trentOnFaith => councilOnFaithCase

/-- The council's answer to the Reformers, heard with the voices it answered. -/
declare_dispute trentAnswersDispute := trentAnswerNode using solaFideDefs
  /-- **Who defeats whom.** The council on baptism and each of the Augsburg
  Confession and the *Apology* defeat each other: faith as the only means of
  justification excludes baptism as its instrument, and each side's step is
  rated `disputed`. Nothing else defeats anything. Luther and Calvin conclude
  that the faith which justifies is not formed by love, and the council's
  ch. 7 that faith does not suffice without hope and charity, and neither
  claim denies the other. Every cell is checked by the kernel. -/
  defeats [ (.augsburg, .trentOnBaptism), (.apology, .trentOnBaptism)
          , (.trentOnBaptism, .augsburg), (.trentOnBaptism, .apology) ]
  /-- **Nothing supports anything.** Every cell is checked by the kernel. -/
  supports []
  /-- Each party's case is part of its own and of no other's. Every cell is
  checked by the kernel. -/
  partOf []
  /-- The council's answer drawn: who defeats whom. -/
  map trentAnswersMap

/-- **The council's answer hears no later voice.** Every reference each party
cites, for its claims and for its steps, is Scripture or a work dated before
1548. -/
theorem trent_answers_hear_no_later_voice :
    trentAnswersDispute.citesOnlyBefore .augsburg 1548 = true ∧
      trentAnswersDispute.citesOnlyBefore .apology 1548 = true ∧
      trentAnswersDispute.citesOnlyBefore .luther 1548 = true ∧
      trentAnswersDispute.citesOnlyBefore .calvin 1548 = true ∧
      trentAnswersDispute.citesOnlyBefore .trentOnBaptism 1548 = true ∧
      trentAnswersDispute.citesOnlyBefore .trentOnFaith 1548 = true := by
  decide +kernel

/-- **The council's answer, told in the order it was given.** The four
Reformation voices come first, in the order they wrote, and the council's two
answers after them. Where a turn is said to meet an earlier one, the two defeat
each other, as the solver computes from their premises. -/
declare_bundle trentAnswersExchange in trentAnswersDispute.finite where
  /-- In June 1530 the Augsburg Confession confesses that people "are freely
  justified for Christ's sake, through faith", citing Romans 3 and 4. -/
  turn TrentAnswerParty.augsburg from augsburgConfession
  /-- In 1531 the *Apology* defends it from Romans 3:28 and Ephesians 2:8–9,
  "therefore by faith alone we are justified", and reads James 2:24 as
  agreeing. -/
  turn TrentAnswerParty.apology from melanchthonApology
  /-- In 1535 Luther, on Galatians 2:4–5, calls the teaching that faith
  "justifieth not, except it be furnished with charity" the false apostles'
  corruption of the gospel. -/
  turn TrentAnswerParty.luther from lutherGalatians1535
  /-- In 1539 Calvin answers Sadoleto from Romans 4:6–8: "We deny that good works
  have any share in justification", and Paul restricts justifying faith "to a
  gratuitous promise of the divine favour". -/
  turn TrentAnswerParty.calvin from calvinReplyToSadoleto
  /-- In January 1547 the council makes baptism "the instrumental cause" of
  justification, which "cannot be effected, without the laver of regeneration,
  or the desire thereof" (chs. 4 and 7), from John 3:5. Faith as the only means
  excludes it as the library states faith alone, so the council and the
  Augsburg Confession each defeat the other. -/
  turn TrentAnswerParty.trentOnBaptism meets TrentAnswerParty.augsburg from trentSessionVI
  /-- In ch. 7 the council also teaches that faith, "unless hope and charity
  be added thereto", does not unite a person perfectly with Christ, on James 2,
  Galatians 5:6 and Matthew 19:17, and canon 9 condemns "nothing else is required
  to co-operate". The two stand apart, because Luther's claim is stated as one
  about faith's form, that the faith which justifies is not formed by love, and
  not about whether faith suffices. -/
  turn TrentAnswerParty.trentOnFaith standsApart TrentAnswerParty.luther from trentSessionVI

/-- The Reformers' reading of 1530–1539: faith alone justifies, the faith that
justifies is not formed by love, and baptism is not the instrument of
justification. Where it is otherwise silent it holds every claim, except those
the argument's meanings exclude. -/
def reformersIn1547Reading : Valuation Claim := fun a =>
  match a with
  | .baptismIsInstrumentalCause => False
  | .justifyingFaithIsFormedByCharity => False
  | .justificationIsForensicOnly => False
  | .jamesUsesDikaioAsPaul => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- **The four Reformation voices stand together.** One reading satisfies the
Augsburg Confession, the *Apology*, Luther and Calvin at once. -/
theorem the_reformers_of_the_1530s_stand_together :
    trentAnswersDispute.StandTogether [.augsburg, .apology, .luther, .calvin] := by
  satisfied_by reformersIn1547Reading [Dispute.StandTogether, solaFideDefs]

/-- The council's reading of 1547, with Luther's claim beside it: baptism is the
instrumental cause, faith does not suffice without hope and charity, and
justification is not by faith alone; and the faith that justifies is not formed
by love. Where it is otherwise silent it holds every claim, except those the
argument's meanings exclude. -/
def councilReading : Valuation Claim := fun a =>
  match a with
  | .justificationByFaithAlone => False
  | .justifyingFaithIsFormedByCharity => False
  | .faithIsSufficient => False
  | .justificationIsForensicOnly => False
  | .jamesUsesDikaioAsPaul => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .energoumeneIsPassive => False
  | .loveMovesFaith => False
  | _ => True

/-- **The council's two answers stand together, and with Luther and Calvin as
the library states them.** One reading satisfies the council on baptism and on
faith, Luther's claim that the faith which justifies is not formed by love, and
Calvin's position of 1539, which concludes only that the faith which justifies
is not formed by love. -/
theorem the_council_stands_with_luthers_claim :
    trentAnswersDispute.StandTogether [.trentOnBaptism, .trentOnFaith, .luther, .calvin] := by
  satisfied_by councilReading [Dispute.StandTogether, solaFideDefs]

/-- Why Luther, Calvin and the council on faith are forced, and nothing else:
nothing defeats those three, and baptism and faith alone defeat each other. -/
declare_verdict trentAnswersSettle for trentAnswersDispute :
    .groundedExactly [[.luther, .calvin, .trentOnFaith]]
      [ (.augsburg, .trentOnBaptism), (.apology, .trentOnBaptism)
      , (.trentOnBaptism, .augsburg) ]
  /-- **After the council, faith alone and baptism as its instrument tie, and no
  other position in the exchange is defeated.** The council's chapter 7 makes
  baptism the instrument of justification, and faith alone, stated as faith
  being the only means, excludes it, so the council and the two Lutheran
  confessions defeat each other, on steps rated `disputed`. Luther's claim and
  Calvin's, that the faith which justifies is not formed by love, and the
  council's, that faith does not suffice without hope and charity, are forced,
  which means only that none of the three denies another as the claims are
  stated, though canon 9 condemns faith alone "in such wise as to mean, that
  nothing else is required to co-operate". -/
  proves @[headline] after_the_council_baptism_and_faith_alone_tie

#print axioms after_the_council_baptism_and_faith_alone_tie

end TestimonyArguments.SolaFide
