# Rationale

## The problem with arguing in prose

Christian arguments from Scripture are old, well developed, and almost always
delivered as prose. A case that Jesus fulfils the messianic prophecies runs
through dozens of texts, each requiring a reading, each reading resting on
lexical, historical and hermeneutical assumptions that the argument rarely
stops to enumerate.

This has three consequences, and they damage the argument's *defenders* more
than its critics.

**Premises hide.** An argument that Micah 5:2 predicts the Messiah's birthplace
assumes that Micah 5:2 is forward-looking prophecy rather than an oracle about
a contemporary Judaean ruler. That assumption is doing real work. In prose it
appears as a clause, or as nothing at all.

**Disagreement diffuses.** When two scholars disagree about sola fide, where
exactly do they part company? Both accept that Paul wrote Romans 3:28. Both
accept the text. Somewhere in a hundred pages of argument there is a step one
grants and the other denies, and locating it is itself a research project.

**Nobody can audit the whole.** A cumulative case over twelve prophecies has a
shape no reader holds in their head at once. Which conclusions depend on which
premises? If one premise falls, what else falls with it? Prose cannot answer
this, and neither can its author.

## What formalisation changes

Encoding an argument in Lean does not make it true. It makes it *inspectable*,
in four specific ways.

**Premises become enumerable.** Every atomic claim in a Testimony argument
carries a citation, enforced by the type system: the function from atoms to
their sources is total, so an uncited claim does not compile. The assumption
manifest is then generated from the premises rather than maintained beside
them, and cannot drift out of step with the argument it describes.

**Validity becomes mechanical.** Whether the conclusion follows is settled by
a proof term, produced by `tauto` and checked by Lean's kernel; where it does
not follow, a named countermodel says so. This is the least interesting
guarantee the library offers, and it is worth having anyway: it means no
disagreement about an argument is ever a disagreement about whether it is
valid.

**Disagreement becomes locatable.** This is the real payoff. Encode the
Reformed reading of justification, encode the New Perspective alongside it, and
the library will tell you that the two packages differ in exactly one premise —
whether Paul's ἔργα νόμου means works in general or Jewish covenant boundary
markers — and then tell you what that premise is worth. It turns out not to be
worth the argument: `worksOfLaw_not_load_bearing` holds, because the dominical
strand at Luke 7:50 carries the conclusion without it, and the New Perspective
package establishes the conclusion too. What is load-bearing is a
*disjunction*: Paul's two disputed readings of Galatians 2:16 — ἔργα νόμου and
πίστις Χριστοῦ — or Jesus' σῴζω at Luke 7:50, or Peter's yoke at Acts 15:10.

That result is not Protestant or Catholic. It is a description of the
disagreement that both sides can accept — including the part neither side
expected, that the famous dispute is not where the argument's weight rests —
and it is the kind of thing prose almost never delivers.

**Circularity becomes visible.** A premise grounded only in Scripture is
epistemically different from one grounded in scholarship, and the library types
the difference. `Source.isScriptureOnly` computes it, and every argument
reports its scripture-only atoms. An argument from Scripture that reads
Scripture a particular way and cites only Scripture for that reading is
assuming part of what it sets out to show. That is sometimes fine. It should
never be invisible.

## Why this is the stronger position, not the weaker one

It might look like a concession to publish every assumption an argument makes.
It is the opposite.

An argument whose premises are all declared is harder to dismiss than one that
claims more than it can deliver. The sceptic's usual move — *you are assuming
what you set out to prove* — is answerable here by pointing at the manifest and
asking which premise they reject, and on what grounds. The conversation moves
from suspicion to a specific, arguable claim.

The library is also, deliberately, useful to people who reject its
conclusions. A critical scholar who thinks Isaiah 7:14 is a near-term sign to
Ahaz can encode that reading with the same machinery, and the library will
confirm that the Christian conclusion does not follow from it. Both encodings
live in the same repository. That is not neutrality for its own sake; it is
what makes the Christian encodings worth taking seriously.

## Prior art

Machine-checked theology is not new. The clearest precedent is Benzmüller and
Woltzenlogel Paleo's formalisation of Gödel's ontological argument, which
verified the proof in higher-order logic and found, in the process, that
Gödel's axioms collapse modal distinctions — a result about a famous argument
that a century of prose commentary had not established.

That is the pattern this project expects to repeat: formalisation rarely
settles whether a conclusion is true, and frequently discovers something about
the argument's structure that nobody had noticed.

See the [bibliography](./bibliography.md) for the citation.

## Why a community

Two kinds of expertise are needed and almost nobody has both.

Formalising an argument requires knowing Lean. Judging whether a formalisation
*faithfully represents* the argument it claims to represent requires knowing
biblical studies, the history of interpretation, and the secondary literature.
A subtly wrong encoding is worse than no encoding, because it launders a bad
argument through a proof assistant and comes out looking rigorous.

So the review that matters most here is not a Lean review. It is a theologian
or biblical scholar reading an encoding and saying *that is not what the
argument says*. The project is set up to make that contribution possible
without writing any Lean: see [Contributing](./contributing.md).
