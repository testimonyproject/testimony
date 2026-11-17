# TestimonyArguments

The worked arguments, in a package built on the [Testimony](../README.md)
library.

The library is the machinery: the logic, the provenance types, the vocabulary
and its ontology, the solver, the checks and the generators. This package is
what the documentation presents — born in Bethlehem, born of a virgin, sola
fide, the canonical witness, sola gratia, sola scriptura, Spirit baptism, and
the published articles examined against them. It requires the library as a Lake dependency,
imports it, and changes nothing in it; the library imports nothing from here.

## Building

Build the library first, from the repository root. This package shares the
library's downloaded dependencies (`packagesDir` in `lakefile.toml`) and reuses
its build, so nothing is fetched or compiled twice. Its `lean-toolchain` pins the
same Lean as the library's, and must be moved with it.

```sh
lake exe cache get && lake build      # at the repository root: the library
cd arguments
lake build                            # every argument, and the library's checks over them
```

The gates are the library's, run here:

```sh
lake build                                         # tier 1, and the checks in Checks.lean
lake lint                                          # tier 2
lake exe axiom-audit                               # tier 3
../scripts/kernel-replay.sh TestimonyArguments bibgen argtex statusgen argdoc
```

Tier 4, the domain linter, runs from the repository root, where it reads every
package: `python3 scripts/testimony_lint.py`.

## The generated files

This package's generators write the documentation's generated files, at the
repository's root. None of them is committed: `.gitignore` keeps them out, and
`scripts/generate-docs.sh` runs every generator, these and the examples', for
the site, the PDFs and each pull request's preview.

```sh
lake exe bibgen       # references.bib and docs/src/bibliography.md
lake exe argdoc       # docs/src/arguments/*.md, and docs/src/SUMMARY.md from its template
lake exe statusgen    # docs/src/roadmap.md and docs/src/maturity.md, from their templates
lake exe argtex       # docs/latex/arguments.tex, and each argument in docs/latex/arguments/
```

The templates, in `docs/templates/`, hold each page's hand-written prose around
an empty generated block. Each generator takes `--check`, which reports whether
what is on disk is current. Never edit what they write: change the docstring,
and regenerate.

## Where things are

| Path | Contents |
|---|---|
| `TestimonyArguments/<Argument>` | each argument; over ~500 lines a directory (`Atoms`, `Sources`, `Lines`, `Packages`, `Results`) |
| `TestimonyArguments/Meanings/` | what each argument's claims mean, and its pinned joins |
| `TestimonyArguments/Articles/` | published articles examined against the arguments |
| `TestimonyArguments/Works.lean` | the works the arguments cite beyond the library's |
| `TestimonyArguments/Attr.lean` | each argument's unfold set |
| `TestimonyArguments/Checks/` | the library's checks, one module per argument, each report pinned beside it |
| `TestimonyArguments/Checks.lean` | the citations check, and `#check_coverage`: every check reaches every argument |
| `TestimonyArguments/Tools/` | the catalogue of arguments, the harvest, and the four generators |

A new argument adds its unfold set to `Attr.lean`, a module of its checks to
`Checks/` (copy another's, and paste in the reports the build prints), imported
by `Checks.lean`, and its title to the catalogue in `Tools/Catalogue.lean`. The
library's guide, [Encoding arguments](../docs/src/logic.md), says how to write
one.
