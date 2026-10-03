import Testimony.Semantics.Discourse
import Testimony.Meanings.SolaFide
import Testimony.Arguments.SolaFide
import Testimony.Logic.Contest

/-!
# Testimony.Articles.Howell2003 — an article, checked against the library

**A draft, and a worked example.** Kenneth Howell, "Aren't We Saved by Faith
Alone?", *Catholic Answers Magazine*, 1 March 2003
(<https://catholic.com/magazine/print-edition/arent-we-saved-by-faith-alone>,
read 2026-10-03). It is a dialogue between an objector, a Protestant, and a
Catholic. Every move below quotes it exactly, from the publisher's page.

Two of the Catholic's moves carry the article's case against *sola fide*, and
one of the objector's carries the Reformed reply. The check is the same for all
three: what each move needs its words to mean.

**The argument about works.** "If Paul and James mean the same thing by
*works*, then they contradict one another. Since you and I both believe that
the Bible cannot contradict itself, we must agree that Paul and James mean two
different things by the word *works*." Romans 4:2–5 and James 2:24 share three
words, not one: *works*, *justify* and *faith*. Their clash needs all three in
the same senses, so the Bible's consistency rules out only that all three agree.
It does not say which one differs (`consistency_does_not_choose_works`): taking
"justify" in two senses, as Moo and Calvin do, keeps the Bible consistent with
*works* the same. The move needs a further reason to prefer its own choice — and
the article gives one, in Paul's "works of the law" (Romans 3:20, 28;
Galatians 2:16). That reason is argued, not assumed; the move as stated is
**conditional** on it, and the library's own dispute over ἔργα νόμου is where it
is weighed (`worksOfLawMeansWorksGenerally`, rated `disputed`).

**The argument from the phrase "faith alone".** "The phrase 'faith alone' does
occur in the New Testament: one time, in James 2:24. There the inspired apostle
denies that justification is from faith alone." To deny *sola fide* by this,
James's "faith" and "justify" in 2:24 must be the ones the Reformers' formula
uses of Paul. The move does not say so (`faithAlone_unstated`), and those are
exactly the two senses the library's `james2_24Compatible` denies, on the
authority of Moo and Calvin, rated `disputed` (`faithAlone_meets_the_library`).
So the move holds only if that disputed claim is false. The article argues the
sense of *works* at length and the sense of *faith* not at all, though the
objector has raised it: by the article's own principle — consistency settles
which word differs only with a reason — the move needs the argument it does not
give. That is a finding about the move, not a verdict on James.

**The objector is held to the same check.** His reply — James 2:14 "is dealing
with the problem of those who claim faith but who don't show it by their
works" — takes "faith" in 2:14 for "faith" in 2:24, and does not say so either
(`deadFaith_unstated`). That is the Reformed reading's own unstated condition,
and the library records it as such: `james2TargetsDeadFaith` reads the whole of
2:14–26 one way, and is rated `disputed`.

**Heard in the dispute, the move can be defended.** Stated as a position —
the verse, the senses the move needs made explicit, and its step — and heard
with every party to the library's sola fide dispute, the move is neither
indefensible nor forced (`howell_defensible`, `howell_not_forced`). Paul's case
and Peter's case defeat it, and it defeats both back: every link on both sides is
rated `disputed`, and the weighing cannot choose. The library does not show the
move's claim cannot be held. What it shows is the price: the move stands only
where James's words are Paul's, and that is exactly what is contested.

**And the dispute it turns on is live, as a computed result.**
`james2_24Compatible` is rated `disputed` because a reader denies it. Heard as
positions, its holder and its denier can each be defended (`jamesContested`):
the rating is what the weighing finds, not only what a citation says.

What the checks do not do: they do not say which reading of James is right. The
design note `docs/src/semantics.md` says what that would take.
-/

namespace Testimony.Articles.Howell2003

open Testimony Testimony.Semantics Testimony.Semantics.Notation Testimony.Meanings.SolaFide

/-- Romans 4:2–5, which the objector quotes: Abraham not justified by works; the
ungodly justified, faith counted as righteousness. -/
@[nolint defsWithUnderscore] abbrev rom4_2_5 : PassageRange := rg .romans 4 2 4 5

/-- James 2:14. -/
@[nolint defsWithUnderscore] abbrev james2_14 : PassageRange := vs .james 2 14

/-- What Romans 4:2–5 says, in its own words. -/
def romans4Says : Statement :=
  .says rom4_2_5 <| .both (rl .excludedFrom (wd .erga rom4_2_5) (wd .dikaioo rom4_2_5))
    (rl .instrumentOf (wd .pistis rom4_2_5) (wd .dikaioo rom4_2_5))

/-- What James 2:24 says, in its own words: justified by works, and not by faith
alone. The article's quotation means what the library's atom for the verse
means, so the two are one claim (`jamesSays_is_the_library's`). -/
def jamesSays : Statement := means .james2_24NotByFaithAlone

/-- The article's James 2:24 is the library's. -/
theorem jamesSays_is_the_library's :
    jamesSays = means .james2_24NotByFaithAlone := rfl

/-- *Sola fide* as the Reformers state it, as a claim about Paul's words: faith,
in Paul's sense, the only means of justification, in Paul's sense. -/
def solaFideOfPaul : Statement :=
  .holds (rl .soleInstrumentOf (.word .pistis (.usage .paul)) (.word .dikaioo (.usage .paul)))

/-- **The Catholic, on works.** -/
def worksMove : Move where
  speaker := "Catholic"
  words :=
    "If Paul and James mean the same thing by works, then they contradict one " ++
    "another. Since you and I both believe that the Bible cannot contradict " ++
    "itself, we must agree that Paul and James mean two different things by " ++
    "the word works."
  act := .argues [romans4Says, jamesSays, .principle .scriptureSelfConsistent]
    (.denied (.sameSense .erga (.passage rom4_2_5) (.passage james2_24)))

/-- **The Catholic, on the phrase "faith alone".** -/
def faithAloneMove : Move where
  speaker := "Catholic"
  words :=
    "The phrase “faith alone” does occur in the New Testament: one time, in " ++
    "James 2:24. There the inspired apostle denies that justification is from " ++
    "faith alone."
  act := .argues [.occursOnlyIn .faithAlonePhrase james2_24, jamesSays]
    (.denied solaFideOfPaul)

/-- **The Catholic, on Luther's translation.** Two textual claims, both true of
the texts; what the move implies beyond them is not modelled here. -/
def lutherMove : Move where
  speaker := "Catholic"
  words :=
    "When Martin Luther translated the letter to the Romans into German in the " ++
    "sixteenth century, he added the word alone—but alone is not in the " ++
    "original Greek text."
  act := .asserts (.also (.renders .luther rom3_28 .allein) (.denied (.occurs .monos rom3_28)))

/-- **The objector, on dead faith.** -/
def deadFaithMove : Move where
  speaker := "Objector"
  words :=
    "Read James 2:14 carefully: “What does it profit, my brethren, if a man says " ++
    "he has faith but has not works? Can his faith save him?” James is dealing " ++
    "with the problem of those who claim faith but who don’t show it by their works."
  act := .argues
    [.says james2_14 (.not (rl .sufficientFor (wd .pistis james2_14) (wd .sozo james2_14)))]
    (.means .pistis (.passage james2_24) .mereAssent)

/-- **The argument about works needs "justify" and "faith" the same in Romans 4
and James 2, and does not say so.** Its own conclusion is about *works*; the
other two words the passages share are left as they were. -/
theorem works_unstated : worksMove.unstatedBesidesConclusion = [.dikaioo, .pistis] := by
  decide

/-- **The argument from the phrase needs James's "justify" and "faith" to be
Paul's, and does not say so.** -/
theorem faithAlone_unstated : faithAloneMove.unstatedWords = [.dikaioo, .pistis] := by
  decide

/-- **The objector's reply needs "faith" in James 2:14 to be "faith" in 2:24,
and does not say so.** The same check, on the other side. -/
theorem deadFaith_unstated : deadFaithMove.unstatedWords = [.pistis] := by
  decide

/-- **Both senses the phrase argument needs are denied by one claim in the
library**: `james2_24Compatible`, cited to Moo and Calvin and rated
`disputed`. The move stands only if that claim is false, and the article does
not argue that it is. -/
theorem faithAlone_meets_the_library :
    faithAloneMove.meets (α := Arguments.SolaFide.Claim) =
      [(.dikaioo, [.james2_24Compatible]), (.pistis, [.james2_24Compatible])] := by
  decide

/-! ### What consistency settles, and what it does not

The argument about works reasons from the Bible's consistency. Written as
logic, with one atom per shared word — *this word has the same sense in Romans
4 and in James 2* — the passages clash only if all three hold, and consistency
denies that they all do. -/

open Testimony.Logic

/-- The Bible's consistency, applied to Romans 4:2–5 and James 2:24: not all
three of their shared words — works, justify, faith — have the same sense in
both. -/
def consistencyHere : List (Formula Lexeme) := [∼ ⋀ [p .erga, p .dikaioo, p .pistis]]

/-- **The reading on which James uses "justify" otherwise**: works the same in
both, faith the same, and "justify" a vindication in James and a verdict in
Paul. Moo's and Calvin's reading of James 2:24, which the library cites for
`james2_24Compatible`. -/
def justifyDiffers : Valuation Lexeme := fun w => w ≠ .dikaioo

/-- **Consistency does not choose *works***. The Bible's consistency, applied to
these two passages, does not entail that Paul and James mean different things by
*works*: the reading on which they differ over "justify" keeps both passages,
and consistency, with *works* the same. What the article's conclusion needs
beyond consistency is a reason to prefer its choice of word — which it goes on to
give, and which is weighed where the library weighs ἔργα νόμου. -/
theorem consistency_does_not_choose_works :
    ¬ Entails consistencyHere (∼ p .erga) := by
  refute_with justifyDiffers [consistencyHere]

/-! ### The move, heard in the dispute

The checks above say what the phrase argument assumes. This section weighs it:
the move is stated as a position, with the assumption it does not state made
explicit, and heard with every party to the library's sola fide dispute. The
solver then says whether it can be defended — as it says of every party. -/

open Testimony.Logic.Framework
open Testimony.Arguments.SolaFide (Claim baseCite partyNode partyDefeats solaFideDispute
  solaFideDispute_defeats partyNode_strength partyStrength)

/-- Howell's step, rated: from the verse, read with James's words in Paul's
senses, to "not by faith alone". Rated `disputed` pending an audit of who grants
those grounds and denies the conclusion, the rating every step starts at here. -/
def howellInference : Source :=
  { primary := .work Bib.howellSavedByFaithAlone .whole
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **The phrase argument, as a position.** What James 2:24 says; what the move
needs and does not state — that James's "justify" and "faith" are Paul's, which
is the denial of `james2_24Compatible`; and the step from them to the move's
conclusion, that justification is not by faith alone. -/
@[solaFideDefs]
def howellCase : ArgumentPackage Claim :=
  { name := "Howell, on the phrase \"faith alone\""
  , cite := baseCite
  , premises :=
      [ p .james2_24NotByFaithAlone, notP .james2_24Compatible
      , ⋀ [p .james2_24NotByFaithAlone, notP .james2_24Compatible] ➝
          notP .justificationByFaithAlone ]
  , conclusion := notP .justificationByFaithAlone
  , conclusionLabel := "notByFaithAlone"
  , inferences := [howellInference] }

/-- The move delivers its conclusion. -/
theorem howellCase_establishes : Establishes howellCase := by establish [solaFideDefs]

/-- **Howell's world**: James says what he says, in Paul's senses, and
justification is not by faith alone; every other claim as Trent's world has it,
so that nothing else is in question. -/
def howellReading : Valuation Claim := fun a =>
  match a with
  | .james2_24Compatible => False
  | .justificationByFaithAlone => False
  | _ => True

/-- The move's premises can all be true. -/
theorem howellCase_is_satisfiable : Satisfiable howellCase.premises := by
  satisfied_by howellReading [solaFideDefs]

/-- Its weakest link is at the bottom: the sense it needs is a denial, and a
denial ranks `disputed`. -/
theorem howellCase_strength : howellCase.strength = 0 := by decide

/-- The parties: Howell's move, and every party to the sola fide dispute. -/
abbrev Party := Option Arguments.SolaFide.Party

/-- Howell's move. -/
abbrev howell : Party := none

/-- The package each party argues from. -/
@[solaFideDefs]
def node : Party → ArgumentPackage Claim
  | none => howellCase
  | some q => partyNode q

/-- **The sola fide dispute, with Howell heard.** -/
def hearing : Dispute Claim Party where
  node := node
  consistent
    | none => howellCase_is_satisfiable
    | some q => solaFideDispute.consistent q
  sound
    | none => howellCase_establishes
    | some q => solaFideDispute.sound q
  rated
    | none => by simp [node, howellCase]
    | some q => solaFideDispute.rated q

/-- Who Howell defeats, and who defeats him: Paul's case and Peter's, both ways.
Paul's and Peter's cases derive that James 2:24 is compatible with Paul, which
Howell denies, and conclude what he denies; Howell's move rebuts both. Luke's
case does not answer James, and nothing else touches the verse. -/
def howellDefeats : Arguments.SolaFide.Party → Bool
  | .pauline | .apostolic => true
  | _ => false

/-- The defeats of the hearing, as a table: the dispute's own, and Howell's. -/
def defeatsTable : Party → Party → Prop
  | none, none => False
  | none, some q => howellDefeats q = true
  | some q, none => howellDefeats q = true
  | some q, some r => partyDefeats q r

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel defeatsTable := fun i j => by
  cases i <;> cases j <;> unfold defeatsTable <;> infer_instance

/-- Each party's weakest link. -/
def strength : Party → ℕ
  | none => 0
  | some q => partyStrength q

/-- **Who defeats whom in the hearing**, all 169 pairs: what the sola fide
dispute already proved, and Howell's twenty-five, computed by `Horn.defeats?`
and checked by the kernel. -/
theorem hearing_defeats : ∀ i j, hearing.defeats i j ↔ defeatsTable i j := by
  intro i j
  cases i with
  | some q =>
    cases j with
    | some r => exact solaFideDispute_defeats q r
    | none =>
      refine Horn.defeats_iff_of_defeats? (partyNode_strength q) howellCase_strength ?_
      cases q <;> decide +kernel
  | none =>
    cases j with
    | none =>
      refine Horn.defeats_iff_of_defeats? howellCase_strength howellCase_strength ?_
      decide +kernel
    | some r =>
      refine Horn.defeats_iff_of_defeats? howellCase_strength (partyNode_strength r) ?_
      cases r <;> decide +kernel

/-- The hearing in the form the verdict solver computes with. -/
def hearingFinite : Solver.Finite hearing.defeats where
  parties := howell :: Arguments.SolaFide.solaFideFinite.parties.map some
  complete i := by cases i with | none => decide | some q => cases q <;> decide
  defeats i j := decide (defeatsTable i j)
  spec i j := by rw [hearing_defeats]; simp

/-- Why Howell's move can be defended: it stands with Trent, Sanders and
Jervell, and answers both its attackers — Paul's case and Peter's — itself. -/
def howellStandsWithTrent : Verdict hearing where
  finite := hearingFinite
  claim := .credulous howell [howell, some .trent, some .sanders, some .jervell]
  checked := by decide +kernel

/-- **Howell's move can be defended.** It is not indefensible: the library does
not show that its claim cannot be held. It answers each party that attacks it,
and the weighing cannot choose between them, because every link on both sides
is rated at the bottom. -/
theorem howell_defensible : CredulouslyAccepted hearing.defeats howell :=
  howellStandsWithTrent.holds

/-- Why Howell's move is not forced: a defensible position holds Paul's case,
and Paul's case defeats it. -/
def howellAnsweredByPaul : Verdict hearing where
  finite := hearingFinite
  claim := .notSkeptical howell (some .pauline)
    [some .pauline, some .dominical, some .apostolic, some .critics]
  checked := by decide +kernel

/-- **Nor is it forced.** A defensible position holds Paul's case with Luke's
and Peter's, and Paul's and Peter's cases cannot be held with Howell's move. -/
theorem howell_not_forced : ¬ SkepticallyAccepted hearing.defeats howell :=
  howellAnsweredByPaul.holds

/-- Why Paul's case can be defended in the hearing: with Luke's, Peter's and the
critics', answering everyone who attacks it — Howell included. -/
def paulStandsWithLuke : Verdict hearing where
  finite := hearingFinite
  claim := .credulous (some .pauline)
    [some .pauline, some .dominical, some .apostolic, some .critics]
  checked := by decide +kernel

/-- Paul's case derives that James 2:24 is compatible with Paul. -/
theorem pauline_holds_compatibility :
    Entails (hearing.node (some .pauline)).premises (p .james2_24Compatible) := by
  establish [solaFideDefs, hearing]

/-- Howell's move denies it. -/
theorem howell_denies_compatibility :
    Entails (hearing.node howell).premises (∼ p .james2_24Compatible) := by
  establish [solaFideDefs, hearing]

/-- **Whether James uses "justify" and "faith" in Paul's senses is contested,
and the weighing confirms it.** The rating `disputed` on `james2_24Compatible`
is a citation: a reader grants the verse and denies the harmony. Heard as
positions, the claim's holder — Paul's case — and its denier — Howell's move —
can each be defended, and neither is forced. The dispute the rating records is
live: it survives the weighing. -/
def jamesContested : Contested hearing (p .james2_24Compatible) where
  holder := some .pauline
  denier := howell
  holds := pauline_holds_compatibility
  denies := howell_denies_compatibility
  holderDefensible := paulStandsWithLuke.holds
  denierDefensible := howell_defensible

end Testimony.Articles.Howell2003
