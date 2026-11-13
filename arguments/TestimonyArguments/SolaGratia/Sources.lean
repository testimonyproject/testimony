import TestimonyArguments.SolaGratia.Atoms
import TestimonyArguments.Works

/-!
# TestimonyArguments.SolaGratia.Sources — citation and classification for every atom

`cite` is total, so an uncited atom does not compile. The three positions agree
about the texts and disagree about what they mean, so each has its own `cite`,
sharing `baseCite` for the texts and the conclusion. Each package's list of
sources then names the people who hold its premises: the Remonstrant reading of
Acts 7:51 cites the Remonstrants, and the Reformed denial of it cites Dort.

Dort and the Remonstrance are cited from Schaff's *Creeds of Christendom*,
which prints both; Trent from Tanner's *Decrees*; Arminius from Nichols's
translation of his works.
-/

namespace TestimonyArguments.SolaGratia

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- A text, as Scripture states it: no party disputes what it says. -/
private def text (refs : List ScriptureCitation) : Source :=
  { primary := .scripture refs
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-! ### Ratings for inference steps

A step's rating is its own, cited to whoever grants its grounds and denies its
conclusion, or, where no one was found who does, to whoever grants both. -/

/-- The rating of the step from Romans 11:6 to "salvation is by grace":
`consensus`. Trent quotes the verse to that effect, "if it be a grace, it is not
now by works" (Session VI, chapter 8); the Remonstrants' fourth article calls
grace "the beginning, continuance, and accomplishment of all good"; Dort says
that conversion "must be wholly ascribed to God" (III/IV, article 10). -/
def graceInference : Source :=
  { primary := .work tannerDecrees (.sectionRef "Trent, Session VI (1547), ch. 8")
  , supporting :=
      [ .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4")
      , .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 10") ]
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-- **The rating of the step from "this" pointing to the whole, to "faith is
God's gift": `disputed`.** Robertson grants the ground and denies the conclusion:
"this" refers "not to [pistis] (feminine) or to [charis] (feminine also), but to
the act of being saved by grace conditioned on faith on our part". Calvin, on
the next verse, says the same of "the gift of God": "His meaning is, not that
faith is the gift of God, but that salvation is given to us by God." -/
def ephesiansInference : Source :=
  { primary := .work robertsonWordPictures4 (.adLoc ⟨.ephesians, 2, 8⟩)
  , supporting := [.work calvinGalatiansEphesians (.pages 228 229)]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- **The rating of the step from the gift to God's work alone: `disputed`.**
Arminius grants both grounds. Faith is God's gift: he speaks of God, "whose
benefit and gift I acknowledge faith to be" (*Apology*, article 4). And a man
cannot turn to God by himself: he ascribes to grace "the commencement, the
continuance and the consummation of all good". He denies the conclusion: "many
persons resist the Holy Spirit and reject the grace that is offered"
(*Declaration of Sentiments*). -/
def giftInference : Source :=
  { primary := .work arminiusWorks1 (.page 600)
  , supporting :=
      [ .work arminiusWorks1 (.page 681)
      , .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4") ]
  , tradition := .arminian
  , confidence := .disputed }

/-- **The rating of the step from Romans 9:16, read as being about salvation, to
God's work alone: `disputed`.** Arminius grants the ground: the chapter's theme
is "That the Gospel, not the law, is the power of God unto salvation, not to him
that worketh, but to him that believeth", and the willing and running of 9:16 is
the effort by which a man "hopes that he will obtain justification and salvation
apart from the mercy of God". He denies the conclusion: the mercy goes to those
"who seek righteousness and salvation by faith in Christ", and grace can be
refused. -/
def romansInference : Source :=
  { primary := .work arminiusWorks3 (.pages 527 565)
  , tradition := .arminian
  , confidence := .disputed }

/-- **The rating of Trent's step from cooperation to "the will is not passive":
`disputed`, and the dissent rests on a distinction.** Canon 4 speaks of the will
"disposing and preparing itself" for justification. Aquinas grants that grace
works with a will that moves, which he calls cooperating grace, and still holds
that in grace's first effect "our mind is moved and does not move, but … God is
the sole mover" (I-II q.111 a.2). Dort likewise grants that the renewed will
"becomes itself active" (III/IV, article 12). Both place the will's activity
after a first moment in which it is only moved; the canon does not say which
moment it means. -/
def cooperationInference : Source :=
  { primary := .work aquinasSumma (.sectionRef "I-II q.111 a.2")
  , supporting :=
      [ .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 12")
      , .work tannerDecrees (.sectionRef "Trent, Session VI (1547), canon 4") ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **The rating of Trent's step from "the will can refuse" to "grace is not
effectual of itself": `disputed`.** Aquinas grants the ground and denies the
conclusion. "If God moves the will to anything, it is incompatible with this
supposition, that the will be not moved thereto. But it is not impossible
simply" (I-II q.10 a.4 ad 3). And "if God intends, while moving, that the one
whose heart He moves should attain to grace, he will infallibly attain to it"
(I-II q.112 a.3). On that reading the will can refuse, taken simply, and grace
is effectual all the same. -/
def dissentInference : Source :=
  { primary := .work aquinasSumma (.sectionRef "I-II q.10 a.4 ad 3")
  , supporting :=
      [ .work aquinasSumma (.sectionRef "I-II q.112 a.3")
      , .work tannerDecrees (.sectionRef "Trent, Session VI (1547), canon 4") ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of the Remonstrants' step from Acts 7:51 to "grace is not
effectual of itself": `wellSupported`. Grant that what Stephen's hearers resisted
was the grace that saves, and no reader was found who denies that grace can
then be resisted. Reformed readers deny the ground instead: John Gill reads the
resistance as made not "to any internal operation of his grace, but to the
external ministry of the word". -/
def resistanceInference : Source :=
  { primary := .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4")
  , supporting := [.work arminiusWorks1 (.page 600)]
  , tradition := .arminian
  , confidence := .wellSupported }

/-! ### The citations -/

/-- What every position cites alike: the texts, and the parts of the
conclusion. A disputed reading has no entry here; each position cites its own. -/
def baseCite : Claim → AtomMeta
  | .ephesians2_1to5 =>
    { label := "Ephesians 2:1–5 — dead in trespasses, God made us alive together with Christ"
    , kind := .textual
    , source := text [{ ref := .range ⟨.ephesians, 2, 1, 2, 5⟩ }] }
  | .ephesians2_8to9 =>
    { label :=
        "Ephesians 2:8–9 — by grace you have been saved through faith, and this is not " ++
        "your own doing; it is the gift of God"
    , kind := .textual
    , source := text [{ ref := .range ⟨.ephesians, 2, 8, 2, 9⟩ }] }
  | .romans9_16 =>
    { label := "Romans 9:16 — it depends not on human will or exertion, but on God, who has mercy"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.romans, 9, 16⟩ }] }
  | .romans11_6 =>
    { label := "Romans 11:6 — if it is by grace, it is no longer on the basis of works"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.romans, 11, 6⟩ }] }
  | .acts7_51 =>
    { label := "Acts 7:51 — you always resist the Holy Spirit"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.acts, 7, 51⟩ }] }
  | .zechariah1_3WithLamentations5_21 =>
    { label :=
        "Zechariah 1:3 (\"return to me, and I will return to you\") with Lamentations 5:21 " ++
        "(\"restore us to yourself, O Lord\")"
    , kind := .textual
    , source :=
        { primary :=
            .scripture
              [{ ref := .verse ⟨.zechariah, 1, 3⟩ }, { ref := .verse ⟨.lamentations, 5, 21⟩ }]
        , supporting := [.work tannerDecrees (.sectionRef "Trent, Session VI (1547), ch. 5")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .toutoRefersToTheWhole =>
    { label :=
        "In Ephesians 2:8, \"this\" (τοῦτο) points to the whole of being saved by grace " ++
        "through faith"
    , kind := .linguistic
      -- `wellSupported`: Hoehner and Robertson read it so, and Calvin refers the
      -- verse to salvation as a whole. The pronoun's grammar is not where the
      -- readers divide; the step from it to faith as a gift is
      -- (`ephesiansInference`).
    , source :=
        { primary := .work hoehnerEphesians (.page 343)
        , supporting := [.work robertsonWordPictures4 (.adLoc ⟨.ephesians, 2, 8⟩)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .romans9_16ConcernsSalvation =>
    { label :=
        "Romans 9:16 is about God's mercy in saving, not only in choosing a people for history"
    , kind := .interpretive
      -- `wellSupported`: Arminius and Abasciano, who deny the Reformed
      -- conclusion, grant this reading. Readers who take Romans 9 as about
      -- peoples' place in history alone would deny it; none was cited with a
      -- verified location.
    , source :=
        { primary := .work arminiusWorks3 (.pages 527 565)
        , supporting := [.work abascianoCorporateElection (.page 351)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .faithIsGodsGift =>
    { label := "Faith itself is God's gift, not something the believer adds"
    , kind := .theological
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 14")
        , supporting := [.work arminiusWorks1 (.page 681)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .acts7_51ResistsSavingGrace =>
    { label := "What Stephen's hearers resisted in Acts 7:51 was the grace that saves"
    , kind := .interpretive
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4")
        , tradition := .arminian
        , confidence := .disputed } }
  | .freeWillCooperatesByAssenting =>
    { label := "The free will, moved by God, cooperates by assenting to God's call"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees (.sectionRef "Trent, Session VI (1547), canon 4")
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .freeWillCanDissent =>
    { label := "The free will, moved by God, can refuse its assent if it wishes"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees (.sectionRef "Trent, Session VI (1547), canon 4")
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .conversionIsGodsWorkAlone =>
    { label := "Conversion is God's work alone: grace brings about the sinner's consent"
    , kind := .theological
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, arts. 10–12")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .salvationIsByGrace =>
    { label := "Salvation is by grace and not earned: grace goes before every saving act"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees (.sectionRef "Trent, Session VI (1547), chs. 5, 8")
        , supporting :=
            [ .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), arts. 3–4")
            , .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 10") ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .graceIsEffectualOfItself =>
    { label := "The grace that saves brings about the consent it seeks"
    , kind := .theological
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 12")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .willIsPassiveInRegeneration =>
    { label := "In being made alive the will is passive, and contributes nothing to it"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "X.2")
        , supporting := [.work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 12")]
        , tradition := .reformedProtestant
        , confidence := .disputed } }

/-- The Reformed citations. Dort denies that Acts 7:51 resists the grace that
saves: "it is not the fault of the gospel … that those who are called … refuse
to come"; the fault lies in themselves (III/IV, art. 9). -/
def reformedCite : Claim → AtomMeta
  | .acts7_51ResistsSavingGrace =>
    { label := "What Stephen's hearers resisted in Acts 7:51 was the grace that saves"
    , kind := .interpretive
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 9")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | a => baseCite a

/-- Trent's citations: the texts and canon 4, as `baseCite` has them. -/
def tridentineCite : Claim → AtomMeta := baseCite

/-- The Remonstrant citations. That faith is God's gift is cited to Arminius,
who affirms it on grounds of his own, and not to Dort, which affirms it in a
sense he rejects. -/
def remonstrantCite : Claim → AtomMeta
  | .faithIsGodsGift =>
    { label := "Faith itself is God's gift, not something the believer adds"
    , kind := .theological
    , source :=
        { primary := .work arminiusWorks1 (.page 681)
        , tradition := .arminian
        , confidence := .wellSupported } }
  | a => baseCite a

end TestimonyArguments.SolaGratia
