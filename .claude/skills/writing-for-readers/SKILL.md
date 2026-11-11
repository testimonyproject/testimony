---
name: writing-for-readers
description: Use when writing or revising any prose a visitor to the Testimony site will read — a module or declaration docstring under arguments/TestimonyArguments/ or examples/, a hand-written page under docs/src/, the README — or when asked to make a page more readable, fix its tone, or review it for a lay reader. Covers who the two readers are, the rules the prose is held to, how to revise a docstring without changing what it claims, and how to check the generated page.
---

# Writing for readers

The project is two things:

1. a guide for lay people reading an English Bible, in language precise enough
   that a theologian can work with it;
2. a code library for encoding arguments and checking them for consistency.

The first says who you are writing for. The second says what you may claim.
The full standard, with a worked example, is
[docs/src/writing-for-readers.md](../../../docs/src/writing-for-readers.md).
Read it once per session before revising prose. This skill is the working
procedure.

## The two readers

- **A Bible-study leader.** Knows the passages, has heard of the Reformation
  debates. No Greek, no Hebrew, no logic. Stops at the first sentence they
  cannot parse.
- **A theologian.** Reads Greek, knows the literature, and is looking for where
  the page misstates their tradition.

The first sets the vocabulary. The second sets the accuracy.

## Rules

1. Quote the passage in English before arguing about it.
2. English first, the original term in brackets, once per section:
   "works of the law" (ἔργα νόμου).
3. Gloss every technical word where it is used, theological ("forensic": a
   verdict, as in a court) and logical ("forced": accepted however the open
   disagreements are settled).
4. Name who holds a view. Never "some scholars".
5. A result's docstring says what it claims, then what it does not.
6. State the point in words; put the identifier in brackets afterwards.
7. Report the verdict the machine gave. A tie is a tie.
8. Describe a rival in words its holders would accept, with their own source.
9. Plain sentences of varied length, joined where the logic joins them. How
   the prose should sound is the `prose-voice` skill; the editing pass for
   generated-sounding habits is `removing-ai-tells`.

Avoid: contrasts built for effect ("not X but Y" where "Y" would do),
sentences that announce importance, code shorthand left unglossed
("load-bearing", "hinge", "standoff"), stacked hedges, and explaining how a
result is proved to someone who came for what it shows.

## Revising a docstring

A docstring is a claim as well as prose. Revising it must not change what it
says is true.

1. **Read the declaration first.** Know exactly what the theorem states or the
   premise asserts. The prose may say less than the statement, never more.
2. **List the facts the old docstring states**: texts, readers, ratings,
   results named. Every one survives the rewrite or is removed on purpose.
3. **Rewrite from the passage outward**: the verse, what each side takes it to
   mean, who they are, what the result shows, what it does not show.
4. **Keep every quotation exactly as it stands.** Quotations were verified
   against a source. Do not smooth, shorten or re-translate them. A new
   quotation needs the `source-verifier` agent first.
5. **Keep every name in backticks spelled as declared.** Linter rule L9 fails
   on a name that does not exist.
6. **Do not add a claim to make a paragraph read better.** If the sentence
   wants a fact the encoding does not have, leave the sentence out.

## Check the page, not the docstring

```sh
cd arguments
lake build                 # docstrings are compiled in
lake exe argdoc            # regenerate docs/src/arguments/
lake exe argtex            # and the LaTeX
lake exe statusgen         # the roadmap's table quotes each first sentence
cd .. && python3 scripts/testimony_lint.py
```

Before regenerating, run the editing pass in `removing-ai-tells`
(`python3 scripts/prose_tells.py --lean <module>` counts what it looks for).
Then read the generated page in `docs/src/arguments/` top to bottom as the
first reader would. Run the `reader-review` agent on the sections you changed.
It reports what it could not follow, mapped to the docstring that produced it.

Every hand-written page that describes a result you touched moves in the same
commit: `docs/src/roadmap.md` (outside its generated block), `README.md`,
`docs/src/introduction.md`, `docs/src/logic.md`.

## Scope

Strictly: docstrings under `arguments/TestimonyArguments/` and `examples/`, and
the pages a visitor reads first (introduction, rationale, scope and limits, the
roadmap's findings). Less strictly: contributor pages and docstrings in the
library's machinery under `Testimony/`. Those are for people who write Lean, and
should still be plain.

Much of the existing prose predates this standard. When you touch a docstring
for another reason, bring it up to the standard in the same change, and update
the list at the end of `docs/src/writing-for-readers.md`.
