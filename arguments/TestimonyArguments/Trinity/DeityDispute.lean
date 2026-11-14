import TestimonyArguments.Trinity.Deity
import Testimony.Logic.Declare

/-!
# TestimonyArguments.Trinity.DeityDispute — the three positions weighed

Six positions are parties to one dispute. Three are the positions of the last
chapter: LST, for one God in three persons; the Jehovah's Witnesses, for whom the
Son is "a god" and a creature and the holy spirit God's force; and the Oneness
position, for which Father, Son and Spirit are one person. The other three are
LST's lines taken one at a time, so that a reader can see which of LST's claims
each rival denies: that the Word is God, that the Spirit is God, and that there
are three persons.

## How to read the verdicts

One position *defeats* another when it denies something the other holds or
derives, unless the other is better supported. A position is only as strong as
its weakest premise or step, rated on four levels: `disputed`, the lowest, then
`plausible`, `wellSupported` and `consensus`. Every position here rests on at
least one reading rated `disputed`, so when two positions deny each other each
defeats the other, and that is a tie. A position is *forced* when it is accepted
however the ties are settled. It *can be defended* when some group of positions,
none defeating another and together answering every attack on them, includes it;
it is *not forced* when another such group leaves it out. Every defeat is
computed from the positions' premises, and Lean checks each computation.

## What the weighing found

The ties fall along the two questions. The Witnesses tie with every other
position, because they deny that the Word is God, which LST and the Oneness
position both hold; that the Spirit is God, which LST's second line holds; and
that the Spirit is a person, which its third line holds.
The Oneness position ties with LST, and with LST's third line, over three persons.
It does not tie with LST's first two lines, because it holds them: on the Word and
the Spirit, Oneness and LST stand together (`oneness_stands_with_the_deity`).

So nothing is forced (`deity_forces_nothing`). LST's position can be defended,
and the Oneness position, holding LST's first two lines, leaves it out
(`lst_deity_defensible`, `lst_deity_not_forced`). The Witnesses' position can be
defended on its own, and LST's leaves it out (`witnesses_defensible`,
`witnesses_not_forced`). The Oneness position can be defended, and LST's leaves
it out too (`oneness_defensible`, `oneness_not_forced`). That the Word is God
can be defended, held by LST's position and by the Oneness position alike, and
it is not forced, because the Witnesses' position stands against it
(`word_deity_defensible`, `word_deity_not_forced`).

The weighing does not favour LST. Nor does it find the three readings of John 1:1
equally good, or the question idle. It cannot choose between them, because each
reading that divides the parties is rated `disputed`: Harner's reading of "God"
(θεός) in John 1:1 against the brochure's "a god"; Augustine's reading of John 1:3
against the Witnesses' reading of Colossians 1:15; Calvin's reading of Acts 5:3–4,
and LST's reading of the Spirit as a person, against the brochure's "active
force"; and LST's readings of "with God" and of Matthew 28:19 against Bernard's.

Since a position is only as strong as its weakest reading, one better-supported
reading changes nothing where a position rests on several. LST rests on six, and
two of its steps are rated `disputed` too. The Spirit line rests on one reading,
Calvin's, and its step is rated `wellSupported`, so it is where a single new,
cited argument could matter. The texts this dispute does not hear, listed in the
last chapter, are where such an argument would be looked for.
-/

namespace TestimonyArguments.Trinity

open Testimony

open Testimony Testimony.Logic Testimony.Logic.Framework

/-- The parties to the dispute over the deity and the persons. -/
inductive DeityParty
  /-- One God, three persons: LST. -/
  | lst
  /-- The Word is God, LST's first line on its own. -/
  | word
  /-- The Spirit is God, LST's second line on its own. -/
  | spirit
  /-- Three persons, LST's third line on its own. -/
  | persons
  /-- A god and a creature; a force: Jehovah's Witnesses. -/
  | witnesses
  /-- One God, one person: Oneness. -/
  | oneness
deriving DecidableEq

/-- The package each party argues from. -/
@[trinityDefs]
def deityPartyNode : DeityParty → ArgumentPackage Claim
  | .lst => lstDeityCase
  | .word => wordCase
  | .spirit => spiritCase
  | .persons => personsCase
  | .witnesses => witnessesCase
  | .oneness => onenessCase

/-- The dispute over the deity and the persons: every party can be held without
contradiction, delivers its conclusion, and has its steps rated. -/
declare_dispute deityDispute := deityPartyNode using trinityDefs
  /-- **Who defeats whom**, all 36 pairs, each checked by Lean. The Witnesses and
  every other position defeat each other: they deny that the Word is God, which
  LST, its first line and the Oneness position hold; that the Spirit is God,
  which its second line holds; and that the Spirit is a person, which its third
  line holds. The Oneness position and LST defeat each other over three persons,
  and so do the Oneness position and LST's third line. Nothing else. -/
  defeats
    [ (.lst, .witnesses), (.witnesses, .lst), (.lst, .oneness), (.oneness, .lst)
    , (.word, .witnesses), (.witnesses, .word), (.spirit, .witnesses), (.witnesses, .spirit)
    , (.persons, .witnesses), (.witnesses, .persons)
    , (.persons, .oneness), (.oneness, .persons)
    , (.witnesses, .oneness), (.oneness, .witnesses) ]
  /-- **Nothing supports anything**, in all 36 pairs: no party's conclusion is a
  premise another party states. Each pair is checked by Lean. -/
  supports []
  /-- **LST's first two lines are part of the Oneness case as well as LST's**, and
  its third is part of LST's alone. Otherwise each case is part of its own only.
  Each pair is checked by Lean. -/
  partOf [(.word, .lst), (.word, .oneness), (.spirit, .lst), (.spirit, .oneness), (.persons, .lst)]
  /-- The dispute over the deity and the persons drawn: who defeats whom, and
  whose case is part of whose. -/
  map deityMap

/-- **LST stands with each of its lines**: the Nicene reading satisfies all four. -/
theorem lst_stands_with_its_lines :
    deityDispute.StandTogether [.lst, .word, .spirit, .persons] := by
  satisfied_by nicenReading [Dispute.StandTogether, trinityDefs]

/-- **The Oneness position stands with LST's first two lines**: the Oneness
reading satisfies all three. On the Word and the Spirit, Oneness and LST agree. -/
theorem oneness_stands_with_the_deity :
    deityDispute.StandTogether [.oneness, .word, .spirit] := by
  satisfied_by onenessReading [Dispute.StandTogether, trinityDefs]

/-! ### What the dispute decides -/

/-- Every position is defeated by another, so none stands unchallenged. The
Witnesses defeat LST and each of its lines; LST defeats the Witnesses and the
Oneness position. -/
declare_verdict deitySettlesNothing for deityDispute :
    .nothingGrounded
      [ (.lst, .witnesses), (.word, .witnesses), (.spirit, .witnesses)
      , (.persons, .witnesses), (.witnesses, .lst), (.oneness, .lst) ]
  /-- **Nothing is forced.** Every position ties with another, and since every one
  rests on a reading rated `disputed`, no rating breaks a tie. This finds the
  weighing unable to choose between readings rated alike; it does not find them
  equally good, or the question idle. -/
  proves @[headline] deity_forces_nothing

#print axioms deity_forces_nothing

/-- Why LST can be defended: with its three lines, it answers the Witnesses and
the Oneness position itself. -/
declare_verdict lstWithItsLines for deityDispute :
    .credulous .lst [.lst, .word, .spirit, .persons]
  /-- **LST's position can be defended**, with each of its lines: there is a
  largest group of positions that can be defended together, one no other party
  can join, and it holds all four. -/
  proves @[headline] lst_deity_defensible

#print axioms lst_deity_defensible

/-- Why LST is not forced: a defensible position holds the Oneness position, and
it defeats LST. -/
declare_verdict lstAnsweredByOneness for deityDispute :
    .notSkeptical .lst .oneness [.oneness, .word, .spirit]
  /-- **LST's position is not forced.** The Oneness position and LST's first two
  lines can be defended as a group, and no such group can also hold LST's. -/
  proves @[headline] lst_deity_not_forced

#print axioms lst_deity_not_forced

/-- Why the Word's deity can be defended: LST's position holds it, and answers its
one attacker, the Witnesses. -/
declare_verdict wordWithLst for deityDispute :
    .credulous .word [.lst, .word, .spirit, .persons]
  /-- **That the Word is God can be defended**, with LST's position. The Oneness
  position defends it too (`oneness_defensible`, with the Word's line). -/
  proves @[headline] word_deity_defensible

#print axioms word_deity_defensible

/-- Why the Word's deity is not forced: the Witnesses' position is defensible on
its own, and defeats it. -/
declare_verdict wordAnsweredByTheWitnesses for deityDispute :
    .notSkeptical .word .witnesses [.witnesses]
  /-- **That the Word is God is not forced.** The Witnesses' position can be
  defended on its own, and it denies that the Word is God. -/
  proves @[headline] word_deity_not_forced

#print axioms word_deity_not_forced

/-- Why the Witnesses can be defended: their position answers every attacker
itself. -/
declare_verdict witnessesAlone for deityDispute : .credulous .witnesses [.witnesses]
  /-- **The Witnesses' position can be defended**, on its own. -/
  proves @[headline] witnesses_defensible

#print axioms witnesses_defensible

/-- Why the Witnesses are not forced: LST's position is defensible, and defeats
theirs. -/
declare_verdict witnessesAnsweredByLst for deityDispute :
    .notSkeptical .witnesses .lst [.lst, .word, .spirit, .persons]
  /-- **The Witnesses' position is not forced.** LST's position, with its three
  lines, can be defended as a group, and no such group can also hold the
  Witnesses'. -/
  proves @[headline] witnesses_not_forced

#print axioms witnesses_not_forced

/-- Why the Oneness position can be defended: with LST's first two lines, it
answers the Witnesses, LST, and LST's third line itself. -/
declare_verdict onenessWithTheDeity for deityDispute :
    .credulous .oneness [.oneness, .word, .spirit]
  /-- **The Oneness position can be defended**, with LST's first two lines. -/
  proves @[headline] oneness_defensible

#print axioms oneness_defensible

/-- Why the Oneness position is not forced: LST's position is defensible, and
defeats it. -/
declare_verdict onenessAnsweredByLst for deityDispute :
    .notSkeptical .oneness .lst [.lst, .word, .spirit, .persons]
  /-- **The Oneness position is not forced.** The same group of LST and its lines
  leaves it out. -/
  proves @[headline] oneness_not_forced

#print axioms oneness_not_forced

end TestimonyArguments.Trinity
