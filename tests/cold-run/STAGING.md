# The test rig — where runs actually happen

**Written 2026-08-22, after runs 01–04.** An addition, not a revision: `METHOD.md` states it was never revised after a run, and that claim is worth more than the convenience of editing it. Nothing here changes a criterion. It records where the runs physically happen, which was known to the operator and to nobody else — including a later session of mine, which went looking and could not find it.

---

## The two staging folders

Both live **outside this repository and outside the vault**, deliberately. A cold reader must not be able to reach the cartographer's own files, the answer keys, or any `CLAUDE.md` sitting above the folder.

| Folder | Full path | The reader gets | Used by |
|---|---|---|---|
| **`cartographer-coldrun`** | `C:\Users\mburf\Documents\cartographer-coldrun` | `cartographer\` (identity, rules, reference, examples) **+** `territory\` | Classes A–E. Runs 01, 02 |
| **`cartographer-mapuse`** | `C:\Users\mburf\Documents\cartographer-mapuse` | `map\MAP.md` **+** `territory\` — **no cartographer, no rules, no reference, no keys** | Class F. Runs 03, 04 |

Each folder carries its own `questions.txt` and `RUN-INSTRUCTIONS.md`. **Those are the operator's copies and they are authoritative for what a reader was actually shown.**

**The distinction is the whole point of class F.** `coldrun` tests whether the cartographer can *produce* a map. `mapuse` tests whether a stranger can *use* the finished map and stop. A reader who can see `rules.md` is not testing the map.

## Running one

1. VS Code: **File → New Window**
2. **File → Open Folder** → the staging folder
3. Open Claude Code in that window
4. Paste **one** block from `questions.txt`

One new window per question. No steering, no hints, no re-runs to get a better answer — a re-run is a new numbered run and both get published (`METHOD.md` §4).

## The territory snapshot is deliberately not repaired

The staged `territory\` is a partial copy: `evidence/sweep-results.csv` and the workbook are absent because of the snapshot filter, though both exist in the source. Three readers have now reasoned correctly to the wrong conclusion from it.

**It stays broken for the remaining runs.** Repairing it mid-series would mean runs 05 and 06 faced different conditions from 03 and 04, and comparability is the only thing that makes a series worth more than a single run. The defect is recorded in `runs/03-class-F2-map-use.md` and its general form is in `findings-for-qa.md`; the rig is not a claim about the territory, so leaving it wrong costs nothing and changing it would cost the pair.

## Before and after every run

`repo-guard.ps1 -Capture` at the start of the session, `-Verify` at the end. The source repository's commit and clean tree are recorded on every run record. No test process touches it: every run reads the staged snapshot.

## Before publishing any transcript

`check-safe.ps1`. A cold reader has every reason to paste in the real account, the real route, the real function name — they make the answer concrete, and the reader has no idea the transcript is about to be published. Runs 01–04 all did it. Assume the next one will too.
