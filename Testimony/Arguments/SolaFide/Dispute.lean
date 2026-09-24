import Testimony.Arguments.SolaFide.Results
import Testimony.Logic.Dispute

/-!
# Arguments.SolaFide.Dispute — who prevails over sola fide

The results in `Results.lean` ask what each package entails. This module asks
what happens when the positions meet: the three Reformed strands, each argued
alone; Trent; the apocalyptic reading of Martyn and Campbell; Sanders and Dunn on
covenantal nomism, and the critics who answer them; and Jervell on the yoke of
Acts 15. Who defeats whom is not stipulated — each defeat, and each absence of
one, is a theorem about the positions' premises (see `Testimony.Logic.Dispute`).

## The ratings decide nothing here

Every party's weakest link is `disputed`: each Reformed strand rests on a
contested reading, Trent and the apocalyptic reading each deny an atom (and a
denial ranks at the bottom), and so on. So no rating blocks any attack, and the
outcome is fixed entirely by who contradicts whom. That is unlike the dispute
over Isaiah 7:14, where one inference rated `plausible` carried the verdict.

## Who defeats whom

- **Trent and each Reformed strand defeat each other.** Trent denies "not by
  works"; each strand concludes it.
- **The apocalyptic reading and Paul defeat each other**: it denies the objective
  genitive, and Paul concludes faith alone. **Luke and Acts defeat it**, and it
  defeats neither — it contradicts nothing they rest on.
- **The apocalyptic reading defeats Trent, and Trent does not defeat it.** They
  agree that justification is not by faith alone; but the apocalyptic reading
  holds "not by works" — God's deliverance is conditioned on nothing a person
  does — and nothing Trent holds contradicts its grounds.
- **Sanders defeats Paul**, by denying the ἔργα νόμου premise; Paul and the
  critics each defeat Sanders back.
- **Jervell and Acts defeat each other**, over the yoke.

## What follows

**Nothing prevails outright** (`nothing_prevails_over_sola_fide`): every party
is defeated by someone, and the grounded extension is empty.

**But sola fide from Luke 7:50 is accepted on every resolution**
(`dominical_case_skeptically_accepted`). Trent cannot be defended — the
apocalyptic reading defeats it, and whatever answers the apocalyptic reading
also defeats Trent (`trent_indefensible`). Nor can the apocalyptic reading —
the dominical case defeats it, and only Trent could answer the dominical case
(`apocalyptic_indefensible`). So every maximal defensible position holds the
dominical case.

## What the verdict rests on

Three things, each stated as a result or a limitation rather than left implicit.

**The two rivals answering each other.** Remove the apocalyptic reading and
Trent defends itself against the three strands; sola fide is then accepted on
some resolutions and not others
(`sola_fide_not_forced_without_the_apocalyptic_reading`). The verdict is not
that sola fide answers Trent. It is that Trent cannot answer a rival that
agrees with it about faith and disagrees with it about works.

**An absence.** The dominical case is attacked by no one but Trent, because no
source cited here argues that σῴζω at Luke 7:50 means healing. The premise is
rated `disputed`, as it should be — the same formula means "made you well" at
Luke 8:48, 17:19 and 18:42 — but a rating is not a party. A cited argument for
the healing reading would attack the dominical case, and could change the
verdict. Finding one is the obvious next step.

**The parties chosen.** A dispute is over the arguments put into it. Hays's
subjective genitive is represented through the apocalyptic reading, which holds
it; a Hays party of its own, the *Joint Declaration*, and a party for the
Finnish reading would each be new arguments to weigh.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Logic Testimony.Logic.Framework

/-! ### The positions

Each party is an argument in its own right: premises that can hold together, a
conclusion they deliver, and an inference someone has rated. The Reformed case
enters as three parties, one per strand, because a dispute weighs arguments
whole: one package holding all three strands would be defeated by a
contradiction of any one of them, and the redundancy the results prove would
count for nothing. -/

/-- The Pauline strand, argued alone: sola fide from Galatians 2:16. -/
def paulineCase : ArgumentPackage Claim :=
  { reformed with
    name := "Sola fide from Paul (Galatians 2:16)"
    premises := caseOf [paulineLine] sharedGrounds closingSteps
    inferences := [trentAgainstFaithAlone] }

/-- The dominical strand, argued alone: sola fide from Luke 7:50. -/
def dominicalCase : ArgumentPackage Claim :=
  { reformed with
    name := "Sola fide from Jesus' words (Luke 7:50)"
    premises := caseOf [dominicalLine] sharedGrounds closingSteps
    inferences := [trentAgainstFaithAlone] }

/-- The apostolic strand, argued alone: sola fide from Peter at Jerusalem. -/
def apostolicCase : ArgumentPackage Claim :=
  { reformed with
    name := "Sola fide from Peter (Acts 15:9–11)"
    premises := caseOf [apostolicLine] sharedGrounds closingSteps
    inferences := [trentAgainstFaithAlone] }

/-- Trent, as the argument it makes: works done in grace merit an increase of
justification, so salvation is not apart from works. -/
def tridentineCase : ArgumentPackage Claim :=
  { tridentine with
    name := "Trent, against 'not by works'"
    conclusion := notP .salvationNotByWorks
    conclusionLabel := "salvation is not apart from works"
    inferences := [trentOnMerit] }

/-- The apocalyptic reading, as the argument it makes: faith is not the
condition of justification. It keeps grace and "not by works", by its own
step. -/
def apocalypticCase : ArgumentPackage Claim :=
  { apocalyptic with
    name := "Apocalyptic reading, against faith as the condition"
    conclusion := notP .justificationByFaithAlone
    conclusionLabel := "justification is not by faith alone"
    inferences := [campbellOnDeliverance] }

/-- Sanders and Dunn: covenantal nomism, so ἔργα νόμου are the boundary
markers. -/
def sandersCase : ArgumentPackage Claim :=
  sandersLine.asPackage newPerspectiveCite "Paul's ἔργα νόμου is not works in general"

/-- Gathercole and *Variegated Nomism*: not covenantal nomism, so ἔργα νόμου are
works in general. -/
def criticsCase : ArgumentPackage Claim :=
  criticsLine.asPackage criticsCite "Paul's ἔργα νόμου is works in general"

/-- Jervell: Luke is law-observant, so the yoke is not the law as a condition of
salvation. -/
def jervellCase : ArgumentPackage Claim :=
  jervellLine.asPackage lawObservantLukeCite
    "the yoke of Acts 15:10 is not the law as a condition of salvation"

/-! ### Each position holds together and delivers its conclusion -/

/-- The Pauline case delivers sola fide. -/
theorem paulineCase_establishes : Establishes paulineCase := by
  establish [paulineCase, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The Pauline case has a model. -/
theorem paulineCase_is_satisfiable : Satisfiable paulineCase.premises := by
  satisfied_by everythingHoldsReading [paulineCase, paulineCase, dominicalCase, apostolicCase,
      tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase, criticsCase,
      jervellCase, Line.asPackage, Line.premises, reformed, reformed, Line.onGrounds, paulineLine,
      dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
      paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
      dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks,
      toThroughFaith, conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The dominical case delivers sola fide. -/
theorem dominicalCase_establishes : Establishes dominicalCase := by
  establish [dominicalCase, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The dominical case has a model. -/
theorem dominicalCase_is_satisfiable : Satisfiable dominicalCase.premises := by
  satisfied_by everythingHoldsReading [dominicalCase, paulineCase, dominicalCase, apostolicCase,
      tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase, criticsCase,
      jervellCase, Line.asPackage, Line.premises, reformed, reformed, Line.onGrounds, paulineLine,
      dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
      paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
      dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks,
      toThroughFaith, conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The apostolic case delivers sola fide. -/
theorem apostolicCase_establishes : Establishes apostolicCase := by
  establish [apostolicCase, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The apostolic case has a model. -/
theorem apostolicCase_is_satisfiable : Satisfiable apostolicCase.premises := by
  satisfied_by everythingHoldsReading [apostolicCase, paulineCase, dominicalCase, apostolicCase,
      tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase, criticsCase,
      jervellCase, Line.asPackage, Line.premises, reformed, reformed, Line.onGrounds, paulineLine,
      dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
      paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
      dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks,
      toThroughFaith, conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- Trent's case delivers its conclusion: salvation is not apart from works. -/
theorem tridentineCase_establishes : Establishes tridentineCase := by
  establish [tridentineCase, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- Trent's case has a model. -/
theorem tridentineCase_is_satisfiable : Satisfiable tridentineCase.premises := by
  satisfied_by tridentineReading [tridentineCase, paulineCase, dominicalCase, apostolicCase,
      tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase, criticsCase,
      jervellCase, Line.asPackage, Line.premises, reformed, reformed, Line.onGrounds, paulineLine,
      dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
      paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
      dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks,
      toThroughFaith, conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The apocalyptic case delivers its conclusion. -/
theorem apocalypticCase_establishes : Establishes apocalypticCase := by
  establish [apocalypticCase, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The apocalyptic case has a model. -/
theorem apocalypticCase_is_satisfiable : Satisfiable apocalypticCase.premises := by
  satisfied_by apocalypticReading [apocalypticCase, paulineCase, dominicalCase, apostolicCase,
      tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase, criticsCase,
      jervellCase, Line.asPackage, Line.premises, reformed, reformed, Line.onGrounds, paulineLine,
      dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
      paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
      dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks,
      toThroughFaith, conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- Sanders' case delivers its conclusion. -/
theorem sandersCase_establishes : Establishes sandersCase := by
  establish [sandersCase, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- Sanders' case has a model. -/
theorem sandersCase_is_satisfiable : Satisfiable sandersCase.premises := by
  satisfied_by sandersReading [sandersCase, paulineCase, dominicalCase, apostolicCase,
      tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase, criticsCase,
      jervellCase, Line.asPackage, Line.premises, reformed, reformed, Line.onGrounds, paulineLine,
      dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
      paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
      dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks,
      toThroughFaith, conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The critics' case delivers its conclusion. -/
theorem criticsCase_establishes : Establishes criticsCase := by
  establish [criticsCase, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The critics' case has a model. -/
theorem criticsCase_is_satisfiable : Satisfiable criticsCase.premises := by
  satisfied_by criticsReading [criticsCase, paulineCase, dominicalCase, apostolicCase,
      tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase, criticsCase,
      jervellCase, Line.asPackage, Line.premises, reformed, reformed, Line.onGrounds, paulineLine,
      dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
      paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
      dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks,
      toThroughFaith, conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- Jervell's case delivers its conclusion. -/
theorem jervellCase_establishes : Establishes jervellCase := by
  establish [jervellCase, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-- Jervell's case has a model. -/
theorem jervellCase_is_satisfiable : Satisfiable jervellCase.premises := by
  satisfied_by lawObservantLukeReading [jervellCase, paulineCase, dominicalCase, apostolicCase,
      tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase, criticsCase,
      jervellCase, Line.asPackage, Line.premises, reformed, reformed, Line.onGrounds, paulineLine,
      dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw,
      paulineWithoutPistisChristou, sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone,
      dominicalToFaithAlone, apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks,
      toThroughFaith, conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace]

/-! ### Strength: every position's weakest link is `disputed`

Every party rests on something cited `disputed`, or denies an atom, which ranks
at the bottom; so every party's strength is `0`, and no rating blocks any
attack. In this dispute the ratings decide nothing, and the verdict is fixed by
who contradicts whom. -/

/-- The Pauline case rests on its lexical premises, cited `disputed`. -/
theorem paulineCase_strength : paulineCase.strength = 0 := by decide
/-- The dominical case rests on the σῴζω premise, cited `disputed`. -/
theorem dominicalCase_strength : dominicalCase.strength = 0 := by decide
/-- The apostolic case rests on the yoke premise, cited `disputed`. -/
theorem apostolicCase_strength : apostolicCase.strength = 0 := by decide
/-- Trent denies the forensic account, and a denial ranks at the bottom. -/
theorem tridentineCase_strength : tridentineCase.strength = 0 := by decide
/-- The apocalyptic case denies the objective genitive. -/
theorem apocalypticCase_strength : apocalypticCase.strength = 0 := by decide
/-- Sanders' case rests on covenantal nomism, cited `disputed`. -/
theorem sandersCase_strength : sandersCase.strength = 0 := by decide
/-- The critics' case denies covenantal nomism. -/
theorem criticsCase_strength : criticsCase.strength = 0 := by decide
/-- Jervell's step is contested, by Bruce. -/
theorem jervellCase_strength : jervellCase.strength = 0 := by decide

/-! ### The defeats -/

/-- **Trent defeats the Pauline case.** It entails the denial of "not by works",
so it rebuts sola fide. -/
theorem trent_defeats_pauline : Defeats tridentineCase paulineCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [tridentineCase_strength, paulineCase_strength]; decide⟩

/-- **Trent defeats the dominical case**, on the same rebuttal. -/
theorem trent_defeats_dominical : Defeats tridentineCase dominicalCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [tridentineCase_strength, dominicalCase_strength]; decide⟩

/-- **Trent defeats the apostolic case**, on the same rebuttal. -/
theorem trent_defeats_apostolic : Defeats tridentineCase apostolicCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [tridentineCase_strength, apostolicCase_strength]; decide⟩

/-- **The Pauline case defeats Trent back.** It entails "not by works", which Trent denies. -/
theorem pauline_defeats_trent : Defeats paulineCase tridentineCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [paulineCase_strength, tridentineCase_strength]; decide⟩

/-- **The dominical case defeats Trent back.** -/
theorem dominical_defeats_trent : Defeats dominicalCase tridentineCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [dominicalCase_strength, tridentineCase_strength]; decide⟩

/-- **The apostolic case defeats Trent back.** -/
theorem apostolic_defeats_trent : Defeats apostolicCase tridentineCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [apostolicCase_strength, tridentineCase_strength]; decide⟩

/-- **The apocalyptic reading defeats Trent.** It holds "not by works" by its
own step — God's deliverance is conditioned on nothing a person does — and Trent
denies it. -/
theorem apocalyptic_defeats_trent : Defeats apocalypticCase tridentineCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [apocalypticCase_strength, tridentineCase_strength]; decide⟩

/-- **The apocalyptic reading defeats the Pauline case.** It denies the
objective genitive, a premise of Paul's strand cited `disputed`. -/
theorem apocalyptic_defeats_pauline : Defeats apocalypticCase paulineCase :=
  .inl ⟨p .pistisChristouObjective,
    ⟨by simp [paulineCase, caseOf, paulineLine], by establish [paulineCase, dominicalCase,
        apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase,
        criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed, Line.onGrounds,
        paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine,
        paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds, prooftexts,
        closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
        jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
        graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]⟩,
    by decide⟩

/-- **The Pauline case defeats the apocalyptic reading back.** It entails
justification by faith alone. -/
theorem pauline_defeats_apocalyptic : Defeats paulineCase apocalypticCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [paulineCase_strength, apocalypticCase_strength]; decide⟩

/-- **The dominical case defeats the apocalyptic reading**, on the same rebuttal
— and the apocalyptic reading contradicts nothing it rests on. -/
theorem dominical_defeats_apocalyptic : Defeats dominicalCase apocalypticCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [dominicalCase_strength, apocalypticCase_strength]; decide⟩

/-- **The apostolic case defeats the apocalyptic reading**, likewise. -/
theorem apostolic_defeats_apocalyptic : Defeats apostolicCase apocalypticCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [apostolicCase_strength, apocalypticCase_strength]; decide⟩

/-- **Sanders defeats the Pauline case.** Covenantal nomism, with Dunn's
inference, denies the ἔργα νόμου premise. -/
theorem sanders_defeats_pauline : Defeats sandersCase paulineCase :=
  .inl ⟨p .worksOfLawMeansWorksGenerally,
    ⟨by simp [paulineCase, caseOf, paulineLine], by establish [paulineCase, dominicalCase,
        apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase,
        criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed, Line.onGrounds,
        paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine,
        paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds, prooftexts,
        closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
        jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
        graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]⟩,
    by decide⟩

/-- **The Pauline case defeats Sanders back.** It holds the premise Sanders' conclusion denies. -/
theorem pauline_defeats_sanders : Defeats paulineCase sandersCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [paulineCase_strength, sandersCase_strength]; decide⟩

/-- **Sanders defeats the critics.** Their conclusions contradict. -/
theorem sanders_defeats_critics : Defeats sandersCase criticsCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [sandersCase_strength, criticsCase_strength]; decide⟩

/-- **The critics defeat Sanders.** They deny covenantal nomism, his ground. -/
theorem critics_defeat_sanders : Defeats criticsCase sandersCase :=
  .inl ⟨p .secondTempleCovenantalNomism,
    ⟨by simp [sandersCase, sandersLine, Line.asPackage, Line.premises], by establish [paulineCase,
        dominicalCase, apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic,
        sandersCase, criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed,
        Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
        criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
        prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
        jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
        graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]⟩,
    by decide⟩

/-- **Jervell defeats the apostolic case.** He denies the yoke premise. -/
theorem jervell_defeats_apostolic : Defeats jervellCase apostolicCase :=
  .inl ⟨p .acts15YokeIsLawAsCondition,
    ⟨by simp [apostolicCase, caseOf, apostolicLine], by establish [paulineCase, dominicalCase,
        apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase,
        criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed, Line.onGrounds,
        paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine, criticsLine,
        paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds, prooftexts,
        closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
        jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
        graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]⟩,
    by decide⟩

/-- **The apostolic case defeats Jervell back.** It holds the premise his conclusion denies. -/
theorem apostolic_defeats_jervell : Defeats apostolicCase jervellCase :=
  .inr ⟨by establish [Rebuts, paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine,
      apocalypticCase, apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage,
      Line.premises, reformed, reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine,
      jamesLine, sandersLine, criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou,
      sharedGrounds, prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
      apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
      conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
      deliveranceNotFaithAlone, deliveranceIsGrace],
    by rw [apostolicCase_strength, jervellCase_strength]; decide⟩

/-! ### What does not defeat

Most pairs of parties are compatible: some world holds both. Seven such worlds
settle every such pair at once (`Dispute.StandTogether`). Three pairs conflict
in one direction only, and those are shown premise by premise. -/

/-- The critics' world with Jervell's: covenantal nomism fails, and the yoke is
Israel's law for gentiles. The Pauline and dominical cases hold in it. -/
def criticsJervellReading : Valuation Claim := fun a =>
  match a with
  | .secondTempleCovenantalNomism => False
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- Trent's world with Sanders' and Jervell's. -/
def trentSandersJervellReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .worksOfLawMeansWorksGenerally => False
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- Trent's world with the critics' and Jervell's. -/
def trentCriticsJervellReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .secondTempleCovenantalNomism => False
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- The apocalyptic world with Sanders' and Jervell's. -/
def apocalypticSandersJervellReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | .worksOfLawMeansWorksGenerally => False
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- The apocalyptic world with the critics' and Jervell's. -/
def apocalypticCriticsJervellReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | .secondTempleCovenantalNomism => False
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- The apocalyptic world in which salvation is still received through faith —
faith is not the condition, but it is the means. Grace and "not by works" hold. -/
def apocalypticWithFaithReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | _ => True

/-- The same, with Jesus' σέσωκέν σε read as healing. -/
def apocalypticHealingReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | .sozoIsSoteriological => False
  | _ => True

/-- The same, with the yoke read as Jervell reads it. -/
def apocalypticJervellReading : Valuation Claim := fun a =>
  match a with
  | .pistisChristouObjective => False
  | .justificationByFaithAlone => False
  | .acts15YokeIsLawAsCondition => False
  | _ => True

/-- Trent's world, with the objective genitive and the apocalyptic reading of
δικαιοσύνη θεοῦ both denied. -/
def trentWithoutDeliveranceReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .pistisChristouObjective => False
  | .righteousnessOfGodIsDeliverance => False
  | _ => True

/-- Trent's world, in which justification is not by faith alone — the
apocalyptic reading's conclusion, which Trent shares. -/
def trentWithoutFaithAloneReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationByFaithAlone => False
  | _ => True

/-- **The apocalyptic reading does not defeat the dominical case.** It
contradicts nothing the dominical case rests on — not Luke 7:50, not σῴζω — and
it does not deny its conclusion: it grants grace and "not by works", and it can
grant that salvation is received through faith while denying that faith is its
condition. -/
theorem apocalyptic_does_not_defeat_dominical : ¬ Defeats apocalypticCase dominicalCase := by
  refine not_defeats_of_models ?_ ?_
  · intro φ hφ
    simp only [dominicalCase, caseOf, dominicalLine, sharedGrounds, prooftexts, jamesLine,
        closingSteps, conclusionSteps, List.flatMap_cons, List.flatMap_nil, List.map_cons,
        List.map_nil, List.cons_append, List.nil_append, List.append_nil, List.mem_cons,
        List.not_mem_nil, or_false] at hφ
    rcases hφ with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
      rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    all_goals first
      | (· satisfied_by apocalypticWithFaithReading [apocalypticCase, paulineCase, dominicalCase,
          apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase,
          criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed,
          Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
          criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
          prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
          apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
          conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
          deliveranceNotFaithAlone, deliveranceIsGrace])
      | (· satisfied_by apocalypticHealingReading [apocalypticCase, paulineCase, dominicalCase,
          apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase,
          criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed,
          Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
          criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
          prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
          apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
          conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
          deliveranceNotFaithAlone, deliveranceIsGrace])
  · satisfied_by apocalypticWithFaithReading [apocalypticCase, dominicalCase, paulineCase,
      dominicalCase, apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic,
      sandersCase, criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed,
      Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
      criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
      prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
      jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
      graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]

/-- **Nor the apostolic case**, for the same reasons. -/
theorem apocalyptic_does_not_defeat_apostolic : ¬ Defeats apocalypticCase apostolicCase := by
  refine not_defeats_of_models ?_ ?_
  · intro φ hφ
    simp only [apostolicCase, caseOf, apostolicLine, sharedGrounds, prooftexts, jamesLine,
        closingSteps, conclusionSteps, List.flatMap_cons, List.flatMap_nil, List.map_cons,
        List.map_nil, List.cons_append, List.nil_append, List.append_nil, List.mem_cons,
        List.not_mem_nil, or_false] at hφ
    rcases hφ with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
      rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    all_goals first
      | (· satisfied_by apocalypticWithFaithReading [apocalypticCase, paulineCase, dominicalCase,
          apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase,
          criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed,
          Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
          criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
          prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
          apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
          conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
          deliveranceNotFaithAlone, deliveranceIsGrace])
      | (· satisfied_by apocalypticJervellReading [apocalypticCase, paulineCase, dominicalCase,
          apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase,
          criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed,
          Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
          criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
          prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
          apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
          conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
          deliveranceNotFaithAlone, deliveranceIsGrace])
  · satisfied_by apocalypticWithFaithReading [apocalypticCase, apostolicCase, paulineCase,
      dominicalCase, apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic,
      sandersCase, criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed,
      Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
      criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
      prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
      jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
      graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]

/-- **Trent does not defeat the apocalyptic reading.** They agree on its
conclusion — justification is not by faith alone — and Trent contradicts none of
its premises: nothing Trent holds settles the genitive, or what δικαιοσύνη θεοῦ
names. So the apocalyptic reading's "not by works" stands against Trent
unanswered. -/
theorem trent_does_not_defeat_apocalyptic : ¬ Defeats tridentineCase apocalypticCase := by
  refine not_defeats_of_models ?_ ?_
  · intro φ hφ
    simp only [apocalypticCase, apocalyptic, caseOf, apocalypticLine, List.flatMap_cons,
        List.flatMap_nil, List.map_cons, List.map_nil, List.cons_append, List.nil_append,
        List.append_nil, List.mem_cons, List.not_mem_nil, or_false] at hφ
    rcases hφ with rfl | rfl | rfl | rfl | rfl | rfl | rfl
    all_goals first
      | (· satisfied_by trentWithoutDeliveranceReading [tridentineCase, paulineCase, dominicalCase,
          apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase,
          criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed,
          Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
          criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
          prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
          apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
          conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
          deliveranceNotFaithAlone, deliveranceIsGrace])
      | (· satisfied_by tridentineReading [tridentineCase, paulineCase, dominicalCase,
          apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic, sandersCase,
          criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed,
          Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
          criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
          prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone,
          apostolicToFaithAlone, jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith,
          conclusionSteps, solaFide, graceNotWorks, jervellLine, apocalypticLine,
          deliveranceNotFaithAlone, deliveranceIsGrace])
  · satisfied_by trentWithoutFaithAloneReading [tridentineCase, apocalypticCase, paulineCase,
      dominicalCase, apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic,
      sandersCase, criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed,
      Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
      criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
      prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
      jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
      graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]

/-! ### The dispute -/

/-- The parties to the dispute over sola fide. -/
inductive Party
  /-- Sola fide from Paul. -/
  | pauline
  /-- Sola fide from Jesus' words at Luke 7:50. -/
  | dominical
  /-- Sola fide from Peter at Jerusalem. -/
  | apostolic
  /-- Trent, against "not by works". -/
  | trent
  /-- The apocalyptic reading, against faith as the condition. -/
  | apocalyptic
  /-- Sanders and Dunn, against ἔργα νόμου as works in general. -/
  | sanders
  /-- Gathercole and *Variegated Nomism*, for it. -/
  | critics
  /-- Jervell, against the yoke as the law as a condition of salvation. -/
  | jervell
deriving DecidableEq

/-- The package each party argues from. -/
def partyNode : Party → ArgumentPackage Claim
  | .pauline => paulineCase
  | .dominical => dominicalCase
  | .apostolic => apostolicCase
  | .trent => tridentineCase
  | .apocalyptic => apocalypticCase
  | .sanders => sandersCase
  | .critics => criticsCase
  | .jervell => jervellCase

/-- The dispute over sola fide: every party's premises have a model, every party
establishes its conclusion, and every party's inferences are rated. -/
def solaFideDispute : Dispute Claim Party where
  node := partyNode
  consistent
    | .pauline => paulineCase_is_satisfiable
    | .dominical => dominicalCase_is_satisfiable
    | .apostolic => apostolicCase_is_satisfiable
    | .trent => tridentineCase_is_satisfiable
    | .apocalyptic => apocalypticCase_is_satisfiable
    | .sanders => sandersCase_is_satisfiable
    | .critics => criticsCase_is_satisfiable
    | .jervell => jervellCase_is_satisfiable
  sound
    | .pauline => paulineCase_establishes
    | .dominical => dominicalCase_establishes
    | .apostolic => apostolicCase_establishes
    | .trent => tridentineCase_establishes
    | .apocalyptic => apocalypticCase_establishes
    | .sanders => sandersCase_establishes
    | .critics => criticsCase_establishes
    | .jervell => jervellCase_establishes
  rated i := by
    cases i <;> simp [partyNode, paulineCase, dominicalCase, apostolicCase, tridentineCase,
      apocalypticCase, sandersCase, criticsCase, jervellCase, sandersLine, criticsLine,
      jervellLine, Line.asPackage]

/-- The Reformed strands and the critics stand together, where covenantal nomism
fails and everything else holds. -/
theorem reformed_strands_stand_with_the_critics :
    solaFideDispute.StandTogether [.pauline, .dominical, .apostolic, .critics] := by
  satisfied_by criticsReading [Dispute.StandTogether, solaFideDispute, partyNode, paulineCase,
      dominicalCase, apostolicCase, tridentineCase, tridentine, apocalypticCase, apocalyptic,
      sandersCase, criticsCase, jervellCase, Line.asPackage, Line.premises, reformed, reformed,
      Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
      criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
      prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
      jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
      graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]

/-- Paul and Luke stand with the critics and with Jervell. -/
theorem paul_and_luke_stand_with_jervell :
    solaFideDispute.StandTogether [.pauline, .dominical, .jervell, .critics] := by
  satisfied_by criticsJervellReading [Dispute.StandTogether, solaFideDispute, partyNode,
      paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine, apocalypticCase,
      apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage, Line.premises, reformed,
      reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
      criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
      prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
      jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
      graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]

/-- Luke and Acts stand with Sanders: neither rests on ἔργα νόμου. -/
theorem luke_and_acts_stand_with_sanders :
    solaFideDispute.StandTogether [.dominical, .apostolic, .sanders] := by
  satisfied_by newPerspectiveOwnReading [Dispute.StandTogether, solaFideDispute, partyNode,
      paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine, apocalypticCase,
      apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage, Line.premises, reformed,
      reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
      criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
      prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
      jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
      graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]

/-- Trent stands with Sanders and Jervell. -/
theorem trent_stands_with_sanders_and_jervell :
    solaFideDispute.StandTogether [.trent, .sanders, .jervell] := by
  satisfied_by trentSandersJervellReading [Dispute.StandTogether, solaFideDispute, partyNode,
      paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine, apocalypticCase,
      apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage, Line.premises, reformed,
      reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
      criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
      prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
      jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
      graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]

/-- Trent stands with the critics and Jervell. -/
theorem trent_stands_with_the_critics_and_jervell :
    solaFideDispute.StandTogether [.trent, .critics, .jervell] := by
  satisfied_by trentCriticsJervellReading [Dispute.StandTogether, solaFideDispute, partyNode,
      paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine, apocalypticCase,
      apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage, Line.premises, reformed,
      reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
      criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
      prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
      jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
      graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The apocalyptic reading stands with Sanders and Jervell. -/
theorem apocalyptic_stands_with_sanders_and_jervell :
    solaFideDispute.StandTogether [.apocalyptic, .sanders, .jervell] := by
  satisfied_by apocalypticSandersJervellReading [Dispute.StandTogether, solaFideDispute, partyNode,
      paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine, apocalypticCase,
      apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage, Line.premises, reformed,
      reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
      criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
      prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
      jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
      graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The apocalyptic reading stands with the critics and Jervell. -/
theorem apocalyptic_stands_with_the_critics_and_jervell :
    solaFideDispute.StandTogether [.apocalyptic, .critics, .jervell] := by
  satisfied_by apocalypticCriticsJervellReading [Dispute.StandTogether, solaFideDispute, partyNode,
      paulineCase, dominicalCase, apostolicCase, tridentineCase, tridentine, apocalypticCase,
      apocalyptic, sandersCase, criticsCase, jervellCase, Line.asPackage, Line.premises, reformed,
      reformed, Line.onGrounds, paulineLine, dominicalLine, apostolicLine, jamesLine, sandersLine,
      criticsLine, paulineWithoutWorksOfLaw, paulineWithoutPistisChristou, sharedGrounds,
      prooftexts, closingSteps, paulineToFaithAlone, dominicalToFaithAlone, apostolicToFaithAlone,
      jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
      graceNotWorks, jervellLine, apocalypticLine, deliveranceNotFaithAlone, deliveranceIsGrace]

/-- The defeats of the dispute, as a table. -/
def partyDefeats : Party → Party → Prop
  | .trent, .pauline => True
  | .trent, .dominical => True
  | .trent, .apostolic => True
  | .pauline, .trent => True
  | .dominical, .trent => True
  | .apostolic, .trent => True
  | .apocalyptic, .trent => True
  | .apocalyptic, .pauline => True
  | .pauline, .apocalyptic => True
  | .dominical, .apocalyptic => True
  | .apostolic, .apocalyptic => True
  | .sanders, .pauline => True
  | .pauline, .sanders => True
  | .sanders, .critics => True
  | .critics, .sanders => True
  | .jervell, .apostolic => True
  | .apostolic, .jervell => True
  | _, _ => False

/-- **Who defeats whom**, all sixty-four pairs. Trent and each Reformed strand
defeat each other. The apocalyptic reading and Paul defeat each other; Luke and
Acts defeat it, and it defeats neither; it defeats Trent, and Trent does not
defeat it. Sanders defeats Paul and the critics, and both defeat him back.
Jervell and Acts defeat each other. Nothing else. -/
theorem solaFideDispute_defeats :
    ∀ i j, solaFideDispute.defeats i j ↔ partyDefeats i j := by
  defeat_table [partyDefeats] using [trent_defeats_pauline, trent_defeats_dominical,
    trent_defeats_apostolic, pauline_defeats_trent, dominical_defeats_trent,
    apostolic_defeats_trent, apocalyptic_defeats_trent, apocalyptic_defeats_pauline,
    pauline_defeats_apocalyptic, dominical_defeats_apocalyptic,
    apostolic_defeats_apocalyptic, sanders_defeats_pauline, pauline_defeats_sanders,
    sanders_defeats_critics, critics_defeat_sanders, jervell_defeats_apostolic,
    apostolic_defeats_jervell, apocalyptic_does_not_defeat_dominical,
    apocalyptic_does_not_defeat_apostolic, trent_does_not_defeat_apocalyptic,
    reformed_strands_stand_with_the_critics, paul_and_luke_stand_with_jervell,
    luke_and_acts_stand_with_sanders, trent_stands_with_sanders_and_jervell,
    trent_stands_with_the_critics_and_jervell, apocalyptic_stands_with_sanders_and_jervell,
    apocalyptic_stands_with_the_critics_and_jervell]

/-! ### What the dispute decides -/

/-- **Nothing prevails outright.** Every party is defeated by some other: each
Reformed strand by Trent, Trent by each strand and by the apocalyptic reading,
the apocalyptic reading by Paul, Sanders by the critics, the critics by
Sanders, Jervell by Acts. The grounded extension — what the dispute forces,
before any choice between rivals — is empty. -/
@[headline]
theorem nothing_prevails_over_sola_fide : grounded solaFideDispute.defeats = ∅ :=
  grounded_eq_empty_of_attacked fun a => by
    cases a
    · exact ⟨.trent, (solaFideDispute_defeats _ _).mpr trivial⟩
    · exact ⟨.trent, (solaFideDispute_defeats _ _).mpr trivial⟩
    · exact ⟨.trent, (solaFideDispute_defeats _ _).mpr trivial⟩
    · exact ⟨.pauline, (solaFideDispute_defeats _ _).mpr trivial⟩
    · exact ⟨.pauline, (solaFideDispute_defeats _ _).mpr trivial⟩
    · exact ⟨.critics, (solaFideDispute_defeats _ _).mpr trivial⟩
    · exact ⟨.sanders, (solaFideDispute_defeats _ _).mpr trivial⟩
    · exact ⟨.apostolic, (solaFideDispute_defeats _ _).mpr trivial⟩

#print axioms nothing_prevails_over_sola_fide

/-- **Trent cannot be defended.** The apocalyptic reading defeats it — it holds
"not by works" on grounds Trent does not contradict — and the only parties that
defeat the apocalyptic reading are the Reformed strands, each of which also
defeats Trent. No position can hold Trent and answer the apocalyptic reading at
once. -/
@[headline]
theorem trent_indefensible (S : Set Party)
    (hS : Admissible solaFideDispute.defeats S) : Party.trent ∉ S := by
  intro ht
  obtain ⟨c, hc, hca⟩ := hS.2 _ ht .apocalyptic ((solaFideDispute_defeats _ _).mpr trivial)
  rw [solaFideDispute_defeats] at hca
  cases c <;> simp only [partyDefeats] at hca <;>
    exact hS.1 _ hc _ ht ((solaFideDispute_defeats _ _).mpr trivial)

#print axioms trent_indefensible

/-- **Nor can the apocalyptic reading.** The dominical case defeats it, and the
only party that defeats the dominical case is Trent — which the apocalyptic
reading itself defeats. -/
@[headline]
theorem apocalyptic_indefensible (S : Set Party)
    (hS : Admissible solaFideDispute.defeats S) : Party.apocalyptic ∉ S := by
  intro ha
  obtain ⟨c, hc, hcd⟩ := hS.2 _ ha .dominical ((solaFideDispute_defeats _ _).mpr trivial)
  rw [solaFideDispute_defeats] at hcd
  cases c <;> simp only [partyDefeats] at hcd
  exact hS.1 _ ha _ hc ((solaFideDispute_defeats _ _).mpr trivial)

#print axioms apocalyptic_indefensible

/-- **Sola fide from Luke 7:50 is accepted on every resolution.** Its only
defeater is Trent, which no admissible position can hold; it defeats back the
only other party it conflicts with, the apocalyptic reading, which no admissible
position can hold either. So every preferred extension — every maximal
defensible position — contains it.

This is the dispute's verdict, and it is narrower than it sounds. It is not
reached by the grounded semantics, which forces nothing
(`nothing_prevails_over_sola_fide`). It rests on the two rivals to sola fide
defeating each other: remove the apocalyptic reading and Trent can be defended
again (`sola_fide_not_forced_without_the_apocalyptic_reading`). And the
dominical case is attacked by no one but Trent because no source cited here
argues that σῴζω at Luke 7:50 means healing; its premise is rated `disputed`,
but the dispute has no party that disputes it. -/
@[headline]
theorem dominical_case_skeptically_accepted :
    SkepticallyAccepted solaFideDispute.defeats .dominical := by
  intro S hS
  by_contra hD
  have hT := trent_indefensible S hS.1
  have hA := apocalyptic_indefensible S hS.1
  have hadm : Admissible solaFideDispute.defeats (insert .dominical S) := by
    refine ⟨?_, ?_⟩
    · intro x hx y hy hxy
      rcases Set.mem_insert_iff.mp hx with rfl | hx <;>
        rcases Set.mem_insert_iff.mp hy with rfl | hy
      · exact solaFideDispute.not_defeats_self _ hxy
      · rw [solaFideDispute_defeats] at hxy
        cases y <;> simp only [partyDefeats] at hxy
        · exact hT hy
        · exact hA hy
      · rw [solaFideDispute_defeats] at hxy
        cases x <;> simp only [partyDefeats] at hxy
        exact hT hx
      · exact hS.1.1 x hx y hy hxy
    · intro x hx
      rcases Set.mem_insert_iff.mp hx with rfl | hx
      · intro b hb
        rw [solaFideDispute_defeats] at hb
        cases b <;> simp only [partyDefeats] at hb
        exact ⟨.dominical, Set.mem_insert _ _, (solaFideDispute_defeats _ _).mpr trivial⟩
      · exact (hS.1.2 x hx).mono (Set.subset_insert _ _)
  exact hD (hS.eq_of_subset hadm (Set.subset_insert _ _) ▸ Set.mem_insert _ _)

#print axioms dominical_case_skeptically_accepted

/-- The dispute without the apocalyptic reading. -/
abbrev withoutApocalyptic := solaFideDispute.restrict (· ≠ Party.apocalyptic)

/-- **Without the apocalyptic reading, sola fide is no longer forced.** Trent,
heard against the three Reformed strands alone, defends itself: it defeats each
of them back. So some maximal defensible position holds Trent, and that position
cannot hold the dominical case, which Trent defeats.

The verdict of `dominical_case_skeptically_accepted` therefore rests on one
rival to sola fide answering the other: on the apocalyptic reading holding
"not by works" where Trent denies it. -/
@[headline]
theorem sola_fide_not_forced_without_the_apocalyptic_reading :
    ¬ SkepticallyAccepted withoutApocalyptic.defeats ⟨.dominical, by decide⟩ := by
  intro hskep
  have hadm : Admissible withoutApocalyptic.defeats {⟨.trent, by decide⟩} := by
    refine ⟨?_, ?_⟩
    · intro x hx y hy hxy
      simp only [Set.mem_singleton_iff] at hx hy
      subst hx hy
      exact withoutApocalyptic.not_defeats_self _ hxy
    · intro x hx b hb
      simp only [Set.mem_singleton_iff] at hx
      subst hx
      obtain ⟨b, hb'⟩ := b
      rw [Dispute.restrict_defeats, solaFideDispute_defeats] at hb
      refine ⟨⟨.trent, by decide⟩, rfl, ?_⟩
      rw [Dispute.restrict_defeats, solaFideDispute_defeats]
      cases b <;> first | exact absurd rfl hb' | simp_all [partyDefeats]
  obtain ⟨P, hsub, hP⟩ := hadm.exists_preferred
  have hd := hskep P hP
  have ht : (⟨.trent, by decide⟩ : {i // i ≠ Party.apocalyptic}) ∈ P := hsub rfl
  exact hP.1.1 _ ht _ hd
    ((Dispute.restrict_defeats _ _ _ _).mpr ((solaFideDispute_defeats _ _).mpr trivial))

#print axioms sola_fide_not_forced_without_the_apocalyptic_reading

end Testimony.Arguments.SolaFide
