# Standards the library aligns to

The library's machinery was built for its own arguments, but the problems it
solves are old ones, and other fields have standards for them. Where a standard
fits, the library aligns to it, so that a reader who knows the standard can read
the library, and so that its arguments can be read by tools built on it. This
page says which standards, how far, and what is left apart.

## Argument: the Argument Interchange Format

The Argument Interchange Format (AIF) is the argumentation community's common
ontology of argument (Chesñevar et al. 2006; the Dundee specification, 2011). An
argument is a graph of **information nodes** (I-nodes), which hold claims, and
**scheme nodes**, which hold the reasoning between them: an **RA-node** applies
an inference, a **CA-node** a conflict, a **PA-node** a preference. Claims meet
only through a scheme.

Every dispute in the library is drawn as an AIF graph (`Testimony.Logic.Aif`):

| In the library | In AIF |
|---|---|
| A claim: a premise, a conclusion, a claim a step delivers | I-node |
| An inference step `p ➝ ψ` | RA-node, from each conjunct of `p` to `ψ` |
| A defeat on a premise, a conclusion or a delivered claim | CA-node, to that claim's I-node |
| A defeat on a step itself (undermining `p ➝ ψ`) | CA-node, to the step's RA-node: an undercutter |
| An attack the weighing refuses, because the attacked outranks the attacker | PA-node, the attacked preferred |

`Testimony.Checks.Aif` draws every dispute under a namespace it is given and
checks it against the specification's Definition 1.1, condition by condition,
and its report of each graph's nodes is pinned. The arguments run it over every
dispute they have (`#check_aif under TestimonyArguments`), and the examples over
theirs.

One simplification, stated in the module: AIF wants a single conflicting
element, and an attack in the library comes from everything a party holds, so
the conflicting element is drawn as the attacking party's conclusion. Not yet
done: exporting the graphs in AIF's JSON, for AIFdb and the tools that read it.

## Attack and defeat: ASPIC+ and Dung

The library's attacks are the three of ASPIC+: a party **undermines** another by
denying one of its premises, **rebuts** it by denying its conclusion, and
**rebuts it on a step** by denying a claim it derives on the way. A defeat is an
attack that survives the preference, and the preference is **weakest link**: a
position is as strong as its least-supported premise or step, by cited rating.
Which positions survive is decided by Dung's semantics — grounded, preferred,
credulous and skeptical acceptance — by a solver whose every verdict carries a
checked witness. See [Reading the logic](./reading-the-logic.md).

## What kind of thing a word names: DOLCE and BFO

The vocabulary's terms are given categories from an upper ontology, so that a
claim relates things of the kinds its relation is about. The categories are
DOLCE's (ISO/IEC 21838-3; Borgo et al. 2022), built to follow the distinctions
natural language draws, which is how texts and their readers speak. Each names
its counterpart in Basic Formal Ontology (ISO/IEC 21838-2; Arp, Smith and Spear
2015) where BFO has one (`Testimony.Semantics.Upper`):

| Category | DOLCE | BFO |
|---|---|---|
| agent | agentive physical or social object | object, or object aggregate |
| physical object | non-agentive physical object | object |
| social object | non-agentive social object | none: nearest, a generically dependent continuant |
| information object | information object | generically dependent continuant |
| event | event | process, or process boundary |
| process | process | process |
| state | state | none: BFO speaks of qualities and dispositions |
| quality | quality | quality, or disposition |
| role | role | role |
| temporal region | temporal region | temporal region |

What kind of thing each of the vocabulary's concepts is, is argued in an article
(`Testimony.Ontology.Kinds`), not assumed. For some concepts the category is the
dispute: whether justification is an act or a process is what the Reformation
and Trent disagree about, and an upper ontology that assigned it would have
answered the question for them. Those concepts are left without a category, and
the article says why.

The relations a case about time needs are aligned the same way: *lasts* is
BFO's *occupies temporal region*, *starts with* and *ends with* are Allen's
interval relations, and *part of* is the part-of relation of both. One
definition follows from both ontologies and is written out, with its sources,
in an article: an occurrence lasts one length of time
(`Testimony.Ontology.Time`).

## Left apart

- **LKIF Core**, the legal ontology. Its categories — norms, legal roles, legal
  actions — are for reasoning about law. The library's first case outside
  theology is a cross-examination, which needs testimony, time and a record,
  not law, so the adversarial trial is a tradition and the court's opinion a
  bibliography entry, and nothing of LKIF is needed. A case that turned on what
  a statute requires would need it.
- **Inference Anchoring Theory**, AIF's extension for dialogue: who asserted,
  questioned or conceded what, and when. The grits case is a dialogue, and its
  verdict turns on a withdrawal, so this is the natural next alignment. It is
  not done; the case states each turn as a citation instead.
