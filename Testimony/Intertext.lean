import Testimony.Text
import Testimony.Provenance

/-!
# Testimony.Intertext — Layer 3: typed intertextual relations

The library never collapses "this NT text quotes that OT text" into
"this OT text predicted Jesus". Those are different claims; they get
different types.
-/

namespace Testimony

/-- The kind of relationship between two passages. Distinctions matter:
much of the Messianic-prophecy debate is precisely about which of these a
given link is. -/
inductive RelationType
  /-- Explicit verbal citation. -/
  | quotation
  /-- Probable intentional reference, not verbatim. -/
  | allusion
  /-- Faint verbal or thematic resonance. -/
  | echo
  /-- Pattern and antitype correspondence. -/
  | typology
  /-- A covenant promise taken up later. -/
  | promise
  /-- Forward-looking prophecy in the original author's intent. The most
  contested classification, and the one most arguments turn on. -/
  | prediction
  /-- A royal or messianic motif. -/
  | messianicTheme
  /-- A later text reinterpreting an earlier one. -/
  | retrospective
  /-- Shared theme without direct dependence. -/
  | thematic
deriving Repr, DecidableEq

/-- A directed intertextual edge with provenance. `source` cites who claims
this relation holds, with what confidence. -/
structure IntertextEdge where
  /-- The later, citing text. -/
  fromPassage : Passage
  /-- The earlier, cited text. -/
  toPassage : Passage
  /-- How the two are related. -/
  relation : RelationType
  /-- Who claims this relation holds, and with what confidence. -/
  source : Source
deriving Repr

/-- An interpretation: a tradition's reading of what a passage claims. -/
structure Interpretation where
  /-- The passage being interpreted. -/
  passage : Passage
  /-- Prose summary of the reading. -/
  reading : String
  /-- How the reading construes the passage's intertextual role, if at all. -/
  asRelation : Option RelationType
  /-- Whose reading this is. -/
  source : Source
deriving Repr

end Testimony
