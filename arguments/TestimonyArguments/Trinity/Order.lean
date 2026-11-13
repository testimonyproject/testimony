import TestimonyArguments.Trinity.Sources
import TestimonyArguments.Meanings.Trinity
import Testimony.Logic.Tactic

/-!
# TestimonyArguments.Trinity.Order — is the Son less than the Father?

Some texts set the Son below the Father. "The Son can do nothing of his own
accord, but only what he sees the Father doing" (John 5:19). "The Father is
greater than I" (John 14:28). The risen Jesus speaks of "my God and your God"
(John 20:17). "The head of Christ is God" (1 Corinthians 11:3). And at the end
"the Son himself will also be subjected to him who put all things in subjection
under him" (1 Corinthians 15:28).

LST grades them so: "These texts establish real personal and mediatorial order,
but they do not by themselves establish inequality of divine nature or an
eternal hierarchy of command and obedience between the divine persons as such."
That is three claims. The texts establish an order (`lstOrder_establishes`).
They leave open whether the Son is less than the Father in his divinity
(`order_texts_leave_lesser_divinity_open`). And they leave open whether the
order is eternal, an order of authority and submission between the persons as
they are (`order_texts_leave_eternal_authority_open`). All three hold.

## Two questions, and who answers them

The first question is the old one. The Arians, Augustine reports, argued "that
the Son is less than the Father, because it is written that the Lord Himself
said, My Father is greater than I". Arius had said that "the Son has a beginning,
but that God is without beginning". Three readers answer the verse, and their
answers differ.

- Augustine reads it by the two "forms" of Philippians 2:6–7: "The Son of God,
  then, is equal to God the Father in nature, but less in fashion. For in the
  form of a servant which He took He is less than the Father; but in the form of
  God … He is equal to the Father."
- Athanasius reads "greater" of the Father as the one the Son is from: "not
  indeed in greatness, nor in time, but because of His generation from the Father
  Himself, nay, in saying 'greater' He again shows that He is proper to His
  essence."
- Calvin reads it as the Mediator comparing his humbled state with the glory he
  is going to: "Christ does not now speak either of his human nature, or of his
  eternal Divinity". He thinks the Fathers' reply from the human nature was
  "neither correct nor appropriate", so his reading and Augustine's exclude each
  other.

The second question is recent. Wayne Grudem and Bruce Ware hold that the order
of sending and obeying belongs to the persons as they eternally are: "the names
Father and Son indicate an eternal relationship of authority and submission"
(Grudem, 2016), and "prior to creation, the Son was eternally subject to the
planning and authority of the Father" (Grudem, 2015, p. 40). Grudem confesses
the persons "equal in power and glory", with the Evangelical Theological
Society, and holds that eternal submission does not deny it. Kevin Giles answers
that "to argue that the Son is eternally subordinate in authority to the Father,
denies that he is equal in power with the Father" (2008, p. 323). The
Westminster Confession calls the three persons "of one substance, power, and
eternity" (II.3). Millard Erickson, in his assessment of the debate, holds that
the texts of the Father's sending and commanding "do not count as evidence in
support of an eternal supremacy of the Father" (as Grudem quotes him, 2016).

## What this does not claim

It does not weigh the texts that say the Son is God, which are the next question
of LST §3: John 1:1, 20:28 and the rest. The order texts were not written to
settle the Son's divinity, and LST does not claim they do. So the Arian reading
here stands against readings of the same few verses, and the result is what
those verses carry, not what the whole New Testament does.
-/

namespace TestimonyArguments.Trinity

open Testimony

open Testimony Testimony.Bib Testimony.Logic

/-! ### The texts, and the order they establish -/

/-- The order texts LST cites. -/
@[trinityDefs]
def orderTexts : List (Formula Claim) :=
  [ p .sonDoesNothingOfHimself, p .fatherIsGreater, p .fatherIsGodOfTheRisenSon
  , p .headOfChristIsGod, p .sonSubjectAtTheEnd ]

/-- From the texts to a real order: the Son is sent and does the sender's will,
the Father is greater, the risen Son calls him his God, the head of Christ is
God, and at the end the Son is subject. -/
@[trinityDefs]
def textsEstablishOrder : Formula Claim :=
  ⋀ [ p .sonDoesNothingOfHimself, p .fatherIsGreater, p .fatherIsGodOfTheRisenSon
    , p .headOfChristIsGod, p .sonSubjectAtTheEnd ] ➝ p .realOrder

/-- **What the order texts establish**, on every party's reading: a real order of
Father and Son in the work of salvation. -/
@[trinityDefs]
def orderLine : Line Claim :=
  { name := "The order texts: the Son sent, obedient, and subject at the end"
  , grounds := orderTexts
  , step := textsEstablishOrder
  , delivers := p .realOrder
  , inference := some onTheOrder }

/-- **LST's position on the order texts**: the texts, and the order they
establish. Every premise is a text, cited to Scripture alone. -/
@[trinityDefs]
def lstOrderCase : ArgumentPackage Claim :=
  orderLine.asPackage cite "there is a real order of Father and Son"

/-! ### Is the Son less in his divinity? -/

/-- The Arian step: "greater" means lesser divinity. -/
@[trinityDefs]
def greaterToLesserDivinity : Formula Claim :=
  ⋀ [p .fatherIsGreater, p .greaterMeansLesserDivinity] ➝ p .sonLesserInDivinity

/-- **The Arian line**, as Augustine and Calvin report it. -/
@[trinityDefs]
def arianLine : Line Claim :=
  { name := "\"The Father is greater\": a lesser divinity (the Arians)"
  , grounds := [p .greaterMeansLesserDivinity]
  , step := greaterToLesserDivinity
  , delivers := p .sonLesserInDivinity
  , inference := some onTheArianReading }

/-- **The Arian position**: the order texts, and John 14:28 read as lesser
divinity. -/
@[trinityDefs]
def arianCase : ArgumentPackage Claim :=
  { name := "The Son less in divinity (the Arians)"
  , cite := cite
  , premises := caseOf [orderLine, arianLine] [] []
  , conclusion := p .sonLesserInDivinity
  , conclusionLabel := "the Son is less than the Father in his divinity"
  , inferences := [onTheOrder, onTheArianReading] }

/-- Augustine's step: less in the form of a servant, equal in the form of God. -/
@[trinityDefs]
def twoFormsToEquality : Formula Claim :=
  ⋀ [p .fatherIsGreater, p .sonInTheFormOfGod, p .lessInTheFormOfAServant]
  ➝ notP .sonLesserInDivinity

/-- **Augustine's line**, by the two forms. -/
@[trinityDefs]
def augustineLine : Line Claim :=
  { name := "Less in the form of a servant, equal in the form of God (Augustine)"
  , grounds := [p .sonInTheFormOfGod, p .lessInTheFormOfAServant]
  , step := twoFormsToEquality
  , delivers := notP .sonLesserInDivinity
  , inference := some onTheTwoForms }

/-- **Augustine's position.** -/
@[trinityDefs]
def augustineCase : ArgumentPackage Claim :=
  { name := "Equal in nature, less in the form of a servant (Augustine)"
  , cite := cite
  , premises := caseOf [orderLine, augustineLine] [] []
  , conclusion := notP .sonLesserInDivinity
  , conclusionLabel := "the Son is not less than the Father in his divinity"
  , inferences := [onTheOrder, onTheTwoForms] }

/-- Athanasius's step: "greater" as the one the Son is from, so "proper to His
essence". -/
@[trinityDefs]
def begetterToEquality : Formula Claim :=
  ⋀ [p .fatherIsGreater, p .greaterAsBegetter] ➝ notP .sonLesserInDivinity

/-- **Athanasius's line.** -/
@[trinityDefs]
def athanasiusLine : Line Claim :=
  { name := "Greater as the one he is from (Athanasius)"
  , grounds := [p .greaterAsBegetter]
  , step := begetterToEquality
  , delivers := notP .sonLesserInDivinity
  , inference := some onTheBegetter }

/-- **Athanasius's position.** -/
@[trinityDefs]
def athanasiusCase : ArgumentPackage Claim :=
  { name := "Greater as the one he is from (Athanasius)"
  , cite := cite
  , premises := caseOf [orderLine, athanasiusLine] [] []
  , conclusion := notP .sonLesserInDivinity
  , conclusionLabel := "the Son is not less than the Father in his divinity"
  , inferences := [onTheOrder, onTheBegetter] }

/-- Calvin's step: the verse compares the Mediator's state with his glory, so it
does not say the Son is less in divinity. -/
@[trinityDefs]
def mediatorsStateAnswersArius : Formula Claim :=
  ⋀ [p .fatherIsGreater, p .greaterAsMediatorsState] ➝ notP .greaterMeansLesserDivinity

/-- Calvin against the Fathers' reply: the verse does not speak of the Son's
human nature either. -/
@[trinityDefs]
def mediatorsStateAnswersTheFathers : Formula Claim :=
  p .greaterAsMediatorsState ➝ notP .lessInTheFormOfAServant

/-- **Calvin's line.** -/
@[trinityDefs]
def calvinLine : Line Claim :=
  { name := "The Mediator's humbled state (Calvin)"
  , grounds := [p .greaterAsMediatorsState]
  , step := mediatorsStateAnswersArius
  , delivers := notP .greaterMeansLesserDivinity
  , inference := some onTheMediatorsState }

/-- **Calvin's position**: John 14:28 does not say the Son is less in divinity,
nor speak of his human nature. -/
@[trinityDefs]
def calvinCase : ArgumentPackage Claim :=
  { name := "The Mediator's state, not his natures (Calvin)"
  , cite := cite
  , premises := caseOf [orderLine, calvinLine] [] [mediatorsStateAnswersTheFathers]
  , conclusion := notP .greaterMeansLesserDivinity
  , conclusionLabel := "John 14:28 does not say the Son is less in divinity"
  , inferences := [onTheOrder, onTheMediatorsState, onCalvinAgainstTheFathers] }

/-! ### Is the order eternal? -/

/-- From the order, read as eternal, to an eternal relationship of authority and
submission. -/
@[trinityDefs]
def orderToEternalAuthority : Formula Claim :=
  ⋀ [p .realOrder, p .orderIsEternal] ➝ p .eternalAuthorityAndSubmission

/-- **The line of Grudem and Ware.** -/
@[trinityDefs]
def eternalOrderLine : Line Claim :=
  { name := "The order is eternal (Grudem, Ware)"
  , grounds := [p .orderIsEternal]
  , step := orderToEternalAuthority
  , delivers := p .eternalAuthorityAndSubmission
  , inference := some onTheEternalOrder }

/-- **The position of Grudem and Ware.** -/
@[trinityDefs]
def eternalAuthorityCase : ArgumentPackage Claim :=
  { name := "Eternal authority and submission (Grudem, Ware)"
  , cite := cite
  , premises := caseOf [orderLine, eternalOrderLine] [] []
  , conclusion := p .eternalAuthorityAndSubmission
  , conclusionLabel := "there is an eternal relationship of authority and submission"
  , inferences := [onTheOrder, onTheEternalOrder] }

/-- From the Son's equality in power, and eternal subordination's denial of it, to
no eternal subordination in authority. -/
@[trinityDefs]
def equalPowerExcludesSubordination : Formula Claim :=
  ⋀ [p .sonEqualInPower, p .subordinationDeniesEqualPower]
  ➝ notP .eternalAuthorityAndSubmission

/-- **Giles's line.** -/
@[trinityDefs]
def equalPowerLine : Line Claim :=
  { name := "Equal in power, so not eternally subordinate (Giles)"
  , grounds := [p .sonEqualInPower, p .subordinationDeniesEqualPower]
  , step := equalPowerExcludesSubordination
  , delivers := notP .eternalAuthorityAndSubmission
  , inference := some onEqualPower }

/-- **Giles's position.** -/
@[trinityDefs]
def equalAuthorityCase : ArgumentPackage Claim :=
  { name := "No eternal subordination in authority (Giles)"
  , cite := cite
  , premises := caseOf [orderLine, equalPowerLine] [] []
  , conclusion := notP .eternalAuthorityAndSubmission
  , conclusionLabel := "there is no eternal subordination of the Son in authority"
  , inferences := [onTheOrder, onEqualPower] }

/-! ### Readings, written down -/

/-- **The Arian reading**: every order text, the order, John 14:28 as lesser
divinity, and the Son less in his divinity; none of the three Nicene readings of
the verse. -/
def arianReading : Valuation Claim := fun a =>
  match a with
  | .lessInTheFormOfAServant | .greaterAsBegetter | .greaterAsMediatorsState => False
  | _ => True

/-- **Augustine's reading**: every order text, the order, the two forms, and the
Son not less in divinity; not the Arian reading, and not Calvin's, which denies
the two forms. -/
def augustineReading : Valuation Claim := fun a =>
  match a with
  | .greaterMeansLesserDivinity | .sonLesserInDivinity | .greaterAsMediatorsState => False
  | _ => True

/-- **Calvin's reading**: every order text, the order, the Mediator's state, and
neither the Arian reading nor the two forms. -/
def calvinReading : Valuation Claim := fun a =>
  match a with
  | .greaterMeansLesserDivinity | .sonLesserInDivinity | .lessInTheFormOfAServant => False
  | _ => True

/-- **The reading of Grudem and Ware**: every order text, the order, the order
read as eternal, and an eternal relationship of authority and submission. Giles's
reading, that such an order would deny the Son's equal power, is not theirs. -/
def eternalAuthorityReading : Valuation Claim := fun a =>
  match a with
  | .subordinationDeniesEqualPower => False
  | _ => True

/-- **Giles's reading**: every order text, the order, the Son equal in power, and
no eternal subordination in authority; the order not read as eternal. -/
def equalAuthorityReading : Valuation Claim := fun a =>
  match a with
  | .orderIsEternal | .eternalAuthorityAndSubmission => False
  | _ => True

/-! ### What the order texts settle, and what they leave open -/

/-- **Grant the order texts, and there is a real order of Father and Son.** This
is what LST says they establish, and every party here grants it. -/
@[headline]
theorem lstOrder_establishes : Establishes lstOrderCase := by
  establish [trinityDefs]

#print axioms lstOrder_establishes

/-- LST's position on the order texts can be held without contradiction. -/
theorem lstOrderCase_is_satisfiable : Satisfiable lstOrderCase.premises := by
  satisfied_by augustineReading [trinityDefs]

/-- **The order texts leave open whether the Son is less in his divinity.**
Granted the five texts and the order they establish, neither "the Son is less
than the Father in his divinity" nor its denial follows: the Arian reading
satisfies every premise with it, and Augustine's without it.

That is LST's claim, and it holds. Whether the Son is less in his divinity is
argued from readings of John 14:28 the texts do not contain, and from other
texts, which the next question of LST §3 takes up. -/
@[headline]
theorem order_texts_leave_lesser_divinity_open :
    Independent lstOrderCase.premises (p .sonLesserInDivinity) := by
  leaves_open augustineReading arianReading [trinityDefs]

#print axioms order_texts_leave_lesser_divinity_open

/-- **The order texts leave open whether the order is eternal.** Granted the
texts and the order, neither an eternal relationship of authority and submission
nor its denial follows: the reading of Grudem and Ware satisfies every premise
with it, and Giles's without it.

That is LST's further claim, and it holds. Erickson draws the same conclusion
about the texts of sending and commanding, that "they do not count as evidence
in support of an eternal supremacy of the Father" (as Grudem quotes him). -/
@[headline]
theorem order_texts_leave_eternal_authority_open :
    Independent lstOrderCase.premises (p .eternalAuthorityAndSubmission) := by
  leaves_open equalAuthorityReading eternalAuthorityReading [trinityDefs]

#print axioms order_texts_leave_eternal_authority_open

/-! ### What each position delivers -/

/-- **Grant John 14:28 read as lesser divinity, and the Son is less than the
Father in his divinity.** -/
@[headline]
theorem arianCase_establishes : Establishes arianCase := by
  establish [trinityDefs]

#print axioms arianCase_establishes

/-- The Arian position can be held without contradiction. -/
theorem arianCase_is_satisfiable : Satisfiable arianCase.premises := by
  satisfied_by arianReading [trinityDefs]

/-- **Grant Augustine's two forms, and the Son is not less in his divinity.** -/
@[headline]
theorem augustineCase_establishes : Establishes augustineCase := by
  establish [trinityDefs]

#print axioms augustineCase_establishes

/-- Augustine's position can be held without contradiction. -/
theorem augustineCase_is_satisfiable : Satisfiable augustineCase.premises := by
  satisfied_by augustineReading [trinityDefs]

/-- **Grant Athanasius's reading of "greater", and the Son is not less in his
divinity.** -/
@[headline]
theorem athanasiusCase_establishes : Establishes athanasiusCase := by
  establish [trinityDefs]

#print axioms athanasiusCase_establishes

/-- Athanasius's position can be held without contradiction. -/
theorem athanasiusCase_is_satisfiable : Satisfiable athanasiusCase.premises := by
  satisfied_by augustineReading [trinityDefs]

/-- **Grant Calvin's reading, and John 14:28 does not say the Son is less in his
divinity.** -/
@[headline]
theorem calvinCase_establishes : Establishes calvinCase := by
  establish [trinityDefs]

#print axioms calvinCase_establishes

/-- Calvin's position can be held without contradiction. -/
theorem calvinCase_is_satisfiable : Satisfiable calvinCase.premises := by
  satisfied_by calvinReading [trinityDefs]

/-- **Grant the order read as eternal, and there is an eternal relationship of
authority and submission.** -/
@[headline]
theorem eternalAuthorityCase_establishes : Establishes eternalAuthorityCase := by
  establish [trinityDefs]

#print axioms eternalAuthorityCase_establishes

/-- The position of Grudem and Ware can be held without contradiction. -/
theorem eternalAuthorityCase_is_satisfiable : Satisfiable eternalAuthorityCase.premises := by
  satisfied_by eternalAuthorityReading [trinityDefs]

/-- **Grant the Son equal in power, and that eternal subordination would deny it,
and there is no eternal subordination in authority.** -/
@[headline]
theorem equalAuthorityCase_establishes : Establishes equalAuthorityCase := by
  establish [trinityDefs]

#print axioms equalAuthorityCase_establishes

/-- Giles's position can be held without contradiction. -/
theorem equalAuthorityCase_is_satisfiable : Satisfiable equalAuthorityCase.premises := by
  satisfied_by equalAuthorityReading [trinityDefs]

end TestimonyArguments.Trinity
