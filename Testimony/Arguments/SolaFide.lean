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

**The Pauline strand** turns on `worksOfLawMeansWorksGenerally`: whether Paul's
ἔργα νόμου denotes human works in general, or specifically the covenant
boundary markers — circumcision, food laws, sabbath — that marked Jews off from
gentiles, as Dunn and Wright argue. This is the most contested step in the
traditional case.

**The dominical strand** rests on Jesus' own words rather than Paul's. ἡ πίστις
σου σέσωκέν σε — "your faith has saved you" — occurs four times in Luke (7:50,
8:48, 17:19, 18:42). It is not a free win: σῴζω means both *save* and *heal*,
and in 8:48, 17:19 and 18:42 the context is physical healing, which is why most
translations render "made you well" there. The argument therefore rests on
**Luke 7:50**, where the saying follows "your sins are forgiven" rather than a
healing, and carries `sozoIsSoteriological` as its own disputed premise. It is
a second bet, on a different word.

Encoding both strands yields a result the single-strand version could not:
neither lexical premise is load-bearing on its own, because either strand
carries the conclusion without the other. Only their *disjunction* is
load-bearing. A reader who wins the ἔργα νόμου argument outright does not
thereby defeat sola fide — and the New Perspective, which accepts justification
by faith while rejecting the traditional reading of Paul's phrase, turns out to
establish the conclusion too.

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
| `Sources.lean` | `baseCite`, and the two rival citations of the ἔργα νόμου premise |
| `Lines.lean` | the inference steps, the two strands, and what they share |
| `Packages.lean` | the three positions, and the variants the results refute |
| `Results.lean` | every `@[headline]` result, with its trust base |
-/
