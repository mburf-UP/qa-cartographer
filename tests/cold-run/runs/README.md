# What each run actually walked

**Added 2026-09-18, after the competition was judged.** Nothing in this folder has been edited — the transcripts are as they were at the judged commit `c1d8b1c`. This file exists because the six run records answer a question they were never asked side by side, and the answer matters to anyone reading them as evidence.

## The short version

**None of these six runs walks the map this repository ships.**

The repo's map is the catalog in `examples.md` naming eight objects, with all eight cards written — three in `examples.md`, five in `map/`. Every run below was given something else.

| Run | Class | What the reader was given | Is that the shipped map? |
|---|---|---|---|
| 01 | E, adversarial | `cartographer/` + `territory/` — a map-**production** test | No map involved |
| 02 | A, front door | `cartographer/` + `territory/` — a map-**production** test | No map involved. It *produced* `../produced-map-run02.md` |
| 03 | F2, map use | run 02's produced map, byte-for-byte | **No** |
| 04 | F1, map use | run 02's produced map, byte-for-byte | **No** |
| 05 | F2, map use | `../MAP-v2.md` (run 02's map plus FIX-08 and FIX-11) | **No** |
| 06 | F1, map use | `../MAP-v2.md` (run 02's map plus FIX-08 and FIX-11) | **No** |

`MAP-v2.md` is a nine-row catalog with **one** card written; the other eight read *"not written — ask"*. The shipped map is eight rows with **all eight** cards written. They are different documents, not two versions of one.

## What this does and does not undermine

**It does not undermine the runs.** Every record already stated what it was given — *"run 02's map, byte-for-byte"*, *"`map/MAP.md` = `MAP-v2.md`"* — on its own second line, before anyone asked. The transcripts are verbatim, the answer keys were committed before the runs, and run 06 was built specifically as a regression control against over-refusal. That work stands.

**What it undermines is one specific claim:** that these are receipts for the map in this repository. They are receipts for the map the cartographer *produced* during testing, and for the stopping rule that testing forced into it. Those are real findings and they are why the shipped map has the stopping rule at all. They are not a record of a stranger walking the eight-card map, and nothing here should be read as one.

## Why it happened, since that is the more useful part

**There is no single canonical map file in this repository.** The catalog lives in `examples.md` and the cards are split between `examples.md` and `map/`. The test rig needed one thing to hand a cold reader, so it used the consolidated map the cartographer had produced — and that copy then stopped tracking the product while the product was being finished.

Two copies of the same thing with nothing marking which one is real. The rule against that is in this repo's own lineage, and it was applied to the cards (*"No card appears twice"*) and not to the artifact under test.
