import TestimonyArguments.Works
import Testimony.Tools.Bibliography

/-!
# bibgen — generate `references.bib` and the bibliography chapter

`lake exe bibgen`, run in `arguments/`, writes `references.bib` and
`docs/src/bibliography.md`, at the repository's root, from the library's
registry and the arguments' together (`TestimonyArguments.bibliography`).
`lake exe bibgen --check` fails CI if either is stale.
-/

/-- Entry point. -/
def main (args : List String) : IO UInt32 :=
  Testimony.Bib.generate TestimonyArguments.bibliography
    "Testimony/Bib/Works.lean and arguments/TestimonyArguments/Works.lean"
    "../references.bib" "../docs/src/bibliography.md" args
