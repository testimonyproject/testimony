import Testimony.Ontology.Search

/-!
# Testimony.Ontology.Relations.Reach — where the definitions bear, and what they derive

### The search

The search finds every claim, in every argument, whose meaning uses one of the
five relation words the definitions are about. Three arguments use them: sola
fide, the canonical witness, and sola scriptura. The others do not, and the
definitions derive nothing for them.

Each word is used two ways. Some claims *hold* a doctrine in it — "works are
not the ground of justification" — and the definitions apply to those. Others
use it *inside a frame*: what a passage says or teaches, what it is written
against, what a voice held. "Romans 3:28 says that works of the law are excluded
from justification" is a claim about a text, and a text may say a thing without
saying everything that follows from it; so the definitions do not reach inside
a frame.
-/

namespace Testimony.Ontology.Relations

open Testimony Testimony.Semantics

/-- **"Excluded from", in sola fide.** Two claims hold it as doctrine: works are
fruit and not ground, and salvation is not by works. Eight use it of a text:
Ephesians 2:8–9, Romans 3:28, Galatians 2:16, Romans 4:4–5, Titus 3:5,
Galatians 3:11–12, Romans 4:6–8, and the tax collector of Luke 18, who brings no
works. -/
theorem excludedFrom_in_sola_fide :
    HasMeanings.holding (α := Arguments.SolaFide.Claim) .excludedFrom =
        [.worksAreFruitNotGround, .salvationNotByWorks] ∧
      HasMeanings.framing (α := Arguments.SolaFide.Claim) .excludedFrom =
        [ .ephesians2_8_9, .romans3_28, .galatians2_16, .romans4_4_5, .titus3_5
        , .gal3_11_12LawIsNotOfFaith, .romans4_6_8, .taxCollectorBringsNoWorks ] := by
  decide +kernel

/-- **"Excluded from", in the canonical witness**: that works are not the ground
of justification, held alone, and as a part of *faith alone* and of "a faith
that is never alone". -/
theorem excludedFrom_in_the_canonical_witness :
    HasMeanings.holding (α := Arguments.CanonicalWitness.Claim) .excludedFrom =
      [.worksAreNotTheGround, .justificationByFaithAlone, .faithAloneNeverAlone] := by
  decide +kernel

/-- **"A ground of"**, held: salvation by grace, and Trent's works that cause an
increase of justification, in sola fide; Scripture the ground of the creedal
consensus, in sola scriptura. -/
theorem groundOf_held :
    HasMeanings.holding (α := Arguments.SolaFide.Claim) .groundOf =
        [.salvationByGrace, .worksCauseIncreaseOfJustification] ∧
      HasMeanings.holding (α := Arguments.SolaScriptura.Claim) .groundOf =
        [.creedalConsensusIsDerivedFromScripture] := by
  decide +kernel

/-- **"The only means of"**, in sola fide. One claim holds it: justification by
faith alone. Two use it of a text: James 2:14–26, written against *faith alone*
on the reading that its faith is assent; and James 2:24, which says "not by
faith only". -/
theorem soleInstrumentOf_in_sola_fide :
    HasMeanings.holding (α := Arguments.SolaFide.Claim) .soleInstrumentOf =
        [.justificationByFaithAlone] ∧
      HasMeanings.framing (α := Arguments.SolaFide.Claim) .soleInstrumentOf =
        [.james2TargetsDeadFaith, .james2_24NotByFaithAlone] := by
  decide +kernel

/-- **"A means of"**, held, in sola fide: salvation through faith, and Trent's
baptism, the instrumental cause of justification. -/
theorem instrumentOf_held_in_sola_fide :
    HasMeanings.holding (α := Arguments.SolaFide.Claim) .instrumentOf =
      [.salvationThroughFaith, .baptismIsInstrumentalCause] := by
  decide +kernel

/-- **"The whole ground of"**, in sola fide: one claim, that Christ's work is the
whole ground of justification. -/
theorem soleGroundOf_in_sola_fide :
    HasMeanings.holding (α := Arguments.SolaFide.Claim) .soleGroundOf =
      [.christsWorkIsTheWholeGround] := by
  decide +kernel

/-! ### What the definitions derive

Each argument's joins are computed under the shared ontology and pinned beside
its meanings. The theorems below compute them again with the definitions taken
away, one at a time, so that what each definition contributes is a checked
fact rather than a claim of this article. -/

/-- **With no definitions at all, sola fide's meanings join five pairs.** Four
were found before: Paul's verb, the two Latin verses, and James's word. The
fifth — "forensic only" against "justification includes sanctification" — needs
no definition either. The denial is in the Reformed claim's own meaning,
"justification includes the remission of sins, and not sanctification"; the
reader used before looked for denials of a whole claim, and missed one inside
it. -/
theorem sola_fide_joins_without_definitions :
    HasMeanings.exclusionsUnder (α := Arguments.SolaFide.Claim) [] =
      [ (.james2_24Compatible, .jamesUsesDikaioAsPaul)
      , (.justificationIsForensicOnly, .justificationIncludesSanctification)
      , (.dikaioIsForensic, .paulsJustifyDenotesRenewal)
      , (.rev22_11BeJustifiedStill, .rev22_11GreekDoRighteousness)
      , (.sir18_22BeJustifiedToDeath, .sir18_22GreekIsAVow) ] := by
  decide +kernel

/-- **"The only means" alone derives the sixth.** Faith the only means by which
justification is received, and baptism a means by which it is, cannot both be
held: the only means of a thing is a means of it, and nothing else is. The two
definitions besides add nothing to sola fide: the joins under all three are
these six (`Testimony.Meanings.SolaFide.joins`). -/
theorem only_means_derives_one_join :
    HasMeanings.exclusionsUnder (α := Arguments.SolaFide.Claim) [onlyMeans] =
      [ (.james2_24Compatible, .jamesUsesDikaioAsPaul)
      , (.justificationByFaithAlone, .baptismIsInstrumentalCause)
      , (.justificationIsForensicOnly, .justificationIncludesSanctification)
      , (.dikaioIsForensic, .paulsJustifyDenotesRenewal)
      , (.rev22_11BeJustifiedStill, .rev22_11GreekDoRighteousness)
      , (.sir18_22BeJustifiedToDeath, .sir18_22GreekIsAVow) ] := by
  decide +kernel

/-- **No definition derives a join or an entailment elsewhere.** In the canonical
witness and in sola scriptura, which use the defined words, the joins and the
entailments are the same with the definitions and without them. -/
theorem definitions_derive_nothing_elsewhere :
    HasMeanings.exclusionsUnder (α := Arguments.CanonicalWitness.Claim) [] =
        HasMeanings.exclusions ∧
      HasMeanings.entailmentsUnder (α := Arguments.CanonicalWitness.Claim) [] =
        HasMeanings.entailments ∧
      HasMeanings.exclusionsUnder (α := Arguments.SolaScriptura.Claim) [] =
        HasMeanings.exclusions ∧
      HasMeanings.entailmentsUnder (α := Arguments.SolaScriptura.Claim) [] =
        HasMeanings.entailments := by
  decide +kernel

/-- **No meaning contradicts itself** under the definitions, in any of the three
arguments that use the defined words. -/
theorem no_meaning_contradicts_itself :
    HasMeanings.incoherent (α := Arguments.SolaFide.Claim) = [] ∧
      HasMeanings.incoherent (α := Arguments.CanonicalWitness.Claim) = [] ∧
      HasMeanings.incoherent (α := Arguments.SolaScriptura.Claim) = [] := by
  decide +kernel

end Testimony.Ontology.Relations
