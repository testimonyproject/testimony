# Code map

Where to look for each kind of work, and what to leave unread. The library is large: the sola
fide argument alone is eighteen thousand lines, and the works the arguments cite are six
thousand more. Most tasks touch five or six files. This page names them, so that a contributor
or a Claude Code session can start without reading the rest.

Search before you read. `grep -n` for a claim's name, a result's name or a citation key finds
the one declaration you need in a file you need not open whole. The files marked *search, don't
read* below are long lists whose order tells you nothing.

## The three packages

| Package | Directory | What it holds |
|---|---|---|
| `Testimony` | `Testimony/` | the machinery: logic, provenance, vocabulary, solver, checks, generators |
| `TestimonyArguments` | `arguments/TestimonyArguments/` | the worked arguments, their meanings, checks and generators |
| `TestimonyExamples` | `examples/` | the grits case and the hello-world tutorial |

An argument's work is almost always in `arguments/`. The library changes when an argument needs
something the machinery cannot yet say: a new vocabulary word, a definition, a page item, a
check. Build the library first, then `arguments/`.

## One argument, file by file

A large argument is a directory, its files in dependency order. Sola fide is the fullest example.

| File | What it holds | How to use it |
|---|---|---|
| `SolaFide.lean` | the module docstring: the argument told to a reader | read whole |
| `SolaFide/Atoms.lean` | every claim, one constructor each, with its docstring | search, don't read |
| `SolaFide/Sources.lean` | the citation of every claim and step | search, don't read |
| `SolaFide/Lines.lean` | the steps and lines of reason shared by the chapters | search |
| `SolaFide/Packages.lean` | the positions | search |
| `SolaFide/Dispute.lean` | the main dispute: parties, defeat table, verdicts | read the docstring, search the rest |
| `SolaFide/<Chapter>.lean` | one chapter: its lines, positions, dispute, bundle, verdicts | read the one you are changing |
| `SolaFide/Results.lean` | the headline results | search |

The chapters of sola fide, in the order the story tells them: `WhatScriptureSays`,
`BeforeTrent`, `Reformation`, `TrentAnswers`,
`ReformersAnswer`; and the topic chapters `Gospel`, `Definition`, `James`, `JesusWords`,
`Johannine`, `Baptism`, `FaithAndCharity`, `Abraham`, `Verdict`, `Vulgate`, `Hearings`,
`Burdens`, `Ratings`. The other arguments follow the same layout with fewer files.

Beside each argument, in `arguments/TestimonyArguments/`:

| File | What it holds |
|---|---|
| `Meanings/<Argument>.lean` | what each claim means, the pinned coverage, and the pinned joins |
| `Checks/<Argument>.lean` | every library check run over the argument, each report pinned |
| `Attr.lean` | each argument's unfold set (`solaFideDefs` and the rest) |
| `Glossary.lean` | the English for every Greek and Hebrew word the arguments print (search) |
| `Works.lean` | every work the arguments cite beyond the library's own (search, don't read) |
| `Epistemologies.lean` | the rules each side professes about how we know |
| `Articles/` | published articles examined move by move |
| `Tools/Catalogue.lean` | which arguments exist and what each page is called |

## The machinery, by question

Each row is a question an encoding asks, and the one module that answers it. Its module
docstring is the manual; read that before the code.

| The question | Module |
|---|---|
| How do I write a claim, a position, a step? | `Testimony/Logic/Package.lean`, `Testimony/Logic/Line.lean` |
| How do I prove a position holds, or refute it? | `Testimony/Logic/Tactic.lean` |
| How is a claim cited and rated? | `Testimony/Provenance.lean` |
| Is the passage already named? | `Testimony/Scripture.lean` (search) |
| What can a claim's meaning say? | `Testimony/Semantics/Grammar.lean`, `Testimony/Semantics/Vocabulary.lean` |
| How are an argument's meanings and joins declared? | `Testimony/Semantics/Meaning.lean` |
| How does a definition join two claims? | `Testimony/Semantics/Ontology.lean`, and an article in `Testimony/Ontology/` |
| What kind of thing is a concept? | `Testimony/Ontology/Kinds.lean`, `Testimony/Semantics/Upper.lean` |
| How is a dispute declared with its verdicts? | `Testimony/Logic/Declare.lean` |
| Who defeats whom, and why? | `Testimony/Logic/Dispute.lean`, then `Testimony/Logic/Horn.lean` only if a cell fails |
| Where do two positions part? | `Testimony/Logic/Because.lean` |
| What must an opponent give up? | `Testimony/Logic/Burden.lean` |
| How is every reading of a claim answered? | `Testimony/Logic/Dilemma.lean` |
| How is an exchange told in order, with dates? | `Testimony/Logic/Bundle.lean` |
| Which fallacies are checked, and how? | `Testimony/Semantics/Fallacy.lean`, `Testimony/Semantics/Finding.lean` |
| Is a rating's dissent credible? | `Testimony/Logic/Credibility.lean` |
| How does a side say we know? | `Testimony/Logic/Epistemology.lean` |
| Which reading of a variant does a claim take? | `Testimony/Variants.lean`, `Testimony/Variants/Units.lean` |
| What does the Greek or Hebrew say at this verse? | `Testimony/Corpus/Greek.lean`, `Testimony/Corpus/Hebrew.lean` |
| How is a page item rendered in words? | `Testimony/Logic/Page.lean`, then `Markdown.lean` or `Latex.lean` |
| Why did the page leave a declaration out? | `Testimony/Tools/Pages.lean` |

Leave `Horn.lean`, `Certificate.lean`, `Solver.lean`, `Witness.lean` and `Compose.lean` closed
unless the task is the engine itself. An encoding never needs their internals: `declare_dispute`
and `declare_verdict` call them, and a wrong table or witness fails with a message that says
which cell.

## The checks, and the file each one points at

A failing check names what failed. The fix is almost always in the argument's own files, not in
the check.

| Check | Fails when | Fix it in |
|---|---|---|
| `#check_readers` | a reading cited to Scripture alone, or a step with no reader | `Sources.lean`: a reader, or a proposal |
| `#check_meanings` | an argument has no meanings, or unpinned joins | `Meanings/<Argument>.lean` |
| `#check_ontology` | a pinned count of what each definition does has moved | the pin, after reading what moved |
| `#check_fallacies`, `#check_conditions` | a line needs a word to keep its sense and does not say so | `Lines.lean`: state the condition as a premise |
| `#check_readings` | a claim inside a variant names no reading, or is rated above it | `Sources.lean`: the reading taken |
| `#check_verse_parts` | a part of a verse is not read from the Greek or Hebrew | the part's definition |
| `#check_refutations` | `establish` succeeds on a package the argument refutes | the package, or the refutation |
| `#check_coverage` | a check missed a namespace | `Checks.lean` |
| `#check_postulates` | a package cannot hold together with its meanings | the package, or a meaning that says too much |
| `L1`–`L13` | `scripts/testimony_lint.py`; each finding names its rule | the line it names |

## What is generated, and from where

Nothing under `docs/src/arguments/`, nor the bibliography, roadmap, maturity or summary pages,
nor anything under `docs/latex/`, is written by hand or committed. They are generated from the
docstrings by `scripts/generate-docs.sh`. To change what a page says, change the docstring.
The hand-written parts of the roadmap, maturity and summary pages are in `docs/templates/`.

## Commands for a quick loop

A full build of `arguments/` takes many minutes. While working on one module, build only it,
and run the gates in full once before committing:

```sh
cd arguments
lake build TestimonyArguments.SolaFide.James      # one module and what it imports
python3 ../scripts/testimony_lint.py TestimonyArguments/SolaFide/James.lean
```

Run one `lake build` at a time: two at once can corrupt each other's compiled files. The order of
the full gates is in [the style guide](./style-guide.md#the-four-tiers).
