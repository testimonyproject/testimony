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

    def test_L6_headline_in_attribute_list(self):
        """`@[headline, proposed]` must still be checked for #print axioms.

        A plain substring test for "@[headline]" misses this, which would let a
        result carrying two attributes skip its trust base silently.
        """
        text = "@[headline, proposed]\ntheorem foo : True := trivial\n"
        self.assertIn("L6", rules(self.lint(text)))

    def test_L6_headline_in_attribute_list_satisfied(self):
        text = (
            "@[headline, proposed]\ntheorem foo : True := trivial\n\n"
            "#print axioms foo\n"
        )
        self.assertNotIn("L6", rules(self.lint(text)))

    def test_L10_proposed_without_rationale(self):
        text = (
            "/-- A result with no account of what it adds. -/\n"
            "@[headline, proposed]\ntheorem foo : True := trivial\n\n"
            "#print axioms foo\n"
        )
        self.assertIn("L10", rules(self.lint(text)))

    def test_L10_proposed_with_rationale(self):
        text = (
            "/-- A result that says what it adds.\n\n"
            "**What is novel here.** Nobody was found arguing this.\n-/\n"
            "@[headline, proposed]\ntheorem foo : True := trivial\n\n"
            "#print axioms foo\n"
        )
        self.assertNotIn("L10", rules(self.lint(text)))

    def test_L10_proposed_with_no_docstring_at_all(self):
        text = "@[proposed]\ntheorem foo : True := trivial\n"
        self.assertIn("L10", rules(self.lint(text)))

    def test_L10_untagged_result_is_not_asked_for_a_rationale(self):
        text = (
            "/-- An ordinary reported result. -/\n"
            "@[headline]\ntheorem foo : True := trivial\n\n"
            "#print axioms foo\n"
        )
        self.assertNotIn("L10", rules(self.lint(text)))

    def test_L11_establishes_without_a_model(self):
        found = L.lint_units({
            "Testimony/Arguments/Foo/Results.lean":
                "theorem a : Establishes christian := by\n  establish [christian]\n",
        })
        self.assertIn("L11", rules(found))
        self.assertIn("christian", str([f for f in found if f.rule == "L11"][0]))

    def test_L11_establishes_with_a_model(self):
        found = L.lint_units({
            "Testimony/Arguments/Foo/Results.lean":
                "theorem a : Establishes christian := by\n  establish [christian]\n"
                "theorem b : Satisfiable christian.premises := by\n"
                "  satisfied_by allHolds [christian]\n",
        })
        self.assertNotIn("L11", rules(found))

    def test_L11_negated_establishes_needs_no_model(self):
        """A refuted package is satisfiable already: its countermodel is a
        valuation on which every premise holds."""
        found = L.lint_units({
            "Testimony/Arguments/Foo/Results.lean":
                "theorem a : \u00ac Establishes critical := by\n"
                "  refute_with criticalReading [critical]\n",
        })
        self.assertNotIn("L11", rules(found))

    def test_L11_model_may_live_in_another_file_of_the_argument(self):
        found = L.lint_units({
            "Testimony/Arguments/Foo/Results.lean":
                "theorem a : Establishes christian := by\n  establish [christian]\n",
            "Testimony/Arguments/Foo/Models.lean":
                "theorem b : Satisfiable christian.premises := by\n"
                "  satisfied_by allHolds [christian]\n",
        })
        self.assertNotIn("L11", rules(found))

    def test_L11_ignores_modules_outside_arguments(self):
        found = L.lint_units({
            "Testimony/Logic/Entail.lean":
                "theorem a : Establishes christian := by\n  establish [christian]\n",
        })
        self.assertNotIn("L11", rules(found))

    def test_L11_does_not_read_establishes_from_a_comment(self):
        found = L.lint_units({
            "Testimony/Arguments/Foo/Results.lean":
                "-- theorem a : Establishes christian := by\n",
        })
        self.assertNotIn("L11", rules(found))

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

    def test_L9_qualified_name_of_a_removed_result(self):
        """A page may cite a result by its full name; the rule follows it."""
        text = "`Testimony.Arguments.SolaFide.deleted_result` settled the case.\n"
        found = L.lint_doc("docs/src/logic.md", text, {"reformed_establishes"})
        self.assertIn("L9", rules(found))

    def test_L9_qualified_name_of_a_result_that_exists(self):
        text = "`Testimony.Arguments.SolaFide.reformed_establishes` holds.\n"
        found = L.lint_doc("docs/src/logic.md", text, {"reformed_establishes"})
        self.assertNotIn("L9", rules(found))

    def test_L9_ignores_dotted_tokens_that_are_not_names(self):
        """Namespace segments are capitalised; a filename's are not."""
        text = "Run `scripts/testimony_lint.py`, or `testimony_lint.py` in place.\n"
        self.assertEqual([], L.lint_doc("CONTRIBUTING.md", text, set()))

    def test_L9_reads_declarations_in_lean_blocks(self):
        """README and the introduction restate theorems as Lean, not in prose."""
        text = "```lean\ntheorem gone_missing : Establishes reformed\n```\n"
        found = L.lint_doc("README.md", text, {"reformed_establishes"})
        self.assertIn("L9", rules(found))

    def test_L9_docstring_naming_a_removed_result(self):
        """The second incident: the root `SolaScriptura` docstring kept a
        paragraph naming four results the same commit deleted, and `argdoc`
        published it into a page that then contradicted itself."""
        text = (
            "/-!\n"
            "Each reply gets two results, `parity_blocks_canon_objection` with\n"
            "`canon_parity_does_not_establish_sole_rule`.\n"
            "-/\n"
            "def live := 1\n"
        )
        found = L.lint_lean_prose("Testimony/Arguments/X.lean", text,
                                  {"parity_leaves_the_canon_open"})
        self.assertIn("L9", rules(found))

    def test_L9_docstring_naming_a_result_that_exists(self):
        text = "/-- `parity_leaves_the_canon_open` states it once. -/\ndef live := 1\n"
        found = L.lint_lean_prose("Testimony/Arguments/X.lean", text,
                                  {"parity_leaves_the_canon_open"})
        self.assertNotIn("L9", rules(found))

    def test_L9_docstring_rule_ignores_code(self):
        """Only prose is prose. A deleted name surviving as an identifier in
        code is a build error, not a documentation defect, and reporting it
        here would double up on the compiler."""
        text = "def gone_result := 1\n-- and `also_gone_result` in a note\n"
        self.assertEqual([], L.lint_lean_prose("Testimony/X.lean", text, set()))

    def test_L9_docstring_rule_reports_the_docstring_line(self):
        """A finding has to point at the paragraph, not at the declaration."""
        text = "def a := 1\ndef b := 2\n/-- names `gone_result` here -/\ndef c := 3\n"
        found = L.lint_lean_prose("Testimony/X.lean", text, set())
        self.assertEqual([3], [f.line for f in found])

    def test_L9_accepts_an_imported_name(self):
        """Prose may name a result this library imports rather than declares.
        Before it could, the rule pushed documentation away from being
        specific — the opposite of what it is for. `models_imply` is the real
        case: #60 described Foundation's truth lemmas rather than naming them,
        purely to keep this rule quiet."""
        text = "/-- Reached through `models_imply`, upstream. -/\ndef x := 1\n"
        self.assertIn("L9", rules(L.lint_lean_prose("Testimony/X.lean", text, set())))
        self.assertNotIn(
            "L9", rules(L.lint_lean_prose("Testimony/X.lean", text, {"models_imply"}))
        )

    @unittest.skipUnless(
        any(r.is_dir() for r in L.IMPORTED_ROOTS),
        "needs .lake/packages — run `lake exe cache get` first",
    )
    def test_imported_names_finds_a_class_field_with_binders(self):
        """Foundation writes `models_imply {𝓜 : M} {φ ψ : F} : …`, with binders
        before the colon, which the strict field pattern misses."""
        found = L.imported_names()
        self.assertIn("models_imply", found)
        self.assertIn("weakening", found)

    def test_imported_names_survive_a_missing_package(self):
        """A fresh clone has no `.lake/` until the first cache fetch, and a
        linter that refused to run before the first build would be worse than
        one that cannot confirm an imported name."""
        self.assertEqual(set(), L.imported_names((Path("nonexistent-package"),)))

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

    def test_declared_names_ignores_inline_comments(self):
        """`-- def gone_result` is a comment, not a declaration. Without this,
        commenting a theorem out would leave documentation citing it passing."""
        names = L.declared_names(
            {"Testimony/A.lean": "def live := 0 -- def gone_result : Nat := 0\n"}
        )
        self.assertIn("live", names)
        self.assertNotIn("gone_result", names)

    def test_strip_comments_keeps_dashes_inside_strings(self):
        """`argtex` emits LaTeX en-dashes: `2:5--6` is text, not a comment, and
        cutting there would hide the rest of the line from every rule."""
        line = '  "Matthew 2:5--6 quotes Micah 5:2." ++'
        self.assertEqual([line], L._strip_comments([line]))

    def test_L12_long_markdown_line(self):
        found = L.lint_markdown("docs/src/roadmap.md", "x" * 120 + "\n")
        self.assertIn("L12", rules(found))
        self.assertIn("120 columns", str(found[0]))

    def test_L12_short_markdown_line(self):
        text = "The prose is as much of the deliverable as the Lean.\n"
        self.assertEqual([], L.lint_markdown("docs/src/roadmap.md", text))

    def test_L12_counts_characters_not_bytes(self):
        """The corpus is full of Greek, Hebrew and mathematical symbols. A byte
        count would fail lines that are not long, on the files most worth
        writing carefully."""
        line = "עלמה " * 20  # 100 characters, and rather more than 100 bytes
        self.assertEqual(100, len(line))
        self.assertGreater(len(line.encode("utf-8")), L.MAX_LINE)
        self.assertEqual([], L.lint_markdown("docs/src/logic.md", line + "\n"))

    def test_L12_table_row_may_be_wide(self):
        """A newline ends a markdown table row, so a wide row cannot be wrapped
        at all — unlike a wide link, which has a form that fits."""
        text = "| `Testimony/Logic/` | " + "prose " * 30 + "|\n"
        self.assertEqual([], L.lint_markdown("CLAUDE.md", text))

    def test_L12_indented_table_row_may_be_wide(self):
        """A table nested in a list item is still a table."""
        text = "  | a | " + "b" * 120 + " |\n"
        self.assertEqual([], L.lint_markdown("docs/src/architecture.md", text))

    def test_L12_a_table_row_without_outer_pipes_may_be_wide(self):
        """Markdown does not require the outer pipes, so a leading `|` cannot be
        the whole test for a row. The block is recognised from its delimiter
        row, which makes the line above it a header and the lines below it
        rows, until the blank line that ends the table."""
        text = (
            "Result | Notes\n"
            "--- | ---\n"
            "`parity_leaves_the_canon_open` | " + "prose " * 30 + "\n"
        )
        self.assertEqual([], L.lint_markdown("docs/src/roadmap.md", text))

    def test_L12_prose_after_a_table_is_not_exempt(self):
        """A GFM table ends at the first blank line. Prose under one is prose."""
        text = (
            "Result | Notes\n"
            "--- | ---\n"
            "a | b\n"
            "\n"
            + "q" * 120 + "\n"
        )
        self.assertEqual([5], [f.line for f in L.lint_markdown("docs/src/roadmap.md", text)])

    def test_L12_a_thematic_break_does_not_open_a_table(self):
        """`---` with no pipe is a horizontal rule, not a delimiter row, so the
        line above it is a heading rather than a table header."""
        text = "x" * 120 + "\n---\n"
        self.assertEqual([1], [f.line for f in L.lint_markdown("docs/src/logic.md", text)])

    def test_L12_generated_block_is_exempt(self):
        """The roadmap's status table is pretty-printed Lean statements that
        `statusgen` rewrites on every run and nobody may hand-edit."""
        text = (
            "<!-- BEGIN GENERATED: lake exe statusgen -->\n"
            + "x" * 200 + "\n"
            "<!-- END GENERATED: lake exe statusgen -->\n"
        )
        self.assertEqual([], L.lint_markdown("docs/src/roadmap.md", text))

    def test_L12_prose_around_a_generated_block_is_not_exempt(self):
        """The reason the rule reads markers rather than paths: `roadmap.md`
        carries a generated table *and* hand-written prose, and excluding the
        file would exempt the prose along with the table."""
        text = (
            "y" * 120 + "\n"
            "<!-- BEGIN GENERATED: lake exe statusgen -->\n"
            + "x" * 200 + "\n"
            "<!-- END GENERATED: lake exe statusgen -->\n"
            + "z" * 120 + "\n"
        )
        found = L.lint_markdown("docs/src/roadmap.md", text)
        self.assertEqual([1, 5], [f.line for f in found])

    def test_L12_argdoc_block_is_exempt_too(self):
        """`SUMMARY.md` has the same shape under a different generator."""
        text = (
            "<!-- BEGIN GENERATED: lake exe argdoc -->\n"
            + "- [An argument](./arguments/a.md) " + "x" * 100 + "\n"
            "<!-- END GENERATED: lake exe argdoc -->\n"
        )
        self.assertEqual([], L.lint_markdown("docs/src/SUMMARY.md", text))

    def test_L12_frontmatter_is_exempt(self):
        """A skill's `description:` is one YAML scalar the loader reads whole.
        A folded scalar would wrap it only if the loader is a real YAML parser,
        and finding out otherwise by breaking a skill is a poor trade."""
        text = (
            "---\n"
            "name: encoding-an-argument\n"
            "description: " + "word " * 80 + "\n"
            "---\n"
            "\n# Encoding an argument\n"
        )
        self.assertEqual([], L.lint_markdown(".claude/skills/x/SKILL.md", text))

    def test_L12_body_after_frontmatter_is_not_exempt(self):
        text = "---\nname: x\n---\n\n" + "q" * 120 + "\n"
        found = L.lint_markdown(".claude/skills/x/SKILL.md", text)
        self.assertEqual([5], [f.line for f in found])

    def test_L12_a_thematic_break_does_not_open_frontmatter(self):
        """`---` is also a horizontal rule. Only an opening one, on line 1,
        starts frontmatter — otherwise a rule mid-page would exempt the rest of
        the file without anyone noticing."""
        text = "# Title\n\n---\n\n" + "q" * 120 + "\n"
        self.assertIn("L12", rules(L.lint_markdown("docs/src/logic.md", text)))

    def test_L12_generated_pages_are_exempt(self):
        """`bibgen` owns the bibliography and `argdoc` the argument pages; both
        are guarded by their own `--check`."""
        long_line = "x" * 200 + "\n"
        self.assertEqual([], L.lint_markdown("docs/src/bibliography.md", long_line))
        self.assertEqual(
            [], L.lint_markdown("docs/src/arguments/sola-fide.md", long_line)
        )

    def test_L12_a_long_link_is_not_exempt(self):
        """The one exemption deliberately refused. An inline link cannot be
        broken across lines, but it has a second form that fits — `[text][ref]`
        with the URL defined elsewhere — so a link too wide for the page is a
        link that should be a reference link, not an exception to the width."""
        text = (
            "Everything above is a "
            "[GitHub issue](https://github.com/testimonyproject/testimony/issues)"
            " and every one of them is tracked there.\n"
        )
        self.assertIn("L12", rules(L.lint_markdown("docs/src/roadmap.md", text)))

    def test_L12_a_reference_link_is_how_a_long_link_fits(self):
        """The same sentence, written the way the rule asks for."""
        text = (
            "Everything above is a [GitHub issue][issues] and every one of\n"
            "them is tracked there.\n"
            "\n"
            "[issues]: https://github.com/testimonyproject/testimony/issues\n"
        )
        self.assertEqual([], L.lint_markdown("docs/src/roadmap.md", text))

    def test_L12_a_code_fence_is_not_exempt(self):
        """Deliberately not exempt: a sample too wide for 100 columns is too
        wide for the rendered page, and the Lean in one is held to 100 by L8
        wherever it also lives in a source file."""
        text = "```sh\ncurl -s " + "x" * 120 + "\n```\n"
        self.assertIn("L12", rules(L.lint_markdown("docs/src/citations.md", text)))

    def test_L12_a_pipe_inside_a_code_fence_is_not_a_table_row(self):
        """The table exemption is read only outside a fence. A wide line that
        happens to begin with `|` in a code sample is a wide line."""
        text = "```text\n|" + "x" * 120 + "\n```\n"
        found = L.lint_markdown("docs/src/style-guide.md", text)
        self.assertEqual([2], [f.line for f in found])

    def test_L12_a_generated_marker_inside_a_code_fence_is_a_sample(self):
        """A page explaining the markers shows one in a fence. That sample must
        not open a real exemption over the prose after the fence — which is how
        a whole page would go silently unchecked."""
        text = (
            "```markdown\n"
            "<!-- BEGIN GENERATED: lake exe statusgen -->\n"
            "```\n"
            "\n"
            + "q" * 120 + "\n"
        )
        found = L.lint_markdown("docs/src/style-guide.md", text)
        self.assertEqual([5], [f.line for f in found])

    def test_L12_a_longer_fence_is_not_closed_by_a_shorter_one(self):
        """A fence closes on the same character, at least as long, and nothing
        else — so a nested ``` inside a ```` block leaves the fence open."""
        text = (
            "````markdown\n"
            "```\n"
            "|" + "x" * 120 + "\n"
            "```\n"
            "````\n"
        )
        self.assertEqual([3], [f.line for f in L.lint_markdown("docs/src/logic.md", text)])

    def test_L12_unclosed_frontmatter_is_not_frontmatter(self):
        """A page opening with `---` and never closing it is a thematic break or
        an interrupted block, not frontmatter. Reading it as frontmatter would
        exempt the whole page, which is the one way a width rule fails without
        anybody noticing."""
        text = "---\n\nSome prose.\n\n" + "q" * 120 + "\n"
        found = L.lint_markdown(".claude/skills/x/SKILL.md", text)
        self.assertEqual([5], [f.line for f in found])

    def test_L12_an_absolute_path_to_a_generated_page_is_exempt(self):
        """The file-write hook passes `tool_input.file_path`, which is absolute.
        `is_generated_doc` matches a repository-relative prefix, so without
        normalising the path the rule would fire on the generated line 6 of
        every page `argdoc` writes."""
        absolute = Path.cwd() / "docs" / "src" / "arguments" / "sola-fide.md"
        self.assertEqual("docs/src/arguments/sola-fide.md", L._rel(absolute))
        self.assertTrue(L.is_generated_doc(L._rel(absolute)))

    def test_rel_leaves_a_path_outside_the_repository_alone(self):
        """Nothing about generated pages is about a path elsewhere on disk, and
        a relative path that escapes the root would be misleading."""
        self.assertEqual("/etc/hosts", L._rel(Path("/etc/hosts")))

    def test_L12_is_not_a_lean_file_rule(self):
        """L12 does not fire from `lint_text`; only `lint_markdown` decides it,
        and L8 already holds Lean to the same width."""
        self.assertNotIn("L12", rules(self.lint("-- " + "x" * 120 + "\n")))

    def test_markdown_files_excludes_generated_pages(self):
        found = [str(p) for p in L.markdown_files(Path("."))]
        self.assertIn("CLAUDE.md", found)
        self.assertIn("docs/src/roadmap.md", found)
        self.assertIn(".claude/skills/encoding-an-argument/SKILL.md", found)
        self.assertNotIn("docs/src/bibliography.md", found)
        self.assertFalse([p for p in found if p.startswith("docs/src/arguments/")])

    def test_markdown_files_does_not_descend_into_packages(self):
        """`.lake/` holds the dependencies' own READMEs, which are not ours to
        hold to a width — and there are thousands of them."""
        found = [str(p) for p in L.markdown_files(Path("."))]
        self.assertFalse([p for p in found if p.startswith(".lake/")])

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
