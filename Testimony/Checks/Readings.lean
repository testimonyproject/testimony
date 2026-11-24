import Testimony.Attr
import Testimony.Variants
import Testimony.Logic.Markdown
import Testimony.Checks.Fixture
import Testimony.Checks.Postulates

/-!
# Testimony.Checks.Readings — a claim says which reading it takes, and is held to it

Mark's Gospel ends at 16:8 in the two oldest complete Bibles, Codex Sinaiticus and Codex
Vaticanus, and runs on to 16:20 in most of the rest. A claim that Jesus says in Mark 16:16 that
"whoever believes and is baptized will be saved" rests on the longer ending, and is as sure as
the judgement that Mark wrote it, and no surer. So for every package under the namespace it is
given, the check looks at every Scripture citation of every claim the package rests on, and
fails the build in four cases:

- the citation's words lie inside a place where the copies differ (a `VariationUnit` marked
  `@[variation_unit]`), and the citation does not say which reading it takes there;
- it takes a reading at a place the library does not know, or a reading the place does not have;
- it takes a reading and does not say which of the three questions it needs answered (what the
  copies say, what the author wrote, or what a church receives as Scripture);
- the claim is rated above the reading it rests on, on that question
  (`VariationUnit.rating`): the firmest cited reader who prefers the reading, and no higher than
  `disputed` where a cited reader prefers another.

It reports how many of the claims citing Scripture name the edition they read, in every
citation, so that the count rises as the arguments name their texts, and a pinned report shows
it.

`#check_variation_units` checks the units themselves (`VariationUnit.problems`): two readings or
more, each judgement on a reading the unit has and cited to a reader, and the judgements on what
the author wrote hearing both sides.
-/

namespace Testimony.Checks

open Lean Elab Command Meta

/-- Every Scripture citation a source makes, in its primary reference and its supporting ones. -/
def _root_.Testimony.Source.scriptureCitations (s : Source) : List ScriptureCitation :=
  s.references.flatMap fun
    | .scripture cs => cs
    | _ => []

/-- **What is wrong with one claim's citations, against the units the library knows**, each as
a sentence: see the module docstring. -/
def readingProblems (units : List VariationUnit) (m : Logic.AtomMeta) : List String :=
  m.source.scriptureCitations.flatMap fun c =>
    let silent := units.filterMap fun u =>
      if c.ref.overlaps u.span && !c.takes.any (·.place == u.place) then
        some ("\"" ++ m.label ++ "\" rests on " ++ c.ref.render ++ ", where the copies differ (" ++
          u.place ++ "), and does not say which reading it takes there")
      else none
    let taken := c.takes.filterMap fun t =>
      match units.find? (·.place == t.place) with
      | none => some ("\"" ++ m.label ++ "\" takes a reading at \"" ++ t.place ++
          "\", which is no place the library knows the copies differ")
      | some u =>
        if (u.reading? t.reading).isNone then
          some ("\"" ++ m.label ++ "\" takes \"" ++ t.reading ++ "\" at " ++ u.place ++
            ", which is not a reading there")
        else match c.question with
          | none => some ("\"" ++ m.label ++ "\" takes \"" ++ t.reading ++ "\" at " ++ u.place ++
              " and does not say whether it needs what the copies say, what the author wrote, " ++
              "or what is received as Scripture")
          | some q => match u.rating q t.reading with
            | none => some ("\"" ++ m.label ++ "\" takes \"" ++ t.reading ++ "\" at " ++
                u.place ++ ", which no cited reader holds on " ++ q.render)
            | some cap =>
              if m.source.confidence.rank > cap.rank then
                some ("\"" ++ m.label ++ "\" is rated " ++
                  Logic.Markdown.confidence m.source.confidence ++
                  ", above the reading it rests on at " ++ u.place ++ ", which is " ++
                  Logic.Markdown.confidence cap ++ " on " ++ q.render)
              else none
    silent ++ taken

/-- What one package's claims cite: the problems with their readings, and each claim that cites
Scripture, by its label, with whether every one of its citations names the edition it read. -/
def packageReadings {α : Type} [DecidableEq α] (units : List VariationUnit)
    (pkg : Logic.ArgumentPackage α) : List String × List (String × Bool) :=
  (pkg.manifest.flatMap (readingProblems units),
    (pkg.manifest.filter (!·.source.scriptureCitations.isEmpty)).map fun m =>
      (m.label, m.source.scriptureCitations.all (·.tradition.isSome)))

/-- The units marked `@[variation_unit]`, as a term. -/
def variationUnitsExpr (env : Environment) : MetaM Expr :=
  let names := (variationUnitAttr.ext.getState env).toList ++
    env.constants.toList.filterMap fun (n, _) =>
      if variationUnitAttr.hasTag env n then some n else none
  mkListLit (mkConst ``VariationUnit) (names.eraseDups.map mkConst)

/-- Check every package under `roots`; see the module docstring. -/
def checkReadings (roots : List Name) : CommandElabM Unit := do
  let env ← getEnv
  let mut checked : Nat := 0
  let mut claims : Std.HashMap String Bool := {}
  let mut problems : Array MessageData := #[]
  for (name, info) in env.constants.toList do
    unless roots.any (·.isPrefixOf name) do continue
    let .defnInfo d := info | continue
    let some _ := packageAtoms? d.type | continue
    let found? ← liftTermElabM do
      try
        let e ← mkAppM ``packageReadings #[← variationUnitsExpr env, mkConst name]
        some <$> unsafe evalExpr (List String × List (String × Bool)) (← inferType e) e
      catch _ => pure none
    match found? with
    | some (ps, cs) =>
      checked := checked + 1
      for (l, k) in cs do claims := claims.insert l k
      for p in ps.eraseDups do problems := problems.push m!"{name}: {p}"
    | none => problems := problems.push m!"{name}: the check could not be run"
  unless problems.isEmpty do
    throwError m!"claims resting where the copies differ, held to no reading or rated above \
      it:\n{MessageData.joinSep problems.toList "\n"}\nname the reading each takes, \
      `takes := [\{ place := …, reading := … }]`, and the question it needs answered, and rate \
      the claim no higher than the reading"
  if checked == 0 then
    throwError "#check_readings found no package to check"
  for r in roots do recordChecked `readings r
  logInfo m!"every claim resting where the copies differ takes a reading, rated no higher:\n\
    {checked} packages, {claims.size} claims citing Scripture, \
    {(claims.toList.filter (·.2)).length} naming the edition they read"

/-- `#check_readings under N` checks every package declared under the namespace `N`. -/
syntax (name := checkReadingsCmd) "#check_readings" " under " ident : command

elab_rules : command
  | `(#check_readings under $root) => checkReadings [root.getId]

/-- Check every unit marked `@[variation_unit]`; see the module docstring. -/
def checkVariationUnits : CommandElabM Unit := do
  let env ← getEnv
  let units ← liftTermElabM do
    unsafe evalExpr (List VariationUnit) (mkApp (mkConst ``List [0]) (mkConst ``VariationUnit))
      (← variationUnitsExpr env)
  let problems := units.flatMap VariationUnit.problems
  let places := units.map (·.place)
  let dup := if places.eraseDups.length != places.length then
    ["two units share a name"] else []
  unless (problems ++ dup).isEmpty do
    throwError m!"places where the copies differ, recorded wrongly:\n{
      String.intercalate "\n" (problems ++ dup)}"
  logInfo m!"every place where the copies differ has two readings or more, each judgement \
    cited to a\nreader, and both sides heard on what the author wrote: {units.length} places"

/-- `#check_variation_units` checks every unit marked `@[variation_unit]`. -/
syntax (name := checkVariationUnitsCmd) "#check_variation_units" : command

elab_rules : command
  | `(#check_variation_units) => checkVariationUnits

/-! ### What the check must catch

One unit, made up for the purpose and marked as the library's own: a verse of Mark where two
readers prefer different readings on what Mark wrote. -/

/-- A reader, made up for the cases below, at a rating. -/
private def caseReader (c : Confidence) : Source :=
  { primary := .proposal "A case of the library's own, for its check; it argues nothing."
  , tradition := .criticalScholarship, confidence := c }

/-- A unit made up for the cases below. -/
private def caseUnit : VariationUnit :=
  { place := "Mark 1:1, the title", span := .verse ⟨.mark, 1, 1⟩, kind := .omission
  , readings := [{ label := "Son of God" }, { label := "without it" }]
  , judgements :=
      [ { question := .originality, prefers := "Son of God", source := caseReader .wellSupported }
      , { question := .originality, prefers := "without it", source := caseReader .plausible } ] }

/-- A claim on Mark 1:1, at a rating, taking a reading. -/
private def caseClaim (c : Confidence) (takes : List ReadingTaken)
    (q : Option TextQuestion := some .originality) : Logic.AtomMeta :=
  { label := "Mark calls Jesus the Son of God", kind := .textual
  , source := { primary := .scripture [{ ref := .verse ⟨.mark, 1, 1⟩, question := q, takes }]
              , tradition := .criticalScholarship, confidence := c } }

/-- The reading the cases take. -/
private def sonOfGod : ReadingTaken := { place := "Mark 1:1, the title", reading := "Son of God" }

-- Silent: the claim rests on Mark 1:1 and takes no reading.
#guard (readingProblems [caseUnit] (caseClaim .disputed [])).length == 1
-- Above its reading: one reader prefers the other, so the reading is at most `disputed`.
#guard (readingProblems [caseUnit] (caseClaim .plausible [sonOfGod])).length == 1
-- At its reading: passes.
#guard (readingProblems [caseUnit] (caseClaim .disputed [sonOfGod])).isEmpty
-- No question named.
#guard (readingProblems [caseUnit] (caseClaim .disputed [sonOfGod] none)).length == 1
-- A reading the unit lacks, at an unknown place.
#guard (readingProblems [caseUnit]
  (caseClaim .disputed [sonOfGod, { sonOfGod with reading := "Christ" }])).length == 1
#guard (readingProblems [caseUnit]
  (caseClaim .disputed [sonOfGod, { sonOfGod with place := "Mark 1:2" }])).length == 1
-- On what is received, no cited reader holds either reading.
#guard (readingProblems [caseUnit] (caseClaim .disputed [sonOfGod] (some .reception))).length == 1
-- The unit itself is recorded rightly.
#guard caseUnit.problems.isEmpty
#guard caseUnit.rating .originality "Son of God" == some .disputed

/--
info: every claim resting where the copies differ takes a reading, rated no higher:
2 packages, 0 claims citing Scripture, 0 naming the edition they read
-/
#guard_msgs in
#check_readings under Testimony.Checks.Fixture

end Testimony.Checks
