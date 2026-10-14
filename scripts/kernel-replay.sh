#!/usr/bin/env sh
# Replay every Testimony declaration through the kernel, independently of the
# elaborator and of every tactic.
#
# `leanchecker Testimony` replays every .olean whose module name starts with
# `Testimony` — whatever it finds on disk, not what the source tree says. Two
# kinds of stale file would therefore be replayed as if they were current, and
# CI restores .lake/ from a cache, so both occur there:
#
#   - the tools' modules (Testimony.Tools.*) are roots of `lean_exe` targets,
#     which `lake build` does not build, so a cached .olean from an older commit
#     survives until something builds them;
#   - Lake never deletes the build output of a module whose source was removed.
#
# So: build every target, delete build output that has no source, then replay.
#
# A package built on the library replays its own modules the same way, from its
# own directory, naming its root and its targets:
#
#   cd examples && ../scripts/kernel-replay.sh TestimonyExamples exampletex
#
# Its imports from the library are replayed by the library's own run.
set -eu

root=${1:-Testimony}
if [ "$#" -gt 0 ]; then shift; fi
if [ "$root" = Testimony ] && [ "$#" -eq 0 ]; then
  set -- bibgen argtex statusgen argdoc
fi

lake build "$root" "$@"

out=.lake/build/lib/lean
find "$out/$root" -name '*.olean' | while read -r olean; do
  module=${olean#"$out"/}
  src=${module%.olean}.lean
  if [ ! -f "$src" ]; then
    echo "kernel-replay: removing build output of deleted module ${src%.lean}"
    rm -f "${olean%.olean}".*
  fi
done

lake env leanchecker "$root"
echo "kernel-replay: every $root module replayed through the kernel"
