import Testimony.Logic.Aif
import Testimony.Checks.Fixture

/-!
# Testimony.Checks.Aif — every dispute, as an Argument Interchange Format graph

Every dispute under a namespace the check is given, whose parties are listed (a
`Solver.Finite`), is drawn as an AIF graph (`Testimony.Logic.Aif`) and checked against the AIF
specification's Definition 1.1. A hearing — a dispute restricted to some of its
parties — is drawn with the dispute it restricts, and counted. The check finds
the disputes itself, so one added tomorrow is drawn and checked tomorrow, and it
fails the build if any graph breaks the definition. The report is pinned: how
many claims, inferences, conflicts and preferences each dispute is, in AIF's
terms. The library runs it over its own fixture (`Testimony.Checks.Fixture`);
a package built on the library runs it over its arguments.
-/

namespace Testimony.Checks

open Lean Elab Command Meta

/-- One dispute's AIF graph, in a line: the node counts by kind, and whether it
meets Definition 1.1. -/
def aifLine (g : Testimony.Logic.Aif.Graph) : String × Bool :=
  open Testimony.Logic.Aif in
  (toString (g.count .i) ++ " I, " ++ toString (g.count .ra) ++ " RA, " ++
    toString (g.count .ca) ++ " CA, " ++ toString (g.count .pa) ++ " PA, " ++
    toString g.edges.length ++ " edges", g.wellFormed)

/-- Draw every listed dispute under `root` as an AIF graph and check it; see
the module docstring. -/
def checkAif (root : Name) : CommandElabM Unit := do
  let env ← getEnv
  let mut lines : Array String := #[]
  let mut broken : Array Name := #[]
  let mut hearings : Nat := 0
  for (name, info) in env.constants.toList do
    unless root.isPrefixOf name do continue
    let ty := info.type
    unless ty.isAppOfArity ``Testimony.Logic.Solver.Finite 2 do continue
    unless ty.appArg!.isAppOf ``Testimony.Logic.Dispute.defeats do
      hearings := hearings + 1
      continue
    let r? ← liftTermElabM do
      try
        let g ← mkAppM ``Testimony.Logic.Aif.ofFinite #[mkConst name]
        let e ← mkAppM ``aifLine #[g]
        some <$> unsafe evalExpr (String × Bool) (toTypeExpr (String × Bool)) e
      catch _ => pure none
    match r? with
    | some (line, ok) =>
      lines := lines.push ((name.replacePrefix root .anonymous).toString ++ ": " ++ line)
      unless ok do broken := broken.push name
    | none => throwError m!"#check_aif could not draw {name}"
  unless broken.isEmpty do
    throwError m!"AIF graphs that break Definition 1.1:\n{MessageData.joinSep
      (broken.toList.map toMessageData) "\n"}"
  if lines.isEmpty then
    throwError "#check_aif found no dispute to draw"
  logInfo m!"every dispute, as an AIF graph meeting Definition 1.1:\n{
    String.intercalate "\n" (lines.qsort (· < ·)).toList}\nand {hearings} hearings, drawn with \
    the disputes they restrict"

/-- `#check_aif under N` draws and checks every dispute declared under the
namespace `N`. -/
syntax (name := checkAifCmd) "#check_aif" " under " ident : command

elab_rules : command
  | `(#check_aif under $root) => checkAif root.getId

/--
info: every dispute, as an AIF graph meeting Definition 1.1:
finite: 4 I, 2 RA, 1 CA, 1 PA, 8 edges
and 0 hearings, drawn with the disputes they restrict
-/
#guard_msgs in
#check_aif under Testimony.Checks.Fixture

end Testimony.Checks
