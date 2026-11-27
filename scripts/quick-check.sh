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
declare -A modules
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
done

# The library first, so that a package built on it sees its change.
for pkg in . arguments examples; do
  mods=${modules[$pkg]:-}
  [ -z "$mods" ] && continue
  echo "== lake build$mods  (in $pkg)"
  # shellcheck disable=SC2086
  out=$(cd "$pkg" && lake build $mods 2>&1)
  code=$?
  printf '%s\n' "$out" | grep -E -A6 '^(error|warning)|error:|warning:|guard_msgs' \
    | grep -v -E "depends on axioms|^info:" | head -120
  if [ $code -ne 0 ]; then
    status=1
    printf '%s\n' "$out" | tail -3
  else
    echo "   built"
  fi
done

echo "== testimony_lint"
python3 scripts/testimony_lint.py "${files[@]}" 2>&1 | tail -30 || status=1
exit $status
