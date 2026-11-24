#!/usr/bin/env python3
"""Import books of the Greek New Testament from MACULA Greek (SBLGNT edition).

MACULA Greek, by Clear Bible / Biblica, is licensed CC BY 4.0; the SBLGNT text it
carries is licensed CC BY 4.0 by the Society of Biblical Literature and Logos
Bible Software. This script keeps only the columns the library reads, and drops
every column whose licence is not CC BY 4.0 or public domain (the MARBLE word
senses, `domain` and `ln`, are used by MACULA with permission only), together
with the glosses and annotations the library does not use.

Usage:
    python3 scripts/import_greek.py SOURCE.tsv BOOK [BOOK ...]

SOURCE.tsv is MACULA's `SBLGNT/tsv/macula-greek-SBLGNT.tsv`. BOOK is a MACULA
book code (JHN, COL, TIT, HEB, ...). Each book is written to
`data/greek/macula-sblgnt/BOOK.tsv`, with the columns

    ref  role  class  text  lemma  morph

in MACULA's order of words, and two more for a verb: `actor`, the dictionary
forms of the words MACULA's frame gives as its first argument (`A0`, who or what
does what the verb says), and `actor_ref`, where those words stand, each list
joined by `;`. Where the first argument is itself a verb, a participle used as a
noun ("the one who works"), its own subject is followed in its place. The Lean
side (`Testimony.Corpus.Greek`) reads these files at build time.
"""

import csv
import hashlib
import pathlib
import sys

KEEP = ["ref", "role", "class", "text", "lemma", "morph"]
EXTRA = ["actor", "actor_ref"]


def actors(row: dict[str, str], by_id: dict[str, dict[str, str]]) -> list[dict[str, str]]:
    """The words a verb's frame gives as its first argument, each a participle
    used as a noun replaced by its own subject, as MACULA's `subjref` gives it."""
    if row["class"] != "verb":
        return []
    ids: list[str] = []
    for part in (row["frame"] or "").split():
        if part.startswith("A0:"):
            ids += [i for i in part[3:].split(";") if i in by_id]
    found: list[dict[str, str]] = []
    for i in ids:
        word, seen = by_id[i], set()
        while word["class"] == "verb" and word["subjref"] and word["xml:id"] not in seen:
            seen.add(word["xml:id"])
            nxt = [j for j in word["subjref"].split() if j in by_id]
            if not nxt:
                break
            word = by_id[nxt[0]]
        if word["class"] != "verb" and word not in found:
            found.append(word)
    return found
OUT = pathlib.Path(__file__).resolve().parent.parent / "data" / "greek" / "macula-sblgnt"


def main(argv: list[str]) -> int:
    if len(argv) < 3:
        print(__doc__, file=sys.stderr)
        return 2
    source = pathlib.Path(argv[1])
    books = set(argv[2:])
    digest = hashlib.sha256(source.read_bytes()).hexdigest()
    rows: dict[str, list[list[str]]] = {b: [] for b in books}
    with source.open(encoding="utf-8", newline="") as f:
        all_rows = list(csv.DictReader(f, delimiter="\t", quoting=csv.QUOTE_NONE))
    by_id = {r["xml:id"]: r for r in all_rows}
    for row in all_rows:
        book = row["ref"].split(" ", 1)[0]
        if book in books:
            found = actors(row, by_id)
            rows[book].append([row[k] or "" for k in KEEP] +
                              [";".join(w["lemma"] for w in found),
                               ";".join(w["ref"] for w in found)])
    OUT.mkdir(parents=True, exist_ok=True)
    for book, rs in sorted(rows.items()):
        if not rs:
            print(f"import_greek: no words for {book}", file=sys.stderr)
            return 1
        path = OUT / f"{book}.tsv"
        with path.open("w", encoding="utf-8", newline="") as f:
            f.write("\t".join(KEEP + EXTRA) + "\n")
            for r in rs:
                if any("\t" in c or "\n" in c for c in r):
                    print(f"import_greek: a field holds a tab or newline: {r}", file=sys.stderr)
                    return 1
                f.write("\t".join(r) + "\n")
        print(f"import_greek: wrote {path} ({len(rs)} words)")
    print(f"import_greek: source sha256 {digest}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
