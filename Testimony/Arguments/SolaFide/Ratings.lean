import Testimony.Arguments.SolaFide.Vulgate
import Testimony.Logic.Credibility

/-!
# Arguments.SolaFide.Ratings — which dissents from the James steps are critiques

A step is rated `disputed` when someone dissents from it. The reader's question
is the next one: **is the dissent an argument, or only a disagreement?** This
module asks it of the Roman Catholic dissents from two steps of the Reformed
reading of James, using the checks of `Testimony.Logic.Credibility`: a credible
dissent is consistent, denies the claim, grants the step's grounds, argues its
denial by a step of its own rather than asserting it, and rests its grounds on
what a stated standard admits. The **evidence** standard admits Scripture and
evidence anyone can check; the **tradition** standard also admits a council's
or a confession's word. Every result names the standard it holds under.

## What the checks find

**Works as fruit, not ground** (`fruitLine`, from Westminster's proof texts).
Two dissents are encoded, and both are argued.

- Trent's canon 24, applied to James 2:24: the works by which a person is
  justified are a cause of the increase of justification. It is argued, and it
  grants Westminster's texts — but the claim that works cause the increase rests
  on the council's word alone. So it is a credible critique under the tradition
  standard and not under the evidence standard
  (`canon24_credible_under_tradition`, `canon24_rests_on_the_council`). Were it
  the only dissent, the step's rating would turn on the authority question
  (`canon24_alone_turns_on_authority`).
- Trent's chapter 16, from the texts it quotes for the reward of good works
  (1 Corinthians 15:58, Hebrews 6:10, Hebrews 10:35, 2 Timothy 4:8): what God
  rewards is not merely fruit. Its grounds are Scripture, which Westminster
  grants too (XVI.6); its step is Trent's reading of them, which the Reformed
  deny. It is a credible critique under **both** standards
  (`reward_credible_under_evidence`).

So the step is **disputed under both standards**, whatever the breadth of its
support (`fruit_step_disputed`). That is a result against the Reformed side, and
the page reports it: the dissent that keeps the step disputed is not an appeal
to Trent's authority but Trent's reading of Scripture, and it is answered, if
at all, by a better reading of the same texts — a step-against-step contest
that a hearing, not this check, decides.

**James's word** (`jamesLexicalLine`: δικαιόω does not denote the increase of
justice). The encoded dissent, Trent's reading of the word, is not an argument
against the step: it holds that James's δικαιόω denotes the increase as a
premise, and that premise alone denies the step's conclusion
(`trent_on_the_word_is_asserted`). Against the register as encoded, the step's
computed rating is its support (`word_register_leaves_support`).

## What this does not show

It does not show that the lexical step deserves a rating above `disputed`. A
rating computed from the dissents that are encoded is only as good as those
dissents, and the strongest one against this step is not yet encoded: that
James uses δικαιόω as Paul does, and that Paul's denotes renewal, as Augustine
read it. Until that dissent is written with its own grounds and checked, the
steelman rule (`docs/src/computed-ratings.md`) withholds a computed rating
above `disputed`, and the step keeps the rating it is cited at.

Nor does a credible dissent show the step wrong. It shows that the dispute is
a dispute between arguments. Which one prevails is what a hearing computes.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Logic.Horn

/-! ### Trent on the reward of works -/

/-- Trent's step from the reward texts to "works are not merely fruit": eternal
life is "a reward to be faithfully rendered to their good works and merits"
(Session VI, ch. 16), and the good works of the justified truly merit it
(canon 32). Rated `disputed`: Westminster grants that God rewards the good works
of believers and holds the reward to be of grace, given to works accepted in
Christ and not earned by them (XVI.5, XVI.6). -/
def trentRewardSource : Source :=
  { primary := .work tannerDecrees (.sectionRef "Trent, Session VI (1547), ch. 16, canon 32")
  , supporting := [.work westminsterConfession (.sectionRef "XVI.5, XVI.6")]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **The reward of works, as Trent reads it**: God rewards the labor of
believers (1 Corinthians 15:58, Hebrews 6:10, Hebrews 10:35, 2 Timothy 4:8); so
works are not merely the fruit of justification. -/
@[solaFideDefs]
def trentRewardLine : Line Claim :=
  { name := "The reward of works (Trent, Session VI, ch. 16)"
  , grounds := [p .rewardTextsPromiseReward]
  , step := p .rewardTextsPromiseReward ➝ notP .worksAreFruitNotGround
  , delivers := notP .worksAreFruitNotGround
  , inference := some trentRewardSource }

/-- Trent on the reward of works: what God rewards is not merely fruit. -/
@[solaFideDefs]
def trentOnReward : ArgumentPackage Claim :=
  trentRewardLine.asPackage baseCite "Works are not merely the fruit of justification"

/-! ### The dissents -/

/-- **Canon 24's dissent from "fruit, not ground"**: Trent's reading of James
2:24's works, set against the step Westminster draws from its proof texts. -/
def canon24Dissent : Dissent Claim :=
  { claim := p .worksAreFruitNotGround
  , grounds := fruitLine.grounds
  , position := catholicJamesOnWorks }

/-- **Chapter 16's dissent from "fruit, not ground"**: Trent's reading of the
reward texts, set against the same step. -/
def rewardDissent : Dissent Claim :=
  { claim := p .worksAreFruitNotGround
  , grounds := fruitLine.grounds
  , position := trentOnReward }

/-- The dissents from "fruit, not ground" the library encodes. -/
def fruitRegister : List (Dissent Claim) := [canon24Dissent, rewardDissent]

/-- **Trent's dissent from the lexical step**: its reading of James's δικαιόω as
the increase of justice, set against the step that reads it as a declaration. -/
def wordDissent : Dissent Claim :=
  { claim := notP .jamesJustifyDenotesIncrease
  , grounds := jamesLexicalLine.grounds
  , position := catholicJamesOnTheWord }

/-! ### Canon 24 -/

/-- **Canon 24's dissent is a credible critique under the tradition standard.**
It is consistent; it denies that works are fruit and not ground; it grants
Westminster's proof texts; it argues the denial by a step from James 2:24 rather
than asserting it; and what it asserts rests on Scripture or on Trent's word. -/
theorem canon24_credible_under_tradition : Dissent.Credible .tradition canon24Dissent :=
  Dissent.credible_of_check (by decide +kernel)

#print axioms canon24_credible_under_tradition

/-- **Under the evidence standard it is not, because one of its grounds rests on
the council's word alone**: that good works are a cause of the increase of
justification. James's words are Scripture; that claim is canon 24's. -/
theorem canon24_rests_on_the_council :
    canon24Dissent.meets .evidence = false ∧
      catholicJamesOnWorks.restingOnAuthority = [.worksCauseIncreaseOfJustification] := by
  decide +kernel

/-- **Were canon 24 the only dissent, the step's rating would turn on the
authority question**: a step supported at `wellSupported` would keep that
rating under the evidence standard and be `disputed` under the tradition
standard. -/
theorem canon24_alone_turns_on_authority :
    computedRating .wellSupported .evidence [canon24Dissent] = .wellSupported ∧
      computedRating .wellSupported .tradition [canon24Dissent] = .disputed := by
  decide +kernel

/-! ### Chapter 16 -/

/-- **Chapter 16's dissent is a credible critique under the evidence
standard.** Its only asserted ground is the reward texts, which are Scripture
and which Westminster grants; the denial comes from Trent's reading of them, a
step, not from a premise. -/
theorem reward_credible_under_evidence : Dissent.Credible .evidence rewardDissent :=
  Dissent.credible_of_check (by decide +kernel)

#print axioms reward_credible_under_evidence

/-- **And so under the tradition standard**, which admits all the evidence
standard does. -/
theorem reward_credible_under_tradition : Dissent.Credible .tradition rewardDissent :=
  Dissent.credible_of_check (by decide +kernel)

/-- **"Fruit, not ground" is disputed under both standards, whatever its
support.** Trent's reading of the reward texts is a credible critique on
Scripture's own ground, so the computed rating is `disputed` under the evidence
standard as under the tradition standard. -/
@[headline]
theorem fruit_step_disputed :
    ∀ std support, computedRating support std fruitRegister = .disputed := by
  intro std support
  cases std <;> cases support <;> decide +kernel

#print axioms fruit_step_disputed

/-! ### James's word -/

/-- **Trent's reading of James's word is asserted, not argued, against the
lexical step.** What it asserts outright includes that James's δικαιόω denotes
the increase of justice, and that alone contradicts the step's conclusion: no
step of its own is needed to reach the denial. -/
theorem trent_on_the_word_is_asserted :
    ¬ Satisfiable (wordDissent.asserted ++ [wordDissent.claim]) :=
  Dissent.not_argued_of_check (by decide +kernel)

#print axioms trent_on_the_word_is_asserted

/-- **Against the register as encoded, the lexical step's computed rating is its
support, under either standard.** This is a fact about the encoded register,
not a licence: the strongest dissent from this step is not yet encoded (see the
module note), and until it is, the steelman rule withholds a rating above
`disputed`. -/
theorem word_register_leaves_support :
    ∀ std support, computedRating support std [wordDissent] = support := by
  intro std support
  cases std <;> cases support <;> decide +kernel

end Testimony.Arguments.SolaFide
