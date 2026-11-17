#!/usr/bin/env bash
# Typesets each LaTeX document named, in its own directory, with tectonic, and
# fails if any glyph is missing from the fonts it is set in.
#
# XeTeX does not stop for a character its font lacks. It logs "Missing
# character", leaves a blank where the glyph should be, and the PDF is written
# anyway; that is how the published sola-fide.pdf came to read 'Paul's verb
# "justify" ( )', with the Greek gone. The fonts are chosen in
# Testimony.Logic.Latex.fonts; this is the check that they cover every
# character the documents quote.
#
# Usage: scripts/typeset.sh docs/latex/arguments.tex docs/latex/arguments/*.tex
set -euo pipefail

status=0
for tex in "$@"; do
  dir=$(dirname "$tex")
  name=$(basename "$tex")
  log=$(mktemp)
  if ! (cd "$dir" && tectonic "$name") >"$log" 2>&1; then
    cat "$log"
    echo "typeset: $tex failed" >&2
    status=1
  elif grep -q "Missing character" "$log"; then
    grep "Missing character" "$log" | sort | uniq -c >&2
    echo "typeset: $tex has characters its fonts lack (listed above)" >&2
    status=1
  else
    echo "typeset: $tex"
  fi
  rm -f "$log"
done
exit "$status"
