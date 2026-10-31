---
name: optimising-the-engine
description: Use when making the Testimony library's engine faster or lighter — build time, memory, kernel replay, the decide +kernel checks behind defeat tables, verdicts, assessments and ratings — or when a change may have slowed it or made it heavier. Covers the benchmark suite, the ablation A/B and its statistics, the fixed-point loop, the CI regression gate and accepting a regression on purpose.
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
scripts/bench-ab.sh origin/main               # this checkout against main: the A/B
scripts/bench-ab.sh HEAD~1 --filter table     # against the last commit, tables only
scripts/bench.sh                              # every benchmark once: time and peak memory
scripts/bench-compare.py a.json b.json        # Mann-Whitney U, alpha 0.05
```

- **`scripts/bench-ab.sh BASE`** is the measurement the loop and CI use: an
  ablation. It checks the base out beside this checkout, builds it
  incrementally from this checkout's build, runs this checkout's benchmarks on
  both, interleaved round by round so that drift on the machine falls on both
  sides alike, and compares them. Both sides run on one machine, so no recorded
  baseline is needed, and none is kept.
- **`arguments/bench/Engine.lean`** holds the benchmarks. It is in no build
  target; `bench.sh` runs it after `lake build` in `arguments/`. Each
  benchmark is a copy of a real proof or check inside `#bench`, which times
  elaboration with the kernel check included
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
- **The calibration benchmark** does kernel work that touches nothing of the
  library's, so no change can move it. In an A/B, `--drift` compares it like
  any other, and a difference in it means the machine drifted during the run:
  the verdicts are then suspect, and the run should be repeated. Comparing runs
  from two machines, `--normalize` divides by it instead. Never change it.
- **Profiling**, to find what to change: `set_option profiler true` (or
  `lean --profile`) for time per declaration, by phase; `set_option
  trace.profiler true` with `trace.profiler.output "x.json"` for a flame graph
  in Firefox Profiler; `set_option diagnostics true` for what the kernel
  unfolded most. Kernel time is what `decide +kernel` costs; heartbeats measure
  the elaborator, not the kernel.

## The loop

1. **Know where you start**: `scripts/bench.sh` for every benchmark's time and
   memory, the arguments package's `lake build` wall time, and the kernel
   replay's wall time and peak memory (`ps` on `leanchecker`, or
   `/proc/<pid>/status`).
2. **Find the hotspot.** The slowest or heaviest benchmark, the slowest module
   in `lake build`'s output, or the replay's peak, profiled. Name it, and whether
   it is time or memory, before changing anything.
3. **Make one change**, aimed at that hotspot. One idea per candidate, so the
   measurement says which idea it was.
4. **Prove it sound**: every tier in `checking-the-build`, axiom audit and
   kernel replay included. A change that fails a gate is discarded, not tuned.
5. **Measure it** against the commit before it:
   `scripts/bench-ab.sh HEAD~1 --runs 10` once it is committed (or against
   `origin/main` for everything on the branch). Ten rounds give the test more
   power than CI's five; `--filter` keeps a round short while you iterate.
   - **IMPROVED** (exit 0), faster or lighter and nothing worse: keep it.
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

- **The checks over every argument run the engine in the interpreter**
  (`evalExpr`), which evaluates every repeated term; the kernel shares them.
  So repeated work costs the checks and not the proofs: removing it (#177) took
  the AIF check from 67 s to 3.8 s and left the defeat tables where they were.
- **The kernel checks certificates, not searches** (#183). A defeat cell
  proved with `horn_certify` has its search run at elaboration and only a model
  or a propagation trace per question checked by the kernel; that halved the
  defeat tables. What a cell costs now: converting both positions to clauses,
  in the kernel, and the search, in the interpreter, about equally. Verdicts,
  assessments, ratings and the postulate checks still search in the kernel.
- **A function `evalExpr` calls is compiled at the call** unless it is
  `@[nospecialize]`: specialized at each cell, the certificate search cost
  50 ms a cell in compilation alone. Read `profiler`'s `compilation` lines.
- **Membership is list search.** `Settled` holds lists, and a replay tests
  atoms with `List.elem`; a model is already a bitmask (#180).
- **Kernel replay** runs every module's replay as a task, each importing its
  own environment, so peak memory is about as many environments as run at
  once. `scripts/kernel-replay.sh` bounds them with `KERNEL_REPLAY_THREADS`
  (default 2: 8.9 GiB and 293 s on the arguments; 4 ran out of memory on a
  16 GB machine) and runs `leanchecker` without `lake env` resident beside it.
  Within a thread, the peak is set by the module whose own replay needs most:
  making that module's proofs lighter lowers the floor.

## The CI gate

On every pull request the `build` job runs `scripts/bench-ab.sh HEAD^1 --runs 5
--gate`: the merge commit against the base it merges into, five interleaved
rounds (the fewest with which the U test can still reach p < 0.05, since the
heaviest benchmark takes over a minute a run). It fails on a significant
slowdown beyond the variance bound, or a rise in peak memory, and uploads both
sides' samples and the base's build log as the `bench-results` artifact.

- **A regression the gate flags** is real until shown otherwise. Find it with
  the loop above and remove it.
- **If the calibration benchmark differs**, the runner drifted, and the gate's
  verdicts are suspect; re-run the job once before acting on them.
- **Accepting a regression on purpose.** A robustness fix, or a check the
  engine did not make before, may be worth being slower or heavier. Say so in
  `arguments/bench/accepted.toml`, in the same PR: the benchmark, the metric
  (`time` or `memory`), `up_to` (the largest accepted change, as a fraction, a
  little above what the gate measured) and the `reason`, in words a reviewer
  can weigh. The gate then reports it as accepted and passes; a larger
  regression still fails. Only entries the PR adds count: once it merges, they
  are in the base and accept nothing more, and can be removed. Never widen the
  thresholds to make a regression pass: that hides it, where an entry shows it.
- **A benchmark that does not elaborate against the base**, because it uses
  what the PR adds, is run on this side only and reported as such; keep the
  benchmark it replaces, unchanged, beside it, so that the A/B still measures
  the old form against the base. Only if the file's imports are missing from
  the base does nothing compare: the step then says so and passes, and the PR
  says what the change costs, measured by hand.
- **A benchmark added or renamed** is reported as only in one side and does not
  fail the gate.
