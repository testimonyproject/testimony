import Testimony.Logic.Witness
import Testimony.Logic.Dispute
import Testimony.Logic.Page

/-!
# Testimony.Logic.Verdict — a verdict, its witness, and the words for it

`Testimony.Logic.Witness` checks a verdict's reason. It leaves the reason's
*words* to a docstring, and nothing ties the two together: a docstring can say
Luke answers the apocalyptic reading while the witness names Acts, and every
check passes.

A `Verdict` closes that gap. It is one declaration holding a dispute's verdict
and its witness, checked once, and it is what the page renders: the claim and
its reasons are generated from the witness itself (`Claim.explain`), each defeat
named by the two parties' packages. Change the witness and the page changes;
`argdoc --check` then fails until it is regenerated. The docstring introduces
the verdict. The generated list is what the verdict claims.

- `Claim` is what a verdict says, with the witness that shows it.
- `Claim.check` runs the matching checker from `Testimony.Logic.Witness`, and
  `Claim.holds_of_check` turns a successful check into the statement
  `Testimony.Logic.Framework` makes.
- `Verdict D` pairs a claim with the dispute's solver form and the check,
  so `Verdict.holds` states the verdict for `D`.
- `Verdict.view` is what a page shows.

The explanation is generated, not proved: it reads the same data the checker
reads, so it cannot name a defeat the table lacks without the check failing. It
does not add anything the checker did not confirm.

## What a verdict rests on

`Verdict.cells` lists every cell of the defeat table the reasons state — the
defeats they name, and the absences of defeat that "nothing defeats *c*" and
"every answer to *c*" quantify over. `Verdict.view` lists every party those
cells involve at its weakest link, with the citations that rate it: the readings
a reader would have to contest to contest the verdict.

**Stated, not proved: sufficiency.** The cells follow the checker's own walk,
so the verdict should hold of any defeat table that agrees with this one on
them. That is not yet a theorem: proving it needs each checker restated so that
what it reads is recorded, and the soundness proofs redone over that record.
Until then, the list is what the reasons say they use.

**Not claimed: necessity.** Deny one of these readings and the verdict may
still stand, by another route the witness did not take.
-/

namespace Testimony.Logic

open Framework Solver Witness

variable {ι : Type} [DecidableEq ι]

/-- What a verdict says, with the witness that shows it. -/
inductive Claim (ι : Type)
  /-- Nothing is grounded: the table names a defeater for every party. -/
  | nothingGrounded (t : Table ι)
  /-- The parties of these stages are grounded. -/
  | grounded (sts : List (List ι))
  /-- The grounded extension is exactly the parties of these stages; the table
  names, for each party outside, an attacker they leave unanswered. -/
  | groundedExactly (sts : List (List ι)) (t : Table ι)
  /-- No admissible set holds `b`, by the strategy in the table. -/
  | indefensible (b : ι) (t : Table ι)
  /-- Every preferred extension holds `a`; the table shows each rival cannot be
  defended. -/
  | skeptical (a : ι) (t : Table ι)
  /-- Some preferred extension leaves `a` out: `s` is admissible and holds `x`,
  which conflicts with `a`. -/
  | notSkeptical (a x : ι) (s : List ι)
  /-- Some preferred extension holds `a`: `s` is admissible and holds it. -/
  | credulous (a : ι) (s : List ι)
  /-- `s` is a preferred extension. -/
  | preferred (s : List ι)

namespace Claim

variable {R : ι → ι → Prop}

/-- Run the claim's checker. -/
def check (F : Finite R) : Claim ι → Bool
  | .nothingGrounded t => groundedEmpty? F t
  | .grounded sts => stages? F sts
  | .groundedExactly sts t => groundedExactly? F sts t
  | .indefensible b t => indefensible? F t b
  | .skeptical a t => skeptical? F t a
  | .notSkeptical a x s => notSkeptical? F s x a
  | .credulous a s => credulous? F s a
  | .preferred s => blocked? F s

/-- What the claim states, in the terms of `Testimony.Logic.Framework`. -/
def Holds (R : ι → ι → Prop) : Claim ι → Prop
  | .nothingGrounded _ => Framework.grounded R = ∅
  | .grounded sts => ∀ x ∈ sts.flatten, x ∈ Framework.grounded R
  | .groundedExactly sts _ => Framework.grounded R = toSet sts.flatten
  | .indefensible b _ => ∀ S : Set ι, Admissible R S → b ∉ S
  | .skeptical a _ => SkepticallyAccepted R a
  | .notSkeptical a _ _ => ¬ SkepticallyAccepted R a
  | .credulous a _ => CredulouslyAccepted R a
  | .preferred s => Preferred R (toSet s)

/-- **A claim that checks, holds.** Each case is the soundness theorem of its
checker. -/
theorem holds_of_check {F : Finite R} : ∀ {c : Claim ι}, c.check F = true → c.Holds R
  | .nothingGrounded _, h => grounded_eq_empty h
  | .grounded _, h => fun _ hx => mem_grounded_of_stages h hx
  | .groundedExactly _ _, h => grounded_eq_of_witness h
  | .indefensible _ _, h => not_mem_admissible_of_witness h
  | .skeptical _ _, h => skeptically_accepted_of_witness h
  | .notSkeptical _ _ _, h => not_skeptically_accepted_of_witness h
  | .credulous _ _, h => credulously_accepted_of_witness h
  | .preferred _, h => preferred_of_witness h

/-! ### The words for it

Each explanation reads the witness and the solver's table, and names every
defeat it relies on. -/

section Explain

variable (F : Finite R) (name : ι → String)

open Page (Seg)

/-- The parties that defeat `x`. -/
def attackersOf (x : ι) : List ι := F.parties.filter (F.defeats · x)

/-- A party, by name. -/
def party (i : ι) : Seg := .party (name i)

/-- `a` defeats `b`. -/
def edge (a b : ι) : Seg := .defeat (name a) (name b)

/-- Parties, listed. -/
def partyList (l : List ι) : List Seg :=
  (l.map (party name)).intersperse (.text ", ")

/-- How `x` and `y` conflict: who defeats whom. -/
def conflictSegs (x y : ι) : List Seg :=
  if F.defeats x y && F.defeats y x then [edge name x y, .text ", and ", edge name y x]
  else if F.defeats x y then [edge name x y]
  else [edge name y x]

/-- Why `b` cannot be defended, following the strategy in the table, at depth
`d` of the list. `n` bounds the recursion, as it bounds the checker. -/
def whyIndefensible (t : Table ι) : ℕ → ℕ → ι → List (ℕ × List Seg)
  | 0, _, _ => []
  | n + 1, d, b => match t.lookup b with
    | none => []
    | some c =>
      let answers := attackersOf F c
      if answers.isEmpty then
        [(d, [edge name c b, .text ", and nothing defeats ", party name c, .text "."])]
      else
        (d, [edge name c b, .text ", and every answer to ", party name c, .text " fails:"]) ::
        answers.flatMap fun e =>
          if conflicts F e b then
            [(d + 1, [edge name e c, .text ", but conflicts with ", party name b, .text ": "] ++
              conflictSegs F name e b ++ [.text "."])]
          else
            (d + 1, [edge name e c, .text ", but ", party name e,
              .text " cannot itself be defended:"]) :: whyIndefensible t n (d + 2) e

/-- How a set defends each of its members: for every attack on a member, the
member of the set that answers it. -/
def whyAdmissible (s : List ι) : List (ℕ × List Seg) :=
  let lines := s.flatMap fun m => (attackersOf F m).map fun y =>
    match s.find? (F.defeats · y) with
    | some z => (1, [edge name y m, .text ", and ", edge name z y, .text "."])
    | none => (1, [edge name y m, .text ", unanswered."])
  let head := match s with
    | [m] => [party name m, .text (if lines.isEmpty then
        " does not defeat itself, and nothing attacks it."
        else " does not defeat itself, and answers each attack on it:")]
    | _ => [.text "None of "] ++ partyList name s ++
        [.text (if lines.isEmpty then " defeats another, and nothing attacks them."
          else " defeats another, and each attack on them is answered from among them:")]
  (0, head) :: lines

/-- The stages of a grounded witness: each stage's parties, and for each attack
on one of them, the party of an earlier stage that answers it. -/
def whyStages : List ι → ℕ → List (List ι) → List (ℕ × List Seg)
  | _, _, [] => []
  | acc, k, st :: rest =>
    (0, [.text ("Stage " ++ toString k ++ ": ")] ++ partyList name st ++ [.text "."]) ::
    (st.flatMap fun x =>
      let as := attackersOf F x
      if as.isEmpty then [(1, [party name x, .text " is defeated by nothing."])]
      else as.map fun y => match acc.find? (F.defeats · y) with
        | some z => (1, [edge name y x, .text ", and ", edge name z y, .text "."])
        | none => (1, [edge name y x, .text ", unanswered."])) ++
    whyStages (acc ++ st) (k + 1) rest

/-- A claim and its reasons, as generated. -/
structure Words where
  /-- What the verdict says. -/
  claim : List Seg
  /-- The reasons, each with its depth in the list. -/
  reasons : List (ℕ × List Seg)

/-- **The words for a claim**, generated from its witness. -/
def explain : Claim ι → Words
  | .nothingGrounded t =>
    { claim := [.text "Nothing prevails outright: every party is defeated by another."]
      reasons := t.map fun (x, y) => (0, [edge name y x, .text "."]) }
  | .grounded sts =>
    { claim := [.text "Grounded: "] ++ partyList name sts.flatten ++ [.text "."]
      reasons := whyStages F name [] 1 sts }
  | .groundedExactly sts t =>
    { claim := [.text "What the dispute forces is exactly "] ++ partyList name sts.flatten ++
        [.text "."]
      reasons := whyStages F name [] 1 sts ++
        (let out := F.parties.filter (· ∉ sts.flatten)
         if out.isEmpty then [] else
           (0, [.text "Nothing else is forced:"]) :: out.filterMap fun x =>
             (t.lookup x).map fun y =>
               (1, [edge name y x, .text ", and nothing forced defeats ", party name y,
                 .text "."])) }
  | .indefensible b t =>
    { claim := [party name b, .text " cannot be defended: no admissible position holds it."]
      reasons := whyIndefensible F name t (t.length + 1) 0 b }
  | .skeptical a t =>
    let as := attackersOf F a
    let rivals := F.parties.filter fun x => x != a && conflicts F x a
    { claim := [party name a, .text " is accepted on every resolution."]
      reasons :=
        (if as.isEmpty then [(0, [party name a, .text " is defeated by nothing."])] else
          (0, [party name a, .text " answers each of its attackers itself:"]) ::
          as.map fun b => (1, [edge name a b, .text "."])) ++
        (if rivals.isEmpty then [] else
          (0, [.text "No party in conflict with it can be defended:"]) ::
          rivals.flatMap fun x =>
            (1, [party name x, .text " cannot:"]) ::
              whyIndefensible F name t (t.length + 1) 2 x) }
  | .notSkeptical a x s =>
    { claim := [party name a, .text " is not accepted on every resolution."]
      reasons :=
        (0, (if s == [x] then [party name x, .text " can be held alone"]
            else [.text "A position holding "] ++ partyList name s ++
              [.text " can be held, and it holds ", party name x]) ++
          [.text "; ", party name x, .text " conflicts with ", party name a, .text ": "] ++
          conflictSegs F name x a ++ [.text "."]) ::
        whyAdmissible F name s }
  | .credulous a s =>
    { claim := [party name a, .text " is accepted on some resolution."]
      reasons := (0, [.text "A position holding "] ++ partyList name s ++
          [.text " can be held."]) :: whyAdmissible F name s }
  | .preferred s =>
    let out := F.parties.filter (· ∉ s)
    { claim := [.text "A maximal defensible position: "] ++ partyList name s ++ [.text "."]
      reasons := whyAdmissible F name s ++
        (if out.isEmpty then [] else
          (0, [.text "Nothing can be added to it:"]) :: out.filterMap fun x =>
            (s.find? (conflicts F x)).map fun y =>
              (1, [party name x, .text " conflicts with ", party name y, .text ": "] ++
                conflictSegs F name x y ++ [.text "."])) }

/-! ### What the words rest on

Every reason above states a cell of the defeat table: that one party defeats
another, or that it does not. "Nothing defeats *c*" and "every answer to *c*
fails" are statements about every party's cell against *c*. `cells` lists them,
following the same walk as `explain`. -/

/-- Every party's cell against `x`: the statement "nothing else defeats `x`",
or "these are all its attackers", reads all of them. -/
def into (x : ι) : List (ι × ι) := F.parties.map (·, x)

/-- The cells `whyIndefensible` states. -/
def cellsIndefensible (t : Table ι) : ℕ → ι → List (ι × ι)
  | 0, _ => []
  | n + 1, b => match t.lookup b with
    | none => []
    | some c => (c, b) :: into F c ++ (attackersOf F c).flatMap fun e =>
        if conflicts F e b then [(e, b), (b, e)] else cellsIndefensible t n e

/-- The cells `whyAdmissible` states: none of `s` defeats another, and every
attack on a member, with the member answering it. -/
def cellsAdmissible (s : List ι) : List (ι × ι) :=
  (s.flatMap fun a => s.map (a, ·)) ++ s.flatMap fun m =>
    into F m ++ (attackersOf F m).filterMap fun y => (s.find? (F.defeats · y)).map (·, y)

/-- The cells `whyStages` states. -/
def cellsStages : List ι → List (List ι) → List (ι × ι)
  | _, [] => []
  | acc, st :: rest =>
    (st.flatMap fun x => into F x ++ (attackersOf F x).filterMap fun y =>
      (acc.find? (F.defeats · y)).map (·, y)) ++ cellsStages (acc ++ st) rest

/-- **Every cell of the defeat table a claim's reasons state.** -/
def cells : Claim ι → List (ι × ι)
  | .nothingGrounded t => t.map fun (x, y) => (y, x)
  | .grounded sts => cellsStages F [] sts
  | .groundedExactly sts t =>
    cellsStages F [] sts ++ (F.parties.filter (· ∉ sts.flatten)).flatMap fun x =>
      match t.lookup x with
      | some y => (y, x) :: sts.flatten.map (·, y)
      | none => []
  | .indefensible b t => cellsIndefensible F t (t.length + 1) b
  | .skeptical a t =>
    (a, a) :: into F a ++ (attackersOf F a).map (a, ·) ++
      (F.parties.filter (· != a)).flatMap fun x =>
        [(x, a), (a, x)] ++
          (if conflicts F x a then cellsIndefensible F t (t.length + 1) x else [])
  | .notSkeptical a x s => (x, a) :: (a, x) :: cellsAdmissible F s
  | .credulous _ s => cellsAdmissible F s
  | .preferred s =>
    cellsAdmissible F s ++ (F.parties.filter (· ∉ s)).flatMap fun x =>
      match s.find? (conflicts F x) with
      | some y => [(x, y), (y, x)]
      | none => []

end Explain

end Claim

/-- **A verdict of a dispute**, with its witness, checked. Its page shows the
reasons generated from the witness; `Verdict.holds` states it. -/
structure Verdict {α : Type} (D : Dispute α ι) where
  /-- The dispute as the checkers compute with it. -/
  finite : Finite D.defeats
  /-- What the verdict says, and its witness. -/
  claim : Claim ι
  /-- The witness checks. -/
  checked : claim.check finite = true

namespace Verdict

variable {α : Type} {D : Dispute α ι}

/-- **The verdict holds** of the dispute. -/
theorem holds (v : Verdict D) : v.claim.Holds D.defeats := Claim.holds_of_check v.checked

/-- The cells the verdict's reasons state, each once, in the order they are
first stated. -/
def cells (v : Verdict D) : List (ι × ι) := (v.claim.cells v.finite).eraseDups

/-- The parties those cells involve, each once. -/
def involved (v : Verdict D) : List ι := (v.cells.flatMap fun (a, b) => [a, b]).eraseDups

/-- What a package holds at its weakest link: every claim cited at that rank,
every denial if the rank is the bottom, and every inference rated at it. A
denial is labelled as the package's own citation labels it, which in this
library states the claim as the party holds it. A
package with no rated premise has no weakest link. -/
def weakestLink (pkg : ArgumentPackage α) : List Page.Held :=
  let r := pkg.strength
  let claims := pkg.premises.filterMap fun φ => match φ with
    | .atom a =>
      let m := pkg.cite a
      if m.source.confidence.rank == r then some ⟨m.label, m.source.confidence, m.source⟩
      else none
    | .imp (.atom a) .falsum =>
      let m := pkg.cite a
      -- A party's own citation labels a denied atom as the party holds it, so
      -- the label is shown as written; what is added is why it ranks where it does.
      if r == 0 then some ⟨m.label ++ " (encoded as a denial, so it ranks disputed)",
        .disputed, m.source⟩ else none
    | _ => none
  let hasStep := pkg.premises.any fun φ => match φ with
    | .atom _ => false
    | .imp (.atom _) .falsum => false
    | _ => true
  let steps := if hasStep && pkg.inferenceRank == some r then
      (pkg.inferences.filter (·.confidence.rank == r)).map fun s =>
        (⟨"an inference step", s.confidence, s⟩ : Page.Held)
    else []
  claims.foldl (fun acc h => if acc.any (·.what == h.what) then acc else acc ++ [h]) [] ++ steps

/-- What a page renders: the claim and the reasons, generated from the witness,
each party named by its package; the cells of the defeat table the reasons
state; and every party they involve, at its weakest link. -/
def view (v : Verdict D) : Page.Verdict :=
  let name := fun i => (D.node i).name
  let words := v.claim.explain v.finite name
  { claim := words.claim
    reasons := words.reasons
    cells := v.cells.map fun (a, b) => (name a, name b, v.finite.defeats a b)
    readings := v.involved.map fun i => ⟨name i, weakestLink (D.node i)⟩ }

end Verdict

end Testimony.Logic
