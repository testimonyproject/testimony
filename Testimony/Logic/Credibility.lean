import Testimony.Logic.Warrant
import Testimony.Logic.Horn
import Testimony.Logic.Page
import Testimony.Logic.Dispute

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

## One assessment, every standard

An `Assessment` runs the checks once and records what they find under every
standard (`Findings`), with the kernel's check that the engine finds it. Whether
the dissent is credible under a standard is then read off the findings, and
`Assessment.credible_iff` says the reading is exact: credible as assessed if and
only if `Credible`. A page renders the findings as what kind of dissent it is — a
critique, a disagreement, a dissent from a ground — and, under each standard,
which of its claims the standard does not admit.

## Ratings, computed

A `RatedStep` is a step with its register: every dissent encoded against it,
and which is the strongest known. Its rating under a standard (`Computed`) is:

- **disputed**, by every dissent credible under the standard;
- otherwise **the support stands**, at the confidence its citation gives it — but
  only if the strongest known dissent is encoded (the steelman rule);
- otherwise **withheld**, and weighed as `disputed`, because nothing licenses a
  higher rating.

`RatedStep.ratings` computes it under every standard at once, so one theorem
states a step's rating under each, and a reader who prefers one standard can
read the rating that standard gives.

## Hearings under a standard

A `Register` attaches the assessments to a dispute's parties and the rated steps
to its citations. The hearing under a standard (`Register.hearing`) hears every
party that is not a dissent and every dissent credible under the standard, and
weighs each rated step at its computed rating there. So the dissents heard and
the ratings weighed come from one register, under one standard, and a verdict
and a rating cannot disagree about which standard they assume.

## What is still judgement

- **The support rating**, the breadth of the evidence for the claim, is still
  cited. What is computed is only whether a dissent brings it down.
- **The register.** A rating computed from the dissents that are encoded is only
  as good as the dissents encoded, and which is the strongest known is a cited
  judgement.

Phase one does not ask whether a credible dissent survives the full dispute: a
dispute outside a hearing still weighs cited ratings. The design note describes
phase two, which weighs computed ratings everywhere, and phase three, which makes
survival part of the rating without a circle.
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

namespace Standard

/-- Every standard, in the order a page reports them. -/
def all : List Standard := [.evidence, .tradition]

/-- No standard is left out. -/
theorem mem_all (s : Standard) : s ∈ all := by cases s <;> decide

/-- Whether a standard admits a warrant. Neither admits the library's own bare
assertion. -/
def admits : Standard → Warrant → Bool
  | .evidence, w => w == .scripture || w == .evidence
  | .tradition, w => w != .assertion

/-- The standard's name, as a page shows it. -/
def name : Standard → String
  | .evidence => "evidence"
  | .tradition => "tradition"

end Standard

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

/-- The claims the position asserts whose warrant the standard does not admit:
the grounds it rests on someone's word alone, under a standard that asks for
more. -/
def unadmitted (std : Standard) (d : Dissent α) : List α :=
  d.position.assertedAtoms.filter fun a => !std.admits (d.position.cite a).warrant

/-- Whether every claim the position asserts rests on what the standard admits,
and it asserts no bare denial. -/
def meets (std : Standard) (d : Dissent α) : Bool :=
  !d.assertsDenial && (d.unadmitted std).isEmpty

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

end Dissent

/-- **What the checks find of a dissent**, under every standard at once. The
first five do not depend on the standard; what does is which asserted claims
the standard leaves unadmitted. -/
structure Findings (α : Type) where
  /-- Its premises have a model. -/
  consistent : Bool
  /-- It denies the claim. -/
  denies : Bool
  /-- It can be held with the step's grounds. -/
  grants : Bool
  /-- What it asserts outright does not already deny the claim. -/
  argued : Bool
  /-- It holds a bare denial as a premise. -/
  bareDenial : Bool
  /-- Under each standard, the asserted claims it does not admit. -/
  unadmitted : List (Standard × List α)
deriving DecidableEq, Repr

/-- What kind of dissent the checks find, before any standard is applied. -/
inductive Findings.Kind
  /-- Its premises contradict one another. -/
  | inconsistent
  /-- It does not deny the claim. -/
  | offTarget
  /-- It denies one of the step's grounds: a dissent from that ground instead. -/
  | deniesGrounds
  /-- It holds the denial, or a bare denial, as a premise: a disagreement. -/
  | asserted
  /-- It argues the denial by a step of its own: a critique. -/
  | argued
deriving DecidableEq, Repr

namespace Findings

/-- What kind of dissent it is. -/
def kind (f : Findings α) : Kind :=
  if !f.consistent then .inconsistent
  else if !f.denies then .offTarget
  else if !f.grants then .deniesGrounds
  else if !f.argued || f.bareDenial then .asserted
  else .argued

/-- The asserted claims a standard does not admit. -/
def unadmittedUnder (f : Findings α) (s : Standard) : List α :=
  (f.unadmitted.lookup s).getD []

/-- Whether the dissent is credible under a standard. -/
def credible (f : Findings α) (s : Standard) : Bool :=
  f.consistent && f.denies && f.grants && f.argued && !f.bareDenial &&
    (f.unadmittedUnder s).isEmpty

end Findings

namespace Dissent

section Decide

variable [DecidableEq α]

/-- **The checks, run** by the engine under every standard; `none` when a check
is undecided. -/
def findings? (d : Dissent α) : Option (Findings α) := do
  let c ← satisfiable? d.position.premises
  let n ← satisfiable? (d.position.premises ++ [d.claim])
  let g ← satisfiable? (d.position.premises ++ d.grounds)
  let a ← satisfiable? (d.asserted ++ [d.claim])
  pure { consistent := c, denies := !n, grants := g, argued := a
       , bareDenial := d.assertsDenial
       , unadmitted := Standard.all.map fun s => (s, d.unadmitted s) }

omit [DecidableEq α] in
private theorem unadmittedUnder_eq (d : Dissent α) (c n g a : Bool) (s : Standard) :
    Findings.unadmittedUnder
      { consistent := c, denies := !n, grants := g, argued := a, bareDenial := d.assertsDenial
      , unadmitted := Standard.all.map fun s => (s, d.unadmitted s) } s = d.unadmitted s := by
  cases s <;> rfl

/-- **What the engine finds credible is credible.** -/
theorem credible_of_findings {d : Dissent α} {f : Findings α} {s : Standard}
    (hf : d.findings? = some f) (h : f.credible s = true) : Credible s d := by
  simp only [findings?, Option.bind_eq_bind, Option.bind_eq_some_iff, Option.pure_def,
    Option.some.injEq] at hf
  obtain ⟨c, hc, n, hn, g, hg, a, ha, rfl⟩ := hf
  simp only [Findings.credible] at h
  rw [unadmittedUnder_eq] at h
  simp only [Bool.and_eq_true, Bool.not_eq_eq_eq_not, Bool.not_true] at h
  obtain ⟨⟨⟨⟨⟨rfl, rfl⟩, rfl⟩, rfl⟩, hb⟩, hu⟩ := h
  exact ⟨satisfiable_of_satisfiable? hc, not_satisfiable_of_satisfiable? hn,
    satisfiable_of_satisfiable? hg, satisfiable_of_satisfiable? ha,
    by simp [meets, hb, hu]⟩

/-- **What the engine finds not credible is not credible.** -/
theorem not_credible_of_findings {d : Dissent α} {f : Findings α} {s : Standard}
    (hf : d.findings? = some f) (h : f.credible s = false) : ¬ Credible s d := by
  intro hC
  simp only [findings?, Option.bind_eq_bind, Option.bind_eq_some_iff, Option.pure_def,
    Option.some.injEq] at hf
  obtain ⟨c, hc, n, hn, g, hg, a, ha, rfl⟩ := hf
  have hc' : c = true := by
    cases c
    · exact absurd hC.consistent (not_satisfiable_of_satisfiable? hc)
    · rfl
  have hn' : n = false := by
    cases n
    · rfl
    · exact absurd (satisfiable_of_satisfiable? hn) hC.denies
  have hg' : g = true := by
    cases g
    · exact absurd hC.grants (not_satisfiable_of_satisfiable? hg)
    · rfl
  have ha' : a = true := by
    cases a
    · exact absurd hC.argued (not_satisfiable_of_satisfiable? ha)
    · rfl
  have hm := hC.meetsStandard
  simp only [meets, Bool.and_eq_true, Bool.not_eq_true'] at hm
  subst hc' hn' hg' ha'
  simp only [Findings.credible] at h
  rw [unadmittedUnder_eq] at h
  simp [hm.1, hm.2] at h

end Decide

end Dissent

/-- **A dissent, assessed** under every standard at once: who dissents, from
what, and what the checks find, with the kernel's check that they find it. One
declaration answers, for every standard, whether the dissent is a critique. -/
structure Assessment (α : Type) [DecidableEq α] where
  /-- Who dissents, as a page names them. -/
  dissenter : String
  /-- What they dissent from, as a page names it. -/
  against : String
  /-- The dissent. -/
  dissent : Dissent α
  /-- What the checks find. -/
  findings : Findings α
  /-- The engine finds it. -/
  checked : dissent.findings? = some findings

namespace Assessment

variable [DecidableEq α]

/-- Whether the dissent is credible under a standard. -/
def credible (a : Assessment α) (s : Standard) : Bool := a.findings.credible s

/-- Whether the dissent is credible, under each standard in turn. -/
def profile (a : Assessment α) : List (Standard × Bool) :=
  Standard.all.map fun s => (s, a.credible s)

/-- **Credible as assessed means credible.** -/
theorem sound (a : Assessment α) {s : Standard} (h : a.credible s = true) :
    Dissent.Credible s a.dissent :=
  Dissent.credible_of_findings a.checked h

/-- **Not credible as assessed means not credible.** -/
theorem complete (a : Assessment α) {s : Standard} (h : a.credible s = false) :
    ¬ Dissent.Credible s a.dissent :=
  Dissent.not_credible_of_findings a.checked h

/-- **Credible as assessed, exactly.** -/
theorem credible_iff (a : Assessment α) (s : Standard) :
    Dissent.Credible s a.dissent ↔ a.credible s = true := by
  constructor
  · intro h
    cases hc : a.credible s
    · exact absurd h (a.complete hc)
    · rfl
  · exact a.sound

/-- The assessment, in words, as a page shows it. -/
def view (a : Assessment α) : Page.Assessed where
  dissenter := a.dissenter
  against := a.against
  critique := a.findings.kind == .argued
  kind := match a.findings.kind with
    | .inconsistent => "Not a critique: its premises contradict one another."
    | .offTarget => "Not a critique of this step: it does not deny what the step concludes."
    | .deniesGrounds =>
      "A dissent from the step's grounds, not from the step: it denies one of them."
    | .asserted =>
      if a.findings.bareDenial then
        "A disagreement, not a critique: it holds a bare denial as a premise, " ++
          "and that is all that denies the step."
      else
        "A disagreement, not a critique: what it asserts outright already " ++
          "contradicts the step's conclusion, so no step of its own argues it."
    | .argued =>
      "A critique: it can be held with the step's grounds, and it argues its " ++
        "denial by a step of its own."
  standards := Standard.all.map fun s =>
    (s.name, a.credible s,
      (a.findings.unadmittedUnder s).map fun x => (a.dissent.position.cite x).label)

end Assessment

/-- **A step's rating, computed** under one standard. -/
inductive Computed
  /-- Disputed: these dissenters' critiques are credible under the standard. -/
  | disputedBy (dissenters : List String)
  /-- Withheld: no dissent is credible, but the strongest known dissent is not
  encoded, so nothing licenses a rating above `disputed`. -/
  | withheld
  /-- The step's support stands: every encoded dissent fails, the strongest known
  among them. -/
  | stands (c : Confidence)
deriving DecidableEq, Repr

/-- The confidence a computed rating gives the step: a withheld rating is
`disputed`, the floor, until the steelman is encoded. -/
def Computed.confidence : Computed → Confidence
  | .stands c => c
  | _ => .disputed

/-- **A step, rated by its register**: the step, the citation that rates its
support, every dissent encoded against it, and which of them is the strongest
known — the steelman, without which no rating above `disputed` is licensed. -/
structure RatedStep (α : Type) [DecidableEq α] where
  /-- The step, as a page names it. -/
  step : String
  /-- The citation for the step, whose confidence rates its support. -/
  support : Source
  /-- Every dissent encoded against it. -/
  register : List (Assessment α)
  /-- The strongest known dissent, by its index in `register`; `none` when it is
  not encoded. -/
  strongest : Option Nat := none

namespace RatedStep

variable [DecidableEq α]

/-- **The rating under one standard**: disputed by every dissent credible under
it; otherwise the support stands if the steelman is encoded, and is withheld if
not. -/
def rating (r : RatedStep α) (s : Standard) : Computed :=
  match (r.register.filter (·.credible s)).map (·.dissenter) with
  | [] => if r.strongest.isSome then .stands r.support.confidence else .withheld
  | ds => .disputedBy ds

/-- **The ratings under every standard**, in the order a page reports them. -/
def ratings (r : RatedStep α) : List (Standard × Computed) :=
  Standard.all.map fun s => (s, r.rating s)

/-- The strongest known dissent, if encoded. -/
def steelman (r : RatedStep α) : Option (Assessment α) :=
  r.strongest.bind (r.register[·]?)

/-- The step's ratings, in words, as a page shows them. -/
def view (r : RatedStep α) : Page.Rated where
  step := r.step
  support := r.support
  register := r.register.map (·.dissenter)
  steelman := r.steelman.map (·.dissenter)
  ratings := r.ratings.map fun (s, c) =>
    (s.name, c.confidence, match c with
      | .disputedBy ds => "a credible critique: " ++ String.intercalate "; " ds
      | .withheld =>
        "no encoded dissent is credible, but the strongest known is not encoded, " ++
          "so nothing licenses a higher rating"
      | .stands _ =>
        "every encoded dissent fails a check, the strongest known among them, " ++
          "so the step's support stands")

end RatedStep

/-! ### Hearings under a standard -/

namespace ArgumentPackage

/-- The package with each cited inference re-rated by `f`. Its premises and
conclusion are untouched, so it holds and delivers what it did. -/
def rerate (pkg : ArgumentPackage α) (f : Source → Source) : ArgumentPackage α :=
  { pkg with inferences := pkg.inferences.map f }

end ArgumentPackage

namespace RatedStep

variable [DecidableEq α]

/-- **A citation, re-rated under a standard**: a rated step's support carries the
step's computed rating under the standard; any other citation is unchanged. -/
def rerate (steps : List (RatedStep α)) (s : Standard) (src : Source) : Source :=
  match steps.find? (·.support == src) with
  | some r => { src with confidence := (r.rating s).confidence }
  | none => src

end RatedStep

variable {ι : Type}

namespace Dispute

/-- The dispute with every node's inferences re-rated by `f`: the same parties,
the same premises, weighed at different ratings. -/
def rerate (D : Dispute α ι) (f : Source → Source) : Dispute α ι where
  node i := (D.node i).rerate f
  consistent i := D.consistent i
  sound i := D.sound i
  rated i := by simpa [ArgumentPackage.rerate] using D.rated i

end Dispute

/-- **A register for a dispute**: the assessment of each party entered as a
dissent from one of the dispute's steps, each assessing the party's own
position; and the steps those dissents are rated against. Parties with no
assessment are not dissents from a rated step. -/
structure Register [DecidableEq α] (D : Dispute α ι) where
  /-- The assessment of each dissenting party. -/
  assessmentOf : ι → Option (Assessment α)
  /-- Each assesses the party's own position. -/
  ownPosition : ∀ i a, assessmentOf i = some a → a.dissent.position = D.node i
  /-- The steps the dissents are against, each with its register. -/
  steps : List (RatedStep α)

namespace Register

variable [DecidableEq α] {D : Dispute α ι}

/-- Whether a party is heard under a standard: it dissents credibly, or it is
not a dissent at all. -/
def admits (R : Register D) (s : Standard) (i : ι) : Prop :=
  (R.assessmentOf i).all (·.credible s) = true

instance (R : Register D) (s : Standard) : DecidablePred (R.admits s) :=
  fun _ => inferInstanceAs (Decidable (_ = true))

/-- The dispute weighed at the standard's ratings: every rated step's support
at the step's computed rating under the standard. -/
def rerated (R : Register D) (s : Standard) : Dispute α ι :=
  D.rerate (RatedStep.rerate R.steps s)

/-- **The hearing under a standard**: the dispute among the parties it admits,
each rated step weighed at its computed rating under the standard. A dissent
that is a disagreement, or rests on what the standard does not admit, is not
heard; a step that a credible dissent disputes is weighed as `disputed`. So the
ratings the hearing weighs and the dissents it hears come from one register,
under one standard. -/
def hearing (R : Register D) (s : Standard) : Dispute α {i // R.admits s i} :=
  (R.rerated s).restrict (R.admits s)

/-- **Every dissent heard is a credible critique** under the hearing's standard. -/
theorem heard_credible (R : Register D) (s : Standard) (i : {i // R.admits s i})
    (a : Assessment α) (h : R.assessmentOf i.1 = some a) :
    Dissent.Credible s a.dissent ∧ a.dissent.position = D.node i.1 := by
  have hi := i.2
  simp only [admits, h, Option.all_some] at hi
  exact ⟨a.sound hi, R.ownPosition i.1 a h⟩

end Register

end Testimony.Logic
