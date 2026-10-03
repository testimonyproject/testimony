# Meanings and articles (draft)

> **A design note, with a working draft.** Nothing here changes what any argument proves. The
> modules it describes sit in `Testimony/Semantics/`, outside the arguments, and no verdict
> reads them.

The library checks arguments it has encoded itself. The question this note answers is how it
could check an argument someone else has *published*: an article, a tract, a chapter, which
claims that a position is unbiblical or fallacious. Such an article does not come as a premise
list. It quotes, attributes, asserts and infers, and it can be careful in one paragraph and
careless in the next. To check it fairly is to check each of those acts for what it is, against
the texts and against the readings and ratings the library already has.

That needs two things the library did not have: a way to say what a claim *means*, so that two
claims — in two arguments, or in an argument and an article — can be compared; and a way to
model what an article *does*, move by move.

## What a claim means

Every argument names its atomic claims in a type of its own. `dikaioIsForensic` is a name with
a docstring; to the library it is opaque. So it cannot answer the questions a reader asks of the
whole collection — every claim about δικαιόω, every passage read two ways, the same claim in two
arguments — and it cannot see an article move from one passage to another under one word.

`Testimony.Semantics.Grammar` gives a claim a meaning: a term built from a fixed vocabulary.
Its parts were each added because a claim in the library needed them:

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
a total function, like `cite`, says what each atom means. `Testimony.Semantics.SolaFide` does
this for the eighty-four sola fide atoms. Seven are still marked unanalysed — the stories of the
thief and the tax collector, a curse, a command, a disjunction — and are counted, not forced.

What the meanings already make computable, from the meanings alone:

- **The contested readings are found, not listed.** Every word given two senses at one place:
  δικαιόω in Paul, the believing of John 6:29, doing the will in Matthew 7, keeping the
  commandments in Matthew 19, the water of John 3:5 four ways, the fire of Matthew 3:11 three
  ways (`contested_length`). Nothing else turns up.
- **Every claim about a word.** Twelve sola fide claims turn on δικαιόω (`about_dikaioo`).
- **The same claim in two arguments.** Once a second argument has meanings, two atoms with the
  same `Statement` are the same claim, and the bridge between them can be generated rather than
  written by hand. This is the shared vocabulary that cross-argument articles need, grown from
  the claims rather than designed in advance.

## What an article does

`Testimony.Semantics.Discourse` models an article as a list of moves. Each move records who
makes it, the article's own words, verbatim, and the act they perform: an assertion, a
quotation, an attribution, or an inference from premises to a conclusion.

The first check is the one that needs the grammar. An inference that sets one text against
another — or a text against a doctrine — assumes, for every word they share, that it means the
same in both. `Move.unstated` computes, from the move alone, the senses it needs and does not
state. A move with unstated senses is not thereby fallacious. It is **conditional**, on exactly
those senses; whether the condition holds is the question of what the word means, which the
library's disputes rate. So the check reports the condition, and points at the library's rated
claims about it.

## A worked example

Kenneth Howell, ["Aren't We Saved by Faith Alone?"][howell], *Catholic Answers Magazine*, 2003,
is a dialogue between a Protestant objector and a Catholic. `Testimony.Semantics.Howell` models
four of its moves, quoted from the publisher's page.

**The argument about works.** *"If Paul and James mean the same thing by works, then they
contradict one another. Since you and I both believe that the Bible cannot contradict itself, we
must agree that Paul and James mean two different things by the word works."* Romans 4:2–5 and
James 2:24 share three words, not one — works, justify and faith — and their clash needs all
three the same. The Bible's consistency rules out only that all three agree; it does not choose
*works* (`consistency_does_not_choose_works`, refuted by the reading on which James uses
"justify" otherwise, as Moo and Calvin read him). The move needs a reason for its choice. The
article gives one — Paul's "works *of the law*" — and that reason is weighed where the library
already weighs ἔργα νόμου, at a premise rated `disputed`.

**The argument from the phrase.** *"The phrase 'faith alone' does occur in the New Testament:
one time, in James 2:24. There the inspired apostle denies that justification is from faith
alone."* To deny *sola fide* by this, James's "faith" and "justify" must be the ones the
Reformers' formula uses of Paul. The move does not say so (`faithAlone_unstated`), and those are
exactly the two senses one claim in the library denies, `james2_24Compatible`, rated `disputed`
(`faithAlone_meets_the_library`). The article argues the sense of *works* at length and the
sense of *faith* not at all, though the objector raises it. By its own principle — consistency
picks a word only with a reason — the move needs an argument it does not give.

**The same check, on the other side.** The objector's reply — James 2:14 "is dealing with the
problem of those who claim faith but who don't show it by their works" — takes "faith" in 2:14
for "faith" in 2:24 without saying so (`deadFaith_unstated`). That is the Reformed reading's own
condition, and the library rates the claim that carries it, `james2TargetsDeadFaith`,
`disputed`.

**What the example does not show.** It does not show which reading of James is right, and the
check is not built to. It shows what each move costs, in senses, and where the library weighs
those senses. A reader can then see that the article's strongest-sounding sentence — the only
"faith alone" in the Bible is denied — is its weakest move, and see exactly why, without being
asked to take anyone's side on James.

## The checks an article audit needs

Each common charge of fallacy is a question the library can make precise. One is built; the rest
reuse machinery that exists, or that the open issues propose.

| Charge | What is checked | What does it |
|---|---|---|
| Equivocation | senses a move needs and does not state | `Move.unstated` — built |
| Non sequitur | does the conclusion follow from what the move states? | `refute_with` — built |
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
  implies. Implicatures get their own act, and a lower standing, when they are modelled.

## Rules for checking someone else's argument

The library's own rules carry over, and four more follow from them.

- **Quote, do not paraphrase.** A move records the article's words exactly. A model of what an
  article "basically says" is a straw man in waiting.
- **Every voice gets the same check.** Howell's objector is checked as his Catholic is. An audit
  that only finds faults on one side proves nothing about the side it spared.
- **Report the condition, not the charge.** A move with an unstated sense is conditional on it.
  It is an equivocation only where the sense it needs is one the evidence denies, and then the
  page says how firmly, from the library's ratings.
- **Apply the article's principles to the article.** When an article states a principle — that
  the Bible cannot contradict itself, so two authors must mean different things by one word — the
  same principle applies to every word it uses that way. That is the fairest test there is,
  because it is the article's own.

## What comes next

1. **Meanings for every argument.** The virgin birth and sola scriptura next. Bridges between
   arguments then come from equal statements.
2. **The remaining checks**, in the order of the table, each as a checked certificate that
   reuses `Because`, `Dilemma` and the solver.
3. **Articles as pages.** An article audit is published prose like an argument page, generated
   from its docstrings, with the article entered in the bibliography first.
4. **The corpus.** Textual claims — that a word occurs in a passage, that "alone" is absent from
   Romans 3:28 — are checkable against an annotated Greek text, such as [MACULA Greek][macula],
   which also carries Louw–Nida sense domains.

[howell]: https://catholic.com/magazine/print-edition/arent-we-saved-by-faith-alone
[macula]: https://github.com/Clear-Bible/macula-greek
