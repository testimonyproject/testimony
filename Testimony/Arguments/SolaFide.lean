import Testimony.Arguments.SolaFide.Atoms
import Testimony.Arguments.SolaFide.Sources
import Testimony.Arguments.SolaFide.Lines
import Testimony.Arguments.SolaFide.Packages
import Testimony.Arguments.SolaFide.Results
import Testimony.Arguments.SolaFide.Dispute
import Testimony.Arguments.SolaFide.Johannine
import Testimony.Arguments.SolaFide.Gospel

/-!
# Arguments.SolaFide — justification by grace through faith, not works

The Reformation's material principle, encoded so that its premises are visible
and its disputed step is identified mechanically.

The argument runs on **three independent strands**, and that is the point.

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
healing, and carries `sozoIsSoteriological` as its own premise. It is a second
bet, on a different word — rated `wellSupported`, because no scholar found
argues the healing sense at 7:50. It also carries its answer to "she loved
much" (7:47): `luke7_47LoveIsEvidence`, that her love is the evidence of her
forgiveness and not its ground, as 7:47b and the parable of the two debtors
(7:41–43) read it. The reading of 7:47 is cited to Osvaldo Padilla's
narrative-critical study of the episode: her actions "stem from the fact that
she loves much because she has been forgiven much". Both premises are also
Melanchthon's, in the *Apology of the Augsburg Confession*, which answers "she
loved much" with Jesus' own words: "Christ interprets Himself when He adds: Thy
faith hath saved thee". Neither argues σῴζω against the healing sense word by
word; Marshall's commentary at 7:50 is named as the philological study to check.

**The apostolic strand** rests on Peter as Luke reports him. At the Jerusalem
council (Acts 15) the demand Galatians answers is made again — "unless you are
circumcised according to the custom of Moses, you cannot be saved" (15:1) — and
Peter answers that God cleansed the gentiles' hearts by faith, that Jew and
gentile alike are saved through grace, and that the law is "a yoke… that
neither our fathers nor we have been able to bear" (15:9–11). James concurs
(15:19). It carries `acts15YokeIsLawAsCondition` as its disputed premise: that
the yoke is the whole law as a condition of salvation, and not Israel's law
laid on gentiles as a mark of belonging, as Jervell reads Luke. The two
premises are about different texts, and logically independent; they are not
dialectically independent, since a reader who takes ἔργα νόμου as boundary
markers will read the yoke the same way.

**Each strand delivers only what its texts say.** Paul argues for *alone*: the
Galatians already believed, adding circumcision to their faith is what severs
them from Christ, and 2:16 names faith as the one means (ἐὰν μή, "except
through faith"). Luke 7:50 and Acts 15 say less: that her faith saved her, and
that the gentiles are saved without the yoke — that faith *suffices*
(`faithIsSufficient`), not that nothing else could be a condition. "Through
faith", the part of the conclusion the strands are needed for, needs only that.
The difference is not pedantry. A case is attacked on what it claims, and a
Luke credited with *alone* would be attacked by the apocalyptic reading on a
claim Luke never made.

**A Johannine strand** is encoded alongside, but not yet inside, the Reformed
case (`Johannine.lean`). Asked what they must do "to be doing the works of God",
the crowd is told: "This is the work of God, that you believe in him whom he has
sent" (John 6:28–29). Calvin reads that believing as trust, which "brings
nothing to God"; Aquinas as faith living through charity, the principle of good
works. John alone delivers sola fide on Calvin's reading
(`johannine_strand_establishes`) and not on Aquinas's
(`johannine_strand_rests_on_believing_as_trust`). Luther answers Aquinas from
Galatians 3:11–12: the law commands love, and the law is not of faith, so a faith
formed by charity would justify by the law (`luther_answers_aquinas_from_galatians`)
— an answer that rests on his step, which Aquinas denies
(`luther_answer_rests_on_his_step`). The strand is not yet one of the strands of
`reformed`, so what follows about three strands is still exact.

Encoding three strands yields a result no single strand could: no disputed
premise is load-bearing on its own, because any strand carries the conclusion
without the others. What is load-bearing is a disjunction — both Pauline
readings, *or* the dominical one, *or* the apostolic one. Defeating Paul's
reading and Luke's together, which defeated the two-strand version, no longer
does. A reader who wins the ἔργα νόμου
argument outright does not thereby defeat sola fide, and the New Perspective,
which accepts justification by faith while rejecting the traditional reading of
Paul's phrase, turns out to establish the conclusion too. Nor does winning the
genitive for Hays: that costs the Reformed case its Pauline route, and not its
conclusion.

**The conclusion has three parts** — salvation is *by grace*, *not by works*,
and *through faith* — and they are separate atoms, because the rivals divide
over different parts. The Tridentine position denies the second: works done in
grace merit an increase of justification. The apocalyptic reading of Martyn and
Campbell does not reach the third: taking the genitive as subjective and
δικαιοσύνη θεοῦ as God's act of deliverance, it denies that faith is the
condition of justification, and so has no ground for "through faith" of its own,
while establishing grace and "not by works" by its own route
(`apocalyptic_establishes_grace_not_works`). The split also shows which part
the strands are needed for. Grace and "not by works" follow from the texts that
say so in terms, given an answer to James, with every lexical premise removed
(`grace_and_works_rest_on_no_lexical_premise`). The lexical disputes decide
*through faith*. And each part has its own closing step, which shows what
the answer to James is for: grace follows without it
(`grace_needs_no_answer_to_james`), "not by works" does not
(`james_harmonisation_is_load_bearing`).

**The New Perspective's reading of ἔργα νόμου has a reason, and its critics
answer the reason.** Sanders' covenantal nomism — in by grace, staying in by
works — is the ground, and Dunn's inference from it to the boundary-marker
reading is the step, cited as his (`sandersLine`). Gathercole and the
*Variegated Nomism* volume deny the ground: Second Temple Judaism also held
final vindication according to works, so the demand Galatians refuses is a
demand for obedience, and the Reformed reading follows (`criticsLine`). On the
critics' history Paul alone carries sola fide
(`critics_carry_the_pauline_strand`); on Sanders' he does not
(`sanders_costs_the_pauline_strand`). The ἔργα νόμου dispute is a dispute
about Second Temple Judaism before it is one about Paul's Greek.

**What justification is** is a separate question, and the encoding keeps it
separate. The Reformed account is forensic: pardon and imputation, not infusion
(Westminster XI.1). Trent denies it — justification is "not remission of sins
merely, but also the sanctification and renewal of the inward man" — and so
does Mannermaa's Finnish reading of Luther, for which Christ himself is present
in faith. The Finnish package denies the forensic account and establishes sola
fide (`forensic_justification_not_load_bearing`); Trent denies it and does not.
So denying the forensic account is not enough to deny sola fide. What Trent's
objection needs is its fuller definition: justification includes the renewal of
the inward man, and that renewal grows through good works, so works increase
justification. Both sides grant the growth; the Reformed call it sanctification,
distinct from justification and following it (Westminster XIII.1; Calvin,
*Institutes* III.xi.6). Put the distinction in place of Trent's definition and
Trent's case no longer denies "not by works"
(`trent_objection_rests_on_its_definition`). The dispute over merit is a
dispute over what justification is — but over sanctification, not over
infusion as such.

**Authorship.** Ephesians, Titus and 1 and 2 Peter are each disputed, and each
dispute is catalogued from both sides — Hoehner and Lincoln on Ephesians,
Mounce, Dibelius–Conzelmann and Marshall on the Pastorals, Jobes and Achtemeier
on 1 Peter, Schreiner and Bauckham on 2 Peter, and Ehrman across all four.
Granting every critical conclusion costs the argument nothing, because it
reads these letters as canonical scripture rather than as an apostle's
testimony. It does cost them their use as evidence of what *Paul* meant by
"works", which is why that premise is argued from Romans 4, 9 and 11, where the
law is not in view and the authorship is not in doubt.

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

**Weighed as a dispute**, with each strand, Trent, the apocalyptic reading,
Sanders, the critics and Jervell as parties, nothing prevails outright, and
nothing is forced. Every party's weakest link is `disputed`, so no rating
breaks a tie, and every attack between Trent and a Reformed strand runs both
ways: Luke's case and Trent are each defensible, and neither is accepted on
every resolution. Luke's case, holding only Luke's words, meets Trent over
faith's sufficiency, and the apocalyptic reading not at all — Luke says faith
saved her, not that faith alone does — so the dispute between Campbell and the
Reformed reading is between Campbell and Paul, over the genitive. What would
decide between Trent and the Reformed readings is what justification *is*, and
that the library argues rather than weighs: two checked explanations locate
it, one for Luke's case and one for Paul's gospel (`Gospel.lean`).

**Where Trent parts from Paul** (`Gospel.lean`). Paul's answer to anything added
to the gospel is Galatians — another gospel, accursed (1:6–9); if righteousness
came by the law, Christ died for nothing (2:21) — and the gospel is that Christ
died for our sins (1 Corinthians 15:3). Read with the forensic sense of δικαιόω,
it denies Trent's definition of justification as renewal. Trent grants every
text, and — with the *Joint Declaration* (§22) and New Testament scholarship
across traditions — the forensic sense of the verb. A checked `Because` finds
where they part: one step, that a verdict on a finished work excludes the
renewal wrought in us.

## Where things are

| File | Contents |
|---|---|
| `Atoms.lean` | the `Claim` atoms |
| `Sources.lean` | `baseCite`, and each position's citation of the premise it disputes |
| `Lines.lean` | the inference steps, the three strands, the apocalyptic rival, what they share |
| `Packages.lean` | the positions, and the variants that remove a named premise |
| `Results.lean` | every `@[headline]` result, with its trust base |
| `Dispute.lean` | the positions as parties to one dispute, who defeats whom, and what prevails |
| `Johannine.lean` | the Johannine strand and Aquinas's rival reading, encoded alone |
| `Gospel.lean` | Paul's gospel in Galatians against Trent's definition, and where they part |
-/
