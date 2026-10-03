import Testimony.Semantics.Discourse
import Testimony.Semantics.SolaFide
import Testimony.Logic.Tactic

/-!
# Testimony.Semantics.Howell — an article, checked against the library

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

What the check does not do: it does not say which reading of James is right. It
says what each move costs, in senses, and points at the library's rated claims
about those senses.
-/

namespace Testimony.Semantics.Howell

open Testimony Testimony.Semantics Testimony.Semantics.SolaFide

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
alone. -/
def jamesSays : Statement :=
  .says james2_24 <| .both (rl .groundOf (wd .erga james2_24) (wd .dikaioo james2_24))
    (.not (rl .soleInstrumentOf (wd .pistis james2_24) (wd .dikaioo james2_24)))

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

/-- The words a move needs to mean the same at two places, and does not say so,
less the one its conclusion is about. -/
def unstatedBesidesConclusion (m : Move) : List Lexeme :=
  match m.act with
  | .argues _ (.denied (.sameSense w _ _)) | .argues _ (.sameSense w _ _) =>
    m.unstatedWords.filter (· ≠ w)
  | _ => m.unstatedWords

/-- **The argument about works needs "justify" and "faith" the same in Romans 4
and James 2, and does not say so.** Its own conclusion is about *works*; the
other two words the passages share are left as they were. -/
theorem works_unstated : unstatedBesidesConclusion worksMove = [.dikaioo, .pistis] := by
  decide

/-- **The argument from the phrase needs James's "justify" and "faith" to be
Paul's, and does not say so.** -/
theorem faithAlone_unstated : faithAloneMove.unstatedWords = [.dikaioo, .pistis] := by
  decide

/-- **The objector's reply needs "faith" in James 2:14 to be "faith" in 2:24,
and does not say so.** The same check, on the other side. -/
theorem deadFaith_unstated : deadFaithMove.unstatedWords = [.pistis] := by
  decide

/-- The sola fide claims that deny a word has the same sense at two places. -/
def deniesSameSense (w : Lexeme) (a b : Scope) (s : Statement) : Bool :=
  match s with
  | .denied (.sameSense w' a' b') => w == w' && ((a == a' && b == b') || (a == b' && b == a'))
  | .also s t => deniesSameSense w a b s || deniesSameSense w a b t
  | _ => false

/-- For each sense a move needs and does not state, the library's claims that
deny it. -/
def meetsTheLibrary (m : Move) : List (Lexeme × List Arguments.SolaFide.Claim) :=
  m.unstated.filterMap fun (w, a, b) =>
    match all.filter (fun c => deniesSameSense w a b (means c)) with
    | [] => none
    | cs => some (w, cs)

/-- **Both senses the phrase argument needs are denied by one claim in the
library**: `james2_24Compatible`, cited to Moo and Calvin and rated
`disputed`. The move stands only if that claim is false, and the article does
not argue that it is. -/
theorem faithAlone_meets_the_library :
    meetsTheLibrary faithAloneMove =
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

end Testimony.Semantics.Howell
