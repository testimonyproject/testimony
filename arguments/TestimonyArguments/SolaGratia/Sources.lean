import TestimonyArguments.SolaGratia.Atoms
import TestimonyArguments.Works

/-!
# TestimonyArguments.SolaGratia.Sources — citation and classification for every atom

Every claim has a source, and the build fails if one does not. The three
positions agree about the texts and disagree about what they mean, so each
position's list of sources is a common list with the entries it cites
differently replaced. The Reformed position cites its own account of Acts 7:51,
and the Remonstrant position cites Arminius for faith as God's gift.

Dort and the Remonstrance are cited from Schaff's *Creeds of Christendom*, which
prints both. Trent is cited by session and canon from Tanner's *Decrees*, the
critical edition, and quoted in Waterworth's translation of 1848, at its page.
Arminius is cited from Nichols's translation of his works, and Aquinas from the
English Dominicans' translation of the *Summa*.

Every claim and every step carries one of four ratings: *consensus*, accepted
across traditions; *well supported*, though not universally held; *plausible*;
and *disputed*, actively contested. A step is rated *disputed* when a reader the
library cites grants its grounds and denies its conclusion.
-/

namespace TestimonyArguments.SolaGratia

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- Trent's sixth session at a chapter or canon, in Tanner's edition. -/
private def trent (loc : String) : Reference :=
  .work tannerDecrees (.sectionRef ("Trent, Session VI (1547), " ++ loc))

/-- The page of Waterworth's translation where the words quoted are found. -/
private def waterworth (page : Nat) : Reference :=
  .work waterworthTrent (.page page)

/-- The Formula of Concord or the Augsburg Confession, by article and paragraph,
in the Triglot's English. -/
private def concord (loc : String) : Reference :=
  .work concordiaTriglotta (.sectionRef loc)

/-- Dort, from Schaff's volume, at the page of its English. -/
private def dort (page : Nat) : Reference :=
  .work schaffCreeds3 (.page page)

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
  { primary := trent "ch. 8"
  , supporting :=
      [ waterworth 36
      , .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4")
      , .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 10") ]
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-- **The rating of the step from "this" pointing to the whole, to "faith is
God's gift": `disputed`.** Robertson grants the ground and, in the same note,
denies the conclusion. "This" refers "not to [pistis] (feminine) or to [charis]
(feminine also), but to the act of being saved by grace conditioned on faith on
our part", and of the two words he says that grace is "God's part, 'faith'
ours".

Calvin is cited for less. He is Reformed, and holds elsewhere that faith is God's
gift, so he does not deny the conclusion. But he denies that this verse teaches
it: Paul's "meaning is, not that faith is the gift of God, but that salvation is
given to us by God". So a reader may grant the reading of "this" and still deny
that the verse delivers faith as a gift. -/
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
      , trent "canon 4", waterworth 45 ]
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
      , trent "canon 4", waterworth 45 ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of the step from the texts of resistance to "the Spirit's work is
resisted": `consensus`. Every party grants it. Dort says that believers "grieve
the Holy Spirit" (V, article 5); Calvin, on Ephesians 4:30, that "we grieve him
when we do not follow his guidance"; the Formula of Concord, citing Acts 7:51,
that "those who always resist the Holy Ghost … are not converted" (Solid
Declaration II.60). -/
def textsOfResistanceInference : Source :=
  { primary := dort 593
  , supporting :=
      [.work calvinGalatiansEphesians (.page 301), concord "Solid Declaration II.60"]
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-- The rating of the Remonstrants' step from resistance, read as resistance to
the grace that saves, to "that grace can be finally refused": `wellSupported`.
Grant that what Stephen's hearers resisted was the grace that saves, and no
reader was found who denies that it can be finally refused. The Reformed deny
the ground instead, reading the resistance as made to the preached word and not
to the inward work of grace. The word "resist" carries two senses here,
resisting for a time and refusing to the end, and the step needs the second. -/
def resistanceInference : Source :=
  { primary := .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4")
  , supporting := [.work arminiusWorks1 (.page 600)]
  , tradition := .arminian
  , confidence := .wellSupported }

/-- The rating of the step from grieving the Spirit, read as able to end in
losing him, to "the grace that saves can be finally refused": `wellSupported`.
The Formula of Concord holds both: the obstinate "do not receive, but grieve and
lose, the Holy Ghost" (Solid Declaration II.83). Dort denies the ground instead:
God "does not wholly withdraw the Holy Spirit from his own people" (V, article
6). -/
def griefInference : Source :=
  { primary := concord "Solid Declaration II.83"
  , supporting := [concord "Solid Declaration XI.42", dort 593]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **The rating of the step from the unforgivable sin to final refusal:
`disputed`.** Augustine grants both grounds. The sin that is never forgiven is
impenitence: "This impenitence then is 'the blasphemy of the Spirit, which shall
not be forgiven'" (Sermon 71, §20). And he denies the conclusion: God is the one
"whom no man's will resists when He wills to give salvation" (*On Rebuke and
Grace*, ch. 43). The grace refused to the end is, for him, not the grace that
saves. -/
def blasphemyInference : Source :=
  { primary := .work npnfAugustineSermons (.page 325)
  , supporting := [.work npnfAugustineAntiPelagian (.sectionRef "On Rebuke and Grace, ch. 43")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- The rating of the step from "can be finally refused" to "is not effectual of
itself": `consensus`. It is what the two claims say. The Reformed hold the
second because they deny the first, and the Remonstrants deny the second because
they hold the first. -/
def refusalInference : Source :=
  { primary := .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4")
  , supporting := [.work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 12")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-- The rating of the step from God's work alone to the will's passivity:
`wellSupported`. The Lutherans, who part from Dort at the next step, grant this
one: man "does nothing whatever towards it, but only suffers what God works in
him" (Formula of Concord, Solid Declaration II.89). No reader was found who
grants that God alone regenerates and denies that the will is passive in it.
Aquinas holds that in the justification of one who has the use of reason, God's
motion "does not take place without a movement of the free-will" (I-II q.113
a.3); that is passivity in another sense, the will moved and so moving, which
is not what this step denies. -/
def passiveInference : Source :=
  { primary := concord "Solid Declaration II.89"
  , supporting := [.work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 12")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **The rating of the step from God's work alone to "grace cannot be finally
refused": `disputed`.** The Formula of Concord grants the ground: conversion "is
not only in part, but altogether an operation, gift, and present, and work of
the Holy Ghost alone" (Solid Declaration II.89). And it denies the conclusion:
"God does not force man to become godly (for those who always resist the Holy
Ghost … as Stephen says of the hardened Jews, Acts 7:51, are not converted)"
(II.60); the perverse will "resists the Holy Ghost, who wishes to be
efficacious" (XI.41). -/
def effectualInference : Source :=
  { primary := concord "Solid Declaration II.89"
  , supporting := [concord "Solid Declaration II.60", concord "Solid Declaration XI.41"]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-! ### Two readings of the ability God gives

Augustine distinguishes two kinds of help. "The aid without which a thing does
not come to pass is one thing, and the aid by which a thing comes to pass is
another." Adam was given the first, "not that by which it should be brought
about that he should persevere, but that without which he could not of free will
persevere"; the saints are given the second, "so that by means of this gift they
cannot help persevering" (*On Rebuke and Grace*, ch. 34). The third way's claim,
that God gives the ability to believe as Adam was made able, can be read as
either. -/

/-- Who reads the ability as Adam's kind of help, one that makes believing
possible and can be refused: Wesley, for whom "a measure of free-will" is
"supernaturally restored to every man", with "power either to resist or yield to
the grace of God" (*Predestination Calmly Considered*, §§XLVI–XLVII). -/
def asAidWithoutWhichSource : Source :=
  { primary := .work wesleyWorks9 (.page 397)
  , supporting := [.work npnfAugustineAntiPelagian (.page 485)]
  , tradition := .arminian
  , confidence := .disputed }

/-- Who reads the ability as the saints' kind of help, one that brings believing
about: Augustine, of the grace given to the saints (*On Rebuke and Grace*,
ch. 34), and Dort, for which faith is God's gift "not on account of its being
offered by God to man, to be accepted or rejected at his pleasure, but because it
is in reality conferred" (III/IV, article 14). -/
def asAidByWhichSource : Source :=
  { primary := .work npnfAugustineAntiPelagian (.page 485)
  , supporting := [dort 591]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-! ### The citations -/

/-- The common list of sources: the texts, the readings, the claims of each
position, and the parts of the conclusion. Each position replaces only the
entries it cites differently. -/
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
  | .ephesians4_30 =>
    { label := "Ephesians 4:30 — do not grieve the Holy Spirit of God, by whom you were sealed"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.ephesians, 4, 30⟩ }] }
  | .thessalonians5_19 =>
    { label := "1 Thessalonians 5:19 — do not quench the Spirit"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.firstThessalonians, 5, 19⟩ }] }
  | .matthew12_31to32 =>
    { label := "Matthew 12:31–32 — the blasphemy against the Spirit will not be forgiven"
    , kind := .textual
    , source := text [{ ref := .range ⟨.matthew, 12, 31, 12, 32⟩ }] }
  | .genesis2_16to17 =>
    { label :=
        "Genesis 2:16–17 — of the tree of the knowledge of good and evil you shall not eat"
    , kind := .textual
    , source := text [{ ref := .range ⟨.genesis, 2, 16, 2, 17⟩ }] }
  | .theSpiritIsResisted =>
    { label := "The Holy Spirit's work is resisted, by unbelievers and by believers"
    , kind := .theological
    , source :=
        { primary := dort 593
        , supporting := [concord "Solid Declaration II.60"]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .grievingCanLoseTheSpirit =>
    { label := "Those who obstinately resist the Spirit can grieve and lose him"
    , kind := .interpretive
      -- `disputed`: Dort denies that God wholly withdraws the Spirit from his
      -- own (V, article 6).
    , source :=
        { primary := concord "Solid Declaration II.83"
        , supporting := [concord "Solid Declaration XI.42"]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .blasphemyIsFinalRefusalOfGrace =>
    { label :=
        "The blasphemy against the Spirit is impenitence to the end: grace refused till death"
    , kind := .interpretive
      -- `disputed`: Calvin rejects it outright, "Those who define it to be
      -- impenitence may be refuted without any difficulty", and takes the sin
      -- to be knowing contempt of the Spirit (Harmony, vol. 2, p. 74).
    , source :=
        { primary := .work npnfAugustineSermons (.page 325)
        , supporting :=
            [ .work aquinasSumma (.sectionRef "II-II q.14 a.1")
            , .work calvinHarmony2 (.page 74) ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .savingGraceCanBeFinallyRefused =>
    { label := "The grace that saves can be finally refused"
    , kind := .theological
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4")
        , supporting := [concord "Solid Declaration XI.41", .work wesleyWorks9 (.page 397)]
        , tradition := .arminian
        , confidence := .disputed } }
  | .abilityToBelieveIsGiven =>
    { label := "God gives the ability to believe, as Adam was made able to stand or fall"
    , kind := .theological
      -- `wellSupported`: Augustine grants that Adam had the help without which
      -- he could not persevere, and Wesley that preventing grace restores to
      -- every person a measure of free will; Dort grants that faith is God's
      -- gift and holds it to be more than an ability. What kind of help it is
      -- is the dilemma, not this rating.
    , source :=
        { primary := .work npnfAugustineAntiPelagian (.page 484)
        , supporting := [.work wesleySermons (.sectionRef "Sermon 85, III.4")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .faithAloneReceivesGrace =>
    { label := "Grace is received by faith alone"
    , kind := .theological
      -- `disputed`: Trent condemns it (Session VI, canon 9).
    , source :=
        { primary := concord "Augsburg Confession IV.1–3"
        , supporting := [.work wesleySermons (.sectionRef "Sermon 1, III.3"), trent "canon 9"]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .zechariah1_3WithLamentations5_21 =>
    { label :=
        "Zechariah 1:3 (\"return to me, and I will return to you\") with Lamentations 5:21 " ++
        "(\"restore us to yourself, O Lord\")"
    , kind := .textual
    , source :=
        { primary :=
            .scripture
              [{ ref := .verse ⟨.zechariah, 1, 3⟩ }, { ref := .verse ⟨.lamentations, 5, 21⟩ }]
        , supporting := [trent "ch. 5", waterworth 33]
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
      -- conclusion, grant this reading. No reader holding that Romans 9 is
      -- about peoples' place in history alone is cited with a verified
      -- location.
    , source :=
        { primary := .work arminiusWorks3 (.pages 527 565)
        , supporting := [.work abascianoCorporateElection (.page 351)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .faithIsGodsGift =>
    { label := "Faith itself is God's gift"
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
        { primary := trent "canon 4"
        , supporting := [waterworth 45]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .freeWillCanDissent =>
    { label := "The free will, moved by God, can refuse its assent if it wishes"
    , kind := .theological
    , source :=
        { primary := trent "canon 4"
        , supporting := [waterworth 45]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .conversionIsGodsWorkAlone =>
    { label := "Conversion is God's work alone: God regenerates, and the will does nothing to it"
    , kind := .theological
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, arts. 10–12")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .salvationIsByGrace =>
    { label := "Salvation is by grace and not earned: grace goes before every saving act"
    , kind := .theological
    , source :=
        { primary := trent "chs. 5, 8"
        , supporting :=
            [ waterworth 32, waterworth 36
            , .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), arts. 3–4")
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

/-- The Reformed citations. Dort does not cite Acts 7:51. What it gives is an
account of those who refuse the call: "It is not the fault of the gospel, nor of
Christ offered therein, nor of God, who calls men by the gospel … that those who
are called by the ministry of the Word refuse to come and be converted. The
fault lies in themselves" (III/IV, article 9). Read with Acts 7:51, that is the
Reformed answer: what Stephen's hearers resisted was the outward call of the
preached word, not the grace that saves. -/
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
    { label := "Faith itself is God's gift"
    , kind := .theological
    , source :=
        { primary := .work arminiusWorks1 (.page 681)
        , tradition := .arminian
        , confidence := .wellSupported } }
  | a => baseCite a

/-- The Lutheran citations: the Formula of Concord for what the Lutherans hold,
in its own words. -/
def lutheranCite : Claim → AtomMeta
  | .conversionIsGodsWorkAlone =>
    { label := "Conversion is God's work alone: God regenerates, and the will does nothing to it"
    , kind := .theological
    , source :=
        { primary := concord "Solid Declaration II.89"
        , supporting := [concord "Solid Declaration II.90"]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .savingGraceCanBeFinallyRefused =>
    { label := "The grace that saves can be finally refused"
    , kind := .theological
    , source :=
        { primary := concord "Solid Declaration XI.41"
        , supporting := [concord "Solid Declaration II.60", concord "Solid Declaration XI.78"]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | a => baseCite a

/-- The Wesleyan citations: Wesley for what Wesley holds. -/
def wesleyanCite : Claim → AtomMeta
  | .abilityToBelieveIsGiven =>
    { label := "God gives the ability to believe, as Adam was made able to stand or fall"
    , kind := .theological
    , source :=
        { primary := .work wesleySermons (.sectionRef "Sermon 85, III.4")
        , supporting := [.work wesleyWorks9 (.page 397)]
        , tradition := .arminian
        , confidence := .wellSupported } }
  | .savingGraceCanBeFinallyRefused =>
    { label := "The grace that saves can be finally refused"
    , kind := .theological
    , source :=
        { primary := .work wesleyWorks9 (.page 397)
        , tradition := .arminian
        , confidence := .disputed } }
  | a => baseCite a

end TestimonyArguments.SolaGratia
