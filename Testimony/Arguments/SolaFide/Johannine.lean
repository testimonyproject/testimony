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

end Testimony.Arguments.SolaFide
