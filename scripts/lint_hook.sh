#!/usr/bin/env bash
# PostToolUse hook: run the domain linter after a Lean file is edited.
#
# Claude Code delivers the tool call as JSON on stdin. Exits 0 silently for
# non-Lean edits so the hook is invisible unless it has something to say.
set -uo pipefail

path=$(python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
except Exception:
    print('')
    sys.exit(0)
print(d.get('tool_input', {}).get('file_path', ''))
" 2>/dev/null)

case "$path" in
  *.lean) ;;
  *) exit 0 ;;
esac

cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0
python3 scripts/testimony_lint.py "$path" 2>&1 | tail -20
