import Testimony.Semantics.Discourse
import Testimony.Logic.Line
import Testimony.Logic.Tactic

/-!
# Testimony.Semantics.Fallacy — three charges, checked move by move

**A draft.** In a debate the charge comes quickly: "that's an equivocation",
"you're begging the question", "that's an argument from silence". Each names a
real way an argument can fail, and each is often made against an argument that
does not commit it. This module makes the three charges precise enough to check,
one move of an argument at a time, against what the move's words mean
(`Testimony.Semantics.Grammar`) and what the shared definitions commit a reader
to (`Testimony.Ontology.shared`).

None of the checks returns a bare "fallacy". Each says which premise, stated or
not, the move turns on, and what the library holds about it. That is the
difference between a charge and a finding.

## Equivocation

An equivocation is an argument that uses one word in two senses and relies on
it meaning the same throughout. Two texts conflict only if their shared words
are taken in the same senses, so an argument that sets one text against another
assumes, for each word they share, that it keeps its sense.

What matters is where the word is *used*, not where it is talked about. A word
is used inside what a text says or teaches, what a reader held, or what is held
to be so; it is talked about in a claim of what the word means. An argument that
gathers what a word means in Matthew and in Deuteronomy is a survey of the word,
and needs the two places no more alike than a dictionary needs its entries
alike. So a move needs a word the same between two places when it is used at
one of them, or the move concludes what it means at one of them, and not
between two places where its premises only report the word's sense
(`Move.needs`). For each such word the move stands in one of three ways
(`Sameness`):

- **granted** — a premise says the word keeps its sense, so the move is
  answerable for that premise and nothing is hidden;
- **read apart** — the move's own statements give the word one sense at one
  place and a different sense at the other, and the inference still needs them
  the same. That is an equivocation on the move's own terms;
- **unstated** — the move neither says nor denies it. The move is then
  *conditional* on the word keeping its sense: not fallacious, but no stronger
  than that condition, which the library's own disputes may rate.

## Begging the question

An argument begs the question when a premise already asserts what it concludes,
so that only a reader who grants the conclusion would grant the premise. Two
claims written differently can say the same thing, so the check is not a
comparison of words. A premise **carries** the conclusion when, read for what
its words mean under the shared definitions, it entails the conclusion or cannot
be held together with its denial (`Statement.carries`). "Faith is the only means
of justification", offered as a premise for "baptism is not a means of
justification", carries it by what "only" means.

Whether a premise that carries the conclusion begs the question depends on who
the argument is addressed to. If no one denies it, the move only restates
itself. If the very readers who deny the conclusion deny the premise, the move
assumes what it was meant to show them (`Move.begsAgainst`). Across a whole
article the same check finds a circle: a move that rests on what a later move
concludes from it (`circular`).

## Argument from silence

An argument from silence reasons from what a text does not say to the claim
that something was not so: the word is not in the verse, so the doctrine is not
in the verse's author. Such an argument is not always weak. It holds when the
text would have said the thing had it been so, and that **expectation** is the
premise it needs (`Statement.expects`). With it, the argument is a valid
modus tollens; without it, the silence is compatible with what the move denies,
and the conclusion does not follow (`silence_needs_its_expectation`). So the
check reports, for each silence a move argues from, whether it states the
expectation (`Silence`). An expectation stated is then a premise like any other,
which the library's claims may deny (`Move.against`).

## What none of this decides

None of the checks says whether a premise is true. A move that equivocates
on its own terms may have a sound argument nearby that does not; a premise that
carries the conclusion may be true; an expectation may be well grounded. The
checks report where the move's weight falls. What holds the weight up is weighed
where the library weighs everything else, in its disputes.
-/

namespace Testimony.Semantics

/-! ### What a move argues from -/

namespace Move

/-- The move's premises, if it argues. -/
def premises (m : Move) : List Statement :=
  match m.act with
  | .argues ps _ => ps
  | _ => []

/-- The move's conclusion, if it argues. -/
def conclusion? (m : Move) : Option Statement :=
  match m.act with
  | .argues _ c => some c
  | _ => none

/-- Every statement of the move that argues: its premises and its conclusion. -/
def statements (m : Move) : List Statement := m.premises ++ m.conclusion?.toList

end Move

/-! ### Equivocation -/

namespace Statement

/-- **Where a statement uses a word**: inside what a text says, teaches or is
written against, what a voice held, or what is held to be so, and in either half
of an expectation. Not where the statement says what the word means, or that it
occurs: there the word is talked about, not used. -/
def uses : Statement → List (Lexeme × Scope)
  | .says _ c | .teaches _ c | .opposes _ c | .heldBy _ c | .holds c => c.words
  | .denied s => s.uses
  | .also s t | .expects s t => s.uses ++ t.uses
  | _ => []

/-- **Where a statement says what a word means**, affirmed or denied. -/
def sensePlaces : Statement → List (Lexeme × Scope)
  | .means w sc _ => [(w, sc)]
  | .denied s => s.sensePlaces
  | .also s t => s.sensePlaces ++ t.sensePlaces
  | _ => []

end Statement

/-- **How a move stands to one sameness of sense it needs.** -/
inductive Sameness
  /-- A premise says the word keeps its sense between the two places. -/
  | granted
  /-- The move's own statements give the word these senses at the first place
  and those at the second, with none in common, and the move still needs the
  word the same at both. -/
  | readApart (here there : List Sense)
  /-- The move neither says nor denies that the word keeps its sense. -/
  | unstated
deriving DecidableEq, Repr

namespace Move

/-- The senses the move's own statements give a word at one place. -/
def sensesAt (m : Move) (w : Lexeme) (sc : Scope) : List Sense :=
  ((m.statements.flatMap Statement.senses).filterMap fun (w', sc', s) =>
    if w' = w ∧ sc' = sc then some s else none).eraseDups

/-- Whether a premise, read for what its words mean, states that a word keeps
its sense between two places, in either order. -/
def establishesSameness (m : Move) (w : Lexeme) (a b : Scope) : Bool :=
  m.premises.any fun s =>
    (Ontology.closed Testimony.Ontology.shared s).lits.contains ⟨true, .sameSense w a b⟩

/-- The word, if any, whose sameness the move concludes: a move concluding that
a word does or does not keep its sense assumes nothing about that word. -/
def concludedWord? (m : Move) : Option Lexeme :=
  match m.conclusion? with
  | some (.sameSense w _ _) | some (.denied (.sameSense w _ _)) => some w
  | _ => none

/-- **The samenesses of sense a move needs**: each word, and each two places
where the move uses it or concludes its sense, or where it uses it at one place
and its premises report its sense at the other. Two places where the premises
only report its sense are a survey of the word, and need nothing of each other.
A word whose sameness is what the move concludes is left out. -/
def needs (m : Move) : List (Lexeme × Scope × Scope) :=
  let used := m.statements.flatMap Statement.uses ++
    (m.conclusion?.map Statement.sensePlaces).getD []
  let reported := (m.premises.flatMap Statement.sensePlaces).filter (!used.contains ·)
  let pairs := used.flatMap fun (w, a) => (used ++ reported).filterMap fun (w', b) =>
    if w = w' ∧ a ≠ b then some (w, a, b) else none
  (pairsOnce pairs).filter fun (w, _, _) => m.concludedWord? != some w

/-- How the move stands to one sameness it needs; see `Sameness`. A word read
apart is reported as such even if a premise also says it keeps its sense: the
move then contradicts itself, which is worse, not better. -/
def sameness (m : Move) (w : Lexeme) (a b : Scope) : Sameness :=
  let here := m.sensesAt w a
  let there := m.sensesAt w b
  if !here.isEmpty && !there.isEmpty && here.all (!there.contains ·) then .readApart here there
  else if m.establishesSameness w a b then .granted
  else .unstated

/-- **The equivocation check**: every sameness of sense the move needs, and how
it stands to each. -/
def equivocation (m : Move) : List (Lexeme × Scope × Scope × Sameness) :=
  m.needs.map fun (w, a, b) => (w, a, b, m.sameness w a b)

/-- **Where the move equivocates on its own terms**: the words it reads in two
senses and needs the same. -/
def equivocates (m : Move) : List Lexeme :=
  (m.equivocation.filterMap fun
    | (w, _, _, .readApart _ _) => some w
    | _ => none).eraseDups

/-- The words whose sameness the move needs and leaves unstated: the conditions
it holds on. -/
def conditionalOn (m : Move) : List Lexeme :=
  (m.equivocation.filterMap fun
    | (w, _, _, .unstated) => some w
    | _ => none).eraseDups

end Move

/-! ### Begging the question -/

namespace Statement

/-- **Whether one meaning already asserts another**: read for what its words
mean under the shared definitions, it entails the other, or it cannot be held
together with the other's denial. A statement carries itself; a passage that
says a thing does not carry the thing, because what a text says is kept whole
(`Testimony.Semantics.Ontology`). -/
def carries (s t : Statement) : Bool := s.entails t || s.excludes (.denied t)

end Statement

namespace Move

/-- **The premises that already assert the conclusion.** -/
def carriers (m : Move) : List Statement :=
  match m.conclusion? with
  | some c => m.premises.filter (·.carries c)
  | none => []

end Move

/-- **One move rests on another**: what the first concludes carries a premise of
the second. -/
def Move.feeds (m n : Move) : Bool :=
  match m.conclusion? with
  | some c => n.premises.any c.carries
  | none => false

/-- What can be reached from each move by following `feeds`, in as many rounds as
there are moves. -/
def reaches (ms : List Move) : List (Nat × List Nat) :=
  let idx := List.range ms.length
  let feeds (i j : Nat) : Bool :=
    match ms[i]?, ms[j]? with
    | some m, some n => m.feeds n
    | _, _ => false
  let start := idx.map fun i => (i, idx.filter (feeds i))
  idx.foldl (fun r _ => r.map fun (i, js) =>
    (i, (js ++ js.flatMap fun j => (r.lookup j).getD []).eraseDups)) start

/-- **The moves on a circle**: each move that rests, through other moves of the
same article, on what it concludes itself. Numbered from 0, in the article's
order. -/
def circular (ms : List Move) : List Nat :=
  (reaches ms).filterMap fun (i, js) => if js.contains i then some i else none

/-! ### Argument from silence -/

namespace Statement

/-- **What a premise is silent about**: the textual claim it denies — that a
passage says a thing, teaches it, or has a word. -/
def silentOn : Statement → Option Statement
  | .denied t@(.says ..) | .denied t@(.teaches ..) | .denied t@(.occurs ..) => some t
  | _ => none

/-- **What a conclusion denies**: the statement under its denial, read so that
"it is not so that A" and "not A, held" are one. -/
def deniedPart : Statement → Option Statement
  | .denied s => some s
  | .holds (.not c) => some (.holds c)
  | _ => none

end Statement

/-- **How a move stands to one silence it argues from.** -/
inductive Silence
  /-- A premise states the expectation: had the denied thing been so, the text
  would have said it. The move is then valid, and the expectation is the premise
  it rests on. -/
  | expected
  /-- No premise states the expectation. The silence is compatible with what
  the move denies, and the conclusion does not follow from it. -/
  | unexpected
deriving DecidableEq, Repr

namespace Move

/-- Whether a premise states that, were `s` so, `t` would be. -/
def expects (m : Move) (s t : Statement) : Bool :=
  m.premises.any fun
    | .expects s' t' => t' == t && s'.shape == s.shape
    | _ => false

/-- **The argument-from-silence check**: for each premise denying that a text
says a thing, when the move concludes that something else is not so, the text's
silence, what the move denies from it, and whether it states the expectation
that joins the two. -/
def silences (m : Move) : List (Statement × Statement × Silence) :=
  match m.conclusion?.bind Statement.deniedPart with
  | none => []
  | some s => m.premises.filterMap fun pr =>
    match pr.silentOn with
    | some t =>
      if t.shape == s.shape then none
      else some (t, s, if m.expects s t then .expected else .unexpected)
    | none => none

/-- The silences the move argues from without the expectation that would carry
it. -/
def fromSilenceAlone (m : Move) : List Statement :=
  m.silences.filterMap fun
    | (t, _, .unexpected) => some t
    | _ => none

end Move

/-! ### The whole move, against an argument

The three checks above read the move alone. The next questions are about the
library: for each premise of the move, stated or made explicit, which of an
argument's claims deny it. -/

namespace Move

variable {α : Type} [HasMeanings α]

/-- **Who in an argument denies a statement**: the claims whose meanings cannot
be held with it, under the shared definitions. -/
def deniersOf (s : Statement) : List α :=
  (HasMeanings.all : List α).filter fun a => (HasMeanings.means a).excludes s

/-- **Each premise of the move, against an argument**: the premises some claim of
the argument denies, with those claims. A premise no claim denies is left out:
the argument has nothing to say against it. -/
def against (m : Move) : List (Statement × List α) :=
  m.premises.filterMap fun s =>
    match deniersOf (α := α) s with
    | [] => none
    | cs => some (s, cs)

/-- **Whom the move begs the question against**: for each premise that already
asserts the conclusion, the argument's claims that deny that premise. A premise
that carries the conclusion and is denied by no one only restates it; one denied
by the claims that deny the conclusion assumes what the move was to show them. -/
def begsAgainst (m : Move) : List (Statement × List α) :=
  m.carriers.filterMap fun s =>
    match deniersOf (α := α) s with
    | [] => none
    | cs => some (s, cs)

end Move

/-! ### A line of reason, as a move

The library's own arguments are made of lines of reason
(`Testimony.Logic.Line`), each with one step from its grounds to what it
delivers. Read through an argument's meanings, a step is a move: its
antecedent's parts are its premises, its consequent its conclusion. So every
check above applies to the library's own reasoning, as it does to an article's
(`Testimony.Checks.Fallacies`). -/

end Testimony.Semantics

namespace Testimony.Logic

open Testimony.Semantics

variable {α : Type} [HasMeanings α]

/-- The parts of a conjunction, with Foundation's `⊤` — the conjunction of no
parts — left out. -/
def Formula.conjuncts : Formula α → List (Formula α)
  | .and a b => Formula.conjuncts a ++ Formula.conjuncts b
  | .imp .falsum .falsum => []
  | f => [f]

/-- **What a formula of atoms means**: an atom's meaning, a negated atom's
denial, a conjunction's parts together. Anything else is not read. -/
def Formula.meaning? : Formula α → Option Statement
  | .atom a => some (HasMeanings.means a)
  | .imp (.atom a) .falsum => some (.denied (HasMeanings.means a))
  | .and a b => do
    let s ← Formula.meaning? a
    let t ← Formula.meaning? b
    pure (.also s t)
  | _ => none

/-- **A line's step, as a move** of the library's own: the antecedent's parts as
premises, the consequent as conclusion. None when the step is not an implication,
or a part of it is not read. -/
def Line.asMove? (l : Line α) : Option Move :=
  match l.step with
  | .imp a c => do
    let ps ← (Formula.conjuncts a).mapM Formula.meaning?
    let c' ← Formula.meaning? c
    pure { speaker := "the library", words := l.name, act := .argues ps c' }
  | _ => none

end Testimony.Logic

namespace Testimony.Semantics

/-! ### Each charge, at work

Moves of the module's own, built from the vocabulary and naming no argument:
each check finds what it looks for, and passes over what it does not. -/

namespace FallacyExamples

open Notation

/-- Romans 3:28. -/
@[nolint defsWithUnderscore] abbrev rom3_28 : PassageRange := vs .romans 3 28

/-- James 2:24. -/
@[nolint defsWithUnderscore] abbrev jas2_24 : PassageRange := vs .james 2 24

/-- Romans 3:28 says a person is justified by faith. -/
abbrev romansSays : Statement := .says rom3_28 (rl .instrumentOf (wd .pistis rom3_28)
  (wd .dikaioo rom3_28))

/-- James 2:24 says a person is not justified by faith alone. -/
abbrev jamesSays : Statement := .says jas2_24 (.not (rl .soleInstrumentOf (wd .pistis jas2_24)
  (wd .dikaioo jas2_24)))

/-- In Romans 3:28, "justify" means a verdict. -/
abbrev verdictInRomans : Statement := .means .dikaioo (.passage rom3_28) .verdict

/-- In James 2:24, "justify" means showing to be righteous. -/
abbrev showingInJames : Statement := .means .dikaioo (.passage jas2_24) .showRighteous

/-- **Read apart, then set against each other.** Romans says justified by faith,
James says not by faith alone; "justify" is a verdict in the one and a showing
in the other; so Scripture contradicts itself. The move needs "justify" the same
in both and has just said it is not. -/
def readApart : Move where
  speaker := "an example"
  words := "Paul and James contradict each other."
  act := .argues [romansSays, jamesSays, verdictInRomans, showingInJames]
    (.denied (.principle .scriptureSelfConsistent))

/-- **The same move, with nothing said about senses.** -/
def silentOnSenses : Move where
  speaker := "an example"
  words := "Paul and James contradict each other."
  act := .argues [romansSays, jamesSays] (.denied (.principle .scriptureSelfConsistent))

/-- **A survey of the word.** "Justify" shows to be in the right at Matthew
11:19 and gives a verdict at Deuteronomy 25:1; so in James it does not mean to
make righteous. -/
def survey : Move where
  speaker := "an example"
  words := "Elsewhere the word declares; so it declares in James."
  act := .argues [.means .dikaioo (.passage (vs .matthew 11 19)) .showRighteous,
      .means .dikaioo (.passage (vs .deuteronomy 25 1)) .verdict]
    (.denied (.means .dikaioo (.usage .james) .makeRighteous))

/-- **The equivocation check, at work.** The first move reads "justify" in two
senses and needs them one: an equivocation on its own terms. The second says
nothing of senses, and is conditional on both "faith" and "justify" keeping
theirs. The third reports two senses of the word in two places and needs
nothing of them alike, since it only talks about the word there; it is
conditional on the word's keeping, in James, a sense it has elsewhere. -/
theorem equivocation_at_work :
    readApart.equivocates = [.dikaioo] ∧ readApart.conditionalOn = [.pistis] ∧
      silentOnSenses.equivocates = [] ∧ silentOnSenses.conditionalOn = [.pistis, .dikaioo] ∧
      survey.equivocates = [] ∧ survey.conditionalOn = [.dikaioo] := by
  decide

/-- Faith is the only means of justification. -/
abbrev faithOnly : Statement := .holds (rl .soleInstrumentOf (cn .faith) (cn .justification))

/-- Baptism is not a means of justification. -/
abbrev baptismNotAMeans : Statement :=
  .holds (.not (rl .instrumentOf (cn .baptism) (cn .justification)))

/-- **A premise that already says the conclusion.** Romans 3:28 says justified
by faith; faith is the only means; so baptism is not a means. The second premise
alone settles it, by what "only" means. -/
def throughOnly : Move where
  speaker := "an example"
  words := "Faith is the only means, so baptism is not one."
  act := .argues [romansSays, faithOnly] baptismNotAMeans

/-- **The begging check, at work.** The premise that faith is the *only* means
carries the conclusion by the definition of "only"; Romans 3:28's own words do
not, because what a text says is kept whole. -/
theorem carries_at_work : throughOnly.carriers = [faithOnly] := by decide

/-- Paul taught that faith is the only means of justification. -/
abbrev paulTaught : Statement := .heldBy .paul (rl .soleInstrumentOf (cn .faith)
  (cn .justification))

/-- The word μόνος ("alone") is in Romans 3:28. -/
abbrev aloneInRomans : Statement := .occurs .monos rom3_28

/-- **From silence alone.** "Alone" is not in Romans 3:28, so Paul did not teach
faith alone. -/
def aloneNotThere : Move where
  speaker := "an example"
  words := "The word is not there, so Paul did not teach it."
  act := .argues [.denied aloneInRomans] (.denied paulTaught)

/-- **From silence, with its expectation.** The same, and: had Paul taught it,
the word would be in Romans 3:28. -/
def aloneExpected : Move where
  speaker := "an example"
  words := "Had Paul taught it, the word would be there; it is not."
  act := .argues [.denied aloneInRomans, .expects paulTaught aloneInRomans] (.denied paulTaught)

/-- **The silence check, at work.** The first move argues from silence alone;
the second states the expectation it needs, and so rests on it. -/
theorem silence_at_work :
    aloneNotThere.fromSilenceAlone = [aloneInRomans] ∧ aloneExpected.fromSilenceAlone = [] ∧
      aloneExpected.silences = [(aloneInRomans, paulTaught, .expected)] := by
  decide

/-- **A circle of two moves.** One concludes that faith is the only means from
Romans 3:28; the other concludes Romans 3:28's reading from faith's being the
only means. -/
def circle : List Move :=
  [ { speaker := "an example", words := "Romans 3:28, so faith alone."
    , act := .argues [.teaches rom3_28 (rl .soleInstrumentOf (cn .faith) (cn .justification))]
        faithOnly }
  , { speaker := "an example", words := "Faith alone, so that is what Romans 3:28 teaches."
    , act := .argues [faithOnly]
        (.teaches rom3_28 (rl .soleInstrumentOf (cn .faith) (cn .justification))) } ]

/-- **The circle check, at work**: each move rests on what the other concludes. -/
theorem circular_at_work : circular circle = [0, 1] := by decide

end FallacyExamples

/-! ### Why an argument from silence needs its expectation

Written as logic, with one atom for the thing denied and one for what the text
would say: the text's silence alone leaves the thing open, and with the
expectation, the denial follows. -/

end Testimony.Semantics

namespace Testimony.Logic

/-- The two claims an argument from silence turns on. -/
inductive SilenceClaim
  /-- The thing the argument denies: that Paul taught it, say. -/
  | thing
  /-- What the text would say were it so: that the word is in the verse. -/
  | text
deriving DecidableEq

/-- **A reading on which the text is silent and the thing is so**: Paul taught
it, and the word is not in the verse. -/
def silentButSo : Valuation SilenceClaim := fun c => c = .thing

/-- **An argument from silence needs its expectation.** From the text's silence
alone, the thing's denial does not follow: the reading on which the thing is so
and the text silent keeps the premise. With the expectation — were the thing so,
the text would say it — the denial follows. -/
theorem silence_needs_its_expectation :
    ¬ Entails [notP SilenceClaim.text] (notP .thing) ∧
      Entails [p SilenceClaim.thing ➝ p .text, notP .text] (notP .thing) := by
  refine ⟨?_, ?_⟩
  · refute_with silentButSo
  · establish

end Testimony.Logic
