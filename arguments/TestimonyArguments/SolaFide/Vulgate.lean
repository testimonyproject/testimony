import TestimonyArguments.SolaFide.James
import Testimony.Logic.Because

/-!
# TestimonyArguments.SolaFide.Vulgate — Trent's two Latin texts, judged by Rome's own teaching

Two of the three texts Trent cites for the increase of justification say
"justified" only in Latin (`TestimonyArguments.SolaFide.James`). "He that is
just, let him be justified still" is Revelation 22:11 in the Latin Vulgate; the
Greek says "let the righteous still do righteousness". "Be not afraid to be
justified even to death" is Sirach 18:22 in the Vulgate; the Greek is about
paying vows. Trent introduces both with "as it is written" (Session VI, ch. 10),
having declared the Vulgate "authentic" for "public lectures, disputations,
sermons and expositions" (Session IV).

A reader asks whether Rome contradicts itself here. Pius XII taught, in *Divino
Afflante Spiritu* (1943), that the original texts outweigh any translation. Can
that be held together with Trent's use of these two Latin readings? This section
answers from Rome's own words only: Trent's, Pius XII's, and the Catholic
Church's own translation of the Greek.

## The answer depends on what "as it is written" claims

**Taken as a claim about what the inspired authors wrote**, it cannot be held
together with Pius XII. He teaches that the original text, "written by the
inspired author himself, has more authority and greater weight than any even the
very best translation" (§16). The original of these two verses, as the Church's
own translation gives it, does not say "justified". Those commitments cannot all
be true together (`trent_as_the_inspired_text_contradicts_pius`). Every one of
them is Rome's.

**Taken as Pius XII takes Trent's decree on the Vulgate**, there is no
contradiction. Pius XII denies that going back to the originals "in any way
derogates" from Trent (§20). The Vulgate's authority is "juridical", a matter of
the Church's approval, and not a claim about the original wording. And the
Vulgate, "in the sense in which the Church has understood and understands it",
is "free from any error whatsoever in matters of faith and morals" and "may be
quoted safely ... in disputations" (§21). Taken that way, Trent quotes the
Church's approved Latin, not the inspired authors' words, and everything Rome
says can be held together (`pius_reading_is_consistent`).

**What the consistent way of taking it costs.** It moves the support for the two
texts from the inspired authors to the Church: the claims that carry it rest on
Rome's word alone (`pius_reading_rests_on_authority`). And Pius XII asks that a
doctrine taught from the Vulgate be confirmed from the original texts (§22),
which at these two verses do not confirm it (`pius_finds_no_confirmation`). So
by Rome's own teaching, the doctrine of the increase of justification is
confirmed from the originals, if at all, by James 2:24 alone, which is weighed
in `TestimonyArguments.SolaFide.James`.

## What this does not show

It does not show that Rome contradicts itself. Trent does not say which way its
"as it is written" is meant, and Pius XII supplies the way on which there is no
contradiction. What this section shows is what each costs. The first contradicts
Pius XII. The second makes the two texts an appeal to the Church's authority,
which Pius XII himself asks to be confirmed from the originals, and the
originals do not confirm it.

Nor does it show that the doctrine is false. Pius XII holds the Vulgate free
from error in faith because Rome holds the doctrine true on other grounds. This
section is about what these two texts can bear.
-/

namespace TestimonyArguments.SolaFide

open Testimony

open Testimony Testimony.Bib Testimony.Logic Testimony.Logic.Horn

/-! ### Taken as the inspired text -/

/-- **Rome's own commitments, with Trent's citation taken as the inspired text.**
Trent's "as it is written" at Revelation 22:11, as a claim about what its author
wrote. The Greek, as the Catholic Church's own translation gives it. Pius XII's
principle that the original outweighs any translation. And the step from the
last two to "the inspired text does not say 'be justified still'". -/
@[solaFideDefs]
def romeOnTheInspiredText : List (Formula Claim) :=
  [ p .rev22_11BeJustifiedStill, p .rev22_11GreekDoRighteousness, p .originalTextDecides
  , revelationTextLine.step ]

/-- **Trent's Revelation 22:11, taken as what its inspired author wrote, cannot be
held together with Pius XII.** The original "has more authority and greater
weight than any even the very best translation" (*Divino Afflante Spiritu* §16).
The original of Revelation 22:11, as the Catholic Church's own translation gives
it, says "the righteous must still do right". With those two, the claim that the
inspired author wrote "let him be justified still" cannot be true. Every premise
is Rome's own.

What this does not claim: that Trent meant its citation that way. Taken as Pius
XII takes Trent's use of the Vulgate, there is no contradiction
(`pius_reading_is_consistent`). -/
@[headline]
theorem trent_as_the_inspired_text_contradicts_pius :
    ¬ Satisfiable romeOnTheInspiredText :=
  not_satisfiable_of_check (by decide +kernel)

#print axioms trent_as_the_inspired_text_contradicts_pius

/-! ### Taken as Pius XII takes the Vulgate -/

/-- Pius XII's step. A doctrine taught from the Vulgate is to be confirmed from the
original texts (§22). The originals of Revelation 22:11 and Sirach 18:22 do not
say what the Latin says. So these two texts do not confirm the doctrine from the
originals. Rated `wellSupported`: it is Pius XII's own requirement, applied to
texts whose originals the Church's own translation gives. -/
def piusConfirmationSource : Source :=
  { primary := .work divinoAfflanteSpiritu (.sectionRef "§22")
  , supporting := [.work nabre .whole]
  , tradition := .romanCatholic
  , confidence := .wellSupported }

/-- **Rome's own position on the two Latin texts, taken as Pius XII takes Trent.**
Trent quotes the Vulgate as the Church's approved text. The Vulgate is free from
error in faith and morals. The original outweighs any translation, and the
originals of the two verses do not say "justified". A doctrine taught from the
Vulgate is to be confirmed from the originals. The conclusion: the two texts do
not confirm the increase of justification from the originals. -/
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

/-- **Rome's position, as Pius XII takes Trent.** The Vulgate is the Church's
approved text and free from error in faith. Trent quotes it as such. The
originals of the two verses lack "justified", and outweigh any translation. So
the two texts do not confirm the doctrine from the originals. Everything else is
as Trent holds it. -/
def piusReading : Valuation Claim := fun a =>
  match a with
  | .rev22_11BeJustifiedStill => False
  | .sir18_22BeJustifiedToDeath => False
  | .latinTextsConfirmedFromOriginals => False
  | .worksAreFruitNotGround => False
  | _ => True

/-- **Taken as Pius XII takes Trent's decree on the Vulgate, Rome is consistent.**
All of this can be held together: Trent quoting the Vulgate as the Church's
approved text; the Vulgate free from error in faith and morals; the original
outweighing any translation; the Greek of the two verses as the Church's own
translation gives it; and the requirement that a doctrine taught from the
Vulgate be confirmed from the originals. -/
@[headline]
theorem pius_reading_is_consistent : Satisfiable piusOnTrentsVulgate.premises := by
  satisfied_by piusReading [solaFideDefs]

#print axioms pius_reading_is_consistent

/-- **By Pius XII's own teaching, the two Latin texts do not confirm the increase of
justification from the originals.** He asks that a doctrine taught from the
Vulgate be confirmed from the original texts (§22). The originals of Revelation
22:11 and Sirach 18:22 do not say "justified". So Trent's doctrine is confirmed
from the originals, if at all, by James 2:24 alone. -/
@[headline]
theorem pius_finds_no_confirmation : Establishes piusOnTrentsVulgate := by
  establish [solaFideDefs]

#print axioms pius_finds_no_confirmation

/-- **Taken that way, the two texts rest on the Church's word.** The claims that
carry Trent's citation are cited to Pius XII alone: that it quotes the Vulgate
as the Church's approved text, and that the Vulgate is free from error in faith.
So are the principle that the original outweighs any translation and the
requirement of confirmation from the originals, though Westminster holds the
principle too. -/
theorem pius_reading_rests_on_authority :
    piusOnTrentsVulgate.restingOnAuthority =
      [ .trentQuotesTheVulgateJuridically, .vulgateFreeFromDoctrinalError
      , .originalTextDecides, .doctrineToBeConfirmedFromOriginals ] := by
  decide

end TestimonyArguments.SolaFide
