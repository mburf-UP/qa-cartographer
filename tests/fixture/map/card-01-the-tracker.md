## Card 1 — The tracker

**Type** Instrument · **Mark** live · **Source** `qa/PLAN.md` §4.3; generation defined in `qa/scripts/` · commit `0f1e2d3c`

Where results are recorded. Generated from the case files rather than authored.

> **Looks like** a document you edit. **Is actually** a build output for most of its columns. **Nothing tells you.**

**Hits** — the findings register, which counts from these rows; any rebuild.

**Does not hit** — **the case definitions.** They live in `qa/scripts/cases/*.mjs`; the tracker renders them.

**If you are unsure** — never edit in place; rebuild.
