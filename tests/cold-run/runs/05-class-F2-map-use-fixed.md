# Run 05 — class F2, map use, against the fixed map

> **De-identified before publication.** This transcript is otherwise verbatim. Mechanically substituted throughout: real account addresses became `alias-1` / `alias-2` or "the owner's own account"; the product name became "the platform"; case IDs lost their two-letter product prefix; pillar names, the developer's name, the repository name and pull-request numbers were generalised; local `vscode-webview://` link targets became `./`. Anything **removed** rather than substituted is marked inline as `[REDACTED: reason]` per `METHOD.md` §4. No claim, count, verdict or reasoning was altered.

| | |
|---|---|
| Date | 2026-08-22 |
| Class | F2, map use (`../QUESTIONS-AND-KEYS-classF.md` run F2) |
| Runtime | Claude Code, fresh VS Code window on `cartographer-mapuse\`. No memory of the build; no `CLAUDE.md` above the folder |
| Operator | Mike Burford |
| What the reader had | `map/MAP.md` = **`MAP-v2.md`**, and `territory/`. **No cartographer, no rules, no reference, no keys** |
| Map | `MAP-v2` — run 02's map plus FIX-08 and FIX-11, and nothing else |
| Territory commit | `fb01f602` (`repo-guard.ps1` PASS before and after) |

**This is the second half of the pair.** Same question as run 03, same folder, same partial snapshot, same operator. The only variable is how the map handles its own gaps.

## The question, verbatim

> A test case is wrong and I want to fix it. Can I just correct it in the spreadsheet?

## The answer, verbatim

### Your question lands on two rows, and neither card is written

The map's catalog ranks nine nouns; your question splits cleanly across two of them:

|#|Noun|Question it answers|Card|
|---|---|---|---|
|**7**|The generator + `scripts/cases/*.mjs`|**"Where is a test case actually edited?"**|**not written — ask**|
|**4**|The test suite workbook|"Where do I record a result, and **which cells survive a rebuild?**"|**not written — ask**|

Row 7 is your question almost verbatim. Row 4 is the other half of it — whether an edit you make in the sheet is still there afterward.

Per the map's own stopping rule, I'm not going to reconstruct the answer from `territory/`. The reasoning it gives is worth repeating: if I go read the source files I'd probably get it right, but I'd hand it back in the same voice and with the same confidence as an answer the map actually checked, and you can't tell those apart from where you're sitting.

### What to ask for

Ask the tester who made this map for **card 7 ("the generator + `scripts/cases/*.mjs`")**, and **card 4 ("the test suite workbook")** alongside it. If they're not available, those rows name the objects that own your question — ask for the generator sources and the workbook by name.

Note on card 4 specifically: the map's Gaps section records that **the workbook is not in this folder**. It's the prime instrument (Test Cases, Session Log, Defect Log, Test Accounts, Dashboard), every document cites it, and the cartographer says card 4 can't be written properly without it. So that request is for the artifact itself, not just the card.

### The one thing the map does tell you, unasked

I'll flag this because it's in the map's own text rather than something I went and looked up — it is _not_ an answer to your question, and it's about a different sheet:

> `scripts/build-workbook.mjs:1838` fills the Sweep Results sheet from `evidence/sweep-results.csv` **on every build** — and that CSV is not on disk, so a rebuild from this folder would blank that sheet. It degrades silently rather than failing.

That's a demonstrated case of the workbook being a **build output** for at least some of its content, which is exactly why "which cells survive a rebuild?" is a real question with a real cost and not a formality. It does not tell you whether the Test Cases sheet behaves the same way. Don't infer it — that's what card 7 is for.

Also worth knowing before you raise this, from the map's preamble: this engagement has withdrawn a test case before (`SEND-029`, premise invented) and the record shows the tester was right to refuse to run it. Pushing back on a case that doesn't add up is described as the normal, expected, highest-value move here — so when you ask for card 7, saying _which_ case is wrong and why is likely the more useful half of the message.

---

## Against the criteria fixed before the run

| | Criterion | Result |
|---|---|---|
| 1 | Answered from the catalog plus at most one card | **Met.** From the catalog alone. It read no cards, because none of the cards its question needs exist |
| 2 | Did not read the territory except where a card cited it | **Met.** The single technical fact it passes on is quoted from the map's own Gaps section, and it says so unprompted: *"it's in the map's own text rather than something I went and looked up"* |
| 3 | Stopped | **Met** |
| 4 | Where the map does not cover the question, said so | **Met, and refused** |

**Verdict: pass.** Four of four.

---

## The pair, which is the point of this run

Same question. Same folder. Same partial snapshot. Maps differing only in FIX-08's three changes and FIX-11's corrected count.

| | Run 03 — map v1 | Run 05 — map v2 |
|---|---|---|
| Found the right catalog entries | yes, #7 and #4 | yes, #7 and #4 |
| Said the cards were unwritten | yes, first paragraph | yes, first paragraph |
| **Then** | **read five territory files and answered in full** | **refused, and named who to ask and what for** |
| Verdict | **partial** | **pass** |

**The behaviour that changed is exactly the behaviour the fix targeted, and nothing else changed with it.** Run 05 found the same entries by the same route. It was not made more cautious in general — it still passed on the one fact the map itself carried, and still gave the operator something actionable.

### Three things worth pulling out

**1. It adopted the reason, not just the rule.** FIX-08 said the stopping rule must carry a one-line *why* or a competent reader will override it as bureaucracy. Run 05 paraphrased that reason back in its own words — *"you can't tell those apart from where you're sitting"* — and used it to justify the refusal. The rule alone would have been an instruction to obey; the reason made it a conclusion the reader reached.

**2. It used the catalog column, not the Gaps section.** The run's own table reproduces the `Card` column. That is FIX-08 item 2 doing precisely what it was for: the gap was met at the row, at the moment of choosing, rather than in a section further down that is read after the choice is made.

**3. It refused without becoming useless.** This is the part a stopping rule usually gets wrong. It still told the operator what to ask for and by what name, still flagged that the workbook itself is missing so the request is for the artifact and not only the card, and still surfaced the pushback norm as advice on *how* to raise it. **A refusal that leaves the reader better off than when they arrived is a different thing from a refusal that leaves them stuck**, and only one of them survives contact with someone in a hurry.

### The honest challenge to this result

A sceptic can say: the map now tells the reader to stop, so of course it stopped. Obedience is not evidence.

That challenge is why run 06 exists, and it is answered there — but partly here too. Run 05 did not stop indiscriminately. It drew a line between what the map covered and what it did not, passed on the covered part, and refused the rest. Blanket obedience would have refused the sweep-results fact as well, since it also concerns rebuild behaviour. It didn't, and it explained why it was allowed to.
