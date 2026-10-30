# Performance: the engine, measured

Every argument the library adds makes every later check dearer: a dispute's
defeat table is one decision per ordered pair of parties, each decided in the
kernel over the parties' premises and the argument's meaning postulates. So the
engine is made faster and lighter as a loop, measured at each step, until a
further change makes no significant difference. How to run the loop is in the
`optimising-the-engine` skill (`.claude/skills/optimising-the-engine`); this
page is its ledger: what was measured, what was tried, and what came of it.

## How it is measured

- **Benchmarks** (`arguments/bench/Engine.lean`, run by `scripts/bench.sh`):
  copies of real proofs and checks, each timed with the kernel's work included,
  with its peak memory above what its process held before. Each benchmark runs
  in a Lean process of its own.
- **Comparison** (`scripts/bench-ab.sh`, `scripts/bench-compare.py`): an
  ablation. The code with a change and without it are built side by side on one
  machine and run interleaved, and each benchmark is compared by the two-sided
  Mann-Whitney U test, as Google Benchmark's `compare.py` does it. A change
  counts when p < 0.05 and it is larger than the variance bound. Peak memory is
  compared by threshold. A calibration benchmark, which no change can move,
  shows whether the machine drifted during the run.
- **CI** runs the A/B on every pull request, against the base it merges into,
  and fails on a regression that the pull request does not accept, with its
  reason, in `arguments/bench/accepted.toml`.
- **Build and kernel replay** are measured by hand, as below, until they have a
  gate of their own.

## Baseline

Measured on 30 October 2026, at `main` after #171, on a 4-core, 16 GB cloud
container (the shape of CI's runner), three runs per benchmark, one run of each
check.

| Benchmark | Median | Peak memory |
|---|---:|---:|
| checks: AIF, every dispute | 73.6 s | 26 MiB |
| table: sola fide, first half, 72 cells | 16.7 s | 204 MiB |
| checks: postulates, every package | 7.3 s | 29 MiB |
| checks: refutations survive their postulates | 5.3 s | 28 MiB |
| checks: ontology | 4.2 s | 23 MiB |
| table: Septuagint, 36 cells | 3.5 s | 35 MiB |
| calibration: kernel list reduction | 297 ms | 58 MiB |
| assessment: Miller against the laws | 212 ms | 28 MiB |
| refute_with: Wegner rests on his inference | 130 ms | 2 MiB |
| cell: status reading defeats Wegner | 74 ms | 11 MiB |
| establish: Miller's case | 66 ms | 6 MiB |
| rating: fruit, not ground | 34 ms | 9 MiB |
| verdict: sola fide, only Paul's word unanswered | 29 ms | 6 MiB |
| rating: the laws' step, three standards | 28 ms | 5 MiB |
| verdict: Septuagint, grounded in stages | 17 ms | 4 MiB |

The first run of each benchmark is 10–40% slower than the rest: warm-up, not a
cache that would let later runs skip the work.

| Stage | Wall time | Peak memory |
|---|---:|---:|
| Library, `lake build` (Mathlib cached) | 25 s | 2.2 GiB |
| Arguments, `lake build` | 490 s | 5.6 GiB |
| Arguments, kernel replay, 4 threads (the old default) | killed | ≥ 13 GiB |
| Arguments, kernel replay, 2 threads | 293 s | 8.9 GiB |
| Arguments, kernel replay, 1 thread | 500 s | ≈ 5.2 GiB |

The slowest modules of the arguments' build: `SolaFide.Ratings` (150 s),
`Checks` (101 s, most of it the AIF check), `SolaFide.Dispute` (81 s),
`Meanings.SolaFide` (74 s) and `CanonicalWitness.Results` (46 s).

## Rounds

| # | Hypothesis | Aimed at | Before | After | p | Verdict |
|---|---|---|---:|---:|---:|---|
| 1 | Bound the kernel replay's concurrent environments to 2, and run `leanchecker` without `lake env` | replay memory | killed at ≥ 13 GiB | 8.9 GiB, 293 s | — | kept |
| 2 | Ask each question of satisfiability once (#177) | the AIF check | 67.4 s | 3.75 s | 0.008 | kept |

Round 2, `scripts/bench-ab.sh` against the commit before, five interleaved
rounds. `Horn.clausesSatisfiable?` propagated up to five times per question,
`Horn.stepRebuts?` and `Horn.defeats?` made their checks twice, and
`Aif.attacks` re-asked, for its preferences, what the attack checks had just
asked. Run by the interpreter, as the checks over every argument are, each copy
was evaluated: the AIF check fell from 67.4 s to 3.75 s (−94%, p = 0.008), the
postulates check by 20% (p = 0.008) and the refutations check by 24%
(p = 0.016). The kernel-decided benchmarks did not move (every p ≥ 0.17): the
kernel was already sharing the repeated terms. Peak memory did not move, and
the calibration benchmark showed no drift. One side of a benchmark run fell
from 146 s to 76 s.

Round 1 was measured by hand, before the benchmarks existed. `leanchecker`
replays each module as a task of its own, each importing that module's whole
environment, and Lean runs one task per core: four environments at once ran out
of memory. Two run in 293 s; one in 500 s with about 5.2 GiB.

## Fixed points

None yet. After round 2 the largest benchmark is half of sola fide's defeat
table, 16 s and 203 MiB, decided in the kernel; the repeated work the kernel
was already sharing is not what costs it. Its next hypothesis is that every
satisfiability check propagates from nothing (#179).
