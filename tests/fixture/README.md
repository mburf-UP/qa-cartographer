# Fixture — a synthetic territory, so a stranger can run the checker

**Everything in here is invented.** No real system, no real file, no real finding. It exists for one
reason: `check-map.ps1` checks a map against the body of work it describes, and the body of work
this map describes is a third party's private commercial system that is not in this repository and
never will be.

**So without this fixture, the repository would claim a guarantee nobody could verify from a fresh
clone.** That is the exact failure the judges named in comp #8 — the pitch outrunning the repo — and
it would be a fair hit.

## Run it

```text
powershell -ExecutionPolicy Bypass -File ..\..\check-map.ps1 -Map .\map -Territory .	erritory
```

Expect a pass: 2 cards, citations resolving, one ghost proved absent by `path ... absent`.

Then break it on purpose and watch it fail — that is what `../check-map-negative-test.py` does,
nine times, one defect at a time.

## What it deliberately contains

- A card whose cited section heading is real (`PLAN.md` §4.3) — so a wrong section can be detected.
- A card citing a **line number** with a **quote on that line** — so a misquote can be detected.
- A **ghost** with a machine-checkable absence (`qa/scripts/reconciler.mjs`, which is not there).

Three shapes, because those are the three the checker settles. It is not a demonstration of a good
map — the real one is in `examples.md` and `map/`. It is a demonstration of a working check.
