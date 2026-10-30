---
name: optimising-the-engine
description: Use when making the Testimony library's engine faster or lighter — build time, memory, kernel replay, the decide +kernel checks behind defeat tables, verdicts, assessments and ratings — or when a change may have slowed it or made it heavier. Covers the benchmark suite, statistical A/B comparison, the fixed-point loop, the CI regression gate and recording a new baseline.
---

# Optimising the engine

## Why this exists

Every argument the library adds makes every later check more expensive: a
dispute's defeat table is one decision per ordered pair of parties, each over
the parties' premises and the argument's meaning postulates, decided in the
kernel. Arguments that build on one another (the virgin birth on Isaiah, the
divinity of Christ on both) multiply this. So the engine is made faster as a
loop, measured at each step, until a further change no longer makes a
significant difference: a **fixed point**. Time and memory are both targets:
CI runs on a 16 GB runner, and the kernel replay has already run out of memory
there once, so a change that halves memory at no cost in time is as good as one
that halves time.

**Speed never buys a weaker proof.** No `native_decide`, no `bv_decide`, no
`sorry`, no raised `maxHeartbeats`, no check moved out of the kernel, no
theorem weakened to make it cheaper. A faster engine proves exactly what the
slower one did, and every gate in `checking-the-build` still passes.

## The tools

```sh
scripts/bench.sh                              # every benchmark: time and peak memory
scripts/bench.sh --runs 10 --out a.json       # ten samples each, for a comparison
scripts/bench.sh --filter table               # only benchmarks whose name has "table"
scripts/bench-compare.py a.json b.json        # Mann-Whitney U, alpha 0.05
```

- **`arguments/bench/Engine.lean`** holds the benchmarks. It is in no build
  target; `bench.sh` runs it with `lake env lean` after `lake build` in
  `arguments/`. Each benchmark is a copy of a real proof or check inside
  `#bench`, which times elaboration with the kernel check included
  (asynchronous elaboration is off) and records the peak resident memory above
  what the process held before. `bench.sh` runs each benchmark in a process of
  its own, so that the memory figure is that benchmark's alone and its samples
  do not share a cache with another benchmark's.
- **`scripts/bench-compare.py`** is Google Benchmark's `compare.py` method: the
  two-sided Mann-Whitney U test per benchmark. A change counts only when
  p < 0.05 **and** the medians differ by more than `--threshold` (default 5%):
  the variance bound, below which noise could account for it. A benchmark whose
  samples spread too widely (`--max-cv`) is reported noisy and counts neither
  way. Peak memory has one figure per benchmark and is close to deterministic,
  so it is compared by threshold, not test: more than `--mem-threshold`
  (default 10%) and `--mem-floor` (default 32 MiB) is a change. `uv` provides
  the script's SciPy from its own header.
- **`--normalize "calibration: kernel list reduction"`** divides every sample by
  the calibration benchmark's median in the same run, so runs on different
  machines compare. Never change the calibration benchmark: it would silently
  rescale every comparison against an older baseline.
- **Profiling**, to find what to change: `set_option profiler true` (or
  `lean --profile`) for time per declaration, by phase; `set_option
  trace.profiler true` with `trace.profiler.output "x.json"` for a flame graph
  in Firefox Profiler; `set_option diagnostics true` for what the kernel
  unfolded most. Kernel time is what `decide +kernel` costs; heartbeats measure
  the elaborator, not the kernel.

## The loop

1. **Record the baseline**, on the machine you will measure the change on:
   `scripts/bench.sh --runs 10 --out base.json`. Also note the arguments
   package's `lake build` wall time and the kernel replay's wall time and peak
   memory (`ps` on `leanchecker`, or `/proc/<pid>/status`).
2. **Find the hotspot.** The slowest or heaviest benchmark, the slowest module
   in `lake build`'s output, or the replay's peak, profiled. Name it, and whether
   it is time or memory, before changing anything.
3. **Make one change**, aimed at that hotspot. One idea per candidate, so the
   measurement says which idea it was.
4. **Prove it sound**: every tier in `checking-the-build`, axiom audit and
   kernel replay included. A change that fails a gate is discarded, not tuned.
5. **Measure it**: `scripts/bench.sh --runs 10 --out new.json`, then
   `scripts/bench-compare.py base.json new.json`.
   - **IMPROVED** (exit 0), faster or lighter and nothing worse: keep it,
     commit it, and it is the new baseline.
   - **NO CHANGE** (exit 1): revert it. It costs code and buys nothing.
   - **REGRESSED** (exit 2), slower or heavier somewhere: revert it, unless
     the regression is in a benchmark the change was not aimed at and you can
     show why it is worth it, as time bought with memory that CI can spare; say
     so in the commit.
6. **Record the round** in `docs/src/performance.md`: the hypothesis, the
   benchmark it aimed at, the medians and peak memory before and after, p, and
   the verdict, kept or reverted. A reverted idea is recorded too, so nobody tries it again
   blind.
7. **Repeat from 2.**

**The fixed point.** Stop when three candidates in a row, each aimed at the
current largest hotspot, come back NO CHANGE. That is a local optimum of this
hill climb, not a proof that nothing faster exists; record it as such, with
the ideas tried. A new argument, or a new kind of check, moves the hotspots,
and the loop starts again.

## What tends to matter

From the first profile and the baseline in `docs/src/performance.md`, in rough
order of cost (re-measure; do not trust this list over a fresh profile):

- **The AIF check** (`#check_aif`, in `TestimonyArguments.Checks`) took 74 s
  at the baseline, more than every defeat table together, and is most of
  `Checks`' build time.
- **The arguments' largest modules** are sola fide's ratings, the checks over
  every argument, and the defeat tables of the largest disputes; half of sola
  fide's table takes 17 s and 204 MiB.
- **`Horn.satisfiable?`** is called several times per defeat cell, each time
  converting the attacker's whole position, meaning postulates included, to
  clauses and propagating from nothing. Work shared between cells is redone.
- **Membership is list search.** `Settled` holds lists, and every propagation
  step tests atoms with `List.elem`, evaluated by the kernel one comparison at
  a time.
- **Kernel replay** runs every module's replay as a task, each importing its
  own environment, so peak memory is about as many environments as run at
  once. `scripts/kernel-replay.sh` bounds them with `KERNEL_REPLAY_THREADS`
  (default 2: 8.9 GiB and 293 s on the arguments; 4 ran out of memory on a
  16 GB machine) and runs `leanchecker` without `lake env` resident beside it.
  Within a thread, the peak is set by the module whose own replay needs most:
  making that module's proofs lighter lowers the floor.

## The CI gate

The `build` job runs `scripts/bench.sh --runs 5` (the fewest repetitions with
which the U test can still reach p < 0.05, since the heaviest benchmark takes
over a minute a run) and compares it with
`arguments/bench/baseline.json`, normalized by the calibration benchmark, with
a 10% variance bound on time and the default bound on memory. It fails on a
significant slowdown or a rise in peak memory, and uploads every run's samples
as the `bench-results` artifact.

- **A regression the gate flags** is real until shown otherwise. Find it with
  the loop above and remove it.
- **Accepting a regression on purpose.** A robustness fix, or a check the
  engine did not make before, may be worth being slower or heavier. Say so in
  `arguments/bench/accepted.toml`, in the same PR: the benchmark, the metric
  (`time` or `memory`), `up_to` (the largest accepted change, as a fraction, a
  little above what the gate measured), `baseline` (the commit of the baseline
  it is accepted against, from `baseline.json`'s context) and the `reason`, in
  words a reviewer can weigh. The gate then reports it as accepted and passes;
  a larger regression still fails. Never widen `--threshold` or edit the
  baseline to make a regression pass: those hide it, where an entry shows it.
- **After the accepted change lands**, record a new baseline from `main`; the
  gate then reports the entry as stale, and it is removed in that PR.
- **Recording a new baseline**: after an improvement lands on `main`, take
  `bench-results.json` from that run's artifact and commit it as
  `arguments/bench/baseline.json`. The baseline must come from a CI runner, not
  a local machine: normalization corrects for speed, not for every difference
  between machines.
- **A benchmark added or renamed** is reported as "only in" one side and does
  not fail the gate; record a new baseline to start comparing it.
