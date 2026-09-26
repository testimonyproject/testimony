import Testimony.Arguments.SolaFide.Gospel
import Testimony.Logic.Dilemma

/-!
# Arguments.SolaFide.Definition — what Trent's definition claims

Trent defines justification as "not remission of sins merely, but also the
sanctification and renewal of the inward man" (Session VI, ch. 7). The Reformed
deny it, and `whereTrentPartsFromPaul` locates the denial at one step. But the
definition can be read two ways, and the two readings meet different
objections.

**Read as a claim about Paul's word**, it says that δικαιόω, in Paul, denotes
the renewal of the inward man. Trent invites the reading: chapter 8 sets out how
"the Apostle's" words — justified "by faith and freely" — are to be understood,
and chapter 7 says that the justified "are not only reputed, but are truly
called, and are, just". Read so, the definition is a lexical claim, and it meets
a lexical answer: δικαιόω is forensic, Paul names renewal with words of its own
and sets them beside it (Titus 3:5–7; 1 Corinthians 6:11), and a word
contributes the least meaning its context requires (Joos; Silva). To read
renewal into the verdict from the doctrine is what Barr called illegitimate
totality transfer. Every link of that answer is rated above `disputed`.

**Read as a claim about what God does**, it says that when God justifies he
also renews — pardon and renewal given together, "not to be separated", as the
*Joint Declaration* (§22) confesses. Read so, no lexical argument reaches it:
it can be held with every word the lexical case says about δικαιόω, and Calvin
himself grants that justification and sanctification are inseparable. What
still divides Trent from Paul, on this reading, is the step
`whereTrentPartsFromPaul` names — that a verdict on a finished work excludes
renewal from justification — and that step is `disputed`.

`whatTrentsDefinitionClaims` is the dilemma, checked: each reading is fair — Trent
read that way still has a model — and each is answered. The first falls to the
lexical case at a step rated `wellSupported`; the second is untouched by it and
falls to Paul's gospel at a step rated `disputed`. Which reading Trent means is
not something the dilemma decides. What it shows is what each reading costs.

`paulNamesRenewalOtherwise` is grounded in scripture alone — what the texts
say, and no more — and the manifest lists it so.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic

attribute [solaFideDefs] ArgumentPackage.readAs

/-! ### The lexical case holds -/

/-- The world of the lexical case: every word as it reads it, and δικαιόω
denoting the verdict and not renewal. -/
def lexicalReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | _ => True

/-- **Paul's δικαιόω does not denote the renewal of the inward man**, from the
forensic sense, Paul's own words for renewal, and the rule of least meaning. -/
@[headline]
theorem lexicalCase_establishes : Establishes lexicalCase := by
  establish [solaFideDefs]

#print axioms lexicalCase_establishes

/-- The lexical case's premises have a model. -/
theorem lexicalCase_is_satisfiable : Satisfiable lexicalCase.premises := by
  satisfied_by lexicalReading [solaFideDefs]

/-! ### Two readings of Trent's definition -/

/-- Reading Trent's definition as a claim about Paul's word. Trent's chapter 8
sets out how "the Apostle's" words are to be understood, and chapter 7 says the
justified are "not only reputed, but are truly called, and are, just". Rated
`disputed`: whether the council defines the word or the reality is itself
argued. -/
def trentReadsPaulsWord : Source :=
  { primary := .work tannerDecrees
      (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 8")
  , supporting :=
      [.work tannerDecrees
        (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 7")]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- Reading Trent's definition as a claim about what God does in justifying: in
the *Joint Declaration*, forgiveness and the renewal the Spirit effects are two
aspects of God's gracious action, "not to be separated" (§22). Rated
`disputed`, for the same reason as the other reading. -/
def trentReadsGrace : Source :=
  { primary := .work jointDeclarationJustification (.sectionRef "§22")
  , supporting :=
      [.work tannerDecrees
        (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 7")]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- Trent's definition, **read as a claim about what Paul's word means**. -/
@[solaFideDefs]
def trentOnPaulsWord : Reading Claim :=
  { name := "as what Paul's word means"
  , commits := p .paulsJustifyDenotesRenewal
  , source := trentReadsPaulsWord }

/-- Trent's definition, **read as a claim about what God does in justifying**. -/
@[solaFideDefs]
def trentOnWhatGodDoes : Reading Claim :=
  { name := "as what God does in justifying"
  , commits := p .justifyingGraceRenews
  , source := trentReadsGrace }

/-- Trent, with its definition read as a claim about Paul's word. -/
@[solaFideDefs]
def tridentineOnPaulsWord : ArgumentPackage Claim :=
  tridentineCase.readAs (p .justificationIncludesSanctification) trentOnPaulsWord

/-- Trent, with its definition read as a claim about what God does. -/
@[solaFideDefs]
def tridentineOnWhatGodDoes : ArgumentPackage Claim :=
  tridentineCase.readAs (p .justificationIncludesSanctification) trentOnWhatGodDoes

/-- Trent, read either way, still concludes what it concluded: a reading only
adds. -/
theorem tridentineOnPaulsWord_establishes : Establishes tridentineOnPaulsWord := by
  establish [solaFideDefs]

/-- Trent's world, reading Paul's word as it does: δικαιόω denotes making just,
and not a verdict only; justification includes renewal, faith without charity
does not suffice, and justification is not by faith alone. -/
def trentOnPaulsWordReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | .dikaioIsForensic => False
  | _ => True

/-- **Trent, read as a claim about Paul's word, holds together.** The horn is
fair: it does not fall to itself. -/
theorem tridentineOnPaulsWord_is_satisfiable :
    Satisfiable tridentineOnPaulsWord.premises := by
  satisfied_by trentOnPaulsWordReading [solaFideDefs]

/-- Trent read as a claim about what God does, with every word of the lexical
case granted: δικαιόω forensic, Paul's own words for renewal, the rule of least
meaning, and δικαιόω not denoting renewal. God, in justifying, also renews. -/
def trentGrantsTheWordReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | .paulsJustifyDenotesRenewal => False
  | _ => True

/-- **Trent, read as a claim about what God does, holds together.** -/
theorem tridentineOnWhatGodDoes_is_satisfiable :
    Satisfiable tridentineOnWhatGodDoes.premises := by
  satisfied_by trentGrantsTheWordReading [solaFideDefs]

/-- **The lexical case does not reach the second reading.** Trent, read as a
claim about what God does, can be held with every premise of the lexical case:
the rule of least meaning governs what Paul's word says, and this reading says
nothing about the word. -/
theorem lexical_case_does_not_reach_what_god_does :
    Satisfiable (lexicalCase.premises ++ tridentineOnWhatGodDoes.premises) := by
  satisfied_by trentGrantsTheWordReading [solaFideDefs]

/-! ### Where each reading falls -/

/-- **Why Paul's word stands against Trent, read as a claim about it.** The crux
is the lexical step: with the forensic sense, Paul's own words for renewal and
the rule of least meaning, δικαιόω does not denote renewal. What it breaks is
Trent's definition together with the reading — nothing else in Trent — and
every link of the break is rated above `disputed`. -/
def whereTrentsWordReadingFalls : Because lexicalCase tridentineOnPaulsWord :=
  Because.ofChecks lexicalLine.step lexicalLine.grounds [] lexicalLine.grounds
    [ p .justificationIncludesSanctification
    , p .justificationIncludesSanctification ➝ p .paulsJustifyDenotesRenewal ]
    .derives lexicalCase_establishes lexicalCase_is_satisfiable
    (by simp [lexicalCase, Line.asPackage, Line.premises])
    (fun φ hφ => by
      simp only [lexicalCase, Line.asPackage, Line.premises, List.mem_append,
        List.mem_cons, List.not_mem_nil, or_false] at hφ ⊢
      tauto)
    (by simp [solaFideDefs, tridentinePremises, Line.premises])
    (by decide +kernel)

/-- **Why Paul's gospel stands against Trent, read as a claim about what God
does.** The same crux as `whereTrentPartsFromPaul`, and the same break: the step
from a verdict on a finished work to "renewal is no part of justification",
against Trent's definition. On this reading that step is all that divides them,
and it is rated `disputed`. -/
def whereTrentsGraceReadingFalls : Because galatianGospel tridentineOnWhatGodDoes :=
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

/-! ### The dilemma -/

/-- **What Trent's definition claims, read both ways.** Read as a claim about
Paul's word, it falls to the lexical case, at a step rated `wellSupported`. Read
as a claim about what God does, the lexical case does not reach it, and it falls
to Paul's gospel at the step `whereTrentPartsFromPaul` names, rated `disputed`.
Each reading is fair: Trent read either way still has a model. -/
def whatTrentsDefinitionClaims : Dilemma tridentineCase where
  claim := p .justificationIncludesSanctification
  horns :=
    [ { reading := trentOnPaulsWord
      , fair := tridentineOnPaulsWord_is_satisfiable
      , fates := [.falls lexicalCase whereTrentsWordReadingFalls]
      , answered := by simp }
    , { reading := trentOnWhatGodDoes
      , fair := tridentineOnWhatGodDoes_is_satisfiable
      , fates :=
          [ .unreached lexicalCase lexicalCase_establishes
              lexical_case_does_not_reach_what_god_does
          , .falls galatianGospel whereTrentsGraceReadingFalls ]
      , answered := by simp } ]
  claim_mem := by simp [solaFideDefs, tridentinePremises, Line.premises]
  two := by simp

end Testimony.Arguments.SolaFide
