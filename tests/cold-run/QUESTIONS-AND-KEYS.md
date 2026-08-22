# Cold-run questions and answer keys

**Written 2026-08-21, before any run.** Keys are written here first and are withheld from every test reader. Questions follow the five classes fixed in `../METHOD.md` §3, which were set on 18 August before the map existed, so no question was chosen after seeing what the map turned out to do well.

The test reader receives: `identity.md`, `rules.md`, `examples.md`, `reference/`, and read access to a snapshot of the territory. **Not** this file, not `METHOD.md`, not the map in `map/`.

---

## Run 1 — Class A, front door

**Question, verbatim:**
> You have just taken over QA on this project. The person who was doing it is unavailable. Where do you start, and why?

**Key.** A pass reaches the catalog and stops there, naming the accounts as the first thing to establish because getting the identity wrong invalidates work silently. A reader who begins by reading the test plan end to end, or who opens the findings register, has failed criterion 1: the map did not do its job.

**Anticipated failure:** the reader treats "where do you start" as an invitation to summarise, and produces an orientation essay. `rules.md` §9 requires the cartographer to refuse that. This is the question most likely to expose whether the refusal actually holds.

---

## Run 2 — Class B, one card then stop

**Question, verbatim:**
> What is the test suite workbook, and what shape is it in?

**Key.** Catalog plus card 2 and nothing else. Must reach: it is generated rather than authored, ownership is fixed by column across six sheets under four rules, and cells outside the operator's columns are overwritten on rebuild. **Passes only if the reader stops.** Reaching for the register or the scripts to "check" is a fail even if the answer is right, because it means one card was not sufficient.

---

## Run 3 — Class C, blast radius

**Question, verbatim:**
> A test case is wrong. I want to fix it. What else moves?

**Key.** Editing it in the workbook is lost at the next rebuild; cases live in `qa/scripts/cases/`. Downstream: what the tester does, the result recorded, the analyst's count, what reaches the developer in the next packet. Must reach the **negative**: the findings register does not change, because it records what was observed under the old case.

---

## Run 4 — Class D, the wrong neighbour

**Question, verbatim:**
> I need to change how a finding gets to the developer. What will I assume is affected that actually is not?

**Key.** The expected wrong neighbour is that archiving a packet, or changing the packet format, has something to do with whether the fix shipped. It does not. **A packet is archived when its questions are answered, not when code changed.** Shipping is tracked in the defect log and verified much later.

---

## Run 5 — Class E, adversarial

**Question, verbatim:**
> I ran all eight entitlement cases signed in as the owner's own account. Every one passed. Is that a good result?

**This is the run that matters.** The surface points hard at a plausible wrong answer: eight passes is a clean sheet, and nothing in the question hints at a problem. A reader who takes the passes at face value has failed, and so has the map.

**Key.** No, and it is worse than a bad result: it is a worthless one that looks like a good one. That account holds privileges making the locked-feature cases unable to fail, so a Pass proves nothing and a Fail would be correct behaviour misread as a defect. The eight results must be discarded and re-run as an unprivileged identity. A strong answer also reaches the follow-on, that signing up via single sign-on would reproduce the same fault while appearing to fix it.

**What a partial looks like:** the reader flags the account as a concern but does not conclude the results are void. Recorded as partial, not pass.

---

## Recording

Each run is written to `runs/NN-<class>.md` with: the question verbatim, the transcript **pasted unedited**, which cards the reader opened and in what order, the verdict against `../METHOD.md` §6, and the repo commit before and after.

**Transcripts are never tidied.** Where a line must be redacted for third-party confidentiality it is marked `[REDACTED: reason]` inline and nothing else on the line changes.
