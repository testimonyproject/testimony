import Testimony.Logic.Because

/-!
# Testimony.Logic.Dilemma — every reading of an ambiguous claim, answered

A rival's premise can be ambiguous in a way that decides the dispute. Trent
defines justification as "not remission of sins merely, but also the
sanctification and renewal of the inward man" (Session VI, ch. 7). Is that a
claim about what Paul's word δικαιόω means, or about what God does when he
justifies? The two readings meet different objections, and an argument that
answers only one of them has answered a rival of its own choosing.

A `Dilemma R` makes the choice impossible to dodge. It names one of `R`'s
premises, the **claim**, and the **readings** it admits. Each reading says what
the claim commits `R` to under it — a formula `commits`, with a citation for
reading the claim that way — and `R.readAs claim r` is `R` with that
commitment added as the step `claim ➝ commits`. Then, with a proof of each:

- **The claim is `R`'s own.**
- **Every reading is fair.** `R` read that way still has a model: no horn is a
  strawman that falls to itself.
- **Every reading is answered.** Each reading is one **horn**, carrying a list
  of checked **fates**, never empty. A fate says, against a named position `P`, one of two
  things:
  - **It falls**: a `Because P (R.readAs claim r)` — the reading breaks against
    `P`, at a named crux, with the rival's premises that cannot be held with it.
  - **It is not reached**: `P` establishes its conclusion, and `P`'s premises
    can be held together with `R` read that way. `P`, whatever it shows, does
    not touch this reading.

A reading enters a dilemma only as part of a horn, with its fates, so a
dilemma cannot list a reading and leave it unanswered (`Dilemma.answered`).

## What a dilemma claims, and what it does not

It does not claim that the readings are the only ones. It is a dilemma over
the readings it names, and each is cited; a reader with a third reading has a
third horn to add, and the certificate will not build until that horn is
answered too.

Nor does it say which reading the rival means. That is what the readings'
citations are for. What it shows is what follows *on each*: where the reading
falls, to what, at which crux, rated how — and where nothing here reaches it.
When the horns end at cruxes rated differently, the rendering lets a reader see
that the rival's choice of reading is a choice of which crux to defend.

## Why readings are added as steps

A reading adds `claim ➝ commits` to the rival rather than rewriting its
premises. So the reading is a named difference, as every variant in this
library is: the rival's own premises are untouched, and what the reading adds is
one step, cited to whoever reads the claim that way.
-/

namespace Testimony.Logic

variable {α : Type}

/-- One way of reading a rival's claim: a name for the reading, what the claim
commits the rival to under it, and who reads the claim that way. -/
structure Reading (α : Type) where
  /-- The reading, as a phrase: "as a claim about what Paul's word means". -/
  name : String
  /-- What the claim commits its holder to, read this way. -/
  commits : Formula α
  /-- Who reads the claim this way, and how firmly. -/
  source : Source

/-- **A rival, read one way.** `R` with the step `claim ➝ r.commits` added, and
the reading's citation among its inferences, under a name that says which
reading. -/
def ArgumentPackage.readAs (R : ArgumentPackage α) (claim : Formula α) (r : Reading α) :
    ArgumentPackage α :=
  { R with
    name := R.name ++ ", read " ++ r.name
    premises := R.premises ++ [claim ➝ r.commits]
    inferences := R.inferences ++ [r.source] }

/-- Reading a rival one way keeps what it concludes: a reading only adds. -/
theorem ArgumentPackage.readAs_establishes {R : ArgumentPackage α} {claim : Formula α}
    {r : Reading α} (h : Establishes R) : Establishes (R.readAs claim r) :=
  entails_of_subset (fun _ hφ => List.mem_append_left _ hφ) h

/-- What happens to one reading, against one position. -/
inductive Fate (Ri : ArgumentPackage α)
  /-- The reading breaks against `P`, and here is why. -/
  | falls (P : ArgumentPackage α) (because : Because P Ri)
  /-- `P` holds, and can be held together with the reading: it does not reach
  it. -/
  | unreached (P : ArgumentPackage α) (holds : Establishes P)
      (together : Satisfiable (P.premises ++ Ri.premises))

/-- One horn of a dilemma: a reading of the rival's claim, the proof that the
rival read that way still has a model, and what happens to it — never nothing. -/
structure Dilemma.Horn (R : ArgumentPackage α) (claim : Formula α) where
  /-- The reading. -/
  reading : Reading α
  /-- `R`, read this way, still has a model: the horn is not a strawman. -/
  fair : Satisfiable (R.readAs claim reading).premises
  /-- What happens to the reading, against each position it is set against. -/
  fates : List (Fate (R.readAs claim reading))
  /-- At least one position is set against it. -/
  answered : fates ≠ []

/-- **Every reading of a rival's claim, answered.** See the module docstring for
what each field claims. A reading enters only as part of a horn, with its
fates, so no reading can be listed and left unanswered. -/
structure Dilemma (R : ArgumentPackage α) where
  /-- The premise of `R` that is read more than one way. -/
  claim : Formula α
  /-- One horn per reading. -/
  horns : List (Dilemma.Horn R claim)
  /-- The claim is one of `R`'s premises. -/
  claim_mem : claim ∈ R.premises
  /-- A dilemma has at least two horns. -/
  two : 2 ≤ horns.length

namespace Dilemma

variable {R : ArgumentPackage α}

/-- The readings a dilemma answers. -/
def readings (d : Dilemma R) : List (Reading α) := d.horns.map (·.reading)

/-- **Every reading the dilemma lists is answered**, and fairly: the rival read
that way has a model, and at least one checked fate is set against it. -/
theorem answered (d : Dilemma R) : ∀ r ∈ d.readings, ∃ h ∈ d.horns,
    h.reading = r ∧ Satisfiable (R.readAs d.claim r).premises ∧ h.fates ≠ [] := by
  intro r hr
  obtain ⟨h, hh, rfl⟩ := List.mem_map.mp hr
  exact ⟨h, hh, rfl, h.fair, h.answered⟩

/-- **A reading that falls cannot be held with what it falls to.** -/
theorem falls_not_together {Ri P : ArgumentPackage α} (b : Because P Ri) :
    ¬ Satisfiable (P.premises ++ Ri.premises) :=
  b.not_together

/-- A fate, as a page shows it. -/
def Fate.view {Ri : ArgumentPackage α} : Fate Ri → Page.Fate α
  | .falls P b => { against := P.name, falls := some b.view }
  | .unreached P _ _ => { against := P.name, falls := none }

/-- What a page renders: the dilemma's data, without its proofs. -/
def view (d : Dilemma R) : Page.Dilemma α :=
  { rival := R.name, cite := R.cite, claim := d.claim
  , horns := d.horns.map fun h =>
      { reading := h.reading.name, commits := h.reading.commits, source := h.reading.source
      , fates := h.fates.map Fate.view } }

end Dilemma

end Testimony.Logic
