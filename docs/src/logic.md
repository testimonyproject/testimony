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

**Does the conclusion follow?** Once a package is unfolded, what is left is
almost always a *Horn* problem: facts, and inference steps from a conjunction of
literals to an atom or a conjunction of atoms. Horn entailment is decidable in
linear time (Dowling and Gallier, 1984), and backward chaining over Horn clauses
— SLD resolution, Prolog's procedure — is what `establish` runs, as Lean's
`solve_by_elim`, after currying each step with `and_imp`, splitting conjunctive
heads with `imp_and`, and currying a negated conjunction with `not_and` — the
shape of a goal that rebuts a conjunctive conclusion, which the sola fide
dispute needs. If that leaves the goal open, `establish`
fails rather than silently searching; `establish_by_search` runs Mathlib's
`tauto`, a general classical search whose cost is exponential in the number of
inference steps, for a step that genuinely cannot be Horn. No result in the
library needs it. Both produce ordinary proof terms, so the trust base is
unchanged.

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

**`tauto` alone** was the recipe until the arguments outgrew it. It case-splits
on every implication in the context, so each inference step added to a case
multiplies its cost however simple the step is: splitting `SolaFide`'s closing
step in three took `reformed_establishes` to twenty times the default heartbeat
budget, and the argument was carried with two closing steps until the recipe
changed; it now has the three, and `reformed_establishes` takes about two
thousand heartbeats. On four `SolaFide` goals with no heartbeat limit, `tauto`, `simp_all`
and `aesop` each failed to finish in fifteen minutes; Mathlib's `itauto`
(Dyckhoff's G4ip, *J. Symbolic Logic* 57(3), 1992), complete for intuitionistic
logic, took six. The Horn path takes four seconds — about two thousand
heartbeats a goal where `tauto` took about four million — because it is the
procedure the goals' shape calls for. It is also
constructive where `tauto` is classical, so every `Establishes` result now rests
on `propext` and `Quot.sound` alone; `Classical.choice` remains in the trust
base only for the dispute results, which come from the Dung semantics.

### Why a faster recipe cannot have made a result wrong

Speed is not correctness, so the change of recipe was checked, not assumed.
The argument rests on how Lean is built, and each part of it was then verified
on the library itself.

**The recipe is not in the trust base.** Lean follows the LCF architecture: a
tactic does not certify anything, it constructs a proof term, and the kernel
checks that term against the theorem's statement. A tactic can fail to find a
proof; it cannot make the kernel accept a false one. What `establish` proves is
`Establishes pkg`, which unfolds to Foundation's *semantic* consequence — every
valuation satisfying the premises satisfies the conclusion — so a successful
`establish` is a kernel-checked proof of exactly that, whatever algorithm found
it. What is trusted is the kernel, the axioms each result reports, and the
statements themselves. The three checks below cover what is not already
covered by the kernel.

**Every statement is unchanged.** The change touched no argument module: in
`Testimony/Logic` it rewrote the tactic macros and two comments. To make that
mechanical rather than argued, the commit before the change (`5cb6bc0`, still
on `tauto`) and the commit after were both built, and every `Testimony`
declaration was printed with its fully elaborated type — and, for definitions,
its value — under `pp.all`, so that no notation could hide a difference. Of the
2,429 declarations that existed before, all 2,429 are identical. The only
differences are four additions: the syntax of `establish_by_search`,
`establish_unfold` and `horn_close`, and the sanity theorem
`establish_by_search_proves_cases`. So every result states what it stated
before, over the same definitions; only proof terms changed.

**The kernel re-checks every proof.** `scripts/kernel-replay.sh` runs
`leanchecker`, which replays every declaration of all 53 `Testimony` modules
through the kernel, into the environment as it stood before each module,
independently of the elaborator and of every tactic. It passes, and runs in CI
after the axiom audit. The audit
itself reports every `Establishes` result resting on `propext` and `Quot.sound`
at most — no `sorryAx`, no `Classical.choice`.

**It proves nothing the library refutes.** For every result of the form
`¬ Establishes pkg`, `establish` is run on `pkg` with its argument's unfold set,
and must fail with `horn_close`'s message. The set is the one the refutation's
own proof unfolds — `refute_with` evaluates the countermodel on every premise,
which it cannot do through a folded definition — so a failure is the entailment
failing and not a definition left folded. This was a manual check; it is now
`#check_refutations` in `Testimony/Checks/Refutations.lean`, which finds the
refutations itself and runs in `lake build`, so CI runs it on every change.
`Tactic.lean` pins the same check on affirming the consequent, the canonical
invalid inference.

What the change does *not* claim is completeness beyond Horn: SLD resolution is
complete for Horn clauses, and `establish` fails — it does not silently succeed
or fall back — on anything else. A failure is never read as a refutation; that
is what countermodels are for.

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
(17)  (P₂ ∧ P₃ ∧ P₈ ∧ P₇ ∧ P₆) → P₂₄
(18)  (P₁₇ ∧ P₁₈ ∧ P₁₉) → P₂₄
(19)  (P₉ ∧ P₁₀) → P₂₄
(20)  (P₂₀ ∧ P₂₁) → P₂₂
(21)  (P₁ ∧ P₄ ∧ P₅) → P₂₅
(22)  (P₁ ∧ P₄ ∧ P₅ ∧ P₂₂ ∧ P₂₃) → P₂₆
(23)  (P₂₄ ∧ P₁) → P₂₇
  ⊢   P₂₅ ∧ P₂₆ ∧ P₂₇
```

That is sola fide. Premises (17), (18) and (19) all conclude `P₂₄`: one by way
of `P₆` and `P₇` (Paul's ἔργα νόμου, and πίστις Χριστοῦ read as faith in
Christ), one by way of `P₁₈` and `P₁₉` (Jesus' σῴζω at Luke 7:50, and 7:47 read
as love evidencing forgiveness), and one by way of `P₁₀` (Peter's yoke at Acts
15:10). The argument's redundancy — the reason no disputed premise is
load-bearing on its own — is visible on the page before you read a word of the
legend. So is the split in the conclusion, one step per part: (21) reaches grace
(`P₂₅`) from the texts alone; (22) reaches "not by works" (`P₂₆`) from the same
texts and the answer to James (`P₂₂`); only (23), "through faith" (`P₂₇`), needs
a strand (`P₂₄`).

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
`SolaFide` on three.

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
establish, name the argument's unfold set:

```lean
@[headline]
theorem reformed_establishes : Establishes reformed := by
  establish [solaFideDefs]
```

To refute, name the rival's reading and check it:

```lean
def tridentineReading : Valuation Claim := fun a =>
  match a with
  | .salvationNotByWorks => False
  | .justificationIsForensicOnly => False
  | _ => True

@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  refute_with tridentineReading [solaFideDefs]
```

To record that a premise set settles a question neither way — which is what a
parity reply does — name both readings:

```lean
@[headline]
theorem parity_leaves_the_canon_open :
    Independent canonUnderParity.premises (p .scriptureIsSoleInfallibleRule) := by
  leaves_open parityEstablishesNothingReading krugerParityReading
    [solaScripturaDefs]
```

`Independent prems φ` is `¬ Entails prems φ ∧ ¬ Entails prems ∼φ`, the semantic
counterpart of Foundation's proof-theoretic `Independent`. Use it in place of a
pair of `¬ Establishes` results over the same premises: one result cannot be
about two different propositions, and a pair can.

The bracketed set is only what to unfold. Each argument has one, declared in
`Testimony/Attr.lean`, and a definition joins it where it is written —
`@[solaFideDefs] def reformed ...` — so a new definition is tagged once rather
than added to every proof that passes through it. An untagged one stays
folded, and `establish` reports the premises as not Horn. The generic half of
the recipe — `caseOf`, `Line.onGrounds`, `p`, `notP`, the list-membership
lemmas that turn `∀ φ ∈ prems` into a conjunction, and Foundation's truth
lemmas for the connectives — lives inside the tactics, in
`Testimony.Logic.Tactic`.

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
def reformedWithoutSozo : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the dominical lexical premise"
    premises :=
      caseOf [paulineLine, dominicalLine.onGrounds [p .luke7_47LoveIsEvidence], apostolicLine]
        sharedGrounds closingSteps }
```

Then ask whether the argument survives. Where an argument has **independent
strands**, as sola fide has three, no strand's disputed premise is load-bearing
alone — only their disjunction is, and that is the more interesting result.

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
rank among its premises, inference steps included — and an attack fails only
when what it attacks is strictly stronger. A denied atom ranks `disputed`,
because the citation rates the claim, not its denial. A step ranks at the
citation in its line's `inference` field, and `Dispute` refuses a node without
one: rate a step `disputed` when a cited source grants its grounds and denies
its conclusion. Leaving steps unrated would let the placement of a contested
move — atom or step — decide who prevails.

Why confidence at all: without it, premise attacks between classical arguments
are always mutual, and Dung's semantics reduce to a consistency check (Cayrol,
1995). The consequence is that **ratings become premises** of every dispute that
uses them, and a rating change can reverse a result. Say so in the module
docstring, and say which rating decides the outcome.

Encoding a dispute has three steps.

**1. Every node is an argument.** `Dispute` requires each node's premises to be
satisfiable and to establish its conclusion — a node with contradictory premises
would attack everything. A reply written with `Line.onGrounds` keeps the
objection's conclusion and so is not a node; write the reply as its own `Line`,
with what it concludes as `delivers`.

**2. State the table, and let the engine check it.** Write down who defeats
whom as a table over the parties, give each party's strength, and prove the
dispute's relation equal to the table. Every cell is computed from the
premises and checked by the kernel — the defeats and the absences alike:

```lean
theorem isaiahDispute_defeats : ∀ i j, isaiahDispute.defeats i j ↔ partyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (partyNode_strength i) (partyNode_strength j) ?_
  cases i <;> cases j <;> decide +kernel
```

`Horn.defeats?` (`Testimony.Logic.Horn`) decides each pair by asking whether
formulas can all hold together: `a` undermines `b` on `φ` exactly when `a`'s
premises and `φ` cannot, and rebuts it exactly when `a`'s premises and `b`'s
conclusion cannot. It translates the premises to clauses — atoms, denied atoms,
and steps from a conjunction of literals to an atom, a conjunction or a
contradiction — and decides them by unit propagation. Each answer carries its
evidence: *satisfiable* only once a candidate model has been checked against
every clause, *unsatisfiable* only when a clause is violated by atoms every
model must have. So the procedure can fail to decide — a formula with a
disjunction has no clauses, and it answers *unknown* — but it cannot decide
wrongly, and its correctness theorems do not depend on it being complete.
`decide +kernel` runs it inside the kernel and adds no axiom, unlike the banned
`native_decide`.

A single defeat worth naming is one line, from the same computation:

```lean
theorem berry_defeats_critical : Defeats berryObjection criticalDenial :=
  Horn.defeats_of_defeats? berryObjection_strength criticalDenial_strength
    (by decide +kernel)
```

Strengths are computed by `decide`, and are worth stating as results of their
own, because they are what a reader contests. They are also why the engine
takes them as arguments: a strength looks up every atom's citation, the most
expensive part of a decision, and a dispute proves each party's once.

**Say why an absence is not a counter.** A computed absence names no reason, and
the reason is often the point: the critic is not answered by Postell's step,
because a critic can date Isaiah 9 and 11 later. `Grants a φ` states that some
reading holds everything `a` holds and `φ` too; it is proved with
`satisfied_by` and a named reading, and gives `¬ UnderminesOn a b φ` when `φ`
is `b`'s premise and `¬ Rebuts a b` when it is `b`'s conclusion:

```lean
/-- The critic's world, with Isaiah 9 and 11 taken off the Assyrian timeline … -/
def laterOraclesReading : Valuation Claim := …

theorem critic_grants_postells_step_by_dating_the_oracles_later :
    Grants criticalDenial parityDefeatsNearTermExclusion := by
  satisfied_by laterOraclesReading [Grants, bornOfAVirginDefs]
```

One reading, one premise, one line: nothing depends on it, adding a premise
elsewhere cannot break it, and its docstring carries the explanation into the
generated page. Write one wherever the absence of a counter is something a
reader would ask about.

Parties that can all hold at once **stand together**, and that is still worth
stating with a named world — `replies_stand_with_the_scriptural_reading` is the
reading on which none of five positions has to give way — though the table no
longer needs it.

**What it costs.** One pair takes the kernel between a tenth and a quarter of
a second. The sola fide table of sixty-four pairs checks as one theorem within
the default heartbeat budget, and its module now builds in 24 seconds where
the hand-written table took 31; the born-of-a-virgin disputes, thirty-six pairs
and nine, build as fast as they did.

**If the engine answers *unknown*** — a premise it cannot write as clauses —
prove that cell by hand: a defeat from the attack and the comparison of
strengths, an absence with `not_defeats_of_models` or
`not_defeats_of_outweighed`, one named world per premise.

**3. State what survives, with its reason.** Describe the dispute once in
solver form (`Testimony.Logic.Solver`): every party listed, and the table as a
Boolean. Then declare each verdict as a `Verdict` (`Testimony.Logic.Verdict`).
It holds the verdict's claim and its **witness**, a small statement of why it
holds. A checker proved sound once against `Testimony.Logic.Framework` confirms
the witness (`Testimony.Logic.Witness`), and the result follows from
`Verdict.holds`:

```lean
def isaiahFinite : Solver.Finite isaiahDispute.defeats where
  parties := [.scriptural, .critical, .berry, .postell, .motyer, .micah]
  complete i := by cases i <;> decide
  defeats i j := decide (partyDefeats i j)
  spec i j := by rw [isaiahDispute_defeats]; simp

/-- Why the critical denial cannot be defended: Postell attacks it, and nothing
answers Postell. -/
def criticAnsweredByPostell : Verdict isaiahDispute where
  finite := isaiahFinite
  claim := .indefensible .critical [(.critical, .postell)]
  checked := by decide +kernel

theorem critical_denial_indefensible (S : Set Party)
    (hS : Admissible isaiahDispute.defeats S) : Party.critical ∉ S :=
  criticAnsweredByPostell.holds S hS
```

A wrong witness fails to check, so it cannot prove a wrong verdict. And the
page does not take the docstring's word for the reason. It renders the reason
from the witness itself, naming each defeat by the two parties' packages:

> ***Critical denial of the predictive reading of Isaiah 7:14* cannot be
> defended: no admissible position holds it.**
>
> - *Postell's parity argument against the near-term exclusion* defeats
>   *Critical denial of the predictive reading of Isaiah 7:14*, and nothing
>   defeats *Postell's parity argument against the near-term exclusion*.

Under the reasons, the page says what they rest on: how many cells of the
defeat table they state (defeats named, and the absences of defeat that
"nothing defeats *c*" quantifies over), and every party those cells involve at
its weakest link, each premise with its citation. Those are the readings to
contest to contest the verdict. Two limits, stated in the module docstring:
that the verdict holds of any table agreeing on those cells is stated but not
yet proved, and denying one reading need not overturn the verdict, which may
stand by another route.

So a docstring that drifts from its witness is visible: the generated list
beneath it says otherwise, and changing the witness changes the page, which
`argdoc --check` catches. A defeat that a `Because` on the same page explains
links to it. Each page also names the defeat table's theorem, where every
defeat mentioned is proved.

| Verdict | Witness |
|---|---|
| nothing is grounded | a defeater for every party |
| these parties are grounded | stages, each defended by the ones before |
| the grounded extension is exactly this | stages, and for each party outside an attacker left unanswered |
| no admissible set holds `b` | the attacker `b` cannot answer, and why each answer to it fails |
| every preferred extension holds `a` | `a` answers its attackers itself, and each rival cannot be defended |
| some preferred extension leaves `a` out | an admissible set holding a rival |
| this set is preferred | admissible, and everything outside conflicts with something inside |

To find a witness, ask the untrusted finder — `#eval Witness.findSkeptical F a`,
`findIndefensible`, `findDefeaters`, `findStages`, `findUnanswered` — and copy
what it returns into the file. Checking a witness is polynomial. The sceptical
witness is a sufficient condition, not a characterisation: where no witness of
that shape exists, the solver's whole-set enumeration (`skeptically_accepted`,
`preferred_eq`, `not_mem_admissible` and the rest) decides the verdict instead,
at a cost exponential in the parties — some such cost is unavoidable in the
worst case, since sceptical acceptance under the preferred semantics is
Π₂ᵖ-complete (the module docstring of `Testimony.Logic.Solver` gives the
results and their sources).

`Dispute.restrict` hears only some of the parties, and `Finite.restrict` gives
the checkers the same hearing; `Witness.Table.sub` and `Witness.listSub` write a
hearing's witnesses in the parties' own names. That is how a result says what
one party is worth: take it away and see what survives. A verdict re-checks
itself when a party is added, and a witness that no longer holds fails to
check.

**4. Say why a position stands against a rival.** A verdict says *who*
survives; a reader also asks *why*. `Because P R` (`Testimony.Logic.Because`)
answers for one pair, as one checked object. It names a **crux**, one of `P`'s
premises, and proves:

- `P`'s premises have a model and establish its conclusion;
- where the crux sits: `P`'s premises are `before ++ crux :: after`;
- a **core** of `R`'s premises cannot be held with the crux, together with any
  **granted** grounds of `P` the break needs, stated rather than hidden;
- the core is minimal: drop any one of its premises and the rest hold with the
  crux, so the core is exactly where `R` breaks;
- the core and the granted grounds hold together without the crux, so the crux
  does the breaking, not the grounds;
- `R`'s premises have a model: it falls to the crux, not to itself;
- the crux's **role**. It `derives` when `P`'s conclusion does not follow without
  it, so it is part of `P`'s case. It `answers` when the conclusion follows
  anyway, so the crux is held only as `P`'s answer to `R`.

The role is proved, not chosen. The dominical case for sola fide turns out to
hold the Reformed distinction between justification and sanctification only as
its answer to Trent: its conclusion follows from its other premises. Luther's
step from Galatians is part of his case against Aquinas.

```lean
def whyLutherAnswersAquinas : Because lutherOnGalatians thomistOnJohn :=
  Because.ofChecks lutherLine.step lutherLine.grounds [] lutherLine.grounds
    [p .johannineBelievingIsFormedByCharity] .derives
    luther_answers_aquinas_from_galatians lutherOnGalatians_is_satisfiable
    (by simp [lutherOnGalatians, Line.asPackage, Line.premises])
    (fun φ hφ => by simp [lutherOnGalatians, Line.asPackage, Line.premises, hφ])
    (by simp [solaFideDefs, caseOf, Line.onGrounds])
    (by decide +kernel)
```

`Because.ofChecks` takes the engine's check as one `decide +kernel`: the break,
its minimality, the crux being needed, the rival standing and the role. It also
takes the facts the engine cannot decide. `P` holds, and its premises have a
model; both are theorems the argument already has. The split and the two
membership claims are proved by unfolding. The split has to be declared,
because equality on `Formula` does not reduce in the kernel. Declaring it is
also the honest form, since it names the occurrence of the crux that is meant.

From a `Because` follow `not_together`, that the two positions cannot be held
at once, and `undermines`, that a one-premise core with nothing granted is an
attack in the dispute's own sense.

**What it claims, and what it does not.** It is conditional on its crux: *if
the crux holds, `P` stands and `R` cannot be held, and this is the premise of
`R` that fails.* It says nothing about whether the crux is true. The rendered
explanation therefore ends with what it rests on: the crux and the granted
grounds, each with its rating and citation. When the crux is a step rather than
a claim, the step's own rating is listed too. A `Because` in an argument's
module is harvested into its page and the PDF like any other result, and its
docstring is the prose above the explanation.

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
