import Testimony.Arguments.SolaScriptura.Atoms
import Testimony.Arguments.SolaScriptura.Sources
import Testimony.Arguments.SolaScriptura.Lines
import Testimony.Arguments.SolaScriptura.Packages
import Testimony.Arguments.SolaScriptura.Results
import Testimony.Arguments.SolaScriptura.Mark7
import Testimony.Arguments.SolaScriptura.Dispute
import Testimony.Arguments.SolaScriptura.Hearings

/-!
# Arguments.SolaScriptura — scripture as the sole infallible rule of faith

The formal principle of the Reformation. Sola fide is a claim *within*
scripture's teaching; sola scriptura is a claim *about* scripture's authority,
and so must answer objections the material principle never faces.

## What the dispute is not about

**It is not about whether doctrine develops.** Both Rome and the Protestant
position encoded here hold that the deposit is closed while understanding of it
deepens — `doctrineDevelopsWithoutNewRevelation` is shared ground, held by
Newman and by Mathison alike. The disagreement is entirely over what
*authenticates* a development: derivability from scripture, or the authority of
the developing body. An encoding that opposed a static Protestantism to a
developing Rome would describe a dispute neither party is having.

## Four positions, not two

Mathison's taxonomy, after Oberman, separates what the seed encoding collapsed:

| Position | What it holds |
|---|---|
| **Tradition 0** | Tradition carries no binding authority; creeds inform without norming |
| **Tradition I** | Tradition is ministerial — real authority, fallible, subordinate to scripture |
| **Tradition II** | Two coordinate sources, as Mathison reads Trent; Geiselmann dissents |
| **Tradition III** | The magisterium is the one real source, resting on Vatican I |

Orthodoxy is a fifth thing again, and not a variant of Rome: authority rests in
the mind of the Church, expressed in the consensus of the Fathers and in
conciliar decisions received by the whole Church. Florovsky rejects the
two-sources model outright. The seed grounded a single "Catholic/Orthodox" line
on `magisteriumIsInfallible`, which attributes to Orthodoxy a premise it does
not hold.

`tradition0_establishes` is the result that most repays the split: the position
Mathison calls "solo scriptura" and judges unbiblical and unworkable reaches the
conclusion too, once stated by Geisler — who holds it — rather than by its
critic.

## Three objections, which do not reduce to one another

**Self-refutation.** If a doctrine binds only when scripture teaches it, and
scripture does not teach sola scriptura, the position fails by its own standard.

**The canon objection.** If the canon is known through the Church's reception,
an authority outside scripture is needed to identify scripture. Augustine
supplies the classical form: *ego vero Evangelio non crederem, nisi me
catholicae Ecclesiae commoveret auctoritas*.

**The interpretive-authority regress.** Cross and Judisch argue that the
individual retains ultimate interpretive authority, exercised indirectly by
choosing which body to submit to, so Tradition I is not principled distinct
from Tradition 0 — "when I submit (so long as I agree), the one to whom I
submit is me."

Encoding objections that tell against the position is not a concession; the
project's ground rules require rival readings to be encoded with the same care
as the ones argued for.

## The hinge does two jobs, and they come apart

The seed asserted in prose that the dispute reduces to
`solaScripturaIsTaughtByScripture`. Split into the two roles that premise
actually plays, the claim is both weaker and sharper than that.

It is **not** load-bearing for reaching the conclusion:
`hinge_not_load_bearing_for_conclusion` shows the eliminative line delivering
the sole rule without it. It **is** load-bearing within the classical strand
taken alone.

And against the self-refutation objection it is one of *two* answers, not the
only one. The objection's step is a conjunction, so either conjunct may be
denied: `classical_answer_blocks_self_refutation` denies that scripture fails to
teach the principle, and `scoping_blocks_self_refutation` denies instead that
the bindingness rule governs a claim about where binding doctrine comes from —
the final-arbiter reading, on which scripture is not the only arbiter but the
last one. The objection succeeds only against a position refusing both.

**Redundancy does not defend a position here**, which is where this argument
parts company with `SolaFide`. There, a second strand defeated an attack on a
premise. These objections are not premise attacks: each independently delivers
the negation of the conclusion, so a further route to the conclusion does
nothing against them. What answers an objection is denying one of *its*
grounds.

## The parity reply, and what it is worth

Kruger on the canon and Mathison on interpretive authority make the same move:
concede the circularity, deny that it discriminates between the positions. What
the move achieves is that the disputed proposition comes out *independent* of
the reply's grounds: neither it nor its denial follows, because two readings
satisfy those grounds and disagree about it. `parity_leaves_the_canon_open` and
`parity_leaves_the_distinction_open` are those results.

Each used to be a *pair* — one result that the reply blocks the objection,
another that it establishes nothing — and the pair is what hid a defect. Over
Barrett's parity reply to Geisler the two halves asked about different
propositions while being presented as complements; `parity_leaves_the_defeat_open`
is the claim that was meant, and `circle_parity_concedes_the_charge` is the
second question restated, since that reply does not merely fail to clear the
charge of circularity but grants it as one of its own grounds.

The replies neutralise; they do not establish.
`compatibility_does_not_establish_criterion` records the same lesson in
`BornOfAVirgin`, for a different argument and a different reply — and *not* as
an independence claim, because its two results range over different premise
sets.

## The circle inside Protestantism

`circle_leaves_the_consensus_open` encodes Geisler's charge against Tradition
I: the creedal consensus is said to rest on scripture's clarity, while
scripture's clear sense is said to be unobtainable without that consensus. Both
legs in place, neither end is settled either way — a cycle of implications is
satisfied outright by a valuation on which every node in it is false, and
equally by one on which every node is true. `circle_leaves_the_perspicuity_open`
says the same of the other end.

That charge is made from inside the Reformation, against the position this
module encodes as the Protestant one. It is conditional like every result here:
deny either leg and the circle is not there.

## What Mark 7 settles

Jesus' rebuke of the elders' tradition (Mark 7:1–13; Matthew 15:1–9) is the
text the Protestant case most often cites, and it used to sit among the shared
grounds with no step reading it. It is a line of its own now, and it settles
less than it is cited for. Its principle — God's word judges human tradition,
and no commandment of men may be taught as God's word — is common ground: Rome
holds it too. From the principle to sola scriptura needs one more premise, that
no apostolic word survives outside Scripture, and Rome denies it.

`whatTrentsTraditionIs` is the dilemma a reader of Mark 7 needs. Read as
commandments of men, Trent's tradition is what Mark 7 condemns; read as the
apostolic word handed on unwritten, which is what Trent says it receives, Mark 7
does not reach it. Weighed as a dispute, Mark 7's principle — which both sides
hold — prevails, Trent read as commandments of men cannot be defended, and
between Mark 7's case for sola scriptura and Trent the dispute chooses neither
(`Mark7.lean`, `Dispute.lean`, `Hearings.lean`).

Weighing it moved a rating. `traditionIsCoordinateSourceOfRevelation` was
`wellSupported`, which made no difference while no dispute read it. In the Mark 7
dispute it would have decided who prevails, so it was audited: Geiselmann grants
Trent's Session IV and denies that it canonised two coordinate sources, since the
council replaced its draft's "partly … partly" with "and"; Congar judges that
Trent left the question open. The claim is `disputed` now, and the Tridentine
party is named "Trent (Tradition II)" rather than by the reading in dispute.

## A limitation worth stating

The final-arbiter reading turns on a distinction between **doctrine**, which
requires scriptural adjudication, and **practice** neither commanded nor
forbidden, which does not. That is a *scope* distinction, and this fragment is
propositional: it cannot quantify. The distinction is carried by atom design and
by this docstring, not by the logic. What the encoding shows is what follows
given the distinction, not that the distinction can be drawn.

## Where things are

| File | Contents |
|---|---|
| `Atoms.lean` | the `Claim` atoms |
| `Sources.lean` | `cite`, with each position cited from a source that holds it |
| `Lines.lean` | the inference steps, the lines, and the replies as substituted grounds |
| `Packages.lean` | the positions, the objections, and the variants the results refute |
| `Results.lean` | every `@[headline]` result on the positions and objections |
| `Mark7.lean` | Mark 7 and the tradition Trent receives: the packages, the dilemma |
| `Dispute.lean` | the dispute over Mark 7, weighed, and its verdicts |
| `Hearings.lean` | the same dispute heard against each reading of Trent |
-/
