#!/usr/bin/env python3
"""Tests for `credits.py`: who each argument's credit names."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from credits import (  # noqa: E402
    Commit,
    Credit,
    Ident,
    credit,
    credits_file,
    escape,
    parse_ident,
    requests,
)

ANA = Ident("Ana Reader", "ana@example.org")
BEN = Ident("Ben Writer", "ben@example.org")
CLAUDE = Ident("Claude", "noreply@anthropic.com")
OPUS = Ident("Claude Opus 5", "noreply@anthropic.com")
BOT = Ident("claude[bot]", "41898282+claude[bot]@users.noreply.github.com")
GITHUB = Ident("GitHub", "noreply@github.com")

SOLA = "arguments/TestimonyArguments/SolaFide/Results.lean"


def commit(sha, author, files, committer=None, coauthors=(), parents=("p",)):
    return Commit(sha, list(parents), author, committer or author, list(coauthors), files)


class Identities(unittest.TestCase):
    def test_claude_is_not_a_person_under_any_name(self) -> None:
        for i in (CLAUDE, OPUS, BOT):
            with self.subTest(i=i):
                self.assertTrue(i.is_ai)
                self.assertFalse(i.is_person)

    def test_githubs_merge_identity_is_not_a_person(self) -> None:
        self.assertFalse(GITHUB.is_person)
        self.assertFalse(GITHUB.is_ai)

    def test_trailer_identity(self) -> None:
        self.assertEqual(parse_ident(" Ana Reader <ana@example.org> "), ANA)
        self.assertIsNone(parse_ident("not an identity"))


class Credits(unittest.TestCase):
    def credit(self, commits, merged_by=None, first_parent=()):
        return credit(["TestimonyArguments.SolaFide"], commits, merged_by or {}, set(first_parent))

    def test_a_person_who_authored_is_credited(self) -> None:
        self.assertEqual(self.credit([commit("a", ANA, [SOLA])]), Credit(["Ana Reader"], False))

    def test_a_co_author_trailer_counts(self) -> None:
        c = commit("a", CLAUDE, [SOLA], coauthors=[BEN])
        self.assertEqual(self.credit([c]), Credit(["Ben Writer"], True))

    def test_claude_alone_is_credited_to_whoever_merged_it(self) -> None:
        c = commit("a", CLAUDE, [SOLA], coauthors=[OPUS])
        self.assertEqual(self.credit([c], merged_by={"a": BEN}), Credit(["Ben Writer"], True))

    def test_a_github_merge_names_no_one(self) -> None:
        c = commit("a", CLAUDE, [SOLA])
        self.assertEqual(self.credit([c], merged_by={"a": GITHUB}), Credit([], True))

    def test_a_direct_push_falls_back_to_the_committer(self) -> None:
        c = commit("a", CLAUDE, [SOLA], committer=ANA)
        self.assertEqual(self.credit([c], first_parent={"a"}), Credit(["Ana Reader"], True))

    def test_the_committer_is_not_credited_for_merged_work(self) -> None:
        # Off the first-parent chain, a committer only replayed the commit.
        c = commit("a", CLAUDE, [SOLA], committer=ANA)
        self.assertEqual(self.credit([c]), Credit([], True))

    def test_the_old_location_counts(self) -> None:
        c = commit("a", ANA, ["Testimony/Arguments/SolaFide/Atoms.lean"])
        self.assertEqual(self.credit([c]).people, ["Ana Reader"])

    def test_meanings_count_and_other_arguments_do_not(self) -> None:
        mine = commit("a", ANA, ["arguments/TestimonyArguments/Meanings/SolaFide.lean"])
        other = commit("b", BEN, ["arguments/TestimonyArguments/SolaGratia/Atoms.lean"])
        self.assertEqual(self.credit([other, mine]).people, ["Ana Reader"])

    def test_a_prefix_is_not_a_directory_match(self) -> None:
        # `SolaFide.lean` must not match `SolaFideExtra.lean`.
        c = commit("a", ANA, ["arguments/TestimonyArguments/SolaFideExtra.lean"])
        self.assertEqual(self.credit([c]).people, [])

    def test_generated_files_credit_no_one(self) -> None:
        c = commit("a", ANA, ["docs/src/arguments/sola-fide.md", "docs/latex/arguments.tex"])
        self.assertEqual(self.credit([c]), Credit([], False))

    def test_names_in_the_order_people_joined(self) -> None:
        # Newest first, as git log lists them.
        commits = [commit("c", ANA, [SOLA]), commit("b", BEN, [SOLA]), commit("a", ANA, [SOLA])]
        self.assertEqual(self.credit(commits).people, ["Ana Reader", "Ben Writer"])


class Rendering(unittest.TestCase):
    def test_names_and_note(self) -> None:
        self.assertEqual(
            Credit(["Ana Reader", "Ben Writer"], True).latex(),
            "Ana Reader, Ben Writer \\\\ {\\small Written with Claude Code}",
        )

    def test_note_alone(self) -> None:
        self.assertEqual(Credit([], True).latex(), "{\\small Written with Claude Code}")

    def test_nothing(self) -> None:
        self.assertEqual(Credit([], False).latex(), "")

    def test_escape(self) -> None:
        self.assertEqual(escape("A & B_c"), "A \\& B\\_c")

    def test_creditline_is_a_request_and_a_definition_is_not(self) -> None:
        tex = (
            "\\newcommand{\\creditline}[1]{\\ifcsname credit@#1\\endcsname"
            "{\\centering\\credit{#1}\\par}\\fi}\n\\author{\\credit{all}}\n"
            "\\creditline{N.A}\n"
        )
        self.assertEqual(requests(tex), ["all", "N.A"])

    def test_requests_in_order_without_repeats(self) -> None:
        tex = "\\credit{all} x \\credit{N.A} y \\credit{N.B} \\credit{N.A}"
        self.assertEqual(requests(tex), ["all", "N.A", "N.B"])

    def test_all_is_everyone_behind_the_documents(self) -> None:
        commits = [
            commit("b", BEN, ["arguments/TestimonyArguments/SolaGratia.lean"]),
            commit("a", ANA, [SOLA]),
        ]
        tex = "\\credit{all}\\credit{TestimonyArguments.SolaFide}" + (
            "\\credit{TestimonyArguments.SolaGratia}"
        )
        out = credits_file([tex], commits, {}, set())
        self.assertIn("\\csname credit@all\\endcsname{Ana Reader, Ben Writer}", out)
        self.assertIn("\\csname credit@TestimonyArguments.SolaFide\\endcsname{Ana Reader}", out)


if __name__ == "__main__":
    unittest.main()
