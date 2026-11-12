#!/usr/bin/env python3
"""Tests for `ci_changes.py`: which jobs a change runs."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from ci_changes import classify  # noqa: E402


class Classify(unittest.TestCase):
    def jobs(self, *paths: str) -> dict[str, bool]:
        return classify(list(paths))

    def test_hand_written_page_builds_only_the_book(self) -> None:
        self.assertEqual(
            self.jobs("docs/src/contributing.md"),
            {"lean": False, "docs": True, "image": False},
        )

    def test_project_notes_run_nothing_but_the_linter(self) -> None:
        for path in (
            "README.md",
            "CLAUDE.md",
            "REVIEW.md",
            ".claude/skills/prose-voice/SKILL.md",
            ".claude/settings.json",
            ".github/pull_request_template.md",
            ".github/workflows/claude.yml",
            "scripts/prose_tells.py",
            "scripts/testimony_lint.py",
        ):
            with self.subTest(path=path):
                self.assertEqual(
                    self.jobs(path), {"lean": False, "docs": False, "image": False}
                )

    def test_generated_files_build(self) -> None:
        for path in (
            "references.bib",
            "docs/src/bibliography.md",
            "docs/src/roadmap.md",
            "docs/src/SUMMARY.md",
            "docs/src/arguments/sola-fide.md",
            "docs/latex/arguments.tex",
        ):
            with self.subTest(path=path):
                self.assertTrue(self.jobs(path)["lean"])

    def test_lean_and_lake_files_build(self) -> None:
        for path in (
            "Testimony/Logic/Horn.lean",
            "Testimony.lean",
            "arguments/TestimonyArguments/SolaFide.lean",
            "arguments/bench/accepted.toml",
            "examples/TestimonyExamples/Grits.lean",
            "lakefile.toml",
            "lake-manifest.json",
            "scripts/kernel-replay.sh",
            "scripts/bench-ab.sh",
        ):
            with self.subTest(path=path):
                self.assertTrue(self.jobs(path)["lean"])

    def test_markdown_inside_a_package_builds(self) -> None:
        self.assertTrue(self.jobs("arguments/README.md")["lean"])

    def test_unknown_file_builds(self) -> None:
        self.assertTrue(self.jobs("something-new.yaml")["lean"])

    def test_build_workflows_run_everything_they_hold(self) -> None:
        self.assertEqual(
            self.jobs(".github/workflows/ci.yml"),
            {"lean": True, "docs": True, "image": False},
        )
        self.assertTrue(self.jobs("scripts/ci_changes.py")["lean"])

    def test_image_inputs(self) -> None:
        for path in (
            ".devcontainer/Dockerfile",
            "lean-toolchain",
            "scripts/bench-compare.py",
            ".github/workflows/devcontainer-image.yml",
        ):
            with self.subTest(path=path):
                jobs = self.jobs(path)
                self.assertTrue(jobs["image"])
                self.assertTrue(jobs["lean"])

    def test_mixed_change_takes_the_union(self) -> None:
        self.assertEqual(
            self.jobs("README.md", "docs/src/logic.md", "Testimony/Logic/Basic.lean"),
            {"lean": True, "docs": True, "image": False},
        )

    def test_empty_change_runs_nothing(self) -> None:
        self.assertEqual(self.jobs(), {"lean": False, "docs": False, "image": False})


if __name__ == "__main__":
    unittest.main()
