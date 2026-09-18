#!/usr/bin/env python3
"""Domain linter for the Testimony library.

Tier 4 of the four checks described in the style guide. The general-purpose
Lean linters do not know what a citation is, what an argument atom is, or that
this project forbids `native_decide`; these rules do.

Source-level and sub-second, so it can run on every file write rather than only
in CI.

Rules L1-L8 and L10 are about Lean files, L5 and L11 about whole
arguments. L9 is about the prose: a documentation page
naming a theorem the library no longer has is drift of exactly the kind this
project exists to rule out, and it has happened. It runs only over the whole
library, because deciding that a name does not exist means having read every
declaration. L12 is about the prose too, but about its shape rather than its
claims: hand-written markdown is held to the same 100 columns as Lean.

Usage:
    python3 scripts/testimony_lint.py            # Testimony/ and the prose docs
    python3 scripts/testimony_lint.py [paths...] # those files only; no L9
"""
from __future__ import annotations

import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path

MAX_LINE = 100
MIN_PACKAGES = 2
WORKS_FILE = "Testimony/Bib/Works.lean"
ARGUMENTS_DIR = "Testimony/Arguments/"
CITE_KEY_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
ARGUMENT_PACKAGE_RE = re.compile(r"\bdef\s+(\w+)\s*:\s*ArgumentPackage\b")

# L9. Pages that carry results in prose, plus the two rule files. The
# generated bibliography is excluded: bibgen owns it, and `--check` guards it.
DOC_PATHS = (
    "README.md",
    "CLAUDE.md",
    "CONTRIBUTING.md",
    "docs/src/*.md",
)
GENERATED_DOCS = frozenset({"docs/src/bibliography.md"})
# `argdoc` writes a page per argument here, from the module and declaration
# docstrings. Whole directories rather than named files, because the set of
# arguments changes and a rule that had to be told about each new one would
# start failing on the commit that adds it.
GENERATED_DOC_DIRS = ("docs/src/arguments/",)

# L12. Where the hand-written markdown is. A walk rather than a glob list: the
# skills, the brand notes and the docs tree all carry prose, and a rule that
# only knew about `docs/src/` would stop applying the moment prose moved.
# `.lake/` holds the dependencies' own READMEs, and `docs/book/` the rendered
# site; neither is ours to hold to a width.
MARKDOWN_SKIP_DIRS = frozenset({".git", ".lake", "book", "node_modules"})

# What counts as a declaration in a Lean file. Constructors and structure
# fields are included: `romans3_28` is an atom constructor, and prose cites it.
LEAN_DECL_RE = re.compile(
    r"\b(?:theorem|lemma|def|abbrev|structure|inductive|instance|class|axiom|opaque)"
    r"\s+([A-Za-z_][A-Za-z0-9_.'!?]*)"
)
LEAN_CTOR_RE = re.compile(r"^\s*\|\s*([A-Za-z_][A-Za-z0-9_.'!?]*)", re.M)
LEAN_FIELD_RE = re.compile(r"^\s{2,}([a-z][A-Za-z0-9_']*)\s*:[^=]", re.M)
# `syntax "establish" ...`, `elab "derive_bib_registry " name:ident ...`: the
# tactic and command names prose refers to are string literals, not identifiers.
LEAN_SYNTAX_RE = re.compile(
    r"\b(?:syntax|elab|macro|notation)\b[^\n\"]*\"\s*([A-Za-z_][A-Za-z0-9_'!?]*)\s*\""
)

# A mention worth checking: theorem-shaped, which is what prose restates,
# optionally qualified by the namespace it lives in — prose cites both
# `almah_not_load_bearing` and `Testimony.Arguments.BornOfAVirgin.almah_...`.
# Namespace segments are capitalised, as Lean's are, which is what keeps
# `testimony_lint.py` and `micah5_2.tex` from looking like qualified names.
# `lowerCamelCase` definitions are not checked — too many English words in
# backticks would match, and it is the results that drift.
DOC_MENTION_RE = re.compile(
    r"^(?:[A-Z][A-Za-z0-9_']*\.)*[a-z][A-Za-z0-9']*(?:_[A-Za-z0-9'!?]+)+$"
)
INLINE_CODE_RE = re.compile(r"`([^`\n]+)`")
LEAN_FENCE_RE = re.compile(r"^\s*```lean\b")
FENCE_RE = re.compile(r"^\s*```")
# Theorem-shaped tokens that name something other than a declaration here:
# Lean tactics this project forbids, and a naming convention.
NOT_DECLARATIONS = frozenset({"native_decide", "bv_decide", "snake_case"})

ENTRY_CTORS = (
    "book", "inCollection", "article", "thesis",
    "criticalEdition", "ancientWork", "dataset", "webPage",
)
# Anchored on `:=` so that field accessors such as `PassageRange.book` are not
# mistaken for BibEntry constructor applications.
INLINE_ENTRY_RE = re.compile(r":=\s*\.(" + "|".join(ENTRY_CTORS) + r")\s*(\{|$)")

RULE_TEXT = {
    "L1": "no `sorry` or `admit`",
    "L2": "no `native_decide` — it adds Lean.ofReduceBool to the trust base",
    "L3": "BibEntry values must be defined in Testimony/Bib/Works.lean",
    "L4": "every BibEntry definition must carry @[bib_entry]",
    # L5 previously capped atoms at 12, because entailment was decided by an
    # exhaustive 2^n truth table. That checker is gone, so the cap is gone with
    # it; the id is reused rather than renumbered to keep references stable.
    "L5": "an argument must encode at least one rival package",
    "L6": "every @[headline] theorem must be followed by `#print axioms`",
    "L7": "citation keys must match ^[a-z0-9]+(-[a-z0-9]+)*$",
    "L8": f"no trailing whitespace; lines at most {MAX_LINE} columns",
    "L9": "documentation names a Lean result that does not exist",
    "L10": "every @[proposed] result must say what is novel about it",
    "L11": "a package with an Establishes result must be shown satisfiable",
    "L12": f"hand-written markdown: lines at most {MAX_LINE} columns",
}

# L12. A generated block inside a hand-written page: `statusgen` writes the
# roadmap's status table between these, `argdoc` the argument list in
# `SUMMARY.md`. Matched on the marker rather than on the path, because the
# page around the block is hand-written and must still be held to the width —
# excluding `roadmap.md` wholesale would exempt its prose along with its table.
GENERATED_BEGIN_RE = re.compile(r"^\s*<!--\s*BEGIN GENERATED\b")
GENERATED_END_RE = re.compile(r"^\s*<!--\s*END GENERATED\b")
# A markdown table row cannot be wrapped: a newline ends the row.
TABLE_ROW_RE = re.compile(r"^\s*\|")
# YAML frontmatter, opened and closed by `---` on its own line.
FRONTMATTER_FENCE = "---"


# Attributes are matched inside a bracket list, because a declaration may carry
# more than one: `@[headline, proposed]` is not caught by a plain substring test
# for `@[headline]`, and a result that slipped past L6 that way would be exactly
# the silent gap these rules exist to close.
HEADLINE_ATTR_RE = re.compile(r"@\[[^\]]*\bheadline\b[^\]]*\]")
PROPOSED_ATTR_RE = re.compile(r"@\[[^\]]*\bproposed\b[^\]]*\]")

# What an @[proposed] docstring has to contain. The phrase is fixed so the rule
# is mechanical: a contribution is welcome, but it must say what it is adding.
NOVELTY_PHRASE = "What is novel"

# L11. `Entails` is vacuously true over a premise set with no model, so a
# package built from contradictory premises establishes its conclusion and every
# other gate passes. A `¬ Establishes` result needs no check — its countermodel
# is already a valuation satisfying every premise — so only the positive ones
# are required to exhibit a model.
ESTABLISHES_RE = re.compile(r"Establishes\s+(\w+)")
SATISFIABLE_RE = re.compile(r"Satisfiable\s+(\w+)\.premises")


@dataclass(frozen=True)
class Finding:
    rule: str
    path: str
    line: int
    message: str

    def __str__(self) -> str:
        return f"{self.path}:{self.line}: [{self.rule}] {self.message}"


def _strip_comments(lines: list[str]) -> list[str]:
    """Blank out comments so prose does not trip code rules.

    Block comments nest, and `--` runs to the end of its line — but only
    outside a string literal. `argtex` emits LaTeX en-dashes, so
    `"Matthew 2:5--6 quotes Micah"` is text rather than a comment, and cutting
    there would hide code from every rule below.

    Inline comments matter to L9 in particular: `def live := 0 -- def gone ...`
    would otherwise put `gone` in the set of declared names, and documentation
    naming a deleted result would pass.
    """
    out, depth, in_string = [], 0, False
    for line in lines:
        kept, i = [], 0
        while i < len(line):
            if depth:
                if line.startswith("/-", i):
                    depth += 1
                elif line.startswith("-/", i):
                    depth -= 1
                else:
                    kept.append(" ")
                    i += 1
                    continue
                kept.append("  ")
                i += 2
            elif in_string:
                if line[i] == "\\" and i + 1 < len(line):
                    kept.append(line[i : i + 2])
                    i += 2
                    continue
                if line[i] == '"':
                    in_string = False
                kept.append(line[i])
                i += 1
            elif line.startswith("/-", i):
                depth += 1
                kept.append("  ")
                i += 2
            elif line.startswith("--", i):
                break
            else:
                if line[i] == '"':
                    in_string = True
                kept.append(line[i])
                i += 1
        out.append("".join(kept))
    return out


def lint_text(path: str, text: str) -> list[Finding]:
    lines = text.splitlines()
    code = _strip_comments(lines)
    findings: list[Finding] = []

    def add(rule: str, lineno: int, extra: str = "") -> None:
        msg = RULE_TEXT[rule] + (f" ({extra})" if extra else "")
        findings.append(Finding(rule, path, lineno, msg))

    for n, line in enumerate(code, 1):
        if re.search(r"\b(sorry|admit)\b", line):
            add("L1", n)
        if "native_decide" in line:
            add("L2", n)
        if path != WORKS_FILE and INLINE_ENTRY_RE.search(line):
            add("L3", n)
        for m in re.finditer(r'key\s*:=\s*"([^"]*)"', line):
            if not CITE_KEY_RE.match(m.group(1)):
                add("L7", n, m.group(1))

    for n, line in enumerate(lines, 1):
        if line != line.rstrip():
            add("L8", n, "trailing whitespace")
        if len(line) > MAX_LINE:
            add("L8", n, f"{len(line)} columns")

    # L4: BibEntry definitions in Works.lean must be tagged.
    if path == WORKS_FILE:
        for n, line in enumerate(code, 1):
            if re.search(r"\bdef\s+\w+\s*:\s*BibEntry\b", line):
                if "@[bib_entry]" not in line and not (
                    n >= 2 and "@[bib_entry]" in code[n - 2]
                ):
                    add("L4", n)

    # L6: headline results must display their trust base.
    for n, line in enumerate(code, 1):
        if not HEADLINE_ATTR_RE.search(line):
            continue
        name = None
        for follow in code[n - 1:]:
            m = re.search(r"\b(?:theorem|lemma)\s+(\w+)", follow)
            if m:
                name = m.group(1)
                break
        if name and not re.search(rf"#print\s+axioms\s+{re.escape(name)}\b", text):
            add("L6", n, name or "?")

    # L10: a proposed result must state what it is contributing.
    for n, line in enumerate(code, 1):
        if not PROPOSED_ATTR_RE.search(line):
            continue
        doc = _doc_comment_above(lines, n)
        if NOVELTY_PHRASE not in doc:
            name = None
            for follow in code[n - 1:]:
                m = re.search(r"\b(?:theorem|lemma|def)\s+(\w+)", follow)
                if m:
                    name = m.group(1)
                    break
            add("L10", n, f'{name or "?"} — docstring must contain "{NOVELTY_PHRASE}"')

    return sorted(findings, key=lambda f: (f.line, f.rule))


def _doc_comment_above(lines: list[str], lineno: int) -> str:
    """The doc comment immediately above a 1-indexed line, or "".

    Reads the raw lines rather than the stripped ones, because the docstring is
    exactly what `_strip_comments` removes.
    """
    i = lineno - 2  # 0-indexed line above the attribute
    while i >= 0 and not lines[i].strip():
        i -= 1
    if i < 0 or "-/" not in lines[i]:
        return ""
    end = i
    while i >= 0 and "/--" not in lines[i]:
        i -= 1
    if i < 0:
        return ""
    return "\n".join(lines[i:end + 1])


def argument_unit(path: str) -> str | None:
    """The argument a file belongs to, or `None` if it is not argument code.

    An argument is either a single module or a directory of them, so
    `Arguments/BornOfAVirgin.lean` and `Arguments/BornOfAVirgin/Lines.lean` both
    belong to `BornOfAVirgin`.
    """
    if not path.startswith(ARGUMENTS_DIR):
        return None
    rest = path[len(ARGUMENTS_DIR):]
    head = rest.split("/", 1)[0]
    return head[: -len(".lean")] if head.endswith(".lean") else head


def lint_units(files: dict[str, str]) -> list[Finding]:
    """L5, which is a rule about arguments rather than about files.

    Rivals are not optional: an argument encoding a Christian reading without at
    least one rival package is incomplete, not merely unpolished.

    Counted per argument rather than per file, because an argument is now
    allowed to be a directory. Splitting a monolith must not let it lose its
    rival, and the packages of a split argument all live in one file of it while
    the rest have none — which a per-file count would either wave through or
    complain about, depending on the file.
    """
    units: dict[str, list[tuple[str, str]]] = {}
    for path, text in sorted(files.items()):
        unit = argument_unit(path)
        if unit is None:
            continue
        units.setdefault(unit, [])
        for name in ARGUMENT_PACKAGE_RE.findall(text):
            units[unit].append((path, name))

    findings: list[Finding] = []
    for unit, found in sorted(units.items()):
        if not found or len(found) >= MIN_PACKAGES:
            continue
        path, name = found[0]
        extra = f"{unit}: only {len(found)} package ({name})"
        findings.append(Finding("L5", path, 1, RULE_TEXT["L5"] + f" ({extra})"))
    findings.extend(lint_satisfiability(files))
    return findings


def _positive_establishes(text: str) -> list[tuple[int, str]]:
    """Packages asserted to establish their conclusion, with line numbers.

    A negated occurrence is skipped: `¬ Establishes p` is refuted by a
    countermodel, which is itself a valuation satisfying every premise, so such
    a package is satisfiable already and needs no separate witness.
    """
    out: list[tuple[int, str]] = []
    for m in ESTABLISHES_RE.finditer(text):
        before = text[max(0, m.start() - 4): m.start()]
        if "¬" in before:
            continue
        out.append((text.count("\n", 0, m.start()) + 1, m.group(1)))
    return out


def lint_satisfiability(files: dict[str, str]) -> list[Finding]:
    """L11, which is a rule about arguments rather than about files.

    Checked per argument unit, like L5: the `Establishes` results and the
    `Satisfiable` witnesses live in the same file today, but nothing requires
    that, and a split argument must not lose a witness to the split.
    """
    establishes: dict[str, list[tuple[str, int, str]]] = {}
    witnessed: dict[str, set[str]] = {}
    for path, text in sorted(files.items()):
        unit = argument_unit(path)
        if unit is None:
            continue
        code = "\n".join(_strip_comments(text.splitlines()))
        establishes.setdefault(unit, [])
        witnessed.setdefault(unit, set())
        for lineno, name in _positive_establishes(code):
            establishes[unit].append((path, lineno, name))
        witnessed[unit].update(SATISFIABLE_RE.findall(code))

    findings: list[Finding] = []
    for unit, found in sorted(establishes.items()):
        seen: set[str] = set()
        for path, lineno, name in found:
            if name in witnessed[unit] or name in seen:
                continue
            seen.add(name)
            findings.append(
                Finding("L11", path, lineno,
                        RULE_TEXT["L11"] + f" ({name}: no `Satisfiable {name}.premises`)")
            )
    return findings


# Where the imported declarations L9 may legitimately be cited by name live.
# Foundation only, and deliberately: this library leans on it directly — prose
# names `weakening`, `of_mem`, `models_imply` — and scanning its 205 files costs
# under a tenth of a second. Mathlib is forty times larger, and nothing here
# cites a Mathlib lemma in prose; if that changes, measure before widening.
IMPORTED_ROOTS = (Path(".lake/packages/Foundation"),)

# A class field as Foundation writes them, with binders before the colon:
#
#     protected class Imp where
#       models_imply {𝓜 : M} {φ ψ : F} : 𝓜 ⊧ φ 🡒 ψ ↔ (𝓜 ⊧ φ → 𝓜 ⊧ ψ)
#
# `LEAN_FIELD_RE` wants the colon to follow the name, so it misses these — and
# `models_imply` is precisely the sort of name this library's prose wants to
# cite. This pattern is looser on purpose, and loose is safe *here* and only
# here: an over-broad imported set means the rule accepts a name in prose that
# upstream might not have, which is a weaker check. An over-broad set of names
# declared *locally* would mean the rule stops noticing deletions, which is the
# rule's whole purpose, so `declared_names` keeps the strict pattern.
IMPORTED_FIELD_RE = re.compile(r"^\s{2,}([a-z][A-Za-z0-9_']*)\b[^:=\n]*:", re.M)


def imported_names(roots: tuple[Path, ...] = IMPORTED_ROOTS) -> set[str]:
    """Declarations this library imports rather than declares.

    L9 asks whether a name a page mentions is a name the library has. Before
    this, "has" meant "declares here", so prose naming a Foundation lemma read
    as a dangling reference — which pushed documentation away from being
    specific, exactly backwards for a project whose case rests on borrowing a
    definition rather than restating it.

    Missing packages are not an error. A fresh clone has no `.lake/` until
    `lake exe cache get` runs, and a linter that refused to run before the
    first build would be worse than one that occasionally cannot confirm an
    imported name.
    """
    names: set[str] = set()
    for root in roots:
        if not root.is_dir():
            continue
        for p in sorted(root.rglob("*.lean")):
            text = p.read_text(encoding="utf-8", errors="replace")
            for pattern in (LEAN_DECL_RE, LEAN_CTOR_RE, IMPORTED_FIELD_RE, LEAN_SYNTAX_RE):
                names.update(pattern.findall(text))
    return names | {n.rsplit(".", 1)[-1] for n in names}


def _keep_only_docstrings(lines: list[str]) -> list[str]:
    """Blank out everything that is not a doc comment, keeping line numbers.

    The inverse of `_strip_comments`, and needed for the same reason read the
    other way round. A docstring under `Testimony/` is *published prose*:
    `argdoc` and `argtex` render every module and declaration docstring in
    `Testimony/Arguments/` into the site and the PDF verbatim, and doc-gen4
    publishes the rest. A paragraph there naming a result the library no longer
    has is exactly the drift L9 exists to catch, and until this function
    existed the rule could not see it — `declared_names` strips comments before
    collecting names, correctly, which left docstring prose read by nothing.

    Doc comments only: `/-- … -/` and `/-! … -/`. An ordinary `/- … -/` block
    or a `--` line comment is a note to whoever opens the file, not something
    this project publishes, and holding private notes to the same standard
    would make the rule tiresome without making a page safer.
    """
    out: list[str] = []
    depth = 0
    for line in lines:
        kept, i = [], 0
        while i < len(line):
            if depth:
                if line.startswith("-/", i):
                    depth -= 1
                    kept.append("  ")
                    i += 2
                    continue
                kept.append(line[i])
                i += 1
                continue
            if line.startswith("/--", i) or line.startswith("/-!", i):
                depth = 1
                kept.append("   ")
                i += 3
                continue
            kept.append(" ")
            i += 1
        out.append("".join(kept))
    return out


def lint_lean_prose(path: str, text: str, declared: set[str]) -> list[Finding]:
    """L9 again, over the docstrings in a Lean file rather than a page.

    Same rule and same message: a result named in prose must be a result the
    library still has. It reached `main` once without this — the root
    `SolaScriptura` docstring kept a paragraph naming four results a commit had
    just deleted, `argdoc` rendered it into the published page, and the page
    contradicted itself a few paragraphs from where it said the packages were
    gone. A review bot caught it; no gate could.
    """
    prose = "\n".join(_keep_only_docstrings(text.splitlines()))
    return [
        Finding("L9", path, n, RULE_TEXT["L9"] + f" (`{name}`)")
        for n, name in doc_mentions(prose)
        if name.rsplit(".", 1)[-1] not in declared and name not in declared
    ]


def declared_names(texts: dict[str, str]) -> set[str]:
    """Every name the Lean sources declare, plus the last segment of each.

    `ArgumentPackage.manifest` is declared and cited both ways, so both
    `ArgumentPackage.manifest` and `manifest` count as existing.

    Comments are stripped first: a docstring recalling a theorem that was
    deleted must not make the prose citing it look sound.
    """
    names: set[str] = set()
    for text in texts.values():
        code = "\n".join(_strip_comments(text.splitlines()))
        for pattern in (LEAN_DECL_RE, LEAN_CTOR_RE, LEAN_FIELD_RE, LEAN_SYNTAX_RE):
            names.update(pattern.findall(code))
    return names | {n.rsplit(".", 1)[-1] for n in names}


def doc_mentions(text: str) -> list[tuple[int, str]]:
    """Lean results a documentation page names.

    Two forms carry results: a name in backticks, and a declaration inside a
    ```lean block — README and the introduction both restate theorems that way.
    """
    found: list[tuple[int, str]] = []
    in_lean_fence = False
    in_fence = False
    for n, line in enumerate(text.splitlines(), 1):
        if FENCE_RE.match(line):
            if in_fence:
                in_fence, in_lean_fence = False, False
            else:
                in_fence = True
                in_lean_fence = bool(LEAN_FENCE_RE.match(line))
            continue
        if in_lean_fence:
            found.extend((n, m) for m in LEAN_DECL_RE.findall(line))
        elif not in_fence:
            found.extend((n, m.group(1)) for m in INLINE_CODE_RE.finditer(line))
    return [
        (n, name)
        for n, name in found
        if DOC_MENTION_RE.match(name) and name not in NOT_DECLARATIONS
    ]


def lint_doc(path: str, text: str, declared: set[str]) -> list[Finding]:
    """L9, which is a rule about prose rather than about Lean.

    The roadmap once spent two commits asserting the opposite of a proven
    theorem, and named a result that had been replaced. Generated pages cannot
    drift; prose can, and this is the part of it a machine can check — that
    every result a page names is a result the library still has.

    A qualified mention is judged by its last segment as well as whole, since
    a theorem declared inside a `namespace` block is written unqualified in the
    source: the rule catches a result that is gone, not a namespace typo.
    """
    return [
        Finding("L9", path, n, RULE_TEXT["L9"] + f" (`{name}`)")
        for n, name in doc_mentions(text)
        if name.rsplit(".", 1)[-1] not in declared and name not in declared
    ]


def is_generated_doc(path: str) -> bool:
    """Whether a markdown page is written by a generator rather than by hand.

    Shared by L9 and L12, because they exempt the same pages for the same
    reason: a generator owns the file, its `--check` run guards it, and a rule
    firing there would ask someone to hand-edit what they are forbidden to
    hand-edit.
    """
    return path in GENERATED_DOCS or path.startswith(GENERATED_DOC_DIRS)


def lint_markdown(path: str, text: str) -> list[Finding]:
    """L12: hand-written markdown, at most `MAX_LINE` columns.

    The prose is as much of the deliverable as the Lean, and more of it gets
    read: someone who does not read Lean reads the primer, the style guide and
    the roadmap. L8 has held Lean to 100 columns all along; this is its
    counterpart, and it counts *characters*, not bytes — the corpus is full of
    Greek, Hebrew and mathematical symbols, and a byte count would fail lines
    that are not long, on the files most worth writing carefully.

    Four things are exempt, and one conspicuously is not.

    *Generated pages* (`is_generated_doc`) are somebody else's output.

    *Generated blocks inside hand-written pages* are the reason a path-level
    exemption is not enough. The roadmap's status table is 60-odd rows of
    pretty-printed Lean statements between `<!-- BEGIN GENERATED: lake exe
    statusgen -->` markers, rewritten on every run and forbidden to hand-edit;
    `SUMMARY.md` has the same shape under `argdoc`. The rule reads the markers,
    so the prose on either side of the block is still held to the width.

    *Table rows* cannot be wrapped at all — a newline ends the row — so the
    choice is between exempting them and forbidding wide tables, and a wide
    table is often the honest shape for the data.

    *YAML frontmatter* carries the skills' `description:`, a single scalar the
    skill loader reads whole; the longest is 392 characters. A folded scalar
    would wrap it and preserve the string, but only if the loader is a real
    YAML parser, and finding out otherwise by breaking a skill is a poor trade.

    *Links are not exempt*, and that is a decision rather than an oversight. An
    inline link genuinely cannot be broken across lines, which looks like the
    same argument the table rows win on — but unlike a table row a link has a
    second form that fits: `[text][ref]`, with the URL defined elsewhere in the
    file. `style-guide.md` already does this once. So a link that will not fit
    is not an exception to the width; it is a link that should be a reference
    link.

    Code fences are not exempt either. A sample too wide for 100 columns is too
    wide for the rendered page, and the Lean inside one is held to 100 by L8
    wherever it also lives in a source file.
    """
    if is_generated_doc(path):
        return []
    lines = text.splitlines()
    in_frontmatter = bool(lines) and lines[0].strip() == FRONTMATTER_FENCE
    in_generated = False
    findings: list[Finding] = []
    for n, line in enumerate(lines, 1):
        if in_frontmatter:
            if n > 1 and line.strip() == FRONTMATTER_FENCE:
                in_frontmatter = False
            continue
        if in_generated:
            if GENERATED_END_RE.match(line):
                in_generated = False
            continue
        if GENERATED_BEGIN_RE.match(line):
            in_generated = True
            continue
        if TABLE_ROW_RE.match(line):
            continue
        if len(line) > MAX_LINE:
            findings.append(
                Finding("L12", path, n, RULE_TEXT["L12"] + f" ({len(line)} columns)")
            )
    return findings


def markdown_files(root: Path) -> list[Path]:
    """The hand-written markdown L12 reads, in a stable order."""
    found: list[Path] = []
    for dirpath, dirs, names in os.walk(root):
        dirs[:] = sorted(d for d in dirs if d not in MARKDOWN_SKIP_DIRS)
        for name in sorted(names):
            if name.endswith(".md"):
                p = Path(dirpath) / name
                if not is_generated_doc(_rel(p)):
                    found.append(p)
    return found


def doc_files(root: Path) -> list[Path]:
    """The documentation pages L9 reads, in a stable order."""
    found: list[Path] = []
    for pattern in DOC_PATHS:
        found.extend(sorted(root.glob(pattern)))
    return [p for p in found if not is_generated_doc(_rel(p))]


def _rel(p: Path) -> str:
    """A repository-relative POSIX path, as the rules expect to match on."""
    rel = p.as_posix()
    return rel[len("./"):] if rel.startswith("./") else rel


def lint_path(p: Path) -> list[Finding]:
    return lint_text(_rel(p), p.read_text(encoding="utf-8"))


def main(argv: list[str]) -> int:
    whole_library = not argv[1:]
    targets = [Path(a) for a in argv[1:]] or [Path("Testimony")]
    files: list[Path] = []
    # Named markdown is linted where it is named, so the file-write hook can
    # hand this a page as readily as a module. A named `.lean` file, or a
    # directory, keeps the old behaviour.
    named_markdown: list[Path] = []
    for t in targets:
        if t.is_dir():
            files.extend(sorted(t.rglob("*.lean")))
            named_markdown.extend(markdown_files(t))
        elif t.suffix == ".md":
            named_markdown.append(t)
        else:
            files.append(t)
    texts = {_rel(p): p.read_text(encoding="utf-8") for p in files}
    findings = [f for path, text in texts.items() for f in lint_text(path, text)]
    findings += lint_units(texts)

    # L9 asks whether a name exists, which only the whole library can answer.
    # It reads two kinds of prose: the documentation pages, and the docstrings
    # in the Lean sources, which `argdoc` and `argtex` publish verbatim.
    #
    # `docs/src/arguments/*.md` is deliberately not read. Those pages are
    # generated from the docstrings now linted above, so a stale name is caught
    # at its source, and `lake exe argdoc --check` catches a page that has
    # drifted from it. Linting both would report one defect twice and tempt
    # someone to edit a generated file.
    docs: list[Path] = []
    if whole_library:
        declared = declared_names(texts) | imported_names()
        for path, text in texts.items():
            findings += lint_lean_prose(path, text, declared)
        docs = doc_files(Path("."))
        for p in docs:
            findings += lint_doc(_rel(p), p.read_text(encoding="utf-8"), declared)

    # L12 needs no cross-file knowledge, so it runs over whatever was named —
    # and over all of the hand-written markdown when nothing was.
    pages = markdown_files(Path(".")) if whole_library else named_markdown
    for p in pages:
        findings += lint_markdown(_rel(p), p.read_text(encoding="utf-8"))

    findings.sort(key=lambda f: (f.path, f.line, f.rule))
    for f in findings:
        print(f)
    n = len({_rel(p) for p in (*files, *docs, *pages)})
    if findings:
        print(f"\ntestimony-lint: {len(findings)} finding(s) in {n} file(s)", file=sys.stderr)
        return 1
    print(f"testimony-lint: {n} file(s) clean")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
