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
benchmarks become multiples of the calibration benchmark's time.

The verdict, for the fixed-point loop (.claude/skills/optimising-the-engine):

  IMPROVED    some benchmark is faster or lighter, none slower or heavier
  REGRESSED   some benchmark is slower, or needs more memory
  NO CHANGE   nothing changed significantly

Exit status: 0 for IMPROVED, 1 for NO CHANGE, 2 for REGRESSED, 3 on bad input.
With --gate, as CI uses it: 2 for REGRESSED, 0 otherwise.

--accept FILE reads regressions accepted on purpose, from a TOML file of
[[accept]] entries, each with benchmark, metric ("time" or "memory"), up_to
(the largest accepted change, as a fraction), baseline (the baseline commit it
is accepted against) and reason. A regression within its entry's bound is
reported as accepted and does not count; an entry naming another baseline is
reported as stale, to be removed once a new baseline is recorded.
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


def acceptances(path, baseline_commit):
    """The regressions accepted against this baseline, from an accepted.toml,
    keyed by (benchmark, metric); and the entries that name another baseline,
    which are stale."""
    if not path:
        return {}, []
    try:
        with open(path, "rb") as f:
            entries = tomllib.load(f).get("accept", [])
    except FileNotFoundError:
        return {}, []
    live, stale = {}, []
    for e in entries:
        missing = [k for k in ("benchmark", "metric", "up_to", "baseline", "reason")
                   if not str(e.get(k, "")).strip()]
        if missing:
            sys.exit(f"bench-compare: an entry of {path} has no {', '.join(missing)}: {e}")
        if e["metric"] not in ("time", "memory"):
            sys.exit(f"bench-compare: metric must be time or memory: {e}")
        accepted_against = str(e["baseline"]).strip()
        # An abbreviated commit names the baseline if it is a prefix of it.
        known = baseline_commit not in ("", "?", "unknown")
        if known and baseline_commit.startswith(accepted_against):
            live[(e["benchmark"], e["metric"])] = e
        else:
            stale.append(e)
    return live, stale


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
                        help="regressions accepted against this baseline, with reasons")
    parser.add_argument("--gate", action="store_true",
                        help="exit 2 on a regression and 0 otherwise, for CI")
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
    for name in common:
        xs, ys = base[name], cont[name]
        if min(len(xs), len(ys)) < MIN_REPETITIONS:
            print(f"{name:<{width}}  too few repetitions ({len(xs)}, {len(ys)}); "
                  f"record with --runs {MIN_REPETITIONS} or more")
            continue
        mx, my = statistics.median(xs), statistics.median(ys)
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
    if mem_common:
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

    # Regressions accepted on purpose, each against this baseline and up to a
    # stated bound, with its reason.
    live, stale = acceptances(args.accept, str(base_ctx.get("commit", "")))
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
            unaccepted.append(f"{name} ({metric})")
    for e in live.values():
        print(f"\nnote: accepted regression not seen: {e['benchmark']} ({e['metric']})")
    for e in stale:
        print(f"\nstale: {e['benchmark']} ({e['metric']}) was accepted against baseline "
              f"{e['baseline']}, not this one; remove it from {args.accept}")

    if unaccepted:
        print(f"\nREGRESSED: {', '.join(unaccepted)}")
        return 2
    if improved:
        print(f"\nIMPROVED: {', '.join(improved)}; nothing worse")
        return 0
    print("\nNO CHANGE: nothing significant")
    return 0 if args.gate else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))
