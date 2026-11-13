import Testimony.Logic.Certificate
import Testimony.Logic.Map
import Testimony.Logic.Verdict
import Testimony.Logic.Tactic
import Testimony.Logic.Credibility

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
- `D.clauses`, each party's position as clauses (`prepare_clauses`), or with
  `pruned`, `D.parts`, its clauses and their components (`prepare_parts`), so
  that each cell is asked only of the components it touches.
- `D.defeatsTable`, the defeat table as a list, and `D_defeats : ∀ i j, D.defeats
  i j ↔ (i, j) ∈ [...]`, the table as given. With `rows N`, the table is proved
  `N` rows at a time, each within the time the checker allows.
- `D.finite : Solver.Finite D.defeats`, the parties in declaration order.
- When a `supports` or `partOf` table or a map is given: `D_supports`, either
  `∀ i j, ¬ D.supports i j` for an empty table or the table, and `D_partOf : ∀ i
  j, D.partOf i j ↔ i = j ∨ (i, j) ∈ [...]`. Every case is part of itself, so
  that table lists only the other pairs.
- With `map M`, `M : ArgumentMap D`.

Each table, and the map, may carry a docstring of its own, which is what its
page says; without one it gets a plain description.

## What `declare_verdict` generates

For `declare_verdict V for D : c` followed by `proves T`, the declarations `V : Verdict
D`, with the witness `c` checked by the kernel against `D.finite`, and the
theorem `T`, whose statement is what `c` claims, as `Claim.Holds` states it:
`CredulouslyAccepted D.defeats .western`, `grounded D.defeats = toSet [...]`,
and so on. Attributes written before `T`, `@[headline]` among them, are applied
to it. `proves T : type` keeps a statement written out, once the kernel agrees
it is the claim's. `using F` checks the witness against the solver form `F`
instead of `D.finite`. Without `proves`, only the verdict is declared, for a
theorem that does more than restate it.

## Hearings, and a register's standards

`declare_hearing H := D only [...]`, or `except [...]`, is the dispute with only
those parties heard, or with them set aside: `H := D.restrict P`, and its solver
form `H.finite`. A verdict about it is `declare_verdict V for H : ...`.

`declare_rerated R`, for a register `R` of the dispute `D`, takes the defeat
table under each standard as a function and generates what weighing `D` at each
standard's ratings needs (`Testimony.Logic.Credibility`): `R.strength`, each
party's weakest link under each standard, computed and checked; `R.defeatsTable`
and `R_defeats`, the tables proved cell by cell under every standard; `R.finite
s`, the solver form; and `R.under s`, the hearing under `s` in that form, which
a verdict names with `using`.
-/

namespace Testimony.Logic.Declare

/-- **A table and the function a solver form computes it with agree**, when one
decision over every pair of parties says so. `L` is the table as written, a list
of pairs; `f` matches on the pairs. The decision runs once in the kernel, where a
`decide` in each of the table's cells would run once per cell. -/
theorem table_spec {ι : Type} [DecidableEq ι] (ps : List ι) (complete : ∀ i, i ∈ ps)
    (L : List (ι × ι)) (f : ι → ι → Bool)
    (h : (ps.all fun i => ps.all fun j => decide ((i, j) ∈ L) == f i j) = true) :
    ∀ i j, (i, j) ∈ L ↔ f i j = true := by
  intro i j
  simp only [List.all_eq_true, beq_iff_eq] at h
  have := h i (complete i) j (complete j)
  by_cases hm : (i, j) ∈ L <;> simp_all

/-- The same for a part-of table, in which every case is part of itself. -/
theorem part_spec {ι : Type} [DecidableEq ι] (ps : List ι) (complete : ∀ i, i ∈ ps)
    (L : List (ι × ι)) (f : ι → ι → Bool)
    (h : (ps.all fun i => ps.all fun j => decide (i = j ∨ (i, j) ∈ L) == f i j) = true) :
    ∀ i j, (i = j ∨ (i, j) ∈ L) ↔ f i j = true := by
  intro i j
  simp only [List.all_eq_true, beq_iff_eq] at h
  have := h i (complete i) j (complete j)
  by_cases hm : (i = j ∨ (i, j) ∈ L) <;> simp_all

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

/-- The pairs a table holds, read when the command runs: each pair of parties as
the two constructors' names. A table is a list of pairs, which is what a reader
should see; a solver form looks a cell up many times over, and scanning the list
each time made checking a verdict several times slower than a match, so the
solver form matches on these pairs instead (`boolTable`). -/
def tablePairs (ι : Expr) (parties : Array Name) (table : Expr) : MetaM (Array (Name × Name)) := do
  let some ιName := ι.constName? | throwError "dispute: {ι} is not a type name"
  let idx := Lean.mkConst (ιName ++ `ctorIdx)
  let f ← withLocalDeclD `p (← mkAppM ``Prod #[ι, ι]) fun x => do
    mkLambdaFVars #[x] (← mkAppM ``Prod.mk
      #[mkApp idx (← mkAppM ``Prod.fst #[x]), mkApp idx (← mkAppM ``Prod.snd #[x])])
  let e ← mkAppM ``List.map #[f, table]
  let v ← unsafe evalExpr (List (Nat × Nat)) (← inferType e) e
  return v.toArray.map fun (a, b) => (parties[a]!, parties[b]!)

/-- A table as a function: `true` at each listed pair, by a match on the two
parties, and `false` elsewhere. -/
def boolTable (pairs : Array (Name × Name)) : MacroM Term := do
  let as : Array Term := pairs.map fun (a, _) => ⟨(mkCIdent a).raw⟩
  let bs : Array Term := pairs.map fun (_, b) => ⟨(mkCIdent b).raw⟩
  if pairs.isEmpty then `(fun _ _ => false)
  else `(fun i j => match i, j with $[| $as, $bs => true]* | _, _ => false)

/-- A table under each standard as a function, by a match on the standard and the
two parties. -/
def boolTable3 (rows : Array (Name × Array (Name × Name))) : MacroM Term := do
  let mut ss : Array Term := #[]
  let mut as : Array Term := #[]
  let mut bs : Array Term := #[]
  for (st, pairs) in rows do
    for (a, b) in pairs do
      ss := ss.push ⟨(mkCIdent st).raw⟩
      as := as.push ⟨(mkCIdent a).raw⟩
      bs := bs.push ⟨(mkCIdent b).raw⟩
  if ss.isEmpty then `(fun _ _ _ => false)
  else `(fun s i j => match s, i, j with $[| $ss, $as, $bs => true]* | _, _, _ => false)

/-- Whether a table was written as the empty list. -/
def isEmptyList (stx : Term) : Bool :=
  match stx with
  | `([]) => true
  | _ => false

/-- `declare_dispute D := node using set`, then the tables: see the module
docstring. The words inside it are not reserved, so `defeats`, `supports`,
`partOf` and `map` stay free as names everywhere else. -/
syntax (name := disputeCmd) (docComment)? "declare_dispute " ident " := " term
  &" using " ident (&" pruned")? (&" rows " num)?
  ppIndent(ppLine (docComment)? &"defeats " term:max)
  ppIndent((ppLine atomic((docComment)? &"supports ") term:max)?)
  ppIndent((ppLine atomic((docComment)? &"partOf ") term:max)?)
  ppIndent((ppLine atomic((docComment)? &"map ") ident)?) : command

/-- `declare_verdict V for D : claim`, then `proves T`: see the module
docstring. With `using F`, the verdict is checked against the solver form `F`
rather than `D.finite`; without `proves`, only the verdict is declared; with
`proves T : type`, the theorem has the statement written, checked to be the
claim's. -/
syntax (name := verdictCmd) (docComment)? "declare_verdict " ident &" for " term:max
  (&" using " term:max)? " : " term
  (ppIndent(ppLine atomic((docComment)? &"proves ") (Lean.Parser.Term.attributes)? ident
    (" : " term)?))? : command

/-- `declare_hearing H := D only [...]`, or `except [...]`: the dispute `D` with
only the listed parties heard, or with the listed parties set aside, and its
solver form `H.finite`. -/
syntax (name := hearingCmd) (docComment)? "declare_hearing " ident " := " ident
  (&" only " <|> &" except ") term:max : command

/-- `declare_rerated R`, then `defeats T`: a register's dispute weighed at each
standard's ratings. `T s` is the defeat table under the standard `s`. Generated:
`R.strength`, each party's weakest link under each standard, computed and
checked (`R.node_strength`); `R.defeatsTable`; `R_defeats`, the table proved cell
by cell under every standard; `R.finite s`, the solver form; and `R.under s`, the
hearing under `s` in that form. With `rows N`, the table is proved `N` rows at a
time. -/
syntax (name := reratedCmd) (docComment)? "declare_rerated " ident (&" rows " num)?
  ppIndent(ppLine (docComment)? &"defeats " term) : command

/-- The cell lemma a table's proof refines with: the prepared one, reading each
party's clauses once, or the pruned one, asking each question of the
components it touches. -/
def cellRefine (d : Ident) (pruned : Bool) : MacroM (TSyntax `tactic) := do
  let dot (field : Name) : Ident := mkIdent (d.getId ++ field)
  if pruned then
    `(tactic| refine Horn.defeats_iff_of_pruned $(dot (`parts ++ `injective))
        ($(dot `node_strength) i) ($(dot `node_strength) j)
        ($(dot (`parts ++ `spec)) i) ($(dot (`parts ++ `spec)) j)
        ($(dot (`parts ++ `valid)) i) ($(dot (`parts ++ `valid)) j)
        ($(d).consistent i) ($(d).consistent j) ?_)
  else
    `(tactic| refine Horn.defeats_iff_of_prepared ($(dot `node_strength) i)
        ($(dot `node_strength) j) ($(dot (`clauses ++ `spec)) i)
        ($(dot (`clauses ++ `spec)) j) ?_)

elab_rules : command
  | `($[$doc?]? declare_dispute $d:ident := $node using $set:ident $[pruned%$pr?]?
      $[rows $rows?]?
      $[$defeatsDoc?]? defeats $defeats
      $[$[$supportsDoc?]? supports $supports?]?
      $[$[$partOfDoc?]? partOf $partOf?]?
      $[$[$mapDoc?]? map $map?]?) => do
    -- What the node function is over: the parties, and the claims.
    let (ιName, αName, parties, strengths, sounds, defeatPairs, supportPairs, partPairs) ←
        liftTermElabM do
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
      -- Each party's weakest link: read from the theorem its package already has,
      -- `P_strength : P.strength = n`, where there is one, and otherwise computed
      -- now and checked by the kernel below.
      let strengths ← parties.mapM fun c => do
        if let some pkg ← packageName? nodeE c then
          let thm := pkg.appendAfter "_strength"
          if let some info := (← getEnv).find? thm then
            if let some (_, _, rhs) := info.type.eq? then
              if let some n := rhs.rawNatLit? <|> (← instantiateMVars rhs).nat? then
                return (n, some thm)
        let s ← mkAppM ``ArgumentPackage.strength #[mkApp nodeE (mkConst c)]
        return (← unsafe evalExpr Nat (mkConst ``Nat) s, none)
      -- Each party's soundness, from the theorem its package already has, if any.
      let sounds ← parties.mapM fun c => do
        let some pkg ← packageName? nodeE c | return none
        let thm := pkg.appendAfter "_establishes"
        return if (← getEnv).contains thm then some thm else none
      -- The tables, read now, for the solver form and the map to match on.
      let pairTy ← mkAppM ``List #[← mkAppM ``Prod #[ι, ι]]
      let read (t : Term) : TermElabM (Array (Name × Name)) := do
        let e ← elabTermEnsuringType t pairTy
        synthesizeSyntheticMVarsNoPostponing
        tablePairs ι parties (← instantiateMVars e)
      let defeatPairs ← read defeats
      let supportPairs ← match supports? with | some t => read t | none => pure #[]
      let partPairs ← match partOf? with | some t => read t | none => pure #[]
      return (ιName, αName, parties, strengths, sounds, defeatPairs, supportPairs, partPairs)
    let ι := mkCIdent ιName
    let α := mkCIdent αName
    let ctorIds := parties.map mkCIdent
    let ctorTerms : Array Term := ctorIds.map fun c => ⟨c.raw⟩
    let soundRhs : Array Term ← (sounds.zip ctorIds).mapM fun (s?, _) =>
      match s? with
      | some thm => `($(mkCIdent thm))
      | none => `(by establish [$set:ident])
    let strengthRhs : Array Term := strengths.map fun (n, _) =>
      ⟨(Syntax.mkNumLit (toString n)).raw⟩
    let strengthProof : Array Term ← strengths.mapM fun (_, thm?) =>
      match thm? with
      | some thm => `($(mkCIdent thm))
      | none => `(by decide)
    let name (suffix : String) : Ident := mkIdent (d.getId.appendAfter suffix)
    let dot (field : Name) : Ident := mkIdent (d.getId ++ field)
    let docD := doc?.getD (docOf s!"A dispute among the parties of `{ιName}`, declared by \
      `declare_dispute`: each party consistent, sound, and with its steps rated.")
    -- One `simp` rates every party, as a dispute written by hand does; a
    -- package that is not a line leaves `Line.asPackage` unused, which is not
    -- worth a warning in generated code.
    elabCommand (← `(command|
      $docD:docComment
      @[$set:ident] def $d : Dispute $α $ι where
        node := $node
        consistent i := Horn.satisfiable_of_certified (by cases i <;> horn_certify)
        sound i := match i with $[| $ctorTerms => $soundRhs]*
        rated i := by
          set_option linter.unusedSimpArgs false in
          cases i <;> simp [$set:ident, Line.asPackage]))
    -- Each party's weakest link, as a table, and checked.
    elabCommand (← `(command|
      /-- Each party's weakest link, as its package computes it: `0` for `disputed`,
      up to `3` for `consensus`. Computed when the dispute was declared. -/
      def $(dot `strength) : $ι → ℕ := fun i => match i with $[| $ctorTerms => $strengthRhs]*))
    elabCommand (← `(command|
      /-- Each party's weakest link is what the table says, checked by the kernel. -/
      theorem $(dot `node_strength) :
          ∀ i, ($(d).node i).strength = $(dot `strength) i := fun i =>
        match i with $[| $ctorTerms => $strengthProof]*))
    let pruned := pr?.isSome
    if pruned then
      elabCommand (← `(command| prepare_parts $(dot `parts) for $d))
    else
      elabCommand (← `(command| prepare_clauses $(dot `clauses) for $d))
    -- The defeat table, as data, and proved: in one theorem, or a few rows at a
    -- time, to keep each proof within the time the checker allows.
    let n := parties.size
    let docDef := defeatsDoc?.getD (docOf s!"**Who defeats whom**, all {n * n} pairs: the \
      listed pairs and no others. Every cell is checked by the kernel.")
    let tableRef := clauseRef defeatsDoc? defeats
    withRef tableRef do elabCommand (← `(command|
      /-- The defeat table, as the list of pairs it holds. -/
      def $(dot `defeatsTable) : List ($ι × $ι) := $defeats))
    let refineCell ← liftMacroM (cellRefine d pruned)
    let rowsPer := (rows?.map (·.getNat)).getD n
    let chunks := (List.range ((n + rowsPer - 1) / rowsPer)).map fun k =>
      (parties.toList.drop (k * rowsPer)).take rowsPer
    if chunks.length ≤ 1 then
      withRef tableRef do elabCommand (← `(command|
        $docDef:docComment
        theorem $(name "_defeats") :
            ∀ i j, $(d).defeats i j ↔ (i, j) ∈ ($defeats : List ($ι × $ι)) := by
          intro i j
          $refineCell:tactic
          cases i <;> cases j <;> horn_certify))
    else
      let mut chunkOf : Array (Name × Ident) := #[]
      for (chunk, k) in chunks.zipIdx do
        let rowName := mkIdent (d.getId.appendAfter s!"_defeats_rows{k + 1}")
        let rowCtors : Array Term := chunk.toArray.map fun c => ⟨(mkCIdent c).raw⟩
        for c in chunk do chunkOf := chunkOf.push (c, rowName)
        withRef tableRef do elabCommand (← `(command|
          /-- Some rows of the defeat table, proved apart from the others to keep each
          proof within the time the checker allows. -/
          private theorem $rowName (i : $ι) (hi : i ∈ ([$rowCtors,*] : List $ι)) (j : $ι) :
              $(d).defeats i j ↔ (i, j) ∈ ($defeats : List ($ι × $ι)) := by
            $refineCell:tactic
            cases i <;> (try (exfalso; revert hi; decide)) <;> cases j <;> horn_certify))
      let rowRhs : Array Term ← chunkOf.mapM fun (_, r) => `($r _ (by decide) j)
      let rowPats : Array Term := chunkOf.map fun (c, _) => ⟨(mkCIdent c).raw⟩
      withRef tableRef do elabCommand (← `(command|
        $docDef:docComment
        theorem $(name "_defeats") :
            ∀ i j, $(d).defeats i j ↔ (i, j) ∈ ($defeats : List ($ι × $ι)) := by
          intro i j
          exact match i with $[| $rowPats => $rowRhs]*))
    withRef (clauseRef defeatsDoc? defeats) do elabCommand (← `(command|
      /-- The defeat table as the solver form computes it, by a match on the two
      parties. -/
      def $(dot `defeatsFn) : $ι → $ι → Bool := $(← liftMacroM (boolTable defeatPairs))))
    withRef (clauseRef defeatsDoc? defeats) do elabCommand (← `(command|
      /-- The dispute in the form the verdict solver computes with. -/
      def $(dot `finite) : Solver.Finite $(d).defeats where
        parties := [$ctorTerms,*]
        complete i := by cases i <;> decide
        defeats := $(dot `defeatsFn)
        spec i j := by
          rw [$(name "_defeats"):ident]
          exact table_spec [$ctorTerms,*] (by intro i; cases i <;> decide)
            ($defeats : List ($ι × $ι)) $(dot `defeatsFn) (by decide +kernel) i j))
    -- The support and part-of tables, when they are written, or when the map
    -- needs them.
    let wantTables := supports?.isSome || partOf?.isSome || map?.isSome
    let supports := supports?.getD (← `([]))
    let partOf := partOf?.getD (← `([]))
    if wantTables then
      -- The support table.
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
      let supportsFn ← liftMacroM (boolTable supportPairs)
      elabCommand (← `(command|
        /-- The support table as the map computes it. -/
        def $(dot `supportsFn) : $ι → $ι → Bool := $supportsFn))
      elabCommand (← `(command|
        /-- The part-of table as the map computes it, each case part of itself. -/
        def $(dot `partOfFn) : $ι → $ι → Bool :=
          $(← liftMacroM (boolTable (parties.map (fun c => (c, c)) ++ partPairs)))))
      let supportsSpec ← if isEmptyList supports then
          `(fun i j => by simp [$(name "_supports"):ident i j, $(dot `supportsFn):ident])
        else `(fun i j => by
          rw [$(name "_supports"):ident]
          exact table_spec [$ctorTerms,*] (by intro i; cases i <;> decide)
            ($supports : List ($ι × $ι)) $(dot `supportsFn) (by decide +kernel) i j)
      withRef (clauseRef (mapDoc?.bind id) m) do elabCommand (← `(command|
        $mapDoc:docComment
        def $m : ArgumentMap $d where
          finite := $(dot `finite)
          supports := $(dot `supportsFn)
          supports_spec := $supportsSpec
          partOf := $(dot `partOfFn)
          partOf_spec i j := by
            rw [$(name "_partOf"):ident]
            exact part_spec [$ctorTerms,*] (by intro i; cases i <;> decide)
              ($partOf : List ($ι × $ι)) $(dot `partOfFn) (by decide +kernel) i j))

/-- The stages of a grounded witness, flattened as a reader would write them: one
list of the parties when every stage is written out, the one stage when there
is one, and the stages joined by `++` otherwise. The stages themselves are left
as written, so a hearing's `Witness.listSub _ [...]` is not expanded. -/
def flattenStages (x : Expr) : MetaM Expr := do
  let some stagesE := x.getAppArgs.back? | return x
  let some (_, stages) := stagesE.listLit? | return x
  let some first := stages.head? | return x
  if stages.length == 1 then return first
  let lits := stages.filterMap (·.listLit?)
  if lits.length == stages.length then
    let ty := lits.head!.1
    return ← mkListLit ty (lits.flatMap (·.2))
  stages.tail.foldlM (init := first) fun acc st => mkAppM ``HAppend.hAppend #[acc, st]

/-- What a claim's `Holds` says, unfolded to the statement a reader would write:
`Claim.Holds R (.credulous a s)` is `CredulouslyAccepted R a`, and the stages of a
grounded witness are flattened to the list of their parties. -/
def holdsStatement (holds : Expr) : MetaM Expr := do
  let some e ← unfoldDefinition? holds | throwError "verdict: cannot unfold {holds}"
  let e ← whnfCore e
  Meta.transform e (post := fun x => do
    if x.isAppOfArity ``List.flatten 2 then return .done (← flattenStages x)
    else return .continue)

elab_rules : command
  | `($[$doc?]? declare_verdict $v:ident for $d $[using $fin?]? : $claim
      $[$[$thmDoc?]? proves $[$attrs?:attributes]? $t?:ident $[: $stmt?]?]?) => do
    let docV := doc?.getD (docOf "A verdict, with the witness the kernel checks.")
    let finite ← match fin? with
      | some f => pure f
      | none => match d with
        | `($x:ident) => `($(mkIdent (x.getId ++ `finite)))
        | _ => throwError "declare_verdict: name the solver form with `using`, for {d}"
    elabCommand (← `(command|
      $docV:docComment
      def $v : Verdict $d where
        finite := $finite
        claim := $claim
        checked := by decide +kernel))
    let some t := t? | return
    let thmDoc? := thmDoc?.bind id
    let attrs? := attrs?.bind id
    let stmt? := stmt?.bind id
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
      -- A statement written out is kept, once the kernel's definitional check
      -- agrees it is the claim's.
      let ty ← match stmt? with
        | none => pure ty
        | some stx => do
          let given ← elabType stx
          synthesizeSyntheticMVarsNoPostponing
          let given ← instantiateMVars given
          unless ← isDefEq given ty do
            throwError "declare_verdict: the statement{indentExpr given}\nis not what \
              the claim shows,{indentExpr ty}"
          pure given
      addDecl <| .thmDecl { name := tName, levelParams := [], type := ty, value := proof }
      if let some doc := thmDoc? then
        addDocStringCore tName (← getDocStringText doc)
      else
        addDocStringCore tName s!"What `{v.getId}` shows, stated."
      addDeclarationRangesFromSyntax tName (clauseRef thmDoc? t) t
      if let some attrs := attrs? then
        let attrs ← elabAttrs attrs.raw[1].getSepArgs
        applyAttributes tName attrs

elab_rules : command
  | `($[$doc?]? declare_hearing $h:ident := $d:ident only $parties) => do
    let docH := doc?.getD (docOf "A hearing: the dispute with only the listed parties heard.")
    elabCommand (← `(command| $docH:docComment abbrev $h := $(d).restrict (· ∈ $parties)))
    elabCommand (← `(command|
      /-- That hearing, in the form the verdict solver computes with. -/
      abbrev $(mkIdent (h.getId ++ `finite)) :=
        $(mkIdent (d.getId ++ `finite)).restrict (· ∈ $parties)))
  | `($[$doc?]? declare_hearing $h:ident := $d:ident except $parties) => do
    let docH := doc?.getD (docOf "A hearing: the dispute with the listed parties set aside.")
    elabCommand (← `(command| $docH:docComment abbrev $h := $(d).restrict (· ∉ $parties)))
    elabCommand (← `(command|
      /-- That hearing, in the form the verdict solver computes with. -/
      abbrev $(mkIdent (h.getId ++ `finite)) :=
        $(mkIdent (d.getId ++ `finite)).restrict (· ∉ $parties)))

elab_rules : command
  | `($[$doc?]? declare_rerated $r:ident $[rows $rows?]? $[$defeatsDoc?]? defeats $table) => do
    let (dName, ιName, parties, standards, strengths, rows) ← liftTermElabM do
      let rE ← elabTerm r none
      let rTy ← whnfR (← inferType rE)
      unless rTy.isAppOf ``Register do throwError "declare_rerated: {r} is not a register"
      let dE := rTy.appArg!
      let some dName := dE.constName? | throwError "declare_rerated: its dispute is not named"
      let dTy ← whnfR (← inferType dE)
      let (ιName, parties) ← enumCtors dTy.appArg!
      let (_, standards) ← enumCtors (mkConst ``Standard)
      let strengths ← standards.mapM fun s => parties.mapM fun c => do
        let d ← mkAppM ``Register.rerated #[rE, mkConst s]
        let pkg ← mkAppM ``Dispute.node #[d, mkConst c]
        let e ← mkAppM ``ArgumentPackage.strength #[pkg]
        unsafe evalExpr Nat (mkConst ``Nat) e
      let ι := dTy.appArg!
      let tableTy ← mkArrow (mkConst ``Standard) (← mkAppM ``List #[← mkAppM ``Prod #[ι, ι]])
      let tE ← elabTermEnsuringType table tableTy
      synthesizeSyntheticMVarsNoPostponing
      let tE ← instantiateMVars tE
      let rows ← standards.mapM fun st => do
        return (st, ← tablePairs ι parties (mkApp tE (mkConst st)))
      return (dName, ιName, parties, standards, strengths, rows)
    let ι := mkCIdent ιName
    let dot (field : Name) : Ident := mkIdent (r.getId ++ field)
    let name (suffix : String) : Ident := mkIdent (r.getId.appendAfter suffix)
    let mut pats : Array Term := #[]
    let mut pats2 : Array Term := #[]
    let mut vals : Array Term := #[]
    for (s, row) in standards.zip strengths do
      for (c, n) in parties.zip row do
        pats := pats.push ⟨(mkCIdent s).raw⟩
        pats2 := pats2.push ⟨(mkCIdent c).raw⟩
        vals := vals.push ⟨(Syntax.mkNumLit (toString n)).raw⟩
    elabCommand (← `(command|
      /-- Each party's weakest link under each standard's ratings, as the re-rated
      package computes it. Computed when the register's hearings were declared. -/
      def $(dot `strength) : Standard → $ι → ℕ := fun s i =>
        match s, i with $[| $pats, $pats2 => $vals]*))
    elabCommand (← `(command|
      /-- Each party's weakest link under each standard is what the table says,
      checked by the kernel. -/
      theorem $(dot `node_strength) :
          ∀ s i, (($(r).rerated s).node i).strength = $(dot `strength) s i := by
        intro s i; cases s <;> cases i <;> decide +kernel))
    elabCommand (← `(command|
      /-- The defeat table under each standard, as the lists of pairs it holds. -/
      def $(dot `defeatsTable) : Standard → List ($ι × $ι) := $table))
    let n := parties.size
    let docDef := defeatsDoc?.getD (docOf "**Who defeats whom at each standard's ratings**, \
      computed from the parties' premises and the re-rated inferences and checked by the \
      kernel.")
    let rowsPer := (rows?.map (·.getNat)).getD n
    let chunks := (List.range ((n + rowsPer - 1) / rowsPer)).map fun k =>
      (parties.toList.drop (k * rowsPer)).take rowsPer
    let refineCell ← `(tactic| refine Horn.defeats_iff_of_certified
        ($(dot `node_strength) s i) ($(dot `node_strength) s j) ?_)
    let mut chunkOf : Array (Name × Ident) := #[]
    for (chunk, k) in chunks.zipIdx do
      let rowName := mkIdent (r.getId.appendAfter s!"_defeats_rows{k + 1}")
      let rowCtors : Array Term := chunk.toArray.map fun c => ⟨(mkCIdent c).raw⟩
      for c in chunk do chunkOf := chunkOf.push (c, rowName)
      elabCommand (← `(command|
        /-- Some rows of the re-rated defeat table, under every standard, proved apart
        from the others to keep each proof within the time the checker allows. -/
        private theorem $rowName (s : Standard) (i : $ι) (hi : i ∈ ([$rowCtors,*] : List $ι))
            (j : $ι) : ($(r).rerated s).defeats i j ↔ (i, j) ∈ $(dot `defeatsTable) s := by
          $refineCell:tactic
          cases s <;> cases i <;> (try (exfalso; revert hi; decide)) <;> cases j <;>
            horn_certify))
    let rowRhs : Array Term ← chunkOf.mapM fun (_, k) => `($k s _ (by decide) j)
    let rowPats : Array Term := chunkOf.map fun (c, _) => ⟨(mkCIdent c).raw⟩
    elabCommand (← `(command|
      $docDef:docComment
      theorem $(name "_defeats") :
          ∀ s i j, ($(r).rerated s).defeats i j ↔ (i, j) ∈ $(dot `defeatsTable) s := by
        intro s i j
        exact match i with $[| $rowPats => $rowRhs]*))
    let dFinite := mkIdent (dName ++ `finite)
    elabCommand (← `(command|
      /-- The defeat table under each standard as the solver form computes it, by a
      match on the standard and the two parties. -/
      def $(dot `defeatsFn) : Standard → $ι → $ι → Bool := $(← liftMacroM (boolTable3 rows))))
    elabCommand (← `(command|
      /-- The dispute at a standard's ratings, in the form the verdict solver
      computes with. -/
      def $(dot `finite) (s : Standard) : Solver.Finite ($(r).rerated s).defeats where
        parties := $(dFinite).parties
        complete := $(dFinite).complete
        defeats := $(dot `defeatsFn) s
        spec i j := by
          rw [$(name "_defeats"):ident]
          exact table_spec $(dFinite).parties $(dFinite).complete
            ($(dot `defeatsTable) s) ($(dot `defeatsFn) s) (by cases s <;> decide +kernel) i j))
    elabCommand (← `(command|
      /-- The hearing under a standard, in the form the verdict solver computes
      with. -/
      abbrev $(dot `under) (s : Standard) := ($(dot `finite) s).restrict ($(r).admits s)))

end Testimony.Logic.Declare
