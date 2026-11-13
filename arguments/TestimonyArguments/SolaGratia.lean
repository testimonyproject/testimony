import TestimonyArguments.SolaGratia.Atoms
import TestimonyArguments.SolaGratia.Sources
import TestimonyArguments.SolaGratia.Lines
import TestimonyArguments.SolaGratia.Packages
import TestimonyArguments.SolaGratia.Results

/-!
# TestimonyArguments.SolaGratia — salvation by grace alone

"For by grace you have been saved through faith. And this is not your own
doing; it is the gift of God, not a result of works, so that no one may boast"
(Ephesians 2:8–9). Every party to this dispute reads the verse and agrees with
it. That is the first thing to understand about *sola gratia*, "by grace alone",
and the reason the conclusion below is stated with more care than the slogan.

## Everyone says "by grace"

The Council of Trent, answering the Reformers in 1547, taught that "in adults,
the beginning of the said Justification is to be derived from the prevenient
grace of God", the grace that goes before, by which they are called "without
any merits existing on their parts". It quoted Paul: "if it be a grace, it is
not now by works, otherwise … grace is no more grace" (Romans 11:6). The
Remonstrants, the followers of Arminius who petitioned the States of Holland in
1610, called grace "the beginning, continuance, and accomplishment of all good".
Neither is Pelagian. Neither thinks a person can begin to turn to God by their
own power.

So a conclusion stated as "salvation is by grace" would follow from all three
positions and separate none of them. When the Synod of Dort answered the
Remonstrants in 1619, it meant something sharper. The grace that saves brings
about the consent it asks for, rather than waiting on a will that could refuse
it. And the new life is, in the Canons' words, "a making alive, which God works
in us without our aid"; the Westminster Confession says the sinner "is
altogether passive therein, until, being quickened and renewed by the Holy
Spirit, he is thereby enabled to answer this call". The older name for this is
*monergism*, from the Greek for "one at work".

The conclusion here has those three parts. Salvation is by grace; the grace that
saves is effectual of itself; and the will is passive in being made alive. Each
rival holds the first part and denies one of the others.

- **Trent** denies the third. Its fourth canon on justification condemns anyone
  who says that the free will, "moved and excited by God", does not cooperate
  "by assenting to God exciting and calling", but "as something inanimate, …
  is merely passive". The same canon condemns anyone who says the will "cannot
  refuse its consent, if it would".
- **The Remonstrants** deny the second. Their fourth article says that grace "is
  not irresistible, inasmuch as it is written concerning many, that they have
  resisted the Holy Ghost", citing Stephen's charge to the council: "you always
  resist the Holy Spirit" (Acts 7:51).

## Two routes to the conclusion

The Reformed case has two routes, called *strands* below, each from a different
text. Each begins from a reading of its text and takes a step from that reading
to the conclusion.

**Ephesians 2.** Paul has just said that his readers "were dead in the trespasses
and sins", and that God "made us alive together with Christ" (2:1, 5). Then:
"by grace you have been saved through faith. And this is not your own doing".
The Greek word for "this" (τοῦτο) is neuter, while "faith" (πίστις) and "grace"
(χάρις) are both feminine, so the pronoun does not point to either word on its
own. Hoehner and Robertson read it as pointing to the whole of being saved by
grace through faith. The strand then takes two steps: since faith is part of
that whole, faith is God's gift; and since it is given to people who were dead
until God made them alive, the turning is his work alone.

**Romans 9.** "So then it depends not on human will or exertion, but on God, who
has mercy" (Romans 9:16). Read as being about God's mercy in saving, and not
only about his choice of a people for a part in history, the verse says that
receiving mercy does not hang on anyone's willing. The Romans strand does not
use the Ephesians grammar at all.

## What the machine finds

Lean checks, for each position written as a list of premises, whether the
conclusion follows. It does not check whether the premises are true.

The Reformed premises reach the conclusion, and neither rival's do, though both
reach its first part. A reading is called *load-bearing* when removing it, with
everything else kept, stops the conclusion following. Neither reading is
load-bearing alone, because each strand reaches the conclusion without the other.
Removed together they are, so the Reformed case needs one of the two readings,
and either will do.

The readings, though, are not where the rivals part from it. Robertson reads
"this" exactly as Hoehner does, and draws the opposite lesson: the whole act of
being saved is "conditioned on faith on our part". Calvin, on the next verse,
writes that Paul's "meaning is, not that faith is the gift of God, but that
salvation is given to us by God". So the step from the pronoun to faith as a gift
is rated *disputed*: a reader the library cites grants its grounds and denies its
conclusion.

The next step is disputed too. Arminius acknowledged faith to be God's "benefit
and gift", and ascribed to grace "the commencement, the continuance and the
consummation of all good". He could grant everything the Ephesians strand rests
on, up to its last step. He refused that step, believing "that many persons
resist the Holy Spirit and reject the grace that is offered". Dort's answer is
its article on faith, which it calls the gift of God "not on account of its
being offered by God to man, to be accepted or rejected at his pleasure, but
because it is in reality conferred". The difference between the two is the
difference between those two senses of *gift*, and the grammar of the verse
does not decide it (`gift_of_faith_does_not_settle_resistibility`).

Romans goes the same way. Arminius read Romans 9 as being about salvation, "not
to him that worketh, but to him that believeth". Abasciano, who reads its
election as of a people rather than of individuals, still grants that "Paul's
argument in Romans 9 surely concerns the salvation of Israel". The reading is
widely granted. It is the step from it to God's work alone that Arminius denies.

Trent's canon has the same feature at both its halves. That the will "cannot
refuse its consent, if it would" is condemned, which seems to deny that grace is
effectual of itself. But Aquinas held both that if God moves the will, "it is
incompatible with this supposition, that the will be not moved thereto. But it
is not impossible simply", and that the man God moves to grace "will infallibly
attain to it". And the canon's "cooperates" speaks of the will "disposing and
preparing itself" for justification, while Aquinas and Dort both place the
will's own activity after a first moment in which, in Aquinas's words, it "is
moved and does not move"; Dort says the will once renewed "becomes itself
active". So both of Trent's steps are rated disputed.

## What is not encoded

Aquinas and the Thomist school are cited here for two ratings, and are not a
position of their own. They hold that grace is infallibly effectual, and Aquinas
puts the infusion of grace first "in the order of nature", before "the
free-will's movement towards God". Whether they reach the sharpened conclusion,
and where they part from Dort if they do not, is a question this module does
not ask.

John 6:44 ("No one can come to me unless the Father who sent me draws him") is
the third text most often cited for the Reformed view, and is not encoded
either. Nor is election, the subject of the first of the Remonstrants' articles,
which is a dispute of its own.

## Where things are

| File | Contents |
|---|---|
| `Atoms.lean` | the claims |
| `Sources.lean` | who holds each claim, and the rating of each step |
| `Lines.lean` | the steps and the lines of reason |
| `Packages.lean` | the three positions, and the variants the results ask about |
| `Results.lean` | what follows, what does not, and which readings carry it |
-/
