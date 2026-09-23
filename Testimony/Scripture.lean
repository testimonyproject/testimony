import Testimony.Provenance
import Testimony.Bib.Works
import Mathlib.Tactic.Linter.Style

/-!
# Testimony.Scripture — the passages and citation bundles arguments share

Arguments overlap in the texts they read. Micah 5:2–3 carries the Bethlehem
oracle in `BornInBethlehem` and the maternal reference in `BornOfAVirgin`;
the infancy narratives ground the historical premise in both; Isaiah 7:14 is
cited in four textual traditions across one module. Spelled out at each use
site, that is the same `⟨.micah, 5, 2⟩` written in several places, and a
typo in one of them is a citation of a different verse that still compiles.

So the passages live here once, and so do the **bundles**: a named
`List ScriptureCitation` for a group of verses that travel together, such as
the two infancy narratives or the pair of Genesis verses that call Rebekah both
עַלְמָה and בְּתוּלָה. A bundle is a clique in the citation graph, and naming it
means an argument cites the *evidence* rather than assembling it.

Bundles are values, so an argument may use one as it stands, extend it, or take
it apart. Nothing here decides what a passage shows; that is the argument's
business. This module only fixes what is being pointed at.

Section headings group passages by the dispute they belong to, which is also
how the arguments import them.
-/

namespace Testimony.Scripture

open Testimony Testimony.Bib

/-! ### Building citations

Two helpers for the cases where a citation has to name its text-form — the
Septuagint's παρθένος against the Masoretic עַלְמָה, the Targum's עוּלֵימְתָא. Where
the text-form does not matter, the record literal is short enough to write. -/

/-- A single verse, in the textual tradition the claim is about. -/
def verseIn (t : TextualTradition) (v : Passage) : ScriptureCitation :=
  { ref := .verse v, tradition := some t }

/-- A range of verses, in the textual tradition the claim is about. -/
def rangeIn (t : TextualTradition) (r : Pericope) : ScriptureCitation :=
  { ref := .range r, tradition := some t }

/-! ### The protoevangelium -/

/-- Genesis 3:15 — the protoevangelium, and the "seed of the woman". -/
@[nolint defsWithUnderscore] def genesis3_15 : Passage := ⟨.genesis, 3, 15⟩

/-! ### The Isaianic sign -/

/-- Isaiah 7:14 — the sign of the *almah* who conceives and bears a son. -/
@[nolint defsWithUnderscore] def isaiah7_14 : Passage := ⟨.isaiah, 7, 14⟩

/-- Isaiah 2:1–4 and 11:1–12:6 — the eschatological frame of Isaiah 2–12,
within which Isaiah 7 sits. Postell's compositional premise cites the frame,
not either end of it. -/
def isaiah2to12Frame : List ScriptureCitation :=
  [ { ref := .range ⟨.isaiah, 2, 1, 2, 4⟩ }
  , { ref := .range ⟨.isaiah, 11, 1, 12, 6⟩ } ]

/-- Isaiah 7:13–14 and 7:16 — the sign given to the house of David in the plural,
and the singular "you" of the verse addressed to Ahaz. -/
def immanuelAddressees : List ScriptureCitation :=
  [ rangeIn .masoretic ⟨.isaiah, 7, 13, 7, 14⟩
  , verseIn .masoretic ⟨.isaiah, 7, 16⟩ ]

/-- Isaiah 7:16 and 8:4 — the same timetable, given first to the child of 7:14
and then to Maher-shalal-hash-baz. -/
def sharedTimetable : List ScriptureCitation :=
  [ verseIn .masoretic ⟨.isaiah, 7, 16⟩
  , verseIn .masoretic ⟨.isaiah, 8, 4⟩ ]

/-- Isaiah 8:7–8, 9:8–11 and 10:5 — the Assyrian invasion, the oppressor's
rod. The near-term timeline that Isaiah 7, 9 and 11 share, which is what
Postell's parity argument turns on. -/
def assyrianTimeline : List ScriptureCitation :=
  [ { ref := .range ⟨.isaiah, 8, 7, 8, 8⟩ }
  , { ref := .range ⟨.isaiah, 9, 8, 9, 11⟩ }
  , { ref := .verse ⟨.isaiah, 10, 5⟩ } ]

/-- Genesis 24:43 and 24:16 — Rebekah as עַלְמָה and as בְּתוּלָה "whom no man had
known", the same woman under both terms.

The pair is the whole of the evidence that virginity is compatible with the
denotation of עַלְמָה, and neither side of the lexical dispute contests it. Cited
to the Masoretic Text, since the claim is about the Hebrew. -/
def rebekahAlmahAndBetulah : List ScriptureCitation :=
  [ verseIn .masoretic ⟨.genesis, 24, 43⟩
  , verseIn .masoretic ⟨.genesis, 24, 16⟩ ]

/-- Genesis 24:43 and Song 6:8 — the two passages besides Isaiah 7:14 that
Wegner calls the clearest evidence for the sense of עַלְמָה.

Cited together because the parity reply needs them together: if one clear
referent settled the word's denotation, these two would settle it for
virginity. Masoretic, since the claim is about the Hebrew. -/
def clearAlmahPassages : List ScriptureCitation :=
  [ verseIn .masoretic ⟨.genesis, 24, 43⟩
  , verseIn .masoretic ⟨.songOfSongs, 6, 8⟩ ]

/-! ### The Bethlehem oracle -/

/-- Micah 5:2 — the prophecy of a ruler from Bethlehem Ephrathah. -/
@[nolint defsWithUnderscore] def micah5_2 : Passage := ⟨.micah, 5, 2⟩

/-- Micah 5:3 — "until the time when she who is in labour has given birth". -/
@[nolint defsWithUnderscore] def micah5_3 : Passage := ⟨.micah, 5, 3⟩

/-- Micah 5:2–3 as a unit: the ruler from Bethlehem and the woman in labour.
The two arguments that read this oracle read different halves of it, and the
maternal reference only means what `BornOfAVirgin` needs it to mean if the two
verses are taken together. -/
@[nolint defsWithUnderscore] def micah5_2to3 : Pericope := ⟨.micah, 5, 2, 5, 3⟩

/-! ### The infancy narratives -/

/-- Matthew 1:23 — Matthew's citation of Isaiah 7:14 via the Septuagint. -/
@[nolint defsWithUnderscore] def matthew1_23 : Passage := ⟨.matthew, 1, 23⟩

/-- Luke 1:31 — Gabriel to Mary: "you will conceive in your womb and bear a son,
and you shall call his name Jesus". Close in wording to Isaiah 7:14 in the
Septuagint, and to the announcement to Hagar. -/
@[nolint defsWithUnderscore] def luke1_31 : Passage := ⟨.luke, 1, 31⟩

/-- Genesis 16:11 — the announcement to Hagar of the birth of Ishmael, the
earliest instance of the birth-announcement form. -/
@[nolint defsWithUnderscore] def genesis16_11 : Passage := ⟨.genesis, 16, 11⟩

/-- Matthew 2:6 — Matthew's citation of Micah 5:2. -/
@[nolint defsWithUnderscore] def matthew2_6 : Passage := ⟨.matthew, 2, 6⟩

/-- Matthew 1:18–25 and Luke 1:26–38 — the two virgin-conception narratives.

They agree on the conception while differing in nearly every other detail,
which is the multiple-attestation premise; their independence is separately
disputed. -/
def virginConceptionNarratives : List ScriptureCitation :=
  [ { ref := .range ⟨.matthew, 1, 18, 1, 25⟩ }
  , { ref := .range ⟨.luke, 1, 26, 1, 38⟩ } ]

/-- Matthew 1:18 and Luke 1:27 — the betrothal notices, which is all either
narrative says about Mary's age and status at the conception. -/
def betrothalNotices : List ScriptureCitation :=
  [ { ref := .verse ⟨.matthew, 1, 18⟩ }
  , { ref := .verse ⟨.luke, 1, 27⟩ } ]

/-- Matthew 2:1 and Luke 2:4–7 — the two notices of a birth at Bethlehem, and
the only evidence for it. -/
def bethlehemBirthNarratives : List ScriptureCitation :=
  [ { ref := .verse ⟨.matthew, 2, 1⟩ }
  , { ref := .range ⟨.luke, 2, 4, 2, 7⟩ } ]

/-! ### Faith, works and the word

The prooftexts of the two Reformation arguments. Luke 7:50 and James 2 recur
across `SolaFide`; the rest are cited once each but belong with them. -/

/-- Luke 7:50 — "your faith has saved you", said to the woman who anointed
Jesus. -/
@[nolint defsWithUnderscore] def luke7_50 : Passage := ⟨.luke, 7, 50⟩

/-- Luke 7:47–50 — the saying in its context, following the declaration that
her sins are forgiven rather than a healing. This is what makes 7:50 the strong
case for the soteriological sense of σῴζω. -/
@[nolint defsWithUnderscore] def luke7_47to50 : Pericope := ⟨.luke, 7, 47, 7, 50⟩

/-- James 2:14 — the opening of the passage on faith and works. -/
@[nolint defsWithUnderscore] def james2_14 : Passage := ⟨.james, 2, 14⟩

/-- James 2:19 — "even the demons believe, and shudder": the barren faith that
is James's target. -/
@[nolint defsWithUnderscore] def james2_19 : Passage := ⟨.james, 2, 19⟩

/-- James 2:24 — "a person is justified by works and not by faith alone", the
only occurrence of *faith alone* in the New Testament. -/
@[nolint defsWithUnderscore] def james2_24 : Passage := ⟨.james, 2, 24⟩

/-! ### Source helpers

A `Source` written out is four fields, and some combinations recur often enough
that writing them out is repetition rather than precision. -/

/-- What the Greek text of a New Testament verse reads, on the authority of
the NA28 apparatus with UBS5 in support.

Both fulfilment arguments make this claim about the verse where Matthew quotes
his prophet, and the two intertextual edges make it again. It is the least
disputed kind of premise in the library — `consensus`, and cited to critical
scholarship rather than to any confession. -/
def na28Apparatus (v : Passage) : Source :=
  { primary := .work na28 (.apparatus v)
  , supporting := [.work ubs5 .whole]
  , tradition := .criticalScholarship
  , confidence := .consensus }

/-- A claim held on the authority of Calvin's *Institutes*, at a given
book-chapter-section.

Both Reformation arguments rest most of their theological premises here, and
they differ only in how firmly. `confidence` defaults to `wellSupported` and is
passed explicitly where the Reformed tradition itself treats the claim as
contested — which, for every premise `SolaScriptura` takes from Calvin, it
does. -/
def calvinHolds (loc : String) (confidence : Confidence := .wellSupported) : Source :=
  { primary := .work calvinInstitutes (.sectionRef loc)
  , tradition := .reformedProtestant
  , confidence := confidence }

/-- A claim grounded in scripture, with Calvin's *Institutes* in support at a
given book-chapter-section.

Both Reformation arguments read their prooftexts through Calvin, and both
formerly carried a private copy of this function. -/
def scriptureWithCalvin (refs : List ScriptureCitation) (loc : String) : Source :=
  { primary := .scripture refs
  , supporting := [.work calvinInstitutes (.sectionRef loc)]
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

end Testimony.Scripture
