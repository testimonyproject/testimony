import Testimony.Logic.Line
import Mathlib.Tactic.Tauto

/-!
# Testimony.Logic.Tactic — the proof recipes

`establish`, `refute_with`, `satisfied_by`, `leaves_open` and `granted`, plus
`establish_by_search` for the rare non-Horn case. They replace a recipe that
was copied into every result in the library.

## Why this is a soundness fix and not a convenience

`Formula` is an abbreviation in `Testimony.Logic` as well as a structure in
Foundation, so inside an argument module the short name `Formula.Boolean.val`
resolves to the wrong namespace. Written out, the semantics never unfold, `simp`
leaves the hypothesis alone, and the proof term ends up resting on `sorryAx` —
with a **successful build**. Only `lake exe axiom-audit` catches it, and only
after the fact.

The old mitigation was a note in CLAUDE.md telling the author to qualify
`FFL.Propositional.Formula.Boolean.val` in full, at twenty-eight call sites.
Here it is written once. Identifiers inside a macro quotation resolve in the
namespace where the quotation was written, not where the tactic is invoked, so
an argument module cannot get it wrong — the qualified name is not at the call
site to be mistyped.

This is the move the library already makes with citations: `Source.primary` is a
required field rather than a review rule, so an uncited premise cannot be
written down. Same idea, applied to a proof.

## Usage

```lean
theorem christian_establishes : Establishes christian := by
  establish [christian, isaianicLine, genesisLine, sharedGrounds, toFulfilment]

theorem critical_not_establishes : ¬ Establishes critical := by
  refute_with criticalReading [critical, criticalExclusion, toCriterion]

theorem parity_leaves_the_canon_open :
    Independent canonUnderParity.premises (p .scriptureIsSoleInfallibleRule) := by
  leaves_open parityEstablishesNothingReading krugerParityReading
    [canonUnderParity, Line.onGrounds, canonObjectionLine, canonObjectionStep]
```

The bracketed list names the definitions to unfold — the package, the lines of
reason it is built from, the inference steps. Everything generic is supplied by
the tactic: `caseOf`, `p`, `notP`, the list-membership lemmas that turn
`∀ φ ∈ prems` into a conjunction, and Foundation's truth lemmas for the
connectives — including the one for `⋀`, the list conjunction that replaced
this library's own `conjOf`.

`refute_with` takes an **identifier**, not a term, so the countermodel has to be
a named definition, and `leaves_open` takes two for the same reason. That is
deliberate. The style guide asks for countermodels
named after the position they encode, because a countermodel *is* the rival's
reading written down; an inline valuation would satisfy the checker and tell a
reader nothing.
-/

namespace Testimony.Logic

open Lean.Parser.Tactic

/-- Close a goal whose hypotheses are Horn clauses over atoms, by backward
chaining.

**Why Horn.** After `establish` has unfolded a package, what is left is almost
always a Horn problem: facts (atoms, or negated atoms), and inference steps of
the form *conjunction of literals → atom, or conjunction of atoms*, with a
conjunction of atoms to prove. Horn entailment is decidable in linear time by
unit propagation (Dowling and Gallier, "Linear-time algorithms for testing the
satisfiability of propositional Horn formulae", *J. Logic Programming* 1(3),
1984), and backward chaining over Horn clauses is SLD resolution — Prolog's
procedure. `tauto` is neither: it is a general classical search that case-splits
on every implication in the context, so its cost is exponential in the number
of inference steps, however simple each one is. Adding a single closing step to
`SolaFide` once took `reformed_establishes` from within the default heartbeat
budget to twenty times over it.

**How.** `and_imp` curries every step (`A ∧ B → C` becomes `A → B → C`),
`imp_and` splits a conjunctive head (`A → B ∧ C` becomes `(A → B) ∧ (A → C)`),
and `not_and` does for a negated conjunction what `and_imp` does for an
implication (`¬(A ∧ B)` becomes `A → ¬B`) — the shape of a goal that rebuts a
conjunctive conclusion. So every hypothesis is a fact or a clause with one
atomic head; `casesm*` puts
each in the context separately; the goal is split into its conjuncts; and
`solve_by_elim` — SLD resolution over the context — proves each. On the
`SolaFide` packages this takes about two thousand heartbeats where `tauto` took
about four million.

**Why no fallback.** When this was written every `establish` in the library
proved on the Horn path, and a silent fallback to `tauto` would have had one
effect only: to hide the moment an encoding stopped being Horn, and got
exponentially slower. So `horn_close` fails, naming the likely cause, and a
step that genuinely cannot be Horn is proved with `establish_by_search`, where
the cost is visible at the call site. The proof term is ordinary either way,
so the trust base is unchanged. -/
syntax (name := hornClose) "horn_close" : tactic

macro_rules
  | `(tactic| horn_close) =>
    `(tactic|
        first
          | (try simp only [and_imp, imp_and, not_and] at *
             casesm* _ ∧ _
             repeat' refine ⟨?_, ?_⟩
             all_goals solve_by_elim (maxDepth := 24)
             done)
          | fail "establish: the premises are not Horn, or a definition in the chain is \
missing from the list. Check the list first; then look for a step with a \
disjunction or a nested implication, and restate it as separate lines. If it \
genuinely cannot be Horn, use `establish_by_search`, which runs `tauto`.")

/-- Prove `Establishes pkg`: introduce the valuation, unfold the package and
the semantics, and close the goal with `horn_close` — backward chaining over the
premises as Horn clauses.

The bracketed arguments are the definitions to unfold — the package, its lines
of reason, its inference steps, any shared premise list. The generic half of
the recipe is supplied here rather than at the call site: the argument
vocabulary that has to be unfolded to reach a premise list, the list lemmas
that turn `∀ φ ∈ premises` into a conjunction of Horn clauses, and
Foundation's truth lemmas for the connectives.

The first step crosses `entails_iff`. `Entails` is Foundation's consequence
relation, stated over a set of premises; every result in the library is stated
over the list. The bridge between them is a proved equivalence rather than a
definitional one: Foundation's `⊧*` is a class, so converting it to the
`∀ φ ∈ prems` form goes through `modelsSet_premiseSet_iff`.

The brackets take at least one lemma, or are omitted entirely; an empty
`[]` is a parse error rather than a tactic that quietly does nothing. An
argument always has a package to unfold, so the bare form is for the
hand-worked entailments in the sanity checks below. -/
syntax "establish" (ppSpace "[" simpLemma,+ "]")? : tactic

/-- The unfolding half of `establish`, shared with `establish_by_search` so that
the simp set is written down once. Leaves the premises as a conjunction in the
context and the conclusion as the goal. Not for use in argument modules. -/
syntax (name := establishUnfold) "establish_unfold" "[" simpLemma,+ "]" : tactic

macro_rules
  | `(tactic| establish_unfold [$ls,*]) =>
    `(tactic|
        (refine Testimony.Logic.entails_iff.mpr ?_;
         intro w hw;
         simp only [$ls,*, Testimony.Logic.caseOf, Testimony.Logic.Line.asPackage,
           Testimony.Logic.Line.premises,
           Testimony.Logic.p, Testimony.Logic.notP,
           List.flatMap_cons, List.flatMap_nil, List.map_cons, List.map_nil,
           List.cons_append, List.nil_append, List.append_nil,
           List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
           FFL.Semantics.Imp.models_imply, FFL.Semantics.And.models_and,
           FFL.Semantics.Or.models_or, FFL.Semantics.Not.models_not,
           FFL.Semantics.Top.models_verum, FFL.Semantics.Bot.models_falsum,
           FFL.Semantics.models_list_conj₂,
           FFL.Propositional.Formula.Boolean.models_atom] at hw ⊢))

macro_rules
  -- The bare form routes through the bracketed one with a lemma that is
  -- already in the fixed set, so the recipe below stays written down once.
  | `(tactic| establish) => `(tactic| establish [Testimony.Logic.caseOf])
  | `(tactic| establish [$ls,*]) =>
    `(tactic| (establish_unfold [$ls,*]; horn_close))

/-- `establish`, closed by `tauto` instead of by backward chaining: for a
package with a step that genuinely cannot be written as a Horn clause — a
disjunction in a premise, an implication inside an antecedent. `tauto`
case-splits on every implication in the context, so its cost is exponential in
the number of inference steps; using this is a statement, at the call site,
that the cost has been accepted. No result in the library needed it when it was
introduced. -/
syntax (name := establishBySearch) "establish_by_search" (ppSpace "[" simpLemma,+ "]")? : tactic

macro_rules
  | `(tactic| establish_by_search) =>
    `(tactic| establish_by_search [Testimony.Logic.caseOf])
  | `(tactic| establish_by_search [$ls,*]) =>
    `(tactic| (establish_unfold [$ls,*]; tauto))

/-- Refute `Establishes pkg` by exhibiting a named countermodel: a valuation
satisfying every premise while falsifying the conclusion.

The first argument is the valuation, which must be an identifier — see the
module docstring. The bracketed arguments are the definitions to unfold. -/
syntax "refute_with" ppSpace ident (ppSpace "[" simpLemma,+ "]")? : tactic

macro_rules
  | `(tactic| refute_with $v:ident) =>
    `(tactic| refute_with $v [Testimony.Logic.caseOf])
  | `(tactic| refute_with $v:ident [$ls,*]) =>
    `(tactic|
        (refine Testimony.Logic.not_entails_of_countermodel $v ?_ ?_ <;>
           simp [$ls,*, $v:ident, Testimony.Logic.caseOf, Testimony.Logic.Line.asPackage,
             Testimony.Logic.Line.premises,
             Testimony.Logic.p, Testimony.Logic.notP,
             List.flatMap_cons, List.flatMap_nil, List.map_cons, List.map_nil,
             List.cons_append, List.nil_append, List.append_nil,
             List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
             FFL.Semantics.Imp.models_imply, FFL.Semantics.And.models_and,
           FFL.Semantics.Or.models_or, FFL.Semantics.Not.models_not,
           FFL.Semantics.Top.models_verum, FFL.Semantics.Bot.models_falsum,
           FFL.Semantics.models_list_conj₂,
           FFL.Propositional.Formula.Boolean.models_atom]))

/-- Prove `Satisfiable prems` by naming a valuation that models every premise.

The mirror of `refute_with`: same unfolding recipe, opposite purpose. Where a
countermodel is the rival's reading written down, a model is the position's
own — the way things are if it is right. Both are named definitions for the
same reason, that an inline valuation satisfies the checker and tells a reader
nothing. -/
syntax "satisfied_by" ppSpace ident (ppSpace "[" simpLemma,+ "]")? : tactic

macro_rules
  | `(tactic| satisfied_by $v:ident) =>
    `(tactic| satisfied_by $v [Testimony.Logic.caseOf])
  | `(tactic| satisfied_by $v:ident [$ls,*]) =>
    `(tactic|
        (refine Testimony.Logic.satisfiable_of_model $v ?_ <;>
           simp [$ls,*, $v:ident, Testimony.Logic.caseOf, Testimony.Logic.Line.asPackage,
             Testimony.Logic.Line.premises,
             Testimony.Logic.p, Testimony.Logic.notP,
             List.flatMap_cons, List.flatMap_nil, List.map_cons, List.map_nil,
             List.cons_append, List.nil_append, List.append_nil,
             List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
             FFL.Semantics.Imp.models_imply, FFL.Semantics.And.models_and,
           FFL.Semantics.Or.models_or, FFL.Semantics.Not.models_not,
           FFL.Semantics.Top.models_verum, FFL.Semantics.Bot.models_falsum,
           FFL.Semantics.models_list_conj₂,
           FFL.Propositional.Formula.Boolean.models_atom]))

/-- Prove `Independent prems φ` by naming the two readings a parity reply
leaves available: one on which the proposition fails, and one on which it
holds, both satisfying every premise.

The order is the order of `Independent`'s two halves — first the reading that
refutes the proposition, then the reading that refutes its negation. Read it as
the claim the theorem makes: *these premises admit this reading, and also that
one, so they settle nothing either way.*

Two identifiers rather than one, for the same reason `refute_with` takes an
identifier at all. An independence result is two rival readings of one premise
set, and both of them are positions someone holds. -/
syntax "leaves_open" ppSpace ident ppSpace ident (ppSpace "[" simpLemma,+ "]")? : tactic

macro_rules
  | `(tactic| leaves_open $vf:ident $vt:ident) =>
    `(tactic| leaves_open $vf $vt [Testimony.Logic.caseOf])
  | `(tactic| leaves_open $vf:ident $vt:ident [$ls,*]) =>
    `(tactic|
        (refine Testimony.Logic.independent_of_countermodels $vf $vt ?_ ?_ ?_ ?_ <;>
           simp [$ls,*, $vf:ident, $vt:ident, Testimony.Logic.caseOf,
             Testimony.Logic.Line.asPackage,
             Testimony.Logic.Line.premises,
             Testimony.Logic.p, Testimony.Logic.notP,
             List.flatMap_cons, List.flatMap_nil, List.map_cons, List.map_nil,
             List.cons_append, List.nil_append, List.append_nil,
             List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
             FFL.Semantics.Imp.models_imply, FFL.Semantics.And.models_and,
           FFL.Semantics.Or.models_or, FFL.Semantics.Not.models_not,
           FFL.Semantics.Top.models_verum, FFL.Semantics.Bot.models_falsum,
           FFL.Semantics.models_list_conj₂,
           FFL.Propositional.Formula.Boolean.models_atom]))

/-- Prove `Establishes pkg` where the conclusion is one of the premises.

Not a shortcut for `establish`, which would also close such a goal — a
different claim, stated differently on purpose. `establish` says the conclusion
*follows*; this says it was *granted*, and the distinction is the whole content
of the result at the one place the library uses it. A reply that concedes the
charge it answers entails that charge, because the charge is one of its own
grounds, and searching for a proof of something sitting in the premise list
would hide exactly what is worth seeing.

Foundation's `of_mem`, reached through `entails_of_mem`. The bracketed
arguments are the definitions to unfold, as elsewhere; what has to reduce here
is the premise *list*, not the semantics, so the goal the recipe leaves is a
membership. -/
syntax "granted" (ppSpace "[" simpLemma,+ "]")? : tactic

macro_rules
  | `(tactic| granted) => `(tactic| granted [Testimony.Logic.caseOf])
  | `(tactic| granted [$ls,*]) =>
    `(tactic|
        (refine Testimony.Logic.entails_of_mem ?_;
         simp [$ls,*, Testimony.Logic.caseOf, Testimony.Logic.Line.asPackage,
           Testimony.Logic.Line.premises,
           Testimony.Logic.p, Testimony.Logic.notP,
           List.flatMap_cons, List.flatMap_nil, List.map_cons, List.map_nil,
           List.cons_append, List.nil_append, List.append_nil,
           List.mem_cons, List.not_mem_nil]))

/-! ### Sanity checks

These tactics are the library's only route to a proof about an argument, so a
small hand-worked case pins each of them here, over the two-atom `Pair` type
`Entail` defines for the same purpose. If a Lean or Mathlib upgrade breaks the
recipe, it breaks in this file rather than in the middle of an argument — and
it also exercises the no-argument forms, which the arguments never use because
they always have a package to unfold.
-/

/-- `establish` proves a valid entailment: modus ponens. -/
theorem establish_proves_modus_ponens :
    Entails (α := Pair) [p .p, p .p ➝ p .q] (p .q) := by
  establish

/-- `establish` handles negated atoms too: modus tollens, with `notP` on both
sides. -/
theorem establish_proves_modus_tollens :
    Entails (α := Pair) [notP .q, p .p ➝ p .q] (notP .p) := by
  establish

/-- The reading on which `q` holds and `p` does not. -/
def affirmingConsequentReading : Valuation Pair := fun a => a = Pair.q

/-- And `establish` does not prove it. A tactic cannot make the kernel accept a
false theorem, so this is not what keeps the library sound; it pins that the
Horn path fails, rather than proving something vacuous, on the canonical
invalid inference. The library-wide version of this check — `establish` fails
on every package the library refutes — is recorded in `docs/src/logic.md`. -/
example : True := by
  fail_if_success
    have : Entails (α := Pair) [p .q, p .p ➝ p .q] (p .p) := by establish
  trivial

/-- `refute_with` refutes an invalid one: affirming the consequent. -/
theorem refute_with_refutes_affirming_the_consequent :
    ¬ Entails (α := Pair) [p .q, p .p ➝ p .q] (p .p) := by
  refute_with affirmingConsequentReading

/-- The reading on which both atoms hold. -/
def bothHoldReading : Valuation Pair := fun _ => True

/-- `satisfied_by` proves a premise set has a model. -/
theorem satisfied_by_models_a_consistent_pair :
    Satisfiable (α := Pair) [p .p, p .p ➝ p .q] := by
  satisfied_by bothHoldReading

/-- `leaves_open` proves independence: from `q` and `p → q`, the premises
settle nothing about `p` either way. `affirmingConsequentReading` is the
reading on which `p` fails; `bothHoldReading` is the reading on which it
holds. -/
theorem leaves_open_shows_p_is_independent :
    Independent (α := Pair) [p .q, p .p ➝ p .q] (p .p) := by
  leaves_open affirmingConsequentReading bothHoldReading

/-- `granted` proves what a premise list already contains. -/
theorem granted_proves_a_premise :
    Entails (α := Pair) [p .q, p .p ➝ p .q] (p .q) := by
  granted

/-- And a contradictory premise set has none, so it entails anything — the
hazard `entails_of_unsatisfiable` names, exhibited. -/
theorem contradictory_premises_entail_anything :
    Entails (α := Pair) [p .p, notP .p] (p .q) := by
  establish

/-- `establish` refuses a case that is not Horn — reasoning by cases over a
disjunction — rather than searching, and `establish_by_search` proves it. Both
halves are pinned: if `establish` ever started accepting this, it would have
regained a hidden exponential path. -/
theorem establish_by_search_proves_cases :
    Entails (α := Pair) [p .p ⋎ p .q, p .p ➝ p .q] (p .q) := by
  fail_if_success establish
  establish_by_search

end Testimony.Logic
