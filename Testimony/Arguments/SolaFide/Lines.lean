import Testimony.Arguments.SolaFide.Atoms
import Testimony.Logic.Line
import Testimony.Bib.Works

/-!
# Arguments.SolaFide.Lines — the strands, and what they share

Three strands deliver justification by faith alone, by different words from
different speakers: Paul, Jesus, and Peter at Jerusalem. A fourth line answers
James, and a fifth — the apocalyptic reading — denies what the strands
deliver. What every package holds in
common is collected here too, so that a variant package is a named difference
rather than a retyped list.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Lines of reason

Three strands deliver the conclusion, and a fourth line answers James. The James
harmonisation is deliberately *not* a strand: it does not reach
`justificationByFaithAlone` by an independent route, it supplies a premise the
closing step needs. So it contributes its grounds and its step to the case
without being one of the lines `caseOf` treats as converging. -/

/-- **The Pauline strand.** From Romans and Galatians to justification by faith
alone, read from Galatians 2:16 as the centre of the letter's polemic.

Each premise does its own work. Galatians 2:16 excludes works of the law; read
as an objective genitive, it also names faith in Christ as the means of
justification. The polemic says what is being refused: circumcision *added to*
faith as a requirement. That is where *alone* comes from. The Galatians already
believed, and adding a work to their faith is what Paul says severs them from
Christ (5:4). Only the ἔργα νόμου premise lets circumcision stand for works in
general rather than for one ethnic marker. -/
@[solaFideDefs]
def paulineToFaithAlone : Formula Claim :=
  ⋀ [ p .romans3_28, p .galatians2_16, p .galatiansOpposesCircumcisionAsRequirement
    , p .pistisChristouObjective, p .worksOfLawMeansWorksGenerally ]
  ➝ p .justificationByFaithAlone

/-- **The dominical strand.** From Jesus' own words at Luke 7:50 to
justification by faith alone, by way of the lexical premise about σῴζω and the
reading of 7:47 that answers "she loved much": her love shows her forgiveness
and does not earn it, so what Jesus names as saving her is her faith.
Independent of Paul, and of the ἔργα νόμου dispute. -/
@[solaFideDefs]
def dominicalToFaithAlone : Formula Claim :=
  ⋀ [p .luke7_50FaithHasSavedYou, p .sozoIsSoteriological, p .luke7_47LoveIsEvidence]
    ➝ p .justificationByFaithAlone

/-- **The apostolic strand.** From Peter's speech at the Jerusalem council to
justification by faith alone, by way of the disputed premise about the yoke.

The council answers the same demand Galatians answers: circumcision and the law
of Moses as a condition of salvation (Acts 15:1, 15:5). Peter's reply names
faith as what cleansed the gentiles' hearts and grace as how Jew and gentile
alike are saved, and refuses the yoke. If the yoke is the whole law as a
condition of salvation, what is left is faith, and grace. -/
@[solaFideDefs]
def apostolicToFaithAlone : Formula Claim :=
  ⋀ [p .acts15_9_11, p .acts15YokeIsLawAsCondition] ➝ p .justificationByFaithAlone

/-- The harmonisation of James: because James's target is barren faith, and
works are the fruit of saving faith rather than its ground, James 2:24 does not
contradict Paul. Derived rather than assumed. -/
@[solaFideDefs]
def jamesHarmonisation : Formula Claim :=
  ⋀ [p .james2TargetsDeadFaith, p .worksAreFruitNotGround] ➝ p .james2_24Compatible

/-- **The conclusion**, in its three parts: salvation is by grace, not by works,
and through faith. Stated as three atoms rather than one so that a position can
be shown to hold some parts and deny another — which the apocalyptic reading
and the Tridentine position each do, over different parts. -/
@[solaFideDefs]
def solaFide : Formula Claim :=
  ⋀ [p .salvationByGrace, p .salvationNotByWorks, p .salvationThroughFaith]

/-- The first two parts: by grace, and not by works. What the apocalyptic
reading keeps. -/
@[solaFideDefs]
def graceNotWorks : Formula Claim :=
  ⋀ [p .salvationByGrace, p .salvationNotByWorks]

/-- *By grace*, from the texts that say so: a gift through faith (Ephesians
2:8), a gift and not wages (Romans 4:4–5), mercy (Titus 3:5). Neither a strand
nor the answer to James is needed for this part. -/
@[solaFideDefs]
def toGrace : Formula Claim :=
  ⋀ [p .ephesians2_8_9, p .romans4_4_5, p .titus3_5] ➝ p .salvationByGrace

/-- *Not by works*, from the same texts, which say "not of works" in terms —
provided James 2:24 is answered, and scripture does not contradict itself. No
strand is needed for this part either; what it needs, and grace does not, is an
answer to James. -/
@[solaFideDefs]
def toNotByWorks : Formula Claim :=
  ⋀ [ p .ephesians2_8_9, p .romans4_4_5, p .titus3_5
    , p .james2_24Compatible, p .scriptureSelfConsistent ]
  ➝ p .salvationNotByWorks

/-- *Through faith*, from justification by faith alone and Ephesians 2:8. This
is the only part of the conclusion the three strands are needed for. -/
@[solaFideDefs]
def toThroughFaith : Formula Claim :=
  ⋀ [p .justificationByFaithAlone, p .ephesians2_8_9] ➝ p .salvationThroughFaith

/-- The Pauline line. Its grounds are the reading of Galatians as a polemic and
the two disputed lexical premises, about ἔργα νόμου and about πίστις Χριστοῦ.
The prooftexts its step reads are shared with every other package, which is
exactly why denying a lexical premise does not cost the argument its
prooftexts.

The genitive dispute is a premise *inside* this strand, not a third strand.
Every πίστις Χριστοῦ text sets it against νόμος, so a route through the genitive
still passes through what ἔργα νόμου denotes. A line on the genitive whose
grounds omitted the ἔργα νόμου premise would misdescribe Paul. -/
@[solaFideDefs]
def paulineLine : Line Claim :=
  { name := "Pauline strand (ἔργα νόμου, πίστις Χριστοῦ)"
  , grounds :=
      [ p .galatiansOpposesCircumcisionAsRequirement, p .worksOfLawMeansWorksGenerally
      , p .pistisChristouObjective ]
  , step := paulineToFaithAlone
  , delivers := p .justificationByFaithAlone }

/-- The dominical line, resting on Jesus' words rather than Paul's. Its
distinctive grounds are the other lexical premise, and the reading of 7:47 that
keeps the woman's love from being the ground of her forgiveness. -/
@[solaFideDefs]
def dominicalLine : Line Claim :=
  { name := "Dominical strand (σῴζω at Luke 7:50)"
  , grounds := [p .sozoIsSoteriological, p .luke7_47LoveIsEvidence]
  , step := dominicalToFaithAlone
  , delivers := p .justificationByFaithAlone }

/-- The apostolic line, resting on Peter as Luke reports him rather than on Paul
or on Jesus. Its distinctive ground is the premise about the yoke.

It is logically independent of the Pauline strand: no premise is shared. It is
not dialectically independent. A reader who takes ἔργα νόμου as Israel's
boundary markers will read Peter's yoke the same way, as Jervell does, so the
two premises tend to be won or lost together. What the encoding shows is that
they are two premises about two texts, and an opponent has to answer both. -/
@[solaFideDefs]
def apostolicLine : Line Claim :=
  { name := "Apostolic strand (Acts 15:7–11)"
  , grounds := [p .acts15YokeIsLawAsCondition]
  , step := apostolicToFaithAlone
  , delivers := p .justificationByFaithAlone }

/-- The James line: not a route to the conclusion but the answer to the one
text that stands against it. -/
@[solaFideDefs]
def jamesLine : Line Claim :=
  { name := "Harmonisation of James 2:24"
  , grounds := [p .james2TargetsDeadFaith, p .worksAreFruitNotGround]
  , step := jamesHarmonisation
  , delivers := p .james2_24Compatible }

/-- **The apocalyptic reading** (Martyn, Campbell). If πίστις Χριστοῦ is Christ's
own faithfulness, and δικαιοσύνη θεοῦ is God's act of deliverance, then faith is
not the condition on which justification is granted. So justification by faith
alone, in the sense the Reformed and New Perspective packages share, is
denied. Grace and "not by works" are not denied: the reading rejects the
condition, not the gift. -/
@[solaFideDefs]
def deliveranceNotFaithAlone : Formula Claim :=
  ⋀ [notP .pistisChristouObjective, p .righteousnessOfGodIsDeliverance]
  ➝ notP .justificationByFaithAlone

/-- What the apocalyptic reading keeps. If δικαιοσύνη θεοῦ is God's act of
deliverance, it is sheer gift, conditioned on nothing a person does: by grace,
and not by works. Campbell's inference, and his reason for calling the reading
more gracious than the one it replaces. -/
@[solaFideDefs]
def deliveranceIsGrace : Formula Claim :=
  p .righteousnessOfGodIsDeliverance ➝ graceNotWorks

/-- The apocalyptic line: a rival route from Paul, delivering the denial of
what the two Reformed strands deliver. -/
@[solaFideDefs]
def apocalypticLine : Line Claim :=
  { name := "Apocalyptic reading (δικαιοσύνη θεοῦ as deliverance)"
  , grounds := [notP .pistisChristouObjective, p .righteousnessOfGodIsDeliverance]
  , step := deliveranceNotFaithAlone
  , delivers := notP .justificationByFaithAlone }

/-- **The New Perspective's reason** for its reading of ἔργα νόμου. If Second
Temple Judaism was covenantal nomism — in by grace, staying in by works — then
Paul's opponents were not seeking to earn salvation, and what he refuses is not
works as such but the marks that kept gentiles out: the boundary markers. The
ground is Sanders'; the inference is Dunn's, and is cited as his. -/
@[solaFideDefs]
def sandersLine : Line Claim :=
  { name := "Covenantal nomism (Sanders, Dunn)"
  , grounds := [p .secondTempleCovenantalNomism]
  , step := p .secondTempleCovenantalNomism ➝ notP .worksOfLawMeansWorksGenerally
  , delivers := notP .worksOfLawMeansWorksGenerally
  , inference :=
      some
        { primary := .work dunnNewPerspective .whole
        , supporting := [.work wrightWhatPaulSaid .whole]
        , tradition := .criticalScholarship
        , confidence := .disputed } }

/-- **The critics' reply.** If Second Temple Judaism also held final vindication
according to works, then the demand Galatians refuses — circumcision added to
faith as a requirement — is a demand for obedience, and what Paul refuses in
refusing it is works as such. So the Reformed reading of ἔργα νόμου is not
assumed but derived: from the reading of Galatians as a polemic, and from a
historical claim about Judaism that is argued on the evidence. -/
@[solaFideDefs]
def criticsLine : Line Claim :=
  { name := "Variegated nomism (Gathercole, Carson et al.)"
  , grounds :=
      [notP .secondTempleCovenantalNomism, p .galatiansOpposesCircumcisionAsRequirement]
  , step :=
      ⋀ [notP .secondTempleCovenantalNomism, p .galatiansOpposesCircumcisionAsRequirement]
      ➝ p .worksOfLawMeansWorksGenerally
  , delivers := p .worksOfLawMeansWorksGenerally
  , inference :=
      some
        { primary := .work gathercoleWhereIsBoasting .whole
        , supporting := [.work carsonVariegatedNomism1 .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }

/-- **Jervell's reading of the yoke.** If Luke presents the Jewish believers as
keeping the law (Acts 21:20–24), and the decree as laying part of it on
gentiles (Acts 15:20–21), then what Peter refuses at 15:10 is not the law as a
condition of salvation but the whole of Israel's law laid on gentiles. The
step is contested: Bruce grants both texts and reads the yoke as the law taken
as a condition of salvation. -/
@[solaFideDefs]
def jervellLine : Line Claim :=
  { name := "Law-observant Luke (Jervell)"
  , grounds := [p .lukeKeepsTheLaw]
  , step := p .lukeKeepsTheLaw ➝ notP .acts15YokeIsLawAsCondition
  , delivers := notP .acts15YokeIsLawAsCondition
  , inference :=
      some
        { primary := .work jervellLukePeopleOfGod .whole
        , tradition := .criticalScholarship
        , confidence := .disputed } }

/-- Trent's step from its definition to merit: if justification *is* the
renewal of the inward man, and that renewal grows through good works, then good
works increase justification (Session VI, ch. 10 and canon 24). Rated
`consensus`, as `trentOnMerit` is: the Reformed deny the definition, not the
inference, and canon 24 condemns the Reformed alternative by name — that works
are "merely the fruits and signs of Justification obtained". -/
def trentOnIncrease : Source :=
  { primary := .work tannerDecrees (.sectionRef "Trent, Session VI (1547), canon 24")
  , supporting :=
      [ .work tannerDecrees
          (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 10") ]
  , tradition := .romanCatholic
  , confidence := .consensus }

/-- **Trent's line.** From its definition of justification — the renewal of the
inward man, not remission of sins only — and the growth of that renewal through
good works, to merit: good works increase justification (Session VI, ch. 10,
canon 24). The Reformed grant the growth and deny the definition, so the step
carries the objection only as far as the definition does. -/
@[solaFideDefs]
def tridentineLine : Line Claim :=
  { name := "Trent (justification as renewal)"
  , grounds := [p .justificationIncludesSanctification, p .renewalGrowsThroughGoodWorks]
  , step :=
      ⋀ [p .justificationIncludesSanctification, p .renewalGrowsThroughGoodWorks]
        ➝ p .worksMeritIncreaseOfJustification
  , delivers := p .worksMeritIncreaseOfJustification
  , inference := some trentOnIncrease }

/-- What Trent's definition rules out: justification as forensic only (canon 11),
and justification as distinct from the sanctification that follows it. -/
@[solaFideDefs]
def trentDefinitionSteps : List (Formula Claim) :=
  [ p .justificationIncludesSanctification ➝ notP .justificationIsForensicOnly
  , p .justificationIncludesSanctification ➝ notP .justificationDistinctFromSanctification ]

/-- The prooftexts the strands read. Shared by every Reformed package, and by
the New Perspective. -/
@[solaFideDefs]
def prooftexts : List (Formula Claim) :=
  [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .romans4_4_5
  , p .titus3_5, p .luke7_50FaithHasSavedYou, p .acts15_9_11 ]

/-- Everything the strands share: the prooftexts, the grounds of the James
harmonisation, and scripture's self-consistency. -/
@[solaFideDefs]
def sharedGrounds : List (Formula Claim) :=
  prooftexts ++ jamesLine.grounds ++ [p .scriptureSelfConsistent]

/-- The same, with James unanswered. -/
@[solaFideDefs]
def sharedGroundsWithoutJames : List (Formula Claim) :=
  prooftexts ++ [p .scriptureSelfConsistent]

/-- The three steps to the three parts of the conclusion, one each. -/
@[solaFideDefs]
def conclusionSteps : List (Formula Claim) := [toGrace, toNotByWorks, toThroughFaith]

/-- The steps that close the argument: the James harmonisation, then the steps
to the parts of the conclusion. -/
@[solaFideDefs]
def closingSteps : List (Formula Claim) := jamesLine.step :: conclusionSteps

end Testimony.Arguments.SolaFide
