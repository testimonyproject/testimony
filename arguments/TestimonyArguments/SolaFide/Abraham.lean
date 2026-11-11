import TestimonyArguments.SolaFide.Verdict
import TestimonyArguments.SolaFide.James

/-!
# TestimonyArguments.SolaFide.Abraham — Abraham, counted righteous

Paul's chief witness for justification by faith is not a verse of his own but a
sentence from the story of Abraham:

> "And he believed the LORD, and he counted it to him as righteousness" (Genesis
> 15:6).

Paul quotes it in Romans 4 and in Galatians 3. And he presses a point of
timing:

> "How then was it counted to him? Was it before or after he had been
> circumcised? It was not after, but before he was circumcised" (Romans 4:10).

## What happens next in Genesis 15

The rest of the chapter is a covenant ceremony, and it is a strange one. God
tells Abram to cut animals in two and lay the halves opposite each other. Then:

> "As the sun was going down, a deep sleep fell on Abram. And behold, dreadful
> and great darkness fell upon him" (Genesis 15:12).

> "When the sun had gone down and it was dark, behold, a smoking fire pot and a
> flaming torch passed between these pieces" (Genesis 15:17).

Jeremiah shows what walking between the pieces meant. Those who broke a covenant
would be made "like the calf that they cut in two and passed between its parts"
(Jeremiah 34:18): whoever passed through called that fate down on himself if he
broke his word. In Genesis 15 only the fire and the torch pass through, and Abram
is asleep. The letter to the Hebrews draws the conclusion: "when God made a
promise to Abraham, since he had no one greater by whom to swear, he swore by
himself" (Hebrews 6:13).

On this reading the covenant binds God alone, and nothing Abram does is a
condition of the promise that was counted to him. Reformed readers of the
covenants read it so: O. Palmer Robertson and Meredith Kline, and Gordon Wenham
in his commentary on Genesis. Moshe Weinfeld, comparing the covenants of the
ancient Near East, set the covenant with Abraham beside the royal grants that a
king gave and did not take back. None of the four has been read for this
chapter, so each is cited as a whole.

## The other way of reading Abraham

Genesis does not stop at chapter 15. When Abraham has offered Isaac, the angel
of the LORD says:

> "By myself I have sworn, declares the LORD, because you have done this and
> have not withheld your son, your only son, I will surely bless you"
> (Genesis 22:16–17).

And to Isaac: the blessing comes "because Abraham obeyed my voice and kept my
charge, my commandments, my statutes, and my laws" (Genesis 26:5).

Jewish writers before Paul read Genesis 15:6 in the light of Genesis 22.
1 Maccabees asks, in the Catholic Church's own translation (NABRE):

> "Was not Abraham found faithful in trial, and it was credited to him as
> righteousness?" (1 Maccabees 2:52).

Sirach says that "when tested [he] was found loyal" (44:20). The same
translation cross-refers the first to Genesis 15:6 and to Genesis 22, and
glosses the second as "Abraham's willingness to sacrifice his son Isaac". On this reading the
righteousness counted to Abraham is tied to his obedience under testing. James
draws on the same story: Abraham was "justified by works when he offered up his
son Isaac on the altar" (James 2:21).

These are not books of the Protestant canon, and nothing here treats them as
Scripture. They are witnesses to how Abraham was read in Paul's day, which is
why Paul argues as he does in Romans 4.

## What the checking finds

- **Granted the reading of the ceremony, Abraham was counted righteous with no
  work as a condition** (`genesisFifteen_establishes`).
- **Granted the reading tied to Genesis 22, he was not**
  (`secondTempleAbraham_establishes`). Both positions can be held without
  contradiction.
- **The texts of Genesis alone do not decide between them.** Genesis 15:6, the
  ceremony of 15:12–17, and Genesis 22:16–18 are kept alike by both readings
  (`genesis_leaves_abraham_open`). What decides is the reading of the ceremony,
  and that reading is rated `disputed`.

The Reformed answer to Genesis 22 is the answer this library already gives to
James: Abraham's offering of Isaac shows the faith that was counted to him,
years before. And the chapter "Does justification have degrees?" adds a reason
of its own. If justification is a verdict, which has no degrees, then James's
"justified" at Genesis 22 cannot mean the *increase* of the justice Abraham
already had (`no_degrees_answers_james_on_abraham`). That reason rests, as
before, on the Reformed definition of justification, which Trent denies.

## What this does not show

It does not show that Abraham's obedience did not matter. Every reader cited
here holds that it did. The question is whether it was the condition of the
righteousness counted to him at Genesis 15:6, or its fruit. Nor does it show
that Trent denies the reading of the ceremony: Trent holds that "none of those
things which precede justification, whether faith or works, merit the grace
itself of justification" (Session VI, ch. 8). Its disagreement is over what
follows.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic

/-! ### The reading tied to Genesis 22, written out first -/

/-- The Second Temple reading's step: Abraham was "found faithful in trial, and it
was credited to him as righteousness" (1 Maccabees 2:52, NABRE), so the counting of
Genesis 15:6 is tied to his obedience in Genesis 22, and was not without works.
Rated `disputed`: Paul accepts Genesis 15:6 and argues the opposite from its
timing (Romans 4:10). -/
def secondTempleOnAbrahamSource : Source :=
  { primary := .work nabre (.adLoc ⟨.firstMaccabees, 2, 52⟩)
  , supporting := [.work nabre (.adLoc ⟨.sirach, 44, 20⟩)]
  , tradition := .secondTempleJewish
  , confidence := .disputed }

/-- **Abraham, read from his testing.** From Genesis 15:6 and 22:16–18, with 1
Maccabees 2:52 and Sirach 44:20, the righteousness counted to Abraham is tied to
his obedience when tested. -/
@[solaFideDefs]
def secondTempleAbrahamLine : Line Claim :=
  { name := "Abraham found faithful when tested (1 Maccabees 2:52; Sirach 44:20)"
  , grounds :=
      [p .gen15_6AbramBelieved, p .gen22_16BecauseYouObeyed, p .abrahamFoundFaithfulWhenTested]
  , step :=
      ⋀ [p .gen15_6AbramBelieved, p .gen22_16BecauseYouObeyed, p .abrahamFoundFaithfulWhenTested]
        ➝ notP .abrahamCountedRighteousWithoutWorks
  , delivers := notP .abrahamCountedRighteousWithoutWorks
  , inference := some secondTempleOnAbrahamSource }

/-- **The reading tied to Genesis 22**, as a position. -/
@[solaFideDefs]
def secondTempleAbraham : ArgumentPackage Claim :=
  { name := "Abraham, counted righteous when tested"
  , cite := baseCite
  , premises := secondTempleAbrahamLine.premises
  , conclusion := notP .abrahamCountedRighteousWithoutWorks
  , conclusionLabel := "Abraham was not counted righteous without works"
  , inferences := [secondTempleOnAbrahamSource] }

/-! ### The reading of the ceremony -/

/-- The Reformed step: Abraham believed and it was counted to him (Genesis 15:6),
before he was circumcised (Romans 4:10), and the covenant that followed bound God
alone (15:12–17). So nothing he did was a condition of what was counted to him.
Rated `disputed`, because the reading of the ceremony it rests on is. -/
def genesisFifteenSource : Source :=
  { primary := .scripture [{ ref := .range ⟨.romans, 4, 3, 4, 12⟩ }]
  , supporting :=
      [ .work robertsonChristOfTheCovenants .whole, .work klineKingdomPrologue .whole ]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- **Abraham, read from the ceremony.** From Genesis 15:6, Romans 4:10, the
ceremony of Genesis 15:12–17 and the reading of it as God's oath alone, Abraham
was counted righteous with no work as a condition. -/
@[solaFideDefs]
def genesisFifteenLine : Line Claim :=
  { name := "Abraham, counted righteous before the covenant's sign (Genesis 15; Romans 4)"
  , grounds :=
      [ p .gen15_6AbramBelieved, p .romans4_10BeforeCircumcision, p .gen15_17GodAlonePasses
      , p .gen15CovenantIsGodsOathAlone ]
  , step :=
      ⋀ [ p .gen15_6AbramBelieved, p .romans4_10BeforeCircumcision, p .gen15_17GodAlonePasses
        , p .gen15CovenantIsGodsOathAlone ] ➝ p .abrahamCountedRighteousWithoutWorks
  , delivers := p .abrahamCountedRighteousWithoutWorks
  , inference := some genesisFifteenSource }

/-- **The reading of the ceremony**, as a position. -/
@[solaFideDefs]
def genesisFifteen : ArgumentPackage Claim :=
  { name := "Abraham, counted righteous by God's oath alone"
  , cite := baseCite
  , premises := genesisFifteenLine.premises
  , conclusion := p .abrahamCountedRighteousWithoutWorks
  , conclusionLabel := "Abraham was counted righteous with no work as a condition"
  , inferences := [genesisFifteenSource] }

/-! ### Genesis 22, and degrees -/

/-- The step from James's word to degrees: if James's "justified" at Genesis 22
means the increase of the justice Abraham already had, then justification has
degrees. Rated `consensus`: it is what "increase" says. -/
def jamesIncreaseMeansDegreesSource : Source :=
  { primary := .work waterworthTrent (.page 37)
  , tradition := .romanCatholic
  , confidence := .consensus }

/-- **James's increase, as degrees.** If James's "justified" means an increase of
justice, justification has degrees. -/
@[solaFideDefs]
def jamesIncreaseMeansDegreesLine : Line Claim :=
  { name := "James's increase, as degrees"
  , grounds := [p .jamesJustifyDenotesIncrease]
  , step := p .jamesJustifyDenotesIncrease ➝ p .justificationHasDegrees
  , delivers := p .justificationHasDegrees
  , inference := some jamesIncreaseMeansDegreesSource }

/-- **The verdict position, on James at Genesis 22.** The Reformed position on
degrees, with what an increase in James's word would mean. It concludes that
James's "justified" does not mean an increase of justice. -/
@[solaFideDefs]
def verdictOnJamesIncrease : ArgumentPackage Claim :=
  { verdictOnDegrees with
    name := "Justification as a verdict, on James at Genesis 22"
    premises := verdictOnDegrees.premises ++ [jamesIncreaseMeansDegreesLine.step]
    conclusion := notP .jamesJustifyDenotesIncrease
    conclusionLabel := "James's 'justified' is not an increase of justice"
    inferences := verdictOnDegrees.inferences ++ [jamesIncreaseMeansDegreesSource] }

/-! ### The readings -/

/-- The reading of the ceremony: every text holds, the covenant binds God alone,
and Abraham was counted righteous with no work as a condition. The reading tied
to his testing, from 1 Maccabees and Sirach, is not held. -/
def genesisFifteenReading : Valuation Claim := fun a =>
  match a with
  | .abrahamFoundFaithfulWhenTested => False
  | .justificationHasDegrees => False
  | .worksMeritIncreaseOfJustification => False
  | .jamesJustifyDenotesIncrease => False
  | .justificationIncludesSanctification => False
  | _ => True

/-- The reading tied to Genesis 22: every text holds, and the righteousness
counted to Abraham is tied to his testing. The reading of the ceremony as God's
oath alone is not held. -/
def secondTempleAbrahamReading : Valuation Claim := fun a =>
  match a with
  | .abrahamCountedRighteousWithoutWorks => False
  | .gen15CovenantIsGodsOathAlone => False
  | _ => True

/-! ### Results -/

/-- **Read from the ceremony, Abraham was counted righteous with no work as a
condition.** Genesis 15:6, Romans 4:10, the ceremony of Genesis 15:12–17, and the
reading of it as God's oath alone.

What this does not claim: that the reading of the ceremony is beyond dispute. It
is rated `disputed`, and Genesis 22 is read the other way. -/
@[headline]
theorem genesisFifteen_establishes : Establishes genesisFifteen := by
  establish [solaFideDefs]

#print axioms genesisFifteen_establishes

/-- The reading of the ceremony can be held without contradiction. -/
theorem genesisFifteen_is_satisfiable : Satisfiable genesisFifteen.premises := by
  satisfied_by genesisFifteenReading [solaFideDefs]

/-- **Read from his testing, Abraham was not counted righteous without works.**
Genesis 15:6 and 22:16–18, with 1 Maccabees 2:52 and Sirach 44:20.

What this does not claim: that 1 Maccabees or Sirach is Scripture. They are
witnesses to how Abraham was read before Paul. -/
@[headline]
theorem secondTempleAbraham_establishes : Establishes secondTempleAbraham := by
  establish [solaFideDefs]

#print axioms secondTempleAbraham_establishes

/-- The reading tied to Genesis 22 can be held without contradiction. -/
theorem secondTempleAbraham_is_satisfiable : Satisfiable secondTempleAbraham.premises := by
  satisfied_by secondTempleAbrahamReading [solaFideDefs]

/-- **The texts of Genesis alone do not decide.** Genesis 15:6, the ceremony of
15:12–17, and Genesis 22:16–18 are kept alike by the reading of the ceremony, on
which Abraham was counted righteous with no work as a condition, and by the
reading tied to his testing, on which he was not. -/
@[headline]
theorem genesis_leaves_abraham_open :
    Independent
      [p Claim.gen15_6AbramBelieved, p .gen15_17GodAlonePasses, p .gen22_16BecauseYouObeyed]
      (p .abrahamCountedRighteousWithoutWorks) := by
  leaves_open secondTempleAbrahamReading genesisFifteenReading [solaFideDefs]

#print axioms genesis_leaves_abraham_open

/-- **If justification has no degrees, James's "justified" at Genesis 22 is not an
increase.** On the Reformed position on degrees, Abraham's being "justified by
works when he offered up his son Isaac" (James 2:21) cannot mean the increase of
the justice he already had. That leaves the Reformed reading of James's word,
"shown to be righteous".

What this does not claim: that justification has no degrees. That rests on the
Reformed definition, which Trent denies (`degrees_turn_on_the_definition`). -/
@[headline]
theorem no_degrees_answers_james_on_abraham : Establishes verdictOnJamesIncrease := by
  establish [solaFideDefs]

#print axioms no_degrees_answers_james_on_abraham

/-- The verdict position on James at Genesis 22 can be held without contradiction. -/
theorem verdictOnJamesIncrease_is_satisfiable :
    Satisfiable verdictOnJamesIncrease.premises := by
  satisfied_by genesisFifteenReading [solaFideDefs]

end TestimonyArguments.SolaFide
