import Testimony.Logic.Line
import Testimony.Argument

/-!
# Testimony.Logic.Page — what a generated page is made of

An argument module is a literate document: a module docstring saying what the
dispute is, `/-! ### … -/` blocks marking its sections, and a docstring on every
package, line, countermodel and result. `Testimony.Tools.Pages` harvests all of
it from the environment in source order; this module is the shape it comes back
in, and `Testimony.Logic.Markdown` and `Testimony.Logic.Latex` are the two
renderings of that shape.

The type sits here rather than in either renderer because neither owns it. The
harvest is medium-independent — a docstring, a package, a pretty-printed
statement — and what differs is only how each is set.
-/

namespace Testimony.Logic.Page

open Testimony

variable {α : Type}

/-- Why one position stands against another, as a page shows it: the data of a
`Because` (`Testimony.Logic.Because`), without its proofs. -/
structure Explanation (α : Type) where
  /-- The position that stands. -/
  holder : String
  /-- The rival it stands against. -/
  rival : String
  /-- Citation and classification for every atom, the holder's. -/
  cite : α → AtomMeta
  /-- The premise the explanation turns on. -/
  crux : Formula α
  /-- Further premises of the holder the break needs. -/
  granted : List (Formula α)
  /-- The premises of the rival that cannot be held with the crux. -/
  core : List (Formula α)
  /-- Whether the holder's conclusion needs the crux, or the crux only answers
  the rival. -/
  derives : Bool
  /-- The citation that rates a crux that is a step rather than a claim, when
  one of the holder's inferences is named as the step's own. -/
  rating : Option Source
  /-- All the holder's cited inferences, which rate its steps together: what a
  page can say of a step whose own rating is not named. -/
  inferences : List Source

namespace Explanation

/-- Whether a formula is a claim or a denied claim, as against a step. -/
def isLiteral : Formula α → Bool
  | .atom _ => true
  | .imp (.atom _) .falsum => true
  | _ => false

/-- The claims an explanation rests on, each once: the crux, when it is a
claim, and the granted grounds. A crux that is a step rests on the step's own
rating instead, not on the claims it mentions — some of which are the rival's. -/
def restsOn [DecidableEq α] (e : Explanation α) : List α :=
  ((if isLiteral e.crux then atomsOf e.crux else []) ++ e.granted.flatMap atomsOf).eraseDups

end Explanation

/-- What happens to one reading of a rival's claim against one position, as a
page shows it: the position, and the explanation if the reading falls to it. -/
structure Fate (α : Type) where
  /-- The position the reading is set against. -/
  against : String
  /-- Why the reading falls, if it does; `none` when the position does not
  reach it. -/
  falls : Option (Explanation α)

/-- One horn of a dilemma, as a page shows it. -/
structure DilemmaHorn (α : Type) where
  /-- The reading, as a phrase. -/
  reading : String
  /-- What the claim commits its holder to, read this way. -/
  commits : Formula α
  /-- What the rival rests the reading on. -/
  grounds : List (Formula α)
  /-- Who reads the claim this way. -/
  source : Source
  /-- What happens to the reading, against each position. -/
  fates : List (Fate α)

/-- Every reading of a rival's claim, answered, as a page shows it: the data
of a `Dilemma` (`Testimony.Logic.Dilemma`), without its proofs. -/
structure Dilemma (α : Type) where
  /-- The rival whose claim is read. -/
  rival : String
  /-- Citation and classification for every atom, the rival's. -/
  cite : α → AtomMeta
  /-- The claim read more than one way. -/
  claim : Formula α
  /-- One horn per reading. -/
  horns : List (DilemmaHorn α)

/-- What an opponent must reject, as a page shows it: the data of an
`OpponentsBurden` (`Testimony.Logic.Burden`), without its proofs. -/
structure Burden where
  /-- The position the burden is on. -/
  holder : String
  /-- What it concludes. -/
  conclusion : String
  /-- Each line's name and the citation rating its reading, in order. -/
  readings : List (String × Option Source)
  /-- The minimal sets of readings whose rejection overturns the case, by
  index into `readings`. -/
  sets : List (List ℕ)

namespace Burden

/-- The readings that belong to no set: rejecting them never helps. -/
def spare (b : Burden) : List String :=
  (b.readings.zipIdx.filter fun (_, i) => !b.sets.any (·.contains i)).map (·.1.1)

end Burden

/-- A dissent, assessed, as a page shows it: the data of an `Assessment`
(`Testimony.Logic.Credibility`), in words. -/
structure Assessed where
  /-- Who dissents. -/
  dissenter : String
  /-- What they dissent from. -/
  against : String
  /-- Whether the checks find a critique: an argued dissent, before any
  standard is applied. -/
  critique : Bool
  /-- What kind of dissent it is, in a sentence. -/
  kind : String
  /-- Under each standard: its name, whether the dissent is credible under it,
  and the claims it asserts that the standard does not admit, by their labels. -/
  standards : List (String × Bool × List String)
  /-- The claims struck because a text refutes them: each claim's label, and what
  the text reads. -/
  struck : List (String × String) := []

/-- A step's rating, computed from its register, as a page shows it: the data
of a `RatedStep` (`Testimony.Logic.Credibility`), in words. -/
structure Rated where
  /-- The step. -/
  step : String
  /-- The citation that rates its support. -/
  support : Source
  /-- Every dissent encoded against it, by who dissents. -/
  register : List String
  /-- The strongest known dissent, if encoded. -/
  steelman : Option String
  /-- Under each standard: its name, the rating, and why, in a phrase. -/
  ratings : List (String × Confidence × String)

/-- A piece of a generated sentence. The renderers set each piece in their own
medium: a party's name in italics, and a defeat with its verb linked to what
explains it. -/
inductive Seg
  /-- Words, written by the generator. -/
  | text (s : String)
  /-- A party, by its package's name. -/
  | party (name : String)
  /-- "*a* defeats *b*", by the two packages' names. -/
  | defeat (a b : String)

/-- A premise a party holds at its weakest link: the claim (or its denial, or
the party's inference), how firmly it is held, and who says so. -/
structure Held where
  /-- What is held. -/
  what : String
  /-- At what confidence. A denied claim ranks `disputed`, whatever its
  citation, because the citation rates the claim and not its denial. -/
  confidence : Confidence
  /-- The citation that rates it. -/
  source : Source

/-- A party a verdict rests on, and its weakest link: the lowest rating among
its premises and inferences, with every premise held at that rating. -/
structure Reading where
  /-- The party, by its package's name. -/
  party : String
  /-- Its weakest link; empty if it has no rated premise. -/
  weakest : List Held

/-- Why a verdict holds, as a page shows it: the claim, then the reasons as an
indented list, both generated from a checked witness
(`Testimony.Logic.Verdict`); and what the reasons rest on. -/
structure Verdict where
  /-- What the verdict says. -/
  claim : List Seg
  /-- The reasons, each with its depth in the list. -/
  reasons : List (Nat × List Seg)
  /-- Every cell of the defeat table the reasons use: attacker, attacked, and
  whether the one defeats the other. -/
  cells : List (String × String × Bool)
  /-- Every party those cells involve, at its weakest link. -/
  readings : List Reading

/-- A `Because` on the page, found by the pair it explains: the holder's name,
the rival's name, and the declaration. A defeat of the rival by the holder links
to it. -/
abbrev BecauseLink := String × String × String

/-- The declaration explaining why `a` defeats `b`, if the page has one. -/
def becauseFor (links : List BecauseLink) (a b : String) : Option String :=
  (links.find? fun (h, r, _) => h == a && r == b).map (·.2.2)

/-- What an edge of a dispute's graph is. A support, and each attack derived
through support, carries whether the same pair is already a defeat. -/
inductive EdgeKind
  /-- The first defeats the second. -/
  | defeat
  /-- The first's conclusion entails a claim the second rests on. -/
  | support (alsoDefeats : Bool)
  /-- The first supports a party that defeats the second. -/
  | supportedAttack (alsoDefeats : Bool)
  /-- The first defeats a party that supports the second. -/
  | secondaryAttack (alsoDefeats : Bool)
  /-- The first's whole case is part of the second's. -/
  | partOf
  /-- The first defeats a party whose case is part of the second's. -/
  | partAttack (alsoDefeats : Bool)

/-- A dispute's graph, as a page shows it (`Testimony.Logic.Map`): the parties,
numbered, and every edge between them by number. -/
structure Graph where
  /-- The parties, by their packages' names, in the order they are numbered. -/
  nodes : List String
  /-- Every edge: from, to, and what it is. -/
  edges : List (Nat × Nat × EdgeKind)

namespace Graph

/-- Where party `k` of `n` sits on the unit circle, the first at the top and the
rest clockwise: the layout both renderings draw. -/
def position (n k : Nat) : Float × Float :=
  let θ := 3.141592653589793 / 2 - 2 * 3.141592653589793 * k.toFloat / n.toFloat
  (Float.cos θ, Float.sin θ)

/-- What an edge is, in words, for the table. -/
def EdgeKind.describe : EdgeKind → String
  | .defeat => "defeats"
  | .support d => "supports" ++ (if d then " — and defeats" else "")
  | .supportedAttack d =>
    "supported attack" ++ (if d then " — already a defeat" else " — not a defeat")
  | .secondaryAttack d =>
    "secondary attack" ++ (if d then " — already a defeat" else " — not a defeat")
  | .partOf => "is part of"
  | .partAttack d =>
    "attack on a part" ++ (if d then " — already a defeat" else " — not a defeat")

/-- Whether an edge is drawn: defeats and supports are; the attacks derived
through support are listed in the table only. -/
def EdgeKind.drawn : EdgeKind → Bool
  | .defeat | .support _ | .partOf => true
  | _ => false

/-- The derived attacks that are not already defeats. -/
def undirected (g : Graph) : Nat :=
  (g.edges.filter fun (_, _, k) => match k with
    | .supportedAttack false | .secondaryAttack false | .partAttack false => true
    | _ => false).length

/-- The pairs in which one party both supports and defeats the other. -/
def conflicted (g : Graph) : Nat :=
  (g.edges.filter fun (_, _, k) => match k with
    | .support true => true
    | _ => false).length

end Graph

/-- One turn of an exchange, as a page shows it: the data of a bundle's `Turn`
(`Testimony.Logic.Bundle`), in words. -/
structure ExchangeTurn where
  /-- The party, by its package's name. -/
  party : String
  /-- What the page says of the turn. -/
  doc : String
  /-- How it stands to an earlier turn: `answers`, `meets`, `standsApart`,
  `responds`, `evades`, `restates`, `concedes`, `shifts`, `ignores`, or empty
  when it only enters. -/
  relation : String := ""
  /-- The earlier turn's party, by its package's name; empty if none. -/
  target : String := ""
  /-- The declaration of the line the turn quotes; empty if none. -/
  quoting : String := ""
  /-- The fallacies that line declares it commits, by kind. -/
  findings : List String := []
  /-- The party of the first later turn that answers this one; empty if none. -/
  answeredBy : String := ""
  /-- What the turn's position concludes, in words; empty if not known. -/
  concludes : String := ""
  /-- What the earlier turn's position concludes; empty if none. -/
  targetConcludes : String := ""
  /-- The party of the first earlier turn that answers the earlier turn named;
  empty if none. -/
  answeredEarlierBy : String := ""
  /-- The parties of the earlier turns that defeated the position the turn sets
  out again, and that it does not defeat in return. -/
  leftStanding : List String := []
  /-- The title of the work the turn comes from; empty if it names none. -/
  source : String := ""
  /-- That work's date, as the page writes it ("1547", "c. 390"); empty if none. -/
  year : String := ""
deriving Repr

/-- An exchange, as a page shows it: its turns in order, and every pair of the
parties they set out, with whether each defeats the other. -/
structure Exchange where
  /-- The turns, in the order a reader meets them. -/
  turns : List ExchangeTurn
  /-- Each pair of distinct parties, in the order the turns first set them out:
  the two names, whether the first defeats the second, and the reverse. -/
  pairs : List (String × String × Bool × Bool)
deriving Repr

namespace Exchange

/-- The sentence that joins a turn to the earlier one it names, in words, as the
solver found it. Empty for a turn that only enters. -/
def connective (t : ExchangeTurn) : List Seg :=
  match t.relation with
  | "answers" =>
    [.text "This answers ", .party t.target, .text ": it defeats it, and ", .party t.target,
      .text " does not defeat it in return."]
  | "meets" =>
    [.party t.party, .text " and ", .party t.target,
      .text " defeat each other, so neither gives way."]
  | "standsApart" =>
    [.party t.party, .text " and ", .party t.target,
      .text " stand apart: neither defeats the other."]
  | "responds" =>
    [.text "This replies to ", .party t.target,
      .text " on a claim the two share, but neither defeats the other."]
  | "evades" =>
    let lead := "It is told as a reply, but it shares no claim with "
    let charge := ", and no meaning: it is a red herring, a reply that changes the " ++
      "subject. It is set out here to be answered"
    [.text lead, .party t.target, .text charge] ++
      (if t.answeredBy.isEmpty then [.text "."]
       else [.text " by ", .party t.answeredBy, .text "."])
  | "restates" =>
    [.text "This sets out the position of ", .party t.target,
      .text " again, with the same conclusion."]
  | "ignores" =>
    let names := (t.leftStanding.map Seg.party).intersperse (.text " and ")
    [.text "This sets out the position of ", .party t.target,
      .text " again, with the same conclusion, but it does not defeat "] ++ names ++
      [.text (", which defeated that position. That is ignoring the rebuttal: " ++
        "restating a position without answering what defeated it. It is set out here " ++
        "to be answered")] ++
      (if t.answeredBy.isEmpty then [.text "."]
       else [.text " by ", .party t.answeredBy, .text "."])
  | "concedes" =>
    [.text "This gives up what ", .party t.target, .text (" concluded (" ++
      t.targetConcludes ++ "), and says so. It concludes instead: " ++ t.concludes ++ ".")]
  | "shifts" =>
    let after : List Seg := if t.answeredEarlierBy.isEmpty then [] else
      [.text " once ", .party t.answeredEarlierBy, .text " had answered it"]
    [.text "It is told as the position of ", .party t.target,
      .text (" again, but it concludes something else. That position concluded (" ++
        t.targetConcludes ++ "), and this concludes (" ++ t.concludes ++ ")")] ++ after ++
      [.text (". That is moving the goalposts: changing what is defended once it has " ++
        "been answered. It is set out here to be answered")] ++
      (if t.answeredBy.isEmpty then [.text "."]
       else [.text " by ", .party t.answeredBy, .text "."])
  | _ => []

/-- What a turn quoting a declared fallacy says of it, in words. Empty for a
turn that quotes none. -/
def declared (t : ExchangeTurn) : List Seg :=
  if t.findings.isEmpty then [] else
  let what := String.intercalate " and " (t.findings.map ("a " ++ ·))
  let lead := "The line it quotes commits " ++ what ++
    ", and says so where it is written. It is set out here to be answered"
  if t.answeredBy.isEmpty then [.text (lead ++ ".")]
  else [.text (lead ++ " by "), .party t.answeredBy, .text "."]

/-- The parties the turns set out, in order, each once. -/
def parties (x : Exchange) : List String := (x.turns.map (·.party)).eraseDups

/-- Whether some turn already says how the two parties stand. -/
def joined (x : Exchange) (a b : String) : Bool :=
  x.turns.any fun t => !t.relation.isEmpty &&
    ((t.party == a && t.target == b) || (t.party == b && t.target == a))

/-- Above this many parties, the page sets the defeats out as a table as well
as in words. -/
def manyParties : Nat := 5

/-- How the parties of an exchange stand to one another, as a paragraph: that
they all defeat each other, or that none does, or else the defeats between the
pairs no turn has joined. Empty when the turns have already said how every pair
stands. A page with more than `manyParties` parties says how many pairs have a
defeat, and sets them out in a table. -/
def summary (x : Exchange) : List Seg :=
  let n := x.parties.length
  let defeats := x.pairs.filter fun (_, _, ab, ba) => ab || ba
  let unjoined := x.pairs.filter fun (a, b, _, _) => !x.joined a b
  if n < 2 || unjoined.isEmpty then []
  else if x.pairs.all (fun (_, _, ab, ba) => ab && ba) then
    [.text (if n == 2 then "The two positions defeat each other, so neither gives way."
      else "Each of these positions defeats every other, so none of them gives way.")]
  else if defeats.isEmpty then
    [.text (if n == 2 then "Neither position defeats the other."
      else "None of these positions defeats another.")]
  else if n > manyParties then
    [.text ("Between the " ++ toString n ++ " positions told here, " ++
      toString defeats.length ++ " of the " ++ toString x.pairs.length ++
      " pairs have a defeat, one way or both, as the table sets out.")]
  else
    let one : String × String × Bool × Bool → List Seg
      | (a, b, true, true) => [.defeat a b, .text ", and ", .defeat b a, .text "."]
      | (a, b, true, false) => [.defeat a b, .text ", and is not defeated by it."]
      | (a, b, _, _) => [.defeat b a, .text ", and is not defeated by it."]
    let found := unjoined.filter fun (_, _, ab, ba) => ab || ba
    let sentences := (found.map one).intersperse [.text " "] |>.flatten
    let rest := if found.length == unjoined.length then [] else
      [.text (if found.isEmpty then "No other pair of these positions defeats either way."
        else " No other pair defeats either way.")]
    (if found.isEmpty then [] else [.text "Of the pairs no turn has joined: "]) ++
      sentences ++ rest

end Exchange

/-- **A statement in logic notation**, as a page sets it beside its English: a
string of mathematics with the argument's claims and formulas left in, so each
rendering can number a claim as its legend does and link it there. `tex` is
mathematics as LaTeX writes it, which MathJax reads on the site too. -/
inductive Sym (α : Type) where
  /-- A claim: its variable, numbered and linked as the legend numbers it. -/
  | atom (a : α)
  /-- A formula over the claims, set as the derivations set one. -/
  | formula (φ : Formula α)
  /-- Mathematics as LaTeX writes it. -/
  | tex (s : String)
  /-- Pieces set one after another. -/
  | seq (parts : List (Sym α))

namespace Sym

/-- Every claim a statement mentions, in the order it mentions them. -/
def atoms : Sym α → List α
  | .atom a => [a]
  | .formula φ => atomsOf φ
  | .tex _ => []
  | .seq ps => ps.attach.flatMap fun ⟨p, _⟩ => atoms p

end Sym

/-- One element of a generated page.

`prose` is a module docstring, lifted whole; the rest are declarations, each
carrying its own docstring and whatever rendering its type admits. The cases
are the shapes an argument module actually declares, and `other` is the honest
fallback — a declaration the renderer has no special reading of is still
listed, with its source, rather than silently dropped. -/
inductive Item (α : Type)
  /-- Prose lifted from a module docstring. Markdown, as docstrings are. -/
  | prose (markdown : String)
  /-- A named position: its premises and its conclusion. -/
  | package (decl doc : String) (pkg : ArgumentPackage α)
  /-- A named line of reason: its grounds, its step, what it delivers. -/
  | line (decl doc : String) (l : Line α)
  /-- A named formula, usually an inference step. -/
  | formula (decl doc : String) (φ : Formula α)
  /-- A named list of formulas, usually grounds shared between lines. -/
  | formulas (decl doc : String) (φs : List (Formula α))
  /-- Who holds something, where, and how firmly: a `Source`, usually the
  rating of an inference step. -/
  | source (decl doc : String) (s : Source)
  /-- One claim's citation, written out on its own: an `AtomMeta`. -/
  | claim (decl doc : String) (m : AtomMeta)
  /-- A reading written as a valuation, usually a countermodel: each claim on
  the page, with whether the reading takes it as true. Read off the definition
  when the page is harvested, one claim at a time. -/
  | reading (decl doc : String) (truth : List (α × Bool))
  /-- A position made from a line of reason as it stands (`Line.asPackage`): the
  line it argues, by name, so the page points to the line instead of setting
  its grounds and step out a second time. -/
  | fromLine (decl doc line : String) (pkg : ArgumentPackage α)
  /-- Which position each party argues from (`Party → ArgumentPackage Claim`):
  the name of each party's position, in the order the parties are declared. -/
  | positions (decl doc : String) (names : List String)
  /-- A dispute: the names of the positions it hears, and the declaration that
  gives each party its position, if it has one by name (empty if not). -/
  | dispute (decl doc : String) (parties : List String) (node : String)
  /-- A register of dissents for a dispute: the positions it assesses as
  dissents, and the steps they are rated against. -/
  | register (decl doc : String) (assessed steps : List String)
  /-- A claim refuted by what a text reads: the claim, what the text reads, and
  its citation. -/
  | refutation (decl doc : String) (claim : α) (reads : String) (reading : Source)
  /-- Words of the Greek New Testament: where they stand, and the words. -/
  | greek (decl doc : String) (place : String) (words : List String)
  /-- A source that takes its rating where it is used (`Confidence → Source`):
  its references, read at one rating. -/
  | sourceFn (decl doc : String) (s : Source)
  /-- A named list, said as a lead sentence and its entries: the lines a
  position gathers, say. The entries are plain text. -/
  | listing (decl doc lead : String) (entries : List String)
  /-- A list of sources, each said in words. -/
  | sources (decl doc : String) (ss : List Source)
  /-- A declaration said in one plain sentence: a passage, a pinpoint. -/
  | said (decl doc text : String)
  /-- How a later text stands to an earlier one: an `IntertextEdge`. -/
  | edge (decl doc : String) (e : IntertextEdge)
  /-- A tradition's reading of a passage: an `Interpretation`, under the name of
  the criterion it serves, if it serves one (empty if not). -/
  | interpretation (decl doc criterion : String) (i : Interpretation)
  /-- One reading of a rival's ambiguous claim: its name, what it commits the
  reader to, and who reads it so. -/
  | dilemmaReading (decl doc name : String) (commits : Formula α) (s : Source)
  /-- A rule written as a table of true and false: its inputs, by name, and for
  each row of inputs whether the rule allows it. -/
  | truthTable (decl doc : String) (inputs : List String) (rows : List (List Bool × Bool))
  /-- A claim one position holds and another denies, both defensible: the names
  of the two positions, and the claim. -/
  | contested (decl doc holder denier : String) (φ : Formula α)
  /-- A helper for writing the argument down, said by its docstring alone: what
  it gives is set out where it is used. -/
  | helper (decl doc : String)
  /-- A citation function, `Claim → AtomMeta`: what it cites each claim to.
  Read off the definition when the page is harvested, one claim at a time,
  so the page shows the citations and not a function's signature. -/
  | citation (decl doc : String) (cite : α → AtomMeta)
  /-- A declaration shown as Lean: anything the renderer does not read. -/
  | other (decl doc source : String)
  /-- A result: its statement in logic notation, set beside its docstring. -/
  | result (decl doc : String) (stated : Sym α) (proposed : Bool)
  /-- Why one position stands against another: a `Because`. -/
  | because (decl doc : String) (e : Explanation α)
  /-- Every reading of a rival's claim, answered: a `Dilemma`. -/
  | dilemma (decl doc : String) (d : Dilemma α)
  /-- What an opponent must reject: an `OpponentsBurden` result, its statement
  in logic notation beside its docstring. -/
  | burden (decl doc : String) (stated : Sym α) (b : Burden)
  /-- A dispute's verdict, with the reasons generated from its witness, the
  page's `Because` declarations to link its defeats to, and the theorem that
  proves the defeat table (empty if none was found). -/
  | verdict (decl doc : String) (v : Verdict) (links : List BecauseLink) (table : String)
  /-- A dispute's graph, with the theorems proving its defeat, support and
  part-of tables (each empty if none was found). -/
  | graph (decl doc : String) (g : Graph) (defeatTable supportTable partTable : String)
  /-- A dissent, assessed under every standard: an `Assessment`. -/
  | assessed (decl doc : String) (a : Assessed)
  /-- A step's rating, computed from its register: a `RatedStep`. -/
  | rated (decl doc : String) (r : Rated)
  /-- An exchange between positions, told in order: its turns, and how each
  stands to an earlier one, as the solver finds it (`Logic.Bundle`). A defeat it
  states links to the `Because` explaining it, if the page has one. -/
  | exchange (decl doc : String) (x : Exchange) (links : List BecauseLink)

namespace Item

/-- Every atom this item mentions, in the order it mentions them. -/
def atoms [DecidableEq α] : Item α → List α
  | .package _ _ pkg => pkg.atoms
  | .fromLine _ _ _ pkg => pkg.atoms
  | .refutation _ _ a _ _ => [a]
  | .dilemmaReading _ _ _ φ _ => atomsOf φ
  | .contested _ _ _ _ φ => atomsOf φ
  | .result _ _ st _ => st.atoms
  | .burden _ _ st _ => st.atoms
  | .line _ _ l => (l.premises ++ [l.delivers]).flatMap atomsOf
  | .formula _ _ φ => atomsOf φ
  | .formulas _ _ φs => φs.flatMap atomsOf
  | .because _ _ e => (e.crux :: e.granted ++ e.core).flatMap atomsOf
  | .dilemma _ _ d =>
    atomsOf d.claim ++ d.horns.flatMap fun h =>
      atomsOf h.commits ++ h.grounds.flatMap atomsOf ++ h.fates.flatMap fun f => match f.falls with
        | some e => (e.crux :: e.granted ++ e.core).flatMap atomsOf
        | none => []
  | _ => []

end Item

/-- The atom ordering a page uses.

`allAtoms` is the atom type's own constructor order, which is the order
`Atoms.lean` declares them in and therefore the order its prose groups them by.
The page keeps that order and drops what it does not mention, so the legend
reads as the source reads. An atom mentioned but not listed — which would mean
the caller passed something other than the constructors — is kept at the end
rather than silently dropped. -/
def atomOrder [DecidableEq α] (allAtoms : List α) (items : List (Item α)) : List α :=
  let mentioned := (items.flatMap Item.atoms).eraseDups
  allAtoms.filter (mentioned.contains ·) ++ mentioned.filter (!allAtoms.contains ·)

/-- How a later text stands to an earlier one, in words. -/
def relationWords : RelationType → String
  | .quotation => "quotes"
  | .allusion => "alludes to"
  | .echo => "echoes"
  | .typology => "reads as a type fulfilled"
  | .promise => "takes up the promise of"
  | .prediction => "reads as fulfilling the prediction of"
  | .messianicTheme => "takes up the royal, messianic motif of"
  | .retrospective => "reinterprets"
  | .thematic => "shares a theme, with no direct dependence, with"

/-- How a reading construes its passage, in words. -/
def asRelationWords : RelationType → String
  | .quotation => "a text quoted later"
  | .allusion => "a text alluded to later"
  | .echo => "a text echoed later"
  | .typology => "a type, fulfilled later"
  | .promise => "a promise, taken up later"
  | .prediction => "a prediction"
  | .messianicTheme => "a royal, messianic motif"
  | .retrospective => "a text reinterpreted later"
  | .thematic => "a theme shared with later texts"

/-- Whether two citations say the same thing: the same claim, of the same kind,
held in the same tradition, as firmly, on the same references. Compared as the
values print, because a citation's types derive no equality. -/
def sameCitation (m₁ m₂ : AtomMeta) : Bool :=
  toString (repr m₁) == toString (repr m₂)

/-- **What a citation function says differently from the legend.** The claims
on the page, in the page's order, that `cite` cites otherwise than `legend`
does, each with its citation under `cite`. A function that agrees with the
legend on every claim on the page gives nothing. -/
def citedOtherwise (order : List α) (legend cite : α → AtomMeta) : List (α × AtomMeta) :=
  (order.filter fun a => !sameCitation (cite a) (legend a)).map fun a => (a, cite a)

/-- The `cite` of the first package on the page.

Every package in an argument shares one `cite` — it is what makes the atom
type's claims a single manifest rather than a per-package one — so the first
package's is the argument's. An argument with no package has nothing to legend,
and cannot occur: rule L5 requires at least two. -/
def citeOf : List (Item α) → Option (α → AtomMeta)
  | [] => none
  | .package _ _ pkg :: _ => some pkg.cite
  | .fromLine _ _ _ pkg :: _ => some pkg.cite
  | _ :: rest => citeOf rest

end Testimony.Logic.Page
