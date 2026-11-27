---
name: standing-rules
description: Use at the start of any Testimony task that adds or changes an argument, a chapter, a docstring or a page, and again before opening a pull request — the project's standing disciplines in one list, each with what it requires, why, and which check enforces it or that only review does. Load it alongside the task's own skill; it is the checklist a reviewer will hold the work to.
---

# The standing rules

These are the disciplines the project has settled on, each learned from a page that went wrong.
CLAUDE.md states the hard rules that a command enforces. This list adds the ones a reviewer
enforces, and says for each where the check is, if there is one. Read it once per task; use the
checklist at the end before the pull request.

## Sources

1. **Nothing is made up.** Every bibliographic field is verified against a public catalogue or
   is `none`; every quotation is checked against a public text, with edition and page. Delegate
   to the `source-verifier` agent. *Enforced in part*: `#check_citations`, `#check_verse_parts`
   (every part of a verse read from the Greek or Hebrew data at build time).
2. **Every reading past the text, and every step, names who draws it**, at a verified place, or
   is marked the library's own with `Reference.proposal` and a rationale saying what is assembled
   and why. Never mark proposed a step a cited author draws; never attach an irrelevant work to
   get past the check. *Enforced*: `#check_readers`.
3. **Every denial gives the denier's reason**, quoted with its place, in the sentence that
   reports it. Where no reader has been read who denies it, say so. *Review only.*
4. **Headcount is not evidence.** No rating moves, refuted included, because more people make
   the same argument. A rating moves only with a new, cited argument. *Review only.*
5. **Ratings follow one rule**: `disputed` when a cited reader grants the grounds and denies the
   conclusion. Audit with the `rating-auditor` agent before rating above `disputed`, and before
   any rating that moves a verdict. *Enforced in part*: `#check_readings` caps a claim at the
   reading of the text it rests on.

## The text

6. **Quote the NET, the LSB or the NRSV**, else the ESV, else the NIV, and name the translation.
   The KJV appears only where a cited source quotes it and reasons from it, marked as the KJV's;
   then the library answers from the Greek or Hebrew and context. Where a source's reading rests
   on a variant the KJV follows, or on Latin that departs from the Greek, that reliance is a
   cited step of its own. *Review only.*
7. **Textual criticism decides what a text says.** A claim inside a place where the copies
   differ names the reading it takes and which question it needs answered (what the copies say,
   what the author wrote, what a church receives), and is rated no higher than that reading.
   *Enforced*: `#check_readings`.
8. **Every Greek or Hebrew word has its English beside it**, from the glossary, each rendering
   cited. A new word goes into `Glossary.lean` first. *Enforced*: lint rule L13.

## Meanings and logic

9. **Every claim has a meaning**, written when the claim is, so the ontology grows with every
   argument (`encoding-meanings`). *Enforced in part*: `#check_meanings` requires an instance;
   `coverage_now` pins how many are analysed, and a fall is visible in review.
10. **Sameness of sense is argued, not assumed.** A line that sets two texts against each other
    and needs a word to keep its sense states that as a premise, and it counts as argued only
    when the primary citation's work argues both places. *Enforced*: `#check_fallacies`,
    `#check_conditions`.
11. **A doctrine's structure is kept as its holders state it.** If a position is an implication
    ("whoever believes is justified, with works or without"), encode the implication, not a
    Boolean filter over rows. A truth table sets out the rows; the rules are the texts' and the
    readers', each cited. *Review only.*
12. **Refutations are computed**, from named readings checked by the kernel, never cited as
    someone's say-so. A step's refutation is the countermodel that shows it. *Enforced*:
    `#check_refutations`, and the tactics (`refute_with` takes only a named reading).
13. **Rivals first, rivals fair.** A rival is written from its holders' words before anything is
    proved, and every reading of an ambiguous claim is answered (`encoding-a-dilemma`).
    *Enforced in part*: rule L5 requires a rival package.
14. **Report the verdict the solver computes**, whichever way it goes; never tune an encoding
    toward a verdict; a moved headline verdict is the first line of the pull request.
    *Review only.*

## History

15. **Tell exchanges in the order they happened**, each turn dated by the work it comes from,
    and show from Scripture and the earlier readers what was read before a controversy; state
    each side's ground truths in its own words (`historical-framing`). *Enforced in part*: dated
    turns must come in date order, and `citesOnlyBefore` proves a hearing's cut-off.

## The page

16. **Write for the lay reader, exact enough for the theologian.** Quote the passage before
    arguing about it; gloss every technical word where it is used; name who holds each view.
    *Review*, with the `reader-review` agent; `scripts/prose_tells.py` counts the habits of
    generated prose.
17. **No Lean code on a reader's page.** Every declaration renders in words; theorem statements
    are set as logic beside English. *Enforced*: the harvest fails on a declaration with no
    rendering in words.
18. **Say what a result is.** Its limit goes inside the sentence that states it. No "what this
    does not show" sentences or sections. *Review only*; `prose_tells.py` counts them.
19. **No history of the library on a page.** State the argument as it now is, in the present
    tense; never "used to", "was rated", "now". History goes in commit messages and pull request
    descriptions. *Review only.*
20. **Capitalise pronouns for God** (He, His, Him) in the library's own prose. Quotations keep
    their source's capitals. *Review only.*
21. **No contributor's name in a skill or a reader's page** except as the author of a cited work
    or in the credits the build generates. Skills must read as usable by anyone. *Review only.*

## Process

22. **Every change has its documentation in the same commit**: a regenerated page, and any
    paragraph that describes a changed result, rewritten. *Enforced in part*: lint rule L9 fails
    on a name that no longer exists.
23. **One concern per pull request, opened as a draft**, its description saying what it claims
    and which gates ran. Follow-up work is filed as an issue written so that someone else can
    take it over.
24. **Read the generated page before the pull request**, not only the docstring.

## Before the pull request

- [ ] Sources verified; readers or proposals on every reading and step; denials quoted.
- [ ] Ratings by the rule, audited where they matter; no headcount anywhere.
- [ ] Translations as above; readings at variants named; every Greek and Hebrew word glossed.
- [ ] Every new claim has a meaning; coverage did not fall without a stated reason.
- [ ] Rivals in their holders' words; every reading answered; verdicts as computed.
- [ ] Chronology checked; ground truths stated.
- [ ] Page read: no code, no "does not show", no history, God's pronouns capitalised.
- [ ] The gates run (`checking-the-build`), the page regenerated, follow-ups filed.
