import Testimony.Semantics.Meaning
import TestimonyArguments.CanonicalWitness.Sources

/-!
# TestimonyArguments.Meanings.CanonicalWitness — what each the canonical witness claim says

Twenty-seven of the twenty-nine claims have meanings (`coverage_now`), so every one of the
argument's eight lines can be read as a move and checked for the three fallacies
(`Testimony.Checks.Fallacies`). `TestimonyArguments.Meanings.SolaFide` is the fuller worked
example. The same kinds of claim are stated here in the same forms, with one difference, in
how a text's "by" is read.

## The texts

Each text says what it says, in its own words. Romans 3:28 says a person is justified
(δικαιόω) by faith (πίστις) apart from works of the law (ἔργα νόμου). What those words mean in
Paul is a further claim, and this argument makes none: it reads each corpus in a step, and the
step is where the reading is.

So where a text says a thing comes "by" or "through" faith, grace or mercy, the meaning says
only that the text says so, and leaves open whether faith is the ground, the means or the
evidence. Rome and the Reformers read that "by" differently. Trent's Decree on Justification
calls faith "the beginning of human salvation" (chapter 8) and baptism the instrument (chapter
7), and a meaning that called faith the instrument in Romans 3:28 would have read the verse for
one side. The sola fide meanings do call faith the means in Romans 3:28 and Ephesians 2:8, and
grace the ground in Ephesians 2:8; here the same verses say only "by". Where a text says "not
by works", the meaning says the works are not the ground, because that is what both sides take
"not by" to deny, as the sola fide meanings do.

Several texts turn on words of their own, and each meaning keeps the text's word: to live (ζάω)
in Galatians 3:11 and Hebrews 10:38; to please (εὐαρεστέω) in Hebrews 11:6; the preserving of
the soul (περιποίησις ψυχῆς) in Hebrews 10:39; John 5:24's "whoever hears my word and believes",
kept as one phrase; James's "faith by itself" and "dead" (2:17) and "faith was completed"
(2:22); mercy (ἔλεος) in Titus 3:5; and "his name" (ὄνομα) in Acts 10:43. Two concepts serve
them as well: not being condemned, which John 3:18 says of whoever believes and 5:24 calls not
coming into judgement, and a verdict.

Four texts needed a judgement about what they say.

- **John 3:16–18** says that whoever believes has eternal life, so believing suffices; and that
  whoever does not believe is condemned already, so believing is needed not to be condemned.
- **Acts 15:10–11.** Peter asks why the council should "put a yoke on the neck of the
  disciples", and answers that "we shall be saved through the grace of the Lord Jesus". The
  question the council met to answer was whether a Gentile could be saved without circumcision
  and the law of Moses (15:1, 15:5). So the meaning says that the yoke (ζυγός) is not needed to
  be saved, which is Peter's answer to that question, and leaves the yoke's identity as a word:
  whether it is the law as a condition is a reading the sola fide argument rates.
- **Luke 18:9–14.** The tax collector, who prayed for mercy, went down to his house justified,
  and the Pharisee, who listed his works, did not. The meaning names the two men and says that
  the one was justified and the other was not, which is all the verse says.
- **James 2:21–23** says that Abraham's faith was completed by his works, and that he believed
  God and it was counted to him as righteousness. James joins the two by saying the scripture
  "was fulfilled", and the vocabulary has no word for a fulfilment, so the meaning keeps the two
  sayings and not the link between them.

James 2:24 says a person is justified by works and not by "faith alone" (πίστεως μόνον), and
both halves are said as the text says them: by works, and not by the phrase. The sola fide
meaning of the same verse reads the second half as a denial that faith is the only means.

## The doctrines and the readings

The three parts of *faith alone* are doctrine: faith is necessary, faith is sufficient, and works
are not the ground of justification. Good works, works done in grace, are the fruit of saving
faith and follow it.
Justification and sanctification are distinct: the one a verdict, the other a renewal that
follows it. That James 2:14–26 is aimed at another faith says that "faith" there means mere
assent, and denies that it has the sense Paul gives it. That James's "justified" is demonstrative
says that in 2:21–24 the word means to show someone to be righteous.

## Left unanalysed, and why

- **James 2:19**, "even the demons believe, and shudder". Every party takes the demons for
  persons who act, but the upper ontology's agents are DOLCE's agentive objects, physical or
  social, and a spirit is neither; giving the demons a category would settle what kind of thing a
  spirit is, which no one has argued here. The vocabulary has no word for their shuddering
  either. The verse is a ground of the James line and no part of its step, so leaving it costs no
  line its reading.
- **Jude 20–21**, "keep yourselves in the love of God". It is a command, and the vocabulary has no
  form for a command, as the sola fide meanings find of Christ's command to baptise.

## What is joined, and what is not

- **Justification by faith alone asserts its three parts.** The argument defines it so: faith is
  necessary, faith is sufficient, and works are not the ground. The step from the parts to the
  whole (`toFaithAlone`) is the converse.
- **"By faith alone, by a faith that is never alone" asserts "by faith alone"**, and with it the
  three parts. Its second clause is not the claim that works are faith's fruit (Westminster
  XVI.2), so that is not joined to it.

No other pair is joined. What a text says is kept whole, so no text entails a doctrine, and the
step from the texts to each part stays a reading, cited and rated. James 2:24's "not by faith
alone" and the doctrine are kept apart on purpose. The argument turns on whether James means
another faith (`james2TargetsDeadFaith`), and a meaning that joined the words would decide that
question before it is asked. The claim that James means mere assent, not Paul's sense, joins
nothing either: no claim of the argument says the two senses are the same.
-/

namespace TestimonyArguments.Meanings.CanonicalWitness

open Testimony

open Testimony.Semantics Testimony.Semantics.Notation
open TestimonyArguments.CanonicalWitness (Claim cite)

/-- Every atom of the argument, in declaration order. -/
def all : List Claim :=
  [ .romans3_28, .romans4_4_5, .galatians2_16, .galatians3_11, .ephesians2_8_9, .titus3_5
  , .hebrews10_38_39, .hebrews11_6, .john3_16_18, .john5_24, .john6_28_29, .acts10_43
  , .acts15_10_11, .luke7_50, .luke18_9_14, .james2_14_17, .james2_19, .james2_21_23, .james2_24
  , .jude20_21, .faithIsNecessary, .faithIsSufficient, .worksAreNotTheGround
  , .justificationByFaithAlone, .worksAreFruitOfFaith, .faithAloneNeverAlone
  , .james2TargetsDeadFaith, .jamesJustifiesDemonstratively
  , .justificationDistinctFromSanctification ]

/-- `all` has every atom. -/
theorem all_complete : ∀ a, a ∈ all := by intro a; cases a <;> decide

/-- Romans 3:28. -/
@[nolint defsWithUnderscore] abbrev rom3_28 : PassageRange := vs .romans 3 28
/-- Romans 4:4–5. -/
@[nolint defsWithUnderscore] abbrev rom4_4_5 : PassageRange := rg .romans 4 4 4 5
/-- Galatians 2:16. -/
@[nolint defsWithUnderscore] abbrev gal2_16 : PassageRange := vs .galatians 2 16
/-- Galatians 3:11. -/
@[nolint defsWithUnderscore] abbrev gal3_11 : PassageRange := vs .galatians 3 11
/-- Ephesians 2:8–9. -/
@[nolint defsWithUnderscore] abbrev eph2_8_9 : PassageRange := rg .ephesians 2 8 2 9
/-- Titus 3:5. -/
@[nolint defsWithUnderscore] abbrev titus3_5 : PassageRange := vs .titus 3 5
/-- Hebrews 10:38. -/
@[nolint defsWithUnderscore] abbrev heb10_38 : PassageRange := vs .hebrews 10 38
/-- Hebrews 10:39. -/
@[nolint defsWithUnderscore] abbrev heb10_39 : PassageRange := vs .hebrews 10 39
/-- Hebrews 11:6. -/
@[nolint defsWithUnderscore] abbrev heb11_6 : PassageRange := vs .hebrews 11 6
/-- John 3:16–18. -/
@[nolint defsWithUnderscore] abbrev john3_16_18 : PassageRange := rg .john 3 16 3 18
/-- John 5:24. -/
@[nolint defsWithUnderscore] abbrev john5_24 : PassageRange := vs .john 5 24
/-- John 6:29. -/
@[nolint defsWithUnderscore] abbrev john6_29 : PassageRange := vs .john 6 29
/-- Acts 10:43. -/
@[nolint defsWithUnderscore] abbrev acts10_43 : PassageRange := vs .acts 10 43
/-- Acts 15:10. -/
@[nolint defsWithUnderscore] abbrev acts15_10 : PassageRange := vs .acts 15 10
/-- Acts 15:11. -/
@[nolint defsWithUnderscore] abbrev acts15_11 : PassageRange := vs .acts 15 11
/-- Luke 7:50. -/
@[nolint defsWithUnderscore] abbrev luke7_50 : PassageRange := vs .luke 7 50
/-- Luke 18:14. -/
@[nolint defsWithUnderscore] abbrev luke18_14 : PassageRange := vs .luke 18 14
/-- James 2:14–26. -/
@[nolint defsWithUnderscore] abbrev james2_14_26 : PassageRange := rg .james 2 14 2 26
/-- James 2:17. -/
@[nolint defsWithUnderscore] abbrev james2_17 : PassageRange := vs .james 2 17
/-- James 2:22. -/
@[nolint defsWithUnderscore] abbrev james2_22 : PassageRange := vs .james 2 22
/-- James 2:23. -/
@[nolint defsWithUnderscore] abbrev james2_23 : PassageRange := vs .james 2 23
/-- James 2:24. -/
@[nolint defsWithUnderscore] abbrev james2_24 : PassageRange := vs .james 2 24

/-- Faith is necessary for justification. -/
abbrev faithNecessary : Statement := .holds (rl .necessaryFor (cn .faith) (cn .justification))

/-- Faith suffices for justification. -/
abbrev faithSufficient : Statement := .holds (rl .sufficientFor (cn .faith) (cn .justification))

/-- Works are not the ground of justification. -/
abbrev worksNotGround : Statement := .holds (rl .excludedFrom (cn .works) (cn .justification))

/-- Justification by faith alone: its three parts. -/
abbrev byFaithAlone : Statement := .also faithNecessary (.also faithSufficient worksNotGround)

/-- The tax collector of Luke 18:13, who stood far off and prayed for mercy. -/
abbrev taxCollector : Term := pt "the tax collector of Luke 18:13, who prayed for mercy" .agent

/-- The Pharisee of Luke 18:11–12, who listed his fasting and his tithes. -/
abbrev pharisee : Term := pt "the Pharisee of Luke 18:11–12, who listed his works" .agent

/-- **What each canonical witness atom asserts.** Twenty-seven are analysed; James 2:19 and
Jude 20–21 keep their citations' labels, marked unanalysed. -/
def means : Claim → Statement
  | .romans3_28 =>
    .says rom3_28 <| .both (rl .saidBy (wd .pistis rom3_28) (wd .dikaioo rom3_28))
      (rl .excludedFrom (wd .ergaNomou rom3_28) (wd .dikaioo rom3_28))
  | .romans4_4_5 =>
    .says rom4_4_5 <| .both (rl .saidBy (wd .pisteuo rom4_4_5) (wd .logizomai rom4_4_5))
      (rl .excludedFrom (wd .erga rom4_4_5) (wd .logizomai rom4_4_5))
  | .galatians2_16 =>
    .says gal2_16 <| .both (rl .excludedFrom (wd .ergaNomou gal2_16) (wd .dikaioo gal2_16))
      (rl .saidBy (wd .pistisChristou gal2_16) (wd .dikaioo gal2_16))
  | .galatians3_11 =>
    .says gal3_11 <| .both (rl .excludedFrom (cn .law) (wd .dikaioo gal3_11))
      (rl .saidBy (wd .pistis gal3_11) (wd .zao gal3_11))
  | .ephesians2_8_9 =>
    .says eph2_8_9 <| .both (rl .saidBy (cn .grace) (wd .sozo eph2_8_9)) <|
      .both (rl .saidBy (wd .pistis eph2_8_9) (wd .sozo eph2_8_9))
        (rl .excludedFrom (wd .erga eph2_8_9) (wd .sozo eph2_8_9))
  | .titus3_5 =>
    .says titus3_5 <| .both (rl .excludedFrom (wd .erga titus3_5) (wd .sozo titus3_5))
      (rl .saidBy (wd .eleos titus3_5) (wd .sozo titus3_5))
  | .hebrews10_38_39 =>
    .says (rg .hebrews 10 38 10 39) <| .both (rl .saidBy (wd .pistis heb10_38) (wd .zao heb10_38))
      (rl .saidBy (wd .pistis heb10_39) (wd .peripoiesisPsyches heb10_39))
  | .hebrews11_6 => .says heb11_6 (rl .necessaryFor (wd .pistis heb11_6) (wd .euaresteo heb11_6))
  | .john3_16_18 =>
    .says john3_16_18 <| .both (rl .sufficientFor (wd .pisteuo john3_16_18) (cn .eternalLife))
      (rl .necessaryFor (wd .pisteuo john3_16_18) (cn .noCondemnation))
  | .john5_24 =>
    .says john5_24 <| .both (rl .sufficientFor (wd .hearingAndBelieving john5_24) (cn .eternalLife))
      (rl .sufficientFor (wd .hearingAndBelieving john5_24) (cn .noCondemnation))
  | .john6_28_29 =>
    .says (rg .john 6 28 6 29) (rl .includes (wd .erga john6_29) (wd .pisteuo john6_29))
  | .acts10_43 =>
    .says acts10_43 <| .both (rl .sufficientFor (wd .pisteuo acts10_43) (cn .forgiveness))
      (rl .saidBy (wd .onoma acts10_43) (cn .forgiveness))
  | .acts15_10_11 =>
    .says (rg .acts 15 10 15 11) <|
      .both (.not (rl .necessaryFor (wd .zygos acts15_10) (wd .sozo acts15_11)))
        (rl .saidBy (cn .grace) (wd .sozo acts15_11))
  | .luke7_50 => .says luke7_50 (rl .saidBy (wd .pistis luke7_50) (wd .sozo luke7_50))
  | .luke18_9_14 =>
    .says (rg .luke 18 9 18 14) <| .both (rl .isA taxCollector (wd .dikaioo luke18_14))
      (.not (rl .isA pharisee (wd .dikaioo luke18_14)))
  | .james2_14_17 =>
    .says (rg .james 2 14 2 17) (rl .isA (wd .faithByItself james2_17) (wd .nekros james2_17))
  | .james2_19 => .opaque (cite .james2_19).label
  | .james2_21_23 =>
    .says (rg .james 2 21 2 23) <|
      .both (rl .saidBy (wd .erga james2_22) (wd .faithCompleted james2_22))
        (rl .saidBy (wd .pisteuo james2_23) (wd .logizomai james2_23))
  | .james2_24 =>
    .says james2_24 <| .both (rl .saidBy (wd .erga james2_24) (wd .dikaioo james2_24))
      (.not (rl .saidBy (wd .faithAlonePhrase james2_24) (wd .dikaioo james2_24)))
  | .jude20_21 => .opaque (cite .jude20_21).label
  | .faithIsNecessary => faithNecessary
  | .faithIsSufficient => faithSufficient
  | .worksAreNotTheGround => worksNotGround
  | .justificationByFaithAlone => byFaithAlone
  | .worksAreFruitOfFaith =>
    .holds <| .both (rl .fruitOf (cn .worksOfFaith) (cn .faith))
      (rl .precedes (cn .faith) (cn .worksOfFaith))
  | .faithAloneNeverAlone =>
    .also byFaithAlone (.holds (rl .inseparableFrom (cn .faith) (cn .worksOfFaith)))
  | .james2TargetsDeadFaith =>
    .also (.means .pistis (.passage james2_14_26) .mereAssent)
      (.denied (.sameSense .pistis (.passage james2_14_26) (.usage .paul)))
  | .jamesJustifiesDemonstratively =>
    .means .dikaioo (.passage (rg .james 2 21 2 24)) .showRighteous
  | .justificationDistinctFromSanctification =>
    .holds <| .both (rl .isA (cn .justification) (cn .verdict)) <|
      .both (rl .distinctFrom (cn .justification) (cn .sanctification))
        (rl .precedes (cn .justification) (cn .sanctification))

/-- What each atom of the argument says. -/
instance meanings : HasMeanings Claim :=
  { argument := "The canonical witness", all, complete := all_complete, means }

/-- **Twenty-seven of the 29 atoms are analysed.** The two left are James 2:19, the
demons who believe and shudder, and Jude 20–21, a command; the module docstring says why. -/
theorem coverage_now : HasMeanings.coverage (α := Claim) = (27, 29) := by decide

/-- **The canonical witness joins**: no exclusions, and seven entailments —
*faith alone* asserts each of its three parts, and "by faith alone, by a faith
that is never alone" asserts *faith alone* and each part. Listed, and proved to
be exactly what the meanings contain. -/
instance joins : HasJoins Claim where
  exclusions := []
  exclusions_pinned := by decide +kernel
  entailments :=
    [ (.justificationByFaithAlone, .faithIsNecessary)
    , (.justificationByFaithAlone, .faithIsSufficient)
    , (.justificationByFaithAlone, .worksAreNotTheGround)
    , (.faithAloneNeverAlone, .faithIsNecessary)
    , (.faithAloneNeverAlone, .faithIsSufficient)
    , (.faithAloneNeverAlone, .worksAreNotTheGround)
    , (.faithAloneNeverAlone, .justificationByFaithAlone) ]
  entailments_pinned := by decide +kernel

open Testimony.Logic in
/-- **The postulates, written out**: `a → b` for each entailment. Proofs over the
argument's packages unfold to this list, so a named reading must satisfy it. -/
@[canonicalWitnessDefs] theorem postulates_eq :
    (HasPostulates.postulates : List (Formula Claim)) =
      [ p .justificationByFaithAlone ➝ p .faithIsNecessary
      , p .justificationByFaithAlone ➝ p .faithIsSufficient
      , p .justificationByFaithAlone ➝ p .worksAreNotTheGround
      , p .faithAloneNeverAlone ➝ p .faithIsNecessary
      , p .faithAloneNeverAlone ➝ p .faithIsSufficient
      , p .faithAloneNeverAlone ➝ p .worksAreNotTheGround
      , p .faithAloneNeverAlone ➝ p .justificationByFaithAlone ] :=
  rfl

attribute [canonicalWitnessDefs] Testimony.Logic.ArgumentPackage.held

end TestimonyArguments.Meanings.CanonicalWitness
