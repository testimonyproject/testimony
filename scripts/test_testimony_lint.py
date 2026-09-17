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


ONE_PACKAGE = "def christian : ArgumentPackage Claim := x\n"
TWO_PACKAGES = ONE_PACKAGE + "def critical : ArgumentPackage Claim := y\n"


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
        found = L.lint_units({"Testimony/Arguments/Foo.lean": ONE_PACKAGE})
        self.assertIn("L5", rules(found))

    def test_L5_argument_module_with_a_rival(self):
        found = L.lint_units({"Testimony/Arguments/Foo.lean": TWO_PACKAGES})
        self.assertNotIn("L5", rules(found))

    def test_L5_ignores_modules_outside_arguments(self):
        found = L.lint_units({"Testimony/Logic/Package.lean": ONE_PACKAGE})
        self.assertNotIn("L5", rules(found))

    def test_L5_counts_packages_across_an_argument_directory(self):
        """A split argument keeps its rival even when the two are in one file of
        it and the other files hold none."""
        found = L.lint_units({
            "Testimony/Arguments/Foo/Atoms.lean": "inductive Claim | a\n",
            "Testimony/Arguments/Foo/Packages.lean": TWO_PACKAGES,
            "Testimony/Arguments/Foo/Results.lean": "theorem t : True := trivial\n",
        })
        self.assertNotIn("L5", rules(found))

    def test_L5_directory_argument_without_a_rival(self):
        found = L.lint_units({
            "Testimony/Arguments/Foo/Atoms.lean": "inductive Claim | a\n",
            "Testimony/Arguments/Foo/Packages.lean": ONE_PACKAGE,
        })
        self.assertIn("L5", rules(found))
        self.assertIn("Foo", str(found[0]))

    def test_L5_counts_a_rival_declared_in_another_file_of_the_argument(self):
        """The rule is about the argument, not the file: two files with one
        package each is a rival, and a per-file count would have missed it."""
        found = L.lint_units({
            "Testimony/Arguments/Foo/Christian.lean": ONE_PACKAGE,
            "Testimony/Arguments/Foo/Critical.lean": "def critical : ArgumentPackage Claim := y\n",
        })
        self.assertNotIn("L5", rules(found))

    def test_L5_ignores_an_argument_with_no_packages_at_all(self):
        """Scaffolding on its way to an argument is not yet an argument."""
        found = L.lint_units({"Testimony/Arguments/Foo/Atoms.lean": "inductive Claim | a\n"})
        self.assertNotIn("L5", rules(found))

    def test_L5_is_not_a_per_file_rule(self):
        """L5 does not fire from `lint_text`; only `lint_units` decides it."""
        self.assertNotIn("L5", rules(self.lint(ONE_PACKAGE, path="Testimony/Arguments/Foo.lean")))

    def test_argument_unit_maps_both_layouts(self):
        self.assertEqual("Foo", L.argument_unit("Testimony/Arguments/Foo.lean"))
        self.assertEqual("Foo", L.argument_unit("Testimony/Arguments/Foo/Lines.lean"))
        self.assertIsNone(L.argument_unit("Testimony/Logic/Package.lean"))

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

    def test_L9_documentation_naming_a_removed_result(self):
        """The incident this rule exists for: a page citing a theorem that was
        replaced, which stayed wrong until someone happened to reread it."""
        text = "`almah_is_load_bearing` recorded that defeating the word defeats it.\n"
        found = L.lint_doc("docs/src/roadmap.md", text, {"almah_not_load_bearing"})
        self.assertIn("L9", rules(found))

    def test_L9_documentation_naming_a_result_that_exists(self):
        text = "`almah_not_load_bearing` now holds.\n"
        found = L.lint_doc("docs/src/roadmap.md", text, {"almah_not_load_bearing"})
        self.assertNotIn("L9", rules(found))

    def test_L9_reads_declarations_in_lean_blocks(self):
        """README and the introduction restate theorems as Lean, not in prose."""
        text = "```lean\ntheorem gone_missing : Establishes reformed\n```\n"
        found = L.lint_doc("README.md", text, {"reformed_establishes"})
        self.assertIn("L9", rules(found))

    def test_L9_ignores_other_code_blocks(self):
        """A shell block or a transcript is not a claim about this library."""
        text = "```\n'bvtest' depends on axioms: [propext, bvtest._native.bv_decide.ax_1_5]\n```\n"
        self.assertEqual([], L.lint_doc("docs/src/logic.md", text, set()))

    def test_L9_ignores_prose_that_is_not_a_result_name(self):
        text = (
            "Run `python3 scripts/testimony_lint.py`, never `native_decide`, and use\n"
            "`snake_case` for theorem names and `lowerCamelCase` for definitions.\n"
        )
        self.assertEqual([], L.lint_doc("docs/src/style-guide.md", text, set()))

    def test_L9_is_not_a_lean_file_rule(self):
        """L9 does not fire from `lint_text`; only `lint_doc` decides it."""
        self.assertNotIn("L9", rules(self.lint("-- `no_such_theorem` in a comment\n")))

    def test_declared_names_sees_more_than_theorems(self):
        """Prose cites atom constructors, tactics and qualified names too."""
        names = L.declared_names({
            "Testimony/Arguments/Foo.lean": "inductive Claim\n  | romans3_28\n",
            "Testimony/Logic/Tactic.lean": 'syntax "refute_with" ppSpace ident : tactic\n',
            "Testimony/Logic/Package.lean": "def ArgumentPackage.manifest : List AtomMeta := x\n",
        })
        self.assertIn("romans3_28", names)
        self.assertIn("refute_with", names)
        self.assertIn("ArgumentPackage.manifest", names)
        self.assertIn("manifest", names)

    def test_doc_files_excludes_generated_pages(self):
        """`bibgen` owns the bibliography; L9 does not second-guess it."""
        found = [str(p) for p in L.doc_files(Path("."))]
        self.assertIn("README.md", found)
        self.assertIn("docs/src/roadmap.md", found)
        self.assertNotIn("docs/src/bibliography.md", found)

    def test_clean_file_has_no_findings(self):
        text = "/-- A thing. -/\ndef x : Nat := 1\n"
        self.assertEqual([], self.lint(text))


if __name__ == "__main__":
    unittest.main(verbosity=2)
