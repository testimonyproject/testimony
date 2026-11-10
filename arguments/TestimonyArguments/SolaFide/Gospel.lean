import TestimonyArguments.Meanings.SolaFide
import TestimonyArguments.SolaFide.Results
import Testimony.Logic.Dispute
import Testimony.Logic.Because

/-!
# TestimonyArguments.SolaFide.Gospel — where Trent parts from Paul

Paul's answer to anything added to the gospel is the letter to the Galatians. A
different gospel is no gospel, and whoever preaches it is accursed (1:6–9). "If
righteousness were through the law, then Christ died for no purpose" (2:21).
Whoever would be justified by the law is "severed from Christ" (5:2–4). The
gospel itself is that "Christ died for our sins" (1 Corinthians 15:3).

Trent defines justification as "not remission of sins merely, but also the
sanctification and renewal of the inward man" (Session VI, ch. 7). This section
asks where exactly Trent and Paul part, and answers in three steps, each
checked.

**What Trent accepts.** Every text above. And that Paul's verb "justify"
(δικαιόω) is a courtroom word, a verdict. The *Joint Declaration on the Doctrine
of Justification* (1999), signed by the Catholic Church, confesses that God "no
longer imputes to them their sin" (§22). Scholars across the traditions read the
verb as a verdict: the standard lexicon, Morris, Moo, Irons, Wright, and the
Catholic scholar Fitzmyer (`dikaioIsForensic`, rated `wellSupported`).

**What Trent denies.** One step: that a verdict given on the ground of Christ's
finished work leaves no room for the renewal worked in us to be part of
justification. The same paragraph of the *Joint Declaration* holds that
forgiveness and the love the Spirit brings about are "not to be separated".
Gorman reads the verdict as a word that does what it says and changes the
person.

**Where they part.** `whereTrentPartsFromPaul` identifies it by checking: the
disagreement is that one step, and what the step contradicts in Trent is its
definition, and nothing else.

This does not show that the step is true. It shows that the step is the whole of
the disagreement. Grant it, and Trent's definition cannot stand. Deny it, and
Paul's gospel, as written out here, does not reach Trent's definition at all.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Logic

/-! ### The gospel line holds together -/

/-- Paul's gospel as this line reads it: every text true, Christ's work the whole
ground, the verdict a courtroom one, and justification not the renewal of the
inward person. -/
def galatianGospelReading : Valuation Claim := fun a =>
  match a with
  | .justificationIncludesSanctification => False
  | _ => True

/-- **Paul's gospel, read this way, denies Trent's definition.** From Galatians
1:6–9, 2:21, 5:2–4 and 1 Corinthians 15:3, read as one claim, with "justify"
(δικαιόω) as a courtroom word: justification is not the renewal of the inward
person.

What this does not claim: that the reading is beyond dispute. Two of its steps
are rated `disputed`, and Trent accepts every text. -/
@[headline]
theorem galatianGospel_establishes : Establishes galatianGospel := by
  establish [solaFideDefs]

#print axioms galatianGospel_establishes

/-- The gospel line's premises can all be true together. -/
theorem galatianGospel_is_satisfiable : Satisfiable galatianGospel.premises := by
  satisfied_by galatianGospelReading [solaFideDefs]

/-! ### What Trent accepts -/

/-- Trent's position, with what the *Joint Declaration* confesses added: God no
longer counts sin against the justified, so the verb is a courtroom word, and
every text of the gospel line holds. Justification still includes renewal, faith
without charity does not suffice, and justification is not by faith alone.

Having granted that the verb is a courtroom word, this reading does not also
hold that Paul's verb means renewal: the two exclude each other
(`TestimonyArguments.Meanings.SolaFide.joins`). Of the other pairs of claims
that exclude each other, it holds the Greek text of Revelation 22:11 and Sirach
18:22, and that James uses "justify" as Paul does. -/
def jointDeclarationReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .james2_24Compatible => False
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | _ => True

/-- **Trent can accept every text of the gospel line.** Nothing Trent holds denies
that Christ died for our sins, that righteousness through the law would make his
death needless, or that another gospel is accursed. -/
theorem trent_grants_the_gospel_texts :
    Grants tridentineCase
      (⋀ [ p .galatians1_6_9, p .firstCorinthians15_3, p .galatians2_21
         , p .galatians5_2_4, p .romans8_33_34 ]) := by
  satisfied_by jointDeclarationReading [Grants, solaFideDefs]

/-- **Trent can accept that Paul's verb is a courtroom word**, as the *Joint
Declaration* does: God no longer counts sin. The meaning of the word is not
where they part. -/
theorem trent_grants_the_forensic_sense : Grants tridentineCase (p .dikaioIsForensic) := by
  satisfied_by jointDeclarationReading [Grants, solaFideDefs]

/-! ### Where Trent parts from Paul -/

/-- **Where Trent parts from Paul.** At one step: if justification is God's verdict
on the ground of Christ's finished work, then the renewal of the inward person
is no part of it (`verdictExcludesRenewal`; Westminster XI.1).

What that step contradicts in Trent is its definition, justification "not
remission of sins merely, but also the sanctification and renewal of the inward
man" (Session VI, ch. 7), and nothing else: not Trent's account of merit, and
not its reading of works.

The contradiction needs the gospel line's starting points as well: the four
texts, the reading of them, Romans 8:33–34 and the courtroom sense of the verb.
Trent can accept every one of those (`trent_grants_the_gospel_texts`,
`trent_grants_the_forensic_sense`). It is the step that Trent denies, with the
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

end TestimonyArguments.SolaFide
