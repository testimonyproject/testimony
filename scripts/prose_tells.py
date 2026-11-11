#!/usr/bin/env python3
"""Count the habits of generated prose on a page (advisory; no gate runs it).

The habits are those of `.claude/skills/removing-ai-tells/SKILL.md`. Each is
counted per thousand words of prose, and the paragraphs with the most habits
are printed with their line numbers, so a revision can be compared with what it
replaced.

    python3 scripts/prose_tells.py docs/src/arguments/sola-fide.md
    python3 scripts/prose_tells.py --lean arguments/TestimonyArguments/SolaFide/Vulgate.lean

Markdown input skips fenced code, tables, HTML lines and the generated
`**\\`name\\`**` result headings. `--lean` reads only the docstrings and module
docs (`/-- … -/`, `/-! … -/`) of a Lean file.
"""

from __future__ import annotations

import argparse
import re
import statistics
import sys
from dataclasses import dataclass

STOCK_WORDS = (
    "crucially notably importantly essentially indeed ultimately robust nuanced "
    "landscape delve delves underscore underscores highlight highlights navigate "
    "multifaceted tapestry journey"
).split()

HABITS: dict[str, re.Pattern[str]] = {
    "bold label opening a paragraph": re.compile(r"^\*\*[^*`]+\*\*", re.M),
    "not X but Y / , not Y": re.compile(r"\bnot\b[^.;:]{1,60}\bbut\b|, not (?:a |an |the )?[a-z]"),
    "announcing": re.compile(
        r"\b(?:[Aa] reader (?:asks|may ask|might ask|wonders)|[Tt]his section"
        r"|[Tt]he question is|[Ii]t is worth noting|[Hh]ere is the point"
        r"|[Tt]hat is the point|[Tt]his matters)"
    ),
    "colon reveal": re.compile(
        r"\b(?:[Tt]wo|[Tt]hree|[Ff]our) (?:things|reasons|ways)[^.:]{0,30}:|\b[Tt]he answer:"
    ),
    "claims / does not claim template": re.compile(r"What (?:this|it) (?:does not )?claims?:"),
    "em dash": re.compile(r"—"),
    # Outside brackets: "(Romans 3:28; Galatians 2:16)" is a citation list.
    "semicolon": re.compile(r";(?![^()]*\))"),
    "stock word": re.compile(r"\b(?:" + "|".join(STOCK_WORDS) + r")\b", re.I),
}


@dataclass
class Paragraph:
    line: int
    text: str


def markdown_paragraphs(src: str) -> list[Paragraph]:
    out: list[Paragraph] = []
    buf: list[str] = []
    start = 0
    in_code = False
    for n, raw in enumerate(src.splitlines(), 1):
        line = raw.rstrip()
        if line.startswith("```"):
            in_code = not in_code
            continue
        if line.startswith("\\[") and not line.endswith("\\]"):
            in_code = True  # a display formula runs to its closing bracket
            continue
        if in_code and line.endswith("\\]"):
            in_code = False
            continue
        if line.startswith("\\["):
            continue
        skip = (
            in_code
            or line.startswith("|")
            or line.startswith("<")
            or line.startswith("#")
            or re.match(r"^\*\*`[^`]+`\*\*$", line)
            or "weakest at" in line  # a generated derivation, not prose
            or "\\(P_{" in line  # a generated line built round a formula
        )
        if skip or not line.strip():
            if buf:
                out.append(Paragraph(start, " ".join(buf)))
                buf = []
            continue
        if not buf:
            start = n
        buf.append(line.strip())
    if buf:
        out.append(Paragraph(start, " ".join(buf)))
    return out


def lean_paragraphs(src: str) -> list[Paragraph]:
    out: list[Paragraph] = []
    for m in re.finditer(r"/-[-!](.*?)-/", src, re.S):
        base = src.count("\n", 0, m.start()) + 1
        body = m.group(1)
        for p in markdown_paragraphs(body):
            out.append(Paragraph(base + p.line - 1, p.text))
    return out


def sentences(text: str) -> list[str]:
    return [s for s in re.split(r"(?<=[.?!])\s+", text) if len(s.split()) > 2]


def main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("path")
    ap.add_argument("--lean", action="store_true", help="read a Lean file's docstrings")
    ap.add_argument("--top", type=int, default=8, help="paragraphs to list")
    args = ap.parse_args(argv)
    src = open(args.path, encoding="utf-8").read()
    paras = lean_paragraphs(src) if args.lean else markdown_paragraphs(src)
    words = sum(len(p.text.split()) for p in paras) or 1
    print(f"{args.path}: {len(paras)} paragraphs, {words} words of prose\n")
    print(f"{'habit':36} {'count':>6} {'per 1000 words':>15}")
    for name, pat in HABITS.items():
        n = sum(len(pat.findall(p.text)) for p in paras)
        print(f"{name:36} {n:6} {1000 * n / words:15.1f}")
    lengths = [len(s.split()) for p in paras for s in sentences(p.text)]
    if lengths:
        print(
            f"\nsentence length: mean {statistics.mean(lengths):.1f} words, "
            f"spread (stdev) {statistics.pstdev(lengths):.1f}; "
            f"{sum(1 for x in lengths if x <= 12) * 100 // len(lengths)}% are 12 words or fewer"
        )
    scored = sorted(
        paras, key=lambda p: -sum(len(h.findall(p.text)) for h in HABITS.values())
    )
    print(f"\nparagraphs with the most habits (first {args.top}):")
    for p in scored[: args.top]:
        hits = sum(len(h.findall(p.text)) for h in HABITS.values())
        if hits == 0:
            break
        print(f"  line {p.line:5}: {hits:3} — {p.text[:90]}…")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
