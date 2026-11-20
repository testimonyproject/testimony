#!/usr/bin/env python3
"""Import books of the Hebrew Bible from MACULA Hebrew, with their verse numbering.

MACULA Hebrew, by Clear Bible / Biblica, is licensed CC BY 4.0. The text it carries
is the Westminster Leningrad Codex, in the public domain, and its morphology is the
Open Scriptures Hebrew Bible's, licensed CC BY 4.0. This script keeps only the
columns the library reads, and drops every column whose licence is not CC BY 4.0
or public domain (the Semantic Dictionary of Biblical Hebrew's domains and senses,
`lexdomain`, `contextualdomain`, `coredomain` and `sdbh`, are used by MACULA with
permission only), together with the glosses and annotations the library does not use.

The Hebrew text numbers some verses differently from English Bibles: English Micah
5:2 is Hebrew 5:1. The library names a verse as English Bibles number it, so the
script also writes, for the books imported, where each differently numbered English
verse stands in the Hebrew. It reads that from STEPBible's TVTMS ("Translators
Versification Traditions with Methodology for Standardisation"), licensed CC BY 4.0,
taking its "English KJV" and "Hebrew" columns. A row is used only when it pairs whole
verses one to one. An English verse in any other row (one the Hebrew splits, joins,
or leaves out), or one whose Hebrew verse is named by such a row, is written with
`-` in place of a Hebrew verse, so the library refuses to number a part of it.

Usage:
    python3 scripts/import_hebrew.py SOURCE.tsv TVTMS.txt BOOK [BOOK ...]

SOURCE.tsv is MACULA's `WLC/tsv/macula-hebrew.tsv`; TVTMS.txt is STEPBible-Data's
`Versification/TVTMS - ... CC BY.txt`. BOOK is a MACULA book code (ISA, MIC, ...).
Each book is written to `data/hebrew/macula-wlc/BOOK.tsv`, with the columns

    ref  role  class  text  lemma  morph

in MACULA's order of words (`role` is empty: MACULA Hebrew's word table has none),
and the numbering of every imported book to `data/hebrew/macula-wlc/versification.tsv`,
with the columns `english` and `hebrew`. The Lean side (`Testimony.Corpus.Table`)
reads these files at build time.
"""

import csv
import hashlib
import pathlib
import re
import sys

KEEP = ["ref", "role", "class", "text", "lemma", "morph"]
OUT = pathlib.Path(__file__).resolve().parent.parent / "data" / "hebrew" / "macula-wlc"

# MACULA's book codes, and TVTMS's for the same books.
TVTMS = {
    "GEN": "Gen", "EXO": "Exo", "LEV": "Lev", "NUM": "Num", "DEU": "Deu", "JOS": "Jos",
    "JDG": "Jdg", "RUT": "Rut", "1SA": "1Sa", "2SA": "2Sa", "1KI": "1Ki", "2KI": "2Ki",
    "1CH": "1Ch", "2CH": "2Ch", "EZR": "Ezr", "NEH": "Neh", "EST": "Est", "JOB": "Job",
    "PSA": "Psa", "PRO": "Pro", "ECC": "Ecc", "SNG": "Sng", "ISA": "Isa", "JER": "Jer",
    "LAM": "Lam", "EZK": "Ezk", "DAN": "Dan", "HOS": "Hos", "JOL": "Jol", "AMO": "Amo",
    "OBA": "Oba", "JON": "Jon", "MIC": "Mic", "NAM": "Nam", "HAB": "Hab", "ZEP": "Zep",
    "HAG": "Hag", "ZEC": "Zec", "MAL": "Mal",
}

SIMPLE = re.compile(r"^(\w+)\.(\d+):(\d+)(?:-(\d+))?$")
ANY_REF = re.compile(r"(\w+)\.(\d+):(\d+)")


def verses(ref: str):
    """The whole verses a TVTMS cell names, as (book, chapter, verse), or None."""
    m = SIMPLE.match(ref.strip())
    if not m:
        return None
    book, ch, v1, v2 = m.group(1), int(m.group(2)), int(m.group(3)), m.group(4)
    return [(book, ch, v) for v in range(v1, int(v2) + 1 if v2 else v1 + 1)]


def versification(path: pathlib.Path, books: set[str]):
    """English verse -> Hebrew verse, or None where the two are not one to one."""
    wanted = {TVTMS[b] for b in books}
    pairs: dict[tuple, tuple] = {}
    refused: set[tuple] = set()
    hebrew_bad: set[tuple] = set()
    cols = None
    for line in path.read_text(encoding="utf-8-sig").splitlines():
        fields = line.split("\t")
        head = fields[0].strip()
        if head.startswith("$"):
            cols = fields[1:] if "English KJV" in fields else None
            continue
        if head == "BIBLES":
            cols = fields[1:]
            continue
        if cols is None or "English KJV" not in cols or "Hebrew" not in cols:
            continue
        if head.startswith("TEST") or len(fields) < 2 or not re.match(
                r"^\w+\.\d+:", fields[1].strip()):
            continue
        eng = fields[1 + cols.index("English KJV")].strip()
        heb = fields[1 + cols.index("Hebrew")].strip()
        if eng.split(".")[0] not in wanted and heb.split(".")[0] not in wanted:
            continue
        e, h = verses(eng), verses(heb)
        if e and h and len(e) == len(h):
            for a, b in zip(e, h):
                pairs[a] = b
        else:
            for m in ANY_REF.finditer(eng):
                refused.add((m.group(1), int(m.group(2)), int(m.group(3))))
            for m in ANY_REF.finditer(heb):
                hebrew_bad.add((m.group(1), int(m.group(2)), int(m.group(3))))
    out: dict[tuple, tuple | None] = {}
    for a, b in pairs.items():
        out[a] = None if (a in refused or b in hebrew_bad) else b
    for a in refused:
        out[a] = None
    for a in list(out):
        if a not in pairs and a in hebrew_bad:
            out[a] = None
    # An English verse numbered as the Hebrew numbers it, but whose Hebrew verse a
    # split or join names, cannot be read either.
    for b in hebrew_bad:
        if b not in out and b not in pairs.values():
            out[b] = None
    return {k: v for k, v in out.items() if v != k}


def main(argv: list[str]) -> int:
    if len(argv) < 4:
        print(__doc__, file=sys.stderr)
        return 2
    source, tvtms = pathlib.Path(argv[1]), pathlib.Path(argv[2])
    books = set(argv[3:])
    unknown = books - TVTMS.keys()
    if unknown:
        print(f"import_hebrew: not a book code: {sorted(unknown)}", file=sys.stderr)
        return 2
    rows: dict[str, list[list[str]]] = {b: [] for b in books}
    present: set[tuple] = set()
    with source.open(encoding="utf-8", newline="") as f:
        reader = csv.DictReader(f, delimiter="\t", quoting=csv.QUOTE_NONE)
        for row in reader:
            book = row["ref"].split(" ", 1)[0]
            if book in books:
                rows[book].append([row.get(k) or "" for k in KEEP])
                ch, rest = row["ref"].split(" ", 1)[1].split(":")
                present.add((book, int(ch), int(rest.split("!")[0])))
    OUT.mkdir(parents=True, exist_ok=True)
    for book, rs in sorted(rows.items()):
        if not rs:
            print(f"import_hebrew: no words for {book}", file=sys.stderr)
            return 1
        path = OUT / f"{book}.tsv"
        with path.open("w", encoding="utf-8", newline="") as f:
            f.write("\t".join(KEEP) + "\n")
            for r in rs:
                if any("\t" in c or "\n" in c for c in r):
                    print(f"import_hebrew: a field holds a tab or newline: {r}", file=sys.stderr)
                    return 1
                f.write("\t".join(r) + "\n")
        print(f"import_hebrew: wrote {path} ({len(rs)} words)")
    code = {v: k for k, v in TVTMS.items()}
    mapping = versification(tvtms, books)
    lines = []
    for (b, c, v), target in sorted(mapping.items(), key=lambda kv: (kv[0][0], kv[0][1], kv[0][2])):
        if code.get(b) not in books:
            continue
        eng = f"{code[b]} {c}:{v}"
        if target is None:
            lines.append(f"{eng}\t-")
            continue
        tb, tc, tv = target
        if (code[tb], tc, tv) not in present:
            print(f"import_hebrew: {eng} maps to {tb}.{tc}:{tv}, not in the text", file=sys.stderr)
            return 1
        lines.append(f"{eng}\t{code[tb]} {tc}:{tv}")
    vpath = OUT / "versification.tsv"
    vpath.write_text("english\thebrew\n" + "".join(l + "\n" for l in lines), encoding="utf-8")
    print(f"import_hebrew: wrote {vpath} ({len(lines)} verses numbered differently)")
    print(f"import_hebrew: source sha256 {hashlib.sha256(source.read_bytes()).hexdigest()}")
    print(f"import_hebrew: TVTMS sha256 {hashlib.sha256(tvtms.read_bytes()).hexdigest()}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
