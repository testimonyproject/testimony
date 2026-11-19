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
# A document is set on A4. With `--paper letter` (or any paper KOMA-Script
# names), it is set on that paper instead, as <name>-<paper>.pdf beside
# <name>.pdf: a one-line wrapper defines \testimonypaper, which the generated
# preamble reads, and inputs the document, so one .tex makes every edition.
#
# Usage: scripts/typeset.sh [--paper letter] docs/latex/arguments.tex docs/latex/arguments/*.tex
set -euo pipefail

paper=""
if [ "${1:-}" = "--paper" ]; then
  paper="$2"
  shift 2
fi

status=0
for tex in "$@"; do
  dir=$(dirname "$tex")
  name=$(basename "$tex" .tex)
  job="$name"
  if [ -n "$paper" ]; then
    job="$name-$paper"
    printf '\\def\\testimonypaper{%s}\\input{%s}\n' "$paper" "$name" >"$dir/$job.tex"
  fi
  log=$(mktemp)
  if ! (cd "$dir" && tectonic "$job.tex") >"$log" 2>&1; then
    cat "$log"
    echo "typeset: $tex ($job) failed" >&2
    status=1
  elif grep -q "Missing character" "$log"; then
    grep "Missing character" "$log" | sort | uniq -c >&2
    echo "typeset: $tex ($job) has characters its fonts lack (listed above)" >&2
    status=1
  else
    echo "typeset: $dir/$job.pdf"
  fi
  rm -f "$log"
  if [ -n "$paper" ]; then rm -f "$dir/$job.tex"; fi
done
exit "$status"
