# How each side says we know (draft)

> **A design note, with its first phase built.** Nothing here changes a verdict or a rating.
> It names the rules the ratings were already computed under, gives each its holders, and
> checks whether each side keeps the rule it professes.

A Protestant and a Catholic arguing over Romans 3:28 are seldom arguing only over Romans 3:28.
Underneath is a disagreement about how anything is known from Scripture at all. The
Westminster Confession says that "the infallible rule of interpretation of Scripture is the
Scripture itself" (I.ix), and that the supreme judge of controversies "can be no other but the
Holy Spirit speaking in the Scripture" (I.x). The Council of Trent receives, beside the written
books, the traditions "received by the Apostles from the mouth of Christ himself, or from the
Apostles themselves, the Holy Ghost dictating" (Session IV), and the Second Vatican Council says
Scripture and tradition are to be accepted with the same devotion (*Dei Verbum* 9). A historian
reading Paul as one reads any ancient author asks for neither: only the texts, and evidence
anyone can check.

An argument that quietly assumes one of these answers has decided the dispute before hearing
it. So the library names them.

## What an epistemology is here

An **epistemology** is how a side holds that something is known: the rule by which it decides
what counts as a reason. The library writes each one as a single value
(`Testimony.Logic.Epistemology`) with five parts:

- **what it admits as grounds.** Every premise in the library rests finally on one of four
  things: a text of Scripture, evidence anyone can check (a critical text, a lexicon, argued
  scholarship), the word of a council, a confession or a theologian, or the library's own
  proposal ([what each position rests on](./semantics.md#what-each-position-rests-on));
- **whether a step resting on Scripture alone may be answered only from Scripture**;
- **the principles of reading it licenses**, such as "a word means no more than its context
  needs" (Silva, Barr) or "Scripture does not contradict itself";
- **how it takes an argument from silence**: never, only when the argument states what the text
  would have said ([Checking an argument for fallacies](./fallacies.md#argument-from-silence)),
  or freely. Where its source does not say, the library does not guess;
- **who holds it**, cited, as a premise is.

Three are encoded (`TestimonyArguments.Epistemologies`):

| Rule | Held by | Grounds it admits | Scripture-alone steps |
|---|---|---|---|
| Scripture its own interpreter | Westminster Confession I.vi, I.ix, I.x | Scripture, evidence | answered from Scripture only |
| Scripture and tradition | Trent, Session IV; *Dei Verbum* 9 | Scripture, evidence, the Church's teaching | not kept to Scripture |
| Evidence anyone can check | the library's own evidence standard; Silva | Scripture, evidence | not kept to Scripture |

None of the three sources speaks to arguments from silence, so none of the three rules does.

## The standards, given their holders

The library's credibility checks ([Computed ratings](./computed-ratings.md)) have always been
run under three standards: evidence, tradition and Scripture. Each was a rule about which
grounds count, and none was anyone's. Each now turns out to say exactly what one of the
encoded rules says (`each_rule_is_a_standard`):

- the **scriptural** standard is Westminster's rule;
- the **tradition** standard is Trent's;
- the **evidence** standard is the historian's.

So every rating computed so far was computed under a rule someone holds, and the page can now
say whose. No rating and no verdict moved.

## Does each side keep its own rule?

The charge of a double standard is common in debate: you ask me for Scripture and rest your own
case on a confession. The library can now check it. A reading is held to the rule of the side
whose reading it is, and every claim it asserts is checked against that rule
(`ArgumentPackage.heldTo`).

Which rule a reading professes is declared, party by party, with the reason. It is not read off
the reading's citations, because a Reformed reading that cites a Catholic exegete is still a
Reformed reading. In the sola fide dispute, the Reformed readings profess Westminster's rule.
Trent's readings and Aquinas profess Trent's. The scholars' readings, and the two arguments
from Paul's word by a method of reading, profess the historian's. Luther and Chrysostom are
held to none, because the library cites no Lutheran and no Orthodox statement of how Scripture
is to be read, and holding them to Westminster's or Trent's would give them a rule they did
not write.

**What the check finds** (`sola_fide_own_rules`). Four Reformed readings break their own rule,
and all four at one premise. Sola fide from Paul, from Peter at Jerusalem and from John 6, and
the Reformed answer to Chrysostom, each assert that justification and sanctification are
"inseparable but distinct". The library cites that claim to Westminster (XIII.1, XI.1) and to
Calvin (*Institutes* III.xi.6), and to nothing else. Westminster's rule admits Scripture and
evidence. It does not admit a confession's word, Westminster's own included, or a
theologian's.

So by their own rule, the four readings owe that claim a text. It is not thereby false. Calvin
says where to look, for he says Scripture "classes them separately", but the library cites
Calvin and not the texts he means. The remedy is to cite the texts. Every other party held to a
rule, Catholic and scholarly alike, asserts only what its own rule admits.

## What this does not do

It does not say which rule is right. That is what the sola scriptura dispute is about, and a
rule built into the solver would settle it by fiat. Every result stays conditional: *under
this rule, this position rests on what the rule admits.* Nothing here is weighed: no verdict
and no rating reads it.

It checks claims, and not yet steps. A step's citation in the library records its rating, and
a step is rated `disputed` by citing the reader who grants its starting points and denies its
conclusion. So a Reformed step is often cited to Trent's anathema on it, which says who disputes
the step and nothing about what it rests on. Holding steps to a rule needs each step to record
what licenses it, apart from who disputes it.

## What comes next

1. **Steps, held to a rule**, once a step records what licenses it.
2. **Principles and silences, held to a rule.** Each rule names the principles it licenses, and
   the fallacy checks already find the silences a move argues from. A move that reads by a
   principle its own rule does not license, or argues from a silence its rule refuses, can be
   charged the same way claims are.
3. **Verdicts under each rule.** A hearing under a standard already weighs a dispute by one
   rule ([Computed ratings](./computed-ratings.md)). With the standards given their holders, a
   page can say "under Westminster's rule this prevails; under Trent's it is contested", and
   show where the two part.
4. **The other disputes, held to their rules**, beginning with sola scriptura, where the rule is
   itself the question.
5. **A rival for each rule.** Each is cited to its holders, and each has its rivals among the
   others. A Lutheran and an Orthodox statement of how Scripture is read would let Luther and
   Chrysostom be held to their own rules.
