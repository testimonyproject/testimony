---
name: historical-framing
description: Use when telling a Testimony argument as history or narrative — a chapter covering an era, an exchange between voices told as a bundle with dated turns, a hearing limited to what could be cited before a year, the development or accretion of a doctrine, or each side's ground truths set on the page — and whenever a page must show the order in which readings arose. Covers chronology, dating a turn by its work, cut-off hearings, fair framing of development and accretion, and the prose of a chapter that tells a story.
---

# Historical framing: telling an argument in the order it happened

The solver weighs every position at once, as if all its holders sat at one table. A reader does
not meet them that way. Paul wrote long before Trent and never answers it; the Reformers read
Paul against the schoolmen; Trent decreed on justification in 1547 and the Reformers answered
within the year; modern scholars come after all of them. A page that flattens that order hides
how the doctrine developed, which is often what the reader came to learn. So the library tells
an exchange in time order, and the build checks the order.

`docs/src/bundles.md` is the reference for bundles and dated turns. This skill is how to frame a
chapter so the history is told fairly and checked.

## 1 — The order of the story

Tell a doctrine's history in this order, and put each voice in its era:

1. **Scripture**: what the texts say, in their own words, quoted (the `WhatScriptureSays`
   chapter of sola fide is the model).
2. **The church before the controversy**: the fathers and medieval readers, to show from their
   own words whether a reading consistent with the later positions existed before the dispute.
   For sola fide this is "was faith alone read in Paul before Trent?" (`BeforeTrent`).
3. **The practices and teachings the controversy was about**, as they developed, with their
   dates: for sola fide, penance, satisfaction, purgatory and indulgences, about 203 to 1520.
4. **The controversy itself**: the Reformation's case, 1517 to 1546.
5. **The council's answer**: Trent, 1547, and its canons.
6. **The answer to the answer**: the Reformers on Trent, 1547 to 1647, and the confessions.
7. **Later replies**: Bellarmine and the later councils.
8. **Modern scholars**, last, read as the readers of all the above.

A chapter covers one era or one question within an era. Name it for what happened and when
("The Reformation's case, 1521–1546").

## 2 — Date every turn by its work

A bundle turn names the work it comes from: `turn Party.x meets Party.y from someWork`. The work
must be one the position cites (or the edition it is cited through), and its date is the year
the work was **composed** (`BibEntry.dated`), never the year of the translation quoted. Dated
turns must come in date order, and a turn may answer only a turn already told, so a reply cannot
come before what it replies to. If a work's date is not in its bibliography entry, find it
(`source-verifier`) and add it; an undated turn cannot be checked for order.

The relation words between turns (answers, meets, stands apart, responds, evades, restates,
concedes, shifts, ignores) are computed from the dispute, so the prose says what the solver
finds. If the bundle refuses a relation, change the prose, never the ratings.

## 3 — Hear only what could be cited then

To ask "what could be said in 1520?", hear a dispute whose parties cite only Scripture and works
dated before the year, and prove it: `D.citesOnlyBefore party year = true` for each party
(`heard_before_trent` in `SolaFide/BeforeTrent.lean`). Then state the verdicts of that hearing in
their own words ("heard before Trent, the fathers' faith alone and Augustine's renewal both stand"),
separately from the verdict once later voices are heard.

## 4 — State each side's ground truths

A position is intelligible only beside what its holders take as given. Every historical chapter
says, near its start and in the holders' words, what each side counts as a ground:

- Rome: Scripture, tradition and the teaching office of the church (the magisterium), with
  Trent's own wording (Session IV) where the chapter turns on it;
- the Reformers: Scripture alone as the final rule, read with the fathers, with a confession's
  own wording where it is cited;
- any other party (the Orthodox, a modern school) the same way.

The epistemology a side professes is encoded in `Epistemologies.lean`; cite it, and where a
chapter shows a side departing from its own rule, that is a result, checked there.

## 5 — Development and accretion are both positions

Where the history itself is in dispute, as when Chemnitz called a teaching an addition "first
revealed in Gregory's time" and Newman called such teachings developments, both readings are
parties: each cited, each quoted, each rated, and the facts of the history shared by both and
rated on their own. The library does not decide between them by framing. The page tells the
facts once, dated, and then lets the two readings of those facts meet in a dispute whose verdict
is the solver's.

## 6 — The rules a history page keeps

- **Headcount is not evidence.** A reading is not strengthened because many held it, or weakened
  because few did. Ratings follow the rating rule only (`encoding-a-dispute`).
- **Every denial gives its reason**, quoted, with its place, in the sentence that reports it.
- **Each voice is quoted from a verified text**, with the edition named. A father or council read
  in translation names the translation, and where the argument turns on a word, the original is
  given with its English.
- **No history of the library.** The page tells the history of the doctrine, in the present
  tense for what the library shows. How the encoding changed belongs in commit messages.
- **Capitalise pronouns for God** (He, His) in the library's own prose; a quotation keeps its
  source's capitals.

## 7 — Write it as a story

A historical chapter is read as continuous prose: people acting in history, quotations doing the
arguing, each paragraph moving the story on. Load `prose-voice` for the sound and
`literate-style` for the order, and use a table (a dated list of councils, a truth table of the
doctrine's shape) where the reader needs to see the whole at once.

## Checklist

- [ ] The chapter sits in the story's order, named for what happened and when.
- [ ] Every turn names its work; every work has its composition date; the order builds.
- [ ] A hearing limited to a year proves `citesOnlyBefore` for each party, and its verdicts are
      stated apart.
- [ ] Each side's ground truths are stated in its own words.
- [ ] Disputed history is two cited positions over shared, dated facts.
- [ ] No headcount, every denial quoted with its reason, no history of the encoding.
