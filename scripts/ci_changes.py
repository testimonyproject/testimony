#!/usr/bin/env python3
"""Which of CI's jobs a change needs, from the files it touches.

The build, the benchmarks and the print edition take tens of minutes, and a
change to a hand-written page or a skill gives them nothing to check. So CI
asks this script first, and runs each job only when its inputs changed:

- `lean`: the four gates, the generated-files checks, the benchmarks and the
  PDF. Every file is an input *unless* it is one no build step reads, so a new
  kind of file runs the build until someone decides otherwise. That is the safe
  way to be wrong.
- `docs`: `mdbook build docs`, which reads only `docs/`.
- `image`: the devcontainer image, built from `.devcontainer/` and the two
  files its Dockerfile copies in.

The domain linter is not here: it is cheap, it reads hand-written pages (L9,
L12) as much as Lean, and so it runs on every change.

Used by `.github/workflows/ci.yml` and `pdf.yml`:

    python3 scripts/ci_changes.py --base <sha> --head <sha>   # diff two commits
    python3 scripts/ci_changes.py --all                       # everything

Each output is written as `name=true|false`, to `$GITHUB_OUTPUT` when set and
to standard output always. A diff that cannot be computed runs everything.
"""

from __future__ import annotations

import argparse
import os
import subprocess
import sys
from fnmatch import fnmatchcase

# Files no build step reads, beside the Markdown files at the root (README,
# CLAUDE.md, REVIEW.md and the rest). `fnmatchcase`'s `*` crosses `/`, so
# `docs/*` is the whole tree. Hand-written pages only: the generated ones are written by the
# arguments' generators, and `--check` fails a change that leaves them stale, so
# touching one is a reason to build.
NOT_BUILD_INPUTS = (
    "docs/*",
    "LICENSE*",
    ".claude/*",
    ".githooks/*",
    ".github/*",
    "assets/*",
    "scripts/new-worktree.sh",
    "scripts/lint_hook.sh",
    "scripts/prose_tells.py",
    # The linter and its tests run on every change, in their own job.
    "scripts/testimony_lint.py",
    "scripts/test_testimony_lint.py",
    ".gitignore",
    ".dockerignore",
)

# Written by `lake exe bibgen`, `argtex`, `statusgen`, `argdoc` and
# `exampletex`, and checked by their `--check`.
GENERATED = (
    "references.bib",
    "docs/src/bibliography.md",
    "docs/src/roadmap.md",
    "docs/src/SUMMARY.md",
    "docs/src/arguments/*",
    "docs/latex/*",
    "examples/docs/latex/*",
)

# The workflows that run the build, and this script: a change to them is
# checked by running them.
BUILD_WORKFLOWS = (
    ".github/workflows/ci.yml",
    ".github/workflows/pdf.yml",
    ".github/workflows/devcontainer-image.yml",
    "scripts/ci_changes.py",
    "scripts/test_ci_changes.py",
)

IMAGE_INPUTS = (
    ".devcontainer/*",
    ".dockerignore",
    "lean-toolchain",
    "scripts/bench-compare.py",
    ".github/workflows/devcontainer-image.yml",
)

DOCS_INPUTS = ("docs/*", ".github/workflows/ci.yml")


def matches(path: str, patterns: tuple[str, ...]) -> bool:
    """Whether `path` matches any of `patterns`."""
    return any(fnmatchcase(path, p) for p in patterns)


def is_build_input(path: str) -> bool:
    """Whether a change to `path` needs the build."""
    if matches(path, GENERATED) or matches(path, BUILD_WORKFLOWS):
        return True
    if path.endswith(".md") and "/" not in path:
        return False
    return not matches(path, NOT_BUILD_INPUTS)


def classify(paths: list[str]) -> dict[str, bool]:
    """The jobs a change to `paths` needs."""
    return {
        "lean": any(is_build_input(p) for p in paths),
        "docs": any(matches(p, DOCS_INPUTS) for p in paths),
        "image": any(matches(p, IMAGE_INPUTS) for p in paths),
    }


def everything() -> dict[str, bool]:
    """Every job, for a run with nothing to diff against."""
    return {"lean": True, "docs": True, "image": True}


def changed_files(base: str, head: str) -> list[str] | None:
    """The files that differ between `base` and `head`, or None if git cannot say."""
    try:
        out = subprocess.run(
            ["git", "diff", "--name-only", "--no-renames", base, head],
            capture_output=True,
            text=True,
            check=True,
        )
    except (OSError, subprocess.CalledProcessError) as e:
        print(f"ci_changes: cannot diff {base}..{head}: {e}", file=sys.stderr)
        return None
    return [line for line in out.stdout.splitlines() if line]


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("--base")
    parser.add_argument("--head", default="HEAD")
    parser.add_argument("--all", action="store_true", help="run every job")
    args = parser.parse_args(argv)

    result = everything()
    if not args.all and args.base and set(args.base) != {"0"}:
        paths = changed_files(args.base, args.head)
        if paths is not None:
            print("Changed files:", *paths, sep="\n  ")
            result = classify(paths)

    lines = [f"{k}={'true' if v else 'false'}" for k, v in result.items()]
    print(*lines, sep="\n")
    if out := os.environ.get("GITHUB_OUTPUT"):
        with open(out, "a", encoding="utf-8") as f:
            f.write("\n".join(lines) + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
