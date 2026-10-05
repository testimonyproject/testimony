import Testimony.Meanings.SolaScriptura
import Testimony.Arguments.SolaScriptura.Packages
import Testimony.Intertext
import Testimony.Logic.Dilemma
import Testimony.Logic.Tactic

/-!
# Arguments.SolaScriptura.Mark7 — what Jesus' rebuke of tradition settles

The Pharisees and scribes ask why Jesus' disciples eat with unwashed hands,
against "the tradition of the elders". Jesus answers with Isaiah 29:13 — "in
vain do they worship me, teaching as doctrines the commandments of men" — and
with Corban: a gift vowed to God releases a son from supporting his father and
mother, "thus making void the word of God by your tradition" (Mark 7:1–13;
Matthew 15:1–9). The Protestant case has always cited it. Until now it only sat
among the shared grounds, and no step read it.

## What Mark 7 settles

**The principle is common ground.** God's word judges human tradition: no
commandment of men may be taught as God's word, and a tradition that voids
God's command is void. Rome says the same — its teaching office is "not above
the word of God" (*Dei Verbum* 10) — and so the principle is not a Protestant
win. Trent, as it states its position, can hold every word of it
(`trent_grants_marks_principle`).

**It does not reach sola scriptura on its own.** From the principle to "Scripture
is the sole infallible rule" needs one more premise: that no apostolic teaching
handed on outside Scripture survives as God's word. Without it, Mark 7 leaves the
sole rule open — neither it nor its denial follows
(`mark7_without_the_hinge_leaves_the_sole_rule_open`). With it, the conclusion
follows (`mark7Case_establishes`), and the premise is rated `disputed`: Rome
denies it from 2 Thessalonians 2:15 ("by word *or* by letter"). The step itself
is disputed too. A reader can grant the principle, and grant that nothing
apostolic survives outside Scripture, and still deny that Scripture is the
*sole* infallible rule: Florovsky, for whom tradition adds nothing to Scripture
and the mind of the Church interprets it; or a Catholic who holds Scripture
materially sufficient and the Magisterium infallible.

## What Rome's "tradition" means

The question the passage raises for a reader is whether the tradition Jesus
condemns is the thing Rome means by Tradition. `whatTrentsTraditionIs` answers
both readings.

- **Read as commandments of men** — Calvin's reading of the laws of worship he
  opposed, applying Matthew 15:9 to them (*Institutes* IV.x.23) — Trent's claim
  is exactly what Mark 7 condemns. The reading cannot be held with Mark 7's
  principle, at a step rated `wellSupported`.
- **Read as the apostolic word handed on unwritten** — what Trent says it
  receives, traditions "received by the Apostles from the mouth of Christ
  himself, or from the Apostles themselves, the Holy Ghost dictating" (Session
  IV, in Waterworth's translation) — Mark 7 does not reach it. Nothing in the principle is denied.
  The reading meets the Mark 7 case only at the premise the step to sola
  scriptura needs, that no apostolic word survives outside Scripture, and that
  premise is `disputed`.

So Mark 7 does not decide between Rome and the Reformers. It moves the question
to what the sola scriptura argument already turned on: whether any unwritten
apostolic word survives and can be identified — and, even granting that none
does, whether the principle then makes Scripture the *sole* infallible rule.
-/

namespace Testimony.Arguments.SolaScriptura

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

attribute [solaScripturaDefs] ArgumentPackage.readAs

/-! ### The quotation -/

/-- **Mark 7:6–7 quotes Isaiah 29:13.** Typed `.quotation`, not `.allusion`:
Jesus introduces the words with "as it is written", and Mark gives them close to
the Septuagint's wording. -/
def mark7QuotesIsaiah : IntertextEdge :=
  { fromPassage := mark7_7
  , toPassage := isaiah29_13
  , relation := .quotation
  , source := na28Apparatus mark7_7 }

/-- **Matthew 15:8–9 quotes the same verse**, in the parallel account. -/
def matthew15QuotesIsaiah : IntertextEdge :=
  { fromPassage := matthew15_9
  , toPassage := isaiah29_13
  , relation := .quotation
  , source := na28Apparatus matthew15_9 }

/-! ### The positions -/

/-- **Mark 7's principle**: Jesus' rebuke of the elders' tradition, and what it
enacts — God's word judges human tradition, and no commandment of men is to be
taught as God's word. It concludes the principle, and claims nothing about
Scripture's place among the rules of faith. -/
@[solaScripturaDefs]
def mark7Principle : ArgumentPackage Claim :=
  { name := "Mark 7: God's word judges human tradition"
  , cite := cite
  , premises := caseOf [mark7Line] [] [principleExcludesMensCommandments]
  , conclusion := p .godsWordJudgesTradition
  , conclusionLabel := "God's word judges human tradition"
  , inferences := mark7Line.inference.toList }

/-- **Mark 7's case for sola scriptura**: the principle, and the premise that no
apostolic word survives outside Scripture. -/
@[solaScripturaDefs]
def mark7Case : ArgumentPackage Claim :=
  { name := "Sola scriptura from Mark 7"
  , cite := cite
  , premises := caseOf [mark7Line, mark7SoleRuleLine] [] []
  , conclusion := p .scriptureIsSoleInfallibleRule
  , conclusionLabel := "scripture is the sole infallible rule of faith"
  , inferences := mark7Line.inference.toList ++ mark7SoleRuleLine.inference.toList }

/-- Mark 7's case without the premise that no apostolic word survives outside
Scripture: the text, the principle, and the step to the sole rule. -/
@[solaScripturaDefs]
def mark7CaseWithoutTheHinge : ArgumentPackage Claim :=
  { mark7Case with
    name := "Sola scriptura from Mark 7, without the premise about unwritten apostolic word"
    premises := caseOf [mark7Line, mark7SoleRuleLine.onGrounds []] [] [] }

/-- **Trent (Tradition II)**, as Mathison reads it: 2 Thessalonians 2:15 and
tradition as a source of revelation alongside Scripture, so Scripture is not the
sole rule. Unread: it says what Trent receives, not whether it is apostolic word
or a commandment of men. The package `tridentine` asks these premises whether
sola scriptura follows; this one states what they conclude, which is what a
dispute weighs. -/
@[solaScripturaDefs]
def tridentineCase : ArgumentPackage Claim :=
  tridentineLine.asPackage cite "scripture is not the sole infallible rule of faith"

/-! ### Two readings of Trent's "tradition" -/

/-- Reading Trent's traditions as commandments of men: God "is worshipped with
laws of human invention", Calvin says of the laws of worship he opposed, and he
applies Matthew 15:9 to them — "in vain do they worship me, teaching for
doctrines the commandments of men" (*Institutes* IV.x.23). Rated `disputed`:
Trent, *Dei Verbum* 9–10 and the *Catechism* deny that what Trent receives is of
human origin — the *Catechism* (§83) distinguishes the apostolic Tradition from
the "theological, disciplinary, liturgical or devotional traditions" which "can
be retained, modified or even abandoned". No one reads Trent as *claiming* human
origin: this is a reading of what those traditions are, not of what Trent
says. -/
def trentReadAsMensCommandments : Source :=
  { primary := .work calvinInstitutes (.sectionRef "IV.x.23")
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- Reading Trent's traditions as the apostolic word handed on unwritten: what
Trent says it receives, the traditions "received by the Apostles from the mouth
of Christ himself, or from the Apostles themselves, the Holy Ghost dictating"
(Session IV, Waterworth 18). *Dei Verbum* 9 says the same: tradition "takes the
word of God entrusted by Christ the Lord and the Holy Spirit to the Apostles,
and hands it on". Rated `consensus` as an account of what Trent claims: Calvin
and Chemnitz do not deny that Trent claims apostolic origin; they deny that the
claim is true. -/
def trentReadAsApostolicWord : Source :=
  { primary := .work waterworthTrent (.page 18)
  , supporting :=
      [ .work tannerDecrees
          (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions")
      , .work tannerDecrees (.sectionRef "Vatican II (1965), Dei Verbum 9")
      , .work catechismCatholicChurch (.sectionRef "83") ]
  , tradition := .romanCatholic
  , confidence := .consensus }

/-- Trent's tradition, **read as commandments of men**: what it receives
alongside Scripture is a commandment of men, bound on the Church as God's
word. -/
@[solaScripturaDefs]
def asMensCommandments : Reading Claim :=
  { name := "as commandments of men"
  , commits := p .mensCommandmentBindsAsGodsWord
  , source := trentReadAsMensCommandments }

/-- Trent's tradition, **read as the apostolic word handed on unwritten**: some
apostolic teaching outside Scripture survives as God's word. -/
@[solaScripturaDefs]
def asApostolicWord : Reading Claim :=
  { name := "as the apostolic word handed on unwritten"
  , commits := notP .noApostolicWordOutsideScripture
  , source := trentReadAsApostolicWord }

/-- Trent, with its tradition read as commandments of men. -/
@[solaScripturaDefs]
def tridentineAsMensCommandments : ArgumentPackage Claim :=
  tridentineCase.readAs (p .traditionIsCoordinateSourceOfRevelation) asMensCommandments

/-- Trent, with its tradition read as the apostolic word handed on unwritten. -/
@[solaScripturaDefs]
def tridentineAsApostolicWord : ArgumentPackage Claim :=
  tridentineCase.readAs (p .traditionIsCoordinateSourceOfRevelation) asApostolicWord

/-! ### Readings, written down -/

/-- The Reformed world: Mark 7's text and principle, no commandment of men bound
as God's word, no apostolic word outside Scripture, and sola scriptura. -/
def marksPrincipleReading : Valuation Claim := fun a =>
  match a with
  | .mensCommandmentBindsAsGodsWord => False
  | _ => True

/-- Rome's world, granting Mark 7: God's word judges human tradition and no
commandment of men may be bound as God's word; but apostolic teaching survives
outside Scripture, so Scripture is not the sole infallible rule. -/
def romeGrantsMarksPrincipleReading : Valuation Claim := fun a =>
  match a with
  | .mensCommandmentBindsAsGodsWord => False
  | .noApostolicWordOutsideScripture => False
  | .scriptureIsSoleInfallibleRule => False
  | _ => True

/-- A world in which Trent, its tradition read Calvin's way, holds together: its
tradition is a commandment of men bound as God's word, and Scripture is not the
sole rule. It must give up Mark 7's principle, so no one holds this world; it
shows only that the reading is coherent on its own. -/
def mensCommandmentsReading : Valuation Claim := fun a =>
  match a with
  | .godsWordJudgesTradition => False
  | .scriptureIsSoleInfallibleRule => False
  | _ => True

/-! ### Mark 7's principle, and what it reaches -/

/-- **Mark 7 delivers its principle**: God's word judges human tradition. -/
@[headline]
theorem mark7Principle_establishes : Establishes mark7Principle := by
  establish [solaScripturaDefs]

#print axioms mark7Principle_establishes

/-- Mark 7's principle can be held without contradiction. -/
theorem mark7Principle_is_satisfiable : Satisfiable mark7Principle.premises := by
  satisfied_by marksPrincipleReading [solaScripturaDefs]

/-- **Trent grants Mark 7's principle.** Trent's position, as it states it, can
be held with the principle and everything Mark 7 says: the reading on which
apostolic teaching survives outside Scripture, and no commandment of men is
bound as God's word. -/
@[headline]
theorem trent_grants_marks_principle :
    Grants tridentineCase (p .godsWordJudgesTradition) := by
  satisfied_by romeGrantsMarksPrincipleReading [Grants, solaScripturaDefs]

#print axioms trent_grants_marks_principle

/-- **Mark 7's case for sola scriptura holds**, given its premise that no
apostolic word survives outside Scripture. -/
@[headline]
theorem mark7Case_establishes : Establishes mark7Case := by
  establish [solaScripturaDefs]

#print axioms mark7Case_establishes

/-- Mark 7's case can be held without contradiction. -/
theorem mark7Case_is_satisfiable : Satisfiable mark7Case.premises := by
  satisfied_by marksPrincipleReading [solaScripturaDefs]

/-- **Without that premise, Mark 7 leaves the sole rule open.** Grant the text,
the principle, and the step from them to the sole rule: sola scriptura neither
follows nor fails. Rome's reading grants all of it and denies the sole rule;
the Reformed reading grants all of it and holds the sole rule. One fact, not
two: Mark 7 alone blocks no argument against sola scriptura and establishes
none for it. -/
@[headline]
theorem mark7_without_the_hinge_leaves_the_sole_rule_open :
    Independent mark7CaseWithoutTheHinge.premises (p .scriptureIsSoleInfallibleRule) := by
  leaves_open romeGrantsMarksPrincipleReading marksPrincipleReading
    [solaScripturaDefs]

#print axioms mark7_without_the_hinge_leaves_the_sole_rule_open

/-- Trent, as it states its position, holds together. -/
theorem tridentineCase_establishes : Establishes tridentineCase := by
  establish [solaScripturaDefs]

/-- Trent's case can be held without contradiction: Rome's world. -/
theorem tridentineCase_is_satisfiable : Satisfiable tridentineCase.premises := by
  satisfied_by romeGrantsMarksPrincipleReading [solaScripturaDefs]

/-- Trent read as commandments of men still concludes what Trent concludes. -/
theorem tridentineAsMensCommandments_establishes :
    Establishes tridentineAsMensCommandments :=
  ArgumentPackage.readAs_establishes tridentineCase_establishes

/-- Trent read as the apostolic word still concludes what Trent concludes. -/
theorem tridentineAsApostolicWord_establishes :
    Establishes tridentineAsApostolicWord :=
  ArgumentPackage.readAs_establishes tridentineCase_establishes

/-- **The first reading is fair**: Trent, read as receiving commandments of men,
can be held without contradiction — so long as Mark 7's principle is not held
with it. -/
theorem tridentineAsMensCommandments_is_satisfiable :
    Satisfiable tridentineAsMensCommandments.premises := by
  satisfied_by mensCommandmentsReading [solaScripturaDefs]

/-- **The second reading is fair**: Trent, read as receiving the apostolic word,
can be held without contradiction. -/
theorem tridentineAsApostolicWord_is_satisfiable :
    Satisfiable tridentineAsApostolicWord.premises := by
  satisfied_by romeGrantsMarksPrincipleReading [solaScripturaDefs]

/-- **Mark 7 does not reach the second reading.** Trent, read as receiving the
apostolic word, can be held with every premise of Mark 7's principle: it binds
no commandment of men as God's word. -/
theorem mark7_does_not_reach_the_apostolic_word :
    Satisfiable (mark7Principle.premises ++ tridentineAsApostolicWord.premises) := by
  satisfied_by romeGrantsMarksPrincipleReading [solaScripturaDefs]

/-! ### Where each reading breaks -/

/-- **Why Mark 7 stands against Trent, read as commandments of men.** The crux is
what the principle says of a commandment of men: it may not be bound as God's
word. What it breaks is Trent's claim with the reading — tradition
received alongside Scripture, and that tradition a commandment of men. Nothing
else in Trent is touched. The crux is Mark 7's answer to the reading, not part
of its case for the principle, which follows without it. -/
def whereTheMensCommandmentsReadingFalls :
    Because mark7Principle tridentineAsMensCommandments :=
  Because.ofChecks principleExcludesMensCommandments
    [p .mark7TraditionCanNullify, mark7ToPrinciple] []
    [p .mark7TraditionCanNullify, mark7ToPrinciple]
    [ p .traditionIsCoordinateSourceOfRevelation
    , p .traditionIsCoordinateSourceOfRevelation ➝ p .mensCommandmentBindsAsGodsWord ]
    .answers mark7Principle_establishes mark7Principle_is_satisfiable
    (by simp [mark7Principle, caseOf, mark7Line])
    (by simp [mark7Principle, caseOf, mark7Line])
    (by simp [solaScripturaDefs, Line.asPackage, Line.premises])
    (by decide +kernel)

/-- **Why Mark 7's case stands against Trent, read as the apostolic word.** Not
at the principle, which this reading grants, but at the premise the step to
sola scriptura needs: that no apostolic teaching survives outside Scripture.
The reading denies exactly that, and the premise is rated `disputed`. The step
from it to the sole rule is `disputed` too, so granting the premise would not
alone settle the question. -/
def whereTheApostolicWordReadingFalls : Because mark7Case tridentineAsApostolicWord :=
  Because.ofChecks (p .noApostolicWordOutsideScripture)
    [p .mark7TraditionCanNullify] [mark7ToPrinciple, principleToSoleRule] []
    [ p .traditionIsCoordinateSourceOfRevelation
    , p .traditionIsCoordinateSourceOfRevelation ➝ notP .noApostolicWordOutsideScripture ]
    .derives mark7Case_establishes mark7Case_is_satisfiable
    (by simp [mark7Case, caseOf, mark7Line, mark7SoleRuleLine])
    (by simp)
    (by simp [solaScripturaDefs, Line.asPackage, Line.premises])
    (by decide +kernel)

/-! ### The dilemma -/

/-- **What Trent's tradition is, read both ways.** The claim is Trent's: tradition
is received as a source of revelation alongside Scripture.

Read as commandments of men, it cannot be held with Mark 7's principle, at a
step rated `wellSupported`: Isaiah 29:13, as Jesus quotes it, says a commandment
of men may not be bound as God's word.

Read as the apostolic word handed on unwritten — what Trent says it receives —
Mark 7's principle does not reach it. It cannot be held with Mark 7's case for
sola scriptura, but only at that case's own premise that no apostolic word
survives outside Scripture, which is `disputed`. That is the question the sola
scriptura argument already turns on; Mark 7 does not settle it.

Each reading is fair: Trent read either way can be held without contradiction. Which reading
fits Trent is not something the dilemma decides; what it shows is what each
costs. -/
def whatTrentsTraditionIs : Dilemma tridentineCase where
  claim := p .traditionIsCoordinateSourceOfRevelation
  horns :=
    [ { reading := asMensCommandments
      , fair := tridentineAsMensCommandments_is_satisfiable
      , fates := [.falls mark7Principle whereTheMensCommandmentsReadingFalls]
      , answered := by simp }
    , { reading := asApostolicWord
      , fair := tridentineAsApostolicWord_is_satisfiable
      , fates :=
          [ .unreached mark7Principle mark7Principle_establishes
              mark7_does_not_reach_the_apostolic_word
          , .falls mark7Case whereTheApostolicWordReadingFalls ]
      , answered := by simp } ]
  claim_mem := by simp [solaScripturaDefs, Line.asPackage, Line.premises]
  two := by simp

end Testimony.Arguments.SolaScriptura
