import Lean

/-!
# Testimony.Tools.Docs — what the documentation generators share

Two tools present the library's own declarations to a reader: `statusgen`
writes the roadmap's status table, and `argdoc` writes the argument pages. They
need the same two things, and neither is derivable from the source.

**Which arguments there are, and what to call them.** An argument's title is
prose about what it argues from — "Born of a virgin — Isaiah 7:14, Genesis
3:15, Micah 5:2–3" is not recoverable from the names of its theorems. The list
lives here once so that adding an argument is one edit rather than two, and
both tools `#guard` that every namespace carrying a result appears in it.

**How a statement is spelled.** A type pretty-printed from outside its own
namespace is spelled `Testimony.Arguments.SolaFide.reformed`; inside the file
it is `reformed`. Stripping the namespaces back off is what makes a rendered
statement match the source a reader would go on to open.
-/

namespace Testimony.Doc

open Lean

/-- One worked argument, as the generated documentation presents it. -/
structure Argument where
  /-- The namespace its declarations live in, e.g.
  `Testimony.Arguments.SolaScriptura`. -/
  ns : Name
  /-- The generated page's file name under `docs/src/arguments/`, without the
  extension. -/
  slug : String
  /-- The heading it appears under. Editorial, and deliberately so: *why* an
  argument is worth making is not derivable from its statements. -/
  title : String
deriving Inhabited, Repr

/-- Every argument the documentation presents, in the order it presents them.

Every namespace carrying a `@[headline]` result must appear here. Both
generators `#guard` it, so adding an argument cannot silently omit it from the
roadmap's table or from the argument pages. -/
def arguments : List Argument :=
  [ { ns := `Testimony.Arguments.BornInBethlehem
    , slug := "born-in-bethlehem"
    , title := "Born in Bethlehem — Micah 5:2" }
  , { ns := `Testimony.Arguments.BornOfAVirgin
    , slug := "born-of-a-virgin"
    , title := "Born of a virgin — Isaiah 7:14, Genesis 3:15, Micah 5:2–3" }
  , { ns := `Testimony.Arguments.SolaFide
    , slug := "sola-fide"
    , title := "Sola fide" }
  , { ns := `Testimony.Arguments.CanonicalWitness
    , slug := "canonical-witness"
    , title := "The canonical witness — faith alone, from the texts all parties accept" }
  , { ns := `Testimony.Arguments.SolaScriptura
    , slug := "sola-scriptura"
    , title := "Sola scriptura" } ]

/-- Namespaces every statement is spelled with, whichever argument it belongs
to. An argument's own namespace is not listed here — it is taken from the
declaration, so a new argument needs no entry. -/
def sharedPrefixes : List String :=
  [ "Testimony.Logic.", "Testimony.People.", "Testimony.", "Logic.", "People." ]

/-- Strip the namespaces from a pretty-printed statement, so that it reads as
it does in the source file rather than as the pretty-printer spells it from
outside the argument's namespace.

The argument's own namespace comes first and in both forms — fully qualified,
and as the pretty-printer shortens it inside `Testimony` — because
`sharedPrefixes` would otherwise eat the `Testimony.` in front of it and leave
`Arguments.BornOfAVirgin.christian` standing. -/
def stripNamespaces (ns : Name) (s : String) : String :=
  let qualified := ns.toString ++ "."
  let shortened := (qualified.splitOn "Testimony.").getLast!
  (qualified :: shortened :: sharedPrefixes).foldl (fun acc p => acc.replace p "") s

end Testimony.Doc
