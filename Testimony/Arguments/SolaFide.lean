import Testimony.Attr
import Testimony.Logic.Package
import Testimony.Bib.Works

/-!
# Arguments.SolaFide — justification by grace through faith, not works

The Reformation's material principle, encoded so that its premises are visible
and its disputed step is identified mechanically.

The argument runs on **two independent strands**, and that is the point.

**The Pauline strand** turns on `worksOfLawMeansWorksGenerally`: whether Paul's
ἔργα νόμου denotes human works in general, or specifically the covenant
boundary markers — circumcision, food laws, sabbath — that marked Jews off from
gentiles, as Dunn and Wright argue. This is the most contested step in the
traditional case.

**The dominical strand** rests on Jesus' own words rather than Paul's. ἡ πίστις
σου σέσωκέν σε — "your faith has saved you" — occurs four times in Luke (7:50,
8:48, 17:19, 18:42). It is not a free win: σῴζω means both *save* and *heal*,
and in 8:48, 17:19 and 18:42 the context is physical healing, which is why most
translations render "made you well" there. The argument therefore rests on
**Luke 7:50**, where the saying follows "your sins are forgiven" rather than a
healing, and carries `sozoIsSoteriological` as its own disputed premise. It is
a second bet, on a different word.

Encoding both strands yields a result the single-strand version could not:
neither lexical premise is load-bearing on its own, because either strand
carries the conclusion without the other. Only their *disjunction* is
load-bearing. A reader who wins the ἔργα νόμου argument outright does not
thereby defeat sola fide — and the New Perspective, which accepts justification
by faith while rejecting the traditional reading of Paul's phrase, turns out to
establish the conclusion too.

**James 2:24** — "a person is justified by works and not by faith alone", the
only occurrence of *faith alone* in the New Testament — is no longer assumed
away. Its compatibility with Paul is now *derived* from two cited premises:
that James's target is a barren faith, mere assent ("even the demons believe",
Jas 2:19), and that works are the fruit and evidence of saving faith rather
than a ground of justification. Moo and Johnson for the exegesis; Westminster
XI.2 for the confessional form — faith "is not alone in the person justified,
but is ever accompanied with all other saving graces, and is no dead faith, but
worketh by love". `james_harmonisation_is_load_bearing` shows the argument
genuinely depends on this: drop it and sola fide does not follow.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- Ephesians 2:8–9 teaches that salvation is by grace through faith, not of
  works, so that no one may boast. -/
  | ephesians2_8_9
  /-- Romans 3:28 teaches that a person is justified by faith apart from works
  of the law. -/
  | romans3_28
  /-- Galatians 2:16 teaches that no one is justified by works of the law. -/
  | galatians2_16
  /-- Romans 4:4–5 contrasts wages owed to a worker with a gift reckoned to one
  who does not work but believes. -/
  | romans4_4_5
  /-- Titus 3:5 teaches that God saved us not by works done in righteousness. -/
  | titus3_5
  /-- Paul's ἔργα νόμου denotes human works in general, not specifically the
  Jewish covenant boundary markers. **The disputed Pauline premise.** -/
  | worksOfLawMeansWorksGenerally
  /-- Luke 7:50 — Jesus tells the woman who anointed him, "your faith has saved
  you", immediately after declaring her sins forgiven. -/
  | luke7_50FaithHasSavedYou
  /-- σῴζω in Luke 7:50 denotes salvation rather than physical healing. **The
  disputed dominical premise.** -/
  | sozoIsSoteriological
  /-- James 2:14–26 targets a barren faith — mere assent, which the demons also
  have — rather than Paul's doctrine of justification. -/
  | james2TargetsDeadFaith
  /-- Good works are the fruit and evidence of saving faith, not a ground of
  justification. -/
  | worksAreFruitNotGround
  /-- James 2:24 is compatible with Paul, using "justify" and "faith" in
  different senses. -/
  | james2_24Compatible
  /-- Scripture does not contradict itself. -/
  | scriptureSelfConsistent
  /-- Justification is by faith alone. -/
  | justificationByFaithAlone
  /-- Salvation is by grace through faith, and not by works. **The
  conclusion.** -/
  | salvationByGraceThroughFaithNotWorks
  /-- Works performed in grace merit an increase of justification. The
  Tridentine claim. -/
  | worksMeritIncreaseOfJustification
deriving DecidableEq, Repr

/-- Shorthand for an atomic formula. -/
abbrev p (c : Claim) : Formula Claim := .atom c

/-- Negation, as Foundation defines it: `φ ➝ ⊥`. -/
abbrev notP (c : Claim) : Formula Claim := .imp (.atom c) .falsum

/-- A source grounded in scripture, with a Reformed commentary in support. -/
private def scriptureWithCalvin (refs : List ScriptureCitation) (loc : String) : Source :=
  { primary := .scripture refs
  , supporting := [.work calvinInstitutes (.sectionRef loc)]
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- Citations shared by every package: the prooftexts and the hermeneutical
premises, which none of the three positions disputes the wording of. -/
def baseCite : Claim → AtomMeta
  | .ephesians2_8_9 =>
    { label := "Ephesians 2:8–9 teaches salvation by grace through faith, not of works"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .range ⟨.ephesians, 2, 8, 2, 9⟩ }] "III.xi.7" }
  | .romans3_28 =>
    { label := "Romans 3:28 teaches justification by faith apart from works of the law"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.romans, 3, 28⟩ }] "III.xi.19" }
  | .galatians2_16 =>
    { label := "Galatians 2:16 teaches that no one is justified by works of the law"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.galatians, 2, 16⟩ }] "III.xi.19" }
  | .romans4_4_5 =>
    { label := "Romans 4:4–5 contrasts wages owed with a gift reckoned to the one who believes"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .range ⟨.romans, 4, 4, 4, 5⟩ }] "III.xi.18" }
  | .titus3_5 =>
    { label := "Titus 3:5 teaches that God saved us not by works done in righteousness"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.titus, 3, 5⟩ }] "III.xiv.5" }
  | .luke7_50FaithHasSavedYou =>
    { label := "Luke 7:50 — Jesus says 'your faith has saved you' after declaring sins forgiven"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.luke, 7, 50⟩ }]
        , supporting := [.work marshallLuke (.adLoc ⟨.luke, 7, 50⟩)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .sozoIsSoteriological =>
    { label := "σῴζω in Luke 7:50 denotes salvation, not physical healing"
    , kind := .linguistic
      -- The dominical counterpart to the ἔργα νόμου dispute. The same formula
      -- appears at Luke 8:48, 17:19 and 18:42, where the context is healing;
      -- Luke 7:50 is the strong case because it follows forgiveness of sins.
    , source :=
        { primary := .work marshallLuke (.adLoc ⟨.luke, 7, 50⟩)
        , supporting := [.scripture [{ ref := .range ⟨.luke, 7, 47, 7, 50⟩ }]]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .james2TargetsDeadFaith =>
    { label := "James 2:14–26 targets a barren faith — mere assent — not Paul's doctrine"
    , kind := .interpretive
    , source :=
        { primary := .work mooJames (.adLoc ⟨.james, 2, 14⟩)
        , supporting :=
            [ .work johnsonJames (.adLoc ⟨.james, 2, 24⟩)
            , .scripture [{ ref := .verse ⟨.james, 2, 19⟩ }] ]
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .worksAreFruitNotGround =>
    { label :=
        "Good works are the fruit and evidence of saving faith, not its ground"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "XI.2")
        , supporting := [.work calvinInstitutes (.sectionRef "III.xvi.1")]
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .james2_24Compatible =>
    { label := "James 2:24 is compatible with Paul, using 'justify' in a different sense"
    , kind := .interpretive
      -- No longer assumed: derived from `james2TargetsDeadFaith` and
      -- `worksAreFruitNotGround` via `jamesHarmonisation`.
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.james, 2, 24⟩ }]
        , supporting :=
            [ .work mooJames (.adLoc ⟨.james, 2, 24⟩)
            , .work calvinInstitutes (.sectionRef "III.xvii.11") ]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .scriptureSelfConsistent =>
    { label := "Scripture does not contradict itself"
    , kind := .theological
    , source :=
        { primary := .work calvinInstitutes (.sectionRef "I.vii")
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .justificationByFaithAlone =>
    { label := "Justification is by faith alone"
    , kind := .theological
    , source :=
        { primary := .work calvinInstitutes (.sectionRef "III.xi.1")
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .salvationByGraceThroughFaithNotWorks =>
    { label := "Salvation is by grace through faith, and not by works"
    , kind := .theological
    , source :=
        { primary := .work calvinInstitutes (.sectionRef "III.xi–xviii")
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .worksMeritIncreaseOfJustification =>
    { label := "Works performed in grace merit an increase of justification"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 16")
        , tradition := .romanCatholic
        , confidence := .wellSupported } }
  | .worksOfLawMeansWorksGenerally =>
    { label := "Paul's ἔργα νόμου denotes human works in general"
    , kind := .linguistic
    , source :=
        { primary := .work calvinInstitutes (.sectionRef "III.xi.19")
        , supporting := [.work dunnNewPerspective .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }

/-- The Reformed reading of the disputed premise. -/
def reformedCite : Claim → AtomMeta
  | .worksOfLawMeansWorksGenerally =>
    { label := "Paul's ἔργα νόμου denotes human works in general, not boundary markers"
    , kind := .linguistic
    , source :=
        { primary := .work calvinInstitutes (.sectionRef "III.xi.19")
        , tradition := .reformedProtestant
          -- Disputed precisely because the New Perspective denies it; see
          -- `newPerspectiveCite`.
        , confidence := .disputed } }
  | c => baseCite c

/-- The New Perspective's reading of the disputed premise: ἔργα νόμου denotes
the covenant boundary markers, so Paul is not addressing human effort in
general. -/
def newPerspectiveCite : Claim → AtomMeta
  | .worksOfLawMeansWorksGenerally =>
    { label := "Paul's ἔργα νόμου denotes Jewish covenant boundary markers, not works in general"
    , kind := .linguistic
    , source :=
        { primary := .work dunnNewPerspective .whole
        , supporting := [.work wrightWhatPaulSaid .whole]
        , tradition := .criticalScholarship
        , confidence := .wellSupported } }
  | c => baseCite c

/-- **The Pauline strand.** From Romans and Galatians to justification by faith
alone, by way of the disputed lexical premise about ἔργα νόμου. -/
def paulineToFaithAlone : Formula Claim :=
  .imp (conjOf [p .romans3_28, p .galatians2_16, p .worksOfLawMeansWorksGenerally])
       (p .justificationByFaithAlone)

/-- **The dominical strand.** From Jesus' own words at Luke 7:50 to
justification by faith alone, by way of the disputed lexical premise about
σῴζω. Independent of Paul, and of the ἔργα νόμου dispute. -/
def dominicalToFaithAlone : Formula Claim :=
  .imp (conjOf [p .luke7_50FaithHasSavedYou, p .sozoIsSoteriological])
       (p .justificationByFaithAlone)

/-- The harmonisation of James: because James's target is barren faith, and
works are the fruit of saving faith rather than its ground, James 2:24 does not
contradict Paul. Derived rather than assumed. -/
def jamesHarmonisation : Formula Claim :=
  .imp (conjOf [p .james2TargetsDeadFaith, p .worksAreFruitNotGround])
       (p .james2_24Compatible)

/-- The inference from justification by faith alone to the full claim about
salvation, requiring the remaining prooftexts and the harmonisation of James. -/
def toSalvation : Formula Claim :=
  .imp (conjOf
        [ p .justificationByFaithAlone, p .ephesians2_8_9, p .romans4_4_5
        , p .titus3_5, p .james2_24Compatible, p .scriptureSelfConsistent ])
       (p .salvationByGraceThroughFaithNotWorks)

/-- The premises every package below shares: the prooftexts, both strands'
textual bases, the James premises, and the four inference steps. -/
def sharedPremises : List (Formula Claim) :=
  [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .romans4_4_5
  , p .titus3_5, p .luke7_50FaithHasSavedYou
  , p .james2TargetsDeadFaith, p .worksAreFruitNotGround
  , p .scriptureSelfConsistent
  , paulineToFaithAlone, dominicalToFaithAlone, jamesHarmonisation, toSalvation ]

/-- The classical Protestant position: both strands, both lexical premises. -/
def reformed : ArgumentPackage Claim :=
  { name := "Reformed (sola fide)"
  , cite := reformedCite
  , premises := p .worksOfLawMeansWorksGenerally :: p .sozoIsSoteriological :: sharedPremises
  , conclusion := p .salvationByGraceThroughFaithNotWorks
  , conclusionLabel := "salvation by grace through faith, not works" }

/-- The New Perspective on Paul: it denies the traditional reading of ἔργα
νόμου while accepting justification by faith, which is what Dunn and Wright
actually hold. -/
def newPerspective : ArgumentPackage Claim :=
  { name := "New Perspective on Paul"
  , cite := newPerspectiveCite
  , premises := notP .worksOfLawMeansWorksGenerally :: p .sozoIsSoteriological :: sharedPremises
  , conclusion := p .salvationByGraceThroughFaithNotWorks
  , conclusionLabel := "salvation by grace through faith, not works" }

/-- The Tridentine position: works performed in grace merit an increase of
justification, which is incompatible with the conclusion as stated. -/
def tridentine : ArgumentPackage Claim :=
  { name := "Tridentine (Council of Trent, Session VI)"
  , cite := baseCite
  , premises :=
      [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .titus3_5
      , p .scriptureSelfConsistent, p .worksMeritIncreaseOfJustification
      , .imp (p .worksMeritIncreaseOfJustification)
             (notP .salvationByGraceThroughFaithNotWorks) ]
  , conclusion := p .salvationByGraceThroughFaithNotWorks
  , conclusionLabel := "salvation by grace through faith, not works" }

/-- The Reformed package without the Pauline lexical premise. -/
def reformedWithoutWorksOfLaw : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the Pauline lexical premise"
    premises := p .sozoIsSoteriological :: sharedPremises }

/-- The Reformed package without the dominical lexical premise. -/
def reformedWithoutSozo : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the dominical lexical premise"
    premises := p .worksOfLawMeansWorksGenerally :: sharedPremises }

/-- The Reformed package with **both** lexical premises removed. -/
def reformedWithoutEitherLexicalPremise : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus both lexical premises"
    premises := sharedPremises }

/-- The Reformed package without the premises that harmonise James. -/
def reformedWithoutJamesHarmonisation : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the James harmonisation"
    premises :=
      [ p .worksOfLawMeansWorksGenerally, p .sozoIsSoteriological
      , p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .romans4_4_5
      , p .titus3_5, p .luke7_50FaithHasSavedYou, p .scriptureSelfConsistent
      , paulineToFaithAlone, dominicalToFaithAlone, toSalvation ] }

/-! ### Results

Entailments are established with `tauto`; refutations name a countermodel — the
rival's own reading, written down as a valuation. -/

/-- Given the Reformed premises, the conclusion follows. -/
@[headline]
theorem reformed_establishes : Establishes reformed := by
  intro w hw
  simp only [reformed, sharedPremises, paulineToFaithAlone, dominicalToFaithAlone,
    jamesHarmonisation, toSalvation, conjOf, p, List.mem_cons, List.not_mem_nil,
    or_false, forall_eq_or_imp, forall_eq, FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms reformed_establishes

/-- **The New Perspective establishes it too.** Dunn and Wright reject the
traditional reading of ἔργα νόμου; they do not reject justification by faith.
Once Jesus' words at Luke 7:50 are in view, denying the Pauline lexical premise
no longer blocks the conclusion.

Winning the ἔργα νόμου argument outright is therefore not a defeat of sola
fide, and this library says so in a form either side can check. -/
@[headline]
theorem newPerspective_establishes : Establishes newPerspective := by
  intro w hw
  simp only [newPerspective, sharedPremises, paulineToFaithAlone, dominicalToFaithAlone,
    jamesHarmonisation, toSalvation, conjOf, p, notP, List.mem_cons, List.not_mem_nil,
    or_false, forall_eq_or_imp, forall_eq, FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms newPerspective_establishes

/-- The Tridentine reading, as a valuation: works merit an increase of
justification, so salvation is not by faith apart from works. -/
def tridentineReading : Valuation Claim := fun a =>
  match a with
  | .salvationByGraceThroughFaithNotWorks => False
  | _ => True

/-- The Tridentine premises do not establish the conclusion — they entail its
negation. -/
@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  refine not_entails_of_countermodel tridentineReading ?_ ?_ <;>
    simp [tridentine, p, notP, FFL.Propositional.Formula.Boolean.val, tridentineReading]

#print axioms tridentine_not_establishes

/-- The Pauline lexical premise is **not** load-bearing on its own: strip it and
the dominical strand still carries the argument. -/
@[headline]
theorem worksOfLaw_not_load_bearing : Establishes reformedWithoutWorksOfLaw := by
  intro w hw
  simp only [reformedWithoutWorksOfLaw, reformed, sharedPremises, paulineToFaithAlone,
    dominicalToFaithAlone, jamesHarmonisation, toSalvation, conjOf, p,
    List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
    FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms worksOfLaw_not_load_bearing

/-- Nor is the dominical lexical premise: strip it and the Pauline strand still
carries the argument. -/
@[headline]
theorem sozo_not_load_bearing : Establishes reformedWithoutSozo := by
  intro w hw
  simp only [reformedWithoutSozo, reformed, sharedPremises, paulineToFaithAlone,
    dominicalToFaithAlone, jamesHarmonisation, toSalvation, conjOf, p,
    List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
    FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms sozo_not_load_bearing

/-- A reading on which neither lexical premise holds: Paul's phrase is about
boundary markers, and Jesus' σέσωκέν σε is about healing. -/
def neitherLexicalReading : Valuation Claim := fun a =>
  match a with
  | .worksOfLawMeansWorksGenerally => False
  | .sozoIsSoteriological => False
  | .justificationByFaithAlone => False
  | .salvationByGraceThroughFaithNotWorks => False
  | _ => True

/-- **The result worth having.** Neither lexical premise carries the argument
alone, but their *disjunction* does: remove both and sola fide no longer
follows, with everything else retained.

So the Reformation's material principle, as encoded here, does not hang on the
sense of Paul's ἔργα νόμου. It hangs on that *or* on the sense of Jesus'
σέσωκέν σε — and an opponent must defeat both. -/
@[headline]
theorem lexical_premises_jointly_load_bearing :
    ¬ Establishes reformedWithoutEitherLexicalPremise := by
  refine not_entails_of_countermodel neitherLexicalReading ?_ ?_ <;>
    simp [reformedWithoutEitherLexicalPremise, reformed, sharedPremises,
      paulineToFaithAlone, dominicalToFaithAlone, jamesHarmonisation, toSalvation,
      conjOf, p, FFL.Propositional.Formula.Boolean.val, neitherLexicalReading]

#print axioms lexical_premises_jointly_load_bearing

/-- A reading on which James 2:24 stands unharmonised against Paul. -/
def jamesUnharmonisedReading : Valuation Claim := fun a =>
  match a with
  | .james2_24Compatible => False
  | .salvationByGraceThroughFaithNotWorks => False
  | _ => True

/-- The argument genuinely depends on answering James. Remove the two premises
that harmonise James 2:24 with Paul and sola fide no longer follows, however
much of the rest is retained.

An argument for sola fide that does not engage James 2:24 is not merely
impolite; it is invalid. -/
@[headline]
theorem james_harmonisation_is_load_bearing :
    ¬ Establishes reformedWithoutJamesHarmonisation := by
  refine not_entails_of_countermodel jamesUnharmonisedReading ?_ ?_ <;>
    simp [reformedWithoutJamesHarmonisation, reformed, paulineToFaithAlone,
      dominicalToFaithAlone, toSalvation, conjOf, p, FFL.Propositional.Formula.Boolean.val,
      jamesUnharmonisedReading]

#print axioms james_harmonisation_is_load_bearing

end Testimony.Arguments.SolaFide
