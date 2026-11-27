import Testimony.Logic.ModelCheck
import Testimony.Provenance

/-!
# Testimony.Logic.TruthTable — a truth table, its tests and what follows

Some arguments are best seen whole, as a table. Take a few claims about one
person (does he believe, does he do good works, is he justified?) and write out
every way they could stand together, one row each. Then hold each row against
the texts: a row is *allowed* when every text holds of it. A statement *follows*
from the texts when it is true in every allowed row, so a reader can check it by
running an eye down one column.

A `TruthTable` is that, written down: its claims, in the order of its columns;
its tests, each a formula with the `Source` it rests on; and the statements that
follow, each a formula. `TruthTable.Checked` says the table is sound: every
formula is about the table's own claims (`covers`), and every statement that
follows is true in every allowed row (`derives`). It is decidable, and an
argument proves it with `decide +kernel`, so the kernel itself evaluates every
row.

The rows are not an illustration beside the logic. `entails_of_checked` proves
that a checked table's tests *entail* each statement that follows, in the
library's own sense (`Entails`, Foundation's consequence over every valuation),
and `satisfiable_of_allowed` that an allowed row is a model of the tests, so
the entailment is not the empty one a contradictory set of tests would give.

The rows come in the order a logic primer prints them: the first claim varies
slowest, and "true" comes before "false" (`rowsOf`). Rows are numbered from 1,
and a page names them by number, so the prose after a table can say "row 5".
-/

namespace Testimony.Logic

variable {α : Type} [DecidableEq α]

/-- One column of tests or of what follows: a label a page heads it with (①,
Ⓐ), what it says in words, the formula itself, and, for a test, the source it
rests on. A statement that follows needs no source of its own: the table is its
proof. -/
structure TableColumn (α : Type) where
  /-- The mark that heads the column and the line that explains it. -/
  label : String
  /-- What the column says, in plain words. -/
  words : String
  /-- The formula the column evaluates, over the table's claims. -/
  formula : Formula α
  /-- The source a test rests on. `none` for a statement that follows. -/
  source : Option Source := none

/-- A claim of the table: the claim, the heading of its column in words, and
the letter that stands for it in the formulas. -/
structure TableClaim (α : Type) where
  /-- The claim. -/
  claim : α
  /-- Its column's heading, in words ("Believes"). -/
  heading : String
  /-- The letter it is written as in formulas ("B"). -/
  letter : String

/-- **A truth table**: its claims, in column order; its tests; and the
statements the argument says follow from the tests. -/
structure TruthTable (α : Type) where
  /-- The claims, one column each, in order. -/
  claims : List (TableClaim α)
  /-- The tests a row must pass to be allowed. -/
  tests : List (TableColumn α)
  /-- What follows: statements that must be true in every allowed row. -/
  follows : List (TableColumn α)

namespace TruthTable

/-- A row with `a` set to `b`. -/
def set (r : α → Bool) (a : α) (b : Bool) : α → Bool := fun x => if x = a then b else r x

/-- **Every row over a list of claims**, in the order a primer prints them: the
first claim varies slowest, and "true" comes first. Claims not in the list are
`false` in every row. -/
def rowsOf : List α → List (α → Bool)
  | [] => [fun _ => false]
  | a :: as => (rowsOf as).map (set · a true) ++ (rowsOf as).map (set · a false)

/-- The table's claims, without their headings. -/
def claimList (t : TruthTable α) : List α := t.claims.map (·.claim)

/-- The table's rows. -/
def rows (t : TruthTable α) : List (α → Bool) := rowsOf t.claimList

/-- Whether a row passes every test. -/
def allowed (t : TruthTable α) (r : α → Bool) : Bool :=
  t.tests.all fun c => holdsB r c.formula

/-- Whether row `k`, counted from 1, is allowed. -/
def allowedRow (t : TruthTable α) (k : Nat) : Bool :=
  match t.rows[k - 1]? with
  | some r => t.allowed r
  | none => false

/-- Whether every test and every statement is about the table's own claims. -/
def covers (t : TruthTable α) : Bool :=
  (t.tests ++ t.follows).all fun c => (atomsOf c.formula).all (t.claimList.contains ·)

/-- Whether every statement that follows is true in every allowed row. -/
def derives (t : TruthTable α) : Bool :=
  t.rows.all fun r => !t.allowed r || t.follows.all fun c => holdsB r c.formula

/-- **A checked table**: about its own claims, and every statement that follows
is true in every allowed row. Decidable; proved by `decide +kernel`. -/
def Checked (t : TruthTable α) : Prop := t.covers = true ∧ t.derives = true

instance (t : TruthTable α) : Decidable t.Checked := by
  unfold Checked; infer_instance

/-- The table heard on its first `n` tests only, so a page can say which test
strikes a row: a row allowed here and struck in the whole table is struck by a
later test. -/
def firstTests (t : TruthTable α) (n : Nat) : TruthTable α := { t with tests := t.tests.take n }

/-- The tests, as a premise list. -/
def premises (t : TruthTable α) : List (Formula α) := t.tests.map (·.formula)

omit [DecidableEq α] in
/-- A formula's value depends only on its own atoms. -/
theorem holdsB_congr {r b : α → Bool} :
    ∀ φ : Formula α, (∀ a ∈ atomsOf φ, r a = b a) → holdsB r φ = holdsB b φ
  | .atom a, h => by simp [holdsB, h a (by simp [atomsOf])]
  | .falsum, _ => rfl
  | .and p q, h => by
    simp only [holdsB]
    rw [holdsB_congr p fun a ha => h a (by simp [atomsOf, ha]),
      holdsB_congr q fun a ha => h a (by simp [atomsOf, ha])]
  | .or p q, h => by
    simp only [holdsB]
    rw [holdsB_congr p fun a ha => h a (by simp [atomsOf, ha]),
      holdsB_congr q fun a ha => h a (by simp [atomsOf, ha])]
  | .imp p q, h => by
    simp only [holdsB]
    rw [holdsB_congr p fun a ha => h a (by simp [atomsOf, ha]),
      holdsB_congr q fun a ha => h a (by simp [atomsOf, ha])]

/-- **Every way the claims could stand is a row.** -/
theorem exists_row (b : α → Bool) :
    ∀ cs : List α, ∃ r ∈ rowsOf cs, ∀ a ∈ cs, r a = b a
  | [] => ⟨fun _ => false, by simp [rowsOf]⟩
  | c :: cs => by
    obtain ⟨r, hr, hagree⟩ := exists_row b cs
    refine ⟨set r c (b c), ?_, ?_⟩
    · cases hb : b c
      · exact List.mem_append_right _ (List.mem_map_of_mem hr)
      · exact List.mem_append_left _ (List.mem_map_of_mem hr)
    · intro a ha
      by_cases hac : a = c
      · subst hac; simp [set]
      · simp only [set, hac, if_false]
        exact hagree a (by simpa [hac] using ha)

/-- **The tests entail what follows**: each statement that follows is entailed
by the tests, over every valuation, not only over the table's rows. -/
def EntailsWhatFollows (t : TruthTable α) : Prop :=
  ∀ c ∈ t.follows, Entails t.premises c.formula

/-- **A checked table's tests entail each statement that follows.** -/
theorem entails_of_checked {t : TruthTable α} (h : t.Checked) : t.EntailsWhatFollows := by
  classical
  intro c hc
  refine entails_iff.mpr fun w hw => ?_
  let b : α → Bool := fun a => decide (w a)
  have hb : ∀ a, w a ↔ b a = true := fun a => by simp [b]
  obtain ⟨r, hr, hagree⟩ := exists_row b t.claimList
  have hcov := List.all_eq_true.mp h.1
  -- Each formula of the table reads the same in `r` as under `w`.
  have same : ∀ d ∈ t.tests ++ t.follows, holdsB r d.formula = holdsB b d.formula :=
    fun d hd => holdsB_congr d.formula fun a ha =>
      hagree a (by simpa using List.all_eq_true.mp (hcov d hd) a ha)
  have hallowed : t.allowed r = true := by
    refine List.all_eq_true.mpr fun d hd => ?_
    rw [same d (List.mem_append_left _ hd)]
    exact (models_iff_holdsB hb d.formula).mp (hw d.formula (List.mem_map_of_mem hd))
  have hrow := List.all_eq_true.mp h.2 r hr
  simp only [hallowed, Bool.not_true, Bool.false_or] at hrow
  have hc' := List.all_eq_true.mp hrow c hc
  rw [same c (List.mem_append_right _ hc)] at hc'
  exact (models_iff_holdsB hb c.formula).mpr hc'

omit [DecidableEq α] in
/-- **An allowed row is a model of the tests**, so they are satisfiable and what
they entail is not entailed vacuously. -/
theorem satisfiable_of_allowed {t : TruthTable α} {r : α → Bool} (h : t.allowed r = true) :
    Satisfiable t.premises := by
  refine satisfiable_of_table (fun a => r a = true) r (fun _ => Iff.rfl) ?_
  simpa [premises, allowed, List.all_map] using h

/-- **If row `k` is allowed, the tests are satisfiable**: the row is a model. -/
theorem satisfiable_of_allowedRow {t : TruthTable α} {k : Nat} (h : t.allowedRow k = true) :
    Satisfiable t.premises := by
  unfold allowedRow at h
  split at h
  · exact satisfiable_of_allowed h
  · exact absurd h Bool.false_ne_true

end TruthTable

end Testimony.Logic
