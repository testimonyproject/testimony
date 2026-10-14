import Testimony.Logic.Horn
import Testimony.Logic.Solver

/-!
# Testimony.Logic.Aif — the library's disputes in the Argument Interchange Format

The Argument Interchange Format (AIF) is the argument community's common
ontology of argument (Chesñevar et al. 2006; the Dundee specification, 2011).
An argument is a graph of two kinds of node. **Information nodes** (I-nodes)
hold claims. **Scheme nodes** hold the reasoning between them, in three kinds:
an **RA-node** applies an inference, from premises to a conclusion; a
**CA-node** applies a conflict, from a conflicting element to a conflicted one;
a **PA-node** applies a preference, from a preferred element to a dispreferred
one. Claims are never joined directly, only through a scheme.

The library's disputes are of the kind AIF was built to carry. Each package's
premises are claims, and each of its inference steps `p ➝ ψ` carries the
conjuncts of `p` to `ψ`: an I-node for each claim, an RA-node for each step.
Each defeat is a conflict, and lands where the library says it lands: on the
conclusion it rebuts, on the premise it undermines, or on the claim a step
delivers. An attack on a step itself — undermining the formula `p ➝ ψ` — lands
on the step's RA-node, which is what AIF calls an undercutter. Each attack the
library weighs and refuses, because what is attacked outranks the attacker,
is a preference: the attacked element preferred to the attacker. So the
weakest-link weighing the library does with cited ratings is drawn, in AIF, as
the PA-nodes it leaves standing.

One simplification, stated: AIF needs a single conflicting element, and an
attack in the library comes from everything a party holds. The conflicting
element is drawn as the attacking party's conclusion — the position, by the
claim that names it.

`Graph.wellFormed` is the specification's Definition 1.1, condition by
condition, and `Testimony.Checks.Aif` checks it of every dispute in the
library.
-/

namespace Testimony.Logic.Aif

open Testimony.Logic

/-- The kinds of node in an AIF graph (Definition 1.1). -/
inductive Kind
  /-- An information node: a claim. -/
  | i
  /-- A rule application: an inference from premises to a conclusion. -/
  | ra
  /-- A conflict application: one element in conflict with another. -/
  | ca
  /-- A preference application: one element preferred to another. -/
  | pa
deriving DecidableEq, Repr

/-- The name AIF gives each kind of node. -/
def Kind.name : Kind → String
  | .i => "I"
  | .ra => "RA"
  | .ca => "CA"
  | .pa => "PA"

/-- **An AIF graph**: its nodes, numbered by position, each with its kind and its
text, and its directed edges between them. -/
structure Graph where
  /-- Each node's kind and text. A node's number is its position. -/
  nodes : List (Kind × String)
  /-- The edges, from one node's number to another's. -/
  edges : List (Nat × Nat)
deriving Repr

namespace Graph

/-- The kind of the node with this number. -/
def kind? (g : Graph) (n : Nat) : Option Kind := (g.nodes[n]?).map (·.1)

/-- The direct predecessors of a node. -/
def preds (g : Graph) (n : Nat) : List Nat := (g.edges.filter (·.2 == n)).map (·.1)

/-- The direct successors of a node. -/
def succs (g : Graph) (n : Nat) : List Nat := (g.edges.filter (·.1 == n)).map (·.2)

/-- How many nodes of a kind the graph has. -/
def count (g : Graph) (k : Kind) : Nat := (g.nodes.filter (·.1 == k)).length

/-- **Definition 1.1 of the AIF specification, condition by condition.**

1. Every node is an I-, RA-, CA- or PA-node (the type says so).
2. The graph is simple, and no edge joins two I-nodes: claims meet only through
   a scheme.
3. Every scheme node has a predecessor and a successor.
4. An RA-node has at least one premise and exactly one conclusion.
5. A PA-node has exactly one preferred and one dispreferred element, and they
   are different.
6. A CA-node has exactly one conflicting and one conflicted element. -/
def wellFormed (g : Graph) : Bool :=
  let n := g.nodes.length
  g.edges.all (fun (a, b) => a < n && b < n && a != b &&
      !(g.kind? a == some .i && g.kind? b == some .i)) &&
    g.edges.Nodup &&
    (List.range n).all fun v =>
      match g.kind? v with
      | some .ra => !(g.preds v).isEmpty && (g.succs v).length == 1
      | some .ca => (g.preds v).length == 1 && (g.succs v).length == 1
      | some .pa => (g.preds v).length == 1 && (g.succs v).length == 1 &&
          g.preds v != g.succs v
      | _ => true

end Graph

/-! The definition is not vacuous: each graph below breaks one condition. -/

-- Two claims joined with no scheme between them (condition 2).
#guard !(Graph.wellFormed ⟨[(.i, "a"), (.i, "b")], [(0, 1)]⟩)
-- An inference with two conclusions (condition 4).
#guard !(Graph.wellFormed ⟨[(.i, "a"), (.ra, ""), (.i, "b"), (.i, "c")],
  [(0, 1), (1, 2), (1, 3)]⟩)
-- A conflict with no conflicted element (conditions 3 and 6).
#guard !(Graph.wellFormed ⟨[(.i, "a"), (.ca, "")], [(0, 1)]⟩)
-- A preference of a claim over itself (condition 5).
#guard !(Graph.wellFormed ⟨[(.i, "a"), (.pa, "")], [(0, 1), (1, 0)]⟩)
-- And the simplest argument there is: one premise, one inference, one conclusion.
#guard Graph.wellFormed ⟨[(.i, "a"), (.ra, ""), (.i, "b")], [(0, 1), (1, 2)]⟩

variable {α : Type} [DecidableEq α]

/-- A claim's text, in its argument's own words: an atom by its citation's label,
a denial as "not", and the connectives by name. -/
def text (cite : α → AtomMeta) : Formula α → String
  | .atom a => (cite a).label
  | .imp p .falsum => "not: " ++ text cite p
  | .falsum => "nothing"
  | .and p q => text cite p ++ "; and " ++ text cite q
  | .or p q => text cite p ++ "; or " ++ text cite q
  | .imp p q => "if " ++ text cite p ++ ", then " ++ text cite q

/-- The conjuncts of a step's antecedent: each is a premise of its RA-node. -/
def conjuncts : Formula α → List (Formula α)
  | .and p q => conjuncts p ++ conjuncts q
  | φ => [φ]

/-- A graph under construction: its nodes and edges so far, and the I- and
RA-nodes already made, so that a claim or a step shared by two parties is one
node. -/
structure Builder (α : Type) where
  /-- The nodes so far. -/
  nodes : Array (Kind × String) := #[]
  /-- The edges so far. -/
  edges : Array (Nat × Nat) := #[]
  /-- Each claim's I-node. -/
  claims : List (Formula α × Nat) := []
  /-- Each step's RA-node. -/
  steps : List (Formula α × Nat) := []
  /-- Each conflict already drawn, by its two ends. -/
  conflicts : List (Nat × Nat) := []
  /-- Each preference already drawn, by its two ends. -/
  preferences : List (Nat × Nat) := []

/-- Add a node, and return its number. -/
def node (k : Kind) (t : String) : StateM (Builder α) Nat :=
  modifyGet fun b => (b.nodes.size, { b with nodes := b.nodes.push (k, t) })

/-- Add an edge, once. -/
def edge (a c : Nat) : StateM (Builder α) Unit :=
  modify fun b => if b.edges.contains (a, c) then b else { b with edges := b.edges.push (a, c) }

/-- A claim's I-node, made the first time it is met. -/
def claim (cite : α → AtomMeta) (φ : Formula α) : StateM (Builder α) Nat := do
  match (← get).claims.lookup φ with
  | some n => pure n
  | none =>
    let n ← node .i (text cite φ)
    modify fun b => { b with claims := (φ, n) :: b.claims }
    pure n

/-- A premise's node: an inference step's RA-node, from the conjuncts of its
antecedent to its head; any other premise, its I-node. -/
def premise (cite : α → AtomMeta) (φ : Formula α) : StateM (Builder α) Nat := do
  match Horn.stepOf? φ with
  | some (p, ψ) =>
    match (← get).steps.lookup φ with
    | some n => pure n
    | none =>
      let r ← node .ra "Default Inference"
      modify fun b => { b with steps := (φ, r) :: b.steps }
      for c in conjuncts p do
        edge (← claim cite c) r
      edge r (← claim cite ψ)
      pure r
  | none => claim cite φ

/-- A package's premises and conclusion, as nodes. -/
def package (pkg : ArgumentPackage α) : StateM (Builder α) Unit := do
  for φ in pkg.premises do
    discard <| premise pkg.cite φ
  discard <| claim pkg.cite pkg.conclusion

/-- A conflict from one node to another, drawn once. -/
def conflict (src tgt : Nat) : StateM (Builder α) Unit := do
  unless src == tgt || (← get).conflicts.contains (src, tgt) do
    let c ← node .ca "Default Conflict"
    modify fun b => { b with conflicts := (src, tgt) :: b.conflicts }
    edge src c
    edge c tgt

/-- A preference of one node over another, drawn once: a claim that is both a
party's conclusion and the head of one of its steps is weighed twice, and
preferred once. -/
def preference (pref dispref : Nat) : StateM (Builder α) Unit := do
  unless pref == dispref || (← get).preferences.contains (pref, dispref) do
    let p ← node .pa "Default Preference"
    modify fun b => { b with preferences := (pref, dispref) :: b.preferences }
    edge pref p
    edge p dispref

variable [HasPostulates α]

/-- **What one party does to another, in AIF**: a conflict for each defeat, on
the conclusion, premise or delivered claim it lands on; a preference for each
attack the weighing refuses. -/
def attacks (a b : ArgumentPackage α) : StateM (Builder α) Unit := do
  let s := a.strength
  let t := b.strength
  let src ← claim a.cite a.conclusion
  let blocked (φ : Formula α) := Horn.satisfiable? (a.held ++ [φ]) == some false
  match Horn.rebuts? a b s t with
  | some true => conflict src (← claim b.cite b.conclusion)
  | _ =>
    if s < t && blocked b.conclusion then preference (← claim b.cite b.conclusion) src
  for φ in b.premises do
    match Horn.undermines? a b s φ with
    | some true => conflict src (← premise b.cite φ)
    | _ =>
      if decide (Outranks b φ s) && blocked φ then preference (← premise b.cite φ) src
  for (_, ψ) in Horn.stepsOf b.premises do
    match Horn.stepRebuts? a b s t ψ with
    | some true => conflict src (← claim b.cite ψ)
    | _ =>
      if s < t && blocked ψ && Horn.satisfiable? (b.held ++ [∼ψ]) == some false then
        preference (← claim b.cite ψ) src

/-- **A dispute as an AIF graph**: every party's package, and what every party
does to every other. -/
def ofParties {ι : Type} (node : ι → ArgumentPackage α) (parties : List ι) : Graph :=
  let build : StateM (Builder α) Unit := do
    for i in parties do
      package (node i)
    for (i, m) in parties.zipIdx do
      for (j, n) in parties.zipIdx do
        if m != n then attacks (node i) (node j)
  let b := (build.run {}).2
  { nodes := b.nodes.toList, edges := b.edges.toList }

/-- The AIF graph of a dispute whose parties are listed. -/
def ofFinite {ι : Type} {d : Dispute α ι} (F : Solver.Finite d.defeats) : Graph :=
  ofParties d.node F.parties

end Testimony.Logic.Aif
