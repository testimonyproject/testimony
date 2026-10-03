import Testimony.Arguments.SpiritBaptism.Atoms
import Testimony.Bib.Works

/-!
# Arguments.SpiritBaptism.Sources — citation and classification for every atom

`cite` is total, so an uncited atom does not compile. Each reading is cited to
a source that holds it; each step's rating is cited to whoever grants its
grounds and denies its conclusion.
-/

namespace Testimony.Arguments.SpiritBaptism

open Testimony Testimony.Bib Testimony.Logic

/-- A text, as Scripture states it. -/
private def text (refs : List ScriptureCitation) : Source :=
  { primary := .scripture refs
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-! ### Ratings for inference steps -/

/-- **The step from 1 Corinthians 12:13 to Spirit baptism at conversion is rated
`disputed`, conservatively.** Dunn and Stott hold it. The Assemblies of God
reject its conclusion, but by denying a ground — that the verse speaks of Christ
baptizing in the Spirit: "'by' is the best translation, indicating that the Holy
Spirit is the instrument" — so they do not contest the step itself. No reader
was sought who grants both grounds and denies the conclusion, so the step is not
rated above the bottom. -/
def onTheConversionStep : Source :=
  { primary := .work dunnBaptismInTheHolySpirit .whole
  , supporting := [.work stottBaptismAndFullness .whole, .work agBaptismPositionPaper .whole]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- **The step from Spirit baptism at conversion to "no second to seek" is
contested, by Menzies.** He grants that Paul's baptism in the Spirit at 1
Corinthians 12:13 is tied to conversion, and holds that Luke's is a different,
prophetic gift, to be sought after it. Whether that is granting the ground and
denying the conclusion, or reading "baptism in the Spirit" in two senses, is the
question of Paul's word and Luke's, which this argument does not yet encode. -/
def menziesAgainstNoSecond : Source :=
  { primary := .work menziesLukesUnderstanding .whole
  , supporting := [.work menziesEmpoweredForWitness .whole]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- **The step from the Pentecostal reading of 1 Corinthians 12:13 is rated
`disputed`, conservatively.** The Assemblies of God hold it. Dunn and Stott
reject its conclusion, but by denying a ground — they read the verse as the
baptism in the Spirit that Christ gives, not the Spirit as instrument — so they
do not contest the step itself. No reader was sought who grants both grounds and
denies the conclusion, so the step is not rated above the bottom. -/
def onTheInstrumentalStep : Source :=
  { primary := .work agBaptismPositionPaper .whole
  , supporting :=
      [.work dunnBaptismInTheHolySpirit .whole, .work stottBaptismAndFullness .whole]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- **The step from the Acts narratives to a second Spirit baptism is well
supported**: grant that believers in Samaria and Ephesus received the Spirit
later, that Luke's Spirit baptism is empowerment, and that his narratives are a
pattern, and the conclusion follows. Unlike the steps rated conservatively here,
this one was audited for a reader who grants all three grounds and denies the
conclusion, and none was found: the readers who reject it deny a ground — Dunn,
that the Samaritans were yet Christians; Stott and Fee, that the narratives are
a pattern. The other steps were not audited in their encoded form, so they stay
at the bottom. -/
def actsToSubsequence : Source :=
  { primary := .work agBaptismPositionPaper .whole
  , supporting := [.work stronstadCharismaticTheology .whole]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **The holiness step is contested, from within the Wesleyan tradition.** The
Church of the Nazarene holds it (*Manual* 2023, Article X). Wesley grants the
"second change, whereby they shall be saved from all sin and perfected in love", and
denies that it is Spirit baptism: "If they like to call this 'receiving the Holy
Ghost,' they may: only the phrase in that sense is not scriptural and not quite
proper; for they all 'received the Holy Ghost' when they were justified" (to
Joseph Benson, 28 December 1770). The Nazarene seminary faculty, keeping entire
sanctification, "no longer view the American holiness hermeneutic of the
'baptism of the Spirit' as exegetically tenable" (2010). -/
def wesleyAgainstTheHolinessName : Source :=
  { primary := .work wesleyLetters (.sectionRef "to Joseph Benson, 28 December 1770")
  , supporting := [.work nazareneWhitePaper .whole]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- **The sacramental step is rated `disputed`, conservatively.** Rome holds it
(Catechism 1302). Westminster rejects the sacramental view, but by denying a
ground — that the Spirit is given in the rite as Rome says: baptism's efficacy
"is not tied to that moment of time wherein it is administered" (XXVIII.6) — so
it does not contest the step itself. No reader was sought who grants the
grounds and denies the conclusion, so the step is not rated above the bottom. -/
def onTheRite : Source :=
  { primary := .work catechismCatholicChurch (.sectionRef "1302")
  , supporting := [.work westminsterConfession (.sectionRef "XXVIII.6")]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **The step from the Spirit given in the sacraments to "no second baptism to
seek" is rated `disputed`, conservatively.** Rome holds it (Catechism 1302). The
natural contester is the Catholic charismatic renewal, which keeps the
sacramental gift and speaks of a "baptism in the Spirit" of its own; its texts
were not verified, so it is not cited, and the step is not rated above the
bottom. -/
def onTheSacramentalExclusion : Source :=
  { primary := .work catechismCatholicChurch (.sectionRef "1302")
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **The step from the variety of Acts is contested, by the Assemblies of God.**
They grant Acts 10 and 2:38 and still read Acts as a pattern: their paper lists
Acts 10:44–46 among the evidence *for* a subsequent experience. -/
def agAgainstTheVariety : Source :=
  { primary := .work agBaptismPositionPaper .whole
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- **The step from the transitions reading is rated `disputed`, conservatively.**
If the episodes of Acts are unrepeatable, they set no norm for believers today,
Stott argues. No reader was sought who grants the transitions reading and still
holds a second Spirit baptism to be the norm, so the step is not rated above the
bottom. -/
def stottOnTheTransitions : Source :=
  { primary := .work stottBaptismAndFullness .whole
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-! ### Citations -/

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .cor12_13AllBaptizedInOneSpirit =>
    { label := "1 Corinthians 12:13 — in one Spirit we were all baptized into one body"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.firstCorinthians, 12, 13⟩ }] }
  | .actsSpiritAfterBelieving =>
    { label :=
        "Acts 8:14–17 and 19:1–7 — believers, already baptized, receive the Spirit " ++
        "afterwards (so the Assemblies of God; Dunn denies they were yet believers)"
    , kind := .textual
      -- `disputed`, not `consensus`: the Assemblies of God read the episodes so;
      -- Dunn denies that the Samaritans were yet Christians before they
      -- received the Spirit.
    , source :=
        { primary := .work agBaptismPositionPaper .whole
        , supporting :=
            [ .scripture
                [ { ref := .range ⟨.acts, 8, 14, 8, 17⟩ }
                , { ref := .range ⟨.acts, 19, 1, 19, 7⟩ } ] ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .acts10SpiritAsTheyHear =>
    { label := "Acts 10:44–48 — the Spirit falls on Cornelius's household before baptism"
    , kind := .textual
    , source := text [{ ref := .range ⟨.acts, 10, 44, 10, 48⟩ }] }
  | .acts2_38SpiritPromised =>
    { label := "Acts 2:38 — repent and be baptized, and you will receive the gift of the Spirit"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.acts, 2, 38⟩ }] }
  | .cor12_13IsChristBaptizingInTheSpirit =>
    { label :=
        "1 Corinthians 12:13 is the baptism in the Spirit Christ gives, received by " ++
        "every believer at conversion"
    , kind := .interpretive
    , source :=
        { primary := .work dunnBaptismInTheHolySpirit .whole
        , supporting := [.work stottBaptismAndFullness .whole]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .cor12_13IsBaptismByTheSpirit =>
    { label :=
        "1 Corinthians 12:13 is baptism by the Spirit into the body, not Christ " ++
        "baptizing in the Spirit"
    , kind := .interpretive
    , source :=
        { primary := .work agBaptismPositionPaper .whole
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .lukanSpiritBaptismIsEmpowerment =>
    { label :=
        "In Luke-Acts, baptism in the Spirit is prophetic empowerment, distinct from " ++
        "the gift Paul ties to conversion"
    , kind := .interpretive
    , source :=
        { primary := .work menziesLukesUnderstanding .whole
        , supporting :=
            [ .work menziesEmpoweredForWitness .whole
            , .work stronstadCharismaticTheology .whole ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .actsNarrativesAreNormative =>
    { label := "Luke's narratives of receiving the Spirit are a pattern for believers today"
    , kind := .interpretive
    , source :=
        { primary := .work stronstadCharismaticTheology .whole
        , supporting := [.work agBaptismPositionPaper .whole]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .actsEpisodesAreTransitions =>
    { label :=
        "The episodes of Acts 8, 10 and 19 are unrepeatable steps in the gospel's " ++
        "spread, not a pattern"
    , kind := .interpretive
    , source :=
        { primary := .work stottBaptismAndFullness .whole
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .entireSanctificationIsSecondWork =>
    { label := "Entire sanctification is a second work of grace after justification"
    , kind := .theological
    , source :=
        { primary := .work nazareneManual (.sectionRef "Articles of Faith, X, ¶10")
        , supporting :=
            [ .work wesleyLetters (.sectionRef "to Joseph Benson, 28 December 1770")
            , .work nazareneWhitePaper .whole ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .spiritGivenInWaterBaptism =>
    { label := "The Spirit is given in water baptism: new birth in the Holy Spirit"
    , kind := .theological
    , source :=
        { primary := .work catechismCatholicChurch (.sectionRef "1262")
        , supporting :=
            [ .work catechismCatholicChurch (.sectionRef "1265")
            , .work bookOfConcord (.sectionRef "Small Catechism, Baptism, third part") ]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .confirmationGivesPentecost =>
    { label :=
        "Confirmation gives the full outpouring of the Spirit, as at Pentecost and in " ++
        "Samaria"
    , kind := .theological
    , source :=
        { primary := .work catechismCatholicChurch (.sectionRef "1302")
        , supporting := [.work catechismCatholicChurch (.sectionRef "1288")]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .spiritBaptismAtConversion =>
    { label := "Every believer is baptized in the Spirit at conversion"
    , kind := .theological
    , source :=
        { primary := .work dunnBaptismInTheHolySpirit .whole
        , supporting := [.work stottBaptismAndFullness .whole]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .secondSpiritBaptismToBeSought =>
    { label := "A baptism in the Spirit distinct from and after conversion is to be sought"
    , kind := .theological
    , source :=
        { primary := .work agBaptismPositionPaper .whole
        , supporting := [.work nazareneManual (.sectionRef "Articles of Faith, X, ¶10")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .spiritGivenInTheSacraments =>
    { label :=
        "The Spirit is given in baptism and confirmation, not in a second baptism " ++
        "beyond the sacraments"
    , kind := .theological
    , source :=
        { primary := .work catechismCatholicChurch (.sectionRef "1302")
        , tradition := .romanCatholic
        , confidence := .disputed } }

end Testimony.Arguments.SpiritBaptism
