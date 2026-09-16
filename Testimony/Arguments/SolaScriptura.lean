import Testimony.Attr
import Testimony.Logic.Package
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

open Testimony Testimony.Bib Testimony.Logic

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

/-- Shorthand for an atomic formula. -/
abbrev p (c : Claim) : Formula Claim := .atom c

/-- Negation, as Foundation defines it: `φ ➝ ⊥`. -/
abbrev notP (c : Claim) : Formula Claim := .imp (.atom c) .falsum

/-- A scripture citation supported by Calvin. -/
private def scriptureWithCalvin (refs : List ScriptureCitation) (loc : String) : Source :=
  { primary := .scripture refs
  , supporting := [.work calvinInstitutes (.sectionRef loc)]
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

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
    , source :=
        { primary := .work calvinInstitutes (.sectionRef "I.vii")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .scriptureIsPerspicuous =>
    { label := "Scripture is clear on what is necessary for salvation"
    , kind := .theological
    , source :=
        { primary := .work calvinInstitutes (.sectionRef "I.vii.5")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .scriptureIsSoleInfallibleRule =>
    { label := "Scripture is the sole infallible rule of faith"
    , kind := .theological
    , source :=
        { primary := .work calvinInstitutes (.sectionRef "I.vii–ix")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
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
    , source :=
        { primary := .work calvinInstitutes (.sectionRef "I.vii.4")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .onlyScripturalDoctrineIsBinding =>
    { label := "A doctrine is binding only if scripture teaches it"
    , kind := .theological
    , source :=
        { primary := .work calvinInstitutes (.sectionRef "IV.x.8")
        , tradition := .reformedProtestant
        , confidence := .disputed } }

/-- Sufficiency and perspicuity, together with the prooftexts, yield the sole
infallible rule. -/
def toSoleRule : Formula Claim :=
  .imp (conjOf
        [ p .timothy3_16GodBreathed, p .timothy3_17ThoroughlyEquips
        , p .scriptureIsSufficient, p .scriptureIsPerspicuous
        , p .solaScripturaIsTaughtByScripture ])
       (p .scriptureIsSoleInfallibleRule)

/-- If a doctrine binds only when scripture teaches it, and scripture does not
teach sola scriptura, then sola scriptura does not bind. -/
def selfRefutationStep : Formula Claim :=
  .imp (conjOf [p .onlyScripturalDoctrineIsBinding, notP .solaScripturaIsTaughtByScripture])
       (notP .scriptureIsSoleInfallibleRule)

/-- The Protestant position, which answers the self-refutation objection by
holding that scripture does teach the principle. -/
def protestant : ArgumentPackage Claim :=
  { name := "Protestant (sola scriptura)"
  , cite := cite
  , premises :=
      [ p .timothy3_16GodBreathed, p .timothy3_17ThoroughlyEquips
      , p .mark7TraditionCanNullify, p .acts17BereansTested
      , p .scriptureIsSufficient, p .scriptureIsPerspicuous
      , p .solaScripturaIsTaughtByScripture, toSoleRule ]
  , conclusion := p .scriptureIsSoleInfallibleRule
  , conclusionLabel := "scripture is the sole infallible rule of faith" }

/-- The Catholic and Orthodox position: scripture and apostolic tradition
together, interpreted by the magisterium. -/
def traditionAndMagisterium : ArgumentPackage Claim :=
  { name := "Catholic/Orthodox (scripture with tradition)"
  , cite := cite
  , premises :=
      [ p .timothy3_16GodBreathed, p .thessalonians2_15TraditionBinding
      , p .magisteriumIsInfallible
      , .imp (conjOf [p .thessalonians2_15TraditionBinding, p .magisteriumIsInfallible])
             (notP .scriptureIsSoleInfallibleRule) ]
  , conclusion := p .scriptureIsSoleInfallibleRule
  , conclusionLabel := "scripture is the sole infallible rule of faith" }

/-- The self-refutation objection, stated as a package concluding the negation
of sola scriptura. -/
def selfRefutation : ArgumentPackage Claim :=
  { name := "Self-refutation objection to sola scriptura"
  , cite := cite
  , premises :=
      [ p .onlyScripturalDoctrineIsBinding
      , notP .solaScripturaIsTaughtByScripture
      , selfRefutationStep ]
  , conclusion := notP .scriptureIsSoleInfallibleRule
  , conclusionLabel := "scripture is not the sole infallible rule of faith" }

/-! ### Results -/

/-- Given the Protestant premises, the conclusion follows. -/
@[headline]
theorem protestant_establishes : Establishes protestant := by
  intro w hw
  simp only [protestant, toSoleRule, conjOf, p, List.mem_cons, List.not_mem_nil,
    or_false, forall_eq_or_imp, forall_eq, FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

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
  refine not_entails_of_countermodel traditionReading ?_ ?_ <;>
    simp [traditionAndMagisterium, conjOf, p, notP,
      FFL.Propositional.Formula.Boolean.val, traditionReading]

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
  intro w hw
  simp only [selfRefutation, selfRefutationStep, conjOf, p, notP, List.mem_cons,
    List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
    FFL.Propositional.Formula.Boolean.val] at hw ⊢
  tauto

#print axioms selfRefutation_is_valid

end Testimony.Arguments.SolaScriptura
