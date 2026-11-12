import TestimonyArguments.SolaFide.Definition

/-!
# TestimonyArguments.SolaFide.Verdict — does justification have degrees?

Trent's decree on justification has a chapter "On the increase of
Justification received". The justified, it says,

> "through the observance of the commandments of God and of the Church, faith
> co-operating with good works, increase in that justice which they have
> received through the grace of Christ, and are still further justified"
> (Session VI, ch. 10).

Canon 24 condemns anyone who says that good works are "merely the fruits and
signs of Justification obtained, but not a cause of the increase thereof".

The Reformed answer is short, and it starts in a courtroom.

> "If there is a dispute between men and they come into court and the judges
> decide between them, acquitting the innocent and condemning the guilty"
> (Deuteronomy 25:1).

> "He who justifies the wicked and he who condemns the righteous are both alike
> an abomination to the LORD" (Proverbs 17:15).

Paul uses the same pair of words of God: "It is God who justifies. Who is to
condemn?" (Romans 8:33–34). A judge's verdict acquits or condemns. Nobody leaves
a courtroom more acquitted than the man beside him, and nobody is acquitted a
little now and more later. So if justification is a verdict, it has no
degrees, and there is no "increase of justification" for works to cause.

## Who has said so

Calvin answered Trent's decree within the year, in his *Antidote*. Of the
council's account of justification he wrote: "I maintain that it is one, and
simple, and is wholly included in the gratuitous acceptance of God" (p. 116).
And of canon 24: "whosoever asserts that works have the effect of increasing
justification, understands neither what is the meaning of justification nor
its cause" (p. 158). Turretin, more than a century later, gave a whole question of his
*Institutes* to the point (Topic XVI, question 10): justification is perfect, so
that in itself it neither grows nor shrinks. James Buchanan put it in English
in 1867: justification is "an act, too, which is completed at once, and not a
work which is gradually accomplished by successive acts", and "there is no
second Justification, properly so called" (p. 251).

Two limits on the courtroom picture. Wright and Dunn speak of a present and a
future justification, a verdict given now and affirmed at the last judgment.
That is a verdict given twice, not a verdict that grows, and the step here
claims only that a verdict has no degrees, not that it is given once. And not
every picture of a divine court has two outcomes: the Talmud's three books, for
the wholly righteous, the wholly wicked and those in between (Rosh Hashanah
16b), has three. Those readers do not grant Romans 8:33–34 as Paul reads it,
and are not counted against the step.

## Where the argument has to go

The courtroom texts settle what a verdict is. They do not settle whether
justification is *only* a verdict, and that is where Trent stands. For Trent,
justification is "not remission of sins merely, but also the sanctification and
renewal of the inward man" (ch. 7), and a renewal can grow. So the argument from
the courtroom reaches Trent only with the Reformed definition beside it, that
justification is a verdict and nothing more (Westminster XI.1).

The checking bears this out in three results.

- **Granted the Reformed definition, justification has no degrees**, and works
  cannot increase it (`verdictOnDegrees_establishes`,
  `no_degrees_denies_the_increase`).
- **Trent can grant every courtroom text, and that a verdict has no degrees.**
  Its increase of justification still stands, because for Trent justification is
  more than a verdict (`trent_grants_that_verdicts_have_no_degrees`).
- **So the two part at one claim: whether justification is only a verdict.**
  Add that claim to Trent's position, and it can no longer be held
  (`degrees_turn_on_the_definition`). The courtroom texts alone leave the
  question open (`courtroom_texts_leave_degrees_open`).

So the argument that justification has no degrees is sound, and it is no
stronger than the definition it rests on. The chapter "What Trent means by
justification" weighs that definition. What this chapter adds is the reason the
Reformers cared about it: on their definition, Trent's increase has nothing to
increase.

## What this does not show

It does not show that the justified do not grow. Both sides hold that the
renewal of the justified grows through good works (`renewalGrowsThroughGoodWorks`).
The Reformed call that growth sanctification, as the Westminster Larger Catechism
does when it sets the two side by side (Q. 77): justification "doth equally free
all believers from the revenging wrath of God, and that perfectly in this life";
sanctification "is neither equal in all, nor in this life perfect in any, but
growing up to perfection". What the courtroom argument denies is that the growth
is an increase of *justification*.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic

/-! ### Trent's increase, written out first -/

/-- The step from an increase of justification to degrees of it. An increase is
more of something, so if works merit an increase of justification, justification
admits of more and less. Rated `consensus`: it is what the word "increase" says,
and both sides read Trent's chapter 10 so. -/
def increaseMeansDegreesSource : Source :=
  { primary := .work waterworthTrent (.page 37)
  , supporting := [.work calvinAntidote (.page 158)]
  , tradition := .romanCatholic
  , confidence := .consensus }

/-- **An increase of justification means degrees of it.** If works merit an
increase of justification, then justification has degrees. -/
@[solaFideDefs]
def increaseMeansDegreesLine : Line Claim :=
  { name := "Trent's increase, as degrees"
  , grounds := [p .worksMeritIncreaseOfJustification]
  , step := p .worksMeritIncreaseOfJustification ➝ p .justificationHasDegrees
  , delivers := p .justificationHasDegrees
  , inference := some increaseMeansDegreesSource }

/-- **Trent, on degrees of justification.** Justification is the renewal of the
inward man, the renewal grows through good works, so good works increase
justification (ch. 10, canon 24), and justification has degrees. -/
@[solaFideDefs]
def trentOnDegrees : ArgumentPackage Claim :=
  { name := "Trent, on the increase of justification"
  , cite := tridentineCite
  , premises := tridentineLine.premises ++ [increaseMeansDegreesLine.step]
  , conclusion := p .justificationHasDegrees
  , conclusionLabel := "justification has degrees"
  , inferences := [trentOnIncrease, increaseMeansDegreesSource] }

/-! ### The courtroom answer -/

/-- The step from the courtroom texts to "a verdict has no degrees". Judges
acquit or condemn (Deuteronomy 25:1; Proverbs 17:15), and God's justifying is set
against condemning in the same way (Romans 8:33–34). Cited to Buchanan (p. 251),
with Calvin's *Antidote* (p. 116) and Turretin (XVI, q. 10). -/
def courtroomSource : Source :=
  { primary := .work buchananJustification (.page 251)
  , supporting :=
      [ .work calvinAntidote (.page 116)
      , .work turretinInstitutes2 (.sectionRef "Topic XVI, q. 10") ]
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- **The courtroom line.** From Deuteronomy 25:1, Proverbs 17:15 and Romans
8:33–34, a verdict acquits or condemns and has no degrees. -/
@[solaFideDefs]
def courtroomLine : Line Claim :=
  { name := "The courtroom (Deuteronomy 25:1; Proverbs 17:15; Romans 8:33–34)"
  , grounds := [p .deut25_1JudgesAcquitOrCondemn, p .romans8_33_34]
  , step := ⋀ [p .deut25_1JudgesAcquitOrCondemn, p .romans8_33_34] ➝ p .verdictAdmitsNoDegrees
  , delivers := p .verdictAdmitsNoDegrees
  , inference := some courtroomSource }

/-- The step from "justification is a verdict only" and "a verdict has no
degrees" to "justification has no degrees". Calvin against canon 24 (*Antidote*,
p. 158), and Turretin (XVI, q. 10). -/
def noDegreesSource : Source :=
  { primary := .work calvinAntidote (.page 158)
  , supporting := [.work turretinInstitutes2 (.sectionRef "Topic XVI, q. 10")]
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- **No degrees.** If justification is a verdict and nothing more, and a verdict
has no degrees, then justification has none. -/
@[solaFideDefs]
def noDegreesLine : Line Claim :=
  { name := "A verdict only, so no degrees"
  , grounds := [p .justificationIsForensicOnly, p .verdictAdmitsNoDegrees]
  , step :=
      ⋀ [p .justificationIsForensicOnly, p .verdictAdmitsNoDegrees] ➝
        notP .justificationHasDegrees
  , delivers := notP .justificationHasDegrees
  , inference := some noDegreesSource }

/-- **The Reformed position on degrees.** The courtroom texts, that a verdict has
no degrees, and the Reformed definition, that justification is a verdict only. So
justification has no degrees. It also holds what an increase means, so that it
can say what it denies of Trent. -/
@[solaFideDefs]
def verdictOnDegrees : ArgumentPackage Claim :=
  { name := "Justification as a verdict, which has no degrees"
  , cite := reformedCite
  , premises :=
      courtroomLine.premises ++
        [p .justificationIsForensicOnly, noDegreesLine.step, increaseMeansDegreesLine.step]
  , conclusion := notP .justificationHasDegrees
  , conclusionLabel := "justification has no degrees"
  , inferences := [courtroomSource, noDegreesSource, increaseMeansDegreesSource] }

/-- **The same position, against Trent's increase.** It concludes what canon 24
condemns: good works do not merit an increase of justification. -/
@[solaFideDefs]
def verdictAgainstIncrease : ArgumentPackage Claim :=
  { verdictOnDegrees with
    name := "Justification as a verdict, against the increase"
    conclusion := notP .worksMeritIncreaseOfJustification
    conclusionLabel := "works do not merit an increase of justification" }

/-! ### The readings -/

/-- The Reformed reading: every courtroom text holds, a verdict has no degrees,
justification is a verdict only, and so it has no degrees and nothing increases
it. Trent's definition does not hold. -/
def verdictOnDegreesReading : Valuation Claim := fun a =>
  match a with
  | .justificationHasDegrees => False
  | .worksMeritIncreaseOfJustification => False
  | .justificationIncludesSanctification => False
  | _ => True

/-- Trent's reading, granting the courtroom texts and that a verdict has no
degrees: justification is more than a verdict, so its increase stands. -/
def trentOnDegreesReading : Valuation Claim := fun a =>
  match a with
  | .justificationIsForensicOnly => False
  | _ => True

/-! ### Results -/

/-- **Granted the Reformed definition, justification has no degrees.** From the
courtroom texts, a verdict acquits or condemns and has no degrees; justification
is a verdict and nothing more; so it has no degrees.

It does not show that justification is only a verdict. That is the
Reformed definition, and Trent denies it. -/
@[headline]
theorem verdictOnDegrees_establishes : Establishes verdictOnDegrees := by
  establish [solaFideDefs]

#print axioms verdictOnDegrees_establishes

/-- The Reformed position on degrees can be held without contradiction. -/
theorem verdictOnDegrees_is_satisfiable : Satisfiable verdictOnDegrees.premises := by
  satisfied_by verdictOnDegreesReading [solaFideDefs]

/-- **On the same premises, works do not merit an increase of justification.**
This is what canon 24 condemns, reached from the courtroom and the Reformed
definition.

It does not show that the justified do not grow. Both sides hold that
the renewal of the justified grows; the Reformed call it sanctification. -/
@[headline]
theorem no_degrees_denies_the_increase : Establishes verdictAgainstIncrease := by
  establish [solaFideDefs]

#print axioms no_degrees_denies_the_increase

/-- The same premises, so the same reading shows they can be held together. -/
theorem verdictAgainstIncrease_is_satisfiable :
    Satisfiable verdictAgainstIncrease.premises := by
  satisfied_by verdictOnDegreesReading [solaFideDefs]

/-- **Trent's increase follows from its own premises.** Justification is the
renewal of the inward man, the renewal grows through good works, and so
justification increases and has degrees.

It does not show that Trent's definition is right. The Westminster
Confession denies it (XI.1). -/
@[headline]
theorem trentOnDegrees_establishes : Establishes trentOnDegrees := by
  establish [solaFideDefs]

#print axioms trentOnDegrees_establishes

/-- Trent's position on degrees can be held without contradiction. -/
theorem trentOnDegrees_is_satisfiable : Satisfiable trentOnDegrees.premises := by
  satisfied_by trentOnDegreesReading [solaFideDefs]

/-- **Trent can grant every courtroom text, and that a verdict has no degrees.**
Its position on the increase of justification can be held together with
Deuteronomy 25:1, Proverbs 17:15, Romans 8:33–34 and the step from them to "a
verdict has no degrees". For Trent justification is more than a verdict, so a
verdict's having no degrees does not touch it.

It does not show that Trent says verdicts have no degrees. The result
says only that nothing in its position denies it. -/
@[headline]
theorem trent_grants_that_verdicts_have_no_degrees :
    Satisfiable (trentOnDegrees.premises ++ courtroomLine.premises) := by
  satisfied_by trentOnDegreesReading [solaFideDefs]

#print axioms trent_grants_that_verdicts_have_no_degrees

/-- **The two part at one claim: whether justification is only a verdict.** Add
to Trent's position that a verdict has no degrees, that justification is a
verdict only, and the step from those two to "no degrees", and it can no longer
be held. Together with `trent_grants_that_verdicts_have_no_degrees`, this puts
the whole disagreement about degrees at the Reformed definition.

It does not claim which side is right about the definition. That is
weighed in the chapter "What Trent means by justification". -/
@[headline]
theorem degrees_turn_on_the_definition :
    ¬ Satisfiable (trentOnDegrees.premises ++
      [p .justificationIsForensicOnly, p .verdictAdmitsNoDegrees, noDegreesLine.step]) :=
  not_satisfiable_of_check (by decide +kernel)

#print axioms degrees_turn_on_the_definition

/-- **The courtroom texts alone leave the question open.** Deuteronomy 25:1,
Proverbs 17:15 and Romans 8:33–34 are kept alike by the Reformed reading, on
which justification has no degrees, and by Trent's, on which it has. What
decides between them is the definition, not the texts. -/
@[headline]
theorem courtroom_texts_leave_degrees_open :
    Independent [p Claim.deut25_1JudgesAcquitOrCondemn, p .romans8_33_34]
      (p .justificationHasDegrees) := by
  leaves_open verdictOnDegreesReading trentOnDegreesReading [solaFideDefs]

#print axioms courtroom_texts_leave_degrees_open

end TestimonyArguments.SolaFide
