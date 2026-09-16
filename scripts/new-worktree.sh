#!/usr/bin/env bash
# Create a git worktree for a piece of work, and initialise it so that
# `lake build` is usable immediately.
#
# Why this exists: `.lake/` is gitignored, so a fresh worktree does not inherit
# it from the checkout you branched from. Without `lake exe cache get` the
# first build in that worktree compiles Mathlib from source — hours rather than
# minutes. Every worktree needs its own cache fetch, once.
#
# Usage: scripts/new-worktree.sh <branch-name> [base-ref]

set -euo pipefail

branch="${1:-}"
base="${2:-main}"

if [[ -z "$branch" ]]; then
  echo "usage: scripts/new-worktree.sh <branch-name> [base-ref]" >&2
  exit 2
fi

if ! command -v lake >/dev/null 2>&1; then
  echo "new-worktree: 'lake' not on PATH — install elan first" >&2
  exit 1
fi

repo_root="$(git rev-parse --show-toplevel)"
dest="$(dirname "$repo_root")/testimony-worktrees/$branch"

if [[ -e "$dest" ]]; then
  echo "new-worktree: $dest already exists" >&2
  exit 1
fi

git -C "$repo_root" fetch --quiet origin "$base" 2>/dev/null || true
mkdir -p "$(dirname "$dest")"
git -C "$repo_root" worktree add -b "$branch" "$dest" "$base"

cd "$dest"
echo "new-worktree: fetching Mathlib oleans — the slow step, but only once"
lake exe cache get

echo
echo "new-worktree: ready"
echo "  cd $dest"
echo "  lake build && lake lint && lake exe axiom-audit && python3 scripts/testimony_lint.py"
