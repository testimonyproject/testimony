# Design

Testimony models biblical Messianic arguments in six layers. The guiding rule:
**formal validity and truth of premises are different things**, and the library's
job is to keep that boundary visible at all times.

## Principles

1. **Conditional analysis.** Every theorem has the shape
   *given premise package P, conclusion C follows*. No premise is smuggled in.
2. **Rival interpretations are first-class.** A passage carries multiple
   `Interpretation` values from different traditions (Christian typological,
   Jewish, critical-scholarship). Divergent conclusions are a feature.
3. **Relation types are not collapsed.** Quotation ≠ allusion ≠ typology ≠
   prediction ≠ retrospective interpretation. Each intertextual edge is typed.
4. **Provenance everywhere.** Every premise, annotation, and edge carries a
   source citation and a confidence level.
5. **Assumption manifests.** Tooling generates, for each theorem, the list of
   unproven premises with their classification:
   `textual | linguistic | historical | theological | interpretive`.
6. **Canon is a parameter.** Protestant, Catholic, Orthodox, and Ethiopian
   canons differ; results are relative to a declared canon.

## Layers

### 1. Text & canon (`Testimony.Text`)
`Book`, `Passage` (book/chapter/verse), `Pericope`, `Canon`, `TextualTradition`.
References eventually resolve against real corpus identifiers (OSHB/STEPBible).

### 2. Linguistic analysis (`Testimony.Language`)
Lemma, morphology, and syntax records imported from scholarly databases
(ETCBC/BHSA, Open Scriptures Hebrew Bible). Treated as *sourced scholarly data*,
never as formally certified fact.

### 3. Intertextual relations (`Testimony.Intertext`)
`RelationType` inductive: `quotation | allusion | echo | typology | promise |
prediction | messianicTheme | retrospective | thematic`. Edges carry
`Source`, `Tradition`, `Confidence`.

### 4. Historical claims (`Testimony.History`)
Claims about persons, events, dates, authorship, manuscripts — with evidence
class and citation, separate from what the text asserts internally.

### 5. Premise packages (`Testimony.Premises`)
Named, versioned bundles of hermeneutical/theological assumptions
(e.g. `christianTypological`, `secondTempleJewish`, `criticalScholarship`).
Theorems quantify over or take a package as hypothesis.

### 6. Formal reasoning (`Testimony.Argument`)
`FulfillmentCriterion`, `FulfillmentClaim`, `MessiahDefinition`, and the
conditional theorems that connect them. A future probabilistic layer
(evidential updating) stays in a separate namespace, never conflated with
deduction.

## Roadmap

- **Phase 1 (vertical slice):** Matthew 2:5–6 quoting Micah 5:2, end-to-end,
  with one rival interpretation and a generated assumption manifest.
- **Phase 2:** the canonical dozen passages (Isa 53, Ps 22, Mic 5:2, Zech 9:9,
  Dan 9, Isa 7:14, Ps 110, …) each with competing premise packages, and a first
  aggregate theorem.
- **Phase 3:** corpus grounding — importers so `Passage` values resolve against
  real text data.
- **Phase 4:** docs site, assumption-manifest browser, community launch.
