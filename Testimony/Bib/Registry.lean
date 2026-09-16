import Testimony.Bib.Works

/-!
# Testimony.Bib.Registry — invariants over the collected bibliography

The checks here run at elaboration time. A duplicate citation key, a dangling
`editionUsed` reference, or a malformed key fails the build rather than
producing a quietly broken `references.bib`.
-/

namespace Testimony.Bib

/-- Every citation key in the registry. -/
def registryKeys : List CiteKey := registry.map BibEntry.key

/-- Whether all citation keys are distinct. Two entries sharing a key would
silently collide in `references.bib` and in any reference manager importing it. -/
def keysUnique : Bool := registryKeys.eraseDups.length == registryKeys.length

/-- Whether a citation key is well formed: lowercase alphanumeric segments
separated by single hyphens, conventionally `family-shorttitle-year`. -/
def keyWellFormed (k : CiteKey) : Bool :=
  let parts := k.splitOn "-"
  !parts.isEmpty && parts.all fun p => !p.isEmpty && p.all fun c => c.isLower || c.isDigit

/-- Whether every key in the registry is well formed. -/
def keysWellFormed : Bool := registryKeys.all keyWellFormed

/-- Whether every ancient work's `editionUsed` names an entry that exists.
A dangling edition reference would render a citation that cannot be followed. -/
def editionsResolve : Bool :=
  registry.all fun e =>
    match e.editionUsed with
    | none => true
    | some k => registryKeys.contains k

/-- Entries carrying no stable public identifier. Not an error — a
nineteenth-century commentary reprint may genuinely have none — but the
bibliography marks them, so the gap is visible rather than silent. -/
def unverifiedEntries : List CiteKey :=
  (registry.filter fun e => !e.isVerifiable).map BibEntry.key

#guard !registry.isEmpty
#guard keysUnique
#guard keysWellFormed
#guard editionsResolve

end Testimony.Bib
