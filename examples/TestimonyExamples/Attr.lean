import Testimony.Attr

/-!
# TestimonyExamples.Attr — the examples' unfold sets

Each case's proofs name the definitions they unfold as one set, tagged where
each definition is written, as the library's arguments do
(`Testimony.Attr`). Lean will not let a module use a simp set it declares
itself, so the sets live here, in a module every case imports.
-/

/-- The definitions the grits case's proofs unfold. -/
register_simp_attr gritsDefs

-- `register_simp_attr` also declares a simproc set, named with a `_proc` suffix
-- the naming linter cannot see is generated.
attribute [nolint defsWithUnderscore] Parser.Attr.gritsDefs_proc
