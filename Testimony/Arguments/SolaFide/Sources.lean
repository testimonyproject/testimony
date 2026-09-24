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
`newPerspectiveCite`, `subjectiveGenitiveCite`, `apocalypticCite` and
`lawObservantLukeCite` each override the one atom where their position parts
from it, and `criticalAuthorshipCite` the four atoms on who wrote the disputed
letters. That is the
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
      [ .work westerholmPerspectives .whole
      , .work dasPaulLawCovenant .whole
      , .work gathercoleWhereIsBoasting .whole
      , .work carsonVariegatedNomism1 .whole
      , .work piperFutureOfJustification .whole
        -- Where Paul sets grace against works with no law in view (Romans
        -- 4:4–5, 9:11–12, 11:6), and where he and James treat the law as a
        -- whole kept or broken entire (Galatians 3:10, 5:3; James 2:10).
        -- Romans is undisputed; this is why the premise leans on it rather
        -- than on Ephesians 2:9.
      , .scripture
          [ { ref := .range ⟨.romans, 9, 11, 9, 12⟩ }, { ref := .verse ⟨.romans, 11, 6⟩ }
          , { ref := .verse ⟨.galatians, 3, 10⟩ }, { ref := .verse ⟨.galatians, 5, 3⟩ }
          , { ref := .verse ⟨.james, 2, 10⟩ } ] ]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- Citations shared by every package: the prooftexts and the hermeneutical
premises, which none of the three positions disputes the wording of. -/
def baseCite : Claim → AtomMeta
  | .ephesians2_8_9 =>
    { label := "Ephesians 2:8–9 teaches salvation by grace through faith, not of works"
    , kind := .textual
      -- What the text teaches does not depend on who wrote it; whether it is
      -- evidence of *Paul's* usage does. See `ephesiansIsPauline`.
    , source :=
        let s := scriptureWithCalvin [{ ref := .range ⟨.ephesians, 2, 8, 2, 9⟩ }] "III.xi.7"
        { s with
          supporting :=
            s.supporting ++ [.work lincolnEphesians (.adLoc ⟨.ephesians, 2, 9⟩)] } }
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
        , supporting :=
            [ .work martynGalatians (.adLoc ⟨.galatians, 5, 2⟩)
            , .work mooGalatians (.adLoc ⟨.galatians, 5, 2⟩)
              -- Luke reports the same demand, refused at Jerusalem by Peter and
              -- James (Acts 15:1, 15:5, 15:19).
            , .scripture
                [ { ref := .verse ⟨.acts, 15, 1⟩ }, { ref := .verse ⟨.acts, 15, 5⟩ }
                , { ref := .verse ⟨.acts, 15, 19⟩ } ]
            , .work bruceActs (.adLoc ⟨.acts, 15, 1⟩) ]
        , tradition := .criticalScholarship
        , confidence := .wellSupported } }
  | .acts15_9_11 =>
    { label := "Acts 15:9–11 — Peter: hearts cleansed by faith; saved through grace"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .range ⟨.acts, 15, 9, 15, 11⟩ }]
        , supporting := [.work bruceActs (.adLoc ⟨.acts, 15, 9⟩)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .acts15YokeIsLawAsCondition =>
    { label := "The yoke refused at Acts 15:10 is the whole law as a condition of salvation"
    , kind := .interpretive
      -- Galatians 5:1 calls the same thing a "yoke of slavery". James 2:10,
      -- like Galatians 3:10 and 5:3, treats the law as a whole that is kept
      -- or broken entire, which is why the yoke is the whole law.
    , source :=
        { primary := .work bruceActs (.adLoc ⟨.acts, 15, 10⟩)
        , supporting :=
            [ .scripture
                [ { ref := .verse ⟨.acts, 15, 10⟩ }, { ref := .verse ⟨.galatians, 5, 1⟩ }
                , { ref := .verse ⟨.james, 2, 10⟩ } ]
            , .work dasPaulLawCovenant .whole ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .ephesiansIsPauline =>
    { label := "Ephesians was written by Paul"
    , kind := .historical
    , source :=
        { primary := .work hoehnerEphesians .whole
        , supporting := [.scripture [{ ref := .verse ⟨.ephesians, 1, 1⟩ }]]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .titusIsPauline =>
    { label := "Titus was written by Paul"
    , kind := .historical
    , source :=
        { primary := .work mouncePastorals .whole
        , supporting := [.scripture [{ ref := .verse ⟨.titus, 1, 1⟩ }]]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .firstPeterIsPetrine =>
    { label := "1 Peter was written by the apostle Peter"
    , kind := .historical
    , source :=
        { primary := .work jobesFirstPeter .whole
        , supporting :=
            [ .work schreinerPeterJude .whole
            , .scripture [{ ref := .verse ⟨.firstPeter, 1, 1⟩ }] ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .secondPeterIsPetrine =>
    { label := "2 Peter was written by the apostle Peter"
    , kind := .historical
    , source :=
        { primary := .work schreinerPeterJude .whole
        , supporting := [.scripture [{ ref := .verse ⟨.secondPeter, 1, 1⟩ }]]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
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
      -- As Ephesians 2:8–9: see `titusIsPauline`.
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
      -- 2 Peter 3:15–16 counts Paul's letters among "the other Scriptures",
      -- one apostolic writer reading another as consistent with scripture.
    , source :=
        { calvinHolds "I.vii" with
          supporting :=
            [ .scripture [{ ref := .range ⟨.secondPeter, 3, 15, 3, 16⟩ }]
            , .work schreinerPeterJude (.adLoc ⟨.secondPeter, 3, 16⟩) ] } }
  | .justificationByFaithAlone =>
    { label := "Justification is by faith alone"
    , kind := .theological
      -- Mannermaa's Luther affirms this too, while reading justification as
      -- union with Christ present in faith. The difference is in what the
      -- words mean, which a propositional atom cannot hold.
    , source :=
        { calvinHolds "III.xi.1" with
          supporting :=
            [ .work schreinerFaithAlone .whole
            , .work mannermaaChristPresentInFaith .whole ] } }
  | .salvationByGraceThroughFaithNotWorks =>
    { label := "Salvation is by grace through faith, and not by works"
    , kind := .theological
      -- 1 Peter: believers are "guarded through faith for a salvation" (1:5),
      -- ransomed "not with perishable things" but by Christ's blood (1:18–19).
    , source :=
        { calvinHolds "III.xi–xviii" with
          supporting :=
            [ .scripture
                [ { ref := .range ⟨.firstPeter, 1, 3, 1, 5⟩ }
                , { ref := .range ⟨.firstPeter, 1, 18, 1, 19⟩ } ]
            , .work jobesFirstPeter (.adLoc ⟨.firstPeter, 1, 5⟩) ] } }
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

/-- Jervell's reading of Luke-Acts: what Acts 15 withholds from gentiles is
Israel's law as a mark of belonging, and the law is not refused as a means of
salvation. Everything else as `baseCite`. -/
def lawObservantLukeCite : Claim → AtomMeta
  | .acts15YokeIsLawAsCondition =>
    { label := "The yoke of Acts 15:10 is Israel's law laid on gentiles, not the law as such"
    , kind := .interpretive
    , source :=
        { primary := .work jervellLukePeopleOfGod .whole
        , supporting := [.scripture [{ ref := .range ⟨.acts, 15, 19, 15, 21⟩ }]]
        , tradition := .criticalScholarship
        , confidence := .disputed } }
  | c => baseCite c

/-- The critical view of authorship: Ephesians and Titus are not by Paul, and
1 and 2 Peter not by Peter. Each atom is cited to a scholar who holds that view
of that letter, with Ehrman for the case across all four. Marshall's mediating
view of the Pastorals — written by Paul's circle after his death, without
intent to deceive — is cited with the critical side, because it too denies that
Paul wrote Titus. -/
def criticalAuthorshipCite : Claim → AtomMeta
  | .ephesiansIsPauline =>
    { label := "Ephesians was written by a follower of Paul, not by Paul"
    , kind := .historical
    , source :=
        { primary := .work lincolnEphesians .whole
        , supporting := [.work ehrmanForgery .whole]
        , tradition := .criticalScholarship
        , confidence := .disputed } }
  | .titusIsPauline =>
    { label := "Titus was written in Paul's name after his death"
    , kind := .historical
    , source :=
        { primary := .work dibeliusConzelmannPastorals .whole
        , supporting := [.work marshallPastorals .whole, .work ehrmanForgery .whole]
        , tradition := .criticalScholarship
        , confidence := .disputed } }
  | .firstPeterIsPetrine =>
    { label := "1 Peter was written in Peter's name by another"
    , kind := .historical
    , source :=
        { primary := .work achtemeierFirstPeter .whole
        , supporting := [.work ehrmanForgery .whole]
        , tradition := .criticalScholarship
        , confidence := .disputed } }
  | .secondPeterIsPetrine =>
    { label := "2 Peter is a testament written in Peter's name after his death"
    , kind := .historical
    , source :=
        { primary := .work bauckhamJude2Peter .whole
        , supporting := [.work ehrmanForgery .whole]
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
