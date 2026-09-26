import Testimony.Arguments.SolaFide.Sources
import Testimony.Arguments.SolaFide.Lines

/-!
# Arguments.SolaFide.Packages — the positions, and the variants

The positions — Reformed, New Perspective, subjective genitive,
law-observant Luke, Finnish, critical authorship, apocalyptic, Tridentine — and
reduced Reformed packages, each missing a named premise.
Whether a premise is load-bearing is shown by removing it and then either
establishing the conclusion anyway or naming a countermodel.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Packages -/

/-- The classical Protestant position: all three strands, and every disputed
premise they rest on — ἔργα νόμου and πίστις Χριστοῦ in Paul, σῴζω in Luke, the
yoke in Acts. -/
@[solaFideDefs]
def reformed : ArgumentPackage Claim :=
  { name := "Reformed (sola fide)"
  , cite := reformedCite
  , premises :=
      caseOf [paulineLine, dominicalLine, apostolicLine] sharedGrounds closingSteps
  , conclusion := solaFide
  , conclusionLabel := "salvation by grace, not by works, through faith" }

/-- The dominical line without the σῴζω premise. The reading of 7:47 stays: it
is not the premise being tested. -/
@[solaFideDefs]
def dominicalWithoutSozo : Line Claim :=
  dominicalLine.onGrounds [p .luke7_47LoveIsEvidence]

/-- The Pauline line without the ἔργα νόμου premise. -/
@[solaFideDefs]
def paulineWithoutWorksOfLaw : Line Claim :=
  paulineLine.onGrounds
    [p .galatiansOpposesCircumcisionAsRequirement, p .pistisChristouObjective]

/-- The Pauline line without the objective genitive. -/
@[solaFideDefs]
def paulineWithoutPistisChristou : Line Claim :=
  paulineLine.onGrounds
    [p .galatiansOpposesCircumcisionAsRequirement, p .worksOfLawMeansWorksGenerally]

/-- The New Perspective on Paul: it denies the traditional reading of ἔργα
νόμου while accepting justification by faith, which is what Dunn and Wright
actually hold. It keeps the objective genitive, as Dunn does, so the one
Pauline ground it denies is the ἔργα νόμου premise.

The denial is not assumed: `sandersLine` derives it from covenantal nomism, so
the package rests on Sanders' account of Judaism and Dunn's inference from it,
which is where its critics engage it.

It takes no position on the yoke of Acts 15:10: the apostolic line keeps its
step and loses its ground, so the package neither grants nor denies the premise
on the New Perspective's behalf. -/
@[solaFideDefs]
def newPerspective : ArgumentPackage Claim :=
  { reformed with
    name := "New Perspective on Paul"
    cite := newPerspectiveCite
    premises :=
      caseOf
        [ paulineWithoutWorksOfLaw, sandersLine, dominicalLine
        , apostolicLine.onGrounds [] ]
        sharedGrounds closingSteps }

/-- The Finnish reading of Luther (Mannermaa): the Reformed case, with the
forensic account of justification denied. Christ himself is present in faith
and is the believer's righteousness, so justification is not a declaration
only.

On what justification *is*, this sides with Trent against the Reformed
account; on sola fide it sides with the Reformed. The encoding shows both, and
shows that the two questions are independent. -/
@[solaFideDefs]
def finnish : ArgumentPackage Claim :=
  { reformed with
    name := "Finnish reading of Luther (Mannermaa)"
    cite := finnishCite
    premises := reformed.premises ++ [notP .justificationIsForensicOnly] }

/-- The subjective genitive (Hays): πίστις Χριστοῦ in Galatians 2:16 is Christ's
own faithfulness, so the verse does not name the believer's faith as the means
of justification. Everything else in the Reformed case is granted. -/
@[solaFideDefs]
def subjectiveGenitive : ArgumentPackage Claim :=
  { reformed with
    name := "Subjective genitive (πίστις Χριστοῦ as Christ's faithfulness)"
    cite := subjectiveGenitiveCite
    premises :=
      caseOf
        [ paulineLine.onGrounds
            [ p .galatiansOpposesCircumcisionAsRequirement
            , p .worksOfLawMeansWorksGenerally, notP .pistisChristouObjective ]
        , dominicalLine, apostolicLine ]
        sharedGrounds closingSteps }

/-- Luke as law-observant (Jervell): the yoke Acts 15:10 refuses is Israel's law
laid on gentiles as a mark of belonging, not the law as a condition of
salvation. Everything else in the Reformed case is granted. The rival the
apostolic strand was written against. -/
@[solaFideDefs]
def lawObservantLuke : ArgumentPackage Claim :=
  { reformed with
    name := "Law-observant Luke (the yoke as Israel's law for gentiles)"
    cite := lawObservantLukeCite
    premises :=
      caseOf
        [ paulineLine, dominicalLine
        , apostolicLine.onGrounds [notP .acts15YokeIsLawAsCondition] ]
        sharedGrounds closingSteps }

/-- The Reformed case granted every critical conclusion about authorship:
Ephesians and Titus not by Paul, 1 and 2 Peter not by Peter.

Nothing else changes, and that is the point. The case reads these letters as
canonical scripture, bound together by `scriptureSelfConsistent`, not as the
testimony of a named apostle. So conceding their authorship costs the argument
nothing — while it would cost an argument that cited Ephesians 2:9 as evidence
of what *Paul* meant by "works", which is why `worksOfLawMeansWorksGenerally`
leans on Romans instead. -/
@[solaFideDefs]
def criticalAuthorship : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, with the critical view of authorship"
    cite := criticalAuthorshipCite
    premises :=
      reformed.premises ++
        [ notP .ephesiansIsPauline, notP .titusIsPauline
        , notP .firstPeterIsPetrine, notP .secondPeterIsPetrine ] }

/-- The apocalyptic reading of Paul (Martyn, Campbell). It rejects the
traditional reading's framing of justification and also the New Perspective's.
The question is neither how an individual is accepted nor how Jew and gentile
are related, but God's deliverance of the world in Christ.

It shares Galatians with the Reformed reading — the text of 2:16 and the
circumcision polemic — and closes with the same step to salvation. It does not
share the dominical or apostolic strands, which neither Martyn nor Campbell
argues from; to grant it Luke 7:50 or Acts 15 would be to encode a position
nobody holds. -/
@[solaFideDefs]
def apocalyptic : ArgumentPackage Claim :=
  { reformed with
    name := "Apocalyptic reading of Paul (Martyn, Campbell)"
    cite := apocalypticCite
    premises :=
      caseOf [apocalypticLine]
        [p .galatians2_16, p .galatiansOpposesCircumcisionAsRequirement]
        [deliveranceIsGrace, toThroughFaith] }

/-- The apocalyptic reading, asked only about the first two parts of the
conclusion: by grace, and not by works. -/
@[solaFideDefs]
def apocalypticOnGraceAndWorks : ArgumentPackage Claim :=
  { apocalyptic with
    name := "Apocalyptic reading, on grace and works only"
    conclusion := graceNotWorks
    conclusionLabel := "salvation by grace, not by works" }

/-- Trent's premises, given the line that carries its definition to merit: four
prooftexts it shares with the Reformed, scripture's self-consistency, what its
definition rules out, and the step from merit to the denial of "not by works"
(ch. 16).

Not built from the Reformed lines, and that is the point: it shares four
prooftexts with them and nothing else, so `caseOf` would misdescribe it. -/
@[solaFideDefs]
def tridentinePremises (line : Line Claim) : List (Formula Claim) :=
  [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .titus3_5
  , p .scriptureSelfConsistent ] ++ line.premises ++ trentDefinitionSteps ++
  [p .worksMeritIncreaseOfJustification ➝ notP .salvationNotByWorks]

/-- The Tridentine position: justification is the renewal of the inward man,
that renewal grows through good works, so works performed in grace merit an
increase of justification — which denies the second part of the conclusion,
salvation not by works. The same definition denies that justification is
forensic only. -/
@[solaFideDefs]
def tridentine : ArgumentPackage Claim :=
  { reformed with
    name := "Tridentine (Council of Trent, Session VI)"
    cite := tridentineCite
    premises := tridentinePremises tridentineLine }

/-! ### Variants

Each removes named premises from `reformed` and keeps the rest. The Pauline
strand has two lexical premises, so it has two reduced forms. -/

/-- The Reformed package without the ἔργα νόμου premise. -/
@[solaFideDefs]
def reformedWithoutWorksOfLaw : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the ἔργα νόμου premise"
    premises :=
      caseOf [paulineWithoutWorksOfLaw, dominicalLine, apostolicLine]
        sharedGrounds closingSteps }

/-- The Reformed package without the dominical lexical premise. -/
@[solaFideDefs]
def reformedWithoutSozo : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the dominical lexical premise"
    premises :=
      caseOf [paulineLine, dominicalWithoutSozo, apostolicLine]
        sharedGrounds closingSteps }

/-- The Reformed package with the ἔργα νόμου premise **and** the dominical
premise removed: the two disputes the argument was first built to survive. The
apostolic strand is untouched. -/
@[solaFideDefs]
def reformedWithoutWorksOfLawOrSozo : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the ἔργα νόμου and σῴζω premises"
    premises :=
      caseOf [paulineWithoutWorksOfLaw, dominicalWithoutSozo, apostolicLine]
        sharedGrounds closingSteps }

/-- The Reformed package with a disputed premise removed from **every** strand:
ἔργα νόμου from Paul, σῴζω from Luke, the yoke from Acts. The objective
genitive stays. -/
@[solaFideDefs]
def reformedWithoutEveryStrandsPremise : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the ἔργα νόμου, σῴζω and yoke premises"
    premises :=
      caseOf
        [paulineWithoutWorksOfLaw, dominicalWithoutSozo, apostolicLine.onGrounds []]
        sharedGrounds closingSteps }

/-- The same with the objective genitive removed in place of ἔργα νόμου: the
Pauline strand loses its other lexical premise, and the other two strands
theirs. -/
@[solaFideDefs]
def reformedWithoutPistisChristouSozoOrYoke : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the πίστις Χριστοῦ, σῴζω and yoke premises"
    premises :=
      caseOf
        [ paulineWithoutPistisChristou, dominicalWithoutSozo
        , apostolicLine.onGrounds [] ]
        sharedGrounds closingSteps }

/-- The Reformed package with **every** lexical premise removed — both of
Paul's, Luke's σῴζω and the yoke of Acts 15 — asked only about grace and works.
The reading of Galatians as a polemic stays, and so does the answer to James. -/
@[solaFideDefs]
def graceAndWorksWithoutAnyLexicalPremise : ArgumentPackage Claim :=
  { reformed with
    name := "Grace and works, minus every lexical premise"
    premises :=
      caseOf
        [ paulineLine.onGrounds [p .galatiansOpposesCircumcisionAsRequirement]
        , dominicalWithoutSozo, apostolicLine.onGrounds [] ]
        sharedGrounds closingSteps
    conclusion := graceNotWorks
    conclusionLabel := "salvation by grace, not by works" }

/-- The New Perspective's critics (Gathercole, the *Variegated Nomism* volume),
on the Pauline strand alone: the ἔργα νόμου premise derived from a denial of
covenantal nomism rather than assumed, and the other two strands left out. Does
Paul alone carry sola fide on Gathercole's history? -/
@[solaFideDefs]
def paulineStrandOnTheCritics : ArgumentPackage Claim :=
  { reformed with
    name := "Pauline strand alone, on variegated nomism"
    cite := criticsCite
    premises :=
      caseOf [paulineWithoutWorksOfLaw, criticsLine] sharedGrounds closingSteps }

/-- The same on Sanders' reading of Judaism. -/
@[solaFideDefs]
def paulineStrandOnSanders : ArgumentPackage Claim :=
  { reformed with
    name := "Pauline strand alone, on covenantal nomism"
    cite := newPerspectiveCite
    premises :=
      caseOf [paulineWithoutWorksOfLaw, sandersLine] sharedGrounds closingSteps }

/-- The Reformed package without the premises that harmonise James. -/
@[solaFideDefs]
def reformedWithoutJamesHarmonisation : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the James harmonisation"
    premises :=
      caseOf [paulineLine, dominicalLine, apostolicLine] sharedGroundsWithoutJames
        conclusionSteps }

/-- The same, asked only about the first part of the conclusion: is salvation by
grace, with James 2:24 left unanswered? -/
@[solaFideDefs]
def graceWithoutJamesHarmonisation : ArgumentPackage Claim :=
  { reformedWithoutJamesHarmonisation with
    name := "Grace alone, minus the James harmonisation"
    conclusion := p .salvationByGrace
    conclusionLabel := "salvation by grace" }

/-- Trent, as the argument it makes in a dispute: justification is the renewal of
the inward man, that renewal grows through good works, so works done in grace
merit an increase of justification, and salvation is not apart from works. The
same premises as `tridentine`, concluding what Trent denies. -/
@[solaFideDefs]
def tridentineCase : ArgumentPackage Claim :=
  { tridentine with
    name := "Trent, against 'not by works'"
    conclusion := notP .salvationNotByWorks
    conclusionLabel := "salvation is not apart from works"
    inferences := [trentOnMerit, trentOnIncrease] }

/-! ### Paul's gospel, against Trent's definition -/

/-- **Paul's gospel, against justification as renewal.** Galatians and
1 Corinthians read as one claim — Christ's work is the whole ground — with the
forensic sense of δικαιόω and Romans 8:33–34, concluding that justification is
not the renewal of the inward man: the direct denial of Trent's definition
(Session VI, ch. 7). -/
@[solaFideDefs]
def galatianGospel : ArgumentPackage Claim :=
  { reformed with
    name := "Paul's gospel (Galatians 1), against justification as renewal"
    premises :=
      galatianGospelLine.premises ++
        [p .romans8_33_34, p .dikaioIsForensic, verdictExcludesRenewal]
    conclusion := notP .justificationIncludesSanctification
    conclusionLabel := "justification is not the renewal of the inward man"
    inferences := [galatianGospelReadingSource, verdictNotRenewalSource] }

/-! ### Paul's word, against justification as renewal -/

/-- **Paul's word.** δικαιόω is forensic, Paul names renewal with words of its
own, and a word contributes the least meaning its context requires: so Paul's
δικαιόω does not denote the renewal of the inward man. -/
@[solaFideDefs]
def lexicalCase : ArgumentPackage Claim :=
  lexicalLine.asPackage baseCite "Paul's δικαιόω does not denote the renewal of the inward man"

end Testimony.Arguments.SolaFide
