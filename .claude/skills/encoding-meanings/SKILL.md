---
name: encoding-meanings
description: Use whenever a claim is added to or changed in any Testimony argument, and when growing the shared vocabulary or writing an ontology article — giving each claim its meaning in Meanings/<Argument>.lean, adding the words it needs, writing a definition with its source and its examples, and pinning coverage and joins. Every new claim gets a meaning in the same pull request, so the ontology builds up argument by argument.
---

# Encoding meanings, and growing the ontology

A claim's label and docstring tell a reader what it says. Its **meaning** tells the machine, so
that the claim can be compared with every other claim in every argument. Meanings are what let
the library find two claims that exclude each other without anyone listing the pair, find every
claim about one Greek word, and run the fallacy checks at all: `#check_conditions` and the
equivocation checks can only read a line whose claims are analysed, and count the rest as
unread. A claim left `opaque` is a claim no check can see.

So the rule is: **every claim added or changed gets its meaning in the same pull request.** When
the vocabulary cannot say it, grow the vocabulary. When a join depends on what a word commits its
reader to, write the definition in an article. `opaque` is the last resort, and it is a debt
with an issue number, never a default. Each argument's pinned coverage (`coverage_now`) should
rise or hold with every pull request, and a pull request that lowers it says why in its
description.

`docs/src/semantics.md` is the design. This skill is the procedure.

## Where things are

| What | File |
|---|---|
| The grammar of a meaning (`Statement`, `Content`, `Term`, `Scope`) | `Testimony/Semantics/Grammar.lean` |
| The shared words (`Voice`, `Lexeme`, `Sense`, `Concept`, `Rel`, `Principle`) | `Testimony/Semantics/Vocabulary.lean` |
| What a meaning affirms and denies, and the definition forms (`Axiom`) | `Testimony/Semantics/Ontology.lean` |
| `HasMeanings`, `HasJoins`, `coverage`, `contested`, `about` | `Testimony/Semantics/Meaning.lean` |
| The articles, and the shared ontology | `Testimony/Ontology/`, `Testimony/Ontology/Shared.lean` |
| What kind of thing each concept is | `Testimony/Ontology/Kinds.lean` |
| One argument's meanings, coverage and joins | `arguments/TestimonyArguments/Meanings/<Argument>.lean` |
| The English for each Greek and Hebrew word | `arguments/TestimonyArguments/Glossary.lean` |

Read `Grammar.lean` and the head of `Vocabulary.lean` once; search the rest.

## 1 — Classify the claim before writing its meaning

The claim's `kind` in its citation already says most of it. Pick the `Statement` form that
matches what the claim asserts, and no more:

| The claim is | Write it as |
|---|---|
| what a passage says, in its own words | `.says passage content` |
| what a passage teaches, read rightly | `.teaches passage content` |
| what a word means at a place or in an author's usage | `.means lexeme scope sense` |
| that a word keeps its sense between two places | `.sameSense lexeme a b` |
| that one word bears the sense of a kindred one (verb by adjective, Greek by Latin) | `.bears w a v b` |
| what a voice held, wrote, glossed or rendered | `.heldBy`, `.wrote`, `.glosses`, `.renders` |
| doctrine, whoever holds it | `.holds content` |
| a principle of reading | `.principle h` |
| a fact of the Greek text (a word occurs, its voice) | `.occurs`, `.occursOnlyIn`, `.parses` |
| "were this so, that would be" (what an argument from silence needs) | `.expects s t` |
| several of these, or a denial | `.also`, `.denied` |

Three distinctions are never collapsed, because every dispute in the library turns on one of
them:

- **`says` is not `teaches`.** A textual claim is stated in the passage's words, with the words
  as `wd lexeme passage` terms. What a word denotes there is a separate `.means` claim. Write
  both texts of a dispute the same way: if Paul's connective is stated as a textual word, so is
  James's.
- **A word is not its meaning.** `wd .dikaioo rom3_28` is the word as it stands; the sense it
  has is a claim of its own.
- **What a voice held is not what is so.** "Trent taught that justification includes
  sanctification" is `.heldBy .trent …`, historical; "justification includes sanctification" is
  `.holds …`, doctrinal. A chapter that tells history uses the first.

## 2 — Use the vocabulary, or grow it by the one word you need

Search `Vocabulary.lean` for the word first: `grep -n "| " Testimony/Semantics/Vocabulary.lean`
lists every constructor. Reuse wins, because a reused word is what joins two arguments.

When a word is missing, add one constructor:

- **Add what the claim needs, named for what it denotes.** A `Sense` is named for what the word
  denotes ("a verdict"), a `Concept` for what doctrine is about ("justification"), a `Rel` for
  how one term stands to another ("the means by which"). The docstring says what it denotes, in a
  sentence a reader could check.
- **Do not duplicate.** If a sense and a concept would carry the same name, or a voice repeats a
  `Tradition`, say in the docstring how the two differ, or reuse the existing one. The known
  overlaps are listed in `docs/src/semantics.md` ("What the search found"); do not add to them.
- **A new `Lexeme` needs a glossary entry**, each rendering cited to the translation or lexicon
  that gives it (rule L13). Check the word against the Greek or Hebrew data before naming it (the
  `reading-the-original` skill).
- **A new `Concept` gets a category** in `Testimony/Ontology/Kinds.lean`, or a sentence there
  saying why its category is the dispute and so is left unassigned.
- **A new `Rel` is a library change.** Every pattern match over `Rel` must handle it; build the
  library before the arguments, and say in the pull request which claims needed it.

Adding a word changes no verdict by itself. It can change what the searches find: `contested`,
`about`, and the joins. Re-pin each argument's counts the build reports, and read what moved.

## 3 — Decide whether the join needs a definition

After writing the meaning, ask: does this claim exclude, or entail, a claim already in the
library? Two claims join only through what their words commit a reader to. If they join by their
form alone (a statement and its denial), nothing more is needed. If they join because of what a
relation word means ("only means", "whole ground", "lasts", "one voice"), that meaning is a
**definition**, and a definition lives in an article.

A definition is what a word means, which no reader disputes. What one tradition holds of a word
and another denies is a premise of a position: it is a claim, cited and rated, and stays out of
the ontology. When in doubt, it is a premise. A definition put into the ontology decides every
dispute it touches without appearing on any page, which is the failure the library exists to
prevent.

## 4 — Write the article

An article is a directory under `Testimony/Ontology/` with three files, like `Time`:

1. `<Article>.lean`, the reader's account: what the words mean, who says so, what follows, and
   what is left apart and why. It names no argument.
2. `<Article>/Definitions.lean`: each `Definition`, with `name`, `says` in words, its `form` (one
   of the `Axiom` forms), and its `source`, cited like a premise. Then the article's list,
   `definitions : Ontology`.
3. `<Article>/Examples.lean`: for each definition, a theorem that two statements of the article's
   own **exclude each other with the definition and not without it**, and a third that shows how
   far it reaches (two different occurrences, two different words). `Time/Examples.lean` is the
   model.

Then add the list to `Testimony.Ontology.shared` in `Testimony/Ontology/Shared.lean`, import the
article in `Testimony/Ontology.lean`, and list it in that module's docstring. If no `Axiom` form
says what the word means, a new form is an engine change: its own pull request, with
`yields` and the soundness lemmas in `Testimony/Semantics/Ontology.lean`.

## 5 — Pin what moved

The build fails until the pins agree with what the meanings now contain. Each one is a claim a
reviewer reads, so write the docstring as well as the number.

- **`coverage_now`** in the argument's meanings module: how many claims are analysed, of how many.
  Its docstring lists the unanalysed claims by group and names the word each group lacks.
- **`HasJoins`**: every exclusion and entailment, as pairs, each explained in the instance's
  docstring with the definition that makes it (or "the denial was in the meaning").
- **`postulates_eq`**: the joins written out as formulas. Proofs over the argument's packages
  unfold to it, so a named reading (a countermodel) must now satisfy every new postulate.
- **`#check_ontology`** in the argument's checks module: what each definition does, per argument.

A new join is a new background claim every party holds, so it can move a dispute. Run the
argument's dispute modules after it and report any verdict that moved, in the first line of the
pull request (`encoding-a-dispute`, "Report what the solver computes").

A countermodel that fails after a join is added is a finding, not a nuisance: the rival's
reading, as written, held two claims whose meanings exclude each other. Fix the reading so it
says what its holders say, and say what changed.

## 6 — When the vocabulary truly cannot say it yet

Some claims need more than a word: a command, a curse, a story's outcome, a rule about texts and
translations. Then:

1. write `.opaque "<the claim in brief>"`;
2. in `coverage_now`'s docstring, add the claim to the group that lacks the same thing, naming
   what is lacking ("a command", "a reward");
3. file an issue for that missing piece of the grammar, if none is open, listing every claim
   across the arguments that waits on it. Search the issues first: the same lack recurs.

An opaque claim may never be the hinge of a dispute or a dilemma. If it is, the meaning is the
work, and it is done before the dispute is declared.

## Checklist for one claim

- [ ] The meaning's form matches the claim's kind (says / teaches / means / held / holds).
- [ ] Every word is the vocabulary's; any new one has a docstring, a glossary entry (for Greek
      or Hebrew) and, for a concept, a category or the reason it has none.
- [ ] Any join it makes through a word's meaning rests on a definition in an article, with a
      source and examples; any join a tradition disputes is a premise instead.
- [ ] `coverage_now`, the joins and `postulates_eq` re-pinned, each docstring saying what moved.
- [ ] Disputes rebuilt; any moved verdict reported.
- [ ] If `opaque`: the lack named, and an issue listing every claim waiting on it.
