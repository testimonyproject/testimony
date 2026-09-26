import Testimony.Arguments.SolaFide.Dispute
import Testimony.Logic.Because

/-!
# Arguments.SolaFide.Gospel — where Trent parts from Paul

Paul's direct answer to anything added to the gospel is Galatians: another
gospel, whoever preaches it accursed (1:6–9); if righteousness came by the law,
Christ died for nothing (2:21); whoever would be justified by the law is severed
from Christ (5:2–4). The gospel itself is that Christ died for our sins
(1 Corinthians 15:3).

Set against Trent's definition of justification — "not remission of sins
merely, but also the sanctification and renewal of the inward man" (Session VI,
ch. 7) — the question is exactly where the two part. This module answers it in
three steps, each checked.

**What Trent grants.** Every text of the line. And the forensic sense of
Paul's verb: the *Joint Declaration* (1999), signed by the Catholic Church,
confesses that God "no longer imputes to them their sin" (§22), and modern Greek
scholarship across traditions reads δικαιόω as a verdict — the standard lexicon,
Morris, Moo, Irons, Wright, and the Catholic exegete Fitzmyer
(`dikaioIsForensic`, rated `wellSupported`).

**What Trent denies.** One step: that a verdict on the ground of a finished work
excludes the renewal wrought in us. The same paragraph of the *Joint
Declaration* holds forgiveness and the love the Spirit effects "not to be
separated", and Gorman reads the verdict as an effective word that transforms.

**Where they part.** `whereTrentPartsFromPaul` finds it mechanically: the crux
is that step, and what it breaks in Trent is its definition, and nothing else.

What this does not show is that the step is true. It shows that it is the whole
of the disagreement: grant it, and Trent's definition cannot stand; deny it, and
Paul's gospel as encoded here does not reach Trent's definition at all.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Logic

/-! ### The gospel line holds -/

/-- The world of Paul's gospel as this line reads it: every text true, Christ's
work the whole ground, the verdict forensic — and justification not the renewal
of the inward man. -/
def galatianGospelReading : Valuation Claim := fun a =>
  match a with
  | .justificationIncludesSanctification => False
  | _ => True

/-- **Paul's gospel denies Trent's definition.** From Galatians 1:6–9, 2:21,
5:2–4 and 1 Corinthians 15:3, read as one claim, with the forensic sense of
δικαιόω: justification is not the renewal of the inward man. -/
@[headline]
theorem galatianGospel_establishes : Establishes galatianGospel := by
  establish [solaFideDefs]

#print axioms galatianGospel_establishes

/-- The gospel line's premises have a model. -/
theorem galatianGospel_is_satisfiable : Satisfiable galatianGospel.premises := by
  satisfied_by galatianGospelReading [solaFideDefs]

/-! ### What Trent grants -/

/-- Trent's world, with the *Joint Declaration*'s confession added: God no longer
imputes sin — the verb is forensic — and every text of the gospel line holds.
Justification still includes renewal, faith without charity does not suffice,
and justification is not by faith alone. -/
def jointDeclarationReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | _ => True

/-- **Trent can grant every text of the gospel line.** Nothing Trent holds denies
that Christ died for our sins, that righteousness by the law would make his
death needless, or that another gospel is accursed. -/
theorem trent_grants_the_gospel_texts :
    Grants tridentineCase
      (⋀ [ p .galatians1_6_9, p .firstCorinthians15_3, p .galatians2_21
         , p .galatians5_2_4, p .romans8_33_34 ]) := by
  satisfied_by jointDeclarationReading [Grants, solaFideDefs]

/-- **Trent can grant that Paul's verb is forensic**, as the *Joint Declaration*
does: God no longer imputes sin. The lexical question is not where they part. -/
theorem trent_grants_the_forensic_sense : Grants tridentineCase (p .dikaioIsForensic) := by
  satisfied_by jointDeclarationReading [Grants, solaFideDefs]

/-! ### Where Trent parts from Paul -/

/-- **Where Trent parts from Paul.** The crux is one step: if justification is
God's verdict on the ground of Christ's finished work, the renewal of the inward
man is no part of it (`verdictExcludesRenewal`; Westminster XI.1). What it breaks
in Trent is its definition — justification "not remission of sins merely, but
also the sanctification and renewal of the inward man" (Session VI, ch. 7) — and
nothing else in Trent's case: not its account of merit, not its reading of works.

The break needs the gospel line's grounds as well, and says so: the four texts,
Paul's reading of them, Romans 8:33–34 and the forensic sense of the verb. Trent
can grant every one of those (`trent_grants_the_gospel_texts`,
`trent_grants_the_forensic_sense`); it is the step that it denies, with the
*Joint Declaration*: forgiveness and renewal are "not to be separated". -/
def whereTrentPartsFromPaul : Because galatianGospel tridentineCase :=
  Because.ofChecks verdictExcludesRenewal
    (galatianGospelLine.premises ++ [p .romans8_33_34, p .dikaioIsForensic]) []
    (galatianGospelLine.premises ++ [p .romans8_33_34, p .dikaioIsForensic])
    [p .justificationIncludesSanctification]
    .derives galatianGospel_establishes galatianGospel_is_satisfiable
    (by simp [galatianGospel])
    (fun φ hφ => by
      simp only [galatianGospel, List.mem_append, List.mem_cons, List.not_mem_nil,
        or_false] at hφ ⊢
      tauto)
    (by simp [solaFideDefs, tridentinePremises, Line.premises])
    (by decide +kernel)

end Testimony.Arguments.SolaFide
