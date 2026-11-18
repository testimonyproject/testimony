import Testimony.Semantics.Discourse
import Testimony.Logic.Line
import Testimony.Logic.Tactic

/-!
# Testimony.Semantics.Fallacy — the charges, checked move by move

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

## A move from one word to a kindred one

Equivocation is one word in two senses. Its near neighbour is two words read as
one. A verb and its adjective are of one family, and a version puts its own word
for the original's, so an argument may read one by the other: Paul's verb
"justify" (δικαιόω) by the adjective "righteous" (δίκαιος), or the Greek by the
Latin *iustificare*. Barr called the first the root fallacy. Neither is a fault
in itself, since kindred words often do share a sense, but the move then rests
on that, and should say so. The vocabulary lists which words are kin
(`Lexeme.kin`). A move **shifts** when a premise has one word and the conclusion
uses, or says what means, a kindred word that no premise has at that place
(`Move.shifts`). For each shift the move stands in one of two ways (`Shift`):

- **granted** — a premise says the first word, where the move has it, bears the
  sense the second has where the move concludes it (`Statement.bears`);
- **unstated** — the move says nothing of it, and holds on that condition, as
  it does on an unstated sameness of sense.

A move can also take a word's sense from nowhere in the word at all. "God's verdict
makes the sinner righteous; so the verb 'justify' means to make righteous" draws
the verb's sense from a claim about what God does, not from any use of the word.
Barr called reading a doctrine into each occurrence of its word illegitimate
totality transfer. A move **draws a sense from elsewhere** when its conclusion
says a word means something at a place and no premise gives that sense to the
word, to a kindred word the move reads it by, or as someone's reading of it, and
no premise is a text from whose setting the sense could be read
(`Move.sensesFromElsewhere`). It is reported, not charged: a word may yet have
the sense, but the move has not shown it from the word.

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

## Straw man

A straw man answers a view its holder does not hold: "Trent teaches that a
person's own works are enough to justify him, and Romans 3:28 says otherwise."
Trent's first canon on justification condemns exactly that view. So the check
compares what a move says someone held (`Statement.attributions`) with the
library's record of what that voice holds: the claims of an argument it cites as
the voice's position, read for what their words mean. An attribution the record
bears out is **fair**; one it contradicts is **unfair**; one it both bears out
and contradicts is **disputed**, because what the voice held is itself argued;
and one it says nothing about is **unrecorded** (`Attribution`). A move answers a
straw man when an attribution is unfair and the move argues against what it
attributes (`Move.strawMen`). An unfair attribution the move leans on instead,
citing a voice for what the voice denied, is reported as a misattribution
(`Move.misattributions`).

## Leaving out what a voice also said

A move can cite a voice fairly and still cite it selectively. A reader who read a
word two ways, cited for one, is borne out by the record, and the straw-man check
passes him. So a second check compares a reading the move cites a voice for with
every other reading the record gives the same voice for the same word, and
reports those the move does not mention (`Move.omissions`). It does not say the
move is wrong to prefer one: it says what a reader is owed. It looks at how a
voice read a word (`Statement.glosses`). What a voice held is not compared, since
whether one held content leaves another out is a question about the contents,
which the reasoner does not yet decide.

## What none of this decides

None of the checks says whether a premise is true. A move that equivocates
on its own terms may have a sound argument nearby that does not; a premise that
carries the conclusion may be true; an expectation may be well grounded; and
an attribution the record contradicts may show the record wrong, not the move.
The checks report where the move's weight falls. What holds the weight up is weighed
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

/-! ### A move from one word to a kindred one -/

/-- **How a move stands to one shift between kindred words it makes.** -/
inductive Shift
  /-- A premise says the first word, where the move has it, bears the sense
  the second has where the move concludes it. -/
  | granted
  /-- The move says nothing of the bridge between the two words. -/
  | unstated
deriving DecidableEq, Repr

namespace Statement

/-- **Every place a statement has a word, as evidence**: where it uses the word,
says what it means, or reports how a voice read it. A bridge between two words
(`Statement.bears`) is left out: it is what licenses a shift, not evidence that
the move has the second word's own sense in hand. -/
def evidenceWords : Statement → List (Lexeme × Scope)
  | .bears .. => []
  | .denied s => s.evidenceWords
  | .also s t => s.evidenceWords ++ t.evidenceWords
  | s => s.words

end Statement

namespace Move

/-- **The shifts between kindred words a move makes**: a premise has one word at
one place, and the conclusion uses, or says what means, a different word of its
kin (`Lexeme.kin`) at another, while no premise has the second word there. The
move then reads the second word by the first: a verb by its adjective, or the
Greek by the Latin. Each with how the two words are kin. -/
def shifts (m : Move) : List (Lexeme × Scope × Lexeme × Scope × Kinship) :=
  let from_ := (m.premises.flatMap Statement.evidenceWords).eraseDups
  let to_ := (m.conclusion?.map fun c => c.uses ++ c.sensePlaces).getD []
  let shifts := to_.eraseDups.flatMap fun (v, b) =>
    if from_.contains (v, b) then [] else
      from_.filterMap fun (w, a) =>
        if w = v then none else (Lexeme.kin w v).map fun k => (w, a, v, b, k)
  shifts.eraseDups

/-- Whether a premise, read for what its words mean, states the bridge: that the
first word, at its place, bears the sense the second has at its own. -/
def bridges (m : Move) (w : Lexeme) (a : Scope) (v : Lexeme) (b : Scope) : Bool :=
  m.premises.any fun s =>
    let lits := (Ontology.closed Testimony.Ontology.shared s).lits
    lits.contains ⟨true, .bears w a v b⟩ || lits.contains ⟨true, .bears v b w a⟩

/-- **The word-shift check**: every shift the move makes between kindred words,
and whether a premise states its bridge. -/
def wordShifts (m : Move) : List (Lexeme × Lexeme × Kinship × Shift) :=
  m.shifts.map fun (w, a, v, b, k) =>
    (w, v, k, if m.bridges w a v b then .granted else .unstated)

/-- The shifts the move makes without stating their bridge: the conditions it
holds on, as an unstated sameness of sense is for one word. -/
def unbridged (m : Move) : List (Lexeme × Lexeme × Kinship) :=
  (m.wordShifts.filterMap fun
    | (w, v, k, .unstated) => some (w, v, k)
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
  let sameConclusion (i j : Nat) : Bool :=
    match ms[i]?, ms[j]? with
    | some m, some n => m.conclusion? == n.conclusion?
    | _, _ => true
  let start := idx.map fun i => (i, idx.filter fun j => !sameConclusion i j && feeds i j)
  idx.foldl (fun r _ => r.map fun (i, js) =>
    (i, (js ++ js.flatMap fun j => (r.lookup j).getD []).eraseDups)) start

/-- **The moves on a circle**: each move that rests, through other moves of the
same article, on what it concludes itself. Numbered from 0, in the article's
order.

A circle takes at least two moves. A move whose conclusion entails one of its own
premises — "Scripture is infallible, and no other rule is, so Scripture is the
sole infallible rule" — is not resting on itself: its conclusion is stronger than
its premise, as a conclusion may be, and nothing it assumes was drawn from it. So
a move's edge to itself is left out, and a move is on a circle only if another
move it rests on rests, in turn, on it.

Two moves to the same conclusion are left out of each other's reach for the same
reason. "Scripture is infallible, and no other rule is, so it is the sole
infallible rule" and "the historical-grammatical method suffices, creeds inform
without binding, Scripture is infallible and no other rule is, so it is the sole
infallible rule" each conclude what carries the other's premises. But that is
each conclusion carrying its own premises, twice over: they are two routes to one
conclusion, and neither draws anything from the other that it does not already
assume. A circle runs through different conclusions, each resting on the next. -/
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

/-! ### Straw man

A straw man answers a view its holder does not hold. The move says that someone
held a thing, argues against the thing, and the thing is not what they hold. So
the check needs a record of what each voice holds, and the record is the
library's own: the claims of an argument that it cites as that voice's position,
given to the check voice by voice. What a voice's position asserts is what the
voice holds, so a claim that Trent's position asserts and a claim that Trent held
something are read alike (`Statement.asHeldBy`). -/

namespace Statement

/-- **What a statement attributes to a voice**: that the voice held a content,
or read a word in a sense, taken apart at "and". A denial attributes nothing: it
says what a voice did not hold. -/
def attributions : Statement → List Statement
  | s@(.heldBy ..) | s@(.glosses ..) => [s]
  | .also s t => s.attributions ++ t.attributions
  | _ => []

/-- The voice an attribution is to. -/
def voice? : Statement → Option Voice
  | .heldBy v _ | .glosses v _ _ => some v
  | _ => none

/-- **A statement about a voice, read as that voice's view**: where it says the
voice held a content, the content itself, held. Anything else is left as it is,
so a claim the voice's position asserts stays what it asserts. -/
def asHeldBy (v : Voice) : Statement → Statement
  | .heldBy v' c => if v' = v then .holds c else .heldBy v' c
  | .also s t => .also (s.asHeldBy v) (t.asHeldBy v)
  | s => s

/-- **Whether a record bears out an attribution**: read as the voice's view, it
entails what the attribution says the voice held; or it entails the attribution
as it stands. -/
def bearsOut (r a : Statement) : Bool :=
  r.entails a ||
    match a with
    | .heldBy v c => (r.asHeldBy v).entails (.holds c)
    | _ => false

/-- **Whether a record contradicts an attribution**: it says the voice did not
hold what the attribution says it held, or, read as the voice's view, it cannot
be held with what the attribution says the voice held. -/
def contradicts (r a : Statement) : Bool :=
  r.excludes a ||
    match a with
    | .heldBy v c => (r.asHeldBy v).excludes (.holds c)
    | _ => false

end Statement

/-- **How an attribution stands to the record of its voice.** -/
inductive Attribution (α : Type)
  /-- Claims recorded as the voice's position bear it out, and none contradicts
  it. -/
  | fair (recordedBy : List α)
  /-- Claims recorded as the voice's position contradict it, and none bears it
  out. -/
  | unfair (contradictedBy : List α)
  /-- The record says both: some of its claims bear the attribution out and some
  contradict it. What the voice held is itself in dispute, and the move rests on
  one side of it. -/
  | disputed (recordedBy contradictedBy : List α)
  /-- The record says nothing either way. The attribution is the move's to
  support, and the check cannot weigh it. -/
  | unrecorded
deriving DecidableEq, Repr

namespace Move

variable {α : Type} [HasMeanings α]

/-- **What a move attributes to someone**: every attribution among its premises,
or, for a move that only attributes, what it attributes. An attribution in the
conclusion is what the move argues for, not what it rests on, and is left out. -/
def attributions (m : Move) : List Statement :=
  (match m.act with
    | .argues ps _ => ps.flatMap Statement.attributions
    | .attributes v (.holds c) => [.heldBy v c]
    | .attributes _ s => s.attributions
    | .asserts s => s.attributions
    | .quotes _ _ => []).eraseDups

/-- **How one attribution stands to the record**, where `record v` is the claims
of an argument cited as the position of the voice `v`. -/
def attribution (record : Voice → List α) (a : Statement) : Attribution α :=
  match a.voice? with
  | none => .unrecorded
  | some v =>
    let rs := record v
    let fair := rs.filter fun r => (HasMeanings.means r).bearsOut a
    let unfair := rs.filter fun r => (HasMeanings.means r).contradicts a
    match fair, unfair with
    | [], [] => .unrecorded
    | f, [] => .fair f
    | [], u => .unfair u
    | f, u => .disputed f u

/-- **The attribution check**: every attribution the move makes, and how it
stands to the record. -/
def attributed (record : Voice → List α) (m : Move) : List (Statement × Attribution α) :=
  m.attributions.map fun a => (a, attribution record a)

/-- Whether the move argues against what an attribution says its voice held: its
conclusion cannot be held with it. -/
def answers (m : Move) (a : Statement) : Bool :=
  match m.conclusion?, a with
  | some c, .heldBy _ x => c.excludes (.holds x)
  | _, _ => false

/-- **The attributions the record contradicts**, with the claims that contradict
each, whether or not the move argues against them. -/
def misattributions (record : Voice → List α) (m : Move) : List (Statement × List α) :=
  (m.attributed record).filterMap fun
    | (a, .unfair u) => some (a, u)
    | _ => none

/-- **Where the move answers a straw man**: an attribution the record contradicts,
and the move argues against what it attributes. One the record only disputes is
left out, because what the voice held is then the question, not the move's
fault. -/
def strawMen (record : Voice → List α) (m : Move) : List (Statement × List α) :=
  (m.misattributions record).filter fun (a, _) => m.answers a

/-- **What a move leaves out of a voice's reading**: for each reading of a word
the move cites a voice for, the other senses the record says that same voice
gave the same word, which the move does not mention, with the record's claims
that give them. A voice who read a word two ways, cited for one, is cited
selectively: the move may still be right, but a reader is owed the other. -/
def omissions (record : Voice → List α) (m : Move) :
    List (Statement × List (Sense × List α)) :=
  let cited := m.attributions
  cited.filterMap fun a =>
    match a with
    | .glosses v w s =>
      let others := (record v).flatMap fun r =>
        ((HasMeanings.means r).attributions.filterMap fun
          | .glosses v' w' s' =>
            if v' = v ∧ w' = w ∧ s' ≠ s ∧ !cited.contains (.glosses v w s')
            then some (s', r) else none
          | _ => none)
      let senses := (others.map (·.1)).eraseDups
      if senses.isEmpty then none
      else some (a, senses.map fun s' => (s', (others.filter (·.1 == s')).map (·.2)))
    | _ => none

/-- Whether a statement says what a text says, teaches or is written against,
alone or as part of a conjunction. -/
def _root_.Testimony.Semantics.Statement.textual : Statement → Bool
  | .says .. | .teaches .. | .opposes .. => true
  | .also s t => s.textual || t.textual
  | _ => false

/-- **The senses a move concludes a word has that nothing it argues from gives
the word**: its conclusion says a word means something at a place, and no
premise gives that sense to the word, to a kindred word the move reads it by, or
as a voice's reading of it, and no premise is a text, from whose setting the word's
sense might be read. The sense then comes from a claim about the thing the word
is used for, and the move reads the doctrine into the word: what Barr called
illegitimate totality transfer. Each with the word, the place and the sense. -/
def sensesFromElsewhere (m : Move) : List (Lexeme × Scope × Sense) :=
  let concluded := (m.conclusion?.map Statement.senses).getD []
  let read : List (Lexeme × Sense) := m.premises.flatMap fun p =>
    p.senses.map (fun (w, _, s) => (w, s)) ++
      p.attributions.filterMap fun
        | .glosses _ w s => some (w, s)
        | _ => none
  let given (w : Lexeme) (s : Sense) : Bool :=
    read.any fun (w', s') => s' = s ∧ (w' = w ∨ (Lexeme.kin w' w).isSome)
  if m.premises.any Statement.textual then [] else
    concluded.filter fun (w, _, s) => !given w s

end Move

/-- **Whether a statement is about a voice**: it says, or denies, what the voice
held or how it read a word. -/
def Statement.about (v : Voice) : Statement → Bool
  | .heldBy v' _ | .glosses v' _ _ => decide (v' = v)
  | .denied s => s.about v
  | .also s t => s.about v || t.about v
  | _ => false

/-- **An argument's own record of a voice**: the claims of the argument that say,
or deny, what the voice held or how it read a word. A line that attributes a view
is checked against these when the library's own lines are checked
(`Testimony.Checks.Fallacies`). A claim that a position asserts in its own voice,
such as Trent's definition of justification, is not on it: a claim does not
record whose position it is. -/
def recordOf (α : Type) [HasMeanings α] (v : Voice) : List α :=
  (HasMeanings.all : List α).filter fun a => (HasMeanings.means a).about v

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
