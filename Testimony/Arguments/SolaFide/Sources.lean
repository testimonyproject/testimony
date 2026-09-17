import Testimony.Arguments.SolaFide.Atoms
import Testimony.Logic.Package
import Testimony.Bib.Works

/-!
# Arguments.SolaFide.Sources — a citation for every atom

Three `cite` functions, not one. The atoms are shared across the three
positions; the *citation* for `worksOfLawMeansWorksGenerally` is not, because
the Reformed tradition and the New Perspective disagree about what Paul's
phrase denotes and each is cited to its own scholarship.

`baseCite` carries everything neither side disputes the wording of;
`reformedCite` and `newPerspectiveCite` override the one atom where they part.
That is the disagreement made mechanical: it shows up as a difference in the
generated manifest rather than as a remark in a docstring.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

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
    { label := "Luke 7:50 — Jesus says ‘your faith has saved you’ after declaring sins forgiven"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse luke7_50 }]
        , supporting := [.work marshallLuke (.adLoc luke7_50)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .sozoIsSoteriological =>
    { label := "σῴζω in Luke 7:50 denotes salvation, not physical healing"
    , kind := .linguistic
      -- The dominical counterpart to the ἔργα νόμου dispute. The same formula
      -- appears at Luke 8:48, 17:19 and 18:42, where the context is healing;
      -- Luke 7:50 is the strong case because it follows forgiveness of sins.
    , source :=
        { primary := .work marshallLuke (.adLoc luke7_50)
        , supporting := [.scripture [{ ref := .range luke7_47to50 }]]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .james2TargetsDeadFaith =>
    { label := "James 2:14–26 targets a barren faith — mere assent — not Paul's doctrine"
    , kind := .interpretive
    , source :=
        { primary := .work mooJames (.adLoc james2_14)
        , supporting :=
            [ .work johnsonJames (.adLoc james2_24)
            , .scripture [{ ref := .verse james2_19 }] ]
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
    { label := "James 2:24 is compatible with Paul, using ‘justify’ in a different sense"
    , kind := .interpretive
      -- No longer assumed: derived from `james2TargetsDeadFaith` and
      -- `worksAreFruitNotGround` via `jamesHarmonisation`.
    , source :=
        { primary := .scripture [{ ref := .verse james2_24 }]
        , supporting :=
            [ .work mooJames (.adLoc james2_24)
            , .work calvinInstitutes (.sectionRef "III.xvii.11") ]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .scriptureSelfConsistent =>
    { label := "Scripture does not contradict itself"
    , kind := .theological
    , source := calvinHolds "I.vii" }
  | .justificationByFaithAlone =>
    { label := "Justification is by faith alone"
    , kind := .theological
    , source := calvinHolds "III.xi.1" }
  | .salvationByGraceThroughFaithNotWorks =>
    { label := "Salvation is by grace through faith, and not by works"
    , kind := .theological
    , source := calvinHolds "III.xi–xviii" }
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

end Testimony.Arguments.SolaFide
