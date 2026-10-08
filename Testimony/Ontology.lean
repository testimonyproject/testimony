import Testimony.Ontology.Shared
import Testimony.Ontology.Search
import Testimony.Ontology.Relations

/-!
# Testimony.Ontology — articles that derive what the vocabulary's words mean

The vocabulary (`Testimony.Semantics.Vocabulary`) names the words meanings are
built from. What those words commit a reader to — that the only means of a thing
is a means of it and nothing else is — is not added beside them. It is derived,
in articles, each of which:

1. **searches** every argument's meanings for the claims that use its words,
   and pins what it finds (`Testimony.Ontology.Search`);
2. **defines** what the words mean, each definition with a source, as a premise
   has one; and
3. **reports what follows**: the joins each definition derives, computed with
   the definition and without it, so that what it contributes is a checked fact.

A definition is what a word means, which no reader disputes. What one tradition
holds of a word and another denies is a premise of a position, and an article
that finds one says so and leaves it apart. The shared ontology is every
article's definitions (`Testimony.Ontology.shared`), and every argument's joins
are read under it.

## The articles

- `Testimony.Ontology.Relations` — what three relation words commit a reader
  to: "not a ground", "the only means", "the whole ground".
-/
