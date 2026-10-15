import Testimony.Attr

/-!
# TestimonyArguments.Attr — the arguments' unfold sets

Each argument's proofs name the definitions they unfold as one set, tagged
where each definition is written: `@[solaFideDefs] def reformed ...`, then
`establish [solaFideDefs]`. Why a set and not a list is said in
`Testimony.Attr`, which declares the library's own. Lean will not let a module
use a simp set it declares itself, so the arguments' sets live here, in a module
every argument imports. Adding an argument means adding its set below, and to
`TestimonyArguments.Checks.unfoldSets`.
-/

/-- The definitions the sola fide proofs unfold. -/
register_simp_attr solaFideDefs

/-- The definitions the sola scriptura proofs unfold. -/
register_simp_attr solaScripturaDefs

/-- The definitions the born-of-a-virgin proofs unfold. -/
register_simp_attr bornOfAVirginDefs

/-- The definitions the born-in-Bethlehem proofs unfold. -/
register_simp_attr bornInBethlehemDefs

/-- The definitions the canonical-witness proofs unfold. -/
register_simp_attr canonicalWitnessDefs

/-- The definitions the Spirit-baptism proofs unfold. -/
register_simp_attr spiritBaptismDefs

-- `register_simp_attr` also declares a simproc set, named with a `_proc` suffix
-- the naming linter cannot see is generated.
attribute [nolint defsWithUnderscore] Parser.Attr.solaFideDefs_proc
  Parser.Attr.solaScripturaDefs_proc Parser.Attr.bornOfAVirginDefs_proc
  Parser.Attr.bornInBethlehemDefs_proc Parser.Attr.canonicalWitnessDefs_proc
  Parser.Attr.spiritBaptismDefs_proc
