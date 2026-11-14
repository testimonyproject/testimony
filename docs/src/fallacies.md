# Checking an argument for fallacies

In a debate the charge comes fast. "That's an equivocation." "You're begging the question."
"That's an argument from silence." Each names a real way an argument can fail, and each is
often said of an argument that does not fail that way. A Catholic quotes James 2:24, "a person
is justified by works and not by faith alone", against Romans 3:28. A Protestant replies that
James means something else by "justify", and the Catholic calls the reply special pleading.
Each has named a fallacy without showing that the other committed it.

The library checks three of these charges one step of an argument at a time. Below is the list
of what it can and cannot yet check, then each of the three, worked through on the cases the
build itself checks. The design behind them is in
[Meanings and articles](./semantics.md#the-checks-an-article-audit-needs).

## The catalogue

Most of the checks read an argument one **move** at a time: one inference, from the premises a
speaker states to the conclusion they draw. A move is written in the library's shared
vocabulary (`Testimony.Semantics.Grammar`), so a check can see what its words mean and not only
how they are spelled.

| Charge | The question the check asks | Where it is | State |
|---|---|---|---|
| Equivocation | does the move give a word two senses where it needs one? | `Move.equivocation` | built |
| Begging the question | does a premise already assert the conclusion? | `Move.begsAgainst` | built |
| Circular reasoning | does a chain of moves come back to where it began? | `circular` | built |
| Argument from silence | does the move state the expectation its silence needs? | `Move.silences` | built |
| Non sequitur | does the conclusion follow from what is stated? | `refute_with` | built |
| Indefensible claim | can a position survive the dispute it is heard in? | a hearing | built |
| False dilemma | does a move pick one reading where others are fair? | would use `Dilemma` | not yet |
| Straw man | does an attribution match what its subject holds? | meanings | not yet |
| Misquotation | does a quotation say what the move says it says? | `says`, then a corpus | not yet |
| Cherry-picking | which texts on the same words does the move ignore? | a query over meanings | not yet |
| Double standard | does a party apply its own principle to its own moves? | an epistemology | not yet |

The checks for a non sequitur and an indefensible claim work on whole positions rather than
single moves. A non sequitur is shown by a **countermodel**: a way of taking every premise as
true and the conclusion as false, which proves the conclusion does not follow
([Reading the logic](./reading-the-logic.md) explains them). An indefensible claim is shown in a
**hearing**: the dispute the library settles between rival positions, each with its cited
premises, which reports whether a position can be held against the others.

None of the move checks returns a bare "fallacy". Each says which premise, stated or not, the
move's weight falls on, and the begging check also names which of the library's claims deny
that premise. A charge becomes a finding a reader can check.

Every case below is in `Testimony/Checks/FallacyCases.lean`, and Lean's checker proves each one
every time the library is built. For each charge the module pins a classic case the check must
catch and a near miss it must pass over, so a change to a check that moves either one fails the
build. The logic behind the silence check and the library's own line on Paul's word are
elsewhere, as named below. You can copy any case into a scratch file that imports
`Testimony.Checks.FallacyCases`, change it, and see what the check does.

## Writing a move

A move is who makes it, the words they used, and what the words do. For an inference, the act
is `.argues`, with a list of premises and a conclusion. The module writes moves with a short
helper:

```lean
def argues (ps : List Statement) (c : Statement) : Move :=
  { speaker := "a test case", words := "", act := .argues ps c }
```

When you model a real article, put its own words in `words`, quoted exactly, and name the
speaker. Kenneth Howell's dialogue on faith alone is the worked case
(`TestimonyArguments.Articles.Howell2003`).

Each premise and conclusion is a **statement**, built from the vocabulary. These are the kinds
the examples use:

- `.says p c` — the passage `p` says `c`, in its own words. A claim about the text, which no
  reader disputes.
- `.teaches p c` — the passage, read rightly, teaches `c`. A reading of it, which a reader may
  dispute.
- `.holds c` — `c` is so: a claim of doctrine, whoever holds it.
- `.heldBy v c` — the voice `v` (a writer, a council, a tradition) held `c`.
- `.means w sc s` — the word `w`, at the place `sc`, has the sense `s`.
- `.sameSense w a b` — the word keeps its sense from place `a` to place `b`.
- `.occurs w p` — the word `w` is in the passage `p`.
- `.expects s t` — had `s` been so, `t` would be: the premise an argument from silence needs.
- `.denied s` — not `s`.

The contents inside them are written with four helpers. `wd w p` is the word `w` as it is used
at `p`; `cn` names a concept, such as faith or justification; and `rl r a b` puts two of these in
the relation `r`. The relations used below are
`.instrumentOf`, "the means by which"; `.soleInstrumentOf`, "the only means by which"; and
`.sufficientFor`, "enough for".

The difference between `.says` and `.teaches` matters to every check. Romans 3:28 *saying*
that a person is justified by faith apart from works of the law is a fact about the text. That
faith is therefore the *only* means of justification is a reading of it, and readers dispute
it.

## Equivocation

An equivocation uses one word in two senses and relies on it meaning the same throughout. The
check looks at every word the move *uses* at two places. A word is used inside what a text
says, what a reader held, or what is held to be so. A word only *talked about*, in a claim of
what it means, is not used. For each word the move needs alike, the check reports one of three
things:

- **granted** — a premise says the word keeps its sense;
- **read apart** — the move's own statements give it different senses at the two places, and
  it still needs them one. That is the fallacy, on the move's own terms;
- **unstated** — the move says nothing either way. It is then *conditional* on the word keeping
  its sense: not fallacious, but no stronger than that condition.

The check compares senses as the vocabulary names them. Two senses a reader might count as one
are counted as two, so what it finds is only as fine as the vocabulary.

**Caught.** Romans 4:5 says, "to the one who does not work but believes in him who justifies the
ungodly, his faith is counted as righteousness". James 2:14 asks of a faith without works, "Can
that faith save him?" Read "faith" (πίστις) as trust in Paul and as bare assent in James, and
conclude that faith is not what Romans 4:5 says it is:

```lean
def thatFaith : Move :=
  argues
    [ .says rom4_5 (rl .instrumentOf (wd .pistis rom4_5) (wd .dikaioo rom4_5))
    , .says jas2_14 (.not (rl .sufficientFor (wd .pistis jas2_14) (wd .sozo jas2_14)))
    , .means .pistis (.passage rom4_5) .trust
    , .means .pistis (.passage jas2_14) .mereAssent ]
    (.holds (.not (rl .instrumentOf (wd .pistis rom4_5) (wd .dikaioo rom4_5))))
```

The move sets James's faith against Paul's, so it needs one faith in both verses, and it has
just read two. The check finds "faith" read apart: `thatFaith.equivocates = [.pistis]`.

**Passed over.** The same move with "faith" said to be one in both verses (`thatFaithGranted`)
does not equivocate. Whether it is one is itself disputed. Trent reads James's faith as the same
assent as Paul's, without the charity that would make it living; the Reformers read it as a
profession that lacks trust. Stated as a premise, the question can be weighed, and the move is
answerable for it.

A survey of what "justify" (δικαιόω) means in Matthew 11:19 and Deuteronomy 25:1 (`survey`) does
not equivocate either, though it gives the word two senses: it talks about the word in both
places and needs nothing of them alike. It is not free, though. It concludes what the word does
not mean in James, so it depends on James using the word in a sense it has elsewhere, and the
check lists it as conditional on that. The library's own line on James's word is listed the same
way. Nor is a move whose *conclusion* is that "works" means two things in Paul and James
(`worksDiffer`) an equivocation on "works".

The survey is here because the check once got it wrong. Its first version flagged the library's
line on James's word, which gathers the senses of δικαιόω outside Paul, as an equivocation. It
was not one, and the check now tells a word used from a word talked about. `equivocation_cases`
pins all seven results.

## Begging the question

An argument begs the question when a premise already asserts what it concludes, so that only a
reader who grants the conclusion would grant the premise. Two claims worded differently can say
the same thing, so the check does not compare words. A premise **carries** the conclusion when,
read for what its words mean under the library's shared definitions, the conclusion follows from
the premise alone.

**Caught.** A premise that is the conclusion carries it (`restated`). So does "faith is the only
means of justification", offered for "works are not a means": what "only" means
(`Testimony.Ontology.Relations.onlyMeans`) makes the second follow from the first.

```lean
def throughOnly : Move := argues [faithOnly] worksNot
```

`throughOnly.carriers = [faithOnly]`.

**Passed over.** Romans 3:28's own words, "apart from works of the law", do not carry the
doctrine that works are no means of justification (`fromTheText`). The check does not unpack a
verse's words into a doctrine. To go from what Romans 3:28 says to what it teaches takes a
reading, and the move has to state that reading as a premise. Here it takes two: that the verse
teaches works are no means, and that Paul's "works of the law" (ἔργα νόμου) are works in general.
Dunn reads them otherwise, as the marks of Jewish identity, and the library keeps the question as
a claim of its own (`worksOfLawMeansWorksGenerally`). A premise about something else carries
nothing either (`different`). `begging_cases` pins all
four.

**Whom it is begged against.** A premise that carries the conclusion is not always a fault. If
no one denies it, the move only restates itself. If the very readers who deny the conclusion
deny the premise, the move assumes what it was meant to show them. So the check looks the
premise up among an argument's claims (`Move.begsAgainst`) and names who denies it.

The library's own reasoning is checked this way too. Each of its arguments is built from **lines
of reason**, each a single step from stated starting points to a conclusion. One sola fide line
(`lexicalLine`) argues that Paul's "justify" does not mean to make a person inwardly just. Its
premise about the word has two halves: Paul's "justify" gives a verdict, and "it does not mean to
make a person good". The second half is the line's conclusion. Trent's reading of Paul's word
denies that half and keeps the first, since the justified "are not only reputed, but are truly
called, and are, just" (Session VI, chapter 7). So as an answer to Trent, the library's own line
begs the question. The check reports it without failing the build, and the fix is tracked as
issue #223.

### Circular reasoning

The same lookup runs over a whole article. One move rests on another when what the first
concludes carries a premise of the second, and a circle is a chain of such moves that comes back
to its start. In `threeCircle`, Romans 3:28 teaches faith alone because faith is the only means;
works are no means because of what Romans 3:28 teaches; and faith is the only means because
works are none. Every move is on the circle. In `chain`, the last move rests on what the text
says instead, and nothing comes back. `circle_cases` pins both.

## Argument from silence

An argument from silence reasons from what a text does not say. The word "alone" is not in
Romans 3:28, so faith is not the only means (`notThere`); Romans 3:28 does not say faith is the
only means, so Paul did not teach it (`notSaid`). Such an argument is not always weak. It holds
when the text would have said the thing had it been so. That **expectation** is a premise of its
own, and the check asks whether the move states it:

```lean
def notSaid : Move := argues [.denied romansSaysOnly] (.denied paulTaught)

def notSaidExpected : Move :=
  argues [.denied romansSaysOnly, .expects paulTaught romansSaysOnly] (.denied paulTaught)
```

The first argues from silence alone, and the check reports the silence it rests on. The second
states its expectation, "had Paul taught it, Romans 3:28 would say so". It is then valid: if
both premises are true, the conclusion must be. The weight now falls on two premises a reader
can weigh. A Lutheran or Reformed reader denies the first, that the verse is silent, holding
that "apart from works of the law" already says *alone*. Another reader might grant the silence
and deny the expectation, holding that Paul need not say in every verse all that he teaches.

Why the expectation decides it is shown in plain logic, in
`Testimony/Semantics/Fallacy.lean` (`silence_needs_its_expectation`). The silence alone leaves
open a reading on which Paul taught it and the verse is silent. Add the expectation, and the
denial follows.

**Passed over, and caught.** A move that concludes only the silence itself is not an argument
from silence (`onlyTheSilence`); the begging check finds it instead. A move whose expectation is
about a different silence is still caught (`wrongExpectation`), because its expectation does
not reach the silence it argues from. `silence_cases` pins these results with the others.

The check sees only two shapes. Its premises must deny that a passage says, teaches or contains
something, and its conclusion must be a denial. An argument from silence about some other record
("the early writers never mention it"), or one that draws a positive conclusion, is not seen
until it is written in that form.

## Checking your own lines

A **package** is a set of arguments built on the library, as the worked arguments are. Read
through its argument's meanings, every line of reason in a package is a move.
`#check_fallacies under N` runs the three checks over every line under the namespace `N`, and
reports, for each argument:

- how many of its lines it could read;
- the lines that read a word two ways and need it one;
- the lines whose premise carries what they deliver, and who denies that premise;
- the lines that argue from silence alone;
- the lines that are conditional on a word keeping its sense, with the words.

It fails the build on two of these, a line that reads a word two ways or one that argues from
silence alone: the library may not do what it checks articles for. A carried premise is reported
but does not fail the build, because whether it begs the question depends on whom the line is
addressed to. Pin the report with `#guard_msgs`, as `TestimonyArguments.Checks` does, so that a
change in what the checks find is a change a reviewer sees.

A line is read only when every claim it uses has a meaning. Today that is 32 lines of the
library's 133, almost all in sola fide; the rest wait on their arguments' meanings.

### Making the build refuse a case

To test that a check fails where it should, give it a case of its own and pin the failure. The
end of `FallacyCases` does this with a small argument, `Refused`, which is the debate this page
opened with. Its line "Paul against James" sets Romans 3:28 against James 2:24 while reading
"justify" as a verdict in the one and a showing in the other; its line "Not in the verse" argues
from the missing word alone. `#check_fallacies` is run over it inside `#guard_msgs`, with the
error it must report written out:

```lean
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
```

If the check ever stopped refusing either line, the message would change, and the build would
fail. This does not settle whether the Protestant reply in the opening debate is right. It shows
what the reply commits its maker to: once "justify" is read as a verdict in Paul and a showing in
James, the two verses can no longer be set against each other, by either side.

## What the checks do not decide

None of them says whether a premise is true. A move that equivocates may have a sound argument
nearby; a premise that carries its conclusion may be true; and many arguments from silence are
good ones, because their expectation is well grounded. The checks say where a move's weight
falls, so that a reader can see what to weigh. The library weighs it where it weighs everything
else, in its disputes, and reports what the solver computes, whichever way it goes.
