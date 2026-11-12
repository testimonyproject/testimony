import TestimonyArguments.Trinity.Atoms
import TestimonyArguments.Trinity.Sources
import TestimonyArguments.Trinity.Procession
import TestimonyArguments.Trinity.Dispute

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

## Still to come

LST's other graded claims in §3 are not yet encoded. They are that the Father,
the Son and the Spirit are each God and are three persons, not three gods; that
the texts of the Son's obedience (John 5:19–30; 14:28; 1 Corinthians 15:24–28)
establish an order without establishing an inequality of nature or an eternal
chain of command; and that eternal generation is a "defended synthesis" rather
than a stated proposition. Each has rivals of its own: the Arians, the
modalists, and those who hold an eternal submission of the Son. The issue that
tracks this work lists them.
-/
