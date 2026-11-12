#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["scipy>=1.11"]
# ///
"""Compare two engine benchmark runs, as Google Benchmark's compare.py does.

Usage: scripts/bench-compare.py BASELINE.json CONTENDER.json [options]

Run it directly; `uv` reads the requirements above and provides them. Both files
are written by `scripts/bench.sh --out`, in Google Benchmark's JSON format, one
entry per repetition. For each benchmark in both, it prints the medians, the
change, and the p-value of the two-sided Mann-Whitney U test, which is the test
compare.py uses.

A change counts only when it is both significant and large enough:

  p < --alpha (default 0.05), and the medians differ by more than
  --threshold (default 0.05, five per cent) — the variance bound, below which
  a difference is noise however small its p-value.

Peak memory, one figure per benchmark from a process of its own, is close to
deterministic and has no samples to test: a change in it counts when it is
larger than --mem-threshold (default 0.10) and than --mem-floor MiB (default 32).

A benchmark whose samples are too spread to compare, with a coefficient of
variation above --max-cv on either side (default 0.25), is reported as noisy and
counts neither way.

--normalize NAME divides every sample by the median of benchmark NAME in the
same file, so that runs on different machines can be compared: the engine's
benchmarks become multiples of the calibration benchmark's time. An A/B run on
one machine (scripts/bench-ab.sh) needs no normalizing; it passes --drift NAME
instead, which compares that benchmark like any other but, since no change to
the library can move it, reports a difference in it as the machine drifting,
not as a verdict.

The verdict, for the fixed-point loop (.claude/skills/optimising-the-engine):

  IMPROVED    some benchmark is faster or lighter, none slower or heavier
  REGRESSED   some benchmark is slower, or needs more memory
  NO CHANGE   nothing changed significantly

Exit status: 0 for IMPROVED, 1 for NO CHANGE, 2 for REGRESSED, 3 on bad input.
With --gate, as CI uses it: 2 for REGRESSED, 0 otherwise.

A slowdown found this way is a first reading, not yet a verdict. With five
samples a side the test can reach only a few p-values, and p < 0.05 means the
new samples beat the old in all but two of the 25 pairings: with no change at
all, chance does that to a benchmark 1.6% of the time. A benchmark of a few
milliseconds varies by more than the 5% threshold from run to run, so the
threshold does not filter it, and across the thirty-odd benchmarks a run had a
one-in-three chance of a false alarm. So scripts/bench-ab.sh measures each
slowdown again before it fails anything, and --plan FILE writes what to
measure: each benchmark that regressed in time, unaccepted, with the extra
rounds it gets (CONFIRM_ROUNDS), fewer for the long ones, whose runs vary less
and cost more. The second comparison pools both readings and asks for p < 0.01
(--alpha), with --no-memory, since peak memory has no samples to add and was
judged the first time. Simulated over Gaussian samples, the two together cut a
run's chance of a false alarm about tenfold, and catch nearly every slowdown
the first reading alone caught.

--accept FILE reads regressions accepted on purpose, from a TOML file of
[[accept]] entries, each with benchmark, metric ("time" or "memory"), up_to
(the largest accepted change, as a fraction) and reason. A regression within its
entry's bound is reported as accepted and does not count; a larger one still
does. With --accept-base FILE, the same file as the base had it, only the
entries the change adds count: one already in the base accepted a regression
that is now in the base, and accepts nothing more.
"""

import argparse
import json
import statistics
import sys
import tomllib

from scipy.stats import mannwhitneyu

# With fewer repetitions on either side the test cannot reach p < 0.05 at all,
# so compare.py warns; this script refuses.
MIN_REPETITIONS = 4

# Extra interleaved rounds to measure a flagged slowdown again, by the
# benchmark's median on the base, in milliseconds: (below this, rounds). Each
# run costs about 4 s before the benchmark starts (lake's paths, then a Lean
# process of its own importing the arguments), so a benchmark of a few
# milliseconds is cheap to measure again and one of fourteen seconds is not. A
# long benchmark also varies less, relative to its time, and needs fewer
# samples. Measured: 40 s for a short benchmark's five rounds a side; by the
# same reckoning about 70 s for a 2 s benchmark's five, an 8 s one's three or
# a 14 s one's two. Two extra rounds, seven samples a side, can still reach
# p < 0.001.
CONFIRM_ROUNDS = ((2000.0, 5), (8000.0, 3), (float("inf"), 2))


def confirm_rounds(median_ms):
    """The extra rounds a slowdown in a benchmark of this median gets."""
    return next(r for bound, r in CONFIRM_ROUNDS if median_ms < bound)


def samples(path):
    """The repetitions of each benchmark in a Google Benchmark JSON file, the
    peak memory of each benchmark that records one, and the file's context."""
    with open(path) as f:
        data = json.load(f)
    out, memory = {}, {}
    for b in data["benchmarks"]:
        if b.get("run_type", "iteration") != "iteration":
            continue  # aggregates (mean, median, stddev) are not samples
        name = b.get("run_name", b["name"])
        out.setdefault(name, []).append(float(b["real_time"]))
        if "peak_memory_mib" in b:
            memory[name] = max(memory.get(name, 0.0), float(b["peak_memory_mib"]))
    return out, memory, data.get("context", {})


def normalized(runs, name, path):
    """Every benchmark's samples as multiples of benchmark `name`'s median."""
    if name not in runs:
        sys.exit(f"bench-compare: {path} has no benchmark {name!r} to normalize by")
    unit = statistics.median(runs[name])
    return {k: [t / unit for t in v] for k, v in runs.items() if k != name}


def entries(path):
    """The [[accept]] entries of an accepted.toml, checked; none if no file."""
    if not path:
        return []
    try:
        with open(path, "rb") as f:
            found = tomllib.load(f).get("accept", [])
    except FileNotFoundError:
        return []
    for e in found:
        missing = [k for k in ("benchmark", "metric", "up_to", "reason")
                   if not str(e.get(k, "")).strip()]
        if missing:
            sys.exit(f"bench-compare: an entry of {path} has no {', '.join(missing)}: {e}")
        if e["metric"] not in ("time", "memory"):
            sys.exit(f"bench-compare: metric must be time or memory: {e}")
    return found


def acceptances(path, base_path):
    """The regressions this change accepts, keyed by (benchmark, metric): the
    entries of `path` that are not already in `base_path`."""
    old = entries(base_path)
    return {(e["benchmark"], e["metric"]): e for e in entries(path) if e not in old}


def cv(xs):
    """Coefficient of variation: the spread of the samples, relative to their mean."""
    mean = statistics.fmean(xs)
    return statistics.stdev(xs) / mean if len(xs) > 1 and mean else 0.0


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("baseline")
    parser.add_argument("contender")
    parser.add_argument("--alpha", type=float, default=0.05)
    parser.add_argument("--threshold", type=float, default=0.05)
    parser.add_argument("--max-cv", type=float, default=0.25)
    parser.add_argument("--normalize", metavar="NAME")
    parser.add_argument("--mem-threshold", type=float, default=0.10)
    parser.add_argument("--mem-floor", type=float, default=32.0)
    parser.add_argument("--accept", metavar="TOML",
                        help="regressions accepted on purpose, with reasons")
    parser.add_argument("--accept-base", metavar="TOML",
                        help="the same file as the base had it; only entries added count")
    parser.add_argument("--drift", metavar="NAME",
                        help="a benchmark no change can move; a difference in it is drift")
    parser.add_argument("--gate", action="store_true",
                        help="exit 2 on a regression and 0 otherwise, for CI")
    parser.add_argument("--plan", metavar="JSON",
                        help="write the slowdowns to measure again, and their rounds")
    parser.add_argument("--no-memory", action="store_true",
                        help="compare time only, as the second reading does")
    args = parser.parse_args(argv[1:])

    base, base_mem, base_ctx = samples(args.baseline)
    cont, cont_mem, cont_ctx = samples(args.contender)
    unit = "ms"
    if args.normalize:
        base = normalized(base, args.normalize, args.baseline)
        cont = normalized(cont, args.normalize, args.contender)
        unit = "x cal"
    common = [name for name in base if name in cont]
    if not common:
        print("bench-compare: no benchmark is in both files")
        return 3

    for label, ctx in (("baseline", base_ctx), ("contender", cont_ctx)):
        print(f"{label:<9} {str(ctx.get('commit', '?'))[:12]}  "
              f"whole run {ctx.get('wall_seconds', '?')} s")
    print(f"alpha {args.alpha}, threshold {args.threshold:.0%}, max cv {args.max_cv:.0%}"
          + (f", normalized by {args.normalize!r}" if args.normalize else ""))
    width = max(len(n) for n in common)
    print(f"\n{'benchmark':<{width}}  {'base ' + unit:>10}  {'new ' + unit:>10}  "
          f"{'change':>8}  {'p':>7}  verdict")

    improved, regressed, noisy = [], [], []
    medians = {}
    for name in common:
        xs, ys = base[name], cont[name]
        if min(len(xs), len(ys)) < MIN_REPETITIONS:
            print(f"{name:<{width}}  too few repetitions ({len(xs)}, {len(ys)}); "
                  f"record with --runs {MIN_REPETITIONS} or more")
            continue
        mx, my = statistics.median(xs), statistics.median(ys)
        medians[name] = mx
        change = (my - mx) / mx if mx else 0.0
        p = mannwhitneyu(xs, ys, alternative="two-sided").pvalue
        if max(cv(xs), cv(ys)) > args.max_cv:
            verdict = f"noisy (cv {cv(xs):.0%}, {cv(ys):.0%})"
            noisy.append(name)
        elif p < args.alpha and change < -args.threshold:
            verdict = "faster"
            improved.append(name)
        elif p < args.alpha and change > args.threshold:
            verdict = "SLOWER"
            regressed.append((name, "time", change))
        else:
            verdict = "-"
        print(f"{name:<{width}}  {mx:>10.3f}  {my:>10.3f}  {change:>+8.1%}  {p:>7.4f}  {verdict}")

    for name in sorted(set(base) ^ set(cont)):
        print(f"{name:<{width}}  only in the {'baseline' if name in base else 'contender'}")

    # Peak memory: one figure per benchmark and run, from a process of its own,
    # so there is no sample to test; it is close to deterministic, and a change
    # counts when it is larger than --mem-threshold and than --mem-floor MiB.
    mem_common = [name for name in common if name in base_mem and name in cont_mem]
    if mem_common and not args.no_memory:
        print(f"\npeak memory, threshold {args.mem_threshold:.0%} and {args.mem_floor:.0f} MiB")
        print(f"{'benchmark':<{width}}  {'base MiB':>10}  {'new MiB':>10}  {'change':>8}  verdict")
        for name in mem_common:
            mx, my = base_mem[name], cont_mem[name]
            change = (my - mx) / mx if mx else 0.0
            if abs(my - mx) <= args.mem_floor or abs(change) <= args.mem_threshold:
                verdict = "-"
            elif my < mx:
                verdict = "less"
                improved.append(name + " (memory)")
            else:
                verdict = "MORE"
                regressed.append((name, "memory", change))
            print(f"{name:<{width}}  {mx:>10.0f}  {my:>10.0f}  {change:>+8.1%}  {verdict}")

    if noisy:
        print(f"\n{len(noisy)} too noisy to compare: {', '.join(noisy)}")

    # The drift benchmark: a difference in it is the machine, not the change.
    drifted = [r for r in regressed if r[0] == args.drift]
    drifted += [args.drift] if args.drift in improved else []
    if args.drift:
        regressed = [r for r in regressed if r[0] != args.drift]
        improved = [i for i in improved if i != args.drift]
    if drifted:
        print(f"\nWARNING: {args.drift!r}, which no change can move, differs between the "
              "sides: the machine drifted during the run, and every verdict here is suspect")

    # Regressions the change accepts on purpose, up to a stated bound, with its
    # reason: the entries it adds to accepted.toml.
    live = acceptances(args.accept, args.accept_base)
    unaccepted = []
    for name, metric, change in regressed:
        entry = live.pop((name, metric), None)
        if entry and change <= float(entry["up_to"]):
            print(f"\naccepted: {name} ({metric}) {change:+.1%}, up to "
                  f"{float(entry['up_to']):+.0%}: {entry['reason']}")
        else:
            if entry:
                print(f"\n{name} ({metric}) {change:+.1%} exceeds its accepted "
                      f"{float(entry['up_to']):+.0%}")
            unaccepted.append((name, metric))
    for e in live.values():
        print(f"\nnote: accepted regression not seen: {e['benchmark']} ({e['metric']})")

    if args.plan:
        slower = [name for name, metric in unaccepted if metric == "time"]
        with open(args.plan, "w") as f:
            json.dump({
                "confirm": [{"benchmark": name, "rounds": confirm_rounds(medians[name]),
                             "median_ms": medians[name]} for name in slower],
                "memory": [name for name, metric in unaccepted if metric == "memory"],
            }, f, indent=1)

    if unaccepted:
        print(f"\nREGRESSED: {', '.join(f'{name} ({metric})' for name, metric in unaccepted)}")
        return 2
    if improved:
        print(f"\nIMPROVED: {', '.join(improved)}; nothing worse")
        return 0
    print("\nNO CHANGE: nothing significant")
    return 0 if args.gate else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))
