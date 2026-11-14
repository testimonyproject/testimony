# Checking an argument for fallacies

In a debate the charge comes fast. "That's an equivocation." "You're begging the question."
"That's an argument from silence." Each names a real way an argument can fail, and each is
often said of an argument that does not fail that way. A Protestant who hears James 2:24
quoted against Romans 3:28 may reply that James means something else by "justify"; a
Catholic may answer that the reply is special pleading. Both have named a fallacy. Neither
has shown it.

The library can show it, or show that it is not there. This page lists the charges it can
check, and then works through each of the three a debate reaches for first, with the
examples the build itself checks. The design behind them is in
[Meanings and articles](./semantics.md#the-checks-an-article-audit-needs).

## The catalogue

Every check here reads an argument one **move** at a time: one inference, from premises the
move states to a conclusion it draws. A move is written in the shared vocabulary
(`Testimony.Semantics.Grammar`), so the check can see what its words mean and not only how
they are spelled.

| Charge | The question the check asks | Where it is | State |
|---|---|---|---|
| Equivocation | is a word used in two senses where the move needs one? | `Move.equivocation` | built |
| Begging the question | does a premise already assert the conclusion? | `Move.begsAgainst` | built |
| Circular reasoning | does a chain of moves come back to where it began? | `circular` | built |
| Argument from silence | does the move state the expectation its silence needs? | `Move.silences` | built |
| Non sequitur | does the conclusion follow from what the move states? | `refute_with` | built |
| Indefensible claim | can the move's position survive the dispute? | a hearing | built |
| False dilemma | does a move pick one reading where others are fair? | would use `Dilemma` | not yet |
| Straw man | does an attribution match what its subject holds? | meanings | not yet |
| Misquotation | does a quotation say what the move says it says? | `says`, then a corpus | not yet |
| Cherry-picking | which texts on the same words does the move ignore? | a query over meanings | not yet |
| Double standard | does a party apply its own principle to its own moves? | an epistemology | not yet |

No check returns a bare "fallacy". Each says which premise, stated or not, the move's weight
falls on, and what the library holds about that premise. That is the difference between a
charge and a finding.

Every example below is in `Testimony/Checks/FallacyCases.lean`, and each is a theorem the
kernel decides when the library builds. For each charge the module pins a classic case the
check must catch, and a near miss it must pass over, so a change to a check that moves either
one fails the build. You can copy any of them into a scratch file that imports
`Testimony.Checks.FallacyCases` and change it to see what the check does.

## Writing a move

A move is who makes it, the words they used, and what the words do. For an inference, the act
is `.argues`, with a list of premises and a conclusion. The module writes them with a short
helper:

```lean
def argues (ps : List Statement) (c : Statement) : Move :=
  { speaker := "a test case", words := "", act := .argues ps c }
```

When you model a real article, put the article's own words in `words`, quoted exactly, and
name the speaker; the Howell article is the worked case
(`TestimonyArguments.Articles.Howell2003`).

The statements are the vocabulary's. Four kinds do most of the work here:

- `.says p c` — the passage `p` says `c`, in its own words. A claim about the text.
- `.holds c` — `c` is so. A claim of doctrine, whoever holds it.
- `.means w sc s` — the word `w`, at the place `sc`, has the sense `s`. A claim about a word.
- `.sameSense w a b` — the word keeps its sense from `a` to `b`.

The difference between the first two matters to every check below. Romans 3:28 *saying* that
a person is justified by faith apart from works of the law is a fact about the text, and no
reader disputes it. That faith is therefore the *only* means of justification is a doctrine,
and readers do.

## Equivocation

An equivocation uses one word in two senses and relies on it meaning the same throughout.
The check looks at every word the move *uses* at two places. A word is used inside what a
text says, what a reader held, or what is held to be so. A word only *talked about*, in a
claim of what it means, is not used. For each word the move needs alike, the check reports
one of three things:

- **granted** — a premise says the word keeps its sense;
- **read apart** — the move's own statements give it different senses at the two places,
  and it still needs them one. That is the fallacy, on the move's own terms;
- **unstated** — the move says nothing either way. It is then *conditional* on the word
  keeping its sense: not fallacious, but no stronger than that condition.

**Caught.** Romans 4:5 says "to the one who does not work but trusts him who justifies the
ungodly, his faith is counted as righteousness". James 2:19 says "even the demons believe —
and shudder!" Take "faith" as trust at the first and bare assent at the second, and conclude
that the demons' faith counts them righteous:

```lean
def demonsFaith : Move :=
  argues
    [ .says rom4_5 (rl .instrumentOf (wd .pistis rom4_5) (wd .dikaioo rom4_5))
    , .says jas2_19 (rl .isA (pt "the demons" .agent) (wd .pistis jas2_19))
    , .means .pistis (.passage rom4_5) .trust
    , .means .pistis (.passage jas2_19) .mereAssent ]
    (.holds (rl .instrumentOf (wd .pistis jas2_19) (wd .dikaioo rom4_5)))
```

The check finds "faith" (πίστις) read apart: `demonsFaith.equivocates = [.pistis]`.

**Passed over.** The same move with "faith" granted the same at both places
(`demonsFaithGranted`) does not equivocate. It may well be false, since James's point is that
such faith does not save, but that is a question about its premise, and the premise is now in
plain view. A survey of what "justify" (δικαιόω) means in Matthew 11:19 and Deuteronomy 25:1
(`survey`) is not flagged either, though the two senses differ: it talks about the word in
both places and needs nothing of them alike. Nor is a move whose *conclusion* is that "works"
means two things in Paul and James (`worksDiffer`).

The survey case is there because the check once got it wrong. Its first version flagged the
library's own line on James's word, which gathers the senses of δικαιόω outside Paul, as an
equivocation. It was not one, and the check now tells a word used from a word talked about.

All five results are one theorem, `equivocation_cases`.

## Begging the question

An argument begs the question when a premise already asserts what it concludes, so that only
a reader who grants the conclusion would grant the premise. Two claims worded differently can
say the same thing, so the check does not compare words. A premise **carries** the
conclusion when, read under the library's shared definitions, it entails the conclusion or
cannot be held with its denial.

**Caught.** A premise that is the conclusion carries it (`restated`). So does "faith is the
only means of justification", offered for "works are not a means": the definition of "only"
(`Testimony.Ontology.Relations.onlyMeans`) makes the one imply the other.

```lean
def throughOnly : Move := argues [faithOnly] worksNot
```

`throughOnly.carriers = [faithOnly]`.

**Passed over.** Romans 3:28's own words, "apart from works of the law", do not carry the
doctrine that works are no means of justification (`fromTheText`). What a text says is kept
whole. That it teaches the doctrine is a reading, and the move is answerable for it. A
premise about something else carries nothing either (`different`). All four results are
`begging_cases`.

**Whom it is begged against.** A premise that carries the conclusion is not always a fault.
If no one denies it, the move only restates itself. If the very readers who deny the
conclusion deny the premise, the move assumes what it was meant to show them. So the check
looks the premise up among an argument's claims (`Move.begsAgainst`) and names who denies
it. The library's own sola fide line on Paul's word (`lexicalLine`) is found this way: its
premise that Paul's "justify" is a courtroom word also says, in its own words, "it does not
mean to make a person good", which is the line's conclusion. That premise is the one Trent's
reading denies.

### Circular reasoning

The same lookup runs over a whole article. One move rests on another when what the first
concludes carries a premise of the second, and a circle is a chain of such moves that comes
back to its start. In `threeCircle`, Romans 3:28 teaches faith alone because faith is the only
means; works are no means because of what Romans 3:28 teaches; and faith is the only means
because works are none. Every move is on the circle. In `chain`, the last move rests on what
the text says instead, and nothing comes back. Both are `circle_cases`.

## Argument from silence

An argument from silence reasons from what a text does not say: the word "alone" is not in
Romans 3:28, so Paul did not teach faith alone. Such an argument is not always weak. It holds
when the text would have said the thing had it been so. That **expectation** is a premise
of its own, `Statement.expects`, and the check asks only whether the move states it:

```lean
def notSaid : Move := argues [.denied romansSaysOnly] (.denied paulTaught)

def notSaidExpected : Move :=
  argues [.denied romansSaysOnly, .expects paulTaught romansSaysOnly] (.denied paulTaught)
```

The first argues from silence alone, and the check reports the silence it rests on. The
second states its expectation, "had Paul taught it, Romans 3:28 would say so", and is then a
valid argument: the text is silent, so what would have made it speak is not so. The weight
now falls on the expectation, which a reader can weigh. A Reformed reader would deny it,
holding that "apart from works" already says *alone*.

Why the expectation decides it is shown as plain logic (`silence_needs_its_expectation`): the
text's silence alone leaves open a reading on which Paul taught it and the verse is silent,
and with the expectation added, the denial follows.

**Passed over.** A move that concludes only the silence itself is not an argument from
silence (`onlyTheSilence`); the begging check finds it. And an expectation about a different
silence does not carry this one (`wrongExpectation`). All are `silence_cases`.

## Checking your own lines

Every line of reason in a package is one step from its grounds to what it delivers, and read
through the argument's meanings, a step is a move. `#check_fallacies under N` runs the three
checks over every line under the namespace `N`. It reports, for each argument:

- how many of its lines it could read;
- the lines that read a word two ways and need it one;
- the lines whose premise carries what they deliver, and who denies that premise;
- the lines that argue from silence alone;
- the lines that are conditional on a word keeping its sense, with the words.

It fails the build on two of them, a line that reads a word two ways or one that argues from
silence alone: the library may not do what it checks articles for. A carried premise is
reported but does not fail, because whether it begs the question depends on whom the line is
addressed to. Pin the report with `#guard_msgs`, as `TestimonyArguments.Checks` does, so a
change in what the checks find is a change a reviewer sees.

A line is read only when every claim it uses has a meaning. Today that is 32 lines of the
library's 133, almost all in sola fide; the rest wait on their arguments' meanings.

### Making the build refuse a case

To test that a check fails where it should, give it a case of its own and pin the failure.
The end of `FallacyCases` does this: a small argument, `Refused`, with one line that reads
"justify" two ways and one that argues from silence alone. `#check_fallacies` is run over it
inside `#guard_msgs`, with the error it must report written out:

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

If the check ever stopped refusing either line, the message would change, and the build
would fail.

## What the checks do not decide

None of them says whether a premise is true. A move that equivocates may have a sound
argument nearby that does not. A premise that carries its conclusion may be true. An
expectation may be well grounded, and many arguments from silence are good ones. The checks
say where a move's weight falls, so that a reader can see what to weigh. The library weighs
it where it weighs everything else, in its disputes, and reports what the solver computes,
whichever way it goes.
