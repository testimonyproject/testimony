import Testimony.Attr
import Testimony.Logic.Package
import Testimony.Bib.Works

/-!
# Arguments.SolaFide — justification by grace through faith, not works

The Reformation's material principle, encoded so that its premises are visible
and its disputed step is identified mechanically.

The argument's hinge is not any of its prooftexts. Reformed, New Perspective
and Tridentine readers all accept that Paul wrote Romans 3:28. What they
dispute is `worksOfLawMeansWorksGenerally`: whether Paul's ἔργα νόμου denotes
human works in general, or specifically the covenant boundary markers —
circumcision, food laws, sabbath — that marked Jews off from gentiles, as Dunn
and Wright argue.

`worksOfLaw_is_load_bearing` below shows that this premise carries the
argument: remove it and the entailment fails, with a countermodel. That result
holds whichever side of the dispute the reader takes, which is the sort of
thing this library exists to produce.

`james2_24Compatible` is included because an argument for sola fide that does
not address James 2:24 — "a person is justified by works and not by faith
alone", the only occurrence of *faith alone* in the New Testament — is not
being honest about its own difficulties.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic

set_option maxRecDepth 20000

/-- The atomic claims this argument is built from. Eleven atoms, inside the
twelve-atom budget that keeps truth-table checking tractable. -/
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
  Jewish covenant boundary markers. **The disputed premise.** -/
  | worksOfLawMeansWorksGenerally
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

instance : FiniteAtoms Claim where
  elems :=
    [ .ephesians2_8_9, .romans3_28, .galatians2_16, .romans4_4_5, .titus3_5
    , .worksOfLawMeansWorksGenerally, .james2_24Compatible
    , .scriptureSelfConsistent, .justificationByFaithAlone
    , .salvationByGraceThroughFaithNotWorks, .worksMeritIncreaseOfJustification ]
  complete a := by cases a <;> simp

/-- Shorthand for an atomic formula. -/
abbrev p (c : Claim) : Formula Claim := .atom c

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
  | .james2_24Compatible =>
    { label := "James 2:24 is compatible with Paul, using 'justify' in a different sense"
    , kind := .interpretive
      -- Disputed: this is the hardest text for the Reformed reading, and the
      -- harmonisation is contested rather than obvious.
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.james, 2, 24⟩ }]
        , supporting := [.work calvinInstitutes (.sectionRef "III.xvii.11")]
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

/-- The inference from the prooftexts to justification by faith alone. It runs
through the disputed lexical premise, which is exactly why that premise is load
bearing. -/
def toFaithAlone : Formula Claim :=
  .imp (conjOf [p .romans3_28, p .galatians2_16, p .worksOfLawMeansWorksGenerally])
       (p .justificationByFaithAlone)

/-- The inference from justification by faith alone to the full claim about
salvation, requiring the remaining prooftexts and the harmonisation of James. -/
def toSalvation : Formula Claim :=
  .imp (conjOf
        [ p .justificationByFaithAlone, p .ephesians2_8_9, p .romans4_4_5
        , p .titus3_5, p .james2_24Compatible, p .scriptureSelfConsistent ])
       (p .salvationByGraceThroughFaithNotWorks)

/-- The classical Protestant position. -/
def reformed : ArgumentPackage Claim :=
  { name := "Reformed (sola fide)"
  , cite := reformedCite
  , premises :=
      [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .romans4_4_5
      , p .titus3_5, p .worksOfLawMeansWorksGenerally, p .james2_24Compatible
      , p .scriptureSelfConsistent, toFaithAlone, toSalvation ]
  , conclusion := p .salvationByGraceThroughFaithNotWorks
  , conclusionLabel := "salvation by grace through faith, not works" }

/-- The New Perspective on Paul. It accepts every prooftext and both inference
steps, and denies only the lexical premise. -/
def newPerspective : ArgumentPackage Claim :=
  { name := "New Perspective on Paul"
  , cite := newPerspectiveCite
  , premises :=
      [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .romans4_4_5
      , p .titus3_5, .imp (p .worksOfLawMeansWorksGenerally) .falsum
      , p .james2_24Compatible, p .scriptureSelfConsistent
      , toFaithAlone, toSalvation ]
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
             (.imp (p .salvationByGraceThroughFaithNotWorks) .falsum) ]
  , conclusion := p .salvationByGraceThroughFaithNotWorks
  , conclusionLabel := "salvation by grace through faith, not works" }

/-- Given the Reformed premises, the conclusion follows. -/
@[headline]
theorem reformed_establishes : Establishes reformed := by
  apply entails_of_check
  decide

#print axioms reformed_establishes

/-- The New Perspective's premises do not establish the conclusion. This is a
countermodel result, not a failure to find a proof: `not_entails_of_check`
exhibits a valuation satisfying every New Perspective premise while the
conclusion is false. -/
@[headline]
theorem newPerspective_not_establishes : ¬ Establishes newPerspective := by
  apply not_entails_of_check
  decide

#print axioms newPerspective_not_establishes

/-- The Tridentine premises do not establish the conclusion either — they
entail its negation. -/
@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  apply not_entails_of_check
  decide

#print axioms tridentine_not_establishes

/-- The Reformed package with the disputed lexical premise removed, and
everything else retained. Stated explicitly rather than derived by filtering,
so that the premise list stays visible and reduces under `decide`. -/
def reformedWithoutLexicalPremise : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the lexical premise"
    premises :=
      [ p .ephesians2_8_9, p .romans3_28, p .galatians2_16, p .romans4_4_5
      , p .titus3_5, p .james2_24Compatible, p .scriptureSelfConsistent
      , toFaithAlone, toSalvation ] }

/-- **The result worth having.** Strip the disputed lexical premise from the
Reformed package and the argument collapses: everything else is retained, and
the conclusion no longer follows.

The Reformation's material principle, as encoded here, rests on a claim about
the sense of two Greek words. That is a conclusion a Reformed reader and a New
Perspective reader can both accept, and it locates the disagreement precisely
where it belongs. -/
@[headline]
theorem worksOfLaw_is_load_bearing :
    ¬ Establishes reformedWithoutLexicalPremise := by
  apply not_entails_of_check
  decide

#print axioms worksOfLaw_is_load_bearing

end Testimony.Arguments.SolaFide
