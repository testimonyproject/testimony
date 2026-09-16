import Testimony.Logic.Entail
import Testimony.Provenance

/-!
# Testimony.Logic.Package — cited arguments and generated manifests

An `ArgumentPackage` bundles a named position's premises with the citation for
every atomic claim they are built from. `meta` is a **total function**: an
atomic proposition without a citation fails to compile, which is the same
enforcement `Source.primary` provides one layer up.

`manifest` is the assumption manifest README.md promises. It is *generated* from
the premises rather than maintained alongside them, so it cannot drift.
-/

namespace Testimony.Logic

open Testimony

variable {α : Type}

/-- Citation and classification for one atomic claim. -/
structure AtomMeta where
  /-- A prose statement of what the atom asserts. -/
  label : String
  /-- Whether the claim is textual, linguistic, historical, theological or
  interpretive. -/
  kind : PremiseKind
  /-- Who says so, where, and with what confidence. -/
  source : Source
deriving Repr

/-- The conjunction of a list of formulas. An empty conjunction is verum,
which Foundation defines as `⊥ ➝ ⊥`. Used to keep multi-premise inference
steps readable at the encoding site. -/
def conjOf : List (Formula α) → Formula α
  | [] => .imp .falsum .falsum
  | [φ] => φ
  | φ :: rest => .and φ (conjOf rest)

/-- A named position: its premises, its conclusion, and a citation for every
atom either mentions. -/
structure ArgumentPackage (α : Type) where
  /-- The position this package encodes, e.g. "Reformed". -/
  name : String
  /-- Citation and classification for every atom. Total, so nothing is
  uncited. -/
  cite : α → AtomMeta
  /-- What the position assumes. -/
  premises : List (Formula α)
  /-- What the position concludes. -/
  conclusion : Formula α
  /-- A name for the conclusion, used to tie it to a `FulfillmentCriterion`. -/
  conclusionLabel : String

namespace ArgumentPackage

/-- The distinct atoms the premises rest on. -/
def atoms [DecidableEq α] (pkg : ArgumentPackage α) : List α :=
  (pkg.premises.flatMap atomsOf).eraseDups

/-- The assumption manifest: every unproven premise the argument rests on, with
its classification and citation. Generated, never maintained. -/
def manifest [DecidableEq α] (pkg : ArgumentPackage α) : List AtomMeta :=
  (pkg.atoms).map pkg.cite

/-- The atoms this package grounds in scripture alone.

An argument from scripture that reads scripture a particular way, and cites only
scripture for that reading, is assuming part of what it sets out to show. These
are not forbidden, but a reader is entitled to see them listed. -/
def scriptureOnlyAtoms [DecidableEq α] (pkg : ArgumentPackage α) : List AtomMeta :=
  pkg.manifest.filter fun m => m.source.isScriptureOnly

/-- How many premises the package assumes. -/
def premiseCount (pkg : ArgumentPackage α) : Nat := pkg.premises.length

-- A `without` helper that filtered a premise out was tried and removed:
-- `List.filter` over a derived `DecidableEq (Formula α)` does not reduce in the
-- kernel, so `decide` proofs built on it fail and fall back to `sorryAx`. State
-- the reduced package explicitly instead — it reads better at the use site and
-- keeps the premise list visible.

end ArgumentPackage

/-- Under this package's premises, its conclusion follows. The shape of every
result in the library: *given premise package P, conclusion C follows*. -/
def Establishes (pkg : ArgumentPackage α) : Prop :=
  Entails pkg.premises pkg.conclusion

end Testimony.Logic
