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
  | quotation        -- explicit verbal citation
  | allusion         -- probable intentional reference, not verbatim
  | echo             -- faint verbal/thematic resonance
  | typology         -- pattern/antitype correspondence
  | promise          -- covenant promise taken up later
  | prediction       -- forward-looking prophecy in original intent
  | messianicTheme   -- royal/messianic motif
  | retrospective    -- later text reinterprets earlier text
  | thematic         -- shared theme without direct dependence
deriving Repr, DecidableEq

/-- A directed intertextual edge with provenance. `source` cites who claims
this relation holds, with what confidence. -/
structure IntertextEdge where
  fromPassage : Passage      -- the later/citing text
  toPassage : Passage        -- the earlier/cited text
  relation : RelationType
  source : Source
deriving Repr

/-- An interpretation: a tradition's reading of what a passage claims. -/
structure Interpretation where
  passage : Passage
  reading : String           -- prose summary of the interpretation
  asRelation : Option RelationType  -- how it construes the intertextual role
  source : Source
deriving Repr

end Testimony
