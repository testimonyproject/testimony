import TestimonyArguments.SolaScriptura.Atoms
import TestimonyArguments.SolaScriptura.Sources
import TestimonyArguments.SolaScriptura.Lines
import TestimonyArguments.SolaScriptura.Packages
import TestimonyArguments.SolaScriptura.Results
import TestimonyArguments.SolaScriptura.Canon
import TestimonyArguments.SolaScriptura.Mark7
import TestimonyArguments.SolaScriptura.JesusAndPaul
import TestimonyArguments.SolaScriptura.Acts15
import TestimonyArguments.SolaScriptura.MosesSeat
import TestimonyArguments.SolaScriptura.Dispute
import TestimonyArguments.SolaScriptura.Hearings

/-!
# TestimonyArguments.SolaScriptura — Sola scriptura: the claim, and the positions on tradition

Sola scriptura, "Scripture alone", is the formal principle of the Reformation:
the claim that Scripture is the sole infallible rule of faith. Sola fide is a
claim *within* Scripture's teaching, about how a sinner is justified. Sola
scriptura is a claim *about* Scripture's authority, and so it has to answer
objections that sola fide never faces. Every party to the dispute grants that
Scripture is infallible (`scriptureIsInfallible`). They part over whether
anything else is an infallible rule beside it.

The dispute is not about whether doctrine develops. Rome and the Protestant
position encoded here both hold that the deposit of revelation is closed while
the Church's understanding of it deepens. That is shared ground, held by
Newman and by Mathison alike (`doctrineDevelopsWithoutNewRevelation`). The
disagreement is over what *authenticates* a development: that it can be
derived from Scripture, or the authority of the body that develops it. An
encoding that set a static Protestantism against a developing Rome would
describe a dispute neither party is having.

## Four positions, not two

Keith Mathison, following Heiko Oberman, separates four views of how tradition
stands to Scripture, and the earliest version of this argument had collapsed
them:

| Position | What it holds |
|---|---|
| **Tradition 0** | Tradition carries no binding authority; creeds inform without norming |
| **Tradition I** | Tradition is ministerial — real authority, fallible, subordinate to scripture |
| **Tradition II** | Two coordinate sources, as Mathison reads Trent; Geiselmann dissents |
| **Tradition III** | The magisterium is the one real source, resting on Vatican I |

Tradition I is the position this argument encodes as the Protestant one.
Orthodoxy is a fifth thing again, and not a variant of Rome. For the Orthodox,
authority rests in the mind of the Church, expressed in the consensus of the
Fathers and in the decisions of councils received by the whole Church, and
Florovsky rejects the two-sources model outright. The first version of this
argument grounded a single "Catholic/Orthodox" line on the infallibility of the
magisterium (`magisteriumIsInfallible`), and so attributed to Orthodoxy a
premise it does not hold.

The split repays itself at once. Mathison calls Tradition 0 "solo scriptura"
and judges it unbiblical and unworkable. Stated by Geisler, who holds it, rather
than by its critic, it reaches the conclusion too (`tradition0_establishes`).

## The questions the later chapters take

- **Does sola scriptura refute itself, and who decides the canon?** Three
  objections are heard: that Scripture does not teach the principle, that the
  Church had to identify Scripture, and that the one who chooses an authority
  is the real authority. None reduces to another. Each can be answered by
  denying one of its own grounds, and the replies from parity leave the
  question open rather than settle it
  ("Three objections, and the answers to them").
- **Does the Church have to identify the canon infallibly?** Scripture sets
  its own tests for a word that claims to come from God (Deuteronomy 13 and
  18), and the early Church set apart books it read and did not receive, the
  Shepherd and the Didache, by reasons it stated. That reply denies the
  objection's need for an infallible authority outside Scripture. Weighed against the objection,
  each defeats the other, and the dispute forces neither
  ("How the canon is recognised").
- **What does Mark 7 settle?** Jesus' rebuke of the elders' tradition delivers a
  principle Rome also holds. To reach sola scriptura it needs one more premise,
  that no unwritten tradition can now be shown to be apostolic, and Rome denies
  it ("What Jesus' rebuke of tradition settles").
- **Does it rest on one story?** Jesus' sayings in John and Matthew and Paul's
  in Galatians and Colossians deliver the same principle, and leave the same
  premise to be argued ("The same principle, beyond Mark 7").
- **Weighed between Rome and the Reformers, who prevails?** Mark 7's principle
  prevails, Trent read as commandments of men cannot be defended, and between
  Mark 7's case for sola scriptura and Trent the dispute chooses neither
  ("Weighing Mark 7 between Rome and the Reformers").
- **What did the council at Jerusalem do?** The Reformers read Acts 15 as a
  council judging by Scripture, Rome as a council binding with the Spirit's
  authority. Each grants the other's texts, the two readings cannot be held
  together, and the texts alone leave the question open
  ("The council at Jerusalem, read both ways").
- **What does "Moses' seat" bind?** Calvin and Cornelius a Lapide read
  Matthew 23:2–3 in opposite directions, and Mark 7 with Matthew 23 leaves the
  teaching office open ("Moses' seat, read both ways").

Scripture is quoted from the Legacy Standard Bible (LSB), a literal translation
made from the critical editions: Kittel's *Biblia Hebraica*, with the Dead Sea
Scrolls, and the Nestle–Aland Greek New Testament. Where a word in the Greek
matters to the argument, it is given in brackets after the English, and where
the translations part over it, that is said where the word is used. A quotation
inside a cited author's words is left as the author gave it, in whatever Bible
he used.

The claims themselves, each with its number, its source and its rating, are
listed in the appendix, "The claims and their sources".
-/

/-!
#### Where things are

| File | Contents |
|---|---|
| `Atoms.lean` | the `Claim` atoms |
| `Sources.lean` | `cite`, with each position cited from a source that holds it |
| `Lines.lean` | the inference steps, the lines, and the replies as substituted grounds |
| `Packages.lean` | the positions, the objections, and the variants the results refute |
| `Results.lean` | every `@[headline]` result on the positions and objections |
| `Canon.lean` | the reply from Scripture's tests to the canon objection, weighed against it |
| `Mark7.lean` | Mark 7 and the tradition Trent receives: the packages, the dilemma |
| `JesusAndPaul.lean` | the same principle from Jesus' sayings and Paul's letters |
| `Acts15.lean` | the council at Jerusalem, read by the Reformers and by Rome |
| `MosesSeat.lean` | Moses' seat (Matthew 23:2–3), read by the Reformers and by Rome |
| `Dispute.lean` | the dispute over Mark 7, weighed, and its verdicts |
| `Hearings.lean` | the same dispute heard against each reading of Trent |
-/
