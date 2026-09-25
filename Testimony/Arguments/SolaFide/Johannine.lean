import Testimony.Arguments.SolaFide.Results

/-!
# Arguments.SolaFide.Johannine — "this is the work of God, that you believe"

A fourth strand for sola fide, from John's Gospel, encoded on its own. Asked
what they must do "to be doing the works of God", the crowd is told: "This is
the work of God, that you believe in him whom he has sent" (John 6:28–29). The
question of works is put to Jesus in terms, and he answers with believing. The
Gospel says the same throughout: eternal life, and passing out of judgement,
through believing in the Son (3:16–18, 3:36, 5:24), and it states its own
purpose in those terms (20:31).

## The hinge: what believing is

Both sides grant the verse. What divides them is what its believing is.

- **Calvin** reads it as trust. Christ calls faith a work only improperly:
  faith "brings nothing to God, but, on the contrary, places man before God as
  empty and poor, that he may be filled with Christ", and "bestows on man no
  other righteousness than that which he receives from Christ". It is "a
  passive work, to which no reward can be paid".
- **Aquinas** reads it as faith formed by charity. Paul distinguishes faith
  "only from external works"; to believe *in* him (*in illum*), as one's end,
  "is proper to faith living through the love of charity", and faith so living
  "is the principle of all our good works" (*Super Ioannem* 6, lect. 3, n. 901).
  That is Trent's account of justifying faith (Session VI, ch. 7): faith
  without hope and charity "neither unites man perfectly with Christ, nor makes
  him a living member of His body".

So the strand has the same shape as the others: shared texts, and a reading on
which everything turns. Grant Aquinas his reading and the texts no longer
deliver faith alone (`johannine_strand_rests_on_believing_as_trust`).

## John has no word for justification

δικαιόω does not occur in John. The strand's step therefore runs from eternal
life through believing to justification by faith alone, and that is an
inference, not a reading of a word. It is cited to Calvin, whose comment on 6:29
speaks of the righteousness faith receives from Christ, and rated `plausible`:
no cited source grants the strand's grounds and denies that step, but none argues
the bridge from John's vocabulary to Paul's at length either.

## Luther's answer, from Galatians 3

Aquinas's reading is not left standing unanswered. Luther meets it head-on in
his lectures on Galatians. At 3:11: "The scholastics misconstrue this passage by
saying: 'The just shall live by faith, if it is a working faith, or a faith
formed and performed by charitable works.' … To speak of formed or unformed
faith, a sort of double faith, is contrary to the Scriptures." At 3:12: "Does
not the Law command charity? … If the law requires charity, charity is part of
the Law and not of faith." So a faith that justifies because charity forms it
justifies by the law after all — and "the law is not of faith" (Galatians 3:12).

The argument is encoded as a line of its own (`lutherLine`). Its grounds are
both things Aquinas grants: the text of Galatians 3:11–12, and that love of God
and neighbour is what the law commands (Deuteronomy 6:5). Its step is Luther's:
from those, the believing that justifies is not faith formed by charity.
Granted the step, Aquinas's reading of John 6:29 falls
(`luther_answers_aquinas_from_galatians`). But the step is the whole of the
answer: the texts alone do not exclude his reading
(`luther_answer_rests_on_his_step`), and the step is rated `disputed`, because
Aquinas grants both of its grounds and denies its conclusion. Nor does removing
Aquinas's reading establish Calvin's: that the believing of 6:29 is not formed
by charity is weaker than that it is trust.

Calvin makes the neighbouring argument in the *Institutes* (III.xi.19), which
the library already cites for `worksOfLawMeansWorksGenerally`: against those
who "pretend that the works excluded are ceremonial, not moral works", he cites
Galatians 3:10 and 3:12 — the curse on everyone who does not continue in *all*
that the law commands — and concludes that "the whole Law is spoken of when the
power of justifying is denied to it". Aquinas's distinction is between
external and inward works rather than ceremonial and moral ones, so it is
Luther's argument on 3:11–12, not Calvin's, that meets him directly.

The Catholic reply rests on Galatians 5:6, "faith working through love", which
Trent cites (Session VI, ch. 7). How Luther and Calvin read that verse is not
yet encoded.

## What is not yet done

The strand is encoded alone, as a package of its own. It is **not** yet part of
`reformed` or of the sola fide dispute, and that is deliberate. Adding a fourth
strand to `reformed` changes the joint results — no premise removed from the
other three strands defeats sola fide while John's strand stands — and a
Johannine party in `Dispute.lean` changes the defeat table. Both are the next
step, tracked in issue #86, and every statement elsewhere that sola fide "runs
on three strands" remains true of `reformed` until then.

Nor does it encode the obedience reading of 3:36, where the opposite of the one
who believes is the one who "does not obey" (ἀπειθῶν): no source arguing that
Johannine faith therefore includes obedience has been verified yet.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### The lines -/

/-- Calvin's step from John to justification. John has no δικαιόω, so the
bridge from eternal life through believing to justification by faith alone is
an inference of its own. Rated `plausible`: no cited source grants the strand's
grounds and denies the step, but the bridge rests on Calvin's comment rather
than on an argument from John's vocabulary. -/
def calvinOnJohnSix : Source :=
  { primary := .work calvinJohn (.adLoc john6_29)
  , tradition := .reformedProtestant
  , confidence := .plausible }

/-- Aquinas's step: faith living through charity is not bare trust. Rated
`consensus`: Calvin concedes it — his trust is precisely a faith that brings
nothing — and the two divide over the premise, not the inference. -/
def aquinasOnFormedFaith : Source :=
  { primary := .work aquinasJohn (.sectionRef "cap. 6, lect. 3, n. 901")
  , tradition := .romanCatholic
  , confidence := .consensus }

/-- **The Johannine strand.** From the work God requires (6:28–29), and eternal
life through believing (3:16–18, 3:36, 5:24, 20:31), to justification by faith
alone — by way of the reading of that believing as trust. -/
def johannineToFaithAlone : Formula Claim :=
  ⋀ [p .john6_29WorkIsBelieving, p .johnLifeThroughBelieving, p .johannineBelievingIsTrust]
    ➝ p .justificationByFaithAlone

/-- The Johannine line. Its texts are its own grounds, not shared prooftexts,
because the strand is not yet part of `reformed`. -/
def johannineLine : Line Claim :=
  { name := "Johannine strand (John 6:29)"
  , grounds :=
      [p .john6_29WorkIsBelieving, p .johnLifeThroughBelieving, p .johannineBelievingIsTrust]
  , step := johannineToFaithAlone
  , delivers := p .justificationByFaithAlone
  , inference := some calvinOnJohnSix }

/-- **Aquinas's line.** The believing of 6:29 is faith living through charity,
and so not the bare trust the strand needs. The denial is derived, not assumed:
it follows from Aquinas's own reading of the verse. -/
def thomistLine : Line Claim :=
  { name := "Faith formed by charity (Aquinas on John 6:29)"
  , grounds := [p .johannineBelievingIsFormedByCharity]
  , step := p .johannineBelievingIsFormedByCharity ➝ notP .johannineBelievingIsTrust
  , delivers := notP .johannineBelievingIsTrust
  , inference := some aquinasOnFormedFaith }

/-! ### The packages -/

/-- Sola fide from John alone: the Johannine line, with the grounds and closing
steps every Reformed strand shares. -/
def johannineCase : ArgumentPackage Claim :=
  { reformed with
    name := "Sola fide from John (6:28–29)"
    premises := caseOf [johannineLine] sharedGrounds closingSteps }

/-- Aquinas on John: every text the Johannine strand reads, and every shared
ground, with its believing read as faith formed by charity. The rival the strand
is written against. -/
def thomistOnJohn : ArgumentPackage Claim :=
  { reformed with
    name := "Aquinas on John 6:29 (faith formed by charity)"
    premises :=
      caseOf
        [ johannineLine.onGrounds [p .john6_29WorkIsBelieving, p .johnLifeThroughBelieving]
        , thomistLine ]
        sharedGrounds closingSteps }

/-! ### Results -/

/-- **John alone delivers sola fide.** Grant that the believing of 6:29 is
trust, and the work God requires is no work at all: sola fide follows from John
without Paul, Luke or Acts. -/
@[headline]
theorem johannine_strand_establishes : Establishes johannineCase := by
  establish [johannineCase, reformed, johannineLine, johannineToFaithAlone, sharedGrounds,
    prooftexts, jamesLine, closingSteps, jamesHarmonisation, toGrace, toNotByWorks,
    toThroughFaith, conclusionSteps, solaFide, graceNotWorks]

#print axioms johannine_strand_establishes

/-- Aquinas's world: every text holds, and the believing of 6:29 is faith living
through charity — so not bare trust, not faith alone, and salvation is not
received through faith alone. Grace and "not by works" still hold: Aquinas
excludes external works, and grants that faith is God's gift. -/
def thomistReading : Valuation Claim := fun a =>
  match a with
  | .johannineBelievingIsTrust => False
  | .justificationByFaithAlone => False
  | .salvationThroughFaith => False
  | _ => True

/-- **The Johannine strand rests on believing as trust.** Grant Aquinas every
text the strand reads, and read their believing as he does — faith living
through charity — and sola fide no longer follows. So John's Gospel, like
Paul's Galatians and Luke's σῴζω, carries the conclusion only through a reading:
here, of what it is to believe *in* him. -/
@[headline]
theorem johannine_strand_rests_on_believing_as_trust : ¬ Establishes thomistOnJohn := by
  refute_with thomistReading [thomistOnJohn, reformed, johannineLine, thomistLine,
    Line.onGrounds, johannineToFaithAlone, sharedGrounds, prooftexts, jamesLine, closingSteps,
    jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
    graceNotWorks]

#print axioms johannine_strand_rests_on_believing_as_trust

/-- The Johannine case has a model, so `johannine_strand_establishes` is not
vacuous. -/
theorem johannineCase_is_satisfiable : Satisfiable johannineCase.premises := by
  satisfied_by everythingHoldsReading [johannineCase, reformed, johannineLine,
    johannineToFaithAlone, sharedGrounds, prooftexts, jamesLine, closingSteps,
    jamesHarmonisation, toGrace, toNotByWorks, toThroughFaith, conclusionSteps, solaFide,
    graceNotWorks]

/-! ### Luther's answer -/

/-- Luther's step, on Galatians 3:11–12: the law commands charity, and the law
is not of faith, so faith formed by charity would justify by the law. Rated
`disputed`: Aquinas grants both grounds — the text, and that the law commands
love — and denies the conclusion, holding that justifying faith is formed by
charity. -/
def lutherOnGalatiansThree : Source :=
  { primary := .work lutherGalatians (.adLoc ⟨.galatians, 3, 12⟩)
  , supporting := [.work lutherGalatians (.adLoc ⟨.galatians, 3, 11⟩)]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- **Luther's line.** From Galatians 3:11–12 and the law's command of love to
the denial of Aquinas's reading: the believing that justifies is not faith formed
by charity, since charity is what the law commands and the law is not of
faith. -/
def lutherLine : Line Claim :=
  { name := "Luther on Galatians 3:11–12 (against faith formed by charity)"
  , grounds := [p .gal3_11_12LawIsNotOfFaith, p .lawCommandsCharity]
  , step :=
      ⋀ [p .gal3_11_12LawIsNotOfFaith, p .lawCommandsCharity]
        ➝ notP .johannineBelievingIsFormedByCharity
  , delivers := notP .johannineBelievingIsFormedByCharity
  , inference := some lutherOnGalatiansThree }

/-- Luther's answer to Aquinas as an argument: what Aquinas grants, with
Luther's step, against the reading of 6:29 as faith formed by charity. -/
def lutherOnGalatians : ArgumentPackage Claim :=
  lutherLine.asPackage baseCite "the believing of John 6:29 is not faith formed by charity"

/-- The same grounds without Luther's step: Galatians 3:11–12, and that the law
commands love. -/
def galatiansTextsAlone : ArgumentPackage Claim :=
  { lutherOnGalatians with
    name := "Galatians 3:11–12 and the law's command of love, without Luther's step"
    premises := lutherLine.grounds }

/-- **Luther answers Aquinas from Galatians 3.** Grant what Aquinas grants —
Galatians 3:11–12, and that the law commands love — and Luther's step, and the
believing of John 6:29 is not faith formed by charity: a faith that justified
because charity formed it would justify by the law, and the law is not of faith.
What this removes is Aquinas's reading; it does not by itself establish
Calvin's. -/
@[headline]
theorem luther_answers_aquinas_from_galatians : Establishes lutherOnGalatians := by
  establish [lutherOnGalatians, lutherLine, Line.asPackage, Line.premises]

#print axioms luther_answers_aquinas_from_galatians

/-- **Luther's answer rests on his step.** The texts alone do not exclude
Aquinas's reading: in Aquinas's world Galatians 3:11–12 holds, the law commands
love, and the believing of 6:29 is faith formed by charity. What decides it is
whether faith formed by charity counts as justification "by the law" — Luther's
step, which Aquinas denies. -/
@[headline]
theorem luther_answer_rests_on_his_step : ¬ Establishes galatiansTextsAlone := by
  refute_with thomistReading [galatiansTextsAlone, lutherOnGalatians, lutherLine,
    Line.asPackage]

#print axioms luther_answer_rests_on_his_step

/-- The Reformed world, in which the believing of John 6:29 is not faith formed
by charity, and everything else holds. -/
def lutherReading : Valuation Claim := fun a =>
  match a with
  | .johannineBelievingIsFormedByCharity => False
  | _ => True

/-- Luther's package has a model, so `luther_answers_aquinas_from_galatians` is
not vacuous. -/
theorem lutherOnGalatians_is_satisfiable : Satisfiable lutherOnGalatians.premises := by
  satisfied_by lutherReading [lutherOnGalatians, lutherLine, Line.asPackage, Line.premises]

end Testimony.Arguments.SolaFide
