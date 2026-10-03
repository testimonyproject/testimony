import Testimony.Arguments.SpiritBaptism.Sources
import Testimony.Logic.Dilemma
import Testimony.Logic.Tactic

/-!
# Arguments.SpiritBaptism.Positions — the four views, and what Acts can carry

Four views, each from a source that holds it — at conversion, Pentecostal,
holiness, sacramental — and two arguments about the Acts narratives: that Acts
gives the Spirit in more than one order, and that its episodes are transitions,
as Stott reads them. Each is a line of reason: its own grounds, one step, what
it delivers — and, where it answers a rival, the step it answers with.
-/

namespace Testimony.Arguments.SpiritBaptism

open Testimony Testimony.Bib Testimony.Logic

attribute [spiritBaptismDefs] ArgumentPackage.readAs

/-! ### The conversion view -/

/-- From 1 Corinthians 12:13, read as Christ baptizing in the Spirit, to Spirit
baptism at conversion. Rated `disputed`, conservatively: the Assemblies of God
deny its conclusion by denying a ground, the conversion reading. -/
@[spiritBaptismDefs]
def corinthiansToConversion : Formula Claim :=
  ⋀ [p .cor12_13AllBaptizedInOneSpirit, p .cor12_13IsChristBaptizingInTheSpirit]
  ➝ p .spiritBaptismAtConversion

/-- If every believer is baptized in the Spirit at conversion, there is no second
Spirit baptism to seek. Rated `disputed`: Menzies grants that Paul's baptism in
the Spirit comes at conversion and holds that Luke's is a second gift, to be
sought. Whether he denies this step or uses the word in two senses is not yet
encoded. -/
@[spiritBaptismDefs]
def conversionExcludesASecond : Formula Claim :=
  p .spiritBaptismAtConversion ➝ notP .secondSpiritBaptismToBeSought

/-- **The conversion view**, as Dunn and Stott hold it: every believer is baptized
in the Spirit at conversion, so there is no second Spirit baptism to seek. -/
@[spiritBaptismDefs]
def conversionCase : ArgumentPackage Claim :=
  { name := "At conversion (Dunn, Stott)"
  , cite := cite
  , premises :=
      [ p .cor12_13AllBaptizedInOneSpirit, p .cor12_13IsChristBaptizingInTheSpirit
      , corinthiansToConversion, conversionExcludesASecond ]
  , conclusion := p .spiritBaptismAtConversion
  , conclusionLabel := "every believer is baptized in the Spirit at conversion"
  , inferences := [onTheConversionStep, menziesAgainstNoSecond] }

/-! ### The Pentecostal view -/

/-- The Pentecostal reading of 1 Corinthians 12:13 excludes the conversion
reading: if the Spirit is the instrument baptizing into the body, the verse is
not Christ baptizing in the Spirit. Rated `disputed`, conservatively: Dunn and
Stott deny its conclusion by denying a ground, the instrumental reading. -/
@[spiritBaptismDefs]
def instrumentalReadingExcludesConversion : Formula Claim :=
  ⋀ [p .cor12_13AllBaptizedInOneSpirit, p .cor12_13IsBaptismByTheSpirit]
  ➝ notP .cor12_13IsChristBaptizingInTheSpirit

/-- From the Acts narratives, read as a pattern of empowerment, to a second Spirit
baptism to be sought. Rated `wellSupported`: its rejecters deny a ground, not
the step. -/
@[spiritBaptismDefs]
def actsToSecond : Formula Claim :=
  ⋀ [ p .actsSpiritAfterBelieving, p .lukanSpiritBaptismIsEmpowerment
    , p .actsNarrativesAreNormative ] ➝ p .secondSpiritBaptismToBeSought

/-- **The Pentecostal view**, as the Assemblies of God hold it: at conversion the
Spirit baptizes into the body of Christ (1 Corinthians 12:13); in a subsequent
and distinct experience Christ baptizes in the Spirit, as in Samaria and at
Ephesus, for empowerment. -/
@[spiritBaptismDefs]
def pentecostalCase : ArgumentPackage Claim :=
  { name := "After conversion (Assemblies of God; Menzies, Stronstad)"
  , cite := cite
  , premises :=
      [ p .cor12_13AllBaptizedInOneSpirit, p .cor12_13IsBaptismByTheSpirit
      , p .actsSpiritAfterBelieving, p .lukanSpiritBaptismIsEmpowerment
      , p .actsNarrativesAreNormative
      , instrumentalReadingExcludesConversion, actsToSecond ]
  , conclusion := p .secondSpiritBaptismToBeSought
  , conclusionLabel := "a baptism in the Spirit after conversion is to be sought"
  , inferences := [onTheInstrumentalStep, actsToSubsequence] }

/-- The holiness step: the second work of grace is the baptism with the Spirit,
to be sought after conversion. Rated `disputed`: Wesley grants the second work
and denies that it is "receiving the Holy Ghost". -/
@[spiritBaptismDefs]
def secondWorkIsTheBaptism : Formula Claim :=
  p .entireSanctificationIsSecondWork ➝ p .secondSpiritBaptismToBeSought

/-- **The holiness view**, as the Church of the Nazarene confesses it: entire
sanctification is a second work of grace, and it "is wrought by the baptism with
or infilling of the Holy Spirit" (*Manual* 2023, Article X). Contested from
within its own tradition, by Wesley and by the Nazarene seminary faculty. -/
@[spiritBaptismDefs]
def holinessCase : ArgumentPackage Claim :=
  { name := "A second work of grace (the holiness tradition)"
  , cite := cite
  , premises := [p .entireSanctificationIsSecondWork, secondWorkIsTheBaptism]
  , conclusion := p .secondSpiritBaptismToBeSought
  , conclusionLabel := "a baptism in the Spirit after conversion is to be sought"
  , inferences := [wesleyAgainstTheHolinessName] }

/-! ### The sacramental view -/

/-- From Acts 2:38, with the Spirit given in water baptism and fully in
confirmation, to the Spirit given in the sacraments, not in an experience to be
sought. Rated `disputed`, conservatively: Westminster, which holds that the grace
of baptism is not tied to the moment of the rite, denies a ground, not the
step. -/
@[spiritBaptismDefs]
def actsTwoToTheSacraments : Formula Claim :=
  ⋀ [ p .acts2_38SpiritPromised, p .spiritGivenInWaterBaptism
    , p .confirmationGivesPentecost ] ➝ p .spiritGivenInTheSacraments

/-- If the Spirit is given in the sacraments, there is no second Spirit baptism to
seek beyond them. Rated `disputed`, conservatively: the Catholic charismatic
renewal is its natural contester, not yet cited. -/
@[spiritBaptismDefs]
def sacramentsExcludeASeeking : Formula Claim :=
  p .spiritGivenInTheSacraments ➝ notP .secondSpiritBaptismToBeSought

/-- **The sacramental view**, as Rome holds it: the Spirit is given in water
baptism — "new birth in the Holy Spirit" — and fully in confirmation, "as once
granted to the apostles on the day of Pentecost". A later gift, then, but a
sacramental one, not a second baptism beyond the sacraments. Lutherans hold the
first half, and have no sacrament of confirmation, so the view as encoded is
Rome's. -/
@[spiritBaptismDefs]
def sacramentalCase : ArgumentPackage Claim :=
  { name := "In baptism and confirmation (Catholic)"
  , cite := cite
  , premises :=
      [ p .acts2_38SpiritPromised, p .spiritGivenInWaterBaptism
      , p .confirmationGivesPentecost, actsTwoToTheSacraments, sacramentsExcludeASeeking ]
  , conclusion := p .spiritGivenInTheSacraments
  , conclusionLabel := "the Spirit is given in the sacraments"
  , inferences := [onTheRite, onTheSacramentalExclusion] }

/-! ### What Acts can carry: two readings of the narratives -/

/-- Acts gives no one order: the Spirit falls as Cornelius's household hears
(10:44), is promised with baptism (2:38), and comes later with the laying on of
hands (8:17; 19:6). So no episode is the pattern. Rated `disputed`: the
Assemblies of God grant Acts 10 and read it as evidence for subsequence. -/
@[spiritBaptismDefs]
def varietyExcludesAPattern : Formula Claim :=
  ⋀ [p .acts10SpiritAsTheyHear, p .acts2_38SpiritPromised]
  ➝ notP .actsNarrativesAreNormative

/-- **The variety of Acts**, as an argument: Acts gives the Spirit in more than
one order, so no one episode is a pattern for believers today. -/
@[spiritBaptismDefs]
def varietyCase : ArgumentPackage Claim :=
  { name := "Acts gives the Spirit in more than one order"
  , cite := cite
  , premises :=
      [p .acts10SpiritAsTheyHear, p .acts2_38SpiritPromised, varietyExcludesAPattern]
  , conclusion := notP .actsNarrativesAreNormative
  , conclusionLabel := "no one episode of Acts is the pattern"
  , inferences := [agAgainstTheVariety] }

/-- If the Samaritan and Ephesian episodes are unrepeatable transitions, they set
no norm: no second Spirit baptism is to be sought on their strength. Stott's
step, rated `disputed` conservatively. -/
@[spiritBaptismDefs]
def transitionsSetNoNorm : Formula Claim :=
  ⋀ [p .actsSpiritAfterBelieving, p .actsEpisodesAreTransitions]
  ➝ notP .secondSpiritBaptismToBeSought

/-- **Acts read as transitions**, as Stott reads it: the later reception of the
Spirit in Samaria and at Ephesus marks steps in the gospel's spread, and sets
no norm. -/
@[spiritBaptismDefs]
def transitionCase : ArgumentPackage Claim :=
  { name := "Acts 8 and 19 as transitions (Stott)"
  , cite := cite
  , premises :=
      [p .actsSpiritAfterBelieving, p .actsEpisodesAreTransitions, transitionsSetNoNorm]
  , conclusion := notP .secondSpiritBaptismToBeSought
  , conclusionLabel := "no second Spirit baptism is to be sought on Acts' strength"
  , inferences := [stottOnTheTransitions] }

/-- Reading the narratives as a pattern: the Assemblies of God and Stronstad. -/
def narrativesReadAsPattern : Source :=
  { primary := .work stronstadCharismaticTheology .whole
  , supporting := [.work agBaptismPositionPaper .whole]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- Reading the narratives as transitions: Stott. -/
def narrativesReadAsTransitions : Source :=
  { primary := .work stottBaptismAndFullness .whole
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- The Acts narratives, **read as a pattern for believers today**. -/
@[spiritBaptismDefs]
def asAPattern : Reading Claim :=
  { name := "as a pattern for believers today"
  , commits := p .actsNarrativesAreNormative
  , source := narrativesReadAsPattern }

/-- The Acts narratives, **read as unrepeatable transitions**. -/
@[spiritBaptismDefs]
def asTransitions : Reading Claim :=
  { name := "as unrepeatable transitions"
  , commits := p .actsEpisodesAreTransitions
  , source := narrativesReadAsTransitions }

/-- The Pentecostal view, with the Acts narratives read as a pattern. -/
@[spiritBaptismDefs]
def pentecostalOnAPattern : ArgumentPackage Claim :=
  pentecostalCase.readAs (p .actsSpiritAfterBelieving) asAPattern

/-- The Pentecostal view, with the Acts narratives read as transitions. The
reading is added to the view, not swapped in: the view keeps its premise that
the narratives are a pattern. -/
@[spiritBaptismDefs]
def pentecostalOnTransitions : ArgumentPackage Claim :=
  pentecostalCase.readAs (p .actsSpiritAfterBelieving) asTransitions

/-! ### Readings, written down -/

/-- The conversion view's world: every believer baptized in the Spirit at
conversion, 1 Corinthians 12:13 read as Christ baptizing in the Spirit, the
episodes of Acts as transitions, no pattern, and no second baptism to seek. -/
def conversionReading : Valuation Claim := fun a =>
  match a with
  | .cor12_13IsBaptismByTheSpirit => False
  | .actsNarrativesAreNormative => False
  | .secondSpiritBaptismToBeSought => False
  | .entireSanctificationIsSecondWork => False
  | _ => True

/-- The Pentecostal view's world: 1 Corinthians 12:13 as baptism by the Spirit
into the body, Luke's Spirit baptism as empowerment, the narratives a pattern,
and a second baptism to seek. -/
def pentecostalReading : Valuation Claim := fun a =>
  match a with
  | .cor12_13IsChristBaptizingInTheSpirit => False
  | .spiritBaptismAtConversion => False
  | .actsEpisodesAreTransitions => False
  | .spiritGivenInTheSacraments => False
  | _ => True

/-! ### Each position holds -/

/-- **Grant 1 Corinthians 12:13 read as Dunn and Stott read it, and every believer
is baptized in the Spirit at conversion.** -/
@[headline]
theorem conversionCase_establishes : Establishes conversionCase := by
  establish [spiritBaptismDefs]

#print axioms conversionCase_establishes

/-- The conversion view can be held without contradiction. -/
theorem conversionCase_is_satisfiable : Satisfiable conversionCase.premises := by
  satisfied_by conversionReading [spiritBaptismDefs]

/-- **Grant the Acts narratives as a pattern of empowerment, and a second Spirit
baptism is to be sought.** -/
@[headline]
theorem pentecostalCase_establishes : Establishes pentecostalCase := by
  establish [spiritBaptismDefs]

#print axioms pentecostalCase_establishes

/-- The Pentecostal view can be held without contradiction. -/
theorem pentecostalCase_is_satisfiable : Satisfiable pentecostalCase.premises := by
  satisfied_by pentecostalReading [spiritBaptismDefs]

/-- **Grant that the second work of grace is the Spirit's baptism, and it is to be
sought.** -/
@[headline]
theorem holinessCase_establishes : Establishes holinessCase := by
  establish [spiritBaptismDefs]

#print axioms holinessCase_establishes

/-- The holiness view can be held without contradiction. -/
theorem holinessCase_is_satisfiable : Satisfiable holinessCase.premises := by
  satisfied_by pentecostalReading [spiritBaptismDefs]

/-- **Grant the Spirit given in water baptism and fully in confirmation, and the
Spirit is given in the sacraments, not in an experience to be sought.** -/
@[headline]
theorem sacramentalCase_establishes : Establishes sacramentalCase := by
  establish [spiritBaptismDefs]

#print axioms sacramentalCase_establishes

/-- The sacramental view can be held without contradiction: the conversion view's
world holds it too. -/
theorem sacramentalCase_is_satisfiable : Satisfiable sacramentalCase.premises := by
  satisfied_by conversionReading [spiritBaptismDefs]

/-- The variety of Acts delivers its conclusion. -/
theorem varietyCase_establishes : Establishes varietyCase := by
  establish [spiritBaptismDefs]

/-- The variety of Acts can be held without contradiction. -/
theorem varietyCase_is_satisfiable : Satisfiable varietyCase.premises := by
  satisfied_by conversionReading [spiritBaptismDefs]

/-- Acts read as transitions delivers its conclusion. -/
theorem transitionCase_establishes : Establishes transitionCase := by
  establish [spiritBaptismDefs]

/-- Acts read as transitions can be held without contradiction. -/
theorem transitionCase_is_satisfiable : Satisfiable transitionCase.premises := by
  satisfied_by conversionReading [spiritBaptismDefs]

/-! ### What Acts can carry -/

/-- The world in which the Pentecostal view reads the narratives as transitions
and keeps everything else: coherent by itself, since nothing in its own premises
says what follows from their being transitions. -/
def pentecostalWithTransitionsReading : Valuation Claim := fun a =>
  match a with
  | .cor12_13IsChristBaptizingInTheSpirit => False
  | .spiritBaptismAtConversion => False
  | .spiritGivenInTheSacraments => False
  | _ => True

/-- **The first reading is coherent**: the Pentecostal view with the narratives as a
pattern contradicts nothing by itself. -/
theorem pentecostalOnAPattern_is_satisfiable :
    Satisfiable pentecostalOnAPattern.premises := by
  satisfied_by pentecostalReading [spiritBaptismDefs]

/-- **The second reading is coherent**: the Pentecostal view with the narratives as
transitions contradicts nothing by itself. Coherent only because the encoding
does not make "pattern" and "transitions" exclude each other; the break comes
from Stott's step, not from that clash. -/
theorem pentecostalOnTransitions_is_satisfiable :
    Satisfiable pentecostalOnTransitions.premises := by
  satisfied_by pentecostalWithTransitionsReading [spiritBaptismDefs]

/-- **Why the variety of Acts stands against reading it as a pattern.** The crux is
the step from Acts 10 and 2:38: the Spirit comes as they hear, is promised with
baptism, and comes later with hands laid on, so no one episode is the pattern.
What it breaks is the Pentecostal view's premise that the narratives are a
pattern. The step is disputed: the Assemblies of God grant Acts 10 and read it
as evidence for subsequence. -/
def whereTheVarietyMeetsThePattern : Because varietyCase pentecostalOnAPattern :=
  Because.ofChecks varietyExcludesAPattern
    [p .acts10SpiritAsTheyHear, p .acts2_38SpiritPromised] []
    [p .acts10SpiritAsTheyHear, p .acts2_38SpiritPromised]
    [p .actsNarrativesAreNormative]
    .derives varietyCase_establishes varietyCase_is_satisfiable
    (by simp [varietyCase])
    (by simp [varietyCase])
    (by simp [spiritBaptismDefs])
    (by decide +kernel)

/-- **Why Acts read as transitions cannot carry the Pentecostal view's step.** The
crux is Stott's step: if the episodes are unrepeatable, they set no norm, and no
second Spirit baptism is to be sought on their strength. What it breaks is the
Pentecostal view's own step from Acts, together with the grounds that step
needs and the transitions reading. Read so, the narratives cannot be both the
Pentecostal view's evidence and no norm. -/
def whereTransitionsMeetTheStep : Because transitionCase pentecostalOnTransitions :=
  Because.ofChecks transitionsSetNoNorm
    [p .actsSpiritAfterBelieving, p .actsEpisodesAreTransitions] []
    [p .actsSpiritAfterBelieving]
    [ p .lukanSpiritBaptismIsEmpowerment, p .actsNarrativesAreNormative, actsToSecond
    , p .actsSpiritAfterBelieving ➝ p .actsEpisodesAreTransitions ]
    .derives transitionCase_establishes transitionCase_is_satisfiable
    (by simp [transitionCase])
    (by simp [transitionCase])
    (by simp [spiritBaptismDefs])
    (by decide +kernel)

/-- **What the Acts narratives are, read both ways.** The claim is the Pentecostal
view's: in Samaria and at Ephesus, believers already baptized received the
Spirit afterwards.

Read as a pattern for believers today, it cannot be held with the variety of
Acts itself — the Spirit given as Cornelius's household hears, and promised
with baptism at Pentecost — at a step the Assemblies of God contest.

Read as unrepeatable transitions, as Stott reads it, the narratives cannot also
carry the Pentecostal view's step from them: at Stott's step, rated disputed.

So the Pentecostal view must read Acts as a pattern, and then meets the variety
of Acts. Which reading is right, the dilemma does not decide. Each reading is
coherent: taken by itself it contradicts nothing — which says nothing about
whether it is the right reading of Luke.

What the dilemma does not check is the other side's cost. Stott, reading the
episodes as transitions, owes an account of why Luke's narratives set no order
for later believers; that is stated here, not checked. Dunn avoids the dilemma
by another road: he denies that the Samaritans were yet believers before they
received the Spirit, a ground of the claim itself. And Rome reads Acts 8:17 and
19:6 as confirmation (Catechism 1288), which is neither horn. -/
def whatTheActsNarrativesAre : Dilemma pentecostalCase where
  claim := p .actsSpiritAfterBelieving
  horns :=
    [ { reading := asAPattern
      , fair := pentecostalOnAPattern_is_satisfiable
      , fates := [.falls varietyCase whereTheVarietyMeetsThePattern]
      , answered := by simp }
    , { reading := asTransitions
      , fair := pentecostalOnTransitions_is_satisfiable
      , fates := [.falls transitionCase whereTransitionsMeetTheStep]
      , answered := by simp } ]
  claim_mem := by simp [pentecostalCase]
  two := by simp

end Testimony.Arguments.SpiritBaptism
