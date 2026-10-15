import TestimonyArguments
import Testimony.Tools.Status
import TestimonyArguments.Tools.Catalogue

/-!
# statusgen — generate the roadmap's status table from the Lean source

`lake exe statusgen`, run in `arguments/`, writes every `@[headline]` result of
the arguments into the marked block of `docs/src/roadmap.md`, at the
repository's root, with the library's `Testimony.Tools.Status`; `--check` fails
CI when the committed copy is stale.

This module imports the package's root rather than the argument modules one by
one. A missing import would simply mean fewer results, silently, and the
`#guard` below could not see the gap it is meant to catch.

```sh
lake exe statusgen            # rewrite the generated block in docs/src/roadmap.md
lake exe statusgen --check    # verify the committed block matches the source
```
-/

open Testimony Testimony.Doc Testimony.Status TestimonyArguments.Doc

namespace TestimonyArguments.Status

derive_headline_table headlines under TestimonyArguments

/-- The arguments the table presents, in order, with the heading each appears
under: the catalogue `argdoc` reads too. Every namespace carrying a headline
result must appear in it — the `#guard` below fails the build otherwise. -/
def sections : List Argument := arguments

#guard !headlines.isEmpty
#guard headlines.all fun h => sections.any fun a => a.ns == h.argument

end TestimonyArguments.Status

/-- Entry point. -/
def main (args : List String) : IO UInt32 :=
  run "../docs/src/roadmap.md" TestimonyArguments.Status.sections
    TestimonyArguments.Status.headlines args
