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
set -eu

lake build Testimony bibgen argtex statusgen argdoc

out=.lake/build/lib/lean
find "$out/Testimony" -name '*.olean' | while read -r olean; do
  module=${olean#"$out"/}
  src=${module%.olean}.lean
  if [ ! -f "$src" ]; then
    echo "kernel-replay: removing build output of deleted module ${src%.lean}"
    rm -f "${olean%.olean}".*
  fi
done

lake env leanchecker Testimony
echo "kernel-replay: every Testimony module replayed through the kernel"
