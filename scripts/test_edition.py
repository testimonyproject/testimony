#!/usr/bin/env python3
"""Tests for `edition.py`: what a printed document says about its edition."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from edition import edition_file, escape, long_date, pull_request  # noqa: E402

SHA = "8ee3779946a9106fcc49131a87e882a0cabc9f3d"


class EditionTest(unittest.TestCase):
    def test_date_is_the_commits_in_words(self) -> None:
        self.assertEqual(long_date("2026-11-17T10:43:48+00:00"), "17 November 2026")
        self.assertEqual(long_date("2027-01-02T23:59:59-08:00"), "2 January 2027")

    def test_untagged_commit_is_named_by_its_short_hash(self) -> None:
        text = edition_file(SHA, "8ee3779", "", "17 November 2026", None)
        self.assertIn("\\renewcommand{\\editionversion}{8ee3779}", text)
        self.assertIn("\\renewcommand{\\editioncommit}{" + SHA + "}", text)
        self.assertIn("\\editionrecordedtrue", text)
        self.assertNotIn("\\editionpreviewtrue", text)

    def test_a_release_is_named_by_its_tag(self) -> None:
        text = edition_file(SHA, "8ee3779", "v1.0_rc", "17 November 2026", None)
        self.assertIn("\\renewcommand{\\editionversion}{v1.0\\_rc}", text)
        self.assertIn("\\renewcommand{\\editioncommit}{" + SHA + "}", text)

    def test_a_pull_request_says_it_is_a_preview(self) -> None:
        text = edition_file(SHA, "8ee3779", "", "17 November 2026", "290")
        self.assertIn("\\editionpreviewtrue", text)
        self.assertIn("pull request 290", text)

    def test_pull_request_is_read_from_the_workflow(self) -> None:
        env = {"GITHUB_EVENT_NAME": "pull_request", "GITHUB_REF": "refs/pull/290/merge"}
        self.assertEqual(pull_request(env), "290")
        self.assertIsNone(pull_request({"GITHUB_EVENT_NAME": "push",
                                        "GITHUB_REF": "refs/heads/main"}))
        self.assertIsNone(pull_request({}))

    def test_escape(self) -> None:
        self.assertEqual(escape("a_b#c"), "a\\_b\\#c")


if __name__ == "__main__":
    unittest.main()
