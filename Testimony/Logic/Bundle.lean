import Testimony.Logic.Solver
import Testimony.Logic.Dispute
import Testimony.Logic.Page
import Lean.Elab.Command

/-!
# Testimony.Logic.Bundle — an exchange between positions, told in order and checked

A chapter sets out each line of reason well on its own. What a reader also asks
is how the lines meet: who answers whom, where two readings stand off, which
reply leaves the objection standing. Written as prose alone, every "this answers
Howell" is a claim nothing checks.

A **bundle** tells one exchange as a list of turns, in the order a reader meets
them. Each turn is a party to a dispute, with the paragraph that tells it, and
may say how it stands to a turn before it:

- it **answers** that turn: it defeats it, and is not defeated by it;
- it **meets** that turn: each defeats the other, so neither gives way;
- it **stands apart** from that turn: neither defeats the other.

Every stated relation is checked against the dispute's defeats, as the solver
computes them (`Testimony.Logic.Solver.Finite`). So the words that join the
turns are the solver's findings, and a bundle that says "answers" where the
solver finds a standoff does not build. The fix is to the prose, never to the
encoding.

A turn may quote a line of reason. If that line declares a fallacy it commits
(`Testimony.Semantics.Finding`), a later turn must answer the turn that quotes
it: a fallacy is set out in a bundle only to be answered there.

What a bundle does not do: decide anything the dispute does not. It is the
dispute's defeats, put in an order and told. A turn with no relation is only
entered into the exchange, and claims nothing about the others.
-/

namespace Testimony.Logic

variable {ι : Type}

/-- **How a turn stands to an earlier one.** -/
inductive Relation (ι : Type)
  /-- The turn enters the exchange, and says nothing of how it meets the others. -/
  | enters
  /-- The turn answers the earlier one: defeats it, and is not defeated by it. -/
  | answers (earlier : ι)
  /-- Each defeats the other, so neither gives way. -/
  | meets (earlier : ι)
  /-- Neither defeats the other. -/
  | standsApart (earlier : ι)
deriving DecidableEq, Repr

namespace Relation

/-- The earlier turn's party, if the relation names one. -/
def target? : Relation ι → Option ι
  | .enters => none
  | .answers j | .meets j | .standsApart j => some j

/-- **What the relation claims**, of party `i`, under the defeat relation `R`. -/
def Holds (R : ι → ι → Prop) (i : ι) : Relation ι → Prop
  | .enters => True
  | .answers j => R i j ∧ ¬ R j i
  | .meets j => R i j ∧ R j i
  | .standsApart j => ¬ R i j ∧ ¬ R j i

/-- The same, computed from a Boolean defeat table. -/
def check (d : ι → ι → Bool) (i : ι) : Relation ι → Bool
  | .enters => true
  | .answers j => d i j && !d j i
  | .meets j => d i j && d j i
  | .standsApart j => !d i j && !d j i

/-- What the computation says, the relation holds. -/
theorem holds_of_check {R : ι → ι → Prop} (F : Solver.Finite R) {i : ι} :
    ∀ {r : Relation ι}, check F.defeats i r = true → Holds R i r
  | .enters, _ => trivial
  | .answers j, h => by
    simp only [check, Bool.and_eq_true, Bool.not_eq_true'] at h
    exact ⟨(F.spec i j).2 h.1, fun hji => by simp [(F.spec j i).1 hji] at h⟩
  | .meets j, h => by
    simp only [check, Bool.and_eq_true] at h
    exact ⟨(F.spec i j).2 h.1, (F.spec j i).2 h.2⟩
  | .standsApart j, h => by
    simp only [check, Bool.and_eq_true, Bool.not_eq_true'] at h
    exact ⟨fun hij => by simp [(F.spec i j).1 hij] at h,
      fun hji => by simp [(F.spec j i).1 hji] at h⟩

end Relation

/-- **One turn of an exchange**: a party to the dispute, how it stands to an
earlier turn, the paragraph that tells it, and the line of reason it quotes, if
any. -/
structure Turn (ι : Type) where
  /-- The party whose position the turn sets out. -/
  party : ι
  /-- How it stands to an earlier turn. -/
  relation : Relation ι := .enters
  /-- The party's name, as the page shows it: its package's name. -/
  name : String := ""
  /-- What the page says of the turn: its docstring. -/
  doc : String := ""
  /-- The declaration of the line of reason the turn quotes, if any. -/
  quoting : Option String := none
  /-- The fallacies that line declares it commits, by kind
  (`Testimony.Semantics.Finding.kind`). A turn with any must be answered. -/
  findings : List String := []
deriving Repr

namespace Turn

/-- Whether the turn quotes a line that declares a fallacy it commits. -/
def declares (t : Turn ι) : Bool := !t.findings.isEmpty

variable [DecidableEq ι]

/-- Whether each relation names a party some earlier turn sets out. -/
def ordered : List (Turn ι) → Bool :=
  go []
where
  /-- With the parties of the turns already told. -/
  go (seen : List ι) : List (Turn ι) → Bool
    | [] => true
    | t :: ts => (t.relation.target?.all seen.contains) && go (t.party :: seen) ts

/-- Whether every turn that quotes a declared fallacy is answered by a later
turn. -/
def answered : List (Turn ι) → Bool
  | [] => true
  | t :: ts =>
    (!t.declares || ts.any (·.relation == .answers t.party)) && answered ts

end Turn

/-- **An exchange, told in order and checked against the defeat relation `R`.** -/
structure Bundle [DecidableEq ι] (R : ι → ι → Prop) where
  /-- What the page says of the exchange as a whole: the bundle's docstring. -/
  doc : String := ""
  /-- The turns, in the order a reader meets them. -/
  turns : List (Turn ι)
  /-- Each relation names an earlier turn. -/
  ordered : Turn.ordered turns = true
  /-- Each turn that quotes a declared fallacy is answered later. -/
  answered : Turn.answered turns = true
  /-- Each stated relation holds. -/
  holds : ∀ t ∈ turns, t.relation.Holds R t.party
  /-- The dispute in the solver's form, from which the page states how every
  pair of the turns' parties stands. -/
  finite : Solver.Finite R

namespace Bundle

variable [DecidableEq ι] {R : ι → ι → Prop}

/-- A bundle whose relations are checked by computing them from the dispute in
the solver's form. -/
def ofFinite (F : Solver.Finite R) (doc : String) (turns : List (Turn ι))
    (ordered : Turn.ordered turns = true) (answered : Turn.answered turns = true)
    (checked : turns.all (fun t => t.relation.check F.defeats t.party) = true) :
    Bundle R where
  doc := doc
  turns := turns
  ordered := ordered
  answered := answered
  holds t ht := Relation.holds_of_check F (List.all_eq_true.1 checked t ht)
  finite := F

/-- The parties the turns set out, in order, each once, with their names. -/
def parties (b : Bundle R) : List (ι × String) :=
  b.turns.foldl (fun acc t => if acc.any (·.1 == t.party) then acc
    else acc ++ [(t.party, t.name)]) []

/-- **The exchange as a page shows it**: each turn in words, and how every pair
of its parties stands, computed. -/
def view (b : Bundle R) : Page.Exchange :=
  let nameOf (j : ι) : String :=
    ((b.parties.find? (·.1 == j)).map (·.2)).getD ""
  let turn (t : Turn ι) (later : List (Turn ι)) : Page.ExchangeTurn :=
    let (rel, target) : String × String := match t.relation with
      | .enters => ("", "")
      | .answers j => ("answers", nameOf j)
      | .meets j => ("meets", nameOf j)
      | .standsApart j => ("standsApart", nameOf j)
    { party := t.name, doc := t.doc, relation := rel, target := target,
      quoting := t.quoting.getD "", findings := t.findings,
      answeredBy := ((later.find? (·.relation == .answers t.party)).map (·.name)).getD "" }
  let ps := b.parties
  let pairs := ps.zipIdx.flatMap fun ((i, a), k) =>
    (ps.drop (k + 1)).map fun (j, c) => (a, c, b.finite.defeats i j, b.finite.defeats j i)
  { turns := b.turns.zipIdx.map fun (t, k) => turn t (b.turns.drop (k + 1))
    pairs := pairs }

end Bundle

end Testimony.Logic

/-! ### Declaring a bundle -/

namespace Testimony.Logic.BundleCmd

open Lean Elab Command

/-- How a turn stands to an earlier one, as written. -/
syntax bundleRel := (&"answers" <|> &"meets" <|> &"standsApart") term:max

/-- One turn, as written: its docstring, its party, how it stands to an earlier
turn, and the line of reason it quotes. -/
syntax bundleTurn := (docComment)? &"turn " term:max (bundleRel)? (&"quoting" ident)?

/-- `declare_bundle B in F where`, then its turns: the exchange `B`, a `Bundle`,
whose relations are checked against `F : Solver.Finite R`, the dispute in the
solver's form (`D.finite`). Each turn is `turn p`, then optionally `answers q`,
`meets q` or `standsApart q` for a party `q` of an earlier turn, and `quoting l`
for a line of reason `l`. Its docstring is what the page says of it. A turn that
quotes a line declaring a fallacy (`l.expected`) must be answered by a later
turn. -/
syntax (name := bundleCmd) (docComment)? "declare_bundle " ident &" in " term:max &" where"
  withPosition((ppLine colGe bundleTurn)+) : command

elab_rules : command
  | `($[$doc?]? declare_bundle $b:ident in $f where $turns*) => do
    let text (d? : Option (TSyntax ``Lean.Parser.Command.docComment)) : CommandElabM String :=
      match d? with
      | some d => return (← getDocStringText d).trimAscii.toString
      | none => return ""
    -- The party's name, read from the dispute when `F` is one's solver form,
    -- else the party as written.
    let dispute? : Option Expr ← liftTermElabM do
      let fE ← Term.elabTerm f none
      Term.synthesizeSyntheticMVarsNoPostponing
      let ty ← Meta.whnfR (← instantiateMVars (← Meta.inferType fE))
      unless ty.isAppOf ``Solver.Finite do return none
      let r := ty.appArg!
      if r.isAppOf ``Dispute.defeats then return some r.appArg! else return none
    let nameOf (p : Term) : CommandElabM String := do
      let shown := (p.raw.reprint.getD "?").trimAscii.toString
      let some d := dispute? | return shown
      liftTermElabM do
        let dTy ← Meta.whnfR (← Meta.inferType d)
        let pE ← Term.elabTermEnsuringType p dTy.appArg!
        Term.synthesizeSyntheticMVarsNoPostponing
        let e ← Meta.mkAppM ``ArgumentPackage.name #[← Meta.mkAppM ``Dispute.node #[d, pE]]
        unsafe Meta.evalExpr String (mkConst ``String) (← instantiateMVars e)
    let mut terms : Array Term := #[]
    for t in turns do
      match t with
      | `(bundleTurn| $[$td?]? turn $p $[$r?]? $[quoting $l?]?) =>
        let rel ← match r? with
          | none => `(Relation.enters)
          | some r => match r with
            | `(bundleRel| answers $q) => `(Relation.answers $q)
            | `(bundleRel| meets $q) => `(Relation.meets $q)
            | `(bundleRel| standsApart $q) => `(Relation.standsApart $q)
            | _ => throwErrorAt r "declare_bundle: unknown relation"
        let (quoting, findings) ← match l? with
          | none => pure ((← `(none)), (← `([])))
          | some l =>
            let n ← liftCoreM <| realizeGlobalConstNoOverloadWithInfo l
            let s := Syntax.mkStrLit n.toString
            let found ← if (← getEnv).contains (n.str "expected") then
                `(List.map $(mkIdent `Testimony.Semantics.Finding.kind)
                  $(mkIdent (n.str "expected")))
              else `([])
            pure ((← `(some $s)), found)
        let docS := Syntax.mkStrLit (← text td?)
        let nameS := Syntax.mkStrLit (← nameOf p)
        terms := terms.push (← `(Turn.mk $p $rel $nameS $docS $quoting $findings))
      | _ => throwErrorAt t "declare_bundle: a turn is `turn p`, then a relation and `quoting l`"
    -- Each relation computed now, so that a refusal says what the solver found.
    let evalBool (t : Term) : CommandElabM Bool := liftTermElabM do
      let e ← Term.elabTermEnsuringType t (mkConst ``Bool)
      Term.synthesizeSyntheticMVarsNoPostponing
      unsafe Meta.evalExpr Bool (mkConst ``Bool) (← instantiateMVars e)
    for t in turns do
      match t with
      | `(bundleTurn| $[$_td?]? turn $p $[$r?]? $[quoting $_l?]?) =>
        let some r := r? | continue
        let (word, q) ← match r with
          | `(bundleRel| answers $q) => pure ("answers", q)
          | `(bundleRel| meets $q) => pure ("meets", q)
          | `(bundleRel| standsApart $q) => pure ("stands apart from", q)
          | _ => throwErrorAt r "declare_bundle: unknown relation"
        let pq ← evalBool (← `(Solver.Finite.defeats $f $p $q))
        let qp ← evalBool (← `(Solver.Finite.defeats $f $q $p))
        let ok := match word with
          | "answers" => pq && !qp
          | "meets" => pq && qp
          | _ => !pq && !qp
        unless ok do
          let name (x : Term) : String := (x.raw.reprint.getD "?").trimAscii.toString
          let say (x y : Term) (b : Bool) : String :=
            s!"  {name x} {if b then "defeats" else "does not defeat"} {name y}"
          throwErrorAt r m!"declare_bundle: a turn said to be one that {word} an earlier \
            turn, where the solver finds:\n{say p q pq}\n{say q p qp}\n\
            Change what the bundle says, not the encoding."
      | _ => pure ()
    unless ← evalBool (← `(Turn.ordered [$terms,*])) do
      throwError "declare_bundle: a turn is said to stand to a party no earlier turn sets out"
    unless ← evalBool (← `(Turn.answered [$terms,*])) do
      throwError m!"declare_bundle: a turn quotes a line that declares a fallacy it \
        commits,\nand no later turn answers it. A fallacy is set out in a bundle only \
        to be\nanswered there."
    let bdoc := Syntax.mkStrLit (← text doc?)
    let cmd ← `($[$doc?]? def $b := Bundle.ofFinite $f $bdoc [$terms,*]
      (by decide +kernel) (by decide +kernel) (by decide +kernel))
    elabCommand cmd

end Testimony.Logic.BundleCmd
