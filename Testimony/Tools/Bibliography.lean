import Testimony.Bib.Render

/-!
# Testimony.Tools.Bibliography — `references.bib` and the bibliography chapter

Both files are generated from a registry of `@[bib_entry]` declarations, and a
check fails CI when a committed copy has drifted from it, so adding an entry
without regenerating fails the build rather than letting the published
bibliography fall behind. `bibgen` is this, run over the library's registry
and its arguments' together.
-/

namespace Testimony.Bib

/-- A generated file's committed contents, or nothing if there is none, so that
a check reports a missing file as stale rather than failing. -/
def readCommitted (p : System.FilePath) : IO String := do
  if ← p.pathExists then IO.FS.readFile p else pure ""

/-- **Write `references.bib` and the bibliography chapter from a registry, or
check them**: with `--check`, report each stale file and fail; otherwise write
both. `source` names the files the entries are written in. Returns the exit
code. -/
def generate (registry : List BibEntry) (source : String) (bibPath mdPath : System.FilePath)
    (args : List String) : IO UInt32 := do
  let bib := bibtexFile registry source
  let md := bibliographyMarkdown registry source
  if args.contains "--check" then
    let mut stale := #[]
    for (path, want) in [(bibPath, bib), (mdPath, md)] do
      if (← readCommitted path) != want then
        stale := stale.push path
    if stale.isEmpty then
      IO.println s!"bibgen: {registry.length} entries; generated files are up to date"
      return 0
    for path in stale do
      IO.eprintln s!"bibgen: {path} is stale — run `lake exe bibgen` and commit the result"
    return 1
  else
    if let some dir := mdPath.parent then IO.FS.createDirAll dir
    IO.FS.writeFile bibPath bib
    IO.FS.writeFile mdPath md
    IO.println s!"bibgen: wrote {bibPath} and {mdPath} ({registry.length} entries)"
    return 0

end Testimony.Bib
