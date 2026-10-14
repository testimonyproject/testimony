/-!
# Testimony.Semantics.Upper — what kind of thing a term names

The vocabulary's concepts were added one at a time, as claims needed them, with
nothing to say what kind of thing each is. A doctrine, a rite, a text, a
person's role and a length of time were all simply "concepts", so nothing could
check that a claim relates things of the kinds its relation is about, and
nothing could say that two concepts are kinds of the same thing.

The categories below are an **upper ontology**'s, not the library's own. They
are DOLCE's (Borgo et al. 2022), the top-level ontology built to follow the
distinctions natural language and cognition draw — enduring things and
occurrences, qualities, roles, descriptions — which is how texts and their
readers speak. Each names its counterpart in Basic Formal Ontology (Arp, Smith
and Spear 2015), the other top-level ontology standardised in ISO/IEC 21838,
where BFO has one; where it has none, the docstring says so, and why. Only the
categories a claim in the library needs are here; DOLCE has more.

What kind of thing each concept is, is not settled here. It is argued in an
article (`Testimony.Ontology.Kinds`), because for some concepts the category is
the dispute: whether justification is an act or a process is what the
Reformation and Trent disagree about.
-/

namespace Testimony.Semantics

/-- **The upper categories**, DOLCE's, each with its BFO counterpart. -/
inductive Category
  /-- A person, or a body that acts: an apostle, a council, a witness. DOLCE's
  *agentive physical object* or *agentive social object*; in BFO, a person is
  an *object*, and a body of persons an *object aggregate*. -/
  | agent
  /-- A thing with a body that does not act: water, a store, a pan of grits.
  DOLCE's *non-agentive physical object*; BFO's *object*. -/
  | physicalObject
  /-- A thing that exists because a community holds it: a law, a covenant, an
  office. DOLCE's *non-agentive social object*. BFO has no social objects; its
  nearest kin is a *generically dependent continuant*. -/
  | socialObject
  /-- A content that can be written, spoken or copied without becoming another:
  a text, a message, a creed, a testimony. DOLCE's *information object*, in its
  extension for descriptions and situations; BFO's *generically dependent
  continuant*, the class the Information Artifact Ontology's *information
  content entity* belongs to. -/
  | informationObject
  /-- An occurrence that comes to an end: a birth, a baptism, an entering, a
  death. DOLCE's *event* (an accomplishment or an achievement); BFO's *process*,
  or *process boundary* for one without duration. -/
  | event
  /-- An occurrence that goes on, of which any part is the same kind of
  occurrence: a renewal, a cooking. DOLCE's *process*; BFO's *process*, which
  draws no line between this and an event. -/
  | process
  /-- How something is for a while, without anything happening: being in a
  state of life. DOLCE's *state*. BFO has no states; it speaks of the
  qualities or dispositions an entity has. -/
  | state
  /-- A feature a thing has: infallibility, virginity, a virtue. DOLCE's
  *quality*; BFO's *quality*, or *disposition* for a feature that is a
  tendency. -/
  | quality
  /-- What a thing is or does in a setting, which another thing could be or do
  instead: a rule of faith, a pattern for believers, a witness on the stand.
  DOLCE's *role*, in its extension for descriptions and situations; BFO's
  *role*. -/
  | role
  /-- A length or stretch of time: five minutes, twenty minutes. DOLCE's
  *temporal region*, an abstract region measuring time; BFO's *temporal
  region*, which is itself an occurrent. -/
  | temporalRegion
deriving DecidableEq, Repr

namespace Category

/-- The category's name in DOLCE. -/
def dolce : Category → String
  | .agent => "agentive physical or social object"
  | .physicalObject => "non-agentive physical object"
  | .socialObject => "non-agentive social object"
  | .informationObject => "information object"
  | .event => "event"
  | .process => "process"
  | .state => "state"
  | .quality => "quality"
  | .role => "role"
  | .temporalRegion => "temporal region"

/-- The category's counterpart in BFO, where it has one. -/
def bfo : Category → Option String
  | .agent => some "object (a person), or object aggregate (a body of persons)"
  | .physicalObject => some "object"
  | .socialObject => none
  | .informationObject => some "generically dependent continuant"
  | .event => some "process, or process boundary"
  | .process => some "process"
  | .state => none
  | .quality => some "quality, or disposition"
  | .role => some "role"
  | .temporalRegion => some "temporal region"

/-- Whether the category is of occurrences, which happen, rather than of things,
which endure: DOLCE's *perdurants*. (BFO's *occurrents* include temporal regions
as well; DOLCE counts them abstract.) -/
def occurs : Category → Bool
  | .event | .process | .state => true
  | _ => false

end Category

end Testimony.Semantics
