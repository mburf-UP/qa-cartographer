## Card 6 — The generator and its case files

**Type** Instrument · **Mark** live · **Source** `qa/scripts/` · commit `fb01f602`

Five scripts. The generator builds the workbook from three case files; a read-only production sweep and an evidence manifest run at set points. **All five are live** — no leftovers, which is unusual enough to state so nobody goes hunting for dead code.

> **Looks like** five scripts you can run. **Is actually** four, and one of them is a module. `harvest.mjs` is imported by the generator and is never run directly; its entire user-facing surface is one flag on the generator. **Nothing tells you** — it sits in the same folder with the same extension.

**A ghost lived here until two days ago and no longer does.** That is not a correction to this card, it is the single best thing in this map, and it has its own section at the end.

The general form is worth carrying regardless: **the documentation here describes the intended end state, and a named file may be a merge away.** Every other script named in the docs is real, which is exactly what makes a missing one hard to spot.

**And two ghosts are still here, in the header of the file a newcomer opens first.** `build-workbook.mjs:38-39` tells you to use `append-defect.mjs` and `restore-validations.mjs` to change the live workbook. Neither exists in `qa/scripts/`, which holds four scripts and a `cases/` folder. Nothing else in the territory references either name. A reader who follows that instruction gets a file-not-found on the one step that was supposed to protect the workbook, at the moment they are trying to avoid corrupting it.

<!-- ghost-check: path qa/scripts/append-defect.mjs absent -->
<!-- ghost-check: path qa/scripts/restore-validations.mjs absent -->

This is why the card carries a mark for the folder and the ghosts are named inside it: `qa/scripts/` is live, and two names it advertises are not.

**Hits** — the workbook, entirely, since the generator produces it; the evidence check, which the analysis step depends on having been run.

**Does not hit** — **the product.** Nothing in this folder changes the platform. The sweep is GET-only by construction. The one script that would touch production at volume is deliberately not run and its case is carried as accepted risk.

**If you are unsure** — a dependency the generator needs is installed **outside the repository**, deliberately, so the project's own manifest stays untouched. Clone the repo, run the generator, and you get a missing-module error with nothing to explain it. That is expected, not a break.
