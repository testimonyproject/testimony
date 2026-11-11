import TestimonyArguments.Checks
import TestimonyArguments.BornOfAVirgin.Dispute.Miller

/-!
# Engine benchmarks

Not part of any library: `scripts/bench.sh` runs this file with
`lake env lean`, from `arguments/`, after `lake build`. It times the work the
engine does when an argument is checked, on the arguments as they stand, so a
change to the engine can be measured before and after.

Each benchmark is a copy of a real proof or check, run inside `#bench`, which
elaborates it some number of times and reports two things.

- **Wall time** of every run, kernel included: asynchronous elaboration is off,
  so a proof is checked by the kernel before the command returns.
  `decide +kernel`, which decides every defeat table, verdict, assessment and
  rating, does its work in the kernel, so it is the kernel's time that is
  measured, not compiled code's.
- **Peak memory**: how far the process's resident memory rose above what it
  held before the benchmark began (Linux's `VmHWM`, reset through
  `/proc/self/clear_refs`). It is only meaningful when the benchmark runs alone
  in its process, since Lean's allocator keeps freed memory for reuse, so
  `scripts/bench.sh` runs each benchmark in a process of its own.

The benchmarks, from the smallest unit up:

- **one defeat cell**: whether the status reading defeats Wegner;
- **a defeat table**: the dispute over the Septuagint's word, 36 cells, and
  six rows of the sola fide dispute, 102 cells, each two ways: searched in the kernel
  (`decide +kernel` on `Horn.defeats?`), and certified, the search run at
  elaboration and only its hints checked in the kernel (`horn_certify`), as the
  arguments' own tables are proved; and a row of a hearing, where every party's
  inferences are re-rated under a standard, with the parties' re-rated strengths;
- **a verdict**: the solver's checked witness for each of the two disputes;
- **two disputes heard as one**: sola fide and Mark 7, 484 cells, and 85 of
  them searched one by one, and the same table composed from the two arguments' own, with its
  verdict;
- **the joins**: the exclusions among sola fide's 127 claims, read for what
  their words mean;
- **an assessment** and **a rating**: Miller's dissent, searched and
  certified, and the laws' step;
- **`establish`** on a package, the tactic every package's soundness uses;
- **the checks** `TestimonyArguments.Checks` runs over every argument.
-/

open Lean Elab Command

set_option Elab.async false

/-- Wall time of one run of a command, in milliseconds, and whether it logged
an error. Unless `keep`, the messages it logs are dropped, so that a check's own
output is not reported once per run; the last run keeps them, so that its errors
are reported. -/
private def timeOnce (cmd : Syntax) (keep : Bool) : CommandElabM (Float × Bool) := do
  let saved := (← get).messages
  modify fun s => { s with messages := {} }
  let t0 ← IO.monoNanosNow
  elabCommand cmd
  let t1 ← IO.monoNanosNow
  let logged := (← get).messages
  modify fun s => { s with messages := if keep then saved ++ logged else saved }
  return ((t1 - t0).toFloat / 1e6, logged.hasErrors)

/-- A field of `/proc/self/status`, in KiB: `VmRSS` (resident now) or `VmHWM`
(the peak). Zero where there is no such file, off Linux. -/
private def statusKiB (field : String) : IO Nat := do
  let some text ← (some <$> IO.FS.readFile "/proc/self/status") <|> pure none
    | return 0
  for line in text.splitOn "\n" do
    if line.startsWith (field ++ ":") then
      return ((line.drop (field.length + 1)).trim.takeWhile Char.isDigit).toNat!
  return 0

/-- Reset the process's peak resident memory to what it holds now, so that the
next `VmHWM` is the peak since this point. -/
private def resetPeak : IO Unit :=
  try IO.FS.writeFile "/proc/self/clear_refs" "5" catch _ => pure ()

/-- Round to one decimal place, for the report. -/
private def round1 (x : Float) : Float := (x * 10).round / 10

/-- `#bench "name" in cmd` and `#bench (runs := n) "name" in cmd`: elaborate
`cmd` `n` times (default 3) and report every run's wall time and the peak
memory above what the process held before, in a line `scripts/bench.sh` reads,
with the first, the fastest and the median time for a reader. The first is
shown apart because a later run may reuse what an earlier one cached. Errors in
`cmd` are reported as usual.

Environment variables, as Google Benchmark's flags are:

- `BENCH_RUNS` overrides every benchmark's run count, for a statistical
  comparison;
- `BENCH_FILTER` runs only the benchmarks whose name contains it, and
  `BENCH_ONLY` only the one whose name is exactly it;
- `BENCH_LIST`, when set, runs nothing and reports each benchmark's name.

A benchmark whose command logs an error reports `bench-error` and no time: it
did not do the work it names, so a time for it would compare nothing. -/
syntax (name := bench) "#bench " ("(" &"runs" " := " num ") ")? str " in " command : command

@[command_elab bench] def elabBench : CommandElab
  | `(#bench $[(runs := $n)]? $name:str in $cmd:command) => do
    let name := name.getString
    if (← IO.getEnv "BENCH_LIST").isSome then
      logInfo m!"bench-name {name}"
      return
    if let some only ← IO.getEnv "BENCH_ONLY" then
      unless only.isEmpty || only == name do return
    let filter := (← IO.getEnv "BENCH_FILTER").getD ""
    unless filter.isEmpty || (name.splitOn filter).length > 1 do return
    let runs := max 1 <| match (← IO.getEnv "BENCH_RUNS").bind String.toNat? with
      | some r => r
      | none => (n.map (·.getNat)).getD 3
    resetPeak
    let before ← statusKiB "VmRSS"
    let mut times : Array Float := #[]
    let mut failed := false
    for i in [0:runs] do
      let (t, err) ← timeOnce cmd (keep := i + 1 == runs)
      times := times.push t
      failed := failed || err
    if failed then
      -- A benchmark that does not elaborate measured nothing: no result.
      logInfo m!"bench-error {name}"
      return
    let peak ← statusKiB "VmHWM"
    let sorted := times.qsort (· < ·)
    let median := sorted[sorted.size / 2]!
    let samples := ", ".intercalate (times.toList.map fun t => toString (round1 t))
    let mib := round1 ((peak - before).toFloat / 1024)
    logInfo m!"bench {name}: first {round1 times[0]!} ms, min {round1 sorted[0]!} ms, \
      median {round1 median} ms, peak memory {mib} MiB, samples [{samples}]"
  | _ => throwUnsupportedSyntax

/-! ### Calibration

Kernel work that touches nothing of the library's: list and `Nat` reduction,
the operations the engine's decisions are made of. Two runs on different
machines are compared through it (`scripts/bench-compare.py --normalize`), so
that a slower machine is not taken for a slower engine. Never change it: a
changed calibration silently rescales every comparison against an older
baseline. -/

#bench "calibration: kernel list reduction" in
example : ((List.range 3000).filter (· % 7 == 0)).length = 429 := by decide +kernel

/-! ### Defeat tables -/

namespace TestimonyArguments.BornOfAVirgin
open Testimony Testimony.Logic Testimony.Logic.Framework

#bench "cell: status reading defeats Wegner" in
example : Horn.defeats? dinahCase driftObjection 1 0 = some true := by decide +kernel

#bench "table: Septuagint, 36 cells" in
example : ∀ i j, septuagintDispute.defeats i j ↔ septuagintPartyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_defeats? (septuagintPartyNode_strength i)
    (septuagintPartyNode_strength j) ?_
  cases i <;> cases j <;> decide +kernel

#bench "cell, certified: status reading defeats Wegner" in
example : Defeats dinahCase driftObjection :=
  Horn.defeats_of_certified dinahCase_strength driftObjection_strength (by horn_certify)

#bench "table, certified: Septuagint, 36 cells" in
example : ∀ i j, septuagintDispute.defeats i j ↔ septuagintPartyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_certified (septuagintPartyNode_strength i)
    (septuagintPartyNode_strength j) ?_
  cases i <;> cases j <;> horn_certify

#bench "table, prepared: Septuagint, 36 cells" in
example : ∀ i j, septuagintDispute.defeats i j ↔ septuagintPartyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_prepared (septuagintPartyNode_strength i)
    (septuagintPartyNode_strength j) (septuagintDisputeClauses.spec i)
    (septuagintDisputeClauses.spec j) ?_
  cases i <;> cases j <;> horn_certify

prepare_parts septuagintBenchParts for septuagintDispute

#bench "table, pruned: Septuagint, 36 cells" in
example : ∀ i j, septuagintDispute.defeats i j ↔ septuagintPartyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_pruned septuagintBenchParts.injective
    (septuagintPartyNode_strength i) (septuagintPartyNode_strength j)
    (septuagintBenchParts.spec i) (septuagintBenchParts.spec j) (septuagintBenchParts.valid i)
    (septuagintBenchParts.valid j) (septuagintDispute.consistent i)
    (septuagintDispute.consistent j) ?_
  cases i <;> cases j <;> horn_certify

#bench "verdict: Septuagint, grounded in stages" in
example : Verdict septuagintDispute where
  finite := septuagintFinite
  claim := .groundedExactly [[.dinah], [.witness, .usage, .laws]]
    [(.drift, .dinah), (.miller, .dinah)]
  checked := by decide +kernel

#bench "assessment: Miller against the laws" in
example :
    Dissent.findings?
      { claim := p .lawsUseParthenosAsVirgin
      , grounds := lawsLine.grounds
      , position := millerOnTheLaws
      , refuted := [joelReadsABride] } =
    some
      { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
      , unadmitted :=
          [ (.evidence, []), (.tradition, [])
          , (.scriptural, [.parthenosDescribesDinahAsSheThenWas]) ]
      , struck := [.joelGreekCallsTheWidowParthenos] } := by
  decide +kernel

#bench "assessment, certified: Miller against the laws" in
example : Assessment Claim where
  dissenter := "Miller, Born Divine"
  against := lawsLine.name
  dissent :=
    { claim := p .lawsUseParthenosAsVirgin
    , grounds := lawsLine.grounds
    , position := millerOnTheLaws
    , refuted := [joelReadsABride] }
  findings :=
    { consistent := true, denies := true, grants := true, argued := true, bareDenial := false
    , unadmitted :=
        [ (.evidence, []), (.tradition, [])
        , (.scriptural, [.parthenosDescribesDinahAsSheThenWas]) ]
    , struck := [.joelGreekCallsTheWidowParthenos] }
  checked := by horn_certify

#bench "rating: the laws' step, three standards" in
example :
    lawsStep.ratings =
      [ (.evidence, .overruled ["Miller, Born Divine"] .wellSupported)
      , (.tradition, .overruled ["Miller, Born Divine"] .wellSupported)
      , (.scriptural, .stands .wellSupported) ] := by
  decide +kernel

#bench "establish: Miller's case" in
example : Establishes millerCase := by establish [bornOfAVirginDefs, caseOf]

#bench "refute_with: Wegner rests on his inference" in
example : ¬ Entails driftLine.grounds (p .parthenosMeantYoungWoman) := by
  refute_with archaismReading [bornOfAVirginDefs]

end TestimonyArguments.BornOfAVirgin

namespace TestimonyArguments.SolaFide
open Testimony Testimony.Logic Testimony.Logic.Framework

#bench (runs := 1) "table: sola fide, first six rows, 102 cells" in
example (i : Party)
    (hi : i ∈ [.pauline, .dominical, .apostolic, .trent, .apocalyptic, .sanders])
    (j : Party) : solaFideDispute.defeats i j ↔ partyDefeats i j := by
  refine Horn.defeats_iff_of_defeats? (partyNode_strength i) (partyNode_strength j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> decide +kernel

#bench (runs := 1) "table, certified: sola fide, first six rows, 102 cells" in
example (i : Party)
    (hi : i ∈ [.pauline, .dominical, .apostolic, .trent, .apocalyptic, .sanders])
    (j : Party) : solaFideDispute.defeats i j ↔ partyDefeats i j := by
  refine Horn.defeats_iff_of_certified (partyNode_strength i) (partyNode_strength j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> horn_certify

#bench (runs := 1) "supports: sola fide, 289 cells" in
example : ∀ i j, ¬ solaFideDispute.supports i j := by
  intro i j
  refine (supports_iff_of_supports? (P := False) ?_).not.mpr id
  cases i <;> cases j <;> decide +kernel

#bench (runs := 1) "supports, certified: sola fide, 289 cells" in
example : ∀ i j, ¬ solaFideDispute.supports i j := by
  intro i j
  refine (supports_iff_of_certified (P := False) ?_).not.mpr id
  cases i <;> cases j <;> horn_certify

#bench (runs := 1) "part of: sola fide, 289 cells" in
example : ∀ i j, solaFideDispute.partOf i j ↔ partyPartOf i j := by
  intro i j
  refine partOf_iff_of_partOf? ?_
  cases i <;> cases j <;> decide +kernel

#bench (runs := 1) "part of, certified: sola fide, 289 cells" in
example : ∀ i j, solaFideDispute.partOf i j ↔ partyPartOf i j := by
  intro i j
  refine partOf_iff_of_certified ?_
  cases i <;> cases j <;> horn_certify

#bench "satisfied_by: the Pauline case" in
example : Satisfiable paulineCase.premises := by
  satisfied_by criticsReading [solaFideDefs]

#bench "satisfied_by: Trent grants the subjective genitive" in
example : Grants tridentineCase (notP .pistisChristouObjective) := by
  satisfied_by trentWithoutDeliveranceReading [Grants, solaFideDefs]

prepare_clauses solaFideBenchClauses for solaFideDispute

#bench (runs := 1) "table, prepared: sola fide, first six rows, 102 cells" in
example (i : Party)
    (hi : i ∈ [.pauline, .dominical, .apostolic, .trent, .apocalyptic, .sanders])
    (j : Party) : solaFideDispute.defeats i j ↔ partyDefeats i j := by
  refine Horn.defeats_iff_of_prepared (partyNode_strength i) (partyNode_strength j)
    (solaFideBenchClauses.spec i) (solaFideBenchClauses.spec j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> horn_certify

#bench (runs := 1) "table, pruned: sola fide, first six rows, 102 cells" in
example (i : Party)
    (hi : i ∈ [.pauline, .dominical, .apostolic, .trent, .apocalyptic, .sanders])
    (j : Party) : solaFideDispute.defeats i j ↔ partyDefeats i j := by
  refine Horn.defeats_iff_of_pruned solaFideDisputeParts.injective (partyNode_strength i)
    (partyNode_strength j) (solaFideDisputeParts.spec i) (solaFideDisputeParts.spec j)
    (solaFideDisputeParts.valid i) (solaFideDisputeParts.valid j) (solaFideDispute.consistent i)
    (solaFideDispute.consistent j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> horn_certify

#bench "strengths: James hearing under evidence, 12 parties" in
example :
    ∀ i, ((jamesRegister.rerated .evidence).node i).strength = ratedStrength .evidence i := by
  intro i
  cases i <;> decide +kernel

#bench "row, certified: James hearing under evidence, Trent's word, 12 cells" in
example (j : JamesParty) :
    (jamesRegister.rerated .evidence).defeats .trentOnTheWord j ↔
      ratedDefeats .evidence .trentOnTheWord j := by
  refine Horn.defeats_iff_of_certified
    (rerated_strength .evidence .trentOnTheWord) (rerated_strength .evidence j) ?_
  cases j <;> horn_certify

#bench (runs := 1) "joins: sola fide exclusions, 127 claims" in
example : (Testimony.Semantics.HasMeanings.exclusions (α := Claim)).length = 6 := by
  decide +kernel

#bench "verdict: sola fide, only Paul's word unanswered" in
example : Verdict solaFideDispute where
  finite := solaFideFinite
  claim := .groundedExactly [[.lexical, .romansOnTheWord]]
    [ (.pauline, .trent), (.dominical, .trent), (.apostolic, .trent), (.trent, .pauline)
    , (.apocalyptic, .pauline), (.sanders, .critics), (.critics, .sanders)
    , (.jervell, .apostolic), (.gospel, .trent), (.trentOnPaulsWord, .lexical)
    , (.johannine, .trent), (.aquinas, .luther), (.luther, .aquinas)
    , (.chrysostom, .pauline), (.sanctification, .trent) ]
  checked := by decide +kernel

#bench "rating: fruit, not ground" in
example :
    fruitStep.ratings =
      [ (.evidence, .stands .wellSupported)
      , (.tradition, .disputedBy ["Trent, canon 24", "Trent, Session VI, ch. 16"])
      , (.scriptural, .stands .wellSupported) ] := by
  decide +kernel

end TestimonyArguments.SolaFide

namespace TestimonyArguments.SolaScriptura
open Testimony Testimony.Logic

#bench "leaves_open: parity leaves the canon open" in
example : Independent canonUnderParity.premises (p .scriptureIsSoleInfallibleRule) := by
  leaves_open parityEstablishesNothingReading krugerParityReading [solaScripturaDefs]

end TestimonyArguments.SolaScriptura

/-! ### Two disputes heard as one

Sola fide's seventeen parties and Mark 7's five, over both arguments' claims: 484
cells, proved once from the two arguments' own tables (`Dispute.sum_defeats`).
The 85 cells in which a party of sola fide meets one of Mark 7 are also decided
one by one, in the kernel, by search, for comparison. A certificate is not an
option here: it reads each claim as a bit at its constructor's index, and a sum
of two claim types has only two. -/

namespace TestimonyArguments.BothSolas
open Testimony Testimony.Logic

abbrev Party := SolaFide.Party ⊕ SolaScriptura.Mark7Party

abbrev bothDispute : Dispute (SolaFide.Claim ⊕ SolaScriptura.Claim) Party :=
  SolaFide.solaFideDispute.sum SolaScriptura.mark7Dispute
    (SolaFide.solaFideDispute.node .pauline).cite
    (SolaScriptura.mark7Dispute.node .principle).cite
    (SolaFide.solaFideDispute.postulates_satisfiable .pauline)
    (SolaScriptura.mark7Dispute.postulates_satisfiable .principle)

def bothDefeats : Party → Party → Prop
  | .inl i, .inl j => SolaFide.partyDefeats i j
  | .inr i, .inr j => SolaScriptura.mark7PartyDefeats i j
  | _, _ => False

instance : DecidableRel bothDefeats := fun x y => by
  cases x <;> cases y <;> unfold bothDefeats <;> infer_instance

def bothStrength : Party → ℕ := Sum.elim SolaFide.partyStrength SolaScriptura.mark7PartyStrength

theorem both_strength : ∀ x, (bothDispute.node x).strength = bothStrength x
  | .inl i => (ArgumentPackage.strength_inl _ _).trans (SolaFide.partyNode_strength i)
  | .inr j => (ArgumentPackage.strength_inr _ _).trans (SolaScriptura.mark7PartyNode_strength j)

#bench (runs := 1) "cross cells, searched: sola fide against Mark 7, 85 cells" in
example : ∀ i j, ¬ bothDispute.defeats (.inl i) (.inr j) := by
  intro i j
  refine Horn.not_defeats_of_defeats? (both_strength (.inl i)) (both_strength (.inr j)) ?_
  cases i <;> cases j <;> decide +kernel

#bench "cross cells, composed: sola fide against Mark 7, 85 cells" in
example : ∀ i j, ¬ bothDispute.defeats (.inl i) (.inr j) := fun i j h =>
  Sum.not_liftRel_inl_inr ((Dispute.sum_defeats _ _ _ _ _ _ _ _).mp h)

#bench "table, composed: sola fide and Mark 7 as one, 484 cells" in
example : ∀ x y, bothDispute.defeats x y ↔ bothDefeats x y := by
  intro x y
  refine (Dispute.sum_defeats _ _ _ _ _ _ x y).trans ?_
  rcases x with i | i <;> rcases y with j | j
  · exact Sum.liftRel_inl_inl.trans (SolaFide.solaFideDispute_defeats i j)
  · exact iff_of_false Sum.not_liftRel_inl_inr id
  · exact iff_of_false Sum.not_liftRel_inr_inl id
  · exact Sum.liftRel_inr_inr.trans (SolaScriptura.mark7Dispute_defeats i j)

#bench "verdict, composed: sola fide and Mark 7 as one" in
example : Verdict bothDispute where
  finite := Dispute.sumFinite SolaFide.solaFideFinite SolaScriptura.mark7Finite
  claim := .groundedExactly [[.inl .lexical, .inl .romansOnTheWord, .inr .principle]]
    [ (.inl .pauline, .inl .trent), (.inl .dominical, .inl .trent)
    , (.inl .apostolic, .inl .trent), (.inl .trent, .inl .pauline)
    , (.inl .apocalyptic, .inl .pauline), (.inl .sanders, .inl .critics)
    , (.inl .critics, .inl .sanders), (.inl .jervell, .inl .apostolic)
    , (.inl .gospel, .inl .trent), (.inl .trentOnPaulsWord, .inl .lexical)
    , (.inl .johannine, .inl .trent), (.inl .aquinas, .inl .luther)
    , (.inl .luther, .inl .aquinas), (.inl .chrysostom, .inl .pauline)
    , (.inl .sanctification, .inl .trent)
    , (.inr .mark7, .inr .trent), (.inr .trent, .inr .mark7)
    , (.inr .trentAsMensCommandments, .inr .principle)
    , (.inr .trentAsApostolicWord, .inr .mark7) ]
  checked := by decide +kernel

end TestimonyArguments.BothSolas

/-! ### The checks over every argument -/

#bench (runs := 1) "checks: postulates, every package" in
#check_postulates under TestimonyArguments

#bench (runs := 1) "checks: refutations survive their postulates" in
#check_refutations_postulates under TestimonyArguments

#bench (runs := 1) "checks: AIF, every dispute" in
#check_aif under TestimonyArguments

#bench (runs := 1) "checks: ontology" in
#check_ontology under TestimonyArguments
