# Class F — map use. Questions and answer keys

**Written 2026-08-22, before any class F run.** Keys withheld from every reader.

## Why this class exists, and why it is an addition rather than a revision

Runs 01 and 02 exposed a conflation in `../METHOD.md` §6. Two different things were being tested with one criterion set:

| | Under test | Success looks like |
|---|---|---|
| **Map production** | The cartographer walks a territory and leaves a map | Reads widely, marks honestly, records its own gaps |
| **Map use** | A cold reader answers a question from the finished map, and stops | Catalog, one card, stop |

§6 was written for map use. Run 02 was map production and would have been marked down for doing its job properly.

**§6 is not being changed, and the five sealed classes are not being touched.** Adding a test is not the same as weakening one, and the difference is the whole reason the earlier runs are worth anything. This class is dated, its reason is stated, and it makes no retrospective claim to have been planned.

## What the reader gets

`map/MAP.md` and the territory. **Not** the cartographer: no `identity.md`, no `rules.md`, no `reference/`, no keys.

`MAP.md` is the map produced cold in run 02, reproduced byte-for-byte. It is not my map and it has not been improved. **Its cards 5 to 9 are named in the catalog and deliberately unwritten**, which class F exists partly to exercise.

## Criteria, fixed here before running

1. Answered from the catalog plus **at most one** card.
2. Did not read the territory to answer, except where the card cited it.
3. Stopped.
4. **Where the map does not cover the question, said so** rather than filling the gap from the territory or from general knowledge.

Criterion 4 is the one that matters. A map that quietly answers beyond its own coverage is worse than one that admits a gap, because nothing tells the reader which they received.

---

## Run F1

**Question, verbatim:**
> I am about to run the entitlement cases. What do I need to know first?

**Key.** Catalog then card 1. Must reach: the owner's account is a platform-wide administrative rights in a comped org, so those cases cannot fail for it and a Pass is worthless; and signing up via single sign-on reproduces the fault while looking like a fresh account. A strong answer also picks up catalog entry 2, the PRO ghost, as the reason one of the nine cases has never been runnable.

**Anticipated failure:** the reader goes to the territory's own `TEST-PLAN.md` and answers from there. The answer would be right and the map would have contributed nothing, which is a failure of the map.

---

## Run F2 — the one that matters

**Question, verbatim:**
> A test case is wrong and I want to fix it. Can I just correct it in the spreadsheet?

**The trap:** the correct answer sits in cards 4 and 7 of that catalog, and **neither card is written.** The map names them and stops.

**Key.** The map must say it does not cover this, name the catalog entries that would, and send the reader to ask. **Anything else is a failure**, including a correct answer assembled from the territory, because the reader cannot tell a covered answer from an improvised one and will trust both equally.

**A pass may reasonably add** what the catalog line itself states, that card 7 answers "where is a test case actually edited" — that is the map pointing, which is its job. It may not answer the question from `build-workbook.mjs`.

**What a partial looks like:** the reader flags that the cards are unwritten and then answers anyway from the territory. Recorded as partial, with the gap between flagging and refusing noted, because that gap is the finding.

---

## Correction, appended 2026-08-22 after run 04

**Line 22 of this file is wrong and is left standing.**

It says *"Its cards 5 to 9 are named in the catalog and deliberately unwritten."* In fact **only card 1 of nine is written**; cards 2, 3 and 4 are absent too. The claim was copied from `MAP.md:76`, which says the same thing about itself, and was never checked against the file.

**Corrected here rather than in place**, for the reason `CMP-013` gives: a test document rewritten after its runs cannot be checked by anyone, and this file's whole value is that it was fixed before the runs. The error is recorded as `FIX-11` in `../fix-log.md`.

**Neither run's verdict is affected.** F2's key names cards 4 and 7 as unwritten; both are. F1's key names catalog entry 2; it is. Every specific claim resting on the wrong count was correct — which is exactly how a wrong count survives three readings.

**A second correction, 2026-08-22.** Line 22 says `MAP.md` is "reproduced byte-for-byte". That was true when written and stopped being true when the whole entry was de-identified for publication. The substitutions touch names and never claims, and each transcript declares its own in a header. Recorded here rather than edited in place, for the same reason as above.
