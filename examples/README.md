# TestimonyExamples

Cases built on the [Testimony](../README.md) library, and not part of it.

Testimony is a library for stating arguments so that every premise is explicit,
cited and contestable, and for checking what follows from them. Its own
arguments are about Scripture. Nothing in its machinery is: a premise is a
cited claim, a position is a package of premises, and a dispute between
positions is weighed by their cited ratings. This package uses that machinery
for a case outside theology, as any package built on the library would.

It is a **strict user** of the library:

- it is its own Lake package, which requires `testimony` by path, as a
  dependency;
- it imports the library and changes nothing in it; the library does not
  import it, and its own documentation does not list it;
- its works, its unfold set, its checks and its documents are its own.

## The cases

| Case | Document | What it shows |
|---|---|---|
| [The grits](TestimonyExamples/Grits.lean), from *My Cousin Vinny* (1992) | `docs/latex/grits.tex` | Where a witness's five minutes breaks, and why the cross-examination did not stop at "I'm a fast cook" |

## Building

Build the library first, from the repository root, so that this package reuses
its build rather than compiling it again. Its `lean-toolchain` pins the same Lean
as the library's, and must be moved with it. This package shares the library's
downloaded dependencies (`packagesDir` in `lakefile.toml`), so nothing is
fetched twice.

```sh
lake exe cache get && lake build      # at the repository root: the library
cd examples
lake build                            # the cases, and the library's checks over them
lake exe exampletex                   # one LaTeX document per case, under docs/latex/
cd docs/latex && tectonic grits.tex   # ... and to PDF
```

The gates are the library's, run here:

```sh
lake build                                         # tier 1, and the checks in Checks.lean
lake lint                                          # tier 2
lake exe axiom-audit                               # tier 3
../scripts/kernel-replay.sh TestimonyExamples exampletex
lake exe exampletex --check                        # the documents are current
```

Tier 4, the domain linter, runs from the repository root, where it reads the
library and this package together: `python3 scripts/testimony_lint.py`.

## Where things are

| Path | Contents |
|---|---|
| `TestimonyExamples/Works.lean` | the works the cases cite that the library does not |
| `TestimonyExamples/Attr.lean` | each case's unfold set |
| `TestimonyExamples/Grits/` | the grits case: atoms, sources, positions, meanings, dispute |
| `TestimonyExamples/Checks.lean` | the library's checks, run over this package (`#check_aif under TestimonyExamples`, and the rest) |
| `TestimonyExamples/Tools/Exampletex.lean` | the document generator, built from the library's harvest |

How to write a case of your own is in the library's guide, *Beyond theology*
(`docs/src/beyond-theology.md`).
