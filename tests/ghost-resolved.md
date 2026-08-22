# Receipt: a ghost that resolved mid-build

Evidence about the map, not part of the map. Lives in `tests/` for the reason `rules.md` §11 gives: the product and the evidence about the product are different things and the cartographer never reads its own test material.

## A ghost that resolved, and why this map states its commit

This is the most useful thing in the map, and it was an accident.

**On 19 August, at commit `3d5edab6`, this map carried a ghost.** Two documents in the territory named a checking script as the control that stops a known defect class returning:

> "Fixed in the fix pull request across eight sites, with a CI gate (`_scripts/check-sql-correlation.mjs`) so the class cannot return"
> — `qa/handoffs/M3-RESPONSE.md`, and again in `qa/OBSERVATIONS-REGISTER.md`

The file did not exist. Not in `_scripts/`, not anywhere. The four sibling scripts named alongside it in the same documents all did exist, which is what made it dangerous rather than merely absent: there was no pattern of aspirational naming to put a reader on guard. A newcomer reading either document would have stopped worrying about a class that nothing was guarding.

**On 21 August, at commit `fb01f602`, it exists.** the fix pull request landed. It is now cited in three places rather than two.

### What this demonstrates, and it is not luck

**A map that did not state its commit would right now be lying to its reader** — sending them to worry about a gap that has been closed, with nothing on the page to reveal that the map had aged.

Both halves are checkable, which is the point:

| | Commit | Verified |
|---|---|---|
| Absent | `3d5edab6` | 2026-08-19 |
| Present | `fb01f602` | 2026-08-21 |

Anyone can run `git show 3d5edab6:_scripts/check-sql-correlation.mjs` and get nothing, then run it against `fb01f602` and get a file.

### The three rules this pays for

**`rules.md` §8, cite never copy.** Had the card reproduced the documents' claim about the gate, the map would now hold a second, wrong copy of a fact, with no way for a reader to tell which was authoritative. Because the card points at the source, the source corrected itself and the card is simply out of date, which is a smaller and more visible failure.

**`rules.md` §4, live needs the most evidence.** The ghost was found by checking whether the named file existed, not by reading the sentence that named it. The sentence was confident, specific, and wrong. **A document asserting a control exists is not evidence that it does.**

**`walk-order.md`, pin the commit.** A territory under active work moves while you map it. This one moved twenty-plus commits in three days, including seven that touched the mapped folder directly. The pin is the difference between a map that is out of date and a map that is wrong, and only one of those is recoverable.

### What was not done

The ghost was **not** quietly deleted from the map when it resolved. Removing it would have hidden the only real demonstration this map has that its own rules do any work. It is recorded, with both commits, and the card that used to carry it now points here.
