import TestimonyArguments.SolaFide.Dispute

/-!
# TestimonyArguments.SolaFide.BeforeTrent — what was read in Paul before Trent

Paul wrote to the Romans that "a person is justified by faith apart from works
of the law" (3:28), and that to the one "who does not work but believes in Him
who justifies the ungodly, his faith is counted as righteousness" (4:5). Fifteen
centuries passed before the Council of Trent met, in 1545, to answer the
Reformers. The question this chapter asks is the one a reader of that council
asks first: was "faith alone" a reading of Paul that the Reformation invented, or
was it read in him before?

It was read in him before, and in the fathers' own words. In the 350s Hilary of
Poitiers, explaining how Jesus forgave the paralysed man what the law could not
release, wrote that "faith alone justifies" (*fides enim sola justificat*). Basil
of Caesarea, preaching on humility about 375, said that a person knows himself
"justified by faith alone, the faith in Christ". In the same years the writer
we call Ambrosiaster commented on Romans 3:24 that the ungodly "are
justified freely because, doing nothing and giving nothing in return, they are
justified by faith alone, a gift of God". Chrysostom, preaching at Antioch about
391, said that God justified "without needing works, but looking for faith
only". Rufinus put Origen's commentary on Romans into Latin about 406, and in it
faith alone suffices, as it did for the thief on the cross. Bernard of Clairvaux
preached to his monks in the 1130s that one "justified by faith alone" shall have peace
with God, and Aquinas wrote on 1 Timothy that there is "no hope of
justification" in the law's commands, "but in faith alone" (*sed in sola fide*).
That they wrote this is rated `consensus`, because it is read in their Latin and
Greek (`fathersOnFaithAlone`).

So the reading of Paul as justification by faith alone, with no work before it
earning it, stood in the East and the West from the fourth century to the
thirteenth. Trent itself grants that much: "none of those things which precede
justification, whether faith or works, merit the grace itself of justification"
(Session VI, ch. 8).

What the fathers meant by it is another question, and the one that divided
Trent from the Reformers. Augustine, writing about the end of 412, explained
"being justified" as "being made righteous" (*On the Spirit and the Letter*,
ch. 45), so that justification includes the renewal of the person, though in
the same passage he allows "deemed, or reckoned as just" as a second way of
taking the word. Aquinas read it the same way, and so did the Latin West after
him. The Reformers held that
justification is a verdict only, kept distinct from the renewal that comes with
it. Modern historians part over whether the fathers' "faith alone" meant that.
Thomas Oden (2002) and D. H. Williams (2006) find the Reformation's teaching
anticipated in them. Alister McGrath (*Iustitia Dei*) calls the Reformers'
distinction between justification and renewal "a genuine theological novum".

The positions are heard in two ways. Heard as a whole, the dispute includes the
reading of the fathers as the Reformers read them, which rests on Oden and
Williams. Heard alone (`beforeTrentAlone`), the debate keeps only the positions
that cite nothing written after 1545, and the build checks that they cite
nothing later (`heard_before_trent`). In both, the fathers' reading of Paul is
forced (`the_fathers_reading_stands_before_trent`,
`the_fathers_reading_stands_in_the_whole_debate`). No position defeats it.
The Reformers hold it, and their reading of the fathers is built on it, so it
lends them its conclusion. Augustine's reading denies nothing it says either:
the same chapter of his treatise is headed "it is not by their works, but by
grace, that the doers of the law are justified". Before Trent, faith alone and
justification as making righteous were held together
(`faith_alone_stood_with_augustine`).

What is not settled is narrower: whether the justification the fathers said is
by faith alone is a verdict only, or also the renewal of the person. The
Reformers read the fathers as teaching the verdict, and Augustine taught the
renewal. That step is rated `disputed` on both sides, so there, and only there,
Augustine's reading and the Reformers' reading of the fathers defeat each other.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Logic.Framework Testimony.Scripture

/-! ### The sources before Trent

Each claim the positions below rest on is cited to Scripture, or to a work
written before 1545. Romans 3:28 and 4:4–5 are cited to the text alone, and
Augustine to his own treatise. -/

/-- The sources of the debate before Trent: Scripture for Romans 3:28 and
4:4–5; Augustine's *On the Spirit and the Letter* for his explanation of "being
justified" and for justification as renewal; and, for every other claim, the
sources the argument gives it elsewhere. -/
@[solaFideDefs]
def beforeTrentCite : Claim → AtomMeta
  | .romans3_28 =>
    { label := "Romans 3:28 teaches justification by faith apart from works of the law"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.romans, 3, 28⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .romans4_4_5 =>
    { label := "Romans 4:4–5 contrasts wages owed with a gift reckoned to the one who believes"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .range ⟨.romans, 4, 4, 4, 5⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .augustineReadsJustifyAsMakeRighteous =>
    { label := "Augustine explains \"being justified\" as \"being made righteous\""
    , kind := .historical
    , source :=
        { primary := .work augustineSpiritAndLetter (.sectionRef "ch. 45")
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .justificationIncludesSanctification =>
    { label := "Justification includes the renewal of the inward person"
    , kind := .theological
    , source :=
        { primary := .work augustineSpiritAndLetter (.sectionRef "ch. 45")
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | c => baseCite c

/-! ### The fathers' reading of Paul -/

/-- **Who draws the step to faith alone.** Ambrosiaster, from Romans 3:24: "they
are justified freely because, doing nothing and giving nothing in return, they
are justified by faith alone, a gift of God"; and Hilary, "faith alone
justifies". Rated `wellSupported`, because the readers before Trent who take up
Romans 3:28 and 4:5, Augustine among them, teach that no work before faith earns
justification. -/
def fathersStep : Source :=
  { primary := .work ambrosiasterRomans (.sectionRef "on Romans 3:24")
  , supporting := [.work hilaryOnMatthew (.sectionRef "8.6")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **Justified by faith alone, as the fathers read Paul.** Paul says a person is
justified "by faith apart from works of the law" (Romans 3:28), and that faith is
counted as righteousness to the one "who does not work but believes" (4:5).
Readers of Paul from Hilary and Basil to Bernard and Aquinas wrote that the
ungodly are justified by faith alone. So God justifies the ungodly by faith
alone, as a gift, and no work that comes before faith earns it. -/
@[solaFideDefs]
def fathersLine : Line Claim :=
  { name := "Justified by faith alone, as the fathers read Paul"
  , grounds := [p .romans3_28, p .romans4_4_5, p .fathersWroteFaithAlone]
  , step := ⋀ [p .romans3_28, p .romans4_4_5, p .fathersWroteFaithAlone] ➝
      p .justifiedByFaithWithoutPriorWorks
  , delivers := p .justifiedByFaithWithoutPriorWorks
  , inference := some fathersStep }

/-- The fathers' reading of Paul, as a position: Romans 3:28 and 4:4–5, and what
the fathers and schoolmen before Trent wrote of faith alone. -/
@[solaFideDefs]
def fathersCase : ArgumentPackage Claim :=
  fathersLine.asPackage beforeTrentCite "justified by faith alone, no prior work earning it"

/-! ### Augustine's reading -/

/-- **Who draws the step to renewal.** Augustine himself: "what else does the
phrase 'being justified' signify than being made righteous" (*On the Spirit and
the Letter*, ch. 45). Rated `disputed`, because the Reformers grant that
Augustine wrote it and deny that justification therefore includes renewal. -/
def augustineStep : Source :=
  { primary := .work augustineSpiritAndLetter (.sectionRef "ch. 45")
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- **Justification as making righteous, as Augustine read it.** Augustine
explains "being justified" as "being made righteous, by Him, of course, who
justifies the ungodly man, that he may become a godly one". So justification
includes the renewal of the person. In the same passage Augustine gives a
second way of taking the word, "deemed, or reckoned as just"
(`augustineGivesBothSenses`), and this line, like Trent's, leaves it out; the
fallacy checks report the omission. He put the renewal first, and that is the
reading the Latin West received. -/
@[solaFideDefs]
def renewalLine : Line Claim :=
  { name := "Justification makes righteous (Augustine)"
  , grounds := [p .augustineReadsJustifyAsMakeRighteous]
  , step := p .augustineReadsJustifyAsMakeRighteous ➝
      p .justificationIncludesSanctification
  , delivers := p .justificationIncludesSanctification
  , inference := some augustineStep }

/-- Augustine's reading, as a position. -/
@[solaFideDefs]
def augustineCase : ArgumentPackage Claim :=
  renewalLine.asPackage beforeTrentCite "justification includes the renewal of the person"

/-! ### The fathers read as the Reformers read them -/

/-- **Who draws the step to a verdict only.** Thomas Oden, who finds in the
fathers "standard Reformation teaching" already in the fourth century, and D. H.
Williams, for whom Hilary "explicitly formulates a biblical theology of 'fides
sola iustificat'". Rated `disputed`, because McGrath grants that the fathers wrote
of faith alone and denies that they kept justification distinct from renewal:
the Reformers' distinction is "a genuine theological novum". -/
def reformersOnTheFathersStep : Source :=
  { primary := .work odenJustificationReader .whole
  , supporting := [.work williamsPatristicJustification .whole]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- **The fathers' faith alone, read as the Reformers' verdict.** What the
fathers wrote of faith alone, and justification by faith alone with no prior
work earning it, mean what the Reformers taught: justification is a verdict
only, forgiveness and righteousness counted, and not the renewal of the
person. -/
@[solaFideDefs]
def reformersOnTheFathersLine : Line Claim :=
  { name := "The fathers' faith alone is the Reformers' verdict (Oden, Williams)"
  , grounds := [p .fathersWroteFaithAlone, p .justifiedByFaithWithoutPriorWorks]
  , step := ⋀ [p .fathersWroteFaithAlone, p .justifiedByFaithWithoutPriorWorks] ➝
      p .justificationIsForensicOnly
  , delivers := p .justificationIsForensicOnly
  , inference := some reformersOnTheFathersStep }

/-- The fathers read as the Reformers read them, as a position: the fathers'
reading of Paul, and the step from it to a verdict only. -/
@[solaFideDefs]
def reformersOnTheFathers : ArgumentPackage Claim :=
  { name := "The fathers read as the Reformers read them"
  , cite := beforeTrentCite
  , premises := fathersLine.premises ++ reformersOnTheFathersLine.premises
  , conclusion := p .justificationIsForensicOnly
  , conclusionLabel := "justification is a verdict only"
  , inferences := [fathersStep, reformersOnTheFathersStep] }

/-! ### The debate before Trent, weighed -/

/-- The parties to the debate over what was read in Paul before Trent. -/
inductive BeforeTrentParty
  /-- The fathers' reading of Paul: justified by faith alone. -/
  | fathers
  /-- Augustine: justification makes righteous. -/
  | augustine
  /-- The fathers read as the Reformers read them: a verdict only. -/
  | reformersOnTheFathers
deriving DecidableEq

/-- The package each party argues from. -/
@[solaFideDefs]
def beforeTrentNode : BeforeTrentParty → ArgumentPackage Claim
  | .fathers => fathersCase
  | .augustine => augustineCase
  | .reformersOnTheFathers => reformersOnTheFathers

/-- The debate over what was read in Paul before Trent. -/
declare_dispute beforeTrentDispute := beforeTrentNode using solaFideDefs
  /-- **Who defeats whom**, all 9 pairs. Augustine's reading and the Reformers'
  reading of the fathers defeat each other, because a verdict only and a
  justification that includes renewal cannot both be true. Nothing defeats the
  fathers' reading of Paul, and it defeats nothing. Every cell is checked by the
  kernel. -/
  defeats [(.augustine, .reformersOnTheFathers), (.reformersOnTheFathers, .augustine)]
  /-- **One position supports another**, in all 9 pairs: the fathers' reading of
  Paul lends the Reformers' reading of the fathers its conclusion, which that
  reading takes as a ground. Every cell is checked by the kernel. -/
  supports [(.fathers, .reformersOnTheFathers)]
  /-- Each party's case is part of its own and of no other's, except that the
  fathers' reading is part of the Reformers' reading of them. Every cell is
  checked by the kernel. -/
  partOf [(.fathers, .reformersOnTheFathers)]
  /-- The debate before Trent drawn: who defeats whom. -/
  map beforeTrentMap

/-- **The debate before Trent, heard alone**: the fathers' reading of Paul and
Augustine's, which cite only Scripture and works written before 1545. Not heard:
the fathers read as the Reformers read them, which rests on modern
historians. -/
declare_hearing beforeTrentAlone := beforeTrentDispute
  except [BeforeTrentParty.reformersOnTheFathers]

/-- **The hearing before Trent hears only what was written before 1545.** Every
reference the fathers' reading and Augustine's cite, for their claims and for
their steps, is Scripture or a work dated before 1545, and the Reformers'
reading of the fathers cites works written after it. -/
theorem heard_before_trent :
    beforeTrentDispute.citesOnlyBefore .fathers 1545 = true ∧
      beforeTrentDispute.citesOnlyBefore .augustine 1545 = true ∧
      beforeTrentDispute.citesOnlyBefore .reformersOnTheFathers 1545 = false := by
  decide +kernel

/-- The reading on which the fathers' faith alone and Augustine's renewal hold
together, as they did for Aquinas: the ungodly are justified by faith alone, no
work earning it, and justification makes them righteous, so it is not a verdict
only. Where it is otherwise silent it holds every claim, except those the
argument's meanings exclude: baptism as the instrument, James's word as Paul's,
and the Latin of Revelation 22:11 and Sirach 18:22. -/
def faithAloneWithRenewalReading : Valuation Claim := fun a =>
  match a with
  | .justificationIsForensicOnly => False
  | .baptismIsInstrumentalCause => False
  | .jamesUsesDikaioAsPaul => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | _ => True

/-- **Before Trent, faith alone stood with Augustine.** One reading satisfies the
fathers' reading of Paul and Augustine's together: justified by faith alone, no
prior work earning it, and justification makes righteous. -/
theorem faith_alone_stood_with_augustine :
    beforeTrentDispute.StandTogether [.fathers, .augustine] := by
  satisfied_by faithAloneWithRenewalReading [Dispute.StandTogether, solaFideDefs]

/-- Why both readings before Trent are forced: nothing heard before 1545 defeats
either. -/
declare_verdict beforeTrentSettles for beforeTrentAlone :
    .groundedExactly [Witness.listSub _ [.fathers, .augustine]] (Witness.Table.sub _ [])
  /-- **Before Trent, the fathers' reading of Paul is forced, and so is
  Augustine's.** Heard on Scripture and works before 1545 alone, nothing defeats
  either: justification by faith alone, with no work before faith earning it,
  and justification as making righteous were held together. -/
  proves @[headline] the_fathers_reading_stands_before_trent

#print axioms the_fathers_reading_stands_before_trent

/-- Why the fathers' reading is forced in the whole debate: nothing defeats it.
Augustine and the Reformers' reading of the fathers defeat each other. -/
declare_verdict fathersSettle for beforeTrentDispute :
    .groundedExactly [[.fathers]]
      [(.augustine, .reformersOnTheFathers), (.reformersOnTheFathers, .augustine)]
  /-- **The fathers' reading of Paul is forced in the whole debate too.** Heard
  with the Reformers' reading of the fathers, nothing defeats it. The Reformers
  hold that the ungodly are justified by faith alone, with no prior work earning
  it, as the fathers wrote, and their reading of the fathers takes that as a
  ground. What they part with Augustine over is what that justification is: a
  verdict only, or also the renewal of the person. The step from the fathers'
  words to a verdict only is rated `disputed`, as is Augustine's step to
  renewal, so on that question alone his reading and the Reformers' reading of
  the fathers defeat each other, and neither is forced. -/
  proves @[headline] the_fathers_reading_stands_in_the_whole_debate

#print axioms the_fathers_reading_stands_in_the_whole_debate

end TestimonyArguments.SolaFide
