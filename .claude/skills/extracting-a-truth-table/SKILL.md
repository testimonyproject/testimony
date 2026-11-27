---
name: extracting-a-truth-table
description: Use whenever a Testimony argument, line of reason, dilemma or satisfiability claim turns on a few propositions whose combinations a reader needs to see — "with works or without", "if and only if", "can both hold", "whatever else is true" — to extract it as a truth table: list the terms, write each logical construction of the claim (its holders', its rivals', its equivalents), set the texts as cited tests, check every row by the kernel, and write prose that names the rows. Use it often; a table is the quickest way for a lay reader to see what a proposition says.
---

# Extracting a truth table

A proposition about faith, works and justification is hard to hold in the head. A table of every
way its terms could stand, with each text marking the rows it allows, can be read with a finger
running down a column. The library has the machinery (`Testimony/Logic/TruthTable.lean`): a
`TruthTable` lists its claims, its tests (each a formula with a source) and what follows (each a
formula), and the page renders it in the site and the PDF with numbered rows. `faithTable` in
`arguments/TestimonyArguments/SolaFide/Reformation.lean` is the worked example: read it, and its
prose, before writing one.

Extract a table wherever a reader would otherwise have to work out combinations in their head.
Signs that a claim wants one:

- it says "whether or not", "with or without", "whatever", "only if", "unless";
- two positions agree on the texts and part on what follows from them;
- a step's conclusion is said to hold in every case the texts allow;
- a satisfiability claim (`Satisfiable`, `Grants`, a named reading, a countermodel) would be
  clearer as "row 5 passes every test";
- a dilemma's readings differ in which combination of claims they rule out.

## 1 — List the terms

Choose the few propositions the claim is about, usually three to five, all about one subject (one
person, one text, one event). Four terms make sixteen rows, which a page can show; past five,
split the question into two tables. For each term write:

- the claim, as a sentence a reader could quote ("He believes");
- the column heading in words ("Believes");
- the letter the formulas use ("B").

Split a term when the texts treat it at two times or in two senses. Works are asked twice in
`faithTable`, at first and afterwards, because every example Scripture gives believes first and
acts after; one column would have to strike Abraham or leave James out. A term that the argument
already has as an atom should be that atom, so the table joins the argument's citations and
meanings; a table about one person may use a small type of its own (`OnePerson`), each
constructor documented.

## 2 — Write every construction of the claim

The same proposition can be stated several ways, and the ways are not always equivalent. Write
each one its holders and rivals use, as a formula over the terms:

- **the holders' own form.** If a position is an implication, keep it as one ("if he believes,
  with works or without them at first, he is justified": `B ∧ (W ∨ ¬W) → J`). Never flatten a
  position into a filter over rows; the rows are the reader's aid, the implication is the claim.
- **its equivalents**, where a reader will meet them (`B ∧ (W ∨ ¬W) → J` and
  `B → (J ∧ (W ∨ ¬W))`), so the table can show they agree column for column.
- **its converse and contrapositive**, where an argument slides between them ("if he does not
  believe, he is not justified" is a separate claim from "if he believes, he is justified").
- **the rival's form**, from the rival's own words: Trent's "faith is required but does not
  suffice" is `J → B` with `B → J` denied, a different column, not a different table.

Each construction is a column. Decide for each whether it is a **test** (what a text or reader
asserts, cited and rated) or a statement that **follows** (what the argument says the tests give,
needing no source because the table is its proof).

## 3 — Set the texts as tests

Each test has a label (①, ②, ③), its words, its formula and its `Source`: the passages, who reads
them so, the tradition and the rating, exactly as a premise is cited. A test no reader draws is a
`Reference.proposal` with its rationale. Rate it by the rule; a test a cited reader denies is
`disputed`, and the prose says who denies it and why.

## 4 — Let the kernel check every row

- `theorem … : t.Checked := by decide +kernel`: every formula is about the table's own terms, and
  every statement that follows is true in every allowed row.
- `TruthTable.entails_of_checked`: so the tests entail what follows, in the library's own sense.
- `t.allowedRow k = true` for a named row, with `satisfiable_of_allowedRow`: so the tests can all
  hold together, and the entailment is not the empty one a contradiction would give. Name the
  theorem for who the row is (`abraham_rahab_and_the_thief_are_allowed`).
- `t.firstTests n` to say which test strikes a row: a row allowed on the first two tests and
  struck in the whole table is struck by the third (`dead_faith_is_struck_by_james_alone`).

Each fact the prose states about a row is a theorem like these, so the prose cannot drift from the
table.

## 5 — Write the prose that reads the table

After the table, in the docstring of a module section (`/-! … -/`), read it the way a teacher
would:

1. **Read down the columns.** Which rows each test strikes, by number: "Rows 2, 4, 6 and 8 break
   ①: he believes and is not justified."
2. **Say what is left**, by number, and that each statement that follows is true in all of them.
3. **Name the rows**: who in Scripture or history each allowed row is, quoted. "Row 5 is Abraham,
   Rahab and the thief on the cross", with the verses.
4. **Name the struck rows a reader will ask about**, and why they are struck: "rows 3 and 7 are
   the faith James calls dead".
5. **Read it as the rival does**: which test the rival denies, quoted with its reason, and which
   rows that would let back in. If the rival's tests make a different table, give it its own.
6. **Say where the two part** in one sentence, in terms of a term or a test ("the two readings
   part at what 'justify' means").

Keep the claims in the prose to what the table and its theorems show. A row named in the prose
should have a theorem behind it.

## 6 — Extracting from what is already encoded

Tables can be drawn from existing work, and should be:

- **from a line of reason**: its grounds and step become tests; what it delivers, and the rival's
  denial of it, become columns;
- **from a named reading or countermodel**: it is one row; the table shows the rows around it;
- **from a dilemma**: each reading is a construction; the table shows which rows each reading rules
  out, beside the horns;
- **from a `Because`**: the crux and the core of the rival are columns; the rows where the core
  holds are struck by the crux.

When the terms are claims of an argument, give each term its meaning first (`encoding-meanings`),
so the table's columns are the claims the rest of the library reads.

## Checklist

- [ ] Three to five terms about one subject, each a sentence, a heading and a letter.
- [ ] Every construction its holders and rivals use, kept in their form; equivalents shown.
- [ ] Tests cited and rated; proposals marked; what follows needs no source.
- [ ] `Checked` by `decide +kernel`; an allowed row named and proved; strikes attributed with
      `firstTests`.
- [ ] Prose reads the table by row number, names the rows, gives the rival's reading, and states
      only what a theorem shows.
