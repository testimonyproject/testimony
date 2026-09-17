# Encoding arguments

> This page assumes you are writing an encoding. If you are here to *review*
> one — which is the contribution this project most needs, and needs no Lean —
> start with [Reading the logic](./reading-the-logic.md) instead.
>
> If you are writing, the [Pedagogy](./style-guide.md#pedagogy) rule applies to
> everything below: assume a reader who knows the theology and not the logic,
> and elucidate or link rather than leaving a notion to be inferred.


## How entailment is settled

An argument is a list of premises and a conclusion, both formulas over cited
atoms. Two questions get asked of it, and they are answered by different means.

**Does the conclusion follow?** Mathlib's `tauto`, a goal-directed classical
tableau. It produces an ordinary proof term, so the trust base is unchanged,
and its cost tracks the argument's structure rather than its atom count.

**Does it fail to follow?** Name a countermodel — a valuation satisfying every
premise while falsifying the conclusion:

```lean
theorem not_entails_of_countermodel
    (w : Valuation α)
    (hsat : ∀ φ ∈ prems, Formula.Boolean.val w φ)
    (hfail : ¬ Formula.Boolean.val w concl) : ¬ Entails prems concl
```

Checking a named valuation is linear. Searching for one is not, which is why
the library asks the author to supply it.

That turns out to be a feature rather than a chore. "A countermodel exists"
tells a reader nothing; a named valuation **is the rival's reading, written
down**. So countermodels here carry the rival's name — `nppReading`,
`tridentineReading`, `criticalReading` — and a reader can inspect what the
opposing position actually commits to.

### There is no atom budget

An earlier version decided entailment by exhaustive truth table, which cost
`2^n` and forced a twelve-atom cap on every argument. Both are gone. An
argument tracing a theme across the canon may use as many atoms as it needs.

### What was rejected, and why

**`bv_decide`**, Lean's SAT-solver tactic, is fast and unusable here. It emits
a per-theorem native axiom:

```
'bvtest' depends on axioms: [propext, Classical.choice, Quot.sound,
                             bvtest._native.bv_decide.ax_1_5]
```

That is an external solver's certificate entering the trust base. For a library
whose claim is that every assumption is declared, it is not a trade worth
making, and `axiom-audit` would reject it.

**Foundation's proof calculi** supply soundness and completeness metatheorems
for the Tait calculus, but no executable decision procedure, so they cannot
discharge a goal.

**A hand-rolled pruning search** was written and then deleted once `tauto`
proved to handle the same goals with less machinery and no new proof
obligations.

## Rendering an argument as logic

`lake exe argtex` writes `docs/latex/arguments.tex`: every package set the way
a logic paper would set it — a legend of numbered propositional variables with
each one's claim, classification and source, then the premises and conclusion
in ordinary notation.

```sh
lake exe argtex
cd docs/latex && tectonic arguments.tex    # or xelatex / lualatex
```

A Unicode engine is required: the claims contain Greek and Hebrew. Citations
render as live `\cite` commands against the generated `references.bib`.

Atoms are numbered rather than named, which is the usual convention and the
point of rendering at all. It separates an argument's *shape* from its content:

```
(12)  (P₄ ∧ P₅ ∧ P₁) → P₁₂
(13)  (P₈ ∧ P₂) → P₁₂
(14)  (P₉ ∧ P₁₀) → P₁₃
(15)  (P₁₂ ∧ P₃ ∧ P₆ ∧ P₇ ∧ P₁₃ ∧ P₁₁) → P₁₄
  ⊢   P₁₄
```

That is sola fide. Premises (12) and (13) both conclude `P₁₂`, one by way of
`P₁` (Paul's ἔργα νόμου) and one by way of `P₂` (Jesus' σῴζω at Luke 7:50). The
argument's redundancy — the reason neither lexical premise is load-bearing — is
visible on the page before you read a word of the legend.

## Publishing what the library claims

`lake exe statusgen` writes the roadmap's status table from the environment:
every `@[headline]` declaration, with its statement as Lean states it and the
first sentence of its docstring, grouped by argument in source order.

```sh
lake exe statusgen           # rewrite the generated block in docs/src/roadmap.md
lake exe statusgen --check   # CI: fail if the committed block is stale
```

Nothing selects the rows. `@[headline]` already marks the results the library
claims rather than the lemmas supporting them, so the table is the tag's
contents; an argument whose results change moves the table, and one whose
namespace is new fails the build until it is given a heading in `sections`.
The prose around the block is written by hand, because *why* an argument is
worth making does not follow from its statements — and rule L9 checks that the
names that prose cites still exist.

## Lines of reason

An argument is not a heap of premises. It is a small number of *lines of
reason*, each resting on its own grounds, each licensed by its own inference
step, converging on a shared conclusion. `BornOfAVirgin` runs on four strands;
`SolaFide` on two.

A `Line` makes that structure a value rather than a remark in a docstring:

```lean
structure Line (α : Type) where
  name     : String
  grounds  : List (Formula α)   -- what this line contributes of its own
  step     : Formula α          -- the inference licensing what it delivers
  delivers : Formula α
```

and `caseOf lines shared closing` assembles a premise list from them — every
line's grounds, then the premises the lines hold in common, then every line's
step, then the steps that close the argument. Grounds before steps, so that the
material the case rests on comes first and the inferences that move it come
last.

This buys three things.

**Variants become differences.** "The scriptural reading minus the lexical
premise" is one line with one ground dropped, written as
`isaianicLine.onGrounds [...]`, instead of twenty premises retyped with one
missing — where a reader cannot see which one went and a slip in the other
nineteen is invisible. Every load-bearing result in the library needs such a
variant, so this is most of what the packages do.

**A line can be checked alone.** `Line.asPackage` turns one into an
`ArgumentPackage`, so `Establishes` applies to a single strand.

**A large argument survives being split.** Because the strands are values, they
can live in their own module: over about five hundred lines an argument becomes
a directory of `Atoms`, `Sources`, `Lines`, `Packages` and `Results`.

## Sharing scripture between arguments

Arguments overlap in the texts they read. `Testimony.Scripture` names the
passages once and collects the groups that travel together — the two infancy
narratives, the pair of Genesis verses calling Rebekah both עַלְמָה and בְּתוּלָה,
the Assyrian timeline of Isaiah 8–10 — as `List ScriptureCitation` bundles. A
bundle is a clique in the citation graph, and naming it means an argument cites
the evidence rather than assembling it:

```lean
| .maryConceivedAsVirgin =>
  { label := "Mary conceived Jesus while a virgin"
  , kind := .historical
  , source :=
      { primary := .scripture virginConceptionNarratives
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }
```

The module also holds the `Source` shapes several arguments build — `calvinHolds`,
`na28Apparatus`, `scriptureWithCalvin` — so that a premise cites a *claim* and
not a re-spelled citation.

## Writing an argument

An argument module has five parts.

**1. An atom type**, one constructor per atomic claim, each documented with
what it asserts:

```lean
inductive Claim
  /-- Romans 3:28 teaches justification by faith apart from works of the law. -/
  | romans3_28
  /-- Paul's ἔργα νόμου denotes human works in general. **The disputed
  premise.** -/
  | worksOfLawMeansWorksGenerally
  ...
deriving DecidableEq, Repr
```

**2. A total citation function.** Because it is total, an uncited atom does not
compile:

```lean
def cite : Claim → AtomMeta
  | .romans3_28 =>
    { label := "Romans 3:28 teaches justification by faith apart from works of the law"
    , kind := .textual
    , source := { primary := .scripture [{ ref := .verse ⟨.romans, 3, 28⟩ }]
                , supporting := [.work calvinInstitutes (.sectionRef "III.xi.19")]
                , tradition := .reformedProtestant
                , confidence := .wellSupported } }
  ...
```

**3. Packages — rivals first.** Writing the rival before proving anything keeps
the encoding honest; it is much easier to build a strawman after you have a
proof you like.

**4. Theorems**, tagged `@[headline]` and followed by `#print axioms`. To
establish, name what to unfold:

```lean
@[headline]
theorem reformed_establishes : Establishes reformed := by
  establish [reformed, paulineLine, dominicalLine, sharedGrounds,
    closingSteps, paulineToFaithAlone, dominicalToFaithAlone, toSalvation]
```

To refute, name the rival's reading and check it:

```lean
def tridentineReading : Valuation Claim := fun a =>
  match a with
  | .salvationByGraceThroughFaithNotWorks => False
  | _ => True

@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  refute_with tridentineReading [tridentine, reformed]
```

The bracketed list is only what to unfold. The generic half of the recipe —
`caseOf`, `conjOf`, `p`, `notP`, the list-membership lemmas that turn
`∀ φ ∈ prems` into a conjunction, and the fully qualified semantics — lives
inside the tactics, in `Testimony.Logic.Tactic`.

That is not tidiness. `Formula` is an abbreviation in `Testimony.Logic` as well
as a structure in Foundation, so a hand-written proof that says
`Formula.Boolean.val` resolves the wrong one, `simp` does nothing, and the
proof term falls back to `sorryAx` — with a successful build. Written once
inside a macro quotation, where identifiers resolve at the definition site, the
mistake cannot be made at a call site. `refute_with` also takes an identifier
rather than a term, so a countermodel must be a named definition.

**5. The load-bearing results**, where there is a disputed premise. Drop the
premise from the line that contributes it:

```lean
def reformedWithoutWorksOfLaw : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the Pauline lexical premise"
    premises :=
      caseOf [paulineLine.onGrounds [], dominicalLine] sharedGrounds closingSteps }
```

Then ask whether the argument survives. Where an argument has **two independent
strands**, as sola fide does, neither disputed premise is load-bearing alone —
only their disjunction is, and that is the more interesting result.

## Manifests

Generated from the premises, never maintained beside them:

```lean
def ArgumentPackage.manifest           : List AtomMeta
def ArgumentPackage.scriptureOnlyAtoms : List AtomMeta
```

`manifest` is every atom the premises rest on, deduplicated and mapped through
`cite`. `scriptureOnlyAtoms` filters it to those appealing to Scripture with no
scholarly support — the circularity surface described in
[Scope and limits](./scope-and-limits.md#circularity-specifically).
