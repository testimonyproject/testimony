---
name: encoding-an-argument
description: Use when adding a new argument to the Testimony library, encoding a theological or exegetical claim as a machine-checkable ArgumentPackage, or adding a rival reading to an existing argument. Covers atom design, the atom budget, rival packages, entailment proofs, and load-bearing-premise results.
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

One constructor per atomic claim. **At most twelve** (rule L5): the checker
enumerates `2^n` valuations. Every constructor needs a docstring saying what it
asserts.

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

instance : FiniteAtoms Claim where
  elems := [ .romans3_28, .worksOfLawMeansWorksGenerally,
             .salvationByGraceThroughFaithNotWorks ]
  complete a := by cases a <;> simp
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

## 3 — the packages, rivals first

Write the rival before proving anything. It is far too easy to build a
strawman once you have a proof you like.

```lean
def reformed : ArgumentPackage Claim :=
  { name := "Reformed (sola fide)"
  , cite := reformedCite
  , premises := [ p .romans3_28, p .worksOfLawMeansWorksGenerally, toConclusion ]
  , conclusion := p .salvationByGraceThroughFaithNotWorks
  , conclusionLabel := "salvation by grace through faith, not works" }
```

Use `p c` for `.atom c`, `notP c` for negation (`.imp (.atom c) .falsum`), and
`conjOf [...]` for multi-premise inference steps. A rival typically shares the
prooftexts and the inference steps, denying one premise.

For a fulfilment argument, `conclusionLabel` must be
`fulfillmentLabel person criterion` so a `SatisfactionWitness` can be built.

## 4 — the theorems

```lean
set_option maxRecDepth 20000   -- 40000 at ten or more atoms

@[headline]
theorem reformed_establishes : Establishes reformed := by
  apply entails_of_check
  decide

#print axioms reformed_establishes

@[headline]
theorem newPerspective_not_establishes : ¬ Establishes newPerspective := by
  apply not_entails_of_check
  decide

#print axioms newPerspective_not_establishes
```

`@[headline]` marks a result the library claims; rule L6 requires the
`#print axioms` line after it.

## 5 — the load-bearing result

The most valuable thing an encoding produces. **State the reduced package
explicitly** — do not filter a premise out of an existing one, because
`List.filter` over a derived `DecidableEq (Formula α)` does not kernel-reduce,
so `decide` fails and falls back to `sorryAx`.

```lean
def reformedWithoutLexicalPremise : ArgumentPackage Claim :=
  { reformed with
    name := "Reformed, minus the lexical premise"
    premises := [ /- everything except the disputed premise -/ ] }

@[headline]
theorem worksOfLaw_is_load_bearing : ¬ Establishes reformedWithoutLexicalPremise := by
  apply not_entails_of_check
  decide
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

## 8 — verify

Run all four tiers — see the `checking-the-build` skill. Tier 3 is what catches
a `decide` that silently failed.
