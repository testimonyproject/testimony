import TestimonyArguments.SolaFide.Gospel
import Testimony.Logic.Dilemma

/-!
# TestimonyArguments.SolaFide.Definition — what Trent's definition claims

Trent defines justification as "not remission of sins merely, but also the
sanctification and renewal of the inward man" (Session VI, ch. 7). The Reformed
deny it, and `whereTrentPartsFromPaul` places the denial at one step. But the
definition can be taken two ways, and each meets a different objection.

**Taken as a claim about Paul's word**, it says that "justify" (δικαιόω), in
Paul, means the renewal of the inward person. Trent invites this. Chapter 8 sets
out how "the Apostle's" words, justified "by faith and freely", are to be
understood, and chapter 7 says that the justified "are not only reputed, but are
truly called, and are, just". Taken this way, the definition is a claim about a
word, and it meets an answer about the word. The verb is a courtroom word. Paul
has other words for renewal and sets them beside it (Titus 3:5–7; 1 Corinthians
6:11). And a word contributes the least meaning its context requires (Joos;
Silva). To read renewal into the verdict from the doctrine is what Barr called
"illegitimate totality transfer". Every link of that answer is rated above
`disputed`.

**Why Trent would take it so** can be said from history. The council read Paul
in the Latin it had declared "authentic" (Session IV), and in Latin "justify"
(*iustificare*) had meant "to make righteous" since Augustine: "what else does
the phrase 'being justified' signify than being made righteous" (*On the Spirit
and the Letter* 26.45). McGrath traces that inheritance through the medieval
West. So this way of taking the definition has a starting point of its own, that
Augustine explained the word so, which is rated `consensus` because he did. It
then needs a step from the Latin explanation to the Greek word, and that step is
where it fails. An explanation in one language does not settle what a word means
in another, and the argument from usage says what the Greek word means in Paul
(`whereTheLatinReadingFalls`).

**Taken as a claim about what God does**, it says that when God justifies he
also renews: pardon and renewal given together, "not to be separated", as the
*Joint Declaration* (§22) confesses. Taken this way, no argument about the word
reaches it. It can be held with everything the argument from usage says about
"justify", and Calvin himself grants that justification and sanctification
cannot be separated. What still divides Trent from Paul is the step
`whereTrentPartsFromPaul` names: that a verdict on Christ's finished work
excludes renewal from justification. That step is `disputed`.

Romans 4 leads to the same place by another way, and does not raise the rating.
God "justifies the ungodly" (4:5), and the blessing of righteousness counted
apart from works is sin not counted (4:6–8). Read with the courtroom sense of
the verb, what is counted to the ungodly is not a righteousness worked in them.
Trent can accept every word (`trent_grants_romans_four`), and Augustine reads
the same verse the other way: God justifies the ungodly "that he may become a
godly one". So the step is `disputed`, as the step from Galatians is. Romans 4
adds a second argument, not a stronger one. Taken this way, Trent is met by Paul
from Galatians and from Romans 4, and each has to be answered
(`whereRomansFourMeetsWhatGodDoes`). The two arguments are not wholly separate:
both start from the courtroom sense of the verb, so a reader who denies that
sense denies both.

`whatTrentsDefinitionClaims` puts the two together, and checks them. Each way of
taking the definition is fair, since Trent taken that way can still be held
without contradiction. Each is answered. The first cannot be held with what
Paul's word means: it fails three times, each at a step rated `wellSupported`.
The second is untouched by anything about the word, and conflicts with Paul's
gospel and with Romans 4, each time at a step rated `disputed`. So a reader who
grants that step rejects the definition taken that way, and a reader who denies
it need not. Which way Trent means it is not something this section decides. It
shows what each costs.

One premise, that Paul has his own words for renewal
(`paulNamesRenewalOtherwise`), is cited to Scripture alone: it says what the
texts say and no more.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic

attribute [solaFideDefs] ArgumentPackage.readAs

/-! ### The argument from Paul's word holds together -/

/-- The reading on which the argument from Paul's word holds: every word as that
argument takes it, and "justify" meaning the verdict and not renewal. -/
def lexicalReading : Valuation Claim := fun a =>
  match a with
  | .paulsJustifyDenotesRenewal => False
  | _ => True

/-- **Paul's "justify" (δικαιόω) does not mean the renewal of the inward person.**
This follows from three things: the verb is a courtroom word; Paul has other
words for renewal; and a word contributes the least meaning its context
requires.

What this does not claim: anything about what God does when he justifies. It is
a result about a word. -/
@[headline]
theorem lexicalCase_establishes : Establishes lexicalCase := by
  establish [solaFideDefs]

#print axioms lexicalCase_establishes

/-- The premises of the argument from Paul's word can all be true together. -/
theorem lexicalCase_is_satisfiable : Satisfiable lexicalCase.premises := by
  satisfied_by lexicalReading [solaFideDefs]

/-! ### Two ways of taking Trent's definition -/

/-- Taking Trent's definition as a claim about Paul's word, and taking Paul's word
as the Latin West did. Trent's chapter 8 sets out how "the Apostle's" words are
to be understood, and chapter 7 says the justified are "not only reputed, but
are truly called, and are, just". The council read Paul in the Latin it had
declared "authentic" (Session IV), where "justify" (*iustificare*) had meant "to
make righteous" since Augustine. McGrath traces that inheritance. Rated
`disputed`: whether the council defines the word or the reality is itself
argued, and the step from the Latin explanation to the Greek word is what the
argument from Paul's word denies. -/
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

/-- Taking Trent's definition as a claim about what God does in justifying. In the
*Joint Declaration*, forgiveness and the renewal the Spirit brings about are two
sides of God's gracious action, "not to be separated" (§22). Rated `disputed`,
for the same reason as the other way of taking it. -/
def trentReadsGrace : Source :=
  { primary := .work jointDeclarationJustification (.sectionRef "§22")
  , supporting :=
      [.work tannerDecrees
        (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 7")]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- Trent's definition, **taken as a claim about what Paul's word means**, and
resting, as the Latin West did, on Augustine's explanation: "being justified" is
"being made righteous". -/
@[solaFideDefs]
def trentOnPaulsWord : Reading Claim :=
  { name := "as what Paul's word means"
  , commits := p .paulsJustifyDenotesRenewal
  , grounds :=
      [ p .augustineReadsJustifyAsMakeRighteous
      , p .augustineReadsJustifyAsMakeRighteous ➝ p .paulsJustifyDenotesRenewal ]
  , source := trentReadsPaulsWord }

/-- Trent's definition, **taken as a claim about what God does in justifying**. -/
@[solaFideDefs]
def trentOnWhatGodDoes : Reading Claim :=
  { name := "as what God does in justifying"
  , commits := p .justifyingGraceRenews
  , source := trentReadsGrace }

/-- Trent, with its definition taken as a claim about Paul's word. -/
@[solaFideDefs]
def tridentineOnPaulsWord : ArgumentPackage Claim :=
  tridentineCase.readAs (p .justificationIncludesSanctification) trentOnPaulsWord

/-- Trent, with its definition taken as a claim about what God does. -/
@[solaFideDefs]
def tridentineOnWhatGodDoes : ArgumentPackage Claim :=
  tridentineCase.readAs (p .justificationIncludesSanctification) trentOnWhatGodDoes

/-- Trent, taken as a claim about Paul's word, still concludes what Trent concludes:
taking the definition one way only adds premises. -/
theorem tridentineOnPaulsWord_establishes : Establishes tridentineOnPaulsWord := by
  establish [solaFideDefs]

/-- Trent's position, taking Paul's word as it does: "justify" means making just,
and not a verdict only; justification includes renewal; faith without charity
does not suffice; and justification is not by faith alone. -/
def trentOnPaulsWordReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | .dikaioIsForensic => False
  | _ => True

/-- **Trent, taken as a claim about Paul's word, can be held without
contradiction.** So this branch of the question is a fair one: the position does
not refute itself. -/
theorem tridentineOnPaulsWord_is_satisfiable :
    Satisfiable tridentineOnPaulsWord.premises := by
  satisfied_by trentOnPaulsWordReading [solaFideDefs]

/-- Trent taken as a claim about what God does, with everything the argument from
Paul's word says accepted: the verb a courtroom word, Paul's own words for
renewal, the rule of least meaning, and "justify" not meaning renewal. God, in
justifying, also renews. -/
def trentGrantsTheWordReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | .justificationDistinctFromSanctification => False
  | .faithIsSufficient => False
  | .justificationByFaithAlone => False
  | .paulsJustifyDenotesRenewal => False
  | _ => True

/-- **Trent, taken as a claim about what God does, can be held without
contradiction.** -/
theorem tridentineOnWhatGodDoes_is_satisfiable :
    Satisfiable tridentineOnWhatGodDoes.premises := by
  satisfied_by trentGrantsTheWordReading [solaFideDefs]

/-- **The argument from Paul's word does not reach Trent's definition taken as a
claim about what God does.** Taken that way, Trent's position can be held
together with every premise of the argument. The rule of least meaning governs
what Paul's word says, and this way of taking the definition says nothing about
the word. -/
theorem lexical_case_does_not_reach_what_god_does :
    Satisfiable (lexicalCase.premises ++ tridentineOnWhatGodDoes.premises) := by
  satisfied_by trentGrantsTheWordReading [solaFideDefs]

/-! ### Where each fails -/

/-- **Why Paul's word stands against Trent taken as a claim about it.** Everything
turns on one step: with the courtroom sense, Paul's own words for renewal and
the rule of least meaning, "justify" does not mean renewal. What that
contradicts is Trent's definition together with this way of taking it, and
nothing else in Trent. Every link is rated above `disputed`. -/
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

/-- **Why Paul's word stands against the Latin reading of it.** The same step, and a
second contradiction in the same branch. Trent rests its reading of Paul's word
on Augustine's explanation, and what fails is the step from that explanation to
what the Greek word means. That Augustine explained it so is not in question; it
is rated `consensus`. But a Latin explanation does not settle what the Greek
word means in Paul, and the courtroom sense, Paul's own words for renewal and
the rule of least meaning say it does not mean renewal. -/
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

/-- **Why Paul's gospel stands against Trent taken as a claim about what God does.**
The same step as `whereTrentPartsFromPaul`, and the same contradiction: from a
verdict on Christ's finished work to "renewal is no part of justification",
against Trent's definition. Taken this way, that step is all that divides them,
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

/-- **Romans 4, read this way, denies Trent's definition.** Paul explains the
righteousness God counts to the ungodly as sin not counted. With the courtroom
sense of the verb, renewal is no part of justification.

What this does not claim: that the reading is beyond dispute. Augustine accepts
the same verses and reads them the other way, so the step is rated `disputed`. -/
@[headline]
theorem romansFourCase_establishes : Establishes romansFourCase := by
  establish [solaFideDefs, caseOf]

#print axioms romansFourCase_establishes

/-- The premises of the argument from Romans 4 can all be true together, on the
reading given for Paul's gospel. -/
theorem romansFourCase_is_satisfiable : Satisfiable romansFourCase.premises := by
  satisfied_by galatianGospelReading [solaFideDefs, caseOf]

/-- **Romans 4, read by the rule of least meaning, shows what Paul's word means.**
The verb Paul explains as sin not counted does not also mean the renewal of the
inward person. -/
@[headline]
theorem romansFourOnTheWord_establishes : Establishes romansFourOnTheWord := by
  establish [solaFideDefs, caseOf]

#print axioms romansFourOnTheWord_establishes

/-- The premises of that argument can all be true together, on the reading given for
the argument from Paul's word. -/
theorem romansFourOnTheWord_is_satisfiable : Satisfiable romansFourOnTheWord.premises := by
  satisfied_by lexicalReading [solaFideDefs, caseOf]

/-- **Trent can accept every word of Romans 4:5–8**, as Augustine does: God
justifies the ungodly, and the blessing is sin not counted. The texts are
accepted on both sides. The reading of them is not. -/
theorem trent_grants_romans_four :
    Grants tridentineCase (⋀ [p .romans4_4_5, p .romans4_6_8]) := by
  satisfied_by jointDeclarationReading [Grants, solaFideDefs]

/-- **Romans 4, read for Paul's word, does not reach Trent's definition taken as a
claim about what God does.** Taken that way, Trent's position can be held with
every premise of the argument. The argument says what the counting is, and this
way of taking the definition says nothing about the word. -/
theorem romans_four_on_the_word_does_not_reach_what_god_does :
    Satisfiable (romansFourOnTheWord.premises ++ tridentineOnWhatGodDoes.premises) := by
  satisfied_by trentGrantsTheWordReading [solaFideDefs, caseOf]

/-- **Why Romans 4 stands against Trent taken as a claim about Paul's word.**
Everything turns on the step from Paul's explanation, that the righteousness
counted to the ungodly is sin not counted, by the rule of least meaning, to "the
verb does not also mean renewal". What it contradicts is Trent's definition
taken this way. Every link is rated `wellSupported` or better. It arrives from
one passage where the argument from usage arrives from the word. -/
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

/-- **Why Romans 4 stands against Trent taken as a claim about what God does.**
Everything turns on the step from Paul's explanation, with the courtroom sense
of the verb, to "renewal is no part of justification". It contradicts Trent's
definition and nothing else.

The step is rated `disputed`, as the step from Galatians is. Augustine accepts
the same verses and reads them the other way: God justifies the ungodly "that he
may become a godly one". So taken this way, Trent is met by Paul twice, from
Galatians and from Romans 4, each time at a `disputed` step. The two arguments
share one starting point, the courtroom sense of the verb. -/
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

/-! ### The two put together -/

/-- **What Trent's definition claims, taken both ways.** The definition is that
justification is the sanctification and renewal of the inward person.

*Taken as a claim about what Paul's word means*, namely that "justify" (δικαιόω)
means that renewal, it cannot be held with the evidence for what the word means.
It fails three times, each at a step rated `wellSupported`: against the argument
from usage, as Trent states the definition; against the same argument, at the
Latin explanation this reading rests on ("being justified" as "being made
righteous"); and against Romans 4 read for the word.

*Taken as a claim about what God does in justifying*, namely that he also
renews, nothing about the word reaches it: neither the argument from usage nor
Romans 4 read for the word. It conflicts with Paul twice, each time at a step
rated `disputed`: with his gospel in Galatians, at the step
`whereTrentPartsFromPaul` names, and with Romans 4, at the reading of "justifies
the ungodly". A reader who grants those steps rejects the definition taken this
way. A reader who denies them, as Augustine and the *Joint Declaration* do, need
not.

Each way of taking it is fair: Trent's position, taken either way, can still be
held without contradiction. -/
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

end TestimonyArguments.SolaFide
