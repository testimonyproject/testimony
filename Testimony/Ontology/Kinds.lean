import Testimony.Semantics.Upper
import Testimony.Semantics.Vocabulary

/-!
# What kind of thing each concept is

**A draft article.** The vocabulary's concepts were added as claims needed
them, with nothing to say what kind of thing each one names. This article gives
each a category from the upper ontology the vocabulary is aligned to — DOLCE's,
with BFO's counterpart beside it (`Testimony.Semantics.Upper`) — where every
party would grant it: the death of Christ is an event, Scripture is a text, a
rule of faith is a role some text or office plays.

Where a party would not grant it, the concept is left without a category, and
this article says why. These are not gaps in the work. They are the points where
an upper ontology, built to describe the world without taking sides, meets a
question the confessions answer differently — and an ontology that assigned the
category would have answered it for them.

## Left without a category, and why

- **God.** An upper ontology sorts creatures. Classical theism holds that God is
  in no genus at all: Aquinas asks "whether God is contained in a genus" and
  answers that he is not (*Summa Theologiae* I, q. 3, a. 5). To give God a
  category would be to deny that, before any argument is heard. The same holds
  of **the Spirit**, so far as the concept names the Spirit himself; so far as
  it names his gift, its category turns on the next question.
- **Grace.** Is grace God's favour toward a person, or a gift inhering in the
  soul? The Reformation took it as favour — Calvin explains justification as
  God's acceptance of us into his favour (*Institutes* III.xi.2) — and Trent
  anathematised the claim that "the grace, whereby we are justified, is only
  the favour of God" (Session VI, canon 11). As favour it is
  a relation, or a disposition of God; as an inhering gift, a quality of the
  soul. The category is the dispute.
- **Faith.** Trust that receives, or a virtue formed by charity? The sola fide
  argument reads John 6:29's believing both ways, as trust and as faith formed
  by charity. As an act it is an event; as a habit, a quality.
- **Justification.** An act, or a process that grows? The Reformed hold that
  justification is forensic only — the remission of sins and not sanctification
  — and Trent that it includes sanctification and increases by works done in
  grace. The sola fide argument turns on exactly this, and those claims
  exclude each other there by their meaning. To call justification an event
  would decide for the one; a process, for the other.
- **Salvation** and **eternal life.** Each is used, in the claims, of the entry
  into life and of the life entered — an event and a state — and the claims do
  not choose.
- **The word of God** names a different thing as each party uses the phrase:
  Scripture, or Scripture and Tradition, or Christ. Its category waits on which.
- **Tradition** is read both as what is handed on and as the handing on — the
  sola scriptura argument reads Trent's word both ways: a content, or an
  occurrence.
-/

namespace Testimony.Ontology.Kinds

open Testimony.Semantics

/-- **What kind of thing each concept names**, where every party would grant it;
`none` where the category is in dispute, for the reason the module docstring
gives. -/
def category : Concept → Option Category
  | .justification => none
  | .salvation => none
  | .sanctification => some .process
  | .faith => none
  | .works => some .event
  | .worksOfFaith => some .event
  | .grace => none
  | .forgiveness => some .event
  | .christsDeath => some .event
  | .baptism => some .event
  | .desireForBaptism => some .state
  | .spirit => none
  | .law => some .socialObject
  | .circumcision => some .event
  | .charity => some .quality
  | .eternalLife => none
  | .god => none
  | .scripture => some .informationObject
  | .gospel => some .informationObject
  | .increaseOfJustification => some .process
  | .covenant => some .socialObject
  | .cleansing => some .event
  | .infallible => some .quality
  | .ruleOfFaith => some .role
  | .otherRuleOfFaith => some .role
  | .wordOfGod => none
  | .tradition => none
  | .commandmentsOfMen => some .informationObject
  | .creedalConsensus => some .informationObject
  | .clearSenseOfScripture => some .informationObject
  | .readingScripture => some .event
  | .magisterium => some .agent
  | .controversiesOfReligion => some .informationObject
  | .messiahsBirth => some .event
  | .birthWithoutHumanFather => some .event
  | .virginity => some .quality
  | .christBaptizingInTheSpirit => some .event
  | .spiritBaptizingIntoTheBody => some .event
  | .actsSpiritEpisodes => some .event
  | .patternForBelievers => some .role
  | .unrepeatableTransition => some .event
  | .minutes _ => some .temporalRegion

/-- The concepts whose category is in dispute: each named in the module
docstring with its reason. -/
def disputed : List Concept :=
  [ .justification, .salvation, .faith, .grace, .spirit, .eternalLife, .god, .wordOfGod
  , .tradition ]

/-- **The disputed concepts are exactly those left without a category.** Every
other concept the vocabulary has is given one; and each of these is left
without, so that no category decides a question the confessions answer
differently. -/
theorem disputed_have_no_category : ∀ c ∈ disputed, category c = none := by
  decide

/-- **Increase of justification is a process, as Trent's own concept.** It is
Trent's: the concept is of justification growing, and a reader who denies that
justification grows denies that there is any such thing, rather than giving it
another category. So the category is not in dispute, though the concept is. -/
theorem increase_is_a_process : category .increaseOfJustification = some .process := rfl

end Testimony.Ontology.Kinds
