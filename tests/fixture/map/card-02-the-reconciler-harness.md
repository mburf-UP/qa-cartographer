## Card 2 — The reconciler harness

**Type** Instrument · **Mark** ghost · **Source** `qa/PLAN.md` §2.4; corroborated at `qa/notes/INDEX.md:11` (*"never built; do not plan cases around it"*) · commit `0f1e2d3c`

A test harness the plan excludes and that has no file behind it.

> **Looks like** a component that is simply out of scope this round. **Is actually** a name with nothing wired behind it. **Nothing tells you.**

<!-- ghost-check: path qa/scripts/reconciler.mjs absent -->

**Hits** — nothing. That is the point: no case depends on it.

**Does not hit** — **the nightly reconciler itself**, which exists in the product. Absent harness, present feature.

**If you are unsure** — do not build it to make a case pass. Record the case as blocked.
