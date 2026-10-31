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
- **a defeat table**: the dispute over the Septuagint's word, 36 cells, and half
  of the sola fide dispute, 72 cells, each two ways: searched in the kernel
  (`decide +kernel` on `Horn.defeats?`), and certified, the search run at
  elaboration and only its hints checked in the kernel (`horn_certify`), as the
  arguments' own tables are proved;
- **a verdict**: the solver's checked witness for each of the two disputes;
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
example : ∃ (index : Claim → ℕ) (hints : List Horn.Hint),
    Horn.defeatsBy? index hints dinahCase driftObjection 1 0 = some true := by
  horn_certify

#bench "table, certified: Septuagint, 36 cells" in
example : ∀ i j, septuagintDispute.defeats i j ↔ septuagintPartyDefeats i j := by
  intro i j
  refine Horn.defeats_iff_of_certified (septuagintPartyNode_strength i)
    (septuagintPartyNode_strength j) ?_
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

#bench (runs := 1) "table: sola fide, first half, 72 cells" in
example (i : Party)
    (hi : i ∈ [.pauline, .dominical, .apostolic, .trent, .apocalyptic, .sanders])
    (j : Party) : solaFideDispute.defeats i j ↔ partyDefeats i j := by
  refine Horn.defeats_iff_of_defeats? (partyNode_strength i) (partyNode_strength j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> decide +kernel

#bench (runs := 1) "table, certified: sola fide, first half, 72 cells" in
example (i : Party)
    (hi : i ∈ [.pauline, .dominical, .apostolic, .trent, .apocalyptic, .sanders])
    (j : Party) : solaFideDispute.defeats i j ↔ partyDefeats i j := by
  refine Horn.defeats_iff_of_certified (partyNode_strength i) (partyNode_strength j) ?_
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hi
  rcases hi with rfl | rfl | rfl | rfl | rfl | rfl <;> cases j <;> horn_certify

#bench "verdict: sola fide, only Paul's word unanswered" in
example : Verdict solaFideDispute where
  finite := solaFideFinite
  claim := .groundedExactly [[.lexical, .romansOnTheWord]]
    [ (.pauline, .trent), (.dominical, .trent), (.apostolic, .trent), (.trent, .pauline)
    , (.apocalyptic, .pauline), (.sanders, .critics), (.critics, .sanders)
    , (.jervell, .apostolic), (.gospel, .trent), (.trentOnPaulsWord, .lexical) ]
  checked := by decide +kernel

#bench "rating: fruit, not ground" in
example :
    fruitStep.ratings =
      [ (.evidence, .stands .wellSupported)
      , (.tradition, .disputedBy ["Trent, canon 24", "Trent, Session VI, ch. 16"])
      , (.scriptural, .stands .wellSupported) ] := by
  decide +kernel

end TestimonyArguments.SolaFide

/-! ### The checks over every argument -/

#bench (runs := 1) "checks: postulates, every package" in
#check_postulates under TestimonyArguments

#bench (runs := 1) "checks: refutations survive their postulates" in
#check_refutations_postulates under TestimonyArguments

#bench (runs := 1) "checks: AIF, every dispute" in
#check_aif under TestimonyArguments

#bench (runs := 1) "checks: ontology" in
#check_ontology under TestimonyArguments
