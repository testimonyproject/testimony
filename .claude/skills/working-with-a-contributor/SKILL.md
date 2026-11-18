---
name: working-with-a-contributor
description: Use when the person in the session does not write Lean — a pastor, Bible-study leader, student or other lay contributor bringing an argument, a correction or a question in plain English — or says they are new to the project, to programming, or to logic. Covers how to take an argument from their notes to a draft pull request, what to show them and what to keep to yourself, the one confirmation that must block the work, and how to report a verdict they did not hope for.
---

# Working with a contributor who does not write Lean

Most people who can improve this project cannot read Lean, and should not have
to. They know the passages, the commentaries and the arguments people actually
make. You know the library. The session goes well when each does their own
part: they say what the argument is and whether you have it right; you do
everything else.

The human-facing version of this procedure is
[docs/src/getting-started.md](../../../docs/src/getting-started.md). Read it
once per session, because it is what the person may have read, and promises
made there are yours to keep.

## Find out who you are working with

If the person has not said, ask once, in one line, whether they write Lean or
would rather work in plain English. Do not ask again. Signs that they do not:
they describe the argument as prose, ask what a word on a page means, or say
they are new. When in doubt, follow this skill; a programmer loses nothing by
it.

## The procedure

### 1. Get the argument on one page

The guide asks the person to write five things before the session: the
conclusion in one sentence, the passages quoted, the steps, the step people
dispute, and who disagrees and where. If they pasted notes, hand them to the
`argument-intake` agent, which returns those five, the claims it would encode,
and what is missing. If they did not, ask for the five in one message.

Ask for everything missing at once, with what you will assume for each if they
do not know, and carry on with the rest. Never ask one question per turn.

If they quote the King James Version, or a translation the library does not
use, quote the verse instead from the one the argument uses (the NET, LSB or
NRSV, else the ESV or NIV; `docs/src/writing-for-readers.md`). When the claim
rests on a word, read the verse back to them in the new wording with the
claims, and ask whether it still says what they meant: a change of translation
can move a claim as surely as a change of words.

### 2. Read the claims back, and wait

Before writing any Lean, show the person the claims as a numbered list:

```
1. Romans 3:28 says a person is justified by faith apart from works of the law.
   Source: Romans 3:28. Rating: consensus (that the verse says this).
2. "Works of the law" (ἔργα νόμου) means works in general, not only the
   markers of Jewish identity.
   Source: Moo, The Epistle to the Romans (1996), on 3:28. Rating: disputed.
   ← the claim the rival denies
3. ...
Rival: James D. G. Dunn, who reads "works of the law" as the observances that
marked Israel out (The New Perspective on Paul, 2005).
```

(An illustration of the format. Both works are in
`arguments/TestimonyArguments/Works.lean`; a real read-back gives the page or
section the person cited.)

One sentence a claim, each with its source and rating, the disputed one marked,
the rival named with its source. Wait for a yes. This is the only step in the
procedure that should block the work, because a claim that is subtly wrong
here is wrong in everything proved from it, and no gate in the build can catch
it. Everything after it you can do and then report.

### 3. Do the mechanics yourself

Encode with `encoding-an-argument`; verify every source with `source-verifier`
and `adding-a-citation`; audit any rating above disputed with
`rating-auditor`; run the gates with `checking-the-build`; regenerate the pages;
have `reader-review` read them; open the draft pull request. None of this needs
the person. Tell them what you did in a sentence, not how.

If a source cannot be verified, leave the identifier `none` and tell them. If
they cannot give a source for a claim at all, it is their proposal: encode it
with `Reference.proposal`, give the rationale in their words, and tell them the
page will mark it. Never present a guess as a citation.

### 4. Report in their words

Say what the computer found using the vocabulary in the guide's table:
*follows*, *does not follow*, *independent*, *prevails*, *standoff*. Then say
which claim it turned on. Two misreadings to head off every time: "does not
follow" is not "false", and a standoff is not a defeat.

When the verdict is not the one they hoped for, say so plainly, first. Then say
what a new, cited premise would have to show to move it. Never reword a premise,
change a rating or drop a rival to move it; `CLAUDE.md` forbids it, and the
person is better served by knowing exactly where their argument stops.

### 5. Show the page, not the code

What they will check is the generated page under `docs/src/arguments/`. Point
them to it, or paste the section that changed. Show Lean only when they ask,
or when they must confirm a particular line, and then gloss every symbol as
[docs/src/hello-world.md](../../../docs/src/hello-world.md) does: `p .x` is
"x holds", `notP .x` is "x does not hold", `⋀ [A, B]` is "A and B together",
`➝` is "therefore".

## What to say, and what not to

| Instead of | Say |
|---|---|
| "I added an atom `worksOfLawGeneral` to the inductive" | "I added the claim that 'works of the law' means works in general" |
| "`establish` fails: not Horn" | "The step as written joins its claims with an 'or', which the checker cannot use; I've split it into two steps" |
| "The grounded extension is empty" | "Neither side prevails: each rests on a claim rated no better than the one it attacks" |
| "Linter L11 fails" | "The checker needs an example showing your premises can all be true together; I've added one" |
| "Rebased onto main and force-pushed" | nothing, unless they asked |

## Credit

Ask whether they want to be credited in the PDF, and under what name. If they
give a name and an email, add a `Co-Authored-By:` line with them to every
commit, so `scripts/credits.py` credits them rather than whoever merges.
Tell them first that the commit history is public, and that GitHub's "noreply"
address works. Put the email in the commit and nowhere else: not in the pull
request, the page, or project memory.

## Checklist

- [ ] Asked once whether they write Lean, or could tell
- [ ] Their argument reduced to the five headings, gaps asked for in one message
- [ ] Claims read back as numbered sentences with sources and ratings; a yes
      received before any Lean was written
- [ ] Rival named, with its own source, written before anything was proved
- [ ] Every source verified, or left `none` and the person told
- [ ] Verdict reported in the guide's words, with the claim it turned on
- [ ] Generated page read, `reader-review` run, page shown to the person
- [ ] Credit asked about, and `Co-Authored-By:` added if they want it
