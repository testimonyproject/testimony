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

/-! ### Rated inferences

A dispute weighs a position's inference steps as well as its premises (see
`Testimony.Logic.Dispute`), and a step is rated `disputed` when a cited source
grants its grounds and denies its conclusion. These are the ratings the
positions in `SolaFide.Dispute` carry. -/

/-- **Every Reformed strand's step is contested, by Trent.** Trent grants what
each strand reads — Romans 3:28 and Galatians 2:16, that Jesus' words save, that
salvation is through grace — and anathematises the conclusion each draws:
justification by faith alone (Session VI, canon 9). -/
def trentAgainstFaithAlone : Source :=
  { primary := .work tannerDecrees (.sectionRef "Trent, Session VI (1547), canon 9")
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- Trent's own step, from merit to the denial of "not by works". Rated
`consensus`: the step is conceded on both sides — it is *why* the Reformed deny
merit — and the dispute is over its premise, not its inference. -/
def trentOnMerit : Source :=
  { primary := .work tannerDecrees
      (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 16")
  , tradition := .romanCatholic
  , confidence := .consensus }

/-- The apocalyptic reading's step, from Christ's faithfulness and God's
deliverance to the denial that faith is the condition. Rated `plausible`: no
source cited here grants both grounds and affirms faith as the condition of
justification. -/
def campbellOnDeliverance : Source :=
  { primary := .work campbellDeliveranceOfGod .whole
  , supporting := [.work martynGalatians .whole]
  , tradition := .criticalScholarship
  , confidence := .plausible }

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
  | .lukeKeepsTheLaw =>
    { label := "Acts 15:20–21, 21:20–24: Jewish believers keep the law; gentiles keep part"
    , kind := .interpretive
    , source :=
        { primary :=
            .scripture
              [ { ref := .range ⟨.acts, 15, 20, 15, 21⟩ }
              , { ref := .range ⟨.acts, 21, 20, 21, 24⟩ } ]
        , supporting := [.work jervellLukePeopleOfGod .whole]
        , tradition := .criticalScholarship
        , confidence := .wellSupported } }
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
      -- **Proposed.** No scholarly work arguing the case at 7:50 has been read
      -- for this library. Marshall's commentary was cited here before, but his
      -- note on 7:50 has not been checked against the text, so it is kept as a
      -- lead, not as the source. Rated `wellSupported`, not `disputed`:
      -- `disputed` means contested by competent scholars, and a search for one
      -- arguing the healing sense *at 7:50* (Crossref and the open web,
      -- September 2026) found none. The ambiguity of the formula elsewhere is
      -- why it is not `consensus`. A cited argument for healing here would
      -- lower it again, and would enter `Dispute.lean` as a party.
    , source :=
        { primary := .proposal
            ("The plain reading of the pericope, advanced here without a verified " ++
             "scholarly source. The same formula means \"made you well\" at Luke " ++
             "8:48, 17:19 and 18:42, where there is illness; at 7:50 there is none, " ++
             "and the saying follows \"your sins are forgiven\" (7:48) and the " ++
             "table's question \"who is this who even forgives sins?\" (7:49). " ++
             "Settled by a commentator who argues it at 7:50 — Marshall's NIGTC " ++
             "Luke is the first to check.")
        , supporting :=
            [.scripture [{ ref := .range luke7_47to50 }], .work marshallLuke (.adLoc luke7_50)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .luke7_47LoveIsEvidence =>
    { label := "Luke 7:47 — her love is the evidence of her forgiveness, not its ground"
    , kind := .interpretive
      -- ὅτι in 7:47a can be read causally ("forgiven because she loved") or as
      -- giving the evidence ("forgiven, as her great love shows"). The text
      -- decides it: 7:47b ("the one forgiven little loves little") runs from
      -- forgiveness to love, and so does the parable the verse applies (7:41–43),
      -- where the debtor loves more *because* more was cancelled. **Proposed**,
      -- because no commentator's reading of 7:47 has been verified from the
      -- commentary itself; `plausible`, because the causal reading has a
      -- history and the grammar alone does not exclude it.
    , source :=
        { primary := .proposal
            ("The evidential reading of ὅτι in 7:47a, advanced here from the text " ++
             "without a verified scholarly source: 7:47b and the parable of " ++
             "7:41–43 both run from forgiveness to love. Settled by a commentator " ++
             "who argues it — Kilgallen, \"Forgiveness of Sins (Luke 7:36-50)\", " ++
             "NovT 40 (1998) 105–116, is the first to check.")
        , supporting :=
            [ .scripture [{ ref := .range luke7_41to43 }, { ref := .verse luke7_47 }]
            , .scripture [{ ref := .range luke7_47to50 }] ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .plausible } }
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
      -- Mannermaa's Luther affirms this too, while denying that justification
      -- is forensic only; see `justificationIsForensicOnly` and `finnishCite`.
    , source :=
        { calvinHolds "III.xi.1" with
          supporting :=
            [ .work schreinerFaithAlone .whole
            , .work mannermaaChristPresentInFaith .whole ] } }
  | .salvationByGrace =>
    { label := "Salvation is by grace, a gift and not wages owed"
    , kind := .theological
      -- 1 Peter 1:18–19: ransomed "not with perishable things" but by Christ's
      -- blood.
    , source :=
        { calvinHolds "III.xi–xviii" with
          supporting :=
            [ .scripture [{ ref := .range ⟨.firstPeter, 1, 18, 1, 19⟩ }]
            , .work jobesFirstPeter (.adLoc ⟨.firstPeter, 1, 18⟩) ] } }
  | .salvationNotByWorks =>
    { label := "Salvation is not by works: no work is its ground"
    , kind := .theological
    , source :=
        { calvinHolds "III.xi–xviii" with
          supporting := [.work schreinerFaithAlone .whole] } }
  | .salvationThroughFaith =>
    { label := "Salvation is received through faith"
    , kind := .theological
      -- 1 Peter 1:5: believers are "guarded through faith for a salvation".
    , source :=
        { calvinHolds "III.xi–xviii" with
          supporting :=
            [ .scripture [{ ref := .range ⟨.firstPeter, 1, 3, 1, 5⟩ }]
            , .work jobesFirstPeter (.adLoc ⟨.firstPeter, 1, 5⟩) ] } }
  | .justificationIsForensicOnly =>
    { label := "Justification is forensic only: pardon and imputation, not infusion"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "XI.1")
        , supporting := [.work calvinInstitutes (.sectionRef "III.xi.2")]
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .secondTempleCovenantalNomism =>
    { label := "Second Temple Judaism: in by grace, staying in by works"
    , kind := .historical
    , source :=
        { primary := .work sandersPaulPalestinianJudaism .whole
        , tradition := .criticalScholarship
          -- Disputed by Gathercole and the *Variegated Nomism* volume; see
          -- `criticsCite`.
        , confidence := .disputed } }
  | .worksMeritIncreaseOfJustification =>
    { label := "Works performed in grace merit an increase of justification"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 16")
        , tradition := .romanCatholic
        , confidence := .wellSupported } }
  | .justificationIncludesSanctification =>
    { label := "Justification is not remission of sins only, but renewal of the inward man"
    , kind := .theological
      -- `disputed`: Westminster XI.1 denies it in terms — God justifies "not by
      -- infusing righteousness into them, but by pardoning their sins".
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 7")
        , supporting :=
            [.work tannerDecrees (.sectionRef "Trent, Session VI (1547), canon 11")]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .justificationDistinctFromSanctification =>
    { label := "Justification and sanctification are inseparable but distinct"
    , kind := .theological
      -- `disputed`: Trent's canon 11 anathematises justification "by the sole
      -- imputation of the justice of Christ, or by the sole remission of sins".
      -- Calvin: as Christ cannot be divided, the two are inseparable, yet
      -- Scripture "classes them separately" (III.xi.6).
    , source :=
        { primary := .work westminsterConfession (.sectionRef "XIII.1")
        , supporting :=
            [ .work westminsterConfession (.sectionRef "XI.1")
            , .work calvinInstitutes (.sectionRef "III.xi.6") ]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .renewalGrowsThroughGoodWorks =>
    { label := "The inward renewal of the justified grows as they do good works in grace"
    , kind := .theological
      -- Common ground. Trent: the justified, "faith co-operating with good
      -- works, increase in that justice" (ch. 10). Westminster: the regenerate
      -- are "further sanctified, really and personally", "more and more"
      -- (XIII.1). They agree that the renewal grows and disagree about what to
      -- call it, which is where the dispute moves: to the definition.
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 10")
        , supporting := [.work westminsterConfession (.sectionRef "XIII.1")]
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

/-- The New Perspective's critics: Second Temple Judaism was not uniformly
covenantal nomism, because final vindication according to works was widely
held. Gathercole primary, the *Variegated Nomism* volume in support. -/
def criticsCite : Claim → AtomMeta
  | .secondTempleCovenantalNomism =>
    { label := "Second Temple Judaism also held final vindication according to works"
    , kind := .historical
    , source :=
        { primary := .work gathercoleWhereIsBoasting .whole
        , supporting := [.work carsonVariegatedNomism1 .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | c => reformedCite c

/-- The Tridentine reading of what justification is: "not remission of sins
merely, but also the sanctification and renewal of the inward man". Everything
else as `baseCite`. -/
def tridentineCite : Claim → AtomMeta
  | .justificationIsForensicOnly =>
    { label := "Justification is not forensic only: it renews the inward man"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 7")
        , tradition := .romanCatholic
        , confidence := .wellSupported } }
  | c => baseCite c

/-- The Finnish reading of Luther: justification is not forensic only, because
Christ himself is present in faith and is the believer's righteousness.
Everything else as `reformedCite`. -/
def finnishCite : Claim → AtomMeta
  | .justificationIsForensicOnly =>
    { label := "Justification is not forensic only: Christ is present in faith"
    , kind := .theological
    , source :=
        { primary := .work mannermaaChristPresentInFaith .whole
        , tradition := .criticalScholarship
        , confidence := .disputed } }
  | c => reformedCite c

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
