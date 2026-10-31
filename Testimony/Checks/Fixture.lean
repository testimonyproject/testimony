import Testimony.Attr
import Testimony.Logic.Line
import Testimony.Logic.Tactic
import Testimony.Logic.Dispute
import Testimony.Logic.Horn
import Testimony.Logic.Solver
import Testimony.Semantics.Meaning
import Testimony.Logic.Certificate

/-!
# Testimony.Checks.Fixture — the library's own case, for its checks

The library's checks find what they check for themselves — claim types,
packages, refutations, disputes — under a namespace they are given, and pin
what they find. Its arguments are not in the library but in a package built on
it, so the library keeps a case of its own for its checks to run over: small,
and complete enough that every check has something to find.

Two positions on how long a meeting lasted. The minutes record that it ran an
hour; a witness says the clock showed two hours. Each claim cites the library's
own proposal: none of this is reported from a source, and none of it argues
anything. It exercises one of everything a check reads — meanings joined by a
definition of the shared ontology, a refuted package, and a dispute with one
defeat and one refused attack.
-/

namespace Testimony.Checks.Fixture

open Testimony Testimony.Logic Testimony.Semantics Testimony.Semantics.Notation

/-- The fixture's atomic claims. -/
inductive Claim
  /-- The minutes record that the meeting ran an hour. -/
  | minutesSayAnHour
  /-- A witness says the clock showed that the meeting ran two hours. -/
  | clockSaysTwoHours
  /-- The meeting lasted an hour. -/
  | lastedAnHour
  /-- The meeting lasted two hours. -/
  | lastedTwoHours
deriving DecidableEq, Repr

/-- The fixture's source, at a rating: the library's own proposal. -/
def fixture (confidence : Confidence) : Source :=
  { primary := .proposal "A fixture of the library's own, for its checks; it argues nothing."
  , tradition := .adversarialTrial
  , confidence }

/-- Citation and classification for every atom. -/
def cite : Claim → AtomMeta
  | .minutesSayAnHour =>
    { label := "The minutes record that the meeting ran an hour"
    , kind := .historical, source := fixture .consensus }
  | .clockSaysTwoHours =>
    { label := "A witness says the clock showed two hours"
    , kind := .historical, source := fixture .disputed }
  | .lastedAnHour =>
    { label := "The meeting lasted an hour", kind := .historical, source := fixture .plausible }
  | .lastedTwoHours =>
    { label := "The meeting lasted two hours", kind := .historical, source := fixture .plausible }

/-- From the minutes to an hour. -/
@[fixtureDefs]
def fromTheMinutes : Line Claim :=
  { name := "By the minutes"
  , grounds := [p .minutesSayAnHour]
  , step := p .minutesSayAnHour ➝ p .lastedAnHour
  , delivers := p .lastedAnHour
  , inference := some (fixture .consensus) }

/-- From the clock to two hours. -/
@[fixtureDefs]
def fromTheClock : Line Claim :=
  { name := "By the clock"
  , grounds := [p .clockSaysTwoHours]
  , step := p .clockSaysTwoHours ➝ p .lastedTwoHours
  , delivers := p .lastedTwoHours
  , inference := some (fixture .consensus) }

/-- The minutes, as a position. -/
@[fixtureDefs]
def minutes : ArgumentPackage Claim := fromTheMinutes.asPackage cite "the meeting lasted an hour"

/-- The clock, as a position. -/
@[fixtureDefs]
def clock : ArgumentPackage Claim := fromTheClock.asPackage cite "the meeting lasted two hours"

/-- The minutes' reading: an hour, and the witness mistaken. -/
def minutesReading : Valuation Claim := fun a =>
  match a with
  | .clockSaysTwoHours => False
  | .lastedTwoHours => False
  | _ => True

/-- The clock's reading: two hours, and the minutes mistaken. -/
def clockReading : Valuation Claim := fun a =>
  match a with
  | .minutesSayAnHour => False
  | .lastedAnHour => False
  | _ => True

/-- The minutes deliver an hour. -/
theorem minutes_establishes : Establishes minutes := by establish [fixtureDefs]

/-- The minutes can be held. -/
theorem minutes_is_satisfiable : Satisfiable minutes.premises := by
  satisfied_by minutesReading [fixtureDefs]

/-- The clock delivers two hours. -/
theorem clock_establishes : Establishes clock := by establish [fixtureDefs]

/-- The clock can be held. -/
theorem clock_is_satisfiable : Satisfiable clock.premises := by
  satisfied_by clockReading [fixtureDefs]

/-- Without the minutes, their step delivers nothing: a refuted package, for the
refutation checks. -/
theorem the_hour_rests_on_the_minutes :
    ¬ Establishes ((fromTheMinutes.onGrounds []).asPackage cite "the meeting lasted an hour") := by
  refute_with clockReading [fixtureDefs]

/-- Everything at once: the minutes and the clock, an hour and two. Only what
"lasts" means rules it out, and `Independent` reads premises alone. -/
def bothReadings : Valuation Claim := fun _ => True

/-- The minutes leave the witness open: what the minutes record neither shows
nor rules out that a witness says the clock showed two hours — even read for
what "lasts" means, since the witness's saying so is not the meeting's lasting
so. For the checks that read an `Independent` result. -/
theorem the_minutes_leave_the_witness_open :
    Independent minutes.premises (p .clockSaysTwoHours) := by
  leaves_open minutesReading bothReadings [fixtureDefs]

/-! ### What the claims mean -/

/-- Every atom, in declaration order. -/
def all : List Claim := [.minutesSayAnHour, .clockSaysTwoHours, .lastedAnHour, .lastedTwoHours]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- The meeting. -/
abbrev theMeeting : Term := pt "the meeting" .event

/-- Two claims are about how long the meeting lasted; the other two keep their
labels, marked unanalysed. -/
def means : Claim → Statement
  | .lastedAnHour => .holds (rl .lasts theMeeting (cn (.minutes 60)))
  | .lastedTwoHours => .holds (rl .lasts theMeeting (cn (.minutes 120)))
  | a => .opaque (cite a).label

/-- What each atom says. -/
instance meanings : HasMeanings Claim :=
  { argument := "The fixture", all, complete := all_complete, means }

/-- The one join: an hour and two hours exclude each other, by what "lasts"
means (`Testimony.Ontology.Time.oneLength`). -/
instance joins : HasJoins Claim where
  exclusions := [(.lastedAnHour, .lastedTwoHours)]
  exclusions_pinned := by decide +kernel
  entailments := []
  entailments_pinned := by decide +kernel

/-- The postulates, written out. -/
@[fixtureDefs] theorem postulates_eq :
    (HasPostulates.postulates : List (Formula Claim)) =
      [p .lastedAnHour ➝ notP .lastedTwoHours] :=
  rfl

attribute [fixtureDefs] ArgumentPackage.held

/-! ### The dispute -/

/-- The parties. -/
inductive Party
  /-- By the minutes. -/
  | minutes
  /-- By the clock. -/
  | clock
deriving DecidableEq

/-- Each party's package. -/
@[fixtureDefs]
def node : Party → ArgumentPackage Claim
  | .minutes => minutes
  | .clock => clock

/-- The dispute: the minutes defeat the clock, whose own attack is refused, its
weakest link being the weaker. -/
@[fixtureDefs]
def dispute : Dispute Claim Party where
  node := node
  consistent i := Horn.satisfiable_of_certified (by cases i <;> horn_certify)
  sound
    | .minutes => minutes_establishes
    | .clock => clock_establishes
  rated i := by cases i <;> simp [fixtureDefs, Line.asPackage]

/-- The defeats, as a table. -/
def defeats : Party → Party → Prop
  | .minutes, .clock => True
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel defeats := fun i j => by
  cases i <;> cases j <;> unfold defeats <;> infer_instance

/-- Each party's weakest link: the minutes at `consensus`, the clock at
`disputed`. -/
def strength : Party → ℕ
  | .minutes => 3
  | .clock => 0

/-- Each party's weakest link, as its package computes it. -/
theorem node_strength : ∀ i, (node i).strength = strength i
  | .minutes => by decide
  | .clock => by decide

/-- Who defeats whom, computed and checked by the kernel. -/
theorem dispute_defeats : ∀ i j, dispute.defeats i j ↔ defeats i j := by
  intro i j
  refine Horn.defeats_iff_of_certified (node_strength i) (node_strength j) ?_
  cases i <;> cases j <;> horn_certify

/-- The dispute, in the form the solver and the AIF check read. -/
def finite : Solver.Finite dispute.defeats where
  parties := [.minutes, .clock]
  complete i := by cases i <;> decide
  defeats i j := decide (defeats i j)
  spec i j := by rw [dispute_defeats]; simp

end Testimony.Checks.Fixture
