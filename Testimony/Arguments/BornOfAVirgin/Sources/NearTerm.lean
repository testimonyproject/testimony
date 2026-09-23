import Testimony.Arguments.BornOfAVirgin.Atoms

/-!
# Arguments.BornOfAVirgin.Sources.NearTerm — the citations of the near-term dispute

The atoms of the dispute over the critical denial, cited here and dispatched
from `cite` by name: the critic's two premises, that 7:14 was a near-term sign
to Ahaz and that such a sign excludes a messianic sense, and the grounds of the
replies to them — Berry's, Postell's Micah counterexample, and Motyer's with
Compton's. (Postell's Isaiah counterexample rests on atoms the compositional
strand also uses, and is cited with them in `Sources.lean`.)

They sit apart for the reason `Sources.Wegner` does: `cite` stays one total
function, and each value below is reached from exactly one of its cases.
-/

namespace Testimony.Arguments.BornOfAVirgin

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- `isaiahIsNearTermSignToAhaz`. The reading Justin already answers, in Trypho's
form: fulfilled in Hezekiah (Dial. 67, 77). Origen's reply is a question — which
child of Ahaz's day was called Immanuel? — and his conclusion that the sign was
given to the house of David (Cels. I.35). Motyer denies it most directly (1970,
120, 124): the sign confirms events after the fact, and Maher-shalal-hash-baz,
not Immanuel, carries the timetable. So does Compton (2007, 12): 7:14 is
addressed to the house of David, in plural pronouns, and only 7:15–16, with a
singular "you", to Ahaz. `disputed` for that reason, on the definition that
re-rated the exclusion premise. -/
def isaiahIsNearTermSignToAhazCited : AtomMeta :=
  { label := "Isaiah 7:14 is a near-term sign to Ahaz, fulfilled in Isaiah's generation"
  , kind := .interpretive
  , source := brownOnBirth .disputed }

/-- `nearTermExcludesMessianicSense`. The premise Berry and Postell deny, and
Motyer with them: `disputed` by the library's own definition, since the contest
is recorded in `berryLine` and `postellLine`. It was once cited `wellSupported`
on Brown's authority, which let the critic outrank both replies. Compton (2007,
12–14) denies it on a third ground: the near-term part of the oracle, 7:15–16,
uses the child's infancy only as a measure of time, and so does not need the
child born in Ahaz's day. -/
def nearTermExcludesMessianicSenseCited : AtomMeta :=
  { label := "A sign given for Ahaz's generation is not also a prediction of a virgin birth"
  , kind := .interpretive
  , source := brownOnBirth .disputed }

/-- `nearTermFulfilmentIsUnclear`. Descriptively uncontroversial: the near-term
referent has been taken for Isaiah's son, for Hezekiah, and for a son of Ahaz,
with no settled answer. What is contestable is the use Berry puts it to. Compton
surveys the candidates (5) and finds that none fits (9). -/
def nearTermFulfilmentIsUnclearCited : AtomMeta :=
  { label := "How Isaiah 7:14 was fulfilled in Ahaz's own day is itself an open question"
  , kind := .interpretive
  , source :=
      { primary := .work berryVirginBirth (.pages 1653 1654)
      , supporting := [.work comptonImmanuelProphecy (.pages 5 9)]
      , tradition := .christianHistoricalGrammatical
      , confidence := .wellSupported } }

/-- `signGivenToHouseOfDavid`. What the Hebrew says: שִׁמְעוּ־נָא בֵּית דָּוִד and
לָכֶם in 7:13–14 are plural, אַתָּה in 7:16 is singular. Compton builds on it
(12), Motyer notes the address to the dynasty (122). The grammar is not in
dispute; what it implies is, and that is left to the step that uses it. -/
def signGivenToHouseOfDavidCited : AtomMeta :=
  { label := "Isaiah 7:13–14 gives the sign to David's house, in the plural; 7:16's 'you' is Ahaz"
  , kind := .textual
  , source :=
      { primary := .scripture immanuelAddressees
      , supporting :=
          [ .work comptonImmanuelProphecy (.page 12)
          , .work youngImmanuelProphecy (.page 112)
          , .work motyerContextContent (.page 122) ]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `maherShalalHashBazRepeatsTheTimetable`. Common ground: the parallel is what
leads the critics who identify the two children to identify them (Compton 5,
citing Clements). Motyer (124) and Compton (13) read it the other way. The
observation is shared; the reading of it is the step. -/
def maherShalalHashBazRepeatsTheTimetableCited : AtomMeta :=
  { label := "Isaiah 8:4 gives Maher-shalal-hash-baz the timetable 7:16 gives the child of 7:14"
  , kind := .textual
  , source :=
      { primary := .work motyerContextContent (.page 124)
      , supporting :=
          [ .work comptonImmanuelProphecy (.page 13)
          , .scripture sharedTimetable ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .wellSupported } }

/-- `micahRulerFacesAssyria`. What the text says. Postell cites it by the Hebrew
numbering, as Micah 5:1 and 5:4–5 (481 n. 72). -/
def micahRulerFacesAssyriaCited : AtomMeta :=
  { label := "Micah 5:5–6 sets the ruler from Bethlehem against the Assyrian invasion"
  , kind := .textual
  , source :=
      { primary := .scripture micahAssyrianSetting
      , supporting := [.work postellIsaiahMessianic (.page 481)]
      , tradition := .criticalScholarship
      , confidence := .consensus } }

/-- `micahRulerReadMessianically`. Granted by the critic's own authority: "there
was an expectation of the Messiah's birth at Bethlehem (Mt 2:4-6; Jn 7:42)"
(Brown 1972, 26 n. 64). Postell: recognised as messianic by ancient Jewish
interpreters (481 n. 72). -/
def micahRulerReadMessianicallyCited : AtomMeta :=
  { label := "Micah 5:2 was read messianically in first-century Judaism"
  , kind := .historical
  , source :=
      { primary := .work postellIsaiahMessianic (.page 481)
      , supporting :=
          [ .work brownProblemVirginalConception (.page 26)
          , .scripture bethlehemExpectation ]
      , tradition := .christianHistoricalGrammatical
      , confidence := .wellSupported } }

end Testimony.Arguments.BornOfAVirgin
