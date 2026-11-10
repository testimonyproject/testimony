## What this changes

<!-- One or two plain sentences. If a result's verdict moved, say so first. -->

## What it claims, and what it does not

<!-- As a result's docstring does: the claim, then its limits. -->

## For the reader

<!-- Which pages change, and what a lay reader with an English Bible will now
     find there. "None" if the change is to the machinery only. -->

## Checks run

- [ ] `lake build`, `lake lint`, `lake exe axiom-audit` (library)
- [ ] `python3 scripts/testimony_lint.py`
- [ ] the same three in `arguments/`, and `scripts/kernel-replay.sh`
- [ ] `bibgen`, `statusgen`, `argdoc`, `argtex`, each with `--check`
- [ ] read the generated page, not only the docstring
      (`docs/src/writing-for-readers.md`)

## Sources

<!-- New citations, and how each identifier and quotation was verified.
     "None" if none. -->
