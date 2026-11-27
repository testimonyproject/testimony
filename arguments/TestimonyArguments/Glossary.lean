import Testimony.Gloss
import TestimonyArguments.Works

/-!
# The glossary: the English for every Greek and Hebrew word the arguments print

Each entry is a word or phrase exactly as the prose prints it, with every English rendering
the prose may give beside it, and who gives that rendering. Most come from a translation at
a verse where the word stands, the NET and the LSB first, as the library's quotations do,
and the rest from a lexicon: Liddell, Scott and Jones for Greek outside the New Testament,
its shorter companion where that is plainer, and the Septuagint lexicons where the
Septuagint's own usage is the question. Where the translations part, both renderings are
here, each with its source, so that the prose can give both.

A quotation from a father, or from the Septuagint where no translation in the bibliography
renders the Greek, is rendered by the library, and its entry says so, with the reason.

Rule L13 of `scripts/testimony_lint.py` reads this file. A docstring, a label or a page of
the site that prints a Greek or Hebrew word must give one of the word's renderings here
beside it, once in each section, and a word with no entry here fails until it has one.
-/

namespace TestimonyArguments

open Testimony Testimony.Bib

/-- A rendering a work gives, at its entry or verse. -/
private def cite (english : String) (entry : BibEntry) (locus : Locus) : Gloss.Rendering :=
  { english, source := .work entry locus }

/-- A rendering the library gives, and why no cited work gives it. -/
private def propose (english : String) (rationale : String) : Gloss.Rendering :=
  { english, source := .proposal rationale }

/-- A word or phrase, with its renderings. -/
private def gloss (original : String) (renderings : List Gloss.Rendering) : Gloss :=
  { original, renderings }

/-- Every Greek and Hebrew word or phrase the arguments' prose prints, with its English. -/
def glossary : List Gloss :=
  [ gloss "παρθένος"
      [ cite "virgin" netBible (.sectionRef "Matthew 1:23")
      , cite "young woman" muraokaLexiconSeptuagint (.page 535)
      , cite "maiden" liddellScottJones (.sectionRef "s.v. παρθένος")
      , cite "girl" liddellScottJones (.sectionRef "s.v. παρθένος") ]
  , gloss "παρθενος"
      [ cite "virgin" netBible (.sectionRef "Matthew 1:23")
      , cite "young woman" muraokaLexiconSeptuagint (.page 535) ]
  , gloss "ἡ παρθένος"
      [ cite "the virgin" netBible (.sectionRef "Matthew 1:23") ]
  , gloss "παρθένοι"
      [ cite "virgins" lsb (.sectionRef "Isaiah 23:4")
      , cite "young women" netBible (.sectionRef "Isaiah 23:4") ]
  , gloss "παρθεν"
      [ cite "virgin" netBible (.sectionRef "Matthew 1:23") ]
  , gloss "τὰ παρθένια"
      [ cite "tokens of virginity" muraokaLexiconSeptuagint (.page 535)
      , cite "signs of virginity" liddellScottJones (.sectionRef "s.v. παρθένια") ]
  , gloss "παρθένια"
      [ cite "tokens of virginity" muraokaLexiconSeptuagint (.page 535)
      , cite "signs pertaining to virginity" lustLexiconSeptuagint (.sectionRef "s.v. παρθένια")
      , cite "virginity" lustLexiconSeptuagint (.sectionRef "s.v. παρθένια") ]
  , gloss "τὸν παρθενικόν"
      [ cite "the bridegroom of her youth" lsb (.sectionRef "Joel 1:8")
      , cite "first husband" middleLiddell (.sectionRef "s.v. παρθένιος") ]
  , gloss "παῖς παρθένος"
      [ cite "a girl who is a virgin" lsb (.sectionRef "Deuteronomy 22:23")
      , cite "a virgin" netBible (.sectionRef "Deuteronomy 22:23") ]
  , gloss "παῖς"
      [ cite "girl" liddellScottJones (.sectionRef "s.v. παῖς")
      , cite "child" middleLiddell (.sectionRef "s.v. παῖς") ]
  , gloss "νεᾶνις"
      [ cite "young woman" middleLiddell (.sectionRef "s.v. νεᾶνις")
      , cite "girl" liddellScottJones (.sectionRef "s.v. νεᾶνις")
      , cite "maiden" liddellScottJones (.sectionRef "s.v. νεᾶνις") ]
  , gloss "νεανις"
      [ cite "young woman" middleLiddell (.sectionRef "s.v. νεᾶνις") ]
  , gloss "νεότης"
      [ cite "youth" liddellScottJones (.sectionRef "s.v. νεότης") ]
  , gloss "νύμφην"
      [ cite "bride" liddellScottJones (.sectionRef "s.v. νύμφη")
      , cite "young wife" liddellScottJones (.sectionRef "s.v. νύμφη") ]
  , gloss "γυνή"
      [ cite "woman" liddellScottJones (.sectionRef "s.v. γυνή")
      , cite "wife" liddellScottJones (.sectionRef "s.v. γυνή") ]
  , gloss "σπέρμα"
      [ cite "seed" liddellScottJones (.sectionRef "s.v. σπέρμα")
      , cite "offspring" middleLiddell (.sectionRef "s.v. σπέρμα") ]
  , gloss "αὐτός"
      [ cite "he" liddellScottJones (.sectionRef "s.v. αὐτός") ]
  , gloss "αὐτόν"
      [ cite "him" liddellScottJones (.sectionRef "s.v. αὐτός") ]
  , gloss "αὐτοῦ"
      [ cite "his" liddellScottJones (.sectionRef "s.v. αὐτός") ]
  , gloss "σου"
      [ cite "your" netBible (.sectionRef "Hebrews 1:8") ]
  , gloss "ὅς"
      [ cite "who" liddellScottJones (.sectionRef "s.v. ὅς") ]
  , gloss "φερνή"
      [ cite "dowry" liddellScottJones (.sectionRef "s.v. φερνή") ]
  , gloss "ἄσχημον"
      [ cite "unseemly" liddellScottJones (.sectionRef "s.v. ἀσχήμων")
      , cite "shameful" liddellScottJones (.sectionRef "s.v. ἀσχήμων") ]
  , gloss "ἀφροσύνην"
      [ cite "folly" liddellScottJones (.sectionRef "s.v. ἀφροσύνη") ]
  , gloss "ἐν γαστρὶ ἕξει"
      [ cite "shall be with child" lsb (.sectionRef "Matthew 1:23")
      , cite "will conceive" netBible (.sectionRef "Matthew 1:23") ]
  , gloss "ἰδοὺ ἡ παρθένος ἐν γαστρὶ ἕξει"
      [ cite "Behold, the virgin shall be with child" lsb (.sectionRef "Matthew 1:23")
      , cite "Look! The virgin will conceive" netBible (.sectionRef "Matthew 1:23") ]
  , gloss "ἰδοὺ ἡ παρθένος ἐν γαστρὶ ἕξει καὶ τέξεται υἱόν"
      [ cite "Behold, the virgin shall be with child and shall bear a Son" lsb
          (.sectionRef "Matthew 1:23")
      , cite "Look! The virgin will conceive and give birth to a son" netBible
          (.sectionRef "Matthew 1:23") ]
  , gloss "γυναῖκα παρθένον ἐκ τοῦ γένους αὐτοῦ"
      [ propose "a wife, a virgin, from his own kin"
          ("The library's word-for-word rendering of Leviticus 21:13 in Rahlfs's Septuagint," ++
           " which no translation in the bibliography renders from the Greek.") ]
  , gloss "ἡ φερνὴ τῶν παρθένων"
      [ propose "the bride-price of virgins"
          ("The library's word-for-word rendering of Exodus 22:16 in Rahlfs's Septuagint; " ++
           "the NET gives the Hebrew of the same verse (22:17 there) as “the bride price for" ++
           " virgins”.") ]
  , gloss "ἐταπείνωσεν αὐτήν"
      [ propose "humbled her"
          ("The library's rendering of Genesis 34:2 in Rahlfs's Septuagint, in the words the" ++
           " LSB gives the same Hebrew verb at Deuteronomy 21:14.") ]
  , gloss "καὶ ἀνὰ μέσον τοῦ σπέρματος αὐτῆς· αὐτός σου τηρήσει κεφαλήν"
      [ propose "and between her seed: he will watch for your head"
          ("The library's word-for-word rendering of Genesis 3:15 in Rahlfs's Septuagint, " ++
           "which no translation in the bibliography renders from the Greek.") ]
  , gloss "κἂν εἰ λέγοιτο νεᾶνις ἡ παρθένος, οὐκ ἔξω κείσεται τοῦ εἶναι παρθένος"
      [ propose "even if the virgin were called a young woman, she will not cease to be a virgin"
          ("The library's rendering of Cyril of Alexandria's Greek, read in Migne (PG 70, " ++
           "204B).") ]
  , gloss "οὐδεὶς δὲ σημεῖον καλεῖ τὸ καθ' ἑκάστην γινόμενον ἡμέραν"
      [ propose "no one calls a sign what happens every day"
          "The library's rendering of Theodoret's Greek, read in Migne (PG 81, 276D)." ]
  , gloss "ὁ ὄφις ὁ ἀρχαῖος"
      [ cite "the serpent of old" lsb (.sectionRef "Revelation 12:9")
      , cite "the ancient serpent" netBible (.sectionRef "Revelation 12:9") ]
  , gloss "γενόμενον ἐκ γυναικός"
      [ cite "born of a woman" lsb (.sectionRef "Galatians 4:4") ]
  , gloss "καταργήσῃ"
      [ cite "render powerless" lsb (.sectionRef "Hebrews 2:14")
      , cite "destroy" netBible (.sectionRef "Hebrews 2:14") ]
  , gloss "עַלְמָה"
      [ cite "virgin" lsb (.sectionRef "Isaiah 7:14")
      , cite "young woman" netBible (.sectionRef "Isaiah 7:14")
      , cite "maiden" lsb (.sectionRef "Isaiah 7:14, note") ]
  , gloss "עלמה"
      [ cite "virgin" lsb (.sectionRef "Isaiah 7:14")
      , cite "young woman" netBible (.sectionRef "Isaiah 7:14") ]
  , gloss "הָעַלְמָה"
      [ cite "the virgin" lsb (.sectionRef "Isaiah 7:14")
      , cite "the young woman" netBible (.sectionRef "Genesis 24:43") ]
  , gloss "עֲלָמוֹת"
      [ cite "maidens" lsb (.sectionRef "Song of Songs 6:8")
      , cite "virgins" lsb (.sectionRef "Song of Songs 6:8, note")
      , cite "young women" netBible (.sectionRef "Song of Songs 6:8") ]
  , gloss "עוּלֵימְתָא"
      [ propose "young woman"
          ("The Aramaic of Targum Jonathan at Isaiah 7:14, in the sense the library's cited " ++
           "readers give it, as the Targum's counterpart of the Hebrew's “young woman” " ++
           "(NET).") ]
  , gloss "בְּתוּלָה"
      [ cite "virgin" netBible (.sectionRef "Deuteronomy 22:23") ]
  , gloss "בְּתוּלַת"
      [ cite "virgin" netBible (.sectionRef "Isaiah 23:12") ]
  , gloss "בְּתוּלִים"
      [ cite "evidence of virginity" netBible (.sectionRef "Deuteronomy 22:15") ]
  , gloss "נַעֲרָה"
      [ cite "young woman" netBible (.sectionRef "Deuteronomy 22:15")
      , cite "girl" lsb (.sectionRef "Deuteronomy 22:15") ]
  , gloss "הָרָה"
      [ cite "with child" lsb (.sectionRef "Isaiah 7:14")
      , cite "pregnant" netBible (.sectionRef "Genesis 16:11")
      , cite "conceive" netBible (.sectionRef "Isaiah 7:14") ]
  , gloss "זֶרַע"
      [ cite "seed" lsb (.sectionRef "Genesis 3:15")
      , cite "offspring" netBible (.sectionRef "Genesis 3:15") ]
  , gloss "זַרְעֵךְ"
      [ cite "your seed" lsb (.sectionRef "Genesis 16:10")
      , cite "your descendants" netBible (.sectionRef "Genesis 16:10") ]
  , gloss "זֶרַע הָאִשָּׁה"
      [ cite "her seed" lsb (.sectionRef "Genesis 3:15")
      , propose "the woman's seed"
          ("The name the commentators the library cites give to Genesis 3:15's “her seed” " ++
           "(LSB).") ]
  , gloss "הוּא"
      [ cite "he" lsb (.sectionRef "Genesis 3:15")
      , propose "it"
          ("The neuter rendering of the pronoun at Genesis 3:15 that the reading cited at " ++
           "this step takes, against the LSB's “He”.") ]
  , gloss "אַתָּה"
      [ cite "you" netBible (.sectionRef "Isaiah 7:16") ]
  , gloss "וְאַתָּה"
      [ cite "But as for you" lsb (.sectionRef "Micah 5:2")
      , cite "As for you" netBible (.sectionRef "Micah 5:2")
      , propose "and you"
          ("The library's word-for-word rendering of the conjunction and the pronoun the " ++
           "word is written as.") ]
  , gloss "לָכֶם"
      [ cite "you" netBible (.sectionRef "Isaiah 7:14") ]
  , gloss "שִׁמְעוּ־נָא בֵּית דָּוִד"
      [ cite "Listen now, O house of David" lsb (.sectionRef "Isaiah 7:13")
      , cite "Pay attention, family of David" netBible (.sectionRef "Isaiah 7:13") ]
  , gloss "יהוה"
      [ cite "the LORD" netBible (.sectionRef "Isaiah 7:10") ]
  , gloss "אדני"
      [ cite "the Lord" netBible (.sectionRef "Isaiah 7:14") ]
  , gloss "וקראת"
      [ propose "and she shall call"
          ("The library's word-for-word rendering of the Masoretic Text's form at Isaiah " ++
           "7:14, which the LSB gives as “she will call”.") ]
  , gloss "וקרא"
      [ propose "and one shall call"
          ("The library's word-for-word rendering of the form 1QIsaᵃ has at Isaiah 7:14 in " ++
           "place of the Masoretic Text's “and she shall call”.") ]
  , gloss "הנה העלמה הרה"
      [ cite "Behold, the virgin will be with child" lsb (.sectionRef "Isaiah 7:14")
      , cite "Look, this young woman is about to conceive" netBible (.sectionRef "Isaiah 7:14") ]
  , gloss "וְאִישׁ לֹא יְדָעָהּ"
      [ cite "no man had known her" lsb (.sectionRef "Genesis 24:16")
      , cite "no man had ever been physically intimate with her" netBible
          (.sectionRef "Genesis 24:16") ]
  , gloss "אִשָּׁה בִבְתוּלֶיהָ"
      [ cite "a wife in her virginity" lsb (.sectionRef "Leviticus 21:13") ]
  , gloss "מֹהַר הַבְּתוּלֹת"
      [ cite "the bride price of virgins" netBible (.sectionRef "Exodus 22:17") ]
  , gloss "מֹהַר"
      [ cite "bride price" netBible (.sectionRef "Genesis 34:12")
      , cite "bridal payment" lsb (.sectionRef "Genesis 34:12") ]
  , gloss "וַיְעַנֶּהָ"
      [ cite "violated her" lsb (.sectionRef "Genesis 34:2")
      , cite "humbled her" lsb (.sectionRef "Deuteronomy 21:14") ]
  , gloss "נְבָלָה עָשָׂה בְיִשְׂרָאֵל"
      [ cite "he had done a disgraceful thing in Israel" lsb (.sectionRef "Genesis 34:7") ]
  , gloss "δικαιόω"
      [ cite "justify" lsb (.sectionRef "Romans 3:30")
      , cite "justified" netBible (.sectionRef "Romans 8:30")
      , cite "justifies" lsb (.sectionRef "Romans 4:5")
      , cite "declared righteous" netBible (.sectionRef "Romans 3:28")
      , cite "vindicate" bdag (.sectionRef "s.v. δικαιόω")
      , cite "vindicated" netBible (.sectionRef "Matthew 11:19")
      , cite "render a favorable verdict" bdag (.sectionRef "s.v. δικαιόω")
      , cite "made righteous" npnfAugustineAntiPelagian
          (.sectionRef "On the Spirit and the Letter 45")
      , cite "set right" liddellScottJones (.sectionRef "s.v. δικαιόω") ]
  , gloss "δεδικαιωμένος"
      [ cite "justified" netBible (.sectionRef "Luke 18:14") ]
  , gloss "δικαιοῦται"
      [ cite "is justified" netBible (.sectionRef "James 2:24") ]
  , gloss "δικαιωθῆναι"
      [ cite "to be justified" netBible (.sectionRef "Galatians 2:17") ]
  , gloss "δικαιωθήτω"
      [ propose "let him be justified still"
          ("The library's word-for-word rendering of the Textus Receptus at Revelation " ++
           "22:11, where the critical editions read otherwise.") ]
  , gloss "δικαιοσύνη"
      [ cite "righteousness" netBible (.sectionRef "Romans 1:17") ]
  , gloss "δικαιοσύνη θεοῦ"
      [ cite "the righteousness of God" netBible (.sectionRef "Romans 1:17") ]
  , gloss "δικαιοσύνην ποιησάτω ἔτι"
      [ cite "still do righteousness" lsb (.sectionRef "Revelation 22:11")
      , cite "act righteously" netBible (.sectionRef "Revelation 22:11") ]
  , gloss "δίκαιος"
      [ cite "righteous" netBible (.sectionRef "Romans 1:17") ]
  , gloss "δίκαιοι"
      [ cite "righteous" netBible (.sectionRef "Romans 5:19") ]
  , gloss "δίκαιοι κατασταθήσονται"
      [ cite "will be made righteous" esv (.sectionRef "Romans 5:19")
      , cite "will be appointed righteous" lsb (.sectionRef "Romans 5:19")
      , cite "will be constituted righteous" netBible (.sectionRef "Romans 5:19") ]
  , gloss "καθίστημι"
      [ cite "constitute" netBible (.sectionRef "Romans 5:19")
      , cite "appoint" lsb (.sectionRef "Romans 5:19")
      , cite "make" esv (.sectionRef "Romans 5:19")
      , cite "set down" liddellScottJones (.sectionRef "s.v. καθίστημι") ]
  , gloss "ἔργα νόμου"
      [ cite "works of the law" netBible (.sectionRef "Galatians 2:16") ]
  , gloss "ἔργα"
      [ cite "works" netBible (.sectionRef "Galatians 2:16")
      , cite "deeds" netBible (.sectionRef "Matthew 11:19") ]
  , gloss "ἔργον"
      [ cite "work" lsb (.sectionRef "John 6:29")
      , cite "deed" netBible (.sectionRef "John 6:29") ]
  , gloss "ἐξ ἔργων"
      [ cite "by works" netBible (.sectionRef "James 2:24")
      , propose "out of works"
          ("The library's word-for-word rendering, giving the preposition its first sense " ++
           "in LSJ, “out of”.") ]
  , gloss "ἐκ"
      [ cite "out of" liddellScottJones (.sectionRef "s.v. ἐκ") ]
  , gloss "ἐκ τῶν ἔργων ἐτελειώθη"
      [ cite "as a result of the works, faith was perfected" lsb (.sectionRef "James 2:22")
      , cite "faith was perfected by works" netBible (.sectionRef "James 2:22") ]
  , gloss "συνήργει"
      [ cite "was working with" lsb (.sectionRef "James 2:22")
      , cite "was working together" netBible (.sectionRef "James 2:22") ]
  , gloss "κἀγώ σοι δείξω ἐκ τῶν ἔργων μου τὴν πίστιν"
      [ cite "I will show you my faith by my works" lsb (.sectionRef "James 2:18")
      , cite "I will show you faith by my works" netBible (.sectionRef "James 2:18") ]
  , gloss "ἐνεργουμένη"
      [ cite "working" netBible (.sectionRef "Galatians 5:6")
      , cite "made operative" robinsonEphesians (.pages 245 246)
      , cite "moved and acted upon" bellarmineOpera6 (.page 219) ]
  , gloss "ἐνεργεῖσθαι"
      [ cite "to be effective" liddellScottJones (.sectionRef "s.v. ἐνεργέω")
      , cite "to be efficacious" liddellScottJones (.sectionRef "s.v. ἐνεργέω") ]
  , gloss "ἐνεργέω"
      [ cite "work" netBible (.sectionRef "Galatians 3:5")
      , cite "to be in action" liddellScottJones (.sectionRef "s.v. ἐνεργέω")
      , cite "operate" liddellScottJones (.sectionRef "s.v. ἐνεργέω") ]
  , gloss "ἐνεργεῖν"
      [ cite "to work" lsb (.sectionRef "Philippians 2:13") ]
  , gloss "ὁ ἐνεργῶν"
      [ cite "works" lsb (.sectionRef "Galatians 3:5")
      , propose "the one who works"
          ("The library's rendering of the participle with its article at Galatians 3:5, " ++
           "which the LSB gives as “works”.") ]
  , gloss "πίστις δι' ἀγάπης ἐνεργουμένη"
      [ cite "faith working through love" netBible (.sectionRef "Galatians 5:6") ]
  , gloss "δι᾽ ἀγάπης"
      [ cite "through love" netBible (.sectionRef "Galatians 5:6") ]
  , gloss "διά"
      [ cite "through" netBible (.sectionRef "Galatians 5:6") ]
  , gloss "ἀγάπη"
      [ cite "love" netBible (.sectionRef "1 Corinthians 13:13") ]
  , gloss "πίστις"
      [ cite "faith" netBible (.sectionRef "1 Corinthians 13:13") ]
  , gloss "ἡ πίστις σου σέσωκέν σε"
      [ cite "Your faith has saved you" netBible (.sectionRef "Luke 7:50") ]
  , gloss "πίστις χριστοῦ"
      [ cite "faith in Christ" lsb (.sectionRef "Galatians 2:16")
      , cite "faithfulness of Christ" netBible (.sectionRef "Galatians 2:16")
      , propose "faith of Christ"
          ("The phrase rendered word for word, as the debate over it names it, leaving open " ++
           "whether Christ is the one believed in or the one who is faithful.") ]
  , gloss "πιστις χριστου"
      [ propose "faith of Christ"
          "The phrase rendered word for word, as the debate over it names it." ]
  , gloss "πίστεως ἰησοῦ χριστοῦ"
      [ cite "the faithfulness of Jesus Christ" netBible (.sectionRef "Galatians 2:16")
      , cite "faith in Jesus Christ" lsb (.sectionRef "Galatians 2:16") ]
  , gloss "πίστεως μόνον"
      [ cite "faith alone" netBible (.sectionRef "James 2:24") ]
  , gloss "πίστει δὲ μόνῃ τῇ εἰς χριστόν"
      [ propose "by faith alone, the faith in Christ"
          "The library's rendering of Basil's Greek, On Humility 3, read in Migne." ]
  , gloss "πίστει δὲ μόνῃ τῇ εἰς χριστὸν δεδικαιωμένον"
      [ propose "justified by faith alone, the faith in Christ"
          "The library's rendering of Basil's Greek, On Humility 3, read in Migne." ]
  , gloss "διὰ πίστεως"
      [ cite "through faith" netBible (.sectionRef "Ephesians 2:8") ]
  , gloss "χάρις"
      [ cite "grace" netBible (.sectionRef "Ephesians 2:8") ]
  , gloss "τοῦτο"
      [ cite "this" netBible (.sectionRef "Ephesians 2:8") ]
  , gloss "καὶ τοῦτο"
      [ cite "and this" netBible (.sectionRef "Ephesians 2:8") ]
  , gloss "πιστεύω"
      [ cite "believe" netBible (.sectionRef "John 3:16") ]
  , gloss "πιστεύειν εἰς"
      [ cite "believe in" netBible (.sectionRef "Acts 16:31")
      , propose "believe into"
          ("The library's word-for-word rendering, giving the preposition its sense in LSJ, " ++
           "“into”, which the argument turns on.") ]
  , gloss "πιστεύειν εἰς τὸν ἰησοῦν"
      [ propose "to believe in Jesus"
          ("The library's rendering of the phrase Thayer quotes (p. 511), in the words of " ++
           "the NET at John 3:16, “believes in him”.") ]
  , gloss "εἰς τ. υἱὸν τοῦ θεοῦ"
      [ propose "in the Son of God"
          ("The library's rendering of the phrase Thayer quotes (p. 511), with its " ++
           "abbreviated article written out.") ]
  , gloss "ὁ πιστεύων εἰς αὐτόν"
      [ cite "whoever believes in him" lsb (.sectionRef "John 3:16")
      , cite "the one who believes in him" netBible (.sectionRef "John 3:18") ]
  , gloss "πεπίστευκεν εἰς τὸ ὄνομα"
      [ cite "believed in the name" netBible (.sectionRef "John 3:18") ]
  , gloss "πιστεύητε εἰς ὃν ἀπέστειλεν"
      [ cite "believe in Him whom He has sent" lsb (.sectionRef "John 6:29")
      , cite "believe in the one whom he sent" netBible (.sectionRef "John 6:29") ]
  , gloss "πιστεύσωμέν σοι"
      [ cite "believe You" lsb (.sectionRef "John 6:30")
      , cite "believe you" netBible (.sectionRef "John 6:30") ]
  , gloss "εἰς"
      [ cite "into" liddellScottJones (.sectionRef "s.v. εἰς")
      , cite "in" netBible (.sectionRef "John 3:16") ]
  , gloss "ὄνομα"
      [ cite "name" netBible (.sectionRef "Acts 10:43") ]
  , gloss "ὁ ἀπειθῶν"
      [ cite "rejects" netBible (.sectionRef "John 3:36")
      , cite "does not obey" lsb (.sectionRef "John 3:36") ]
  , gloss "ζάω"
      [ cite "live" netBible (.sectionRef "Romans 1:17") ]
  , gloss "εὐαρεστέω"
      [ cite "please" netBible (.sectionRef "Hebrews 11:6") ]
  , gloss "περιποίησις ψυχῆς"
      [ cite "preserving of the soul" lsb (.sectionRef "Hebrews 10:39") ]
  , gloss "ἔλεος"
      [ cite "mercy" netBible (.sectionRef "Titus 3:5") ]
  , gloss "ἀνακαίνωσις"
      [ cite "renewing" netBible (.sectionRef "Titus 3:5") ]
  , gloss "ἁγιασμός"
      [ cite "sanctification" lsb (.sectionRef "1 Thessalonians 4:3") ]
  , gloss "μισθός"
      [ cite "wage" lsb (.sectionRef "Romans 4:4")
      , cite "pay" netBible (.sectionRef "Romans 4:4") ]
  , gloss "λογίζομαι"
      [ cite "credit" netBible (.sectionRef "Romans 4:3")
      , cite "count" lsb (.sectionRef "Romans 4:3")
      , cite "reckon" liddellScottJones (.sectionRef "s.v. λογίζομαι") ]
  , gloss "ἔθνη"
      [ cite "the nations" netBible (.sectionRef "Galatians 3:8")
      , cite "Gentiles" netBible (.sectionRef "Galatians 3:8") ]
  , gloss "ὅτι"
      [ cite "for" netBible (.sectionRef "Luke 7:47")
      , cite "because" liddellScottJones (.sectionRef "s.v. ὅτι") ]
  , gloss "ὑπό"
      [ cite "by" liddellScottJones (.sectionRef "s.v. ὑπό") ]
  , gloss "ἐὰν μή"
      [ cite "unless" netBible (.sectionRef "John 3:5")
      , cite "except" netBible (.sectionRef "Mark 4:22") ]
  , gloss "σῴζω"
      [ cite "save" netBible (.sectionRef "Luke 7:50")
      , cite "saved" netBible (.sectionRef "Luke 7:50")
      , cite "made you well" netBible (.sectionRef "Luke 8:48")
      , cite "healed" netBible (.sectionRef "Luke 8:50") ]
  , gloss "σωθῆναι"
      [ cite "be saved" netBible (.sectionRef "Acts 15:1")
      , cite "are saved" netBible (.sectionRef "Acts 15:11") ]
  , gloss "διαθήκη"
      [ cite "covenant" netBible (.sectionRef "Galatians 3:15") ]
  , gloss "μὴ ἐμποδισθῇς τοῦ ἀποδοῦναι εὐχὴν εὐκαίρως"
      [ propose "let nothing hinder you from paying a vow in due time"
          "The library's rendering of Sirach 18:22 in Swete's Septuagint." ]
  , gloss "καὶ μὴ μείνῃς ἕως θανάτου δικαιωθῆναι"
      [ propose "and do not wait until death to be justified"
          "The library's rendering of Sirach 18:22 in Swete's Septuagint."
      , propose "do not wait until death to be justified"
          "The library's rendering of Sirach 18:22 in Swete's Septuagint." ]
  , gloss "ἐπισκοπή"
      [ cite "office" lsb (.sectionRef "Acts 1:20")
      , cite "position of responsibility" netBible (.sectionRef "Acts 1:20") ]
  , gloss "ἐπίσκοπος"
      [ cite "overseer" netBible (.sectionRef "1 Timothy 3:2")
      , cite "bishop" nabre (.sectionRef "1 Timothy 3:2") ]
  , gloss "παρ' ὅ"
      [ cite "contrary to" netBible (.sectionRef "Galatians 1:8")
      , cite "other than" nabre (.sectionRef "Galatians 1:8") ]
  , gloss "παρεδίδοσαν"
      [ cite "delivering" lsb (.sectionRef "Acts 16:4")
      , cite "passed on" netBible (.sectionRef "Acts 16:4") ]
  , gloss "παραδόσεις"
      [ cite "traditions" netBible (.sectionRef "2 Thessalonians 2:15") ]
  , gloss "παράδοσις"
      [ cite "tradition" netBible (.sectionRef "Matthew 15:2") ]
  , gloss "ἔθος"
      [ cite "custom" netBible (.sectionRef "Acts 15:1") ]
  , gloss "ζυγός"
      [ cite "yoke" netBible (.sectionRef "Acts 15:10") ]
  , gloss "καθέδρα"
      [ cite "chair" lsb (.sectionRef "Matthew 23:2")
      , cite "seat" netBible (.sectionRef "Matthew 23:2") ]
  , gloss "ἐπὶ τῆς μωϋσέως καθέδρας"
      [ cite "in the chair of Moses" lsb (.sectionRef "Matthew 23:2")
      , cite "on Moses' seat" netBible (.sectionRef "Matthew 23:2") ]
  , gloss "ὁδηγοὶ τυφλοί"
      [ cite "blind guides" netBible (.sectionRef "Matthew 23:16") ]
  , gloss "ποιήσατε καὶ τηρεῖτε"
      [ cite "do and keep" lsb (.sectionRef "Matthew 23:3") ]
  , gloss "τηρεῖτε"
      [ cite "keep" lsb (.sectionRef "Matthew 23:3") ]
  , gloss "στήσητε"
      [ propose "establish"
          "The library's rendering of the Nestle-Aland reading at Mark 7:9." ]
  , gloss "οὐ δύναται λυθῆναι"
      [ cite "cannot be broken" netBible (.sectionRef "John 10:35") ]
  , gloss "ἡ γραφή"
      [ cite "the scripture" netBible (.sectionRef "John 10:35") ]
  , gloss "πᾶσα γραφή"
      [ cite "every scripture" netBible (.sectionRef "2 Timothy 3:16")
      , cite "all Scripture" lsb (.sectionRef "2 Timothy 3:16") ]
  , gloss "θεόπνευστος"
      [ cite "inspired by God" netBible (.sectionRef "2 Timothy 3:16")
      , cite "God-breathed" lsb (.sectionRef "2 Timothy 3:16") ]
  , gloss "ὠφέλιμος"
      [ cite "useful" netBible (.sectionRef "2 Timothy 3:16")
      , cite "profitable" lsb (.sectionRef "2 Timothy 3:16") ]
  , gloss "ἰῶτα ἓν ἢ μία κεραία"
      [ cite "the smallest letter or stroke" netBible (.sectionRef "Matthew 5:18") ]
  , gloss "ἰῶτα"
      [ cite "smallest letter" netBible (.sectionRef "Matthew 5:18")
      , cite "jot" liddellScottJones (.sectionRef "s.v. ἰῶτα") ]
  , gloss "κεραία"
      [ cite "stroke" netBible (.sectionRef "Matthew 5:18") ]
  , gloss "ἀνάθεμα"
      [ cite "accursed" lsb (.sectionRef "Galatians 1:8")
      , cite "condemned to hell" netBible (.sectionRef "Galatians 1:8") ]
  , gloss "ἐν βάρει"
      [ cite "a burden" lsb (.sectionRef "1 Thessalonians 2:6")
      , cite "weight" netBible (.sectionRef "1 Thessalonians 2:7") ]
  , gloss "ὅπως ἐκζητήσωσιν οἱ κατάλοιποι τῶν ἀνθρώπων"
      [ cite "so that the rest of mankind may seek" lsb (.sectionRef "Acts 15:17")
      , cite "so that the rest of humanity may seek" netBible (.sectionRef "Acts 15:17") ]
  , gloss "θεός"
      [ cite "God" netBible (.sectionRef "John 1:1") ]
  , gloss "ὁ θεός"
      [ cite "God" netBible (.sectionRef "John 1:1") ]
  , gloss "τὸν θεόν"
      [ cite "God" netBible (.sectionRef "John 1:1") ]
  , gloss "λόγος"
      [ cite "Word" netBible (.sectionRef "John 1:1") ]
  , gloss "ὁ λόγος"
      [ cite "the Word" netBible (.sectionRef "John 1:1") ]
  , gloss "ἦν"
      [ cite "was" netBible (.sectionRef "John 1:1") ]
  , gloss "καὶ θεὸς ἦν ὁ λόγος"
      [ cite "and the Word was God" lsb (.sectionRef "John 1:1")
      , cite "and the Word was fully God" netBible (.sectionRef "John 1:1") ]
  , gloss "τὰ πάντα"
      [ cite "all things" lsb (.sectionRef "John 1:3") ]
  , gloss "εἷς"
      [ cite "one" netBible (.sectionRef "Mark 10:18") ]
  , gloss "πνεῦμα"
      [ cite "Spirit" netBible (.sectionRef "John 15:26") ]
  , gloss "ἀγαπητός"
      [ cite "beloved" lsb (.sectionRef "Mark 1:11")
      , cite "dear" netBible (.sectionRef "Mark 1:11") ]
  , gloss "ἐκπόρευσις"
      [ propose "procession"
          ("The name Western theology gives the Spirit's origin, which the Greek fathers " ++
           "distinguish from the Latin processio; the library's sources at this step draw " ++
           "the distinction.") ]
  , gloss "ἐκπορεύεται"
      [ cite "proceeds" lsb (.sectionRef "John 15:26")
      , cite "goes out" netBible (.sectionRef "John 15:26") ]
  , gloss "διὰ τοῦ υἱοῦ"
      [ propose "through the Son"
          ("The library's rendering of the phrase of the Greek fathers, as the cited readers" ++
           " at this step quote it.") ]
  , gloss "παρά"
      [ cite "from" netBible (.sectionRef "John 15:26") ]
  , gloss "ὑπόστασις"
      [ propose "person"
          ("The Latin persona, by which the West renders the hypostasis that Basil sets " ++
           "against ousia (Letter 236, §6), and the word the library's sources at this step " ++
           "use.")
      , cite "hypostasis" npnf2v8 (.sectionRef "Letter 214, §4") ]
  , gloss "οὐσία"
      [ cite "essence" npnf2v8 (.sectionRef "Letter 236, §6")
      , cite "substance" npnf2v8 (.sectionRef "Letter 236, §6") ]
  , gloss "ὁμοούσιον"
      [ cite "of one substance" npnf2v14 (.sectionRef "The Creed of Nicaea") ]
  , gloss "ὁμοούσιος"
      [ cite "of one substance" npnf2v14 (.sectionRef "The Creed of Nicaea") ]
  , gloss "τί με λέγεις ἀγαθόν; οὐδεὶς ἀγαθός, εἰ μὴ εἷς, ὁ θεός"
      [ cite "Why do you call me good? No one is good except God alone" netBible
          (.sectionRef "Mark 10:18") ]
  , gloss "τί με ἐρωτᾷς περὶ τοῦ ἀγαθοῦ; εἷς ἐστιν ὁ ἀγαθός"
      [ cite "Why do you ask me about what is good? There is only one who is good" netBible
          (.sectionRef "Matthew 19:17") ] ]

end TestimonyArguments
