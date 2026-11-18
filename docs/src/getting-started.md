# Contributing with Claude Code

This page is for anyone who wants to add to Testimony and has never written a
program: a pastor with an argument they make every Easter, a Bible-study leader
who wants to see whether a reading holds up, a student who has met an objection
and wants to know exactly where it bites. You bring the argument. Claude Code,
an AI assistant that can read and change the project's files, writes the code
and runs the checks. Your part is the part no computer can do: saying what the
argument is, where it comes from, and whether what Claude wrote down is what
you meant.

The second half of the page is addressed to Claude itself, and to any other AI
agent working on the project. Humans are welcome to read it, since it says
plainly what the assistant has been told to do for you.

If you would rather not use Claude Code at all, you can still contribute. Open
an issue on GitHub in plain English (the *Encoding review* form, if it is about
an argument already on the site), and a maintainer will pair with you.
[Contributing](./contributing.md) has the other ways to help, and the
project's ground rules.

## What you are making

Each argument on this site is a list of claims, every one with a source, joined
by steps of reasoning, and set beside at least one rival position that reads the
same passages another way. A computer program called Lean checks two things:
whether the conclusion really follows from the claims, and whether the rival's
claims really leave room for it to be false. It cannot check that a claim is
true. That judgement stays with the reader, so every claim is written out,
sourced and rated where the reader can see it. When several positions are
weighed against each other, the computer also works out which are left
standing, and there a claim's rating (disputed, plausible, well supported or
consensus) can decide the result.

[Hello world](./hello-world.md) shows the smallest such argument, block by
block, with every symbol explained. Read it once before your first session.
You will not have to write anything like it, but you will be asked to read
what Claude writes, and it helps to have seen one.

## What you need

- **A GitHub account**, with access to the repository. Ask a maintainer to add
  you, or work from your own copy of it (a *fork*, in GitHub's word).
- **Claude Code.** The simplest way is on the web, at
  [claude.ai/code](https://claude.ai/code): choose the `testimony` repository,
  and the session installs the tools the project needs as it starts. Nothing
  goes on your own computer.
- **Your sources, at hand.** The commentary, the confession, the article: the
  page numbers and the exact words. Claude will look up editions and
  identifiers, but the argument is yours, and so is knowing who made it.

## Before the first session: write it down

The most useful thing you can do happens before you open Claude Code. Write
your argument out on one page, in your own words, under five headings. A
conversation that starts from this page goes quickly. One that starts from
"I think the Trinity is in Genesis" has to discover all five by questions.

1. **The conclusion, in one sentence.** "Paul teaches that we are justified by
   faith apart from works." Not a topic; a sentence someone could deny.
2. **The passages, quoted.** Chapter and verse, and the words in the English
   translation you read, with its name. The library quotes modern translations
   made from the earliest texts (the NET, LSB or NRSV first, then the ESV or
   NIV) and not the King James Version, so if yours is the KJV, Claude will
   find the same verse in one of those and check that it says what you need.
   If a Greek or Hebrew word carries the argument, name it if you know it;
   Claude can help find it if you do not.
3. **The steps.** "Because Paul says X in Romans 3:28, and X means Y, it follows
   that Z." Each *because* and *so* is a step. Most arguments have between one
   and five.
4. **The step people dispute.** Nearly every argument turns on one claim that
   the other side denies. Say which one you think it is.
5. **Who disagrees, and where they wrote it.** A named person or tradition and
   a book, a confession or an article. Not "some scholars". The project will
   not take a reading without its strongest rival, stated as its own holders
   would state it, so this heading matters as much as the first.

If you hold the argument yourself and nobody in print has made it, say so. It
is welcome, and it is marked on the page as your proposal, so a reader can tell
what the library reports from what it constructs.

## Your first session

Start the session and paste your page in, with a sentence saying what you want.
Some openings that work well:

- "Here is an argument I'd like to add. Please read it, tell me what's missing,
  and then encode it with its rival."
- "I think the page on Sola gratia misstates the Arminian position on John 6:44.
  Here is how Arminius puts it, with the reference. Can you check and fix it?"
- "I don't understand what 'standoff' means on this page. Explain it, and if
  the page is unclear, rewrite that paragraph."
- "Before you write anything, walk me through what you think my argument's
  claims are, in plain English."

Ask for that last one every time. Claude should read your claims
back to you as a numbered list of sentences, each with its source and rating,
before writing any code. Check that list as you would check a quotation of your
own words. A claim that is subtly wrong there will be wrong in everything the
computer proves from it, and the proof will make it look more reliable than it
is.

### What Claude will do next

Once you agree on the claims, Claude will:

1. Write them, the steps and the rival position in Lean.
2. Check every book and article you cited against a public catalogue (Open
   Library, Crossref). If an ISBN
   or page range cannot be confirmed, it is left blank rather than guessed.
3. Run the project's checks. There are several, and some take a few minutes.
4. Generate the page a reader will see, and read it as a lay reader would.
5. Show you what the computer found, in plain words.
6. Open a *draft pull request*: a proposal to add your work, which a maintainer
   reviews before it becomes part of the site.

You can stop it at any point and ask why. Every claim it writes should be one
you can point to in your notes or your sources.

### What it will refuse, and why

Some things Claude has been told never to do, whoever asks. Each one guards
against an argument that looks rigorous and is not.

- **It will not invent a reference.** A wrong ISBN looks exactly like a right
  one and survives review. A blank does not.
- **It will not encode your reading without a rival.** An argument checked
  against nobody proves nothing about the disagreement it claims to settle.
- **It will not adjust the encoding to get the verdict you hoped for.** If the
  computer says your argument does not settle the question, the page will say
  so too. You can add a new, cited premise and run it again; you cannot
  reword one to make the answer come out.
- **It will not drop a cited reader because you think he is wrong.** It will
  show where his reading breaks, or that it does not.

## Reading what comes back

The computer's answers come in a small vocabulary. These are the words you will
meet most, with what each one means here.

| Word | What it means on this site |
|---|---|
| claim, or premise | One sentence the argument grants or denies, with a source |
| package, or position | One side's claims, its steps and its conclusion |
| line of reason | One stretch of an argument: its grounds, one step, what it gives |
| follows, or establishes | Grant every premise and you must grant the conclusion |
| does not follow | There is a way for every premise to hold and the conclusion fail |
| countermodel | That way, written out claim by claim and checked |
| independent | The premises settle the question neither way |
| rating | How firmly a source holds a claim: disputed, plausible, well supported, consensus |
| dispute | Positions weighed: which contradicts which, and whose claims are better supported |
| prevails | Left standing however the open disagreements are settled (what the dispute *forces*) |
| standoff | Two sides defeat each other, neither better supported; neither is forced, both can be held |
| proposal | A claim or argument nobody in print has made, marked as the author's |

Two misreadings are common. "Does not follow" does not mean "false": it means
the premises leave the question open. And a standoff does not mean either side
has lost. Each defeats the other, so the dispute forces neither, but each can
still be held without contradiction. The disagreement comes down to claims each
side holds for its own reasons, none rated better than the other's, and the
page should name them. Finding those claims is often the most useful thing an
argument here does.

In a dispute a position counts as only as strong as its least-supported claim,
so a rating can decide who prevails. Check the ratings Claude reads back to you
as carefully as the sentences.

[Reading the logic](./reading-the-logic.md) goes further, still with no code,
for when you want to review someone else's argument.

## After the pull request

A maintainer reads the draft, and may ask questions on GitHub or in the
session. You may be asked for a page number, or whether a summary of a source
is fair. When it is accepted, your argument becomes a page on this site and a
chapter of the PDF, and your name can be on it: the PDF credits everyone who
worked on an argument, from the project's history. Claude will ask whether you
want to be credited, and under what name. The credit is recorded in the
project's public history with a name and an email address, so give one you are
content to have seen; GitHub's "noreply" address works.
[Contributing](./contributing.md) says more.

## For Claude and other AI agents

This section is for the assistant. It summarises what `CLAUDE.md` at the
repository root requires, and adds what to do when the person you are working
with is new. Where the two differ, `CLAUDE.md` wins.

### At the start of a session

1. Read `CLAUDE.md`. It holds the hard rules, the commands and the layout.
2. In a cloud session, run `lake exe cache get` before the first build. Without
   it the first build compiles Mathlib from source, which takes hours.
3. Find out who you are working with. If they have not said, ask once whether
   they write Lean. If they do not, load the skill `working-with-a-contributor`
   and follow it for the rest of the session.
4. Match the request to a skill before starting, from the table below.

| The person wants to | Load |
|---|---|
| bring a new argument, in their own words | `working-with-a-contributor`, then `encoding-an-argument` |
| strengthen or answer an existing argument | `supplementing-an-argument` |
| add or fix a citation | `adding-a-citation` |
| change what a page says, or make it clearer | `writing-for-readers`, `prose-voice`, `removing-ai-tells` |
| know whether the work is finished | `checking-the-build` |
| make the engine faster | `optimising-the-engine` |

The agents in `.claude/agents/` do research and return findings; they never
edit. Use `argument-intake` to turn a person's notes into a list of claims,
steps and missing sources before you write any Lean; `source-verifier` for every
identifier and quotation; `rating-auditor` before any rating above disputed;
and `reader-review` on every page you generate, before the pull request.

### Working with someone who does not write Lean

- **Talk about the argument, not the code.** Show claims as English sentences
  with their sources and ratings. Show Lean only when asked, or when the person
  must confirm a line of it, and then explain each symbol as
  [Hello world](./hello-world.md) does.
- **Read the claims back before encoding.** A numbered list, one sentence each,
  with source and rating, and the disputed claim marked. Wait for a yes. This is
  the one confirmation that should block the work, because a wrong claim is the
  failure no gate can catch.
- **Ask for what is missing, in one message.** Missing sources, an unnamed
  rival, a step the notes skip: list them together, say what you will assume
  for each if they do not know, and carry on with the rest.
- **Never fill a gap with a guess presented as a citation.** If the person
  cannot supply a source, the claim is their proposal, and the page says so.
- **Report the verdict as the solver computed it**, in the words of the table
  above, including when it is not what the person hoped. Say which claim it
  turned on, and what a new, cited premise would have to show to move it.
- **Handle the mechanics yourself.** Branches, builds, the generated pages, the
  pull request and its checklist are your work. Tell the person what you did
  in a sentence, not how.
- **Credit them.** Add a `Co-Authored-By:` line with their name and email to
  each commit, when they give one, so the PDF credits them and not you.

### Before you say it is done

Every gate in `CLAUDE.md` passes, the generated pages are current, and you have
read the generated page yourself and had `reader-review` read it. Then tell the
person, in plain words, what the page now says and what the computer found.
