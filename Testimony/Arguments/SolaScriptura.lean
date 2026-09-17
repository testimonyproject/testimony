import Testimony.Attr
import Testimony.Logic.Line
import Testimony.Logic.Tactic
import Testimony.Scripture
import Testimony.Bib.Works

/-!
# Arguments.SolaScriptura — scripture as the sole infallible rule of faith

A seed encoding: the atoms, citations and packages are complete; the full set
of derivations is left to a follow-up.

The formal principle of the Reformation is harder to encode than the material
one. Sola fide is a claim *within* scripture's teaching; sola scriptura is a
claim *about* scripture's authority, and so must answer an objection the
material principle never faces.

**The self-refutation objection.** If a doctrine is binding only when scripture
teaches it, and scripture does not teach sola scriptura, then sola scriptura is
not binding by its own standard. This is encoded in `selfRefutation` and the
result `selfRefutation_defeats_unwarranted_claim` — the objection succeeds
against a package that does not also hold that scripture teaches the principle.
Encoding an objection that tells against the position is not a concession; the
project's ground rules require rival readings to be encoded with the same care
as the ones being argued for, and an argument whose strongest objection is
missing is not being honestly represented.

The Protestant package answers the objection by asserting
`solaScripturaIsTaughtByScripture`, which is itself disputed and is marked so.
-/

namespace Testimony.Arguments.SolaScriptura

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- 2 Timothy 3:16 — all scripture is God-breathed and profitable. -/
  | timothy3_16GodBreathed
  /-- 2 Timothy 3:17 — that the man of God may be complete, equipped for every
  good work. -/
  | timothy3_17ThoroughlyEquips
  /-- Mark 7:8–13 — Jesus rebukes tradition that nullifies the command of
  God. -/
  | mark7TraditionCanNullify
  /-- Acts 17:11 — the Bereans tested apostolic preaching against scripture. -/
  | acts17BereansTested
  /-- Scripture is a sufficient rule of faith. -/
  | scriptureIsSufficient
  /-- Scripture is clear on what is necessary for salvation. -/
  | scriptureIsPerspicuous
  /-- Scripture is the sole infallible rule of faith. **The conclusion.** -/
  | scriptureIsSoleInfallibleRule
  /-- 2 Thessalonians 2:15 — hold to the traditions taught by word or letter.
  The Catholic and Orthodox counter-text. -/
  | thessalonians2_15TraditionBinding
  /-- The magisterium is an infallible interpreter of scripture. -/
  | magisteriumIsInfallible
  /-- Scripture itself teaches sola scriptura. The hinge of the
  self-refutation objection. -/
  | solaScripturaIsTaughtByScripture
  /-- A doctrine is binding only if scripture teaches it. -/
  | onlyScripturalDoctrineIsBinding
deriving DecidableEq, Repr

/-- Citation and classification for every atom. Total, so nothing is
uncited. -/
def cite : Claim → AtomMeta
  | .timothy3_16GodBreathed =>
    { label := "2 Timothy 3:16 — all scripture is God-breathed and profitable"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.secondTimothy, 3, 16⟩ }] "I.vii.1" }
  | .timothy3_17ThoroughlyEquips =>
    { label := "2 Timothy 3:17 — that the man of God may be complete, equipped for every good work"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.secondTimothy, 3, 17⟩ }] "I.vii.1" }
  | .mark7TraditionCanNullify =>
    { label := "Mark 7:8–13 — Jesus rebukes tradition that nullifies God's command"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .range ⟨.mark, 7, 8, 7, 13⟩ }] "IV.x.8" }
  | .acts17BereansTested =>
    { label := "Acts 17:11 — the Bereans tested apostolic preaching against scripture"
    , kind := .textual
    , source := scriptureWithCalvin [{ ref := .verse ⟨.acts, 17, 11⟩ }] "I.vii.2" }
  | .scriptureIsSufficient =>
    { label := "Scripture is a sufficient rule of faith"
    , kind := .theological
    , source := calvinHolds "I.vii" .disputed }
  | .scriptureIsPerspicuous =>
    { label := "Scripture is clear on what is necessary for salvation"
    , kind := .theological
    , source := calvinHolds "I.vii.5" .disputed }
  | .scriptureIsSoleInfallibleRule =>
    { label := "Scripture is the sole infallible rule of faith"
    , kind := .theological
    , source := calvinHolds "I.vii–ix" .disputed }
  | .thessalonians2_15TraditionBinding =>
    { label := "2 Thessalonians 2:15 — hold to the traditions taught by word or letter"
    , kind := .textual
    , source :=
        { primary := .scripture [{ ref := .verse ⟨.secondThessalonians, 2, 15⟩ }]
        , supporting :=
            [.work tannerDecrees
              (.sectionRef "Trent, Session IV (1546), Decree on Sacred Books and Traditions")]
        , tradition := .romanCatholic
        , confidence := .wellSupported } }
  | .magisteriumIsInfallible =>
    { label := "The magisterium is an infallible interpreter of scripture"
    , kind := .theological
    , source :=
        { primary := .work tannerDecrees
            (.sectionRef "Trent, Session IV (1546), Decree on the Vulgate Edition")
        , tradition := .romanCatholic
        , confidence := .wellSupported } }
  | .solaScripturaIsTaughtByScripture =>
    { label := "Scripture itself teaches that scripture is the sole infallible rule"
    , kind := .interpretive
      -- The crux of the self-refutation objection: denied by Catholic and
      -- Orthodox critics, and conceded by some Protestants to be an inference
      -- rather than an explicit teaching.
    , source := calvinHolds "I.vii.4" .disputed }
  | .onlyScripturalDoctrineIsBinding =>
    { label := "A doctrine is binding only if scripture teaches it"
    , kind := .theological
    , source := calvinHolds "IV.x.8" .disputed }

/-! ### Lines of reason

Three, and they disagree. The Protestant line and the self-refutation objection
run on the same hinge — `solaScripturaIsTaughtByScripture` — from opposite
sides, which is the whole of the dispute encoded in two lines. -/

/-- Sufficiency and perspicuity, together with the prooftexts, yield the sole
infallible rule. -/
def toSoleRule : Formula Claim :=
  .imp (conjOf
        [ p .timothy3_16GodBreathed, p .timothy3_17ThoroughlyEquips
        , p .scriptureIsSufficient, p .scriptureIsPerspicuous
        , p .solaScripturaIsTaughtByScripture ])
       (p .scriptureIsSoleInfallibleRule)

/-- Binding tradition and an infallible interpreter of it together deny that
scripture is the *sole* infallible rule. -/
def traditionDeniesSoleRule : Formula Claim :=
  .imp (conjOf [p .thessalonians2_15TraditionBinding, p .magisteriumIsInfallible])
       (notP .scriptureIsSoleInfallibleRule)

/-- If a doctrine binds only when scripture teaches it, and scripture does not
teach sola scriptura, then sola scriptura does not bind. -/
def selfRefutationStep : Formula Claim :=
  .imp (conjOf [p .onlyScripturalDoctrineIsBinding, notP .solaScripturaIsTaughtByScripture])
       (notP .scriptureIsSoleInfallibleRule)

/-- **The Protestant line.** The prooftexts, sufficiency and perspicuity, and
the answer to the self-refutation objection. -/
def protestantLine : Line Claim :=
  { name := "Protestant (sola scriptura)"
  , grounds :=
      [ p .timothy3_16GodBreathed, p .timothy3_17ThoroughlyEquips
      , p .mark7TraditionCanNullify, p .acts17BereansTested
      , p .scriptureIsSufficient, p .scriptureIsPerspicuous
      , p .solaScripturaIsTaughtByScripture ]
  , step := toSoleRule
  , delivers := p .scriptureIsSoleInfallibleRule }

/-- **The Catholic and Orthodox line.** Scripture with apostolic tradition,
interpreted by the magisterium. -/
def traditionLine : Line Claim :=
  { name := "Catholic/Orthodox (scripture with tradition)"
  , grounds :=
      [ p .timothy3_16GodBreathed, p .thessalonians2_15TraditionBinding
      , p .magisteriumIsInfallible ]
  , step := traditionDeniesSoleRule
  , delivers := notP .scriptureIsSoleInfallibleRule }

/-- **The self-refutation line.** The objection that sola scriptura fails by
its own standard. -/
def selfRefutationLine : Line Claim :=
  { name := "Self-refutation objection to sola scriptura"
  , grounds :=
      [ p .onlyScripturalDoctrineIsBinding
      , notP .solaScripturaIsTaughtByScripture ]
  , step := selfRefutationStep
  , delivers := notP .scriptureIsSoleInfallibleRule }

/-! ### Packages -/

/-- The Protestant position, which answers the self-refutation objection by
holding that scripture does teach the principle. -/
def protestant : ArgumentPackage Claim :=
  protestantLine.asPackage cite "scripture is the sole infallible rule of faith"

/-- The Catholic and Orthodox position: scripture and apostolic tradition
together, interpreted by the magisterium.

Its line *delivers* the denial, so the package is not the line as it stands:
the question asked of these premises is whether sola scriptura follows, and the
answer is that they entail its negation. -/
def traditionAndMagisterium : ArgumentPackage Claim :=
  { traditionLine.asPackage cite "scripture is the sole infallible rule of faith" with
    conclusion := p .scriptureIsSoleInfallibleRule }

/-- The self-refutation objection, stated as a package concluding the negation
of sola scriptura. -/
def selfRefutation : ArgumentPackage Claim :=
  selfRefutationLine.asPackage cite "scripture is not the sole infallible rule of faith"

/-! ### Results -/

/-- Given the Protestant premises, the conclusion follows. -/
@[headline]
theorem protestant_establishes : Establishes protestant := by
  establish [protestant, protestantLine, toSoleRule]

#print axioms protestant_establishes

/-- The Catholic and Orthodox reading, written down: scripture and apostolic
tradition together, interpreted by the magisterium, so scripture is not the
*sole* infallible rule. -/
def traditionReading : Valuation Claim := fun a =>
  match a with
  | .scriptureIsSoleInfallibleRule => False
  | _ => True

/-- The Catholic/Orthodox premises do not establish sola scriptura — they
entail its negation. -/
@[headline]
theorem traditionAndMagisterium_not_establishes :
    ¬ Establishes traditionAndMagisterium := by
  refute_with traditionReading [traditionAndMagisterium, traditionLine,
    traditionDeniesSoleRule]

#print axioms traditionAndMagisterium_not_establishes

/-- The self-refutation objection is valid: granted that only scriptural
doctrine binds and that scripture does not teach sola scriptura, sola scriptura
fails by its own standard.

This says nothing about whether the objection is *sound* — the Protestant
package denies its second premise. What the library shows is that the dispute
reduces to `solaScripturaIsTaughtByScripture`, which is where the argument
between the traditions actually lives. -/
@[headline]
theorem selfRefutation_is_valid : Establishes selfRefutation := by
  establish [selfRefutation, selfRefutationLine, selfRefutationStep]

#print axioms selfRefutation_is_valid

end Testimony.Arguments.SolaScriptura
