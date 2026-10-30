#!/usr/bin/env bash
# Engine benchmarks: run arguments/bench/Engine.lean and report each
# benchmark's wall time and peak memory.
#
# Usage: scripts/bench.sh [--runs N] [--filter TEXT] [--out FILE.json]
#                         [--tree DIR] [--bench FILE.lean]
#
# Run from anywhere in the repository after `lake build` in arguments/.
#   --runs N        repetitions of every benchmark (default: each one's own)
#   --filter TEXT   only the benchmarks whose name contains TEXT
#   --out FILE      also write every sample as JSON in Google Benchmark's
#                   format, one entry per repetition, for
#                   scripts/bench-compare.py (or Google Benchmark's compare.py)
#   --tree DIR      measure the checkout at DIR, built, instead of this one
#   --bench FILE    the benchmarks to run (default: the tree's own
#                   arguments/bench/Engine.lean); scripts/bench-ab.sh runs the
#                   same file against both sides
#
# Each benchmark runs in a Lean process of its own, so that its peak memory is
# its own: Lean's allocator keeps freed memory for reuse, and a benchmark run
# after a hungrier one would seem to need none. It costs one import of the
# arguments' environment per benchmark.
#
# For an A/B comparison of a change, use scripts/bench-ab.sh, which runs this
# on both sides: see .claude/skills/optimising-the-engine.

set -euo pipefail

runs="" filter="" out="" tree="" bench=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --runs) runs="$2"; shift 2 ;;
    --filter) filter="$2"; shift 2 ;;
    --out) out="$2"; shift 2 ;;
    --tree) tree="$2"; shift 2 ;;
    --bench) bench="$(cd "$(dirname "$2")" && pwd)/$(basename "$2")"; shift 2 ;;
    *) echo "bench: unknown argument $1" >&2; exit 2 ;;
  esac
done

root="${tree:-$(dirname "$0")/..}"
root="$(cd "$root" && pwd)"
bench="${bench:-$root/arguments/bench/Engine.lean}"
cd "$root/arguments"
commit="$(git rev-parse HEAD 2>/dev/null || echo unknown)"
# The search path, asked of lake once: each benchmark's process is then plain
# `lean`, not `lake env lean`, which would stay resident beside it.
LEAN_PATH="$(lake env printenv LEAN_PATH)"
lean="$(lake env printenv LEAN_SYSROOT)/bin/lean"
export LEAN_PATH

BENCH_RUNS="$runs" BENCH_FILTER="$filter" python3 - "$out" "$commit" "$lean" "$bench" <<'EOF'
import json, os, re, subprocess, sys, time

out, commit, lean, FILE = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]


def lean_run(extra_env):
    proc = subprocess.run([lean, FILE], capture_output=True, text=True,
                          env={**os.environ, **extra_env})
    if proc.returncode != 0:
        sys.stdout.write(proc.stdout + proc.stderr)
        sys.exit(proc.returncode)
    return proc.stdout


filter_ = os.environ.get("BENCH_FILTER", "")
names = [n for n in re.findall(r"bench-name (.+)", lean_run({"BENCH_LIST": "1"}))
         if filter_ in n]
if not names:
    sys.exit("bench: no benchmark matches")

t0 = time.time()
rows = []
for name in names:
    text = lean_run({"BENCH_ONLY": name, "BENCH_FILTER": ""})
    m = re.search(
        r"bench (.+?): first ([0-9.]+) ms, min ([0-9.]+) ms, median ([0-9.]+) ms, "
        r"peak memory ([0-9.]+) MiB, samples \[([0-9., ]*)\]", text)
    if not m:
        sys.stdout.write(text)
        sys.exit(f"bench: no result for {name!r}")
    rows.append((name, float(m[2]), float(m[3]), float(m[4]), float(m[5]),
                 [float(x) for x in m[6].split(",")]))
    print(f"  {name}: median {float(m[4]):.1f} ms, peak +{float(m[5]):.0f} MiB",
          file=sys.stderr)
wall = time.time() - t0

width = max(len(r[0]) for r in rows)
print(f"{'benchmark':<{width}}  {'first ms':>10}  {'min ms':>10}  {'median ms':>10}  "
      f"{'peak MiB':>9}  runs")
for name, first, lo, med, mib, times in rows:
    print(f"{name:<{width}}  {first:>10.1f}  {lo:>10.1f}  {med:>10.1f}  {mib:>9.0f}  "
          f"{len(times)}")
print(f"\nwhole run: {wall:.0f} s, one process per benchmark")

if out:
    benchmarks = []
    for name, _, _, _, mib, times in rows:
        for i, t in enumerate(times):
            benchmarks.append({
                "name": name, "run_name": name, "run_type": "iteration",
                "repetitions": len(times), "repetition_index": i, "threads": 1,
                "iterations": 1, "real_time": t, "cpu_time": t, "time_unit": "ms",
                # A user counter, in Google Benchmark's terms: the benchmark's
                # peak memory above what its process held before it began.
                "peak_memory_mib": mib})
    context = {"date": time.strftime("%Y-%m-%dT%H:%M:%S%z"), "host_name": os.uname().nodename,
               "executable": FILE, "num_cpus": os.cpu_count(), "commit": commit,
               "wall_seconds": round(wall, 1)}
    with open(out, "w") as f:
        json.dump({"context": context, "benchmarks": benchmarks}, f, indent=1)
EOF
