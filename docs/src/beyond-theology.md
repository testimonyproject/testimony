# Beyond theology: a case of your own

The library's arguments are about Scripture, but its machinery is not. A premise
is a claim with a citation and a rating. A position is a package of premises
with a conclusion. A dispute between positions is weighed by what each denies
of the others, and by their cited ratings. None of that knows what a covenant
is. A cross-examination, a policy debate, a review of a paper or a quarrel
between historians can be stated the same way, and checked the same way.

This page shows how, with the first such case: the grits cross-examination from
*My Cousin Vinny* (1992). The case is not in the library. It lives in
`examples/`, in a package of its own, `TestimonyExamples`, which uses the
library as any package built on it would. Its document is generated from its
own source and is not listed among the library's arguments.

## Why a separate package

The library is the machinery for stating and checking arguments, and the
packages built on it are its users. Keeping them apart keeps two promises.

- **A case cannot bend the library.** A package that imports the library can add
  cases, works and checks of its own, and cannot change what a `Defeats` or a
  `Verdict` means. If a case needs something the library lacks — a word in the
  vocabulary, a kind of bibliography entry — the library gains it as a general
  feature, with its own documentation, and every user gets it.
- **The library's documentation is about the library.** The arguments it
  publishes are its own. A package's document is the package's: it is set the
  same way, by the same generator, but it is not in the library's index.

The arguments this documentation presents are such a package too:
`TestimonyArguments`, in `arguments/`. Everything below is what they do, and
the grits case does the same at a smaller scale.

## The steps

### 1. A package that requires the library

```toml
# examples/lakefile.toml
name = "TestimonyExamples"
defaultTargets = ["TestimonyExamples"]
# Inside this repository: share the library's downloaded dependencies.
packagesDir = "../.lake/packages"

[[require]]
name = "testimony"
path = ".."
```

A package outside this repository requires the library by `git` instead, and
fetches Mathlib's build with `lake exe cache get`.

### 2. Claims, each cited to a record

Every atom of the case is a constructor of a `Claim` type, and `cite` gives each
one a label, a kind and a `Source`. For a trial the record is the source, and
the tradition is `.adversarialTrial`: the parties are a witness and counsel, not
schools of reading. The works the case cites go in the package's own
`Works.lean`, tagged `@[bib_entry]` and verified as the library's are. The
library's bibliography has entry types for films and court opinions.

The grits case cites the scene as the D.C. Circuit set it out, question by
question, in *Novato Healthcare Center v. NLRB* (2019), with the film beside it.
Each rating is argued in a comment or a docstring: the five-minute breakfast is
`disputed`, because counsel contests it, the witness withdraws it and the court
rejects it; regular grits taking twenty minutes is `wellSupported`, because the
record holds nothing for it but counsel's word, and nothing against it.

### 3. Two positions at least, written before anything is proved

The library will not let a reading stand alone (linter rule L5), and a case is
no different. The grits case has two: Tipton's testimony on direct examination,
and counsel's case on cross-examination, which keeps Tipton's own reckoning —
the time in the store is the time breakfast took — and contests only what
breakfast took. Each is shown to hold (`establish`) and to be coherent
(`satisfied_by`, with a named reading), and the place the testimony rests is
shown by taking it away: `the_five_minutes_rests_on_the_breakfast`.

### 4. What the claims mean

The library's vocabulary reads a claim as a relation between terms. A case is
about particular things and occurrences, not kinds, so a term can be a
**particular**, named and given its upper category: the time in the store is a
process, the making of breakfast an event. "Five minutes passed" says the time
in the store *lasts* five minutes. "Breakfast took twenty" says its making lasts
twenty.

The library's shared ontology then does the work. One of its definitions, that
an occurrence lasts one length of time, stated by both DOLCE and BFO, makes
five minutes and twenty exclude each other. The case does not state that
exclusion as a premise. It pins what the meanings yield (`HasJoins`), and the
build fails if the pinned list and the meanings disagree. So the headline
contradiction, `tiptons_five_minutes_cannot_stand_with_the_grits`, is in what
"lasts" means. Its companion, `apart_from_what_lasts_means_both_could_be_held`,
shows that without the meanings there is none.

### 5. A dispute, and its verdicts

The two positions become parties to a `Dispute`. Who defeats whom is computed
from their premises and ratings, and checked by the kernel. The verdicts —
`the_cross_examination_prevails`, `tiptons_testimony_cannot_be_defended` — are
`Verdict`s, each a claim with the solver's witness for it.

A rating is load-bearing, and the case shows it. Rated as the record stood when
Tipton answered "I'm a fast cook, I guess", the step from the grits is
`disputed`. The dispute is then a standoff (`at_the_fast_cook_nothing_was_decided`),
and the variant is one rating different, not a second list of premises. What
decided it was the witness's withdrawal: "I may have been mistaken."

### 6. The library's checks, over the package

Every check the library runs over its own arguments takes a namespace:

```lean
#check_meanings under TestimonyExamples
#check_ontology under TestimonyExamples
#check_postulates under TestimonyExamples
#check_refutations_postulates under TestimonyExamples
#check_refutations under TestimonyExamples using unfoldSets
#check_aif under TestimonyExamples
```

Each report is pinned with `#guard_msgs`, so a change in any of them is a
change a reviewer sees. The gates are the library's too: `lake lint`,
`lake exe axiom-audit`, and `scripts/kernel-replay.sh`, given the package's root.
The domain linter reads the package whenever it reads the library.

### 7. A document of its own

The library's harvest renders any namespace's docstrings, packages, lines and
verdicts. A package harvests only its own, and sets it as the library sets its
arguments:

```lean
derive_argument_bodies bodies under TestimonyExamples
```

`latexDocument` sets a title, a standing note and the harvested sections, and
`writeOrCheck` writes the files or checks that they are current. In the
examples, `lake exe exampletex` writes one document per case, and
`lake exe exampletex --check` fails if a committed one is stale.

## What the library does not give a package

- **Words.** The vocabulary's concepts and relations, the traditions and the
  kinds of premise are the library's, and a package cannot add to them. The
  grits case needed lengths of time, particulars, *lasts*, *starts with*, *ends
  with* and *part of*, the adversarial trial as a tradition, and empirical
  claims as a kind. Each was added to the library as a general feature, with
  its alignment to DOLCE and BFO stated (see [Standards](./standards.md)), so
  the next case has them.
- **Ratings that mean something else.** The four ratings are the library's, and
  so is the rule for them: a step is `disputed` when a cited source grants its
  grounds and denies its conclusion. In a trial the cited sources are the
  record, and the rule reads the same.
