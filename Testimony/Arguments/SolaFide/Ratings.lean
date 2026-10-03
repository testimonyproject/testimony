import Testimony.Arguments.SolaFide.Vulgate
import Testimony.Logic.Credibility
import Testimony.Logic.Contest

/-!
# Arguments.SolaFide.Ratings — which dissents from the James steps are critiques

A step is rated `disputed` when someone dissents from it. The reader's question
is the next one: **is the dissent an argument, or only a disagreement?** This
module asks it of every dissent the library encodes from two steps of the
Reformed reading of James, using the checks of `Testimony.Logic.Credibility`. A
credible dissent:

- is consistent;
- denies the claim;
- grants the step's grounds;
- argues its denial by a step of its own, rather than asserting it;
- rests its grounds on what a stated standard admits.

There are two standards, and every result is computed under both. The
**evidence** standard admits Scripture and evidence anyone can check; the
**tradition** standard also admits a council's or a confession's word.

## James's word: how a rating moves

The lexical step reads James's δικαιόω as the declarative sense the word has
outside Paul (`jamesLexicalLine`). Two dissents from it are encoded.

- **Trent's reading of the word** holds the increase of justice as a premise:
  a disagreement, not a critique, under any standard.
- **The renewal reading** argues it. Paul's δικαιόω denotes renewal, as
  VanLandingham argues from the lexicon and Augustine glossed it; James's word
  is Paul's; and James says Abraham was justified by works after Genesis 15:6.
  This is the strongest dissent the library has found, and it is a critique —
  but one of its grounds, that James's word is Paul's, rests on Trent's word
  alone (chapter 10). No exegete's statement of it has been verified.

So the step's rating turns on the authority question, and the page says so
(`lexical_step_ratings`). Under the evidence standard its support stands at
`wellSupported`, because every encoded dissent fails, the strongest among them.
Under the tradition standard it is `disputed` by the renewal reading. Before the
renewal reading was encoded, the same computation withheld any rating above
`disputed` under both standards, because the strongest dissent was missing
(`lexical_step_before_the_steelman`). Encoding it is what licenses the higher
rating, and only where it fails.

## Works as fruit, not ground

Westminster's step (`fruitLine`) derives "fruit, not ground" from its proof
texts. Its support is `wellSupported`: the Lutheran World Federation and the
Catholic Church confess together that good works "follow justification and are
its fruits", and that what follows faith "is neither the basis of justification
nor merits it" (*Joint Declaration* §§37, 25). Two dissents from it are encoded,
both from Trent, and both argued.

- **Canon 24, applied to James 2:24**: works cause the increase of
  justification. That claim rests on the council's word alone.
- **Chapter 16, from the reward texts** (1 Corinthians 15:58, Hebrews 6:10,
  Hebrews 10:35, 2 Timothy 4:8). The texts are Scripture, and Westminster grants
  them (XVI.6). But they say God *rewards* the works. Chapter 16 adds that the
  reward is "rendered to their good works and merits", and that "we must believe"
  the justified "have truly merited eternal life". That bridge from reward to
  merit is the council's own claim. Dulles, defending Trent's teaching, grants
  that "the fact that a reward is promised does not make it merited". The Joint
  Declaration reads "merit" as no more than a reward promised (§38).

So each of Trent's dissents rests at one claim on the council's word, and the
step's rating turns on the authority question (`fruit_step_ratings`). Under the
evidence standard neither dissent is credible, and the support stands at
`wellSupported`. Under the tradition standard both are, and the step is
`disputed`.

What this shows is exactly that, and no more. Trent's denial does not stand on
Scripture and evidence alone. A reader who receives the council's word has a
credible critique; a reader who does not has none. It does not show that the
reward texts teach the Reformed reading of them; it shows that they do not
teach Trent's without Trent.

## The hearing under each standard

Which dissents are critiques decides who is heard, and how each step is weighed.
The hearing under a standard (`Testimony.Logic.Register`) is the James dispute
(`jamesDispute`) among every party that is not a dissent and every dissent that
is credible under the standard, with each rated step weighed at its computed
rating under that standard. So the dissents heard and the ratings weighed come
from one register, and the hearing's verdict and the step's rating cannot
disagree about the standard.

- **What James's δικαιόω denotes turns on the standard**
  (`james_word_turns_on_the_standard`). Under the evidence standard the hearing
  forces James's word, as the full dispute does: the renewal reading is not
  heard. Under the tradition standard it is heard, the lexical step is weighed at
  `disputed`, and the question is contested — James's word and the renewal
  reading each survive, and neither is forced.
- **Whether works are fruit and not ground turns on the standard too**
  (`fruit_turns_on_the_standard`). Under the evidence standard the hearing
  forces the Reformed harmony: neither of Trent's dissents is heard. Under the
  tradition standard both are, and the harmony and chapter 16's reading each
  survive, and neither is forced.

In both, the register's rating and the hearing's verdict agree. A step rated
`disputed` under a standard is contested in the hearing under it, and a step
whose support stands is forced.

The full dispute still weighs every step at its *cited* rating. For the lexical
step that is `wellSupported`, its computed rating under the evidence standard;
under the tradition standard the hearing, not the full dispute, is the coherent
result. Making every dispute weigh computed ratings is phase two of the design
(`docs/src/computed-ratings.md`).

## What this does not show

A credible dissent does not show the step wrong, and an answered one does not
show it right. Credibility says the dispute is a dispute between arguments;
which prevails is what the hearing computes, from the ratings each side rests
on.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Logic.Framework

/-! ### The dissents, assessed -/

/-- **Canon 24, against "fruit, not ground"**: argued, and granting
Westminster's proof texts. It asserts that good works are a cause of the
increase of justification on the council's word alone, so it is a critique
under the tradition standard and not under the evidence standard. -/
def canon24Assessment : Assessment Claim where
  dissenter := "Trent, canon 24"
  against := fruitLine.name
  dissent :=
    { claim := p .worksAreFruitNotGround
    , grounds := fruitLine.grounds
    , position := catholicJamesOnWorks }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, [.worksCauseIncreaseOfJustification]), (.tradition, [])] }
  checked := by decide +kernel

/-- **Chapter 16, against "fruit, not ground"**: argued, and granting
Westminster's proof texts. Its grounds are the reward texts, which are Scripture
and which Westminster grants, and the claim that the reward is rendered to the
works as merits — which the texts do not say, and Trent asserts on its own word
("we must believe"). So it is a critique under the tradition standard, and not
under the evidence standard. -/
def rewardAssessment : Assessment Claim where
  dissenter := "Trent, Session VI, ch. 16"
  against := fruitLine.name
  dissent :=
    { claim := p .worksAreFruitNotGround
    , grounds := fruitLine.grounds
    , position := trentOnReward }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, [.rewardRenderedToMerits]), (.tradition, [])] }
  checked := by decide +kernel

/-- **Trent's reading of James's word, against the lexical step**: it holds that
James's δικαιόω denotes the increase of justice as a premise, and that premise
alone contradicts the step's conclusion. A disagreement, not a critique, under
any standard. -/
def trentWordAssessment : Assessment Claim where
  dissenter := "Trent, Session VI, ch. 10"
  against := jamesLexicalLine.name
  dissent :=
    { claim := notP .jamesJustifyDenotesIncrease
    , grounds := jamesLexicalLine.grounds
    , position := catholicJamesOnTheWord }
  findings :=
    { consistent := true, denies := true, grants := true, argued := false, bareDenial := false
    , unadmitted := [(.evidence, [.jamesJustifyDenotesIncrease]), (.tradition, [])] }
  checked := by decide +kernel

/-- **The renewal reading, against the lexical step**: argued from Paul's word
as renewal and James's word as Paul's, granting the lexical case's grounds. It
is a critique under the tradition standard; under the evidence standard one of
its grounds, that James's word is Paul's, rests on Trent's word alone. -/
def renewalAssessment : Assessment Claim where
  dissenter := "The renewal reading"
  against := jamesLexicalLine.name
  dissent :=
    { claim := notP .jamesJustifyDenotesIncrease
    , grounds := jamesLexicalLine.grounds
    , position := renewalOnTheWord }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted := [(.evidence, [.jamesUsesDikaioAsPaul]), (.tradition, [])] }
  checked := by decide +kernel

/-- **Trent's reading of James's word is a disagreement, not a critique.** What
it asserts outright includes the increase of justice, which alone contradicts the
lexical step's conclusion: no step of its own is needed to reach its denial. -/
theorem trent_on_the_word_is_asserted :
    trentWordAssessment.findings.kind = .asserted ∧
      ∀ s, ¬ Dissent.Credible s trentWordAssessment.dissent := by
  refine ⟨by decide, fun s => trentWordAssessment.complete ?_⟩
  cases s <;> decide

/-! ### The steps, rated -/

/-- **"Works are fruit, not ground", rated by its register**: canon 24's
dissent and chapter 16's. Chapter 16's is the strongest known: it argues from
texts both sides grant. -/
def fruitStep : RatedStep Claim where
  step := fruitLine.name
  support := fruitSource
  register := [canon24Assessment, rewardAssessment]
  strongest := some 1

/-- **"Fruit, not ground" turns on the authority question.** Under the evidence
standard its support stands at `wellSupported`: both of Trent's dissents are
argued, and each rests at one claim on the council's word alone. Canon 24's
claim is that works cause the increase of justification. Chapter 16's is that the
reward the texts promise is rendered to the works as merits. Under the
tradition standard, which admits the council's word, both are credible
critiques, and the step is `disputed`. -/
@[headline]
theorem fruit_step_ratings :
    fruitStep.ratings =
      [ (.evidence, .stands .wellSupported)
      , (.tradition, .disputedBy ["Trent, canon 24", "Trent, Session VI, ch. 16"]) ] := by
  decide +kernel

#print axioms fruit_step_ratings

/-- **James's word, rated by its register**: Trent's reading of the word, and
the renewal reading — the strongest known dissent, which argues the increase
from Paul's word instead of asserting it. -/
def lexicalStep : RatedStep Claim where
  step := jamesLexicalLine.name
  support := jamesLexicalSource
  register := [trentWordAssessment, renewalAssessment]
  strongest := some 1

/-- **The lexical step's rating turns on the authority question.** Under the
evidence standard its support stands at `wellSupported`: every encoded dissent
fails a check, the strongest known among them, because the renewal reading's
claim that James's word is Paul's rests on Trent alone. Under the tradition
standard, which admits Trent's word, the renewal reading is a credible critique
and the step is `disputed`. -/
@[headline]
theorem lexical_step_ratings :
    lexicalStep.ratings =
      [ (.evidence, .stands .wellSupported)
      , (.tradition, .disputedBy ["The renewal reading"]) ] := by
  decide +kernel

#print axioms lexical_step_ratings

/-- **Before the steelman was encoded, no rating above `disputed` was licensed.**
With only Trent's reading of the word in the register, no dissent is credible,
but the strongest known one is missing, so the rating is withheld under both
standards. Encoding the renewal reading is what moves it: to `wellSupported`
under the evidence standard, and to `disputed` under the tradition standard. -/
theorem lexical_step_before_the_steelman :
    ({ lexicalStep with register := [trentWordAssessment], strongest := none }).ratings =
      [(.evidence, .withheld), (.tradition, .withheld)] := by
  decide +kernel

/-! ### The hearing under each standard -/

/-- **The James dispute's register**: each party entered as a dissent from a step
of the Reformed reading, assessed, and the two steps they are rated against. The
other parties hold those steps, or are readings of texts answered by the texts
themselves. -/
def jamesRegister : Register jamesDispute where
  assessmentOf
    | .trentOnTheWord => some trentWordAssessment
    | .trentOnWorks => some canon24Assessment
    | .trentOnReward => some rewardAssessment
    | .renewalOnTheWord => some renewalAssessment
    | _ => none
  ownPosition i a h := by
    cases i <;> simp only [Option.some.injEq, reduceCtorEq] at h <;> subst h <;> rfl
  steps := [fruitStep, lexicalStep]

/-- Each party's weakest link, weighed at a standard's ratings: as cited, except
that under the tradition standard James's word is weighed as `disputed`, its
computed rating there. -/
def ratedStrength : Standard → JamesParty → ℕ
  | .tradition, .lexical => 0
  | _, i => jamesPartyStrength i

/-- Each party's weakest link, as the re-rated package computes it. -/
theorem rerated_strength (s : Standard) :
    ∀ i, ((jamesRegister.rerated s).node i).strength = ratedStrength s i := by
  intro i
  cases s <;> cases i <;> decide +kernel

/-- Who defeats whom at a standard's ratings: under the evidence standard, as in
the full dispute; under the tradition standard, also Trent's reading of the word
and the renewal reading each defeat James's word, now that it is weighed as
`disputed`. -/
def ratedDefeats : Standard → JamesParty → JamesParty → Prop
  | .tradition, .trentOnTheWord, .lexical => True
  | .tradition, .renewalOnTheWord, .lexical => True
  | _, i, j => jamesPartyDefeats i j

/-- The table is finite, so membership in it is decidable. -/
instance (s : Standard) : DecidableRel (ratedDefeats s) := fun i j => by
  cases s <;> cases i <;> cases j <;> unfold ratedDefeats <;> infer_instance

/-- **Who defeats whom at each standard's ratings**, all 121 pairs under each
standard, computed from the parties' premises and the re-rated inferences and
checked by the kernel. -/
theorem rerated_defeats (s : Standard) :
    ∀ i j, (jamesRegister.rerated s).defeats i j ↔ ratedDefeats s i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (rerated_strength s i) (rerated_strength s j) ?_
  cases s <;> cases i <;> cases j <;> decide +kernel

/-- The dispute at a standard's ratings, in the form the verdict solver computes
with. -/
def ratedFinite (s : Standard) : Solver.Finite (jamesRegister.rerated s).defeats where
  parties := jamesFinite.parties
  complete := jamesFinite.complete
  defeats i j := decide (ratedDefeats s i j)
  spec i j := by rw [rerated_defeats]; simp

/-- The hearing under the evidence standard. -/
abbrev jamesUnderEvidence := jamesRegister.hearing .evidence

/-- The hearing under the tradition standard. -/
abbrev jamesUnderTradition := jamesRegister.hearing .tradition

/-- The hearing under a standard, in the form the verdict solver computes with. -/
abbrev jamesUnderFinite (s : Standard) :=
  (ratedFinite s).restrict (jamesRegister.admits s)

/-- **Who defeats whom in the hearing under the evidence standard**: as in the
full dispute, among the parties heard. -/
theorem jamesUnderEvidence_defeats :
    ∀ i j, jamesUnderEvidence.defeats i j ↔ ratedDefeats .evidence i.1 j.1 :=
  fun i j => rerated_defeats .evidence i.1 j.1

/-- **Who defeats whom in the hearing under the tradition standard**: James's
word, weighed as `disputed`, and the renewal reading defeat each other. -/
theorem jamesUnderTradition_defeats :
    ∀ i j, jamesUnderTradition.defeats i j ↔ ratedDefeats .tradition i.1 j.1 :=
  fun i j => rerated_defeats .tradition i.1 j.1

/-- How the hearing under the evidence standard is settled: James's word,
James's faith, the Reformed harmony and the Greek of both verses come first, and
nothing heard answers them; Trent's Latin readings fall to the Greek. Every
dissent of Trent's from a rated step — canon 24, chapter 16, the renewal reading,
and Trent's reading of the word — rests at some claim on the council's word, or
asserts its denial, and is not heard. -/
def underEvidenceSettled : Verdict jamesUnderEvidence where
  finite := jamesUnderFinite .evidence
  claim := .groundedExactly
    [Witness.listSub _ [.lexical, .faith, .harmony, .revelationText, .sirachText]]
    (Witness.Table.sub _
      [ (.trentOnRevelation, .revelationText), (.trentOnSirach, .sirachText) ])
  checked := by decide +kernel

/-- How the hearing under the tradition standard is settled: James's faith and
the Greek of both verses come first. James's word and the renewal reading defeat
each other; so do the Reformed harmony and each of Trent's readings of what works
do. Only Trent's reading of the word is not heard. -/
def underTraditionSettled : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .groundedExactly
    [Witness.listSub _ [.faith, .revelationText, .sirachText]]
    (Witness.Table.sub _
      [ (.lexical, .renewalOnTheWord), (.renewalOnTheWord, .lexical)
      , (.trentOnRevelation, .revelationText), (.trentOnSirach, .sirachText)
      , (.harmony, .trentOnWorks), (.trentOnWorks, .harmony)
      , (.trentOnReward, .harmony) ])
  checked := by decide +kernel

/-- The renewal reading holds that James's δικαιόω denotes the increase of
justice. -/
theorem renewal_holds_increase :
    Entails (jamesDispute.node .renewalOnTheWord).premises (p .jamesJustifyDenotesIncrease) := by
  establish [solaFideDefs, jamesDispute]

/-- James's word denies it. -/
theorem lexical_denies_increase :
    Entails (jamesDispute.node .lexical).premises (∼ p .jamesJustifyDenotesIncrease) := by
  establish [solaFideDefs, jamesDispute]

/-- Why the renewal reading can be defended in the hearing under the tradition
standard: it answers James's word itself, now that the two are rated alike. -/
def renewalHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.renewalOnTheWord, by decide⟩
    (Witness.listSub _ [.faith, .renewalOnTheWord, .revelationText, .sirachText])
  checked := by decide +kernel

/-- Why James's word can be defended there: it answers the renewal reading
itself. -/
def lexicalHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.lexical, by decide⟩
    (Witness.listSub _ [.lexical, .faith, .revelationText, .sirachText])
  checked := by decide +kernel

/-- **What James's δικαιόω denotes turns on the standard, and the hearing and
the rating agree.** Under the evidence standard the hearing forces James's word,
with James's faith and the Greek of both verses: the renewal reading is not
heard, because it rests on Trent's word that James's δικαιόω is Paul's. Under
the tradition standard the renewal reading is heard, the lexical step is weighed
at its computed rating there, `disputed`, and whether James's word denotes the
increase of justice is contested: each side can be defended, and neither is
forced. -/
@[headline]
theorem james_word_turns_on_the_standard :
    grounded jamesUnderEvidence.defeats =
        Solver.toSet
          (Witness.listSub _ [.lexical, .faith, .harmony, .revelationText, .sirachText]) ∧
      Nonempty (Contested jamesUnderTradition (p .jamesJustifyDenotesIncrease)) :=
  ⟨underEvidenceSettled.holds,
    ⟨{ holder := ⟨.renewalOnTheWord, by decide⟩
       denier := ⟨.lexical, by decide⟩
       holds := renewal_holds_increase
       denies := lexical_denies_increase
       holderDefensible := renewalHeard.holds
       denierDefensible := lexicalHeard.holds }⟩⟩

#print axioms james_word_turns_on_the_standard

/-- **Under the tradition standard, what is forced is James's faith and the
Greek of the two verses**, and no more. -/
theorem under_tradition_forces :
    grounded jamesUnderTradition.defeats =
      Solver.toSet (Witness.listSub _ [.faith, .revelationText, .sirachText]) :=
  underTraditionSettled.holds

/-- Trent's reading of the reward texts denies that works are fruit and not
ground. -/
theorem trentOnReward_denies_fruit :
    Entails (jamesDispute.node .trentOnReward).premises (∼ p .worksAreFruitNotGround) := by
  establish [solaFideDefs, jamesDispute]

/-- Why the Reformed harmony can be defended in the hearing under the tradition
standard: it answers canon 24 and chapter 16 itself. -/
def harmonyHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.harmony, by decide⟩
    (Witness.listSub _ [.lexical, .faith, .harmony, .revelationText, .sirachText])
  checked := by decide +kernel

/-- Why chapter 16's reading of the reward texts can be defended there: it
answers the Reformed harmony itself. -/
def rewardHeard : Verdict jamesUnderTradition where
  finite := jamesUnderFinite .tradition
  claim := .credulous ⟨.trentOnReward, by decide⟩
    (Witness.listSub _
      [.lexical, .faith, .trentOnWorks, .trentOnReward, .revelationText, .sirachText])
  checked := by decide +kernel

/-- **Whether works are fruit and not ground turns on the authority question,
and the hearing and the rating agree.** Under the evidence standard the hearing
forces the Reformed harmony, which derives "fruit, not ground" from Westminster's
proof texts. Neither of Trent's dissents is heard: each rests at one claim on the
council's word. Under the tradition standard both are heard, the step is weighed
at `disputed`, and the question is contested: the harmony and chapter 16's
reading of the reward texts can each be defended, and neither is forced. -/
@[headline]
theorem fruit_turns_on_the_standard :
    grounded jamesUnderEvidence.defeats =
        Solver.toSet
          (Witness.listSub _ [.lexical, .faith, .harmony, .revelationText, .sirachText]) ∧
      Nonempty (Contested jamesUnderTradition (p .worksAreFruitNotGround)) :=
  ⟨underEvidenceSettled.holds,
    ⟨{ holder := ⟨.harmony, by decide⟩
       denier := ⟨.trentOnReward, by decide⟩
       holds := harmony_holds_fruit
       denies := trentOnReward_denies_fruit
       holderDefensible := harmonyHeard.holds
       denierDefensible := rewardHeard.holds }⟩⟩

#print axioms fruit_turns_on_the_standard

end Testimony.Arguments.SolaFide
