# Meanings and articles (draft)

> **A design note, with a working draft.** Nothing here changes what any argument proves. The
> modules it describes sit outside the arguments, and no argument's verdict reads them.

The library checks arguments it has encoded itself. This note is about checking an argument
someone else has *published* — an article, a tract, a chapter that claims a position is
unbiblical or fallacious — and saying, as the library's own commentary, whether its claim can be
defended. Such an article does not come as a premise list. It quotes, attributes, asserts and
infers, and it can be careful in one paragraph and careless in the next. To check it fairly is to
check each of those acts for what it is, and then to weigh what it claims against everything the
library already holds.

That needs three things the library did not have: a way to say what a claim *means*, so that two
claims can be compared; a way to model what an article *does*, move by move; and a way to hear an
article's claim as a position in a dispute, so that whether it can be defended is computed, like
every other verdict here.

## Where the parts live

| Layer | Modules | What it is |
|---|---|---|
| Generic | `Testimony.Semantics.Vocabulary` | one shared vocabulary of words, senses, relations |
| | `Testimony.Semantics.Grammar` | how they combine into a statement, and queries over statements |
| | `Testimony.Semantics.Meaning` | `HasMeanings`: any argument's claims, given meanings; `HasJoins`: the pairs whose meanings exclude or entail each other |
| | `Testimony.Semantics.Discourse` | an article as moves, and what each move assumes |
| Per argument | `Testimony.Meanings` | one `HasMeanings` and one `HasJoins` instance for each argument |
| Commentary | `Testimony.Articles` | one module per published article examined |
| Weighing | `Testimony.Logic.Contest` | whether a dispute over a claim survives weighing |

Nothing in the generic layer names an argument. Every argument has an instance: sola fide is
analysed; sola scriptura, the virgin birth and Spirit baptism in part, the claims whose meanings
bear on a join; and the other two are registered with their citations' labels and marked
unanalysed, so that they are counted from the start (each module's `coverage_now`).
`Testimony.Checks.Meanings` fails the build for an argument with no instance, so a new argument
is registered when it is added. It also fails the build for an argument whose joins are not listed and pinned, or
whose meaning postulates come from anywhere but those lists
([computed ratings](computed-ratings.md#meaning-postulates)).

## What a claim means

Every argument names its atomic claims in a type of its own. `dikaioIsForensic` is a name with
a docstring; to the library it is opaque. So it cannot answer the questions a reader asks of the
whole collection — every claim about δικαιόω, every passage read two ways, the same claim in two
arguments — and it cannot see an article move from one passage to another under one word.

A meaning is a term built from the shared vocabulary. Its parts were each added because a claim
in the library needed them:

| Part | What it is | Examples |
|---|---|---|
| `Voice` | who speaks, writes, holds or reads | Paul, James, Trent, Augustine, Calvin |
| `Lexeme` | a word or fixed phrase, in its own language | δικαιόω, ἔργα νόμου, πίστις, ὕδωρ |
| `Sense` | what a word can mean, named for what it denotes | a verdict; to make righteous |
| `Concept` | what doctrinal claims are about | justification, faith, works, baptism |
| `Rel` | how one term stands to another | ground of; only means of; includes |
| `Statement` | what one atomic claim asserts | says, teaches, means, holds, wrote |

Three distinctions in it do most of the work.

- **The word and what it means are kept apart.** A textual claim is stated with the words as
  they stand; what a word denotes is a separate claim, `means`. Romans 3:28 says a person is
  *justified* by *faith* apart from *works of the law*; what those words mean in Paul is three
  further claims, each disputed. This is Barr's distinction between the word and the concept,
  which the sola fide argument already turns on.
- **`says` is not `teaches`.** What a passage says, in its own words, is textual. What it
  teaches, read rightly, is a reading, which a rival may read otherwise. Luke 7:47 says her sins
  are forgiven, for she loved much; that her love is the evidence of forgiveness and not its
  ground is what the Reformed say it teaches. The two are never the same claim, as quotation is
  never prediction.
- **A sense can be the same, or not, at two places.** `sameSense` states that a word means the
  same in two texts. Every contradiction between two texts depends on it, for every word they
  share, and most arguments never say so.

The atoms are not replaced. An argument keeps its own claim type and its proofs are untouched;
its instance says what each atom means, as `cite` says who holds it. Ninety-five of the hundred
and seven sola fide atoms are analysed; twelve — the stories of the thief and the tax collector, a
curse, a command, a disjunction, and the claims about texts and their translations — are marked
unanalysed and counted, not forced.

What the meanings already make computable, from the meanings alone, for any argument:

- **The contested readings are found, not listed.** For sola fide: δικαιόω in Paul, the
  believing of John 6:29, doing the will in Matthew 7, keeping the commandments in Matthew 19,
  the water of John 3:5 four ways, the fire of Matthew 3:11 three ways (`contested_length`).
  Nothing else turns up.
- **Every claim about a word.** Thirteen sola fide claims turn on δικαιόω (`about_dikaioo`).
- **The same claim in two places.** An article's quotation of James 2:24 means exactly what the
  library's atom for the verse means (`jamesSays_is_the_library's`), so the two are one claim.
  Once a second argument is analysed, the same holds between arguments.

## What an article does

`Testimony.Semantics.Discourse` models an article as a list of moves. Each move records who
makes it, the article's own words, verbatim, and the act they perform: an assertion, a
quotation, an attribution, or an inference from premises to a conclusion.

The first check is the one that needs the grammar. An inference that sets one text against
another — or a text against a doctrine — assumes, for every word they share, that it means the
same in both. `Move.unstated` computes, from the move alone, the senses it needs and does not
state; `Move.meets` finds the claims of any argument that deny them. A move with unstated senses
is not thereby fallacious. It is **conditional**, on exactly those senses.

## Commentary: whether an article's claim can be defended

The library's verdicts already say, of a position, whether it can be defended. A position is
**indefensible** when no admissible set holds it: something defeats it, and nothing the dispute
can hold answers that defeat. Trent's definition, read as a claim about what Paul's word means,
is indefensible in the sola fide dispute (`trent_on_pauls_word_indefensible`). That is the
library's own judgment, checked, and an article that argued the same would meet the same
verdict, for the same stated reason.

So an article's claim is judged the same way, in four steps:

1. **Model the move**, verbatim.
2. **Make its unstated assumptions explicit** as premises, from `Move.unstated`. A position is
   answerable for what it needs, not only for what it says.
3. **Hear it as a party** in the argument's dispute, alongside every existing party.
4. **Report what the solver computes**: indefensible, defensible but not forced, or forced —
   whichever way it goes, and with the defeats that decide it.

This is commentary, not reproduction: the verdict is the library's, and it is a checked result
about the article's claim, not a summary of the article.

## Whether a dispute makes sense

A premise is rated `disputed` when a cited source grants its grounds and denies its conclusion.
That is a fact about the literature: someone denies it. Whether the denial, stated as a position
and weighed against everything else, can still be defended is a further fact, and
`Testimony.Logic.Contest` makes it a computed one.

- A claim is **contested** in a dispute (`Contested`) when one party holds it, another denies
  it, and each can be defended. The rating `disputed` is then what the weighing finds.
- A claim's denial is **answered** (`DenialAnswered`) when every party that denies it is
  indefensible. The claim is disputed in the literature, and the denial does not survive the
  weighing; a page should say both.

The weighing takes the cited ratings as its input, so a contest result does not make ratings out
of nothing. It says what the ratings already in the library imply once the positions that hold
and deny a claim are heard together. A rating still moves only with a new, cited argument.

## A worked example

Kenneth Howell, ["Aren't We Saved by Faith Alone?"][howell], *Catholic Answers Magazine*, 2003,
is a dialogue between a Protestant objector and a Catholic. `Testimony.Articles.Howell2003`
models four of its moves, quoted from the publisher's page, and hears one of them.

**The argument about works.** *"If Paul and James mean the same thing by works, then they
contradict one another. Since you and I both believe that the Bible cannot contradict itself, we
must agree that Paul and James mean two different things by the word works."* Romans 4:2–5 and
James 2:24 share three words, not one — works, justify and faith — and their clash needs all
three the same. The Bible's consistency rules out only that all three agree; it does not choose
*works* (`consistency_does_not_choose_works`, refuted by the reading on which James uses
"justify" otherwise, as Moo and Calvin read him). The article does give a reason for its choice —
Paul's "works *of the law*" — and that reason is weighed where the library weighs ἔργα νόμου.

**The argument from the phrase.** *"The phrase 'faith alone' does occur in the New Testament:
one time, in James 2:24. There the inspired apostle denies that justification is from faith
alone."* To deny *sola fide* by this, James's "faith" and "justify" must be the ones the
Reformers' formula uses of Paul. The move does not say so (`faithAlone_unstated`), and those are
exactly the two senses one claim in the library denies, `james2_24Compatible`
(`faithAlone_meets_the_library`).

**Heard in the dispute, it cannot be defended.** Stated as a position, with the senses it needs
made explicit, and heard with every party to the sola fide dispute and with James's own words
about faith, the move falls (`howell_indefensible`). James calls the faith he denies justifies
dead (2:17, 2:26); Trent reads it so (Session VI, ch. 7); the Reformers' confession calls the
faith that alone justifies "no dead faith" (Westminster XI.2). The denial the move needs does not
survive the weighing (`faithDenialAnswered`). The article's other case from James — that works
"actually justify" — is the Catholic reading of James's "by works", weighed in
`Testimony.Arguments.SolaFide.James`: as a claim about James's word it cannot be defended
(`trent_on_james_word_indefensible`); as a claim about what works do before God it can, and is
not forced (`trent_on_works_defensible`).

**The same check, on the other side.** The objector's reply — James 2:14 "is dealing with the
problem of those who claim faith but who don't show it by their works" — takes "faith" in 2:14
for "faith" in 2:24 without saying so (`deadFaith_unstated`). That is the Reformed reading's own
condition, and the claim that carries it, `james2TargetsDeadFaith`, is rated `disputed` too.

## What each position rests on

`Testimony.Logic.Warrant` answers a reader's question about any position: *where does this rest
on someone's word alone?* Each cited work has a role — a text or lexicon, argued scholarship, a
binding decree or confession, or a theologian's own teaching — and a premise's warrant is the best
of its references: Scripture, evidence, authority alone, or the library's own assertion. A claim
*about* what someone holds is proved by their own text, so it rests on evidence.

The warrant is reported beside the verdicts and never weighed in them. A rule that discounted
authority inside the solver — "Scripture first, by default" — would decide the sola scriptura
dispute by fiat, since whether a council's or a confession's word binds is what that dispute is
about. And it applies to every side: in the James dispute (`james_warrants`) Trent's readings rest
on Trent's word, and the readings of the Greek on Pius XII's and Westminster's at "the original
outweighs any translation". The Reformed harmony rested on Westminster's word at "works are fruit,
not ground" until it was given the Assembly's own proof texts as a step (`fruitLine`); it rests on
Scripture now, and the step is still `disputed`, because Trent grants the texts and calls the
fruit merit.

The same check answers whether Rome contradicts itself over Trent's Latin texts
(`Testimony.Arguments.SolaFide.Vulgate`). Read as what the inspired authors wrote, Trent's "as it
is written" at Revelation 22:11 cannot be held with Pius XII's teaching that the original
outweighs any translation (`trent_as_the_inspired_text_contradicts_pius`). Read as Pius XII reads
Trent's decree — the Vulgate juridically authentic and free from error in faith — Rome is
consistent (`pius_reading_is_consistent`), and the two texts then rest on the Church's word
(`pius_reading_rests_on_authority`), which Pius XII asks to be confirmed from the originals; at
these verses the originals do not confirm it (`pius_finds_no_confirmation`).

## Computed ratings

A rating today is asserted, with a citation: `disputed` when a cited source grants a step's grounds
and denies its conclusion. That records that someone dissents, not whether the dissent is an
argument or only "I disagree". [Computed ratings](./computed-ratings.md) sets out the design for
telling them apart — five checks a dissent must pass to count as credible, under a stated standard
of evidence — and its first phase is built. It finds that Howell's move is a disagreement, not a
critique (`howell_asserts_his_denial`). Trent's denial that works are fruit, not ground, rests at
one claim on the council's word, so that step stands under the evidence standard and is disputed
under the tradition standard (`fruit_turns_on_the_standard`). And what James's δικαιόω denotes
turns on the standard in the same way (`james_word_turns_on_the_standard`). `Contested` and
`DenialAnswered` remain the checks of whether a dissent survives the weighing: the Howell hearing
shows one that does not (`faithDenialAnswered`), the James dispute one that does
(`worksContested`).

## What it would take to decide James

The library says a reading is right in one sense only: the dispute forces it. A reading is
forced when it is in the grounded extension — every rival reading is indefensible, given
premises that are cited and rated. Paul's word is forced in that sense
(`only_pauls_word_prevails`), because the lexical case rests on links rated above `disputed`
and nothing that attacks it is as strong. For James, four things are missing.

1. **The dispute now exists** (`Testimony.Arguments.SolaFide.James`), with the Catholic reading as
   two parties: James's word as the increase of justice, which cannot be defended; and what works
   do before God (canon 24), which can, against the Reformed harmony. What is left to decide is
   the second.
2. **The question splits by word and by verse.** What δικαιόω denotes at 2:21, 2:24 and 2:25;
   what πίστις denotes at 2:14, 2:17, 2:19 and 2:24; and whether each keeps its sense through
   the paragraph. The grammar can now state each as its own claim, and `sameSense` the claim that
   one word means the same at two verses.
3. **Evidence that discriminates between the readings**, each a cited premise:
   - 2:14 asks whether "*the* faith" can save — the faith just described, said and not shown. The
     article is in the Greek; that it points back is a reading, to be rated.
   - 2:21–23: Abraham is "justified by works when he offered up Isaac" (Genesis 22), and 2:23
     says this fulfilled Genesis 15:6, said of him years before. That one justification follows
     the other is in the texts; whether "justify" then means a second verdict, a showing, or an
     increase is where the readings part.
   - 2:18, "show me your faith", and the uses of δικαιόω elsewhere for being shown to be in the
     right (to be verified against a lexicon before any is cited).
4. **Ratings audited, not assumed.** Each step stays `disputed` until the rating auditor finds
   no cited reader who grants its grounds and denies its conclusion. If every step on both sides
   stays `disputed`, the solver will report that James is contested — as it now does — and the
   page will say so. A forced reading needs one side to rest on something the other cannot match.

The textual facts in the third item can also be checked against an annotated Greek text — that
the article stands in 2:14, which words recur through 2:14–26 — rather than cited alone
([MACULA Greek][macula] carries the syntax and Louw–Nida sense domains).

## The checks an article audit needs

Each common charge of fallacy is a question the library can make precise. Two are built; the
rest reuse machinery that exists, or that the open issues propose.

| Charge | What is checked | What does it |
|---|---|---|
| Equivocation | senses a move needs and does not state | `Move.unstated` — built |
| Non sequitur | does the conclusion follow from what the move states? | `refute_with` — built |
| Indefensible claim | can the move's position survive the dispute? | a hearing — built |
| False dilemma | does a move pick one reading where others are fair? | `Dilemma` |
| Straw man | does an attribution match what its subject holds? | meanings of the position |
| Misquotation | does a quotation say what the move says it says? | `says`, then the corpus |
| Cherry-picking | texts on the same words and relation the move ignores | a query over meanings |
| Begging the question | is the conclusion among what the premises assume? | commitment propagation |
| Double standard | is the article's own principle applied to its own moves? | a refutation on own terms |

Two of these are worth a word, because Howell's article already supplies them.

- **An attribution has readings, as a claim does.** The objector asks how the Church can teach
  "that we have to earn our salvation". Against the library's Trent, that is ambiguous: if
  "earn" means by our own efforts, Trent denies it, and the Catholic says so; if it means works
  done in grace meriting an increase of justification, Trent holds it
  (`worksMeritIncreaseOfJustification`). The grammar tells these apart — `works` and
  `worksOfFaith` are different concepts — so an attribution check can report which reading of
  the attribution is fair, rather than calling it a straw man or not.
- **An implicature is not an assertion.** The Catholic says Luther "added the word alone—but
  alone is not in the original Greek text". Both claims are true of the texts, and the move is
  modelled as asserting exactly them. What it may be taken to imply — that the reading was new
  with Luther — is a different act, and a check must not charge an article with what it only
  implies.

## Rules for checking someone else's argument

The library's own rules carry over, and four more follow from them.

- **Quote, do not paraphrase.** A move records the article's words exactly. A model of what an
  article "basically says" is a straw man in waiting.
- **Every voice gets the same check.** Howell's objector is checked as his Catholic is. An audit
  that only finds faults on one side proves nothing about the side it spared.
- **Report the verdict the solver computes.** An article's claim is indefensible only when the
  dispute says so. Howell's move is not, and the page says that.
- **Apply the article's principles to the article.** When an article states a principle — that
  the Bible cannot contradict itself, so two authors must mean different things by one word — the
  same principle applies to every word it uses that way.

## What comes next

1. **Meanings for every argument.** Sola scriptura, the virgin birth and Spirit baptism are
   analysed where a join turns on them; the other two are registered and unanalysed.
2. **A James dispute**, with the Catholic reading as a party, so that the question the Howell
   hearing leaves contested is asked directly.
3. **The remaining checks**, in the order of the table, each as a checked certificate that
   reuses `Because`, `Dilemma` and the solver.
4. **Articles as pages.** An audit is published prose like an argument page, generated from its
   docstrings.

[howell]: https://catholic.com/magazine/print-edition/arent-we-saved-by-faith-alone
[macula]: https://github.com/Clear-Bible/macula-greek
