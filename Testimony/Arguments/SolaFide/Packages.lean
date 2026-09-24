import Testimony.Arguments.SolaFide.Sources
import Testimony.Arguments.SolaFide.Lines

/-!
# Arguments.SolaFide.Packages — the positions, and the variants

Seven positions — Reformed, New Perspective, subjective genitive, law-observant
Luke, critical authorship, apocalyptic, Tridentine — and reduced Reformed
packages, each missing a named premise.
Whether a premise is load-bearing is shown by removing it and then either
establishing the conclusion anyway or naming a countermodel.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Packages -/

/-- The classical Protestant position: all three strands, and every disputed
premise they rest on — ἔργα νόμου and πίστις Χριστοῦ in Paul, σῴζω in Luke, the
yoke in Acts. -/
def reformed : ArgumentPackage Claim :=
  { name := "Reformed (sola fide)"
  , cite := reformedCite
  , premises :=
      caseOf [paulineLine, dominicalLine, apostolicLine] sharedGrounds closingSteps
  , conclusion := p .salvationByGraceThroughFaithNotWorks
  , conclusionLabel := "salvation by grace through faith, not works" }

/-- The New Perspective on Paul: it denies the traditional reading of ἔργα
νόμου while accepting justification by faith, which is what Dunn and Wright
actually hold. It keeps the objective genitive, as Dunn does, so the one
Pauline ground it denies is the ἔργα νόμου premise.

It takes no position on the yoke of Acts 15:10: the apostolic line keeps its
step and loses its ground, so the package neither grants nor denies the premise
on the New Perspective's behalf. -/
def newPerspective : ArgumentPackage Claim :=
  { reformed with
    name := "New Perspective on Paul"
    cite := newPerspectiveCite
    premises :=
      caseOf
        [ paulineLine.onGrounds
            [ p .galatiansOpposesCircumcisionAsRequirement
            , notP .worksOfLawMeansWorksGenerally, p .pistisChristouObjective ]
        , dominicalLine, apostolicLine.onGrounds [] ]
        sharedGrounds closingSteps }

/-- The subjective genitive (Hays): πίστις Χριστοῦ in Galatians 2:16 is Christ's
own faithfulness, so the verse does not name the believer's faith as the means
of justification. Everything else in the Reformed case is granted. -/
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
def apocalyptic : ArgumentPackage Claim :=
  { reformed with
    name := "Apocalyptic reading of Paul (Martyn, Campbell)"
    cite := apocalypticCite
    premises :=
      caseOf [apocalypticLine]
        [p .galatians2_16, p .galatiansOpposesCircumcisionAsRequirement] [toSalvation] }

/-- The Tridentine position: works performed in grace merit an increase of
justification, which is incompatible with the conclusion as stated.

Not built from the lines above, and that is the point: it shares four
prooftexts with them and nothing else, so `caseOf` would misdescribe it. -/
def tridentine : ArgumentPackage Claim :=
  { reformed with
    name := "Tridentine (Council of Trent, Session VI)"
    cite := baseCite
    premises :=
      [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .titus3_5
      , p .scriptureSelfConsistent, p .worksMeritIncreaseOfJustification
      , p .worksMeritIncreaseOfJustification ➝ notP .salvationByGraceThroughFaithNotWorks ] }

/-! ### Variants

Each removes named premises from `reformed` and keeps the rest. The Pauline
strand has two lexical premises, so it has two reduced forms. -/

/-- The Pauline line without the ἔργα νόμου premise. -/
def paulineWithoutWorksOfLaw : Line Claim :=
  paulineLine.onGrounds
    [p .galatiansOpposesCircumcisionAsRequirement, p .pistisChristouObjective]

/-- The Pauline line without the objective genitive. -/
def paulineWithoutPistisChristou : Line Claim :=
  paulineLine.onGrounds
    [p .galatiansOpposesCircumcisionAsRequirement, p .worksOfLawMeansWorksGenerally]

/-- The Reformed package without the ἔργα νόμου premise. -/
def reformedWithoutWorksOfLaw : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the ἔργα νόμου premise"
    premises :=
      caseOf [paulineWithoutWorksOfLaw, dominicalLine, apostolicLine]
        sharedGrounds closingSteps }

/-- The Reformed package without the dominical lexical premise. -/
def reformedWithoutSozo : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the dominical lexical premise"
    premises :=
      caseOf [paulineLine, dominicalLine.onGrounds [], apostolicLine]
        sharedGrounds closingSteps }

/-- The Reformed package with the ἔργα νόμου premise **and** the dominical
premise removed: the two disputes the argument was first built to survive. The
apostolic strand is untouched. -/
def reformedWithoutWorksOfLawOrSozo : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the ἔργα νόμου and σῴζω premises"
    premises :=
      caseOf [paulineWithoutWorksOfLaw, dominicalLine.onGrounds [], apostolicLine]
        sharedGrounds closingSteps }

/-- The Reformed package with a disputed premise removed from **every** strand:
ἔργα νόμου from Paul, σῴζω from Luke, the yoke from Acts. The objective
genitive stays. -/
def reformedWithoutEveryStrandsPremise : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the ἔργα νόμου, σῴζω and yoke premises"
    premises :=
      caseOf
        [paulineWithoutWorksOfLaw, dominicalLine.onGrounds [], apostolicLine.onGrounds []]
        sharedGrounds closingSteps }

/-- The same with the objective genitive removed in place of ἔργα νόμου: the
Pauline strand loses its other lexical premise, and the other two strands
theirs. -/
def reformedWithoutPistisChristouSozoOrYoke : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the πίστις Χριστοῦ, σῴζω and yoke premises"
    premises :=
      caseOf
        [ paulineWithoutPistisChristou, dominicalLine.onGrounds []
        , apostolicLine.onGrounds [] ]
        sharedGrounds closingSteps }

/-- The Reformed package without the premises that harmonise James. -/
def reformedWithoutJamesHarmonisation : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the James harmonisation"
    premises :=
      caseOf [paulineLine, dominicalLine, apostolicLine] sharedGroundsWithoutJames
        [toSalvation] }

end Testimony.Arguments.SolaFide
