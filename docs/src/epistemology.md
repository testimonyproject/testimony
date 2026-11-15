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

Three are encoded (`TestimonyArguments.Epistemologies`):

| Rule | Held by | Grounds it admits | An objection to a Scripture-only step |
|---|---|---|---|
| Scripture its own interpreter | Westminster Confession I.vi, I.viii, I.ix, I.x | Scripture, evidence | must itself rest on Scripture |
| Scripture and tradition | Trent, Session IV; *Dei Verbum* 9 | Scripture and the apostolic tradition, received together; evidence | may rest on tradition or evidence too |
| Evidence anyone can check | the library's own evidence standard | Scripture, evidence | may rest on evidence too |

None of the sources speaks to arguments from silence, so none of the rules does. Only the
library's rule records a principle of reading, the one it cites to Silva. Westminster and Trent
each have their own, and they will be recorded when they are cited in their own words.

**The Catholic rule, as encoded, is broader than Trent's.** The library knows that a work is a
council's, a confession's or a theologian's, but not whose. So the rule admits every such word:
Trent's, but also Westminster's or any theologian's. Trent admits the tradition received from
the Apostles and the Church's judgement of Scripture's sense, not a Protestant confession. A
narrower rule needs the library to tell a Catholic authority from any other, and it does not
yet.

## The standards, given their holders

The library's credibility checks ([Computed ratings](./computed-ratings.md)) have always been
run under three standards, evidence, tradition and Scripture. Each was a rule about which
grounds count, written without a holder, and each turns out to say exactly what one of the
encoded rules says (`each_rule_is_a_standard`):

- the **scriptural** standard is Westminster's rule;
- the **tradition** standard is the Catholic rule, as encoded;
- the **evidence** standard is the library's own.

So every rating computed so far was computed under a rule a tradition holds, or, for the
evidence standard, under the library's own, and the page can now say which. No rating and no
verdict moved.

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
- Aquinas, Luther and Chrysostom are held to none. None of them wrote Trent's rule or
  Westminster's. Aquinas has his own, Luther's tradition has the Formula of Concord, and
  Chrysostom wrote before either; the library cites none of these as a rule, and holding them to
  another's would give them a rule they did not write.

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

Two limits remain. The library's evidence rule admits the same grounds for claims as
Westminster's, so the check could not have told the two apart: what sets Westminster's rule
apart is how a Scripture-only step is answered, and steps are not yet checked. And the Catholic
rule, as encoded, admits any authority's word, so Trent's readings could not have failed this
way. That they pass says less than it would under a narrower rule.

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
2. **A narrower Catholic rule**, once the library can tell whose authority a work is.
3. **Principles and silences, held to a rule.** Each rule's principles of reading, cited in its
   own words, and the silences the fallacy checks already find. A move that reads by a principle
   its own rule does not license can be charged as claims are.
4. **Verdicts under each rule.** A hearing, the dispute weighed with only the objections a
   standard accepts, already weighs a dispute by one rule ([Computed
   ratings](./computed-ratings.md)). With the standards given their holders, a page can say
   "under Westminster's rule this prevails; under Trent's it is contested".
5. **The other disputes, held to their rules**, beginning with the one over Scripture alone,
   where the rule is itself the question; and rules of their own for Aquinas, Luther and
   Chrysostom, once each is cited.
