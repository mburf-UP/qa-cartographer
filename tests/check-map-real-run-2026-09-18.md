# check-map.ps1 against the real territory — 2026-09-18

> **De-identified before publication.** Mechanically substituted throughout: the territory's path and repository name became `<territory>`; the third party's current branch name became `<branch>`. Anything **removed** rather than substituted is marked `[REDACTED: reason]` per `METHOD.md` §4. No claim, count, verdict or number was altered.

**Why this run exists.** Every previous proof of this checker was against `tests/fixture/`, which is invented. A fixture proves the checker runs; it says nothing about whether the real cards are true. Those are different claims. This is the second one, run once, with the result published whichever way it went.

**What was being tested.** On 2026-09-18 the quote check was found to bind a quoted phrase to *the set of lines a card cites* rather than to the citation the quote hangs off, and to skip a quote entirely when a card cites no line at all. Both were fixed and proved on the fixture (10/10 injected defects, three controls). This run asks what the stricter check says about the map that actually shipped.

**Two predictions, written before the run** (`Competitions\REGISTER.md` CMP-028), so it could falsify them:

1. Card 8 is the only card ever exposed to the defect — three line citations, one quote. Under the new rule its quote binds to the third citation specifically. **It will pass or it will fail, and which is unknown.**
2. Cards 1 and 5 carry three quotes between them with no line citation at all, so **three UNCHECKED lines will print that never printed before.**

---

## Procedure

The territory is a third party's commercial system, accessed on trust, syncing to their production build. `Cartographer\BRIEF.md` makes it strictly read-only. `check-map.ps1` opens files, lists directories and reads the commit; it writes nothing, moves nothing and executes nothing inside the territory.

```
pwsh -File Cartographer/repo-guard.ps1 -Capture
pwsh -NoProfile -File Cartographer/qa-cartographer/check-map.ps1 -Map Cartographer/qa-cartographer -Territory <territory>
pwsh -File Cartographer/repo-guard.ps1 -Verify
```

**Guard before:** `CAPTURED  a6225b95 on <branch>, 0 dirty entries`
**Guard after:** `PASS  <territory> unchanged: a6225b95 on <branch>, 0 dirty entries` — exit 0.

Nothing in the territory moved.

## Result

```
  territory  <territory> at a6225b95
  map        Cartographer/qa-cartographer
  checked    8 cards, 20 citations, 4 section refs, 1 quotes bound to a cited line, 1 ghost(s) carrying 3 assertion(s)
  UNCHECKED  3 quote(s) had no line citation to check them against:
             examples.md:36
             Card 1 — The test accounts: [quote text omitted here; it is in the card] with no line
             citation anywhere in the card, so nothing checks the wording
             map/card-05-handoff-packet.md:1
             Card 5 — The handoff packet: [two quotes, same message]
             This is not a failed claim. It is a claim nothing looked at.

WARN  examples.md:78
      Card 8 — The comped PRO persona: ghost declared unverifiable - settling this one would
      require naming internals of a third party's production system, which this repository does
      not publish; the absence is attested by three independent documents cited above

FAIL  map
      pinned to fb01f602 but the territory is at a6225b95; the map describes a commit that is not
      checked out

FAIL  1 claim(s) in this map are not true of the territory.
```

Exit 1.

## What it settles

**Prediction 1 resolved to pass.** Card 8's quote binds to its third citation — the response document at line 110, the nearest citation preceding the quote — and the words are on that line. The one card in the map that was ever exposed to this defect was not carrying it. That is a result and not a relief: it was 50/50 in writing before the run, and had it failed, this file would say so.

**Prediction 2 confirmed, exactly.** Three quotes, in cards 1 and 5, with nothing to check them against. Before today's fix the run printed nothing at all about them and reported PASS. **Three of the map's four quotes were never checked, and the map's own guarantee never said so.** That is the finding with the longest reach here, and it was invisible from inside the folder for four weeks.

**Everything else held, against a territory four weeks further on than the map describes.** 20 citations, 4 section references, the one bound quote and 3 ghost assertions all resolved against a tree that has moved since the map was made.

## The FAIL, and what it is not

The run exits 1 on the commit pin: the map is pinned to the commit it was made from and the territory has moved on, which it is supposed to do — the third party commits their own work. **No card claim failed.** The pin check is doing exactly its job, which is to refuse to let a map quietly describe a commit nobody has checked out.

It does mean this: **a map of a live system decays, and the checker can tell you the date it stopped being true but not which sentence went stale first.** Nothing here fixes that and nothing pretends to.

## What this run does not prove

- It is one run, on one day, against one commit.
- The three UNCHECKED quotes are **still unchecked**. They are now visible, which is a different and lesser thing than being verified. Whether an unbindable quote should fail the run outright is open — `Competitions\REGISTER.md` CMP-029 — and the argument that it should is this script's own, already written for ghosts: *"the cheapest way to pass is to assert nothing."*
- The map was not changed in response to any of this. Nothing was corrected to make this run look better.
