import Testimony.Logic.Certificate
import Testimony.Logic.Map
import Testimony.Logic.Verdict
import Testimony.Logic.Tactic

/-!
# Testimony.Logic.Declare — a dispute and its verdicts, declared as data

A dispute written out by hand is mostly the same code each time. Once its
parties' packages are named, everything else follows by rule: the `Dispute`
itself, whose fields are proved the same way for every argument; each party's
weakest link, written as a table and checked; each party's clauses, prepared
once; the defeat, support and part-of tables, each proved cell by cell by the
kernel; the dispute in the solver's form; and its map. Each verdict, likewise,
was two declarations stating one fact: a `Verdict` holding the witness, and a
theorem restating what the witness shows.

What is not boilerplate is the data: who the parties are, which package each
argues from, and the three tables. The commands here take that, and only that,
and generate the rest.

```
/-- The dispute over the procession. -/
declare_dispute processionDispute := partyNode using trinityDefs
  /-- Who defeats whom: one standoff. -/
  defeats [(.western, .eastern), (.eastern, .western)]
  /-- Whose case is part of whose, besides each party's own. -/
  partOf [(.lst, .western), (.lst, .eastern)]
  /-- The dispute drawn. -/
  map processionMap

/-- Why the West can be defended: with LST, it answers the East itself. -/
declare_verdict westernWithTheTexts for processionDispute : .credulous .western [.lst, .western]
  /-- **The Western position can be defended.** -/
  proves @[headline] western_defensible
```

The tables are data in the plain sense: lists of pairs, written where a reader
can see them, and the statement of each table theorem is that list. Nothing is
trusted because it was written. Every cell is still decided and checked by the
kernel (`horn_certify`), so a wrong table does not build, and the generated
declarations are the ones a dispute written by hand would have: the page
generator renders them exactly as before.

## What `declare_dispute` generates

For `declare_dispute D := node using set`, with `node : ι → ArgumentPackage α` and `ι`
an enumeration:

- `D : Dispute α ι`, tagged with `set`. Each party is shown consistent by
  `horn_certify`; each is shown sound by the theorem `P_establishes` when its
  package is a definition `P` and that theorem exists, and by
  `establish [set]` otherwise; each has its steps rated.
- `D.strength : ι → ℕ`, each party's weakest link, computed when the command
  runs and written as a literal, and `D.node_strength`, checked by the kernel.
- `D.clauses`, each party's position as clauses (`prepare_clauses`).
- `D_defeats : ∀ i j, D.defeats i j ↔ (i, j) ∈ [...]`, the table as given.
- `D.finite : Solver.Finite D.defeats`, the parties in declaration order.
- `D_supports`: `∀ i j, ¬ D.supports i j` when no `supports` table is given,
  and the table otherwise.
- `D_partOf : ∀ i j, D.partOf i j ↔ i = j ∨ (i, j) ∈ [...]`. Every case is part
  of itself, so the table lists only the other pairs.
- With `map M`, `M : ArgumentMap D`.

Each table, and the map, may carry a docstring of its own, which is what its
page says; without one it gets a plain description.

## What `declare_verdict` generates

For `declare_verdict V for D : c` followed by `proves T`, the declarations `V : Verdict
D`, with the witness `c` checked by the kernel against `D.finite`, and the
theorem `T`, whose statement is what `c` claims, as `Claim.Holds` states it:
`CredulouslyAccepted D.defeats .western`, `grounded D.defeats = toSet [...]`,
and so on. Attributes written before `T`, `@[headline]` among them, are applied
to it.
-/

namespace Testimony.Logic.Declare

open Lean Elab Command Term Meta

/-- The constructors of an enumeration, in declaration order. -/
def enumCtors (ty : Expr) : MetaM (Name × Array Name) := do
  let .const n [] := ty | throwError "dispute: {ty} is not an enumeration"
  let some (.inductInfo i) := (← getEnv).find? n | throwError "dispute: {n} is not an inductive"
  for c in i.ctors do
    let some (.ctorInfo ci) := (← getEnv).find? c | throwError "dispute: {c}?"
    unless ci.numFields == 0 do
      throwError "dispute: the parties must be an enumeration, and {c} takes arguments"
  return (n, i.ctors.toArray)

/-- A docstring, as the syntax a declaration carries. -/
def docOf (s : String) : TSyntax ``Lean.Parser.Command.docComment :=
  ⟨mkNode ``Lean.Parser.Command.docComment #[mkAtom "/--", mkAtom (s ++ " -/")]⟩

/-- The package a party argues from, when it is a named definition: `node c`,
unfolded once and its match reduced, is a constant. -/
def packageName? (node : Expr) (c : Name) : MetaM (Option Name) := do
  let e := mkApp node (mkConst c)
  let e ← match ← unfoldDefinition? e with
    | some e => whnfCore e
    | none => whnfCore e
  return e.constName?

/-- Where a clause of a command is written: its docstring, if it has one, through
its last token. Each declaration a command generates is placed at the clause it
comes from, so a page lists them in the order the source does. -/
def clauseRef (doc? : Option (TSyntax ``Lean.Parser.Command.docComment)) (stx : Syntax) :
    Syntax :=
  mkNullNode (doc?.toArray.map (·.raw) ++ #[stx])

/-- Whether a table was written as the empty list. -/
def isEmptyList (stx : Term) : Bool :=
  match stx with
  | `([]) => true
  | _ => false

/-- `declare_dispute D := node using set`, then the tables: see the module
docstring. The words inside it are not reserved, so `defeats`, `supports`,
`partOf` and `map` stay free as names everywhere else. -/
syntax (name := disputeCmd) (docComment)? "declare_dispute " ident " := " term
  &" using " ident
  ppIndent(ppLine (docComment)? &"defeats " term:max)
  ppIndent((ppLine (docComment)? &"supports " term:max)?)
  ppIndent((ppLine (docComment)? &"partOf " term:max)?)
  ppIndent((ppLine (docComment)? &"map " ident)?) : command

/-- `declare_verdict V for D : claim`, then `proves T`: see the module
docstring. -/
syntax (name := verdictCmd) (docComment)? "declare_verdict " ident &" for " ident " : " term
  ppIndent(ppLine (docComment)? &"proves " (Lean.Parser.Term.attributes)? ident) : command

elab_rules : command
  | `($[$doc?]? declare_dispute $d:ident := $node using $set:ident
      $[$defeatsDoc?]? defeats $defeats
      $[$[$supportsDoc?]? supports $supports?]?
      $[$[$partOfDoc?]? partOf $partOf?]?
      $[$[$mapDoc?]? map $map?]?) => do
    -- What the node function is over: the parties, and the claims.
    let (ιName, αName, parties, strengths, sounds) ← liftTermElabM do
      let nodeE ← elabTerm node none
      synthesizeSyntheticMVarsNoPostponing
      let nodeE ← instantiateMVars nodeE
      let nodeTy ← whnfR (← inferType nodeE)
      let .forallE _ ι pkgTy _ := nodeTy
        | throwError "dispute: {node} is not a function from parties to packages"
      let pkgTy ← whnfR pkgTy
      unless pkgTy.isAppOfArity ``ArgumentPackage 1 do
        throwError "dispute: {node} does not give an argument package"
      let α := pkgTy.appArg!
      let (ιName, parties) ← enumCtors ι
      let some αName := α.constName? | throwError "dispute: the claims {α} are not a type name"
      -- Each party's weakest link, computed now and checked by the kernel below.
      let strengths ← parties.mapM fun c => do
        let s ← mkAppM ``ArgumentPackage.strength #[mkApp nodeE (mkConst c)]
        unsafe evalExpr Nat (mkConst ``Nat) s
      -- Each party's soundness, from the theorem its package already has, if any.
      let sounds ← parties.mapM fun c => do
        let some pkg ← packageName? nodeE c | return none
        let thm := pkg.appendAfter "_establishes"
        return if (← getEnv).contains thm then some thm else none
      return (ιName, αName, parties, strengths, sounds)
    let ι := mkCIdent ιName
    let α := mkCIdent αName
    let ctorIds := parties.map mkCIdent
    let ctorTerms : Array Term := ctorIds.map fun c => ⟨c.raw⟩
    let soundRhs : Array Term ← (sounds.zip ctorIds).mapM fun (s?, _) =>
      match s? with
      | some thm => `($(mkCIdent thm))
      | none => `(by establish [$set:ident])
    let strengthRhs : Array Term := strengths.map fun n => ⟨(Syntax.mkNumLit (toString n)).raw⟩
    let name (suffix : String) : Ident := mkIdent (d.getId.appendAfter suffix)
    let dot (field : Name) : Ident := mkIdent (d.getId ++ field)
    let docD := doc?.getD (docOf s!"A dispute among the parties of `{ιName}`, declared by \
      `declare_dispute`: each party consistent, sound, and with its steps rated.")
    elabCommand (← `(command|
      $docD:docComment
      @[$set:ident] def $d : Dispute $α $ι where
        node := $node
        consistent i := Horn.satisfiable_of_certified (by cases i <;> horn_certify)
        sound i := match i with $[| $ctorTerms => $soundRhs]*
        rated i := by
          cases i <;> first
            | (simp [$set:ident]; done)
            | (simp [$set:ident, Line.asPackage]; done)))
    -- Each party's weakest link, as a table, and checked.
    elabCommand (← `(command|
      /-- Each party's weakest link, as its package computes it: `0` for `disputed`,
      up to `3` for `consensus`. Computed when the dispute was declared. -/
      def $(dot `strength) : $ι → ℕ := fun i => match i with $[| $ctorTerms => $strengthRhs]*))
    elabCommand (← `(command|
      /-- Each party's weakest link is what the table says, checked by the kernel. -/
      theorem $(dot `node_strength) :
          ∀ i, ($(d).node i).strength = $(dot `strength) i := by
        intro i; cases i <;> decide))
    elabCommand (← `(command| prepare_clauses $(dot `clauses) for $d))
    -- The defeat table.
    let n := parties.size
    let docDef := defeatsDoc?.getD (docOf s!"**Who defeats whom**, all {n * n} pairs: the \
      listed pairs and no others. Every cell is checked by the kernel.")
    withRef (clauseRef defeatsDoc? defeats) do elabCommand (← `(command|
      $docDef:docComment
      theorem $(name "_defeats") :
          ∀ i j, $(d).defeats i j ↔ (i, j) ∈ ($defeats : List ($ι × $ι)) := by
        intro i j
        refine Horn.defeats_iff_of_prepared ($(dot `node_strength) i) ($(dot `node_strength) j)
          ($(dot (`clauses ++ `spec)) i) ($(dot (`clauses ++ `spec)) j) ?_
        cases i <;> cases j <;> horn_certify))
    withRef (clauseRef defeatsDoc? defeats) do elabCommand (← `(command|
      /-- The dispute in the form the verdict solver computes with. -/
      def $(dot `finite) : Solver.Finite $(d).defeats where
        parties := [$ctorTerms,*]
        complete i := by cases i <;> decide
        defeats i j := decide ((i, j) ∈ ($defeats : List ($ι × $ι)))
        spec i j := by rw [$(name "_defeats"):ident]; simp))
    -- The support table.
    let supports := supports?.getD (← `([]))
    let supportsDoc := (supportsDoc?.bind id).getD (docOf s!"**Who supports whom**: \
      {if isEmptyList supports then "nothing supports anything" else "the listed pairs \
      and no others"}, in all {n * n} pairs. Every cell is checked by the kernel.")
    let supportsRef := match supports? with
      | some t => clauseRef (supportsDoc?.bind id) t
      | none => defeats.raw
    if isEmptyList supports then
      withRef supportsRef do elabCommand (← `(command|
        $supportsDoc:docComment
        theorem $(name "_supports") : ∀ i j, ¬ $(d).supports i j := by
          intro i j
          refine (supports_iff_of_certified (P := False) ?_).not.mpr id
          cases i <;> cases j <;> horn_certify))
    else
      withRef supportsRef do elabCommand (← `(command|
        $supportsDoc:docComment
        theorem $(name "_supports") :
            ∀ i j, $(d).supports i j ↔ (i, j) ∈ ($supports : List ($ι × $ι)) := by
          intro i j
          refine supports_iff_of_certified ?_
          cases i <;> cases j <;> horn_certify))
    -- The part-of table: every case is part of itself, and the listed pairs.
    let partOf := partOf?.getD (← `([]))
    let partOfDoc := (partOfDoc?.bind id).getD (docOf s!"**Whose case is part of whose**: \
      each party's of its own, {if isEmptyList partOf then "and of no other's" else "and \
      the listed pairs"}. Every cell is checked by the kernel.")
    let partOfRef := match partOf? with
      | some t => clauseRef (partOfDoc?.bind id) t
      | none => supportsRef
    withRef partOfRef do elabCommand (← `(command|
      $partOfDoc:docComment
      theorem $(name "_partOf") :
          ∀ i j, $(d).partOf i j ↔ i = j ∨ (i, j) ∈ ($partOf : List ($ι × $ι)) := by
        intro i j
        refine partOf_iff_of_certified ?_
        cases i <;> cases j <;> horn_certify))
    -- The map.
    if let some m := map? then
      let mapDoc := (mapDoc?.bind id).getD (docOf s!"The dispute drawn: who defeats \
        whom, who supports whom, and whose case is part of whose.")
      let supportsFn ← if isEmptyList supports then `(fun _ _ => false)
        else `(fun i j => decide ((i, j) ∈ ($supports : List ($ι × $ι))))
      let supportsSpec ← if isEmptyList supports then
          `(fun i j => by simp [$(name "_supports"):ident i j])
        else `(fun i j => by rw [$(name "_supports"):ident]; simp)
      withRef (clauseRef (mapDoc?.bind id) m) do elabCommand (← `(command|
        $mapDoc:docComment
        def $m : ArgumentMap $d where
          finite := $(dot `finite)
          supports := $supportsFn
          supports_spec := $supportsSpec
          partOf i j := decide (i = j ∨ (i, j) ∈ ($partOf : List ($ι × $ι)))
          partOf_spec i j := by rw [$(name "_partOf"):ident]; simp))

/-- What a claim's `Holds` says, unfolded to the statement a reader would write:
`Claim.Holds R (.credulous a s)` is `CredulouslyAccepted R a`, and the stages of a
grounded witness are flattened to the list of their parties. -/
def holdsStatement (holds : Expr) : MetaM Expr := do
  let some e ← unfoldDefinition? holds | throwError "verdict: cannot unfold {holds}"
  let e ← whnfCore e
  Meta.transform e (post := fun x => do
    if x.isAppOf ``List.flatten then return .done (← reduce x) else return .continue)

elab_rules : command
  | `($[$doc?]? declare_verdict $v:ident for $d:ident : $claim
      $[$thmDoc?]? proves $[$attrs?:attributes]? $t:ident) => do
    let docV := doc?.getD (docOf "A verdict, with the witness the kernel checks.")
    elabCommand (← `(command|
      $docV:docComment
      def $v : Verdict $d where
        finite := $(mkIdent (d.getId ++ `finite))
        claim := $claim
        checked := by decide +kernel))
    let ns ← getCurrNamespace
    let vName := ns ++ v.getId
    let tName := ns ++ t.getId
    liftTermElabM do
      let vE := Lean.mkConst vName
      let proof ← mkAppM ``Verdict.holds #[vE]
      -- `Verdict.holds v : Claim.Holds D.defeats v.claim`; read the claim back
      -- from the verdict, so the statement is the claim's and nothing else.
      let pty ← inferType proof
      let pty ← whnfR pty
      let claimE ← whnf (pty.appArg!)
      let holds := mkApp pty.appFn! claimE
      let ty ← instantiateMVars (← holdsStatement holds)
      addDecl <| .thmDecl { name := tName, levelParams := [], type := ty, value := proof }
      if let some doc := thmDoc? then
        addDocStringCore tName (← getDocStringText doc)
      else
        addDocStringCore tName s!"What `{v.getId}` shows, stated."
      addDeclarationRangesFromSyntax tName (clauseRef thmDoc? t) t
      if let some attrs := attrs? then
        let attrs ← elabAttrs attrs.raw[1].getSepArgs
        applyAttributes tName attrs

end Testimony.Logic.Declare
