import Testimony.Corpus.Greek
import Testimony.Checks.Coverage

/-!
# Testimony.Checks.VerseParts — every part of a verse is read from the Greek

A premise can speak of half a verse: John 3:18a, "whoever believes in him is not condemned",
without 3:18b, "whoever does not believe is condemned already". Such a part is named by the
positions of its first and last words in the verse, as the Greek corpus numbers them, and by one
word it contains, its anchor (`Testimony.VersePart`). `verse_part` (`Testimony.Corpus.Greek`)
builds one, and it reads the corpus while the module is built: it fails unless the verse is
there, the positions lie inside it, and the anchor occurs in the part exactly once.

Nothing in the type makes anyone use `verse_part`, though. A part is a value, and a value can
be written out by hand, `.part { verse := ⟨.john, 3, 18⟩, first := 7, last := 23, … }`, and it
would compile. It could then name words the verse does not have, or an anchor that is not
there, and every other gate would pass. So this check does not trust how a part was made. It
reads every part again.

`#check_verse_parts under N` finds every part of a verse built under the namespace `N`: in the
value of every definition, and in the statement of every definition and theorem, wherever in
the term the part stands. For each it reads the verse from the corpus and asks of it what
`verse_part` asks (`partProblem`). It fails the build, naming the declaration and the reason, if

- the book has no Greek text in the corpus, so the part cannot be read at all;
- the positions are not a span inside the verse;
- the anchor is not among the part's words, or occurs there more than once; or
- the part is not written out, so that its verse, positions or anchor are not known until
  something else is supplied, as in a function that builds a part from its argument.

It does not look inside proofs. A part that appears only in a proof is not stated by anything,
and what a theorem states is in its statement, which is read. A part made by `verse_part` passes
because `verse_part` has already asked the same questions; the check asks them again, so that
the corpus, not the way the part was written, decides.

The check records where it ran (`Testimony.Checks.Coverage`), and `#check_coverage` fails the
build if a part lies under no namespace it was run under. The arguments package runs it over
the library and over its own namespace.
-/

namespace Testimony.Checks

open Lean Elab Command Meta Testimony.Corpus.Greek

/-- Whether a declaration belongs to the machinery of `VersePart` itself: its constructor,
recursors and projections, and the instances it derives, whose terms name the constructor
without building a part of any verse. -/
def versePartMachinery (name : Name) : Bool :=
  name.isInternalDetail ||
    [``Testimony.VersePart, `Testimony.instDecidableEqVersePart].any (·.isPrefixOf name)

/-- Every place a term builds a part of a verse: each application of `VersePart.mk`, and the
constructor named on its own, as when it is passed to a function. Shared subterms are visited
once. -/
partial def versePartsIn (e : Expr) : Array Expr :=
  if e.find? (·.isConstOf ``Testimony.VersePart.mk) |>.isNone then #[]
  else ((visit e).run ({}, #[])).2.2
where
  /-- Walk the term, collecting every part it builds. -/
  visit (e : Expr) : StateM (Std.HashSet Expr × Array Expr) Unit := do
    if (← get).1.contains e then return
    modify fun (seen, found) => (seen.insert e, found)
    if e.getAppFn.isConstOf ``Testimony.VersePart.mk then
      modify fun (seen, found) => (seen, found.push e)
      for a in e.getAppArgs do visit a
      return
    match e with
    | .app f a => visit f; visit a
    | .lam _ t b _ | .forallE _ t b _ => visit t; visit b
    | .letE _ t v b _ => visit t; visit v; visit b
    | .mdata _ b | .proj _ _ b => visit b
    | _ => pure ()

/-- Whether a declaration's statement, or a definition's value, builds a part of a verse. -/
def buildsVersePart (info : ConstantInfo) : Bool :=
  !(versePartsIn info.type).isEmpty ||
    match info with
    | .defnInfo d => !(versePartsIn d.value).isEmpty
    | _ => false

/-- A part of a verse as written out in a term: the book's code in the corpus, chapter, verse,
the letter, the positions of its first and last words, and its anchor. -/
structure WrittenPart where
  /-- The book's code in the corpus, `JHN`. -/
  code : String
  /-- Its chapter. -/
  chapter : Nat
  /-- Its verse. -/
  verse : Nat
  /-- The letter after the verse number. -/
  letter : String
  /-- The position of its first word. -/
  first : Nat
  /-- The position of its last word. -/
  last : Nat
  /-- The dictionary form of its anchor. -/
  anchor : String

/-- Read a part built by the term `e`, an application of `VersePart.mk`, as the values written
in it, or say why it cannot be read: it is not fully applied, it depends on something not yet
supplied, or a field does not reduce to a literal. -/
def readWrittenPart (e : Expr) : MetaM (Except String WrittenPart) := do
  let args := e.getAppArgs
  unless args.size == 5 do
    return .error "the constructor `VersePart.mk` is used without all of its fields"
  if e.hasLooseBVars || e.hasFVar || e.hasMVar then
    return .error "its words wait on a value not yet supplied"
  let nat (x : Expr) : MetaM (Option Nat) := do
    if let some n ← evalNat x then return some n
    match ← whnf x with
    | .lit (.natVal n) => return some n
    | _ => return none
  let str (x : Expr) : MetaM (Option String) := do
    match ← whnf x with
    | .lit (.strVal s) => return some s
    | _ => return none
  let p ← whnf args[0]!
  unless p.isAppOfArity ``Testimony.Passage.mk 3 do
    return .error "its verse is not written out"
  let some book := (← whnf p.getAppArgs[0]!).constName?
    | return .error "its book is not written out"
  let some code := bookCodes.find? (fun (_, b) => ``Testimony.Book ++ b == book) |>.map (·.1)
    | return .error s!"{book} has no Greek text, so the part cannot be read from the corpus"
  let some chapter ← nat p.getAppArgs[1]! | return .error "its chapter is not written out"
  let some verse ← nat p.getAppArgs[2]! | return .error "its verse number is not written out"
  let some letter ← str args[1]! | return .error "its letter is not written out"
  let some first ← nat args[2]! | return .error "its first word is not written out"
  let some last ← nat args[3]! | return .error "its last word is not written out"
  let some anchor ← str args[4]! | return .error "its anchor is not written out"
  return .ok { code, chapter, verse, letter, first, last, anchor }

/-- Every problem with the parts of verses built by the declarations `names`, as messages,
and how many parts were read and passed. Each book's file is read once. -/
def versePartProblems (names : Array Name) : CommandElabM (Array MessageData × Nat) := do
  let env ← getEnv
  let mut books : Std.HashMap String (Array Row) := {}
  let mut problems : Array MessageData := #[]
  let mut passed : Nat := 0
  for name in names do
    let some info := env.find? name | continue
    let terms := versePartsIn info.type ++
      match info with
      | .defnInfo d => versePartsIn d.value
      | _ => #[]
    for t in terms do
      match ← liftTermElabM (readWrittenPart t) with
      | .error why => problems := problems.push m!"{name}: {why}"
      | .ok w =>
        let place := s!"{w.code} {w.chapter}:{w.verse}{w.letter}"
        let rows ← match books[w.code]? with
          | some rows => pure (some rows)
          | none =>
            try
              let rows ← liftIO (readBook w.code)
              pure (some rows)
            catch _ => pure none
        let some rows := rows
          | problems := problems.push m!"{name}: {place}: the corpus has no file for {w.code}"
            continue
        books := books.insert w.code rows
        let words := (rows.filter fun r => r.chapter == w.chapter && r.verse == w.verse).toList
        match partProblem words w.first w.last w.anchor with
        | some why => problems := problems.push m!"{name}: {place}: {why}"
        | none => passed := passed + 1
  return (problems, passed)

/-- Fail, naming each one, if any problems were found. -/
def refuseVerseParts (problems : Array MessageData) : CommandElabM Unit := do
  unless problems.isEmpty do
    throwError m!"parts of verses the Greek corpus does not bear out:\n{
      MessageData.joinSep problems.toList "\n"}\nwrite each part with `verse_part`, which reads \
      it from the corpus"

/-- The declarations under `root` whose statement or value builds a part of a verse, in order
of name. -/
def versePartDecls (env : Environment) (root : Name) : Array Name :=
  let names := env.constants.toList.filterMap fun (name, info) =>
    if root.isPrefixOf name && !versePartMachinery name && buildsVersePart info then some name
    else none
  names.toArray.qsort (·.toString < ·.toString)

/-- Check every part of a verse built under `root`; see the module docstring. -/
def checkVerseParts (root : Name) : CommandElabM Unit := do
  let (problems, passed) ← versePartProblems (versePartDecls (← getEnv) root)
  refuseVerseParts problems
  recordChecked `verseParts root
  if passed == 0 then
    logInfo m!"no part of a verse is built under {root}"
  else
    logInfo m!"every part of a verse under {root} is read from the Greek corpus: {passed}"

/-- `#check_verse_parts under N` reads every part of a verse built under the namespace `N`
against the Greek corpus, and fails the build on any the corpus does not bear out. -/
syntax (name := checkVersePartsCmd) "#check_verse_parts" " under " ident : command

/-- `#check_verse_parts in cmd` runs `cmd`, reads every part of a verse built by what it
declares, and then forgets the declarations. It is for pinning a refusal: a hand-written part
the check must reject, which must not stay in the library to be found again. -/
syntax (name := checkVersePartsInCmd) "#check_verse_parts" " in " command : command

elab_rules : command
  | `(#check_verse_parts under $root) => checkVerseParts root.getId
  | `(#check_verse_parts in $cmd) => withoutModifyingEnv do
    let before := (← getEnv).constants.map₂
    elabCommand cmd
    let env ← getEnv
    let added := env.constants.map₂.toList.filterMap fun (name, info) =>
      if before.contains name || versePartMachinery name || !buildsVersePart info then none
      else some name
    let (problems, passed) ← versePartProblems added.toArray
    refuseVerseParts problems
    logInfo m!"read from the Greek corpus: {passed}"

/-! ### What the check passes, and what it refuses

The part `verse_part` built, John 3:18a, is read again and passes. -/

/-- info: every part of a verse under Testimony.Corpus is read from the Greek corpus: 1 -/
#guard_msgs in
#check_verse_parts under Testimony.Corpus

/-! The same part written out by hand passes too, because the corpus bears it out: it is not
how a part is written that the check asks about, but whether the words are there. -/

/-- info: read from the Greek corpus: 1 -/
#guard_msgs in
#check_verse_parts in
/-- John 3:18a, written out by hand. -/
def handWrittenA : PassageRange :=
  .part { verse := ⟨.john, 3, 18⟩, letter := "a", first := 1, last := 6, anchor := "πιστεύω" }

/-! A hand-written 3:18b anchored by πιστεύω is refused, because the verb occurs twice in words
7 to 23, "whoever does not believe … because he has not believed". So is a part longer than its
verse, a part anchored by a word it does not hold, and a part of a book the corpus does not
have. -/

/--
error: parts of verses the Greek corpus does not bear out:
Testimony.Checks.handWrittenB: JHN 3:18b: its anchor πιστεύω occurs 2 times among words 7 to 23
write each part with `verse_part`, which reads it from the corpus
-/
#guard_msgs in
#check_verse_parts in
/-- John 3:18b, anchored by a word it holds twice. -/
def handWrittenB : PassageRange :=
  .part { verse := ⟨.john, 3, 18⟩, letter := "b", first := 7, last := 23, anchor := "πιστεύω" }

/--
error: parts of verses the Greek corpus does not bear out:
Testimony.Checks.handWrittenOverlong: JHN 3:18c: the verse has 23 words, not 30
write each part with `verse_part`, which reads it from the corpus
-/
#guard_msgs in
#check_verse_parts in
/-- John 3:18, given more words than it has. -/
def handWrittenOverlong : PassageRange :=
  .part { verse := ⟨.john, 3, 18⟩, letter := "c", first := 1, last := 30, anchor := "πιστεύω" }

/--
error: parts of verses the Greek corpus does not bear out:
Testimony.Checks.handWrittenUnanchored: JHN 3:16b: its anchor ἀγαπάω is not among words 10 to 20
write each part with `verse_part`, which reads it from the corpus
-/
#guard_msgs in
#check_verse_parts in
/-- Part of John 3:16, anchored by a word it does not hold. -/
def handWrittenUnanchored : PassageRange :=
  .part { verse := ⟨.john, 3, 16⟩, letter := "b", first := 10, last := 20, anchor := "ἀγαπάω" }

/--
error: parts of verses the Greek corpus does not bear out:
Testimony.Checks.handWrittenRomans: ROM 3:28a: the corpus has no file for ROM
write each part with `verse_part`, which reads it from the corpus
-/
#guard_msgs in
#check_verse_parts in
/-- Part of Romans 3:28, a book the corpus does not yet have. -/
def handWrittenRomans : PassageRange :=
  .part { verse := ⟨.romans, 3, 28⟩, letter := "a", first := 1, last := 3, anchor := "λογίζομαι" }

/-! A part built by a function from its argument cannot be read, because its words are not
known until the function is applied. -/

/--
error: parts of verses the Greek corpus does not bear out:
Testimony.Checks.handWrittenFromArgument: its words wait on a value not yet supplied
write each part with `verse_part`, which reads it from the corpus
-/
#guard_msgs in
#check_verse_parts in
/-- A part of John 3:18 ending wherever the caller says. -/
def handWrittenFromArgument (last : Nat) : PassageRange :=
  .part { verse := ⟨.john, 3, 18⟩, letter := "a", first := 1, last, anchor := "πιστεύω" }

end Testimony.Checks
