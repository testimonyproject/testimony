---
name: fast-lean-loop
description: Use while writing or fixing Lean in the Testimony library, to check a change quickly and without flooding the context — the Lean language server through the lean-lsp MCP tools, scripts/quick-check.sh for the modules a change touched, reading only the errors that matter, finding declarations by search instead of reading files, and when to run the full gates instead. Pair with checking-the-build before a commit.
---

# The fast loop for Lean

A full build of `arguments/` compiles about a thousand modules and prints a line for every
`#print axioms`; reading that output costs more than the change. Work in a short loop instead,
and run the four gates in full once, before the commit (`checking-the-build`).

## 1 — Find before you read

- `grep -n "| claimName\|def lineName\|theorem result_name" -r arguments/TestimonyArguments`
  finds a declaration; read twenty lines round it, not the file.
- `docs/src/code-map.md` names the file for each kind of work and marks the long files to
  search, not read (`Atoms.lean`, `Sources.lean`, `Works.lean`, `Glossary.lean`).
- A module's docstring is its manual. Read it before its code, and stop there if it answers the
  question.

## 2 — Ask the language server

When the `lean-lsp` MCP server is connected (configured in `.mcp.json`, from the
`lean-lsp-mcp` package), use it before building:

| To | Tool |
|---|---|
| list a file's declarations without reading it | `lean_file_outline` |
| see the errors and warnings of one file | `lean_diagnostic_messages` |
| see the goal at a line of a proof | `lean_goal`, `lean_term_goal` |
| see the type and docstring of a name | `lean_hover_info` |
| find where a name is declared, or used | `lean_declaration_file`, `lean_references` |
| find a declaration in this project by name | `lean_local_search` |
| complete a name or a field | `lean_completions` |
| see which axioms a theorem uses | `lean_verify` (tier 3 still runs the audit in full) |
| find a Mathlib lemma by its type | `lean_loogle`, `lean_leansearch` (external services; use sparingly) |

The server elaborates one file against the compiled modules it imports, so it answers in seconds
(about five for a sola fide chapter) for a file whose imports are built. Pass `severity: "error"` to
`lean_diagnostic_messages` to leave out the `#print axioms` lines every file reports, and
`start_line`/`end_line` or `declaration_name` to ask about one declaration. If its imports are stale
(a module it imports changed and was not rebuilt), build that module first with `quick-check.sh`.
The server is set not to run builds or code itself, because two builds at once can corrupt each
other's compiled files.

If the tools are not listed, the server is not connected in this session; use the script below.

## 3 — Build only what changed, and read only what failed

```sh
scripts/quick-check.sh arguments/TestimonyArguments/SolaFide/James.lean
scripts/quick-check.sh            # every .lean file changed against origin/main
```

The script works out each file's package, builds that file's module and what it imports (the
library first), prints only errors, warnings and failed `#guard_msgs`, with a few lines of
context, and then runs the domain linter on the same files. A module that imports many others
still compiles them if they are stale, but prints nothing about them.

Read an error from its first line. Most have a known cause:

| The error says | The cause, usually |
|---|---|
| `establish`: not Horn | a definition the proof unfolds is missing the argument's unfold-set tag |
| `declare_dispute`: a cell differs | the table, not the encoding: copy what the engine found, then ask why |
| `declare_bundle`: a turn said to … | the prose relation is wrong; say what the solver finds |
| a `#guard_msgs` mismatch | a pinned report moved: read the diff, and re-pin only if the move is the change |
| `decide` failed to reduce | `List.filter` over formulas, or a definition the kernel cannot unfold; state it directly |
| `unknown identifier` in a docstring link | the name changed; lint rule L9 will also say so |

## 4 — Keep the output small

- Pipe long output through `grep` and `tail`: `lake build X 2>&1 | grep -E -A5 "error|warning"`.
- Never print a whole build log or a whole generated page; open the section you changed.
- Re-run only what failed while fixing it. A gate that passed with no file changed since does
  not need running again.
- Run one `lake build` at a time.

## 5 — Then the gates

Before committing, run the full gates in the order `checking-the-build` gives, and
`scripts/generate-docs.sh`. The fast loop is for finding a mistake quickly; only the gates say the
work builds.
