import TestimonyArguments.SolaScriptura.Acts15

/-!
# TestimonyArguments.SolaScriptura.MosesSeat — Moses' seat, read both ways

A reader who has followed Jesus against the elders in Mark 7 meets him, a few
days before his death, saying something that sounds like the opposite. "The
scribes and the Pharisees have seated themselves in the chair of Moses;
therefore all that they tell you, do and keep, but do not do according to their
deeds; for they say things and do not do them" (Matthew 23:2–3). The "chair"
(καθέδρα), Moses' seat, is a teacher's chair. The verb for "keep" (τηρεῖτε) is
the one Mark 7:9 uses for keeping "your tradition", in the text the SBL Greek
New Testament prints; the Nestle-Aland edition prints "establish" (στήσητε)
there instead. J. W. Wenham, in his 1953 lecture on Jesus and the Old Testament,
finds the saying "even more remarkable" than Matthew 5:17–20, and comments: "To
Jesus scribal lore was valuable if linked with spiritual understanding". Jesus
upholds the teaching of men he goes on to rebuke. Both sides of the Reformation
read the saying, and they read it in opposite directions.

## The Reformed reading

The same discourse condemns a teaching of the same scribes: "Woe to you, blind
guides, who say, 'Whoever swears by the sanctuary, that is nothing; but whoever
swears by the gold of the sanctuary is obligated'" (23:16–22). So Jesus cannot
be binding his hearers to everything the scribes say. Calvin takes "Moses' seat"
to mean the law taught from it: "to sit in the chair of Moses is nothing else
than to teach, according to the Law of God, how we ought to live", and so
"Christ exhorts the people to obey the scribes, only so far as they adhere to
the pure and simple exposition of the Law". He grants that the seat "denotes, at
the same time, a lawful calling", and that the scribes were to be heard "because
they were the public teachers of the Church". What he denies is that the station
is enough. "The Papists reckon it enough, that those who issue laws should
possess the title and occupy the station". Were that so, there would be "no good
ground" for Jesus' saying in Matthew 15:9, the parallel of Mark 7, "that it is
in vain to worship God by the commandments of men". On this reading an office in
the Church is heard as far as it teaches God's word, and not for its seat alone.
The Protestant position reads Matthew 23 this way (`mosesSeatReformedLine`).

## Rome's reading

Cornelius a Lapide, the Jesuit commentator of the early seventeenth century,
reads the seat as "the honour, dignity, and authority of teaching and
commanding, which Moses had with the Jews, and to which the Scribes had
succeeded", and draws the Church's case from it: "In like manner, the chair of
S. Peter is used to signify the power and authority of teaching and ruling all
the faithful throughout the world, in which the Roman Pontiffs succeed S.
Peter". Jesus' "all things" means "all things not contrary to Moses and the
Law": the corban teaching of Mark 7 "was contrary to the Law, as Christ showed",
and was not to be followed. In everything else the scribes were to be obeyed,
even in dogmas "vain and foolish, and therefore not binding", which could "yet
serve for the merit of blind and simple obedience, and for reverence of the
sacerdotal order". And "Christians ought to bear in mind these words of Christ
when they see certain Bishops, Pastors, and Magistrates not living in accordance
with the law of Christ". On this reading those who hold the Church's teaching
office are heeded for the seat they hold, in whatever is not contrary to God's
law, even when they live ill. Tradition III, the position resting on Vatican I,
reads Matthew 23 this way (`mosesSeatRomanLine`).

The claim is one of authority, not of infallibility, which is the power of a
teaching that cannot err. Lapide goes on to say that the pope "cannot err" when
he defines the faith, but Moses' seat cannot carry that: the scribes who sat in
it taught things "contrary to the Law". The library does not draw it from this
text.

## What the texts settle, and what they do not

The two readers grant each other's texts. Lapide calls the scribes of 23:16
"rightly called by Christ blind guides", and grants that Jesus condemned the
corban teaching; Calvin grants that Jesus commands the scribes to be heard. What
they part over is the measure. For Calvin an office binds as far as it teaches
the law, and for Lapide in everything not contrary to it. So each reading's step
is rated `disputed`, a rating given when a cited reader grants a step's texts
and denies its conclusion. The two readings cannot be held together
(`moses_seat_readings_cannot_be_held_together`). Grant Mark 7, the principle it
delivers that God's word judges human tradition, and Matthew 23:2–3 and
23:16–22, without either step: whether the teaching office is heeded for its
seat neither follows nor fails (`mark7_and_moses_seat_leave_the_office_open`).
So each reading holds Jesus' two sayings together, in its own way, and the
texts alone do not choose between them.

Nor does Rome's reading undo the case for sola scriptura from Mark 7. That case
concludes that Scripture is the sole infallible rule, and Rome's reading of
Moses' seat is about authority, not infallibility. A reader can grant both
(`romes_reading_of_moses_seat_can_be_held_with_mark7s_case`).

These lines join the Protestant and Vatican I positions, and not the dispute
over Mark 7. None of the parties to that dispute says anything about the
teaching office, so neither reading of Matthew 23 would meet a party there.
-/

namespace TestimonyArguments.SolaScriptura

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### The two readings -/

/-- **Moses' seat, the Reformed reading**: Matthew 23:2–3, the "blind guides" of
23:16–22 and Mark 7, and the step from them to the teaching office: an office in
the Church is heard as far as it teaches God's word, and not for its seat
alone. -/
@[solaScripturaDefs]
def mosesSeatReformed : ArgumentPackage Claim :=
  mosesSeatReformedLine.asPackage cite
    "the teaching office is not heeded for its seat alone"

/-- **Moses' seat, Rome's reading**: Matthew 23:2–3, and the step from it to the
teaching office: those who hold it are heeded for the seat they hold, in
whatever is not contrary to God's law. -/
@[solaScripturaDefs]
def mosesSeatRoman : ArgumentPackage Claim :=
  mosesSeatRomanLine.asPackage cite "the teaching office is heeded for its seat"

/-- Mark 7 and the principle it delivers, with every text either reading of
Moses' seat reads: Matthew 23:2–3 and 23:16–22. No step from Matthew 23. -/
@[solaScripturaDefs]
def mosesSeatTexts : List (Formula Claim) :=
  mark7Principle.premises ++ [p .matthew23_2_3MosesSeat, p .matthew23_16_22BlindGuides]

/-! ### Readings, written down -/

/-- The Reformed world, on Moses' seat: every text holds, no commandment of men
is bound as God's word, and those who hold the teaching office are heard as far
as they teach God's word, not for their seat alone. -/
def reformedOnTheSeatReading : Valuation Claim := fun a =>
  match a with
  | .mensCommandmentBindsAsGodsWord => False
  | .teachingOfficeHeardByItsSeat => False
  | _ => True

/-! ### What follows -/

/-- **The Reformed reading of Moses' seat holds, given its step.** From Matthew
23:2–3, 23:16–22 and Mark 7, the teaching office in the Church is heard as far as
it teaches God's word, and not for its seat alone. The step is rated `disputed`:
Cornelius a Lapide grants the texts and holds that the scribes were to be obeyed
in "all things not contrary to Moses and the Law".

What this does not claim: that the office has no authority. Calvin, who holds
this reading, says Christ "commands that the scribes should be heard, because
they were the public teachers of the Church". -/
theorem mosesSeatReformed_establishes : Establishes mosesSeatReformed := by
  establish [solaScripturaDefs]

#print axioms mosesSeatReformed_establishes

/-- The Reformed reading of Moses' seat can be held without contradiction. -/
theorem mosesSeatReformed_is_satisfiable : Satisfiable mosesSeatReformed.premises := by
  satisfied_by reformedOnTheSeatReading [solaScripturaDefs]

/-- **Rome's reading of Moses' seat holds, given its step.** From Matthew
23:2–3, those who hold the Church's teaching office are heeded for the seat they
hold, in whatever is not contrary to God's law, even when they live ill. The step
is rated `disputed`: Calvin grants the text and holds that the scribes were to be
obeyed "only so far as they adhere to the pure and simple exposition of the
Law".

What this does not claim: that the office cannot err. Its own reader, Lapide,
says the scribes in Moses' seat taught things "contrary to the Law". -/
theorem mosesSeatRoman_establishes : Establishes mosesSeatRoman := by
  establish [solaScripturaDefs]

#print axioms mosesSeatRoman_establishes

/-- Rome's reading of Moses' seat can be held without contradiction: Rome's
world, in which God's word judges human tradition, some unwritten tradition is
known to be apostolic, and every other claim of the argument holds, among them
that the teaching office is heeded for its seat. -/
theorem mosesSeatRoman_is_satisfiable : Satisfiable mosesSeatRoman.premises := by
  satisfied_by romeGrantsMarksPrincipleReading [solaScripturaDefs]

/-- **The two readings of Moses' seat cannot be held together.** One concludes
that the teaching office is heard only as far as it teaches God's word, the
other that it is heeded for its seat in whatever is not contrary to that word.
Both grant Matthew 23:2–3, so what they part over is the two steps, each rated
`disputed`.

What this does not claim: that either reading is wrong. It shows only that a
reader must choose between them. -/
@[headline]
theorem moses_seat_readings_cannot_be_held_together :
    ¬ Satisfiable (mosesSeatReformed.premises ++ mosesSeatRoman.premises) :=
  not_satisfiable_of_check (by decide +kernel)

#print axioms moses_seat_readings_cannot_be_held_together

/-- **Mark 7 and Moses' seat leave the teaching office open.** Grant Mark 7, the
principle it delivers that God's word judges human tradition, and Matthew 23:2–3
and 23:16–22, without either reading's step from Matthew 23: whether the teaching
office is heeded for its seat neither follows nor fails. The Reformed reading
grants every text and the principle, and denies it; Rome's grants them all and
holds it. So each reading holds Jesus' two sayings together, and the texts by
themselves choose neither. One fact, not two: the texts establish neither
reading and block neither. -/
@[headline]
theorem mark7_and_moses_seat_leave_the_office_open :
    Independent mosesSeatTexts (p .teachingOfficeHeardByItsSeat) := by
  leaves_open reformedOnTheSeatReading romeGrantsMarksPrincipleReading
    [solaScripturaDefs]

#print axioms mark7_and_moses_seat_leave_the_office_open

/-- **Rome's reading of Moses' seat can be held with Mark 7's case for sola
scriptura.** Grant Mark 7, its principle, the premise that no unwritten tradition
can now be shown to be apostolic, and the step to the sole rule, and with them
Rome's reading of Matthew 23:2–3: nothing contradicts. The witness is a world in
which every claim of the argument holds but one, that a commandment of men may
be bound as God's word. Rome's reading claims that the teaching office is to be
heeded, not that it cannot err, so it leaves Scripture the sole infallible rule.

What this does not claim: that the Reformers accept Rome's reading. Calvin
denies it; the Protestant position holds the Reformed reading instead. -/
@[headline]
theorem romes_reading_of_moses_seat_can_be_held_with_mark7s_case :
    Satisfiable (mark7Case.premises ++ mosesSeatRoman.premises) := by
  satisfied_by marksPrincipleReading [solaScripturaDefs]

#print axioms romes_reading_of_moses_seat_can_be_held_with_mark7s_case

end TestimonyArguments.SolaScriptura
