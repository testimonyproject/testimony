import Testimony.Checks.Fallacies

/-!
# Testimony.Checks.Maturity — how far each argument is checked

The checks of meaning, of the shared ontology and of fallacies run over every
argument, and each can only do anything with what has been analysed. A claim
whose meaning is not analysed gives the ontology nothing to join, and a line of
reason touching such a claim is not read by the fallacy checks at all. So a
build that passes says less about one argument than another, and nothing on
the site said how much less.

This module counts, for every argument under a namespace, what those checks
reach: how many of its claims have analysed meanings, how many of its lines of
reason the fallacy checks read and what they found there, and how many joins its
meanings have under the shared ontology. `derive_maturity_table` writes the
counts down as data, at build time, so a generator can set them as a page. The
counts are the checks' own, by the same functions, so the page cannot say a
check reaches further than it does.
-/

namespace Testimony.Checks

open Lean Elab Command Meta Testimony.Semantics Testimony.Logic

/-- What the checks reach in one argument. -/
structure Maturity where
  /-- The namespace the argument's claim type is declared in. -/
  argument : Name
  /-- The argument's name, as its meanings give it. -/
  title : String
  /-- How many of its claims have analysed meanings. -/
  analysed : Nat
  /-- How many claims it has. -/
  claims : Nat
  /-- How many lines of reason it has. -/
  lines : Nat
  /-- How many of them the fallacy checks read: those all of whose claims are
  analysed. -/
  read : Nat
  /-- Read lines a premise of which already asserts what they deliver. -/
  carrying : Nat
  /-- Read lines that need a word to keep its sense and do not say so. -/
  conditional : Nat
  /-- How many joins its meanings have under the shared ontology. -/
  joins : Nat
  /-- How many of those are found with no definition, from the meanings alone. -/
  bare : Nat
  /-- How many of the shared ontology's definitions bear on its claims. -/
  definitions : Nat
  deriving Inhabited, Repr

/-- **What the checks reach in one argument**, counted by the functions the
checks themselves use (`fallacyReport`, `ontologyReport`). Equivocation and
arguing from silence alone are not counted: a line that commits either fails the
build, so on any page generated from a passing build both are zero. -/
def maturityOf (α : Type) [HasMeanings α] [DecidableEq α] (argument : Name)
    (lines : List (Line α)) : Maturity :=
  let moves := lines.filterMap fun l =>
    (l.asMove? (α := α)).bind fun m => if m.statements.all Statement.analysed then some m
      else none
  let O := Testimony.Ontology.shared
  let (analysed, claims) := HasMeanings.coverage (α := α)
  { argument, title := HasMeanings.argument α, analysed, claims
  , lines := lines.length, read := moves.length
  , carrying := (moves.filter fun m => !m.carriers.isEmpty).length
  , conditional := (moves.filter fun m => !m.conditionalOn.isEmpty).length
  , joins := (HasMeanings.exclusions (α := α)).length + (HasMeanings.entailments (α := α)).length
  , bare := (HasMeanings.exclusionsUnder (α := α) []).length +
      (HasMeanings.entailmentsUnder (α := α) []).length
  , definitions := (O.filter fun d =>
      let (h, f) := HasMeanings.bearing (α := α) d.form
      h.length + f.length > 0).length }

/-- Generates `def <name> : List Maturity`, one entry for every argument whose
claim type is declared under `root`, counted at build time; see the module
docstring. Arguments are listed in order of their namespace. -/
def deriveMaturityTable (tableName : Ident) (root : Name) : CommandElabM Unit := do
  let env ← getEnv
  let mut types : Array Name := #[]
  let mut byType : Std.HashMap Name (Array Name) := {}
  for (name, info) in env.constants.toList do
    if name.isInternal then continue
    if isClaimType env name root then types := types.push name
    match lineClaimType? info.type with
    | some c => byType := byType.insert c ((byType.getD c #[]).push name)
    | none => pure ()
  let mut rows : Array Maturity := #[]
  for c in types.qsort (·.toString < ·.toString) do
    let names := (byType.getD c #[]).qsort (·.toString < ·.toString)
    let r? ← liftTermElabM do
      try
        let lineTy := mkApp (mkConst ``Testimony.Logic.Line) (mkConst c)
        let lst ← mkListLit lineTy (names.toList.map mkConst)
        let e ← mkAppOptM ``maturityOf
          #[some (mkConst c), none, none, some (toExpr c.getPrefix), some lst]
        some <$> unsafe evalExpr Maturity (mkConst ``Maturity) e
      catch _ => pure none
    match r? with
    | some m => rows := rows.push m
    | none => throwError m!"derive_maturity_table could not count {c}"
  if rows.isEmpty then
    throwError "derive_maturity_table found no argument under {root}"
  let terms ← rows.mapM fun m =>
    `(term| { argument := $(quote m.argument), title := $(quote m.title)
            , analysed := $(quote m.analysed), claims := $(quote m.claims)
            , lines := $(quote m.lines), read := $(quote m.read)
            , carrying := $(quote m.carrying), conditional := $(quote m.conditional)
            , joins := $(quote m.joins), bare := $(quote m.bare)
            , definitions := $(quote m.definitions) })
  elabCommand (← `(command|
    /-- What the checks reach in every argument, counted at build time. Generated
    by `derive_maturity_table`. -/
    def $tableName : List Maturity := [$terms,*]))

/-- `derive_maturity_table t under N` generates `def t : List Maturity`, what
the checks reach in every argument whose claim type is declared under `N`. -/
syntax (name := deriveMaturityTableCmd) "derive_maturity_table " ident " under " ident :
  command

elab_rules : command
  | `(derive_maturity_table $t under $root) => deriveMaturityTable t root.getId

namespace MaturityFixture

derive_maturity_table fixtureMaturity under Testimony.Checks.Fixture

/-- The fixture's counts, as the ontology and fallacy checks above report them:
one join, three lines, one of them read, and that one carrying its conclusion in
a premise. -/
example : fixtureMaturity.map (fun m => (m.lines, m.read, m.carrying, m.joins, m.bare)) =
    [(3, 1, 1, 1, 0)] := by decide

end MaturityFixture

end Testimony.Checks
