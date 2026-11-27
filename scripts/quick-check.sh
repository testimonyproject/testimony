#!/usr/bin/env bash
# Build the modules a change touched, and print only what needs reading.
#
#     scripts/quick-check.sh arguments/TestimonyArguments/SolaFide/James.lean [more.lean ...]
#     scripts/quick-check.sh            # every .lean file changed against origin/main
#
# For each file it finds the package the file belongs to (the library at the
# root, `arguments/` or `examples/`), builds that file's module and what it
# imports, and prints errors, warnings and failed `#guard_msgs` with a few lines
# of context: never the `#print axioms` lines or the progress of a thousand
# modules, which a full build prints and nobody reads. Then it runs the domain
# linter on the same files.
#
# It is the loop to run while working. It is not the gates: before a commit,
# run them in full (`checking-the-build`). Builds run one at a time, because two
# `lake build`s at once can corrupt each other's compiled files.
set -uo pipefail

root=$(git rev-parse --show-toplevel)
cd "$root" || exit 2
export PATH="$HOME/.elan/bin:$PATH"

if [ $# -eq 0 ]; then
  mapfile -t files < <( { git diff --name-only origin/main...HEAD; git diff --name-only; } \
    | grep '\.lean$' | sort -u)
else
  files=("$@")
fi
[ ${#files[@]} -eq 0 ] && { echo "quick-check: no Lean files to check"; exit 0; }

status=0
declare -A modules relpaths
for f in "${files[@]}"; do
  f=${f#./}
  [ -f "$f" ] || { echo "quick-check: $f is gone, skipped"; continue; }
  case "$f" in
    arguments/*) pkg=arguments; rel=${f#arguments/} ;;
    examples/*)  pkg=examples;  rel=${f#examples/} ;;
    *)           pkg=.;         rel=$f ;;
  esac
  mod=${rel%.lean}; mod=${mod//\//.}
  modules[$pkg]+=" $mod"
  relpaths[$pkg]+=" $rel"
done

# The library first, so that a package built on it sees its change.
for pkg in . arguments examples; do
  mods=${modules[$pkg]:-}
  rels=${relpaths[$pkg]:-}
  [ -z "$mods" ] && continue
  echo "== lake build$mods  (in $pkg)"
  # shellcheck disable=SC2086
  out=$(cd "$pkg" && lake build $mods 2>&1)
  code=$?
  # Errors from anywhere; warnings only from the files asked about, because a
  # replayed dependency repeats warnings that are not this change's.
  printf '%s\n' "$out" | python3 -c '
import re, sys
mine = sys.argv[1:]
block, keep, shown = [], False, 0
def flush():
    global shown
    if keep and block and shown < 120:
        print("\n".join(block[:12])); shown += len(block[:12])
for line in sys.stdin.read().splitlines():
    m = re.match(r"(error|warning|info): (\S+?):\d+:\d+: ", line)
    if m or re.match(r"(✖|⚠|ℹ|✔) \[", line) or line.startswith("error:"):
        flush(); block = [line]
        if line.startswith("error"):
            keep = True
        elif m and m.group(1) == "warning":
            keep = any(m.group(2).endswith(f) or f.endswith(m.group(2)) for f in mine)
        else:
            keep = False
    else:
        block.append(line)
flush()
' $rels
  if [ $code -ne 0 ]; then
    status=1
  else
    echo "   built"
  fi
done

echo "== testimony_lint"
python3 scripts/testimony_lint.py "${files[@]}" 2>&1 | tail -30 || status=1
exit $status
