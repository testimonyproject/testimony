# Which text a claim rests on (design)

> **A design note, with its first phase built.** It scopes checking claims against the text:
> making the library say, for every claim that rests on the wording of a verse, which text it
> read, where the manuscripts differ, and how secure the reading is. The first phase, variation
> units and the rating ceiling, is in the library ([What is built](#what-is-built)); the rest
> are filed as issues that anyone can take.

A Christian reading the King James Version finds at 1 John 5:7 what looks like the plainest
statement of the Trinity in the New Testament: three witnesses in heaven, the Father, the Word
and the Holy Spirit, "and these three are one". A Christian reading a modern translation finds
no such sentence. The verse is there, numbered 7, but it says only that three testify, and the
heavenly witnesses are gone. Neither translator made a mistake. They translated different
Greek texts. The words about the Father, the Word and the Spirit, called the Comma Johanneum,
stand in Latin manuscripts from the fourth century on and in only a handful of late Greek ones.
Erasmus left them out of his first two editions of the Greek New Testament, in 1516 and 1519,
and put them into the third, in 1522. From his text they passed into the Textus Receptus, the
"received text" the KJV translated.

So "1 John 5:7 says that these three are one" is true of one text and false of another. The
library already checks what follows from a claim like that. It does not yet check which text
the claim is true of. This page sets out how it would.

The library quotes the King James Version only where a scholar it cites quotes it and reasons
from it, and then answers from the Greek and from the passage around it, or from scholars who
rebut the reading from Scripture. Where this page describes what the Textus Receptus says, it
describes it, or gives the Greek.

## What the library holds now

Three pieces are in place.

- **The Greek text as data.** The SBL Greek New Testament, word by word with MACULA Greek's
  analysis, is read when the library is built, and a claim about what a verse contains can be
  checked against it ([The Greek text as data](./corpus.md)). It holds one edition, and that
  page says so: "A dispute that turns on a variant must name it and cite an apparatus."
- **A citation can name its text-form.** A citation of Scripture may say which text it means,
  the Masoretic Hebrew, the Septuagint, Nestle–Aland and a few more (`ScriptureCitation`,
  `TextualTradition`). The Isaiah 7:14 argument uses it to keep the Greek παρθένος, "virgin",
  apart from the Hebrew עַלְמָה, "young woman". A work can also be cited at its apparatus,
  the notes under the text that record where manuscripts differ (`Locus.apparatus`).
- **A premise can be marked textual.** "What a text says: wording, variants, attestation" is a
  kind of premise (`PremiseKind.textual`).

Before the first phase, nothing checked any of it. A textual premise could cite a verse in no
named text, and most did. A claim could rest on a verse whose wording the manuscripts dispute and
still be rated `consensus`, the library's highest rating, meaning "accepted across traditions,
including by those with no stake in it". In the Trinity argument, 26 of the 29 claims about what
a text says were cited this way, from Scripture alone, in no named text, at `consensus`.

## What is built

The first phase is in the library.

- **Places where the copies differ, as data.** A variation unit (`Testimony.VariationUnit`)
  records where it is, down to the word where the Greek corpus holds the book, what kind of
  difference it is, its readings with the editions that print them, and every cited judgement
  on them, each saying which of the three questions below it answers. Seven are written, in
  `Testimony.Variants.Units`: Mark 16:9–20, John 7:53–8:11, 1 John 5:7–8, Matthew 19:17a,
  Matthew 28:19b, Romans 9:5 and Hebrews 1:8b. Each hears a cited reader on both sides of what
  the author wrote, and `#check_variation_units` fails the build on one that does not.
- **A citation says which reading it takes.** A citation of Scripture can name its edition, the
  question it needs answered, and the reading it takes at each unit (`ScriptureCitation`), and
  the page shows the reading beside the verse.
- **The ceiling, checked.** `#check_readings` (`Testimony.Checks.Readings`) fails the build on
  a claim whose words lie inside a unit and which does not say which reading it takes there, on
  a reading the unit lacks, on a reading taken with no question named, and on a claim rated
  above the reading it rests on. It runs over every argument, and its pinned report counts how
  many claims citing Scripture name the edition they read, so that the count shows how far the
  next step has come.
- **The committee's grades.** Bruce Metzger's *Textual Commentary*, in the corrected edition of
  1975, is cited at six of the seven units, with the committee's letter where he prints one
  (`UbsGrade`): {A} for leaving out the heavenly witnesses, {B} for "why do you ask me about
  what is good" in Matthew 19:17, and {C} for "your kingdom" in Hebrews 1:8. The committee gave
  no letter to the two long passages, which it judged no part of Mark or John and printed in
  double brackets, nor to the punctuation of Romans 9:5, where its majority chose the full stop
  and a minority the comma. Metzger has no note on Matthew 28:19. A reading the committee
  graded {C} or {D} is rated no higher than `disputed` (`VariationUnit.rating`).

The ceiling lowered four ratings from `consensus` to `disputed`, and moved no verdict. In the
Trinity argument, Romans 9:5 (`godOverAll`) takes the comma, which Hort answers with a full stop;
Hebrews 1:8 (`throneOGod`) takes "your kingdom", which Westcott answers with "his kingdom" and
"God is Thy throne"; and Matthew 28:19 (`oneNameOfThree`) takes the threefold name, which
Conybeare answered with the shorter form Eusebius quotes. In sola fide, the claim that Christ
commands baptism (`baptismCommandedByChrist`) rests on the same words of Matthew 28:19. The claim
on Matthew 19:17 (`matthew19_17KeepTheCommandments`) now cites the half of the verse it rests
on, 19:17b, which lies outside the unit, and keeps its rating. Metzger's grades moved no rating
further: the one {C}, on Hebrews 1:8, caps a reading that Westcott's dissent had already capped.
No claim in any argument rests on the longer ending of Mark, the woman taken in adultery or the
heavenly witnesses.

## Three questions a reader asks of a verse

A reader who hears that "the best manuscripts" lack a verse is usually being told one of three
different things, and the library must keep them apart.

1. **What do the copies say?** Codex Sinaiticus and Codex Vaticanus, the two oldest complete
   copies of the New Testament, both from the fourth century, end Mark's Gospel at 16:8: "and
   they said nothing to anyone, for they were afraid." That is a fact about two manuscripts,
   and it can be checked against a transcription of them. Call it **attestation**.
2. **What did the author write?** Whether Mark wrote 16:9–20 is a judgement, drawn from the
   attestation by a textual critic, the scholar who compares copies to recover the earliest
   wording. Most critical editors judge that he did not; Nestle–Aland prints the verses in
   double brackets, its mark for a passage it judges later but too old and too widely read to
   leave out. Others, among them those who hold to the Byzantine text that most later
   manuscripts share, judge that he did. Call it **originality**. It is rated like any other
   reading, by who holds it and who dissents.
3. **What does the church receive as Scripture?** The Council of Trent received the books
   "entire with all their parts, as they have been used to be read in the Catholic Church, and
   as they are contained in the old Latin vulgate edition" (Session IV, 1546). On that ground a
   Catholic reader holds Mark 16:9–20 to be Scripture whoever wrote it. Many Protestants hold
   the same, on other grounds. Call it **reception**. It is a claim about a tradition, held by
   that tradition, and the library already attributes such claims.

The library's rule against collapsing relation types applies here as it does to quotation and
allusion. A claim that rests on one of the three must say which. "Jesus says in Mark 16:16 that
whoever believes and is baptised will be saved" needs the verse to be original to Mark.
"Scripture, as Rome receives it, says so" needs only reception. Both claims can be argued, and
the dispute between a Catholic and a critic who denies Mark wrote the verse turns on which one
the argument needs. Kept apart, the build can show exactly where the two part.

## What a claim would record

Every claim that rests on the wording of a verse would carry, beside its citation:

- **the text it reads**: an edition (the SBLGNT, Nestle–Aland 28, the Tyndale House Greek New
  Testament, Robinson and Pierpont's Byzantine text, Scrivener's Textus Receptus of 1894, the
  Westminster Leningrad Codex, a scroll from Qumran);
- **the places of variation it depends on**, each with the reading it takes. Textual critics
  call such a place a **variation unit**: a stretch of text where the copies differ, with the
  readings found there;
- **which of the three questions it needs answered**: attestation, originality or reception.

A variation unit is data the library writes once and every argument shares, as it shares its
works and passages. Each would hold:

- where it is, down to the word, so that the build can tell whether a claim's words lie inside
  it;
- what kind of difference it is: words added, words left out, one word for another, words in
  another order, punctuation, or a reading no manuscript has, conjectured by a scholar;
- its readings, each with the editions that print it and the manuscripts cited for it;
- the judgement of each cited critic on which reading is original, rated by the library's rule.

Punctuation earns its own kind because it is the editors', not the copyists'. The earliest
manuscripts have almost none. Romans 9:5 is the classic case. With a comma after "according to
the flesh", Paul calls Christ God over all, blessed forever. With a full stop, the Christ comes
from Israel according to the flesh, and the verse ends in a blessing of the God who is over all.
The letters are the same, and Westcott and Hort, who agree on almost every reading, part over
the comma in one signed note. The Trinity argument cites the first reading (`godOverAll`). It
now names the punctuation unit and takes the comma, and the ceiling below rates it `disputed`,
because Hort, a cited reader, prefers the full stop.

## How a reading's certainty enters the ratings

The library rates a claim by one rule: it is `disputed` when a cited reader grants its grounds
and denies it, and a rating above `disputed` must survive the strongest known dissent, encoded
with its own grounds ([Computed ratings](./computed-ratings.md)). Textual judgements are
rated by the same rule, with no scale of their own. A critic is a reader. Bruce Metzger's
*Textual Commentary on the Greek New Testament*, which gives the reasons of the committee
behind the United Bible Societies' edition, is a reader's argument like any commentary's.

From there one new rule carries the certainty of the text into the argument:

> **A claim cannot be rated above the readings it rests on.** A claim that depends on a
> variation unit is rated no higher than the library's rating of the reading it takes there.

So a claim resting on Mark 16:16 for what Mark wrote can be no firmer than the judgement that
Mark wrote 16:16. The dispute's weighing already takes each position's weakest link, so the
rule moves weight exactly where the text is uncertain, and nowhere else.

The United Bible Societies' edition grades its decisions with letters, from {A}, "the text is
certain", to {D}, the committee "had great difficulty" deciding. A letter is the committee's
own confidence, and the library cites it as such, beside the rating, never in place of it.
One step further is the library's own proposal, and is marked as one: a reading graded {C} or
{D} is rated no higher than `disputed`, because the committee that chose it is itself a cited
reader in doubt.

### The rule runs both ways

The rule does not only lower ratings. It also shows when a variant does not matter, which is the
far more common finding, and a reader deserves to see it.

Sola fide cites Matthew 19:17. The manuscripts differ in the verse's first half. In the
Byzantine text Jesus asks why the young man calls Him good, and says that no one is good but
one, God (Τί με λέγεις ἀγαθόν; Οὐδεὶς ἀγαθός, εἰ μὴ εἷς, ὁ θεός, "Why do you call me good? No one is
good except God alone"), as in Mark 10:18 and Luke 18:19. In the critical text He asks why the man
asks Him about what is good, and says that there is one who is good (Τί με ἐρωτᾷς περὶ τοῦ ἀγαθοῦ;
εἷς ἐστιν ὁ ἀγαθός, "Why do you ask me about what is good? There is only one who is good"). The
argument's claim rests on the second half, "If you would enter life, keep the commandments"
(`matthew19_17KeepTheCommandments`), which every edition prints alike. Located to the word, it cites
19:17b, and lies outside the unit at 19:17a.

The Trinity argument cites John 8:17–18, "the testimony of two people is true"
(`twoWitnesses`). The passage about the woman taken in adultery, John 7:53–8:11, is missing
from the oldest copies of John, and some later ones place it elsewhere, one family of
manuscripts after Luke 21:38. Verses 17 and 18 lie outside it, and nothing in the argument
depends on it. That too is a finding.

Hebrews 1:8 shows why position alone is not enough. The Trinity argument quotes "Your throne,
O God, is forever and ever" (`throneOGod`), and those words are not in dispute. The next words
are. Most manuscripts read "the scepter of *your* kingdom"; the oldest collection of Paul's
letters, a papyrus from about AD 200, and the two great fourth-century codices read "the scepter
of *his* kingdom". B. F. Westcott takes the verse as "God is Thy throne", a rendering he says is
"required if we adopt the reading αὐτοῦ [his] for σου [your]" (*The Epistle to the Hebrews*, 1892,
pp. 25–26). A variant outside a
claim's words can bear on how they are read. So the dependence of a claim on a unit is computed
where the words overlap, and declared, with the reader who draws it, where a reader holds that
a reading nearby bears on the claim. A declared dependence is a step like any other: it cites
who draws it, or it is marked as the library's own.

### When the standard decides

The library reports every rating under three standards of evidence, and the text-critical cases
show why it must. Some who defend the Textus Receptus, often called the Confessional Text
position, hold it as the text God preserved, on the ground of the Westminster Confession: the
Scriptures, "by his singular care and providence kept pure in all ages, are therefore
authentical" (I.viii). That is an argument from a confession. Under the tradition standard it is
heard, and a reading such as the Comma Johanneum, defended on it, keeps a credible dissent
behind it. Under the evidence standard, which admits only texts and argued scholarship, it is
not heard on that ground. If the rating of the Comma comes out different under the two
standards, it turns on the authority question, and the page will say so in those words.

## What the build would check

Each check fails the build, as the library's other checks do, with a report pinned in the
argument's checks module.

1. **Every textual claim names its text.** A claim of the textual kind, or any claim that quotes
   the words of a verse, names the edition it reads. A claim that names none fails, and so
   does one that names an edition the library holds no data or citation for.
2. **No silent dependence.** Where the editions the library holds differ inside a claim's words,
   the claim must name the unit and the reading it takes. This is computed from the data, not
   declared.
3. **The ceiling.** No claim is rated above any reading it depends on.
4. **Every judgement has a reader.** Each unit's preferred reading cites the critic or edition
   that prefers it, or is marked as the library's own. This is the rule that
   `#check_readers` brings to every step of an argument
   ([#307](https://github.com/testimonyproject/testimony/pull/307)), carried to the text. A
   reading cited to the edition's editors alone is cited to them, which is a reader. A reading
   preferred by nobody but the library says so.
5. **The steelman.** A textual judgement rated above `disputed` has its strongest known dissent
   encoded with its grounds, as every rating above `disputed` must. For Mark 16:9–20 the
   dissent is the Byzantine-priority case, which Maurice Robinson makes; for the Comma it is the
   Confessional Text case.
6. **Quotations match their text.** A claim that quotes Greek or Hebrew quotes it as the named
   edition prints it, word for word. This is the "misquotation" row of the fallacy catalogue,
   which waits on a corpus ([Checking an argument for fallacies](./fallacies.md#the-catalogue)).
7. **Attestation matches its witnesses.** A claim that a manuscript has or lacks a reading is
   checked against a transcription of that manuscript, where the library holds one under an open
   licence. Where it holds none, the claim is cited to whoever reports it, as now.

What the build would not check is which reading is original. That stays a judgement, rated by
who holds it. The build checks that the judgement is named, attributed, rated honestly and
carried into every claim that needs it.

### Every verdict, under every text

Once each claim records its readings, a dispute can be heard under each text-form, as it is
heard now under each standard. A claim that depends on a reading a text lacks is dropped from
the package under that text, as a named difference (`Line.onGrounds`), never by retyping the
premise list. The page then says, for each argument: under the critical text the verdict is
this; under the Byzantine text, this; under the Textus Receptus, this. A verdict that is the same
under every text, which will be most of them, the page states once, and says that the text does
not decide it. A verdict that moves with the text is the finding a reader most needs.

## How it meets the fallacy checks

The fallacy checks work one move at a time ([Checking an argument for
fallacies](./fallacies.md)). Several of them meet textual arguments directly.

- **Argument from silence.** "Mark 16:9–20 is not in Sinaiticus or Vaticanus, so Mark did not
  write it" argues from what two copies do not contain. The check asks for its expectation: had
  Mark written the verses, the oldest copies would have them. The expectation is a premise a
  reader can weigh, and critics argue it. The Comma's best-known argument from silence is a
  strong one. The Greek writers of the fourth century, arguing against Arius that the Son is one
  with the Father, never quote "these three are one". Had their texts held it, they would have
  used it. The check would let that argument through with its expectation stated, and stop one
  that leaves it out. Today the check sees only silences of the form "the passage does not say
  this". This work would extend it to silences of witnesses: a manuscript, a version or a church
  father who does not have a reading.
- **Equivocation.** "Scripture", "the text" and "the original" each mean several things in
  these debates. Eldon Epp set out how many in "The Multivalence of the Term 'Original Text' in
  New Testament Textual Criticism" (*Harvard Theological Review*, 1999). A move whose premise
  speaks of the text as printed in one edition and whose conclusion speaks of what the apostle
  wrote has changed the sense of "the text" mid-argument. With every textual claim naming its
  text-form and its question, the equivocation check can see it.
- **Begging the question.** "The Textus Receptus is the preserved text, because God preserved
  his word, and his preserved word is the Textus Receptus" has its conclusion among its
  premises. The begging check finds such a move as it finds any other.
- **Double standard.** The Chicago Statement on Biblical Inerrancy (1978) holds that
  "inspiration, strictly speaking, applies only to the autographic text of Scripture" (Article
  X). A party that professes that rule and rests a claim on a reading its own critical text
  judges later than the autograph breaks its own rule. The library's check that each party keeps
  the rule it professes (`ArgumentPackage.heldTo`) would catch it, once the rule and the reading
  are both data ([How each side says we know](./epistemology.md)).
- **Cherry-picking.** A move that cites a verse and passes over a variation unit inside the
  words it cites is caught by check 2 above.

## The rival positions

The library never encodes a reading without a rival. Text-critical method has several, and each
would be an epistemology in the library's sense, with its holders cited:

- **Reasoned eclecticism**, weighing manuscripts and the habits of copyists case by case: Metzger,
  the Nestle–Aland and UBS committees, Michael Holmes's SBLGNT.
- **The Coherence-Based Genealogical Method**, the computer-assisted method behind the
  *Editio Critica Maior*, the large critical edition from Münster, introduced by Tommy Wasserman
  and Peter Gurry, *A New Approach to Textual Criticism* (2017).
- **Byzantine priority**, holding that the text most manuscripts share is closest to the
  original: Maurice Robinson and William Pierpont, *The New Testament in the Original Greek:
  Byzantine Textform* (2005).
- **The Confessional Text**, holding the Textus Receptus as the text providentially kept pure,
  on Westminster I.viii.
- **Rome's position**, which declared the Vulgate "authentic" at Trent, and since Pius XII's
  *Divino afflante Spiritu* (1943) has encouraged translation from the original languages and
  their critical texts.
- **The sceptical reading**, which doubts that the earliest text can be recovered, or that there
  was a single original to recover: Bart Ehrman, *The Orthodox Corruption of Scripture* (1993),
  on changes copyists made for doctrine's sake, and David Parker, *The Living Text of the
  Gospels* (1997).

The sceptical reading is the rival a Christian argument most needs heard. If it holds at a
place where an argument rests, the argument is weaker there, and the page says so. If it does
not, the page shows where it fails, at a checked step, with the reader who answers it.

## The texts and their licences

The library takes in only openly licensed data, and records each source's licence and checksum
beside the data, as it does for the SBLGNT now. What is under copyright can still be cited, at a
locus, as any book is. It cannot be imported.

Each licence below was read from the source's own licence file or page on 2026-11-18.

| Source | What it holds | Licence | Use here |
|---|---|---|---|
| [SBLGNT][sblgnt] text and apparatus | Holmes's critical text; an apparatus of *editions* (Westcott–Hort, Tregelles, the NIV's text, Robinson–Pierpont, NA28) | CC BY 4.0 | Already the corpus; its apparatus can be imported |
| [STEPBible TAGNT][tagnt] | Every word of NA27/28, the SBLGNT, the Tyndale House GNT, the Byzantine text, Scrivener's TR, Westcott–Hort and Tregelles, each marked with the editions that have it | CC BY 4.0 (Tyndale House, credit "STEP Bible") | The main source for where the editions differ |
| [Robinson–Pierpont][byz] | The Byzantine text, parsed, with an apparatus of Byzantine variants | CC0 (public domain) | Importable |
| [Scrivener 1894][tr], [Westcott–Hort 1881][wh] | The Textus Receptus; Westcott and Hort's text, parsed | Public domain | Importable |
| [CNTR transcriptions][cntr] | Transcriptions of Greek manuscripts up to AD 400 | CC BY-SA 4.0 | Importable, with its ShareAlike condition kept on the imported files |
| CNTR collation and apparatus | Its own collation of those manuscripts | All rights reserved | Cited, not imported |
| [IGNTP transcriptions][igntp] | Transcriptions of John and Paul; an apparatus of the majuscules of John | Mixed: the files checked are CC BY-NC-SA 2.5 or CC BY-NC 2.5 | Only after each file's own licence is read; the non-commercial ones conflict with the library's licence |
| Tyndale House GNT | The text and its apparatus | No open licence found | Cited; its readings reach the build through TAGNT |
| INTF *Editio Critica Maior*, CBGM data | The Münster apparatus and genealogy of witnesses | No open licence found | Cited, not imported |
| NA28, UBS5 apparatus and ratings | The standard apparatus and its {A}–{D} letters | Under copyright (German Bible Society); no open licence found | Cited at a locus, as now |
| [OSHB][oshb] | The Westminster Leningrad Codex, with lemmas and morphology | Text public domain; analysis CC BY 4.0 | Importable (#4) |
| [MACULA Hebrew][machebrew] | Syntax and analysis of the Hebrew Bible | CC BY 4.0, but its word senses are the United Bible Societies', "used with permission" | Importable, without the word senses, as with MACULA Greek |
| [ETCBC BHSA][bhsa], [ETCBC dss][dss] | The BHS text with annotation; the Qumran scrolls, transcribed | CC BY-NC 4.0 | Non-commercial: cited, or imported only if the library accepts that condition |
| [Swete's Septuagint][swete] | Swete, *The Old Testament in Greek*, as TEI text | CC BY-SA 4.0 | Importable, with ShareAlike |
| CATSS LXX morphology, Rahlfs 1935 | The usual digital Septuagint | Signed user agreement required | Not importable |
| BHS, BHQ apparatus | The standard Hebrew apparatus | Under copyright | Cited at a locus |

[sblgnt]: https://github.com/LogosBible/SBLGNT
[tagnt]: https://github.com/STEPBible/STEPBible-Data
[byz]: https://github.com/byztxt/byzantine-majority-text
[tr]: https://github.com/byztxt/greektext-scrivener
[wh]: https://github.com/byztxt/greektext-westcott-hort
[cntr]: https://github.com/Center-for-New-Testament-Restoration/transcriptions
[igntp]: https://www.birmingham.ac.uk/news-archive/2017/igntp-releases-open-data
[oshb]: https://github.com/openscriptures/morphhb
[machebrew]: https://github.com/Clear-Bible/macula-hebrew
[bhsa]: https://github.com/ETCBC/bhsa
[dss]: https://github.com/ETCBC/dss
[swete]: https://github.com/OpenGreekAndLatin/First1KGreek

Three findings shape the plan. First, the edition-level data is open and good: TAGNT alone says,
word by word, which of seven editions print each word, and that is enough for the build to find
every place where the editions differ. Second, the manuscript-level data is open only in part.
The early papyri and majuscules are transcribed under ShareAlike terms, but no open collation
or apparatus of all the manuscripts exists. Third, the Hebrew side's best annotated data, and
the Qumran scrolls, are licensed for non-commercial use only, which the library's own licence
(Apache 2.0 for code, CC BY 4.0 for prose) does not allow it to pass on. Whether to accept that
condition for a separate data package is a decision for the project, and phase 5 asks it.

The two apparatuses most scholars cite, Nestle–Aland's and the United Bible Societies', belong
to the German Bible Society and are not openly licensed. They stay citable at a locus
(`Locus.apparatus`), as the library cites them now, and nothing of them is imported. The same
holds for the apparatus of *Biblia Hebraica Stuttgartensia*. So the open data tells the build
where the *editions* differ, and which words the open transcriptions of early manuscripts have.
It does not tell the build every place the manuscripts differ. A check that finds no variation
reports that the editions it holds agree there, never that the manuscripts do. Saying more would
be an argument from silence, with an expectation, "the open data records every variant", that is
false.

## The plan

Each phase is an issue, written so that someone else can take it. Each delivers something a
reader can see on a page, and the phases after the first can be taken in any order the data
allows.

1. **Variation units as data, and the ceiling.** Text-forms, variation units, readings and
   judgements as Lean data; citations that name their text, their units and their question; the
   ceiling rule and the readers rule over units, as build checks. The first units are written by
   hand, each with cited judgements on both sides: Mark 16:9–20, John 7:53–8:11, the Comma
   Johanneum, Matthew 28:19 (where Eusebius quotes a shorter form, and F. C. Conybeare argued in
   1901 that it was the original, though every Greek manuscript and version that has the verse
   reads the threefold name), Romans 9:5, Hebrews 1:8 and Matthew 19:17. Every textual claim the
   arguments already make is then given its text, and any rating the ceiling moves is reported.
   Built ([What is built](#what-is-built)), except that naming every claim's edition is left to
   one pull request per argument, after which an unnamed edition fails the build. Metzger's
   pages and his committee's grades are cited, and a reading graded {C} or {D} is rated no
   higher than `disputed`, as the library's own proposal.
2. **Where the editions differ, from the data.** Import the edition-agreement data the licences
   allow for the books the library reads, and compute every place where the editions differ.
   Check 2, no silent dependence, runs over every argument. The misquotation check runs over
   every quoted word. The Vulgate joins as an edition, from a public-domain text, so that an
   argument that the Latin departs from the Greek or the Hebrew is checked against both.
3. **What the early copies have.** Import open transcriptions of early manuscripts, so that a
   claim of attestation ("Vaticanus ends Mark at 16:8") is checked against the manuscript. The
   argument-from-silence check learns the silence of a witness.
4. **Every verdict under every text.** Hear each dispute under each text-form, and generate, on
   each argument's page, a section that tells a lay reader which text the argument rests on,
   where the manuscripts differ, and whether the verdict moves.
5. **The Hebrew Bible, the Septuagint and Qumran.** Import the Westminster Leningrad Codex and its
   open analysis ([#4](https://github.com/testimonyproject/testimony/issues/4)), the Septuagint
   as far as licences allow, and the biblical scrolls from Qumran; write the units where the
   Masoretic Text, the Septuagint and the scrolls differ, beginning with those the arguments
   use, Isaiah 7:14, and the next they will need, Psalm 22:16 and Deuteronomy 32:8. The
   scrolls' open data is licensed for non-commercial use only, so the phase begins by deciding
   whether to import it or cite it.
6. **The rival methods as epistemologies.** Encode the positions above, each with its holders
   and the rule it professes, and check that each party keeps its own rule.

## What this does not claim

- It does not decide which reading is original. That stays a rated judgement, attributed to
  those who make it.
- It does not say that a verse is or is not Scripture. Reception is a tradition's claim, and
  the library attributes it.
- It does not treat the absence of a variant from the open data as the absence of a variant.
- It does not make the truth of a premise checkable. It makes checkable what the text contains,
  which text a claim read, and whether the claim's rating honours how secure that text is.
