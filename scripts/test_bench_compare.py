#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["scipy>=1.11"]
# ///
"""Tests for `bench-compare.py`: the first reading's plan and the second's bar.

Run it directly, as bench-compare.py is run: `uv` provides scipy.
"""

from __future__ import annotations

import importlib.util
import json
import sys
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location("bench_compare", HERE / "bench-compare.py")
bench_compare = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bench_compare)

DRIFT = "calibration: kernel list reduction"


def write(path: Path, runs: dict[str, list[float]], mem: dict[str, float]) -> str:
    """A Google Benchmark JSON file of these samples, as bench.sh writes one."""
    benchmarks = [
        {"name": n, "run_name": n, "run_type": "iteration", "real_time": t,
         "peak_memory_mib": mem.get(n, 10.0)}
        for n, ts in runs.items() for t in ts
    ]
    path.write_text(json.dumps({"context": {"commit": path.stem}, "benchmarks": benchmarks}))
    return str(path)


class Compare(unittest.TestCase):
    def setUp(self) -> None:
        self.dir = Path(tempfile.mkdtemp())

    def run_compare(self, base, head, *extra, base_mem=None, head_mem=None):
        b = write(self.dir / "base.json", base, base_mem or {})
        h = write(self.dir / "head.json", head, head_mem or {})
        plan = self.dir / "plan.json"
        status = bench_compare.main(
            ["bench-compare", b, h, "--gate", "--drift", DRIFT, "--plan", str(plan), *extra])
        return status, json.loads(plan.read_text())

    def test_rounds_fall_with_length(self) -> None:
        self.assertEqual(bench_compare.confirm_rounds(76.0), 5)
        self.assertEqual(bench_compare.confirm_rounds(1013.0), 5)
        self.assertEqual(bench_compare.confirm_rounds(5975.0), 3)
        self.assertEqual(bench_compare.confirm_rounds(14262.0), 2)

    def test_a_slowdown_is_planned_for_a_second_reading(self) -> None:
        # One new sample below two old ones, the rest above all: U = 2, p = 0.0317,
        # and the median is 5.9% slower.
        status, plan = self.run_compare(
            {"short": [75.0, 75.5, 76.0, 76.5, 77.0], DRIFT: [220.0] * 5},
            {"short": [76.2, 80.0, 80.5, 81.0, 81.5], DRIFT: [220.0] * 5},
        )
        self.assertEqual(status, 2)
        self.assertEqual([c["benchmark"] for c in plan["confirm"]], ["short"])
        self.assertEqual(plan["confirm"][0]["rounds"], 5)
        self.assertEqual(plan["memory"], [])

    def test_the_second_bar_needs_more_than_the_first_reading(self) -> None:
        # The same samples fail the first bar and pass p < 0.01: at five a
        # side, only all five new samples above all five old reach it.
        status, plan = self.run_compare(
            {"short": [75.0, 75.5, 76.0, 76.5, 77.0]},
            {"short": [76.2, 80.0, 80.5, 81.0, 81.5]},
            "--alpha", "0.01", "--no-memory",
        )
        self.assertEqual(status, 0)
        self.assertEqual(plan["confirm"], [])

    def test_a_slowdown_that_holds_fails_the_second_reading(self) -> None:
        base = [75.0 + 0.3 * i for i in range(10)]
        status, _ = self.run_compare(
            {"short": base}, {"short": [t * 1.10 for t in base]},
            "--alpha", "0.01", "--no-memory",
        )
        self.assertEqual(status, 2)

    def test_memory_regression_is_not_planned(self) -> None:
        status, plan = self.run_compare(
            {"heavy": [100.0] * 5}, {"heavy": [100.0] * 5},
            base_mem={"heavy": 100.0}, head_mem={"heavy": 200.0},
        )
        self.assertEqual(status, 2)
        self.assertEqual(plan, {"confirm": [], "memory": ["heavy"]})

    def test_no_memory_ignores_memory(self) -> None:
        status, _ = self.run_compare(
            {"heavy": [100.0] * 5}, {"heavy": [100.0] * 5}, "--no-memory",
            base_mem={"heavy": 100.0}, head_mem={"heavy": 200.0},
        )
        self.assertEqual(status, 0)

    def test_drift_is_never_planned(self) -> None:
        status, plan = self.run_compare(
            {DRIFT: [220.0, 221.0, 222.0, 223.0, 224.0]},
            {DRIFT: [250.0, 251.0, 252.0, 253.0, 254.0]},
        )
        self.assertEqual(status, 0)
        self.assertEqual(plan["confirm"], [])


if __name__ == "__main__":
    unittest.main()
