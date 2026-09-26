import Testimony.Logic.Support
import Testimony.Logic.Solver

/-!
# Testimony.Logic.Map — a dispute drawn: who defeats whom, and who stands with whom

An `ArgumentMap D` is a dispute's graph as one checked declaration: the defeat
table the solver computes with, and the support and part-of tables
(`Testimony.Logic.Support`), each proved equal to the relation it tabulates. Its
page renders the graph twice — drawn, and as a table of edges — from the same data.

## Attacks through support

Support carries attacks along it. In bipolar argumentation (Cayrol and
Lagasquie-Schiex):

- a **supported attack**: `a` supports `b`, and `b` defeats `c` — so `a` lends
  `c`'s defeater a premise;
- a **secondary attack**: `a` defeats `b`, and `b` supports `c` — so `a` strikes
  at something `c` was lent.

Both are derived here and proved (`supportedAttack_iff`, `secondaryAttack_iff`).

## One case inside another

When one party's case is **part of** another's (`Testimony.Logic.Support`),
whatever defeats the part is aimed at the whole: an **attack on a part**
(`partAttack_iff`). It too is reported and marked. One that is not already a
defeat of the whole is worth reading closely: the whole holds more than the
part, and the preference may weigh the same attack differently against it.
They are **reported alongside the defeats, not added to them**: every verdict is
computed from the defeats alone. Each derived attack is marked by whether it is
already a defeat, so the two relations can be read against each other; one that
is not is a question the dispute leaves open, not an answer it gives. A pair in
which one party both supports and defeats the other is marked too: such a
position lends the other a premise while undermining it.
-/

namespace Testimony.Logic

open Solver

variable {α ι : Type} [DecidableEq ι]

/-- **A dispute's graph**: its defeat, support and part-of tables, each checked
against the relation. -/
structure ArgumentMap (D : Dispute α ι) where
  /-- The dispute as the solver computes with it: the parties and the defeats. -/
  finite : Finite D.defeats
  /-- Who supports whom, computed. -/
  supports : ι → ι → Bool
  /-- The computation agrees with the relation. -/
  supports_spec : ∀ i j, D.supports i j ↔ supports i j = true
  /-- Which party's case is part of which, computed. -/
  partOf : ι → ι → Bool
  /-- The computation agrees with the relation. -/
  partOf_spec : ∀ i j, D.partOf i j ↔ partOf i j = true

namespace ArgumentMap

variable {D : Dispute α ι} (m : ArgumentMap D)

/-- A supported attack: `i` supports a party that defeats `k`. -/
def supportedAttack (i k : ι) : Bool :=
  m.finite.parties.any fun j => m.supports i j && m.finite.defeats j k

/-- A secondary attack: `i` defeats a party that supports `k`. -/
def secondaryAttack (i k : ι) : Bool :=
  m.finite.parties.any fun j => m.finite.defeats i j && m.supports j k

/-- An attack on a part: `i` defeats a party whose case is part of `k`'s. -/
def partAttack (i k : ι) : Bool :=
  m.finite.parties.any fun j => j != k && m.finite.defeats i j && m.partOf j k

variable {m}

theorem partAttack_iff {i k : ι} :
    m.partAttack i k = true ↔ ∃ j, j ≠ k ∧ D.defeats i j ∧ D.partOf j k := by
  simp only [partAttack, List.any_eq_true, Bool.and_eq_true, m.partOf_spec, m.finite.spec,
    bne_iff_ne, ne_eq]
  exact ⟨fun ⟨j, _, h⟩ => ⟨j, h.1.1, h.1.2, h.2⟩,
    fun ⟨j, h⟩ => ⟨j, m.finite.complete j, ⟨h.1, h.2.1⟩, h.2.2⟩⟩

omit [DecidableEq ι] in
theorem supportedAttack_iff {i k : ι} :
    m.supportedAttack i k = true ↔ ∃ j, D.supports i j ∧ D.defeats j k := by
  simp only [supportedAttack, List.any_eq_true, Bool.and_eq_true, m.supports_spec,
    m.finite.spec]
  exact ⟨fun ⟨j, _, h⟩ => ⟨j, h⟩, fun ⟨j, h⟩ => ⟨j, m.finite.complete j, h⟩⟩

omit [DecidableEq ι] in
theorem secondaryAttack_iff {i k : ι} :
    m.secondaryAttack i k = true ↔ ∃ j, D.defeats i j ∧ D.supports j k := by
  simp only [secondaryAttack, List.any_eq_true, Bool.and_eq_true, m.supports_spec,
    m.finite.spec]
  exact ⟨fun ⟨j, _, h⟩ => ⟨j, h⟩, fun ⟨j, h⟩ => ⟨j, m.finite.complete j, h⟩⟩

variable (m)

/-- What a page renders: the parties, numbered in the solver's order, and every
edge — defeats, supports, and the attacks derived through support, each marked
by whether it is already a defeat. -/
def view : Page.Graph :=
  let ps := m.finite.parties
  let idx := fun (i : ι) => ps.idxOf i
  let pairs := ps.flatMap fun i => ps.map (i, ·)
  let edges (keep : ι → ι → Bool) (kind : ι → ι → Page.EdgeKind) :
      List (ℕ × ℕ × Page.EdgeKind) :=
    (pairs.filter fun (i, k) => keep i k).map fun (i, k) => (idx i, idx k, kind i k)
  { nodes := ps.map fun i => (D.node i).name
    edges :=
      edges m.finite.defeats (fun _ _ => .defeat) ++
      edges m.supports (fun i k => .support (m.finite.defeats i k)) ++
      edges (fun i k => i != k && m.supportedAttack i k)
        (fun i k => .supportedAttack (m.finite.defeats i k)) ++
      edges (fun i k => i != k && m.secondaryAttack i k)
        (fun i k => .secondaryAttack (m.finite.defeats i k)) ++
      edges (fun i k => i != k && m.partOf i k) (fun _ _ => .partOf) ++
      edges (fun i k => i != k && m.partAttack i k)
        (fun i k => .partAttack (m.finite.defeats i k)) }

end ArgumentMap

end Testimony.Logic
