import Testimony.Arguments.SolaFide.Atoms
import Testimony.Logic.Package
import Testimony.Bib.Works

/-!
# Arguments.SolaFide.Sources — a citation for every atom

Several `cite` functions, not one. The atoms are shared across the positions;
the *citation* of a disputed premise is not, because each side of a dispute is
cited to its own scholarship. The Reformed tradition and the New Perspective
part over what Paul's ἔργα νόμου denotes; Dunn and Hays part over the genitive
in πίστις Χριστοῦ; the apocalyptic reading parts from both.

`baseCite` carries the default citation of every atom; `reformedCite`,
`newPerspectiveCite`, `subjectiveGenitiveCite` and `apocalypticCite` each
override the one atom where their position parts from it. That is the
disagreement made mechanical: it shows up as a difference in the generated
manifest rather than as a remark in a docstring.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- The Reformed reading of ἔργα νόμου, cited to the tradition that holds it and
to its modern defenders against the New Perspective. Disputed precisely because
the New Perspective denies it; see `newPerspectiveCite`. -/
def reformedWorksOfLawSource : Source :=
  { primary := .work calvinInstitutes (.sectionRef "III.xi.19")
  , supporting :=
      [ .work gathercoleWhereIsBoasting .whole
      , .work carsonVariegatedNomism1 .whole
      , .work piperFutureOfJustification .whole ]
  , tradition := .reformedProtestant
  , confidence := .disputed }

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
      -- A Catholic exegete reads the verse the same way; the text is shared
      -- ground, and what divides the positions is elsewhere.
    , source :=
        let s := scriptureWithCalvin [{ ref := .verse ⟨.romans, 3, 28⟩ }] "III.xi.19"
        { s with supporting := s.supporting ++ [.work fitzmyerRomans (.adLoc ⟨.romans, 3, 28⟩)] } }
  | .galatians2_16 =>
    { label := "Galatians 2:16 teaches that no one is justified by works of the law"
    , kind := .textual
    , source :=
        let s := scriptureWithCalvin [{ ref := .verse ⟨.galatians, 2, 16⟩ }] "III.xi.19"
        { s with
          supporting := s.supporting ++ [.work martynGalatians (.adLoc ⟨.galatians, 2, 16⟩)] } }
  | .pistisChristouObjective =>
    { label := "πίστις Χριστοῦ in Galatians 2:16 means faith in Christ, not Christ's faithfulness"
    , kind := .linguistic
      -- Dunn holds the objective genitive and the New Perspective together,
      -- which is why this premise and `worksOfLawMeansWorksGenerally` are
      -- independent: the genitive dispute does not follow the Old/New line.
    , source :=
        { primary := .work dunnOnceMorePistisChristou .whole
        , supporting :=
            [ .work matlockDetheologizing .whole
            , .scripture
                [ { ref := .verse ⟨.galatians, 2, 16⟩ }, { ref := .verse ⟨.romans, 3, 22⟩ }
                , { ref := .verse ⟨.philippians, 3, 9⟩ } ] ]
        , tradition := .criticalScholarship
        , confidence := .disputed } }
  | .galatiansOpposesCircumcisionAsRequirement =>
    { label := "Galatians opposes requiring circumcision, besides faith, for justification"
    , kind := .interpretive
      -- Common ground: the Reformed reading, the New Perspective and the
      -- apocalyptic reading all take the Teachers in Galatia to have demanded
      -- circumcision. They divide over *why* Paul refuses it.
    , source :=
        { primary :=
            .scripture
              [ { ref := .range ⟨.galatians, 2, 3, 2, 5⟩ }
              , { ref := .range ⟨.galatians, 5, 2, 5, 4⟩ } ]
        , supporting := [.work martynGalatians (.adLoc ⟨.galatians, 5, 2⟩)]
        , tradition := .criticalScholarship
        , confidence := .wellSupported } }
  | .righteousnessOfGodIsDeliverance =>
    { label := "δικαιοσύνη θεοῦ names God's deliverance in Christ, not a status faith obtains"
    , kind := .interpretive
    , source :=
        { primary := .work campbellDeliveranceOfGod .whole
        , supporting :=
            [ .work martynGalatians .whole
            , .scripture [{ ref := .range ⟨.romans, 3, 21, 3, 26⟩ }] ]
        , tradition := .criticalScholarship
        , confidence := .disputed } }
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
      -- Mannermaa's Luther affirms this too, while reading justification as
      -- union with Christ present in faith. The difference is in what the
      -- words mean, which a propositional atom cannot hold.
    , source :=
        { calvinHolds "III.xi.1" with
          supporting := [.work mannermaaChristPresentInFaith .whole] } }
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
    , source := reformedWorksOfLawSource }

/-- The Reformed reading of the disputed premise. -/
def reformedCite : Claim → AtomMeta
  | .worksOfLawMeansWorksGenerally =>
    { label := "Paul's ἔργα νόμου denotes human works in general, not boundary markers"
    , kind := .linguistic
    , source := reformedWorksOfLawSource }
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
        , supporting :=
            [ .work sandersPaulPalestinianJudaism .whole
            , .work wrightWhatPaulSaid .whole
            , .work wrightJustification .whole ]
        , tradition := .criticalScholarship
          -- Disputed, as the Reformed reading is: Gathercole and the
          -- *Variegated Nomism* volume contest the account of Judaism it
          -- rests on.
        , confidence := .disputed } }
  | c => baseCite c

/-- Hays's reading of the genitive: πίστις Χριστοῦ is Christ's own
faithfulness. Everything else as `baseCite`. -/
def subjectiveGenitiveCite : Claim → AtomMeta
  | .pistisChristouObjective =>
    { label := "πίστις Χριστοῦ in Galatians 2:16 means Christ's own faithfulness"
    , kind := .linguistic
    , source :=
        { primary := .work haysFaithOfJesusChrist .whole
        , supporting := [.scripture [{ ref := .verse ⟨.galatians, 2, 16⟩ }]]
        , tradition := .criticalScholarship
        , confidence := .disputed } }
  | c => baseCite c

/-- The apocalyptic reading: the genitive is subjective, and it is Campbell's
reason for reading it so that the citation records. -/
def apocalypticCite : Claim → AtomMeta
  | .pistisChristouObjective =>
    { label := "πίστις Χριστοῦ is Christ's faithfulness, the means of God's deliverance"
    , kind := .linguistic
    , source :=
        { primary := .work campbellDeliveranceOfGod .whole
        , supporting :=
            [ .work martynGalatians (.adLoc ⟨.galatians, 2, 16⟩)
            , .work haysFaithOfJesusChrist .whole ]
        , tradition := .criticalScholarship
        , confidence := .disputed } }
  | c => baseCite c

end Testimony.Arguments.SolaFide
