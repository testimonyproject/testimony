import Testimony.Checks.Fallacies

/-!
# Testimony.Checks.FallacyCases — what the fallacy checks must catch, and must not

The checks of `Testimony.Semantics.Fallacy` are only worth having if they find
each charge where it is, and stay silent where it is not. A check that calls
every lexical survey an equivocation, or every argument from silence a fallacy,
is a debater's reflex written down. So this module pins both: for each charge,
a classic case the check must catch and a near miss it must pass over. Each is a
theorem, decided by the kernel, so a change to a check that moves either one
fails the build.

The first near miss is not hypothetical. The equivocation check's first version
flagged the sola fide line on James's word, which gathers what δικαιόω means in
Matthew and in Deuteronomy, as if a survey of a word needed its places alike.
The check now tells a word used from a word talked about, and the survey stays
here so that it cannot slip back.

The last section is a case the build itself must refuse: an argument of its own
whose lines equivocate and argue from silence alone, run through
`#check_fallacies`, with the failure pinned by `#guard_msgs`.

None of these cases is anyone's argument. They are built from the vocabulary,
and they argue nothing.
-/

namespace Testimony.Checks.FallacyCases

open Testimony Testimony.Semantics Testimony.Semantics.Notation

/-- Romans 3:28. -/
@[nolint defsWithUnderscore] abbrev rom3_28 : PassageRange := vs .romans 3 28

/-- James 2:24. -/
@[nolint defsWithUnderscore] abbrev jas2_24 : PassageRange := vs .james 2 24

/-- James 2:14. -/
@[nolint defsWithUnderscore] abbrev jas2_14 : PassageRange := vs .james 2 14

/-- Romans 4:5. -/
@[nolint defsWithUnderscore] abbrev rom4_5 : PassageRange := vs .romans 4 5

/-- A move, from its premises and its conclusion. -/
def argues (ps : List Statement) (c : Statement) : Move :=
  { speaker := "a test case", words := "", act := .argues ps c }

/-! ### Equivocation -/

/-- **Caught: the faith Paul counts, and the faith James asks about.** Romans
4:5 says that to the one who trusts, his faith is counted as righteousness; James
2:14 asks of a faith without works, "Can that faith save him?"; "faith" is trust
at the one and bare assent at the other; so faith is not what Romans 4:5 says it
is. The move needs one faith in both verses, and has just read two. -/
def thatFaith : Move :=
  argues
    [ .says rom4_5 (rl .instrumentOf (wd .pistis rom4_5) (wd .dikaioo rom4_5))
    , .says jas2_14 (.not (rl .sufficientFor (wd .pistis jas2_14) (wd .sozo jas2_14)))
    , .means .pistis (.passage rom4_5) .trust
    , .means .pistis (.passage jas2_14) .mereAssent ]
    (.holds (.not (rl .instrumentOf (wd .pistis rom4_5) (wd .dikaioo rom4_5))))

/-- **Passed over: the same, with "faith" said to be one in both verses.** Whether
it is one is disputed: Trent reads James's faith as the same assent, unformed by
charity, and the Reformers read it as a profession without trust. Stated as a
premise, it can be weighed; the move does not equivocate. -/
def thatFaithGranted : Move :=
  argues
    [ .says rom4_5 (rl .instrumentOf (wd .pistis rom4_5) (wd .dikaioo rom4_5))
    , .says jas2_14 (.not (rl .sufficientFor (wd .pistis jas2_14) (wd .sozo jas2_14)))
    , .sameSense .pistis (.passage jas2_14) (.passage rom4_5) ]
    (.holds (.not (rl .instrumentOf (wd .pistis rom4_5) (wd .dikaioo rom4_5))))

/-- **Passed over: a survey of the word.** What δικαιόω means in Matthew 11:19
and in Deuteronomy 25:1, gathered to say what it does not mean in James. The two
senses differ, and nothing needs them alike. -/
def survey : Move :=
  argues
    [ .means .dikaioo (.passage (vs .matthew 11 19)) .showRighteous
    , .means .dikaioo (.passage (vs .deuteronomy 25 1)) .verdict ]
    (.denied (.means .dikaioo (.usage .james) .makeRighteous))

/-- **Passed over: a move concluding that a word differs.** Reading "works" two
ways to conclude that Paul and James mean two things by it is the conclusion,
not an equivocation on it. -/
def worksDiffer : Move :=
  argues
    [ .means .erga (.passage rom3_28) .lawAsCondition
    , .means .erga (.passage jas2_24) .worksOfFaith ]
    (.denied (.sameSense .erga (.passage rom3_28) (.passage jas2_24)))

/-- **The equivocation check, caught and passed over.** "Faith" in Romans 4:5
and James 2:14 is read two ways and needed one. Granted the same, it needs
nothing unstated. The survey does not equivocate, since it only talks about the
word, but it is not free either: it is conditional on "justify" keeping, in
James, a sense it has elsewhere. The move whose conclusion is that "works"
differs assumes nothing about "works". -/
theorem equivocation_cases :
    thatFaith.equivocates = [.pistis] ∧
      thatFaithGranted.equivocates = [] ∧ thatFaithGranted.conditionalOn = [] ∧
      survey.equivocates = [] ∧ survey.conditionalOn = [.dikaioo] ∧
      worksDiffer.equivocates = [] ∧ worksDiffer.conditionalOn = [] := by
  decide

/-! ### Begging the question -/

/-- Faith is the only means of justification. -/
abbrev faithOnly : Statement := .holds (rl .soleInstrumentOf (cn .faith) (cn .justification))

/-- Works are not a means of justification. -/
abbrev worksNot : Statement := .holds (.not (rl .instrumentOf (cn .works) (cn .justification)))

/-- **Caught: the conclusion, restated.** -/
def restated : Move := argues [faithOnly] faithOnly

/-- **Caught: the conclusion, inside a premise by what "only" means.** -/
def throughOnly : Move := argues [faithOnly] worksNot

/-- **Passed over: a text's words, which carry no doctrine by themselves.**
Romans 3:28 saying "apart from works of the law" is what the text says. Whether
it teaches that works are no means — and whether "works of the law" are works in
general — are readings, and the move needs them. -/
def fromTheText : Move :=
  argues [.says rom3_28 (.not (rl .instrumentOf (wd .ergaNomou rom3_28)
      (wd .dikaioo rom3_28)))]
    worksNot

/-- **Passed over: the premise and the conclusion about different things.** -/
def different : Move :=
  argues [.holds (rl .instrumentOf (cn .faith) (cn .justification))] worksNot

/-- **The begging check, caught and passed over.** A premise that is the
conclusion carries it, and so does one that implies it by what "only" means; a
text's own words do not, and nor does a premise about something else. -/
theorem begging_cases :
    restated.carriers = [faithOnly] ∧ throughOnly.carriers = [faithOnly] ∧
      fromTheText.carriers = [] ∧ different.carriers = [] := by
  decide

/-- **Caught: a circle of three.** Romans 3:28 teaches faith alone because faith
is the only means; works are no means because of what Romans 3:28 teaches; and
faith is the only means because works are none. -/
def threeCircle : List Move :=
  let teaches := Statement.teaches rom3_28 (rl .soleInstrumentOf (cn .faith) (cn .justification))
  [argues [faithOnly] teaches, argues [teaches] worksNot, argues [worksNot] faithOnly]

/-- **Passed over: a chain that ends.** The same three moves, with the last one
resting on the text's words instead of on what the first concludes. -/
def chain : List Move :=
  let teaches := Statement.teaches rom3_28 (rl .soleInstrumentOf (cn .faith) (cn .justification))
  [ argues [faithOnly] teaches, argues [teaches] worksNot
  , argues [.says rom3_28 (rl .instrumentOf (wd .pistis rom3_28) (wd .dikaioo rom3_28))]
      faithOnly ]

/-- **The circle check, caught and passed over.** Every move of the circle rests,
through the others, on what it concludes. In the chain, the last move rests on
the text, and nothing returns to it. The first two still rest on its conclusion,
so they are not on a circle either. -/
theorem circle_cases : circular threeCircle = [0, 1, 2] ∧ circular chain = [] := by decide

/-! ### Argument from silence -/

/-- Paul taught that faith is the only means of justification. -/
abbrev paulTaught : Statement :=
  .heldBy .paul (rl .soleInstrumentOf (cn .faith) (cn .justification))

/-- Romans 3:28 says that faith is the only means of justification. -/
abbrev romansSaysOnly : Statement :=
  .says rom3_28 (rl .soleInstrumentOf (wd .pistis rom3_28) (wd .dikaioo rom3_28))

/-- **Caught: from what the verse does not say.** -/
def notSaid : Move := argues [.denied romansSaysOnly] (.denied paulTaught)

/-- **Caught: from a word that is not there, to a doctrine.** "Alone" is not in
Romans 3:28, so faith is not the only means. -/
def notThere : Move := argues [.denied (.occurs .monos rom3_28)] (.denied faithOnly)

/-- **Passed over: the silence, with its expectation.** -/
def notSaidExpected : Move :=
  argues [.denied romansSaysOnly, .expects paulTaught romansSaysOnly] (.denied paulTaught)

/-- **Passed over: a silence that concludes only the silence.** That the verse
does not say it, so the verse does not say it, argues from nothing; the begging
check finds it, not this one. -/
def onlyTheSilence : Move := argues [.denied romansSaysOnly] (.denied romansSaysOnly)

/-- **Caught: an expectation about something else.** Its expectation is for a
different silence, so it does not reach the silence the move argues from, which
is still alone. -/
def wrongExpectation : Move :=
  argues [.denied romansSaysOnly, .expects paulTaught (.occurs .monos rom3_28)]
    (.denied paulTaught)

/-- **The silence check, caught and passed over.** Both silences argued from
alone are caught, the second though its conclusion is written as a doctrine
denied, not a denial. With the expectation stated, the move rests on it. A
silence that concludes itself is not an argument from silence. And a move whose
expectation is about a different silence is caught too: its expectation does
not reach the silence it argues from. -/
theorem silence_cases :
    notSaid.fromSilenceAlone = [romansSaysOnly] ∧
      notThere.fromSilenceAlone = [.occurs .monos rom3_28] ∧
      notSaidExpected.fromSilenceAlone = [] ∧
      onlyTheSilence.silences = [] ∧ onlyTheSilence.carriers = [.denied romansSaysOnly] ∧
      wrongExpectation.fromSilenceAlone = [romansSaysOnly] := by
  decide

end Testimony.Checks.FallacyCases

/-! ### A case the build must refuse

An argument of its own, with a claim type, meanings, and two lines that commit
what `#check_fallacies` fails the build for: one reads "justify" two ways and
needs it one, one argues from silence alone. The check is run over it, and the
failure it reports is pinned. If the check stopped refusing either line, this
would fail. -/

namespace Testimony.Checks.FallacyCases.Refused

open Testimony Testimony.Logic Testimony.Semantics Testimony.Semantics.Notation
open Testimony.Checks.FallacyCases (rom3_28 jas2_24)

/-- The case's atomic claims. -/
inductive Claim
  /-- Romans 3:28 says a person is justified by faith. -/
  | romansSays
  /-- James 2:24 says a person is not justified by faith alone. -/
  | jamesSays
  /-- In Romans 3:28, "justify" gives a verdict. -/
  | verdictInRomans
  /-- In James 2:24, "justify" shows a person to be righteous. -/
  | showingInJames
  /-- Scripture is not consistent with itself. -/
  | inconsistent
  /-- The word "alone" is not in Romans 3:28. -/
  | aloneNotInRomans
  /-- Paul did not teach that faith is the only means of justification. -/
  | paulDidNotTeach
deriving DecidableEq, Repr

/-- Every claim. -/
def all : List Claim :=
  [.romansSays, .jamesSays, .verdictInRomans, .showingInJames, .inconsistent,
    .aloneNotInRomans, .paulDidNotTeach]

/-- What each claim means. -/
def means : Claim → Statement
  | .romansSays => .says rom3_28 (rl .instrumentOf (wd .pistis rom3_28) (wd .dikaioo rom3_28))
  | .jamesSays => .says jas2_24 (.not (rl .soleInstrumentOf (wd .pistis jas2_24)
      (wd .dikaioo jas2_24)))
  | .verdictInRomans => .means .dikaioo (.passage rom3_28) .verdict
  | .showingInJames => .means .dikaioo (.passage jas2_24) .showRighteous
  | .inconsistent => .denied (.principle .scriptureSelfConsistent)
  | .aloneNotInRomans => .denied (.occurs .monos rom3_28)
  | .paulDidNotTeach =>
    .denied (.heldBy .paul (rl .soleInstrumentOf (cn .faith) (cn .justification)))

/-- The case's meanings. -/
instance meanings : HasMeanings Claim :=
  { argument := "A case the build must refuse", all, means
  , complete := by intro a; cases a <;> decide }

/-- **Reads "justify" two ways and needs it one.** -/
def contradiction : Line Claim :=
  { name := "Paul against James"
  , grounds := [p .romansSays, p .jamesSays, p .verdictInRomans, p .showingInJames]
  , step := ⋀ [p .romansSays, p .jamesSays, p .verdictInRomans, p .showingInJames]
      ➝ p .inconsistent
  , delivers := p .inconsistent }

/-- **Argues from silence alone.** -/
def fromSilence : Line Claim :=
  { name := "Not in the verse"
  , grounds := [p .aloneNotInRomans]
  , step := p .aloneNotInRomans ➝ p .paulDidNotTeach
  , delivers := p .paulDidNotTeach }

/--
error: lines that equivocate or argue from silence alone, in:
Testimony.Checks.FallacyCases.Refused.Claim
A case the build must refuse
  lines: 2, read: 2
  read a word in two senses and need it the same:
    contradiction
  argue from silence alone:
    fromSilence
  need a word to keep its sense, unstated:
    contradiction: pistis
-/
#guard_msgs in
#check_fallacies under Testimony.Checks.FallacyCases.Refused

end Testimony.Checks.FallacyCases.Refused
