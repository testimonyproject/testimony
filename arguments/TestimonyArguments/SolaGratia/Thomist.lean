import TestimonyArguments.SolaGratia.ThirdWay

/-!
# TestimonyArguments.SolaGratia.Thomist — Aquinas and the Catholic schools

Is sola gratia, stated sharply, a Protestant doctrine? Thomas Aquinas wrote,
three centuries before Dort, that "if God intends, while moving, that the one
whose heart He moves should attain to grace, he will infallibly attain to it"
(*Summa Theologiae*, First Part of the Second Part, question 112, article 3;
cited below as I-II q.112 a.3). And in the grace by which the will is converted,
"our mind is moved and does not move, but … God is the sole mover" (I-II q.111
a.2). Aquinas calls that *operating grace*: grace in which God alone moves the
will. In *cooperating grace* the will, once moved, moves as well.

The Dominican school that followed him, Domingo Báñez in the sixteenth century
and Réginald Garrigou-Lagrange in the twentieth, held with Garrigou-Lagrange that
grace is "efficacious of itself, producing of itself the virtuous act" (*Grace*,
ch. V): when it is given, the grace itself, by its own power, brings about the
will's consent. This argument calls that grace *effectual of itself*, the second
part of sola gratia.

The Jesuit school of Luis de Molina read Trent otherwise. For the Molinists, as
Joseph Pohle reports them, "the infallible success of efficacious grace is not
to be ascribed to its own intrinsic nature, but to" God's "middle knowledge"
(*scientia media*), his knowledge of what a person would freely do in any
circumstance; "it is rather the will itself which by its consent" makes grace
efficacious. So for them efficacious grace is infallibly followed by consent,
but because God foresaw the consent, not because the grace produces it. The two
schools argued before the popes for twenty years. Paul V's decree of 5 September
1607 "allowed each party to defend its own doctrine, enjoined each from
censoring or condemning the opposite opinion" (Astrain, "Congregatio de
Auxiliis"), and Rome has not decided between them since. The Trent of this
argument's other chapters is Trent on the Molinist reading of its fourth canon.

## What the Thomists reach

The Thomists accept Trent's fourth canon: the will, moved by God, cooperates by
assenting and can dissent if it would. But they read it so that it denies
neither part of sola gratia that Trent seems to deny. Garrigou-Lagrange explains
the canon so, in his own translation of it: "The Council does not maintain that
man does, in fact, sometimes dissent, but that 'he can dissent if he so wills.'
In other words, the contrary power remains, but under efficacious grace man
never wills to resist, nor does he." The schoolmen call this the *divided sense*:
taken apart from grace, the will can dissent; in the *composite sense*, taken
together with efficacious grace, it does not. So the step from the canon to
"grace is not effectual of itself", rated *disputed* because Aquinas grants the
canon's ground and denies that it follows, is a step the Thomists refuse.

Grant the Thomists their premises, and the second part of sola gratia follows:
the grace that saves brings about the consent it seeks
(`thomists_reach_effectual_grace`). The step that delivers it is rated
*disputed*, because the Molinists grant God's intention and the infallible
result and ascribe the efficacy to the consent God foresees.

Two Thomist claims are about resisting grace, and neither is the claim that the
grace that saves can be finally refused. Grace "really sufficient in its own
order" (Garrigou-Lagrange, after Lemos) is resisted, and through that resistance
the efficacious grace offered with it is withheld. And justifying grace, once
given, can be lost: Aquinas holds that the charity of one still on the way (in
this life) can be lost, and Trent condemns anyone who says otherwise (canon 23).
The grace resisted in the first is not the grace that converts, and the grace
lost in the second is grace once given. So they are encoded as claims of their
own. Dort parts from the Thomists on the second, the perseverance of the saints,
which the chapter on perseverance weighs, with Aquinas beside Augustine.

## The word "passive"

The Thomists' operating grace gives them that conversion is God's work alone.
What they do not take is Dort's next step, from God's work alone to the will's
passivity. Instead they say the will is "not merely passive". Garrigou-Lagrange:
under operating grace "the will elicits its act vitally, in fact, it freely
consents to the divine motion or inspiration, but it does not strictly move
itself", and "in these acts the will does not remain passive". He lists Calvin's
"merely passive" among the errors. Taken at their face, these words deny the
third part of sola gratia.

But he is exact about the sense. The will's consent, "although as a disposition
it precedes it [grace] in the genus or order of material cause, it nevertheless
follows it in the genus or order of formal, efficient, and final cause". These
are Aristotle's four kinds of cause: the material, what receives a thing; the
efficient, what brings it about; the formal, what makes it what it is; the
final, what it is for. So the consent comes before grace only as the readiness
that receives it, and grace is what brings the consent about. Aquinas says the
same: the movement of the free will "is not the cause of grace, but the effect".
The third part of sola gratia, as this argument states it, says that the will
is not the agent of its own new life. On Garrigou-Lagrange's own explanation the
Thomist grants it in that sense; but that is a reading of him, rated *disputed*,
not something his premises settle.

If "not merely passive" makes the will's consent a cause of the new life, as the
Molinists hold of the will's part, the Thomist breaks with Dort at Dort's step
from God's work alone to the will's passivity. If it means the will acts while
God alone gives the new life, as Garrigou-Lagrange explains it, the Thomist can
stand with Dort, and breaks instead with Trent on the Molinist reading, at the
step from the will's cooperation, which Aquinas already disputes
(`whatNotMerelyPassiveMeans`). Granted the Thomists' premises and no more, the
third part neither follows nor fails (`thomists_leave_passivity_open`).

## So is sola gratia a Protestant doctrine?

The Thomists' premises reach the first two parts of sola gratia and leave the
third open. Nothing here shows that they hold sola gratia as stated, and nothing
shows that they deny it. Weighed with the other positions, the Thomists can be
defended with Dort and are not forced (`thomist_defensible`,
`thomist_not_forced`). Where the Thomists plainly part from the Reformers is
elsewhere: on faith formed by charity, which Aquinas calls "the form of faith",
and so not faith alone, which Dort's position here does not carry; and on
perseverance. Neither is part of sola gratia as this argument states it.
-/

namespace TestimonyArguments.SolaGratia

open Testimony Testimony.Logic

/-! ### The Thomist position -/

/-- The Thomist citations: Aquinas, with Trent's ninth canon, for the denial of
faith alone, faith being formed by charity (II-II q.4 a.3). -/
def thomistCite : Claim → AtomMeta
  | .faithAloneReceivesGrace =>
    { label := "Grace is received by faith alone"
    , kind := .theological
    , source :=
        { primary := .work aquinasSumma (.sectionRef "II-II q.4 a.3")
        , supporting :=
            [ .work aquinasSumma (.sectionRef "I-II q.113 a.4 ad 1")
            , .work tannerDecrees (.sectionRef "Trent, Session VI (1547), canon 9") ]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | a => baseCite a

/-- **The Thomists**, from Aquinas (*Summa* I-II qq.109–113) and Garrigou-Lagrange.
They hold Romans 11:6, and operating grace, in which God is the sole mover. They
hold that God moves the will intending it to attain grace, so that it attains it
infallibly. They accept Trent's canon 4, that the will cooperates and can
dissent, but draw neither of the steps that Trent's Molinist reading draws from
it. They hold that the will under operating grace is not merely passive, that
grace truly sufficient is resisted, that justifying grace can be lost, and that
grace is not received by faith alone, faith being formed by charity.

The conclusion set against these premises is sola gratia as this argument states
it, to test how far they reach. It is not the Thomists' own conclusion, which is
`thomistPosition` below. -/
@[solaGratiaDefs]
def thomist : ArgumentPackage Claim :=
  { name := "Thomist (Aquinas; Garrigou-Lagrange)"
  , cite := thomistCite
  , premises :=
      caseOf [graceLine, operatingGraceLine, efficacyLine]
        [ p .freeWillCooperatesByAssenting, p .freeWillCanDissent, p .willIsNotMerelyPassive
        , p .sufficientGraceIsResisted, p .justifyingGraceCanBeLost
        , notP .faithAloneReceivesGrace ] []
  , conclusion := solaGratia
  , conclusionLabel :=
      "salvation by grace alone: grace brings about the consent it seeks, and the will " ++
      "contributes nothing to its own new life"
  , inferences := [graceInference, operatingGraceInference, efficacyInference] }

/-- The Thomists' position, concluding what their sources draw: salvation by
grace, and grace effectual of itself. -/
@[solaGratiaDefs]
def thomistPosition : ArgumentPackage Claim :=
  { thomist with
    conclusion := ⋀ [p .salvationIsByGrace, p .graceIsEffectualOfItself]
    conclusionLabel := "salvation by grace, which is efficacious of itself" }

/-- The Thomists' reading, with "not merely passive" taken as the Molinists take
it: grace effectual of itself, God alone the one who regenerates, the will not
passive in it, and not faith alone. -/
def thomistReading : Valuation Claim := fun a =>
  match a with
  | .willIsPassiveInRegeneration => False
  | .faithAloneReceivesGrace => False
  | .savingGraceCanBeFinallyRefused => False
  | _ => True

/-- The Thomists' reading, with "not merely passive" taken as Garrigou-Lagrange
explains it, so that the will is not the agent of its new life; and Dort's
answer to Acts 7:51 granted besides, so that Dort's premises hold with it. -/
def thomistWithDortReading : Valuation Claim := fun a =>
  match a with
  | .faithAloneReceivesGrace => False
  | .savingGraceCanBeFinallyRefused => False
  | .acts7_51ResistsSavingGrace => False
  | _ => True

/-! ### What the Thomist reaches -/

/-- **The Thomists' premises reach grace effectual of itself**, the second part of
sola gratia. Aquinas's "if God intends, while moving … he will infallibly attain
to it", read as Garrigou-Lagrange reads it, delivers that the grace that saves
brings about the consent it seeks. The step is rated `disputed`: the Molinists
grant the intention and the infallible result, and ascribe the efficacy to the
consent God foresees. -/
@[headline]
theorem thomists_reach_effectual_grace :
    Entails thomist.premises (p .graceIsEffectualOfItself) := by
  establish [solaGratiaDefs]

#print axioms thomists_reach_effectual_grace

/-- The Thomists' premises deliver their position. -/
theorem thomistPosition_establishes : Establishes thomistPosition := by
  establish [solaGratiaDefs]

/-- The Thomists' position can be held without contradiction. -/
theorem thomistPosition_is_satisfiable : Satisfiable thomistPosition.premises := by
  satisfied_by thomistReading [solaGratiaDefs]

/-- **Granted the Thomists' premises, the will's passivity neither follows nor
fails.** Their operating grace gives them that conversion is God's work alone.
What they do not take is Dort's next step, from God's work alone to the will's
passivity, which is rated *well supported*. Instead they hold that the will is
"not merely passive", which can be read either way: as denying the third part
of sola gratia, or as consistent with it. Their premises alone do not choose: a
reading that takes the will as passive in the sense of not being the agent of
its new life satisfies them, and so does one that does not. So the Thomists do
not reach sola gratia as stated, and they do not refute it either. -/
@[headline]
theorem thomists_leave_passivity_open :
    Independent thomist.premises (p .willIsPassiveInRegeneration) := by
  leaves_open thomistReading thomistWithDortReading [solaGratiaDefs]

#print axioms thomists_leave_passivity_open

/-! ### What "not merely passive" means -/

/-- "Not merely passive" read as making the will's consent a cause of the new
life, as the Molinists hold of the will's part, for whom "it is rather the will
itself which by its consent" makes grace efficacious (Pohle). No Thomist reads
his own claim so; the horn asks what follows if the phrase meant this. -/
@[solaGratiaDefs]
def asAgentOfNewLife : Reading Claim :=
  { name := "as making the will's consent a cause of the new life, in the Molinists' sense"
  , commits := notP .willIsPassiveInRegeneration
  , source := asAgentOfNewLifeSource }

/-- "Not merely passive" read as the will acting while God alone is the agent of
the new life: the will is passive in the sense the third part of sola gratia
means. Garrigou-Lagrange's reading. -/
@[solaGratiaDefs]
def asDisposition : Reading Claim :=
  { name := "as the will consenting while God alone is the agent, Garrigou-Lagrange's sense"
  , commits := p .willIsPassiveInRegeneration
  , source := asDispositionSource }

/-- The Thomists, with "not merely passive" read in the Molinists' sense. -/
@[solaGratiaDefs]
def thomistAsAgent : ArgumentPackage Claim :=
  thomistPosition.readAs (p .willIsNotMerelyPassive) asAgentOfNewLife

/-- The Thomists, with "not merely passive" read in Garrigou-Lagrange's sense. -/
@[solaGratiaDefs]
def thomistAsDisposition : ArgumentPackage Claim :=
  thomistPosition.readAs (p .willIsNotMerelyPassive) asDisposition

/-- The Thomists read the first way can be held without contradiction. -/
theorem thomistAsAgent_is_satisfiable : Satisfiable thomistAsAgent.premises := by
  satisfied_by thomistReading [solaGratiaDefs]

/-- The Thomists read the second way can be held without contradiction. -/
theorem thomistAsDisposition_is_satisfiable : Satisfiable thomistAsDisposition.premises := by
  satisfied_by thomistWithDortReading [solaGratiaDefs]

/-- Dort holds together with the Thomists read the second way. -/
theorem dort_holds_with_garrigou_lagrange :
    Satisfiable (reformed.premises ++ thomistAsDisposition.premises) := by
  satisfied_by thomistWithDortReading [solaGratiaDefs]

/-- **Why Dort stands against the Thomists, with "not merely passive" in the
Molinists' sense.** The Thomists' own operating grace gives them that God alone
does the work. Dort's step says that if God alone does it, the will is passive.
Read in the Molinists' sense, the Thomists' "not merely passive" says it is not.
They cannot hold all three, and the crux is Dort's step. -/
def whereTheAgentReadingFalls : Because reformed thomistAsAgent :=
  Because.ofChecks passiveStep
    (caseOf [graceLine, ephesiansLine, giftLine, romansLine, textsOfResistanceLine]
      reformedShared []) [effectualStep]
    []
    [ p .operatingGraceMovesTheWill, operatingGraceStep, p .willIsNotMerelyPassive
    , p .willIsNotMerelyPassive ➝ notP .willIsPassiveInRegeneration ]
    .derives reformed_establishes reformed_is_satisfiable
    (by simp [reformed, caseOf, closingSteps])
    (by simp)
    (by simp [solaGratiaDefs, caseOf])
    (by decide +kernel)
  |>.ratedBy passiveInference (by simp [reformed, closingInferences])

/-- **Why Trent, on the Molinist reading, stands against the Thomists, with "not
merely passive" in Garrigou-Lagrange's sense.** The crux is the first half of
Trent's canon 4 as the Molinist reading takes it: the will cooperates by
assenting, so it is not passive. That step is rated *disputed*, because Aquinas
grants that grace cooperates with a will that moves and holds that in grace's
first effect the mind "is moved and does not move". -/
def whereTheDispositionReadingFalls : Because tridentinePosition thomistAsDisposition :=
  Because.ofChecks cooperationStep
    ([ p .romans11_6, p .zechariah1_3WithLamentations5_21, p .freeWillCooperatesByAssenting
     , p .freeWillCanDissent, notP .faithAloneReceivesGrace ] ++ [graceStep]) [dissentStep]
    [p .zechariah1_3WithLamentations5_21, p .freeWillCooperatesByAssenting]
    [p .willIsNotMerelyPassive, p .willIsNotMerelyPassive ➝ p .willIsPassiveInRegeneration]
    .derives tridentinePosition_establishes tridentinePosition_is_satisfiable
    (by simp [tridentinePosition, tridentine, caseOf, solaGratiaDefs])
    (by simp [solaGratiaDefs, caseOf])
    (by simp [solaGratiaDefs, caseOf])
    (by decide +kernel)
  |>.ratedByLine cooperationLine rfl (by simp [tridentinePosition, solaGratiaDefs])

/-- **What "not merely passive" means, read both ways.** The claim is the
Thomists': under operating grace the will is not merely passive, but freely
consents.

Read as making the will's consent a cause of the new life, in the Molinists'
sense, it cannot be held with Dort, at Dort's step from God's work alone to the
will's passivity.

Read as the will consenting while God alone is the agent of the new life,
Garrigou-Lagrange's sense ("it nevertheless follows it in the genus or order of
formal, efficient, and final cause"), Dort can hold it without contradiction. It
cannot be held with Trent on the Molinist reading, at the step from the will's
cooperation, which is rated `disputed` because Aquinas grants that grace
cooperates with a will that moves and holds that in grace's first effect the
mind "is moved and does not move".

Each reading is consistent: the Thomists read either way can be held without
contradiction. Which one the Thomists mean is not something the dilemma decides,
but Garrigou-Lagrange's own explanation is the second. -/
def whatNotMerelyPassiveMeans : Dilemma thomistPosition where
  claim := p .willIsNotMerelyPassive
  horns :=
    [ { reading := asAgentOfNewLife
      , fair := thomistAsAgent_is_satisfiable
      , fates := [.falls reformed whereTheAgentReadingFalls]
      , answered := by simp }
    , { reading := asDisposition
      , fair := thomistAsDisposition_is_satisfiable
      , fates :=
          [ .falls tridentinePosition whereTheDispositionReadingFalls
          , .unreached reformed reformed_establishes dort_holds_with_garrigou_lagrange ]
      , answered := by simp } ]
  claim_mem := by simp [solaGratiaDefs, caseOf]
  two := by simp

end TestimonyArguments.SolaGratia
