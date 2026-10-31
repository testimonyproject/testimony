#!/usr/bin/env bash
# Ablation A/B of the engine: measure this checkout and the same code with its
# change backed out, on the same machine, interleaved, and compare them.
#
# Usage: scripts/bench-ab.sh BASE-REF [--runs N] [--filter TEXT] [--out DIR]
#                                     [--gate]
#
#   BASE-REF       the revision without the change: in CI, HEAD^1 of a pull
#                  request's merge commit, the base it would merge into
#   --runs N       interleaved rounds (default 5): each round runs every
#                  benchmark once on this checkout and once on the base
#   --filter TEXT  only the benchmarks whose name contains TEXT
#   --out DIR      where to keep base.json and head.json (default: a temporary
#                  directory)
#   --gate         exit 2 on an unaccepted regression and 0 otherwise, for CI
#
# Run from this checkout after `lake build` in arguments/. The base is checked
# out in a worktree beside it and built incrementally: this checkout's build
# output is copied in first, its executables aside, so lake rebuilds only what
# the change touched, and Mathlib's packages are shared, not copied.
#
# Both sides run this checkout's benchmarks (arguments/bench/Engine.lean), so
# that they measure the same work. A benchmark that does not elaborate against
# the base, because it uses what the change adds, has no base side and is
# reported as only in this checkout; the others are compared. If none does,
# not even the calibration benchmark, because the file's imports are not in the
# base, there is nothing to compare, and the script says so and exits 0.
#
# The rounds alternate, so that drift on the machine falls on both sides alike;
# the calibration benchmark, which nothing in the library can change, shows
# whether it did. Regressions the change accepts on purpose are those it adds
# to arguments/bench/accepted.toml: an entry already in the base accepts
# nothing. See .claude/skills/optimising-the-engine.

set -euo pipefail

base_ref="" runs=5 filter="" out="" gate=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --runs) runs="$2"; shift 2 ;;
    --filter) filter="$2"; shift 2 ;;
    --out) out="$2"; shift 2 ;;
    --gate) gate="--gate"; shift ;;
    -*) echo "bench-ab: unknown argument $1" >&2; exit 2 ;;
    *) base_ref="$1"; shift ;;
  esac
done
if [[ -z "$base_ref" ]]; then
  echo "usage: scripts/bench-ab.sh BASE-REF [--runs N] [--filter TEXT] [--out DIR] [--gate]" >&2
  exit 2
fi

head="$(cd "$(dirname "$0")/.." && pwd)"
base_commit="$(git -C "$head" rev-parse --verify "$base_ref^{commit}")"
out="${out:-$(mktemp -d)}"
mkdir -p "$out"
# Absolute, since the base is built from inside its own tree.
out="$(cd "$out" && pwd)"
base="$out/base-tree"
log() { echo "bench-ab: $*" >&2; }

# The base, in a worktree of its own, removed on exit.
cleanup() { git -C "$head" worktree remove --force "$base" 2>/dev/null || true; }
trap cleanup EXIT
cleanup
git -C "$head" worktree add --detach --quiet "$base" "$base_commit"

# Build it incrementally from this checkout's build output; share the packages.
# The benchmarks need the arguments' modules, not their executables, which are
# most of the build output's size: CI's runner ran out of disk copying them.
log "building the base, $base_commit, from this checkout's build"
mkdir -p "$base/.lake" "$base/arguments/.lake/build"
ln -s "$head/.lake/packages" "$base/.lake/packages"
cp -a "$head/.lake/build" "$base/.lake/build"
for part in "$head/arguments/.lake/build"/*; do
  [[ "$(basename "$part")" == bin ]] || cp -a "$part" "$base/arguments/.lake/build/"
done
(cd "$base/arguments" && lake build TestimonyArguments >"$out/base-build.log" 2>&1) || {
  log "the base does not build; see $out/base-build.log"
  exit 1
}

# This checkout's benchmarks, against the base: if not even the calibration
# benchmark elaborates there, there is nothing to compare.
bench="$head/arguments/bench/Engine.lean"
if ! "$head/scripts/bench.sh" --tree "$base" --bench "$bench" --runs 1 \
    --filter "calibration" >"$out/probe.log" 2>&1; then
  log "this checkout's benchmarks do not build against the base; no A/B (see $out/probe.log)"
  exit 0
fi

# Interleaved rounds: this checkout, then the base, once per benchmark each.
for i in $(seq 1 "$runs"); do
  for side in head base; do
    tree="$head"; [[ "$side" == base ]] && tree="$base"
    log "round $i of $runs: $side"
    "$head/scripts/bench.sh" --tree "$tree" --bench "$bench" --runs 1 \
      ${filter:+--filter "$filter"} --out "$out/$side-$i.json" >/dev/null
  done
done

# The rounds, merged into one file per side.
python3 - "$out" "$runs" "$base_commit" "$(git -C "$head" rev-parse HEAD)" <<'EOF'
import json, sys
out, runs, base_commit, head_commit = sys.argv[1], int(sys.argv[2]), sys.argv[3], sys.argv[4]
for side, commit in (("base", base_commit), ("head", head_commit)):
    merged = {"context": None, "benchmarks": []}
    for i in range(1, runs + 1):
        with open(f"{out}/{side}-{i}.json") as f:
            data = json.load(f)
        merged["context"] = merged["context"] or data["context"]
        for b in data["benchmarks"]:
            b["repetition_index"], b["repetitions"] = i - 1, runs
            merged["benchmarks"].append(b)
    merged["context"]["commit"] = commit
    with open(f"{out}/{side}.json", "w") as f:
        json.dump(merged, f, indent=1)
EOF

git -C "$base" show "HEAD:arguments/bench/accepted.toml" >"$out/base-accepted.toml" 2>/dev/null \
  || : >"$out/base-accepted.toml"
log "comparing; the samples are in $out"
"$head/scripts/bench-compare.py" "$out/base.json" "$out/head.json" \
  --accept "$head/arguments/bench/accepted.toml" --accept-base "$out/base-accepted.toml" \
  --drift "calibration: kernel list reduction" $gate
