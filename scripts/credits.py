#!/usr/bin/env python3
"""Who wrote each argument, from git history, for the printed documents.

`lake exe argtex` writes `\\credit{TestimonyArguments.SolaFide}` where a
document names the people behind an argument: under the title of an argument
printed alone, and (as `\\creditline`) under each argument's heading in the
book. `\\credit{all}`
names everyone behind every argument a document holds. The macro expands to
whatever `credits.tex`, beside the document, defines for that argument, and to
nothing if there is no such file.

This script writes that file. It runs when the PDFs are typeset
(`.github/workflows/pdf.yml`), not when the `.tex` is generated, for a reason:
a commit that names no person is credited to whoever merged it, so the credits
change at the moment of merge. A committed `.tex` holding them would be stale
on `main` the instant its pull request merged, and `argtex --check` would fail
there. Worked out at typesetting, from the history CI checks out, they are
never stale.

    python3 scripts/credits.py docs/latex docs/latex/arguments

How a commit is credited:

- A person who authored it, or is named in a `Co-Authored-By:` trailer, is
  credited. Names pass through `.mailmap`, so one person spelled two ways is
  one person.
- A commit authored by Claude that names no person is credited to the author
  of the merge that brought it into the branch: the first-parent merge whose
  second parent reaches it. A commit pushed straight onto the branch is
  credited to its committer, if that is a person.
- Claude itself is not listed as an author. Where any commit to an argument was
  made with Claude, its credit adds "Written with Claude Code", so that is said
  rather than hidden.

A commit counts for an argument if it touches the argument's own sources,
wherever they have lived: `arguments/TestimonyArguments/<Name>.lean` and
`<Name>/`, its meanings module, and the same files under `Testimony/Arguments/`
and `Testimony/Meanings/`, where the arguments were before they became a
package of their own. Generated files are not sources, so regenerating a page
credits no one. Works and sources shared between arguments are not counted,
because they cannot be divided between them.

The script refuses a shallow clone: a history cut short would drop people's
credit without saying so.
"""

from __future__ import annotations

import re
import subprocess
import sys
from dataclasses import dataclass, field
from pathlib import Path

FIELD = "\x1f"
RECORD = "\x1e"
TRAILER = "\x1d"

AI_NOTE = "Written with Claude Code"

# A `\credit{...}` or `\creditline{...}` request in a generated document. A
# key never holds `#`, which leaves out the macros' own definitions.
CREDIT_REQUEST = re.compile(r"\\credit(?:line)?\{([^}#]*)\}")


@dataclass(frozen=True)
class Ident:
    """A name and an email address, as git records an author."""

    name: str
    email: str

    @property
    def is_ai(self) -> bool:
        """Whether this is Claude, by any of the names it commits under."""
        e = self.email.lower()
        return e == "noreply@anthropic.com" or "claude[bot]" in e or "claude[bot]" in self.name

    @property
    def is_person(self) -> bool:
        """Whether this is a person: neither Claude nor GitHub's own merge identity."""
        return not self.is_ai and self.email.lower() != "noreply@github.com"


@dataclass
class Commit:
    """One commit, as much of it as credit needs."""

    sha: str
    parents: list[str]
    author: Ident
    committer: Ident
    coauthors: list[Ident] = field(default_factory=list)
    files: list[str] = field(default_factory=list)


def parse_ident(s: str) -> Ident | None:
    """`Name <email>`, as a trailer writes it, or None if it is not one."""
    m = re.fullmatch(r"\s*(.*?)\s*<([^>]*)>\s*", s)
    return Ident(m.group(1), m.group(2)) if m else None


def source_paths(ns: str) -> list[str]:
    """The paths an argument's sources have lived at, as prefixes: a directory
    ends in `/`, a file does not."""
    name = ns.rsplit(".", 1)[-1]
    return [
        f"arguments/TestimonyArguments/{name}.lean",
        f"arguments/TestimonyArguments/{name}/",
        f"arguments/TestimonyArguments/Meanings/{name}.lean",
        f"Testimony/Arguments/{name}.lean",
        f"Testimony/Arguments/{name}/",
        f"Testimony/Meanings/{name}.lean",
    ]


def touches(commit: Commit, prefixes: list[str]) -> bool:
    """Whether the commit changes a file under any of the prefixes."""
    return any(
        f == p or (p.endswith("/") and f.startswith(p)) for f in commit.files for p in prefixes
    )


def people(commit: Commit, merged_by: dict[str, Ident], first_parent: set[str]) -> list[Ident]:
    """The people a commit is credited to, by the rules in the module docstring."""
    named = [i for i in [commit.author, *commit.coauthors] if i.is_person]
    if named:
        return named
    if commit.sha in merged_by and merged_by[commit.sha].is_person:
        return [merged_by[commit.sha]]
    if commit.sha in first_parent and commit.committer.is_person:
        return [commit.committer]
    return []


def made_with_ai(commit: Commit) -> bool:
    """Whether Claude authored or co-authored the commit."""
    return any(i.is_ai for i in [commit.author, *commit.coauthors])


@dataclass
class Credit:
    """What one argument's credit line says."""

    people: list[str]
    with_ai: bool

    def latex(self) -> str:
        """The credit as LaTeX: the names, and the note on its own line."""
        lines = []
        if self.people:
            lines.append(", ".join(escape(p) for p in self.people))
        if self.with_ai:
            lines.append("{\\small " + AI_NOTE + "}")
        return " \\\\ ".join(lines)


def credit(
    ns_list: list[str], commits: list[Commit], merged_by: dict[str, Ident], first_parent: set[str]
) -> Credit:
    """The credit for the arguments named: everyone credited for a commit to
    any of them, in the order they first contributed."""
    prefixes = [p for ns in ns_list for p in source_paths(ns)]
    seen: list[str] = []
    with_ai = False
    # Oldest first, so the names are in the order people joined the work.
    for c in reversed(commits):
        if not touches(c, prefixes):
            continue
        with_ai = with_ai or made_with_ai(c)
        for i in people(c, merged_by, first_parent):
            if i.name not in seen:
                seen.append(i.name)
    return Credit(seen, with_ai)


def escape(s: str) -> str:
    """Escape the characters TeX treats specially in a name."""
    out = s.replace("\\", "\\textbackslash{}")
    for ch in "&%$#_{}":
        out = out.replace(ch, "\\" + ch)
    return out.replace("~", "\\textasciitilde{}").replace("^", "\\textasciicircum{}")


def git(*args: str) -> str:
    """Run git and return its output."""
    return subprocess.run(["git", *args], capture_output=True, text=True, check=True).stdout


def mailmap(ident: Ident) -> Ident:
    """A trailer's identity, through `.mailmap`, as `%aN` maps an author's."""
    out = git("check-mailmap", f"{ident.name} <{ident.email}>").strip()
    return parse_ident(out) or ident


def read_commits() -> list[Commit]:
    """Every commit reachable from HEAD, newest first, with the files it changes."""
    fmt = FIELD.join(
        [
            RECORD + "%H",
            "%P",
            "%aN",
            "%aE",
            "%cN",
            "%cE",
            f"%(trailers:key=Co-Authored-By,valueonly,separator=%x1d)",
        ]
    )
    out = git("log", "--use-mailmap", "--no-renames", "--name-only", f"--format={fmt}", "HEAD")
    cache: dict[Ident, Ident] = {}
    commits = []
    for rec in out.split(RECORD)[1:]:
        head, _, rest = rec.partition("\n")
        sha, parents, an, ae, cn, ce, trailers = head.split(FIELD)
        coauthors = []
        for t in trailers.split(TRAILER):
            i = parse_ident(t)
            if i is not None:
                if i not in cache:
                    cache[i] = mailmap(i)
                coauthors.append(cache[i])
        files = [f for f in rest.splitlines() if f.strip()]
        commits.append(
            Commit(sha, parents.split(), Ident(an, ae), Ident(cn, ce), coauthors, files)
        )
    return commits


def merge_map(commits: list[Commit]) -> tuple[dict[str, Ident], set[str]]:
    """For each commit a first-parent merge brought in, that merge's author; and
    the commits on the first-parent chain itself."""
    by_sha = {c.sha: c for c in commits}
    chain = git("rev-list", "--first-parent", "HEAD").split()
    merged_by: dict[str, Ident] = {}
    for sha in chain:
        c = by_sha[sha]
        if len(c.parents) < 2:
            continue
        for brought in git("rev-list", f"{c.parents[0]}..{sha}").split():
            if brought != sha:
                merged_by.setdefault(brought, c.author)
    return merged_by, set(chain)


def requests(tex: str) -> list[str]:
    """The arguments a document asks credit for, in order, without repeats."""
    out: list[str] = []
    for key in CREDIT_REQUEST.findall(tex):
        if key not in out:
            out.append(key)
    return out


def credits_file(texts: list[str], commits, merged_by, first_parent) -> str:
    """`credits.tex` for the documents in one directory."""
    keys: list[str] = []
    for t in texts:
        for k in requests(t):
            if k not in keys:
                keys.append(k)
    named = [k for k in keys if k != "all"]
    lines = ["% Generated by scripts/credits.py from git history. Not committed.\n"]
    for k in keys:
        c = credit(named if k == "all" else [k], commits, merged_by, first_parent)
        # Undefined, not empty: `\creditline` then sets nothing at all.
        if not c.latex():
            continue
        lines.append(f"\\expandafter\\def\\csname credit@{k}\\endcsname{{{c.latex()}}}\n")
    return "".join(lines)


def main(argv: list[str]) -> int:
    if not argv:
        print("usage: credits.py <dir> [<dir> ...]", file=sys.stderr)
        return 2
    if git("rev-parse", "--is-shallow-repository").strip() == "true":
        print(
            "credits: this clone is shallow, so credit would be missing for older work; "
            "run `git fetch --unshallow` (in CI, check out with fetch-depth: 0)",
            file=sys.stderr,
        )
        return 1
    commits = read_commits()
    merged_by, first_parent = merge_map(commits)
    for d in argv:
        texts = [p.read_text() for p in sorted(Path(d).glob("*.tex")) if p.name != "credits.tex"]
        out = Path(d) / "credits.tex"
        out.write_text(credits_file(texts, commits, merged_by, first_parent))
        print(f"credits: wrote {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
