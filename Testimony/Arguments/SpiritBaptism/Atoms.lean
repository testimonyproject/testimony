import Testimony.Attr
import Testimony.Logic.Line
import Testimony.Scripture

/-!
# Arguments.SpiritBaptism.Atoms — the atomic claims

The texts each side reads, the readings each side gives them, and the three
positions' conclusions. The texts are kept apart from the readings, so that a
reader can see which claims are what Luke and Paul say and which are what a
tradition says they mean.
-/

namespace Testimony.Arguments.SpiritBaptism

/-- The atomic claims this argument is built from. -/
inductive Claim
  /-- 1 Corinthians 12:13 — "in one Spirit we were all baptized into one
  body". -/
  | cor12_13AllBaptizedInOneSpirit
  /-- Acts 8:14–17 and 19:1–7 — in Samaria and at Ephesus, people who had
  believed and been baptized receive the Spirit afterwards, when apostles lay
  hands on them. -/
  | actsSpiritAfterBelieving
  /-- Acts 10:44–48 — the Spirit falls on Cornelius's household as they hear the
  word, before they are baptized. -/
  | acts10SpiritAsTheyHear
  /-- Acts 2:38 — "Repent and be baptized … and you will receive the gift of the
  Holy Spirit." -/
  | acts2_38SpiritPromised
  /-- **The conversion reading of 1 Corinthians 12:13**: it is the baptism in the
  Spirit that John promised Christ would give, and every believer receives it
  in becoming a Christian. Dunn; Stott. -/
  | cor12_13IsChristBaptizingInTheSpirit
  /-- **The Pentecostal reading of 1 Corinthians 12:13**: "by one Spirit" — the
  Spirit is the instrument, baptizing believers into the body of Christ at
  conversion; this is not Christ baptizing *in* the Spirit. Assemblies of God,
  2010. -/
  | cor12_13IsBaptismByTheSpirit
  /-- In Luke-Acts, baptism in the Spirit is prophetic empowerment for witness,
  distinct from the Spirit's gift that Paul ties to conversion. Menzies;
  Stronstad. -/
  | lukanSpiritBaptismIsEmpowerment
  /-- Luke's narratives of receiving the Spirit teach a pattern for believers
  today, not only what happened then. Stronstad; the Assemblies of God. -/
  | actsNarrativesAreNormative
  /-- The episodes of Acts 8, 10 and 19 are unrepeatable steps in the gospel's
  spread — Samaria, the gentiles, John's disciples — not a pattern for later
  believers. Stott. -/
  | actsEpisodesAreTransitions
  /-- Entire sanctification is a second work of grace after justification, in
  which believers are "made free from original sin" and brought to "the holy
  obedience of love made perfect" (Nazarene *Manual* 2023, Article X) — Wesley's
  "second change, whereby they shall be saved from all sin and perfected in
  love". -/
  | entireSanctificationIsSecondWork
  /-- The Spirit is given in water baptism: "new birth in the Holy Spirit"
  (Catechism 1262). Luther's Small Catechism, on Titus 3:5, likewise calls
  baptism a washing of new birth in the Holy Spirit. -/
  | spiritGivenInWaterBaptism
  /-- Confirmation gives "the full outpouring of the Holy Spirit as once granted
  to the apostles on the day of Pentecost" (Catechism 1302), as the apostles laid
  hands on the baptized in Samaria (1288). -/
  | confirmationGivesPentecost
  /-- **The conversion view.** Every believer is baptized in the Spirit at
  conversion. -/
  | spiritBaptismAtConversion
  /-- **What the subsequence views conclude.** A baptism in the Spirit distinct from and after
  conversion is to be sought by believers today. -/
  | secondSpiritBaptismToBeSought
  /-- **The sacramental view.** The Spirit is given in the sacraments — in water
  baptism, and fully in confirmation — not in a second baptism beyond the
  sacraments. -/
  | spiritGivenInTheSacraments
deriving DecidableEq, Repr

end Testimony.Arguments.SpiritBaptism
