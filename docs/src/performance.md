# Performance: the engine, measured

Every argument the library adds makes every later check dearer: a dispute's
defeat table is one decision per ordered pair of parties, each decided in the
kernel over the parties' premises and the argument's meaning postulates. So the
engine is made faster and lighter as a loop, measured at each step, until a
further change makes no significant difference. How to run the loop is in the
`optimising-the-engine` skill (`.claude/skills/optimising-the-engine`); this
page is its ledger: what was measured, what was tried, and what came of it.

## How it is measured

- **Benchmarks** (`arguments/bench/Engine.lean`, run by `scripts/bench.sh`):
  copies of real proofs and checks, each timed with the kernel's work included,
  with its peak memory above what its process held before. Each benchmark runs
  in a Lean process of its own.
- **Comparison** (`scripts/bench-ab.sh`, `scripts/bench-compare.py`): an
  ablation. The code with a change and without it are built side by side on one
  machine and run interleaved, and each benchmark is compared by the two-sided
  Mann-Whitney U test, as Google Benchmark's `compare.py` does it. A change
  counts when p < 0.05 and it is larger than the variance bound. Peak memory is
  compared by threshold. A calibration benchmark, which no change can move,
  shows whether the machine drifted during the run.
- **CI** runs the A/B on every pull request, against the base it merges into,
  and fails on a regression that the pull request does not accept, with its
  reason, in `arguments/bench/accepted.toml`.
- **Build and kernel replay** are measured by hand, as below, until they have a
  gate of their own.

## Baseline

Measured on 30 October 2026, at `main` after #171, on a 4-core, 16 GB cloud
container (the shape of CI's runner), three runs per benchmark, one run of each
check.

| Benchmark | Median | Peak memory |
|---|---:|---:|
| checks: AIF, every dispute | 73.6 s | 26 MiB |
| table: sola fide, first half, 72 cells | 16.7 s | 204 MiB |
| checks: postulates, every package | 7.3 s | 29 MiB |
| checks: refutations survive their postulates | 5.3 s | 28 MiB |
| checks: ontology | 4.2 s | 23 MiB |
| table: Septuagint, 36 cells | 3.5 s | 35 MiB |
| calibration: kernel list reduction | 297 ms | 58 MiB |
| assessment: Miller against the laws | 212 ms | 28 MiB |
| refute_with: Wegner rests on his inference | 130 ms | 2 MiB |
| cell: status reading defeats Wegner | 74 ms | 11 MiB |
| establish: Miller's case | 66 ms | 6 MiB |
| rating: fruit, not ground | 34 ms | 9 MiB |
| verdict: sola fide, only Paul's word unanswered | 29 ms | 6 MiB |
| rating: the laws' step, three standards | 28 ms | 5 MiB |
| verdict: Septuagint, grounded in stages | 17 ms | 4 MiB |

The first run of each benchmark is 10–40% slower than the rest: warm-up, not a
cache that would let later runs skip the work.

| Stage | Wall time | Peak memory |
|---|---:|---:|
| Library, `lake build` (Mathlib cached) | 25 s | 2.2 GiB |
| Arguments, `lake build` | 490 s | 5.6 GiB |
| Arguments, kernel replay, 4 threads (the old default) | killed | ≥ 13 GiB |
| Arguments, kernel replay, 2 threads | 293 s | 8.9 GiB |
| Arguments, kernel replay, 1 thread | 500 s | ≈ 5.2 GiB |

The slowest modules of the arguments' build: `SolaFide.Ratings` (150 s),
`Checks` (101 s, most of it the AIF check), `SolaFide.Dispute` (81 s),
`Meanings.SolaFide` (74 s) and `CanonicalWitness.Results` (46 s).

## Rounds

| # | Hypothesis | Aimed at | Before | After | p | Verdict |
|---|---|---|---:|---:|---:|---|
| 1 | Bound the kernel replay's concurrent environments to 2, and run `leanchecker` without `lake env` | replay memory | killed at ≥ 13 GiB | 8.9 GiB, 293 s | — | kept |
| 2 | Ask each question of satisfiability once (#177) | the AIF check | 67.4 s | 3.75 s | 0.008 | kept |
| 3 | The kernel checks certificates instead of searching (#183) | the defeat tables | 14.2 s, 185 MiB | 7.1 s, 92 MiB | 0.008 | kept |
| 4 | Certify assessments and consistency; in a hearing, weigh a step's rank only once it is attacked (#183) | the hearings and assessments | 3.08 s, 97 MiB | 0.48 s, 16 MiB | 0.008 | kept |
| 5 | Compare a citation by its key and locus, a key checked to name one entry | a hearing's rerated strengths | 2.54 s, 83 MiB | 0.86 s, 25 MiB | 0.008 | kept |
| 6 | Replay a refutation on bitmasks (#180) | the certified defeat tables | 7.21 s, 94 MiB | 5.99 s, 70 MiB | 0.008 | kept |
| 7 | Find exclusions through shared keys, not every pair | the sola fide joins | 45.4 s, 3.43 GiB | 10.6 s, 1.06 GiB | 0.008 | kept |
| 8 | Certify the support and part-of tables | sola fide's part-of table | 8.01 s, 131 MiB | 5.00 s, 102 MiB | 0.008 | kept |
| 9 | Check a named reading in the kernel, as a table, not by `simp` | `satisfied_by` and `leaves_open` | 1.11 s, 8 MiB | 45 ms, 4 MiB | 0.008 | kept |
| 10 | Convert each party's position to clauses once per table, not once per cell | the certified defeat tables | 1.61 s, 13 MiB | 0.99 s, 11 MiB | 0.008 | kept |
| 11 | Ask each question of the components of a position it touches | sola fide's defeat table | 5.95 s, 60 MiB | 5.38 s, 36 MiB | 0.008 | kept, for sola fide |

Round 11, measured on one side of a `scripts/bench-ab.sh` run against the
head of round 10, five interleaved rounds: each table benchmarked prepared and
pruned. A position falls into components that share no claim, found by
union-find over the claims each clause mentions; `prepare_parts` writes them out
and the kernel checks once for each party that they partition its clauses. Each
question is then asked of the components it touches, after one check that it
misses the rest; a question that touches them all is asked of the whole
position, since pruning would drop nothing and only add its checks. The proof
that the answers are the whole position's (`Horn.askPruned_sound`) needs the
position to hold on its own, which every node of a dispute already proves, so a
cell's theorems are now stated over any oracle that answers truly
(`Horn.AskSound`); the prepared tables, asked through the old one, matched round
10's head (+0.3%, +4.6%, neither significant). Half of sola fide's table fell
from 5.95 s to 5.38 s (−9.5%, p = 0.008) and from 60 to 36 MiB; the Septuagint's
rose from 1.05 s to 1.26 s (+21%, p = 0.15, not significant) and fell from 12 to
4 MiB. So sola fide's table is asked by components, and the smaller tables,
whose questions touch most of each position, stay prepared. The machinery is
there for disputes that join arguments, where whole positions share nothing.

Round 10, measured on one side of a `scripts/bench-ab.sh` run against `main`,
five interleaved rounds, as rounds 3 and 8 were: each defeat table is
benchmarked certified, as before, and prepared. A certified cell converted both
parties' positions to clauses, so a party appearing in a row and a column of
cells was converted once for every cell. `prepare_clauses` converts each
party's position once, at elaboration time, writes the clauses out, and has the
kernel check, once for each party, that they are what the conversion gives;
every cell then reads them (`Horn.defeatsWith?`,
`Horn.defeats_iff_of_prepared`). The Septuagint's table fell from 1.61 s to
0.99 s (−39%, p = 0.008), and half of sola fide's from 7.14 s to 5.44 s (−24%,
p = 0.008); preparing sola fide's twelve parties costs 0.35 s, once. Every
benchmark shared with `main` matched it. An earlier run, before the hints were
searched from the clauses rather than the packages, measured −39% and −12%
(p = 0.016).

Before this, the round's real target was measured and set aside. Pruning each
question to the components of a position it touches, found by union-find over
the claims each clause mentions, asked the kernel about a third of the clauses
(6,671 of 19,800 in half of sola fide's table) but saved only 15% of the time.
Most of a question's cost is not in the clauses it reads but in how the kernel
reads them: a model check of Paul's 33 clauses took 7.6 ms, of which the
library's list functions, compiled through `brecOn`, and each claim's
constructor index, computed by a case split over the claim type's hundred-odd
constructors, are most. Written on `List.rec` and over indices, the same check
took about 3 ms, cold.

That did not carry over to the tables, and is recorded so that nobody tries it
again. The checker's model check, clause checks and replay were rewritten on
`List.rec`, each function proved equal to its core counterpart. A lookup written
that way, `List.rec` over `Nat.rec`, made each refutation's replay exponential
in the kernel, from 0.13 s to over 150 s as a synthetic position grew from 24 to
32 formulas; without it, against this round's head, five interleaved rounds,
neither table moved (the prepared ones −5%, p = 0.15, and +2%, p = 0.84) and
one certified cell was 21% slower (p = 0.032). Within a cell the kernel shares
the work the cold measurement repeated, so the list functions are not where a
table's time goes. The rewrite was dropped, and clauses over indices with it,
which the same measurement had suggested.

Round 9, `scripts/bench-ab.sh` against `main`, five interleaved rounds. A
profile of the slowest modules after round 6 put most of their elaboration in
`simp`, and most of that in `satisfied_by`: 46 s of `SolaFide.Dispute`'s,
serially, and 24 s of `SolaFide.Results`'. Its recipe unfolded the premise list
and rewrote the semantics of every formula in it, a second for one sola fide
case. But a reading is a table: each claim `True` or `False`. So the tactic now
reads the table off the definition, as a function to `Bool` with the proof, by
cases, that it agrees with the reading, and the kernel evaluates every premise
under it (`Testimony.Logic.ModelCheck`; `models_iff_holdsB` proves the
evaluation the semantics). A reading that is not a table falls back to the old
recipe; none in the arguments or the examples does. A first proof of
`models_iff_holdsB` used `tauto`, which put `Classical.choice` under every model
it checked, and the generated pages, which print each theorem's axioms, caught
it; the proof is now by cases, and the theorems rest on what they did,
`propext` and `Quot.sound`. The Pauline case's model
fell from 1.11 s to 45 ms (−96%, p = 0.008), a granted denial of Trent's from
1.05 s to 46 ms (−96%), and the parity reply's independence from 204 ms to
15 ms (−93%). Measured by hand, two runs each, the tactic otherwise unchanged:
`SolaFide.Dispute` elaborates in 35.8 s against 48.4 s, and `SolaFide.Results`
in 12.6 s against 18.6 s. `refute_with` is left as it is: the refutation check
counts on its recipe unfolding every definition through the argument's unfold
set, which is what tells a "not Horn" failure from a definition left folded,
and a kernel check would unfold them all whether tagged or not.

Round 8, measured on one side of a `scripts/bench-ab.sh` run against `main`,
five interleaved rounds, as round 3 was: each of sola fide's two tables of how
parties stand together is benchmarked searched, as before, and certified. Both
were still decided by a search the kernel ran, `supports?` and `partOf?`, and
the part-of table converted a party's premises to clauses afresh for every
premise it asked about. Now each question takes a hint, as a defeat cell's
does (`supportsBy?`, `partOfBy?`), `horn_certify` finds them, and each party's
premises are converted once a cell. The part-of table fell from 8.01 s to
5.00 s (−38%, p = 0.008) and from 131 to 102 MiB; the support table from
3.37 s to 1.99 s (−41%, p = 0.008), 17 to 13 MiB. The searched forms, now the
same decisions with no hints, matched `main` (p ≥ 0.55). Measured by hand,
two runs each: `SolaFide.Dispute` elaborates in 41.5 s against 47.6 s with its
two tables searched.

Round 7, `scripts/bench-ab.sh` against `main`, five interleaved rounds. A
profile of `Meanings.SolaFide` put 51 of its 64 seconds in one proof: that the
pinned exclusions are what the meanings contain, which the kernel checked by
testing every one of the 6105 pairs of the argument's 111 claims for a clash.
Two first guesses were wrong, and are recorded so that nobody tries them again:
that the kernel closed each meaning again for every pair (a table of closed
meanings, and one of their coherence, each checked once, changed nothing,
44 s), and that the closing was the cost (it is 0.4 s for every claim). The
cost was the clash check itself, comparing whole facts and terms a field at a
time, some 400,000 comparisons. Two coherent meanings can clash only where they
share a key, a fact or a thing their relations are about
(`Ontology.shares_of_clash`), so the claims are now taken from the last to the
first against an index of the later claims' keys, and each is checked only
against those it shares a key with; `HasMeanings.exclusionsUnder_eq` proves the
list the same, pair for pair and in order. The first version walked the claims
themselves and closed each later claim's meaning again for every claim before
it. The kernel shares those repeated terms, so its build was not slowed, but
the ontology check runs the same function compiled, once for every
definition, and there each closing was paid again: CI's gate found that check
5% slower (p = 0.008). So each meaning is now closed once, before the walk
(`HasMeanings.shapedUnder`). The exclusions fell from 45.4 s to 10.6 s (−77%,
p = 0.008) and from 3.43 to 1.06 GiB, and the ontology check from 3.16 s to
1.69 s (−47%, p = 0.008). The entailments were tried
the same way, indexed by each claim's first literal, and gained only 9.7 s to
8.3 s: their check already stops at the first missing literal, so the pairs
themselves are the cost, and the index does not remove them. They are left as
they are. Measured by hand on the first version, clean, on the same machine: the arguments'
`lake build` fell from 225 s to 204 s and its peak from 13.8 to 10.9 GiB, and
the kernel replay's peak from 9.3 to 6.9 GiB, at 226 s: the exclusions proof
was the largest single holder of memory in either.

Round 6, `scripts/bench-ab.sh` against `main`, five interleaved rounds. A
certified refutation was replayed over lists of settled atoms, each membership
a scan of comparisons: of the 75 ms one of Paul's refutations of Trent took,
53 ms were the replay. Replayed on two bitmasks over the atoms' constructor
index, which the kernel tests and sets in a step each, it took 33 ms in a
prototype. The replay is sound only through an index that tells atoms apart
(`Horn.replay_sound`), so the certified theorems ask for one and
`horn_certify` proves it from the enumeration's own inverse; the searched
decisions need none. Half of sola fide's certified table fell from 7.21 s to
5.99 s (−17%, p = 0.008) and from 94 to 70 MiB. The sola fide verdict also
read faster (−30%, p = 0.032), though it replays nothing: likely the noise of
a benchmark under 60 ms. Nothing was worse.

Round 5, `scripts/bench-ab.sh` against `main`, five interleaved rounds. What a
hearing still paid for re-rating after round 4 was its strengths: re-rating
matched a step's citation by comparing two whole `Source`s, entries and all,
350 ms a citation. A key can stand for its entry only if no two entries share a
key, and that was true but unchecked, so it is now a check
(`#check_citations`): every entry is a `@[bib_entry]` definition, and no two
share a key, in the library, the arguments and the examples alike. With it,
`Source.sameCitation` compares a work's key and locus, and
`Source.sameCitation_iff` proves it agrees with equality wherever the entries
are drawn from such a list. The James hearing's twelve rerated strengths fell
from 2.54 s to 0.86 s (−66%, p = 0.008) and from 83 to 25 MiB; the certified
Septuagint table moved too (−15%, p = 0.032); nothing was worse. Measured by
hand, clean: `SolaFide.Ratings` 31 s, and the arguments' `lake build` 230 s.

Round 4, `scripts/bench-ab.sh` against `main`, five interleaved rounds. A
profile of `SolaFide.Ratings`, the slowest module at 110 s, found its rerated
hearing cells at 460 ms each against 53 ms for the same cells unrated: to weigh
whether a premise outranks its attacker, a cell read the target's inference
rank, and in a hearing that re-rates each cited inference, comparing whole
`Source`s, bibliography entries and all, in the kernel. One such comparison
took 350 ms; the ratings themselves, 7 ms. So for a step whose question has a
certificate the attack is now asked first, and the rank only if it lands
(`Horn.rankFirst`); a cited premise's rank, a lookup, and any searched question
keep the old order, which a first attempt that reordered everything showed is
the cheaper there (+12% on the searched sola fide table, p = 0.008, reverted).
A certified row of the James hearing fell from 3.08 s to 0.48 s (−85%,
p = 0.008) and from 97 to 16 MiB; every other benchmark matched `main`. The
assessments are certified too (`Dissent.findingsBy?`): Miller's, 288 ms
searched against 120 ms certified (p = 0.008). Verdicts needed nothing: they
already had the kernel check a witness the solver found. Ratings search
nothing: they read the assessments' findings. Measured by hand, clean, on the
same machine: `SolaFide.Ratings` fell from 110 s to 39 s, and the arguments'
`lake build` from 309 s after round 3 to 248 s. The kernel replay took 247 s
with a peak of 9.5 GiB, against 8.1 to 8.5 GiB in earlier runs: one run each,
and not yet explained.

Round 3, measured on one side of a `scripts/bench-ab.sh` run against `main`,
five interleaved rounds: each table is benchmarked twice, searched in the
kernel as before and certified, and the two are compared. A profile of one sola
fide cell found that converting a party's position to clauses took 17 ms a
question, and propagating to a fixed point, in the kernel, about 85 ms; atom
comparisons cost nothing that mattered. So the search now runs at elaboration,
and the kernel checks what it found: a model, against every clause once, or
the clauses that fired, replayed once (`Horn.clausesSatisfiableBy?`,
`Testimony.Logic.Certificate`). Each position is converted once per cell, and
the search is not specialized at each call, which had cost 50 ms a cell in
compilation. Half of sola fide's table fell from 14.2 s to 7.1 s (−50%,
p = 0.008) and its peak memory from 185 to 92 MiB; the Septuagint's from
3.25 s to 1.53 s (−53%, p = 0.008), 32 to 16 MiB; one cell from 101 to 61 ms
(p = 0.016). Every searched benchmark matched `main` (every p ≥ 0.06), and the
calibration benchmark showed no drift. Measured by hand on the same machine,
clean: the arguments' `lake build` fell from 363.5 s to 308.7 s (−15%),
`SolaFide.Dispute` from 70 s to 48 s; the build's peak, about 13.8 GiB summed
over its parallel jobs, did not move, and the kernel replay took 261 s at
8.5 GiB against `main`'s 329 s at 8.1 GiB, one run each.

Round 2, `scripts/bench-ab.sh` against the commit before, five interleaved
rounds. `Horn.clausesSatisfiable?` propagated up to five times per question,
`Horn.stepRebuts?` and `Horn.defeats?` made their checks twice, and
`Aif.attacks` re-asked, for its preferences, what the attack checks had just
asked. Run by the interpreter, as the checks over every argument are, each copy
was evaluated: the AIF check fell from 67.4 s to 3.75 s (−94%, p = 0.008), the
postulates check by 20% (p = 0.008) and the refutations check by 24%
(p = 0.016). The kernel-decided benchmarks did not move (every p ≥ 0.17): the
kernel was already sharing the repeated terms. Peak memory did not move, and
the calibration benchmark showed no drift. One side of a benchmark run fell
from 146 s to 76 s.

Round 1 was measured by hand, before the benchmarks existed. `leanchecker`
replays each module as a task of its own, each importing that module's whole
environment, and Lean runs one task per core: four environments at once ran out
of memory. Two run in 293 s; one in 500 s with about 5.2 GiB.

## Fixed points

None yet. After round 7 the sola fide joins take 25 s of their module, of which
the entailments are 9 s; the next candidates are the support and part-of tables,
which still search in the kernel, and the models `satisfied_by` checks with
`simp`.
