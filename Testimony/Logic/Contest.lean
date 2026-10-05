import Testimony.Logic.Dispute
import Testimony.Logic.Framework

/-!
# Testimony.Logic.Contest — whether a dispute over a claim survives weighing

A premise is rated `disputed` when a cited source grants its grounds and denies
its conclusion. That is a fact about the literature: someone denies it. It is
not yet a fact about the argument — whether the denial, once it is stated as a
position and weighed against everything else the library holds, can still be
defended.

This module states that second fact, and makes it a computed result.

- A claim is **contested** in a dispute when one party holds it and another
  denies it, and **each can be defended**: some admissible set — a position
  that answers every attack on it — holds each of them. Then the dispute over
  the claim is live, and the rating `disputed` is what the weighing finds, not
  only what the citation says.
- A claim's denial is **answered** when every party that denies it is
  indefensible: no admissible set holds any of them. Then the claim is disputed
  in the literature and the denial does not survive the weighing; a page should
  say both.

## What this computes, and what it does not

The weighing takes the cited ratings as its input: whether one party defeats
another depends on the confidence of what each rests on. So a contest result
does not make ratings out of nothing. It says what the ratings already in the
library imply for this claim, once the positions that hold and deny it are
heard together — whether a denial that is cited can also be defended. A rating
moves only with a new, cited argument; what changes here is that the page can
report, as a checked result, whether the dispute the rating records is still
standing.

Both results are relative to the dispute: to its parties, and to what each
rests on. A denial answered in one hearing may stand in another that leaves
its answerer out; the hearing is named in every result.
-/

namespace Testimony.Logic

open Framework

variable {α ι : Type} [HasPostulates α]

/-- **The claim `φ` is contested in the dispute**: `holder` holds it, `denier`
denies it, and both can be defended. -/
structure Contested (D : Dispute α ι) (φ : Formula α) where
  /-- A party whose premises entail the claim. -/
  holder : ι
  /-- A party whose premises entail its negation. -/
  denier : ι
  /-- The holder holds it. -/
  holds : Entails (D.node holder).premises φ
  /-- The denier denies it. -/
  denies : Entails (D.node denier).premises (∼φ)
  /-- Some admissible set holds the holder. -/
  holderDefensible : CredulouslyAccepted D.defeats holder
  /-- Some admissible set holds the denier. -/
  denierDefensible : CredulouslyAccepted D.defeats denier

/-- **The denial of `φ` is answered in the dispute**: every listed party that
denies it is indefensible, and the list is every party that denies it. -/
structure DenialAnswered (D : Dispute α ι) (φ : Formula α) where
  /-- The parties that deny the claim. -/
  deniers : List ι
  /-- Each denies it. -/
  deny : ∀ i ∈ deniers, Entails (D.node i).premises (∼φ)
  /-- No other party does. -/
  complete : ∀ i, Entails (D.node i).premises (∼φ) → i ∈ deniers
  /-- None of them can be defended. -/
  indefensible : ∀ i ∈ deniers, ∀ S : Set ι, Admissible D.defeats S → i ∉ S

end Testimony.Logic
