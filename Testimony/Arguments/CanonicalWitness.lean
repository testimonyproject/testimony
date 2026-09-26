import Testimony.Arguments.CanonicalWitness.Atoms
import Testimony.Arguments.CanonicalWitness.Sources
import Testimony.Arguments.CanonicalWitness.Lines
import Testimony.Arguments.CanonicalWitness.Packages
import Testimony.Arguments.CanonicalWitness.Results

/-!
# Arguments.CanonicalWitness — faith alone, from the texts every party accepts

`Testimony.Arguments.SolaFide` argues faith alone through the disputes that
surround it: what ἔργα νόμου denotes, whether πίστις Χριστοῦ is objective, what
σῴζω means at Luke 7:50. This argument asks a narrower question, and the
disputes do not bury it: **granting only the texts that Rome and the Reformers
both hold as scripture, what does each corpus say about how a person is
justified, and does faith alone follow?**

**Every text is a premise cited to scripture alone.** Romans, Galatians,
Ephesians and Titus are read together as Paul, whoever wrote the last two:
every party receives them as canon, and the question is what the canon says.
Hebrews is read as its own corpus, because it is anonymous. Trent grants all of
them; its Decree on Justification quotes most. So the texts are `consensus`,
and nothing turns on them.

**The readings are where the argument is made.** Each corpus is a line whose
single step reads its texts, and that step is cited and rated as a reading.
Texts do not entail conclusions; readings do. And each corpus is made to
deliver only what its own texts say. Paul is read twice, because he says
different things in different places: on works, and on faith. *Faith alone* is
split into three parts:

- that faith is **necessary** — Paul ("not justified by works of the law except
  through faith", Galatians 2:16; "the righteous shall live by faith", 3:11),
  Hebrews ("without faith it is impossible to please God") and John ("whoever
  does not believe is condemned already");
- that faith is **sufficient** — Paul ("to the one who does not work but
  believes", Romans 4:5), John, Peter and Jesus' words in Luke;
- that works are **not the ground** — Paul (Romans 3:28, Ephesians 2:9, Titus
  3:5), Peter at the Jerusalem council, and Jesus' parable of the Pharisee and
  the tax collector.

No corpus carries more than its share, and no corpus is load-bearing: take any
one reading away and the conclusion still follows. Two corpora are enough —
Hebrews and Jesus' words. What an opponent must reject instead is computed,
not chosen: the **opponent's burden** (`canonical_burden`) lists every minimal
set of readings whose rejection overturns the case, and proves there is no
other way. There are exactly three, one for each part. To deny that works are
not the ground, an opponent must reject three readings: Paul's on works,
Peter's and Jesus'. To deny that faith is necessary, three: Paul's on faith,
Hebrews' and John's — and Trent does not, since its chapter 8 reads the
Apostle's "justified by faith" as faith "the beginning of human salvation …
without which it is impossible to please God". To deny that faith suffices,
four: Paul's on faith, John's, Peter's and Jesus'. That is the way Trent takes.
Hebrews' reading is rated `consensus`, and every other reading `disputed`.

**Paul on faith is stated on its own** (`paul_on_faith_establishes`): faith is
necessary and sufficient, from Romans 4:4–5 and Galatians 2:16 and 3:11. It
stands with James — every text of James, read with 2:14–17 as about faith
without works, and without the contested demonstrative sense of "justified"
(`paul_on_faith_stands_with_james`). And the harmony is shown to be a reading,
not a given: read James's "that faith" (2:14) and "not by faith alone" (2:24)
of faith as such, as Trent does, and the two cannot both be held
(`james_against_sufficiency_contradicts_paul`).

The burden is how this library lets several witnesses matter without counting
them. Three corpora saying works are not the ground is not a score of three; it
is three readings an opponent has to break, each on its own texts.

**James is coherence, not a witness to faith alone.** James 2 does not argue
against works; it argues against a faith without them — the demons' assent of
2:19, the faith that says "go in peace" and gives nothing (2:14–17). Read with
the distinction between justification and sanctification, James 2:21–24 uses
"justified" demonstratively: Abraham's offering of Isaac *showed* the faith
already counted as righteousness in Genesis 15:6, which James himself quotes.
So James adds what the other corpora do not say — that works are the fruit of
saving faith — and with it the conclusion becomes the Reformed formula of the
Westminster Confession (XI.2): justification by faith alone, by a faith that is
never alone. Every text of James is a premise, 2:24 included. Jude, which does
not address the question, is granted as consistent with the rest and nothing
more.

**What the early church said.** The readings are cited to the Reformers and to
modern exegetes, and also to fathers whom Rome itself venerates and cites — to
show that the claims Trent condemns were not coined in the sixteenth century.
Clement of Rome: "not justified by ourselves … nor by works which we have
wrought in holiness of heart; but by that faith through which, from the
beginning, Almighty God has justified all men" (1 Clement 32.4). Polycarp: "by
grace you are saved, not of works" (Philippians 1). The Epistle to Diognetus,
which the Catechism cites (CCC 2271): "that the righteousness of One should
justify many transgressors" (9). Hilary of Poitiers, a Doctor of the Church:
"faith alone justifies" — *fides enim sola iustificat* (*Commentary on Matthew*
8.6). Basil the Great, another: "to be justified by faith in Christ alone"
(Homily 20, *Of Humility*).

What they show is that faith's sufficiency, and the exclusion of works as
ground, were early Christian claims. They do not show that the fathers held the
Reformers' *forensic* account of what justification is: Augustine reads
justification as a making righteous, and Trent follows him there; and
Chrysostom's seventh homily on Romans, on 3:27–28, speaks of justification by
faith without saying "faith alone". So the fathers are cited for what they say,
and the ontology is argued from Paul.

**The rival is Trent**, and it holds every one of these texts. It parts from
the canonical witness at exactly one reading: that "justified" in James 2:24 is
the *increase* of a justification already received, by works done in grace
(Session VI, ch. 10). On that reading works are part of the ground, and faith
alone fails. The `Because` result finds that one atom mechanically, and the
load-bearing result shows the Reformed formula needs it: without the
demonstrative reading of James, "faith never alone" no longer follows. The
burden with James says the same at the level of readings: rejecting James's
reading alone overturns the formula, and nothing else about faith alone
changes.

What this argument does *not* show is that the Reformed readings are right. It
shows where the disagreement is. Every text is common ground; every reading is
cited to the people who hold it; and the burden results name, corpus by corpus,
what a reader must reject to deny the conclusion.
-/
