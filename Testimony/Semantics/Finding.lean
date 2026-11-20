import Testimony.Semantics.Fallacy

/-!
# Testimony.Semantics.Finding — a fallacy declared where it is committed

The fallacy checks (`Testimony.Semantics.Fallacy`) find, in a move, what its
reasoning leans on: a word read in two senses, a text's silence, a view its holder
does not hold. Read over the library's own lines, three of those fail the build
(`Testimony.Checks.Fallacies`), because the library may not do what it checks
others for.

A rival's argument is another matter. Sometimes the clearest way to answer a
reader's question is to set out the argument a writer actually makes, fallacy and
all, and show where it breaks. So a step that commits one of the catalogued
fallacies may say so, next to the step: a **declared finding**. A declaration
names the fallacy and its witness exactly: which word is read two ways, which
premise argues from silence, which attribution answers a view its holder does not
hold and which of the argument's claims contradict it.

The check then runs both ways (`Testimony.Semantics.Move.mismatches`). A declared
finding must be found, with that witness and no other. A fatal finding that is not
declared still fails the build. A declaration that the checks do not bear out is
itself a fault, so a declaration can never hide a fallacy the step does not
commit, or one it commits differently.

What it does not do: decide that the writer is wrong. A declared straw man says
the step answers a view its holder does not hold, by the argument's own record of
that holder. Whether the step's conclusion is true is weighed where the argument
weighs it. Nor does it check that a declared fault is answered: a declaration
sets the fault out to be shown, and the answer is the argument's to give.
-/

namespace Testimony.Semantics

/-- **A finding of the fallacy checks, with its witness**, as a step declares it.
One constructor for each catalogued check a step can be found to commit. -/
inductive Finding (α : Type)
  /-- The step reads these words in two senses where it needs one
  (`Move.equivocates`). -/
  | equivocates (words : List Lexeme)
  /-- The step argues from these texts' silence alone: each is what a text is
  said, by a premise, not to say, teach or contain (`Move.fromSilenceAlone`). -/
  | fromSilence (texts : List Statement)
  /-- The step answers these attributions, each contradicted by the listed claims
  of the argument's record of its voice (`Move.strawMen`). -/
  | strawMan (answered : List (Statement × List α))
  /-- The step needs these words to keep their sense and does not say so
  (`Move.conditionalOn`). A condition, not a fault: declared, it is checked like
  the others, and undeclared it is only reported. -/
  | conditionalOn (words : List Lexeme)
deriving DecidableEq, Repr

namespace Finding

variable {α : Type}

/-- The finding's name, in words, for a report. -/
def kind : Finding α → String
  | .equivocates _ => "equivocation"
  | .fromSilence _ => "argument from silence alone"
  | .strawMan _ => "straw man"
  | .conditionalOn _ => "a word's sense kept, unstated"

/-- Whether two findings are of one kind, whatever their witnesses. -/
def sameKind : Finding α → Finding α → Bool
  | .equivocates _, .equivocates _ => true
  | .fromSilence _, .fromSilence _ => true
  | .strawMan _, .strawMan _ => true
  | .conditionalOn _, .conditionalOn _ => true
  | _, _ => false

/-- Whether the finding has no witness: nothing was found. -/
def isEmpty : Finding α → Bool
  | .equivocates ws => ws.isEmpty
  | .fromSilence ps => ps.isEmpty
  | .strawMan as => as.isEmpty
  | .conditionalOn ws => ws.isEmpty

end Finding

/-- **How a step's declarations stand to what the checks find.** -/
inductive Mismatch (α : Type)
  /-- Declared, and the checks find nothing of the kind. -/
  | absent (declared : Finding α)
  /-- Declared, and the checks find the kind with another witness. -/
  | differs (declared found : Finding α)
  /-- Found, a fault that fails the build, and not declared. -/
  | undeclared (found : Finding α)
  /-- The same kind declared twice. -/
  | twice (declared : Finding α)
deriving DecidableEq, Repr

namespace Move

variable {α : Type} [HasMeanings α]

/-- **What the checks find of one kind in a move**, as a finding of that kind:
the witness the move has, where `record` is the argument's record of each voice. -/
def found (record : Voice → List α) (m : Move) : Finding α → Finding α
  | .equivocates _ => .equivocates m.equivocates
  | .fromSilence _ => .fromSilence m.fromSilenceAlone
  | .strawMan _ => .strawMan (m.strawMen record)
  | .conditionalOn _ => .conditionalOn m.conditionalOn

/-- **The faults the checks find in a move**: equivocation, arguing from silence
alone and answering a straw man, each with its witness, those found only. A
step of the library's own that commits any of them fails the build. -/
def faults (record : Voice → List α) (m : Move) : List (Finding α) :=
  [ .equivocates m.equivocates, .fromSilence m.fromSilenceAlone
  , .strawMan (m.strawMen record) ].filter (!·.isEmpty)

variable [DecidableEq α]

/-- **Every way a move's declarations fail to match what the checks find**:
each declaration found absent or with another witness, each kind declared twice,
and each fault found that no declaration names. Empty when every declaration is
borne out exactly and every fault is declared. -/
def mismatches (record : Voice → List α) (expected : List (Finding α)) (m : Move) :
    List (Mismatch α) :=
  let checked := expected.map fun d =>
    let f := m.found record d
    if f.isEmpty then some (Mismatch.absent d) else if f = d then none
    else some (.differs d f)
  let twice := (expected.zipIdx.filter fun (d, i) =>
    (expected.take i).any (·.sameKind d)).map fun (d, _) => Mismatch.twice d
  let undeclared := (m.faults record).filter (fun f => !expected.any (·.sameKind f))
    |>.map Mismatch.undeclared
  checked.filterMap id ++ twice ++ undeclared

end Move

end Testimony.Semantics
