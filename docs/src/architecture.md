# Architecture

Testimony models arguments in layers. The guiding rule: **formal validity and
truth of premises are different things**, and the library's job is to keep that
boundary visible at all times.

## Principles

1. **Conditional analysis.** Every theorem has the shape *given premise package
   P, conclusion C follows*. No premise is smuggled in.
2. **Rival interpretations are first-class.** Divergent conclusions are a
   feature. An argument module encoding a Christian reading without at least
   one rival package is incomplete.
3. **Relation types are not collapsed.** Quotation ≠ allusion ≠ typology ≠
   prediction ≠ retrospective interpretation. Much of the messianic-prophecy
   debate is precisely about which of these a given link is.
4. **Provenance everywhere.** Enforced by the elaborator, not by review: see
   [Citations](./citations.md).
5. **Assumption manifests are generated**, never maintained.
6. **Canon is a parameter.** Results are relative to a declared canon.

## The layers

| Module | Contents |
|---|---|
| `Testimony.Text` | `Book`, `Passage`, `Pericope`, `PassageRange`, `Canon`, `TextualTradition` |
| `Testimony.Bib` | Typed bibliography entries, the `@[bib_entry]` registry, BibTeX and Markdown rendering |
| `Testimony.Provenance` | `Reference`, `Source`, `Tradition`, `Confidence`, `PremiseKind` |
| `Testimony.Intertext` | `RelationType`, `IntertextEdge`, `Interpretation` |
| `Testimony.Logic` | Formula type, decidable entailment, `ArgumentPackage`, manifests |
| `Testimony.Argument` | `FulfillmentCriterion`, `MessiahDefinition`, `Satisfies`, `MeetsDefinition` |
| `Testimony.Arguments.*` | The worked arguments |

## Two structural enforcements

The library's central rule — nothing is asserted bare — is enforced twice, at
two levels, by making the bad state unrepresentable rather than by checking for
it.

**`Source.primary` is a single required `Reference`**, not a possibly-empty
list. An uncited `Source` cannot be written down. There is no free-text escape
hatch, because an escape hatch would be used.

**`ArgumentPackage.cite` is a total function** from atoms to their metadata. An
atomic proposition without a citation does not compile.

Neither of these requires a linter, a review checklist, or a proof obligation
at the use site. They are consequences of the types.

## Dependencies

The library depends on
[FormalizedFormalLogic/Foundation](https://github.com/FormalizedFormalLogic/Foundation)
for its propositional syntax and semantics, and transitively on Mathlib,
doc-gen4 and axiom-audit. Foundation pins Lean v4.33.1.

Foundation supplies the formula type, the Hilbert systems, the Boolean and
Kripke semantics, and the metatheory; Testimony reimplements none of it. What
Testimony adds is a decidability adapter, explained in
[Encoding arguments](./logic.md).
