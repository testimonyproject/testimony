import Testimony.Arguments.SolaFide.Atoms
import Testimony.Arguments.SolaFide.Sources
import Testimony.Arguments.SolaFide.Lines
import Testimony.Arguments.SolaFide.Packages
import Testimony.Arguments.SolaFide.Results

/-!
# Arguments.SolaFide — justification by grace through faith, not works

The Reformation's material principle, encoded so that its premises are visible
and its disputed step is identified mechanically.

The argument runs on **two independent strands**, and that is the point.

**The Pauline strand** reads Galatians 2:16 as the centre of a polemic. The
Teachers in Galatia required believers to be circumcised as well as to believe,
and Paul answers that a person is justified "not by works of the law but through
faith in Jesus Christ". It rests on two disputed readings of that verse.

The first is `worksOfLawMeansWorksGenerally`: whether ἔργα νόμου denotes human
works in general, or specifically the covenant boundary markers — circumcision,
food laws, sabbath — that marked Jews off from gentiles, as Dunn and Wright
argue, building on Sanders' account of Second Temple Judaism. Only on the first
reading does refusing circumcision mean refusing every work as a requirement.

The second is `pistisChristouObjective`: whether πίστις Χριστοῦ is faith *in*
Christ, as Dunn holds, or Christ's own faithfulness, as Hays holds. Only on the
first does the verse name the believer's faith as the means of justification.
Excluding works is not yet *faith alone*.

The genitive dispute is a premise inside the Pauline strand, not a third
strand. Every πίστις Χριστοῦ text sets it against νόμος, so no route through the
genitive avoids the question of what ἔργα νόμου denotes. Nor does it follow the
Old/New Perspective line: the New Perspective package keeps the objective
genitive, because Dunn does.

**The dominical strand** rests on Jesus' own words rather than Paul's. ἡ πίστις
σου σέσωκέν σε — "your faith has saved you" — occurs four times in Luke (7:50,
8:48, 17:19, 18:42). It is not a free win: σῴζω means both *save* and *heal*,
and in 8:48, 17:19 and 18:42 the context is physical healing, which is why most
translations render "made you well" there. The argument therefore rests on
**Luke 7:50**, where the saying follows "your sins are forgiven" rather than a
healing, and carries `sozoIsSoteriological` as its own disputed premise. It is
a second bet, on a different word.

Encoding both strands yields a result the single-strand version could not: no
lexical premise is load-bearing on its own, because either strand carries the
conclusion without the other. What is load-bearing is a disjunction — both
Pauline readings, *or* the dominical one. A reader who wins the ἔργα νόμου
argument outright does not thereby defeat sola fide, and the New Perspective,
which accepts justification by faith while rejecting the traditional reading of
Paul's phrase, turns out to establish the conclusion too. Nor does winning the
genitive for Hays: that costs the Reformed case its Pauline route, and not its
conclusion.

**The apocalyptic reading** of Martyn and Campbell is a rival to both
perspectives. It takes the genitive as subjective and δικαιοσύνη θεοῦ as God's
act of deliverance, and denies that faith is the condition of justification. It
does not establish the conclusion. It does keep part of it — grace, and "not by
works" — and the encoding cannot say so, because the conclusion is one atom.
Splitting it would let a package establish half of it, and would restate every
result here; the conclusion stays whole, and this paragraph records the cost.

Two positions are cited rather than encoded. The Reformed critics of the New
Perspective — Gathercole, the *Variegated Nomism* volume, Piper — defend the
ἔργα νόμου premise; they add no route, so they appear in its citation, not as
a package of their own. Mannermaa's Finnish reading of Luther affirms every
atom here and differs over what justification *is*, union with Christ rather
than a forensic verdict, which a propositional atom cannot hold.

**James 2:24** — "a person is justified by works and not by faith alone", the
only occurrence of *faith alone* in the New Testament — is no longer assumed
away. Its compatibility with Paul is now *derived* from two cited premises:
that James's target is a barren faith, mere assent ("even the demons believe",
Jas 2:19), and that works are the fruit and evidence of saving faith rather
than a ground of justification. Moo and Johnson for the exegesis; Westminster
XI.2 for the confessional form — faith "is not alone in the person justified,
but is ever accompanied with all other saving graces, and is no dead faith, but
worketh by love". `james_harmonisation_is_load_bearing` shows the argument
genuinely depends on this: drop it and sola fide does not follow.

## Where things are

| File | Contents |
|---|---|
| `Atoms.lean` | the `Claim` atoms |
| `Sources.lean` | `baseCite`, and each position's citation of the premise it disputes |
| `Lines.lean` | the inference steps, the two strands, the apocalyptic rival, and what they share |
| `Packages.lean` | the five positions, and the variants that remove a named premise |
| `Results.lean` | every `@[headline]` result, with its trust base |
-/
