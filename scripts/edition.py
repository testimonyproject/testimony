#!/usr/bin/env python3
"""Which edition a printed document is, from git, for its title and its last page.

A document `lake exe argtex` writes names its edition twice: under the title, as
a date and a version, and in the appendix "How this edition was made", as the
commit a reader checks out to make it again. It names them through macros
(`\\editiondate`, `\\editionversion`, `\\editioncommit`, `\\editionremark`) that
default to an unrecorded copy, and reads `edition.def`, beside it, if there is
one. This script writes that file.

It runs when the PDFs are typeset (`.github/workflows/pdf.yml`), not when the
`.tex` is generated, for the reason `credits.py` does: the commit a document is
typeset from is not known until it is made. A pull request is typeset from
GitHub's trial merge, and `main` from the merge itself.

    python3 scripts/edition.py docs/latex docs/latex/arguments

What it records:

- The version is the release tag, where the commit carries one (`v1.0`), and
  otherwise the commit's short hash.
- The date is the commit's, not the day it was typeset, so the same commit
  always makes the same edition.
- The commit is the full hash, which the appendix tells a reader to check out.
- On a pull request (`GITHUB_EVENT_NAME` is `pull_request`) the title also says
  that this is a preview of that pull request, not yet part of the library:
  the commit it names is GitHub's trial merge, which nobody can cite.
"""

from __future__ import annotations

import os
import re
import subprocess
import sys
from datetime import datetime
from pathlib import Path

MONTHS = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December",
]


def git(*args: str) -> str:
    """The output of a git command, stripped; empty if it fails."""
    r = subprocess.run(["git", *args], capture_output=True, text=True)
    return r.stdout.strip() if r.returncode == 0 else ""


def escape(s: str) -> str:
    """A string as LaTeX sets it literally: a tag may hold `_` or `#`."""
    out = []
    for ch in s:
        if ch in "&%$#_{}":
            out.append("\\" + ch)
        elif ch == "~":
            out.append("\\textasciitilde{}")
        elif ch == "^":
            out.append("\\textasciicircum{}")
        elif ch == "\\":
            out.append("\\textbackslash{}")
        else:
            out.append(ch)
    return "".join(out)


def long_date(iso: str) -> str:
    """`2026-11-17T10:43:48+00:00` as `17 November 2026`."""
    d = datetime.fromisoformat(iso)
    return f"{d.day} {MONTHS[d.month - 1]} {d.year}"


def pull_request(env: dict[str, str]) -> str | None:
    """The pull request's number, when this is a pull request's build."""
    if env.get("GITHUB_EVENT_NAME") != "pull_request":
        return None
    m = re.fullmatch(r"refs/pull/(\d+)/merge", env.get("GITHUB_REF", ""))
    return m.group(1) if m else None


def edition_file(commit: str, short: str, tag: str, date: str, pr: str | None) -> str:
    """The contents of `edition.def`."""
    version = tag or short
    remark = (
        f"A preview of pull request {pr}, not yet part of the library"
        if pr else ""
    )
    lines = [
        "% Written by scripts/edition.py when this document was typeset. Not committed.",
        "\\editionrecordedtrue",
        *(["\\editionpreviewtrue"] if pr else []),
        f"\\renewcommand{{\\editiondate}}{{{escape(date)}}}",
        f"\\renewcommand{{\\editionversion}}{{{escape(version)}}}",
        f"\\renewcommand{{\\editioncommit}}{{{escape(commit)}}}",
        f"\\renewcommand{{\\editionremark}}{{{escape(remark)}}}",
    ]
    return "\n".join(lines) + "\n"


def main(argv: list[str]) -> int:
    if not argv:
        print("usage: edition.py <dir> [<dir> ...]", file=sys.stderr)
        return 2
    commit = git("rev-parse", "HEAD")
    if not commit:
        print("edition: not in a git repository", file=sys.stderr)
        return 1
    short = git("rev-parse", "--short", "HEAD")
    # Only a release's tag names an edition: `release.yml` publishes `v*`.
    tag = git("describe", "--tags", "--exact-match", "--match", "v*", "HEAD")
    date = long_date(git("show", "-s", "--format=%cI", "HEAD"))
    text = edition_file(commit, short, tag, date, pull_request(dict(os.environ)))
    for d in argv:
        # Not `.tex`: the PDF workflow typesets every `*.tex` in these
        # directories, and would take this file for a document.
        out = Path(d) / "edition.def"
        out.write_text(text)
        print(f"edition: wrote {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
