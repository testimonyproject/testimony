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

`Entails` is a thin local wrapper; the relation it names is not this library's.
It is Foundation's logical consequence, `T ⊨[M] φ`, at this library's premise
lists:

```lean
def premiseSet (prems : List (Formula α)) : Set (Formula α) := {φ | φ ∈ prems}

def Entails (prems : List (Formula α)) (concl : Formula α) : Prop :=
  premiseSet prems ⊨[Valuation α] concl
```

**Why two shapes.** Consequence is about a *set* of premises — order and
repetition make no difference to it, and Foundation states it over `Set F`
accordingly. A package's premises are a *list*, because `manifest` is computed
by walking them and `Set F` is `F → Prop`, which cannot be walked. The
generated assumption manifest, the atom legend and the numbered derivation on
every argument page all depend on that walk. `premiseSet` is the one step
between the two, and `entails_iff` states the relation back in the
`∀ φ ∈ prems` form every result is written in.

Borrowing rather than restating is what makes Foundation's own results
available: monotonicity, the relation between consequence and satisfiability,
and compactness are inherited rather than re-proved. A definition of entailment
written locally could be subtly wrong, and every result in the catalogue would
inherit the error while each one still looked correct.

**Does it fail to follow?** Name a countermodel — a valuation satisfying every
premise while falsifying the conclusion:

```lean
theorem not_entails_of_countermodel
    (w : Valuation α)
    (hsat : ∀ φ ∈ prems, w ⊧ φ)
    (hfail : ¬ w ⊧ concl) : ¬ Entails prems concl
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

## Publishing the argument itself

`lake exe argdoc` writes one page per argument under `docs/src/arguments/`, and
that page is the Lean file read back out: every module docstring in source
order, every `/-! ### … -/` section where the source puts it, and after each
docstring the declaration it introduces — a package as premises above a
turnstile, a line of reason as grounds and step, a result as Lean states it
with the axioms it rests on, a countermodel as the function it is.

```sh
lake exe argdoc            # rewrite docs/src/arguments/ and the SUMMARY block
lake exe argdoc --check    # CI: fail if a committed page is stale
```

`lake exe argtex` writes the same document for print, from the same harvest:

```sh
lake exe argtex                          # rewrite docs/latex/arguments.tex
cd docs/latex && tectonic arguments.tex  # ... and render it
```

The atoms are numbered **once for the whole argument** rather than per package,
so \\(P_{9}\\) means the same claim in the Protestant position and in the
Tridentine one and a reader can compare them. Only the setting differs between
the two: Markdown tables and MathJax on the site, `longtable` and live `\cite`
commands in the PDF. The formulas themselves are rendered once, by
`Testimony.Logic.Latex`, because what TeX wants is what MathJax reads.

The practical consequence is for how you write docstrings. They are not
commentary for the next contributor; they are the page. A module docstring that
says what the dispute is *not* about, or which of two answers to an objection
the position takes, is read by whoever opens the argument on the site, and it
is the only prose about that argument anywhere — there is no hand-written page
to fall out of step with it.

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

To record that a premise set settles a question neither way — which is what a
parity reply does — name both readings:

```lean
@[headline]
theorem parity_leaves_the_canon_open :
    Independent canonUnderParity.premises (p .scriptureIsSoleInfallibleRule) := by
  leaves_open parityEstablishesNothingReading krugerParityReading
    [canonUnderParity, Line.onGrounds, canonObjectionLine, canonObjectionStep]
```

`Independent prems φ` is `¬ Entails prems φ ∧ ¬ Entails prems ∼φ`, the semantic
counterpart of Foundation's proof-theoretic `Independent`. Use it in place of a
pair of `¬ Establishes` results over the same premises: one result cannot be
about two different propositions, and a pair can.

The bracketed list is only what to unfold. The generic half of the recipe —
`caseOf`, `p`, `notP`, the list-membership lemmas that turn `∀ φ ∈ prems` into
a conjunction, and Foundation's truth lemmas for the connectives — lives inside
the tactics, in `Testimony.Logic.Tactic`.

That is not tidiness. A hand-written proof has to name the semantics, and the
semantics used to be named by unfolding `Formula.Boolean.val`. `Formula` is an
abbreviation in `Testimony.Logic` as well as a structure in Foundation, so a
proof written inside an argument module resolved the wrong one, `simp` did
nothing, and the proof term fell back to `sorryAx` — with a successful build.

Formulas are now written in Foundation's own notation — `➝`, `⋏`, `⋎`, `∼`,
and `⋀` for the conjunction of a list — so the recipe reaches for Foundation's
own `@[simp]` truth lemmas, one per connective, rather than reconstructing them
by unfolding the definition of the semantics. Those lemmas live in Foundation's
namespaces and have no ambiguous siblings here: name one wrongly and it is an
unknown identifier, not a silent no-op. `refute_with` also takes an identifier
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

## Disputes

Every result above is about one package. A **dispute** is about several: which
of them defeats which, and which survive together. `Testimony.Logic.Framework`
is Dung's abstract argumentation, over any relation; `Testimony.Logic.Dispute`
makes the nodes argument packages and derives the relation from entailment.
`Arguments/BornOfAVirgin/Dispute.lean` is the worked example.

**Nothing about the relation is stipulated.** One package *attacks* another when
its premises entail the negation of one of the other's premises (`UnderminesOn`)
or of its conclusion (`Rebuts`). An attack is a *defeat* unless the cited
confidences block it: a position's strength is its weakest link — the lowest
rank among its premises that are atoms or denials of atoms — and an attack fails
only when what it attacks is strictly stronger. Inference steps have no rank, so
an attack on a step always succeeds. A denied atom ranks `disputed`, because the
citation rates the claim, not its denial.

Why confidence at all: without it, premise attacks between classical arguments
are always mutual, and Dung's semantics reduce to a consistency check (Cayrol,
1995). The consequence is that **ratings become premises** of every dispute that
uses them, and a rating change can reverse a result. Say so in the module
docstring, and say which rating decides the outcome.

Encoding a dispute has four steps.

**1. Every node is an argument.** `Dispute` requires each node's premises to be
satisfiable and to establish its conclusion — a node with contradictory premises
would attack everything. A reply written with `Line.onGrounds` keeps the
objection's conclusion and so is not a node; write the reply as its own `Line`,
with what it concludes as `delivers`.

**2. Prove the defeat table, every ordered pair.** Four shapes cover it:

```lean
-- undermining: the premise, its membership, the entailment, the ranks
theorem berry_defeats_critical : Defeats berryObjection criticalDenial :=
  .inl ⟨p .nearTermExcludesMessianicSense,
    ⟨by simp [criticalDenial, criticalExclusionLine, Line.asPackage, Line.premises],
      berryObjection_establishes⟩,
    by decide⟩

-- rebutting: the entailment, then the strengths
theorem christian_defeats_critical : Defeats christian criticalDenial :=
  .inr ⟨christian_rebuts_critical,
    by rw [christian_strength, criticalDenial_strength]; decide⟩

-- no attack: name the world in which both positions stand
theorem berry_does_not_defeat_postell : ¬ Defeats berryObjection postellParity :=
  not_defeats_of_joint_model (by satisfied_by repliesStandReading […])

-- the diagonal, for free
isaiahDispute.not_defeats_self i
```

An attack the ratings block needs both of its routes closed: each undermining,
by a named world in which the attacker's premises hold alongside the premise,
and the rebuttal, by strength. `critical_does_not_defeat_berry` is the example.
Strengths are computed by `decide`, and are worth stating as results of their
own, because they are what a reader contests.

**3. Collect the table** as one `↔` against a function by cases, proved by
`cases i <;> cases j` and the pairwise results.

**4. State what survives.** `grounded_eq_of_iterate` proves a grounded
extension: give the iterate of the characteristic function from `∅` and show it
defends nothing new. `preferred_of_blocked` proves a preferred extension: show
the set is admissible and that everything outside it conflicts with something
inside. Credulous and sceptical acceptance follow from exhibited extensions.

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
