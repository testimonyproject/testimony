import Testimony.Arguments.SolaScriptura.Atoms
import Testimony.Bib.Works

/-!
# Arguments.SolaScriptura.Sources — citation and classification for every atom

`cite` is total, so an uncited atom does not compile.

Where the positions disagree about an atom they are given the source that
actually holds the claim: the Orthodox premise cites Florovsky and Ware rather
than a Protestant account of Orthodoxy, and Tradition 0 cites Geisler rather
than Mathison's description of it — Geisler's principal complaint being that
the description is a caricature.
-/

namespace Testimony.Arguments.SolaScriptura

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- A claim held by a named work at a section, in a given tradition. -/
private def heldBy (entry : BibEntry) (loc : String) (tradition : Tradition)
    (confidence : Confidence := .disputed) : Source :=
  { primary := .work entry (.sectionRef loc)
  , tradition := tradition
  , confidence := confidence }

/-! ### Ratings for inference steps

A step's rating is its own, cited to whoever grants its grounds and denies its
conclusion — or, where no one was found who does, to whoever grants both. -/

/-- The rating of Mark 7's step, from the rebuke to the principle. No reader was
found who grants the text and denies the principle; Rome grants it outright —
the teaching office is "not above the word of God" (*Dei Verbum* 10) — and
Calvin applies Matthew 15:9 to the laws of worship he opposed. Rated
`wellSupported` rather than `consensus`, because the step generalises from one
pericope. -/
def mark7PrincipleInference : Source :=
  { primary := .work tannerDecrees (.sectionRef "Vatican II (1965), Dei Verbum 10")
  , supporting := [.work calvinInstitutes (.sectionRef "IV.x.23")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- The rating of the step from Mark 7's principle to the sole rule: `disputed`.
Grant that God's word judges human tradition and that no apostolic teaching
outside Scripture adds to it, and a reader may still deny that Scripture is the
*sole* infallible rule. Geiselmann is that reader: he holds that Scripture
contains all revealed content, grants the principle as every Catholic does, and
as a Catholic after Vatican I still holds the Magisterium an infallible
interpreter (*Pastor Aeternus* 4). Florovsky, for whom tradition adds nothing
to Scripture, likewise keeps the mind of the Church as its authoritative
interpreter. -/
def principleToSoleRuleInference : Source :=
  { primary := .work geiselmannMeaningOfTradition .whole
  , supporting :=
      [ .work tannerDecrees (.sectionRef "Vatican I (1870), Pastor Aeternus, ch. 4")
      , .work florovskyBibleChurchTradition .whole ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of Trent's step, from 2 Thessalonians 2:15 and tradition as a
source of revelation to "Scripture is not the sole rule": `wellSupported`. Once
the grounds are granted the conclusion all but follows, and no reader was found
who grants both and denies it. Protestants deny the second ground instead, and
that dissent is weighed in its own rating. -/
def tridentineInference : Source :=
  { primary := .work tannerDecrees
      (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions")
  , tradition := .romanCatholic
  , confidence := .wellSupported }

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .timothy3_16GodBreathed =>
    { label := "2 Timothy 3:16 — all scripture is God-breathed and profitable"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.secondTimothy, 3, 16⟩ }] "I.vii.1" }
  | .timothy3_17ThoroughlyEquips =>
    { label :=
        "2 Timothy 3:17 — that the man of God may be complete, equipped for every good work"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.secondTimothy, 3, 17⟩ }] "I.vii.1" }
  | .mark7TraditionCanNullify =>
    { label :=
        "Mark 7:1–13 (Matthew 15:1–9) — Jesus rebukes the elders' tradition, " ++
        "Corban above all, for voiding God's command"
    , kind := .textual
      -- What the text says, which no party disputes: Rome and the Reformers
      -- differ over what it reaches, not over what it reports.
    , source :=
        { primary := .scripture [{ ref := .range mark7_1to13 }, { ref := .range matthew15_1to9 }]
        , supporting := [.work calvinInstitutes (.sectionRef "IV.x.10")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .acts17BereansTested =>
    { label := "Acts 17:11 — the Bereans tested apostolic preaching against scripture"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.acts, 17, 11⟩ }] "I.vii.2" }
  | .thessalonians2_15TraditionBinding =>
    { label := "2 Thessalonians 2:15 — hold to the traditions taught by word or letter"
    , kind := .textual
      -- Shared ground. Every position has to say something about unwritten
      -- apostolic teaching; filing this as Rome's prooftext left the
      -- Protestant packages with no answer to it.
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.secondThessalonians, 2, 15⟩ }]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .scriptureIsInfallible =>
    { label := "Scripture is infallible"
    , kind := .theological
    , source :=
        { primary := .work grudemSystematicTheology (.sectionRef "ch. 5")
        , supporting := [.work calvinInstitutes (.sectionRef "I.vii")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .scriptureIsSufficient =>
    { label := "Scripture is a sufficient rule of faith"
    , kind := .theological
      -- Carries the preservation claim as well as its own: a filter on
      -- tradition cannot retain the apostolic deposit unless the deposit is in
      -- scripture. Calvin alone was too thin a footing for that.
    , source :=
        { primary := .work grudemSystematicTheology (.sectionRef "ch. 8")
        , supporting :=
            [ .work websterHolyScripture .whole
            , .work bavinckProlegomena .whole
            , .work calvinInstitutes (.sectionRef "I.vii")
            , .work westminsterConfession (.sectionRef "I.6") ]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .scriptureIsPerspicuous =>
    { label := "Scripture is clear on what is necessary for salvation"
    , kind := .theological
    , source := calvinHolds "I.vii.5" .disputed }
  | .scriptureIsSoleInfallibleRule =>
    { label := "Scripture is the sole infallible rule of faith"
    , kind := .theological
    , source := calvinHolds "I.vii–ix" .disputed }
  | .solaScripturaIsTaughtByScripture =>
    { label := "Scripture itself teaches that scripture is the sole infallible rule"
    , kind := .interpretive
    , source := calvinHolds "I.vii.4" .disputed }
  | .onlyScripturalDoctrineIsBinding =>
    { label := "A doctrine is binding only if scripture teaches it"
    , kind := .theological
    , source := calvinHolds "IV.x.8" .disputed }
  | .noOtherRuleIsInfallible =>
    { label := "No candidate rule of faith other than scripture is infallible"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "I.6")
        , supporting := [.work mathisonShapeSolaScriptura .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .traditionIsCoordinateSourceOfRevelation =>
    { label := "Tradition is a coordinate source of revelation alongside scripture"
    , kind := .theological
      -- `disputed`, not `wellSupported` as it was; the atom's docstring gives
      -- Geiselmann's and Congar's reasons. The rating was information for a
      -- reader until the Mark 7 dispute made it decide who prevails.
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions")
        , supporting :=
            [ .work mathisonShapeSolaScriptura .whole
            , .work geiselmannMeaningOfTradition .whole
            , .work congarTraditionAndTraditions .whole ]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .magisteriumIsInfallible =>
    { label := "The magisterium is an infallible interpreter of scripture"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Vatican I (1870), Pastor Aeternus, ch. 4")
        , supporting := [.work mathisonShapeSolaScriptura .whole]
        , tradition := .romanCatholic
        , confidence := .wellSupported } }
  | .churchMindIsInfallibleInterpreter =>
    { label :=
        "The mind of the Church, in the consensus of the Fathers and in received " ++
        "conciliar decisions, infallibly interprets scripture"
    , kind := .theological
      -- Not the magisterial premise. Florovsky rejects the two-sources model
      -- outright, so encoding Orthodoxy with a Tridentine premise gets the
      -- objection backwards rather than merely imprecise.
    , source :=
        { primary := .work florovskyBibleChurchTradition .whole
        , supporting := [.work wareOrthodoxChurch .whole]
        , tradition := .easternOrthodox
        , confidence := .wellSupported } }
  | .canonKnownThroughChurchReception =>
    { label := "The canon is known through the Church's reception of it"
    , kind := .historical
    , source :=
        { primary := .work npnfAugustineManichaeans
            (.sectionRef "Augustine, Contra epistolam Manichaei 5.6")
        , supporting :=
            [ .work tannerDecrees
                (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions") ]
        , tradition := .romanCatholic
        , confidence := .consensus } }
  | .identifyingCanonRequiresInfallibleAuthority =>
    { label := "Identifying the canon requires an infallible authority"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions")
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .rivalAuthorityIsAlsoSelfAuthenticating =>
    { label :=
        "A rival's own foundational authority is self-authenticating too, so the " ++
        "circularity charge does not discriminate"
    , kind := .interpretive
    , source := heldBy krugerCanonRevisited "ch. 2" .reformedProtestant }
  | .traditionHasMinisterialAuthority =>
    { label := "Tradition carries real but fallible — ministerial — authority"
    , kind := .theological
    , source :=
        { primary := .work mathisonShapeSolaScriptura .whole
        , supporting := [.work obermanDawn .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .traditionIDiffersInPrincipleFromTradition0 =>
    { label := "Sola scriptura differs in principle from solo scriptura"
    , kind := .theological
    , source := heldBy mathisonShapeSolaScriptura "ch. 9" .reformedProtestant }
  | .individualRetainsUltimateInterpretiveAuthority =>
    { label :=
        "The individual retains ultimate interpretive authority, exercised " ++
        "indirectly by choosing which body to submit to"
    , kind := .theological
    , source := heldBy crossJudischInterpretiveAuthority "§ III" .romanCatholic }
  | .choosingAnAuthorityIsItselfPrivateJudgment =>
    { label :=
        "Choosing which authority to submit to is itself private judgement, " ++
        "whichever authority is chosen"
    , kind := .interpretive
    , source := heldBy mathisonShapeSolaScriptura "ch. 9" .reformedProtestant }
  | .bindingnessAppliesToFirstOrderDoctrineOnly =>
    { label :=
        "The bindingness rule governs first-order doctrine, not a claim about " ++
        "where binding doctrine comes from"
    , kind := .theological
      -- The scope distinction between doctrine and practice is carried by atom
      -- design and this docstring, not by the logic: the fragment is
      -- propositional and cannot quantify.
    , source :=
        { primary := .work westminsterConfession (.sectionRef "I.6")
        , supporting := [.work mathisonShapeSolaScriptura .whole]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .practiceNeitherCommandedNorForbiddenIsPermitted =>
    { label :=
        "A practice neither commanded nor forbidden in scripture is permitted " ++
        "without scriptural warrant"
    , kind := .theological
    , source :=
        { primary := .work bookOfConcord
            (.sectionRef "Formula of Concord, Solid Declaration X")
        , supporting := [.work westminsterConfession (.sectionRef "I.6")]
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .creedsAreInformativeNotNormative =>
    { label := "Creeds are informative without being normative"
      -- Tradition 0 cited from someone who holds it. Geisler's principal
      -- complaint against Mathison is that this position has no slot in the
      -- taxonomy and is described only by its critic.
    , kind := .theological
    , source := heldBy geislerReviewMathison "120" .christianHistoricalGrammatical }
  | .historicalGrammaticalMethodSuffices =>
    { label :=
        "The historical-grammatical method alone suffices to obtain the meaning " ++
        "of scripture on essential doctrine"
    , kind := .interpretive
    , source := heldBy geislerReviewMathison "120–121" .christianHistoricalGrammatical }
  | .creedalConsensusIsHermeneuticallyNecessary =>
    { label := "The creedal consensus is hermeneutically necessary for understanding scripture"
    , kind := .interpretive
    , source := heldBy mathisonShapeSolaScriptura "275" .reformedProtestant }
  | .doctrineDevelopsWithoutNewRevelation =>
    { label := "Doctrine develops without new revelation: the deposit is closed"
      -- Shared ground, not the dispute. Both Rome and Tradition I hold it; they
      -- differ over what authenticates a development.
    , kind := .theological
    , source :=
        { primary := .work newmanDevelopment .whole
        , supporting := [.work mathisonShapeSolaScriptura .whole]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .developmentIsAuthenticatedByTheChurch =>
    { label := "A development is authenticated by the authority of the developing body"
    , kind := .theological
    , source := heldBy newmanDevelopment "ch. 2" .romanCatholic .wellSupported }
  | .creedalConsensusRestsOnPerspicuity =>
    { label := "The creedal consensus rests on the clarity of scripture"
    , kind := .interpretive
    , source := heldBy mathisonShapeSolaScriptura "279–280" .reformedProtestant }
  | .perspicuityRequiresCreedalConsensus =>
    { label := "Scripture's clear sense is not obtainable without the creedal consensus"
    , kind := .interpretive
    , source := heldBy mathisonShapeSolaScriptura "275" .reformedProtestant }
  | .traditionIReasoningIsCircular =>
    { label := "Tradition I's reasoning is circular"
    , kind := .interpretive
    , source := heldBy geislerReviewMathison "122–123" .christianHistoricalGrammatical }
  | .circularityDefeatsTraditionI =>
    { label := "The circularity defeats Tradition I"
    , kind := .theological
    , source := heldBy geislerReviewMathison "123" .christianHistoricalGrammatical }
  | .everyUltimateAuthorityIsCircular =>
    { label :=
        "Any appeal to an ultimate authority is circular, there being no higher " ++
        "authority to appeal to"
    , kind := .theological
    , source := heldBy barrettGodsWordAlone "ch. 11" .reformedProtestant }
  | .creedalConsensusIsDerivedFromScripture =>
    { label :=
        "The creedal consensus is established by and accountable to scripture — " ++
        "a product of reading it, not a precondition of it"
    , kind := .theological
    , source := heldBy allenSwainReformedCatholicity "ch. 3" .reformedProtestant }
  | .scriptureBoundsTheInterpretiveOffice =>
    { label :=
        "Scripture itself bounds the interpretive office: elders are commended " ++
        "to the word, required to hold to it, and forbidden to domineer"
    , kind := .textual
      -- **Proposed.** The passages are cited, and the claim that they bound the
      -- office rather than merely describing it is the library's own assembly:
      -- no source was found advancing these texts as an answer to Geisler.
    , source :=
        { primary := .proposal
            ("Advanced here, not found in the literature as a reply to the " ++
             "circularity charge. The texts are cited; the use is assembled. " ++
             "Note it claims only that scripture *bounds* the office, not that " ++
             "it *confers* it — conferral invites the recognition/conferral " ++
             "distinction Mathison himself presses against Rome.")
        , supporting :=
            [ .scripture
                [ { ref := .verse ⟨.acts, 20, 32⟩ }
                , { ref := .verse ⟨.titus, 1, 9⟩ }
                , { ref := .range ⟨.firstPeter, 5, 2, 5, 3⟩ } ] ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .plausible } }
  | .godsWordJudgesTradition =>
    { label :=
        "God's word judges human tradition: no commandment of men may be taught " ++
        "as God's word, and a tradition that voids God's command is void"
    , kind := .theological
      -- Common ground. "God's word" is left as each side uses it: for Rome it
      -- includes apostolic Tradition, and the principle is granted on those
      -- terms. Read as "Scripture only", it would be a different, disputed claim.
    , source :=
        { primary := .work tannerDecrees (.sectionRef "Vatican II (1965), Dei Verbum 10")
        , supporting :=
            [ .work calvinInstitutes (.sectionRef "IV.x.23")
            , .work florovskyBibleChurchTradition .whole ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .mensCommandmentBindsAsGodsWord =>
    { label := "A commandment of men may rightly be bound on the Church as God's word"
    , kind := .interpretive
      -- What the elders claimed for Corban. Whether any tradition Rome holds
      -- is bound so is what Calvin asserts and Rome denies.
    , source :=
        { primary := .scripture [{ ref := .verse mark7_7 }, { ref := .verse isaiah29_13 }]
        , supporting := [.work calvinInstitutes (.sectionRef "IV.x.23")]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .noApostolicWordOutsideScripture =>
    { label :=
        "No apostolic teaching handed on outside Scripture survives, identifiable " ++
        "as the word of God"
    , kind := .theological
      -- Whitaker: "the papists have no such unwritten tradition which can be
      -- certainly shewn to have been always observed by the universal church".
      -- Denied by Rome, from 2 Thessalonians 2:15 and Dei Verbum 9.
    , source :=
        { primary := .work whitakerDisputation (.page 506)
        , supporting := [.work westminsterConfession (.sectionRef "I.6")]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .perspicuityIsLimitedToSalvationEssentials =>
    { label :=
        "Perspicuity is claimed only for what is necessary for salvation, not " ++
        "for all of scripture alike"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "I.7")
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }

end Testimony.Arguments.SolaScriptura
