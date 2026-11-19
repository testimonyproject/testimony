import TestimonyArguments.SolaScriptura.Atoms
import TestimonyArguments.Works

/-!
# TestimonyArguments.SolaScriptura.Sources — a source for every claim

Every claim in the argument is given a source here: a passage of Scripture, or a
work and the place in it, with a rating that says how well supported it is among
the sources cited.

Where the positions disagree about a claim, each is given the source that
actually holds it. The Orthodox premise cites Florovsky and Ware rather than a
Protestant account of Orthodoxy, and Tradition 0 cites Geisler rather than
Mathison's description of it, since Geisler's principal complaint is that the
description is a caricature.
-/

namespace TestimonyArguments.SolaScriptura

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- A claim held by a named work at a section, in a given tradition. -/
private def heldBy (entry : BibEntry) (loc : String) (tradition : Tradition)
    (confidence : Confidence := .disputed) : Source :=
  { primary := .work entry (.sectionRef loc)
  , tradition := tradition
  , confidence := confidence }

/-! #### Ratings for inference steps

A step's rating is its own, cited to whoever grants its grounds and denies its
conclusion — or, where no one was found who does, to whoever grants both. -/

/-- The rating of Mark 7's step, from the rebuke to the principle. No reader was
found who grants the text and denies the principle; Rome grants it outright —
the teaching office is "not above the word of God" (*Dei Verbum* 10) — and
Calvin applies Matthew 15:9 to the laws of worship he opposed. Wenham reads the
passage the same way: "the displacement of Scripture by 'tradition' (mere
'precepts of men')" was one of "the twin evils which made that Word of none
effect" (pp. 15–16). Rated `wellSupported` rather than `consensus`, because the
step generalises from one pericope. -/
def mark7PrincipleInference : Source :=
  { primary := .work tannerDecrees (.sectionRef "Vatican II (1965), Dei Verbum 10")
  , supporting :=
      [.work calvinInstitutes (.sectionRef "IV.x.23"), .work wenhamOurLordsView (.pages 15 16)]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- The rating of the canon objection's step, from the Church's reception of the
canon and the need for an infallible authority outside Scripture to identify
it, to the denial that Scripture is the sole infallible rule: `wellSupported`.
No reader was found who grants both grounds and denies the conclusion: if an
infallible authority outside Scripture is needed to say which books are
Scripture, Scripture is not the only infallible rule. Reid grants the grounds
and the conclusion. The step is rated `wellSupported` rather than `consensus`
because "infallible" may be read more loosely than Rome reads it. Calvin and
Kruger answer the objection by denying its second ground, not this step. -/
def canonObjectionInference : Source :=
  { primary := .work reidCanonNewTestament (.sectionRef "The criterion of inspiration")
  , supporting :=
      [ .work tannerDecrees
          (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions") ]
  , tradition := .romanCatholic
  , confidence := .wellSupported }

/-- The rating of the step from Scripture's tests, applied under providence, to
the claim that identifying the canon needs no infallible authority outside
Scripture: `disputed`. George Reid, writing in the *Catholic Encyclopedia*
(1908), is the reader who grants the grounds and denies the conclusion. He
grants that apostolicity is "a positive and partial touchstone", and narrates
how the Shepherd and the Didache were set apart; and he names the test from
Scripture's own content and denies that it suffices. Inspiration "is not
self-evident", so its "sole absolute criterion" is the Spirit witnessing "not
... in the doctrinal and spiritual tenor of Holy Writ itself, according to
Luther, but through the constituted organ and custodian of Its revelations, the
Church". Augustine stands behind him: the canonical books are those "received by
all the Catholic churches" (*On Christian Doctrine* II.8.12), a test of
reception, not of agreement. As a Catholic he reads every text the step cites
as Scripture, Peter on Paul's letters among them, and holds that God keeps his
word; his providence, on Reid's account, works through the Church that
recognises the books.

Two Protestant readers press on the step from the other side without denying
its conclusion. Kruger criticises the criteria-of-canonicity model taken on its
own and grants that it "has rightly focused on apostolicity as a key component
of canonicity" (pp. 67–87, at p. 87); his own model counts providential
exposure and apostolic origin among its parts, with the Spirit's witness.
McDonald finds the ancient criteria applied "often unequally" (p. 127). -/
def canonTestsInference : Source :=
  { primary := .work reidCanonNewTestament (.sectionRef "The criterion of inspiration")
  , supporting :=
      [ .work krugerCanonRevisited (.pages 67 87)
      , .work mcdonaldIntegrityCanon (.pages 127 129) ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of Whitaker's step from the circle to the conclusion that the
first route gives no certainty of the canon: `wellSupported`. No reader was
found who grants that proving each from the other is circular and still holds
that this route gives the certainty of faith. The Catholic writers who state
the spiral grant the circle and leave this route, to argue from Scripture read
only as history (Toner, *Catholic Encyclopedia*, "Infallibility"; Catholic
Answers, "Proving Inspiration"). -/
def circleAnswerInference : Source :=
  { primary := .work whitakerDisputation (.pages 334 335)
  , supporting := [.work catholicAnswersProvingInspiration (.sectionRef "A Spiral Argument")]
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- The rating of the step from "no surer than its history" to the conclusion
that the spiral gives no certainty of faith: `disputed`. Vatican I grants that
faith does not rest on the arguments that make it credible: we believe "not
because we perceive its intrinsic truth by the natural light of reason, but
because of the authority of God himself", "with the grace of God inspiring and
assisting us" (*Dei Filius*, ch. 3). So a reader may grant that the history is
no surer than history, and still hold that the Church's word, believed by
grace, gives the certainty of faith. -/
def spiralAnswerInference : Source :=
  { primary := .work tannerDecrees (.sectionRef "Vatican I (1870), Dei Filius, ch. 3")
  , supporting := [.work chillingworthReligion (.page 66)]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of the step from "the marks make the claim only credible" to the
conclusion that the marks give no certainty of faith: `disputed`. Bellarmine
grants the ground in so many words: the marks make the Church "evidently
credible", not evidently true (*De Ecclesia militante* IV.3). He denies the
conclusion, as Vatican I does, because the assent of faith rests on God's
authority with "the effective help of power from on high" (*Dei Filius*,
ch. 3). -/
def marksAnswerInference : Source :=
  { primary := .work bellarmineOpera2 (.sectionRef "De Ecclesia militante IV.3, pp. 365–366")
  , supporting := [.work tannerDecrees (.sectionRef "Vatican I (1870), Dei Filius, ch. 3")]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of the step from the doubts before Trent to the conclusion that
reception had not settled the canon: `disputed`. Reid grants the doubts ("Few
are found to unequivocally acknowledge their canonicity") and denies the
conclusion: the doubts "must be regarded as more or less academic", because
"Ecclesiastical usage and Roman tradition held firmly" (*Catholic
Encyclopedia*, "Canon of the Old Testament"). -/
def receptionAnswerInference : Source :=
  { primary := .work reidCanonOldTestament
      (.sectionRef "The canon of the Old Testament during the Middle Ages: The Latin Church")
  , supporting := [.work whitakerDisputation (.page 333)]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of the step from Mark 7's principle to the sole rule: `disputed`.
Grant that God's word judges human tradition and that no unwritten tradition can
be shown to be apostolic, and a reader may still deny that Scripture is the
*sole* infallible rule. Geiselmann is that reader: he holds that Scripture
contains all revealed content, grants the principle as every Catholic does, and
as a Catholic after Vatican I still holds the Magisterium an infallible
interpreter (*Pastor Aeternus* 4). Florovsky, for whom tradition adds nothing
to Scripture, likewise keeps the mind of the Church as its authoritative
interpreter. -/
def principleToSoleRuleInference : Source :=
  { primary := .work geiselmannMeaningOfTradition .whole
  , supporting :=
      [ .work tannerDecrees (.sectionRef "Vatican I (1870), Pastor Aeternus, ch. 4")
      , .work florovskyBibleChurchTradition .whole ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of the step from Jesus' sayings and Paul's letters to the principle:
`wellSupported`. Jesus says that "the Scripture cannot be broken" (John 10:35)
and that "not the smallest letter or stroke shall pass from the Law" (Matthew
5:18); Paul puts even an apostle and an angel under the gospel already preached
(Galatians 1:8–9), and sets "the tradition of men" against Christ (Colossians
2:8). From these to the principle that God's word judges human tradition, no
reader was found who grants the texts and denies the principle.

The nearest to a dissenter is Aquinas, and he grants it. He reads Galatians 1:8
as Paul wrote it, and answers the objection that it forbids teaching anything
not written in the Gospels and epistles: "nothing is to be taught except what is
contained, either implicitly or explicitly, in the Gospels and epistles and
Sacred Scripture". What he denies is a stronger claim, Calvin's, that "another
gospel" is any gospel "to which the inventions of other men are added": for
Aquinas, Paul's "besides" means "adding something completely alien" (his
lectures on Galatians, chapter 1, lecture 2). Rome's answer in Calvin's day was
of the same kind, as Calvin reports it at the same verse: "they tell us, that we
have not in our possession the whole of Paul's preaching". Paul himself commends
what he handed on by word: the Corinthians "hold firmly to the traditions, just
as I delivered them to you" (1 Corinthians 11:2); "hold to the traditions which
you were taught, whether by word of mouth or by letter from us" (2 Thessalonians
2:15; compare 3:6). On that reading the test Paul sets is where a teaching came
from, not whether it was written down. Both answers grant the principle, and
deny that it makes Scripture the only measure; that denial is weighed where the
argument needs it, at the premise about unwritten tradition and at the step to
the sole rule, both `disputed`.

Rated `wellSupported`, as Mark 7's step is, and not `consensus`, because the
step still generalises: John 10:35 and Matthew 5:18 speak of Scripture and the
law, Galatians 1:8 of the gospel preached, and only Colossians 2 of a tradition
in the church. Wenham's account of Jesus' teaching is the same as the step's:
Jesus "repudiates the petty traditions of the elders in favour of a sane and
spiritually minded attention to the Old Testament" (p. 28, of the grain plucked
on the sabbath). He also notes the other side of it: of the scribes in Moses'
seat Jesus says, in the English Wenham quotes, "all things therefore whatsoever
they bid you, these do and observe" (Matthew 23:2–3), and "To Jesus scribal lore
was valuable if linked with spiritual understanding" (p. 15). The principle
judges tradition; it does not abolish it. -/
def jesusAndPaulPrincipleInference : Source :=
  { primary := .work aquinasGalatians (.sectionRef "c. 1, lect. 2")
  , supporting :=
      [ .work tannerDecrees (.sectionRef "Vatican II (1965), Dei Verbum 10")
      , .work calvinGalatians (.adLoc ⟨.galatians, 1, 9⟩)
      , .work wenhamOurLordsView (.pageList [15, 19, 28])
      , .work lightfootColossians (.page 204)
      , .scripture
          [ { ref := .verse ⟨.firstCorinthians, 11, 2⟩ }
          , { ref := .verse ⟨.secondThessalonians, 3, 6⟩ } ] ]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- The rating of the Reformed step from Acts 15 to councils: `disputed`. The step
reads the council at Jerusalem as the Reformers did. Men from Judaea taught that
"Unless you are circumcised according to the custom of Moses, you cannot be
saved" (15:1), so the oldest custom Israel had was laid on the gentiles as a
condition of salvation. Peter answered it with the gospel, "we are saved through
the grace of the Lord Jesus, in the same way as they also are" (15:10–11), and
James with Scripture, "with this the words of the Prophets agree, just as it is
written" (15:15). Calvin draws the conclusion at 15:15: the apostles "took
nothing to themselves imperiously, but did reverently follow that which was
prescribed in the word of God", and were not ashamed "to profess themselves to
be the scholars of the Scripture". So a council after the apostles binds only as
far as it agrees with the word, and may err. The Westminster Confession says so
of councils: their decrees bind "if consonant to the Word of God", and "All
synods or councils since the apostles' times, whether general or particular, may
err, and many have erred; therefore they are not to be made the rule of faith or
practice, but to be used as a help in both" (XXXI.3–4, in the numbering of
1647).

Joseph Wilhelm, in the *Catholic Encyclopedia*, reads the same council and
denies the conclusion. For him the decree of 15:28 shows "the mind of the
Apostles" about councils: "they put the seal of supreme authority on their
decisions in attributing them to the joint action of the Spirit of God and of
themselves", and general councils in union with the pope have the same
"infallible authority". He grants every text the step reads, as every Catholic
does. So the step is `disputed`. -/
def acts15ReformedInference : Source :=
  { primary := .work wilhelmGeneralCouncils (.sectionRef "Infallibility of general councils")
  , supporting :=
      [ .work calvinActs2 (.adLoc ⟨.acts, 15, 15⟩)
      , .work westminsterConfession (.sectionRef "XXXI.3")
      , .work westminsterConfession (.sectionRef "XXXI.4") ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of Rome's step from Acts 15 to councils: `disputed`. The council's
letter says "it seemed good to the Holy Spirit and to us" (15:28), and Paul and
Silas "were delivering the decrees ... for them to keep" in the cities they
passed through (16:4). From these Wilhelm concludes that a general council in
union with the pope, like the council at Jerusalem, binds with the Spirit's
authority and cannot err.

The Westminster Confession grants both texts and denies the conclusion. It cites
Acts 15:27–31 and 16:4 as its proof that a council's decrees, "if consonant to
the Word of God, are to be received with reverence and submission ... for the
power whereby they are made, as being an ordinance of God" (XXXI.3), and then
says that councils since the apostles' times may err and are "not to be made the
rule of faith or practice" (XXXI.4). Calvin answers 15:28 itself: the apostles
claimed nothing apart from the Spirit, being "only ministers of the Spirit", and
"the Papists are doltish who go about, out of these words, to prove that the
Church hath some authority of her own". So the step is `disputed`. -/
def acts15RomanInference : Source :=
  { primary := .work westminsterConfession (.sectionRef "XXXI.4")
  , supporting :=
      [ .work westminsterConfession (.sectionRef "XXXI.3")
      , .work calvinActs2 (.adLoc ⟨.acts, 15, 28⟩) ]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- The rating of the Reformed step from the texts on the apostles to the end of
their office: `disputed`. The apostle chosen in Judas's place had to have
"accompanied us all the time that the Lord Jesus went in and out among us", to
be "a witness with us of His resurrection" (Acts 1:21–22); Paul counts himself
the last to whom the risen Christ appeared, "last of all, as to one untimely
born, He appeared to me also" (1 Corinthians 15:8); Peter counts Paul's letters
with "the rest of the Scriptures" (2 Peter 3:15–16); and Paul writes as "an
apostle of Christ Jesus" with "Timothy our brother" (2 Corinthians 1:1,
Colossians 1:1). So the apostles were a closed company, and their office ended
with them. Calvin draws it so. At Acts 1:21 he grants that "Peter doth here
require such a witness as saw the Lord after his resurrection ... For this did
serve for the confirmation of faith" (*Acts*, vol. 1, p. 66), and in the
*Institutes* the offices of apostle, prophet and evangelist "were not instituted
in the Church to be perpetual", while the twelve, "to the number of whom Paul
was afterwards added", were "distinguished from others by a peculiar title"
(IV.iii.4–5).

He grants as much as this too: pastors "have the same function as apostles",
except that each has a particular church (IV.iii.5), and God has at times
"raised up Apostles, or at least Evangelists, in their stead, as has been done in
our time" (IV.iii.4). What ends, for Calvin, is the office, not the preaching.

*Lumen Gentium*, the Second Vatican Council's constitution on the Church, grants
every text the step reads, as every Catholic does, and denies its conclusion:
"the apostles' office of nurturing the Church is permanent, and is to be
exercised without interruption by the sacred order of bishops", and "bishops by
divine institution have succeeded to the place of the apostles" (§20). So the
step is `disputed`. -/
def apostlesOfficeEndedInference : Source :=
  { primary := .work lumenGentium (.sectionRef "20")
  , supporting :=
      [ .work calvinInstitutesBeveridge3 (.sectionRef "IV.iii.4–5")
      , .work calvinActs1 (.page 66) ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of Rome's step from the succession texts to the apostles' office
continuing: `disputed`. Peter applies the Psalm to Judas, "Let another man take
his office (ἐπισκοπή)" (Acts 1:20); Paul bids Timothy "entrust these to faithful
men who will be able to teach others also" (2 Timothy 2:2); and Clement of Rome
records that the apostles appointed bishops and deacons and "afterwards gave
instructions, that when these should fall asleep, other approved men should
succeed them in their ministry" (1 Clement 44). So the apostles' office
continues in those who succeed them. *Lumen Gentium* 20 draws it so, and cites 2
Timothy 2:2 and 1 Clement 44 in its notes: "bishops by divine institution have
succeeded to the place of the apostles".

Calvin grants the texts and denies the conclusion. At Acts 1:20 he reads the
office, "bishoprick" in his translator's English, as "a jurisdiction or
government", and grants that "another may succeed him"; at 1:21 he answers that
the apostleship "is not without the preaching of the gospel", so that "the
Popish bishops ... brag that they are the successors of the apostles; but
wherein are they like unto them?" (*Acts*, vol. 1, pp. 65–66). In the
*Institutes* the apostolic office was not "instituted in the Church to be
perpetual" (IV.iii.4). Whether Clement's "succeed them in their ministry" means
succeeding to the apostles' office or to the ministry of the bishops and deacons
they appointed is the question itself. So the step is `disputed`. -/
def apostolicSuccessionInference : Source :=
  { primary := .work calvinActs1 (.pages 65 66)
  , supporting :=
      [ .work calvinInstitutesBeveridge3 (.sectionRef "IV.iii.4")
      , .work lumenGentium (.sectionRef "20")
      , .work clementCorinthians (.sectionRef "44") ]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- The rating of the Reformed step from Matthew 23:2–3 to the teaching office:
`disputed`. Jesus tells the crowd to do and keep "all that" the scribes and
Pharisees tell them, because they "have seated themselves in the chair of Moses"
(23:2–3). In the same discourse he condemns their teaching about oaths, "Woe to
you, blind guides, who say, 'Whoever swears by the sanctuary, that is nothing'"
(23:16–22), and in Mark 7 and Matthew 15 he condemns the elders' tradition for
making void the word of God. So, Calvin argues, the seat binds only so far as
Moses is taught from it: "to sit in the chair of Moses is nothing else than to
teach, according to the Law of God, how we ought to live", and "Christ exhorts
the people to obey the scribes, only so far as they adhere to the pure and
simple exposition of the Law" (pp. 74–75). He answers Rome by name: "The Papists
reckon it enough, that those who issue laws should possess the title and occupy
the station", and if Christ had meant to bind consciences to the commandments of
men, "there would have been no good ground for what he said in another passage,
that it is in vain to worship God by the commandments of men, (Matthew 15:9.)"
(p. 75).

Cornelius a Lapide grants every text the step reads and denies its conclusion.
He calls the scribes of 23:16 "rightly called by Christ blind guides" (p. 40),
and he grants that the corban teaching "was contrary to the Law, as Christ
showed" (p. 32). Yet he reads "all things" as "all things not contrary to Moses
and the Law", and holds that even the scribes' dogmas that were "vain and
foolish, and therefore not binding" could "yet serve for the merit of blind and
simple obedience, and for reverence of the sacerdotal order" (p. 33). So the
office is heeded for its seat, in what is not contrary to the law, and not only
where it teaches the law. Lapide reports that Maldonatus, a Catholic too,
"restricts the word all to such commands alone as are contained in the Law of
Moses" (p. 33); Maldonatus himself has not been read. So the step is
`disputed`. -/
def mosesSeatReformedInference : Source :=
  { primary := .work aLapideMatthew3 (.pages 32 33)
  , supporting :=
      [ .work aLapideMatthew3 (.page 40), .work calvinHarmony3 (.pages 74 75) ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of Rome's step from Matthew 23:2–3 to the teaching office:
`disputed`. Jesus bids the crowd observe what the scribes and Pharisees bid,
because of the seat they sit in, though "they say things and do not do them"
(23:2–3). Cornelius a Lapide takes the seat as "the honour, dignity, and
authority of teaching and commanding, which Moses had with the Jews, and to
which the Scribes had succeeded", and draws the Church's case from it: "In like
manner, the chair of S. Peter is used to signify the power and authority of
teaching and ruling all the faithful throughout the world, in which the Roman
Pontiffs succeed S. Peter" (p. 32). "Christians ought to bear in mind these
words of Christ when they see certain Bishops, Pastors, and Magistrates not
living in accordance with the law of Christ" (p. 33). So the office in the
Church is heeded for its seat, even when its holders live ill.

Calvin grants the text and denies the conclusion. He grants that the seat
"denotes, at the same time, a lawful calling; for Christ commands that the
scribes should be heard, because they were the public teachers of the Church",
and denies that the station is enough: "That man, therefore, sits in the chair
of Moses who teaches, not from himself, or at his own suggestion, but according
to the authority and word of God" (p. 75). So the step is `disputed`.

The step claims authority, not infallibility. Lapide goes on to say that the
pope "cannot err" when he defines the faith "ex cathedra" (p. 32), but he does
not draw that from Moses' seat, whose holders he says taught things "contrary to
the Law"; the step does not claim it. -/
def mosesSeatRomanInference : Source :=
  { primary := .work calvinHarmony3 (.pages 74 75)
  , supporting := [.work aLapideMatthew3 (.pages 32 33)]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- The rating of Trent's step, from 2 Thessalonians 2:15 and tradition as a
source of revelation to "Scripture is not the sole rule": `wellSupported`. Once
the grounds are granted the conclusion all but follows, and no reader was found
who grants both and denies it. Protestants deny the second ground instead, and
that dissent is weighed in its own rating. -/
def tridentineInference : Source :=
  { primary := .work tannerDecrees
      (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions")
  , tradition := .romanCatholic
  , confidence := .wellSupported }

/-- The rating of the classical step, from 2 Timothy 3:16–17, sufficiency,
clarity and Scripture's own teaching to "Scripture is the sole infallible rule":
`wellSupported`. The Westminster Confession draws it, citing 2 Timothy 3:16–17
for "the whole counsel of God … unto which nothing at any time is to be added,
whether by new revelations of the Spirit, or traditions of men" (I.6). No reader
was found who grants all five grounds and denies the conclusion. Rome denies the
grounds instead: Staples, for Catholic Answers, that "II Timothy 3 … does not even
hint at sola scriptura". Not `consensus`, for the reason `tridentineInference`
is not: once the last ground is granted, the conclusion all but follows. -/
def classicalInference : Source :=
  { primary := .work westminsterConfession (.sectionRef "I.6")
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- The rating of the eliminative step, from "Scripture is infallible" and "no
other rule is" to "Scripture is the sole infallible rule": `wellSupported`. The
step is close to what "sole" means. The Westminster Confession draws it: the
supreme judge "can be no other but the Holy Spirit speaking in the Scripture"
(I.10), and councils since the apostles "may err" (XXXI.4). No reader was found
who grants both grounds and denies it. Vincent of Lérins grants the canon
"sufficient of itself for everything" and still joins the Church's
interpretation to it as a norm; that is a dispute over what "rule" means, not
over this step. -/
def eliminativeInference : Source :=
  { primary := .work westminsterConfession (.sectionRef "I.10")
  , supporting := [.work westminsterConfession (.sectionRef "XXXI.4")]
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- The rating of Tradition 0's step: `wellSupported`. Geisler draws it in his
review of Mathison (pp. 120–121, where the grounds are cited). Its grounds
include the eliminative step's, so it can be rated no higher than that step,
and no one was found who grants them and denies the conclusion. Mathison denies
a ground, that creeds inform without binding, and that is weighed there. -/
def tradition0Inference : Source :=
  { primary := .work geislerReviewMathison (.sectionRef "120–121")
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- The rating of Tradition III's step, from an infallible magisterium to the
denial that Scripture is the sole infallible rule: `wellSupported`. Vatican II
draws it: "it is not from Sacred Scripture alone that the Church draws her
certainty about everything which has been revealed", and Scripture, tradition
and the teaching office "are so linked and joined together that one cannot
stand without the others" (*Dei Verbum* 9–10). Protestants deny the ground, that
the magisterium is infallible, not the step. -/
def vaticanInference : Source :=
  { primary := .work tannerDecrees (.sectionRef "Vatican II (1965), Dei Verbum 9–10")
  , supporting := [.work tannerDecrees (.sectionRef "Vatican I (1870), Pastor Aeternus, ch. 4")]
  , tradition := .romanCatholic
  , confidence := .wellSupported }

/-- The rating of the Orthodox step, from the infallible mind of the Church to the
denial that Scripture is the sole infallible rule: `wellSupported`. Florovsky
grounds the councils' teaching authority "in the infallibility of the Church".
The Confession of Dositheus (Jerusalem, 1672) draws the conclusion in its second
decree: Scripture is believed "not otherwise than as the Catholic Church hath
interpreted and delivered the same", and the Church's witness is "not of
inferior authority to that of the Divine Scriptures". No reader was found who
grants the ground and denies the step. -/
def orthodoxInference : Source :=
  { primary := .work florovskyBibleChurchTradition .whole
  , supporting := [.work wareOrthodoxChurch .whole]
  , tradition := .easternOrthodox
  , confidence := .wellSupported }

/-- The rating of the self-refutation step, from "only what Scripture teaches
binds" and "Scripture does not teach sola scriptura" to "Scripture is not the
sole infallible rule": `disputed`. Broussard draws it: sola scriptura "must be
proven from Scripture to pass its own test", "And given that it can't, it's
self-defeating." Harper grants both grounds, "for the sake of argument", and
denies the conclusion. What follows, he says, is only that the doctrine cannot
be held infallibly; it "does not need to be taught explicitly in the Bible or
infallibly known in order to be true". The grounds give "the doctrine does not
bind", and the step passes from that to "the doctrine is false". -/
def selfRefutationInference : Source :=
  { primary := .work broussardBestArgument .whole
  , supporting := [.work harperSelfRefuting .whole]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of the regress step, from ministerial tradition and the
individual's final choice of whom to submit to, to "sola scriptura does not
differ in principle from solo scriptura": `disputed`. Cross and Judisch draw it:
"when I submit (so long as I agree), the one to whom I submit is me", so "there
is no principled difference between sola scriptura and solo scriptura with
respect to the locus of 'ultimate interpretive authority'". Mathison, replying
to them, grants "the fact that an individual must determine whether or not to
submit to an authority", and denies the conclusion: "there is in fact a real
principled difference". -/
def interpretiveRegressInference : Source :=
  { primary := .work crossJudischInterpretiveAuthority (.sectionRef "§§ I, IV.B")
  , supporting := [.work mathisonReplyCrossJudisch .whole]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of the step in Geisler's charge, from the two legs to "Tradition
I's reasoning is circular": `wellSupported`. Geisler draws it (pp. 122–123).
That each leg rests on the other is what circular means, and no reader was found
who grants both legs and denies the circle. Allen and Swain deny the second leg,
and that is weighed in its rating. -/
def circleInference : Source :=
  { primary := .work geislerReviewMathison (.sectionRef "122–123")
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- The rating of the step from the circle to its defeating Tradition I,
provided not every appeal to an ultimate authority is circular: `plausible`,
and the library's own. Geisler is cited for the conclusion, but no source was
found that argues from the condition, and none that grants both grounds and
denies the defeat. -/
def circleDefeatsInference : Source :=
  { primary := .proposal
      ("Assembled here to state what Geisler's charge needs against Barrett's " ++
       "parity reply: a circle counts against a position only if its rivals " ++
       "escape it. Geisler is cited for the conclusion, not for this condition.")
  , supporting := [.work geislerReviewMathison (.sectionRef "123")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .plausible }

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .timothy3_16GodBreathed =>
    { label := "2 Timothy 3:16 — all scripture is God-breathed and profitable"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.secondTimothy, 3, 16⟩ }] "I.vii.1" }
  | .timothy3_17ThoroughlyEquips =>
    { label :=
        "2 Timothy 3:17 — that the man of God may be complete, equipped for every good work"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.secondTimothy, 3, 17⟩ }] "I.vii.1" }
  | .mark7TraditionCanNullify =>
    { label :=
        "Mark 7:1–13 (Matthew 15:1–9) — Jesus rebukes the elders' tradition, " ++
        "Corban above all, for voiding God's command"
    , kind := .textual
      -- What the text says, which no party disputes: Rome and the Reformers
      -- differ over what it reaches, not over what it reports.
    , source :=
        { primary := .scripture [{ ref := .range mark7_1to13 }, { ref := .range matthew15_1to9 }]
        , supporting := [.work calvinInstitutes (.sectionRef "IV.x.10")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .acts17BereansTested =>
    { label := "Acts 17:11 — the Bereans tested apostolic preaching against scripture"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.acts, 17, 11⟩ }] "I.vii.2" }
  | .thessalonians2_15TraditionBinding =>
    { label := "2 Thessalonians 2:15 — hold to the traditions taught by word or letter"
    , kind := .textual
      -- Shared ground. Every position has to say something about unwritten
      -- apostolic teaching; filing this as Rome's prooftext left the
      -- Protestant packages with no answer to it.
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.secondThessalonians, 2, 15⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .scriptureIsInfallible =>
    { label := "Scripture is infallible"
    , kind := .theological
    , source :=
        { primary := .work grudemSystematicTheology (.sectionRef "ch. 5")
        , supporting := [.work calvinInstitutes (.sectionRef "I.vii")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .scriptureIsSufficient =>
    { label := "Scripture is a sufficient rule of faith"
    , kind := .theological
      -- Carries the preservation claim as well as its own: a filter on
      -- tradition cannot retain the apostolic deposit unless the deposit is in
      -- scripture. Calvin alone was too thin a footing for that.
    , source :=
        { primary := .work grudemSystematicTheology (.sectionRef "ch. 8")
        , supporting :=
            [ .work websterHolyScripture .whole
            , .work bavinckProlegomena .whole
            , .work calvinInstitutes (.sectionRef "I.vii")
            , .work westminsterConfession (.sectionRef "I.6") ]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .scriptureIsPerspicuous =>
    { label := "Scripture is clear on what is necessary for salvation"
    , kind := .theological
    , source := calvinHolds "I.vii.5" .disputed }
  | .scriptureIsSoleInfallibleRule =>
    { label := "Scripture is the sole infallible rule of faith"
    , kind := .theological
    , source := calvinHolds "I.vii–ix" .disputed }
  | .solaScripturaIsTaughtByScripture =>
    { label := "Scripture itself teaches that scripture is the sole infallible rule"
    , kind := .interpretive
    , source := calvinHolds "I.vii.4" .disputed }
  | .onlyScripturalDoctrineIsBinding =>
    { label := "A doctrine is binding only if scripture teaches it"
    , kind := .theological
    , source := calvinHolds "IV.x.8" .disputed }
  | .noOtherRuleIsInfallible =>
    { label := "No candidate rule of faith other than scripture is infallible"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "I.6")
        , supporting := [.work mathisonShapeSolaScriptura .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .traditionIsCoordinateSourceOfRevelation =>
    { label := "Tradition is a coordinate source of revelation alongside scripture"
    , kind := .theological
      -- `disputed`, not `wellSupported` as it was; the atom's docstring gives
      -- Geiselmann's and Congar's reasons. The rating was information for a
      -- reader until the Mark 7 dispute made it decide who prevails.
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions")
        , supporting :=
            [ .work mathisonShapeSolaScriptura .whole
            , .work geiselmannMeaningOfTradition .whole
            , .work congarTraditionAndTraditions .whole ]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .magisteriumIsInfallible =>
    { label := "The magisterium is an infallible interpreter of scripture"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Vatican I (1870), Pastor Aeternus, ch. 4")
        , supporting := [.work mathisonShapeSolaScriptura .whole]
        , tradition := .romanCatholic
        , confidence := .wellSupported } }
  | .churchMindIsInfallibleInterpreter =>
    { label :=
        "The mind of the Church, in the consensus of the Fathers and in received " ++
        "conciliar decisions, infallibly interprets scripture"
    , kind := .theological
      -- Not the magisterial premise. Florovsky rejects the two-sources model
      -- outright, so encoding Orthodoxy with a Tridentine premise gets the
      -- objection backwards rather than merely imprecise.
    , source :=
        { primary := .work florovskyBibleChurchTradition .whole
        , supporting := [.work wareOrthodoxChurch .whole]
        , tradition := .easternOrthodox
        , confidence := .wellSupported } }
  | .canonKnownThroughChurchReception =>
    { label := "The canon is known through the Church's reception of it"
    , kind := .historical
    , source :=
        { primary := .work npnfAugustineManichaeans
            (.sectionRef "Augustine, Contra epistolam Manichaei 5.6")
        , supporting :=
            [ .work tannerDecrees
                (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions") ]
        , tradition := .romanCatholic
        , confidence := .consensus } }
  | .identifyingCanonRequiresInfallibleAuthority =>
    { label := "Identifying the canon requires an infallible authority outside Scripture"
    , kind := .theological
      -- Held by Trent and, explicitly, by Reid ("through the constituted organ
      -- and custodian of Its revelations, the Church"); denied by Calvin, for
      -- whom the Church receiving Scripture "does not make that authentic which
      -- was otherwise doubtful" (Institutes I.vii.2), and by Kruger.
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions")
        , supporting :=
            [ .work reidCanonNewTestament (.sectionRef "The criterion of inspiration") ]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .rivalAuthorityIsAlsoSelfAuthenticating =>
    { label :=
        "A rival's own foundational authority is self-authenticating too, so the " ++
        "circularity charge does not discriminate"
    , kind := .interpretive
    , source := heldBy krugerCanonRevisited "ch. 2" .reformedProtestant }
  | .deut13_1_3ProphetOfOtherGods =>
    { label :=
        "Deuteronomy 13:1–3 — a prophet whose sign comes to pass, but who says, Let us " ++
        "go after other gods, is not to be heard"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .range ⟨.deuteronomy, 13, 1, 13, 3⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .deut18_20_22WordNotFulfilled =>
    { label :=
        "Deuteronomy 18:20–22 — a word spoken in the LORD's name that does not come " ++
        "to pass is a word the LORD has not spoken"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .range ⟨.deuteronomy, 18, 20, 18, 22⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .booksReadButNotReceived =>
    { label :=
        "The early Church set apart books it read but did not receive into the canon, " ++
        "the Shepherd and the Didache among them, and said why"
    , kind := .historical
      -- What the documents say. Not every early writer agreed: Irenaeus quotes
      -- the Shepherd as "the Scripture" (Against Heresies IV.20.2). The claim is
      -- that these witnesses drew the line and gave their reasons, not that
      -- everyone drew it in the same place.
    , source :=
        { primary := .work anf5 (.pages 603 604)
        , supporting :=
            [ .work npnf2v4 (.sectionRef "Athanasius, Festal Letter 39, §§6–7, p. 552")
            , .work mcdonaldIntegrityCanon (.pages 127 129) ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .providenceKeepsScripture =>
    { label :=
        "God by his providence keeps his written word and brings it to his people, and " ++
        "the tests are applied under that providence"
    , kind := .theological
      -- Kruger's model names "providential exposure" of the books to the church
      -- as one of its parts; the page is known only from reviews, so the chapter
      -- is cited.
    , source :=
        { primary := .work westminsterConfession (.sectionRef "I.8")
        , supporting :=
            [ .work krugerCanonRevisited
                (.sectionRef "\"My sheep hear my voice: canon as self-authenticating\"") ]
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .eph2_20FoundationOfApostles =>
    { label :=
        "Ephesians 2:20 and Jude 3 — the church is built on the foundation of the " ++
        "apostles and prophets, and the faith was once for all handed down to the saints"
    , kind := .textual
    , source :=
        { primary := .scripture
            [ { ref := .verse ⟨.ephesians, 2, 20⟩ }, { ref := .verse ⟨.jude, 1, 3⟩ } ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .pet3_15_16PaulAmongScriptures =>
    { label :=
        "2 Peter 3:15–16 counts Paul's letters with \"the rest of the Scriptures\", 3:2 sets " ++
        "the apostles' commandment beside the prophets, and 1 Timothy 5:18 calls a " ++
        "saying Luke 10:7 records \"scripture\""
    , kind := .textual
    , source :=
        { primary := .scripture
            [ { ref := .range ⟨.secondPeter, 3, 15, 3, 16⟩ }
            , { ref := .verse ⟨.secondPeter, 3, 2⟩ }
            , { ref := .verse ⟨.firstTimothy, 5, 18⟩ }
            , { ref := .verse ⟨.luke, 10, 7⟩ } ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .gal1_8NoOtherGospel =>
    { label :=
        "Galatians 1:8 — even if we, or an angel from heaven, should proclaim a gospel " ++
        "contrary to the one first proclaimed, let him be accursed"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.galatians, 1, 8⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .prophecyCeasedBeforeLaterBooks =>
    { label :=
        "First-century Jews held that prophecy had ceased, and did not give the books " ++
        "written after it the authority of the earlier ones"
    , kind := .historical
      -- What Josephus reports, and what 1 Maccabees says of its own time. Trent
      -- receives 1 Maccabees and the other books Josephus leaves out; the claim
      -- is what was held then, not that Trent is wrong.
    , source :=
        { primary := .work josephusAgainstApion (.sectionRef "I.8")
        , supporting :=
            [ .scripture
                [ { ref := .verse ⟨.firstMaccabees, 9, 27⟩ }
                , { ref := .verse ⟨.firstMaccabees, 4, 46⟩ }
                , { ref := .verse ⟨.firstMaccabees, 14, 41⟩ } ] ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .churchKnownFromInspiredScripture =>
    { label :=
        "The infallible authority that identifies the canon is known by proving the " ++
        "Church from Scripture received as inspired"
    , kind := .theological
      -- No Catholic writer found holds this route; Toner and Catholic Answers
      -- reject it as circular. It is the reading Whitaker answers.
    , source := heldBy whitakerDisputation "pp. 334–335" .reformedProtestant }
  | .spiralGivesCertaintyOfTheCanon =>
    { label :=
        "Scripture read as reliable history shows an infallible Church, whose word " ++
        "gives the certainty of faith about which books are inspired"
    , kind := .theological
    , source :=
        { primary := .work tonerInfallibility (.sectionRef "Proof from Scripture")
        , supporting := [.work catholicAnswersProvingInspiration (.sectionRef "A Spiral Argument")]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .marksGiveCertaintyOfTheCanon =>
    { label :=
        "The Church's marks show it to be the infallible authority, and so give the " ++
        "certainty of faith about the canon"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees (.sectionRef "Vatican I (1870), Dei Filius, ch. 3")
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .receptionSettledTheCanon =>
    { label :=
        "The Church's universal reception and ordinary teaching settled the canon " ++
        "before any council defined it"
    , kind := .theological
    , source :=
        { primary := .work reidCanonNewTestament (.sectionRef "The criterion of inspiration")
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .provingEachFromTheOtherIsCircular =>
    { label :=
        "To prove the Church from Scripture received as inspired, and then Scripture's " ++
        "inspiration from the Church, is to argue in a circle"
    , kind := .theological
      -- Granted by the Catholic sources that state the spiral: "That indeed
      -- would be a circular argument!" (Catholic Answers); "no vicious circle"
      -- only when Scripture is used "merely as reliable historical sources"
      -- (Toner).
    , source :=
        { primary := .work whitakerDisputation (.pages 334 335)
        , supporting :=
            [ .work catholicAnswersProvingInspiration (.sectionRef "A Spiral Argument")
            , .work tonerInfallibility (.sectionRef "Proof from Scripture") ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .conclusionNoSurerThanItsHistory =>
    { label :=
        "A conclusion reasoned from history is, by natural means, no surer than that " ++
        "history, and the judgement that the Gospels are reliable history is fallible"
    , kind := .theological
      -- Denied by Vatican I, which anathematises saying that miracles "can never
      -- be known with certainty" (Dei Filius, ch. 3, canon 4), and by Newman,
      -- who rejects "the pretentious axiom that probable reasoning can never
      -- lead to certitude" (Grammar of Assent, ch. 6).
    , source :=
        { primary := .work chillingworthReligion (.page 66)
        , supporting :=
            [.work turretinInstitutio1 (.sectionRef "Locus II, Q. VI, §XXI, p. 85")]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .marksMakeTheClaimOnlyCredible =>
    { label :=
        "The Church's marks make its claim credible, not evident, and other churches " ++
        "claim the same marks"
    , kind := .theological
    , source :=
        { primary := .work bellarmineOpera2 (.sectionRef "De Ecclesia militante IV.3, pp. 365–366")
        , supporting :=
            [ .work calvinInstitutesBeveridge3 (.sectionRef "IV.ii.2")
            , .work turretinInstitutio3 (.sectionRef "Locus XVIII, Q. XIII, §IV, pp. 83–84") ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .disputedBooksDoubtedBeforeTrent =>
    { label :=
        "Before Trent the Latin Church did not receive the disputed books with one " ++
        "voice: Jerome left them out, Gregory called 1 Maccabees not canonical, and " ++
        "Cajetan followed Jerome"
    , kind := .historical
    , source :=
        { primary := .work reidCanonOldTestament
            (.sectionRef "The canon of the Old Testament during the Middle Ages: The Latin Church")
        , supporting :=
            [ .work npnf2v6
                (.sectionRef "Jerome, Prefaces to Samuel and Kings, and to the Books of Solomon")
            , .work gregoryMoralia2 (.sectionRef "XIX.xxi.34, p. 424")
            , .work whitakerDisputation (.pages 47 48)
            , .work reidCanonNewTestament .whole ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .traditionHasMinisterialAuthority =>
    { label := "Tradition carries real but fallible — ministerial — authority"
    , kind := .theological
    , source :=
        { primary := .work mathisonShapeSolaScriptura .whole
        , supporting := [.work obermanDawn .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .traditionIDiffersInPrincipleFromTradition0 =>
    { label := "Sola scriptura differs in principle from solo scriptura"
    , kind := .theological
    , source := heldBy mathisonShapeSolaScriptura "ch. 9" .reformedProtestant }
  | .individualRetainsUltimateInterpretiveAuthority =>
    { label :=
        "The individual retains ultimate interpretive authority, exercised " ++
        "indirectly by choosing which body to submit to"
    , kind := .theological
    , source := heldBy crossJudischInterpretiveAuthority "§ IV.A–B" .romanCatholic }
  | .choosingAnAuthorityIsItselfPrivateJudgment =>
    { label :=
        "Choosing which authority to submit to is itself private judgement, " ++
        "whichever authority is chosen"
    , kind := .interpretive
    , source := heldBy mathisonShapeSolaScriptura "ch. 9" .reformedProtestant }
  | .bindingnessAppliesToFirstOrderDoctrineOnly =>
    { label :=
        "The bindingness rule governs first-order doctrine, not a claim about " ++
        "where binding doctrine comes from"
    , kind := .theological
      -- The scope distinction between doctrine and practice is carried by atom
      -- design and this docstring, not by the logic: the fragment is
      -- propositional and cannot quantify.
    , source :=
        { primary := .work westminsterConfession (.sectionRef "I.6")
        , supporting := [.work mathisonShapeSolaScriptura .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .practiceNeitherCommandedNorForbiddenIsPermitted =>
    { label :=
        "A practice neither commanded nor forbidden in scripture is permitted " ++
        "without scriptural warrant"
    , kind := .theological
    , source :=
        { primary := .work bookOfConcord
            (.sectionRef "Formula of Concord, Solid Declaration X")
        , supporting := [.work westminsterConfession (.sectionRef "I.6")]
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .creedsAreInformativeNotNormative =>
    { label := "Creeds are informative without being normative"
      -- Tradition 0 cited from someone who holds it. Geisler's principal
      -- complaint against Mathison is that this position has no slot in the
      -- taxonomy and is described only by its critic.
    , kind := .theological
    , source := heldBy geislerReviewMathison "120" .christianHistoricalGrammatical }
  | .historicalGrammaticalMethodSuffices =>
    { label :=
        "The historical-grammatical method alone suffices to obtain the meaning " ++
        "of scripture on essential doctrine"
    , kind := .interpretive
    , source := heldBy geislerReviewMathison "120–121" .christianHistoricalGrammatical }
  | .creedalConsensusIsHermeneuticallyNecessary =>
    { label := "The creedal consensus is hermeneutically necessary for understanding scripture"
    , kind := .interpretive
    , source := heldBy mathisonShapeSolaScriptura "275" .reformedProtestant }
  | .doctrineDevelopsWithoutNewRevelation =>
    { label := "Doctrine develops without new revelation: the deposit is closed"
      -- Shared ground, not the dispute. Both Rome and Tradition I hold it; they
      -- differ over what authenticates a development.
    , kind := .theological
    , source :=
        { primary := .work newmanDevelopment .whole
        , supporting := [.work mathisonShapeSolaScriptura .whole]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .developmentIsAuthenticatedByTheChurch =>
    { label := "A development is authenticated by the authority of the developing body"
    , kind := .theological
    , source := heldBy newmanDevelopment "ch. 2" .romanCatholic .wellSupported }
  | .creedalConsensusRestsOnPerspicuity =>
    { label := "The creedal consensus rests on the clarity of scripture"
    , kind := .interpretive
    , source := heldBy mathisonShapeSolaScriptura "279–280" .reformedProtestant }
  | .perspicuityRequiresCreedalConsensus =>
    { label := "Scripture's clear sense is not obtainable without the creedal consensus"
    , kind := .interpretive
    , source := heldBy mathisonShapeSolaScriptura "275" .reformedProtestant }
  | .traditionIReasoningIsCircular =>
    { label := "Tradition I's reasoning is circular"
    , kind := .interpretive
    , source := heldBy geislerReviewMathison "122–123" .christianHistoricalGrammatical }
  | .circularityDefeatsTraditionI =>
    { label := "The circularity defeats Tradition I"
    , kind := .theological
    , source := heldBy geislerReviewMathison "123" .christianHistoricalGrammatical }
  | .everyUltimateAuthorityIsCircular =>
    { label :=
        "Any appeal to an ultimate authority is circular, there being no higher " ++
        "authority to appeal to"
    , kind := .theological
    , source := heldBy barrettGodsWordAlone "ch. 11" .reformedProtestant }
  | .creedalConsensusIsDerivedFromScripture =>
    { label :=
        "The creedal consensus is established by and accountable to scripture — " ++
        "a product of reading it, not a precondition of it"
    , kind := .theological
    , source := heldBy allenSwainReformedCatholicity "ch. 3" .reformedProtestant }
  | .scriptureBoundsTheInterpretiveOffice =>
    { label :=
        "Scripture itself bounds the interpretive office: elders are commended " ++
        "to the word, required to hold to it, and forbidden to domineer"
    , kind := .textual
      -- **Proposed.** The passages are cited, and the claim that they bound the
      -- office rather than merely describing it is the library's own assembly:
      -- no source was found advancing these texts as an answer to Geisler.
    , source :=
        { primary := .proposal
            ("Advanced here, not found in the literature as a reply to the " ++
             "circularity charge. The texts are cited; the use is assembled. " ++
             "Note it claims only that scripture *bounds* the office, not that " ++
             "it *confers* it — conferral invites the recognition/conferral " ++
             "distinction Mathison himself presses against Rome.")
        , supporting :=
            [ .scripture
                [ { ref := .verse ⟨.acts, 20, 32⟩ }
                , { ref := .verse ⟨.titus, 1, 9⟩ }
                , { ref := .range ⟨.firstPeter, 5, 2, 5, 3⟩ } ] ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .plausible } }
  | .godsWordJudgesTradition =>
    { label :=
        "God's word judges human tradition: no commandment of men may be taught " ++
        "as God's word, and a tradition that voids God's command is void"
    , kind := .theological
      -- Common ground. "God's word" is left as each side uses it: for Rome it
      -- includes apostolic Tradition, and the principle is granted on those
      -- terms. Read as "Scripture only", it would be a different, disputed claim.
    , source :=
        { primary := .work tannerDecrees (.sectionRef "Vatican II (1965), Dei Verbum 10")
        , supporting :=
            [ .work calvinInstitutes (.sectionRef "IV.x.23")
            , .work florovskyBibleChurchTradition .whole ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .mensCommandmentBindsAsGodsWord =>
    { label := "A commandment of men may rightly be bound on the Church as God's word"
    , kind := .interpretive
      -- What the elders claimed for Corban. Whether any tradition Rome holds
      -- is bound so is what Calvin asserts and Rome denies.
    , source :=
        { primary := .scripture [{ ref := .verse mark7_7 }, { ref := .verse isaiah29_13 }]
        , supporting := [.work calvinInstitutes (.sectionRef "IV.x.23")]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .noUnwrittenTraditionShownApostolic =>
    { label :=
        "No unwritten tradition can now be shown to be apostolic, so none can " ++
        "bind the conscience as the word of God"
    , kind := .theological
      -- Whitaker, question VI, chapter IV (pp. 503–511), answering Bellarmine's
      -- five rules: "the papists have no such unwritten tradition which can be
      -- certainly shewn to have been always observed by the universal church"
      -- (506); and "if they could with so much clearness and authority prove
      -- their traditions to be as true as the precepts of scripture, we would
      -- willingly receive them ... but ... even they themselves do not
      -- certainly know their own traditions" (594). A claim about proof, not
      -- about what the apostles said. Denied by Rome: Trent, Session IV
      -- (Waterworth 18), "the written books, and the unwritten traditions";
      -- Dei Verbum 9, "it is not from Sacred Scripture alone that the Church
      -- draws her certainty about everything which has been revealed".
    , source :=
        { primary := .work whitakerDisputation (.pages 503 511)
        , supporting :=
            [ .work whitakerDisputation (.page 594)
            , .work westminsterConfession (.sectionRef "I.6") ]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .john10_35ScriptureCannotBeBroken =>
    { label := "John 10:35 — the Scripture cannot be broken"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.john, 10, 35⟩ }]
        , supporting := [.work wenhamOurLordsView (.page 19)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .matthew5_18LawShallNotPass =>
    { label :=
        "Matthew 5:18 — not the smallest letter or stroke shall pass from the Law " ++
        "until all is accomplished"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.matthew, 5, 18⟩ }]
        , supporting := [.work wenhamOurLordsView (.pageList [15, 19])]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .galatians1_8AnotherGospelAccursed =>
    { label :=
        "Galatians 1:8–9 — even if we, or an angel from heaven, should proclaim a " ++
        "gospel contrary to the gospel we have proclaimed, let him be accursed"
    , kind := .textual
      -- What the text says, which Calvin and Aquinas both grant. They differ
      -- over what "contrary to" (παρ' ὃ, also "besides") reaches: an addition,
      -- or only something alien. That is weighed in the step's rating.
    , source :=
        { primary := .scripture [{ ref := .range ⟨.galatians, 1, 8, 1, 9⟩ }]
        , supporting :=
            [ .work calvinGalatians (.adLoc ⟨.galatians, 1, 9⟩)
            , .work aquinasGalatians (.sectionRef "c. 1, lect. 2") ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .colossians2_8TraditionOfMen =>
    { label :=
        "Colossians 2:8, 20–22 — according to the tradition of men, and not " ++
        "according to Christ; in accordance with the commands and teachings of men"
    , kind := .textual
    , source :=
        { primary :=
            .scripture
              [ { ref := .verse ⟨.colossians, 2, 8⟩ }
              , { ref := .range ⟨.colossians, 2, 20, 2, 22⟩ } ]
        , supporting := [.work lightfootColossians (.page 204)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .acts15_1CircumcisionAfterMoses =>
    { label :=
        "Acts 15:1 — unless you are circumcised according to the custom of Moses, " ++
        "you cannot be saved"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.acts, 15, 1⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .acts15_10_11YokeAndGrace =>
    { label :=
        "Acts 15:10–11 — a yoke which neither our fathers nor we have been able to " ++
        "bear; we are saved through the grace of the Lord Jesus"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .range ⟨.acts, 15, 10, 15, 11⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .acts15_15_17ProphetsAgree =>
    { label :=
        "Acts 15:15–17 — with this the words of the Prophets agree, just as it is " ++
        "written (Amos 9:11–12)"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .range ⟨.acts, 15, 15, 15, 17⟩ }]
        , supporting := [.work calvinActs2 (.adLoc ⟨.acts, 15, 15⟩)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .acts15_23_29DecreeWritten =>
    { label := "Acts 15:23–29 — they sent this letter by them: the decree went out in writing"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .range ⟨.acts, 15, 23, 15, 29⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .acts15_28SeemedGoodToTheHolyGhost =>
    { label :=
        "Acts 15:28 — it seemed good to the Holy Spirit and to us to lay upon you " ++
        "no greater burden than these essentials"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.acts, 15, 28⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .acts16_4DecreesDelivered =>
    { label :=
        "Acts 16:4 — they were delivering the decrees which had been decided upon " ++
        "by the apostles and elders who were in Jerusalem, for them to keep"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.acts, 16, 4⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .councilBindsWithTheSpiritsAuthority =>
    { label :=
        "A general council after the apostles binds with the Holy Spirit's " ++
        "authority, as the council at Jerusalem did, and cannot err"
    , kind := .theological
      -- Rome's claim, as Wilhelm states it at Acts 15:28. `disputed`: the
      -- Westminster Confession cites the same texts and holds that councils
      -- since the apostles' times may err (XXXI.3–4).
    , source :=
        { primary := .work wilhelmGeneralCouncils
            (.sectionRef "Infallibility of general councils")
        , supporting :=
            [ .work westminsterConfession (.sectionRef "XXXI.4")
            , .work calvinActs2 (.adLoc ⟨.acts, 15, 28⟩) ]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .matthew23_2_3MosesSeat =>
    { label :=
        "Matthew 23:2–3 — the scribes and the Pharisees have seated themselves in " ++
        "the chair of Moses; therefore all that they tell you, do and keep, but do " ++
        "not do according to their deeds"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .range ⟨.matthew, 23, 2, 23, 3⟩ }]
        , supporting := [.work wenhamOurLordsView (.page 15)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .matthew23_16_22BlindGuides =>
    { label :=
        "Matthew 23:16–22 — woe to you, blind guides, who say, Whoever swears by " ++
        "the sanctuary, that is nothing"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .range ⟨.matthew, 23, 16, 23, 22⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .teachingOfficeHeardByItsSeat =>
    { label :=
        "Those who hold the Church's teaching office are to be heeded for the " ++
        "seat they hold, in whatever is not contrary to God's law, even when " ++
        "they live ill"
    , kind := .theological
      -- Rome's claim, as Cornelius a Lapide states it at Matthew 23:2–3.
      -- `disputed`: Calvin reads the same verses and holds that the scribes are
      -- to be obeyed only so far as they expound the law.
    , source :=
        { primary := .work aLapideMatthew3 (.pages 32 33)
        , supporting := [.work calvinHarmony3 (.pages 74 75)]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .acts1_21_22WitnessOfResurrection =>
    { label :=
        "Acts 1:21–22 — of the men who have accompanied us all the time ... one of " ++
        "these must become a witness with us of His resurrection"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .range ⟨.acts, 1, 21, 1, 22⟩ }]
        , supporting := [.work calvinActs1 (.page 66)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .corinthians15_8LastOfAll =>
    { label := "1 Corinthians 15:8 — and last of all ... He appeared to me also"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.firstCorinthians, 15, 8⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .peter3_15_16PaulsEpistlesWithTheScriptures =>
    { label :=
        "2 Peter 3:15–16 — Paul's letters, which the untaught and unstable distort, " ++
        "as they do also the rest of the Scriptures"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .range ⟨.secondPeter, 3, 15, 3, 16⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .salutationsApostleAndBrother =>
    { label :=
        "2 Corinthians 1:1; Colossians 1:1 — Paul, an apostle of Christ Jesus, and " ++
        "Timothy our brother"
    , kind := .textual
    , source :=
        { primary :=
            .scripture
              [ { ref := .verse ⟨.secondCorinthians, 1, 1⟩ }
              , { ref := .verse ⟨.colossians, 1, 1⟩ } ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .thessalonians2_6ApostlesOfChrist =>
    { label :=
        "1 Thessalonians 2:6 (with 1:1) — from Paul, Silvanus and Timothy: as " ++
        "apostles of Christ we could have been a burden"
    , kind := .textual
    , source :=
        { primary :=
            .scripture
              [ { ref := .verse ⟨.firstThessalonians, 1, 1⟩ }
              , { ref := .verse ⟨.firstThessalonians, 2, 6⟩ } ]
        , supporting :=
            [ .work coppietersApostles (.sectionRef "Various meanings")
            , .work calvinThessalonians (.adLoc ⟨.firstThessalonians, 2, 6⟩) ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .apostlesOfficeEndedWithThem =>
    { label :=
        "The apostles' own office ended with them; those after them succeed to " ++
        "their ministry, not to their office"
    , kind := .theological
      -- Calvin's claim (Institutes IV.iii.4–5). `disputed`: Lumen Gentium 20
      -- holds that the apostles' office is permanent in the order of bishops.
    , source :=
        { primary := .work calvinInstitutesBeveridge3 (.sectionRef "IV.iii.4–5")
        , supporting := [.work lumenGentium (.sectionRef "20")]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .acts15ApostlesAndElders =>
    { label := "Acts 15:6, 22–23; 16:4 — the apostles and elders came together"
    , kind := .textual
    , source :=
        { primary :=
            .scripture
              [ { ref := .verse ⟨.acts, 15, 6⟩ }, { ref := .range ⟨.acts, 15, 22, 15, 23⟩ }
              , { ref := .verse ⟨.acts, 16, 4⟩ } ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .acts1_20BishoprickLetAnotherTake =>
    { label := "Acts 1:20 — let another man take his office"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.acts, 1, 20⟩ }]
        , supporting := [.work calvinActs1 (.page 65)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .timothy2_2CommitToFaithfulMen =>
    { label :=
        "2 Timothy 2:2 — entrust these to faithful men who will be able to teach " ++
        "others also"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.secondTimothy, 2, 2⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .clement42_44SuccessorsAppointed =>
    { label :=
        "1 Clement 42, 44 — the apostles appointed bishops and deacons, and gave " ++
        "instructions that other approved men should succeed them"
    , kind := .historical
    , source :=
        { primary := .work clementCorinthians (.sectionRef "42, 44")
        , supporting := [.work lumenGentium (.sectionRef "20")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .perspicuityIsLimitedToSalvationEssentials =>
    { label :=
        "Perspicuity is claimed only for what is necessary for salvation, not " ++
        "for all of scripture alike"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "I.7")
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }

end TestimonyArguments.SolaScriptura
