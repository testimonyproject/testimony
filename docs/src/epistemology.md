# How each side says we know (draft)

> **A design note, with its first phase built.** Nothing here changes a verdict or a rating.
> It names the rules the ratings were already computed under, gives each its holders, and
> checks whether each side keeps the rule it professes.

A Protestant and a Catholic arguing over Romans 3:28, "a man is justified by faith without the
deeds of the law", are seldom arguing only over Romans 3:28. Underneath is a disagreement about
how anything is known from Scripture at all. The Westminster Confession says that "the
infallible rule of interpretation of Scripture is the Scripture itself" (I.ix), and that the
supreme judge of controversies "can be no other but the Holy Spirit speaking in the Scripture"
(I.x). The Council of Trent receives, beside the written books, the traditions "received by the
Apostles from the mouth of Christ himself, or from the Apostles themselves, the Holy Ghost
dictating" (Session IV, in Waterworth's translation), and the Second Vatican Council says
Scripture and tradition are to be accepted with the same devotion (*Dei Verbum* 9). The
library's own evidence standard asks for neither: only the texts, and evidence anyone can check.

An argument that quietly assumes one of these answers has decided the dispute before hearing
it. So the library names them.

## What an epistemology is here

An **epistemology** is how a side holds that something is known: the rule by which it decides
what counts as a reason. The library writes each one as a single value with five parts
(`Testimony.Logic.Epistemology`):

- **what it admits as grounds.** Every claim in the library rests finally on one of four
  things: a text of Scripture; evidence anyone can check, such as a critical text, a lexicon or
  argued scholarship; the word of a council, a confession or a theologian; or a premise the
  library puts forward without a source of its own
  ([what each position rests on](./semantics.md#what-each-position-rests-on));
- **how an objection to a Scripture-only step must be argued.** An argument moves from claims
  to a conclusion by **steps**: each step is a "because", and each claim is something the
  argument asserts. Some rules hold that a step resting on Scripture alone can be answered only
  from Scripture;
- **the principles of reading it licenses**, such as "a word means no more than its context
  needs";
- **how it takes an argument from silence**: never, or only when the argument says why the text
  would have mentioned the thing had it been so
  ([Checking an argument for fallacies](./fallacies.md#argument-from-silence)), or freely.
  Where a rule's source does not say, the library does not guess;
- **who holds it**, cited, as a claim is.

Four are encoded (`TestimonyArguments.Epistemologies`):

| Rule | Held by | Grounds it admits | An objection to a Scripture-only step |
|---|---|---|---|
| Scripture its own interpreter | Westminster Confession I.vi, I.viii, I.ix, I.x | Scripture, evidence | must itself rest on Scripture |
| Scripture and tradition | Trent, Session IV; *Dei Verbum* 9 | Scripture and the apostolic tradition, received together; evidence; Catholic authority only | may rest on tradition or evidence too |
| Scripture in the mind of the Church | Florovsky, *Bible, Church, Tradition*; Ware, *The Orthodox Church* | Scripture, read within the consensus of the Fathers and the received councils; evidence; Orthodox authority only | may rest on tradition or evidence too |
| Evidence anyone can check | the library's own evidence standard | Scripture, evidence | may rest on evidence too |

**Each tradition's own authority, and no other's.** The Catholic rule admits a council's, a
Father's or the Church's teaching as the Catholic tradition receives it, and not Westminster's
word or Calvin's. The Orthodox rule admits the Fathers and councils as the Orthodox Church
receives them. Whose authority a claim rests on is read from the tradition its citation records
as advancing it. That is a proxy, not a record of who wrote each work, and a Father both
traditions receive is counted by the tradition that cites him.

The Catholic and Orthodox rules admit grounds alike in kind, and they still differ. Florovsky
rejects Trent's model of two sources outright: for him tradition adds nothing to Scripture, but
is the Church's living understanding of it, with no single office as its infallible
interpreter. The library's checks of claims cannot see that difference yet; it lies in how a
reading is reached, not in what it rests on.

None of the sources speaks to arguments from silence, as cited, so none of the rules does. Only
the library's rule records a principle of reading, the one it cites to Silva. The others each
have their own, and they will be recorded when they are cited in their own words.

## The standards, given their holders

The library's credibility checks ([Computed ratings](./computed-ratings.md)) have always been
run under three standards, evidence, tradition and Scripture. Each was a rule about which
grounds count, written without a holder. Two turn out to say exactly what an encoded rule says
(`two_standards_are_rules`):

- the **scriptural** standard is Westminster's rule;
- the **evidence** standard is the library's own.

The **tradition** standard is neither the Catholic rule nor the Orthodox one. It admits a
council's, a confession's or a theologian's word from any tradition, Westminster's and Trent's
alike, where each of those rules admits only its own. So a rating computed under the tradition
standard is computed under every tradition's authorities at once, which is no one's rule. No
rating and no verdict moved; what changed is what the page can say each standard is.

## Does each side keep its own rule?

The charge of a double standard is common in debate: you ask me for Scripture and rest your own
case on a confession. The library can now check it for claims. A reading is held to the rule of
the side whose reading it is, and every claim it asserts is checked against that rule
(`ArgumentPackage.heldTo`).

Which rule a reading professes is declared, reading by reading, with the reason. It is not read
off the reading's citations, because a Reformed reading that cites a Catholic exegete is still a
Reformed reading. In the dispute over faith alone (*sola fide*):

- the Reformed readings profess Westminster's rule: faith alone from Paul, from Jesus' words at
  Luke 7:50 and in John 6, and from Peter at Jerusalem; Paul's gospel against Trent's
  definition; and the Reformed answer to Chrysostom;
- Trent's two readings profess Trent's;
- the scholars' readings, Sanders and Dunn, their critics, the apocalyptic reading and Jervell,
  and two arguments about what Paul's word means, the word study and Romans 4, are held to the
  library's evidence rule: they argue as scholars, from texts and lexica;
- Aquinas, Luther and Chrysostom are held to none. None of them wrote Trent's rule,
  Westminster's or the Orthodox one. Aquinas has his own, and Luther's tradition has the
  Formula of Concord; the library cites neither as a rule. Chrysostom is a Father whom the
  Orthodox and the Catholic traditions both receive, and calling him either's would be a claim
  the library does not argue. Holding any of them to another's rule would give him a rule he
  did not write.

**What the check found, and what changed because of it.** When the check was first run, four
Reformed readings failed it: faith alone from Paul, from Peter and from John 6, and the
Reformed answer to Chrysostom. Each asserts that justification and sanctification are
inseparable but distinct. Justification is God's pardoning a sinner and accepting him as
righteous; sanctification is his making that sinner holy over a life; the claim is that the two
always go together and are not the same thing. The library had cited it to the Westminster
Confession (XIII.1, XI.1) and to Calvin (*Institutes* III.xi.6), and to nothing else. Westminster's
rule admits Scripture and evidence, not a confession's or a theologian's word, so as encoded the
four readings rested a claim on what their own rule refuses their rival.

The fault was in the earlier encoding, not in the readings. A Reformed reader cites the
Confession as a summary of Scripture, printed with its Scripture proofs, and the library had
cited the summary without the proofs. It had also cited the wrong summary. Confession XIII.1 is
about sanctification alone and does not state the claim; the Larger Catechism does, at question
77: "Although sanctification be inseparably joined with justification, yet they differ". Under
each clause it prints its proofs: 1 Corinthians 6:11 and 1:30 for "inseparably joined", and for
the differences Romans 4:6 and 8, Ezekiel 36:27 with Hebrews 9:13–14, Romans 3:24–25, and
Romans 6:6 and 14. Calvin's text for Scripture distinguishing the two is 1 Corinthians 1:30.

So the encoding was changed. The claim is now cited to the Larger Catechism, with its proofs,
in both arguments that assert it, sola fide and the canonical witness. Every party held to a
rule now keeps it (`sola_fide_own_rules`). No rating and no verdict moved, because nothing
weighs a claim by what it rests on. What moved is what a reader can check: the texts are on
the page.

This is what the check is for. A rule each side professes, applied to each side's own claims,
found a premise the library had cited on a confession's word alone, and pointed to the wrong
place. Neither showed in any verdict.

**Trent's readings keep their rule, and could have failed it.** Each rule admits authority only
from its own tradition, so a Catholic reading resting a claim on Westminster's word would fail
Trent's rule as a Reformed reading resting a claim on Trent's word fails Westminster's. Trent's
reading of justification rests two claims on Catholic authority alone: that justification is
not the remission of sins only but the renewal of the inward man, and that the justified grow in
that renewal by good works done in grace. Trent's rule admits both, and Westminster's refuses
both (`trent_keeps_its_own_rule`). The two rules part exactly where the two sides do.

**In the dispute over Mark 7, the Reformed case fails its rule at one claim.** The argument
over Scripture alone has one dispute so far. In Mark 7 Jesus rebukes "the tradition of the
elders" for "making void the word of God", and the dispute asks what that settles between Rome
and the Reformers. Its five parties are held to their rules the same way:

- Mark 7's case for Scripture alone is the Reformed reading of the passage, and professes
  Westminster's rule;
- Trent, as it states its position, and Trent with its tradition read as the apostles' word
  handed on unwritten, which is what Trent says it receives, profess Trent's;
- Mark 7's principle, that God's word judges human tradition, is held to none, because it is
  common ground: Rome grants it in *Dei Verbum* 10 ("this teaching office is not above the word
  of God"). Every rule the library has encoded admits what it asserts, the passage itself
  (`marks_principle_meets_every_rule`);
- Trent with its tradition read as commandments of men is held to none, because no one holds
  it. The reading is Calvin's (*Institutes* IV.x.23), and Calvin denies Trent; Trent denies the
  reading.

Trent's readings keep their rule. Mark 7's case does not (`sola_scriptura_own_rules`). To get
from the principle to Scripture alone it needs one more claim: that no unwritten tradition can
now be shown to have come from the apostles, and so none can bind the conscience as the word
of God. That is a claim about proof, not about what the apostles once said, and it is how
William Whitaker puts it in his *Disputation on Holy Scripture* (1588), answering Bellarmine:
"the papists have no such unwritten tradition which can be certainly shewn to have been always
observed by the universal church". The library cites the claim to Whitaker and to the
Westminster Confession I.6, which says that nothing is to be added to Scripture by "traditions
of men". Both are a theologian's or a confession's word, and Westminster's rule admits neither
as a ground. So the Reformed case asks Rome for Scripture and, at this claim, rests on what it
refuses Rome.

Stating the claim as narrowly as Whitaker does changes nothing here, because what it rests on
is the same. The check does not say that the claim is false, or that it cannot be grounded as
Westminster's rule asks. It is in part a claim of history, about what the record can show,
and an argument from that evidence would be a ground the rule admits. The library cites
Whitaker as a witness to the Reformed position, not a historian's account of the evidence,
and the citation is left as it stands until one is found. No verdict moved: nothing weighs a
claim by what it rests on.

One limit remains. The library's evidence rule admits the same grounds for claims as
Westminster's, so the check could not have told the two apart: what sets Westminster's rule
apart is how a Scripture-only step is answered, and steps are not yet checked.

## The canonical witness

The canonical witness asks what follows from the texts Rome and the Reformers both receive, and
it has no dispute, so its parties are its positions (`professesCanonicalWitness`). The Reformed
case, with James and without, and Paul's claim about faith on its own profess Westminster's
rule: their readings are cited to Reformed exegetes, and their conclusion is Westminster's "by
faith alone", "by a faith that is never alone". Trent's reading of James 2:24, and its reading of
James against the sufficiency of faith, profess Trent's. The ten positions the library builds by
striking readings out of the canonical case are held to none, because no one argues them; they
are there to show which readings the case rests on.

Every position keeps its rule, and every other rule too (`canonical_witness_own_rules`). The
check could not have parted them here. Every text is cited to Scripture alone, and Trent asserts
nothing else. The case with James asserts three readings as claims, that James 2:14–26 is aimed
at a faith without works, that "justified" in 2:21–24 means shown to be righteous, and that
justification and sanctification are distinct, and each is cited to the verses it reads as well
as to Moo, Calvin or the Larger Catechism. The two sides part in their steps, each corpus's
reading and Trent's reading of James 2:24, and in what Trent denies; the check reaches neither.

## What this does not do

Which rule is right is the question of the dispute over Scripture alone (*sola scriptura*), and
a rule built into the solver, the program that computes verdicts, would settle that question
before hearing it. So every result here stays conditional: *under this rule, this reading rests
on what the rule admits.* No verdict or rating reads it.

It checks claims, and not yet steps. A step's citation in the library records its rating, and a
step is marked as disputed by citing a reader who grants its starting points and denies its
conclusion. So a Reformed step is often cited to Trent's anathema on it, its formal
condemnation, which says who disputes the step and nothing about what the step rests on.
Holding steps to a rule needs each step to record what licenses it, apart from who disputes it.

## What comes next

1. **Steps, held to a rule**, once a step records what licenses it.
2. **Whose authority, exactly.** Each rule now admits authority from its own tradition, read
   from the tradition a citation records. A record of each work's own tradition would make
   that exact, and let a Father both traditions receive count for both.
3. **Principles and silences, held to a rule.** Each rule's principles of reading, cited in its
   own words, and the silences the fallacy checks already find. A move that reads by a principle
   its own rule does not license can be charged as claims are.
4. **Verdicts under each rule.** A hearing, the dispute weighed with only the objections a
   standard accepts, already weighs a dispute by one rule ([Computed
   ratings](./computed-ratings.md)). With the standards given their holders, a page can say
   "under Westminster's rule this prevails; under Trent's it is contested".
5. **The other disputes, held to their rules**, and the positions in the argument over
   Scripture alone that no dispute weighs yet: Geisler's, Mathison's, Kruger's, Barrett's. And
   rules of their own for Aquinas, Luther and Chrysostom, once each is cited.
6. **A ground for the Reformed claim that no unwritten tradition can be shown to be
   apostolic**, cited from the evidence or from Scripture, so that Mark 7's case can be held
   to its rule and pass, or shown not to.
