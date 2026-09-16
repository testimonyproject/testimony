#!/usr/bin/env python3
"""Tests for testimony_lint.

A linter that silently stops firing is worse than no linter, so every rule has
a fixture that must trip it and a fixture that must not.
"""
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import testimony_lint as L  # noqa: E402


def rules(findings):
    return sorted({f.rule for f in findings})


class RuleTests(unittest.TestCase):
    def lint(self, text, path="Testimony/Example.lean"):
        return L.lint_text(path, text)

    def test_L1_sorry(self):
        self.assertIn("L1", rules(self.lint("theorem foo : True := by sorry\n")))
        self.assertIn("L1", rules(self.lint("theorem foo : True := by admit\n")))

    def test_L1_ignores_sorry_inside_word(self):
        self.assertNotIn("L1", rules(self.lint("/-- not sorryful prose -/\ndef x := 1\n")))

    def test_L2_native_decide(self):
        self.assertIn("L2", rules(self.lint("theorem f : True := by native_decide\n")))

    def test_L2_allows_plain_decide(self):
        self.assertNotIn("L2", rules(self.lint("theorem f : True := by decide\n")))

    def test_L3_inline_bib_entry_outside_works(self):
        text = 'def x : BibEntry := .book\n  { core := c, publisher := "P" }\n'
        self.assertIn("L3", rules(self.lint(text)))

    def test_L3_allows_entries_in_works(self):
        text = 'def x : BibEntry := .book\n  { core := c, publisher := "P" }\n'
        found = self.lint(text, path="Testimony/Bib/Works.lean")
        self.assertNotIn("L3", rules(found))

    def test_L3_ignores_field_accessors_named_like_constructors(self):
        text = "def PassageRange.book : PassageRange -> Book\n  | .verse p => p.book\n"
        self.assertNotIn("L3", rules(self.lint(text, path="Testimony/Text.lean")))

    def test_L4_untagged_entry_in_works(self):
        text = 'def alpha : BibEntry := .book\n  { core := c }\n'
        self.assertIn("L4", rules(self.lint(text, path="Testimony/Bib/Works.lean")))

    def test_L4_tagged_entry_passes(self):
        text = '@[bib_entry] def alpha : BibEntry := .book\n  { core := c }\n'
        self.assertNotIn("L4", rules(self.lint(text, path="Testimony/Bib/Works.lean")))

    def test_L5_argument_module_without_a_rival(self):
        text = "def christian : ArgumentPackage Claim := x\n"
        found = self.lint(text, path="Testimony/Arguments/Foo.lean")
        self.assertIn("L5", rules(found))

    def test_L5_argument_module_with_a_rival(self):
        text = ("def christian : ArgumentPackage Claim := x\n"
                "def critical : ArgumentPackage Claim := y\n")
        found = self.lint(text, path="Testimony/Arguments/Foo.lean")
        self.assertNotIn("L5", rules(found))

    def test_L5_ignores_modules_outside_arguments(self):
        text = "def christian : ArgumentPackage Claim := x\n"
        self.assertNotIn("L5", rules(self.lint(text, path="Testimony/Logic/Package.lean")))

    def test_L6_headline_without_print_axioms(self):
        text = "@[headline]\ntheorem foo : True := trivial\n"
        self.assertIn("L6", rules(self.lint(text)))

    def test_L6_headline_with_print_axioms(self):
        text = "@[headline]\ntheorem foo : True := trivial\n\n#print axioms foo\n"
        self.assertNotIn("L6", rules(self.lint(text)))

    def test_L7_bad_citation_key(self):
        self.assertIn("L7", rules(self.lint('  { key := "France_Matthew2007"\n')))

    def test_L7_good_citation_key(self):
        self.assertNotIn("L7", rules(self.lint('  { key := "france-matthew-2007"\n')))

    def test_L8_trailing_whitespace(self):
        self.assertIn("L8", rules(self.lint("def x := 1   \n")))

    def test_L8_long_line(self):
        self.assertIn("L8", rules(self.lint("-- " + "x" * 120 + "\n")))

    def test_clean_file_has_no_findings(self):
        text = "/-- A thing. -/\ndef x : Nat := 1\n"
        self.assertEqual([], self.lint(text))


if __name__ == "__main__":
    unittest.main(verbosity=2)
