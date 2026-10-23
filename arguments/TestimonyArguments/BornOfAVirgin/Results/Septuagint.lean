import TestimonyArguments.BornOfAVirgin.Packages
import Testimony.Logic.Tactic

/-!
# TestimonyArguments.BornOfAVirgin.Results.Septuagint — what the Septuagint shows

A reader's question, in a reader's words: *the Jews who translated Isaiah into
Greek, before Christ, wrote παρθένος — "virgin". Doesn't that settle it?*

The argument is old. Irenaeus makes it against Theodotion and Aquila: the verse
"was interpreted into Greek by the Jews themselves, much before the period of
our Lord's advent, that there might remain no suspicion that perchance the Jews,
complying with our humour, did put this interpretation upon these words"
(*Against Heresies* III.21.1). This module encodes it at full strength and asks
three things of it, one result each.

**What it rests on.** Take away the claim that παρθένος, in the translator's
Greek, means a virgin, and the Septuagint no longer shows that its translator
read the woman as one (`parthenos_is_load_bearing`). Everything turns on that
word, and whether it means "virgin" there is exactly what the sources dispute.
Rico and Gentry hold that it does "whenever it appears in Semitic Koine Greek",
and Bratcher agrees. Wegner, Rhodea and Meade hold that in the translator's day
it still meant a young woman, as it does of Dinah after Shechem has lain with her
(Genesis 34:3), and Walton that the translator's choice of it "is not
necessarily betraying an interpretation as virgin". Wegner and Walton grant that
by the New Testament the word meant "virgin"; Meade and Davidson put that sense
down to Christian use. The dispute is over the translator's day, two or three
centuries before Matthew. Weighed against each other, nothing prevails: the
Septuagint's witness, with Rico and Gentry, can be defended, and so can Wegner
(`nothing_prevails_over_parthenos`, in `Dispute.Septuagint`).

**What it would show, if the word means "virgin".** How one early reader read
Isaiah: a Jewish translator, before Christ, read the woman of 7:14 as a virgin, so
reading her so is no Christian invention. It would not show what Isaiah's own word
means without a further step, rated `disputed`
(`septuagint_word_rests_on_its_inference`). A translator can render the woman
described rather than the word. The translator of Genesis wrote παρθένος for the
עַלְמָה Rebekah (24:43), whom the story has already called a virgin (24:16): a
rendering "historically correct — since Rebekah was a virgin", Bratcher says,
that "does not precisely translate the Hebrew" (113). Elsewhere the Septuagint's
translators, of other books than Isaiah, render עַלְמָה with νεᾶνις, "young
woman", four times. That is how this argument's referential strand already reads
the versions.

**What it leaves open, even then.** The Greek says the virgin *shall* be with
child. A woman who is a virgin when the sign is given and conceives later by a
man fits those words as well as a virgin who conceives as a virgin does
(`septuagint_leaves_the_conception_open`). That is not only a rival's reading.
Bratcher, who holds that παρθένος "definitely means 'virgin' in the LXX" (113),
reads the Greek of 7:14 so: "a young woman, at that time virgin, would in the
normal way marry and bear a child" (115), "the most reasonable explanation"
(116). So the Septuagint, granted every word, does not by itself say that the
conception was without a man. Justin and
Irenaeus read it so, from the promise of a sign (`signLine`, weighed in
`Dispute.Wegner`); the word alone does not.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Bib Testimony.Logic

/-! ### The Septuagint as a witness

Each reading below is a model: a way every claim of the argument could stand at
once, named for what it says of the Septuagint and of the woman of 7:14. It
settles those as its namesake does. Where the argument's joins require a side on
questions this module does not touch, it takes the scriptural reading's: that
Micah's mention of a mother and no father does mean something, and that
Scripture, not the magisterium, is the judge. Every other claim it leaves true,
and none of them bears on the results it is used for. -/

/-- Justin's reading of the elders' Greek, with Rico and Gentry's sense of the
word: παρθένος means a virgin, the translator read the woman of 7:14 as one, and
she conceives as one — "a sign which is not common to all the first-born sons"
(*Dialogue* 84). So she is not already pregnant when the sign is given, and her
pregnancy is no ordinary one. The word did not mean "young woman" as such. -/
def virginConceivesReading : Valuation Claim := fun a =>
  match a with
  | .parthenosMeantYoungWoman => False
  | .harahIsPredicateAdjective => False
  | .isaianicAlmahIsAlreadyPregnant => False
  | .pregnancyAtTheSignIsOrdinary => False
  | .isaianicAlmahIsNotAVirgin => False
  | .maternalSilenceProvesNothing => False
  | .magisteriumIsDoctrinallyAuthoritative => False
  | _ => True

/-- **The Septuagint, read with Rico and Gentry, is a witness from before
Christ.** Grant that the Greek Isaiah renders עַלְמָה with παρθένος, that it was
made by Jews before Christ, and that παρθένος in its Greek means a virgin, and
it follows that a Jewish translator, before Christ, read the woman of 7:14 as a
virgin.

That is the whole of what it delivers: a claim about how the first translator
read the verse. It does not show that παρθένος meant "virgin" in the
translator's day: that is granted here, and rated `disputed`
(`parthenos_is_load_bearing`). Nor does it show what עַלְמָה means
(`septuagint_word_rests_on_its_inference`), or how the woman conceived
(`septuagint_leaves_the_conception_open`). -/
@[headline]
theorem septuagintWitness_establishes : Establishes septuagintWitness := by
  establish [bornOfAVirginDefs]

#print axioms septuagintWitness_establishes

/-- The Septuagint as a witness has a model. -/
theorem septuagintWitness_is_satisfiable : Satisfiable septuagintWitness.premises := by
  satisfied_by virginConceivesReading [bornOfAVirginDefs]

/-- Wegner's reading: in the translator's day παρθένος meant "young woman", with
or without virginity, and did not yet mean "virgin"; so the Greek does not show
that its translator read the woman of 7:14 as a virgin, nor anything about how
she conceived, and עַלְמָה does not denote a virgin either. The woman of 7:14 is
already pregnant when the sign is given, and the sign need not be a miracle. -/
def wegnerDriftReading : Valuation Claim := fun a =>
  match a with
  | .parthenosMeansVirgin => False
  | .lxxReadsAVirgin => False
  | .lxxEnvisagesAVirginalConception => False
  | .almahMeansVirgin => False
  | .signMustBeExtraordinary => False
  | .maternalSilenceProvesNothing => False
  | .magisteriumIsDoctrinallyAuthoritative => False
  | _ => True

/-- **The word carries the whole witness.** Keep the rendering and its date —
the Greek has παρθένος, and Jews made it before Christ — and grant nothing about
what παρθένος meant to them, and the Septuagint no longer shows that its
translator read the woman as a virgin. On Wegner's reading the word was the
ordinary one for a young woman of marriageable age.

So whoever argues from the Septuagint has to win the claim about the word. Its
date, which the rival grants, does not help without it. -/
@[headline]
theorem parthenos_is_load_bearing : ¬ Establishes septuagintWithoutTheSense := by
  refute_with wegnerDriftReading [bornOfAVirginDefs]

#print axioms parthenos_is_load_bearing

/-! ### From the translator's reading to Isaiah's word -/

/-- Add the step from the translator's reading to Isaiah's word, rated
`disputed`, and the case concludes that עַלְמָה denotes a virgin. It is only as
good as that step. -/
theorem septuagintOnTheWord_establishes : Establishes septuagintOnTheWord := by
  establish [bornOfAVirginDefs, caseOf]

/-- The Septuagint asked for Isaiah's word has a model. -/
theorem septuagintOnTheWord_is_satisfiable : Satisfiable septuagintOnTheWord.premises := by
  satisfied_by virginConceivesReading [bornOfAVirginDefs, caseOf]

/-- The referential reading of the Septuagint: its translator read the woman of
7:14 as a virgin, with a word that means one, and עַלְמָה still denotes only a
young woman of marriageable age. He described the woman, not the word, and the
woman is a virgin. -/
def translatorDescribesTheWomanReading : Valuation Claim := fun a =>
  match a with
  | .parthenosMeantYoungWoman => False
  | .almahMeansVirgin => False
  | .harahIsPredicateAdjective => False
  | .isaianicAlmahIsAlreadyPregnant => False
  | .isaianicAlmahIsNotAVirgin => False
  | .maternalSilenceProvesNothing => False
  | .magisteriumIsDoctrinallyAuthoritative => False
  | _ => True

/-- **The Septuagint shows how its translator read the woman, not what Isaiah's
word means.** Grant everything the witness rests on, παρθένος as "virgin"
included, and grant that the translator read the woman of 7:14 as a virgin:
עַלְמָה can still denote only a young woman, as the referential strand reads it.
The step from the one to the other is the weight, and it is rated `disputed`:
Bratcher and Brown grant that the translator read the woman as a virgin and deny
that עַלְמָה says so, and Walton holds that the Greek shows "at best ... an
interpretational preference rather than a linguistic necessity" (293). On
Bratcher's reading (113), the Septuagint's translators render the woman, not the
word: παρθένος for Rebekah, whom the story calls a virgin (Genesis 24:43), and
νεᾶνις at Exodus 2:8, Psalm 67:26 (68:25 in English Bibles), Song 1:3 and 6:8.
Jerome reads Rebekah the other way, as showing that עַלְמָה denotes a virgin
(*Against Jovinianus* I.32).

So the Septuagint cannot by itself settle the claim that עַלְמָה itself denotes a
virgin, however its word is read. If its word means "virgin", what it can do is
what the referential strand already needs: show that a virgin answers the
description. -/
@[headline]
theorem septuagint_word_rests_on_its_inference :
    ¬ Entails septuagintLine.premises (p .almahMeansVirgin) := by
  refute_with translatorDescribesTheWomanReading [bornOfAVirginDefs]

#print axioms septuagint_word_rests_on_its_inference

/-! ### What the Greek leaves open -/

/-- Bratcher's reading of the Greek, who holds that its word means a virgin: "a
young woman, at that time virgin, would in the normal way marry and bear a
child" (115). Rhodea gives the Greek the same reading, granting its sense for
argument's sake and quoting Tsevat: "The pregnancy lies in the future ...;
nothing indicates that the woman is also a virgin after the conception" (67).
The word means a virgin, the translator read her as one, and she is one when the
sign is given; she conceives later, by a man. -/
def nowAVirginReading : Valuation Claim := fun a =>
  match a with
  | .parthenosMeantYoungWoman => False
  | .lxxEnvisagesAVirginalConception => False
  | .harahIsPredicateAdjective => False
  | .isaianicAlmahIsAlreadyPregnant => False
  | .isaianicAlmahIsNotAVirgin => False
  | .maternalSilenceProvesNothing => False
  | .magisteriumIsDoctrinallyAuthoritative => False
  | _ => True

/-- **Granted every word, the Septuagint leaves the conception open.** Keep the
rendering, its date, παρθένος as "virgin", the reading it delivers, and the tense
of the verb — the virgin *shall* be with child — and whether its translator
meant a conception without a man is independent of all of it. On Bratcher's
reading, who holds that the word means a virgin, she is a virgin when the sign is
given and later conceives in the ordinary way; Rhodea reads it so too, granting
the sense for argument's sake. On Justin's she conceives as a virgin. Both
readings keep every premise.

No premise here speaks to how she conceives, so the result says only that the
Greek's own words leave it open. Justin's argument that an ordinary conception
would be no sign is the sign argument's, and is weighed in `Dispute.Wegner`.

The result has two halves: the Greek does not show that the translator meant a
conception without a man, and does not show that he did not. If its sense is
granted, the Septuagint's word answers the objection that the virgin reading was
a Christian invention; it does not supply the virginal conception. That comes, if
it comes, from the promise of a sign (`signLine`), or from Matthew and Luke. -/
@[headline]
theorem septuagint_leaves_the_conception_open :
    Independent septuagintWithTheFuture.premises (p .lxxEnvisagesAVirginalConception) := by
  leaves_open nowAVirginReading virginConceivesReading [bornOfAVirginDefs]

#print axioms septuagint_leaves_the_conception_open

end TestimonyArguments.BornOfAVirgin
