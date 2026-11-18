#!/usr/bin/env bash
# Generate every file the site and the PDFs are made from but git does not hold:
# references.bib, the bibliography chapter, the argument pages, the summary, the
# roadmap and maturity pages (from docs/templates/), and the LaTeX documents.
#
#   scripts/generate-docs.sh           # build the generators and run them
#   scripts/generate-docs.sh --stub    # no Lean: the three templated pages only
#
# The generated files are not committed (.gitignore says why), so run this
# before `mdbook build docs` or `mdbook serve docs`, before typesetting a PDF,
# and before reading the page a change produces. It needs the library built
# (`lake build` at the root); the generators then build the arguments.
#
# `--stub` copies each template into place with its generated block empty, so
# that `mdbook build docs` can check the hand-written pages without a Lean
# build: CI's book job does this for a change that touches no build input. The
# argument pages are then missing, and mdbook creates them empty.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"

if [[ "${1:-}" == "--stub" ]]; then
  for f in SUMMARY roadmap maturity; do
    cp "$root/docs/templates/$f.md" "$root/docs/src/$f.md"
  done
  echo "generate-docs: templated pages copied into docs/src, generated blocks empty"
  exit 0
fi

cd "$root/arguments"
lake build bibgen argdoc argtex statusgen
lake exe bibgen
lake exe argdoc
lake exe argtex
lake exe statusgen

cd "$root/examples"
lake build exampletex
lake exe exampletex
