import Testimony.Tools.Pages
import Testimony.Tools.Site

/-!
# argdoc — publish each argument as a page of the documentation site

`lake exe argdoc` writes `docs/src/arguments/<slug>.md` for every argument in
the catalogue, and splices the list of them into the marked block of
`docs/src/SUMMARY.md`. The pages are harvested by `Testimony.Tools.Pages` and
set by `Testimony.Tools.Site`; what lives here is which arguments, and where.

```sh
lake exe argdoc            # rewrite docs/src/arguments/ and the SUMMARY block
lake exe argdoc --check    # verify the committed pages match the source
```
-/

open Testimony.Doc

/-- Where the library's pages go. -/
def site : Site :=
  { tool := "argdoc", pagesDir := "docs/src/arguments", summaryPath := "docs/src/SUMMARY.md" }

/-- Entry point. -/
def main (args : List String) : IO UInt32 := site.run arguments bodies args
