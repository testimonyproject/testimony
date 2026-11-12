#!/usr/bin/env bash
# Ablation A/B of the engine: measure this checkout and the same code with its
# change backed out, on the same machine, interleaved, and compare them.
#
# Usage: scripts/bench-ab.sh BASE-REF [--runs N] [--filter TEXT] [--shard K/N]
#                                     [--out DIR] [--gate] [--no-confirm]
#
#   BASE-REF       the revision without the change: in CI, HEAD^1 of a pull
#                  request's merge commit, the base it would merge into
#   --runs N       interleaved rounds (default 5): each round runs every
#                  benchmark once on this checkout and once on the base
#   --filter TEXT  only the benchmarks whose name contains TEXT
#   --shard K/N    only the K-th of N shards, as scripts/bench.sh takes it: CI
#                  runs each shard as a job of its own, on a machine of its own,
#                  and each is a whole A/B, with its own calibration and gate
#   --out DIR      where to keep base.json and head.json (default: a temporary
#                  directory)
#   --gate         exit 2 on an unaccepted regression and 0 otherwise, for CI
#   --no-confirm   report the first reading's slowdowns as they are, without
#                  measuring them again (below)
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
# whether it did.
#
# A slowdown in time is measured again before it counts: the benchmark alone,
# in extra interleaved rounds (five, fewer for a long benchmark), then both
# readings pooled and compared at p < 0.01. The first reading, at p < 0.05 on
# five samples a side, raised a false alarm in about a third of CI's runs; the
# second costs nothing when nothing is flagged, and 40 s to about 70 s a
# flagged benchmark when one is. Its samples are base-pooled.json and
# head-pooled.json.
#
# Regressions the change accepts on purpose are those it adds
# to arguments/bench/accepted.toml: an entry already in the base accepts
# nothing. See .claude/skills/optimising-the-engine.

set -euo pipefail

base_ref="" runs=5 filter="" shard="" out="" gate="" no_confirm=""
# The second reading's bar: see scripts/bench-compare.py.
confirm_alpha=0.01
while [[ $# -gt 0 ]]; do
  case "$1" in
    --runs) runs="$2"; shift 2 ;;
    --filter) filter="$2"; shift 2 ;;
    --shard) shard="$2"; shift 2 ;;
    --out) out="$2"; shift 2 ;;
    --gate) gate="--gate"; shift ;;
    --no-confirm) no_confirm=1; shift ;;
    -*) echo "bench-ab: unknown argument $1" >&2; exit 2 ;;
    *) base_ref="$1"; shift ;;
  esac
done
if [[ -z "$base_ref" ]]; then
  echo "usage: scripts/bench-ab.sh BASE-REF [--runs N] [--filter TEXT] [--shard K/N]" \
    "[--out DIR] [--gate] [--no-confirm]" >&2
  exit 2
fi
# Checked here too, before the base is built, not only by bench.sh after it.
if [[ -n "$shard" && ! "$shard" =~ ^([1-9][0-9]*)/([1-9][0-9]*)$ ]] \
    || [[ -n "$shard" && "${BASH_REMATCH[1]}" -gt "${BASH_REMATCH[2]}" ]]; then
  echo "bench-ab: --shard takes K/N with 1 <= K <= N, not $shard" >&2; exit 2
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
      ${filter:+--filter "$filter"} ${shard:+--shard "$shard"} --out "$out/$side-$i.json" >/dev/null
  done
done

# Files of samples, merged into one: every repetition of a benchmark numbered
# in turn, so that a benchmark measured again has its new samples after its old.
merge() {
  python3 - "$@" <<'EOF'
import json, sys
dest, commit, sources = sys.argv[1], sys.argv[2], sys.argv[3:]
merged, seen = {"context": None, "benchmarks": []}, {}
for path in sources:
    with open(path) as f:
        data = json.load(f)
    merged["context"] = merged["context"] or data["context"]
    for b in data["benchmarks"]:
        b["repetition_index"] = seen.get(b["name"], 0)
        seen[b["name"]] = b["repetition_index"] + 1
        merged["benchmarks"].append(b)
for b in merged["benchmarks"]:
    b["repetitions"] = seen[b["name"]]
merged["context"]["commit"] = commit
with open(dest, "w") as f:
    json.dump(merged, f, indent=1)
EOF
}

head_commit="$(git -C "$head" rev-parse HEAD)"
base_rounds=() head_rounds=()
for i in $(seq 1 "$runs"); do
  base_rounds+=("$out/base-$i.json")
  head_rounds+=("$out/head-$i.json")
done
merge "$out/base.json" "$base_commit" "${base_rounds[@]}"
merge "$out/head.json" "$head_commit" "${head_rounds[@]}"

git -C "$base" show "HEAD:arguments/bench/accepted.toml" >"$out/base-accepted.toml" 2>/dev/null \
  || : >"$out/base-accepted.toml"
compare() {
  "$head/scripts/bench-compare.py" "$@" \
    --accept "$head/arguments/bench/accepted.toml" --accept-base "$out/base-accepted.toml" \
    --drift "calibration: kernel list reduction" $gate
}
log "comparing; the samples are in $out"
status=0
compare "$out/base.json" "$out/head.json" --plan "$out/plan.json" || status=$?

# A slowdown is measured again before it fails anything (bench-compare.py says
# why): each benchmark that regressed in time, in extra interleaved rounds of
# its own, fewer for the long ones, then both readings pooled and compared at
# p < 0.01. A rise in peak memory has no samples to add, so it stands
# as it was found, and beside one there is nothing to confirm.
plan="$(python3 - "$out/plan.json" <<'EOF'
import json, sys
with open(sys.argv[1]) as f:
    plan = json.load(f)
if not plan["memory"]:
    for c in plan["confirm"]:
        print(f"{c['rounds']}\t{c['benchmark']}")
EOF
)"
if [[ "$status" -eq 2 && -n "$plan" && -z "$no_confirm" ]]; then
  log "measuring each slowdown again"
  # Round by round, every benchmark that still has rounds to go, in one call a
  # side: each call costs a second or two of setup before its first benchmark.
  declare -A rounds_of=()
  while IFS=$'\t' read -r rounds name; do rounds_of["$name"]="$rounds"; done <<<"$plan"
  extra_base=() extra_head=()
  for i in $(seq 1 "$(printf '%s\n' "${rounds_of[@]}" | sort -n | tail -1)"); do
    names=()
    for name in "${!rounds_of[@]}"; do
      if (( rounds_of["$name"] >= i )); then names+=(--name "$name"); fi
    done
    for side in head base; do
      tree="$head"; [[ "$side" == base ]] && tree="$base"
      log "again, round $i: $side, $(( ${#names[@]} / 2 )) benchmark(s)"
      "$head/scripts/bench.sh" --tree "$tree" --bench "$bench" --runs 1 "${names[@]}" \
        --out "$out/again-$side-$i.json" >/dev/null
      if [[ "$side" == base ]]; then extra_base+=("$out/again-$side-$i.json")
      else extra_head+=("$out/again-$side-$i.json"); fi
    done
  done
  merge "$out/base-pooled.json" "$base_commit" "$out/base.json" "${extra_base[@]}"
  merge "$out/head-pooled.json" "$head_commit" "$out/head.json" "${extra_head[@]}"
  log "comparing both readings, pooled, at p < $confirm_alpha"
  status=0
  compare "$out/base-pooled.json" "$out/head-pooled.json" \
    --alpha "$confirm_alpha" --no-memory || status=$?
fi
exit "$status"
