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

## John 3:36

"Whoever does not obey the Son shall not see life" (John 3:36) is treated in a
section of its own at the end of this page. In short: the commentators cited
read "does not obey" as unbelief seen in what it does; Chrysostom, on the same
verse, denies that believing is enough without a right life; and the wording
of the verse does not decide between them.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### The lines -/

/-- Aquinas's step: faith made alive by love is not bare trust. Rated `consensus`:
Calvin accepts it, since the trust he means is exactly a faith that brings
nothing. The two divide over the premise, not the step. -/
def aquinasOnFormedFaith : Source :=
  { primary := .work aquinasJohn (.sectionRef "cap. 6, lect. 3, n. 901")
  , tradition := .romanCatholic
  , confidence := .consensus }

/-- **Aquinas's line of argument.** The believing of 6:29 is faith made alive by
love, and so not the bare trust that John's strand needs. The denial is derived
from Aquinas's own reading of the verse, not assumed. -/
@[solaFideDefs]
def thomistLine : Line Claim :=
  { name := "Faith formed by charity (Aquinas on John 6:29)"
  , grounds := [p .johannineBelievingIsFormedByCharity]
  , step := p .johannineBelievingIsFormedByCharity ➝ notP .johannineBelievingIsTrust
  , delivers := notP .johannineBelievingIsTrust
  , inference := some aquinasOnFormedFaith }

/-! ### The packages -/

/-- Sola fide from John alone: John's line, with the premises and closing steps
every Reformed strand shares. -/
@[solaFideDefs]
def johannineCase : ArgumentPackage Claim :=
  { reformed with
    name := "Sola fide from John (6:28–29)"
    premises := caseOf [johannineLine] sharedGrounds closingSteps }

/-- Aquinas on John: every text John's strand reads, and every shared premise, with
the believing read as faith formed by charity. This is the rival John's strand
was written against. -/
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

/-- Aquinas's reading, written out. Every text holds. The believing of 6:29 is faith
made alive by love, so it is not bare trust; justification is not by faith
alone; and faith without charity does not suffice. Grace and "not by works"
still hold: Aquinas excludes outward works, and grants that faith is God's gift. -/
def thomistReading : Valuation Claim := fun a =>
  match a with
  | .johannineBelievingIsTrust => False
  | .justificationByFaithAlone => False
  | .faithIsSufficient => False
  | .salvationThroughFaith => False
  | _ => True

/-- **John's strand depends on reading believing as trust.** Grant Aquinas every
text the strand reads, and read their believing as he does, faith made alive by
love, and sola fide no longer follows.

So John's Gospel, like Paul's Galatians and Luke 7:50, reaches the conclusion
only through a reading: here, of what it is to believe *in* him. -/
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

/-- The Reformed reading with one concession: the believing of John 6:29 is not bare
trust, and everything else holds. -/
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

/-- John's case can be held without contradiction, so `johannine_strand_establishes`
is not true merely because its premises could never all hold. -/
theorem johannineCase_is_satisfiable : Satisfiable johannineCase.premises := by
  satisfied_by everythingHoldsReading [solaFideDefs]

/-! ### Luther's answer -/

/-- Luther's step, on Galatians 3:11–12: the law commands love, and the law is not
of faith, so faith formed by charity would justify by the law. Rated `disputed`:
Aquinas accepts both starting points, the text and that the law commands love,
and denies the conclusion, holding that the faith which justifies is formed by
charity. -/
def lutherOnGalatiansThree : Source :=
  { primary := .work lutherGalatians (.adLoc ⟨.galatians, 3, 12⟩)
  , supporting := [.work lutherGalatians (.adLoc ⟨.galatians, 3, 11⟩)]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- **Luther's line of argument.** From Galatians 3:11–12 and the law's command of
love to the denial of Aquinas's reading: the believing that justifies is not
faith formed by charity, since love is what the law commands and the law is not
of faith. -/
@[solaFideDefs]
def lutherLine : Line Claim :=
  { name := "Luther on Galatians 3:11–12 (against faith formed by charity)"
  , grounds := [p .gal3_11_12LawIsNotOfFaith, p .lawCommandsCharity]
  , step :=
      ⋀ [p .gal3_11_12LawIsNotOfFaith, p .lawCommandsCharity]
        ➝ notP .johannineBelievingIsFormedByCharity
  , delivers := notP .johannineBelievingIsFormedByCharity
  , inference := some lutherOnGalatiansThree }

/-- Luther's answer to Aquinas as a position: what Aquinas grants, with Luther's
step, against reading the believing of 6:29 as faith formed by charity. -/
@[solaFideDefs]
def lutherOnGalatians : ArgumentPackage Claim :=
  lutherLine.asPackage baseCite "the believing of John 6:29 is not faith formed by charity"

/-- The same starting points without Luther's step: Galatians 3:11–12, and that the
law commands love. -/
@[solaFideDefs]
def galatiansTextsAlone : ArgumentPackage Claim :=
  { lutherOnGalatians with
    name := "Galatians 3:11–12 and the law's command of love, without Luther's step"
    premises := lutherLine.grounds }

/-- **Luther answers Aquinas from Galatians 3.** Grant what Aquinas grants,
Galatians 3:11–12 and that the law commands love, and grant Luther's step. Then
the believing of John 6:29 is not faith formed by charity: a faith that
justified because love formed it would justify by the law, and the law is not of
faith.

What this does not claim: that Calvin's reading is thereby established. It
removes Aquinas's reading, and only if the step is granted. -/
@[headline]
theorem luther_answers_aquinas_from_galatians : Establishes lutherOnGalatians := by
  establish [solaFideDefs]

#print axioms luther_answers_aquinas_from_galatians

/-- **Luther's answer depends on his step.** The texts alone do not exclude
Aquinas's reading. On Aquinas's reading Galatians 3:11–12 holds, the law
commands love, and the believing of 6:29 is faith formed by charity. What
decides it is whether faith formed by charity counts as justification "by the
law". That is Luther's step, and Aquinas denies it. -/
@[headline]
theorem luther_answer_rests_on_his_step : ¬ Establishes galatiansTextsAlone := by
  refute_with thomistReading [solaFideDefs]

#print axioms luther_answer_rests_on_his_step

/-- The Reformed reading, on which the believing of John 6:29 is not faith formed by
charity, and everything else holds. -/
def lutherReading : Valuation Claim := fun a =>
  match a with
  | .johannineBelievingIsFormedByCharity => False
  | _ => True

/-- Luther's position can be held without contradiction, so
`luther_answers_aquinas_from_galatians` is not true merely because its premises
could never all hold. -/
theorem lutherOnGalatians_is_satisfiable : Satisfiable lutherOnGalatians.premises := by
  satisfied_by lutherReading [solaFideDefs]

/-- **Why Luther's answer stands against Aquinas.** Everything turns on Luther's
step: from Galatians 3:11–12 and the law's command of love, the believing that
justifies is not faith formed by charity. With the two texts accepted, Aquinas's
reading of John 6:29 cannot keep its one distinctive premise, that the believing
is formed by charity.

Unlike the Reformed distinction against Trent, this step is part of Luther's own
case: without it, the texts do not deliver his conclusion. So the answer is
exactly as strong as the step, which is rated `disputed`. The step is Luther's,
and the texts are accepted by both sides. -/
def whyLutherAnswersAquinas : Because lutherOnGalatians thomistOnJohn :=
  Because.ofChecks lutherLine.step lutherLine.grounds [] lutherLine.grounds
    [p .johannineBelievingIsFormedByCharity] .derives
    luther_answers_aquinas_from_galatians lutherOnGalatians_is_satisfiable
    (by simp [lutherOnGalatians, Line.asPackage, Line.premises])
    (fun φ hφ => by simp [lutherOnGalatians, Line.asPackage, Line.premises, hφ])
    (by simp [solaFideDefs, caseOf, Line.onGrounds])
    (by decide +kernel)

/-! ### John 3:36: "whoever does not obey the Son"

"Whoever believes in the Son has eternal life; whoever does not obey the Son
shall not see life, but the wrath of God remains on him" (John 3:36). The verse
sets *not obeying* against *believing*. A reader may fairly ask whether
believing, in John, therefore includes obeying, and whether faith alone can then
be what saves.

Two things are on record, and they point in different directions.

**On the word.** The Greek for "does not obey" (ὁ ἀπειθῶν) is read by the
commentators cited here as unbelief seen in what it does. Westcott: "believeth
not] disobeyeth. Disbelief is regarded in its activity." Calvin's comment takes
the clause of "all who do not believe in Christ". No source has been found that
argues from this word that believing includes obeying.

**On the doctrine.** Chrysostom, preaching on this verse, does deny that
believing is enough: "'Is it then enough,' saith one, 'to believe on the Son,
that one may have eternal life?' By no means." He does not argue from the word.
He argues from Jesus' saying in Matthew 7:21, "Not everyone who says to me,
'Lord, Lord,' will enter the kingdom of heaven", and concludes: "though a man
believe rightly on the Father, the Son, and the Holy Ghost, yet if he lead not a
right life, his faith will avail nothing towards his salvation" (*Homilies on
John* 31).

Chrysostom's argument is written out as starting points, a step and a conclusion
(`chrysostomLine`). Its starting points are two texts every reader here accepts.
The step from them to "faith does not suffice" is his. Three things are checked.

- Granted his step, his conclusion follows
  (`chrysostom_reads_john3_36_against_faith_alone`).
- The wording of the two texts does not settle it. One consistent reading holds
  both texts and that faith suffices; another holds both and that it does not
  (`john3_36_leaves_faiths_sufficiency_open`).
- His conclusion, written out as "faith does not suffice", and John's strand
  cannot both be held (`chrysostom_cannot_be_held_with_johns_case`). Whether the
  faith he means is the faith the Reformers mean is a further question, noted at
  that result.

The step is rated `disputed`. Calvin accepts both texts and denies the
conclusion: he reads the doing of Matthew 7:21 as including faith, and good
works as what follows faith.

**What is not done here.** Chrysostom's case is not a party to the main sola
fide dispute. His conclusion is general, so there it would stand against Luke's
case, Paul's and Peter's as well as John's, and that is a change to that
dispute's results which should be made and reported by itself. The modern
commentaries on John 3:36 (Brown, Schnackenburg, Barrett, Carson) have not been
read, and neither has the standard lexicon (BDAG) on the word. -/

/-- Chrysostom's step, in Homily 31 on John: from John 3:36 and Matthew 7:21 to
"faith alone is not sufficient to salvation". Rated `disputed`: Calvin accepts
both texts and denies the conclusion. -/
def chrysostomOnJohnThreeThirtySix : Source :=
  { primary := .work chrysostomHomiliesJohn (.sectionRef "Homily 31, §1")
  , tradition := .easternOrthodox
  , confidence := .disputed }

/-- **Chrysostom's line.** From "whoever does not obey the Son shall not see
life" (John 3:36) and "not everyone who says to me, 'Lord, Lord'" (Matthew
7:21) to the conclusion that believing does not suffice without a right life. -/
@[solaFideDefs]
def chrysostomLine : Line Claim :=
  { name := "Chrysostom on John 3:36 (believing is not enough without a right life)"
  , grounds := [p .john3_36WhoeverDoesNotObey, p .matthew7_21_23DoingTheWill]
  , step :=
      ⋀ [p .john3_36WhoeverDoesNotObey, p .matthew7_21_23DoingTheWill]
        ➝ notP .faithIsSufficient
  , delivers := notP .faithIsSufficient
  , inference := some chrysostomOnJohnThreeThirtySix }

/-- Chrysostom's argument as a position: the two texts, with his step. -/
@[solaFideDefs]
def chrysostomOnJohn : ArgumentPackage Claim :=
  chrysostomLine.asPackage baseCite "believing does not suffice without a right life"

/-- **Granted his step, Chrysostom's conclusion follows.** From John 3:36 and
Matthew 7:21, read as he reads them, believing does not suffice for salvation
without a right life.

What this claims: his argument is valid, and its premises are two texts nobody
here disputes. What it does not claim: that the step is sound. Calvin accepts
both texts and denies it, so the step is rated `disputed`. -/
@[headline]
theorem chrysostom_reads_john3_36_against_faith_alone : Establishes chrysostomOnJohn := by
  establish [solaFideDefs]

#print axioms chrysostom_reads_john3_36_against_faith_alone

/-- Chrysostom's position can be held without contradiction, on Aquinas's reading,
where every text holds and faith without charity does not suffice. So
`chrysostom_reads_john3_36_against_faith_alone` is not true merely because its
premises could never all hold. -/
theorem chrysostomOnJohn_is_satisfiable : Satisfiable chrysostomOnJohn.premises := by
  satisfied_by thomistReading [solaFideDefs]

/-- **The wording of John 3:36 and Matthew 7:21 leaves open whether faith
suffices.** One consistent reading holds both texts and that faith suffices: the
Reformed one, on which not obeying the Son is refusing to believe him. Another
holds both texts and that faith does not suffice: Chrysostom's and Aquinas's.

What this claims: neither side can settle the question by pointing at the
words. What it does not claim: that the two readings are equally good. That is
a matter for the sources, and the page reports what they say. -/
@[headline]
theorem john3_36_leaves_faiths_sufficiency_open :
    Independent [p Claim.john3_36WhoeverDoesNotObey, p .matthew7_21_23DoingTheWill]
      (p .faithIsSufficient) := by
  leaves_open thomistReading everythingHoldsReading [solaFideDefs]

#print axioms john3_36_leaves_faiths_sufficiency_open

/-- John's strand and Chrysostom's argument, held together: every premise of
each. -/
@[solaFideDefs]
def johnWithChrysostom : List (Formula Claim) :=
  johannineCase.premises ++ chrysostomOnJohn.premises

/-- **Chrysostom's conclusion and John's strand cannot both be held.** John's strand
concludes that justification is by faith alone, and so that faith suffices.
Chrysostom concludes that it does not. No consistent reading holds every premise
of both.

What this claims: a reader has to choose between Calvin's reading of John and
Chrysostom's conclusion as written out here. What it does not claim: which to
choose. Each rests on a step rated `disputed`.

Nor does it claim that the faith Chrysostom speaks of, right belief without a
right life, is the faith the Reformers say justifies. His conclusion is written
out here as "faith does not suffice". A reader who takes him to deny only what
James calls dead faith (see the section on James) need not choose. -/
@[headline]
theorem chrysostom_cannot_be_held_with_johns_case : ¬ Satisfiable johnWithChrysostom :=
  not_satisfiable_of_check (by decide +kernel)

#print axioms chrysostom_cannot_be_held_with_johns_case

end TestimonyArguments.SolaFide
