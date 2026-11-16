import TestimonyArguments.SolaScriptura.JesusAndPaul
import TestimonyArguments.SolaScriptura.Results

/-!
# TestimonyArguments.SolaScriptura.Acts15 — the council at Jerusalem, read both ways

Acts 15 tells of the council at Jerusalem, and both sides of the Reformation
read it as their own. It begins with a demand: "certain men which
came down from Judaea taught the brethren, and said, Except ye be circumcised
after the manner of Moses, ye cannot be saved" (15:1). The apostles and elders
meet. Peter asks "why tempt ye God, to put a yoke upon the neck of the
disciples, which neither our fathers nor we were able to bear? But we believe
that through the grace of the Lord Jesus Christ we shall be saved, even as they"
(15:10–11). James answers from the prophets: "to this agree the words of the
prophets; as it is written, After this I will return, and will build again the
tabernacle of David, which is fallen down" (15:15–16, quoting Amos 9:11–12).
The council writes to the gentile churches, "For it seemed good to the Holy
Ghost, and to us, to lay upon you no greater burden than these necessary things"
(15:28), and Paul and Silas, going through the cities, "delivered them the
decrees for to keep, that were ordained of the apostles and elders which were at
Jerusalem" (16:4).

James's words are a quotation, not an allusion: he introduces them "as it is
written" (`acts15QuotesAmos`). Calvin notes that the place "is not cited word
for word as it is in the prophet". Luke gives Amos close to the Greek
translation, the Septuagint. Where the Hebrew of Amos 9:12 reads "That they may
possess the remnant of Edom", the Septuagint reads "that the remnant of men may
seek" (ὅπως ἐκζητήσωσιν οἱ κατάλοιποι τῶν ἀνθρώπων), and so does Acts: "That the
residue of men might seek after the Lord".

## The Reformed reading

The custom of Moses was the oldest tradition Israel had, and God had given it.
The council did not let even that be laid on the gentiles as a condition of
salvation: Peter answered it with the gospel and James with Scripture. So the
gospel judged even the oldest tradition, and the council judged by Scripture.
Calvin says of 15:15 that the apostles "took nothing to themselves imperiously,
but did reverently follow that which was prescribed in the word of God", and
were not ashamed "to profess themselves to be the scholars of the Scripture".
The Westminster Confession draws the rule for councils after them: their
decrees bind "if consonant to the Word of God", and "All synods or councils since
the apostles' times, whether general or particular, may err, and many have
erred; therefore they are not to be made the rule of faith or practice, but to
be used as a help in both" (XXXI.3–4, in the numbering of 1647). The Protestant
position reads Acts 15 this way (`acts15ReformedLine`).

## Rome's reading

The council's letter claims more than agreement with Scripture: "it seemed good
to the Holy Ghost, and to us". Joseph Wilhelm, writing on general councils in
the *Catholic Encyclopedia* of 1908, takes it as "the mind of the Apostles":
they "put the seal of supreme authority on their decisions in attributing them
to the joint action of the Spirit of God and of themselves", and general
councils in union with the pope have the same "infallible authority". The
decrees were then handed on to the churches to keep: "delivered" in 16:4
(παρεδίδοσαν) is the verb whose noun is "tradition" (παράδοσις). Tradition III,
the position resting on Vatican I, reads Acts 15 this way (`acts15RomanLine`).

## What the texts settle, and what they do not

Each reading grants every text the other reads. The Westminster Confession
cites Acts 15:27–31 and 16:4 as its own proof that a council's decrees bind, and
Wilhelm, as a Catholic, grants Peter's and James's words. What they part over
is the step from the texts to councils after the apostles, and each step is
rated `disputed` because the other side's reader grants its texts and denies its
conclusion.

So the two readings cannot be held together
(`acts15_readings_cannot_be_held_together`), and the texts by themselves do not
choose between them: grant all six texts, without either step, and whether a council
binds with the Spirit's authority neither follows nor fails
(`acts15_texts_leave_the_council_open`).

Nor does Rome's reading reach the premise the Mark 7 case for sola scriptura
needs, that no unwritten tradition can now be shown to be apostolic. The
decrees handed on in 16:4 were not unwritten: "they wrote letters by them"
(15:23), and the letter is in Scripture (15:23–29). Grant Rome's reading of Acts
15 and that the decree was written, and the premise about unwritten tradition is
left exactly where it was (`romes_reading_of_acts15_leaves_unwritten_tradition_open`).

These lines join the Protestant and Vatican I positions, and not the dispute
over Mark 7. That dispute is about tradition, and none of its parties says
anything about councils, so neither reading of Acts 15 would meet a party
there.
-/

namespace TestimonyArguments.SolaScriptura

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### James and Amos -/

/-- Acts 15:16 — "After this I will return, and will build again the tabernacle
of David", where James's quotation of the prophets begins. -/
@[nolint defsWithUnderscore] def acts15_16 : Passage := ⟨.acts, 15, 16⟩

/-- Amos 9:11 — "In that day will I raise up the tabernacle of David that is
fallen". -/
@[nolint defsWithUnderscore] def amos9_11 : Passage := ⟨.amos, 9, 11⟩

/-- **Acts 15:16–17 quotes Amos 9:11–12.** Typed `.quotation`, not `.allusion`:
James introduces the words "as it is written". Calvin notes at 15:16 that they
are "not cited word for word as it is in the prophet"; Luke gives them close to
the Septuagint. -/
def acts15QuotesAmos : IntertextEdge :=
  { fromPassage := acts15_16
  , toPassage := amos9_11
  , relation := .quotation
  , source :=
      { primary := .work na28 (.apparatus acts15_16)
      , supporting := [.work ubs5 .whole, .work calvinActs2 (.adLoc acts15_16)]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-! ### The two readings -/

/-- **Acts 15, the Reformed reading**: the demand of 15:1, Peter's answer from
the gospel and James's from Scripture, and the step from them to councils: a
council after the apostles binds as far as it agrees with Scripture, and may
err. -/
@[solaScripturaDefs]
def acts15Reformed : ArgumentPackage Claim :=
  acts15ReformedLine.asPackage cite
    "a council after the apostles does not bind with the Spirit's own authority"

/-- **Acts 15, Rome's reading**: "it seemed good to the Holy Ghost, and to us",
the decrees delivered to keep, and the step from them to councils: a general
council binds with the Holy Spirit's authority. -/
@[solaScripturaDefs]
def acts15Roman : ArgumentPackage Claim :=
  acts15RomanLine.asPackage cite "a general council binds with the Spirit's authority"

/-- Every text either reading of Acts 15 reads, and the letter the decree went
out in: 15:1, 10–11, 15–17, 23–29 and 28, and 16:4. No step. -/
@[solaScripturaDefs]
def acts15Texts : List (Formula Claim) :=
  acts15ReformedLine.grounds ++ acts15RomanLine.grounds ++ [p .acts15_23_29DecreeWritten]

/-! ### Readings, written down -/

/-- The Reformed world, on Acts 15: every text holds, no commandment of men is
bound as God's word, and a council after the apostles may err. -/
def reformedOnTheCouncilReading : Valuation Claim := fun a =>
  match a with
  | .mensCommandmentBindsAsGodsWord => False
  | .councilBindsWithTheSpiritsAuthority => False
  | _ => True

/-! ### What follows -/

/-- **The Reformed reading of Acts 15 holds, given its step.** From 15:1, 15:10–11
and 15:15–17, a council after the apostles does not bind with the Spirit's own
authority: it binds as far as it agrees with Scripture. The step is rated
`disputed`: Wilhelm grants the texts and denies the conclusion.

What this does not claim: that councils have no authority. The Westminster
Confession, which holds this reading, says their decrees are "to be received with
reverence and submission" when they agree with the word. -/
theorem acts15Reformed_establishes : Establishes acts15Reformed := by
  establish [solaScripturaDefs]

#print axioms acts15Reformed_establishes

/-- The Reformed reading of Acts 15 can be held without contradiction. -/
theorem acts15Reformed_is_satisfiable : Satisfiable acts15Reformed.premises := by
  satisfied_by reformedOnTheCouncilReading [solaScripturaDefs]

/-- **Rome's reading of Acts 15 holds, given its step.** From 15:28 and 16:4, a
general council binds with the Holy Spirit's authority. The step is rated
`disputed`: the Westminster Confession grants the texts and denies the
conclusion. -/
theorem acts15Roman_establishes : Establishes acts15Roman := by
  establish [solaScripturaDefs]

#print axioms acts15Roman_establishes

/-- Rome's reading of Acts 15 can be held without contradiction: Rome's world, in
which God's word judges human tradition, some unwritten tradition is known to be
apostolic, and a general council binds with the Spirit's authority. -/
theorem acts15Roman_is_satisfiable : Satisfiable acts15Roman.premises := by
  satisfied_by romeGrantsMarksPrincipleReading [solaScripturaDefs]

/-- **The two readings of Acts 15 cannot be held together.** One concludes that a
council after the apostles may err, the other that a general council binds with
the Spirit's authority and cannot. Since every text either reads is granted by
both, what they part over is the two steps, each rated `disputed`.

What this does not claim: that either reading is wrong. It shows only that a
reader must choose between them. -/
@[headline]
theorem acts15_readings_cannot_be_held_together :
    ¬ Satisfiable (acts15Reformed.premises ++ acts15Roman.premises) :=
  not_satisfiable_of_check (by decide +kernel)

#print axioms acts15_readings_cannot_be_held_together

/-- **The texts of Acts 15 do not settle the council's authority.** Grant
15:1, 15:10–11, 15:15–17, 15:23–29 and 15:28, and 16:4, without either reading's
step: whether a general council binds with the Spirit's authority neither
follows nor fails. The Reformed reading grants every text and denies it; Rome's
grants every text and holds it. One fact, not two: the texts alone establish
neither reading and block neither. -/
@[headline]
theorem acts15_texts_leave_the_council_open :
    Independent acts15Texts (p .councilBindsWithTheSpiritsAuthority) := by
  leaves_open reformedOnTheCouncilReading romeGrantsMarksPrincipleReading
    [solaScripturaDefs]

#print axioms acts15_texts_leave_the_council_open

/-- **Rome's reading of Acts 15 does not reach unwritten tradition.** Grant that
"it seemed good to the Holy Ghost, and to us", that the decrees were delivered
to keep, Rome's step from them, and that the decree went out as a letter
(15:23–29): whether any unwritten tradition can now be shown to be apostolic
neither follows nor fails. Rome's world grants all of it and denies the premise;
a world in which every claim of the argument holds grants all of it and holds
the premise. What the council handed on was written, so it is no instance of
the unwritten tradition the Mark 7 case turns on. -/
@[headline]
theorem romes_reading_of_acts15_leaves_unwritten_tradition_open :
    Independent (acts15Roman.premises ++ [p .acts15_23_29DecreeWritten])
      (p .noUnwrittenTraditionShownApostolic) := by
  leaves_open romeGrantsMarksPrincipleReading everythingHoldsReading [solaScripturaDefs]

#print axioms romes_reading_of_acts15_leaves_unwritten_tradition_open

end TestimonyArguments.SolaScriptura
