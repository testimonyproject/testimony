import TestimonyArguments.Checks.Articles
import TestimonyArguments.Checks.BornInBethlehem
import TestimonyArguments.Checks.BornOfAVirgin
import TestimonyArguments.Checks.CanonicalWitness
import TestimonyArguments.Checks.SolaFide
import TestimonyArguments.Checks.SolaGratia
import TestimonyArguments.Checks.SolaScriptura
import TestimonyArguments.Checks.SpiritBaptism
import TestimonyArguments.Checks.Trinity
import TestimonyArguments.Meanings
import TestimonyArguments.Articles.Howell2003
import Testimony.Checks.Citations
import Testimony.Checks.Covered
import Testimony.Checks.VerseParts

/-!
# TestimonyArguments.Checks — the library's checks, over every argument

The checks the library defines (`Testimony.Checks`), run over this package as
part of its build. Each report is pinned, so a change in any of them is a
change a reviewer sees:

- **meanings**: every argument's claims have meanings, and its postulates come
  from its pinned joins and nowhere else;
- **the shared ontology**: what each of the library's definitions does in each
  argument — where its words are held, and the joins it derives;
- **fallacies**: every line of reason, read through its argument's meanings,
  checked for equivocation, begging the question and arguing from silence, as
  an article's moves are; a line that equivocates on its own terms, or argues
  from silence alone, fails the build;
- **postulates**: no package is emptied by its meanings, and no refutation is
  undone by them;
- **refutations**: `establish` fails, as not Horn, on every package an argument
  refutes, with that argument's unfold set;
- **citations**: every bibliography entry, the library's and the arguments', is a
  `@[bib_entry]` definition, and no two share a key, so a citation's key names
  its entry;
- **AIF**: every dispute is a graph meeting the Argument Interchange Format's
  Definition 1.1;
- **parts of verses**: every part of a verse, the library's and the arguments',
  wherever it is built and however it was written, is read again from the Greek
  corpus, and the build fails on one whose words or anchor are not there.

Each argument's checks run in a module of their own, `Checks.<Argument>`, under
its namespace, and their reports are pinned there. Pinned here, every argument's
counts shared one block, so two pull requests on two different arguments
conflicted over it. What the one run over the whole package guaranteed, that an
argument added tomorrow is checked tomorrow, is kept by `#check_coverage`
below: the build fails if anything a check examines lies under no namespace the
check was run under. A new argument adds its `Checks.<Argument>` module and
imports it here.

The citations check reads every entry in the environment, so it runs here,
once, over everything. Its report counts every definition in the package, which
every pull request changes, so only its failures are pinned: it fails the build
on an entry built outside a `@[bib_entry]` definition, on two entries sharing a
key, and on finding nothing to check. The check of parts of verses runs here too,
over the library and over the package, because a part may be built in any module.
-/

namespace TestimonyArguments

#guard_msgs (drop info) in
#check_citations under Testimony

#guard_msgs (drop info) in
#check_citations under TestimonyArguments

/-- info: every part of a verse under Testimony is read from the Greek corpus: 1 -/
#guard_msgs in
#check_verse_parts under Testimony

/-- info: no part of a verse is built under TestimonyArguments -/
#guard_msgs in
#check_verse_parts under TestimonyArguments

/-- info: every check reaches everything under TestimonyArguments -/
#guard_msgs in
#check_coverage under TestimonyArguments

end TestimonyArguments
