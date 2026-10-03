import Testimony.Arguments.SolaFide.James
import Testimony.Logic.Because

/-!
# Arguments.SolaFide.Vulgate — Trent's Latin texts, on Rome's own terms

Two of the three texts Trent cites for the increase of justification say
"justified" only in Latin (`Testimony.Arguments.SolaFide.James`). "He that is
just, let him be justified still" is the Vulgate's Revelation 22:11, whose Greek
says "let the righteous still do righteousness"; "Be not afraid to be justified
even to death" is the Vulgate's Sirach 18:22, whose Greek is about paying vows.
Trent introduces both with "as it is written" (Session VI, ch. 10), having
declared the Vulgate "authentic" for "public lectures, disputations, sermons and
expositions" (Session IV).

The reader's question is whether Rome contradicts itself here — whether what
Pius XII taught about the original texts in *Divino Afflante Spiritu* (1943)
cannot be held together with Trent's use of these two readings. This module
answers it from Rome's own words only: Trent's, Pius XII's, and the Catholic
Church's own translation of the Greek.

## The answer depends on what Trent's "as it is written" claims

**Read as a claim about what the inspired authors wrote**, it cannot be held with
Pius XII. He teaches that the original text, "written by the inspired author
himself, has more authority and greater weight than any even the very best
translation" (§16), and the original of these two verses — as the Church's own
translation renders it — does not say "justified". Those commitments together
have no model (`trent_as_the_inspired_text_contradicts_pius`). That is a
contradiction on Rome's own terms, and every premise of it is Rome's.

**Read as Pius XII reads Trent's decree on the Vulgate**, there is no
contradiction. Pius XII denies that recourse to the originals "in any way
derogates" from Trent (§20): the Vulgate's authenticity is "juridical" rather
than critical, and the Vulgate, "in the sense in which the Church has understood
and understands it", is "free from any error whatsoever in matters of faith and
morals" and "may be quoted safely ... in disputations" (§21). On that reading
Trent quotes the Church's authentic Latin, not the inspired authors' words, and
everything Rome says can be held together (`pius_reading_is_consistent`).

**What the consistent reading costs.** It moves the two texts' warrant from the
inspired authors to the Church: the claims that carry it rest on Rome's word
alone (`pius_reading_rests_on_authority`). And Pius XII asks that a doctrine
taught from the Vulgate be confirmed from the original texts (§22), which at
these two verses do not confirm it (`pius_finds_no_confirmation`). So on Rome's
own terms the doctrine of the increase of justification is confirmed from the
originals, if at all, by James 2:24 alone — where it is weighed in
`Testimony.Arguments.SolaFide.James`.

## What this does not show

It does not show that Rome contradicts itself. Trent does not say which reading
of its "as it is written" it means, and Pius XII supplies the reading on which
there is no contradiction. What the module shows is the price of each reading:
the first contradicts Pius XII; the second makes the two texts an appeal to the
Church's authority, which Pius XII himself asks to be confirmed from the
originals, and the originals do not confirm it.

Nor does it show that the doctrine is false. Pius XII holds the Vulgate free
from error in faith because Rome holds the doctrine true on other grounds; this
module is about what these two texts can carry.
-/

namespace Testimony.Arguments.SolaFide

open Testimony Testimony.Bib Testimony.Logic Testimony.Logic.Horn

/-! ### Read as the inspired text -/

/-- **Rome's own commitments, with Trent's citation read as the inspired text**:
Trent's "as it is written" at Revelation 22:11 as a claim about what its author
wrote; the Greek as the Catholic Church's own translation renders it; Pius XII's
principle that the original outweighs any translation; and the step from the
last two to "the inspired text does not say 'be justified still'". -/
@[solaFideDefs]
def romeOnTheInspiredText : List (Formula Claim) :=
  [ p .rev22_11BeJustifiedStill, p .rev22_11GreekDoRighteousness, p .originalTextDecides
  , revelationTextLine.step ]

/-- **Trent's Revelation 22:11, read as what its inspired author wrote, cannot be
held with Pius XII.** The original "has more authority and greater weight than
any even the very best translation" (*Divino Afflante Spiritu* §16), and the
original of Revelation 22:11, as the Catholic Church's own translation renders
it, says "the righteous must still do right". With those, the claim that the
inspired author wrote "let him be justified still" has no model. Every premise is
Rome's own.

What this does not claim: that Trent meant its citation so. Read as Pius XII
reads Trent's Vulgate, there is no contradiction (`pius_reading_is_consistent`). -/
@[headline]
theorem trent_as_the_inspired_text_contradicts_pius :
    ¬ Satisfiable romeOnTheInspiredText :=
  not_satisfiable_of_check (by decide +kernel)

#print axioms trent_as_the_inspired_text_contradicts_pius

/-! ### Read as Pius XII reads the Vulgate -/

/-- Pius XII's step: a doctrine taught from the Vulgate is to be confirmed from
the original texts (§22), and the originals of Revelation 22:11 and Sirach 18:22
do not say what the Latin says; so these two texts do not confirm the doctrine
from the originals. Rated `wellSupported`: it is Pius XII's own demand, applied
to texts whose originals the Church's own translation renders. -/
def piusConfirmationSource : Source :=
  { primary := .work divinoAfflanteSpiritu (.sectionRef "§22")
  , supporting := [.work nabre .whole]
  , tradition := .romanCatholic
  , confidence := .wellSupported }

/-- **Rome's own position on the two Latin texts, read as Pius XII reads Trent**:
Trent quotes the Vulgate as juridically authentic; the Vulgate is free from error
in faith and morals; the original outweighs any translation, and the originals
of the two verses do not say "justified"; a doctrine taught from the Vulgate is
to be confirmed from the originals. Concluded: the two texts do not confirm the
increase of justification from the originals. -/
@[solaFideDefs]
def piusOnTrentsVulgate : ArgumentPackage Claim :=
  { name := "Pius XII, on Trent's Vulgate"
  , cite := baseCite
  , premises :=
      [ p .trentQuotesTheVulgateJuridically, p .vulgateFreeFromDoctrinalError
      , p .originalTextDecides, p .rev22_11GreekDoRighteousness, p .sir18_22GreekIsAVow
      , p .doctrineToBeConfirmedFromOriginals
      , revelationTextLine.step, sirachTextLine.step
      , ⋀ [p .doctrineToBeConfirmedFromOriginals, notP .rev22_11BeJustifiedStill,
            notP .sir18_22BeJustifiedToDeath] ➝ notP .latinTextsConfirmedFromOriginals ]
  , conclusion := notP .latinTextsConfirmedFromOriginals
  , conclusionLabel := "notConfirmedFromOriginals"
  , inferences := [textualSource, piusConfirmationSource] }

/-- **Rome's world, as Pius XII reads Trent**: the Vulgate juridically authentic
and free from error in faith; Trent quoting it so; the originals of the two
verses without "justified", and outweighing any translation; and the two texts,
so read, not confirming the doctrine from the originals. Everything else as Trent
holds it. -/
def piusReading : Valuation Claim := fun a =>
  match a with
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .latinTextsConfirmedFromOriginals => False
  | .worksAreFruitNotGround => False
  | _ => True

/-- **Read as Pius XII reads Trent's decree on the Vulgate, Rome is consistent.**
Trent quoting the Vulgate as juridically authentic, the Vulgate free from error
in faith and morals, the original outweighing any translation, the Greek of the
two verses as the Church's own translation renders it, and the demand that a
doctrine taught from the Vulgate be confirmed from the originals: all of it can be
held together. -/
@[headline]
theorem pius_reading_is_consistent : Satisfiable piusOnTrentsVulgate.premises := by
  satisfied_by piusReading [solaFideDefs]

#print axioms pius_reading_is_consistent

/-- **On Pius XII's own terms, the two Latin texts do not confirm the increase
of justification from the originals.** He asks that a doctrine taught from the
Vulgate be confirmed from the original texts (§22); the originals of Revelation
22:11 and Sirach 18:22 do not say "justified". So Trent's doctrine is confirmed
from the originals, if at all, by James 2:24 alone. -/
@[headline]
theorem pius_finds_no_confirmation : Establishes piusOnTrentsVulgate := by
  establish [solaFideDefs]

#print axioms pius_finds_no_confirmation

/-- **On that reading, the two texts rest on the Church's word.** The claims
that carry Trent's citation — that it quotes the Vulgate as juridically
authentic, and that the Vulgate is free from error in faith — are cited to
Pius XII alone (`Testimony.Logic.Warrant`); so are the principle that the
original outweighs any translation and the demand for confirmation from the
originals, which Westminster holds too. -/
theorem pius_reading_rests_on_authority :
    piusOnTrentsVulgate.restingOnAuthority =
      [ .trentQuotesTheVulgateJuridically, .vulgateFreeFromDoctrinalError
      , .originalTextDecides, .doctrineToBeConfirmedFromOriginals ] := by
  decide

end Testimony.Arguments.SolaFide
