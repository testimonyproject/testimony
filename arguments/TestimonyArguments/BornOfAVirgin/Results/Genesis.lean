import TestimonyArguments.BornOfAVirgin.Packages
import Testimony.Logic.Tactic
import Testimony.Logic.Dilemma

/-!
# TestimonyArguments.BornOfAVirgin.Results.Genesis — what "her seed" says of a father

A reader's question, in a reader's words: *Genesis 3:15 promises that "her seed"
will strike the serpent's head — the woman's seed, not the man's. Doesn't that
already point to a virgin conception? And doesn't the Greek, which calls the
seed "he", make it plainer?*

The short answer: it may, but the text does not settle it. Whether naming the
seed as the woman's *says* there will be no human father is a live dispute among
readers most of whom hold the virgin birth, and the library finds it a tie
(`nothing_prevails_over_her_seed`, in `Dispute.Genesis`). That the wording
*fits* the virgin birth, once it has happened, Luther's side and Leupold and
Keil all grant. The Greek may show
that its translator expected one person; it does not show how that person would
be born.

The protoevangelium strand of this argument holds, as a premise, that the seed
being named as the woman's marks a birth with no human father
(`seedOfTheWomanImpliesNoHumanFather`). "Marks" is vague on purpose, as its
holders leave it: Miravalle's own word is "hint". This module asks what it can
mean, and what each meaning can bear.

**Read as what the wording itself signifies**, it is Luther's argument: the seed
of other women "might rather be said to have been the seed of the man", but
Mary's was "the true Seed of Mary" (*Luther on the Creation* 298–99). He finds
the sense in the words of Genesis, and holds that Isaiah later "threw some
additional light" on it, so that "it was then made certain" (298).
`herSeedCase_establishes` grants him every ground and checks that the argument
goes through. It rests on his step (`her_seed_rests_on_its_inference`). The
Lutheran commentators Leupold and Keil, who hold the virgin birth, grant every
ground and deny the step. Leupold, asked whether the expression is "so phrased
in reference to Mary and the virgin birth", answers "Not primarily, but at least
incidentally": it "does not specifically prophesy the virgin birth" (169). Keil
finds the virgin birth in the promise's fulfilment, "even if the words had
reference first of all to the fact that the woman had been led astray" (102).
Jack P. Lewis denies the step too, pointing to Hagar and Rebekah, whose seed
Genesis also calls theirs (299–300); he doubts the promise reading itself, but
his argument does not need that doubt.

**Read as what the wording fits, once fulfilled**, it is granted by Leupold and
Keil, who deny the first reading. Leupold: "it coincides and agrees with it under
divine providence" (169). Keil: the promise was fulfilled "even in its apparently
casual form" (102). But they reach the fit from the conception: the wording is
seen to fit once the birth is known. Read this way, the verse confirms the
virgin birth to one who already believes it, and gives no reason to believe it
to one who does not. That is what the reading's own grounds say; it is not a
separate theorem. `whatHerSeedMarks` sets out both readings and what answers
each.

**The promise, and its fulfilment.** Whether the wording foretold a virgin birth
is one question. Whether the promise is fulfilled in Jesus is another, and it
does not need the first. Every term of the verse is met as the New Testament
names it: the woman's seed, the Son "made of a woman" (Galatians 4:4); the
serpent, "that old serpent, called the Devil" (Revelation 12:9); its head
crushed, when the Son destroys the devil "through death" (Hebrews 2:14); his heel
struck, in his death and rising. That fulfilment confirms that the verse was a
promise, and it does so for a reader who denies the virginal conception too.
With the virginal conception, it says one thing more: the seed in whom the
promise is fulfilled was of the woman alone. `Dispute.Protoevangelium` weighs
the fulfilment against Westermann's denial that the verse is a promise at
all.

**The Greek's "he".** The Septuagint calls the woman's seed "he", αὐτός, though
σπέρμα is neuter, and Collins finds it "beyond question that the translator of
Genesis 3:15 meant to convey that an individual was promised" (145)
(`greekHeCase_establishes`). If so, it shows how one Jewish translator before
Christ read the promise, and reading it of one person is no Christian invention.
But the earliest known reader of that Greek did not read it so: Philo calls the
masculine "as to its language, a barbarism, but, as to the meaning … a correct
expression", and takes "he" of the mind (*Allegorical Interpretation* III.188).
The claim is `disputed` on him. No other text before Christ reads the verse of
one victor; the Targums, later, read it of "the sons of the woman", with a
remedy "in the days of the King Messiah" (Lewis 301).
Whether the Hebrew says so is a further question: Collins argues that its syntax
is "quite consistent with the pattern where a single individual is in view"
(145), and reports that many think it does not (141); Lewis, who grants the
Greek's reading, allows that the masculine "could be an oversight" (300). Either
way,
the Greek says nothing of a father (`the_greek_he_leaves_the_father_open`): the
same Greek calls the seed Hannah asks for "him" (1 Samuel 1:11), and the seed
promised to David "he" (2 Samuel 7:12–14), and each has a father. Irenaeus,
quoting the verse as the Greek gives it, "He shall be on the watch for thy
head", reads it of "He who should be born of a woman, [namely] from the Virgin"
(*Against Heresies* V.21.1); but he does not argue from the pronoun to the
conception, and no reader found does.

`Dispute.Genesis` weighs Luther's case against Leupold's and Lewis's.
-/

namespace TestimonyArguments.BornOfAVirgin

open Testimony

open Testimony Testimony.Bib Testimony.Logic

/-! ### Two readings of the woman's seed

Each reading below is a model: one way every claim of the argument could be true
at once, named for what it says of the wording of Genesis 3:15. Some pairs of
claims in this argument cannot both be true, so each model has to take a side on
them; on questions this module does not touch it takes the scriptural reading's
side: that the Septuagint's παρθένος means a virgin, that Micah's mention of a
mother and no father does mean something, and that Scripture, not the
magisterium, is the judge. Every other claim it leaves true, and none of them
bears on the results it is used for. -/

/-- Luther's reading: the seed named as the woman's, and not a man's, signifies
a birth with no human father, and the promise is fulfilled in one so born. -/
def lutherReading : Valuation Claim := fun a =>
  match a with
  | .parthenosMeantYoungWoman => False
  | .parthenosDoesNotItselfConnoteVirginity => False
  | .parthenosDescribesDinahAsSheThenWas => False
  | .maternalSilenceProvesNothing => False
  | .magisteriumIsDoctrinallyAuthoritative => False
  | _ => True

/-- Leupold's reading: the promise is of the victor, "her seed" is first
collective, the woman's posterity, the woman is named because she was deceived,
and the wording does not itself signify a birth without a human father — though
it fits one, as fulfilled. Lewis's claims hold in it too: Genesis speaks of a
woman's seed in ordinary births. And "her seed", though collective first, is not
only a line of descendants: "the word is also used in reference to an individual"
(168). -/
def leupoldReading : Valuation Claim := fun a =>
  match a with
  | .wordingSignifiesAFatherlessBirth => False
  | .seedIsLineNotIndividual => False
  | .parthenosMeantYoungWoman => False
  | .parthenosDoesNotItselfConnoteVirginity => False
  | .parthenosDescribesDinahAsSheThenWas => False
  | .maternalSilenceProvesNothing => False
  | .magisteriumIsDoctrinallyAuthoritative => False
  | _ => True

/-! ### The wording read as signifying -/

/-- **Luther's case from the wording goes through.** Grant that Genesis 3:15
names the seed as the woman's, that it is the first promise of a redeemer, that
a man's seed is ordinarily reckoned through him, and Luther's step from these to
the wording's sense: the wording signifies a birth with no human father.

It does not show that the step is sound — Leupold, Keil and Lewis deny it
(`her_seed_rests_on_its_inference`) — nor that the promise was fulfilled. -/
@[headline]
theorem herSeedCase_establishes : Establishes herSeedCase := by
  establish [bornOfAVirginDefs]

#print axioms herSeedCase_establishes

/-- Luther's case has a model: his own reading. -/
theorem herSeedCase_is_satisfiable : Satisfiable herSeedCase.premises := by
  satisfied_by lutherReading [bornOfAVirginDefs]

/-- **The wording's sense rests on Luther's step.** Grant every ground — the
seed named as the woman's, Genesis 3:15 as the first promise of a redeemer, a
man's seed reckoned through him — and it still does not follow that the wording
signifies a birth with no human father. Leupold and Keil grant those grounds and
deny it, and Lewis, granting the messianic reading for argument's sake, denies
it too. On Leupold's reading the seed is named the woman's because she was
deceived, and "her seed" is first collective, her posterity.

So the claim does not follow from the grounds alone: it needs Luther's step,
rated `disputed`. That does not show the step is wrong, only that the wording,
which both sides read, does not decide between them. -/
@[headline]
theorem her_seed_rests_on_its_inference :
    ¬ Entails herSeedLine.grounds (p .wordingSignifiesAFatherlessBirth) := by
  refute_with leupoldReading [bornOfAVirginDefs]

#print axioms her_seed_rests_on_its_inference

/-- Leupold's case goes through on its own grounds. -/
theorem posterityCase_establishes : Establishes posterityCase := by
  establish [bornOfAVirginDefs]

/-- Leupold's case has a model: his own reading. -/
theorem posterityCase_is_satisfiable : Satisfiable posterityCase.premises := by
  satisfied_by leupoldReading [bornOfAVirginDefs]

/-- Lewis's case goes through on its own grounds. -/
theorem idiomCase_establishes : Establishes idiomCase := by
  establish [bornOfAVirginDefs]

/-- Lewis's case has a model: Leupold's reading, in which Lewis's claims hold
too. -/
theorem idiomCase_is_satisfiable : Satisfiable idiomCase.premises := by
  satisfied_by leupoldReading [bornOfAVirginDefs]

/-! ### The Greek's "he" -/

/-- **The Greek reads one person.** Grant that the Septuagint refers to the
woman's seed with the masculine αὐτός, though σπέρμα is neuter, and the step
Collins and Martin take from it, and its translator read the seed as one person.

That is all it delivers: who that person is, and how he is born, it does not
say. -/
@[headline]
theorem greekHeCase_establishes : Establishes greekHeCase := by
  establish [bornOfAVirginDefs]

#print axioms greekHeCase_establishes

/-- The Greek's line has a model. -/
theorem greekHeCase_is_satisfiable : Satisfiable greekHeCase.premises := by
  satisfied_by leupoldReading [bornOfAVirginDefs]

/-- **The Greek's "he" leaves the father open.** Keep the Greek's masculine "he"
and the reading of one person drawn from it, and every ground of Luther's case
— the seed named as the woman's, the first promise of a redeemer, a man's seed
reckoned through him — and whether the wording signifies a birth with no human
father is independent of all of it. On Luther's reading it does; on Leupold's,
granted the Greek, it does not.

The result has two halves: the Greek does not show that the one person promised
has no human father, and does not show that he has one. The plain reason is in
the Greek itself: it calls the seed Hannah asks for "him" (1 Samuel 1:11), and
the seed promised to David "he" (2 Samuel 7:12–14), as Collins shows (144), and
each has a father. One person, called "he", can have a father. What the Greek
shows is how its translator read the promise: of one person. Collins argues
that the Hebrew's syntax is "quite consistent with the pattern where a single
individual is in view" (145); Leupold reaches one person at the promise's end,
and Keil reaches Christ "not as an individual, but as the head" of the woman's
posterity (102). No reader found argues that the Greek's "he" answers Lewis's
point from Hagar and Rebekah. -/
@[headline]
theorem the_greek_he_leaves_the_father_open :
    Independent greekHeWithThePromise.premises (p .wordingSignifiesAFatherlessBirth) := by
  leaves_open leupoldReading lutherReading [bornOfAVirginDefs]

#print axioms the_greek_he_leaves_the_father_open

/-! ### What "marks" means: the dilemma -/

/-- The hinge **read as what the wording itself signifies**: Luther's reading,
and the one Miravalle and Henry give. -/
@[bornOfAVirginDefs]
def asWhatTheWordingSignifies : Reading Claim :=
  { name := "as what the wording itself signifies"
  , commits := p .wordingSignifiesAFatherlessBirth
  , source :=
      { primary := .work lutherOnTheCreation (.pages 298 299)
      , supporting :=
          [ .work miravalleMeetYourMother .whole
          , .work henryCommentary (.adLoc Scripture.genesis3_15) ]
      , tradition := .christianTypological
      , confidence := .disputed } }

/-- The hinge **read as what the wording fits, once fulfilled**: Leupold's and
Keil's reading, which rests the fit on the virginal conception itself. -/
@[bornOfAVirginDefs]
def asWhatTheWordingFits : Reading Claim :=
  { name := "as what the wording fits, once fulfilled"
  , commits := p .wordingFitsAFatherlessBirth
  , grounds :=
      [ p .maryConceivedAsVirgin
      , p .maryConceivedAsVirgin ➝ p .wordingFitsAFatherlessBirth ]
  , source :=
      { primary := .work leupoldGenesis (.page 169)
      , supporting := [.work keilDelitzschPentateuch (.page 102)]
      , tradition := .christianHistoricalGrammatical
      , confidence := .disputed } }

/-- The protoevangelium strand with its hinge read as Luther reads it. -/
@[bornOfAVirginDefs]
def protoevangeliumAsSignifying : ArgumentPackage Claim :=
  protoevangeliumCase.readAs (p .seedOfTheWomanImpliesNoHumanFather) asWhatTheWordingSignifies

/-- The protoevangelium strand with its hinge read as Leupold reads it. -/
@[bornOfAVirginDefs]
def protoevangeliumAsFitting : ArgumentPackage Claim :=
  protoevangeliumCase.readAs (p .seedOfTheWomanImpliesNoHumanFather) asWhatTheWordingFits

/-- **The strand, read as Luther reads its hinge, is consistent**: its premises
can all be true together, so any answer to it must come from outside it. -/
theorem protoevangeliumAsSignifying_is_satisfiable :
    Satisfiable protoevangeliumAsSignifying.premises := by
  satisfied_by lutherReading [bornOfAVirginDefs, ArgumentPackage.readAs]

/-- **The strand, read as Leupold reads its hinge, is consistent** too. -/
theorem protoevangeliumAsFitting_is_satisfiable :
    Satisfiable protoevangeliumAsFitting.premises := by
  satisfied_by leupoldReading [bornOfAVirginDefs, ArgumentPackage.readAs]

/-- **Leupold has no quarrel with the second reading; he holds it.** Read as
what the wording fits once fulfilled, the strand's hinge can be held with every
premise of Leupold's case. -/
theorem posterity_does_not_reach_the_fit :
    Satisfiable (posterityCase.premises ++ protoevangeliumAsFitting.premises) := by
  satisfied_by leupoldReading [bornOfAVirginDefs, ArgumentPackage.readAs]

/-- **Nor does Lewis.** The idiom of Hagar and Rebekah bears on what the wording
signifies, not on what it fits once fulfilled. -/
theorem idiom_does_not_reach_the_fit :
    Satisfiable (idiomCase.premises ++ protoevangeliumAsFitting.premises) := by
  satisfied_by leupoldReading [bornOfAVirginDefs, ArgumentPackage.readAs]

/-- **Why Leupold stands against the hinge, read as Luther reads it.** The crux
is Leupold's step: "her seed" is first collective, the woman's posterity, and
the woman is named because she was deceived, so the wording does not itself signify
a birth without a human father. No one can hold both Leupold's case and the
hinge read Luther's way; which gives way is the dispute's question, and
`Dispute.Genesis` finds a tie. What cannot be held with Leupold is the hinge
together with the reading, nothing else in the strand, and the step is rated
`disputed`: Irenaeus grants both its grounds, and Henry the second, and both
read the verse of the Virgin's son. -/
def whereTheSignifyingReadingMeetsLeupold : Because posterityCase protoevangeliumAsSignifying :=
  Because.ofChecks posterityLine.step posterityLine.grounds [] posterityLine.grounds
    [ p .seedOfTheWomanImpliesNoHumanFather
    , p .seedOfTheWomanImpliesNoHumanFather ➝ p .wordingSignifiesAFatherlessBirth ]
    .derives posterityCase_establishes posterityCase_is_satisfiable
    (by simp [posterityCase, Line.asPackage, Line.premises])
    (fun φ hφ => by
      simp only [posterityCase, Line.asPackage, Line.premises, List.mem_append,
        List.mem_cons, List.not_mem_nil, or_false] at hφ ⊢
      tauto)
    (by simp [bornOfAVirginDefs, ArgumentPackage.readAs, Line.asPackage, Line.premises])
    (by decide +kernel)

/-- **Why Lewis stands against the hinge, read as Luther reads it.** The crux is
Lewis's step: Genesis speaks of Hagar's and Rebekah's seed too, so the woman's
seed at 3:15 does not by itself signify a birth without a human father. Rated
`disputed`, on Jimmy Akin, who grants that a woman's seed "is not outside the
bounds of Hebrew expression" and agrees with the "many" who have "rightly seen"
the wording as "a hint of the Virgin Birth". -/
def whereTheSignifyingReadingMeetsLewis : Because idiomCase protoevangeliumAsSignifying :=
  Because.ofChecks idiomLine.step idiomLine.grounds [] idiomLine.grounds
    [ p .seedOfTheWomanImpliesNoHumanFather
    , p .seedOfTheWomanImpliesNoHumanFather ➝ p .wordingSignifiesAFatherlessBirth ]
    .derives idiomCase_establishes idiomCase_is_satisfiable
    (by simp [idiomCase, Line.asPackage, Line.premises])
    (fun φ hφ => by
      simp only [idiomCase, Line.asPackage, Line.premises, List.mem_append,
        List.mem_cons, List.not_mem_nil, or_false] at hφ ⊢
      tauto)
    (by simp [bornOfAVirginDefs, ArgumentPackage.readAs, Line.asPackage, Line.premises])
    (by decide +kernel)

/-- **What the woman's seed marks, read both ways.** The claim is the
protoevangelium strand's hinge: the seed being named as the woman's marks a
birth with no human father. These are the two readings found in the sources;
a reader with a third would add a third horn.

Read as what the wording itself signifies (Luther's reading), it cannot be held
together with Leupold's case or with Lewis's. Each breaks it at a step rated
`disputed`, not at a ground. Leupold's grounds, that the seed is named the
woman's because she was deceived and that "her seed" is first collective, her
posterity, are rated `wellSupported` and `disputed`; Lewis's, that Genesis says "her
seed" of Hagar and of Rebekah, each with a father, is common ground. What is
contested is the step from them to "so the wording does not signify a birth
without a father". A reader who takes those steps rejects Luther's reading. One
who grants the grounds and refuses the steps need not, as Irenaeus does with
Leupold's and Akin with Lewis's. "Cannot be held together" says that no one
can hold both, not which gives way: `Dispute.Genesis` weighs that, and finds a
tie.

Read as what the wording fits, once fulfilled (Leupold's and Keil's reading),
neither case touches it: Leupold and Keil hold it. But the reading rests on the
virginal conception itself (`maryConceivedAsVirgin`). That is rated `disputed`
because Brown, the historian this argument cites, leaves the question
unresolved; the rating records that it is contested, not that the library
doubts it. On this reading the strand can show that the promise suits a birth
already believed, not that the promise foretold it.

Neither reading is a straw man: read either way, the strand's premises can all
be true together. -/
def whatHerSeedMarks : Dilemma protoevangeliumCase where
  claim := p .seedOfTheWomanImpliesNoHumanFather
  horns :=
    [ { reading := asWhatTheWordingSignifies
      , fair := protoevangeliumAsSignifying_is_satisfiable
      , fates :=
          [ .falls posterityCase whereTheSignifyingReadingMeetsLeupold
          , .falls idiomCase whereTheSignifyingReadingMeetsLewis ]
      , answered := by simp }
    , { reading := asWhatTheWordingFits
      , fair := protoevangeliumAsFitting_is_satisfiable
      , fates :=
          [ .unreached posterityCase posterityCase_establishes
              posterity_does_not_reach_the_fit
          , .unreached idiomCase idiomCase_establishes idiom_does_not_reach_the_fit ]
      , answered := by simp } ]
  claim_mem := by simp [bornOfAVirginDefs, Line.asPackage, Line.premises]
  two := by simp

end TestimonyArguments.BornOfAVirgin
