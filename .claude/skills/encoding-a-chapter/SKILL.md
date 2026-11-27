---
name: encoding-a-chapter
description: Use when adding a chapter to a Testimony argument — a new era of a doctrine's story, an exchange between named voices, a topic such as faith and charity or penance and indulgences — from the request to a draft pull request. Covers scoping the chapter, the numbered claims read back for a yes before any Lean, verifying every quotation, encoding the claims with meanings, the dispute, its hearings and its bundle, placing it in the story, reading the page, and filing what is left as issues.
---

# Encoding a chapter, from request to draft pull request

A chapter is the unit most work in this library arrives in: one question a reader asks, answered
from the voices who answered it, in the order they spoke. This skill is the whole route. Each
step names the skill that holds its detail.

## 1 — Scope it to one question

Write the chapter's question in a reader's words ("Was faith alone read in Paul before Trent?",
"What did forgiveness leave unpaid, 203 to 1520?") and the argument it belongs to. A chapter that
wanders into a second doctrine is two chapters. When the request is broad, propose the narrowest
chapter that answers it and list what is left out; the rest becomes issues.

Find where it sits in the story (`historical-framing`, "The order of the story") and which
existing chapters it must link to rather than repeat.

## 2 — Write the claims as numbered sentences, and verify them

Before any Lean, write a plan: a Claude Doc when one is available, else a markdown file under the
project's shared folder. It holds:

1. the chapter's question and its answer as the chapter will state it;
2. the passages, quoted in English from a preferred translation (`reading-the-original`);
3. every claim, numbered, as a sentence a reader could quote, each with its source at a verified
   place (work, edition, page or section) and its proposed rating with the reason;
4. every step, with who draws it, or marked as the library's proposal;
5. the rival positions, in their holders' quoted words;
6. the hearings proposed (who is heard, any cut-off year) and the verdicts expected, marked as
   expectations the solver will decide.

Send every quotation and every identifier to the `source-verifier` agent and every rating above
`disputed` to the `rating-auditor`. Record in the plan what could not be verified, and leave
those fields out of the encoding.

## 3 — Read the claims back, and wait for a yes

This is the one step that blocks. A wrong claim is the failure no gate catches, so the person who
asked for the chapter confirms the numbered claims before they are encoded. Ask once, with the
plan attached and a short list of the choices that change the chapter (include or leave out a
voice, a narrower scope). While waiting, prepare what does not depend on the answer: bibliography
entries, glossary words, the vocabulary the meanings will need.

## 4 — Encode

In one module of the argument's directory, named for the chapter, in this order:

1. **Atoms**, one per numbered claim, each with its docstring (in `Atoms.lean`, or in the chapter's
   own module when its claims belong to no other).
2. **Citations**, in the argument's `Sources.lean` or the chapter's, every one verified.
3. **Meanings**, for every new atom, in `Meanings/<Argument>.lean`, growing the vocabulary or
   writing an article where a join needs one (`encoding-meanings`). Re-pin coverage and joins.
4. **Lines and positions**, complete: grounds, step, `inference` or proposal, conditions stated
   (`encoding-an-argument`, "What a complete line of reason has").
5. **The dispute**, its table computed, its verdicts with witnesses, a `Because` for every defeat
   the prose leans on, a dilemma for an ambiguous rival claim (`encoding-a-dispute`,
   `encoding-a-dilemma`).
6. **Hearings** for the chapter's narrower questions, and a cut-off proved with
   `citesOnlyBefore` where the chapter asks what could be said by a year.
7. **The bundle**, its turns dated by their works and told in order (`historical-framing`).
8. **The module docstring**, written last and read first: the story of the chapter, told
   (`prose-voice`, `literate-style`, `writing-for-readers`).

Then wire it in: import it in the argument's root module, add its checks to
`Checks/<Argument>.lean` and re-pin what they report, and add the page to the catalogue if it is
a page of its own. Link it from the chapters before and after it, and from the argument's
introduction where the story is summarised.

## 5 — Check, and read the page

Use `scripts/quick-check.sh` on the changed files while working (`fast-lean-loop`), then run the
gates in full (`checking-the-build`) and `scripts/generate-docs.sh`. Read the generated page as
a lay reader would, then send it to the `reader-review` agent, and fix what either finds in the
docstrings. Hold the page to every item of `standing-rules`.

## 6 — Open the draft pull request, and file what is left

The pull request's first lines state the verdicts the chapter adds, and any existing verdict that
moved. Then what the chapter claims, the sources checked, what could not be verified, and the
gates run, under the repository's template headings.

File every piece of work left over as an issue someone else could pick up: pages still to
procure, dates unverified, a rating not yet audited, a claim left opaque for want of a word, a
neighbouring chapter the scope left out. Each issue says what to do, where, and what is already
known, so it can be taken over without the conversation that produced it.

## Checklist

- [ ] One question, placed in the story, linked to its neighbours.
- [ ] Numbered claims, verified, read back, and confirmed before any Lean.
- [ ] Every claim with a meaning; coverage did not fall without a stated reason.
- [ ] Complete lines; dispute computed; verdicts with witnesses; a `Because` for each defeat used.
- [ ] Hearings and dated bundle; cut-offs proved.
- [ ] Gates, generated page read, `reader-review` run.
- [ ] Draft pull request with verdicts first; follow-ups filed as issues.
