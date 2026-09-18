---
name: encoding-an-argument
description: Use when adding a new argument to the Testimony library, encoding a theological or exegetical claim as a machine-checkable ArgumentPackage, or adding a rival reading to an existing argument. Covers atom design, scripture bundles, lines of reason, rival packages, the establish and refute_with tactics, load-bearing-premise results, and when to split an argument into a directory.
---

# Encoding an argument

## Before writing any Lean

Get these from the source literature, not from memory:

1. **What is the conclusion**, stated as one sentence.
2. **Which texts** the argument appeals to, with chapter and verse.
3. **Which interpretive premises** it needs — and specifically, **which one is
   disputed**. Nearly every argument in this library has exactly one hinge.
4. **Who holds the rival position**, and what they deny. You need a real
   citation for the rival, not a characterisation.

If you cannot name the rival's source, stop and find it. A strawman rival makes
the whole encoding worthless.

## 1 — the atom type

One constructor per atomic claim, each with a docstring saying what it asserts.
There is no limit on how many: entailment is settled by `tauto` and refuted by
named countermodels, neither of which enumerates valuations.

```lean
inductive Claim
  /-- Romans 3:28 teaches justification by faith apart from works of the law. -/
  | romans3_28
  /-- Paul's ἔργα νόμου denotes human works in general, not Jewish covenant
  boundary markers. **The disputed premise.** -/
  | worksOfLawMeansWorksGenerally
  /-- Salvation is by grace through faith, and not by works. **The
  conclusion.** -/
  | salvationByGraceThroughFaithNotWorks
deriving DecidableEq, Repr
```

Include the atom the *rival* needs, and the atom the strongest *objection*
needs. Sola scriptura encodes its own self-refutation objection; that is the
standard, not a special case.

Name atoms as passage + claim: `romans3_28`, `timothy3_16GodBreathed`.

## 2 — the citation function

Total, so an uncited atom does not compile.

```lean
def cite : Claim → AtomMeta
  | .romans3_28 =>
    { label := "Romans 3:28 teaches justification by faith apart from works of the law"
    , kind := .textual
    , source := { primary := .scripture [{ ref := .verse ⟨.romans, 3, 28⟩ }]
                , supporting := [.work calvinInstitutes (.sectionRef "III.xi.19")]
                , tradition := .reformedProtestant
                , confidence := .wellSupported } }
```

`kind` is `textual` (what a text says), `linguistic` (what words mean),
`historical` (what happened), `theological` (what doctrine holds), or
`interpretive` (how a passage is read). Mark a disputed premise
`confidence := .disputed` — especially when it is the hinge.

Where packages disagree about an atom, give each its own `cite`, sharing a
`baseCite` for the atoms they agree on. That way each package's manifest cites
the people who actually hold its premises.

See the `adding-a-citation` skill for new bibliography entries.

## 3 — the lines of reason

An argument is a small number of *lines of reason*, not a heap of premises.
Each is a `Line`: its own grounds, the single step licensing them, and what it
delivers.

```lean
def paulineLine : Line Claim :=
  { name := "Pauline strand (ἔργα νόμου)"
  , grounds := [p .worksOfLawMeansWorksGenerally]
  , step := paulineToFaithAlone
  , delivers := p .justificationByFaithAlone }
```

`grounds` are the premises the line contributes *of its own*. What several
lines rest on in common is passed separately, because it belongs to no single
strand.

Build the package with `caseOf lines shared closing`, which lays out every
line's grounds first, then the shared premises, then every line's step, then
the steps that close the argument:

```lean
def reformed : ArgumentPackage Claim :=
  { name := "Reformed (sola fide)"
  , cite := reformedCite
  , premises := caseOf [paulineLine, dominicalLine] sharedGrounds closingSteps
  , conclusion := p .salvationByGraceThroughFaithNotWorks
  , conclusionLabel := "salvation by grace through faith, not works" }
```

A single line that concludes exactly what it delivers can skip `caseOf`:
`someLine.asPackage cite "the label"`.

## 3b — the packages, rivals first

Write the rival before proving anything. It is far too easy to build a
strawman once you have a proof you like.

`p c` (for `.atom c`) and `notP c` (for Foundation's `∼(.atom c)`) are generic
over the atom type and come from `Testimony.Logic.Notation` — do not redeclare
them in the argument module. Use `p`, `notP`, Foundation's connective notation
(`🡒`, `⋏`, `⋎`) and `⋀ [...]` for multi-premise inference steps — never the
raw `.imp`/`.and` constructors, which the truth lemmas are not indexed under. A rival typically shares the
prooftexts and the inference steps, denying one premise.

For a fulfilment argument, `conclusionLabel` must be
`fulfillmentLabel person criterion` so a `SatisfactionWitness` can be built.

## 4 — the theorems

To establish, use `establish` and name what to unfold — the package, its
lines, its steps, any shared premise list:

```lean
@[headline]
theorem reformed_establishes : Establishes reformed := by
  establish [reformed, paulineLine, dominicalLine, sharedGrounds, closingSteps,
    paulineToFaithAlone, dominicalToFaithAlone, toSalvation]

#print axioms reformed_establishes
```

If `tauto` fails with the package still folded up in the hypothesis, something
in the chain is missing from the list — add it. The failure is loud, which is
the point: nothing here can succeed vacuously.

To refute, **name the rival's reading** and check it. The valuation is the
rival's position written down, so name it after that position:

```lean
def tridentineReading : Valuation Claim := fun a =>
  match a with
  | .salvationByGraceThroughFaithNotWorks => False
  | _ => True

@[headline]
theorem tridentine_not_establishes : ¬ Establishes tridentine := by
  refute_with tridentineReading [tridentine, reformed]
```

`refute_with` takes an **identifier**, so the countermodel has to be a named
definition. An inline valuation will not typecheck, which is the style rule
made mechanical.

**Never hand-write the `simp only` recipe these tactics replace.** A
hand-written proof has to name the semantics, and naming it wrongly is silent:
`Formula` is also an abbreviation in `Testimony.Logic`, so a proof saying
`Formula.Boolean.val` resolved the wrong namespace, `simp` did nothing, and the
proof fell back to `sorryAx` — with a successful build that only
`lake exe axiom-audit` catches. The tactics name Foundation's truth lemmas
once, inside a macro quotation, where a call site cannot reach them.

`@[headline]` marks a result the library claims; rule L6 requires the
`#print axioms` line after it.

## 5 — the load-bearing result

The most valuable thing an encoding produces. Drop the premise from the line
that contributes it, with `Line.onGrounds` — never by filtering a premise out
of an existing package, and never by retyping the premise list, where a reader
cannot see which premise went.

Where an argument has two independent routes to its conclusion — as sola fide
does, through Paul and through Jesus' words in Luke — neither disputed premise
will be load-bearing on its own. Check each separately, then check both
together; the interesting result is usually that only the *disjunction* carries
the argument.

```lean
def reformedWithoutWorksOfLaw : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the Pauline lexical premise"
    premises :=
      caseOf [paulineLine.onGrounds [], dominicalLine] sharedGrounds closingSteps }

@[headline]
theorem worksOfLaw_not_load_bearing : Establishes reformedWithoutWorksOfLaw := by
  establish [reformedWithoutWorksOfLaw, reformed, Line.onGrounds, paulineLine,
    dominicalLine, sharedGrounds, closingSteps, /- … the steps -/]
```

## 6 — read the manifest

```lean
#eval reformed.manifest.map (fun m => m.label)
#eval reformed.scriptureOnlyAtoms.map (fun m => m.label)
```

If `scriptureOnlyAtoms` is non-empty, the argument grounds a premise in
Scripture with no scholarly support. That is permitted, but say so in the
module docstring — `BornInBethlehem` does, for `jesusBornInBethlehem`.

## 7 — the module docstring

State the dispute in prose before any code: what the argument claims, where it
is contested, and what the strongest objection is. `BornOfAVirgin.lean` is the
model. A reader should be able to understand the disagreement without reading
the Lean.

## 7b — one file, or a directory

Start in one module. When it approaches ~500 lines, split it, keeping the root
module as imports plus the module docstring:

| File | Contents |
|---|---|
| `Atoms.lean` | the `Claim` atoms, and any recurring `Source` values |
| `Sources.lean` | `cite` |
| `Lines.lean` | the inference steps and the lines of reason |
| `Packages.lean` | the positions and the variants |
| `Results.lean` | the `@[headline]` results |

Dependencies run in that order, so there are no cycles. `BornOfAVirgin/` and
`SolaFide/` are the worked examples. Rule L5 counts packages across the whole
directory, so splitting cannot lose the rival.

Anything shared with *another* argument goes further out: passages and citation
bundles in `Testimony.Scripture`, `Person` values in `Testimony.People`. Check
`Testimony.Scripture` before writing a passage literal — the passage may
already be named, and a bundle such as `virginConceptionNarratives` or
`bethlehemBirthNarratives` may already collect the verses you want.

## 8 — verify

Run all four tiers — see the `checking-the-build` skill. Tier 3 is what catches
a `decide` that silently failed.
