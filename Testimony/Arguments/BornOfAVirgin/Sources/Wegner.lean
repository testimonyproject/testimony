import Testimony.Arguments.BornOfAVirgin.Atoms

/-!
# Arguments.BornOfAVirgin.Sources.Wegner — the citations of the sign dispute

The atoms of the dispute over Wegner's objection, cited here and dispatched from
`cite` by name. They are the parse of הָרָה, the pregnancy it reports, what that
pregnancy is taken to show, and the fathers' sign argument against it with the
near-term reply to that.

They sit apart because `cite` is one total function over every atom. It keeps
that guarantee: each value below is reached from exactly one of its cases, so an
atom still cannot go uncited. What moves is only where the citation is written,
which keeps `Sources.lean` short enough to read.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- `harahIsPredicateAdjective`. Deliberately not the contested step, and granted
throughout. Wegner puts it at "most likely" and cites Williams' grammar §75;
Rydelnik parses the clause exactly the same way and draws the opposite conclusion
from it, that the virgin *is* pregnant and the sign is therefore as deep as Sheol
(Isa 7:11). -/
def harahIsPredicateAdjectiveCited : AtomMeta :=
  { label := "הָרָה at Isaiah 7:14 is a predicate adjective: the עַלְמָה is pregnant"
  , kind := .linguistic
  , source :=
      { wegnerOnAlmah (.page 471) .wellSupported with
        supporting :=
          [ .work postellIsaiahMessianic (.page 474)
          , .work youngImmanuelProphecy (.pages 115 116) ] } }

/-- `isaianicAlmahIsAlreadyPregnant`. Granted on both sides of the dispute over
this verse: Wegner reads a present pregnancy and so does Rydelnik. What they
disagree about is what kind of pregnancy it is. -/
def isaianicAlmahIsAlreadyPregnantCited : AtomMeta :=
  { label := "The עַלְמָה of Isaiah 7:14 is already pregnant when the sign is given"
  , kind := .interpretive
  , source :=
      { wegnerOnAlmah (.pages 471 472) .wellSupported with
        supporting :=
          [ .work postellIsaiahMessianic (.page 468)
          , .work youngImmanuelProphecy (.pages 116 117) ] } }

/-- `pregnancyAtTheSignIsOrdinary`. The hinge of Wegner's objection, and not a
lexical claim at all. He gets it from the near-term reading of the sign: the
child born within nine months, everything in the oracle discharged by 701 BC.
Rydelnik, parsing הָרָה as Wegner does, denies it outright. So do the fathers, on
the ground that an ordinary conception would be no sign, and `signLine` is that
argument. -/
def pregnancyAtTheSignIsOrdinaryCited : AtomMeta :=
  { label := "The pregnancy Isaiah 7:14 announces is an ordinary conception"
  , kind := .interpretive
  , source :=
      { wegnerOnAlmah (.pages 476 478) .disputed with
        supporting := [.work postellIsaiahMessianic (.page 474)] } }

/-- `isaianicAlmahIsNotAVirgin`. Wegner's conclusion about the referent. Postell
states the step it rests on baldly: "since the עַלְמָה in Isaiah 7:14 is already
pregnant, she obviously cannot be a virgin" (468). -/
def isaianicAlmahIsNotAVirginCited : AtomMeta :=
  { label := "The עַלְמָה of Isaiah 7:14 is not a virgin"
  , kind := .interpretive
  , source :=
      { wegnerOnAlmah (.pages 471 472) .disputed with
        supporting := [.work postellIsaiahMessianic (.page 468)] } }

/-- `oneReferentSettlesDenotation`. Wegner's method: Isaiah 7:14 is used as proof
that the word cannot mean "virgin". Rico and Gentry deny the principle — "the
analysis of the Immanuel oracle does not by itself allow one to draw a conclusion
concerning the meaning of the word" — and hold that the other occurrences settle
it the other way (quoted at Postell 468 n. 22). -/
def oneReferentSettlesDenotationCited : AtomMeta :=
  { label := "What the עַלְמָה of Isaiah 7:14 turns out to be settles what the word denotes"
  , kind := .linguistic
  , source :=
      { wegnerOnAlmah (.pages 471 472) .disputed with
        supporting :=
          [ .work postellIsaiahMessianic (.page 468)
          , .work ricoGentryInfantKing (.page 152) ] } }

/-- `otherClearAlmahCasesAreVirgins`. Postell at 468 n. 22, of the three passages
Wegner calls clearest. Marked `plausible` rather than `wellSupported` because it
is stronger than Wegner's own text: Genesis 24:43 is uncontested, but Wegner's
discussion of Song 6:8 allows that some of the עֲלָמוֹת in the harem would not be
virgins. -/
def otherClearAlmahCasesAreVirginsCited : AtomMeta :=
  { label := "In the other clear עַלְמָה passages Wegner lists, the women are virgins"
  , kind := .linguistic
  , source :=
      { postellOnIsaiah (.page 468) .plausible with
        supporting :=
          [ .work wegnerVirginBirths (.pages 471 472)
          , .work jeromeAgainstJovinianus (.sectionRef "I.32")
          , .work comptonImmanuelProphecy (.page 8)
          , .scripture clearAlmahPassages ] } }

/-- `signMustBeExtraordinary`. Origen's form of it: "What kind of sign, then,
would that have been — a young woman who was not a virgin giving birth to a
child?", tied to the sign offered "in the depth or in the height" (Cels. I.35).
Justin (Dial. 84) and Irenaeus (Haer. III.21.6) argue the same. Rydelnik makes
the move today, as Postell reports (474). `disputed`: Wegner grants that the
sign offered at 7:11 would have been miraculous, but holds that a sign may be an
everyday occurrence and reads the one given at 7:14, after Ahaz refused the
first, as one (469–470, 477–478); Rhodea holds that a sign does not require a
miracle, and that 7:11 does not make this one (64 and n. 10). -/
def signMustBeExtraordinaryCited : AtomMeta :=
  { label := "The sign of Isaiah 7:14 must be extraordinary, like the sign offered at 7:11"
  , kind := .interpretive
  , source :=
      { primary := .work origenAgainstCelsus (.sectionRef "I.35")
      , supporting :=
          [ .work justinDialogue (.sectionRef "84")
          , .work irenaeusAgainstHeresies (.sectionRef "III.21.6")
          , .work postellIsaiahMessianic (.page 474)
          , .scripture depthOrHeightOffer ]
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- `ordinaryConceptionIsNoMarvel`. Irenaeus: "what great thing or what sign
should have been in this, that a young woman conceiving by a man should bring
forth — a thing which happens to all women that produce offspring?" Justin asks
why God would give "a sign which is not common to all the first-born sons"
(Dial. 84). `consensus`, because the rival grants it: its point is that the
sign need not be a marvel, not that an ordinary conception is one (Rhodea
64). -/
def ordinaryConceptionIsNoMarvelCited : AtomMeta :=
  { label := "An ordinary conception is nothing extraordinary: it happens to all women"
  , kind := .interpretive
  , source :=
      { primary := .work irenaeusAgainstHeresies (.sectionRef "III.21.6")
      , supporting :=
          [ .work justinDialogue (.sectionRef "84")
          , .work rhodeaDidMatthewConceive (.page 64) ]
      , tradition := .christianTypological
      , confidence := .consensus } }

/-- `isaianicSignsAreOrdinaryEvents`. What the text says: Rhodea lists
non-supernatural signs "including elsewhere in Isaiah" (64), and Wegner a sign
as "a common, everyday occurrence that has significance because of what it
means, foretells, or predicts" (470). Rydelnik, as Postell reports him (474),
grants the first of them: Isaiah's children are the "signs and wonders" of 8:18. -/
def isaianicSignsAreOrdinaryEventsCited : AtomMeta :=
  { label := "Signs elsewhere in Isaiah are ordinary events: his children, 8:18"
  , kind := .textual
  , source :=
      { primary := .scripture ordinaryIsaianicSigns
      , supporting :=
          [ .work rhodeaDidMatthewConceive (.page 64)
          , .work wegnerVirginBirths (.page 470) ]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `signDatedByAChildsInfancy`. What 7:16 says, and common ground about which
child is left open: Wegner reads it of the child of 7:14 (477), Rydelnik of
Shear-jashub (Postell 474), and Compton of a child whose infancy only measures
the time (14). -/
def signDatedByAChildsInfancyCited : AtomMeta :=
  { label := "Isaiah 7:16 dates the deliverance by a child's infancy"
  , kind := .textual
  , source :=
      { primary := .scripture [verseIn .masoretic ⟨.isaiah, 7, 16⟩]
      , supporting :=
          [ .work wegnerVirginBirths (.page 477)
          , .work comptonImmanuelProphecy (.page 14) ]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

end Testimony.Arguments.BornOfAVirgin
