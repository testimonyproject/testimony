import Testimony.Logic.Line
import Mathlib.Tactic.Tauto

/-!
# Testimony.Logic.Tactic — `establish` and `refute_with`

Two tactics, replacing a recipe that was copied into every result in the
library.

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
```

The bracketed list names the definitions to unfold — the package, the lines of
reason it is built from, the inference steps. Everything generic is supplied by
the tactic: `caseOf`, `conjOf`, `p`, `notP`, the list-membership lemmas that
turn `∀ φ ∈ prems` into a conjunction, and the semantics.

`refute_with` takes an **identifier**, not a term, so the countermodel has to be
a named definition. That is deliberate. The style guide asks for countermodels
named after the position they encode, because a countermodel *is* the rival's
reading written down; an inline valuation would satisfy the checker and tell a
reader nothing.
-/

namespace Testimony.Logic

open Lean.Parser.Tactic

/-- Prove `Establishes pkg`: introduce the valuation, unfold the package and
the semantics, and close the goal with `tauto`.

The bracketed arguments are the definitions to unfold — the package, its lines
of reason, its inference steps, any shared premise list. The generic half of
the recipe is supplied here rather than at the call site: the argument
vocabulary that has to be unfolded to reach a premise list, the list lemmas
that turn `∀ φ ∈ premises` into a conjunction `tauto` can work on, and
Foundation's semantics under its full name.

The brackets take at least one lemma, or are omitted entirely; an empty
`[]` is a parse error rather than a tactic that quietly does nothing. An
argument always has a package to unfold, so the bare form is for the
hand-worked entailments in the sanity checks below. -/
syntax "establish" (ppSpace "[" simpLemma,+ "]")? : tactic

macro_rules
  -- The bare form routes through the bracketed one with a lemma that is
  -- already in the fixed set, so the recipe below stays written down once.
  | `(tactic| establish) => `(tactic| establish [Testimony.Logic.caseOf])
  | `(tactic| establish [$ls,*]) =>
    `(tactic|
        (intro w hw;
         simp only [$ls,*, Testimony.Logic.caseOf, Testimony.Logic.Line.asPackage,
           Testimony.Logic.Line.premises, Testimony.Logic.conjOf,
           Testimony.Logic.p, Testimony.Logic.notP,
           List.flatMap_cons, List.flatMap_nil, List.map_cons, List.map_nil,
           List.cons_append, List.nil_append, List.append_nil,
           List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
           FFL.Propositional.Formula.Boolean.val] at hw ⊢;
         tauto))

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
             Testimony.Logic.Line.premises, Testimony.Logic.conjOf,
             Testimony.Logic.p, Testimony.Logic.notP,
             List.flatMap_cons, List.flatMap_nil, List.map_cons, List.map_nil,
             List.cons_append, List.nil_append, List.append_nil,
             List.mem_cons, List.not_mem_nil, or_false, forall_eq_or_imp, forall_eq,
             FFL.Propositional.Formula.Boolean.val]))

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
    Entails (α := Pair) [p .p, .imp (p .p) (p .q)] (p .q) := by
  establish

/-- `establish` handles negated atoms too: modus tollens, with `notP` on both
sides. -/
theorem establish_proves_modus_tollens :
    Entails (α := Pair) [notP .q, .imp (p .p) (p .q)] (notP .p) := by
  establish

/-- The reading on which `q` holds and `p` does not. -/
def affirmingConsequentReading : Valuation Pair := fun a => a = Pair.q

/-- `refute_with` refutes an invalid one: affirming the consequent. -/
theorem refute_with_refutes_affirming_the_consequent :
    ¬ Entails (α := Pair) [p .q, .imp (p .p) (p .q)] (p .p) := by
  refute_with affirmingConsequentReading

end Testimony.Logic
