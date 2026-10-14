import Testimony.Bib.Registry

/-!
# TestimonyExamples.Works — what the examples cite

The examples' own bibliography: the works their cases cite that the library
does not. Entries are written as the library writes its own
(`Testimony.Bib.Works`), with the same verified identifiers, and collected by
the same `derive_bib_registry` — which must stay at the bottom of this file.
The library's entries are the library's: a case here may cite them, and the
examples' bibliography is the two registries together (`bibliography`).
-/

namespace TestimonyExamples

open Testimony.Bib

/-! ### A cross-examination -/

/-- *My Cousin Vinny*, the film whose cross-examination of Sam Tipton — the grits
— is the first case here (`TestimonyExamples.Grits`). Cited for the scene; its
dialogue is quoted from the court opinion that reproduces it
(`novatoHealthcareNlrb`). Its Wikidata record is the identifier; IMDb lists it
as tt0104952. -/
@[bib_entry] def myCousinVinny : BibEntry := .film
  { core :=
      { key := "launer-my-cousin-vinny-1992"
      , role := .text
      , contributors := { authors := [.person "Dale" "Launer"] }
      , title := "My Cousin Vinny"
      , year := some { value := 1992 }
      , identifiers := [.url "https://www.wikidata.org/wiki/Q838154" (some "2026-10-14")] }
  , directors := [.person "Jonathan" "Lynn"]
  , studio := "Twentieth Century Fox"
  , runtime := some 119 }

/-- Chief Judge Garland's opinion for the D.C. Circuit, which opens: "In 1992,
Vincent Gambini taught a master class in cross-examination." Its note 5 sets out
the grits cross-examination, question by question, and the opinion applies the
same lesson to a supervisor's account of how long a drive took. Cited for the
dialogue of the scene, read from the court's own PDF at govinfo. -/
@[bib_entry] def novatoHealthcareNlrb : BibEntry := .legalCase
  { core :=
      { key := "garland-novato-healthcare-2019"
      , role := .text
      , contributors := { authors := [.person "Merrick" "Garland"] }
      , title := "Novato Healthcare Center v. National Labor Relations Board"
      , year := some { value := 2019 }
      , identifiers :=
          [ .url ("https://www.govinfo.gov/content/pkg/USCOURTS-caDC-17-01221/pdf/" ++
                  "USCOURTS-caDC-17-01221-0.pdf") (some "2026-10-14") ] }
  , court := "United States Court of Appeals for the District of Columbia Circuit"
  , docket := some "17-1221"
  , reporter := some "916 F.3d 1095"
  , decided := some "2019-03-05" }

derive_bib_registry registry

/-- **The examples' bibliography**: the library's entries and the examples' own,
which is what a case here may cite. -/
def bibliography : List BibEntry := Testimony.Bib.registry ++ registry

/-- Every citation key in the examples' bibliography. -/
def bibliographyKeys : List CiteKey := bibliography.map BibEntry.key

-- The library's invariants, over the two registries together: no key is used
-- twice, by an entry here or by one of the library's, and every key is well formed.
#guard !registry.isEmpty
#guard bibliographyKeys.eraseDups.length == bibliographyKeys.length
#guard bibliographyKeys.all keyWellFormed

end TestimonyExamples
