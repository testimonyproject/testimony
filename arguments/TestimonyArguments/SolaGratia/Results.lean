import TestimonyArguments.SolaGratia.Packages
import Testimony.Logic.Tactic

/-!
# TestimonyArguments.SolaGratia.Results — what does and does not follow

The results come in three groups. The first is what each position reaches: the
Reformed premises reach sola gratia, neither rival's do, and both rivals reach
its first part. The second is which reading of the texts the Reformed case
depends on: neither alone, and the two together. The third is where Arminius
parts from the Ephesians strand, which is after the grammar of "this" and after
faith is granted to be God's gift.
-/

namespace TestimonyArguments.SolaGratia

open Testimony Testimony.Logic

/-! ### The positions -/

/-- **Grant the Reformed premises, and sola gratia follows.** The premises are
Romans 11:6; Ephesians 2, with "this" pointing to the whole of being saved by
grace through faith; Romans 9:16, read as being about salvation; the steps from
each of those to God's work alone; and the Reformed answer to Acts 7:51. The result
does not say that the readings or the steps are right, only that the conclusion
follows from them. Three of the steps are rated `disputed`, each on a reader who
grants its grounds and denies its conclusion. The step that unpacks "God's work
alone" into the conclusion's last two parts carries no rating; it is taken as
what Dort means by the phrase. -/
@[headline]
theorem reformed_establishes : Establishes reformed := by
  establish [solaGratiaDefs]

#print axioms reformed_establishes

/-- Trent's reading, written down: salvation is by grace, the will cooperates
and can refuse, so grace is not effectual of itself and the will is not passive
in being made alive. Claims Trent's documents do not address, such as the
readings of Ephesians 2 and Romans 9, are set true; nothing turns on them. On
these sixteen claims Trent's reading and Arminius's coincide; the two positions
differ in which premises they hold and whom they cite. -/
def trentsReading : Valuation Claim := fun a =>
  match a with
  | .conversionIsGodsWorkAlone => False
  | .graceIsEffectualOfItself => False
  | .willIsPassiveInRegeneration => False
  | _ => True

/-- **Trent's premises do not lead to sola gratia.** A *countermodel* shows it: a
way of holding every one of Trent's premises while denying the conclusion. On
Trent's account the will,
moved by God, cooperates by assenting and can refuse its consent; so the second
and third parts of the conclusion fail. Whether canon 4 really denies the second
part is itself disputed, because Aquinas holds both that the will can refuse,
taken simply, and that the man God moves to grace attains it infallibly; that
dispute is in the rating of the canon's step, not in this result. -/
@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  refute_with trentsReading [solaGratiaDefs]

#print axioms tridentine_not_establishes

/-- Arminius's reading, written down: salvation is by grace, faith is God's gift,
Romans 9:16 is about salvation, and the grace that saves can be refused. It also
sets the will's passivity false. The Remonstrants denied that too, but their
denial of it is not encoded, and nothing in their package turns on it. The
reading of "this" in Ephesians 2:8 is set true, as Hoehner and Robertson hold
it; no reading of the pronoun is cited to Arminius. -/
def arminiusReading : Valuation Claim := fun a =>
  match a with
  | .conversionIsGodsWorkAlone => False
  | .graceIsEffectualOfItself => False
  | .willIsPassiveInRegeneration => False
  | _ => True

/-- **The Remonstrants' premises do not lead to sola gratia either**, though they
grant much of what the Reformed case rests on: that faith is God's gift, given
to those dead in sin, and that Romans 9:16 is about salvation. What they add is
their fourth article, that grace is not irresistible, read from Acts 7:51; what
they leave out is the two steps from those grants to God's work alone. -/
@[headline]
theorem remonstrant_not_establishes : ¬ Establishes remonstrant := by
  refute_with arminiusReading [solaGratiaDefs]

#print axioms remonstrant_not_establishes

/-- Both rivals reach the first part, that salvation is by grace. Trent's premises
deliver it, and so do the Remonstrants', by the same line from Romans 11:6. A
conclusion stated only as "salvation is by grace" would be established by all
three positions and would divide none of them, which is why the conclusion here
has two further parts. -/
@[headline]
theorem rivals_hold_salvation_by_grace :
    Entails tridentine.premises (p .salvationIsByGrace) ∧
      Entails remonstrant.premises (p .salvationIsByGrace) :=
  ⟨by establish [solaGratiaDefs], by establish [solaGratiaDefs]⟩

#print axioms rivals_hold_salvation_by_grace

/-- Trent's premises deny the third part, that the will is passive. Canon 4
condemns anyone who says the will "is merely passive", and the premises deliver
the denial outright. The step is rated `disputed`, because the canon speaks of
the will preparing itself for justification and the Reformed claim is about the
moment of being made alive. -/
@[headline]
theorem trent_denies_passivity :
    Entails tridentine.premises (notP .willIsPassiveInRegeneration) := by
  establish [solaGratiaDefs]

#print axioms trent_denies_passivity

/-- Trent's premises deny the second part too, that grace is effectual of itself.
Canon 4 condemns anyone who says the will "cannot refuse its consent, if it
would", and the premises deliver the denial. The step is rated `disputed`:
Aquinas grants that the will moved by God could, taken simply, refuse, and
holds that the man God moves to grace "will infallibly attain to it". So a
Catholic reader in his school grants the canon and not this conclusion. -/
@[headline]
theorem trent_denies_effectual_grace :
    Entails tridentine.premises (notP .graceIsEffectualOfItself) := by
  establish [solaGratiaDefs]

#print axioms trent_denies_effectual_grace

/-- The Remonstrants' premises deny the second part: grace can be resisted. Their
fourth article reads Acts 7:51 so. -/
@[headline]
theorem remonstrants_deny_effectual_grace :
    Entails remonstrant.premises (notP .graceIsEffectualOfItself) := by
  establish [solaGratiaDefs]

#print axioms remonstrants_deny_effectual_grace

/-! ### Which reading the Reformed case depends on -/

/-- The case does not depend on the reading of "this". Remove the reading on
which "this" in Ephesians 2:8 points to the whole of being saved by grace
through faith, keep everything else, and sola gratia still follows by
Romans 9:16, which does not use the Ephesians grammar. The reading itself is
well supported: Hoehner and Robertson both hold it. -/
@[headline]
theorem touto_not_load_bearing : Establishes reformedWithoutTouto := by
  establish [solaGratiaDefs]

#print axioms touto_not_load_bearing

/-- Nor does it depend on the reading of Romans 9:16. Remove the reading on which the verse
is about salvation, keep everything else, and sola gratia still follows by
Ephesians 2. -/
@[headline]
theorem romans_reading_not_load_bearing : Establishes reformedWithoutRomansReading := by
  establish [solaGratiaDefs]

#print axioms romans_reading_not_load_bearing

/-- The reading on which neither of the two readings holds: "this" in
Ephesians 2:8 does not point to the whole, and Romans 9:16 is about God's choice
of a people for a part in history alone. No reader is cited who holds both
denials; the countermodel shows what follows if both readings go, not that
anyone has given them up. Everything else the Reformed position grants is kept,
the Reformed answer to Acts 7:51 included. -/
def neitherReadingGranted : Valuation Claim := fun a =>
  match a with
  | .toutoRefersToTheWhole => False
  | .romans9_16ConcernsSalvation => False
  | .faithIsGodsGift => False
  | .conversionIsGodsWorkAlone => False
  | .graceIsEffectualOfItself => False
  | .willIsPassiveInRegeneration => False
  | .acts7_51ResistsSavingGrace => False
  | _ => True

/-- The two readings together carry it. Remove both, keep every text and every
step, and sola gratia no longer follows, because nothing is left that reaches
God's work alone. So the Reformed case needs at least one of the two readings,
and either will do. A reading whose removal stops the conclusion following is
called *load-bearing*; here only the pair is. -/
@[headline]
theorem readings_jointly_load_bearing : ¬ Establishes reformedWithoutEitherReading := by
  refute_with neitherReadingGranted [solaGratiaDefs]

#print axioms readings_jointly_load_bearing

/-- The Ephesians strand, argued alone, reaches sola gratia. It rests on two
steps, both rated `disputed`: from "this" to faith as God's gift, and from the
gift to God's work alone. -/
@[headline]
theorem ephesians_strand_establishes : Establishes ephesiansStrand := by
  establish [solaGratiaDefs]

#print axioms ephesians_strand_establishes

/-- So does the Romans strand, on one step rated `disputed`. -/
@[headline]
theorem romans_strand_establishes : Establishes romansStrand := by
  establish [solaGratiaDefs]

#print axioms romans_strand_establishes

/-! ### Where Arminius parts from the Ephesians strand -/

/-- **That faith is God's gift does not settle whether grace can be refused.**
Grant everything the Ephesians strand rests on short of its last step: the
texts, "this" pointing to the whole, and so faith as God's gift, given to those
who were dead in sin. Leave out only the step from that gift to God's work
alone, and sola gratia does not follow.

Arminius grants the texts and that faith is God's gift; the reading of "this" is
Hoehner's and Robertson's, not cited to him. On a reading that grants all of
these, his, the conclusion fails. So where he parts from the strand is the step
from the gift to God's work alone. The encoding writes "faith is God's gift" as
one claim, and Dort and Arminius mean different things by it: for Dort a gift
"in reality conferred", for Arminius one that can be refused. The difference
shows here as Arminius refusing the step. -/
@[headline]
theorem gift_of_faith_does_not_settle_resistibility :
    ¬ Establishes ephesiansWithoutTheGiftStep := by
  refute_with arminiusReading [solaGratiaDefs]

#print axioms gift_of_faith_does_not_settle_resistibility

/-! ### Satisfiability

A list of premises that contradict each other would "prove" anything, so each
position that reaches its conclusion is shown to be holdable without
contradiction, by Dort's reading. These are claims about the health of the
encoding, not about the dispute, and are not headline results. -/

/-- Dort's reading: every claim of the Reformed position holds, and what
Stephen's hearers resisted was the preached word, not the grace that saves. -/
def dortReading : Valuation Claim := fun a =>
  match a with
  | .acts7_51ResistsSavingGrace => False
  | _ => True

/-- The Reformed package has a model. -/
theorem reformed_is_satisfiable : Satisfiable reformed.premises := by
  satisfied_by dortReading [solaGratiaDefs]

/-- The Reformed package without its reading of "this" has a model. -/
theorem reformedWithoutTouto_is_satisfiable : Satisfiable reformedWithoutTouto.premises := by
  satisfied_by dortReading [solaGratiaDefs]

/-- The Reformed package without its reading of Romans 9:16 has a model. -/
theorem reformedWithoutRomansReading_is_satisfiable :
    Satisfiable reformedWithoutRomansReading.premises := by
  satisfied_by dortReading [solaGratiaDefs]

/-- The Ephesians strand alone has a model. -/
theorem ephesiansStrand_is_satisfiable : Satisfiable ephesiansStrand.premises := by
  satisfied_by dortReading [solaGratiaDefs]

/-- The Romans strand alone has a model. -/
theorem romansStrand_is_satisfiable : Satisfiable romansStrand.premises := by
  satisfied_by dortReading [solaGratiaDefs]

end TestimonyArguments.SolaGratia
