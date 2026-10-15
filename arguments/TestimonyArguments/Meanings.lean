import TestimonyArguments.Meanings.BornInBethlehem
import TestimonyArguments.Meanings.BornOfAVirgin
import TestimonyArguments.Meanings.CanonicalWitness
import TestimonyArguments.Meanings.SolaFide
import TestimonyArguments.Meanings.SolaScriptura
import TestimonyArguments.Meanings.SpiritBaptism

/-!
# TestimonyArguments.Meanings — what every argument's claims say

One module per argument, each a `HasMeanings` instance for the argument's
`Claim` type. Sola fide is analysed, and the other arguments where a join turns
on them; their remaining claims are registered with their citations' labels,
marked unanalysed, and counted. The library's `#check_meanings`, run over every
argument in `TestimonyArguments.Checks`, fails the build for an argument with no
instance, so a new argument is registered when it is added.
-/
