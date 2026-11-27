---
name: encoding-a-dilemma
description: Use when a rival's claim in a Testimony argument can be read more than one way and the readings meet different objections — a definition read as about a word or about a reality, a text read as about a sense or about a doctrine, a council's canon read strictly or broadly — or when a reader asks "but what if they mean…?". Covers finding and citing every reading, proving each fair, answering each with a Because or showing nothing reaches it, and how the page sets the horns side by side.
---

# Encoding a dilemma

An argument that answers one reading of a rival's claim has answered a rival of its own choosing.
A `Dilemma R` (`Testimony/Logic/Dilemma.lean`) names one of `R`'s premises, the **claim**, and
every reading of it the literature gives, and the build refuses it until each reading is
answered. `docs/src/logic.md` ("Answer every reading of an ambiguous claim") has the API and
`whatTrentsDefinitionClaims` in `SolaFide/Definition.lean` is the worked example: Trent's
"sanctification and renewal of the inward man" read as what Paul's word δικαιόω ("justify")
means, and as what God does in justifying.

## When a dilemma is the right construction

Build one when the reader's question is "what if it means something else?" and the answer
changes the outcome. Signs that a claim needs one:

- a word in it is given two senses at one place (`HasMeanings.contested` lists these, from the
  meanings alone, so look there first);
- one side reads a text as a claim about the word and the other as a claim about the thing;
- a confession or canon is read strictly by some of its own heirs and broadly by others;
- the claim is the crux of a `Because`, and its holders would say the `Because` attacks a reading
  they do not hold.

A claim with one reading in the literature does not need a dilemma. A reading the library
invents is a strawman, and is not a horn.

## 1 — Find and cite each reading

Each reading is a `Reading`: a name, what the claim **commits** the rival to under it (a formula
over the argument's claims), any **grounds** the rival rests that reading on, and the **source**
of the reading: who reads the claim that way, at a verified place. The grounds are the rival's
own reasons for the reading, quoted: Trent's reading of Paul's word rests on Augustine's gloss,
"being justified" as "being made righteous", and that ground is checked too.

Give each reading a meaning before it is used (`encoding-meanings`): the two readings of an
ambiguous claim usually differ in exactly one `Statement` form, `.means` against `.holds`, and
writing the meanings shows whether the readings really differ.

## 2 — Prove each reading fair

`R.readAs claim r` is `R` with the reading's grounds and the step `claim ➝ commits` added, the
rival's own premises untouched. Prove it satisfiable with a named reading, written as its holders
would describe their world (`satisfied_by`, or a `Satisfiable` theorem). A horn that cannot be
satisfied is a reading that falls to itself, which no one holds.

## 3 — Answer each reading

Every horn carries at least one **fate**, against a named position `P`:

- **falls**: a `Because P (R.readAs claim r)`, built as `encoding-a-dispute` describes, naming
  the crux and the core of the reading that breaks on it;
- **not reached**: `P` establishes its conclusion, and `P`'s premises hold together with the
  reading. Say so plainly; it is often the most useful finding on the page, because it shows
  which objection does not touch which reading.

Try every position the argument has against every horn before choosing which fates to record.
A horn that falls against one position and is unreached by another needs both, because a reader
needs to know which objection does the work.

## 4 — No razor enters the solver

When a horn falls only by a principle of reading (the least meaning a context requires; one
occurrence does not carry a whole doctrine), the principle is a premise, cited (Joos, Silva,
Barr) and rated, never a preference built into the semantics. A principle built into the machine
decides cases without appearing on any page.

## 5 — Write it for the reader

The page sets the horns side by side. The dilemma's docstring states the claim in its holders'
words, then each reading with who holds it, then what each costs: "read as a claim about Paul's
word, it cannot be held against the lexical case, at a crux rated `disputed` because <a named
reader> grants its grounds and denies its conclusion, for <the reader's quoted reason>; read as a
claim about what God does, the lexical case does not reach it, and the Galatian case does". Say
"cannot be held", never "refuted", when the crux is `disputed`. A third reading is welcome: the
docstring says the dilemma is over the readings it names, each cited.

## Checklist

- [ ] The claim is the rival's own premise, and the rival is a complete line of reason.
- [ ] Every reading is cited to a reader at a verified place, with its grounds quoted.
- [ ] Every reading has a meaning, and the meanings show how the readings differ.
- [ ] Every horn is proved fair with a named reading in its holders' words.
- [ ] Every horn has a fate against every position that bears on it, falls or not reached.
- [ ] Any principle a horn turns on is a cited, rated premise.
- [ ] The docstring says what each reading costs, in the solver's words.
