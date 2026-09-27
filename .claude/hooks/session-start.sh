#!/usr/bin/env bash
# SessionStart hook for Claude Code on the web: make a cloud session able to run
# every gate in CLAUDE.md, including the two that render what a reader sees —
# the PDF (`tectonic`) and the docs site with its argument maps (`mdbook`).
#
# It does three things, each only when needed, so it is safe to run on every
# start and cheap once the container is cached:
#
# 1. Puts elan's `lake` on PATH for the session (cloud images install elan but
#    do not export ~/.elan/bin, and scripts/new-worktree.sh needs `lake`).
# 2. Installs tectonic 0.17.0, pinned and fetched as .devcontainer/Dockerfile
#    fetches it — the same build CI uses.
# 3. Installs mdbook 0.4.40, likewise.
#
# Local sessions are left alone: use the devcontainer there.

set -euo pipefail

if [[ "${CLAUDE_CODE_REMOTE:-}" != "true" ]]; then
  exit 0
fi

TECTONIC_VERSION=0.17.0
MDBOOK_VERSION=0.4.40
BIN=/usr/local/bin

log() { echo "session-start: $*" >&2; }

# 1. lake on PATH, for this hook and for the session.
if [[ -x "$HOME/.elan/bin/lake" ]]; then
  export PATH="$HOME/.elan/bin:$PATH"
  line='export PATH="$HOME/.elan/bin:$PATH"'
  if [[ -n "${CLAUDE_ENV_FILE:-}" ]] && ! grep -qxF "$line" "$CLAUDE_ENV_FILE" 2>/dev/null; then
    echo "$line" >> "$CLAUDE_ENV_FILE"
  fi
else
  log "elan not found at ~/.elan; install it before building (https://github.com/leanprover/elan)"
fi

# The release builds for this machine, chosen as the devcontainer chooses them:
# aarch64 gets the static musl build, since neither project ships aarch64-gnu.
case "$(uname -m)" in
  x86_64)  ARCH=x86_64-unknown-linux-gnu ;;
  aarch64) ARCH=aarch64-unknown-linux-musl ;;
  *) log "unsupported architecture $(uname -m); skipping tectonic and mdbook"; exit 0 ;;
esac

# 2. tectonic, for docs/latex/arguments.tex.
if ! command -v tectonic >/dev/null 2>&1 || \
   [[ "$(tectonic --version 2>/dev/null)" != *"$TECTONIC_VERSION"* ]]; then
  log "installing tectonic $TECTONIC_VERSION"
  curl -fsSL "https://github.com/tectonic-typesetting/tectonic/releases/download/tectonic%40${TECTONIC_VERSION}/tectonic-${TECTONIC_VERSION}-${ARCH}.tar.gz" \
    | tar xz -C "$BIN" tectonic
fi

# 3. mdbook, for `mdbook build docs`.
if ! command -v mdbook >/dev/null 2>&1 || \
   [[ "$(mdbook --version 2>/dev/null)" != *"$MDBOOK_VERSION"* ]]; then
  log "installing mdbook $MDBOOK_VERSION"
  curl -fsSL "https://github.com/rust-lang/mdBook/releases/download/v${MDBOOK_VERSION}/mdbook-v${MDBOOK_VERSION}-${ARCH}.tar.gz" \
    | tar xz -C "$BIN"
fi

log "$(tectonic --version), $(mdbook --version), $(lake --version 2>/dev/null || echo 'lake missing')"
