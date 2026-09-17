#!/usr/bin/env python3
"""Domain linter for the Testimony library.

Tier 4 of the four checks described in the style guide. The general-purpose
Lean linters do not know what a citation is, what an argument atom is, or that
this project forbids `native_decide`; these rules do.

Source-level and sub-second, so it can run on every file write rather than only
in CI.

Usage:
    python3 scripts/testimony_lint.py [paths...]     # default: Testimony/
"""
from __future__ import annotations

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
}


@dataclass(frozen=True)
class Finding:
    rule: str
    path: str
    line: int
    message: str

    def __str__(self) -> str:
        return f"{self.path}:{self.line}: [{self.rule}] {self.message}"


def _strip_comments(lines: list[str]) -> list[str]:
    """Blank out block comments so prose does not trip code rules."""
    out, depth = [], 0
    for line in lines:
        kept, i = [], 0
        while i < len(line):
            if line.startswith("/-", i):
                depth += 1
                i += 2
            elif line.startswith("-/", i) and depth:
                depth -= 1
                i += 2
            else:
                kept.append(" " if depth else line[i])
                i += 1
        text = "".join(kept)
        out.append("" if text.strip().startswith("--") else text)
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
        if "@[headline]" not in line:
            continue
        name = None
        for follow in code[n - 1:]:
            m = re.search(r"\b(?:theorem|lemma)\s+(\w+)", follow)
            if m:
                name = m.group(1)
                break
        if name and not re.search(rf"#print\s+axioms\s+{re.escape(name)}\b", text):
            add("L6", n, name or "?")

    return sorted(findings, key=lambda f: (f.line, f.rule))


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
    return findings


def _rel(p: Path) -> str:
    """A repository-relative POSIX path, as the rules expect to match on."""
    rel = p.as_posix()
    return rel[len("./"):] if rel.startswith("./") else rel


def lint_path(p: Path) -> list[Finding]:
    return lint_text(_rel(p), p.read_text(encoding="utf-8"))


def main(argv: list[str]) -> int:
    targets = [Path(a) for a in argv[1:]] or [Path("Testimony")]
    files: list[Path] = []
    for t in targets:
        files.extend(sorted(t.rglob("*.lean")) if t.is_dir() else [t])
    texts = {_rel(p): p.read_text(encoding="utf-8") for p in files}
    findings = [f for path, text in texts.items() for f in lint_text(path, text)]
    findings += lint_units(texts)
    findings.sort(key=lambda f: (f.path, f.line, f.rule))
    for f in findings:
        print(f)
    n = len(files)
    if findings:
        print(f"\ntestimony-lint: {len(findings)} finding(s) in {n} file(s)", file=sys.stderr)
        return 1
    print(f"testimony-lint: {n} file(s) clean")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
