import Testimony.Meanings.BornInBethlehem
import Testimony.Meanings.BornOfAVirgin
import Testimony.Meanings.CanonicalWitness
import Testimony.Meanings.SolaFide
import Testimony.Meanings.SolaScriptura
import Testimony.Meanings.SpiritBaptism

/-!
# Testimony.Meanings — what every argument's claims say

One module per argument, each a `HasMeanings` instance for the argument's
`Claim` type. Sola fide is analysed, and sola scriptura, the virgin birth and
Spirit baptism where a join turns on them; the others are registered with their
citations' labels, marked unanalysed, and counted. `Testimony.Checks.Meanings` fails the
build for an argument with no instance, so a new argument is registered when it
is added.
-/
