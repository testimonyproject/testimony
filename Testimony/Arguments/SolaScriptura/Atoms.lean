import Testimony.Attr
import Testimony.Logic.Line
import Testimony.Scripture

/-!
# Arguments.SolaScriptura.Atoms — the atomic claims

Four positions, three objections and two parity replies, so the atom list is
longer than most. It is grouped by what each atom belongs to rather than by
kind, because the groups are what the lines are built from.

Two atoms are worth flagging. `scriptureIsInfallible` is granted by every party
to the dispute and was absent from the seed encoding, which concluded that
scripture is the sole *infallible* rule without ever saying that scripture is
infallible; the eliminative line needs it stated. And
`thessalonians2_15TraditionBinding` is a datum both sides must accommodate
rather than a Roman premise — the seed filed it as the Catholic counter-text,
which left the Protestant package with no answer to it.
-/

namespace Testimony.Arguments.SolaScriptura

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- 2 Timothy 3:16 — all scripture is God-breathed and profitable. -/
  | timothy3_16GodBreathed
  /-- 2 Timothy 3:17 — that the man of God may be complete, equipped for every
  good work. The sufficiency prooftext. -/
  | timothy3_17ThoroughlyEquips
  /-- Mark 7:1–13, with its parallel in Matthew 15:1–9 — Jesus rebukes the
  elders' tradition, Corban above all, for voiding the command of God, and
  quotes Isaiah 29:13 against it: "teaching as doctrines the commandments of
  men". What the text says, not yet what follows from it. -/
  | mark7TraditionCanNullify
  /-- Acts 17:11 — the Bereans tested apostolic preaching against scripture.
  Scripture adjudicating rather than sourcing. -/
  | acts17BereansTested
  /-- 2 Thessalonians 2:15 — hold to the traditions taught by word or letter.
  A datum both sides must accommodate, not a premise of one of them. -/
  | thessalonians2_15TraditionBinding
  /-- Scripture is infallible. Granted by every party to this dispute. -/
  | scriptureIsInfallible
  /-- Scripture is a sufficient rule of faith. -/
  | scriptureIsSufficient
  /-- Scripture is clear on what is necessary for salvation. -/
  | scriptureIsPerspicuous
  /-- Scripture is the sole infallible rule of faith. **The conclusion.** -/
  | scriptureIsSoleInfallibleRule
  /-- Scripture itself teaches sola scriptura. The hinge of the self-refutation
  objection. -/
  | solaScripturaIsTaughtByScripture
  /-- A doctrine is binding only if scripture teaches it. -/
  | onlyScripturalDoctrineIsBinding
  /-- No candidate rule of faith other than scripture is infallible. The hinge
  of the eliminative line. -/
  | noOtherRuleIsInfallible
  /-- Tradition is a coordinate source of revelation alongside scripture.
  **Tradition II**, Trent as Oberman and Mathison read it. Rated `disputed`:
  Geiselmann grants Trent's Session IV and denies that it canonised two
  coordinate sources — the draft's "partly … partly" (*partim … partim*) became
  "and" (*et*), which leaves open whether Scripture holds all revealed content —
  and Congar judges that Trent left the question open. -/
  | traditionIsCoordinateSourceOfRevelation
  /-- The magisterium is an infallible interpreter of scripture.
  **Tradition III**, resting on Vatican I. -/
  | magisteriumIsInfallible
  /-- The mind of the Church, expressed in the consensus of the Fathers and in
  conciliar decisions received by the whole Church, infallibly interprets
  scripture. The Orthodox premise, which is not the Roman one. -/
  | churchMindIsInfallibleInterpreter
  /-- The canon is known through the Church's reception of it. -/
  | canonKnownThroughChurchReception
  /-- Identifying the canon requires an infallible authority. The hinge of the
  canon objection. -/
  | identifyingCanonRequiresInfallibleAuthority
  /-- A rival's own foundational authority is self-authenticating too, so the
  circularity charge does not discriminate between the positions. Kruger's
  parity reply. -/
  | rivalAuthorityIsAlsoSelfAuthenticating
  /-- Tradition carries real but fallible — ministerial, not magisterial —
  authority. **Tradition I.** -/
  | traditionHasMinisterialAuthority
  /-- Tradition I differs in principle from Tradition 0. What the
  interpretive-authority regress denies. -/
  | traditionIDiffersInPrincipleFromTradition0
  /-- The individual retains ultimate interpretive authority, exercised
  indirectly by choosing which body to submit to. Cross and Judisch's premise. -/
  | individualRetainsUltimateInterpretiveAuthority
  /-- Choosing which authority to submit to is itself an act of private
  judgement, whichever authority is chosen. Mathison's parity reply. -/
  | choosingAnAuthorityIsItselfPrivateJudgment
  /-- The bindingness rule governs first-order doctrine, not a claim about
  where binding doctrine comes from. The final-arbiter answer to
  self-refutation. -/
  | bindingnessAppliesToFirstOrderDoctrineOnly
  /-- A practice neither commanded nor forbidden in scripture is permitted
  without scriptural warrant. Adiaphora. -/
  | practiceNeitherCommandedNorForbiddenIsPermitted
  /-- Creeds are informative without being normative: valuable in interpreting
  scripture without binding. **Tradition 0**, as Geisler states it. -/
  | creedsAreInformativeNotNormative
  /-- The historical-grammatical method alone suffices to obtain the meaning of
  scripture on essential doctrine. -/
  | historicalGrammaticalMethodSuffices
  /-- The creedal consensus is hermeneutically necessary for understanding
  scripture. Tradition I's claim, and one leg of Geisler's circle. -/
  | creedalConsensusIsHermeneuticallyNecessary
  /-- Doctrine develops without new revelation: the deposit is closed while
  understanding of it deepens. Held by Rome and by Tradition I alike. -/
  | doctrineDevelopsWithoutNewRevelation
  /-- A development is authenticated by the authority of the developing body.
  Newman's answer to what licenses a development. -/
  | developmentIsAuthenticatedByTheChurch
  /-- The creedal consensus rests on the clarity of scripture. The first leg of
  Geisler's circle. -/
  | creedalConsensusRestsOnPerspicuity
  /-- Scripture's clear sense is not obtainable without the creedal consensus.
  The second leg, and the one every reply below denies. -/
  | perspicuityRequiresCreedalConsensus
  /-- Tradition I's reasoning is circular. Geisler's charge. -/
  | traditionIReasoningIsCircular
  /-- The circularity defeats Tradition I. -/
  | circularityDefeatsTraditionI
  /-- Any appeal to an ultimate authority is circular, there being no higher
  authority to appeal to. Barrett's parity reply. -/
  | everyUltimateAuthorityIsCircular
  /-- The creedal consensus is established by and accountable to scripture — a
  product of reading it rather than a precondition of it. Allen and Swain. -/
  | creedalConsensusIsDerivedFromScripture
  /-- Scripture itself bounds the interpretive office: elders are commended to
  the word, required to hold to it, and forbidden to domineer. **Proposed.** -/
  | scriptureBoundsTheInterpretiveOffice
  /-- Perspicuity is claimed only for what is necessary for salvation, not for
  all of scripture alike. Westminster I.7. -/
  | perspicuityIsLimitedToSalvationEssentials
  /-- **Mark 7's principle.** God's word judges human tradition: no commandment
  of men may be taught as God's word, and a tradition that voids God's command
  is void. Held by Rome as firmly as by the Reformers: the Church's teaching
  office is "not above the word of God" (*Dei Verbum* 10). It is common ground
  only while "God's word" is left as each side uses it — for Rome it includes
  the apostolic Tradition. Read as "Scripture judges every tradition", it is the
  Reformed claim, and Rome denies it. -/
  | godsWordJudgesTradition
  /-- A commandment of men may rightly be bound on the Church as God's word.
  What the elders claimed for Corban, and what Isaiah 29:13 condemns. Trent,
  read as receiving commandments of men, is committed to it; Mark 7's principle
  denies it. -/
  | mensCommandmentBindsAsGodsWord
  /-- No apostolic teaching handed on outside Scripture survives, identifiable
  as the word of God. **The step from Mark 7 to sola scriptura needs it**, and
  Rome denies it: the apostles handed on by word as well as by letter
  (2 Thessalonians 2:15). -/
  | noApostolicWordOutsideScripture
deriving DecidableEq, Repr

end Testimony.Arguments.SolaScriptura
