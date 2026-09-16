import Testimony.Bib.Render

/-!
# bibgen — generate `references.bib` and the bibliography chapter

Run `lake exe bibgen` to regenerate, or `lake exe bibgen --check` to verify the
committed files match the Lean source. CI runs the latter, so adding an entry
without regenerating fails the build rather than letting the published
bibliography drift from the library.
-/

open Testimony.Bib

/-- Machine-readable BibTeX, for reference managers. -/
def bibPath : System.FilePath := "references.bib"

/-- The generated bibliography chapter of the documentation site. -/
def mdPath : System.FilePath := "docs/src/bibliography.md"

/-- Read a file, treating absence as empty so `--check` reports it as stale
rather than failing. -/
def readOrEmpty (p : System.FilePath) : IO String := do
  if ← p.pathExists then IO.FS.readFile p else pure ""

/-- Entry point. -/
def main (args : List String) : IO UInt32 := do
  let bib := bibtexFile registry
  let md := bibliographyMarkdown registry
  if args.contains "--check" then
    let mut stale := #[]
    for (path, want) in [(bibPath, bib), (mdPath, md)] do
      if (← readOrEmpty path) != want then
        stale := stale.push path
    if stale.isEmpty then
      IO.println s!"bibgen: {registry.length} entries; generated files are up to date"
      return 0
    for path in stale do
      IO.eprintln s!"bibgen: {path} is stale — run `lake exe bibgen` and commit the result"
    return 1
  else
    IO.FS.createDirAll "docs/src"
    IO.FS.writeFile bibPath bib
    IO.FS.writeFile mdPath md
    IO.println s!"bibgen: wrote {bibPath} and {mdPath} ({registry.length} entries)"
    return 0
