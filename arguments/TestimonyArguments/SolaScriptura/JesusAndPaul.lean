import TestimonyArguments.SolaScriptura.Mark7

/-!
# TestimonyArguments.SolaScriptura.JesusAndPaul — the same principle, beyond Mark 7

A reader who has followed the case from Mark 7 may fairly ask whether it rests
on one story. It does not. Jesus says elsewhere that "the Scripture cannot be
broken" (John 10:35), and that "until heaven and earth pass away, not the
smallest letter or stroke shall pass from the Law until all is accomplished"
(Matthew 5:18). Paul writes to the Galatians, "even if we, or an angel from
heaven, should proclaim to you a gospel contrary to the gospel we have
proclaimed to you, let him be accursed!" (Galatians 1:8), and to the Colossians,
"See to it that no one takes you captive through philosophy and empty deception,
according to the tradition of men, according to the elementary principles of the
world, and not according to Christ" (Colossians 2:8). Of the rules "Do not
handle, nor taste, nor touch" he says that they are "in accordance with the
commands and teachings of men" (2:21–22).

That last phrase is Isaiah's. J. B. Lightfoot notes that "The expression is
taken ultimately from Isaiah xxix. 13", the verse Jesus quotes against the
elders in Mark 7, and that the coincidences between Paul's language and Jesus'
words in Matthew 15 and Mark 7 "are striking, and suggest that the Apostle had
this discourse in his mind". So the relation is recorded as an allusion, on
Lightfoot's authority, and not as a quotation: Paul gives no "as it is written"
(`colossiansAlludesToIsaiah`, `colossiansAlludesToMark7`).

## What these texts deliver

Together they deliver the principle Mark 7 delivers: God's word judges human
tradition, and no commandment of men may be taught as God's word
(`jesusAndPaulPrinciple_establishes`). The step from the texts to the principle
is rated `wellSupported`, as Mark 7's is. Thomas Aquinas, lecturing on Galatians,
grants the text and the principle with it: "nothing is to be taught except what
is contained, either implicitly or explicitly, in the Gospels and epistles and
Sacred Scripture". What he denies is Calvin's reading of Paul's words, that the
gospel accursed is any gospel "to which the inventions of other men are added".
The Greek is παρ' ὅ, which can be rendered "contrary to", "besides" or "other
than", and for Aquinas Paul's "besides" means "adding something completely
alien". That is a dispute about how far the principle reaches, not about the
principle.

## What they do not deliver

They do not deliver sola scriptura. Add them to Mark 7 and to the step from the
principle to the sole rule, leave out the one premise Rome denies — that no
unwritten tradition can now be shown to be apostolic — and the sole rule is
still open: neither it nor its denial follows
(`every_text_without_the_hinge_leaves_the_sole_rule_open`). Nor do they reach
Trent read as the apostolic word handed on unwritten, which can be held with
every one of them (`jesus_and_paul_do_not_reach_the_apostolic_word`). Rome
answers that Paul also praises the Corinthians because they "hold firmly to the
traditions, just as I delivered them to you" (1 Corinthians 11:2), so that his
measure is where a teaching came from, not whether it was written down.

So the texts show that the principle does not hang on one story in the Gospels,
and they leave the Reformation's question where Mark 7 left it. In the dispute
over Mark 7 the principle already prevails, and the least-supported link in its
case is rated `wellSupported`, the second of the four ratings. A second route
rated the same would not change that, so these texts join the Protestant
position (`protestant`) and not the dispute.
-/

namespace TestimonyArguments.SolaScriptura

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### Paul and Isaiah 29:13 -/

/-- Colossians 2:22 — "in accordance with the commands and teachings of men"
(LSB). -/
@[nolint defsWithUnderscore] def colossians2_22 : Passage := ⟨.colossians, 2, 22⟩

/-- **Colossians 2:22 alludes to Isaiah 29:13.** Typed `.allusion`, not
`.quotation`: Paul introduces no citation, and Lightfoot says only that "The
expression is taken ultimately from Isaiah xxix. 13" (p. 204). Rated
`plausible`: only Lightfoot is cited for it, and no reader who denies it has
been looked for. -/
def colossiansAlludesToIsaiah : IntertextEdge :=
  { fromPassage := colossians2_22
  , toPassage := isaiah29_13
  , relation := .allusion
  , source :=
      { primary := .work lightfootColossians (.page 204)
      , tradition := .christianHistoricalGrammatical
      , confidence := .plausible } }

/-- **Colossians 2:22 alludes to Jesus' words in Mark 7.** Lightfoot finds the
coincidences with "our Lord's words as related in the Gospels (Matt. xv. 1—20,
Mark vii. 1—23)" "striking", and judges that they "suggest that the Apostle had
this discourse in his mind" (p. 204): both argue from the perishing of food, and
both connect such rules with Isaiah's denunciation. An allusion, and rated
`plausible`, for the same reasons as `colossiansAlludesToIsaiah`. -/
def colossiansAlludesToMark7 : IntertextEdge :=
  { fromPassage := colossians2_22
  , toPassage := mark7_7
  , relation := .allusion
  , source :=
      { primary := .work lightfootColossians (.page 204)
      , tradition := .christianHistoricalGrammatical
      , confidence := .plausible } }

/-! ### The principle, from Jesus and Paul -/

/-- **The principle from Jesus' sayings and Paul's letters**: John 10:35,
Matthew 5:18, Galatians 1:8–9 and Colossians 2:8, 20–22, and the step from them
to the principle that God's word judges human tradition. It claims nothing
about Scripture's place among the rules of faith. -/
@[solaScripturaDefs]
def jesusAndPaulPrinciple : ArgumentPackage Claim :=
  jesusAndPaulLine.asPackage cite "God's word judges human tradition"

/-- Every text the argument draws the principle from, Mark 7's and the others,
with the step from the principle to the sole rule, and without the premise that
no unwritten tradition can now be shown to be apostolic. -/
@[solaScripturaDefs]
def everyTextWithoutTheHinge : List (Formula Claim) :=
  caseOf [mark7Line, jesusAndPaulLine, mark7SoleRuleLine.onGrounds []] [] []

/-- **Jesus and Paul deliver the principle without Mark 7.** God's word judges
human tradition, from four texts and the step from them, rated `wellSupported`:
Aquinas grants Galatians 1:8 and the principle, and denies only that every
addition to the gospel is "another gospel".

What this does not claim: that the principle makes Scripture the only measure of
tradition. Aquinas and Rome grant the principle and deny that. -/
@[headline]
theorem jesusAndPaulPrinciple_establishes : Establishes jesusAndPaulPrinciple := by
  establish [solaScripturaDefs]

#print axioms jesusAndPaulPrinciple_establishes

/-- The principle from Jesus and Paul can be held without contradiction: the
Reformed reading. -/
theorem jesusAndPaulPrinciple_is_satisfiable :
    Satisfiable jesusAndPaulPrinciple.premises := by
  satisfied_by marksPrincipleReading [solaScripturaDefs]

/-- **Jesus and Paul do not reach Trent read as the apostolic word.** Trent,
read as receiving the apostolic word handed on unwritten, can be held with every
premise of the principle from Jesus and Paul: Rome's reading, on which God's
word judges human tradition and some unwritten tradition is the apostles' own,
known to be so. The same holds of Mark 7
(`mark7_does_not_reach_the_apostolic_word`). -/
@[headline]
theorem jesus_and_paul_do_not_reach_the_apostolic_word :
    Satisfiable (jesusAndPaulPrinciple.premises ++ tridentineAsApostolicWord.premises) := by
  satisfied_by romeGrantsMarksPrincipleReading [solaScripturaDefs]

#print axioms jesus_and_paul_do_not_reach_the_apostolic_word

/-- **Every text, without the premise Rome denies, leaves the sole rule open.**
Grant Mark 7, John 10:35, Matthew 5:18, Galatians 1:8–9 and Colossians 2, the
principle they deliver, and the step from the principle to the sole rule; leave
out only the premise that no unwritten tradition can now be shown to be
apostolic. Sola scriptura neither follows nor fails. Rome's reading grants all of
it and denies the sole rule; the Reformed reading grants all of it and holds the
sole rule. One fact, as with Mark 7 alone
(`mark7_without_the_hinge_leaves_the_sole_rule_open`): more texts for the
principle do not supply the premise the step to the sole rule needs. -/
@[headline]
theorem every_text_without_the_hinge_leaves_the_sole_rule_open :
    Independent everyTextWithoutTheHinge (p .scriptureIsSoleInfallibleRule) := by
  leaves_open romeGrantsMarksPrincipleReading marksPrincipleReading
    [solaScripturaDefs]

#print axioms every_text_without_the_hinge_leaves_the_sole_rule_open

end TestimonyArguments.SolaScriptura
