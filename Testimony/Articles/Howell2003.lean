import Testimony.Semantics.Discourse
import Testimony.Meanings.SolaFide
import Testimony.Arguments.SolaFide
import Testimony.Arguments.SolaFide.James
import Testimony.Logic.Contest
import Testimony.Logic.Credibility

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
uses. The move does not say so (`faithAlone_unstated`), and the first of the
two is exactly what the library's `jamesFaithIsNotReformedFaith` denies
(`faithAlone_meets_the_library`).

**Heard in the dispute, the phrase argument cannot be defended**
(`howell_indefensible`). Stated as a position — the verse, the senses the move
needs made explicit, and its step — and heard with every party to the sola fide
dispute and with James's own words about faith, it falls to those words. James
calls the faith he denies justifies dead (2:17, 2:26); Trent reads it so (Session
VI, ch. 7); and the Reformers' confession calls the faith that alone justifies
"no dead faith, but worketh by love" (Westminster XI.2). Every link of that
answer is rated `wellSupported` or better, and none rests on anyone's word alone,
so the move's reply, from a denial at the bottom, fails against it. The denial
it needs does not survive the weighing (`faithDenialAnswered`).

**What that does not reach.** The article's other case from James — "works
actually justify", Abraham "justified by doing a work that grew out of his faith"
— is the Catholic reading of James's "by works", weighed in `SolaFide.James`.
Read as a claim about James's word δικαιόω (the increase of justice) it cannot be
defended there (`trent_on_james_word_indefensible`); read as a claim about what
works do before God (Trent, canon 24) it can be, and is not forced
(`trent_on_works_defensible`, `trent_on_works_not_forced`). The article argues
from James's words, so its own route is the first; the doctrine survives on the
second.

**The objector is held to the same check.** His reply — James 2:14 "is dealing
with the problem of those who claim faith but who don't show it by their
works" — takes "faith" in 2:14 for "faith" in 2:24, and does not say so either
(`deadFaith_unstated`). That is the Reformed reading's own unstated condition,
and here it is supplied: the faith of 2:24 is the faith of 2:14–26
(`jamesFaithAloneIsDeadFaith`, rated `wellSupported`, and granted by Trent).

What the checks do not do: they do not say which reading of James's "by works"
is right. The design note `docs/src/semantics.md` says what that would take.
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

/-- *Sola fide* as the Reformers state it: faith, in their sense, the only means
of justification, in their sense. -/
def solaFideOfPaul : Statement :=
  .holds (rl .soleInstrumentOf (.word .pistis (.usage .reformed))
    (.word .dikaioo (.usage .reformed)))

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
      [(.pistis, [.jamesFaithIsNotReformedFaith])] := by
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
needs and does not state — that James's "faith" is the faith of the Reformers'
formula, and that James's words have Paul's senses, the denials of
`jamesFaithIsNotReformedFaith` and of `james2_24Compatible`; and the step from
them to the move's conclusion, that justification is not by faith alone. -/
@[solaFideDefs]
def howellCase : ArgumentPackage Claim :=
  { name := "Howell, on the phrase \"faith alone\""
  , cite := baseCite
  , premises :=
      [ p .james2_24NotByFaithAlone, notP .jamesFaithIsNotReformedFaith
      , notP .james2_24Compatible
      , ⋀ [p .james2_24NotByFaithAlone, notP .jamesFaithIsNotReformedFaith,
            notP .james2_24Compatible] ➝ notP .justificationByFaithAlone ]
  , conclusion := notP .justificationByFaithAlone
  , conclusionLabel := "notByFaithAlone"
  , inferences := [howellInference] }

/-- The move delivers its conclusion. -/
theorem howellCase_establishes : Establishes howellCase := by establish [solaFideDefs]

/-- **Howell's world**: James says what he says, his "faith" the Reformers'
faith and his words Paul's, and justification is not by faith alone. -/
def howellReading : Valuation Claim := fun a =>
  match a with
  | .james2_24Compatible => False
  | .jamesFaithIsNotReformedFaith => False
  | .justificationByFaithAlone => False
  | _ => True

/-- The move's premises can all be true. -/
theorem howellCase_is_satisfiable : Satisfiable howellCase.premises := by
  satisfied_by howellReading [solaFideDefs]

/-- Its weakest link is at the bottom: the senses it needs are denials, and a
denial ranks `disputed`. -/
theorem howellCase_strength : howellCase.strength = 0 := by decide

/-- The parties: Howell's move, James's faith, and every party to the sola fide
dispute. -/
inductive Party
  /-- Howell's move from the phrase "faith alone". -/
  | howell
  /-- James's faith: the faith James 2:24 denies is not the Reformers' faith. -/
  | faith
  /-- A party to the sola fide dispute. -/
  | sola (q : Arguments.SolaFide.Party)
deriving DecidableEq

/-- The package each party argues from. -/
@[solaFideDefs]
def node : Party → ArgumentPackage Claim
  | .howell => howellCase
  | .faith => Arguments.SolaFide.jamesFaithCase
  | .sola q => partyNode q

/-- **The sola fide dispute, with Howell's move and James's faith heard.** -/
def hearing : Dispute Claim Party where
  node := node
  consistent
    | .howell => howellCase_is_satisfiable
    | .faith => Arguments.SolaFide.jamesFaithCase_is_satisfiable
    | .sola q => solaFideDispute.consistent q
  sound
    | .howell => howellCase_establishes
    | .faith => Arguments.SolaFide.jamesFaithCase_establishes
    | .sola q => solaFideDispute.sound q
  rated
    | .howell => by simp [node, howellCase]
    | .faith => by simp [node, solaFideDefs, Line.asPackage]
    | .sola q => solaFideDispute.rated q

/-- Who Howell's move defeats among the sola fide parties, and who defeats it:
Paul's case and Peter's, both ways. -/
def howellMeets : Arguments.SolaFide.Party → Bool
  | .pauline | .apostolic => true
  | _ => false

/-- The defeats of the hearing, as a table: the sola fide dispute's own; Howell's
standoffs with Paul's and Peter's cases; and James's faith over Howell. -/
def defeatsTable : Party → Party → Prop
  | .faith, .howell => True
  | .howell, .sola q => howellMeets q = true
  | .sola q, .howell => howellMeets q = true
  | .sola q, .sola r => partyDefeats q r
  | _, _ => False

/-- The table is finite, so membership in it is decidable. -/
instance : DecidableRel defeatsTable := fun i j => by
  cases i <;> cases j <;> unfold defeatsTable <;> infer_instance

/-- Each party's weakest link. -/
def strength : Party → ℕ
  | .howell => 0
  | .faith => 2
  | .sola q => partyStrength q

/-- Each party's weakest link, as its package computes it. -/
theorem node_strength : ∀ i, (node i).strength = strength i
  | .howell => howellCase_strength
  | .faith => Arguments.SolaFide.jamesFaithCase_strength
  | .sola q => partyNode_strength q

/-- **Who defeats whom in the hearing**, all 196 pairs: what the sola fide
dispute already proved; Howell's move and Paul's and Peter's cases, both ways;
and James's faith over Howell's move, which cannot answer it. James's faith
meets nothing else. Computed by `Horn.defeats?` and checked by the kernel. -/
theorem hearing_defeats : ∀ i j, hearing.defeats i j ↔ defeatsTable i j := by
  intro i j
  cases i with
  | howell =>
    cases j with
    | howell =>
      exact Horn.defeats_iff_of_defeats? (node_strength .howell) (node_strength .howell)
        (by decide +kernel)
    | faith =>
      exact Horn.defeats_iff_of_defeats? (node_strength .howell) (node_strength .faith)
        (by decide +kernel)
    | sola r =>
      refine Horn.defeats_iff_of_defeats? (node_strength .howell) (node_strength (.sola r)) ?_
      cases r <;> decide +kernel
  | faith =>
    cases j with
    | howell =>
      exact Horn.defeats_iff_of_defeats? (node_strength .faith) (node_strength .howell)
        (by decide +kernel)
    | faith =>
      exact Horn.defeats_iff_of_defeats? (node_strength .faith) (node_strength .faith)
        (by decide +kernel)
    | sola r =>
      refine Horn.defeats_iff_of_defeats? (node_strength .faith) (node_strength (.sola r)) ?_
      cases r <;> decide +kernel
  | sola q =>
    cases j with
    | howell =>
      refine Horn.defeats_iff_of_defeats? (node_strength (.sola q)) (node_strength .howell) ?_
      cases q <;> decide +kernel
    | faith =>
      refine Horn.defeats_iff_of_defeats? (node_strength (.sola q)) (node_strength .faith) ?_
      cases q <;> decide +kernel
    | sola r => exact solaFideDispute_defeats q r

/-- The hearing in the form the verdict solver computes with. -/
def hearingFinite : Solver.Finite hearing.defeats where
  parties := .howell :: .faith :: Arguments.SolaFide.solaFideFinite.parties.map .sola
  complete i := by cases i with | sola q => cases q <;> decide | _ => decide
  defeats i j := decide (defeatsTable i j)
  spec i j := by rw [hearing_defeats]; simp

/-- Why Howell's move cannot be defended: James's faith defeats it, and nothing
defeats James's faith. -/
def howellAnswered : Verdict hearing where
  finite := hearingFinite
  claim := .indefensible .howell [(.howell, .faith)]
  checked := by decide +kernel

/-- **Howell's argument from the phrase "faith alone" cannot be defended.** It
needs James's "faith" to be the faith the Reformers say alone justifies. James
calls the faith he denies justifies dead (2:17, 2:26), Trent reads it so
(Session VI, ch. 7), and the Reformers' own confession calls their faith "no
dead faith" (Westminster XI.2). Every link of that answer is rated
`wellSupported` or better, and the move's reply rests on a denial at the bottom.

What this does not claim: that James 2:24 is compatible with Paul, or that
justification is by faith alone. Howell's move stands off against Paul's and
Peter's cases as before; it falls to James's own words about faith, which a
Catholic reader grants. Nor does it touch the Catholic reading of James's
"by works" (`trent_on_works_defensible`). -/
theorem howell_indefensible (S : Set Party) (hS : Admissible hearing.defeats S) :
    Party.howell ∉ S :=
  howellAnswered.holds S hS

/-- James's faith derives that the faith James denies is not the Reformers'. -/
theorem faith_holds :
    Entails (hearing.node .faith).premises (p .jamesFaithIsNotReformedFaith) := by
  establish [solaFideDefs, hearing]

/-- Howell's move denies it. -/
theorem howell_denies :
    Entails (hearing.node .howell).premises (∼ p .jamesFaithIsNotReformedFaith) := by
  establish [solaFideDefs, hearing]

/-- No sola fide party denies it: each can be held with it. -/
theorem sola_does_not_deny (q : Arguments.SolaFide.Party) :
    ¬ Entails (hearing.node (.sola q)).premises (∼ p .jamesFaithIsNotReformedFaith) := by
  rw [entails_neg_iff, not_not]
  apply satisfiable_of_check
  cases q <;> decide +kernel

/-- **The denial that James's faith differs from the Reformers' is answered.**
Its one holder in the hearing, Howell's move, cannot be defended. The dispute
over the phrase "faith alone" is not live: the reading Howell needs is
disputed in an article, and does not survive the weighing. -/
def faithDenialAnswered : DenialAnswered hearing (p .jamesFaithIsNotReformedFaith) where
  deniers := [.howell]
  deny i hi := by simp at hi; subst hi; exact howell_denies
  complete i h := by
    cases i with
    | howell => simp
    | faith =>
      exfalso
      exact (entails_neg_iff.mp h)
        (satisfiable_of_model Arguments.SolaFide.reformedJamesReading (by
          simp [hearing, node, solaFideDefs, Line.asPackage, Line.premises,
            Arguments.SolaFide.reformedJamesReading]))
    | sola q => exact absurd h (sola_does_not_deny q)
  indefensible i hi S hS := by simp at hi; subst hi; exact howell_indefensible S hS

/-- **Howell's move, as a dissent from James's faith**: his position set against
the step that concludes the faith James denies is not the Reformers'. -/
def howellDissent : Dissent Claim :=
  { claim := p .jamesFaithIsNotReformedFaith
  , grounds := Arguments.SolaFide.jamesFaithLine.grounds
  , position := howellCase }

/-- **Howell's dissent is a disagreement, not a critique.** He holds that the
faith James denies *is* the Reformers' as a premise — a bare denial, which his
article asserts and argues from no text — and that premise alone contradicts
the step's conclusion. He gives no reason the step's grounds fail to yield it. So under
either standard the dissent is not credible (`Testimony.Logic.Credibility`),
whatever weight his article carries otherwise. -/
theorem howell_asserts_his_denial :
    howellDissent.assertsDenial = true ∧
      ¬ Satisfiable (howellDissent.asserted ++ [howellDissent.claim]) :=
  ⟨by decide +kernel, Dissent.not_argued_of_check (by decide +kernel)⟩

#print axioms howell_asserts_his_denial

end Testimony.Articles.Howell2003
