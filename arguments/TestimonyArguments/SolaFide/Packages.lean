import TestimonyArguments.SolaFide.Sources
import TestimonyArguments.SolaFide.Lines

/-!
# TestimonyArguments.SolaFide.Packages — the positions, written out

Besides the Reformed case, these positions are written out in this chapter:

- **the New Perspective** (Dunn, Wright), which reads "works of the law" as
  Israel's boundary markers;
- **Hays**, who reads "faith of Christ" as Christ's own faithfulness;
- **Jervell**, who reads Peter's yoke as Israel's law laid on gentiles;
- **the Finnish reading of Luther** (Mannermaa), for which justification is
  not a verdict and nothing more;
- **the critical view of authorship**, which denies that Paul wrote Ephesians
  and Titus, and that Peter wrote 1 and 2 Peter;
- **the apocalyptic reading** (Martyn, Campbell);
- and **Trent**.

Beside them are variants of the Reformed case. Each asks whether the case
depends on one premise: with it taken out, either the conclusion still follows,
or the checking names a way of taking the texts on which it does not.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Packages -/

/-- The classical Protestant position: all four strands, and every disputed
reading they rest on. In Paul, that "works of the law" (ἔργα νόμου) means works
in general, and that "faith of Christ" (πίστις Χριστοῦ) means faith in Christ.
In Luke, that "saved" (σῴζω) at 7:50 means saved and not healed. In Acts, that
the yoke is the law as a condition of salvation. In John, that believing is
trust. -/
@[solaFideDefs]
def reformed : ArgumentPackage Claim :=
  { name := "Reformed (sola fide)"
  , cite := reformedCite
  , premises :=
      caseOf [paulineLine, dominicalLine, apostolicLine, johannineLine] sharedGrounds
        closingSteps
  , conclusion := solaFide
  , conclusionLabel := "salvation by grace, not by works, through faith" }

/-- Luke's line without the reading of "saved". The reading of 7:47 stays: it is not
what is being tested. -/
@[solaFideDefs]
def dominicalWithoutSozo : Line Claim :=
  dominicalLine.onGrounds [p .luke7_47LoveIsEvidence]

/-- Paul's line without the reading of "works of the law". -/
@[solaFideDefs]
def paulineWithoutWorksOfLaw : Line Claim :=
  paulineLine.onGrounds
    [p .galatiansOpposesCircumcisionAsRequirement, p .pistisChristouObjective]

/-- Paul's line without the reading of "faith in Christ". -/
@[solaFideDefs]
def paulineWithoutPistisChristou : Line Claim :=
  paulineLine.onGrounds
    [p .galatiansOpposesCircumcisionAsRequirement, p .worksOfLawMeansWorksGenerally]

/-- The Johannine line without the reading of believing as trust. Its texts
stay: they are not what is being tested. -/
@[solaFideDefs]
def johannineWithoutTrust : Line Claim :=
  johannineLine.onGrounds [p .john6_29WorkIsBelieving, p .johnLifeThroughBelieving]

/-- The New Perspective on Paul. It denies the traditional reading of "works of the
law" (ἔργα νόμου) and accepts justification by faith, which is what Dunn and
Wright hold. It keeps "faith in Christ" as Dunn does, so the one reading of
Paul's that it denies is the first.

The denial is not assumed. `sandersLine` derives it from Sanders' account of
Judaism by Dunn's inference, which is where its critics engage it.

It takes no position on the yoke of Acts 15:10, or on what believing is in John
6:29. Each of those lines keeps its step and loses its disputed reading, so the
position neither grants nor denies the reading on the New Perspective's behalf. -/
@[solaFideDefs]
def newPerspective : ArgumentPackage Claim :=
  { reformed with
    name := "New Perspective on Paul"
    cite := newPerspectiveCite
    premises :=
      caseOf
        [ paulineWithoutWorksOfLaw, sandersLine, dominicalLine
        , apostolicLine.onGrounds [], johannineWithoutTrust ]
        sharedGrounds closingSteps }

/-- The Finnish reading of Luther (Mannermaa): the Reformed case, with the
verdict-only account of justification denied. Christ himself is present in faith
and is the believer's righteousness, so justification is not a declaration and
nothing more.

On what justification *is*, this stands with Trent against the Reformed account.
On sola fide it stands with the Reformed. The encoding shows both, and shows
that the two questions are separate. -/
@[solaFideDefs]
def finnish : ArgumentPackage Claim :=
  { reformed with
    name := "Finnish reading of Luther (Mannermaa)"
    cite := finnishCite
    premises := reformed.premises ++ [notP .justificationIsForensicOnly] }

/-- Hays's reading: "faith of Christ" (πίστις Χριστοῦ) in Galatians 2:16 is Christ's
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
        , dominicalLine, apostolicLine, johannineLine ]
        sharedGrounds closingSteps }

/-- Jervell's reading of Luke: the yoke Peter refuses at Acts 15:10 is Israel's law
laid on gentiles as a mark of belonging, and not the law as a condition of
salvation. Everything else in the Reformed case is granted. This is the rival
Peter's strand was written against. -/
@[solaFideDefs]
def lawObservantLuke : ArgumentPackage Claim :=
  { reformed with
    name := "Law-observant Luke (the yoke as Israel's law for gentiles)"
    cite := lawObservantLukeCite
    premises :=
      caseOf
        [ paulineLine, dominicalLine
        , apostolicLine.onGrounds [notP .acts15YokeIsLawAsCondition], johannineLine ]
        sharedGrounds closingSteps }

/-- The Reformed case with every critical conclusion about authorship granted:
Ephesians and Titus not by Paul, 1 and 2 Peter not by Peter.

Nothing else changes. The case reads these letters as Scripture, held together
by the premise that Scripture does not contradict itself, and not as the
testimony of a named apostle. So conceding their authorship costs the argument
nothing. It would cost an argument that cited Ephesians 2:9 as evidence of what
*Paul* meant by "works", which is why the reading of "works of the law" leans on
Romans. -/
@[solaFideDefs]
def criticalAuthorship : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, with the critical view of authorship"
    cite := criticalAuthorshipCite
    premises :=
      reformed.premises ++
        [ notP .ephesiansIsPauline, notP .titusIsPauline
        , notP .firstPeterIsPetrine, notP .secondPeterIsPetrine ] }

/-- The apocalyptic reading of Paul (Martyn, Campbell). It rejects the traditional
framing of justification and the New Perspective's as well. For it the question
is neither how an individual is accepted nor how Jew and gentile are related. It
is God's rescue of the world in Christ.

It shares Galatians with the Reformed reading: the text of 2:16 and the occasion
of the letter. It closes with the same step to salvation. It does not share
Luke's strand, Peter's or John's, which neither Martyn nor Campbell argues from.
To grant it Luke 7:50, Acts 15 or John 6:29 would be to encode a position nobody
holds. -/
@[solaFideDefs]
def apocalyptic : ArgumentPackage Claim :=
  { reformed with
    name := "Apocalyptic reading of Paul (Martyn, Campbell)"
    cite := apocalypticCite
    premises :=
      caseOf [apocalypticLine]
        [p .galatians2_16, p .galatiansOpposesCircumcisionAsRequirement]
        [deliveranceIsGrace, toThroughFaith] }

/-- The apocalyptic reading, asked only about the first two parts of the conclusion:
by grace, and not by works. -/
@[solaFideDefs]
def apocalypticOnGraceAndWorks : ArgumentPackage Claim :=
  { apocalyptic with
    name := "Apocalyptic reading, on grace and works only"
    conclusion := graceNotWorks
    conclusionLabel := "salvation by grace, not by works" }

/-- Trent's premises, given the line that carries its definition to merit. Four
verses it shares with the Reformed. That Scripture does not contradict itself.
What its definition rules out. And the step from merit to the denial of "not by
works" (ch. 16).

It is not built from the Reformed lines. It shares four verses with them and
nothing else, so building it from them would misdescribe it. -/
@[solaFideDefs]
def tridentinePremises (line : Line Claim) : List (Formula Claim) :=
  [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .titus3_5
  , p .scriptureSelfConsistent ] ++ line.premises ++ trentDefinitionSteps ++
  [p .worksMeritIncreaseOfJustification ➝ notP .salvationNotByWorks]

/-- The position of the Council of Trent (Session VI, 1547). Justification is the
renewal of the inward person. That renewal grows through good works. So works
done in grace merit an increase of justification, which denies the second part
of the conclusion, "not by works". The same definition denies that justification
is only a verdict. -/
@[solaFideDefs]
def tridentine : ArgumentPackage Claim :=
  { reformed with
    name := "Tridentine (Council of Trent, Session VI)"
    cite := tridentineCite
    premises := tridentinePremises tridentineLine }

/-! #### Variants

Each removes named premises from the Reformed case and keeps the rest. Paul's
strand rests on two disputed readings, so it has two reduced forms. -/

/-- The Reformed case without the reading of "works of the law". -/
@[solaFideDefs]
def reformedWithoutWorksOfLaw : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the ἔργα νόμου premise"
    premises :=
      caseOf [paulineWithoutWorksOfLaw, dominicalLine, apostolicLine, johannineLine]
        sharedGrounds closingSteps }

/-- The Reformed case without the reading of "saved" at Luke 7:50. -/
@[solaFideDefs]
def reformedWithoutSozo : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the dominical lexical premise"
    premises :=
      caseOf [paulineLine, dominicalWithoutSozo, apostolicLine, johannineLine]
        sharedGrounds closingSteps }

/-- The Reformed package resting on Acts alone. The disputed reading is removed
from each of the other three strands: ἔργα νόμου from Paul, σῴζω from Luke,
believing as trust from John. Peter's speech is untouched. -/
@[solaFideDefs]
def reformedRestingOnActs : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, with only the Acts strand left whole"
    premises :=
      caseOf
        [paulineWithoutWorksOfLaw, dominicalWithoutSozo, apostolicLine, johannineWithoutTrust]
        sharedGrounds closingSteps }

/-- The Reformed package resting on John alone. The disputed reading is removed
from each of the other three strands: ἔργα νόμου from Paul, σῴζω from Luke, the
yoke from Acts. John's strand is untouched. -/
@[solaFideDefs]
def reformedRestingOnJohn : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, with only the Johannine strand left whole"
    premises :=
      caseOf
        [ paulineWithoutWorksOfLaw, dominicalWithoutSozo, apostolicLine.onGrounds []
        , johannineLine ]
        sharedGrounds closingSteps }

/-- The Reformed package with a disputed reading removed from **every** strand:
ἔργα νόμου from Paul, σῴζω from Luke, the yoke from Acts, believing as trust
from John. The objective genitive stays. -/
@[solaFideDefs]
def reformedWithoutEveryStrandsPremise : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the ἔργα νόμου, σῴζω, yoke and trust premises"
    premises :=
      caseOf
        [ paulineWithoutWorksOfLaw, dominicalWithoutSozo, apostolicLine.onGrounds []
        , johannineWithoutTrust ]
        sharedGrounds closingSteps }

/-- The same with the objective genitive removed in place of ἔργα νόμου: the
Pauline strand loses its other disputed reading, and the other three strands
theirs. The name lists Luke's and Peter's; John's reading of believing as trust
is removed too. -/
@[solaFideDefs]
def reformedWithoutPistisChristouSozoOrYoke : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the πίστις Χριστοῦ, σῴζω, yoke and trust premises"
    premises :=
      caseOf
        [ paulineWithoutPistisChristou, dominicalWithoutSozo
        , apostolicLine.onGrounds [], johannineWithoutTrust ]
        sharedGrounds closingSteps }

/-- The Reformed case with **every** disputed reading removed: both of Paul's,
Luke's "saved", the yoke of Acts 15 and believing as trust in John. It is asked
only about grace and works. The reading of Galatians as a letter against
requiring circumcision stays, and so does the answer to James. -/
@[solaFideDefs]
def graceAndWorksWithoutAnyLexicalPremise : ArgumentPackage Claim :=
  { reformed with
    name := "Grace and works, minus every lexical premise"
    premises :=
      caseOf
        [ paulineLine.onGrounds [p .galatiansOpposesCircumcisionAsRequirement]
        , dominicalWithoutSozo, apostolicLine.onGrounds [], johannineWithoutTrust ]
        sharedGrounds closingSteps
    conclusion := graceNotWorks
    conclusionLabel := "salvation by grace, not by works" }

/-- Paul's strand alone, on the critics' account of Judaism (Gathercole; Carson,
O'Brien and Seifrid). The reading of "works of the law" is derived from their
denial of Sanders' account, not assumed, and the other three strands are left
out. The question: on that history, does Paul alone reach sola fide? -/
@[solaFideDefs]
def paulineStrandOnTheCritics : ArgumentPackage Claim :=
  { reformed with
    name := "Pauline strand alone, on variegated nomism"
    cite := criticsCite
    premises :=
      caseOf [paulineWithoutWorksOfLaw, criticsLine] sharedGrounds closingSteps }

/-- The same on Sanders' account of Judaism. -/
@[solaFideDefs]
def paulineStrandOnSanders : ArgumentPackage Claim :=
  { reformed with
    name := "Pauline strand alone, on covenantal nomism"
    cite := newPerspectiveCite
    premises :=
      caseOf [paulineWithoutWorksOfLaw, sandersLine] sharedGrounds closingSteps }

/-- The Reformed case without the premises that answer James. -/
@[solaFideDefs]
def reformedWithoutJamesHarmonisation : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the James harmonisation"
    premises :=
      caseOf [paulineLine, dominicalLine, apostolicLine, johannineLine]
        sharedGroundsWithoutJames conclusionSteps }

/-- The same, asked only about the first part of the conclusion: is salvation by
grace, with James 2:24 left unanswered? -/
@[solaFideDefs]
def graceWithoutJamesHarmonisation : ArgumentPackage Claim :=
  { reformedWithoutJamesHarmonisation with
    name := "Grace alone, minus the James harmonisation"
    conclusion := p .salvationByGrace
    conclusionLabel := "salvation by grace" }

/-- Trent, as the argument it makes when set against the others. Justification is
the renewal of the inward person; that renewal grows through good works; so
works done in grace merit an increase of justification, and salvation is not
apart from works. The premises are those of `tridentine`. The conclusion is what
Trent holds against sola fide. -/
@[solaFideDefs]
def tridentineCase : ArgumentPackage Claim :=
  { tridentine with
    name := "Trent, against 'not by works'"
    conclusion := notP .salvationNotByWorks
    conclusionLabel := "salvation is not apart from works"
    inferences := [trentOnMerit, trentOnIncrease] }

/-! ### Paul's gospel, against Trent's definition -/

/-- **Paul's gospel, against justification as renewal.** Galatians and 1 Corinthians
read as one claim, that Christ's work is the whole ground. With the courtroom
sense of "justify" and Romans 8:33–34, it concludes that justification is not
the renewal of the inward person. That is the direct denial of Trent's
definition (Session VI, ch. 7). -/
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

/-- **Romans 4, on what Paul's word means.** Paul explains the righteousness God
counts to the ungodly as sin not counted. By the rule of least meaning, the verb
he explains in that way does not also mean the renewal of the inward person.
This reaches from one passage what the argument from the word reaches from
usage. -/
@[solaFideDefs]
def romansFourOnTheWord : ArgumentPackage Claim :=
  { name := "Romans 4:3–8, on Paul's word (by the rule of least meaning)"
  , cite := baseCite
  , premises := caseOf [romansFourExegesisLine] [p .leastMeaning] [glossByLeastMeaning]
  , conclusion := notP .paulsJustifyDenotesRenewal
  , conclusionLabel := "Paul's δικαιόω does not denote the renewal of the inward man"
  , inferences := [romansFourExegesisSource, leastMeaningSource] }

/-- **Romans 4, against justification as renewal.** Paul explains the righteousness
God counts to the ungodly as sin not counted. With the courtroom sense of the
verb, justification is not the renewal of the inward person. -/
@[solaFideDefs]
def romansFourCase : ArgumentPackage Claim :=
  { name := "Romans 4:3–8, against justification as renewal"
  , cite := baseCite
  , premises := caseOf [romansFourExegesisLine] [p .dikaioIsForensic] [countedExcludesRenewal]
  , conclusion := notP .justificationIncludesSanctification
  , conclusionLabel := "justification is not the renewal of the inward man"
  , inferences := [romansFourExegesisSource, romansFourReadingSource] }

/-! ### Paul's word, against justification as renewal -/

/-- **Paul's word.** "Justify" (δικαιόω) is a courtroom word. Paul names renewal
with words of its own. And a word contributes the least meaning its context
requires. So Paul's "justify" does not mean the renewal of the inward person. -/
@[solaFideDefs]
def lexicalCase : ArgumentPackage Claim :=
  lexicalLine.asPackage baseCite "Paul's δικαιόω does not denote the renewal of the inward man"

end TestimonyArguments.SolaFide
