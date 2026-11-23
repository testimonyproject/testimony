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
- it **stands apart** from that turn: neither defeats the other;
- it **replies** to that turn: neither defeats the other, but the two share a
  claim, or a meaning that joins two of their claims;
- it **evades** that turn: told as a reply, it shares no claim with it and no
  meaning. That is a red herring, a reply that changes the subject;
- it **restates** that turn: it sets out the same position again, with the same
  conclusion;
- it **concedes** to that turn: it concludes something else, and says it gives
  the earlier conclusion up;
- it **shifts** from that turn: told as the same position after that turn was
  answered, it concludes something else. That is moving the goalposts;
- it **ignores** a rebuttal of that turn: it sets out the same position again,
  with the same conclusion, and does not defeat a turn that defeated it. That is
  ignoring the rebuttal. A turn that restates must defeat every earlier turn
  that defeated the position it restates.

Every stated relation is checked against the dispute's defeats, as the solver
computes them (`Testimony.Logic.Solver.Finite`). So the words that join the
turns are the solver's findings, and a bundle that says "answers" where the
solver finds a standoff does not build. The fix is to the prose, never to the
encoding.

Whether two turns share a claim is read from their packages: a claim either
rests on or delivers, the same for both, or two claims named together by one of
the argument's meaning postulates (`HasPostulates`), as "lasted an hour" and
"lasted two hours" are. A defeat between two positions is decided over those
claims, so where the solver finds one, the two always share a claim; a reply
and a red herring are told only where it finds none.

A turn may quote a line of reason. If that line declares a fallacy it commits
(`Testimony.Semantics.Finding`), a later turn must answer the turn that quotes
it: a fallacy is set out in a bundle only to be answered there. A turn that
evades is a red herring of its own, a turn that shifts moves the goalposts, and
a turn that ignores a rebuttal leaves it standing: each must be answered in the
same way.

A turn may name a work its position cites (`from w`), and then it is dated by
that work: the year it was composed, for a work cited through a later edition
(`Testimony.Bib.BibEntry.dated`). Dated turns must come in the order of their
dates, so an exchange is told as it happened, and a reply never comes before
what it replies to.

A bundle decides only what the dispute decides: it is the dispute's defeats, put
in an order and told. A turn with no relation simply enters the exchange.
-/

namespace Testimony.Logic

variable {ι : Type}

/-! ### Which claims two positions share -/

section Shares

variable {α : Type} [HasPostulates α] [DecidableEq α]

/-- Whether two claims touch: they are the same claim, or one of the meaning
postulates names both, as a definition joining what two words mean. -/
def touches (a b : α) : Bool :=
  a == b || (HasPostulates.postulates : List (Formula α)).any fun f =>
    (atomsOf f).contains a && (atomsOf f).contains b

/-- The claims a party's position rests on or delivers. -/
def Dispute.claims (d : Dispute α ι) (i : ι) : List α :=
  (d.node i).atoms ++ atomsOf (d.node i).conclusion

/-- Whether two parties share a claim, or a meaning that joins one of each. -/
def Dispute.shares (d : Dispute α ι) (i j : ι) : Bool :=
  (d.claims i).any fun a => (d.claims j).any (touches a)

/-- The keys of the works a party's position cites: for each claim it rests on or
delivers, and for each of its inference steps, the source's principal reference
and those it draws on. -/
def Dispute.citedKeys (d : Dispute α ι) (i : ι) : List String :=
  let sources := (d.claims i).map (fun a => ((d.node i).cite a).source) ++
    (d.node i).inferences
  sources.flatMap fun s => (s.primary :: s.supporting).filterMap fun r =>
    r.entry.map (·.core.key)

/-- Whether a party's position cites a work, or the edition the work is cited
through. -/
def Dispute.citesWork (d : Dispute α ι) (i : ι) (w : Testimony.Bib.BibEntry) : Bool :=
  let keys := d.citedKeys i
  keys.contains w.core.key || w.editionUsed.any keys.contains

/-- Whether a reference was written before a year: Scripture always, a work when
its date (`Testimony.Bib.BibEntry.dated`, the year it was composed for a work
cited through a later edition) is earlier, and the library's own proposal,
which cites no one, always. A work with no date is not counted as earlier. -/
def _root_.Testimony.Reference.before (y : Int) : Reference → Bool
  | .scripture _ => true
  | .proposal _ => true
  | .work e _ => e.dated.any (·.value < y)

/-- **Whether a party's position rests only on what was written before a year**:
every reference cited for its claims and for its steps, primary and supporting,
is Scripture or a work dated earlier. So a hearing of the debate before Trent
can be checked to hear no position that cites a later reader. -/
def Dispute.citesOnlyBefore (d : Dispute α ι) (i : ι) (y : Int) : Bool :=
  let sources := (d.claims i).map (fun a => ((d.node i).cite a).source) ++
    (d.node i).inferences
  sources.all fun s => (s.primary :: s.supporting).all (Reference.before y)

/-- Whether two formulas are written the same, part by part. Structural, so the
kernel can decide it. -/
def sameFormula : Formula α → Formula α → Bool
  | .atom a, .atom b => a == b
  | .falsum, .falsum => true
  | .and p q, .and p' q' => sameFormula p p' && sameFormula q q'
  | .or p q, .or p' q' => sameFormula p p' && sameFormula q q'
  | .imp p q, .imp p' q' => sameFormula p p' && sameFormula q q'
  | _, _ => false

/-- Whether two parties conclude the same thing. -/
def Dispute.sameConclusion (d : Dispute α ι) (i j : ι) : Bool :=
  sameFormula (d.node i).conclusion (d.node j).conclusion

end Shares

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
  /-- A reply on the same subject: neither defeats the other, and the two share
  a claim, or a meaning. -/
  | responds (earlier : ι)
  /-- A red herring: told as a reply, it shares no claim with the earlier turn,
  and no meaning. -/
  | evades (earlier : ι)
  /-- The same position again: the same conclusion as the earlier turn. -/
  | restates (earlier : ι)
  /-- A concession: a different conclusion, told as giving the earlier one up. -/
  | concedes (earlier : ι)
  /-- Moving the goalposts: told as the earlier position after it was answered,
  but concluding something else. -/
  | shifts (earlier : ι)
  /-- Ignoring the rebuttal: the earlier position again, with the same
  conclusion, leaving standing a turn that defeated it. -/
  | ignores (earlier : ι)
deriving DecidableEq, Repr

namespace Relation

/-- The earlier turn's party, if the relation names one. -/
def target? : Relation ι → Option ι
  | .enters => none
  | .answers j | .meets j | .standsApart j | .responds j | .evades j
  | .restates j | .concedes j | .shifts j | .ignores j => some j

/-- The fallacy the relation itself names, if any. -/
def charge? : Relation ι → Option String
  | .evades _ => some "red herring"
  | .shifts _ => some "moving the goalposts"
  | .ignores _ => some "ignoring the rebuttal"
  | _ => none

/-- **What the relation claims**, of party `i`, under the defeat relation `R`. -/
def Holds (R : ι → ι → Prop) (i : ι) : Relation ι → Prop
  | .enters | .restates _ | .concedes _ | .shifts _ | .ignores _ => True
  | .answers j => R i j ∧ ¬ R j i
  | .meets j => R i j ∧ R j i
  | .standsApart j | .responds j | .evades j => ¬ R i j ∧ ¬ R j i

/-- The same, computed from a Boolean defeat table. -/
def check (d : ι → ι → Bool) (i : ι) : Relation ι → Bool
  | .enters | .restates _ | .concedes _ | .shifts _ | .ignores _ => true
  | .answers j => d i j && !d j i
  | .meets j => d i j && d j i
  | .standsApart j | .responds j | .evades j => !d i j && !d j i

/-- **Whether a relation reads the positions rightly**, given which parties
share a claim (`s`) and which conclude the same (`c`): one that replies must
share a claim, and one that evades must share none; one that restates must
conclude the same, and one that concedes or shifts must conclude something
else. Every other relation passes. -/
def relevant (s c : ι → ι → Bool) (i : ι) : Relation ι → Bool
  | .responds j => s i j
  | .evades j => !s i j
  | .restates j | .ignores j => c i j
  | .concedes j | .shifts j => !c i j
  | _ => true

/-- What the computation says, the relation holds. -/
theorem holds_of_check {R : ι → ι → Prop} (F : Solver.Finite R) {i : ι} :
    ∀ {r : Relation ι}, check F.defeats i r = true → Holds R i r
  | .enters, _ | .restates _, _ | .concedes _, _ | .shifts _, _ | .ignores _, _ => trivial
  | .answers j, h => by
    simp only [check, Bool.and_eq_true, Bool.not_eq_true'] at h
    exact ⟨(F.spec i j).2 h.1, fun hji => by simp [(F.spec j i).1 hji] at h⟩
  | .meets j, h => by
    simp only [check, Bool.and_eq_true] at h
    exact ⟨(F.spec i j).2 h.1, (F.spec j i).2 h.2⟩
  | .standsApart j, h | .responds j, h | .evades j, h => by
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
  /-- What the party's position concludes, as its package names it. -/
  concludes : String := ""
  /-- The work the turn comes from, which dates it: one the position cites, or a
  work cited through an edition the position cites. -/
  source : Option Testimony.Bib.BibEntry := none
deriving Repr

namespace Turn

/-- The fallacies the turn sets out: a red herring, if it evades, and those
the line it quotes declares. -/
def charges (t : Turn ι) : List String :=
  t.relation.charge?.toList ++ t.findings

/-- The year of the work the turn comes from, if it names one that is dated. -/
def year (t : Turn ι) : Option Int := (t.source.bind (·.dated)).map (·.value)

/-- Whether the turns that are dated come in the order of their dates. A reply
can then name only a turn of the same date or earlier. -/
def chronological : List (Turn ι) → Bool :=
  go none
where
  /-- With the latest date so far. -/
  go (latest : Option Int) : List (Turn ι) → Bool
    | [] => true
    | t :: ts => match t.year, latest with
      | some y, some l => decide (l ≤ y) && go (some y) ts
      | some y, none => go (some y) ts
      | none, _ => go latest ts

/-- Whether the turn sets out a fallacy, its own or the line's it quotes. -/
def declares (t : Turn ι) : Bool := !t.charges.isEmpty

variable [DecidableEq ι]

/-- Whether each relation names a party some earlier turn sets out. -/
def ordered : List (Turn ι) → Bool :=
  go []
where
  /-- With the parties of the turns already told. -/
  go (seen : List ι) : List (Turn ι) → Bool
    | [] => true
    | t :: ts => (t.relation.target?.all seen.contains) && go (t.party :: seen) ts

/-- Whether every turn that shifts from an earlier one comes after a turn that
answers it: the goalposts move only once a position has been answered. -/
def shiftsAnswered : List (Turn ι) → Bool :=
  go []
where
  /-- With the parties already answered. -/
  go (answered : List ι) : List (Turn ι) → Bool
    | [] => true
    | t :: ts =>
      let ok := match t.relation with
        | .shifts j => answered.contains j
        | _ => true
      let answered := match t.relation with
        | .answers j => j :: answered
        | _ => answered
      ok && go answered ts

/-- The earlier turns that defeated the position a turn sets out again, and
that the turn does not defeat in return, under the defeat table `d`. -/
def leftStanding (d : ι → ι → Bool) (t : Turn ι) (earlier : List (Turn ι)) (j : ι) :
    List (Turn ι) :=
  earlier.filter fun e => d e.party j && !d t.party e.party

/-- Whether every restatement defeats each earlier turn that defeated the
position it restates, and every turn said to ignore a rebuttal leaves one
standing. -/
def rebuttalsMet (d : ι → ι → Bool) : List (Turn ι) → Bool :=
  go []
where
  /-- With the turns already told, latest first. -/
  go (earlier : List (Turn ι)) : List (Turn ι) → Bool
    | [] => true
    | t :: ts =>
      let ok := match t.relation with
        | .restates j => (leftStanding d t earlier j).isEmpty
        | .ignores j => !(leftStanding d t earlier j).isEmpty
        | _ => true
      ok && go (t :: earlier) ts

/-- Whether every turn that sets out a fallacy is answered by a later turn. -/
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
  /-- Each turn that sets out a fallacy is answered later. -/
  answered : Turn.answered turns = true
  /-- Each stated relation holds. -/
  holds : ∀ t ∈ turns, t.relation.Holds R t.party
  /-- Which parties share a claim, or a meaning: `Dispute.shares`, when the
  bundle is declared over a dispute. -/
  shares : ι → ι → Bool
  /-- Which parties conclude the same: `Dispute.sameConclusion`, when the bundle
  is declared over a dispute. -/
  same : ι → ι → Bool
  /-- Each reply shares a claim with the turn it replies to, and each red
  herring shares none; each restatement concludes the same, and each concession
  or shift concludes something else. -/
  relevant : turns.all (fun t => t.relation.relevant shares same t.party) = true
  /-- Each shift comes after a turn that answers the position it shifts from. -/
  shiftsAnswered : Turn.shiftsAnswered turns = true
  /-- Which works each party's position cites: `Dispute.citesWork`, when the
  bundle is declared over a dispute. -/
  cites : ι → Testimony.Bib.BibEntry → Bool
  /-- Each turn that names the work it comes from names one its position cites. -/
  sourced : turns.all (fun t => t.source.all (cites t.party)) = true
  /-- The dated turns come in the order of their dates. -/
  chronological : Turn.chronological turns = true
  /-- The dispute in the solver's form, from which the page states how every
  pair of the turns' parties stands. -/
  finite : Solver.Finite R
  /-- Each restatement defeats every earlier turn that defeated the position,
  and each turn said to ignore a rebuttal leaves one standing. -/
  rebuttals : Turn.rebuttalsMet finite.defeats turns = true

namespace Bundle

variable [DecidableEq ι] {R : ι → ι → Prop}

/-- A bundle whose relations are checked by computing them from the dispute in
the solver's form. -/
def ofFinite (F : Solver.Finite R) (shares same : ι → ι → Bool) (doc : String)
    (turns : List (Turn ι))
    (ordered : Turn.ordered turns = true) (answered : Turn.answered turns = true)
    (checked : turns.all (fun t => t.relation.check F.defeats t.party) = true)
    (relevant : turns.all (fun t => t.relation.relevant shares same t.party) = true)
    (shiftsAnswered : Turn.shiftsAnswered turns = true)
    (rebuttals : Turn.rebuttalsMet F.defeats turns = true)
    (cites : ι → Testimony.Bib.BibEntry → Bool)
    (sourced : turns.all (fun t => t.source.all (cites t.party)) = true)
    (chronological : Turn.chronological turns = true) :
    Bundle R where
  doc := doc
  turns := turns
  ordered := ordered
  answered := answered
  holds t ht := Relation.holds_of_check F (List.all_eq_true.1 checked t ht)
  finite := F
  shares := shares
  same := same
  relevant := relevant
  shiftsAnswered := shiftsAnswered
  rebuttals := rebuttals
  cites := cites
  sourced := sourced
  chronological := chronological

/-- Which parties share a claim, or a meaning, in the dispute whose solver form
is given: `Dispute.shares`. -/
def sharesOf {α : Type} [HasPostulates α] [DecidableEq α] {d : Dispute α ι}
    (_ : Solver.Finite d.defeats) : ι → ι → Bool :=
  d.shares

/-- Which parties conclude the same, in the dispute whose solver form is given:
`Dispute.sameConclusion`. -/
def sameOf {α : Type} [HasPostulates α] [DecidableEq α] {d : Dispute α ι}
    (_ : Solver.Finite d.defeats) : ι → ι → Bool :=
  d.sameConclusion

/-- Which works each party cites, in the dispute whose solver form is given:
`Dispute.citesWork`. -/
def citesOf {α : Type} [HasPostulates α] [DecidableEq α] {d : Dispute α ι}
    (_ : Solver.Finite d.defeats) : ι → Testimony.Bib.BibEntry → Bool :=
  d.citesWork

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
      | .responds j => ("responds", nameOf j)
      | .evades j => ("evades", nameOf j)
      | .restates j => ("restates", nameOf j)
      | .concedes j => ("concedes", nameOf j)
      | .shifts j => ("shifts", nameOf j)
      | .ignores j => ("ignores", nameOf j)
    let concludesOf (j : ι) : String :=
      ((b.turns.find? (·.party == j)).map (·.concludes)).getD ""
    let earlier := b.turns.take (b.turns.length - later.length - 1)
    { party := t.name, doc := t.doc, relation := rel, target := target,
      concludes := t.concludes, targetConcludes := (t.relation.target?.map concludesOf).getD "",
      answeredEarlierBy := (t.relation.target?.bind fun j =>
        (earlier.find? (·.relation == .answers j)).map (·.name)).getD "",
      leftStanding := (t.relation.target?.map fun j =>
        (Turn.leftStanding b.finite.defeats t earlier j).map (·.name)).getD [],
      quoting := t.quoting.getD "", findings := t.findings,
      source := (t.source.map (·.core.title)).getD "",
      year := (t.source.bind (·.dated)).map (fun y =>
        (if y.approximate then "c. " else "") ++
          (if y.value < 0 then toString (-y.value) ++ " BC" else toString y.value)) |>.getD "",
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
syntax bundleRel :=
  (&"answers" <|> &"meets" <|> &"standsApart" <|> &"responds" <|> &"evades" <|>
    &"restates" <|> &"concedes" <|> &"shifts" <|> &"ignores") term:max

/-- One turn, as written: its docstring, its party, how it stands to an earlier
turn, and the line of reason it quotes. -/
syntax bundleTurn :=
  (docComment)? &"turn " term:max (bundleRel)? (&"quoting" ident)? (&"from" ident)?

/-- `declare_bundle B in F where`, then its turns: the exchange `B`, a `Bundle`,
whose relations are checked against `F : Solver.Finite R`, the dispute in the
solver's form (`D.finite`). Each turn is `turn p`, then optionally `answers q`,
`meets q`, `standsApart q`, `responds q`, `evades q`, `restates q`, `concedes q`,
`shifts q` or `ignores q` for a party `q` of an earlier turn, `quoting l` for
a line of reason `l`, and `from w` for the work `w` the turn comes from, which
its position must cite and which dates it: dated turns must come in date
order. Its docstring is what the page says of it. A turn that
evades, shifts or ignores a rebuttal, or that quotes a line declaring a fallacy
(`l.expected`), must be answered by a later turn. -/
syntax (name := bundleCmd) (docComment)? "declare_bundle " ident &" in " term:max &" where"
  withPosition((ppLine colGe bundleTurn)+) : command

elab_rules : command
  | `($[$doc?]? declare_bundle $b:ident in $f where $turns*) => do
    let text (d? : Option (TSyntax ``Lean.Parser.Command.docComment)) : CommandElabM String :=
      match d? with
      | some d => do
        -- Each line of a turn's docstring is indented under `turn`; the page
        -- wants the paragraph, not the indentation.
        let raw ← getDocStringText d
        let lines := (raw.splitOn "\n").map (·.trimAsciiStart.toString)
        return ("\n".intercalate lines).trimAscii.toString
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
      let shown := (p.raw.unsetTrailing.reprint.getD "?").trimAscii.toString
      let some d := dispute? | return shown
      liftTermElabM do
        let dTy ← Meta.whnfR (← Meta.inferType d)
        let pE ← Term.elabTermEnsuringType p dTy.appArg!
        Term.synthesizeSyntheticMVarsNoPostponing
        let e ← Meta.mkAppM ``ArgumentPackage.name #[← Meta.mkAppM ``Dispute.node #[d, pE]]
        unsafe Meta.evalExpr String (mkConst ``String) (← instantiateMVars e)
    let concludesOf (p : Term) : CommandElabM String := do
      let some d := dispute? | return ""
      liftTermElabM do
        let dTy ← Meta.whnfR (← Meta.inferType d)
        let pE ← Term.elabTermEnsuringType p dTy.appArg!
        Term.synthesizeSyntheticMVarsNoPostponing
        let e ← Meta.mkAppM ``ArgumentPackage.conclusionLabel
          #[← Meta.mkAppM ``Dispute.node #[d, pE]]
        unsafe Meta.evalExpr String (mkConst ``String) (← instantiateMVars e)
    let mut terms : Array Term := #[]
    for t in turns do
      match t with
      | `(bundleTurn| $[$td?]? turn $p $[$r?]? $[quoting $l?]? $[from $w?]?) =>
        let rel ← match r? with
          | none => `(Relation.enters)
          | some r => match r with
            | `(bundleRel| answers $q) => `(Relation.answers $q)
            | `(bundleRel| meets $q) => `(Relation.meets $q)
            | `(bundleRel| standsApart $q) => `(Relation.standsApart $q)
            | `(bundleRel| responds $q) => `(Relation.responds $q)
            | `(bundleRel| evades $q) => `(Relation.evades $q)
            | `(bundleRel| restates $q) => `(Relation.restates $q)
            | `(bundleRel| concedes $q) => `(Relation.concedes $q)
            | `(bundleRel| shifts $q) => `(Relation.shifts $q)
            | `(bundleRel| ignores $q) => `(Relation.ignores $q)
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
        let concS := Syntax.mkStrLit (← concludesOf p)
        let src ← match w? with
          | none => `(none)
          | some w => `(some $w)
        terms := terms.push
          (← `(Turn.mk $p $rel $nameS $docS $quoting $findings $concS $src))
      | _ => throwErrorAt t "declare_bundle: a turn is `turn p`, then a relation, \
          `quoting l` and `from w`"
    -- Each relation computed now, so that a refusal says what the solver found.
    let evalBool (t : Term) : CommandElabM Bool := liftTermElabM do
      let e ← Term.elabTermEnsuringType t (mkConst ``Bool)
      Term.synthesizeSyntheticMVarsNoPostponing
      unsafe Meta.evalExpr Bool (mkConst ``Bool) (← instantiateMVars e)
    for t in turns do
      match t with
      | `(bundleTurn| $[$_td?]? turn $p $[$r?]? $[quoting $_l?]? $[from $w?]?) =>
        if let some w := w? then
          if dispute?.isNone then
            throwErrorAt w "declare_bundle: whether a position cites a work is read from \
              the dispute's packages, so the bundle must be declared over a dispute's \
              solver form"
          unless ← evalBool (← `(Bundle.citesOf $f $p $w)) do
            throwErrorAt w m!"declare_bundle: the turn's position cites neither this work \
              nor the edition it is\ncited through, so the work cannot date the turn. \
              Name a work the position cites."
        let some r := r? | continue
        let (word, q) ← match r with
          | `(bundleRel| answers $q) => pure ("answer", q)
          | `(bundleRel| meets $q) => pure ("meet", q)
          | `(bundleRel| standsApart $q) => pure ("stand apart from", q)
          | `(bundleRel| responds $q) => pure ("reply to", q)
          | `(bundleRel| evades $q) => pure ("evade", q)
          | `(bundleRel| restates $q) => pure ("restate", q)
          | `(bundleRel| concedes $q) => pure ("concede to", q)
          | `(bundleRel| shifts $q) => pure ("shift from", q)
          | `(bundleRel| ignores $q) => pure ("ignore a rebuttal of", q)
          | _ => throwErrorAt r "declare_bundle: unknown relation"
        if word == "restate" || word == "concede to" || word == "shift from" ||
            word == "ignore a rebuttal of" then
          if dispute?.isNone then
            throwErrorAt r "declare_bundle: what a position concludes is read from the \
              dispute's packages, so the bundle must be declared over a dispute's solver form"
          let same ← evalBool (← `(Bundle.sameOf $f $p $q))
          if word == "restate" && !same then
            throwErrorAt r m!"declare_bundle: a turn said to restate an earlier turn \
              concludes something else.\nTold as the same position, that is moving the \
              goalposts: say `shifts`, and answer it\nin a later turn. If the turn gives \
              the earlier conclusion up, say `concedes`."
          if (word == "concede to" || word == "shift from") && same then
            throwErrorAt r m!"declare_bundle: a turn said to {word} an earlier turn \
              concludes the same.\nIt sets out the same position again: say `restates`."
          if word == "ignore a rebuttal of" && !same then
            throwErrorAt r m!"declare_bundle: a turn said to ignore a rebuttal of an \
              earlier turn concludes something else.\nIt is not the same position: \
              say `shifts` or `concedes`."
          continue
        let pq ← evalBool (← `(Solver.Finite.defeats $f $p $q))
        let qp ← evalBool (← `(Solver.Finite.defeats $f $q $p))
        let ok := match word with
          | "answer" => pq && !qp
          | "meet" => pq && qp
          | _ => !pq && !qp
        unless ok do
          let name (x : Term) : String :=
            (x.raw.unsetTrailing.reprint.getD "?").trimAscii.toString
          let say (x y : Term) (b : Bool) : String :=
            s!"  {name x} {if b then "defeats" else "does not defeat"} {name y}"
          throwErrorAt r m!"declare_bundle: a turn said to {word} an earlier turn, \
            where the solver finds:\n{say p q pq}\n{say q p qp}\n\
            Change what the bundle says, not the encoding."
        if word == "reply to" || word == "evade" then
          if dispute?.isNone then
            throwErrorAt r "declare_bundle: whether a turn replies to another or evades it \
              is read from the dispute's packages, so the bundle must be declared over a \
              dispute's solver form"
          let shared ← evalBool (← `(Bundle.sharesOf $f $p $q))
          if word == "reply to" && !shared then
            throwErrorAt r m!"declare_bundle: a turn said to reply to an earlier turn \
              shares no claim with it,\nand no meaning. A reply on another subject is a \
              red herring: say `evades`, and\nanswer it in a later turn."
          if word == "evade" && shared then
            throwErrorAt r m!"declare_bundle: a turn said to evade an earlier turn shares \
              a claim with it, or a meaning.\nIt replies on the same subject: say \
              `responds`."
      | _ => pure ()
    unless ← evalBool (← `(Turn.ordered [$terms,*])) do
      throwError "declare_bundle: a turn is said to stand to a party no earlier turn sets out"
    unless ← evalBool (← `(Turn.rebuttalsMet (Solver.Finite.defeats $f) [$terms,*])) do
      throwError m!"declare_bundle: a turn said to restate an earlier one leaves standing \
        a turn that defeated\nthat position, or a turn said to ignore a rebuttal leaves \
        none standing. Restated\nwithout an answer, a defeated position ignores the \
        rebuttal: say `ignores`, and\nanswer it in a later turn. A restatement that \
        defeats every rebuttal says `restates`."
    unless ← evalBool (← `(Turn.shiftsAnswered [$terms,*])) do
      throwError m!"declare_bundle: a turn shifts from a position no earlier turn \
        answers.\nThe goalposts move only once a position has been answered: say \
        `concedes`, or\nanswer the position first."
    unless ← evalBool (← `(Turn.chronological [$terms,*])) do
      throwError m!"declare_bundle: the dated turns are not in the order of their \
        dates.\nTell the exchange as it happened: a reply comes after what it replies \
        to."
    unless ← evalBool (← `(Turn.answered [$terms,*])) do
      throwError m!"declare_bundle: a turn sets out a fallacy, its own or one the line \
        it quotes\ndeclares, and no later turn answers it. A fallacy is set out in a \
        bundle only\nto be answered there."
    let bdoc := Syntax.mkStrLit (← text doc?)
    let shares ← if dispute?.isSome then `(Bundle.sharesOf $f) else `(fun _ _ => true)
    let same ← if dispute?.isSome then `(Bundle.sameOf $f) else `(fun _ _ => true)
    let cites ← if dispute?.isSome then `(Bundle.citesOf $f) else `(fun _ _ => true)
    let cmd ← `($[$doc?]? def $b := Bundle.ofFinite $f $shares $same $bdoc [$terms,*]
      (by decide +kernel) (by decide +kernel) (by decide +kernel) (by decide +kernel)
      (by decide +kernel) (by decide +kernel) $cites (by decide +kernel)
      (by decide +kernel))
    elabCommand cmd

end Testimony.Logic.BundleCmd
