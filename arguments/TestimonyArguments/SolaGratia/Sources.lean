import TestimonyArguments.SolaGratia.Atoms
import TestimonyArguments.Works

/-!
# TestimonyArguments.SolaGratia.Sources — citation and classification for every atom

Every claim has a source, and the build fails if one does not. The three
positions agree about the texts and disagree about what they mean, so each
position's list of sources is a common list with the entries it cites
differently replaced. The Reformed position cites its own account of Acts 7:51,
and the Remonstrant position cites Arminius for faith as God's gift.

Dort and the Remonstrance are cited from Schaff's *Creeds of Christendom*, which
prints both. Trent is cited by session and canon from Tanner's *Decrees*, the
critical edition, and quoted in Waterworth's translation of 1848, at its page.
Arminius is cited from Nichols's translation of his works, and Aquinas from the
English Dominicans' translation of the *Summa*.

Every claim and every step carries one of four ratings: *consensus*, accepted
across traditions; *well supported*, though not universally held; *plausible*;
and *disputed*, actively contested. A step is rated *disputed* when a reader the
library cites grants its grounds and denies its conclusion.
-/

namespace TestimonyArguments.SolaGratia

open Testimony Testimony.Bib Testimony.Logic Testimony.Scripture

/-- Trent's sixth session at a chapter or canon, in Tanner's edition. -/
private def trent (loc : String) : Reference :=
  .work tannerDecrees (.sectionRef ("Trent, Session VI (1547), " ++ loc))

/-- The page of Waterworth's translation where the words quoted are found. -/
private def waterworth (page : Nat) : Reference :=
  .work waterworthTrent (.page page)

/-- The Formula of Concord or the Augsburg Confession, by article and paragraph,
in the Triglot's English. -/
private def concord (loc : String) : Reference :=
  .work concordiaTriglotta (.sectionRef loc)

/-- Dort, from Schaff's volume, at the page of its English. -/
private def dort (page : Nat) : Reference :=
  .work schaffCreeds3 (.page page)

/-- A text, as Scripture states it: no party disputes what it says. -/
private def text (refs : List ScriptureCitation) : Source :=
  { primary := .scripture refs
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-! ### Ratings for inference steps

A step's rating is its own, cited to whoever grants its grounds and denies its
conclusion, or, where no one was found who does, to whoever grants both. -/

/-- The rating of the step from Romans 11:6 to "salvation is by grace":
`consensus`. Trent quotes the verse to that effect, "if it be a grace, it is not
now by works" (Session VI, chapter 8); the Remonstrants' fourth article calls
grace "the beginning, continuance, and accomplishment of all good"; Dort says
that conversion "must be wholly ascribed to God" (III/IV, article 10). -/
def graceInference : Source :=
  { primary := trent "ch. 8"
  , supporting :=
      [ waterworth 36
      , .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4")
      , .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 10") ]
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-- **The rating of the step from "this" pointing to the whole, to "faith is
God's gift": `disputed`.** Robertson grants the ground and, in the same note,
denies the conclusion. "This" refers "not to [pistis] (feminine) or to [charis]
(feminine also), but to the act of being saved by grace conditioned on faith on
our part", and of the two words he says that grace is "God's part, 'faith'
ours".

Calvin is cited for less. He is Reformed, and holds elsewhere that faith is God's
gift, so he does not deny the conclusion. But he denies that this verse teaches
it: Paul's "meaning is, not that faith is the gift of God, but that salvation is
given to us by God". So a reader may grant the reading of "this" and still deny
that the verse delivers faith as a gift. -/
def ephesiansInference : Source :=
  { primary := .work robertsonWordPictures4 (.adLoc ⟨.ephesians, 2, 8⟩)
  , supporting := [.work calvinGalatiansEphesians (.pages 228 229)]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- **The rating of the step from the gift to God's work alone: `disputed`.**
Arminius grants both grounds. Faith is God's gift: he speaks of God, "whose
benefit and gift I acknowledge faith to be" (*Apology*, article 4). And a man
cannot turn to God by himself: he ascribes to grace "the commencement, the
continuance and the consummation of all good". He denies the conclusion: "many
persons resist the Holy Spirit and reject the grace that is offered"
(*Declaration of Sentiments*). -/
def giftInference : Source :=
  { primary := .work arminiusWorks1 (.page 600)
  , supporting :=
      [ .work arminiusWorks1 (.page 681)
      , .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4") ]
  , tradition := .arminian
  , confidence := .disputed }

/-- **The rating of the step from Romans 9:16, read as being about salvation, to
God's work alone: `disputed`.** Arminius grants the ground: the chapter's theme
is "That the Gospel, not the law, is the power of God unto salvation, not to him
that worketh, but to him that believeth", and the willing and running of 9:16 is
the effort by which a man "hopes that he will obtain justification and salvation
apart from the mercy of God". He denies the conclusion: the mercy goes to those
"who seek righteousness and salvation by faith in Christ", and grace can be
refused. -/
def romansInference : Source :=
  { primary := .work arminiusWorks3 (.pages 527 565)
  , tradition := .arminian
  , confidence := .disputed }

/-- **The rating of Trent's step from cooperation to "the will is not passive":
`disputed`, and the dissent rests on a distinction.** Canon 4 speaks of the will
"disposing and preparing itself" for justification. Aquinas grants that grace
works with a will that moves, which he calls cooperating grace, and still holds
that in grace's first effect "our mind is moved and does not move, but … God is
the sole mover" (I-II q.111 a.2). Dort likewise grants that the renewed will
"becomes itself active" (III/IV, article 12). Both place the will's activity
after a first moment in which it is only moved; the canon does not say which
moment it means. -/
def cooperationInference : Source :=
  { primary := .work aquinasSumma (.sectionRef "I-II q.111 a.2")
  , supporting :=
      [ .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 12")
      , trent "canon 4", waterworth 45 ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- **The rating of Trent's step from "the will can refuse" to "grace is not
effectual of itself": `disputed`.** Aquinas grants the ground and denies the
conclusion. "If God moves the will to anything, it is incompatible with this
supposition, that the will be not moved thereto. But it is not impossible
simply" (I-II q.10 a.4 ad 3). And "if God intends, while moving, that the one
whose heart He moves should attain to grace, he will infallibly attain to it"
(I-II q.112 a.3). On that reading the will can refuse, taken simply, and grace
is effectual all the same. -/
def dissentInference : Source :=
  { primary := .work aquinasSumma (.sectionRef "I-II q.10 a.4 ad 3")
  , supporting :=
      [ .work aquinasSumma (.sectionRef "I-II q.112 a.3")
      , trent "canon 4", waterworth 45 ]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of the step from the texts of resistance to "the Spirit's work is
resisted": `consensus`. Every party grants it. Dort says that believers "grieve
the Holy Spirit" (V, article 5); Calvin, on Ephesians 4:30, that "we grieve him
when we do not follow his guidance"; the Formula of Concord, citing Acts 7:51,
that "those who always resist the Holy Ghost … are not converted" (Solid
Declaration II.60). -/
def textsOfResistanceInference : Source :=
  { primary := dort 593
  , supporting :=
      [.work calvinGalatiansEphesians (.page 301), concord "Solid Declaration II.60"]
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-- The rating of the Remonstrants' step from resistance, read as resistance to
the grace that saves, to "that grace can be finally refused": `wellSupported`.
Grant that what Stephen's hearers resisted was the grace that saves, and no
reader was found who denies that it can be finally refused. The Reformed deny
the ground instead, reading the resistance as made to the preached word and not
to the inward work of grace. The word "resist" carries two senses here,
resisting for a time and refusing to the end, and the step needs the second. -/
def resistanceInference : Source :=
  { primary := .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4")
  , supporting := [.work arminiusWorks1 (.page 600)]
  , tradition := .arminian
  , confidence := .wellSupported }

/-- The rating of the step from grieving the Spirit, read as able to end in
losing him, to "the grace that saves can be finally refused": `wellSupported`.
The Formula of Concord holds both: the obstinate "do not receive, but grieve and
lose, the Holy Ghost" (Solid Declaration II.83). Dort denies the ground instead:
God "does not wholly withdraw the Holy Spirit from his own people" (V, article
6). -/
def griefInference : Source :=
  { primary := concord "Solid Declaration II.83"
  , supporting := [concord "Solid Declaration XI.42", dort 593]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **The rating of the step from the unforgivable sin to final refusal:
`disputed`.** Augustine grants both grounds. The sin that is never forgiven is
impenitence: "This impenitence then is 'the blasphemy of the Spirit, which shall
not be forgiven'" (Sermon 71, §20). And he denies the conclusion: God is the one
"whom no man's will resists when He wills to give salvation" (*On Rebuke and
Grace*, ch. 43). The grace refused to the end is, for him, not the grace that
saves. -/
def blasphemyInference : Source :=
  { primary := .work npnfAugustineSermons (.page 325)
  , supporting := [.work npnfAugustineAntiPelagian (.sectionRef "On Rebuke and Grace, ch. 43")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-- The rating of the step from God's work alone to the will's passivity:
`wellSupported`. The Lutherans, who part from Dort at the next step, grant this
one: man "does nothing whatever towards it, but only suffers what God works in
him" (Formula of Concord, Solid Declaration II.89). No reader was found who
grants that God alone regenerates and denies that the will is passive in it.
Aquinas holds that in the justification of one who has the use of reason, God's
motion "does not take place without a movement of the free-will" (I-II q.113
a.3); that is passivity in another sense, the will moved and so moving, which
is not what this step denies. -/
def passiveInference : Source :=
  { primary := concord "Solid Declaration II.89"
  , supporting := [.work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 12")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- **The rating of the step from God's work alone to "grace cannot be finally
refused": `disputed`.** The Formula of Concord grants the ground: conversion "is
not only in part, but altogether an operation, gift, and present, and work of
the Holy Ghost alone" (Solid Declaration II.89). And it denies the conclusion:
"God does not force man to become godly (for those who always resist the Holy
Ghost … as Stephen says of the hardened Jews, Acts 7:51, are not converted)"
(II.60); the perverse will "resists the Holy Ghost, who wishes to be
efficacious" (XI.41). -/
def effectualInference : Source :=
  { primary := concord "Solid Declaration II.89"
  , supporting := [concord "Solid Declaration II.60", concord "Solid Declaration XI.41"]
  , tradition := .christianHistoricalGrammatical
  , confidence := .disputed }

/-! ### Two readings of the ability God gives

Augustine distinguishes two kinds of help. "The aid without which a thing does
not come to pass is one thing, and the aid by which a thing comes to pass is
another." Adam was given the first, "not that by which it should be brought
about that he should persevere, but that without which he could not of free will
persevere"; the saints are given the second, "so that by means of this gift they
cannot help persevering" (*On Rebuke and Grace*, ch. 34). The third way's claim,
that God gives the ability to believe as Adam was made able, can be read as
either. -/

/-- Who reads the ability as Adam's kind of help, one that makes believing
possible and can be refused: Wesley, for whom "a measure of free-will" is
"supernaturally restored to every man", with "power either to resist or yield to
the grace of God" (*Predestination Calmly Considered*, §§XLVI–XLVII). -/
def asAidWithoutWhichSource : Source :=
  { primary := .work wesleyWorks9 (.page 397)
  , supporting := [.work npnfAugustineAntiPelagian (.page 485)]
  , tradition := .arminian
  , confidence := .disputed }

/-- Who reads the ability as the saints' kind of help, one that brings believing
about: Augustine, of the grace given to the saints (*On Rebuke and Grace*,
ch. 34), and Dort, for which faith is God's gift "not on account of its being
offered by God to man, to be accepted or rejected at his pleasure, but because it
is in reality conferred" (III/IV, article 14). -/
def asAidByWhichSource : Source :=
  { primary := .work npnfAugustineAntiPelagian (.page 485)
  , supporting := [dort 591]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-! ### Aquinas and the Thomists -/

/-- Garrigou-Lagrange's *Grace*, at a chapter and section of the EWTN text. -/
private def garrigou (loc : String) : Reference :=
  .work garrigouLagrangeGrace (.sectionRef loc)

/-- The rating of the step from operating grace to God's work alone:
`wellSupported`. Grant that in converting grace God is the sole mover of the
will, and no reader was found who denies that God alone is the one who
regenerates. The Molinists deny the ground instead, placing God as sole mover
only in the will's first, indeliberate motions; for them the converting act is
"due to" the will's consent, "in no way" to "the Thomistic predetermination"
(Pohle, "Molinism"). -/
def operatingGraceInference : Source :=
  { primary := .work aquinasSumma (.sectionRef "I-II q.111 a.2")
  , supporting := [garrigou "ch. IV", .work pohleMolinism .whole]
  , tradition := .romanCatholic
  , confidence := .wellSupported }

/-- **The rating of the step from God's intention in moving to grace effectual of
itself: `disputed`.** The Molinists grant the ground and deny the conclusion.
They grant that "the decree of God to bestow an efficacious grace upon a man
involves with metaphysical certainty the free co-operation of the will", and
deny that the grace brings it about: "the infallible success of efficacious
grace is not to be ascribed to its own intrinsic nature, but to the Divine
scientia media", God's knowledge of what a person would freely do (Pohle,
"Molinism"). Garrigou-Lagrange holds the conclusion: "grace is intrinsically
efficacious" (*Grace*, ch. VII). -/
def efficacyInference : Source :=
  { primary := .work pohleMolinism .whole
  , supporting := [.work aquinasSumma (.sectionRef "I-II q.112 a.3"), garrigou "ch. VII"]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- Who holds of the will's part what this reading takes "not merely passive" to
mean: the Molinists, for whom "it is rather the will itself which by its
consent" renders grace efficacious (Pohle, "Molinism"). Rated `disputed`: no
Thomist reads his own claim so, and Garrigou-Lagrange says Molina "deviates from
the teaching of St. Thomas" here. -/
def asAgentOfNewLifeSource : Source :=
  { primary := .work pohleMolinism .whole
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- Who reads "not merely passive" as the will acting while God alone is the
agent of the new life: Garrigou-Lagrange, for whom the will's consent, "although
as a disposition it precedes it [grace] in the genus or order of material cause,
it nevertheless follows it in the genus or order of formal, efficient, and final
cause" (*Grace*, ch. X); and Aquinas, for whom the movement of the free will "is
not the cause of grace, but the effect" (I-II q.111 a.2 ad 2). Rated `disputed`:
Garrigou-Lagrange himself lists Calvin's "merely passive" among the errors
(ch. IV), and a Reformed reader may take that as a denial of the third part in
Dort's sense, not only in another. -/
def asDispositionSource : Source :=
  { primary := garrigou "ch. X"
  , supporting := [.work aquinasSumma (.sectionRef "I-II q.111 a.2 ad 2")]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-! ### Ratings for the steps on perseverance -/

/-- **The rating of the step from John 10:27–29 to "the elect persevere":
`disputed`.** Calvin reads it so: "the salvation of all the elect is not less
certain than the power of God is invincible" (*John*, vol. 1, p. 416), and the
Formula of Concord cites the verse for God's purpose, "from which no one can
pluck us" (Solid Declaration XI.45). Wesley grants the text and denies that it
promises anyone perseverance without condition: "In the preceding text, the
condition is only implied. In this it is plainly expressed. They are *my sheep*,
that *hear my voice*, that *follow me* in all holiness. And 'if ye do these
things, ye shall never fall'" (*Serious Thoughts upon the Perseverance of the
Saints*, §18), quoting 2 Peter 1:10. -/
def john10Inference : Source :=
  { primary := .work wesleyWorks9 (.pages 444 445)
  , supporting := [.work calvinJohn (.pages 415 416), concord "Solid Declaration XI.45"]
  , tradition := .arminian
  , confidence := .disputed }

/-- The rating of the step from 1 John 2:19, read of every apostate, to
"everyone truly justified is among the elect": `wellSupported`. Owen draws it:
"If all they who fall away totally … were never true believers … then those who
are true believers cannot fall away; but the first is true, therefore the
latter" (*Works*, vol. 11, p. 595). No reader was found who grants the reading
and denies the conclusion. The dissent is from the reading: Augustine holds that
those who left "were in goodness", "in the faith of children", and not elect
(*On Rebuke and Grace*, ch. 20); Trent condemns the conclusion outright,
anathema to anyone who says "that he that falls and sins was never truly
justified" (Session VI, canon 23). -/
def bridgeInference : Source :=
  { primary := .work owenPerseverance (.page 595)
  , supporting :=
      [ .work calvinCatholicEpistles (.pages 191 192), .work calvinHebrews (.pages 137 138)
      , trent "canon 23", waterworth 47 ]
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- The rating of the step from "the elect persevere" and "the truly justified
are elect" to "no one truly justified can finally fall away": `consensus`. It
follows from what the words mean, and no reader was found who grants both
grounds and denies the conclusion. The readers who deny the conclusion, Augustine
among them, deny the second ground. -/
def joinInference : Source :=
  { primary := .work westminsterConfession (.sectionRef "XVII.1")
  , supporting := [.work schaffCreeds3 (.page 636)]
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-- **The rating of the step from Philippians 1:6 to "no one truly justified can
finally fall away": `disputed`.** Trent quotes the verse and, in the same
sentence, denies that it settles the matter: "For God, unless men be themselves
wanting to His grace, as he has begun the good work, so will he perfect it"
(Session VI, ch. 13). The Formula of Concord cites it while explaining why some
fall away: it "is not as though God were unwilling to grant grace for
perseverance to those in whom He has begun the good work" (Solid Declaration
XI.42). -/
def philippiansInference : Source :=
  { primary := trent "ch. 13"
  , supporting := [waterworth 40, concord "Solid Declaration XI.42"]
  , tradition := .romanCatholic
  , confidence := .disputed }

/-- The rating of the step from a promise that holds "unless men be themselves
wanting to His grace" to "the justified can finally fall away": `wellSupported`.
Read as a condition that can fail, the step only says what the condition means,
and Trent draws it in canon 23. Read as a condition God himself keeps in those
he has begun to save, the ground is a different claim, and the step does not
apply to it; the dilemma over the promise sets the two readings out. -/
def conditionalInference : Source :=
  { primary := trent "canon 23"
  , supporting := [waterworth 47, .work wesleyWorks9 (.page 439)]
  , tradition := .romanCatholic
  , confidence := .wellSupported }

/-- The rating of the step from Hebrews 6:4–6, read as describing true believers
who fall away, to "the justified can finally fall away": `wellSupported`. Wesley
draws it: "those who are holy or righteous in the judgment of God himself … may
nevertheless so fall from God, as to perish everlastingly" (*Serious Thoughts*,
§30). No reader was found who grants the reading and denies the conclusion. The
dissent is from the reading: Calvin holds that those described had only "some
taste of his grace", a knowledge "which afterwards vanishes away". -/
def hebrewsInference : Source :=
  { primary := .work wesleyWorks9 (.page 449)
  , tradition := .arminian
  , confidence := .wellSupported }

/-- The rating of the step from "some regenerate are not given perseverance" to
"the justified can finally fall away": `wellSupported`. Augustine draws it, and
Aquinas: "anyone may lose his crown by mortal sin" (I q.23 a.6 ad 1). No reader
was found who grants the ground and denies the conclusion; Calvin denies the
ground. -/
def augustineInference : Source :=
  { primary := .work npnfAugustineAntiPelagian (.page 478)
  , supporting := [.work aquinasSumma (.sectionRef "I q.23 a.6 ad 1")]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- The rating of the step from John 10:28 to "no power from outside snatches
believers out of Christ's hand": `consensus`. The Remonstrants draw it (fifth
article), and every party here grants it. -/
def remonstranceInference : Source :=
  { primary := .work schaffCreeds3 (.pages 548 549)
  , supporting :=
      [ .work arminiusWorks1 (.page 603), concord "Solid Declaration XI.45"
      , .work wesleyWorks9 (.pages 444 445) ]
  , tradition := .christianHistoricalGrammatical
  , confidence := .consensus }

/-- The promise read as a condition God himself keeps: Dort's "God is faithful,
who having conferred grace, mercifully confirms and powerfully preserves them
therein, even to the end" (V, article 3). -/
def asConditionGodKeepsSource : Source :=
  { primary := dort 593
  , supporting := [.work calvinJohn (.pages 415 416)]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-- The promise read as a condition that can fail: Wesley's "a Saint may fall
away; … one who is holy or righteous in the judgment of God himself, may
nevertheless so fall from God, as to perish everlastingly" (*Serious Thoughts*,
§5). -/
def asConditionThatCanFailSource : Source :=
  { primary := .work wesleyWorks9 (.page 439)
  , supporting := [.work wesleyWorks9 (.pages 444 445)]
  , tradition := .arminian
  , confidence := .disputed }

/-! ### Ratings for the further texts on perseverance -/

/-- The rating of the step from Romans 8:29–30, read as a chain from which no
one drops, to "no one truly justified can finally fall away": `wellSupported`.
Dort draws it: God decreed to give the elect "true faith, justification, and
sanctification; and having powerfully preserved them … finally to glorify them"
(I, article 7), and its Rejection of Errors condemns those who teach election to
justifying faith without election to salvation, "dissolving this golden chain of
salvation" (I.2, in Latin). No reader was found who grants the reading and
denies the conclusion. The dissent is from the reading: Wesley answers that the
verse "proves no more than that all who are glorified, are pardoned and
sanctified first" (*Predestination Calmly Considered*, §76), and that Paul "does
not affirm … that precisely the same number of men are called, justified, and
glorified" (*Notes*, on Romans 8:30). Augustine reads the chain of those
"called according to His purpose", and holds that others truly justified fall
away (*On Rebuke and Grace*, chs. 14, 23). -/
def romans8Inference : Source :=
  { primary := .work schaffCreeds3 (.pages 582 583)
  , supporting :=
      [ .work schaffCreeds3 (.page 557), .work wesleyWorks9 (.page 413)
      , .work wesleyNotes (.page 384), .work npnfAugustineAntiPelagian (.pages 480 481)
      , .work calvinRomans (.pages 319 320) ]
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- The rating of the step from God's knowing all things as present to "the one
who perseveres could, considered in himself, have fallen away": `wellSupported`.
Boethius draws it: things foreseen, "viewed, however, in themselves, … desist not
from the absolute freedom naturally theirs" (*Consolation* V, prose 6, pp.
263–264); and Aquinas: "it is possible for one who is predestinated considered in
himself to die in mortal sin; yet it is not possible, supposed … that he is
predestinated" (I q.23 a.6, ad 2). No reader was found who grants the premise
and denies the conclusion. -/
def timelessInference : Source :=
  { primary := .work boethiusConsolation (.pages 263 264)
  , supporting :=
      [ .work aquinasSumma (.sectionRef "I q.23 a.6 ad 2")
      , .work aquinasSumma (.sectionRef "I q.14 a.13") ]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- The rating of the step from Hebrews 10:29, read as describing one truly
sanctified who falls away, to "the justified can finally fall away":
`wellSupported`. Wesley draws it: "It is undeniably plain, 1. That the person
mentioned here, was once sanctified by the blood of the covenant" (*Serious
Thoughts*, §27). No reader was found who grants the reading and denies the
conclusion; the dissent, Owen's, is from the reading. -/
def hebrews10Inference : Source :=
  { primary := .work wesleyWorks9 (.pages 448 449)
  , supporting := [.work wesleyWorks9 (.pages 414 415), .work wesleyNotes (.page 585)]
  , tradition := .arminian
  , confidence := .wellSupported }

/-- The rating of the step from 2 Peter 2:20–22, read as describing true
believers who fall back, to "the justified can finally fall away":
`wellSupported`. Wesley draws it: those who "so effectually know Christ, as by
that knowledge to have escaped the pollutions of the world, may yet fall back
into those pollutions, and perish everlastingly" (*Serious Thoughts*, §21). No
reader was found who grants the reading and denies the conclusion; the dissent,
Calvin's, is from the reading. -/
def secondPeterInference : Source :=
  { primary := .work wesleyWorks9 (.pages 445 446)
  , supporting := [.work wesleyNotes (.page 625)]
  , tradition := .arminian
  , confidence := .wellSupported }

/-- The rating of the step from David's losing the Spirit to "justifying grace
can be lost": `wellSupported`. The Smalcald Articles draw it, and Trent's
fifteenth chapter holds the conclusion: grace "is lost … by any other mortal sin
whatever". No reader was found who grants that David lost the Spirit and denies
that grace can be lost; Calvin denies the ground. -/
def davidInference : Source :=
  { primary := concord "Smalcald Articles III.iii.43"
  , supporting := [trent "ch. 15", waterworth 42]
  , tradition := .christianHistoricalGrammatical
  , confidence := .wellSupported }

/-- The rating of the step from Psalm 51:11, read as Calvin reads it, to
"justifying grace is never lost": `wellSupported`. Calvin draws it: "it is their
duty to hold fast the truth that grace is the incorruptible seed of God, which
never can perish in any heart where it has been deposited" (*Psalms*, vol. 2,
p. 300), and Dort says God does not suffer his own "to lose the grace of adoption
and forfeit the state of justification" (V, article 6). No reader was found who
grants that David kept the Spirit and denies the conclusion. -/
def psalmInference : Source :=
  { primary := .work calvinPsalms2 (.pages 299 300)
  , supporting := [dort 593]
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- The rating of the step from Romans 8:16 to "a believer can know, without a
special revelation, that he will persevere": `wellSupported`. Dort draws it: the
assurance "springs from faith in God's promises … from the testimony of the Holy
Spirit, witnessing with our spirit, that we are children and heirs of God" (V,
article 10), and Westminster cites the verse for assurance (XVIII.2). No reader
was found who grants the verse and denies the conclusion. Wesley grants the verse
to every believer and allows "the full assurance of hope", "Divine evidence
(wrought in the soul by the same immediate inspiration of the Holy Ghost) of
persevering grace, and of eternal glory", which "you cannot expect, if you abate
your diligence" (*Notes*, on Hebrews 6:11). He says the same of the assurance of
faith, so the "immediate inspiration" is the ordinary witness of the Spirit, and
that is not a denial. Trent denies the conclusion from another text, 1
Corinthians 10:12. -/
def assuranceInference : Source :=
  { primary := dort 594
  , supporting :=
      [ .work westminsterConfession (.sectionRef "XVIII.2")
      , .work wesleyNotes (.adLoc ⟨.hebrews, 6, 11⟩) ]
  , tradition := .reformedProtestant
  , confidence := .wellSupported }

/-- **The rating of the step from 1 Corinthians 10:12 to "no believer can know,
without a special revelation, that he will persevere": `disputed`.** Trent draws
it, quoting the verse in its chapter on perseverance: "let those who think
themselves to stand, take heed lest they fall" (Session VI, ch. 13). Calvin
grants the verse and denies the conclusion: "let us observe that there are two
kinds of assurance", and Paul "does not, however, exhort them to be always
anxiously in doubt as to the will of God, or to tremble from uncertainty as to
their salvation" (*1 Corinthians*, vol. 1, pp. 329–330). -/
def cautionInference : Source :=
  { primary := .work calvinFirstCorinthians (.pages 329 330)
  , supporting := [trent "ch. 13", .work waterworthTrent (.pages 40 41)]
  , tradition := .reformedProtestant
  , confidence := .disputed }

/-! ### The citations -/

/-- The common list of sources: the texts, the readings, the claims of each
position, and the parts of the conclusion. Each position replaces only the
entries it cites differently. -/
def baseCite : Claim → AtomMeta
  | .ephesians2_1to5 =>
    { label := "Ephesians 2:1–5 — dead in trespasses, God made us alive together with Christ"
    , kind := .textual
    , source := text [{ ref := .range ⟨.ephesians, 2, 1, 2, 5⟩ }] }
  | .ephesians2_8to9 =>
    { label :=
        "Ephesians 2:8–9 — by grace you have been saved through faith, and this is not " ++
        "your own doing; it is the gift of God"
    , kind := .textual
    , source := text [{ ref := .range ⟨.ephesians, 2, 8, 2, 9⟩ }] }
  | .romans9_16 =>
    { label := "Romans 9:16 — it depends not on human will or exertion, but on God, who has mercy"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.romans, 9, 16⟩ }] }
  | .romans11_6 =>
    { label := "Romans 11:6 — if it is by grace, it is no longer on the basis of works"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.romans, 11, 6⟩ }] }
  | .acts7_51 =>
    { label := "Acts 7:51 — you always resist the Holy Spirit"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.acts, 7, 51⟩ }] }
  | .ephesians4_30 =>
    { label := "Ephesians 4:30 — do not grieve the Holy Spirit of God, by whom you were sealed"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.ephesians, 4, 30⟩ }] }
  | .thessalonians5_19 =>
    { label := "1 Thessalonians 5:19 — do not quench the Spirit"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.firstThessalonians, 5, 19⟩ }] }
  | .matthew12_31to32 =>
    { label := "Matthew 12:31–32 — the blasphemy against the Spirit will not be forgiven"
    , kind := .textual
    , source := text [{ ref := .range ⟨.matthew, 12, 31, 12, 32⟩ }] }
  | .genesis2_16to17 =>
    { label :=
        "Genesis 2:16–17 — of the tree of the knowledge of good and evil you shall not eat"
    , kind := .textual
    , source := text [{ ref := .range ⟨.genesis, 2, 16, 2, 17⟩ }] }
  | .theSpiritIsResisted =>
    { label := "The Holy Spirit's work is resisted, by unbelievers and by believers"
    , kind := .theological
    , source :=
        { primary := dort 593
        , supporting := [concord "Solid Declaration II.60"]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .grievingCanLoseTheSpirit =>
    { label := "Those who obstinately resist the Spirit can grieve and lose him"
    , kind := .interpretive
      -- `disputed`: Dort denies that God wholly withdraws the Spirit from his
      -- own (V, article 6).
    , source :=
        { primary := concord "Solid Declaration II.83"
        , supporting := [concord "Solid Declaration XI.42"]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .blasphemyIsFinalRefusalOfGrace =>
    { label :=
        "The blasphemy against the Spirit is impenitence to the end: grace refused till death"
    , kind := .interpretive
      -- `disputed`: Calvin rejects it outright, "Those who define it to be
      -- impenitence may be refuted without any difficulty", and takes the sin
      -- to be knowing contempt of the Spirit (Harmony, vol. 2, p. 74).
    , source :=
        { primary := .work npnfAugustineSermons (.page 325)
        , supporting :=
            [ .work aquinasSumma (.sectionRef "II-II q.14 a.1")
            , .work calvinHarmony2 (.page 74) ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .savingGraceCanBeFinallyRefused =>
    { label := "The grace that saves can be finally refused"
    , kind := .theological
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4")
        , supporting := [concord "Solid Declaration XI.41", .work wesleyWorks9 (.page 397)]
        , tradition := .arminian
        , confidence := .disputed } }
  | .abilityToBelieveIsGiven =>
    { label := "God gives the ability to believe, as Adam was made able to stand or fall"
    , kind := .theological
      -- `wellSupported`: Augustine grants that Adam had the help without which
      -- he could not persevere, and Wesley that preventing grace restores to
      -- every person a measure of free will; Dort grants that faith is God's
      -- gift and holds it to be more than an ability. What kind of help it is
      -- is the dilemma, not this rating.
    , source :=
        { primary := .work npnfAugustineAntiPelagian (.page 484)
        , supporting := [.work wesleySermons (.sectionRef "Sermon 85, III.4")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .faithAloneReceivesGrace =>
    { label := "Grace is received by faith alone"
    , kind := .theological
      -- `disputed`: Trent condemns it (Session VI, canon 9).
    , source :=
        { primary := concord "Augsburg Confession IV.1–3"
        , supporting := [.work wesleySermons (.sectionRef "Sermon 1, III.1"), trent "canon 9"]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .operatingGraceMovesTheWill =>
    { label := "In converting grace God is the sole mover: the mind is moved and does not move"
    , kind := .theological
      -- `disputed`: the Molinists place God as sole mover only in the will's
      -- indeliberate first motions (Pohle, "Molinism").
    , source :=
        { primary := .work aquinasSumma (.sectionRef "I-II q.111 a.2")
        , supporting := [garrigou "ch. IV"]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .godIntendsWhileMoving =>
    { label := "God moves the will intending that it attain grace"
    , kind := .theological
    , source :=
        { primary := .work aquinasSumma (.sectionRef "I-II q.112 a.3")
        , supporting := [.work pohleMolinism .whole]
        , tradition := .romanCatholic
        , confidence := .wellSupported } }
  | .willIsNotMerelyPassive =>
    { label := "Under operating grace the will is not merely passive: it freely consents"
    , kind := .theological
    , source :=
        { primary := garrigou "ch. IV"
        , supporting := [trent "canon 4", waterworth 45]
        , tradition := .romanCatholic
        , confidence := .wellSupported } }
  | .sufficientGraceIsResisted =>
    { label := "Grace truly sufficient, giving the power to do good, is resisted"
    , kind := .theological
    , source :=
        { primary := garrigou "ch. VI"
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .justifyingGraceCanBeLost =>
    { label := "Justifying grace, once given, can be lost"
    , kind := .theological
      -- `disputed`: Dort holds the perseverance of the saints (Fifth Head).
    , source :=
        { primary := .work aquinasSumma (.sectionRef "II-II q.24 a.11")
        , supporting := [trent "canon 23"]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .zechariah1_3WithLamentations5_21 =>
    { label :=
        "Zechariah 1:3 (\"return to me, and I will return to you\") with Lamentations 5:21 " ++
        "(\"restore us to yourself, O Lord\")"
    , kind := .textual
    , source :=
        { primary :=
            .scripture
              [{ ref := .verse ⟨.zechariah, 1, 3⟩ }, { ref := .verse ⟨.lamentations, 5, 21⟩ }]
        , supporting := [trent "ch. 5", waterworth 33]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .toutoRefersToTheWhole =>
    { label :=
        "In Ephesians 2:8, \"this\" (τοῦτο) points to the whole of being saved by grace " ++
        "through faith"
    , kind := .linguistic
      -- `wellSupported`: Hoehner and Robertson read it so, and Calvin refers the
      -- verse to salvation as a whole. The pronoun's grammar is not where the
      -- readers divide; the step from it to faith as a gift is
      -- (`ephesiansInference`).
    , source :=
        { primary := .work hoehnerEphesians (.page 343)
        , supporting := [.work robertsonWordPictures4 (.adLoc ⟨.ephesians, 2, 8⟩)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .romans9_16ConcernsSalvation =>
    { label :=
        "Romans 9:16 is about God's mercy in saving, not only in choosing a people for history"
    , kind := .interpretive
      -- `wellSupported`: Arminius and Abasciano, who deny the Reformed
      -- conclusion, grant this reading. No reader holding that Romans 9 is
      -- about peoples' place in history alone is cited with a verified
      -- location.
    , source :=
        { primary := .work arminiusWorks3 (.pages 527 565)
        , supporting := [.work abascianoCorporateElection (.page 351)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .faithIsGodsGift =>
    { label := "Faith itself is God's gift"
    , kind := .theological
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 14")
        , supporting := [.work arminiusWorks1 (.page 681)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .acts7_51ResistsSavingGrace =>
    { label := "What Stephen's hearers resisted in Acts 7:51 was the grace that saves"
    , kind := .interpretive
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), art. 4")
        , tradition := .arminian
        , confidence := .disputed } }
  | .freeWillCooperatesByAssenting =>
    { label := "The free will, moved by God, cooperates by assenting to God's call"
    , kind := .theological
    , source :=
        { primary := trent "canon 4"
        , supporting := [waterworth 45]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .freeWillCanDissent =>
    { label := "The free will, moved by God, can refuse its assent if it wishes"
    , kind := .theological
    , source :=
        { primary := trent "canon 4"
        , supporting := [waterworth 45]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .conversionIsGodsWorkAlone =>
    { label := "Conversion is God's work alone: God regenerates, and the will does nothing to it"
    , kind := .theological
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, arts. 10–12")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .salvationIsByGrace =>
    { label := "Salvation is by grace and not earned: grace goes before every saving act"
    , kind := .theological
    , source :=
        { primary := trent "chs. 5, 8"
        , supporting :=
            [ waterworth 32, waterworth 36
            , .work schaffCreeds3 (.sectionRef "Five Arminian Articles (1610), arts. 3–4")
            , .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 10") ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .graceIsEffectualOfItself =>
    { label := "The grace that saves brings about the consent it seeks"
    , kind := .theological
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 12")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .willIsPassiveInRegeneration =>
    { label := "In being made alive the will is passive, and contributes nothing to it"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "X.2")
        , supporting := [.work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 12")]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .john10_27to29 =>
    { label := "John 10:27–29 — they will never perish, and no one will snatch them out of my hand"
    , kind := .textual
    , source := text [{ ref := .range ⟨.john, 10, 27, 10, 29⟩ }] }
  | .philippians1_6 =>
    { label :=
        "Philippians 1:6 — he who began a good work in you will bring it to completion"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.philippians, 1, 6⟩ }] }
  | .hebrews6_4to6 =>
    { label :=
        "Hebrews 6:4–6 — it is impossible to restore again to repentance those once " ++
        "enlightened who have fallen away"
    , kind := .textual
    , source := text [{ ref := .range ⟨.hebrews, 6, 4, 6, 6⟩ }] }
  | .firstJohn2_19 =>
    { label := "1 John 2:19 — they went out from us, but they were not of us"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.firstJohn, 2, 19⟩ }] }
  | .noneSnatchedByForce =>
    { label := "No power from outside can snatch true believers out of Christ's hand"
    , kind := .theological
    , source :=
        { primary := .work schaffCreeds3 (.page 548)
        , supporting := [concord "Solid Declaration XI.45", .work wesleyWorks9 (.pages 444 445)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .someRegenerateNotGivenPerseverance =>
    { label :=
        "To some whom God has regenerated, and given faith, hope and love, he does not " ++
        "give perseverance"
    , kind := .theological
      -- `disputed`: Calvin holds that God "favours none but the elect alone with
      -- the Spirit of regeneration" (Hebrews, p. 138).
    , source :=
        { primary := .work npnfAugustineAntiPelagian (.page 478)
        , supporting :=
            [.work npnfAugustineAntiPelagian (.sectionRef "On Rebuke and Grace, ch. 18")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .promiseIsConditional =>
    { label :=
        "God's promise to keep those he has begun to save holds unless they fall away by " ++
        "their own fault"
    , kind := .theological
    , source :=
        { primary := trent "ch. 13"
        , supporting := [waterworth 40]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .godKeepsHisSheepInFaith =>
    { label := "Those who are Christ's sheep do hear and follow, because God keeps them in faith"
    , kind := .theological
    , source :=
        { primary := dort 593
        , supporting := [.work calvinJohn (.pages 415 416)]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .hebrews6DescribesBelieversWhoFall =>
    { label := "Hebrews 6:4–6 describes true believers who actually fall away"
    , kind := .interpretive
      -- `disputed`: Calvin reads those described as having had only "some taste"
      -- of grace (pp. 137–138).
    , source :=
        { primary := .work wesleyWorks9 (.page 449)
        , tradition := .arminian
        , confidence := .disputed } }
  | .electPersevere =>
    { label := "Those God has chosen to save cannot finally fall away from grace"
    , kind := .theological
      -- `wellSupported`: Augustine, Aquinas and the Formula of Concord say it of
      -- the elect too; Wesley reads every such promise as conditional.
    , source :=
        { primary := .work westminsterConfession (.sectionRef "XVII.1")
        , supporting := [.work schaffCreeds3 (.page 636), dort 593]
        , tradition := .reformedProtestant
        , confidence := .wellSupported } }
  | .justifiedAreElect =>
    { label := "Everyone who is truly justified is among the elect"
    , kind := .theological
    , source :=
        { primary := .work westminsterConfession (.sectionRef "X.4")
        , supporting := [.work calvinHebrews (.pages 137 138)]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .justifiedCanFinallyFallAway =>
    { label := "One who is truly justified can fall away from grace finally, and perish"
    , kind := .theological
    , source :=
        { primary := trent "canon 23"
        , supporting := [waterworth 47, .work wesleyWorks9 (.page 439)]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .romans8_29to30 =>
    { label := "Romans 8:29–30 — those whom he justified he also glorified"
    , kind := .textual
    , source := text [{ ref := .range ⟨.romans, 8, 29, 8, 30⟩ }] }
  | .hebrews10_26to29 =>
    { label :=
        "Hebrews 10:26–29 — the one who has profaned the blood of the covenant by which " ++
        "he was sanctified"
    , kind := .textual
    , source := text [{ ref := .range ⟨.hebrews, 10, 26, 10, 29⟩ }] }
  | .secondPeter2_20to22 =>
    { label :=
        "2 Peter 2:20–22 — having escaped the defilements of the world, they are again " ++
        "entangled in them"
    , kind := .textual
    , source := text [{ ref := .range ⟨.secondPeter, 2, 20, 2, 22⟩ }] }
  | .psalm51_11 =>
    { label := "Psalm 51:11 — take not your Holy Spirit from me"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.psalms, 51, 11⟩ }] }
  | .romans8_16 =>
    { label := "Romans 8:16 — the Spirit himself bears witness with our spirit"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.romans, 8, 16⟩ }] }
  | .firstCorinthians10_12 =>
    { label := "1 Corinthians 10:12 — let anyone who thinks that he stands take heed lest he fall"
    , kind := .textual
    , source := text [{ ref := .verse ⟨.firstCorinthians, 10, 12⟩ }] }
  | .hebrews10DescribesTheSanctifiedWhoFall =>
    { label := "Hebrews 10:29 describes one truly sanctified by Christ's blood who falls away"
    , kind := .interpretive
      -- `disputed`: Owen reads the sanctification as "a separation and dedication
      -- unto God", or as Christ's own (Works 23, p. 545).
    , source :=
        { primary := .work wesleyWorks9 (.pages 448 449)
        , supporting := [.work wesleyNotes (.page 585)]
        , tradition := .arminian
        , confidence := .disputed } }
  | .secondPeter2DescribesBelieversWhoFall =>
    { label := "2 Peter 2:20–22 describes true believers who fall back into the world"
    , kind := .interpretive
      -- `disputed`: Calvin holds that the faithful "do not fall away from the grace
      -- of God" (Catholic Epistles, p. 411).
    , source :=
        { primary := .work wesleyWorks9 (.pages 445 446)
        , supporting := [.work wesleyNotes (.page 625)]
        , tradition := .arminian
        , confidence := .disputed } }
  | .davidLostTheSpirit =>
    { label := "In his sin David lost the Holy Spirit and his faith"
    , kind := .interpretive
      -- `disputed`: Calvin reads Psalm 51:11 as implying "that the Spirit had not
      -- altogether been taken away from him" (Psalms 2, p. 299).
    , source :=
        { primary := concord "Smalcald Articles III.iii.43"
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .believersCanBeSureOfPersevering =>
    { label := "A believer can know, without a special revelation, that he will persevere"
    , kind := .theological
    , source :=
        { primary := dort 594
        , supporting := [.work westminsterConfession (.sectionRef "XVIII.3")]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .romans8ChainIsUnbroken =>
    { label := "Romans 8:29–30 is a chain from which no one drops: every one justified is glorified"
    , kind := .interpretive
      -- `disputed`: Wesley denies it (Notes, p. 384; Predestination Calmly
      -- Considered §76, p. 413), both cited among the supporting references;
      -- Augustine reads the chain of the elect alone.
    , source :=
        { primary := .work schaffCreeds3 (.pages 582 583)
        , supporting :=
            [ .work schaffCreeds3 (.page 557), .work wesleyNotes (.page 384)
            , .work wesleyWorks9 (.page 413) ]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .apostatesNeverHadTrueFaith =>
    { label := "1 John 2:19, read of every apostate: all who fall away were never true believers"
    , kind := .interpretive
      -- `disputed`: Augustine holds that those who left "were in goodness"
      -- (On Rebuke and Grace, ch. 20, cited among the supporting references).
    , source :=
        { primary := .work owenPerseverance (.pages 594 595)
        , supporting :=
            [ .work calvinCatholicEpistles (.pages 191 192)
            , .work npnfAugustineAntiPelagian (.pages 479 480) ]
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .canFallInThemselves =>
    { label :=
        "Considered in himself, apart from God's decree, the one who perseveres could " ++
        "have fallen"
    , kind := .theological
      -- `consensus`: Dort grants it (V.8), and Aquinas (I q.23 a.6 ad 2); no
      -- reader here denies it.
    , source :=
        { primary := dort 594
        , supporting :=
            [ .work aquinasSumma (.sectionRef "I q.23 a.6 ad 2")
            , .work boethiusConsolation (.pages 263 264) ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .consensus } }
  | .godKnowsAllAsPresent =>
    { label := "God knows all things as present to his eternity, which imposes no necessity on them"
    , kind := .theological
    , source :=
        { primary := .work boethiusConsolation (.pages 257 262)
        , supporting :=
            [ .work aquinasSumma (.sectionRef "I q.14 a.13")
            , .work wesleySermons (.sectionRef "Sermon 58, §5") ]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }

/-- The Reformed citations. Dort does not cite Acts 7:51. What it gives is an
account of those who refuse the call: "It is not the fault of the gospel, nor of
Christ offered therein, nor of God, who calls men by the gospel … that those who
are called by the ministry of the Word refuse to come and be converted. The
fault lies in themselves" (III/IV, article 9). Read with Acts 7:51, that is the
Reformed answer: what Stephen's hearers resisted was the outward call of the
preached word, not the grace that saves. -/
def reformedCite : Claim → AtomMeta
  | .acts7_51ResistsSavingGrace =>
    { label := "What Stephen's hearers resisted in Acts 7:51 was the grace that saves"
    , kind := .interpretive
    , source :=
        { primary := .work schaffCreeds3 (.sectionRef "Canons of Dort, III/IV, art. 9")
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .hebrews6DescribesBelieversWhoFall =>
    { label := "Hebrews 6:4–6 describes true believers who actually fall away"
    , kind := .interpretive
    , source :=
        { primary := .work calvinHebrews (.pages 137 138)
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .hebrews10DescribesTheSanctifiedWhoFall =>
    { label := "Hebrews 10:29 describes one truly sanctified by Christ's blood who falls away"
    , kind := .interpretive
    , source :=
        { primary := .work owenHebrews (.pages 545 546)
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .secondPeter2DescribesBelieversWhoFall =>
    { label := "2 Peter 2:20–22 describes true believers who fall back into the world"
    , kind := .interpretive
    , source :=
        { primary := .work calvinCatholicEpistles (.pages 410 412)
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | .davidLostTheSpirit =>
    { label := "In his sin David lost the Holy Spirit and his faith"
    , kind := .interpretive
    , source :=
        { primary := .work calvinPsalms2 (.pages 299 300)
        , tradition := .reformedProtestant
        , confidence := .disputed } }
  | a => baseCite a

/-- Trent's citations: the texts and canon 4, as `baseCite` has them; on
perseverance, its fifteenth chapter, that grace "is lost … by any other mortal sin
whatever", and its sixteenth canon, against certainty of persevering. -/
def tridentineCite : Claim → AtomMeta
  | .justifyingGraceCanBeLost =>
    { label := "Justifying grace, once given, can be lost"
    , kind := .theological
    , source :=
        { primary := trent "ch. 15"
        , supporting := [waterworth 42, trent "canon 23", waterworth 47]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | .believersCanBeSureOfPersevering =>
    { label := "A believer can know, without a special revelation, that he will persevere"
    , kind := .theological
    , source :=
        { primary := trent "canon 16"
        , supporting := [waterworth 46, trent "ch. 12", .work waterworthTrent (.pages 39 40)]
        , tradition := .romanCatholic
        , confidence := .disputed } }
  | a => baseCite a

/-- The Remonstrant citations. That faith is God's gift is cited to Arminius,
who affirms it on grounds of his own, and not to Dort, which affirms it in a
sense he rejects. -/
def remonstrantCite : Claim → AtomMeta
  | .faithIsGodsGift =>
    { label := "Faith itself is God's gift"
    , kind := .theological
    , source :=
        { primary := .work arminiusWorks1 (.page 681)
        , tradition := .arminian
        , confidence := .wellSupported } }
  | a => baseCite a

/-- The Lutheran citations: the Formula of Concord for what the Lutherans hold,
in its own words. -/
def lutheranCite : Claim → AtomMeta
  | .conversionIsGodsWorkAlone =>
    { label := "Conversion is God's work alone: God regenerates, and the will does nothing to it"
    , kind := .theological
    , source :=
        { primary := concord "Solid Declaration II.89"
        , supporting := [concord "Solid Declaration II.90"]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .savingGraceCanBeFinallyRefused =>
    { label := "The grace that saves can be finally refused"
    , kind := .theological
    , source :=
        { primary := concord "Solid Declaration XI.41"
        , supporting := [concord "Solid Declaration II.60", concord "Solid Declaration XI.78"]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .promiseIsConditional =>
    { label :=
        "God's promise to keep those he has begun to save holds unless they fall away by " ++
        "their own fault"
    , kind := .theological
    , source :=
        { primary := concord "Solid Declaration XI.42"
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .electPersevere =>
    { label := "Those God has chosen to save cannot finally fall away from grace"
    , kind := .theological
    , source :=
        { primary := concord "Solid Declaration XI.45"
        , supporting := [concord "Solid Declaration XI.90"]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | a => baseCite a

/-- The Wesleyan citations: Wesley for what Wesley holds. -/
def wesleyanCite : Claim → AtomMeta
  | .abilityToBelieveIsGiven =>
    { label := "God gives the ability to believe, as Adam was made able to stand or fall"
    , kind := .theological
    , source :=
        { primary := .work wesleySermons (.sectionRef "Sermon 85, III.4")
        , supporting := [.work wesleyWorks9 (.page 397)]
        , tradition := .arminian
        , confidence := .wellSupported } }
  | .savingGraceCanBeFinallyRefused =>
    { label := "The grace that saves can be finally refused"
    , kind := .theological
    , source :=
        { primary := .work wesleyWorks9 (.page 397)
        , tradition := .arminian
        , confidence := .disputed } }
  | .promiseIsConditional =>
    { label :=
        "God's promise to keep those he has begun to save holds unless they fall away by " ++
        "their own fault"
    , kind := .theological
    , source :=
        { primary := .work wesleyWorks9 (.pages 444 445)
        , tradition := .arminian
        , confidence := .disputed } }
  | .romans8ChainIsUnbroken =>
    { label := "Romans 8:29–30 is a chain from which no one drops: every one justified is glorified"
    , kind := .interpretive
    , source :=
        { primary := .work wesleyNotes (.page 384)
        , supporting := [.work wesleyWorks9 (.page 413)]
        , tradition := .arminian
        , confidence := .disputed } }
  | a => baseCite a

/-- The citations of Augustine and Aquinas: that the elect persevere, from
Augustine's "they who are not to persevere … are not elected" (*On Rebuke and
Grace*, ch. 16) and from Aquinas, for whom predestination "most certainly and
infallibly takes effect" (*Summa* I q.23 a.6). That the justified can fall
finally, from Aquinas: "anyone may lose his crown by mortal sin" (ad 1). -/
def augustinianCite : Claim → AtomMeta
  | .electPersevere =>
    { label := "Those God has chosen to save cannot finally fall away from grace"
    , kind := .theological
    , source :=
        { primary := .work npnfAugustineAntiPelagian (.page 478)
        , supporting := [.work aquinasSumma (.sectionRef "I q.23 a.6")]
        , tradition := .christianHistoricalGrammatical
        , confidence := .wellSupported } }
  | .justifiedCanFinallyFallAway =>
    { label := "One who is truly justified can fall away from grace finally, and perish"
    , kind := .theological
    , source :=
        { primary := .work aquinasSumma (.sectionRef "I q.23 a.6 ad 1")
        , supporting := [.work npnfAugustineAntiPelagian (.page 478)]
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | .apostatesNeverHadTrueFaith =>
    { label := "1 John 2:19, read of every apostate: all who fall away were never true believers"
    , kind := .interpretive
    , source :=
        { primary := .work npnfAugustineAntiPelagian (.pages 479 480)
        , tradition := .christianHistoricalGrammatical
        , confidence := .disputed } }
  | a => baseCite a

end TestimonyArguments.SolaGratia
