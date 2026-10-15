import Lean

/-!
# Testimony.Tools.Docs — what the documentation generators share

The generators that present a package's arguments to a reader — its pages, its
PDF, its status table — need the same two things, and neither is derivable
from the source.

**Which arguments there are, and what to call them.** An argument's title is
prose about what it argues from, and is not recoverable from the names of its
theorems. A package keeps one catalogue of them (a list of `Argument`), so that
adding an argument is one edit, and its generators `#guard` that every
namespace carrying a result appears in it.

**How a statement is spelled.** A type pretty-printed from outside its own
namespace is spelled with the namespace in front, `SolaFide.reformed`; inside
the file it is `reformed`. Stripping the namespaces back off is what makes a rendered
statement match the source a reader would go on to open.
-/

namespace Testimony.Doc

open Lean

/-- One worked argument, as the generated documentation presents it. -/
structure Argument where
  /-- The namespace its declarations live in. -/
  ns : Name
  /-- The generated page's file name under `docs/src/arguments/`, without the
  extension. -/
  slug : String
  /-- The heading it appears under. Editorial, and deliberately so: *why* an
  argument is worth making is not derivable from its statements. -/
  title : String
deriving Inhabited, Repr


/-- Namespaces every statement is spelled with, whichever argument it belongs
to. An argument's own namespace is not listed here — it is taken from the
declaration, so a new argument needs no entry. -/
def sharedPrefixes : List String :=
  [ "Testimony.Logic.", "Testimony.People.", "Testimony.", "Logic.", "People." ]

/-- The longest namespace two names share, component by component. -/
def commonPrefix (a b : Name) : Name :=
  let rec go : List String → List String → Name → Name
    | x :: xs, y :: ys, acc => if x == y then go xs ys (acc.str x) else acc
    | _, _, acc => acc
  go (a.components.map (·.toString)) (b.components.map (·.toString)) .anonymous

/-- Strip the namespaces from a pretty-printed statement, so that it reads as
it does in the source file rather than as the pretty-printer spells it from
outside the argument's namespace.

`within` is the namespace the statement was printed in: the pretty-printer
shortens a name by the namespaces it shares with it, so a package built on the
library, harvesting from its own namespace, passes that.

The argument's own namespace comes first and in both forms — fully qualified,
and as the pretty-printer shortens it inside `within` — because
`sharedPrefixes` would otherwise eat a `Testimony.` in front of it and leave
the rest of the namespace standing. -/
def stripNamespaces (ns : Name) (s : String) (within : Name := `Testimony.Doc) : String :=
  let qualified := ns.toString ++ "."
  let shortened := (ns.replacePrefix (commonPrefix ns within) .anonymous).toString ++ "."
  (qualified :: shortened :: sharedPrefixes).foldl (fun acc p => acc.replace p "") s

end Testimony.Doc
