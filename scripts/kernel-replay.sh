#!/usr/bin/env sh
# Replay every Testimony declaration through the kernel, independently of the
# elaborator and of every tactic.
#
# `leanchecker Testimony` replays every .olean whose module name starts with
# `Testimony` — whatever it finds on disk, not what the source tree says. Lake
# never deletes the build output of a module whose source was removed, and CI
# restores .lake/ from a cache, so a stale file would be replayed as if it were
# current.
#
# So: build every target, delete build output that has no source, then replay.
# The library's tools are a library target of their own, which its root does not
# import, and are built here with it. A package built on the library replays its
# own modules the same way, from its own directory, naming its root and its
# executables, whose root modules its library does not build:
#
#   cd arguments && ../scripts/kernel-replay.sh TestimonyArguments bibgen argtex statusgen argdoc
#   cd examples  && ../scripts/kernel-replay.sh TestimonyExamples exampletex
#
# Its imports from the library are replayed by the library's own run.
set -eu

root=${1:-Testimony}
if [ "$#" -gt 0 ]; then shift; fi
if [ "$root" = Testimony ] && [ "$#" -eq 0 ]; then
  set -- TestimonyTools
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

# leanchecker replays each module as a task of its own, and each task imports
# that module's whole environment — Foundation, and Mathlib through it. Lean
# runs one task per core by default, so peak memory is that many environments
# at once; on a 4-core, 16 GB machine the arguments ran out of memory. Bound the
# tasks that run together with KERNEL_REPLAY_THREADS (Lean's LEAN_NUM_THREADS).
#
# And run the toolchain's leanchecker directly, not under `lake env`, which
# stays resident for the whole replay: ask lake once for the search path and the
# toolchain, then let lake exit.
LEAN_PATH=$(lake env printenv LEAN_PATH)
sysroot=$(lake env printenv LEAN_SYSROOT)
export LEAN_PATH
LEAN_NUM_THREADS=${KERNEL_REPLAY_THREADS:-2} "$sysroot/bin/leanchecker" "$root"
echo "kernel-replay: every $root module replayed through the kernel"
