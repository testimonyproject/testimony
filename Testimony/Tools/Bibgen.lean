import Testimony.Tools.Bibliography

/-!
# bibgen — generate `references.bib` and the bibliography chapter

Run `lake exe bibgen` to regenerate, or `lake exe bibgen --check` to verify the
committed files match the Lean source. CI runs the latter. The work is
`Testimony.Bib.generate`; this names the registry and the files.
-/

open Testimony.Bib

/-- Entry point. -/
def main (args : List String) : IO UInt32 :=
  generate registry "references.bib" "docs/src/bibliography.md" args
