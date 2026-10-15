import TestimonyArguments.Tools.Pages
import Testimony.Tools.Site

/-!
# argdoc — publish each argument as a page of the documentation site

`lake exe argdoc`, run in `arguments/`, writes `docs/src/arguments/<slug>.md`
for every argument in the catalogue and splices the list of them into the
marked block of `docs/src/SUMMARY.md`, at the repository's root. The pages are
harvested by `TestimonyArguments.Tools.Pages` and set by the library's
`Testimony.Tools.Site`; what lives here is which arguments, and where.

```sh
lake exe argdoc            # rewrite docs/src/arguments/ and the SUMMARY block
lake exe argdoc --check    # verify the committed pages match the source
```
-/

open Testimony.Doc TestimonyArguments.Doc

/-- Where the arguments' pages go, from this package's directory. -/
def site : Site :=
  { tool := "argdoc", sourceRoot := "arguments/"
  , pagesDir := "../docs/src/arguments", summaryPath := "../docs/src/SUMMARY.md" }

/-- Entry point. -/
def main (args : List String) : IO UInt32 := site.run arguments bodies args
