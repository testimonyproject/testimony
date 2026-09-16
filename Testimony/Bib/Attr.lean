import Lean
import Testimony.Bib.Core

/-!
# Testimony.Bib.Attr — the `@[bib_entry]` attribute and registry derivation

Bibliography entries are defined as named `def`s and tagged `@[bib_entry]`. The
registry is then *collected* rather than hand-maintained, so it cannot drift out
of step with the entries that exist.

`derive_bib_registry` reads the tag attribute's local state, which means it must
be invoked in the same module that defines the entries. That is a deliberate
constraint rather than a limitation: it keeps the collection logic trivial, and
one file of entries is the intended shape anyway.
-/

open Lean Elab Command

namespace Testimony.Bib

/-- Marks a `BibEntry` definition for inclusion in the bibliography registry.
An entry without this tag is invisible to `bibgen`, and so would be silently
absent from `references.bib`; `scripts/testimony_lint.py` rule L4 rejects an
untagged entry. -/
initialize bibEntryAttr : TagAttribute ←
  registerTagAttribute `bib_entry
    "include this BibEntry in the bibliography registry"

/-- Generates `def <name> : List BibEntry` listing every `@[bib_entry]`
declaration in the current module, sorted by declaration name so the output is
deterministic.

Reads the tag attribute's *local* state, so it must be invoked in the module
that defines the entries — see the module docstring. -/
elab "derive_bib_registry " name:ident : command => do
  let env ← getEnv
  let names : Array Name := (bibEntryAttr.ext.getState env).toArray
  let sorted : Array Name := names.qsort (fun a b => a.toString < b.toString)
  let terms : Array Ident := sorted.map mkIdent
  let stx ← `(command| def $name : List BibEntry := [$terms,*])
  elabCommand stx

end Testimony.Bib
