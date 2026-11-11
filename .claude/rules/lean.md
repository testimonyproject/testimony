---
paths:
  - "**/*.lean"
---

# Lean gotchas, found the hard way

- `section` and `meta` are reserved; use `sectionRef` and `cite`.
- Doc comments must sit immediately before the declaration keyword —
  `set_option ... in` goes *above* the docstring.
- `derive_bib_registry` reads the attribute's local module state, so it must
  stay at the bottom of each package's `Works.lean`. A work the library itself
  cites goes in `Testimony/Bib/Works.lean`; one only the arguments cite, in
  `arguments/TestimonyArguments/Works.lean`.
- `List.filter` over a derived `DecidableEq (Formula α)` does not kernel-reduce;
  state reduced packages explicitly instead.
- **Never hand-write the entailment proof recipe.** Use `establish [set]`,
  `refute_with <namedValuation> [set]`, `satisfied_by <namedValuation> [set]`
  and `leaves_open <falsifies> <verifies> [set]` from `Testimony.Logic.Tactic`,
  where `set` is the argument's unfold set (`solaFideDefs`, declared in
  `arguments/TestimonyArguments/Attr.lean`).
- **Tag a new definition, never extend a list.** A package, line, step or
  shared premise list joins its argument's set where it is written:
  `@[solaFideDefs] def ...`. An untagged one stays folded, and `establish`
  reports "not Horn". A new argument adds its set to
  `arguments/TestimonyArguments/Attr.lean` and to `unfoldSets` in
  `arguments/TestimonyArguments/Checks.lean`, and its title to the catalogue in
  `arguments/TestimonyArguments/Tools/Catalogue.lean`.
- **The recipe's semantics are qualified inside the tactic.** This used to be a
  documentation rule: `Formula` is also an abbrev in
  `Testimony.Logic`, so an unqualified `Formula.Boolean.val` resolves to the
  wrong namespace, `simp` does nothing, and the proof falls back to `sorryAx`
  with a *successful build*. The qualified name is now written once, inside the
  tactic, where a call site cannot mistype it.
- **"Defeats" has two senses.** Older result names such as
  `compatibility_defeats_lexical_objection` state an entailment fact. In
  `Testimony.Logic.Dispute`, `Defeats` is an attack that survives the
  confidence preference, and it makes every cited `Confidence` load-bearing: a
  changed rating can change who prevails in a dispute. Inference steps count
  too: a `Dispute` refuses a node whose package cites no `inference`, and a step
  is `disputed` when a cited source grants its grounds and denies its conclusion.
- **`establish` is Horn-only, on purpose.** It proves by backward chaining
  (`solve_by_elim`) after currying each step, and fails rather than falling back
  to `tauto`, whose cost is exponential in the number of inference steps. Keep
  steps as *conjunction of literals → atom or conjunction of atoms*; write
  alternatives as separate lines, not as a `⋎`. `establish_by_search` exists for
  a step that genuinely cannot be Horn. Never raise `maxHeartbeats`.
- `refute_with` takes an identifier, not a term, so a countermodel must be a
  named definition — the rival's reading, written down.
- There is no atom budget; the 2^n truth-table checker was removed.
- Free text reaching LaTeX must be escaped. An unescaped `&` in a bibliography
  note ("T. & T. Clark") breaks the generated `.bbl` with a misplaced-alignment
  error far from its cause; `Bib.Render.texEscape` handles it.
- String interpolation `s!"...{x}..."` collides with Mathlib's `{...}` set
  notation when braces nest. Use `++` when emitting LaTeX.
- **A docstring is published prose.** `argdoc` and `argtex` render every module
  and declaration docstring in `arguments/TestimonyArguments/` into the site and the PDF,
  Markdown and all. Write them for a reader, and remember that a change to one
  makes both generated files stale.
- **Display math in generated Markdown goes inside a `<div>`.** mdBook runs
  Markdown over the page before MathJax sees it, and `\\` (a row break in
  `aligned`) is also Markdown's escape character, so a naked display block is
  silently mangled rather than failing. A raw-HTML block is passed through
  untouched — but only as far as the first blank line, so a display formula must
  contain none, and the legend table's wrapping `<div>` must be followed by one
  so its table is read as Markdown. A derivation avoids display math altogether:
  it is a Markdown list of inline formulas inside such a `<div>`, as
  `Testimony.Logic.Markdown` explains.
