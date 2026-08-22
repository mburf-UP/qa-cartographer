## Card 7 — The evidence trail

**Type** Record · **Mark** live · **Source** `qa/evidence/screenshots/README.md`; the committed-versus-ignored rule in `qa/.gitignore`; the check at `qa/scripts/evidence-manifest.mjs` · commit `fb01f602`

Where a screenshot goes so that the person who has to act on it can actually open it. A file name in the workbook's Evidence column is a promise that an image exists at a known path; this object is what makes the promise true.

Shaped this way because the developer reviews findings from the repository rather than from an inbox. An image that reaches them by email is not evidence — it cannot be found again from the result that cites it. So evidence is committed, and the naming rule is `<TestID>-<short-description>.png` with no date, because the workbook already records the date and two sources for one fact is one source too many.

> **Looks like** `evidence/` and `evidence/screenshots/` are the same place, one just tidier. **Is actually** two different fates: files in the subfolder are committed, and loose images one directory up are ignored by pattern. **Nothing tells you** — the save succeeds, the file sits on disk, the workbook cites it, and it never reaches the developer. No error at any point.

That ignore rule is deliberate and its own file says so, including a warning not to "tidy" the patterns into a recursive form — doing so would silently stop every screenshot being committed, and the workbook would go on naming files that are not there. **This is the highest-cost trap in the map that produces no symptom at all.** A wrong account (card 1) at least destroys results you can later identify; a screenshot that silently vanishes leaves a finding that looks complete and cannot be acted on.

**Network captures are excluded on purpose and must not be re-enabled.** They record response bodies from an authenticated session, so a committed capture is a committed credential, and the file says it was ignored before the first one was ever taken.

**Hits** — the analysis step, which is required to open cited evidence before concluding anything, and which has a script for exactly that check; the finding that cites the file, which becomes unactionable if the image is not where it says.

**Does not hit** — **the test result.** The instinct on finding a screenshot missing is that the result is now unsafe and should be re-run. It is not: the result records what the tester observed and stands on its own. What is damaged is the *finding's* portability — someone else's ability to confirm it without repeating the work. Re-run the case only if you doubt the observation, not because the image went astray.

**If you are unsure** — save into `evidence/screenshots/`, never one level up, and check the file is actually there before recording the name. The evidence-manifest check exists because this failed once in a way nobody noticed until a finding had been analysed against an image that was never opened.
