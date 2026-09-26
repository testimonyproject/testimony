import Testimony.Arguments.CanonicalWitness.Atoms
import Testimony.Logic.Package
import Testimony.Bib.Works

/-!
# Arguments.CanonicalWitness.Sources — a citation for every atom

Every text is cited to scripture alone. That is the argument's point, and the
generated manifest shows it: every text atom is marked as grounded in scripture
alone. The rival grants every one of them — Trent quotes most of them itself —
so what the texts say is common ground, and nothing in the argument turns on a
citation that only one side accepts.

The readings are where the argument is made, and they are cited as readings:
each corpus's step carries its own rated source
(`Testimony.Arguments.CanonicalWitness.Lines`). `cite` holds the argument's own
citations; `tridentineCite` overrides the one atom on which Trent parts from
it, the sense of "justified" in James 2:24.
-/

namespace Testimony.Arguments.CanonicalWitness

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- A claim about what a text says, cited to the text alone. Every party to the
argument accepts the text as scripture, so the claim is `consensus`. -/
def textOnly (refs : List ScriptureCitation) : Source :=
  { primary := .scripture refs
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-- A verse, as a citation. -/
def verse (b : Book) (c v : Nat) : ScriptureCitation := { ref := .verse ⟨b, c, v⟩ }

/-- A range of verses in one chapter, as a citation. -/
def verses (b : Book) (c v w : Nat) : ScriptureCitation := { ref := .range ⟨b, c, v, c, w⟩ }

/-- The argument's citation of every atom. -/
def cite : Claim → AtomMeta
  | .romans3_28 =>
    { label := "Romans 3:28: a person is justified by faith apart from works of the law"
    , kind := .textual, source := textOnly [verse .romans 3 28] }
  | .romans4_4_5 =>
    { label := "Romans 4:4–5: to the one who does not work but believes, faith is counted " ++
        "as righteousness"
    , kind := .textual, source := textOnly [verses .romans 4 4 5] }
  | .galatians2_16 =>
    { label := "Galatians 2:16: not justified by works of the law but through faith in Christ"
    , kind := .textual, source := textOnly [verse .galatians 2 16] }
  | .galatians3_11 =>
    { label := "Galatians 3:11: no one is justified before God by the law; the righteous shall " ++
        "live by faith"
    , kind := .textual, source := textOnly [verse .galatians 3 11] }
  | .ephesians2_8_9 =>
    { label := "Ephesians 2:8–9: saved by grace through faith, not of works"
    , kind := .textual, source := textOnly [verses .ephesians 2 8 9] }
  | .titus3_5 =>
    { label := "Titus 3:5: saved not by works done in righteousness but by his mercy"
    , kind := .textual, source := textOnly [verse .titus 3 5] }
  | .hebrews10_38_39 =>
    { label := "Hebrews 10:38–39: the righteous one shall live by faith"
    , kind := .textual, source := textOnly [verses .hebrews 10 38 39] }
  | .hebrews11_6 =>
    { label := "Hebrews 11:6: without faith it is impossible to please God"
    , kind := .textual, source := textOnly [verse .hebrews 11 6] }
  | .john3_16_18 =>
    { label := "John 3:16–18: whoever believes has eternal life; whoever does not believe " ++
        "is condemned already"
    , kind := .textual, source := textOnly [{ ref := .range john3_16to18 }] }
  | .john5_24 =>
    { label := "John 5:24: whoever hears and believes has eternal life and does not come " ++
        "into judgement"
    , kind := .textual, source := textOnly [{ ref := .verse john5_24 }] }
  | .john6_28_29 =>
    { label := "John 6:28–29: the work of God is that you believe in him whom he has sent"
    , kind := .textual, source := textOnly [{ ref := .range john6_28to29 }] }
  | .acts10_43 =>
    { label := "Acts 10:43: everyone who believes in him receives forgiveness of sins"
    , kind := .textual, source := textOnly [verse .acts 10 43] }
  | .acts15_10_11 =>
    { label := "Acts 15:10–11: no yoke on the disciples; we are saved through the grace of " ++
        "the Lord Jesus"
    , kind := .textual, source := textOnly [verses .acts 15 10 11] }
  | .luke7_50 =>
    { label := "Luke 7:50: your faith has saved you"
    , kind := .textual, source := textOnly [{ ref := .verse luke7_50 }] }
  | .luke18_9_14 =>
    { label := "Luke 18:9–14: the tax collector, not the Pharisee who listed his works, went " ++
        "home justified"
    , kind := .textual, source := textOnly [verses .luke 18 9 14] }
  | .james2_14_17 =>
    { label := "James 2:14–17: faith by itself, if it does not have works, is dead"
    , kind := .textual, source := textOnly [verses .james 2 14 17] }
  | .james2_19 =>
    { label := "James 2:19: even the demons believe, and shudder"
    , kind := .textual, source := textOnly [{ ref := .verse james2_19 }] }
  | .james2_21_23 =>
    { label := "James 2:21–23: Abraham's faith was completed by his works, and Genesis 15:6 " ++
        "was fulfilled"
    , kind := .textual, source := textOnly [verses .james 2 21 23] }
  | .james2_24 =>
    { label := "James 2:24: a person is justified by works and not by faith alone"
    , kind := .textual, source := textOnly [{ ref := .verse james2_24 }] }
  | .jude20_21 =>
    { label := "Jude 20–21: keep yourselves in the love of God, waiting for the mercy of " ++
        "our Lord Jesus Christ"
    , kind := .textual, source := textOnly [verses .jude 1 20 21] }
  | .faithIsNecessary =>
    { label := "Faith is necessary: no one is saved without it"
    , kind := .theological
    , source :=
        { primary := .scripture [verse .hebrews 11 6, { ref := .range john3_16to18 }]
        , supporting :=
            [.work tannerDecrees
              (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 8")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .faithIsSufficient =>
    { label := "Faith is sufficient: whoever believes is saved"
    , kind := .theological
    , source :=
        { primary := .scripture [verses .romans 4 4 5, { ref := .verse john5_24 }]
        , supporting := [.work schreinerFaithAlone .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .worksAreNotTheGround =>
    { label := "Works are not the ground of justification"
    , kind := .theological
    , source :=
        { primary := .scripture [verse .romans 3 28, verses .ephesians 2 8 9]
        , supporting := [.work schreinerFaithAlone .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .justificationByFaithAlone =>
    { label := "Justification is by faith alone"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "XI.2")
        , supporting := [.work calvinInstitutes (.sectionRef "III.xi.19")]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .worksAreFruitOfFaith =>
    { label := "Good works are the fruit and evidence of a true and lively faith"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "XVI.2")
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .faithAloneNeverAlone =>
    { label := "Justification is by faith alone, by a faith that is never alone"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "XI.2")
        , tradition := .reformedProtestant
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
  | .jamesJustifiesDemonstratively =>
    { label := "‘Justified’ in James 2:21–24 means shown to be righteous, not made righteous"
    , kind := .linguistic
    , source :=
        { primary := .work calvinInstitutes (.sectionRef "III.xvii.11")
        , supporting := [.scripture [verses .james 2 21 23]]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .justificationDistinctFromSanctification =>
    { label := "Justification and sanctification are inseparable but distinct"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "XIII.1")
        , supporting := [.work calvinInstitutes (.sectionRef "III.xi.6")]
        , tradition := .reformedProtestant
        , confidence := .disputed } }

/-- Trent's citations: the argument's, except the one atom Trent denies — the
demonstrative sense of "justified" in James 2:24, which Trent reads as the
increase of a justification already received, quoting the verse. -/
def tridentineCite : Claim → AtomMeta
  | .jamesJustifiesDemonstratively =>
    { label := "‘Justified’ in James 2:24 is an increase of justification, by works done in " ++
        "grace"
    , kind := .linguistic
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 10")
        , supporting := [.scripture [{ ref := .verse james2_24 }]]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | c => cite c

end Testimony.Arguments.CanonicalWitness
