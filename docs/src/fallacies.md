# Checking an argument for fallacies

In a debate the charge comes fast. "That's an equivocation." "You're begging the question."
"That's an argument from silence." Each names a real way an argument can fail, and each is
often said of an argument that does not fail that way. A Catholic quotes James 2:24, "a person
is justified by works and not by faith alone", against Romans 3:28. A Protestant replies that
James means something else by "justify", and the Catholic calls the reply special pleading.
Each has named a fallacy without showing that the other committed it.

The library checks four of these charges one step of an argument at a time. Below is the list
of what it can and cannot yet check, then each of the four, worked through on the cases the
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
| Word shift | does the move read one word by a kindred one without saying so? | `Move.unbridged` | built |
| Begging the question | does a premise already assert the conclusion? | `Move.begsAgainst` | built |
| Circular reasoning | does a chain of moves come back to where it began? | `circular` | built |
| Argument from silence | does the move state the expectation its silence needs? | `Move.silences` | built |
| Non sequitur | does the conclusion follow from what is stated? | `refute_with` | built |
| Indefensible claim | can a position survive the dispute it is heard in? | a hearing | built |
| False dilemma | does a move pick one reading where others are fair? | would use `Dilemma` | not yet |
| Straw man | does a move answer a view its subject does not hold? | `Move.strawMen` | built |
| Misquotation | does a quotation say what the move says it says? | `says`, then a corpus | not yet |
| Sense from elsewhere | does the move take a word's sense from a doctrine, not the word? | `Move.sensesFromElsewhere` | built |
| Selective citation | does the move cite a voice for one reading and omit another? | `Move.omissions` | built |
| Cherry-picking | which texts on the same words does the move ignore? | a query over meanings | not yet |
| Double standard | does a party rest a claim on what its own rule refuses? | `ArgumentPackage.heldTo` | claims built |

The checks for a non sequitur and an indefensible claim work on whole positions rather than
single moves. A non sequitur is shown by a **countermodel**: a way of taking every premise as
true and the conclusion as false, which proves the conclusion does not follow
([Reading the logic](./reading-the-logic.md) explains them). An indefensible claim is shown in a
**hearing**: the dispute the library settles between rival positions, each with its cited
premises, which reports whether a position can be held against the others.

None of the move checks returns a bare "fallacy". Each says which premise, stated or not, the
move's weight falls on, and the begging and straw-man checks also name which of the library's
claims tell against that premise. A charge becomes a finding a reader can check.

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
what it means, is not used. For each word the move needs alike, the check reports one of four
things:

- **granted** — a premise says the word keeps its sense, between the two places or between two
  places they lie within: what a premise says of John 3:16–18, it says of 3:16;
- **read apart** — the move's own statements give it different senses at the two places, and
  it still needs them one. That is the fallacy, on the move's own terms;
- **granted only in part** — a premise says the word keeps its sense between places that
  overlap the two the move needs without covering them. A premise about John 3:18a, "whoever
  believes in him is not condemned", says nothing of the rest of 3:18, which speaks of
  believing "in the name". The move is conditional on the rest;
- **unstated** — the move says nothing either way. It is then *conditional* on the word keeping
  its sense: not fallacious, but no stronger than that condition.

A place can be part of a verse. `verse_part` (`Testimony.Corpus.Table`) names one by the
positions of its first and last words in the Greek, or in the Hebrew for the Old Testament, and
by one word it contains, by dictionary form. It reads the corpus as the module is built and
fails the build unless the words are there and the anchoring word occurs in the part exactly
once, so half a verse cannot silently stand for the whole. The cases are pinned in
`Testimony.Checks.FallacyCases` (`part_of_a_passage_cases`).

A part can still be written out by hand, without `verse_part`, so the build does not trust how
a part was made. `#check_verse_parts` (`Testimony.Checks.VerseParts`) finds every part of a
verse built anywhere in the library or the arguments, reads its verse from the text again, and
fails the build on any whose words or anchor are not there, or whose fields are not written out.
A hand-written part that the corpus bears out passes; one it does not is refused, and both
outcomes are pinned beside the check.

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

## A word read by a kindred one

Equivocation is one word in two senses. Its neighbour is two words read as one. A verb and its
adjective are of one family, and a translation puts its own word for the original's, so an
argument can read one by the other. Fitzmyer reads Paul's verb "justify" (δικαιόω) by the
adjective in Romans 5:19, "the many will be made righteous" (δίκαιοι). The Latin West read
Paul's Greek through its own *iustificare*. James Barr called the first kind of move the root
fallacy. Neither is wrong in itself, because kindred words often do share a sense. But the
argument then rests on that, and should say so.

The vocabulary lists which words are kin, and how: as cognates in one language, or as a word
and its translation (`Lexeme.kin`). A move **shifts** when a premise has one word, and the
conclusion uses, or says what means, a kindred word that no premise has at that place
(`Move.shifts`). If a premise says the first word bears the second's sense there
(`Statement.bears`), the shift is granted. If nothing says so, the move holds on that
condition, as it does on an unstated sameness of sense (`Move.unbridged`).

**Caught.** The verb read by its adjective (`adjectiveForVerb`), and the Greek read by the
Latin (`latinForGreek`). **Passed over.** The same move with the bridge stated
(`adjectiveBridged`), and a move that has the verb's own evidence beside its adjective
(`verbItself`), which reads nothing by anything. `wordshift_cases` pins them.

A move can also take a word's sense from no word at all. "God's verdict brings about the
sinner's renewal, so the verb 'justify' means to make righteous" draws the verb's sense from a
claim about what God does. Barr called reading a doctrine into each use of its word
illegitimate totality transfer. A move **draws a sense from elsewhere** when its conclusion says
a word means something at a place, and no premise gives that sense to the word, to a kindred
word the move reads it by, or as someone's reading of it, and no premise is a text, from whose
setting the sense could be read (`Move.sensesFromElsewhere`). It is
reported, not charged: the word may yet have the sense, but the move has not shown it from the
word. `elsewhere_cases` pins the doctrine case as caught, and the kindred-word, translation and
own-evidence cases as passed over.

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
(`lexicalLine`) argues that Paul's "justify" does not mean to make a person inwardly just. When
the check was first run, its premise about the word had two halves: Paul's "justify" gives a
verdict, and "it does not mean to make a person good". The second half was the line's
conclusion. Trent's reading of Paul's word denies that half and keeps the first, since the
justified "are not only reputed, but are truly called, and are, just" (Session VI, chapter 7).
So as an answer to Trent, the library's own line begged the question.

The premise now says only that the word gives a verdict, which is what its lexical sources say,
and the line has to reach "and nothing more" from its other grounds: Paul's other words for
renewal, and the rule that a word means no more than its context requires. The checks then
found what a reader would expect. Trent's reading, which keeps the verdict and adds renewal, is
now an argument against that step under every standard, where before it had only denied a
premise (`trent_dissents_from_the_definition_steps`). The line still delivers its conclusion;
the step it rests on is disputed, and the page on why each step is rated as it is says so.

### Circular reasoning

The same lookup runs over a whole article. One move rests on another when what the first
concludes carries a premise of the second, and a circle is a chain of such moves that comes back
to its start. In `threeCircle`, Romans 3:28 teaches faith alone because faith is the only means;
works are no means because of what Romans 3:28 teaches; and faith is the only means because
works are none. Every move is on the circle. In `chain`, the last move rests on what the text
says instead, and nothing comes back.

A circle takes at least two moves. "Faith is a means of justification, and works are not, so
faith is the only means" (`strongerConclusion`) has a conclusion that entails its first premise,
by what "only" means, and it is still no circle: a conclusion may say more than its premises,
and nothing the move assumes was drawn from it. So a move's edge to itself is left out.

Two such moves to the same conclusion are no circle either (`twoRoutes`). Each conclusion
carries the other move's premises, because it carries its own, but they are two routes to one
place: neither draws from the other anything it does not already assume. Sola scriptura's
eliminative line and Geisler's Tradition 0 line are such a pair, both concluding that Scripture
is the sole infallible rule. So the check leaves out an edge between two moves with one
conclusion, and a circle runs through different conclusions. `circle_cases` pins all four
cases.

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

## Straw man

A straw man answers a view its holder does not hold. The classic case in this debate runs:
Trent teaches that a person's own works are enough to justify him, but Romans 3:28 says a
person is justified "apart from works of the law", so Trent is wrong. Trent's first canon on
justification condemns the very view the argument answers: it anathematises whoever says that a
person can be justified before God by their own works, without the grace of God through Jesus
Christ.

To check that, the library needs a record of what Trent holds, and it uses its own: the claims
of an argument that it cites as a voice's position, given to the check voice by voice. What a
position asserts is what its holder holds, so a claim Trent's position asserts and a claim that
"Trent held" something are read alike. Each attribution a move makes, that someone held a
content (`.heldBy`) or read a word in a sense (`.glosses`), is then one of four things:

- **fair** — a claim of the record bears it out, and none contradicts it;
- **unfair** — a claim of the record contradicts it, and none bears it out;
- **disputed** — the record does both, because what the voice held is itself argued;
- **unrecorded** — the record says nothing either way, and the attribution is the move's to
  support.

A move answers a straw man when an attribution is unfair and its conclusion cannot be held with
what it attributes (`Move.strawMen`). The check reports the attribution and the claims that
contradict it.

**Caught.** The case above, with Trent's canon in the record as "Trent held that works are not
enough for justification" (`ownWorks`). The move's attribution is unfair, and its conclusion
denies what it attributes.

**Passed over.** A move that takes Trent at its word is not a straw man, whatever else is wrong
with it. Trent holds that works done in grace merit an increase of justification (Session VI,
chapter 16); a move that says so and denies it (`meritAnswered`) makes a fair attribution. The
grammar keeps works in general (`works`) apart from works done in grace (`worksOfFaith`), and
that is why the two cases come apart.

**Reported, not charged.** A move that cites Trent for what Trent condemns, and leans on it
rather than answering it (`citedForItsDenial`), misattributes without answering anyone. The
check lists it among `Move.misattributions` and does not call it a straw man.

**Disputed, and not charged.** What a voice held can itself be the question. E. P. Sanders
argued that the picture of the Judaism of Paul's day as a religion of earning salvation by
works, which he traced to Ferdinand Weber, misreads its sources. A move that credits that
Judaism with the view and denies it (`legalism`) rests on one side of that argument, so the
check reports the attribution as disputed, names the claims on each side, and leaves the
weighing to the dispute over what Judaism held.

`strawman_cases` pins these cases, with one attribution the record says nothing of and one
reading of a word, Augustine's "justify" as to make righteous, that it bears out.

The check is only as good as its record. An attribution the record contradicts may show the
record wrong, so the report names the claims it relied on, and those claims carry their own
citations. Two things are not seen yet. A misread *word* is reported as an attribution but is
never charged as a straw man, because the check does not yet tell when a conclusion answers what
a reader took a word to mean. And when the library checks its own lines (below), the record is
thin: an argument's only claims about what a voice held are the few written as attributions, so
most of what the library knows of Trent, written as Trent's doctrine, is not yet on it.

## Leaving out what a voice also said

A move can cite a voice fairly and still cite it selectively. Augustine explains "being
justified" as "being made righteous", and in the same chapter gives a second way of taking it,
"deemed, or reckoned as just" (*On the Spirit and the Letter* 26.45). A move that cites the
first is borne out by the record, so the straw-man check passes it. It has still left
something out. The omission check compares each reading a move cites a voice for with every
other reading the record gives that voice for the same word, and lists the ones the move does
not mention (`Move.omissions`). It does not say the move is wrong to prefer one. It says what a
reader is owed.

**Caught.** Against a record in which Augustine read the word both ways, a move citing one
reading (`citedForOne`). **Passed over.** The same move citing both (`citedForBoth`), and the
first move against a record of one reading only. `omission_cases` pins them.

The check compares readings of a word (`Statement.glosses`). It does not compare what a voice
held, because whether one held content leaves another out is a question about the contents,
which the reasoner does not yet decide.

## Whose reasoning is checked

The library is written for readers who hold Scripture to be the word of God, and these checks
are not a way of finding fault with it. A verse enters a move only as a premise, as what the
verse says, and the checks read moves, never premises. A move is someone's reasoning from the
texts: Trent's, Calvin's, Moo's, or a line the library proposes. Every line of reason cites who
draws its step, and every finding names that reader, so the report says "Schreiner's line needs
δικαιόω to keep one sense", never "Paul's".

Scripture also reasons. Paul argues in Romans 4:3–5 from Genesis 15:6: "Abraham believed God,
and it was counted to him as righteousness", so "to the one who does not work but believes …
his faith is counted as righteousness". A line that sets out such reasoning cites its step to
Scripture itself, and it is never charged. If it needs "counted" (λογίζομαι) to keep one sense
from Genesis to Romans, that is reported as what a reader must hold to follow the text, apart
from the findings against readers. If the encoding of such a line would read a word two ways or
argue from silence alone, the build still fails, and the fault is the encoding's: it has read
the text wrongly. The case `FallacyCases.Scriptural` sets out Paul's reasoning both ways, once
cited to Scripture and once as a reader's line, and pins how each is reported.

## Checking your own lines

A **package** is a set of arguments built on the library, as the worked arguments are. Read
through its argument's meanings, every line of reason in a package is a move.
`#check_fallacies under N` runs the move checks over every line under the namespace `N`, and
reports, for each argument, every line named with the reader its step is cited to:

- how many of its lines it could read, and how many set out Scripture's own reasoning;
- the lines that read a word two ways and need it one;
- the lines whose premise carries what they deliver, and who denies that premise;
- the lines that argue from silence alone;
- the lines that rest on one another in a circle;
- the lines that answer a view the argument's own record says its holder does not hold;
- the lines that attribute a view, and how each attribution stands to the record;
- the lines that are conditional on a word keeping its sense, with the words;
- the lines that read one word by a kindred one without stating the bridge;
- the lines that cite a voice for one reading and leave out another the record has;
- the lines that conclude what a word means from no use or reading of the word;
- and, apart from all of these, what a line of Scripture's own reasoning asks of its reader.

For a line, the record of a voice is the argument's other claims that say, or deny, what the
voice held or how it read a word. The line's own claims are left out of it, because a ground
that says "Sanders' Judaism held this" cannot be what bears itself out. Today the report lists
two sola fide lines that attribute a view, Sanders' account of Second Temple Judaism
(`sandersLine`) and Augustine's reading of "justify" (`trentWordLine`), and finds both
*unrecorded*: the argument cites nothing else about what either voice held.

It fails the build on three of these, a line that reads a word two ways, one that argues from
silence alone, or one that answers a straw man, unless the line declares it (below): the library
may not do what it checks articles for. A carried premise is reported
but does not fail the build, because whether it begs the question depends on whom the line is
addressed to. A circle of lines is reported and does not fail the build either. A line does not
record which position holds it, and a circle is a fault only in one position's reasoning; an
argument may also encode a circle on purpose, as the charge it weighs. Pin the report with
`#guard_msgs`, as `TestimonyArguments.Checks` does, so that a change in what the checks find is
a change a reviewer sees.

A line is read only when every claim it uses has a meaning. The
[maturity page](./maturity.md) counts, for every argument, how many of its lines are read and
what the checks found in them.

### Declaring a fallacy where it is committed

Sometimes the clearest answer to a reader's question is the argument a writer actually makes,
fallacy and all, set out so that the reader can see where it breaks. A rival's line may commit
one of the three faults if it says so, beside the line, with the fault's witness: which word it
reads two ways, which text's silence it argues from, which attribution answers a view its
holder does not hold, and which of the argument's claims contradict that attribution. The
declaration is a definition named for the line, `<line>.expected`, a list of findings
(`Testimony.Semantics.Finding`):

```lean
/-- Answers a straw man, and says so. -/
def strawMan : Line Claim :=
  { name := "Trent made to say it"
  , grounds := [p .trentSaysWorksSuffice]
  , step := p .trentSaysWorksSuffice ➝ p .worksDoNotSuffice
  , delivers := p .worksDoNotSuffice }

/-- The straw man `strawMan` answers, declared with the claim that contradicts it. -/
def strawMan.expected : List (Finding Claim) :=
  [.strawMan [(.heldBy .trent worksSuffice, [.trentDeniesOwnWorks])]]
```

The check then runs both ways. The build still fails if a declared finding is not found, or is
found with another witness, or if a fault is found that no declaration names. So a declaration
can never hide a fault the line does not commit, or one it commits differently. A declaration
may also name an unstated condition, a word whose sense the line needs kept
(`.conditionalOn`), and it is held to the same test. It may not go on Scripture's own reasoning
or on a step the library proposes itself, because the library may not commit what it checks
others for. Every finding stays in the report, declared or not, so the same checks are seen to
run on every side.

What a declaration does not do is answer the fallacy. A declared fault is there to be shown and
answered. When a [bundle](./bundles.md) quotes the line in an exchange, a later turn must answer
it there, or the bundle does not build.

The cases `FallacyCases.Declared` and `FallacyCases.Misdeclared` pin both directions: two lines
whose declared faults are borne out, and three declarations the build must refuse.

### Making the build refuse a case

To test that a check fails where it should, give it a case of its own and pin the failure. The
end of `FallacyCases` does this with a small argument, `Refused`, which is the debate this page
opened with. Its line "Paul against James" sets Romans 3:28 against James 2:24 while reading
"justify" as a verdict in the one and a showing in the other; its line "Not in the verse" argues
from the missing word alone; and its line "Trent made to say it" answers a view of Trent's that
the case's own record of Trent contradicts. `#check_fallacies` is run over it inside
`#guard_msgs`, with the error it must report written out:

```lean
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
```

If the check ever stopped refusing any of the three, the message would change, and the build would
fail. This does not settle whether the Protestant reply in the opening debate is right. It shows
what the reply commits its maker to: once "justify" is read as a verdict in Paul and a showing in
James, the two verses can no longer be set against each other, by either side.

## What the checks do not decide

None of them says whether a premise is true. A move that equivocates may have a sound argument
nearby; a premise that carries its conclusion may be true; and many arguments from silence are
good ones, because their expectation is well grounded. The checks say where a move's weight
falls, so that a reader can see what to weigh. The library weighs it where it weighs everything
else, in its disputes, and reports what the solver computes, whichever way it goes.
