import TestimonyArguments.Trinity.Atoms
import TestimonyArguments.Trinity.Sources
import TestimonyArguments.Trinity.Procession
import TestimonyArguments.Trinity.Dispute
import TestimonyArguments.Trinity.Order
import TestimonyArguments.Trinity.OrderDispute
import TestimonyArguments.Trinity.Deity
import TestimonyArguments.Trinity.DeityDispute

/-!
# TestimonyArguments.Trinity — the Triune God: what Scripture settles, and what it leaves open

Ken Kibbey's *Living Systematic Theology* (LST) is a systematic theology written
in the open and revised whenever its author is persuaded that Scripture
requires it. Its governing maxim is to speak "with the certainty Scripture
gives, refusing certainty Scripture does not give". So it grades its own
claims: some it confesses as what Scripture establishes, some it defends as a
synthesis Scripture "strongly grounds" without stating, and some it says are
"not demonstrated". Its section on the Triune God (§3, version 2.9, 21 October
2026) uses all three grades.

Those grades are claims about what follows from what, and that is what this
library checks. A confessed claim should follow from the texts LST cites. A
claim it calls not demonstrated should be *independent* of them: neither it nor
its denial should follow. This argument checks the grades, one question at a
time, and reports what the checks find whichever way it goes.

## The question encoded so far: does the Spirit proceed from the Son?

The creed of the Council of Constantinople (381), the one Christians call the
Nicene Creed, confesses that the Holy Spirit "proceeds from the Father". In the
West the words "and the Son" (*Filioque*) were later added to it. The Council
of Florence defined in 1439 "that the holy Spirit is eternally from the Father
and the Son", and the Westminster Confession
confesses "the Holy Ghost eternally proceeding from the Father and the Son"
(II.3). The Orthodox churches never accepted the addition. "Most Orthodox
believe the Filioque to be theologically untrue," Kallistos Ware writes. "They
hold that the Spirit proceeds from the Father alone."

LST once confessed the Filioque, as Westminster does. Version 2.9 says that it
"no longer confesses" it, and gives its reasons:

> These texts establish a real relation of the Spirit to both Father and Son.
> They do not state that the Spirit's eternal origin is "from the Father and the
> Son" rather than "from the Father through the Son," and they do not by
> themselves settle whether John 15:26 is speaking directly of eternal origin or
> of the Spirit's mission. LST therefore no longer confesses the Western
> Filioque formula as a demonstrated biblical proposition.

The chapter "Does the Spirit proceed from the Son?" checks each of those
sentences, and each holds, with one limit. The texts establish the relation.
They leave the Filioque open, and they also leave open whether John 15:26 speaks
of eternal origin. The limit is that "through the Son" is not yet a position of
its own, so what is checked is "and the Son" against "from the Father alone".
Each side needs at least one reading of its own beyond the texts. Any one of
them is enough, so answering one does not answer the side. The chapter
"Weighing the positions" sets LST, the West and the East against each other.
What the texts establish is accepted however the disagreement is settled. The
two sides defeat each other, so neither is.

## The first question: are the Son and the Spirit God, and three persons?

LST's section opens with the confession every other claim rests on: "The Father
is God, the Son is God, and the Holy Spirit is God; they are personally distinct
without being separate gods," citing John 1:1–18, 20:28 and Acts 5:3–4 among
others. LST confesses it as what Scripture establishes, and does not grade it as
it grades the procession or eternal generation. Two positions read the same texts
against it. Jehovah's Witnesses read John 1:1 as "the Word was a god", the Son as
the first thing God made, and the holy spirit as God's force. Oneness
Pentecostals, with David Bernard, confess that "Jesus is the one God", and that
Father, Son and Holy Spirit are titles of the one God, not three persons.

The chapter "Are the Son and the Spirit God, and three persons?" encodes all
three. Each position gives its conclusion only with readings of its own, and
each can be held without contradiction. So the check does not confirm LST's grade
as it stands: the confession follows from the texts together with LST's readings,
and each of those readings is rated `disputed`, the lowest of the four ratings,
because another reader denies it. Whether the texts alone settle the question is
not tested. Weighed against one another, no position is accepted however the
disagreements are settled. The Witnesses and each of the other two defeat one
another over the Son and the Spirit, and Oneness and LST defeat each other over
the three persons. On the deity of the Word and of the Spirit, LST and Oneness
stand together.

## The second question: is the Son less than the Father?

LST also grades the texts of the Son's obedience: "These texts establish real
personal and mediatorial order, but they do not by themselves establish
inequality of divine nature or an eternal hierarchy of command and obedience
between the divine persons as such." The chapter "Is the Son less than the
Father?" checks that sentence, and it holds in each of its three parts. The
texts establish an order of Father and Son in the work of salvation. They leave
open whether the Son is less than the Father in his divinity, which the Arians
read John 14:28 to say and Augustine, Athanasius and Calvin each answer
differently. And they leave open whether the order is eternal, which Wayne
Grudem and Bruce Ware hold and Kevin Giles denies. Weighed, what the texts
establish is forced, and every reading beyond it stands off against another.
That includes the Arian reading, which means only that these few verses do not
settle the Son's divinity. LST confesses it from other texts, the first question.

## Still to come

One graded claim of §3 is not yet encoded: that eternal generation is a "defended
synthesis" rather than a stated proposition. The issue that tracks this work
lists it.
-/
