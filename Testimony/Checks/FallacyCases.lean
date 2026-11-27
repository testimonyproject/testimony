import Testimony.Checks.Fallacies
import Testimony.Corpus.Greek

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

A premise may say a word keeps its sense across a range, or across only part of a verse. The
next cases pin how the check reads that: what is granted of John 3:16–18 is granted of 3:16, and
what is granted of 3:18a, "whoever believes in him is not condemned", is not granted of the whole
of 3:18, whose second half speaks of believing "in the name".

The straw-man cases come after it, with a small record of what each voice
holds, because that check compares what a move attributes with the record and
needs one to compare with.

Then the word-shift cases, a verb read by its adjective and the Greek by the
Latin, and the omission cases, with a record in which Augustine read "justify"
two ways, so that a move citing one of them is seen to leave out the other.

Then the univocality cases, with a record of readings of "justify": a move that
needs the word one in Romans and James is charged with the readings that tell the
letters apart, and passed over once it answers them, or where the only reading
makes the word one in both.

The case the build itself must refuse: an argument of its own
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

/-! ### Part of a passage -/

/-- John 6:29. -/
@[nolint defsWithUnderscore] abbrev john6_29 : PassageRange := vs .john 6 29

/-- John 3:16. -/
@[nolint defsWithUnderscore] abbrev john3_16 : PassageRange := vs .john 3 16

/-- **Passed over: a premise about a range covers a verse within it.** The move reads the
believing of 6:29 by the believing of 3:16, and its premise says "believe" keeps its sense
between 6:29 and all of 3:16–18. That covers 3:16. -/
def believingWithinTheRange : Move :=
  argues
    [ .says john3_16 (rl .instrumentOf (wd .pisteuo john3_16) (cn .eternalLife))
    , .sameSense .pisteuo (.passage john6_29) (.passage (rg .john 3 16 3 18)) ]
    (.holds (rl .instrumentOf (wd .pisteuo john6_29) (cn .eternalLife)))

/-- **Caught: a premise about half a verse does not cover the whole.** The move reads the
believing of 6:29 by the believing of all of 3:18, and its premise says "believe" keeps its
sense only between 6:29 and 3:18a. The rest of 3:18 is left unstated, and the check says that
the premise grants part of what the move uses. -/
def believingInHalfAVerse : Move :=
  argues
    [ .says (vs .john 3 18) (rl .instrumentOf (wd .pisteuo (vs .john 3 18)) (cn .eternalLife))
    , .sameSense .pisteuo (.passage john6_29) (.passage Corpus.Greek.johnThreeEighteenA) ]
    (.holds (rl .instrumentOf (wd .pisteuo john6_29) (cn .eternalLife)))

/-- **The equivocation check, over parts of a passage.** A premise about 3:16–18 grants what the
move needs of 3:16. A premise about 3:18a grants only part of what a move needs of all of 3:18,
and the check reports it so, with the places the premise does cover, and counts the move
conditional on "believe". -/
theorem part_of_a_passage_cases :
    believingWithinTheRange.equivocation =
        [(.pisteuo, .passage john3_16, .passage john6_29, .granted)] ∧
      believingWithinTheRange.conditionalOn = [] ∧
      believingInHalfAVerse.equivocation =
        [(.pisteuo, .passage (vs .john 3 18), .passage john6_29,
          .partly [(.passage john6_29, .passage Corpus.Greek.johnThreeEighteenA)])] ∧
      believingInHalfAVerse.conditionalOn = [.pisteuo] := by
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

/-- **Passed over: a conclusion stronger than its premises.** Faith is a means
of justification, and works are not, so faith is the only means. The conclusion,
read for what "only" means, entails the first premise: it says more than the
premise, as a conclusion may. Nothing the move assumes was drawn from its
conclusion, so it does not rest on itself. The circle check counts a move as
resting on another, never on itself. -/
def strongerConclusion : List Move :=
  [argues [.holds (rl .instrumentOf (cn .faith) (cn .justification)), worksNot] faithOnly]

/-- **Two routes to one conclusion**: the stronger conclusion twice, from two sets
of premises. Each conclusion carries the other's premises, as it carries its own,
and neither move draws from the other anything it does not already assume. -/
def twoRoutes : List Move :=
  [ argues [.holds (rl .instrumentOf (cn .faith) (cn .justification)), worksNot] faithOnly
  , argues [worksNot, .holds (rl .instrumentOf (cn .faith) (cn .justification))] faithOnly ]

/-- **The circle check, caught and passed over.** Every move of the circle rests,
through the others, on what it concludes. In the chain, the last move rests on
the text, and nothing returns to it. The first two still rest on its conclusion,
so they are not on a circle either. A move whose conclusion is stronger than its
premise rests on nothing but its premises, and two such moves to one conclusion
are two routes, not a circle. -/
theorem circle_cases :
    circular threeCircle = [0, 1, 2] ∧ circular chain = [] ∧ circular strongerConclusion = [] ∧
      circular twoRoutes = [] := by
  decide

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

/-! ### Misreading the original, and reversed cause and effect -/

/-- Galatians 5:6. -/
@[nolint defsWithUnderscore] abbrev gal5_6 : PassageRange := vs .galatians 5 6

open Testimony.Corpus.Greek in
greek_word galatiansWorking from GAL 5 6 "ἐνεργέω"

/-- That ἐνεργουμένη in Galatians 5:6 is passive. -/
abbrev saysPassive : Statement := .parses .energeo galatiansWorking .passive

/-- That it is middle. -/
abbrev saysMiddle : Statement := .parses .energeo galatiansWorking .middle

/-- That love moves faith. -/
abbrev loveMovesFaith : Statement := .holds (rl .moves (wd .agape gal5_6) (wd .pistis gal5_6))

/-- That faith works through love. -/
abbrev faithThroughLove : Statement :=
  .holds (rl .worksThrough (wd .pistis gal5_6) (wd .agape gal5_6))

open Testimony.Corpus.Greek in
greek_word galatiansWorker from GAL 3 5 "ἐνεργέω"

/-- That ὁ ἐνεργῶν in Galatians 3:5, "the one who works", is passive. -/
abbrev workerPassive : Statement := .parses .energeo galatiansWorker .passive

/-- That it is not active. -/
abbrev workerNotActive : Statement := .denied (.parses .energeo galatiansWorker .active)

/-- That ἐνεργουμένη in Galatians 5:6 is active. -/
abbrev saysActive : Statement := .parses .energeo galatiansWorking .active

/-- From the passive of an active form, that it is not active: the classic
case. -/
def fromThePassiveOfAnActive : Move := argues [workerPassive] workerNotActive

/-- From the denial of the one voice the form allows, that it is passive: a
misreading too. -/
def denyingTheActive : Move := argues [workerNotActive] workerPassive

/-- From the passive at Galatians 5:6, which the spelling allows, though the
data's tag gives the middle: no misreading. -/
def fromThePassive : Move := argues [saysPassive] loveMovesFaith

/-- From the middle there, which the tag gives. -/
def fromTheMiddle : Move := argues [saysMiddle] faithThroughLove

/-- From the active there, which the spelling rules out. -/
def fromTheActive : Move := argues [saysActive] faithThroughLove

/-- That love is what works faith at Galatians 5:6: the one at work in
ἐνεργουμένη, were it passive. -/
abbrev workedByLove : Statement := .worksBy .energeo galatiansWorking "ἀγάπη"

/-- That God is: J. Armitage Robinson's reading of the passive. -/
abbrev workedByGod : Statement := .worksBy .energeo galatiansWorking "θεός"

/-- From the passive, that love is what works faith. -/
def loveAsWorker : Move := argues [saysPassive] workedByLove

/-- From the passive, that God is. -/
def godAsWorker : Move := argues [saysPassive] workedByGod

/-- From faith working through love, that love moves faith: the means made the
mover. -/
def meansMadeMover : Move := argues [faithThroughLove] loveMovesFaith

/-- From love moving faith, that love moves faith: no reversal, only a premise
restated. -/
def moverKept : Move := argues [loveMovesFaith] loveMovesFaith

/-- **The Greek is read, not assumed, and a means is not made its user's
mover.** The word of Galatians 3:5 is ὁ ἐνεργῶν, a present active participle, and
its spelling allows the active alone: a move from the claim that it is passive
misreads the original, and so does one from the denial that it is active. The
word of Galatians 5:6 is ἐνεργουμένη, whose spelling allows the middle or the
passive, and the data's editors tag it middle: the check reads the letters, not
the tag, so a move from the active misreads it, and moves from the passive and
from the middle do not. Where Paul's spelling makes the verb active, the one at
work is God, the Spirit, the evil spirit or believers, never love: a move
concluding that love works faith reads against his usage, and one concluding
that God does not. A move from faith working through love to love moving faith
reverses cause and effect; one that only restates that love moves faith does
not. -/
theorem misreading_and_reversal_cases :
    galatiansWorker.text = "ἐνεργῶν" ∧ galatiansWorker.formVoices = [.active] ∧
      galatiansWorking.text = "ἐνεργουμένη" ∧ galatiansWorking.voice? = some .middle ∧
      galatiansWorking.formVoices = [.middle, .passive] ∧
      fromThePassiveOfAnActive.misreadings = [workerPassive] ∧
      denyingTheActive.misreadings = [workerNotActive] ∧
      fromThePassive.misreadings = [] ∧ fromTheMiddle.misreadings = [] ∧
      fromTheActive.misreadings = [saysActive] ∧
      loveAsWorker.againstUsages = [workedByLove] ∧ godAsWorker.againstUsages = [] ∧
      fromTheMiddle.againstUsages = [] ∧
      meansMadeMover.reversals = [(wd .agape gal5_6, wd .pistis gal5_6)] ∧
      moverKept.reversals = [] ∧ fromTheMiddle.reversals = [] := by
  decide

end Testimony.Checks.FallacyCases

/-! ### A case the build must refuse

An argument of its own, with a claim type, meanings, and three lines that commit
what `#check_fallacies` fails the build for: one reads "justify" two ways and
needs it one, one argues from silence alone, and one answers a view of Trent's
that the case's own record of Trent contradicts. The check is run over it, and the
failure it reports is pinned. If the check stopped refusing any of them, this
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
  /-- Trent held that a person's own works are not enough for justification. -/
  | trentDeniesOwnWorks
  /-- Trent held that a person's own works are enough for justification. -/
  | trentSaysWorksSuffice
  /-- Works are not enough for justification. -/
  | worksDoNotSuffice
deriving DecidableEq, Repr

/-- Every claim. -/
def all : List Claim :=
  [.romansSays, .jamesSays, .verdictInRomans, .showingInJames, .inconsistent,
    .aloneNotInRomans, .paulDidNotTeach, .trentDeniesOwnWorks, .trentSaysWorksSuffice,
    .worksDoNotSuffice]

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
  | .trentDeniesOwnWorks =>
    .heldBy .trent (.not (rl .sufficientFor (cn .works) (cn .justification)))
  | .trentSaysWorksSuffice => .heldBy .trent (rl .sufficientFor (cn .works) (cn .justification))
  | .worksDoNotSuffice => .holds (.not (rl .sufficientFor (cn .works) (cn .justification)))

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

/-- **Answers a straw man.** Its ground makes Trent say that works are enough,
which the case's own record of Trent denies, and it argues that they are not. -/
def strawMan : Line Claim :=
  { name := "Trent made to say it"
  , grounds := [p .trentSaysWorksSuffice]
  , step := p .trentSaysWorksSuffice ➝ p .worksDoNotSuffice
  , delivers := p .worksDoNotSuffice }

/--
error: lines with an undeclared fault, or a declared finding not borne out, in:
Testimony.Checks.FallacyCases.Refused.Claim
A case the build must refuse
  lines: 3, read: 3, Scripture's own: 0
  declare a finding the checks do not bear out, or commit a fault undeclared:
    contradiction (uncited):
      equivocation on dikaioo; not declared
    fromSilence (uncited):
      argument from the silence of 1 text(s) alone; not declared
    strawMan (uncited):
      straw man of trent, contradicted by trentDeniesOwnWorks; not declared
  read a word in two senses and need it the same:
    contradiction (uncited)
  argue from silence alone:
    fromSilence (uncited)
  answer a view the argument's record says its holder does not hold:
    strawMan (uncited)
  attribute a view, against the argument's record:
    strawMan (uncited): trent, contradicted by trentDeniesOwnWorks
  need a word to keep its sense, unstated:
    contradiction (uncited): pistis
-/
#guard_msgs in
#check_fallacies under Testimony.Checks.FallacyCases.Refused

end Testimony.Checks.FallacyCases.Refused

/-! ### Straw man

The straw-man check needs a record of what each voice holds, so its cases come
with one: five claims, each a voice's position as the library would cite it. Two
are Trent's, one is Augustine's, and two are rival accounts of Second Temple
Judaism, so that the record itself disagrees about what one voice held. -/

namespace Testimony.Checks.FallacyCases.StrawMan

open Testimony Testimony.Semantics Testimony.Semantics.Notation
open Testimony.Checks.FallacyCases (argues rom3_28)

/-- The record's claims. -/
inductive Record
  /-- Trent held that a person's own works are not enough for justification:
  its first canon on justification condemns whoever says a person may be
  justified by their own works without the grace of God through Jesus Christ. -/
  | trentOnOwnWorks
  /-- Works done in grace merit an increase of justification: what Trent's
  position asserts (Session VI, chapter 16). -/
  | trentOnMerit
  /-- Augustine read "justify" as to make righteous. -/
  | augustineOnJustify
  /-- Sanders: Second Temple Judaism did not hold that works earn salvation. -/
  | sandersOnJudaism
  /-- The older picture of rabbinic religion that Sanders argued against, which
  he traced to Ferdinand Weber: works earn salvation. -/
  | olderPicture
deriving DecidableEq, Repr

/-- Every claim of the record. -/
def all : List Record :=
  [.trentOnOwnWorks, .trentOnMerit, .augustineOnJustify, .sandersOnJudaism, .olderPicture]

/-- Works are enough for justification. -/
abbrev worksSuffice : Content := rl .sufficientFor (cn .works) (cn .justification)

/-- Works done in grace merit an increase of justification. -/
abbrev meritInGrace : Content := rl .merits (cn .worksOfFaith) (cn .increaseOfJustification)

/-- Works earn salvation. -/
abbrev worksEarn : Content := rl .merits (cn .works) (cn .salvation)

/-- What each claim of the record means. -/
def means : Record → Statement
  | .trentOnOwnWorks => .heldBy .trent (.not worksSuffice)
  | .trentOnMerit => .holds meritInGrace
  | .augustineOnJustify => .glosses .augustine .dikaioo .makeRighteous
  | .sandersOnJudaism => .denied (.heldBy .secondTempleJudaism worksEarn)
  | .olderPicture => .heldBy .secondTempleJudaism worksEarn

/-- The record's meanings. -/
instance meanings : HasMeanings Record :=
  { argument := "A record for the straw-man cases", all, means
  , complete := by intro a; cases a <;> decide }

/-- **The record, voice by voice**: the claims cited as each voice's position. -/
def record : Voice → List Record
  | .trent => [.trentOnOwnWorks, .trentOnMerit]
  | .augustine => [.augustineOnJustify]
  | .secondTempleJudaism => [.sandersOnJudaism, .olderPicture]
  | _ => []

/-- **Caught: Trent made to say what it condemns.** Trent held that a person's
own works are enough to justify; Romans 3:28 says a person is justified apart
from works of the law; so works are not enough. Trent's first canon condemns the
view the move answers. -/
def ownWorks : Move :=
  argues
    [ .heldBy .trent worksSuffice
    , .says rom3_28 (rl .excludedFrom (wd .ergaNomou rom3_28) (wd .dikaioo rom3_28)) ]
    (.holds (.not worksSuffice))

/-- **Passed over: Trent taken at its word.** Trent held that works done in grace
merit an increase of justification; so, the move concludes, they do not. Whether
the move's grounds are enough is another question; the view it answers is
Trent's. -/
def meritAnswered : Move := argues [.heldBy .trent meritInGrace] (.holds (.not meritInGrace))

/-- **Reported, not charged: Trent cited for what it condemns.** The same false
attribution, leaned on instead of answered: Trent held that works are enough, so
they are. It misattributes, and it answers no one. -/
def citedForItsDenial : Move := argues [.heldBy .trent worksSuffice] (.holds worksSuffice)

/-- **Passed over: what the record disputes.** Second Temple Judaism held that
works earn salvation, and they do not. Sanders denies the attribution, and the
older picture he argued against makes it; the move rests on one side of a
dispute over what Judaism held, and that dispute, not the move, is where it is
weighed. -/
def legalism : Move :=
  argues [.heldBy .secondTempleJudaism worksEarn] (.holds (.not worksEarn))

/-- **Passed over: what the record does not say.** The same attribution to
Aquinas, of whom the record cites nothing. -/
def unrecorded : Move := argues [.heldBy .aquinas worksSuffice] (.holds (.not worksSuffice))

/-- **Passed over: a reading attributed, and borne out.** A move that only
attributes: Augustine read "justify" as to make righteous. -/
def augustineRead : Move :=
  { speaker := "a test case", words := ""
  , act := .attributes .augustine (.glosses .augustine .dikaioo .makeRighteous) }

/-- **The straw-man check, caught and passed over.** The move that makes Trent
say what its first canon condemns, and answers that, is caught. Taken at its
word, Trent is answered fairly. Cited for what it condemns, it is misattributed
but not answered, so the move is reported and not charged with a straw man. An
attribution the record disputes is reported as disputed and not charged; one it
says nothing of is unrecorded; and Augustine's reading of "justify" is borne out
by the record. -/
theorem strawman_cases :
    ownWorks.strawMen record = [(.heldBy .trent worksSuffice, [.trentOnOwnWorks])] ∧
      meritAnswered.attributed record = [(.heldBy .trent meritInGrace, .fair [.trentOnMerit])] ∧
      meritAnswered.strawMen record = [] ∧
      citedForItsDenial.misattributions record =
        [(.heldBy .trent worksSuffice, [.trentOnOwnWorks])] ∧
      citedForItsDenial.strawMen record = [] ∧
      legalism.attributed record =
        [(.heldBy .secondTempleJudaism worksEarn, .disputed [.olderPicture] [.sandersOnJudaism])] ∧
      legalism.strawMen record = [] ∧
      unrecorded.attributed record = [(.heldBy .aquinas worksSuffice, .unrecorded)] ∧
      augustineRead.attributed record =
        [(.glosses .augustine .dikaioo .makeRighteous, .fair [.augustineOnJustify])] := by
  decide

end Testimony.Checks.FallacyCases.StrawMan

/-! ### A move from one word to a kindred one

The word-shift cases. They need no record: whether a move reads one word by a
kindred one is a matter of its own premises and conclusion. -/

namespace Testimony.Checks.FallacyCases.WordShift

open Testimony Testimony.Semantics Testimony.Semantics.Notation
open Testimony.Checks.FallacyCases (argues)

/-- Romans 5:19. -/
@[nolint defsWithUnderscore] abbrev rom5_19 : PassageRange := vs .romans 5 19

/-- **Caught: the verb read by its adjective.** Romans 5:19's "the many will be
made righteous" (δίκαιοι) means made righteous; so Paul's verb "justify"
(δικαιόω) means to make righteous. The move reads the verb by the adjective and
says nothing of whether the one bears on the other. -/
def adjectiveForVerb : Move :=
  argues [.means .dikaios (.passage rom5_19) .makeRighteous]
    (.means .dikaioo (.usage .paul) .makeRighteous)

/-- **Passed over: the same, with the bridge stated.** A premise says the
adjective in 5:19 bears the sense the verb has in Paul. Whether it does is
disputed; stated, it can be weighed. -/
def adjectiveBridged : Move :=
  argues
    [ .means .dikaios (.passage rom5_19) .makeRighteous
    , .bears .dikaios (.passage rom5_19) .dikaioo (.usage .paul) ]
    (.means .dikaioo (.usage .paul) .makeRighteous)

/-- **Caught: the Greek read by the Latin.** The Latin West read *iustificare* as
to make righteous; so Paul's δικαιόω means that. -/
def latinForGreek : Move :=
  argues [.glosses .latinWest .iustificare .makeRighteous]
    (.means .dikaioo (.usage .paul) .makeRighteous)

/-- **Passed over: a word and its own family member, both in the premises.** A
move that has the verb itself where it concludes, beside its adjective, does not
read the one by the other: it has the verb's own evidence. -/
def verbItself : Move :=
  argues
    [ .means .dikaios (.passage rom5_19) .makeRighteous
    , .means .dikaioo (.usage .paul) .verdict ]
    (.denied (.means .dikaioo (.usage .paul) .makeRighteous))

/-- **The word-shift check, caught and passed over.** The verb read by its
adjective, and the Greek by the Latin, are each reported as an unstated shift;
with the bridge stated, the shift is granted; and a move that has the verb's own
evidence makes no shift at all. -/
theorem wordshift_cases :
    adjectiveForVerb.unbridged = [(.dikaios, .dikaioo, .cognate)] ∧
      adjectiveBridged.wordShifts = [(.dikaios, .dikaioo, .cognate, .granted)] ∧
      adjectiveBridged.unbridged = [] ∧
      latinForGreek.unbridged = [(.iustificare, .dikaioo, .translation)] ∧
      verbItself.shifts = [] := by
  decide

/-- **Caught: the verb's sense drawn from the doctrine.** God's verdict brings
about the sinner's renewal; Paul's verb is a verdict; so the verb means to make
righteous. No premise gives the verb, or any word of its kin, that sense: it
comes from a claim about what God does. -/
def senseFromDoctrine : Move :=
  argues
    [ .holds (rl .effects (cn .justification) (cn .sanctification))
    , .means .dikaioo (.usage .paul) .verdict ]
    (.means .dikaioo (.usage .paul) .makeRighteous)

/-- **A sense from elsewhere, caught and passed over.** The sense drawn from a
doctrine is reported. A sense read from a kindred word, from a voice's reading of
the word, or from the word itself is not: each has the sense from a word. -/
theorem elsewhere_cases :
    senseFromDoctrine.sensesFromElsewhere = [(.dikaioo, .usage .paul, .makeRighteous)] ∧
      adjectiveForVerb.sensesFromElsewhere = [] ∧
      latinForGreek.sensesFromElsewhere = [] ∧
      verbItself.sensesFromElsewhere = [] := by
  decide

end Testimony.Checks.FallacyCases.WordShift

/-! ### Leaving out what a voice also said -/

namespace Testimony.Checks.FallacyCases.Omission

open Testimony Testimony.Semantics Testimony.Semantics.Notation
open Testimony.Checks.FallacyCases (argues)

/-- A record of how Augustine read "justify", for the omission cases. -/
inductive Record
  /-- Augustine read "being justified" both ways: as being made righteous, and as
  being deemed righteous. -/
  | augustineBothWays
  /-- Augustine read "being justified" as being made righteous. -/
  | augustineMakeRighteous
deriving DecidableEq, Repr

/-- The record's meanings. -/
instance meanings : HasMeanings Record :=
  { argument := "A record for the omission cases"
  , all := [.augustineBothWays, .augustineMakeRighteous]
  , means := fun
      | .augustineBothWays =>
        .also (.glosses .augustine .dikaioo .makeRighteous)
          (.glosses .augustine .dikaioo .verdict)
      | .augustineMakeRighteous => .glosses .augustine .dikaioo .makeRighteous
  , complete := by intro a; cases a <;> decide }

/-- A record in which Augustine read the word both ways. -/
def bothWays : Voice → List Record
  | .augustine => [.augustineBothWays]
  | _ => []

/-- A record in which Augustine read it one way only. -/
def oneWay : Voice → List Record
  | .augustine => [.augustineMakeRighteous]
  | _ => []

/-- Augustine read "justify" as to make righteous; so Paul's word means that. -/
def citedForOne : Move :=
  argues [.glosses .augustine .dikaioo .makeRighteous]
    (.means .dikaioo (.usage .paul) .makeRighteous)

/-- The same move, citing both of Augustine's readings. -/
def citedForBoth : Move :=
  argues
    [ .glosses .augustine .dikaioo .makeRighteous
    , .glosses .augustine .dikaioo .verdict ]
    (.means .dikaioo (.usage .paul) .makeRighteous)

/-- **The omission check, caught and passed over.** Against a record in which
Augustine read the word both ways, a move citing one reading leaves out the
other, and the check says which and where the record has it. A move citing both
leaves nothing out, and against a record of one reading only, the first move
leaves nothing out either. -/
theorem omission_cases :
    citedForOne.omissions bothWays =
        [(.glosses .augustine .dikaioo .makeRighteous, [(.verdict, [.augustineBothWays])])] ∧
      citedForBoth.omissions bothWays = [] ∧
      citedForOne.omissions oneWay = [] := by
  decide

end Testimony.Checks.FallacyCases.Omission

/-! ### Univocality

The univocality check reads a move against an argument's readings of a word, so
its cases come with a small record of readings of "justify" (δικαιόω): one of
James 2:24, one of Paul's usage as a whole, one reading both letters alike, and
the authorship that lets a reading of Paul's usage bear on Romans. -/

namespace Testimony.Checks.FallacyCases.Univocality

open Testimony Testimony.Semantics Testimony.Semantics.Notation
open Testimony.Checks.FallacyCases (argues rom3_28 jas2_24)

/-- The readings. -/
inductive Reading
  /-- In James 2:24, "justify" means to show to be righteous. -/
  | jamesShows
  /-- In Paul's usage, "justify" means a verdict. -/
  | paulVerdict
  /-- In Romans 3:28 and in James 2:24 alike, "justify" means to make righteous. -/
  | bothMakeRighteous
  /-- In James 2:24, "justify" means to make righteous. -/
  | jamesMakes
  /-- Paul wrote Romans. -/
  | romansIsPauline
deriving DecidableEq, Repr

/-- What each reading means. -/
def means : Reading → Statement
  | .jamesShows => .means .dikaioo (.passage jas2_24) .showRighteous
  | .paulVerdict => .means .dikaioo (.usage .paul) .verdict
  | .bothMakeRighteous =>
    .also (.means .dikaioo (.passage rom3_28) .makeRighteous)
      (.means .dikaioo (.passage jas2_24) .makeRighteous)
  | .jamesMakes => .means .dikaioo (.passage jas2_24) .makeRighteous
  | .romansIsPauline => .wrote .paul .romans

/-- The readings' meanings. -/
instance meanings : HasMeanings Reading :=
  { argument := "A record for the univocality cases"
  , all := [.jamesShows, .paulVerdict, .bothMakeRighteous, .jamesMakes, .romansIsPauline]
  , means
  , complete := by intro a; cases a <;> decide }

/-- A record that reads the word differently in the two letters. -/
def apart : List Reading := [.jamesShows, .paulVerdict, .romansIsPauline]

/-- A record whose only reading gives the word one sense in both letters. -/
def alike : List Reading := [.bothMakeRighteous]

/-- Romans 3:28 says a person is justified by faith apart from works of the law. -/
abbrev romansSays : Statement :=
  .says rom3_28 (rl .instrumentOf (wd .pistis rom3_28) (wd .dikaioo rom3_28))

/-- James 2:24 says a person is justified by works and not by faith alone. -/
abbrev jamesSays : Statement :=
  .says jas2_24 (.not (rl .instrumentOf (wd .pistis jas2_24) (wd .dikaioo jas2_24)))

/-- **Caught: James set against Paul, the word granted one sense.** Romans 3:28
and James 2:24 are set against each other, with a premise that "justify" is the
same in both. Against a record that reads it as "show to be righteous" in James and
as a verdict in Paul, the premise is a ground no reading supports, and the move
answers neither reading. -/
def setAgainst : Move :=
  argues [romansSays, jamesSays, .sameSense .dikaioo (.passage rom3_28) (.passage jas2_24)]
    (.holds (.not (rl .instrumentOf (wd .pistis rom3_28) (wd .dikaioo rom3_28))))

/-- **Caught: the same, the sameness left unstated.** -/
def setAgainstSilently : Move :=
  argues [romansSays, jamesSays]
    (.holds (.not (rl .instrumentOf (wd .pistis rom3_28) (wd .dikaioo rom3_28))))

/-- **Passed over: the reading of James answered.** The same move, with a premise
denying that "justify" in James 2:24 means to show to be righteous. Whether the
denial is right is the dispute's to weigh; the move has met the reading. -/
def jamesAnswered : Move :=
  argues
    [ romansSays, jamesSays, .sameSense .dikaioo (.passage rom3_28) (.passage jas2_24)
    , .denied (.means .dikaioo (.passage jas2_24) .showRighteous) ]
    (.holds (.not (rl .instrumentOf (wd .pistis rom3_28) (wd .dikaioo rom3_28))))

/-- **The univocality check, caught and passed over.** Against readings that give
"justify" one sense in James and another in Paul, a move needing it the same is
charged with both readings, whether it grants the sameness or leaves it unstated.
A move that denies the reading of James has answered it, and the reading of Paul
then stands against nothing given at James. Against a record whose only reading
makes the word one in both letters, nothing is charged: that reading disputes the
sense, not the sameness. The survey of "justify" in Matthew and Deuteronomy
needs James's word to share a sense with one of them, and the reading of James
as "show to be righteous" gives it Matthew's, so the survey is not charged; a
reading of James as "make righteous" is the very sense its conclusion denies of
James's usage, so it is answered. The move concluding that "works" differs needs
no sameness, and the move that reads "faith" two ways is charged with
equivocation, not with this. -/
theorem univocality_cases :
    setAgainst.univocal apart = [(.dikaioo, [.paulVerdict, .jamesShows])] ∧
      setAgainstSilently.univocal apart = [(.dikaioo, [.paulVerdict, .jamesShows])] ∧
      jamesAnswered.univocal apart = [] ∧
      setAgainst.univocal alike = [] ∧
      FallacyCases.survey.univocal apart = [] ∧
      FallacyCases.survey.univocal [Reading.jamesMakes] = [] ∧
      FallacyCases.worksDiffer.univocal apart = [] ∧
      FallacyCases.thatFaith.univocal apart = [] := by
  decide

end Testimony.Checks.FallacyCases.Univocality

/-! ### Scripture's own reasoning, never charged

The checks read lines of reason, and a line of reason is someone's. Most are a
reader's: Trent's, Calvin's, Moo's, each line's step cited to the work that draws
it. Some set out Scripture's own reasoning, as Paul reasons in Romans 4:3–5 from
Genesis 15:6: "Abraham believed God, and it was counted to him as righteousness",
so "to the one who does not work but believes … his faith is counted as
righteousness". A step cited to Scripture itself is never charged. If the line
needs "counted" (λογίζομαι) to keep one sense from Genesis to Romans, that need
falls on the reader: it is what a reader must hold to follow the text, and the
report sets it apart from the findings against readers.

This case pins both. The same line is set out twice, once cited to Scripture and
once proposed as a reader's line. The first is reported as Scripture's own
reasoning, with what it asks of a reader; the second is listed with the
conditions readers' lines are held to. -/

namespace Testimony.Checks.FallacyCases.Scriptural

open Testimony Testimony.Logic Testimony.Semantics Testimony.Semantics.Notation
open Testimony.Checks.FallacyCases (rom4_5)

/-- Genesis 15:6. -/
@[nolint defsWithUnderscore] abbrev gen15_6 : PassageRange := vs .genesis 15 6

/-- The case's atomic claims. -/
inductive Claim
  /-- Genesis 15:6 says Abraham's believing was counted to him as righteousness. -/
  | genesisSays
  /-- Romans 4:5 says the believer's faith is counted as righteousness. -/
  | romansSays
deriving DecidableEq, Repr

/-- Every claim. -/
def all : List Claim := [.genesisSays, .romansSays]

/-- What each claim means. -/
def means : Claim → Statement
  | .genesisSays => .says gen15_6 (rl .instrumentOf (wd .pisteuo gen15_6) (wd .logizomai gen15_6))
  | .romansSays => .says rom4_5 (rl .instrumentOf (wd .pistis rom4_5) (wd .logizomai rom4_5))

/-- The case's meanings. -/
instance meanings : HasMeanings Claim :=
  { argument := "Scripture's own reasoning", all, means
  , complete := by intro a; cases a <;> decide }

/-- **Paul's own reasoning, from Genesis to Romans**, cited to Scripture itself
(Romans 4:3–5). -/
def paulFromGenesis : Line Claim :=
  { name := "Paul, from Genesis 15:6"
  , grounds := [p .genesisSays]
  , step := p .genesisSays ➝ p .romansSays
  , delivers := p .romansSays
  , inference := some
      { primary := .scripture [{ ref := vs .romans 4 3 }, { ref := rom4_5 }]
      , tradition := .christianHistoricalGrammatical
      , confidence := .consensus } }

/-- **The same line, as a reader's**: proposed here, not cited to Scripture. -/
def aReaderFromGenesis : Line Claim :=
  { paulFromGenesis with
    inference := some
      { primary := .proposal "the same step, set out as a reader's line, for contrast"
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/--
info: the fallacy checks, over every argument's lines, each named with its reader:
Scripture's own reasoning
  lines: 2, read: 2, Scripture's own: 1
  need a word to keep its sense, unstated:
    aReaderFromGenesis (proposed here): logizomai
  read one word by a kindred one, the bridge unstated:
    aReaderFromGenesis (proposed here): pisteuo for pistis (cognate)
  Scripture's own reasoning, not charged: what a reader must hold to follow it:
    paulFromGenesis (Scripture): logizomai kept in one sense, pisteuo for pistis (cognate)
-/
#guard_msgs in
#check_fallacies under Testimony.Checks.FallacyCases.Scriptural

end Testimony.Checks.FallacyCases.Scriptural

/-! ### Declared findings

A rival's step may commit one of the faults above if it says so, next to the
step, with the witness (`Testimony.Semantics.Finding`). The check then runs both
ways. First, on moves: a declaration borne out exactly leaves nothing to report;
one the move does not bear out, or bears out with another witness, is reported;
so is a fault left undeclared, and a kind declared twice. -/

namespace Testimony.Checks.FallacyCases.StrawMan

open Testimony Testimony.Semantics Testimony.Semantics.Notation

/-- Trent made to say what it condemns, and answered: the straw man as the
check finds it. -/
abbrev ownWorksStrawMan : Finding Record :=
  .strawMan [(.heldBy .trent worksSuffice, [.trentOnOwnWorks])]

/-- **Declarations, borne out and not.** The straw man declared as found leaves
nothing. Declared with no contradicting claim, it differs from what is found.
Declared on Trent taken at his word, it is absent. Left undeclared, it is
reported. Declared twice, the second is reported. -/
theorem declared_cases :
    ownWorks.mismatches record [] [ownWorksStrawMan] = [] ∧
      ownWorks.mismatches record [] [.strawMan [(.heldBy .trent worksSuffice, [])]] =
        [.differs (.strawMan [(.heldBy .trent worksSuffice, [])]) ownWorksStrawMan] ∧
      meritAnswered.mismatches record [] [ownWorksStrawMan] = [.absent ownWorksStrawMan] ∧
      ownWorks.mismatches record [] [] = [.undeclared ownWorksStrawMan] ∧
      ownWorks.mismatches record [] [ownWorksStrawMan, ownWorksStrawMan] =
        [.twice ownWorksStrawMan] := by
  decide

end Testimony.Checks.FallacyCases.StrawMan

/-! Then on lines, through `#check_fallacies`. A line declares its findings as
`expected`, a definition beside it named for the line. Two lines commit the
faults the refused case commits, and declare them: the build passes, and the
report says each commits what it declares, as declared. -/

namespace Testimony.Checks.FallacyCases.Declared

open Testimony Testimony.Logic Testimony.Semantics Testimony.Semantics.Notation
open Testimony.Checks.FallacyCases (rom3_28)

/-- The case's atomic claims. -/
inductive Claim
  /-- The word "alone" is not in Romans 3:28. -/
  | aloneNotInRomans
  /-- Paul did not teach that faith is the only means of justification. -/
  | paulDidNotTeach
  /-- Trent held that a person's own works are not enough for justification. -/
  | trentDeniesOwnWorks
  /-- Trent held that a person's own works are enough for justification. -/
  | trentSaysWorksSuffice
  /-- Works are not enough for justification. -/
  | worksDoNotSuffice
deriving DecidableEq, Repr

/-- Every claim. -/
def all : List Claim :=
  [.aloneNotInRomans, .paulDidNotTeach, .trentDeniesOwnWorks, .trentSaysWorksSuffice,
    .worksDoNotSuffice]

/-- Works are enough for justification. -/
abbrev worksSuffice : Content := rl .sufficientFor (cn .works) (cn .justification)

/-- What each claim means. -/
def means : Claim → Statement
  | .aloneNotInRomans => .denied (.occurs .monos rom3_28)
  | .paulDidNotTeach =>
    .denied (.heldBy .paul (rl .soleInstrumentOf (cn .faith) (cn .justification)))
  | .trentDeniesOwnWorks => .heldBy .trent (.not worksSuffice)
  | .trentSaysWorksSuffice => .heldBy .trent worksSuffice
  | .worksDoNotSuffice => .holds (.not worksSuffice)

/-- The case's meanings. -/
instance meanings : HasMeanings Claim :=
  { argument := "Faults declared where they are committed", all, means
  , complete := by intro a; cases a <;> decide }

/-- **Argues from silence alone, and says so.** -/
def fromSilence : Line Claim :=
  { name := "Not in the verse"
  , grounds := [p .aloneNotInRomans]
  , step := p .aloneNotInRomans ➝ p .paulDidNotTeach
  , delivers := p .paulDidNotTeach }

/-- The silence `fromSilence` argues from, declared. -/
def fromSilence.expected : List (Finding Claim) :=
  [.fromSilence [.occurs .monos rom3_28]]

/-- **Answers a straw man, and says so.** -/
def strawMan : Line Claim :=
  { name := "Trent made to say it"
  , grounds := [p .trentSaysWorksSuffice]
  , step := p .trentSaysWorksSuffice ➝ p .worksDoNotSuffice
  , delivers := p .worksDoNotSuffice }

/-- The straw man `strawMan` answers, declared with the claim that contradicts
it. -/
def strawMan.expected : List (Finding Claim) :=
  [.strawMan [(.heldBy .trent worksSuffice, [.trentDeniesOwnWorks])]]

/--
info: the fallacy checks, over every argument's lines, each named with its reader:
Faults declared where they are committed
  lines: 2, read: 2, Scripture's own: 0
  commit what they declare, as declared:
    fromSilence (uncited): argument from the silence of 1 text(s) alone
    strawMan (uncited): straw man of trent, contradicted by trentDeniesOwnWorks
  argue from silence alone:
    fromSilence (uncited)
  answer a view the argument's record says its holder does not hold:
    strawMan (uncited)
  attribute a view, against the argument's record:
    strawMan (uncited): trent, contradicted by trentDeniesOwnWorks
-/
#guard_msgs in
#check_fallacies under Testimony.Checks.FallacyCases.Declared

end Testimony.Checks.FallacyCases.Declared

/-! And the declarations the build must refuse: one the line does not bear out,
one with another witness than the line's, and one on a step the library proposes
itself, which may never commit what the library checks others for. -/

namespace Testimony.Checks.FallacyCases.Misdeclared

open Testimony Testimony.Logic Testimony.Semantics Testimony.Semantics.Notation
open Testimony.Checks.FallacyCases (rom3_28)

/-- The case's atomic claims. -/
inductive Claim
  /-- The word "alone" is not in Romans 3:28. -/
  | aloneNotInRomans
  /-- Paul did not teach that faith is the only means of justification. -/
  | paulDidNotTeach
  /-- Trent held that a person's own works are not enough for justification. -/
  | trentDeniesOwnWorks
  /-- Trent held that a person's own works are enough for justification. -/
  | trentSaysWorksSuffice
  /-- Works are not enough for justification. -/
  | worksDoNotSuffice
deriving DecidableEq, Repr

/-- Every claim. -/
def all : List Claim :=
  [.aloneNotInRomans, .paulDidNotTeach, .trentDeniesOwnWorks, .trentSaysWorksSuffice,
    .worksDoNotSuffice]

/-- Works are enough for justification. -/
abbrev worksSuffice : Content := rl .sufficientFor (cn .works) (cn .justification)

/-- What each claim means. -/
def means : Claim → Statement
  | .aloneNotInRomans => .denied (.occurs .monos rom3_28)
  | .paulDidNotTeach =>
    .denied (.heldBy .paul (rl .soleInstrumentOf (cn .faith) (cn .justification)))
  | .trentDeniesOwnWorks => .heldBy .trent (.not worksSuffice)
  | .trentSaysWorksSuffice => .heldBy .trent worksSuffice
  | .worksDoNotSuffice => .holds (.not worksSuffice)

/-- The case's meanings. -/
instance meanings : HasMeanings Claim :=
  { argument := "Declarations the build must refuse", all, means
  , complete := by intro a; cases a <;> decide }

/-- **Argues from silence, and declares a straw man instead.** The straw man is
absent, and the silence is undeclared. -/
def wrongKind : Line Claim :=
  { name := "Not in the verse"
  , grounds := [p .aloneNotInRomans]
  , step := p .aloneNotInRomans ➝ p .paulDidNotTeach
  , delivers := p .paulDidNotTeach }

/-- A straw man `wrongKind` does not answer. -/
def wrongKind.expected : List (Finding Claim) :=
  [.strawMan [(.heldBy .trent worksSuffice, [.trentDeniesOwnWorks])]]

/-- **Answers a straw man, and declares it with no contradicting claim.** -/
def wrongWitness : Line Claim :=
  { name := "Trent made to say it"
  , grounds := [p .trentSaysWorksSuffice]
  , step := p .trentSaysWorksSuffice ➝ p .worksDoNotSuffice
  , delivers := p .worksDoNotSuffice }

/-- The straw man `wrongWitness` answers, with the wrong witness. -/
def wrongWitness.expected : List (Finding Claim) :=
  [.strawMan [(.heldBy .trent worksSuffice, [])]]

/-- **The library's own step, declaring the straw man it answers.** -/
def ownStep : Line Claim :=
  { name := "Trent made to say it, by the library"
  , grounds := [p .trentSaysWorksSuffice]
  , step := p .trentSaysWorksSuffice ➝ p .worksDoNotSuffice
  , delivers := p .worksDoNotSuffice
  , inference := some
      { primary := .proposal "a test case: the library may not commit a straw man"
      , tradition := .reformedProtestant, confidence := .disputed } }

/-- The straw man `ownStep` answers, declared as found. -/
def ownStep.expected : List (Finding Claim) :=
  [.strawMan [(.heldBy .trent worksSuffice, [.trentDeniesOwnWorks])]]

/--
error: lines with an undeclared fault, or a declared finding not borne out, in:
Testimony.Checks.FallacyCases.Misdeclared.Claim
Declarations the build must refuse
  lines: 3, read: 3, Scripture's own: 0
  declare a finding the checks do not bear out, or commit a fault undeclared:
    wrongKind (uncited):
      declares straw man of trent, contradicted by trentDeniesOwnWorks; not found
      argument from the silence of 1 text(s) alone; not declared
    wrongWitness (uncited):
      declares straw man of trent, contradicted by nothing,
        but finds straw man of trent, contradicted by trentDeniesOwnWorks
  declare a finding where no declaration may go:
    ownStep: on the library's own step
  argue from silence alone:
    wrongKind (uncited)
  answer a view the argument's record says its holder does not hold:
    ownStep (proposed here)
    wrongWitness (uncited)
  attribute a view, against the argument's record:
    ownStep (proposed here): trent, contradicted by trentDeniesOwnWorks
    wrongWitness (uncited): trent, contradicted by trentDeniesOwnWorks
-/
#guard_msgs in
#check_fallacies under Testimony.Checks.FallacyCases.Misdeclared

end Testimony.Checks.FallacyCases.Misdeclared
