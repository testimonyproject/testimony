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

**Why Trent would read it so** is not left to the magisterium. The council read
Paul in the Latin it had declared "authentic" (Session IV), and in Latin
*iustificare* had meant "to make righteous" since Augustine: "what else does the
phrase 'being justified' signify than being made righteous" (*On the Spirit and
the Letter* 26.45). McGrath traces that inheritance through the medieval West.
So this reading rests on a ground of its own — that Augustine glossed the word
so, rated `consensus`, because he did — and a step from the Latin gloss to the
Greek word. That step is where the reading breaks: a gloss in one language does
not fix what a word denotes in another, and the lexical case says what δικαιόω
denotes in Paul (`whereTheLatinReadingFalls`).

**Read as a claim about what God does**, it says that when God justifies he
also renews — pardon and renewal given together, "not to be separated", as the
*Joint Declaration* (§22) confesses. Read so, no lexical argument reaches it:
it can be held with every word the lexical case says about δικαιόω, and Calvin
himself grants that justification and sanctification are inseparable. What
still divides Trent from Paul, on this reading, is the step
`whereTrentPartsFromPaul` names — that a verdict on a finished work excludes
renewal from justification — and that step is `disputed`.

Romans 4 is a second route to the same place, and it does not lift the rating.
God "justifies the ungodly" (4:5), and the blessing of righteousness counted
apart from works is sin not counted (4:6–8): read with the forensic verb, what
is counted to the ungodly is not a righteousness wrought in them. Trent can grant
every word (`trent_grants_romans_four`), and Augustine reads the same verse the
other way — God justifies the ungodly "that he may become a godly one". So the
step is `disputed`, as the step from Galatians is. What Romans 4 adds is not
strength but a second route: on this reading, Paul meets Trent from Galatians
and from Romans 4, and each must be answered on its own
(`whereRomansFourMeetsWhatGodDoes`). The two routes are not wholly independent:
both rest on the forensic sense of the verb, so a reader who denies that sense
denies both.

`whatTrentsDefinitionClaims` is the dilemma, checked: each reading is fair — Trent
read that way still has a model — and each is answered. The first cannot be held
with Paul's word, three times over and each time at a step rated
`wellSupported`: against the lexical case, as Trent states it and as it rests on
the Latin gloss, and against Romans 4 read for the word. The second is untouched
by anything about the word, and conflicts with Paul's gospel and with Romans 4,
each time at a step rated `disputed` — so whoever grants that step rejects this
reading, and whoever denies it need not. Which reading Trent means is
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

/-- Reading Trent's definition as a claim about Paul's word, and reading Paul's
word as the Latin West did. Trent's chapter 8 sets out how "the Apostle's" words
are to be understood, and chapter 7 says the justified are "not only reputed,
but are truly called, and are, just". The council read Paul in the Latin it had
declared "authentic" (Session IV), where *iustificare* had meant "to make
righteous" since Augustine; McGrath traces that inheritance. Rated `disputed`:
whether the council defines the word or the reality is itself argued, and the
step from the Latin gloss to the Greek word is what the lexical case denies. -/
def trentReadsPaulsWord : Source :=
  { primary := .work tannerDecrees
      (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 8")
  , supporting :=
      [ .work tannerDecrees
          (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 7")
      , .work npnfAugustineAntiPelagian
          (.sectionRef "On the Spirit and the Letter, ch. 45 (26.45)")
      , .work mcgrathIustitiaDei .whole ]
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

/-- Trent's definition, **read as a claim about what Paul's word means** — and
resting that reading, as the Latin West did, on Augustine's gloss: "being
justified" is "being made righteous". -/
@[solaFideDefs]
def trentOnPaulsWord : Reading Claim :=
  { name := "as what Paul's word means"
  , commits := p .paulsJustifyDenotesRenewal
  , grounds :=
      [ p .augustineReadsJustifyAsMakeRighteous
      , p .augustineReadsJustifyAsMakeRighteous ➝ p .paulsJustifyDenotesRenewal ]
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

/-- Trent, read as a claim about Paul's word, still concludes what Trent
concludes: a reading only adds premises. -/
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

/-- **Why Paul's word stands against the Latin reading of it.** The same crux,
and a second break in the same horn: Trent rests its reading of Paul's word on
Augustine's gloss, and the step from that gloss to what the Greek word means is
what breaks. That Augustine glossed it so is not in question — it is rated
`consensus` — but a Latin gloss does not fix what δικαιόω denotes in Paul, and
the forensic sense, Paul's own words for renewal and the rule of least meaning
say it does not. -/
def whereTheLatinReadingFalls : Because lexicalCase tridentineOnPaulsWord :=
  Because.ofChecks lexicalLine.step lexicalLine.grounds [] lexicalLine.grounds
    [ p .augustineReadsJustifyAsMakeRighteous
    , p .augustineReadsJustifyAsMakeRighteous ➝ p .paulsJustifyDenotesRenewal ]
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

/-! ### Romans 4 -/

/-- **Romans 4 denies Trent's definition**: Paul glosses the righteousness God
counts to the ungodly as sin not counted, and with the forensic sense of the
verb, renewal is no part of justification. -/
@[headline]
theorem romansFourCase_establishes : Establishes romansFourCase := by
  establish [solaFideDefs, caseOf]

#print axioms romansFourCase_establishes

/-- Romans 4's case has a model: Paul's gospel's world. -/
theorem romansFourCase_is_satisfiable : Satisfiable romansFourCase.premises := by
  satisfied_by galatianGospelReading [solaFideDefs, caseOf]

/-- **Romans 4, read by the rule of least meaning, says what Paul's word means**:
the verb Paul glosses as sin not counted does not also denote the renewal of the
inward man. -/
@[headline]
theorem romansFourOnTheWord_establishes : Establishes romansFourOnTheWord := by
  establish [solaFideDefs, caseOf]

#print axioms romansFourOnTheWord_establishes

/-- The exegetical route to Paul's word has a model: the lexical case's world. -/
theorem romansFourOnTheWord_is_satisfiable : Satisfiable romansFourOnTheWord.premises := by
  satisfied_by lexicalReading [solaFideDefs, caseOf]

/-- **Trent can grant every word of Romans 4:5–8**, as Augustine does: God
justifies the ungodly, and the blessing is sin not counted. The texts are
common ground; the reading is not. -/
theorem trent_grants_romans_four :
    Grants tridentineCase (⋀ [p .romans4_4_5, p .romans4_6_8]) := by
  satisfied_by jointDeclarationReading [Grants, solaFideDefs]

/-- **Romans 4, read for Paul's word, does not reach the second reading either.**
Trent, read as a claim about what God does, can be held with every premise of
it: the exegesis says what the counting is, and this reading says nothing about
the word. -/
theorem romans_four_on_the_word_does_not_reach_what_god_does :
    Satisfiable (romansFourOnTheWord.premises ++ tridentineOnWhatGodDoes.premises) := by
  satisfied_by trentGrantsTheWordReading [solaFideDefs, caseOf]

/-- **Why Romans 4 stands against Trent, read as a claim about Paul's word.** The
crux is the step from Paul's gloss — the righteousness counted to the ungodly is
sin not counted — by the rule of least meaning, to "the verb does not also denote
renewal". What it breaks is Trent's definition with the reading, and every link
of the break is rated `wellSupported` or better: an exegetical route to where the
lexical case arrives lexically. -/
def whereRomansFourMeetsTheWordReading : Because romansFourOnTheWord tridentineOnPaulsWord :=
  Because.ofChecks glossByLeastMeaning
    (romansFourExegesisLine.grounds ++ [p .leastMeaning, romansFourExegesisLine.step]) []
    (romansFourExegesisLine.grounds ++ [p .leastMeaning, romansFourExegesisLine.step])
    [ p .justificationIncludesSanctification
    , p .justificationIncludesSanctification ➝ p .paulsJustifyDenotesRenewal ]
    .derives romansFourOnTheWord_establishes romansFourOnTheWord_is_satisfiable
    (by simp [romansFourOnTheWord, caseOf, romansFourExegesisLine])
    (fun φ hφ => by
      simp only [romansFourOnTheWord, caseOf, romansFourExegesisLine, List.flatMap_cons,
        List.flatMap_nil, List.map_cons, List.map_nil, List.append_nil, List.mem_append,
        List.mem_cons, List.not_mem_nil, or_false] at hφ ⊢
      tauto)
    (by simp [solaFideDefs, tridentinePremises, Line.premises])
    (by decide +kernel)

/-- **Why Romans 4 stands against Trent, read as a claim about what God does.**
The crux is the step from Paul's gloss, with the forensic sense of the verb, to
"renewal is no part of justification". It breaks Trent's definition and nothing
else. It is rated `disputed`, as the step from Galatians is — Augustine grants
the same verses and reads them the other way, God justifying the ungodly "that
he may become a godly one" — so on this reading of Trent, Paul meets it by two
routes, from Galatians and from Romans 4, each at a `disputed` step. The routes
share one ground, the forensic sense of the verb. -/
def whereRomansFourMeetsWhatGodDoes : Because romansFourCase tridentineOnWhatGodDoes :=
  Because.ofChecks countedExcludesRenewal
    (romansFourExegesisLine.grounds ++ [p .dikaioIsForensic, romansFourExegesisLine.step]) []
    (romansFourExegesisLine.grounds ++ [p .dikaioIsForensic, romansFourExegesisLine.step])
    [p .justificationIncludesSanctification]
    .derives romansFourCase_establishes romansFourCase_is_satisfiable
    (by simp [romansFourCase, caseOf, romansFourExegesisLine])
    (fun φ hφ => by
      simp only [romansFourCase, caseOf, romansFourExegesisLine, List.flatMap_cons,
        List.flatMap_nil, List.map_cons, List.map_nil, List.append_nil, List.mem_append,
        List.mem_cons, List.not_mem_nil, or_false] at hφ ⊢
      tauto)
    (by simp [solaFideDefs, tridentinePremises, Line.premises])
    (by decide +kernel)

/-! ### The dilemma -/

/-- **What Trent's definition claims, read both ways.** The claim is Trent's
definition — justification is the sanctification and renewal of the inward
man.

Read as a claim about what Paul's word means (δικαιόω denotes that renewal), it
cannot be held with Paul's word, three times over, each at a step rated
`wellSupported`: the lexical case against the definition as Trent states it; the
lexical case against the Latin gloss the reading rests on ("being justified" as
"being made righteous"); and Romans 4 read for the word.

Read as a claim about what God does in justifying (he also renews), nothing
about the word reaches it: neither the lexical case nor Romans 4 read for the
word. It conflicts with Paul twice, each time at a step rated `disputed`: with
his gospel in Galatians, at the step `whereTrentPartsFromPaul` names, and with
Romans 4, at his reading of the ungodly justified. A reader who grants those
steps rejects this reading; one who denies them, as Augustine and the *Joint
Declaration* do, need not.

Each reading is fair: Trent read either way still has a model. -/
def whatTrentsDefinitionClaims : Dilemma tridentineCase where
  claim := p .justificationIncludesSanctification
  horns :=
    [ { reading := trentOnPaulsWord
      , fair := tridentineOnPaulsWord_is_satisfiable
      , fates :=
          [ .falls lexicalCase whereTrentsWordReadingFalls
          , .falls lexicalCase whereTheLatinReadingFalls
          , .falls romansFourOnTheWord whereRomansFourMeetsTheWordReading ]
      , answered := by simp }
    , { reading := trentOnWhatGodDoes
      , fair := tridentineOnWhatGodDoes_is_satisfiable
      , fates :=
          [ .unreached lexicalCase lexicalCase_establishes
              lexical_case_does_not_reach_what_god_does
          , .unreached romansFourOnTheWord romansFourOnTheWord_establishes
              romans_four_on_the_word_does_not_reach_what_god_does
          , .falls galatianGospel whereTrentsGraceReadingFalls
          , .falls romansFourCase whereRomansFourMeetsWhatGodDoes ]
      , answered := by simp } ]
  claim_mem := by simp [solaFideDefs, tridentinePremises, Line.premises]
  two := by simp

end Testimony.Arguments.SolaFide
