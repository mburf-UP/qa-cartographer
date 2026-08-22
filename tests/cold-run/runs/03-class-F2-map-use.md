# Run 03 — class F2, map use

> **De-identified before publication.** This transcript is otherwise verbatim. Mechanically substituted throughout: real account addresses became `alias-1` / `alias-2` or "the owner's own account"; the product name became "the platform"; case IDs lost their two-letter product prefix; pillar names, the developer's name, the repository name and pull-request numbers were generalised; local `vscode-webview://` link targets became `./`. Anything **removed** rather than substituted is marked inline as `[REDACTED: reason]` per `METHOD.md` §4. No claim, count, verdict or reasoning was altered.

| | |
|---|---|
| Date | 2026-08-22 |
| Class | F2, map use (`../QUESTIONS-AND-KEYS-classF.md` run F2) |
| Runtime | Claude Code, fresh VS Code window on `cartographer-mapuse\`. No memory of the build; no `CLAUDE.md` above the folder |
| Operator | Mike Burford |
| What the reader had | `map/MAP.md` (run 02's map, byte-for-byte) and `territory/`. **No cartographer, no rules, no reference, no keys** |
| Territory commit | `fb01f602` (`repo-guard.ps1` PASS before and after) |

**This is the run the class was built for.** Its criteria were written down on 2026-08-22 before it was run, including what a pass, a partial and a failure each look like. The result matched the predicted partial exactly.

## The question, verbatim

> A test case is wrong and I want to fix it. Can I just correct it in the spreadsheet?

## The answer, verbatim, with one declared substitution

**One mechanical change, stated so it can be checked:** the reader's file links were absolute `vscode-webview://` URLs carrying a session GUID, each over 100 characters. Every one has been replaced by `./` and nothing else was touched. Word for word, the text is as it came back, including the parts that are wrong.


## No. The spreadsheet is a render, not a source.

The map's catalog names this exact question twice — entry **#7 "The generator + `scripts/cases/*.mjs` — _Where is a test case actually edited?_"** and entry **#4 "The test suite workbook — _which cells survive a rebuild?_"**. Neither card was written (the map's Gaps section says cards 5–9 are named but unwritten, and card 4 lacks the workbook itself), so I read the files. They confirm the map's framing.

### Where the edit goes

Test-case content lives in [scripts/cases/b-pillars.mjs](./territory/scripts/cases/b-pillars.mjs) (or `a-public-and-auth.mjs` / `c-crosscutting.mjs`), as a `C(...)` call — the shape is documented in [_helper.mjs](./territory/scripts/cases/_helper.mjs#L8-L26). [build-workbook.mjs:6-7](./territory/scripts/build-workbook.mjs#L6-L7) states it plainly: _"Test-case CONTENT lives in qa/scripts/cases/*.mjs; this file is only presentation, validation and formulas."_

### Why the spreadsheet edit would evaporate

The Test Cases sheet is 23 columns ([build-workbook.mjs:393-398](./territory/scripts/build-workbook.mjs#L393-L398)). The split that matters:

|Columns|Content|Owner|
|---|---|---|
|A–K|Test ID, Phase, Area, Persona, Pre-conditions, **Test Steps**, Test Data, **Expected Result**|**generator** — rewritten every build|
|L–S|Actual Result, Status, Severity, Defect ID, Evidence, Tester, Date, Notes|operator — harvested forward|
|T–W|Gated, Creates Artefact, Automatable, Reference|generator|

[harvest.mjs:24](./territory/scripts/harvest.mjs#L24) harvests only `cols: [12..19]` from Test Cases. Your corrected steps sit in column I or K — **not harvested, silently overwritten at the next rebuild.** No error, no warning; the case just reverts.

That file also documents this precise failure mode happening twice already, and both comments end with the same lesson: [Defect Log columns 1–20](./territory/scripts/harvest.mjs#L25-L37) were harvested until it started writing _old_ analysis back over corrections (OBS-012's "wrong layer" fix never reached the sheet the developer signs off), and [Sweep Results](./territory/scripts/harvest.mjs#L58-L74) froze a day-1 paste showing 71 PASS / 2 FAIL while the live sweep read 77 PASS / 0 FAIL. _"When the generator owns a sheet, harvesting it means the old copy wins."_

### The precedent is strong — and in your favour

`SEND-029` is the map's own example of a wrong case getting fixed properly. The tester **refused to run it** and was right; OBS-069 records the three defects in the case; it was rewritten in the generator on 2026-08-17, and the [rewrite is annotated in place](./territory/scripts/cases/b-pillars.mjs#L246-L258) with why the original was wrong. That comment block is the house style — the correction is kept, not tidied away. The map's opening is explicit: _"Pushing back on an instruction that does not add up is the normal, expected, highest-value thing you can do here."_

### Two hazards before you rebuild

1. **The rebuild is the dangerous step, not the edit.** A plain regeneration overwrites recorded results. The only safe path is `--import` ([build-workbook.mjs:44-57](./territory/scripts/build-workbook.mjs#L44-L57)): harvest → generate fresh → inject, one pure write. Never re-open the output to modify it — in-place editing corrupted the workbook on 2026-08-04 (Excel discarded a sheet's dropdowns and column widths).
2. **Do not rebuild from this folder as it stands.** The map's Gaps flag it and I confirmed both: `evidence/sweep-results.csv` is absent, and [build-workbook.mjs:1838](./territory/scripts/build-workbook.mjs#L1838) fills Sweep Results from it _on every build_, degrading silently to "No sweep has been run yet" — you'd blank that sheet. The workbook itself isn't here either. Also, the in-place helpers the header recommends (`append-defect.mjs`, `restore-validations.mjs`) are **not in `scripts/`** — only `build-workbook`, `harvest`, `dark-feature-sweep`, `evidence-manifest`.

### One thing the generator won't do for you

A rewritten case doesn't reach the tester's copy until the next rebuild. [PRE-SESSION-2026-08-17.md:163](./territory/handoffs/PRE-SESSION-2026-08-17.md#L163) records the workaround used last time: _"The three rewritten cases are in the generator, not in your current workbook… read them from this document or ask me."_ So if someone is executing right now, the fix needs to travel by handoff as well as by code.

**Suggested sequence:** log the defect in the case as an observation in [OBSERVATIONS-REGISTER.md](./territory/OBSERVATIONS-REGISTER.md) (that's where corrections live, and it's what OBS-069 did) → edit the `C(...)` call with a `// REWRITTEN <date> (OBS-nnn)` comment saying what was wrong → rebuild with `--import` to a scratch `--out`, compare, then swap.

Tell me which case is wrong and what's wrong with it, and I'll draft the register entry and the generator edit.
---

## Against the criteria fixed before the run

The four criteria are in `../QUESTIONS-AND-KEYS-classF.md`, written 2026-08-22, before this ran.

| | Criterion | Result |
|---|---|---|
| 1 | Answered from the catalog plus at most one card | **Met.** It went to the catalog first and named the two entries that own this question, #7 and #4, correctly and without prompting |
| 2 | Did not read the territory except where a card cited it | **Failed.** It read `build-workbook.mjs`, `harvest.mjs`, `_helper.mjs`, `b-pillars.mjs` and a handoff packet. No card cited any of them, because no card exists |
| 3 | Stopped | **Failed.** It produced a suggested sequence and offered to draft the register entry and the generator edit |
| 4 | Where the map does not cover the question, said so | **Half met, and the half is the finding.** It said so, clearly and in the first paragraph, then answered anyway |

**Verdict: partial.** The key predicted this partial in writing, in these words: *"the reader flags that the cards are unwritten and then answers anyway from the territory. Recorded as partial, with the gap between flagging and refusing noted, because that gap is the finding."*

## The finding

**The map's Gaps section is informative. It is not operative.**

It told the reader what was missing. It did not tell the reader what to do about it. So the reader read the gap as an obstacle to route around rather than a boundary to stop at, and routed around it competently: *"Neither card was written... so I read the files."*

The refusal rule exists. It is `rules.md` §11, and it is binding on the cartographer. **It never travels into the map.** The map inherits the cartographer's honesty about its own gaps and none of its discipline at them, and the person reading a map has by definition never seen the rules that made it.

This is the map failing at exactly the point it was most confident about itself. Declaring a gap felt like the whole job. Declaring a gap is half the job, and the half that is easy.

**Why it matters more than a wrong answer would have.** Everything the run said is correct. It is well sourced, it cites line numbers, and a tester could act on it. That is what makes it dangerous: the reader now holds an answer assembled from the territory and cannot tell it apart from one the map covered. Both arrive in the same voice, with the same confidence, in the same reply. A map whose covered and uncovered answers are indistinguishable is not a map, it is a search tool with a table of contents.

## What the run got right, and it is not a small list

It reached the correct answer, and the correct reasoning for it: the sheet is a render, cases live in `scripts/cases/*.mjs`, columns A to K are generator-owned and `harvest.mjs` carries forward only 12 to 19, so a corrected step in column I evaporates at the next rebuild with no error.

It found the `--import` rule and the in-place-editing hazard without being pointed at them.

It found `SEND-029` on its own and read it correctly, including the part that matters most and is least obvious: that the tester who refused to run a wrong case was right to, and that the correction was annotated in place rather than tidied away.

**And it independently reproduced a real defect in the live QA environment.** Hazard 2 in its answer is the silent degrade of the Sweep Results sheet, which is finding 4 in `../../../../findings-for-qa.md`. This reader had never seen that file. Two independent readers, from different folders, on different questions, arriving at the same defect is the strongest evidence in the set that it is real.

**It also found one nobody had.** `build-workbook.mjs:38-39` tells the reader to use `append-defect.mjs` and `restore-validations.mjs` to change the live workbook. Neither exists in `scripts/`. Verified read-only against `fb01f602`: the folder holds `build-workbook`, `harvest`, `dark-feature-sweep` and `evidence-manifest`, and nothing else references either name. That is a ghost by the map's own definition, sitting in the header comment of the file a newcomer opens first. Now finding 7 in `findings-for-qa.md`.

## The false positive that will not die

The run reports `evidence/sweep-results.csv` absent and the workbook missing. **Third occurrence, third staged folder, same cause: my snapshot filter.** Both files exist. Recorded here rather than in `findings-for-qa.md`, where the general form of it already is.

Three readers reasoning correctly to the same wrong conclusion is not three mistakes. It is one defect in the rig, reproducing on schedule, and it is worth more as a demonstration than it cost: **a partial copy cannot support a finding about absence, and nothing in the copy says it is partial.** That is the same failure this map exists to name, committed by the person building the map, against the map's own readers.

## The fix, and why it is not applied yet

`FIX-08` in `../../fix-log.md`. Held until F1 has run on this unchanged map, for the same reason `FIX-07` is held: changing the artifact mid-series makes the runs incomparable, and comparability is the only thing that makes a series worth more than a single run.

**Then re-run this exact question against the fixed map, as run 05, and ship both.** The pair is worth more than either half. One shows a map that declares its gap and walks through it; the other shows the same question stopping at the same gap. Nothing else in this entry would demonstrate as directly that the fix does what it claims.
