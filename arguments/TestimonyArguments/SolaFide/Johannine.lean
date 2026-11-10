import TestimonyArguments.SolaFide.Results
import Testimony.Logic.Because

/-!
# TestimonyArguments.SolaFide.Johannine — "this is the work of God, that you believe"

The fourth strand of sola fide comes from John's Gospel. A crowd asks Jesus,
"What must we do, to be doing the works of God?" He answers: "This is the work
of God, that you believe in him whom he has sent" (John 6:28–29). The question
is about works, and the answer is believing.

John says the same elsewhere. Whoever believes in the Son has eternal life and
does not come into judgement (3:16–18, 3:36, 5:24), and the Gospel gives this as
its own purpose: "that by believing you may have life in his name" (20:31).

## What both sides grant, and where they part

Nobody in this dispute denies the verse. They differ on what its believing is.

- **Calvin** reads it as trust. Christ calls faith a work only loosely: faith
  "brings nothing to God, but, on the contrary, places man before God as empty
  and poor, that he may be filled with Christ". It is "a passive work, to which
  no reward can be paid".
- **Aquinas** reads it as faith formed by charity, that is, faith made alive by
  love. He takes Paul to distinguish faith "only from external works", so that
  believing is itself an inward work. To believe *in* him, as the goal one
  moves toward, "is proper to faith
  living through the love of charity", and such faith "is the principle of all
  our good works" (*Super Ioannem* 6, lect. 3, n. 901). The Council of Trent
  describes justifying faith the same way: without hope and charity, faith
  "neither unites man perfectly with Christ, nor makes him a living member of
  His body" (Session VI, ch. 7).

So this strand has the shape of the other three: texts everyone accepts, and
one reading on which the conclusion turns. On Calvin's reading John supplies
faith alone without the readings the other strands depend on
(`johannine_strand_establishes`).
On Aquinas's it does not (`johannine_strand_rests_on_believing_as_trust`).

## John has no word for "justify"

Paul's verb for "justify" (δικαιόω) does not occur in John's Gospel. So the
strand has to step from "eternal life through believing" to "justified by faith
alone", and that step is an inference, not the meaning of a word. It is cited to
Calvin, whose comment on 6:29 speaks of the righteousness faith receives from
Christ. It is rated `plausible`. No cited source accepts the strand's premises
and rejects the step, but no cited source argues the step at length either.

## Luther's answer to Aquinas

Luther, in his own lectures on Galatians, answers the reading Aquinas gives of
John 6:29. He names "the scholastics", not Aquinas; the faith formed by charity
that he attacks is the reading Aquinas gives. On 3:11:
"The scholastics misconstrue this passage by saying: 'The just shall live by
faith, if it is a working faith, or a faith formed and performed by charitable
works.' … To speak of formed or unformed faith, a sort of double faith, is
contrary to the Scriptures." On 3:12: "Does not the Law command charity? … If
the law requires charity, charity is part of the Law and not of faith."

His argument runs: love is what the law commands, and "the law is not of faith"
(Galatians 3:12), so a faith that justifies because love forms it would justify
by the law after all.

The argument is encoded as a line of its own (`lutherLine`). Its two starting
points are ones Aquinas accepts: the text of Galatians 3:11–12, and that love of
God and neighbour is what the law commands (Deuteronomy 6:5). The step from them
is Luther's. Grant the step, and Aquinas's reading of John 6:29 falls
(`luther_answers_aquinas_from_galatians`). Without the step the texts do not
exclude his reading (`luther_answer_rests_on_his_step`). The step is rated
`disputed`, because Aquinas accepts both starting points and rejects the
conclusion. His reason for rejecting it is not yet cited here.

Two limits. Removing Aquinas's reading does not establish Calvin's: "not formed
by charity" is a weaker claim than "trust". And the Catholic reply rests on
Galatians 5:6, "faith working through love", which Trent cites (Session VI,
ch. 7). How Luther and Calvin read that verse is not yet encoded.

Calvin makes a neighbouring argument in the *Institutes* (III.xi.19), against
those who "pretend that the works excluded are ceremonial, not moral works". He
cites Galatians 3:10 and 3:12 and concludes that "the whole Law is spoken of
when the power of justifying is denied to it". That answers those who say Paul
excludes only ceremonial works. Aquinas does not say that. He says believing is
an inward work, formed by love. So Luther's argument, and not Calvin's, is the
one that addresses him.

## Where the strand stands in the whole dispute

The strand is one of the four strands of the Reformed case, and John's case,
Aquinas's and Luther's are parties to the sola fide dispute. Three things are
checked.

- **John supplies "through faith" without the other three strands.** Leave out
  the disputed readings in Paul, Luke and Acts. Keep what every strand shares:
  the verses on grace and works, and the answer to James. Sola fide still
  follows, with John 6:28–29 as the only route to faith
  (`johannine_strand_survives_the_other_three`).
- **John's disputed reading is not one the whole case depends on.** Grant
  Aquinas his reading of 6:29, keep the other three strands, and sola fide still
  follows (`believing_as_trust_not_load_bearing`).
- **John's case is not forced, and neither is any rival.** John's case and
  Aquinas's each defeat the other, that is, each contradicts the other and
  neither is better supported. So do Aquinas's and Luther's, John's and Trent's,
  and John's and the apocalyptic reading's. Each pair is a tie, because each
  side rests on a premise rated `disputed`.

## What is not encoded

At John 3:36 the opposite of "whoever believes" is, in Greek, "whoever does not
obey" (ὁ ἀπειθῶν). A reader could argue from that word that believing in John
includes obeying. No source that argues this from the word has been read and
verified. What has been found points the other way on the word and the same way
on the doctrine. Westcott's commentary and the older lexica take the word as
unbelief shown in action. Chrysostom, preaching on this verse, denies that
believing is enough without a right life, but he argues from Matthew 7:21 and
not from the verb. Neither is cited here yet, and the modern commentaries
(Brown, Schnackenburg, Barrett, Carson) have not been read. Until they are, this
reading is absent, and its absence is not evidence that nobody holds it.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### The lines -/

/-- Aquinas's step: faith living through charity is not bare trust. Rated
`consensus`: Calvin concedes it — his trust is precisely a faith that brings
nothing — and the two divide over the premise, not the inference. -/
def aquinasOnFormedFaith : Source :=
  { primary := .work aquinasJohn (.sectionRef "cap. 6, lect. 3, n. 901")
  , tradition := .romanCatholic
  , confidence := .consensus }

/-- **Aquinas's line.** The believing of 6:29 is faith living through charity,
and so not the bare trust the strand needs. The denial is derived, not assumed:
it follows from Aquinas's own reading of the verse. -/
@[solaFideDefs]
def thomistLine : Line Claim :=
  { name := "Faith formed by charity (Aquinas on John 6:29)"
  , grounds := [p .johannineBelievingIsFormedByCharity]
  , step := p .johannineBelievingIsFormedByCharity ➝ notP .johannineBelievingIsTrust
  , delivers := notP .johannineBelievingIsTrust
  , inference := some aquinasOnFormedFaith }

/-! ### The packages -/

/-- Sola fide from John alone: the Johannine line, with the grounds and closing
steps every Reformed strand shares. -/
@[solaFideDefs]
def johannineCase : ArgumentPackage Claim :=
  { reformed with
    name := "Sola fide from John (6:28–29)"
    premises := caseOf [johannineLine] sharedGrounds closingSteps }

/-- Aquinas on John: every text the Johannine strand reads, and every shared
ground, with its believing read as faith formed by charity. The rival the strand
is written against. -/
@[solaFideDefs]
def thomistOnJohn : ArgumentPackage Claim :=
  { reformed with
    name := "Aquinas on John 6:29 (faith formed by charity)"
    premises :=
      caseOf
        [ johannineLine.onGrounds [p .john6_29WorkIsBelieving, p .johnLifeThroughBelieving]
        , thomistLine ]
        sharedGrounds closingSteps }

/-! ### Results -/

/-- **John's strand, argued alone, delivers sola fide.** Grant that the
believing of 6:29 is trust, and the work God requires is believing, which earns
nothing. Sola fide then follows without the readings Paul's, Luke's and Peter's
strands depend on.

What this does not claim: that John 6:29 is the only text used. Grace and "not
by works" come from the verses every strand shares and from the answer to
James. -/
@[headline]
theorem johannine_strand_establishes : Establishes johannineCase := by
  establish [solaFideDefs]

#print axioms johannine_strand_establishes

/-- Aquinas's world: every text holds, and the believing of 6:29 is faith living
through charity — so not bare trust, not faith alone, and faith without
charity does not suffice. Grace and "not by works" still hold: Aquinas excludes
external works, and grants that faith is God's gift. -/
def thomistReading : Valuation Claim := fun a =>
  match a with
  | .johannineBelievingIsTrust => False
  | .justificationByFaithAlone => False
  | .faithIsSufficient => False
  | .salvationThroughFaith => False
  | _ => True

/-- **The Johannine strand rests on believing as trust.** Grant Aquinas every
text the strand reads, and read their believing as he does — faith living
through charity — and sola fide no longer follows. So John's Gospel, like
Paul's Galatians and Luke's σῴζω, carries the conclusion only through a reading:
here, of what it is to believe *in* him. -/
@[headline]
theorem johannine_strand_rests_on_believing_as_trust : ¬ Establishes thomistOnJohn := by
  refute_with thomistReading [solaFideDefs]

#print axioms johannine_strand_rests_on_believing_as_trust

/-- The Reformed case with Aquinas granted his reading of John 6:29: the
believing is faith formed by charity, and so not bare trust. The other three
strands are kept whole. -/
@[solaFideDefs]
def reformedGrantingAquinasOnJohn : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, granting Aquinas on John 6:29"
    premises :=
      caseOf [paulineLine, dominicalLine, apostolicLine, johannineWithoutTrust, thomistLine]
        sharedGrounds closingSteps }

/-- **The reading of believing as trust is not one the whole case depends on.**
Grant Aquinas that the believing of John 6:29 is faith formed by charity, keep
Paul, Luke and Acts as the Reformed read them, and sola fide still follows.

What this claims: losing the argument over John 6:29 costs the Reformed case one
strand and not its conclusion. What it does not claim: that Aquinas would accept
the rest. He would not, and the package is not his position; it is the Reformed
case with one concession made. -/
@[headline]
theorem believing_as_trust_not_load_bearing : Establishes reformedGrantingAquinasOnJohn := by
  establish [solaFideDefs]

#print axioms believing_as_trust_not_load_bearing

/-- The Reformed world with one concession: the believing of John 6:29 is not
bare trust, and everything else holds. -/
def concedingJohnReading : Valuation Claim := fun a =>
  match a with
  | .johannineBelievingIsTrust => False
  | _ => True

/-- That package can be held without contradiction, so
`believing_as_trust_not_load_bearing` is not true merely because its premises
could never all hold. -/
theorem reformedGrantingAquinasOnJohn_is_satisfiable :
    Satisfiable reformedGrantingAquinasOnJohn.premises := by
  satisfied_by concedingJohnReading [solaFideDefs]

/-- The Johannine case has a model, so `johannine_strand_establishes` is not
vacuous. -/
theorem johannineCase_is_satisfiable : Satisfiable johannineCase.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

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
@[solaFideDefs]
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
@[solaFideDefs]
def lutherOnGalatians : ArgumentPackage Claim :=
  lutherLine.asPackage baseCite "the believing of John 6:29 is not faith formed by charity"

/-- The same grounds without Luther's step: Galatians 3:11–12, and that the law
commands love. -/
@[solaFideDefs]
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
  establish [solaFideDefs]

#print axioms luther_answers_aquinas_from_galatians

/-- **Luther's answer rests on his step.** The texts alone do not exclude
Aquinas's reading: in Aquinas's world Galatians 3:11–12 holds, the law commands
love, and the believing of 6:29 is faith formed by charity. What decides it is
whether faith formed by charity counts as justification "by the law" — Luther's
step, which Aquinas denies. -/
@[headline]
theorem luther_answer_rests_on_his_step : ¬ Establishes galatiansTextsAlone := by
  refute_with thomistReading [solaFideDefs]

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
  satisfied_by lutherReading [solaFideDefs]

/-- **Why Luther's answer stands against Aquinas.** The crux is Luther's step:
from Galatians 3:11–12 and the law's command of love, the believing that
justifies is not faith formed by charity. With the two texts granted, Aquinas's
reading of John 6:29 cannot keep its one distinctive ground — that the believing
is formed by charity — and that ground alone breaks.

Unlike the Reformed distinction against Trent, this crux is part of Luther's
case: without the step, the texts do not deliver his conclusion. So the answer
is exactly as strong as the step, which is rated `disputed` — the step is
Luther's, and the texts are granted by both sides. -/
def whyLutherAnswersAquinas : Because lutherOnGalatians thomistOnJohn :=
  Because.ofChecks lutherLine.step lutherLine.grounds [] lutherLine.grounds
    [p .johannineBelievingIsFormedByCharity] .derives
    luther_answers_aquinas_from_galatians lutherOnGalatians_is_satisfiable
    (by simp [lutherOnGalatians, Line.asPackage, Line.premises])
    (fun φ hφ => by simp [lutherOnGalatians, Line.asPackage, Line.premises, hφ])
    (by simp [solaFideDefs, caseOf, Line.onGrounds])
    (by decide +kernel)

end TestimonyArguments.SolaFide
