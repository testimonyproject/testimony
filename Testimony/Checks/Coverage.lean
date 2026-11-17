import Lean

/-!
# Testimony.Checks.Coverage — which namespaces each check has been run under

A package runs the library's checks over its arguments, and pins each report
with `#guard_msgs`, so that a change in what a check finds is a change a
reviewer sees. Run once over the whole package, every report is one block of
text, and every pull request that adds a package, a line or a definition to any
argument edits that block. Two pull requests on two different arguments then
conflict there, although neither touches the other's work.

So a package may run each check once for each argument, under the argument's
own namespace, and pin each report beside the argument it is about. What a
whole-package run gave for free, that an argument added tomorrow is checked
tomorrow, is then a separate fact, and this module records what it needs. Each
check notes the namespace it was run under (`recordChecked`), and
`#check_coverage`, in `Testimony.Checks.Covered`, fails the build if anything a
check would examine under a package's namespace lies under no namespace that
check was run under.

The record is an environment extension, so it is carried through imports: the
checks may run in as many modules as the package likes, and the module that
asks for coverage imports them all.
-/

namespace Testimony.Checks

open Lean Elab Command

/-- The namespaces each check has been run under, as pairs of the check's name
and the namespace, gathered from every imported module and this one. -/
initialize checkedRootsExt :
    SimplePersistentEnvExtension (Name × Name) (Array (Name × Name)) ←
  registerSimplePersistentEnvExtension {
    addEntryFn := Array.push
    addImportedFn := fun mods => mods.foldl (· ++ ·) #[] }

/-- Record that the check `kind` has been run, and passed, under `root`. -/
def recordChecked (kind root : Name) : CommandElabM Unit :=
  modifyEnv (checkedRootsExt.addEntry · (kind, root))

/-- The namespaces the check `kind` has been run under. -/
def checkedRoots (env : Environment) (kind : Name) : Array Name :=
  (checkedRootsExt.getState env).filterMap fun (k, r) => if k == kind then some r else none

end Testimony.Checks
