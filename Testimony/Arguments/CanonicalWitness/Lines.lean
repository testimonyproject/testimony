import Testimony.Arguments.CanonicalWitness.Sources
import Testimony.Logic.Line

/-!
# Arguments.CanonicalWitness.Lines — one reading per corpus

Each corpus is a line of reason: its texts as grounds, and one step — the
reading — carrying them to what it delivers. The texts are granted by every
party; the step is where each corpus is read, and it is cited and rated as a
reading.

A corpus delivers only what its texts say. Hebrews says faith is necessary, and
nothing about works; the Johannine texts say faith is sufficient and necessary;
Paul, Peter and Jesus say that works are not the ground and that faith is
sufficient. *Faith alone* is the three together (`toFaithAlone`), so no corpus
has to carry more than its own texts.
-/

namespace Testimony.Arguments.CanonicalWitness

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-! ### The readings, rated

Every reading but Hebrews' is rated `disputed`: Trent grants the texts and
denies that faith alone follows (Session VI, canon 9). Hebrews' reading is
`consensus`, because Trent makes it too — its chapter 8 calls faith the
beginning of salvation, "without which it is impossible to please God". -/

/-- The Pauline reading, cited to the Reformed exegesis, and to the first
Christian writer outside the New Testament to say it: Clement of Rome, writing
that we are justified "not by ourselves … nor by works which we have wrought in
holiness of heart, but by that faith through which, from the beginning, Almighty
God has justified all men" (1 Clement 32.4). -/
def paulineReadingSource : Source :=
  { primary := .work schreinerFaithAlone .whole
  , supporting :=
      [ .work calvinInstitutes (.sectionRef "III.xi.19")
      , .work anf1 (.sectionRef "1 Clement 32.4") ]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- Hebrews' reading: that faith is necessary. Conceded by Trent. -/
def hebrewsReadingSource : Source :=
  { primary := .work bruceHebrews (.adLoc ⟨.hebrews, 11, 6⟩)
  , supporting :=
      [.work tannerDecrees (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 8")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-- The Johannine reading, cited to Calvin's commentary on John. Aquinas reads
the same texts of a faith formed by charity (`Testimony.Arguments.SolaFide`). -/
def johannineReadingSource : Source :=
  { primary := .work calvinJohn (.adLoc ⟨.john, 3, 16⟩)
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- The Petrine reading, cited to Bruce on Peter's speech at the Jerusalem
council. -/
def petrineReadingSource : Source :=
  { primary := .work bruceActs (.adLoc ⟨.acts, 15, 11⟩)
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- The dominical reading, cited to Marshall on the Pharisee and the tax
collector. -/
def dominicalReadingSource : Source :=
  { primary := .work marshallLuke (.adLoc ⟨.luke, 18, 14⟩)
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- James's reading: works as the fruit of a faith that has justified. -/
def jamesReadingSource : Source :=
  { primary := .work mooJames (.adLoc james2_14)
  , supporting :=
      [ .work johnsonJames (.adLoc james2_24)
      , .work calvinInstitutes (.sectionRef "III.xvii.11") ]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- Trent's reading of James 2:24: justification increased by works. -/
def trentOnJamesSource : Source :=
  { primary := .work tannerDecrees
      (.sectionRef "Trent, Session VI (1547), Decree on Justification, ch. 10")
  , tradition := .romanCatholic
  , confidence := .disputed }

/-! ### The lines -/

/-- **Paul**, read as canon: the undisputed letters with Ephesians and Titus,
whoever wrote them. -/
@[canonicalWitnessDefs]
def paulineLine : Line Claim :=
  { name := "Paul (Romans, Galatians, Ephesians, Titus)"
  , grounds :=
      [p .romans3_28, p .romans4_4_5, p .galatians2_16, p .ephesians2_8_9, p .titus3_5]
  , step :=
      ⋀ [p .romans3_28, p .romans4_4_5, p .galatians2_16, p .ephesians2_8_9, p .titus3_5]
      ➝ p .worksAreNotTheGround ⋏ p .faithIsSufficient
  , delivers := p .worksAreNotTheGround ⋏ p .faithIsSufficient
  , inference := some paulineReadingSource }

/-- **Hebrews**, read as its own corpus: faith is necessary. -/
@[canonicalWitnessDefs]
def hebrewsLine : Line Claim :=
  { name := "Hebrews"
  , grounds := [p .hebrews10_38_39, p .hebrews11_6]
  , step := ⋀ [p .hebrews10_38_39, p .hebrews11_6] ➝ p .faithIsNecessary
  , delivers := p .faithIsNecessary
  , inference := some hebrewsReadingSource }

/-- **John**: whoever believes has life, and whoever does not is condemned
already. -/
@[canonicalWitnessDefs]
def johannineLine : Line Claim :=
  { name := "John"
  , grounds := [p .john3_16_18, p .john5_24, p .john6_28_29]
  , step :=
      ⋀ [p .john3_16_18, p .john5_24, p .john6_28_29]
      ➝ p .faithIsSufficient ⋏ p .faithIsNecessary
  , delivers := p .faithIsSufficient ⋏ p .faithIsNecessary
  , inference := some johannineReadingSource }

/-- **Peter**, in Luke's report: forgiveness to everyone who believes, and
salvation through grace, without the yoke. -/
@[canonicalWitnessDefs]
def petrineLine : Line Claim :=
  { name := "Peter (Acts 10 and 15)"
  , grounds := [p .acts10_43, p .acts15_10_11]
  , step :=
      ⋀ [p .acts10_43, p .acts15_10_11] ➝ p .faithIsSufficient ⋏ p .worksAreNotTheGround
  , delivers := p .faithIsSufficient ⋏ p .worksAreNotTheGround
  , inference := some petrineReadingSource }

/-- **Jesus**, in Luke: the woman whose faith saved her, and the tax collector
who went home justified. -/
@[canonicalWitnessDefs]
def dominicalLine : Line Claim :=
  { name := "Jesus (Luke 7 and 18)"
  , grounds := [p .luke7_50, p .luke18_9_14]
  , step :=
      ⋀ [p .luke7_50, p .luke18_9_14] ➝ p .faithIsSufficient ⋏ p .worksAreNotTheGround
  , delivers := p .faithIsSufficient ⋏ p .worksAreNotTheGround
  , inference := some dominicalReadingSource }

/-- The three parts, together, are *faith alone*. -/
@[canonicalWitnessDefs]
def toFaithAlone : Formula Claim :=
  ⋀ [p .faithIsNecessary, p .faithIsSufficient, p .worksAreNotTheGround]
  ➝ p .justificationByFaithAlone

/-- **James**, read with the distinction between justification and
sanctification: the faith he calls dead is the demons' assent, and the
justification he means is the display of a faith already counted as
righteousness. So works are the fruit of saving faith, not its ground. -/
@[canonicalWitnessDefs]
def jamesLine : Line Claim :=
  { name := "James 2"
  , grounds :=
      [ p .james2_14_17, p .james2_19, p .james2_21_23, p .james2_24
      , p .james2TargetsDeadFaith, p .jamesJustifiesDemonstratively
      , p .justificationDistinctFromSanctification ]
  , step :=
      ⋀ [ p .james2_14_17, p .james2_21_23, p .james2TargetsDeadFaith
        , p .jamesJustifiesDemonstratively, p .justificationDistinctFromSanctification ]
      ➝ p .worksAreFruitOfFaith
  , delivers := p .worksAreFruitOfFaith
  , inference := some jamesReadingSource }

/-- Faith alone, with its fruit, is faith that is never alone. -/
@[canonicalWitnessDefs]
def toNeverAlone : Formula Claim :=
  ⋀ [p .justificationByFaithAlone, p .worksAreFruitOfFaith] ➝ p .faithAloneNeverAlone

/-- **Trent's reading of James 2:24.** "Justified" there is the increase of a
justification already received, by works done in grace; so works are part of
its ground, and faith alone is denied. -/
@[canonicalWitnessDefs]
def trentOnJames : Formula Claim :=
  ⋀ [p .james2_24, notP .jamesJustifiesDemonstratively] ➝ notP .worksAreNotTheGround

/-- And what follows from that: not faith alone. -/
@[canonicalWitnessDefs]
def notAloneIfWorksGround : Formula Claim :=
  notP .worksAreNotTheGround ➝ notP .justificationByFaithAlone

/-- The five corpora. -/
@[canonicalWitnessDefs]
def corpora : List (Line Claim) :=
  [paulineLine, hebrewsLine, johannineLine, petrineLine, dominicalLine]

/-! ### The readings, by name

What an opponent can reject is a corpus's reading. The burden numbers the
readings by their place among the lines — the five corpora, then James — and
these names say which is which, so every burden below reads as the corpora it
concerns. `readings_named` checks each name against its line. -/

namespace Reading

/-- Paul's reading. -/
abbrev paul : ℕ := 0
/-- Hebrews' reading. -/
abbrev hebrews : ℕ := 1
/-- John's reading. -/
abbrev john : ℕ := 2
/-- Peter's reading. -/
abbrev peter : ℕ := 3
/-- The reading of Jesus' words. -/
abbrev jesus : ℕ := 4
/-- James's reading, after the five corpora. -/
abbrev james : ℕ := 5

end Reading

/-- Each reading's name points at its own line. -/
theorem readings_named :
    (corpora ++ [jamesLine])[Reading.paul]? = some paulineLine ∧
    (corpora ++ [jamesLine])[Reading.hebrews]? = some hebrewsLine ∧
    (corpora ++ [jamesLine])[Reading.john]? = some johannineLine ∧
    (corpora ++ [jamesLine])[Reading.peter]? = some petrineLine ∧
    (corpora ++ [jamesLine])[Reading.jesus]? = some dominicalLine ∧
    (corpora ++ [jamesLine])[Reading.james]? = some jamesLine :=
  ⟨rfl, rfl, rfl, rfl, rfl, rfl⟩

end Testimony.Arguments.CanonicalWitness
