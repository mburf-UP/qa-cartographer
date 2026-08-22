# Test method

**Written 2026-08-18, before a single line of the cartographer was drafted.** Nothing in this file was revised after a run. If a run contradicted a criterion below, the criterion stayed and the result was recorded against it.

This ordering is the whole point. A method written after the results is a highlight reel, and no reader can tell the difference from the outside unless the method is dated and committed first. This file was committed before `identity.md`, `rules.md`, `examples.md` or the map existed.

---

## 1. The claim under test

> Given only this folder and read access to the territory, a reader with no prior knowledge can find one thing, understand it, name what else moves if they change it, and stop — without loading the rest.

Each of those four is tested separately. "Stop" is a real criterion, not a flourish: a reader who answers correctly having loaded the whole territory has failed the test, because the map did not do the work.

## 2. Runtime

| | |
|---|---|
| Model | Claude, fresh session, no memory of this build |
| Prior exposure | None. The test reader has never seen the cartographer, the territory, or these criteria |
| Operator | Mike Burford |
| Territory access | A **read-only snapshot** staged outside the source repository |

**The snapshot exists for a hard safety reason, not convenience.** The territory lives inside a commercial repository belonging to a third party who granted access on trust. No test process touches it. Every run reads a snapshot; the source repository's commit hash and clean working tree are verified before and after each session and recorded in `runs\`.

## 3. Inputs

**The test reader receives:** the cartographer folder, the territory snapshot, and one question.

**The test reader never receives:** this file, the answer keys, the map produced during the build, or any statement of what the right answer is. Answer keys are written before each run and held back until it is complete.

**Question classes**, fixed now so they cannot be chosen after seeing what the map happens to do well:

| Class | Form of question |
|---|---|
| **A — Front door** | "You have taken over this work. Where do you start, and why?" |
| **B — One card, then stop** | "What is *X*, and what shape is it in?" Passed only if answered from the catalog plus one card |
| **C — Blast radius** | "If I change *X*, what else moves?" |
| **D — The wrong neighbour** | "What will I assume is affected that is not?" |
| **E — Adversarial** | A question whose surface points at a plausible wrong noun, with the evidence excluding it |

Class E exists because comp #10's judge tested that entry exactly this way and it was the only test that proved anything. A map that only answers friendly questions has not been tested.

## 4. Preservation rule

**Transcripts are pasted verbatim and never edited.** No tidying, no trimming, no correcting a question that turned out to be badly worded, no removing a run that went badly.

Where a transcript must be redacted for the third-party confidentiality constraint, the redaction is marked inline as `[REDACTED: reason]` and **nothing else on the line changes**. A redaction is visible; a silent edit is not, and the difference is the entire value of the record.

## 5. The expectation

**This cartographer will get at least one thing wrong, and the runs are expected to show it.** Specifically anticipated, before running:

- A noun will be classified live when it is leftover, because the folder says it is current and the folder is stale.
- A "does not hit" line will be wrong in at least one direction, because absence is harder to establish than presence.
- The catalog will be too big at first draft. Every entrant's is.

If every run passes cleanly, that is evidence the questions were too easy, not that the build is finished. In that case the runs are discarded and harder questions are written.

## 6. Pass criteria, declared in advance

A run passes only if **all four** hold:

1. The reader reached the answer via the catalog and **at most two** cards.
2. The reader did not need to open the territory beyond what a card cited.
3. The "what else moves" answer is correct and specific, naming things rather than categories.
4. The reader stopped without being told to.

Partial results are recorded as partial. A run where three of four hold is a fail against this criterion set and is written up as one.

## 7. What would falsify the design

Stated now so it cannot be quietly redefined later:

- If a cold reader consistently needs three or more cards for a class B question, the cards are the wrong size.
- If "does not hit" lines are more often wrong than right, that section is doing harm and should be cut rather than defended.
- If the reader ignores the catalog and reads files directly, the catalog is not earning its place.

## 8. Runs

Every run is recorded in `runs\` with: date, question class, the question verbatim, the answer key written beforehand, the transcript, the verdict against §6, and the source repository's commit hash before and after.
