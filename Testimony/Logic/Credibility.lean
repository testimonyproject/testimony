import Testimony.Logic.Warrant
import Testimony.Logic.Horn
import Testimony.Logic.Page

/-!
# Testimony.Logic.Credibility — whether a dissent is a credible critique

**Phase one of computed ratings** (`docs/src/computed-ratings.md`). A rating is
asserted today: a step is `disputed` when a cited source grants its grounds and
denies its conclusion. That records that someone dissents. It does not say
whether the dissent is an argument or only a disagreement, and the difference is
what a reader most needs to know.

A **dissent** is a position, stated as a package, set against a claim — a
premise, or the conclusion of a step. This module asks of it five things the
library can check, and calls it **credible under a standard** when all five
hold:

1. **It is consistent.** Its premises have a model. A position that contradicts
   itself denies everything.
2. **It denies the claim.** Its premises entail the claim's negation.
3. **It grants the step's grounds**, when the claim is a step's conclusion. Its
   premises can be held with the grounds. A dissent that denies a ground is
   about that ground, and belongs to its rating — the library's existing rule,
   made a check.
4. **It is argued, not asserted.** The denial does not follow from what the
   dissent asserts outright; it needs one of the dissent's own steps. A
   position that holds the claim's negation as a premise is saying "I disagree",
   which is a fact about it, and not a critique.
5. **Its grounds meet the standard.** Every claim it asserts outright rests on
   what the standard admits, and it asserts no bare denial.

## Two standards, stated, never hidden

Whether a council's or a confession's word can ground a critique is exactly
what the sola scriptura dispute is about, so the library does not decide it.
It names the choice as a **standard** and computes under each:

- **evidence**: the dissent's grounds rest on Scripture or on evidence anyone
  can check (`Warrant.scripture`, `Warrant.evidence`);
- **tradition**: they may also rest on a council's, a confession's or a
  theologian's own word (`Warrant.authority`).

A page reports both. A rating that differs between them is a rating that turns
on the authority question, and the page says so.

## What is computed, and what is not

`computedRating` is `disputed` when some registered dissent is credible under
the standard, and otherwise the rating the claim's support is cited at. Two
things stay judgement, and are stated as such:

- **The support rating**, the breadth of the evidence for the claim, is still
  cited. What is computed is only whether a dissent brings it down.
- **The register.** A rating computed from the dissents that are encoded is only
  as good as the dissents encoded. So a computed rating may stand above
  `disputed` only when the strongest known dissent is encoded *with its own
  grounds* — the steelman rule. The dissent's encoding, not its holder's
  citation, is what is checked.

Phase one does not ask whether a dissent survives the dispute — whether it can
be defended. That depends on the ratings themselves, and so on what is being
computed. `Contested` and `DenialAnswered` (`Testimony.Logic.Contest`) report it
after the fact; the design note describes how phase three makes it part of the
computation without a circle.
-/

namespace Testimony.Logic

open Horn

variable {α : Type}

/-- What a dissent's grounds may rest on. -/
inductive Standard
  /-- Scripture, and evidence anyone can check. -/
  | evidence
  /-- Also a council's, a confession's or a theologian's own word. -/
  | tradition
deriving DecidableEq, Repr

/-- Whether a standard admits a warrant. Neither admits the library's own bare
assertion. -/
def Standard.admits : Standard → Warrant → Bool
  | .evidence, w => w == .scripture || w == .evidence
  | .tradition, w => w != .assertion

/-- **A dissent**: a position set against a claim. For a step, `grounds` are the
step's grounds, which the dissent must grant; for a premise, they are empty. -/
structure Dissent (α : Type) where
  /-- The claim dissented from. -/
  claim : Formula α
  /-- The grounds of the step whose conclusion the claim is, if any. -/
  grounds : List (Formula α) := []
  /-- The dissenting position. -/
  position : ArgumentPackage α

namespace Dissent

/-- The position's premises that are claims asserted outright: atoms and denied
atoms, not steps. -/
def asserted (d : Dissent α) : List (Formula α) :=
  d.position.premises.filter Page.Explanation.isLiteral

/-- Whether the position asserts a bare denial: a premise that only denies an
atom. A denial is cited nowhere — a citation rates the claim, not its denial —
so it rests on the position's say-so. -/
def assertsDenial (d : Dissent α) : Bool :=
  d.position.premises.any fun
    | .imp (.atom _) .falsum => true
    | _ => false

/-- Whether every claim the position asserts rests on what the standard admits,
and it asserts no bare denial. -/
def meets (std : Standard) (d : Dissent α) : Bool :=
  !d.assertsDenial &&
    d.position.assertedAtoms.all fun a => std.admits (d.position.cite a).warrant

/-- **The dissent is credible under a standard**: consistent; it denies the
claim; it grants the grounds; it argues the denial by a step of its own; and its
grounds meet the standard. -/
structure Credible (std : Standard) (d : Dissent α) : Prop where
  /-- Its premises have a model. -/
  consistent : Satisfiable d.position.premises
  /-- It denies the claim. -/
  denies : ¬ Satisfiable (d.position.premises ++ [d.claim])
  /-- It can be held with the step's grounds. -/
  grants : Satisfiable (d.position.premises ++ d.grounds)
  /-- What it asserts outright does not already deny the claim. -/
  argued : Satisfiable (d.asserted ++ [d.claim])
  /-- Its grounds meet the standard. -/
  meetsStandard : d.meets std = true

section Decide

variable [DecidableEq α]

/-- **Credibility, decided** by the engine; `none` when a check is undecided. -/
def credible? (std : Standard) (d : Dissent α) : Option Bool := do
  let c ← satisfiable? d.position.premises
  let n ← satisfiable? (d.position.premises ++ [d.claim])
  let g ← satisfiable? (d.position.premises ++ d.grounds)
  let a ← satisfiable? (d.asserted ++ [d.claim])
  pure (c && !n && g && a && d.meets std)

/-- What failed, when a dissent is not credible: each check by name, `true` where
it holds. -/
def checks? (std : Standard) (d : Dissent α) :
    Option (Bool × Bool × Bool × Bool × Bool) := do
  let c ← satisfiable? d.position.premises
  let n ← satisfiable? (d.position.premises ++ [d.claim])
  let g ← satisfiable? (d.position.premises ++ d.grounds)
  let a ← satisfiable? (d.asserted ++ [d.claim])
  pure (c, !n, g, a, d.meets std)

/-- **A dissent the engine finds credible is credible.** -/
theorem credible_of_check {std : Standard} {d : Dissent α}
    (h : credible? std d = some true) : Credible std d := by
  simp only [credible?, Option.bind_eq_bind, Option.bind_eq_some_iff, Option.pure_def,
    Option.some.injEq] at h
  obtain ⟨c, hc, n, hn, g, hg, a, ha, h⟩ := h
  simp only [Bool.and_eq_true, Bool.not_eq_true'] at h
  obtain ⟨⟨⟨⟨rfl, rfl⟩, rfl⟩, rfl⟩, hm⟩ := h
  exact ⟨satisfiable_of_satisfiable? hc, not_satisfiable_of_satisfiable? hn,
    satisfiable_of_satisfiable? hg, satisfiable_of_satisfiable? ha, hm⟩

/-- **An argued dissent is not a bare assertion**, and the engine can show that
a dissent is one: what it asserts outright already denies the claim. -/
theorem not_argued_of_check {d : Dissent α}
    (h : satisfiable? (d.asserted ++ [d.claim]) = some false) :
    ¬ Satisfiable (d.asserted ++ [d.claim]) :=
  not_satisfiable_of_satisfiable? h

end Decide

end Dissent

/-- **A rating, computed**: `disputed` when some dissent in the register is
credible under the standard; otherwise the rating the claim's support is cited
at. -/
def computedRating [DecidableEq α] (support : Confidence) (std : Standard)
    (register : List (Dissent α)) : Confidence :=
  if register.any (fun d => Dissent.credible? std d == some true) then .disputed else support

end Testimony.Logic
